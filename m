Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234D933CA88
	for <lists+bpf@lfdr.de>; Tue, 16 Mar 2021 02:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbhCPBDn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Mar 2021 21:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbhCPBDY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Mar 2021 21:03:24 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3571C06174A;
        Mon, 15 Mar 2021 18:03:23 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id p186so35166299ybg.2;
        Mon, 15 Mar 2021 18:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h66x3teGCQcy0fRIINxGcNQq5LSVOptp2d7+sCGalPg=;
        b=P/UYwD2MMOhepD71tPUDRUTJXkwNAxW5vxdOozDx10DaEu3WRWAlDVReo3PMd/T04x
         4EhkJb0fNYwgu/Dhf/jZ4TTN9dv1rec6DMnpnUAHAOEv9JpkZbyAThXVS+pUwHWVHl/8
         ZD2kZ/qbP+HrfaNkxfg2BqsK5ukIE0Y+HzGK0KH9Q4yKbmE7Vusm0I9+jp+baUMrmK5P
         qOxDIDnHMNc/lAjFuridXl7dmHDpNkNymLnavQj/CKMQpEltuGcgWJ3enX6/jQ42YjPh
         3VEuX4OmRPTVXjmXdQ9oboBo/Umhb4ajR1G2y37NIpaWBTLbkBkHMWadQv9+O4DuVtZY
         KuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h66x3teGCQcy0fRIINxGcNQq5LSVOptp2d7+sCGalPg=;
        b=KE/klCOepJSlNdIxltUkE7BvOOsFzseorxyLGphkdhT46eGAoGQs++KF6vQ7HNaqrC
         /ixBZxXLhin1lZegQZBT7YdOyC1HTvhw7FH01DBolSo8b5FCukN5u+Fri+J8wmblLMT2
         cIlJGYVwjC4u+YcL1fSSf9pPqjV5UfBvc/yYjFZIJ/o09ATJwy+jP013l53dnN0+7+vD
         LFLVD/KmtdYn4SIJvyM6LKRfpCD7O019ZK88GfhXt3j1nGFptpHywvAKiWIFIxBik7cH
         Eid8HtnYcO0KEOXhkP/gyC6gZEPkjan+W/Iy6/Y9uTDnejDFvvkXHYnPedX9cmrtlxzd
         qtrw==
X-Gm-Message-State: AOAM531ARhtNwO/BGPpJn7Avajee2OvOVhqEbwmsJzbKvLyNWt5mt/Pq
        vo7JT93JpLyx2nVgRldaLHwXlzdD5EQ9RJ/W53k=
X-Google-Smtp-Source: ABdhPJx4ejUHcvIuxH2o66c6VqYPSfRhRg/7UXQzqOp41JiOSWvXHGFUkK77jkzGuOjsVEBUII5ctSxD57h9UdUFcLc=
X-Received: by 2002:a25:3d46:: with SMTP id k67mr3298354yba.510.1615856603198;
 Mon, 15 Mar 2021 18:03:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210310220211.1454516-1-revest@chromium.org> <20210310220211.1454516-2-revest@chromium.org>
In-Reply-To: <20210310220211.1454516-2-revest@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 15 Mar 2021 18:03:11 -0700
Message-ID: <CAEf4BzZ6Lfmn9pEJSLVhROjkPGJO_mT4nHot8AOjZ_9HTC1rEQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Add a ARG_PTR_TO_CONST_STR argument type
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 10, 2021 at 2:02 PM Florent Revest <revest@chromium.org> wrote:
>
> This type provides the guarantee that an argument is going to be a const
> pointer to somewhere in a read-only map value. It also checks that this
> pointer is followed by a NULL character before the end of the map value.
>
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  include/linux/bpf.h   |  1 +
>  kernel/bpf/verifier.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index a25730eaa148..7b5319d75b3e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -308,6 +308,7 @@ enum bpf_arg_type {
>         ARG_PTR_TO_PERCPU_BTF_ID,       /* pointer to in-kernel percpu type */
>         ARG_PTR_TO_FUNC,        /* pointer to a bpf program function */
>         ARG_PTR_TO_STACK_OR_NULL,       /* pointer to stack or NULL */
> +       ARG_PTR_TO_CONST_STR,   /* pointer to a null terminated read-only string */
>         __BPF_ARG_TYPE_MAX,
>  };
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f9096b049cd6..c99b2b67dc8d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4601,6 +4601,7 @@ static const struct bpf_reg_types spin_lock_types = { .types = { PTR_TO_MAP_VALU
>  static const struct bpf_reg_types percpu_btf_ptr_types = { .types = { PTR_TO_PERCPU_BTF_ID } };
>  static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
>  static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
> +static const struct bpf_reg_types const_str_ptr_types = { .types = { PTR_TO_MAP_VALUE } };
>
>  static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
>         [ARG_PTR_TO_MAP_KEY]            = &map_key_value_types,
> @@ -4631,6 +4632,7 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
>         [ARG_PTR_TO_PERCPU_BTF_ID]      = &percpu_btf_ptr_types,
>         [ARG_PTR_TO_FUNC]               = &func_ptr_types,
>         [ARG_PTR_TO_STACK_OR_NULL]      = &stack_ptr_types,
> +       [ARG_PTR_TO_CONST_STR]          = &const_str_ptr_types,
>  };
>
>  static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> @@ -4881,6 +4883,45 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>                 if (err)
>                         return err;
>                 err = check_ptr_alignment(env, reg, 0, size, true);
> +       } else if (arg_type == ARG_PTR_TO_CONST_STR) {
> +               struct bpf_map *map = reg->map_ptr;
> +               int map_off, i;
> +               u64 map_addr;
> +               char *map_ptr;
> +
> +               if (!map || !bpf_map_is_rdonly(map)) {
> +                       verbose(env, "R%d does not point to a readonly map'\n", regno);
> +                       return -EACCES;
> +               }
> +
> +               if (!tnum_is_const(reg->var_off)) {
> +                       verbose(env, "R%d is not a constant address'\n", regno);
> +                       return -EACCES;
> +               }
> +
> +               if (!map->ops->map_direct_value_addr) {
> +                       verbose(env, "no direct value access support for this map type\n");
> +                       return -EACCES;
> +               }
> +
> +               err = check_helper_mem_access(env, regno,
> +                                             map->value_size - reg->off,
> +                                             false, meta);

you expect reg to be PTR_TO_MAP_VALUE, so probably better to directly
use check_map_access(). And double-check that register is of expected
type. just the presence of ref->map_ptr might not be sufficient?

> +               if (err)
> +                       return err;
> +
> +               map_off = reg->off + reg->var_off.value;
> +               err = map->ops->map_direct_value_addr(map, &map_addr, map_off);
> +               if (err)
> +                       return err;
> +
> +               map_ptr = (char *)(map_addr);

map_ptr is a very confusing name. str_ptr or value ptr?

> +               for (i = map_off; map_ptr[i] != '\0'; i++) {
> +                       if (i == map->value_size - 1) {

use strnchr()?

> +                               verbose(env, "map does not contain a NULL-terminated string\n");

map in the user-visible message is quite confusing, given that users
will probably use this through static variables, so maybe just "string
is not zero-terminated?" And it's not really a NULL, it's zero
character.

> +                               return -EACCES;
> +                       }
> +               }
>         }
>
>         return err;
> --
> 2.30.1.766.gb4fecdf3b7-goog
>
