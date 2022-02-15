Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0E04B6250
	for <lists+bpf@lfdr.de>; Tue, 15 Feb 2022 06:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiBOFLZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Feb 2022 00:11:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiBOFLY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Feb 2022 00:11:24 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729B5127D4F
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 21:11:15 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id e79so22459921iof.13
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 21:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HLWQG1jjPLyKv8rsP8ZJITUZ5v4GNN9UICiXRtAeuxk=;
        b=GZUhxa/eYZ7mpSr3CWhl1n4cwa5mtrHC1i5kAtbxLPHcUye6wCwUuUGAHBAVoWsMYi
         JfRa0gUiS+ZgRJBag6A5zGwkKH7K4fSdGCCQuuS9VwVR7OW/ZoI9AqFqxyYxX5meJoO9
         IP1dnrLy1R8pF8JF+PH9l5q6dz2Dimmd8xg6eQqPdmZhNHban6pjhQz0nh2BJxjI96Vs
         dkSUmAhRn84/njPTBvZUy5HszHoJ6TCwuPqXpFyMb6ToBT6G32/OwVtGl13nxJ9S8nVu
         Tq/SzNf7l/aQrIqN0bbqMBnQPHGJ0F2LlMjxl6CQIoSUnyuhPCNnwjwIZMabHDNLsqE+
         sQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HLWQG1jjPLyKv8rsP8ZJITUZ5v4GNN9UICiXRtAeuxk=;
        b=TqdMMIPtSdB1DocZXBoIzjcN9MW7KYERSjOq1dJBG1GQx49uZyKujHDcTKZ8dFGn6B
         4pVWooEJOHm09ljYFI+P/b66Ab5d0iJQIiv8hqMq2q2f3uY9XQitwUsI3N4z6iS/8bZI
         H9H2KQcNZNy4U5xF8d4e2rb/+22E0Yly7b3qh9DyZly+8ToQ+ijQW06kbMNQ4bYJzzJX
         9ubwXnDGIWu8ynXCJTpliVjEU8PElSLFCWrTs/HOv4Nu61X2cubAgQOvm4QOe58C+YL+
         y+Zg5zfTyTb46Znjq7Xql7mL9ykzP8zo2OQREyDwb9QLz6q9Vol5ifW65B9X5mckG6sW
         WjKQ==
X-Gm-Message-State: AOAM5320/AZctOcUdPoN+ZIvc38cmfu1YTFxVegMNqZJm5JBVOl1RM0Z
        VQFWXrPmFen4cFI3syFP4AiIYTj4wdSdAZ/nTRqFquw2Da8=
X-Google-Smtp-Source: ABdhPJyH5GkiCb6y7OrdIj39hGJG/A2NEbQEj03qgJUjgkBWf7AVwIk8uiVhmcjBkr/cGESvdqF4EZCDlKw3zPphL5E=
X-Received: by 2002:a05:6602:2d86:: with SMTP id k6mr1404094iow.79.1644901874537;
 Mon, 14 Feb 2022 21:11:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1644884357.git.delyank@fb.com> <6c673f48d35fd06bc3490b00d4e6527b7e180d59.1644884357.git.delyank@fb.com>
