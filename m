Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0EB590920
	for <lists+bpf@lfdr.de>; Fri, 12 Aug 2022 01:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236654AbiHKXXQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Aug 2022 19:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236571AbiHKXXE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Aug 2022 19:23:04 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4966FA1D0A;
        Thu, 11 Aug 2022 16:23:03 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b16so24791240edd.4;
        Thu, 11 Aug 2022 16:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=/U91/4PX2cpKjtuOoFQknW+ecNHAJ1lj200SkSG5NGo=;
        b=DxMmdBcwHWCQnmnR8aPAu/oDtYp5pG3qc9c5fkyCudxd6XbS2J65kUUJJzH6Bx2LDX
         w04K8eTOjFSZkViAYrxQMSC0OCsdp7wO8uL1NtW2hCKi79BXG60PC8yjPiRFALDYmbbd
         13EKw3byU8q157quq1YdfbvhBq76/eYhEHm523Ur4WqGzYGbF05zwHFkTy2BwIpGsUyL
         ds01I74rRfICwbbH/wK4YJQniGgAuN7JkaPzEgOwSAy6VqudvNhRsOsNCA6oSeQOkbhu
         GNZD6RLgsJIOJFb4ezUZg44un0iA3VlUNVI4I8zb6fEV2fwpneJyNaG2BG4HAxh1gQ1L
         +v+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=/U91/4PX2cpKjtuOoFQknW+ecNHAJ1lj200SkSG5NGo=;
        b=6m0vaaz1hmrYxzLDVdWHnbY1R7m4b3XkJ6QV+4/wHPAJPht//4pPK1wuPKTatkUtFB
         gQJbXCHDGR0ubfyqyW6QBONIfzLSpSliqomp0FzrzdVsnSYaanHpt6LJW2DNEQ24uie8
         2fvTbkCGdx3Ycmv0xkH9Z6/7BowdODKK35Q2jzdL7dGwxLAPJaq0JWEmw9a6/Zj3tWG8
         QZFmrXh7ihIcvZfXvXCaGwW3LSYDvllN6YYSXQUkt3ejfgpVKhlnup42ttEQeRrKZJrY
         ubbzscobn0/0BNs1+3ZW1chauXKD3IHPZdDoQVB9B5lSBXLgZX1kr3BjK48g5KjoYSGU
         c8fw==
X-Gm-Message-State: ACgBeo1IfFw1M/evgJh+qnaUc8EbhOAPFVdV4c4tte83w1KcjZYwc9am
        S0MJd78AMuxs1SYj1rl7LeJ/1hcn0e90aDKW1vY=
X-Google-Smtp-Source: AA6agR4YPEfgR/bDb/MhvLucvwWk13IzKj8Ug1hoRV4YqMmscMNCnEKauuMNQsnhnOhifR0LhNha1i1Nm6DfUguKph4=
X-Received: by 2002:a05:6402:110a:b0:443:225c:6822 with SMTP id
 u10-20020a056402110a00b00443225c6822mr1155262edv.81.1660260181785; Thu, 11
 Aug 2022 16:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220808155341.2479054-1-void@manifault.com> <20220808155341.2479054-2-void@manifault.com>
In-Reply-To: <20220808155341.2479054-2-void@manifault.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 11 Aug 2022 16:22:50 -0700
Message-ID: <CAEf4BzbGEQ9rMHBaiex2wPEB2cOMXFNydpPUutko6P7UCK-UyQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] bpf: Define new BPF_MAP_TYPE_USER_RINGBUF map type
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        joannelkoong@gmail.com, linux-kernel@vger.kernel.org,
        Kernel-team@fb.com
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

