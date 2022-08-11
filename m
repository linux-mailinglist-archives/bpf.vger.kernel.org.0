Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C895A59092E
	for <lists+bpf@lfdr.de>; Fri, 12 Aug 2022 01:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbiHKX3R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Aug 2022 19:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbiHKX3Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Aug 2022 19:29:16 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725B1A1D18;
        Thu, 11 Aug 2022 16:29:15 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z22so24801960edd.6;
        Thu, 11 Aug 2022 16:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=f8wt8SNd2Qsh50uz7XA5V0kZKP2oYkPYl+cvukWAopc=;
        b=gr3DmPE0Agzr15MpmdcUohB+1kh68chdTGxcplwXyylzs3pEy6OR/IyJfRVDa2NvuN
         TA6E1WvK2kimjqSxCf4uDi3srHWfdfrWhH4DISSICGwbGjaCVEmx1kx/hAQ/pyYhYcdr
         mbebVrCLRHxW5G5GdmFmJ6hI5mv8CLoWq0XyMGws7ueRLbrC3JtgACYMMg/aR12PNA6i
         1MmdnHaQZI5o+5HB1T1DfUYi5ihwesgj7dh40xy73x3OXj5qKbGoInOGMIgpayuxm7qX
         zs0Ak52HFVPB2p5ehrqrf1U1xBmZXCWUUd8n/oVstfNRuhysyfvMjLDIK4w/qQ2uu+km
         qbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=f8wt8SNd2Qsh50uz7XA5V0kZKP2oYkPYl+cvukWAopc=;
        b=REWdTr5/VrQZPmAlrZktRfQo4F9IvoG2WHduyVBFgapkL+RRWHkkc+ZvhnueN0mp/f
         FB3P/H7TCOjhWoyy2YxlaL0cmEcAtX3W2VUiSHS9CVxmx1o2E/qdK+AW8f5aeA4fL8Sh
         tobKxzfltI1TQCDHnx90daE/Kjs7hF8SHnYNKjIVOPneUprxqLZD07j6Nw5HyjP4Xv//
         4xci1yrBZ71acBWdCIGvP3hVCPsVm+O7SWr2FlRNYoOfFJLztq6nAac/Q2BBBpnq15qm
         WOEnaiSpDKvs1FsBNXXmzxwTzsZy8+qZPod/JBC65Wp7EDyoFV9UkgXkcnMiqyyPg8im
         XF9A==
X-Gm-Message-State: ACgBeo2BBDz3Ho1M01kalLq7st5HyV06bYm1cl9x5hJYYCnEK2LUyjFZ
        fYPhsjVqd5ClCDE3hWt+HlmU+Ai8Ub+iAD+QJ6k=
X-Google-Smtp-Source: AA6agR6ClXQNqxX2OKPmEV2c+upHqeyH2Cog2uXylTfAJ7xVH12/235vUeIrR+xFr9dvPquu7hFijXvfAagl6rM5KG0=
X-Received: by 2002:aa7:de8c:0:b0:440:3516:1813 with SMTP id
 j12-20020aa7de8c000000b0044035161813mr1271383edv.260.1660260553996; Thu, 11
 Aug 2022 16:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220808155341.2479054-1-void@manifault.com> <20220808155341.2479054-2-void@manifault.com>
In-Reply-To: <20220808155341.2479054-2-void@manifault.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 11 Aug 2022 16:29:02 -0700
Message-ID: <CAEf4BzZdOQwym4Q2QXtWF9uKhtKEb8cya-eQvLU3h3+7wES8UA@mail.gmail.com>
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
> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> index 2b9112b80171..2c6a4f2562a7 100644
> --- a/include/linux/bpf_types.h
> +++ b/include/linux/bpf_types.h
> @@ -126,6 +126,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_STRUCT_OPS, bpf_struct_ops_map_ops)
>  #endif
>  BPF_MAP_TYPE(BPF_MAP_TYPE_RINGBUF, ringbuf_map_ops)
>  BPF_MAP_TYPE(BPF_MAP_TYPE_BLOOM_FILTER, bloom_filter_map_ops)
> +BPF_MAP_TYPE(BPF_MAP_TYPE_USER_RINGBUF, user_ringbuf_map_ops)
>
>  BPF_LINK_TYPE(BPF_LINK_TYPE_RAW_TRACEPOINT, raw_tracepoint)
>  BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 7bf9ba1329be..a341f877b230 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -909,6 +909,7 @@ enum bpf_map_type {
>         BPF_MAP_TYPE_INODE_STORAGE,
>         BPF_MAP_TYPE_TASK_STORAGE,
>         BPF_MAP_TYPE_BLOOM_FILTER,
> +       BPF_MAP_TYPE_USER_RINGBUF,
>  };
>
>  /* Note that tracing related programs such as
> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index ded4faeca192..29e2de42df15 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
> @@ -38,12 +38,32 @@ struct bpf_ringbuf {
>         struct page **pages;
>         int nr_pages;
>         spinlock_t spinlock ____cacheline_aligned_in_smp;
> -       /* Consumer and producer counters are put into separate pages to allow
> -        * mapping consumer page as r/w, but restrict producer page to r/o.
> -        * This protects producer position from being modified by user-space
> -        * application and ruining in-kernel position tracking.
> +       /* Consumer and producer counters are put into separate pages to
> +        * allow each position to be mapped with different permissions.
> +        * This prevents a user-space application from modifying the
> +        * position and ruining in-kernel tracking. The permissions of the
> +        * pages depend on who is producing samples: user-space or the
> +        * kernel.
> +        *
> +        * Kernel-producer
> +        * ---------------
> +        * The producer position and data pages are mapped as r/o in
> +        * userspace. For this approach, bits in the header of samples are
> +        * used to signal to user-space, and to other producers, whether a
> +        * sample is currently being written.
> +        *
> +        * User-space producer
> +        * -------------------
> +        * Only the page containing the consumer position, and whether the
> +        * ringbuffer is currently being consumed via a 'busy' bit, are
> +        * mapped r/o in user-space. Sample headers may not be used to
> +        * communicate any information between kernel consumers, as a
> +        * user-space application could modify its contents at any time.
>          */
> -       unsigned long consumer_pos __aligned(PAGE_SIZE);
> +       struct {
> +               unsigned long consumer_pos;
> +               atomic_t busy;

one more thing, why does busy have to be exposed into user-space
mapped memory at all? Can't it be just a private variable in
bpf_ringbuf?

> +       } __aligned(PAGE_SIZE);
>         unsigned long producer_pos __aligned(PAGE_SIZE);
>         char data[] __aligned(PAGE_SIZE);
>  };

[...]
