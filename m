Return-Path: <bpf+bounces-12347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D12797CB3BF
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 22:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DA1A1C20AF3
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 20:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F3F36AFB;
	Mon, 16 Oct 2023 20:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhFgJPHH"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93D0341AD
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 20:11:02 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7534A1
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 13:11:00 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-533d31a8523so8414415a12.1
        for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 13:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697487059; x=1698091859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBKgqALnCgzAagUEHd7sAZyJ9q9mLB1Dn6erJELMBdA=;
        b=GhFgJPHHpbPTzrk2DX7OHLq+aSIJ4zA2v5DCtpBsiq0Iuiaf63D+Nt1ZGeDCx5af9x
         T3G+PZN9dMY3NTtsvh8HwfjXzjY7pK7nVAiXhl39AjYBKDijOrD24m4tMl09mP0hZvtW
         tuUSzUfzzrIH/5uT+Zm/cBlTv/+uye55DSkPB+XOmlKor7BI0WTlOjVs+Z02k1hwccc+
         3Bmi6CNw5OilcgQu9eMgPhfgxAGwbYBkQ/iN9kVP+f1WRcy+znaIBApbwB8LxxHuyRSC
         8H1FVhqVy+swyLMQxVXmhcQ+C18V+mfHhWAYWHqk8v4e9pMt8y9Y7iZ8sMWWOUNsLHm7
         Chrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697487059; x=1698091859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBKgqALnCgzAagUEHd7sAZyJ9q9mLB1Dn6erJELMBdA=;
        b=sOodhRyTComyUginoWRNbkduBjfMDldOO5JlLs7czyBBS6SKtMHMTnS9oUgSJvq92R
         Q8Uprd22oV+9Fxy3SAKCtROtH7b0aOqjC1dyRmADGDYr5Nx7zVbuTELNMfojxRI0K05U
         UcipXLU3HvJKIK+S5wjjHBkCf/YU/eFo3dnjIawQ7rxXGxx2gVfXv6VeQmXqPEj0bmH+
         FawUYTM/vKU9UBQQ9wn4DnaNXAultqpNJrokbx+1hGHXIGDmmCc7IW/oiBQ9lD56pdiq
         8iJzMznkaE4CsvGC5wDtDn7VTMF049ATHvA5owK0vJBZ1onoZTnXxtzVIlxIlmsHT0fw
         PP3A==
X-Gm-Message-State: AOJu0YzUI2m7+8jT1sqtiJgRu9LiSJNPj9mkXvXzgFaOnNbr1KjCmPP/
	Adxn8wYGz+esYObcyxMfc9prBuVKe37zLIKjnufsENu/RX0=
X-Google-Smtp-Source: AGHT+IE+yRCNp57cQ8zsfThh8vo1f42m+dUEwF1aaR4G4Q1M7l4Rf3/fawxc7Mm8waZsrKP2eNZIx8lcheCb9DMT7l4=
X-Received: by 2002:a05:6402:51ce:b0:53e:eed5:d8e7 with SMTP id
 r14-20020a05640251ce00b0053eeed5d8e7mr211376edd.17.1697487059131; Mon, 16 Oct
 2023 13:10:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016182840.4033346-1-andrii@kernel.org>
In-Reply-To: <20231016182840.4033346-1-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 16 Oct 2023 13:10:45 -0700
Message-ID: <CAEf4BzZopGdv=cfQCryvaw_duK_BD1oFgTXXZ6w25X0xxXLWJw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: don't assume SHT_GNU_verdef presence for
 SHT_GNU_versym section
To: Andrii Nakryiko <andrii@kernel.org>, Hengqi Chen <hengqi.chen@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com, 
	Liam Wisehart <liamwisehart@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 11:28=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org=
> wrote:
>
> Fix too eager assumption that SHT_GNU_verdef ELF section is going to be
> present whenever binary has SHT_GNU_versym section. It seems like either
> SHT_GNU_verdef or SHT_GNU_verneed can be used, so failing on missing
> SHT_GNU_verdef actually breaks use cases in production.
>
> One specific reported issue, which was used to manually test this fix,
> was trying to attach to `readline` function in BASH binary.
>
> Cc: Hengqi Chen <hengqi.chen@gmail.com>
> Reported-by: Liam Wisehart <liamwisehart@meta.com>
> Fixes: bb7fa09399b9 ("libbpf: Support symbol versioning for uprobe")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/elf.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>

Hengqi,

Please take a look when you get a chance. I'm not very familiar with
symbol versioning details, but it seems like we made a too strong
assumption about verdef always being present. In bash's case we have
VERNEED, but not VERDEF, and that seems to be ok:

  [ 8] .gnu.version      VERSYM          000000000001c9ca 01c9ca
00130c 02   A  6   0  2
  [ 9] .gnu.version_r    VERNEED         000000000001dcd8 01dcd8
0000b0 00   A  7   2  8

So perhaps we need to complete the implementation to take VERNEED into
account. And also let's add a test that can catch an issue like this
going forward. Thanks!

> diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> index 2a158e8a8b7c..2a62bf411bb3 100644
> --- a/tools/lib/bpf/elf.c
> +++ b/tools/lib/bpf/elf.c
> @@ -141,14 +141,15 @@ static int elf_sym_iter_new(struct elf_sym_iter *it=
er,
>         iter->versyms =3D elf_getdata(scn, 0);
>
>         scn =3D elf_find_next_scn_by_type(elf, SHT_GNU_verdef, NULL);
> -       if (!scn) {
> -               pr_debug("elf: failed to find verdef ELF sections in '%s'=
\n", binary_path);
> -               return -ENOENT;
> -       }
> -       if (!gelf_getshdr(scn, &sh))
> +       if (!scn)
> +               return 0;
> +
> +       iter->verdefs =3D elf_getdata(scn, 0);
> +       if (!iter->verdefs || !gelf_getshdr(scn, &sh)) {
> +               pr_warn("elf: failed to get verdef ELF section in '%s'\n"=
, binary_path);
>                 return -EINVAL;
> +       }
>         iter->verdef_strtabidx =3D sh.sh_link;
> -       iter->verdefs =3D elf_getdata(scn, 0);
>
>         return 0;
>  }
> @@ -199,6 +200,9 @@ static const char *elf_get_vername(struct elf_sym_ite=
r *iter, int ver)
>         GElf_Verdef verdef;
>         int offset;
>
> +       if (!iter->verdefs)
> +               return NULL;
> +
>         offset =3D 0;
>         while (gelf_getverdef(iter->verdefs, offset, &verdef)) {
>                 if (verdef.vd_ndx !=3D ver) {
> --
> 2.34.1
>

