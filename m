Return-Path: <bpf+bounces-64329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A044B1190A
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 09:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AA3E3BE3A0
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 07:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915F229994A;
	Fri, 25 Jul 2025 07:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjnBYe1n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9962951CB
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 07:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753427724; cv=none; b=Hl3ptE1aTXBiWXb5D42GP/3d0F4oWXjXXHx56A7KkbqoGx0BHEDiS5CpflaUq6ezMP4za6wtWsD+uag/NdOAgsWKmRXb+mEdocCxgMFx8XgrdyYBmNdwFyYUwfWHKlEFmmag/ToIr2cQ2BY32Ps19py75Me2fMCOfQqzE7k53h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753427724; c=relaxed/simple;
	bh=Iz70aZVTyz/P94Ka49ThA+YcwXAkvaRYFTmwtoW9AYU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hdy2kqwJtuWMPdp7pqL03ExBFK7ewAOWVP5FVHZNEYUFzXcdVTidiwlF4PhN1mP8LQnJrb8LMM3PBbIBjhIZnhV6+SThOyVlNJqS+c+zSRf+SiEDLsYa+q3xISfggxJ4CSfufOxBRNBqAVRcgqjtrsMep+wKdhoF6lRUyXcJbMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjnBYe1n; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-234b9dfb842so15635245ad.1
        for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 00:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753427722; x=1754032522; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lFDA+CFA/gQQm/HCijyKY5xYMUWmYMy5/3mdVwRPEV4=;
        b=OjnBYe1nXinOe07TDApaw4alNR5KIOnbf+Bk44HCYiGmMRJdO3RXQCjsWTOXeSwo2Q
         vT/5TUFLrxNi9ZXq72V2bubgRt8VK6W95KBFAzOy2UJvjZ2RgNtn5g6VmlA+UwMwONlB
         ZHTz3yWG1IZw6Vbv2vep6c67FHMD7Z1VLV3FymmYl455dlSn3Q1jZtZ0n7eLk6WaZprm
         /KixGPJ4V8rdJqgA5K26RJcjFeOUTWT1cWGfczzoskIo+TRQ9xAWcDIDTvbjCqAoOxrb
         SgubE9+bw7by6Pnwk/jgMDuz4Y0XMXgl3xcE3FrqZwBUbawQBJe3ITfZ2HcrmxlWDnSc
         PFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753427722; x=1754032522;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lFDA+CFA/gQQm/HCijyKY5xYMUWmYMy5/3mdVwRPEV4=;
        b=ZZKhBGqKrj/ld22XstgV6p1e2Cz3oBuOqiRsYX+HxF01XwFZshvkcVtjTo+Qa/th4i
         lpBZy0aPf44ydqW5rZzYNqgZugxb31+HuheW0Rm8ycH/oidYaTlt8cUA4HgGdrO4CFRl
         X7RqzGZi+d2maWqWKbqRRfoKrsxeHBgEPBhhBRXyeDc54UMp0FJ2vafy303gJ1UTTJ6d
         ib5ZTMd3qsicWyprKZmKk+AG5uhoxC84fcP+tE/7kFX9gTebtHuTvmg3K+T0W8s0C7nr
         RbtdwdCRJLlJ8Gg3oZR+IjDy0oRqeiUvWKh4kf0TrocoShVHzAg6CG32l+Rwp0Cu5ubt
         xleQ==
X-Gm-Message-State: AOJu0Yxmeu+IwDYWL2qSUMkZWRj0GwfOL20DJR7n+KTKPnySJEvGr7sC
	MdXHO0IZvY1XkT57Td9XuVENIWqrTSP7uq0uUxq3R/V3PJXtTVxDMWges7ZNYg==
X-Gm-Gg: ASbGnctTifXQ1KoEqe59FasWXCVHWVePM04ZAisdXlli5vFVoK1YJMziv9lnY9KIBlU
	w8xfXwAEz6qchlIXGa2T14vCHYijS+4pSeIMurQ5T4kAIApFGODB1h4ZWxVlk8swIpsL1W39SDu
	aA/gGVXuQM3IvBSMFaPdo3ChN6zie0sGpFWyN/aEIBb9vuXyMdewC3kUkd3RyWYJSPoCiRfTdn0
	A4F7dRiuL6EGFEyBdjnxcO/ED2Ua3woItuztzVibb5+0HQY/jCqm2NL8E+z5J02wxx444kd/XcE
	CGRVk5I+T1/O+0jKUajCi4xciVG11WPk96gyQkETidpuvd653UGDZCHkA8pKH29k+bPOnIu0K/1
	Rt6FEYEvG+uEiOUZuN7uOfcUSoYsd
X-Google-Smtp-Source: AGHT+IE7AfMgwfUXmBoylwW09pB+u3/eez1AIBVKx1h2omFUSR5k5DT5c3aJZQK8mrEsn0TplQs4+Q==
X-Received: by 2002:a17:902:dacd:b0:234:a734:4ab1 with SMTP id d9443c01a7336-23fb307cde0mr14900145ad.3.1753427721613;
        Fri, 25 Jul 2025 00:15:21 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa475f3bcsm30418995ad.10.2025.07.25.00.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 00:15:21 -0700 (PDT)
