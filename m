Return-Path: <bpf+bounces-53918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FFEA5E3D2
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 19:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92CA19C0306
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 18:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F531E6DC5;
	Wed, 12 Mar 2025 18:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5xl8SJJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720951C84AA
	for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 18:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741805278; cv=none; b=Jq4fqTzss5QNi0DI0fXmHkdxyI5cxKq9GA4d/zLFutU+nMeXOUQEQRYHhIt9jDfB4cHR6g/Cb2jWnzT3+2GCGGxzDuiyEWQ2oc8etCKTmfbeABsX/8fi7uy+kH9h9RjKSQ8yhnU55E2/dBLjqWfa7kxDfGfy9eBBAEKY3lPLHlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741805278; c=relaxed/simple;
	bh=sonuE/nU+B7a2+IUvb2Ngy7fSXRtZ/N9dsuIDwh2Ka4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9VpDhj8RQbvkN9d0SYekdabwzbZbNiGduGyLRDs2vWv4HDMm6vLfLwtWqZV4dj/+/VvlywfosSXqB7048qfJD5ZJxTc8ydfFDcwQB+wQPKfqDsfqCjN9qofniSLmz62dZ+vrPYBfVKDvGCFipvRB4OSylSOKw0or7RkDMkXXCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5xl8SJJ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ff69365e1dso362706a91.3
        for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 11:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741805277; x=1742410077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3+uniA3WbVBR449DfdHBTJY/qTSju1IIQiXlJJSAbE=;
        b=O5xl8SJJM/Xumud8CUgIyuuUfQYmRTgbvo27vcrRUcjdGJOBbFpIgxGTVgmoSeK/Nl
         thitDx9bJ2KW5yuJSsVuTl2ozAhzyuvZ18gzINX42SBjV0Mfx4byZuAnt+DcM+orAKRf
         V1Bsji9Bz1JtIgBtPLdmuZFVjpgh9L2TZmOwiSyrotW4QKgovbjwoKQJSHEcrPgESsN3
         RHmjjzFUc6Z393BqFHJdpou5quXBj3QdGkfPTCMo5Z6lxCYxZZiOaRN/lYImpqTTz9Xk
         hnXtF8wy9BVCI0Hzj7MXA0B6n1wr7C6+d2iyqY9HfeQzY5v3b5h42j1MB40kEsDcvEo+
         aMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741805277; x=1742410077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3+uniA3WbVBR449DfdHBTJY/qTSju1IIQiXlJJSAbE=;
        b=WOB+GuxZM36p/+07uLXNhKS1IPILp33PLKV8ew5ynk54EJwcJsZr8b7xOHMOjEZt5D
         /pdVJe1BiM7YwYdMcLadyTqw+3i/qcl/cAPCdTYxSTjEv+9brR2yhhqnYt/yHXk98pHG
         m/jH7KiUgmut4ZW4SdVgO+8jcAKGDG3Eji9ez41s4LNAudstxkSnrrON/JXaMZGcSUCa
         s+bPqe5X5VBP4oA/vkZ8DRgXnM63eOjBem5mZoYWu8ONj5pUxJfeiq/T3XR98xjZg6j1
         PrXMgI0yzCWBVfi4baIWebigr8WMslyQLlcPOUpEXXRZ2WnPqjLGxC6YB+o09HnNBwwI
         gikw==
X-Forwarded-Encrypted: i=1; AJvYcCWoiIMUUDYnv/VwZcuzBkKOqQr95qVXzAvmJjbOzPUuv4Sm9mD42XeC6AeDnLKoSXCgqIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyliClzrut7u2geGfH2gG8h2NXYCRohszjAg6KzvgvCIDzlsvmD
	Fqesd/CLMMaDKByQgg0YxzFaYAqJusg/H+0pwwQapnbtMiEdLYfrjbVK27ZC9VOpINOIDm5uXEE
	XleKBtQYP/nkxWXgAZ8Qm2HN+dotwawtc
X-Gm-Gg: ASbGncvAxNWzBz5tO60JHVZvsS1fGU8THxwIpsInUFmNJoPrVOEkBnw7GO33gzcHj5J
	AcFDDWBok5OIWuFtqicNHbw098UEFeIgZZ2K+8/1ID53BzcGYs6JU6wjAkJEKDfblNTUpA18Kry
	yz0Lpt8c/NieIlv+a+Thj2aPi+RqWymn08pKFlhAJgTA==
X-Google-Smtp-Source: AGHT+IFJAJVqV6NuDJQJea+iFMHvH7tcd9ot0Cu9g41LukR+mV6RWAWNMnuFh7IWadmH9xImJpdl1E1hlaSFfouG+UE=
X-Received: by 2002:a17:90a:7785:b0:301:1d9f:4ba2 with SMTP id
 98e67ed59e1d1-3011d9f4c1cmr3921543a91.28.1741805276661; Wed, 12 Mar 2025
 11:47:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307140120.1261890-1-hengqi.chen@gmail.com>
 <10239917-2cbe-434e-adc5-69c3f3e66e36@linux.dev> <CAEyhmHT+DZDjXixnWgCq028K7KZ84bWHY1+Kv9bjJAQW9vryHQ@mail.gmail.com>
