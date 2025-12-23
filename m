Return-Path: <bpf+bounces-77332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BE2CD7DB0
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 03:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F0BBA300647B
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 02:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED09231A23;
	Tue, 23 Dec 2025 02:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wr0HsvVg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63AD218AB9
	for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 02:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766456607; cv=none; b=GjSrbr0+2422s82qPslRd5w5EWqSpT20BU8BupBsTfg/ZCAmW6Y3C8GYMk2n5cHCBEaB7uBjLucQxY+p25CToBDBN74W6tkxUOkW5Y0YGh7KXvuvBuzD9zc2KJ3fsc3ivR3W1W8i2vTlruhMq3+mx5CaqygKhRElMp8GFNSt8hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766456607; c=relaxed/simple;
	bh=pBzySd4Ox634GIKJpFixdpWuyO/RI9myMWRFhRp2X/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQ6oT8QLPyX7QVA4hGMtGxia2B/i9Tpta/k4/Hmqe2KaDqayMHj/TSI4TF4Di8eHmvjbEvbtv0YO0CwdVQ09Nv/iFsOzm1Cv44i+MNVSqEVcEvwW95u65WWK9ipAmsq1fc8q4va1sjq2y3TlnqKrCbg7omG3US8LS3Jja/nPqvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wr0HsvVg; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7c6e9538945so3784975a34.1
        for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 18:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766456603; x=1767061403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLeu/y61Z0yAvO3yDOpGOWyvHRNl3Gfwdr22wfFgq/s=;
        b=Wr0HsvVgRMmaq7cDrPiqjgbCBzRC0lzgZ0YObaMiGk2VD+wkiziRr3RVbzY/qEfTok
         j+Jyo6FodMd5t+0Er2LBl3HNLwK4/wJg26J955pv2cq97oWA/BB6233F23lAYu9CXtEp
         sS3CJPaVKODq3qYxREWxA7hH+qjHhTiJBoqkbzidELEtlF/tpk93xuLU1W7QhY7/G7i2
         SE4Sg+oZ+iGLhxOBKqZGFUfTNDiuQjK4LyjHD/+n3A0Ohu5eSTNLcUMuS4ER/WQtUqij
         RYUhtwWuG124jRvNR1r9OxyozEbc8FAIUQMiAsp2M+v7winKkbNH3OO3T5+YWJZoI5n9
         hD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766456603; x=1767061403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iLeu/y61Z0yAvO3yDOpGOWyvHRNl3Gfwdr22wfFgq/s=;
        b=C4ErJiRFPkKF0hWCCpF9Gy+s9pJ/DG7A7M3OhNADFJnQ7/wCCz8ehQVviu/SehLorZ
         cXkEOuCX6lotprSclPJ7eBCp/NyNNkKZAlH0JnPQG58S3zU4FxlnzISXajTp7UMg2uA1
         n4ZfYO8ZIdDFFPO0LA490fN5zB0TnVIkgdqWxLuOUI4JGfeMtzrLes2+/thHjluXmjHC
         WaRjpbv+TZaIHkc3aPlmSv6F71D0DY0hoyguomDryM6Qhm/8MAPXGcsctFvqXmEelqPS
         BWKqAmp0to+zoZyzdIJ2S5t1jLXNaub2oYtaHAIr0AFCUvh+1Gu5V23MlAKzDaakYmdh
         b3Qw==
X-Forwarded-Encrypted: i=1; AJvYcCXVkCs+Xd4rRlCEDCLgCQ+WN4yTl3wtjaCFXMBrpg3gqh0QJbXNI9mrtMcBStYe6umUcQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNpYBYimT7YrcTSt4Qopcodag0d0KrjiRD7rvmlYMrnBJT1UYi
	+60tkqWQWbdWro2A69NDBrA1UJp83YmeMH43Q8BQNPiHMKWcpAoTIg8q31Cr1ljSyptYXbob6Pl
	qoXUAYCNYdDgVxKXLBW0WYFhenSF2lqs=
X-Gm-Gg: AY/fxX5CO77Onz+mou6BbZ00Gh8wHYmaKuDFmpwfzzUdNpHpxNi4EqkH+NK7SKmkO72
	1wD/mY4JyPnN4c1kvlUvPaonqeXKMRrS4SLyCmNmGOtRyk3ZlFOmtkTze8gnTO2c7wMxZRw27k7
	k772RitrjVUTOZ1mg9r6+1azSwyvyARY58fSgL0wAmc4GMY39ocG6eKeQlVisyzzGye6WmkULhQ
	R0r3w0icGiXzDBWNrq584huGpSaiHKO0V1oDty6PTsespXwTXQ1pnNaQkLmC5cDahNtd28=
