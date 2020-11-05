Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9332A86CD
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 20:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgKETK0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 14:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKETK0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 14:10:26 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37768C0613CF;
        Thu,  5 Nov 2020 11:10:26 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id b138so2289641yba.5;
        Thu, 05 Nov 2020 11:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KJ4/h1YdYd4I+aTdeDT3O49xOtynQ0iW9/9nrkdHlSY=;
        b=mqTZSqStnElJ0DB99TJ+ZXfMw0LAgrNyxf84zgIS4zMzDV76+C4h4Kmr6z4NuLOm25
         rB4qmFaHf6Z8l15Vu5zfmAPuz7Y++XoamhpO1+eL5htjNE8xIOMw8zPrithvwJg4QBtJ
         P/+y74/kUAlyhm0DdHdY+gOyGRKR7vV+CB0GXRKey9s/r6zcrK2svbKvOgQFUnhks4LW
         qJxVG9u2ZpH+uwEfWAMskDC6mGd+z/up4+DkeDL4orXWJbHCITWXekVxd5hnqFGkKXRg
         Rkb7yr2ls6/gYT3IELx98pabiR7CL7Oxws+CkCmZoRtvb7Pbe30iYvoqycdyM099o0Zy
         JdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KJ4/h1YdYd4I+aTdeDT3O49xOtynQ0iW9/9nrkdHlSY=;
        b=JDvx53kaKvMlrrYvk8+WX2BU7Y4+HUIeNEtoQHEbwYbfa0oKXnI7HB2RgpmeswgBTY
         ot9/4k9f9IAadK96L7EtvPRQElNd9o0IPgzS9tq4FwLrGPocNVDVvnqwH85NlkbRbHvo
         bdn2cjA3TaNTSIxjdHDaRyVdri4sVnPgHFl7j3JStPbQmWnqQj8ldv3/xY7oMpcfnZoo
         LntNQE5zGPQJe6GCzbJxpGCpb310yU5/w1HatUvs/4SLBLT3H4wfV06m1QROq+fp/PpP
         ZkkTssBQa5pCXTDADMg1ptPnBc8sswfLkiLY7pW3UDvrmJPIEl0MVEejN1cPp2WL3tzS
         YG7w==
X-Gm-Message-State: AOAM530P69YIupSf5DqCKcTiIa8AemeLSScSnukVmofWkan2Tue5wX4k
        /WPoEoyRTSFfhaKFOu6xMKqUNtMz+TBU399CjYtBCalb1yKSLw==
X-Google-Smtp-Source: ABdhPJzlhxiNo8PRISb3zoqcj9C5zkRRZd/6NiTpBEhxnvnLcm3coEBUWZSlSPmKeQb1R24jRXKRTb460wZsURJs1Wk=
X-Received: by 2002:a25:cb10:: with SMTP id b16mr5605715ybg.459.1604603425243;
 Thu, 05 Nov 2020 11:10:25 -0800 (PST)
