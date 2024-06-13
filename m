Return-Path: <bpf+bounces-32106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C897907895
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 18:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22DFB289047
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 16:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117A3149C61;
	Thu, 13 Jun 2024 16:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXV3dwwW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD2C1448E6
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718297092; cv=none; b=iYuB//tIkBc/jU2IWw20vxIdT4rcbXnuuiU/kTHCoTQ4z8Ggl0VEwAeUEZAQLEiBA3Ki7KDaid/6GwVOafS2aSOXPkLejt/wBbCHqirvsaTrWlZ0QrbWs8SM8ID7MIC/E1EJzGRcmR1S8aQdoR4+ABsqQgtXm06FBfUJWQMd1sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718297092; c=relaxed/simple;
	bh=2veTvufTvxBc11woL/RTPZrBCjpP6f7NVRfqGC0qRdQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=lFaObSpre5dh0zUkhotTh/1oem68AdsvYY84Po73lhSgXy4WtmzVeJxyPv+Juks1IYkB97FOE/a+rgS20dRUH9QtcHGGlCycHEEVL685PlRyVDd8EvpheN9wJgh+IFxs28Q7RWFAewIHNQ/cx2OYm8dq0w3UX/Gd1Tj1i6RL2B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXV3dwwW; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3738690172eso6033415ab.1
        for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 09:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718297090; x=1718901890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4B2RLB2mgCxUq/OUsu5XJYGQADjwMx3pRuFptZZlSc=;
        b=KXV3dwwWOYmQqdJTmglqNXw1l3BaKnbmAzM4lXcZA15jGBGp8kw/Rwn4elC2gp2z3/
         JqiAz12Jy2JZNKwm7LK2e9GufwXO22AVNucZ82OOF/otPFWgCJ3mr1t0B+nqF6PefPtv
         QfVS7pKgvsHuP3w2ojpQIUC+PGbEcYdAAklOZ5R703kpxaQBSmgyXPkqQdvXeoXI1BYl
         A7VF+u8BURB1e+18qHUuuRRoDubEl+1PcVLNdWHOZmaYLCc2CZHaEXQvjujH9Icdv/Vo
         ObIdIbHoAu/qOhre4L4zoa7NzjmSOB5cihdLv/4nz9HL1Y+yPgO74zdmhMH1G9aACppt
         iknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718297090; x=1718901890;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l4B2RLB2mgCxUq/OUsu5XJYGQADjwMx3pRuFptZZlSc=;
        b=U3BhZZN3DgAPeAvS4dmzDzlr9pp1f2yaNryEr2zx18YT0YC4F9OOqScETo6iOkF7fE
         uyT6m+Sphuya8uXPOS7QN4FS1tHFS37Dz2jykPPojXvFC7JA+WeXfXwXExp85BCvKtka
         057O+tUvHsE/ZgQKUa6iuP/QvuBZQGze5H4tuOTBxb1XFX1dgWPiffgbySBOC/JXwPsb
         I9n+KnPKfkNfCLoWNFnE9FoUruobb6zX2/pU9AAIQU9zEGbnwOHJW2oCDt54D1pRagR3
         DqqDTo4h+0e2J011QtRjPCFDihHcvDXaf3dHrTTckAgjbgcTcdIsRnRvvsPz0VllaGOj
         m70g==
X-Forwarded-Encrypted: i=1; AJvYcCWdpXqxmZNXgK1bHHoOGXwo7hoyNE0zm+2jQQ3B9PiCGWRYgR/WStdoVfM+pVY4daVGbp2KDZyhj5BJGN03aACxZgbm
X-Gm-Message-State: AOJu0YyndudRm4GMpiPxKl7kGTO4/2NgdhkrmqsfrgSKx7TD3fDHqm1L
	791egp49tXefMjFggdpydwhgZelYWj/HxOAOdDIRclDLz1iWLS81
X-Google-Smtp-Source: AGHT+IFSUzwZKy69mKZY66RIes0tnKWhERkWLSkhCVCoEVyM5h5mJu2VMDRoh3X+antAJePbLXgLTA==
X-Received: by 2002:a92:c542:0:b0:374:a44b:1186 with SMTP id e9e14a558f8ab-375e0e15bb6mr1394955ab.12.1718297089740;
        Thu, 13 Jun 2024 09:44:49 -0700 (PDT)
