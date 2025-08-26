Return-Path: <bpf+bounces-66532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C337DB35764
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 10:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB723B17B8
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 08:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB732FB61D;
	Tue, 26 Aug 2025 08:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aV1dQTKn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F622253FE
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 08:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756197639; cv=none; b=gsuCXa2dUHIFM6TnVMucpyXeawm/9qcXSaZWJGpMhkBqryVHRpEsaVZa49oo0ugYnT4wcu/O8SIrKbzs82JUbJwegQKFt4SrbrwFsCuMdnZd/5+/AuEj+fssGGomMyFr+hlMzwYkHbP1ZZKUdc6aAtstRtzwooGLPwjbo1cVMC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756197639; c=relaxed/simple;
	bh=ml7uVD5DRcxn+9bX3pvVGLbn5/HLiqMsHxdVboS7fR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PtwThoLCYI66uglSTEqbSQ2at8JA01kVXwUGJ/ep4npuqPqYkSBARSwwyZuOPoscOoRomNQz41jFSqJ/Mf0YY+vNotwnkiwCtV16c6941y90bZykjnM14OvPtANA/aXmN5RgKLC9RSRDOCVrqCNgkZ6L8rCITSpIE5mb3HucLTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aV1dQTKn; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61c638ab6c9so2894257a12.1
        for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 01:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756197636; x=1756802436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUznInQ+he7CTGLbKkCgI51NqCENsR+GsS1zL5TwQYs=;
        b=aV1dQTKnUjnBvZavGn2dCA1MtWHA4v53HUZNNivFEyHO3qAHlYiZ/Q0NHLGHnGcC2i
         /pbRlT2A1i1cQ3aCQG78izpKILS9vGBIreqm9xZePYBTQNEK1DoRKXWFIkYMMoijhWuK
         4WCimyNcBsh/XC3jwFl4W+sIgtInYw3nWXXCpuZsC1bk0BTtwQ34EzQSrGj8j6NcKzdP
         jgaw32Wi3BQGHxaP1gxJiaEDNqNoYvwVl0AmePX+9tK+ZzFy1VIVSBHHwer9OMyTuPSI
         Ri7C9drEG2IxptY2U1QuDo+HPGbsCfAZ4fBR1DoZrhQH+8S8soy8lxZGxcCVqbcxRuKa
         neJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756197636; x=1756802436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUznInQ+he7CTGLbKkCgI51NqCENsR+GsS1zL5TwQYs=;
        b=LQ0c6U8Dqj0bwWzlXxStPQg4i+CauNdfs/8Aa+2W1SOmDdkNULBdDiqOU9VUiJM2+Y
         Mj2WwRQDKwUw3XNLqWRyBHZ39IJ2fGnZm1TYeUN4pFYeE8qEAELUmopWaRmJ1u83jiJ/
         jSHQr8X7SxE3jeRwRRp7cBLqccuewViqFTMd9APH10lQSwg/j82pcZ/OZzmr9igzT673
         MuZRNL+oKlTAYWM6A+J+Z4uZrfZ4b1ZyScA1P88CXClE+BWR2M5K4Vj2d7QBy4ijB+xv
         sxAth0HeiVvgiHeWhjXAcjE79GachHIPdZyNDVn3vIZD3Px85mCIDTaK39zKM1pqVbHZ
         zgEA==
X-Forwarded-Encrypted: i=1; AJvYcCWFMgVPO3bFSvhVJPvn1kl3BznoOvbQyIuvy6vFzjFmZTdlvmJ9JxivrBRhCnr/89QWsE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySYrZmVo+pU6VwsAHtPRbGne2i7yFKu3qwO1O+9pKT4IjXjACs
	xLStWaA+hFyd5vM4W9+t+AyaYBG+sL+XkYYrAbiq2QxvejLbmF0tgk9iNeKgJr4W7MO5Qp/xKoE
	uzUHPDFeGfxs+WpkLiBhgldywU4h+h2Q=
