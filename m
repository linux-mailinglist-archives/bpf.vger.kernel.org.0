Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D44B6C225B
	for <lists+bpf@lfdr.de>; Mon, 20 Mar 2023 21:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjCTUQF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Mar 2023 16:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjCTUQE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Mar 2023 16:16:04 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C8F31E2E
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 13:15:57 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id k2so13774039pll.8
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 13:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679343356;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xSz84hF+4DVQ974S2+UpAOdAKV+U+s4CN6K8Xq1SnKY=;
        b=VonBZmxv+uEJQb7X99iKRMD7Ss+JPVswSou27Lbtd0KOq/AY1VvyRfkjOasTLGgbpy
         Baw+HsoNj+8KVmpaI5KgUtCFd5VS4ledOWesFtqUNRnmIFJr2NUCS9H1Y+gsyJu8+yEU
         F5HQpAWY/sdz57v8E+aWCt7Jsa3H/brNTSlwCBtFLe6GsuN8DvSuJ98C8UXJQwqc1Ckv
         CinfG8OeKOhYani2nEkVEW9zdOb2SUeH6TrTuwQjqQDD0xJaeEUQ9KM9ItGSxOleq5Rc
         Pxr11VKJ3oXpn0HPfu7TnNVUBjkgYFYBs3U5cVzJTmHtdXDrc0XO1XtRP5/EL99fVWKZ
         2xbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679343356;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xSz84hF+4DVQ974S2+UpAOdAKV+U+s4CN6K8Xq1SnKY=;
        b=az4eqDmaIt5ot2LIX1shfIY8uwNTOFXw/n/uLAe6c4aNVe0IKm97ZfcFKYnbXzaIoS
         a+Trj6G91D+l+53uiYAQVSBuJVZGfN8KkRKpMvI3Lg/86c92y/21ssllQtQyZBsR8dip
         xY7CYI2wY14pcHt3kdhcXkIupCW7lZWhTd0etNfneinvi9sKPtcZkgK5/15HnCWWjK78
         q8lihwQxZ4827GG8CEsBSFh94lo1QuWd1ZHajcLLsapfRUZmeNkwkKMR1LWifivDaWCe
         KpBJuXn8/zgM3C2tnpZSGho7htIhfIpPxK1PlIc+734ZUKRBZkB2yd25aVPbH8w4Lb6b
         G26A==
X-Gm-Message-State: AO0yUKXwvNKx3ILIkAx0OiPo2bYIrm09m7c9MJ14+KJmY6Jv/A72piF4
        HE5CVGrgHWGqiCncchW5TSg=
X-Google-Smtp-Source: AK7set/fM8tBLzXh5eyA9jJ6eUFgxz8kCewrexBLDUQ+qG0w6Xe1tkpfKsAyCCzfCM91VIE+dJM45A==
X-Received: by 2002:a05:6a20:8f03:b0:cc:f27d:eb83 with SMTP id b3-20020a056a208f0300b000ccf27deb83mr22802720pzk.53.1679343356508;
        Mon, 20 Mar 2023 13:15:56 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e1::15f9? ([2620:10d:c090:400::5:48b7])
        by smtp.gmail.com with ESMTPSA id e25-20020aa78c59000000b0058837da69edsm6732449pfd.128.2023.03.20.13.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 13:15:55 -0700 (PDT)
Message-ID: <0e08cc21-1f90-e0b3-ef9a-7a1cb3d62673@gmail.com>
Date:   Mon, 20 Mar 2023 13:15:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v9 0/8] Transit between BPF TCP congestion
 controls.
Content-Language: en-US, en-ZW
To:     Kui-Feng Lee <kuifeng@meta.com>, bpf@vger.kernel.org,
        ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
References: <20230320192410.1624645-1-kuifeng@meta.com>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20230320192410.1624645-1-kuifeng@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This thread is sent by accident.  Please ignore this thread and check
the other thread sent with the same subject.
Sorry for wasting your time.

