Return-Path: <bpf+bounces-64317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58558B114F2
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 01:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54A8B7BAF61
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 23:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97FF23C8A4;
	Thu, 24 Jul 2025 23:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfhAEkPV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75D3246BD3
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 23:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753401161; cv=none; b=BAk3owMFsxtcpiUZA74ZtzbpSDaVOqtHs0JhblpEBIs140Fx8r0YWS/Na2IL7pw+Aok1W/qCPnThaHLL8X2+MBkOkB38SwlGndkQGkyd+QdEpRvI7Q2gpdWy4FgllK9bQ42+//xXd33EsrNeg5mVH5ToBawlZx+tmm6R33bPOrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753401161; c=relaxed/simple;
	bh=UnU7DxXIk4gTMqqrRlGBqwI+6Tk/QAgpuWLsKT8kr1Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sgZtZP/N3usUYojjubPAkVm/0+0gMQcXrIzhe1LEoVyclRW2fQPTvdTqdNAU19GOuV/jNdOjSPJm0OBdYCVgrcyuYDN3Z7ovmKlHUx6wK/sqiik7NBGrzloK2lm9zlmyrHWGJqNxGimS0qNwp8n+wxNwJn5Y2vqDyP2WGA2Ak2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfhAEkPV; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-75bd436d970so1034299b3a.3
        for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 16:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753401159; x=1754005959; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hbS6OxklSPdJ3tu1Eq+SZP8qTBgQRzs+8N1W8N0Lbrc=;
        b=hfhAEkPVNoRSgzNbSisYFdHcWRkwYJZHFS1aIrsqC5KqQqdEJ6k17mNFVmGK9kKR1I
         tBXblnFpGDhvORBCNLu+QXLRqYwWNBBNh1aRNUQOLqWcYHnUz1UIf0d54zvAKiDT7+7A
         Qzi3m0fDAAmXUgkB0oUYfQpSlb7Rz+hem+IWc2CaLnvuzICqzMF5sY2Q/R/y9ZJj0zCZ
         Llyq/XDG5jaGtJBkwA7NpKwSRm6T0xdw1gnA2m38twV9/KV2/K1Vvaxyz9rIU8+K9Dka
         35gvUuGQApeh9wpIpU2NUHyB+PmIwST/PS6QyCaUSvXG0pRLM7iC9p3Py+fuCjbDaPT4
         t/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753401159; x=1754005959;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hbS6OxklSPdJ3tu1Eq+SZP8qTBgQRzs+8N1W8N0Lbrc=;
        b=dUyo59n7FpFKZLEllk6j/8aVCM78l6GLcEIbfbkLj3XoUvqhhGkPOJ8It2RqEFZ3w8
         rrmp610PvG8IUYCbpTybAuJnYObWLhEuyMpP+GKC2710XnRFWVducxdc36dAh3OTjj5H
         hUR1g7Nf9E6FaHXh5Zxg8YZYXR9K2JkCCoPh+dEbg30IAEEIdJ4ae+G/6EK/gbCS39QF
         T9VkFcU1PQbYY0hk9RRW6/+8MgeVX4y3kVhesF58aHhhlWKie+H4CqdZih3IjE3suib1
         S8BTdICot/M9bRK2g7+TuR0MvsL3qsWbeRlas6dHc9e7k9Uv1mkru9UaGdYY8MN/5+Hw
         0agA==
X-Gm-Message-State: AOJu0YzaFY+JEh2kCFEIncYDzAXkSl79GkyN7o3NHlkrCQxQQRZsroZp
	5a0MaijBsJ6oxuu3KN0UuqsBA7G5FFGiySXy9HbOyxTmQoZlLqkhbOTd
X-Gm-Gg: ASbGncs1iErwVK0C9dcQEY2D/P4fRRAJa4JFUicv8BKwpDUD0cMkMaMpBCscmeFeYqQ
	XqQKGhntG7CvR321/gRBSnc5W89QooJyf6jvFK/dHwx6q+nXN9UJ0VcM3la+m1ya8mjwBtp8JIs
	NfS/hl+7lRyTOEOhBzbcLFvikvtpeLi55QaAYSHXKyuL8CFR4Z43JgHjhkBmhTmbr4bi3eaW+1i
	Abts4YCCHZ2q3nBLh00ugyhkrw9jCbdwCybPiSpYiesu98uKBoB5CDLMnOTl13kC84u7svjD/J6
	r7SRyUDKr8V4HOEaAeuvxTQifYuQIJz8BDH42gTJIlYjFF+1mxTiZ1gs2PIiFbzdiUdTBmooszI
	cb5JLEzFMjGyK2TZ99w==
