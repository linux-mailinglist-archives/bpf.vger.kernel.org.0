Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3716B96F6
	for <lists+bpf@lfdr.de>; Tue, 14 Mar 2023 14:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjCNN4b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 09:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbjCNN4P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 09:56:15 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC422E0C9;
        Tue, 14 Mar 2023 06:55:16 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x3so62312260edb.10;
        Tue, 14 Mar 2023 06:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678802114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DFXW7wT+RfGJnBAS+LhUUfy6C0qfPbOQYiCQ9QS4Mys=;
        b=c/xaT5OVcxg4dHAzmi0K2Tsyn+uXMD7oNbiufmVbE+sxBL6nD9m7utbJGC0XN7R6rX
         tqa8wFP/EyWn/n+Jh9Dm/PadYLR3WIx6lfUeks+jZJBLTerWWs6gbvJ+5rOz55qGlKzr
         zE1hIvnRE60HQbidetFpgu/IlnJvYvdTCdXQAM+xsUtTiA4dy6e/dPyJhxNq9n9VpOtz
         1JEmcZ9vOjk0C8mU7ZX2oPWtPLQ4sBR9YN0dEgpEVQf41ePjH8gktxLq/hxMKvRZhirC
         TE4UNZjdHKTsOG5n4QakuWd51GuPDoSdVyniZmsbBLazNkhlPkOnXbIuctOdev5Hp4rD
         U2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678802114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFXW7wT+RfGJnBAS+LhUUfy6C0qfPbOQYiCQ9QS4Mys=;
        b=1o0LAkOo40WdxtcteNdEY4G4tLTZJZBlHpWZq9VHuGMUP6HqvLYmzrE/AgiHlfDTgR
         gYvo5Uwi014NESraao55blOoBq4MdN0cJ6aa34qfY/pPam6+8YBnWr6J27HZc4h8+OoN
         EpxNih22ydCX4/pufeVgP3f54NmgsD4OTk3qcw+fKRa2C4ItfrG7zMkIt0GxcgOwH613
         8z/xq1GmjXpIelZl3fbIJyy+skfdDbp+Y21dTAK9LCisBHZBS4xKoVheZhKzgInm2q9e
         eBzw8S+Mg7PzhDtCBZSYCR35opemZt7T26zBYqWpvwbdxUg42rDFLnhJP209yfN9Zt3H
         0LqA==
X-Gm-Message-State: AO0yUKUrMSJpm2AlVdqHcLe1bcLoY4wdIrq0fC+MxCFoiIUnmqRJS/i8
        lL5wSM6uErtv2vzc09SoSqAemrmfunwbrw==
X-Google-Smtp-Source: AK7set9Ef90uUTRYVhpB8v0uttm8rAD0UWdFfqDESGNyVcsv20sE4Cr9Ul0g2pyBpq6ibwZ1UEW9Iw==
X-Received: by 2002:a17:906:6b98:b0:8f6:ad32:cd51 with SMTP id l24-20020a1709066b9800b008f6ad32cd51mr2724261ejr.62.1678802114355;
        Tue, 14 Mar 2023 06:55:14 -0700 (PDT)
Received: from localhost (tor-exit-38.for-privacy.net. [185.220.101.38])
        by smtp.gmail.com with ESMTPSA id h25-20020a17090619d900b008b9b4ab6ad1sm1182957ejd.102.2023.03.14.06.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 06:55:13 -0700 (PDT)
Date:   Tue, 14 Mar 2023 15:55:09 +0200
From:   Maxim Mikityanskiy <maxtram95@gmail.com>
To:     Joe Stringer <joe@isovalent.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, corbet@lwn.net,
        martin.lau@linux.dev, bagasdotme@gmail.com
Subject: Re: [PATCH bpf-next v3] docs/bpf: Add LRU internals description and
 graph
