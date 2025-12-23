Return-Path: <bpf+bounces-77355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3003CD87C5
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 09:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFF863043929
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 08:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AD232277B;
	Tue, 23 Dec 2025 08:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJ483G2+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9AA2DFA32
	for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 08:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766479756; cv=none; b=f/0a9UFzoGRyosgKe3NgEtr4rfB8nGqHdO0OecoFNk9mTxc8Gq3SDTAkRrKQ4hRkrJfFTF+nZhpWxLqA0GVnYScJsfTf7W7cENbe11AClZoSunKTe96iHzfZ2S22zXrVv4zg3pbuSWf3PBpOBkW5hfOgWe+qXASpJ+1JQ1X4+gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766479756; c=relaxed/simple;
	bh=uMPdjFR3AUHODA1yruGTL+xnrZMVCFfKoSwes/LbfHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aGcyvnQL4VpfFQ3Hm3QR/kaMgwt4a7CGcbM1QKvDdAVkXQu95EE4RGHiQLtPZCw50CxVvOKme6RFoV2IM0/eSy6F8qF5iIcdMWdhwUq6jUG79Vk6inCy+1aU8+NNOg7Yuu/2kPl2eFBhP8VYv42Pfq0vByLvbvMuMfCTNDNUfTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJ483G2+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F03C19424
	for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 08:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766479756;
	bh=uMPdjFR3AUHODA1yruGTL+xnrZMVCFfKoSwes/LbfHE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VJ483G2+ZySmqHB4Q1NPQUS2U+BHMOl0/9HDViAwAcKG33qYpNjrq8ReIYRNvF2tW
	 y6/DgPrWaYN7wTB+LD7RZGasHewhybUpEvkpOKl74AwGuSLFUf/oCjyf8dLGnHAgHz
	 D9Dh4uEg/dEbaEfkwns8sJ3QioDUn7el0+Hse+YIoL0rduBsWA1pufRY1RJ1TfOciz
	 KeNVErkULRHT8hPDK2MWsVnvSPS4QpV4oMap3VZGm69uxUj34Mha9gTq/ePRwffpWZ
	 1z5p2JOga6mBeml93tqIkVk2FqR3ih6sh8K+uRCgg1kbNcDemtJRA9CLImR0SAMpfX
	 qtJgPppqoopeQ==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6418b55f86dso6410448a12.1
        for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 00:49:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX2+dHtTIFNAmIdTFVFNlZklXdf07qBoORHzD/pI8eSq2k9yqkG1QaqvnL+tCd2FKSwJgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx39FBNDRuxVp91mdQV2oyq87nyuBTaGa9EMUGAVWoVHMNIeKwF
	b5IrgF4GFP9IPwRL7B/EQBd7vpLkzDQ2LC00QzbKn9+yahg8oONHATtjxsDLBNGZf+ReIFm2iW+
	qWU/hw0hGSiiqwO+xh07VPkBaX/YbsME=
X-Google-Smtp-Source: AGHT+IGqICKA6Tt0g8gdCDQ5skcFxPNmflpiNOGftMkEGt7c41HtMhVaOn2SEP7jhGrIAw6lkvDjXUUHiFwAyoNuylk=
X-Received: by 2002:a17:907:980f:b0:b73:8b79:a322 with SMTP id
 a640c23a62f3a-b8036f1222emr1491784766b.11.1766479754647; Tue, 23 Dec 2025
 00:49:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217061435.802204-1-duanchenghao@kylinos.cn>
 <20251217061435.802204-7-duanchenghao@kylinos.cn> <CAEyhmHRbacxpfTkPJq4MerBupH0bJkFfx8xGUvHMvGOzDDJUow@mail.gmail.com>
 <20251222015010.GA119291@chenghao-pc> <CAEyhmHRkW67wiz_JX0i+sf2Y5LoYnpmTSt_Dh+asU8EEVTdk=w@mail.gmail.com>
In-Reply-To: <CAEyhmHRkW67wiz_JX0i+sf2Y5LoYnpmTSt_Dh+asU8EEVTdk=w@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 23 Dec 2025 16:49:30 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4cutccVGOmvHjMF3NaGEYqdTYa6-eqz39bO+U-HgO1-Q@mail.gmail.com>
X-Gm-Features: AQt7F2oKz5REz7f5rWcYliHHB6z3xEFCgbSsFXHZ5UfkPwEWshKkES1HPpR325Y
Message-ID: <CAAhV-H4cutccVGOmvHjMF3NaGEYqdTYa6-eqz39bO+U-HgO1-Q@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] LoongArch: BPF: Enhance the bpf_arch_text_poke() function
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: Chenghao Duan <duanchenghao@kylinos.cn>, yangtiezhu@loongson.cn, rostedt@goodmis.org, 
	mhiramat@kernel.org, mark.rutland@arm.com, kernel@xen0n.name, 
	zhangtianyang@loongson.cn, masahiroy@kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, bpf@vger.kernel.org, youling.tang@linux.dev, 
	jianghaoran@kylinos.cn, vincent.mc.li@gmail.com, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 10:23=E2=80=AFAM Hengqi Chen <hengqi.chen@gmail.com=