X-Gm-Gg: ASbGncuzB8KAVFEFaMTvnJ/Qe8B7R7zgKeNEc1ZW4/Y+VprsoPrMXPqJSxBnyJUpiPV
	hleRE/2Nfpkoc06BscaSCP2n+ZqwRaESohlh5VHJKeqvMK3jEBF9A0v72G0lsj/nhQEGt+/ZKxA
	AAksh05FZiKMYTco/krCjTAG29UWJ01MWnTJoW9FAMPM7dXmok9aazQNK3gln32p1YQFF6d2k2a
	s2H+kWiRha1qrxkwFlNLab0FxZCeipodr4LPwFtI6pasjpbGCCT8NF1aoVtHEsUYcrEIdHXsMhq
	ZDDLFtEY2NsZp0jPjfovbbdzmCfs3/x2CcpLNEXJSiQNX/m0Uh2DlUg=
X-Google-Smtp-Source: AGHT+IFViBToBz8KQVACO+Zo3R9SVs9VHYtIQ/Gqv75jKhOBsfcB/SlIujQazaI+0CvTngCa+ykKREpzxIkr0qUtXws=
X-Received: by 2002:a05:6402:21c1:b0:61b:ff85:398b with SMTP id
 4fb4d7f45d1cf-61c1b4a2163mr12823828a12.14.1756197635743; Tue, 26 Aug 2025
 01:40:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819111953.3197428-1-chenhuacai@loongson.cn> <1378057e-4fc1-2bcd-4d60-1a10bd98e5bb@loongson.cn>
In-Reply-To: <1378057e-4fc1-2bcd-4d60-1a10bd98e5bb@loongson.cn>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Tue, 26 Aug 2025 16:40:21 +0800
X-Gm-Features: Ac12FXxf-4Mbv86G81MkWYAbsoZgs8HhVE-23zzhyxDMTXP0prtcdtpVv3BGBGs
Message-ID: <CAAhV-H7UnPBpa7jK4WwqQJGnAP+cnsoggxkt1T3spoed4OfkTw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: BPF: Fix uninitialized symbol 'retval_off'
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org, 
	Hengqi Chen <hengqi.chen@gmail.com>, George Guo <guodongtai@kylinos.cn>, 
	Chenghao Duan <duanchenghao@kylinos.cn>, loongarch@lists.linux.dev, 
	kernel test robot <lkp@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 3:08=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> On 2025/8/19 =E4=B8=8B=E5=8D=887:19, Huacai Chen wrote:
> > In __arch_prepare_bpf_trampoline(), retval_off is meaningful only when
> > save_ret is not 0, so the current logic is correct. But it may cause a
> > build warning:
> >
> > arch/loongarch/net/bpf_jit.c:1547 __arch_prepare_bpf_trampoline() error=
: uninitialized symbol 'retval_off'.
> >
> > So initialize retval_off unconditionally to fix it.
> >
> > Fixes: f9b6b41f0cf3 ("LoongArch: BPF: Add basic bpf trampoline support"=
)
> > Closes: https://lore.kernel.org/r/202508191020.PBBh07cK-lkp@intel.com/
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   arch/loongarch/net/bpf_jit.c | 9 ++++-----
> >   1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.=
c
> > index abfdb6bb5c38..a73f6ea4ed4a 100644
> > --- a/arch/loongarch/net/bpf_jit.c
> > +++ b/arch/loongarch/net/bpf_jit.c
> > @@ -1504,11 +1504,10 @@ static int __arch_prepare_bpf_trampoline(struct=
 jit_ctx *ctx, struct bpf_tramp_i
> >       stack_size +=3D 16;
> >
> >       save_ret =3D flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FEN=
TRY_RET);
> > -     if (save_ret) {
> > -             /* Save BPF R0 and A0 */
> > -             stack_size +=3D 16;
> > -             retval_off =3D stack_size;
> > -     }
> > +     if (save_ret)
> > +             stack_size +=3D 16; /* Save BPF R0 and A0 */
> > +
> > +     retval_off =3D stack_size;
>
> Just init retval_off as 0 at the beginning of this function?
> What is the difference? which is better?
This patch is more like ARM64 does.

In addition, if save_ret is true, "init retval_off as 0" causes
retval_off to be evaluated twice, while this patch is only evaluated
once. But surely this is not a big deal.

Huacai

>
> Thanks,
> Tiezhu
>