On Mon, Aug 8, 2022 at 8:54 AM David Vernet <void@manifault.com> wrote:
>
> We want to support a ringbuf map type where samples are published from
> user-space to BPF programs. BPF currently supports a kernel -> user-space
> circular ringbuffer via the BPF_MAP_TYPE_RINGBUF map type. We'll need to
> define a new map type for user-space -> kernel, as none of the helpers
> exported for BPF_MAP_TYPE_RINGBUF will apply to a user-space producer
> ringbuffer, and we'll want to add one or more helper functions that would
> not apply for a kernel-producer ringbuffer.
>
> This patch therefore adds a new BPF_MAP_TYPE_USER_RINGBUF map type
> definition. The map type is useless in its current form, as there is no way
> to access or use it for anything until we add more BPF helpers. A follow-on
> patch will therefore add a new helper function that allows BPF programs to
> run callbacks on samples that are published to the ringbuffer.
>
> Signed-off-by: David Vernet <void@manifault.com>
> ---
>  include/linux/bpf_types.h      |  1 +
>  include/uapi/linux/bpf.h       |  1 +
>  kernel/bpf/ringbuf.c           | 70 +++++++++++++++++++++++++++++-----
>  kernel/bpf/verifier.c          |  3 ++
>  tools/include/uapi/linux/bpf.h |  1 +
>  tools/lib/bpf/libbpf.c         |  1 +
>  6 files changed, 68 insertions(+), 9 deletions(-)
>

[...]

>
> -static int ringbuf_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
> +static int ringbuf_map_mmap(struct bpf_map *map, struct vm_area_struct *vma,
> +                           bool kernel_producer)
>  {
>         struct bpf_ringbuf_map *rb_map;
>
>         rb_map = container_of(map, struct bpf_ringbuf_map, map);
>
>         if (vma->vm_flags & VM_WRITE) {
> -               /* allow writable mapping for the consumer_pos only */
> -               if (vma->vm_pgoff != 0 || vma->vm_end - vma->vm_start != PAGE_SIZE)
> +               if (kernel_producer) {
> +                       /* allow writable mapping for the consumer_pos only */
> +                       if (vma->vm_pgoff != 0 || vma->vm_end - vma->vm_start != PAGE_SIZE)
> +                               return -EPERM;
> +               /* For user ringbufs, disallow writable mappings to the
> +                * consumer pointer, and allow writable mappings to both the
> +                * producer position, and the ring buffer data itself.
> +                */
> +               } else if (vma->vm_pgoff == 0)
>                         return -EPERM;

the asymmetrical use of {} in one if branch and not using them in
another is extremely confusing, please don't do that

the way you put big comment inside the wrong if branch also throws me
off, maybe move it before return -EPERM instead with proper
indentation?

sorry for nitpicks, but I've been stuck for a few minutes trying to
figure out what exactly is happening here :)


>         } else {
>                 vma->vm_flags &= ~VM_MAYWRITE;
> @@ -242,6 +271,16 @@ static int ringbuf_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
>                                    vma->vm_pgoff + RINGBUF_PGOFF);
>  }
>
> +static int ringbuf_map_mmap_kern(struct bpf_map *map, struct vm_area_struct *vma)
> +{
> +       return ringbuf_map_mmap(map, vma, true);
> +}
> +
> +static int ringbuf_map_mmap_user(struct bpf_map *map, struct vm_area_struct *vma)
> +{
> +       return ringbuf_map_mmap(map, vma, false);
> +}

I wouldn't mind if you just have two separate implementations of
ringbuf_map_mmap for _kern and _user cases, tbh, probably would be
clearer as well

> +
>  static unsigned long ringbuf_avail_data_sz(struct bpf_ringbuf *rb)
>  {
>         unsigned long cons_pos, prod_pos;
> @@ -269,7 +308,7 @@ const struct bpf_map_ops ringbuf_map_ops = {
>         .map_meta_equal = bpf_map_meta_equal,
>         .map_alloc = ringbuf_map_alloc,
>         .map_free = ringbuf_map_free,
> -       .map_mmap = ringbuf_map_mmap,
> +       .map_mmap = ringbuf_map_mmap_kern,
>         .map_poll = ringbuf_map_poll,
>         .map_lookup_elem = ringbuf_map_lookup_elem,
>         .map_update_elem = ringbuf_map_update_elem,
> @@ -278,6 +317,19 @@ const struct bpf_map_ops ringbuf_map_ops = {
>         .map_btf_id = &ringbuf_map_btf_ids[0],
>  };
>

[...]
