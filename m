Return-Path: <bpf+bounces-51669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E16A3700A
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 19:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 083567A3B3D
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 18:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEFE1EA7CF;
	Sat, 15 Feb 2025 18:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsELuonZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDB21519A7;
	Sat, 15 Feb 2025 18:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739642482; cv=none; b=kfPk8M7VcUvuCbCjWKS13oxptJ6vqbxo3eSyJyhHyvmZ6NoJHR8U/OSq4SnZW/xAQMiLQB47Ok/Gub+PTBKOEDm1HgcYEMo76IJi9nHKJxgm0allV1nlasU1BpAWYuzGWp5jViFfeMEi+GFeuizh42TMP6pxH/m383IUE+UtWH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739642482; c=relaxed/simple;
	bh=C2Peyit1HHvClUv2db4PlaqL+j5mCCBsyfOCN0hM/XU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=d29Iema0Mb9z0pUxNC83x+/QTGxgOG62J0hNXt9RfzOYANw+freL7/LebDW6eSFdDk1dFUZBAaqp5HI6pHTBCld9XcFQW/vEthonyEMEmBWMaCo7bfZyZnclFUyMeTPD5yM7/8T9TYYxX5i8yEwe9+B710n8F/VU+KPkS4hN+/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsELuonZ; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e4562aa221so31796676d6.0;
        Sat, 15 Feb 2025 10:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739642480; x=1740247280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgEHwR6UCAfyExVeQ2p5isAXlmBkGls02oNUma+8KW0=;
        b=EsELuonZvXSqhPOKTxi17ss0WP4i24NT35VwQ1YEWU5n9TyRWKHzDIohI1akJ7bjXd
         DYUWRbYYAlUe8rQeBcL5LnenVVnMIOqD5lLcNCkpiAQwO6kKmdI/kZFs8+Zw9FPMYGWC
         V908PiDmhuhvYvAKBoU0Sha4jZKRj4aNhAoJ3SWGaNuey/Orq2JuAI9jQaFhPRBIseUQ
         vtLLmN0eNn7DsNF/JlehifXJz9raU2L6fYhvG9w3Ht7lx5XAxcBPKPCRMLBAaBWsYcnT
         f+S4AqxMuUHnF1zXTrZzHjSNLOeb8cCe9sCwtgnjWpiqvOv+HyQ6yu/6S9F0OLJ30zCr
         bXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739642480; x=1740247280;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cgEHwR6UCAfyExVeQ2p5isAXlmBkGls02oNUma+8KW0=;
        b=sOI1HJo07PdgLlxFjWWh8bb06GeV2QoQk6k0Ii6aJDjBW+Cq7AVejO6WUId7noDf+X
         VkbHVugrZcBRCB6CZtA2GfAUzIKCdz+kbX4s16Fifsmcnyus39jMJPiNZLBjYwfIHusn
         CiRMmFnxpG/RhZy0uBh9h9xBPFSLSU1FKfvNsiAIIakec0gRmoOUeNZBT6BeAWBaWwQW
         i4LAd4unBA2FlNuLRFVpAXXH6IOhTKDs/RCSevIVVp6kXSr8NOVnDYuezmYUxG47GywS
         FEn617s8MKg5bflhZV2oDByTRasZUQigDCDn9S4hDdp+m7XsNpihrCsGE6rXDe4fbIYO
         yfrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjhPzzwUZx9EkRh+MH2stP2xfmEUcbf4ww6HPdMkAG7deKtHqSUmvT8+Qly3RJcLCZDtE=@vger.kernel.org, AJvYcCWgDiUMsksA0cTad68rVXEWDYciX5m4A2OgUyTtbFWw7Ouvleg8vPNEab9182NHfejT2hXMucnX@vger.kernel.org
X-Gm-Message-State: AOJu0YyZF0QQm8kOWC4L2XEjK3cBIk0//bH57HBS268KFQd8mpsa+vvu
	XNkDh5D/9ushMKpA4vRWxn//6H74gQ5lb8vxWVP2D3+uWPos+NcoEXYPdQ==
