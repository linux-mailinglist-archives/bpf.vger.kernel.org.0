Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5583569FBEA
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 20:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjBVTUl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 14:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjBVTUk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 14:20:40 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DB03D929
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 11:20:16 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id cq23so34461161edb.1
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 11:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=abhqOfIoGyexEbkPWoFhvobUykcRFpSZHUY2HUAoQGU=;
        b=K9C6F/ZVUOEiUzRwpxTOTjvRn2CgVp2/DzmjwX9K5H8AqQIZkMCsCd9f3RAiQidmAQ
         xoucGoA8a885vaf8j6+j6uYL9a+6wxhQwBNkOYhjxYXhnRhyF/GLrMaNHVqOpi6tl7Tj
         VI7iXUJD8BquHAfKCd6B6lql5JyBmCdI6vjcATEHsJvZ19lj+6cvUzYXtzZP4Z8dM+Qv
         GDaMKdzqEGmmZUgUqeh4vm0jUZykAatp05TpFNUEUMEYp9mAJKpi6UOhp+aDjDSnzI5M
         JvgigZ0CP+5mQomxTwJRjCcU3SPxW3EO5p0mz1gPterqJyQBhXB3fLR56Zaqgl5WKKjt
         5l6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=abhqOfIoGyexEbkPWoFhvobUykcRFpSZHUY2HUAoQGU=;
        b=C/K6EyF6x6a9QUDiWfY4s4XbAfiJs25gknQPwI2raxJZb4M8k4yX/5YwKEZD4luHvE
         yChuBLsvvNJwXkjtrEsCT2uQ7VHh/QhrC1kGSgH12ezI4txxNABCn/IcpdopiaDauVHY
         eR0Nh7KFcCWOmfXe8tQ1zOlDOpOr46Bwos12QtdYSj4C/ksBox9IypDe7Qp9AvN/IBaj
         IEW47pZgigVtglPzHO6BznNJfxN35R2EPL38sYdEBAUyKSUQYWa6T7S/kSA0QxEIp90m
         gxe8N/zskI4KxECTHfKxMF6VLUw4p8LgzDu9G6C1a4j+zjRvuDon4eb2sb8sfks0ppsb
         aNrA==
X-Gm-Message-State: AO0yUKUNPEyVFDJgVeWHxJOcwgGsMxnjNqS8U4q/EWnT9VslIn347WR5
        41HbBZ3VnQN1giS9qDk3D7WUiW4/ojXVDCTohs8=
X-Google-Smtp-Source: AK7set++aD57mZAeaX2NOIeXFjUxdZPnPoEQwWDE2zvfvzlhoobpG4H0ibQX1kCCj2vnqjFhrfMTx42CokrwQU8h7lc=
X-Received: by 2002:a17:906:eb4d:b0:87b:dce7:c245 with SMTP id
 mc13-20020a170906eb4d00b0087bdce7c245mr7888185ejb.3.1677093614715; Wed, 22
 Feb 2023 11:20:14 -0800 (PST)
MIME-Version: 1.0
References: <20230222014553.47744-1-laoar.shao@gmail.com> <20230222014553.47744-19-laoar.shao@gmail.com>
In-Reply-To: <20230222014553.47744-19-laoar.shao@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 22 Feb 2023 11:20:03 -0800
Message-ID: <CAADnVQ+09SYGH3Kz13wVSSu9k2Er55KA8FZLxC0j6ZpY4EbDKA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 18/18] bpf: enforce all maps having memory
 usage callback
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Ho-Ren Chuang <horenc@vt.edu>,
        Cong Wang <xiyou.wangcong@gmail.com>, bpf <bpf@vger.kernel.org>
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

On Tue, Feb 21, 2023 at 5:47 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> We have implemented memory usage callback for all maps, and we enforce
> any newly added map having a callback as well. Show a warning if it
> doesn't have.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/bpf/syscall.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index e12b03e..d814d4e 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -775,13 +775,9 @@ static fmode_t map_get_sys_perms(struct bpf_map *map, struct fd f)
>  /* Show the memory usage of a bpf map */
>  static u64 bpf_map_memory_usage(const struct bpf_map *map)
>  {
> -       unsigned long size;
> -
> -       if (map->ops->map_mem_usage)
> -               return map->ops->map_mem_usage(map);
> -
> -       size = round_up(map->key_size + bpf_map_value_size(map), 8);
> -       return round_up(map->max_entries * size, PAGE_SIZE);
> +       if (WARN_ON_ONCE(!map->ops->map_mem_usage))
> +               return 0;

Since all maps are converted, let's do this check earlier.
Like during find_and_alloc_map.
And without WARN.
