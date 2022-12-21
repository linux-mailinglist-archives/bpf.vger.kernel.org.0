Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80403652AE5
	for <lists+bpf@lfdr.de>; Wed, 21 Dec 2022 02:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbiLUBRl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 20:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbiLUBRj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 20:17:39 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8DD100B
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 17:17:38 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id kw15so33291728ejc.10
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 17:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=//vvrCr9VKhA/WnEwOcQxIHFZ1MSlnGzEDzWbS+C8WQ=;
        b=W5pKH3IfZgvstdB+tdIgXByqTHnJSbjmJAc3fdqDxLfCTli6mxkHSdz15JAKmSUh9E
         qw/3J1Vi79Kjf9xmlrzsfDfBwzmXVf1pJmCP0D66GoFnsiU5Ypj83gb6f2vqa8FYXp/e
         iHF2vLudXkycqoH1kJ8nhO/eIzh8zQE9Rvh6/E9bwD6TRvc7V4Ih+rTiGFYfI/7yMTMR
         oemMNdztj8GHtdQBTxSmJLQk32ch6KTeybefvCa5NNl//pQjYNDiQq2ULWdys4kViUA1
         STB8oMzuDTAXCENjJkLv7OmsltCUwyBbgwCyZY6yjEY3/pgJ/5+aPwCvgg3wvykR9s8H
         IPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=//vvrCr9VKhA/WnEwOcQxIHFZ1MSlnGzEDzWbS+C8WQ=;
        b=VwLHYVz4h99toRaDClp8Demlv50FiL5y5FI7jYMT6+lXAlmIK4sqTntPljOzjUZKie
         YcuH7uqX1iKM5vDyUOYlh9zVYy4nEDmu7j5tb8ujwcwO8r4VKW3NcJarm8gP8xJq6Jp/
         A0D+GXAs+o1BaFxs/qJVbd0Pz0x+QPLxS0/ArEdHSIixH+id49aFh79nCVfwXmgp302k
         STebPWA8iF8kQl/Cwr10ikcM8niKfuizHOnjws+Sezr9rIim/27jh0B1neCdQnkOFExv
         rHSezVsFNqootXg7XsWJ2f+mZA1xIATP3uzZCDjy+1h50DHF5JUwunW5DbawQ0XxZsnL
         Ts0w==
X-Gm-Message-State: ANoB5plh7jjW3NhgUhlN5D0aUyrX5HhdSVxP52fVjpFMjIkhTvcdLkgQ
        QX2H/k5rhrI9llcwEic+7nNz4igMuigoMKU0MWaStyaH+qBbTQ==
X-Google-Smtp-Source: AA0mqf7JKrTlVxfz8GmL6W7d81MjDwpazDknmpjiqWdBb5Yp4yGKPg0HoZ6HpQL7lyJOoYUjvMHo1OQZyDrIc7fdKrQ=
X-Received: by 2002:a17:906:2b04:b0:7c0:dd4e:3499 with SMTP id
 a4-20020a1709062b0400b007c0dd4e3499mr22538604ejg.545.1671585457261; Tue, 20
 Dec 2022 17:17:37 -0800 (PST)
MIME-Version: 1.0
References: <20221221011538.3263935-1-martin.lau@linux.dev>
In-Reply-To: <20221221011538.3263935-1-martin.lau@linux.dev>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 20 Dec 2022 17:17:25 -0800
Message-ID: <CAEf4BzZq5cHGP=e+F1vue4L1kgUwz3Hw_bZ9GMtr9gA75rvT1A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: Reduce smap->elem_size
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com,
        Yonghong Song <yhs@fb.com>
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

On Tue, Dec 20, 2022 at 5:15 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> 'struct bpf_local_storage_elem' has an unused 56 byte padding at the
> end due to struct's cache-line alignment requirement. This padding
> space is overlapped by storage value contents, so if we use sizeof()
> to calculate the total size, we overinflate it by 56 bytes. Use
> offsetofend() instead to calculate more exact memory use.
>
> Acked-by: Yonghong Song <yhs@fb.com>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---
> v2:
>   Rephrase the commit message (Andrii and Yonghong)
>   Use offsetofend instead of offsetof (Andrii)
>
>  kernel/bpf/bpf_local_storage.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index b39a46e8fb08..e73fc70071b0 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -580,8 +580,8 @@ static struct bpf_local_storage_map *__bpf_local_storage_map_alloc(union bpf_att
>                 raw_spin_lock_init(&smap->buckets[i].lock);
>         }
>
> -       smap->elem_size =
> -               sizeof(struct bpf_local_storage_elem) + attr->value_size;
> +       smap->elem_size = offsetofend(struct bpf_local_storage_elem, sdata) +
> +               attr->value_size;

Heh, we raced down to a minute. Copy/pasting my latest reply from
original thread.

it just occurred to me
that your change can be written equivalently (but now I do think it's
cleaner) as:

smap->elem_size = offsetof(struct bpf_local_storage_elem,
sdata.data[attr->value_size]);


sdata is embedded struct, no pointer dereference, so single offsetof()
should be enough to peer inside it


Whichever you prefer, both versions work for me:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>
>         return smap;
>  }
> --
> 2.30.2
>