On 3/20/23 12:24, Kui-Feng Lee wrote:
> Major changes:
> 
>   - Create bpf_links in the kernel for BPF struct_ops to register and
>     unregister it.
> 
>   - Enables switching between implementations of bpf-tcp-cc under a
>     name instantly by replacing the backing struct_ops map of a
>     bpf_link.
> 
> Previously, BPF struct_ops didn't go off, as even when the user
> program creating it was terminated, none of these ever were pinned.
> For instance, the TCP congestion control subsystem indirectly
> maintains a reference count on the struct_ops of any registered BPF
> implemented algorithm. Thus, the algorithm won't be deactivated until
> someone deliberately unregisters it.  For compatibility with other BPF
> programs, bpf_links have been created to work in coordination with
> struct_ops maps. This ensures that the registration and unregistration
> of these respective maps is carried out at the start and end of the
> bpf_link.
> 
> We also faced complications when attempting to replace an existing TCP
> congestion control algorithm with a new implementation on the fly. A
> struct_ops map was used to register a TCP congestion control algorithm
> with a unique name.  We had to either register the alternative
> implementation with a new name and move over or unregister the current
> one before being able to reregistration with the same name.  To fix
> this problem, we can an option to migrate the registration of the
> algorithm from struct_ops maps to bpf_links. By modifying the backing
> map of a bpf_link, it suddenly becomes possible to replace an existing
> TCP congestion control algorithm with ease.
> 
> ---
> 
> The major differences form v8:
> 
>   - Check bpf_struct_ops::{validate,update} in
>     bpf_struct_ops_map_alloc()
> 
> The major differences from v7:
> 
>   - Use synchronize_rcu_mult(call_rcu, call_rcu_tasks) to replace
>     synchronize_rcu() *** BLURB HERE *** synchronize_rcu_tasks().
> 
>   - Call synchronize_rcu() in tcp_update_congestion_control().
> 
>   - Handle -EBUSY in bpf_map__attach_struct_ops() to allow a struct_ops
>     can be used to create links more than once.  Include a test case.
> 
>   - Add old_map_fd to bpf_attr and handle BPF_F_REPLACE in
>     bpf_struct_ops_map_link_update().
> 
>   - Remove changes in bpf_dummy_struct_ops.c and add a check of .update
>     function pointer of bpf_struct_ops.
> 
> The major differences from v6:
> 
>   - Reword commit logs of the patch 1, 2, and 8.
> 
>   - Call syncrhonize_rcu_tasks() as well in bpf_struct_ops_map_free().
> 
>   - Refactor bpf_struct_ops_map_free() so that
>     bpf_struct_ops_map_alloc() can free a struct_ops without waiting
>     for a RCU grace period.
> 
> The major differences from v5:
> 
>   - Add a new step to bpf_object__load() to prepare vdata.
> 
>   - Accept BPF_F_REPLACE.
> 
>   - Check section IDs in find_struct_ops_map_by_offset()
> 
>   - Add a test case to check mixing w/ and w/o link struct_ops.
> 
>   - Add a test case of using struct_ops w/o link to update a link.
> 
>   - Improve bpf_link__detach_struct_ops() to handle the w/ link case.
> 
> The major differences from v4:
> 
>   - Rebase.
> 
>   - Reorder patches and merge part 4 to part 2 of the v4.
> 
> The major differences from v3:
> 
>   - Remove bpf_struct_ops_map_free_rcu(), and use synchronize_rcu().
> 
>   - Improve the commit log of the part 1.
> 
>   - Before transitioning to the READY state, we conduct a value check
>     to ensure that struct_ops can be successfully utilized and links
>     created later.
> 
> The major differences from v2:
> 
>   - Simplify states
> 
>     - Remove TOBEUNREG.
> 
>     - Rename UNREG to READY.
> 
>   - Stop using the refcnt of the kvalue of a struct_ops. Explicitly
>     increase and decrease the refcount of struct_ops.
> 
>   - Prepare kernel vdata during the load phase of libbpf.
> 
> The major differences from v1:
> 
>   - Added bpf_struct_ops_link to replace the previous union-based
>     approach.
> 
>   - Added UNREG and TOBEUNREG to the state of bpf_struct_ops_map.
> 
>     - bpf_struct_ops_transit_state() maintains state transitions.
> 
>   - Fixed synchronization issue.
> 
>   - Prepare kernel vdata of struct_ops during the loading phase of
>     bpf_object.
> 
>   - Merged previous patch 3 to patch 1.
> 
> v8: https://lore.kernel.org/all/20230318053144.1180301-1-kuifeng@meta.com/
> v7: https://lore.kernel.org/all/20230316023641.2092778-1-kuifeng@meta.com/
> v6: https://lore.kernel.org/all/20230310043812.3087672-1-kuifeng@meta.com/
> v5: https://lore.kernel.org/all/20230308005050.255859-1-kuifeng@meta.com/
> v4: https://lore.kernel.org/all/20230307232913.576893-1-andrii@kernel.org/
> v3: https://lore.kernel.org/all/20230303012122.852654-1-kuifeng@meta.com/
> v2: https://lore.kernel.org/bpf/20230223011238.12313-1-kuifeng@meta.com/
> v1: https://lore.kernel.org/bpf/20230214221718.503964-1-kuifeng@meta.com/
> 
> Kui-Feng Lee (8):
>    bpf: Retire the struct_ops map kvalue->refcnt.
>    net: Update an existing TCP congestion control algorithm.
>    bpf: Create links for BPF struct_ops maps.
>    libbpf: Create a bpf_link in bpf_map__attach_struct_ops().
>    bpf: Update the struct_ops of a bpf_link.
>    libbpf: Update a bpf_link with another struct_ops.
>    libbpf: Use .struct_ops.link section to indicate a struct_ops with a
>      link.
>    selftests/bpf: Test switching TCP Congestion Control algorithms.
> 
>   include/linux/bpf.h                           |  11 +
>   include/net/tcp.h                             |   3 +
>   include/uapi/linux/bpf.h                      |  33 ++-
>   kernel/bpf/bpf_struct_ops.c                   | 250 +++++++++++++++---
>   kernel/bpf/syscall.c                          |  63 ++++-
>   net/ipv4/bpf_tcp_ca.c                         |  14 +-
>   net/ipv4/tcp_cong.c                           |  65 ++++-
>   tools/include/uapi/linux/bpf.h                |  33 ++-
>   tools/lib/bpf/libbpf.c                        | 190 ++++++++++---
>   tools/lib/bpf/libbpf.h                        |   1 +
>   tools/lib/bpf/libbpf.map                      |   1 +
>   .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 116 ++++++++
>   .../selftests/bpf/progs/tcp_ca_update.c       |  80 ++++++
>   13 files changed, 759 insertions(+), 101 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/progs/tcp_ca_update.c
> 
