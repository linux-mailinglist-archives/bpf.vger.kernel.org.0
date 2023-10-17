Return-Path: <bpf+bounces-12364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C83197CB87B
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 04:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683FE281623
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 02:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E811864;
	Tue, 17 Oct 2023 02:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVHhSRg9"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D94622
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 02:38:06 +0000 (UTC)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FA48E
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 19:38:04 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1dceb2b8823so2670864fac.1
        for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 19:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697510284; x=1698115084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgFZjlRzqNDYvu0lc0C32Ko7PoKLTlNJ6ZCw5CVdK7k=;
        b=ZVHhSRg9I+96WEggTG5p8TXq56fENp3K0Xg4OcAFRmREMkz1DPZm89yOhkaUdE/K7A
         0YIY2r9Y+3+T1k7CbZXDeydf1dRDM7fSQQra/1YsA1PHuFJdRsPPCiRN9i19tHZK7fGw
         VmwvJm8yemftnpGWohC2bDiYDAmgyIviZ9hQlWQLbSj+GNzM4uW3PEbyU/a/YxRPUNol
         I96/4nf3O24+trtOCGWhZn9CuIfvCHxUUsLGY8e9clwlB6iJBlXtSm9yQbgig6ek+UVd
         4HTC6YeGvvoU37zHk3qmqzONJOVd/es0AsNpIpx+hpnbU4UG264v6PARo1RfKRN+Lt24
         yOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697510284; x=1698115084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RgFZjlRzqNDYvu0lc0C32Ko7PoKLTlNJ6ZCw5CVdK7k=;
        b=oDjnL26Z/ImFp3KISPWMldSBfWfo7WJ4KbTlkeZJGOi/biQSpbKMWz+He2Sxjz3uIw
         3LrBzS7ngH+4zOoqlp58xTXnkq6kd7iWJA1hMuecO5v2SRf2lXwjTibZag2szNS+DWB1
         yoz3GdAGF0UwCczZCio3mf0U89+5w42tnbYPc5DyNsJEpwpbUtuCK9grYNiMaKGyu1qf
         WWpMTNexTWRX38Pe+WiZS/gPtHiG4/NAoeHhRF1pgEFitGj1nKY1mSMC8Cm8pHN1pZyB
         vplqCxbxwBnnHA+Qu/F0Ewd9Knwp/+yqDEBrNCIKME+i2YWFxLR6tAO60IccJhhGaB2z
         uXEg==
X-Gm-Message-State: AOJu0YzY1yTKB+i19TWRozNf9GM92frY5wIEbjPsG9to70+Am2Q/Dj8N
	yMsw55Cerlkv/k2AZENPJsijqYTfrh/wfn8yuno=
X-Google-Smtp-Source: AGHT+IF6wzck7NBs7noSIadx4PzAUx2UhLZhKiNjQhBDAIIEyb/taWe8uA+IiPkQYodmgx6jdMsScVprlxVLYsh0sro=
X-Received: by 2002:a05:6870:d1c5:b0:1e9:d3bd:3ec with SMTP id
 b5-20020a056870d1c500b001e9d3bd03ecmr330173oac.22.1697510283946; Mon, 16 Oct
 2023 19:38:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016182840.4033346-1-andrii@kernel.org> <CAEf4BzZopGdv=cfQCryvaw_duK_BD1oFgTXXZ6w25X0xxXLWJw@mail.gmail.com>
In-Reply-To: <CAEf4BzZopGdv=cfQCryvaw_duK_BD1oFgTXXZ6w25X0xxXLWJw@mail.gmail.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Tue, 17 Oct 2023 10:37:52 +0800
Message-ID: <CAEyhmHSHJgQrgtRZotmm3yQOSekjjZjqaHAF58iQeu0WYPNcYA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: don't assume SHT_GNU_verdef presence for
 SHT_GNU_versym section
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Fangrui Song <maskray@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, 
	Liam Wisehart <liamwisehart@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

+ Fangrui

On Tue, Oct 17, 2023 at 4:10=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Oct 16, 2023 at 11:28=E2=80=AFAM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> >
> > Fix too eager assumption that SHT_GNU_verdef ELF section is going to be
> > present whenever binary has SHT_GNU_versym section. It seems like eithe=
r
> > SHT_GNU_verdef or SHT_GNU_verneed can be used, so failing on missing
> > SHT_GNU_verdef actually breaks use cases in production.
> >
> > One specific reported issue, which was used to manually test this fix,
> > was trying to attach to `readline` function in BASH binary.
> >
> > Cc: Hengqi Chen <hengqi.chen@gmail.com>
> > Reported-by: Liam Wisehart <liamwisehart@meta.com>
> > Fixes: bb7fa09399b9 ("libbpf: Support symbol versioning for uprobe")
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/lib/bpf/elf.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> >
>
> Hengqi,
>
> Please take a look when you get a chance. I'm not very familiar with
> symbol versioning details, but it seems like we made a too strong
> assumption about verdef always being present. In bash's case we have
> VERNEED, but not VERDEF, and that seems to be ok:
>

Yes, both VERNEED and VERDEF are optional.

>   [ 8] .gnu.version      VERSYM          000000000001c9ca 01c9ca
> 00130c 02   A  6   0  2
>   [ 9] .gnu.version_r    VERNEED         000000000001dcd8 01dcd8
> 0000b0 00   A  7   2  8
>
> So perhaps we need to complete the implementation to take VERNEED into
> account. And also let's add a test that can catch an issue like this
> going forward. Thanks!
>

AFAIK, VERNEED contains version requirements for shared libraries.

> > diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> > index 2a158e8a8b7c..2a62bf411bb3 100644
> > --- a/tools/lib/bpf/elf.c
> > +++ b/tools/lib/bpf/elf.c
> > @@ -141,14 +141,15 @@ static int elf_sym_iter_new(struct elf_sym_iter *=
iter,
> >         iter->versyms =3D elf_getdata(scn, 0);
> >
> >         scn =3D elf_find_next_scn_by_type(elf, SHT_GNU_verdef, NULL);
> > -       if (!scn) {
> > -               pr_debug("elf: failed to find verdef ELF sections in '%=
s'\n", binary_path);
> > -               return -ENOENT;
> > -       }
> > -       if (!gelf_getshdr(scn, &sh))
> > +       if (!scn)
> > +               return 0;
> > +
> > +       iter->verdefs =3D elf_getdata(scn, 0);
> > +       if (!iter->verdefs || !gelf_getshdr(scn, &sh)) {
> > +               pr_warn("elf: failed to get verdef ELF section in '%s'\=
n", binary_path);
> >                 return -EINVAL;
> > +       }
> >         iter->verdef_strtabidx =3D sh.sh_link;
> > -       iter->verdefs =3D elf_getdata(scn, 0);
> >
> >         return 0;
> >  }
> > @@ -199,6 +200,9 @@ static const char *elf_get_vername(struct elf_sym_i=
ter *iter, int ver)
> >         GElf_Verdef verdef;
> >         int offset;
> >
> > +       if (!iter->verdefs)
> > +               return NULL;
> > +
> >         offset =3D 0;
> >         while (gelf_getverdef(iter->verdefs, offset, &verdef)) {
> >                 if (verdef.vd_ndx !=3D ver) {
> > --
> > 2.34.1
> >

Anyway, this change look good to me, so

Acked-by: Hengqi Chen <hengqi.chen@gmail.com>

--
Hengqi

