Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2578619001
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 06:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiKDFa0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 01:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiKDFaZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 01:30:25 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9FD26105
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 22:30:24 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id f27so10629794eje.1
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 22:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0Mibve3JTYSoeQIOiqF5nz7UdakU0DvcO22PCs+dIn8=;
        b=iz7FbFSHjx5krG8d63mkEDqgwX+hr1pmnj0MDnuyWCjYnW25vf2KzJ6KTECC9+UsMe
         pkHyp4KpHYrZzsF+vfU7W+jxp2aFfs1H7Ej7OxaDqlhm+SiNsJSW7dHpsT8sSynHbWRz
         /DTOlXvKSmI4hXtDMD0f8dSJu6EzObqwwzImcx7DPTbs2IU5hlDZBBCh/In7qstTmEaF
         XpZwCi0wj9n4Y4c6jFxPB8cdH/Z8tYQ7kKWvR7Mh3Qm2rxdXU6di/TECs9xuCRxRa+d9
         5YFyZl5K+Jx+VwX20o1xCAnb9Zs7czfJbwi2WKNfbyEWT/p8ktv/VPxzuJgJIO+AAF3x
         0FnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Mibve3JTYSoeQIOiqF5nz7UdakU0DvcO22PCs+dIn8=;
        b=Dz9FR7sXJvig7ZaKctGD5Vd+QP+8pgKg0L5TvWnLN731NKWKHaVXrMNyMGHkZ8jxIF
         4dEoghoSYA2Nw4qgMQfDOpkuaW7OVXXqPdQ5irRRaa/EhCwtUL7dzPuJwj8QkkRyXwgB
         x5P3xXUjBxs1Yz42PmCXQpnwb+bE3Ij6z8aZ2dFeNYDyV4Uzpry3HRXS8gJXVNIMV2Ht
         vlAfSjbn1oIfl6lqXv6yJ8WM5na8F4mYQwlA+B8cGADx1BaVi1k5NSq1u3AgCyDVMvwS
         rTqcDEYd7M6yEkeeU+TXiQDCUxweRSnoO/V7flyKkTwPYZA6l0JTcabq1Wt64LoDmonr
         DgfQ==
X-Gm-Message-State: ACrzQf1jFSY5kKYUjFtOHCWhME8DemaTaHbTzs3VNjbrlnj/1foDNuAR
        a5LcUHYs7ec6r0uv1T4NqQ8dGqUt2EG/8oUdSwds7q09
X-Google-Smtp-Source: AMsMyM6OCSipJ+DGIHqYjmDjU16bCK/6K/ldKe/BFIIzKXqJUekzdO/3U2iEd32y0PkUCi1NiDJCogR+7JqnEoapQEg=
X-Received: by 2002:a17:906:8a73:b0:7ae:3962:47e7 with SMTP id
 hy19-20020a1709068a7300b007ae396247e7mr460333ejc.502.1667539823179; Thu, 03
 Nov 2022 22:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <20221103191013.1236066-1-memxor@gmail.com> <20221103191013.1236066-8-memxor@gmail.com>
In-Reply-To: <20221103191013.1236066-8-memxor@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 3 Nov 2022 22:30:11 -0700
Message-ID: <CAADnVQ+E8T3dRowYzzVfxXEcE1ntNRvF4YSgaCmGhNfO6Q0CaQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 07/24] bpf: Consolidate spin_lock, timer
 management into btf_record
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
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

On Thu, Nov 3, 2022 at 12:11 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>  static int bpf_map_alloc_off_arr(struct bpf_map *map)
>  {
> -       bool has_spin_lock = map_value_has_spin_lock(map);
> -       bool has_timer = map_value_has_timer(map);
>         bool has_fields = !IS_ERR_OR_NULL(map);
>         struct btf_field_offs *fo;
> -       u32 i;
> +       struct btf_record *rec;
> +       u32 i, *off;
> +       u8 *sz;
>
> -       if (!has_spin_lock && !has_timer && !has_fields) {
> +       if (!has_fields) {
>                 map->field_offs = NULL;
>                 return 0;
>         }
> @@ -970,32 +987,14 @@ static int bpf_map_alloc_off_arr(struct bpf_map *map)
>                 return -ENOMEM;
>         map->field_offs = fo;
>
> -       fo->cnt = 0;
> -       if (has_spin_lock) {
> -               i = fo->cnt;
> -
> -               fo->field_off[i] = map->spin_lock_off;
> -               fo->field_sz[i] = sizeof(struct bpf_spin_lock);
> -               fo->cnt++;
> -       }
> -       if (has_timer) {
> -               i = fo->cnt;
> -
> -               fo->field_off[i] = map->timer_off;
> -               fo->field_sz[i] = sizeof(struct bpf_timer);
> -               fo->cnt++;
> -       }
> -       if (has_fields) {
> -               struct btf_record *rec = map->record;
> -               u32 *off = &fo->field_off[fo->cnt];
> -               u8 *sz = &fo->field_sz[fo->cnt];
> -
> -               for (i = 0; i < rec->cnt; i++) {
> -                       *off++ = rec->fields[i].offset;
> -                       *sz++ = btf_field_type_size(rec->fields[i].type);
> -               }
> -               fo->cnt += rec->cnt;
> +       rec = map->record;
> +       off = &fo->field_off[fo->cnt];
> +       sz = &fo->field_sz[fo->cnt];

Another bug that would have been obvious if you run any tests.
(fo->cnt contains garbage)

I'm surprised by the amount of issues in the series.

> +       for (i = 0; i < rec->cnt; i++) {
> +               *off++ = rec->fields[i].offset;
> +               *sz++ = btf_field_type_size(rec->fields[i].type);
>         }

Anyway, pushed this patch as well after fixing this bug.