X-Google-Smtp-Source: AGHT+IFYQ6TY1JvCD6/8ugUJPzSmdfqJx5SrIx00DO6YDE/XWcIW+afoGh0b2CfnLL+rZrcCv5sxoixO7SufMxtT7Zg=
X-Received: by 2002:a4a:a60a:0:b0:659:9a49:8ef3 with SMTP id
 006d021491bc7-65d0e3dbf8fmr4021479eaf.39.1766456603527; Mon, 22 Dec 2025
 18:23:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217061435.802204-1-duanchenghao@kylinos.cn>
 <20251217061435.802204-7-duanchenghao@kylinos.cn> <CAEyhmHRbacxpfTkPJq4MerBupH0bJkFfx8xGUvHMvGOzDDJUow@mail.gmail.com>
 <20251222015010.GA119291@chenghao-pc>
In-Reply-To: <20251222015010.GA119291@chenghao-pc>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Tue, 23 Dec 2025 10:23:12 +0800
X-Gm-Features: AQt7F2r1vCQijeU9b5DREgugKrd94kf6gaE7wPwDz-Jur_-FY6Ndtz9WhSQy1Mc
Message-ID: <CAEyhmHRkW67wiz_JX0i+sf2Y5LoYnpmTSt_Dh+asU8EEVTdk=w@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] LoongArch: BPF: Enhance the bpf_arch_text_poke() function
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: yangtiezhu@loongson.cn, rostedt@goodmis.org, mhiramat@kernel.org, 
	mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, 
	zhangtianyang@loongson.cn, masahiroy@kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, bpf@vger.kernel.org, youling.tang@linux.dev, 
	jianghaoran@kylinos.cn, vincent.mc.li@gmail.com, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 9:50=E2=80=AFAM Chenghao Duan <duanchenghao@kylinos=
.cn> wrote:
>
> On Sat, Dec 20, 2025 at 10:07:25PM +0800, Hengqi Chen wrote:
> > On Wed, Dec 17, 2025 at 2:15=E2=80=AFPM Chenghao Duan <duanchenghao@kyl=
inos.cn> wrote:
> > >
> > > Enhance the bpf_arch_text_poke() function to enable accurate location
> > > of BPF program entry points.
> > >
> > > When modifying the entry point of a BPF program, skip the move t0, ra
> > > instruction to ensure the correct logic and copy of the jump address.
> > >
> > > Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> > > ---
> > >  arch/loongarch/net/bpf_jit.c | 15 ++++++++++++++-
> > >  1 file changed, 14 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_ji=
t.c
> > > index 3dbabacc8856..0c16a1b18e8f 100644
> > > --- a/arch/loongarch/net/bpf_jit.c
> > > +++ b/arch/loongarch/net/bpf_jit.c
> > > @@ -1290,6 +1290,10 @@ int bpf_arch_text_poke(void *ip, enum bpf_text=
_poke_type old_t,
> > >                        void *new_addr)
> >
> > The signature of bpf_arch_text_poke() was changed in v6.19 ([1]), pleas=
e rebase.
> >
> >   [1]: https://github.com/torvalds/linux/commit/ae4a3160d19cd16b874737e=
bc1798c7bc2fe3c9e
>
> Thank you for your review and for pointing out the API change in v6.19.
>
> I believe my patch series already accounts for this. It was developed on
> top of commit ae4a3160d19c ("bpf: specify the old and new poke_type for b=
pf_arch_text_poke"),
> so all modifications to bpf_arch_text_poke() call sites within my
> patches should already be using the updated signature.

Fine, it seems like the LoongArch tree is not up-to-date.

>
> Please let me know if you find any inconsistencies or if further
> adjustments are needed.
>
> Best regards,
> Chenghao
>
> >
> > >  {
> > >         int ret;
> > > +       unsigned long size =3D 0;
> > > +       unsigned long offset =3D 0;
> > > +       char namebuf[KSYM_NAME_LEN];
> > > +       void *image =3D NULL;
> > >         bool is_call;
> > >         u32 old_insns[LOONGARCH_LONG_JUMP_NINSNS] =3D {[0 ... 4] =3D =
INSN_NOP};
> > >         u32 new_insns[LOONGARCH_LONG_JUMP_NINSNS] =3D {[0 ... 4] =3D =
INSN_NOP};
> > > @@ -1297,9 +1301,18 @@ int bpf_arch_text_poke(void *ip, enum bpf_text=
_poke_type old_t,
> > >         /* Only poking bpf text is supported. Since kernel function e=
ntry
> > >          * is set up by ftrace, we rely on ftrace to poke kernel func=
tions.
> > >          */
> > > -       if (!is_bpf_text_address((unsigned long)ip))
> > > +       if (!__bpf_address_lookup((unsigned long)ip, &size, &offset, =
namebuf))
> > >                 return -ENOTSUPP;
> > >
> > > +       image =3D ip - offset;
> > > +       /* zero offset means we're poking bpf prog entry */
> > > +       if (offset =3D=3D 0)
> > > +               /* skip to the nop instruction in bpf prog entry:
> > > +                * move t0, ra
> > > +                * nop
> > > +                */
> > > +               ip =3D image + LOONGARCH_INSN_SIZE;
> > > +
> > >         is_call =3D old_t =3D=3D BPF_MOD_CALL;
> > >         ret =3D emit_jump_or_nops(old_addr, ip, old_insns, is_call);
> > >         if (ret)
> > > --
> > > 2.25.1
> > >

