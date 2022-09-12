Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3D65B5C47
	for <lists+bpf@lfdr.de>; Mon, 12 Sep 2022 16:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiILOes (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Sep 2022 10:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiILOer (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Sep 2022 10:34:47 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7705EBC06
        for <bpf@vger.kernel.org>; Mon, 12 Sep 2022 07:34:43 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id y15so4625820ilq.4
        for <bpf@vger.kernel.org>; Mon, 12 Sep 2022 07:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=uSNloWYZXeJ/bGiG6RlXcE+UXYwpbFu6cCORbO6KzzI=;
        b=Q8bnOSE6hYUb51utVqyoeFrHhN4gANrlFRqEme/1Zpr7jUnb60j0Ooc5FnALOpWveJ
         q2kQBDh6YNlLllMh7lEsETMhv9BZbGDG8WAR9UUtDLHWGb/ik/CoWJJ1ykLnBaeN9VDv
         P6hNCf+Sm1O1RyNZnqt/82+q1q0wbY9SuuCvbAZkPysccs9yqwlUZHa03eYRi9wdpUYX
         YTOXY5f3bQUbZz5LtbjMRLGcx2Yb+qSfJyWU4xuH284uqTVhWNuRkiVNDzyB7Nwr31mQ
         Dwy5bnJd80o69iPnigYjqYI4EVPAdHZUKNv5RpbUin1ZvgQK7uUj902WQw60OrLlYtGA
         XtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=uSNloWYZXeJ/bGiG6RlXcE+UXYwpbFu6cCORbO6KzzI=;
        b=xTgLIuOOKPNJKD1Ink0lgE8RkpyPxXt71gurGu/XTnl5ikVt7fXh42sx/h8L48DnKZ
         NwgDU7GI8BcqvP4TH/pNWOuY8+1Vb+S8LrHwZTfBc06y10E13gODJGXKYGXC/bb5P7A1
         VJfuJpQeGs5Bi88ozj2nQ5iRVDTyqG8SHHxB+MMLm59BKGGicbYMY4nJMV4SoEIeNt2c
         LvOXqrTt3j+uqMIvGviKi4IhssHKbSzqohybmWY5qiLzUHL55V2GRAANsRtXJpAwNr3w
         qL3AP2Y81Wb0wFY966t/zRqHUbfje5mhieX2u3I0QpdqD0sZwNLcW3zoq9lljkXengxh
         xdmQ==
X-Gm-Message-State: ACgBeo3hJVlJdzweeUMXwOdl5R8DKRwB/uLstZCE4xX9Qk57Nwt3zg8D
        7qinww99Egu6L4q3RpV5dYSFT3ix0Mx+yeLBwrM=
X-Google-Smtp-Source: AA6agR7n/dJvMElTz5+VzhYaD9h6t7083RSNh1sHoW193cz7zCpMEOrILjZWGoKK/6zdLcjutDp4VkyfeGVmZen4TfI=
X-Received: by 2002:a05:6e02:198b:b0:2f2:d90:22a6 with SMTP id
 g11-20020a056e02198b00b002f20d9022a6mr10195759ilf.219.1662993283083; Mon, 12
 Sep 2022 07:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220912101106.2765921-1-davemarchevsky@fb.com> <20220912101106.2765921-2-davemarchevsky@fb.com>
In-Reply-To: <20220912101106.2765921-2-davemarchevsky@fb.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Mon, 12 Sep 2022 16:34:05 +0200
Message-ID: <CAP01T76YeOQLfYBX+63Z+cbF+xZUH-4FYG3MyNTiKtP8fLPGtw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: Consider all mem_types compatible for
 map_{key,value} args
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Liam Wisehart <liamwisehart@fb.com>
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

On Mon, 12 Sept 2022 at 12:24, Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> After the previous patch, which added PTR_TO_MEM types to
> map_key_value_types, the only difference between map_key_value_types and
> mem_types sets is PTR_TO_BUF, which is in the latter set but not the
> former.
>
> Helpers which expect ARG_PTR_TO_MAP_KEY or ARG_PTR_TO_MAP_VALUE
> already effectively expect a valid blob of arbitrary memory that isn't
> necessarily explicitly associated with a map. When validating a
> PTR_TO_MAP_{KEY,VALUE} arg, the verifier expects meta->map_ptr to have
> already been set, either by an earlier ARG_CONST_MAP_PTR arg, or custom
> logic like that in process_timer_func or process_kptr_func.
>
> So let's get rid of map_key_value_types and just use mem_types for those
> args.
>
> This has the effect of adding PTR_TO_BUF to the set of compatible types
> for ARG_PTR_TO_MAP_KEY and ARG_PTR_TO_MAP_VALUE.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---

I'm wondering how it is safe when PTR_TO_BUF aliases map_value we are updating.

User can now do e.g. in array map:
map_iter(ctx)
  bpf_map_update_elem(map, ctx->key, ctx->value, 0);

Technically such overlapping memcpy is UB.

Looks like for this particular case, overlap will always be exact.
Such aliasing pointers always have fixed size memory.
If offset was added for partial overlap, it would not satisfy
value_size requirement and users won't be able to pass the pointer.
dynptr_from_mem may be a problem, but even there you need to obtain a
data slice of at least value_size, if an offset is added
slice will always be < value_size.

So it seems we only need to care about dst == src, and should be using
memmove when dst == src?

PS: Also it would be better to split verifier and selftest changes in
patch 1 into separate patches.

>  kernel/bpf/verifier.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d093618aed99..ae2259d782bb 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5619,18 +5619,6 @@ struct bpf_reg_types {
>         u32 *btf_id;
>  };
>
> -static const struct bpf_reg_types map_key_value_types = {
> -       .types = {
> -               PTR_TO_STACK,
> -               PTR_TO_PACKET,
> -               PTR_TO_PACKET_META,
> -               PTR_TO_MAP_KEY,
> -               PTR_TO_MAP_VALUE,
> -               PTR_TO_MEM,
> -               PTR_TO_MEM | MEM_ALLOC,
> -       },
> -};
> -
>  static const struct bpf_reg_types sock_types = {
>         .types = {
>                 PTR_TO_SOCK_COMMON,
> @@ -5691,8 +5679,8 @@ static const struct bpf_reg_types timer_types = { .types = { PTR_TO_MAP_VALUE }
>  static const struct bpf_reg_types kptr_types = { .types = { PTR_TO_MAP_VALUE } };
>
>  static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
> -       [ARG_PTR_TO_MAP_KEY]            = &map_key_value_types,
> -       [ARG_PTR_TO_MAP_VALUE]          = &map_key_value_types,
> +       [ARG_PTR_TO_MAP_KEY]            = &mem_types,
> +       [ARG_PTR_TO_MAP_VALUE]          = &mem_types,
>         [ARG_CONST_SIZE]                = &scalar_types,
>         [ARG_CONST_SIZE_OR_ZERO]        = &scalar_types,
>         [ARG_CONST_ALLOC_SIZE_OR_ZERO]  = &scalar_types,
> --
> 2.30.2
>