Received: from localhost (c-73-14-12-167.hsd1.co.comcast.net. [73.14.12.167])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b956926b25sm433720173.57.2024.06.13.09.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 09:44:49 -0700 (PDT)
Date: Thu, 13 Jun 2024 09:44:48 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, 
 bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com, 
 jjlopezjaimez@google.com, 
 andrii.nakryiko@gmail.com, 
 eddyz87@gmail.com, 
 john.fastabend@gmail.com, 
 Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <666b220096404_1f0f208ea@john.notmuch>
In-Reply-To: <20240613115310.25383-1-daniel@iogearbox.net>
References: <20240613115310.25383-1-daniel@iogearbox.net>
Subject: RE: [PATCH bpf v2 1/3] bpf: Fix reg_set_min_max corruption of
 fake_reg
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Daniel Borkmann wrote:
> Juan reported that after doing some changes to buzzer [0] and implement=
ing
> a new fuzzing strategy guided by coverage, they noticed the following i=
n
> one of the probes:
> =

>   [...]
>   13: (79) r6 =3D *(u64 *)(r0 +0)         ; R0=3Dmap_value(ks=3D4,vs=3D=
8) R6_w=3Dscalar()
>   14: (b7) r0 =3D 0                       ; R0_w=3D0
>   15: (b4) w0 =3D -1                      ; R0_w=3D0xffffffff
>   16: (74) w0 >>=3D 1                     ; R0_w=3D0x7fffffff
>   17: (5c) w6 &=3D w0                     ; R0_w=3D0x7fffffff R6_w=3Dsc=
alar(smin=3Dsmin32=3D0,smax=3Dumax=3Dumax32=3D0x7fffffff,var_off=3D(0x0; =
0x7fffffff))
>   18: (44) w6 |=3D 2                      ; R6_w=3Dscalar(smin=3Dumin=3D=
smin32=3Dumin32=3D2,smax=3Dumax=3Dumax32=3D0x7fffffff,var_off=3D(0x2; 0x7=
ffffffd))
>   19: (56) if w6 !=3D 0x7ffffffd goto pc+1
>   REG INVARIANTS VIOLATION (true_reg2): range bounds violation u64=3D[0=
x7fffffff, 0x7ffffffd] s64=3D[0x7fffffff, 0x7ffffffd] u32=3D[0x7fffffff, =
0x7ffffffd] s32=3D[0x7fffffff, 0x7ffffffd] var_off=3D(0x7fffffff, 0x0)
>   REG INVARIANTS VIOLATION (false_reg1): range bounds violation u64=3D[=
0x7fffffff, 0x7ffffffd] s64=3D[0x7fffffff, 0x7ffffffd] u32=3D[0x7fffffff,=
 0x7ffffffd] s32=3D[0x7fffffff, 0x7ffffffd] var_off=3D(0x7fffffff, 0x0)
>   REG INVARIANTS VIOLATION (false_reg2): const tnum out of sync with ra=
nge bounds u64=3D[0x0, 0xffffffffffffffff] s64=3D[0x8000000000000000, 0x7=
fffffffffffffff] u32=3D[0x0, 0xffffffff] s32=3D[0x80000000, 0x7fffffff] v=
ar_off=3D(0x7fffffff, 0x0)
>   19: R6_w=3D0x7fffffff
>   20: (95) exit
> =

>   from 19 to 21: R0=3D0x7fffffff R6=3Dscalar(smin=3Dumin=3Dsmin32=3Dumi=
n32=3D2,smax=3Dumax=3Dsmax32=3Dumax32=3D0x7ffffffe,var_off=3D(0x2; 0x7fff=
fffd)) R7=3Dmap_ptr(ks=3D4,vs=3D8) R9=3Dctx() R10=3Dfp0 fp-24=3Dmap_ptr(k=
s=3D4,vs=3D8) fp-40=3Dmmmmmmmm
>   21: R0=3D0x7fffffff R6=3Dscalar(smin=3Dumin=3Dsmin32=3Dumin32=3D2,sma=
x=3Dumax=3Dsmax32=3Dumax32=3D0x7ffffffe,var_off=3D(0x2; 0x7ffffffd)) R7=3D=
map_ptr(ks=3D4,vs=3D8) R9=3Dctx() R10=3Dfp0 fp-24=3Dmap_ptr(ks=3D4,vs=3D8=
) fp-40=3Dmmmmmmmm
>   21: (14) w6 -=3D 2147483632             ; R6_w=3Dscalar(smin=3Dumin=3D=
umin32=3D2,smax=3Dumax=3D0xffffffff,smin32=3D0x80000012,smax32=3D14,var_o=
ff=3D(0x2; 0xfffffffd))
>   22: (76) if w6 s>=3D 0xe goto pc+1      ; R6_w=3Dscalar(smin=3Dumin=3D=
umin32=3D2,smax=3Dumax=3D0xffffffff,smin32=3D0x80000012,smax32=3D13,var_o=
ff=3D(0x2; 0xfffffffd))
>   23: (95) exit
> =

