Return-Path: <bpf+bounces-67374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E354DB42F3F
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 03:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEF5F175781
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 01:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6031DF247;
	Thu,  4 Sep 2025 01:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtEbOvPT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769224A3C
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 01:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756950846; cv=none; b=oSPJaJVKzRpfe+XABQ1sCyw5GmxCj34m1TsmiKSzgVDc15qsq+COFdpPMalnPnNGttoK2M7uFA632M/K2TZ/2dTWjcihnnRSuVDzxDn7a16JtSAr0RYEXXCCheBj9F0AvYaWBDXNetYOqCXH4UP4XpbT81tJDgm5ZhRv9wTycYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756950846; c=relaxed/simple;
	bh=Tj+11z4XCYJES/vD906UZbJqGNzTbui6Hf+3y2b205I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AXDAzuoRxbrNgvEXvO7Rm/J5hEO5OUS9HehDQieoV1q1jJCSAd7FmaO0dLT86t5Ozwmd+E1D1BicxQzQBGPoq/w7fsFJRjBBTSf0Hw0BBBRkB10mHjhgU80U2YdXAa97K6t16glIIaz/rQZ4g1xGu02qDZOdpe8L5IIkkzNXsJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtEbOvPT; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-30ccebab736so505630fac.3
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 18:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756950843; x=1757555643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIhwvpOs6iAfsYGD/+KTssMhMFixOoTwar6NTWwhAMI=;
        b=DtEbOvPTm5HNFLn9Id+xwhViFV3Al3Vk98pIO6RRSzVwnOMFTGmyYdEDx9gfoGWOQg
         8FaGmI2d1XI+ziaynDwImeybqx+rhBOTXEzC/+BsVCNrp77zFNDmfobxIce7cyYKW/B+
         BXbRkXF4HPtwJBt4cqwPrd544EzdPQwkMzHom5EO2R3ApghVmUzT6A61fhZBgIbYkemw
         v14LcPLotJUdT8mDE6AUS1dy1Kyy4zenWdeu9Hgh6eWzIUWEcXoV4OQuPuPOFLulr4up
         TORtuq7v3aPRbHacDe5DYKpFOHh0vGVKQIzmQ3KFviYQj2ZQpeMPg57UQ1ey2AtyQtua
         Mt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756950843; x=1757555643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIhwvpOs6iAfsYGD/+KTssMhMFixOoTwar6NTWwhAMI=;
        b=VXMR8Zm8r0ZPCV2tl+ZiSMXBlPtAoVby4D6KCoaeBmD2FA/Q8uSCHW8F3VP4p9/d1Y
         RN4LqyMCYfDLWoyl6HFXTDjxCYhxfgW1RSCDKomjjjkwCPJ2mJ77kynTPBdKUvd61sUI
         eXTf5FPxf5Y1cWv4HN2S6xQMR+NfA/zt/DJK9yMxTeVZfuMmGJit85SiB1mW8MhrW6bN
         5TApCgBRL2ktyjx4U+LOwwynDU9BJdi5tlWLlqCsowZiyr1c2eaghGkE0aaOKcFOBI8U
         ypwSt5UGCFuxAIhKYNRtQRHi42kVdg4sBqU3NSbPPEHFbmT3AxvqlUwgcX/9vKZNbj+1
         5+jg==
X-Forwarded-Encrypted: i=1; AJvYcCVTHbEqT8URwIjQKSM98Un9p+XtQW+HKx1f8qIL9yp1LFF/1Eu5oKCuOEdasbDO6XrZzrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYTRHAF9G4FHz9GK6w5cAh3i0Nf9ntkxNFIIEZ/FKID8dzUwOv
	aSv9mWVp3OapCH2ykLSjCYozx18H+f9zZdQ3oVmPQjMEniXk1coftFS+7qdLSGq2Tfx9rOetINb
	PNNXdGKu666rC2AozdMZuKG1HXdHI5To=
