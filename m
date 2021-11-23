Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D294599E2
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 02:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbhKWB4O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 20:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbhKWB4N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 20:56:13 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E30C061714;
        Mon, 22 Nov 2021 17:53:05 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 131so55166596ybc.7;
        Mon, 22 Nov 2021 17:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KQew24gCw32BEspXmTN0N3jE47f4UUvD6aEt6ZjVBM8=;
        b=SqTpL5iLKjNITSh8GNz3LyLP3iRqTXMLaNlyu/KLT4J9FjA2cYxZ3FRiP/LEde6S2+
         24eU8da+O9N9PepEmwWTHVN2GOTQcHnaw+9fLVis/5DqNf9wL2PGk0T8cp5L8/YYhqIu
         46uiCrqKJGeAhLFjbOdPQuMgy2SL1ga7b5luZ5yIYPSXctvhP4071sAWyF0s0trmY3NY
         vT/cnIRtQzVYTnIKmJLgxhiBlmK0sseV6z6EoeBju/SoPD36zW11BnzMrr8nxSwg8WJc
         ysAeXaS/5ssVNis/cHEvzkJ8Hc42hFZHyY2/fTRyye/5ayDIXEYY25O7DE6ho9dJuO9Z
         ak0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KQew24gCw32BEspXmTN0N3jE47f4UUvD6aEt6ZjVBM8=;
        b=Xz3gK5gRAoLugnUyg6c8PurEyUpTongL7MdIfWbpxcTQi7psMV5esPiW2WyQEQFTTi
         Bp8S3e4rCxCEA76x4hXvHvEjulfhhy1g4HRKxvpmOkSRAjnvwFMq/0RphFaEpv+LlXG3
         t0YmdjEgWpt8XrbvNnRdUrrXhAqpY2pBjhxpgZdNdD4GZ7eoi9twqTaSbeH9JltS2dqy
         htch5BtQaxjNT9tIowjpfFTDcuFz71qn/JtB1wjga28fFEXWas3VReRBJL6qZWSIv6iK
         2euQoRMiYX2zDWADbIXGFBimYiS2h9Sj4UAhunUXccMOE40ZT5Ffu4FM0OsSzYlyw0ir
         vTOg==
X-Gm-Message-State: AOAM533Ym1+Y5VUkrI+2iUC+b2486Wet8uDG8uNKpI3ixcTgDisw063P
        DMhNZWHP7MsD5Gi0U6c3D8rQ5Ke+EKTGaeVr3aY=
X-Google-Smtp-Source: ABdhPJxMV9h5aFoIbdAovbXihTGjlzX4KhZCL6E5x6hEkwIfy2qL5oYVdphR1hxtTbZX9spvq6WBzHzBLTPnteV1I9w=
X-Received: by 2002:a25:ccd4:: with SMTP id l203mr2076380ybf.225.1637632384690;
 Mon, 22 Nov 2021 17:53:04 -0800 (PST)
MIME-Version: 1.0
References: <20211117202214.3268824-1-yhs@fb.com> <20211117202229.3270304-1-yhs@fb.com>
In-Reply-To: <20211117202229.3270304-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 22 Nov 2021 17:52:53 -0800
Message-ID: <CAEf4Bzbcx0ExE+TsOL4G+56KZ3dLs5vJV_y1=9_Cpt=4Y=c5uA@mail.gmail.com>
Subject: Re: [PATCH dwarves 3/4] dwarf_loader: support btf_type_tag attribute
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

On Wed, Nov 17, 2021 at 12:25 PM Yonghong Song <yhs@fb.com> wrote:
>
> LLVM patches ([1] for clang, [2] and [3] for BPF backend)
> added support for btf_type_tag attributes. The following is
> an example:
>   [$ ~] cat t.c
>   #define __tag1 __attribute__((btf_type_tag("tag1")))
>   #define __tag2 __attribute__((btf_type_tag("tag2")))
>   int __tag1 * __tag1 __tag2 *g __attribute__((section(".data..percpu")));
>   [$ ~] clang -O2 -g -c t.c
>   [$ ~] llvm-dwarfdump --debug-info t.o
>   t.o:    file format elf64-x86-64
>   ...
>   0x0000001e:   DW_TAG_variable
>                   DW_AT_name      ("g")
>                   DW_AT_type      (0x00000033 "int **")
>                   DW_AT_external  (true)
>                   DW_AT_decl_file ("/home/yhs/t.c")
>                   DW_AT_decl_line (3)
>                   DW_AT_location  (DW_OP_addr 0x0)
>   0x00000033:   DW_TAG_pointer_type
>                   DW_AT_type      (0x0000004b "int *")
>   0x00000038:     DW_TAG_LLVM_annotation
>                     DW_AT_name    ("btf_type_tag")
>                     DW_AT_const_value     ("tag1")
>   0x00000041:     DW_TAG_LLVM_annotation
>                     DW_AT_name    ("btf_type_tag")
>                     DW_AT_const_value     ("tag2")
>   0x0000004a:     NULL
>   0x0000004b:   DW_TAG_pointer_type
>                   DW_AT_type      (0x0000005a "int")
>   0x00000050:     DW_TAG_LLVM_annotation
>                     DW_AT_name    ("btf_type_tag")
>                     DW_AT_const_value     ("tag1")
>   0x00000059:     NULL
>   0x0000005a:   DW_TAG_base_type
>                   DW_AT_name      ("int")
>                   DW_AT_encoding  (DW_ATE_signed)
>                   DW_AT_byte_size (0x04)
>   0x00000061:   NULL
>
> From the above example, you can see that DW_TAG_pointer_type
> may contain one or more DW_TAG_LLVM_annotation btf_type_tag tags.
> If DW_TAG_LLVM_annotation tags are present inside
> DW_TAG_pointer_type, for BTF encoding, pahole will need
> to follow [3] to generate a type chain like
>   var -> ptr -> tag2 -> tag1 -> ptr -> tag1 -> int
>
> This patch implemented dwarf_loader support. If a pointer type
> contains DW_TAG_LLVM_annotation tags, a new type
> btf_type_tag_ptr_type will be created which will store
> the pointer tag itself and all DW_TAG_LLVM_annotation tags.
> During recoding stage, the type chain will be formed properly
> based on the above example.
>
> An option "--skip_encoding_btf_type_tag" is added to disable
> this new functionality.
>
>   [1] https://reviews.llvm.org/D111199
>   [2] https://reviews.llvm.org/D113222
>   [3] https://reviews.llvm.org/D113496
> ---
>  dwarf_loader.c | 116 +++++++++++++++++++++++++++++++++++++++++++++++--
>  dwarves.h      |  33 +++++++++++++-
>  pahole.c       |   8 ++++
>  3 files changed, 153 insertions(+), 4 deletions(-)
>