> wrote:
>
> On Mon, Dec 22, 2025 at 9:50=E2=80=AFAM Chenghao Duan <duanchenghao@kylin=
os.cn> wrote:
> >
> > On Sat, Dec 20, 2025 at 10:07:25PM +0800, Hengqi Chen wrote:
> > > On Wed, Dec 17, 2025 at 2:15=E2=80=AFPM Chenghao Duan <duanchenghao@k=
ylinos.cn> wrote:
> > > >
> > > > Enhance the bpf_arch_text_poke() function to enable accurate locati=
on
> > > > of BPF program entry points.
> > > >
> > > > When modifying the entry point of a BPF program, skip the move t0, =
ra
> > > > instruction to ensure the correct logic and copy of the jump addres=
s.
> > > >
> > > > Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> > > > ---
> > > >  arch/loongarch/net/bpf_jit.c | 15 ++++++++++++++-
> > > >  1 file changed, 14 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_=
jit.c
> > > > index 3dbabacc8856..0c16a1b18e8f 100644
> > > > --- a/arch/loongarch/net/bpf_jit.c
> > > > +++ b/arch/loongarch/net/bpf_jit.c
> > > > @@ -1290,6 +1290,10 @@ int bpf_arch_text_poke(void *ip, enum bpf_te=
xt_poke_type old_t,
> > > >                        void *new_addr)
> > >
> > > The signature of bpf_arch_text_poke() was changed in v6.19 ([1]), ple=
ase rebase.
> > >
> > >   [1]: https://github.com/torvalds/linux/commit/ae4a3160d19cd16b87473=
7ebc1798c7bc2fe3c9e
> >
> > Thank you for your review and for pointing out the API change in v6.19.
> >
> > I believe my patch series already accounts for this. It was developed o=
n
> > top of commit ae4a3160d19c ("bpf: specify the old and new poke_type for=
 bpf_arch_text_poke"),
> > so all modifications to bpf_arch_text_poke() call sites within my
> > patches should already be using the updated signature.
>
> Fine, it seems like the LoongArch tree is not up-to-date.
LoongArch tree now updated to 6.19-rc2, hope patches can be applied cleanly=
.

Huacai

>
> >
> > Please let me know if you find any inconsistencies or if further
> > adjustments are needed.
> >
> > Best regards,
> > Chenghao
> >
> > >
> > > >  {
> > > >         int ret;
> > > > +       unsigned long size =3D 0;
> > > > +       unsigned long offset =3D 0;
> > > > +       char namebuf[KSYM_NAME_LEN];
> > > > +       void *image =3D NULL;
> > > >         bool is_call;
> > > >         u32 old_insns[LOONGARCH_LONG_JUMP_NINSNS] =3D {[0 ... 4] =
=3D INSN_NOP};
> > > >         u32 new_insns[LOONGARCH_LONG_JUMP_NINSNS] =3D {[0 ... 4] =
=3D INSN_NOP};
> > > > @@ -1297,9 +1301,18 @@ int bpf_arch_text_poke(void *ip, enum bpf_te=
xt_poke_type old_t,
> > > >         /* Only poking bpf text is supported. Since kernel function=
 entry
> > > >          * is set up by ftrace, we rely on ftrace to poke kernel fu=
nctions.
> > > >          */
> > > > -       if (!is_bpf_text_address((unsigned long)ip))
> > > > +       if (!__bpf_address_lookup((unsigned long)ip, &size, &offset=
, namebuf))
> > > >                 return -ENOTSUPP;
> > > >
> > > > +       image =3D ip - offset;
> > > > +       /* zero offset means we're poking bpf prog entry */
> > > > +       if (offset =3D=3D 0)
> > > > +               /* skip to the nop instruction in bpf prog entry:
> > > > +                * move t0, ra
> > > > +                * nop
> > > > +                */
> > > > +               ip =3D image + LOONGARCH_INSN_SIZE;
> > > > +
> > > >         is_call =3D old_t =3D=3D BPF_MOD_CALL;
> > > >         ret =3D emit_jump_or_nops(old_addr, ip, old_insns, is_call)=
;
> > > >         if (ret)
> > > > --
> > > > 2.25.1
> > > >
>

