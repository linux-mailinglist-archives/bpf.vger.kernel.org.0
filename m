Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12ADE626347
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 21:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbiKKU56 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 15:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbiKKU56 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 15:57:58 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1B985460
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 12:57:56 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id x2so9245128edd.2
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 12:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=31FrOSuiM8ZAEeJ8gcUkzRSnDKT+9wbVPVynSteb/rs=;
        b=BVxBP54XsOYRK+VPsBua9XMQPMAKhdldTu71knDQUgwIuhPPXQBDBLOAf4zhv/9eOK
         3gZnTP8S+FB8TXXp40C/LHlOdKfBV04ldftayNmz7nRRj+oRBcE4bgfTmZ5Mc5t8V04u
         5nKUP3XXcWUEfZdczPEMCeeYwUyx4kUaVn7VPO2KMNxIJwG82IlaUpXiVk07pc1ia0Lm
         aNl64+nKB4FOQeCl/EpGnODJfI0qAHc+eq2yyJoQoQzXqqZy87TID/7SLaqP3vkr7CRr
         U3fNLQoZf472UnAqwM+C/LT+wFnx6HONHjLMWZcHErhMCLS+mj056Efx9XBtV8wXDdwt
         nBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31FrOSuiM8ZAEeJ8gcUkzRSnDKT+9wbVPVynSteb/rs=;
        b=OX+9jy7i7iaLYfwnHwG65AgpsPl1eP/KA8OhAe4UUCW1Y0PFNUQLL44NfCZJ4a4/XD
         6BcKTQ/c2J79dC54U4Wfa9PxhUCk2gVNPtMjHD9Np6zpxNK93uWzAT9l1eCwcg4PDUd8
         +A5H+tHxP4UUci5BZxSEX9agXQUZxkYBDClJsmMf6Orrik2ytJMVknIAE407qGGN+F4O
         tefzi+eJTPadHW5upskyaaVSBns0P48CslD+g7v2FuKtDOKQfCgdiMunBPz5tCZzg/Rs
         euErfqnx+ptQb1gj2Yz51q7R/pLCdlC0rAK8YEQH/Wlk7O8DppNV1F6Y610zJLRvRc2l
         jGdw==
X-Gm-Message-State: ANoB5plYL6wgsGxsYFhIaOB70DFq8vSA0jrdAjMfES/1Jv2cE0Xlukkz
        LEfme3w/W/FCo91cawXifnk1WP/7XE/vp6V303o=
X-Google-Smtp-Source: AA0mqf480ZCEKnf4bguX6QamerzK6UJPEYmpdETYP2L8aBmDKj4J8y3yq6jHsxHYt9i2LjrwWOvUREc+X67IXqzeecI=
X-Received: by 2002:a05:6402:344f:b0:461:d726:438f with SMTP id
 l15-20020a056402344f00b00461d726438fmr3049681edc.333.1668200275403; Fri, 11
 Nov 2022 12:57:55 -0800 (PST)
MIME-Version: 1.0
References: <20221111092642.2333724-1-houtao@huaweicloud.com> <20221111092642.2333724-4-houtao@huaweicloud.com>
In-Reply-To: <20221111092642.2333724-4-houtao@huaweicloud.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Nov 2022 12:57:43 -0800
Message-ID: <CAEf4Bzb2i7M5EGOBxp0ky0GQ=D+cMBUc6TDq7HdjfcuLoF4oFA@mail.gmail.com>
Subject: Re: [PATCH bpf 3/4] libbpf: Handle size overflow for user ringbuf mmap
To:     Hou Tao <houtao@huaweicloud.com>, David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
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

On Fri, Nov 11, 2022 at 1:01 AM Hou Tao <houtao@huaweicloud.com> wrote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> Similar with the overflow problem on ringbuf mmap, in user_ringbuf_map()
> 2 * max_entries may overflow u32 when mapping writeable region.
>
> Fixing it by casting the size of writable mmap region into a __u64 and
> checking whether or not there will be overflow during mmap.
>
> Fixes: b66ccae01f1d ("bpf: Add libbpf logic for user-space ring buffer")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  tools/lib/bpf/ringbuf.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index c4bdc88af672..b34e61c538d7 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -355,6 +355,7 @@ static int user_ringbuf_map(struct user_ring_buffer *rb, int map_fd)
>  {
>         struct bpf_map_info info;
>         __u32 len = sizeof(info);
> +       __u64 wr_size;
>         void *tmp;
>         struct epoll_event *rb_epoll;
>         int err;
> @@ -391,8 +392,14 @@ static int user_ringbuf_map(struct user_ring_buffer *rb, int map_fd)
>          * simple reading and writing of samples that wrap around the end of
>          * the buffer.  See the kernel implementation for details.
>          */
> -       tmp = mmap(NULL, rb->page_size + 2 * info.max_entries,
> -                  PROT_READ | PROT_WRITE, MAP_SHARED, map_fd, rb->page_size);
> +       wr_size = rb->page_size + 2 * (__u64)info.max_entries;
> +       if (wr_size != (__u64)(size_t)wr_size) {
> +               pr_warn("user ringbuf: ring buf size (%u) is too big\n",
> +                       info.max_entries);
> +               return -E2BIG;
> +       }
> +       tmp = mmap(NULL, (size_t)wr_size, PROT_READ | PROT_WRITE, MAP_SHARED,
> +                  map_fd, rb->page_size);

same suggestions as in precious patch: s/wr_size/mmap_sz/ and let's
discuss if we should split one mmap into two?

cc'ed David as well

>         if (tmp == MAP_FAILED) {
>                 err = -errno;
>                 pr_warn("user ringbuf: failed to mmap data pages for map fd=%d: %d\n",
> --
> 2.29.2
>
