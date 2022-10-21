Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DB56081F8
	for <lists+bpf@lfdr.de>; Sat, 22 Oct 2022 01:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiJUXEl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 19:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJUXEk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 19:04:40 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8204B3B453
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 16:04:37 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g27so11167606edf.11
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 16:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BNeYBdiKc8rrr5BT7yXK8Yancac/6zd3DXsTbmGntiM=;
        b=hOh1vVBzjgtXfhgAXcKuju2Cs0wMRbHwSknlljHU4qiXUQkkfOmOve1Mv0ZIHzjTgS
         8G3XB7fATEvF9Nlh7M6+DXf6pbGbNulOO/3rxf9vwwccIfI1UUxMArGgNd6xXzg3dMtq
         NYKaKUN44aFQgycPfoAe3B/dT4CBazBZHGmR2AMV+rymuFWA8I0isZ62Awn6vZgWzk53
         9dIHOJNjt9NQmW0jGjpGj61UZpnaASTq5suJg0gqOPe7Z1mNCC5CdYbG4cNHWUIxOfTo
         PXPhSsXyX1tizMSHdh37lykCtOCuuUJD3VGrbPar0TyLzjpq+nQP5sdA237gJpKHoqdl
         +ayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BNeYBdiKc8rrr5BT7yXK8Yancac/6zd3DXsTbmGntiM=;
        b=BAhAiXIn8y6dSX64EMt5gUcPBfWUpEAzsnoFvaLgkUk2SYInA7/pfDT2TkbLheRuQU
         GVh91ndnlHPKLA0LyWq9hy2dyZGXByfZ9sXykODego3K6+95ntFv/HnLF228JiGj4AlD
         Dzy/Pc37DRYxeZzMyIqVRt3/xxoQ4bdHRoOTQWSi7Kzaw92NnHheXhzkaC0L3j6x1DiS
         ZxNl0QWbUTLVa5d5O7vQzZiLKnHEuI/RpAb/McNE4WSlObgHPZpAaVu+CZb7Pc44xnjn
         /S+iBwZ22QqikMHikRVBrDmC4V5KzgUnpE11SQL3k69XhzCW6WJl+GL6dAh9z36nwlHw
         QStw==
X-Gm-Message-State: ACrzQf0yj5c3j/y50O18iR01ulj1Th+1MPdLQ89FfzdqizPbjnDx6BDT
        pNxGATu1i+qfHUXMLNIUXkqNgIDdQpdstxys93E=
X-Google-Smtp-Source: AMsMyM47W07OFiRffgoE0JZ1FARoWVr/QyIs81v4w+zIJe4Fr7un06J8wCxF5wPLPq/1ydt9Oz7P/ZE8xBfuLkIKkZo=
X-Received: by 2002:a05:6402:5406:b0:452:1560:f9d4 with SMTP id
 ev6-20020a056402540600b004521560f9d4mr19877588edb.333.1666393475963; Fri, 21
 Oct 2022 16:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <20221020160721.4030492-1-davemarchevsky@fb.com> <20221020160721.4030492-2-davemarchevsky@fb.com>
In-Reply-To: <20221020160721.4030492-2-davemarchevsky@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 21 Oct 2022 16:04:23 -0700
Message-ID: <CAEf4BzYK939fgyc3LwNvoz3vPk2avyskP_3wRZO344irubXPtg@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/4] bpf: Consider all mem_types compatible
 for map_{key,value} args
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 20, 2022 at 9:07 AM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> After the previous patch, which added PTR_TO_MEM | MEM_ALLOC type
> map_key_value_types, the only difference between map_key_value_types and
> mem_types sets is PTR_TO_BUF and PTR_TO_MEM, which are in the latter set
> but not the former.
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
> This has the effect of adding PTR_TO_BUF and PTR_TO_MEM to the set of
> compatible types for ARG_PTR_TO_MAP_KEY and ARG_PTR_TO_MAP_VALUE.
>
> PTR_TO_BUF is used by various bpf_iter implementations to represent a
> chunk of valid r/w memory in ctx args for iter prog.
>
> PTR_TO_MEM is used by networking, tracing, and ringbuf helpers to
> represent a chunk of valid memory. The PTR_TO_MEM | MEM_ALLOC
> type added in previous commmit is specific to ringbuf helpers.

typo: s/commmit/commit/ (but not worth reposting just to fix this)

btw, I have a strong desire to change PTR_TO_MEM | MEM_ALLOC into its
own PTR_TO_RINGBUF_RECORD (or something less verbose), it's very
confusing that "MEM_ALLOC" is very crucially *a ringbuf record*
pointer. Can't be anything else, but name won't suggest this, we'll
trip ourselves over this in the future.

> Presence or absence of MEM_ALLOC doesn't change the validity of using
> PTR_TO_MEM as a map_{key,val} input.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
> v1 -> v5: lore.kernel.org/bpf/20220912101106.2765921-2-davemarchevsky@fb.com
>
>   * This patch was dropped in v2 as I had no concrete usecase for
>     PTR_TO_BUF and PTR_TO_MEM w/o MEM_ALLOC. Andrii encouraged me to
>     re-add the patch as we both share desire to eventually cleanup all
>     these separate "valid chunk of memory" types. Starting to treat them
>     similarly is a good step in that direction.

Yep, 100% agree. We should try to generalize code and types for
conceptually similar things to make things a bit more manageable. As
another example, seems like ARG_PTR_TO_MAP_KEY and
ARG_PTR_TO_MAP_VALUE handling inside check_func_arg() is basically
identical, we just need to pass meta->raw_mode = false for
ARG_PTR_TO_MAP_KEY case to mark "read-only" operation. Something for
future clean ups, though.

This patch looks great, thanks!

Acked-by: Andrii Nakryiko <andrii@kernel.org>



>     * A usecase for PTR_TO_BUF is now demonstrated in patch 4 of this
>       series.
>     * PTR_TO_MEM w/o MEM_ALLOC is returned by bpf_{this,per}_cpu_ptr
>       helpers via RET_PTR_TO_MEM_OR_BTF_ID, but in both cases the return
>       type is also tagged MEM_RDONLY, which map helpers don't currently
>       accept (see patch 4 summary). So no selftest for this specific
>       case is added in the series, but by logic in this patch summary
>       there's no reason to treat it differently.
>
>  kernel/bpf/verifier.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 97351ae3e7a7..ddc1452cf023 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5634,17 +5634,6 @@ struct bpf_reg_types {
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
> -               PTR_TO_MEM | MEM_ALLOC,
> -       },
> -};
> -
>  static const struct bpf_reg_types sock_types = {
>         .types = {
>                 PTR_TO_SOCK_COMMON,
> @@ -5711,8 +5700,8 @@ static const struct bpf_reg_types dynptr_types = {
>  };
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
