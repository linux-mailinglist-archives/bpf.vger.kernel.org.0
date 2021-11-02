Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5198F4425E1
	for <lists+bpf@lfdr.de>; Tue,  2 Nov 2021 03:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhKBDBf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Nov 2021 23:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbhKBDBX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Nov 2021 23:01:23 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E432BC061766;
        Mon,  1 Nov 2021 19:58:49 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id o12so49570701ybk.1;
        Mon, 01 Nov 2021 19:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xUSHsL1SJ8QuFDluus8hF/ursJeTPEAe3GL/4QDN0t4=;
        b=oHIKzS1bB1hECBgxroX5WqLbEXt1LknDIGqz72MYC4XTEqOufaCJ6dOesdico26qA5
         0TX1ccDTeNA56ZPgkLlapTq0IVf/TxCeXmxU5H8lm4asocVsjeMKU8oG3HBFgQwHxhwZ
         2REscNLG+6owbPdeKUhottQN1WIBqbiY3zlxTMW2LQe+mxAbzqJawEB7CaFHY0duIoEE
         Y2/Zwhz0KhR0Bmu01NaxNwBPeIPkAkOvOR0SCnN15D9bZCRzEgAYwgI1Yzu2SIZcsLZ4
         cJ3Mrh4CzSuH3U5oxqynVmfjo5ebmDb+e3q80uJnS2GTUQ98P3HxwX2EdO8BJpVSHwQ1
         PkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xUSHsL1SJ8QuFDluus8hF/ursJeTPEAe3GL/4QDN0t4=;
        b=YRjgGvHV5eEFrt4kxVJneumcGw+Sz0INbK5R904tvTPtm9CbEQF5C1fMHX0Mw8brS0
         VXXtUyukaicSk74MTYuqJ2+PuIfmazXxLaHRzRkQr5+x4JyyLKSbMljrMioDf7aKDU7a
         k2kGnafPeEFyikvjDS6bAuJmAYSCcnIhw0LRcp5shYyFusDaTNMJQ+g+Tnsk05cV6HRF
         xnpixX0XvHo2HMmq5wKGCO+AJkHjfsHDYn8mMpXEqbghdcABFzyv9IpwgfBM9rC1pmli
         1zYCStKFUUG7dcUzaWwvbVOFsFKrmQDYIIdOhl2YucuD2xNCUYNeSNEUgtcp9dsmE9vq
         qkEg==
X-Gm-Message-State: AOAM530kuxXQ/yPGBKYthe0pKvnmuxaBHqjwXm1F3+O2HkYHXygR8WXa
        YviNPz1u5A34hkK+XZH+A/FX1MNhWqEZtYHPH6w=
X-Google-Smtp-Source: ABdhPJyEjVLYSfeu/gvFmkLa+noSxw7oHKKg49/3CFzVRkIkyPu/avOKQsVznNhu7YXSuNO50qebv9ZVayyDeyxFs54=
X-Received: by 2002:a25:cc4c:: with SMTP id l73mr34881668ybf.114.1635821929220;
 Mon, 01 Nov 2021 19:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211027230822.2465100-1-yhs@fb.com> <20211027230834.2466282-1-yhs@fb.com>
In-Reply-To: <20211027230834.2466282-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 1 Nov 2021 19:58:38 -0700
Message-ID: <CAEf4BzaOuwJtLkEhLcnN4_GjG+qVBUF63ywPkAsZdC2FjxmJuQ@mail.gmail.com>
Subject: Re: [PATCH dwarves 2/2] btf_encoder: generate BTF_KIND_DECL_TAGs for
 typedef btf_decl_tag attributes
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 27, 2021 at 4:08 PM Yonghong Song <yhs@fb.com> wrote:
>
> Emit BTF BTF_KIND_DECL_TAGs for btf_decl_tag attributes attached to
> typedef declarations. The following is a simple example:
>   $ cat t.c
>     #define __tag1 __attribute__((btf_decl_tag("tag1")))
>     #define __tag2 __attribute__((btf_decl_tag("tag2")))
>     typedef struct { int a; int b; } __t __tag1 __tag2;
>     __t g;
>   $ clang -O2 -g -c t.c
>   $ pahole -JV t.o
>     btf_encoder__new: 't.o' doesn't have '.data..percpu' section
>     Found 0 per-CPU variables!
>     File t.o:
>     [1] TYPEDEF __t type_id=2
>     [2] STRUCT (anon) size=8
>             a type_id=3 bits_offset=0
>             b type_id=3 bits_offset=32
>     [3] INT int size=4 nr_bits=32 encoding=SIGNED
>     [4] DECL_TAG tag1 type_id=1 component_idx=-1
>     [5] DECL_TAG tag2 type_id=1 component_idx=-1
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  btf_encoder.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 40f6aa3..2f1f4ae 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1437,19 +1437,25 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu)
>         }
>
>         cu__for_each_type(cu, core_id, pos) {
> +               const char *tag_name = "typedef";
>                 struct namespace *ns;
>
> -               if (pos->tag != DW_TAG_structure_type && pos->tag != DW_TAG_union_type)
> +               if (pos->tag != DW_TAG_structure_type && pos->tag != DW_TAG_union_type &&
> +                   pos->tag != DW_TAG_typedef)
>                         continue;
>
> +               if (pos->tag == DW_TAG_structure_type)
> +                       tag_name = "struct";
> +               else if (pos->tag == DW_TAG_union_type)
> +                       tag_name = "union";

nit: switch instead of these two related sets of if/else blocks would be cleaner


> +
>                 btf_type_id = type_id_off + core_id;
>                 ns = tag__namespace(pos);
>                 list_for_each_entry(annot, &ns->annots, node) {
>                         tag_type_id = btf_encoder__add_decl_tag(encoder, annot->value, btf_type_id, annot->component_idx);
>                         if (tag_type_id < 0) {
>                                 fprintf(stderr, "error: failed to encode tag '%s' to %s '%s' with component_idx %d\n",
> -                                       annot->value, pos->tag == DW_TAG_structure_type ? "struct" : "union",
> -                                       namespace__name(ns), annot->component_idx);
> +                                       annot->value, tag_name, namespace__name(ns), annot->component_idx);
>                                 goto out;
>                         }
>                 }
> --
> 2.30.2
>