Message-ID: <ZBB8vZ8EJRv2d7mD@mail.gmail.com>
References: <20230312190600.324573-1-joe@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230312190600.324573-1-joe@isovalent.com>
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 12, 2023 at 12:05:59PM -0700, Joe Stringer wrote:
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
>     Replace inline commit message with reference to commit
>     Fix incorrect Y/N label for common LRU check
>     Rename some dotfile variables to reduce confusion between cases
>     Minor wording touchups
> v2: Fix issue that caused initial email submission to fail
> ---
>  Documentation/bpf/map_hash.rst            |  62 ++++++++
>  Documentation/bpf/map_lru_hash_update.dot | 166 ++++++++++++++++++++++
>  2 files changed, 228 insertions(+)
>  create mode 100644 Documentation/bpf/map_lru_hash_update.dot
> 
> diff --git a/Documentation/bpf/map_hash.rst b/Documentation/bpf/map_hash.rst
> index 8669426264c6..61602ce26561 100644
> --- a/Documentation/bpf/map_hash.rst
> +++ b/Documentation/bpf/map_hash.rst
> @@ -1,5 +1,6 @@
>  .. SPDX-License-Identifier: GPL-2.0-only
>  .. Copyright (C) 2022 Red Hat, Inc.
> +.. Copyright (C) 2022-2023 Isovalent, Inc.
>  
>  ===============================================
>  BPF_MAP_TYPE_HASH, with PERCPU and LRU Variants
> @@ -206,3 +207,64 @@ Userspace walking the map elements from the map declared above:
>                      cur_key = &next_key;
>              }
>      }
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
> +
> +This algorithm is described visually in the following diagram. See the
> +description in commit 3a08c2fd7634 ("bpf: LRU List") for a full explanation of
> +the corresponding operations:
> +
> +.. kernel-figure::  map_lru_hash_update.dot
> +   :alt:    Diagram outlining the LRU eviction steps taken during map update
> +
> +   LRU hash eviction during map update for ``BPF_MAP_TYPE_LRU_HASH`` and
> +   variants
> +
> +Map updates start from the oval in the top right "begin ``bpf_map_update()``"
> +and progress through the graph towards the bottom where the result may be
> +either a successful update or a failure with various error codes. The key in
> +the top right provides indicators for which locks may be involved in specific
> +operations. This is intended as a visual hint for reasoning about how map
> +contention may impact update operations, though the map type and flags may
> +impact the actual contention on those locks, based on the logic described in
> +the table above. For instance, if the map is created with type
> +``BPF_MAP_TYPE_LRU_PERCPU_HASH`` and flags ``BPF_NO_COMMON_LRU`` then all map
> +properties would be per-cpu.
> +
> +The dot file source for the above figure uses internal kernel function names
> +for the node names in order to make the corresponding logic easier to find.
> diff --git a/Documentation/bpf/map_lru_hash_update.dot b/Documentation/bpf/map_lru_hash_update.dot
> new file mode 100644
> index 000000000000..3a44ebec501e
> --- /dev/null
> +++ b/Documentation/bpf/map_lru_hash_update.dot
> @@ -0,0 +1,166 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (C) 2022-2023 Isovalent, Inc.
> +digraph {
> +  node [colorscheme=accent4,style=filled] # Apply colorscheme to all nodes
> +  graph [splines=ortho, nodesep=1]
> +
> +  subgraph cluster_key {
> +    label = "Key\n(locks held during operation)";
> +    rankdir = TB;
> +
> +    remote_lock [shape=rectangle,fillcolor=4,label="remote CPU LRU lock"]
> +    hash_lock [shape=rectangle,fillcolor=3,label="hashtab lock"]
> +    lru_lock [shape=rectangle,fillcolor=2,label="LRU lock"]
> +    local_lock [shape=rectangle,fillcolor=1,label="local CPU LRU lock"]
> +    no_lock [shape=rectangle,label="no locks held"]
> +  }
> +
> +  begin [shape=oval,label="begin\nbpf_map_update()"]
> +
> +  // Nodes below with an 'fn_' prefix are roughly labeled by the C function
> +  // names that initiate the corresponding logic in kernel/bpf/bpf_lru_list.c.
> +  // Number suffixes and errno suffixes handle subsections of the corresponding
> +  // logic in the function as of the writing of this dot.
> +
> +  // The following corresponds to bpf_lru_pop_free() for common LRU case.

The comment that points to the function and explains that it's
applicable only to one case is a great idea, it's much clearer compared
to the previous version.

I believe there are some inaccuracies, though. As far as I see it,
local_freelist_check corresponds to __local_list_pop_free in the common
LRU case, specifically, to checking its return value; use_local_node
corresponds to returning that value; and common_lru_check corresponds
to bpf_lru_pop_free (for both common and percpu LRU, that's where the
distinction is made).

> +  local_freelist_check [shape=diamond,fillcolor=1,
> +    label="Local freelist\nnode available?"];
> +  // The following corresponds to __local_list_pop_free() for common LRU case.
> +  use_local_node [shape=rectangle,
> +    label="Use node owned\nby this CPU"]
> +
> +  common_lru_check [shape=diamond,
> +    label="Map created with\ncommon LRU?\n(!BPF_NO_COMMON_LRU)"];

Nit: the exact flag name is BPF_F_NO_COMMON_LRU.

> +
> +  fn_bpf_lru_list_pop_free_to_local [shape=rectangle,fillcolor=2,
> +    label="Flush local pending,
> +    Rotate Global list, move
> +    LOCAL_FREE_TARGET
> +    from global -> local"]
> +  // Also corresponds to:
> +  // fn__local_list_flush()
> +  // fn_bpf_lru_list_rotate()
> +  fn___bpf_lru_node_move_to_free[shape=diamond,fillcolor=2,
> +    label="Able to free\nLOCAL_FREE_TARGET\nnodes?"]
> +
> +  fn___bpf_lru_list_shrink_inactive [shape=rectangle,fillcolor=3,
> +    label="Shrink inactive list
> +      up to remaining
> +      LOCAL_FREE_TARGET
> +      (global LRU -> local)"]
> +  fn___bpf_lru_list_shrink [shape=diamond,fillcolor=2,
> +    label="> 0 entries in\nlocal free list?"]
> +  fn___bpf_lru_list_shrink2 [shape=rectangle,fillcolor=2,
> +    label="Steal one node from
> +      inactive, or if empty,
> +      from active global list"]
> +  fn___bpf_lru_list_shrink3 [shape=rectangle,fillcolor=3,
> +    label="Try to remove\nnode from hashtab"]
> +
> +  local_freelist_check2 [shape=diamond,label="Htab removal\nsuccessful?"]
> +  common_lru_check2 [shape=diamond,
> +    label="Map created with\ncommon LRU?\n(!BPF_NO_COMMON_LRU)"];
> +
> +  subgraph cluster_remote_lock {
> +    label = "Iterate through CPUs\n(start from current)";
> +    style = dashed;
> +    rankdir=LR;
> +
> +    local_freelist_check5 [shape=diamond,fillcolor=4,
> +      label="Steal a node from\nper-cpu freelist?"]
> +    local_freelist_check6 [shape=rectangle,fillcolor=4,
> +      label="Steal a node from
> +        (1) Unreferenced pending, or
> +        (2) Any pending node"]
> +    local_freelist_check7 [shape=rectangle,fillcolor=3,
> +      label="Try to remove\nnode from hashtab"]
> +    fn_htab_lru_map_update_elem [shape=diamond,
> +      label="Stole node\nfrom remote\nCPU?"]
> +    fn_htab_lru_map_update_elem2 [shape=diamond,label="Iterated\nall CPUs?"]
> +    // Also corresponds to:
> +    // use_local_node()
> +    // fn__local_list_pop_pending()
> +  }
> +
> +  fn_bpf_lru_list_pop_free_to_local2 [shape=rectangle,
> +    label="Use node that was\nnot recently referenced"]
> +  local_freelist_check4 [shape=rectangle,
> +    label="Use node that was\nactively referenced\nin global list"]
> +  fn_htab_lru_map_update_elem_ENOMEM [shape=oval,label="return -ENOMEM"]
> +  fn_htab_lru_map_update_elem3 [shape=rectangle,
> +    label="Use node that was\nactively referenced\nin (another?) CPU's cache"]
> +  fn_htab_lru_map_update_elem4 [shape=diamond,
> +    label="Can lock this\nhashtab bucket?"]
> +  fn_htab_lru_map_update_elem5 [shape=rectangle,fillcolor=3,
> +    label="Update hashmap\nwith new element"]
> +  fn_htab_lru_map_update_elem6 [shape=oval,label="return 0"]
> +  fn_htab_lru_map_update_elem_EBUSY [shape=oval,label="return -EBUSY"]
> +
> +  begin -> local_freelist_check
> +  local_freelist_check -> use_local_node [xlabel="Y"]
> +  local_freelist_check -> common_lru_check [xlabel="N"]
> +  common_lru_check -> fn_bpf_lru_list_pop_free_to_local [xlabel="Y"]
> +  common_lru_check -> fn___bpf_lru_list_shrink_inactive [xlabel="N"]
> +  fn_bpf_lru_list_pop_free_to_local -> fn___bpf_lru_node_move_to_free
> +  fn___bpf_lru_node_move_to_free ->
> +    fn_bpf_lru_list_pop_free_to_local2 [xlabel="Y"]
> +  fn___bpf_lru_node_move_to_free ->
> +    fn___bpf_lru_list_shrink_inactive [xlabel="N"]
> +  fn___bpf_lru_list_shrink_inactive -> fn___bpf_lru_list_shrink
> +  fn___bpf_lru_list_shrink -> fn_bpf_lru_list_pop_free_to_local2 [xlabel = "Y"]
> +  fn___bpf_lru_list_shrink -> fn___bpf_lru_list_shrink2 [xlabel="N"]
> +  fn___bpf_lru_list_shrink2 -> fn___bpf_lru_list_shrink3
> +  fn___bpf_lru_list_shrink3 -> local_freelist_check2
> +  local_freelist_check2 -> local_freelist_check4 [xlabel = "Y"]
> +  local_freelist_check2 -> common_lru_check2 [xlabel = "N"]
> +  common_lru_check2 -> local_freelist_check5 [xlabel = "Y"]
> +  common_lru_check2 -> fn_htab_lru_map_update_elem_ENOMEM [xlabel = "N"]
> +  local_freelist_check5 -> fn_htab_lru_map_update_elem [xlabel = "Y"]
> +  local_freelist_check5 -> local_freelist_check6 [xlabel = "N"]
> +  local_freelist_check6 -> local_freelist_check7
> +  local_freelist_check7 -> fn_htab_lru_map_update_elem
> +
> +  fn_htab_lru_map_update_elem -> fn_htab_lru_map_update_elem3 [xlabel = "Y"]
> +  fn_htab_lru_map_update_elem -> fn_htab_lru_map_update_elem2  [xlabel = "N"]
> +  fn_htab_lru_map_update_elem2 ->
> +    fn_htab_lru_map_update_elem_ENOMEM [xlabel = "Y"]
> +  fn_htab_lru_map_update_elem2 -> local_freelist_check5 [xlabel = "N"]
> +  fn_htab_lru_map_update_elem3 -> fn_htab_lru_map_update_elem4
> +
> +  use_local_node -> fn_htab_lru_map_update_elem4
> +  fn_bpf_lru_list_pop_free_to_local2 -> fn_htab_lru_map_update_elem4
> +  local_freelist_check4 -> fn_htab_lru_map_update_elem4
> +
> +  fn_htab_lru_map_update_elem4 -> fn_htab_lru_map_update_elem5 [xlabel="Y"]
> +  fn_htab_lru_map_update_elem4 ->
> +    fn_htab_lru_map_update_elem_EBUSY [xlabel="N"]
> +  fn_htab_lru_map_update_elem5 -> fn_htab_lru_map_update_elem6
> +
> +  // Create invisible pad nodes to line up various nodes
> +  pad0 [style=invis]
> +  pad1 [style=invis]
> +  pad2 [style=invis]
> +  pad3 [style=invis]
> +  pad4 [style=invis]
> +
> +  // Line up the key with the top of the graph
> +  no_lock -> local_lock [style=invis]
> +  local_lock -> lru_lock [style=invis]
> +  lru_lock -> hash_lock [style=invis]
> +  hash_lock -> remote_lock [style=invis]
> +  remote_lock -> local_freelist_check5 [style=invis]
> +  remote_lock -> fn___bpf_lru_list_shrink [style=invis]
> +
> +  // Line up return code nodes at the bottom of the graph
> +  fn_htab_lru_map_update_elem -> pad0 [style=invis]
> +  pad0 -> pad1 [style=invis]
> +  pad1 -> pad2 [style=invis]
> +  pad2-> fn_htab_lru_map_update_elem_ENOMEM [style=invis]
> +  fn_htab_lru_map_update_elem4 -> pad3 [style=invis]
> +  pad3 -> fn_htab_lru_map_update_elem_EBUSY  [style=invis]
> +
> +  // Reduce diagram width by forcing some nodes to appear above others
> +  local_freelist_check4 -> fn_htab_lru_map_update_elem3 [style=invis]
> +  common_lru_check2 -> pad4 [style=invis]
> +  pad4 -> local_freelist_check5 [style=invis]
> +}
> -- 
> 2.34.1
> 

Thanks again for this patch, this piece of documentation really helped
me understand internals of the LRU hashmap.