Message-ID: <d7f52ed7d0f0b3fd2ce8336f4161b776cfc0d628.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Test cross-sign 64bits
 range refinement
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>, Shung-Hsi Yu
 <shung-hsi.yu@suse.com>
Date: Fri, 25 Jul 2025 00:15:18 -0700
In-Reply-To: <6d75ad3a05ebf56ab2f68e677264e8142c372fbc.camel@gmail.com>
References: <cover.1753364265.git.paul.chaignon@gmail.com>
		 <8f1297bcbfaeebff55215d57f488570152ebb05f.1753364265.git.paul.chaignon@gmail.com>
		 <905853bfc266a6969953b4de8433ef9ca7e7a34c.camel@gmail.com>
		 <aIKtSK9LjQXB8FLY@mail.gmail.com>
	 <6d75ad3a05ebf56ab2f68e677264e8142c372fbc.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-07-24 at 16:52 -0700, Eduard Zingerman wrote:
> On Fri, 2025-07-25 at 00:01 +0200, Paul Chaignon wrote:
> > On Thu, Jul 24, 2025 at 12:15:53PM -0700, Eduard Zingerman wrote:
> > > On Thu, 2025-07-24 at 15:43 +0200, Paul Chaignon wrote:
> >=20
> > [...]
> >=20
> > > > +SEC("socket")
> > > > +__description("bounds deduction cross sign boundary, negative over=
lap")
> > > > +__success __log_level(2) __flag(BPF_F_TEST_REG_INVARIANTS)
> > > > +__msg("7: (1f) r0 -=3D r6 {{.*}} R0=3Dscalar(smin=3D-655,smax=3Dsm=
ax32=3D-146,umin=3D0xfffffffffffffd71,umax=3D0xffffffffffffff6e,smin32=3D-7=
83,umin32=3D0xfffffcf1,umax32=3D0xffffff6e,var_off=3D(0xfffffffffffffc00; 0=
x3ff))")
> > >=20
> > > Interesting, note the difference: smin=3D-655, smin32=3D-783.
> > > There is a code to infer s32 range from s46 range in this situation i=
n
> > > __reg32_deduce_bounds(), but it looks like a third __reg_deduce_bound=
s
> > > call is needed to trigger it. E.g. the following patch removes the
> > > difference for me:
> >=20
> > Hm, I can add the third __reg_deduce_bounds to the first patch in the
> > series. That said, we may want to rethink and optimize reg_bounds_sync
> > in a followup patchset. It's probably worth listing all the inferences
> > we have and their dependencies and see if we can reorganize the
> > subfunctions.
>=20
> Let's not add third __reg_deduce_bounds yet. After inserting some
> prints and looking more closely at the log, something funny happens at
> instruction #2:
>=20
>   2: (bc) w6 =3D (s8)w0
>   reg_bounds_sync entry: scalar(smin=3D0,smax=3Dumax=3D0xffffffff,smin32=
=3D-128,smax32=3D127,var_off=3D(0x0; 0xffffffff))
>   reg_bounds_sync __update_reg_bounds #1: scalar(smin=3D0,smax=3Dumax=3D0=
xffffffff,smin32=3D-128,smax32=3D127,var_off=3D(0x0; 0xffffffff))
>   reg_bounds_sync __reg_deduce_bounds #1: scalar(smin=3D0,smax=3Dumax=3D0=
xffffffff,smin32=3D-128,smax32=3D127,var_off=3D(0x0; 0xffffffff))
>   reg_bounds_sync __reg_deduce_bounds #2: scalar(smin=3D0,smax=3Dumax=3D0=
xffffffff,smin32=3D-128,smax32=3D127,var_off=3D(0x0; 0xffffffff))
>   reg_bounds_sync __reg_bound_offset: scalar(smin=3D0,smax=3Dumax=3D0xfff=
fffff,smin32=3D-128,smax32=3D127,var_off=3D(0x0; 0xffffffff))
>   reg_bounds_sync __update_reg_bounds #2: scalar(smin=3D0,smax=3Dumax=3D0=
xffffffff,smin32=3D-128,smax32=3D127,var_off=3D(0x0; 0xffffffff))
>   3: R0_w=3Dscalar() R6_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,smin=
32=3D-128,smax32=3D127,var_off=3D(0x0; 0xffffffff))
>=20
> It would be good to figure out what happens here.
> That being said, the issue is not related to the patch in question.
> I suggest rephrasing the test to avoid the sign extension above.
>=20
> [...]

Apologies, I'm being stupid above. The range after sign extension is
perfectly fine.

