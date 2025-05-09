Return-Path: <bpf+bounces-57899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE79AB1B81
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 19:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E88A7A9E04
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 17:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BAF239E8D;
	Fri,  9 May 2025 17:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXgZ8hLT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E7C7E1
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 17:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746811323; cv=none; b=YWIXG9Ji2UIIygeXSz94BDm6lzinvXCtkmaJ5HhElpmw8ZfFOr7SkvQ/cAqpqbm8REGxuFt7K9eKx5SL5FJQVjywL5xzuyvaDNRSui4SaX6/LUJXLMzPEsAjyRB8/901QQfJGwEyY/1mUrrIDXrLTzBY2k4cunegWzAaBs6kLOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746811323; c=relaxed/simple;
	bh=y29vH3ly2Pgb2o4uDrgUvDlXQMRrqm9XgLGlqnYtkPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Co1JgIJfsuvPrr7tke3kgMl7jzWjGUWK+L8VwzFwPRCbtITB3ZsZtwP5CL0yoDnTpNlxaNrdcHe10xqkawcCMTe9shA++rXPVafB5K9w1SrCCCPizwzcUYiZYMaPAU/TiaoEE2TbNPVZhfmpH7xRGpvQZTF1m0nTYsNEUsmsh9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXgZ8hLT; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cfe574976so16667175e9.1
        for <bpf@vger.kernel.org>; Fri, 09 May 2025 10:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746811320; x=1747416120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leOMp+2qkNoGYZWewIojWJ9Gi2xeRLT9Hc/T92OelYg=;
        b=cXgZ8hLT7Q0xrOlR3a0hjojOSYP5etpVP0m9VjtXb8cdKEtbnYwUgy3mGYae7XG4Sh
         h2tUUOKPYIuo3K8KpgS60Mra3Zx+R+gAN6N6SJXhBHJjymkQ630ymqT7oiJHmi0f7P2/
         NdHQwwXiyAje7HPTOn7Yy9Wgear6qzsasJHuTJRRtaq8aHyzlrXp8jlt8OaSsoaGfo97
         3/oGaqQPDhN1gn2BK/PCmyJczddblHcfbGox3BJu1UTXK0S1QjN+cbpbn70/YSEbzPAj
         Lf1NaLrkqr9M3522VU2lhd8xwC+kQTiOfl5vG9Ya/TGOO9S6v6tzjATzuYmzgcpb3f8C
         P8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746811320; x=1747416120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=leOMp+2qkNoGYZWewIojWJ9Gi2xeRLT9Hc/T92OelYg=;
        b=hiqLPr3sA3LDsx/gCxwhnp4XA61FhkVuN9vMSvrI2VXoeczildkhnnl9PM2EvlKudK
         rrtvg6IJJZcKEqSo12rN9FIeAr13b2oXjrBoX6aP6mjdUCMU9tX0yVz1OexsoRI4nzbP
         0kOKHn2aSwWJjBS/emN0a9i5lJfOO20Ds5QYdYmM9sO+KoIfjSipzXItAlBQmiJE2wg2
         WINqWVBTHAzzPwNDA+VaT9OzXgBUVIdtIzfwV2crQOSkDIWELFaLCfKqh6XwEHiYR44H
         UC28XEr3j54NNbuYPw8x22MkuH/LwdBn6TevLI6xqxW7nXhi++llyt85ZLhnHEtGX0cD
         XltA==
X-Forwarded-Encrypted: i=1; AJvYcCXB64MebcgktktoBbIPqp9VR0zlp9UHQAKqQFpBX60Aq8Tafp2xeaeSZU4lHrq//sHGvAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwymI3bXF5BK0xRz86gJLOTdIv4gIGd01ZOx2LfklBMAvkamkwT
	oU5wyiRIiuIBd8N0qwRT7fdv/2CXTtbJ3NNg3p/LMu5HKHlUXysMMRBnvyS0o01rO/cyYe1o0z2
	u8of/4D5yLnIND3DlqMTD0upp434=
X-Gm-Gg: ASbGncvcF/pQWIFF3FnKbP4wnOiUaNTKv0BIxWaiS9wk4FH/gvPMtY0Yw8R7dz0yDJp
	VX74veoe6ZsDh0+788SoYZMhntSiL1fnH+POeJxu79IK38ENdtFzx/8BkAio832fy4Gl1Ok2aao
	YYPls0EiRcNDQTSanJe/ybEuoFyncxW5NncAwdbw==
X-Google-Smtp-Source: AGHT+IELF2BFmnk+bWvkdsZqGN/UFx2bI7ulSlq2cLhLRj78CweuSDcoyXz+evgdKsFK3ZIdviIRhJbGASAi/Cd3Jr4=
X-Received: by 2002:a05:6000:144b:b0:3a0:b65b:78ef with SMTP id
 ffacd0b85a97d-3a1f64b6931mr4053456f8f.52.1746811320159; Fri, 09 May 2025
 10:22:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230728011143.3710005-1-yonghong.song@linux.dev>
 <20230728011231.3716103-1-yonghong.song@linux.dev> <Z/8q3xzpU59CIYQE@ly-workstation>
 <763cbfb4-b1a0-4752-8428-749bb12e2103@linux.dev> <33a03235-638d-4c63-811d-ec44872654b3@linux.dev>