X-Gm-Gg: ASbGncvJoeP90E5g0BMSgqHs3697gzpU5ZHNVMmG7HnnFzotykFF0lxD99aG4wNHwSi
	210Rqzwv5IGxkB3FgqG+XhykA4w6twcL1IvrYJ0DM0YiXJ3kNO5G23hGAzXRrptIuyo8tcZeeaW
	PzUrG1N2FXUfzJMjW4hCTLyvrICO6eJgTilDXpp9FhsX0qvKCoHLc6mvDFmwR3JM18NpTWnCQT4
	d/uimg=
X-Google-Smtp-Source: AGHT+IHQiI1nk38c3yMkgnN8We4qjWiln1DzH1T28R8vIJcMDb6jIJDCFkPNPGlzbOc1VkWs9+jyOEm9vnqB0pzVA+Q=
X-Received: by 2002:a05:6871:9e22:b0:319:cad9:c6e5 with SMTP id
 586e51a60fabf-319cad9d164mr3175893fac.25.1756950843558; Wed, 03 Sep 2025
 18:54:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903070113.42215-1-hengqi.chen@gmail.com> <20250903070113.42215-5-hengqi.chen@gmail.com>
 <CAAhV-H4ZCM7uRB_oe__pJB_a1ei4+SPnVfT6c0JXvk4-HJg=bg@mail.gmail.com>
In-Reply-To: <CAAhV-H4ZCM7uRB_oe__pJB_a1ei4+SPnVfT6c0JXvk4-HJg=bg@mail.gmail.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Thu, 4 Sep 2025 09:53:52 +0800
X-Gm-Features: Ac12FXwZBwciCgn7fjX2RHc82mL3VfYF6oDWKN86u4UsOIQ1xj_0IXf9kYwJz84
Message-ID: <CAEyhmHTwEjsJp+roXOFLTEkDbVcKUU8PC=ba2JfvLZ29B2ZffA@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] LoongArch: BPF: No text_poke() for kernel text
To: Huacai Chen <chenhuacai@kernel.org>
Cc: yangtiezhu@loongson.cn, vincent.mc.li@gmail.com, hejinyang@loongson.cn, 
	loongarch@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 10:52=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> Hi, Hengqi,
>
> On Wed, Sep 3, 2025 at 8:06=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com=
> wrote:
> >
> > The current implementation of bpf_arch_text_poke() requires 5 nops
> > at patch site which is not applicable for kernel/module functions.
> > With CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=3Dy, this can be done
> > by ftrace instead.
> Does this mean BPF trampoline can only work with FTRACE enabled?
>

IIUC, with CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=3Dn, we could still trac=
e
BPF progs with BPF trampoline.

> Huacai
>
> >
> > See the following commit for details:
> >   * commit b91e014f078e ("bpf: Make BPF trampoline use register_ftrace_=
direct() API")
> >   * commit 9cdc3b6a299c ("LoongArch: ftrace: Add direct call support")
> >
> > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > ---
> >  arch/loongarch/net/bpf_jit.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.=
c
> > index 7b7e449b9ea9..35b13d91a979 100644
> > --- a/arch/loongarch/net/bpf_jit.c
> > +++ b/arch/loongarch/net/bpf_jit.c
> > @@ -1294,8 +1294,11 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_p=
oke_type poke_type,
> >         u32 old_insns[LOONGARCH_LONG_JUMP_NINSNS] =3D {[0 ... 4] =3D IN=
SN_NOP};
> >         u32 new_insns[LOONGARCH_LONG_JUMP_NINSNS] =3D {[0 ... 4] =3D IN=
SN_NOP};
> >
> > -       if (!is_kernel_text((unsigned long)ip) &&
> > -               !is_bpf_text_address((unsigned long)ip))
> > +       if (!is_bpf_text_address((unsigned long)ip))
> > +               /* Only poking bpf text is supported. Since kernel func=
tion
> > +                * entry is set up by ftrace, we reply on ftrace to pok=
e kernel
> > +                * functions.
> > +                */
> >                 return -ENOTSUPP;
> >
> >         ret =3D emit_jump_or_nops(old_addr, ip, old_insns, is_call);
> > --
> > 2.43.5
> >