So, going back to the question of the test cases, here is a relevant
part with debug prints [1]:

  7: (1f) r0 -=3D r6
  reg_bounds_sync entry:                  scalar(smin=3D-655,smax=3D0xeffff=
eee,smin32=3D-783,smax32=3D-146)
  reg_bounds_sync __update_reg_bounds #1: scalar(smin=3D-655,smax=3D0xeffff=
eee,smin32=3D-783,smax32=3D-146)
  __reg32_deduce_bounds #8:               scalar(smin=3D-655,smax=3D0xeffff=
eee,smin32=3D-783,smax32=3D-146,umin32=3D0xfffffcf1,umax32=3D0xffffff6e)
  __reg_deduce_mixed_bounds #1:           scalar(smin=3D-655,smax=3D0xeffff=
eee,umin=3Dumin32=3D0xfffffcf1,  umax=3D0xffffffffffffff6e,smin32=3D-783,sm=
ax32=3D-146,      umax32=3D0xffffff6e)
  reg_bounds_sync __reg_deduce_bounds #1: scalar(smin=3D-655,smax=3D0xeffff=
eee,umin=3Dumin32=3D0xfffffcf1,  umax=3D0xffffffffffffff6e,smin32=3D-783,sm=
ax32=3D-146,      umax32=3D0xffffff6e)
  __reg32_deduce_bounds #7:               scalar(smin=3D-655,smax=3D0xeffff=
eee,umin=3Dumin32=3D0xfffffcf1,  umax=3D0xffffffffffffff6e,smin32=3D-783,sm=
ax32=3D-146,      umax32=3D0xffffff6e)
  __reg32_deduce_bounds #8:               scalar(smin=3D-655,smax=3D0xeffff=
eee,umin=3Dumin32=3D0xfffffcf1,  umax=3D0xffffffffffffff6e,smin32=3D-783,sm=
ax32=3D-146,      umax32=3D0xffffff6e)
  __reg64_deduce_bounds #4:               scalar(smin=3D-655,smax=3Dsmax32=
=3D-146,umin=3D0xfffffffffffffd71,umax=3D0xffffffffffffff6e,smin32=3D-783,u=
min32=3D0xfffffcf1,umax32=3D0xffffff6e)
  __reg_deduce_mixed_bounds #1:           scalar(smin=3D-655,smax=3Dsmax32=
=3D-146,umin=3D0xfffffffffffffd71,umax=3D0xffffffffffffff6e,smin32=3D-783,u=
min32=3D0xfffffcf1,umax32=3D0xffffff6e)
  reg_bounds_sync __reg_deduce_bounds #2: scalar(smin=3D-655,smax=3Dsmax32=
=3D-146,umin=3D0xfffffffffffffd71,umax=3D0xffffffffffffff6e,smin32=3D-783,u=
min32=3D0xfffffcf1,umax32=3D0xffffff6e)
  reg_bounds_sync __reg_bound_offset:     scalar(smin=3D-655,smax=3Dsmax32=
=3D-146,umin=3D0xfffffffffffffd71,umax=3D0xffffffffffffff6e,smin32=3D-783,u=
min32=3D0xfffffcf1,umax32=3D0xffffff6e,var_off=3D(0xfffffffffffffc00; 0x3ff=
))
  reg_bounds_sync __update_reg_bounds #2: scalar(smin=3D-655,smax=3Dsmax32=
=3D-146,umin=3D0xfffffffffffffd71,umax=3D0xffffffffffffff6e,smin32=3D-783,u=
min32=3D0xfffffcf1,umax32=3D0xffffff6e,var_off=3D(0xfffffffffffffc00; 0x3ff=
))

  8: R0=3Dscalar(smin=3D-655,smax=3Dsmax32=3D-146,umin=3D0xfffffffffffffd71=
,umax=3D0xffffffffffffff6e,smin32=3D-783,umin32=3D0xfffffcf1,umax32=3D0xfff=
fff6e,var_off=3D(0xfffffffffffffc00; 0x3ff))
     R6=3Dscalar(smin=3Dumin=3Dsmin32=3Dumin32=3D400,smax=3Dumax=3Dsmax32=
=3Dumax32=3D527,var_off=3D(0x0; 0x3ff))

Important parts are:
a. "__reg32_deduce_bounds #8"     updates umin32 and umax32
b. "__reg_deduce_mixed_bounds #1" updates umin and umax (uses values from a=
)
c. "__reg64_deduce_bounds #4"     updates smax and umin (enabled by b)

Only at this point there is an opportunity to refine smin32 from smin
using rule "__reg32_deduce_bounds #2", because of the conditions for
umin and umax (umin refinement by (c) is crucial).
Your new check is (c).

So, it looks like adding third call to __reg_deduce_bounds() in
reg_bounds_sync() is not wrong and the change is linked to this
patch-set.

As you say, whether there is a better way to organize all these rules
requires further analysis, and is a bit out of scope for this
patch-set.

[1] https://github.com/kernel-patches/bpf/commit/f68d4957204f21caac67d24de4=
0fb66e4618f354

