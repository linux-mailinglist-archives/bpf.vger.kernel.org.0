Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2206B9FCF
	for <lists+bpf@lfdr.de>; Tue, 14 Mar 2023 20:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjCNTbr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 15:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjCNTbp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 15:31:45 -0400
Received: from out-15.mta0.migadu.com (out-15.mta0.migadu.com [IPv6:2001:41d0:1004:224b::f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CC5360A3
        for <bpf@vger.kernel.org>; Tue, 14 Mar 2023 12:31:29 -0700 (PDT)
Message-ID: <c6172fe2-7d88-f9f8-e19a-47c232f9cb75@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678822287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jpb0Syl0w3M2RYRWL+D6ZXsAlme5/bd92q0A9qcn034=;
        b=GA6+79xgEEorjqpRIjGJLRus/237ZKFgwHcN9/f6adnSLhAB18F5rj4cgBdo8F5D89Srj2
        kv5PueqcYHd/pHnWbeEN28dRJ7kuIbzVXEpAseoNmlASbhTAvzptRFu2yXAIJ9fjJhGxbN
        sN9g89XPf/z3NH+MuLV81fS/YFAfj5U=
Date:   Tue, 14 Mar 2023 12:31:24 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3] docs/bpf: Add LRU internals description and
 graph
Content-Language: en-US
To:     Joe Stringer <joe@isovalent.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, corbet@lwn.net, bagasdotme@gmail.com,
        maxtram95@gmail.com, bpf@vger.kernel.org
References: <20230312190600.324573-1-joe@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230312190600.324573-1-joe@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/12/23 12:05 PM, Joe Stringer wrote:
> Extend the bpf hashmap docs to include a brief description of the
> internals of the LRU map type (setting appropriate API expectations),
> including the original commit message from Martin and a variant on the
> graph that I had presented during my Linux Plumbers Conference 2022 talk
> on "Pressure feedback for LRU map types"[0].
> 
> The node names in the dot file correspond roughly to the functions where
> the logic for those decisions or steps is defined, to help curious
> developers to cross-reference and update this logic if the details of
> the LRU implementation ever differ from this description.
> 
> [0]: https://lpc.events/event/16/contributions/1368/
> 
> Signed-off-by: Joe Stringer <joe@isovalent.com>
> ---
> v3: Use standard table syntax
>      Replace inline commit message with reference to commit
>      Fix incorrect Y/N label for common LRU check
>      Rename some dotfile variables to reduce confusion between cases
>      Minor wording touchups
> v2: Fix issue that caused initial email submission to fail
> ---
>   Documentation/bpf/map_hash.rst            |  62 ++++++++
>   Documentation/bpf/map_lru_hash_update.dot | 166 ++++++++++++++++++++++
>   2 files changed, 228 insertions(+)
>   create mode 100644 Documentation/bpf/map_lru_hash_update.dot
> 
> diff --git a/Documentation/bpf/map_hash.rst b/Documentation/bpf/map_hash.rst
> index 8669426264c6..61602ce26561 100644
> --- a/Documentation/bpf/map_hash.rst
> +++ b/Documentation/bpf/map_hash.rst
> @@ -1,5 +1,6 @@
>   .. SPDX-License-Identifier: GPL-2.0-only
>   .. Copyright (C) 2022 Red Hat, Inc.
> +.. Copyright (C) 2022-2023 Isovalent, Inc.
>   
>   ===============================================
>   BPF_MAP_TYPE_HASH, with PERCPU and LRU Variants
> @@ -206,3 +207,64 @@ Userspace walking the map elements from the map declared above:
>                       cur_key = &next_key;
>               }
>       }
> +
> +Internals
> +=========
> +
> +This section of the document is targeted at Linux developers and describes
> +aspects of the map implementations that are not considered stable ABI. The
> +following details are subject to change in future versions of the kernel.
> +
> +``BPF_MAP_TYPE_LRU_HASH`` and variants
> +--------------------------------------
> +
> +An LRU hashmap type consists of two properties: Firstly, it is a hash map and
> +hence is indexable by key for constant time lookups. Secondly, when at map
> +capacity, map updates will trigger eviction of old entries based on the age of
> +the elements in a set of lists. Each of these properties may be either global
> +or per-CPU, depending on the map type and flags used to create the map:
> +
> ++------------------------+---------------------------+----------------------------------+
> +|                        | ``BPF_MAP_TYPE_LRU_HASH`` | ``BPF_MAP_TYPE_LRU_PERCPU_HASH`` |
> ++========================+===========================+==================================+
> +| ``BPF_NO_COMMON_LRU``  | Per-CPU LRU, global map   | Per-CPU LRU, per-cpu map         |
> ++------------------------+---------------------------+----------------------------------+
> +| ``!BPF_NO_COMMON_LRU`` | Global LRU, global map    | Global LRU, per-cpu map          |
> ++------------------------+---------------------------+----------------------------------+
> +
> +Notably, there are various steps that the update algorithm attempts in order to
> +enforce the LRU property which have increasing impacts on other CPUs involved
> +in the following operation attempts:
> +
> +- Attempt to use CPU-local state to batch operations
> +- Attempt to fetch free nodes from global lists
> +- Attempt to pull any node from a global list and remove it from the hashmap
> +- Attempt to pull any node from any CPU's list and remove it from the hashmap
> +
> +Even if an LRU node may be acquired, maps of type ``BPF_MAP_TYPE_LRU_HASH``
> +may fail to insert the entry into the map if other CPUs are heavily contending
> +on the global hashmap lock.

The global hashmap lock described here is the action taken in htab_lock_bucket()?

It is a percpu counter added in commit 20b6cc34ea74 ("bpf: Avoid hashtab 
deadlock with map_locked") to avoid deadlock/recursion.

I would suggest to simplify the diagram by removing the "Can lock this hashtab 
bucket?" details. May be a note somewhere to mention why it will still fail to 
shrink the list because the htab_lock_bucket() have detected potential 
deadlock/recursion which is a very unlikely case.


Thanks for the write-up!