X-Gm-Gg: ASbGncvagskUa+AmLaYH8/5VdpcP/lK+6viGseIG4N6IkfYotcw1BkUcv8KGyo46FqH
	dzPOioMKyPGUvYyx97ZD1f9IE3q0EF/sSsTAiz56XkIUn4QTGG9C5h54GPeWQVlooIP4myC/9ux
	5WlbAchChD0SepJ+mjMEA/fvTFup5qSXgU9MH0XYYvUlYssMh+QOHIhcOiDeFXF10+Yowk4kV7N
	XwHw/APYGwMX03ysy5YEiPpgNgLJTBM2+k8+C/ubYbpH236DxO0Vt1+COqJwbdIZQKbndmeftkP
	PuP17pJEOydgHuVechN7UM5AekPiRbBb8ktafCMHKU+3i5Q5LrRWVAnz/bP21mc=
X-Google-Smtp-Source: AGHT+IEXDJukpmb7x7YsePbaWMeSjU2vMr8dvfnpA2zyfLaEdqCsHmvT86fhXlx1XVsaGntAOLA9YA==
X-Received: by 2002:ad4:5f88:0:b0:6e6:61a5:aa4f with SMTP id 6a1803df08f44-6e66ce33eabmr50698466d6.45.1739642479911;
        Sat, 15 Feb 2025 10:01:19 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7a436esm34105216d6.62.2025.02.15.10.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 10:01:19 -0800 (PST)
Date: Sat, 15 Feb 2025 13:01:18 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 horms@kernel.org, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Message-ID: <67b0d66ec8d50_3818932941e@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoAN5EZbAzHDsWLpnzZ0sE5--_3qD5SQfVZf-OSZTw_gGw@mail.gmail.com>
References: <20250214010038.54131-1-kerneljasonxing@gmail.com>
 <20250214010038.54131-13-kerneljasonxing@gmail.com>
 <67b0af817bb1b_36e34429417@willemb.c.googlers.com.notmuch>
 <CAL+tcoAN5EZbAzHDsWLpnzZ0sE5--_3qD5SQfVZf-OSZTw_gGw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 12/12] selftests/bpf: add simple bpf tests in
 the tx path for timestamping feature
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Sat, Feb 15, 2025 at 11:15=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > BPF program calculates a couple of latency deltas between each tx
> > > timestamping callbacks. It can be used in the real world to diagnos=
e
> > > the kernel behaviour in the tx path.
> > >
> > > Check the safety issues by accessing a few bpf calls in
> > > bpf_test_access_bpf_calls() which are implemented in the patch 3 an=
d 4.
> > >
> > > Check if the bpf timestamping can co-exist with socket timestamping=
.
> > >
> > > There remains a few realistic things[1][2] to highlight:
> > > 1. in general a packet may pass through multiple qdiscs. For instan=
ce
> > > with bonding or tunnel virtual devices in the egress path.
> > > 2. packets may be resent, in which case an ACK might precede a repe=
at
> > > SCHED and SND.
> > > 3. erroneous or malicious peers may also just never send an ACK.
> > >
> > > [1]: https://lore.kernel.org/all/67a389af981b0_14e0832949d@willemb.=
c.googlers.com.notmuch/
> > > [2]: https://lore.kernel.org/all/c329a0c1-239b-4ca1-91f2-cb30b8dd2f=
6a@linux.dev/
> > >
> > > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> >
> > > +/* In the timestamping callbacks, we're not allowed to call the fo=
llowing
> > > + * BPF CALLs for the safety concern. Return false if expected.
> > > + */
> > > +static bool bpf_test_access_bpf_calls(struct bpf_sock_ops *skops,
> > > +                                   const struct sock *sk)
> >
> > Is this parameter aligned with the one on the previous line?
> >
> > This line was changed in the latest revision. Still looks off to me.
> > But that may just be how the diff is presented in my vi.
> >
> > > +SEC("fentry/tcp_sendmsg_locked")
> > > +int BPF_PROG(trace_tcp_sendmsg_locked, struct sock *sk, struct msg=
hdr *msg,
> > > +          size_t size)
> >
> > Same
> =

> Weird. I cannot see the problem from my machine. The CI didn't warn me
> on this alignment either. Probably your vi went wrong? I'm not sure.

If you double checked, I trust that it's just representation in my
client.


