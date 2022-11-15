Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2332D628F47
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 02:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbiKOBbV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 20:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbiKOBbR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 20:31:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9832B6381
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 17:30:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25323614BB
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 01:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A320C43149
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 01:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668475854;
        bh=21dyo6pC4Z7btEnoNbIbvGKAF6vPoZF9LbkSlShGszw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hYWop5r7s9EYc/9+cgBB//1D45vKsfN1AhW4jEnWIEKm0J2fwYr+yD3G/1wA3pawS
         YCmflzS0YRHRdW1mV40SjY/amIKLLfg0rJ2jTmU43ULMao/7dz9rQ6865fUlI43lKg
         neB+cxU3ZY0BrwxC6HwWJ4dCOHjzfEb+JXV80PR1IIQBGCJAp/2TrPk0Gx9NDTWMuX
         df2XHk7iTp7ztvwh1UvRBsD6Cgbypq4crNlGM6AI8UkfqjOHhxsNJViBxMgbix5YyS
         LwoD8cClkeYQuRDWlFhso7jrwTwlLj8SDJjQuap1tH3te49jTueP1WSJZF97ALwR2f
         jSKReFUgE2Vdw==
Received: by mail-ej1-f54.google.com with SMTP id t25so32576451ejb.8
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 17:30:54 -0800 (PST)
X-Gm-Message-State: ANoB5plHmjutTpaGkJWREZtg7rCV1v5Bqv/b30VyPbrAd5jm5uRNinxu
        CG9mt944zg3d1AA3lMDJRNnyeVmqINnIk0MpoBs=
X-Google-Smtp-Source: AA0mqf79oHz8D7RfiHeZN1SfkVkV4xDIpD7AXDylZzs6+uN+XZc/iEZf5Pzq8+UgA4kNF9m5MM19qM7UOqUWN8c4hjw=
X-Received: by 2002:a17:907:8c15:b0:78d:9e04:d8c2 with SMTP id
 ta21-20020a1709078c1500b0078d9e04d8c2mr11606536ejc.614.1668475852566; Mon, 14
 Nov 2022 17:30:52 -0800 (PST)
MIME-Version: 1.0
References: <20221107223921.3451913-1-song@kernel.org>
In-Reply-To: <20221107223921.3451913-1-song@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Mon, 14 Nov 2022 17:30:39 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5pq+hzS87Rb3pyoD3z8WH+R7EOAGkTkh-KwEKt9HV_mA@mail.gmail.com>
Message-ID: <CAPhsuW5pq+hzS87Rb3pyoD3z8WH+R7EOAGkTkh-KwEKt9HV_mA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
To:     bpf@vger.kernel.org, linux-mm@kvack.org, peterz@infradead.org,
        akpm@linux-foundation.org
Cc:     x86@kernel.org, hch@lst.de, rick.p.edgecombe@intel.com,
        aaron.lu@intel.com, rppt@kernel.org, mcgrof@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 7, 2022 at 2:41 PM Song Liu <song@kernel.org> wrote:
>

[...]

>
>
> This set enables bpf programs and bpf dispatchers to share huge pages with
> new API:
>   execmem_alloc()
>   execmem_alloc()
>   execmem_fill()
>
> The idea is similar to Peter's suggestion in [1].
>
> execmem_alloc() manages a set of PMD_SIZE RO+X memory, and allocates these
> memory to its users. execmem_alloc() is used to free memory allocated by
> execmem_alloc(). execmem_fill() is used to update memory allocated by
> execmem_alloc().

Sigh, I just realized this thread made through linux-mm@kvack.org, but got
dropped by bpf@vger.kernel.org, so I guess I will have to resend v3.

Currently, I have got the following action items for v3:
1. Add unify API to allocate text memory to motivation;
2. Update Documentation/x86/x86_64/mm.rst;
3. Allow none PMD_SIZE allocation for powerpc.

