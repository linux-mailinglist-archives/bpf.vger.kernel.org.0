Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031986B8A39
	for <lists+bpf@lfdr.de>; Tue, 14 Mar 2023 06:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjCNFVm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 01:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCNFVl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 01:21:41 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42512911C6;
        Mon, 13 Mar 2023 22:21:38 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso3763068pjb.0;
        Mon, 13 Mar 2023 22:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678771298;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrAb4Yj3PAEnuSSPiEBtod2BllVG0Rn+m21e9tqnUjI=;
        b=YCepn7QRSG4lb2WbIC7IP2RW6pAwdwcB4bnVYmr6KXSHEcmwM/mzMjIl4vdWftcuMV
         bkcuHvh64N4wg8GMrQgZlyqhdbPrKMCorgZpIda7n6NNSQ5TfLeOT/kjIoPvCoSRoA1F
         N4U22398I3p2wBZApx1Y79Baa9FVpYMDkaqI9z3/MKJzYZ2yJj3A170qBX/ad3X5X8qL
         aPfjT/DcYeezikPXwgHmUIwATw0g3EWNY/DlcISoB28JXBzerdd1J/cV59HKbKwssFr+
         Re8ABOqf/j9ZgmRP8ijeoQnPcG4PNbP2Ab7zjfcaM431DbNWyNxhHbwgGjR6GzpXBYz7
         7CAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678771298;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BrAb4Yj3PAEnuSSPiEBtod2BllVG0Rn+m21e9tqnUjI=;
        b=Knf0jmHhDuIumAEAW9XsdUB8icB00l1Zdge0fw8O7izF51Fxe6ghEf5+Vc6lSupzNv
         DUMyCHgLJEGikkZCzC8Bvr7x8KnYrLWGFs5dTNUzmNHGJ1l3++il2eWua4DPXoUMArbB
         zIg1W2M+HQEkAWlRIhQzOu01Mvqydl4FGpf5wVhVBVMVM5/BFMBdLIosUZI+0ustdjP9
         WId7ENHREzBhViQsslhTYFyNmL3nzdwFqNDPwZGjPmS2f2Zsng//PcGyRgiyuTWnJp3A
         YpQQvlu7Yltpe3YP5SaGhFxS6HHe1T+gwLW9szbLRVVqRt9PlTHuks21UmVcWH9ZCYNj
         Rwqw==
X-Gm-Message-State: AO0yUKVdLNZYGA+X6P9VkW923Z7AXtTv0EUU486HF3DYsXZQrCrtP6kR
        bS/Rxzu+JuTkZXSYtgeWHPs=
X-Google-Smtp-Source: AK7set+rzqdd8vpyaeD9+l1GjviI3riHIjxR+eCJZzncrgvBlr6YnLBxAZZnLV0EBJO30E/2AU5IzA==
X-Received: by 2002:a17:902:db0f:b0:19e:7a2d:19f2 with SMTP id m15-20020a170902db0f00b0019e7a2d19f2mr46026822plx.19.1678771297638;
        Mon, 13 Mar 2023 22:21:37 -0700 (PDT)
Received: from localhost ([98.97.116.12])
        by smtp.gmail.com with ESMTPSA id kb14-20020a170903338e00b001990028c0c9sm738692plb.68.2023.03.13.22.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 22:21:37 -0700 (PDT)
Date:   Mon, 13 Mar 2023 22:21:36 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Joe Stringer <joe@isovalent.com>, bpf@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, corbet@lwn.net, martin.lau@linux.dev,
        bagasdotme@gmail.com, maxtram95@gmail.com
Message-ID: <6410046013834_42581208fd@john.notmuch>
In-Reply-To: <20230312190600.324573-1-joe@isovalent.com>
References: <20230312190600.324573-1-joe@isovalent.com>
Subject: RE: [PATCH bpf-next v3] docs/bpf: Add LRU internals description and
 graph
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Joe Stringer wrote:
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


Thanks couple nits below

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

Above all seems API to me. Maybe move the statement about not considered stable
ABI down here? Something like,

"
The internal details of which entry is evicted and acquiring a new entry
are not considered stable and may change in the future. But the current
impelementation is as follows.
"

Or something like that?

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

Similarly this is ABI correct? Probably we can also specify the error code? 
Assuming it is just EBUSY or EAGAIN?

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
> +  local_freelist_check [shape=diamond,fillcolor=1,
> +    label="Local freelist\nnode available?"];
> +  // The following corresponds to __local_list_pop_free() for common LRU case.
> +  use_local_node [shape=rectangle,
> +    label="Use node owned\nby this CPU"]
> +
> +  common_lru_check [shape=diamond,
> +    label="Map created with\ncommon LRU?\n(!BPF_NO_COMMON_LRU)"];
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


