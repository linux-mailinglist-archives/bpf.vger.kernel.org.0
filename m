Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E376A47D4
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 18:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjB0RWc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 12:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjB0RWQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 12:22:16 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8AD23D8F
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 09:22:09 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id ck15so29078299edb.0
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 09:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KIj/qYqwqM03qk3g6xOAvyJYrfd2GNCZLu/cMnLWjM8=;
        b=Q5XxRrqzutIWc+3fRt2HF3NPsnOIqLm/PN1cLUrWPD381oJQRbTqTiv4ijTi5t83On
         0R8u/CEz3LU72mIMHyAlBZ9cU7wg/X5ZNzfaJP8o3WqDQJ9wqHgfG1A+9sI/3xd7Yy1S
         wSo2WoAEBctgBQwbAf+yO5LCpsgQ54bKsIcVYeGpcgRKhGy5/WgRS+fj9U2EgSSOouFG
         59Zse3pkhysyUg4enfCqI7bx2ohLVOP1PAJBfM65HUbXvGukjH4KWqrjpMtAP0FFXggc
         zqSLBCKm5n+DIVamZHN569uV01M1IEWp30BL45TSQK1vHd/Xh3KPs4BFM1hiS9FJqXqB
         Fepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KIj/qYqwqM03qk3g6xOAvyJYrfd2GNCZLu/cMnLWjM8=;
        b=fMbonjS8xL6W5k9K5OIAFr2ulINVAMjf9g/NC0bSN4Fwf8iwC72QREe4a9dObUTyg9
         P6wzR85k6zWNHcqBxjyOinmmJcNNZZLYKJuKspmAPPpZp4Nh74g5FfOe26eSCg+fwtao
         XF1ZM9SNt09fUiyEd/PxCZcuGmIkNsbdV7dOnsm4oivWSH+GJFUQHJ3Ip+e0K4pvHHBW
         ZLABWdJZ9icPNPlSemnAIHX/NbW7dkN2f2xiSxXMftrMfB84e4jZjnDjeyDvEsphLcZu
         NxM/4CIiX1UuUlH/j8L0JLa/6bgssX20kmdrmO/VROpGb8tXdqXDvHDsFyT34qwpwLtX
         ePEg==
X-Gm-Message-State: AO0yUKX0vDVqw+gd1GH+2TTlIsgXwIwGCJHeUj2d/tuhx4o8h2RcLxX2
        L4TDA0hek2g975lmyOrYXWJQOvLrEmLpz/IHyU6qZq2/vIM=
X-Google-Smtp-Source: AK7set+qIQWaAGf+SMGsf/tw0PzMSy3X+wYBuhlSfjkD6ymyM88tbDmZCxSiNcF6DldJf05UHqotirQH4XUeOCy47qA=
X-Received: by 2002:a17:907:1dda:b0:8b0:fbd5:2145 with SMTP id
 og26-20020a1709071dda00b008b0fbd52145mr15338304ejc.15.1677518527846; Mon, 27
 Feb 2023 09:22:07 -0800 (PST)
MIME-Version: 1.0
References: <20230227152032.12359-1-laoar.shao@gmail.com> <20230227152032.12359-8-laoar.shao@gmail.com>
In-Reply-To: <20230227152032.12359-8-laoar.shao@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Feb 2023 09:21:55 -0800
Message-ID: <CAEf4BzZqOUGqhDgN3NzFO5aeSSxGtsVx_xzBkgHhws=MF5xD9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 07/18] bpf: ringbuf memory usage
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com, bpf@vger.kernel.org
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

On Mon, Feb 27, 2023 at 7:21 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> A new helper ringbuf_map_mem_usage() is introduced to calculate ringbuf
> memory usage.
>
> The result as follows,
> - before
> 15: ringbuf  name count_map  flags 0x0
>         key 0B  value 0B  max_entries 65536  memlock 0B
>
> - after
> 15: ringbuf  name count_map  flags 0x0
>         key 0B  value 0B  max_entries 65536  memlock 78424B
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/bpf/ringbuf.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index 80f4b4d..2bbf6e2 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
> @@ -336,6 +336,23 @@ static __poll_t ringbuf_map_poll_user(struct bpf_map *map, struct file *filp,
>         return 0;
>  }
>
> +static u64 ringbuf_map_mem_usage(const struct bpf_map *map)
> +{
> +       struct bpf_ringbuf_map *rb_map;
> +       struct bpf_ringbuf *rb;
> +       int nr_data_pages;
> +       int nr_meta_pages;
> +       u64 usage = sizeof(struct bpf_ringbuf_map);
> +
> +       rb_map = container_of(map, struct bpf_ringbuf_map, map);
> +       rb = rb_map->rb;

nit: rb_map seems unnecessary, I'd just go straight to rb

rb = container_of(map, struct bpf_ringbuf_map, map)->rb;

> +       usage += (u64)rb->nr_pages << PAGE_SHIFT;
> +       nr_meta_pages = RINGBUF_PGOFF + RINGBUF_POS_PAGES;

it would be cleaner to extract this into a constant
RINGBUF_NR_META_PAGES and use it in ringbuf_map_mem_usage and
bpf_ringbuf_area_alloc to keep them in sync

But other than that, looks good:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> +       nr_data_pages = map->max_entries >> PAGE_SHIFT;
> +       usage += (nr_meta_pages + 2 * nr_data_pages) * sizeof(struct page *);
> +       return usage;
> +}
> +
>  BTF_ID_LIST_SINGLE(ringbuf_map_btf_ids, struct, bpf_ringbuf_map)
>  const struct bpf_map_ops ringbuf_map_ops = {
>         .map_meta_equal = bpf_map_meta_equal,
> @@ -347,6 +364,7 @@ static __poll_t ringbuf_map_poll_user(struct bpf_map *map, struct file *filp,
>         .map_update_elem = ringbuf_map_update_elem,
>         .map_delete_elem = ringbuf_map_delete_elem,
>         .map_get_next_key = ringbuf_map_get_next_key,
> +       .map_mem_usage = ringbuf_map_mem_usage,
>         .map_btf_id = &ringbuf_map_btf_ids[0],
>  };
>
> @@ -361,6 +379,7 @@ static __poll_t ringbuf_map_poll_user(struct bpf_map *map, struct file *filp,
>         .map_update_elem = ringbuf_map_update_elem,
>         .map_delete_elem = ringbuf_map_delete_elem,
>         .map_get_next_key = ringbuf_map_get_next_key,
> +       .map_mem_usage = ringbuf_map_mem_usage,
>         .map_btf_id = &user_ringbuf_map_btf_ids[0],
>  };
>
> --
> 1.8.3.1
>
