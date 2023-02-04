Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A1668A7C2
	for <lists+bpf@lfdr.de>; Sat,  4 Feb 2023 03:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjBDCP5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 21:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjBDCP5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 21:15:57 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195E465EDF
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 18:15:56 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id g13so2274167ple.10
        for <bpf@vger.kernel.org>; Fri, 03 Feb 2023 18:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YS7B6O70LhbZ3Kdw/RBfmMHaegKvoCD2PlKa2IVQqU=;
        b=qYTOq6/le9oPQ5cZxjM5k208A3lNIcnE88Ui8w2oxjhwPm31u27bSWiF596qVa4xju
         YXngzA06e3W2tWpHiu7P47PIwxg7bQg/kCCZd8dwMxf5LQsQjRerHDLlQ8r75UqyocjL
         zAvkzavYGBFyX31Th/2HNeBIWHrRpB6BJOKxx/HKBYU7PodKbv7+4oDqR4kcBny67kFe
         Z0J4Z9RdWNaj+3jwoauBU83bYC9FVYEsrusz9uTvY491zB2UL5C7ltnoskLP6w3pcvUR
         RxUv2d62EuoJ16HZi4TttjCiQpftmhVSVJZtVJTYXQ3s9Xj3c2DiTD41ibBMUFuqwAgB
         rHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2YS7B6O70LhbZ3Kdw/RBfmMHaegKvoCD2PlKa2IVQqU=;
        b=Ldugnqcz0Hsm1A9La8h25X1Hgj3JDMPPsvhSJUeBXx3KI85MUZgBW7X6uuSQGSvj8+
         2fUaPOdWyqThZ1jRsOxkWqo7v7lJCnVhD32ueFFmmj6rFLp/+zMCwjLlk6xlWRzGgqg7
         oNPEaalu8JWez2eipm/5fY9LHxpXa8pDz+DmwGT6+fmNGzy4i2T12QfrzxJImtFbsoFS
         V0ImGE1Lcd1/iQmylfhNzNqRPDFOGQpWk8ZZtoB1uKrCuEyG+bX8cg07P9NcjARl1hQ9
         Ltg2YTod2nivtQL+pGi6T0ZVq/NAA/7Er6BbamQPYU7mXapJy0RSSoCjOZgZKG5msJ+8
         oKFg==
X-Gm-Message-State: AO0yUKWlyI4yqsXDFL7Mctbdquigrg1KbDnKuF2SAMBl6cF+cDXdhcMB
        bofBHnWGJ77C1RBOkZiSIos=
X-Google-Smtp-Source: AK7set9hK8dUsqOb7e3jfmbRblXFhWo9Dfbm1nGlu1Cd3l9cKMuAWF7ZDYR2dX0FffYAvhrXAntZig==
X-Received: by 2002:a17:902:c402:b0:198:e63d:9a3c with SMTP id k2-20020a170902c40200b00198e63d9a3cmr3551939plk.44.1675476955500;
        Fri, 03 Feb 2023 18:15:55 -0800 (PST)
Received: from localhost ([98.97.116.12])
        by smtp.gmail.com with ESMTPSA id d19-20020a170902c19300b001947c22185bsm2252508pld.184.2023.02.03.18.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 18:15:54 -0800 (PST)
Date:   Fri, 03 Feb 2023 18:15:53 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, tj@kernel.org, dennis@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, vbabka@suse.cz, urezki@gmail.com
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Message-ID: <63ddbfd9ae610_6bb1520861@john.notmuch>
In-Reply-To: <20230202014158.19616-1-laoar.shao@gmail.com>
References: <20230202014158.19616-1-laoar.shao@gmail.com>
Subject: RE: [PATCH bpf-next 0/7] bpf, mm: bpf memory usage
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yafang Shao wrote:
> Currently we can't get bpf memory usage reliably. bpftool now shows the
> bpf memory footprint, which is difference with bpf memory usage. The
> difference can be quite great between the footprint showed in bpftool
> and the memory actually allocated by bpf in some cases, for example,
> 
> - non-preallocated bpf map
>   The non-preallocated bpf map memory usage is dynamically changed. The
>   allocated elements count can be from 0 to the max entries. But the
>   memory footprint in bpftool only shows a fixed number.
> - bpf metadata consumes more memory than bpf element 
>   In some corner cases, the bpf metadata can consumes a lot more memory
>   than bpf element consumes. For example, it can happen when the element
>   size is quite small.

Just following up slightly on previous comment.

The metadata should be fixed and knowable correct? What I'm getting at
is if this can be calculated directly instead of through a BPF helper
and walking the entire map.

> 
> We need a way to get the bpf memory usage especially there will be more
> and more bpf programs running on the production environment and thus the
> bpf memory usage is not trivial.

In our environments we track map usage so we always know how many entries
are in a map. I don't think we use this to calculate memory footprint
at the moment, but just for map usage. Seems though once you have this
calculating memory footprint can be done out of band because element
and overheads costs are fixed.

> 
> This patchset introduces a new map ops ->map_mem_usage to get the memory
> usage. In this ops, the memory usage is got from the pointers which is
> already allocated by a bpf map. To make the code simple, we igore some
> small pointers as their size are quite small compared with the total
> usage.
> 
> In order to get the memory size from the pointers, some generic mm helpers
> are introduced firstly, for example, percpu_size(), vsize() and kvsize(). 
> 
> This patchset only implements the bpf memory usage for hashtab. I will
> extend it to other maps and bpf progs (bpf progs can dynamically allocate
> memory via bpf_obj_new()) in the future.

My preference would be to calculate this out of band. Walking a
large map and doing it in a critical section to get the memory
usage seems not optimal 

> 
> The detailed result can be found in patch #7.
> 
> Patch #1~#4: Generic mm helpers
> Patch #5   : Introduce new ops
> Patch #6   : Helpers for bpf_mem_alloc
> Patch #7   : hashtab memory usage
> 
> Future works:
> - extend it to other maps
> - extend it to bpf prog
> - per-container bpf memory usage 
> 
> Historical discussions,
> - RFC PATCH v1 mm, bpf: Add BPF into /proc/meminfo
>   https://lwn.net/Articles/917647/  
> - RFC PATCH v2 mm, bpf: Add BPF into /proc/meminfo
>   https://lwn.net/Articles/919848/
> 
> Yafang Shao (7):
>   mm: percpu: fix incorrect size in pcpu_obj_full_size()
>   mm: percpu: introduce percpu_size()
>   mm: vmalloc: introduce vsize()
>   mm: util: introduce kvsize()
>   bpf: add new map ops ->map_mem_usage
>   bpf: introduce bpf_mem_alloc_size()
>   bpf: hashtab memory usage
> 
>  include/linux/bpf.h           |  2 ++
>  include/linux/bpf_mem_alloc.h |  2 ++
>  include/linux/percpu.h        |  1 +
>  include/linux/slab.h          |  1 +
>  include/linux/vmalloc.h       |  1 +
>  kernel/bpf/hashtab.c          | 80 ++++++++++++++++++++++++++++++++++++++++++-
>  kernel/bpf/memalloc.c         | 70 +++++++++++++++++++++++++++++++++++++
>  kernel/bpf/syscall.c          | 18 ++++++----
>  mm/percpu-internal.h          |  4 ++-
>  mm/percpu.c                   | 35 +++++++++++++++++++
>  mm/util.c                     | 15 ++++++++
>  mm/vmalloc.c                  | 17 +++++++++
>  12 files changed, 237 insertions(+), 9 deletions(-)
> 
> -- 
> 1.8.3.1
> 


