Return-Path: <bpf+bounces-13881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1DB7DEA97
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 03:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8CE01C20E56
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 02:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7F815D4;
	Thu,  2 Nov 2023 02:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoBQVFfe"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC2610F9
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 02:16:24 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF32A12B
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 19:16:21 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c6b30aca06so5591361fa.3
        for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 19:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698891380; x=1699496180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UC5nCVX0yqhYljyZNvdqoQ+V8liHCfIR3TxLl/R3230=;
        b=eoBQVFfeSgdvFew/ihhA67SLBuunyOTgTmllZ5Y9/YwvKykIIHz+UqTrFhrlzC1UEU
         FWLDXlCUfer/E3mxY6b3Z5pQnk+32w3miczc2jhFgo/sBenc/64JtKvhY4IbVsz7qYrp
         UWAaQ6CFcV169zFyl/cXEi9Asz3ur+gcAcn8cBACJxVtD/6TXao6yfr0Z7XY9KBN+TTR
         TRWTaNo7qL4ScHfGcTzfwxi48B+LtraSMV7hrS0ke7B1YlfElvMGVxOLPUrijM6tSIl4
         hiR4jF6PE2xJq3aVz3GZ8Z+Z4VgeQ3Wirc9ERVEu7hNWeczIb2pWsn8cJllJm9bCsatm
         Y58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698891380; x=1699496180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UC5nCVX0yqhYljyZNvdqoQ+V8liHCfIR3TxLl/R3230=;
        b=XXyT+ZDBFySz5MQfXXac8dR/cpZa1AEar07AGusHyNwPH8cR1OFax7TEe5pKHuW0wf
         RH61Av2m8xz3VlTxdx0hP5YllCmZ0I70J3jRD77Fgncf7VTBS7JZxdqUpS09zggEZ0CA
         cFm59XP6ON+87csfFpg1ZHKuKUpL3+9pk9ARfDySm39B83yH5fICnS8no561N6/X28L6
         hoadbYu9nSL4JQhHa0xO5cSqkRPgKSfYnOiESDo8Wv5OpKcFkOqxSX7DcR2gAm7JXN0B
         pe7nGC/pU35Dczms7xCvccgHrvlyraZz47ZvXzykXOC7aFYq0EV9yBraBIYuJOdegLC2
         FW+g==
X-Gm-Message-State: AOJu0YzvkdZj+kT/YH3w3TznSr7J30mLcW3LRog8Ct9XjGtsRHvN+IZr
	9o6vjNGJQuSspcn66WJaOc8pqtjMtEhJGynYaJc=
X-Google-Smtp-Source: AGHT+IGVuMrJgZxCCpL2X4lkJonx4+/Bsk7eS9dy3qswSwWTYE4ko+Xf1fi3yu37A2y9aP0/EMrL2llKgzMnBcNOb1k=
X-Received: by 2002:a19:c211:0:b0:507:975f:6ccb with SMTP id
 l17-20020a19c211000000b00507975f6ccbmr11439022lfc.2.1698891379677; Wed, 01
 Nov 2023 19:16:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN+4W8h3yDjkOLJPiuKVKTpj_08pBz8ke6vN=Lf8gcA=iYBM-g@mail.gmail.com>
 <e9987f16-7328-627d-8c02-c42c130a61a8@meta.com> <CAN+4W8hK9EEb7Qb2How+YwNkkz4wjRyBAK7Y+WcqBzA9ckJ5Qg@mail.gmail.com>
 <CAEf4BzaEPMVFfEYwHxje8sm+26bgeLJ+4hfdGNOMHd5bV8u9rw@mail.gmail.com>
 <CAN+4W8iTm-GS_-Wp=XjY1Txs09G7F4d3vcG_30WDOp-CpDKmCA@mail.gmail.com>
 <CAEf4BzZQQiD5x0PRwGD32bE7izUxhPvRRQTMpifQZYvu+0mMkA@mail.gmail.com> <bf1ab8f0-bb83-43d1-9ce0-cb6828fdc935@linux.dev>