>   from 22 to 24: R0=3D0x7fffffff R6_w=3D14 R7=3Dmap_ptr(ks=3D4,vs=3D8) =
R9=3Dctx() R10=3Dfp0 fp-24=3Dmap_ptr(ks=3D4,vs=3D8) fp-40=3Dmmmmmmmm
>   24: R0=3D0x7fffffff R6_w=3D14 R7=3Dmap_ptr(ks=3D4,vs=3D8) R9=3Dctx() =
R10=3Dfp0 fp-24=3Dmap_ptr(ks=3D4,vs=3D8) fp-40=3Dmmmmmmmm
>   24: (14) w6 -=3D 14                     ; R6_w=3D0
>   [...]
> =

> What can be seen here is a register invariant violation on line 19. Aft=
er
> the binary-or in line 18, the verifier knows that bit 2 is set but know=
s
> nothing about the rest of the content which was loaded from a map value=
,
> meaning, range is [2,0x7fffffff] with var_off=3D(0x2; 0x7ffffffd). When=
 in
> line 19 the verifier analyzes the branch, it splits the register states=

> in reg_set_min_max() into the registers of the true branch (true_reg1,
> true_reg2) and the registers of the false branch (false_reg1, false_reg=
2).
> =

> Since the test is w6 !=3D 0x7ffffffd, the src_reg is a known constant.
> Internally, the verifier creates a "fake" register initialized as scala=
r
> to the value of 0x7ffffffd, and then passes it onto reg_set_min_max(). =
Now,
> for line 19, it is mathematically impossible to take the false branch o=
f
> this program, yet the verifier analyzes it. It is impossible because th=
e
> second bit of r6 will be set due to the prior or operation and the
> constant in the condition has that bit unset (hex(fd) =3D=3D binary(111=
1 1101).
> =

> When the verifier first analyzes the false / fall-through branch, it wi=
ll
> compute an intersection between the var_off of r6 and of the constant. =
This
> is because the verifier creates a "fake" register initialized to the va=
lue
> of the constant. The intersection result later refines both registers i=
n
> regs_refine_cond_op():
> =

>   [...]
>   t =3D tnum_intersect(tnum_subreg(reg1->var_off), tnum_subreg(reg2->va=
r_off));
>   reg1->var_off =3D tnum_with_subreg(reg1->var_off, t);
>   reg2->var_off =3D tnum_with_subreg(reg2->var_off, t);
>   [...]
> =

> Since the verifier is analyzing the false branch of the conditional jum=
p,
> reg1 is equal to false_reg1 and reg2 is equal to false_reg2, i.e. the r=
eg2
> is the "fake" register that was meant to hold a constant value. The res=
ulting
> var_off of the intersection says that both registers now hold a known v=
alue
> of var_off=3D(0x7fffffff, 0x0) or in other words: this operation manage=
s to
> make the verifier think that the "constant" value that was passed in th=
e
> jump operation now holds a different value.
> =

> Normally this would not be an issue since it should not influence the t=
rue
> branch, however, false_reg2 and true_reg2 are pointers to the same "fak=
e"
> register. Meaning, the false branch can influence the results of the tr=
ue
> branch. In line 24, the verifier assumes R6_w=3D0, but the actual runti=
me
> value in this case is 1. The fix is simply not passing in the same "fak=
e"
> register location as inputs to reg_set_min_max(), but instead making a
> copy. Moving the fake_reg into the env also reduces stack consumption b=
y
> 120 bytes. With this, the verifier successfully rejects invalid accesse=
s
> from the test program.
> =

>   [0] https://github.com/google/buzzer
> =

> Fixes: 67420501e868 ("bpf: generalize reg_set_min_max() to handle non-c=
onst register comparisons")
> Reported-by: Juan Jos=C3=A9 L=C3=B3pez Jaimez <jjlopezjaimez@google.com=
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  v1 -> v2:
>   - Reduce stack space consumption (Alexei)

Reviewed-by: John Fastabend <john.fastabend@gmail.com>=