MIME-Version: 1.0
References: <20201105043936.2555804-1-andrii@kernel.org> <20201105114242.GH262228@kernel.org>
In-Reply-To: <20201105114242.GH262228@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 5 Nov 2020 11:10:14 -0800
Message-ID: <CAEf4BzYshEY3K=fqt2iQJaVcZeepcger0C7+uOXNhG=MLC9R-w@mail.gmail.com>
Subject: Re: [RFC PATCH dwarves] btf: add support for split BTF loading and encoding
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 5, 2020 at 3:42 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Wed, Nov 04, 2020 at 08:39:36PM -0800, Andrii Nakryiko escreveu:
> > Add support for generating split BTF, in which there is a designated base
> > BTF, containing a base set of types, and a split BTF, which extends main BTF
> > with extra types, that can reference types and strings from the main BTF.
> >
> > This is going to be used to generate compact BTFs for kernel modules, with
> > vmlinux BTF being a main BTF, which all kernel modules are based off of.
> >
> > These changes rely on patch set [0] to be present in libbpf submodule.
> >
> >   [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=377859&state=*
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >
> > This is posted before libbpf changes landed to show end-to-end how kernel
> > module BTFs are going to be integrated into the kernel. Once libbpf split BTF
> > support lands, I'll sync it into Github repo and will post a proper v1.
> >
> >  btf_encoder.c | 15 ++++++++-------
> >  btf_loader.c  |  2 +-
> >  libbtf.c      | 43 +++++++++++++++++++++++++++----------------
> >  libbtf.h      |  4 +++-
> >  pahole.c      | 23 +++++++++++++++++++++++
> >  5 files changed, 62 insertions(+), 25 deletions(-)
> >
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index 4c92908beab2..d67e29b9cbee 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -12,6 +12,7 @@
> >  #include "dwarves.h"
> >  #include "libbtf.h"
> >  #include "lib/bpf/include/uapi/linux/btf.h"
> > +#include "lib/bpf/src/libbpf.h"
> >  #include "hash.h"
> >  #include "elf_symtab.h"
> >  #include "btf_encoder.h"
> > @@ -343,7 +344,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> >       }
> >
> >       if (!btfe) {
> > -             btfe = btf_elf__new(cu->filename, cu->elf);
> > +             btfe = btf_elf__new(cu->filename, cu->elf, base_btf);
> >               if (!btfe)
> >                       return -1;
> >
> > @@ -358,22 +359,22 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> >                       printf("File %s:\n", btfe->filename);
> >       }
> >
> > +     btf_elf__verbose = verbose;
> > +     btf_elf__force = force;
> > +     type_id_off = btf__get_nr_types(btfe->btf);
> > +
> >       if (!has_index_type) {
> >               /* cu__find_base_type_by_name() takes "type_id_t *id" */
> >               type_id_t id;
> >               if (cu__find_base_type_by_name(cu, "int", &id)) {
> >                       has_index_type = true;
> > -                     array_index_id = id;
> > +                     array_index_id = type_id_off + id;
> >               } else {
> >                       has_index_type = false;
> > -                     array_index_id = cu->types_table.nr_entries;
> > +                     array_index_id = type_id_off + cu->types_table.nr_entries;
> >               }
> >       }
> >
> > -     btf_elf__verbose = verbose;
> > -     btf_elf__force = force;
> > -     type_id_off = btf__get_nr_types(btfe->btf);
> > -
> >       cu__for_each_type(cu, core_id, pos) {
> >               int32_t btf_type_id = tag__encode_btf(cu, pos, core_id, btfe, array_index_id, type_id_off);
> >
> > diff --git a/btf_loader.c b/btf_loader.c
> > index 6ea207ea65b4..ec286f413f36 100644
> > --- a/btf_loader.c
> > +++ b/btf_loader.c
> > @@ -534,7 +534,7 @@ struct debug_fmt_ops btf_elf__ops;
> >  int btf_elf__load_file(struct cus *cus, struct conf_load *conf, const char *filename)
> >  {
> >       int err;
> > -     struct btf_elf *btfe = btf_elf__new(filename, NULL);
> > +     struct btf_elf *btfe = btf_elf__new(filename, NULL, base_btf);
> >
> >       if (btfe == NULL)
> >               return -1;
> > diff --git a/libbtf.c b/libbtf.c
> > index babf4fe8cd9e..3c52aa0d482b 100644
> > --- a/libbtf.c
> > +++ b/libbtf.c
> > @@ -27,6 +27,7 @@
> >  #include "dwarves.h"
> >  #include "elf_symtab.h"
> >
> > +struct btf *base_btf;
> >  uint8_t btf_elf__verbose;
> >  uint8_t btf_elf__force;
> >
> > @@ -52,9 +53,9 @@ int btf_elf__load(struct btf_elf *btfe)
> >       /* free initial empty BTF */
> >       btf__free(btfe->btf);
> >       if (btfe->raw_btf)
> > -             btfe->btf = btf__parse_raw(btfe->filename);
> > +             btfe->btf = btf__parse_raw_split(btfe->filename, btfe->base_btf);
> >       else
> > -             btfe->btf = btf__parse_elf(btfe->filename, NULL);
> > +             btfe->btf = btf__parse_elf_split(btfe->filename, btfe->base_btf);
> >
> >       err = libbpf_get_error(btfe->btf);
> >       if (err)
> > @@ -63,7 +64,7 @@ int btf_elf__load(struct btf_elf *btfe)
> >       return 0;
> >  }
> >
> > -struct btf_elf *btf_elf__new(const char *filename, Elf *elf)
> > +struct btf_elf *btf_elf__new(const char *filename, Elf *elf, struct btf *base_btf)
> >  {
> >       struct btf_elf *btfe = zalloc(sizeof(*btfe));
> >       GElf_Shdr shdr;
> > @@ -77,7 +78,8 @@ struct btf_elf *btf_elf__new(const char *filename, Elf *elf)
> >       if (btfe->filename == NULL)
> >               goto errout;
> >
> > -     btfe->btf = btf__new_empty();
> > +     btfe->base_btf = base_btf;
> > +     btfe->btf = btf__new_empty_split(base_btf);
> >       if (libbpf_get_error(btfe->btf)) {
> >               fprintf(stderr, "%s: failed to create empty BTF.\n", __func__);
> >               goto errout;
> > @@ -679,11 +681,11 @@ static int btf_elf__write(const char *filename, struct btf *btf)
> >  {
> >       GElf_Shdr shdr_mem, *shdr;
> >       GElf_Ehdr ehdr_mem, *ehdr;
> > -     Elf_Data *btf_elf = NULL;
> > +     Elf_Data *btf_data = NULL;
>
> Can you please split this into two patches, one doing just the rename
> of btf_elf to btf_data and then moving to btf__new_empty_split()? Eases
> reviewing.

sure, will do in the next version

>
> With this split btf code would it be possible to paralelize the encoding
> of the modules BTF? I have to check the other patches and how this gets
> used in the kernel build process... :-)

Yes, each module's BTF is generated completely independently. See some
numbers in [0].

  [0] https://patchwork.kernel.org/project/netdevbpf/patch/20201105045140.2589346-4-andrii@kernel.org/

>
> - Arnaldo
>

[...]
