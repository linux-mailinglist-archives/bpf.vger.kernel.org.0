Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103316B4D0E
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 17:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjCJQcN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 11:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjCJQbx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 11:31:53 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA8912141C
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 08:29:06 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d7so6236781qtr.12
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 08:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678465742;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6LzT9Cf5YgFy/KZdFtzqSQG4A/sPbLMjZqOTBFT8aqo=;
        b=oX22w9AfXUnuKmpWxpTaJgMtrEhDpMwl9mtDBM0fv1AiAkZXytAtadvLcitvr7+nZ1
         MBu4d3uJ2fp+HglRmeltaeDVEv3n8RGHrgCwJCXXE+8qezDdNNGwoYm4XkBUyCi1GCOu
         pShvvyS9HD94MAb2Dcsh9AFMpgl6iqD0lS358luMoCkNaO8eQSbaRP4kUG3U17MTy51B
         Wgt4ToFl9G7lRQr2PoawjUO5LwckhPWVQ5lHI/zrgnxvoy+n1GsZ9zioIoNzqDIv3e/d
         cuU57NiGr5S4QMulZ1+ANLT9TP5MMUClt8jNNRdRSyowMikkv3MOSoRjHzw50v1yrTsa
         s2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678465742;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6LzT9Cf5YgFy/KZdFtzqSQG4A/sPbLMjZqOTBFT8aqo=;
        b=ZpfdbPFZw7rXZOb0NKKppDWabgQWfimLJahYoL/jlNO/W1jn2jHOa4FKCcxl7NyW01
         fajrhicxRvH5riwK49Ckt+e/uz6tPa7ZrWCIhHqBQMD6zPMt0A1VMbiuuP9vAs6uRXgs
         C7n/AuMdjRJ9hcOwUTxANZgxPKR+wYZmzX+Udn08RnnE//TX44dbSNLjUH/wSQyGQUUw
         8yzzTmikNQh9dXDdlAY+Gq4lnypWx5YFiGkhyasUddXhW0oup0oAtQAzRrnii/ZeGpIK
         AFKKMqLASjdWuYpTui54ScLxrU1HuCEfV0XUsZTM3Gf2LeJXKqMiVUdwdC5NrT60RCRp
         c4Uw==
X-Gm-Message-State: AO0yUKUcE/JH4Dbtrk739sMLtHhTT+gRRhg46emwP5nSLhQhG1OygB5s
        VNbBThNIw9DA8QwrVjn+isdraBDhTds=
X-Google-Smtp-Source: AK7set/ZSsUqYAGl52X5bcYrnz7YjijX6DyJXDk2hGczh0LB6RNX1W5QQPqAtC2fBslVDxM21jVgNg==
X-Received: by 2002:ac8:5c4a:0:b0:3bf:b950:f684 with SMTP id j10-20020ac85c4a000000b003bfb950f684mr13010350qtj.53.1678465742123;
        Fri, 10 Mar 2023 08:29:02 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240::3b? ([2600:1700:6cf8:1240::3b])
        by smtp.gmail.com with ESMTPSA id ef14-20020a05620a808e00b0074357a6529asm35215qkb.105.2023.03.10.08.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 08:29:01 -0800 (PST)
Message-ID: <7e0b5974-0518-fe8d-0485-a8b2b73059cb@gmail.com>
Date:   Fri, 10 Mar 2023 08:28:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v6 0/8] Transit between BPF TCP congestion
 controls.
Content-Language: en-US, en-ZW
To:     Kui-Feng Lee <kuifeng@meta.com>, bpf@vger.kernel.org,
        ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
References: <20230310043812.3087672-1-kuifeng@meta.com>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20230310043812.3087672-1-kuifeng@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/9/23 20:38, Kui-Feng Lee wrote:
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

The major differences from v5:

  - Add a new step to bpf_object__load() to prepare vdata.

  - Accept BPF_F_REPLACE.

  - Check section IDs in find_struct_ops_map_by_offset()

  - Add a test case to check mixing w/ & w/o link struct_ops.

  - Add a test case of using struct_ops w/o link to update a link.

  - Improve bpf_link__detach_struct_ops() to handle the w/ link case.


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
v5: https://lore.kernel.org/all/20230308005050.255859-1-kuifeng@meta.com/
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
>   include/linux/bpf.h                           |  10 +
>   include/net/tcp.h                             |   3 +
>   include/uapi/linux/bpf.h                      |  20 +-
>   kernel/bpf/bpf_struct_ops.c                   | 229 +++++++++++++++---
>   kernel/bpf/syscall.c                          |  49 +++-
>   net/bpf/bpf_dummy_struct_ops.c                |   6 +
>   net/ipv4/bpf_tcp_ca.c                         |  14 +-
>   net/ipv4/tcp_cong.c                           |  60 ++++-
>   tools/include/uapi/linux/bpf.h                |  20 +-
>   tools/lib/bpf/libbpf.c                        | 180 +++++++++++---
>   tools/lib/bpf/libbpf.h                        |   1 +
>   tools/lib/bpf/libbpf.map                      |   1 +
>   .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  91 +++++++
>   .../selftests/bpf/progs/tcp_ca_update.c       |  80 ++++++
>   14 files changed, 671 insertions(+), 93 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/progs/tcp_ca_update.c
> 