In-Reply-To: <33a03235-638d-4c63-811d-ec44872654b3@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 May 2025 10:21:49 -0700
X-Gm-Features: AX0GCFsieX1lvC1QRuaXdwOVtulQTjFK-Cog5o9_X9KfC2ssesQqSoAi6KUsyVQ
Message-ID: <CAADnVQJBgEDXnsRjTC0BUPAqfiHoH+ZL6vk1Me-+QcXbT811jg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 07/17] bpf: Support new 32bit offset jmp instruction
To: Yonghong Song <yonghong.song@linux.dev>, Andrii Nakryiko <andrii@kernel.org>
Cc: "Lai, Yi" <yi1.lai@linux.intel.com>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	David Faust <david.faust@oracle.com>, "Jose E . Marchesi" <jose.marchesi@oracle.com>, 
	Kernel Team <kernel-team@fb.com>, Eduard Zingerman <eddyz87@gmail.com>, yi1.lai@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 9:09=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
>
> On 5/7/25 1:06 PM, Yonghong Song wrote:
> >
> >
> > On 4/15/25 11:58 AM, Lai, Yi wrote:
> >> Hi Yonghong Song,
> >>
> >> Greetings!
> >>
> >> I used Syzkaller and found that there is WARNING in
> >> __mark_chain_precision in linux-next tag - next-20250414.
> >
> > Thanks, Yi. I will investigate this soon.
>
> I did some investigation. The source code looks like below:
>
> +__used __naked static void hack_sub(void)
> +{
> +       asm volatile ("                                 \
> +        r2 =3D 2314885393468386424 ll; \
> +        gotol +0; \
> +        if r2 <=3D r10 goto -1; \
> +        if r1 >=3D -1835016 goto +0; \
> +        if r2 <=3D 8 goto +0; \
> +        if r3 <=3D 0 goto +0; \
> +        call 44; \
> +        exit; \
> +       "      :
> +       :
> +       : __clobber_all);
> +}
> +
> +SEC("cgroup/sock_create")
> +__description("HACK")
> +__success __retval(0)
> +__naked void hack(void)
> +{
> +       asm volatile ("                                 \
> +        r3 =3D 0 ll; \
> +        call hack_sub; \
> +        exit; \
> +       "      :
> +       :
> +       : __clobber_all);
> +}
>
> The verification failure:
>
> 0: R1=3Dctx() R10=3Dfp0
> ; asm volatile ("                                 \ @ verifier_movsx.c:35=
2
> 0: (18) r3 =3D 0x0                      ; R3_w=3D0
> 2: (85) call pc+1
> caller:
>   R10=3Dfp0
> callee:
>   frame1: R1=3Dctx() R3_w=3D0 R10=3Dfp0
> 4: frame1: R1=3Dctx() R3_w=3D0 R10=3Dfp0
> ; asm volatile ("                                 \ @ verifier_movsx.c:33=
3
> 4: (18) r2 =3D 0x20202000256c6c78       ; frame1: R2_w=3D0x20202000256c6c=
78
> 6: (06) gotol pc+0
> 7: (bd) if r2 <=3D r10 goto pc-1        ; frame1: R2_w=3D0x20202000256c6c=
78 R10=3Dfp0
> 8: (35) if r1 >=3D 0xffe3fff8 goto pc+0         ; frame1: R1=3Dctx()
> 9: (b5) if r2 <=3D 0x8 goto pc+0
> mark_precise: frame1: last_idx 9 first_idx 0 subseq_idx -1
> mark_precise: frame1: regs=3Dr2 stack=3D before 8: (35) if r1 >=3D 0xffe3=
fff8 goto pc+0
> mark_precise: frame1: regs=3Dr2 stack=3D before 7: (bd) if r2 <=3D r10 go=
to pc-1
> mark_precise: frame1: regs=3Dr2,r10 stack=3D before 6: (06) gotol pc+0
> mark_precise: frame1: regs=3Dr2,r10 stack=3D before 4: (18) r2 =3D 0x2020=
2000256c6c78
> mark_precise: frame1: regs=3Dr10 stack=3D before 2: (85) call pc+1
> BUG regs 400
> processed 7 insns (limit 1000000) max_states_per_insn 0 total_states 0 pe=
ak_states 0 mark_read 0
>
> The verification failure happens below (line 4301 and 4302)
>
>   4294                                 /* static subprog call instruction=
, which
>   4295                                  * means that we are exiting curre=
nt subprog,
>   4296                                  * so only r1-r5 could be still re=
quested as
>   4297                                  * precise, r0 and r6-r10 or any s=
tack slot in
>   4298                                  * the current frame should be zer=
o by now
>   4299                                  */
>   4300                                 if (bt_reg_mask(bt) & ~BPF_REGMASK=
_ARGS) {
>   4301                                         verbose(env, "BUG regs %x\=
n", bt_reg_mask(bt));
>   4302                                         WARN_ONCE(1, "verifier bac=
ktracking bug");
>   4303                                         return -EFAULT;
>   4304                                 }
>
> So the failure reason is due to r10 is used during comparisons.
> So verifier does the right thing. Maybe you should remove WARN_ONCE
> ("verifier backtracking bug")? Do we actually hit backtracking bug
> due to verifier implementation?

hmm.
We probably should filter out r10 somehow,
since the following:
> mark_precise: frame1: regs=3Dr2 stack=3D before 7: (bd) if r2 <=3D r10 go=
to pc-1
> mark_precise: frame1: regs=3Dr2,r10 stack=3D before 6: (06) gotol pc+0

is already odd.

Andrii,

ideas?