In-Reply-To: <bf1ab8f0-bb83-43d1-9ce0-cb6828fdc935@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Nov 2023 19:16:08 -0700
Message-ID: <CAEf4BzaLuL_MtW25t4sehjD2VzCSu3TqbRyQrJJG2t2hCf4LqQ@mail.gmail.com>
Subject: Re: bpf_core_type_id_kernel is not consistent with bpf_core_type_id_local
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Lorenz Bauer <lorenz.bauer@isovalent.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yhs@meta.com>, Lorenz Bauer <lmb@isovalent.com>, bpf <bpf@vger.kernel.org>, 
	Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 1, 2023 at 5:34=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
> On 11/1/23 3:42 PM, Andrii Nakryiko wrote:
> > On Wed, Nov 1, 2023 at 7:18=E2=80=AFAM Lorenz Bauer <lorenz.bauer@isova=
lent.com> wrote:
> >> On Tue, Oct 31, 2023 at 6:24=E2=80=AFPM Andrii Nakryiko
> >> <andrii.nakryiko@gmail.com> wrote:
> >>>> Did you get round to fixing this, or did you decide to leave it as i=
s?
> >>> Trying to recall, was there anything to do on the libbpf side, or was
> >>> it purely a compiler-side change?
> >> I'm not 100% sure TBH. I'd like clang to behave consistently for
> >> local_id and target_id. I don't know whether that would break libbpf.
> >>
> > *checks code* libbpf just passes through whatever ID compiler
> > generated, so there doesn't seem to be any change to libbpf. Seems
> > like compiler-only change. cc'ing Eduard  as well, if he's curious
> > enough to check
>
> Okay, let us try to have a consistent behavior in local/remote type_id
> by changing local_id semantics to be the same as target_id.
>
> The corresponding llvm change is similar to
>
> [yhs@devbig309.ftw3 ~/work/llvm-project (ed)]$ git diff
> diff --git a/llvm/lib/Target/BPF/BPFPreserveDIType.cpp b/llvm/lib/Target/=
BPF/BPFPreserveDIType.cpp
> index 78e1bf90f1bd..1fbe1207dc6e 100644
> --- a/llvm/lib/Target/BPF/BPFPreserveDIType.cpp
> +++ b/llvm/lib/Target/BPF/BPFPreserveDIType.cpp
> @@ -86,15 +86,17 @@ static bool BPFPreserveDITypeImpl(Function &F) {
>         Reloc =3D BTF::BTF_TYPE_ID_LOCAL;
>       } else {
>         Reloc =3D BTF::BTF_TYPE_ID_REMOTE;
> -      DIType *Ty =3D cast<DIType>(MD);
> -      while (auto *DTy =3D dyn_cast<DIDerivedType>(Ty)) {
> -        unsigned Tag =3D DTy->getTag();
> -        if (Tag !=3D dwarf::DW_TAG_const_type &&
> -            Tag !=3D dwarf::DW_TAG_volatile_type)
> -          break;
> -        Ty =3D DTy->getBaseType();
> -      }
> +    }
> +    DIType *Ty =3D cast<DIType>(MD);
> +    while (auto *DTy =3D dyn_cast<DIDerivedType>(Ty)) {
> +      unsigned Tag =3D DTy->getTag();
> +      if (Tag !=3D dwarf::DW_TAG_const_type &&
> +          Tag !=3D dwarf::DW_TAG_volatile_type)
> +        break;
> +      Ty =3D DTy->getBaseType();
> +    }
>
> +    if (Reloc =3D=3D BTF::BTF_TYPE_ID_REMOTE) {
>         if (Ty->getName().empty()) {
>           if (isa<DISubroutineType>(Ty))
>             report_fatal_error(
> @@ -102,8 +104,8 @@ static bool BPFPreserveDITypeImpl(Function &F) {
>           else
>             report_fatal_error("Empty type name for BTF_TYPE_ID_REMOTE re=
loc");
>         }
> -      MD =3D Ty;
>       }
> +    MD =3D Ty;
>
>       BasicBlock *BB =3D Call->getParent();
>       IntegerType *VarType =3D Type::getInt64Ty(BB->getContext());
>
> Either Eduard or Myself will submit a llvm patch to fix this in llvm18.

Sounds good, and thank you!

>
> >
> >
> >> Lorenz

