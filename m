Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5191650AD4C
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 03:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbiDVBn0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 21:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbiDVBnZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 21:43:25 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8851E49C96
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 18:40:34 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id z16so6589240pfh.3
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 18:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0j+rwjaRLqtNldELFSiq1KfuS8h7s7H1KiLSXKeiS6M=;
        b=Rhj6e2cCVRVfMNcdrzxYK5Tu3XzwOMtrBpDlyTEnYFBnKFneemJzUyT4t8ONlvty5R
         0UX5F3bbUDkPuLPFaL/y/qDb2qdrFUSjg5fW2mVulvsNxBwRKXv77EHTAme7uXzQhpFa
         Qz6hcHLiMUXzR+hqJY7lhmrVouxhnobGi33yAWN3J9ZzFdLqMYVULF43FMVDr8Zjbp38
         uLiKHTdI2UHdYGB6Z+Q1aHxRnTuJrD62nzaW0JT506CoU2QfarNAaGUDLgYag3/t7V8i
         1YxZoxvgPIDgcqppmIPQWWOsr0WHMHtmRII62yy6/I90XEoU4L/OvMCypNzqKSoWFN4d
         CBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0j+rwjaRLqtNldELFSiq1KfuS8h7s7H1KiLSXKeiS6M=;
        b=bxLrHtCeoI4+9M6Ug6sxadZf8rU0OOyxf7e/Pa8zTTo6oOzf03v2mc1uGr/DLe583w
         dC8LG+DPvcpSTL02DAPqWZZWsHEB4bQj/EZkM/xPp+iAfcMleBeDVSSraPzzprRHgnvk
         H4BeO5YeoiuHH+EaAAOYF+O6nj2VvF0fMLHaJOtVXhJ/EnurWr5XqvH0zbNbtVEqmQPo
         x86Oq9c7trqO2Rpe40MFafuns+BscZ6ZqMcuAL6o6Luy0nfTALqiuMPsuzWR05Maubnn
         Z0tYYUYChMg1C64xAVcHKR0jwyjU/KyXsvuuvHWx94J0XDEaR34yOn6scdYq8xrvVltN
         W4Ow==
X-Gm-Message-State: AOAM533o2GWZTd326B1spa1/NfgAKfriQrAIwDPHjUEY2cuoKuxnrd7f
        reuqeIj2g3jNrlaAgH9zzgghmBBaCKQ=
X-Google-Smtp-Source: ABdhPJwVAaG4gkfsa7rEAt2LeER9vTIbYyjBtA+b6bXaccQr664Y9ZKcdIALrOmX8mtcgDP4nXhB8g==
X-Received: by 2002:a63:ed05:0:b0:39d:4f84:1fe3 with SMTP id d5-20020a63ed05000000b0039d4f841fe3mr1943661pgi.420.1650591633801;
        Thu, 21 Apr 2022 18:40:33 -0700 (PDT)
Received: from MBP-98dd607d3435.dhcp.thefacebook.com ([2620:10d:c090:400::5:4399])
        by smtp.gmail.com with ESMTPSA id ca11-20020a056a00418b00b0050a55c55fe5sm377927pfb.75.2022.04.21.18.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 18:40:33 -0700 (PDT)
Date:   Thu, 21 Apr 2022 18:40:30 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>, Tejun Heo <tj@kernel.org>,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next 0/3] Introduce local_storage exclusive caching
Message-ID: <20220422014030.opvbgrfvdnxzwfxl@MBP-98dd607d3435.dhcp.thefacebook.com>
References: <20220420002143.1096548-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420002143.1096548-1-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 19, 2022 at 05:21:40PM -0700, Dave Marchevsky wrote:
> Currently, each local_storage type (sk, inode, task) has a 16-entry
> cache for local_storage data associated with a particular map. A
> local_storage map is assigned a fixed cache_idx when it is allocated.
> When looking in a local_storage for data associated with a map the cache
> entry at cache_idx is the only place the map can appear in cache. If the
> map's data is not in cache it is placed there after a search through the
> cache hlist. When there are >16 local_storage maps allocated for a
> local_storage type multiple maps have same cache_idx and thus may knock
> each other out of cache.
> 
> BPF programs that use local_storage may require fast and consistent
> local storage access. For example, a BPF program using task local
> storage to make scheduling decisions would not be able to tolerate a
> long hlist search for its local_storage as this would negatively affect
> cycles available to applications. Providing a mechanism for such a
> program to ensure that its local_storage_data will always be in cache
> would ensure fast access.
> 
> This series introduces a BPF_LOCAL_STORAGE_FORCE_CACHE flag that can be
> set on sk, inode, and task local_storage maps via map_extras. When a map
> with the FORCE_CACHE flag set is allocated it is assigned an 'exclusive'
> cache slot that it can't be evicted from until the map is free'd. 
> 
> If there are no slots available to exclusively claim, the allocation
> fails. BPF programs are expected to use BPF_LOCAL_STORAGE_FORCE_CACHE
> only if their data _must_ be in cache.

I'm afraid new uapi flag doesn't solve this problem.
Sooner or later every bpf program would deem itself "important" and
performance critical. All of them will be using FORCE_CACHE flag
and we will back to the same situation.

Also please share the performance data that shows more than 16 programs
that use local storage at the same time and existing simple cache
replacing logic is not enough.
For any kind link list walking to become an issue there gotta be at
least 17 progs. Two progs should pick up the same cache_idx and
run interleaved to evict each other. 
It feels like unlikely scenario, so real data would be good to see.
If it really an issue we might need a different caching logic.
Like instead of single link list per local storage we might
have 16 link lists. cache_idx can point to a slot.
If it's not 1st it will be a 2nd in much shorter link list.
With 16 slots the link lists will have 2 elements until 32 bpf progs
are using local storage.
We can get rid of cache too and replace with mini hash table of N
elements where map_id would be an index into a hash table.
All sorts of other algorithms are possible.
In any case the bpf user shouldn't be telling the kernel about
"importance" of its program. If program is indeed executing a lot
the kernel should be caching/accelerating it where it can.