[...]

> +
> +static struct tag *die__create_new_pointer_tag(Dwarf_Die *die, struct cu *cu,
> +                                              struct conf_load *conf)
> +{
> +       struct btf_type_tag_ptr_type *tag = NULL;
> +       struct btf_type_tag_type *annot;
> +       Dwarf_Die *cdie, child;
> +       const char *name;
> +       uint32_t id;
> +
> +       /* If no child tags or skipping btf_type_tag encoding, just create a new tag
> +        * and return
> +        */
> +       if (!dwarf_haschildren(die) || dwarf_child(die, &child) != 0 ||
> +           conf->skip_encoding_btf_type_tag)
> +               return tag__new(die, cu);
> +
> +       /* Otherwise, check DW_TAG_LLVM_annotation child tags */
> +       cdie = &child;
> +       do {
> +               if (dwarf_tag(cdie) == DW_TAG_LLVM_annotation) {

nit: inverting the condition and doing continue would reduce nestedness level

> +                       /* Only check btf_type_tag annotations */
> +                       name = attr_string(cdie, DW_AT_name, conf);
> +                       if (strcmp(name, "btf_type_tag") != 0)
> +                               continue;
> +
> +                       if (tag == NULL) {
> +                               /* Create a btf_type_tag_ptr type. */
> +                               tag = die__create_new_btf_type_tag_ptr_type(die, cu);
> +                               if (!tag)
> +                                       return NULL;
> +                       }
> +
> +                       /* Create a btf_type_tag type for this annotation. */
> +                       annot = die__create_new_btf_type_tag_type(cdie, cu, conf);
> +                       if (annot == NULL)
> +                               return NULL;
> +
> +                       if (cu__table_add_tag(cu, &annot->tag, &id) < 0)
> +                               return NULL;
> +
> +                       struct dwarf_tag *dtag = annot->tag.priv;
> +                       dtag->small_id = id;
> +                       cu__hash(cu, &annot->tag);
> +
> +                       /* For a list of DW_TAG_LLVM_annotation like tag1 -> tag2 -> tag3,
> +                        * the tag->tags contains tag3 -> tag2 -> tag1.
> +                        */
> +                       list_add(&annot->node, &tag->tags);
> +               }
> +       } while (dwarf_siblingof(cdie, cdie) == 0);
> +
> +       return tag ? &tag->tag : tag__new(die, cu);
> +}
> +
>  static struct tag *die__create_new_ptr_to_member_type(Dwarf_Die *die,
>                                                       struct cu *cu)
>  {
> @@ -1903,12 +1985,13 @@ static struct tag *__die__process_tag(Dwarf_Die *die, struct cu *cu,
>         case DW_TAG_const_type:
>         case DW_TAG_imported_declaration:
>         case DW_TAG_imported_module:
> -       case DW_TAG_pointer_type:
>         case DW_TAG_reference_type:
>         case DW_TAG_restrict_type:
>         case DW_TAG_unspecified_type:
>         case DW_TAG_volatile_type:
>                 tag = die__create_new_tag(die, cu);             break;
> +       case DW_TAG_pointer_type:
> +               tag = die__create_new_pointer_tag(die, cu, conf);       break;
>         case DW_TAG_ptr_to_member_type:
>                 tag = die__create_new_ptr_to_member_type(die, cu); break;
>         case DW_TAG_enumeration_type:
> @@ -2192,6 +2275,26 @@ static void lexblock__recode_dwarf_types(struct lexblock *tag, struct cu *cu)
>         }
>  }
>
> +static void dwarf_cu__recode_btf_type_tag_ptr(struct btf_type_tag_ptr_type *tag,
> +                                             uint32_t pointee_type)
> +{
> +       struct btf_type_tag_type *annot;
> +       struct dwarf_tag *annot_dtag;
> +       struct tag *prev_tag;
> +
> +       /* If tag->tags contains tag3 -> tag2 -> tag1, the final type chain
> +        * looks like:
> +        *   pointer -> tag3 -> tag2 -> tag1 -> pointee
> +        */

is the comment accurate or the final one should have looked like
pointer -> tag1 -> tag2 -> tag3 -> pointee? Basically, trying to
understand if the final BTF represents the source-level order of tags
or not?

> +       prev_tag = &tag->tag;
> +       list_for_each_entry(annot, &tag->tags, node) {
> +               annot_dtag = annot->tag.priv;
> +               prev_tag->type = annot_dtag->small_id;
> +               prev_tag = &annot->tag;
> +       }
> +       prev_tag->type = pointee_type;
> +}
> +

[...]