In-Reply-To: <6c673f48d35fd06bc3490b00d4e6527b7e180d59.1644884357.git.delyank@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 14 Feb 2022 21:11:03 -0800
Message-ID: <CAEf4BzYZ7r3hpUsEQvkF-fpJhHdt0OXAxJxPvPDN-f4088bM6A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/1] bpftool: bpf skeletons assert type sizes
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 14, 2022 at 4:27 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> When emitting type declarations in skeletons, bpftool will now also emit
> static assertions on the size of the data/bss/rodata/etc fields. This
> ensures that in situations where userspace and kernel types have the same
> name but differ in size we do not silently produce incorrect results but
> instead break the build.
>
> This was reported in [1] and as expected the repro in [2] fails to build
> on the new size assert after this change.
>
>   [1]: Closes: https://github.com/libbpf/libbpf/issues/433
>   [2]: https://github.com/fuweid/iovisor-bcc-pr-3777
>
> Signed-off-by: Delyan Kratunov <delyank@fb.com>
> ---
>  tools/bpf/bpftool/gen.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 6f2e20be0c62..e7f11899437a 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -205,6 +205,29 @@ static int codegen_datasec_def(struct bpf_object *obj,
>                 off = sec_var->offset + sec_var->size;
>         }
>         printf("        } *%s;\n", sec_ident);
> +
> +       /* Walk through the section again to emit size asserts */
> +       sec_var = btf_var_secinfos(sec);
> +       for (i = 0; i < vlen; i++, sec_var++) {
> +               const struct btf_type *var = btf__type_by_id(btf, sec_var->type);
> +               const char *var_name = btf__name_by_offset(btf, var->name_off);
> +               __u32 var_type_id = var->type;
> +               __s64 var_size = btf__resolve_size(btf, var_type_id);
> +
> +               /* static variables are not exposed through BPF skeleton */
> +               if (btf_var(var)->linkage == BTF_VAR_STATIC)
> +                       continue;
> +
> +               var_ident[0] = '\0';
> +               strncat(var_ident, var_name, sizeof(var_ident) - 1);
> +               sanitize_identifier(var_ident);
> +
> +               printf("\tBPF_STATIC_ASSERT(");
> +               printf("sizeof(((struct %s__%s*)0)->%s) == %lld, ",
> +                      obj_name, sec_ident, var_ident, var_size);
> +               printf("\"unexpected size of field %s\");\n", var_ident);
> +       }
> +

So doing it right after each section really pollutes the layout of the
skeleton's struct and hurts readability a lot.

How about adding all those _Static_asserts in <skeleton__elf_bytes()
function, after the huge binary dump, to get it out of sight? I think
if we are doing asserts, we might as well validate that not just
sizes, but also each variable's offset within the section is right.

Those huge struct casts are also pretty verbose. What if we do
something like this (assuming we are in a separate function, but we
can easily just do that in __elf_bytes(). Let's use test_skeleton as
skeleton name

struct test_skeleton *s = (void *)0;

_Static_assert(sizeof(s->data->in1) == 4, "invalid size of in1");
_Static_assert(offsetof(typeof(*skel->data), in1) == 0, "invalid
offset of in1");
...
_Static_assert(sizeof(s->data_read_mostly->read_mostly_var) == 4,
"invalid size of read_mostly_var");
_Static_assert(offsetof(typeof(*skel->data_read_mostly),
read_mostly_var) == 0, "invalid offset of read_mostly_var");

(void)s; /* avoid unused variable warning */

WDYT?

>         return 0;
>  }
>
> @@ -756,6 +779,12 @@ static int do_skeleton(int argc, char **argv)
>                                                                             \n\
>                 #include <bpf/skel_internal.h>                              \n\
>                                                                             \n\
> +               #ifdef __cplusplus                                          \n\
> +               #define BPF_STATIC_ASSERT static_assert                     \n\
> +               #else                                                       \n\
> +               #define BPF_STATIC_ASSERT _Static_assert                    \n\
> +               #endif                                                      \n\

Maybe just:

#ifdef __cplusplus
#define _Static_assert static_assert
#endif

? Or that doesn't work?

BPF_STATIC_ASSERT sounds very BPF-y, while this should stay within the skeleton.

Also any such macro has to be #undef in this file, otherwise it will
"leak" into the user's code (as this is just a header file included in
user's .c files).



> +                                                                           \n\
>                 struct %1$s {                                               \n\
>                         struct bpf_loader_ctx ctx;                          \n\
>                 ",
> @@ -774,6 +803,12 @@ static int do_skeleton(int argc, char **argv)
>                 #include <stdlib.h>                                         \n\
>                 #include <bpf/libbpf.h>                                     \n\
>                                                                             \n\
> +               #ifdef __cplusplus                                          \n\
> +               #define BPF_STATIC_ASSERT static_assert                     \n\
> +               #else                                                       \n\
> +               #define BPF_STATIC_ASSERT _Static_assert                    \n\
> +               #endif                                                      \n\
> +                                                                           \n\
>                 struct %1$s {                                               \n\
>                         struct bpf_object_skeleton *skeleton;               \n\
>                         struct bpf_object *obj;                             \n\
> --
> 2.34.1