1 and 2 are relatively simple. We can probably do 3 in a follow up patch
(as I don't have powerpc environments for testing). Did I miss anything?

Besides these, does this set look reasonable? Andrew and Peter, could
you please share your comments on this?

Thanks,
Song

>
> Memory allocated by execmem_alloc() is RO+X, so this doesnot violate W^X.
> The caller has to update the content with text_poke like mechanism.
> Specifically, execmem_fill() is provided to update memory allocated by
> execmem_alloc(). execmem_fill() also makes sure the update stays in the
> boundary of one chunk allocated by execmem_alloc(). Please refer to patch
> 1/5 for more details of
>
> Patch 3/5 uses these new APIs in bpf program and bpf dispatcher.
>
> Patch 4/5 and 5/5 allows static kernel text (_stext to _etext) to share
> PMD_SIZE pages with dynamic kernel text on x86_64. This is achieved by
> allocating PMD_SIZE pages to roundup(_etext, PMD_SIZE), and then use
> _etext to roundup(_etext, PMD_SIZE) for dynamic kernel text.
>
> [1] https://lore.kernel.org/bpf/Ys6cWUMHO8XwyYgr@hirez.programming.kicks-ass.net/
> [2] RFC v1: https://lore.kernel.org/linux-mm/20220818224218.2399791-3-song@kernel.org/T/
> [3] v1: https://lore.kernel.org/bpf/20221031222541.1773452-1-song@kernel.org/
> [4] https://lore.kernel.org/bpf/Y2ioTodn+mBXdIqp@ziqianlu-desk2/
> [5] https://lore.kernel.org/bpf/20220707223546.4124919-1-song@kernel.org/
>
> Changes PATCH v1 => v2:
> 1. Rename the APIs as execmem_* (Christoph Hellwig)
> 2. Add more information about the motivation of this work (and follow up
>    works in for kernel modules, various trampolines, etc).
>    (Luis Chamberlain, Rick Edgecombe, Mike Rapoport, Aaron Lu)
> 3. Include expermential results from previous bpf_prog_pack and the
>    community. (Aaron Lu, Luis Chamberlain, Rick Edgecombe)
>
> Changes RFC v2 => PATCH v1:
> 1. Add vcopy_exec(), which updates memory allocated by vmalloc_exec(). It
>    also ensures vcopy_exec() is only used to update memory from one single
>    vmalloc_exec() call. (Christoph Hellwig)
> 2. Add arch_vcopy_exec() and arch_invalidate_exec() as wrapper for the
>    text_poke() like logic.
> 3. Drop changes for kernel modules and focus on BPF side changes.
>
> Changes RFC v1 => RFC v2:
> 1. Major rewrite of the logic of vmalloc_exec and vfree_exec. They now
>    work fine with BPF programs (patch 1, 2, 4). But module side (patch 3)
>    still need some work.
>
> Song Liu (5):
>   vmalloc: introduce execmem_alloc, execmem_free, and execmem_fill
>   x86/alternative: support execmem_alloc() and execmem_free()
>   bpf: use execmem_alloc for bpf program and bpf dispatcher
>   vmalloc: introduce register_text_tail_vm()
>   x86: use register_text_tail_vm
>
>  arch/x86/include/asm/pgtable_64_types.h |   1 +
>  arch/x86/kernel/alternative.c           |  12 +
>  arch/x86/mm/init_64.c                   |   4 +-
>  arch/x86/net/bpf_jit_comp.c             |  23 +-
>  include/linux/bpf.h                     |   3 -
>  include/linux/filter.h                  |   5 -
>  include/linux/vmalloc.h                 |   9 +
>  kernel/bpf/core.c                       | 180 +-----------
>  kernel/bpf/dispatcher.c                 |  11 +-
>  mm/nommu.c                              |  12 +
>  mm/vmalloc.c                            | 354 ++++++++++++++++++++++++
>  11 files changed, 412 insertions(+), 202 deletions(-)
>
> --
> 2.30.2