In-Reply-To: <CAEyhmHT+DZDjXixnWgCq028K7KZ84bWHY1+Kv9bjJAQW9vryHQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 12 Mar 2025 11:47:44 -0700
X-Gm-Features: AQ5f1JqYMTPlSSEsefj29uehRq4kxQB2pep1uUjkHFFS0p-fOcQIMGUHAlUF48c
Message-ID: <CAEf4BzbAi-g-jyFoHdXHNfOT3DLTnKN1XioPhR=XYJnM7+_VOQ@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Fix uprobe offset calculation
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, andrii@kernel.org, 
	eddyz87@gmail.com, deso@posteo.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 10:16=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com=
> wrote:
>
> Hi Yonghong,
>
> On Sat, Mar 8, 2025 at 2:48=E2=80=AFPM Yonghong Song <yonghong.song@linux=
.dev> wrote:
> >
> >
> >
> > On 3/7/25 6:01 AM, Hengqi Chen wrote:
> > > As reported on libbpf-rs issue([0]), the current implementation
> > > may resolve symbol to a wrong offset and thus missing uprobe
> > > event. Calculate the symbol offset from program header instead.
> > > See the BCC implementation (which in turn used by bpftrace) and
> > > the spec ([1]) for references.
> > >
> > >    [0]: https://github.com/libbpf/libbpf-rs/issues/1110
> > >    [1]: https://refspecs.linuxfoundation.org/elf/
> > >
> > > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> >
> > Hengqi,
> >
> > There are some test failures in the CI. For example,
> >    https://github.com/kernel-patches/bpf/actions/runs/13725803997/job/3=
8392284640?pr=3D8631
> >
>
> Yes, I've received an email from BPF CI.
> It seems like the uprobe multi testcase is unhappy with this change.
>
> > Please take a look.
> > Your below elf_sym_offset change matches some bcc implementation, but
> > maybe maybe this is only under certain condition?
> >
>
> Remove the `phdr.p_flags & PF_X` check fix the issue. Need more investiga=
tion.
>
> > Also, it would be great if you can add detailed description in commit m=
essage
> > about what is the problem and why a different approach is necessary to
> > fix the issue.
> >
>
> Will do. Thanks.
>
> > > ---
> > >   tools/lib/bpf/elf.c | 32 ++++++++++++++++++++++++--------
> > >   1 file changed, 24 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> > > index 823f83ad819c..9b561c8d1eec 100644
> > > --- a/tools/lib/bpf/elf.c
> > > +++ b/tools/lib/bpf/elf.c
> > > @@ -260,13 +260,29 @@ static bool symbol_match(struct elf_sym_iter *i=
ter, int sh_type, struct elf_sym
> > >    * for shared libs) into file offset, which is what kernel is expec=
ting
> > >    * for uprobe/uretprobe attachment.
> > >    * See Documentation/trace/uprobetracer.rst for more details. This =
is done
> > > - * by looking up symbol's containing section's header and using iter=
's virtual
> > > - * address (sh_addr) and corresponding file offset (sh_offset) to tr=
ansform
> > > + * by looking up symbol's containing program header and using its vi=
rtual
> > > + * address (p_vaddr) and corresponding file offset (p_offset) to tra=
nsform
> > >    * sym.st_value (virtual address) into desired final file offset.
> > >    */
> > > -static unsigned long elf_sym_offset(struct elf_sym *sym)
> > > +static unsigned long elf_sym_offset(Elf *elf, struct elf_sym *sym)
> > >   {
> > > -     return sym->sym.st_value - sym->sh.sh_addr + sym->sh.sh_offset;
> > > +     size_t nhdrs, i;
> > > +     GElf_Phdr phdr;
> > > +
> > > +     if (elf_getphdrnum(elf, &nhdrs))
> > > +             return -1;
> > > +
> > > +     for (i =3D 0; i < nhdrs; i++) {
> > > +             if (!gelf_getphdr(elf, (int)i, &phdr))
> > > +                     continue;
> > > +             if (phdr.p_type !=3D PT_LOAD || !(phdr.p_flags & PF_X))
> > > +                     continue;
> > > +             if (sym->sym.st_value >=3D phdr.p_vaddr &&
> > > +                 sym->sym.st_value < (phdr.p_vaddr + phdr.p_memsz))
> > > +                     return sym->sym.st_value - phdr.p_vaddr + phdr.=
p_offset;

Hengqi,

Can you please provide an example where existing code doesn't work? I think=
 that

sym->sym.st_value - sym->sh.sh_addr + sym->sh.sh_offset

and

sym->sym.st_value - phdr.p_vaddr + phdr.p_offset


Should result in the same, and we don't need to search for a matching
segment if we have an ELF symbol and its section. But maybe I'm
mistaken, so can you please elaborate a bit?

> > > +     }
> > > +
> > > +     return -1;
> > >   }
> > >
> > >   /* Find offset of function name in the provided ELF object. "binary=
_path" is
> > > @@ -329,7 +345,7 @@ long elf_find_func_offset(Elf *elf, const char *b=
inary_path, const char *name)
> > >
> > >                       if (ret > 0) {
> > >                               /* handle multiple matches */
> > > -                             if (elf_sym_offset(sym) =3D=3D ret) {
> > > +                             if (elf_sym_offset(elf, sym) =3D=3D ret=
) {
> > >                                       /* same offset, no problem */
> > >                                       continue;
> > >                               } else if (last_bind !=3D STB_WEAK && c=
ur_bind !=3D STB_WEAK) {
> >
> > [...]
> >

