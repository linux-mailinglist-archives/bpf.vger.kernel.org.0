Return-Path: <bpf+bounces-67378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9C8B42F5B
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 04:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF0B63BB33F
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 02:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90531CEAB2;
	Thu,  4 Sep 2025 02:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAvXcc19"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7F072618
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 02:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756951814; cv=none; b=tN/OXMTjpO6lgvCicaTFpNE5yMQc+QpF83SHfQd82pSpQuRuvQKtStVNjquUq6IlNV5Qiw0I3rgWW5ZjBPeowUp8OV93W1KZ1tv5krgstjexoK48IzT8ByfCZeZOS4lqZwJmepTcF466cVKcOmESPPKUYdefCfD4jelMai1owF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756951814; c=relaxed/simple;
	bh=MTc2g4S451CT+5LG46/r2Ah0FmOd5F9DgiZ4ehFh6AU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEmHbxVxwG/Rjo0au4eHeP/qSwaDry1RcupWz5LMk+lh9c8gCogHZ4VmcwrOcoKeGbfnn256zf1dk3Z5lm7DfIV/z4iR41bTq7K5MugFI1uJZYHX7Id9QfcjOom76Vg9KgvfWJPoDt2+/kxNYctjpk7607/KVWt1zZsjEq4O98E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAvXcc19; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9EAC4CEF0
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 02:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756951813;
	bh=MTc2g4S451CT+5LG46/r2Ah0FmOd5F9DgiZ4ehFh6AU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uAvXcc19F/v66e3s+ajn8Ughn/C1BB841xTD1CSYdDtfbZULem9I04jdigl7RusAd
	 G863bT/uaSnvWsn71Z/qsp6QXevK87xsJyuUnJgTYh4/UmYw4U+MTWn/aLti97MT1H
	 6u+nU+q/a/oiCfAI8rAJwsOfvN2ytMoQxNE/MucrnkfH1w4pbQ3AwfF/aG3H9K0IU7
	 PPotkbOlZ0mu+zCFFN7SeuLssAeYFVZWPMIZAmTgI5sBgdDo0gudGKW5FeKY71pWsg
	 0abwWgreXrQTWg5CDO/rKUm6NZowRXlKqOp37VserIw+ktWWXa2XVted1KWUTBG0I9
	 SFccXTkObF3Iw==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b0472bd218bso93251066b.1
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 19:10:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVvP81wW1WGb+oLj282iCjxlkgriP59rpg0sG67w0Rkql/txQpxPW0KXN5YLF9ymJBRefY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpxl8Uo1uBix2t21MQvx/Ft/u/QiC49tO3TMsAsAdVdpme7hW9
	mgcaqquRhtuc9eEJu2oEvSf5DSC4WPCUY5yWQm8jV1sgiqEbZy0UM7BY/56ZnJG6BLswlnquvv8
	328OClPGC6uDFREX2Q+5KA2uUm9VIyto=
X-Google-Smtp-Source: AGHT+IFbBtwIlWpuGUbzHoeIjMpeeDISsUwEw9z/ChIeaG2TNkL8golxeGlN6kc2peOczaxwZYovfzbhOpBkGsYlsAI=
X-Received: by 2002:a17:907:980a:b0:b04:6412:9612 with SMTP id
 a640c23a62f3a-b0464129adbmr548299166b.46.1756951812372; Wed, 03 Sep 2025
 19:10:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903070113.42215-1-hengqi.chen@gmail.com> <20250903070113.42215-6-hengqi.chen@gmail.com>
 <CAAhV-H5PkWkhnBWEynxJki3rbN6rh_HW1hmVUY+ixY0Gx+ot+w@mail.gmail.com> <CAEyhmHTsnLmQy2ShLKwnsrPforzVCA0rGFs0RPQYFOkXgErcmg@mail.gmail.com>
In-Reply-To: <CAEyhmHTsnLmQy2ShLKwnsrPforzVCA0rGFs0RPQYFOkXgErcmg@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 4 Sep 2025 10:09:59 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6y8VcJCp7MRchvepBjgU=AHGb6_JZYEwF=As=rvv+XGQ@mail.gmail.com>
X-Gm-Features: Ac12FXxU278Ji3w2DDCqshLstBEqGVQxu9RSSobqzS3neEKtEBGZhHpLqOBf7_M
Message-ID: <CAAhV-H6y8VcJCp7MRchvepBjgU=AHGb6_JZYEwF=As=rvv+XGQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] LoongArch: BPF: Don't assume trampoline size is
 page aligned
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: yangtiezhu@loongson.cn, vincent.mc.li@gmail.com, hejinyang@loongson.cn, 
	loongarch@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 9:56=E2=80=AFAM Hengqi Chen <hengqi.chen@gmail.com> =
wrote:
>
> On Wed, Sep 3, 2025 at 10:56=E2=80=AFPM Huacai Chen <chenhuacai@kernel.or=
g> wrote:
> >
> > Hi, Hengqi,
> >
> > On Wed, Sep 3, 2025 at 8:06=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.c=
om> wrote:
> > >
> > > Currently, arch_alloc_bpf_trampoline() use bpf_prog_pack_alloc()
> > > which will pack multiple trampolines into a huge page. So no need
> > > to assume the trampoline size is page aligned.
> > We do the alignment because larch_insn_text_copy() changes page attrs.
> > If there is other data and BPF trampoline is in the same page,
> > changing page attrs may cause errors.
> >
>
> Doesn't stop_machine() prevent this side effect?
I don't think so.

Consider such a case: BPF trampoline and another vmalloc area share
the same page, larch_insn_text_copy() makes the whole page be "rox",
even if stop_machine() completes. But "rox" is only needed by BPF
trampoline, and the other vmalloc area isn't.

Huacai

>
> > Huacai
> >
> > >
> > > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > > ---
> > >  arch/loongarch/net/bpf_jit.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_ji=
t.c
> > > index 35b13d91a979..43628b5e1553 100644
> > > --- a/arch/loongarch/net/bpf_jit.c
> > > +++ b/arch/loongarch/net/bpf_jit.c
> > > @@ -1747,8 +1747,7 @@ int arch_bpf_trampoline_size(const struct btf_f=
unc_model *m, u32 flags,
> > >
> > >         ret =3D __arch_prepare_bpf_trampoline(&ctx, &im, m, tlinks, f=
unc_addr, flags);
> > >
> > > -       /* Page align */
> > > -       return ret < 0 ? ret : round_up(ret * LOONGARCH_INSN_SIZE, PA=
GE_SIZE);
> > > +       return ret < 0 ? ret : ret * LOONGARCH_INSN_SIZE;
> > >  }
> > >
> > >  struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> > > --
> > > 2.43.5
> > >
>