X-Google-Smtp-Source: AGHT+IEov2hDzUp3ZQMJEO1ynhhQGr87shYUUaNf8wXp+SSmlFV2twFOve1QwQBLFIbXIVyUbNZjmg==
X-Received: by 2002:a05:6a20:12d4:b0:234:216b:cf98 with SMTP id adf61e73a8af0-23d4913bb82mr14548155637.35.1753401159039;
        Thu, 24 Jul 2025 16:52:39 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761b05e17a4sm2522248b3a.93.2025.07.24.16.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 16:52:38 -0700 (PDT)
Message-ID: <6d75ad3a05ebf56ab2f68e677264e8142c372fbc.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Test cross-sign 64bits
 range refinement
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>, Shung-Hsi Yu
 <shung-hsi.yu@suse.com>
Date: Thu, 24 Jul 2025 16:52:35 -0700
In-Reply-To: <aIKtSK9LjQXB8FLY@mail.gmail.com>
References: <cover.1753364265.git.paul.chaignon@gmail.com>
	 <8f1297bcbfaeebff55215d57f488570152ebb05f.1753364265.git.paul.chaignon@gmail.com>
	 <905853bfc266a6969953b4de8433ef9ca7e7a34c.camel@gmail.com>
	 <aIKtSK9LjQXB8FLY@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-07-25 at 00:01 +0200, Paul Chaignon wrote:
> On Thu, Jul 24, 2025 at 12:15:53PM -0700, Eduard Zingerman wrote:
> > On Thu, 2025-07-24 at 15:43 +0200, Paul Chaignon wrote:
>=20
> [...]
>=20
> > > +SEC("socket")
> > > +__description("bounds deduction cross sign boundary, negative overla=
p")
> > > +__success __log_level(2) __flag(BPF_F_TEST_REG_INVARIANTS)
> > > +__msg("7: (1f) r0 -=3D r6 {{.*}} R0=3Dscalar(smin=3D-655,smax=3Dsmax=
32=3D-146,umin=3D0xfffffffffffffd71,umax=3D0xffffffffffffff6e,smin32=3D-783=
,umin32=3D0xfffffcf1,umax32=3D0xffffff6e,var_off=3D(0xfffffffffffffc00; 0x3=
ff))")
> >=20
> > Interesting, note the difference: smin=3D-655, smin32=3D-783.
> > There is a code to infer s32 range from s46 range in this situation in
> > __reg32_deduce_bounds(), but it looks like a third __reg_deduce_bounds
> > call is needed to trigger it. E.g. the following patch removes the
> > difference for me:
>=20
> Hm, I can add the third __reg_deduce_bounds to the first patch in the
> series. That said, we may want to rethink and optimize reg_bounds_sync
> in a followup patchset. It's probably worth listing all the inferences
> we have and their dependencies and see if we can reorganize the
> subfunctions.

Let's not add third __reg_deduce_bounds yet. After inserting some
prints and looking more closely at the log, something funny happens at
instruction #2:

  2: (bc) w6 =3D (s8)w0
  reg_bounds_sync entry: scalar(smin=3D0,smax=3Dumax=3D0xffffffff,smin32=3D=
-128,smax32=3D127,var_off=3D(0x0; 0xffffffff))
  reg_bounds_sync __update_reg_bounds #1: scalar(smin=3D0,smax=3Dumax=3D0xf=
fffffff,smin32=3D-128,smax32=3D127,var_off=3D(0x0; 0xffffffff))
  reg_bounds_sync __reg_deduce_bounds #1: scalar(smin=3D0,smax=3Dumax=3D0xf=
fffffff,smin32=3D-128,smax32=3D127,var_off=3D(0x0; 0xffffffff))
  reg_bounds_sync __reg_deduce_bounds #2: scalar(smin=3D0,smax=3Dumax=3D0xf=
fffffff,smin32=3D-128,smax32=3D127,var_off=3D(0x0; 0xffffffff))
  reg_bounds_sync __reg_bound_offset: scalar(smin=3D0,smax=3Dumax=3D0xfffff=
fff,smin32=3D-128,smax32=3D127,var_off=3D(0x0; 0xffffffff))
  reg_bounds_sync __update_reg_bounds #2: scalar(smin=3D0,smax=3Dumax=3D0xf=
fffffff,smin32=3D-128,smax32=3D127,var_off=3D(0x0; 0xffffffff))
  3: R0_w=3Dscalar() R6_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,smin32=
=3D-128,smax32=3D127,var_off=3D(0x0; 0xffffffff))

It would be good to figure out what happens here.
That being said, the issue is not related to the patch in question.
I suggest rephrasing the test to avoid the sign extension above.

[...]

