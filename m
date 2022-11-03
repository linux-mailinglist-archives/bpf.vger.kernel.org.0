Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5B16189C1
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 21:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiKCUns (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 16:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiKCUnr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 16:43:47 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C071CFD9
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 13:43:45 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so2941952pji.0
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 13:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AxKD7HF4VVY6C126pnDDCJGczug2CgC+SjyJrp+YveA=;
        b=VeAQSesJwEH64QODI0Yl5C9dKS3LZi8MR8WaYRl2vBDnGQXOmKvh2o4b787hoZOS9T
         hULp9P//nxDgNnGT7lwRcfPoA7xGxlLLURCtf9w0wHwPrrCryBuTz7CASdoBisFrv3Cl
         CitYzycCIFl1Jn5xSQvT4yNtxfTkNsZx/fs8ZI3fgunXk4sRET894FS4HzWuOc98F0Rj
         Wgao2k/74FToyVATc/ECzlYGOixVKwdPPIHkywol/dUZt8I9nRMWGBCsPkAM7tfGFupx
         TGCkR7QZvgWdc6/FBen1wpXkdXmJ5KihpLpQ5AP5hEL6T2zIZH5Jmn7deB+D/6teUOTh
         9lfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AxKD7HF4VVY6C126pnDDCJGczug2CgC+SjyJrp+YveA=;
        b=mAbAFidY1POoA5YDZhZS+HrUvzPYgbPS7SoOPzRG7Cyv+TANiBTiQFGGXFogjjMH95
         Q0sHtR07kt52wQwbehMDOO/pxLZZ3m/0Vt6+zx8+8fbN7kcV18RuoCNJ2NkKSMQB0WN8
         bdB867cG3InkYy5T3DliYnucORuabKRkRvvaPbcrvRNhWdQfgmvxvw2kZFOPgbFCN8ZT
         8iK2YmYrXrurf0ntTFQIYjGrphZZxsFbHB+IyBFX0twoXw0QXd4CYrmbaHyCuAhLc2d1
         a8cx1c6ln4mFAUn64NWUfdmJ2d0slcxWdDTTSH3RsbHBbcxzJCz+oePZh7bPSnGrqGNt
         NcTg==
X-Gm-Message-State: ACrzQf0/YP5qQkSmarLtPcPxitlF+nia5SsnEfayVmks4m5/YDapfAAq
        m5BY6ann8FjZ6I6CTPYrqWva3P2ta7qcmw==
X-Google-Smtp-Source: AMsMyM4v6+6Us6YKO91yjeNjYrHRSjLkkemcfViaksLbMh647KaWDorG6N96eyQ+K+P+ZBud9m8wGw==
X-Received: by 2002:a17:902:64c1:b0:186:827e:a0da with SMTP id y1-20020a17090264c100b00186827ea0damr32197813pli.94.1667508223855;
        Thu, 03 Nov 2022 13:43:43 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-5-123.hsd1.ca.comcast.net. [73.93.5.123])
        by smtp.gmail.com with ESMTPSA id 2-20020a17090a0cc200b00212daa6f41dsm403110pjt.28.2022.11.03.13.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 13:43:43 -0700 (PDT)
From:   Joe Stringer <joe@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, corbet@lwn.net, martin.lau@linux.dev
Subject: [PATCH] docs/bpf: Add LRU internals description and graph
Date:   Thu,  3 Nov 2022 13:43:29 -0700
Message-Id: <20221103204330.3257910-1-joe@isovalent.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Extend the bpf hashmap docs to include a brief description of the
internals of the LRU map type (setting appropriate API expectations),
including the original commit message from Martin and a variant on the
graph that I had presented during my Linux Plumbers Conference 2022 talk
on "Pressure feedback for LRU map types"[0].

The node names in the dot file correspond roughly to the functions where
the logic for those decisions or steps is defined, to help curious
developers to cross-reference and update this logic if the details of
the LRU implementation ever differ from this description.

[0]: https://lpc.events/event/16/contributions/1368/

Signed-off-by: Joe Stringer <joe@isovalent.com>
---
 Documentation/bpf/map_hash.rst            | 193 ++++++++++++++++++++++
 Documentation/bpf/map_lru_hash_update.dot | 163 ++++++++++++++++++
 2 files changed, 356 insertions(+)
 create mode 100644 Documentation/bpf/map_lru_hash_update.dot

diff --git a/Documentation/bpf/map_hash.rst b/Documentation/bpf/map_hash.rst
index e85120878b27..1bf7c497e5fe 100644
--- a/Documentation/bpf/map_hash.rst
+++ b/Documentation/bpf/map_hash.rst
@@ -1,5 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0-only
 .. Copyright (C) 2022 Red Hat, Inc.
+.. Copyright (C) 2022 Isovalent, Inc.
 
 ===============================================
 BPF_MAP_TYPE_HASH, with PERCPU and LRU Variants
@@ -183,3 +184,195 @@ Userspace walking the map elements from the map declared above:
                     cur_key = &next_key;
             }
     }
+
+Internals
+=========
+
+This section of the document is targeted at Linux developers and describes
+aspects of the map implementations that are not considered stable ABI. The
+following details are subject to change in future versions of the kernel.
+
+``BPF_MAP_TYPE_LRU_HASH`` and variants
+--------------------------------------
+
+An LRU hashmap type consists of two properties: Firstly, it is a hash map and
+hence is indexable by key for constant time lookups. Secondly, when at map
+capacity, map updates will trigger eviction of old entries based on the age of
+the elements in a set of lists. Each of these properties may be either global
+or per-CPU, depending on the map type and flags used to create the map:
+
+.. flat-table:: Comparison of map properties by map type (x-axis) and flags
+   (y-axis)
+
+   * -
+     - ``BPF_MAP_TYPE_LRU_HASH``
+     - ``BPF_MAP_TYPE_LRU_PERCPU_HASH``
+
+   * - ``BPF_NO_COMMON_LRU``
+     - Per-CPU LRU, global map
+     - Per-CPU LRU, per-cpu map
+
+   * - ``!BPF_NO_COMMON_LRU``
+     - Global LRU, global map
+     - Global LRU, per-cpu map
+
+The commit message for LRU map support provides a general overview of the
+underlying LRU algorithm used for entry eviction when the table is full:
+
+::
+
+    commit 3a08c2fd763450a927d1130de078d6f9e74944fb
+    Author: Martin KaFai Lau <kafai@fb.com>
+    Date:   Fri Nov 11 10:55:06 2016 -0800
+
+        bpf: LRU List
+
+        Introduce bpf_lru_list which will provide LRU capability to
+        the bpf_htab in the later patch.
+
+        * General Thoughts:
+        1. Target use case.  Read is more often than update.
+           (i.e. bpf_lookup_elem() is more often than bpf_update_elem()).
+           If bpf_prog does a bpf_lookup_elem() first and then an in-place
+           update, it still counts as a read operation to the LRU list concern.
+        2. It may be useful to think of it as a LRU cache
+        3. Optimize the read case
+           3.1 No lock in read case
+           3.2 The LRU maintenance is only done during bpf_update_elem()
+        4. If there is a percpu LRU list, it will lose the system-wise LRU
+           property.  A completely isolated percpu LRU list has the best
+           performance but the memory utilization is not ideal considering
+           the work load may be imbalance.
+        5. Hence, this patch starts the LRU implementation with a global LRU
+           list with batched operations before accessing the global LRU list.
+           As a LRU cache, #read >> #update/#insert operations, it will work well.
+        6. There is a local list (for each cpu) which is named
+           'struct bpf_lru_locallist'.  This local list is not used to sort
+           the LRU property.  Instead, the local list is to batch enough
+           operations before acquiring the lock of the global LRU list.  More
+           details on this later.
+        7. In the later patch, it allows a percpu LRU list by specifying a
+           map-attribute for scalability reason and for use cases that need to
+           prepare for the worst (and pathological) case like DoS attack.
+           The percpu LRU list is completely isolated from each other and the
+           LRU nodes (including free nodes) cannot be moved across the list.  The
+           following description is for the global LRU list but mostly applicable
+           to the percpu LRU list also.
+
+        * Global LRU List:
+        1. It has three sub-lists: active-list, inactive-list and free-list.
+        2. The two list idea, active and inactive, is borrowed from the
+           page cache.
+        3. All nodes are pre-allocated and all sit at the free-list (of the
+           global LRU list) at the beginning.  The pre-allocation reasoning
+           is similar to the existing BPF_MAP_TYPE_HASH.  However,
+           opting-out prealloc (BPF_F_NO_PREALLOC) is not supported in
+           the LRU map.
+
+        * Active/Inactive List (of the global LRU list):
+        1. The active list, as its name says it, maintains the active set of
+           the nodes.  We can think of it as the working set or more frequently
+           accessed nodes.  The access frequency is approximated by a ref-bit.
+           The ref-bit is set during the bpf_lookup_elem().
+        2. The inactive list, as its name also says it, maintains a less
+           active set of nodes.  They are the candidates to be removed
+           from the bpf_htab when we are running out of free nodes.
+        3. The ordering of these two lists is acting as a rough clock.
+           The tail of the inactive list is the older nodes and
+           should be released first if the bpf_htab needs free element.
+
+        * Rotating the Active/Inactive List (of the global LRU list):
+        1. It is the basic operation to maintain the LRU property of
+           the global list.
+        2. The active list is only rotated when the inactive list is running
+           low.  This idea is similar to the current page cache.
+           Inactive running low is currently defined as
+           "# of inactive < # of active".
+        3. The active list rotation always starts from the tail.  It moves
+           node without ref-bit set to the head of the inactive list.
+           It moves node with ref-bit set back to the head of the active
+           list and then clears its ref-bit.
+        4. The inactive rotation is pretty simply.
+           It walks the inactive list and moves the nodes back to the head of
+           active list if its ref-bit is set. The ref-bit is cleared after moving
+           to the active list.
+           If the node does not have ref-bit set, it just leave it as it is
+           because it is already in the inactive list.
+
+        * Shrinking the Inactive List (of the global LRU list):
+        1. Shrinking is the operation to get free nodes when the bpf_htab is
+           full.
+        2. It usually only shrinks the inactive list to get free nodes.
+        3. During shrinking, it will walk the inactive list from the tail,
+           delete the nodes without ref-bit set from bpf_htab.
+        4. If no free node found after step (3), it will forcefully get
+           one node from the tail of inactive or active list.  Forcefully is
+           in the sense that it ignores the ref-bit.
+
+        * Local List:
+        1. Each CPU has a 'struct bpf_lru_locallist'.  The purpose is to
+           batch enough operations before acquiring the lock of the
+           global LRU.
+        2. A local list has two sub-lists, free-list and pending-list.
+        3. During bpf_update_elem(), it will try to get from the free-list
+           of (the current CPU local list).
+        4. If the local free-list is empty, it will acquire from the
+           global LRU list.  The global LRU list can either satisfy it
+           by its global free-list or by shrinking the global inactive
+           list.  Since we have acquired the global LRU list lock,
+           it will try to get at most LOCAL_FREE_TARGET elements
+           to the local free list.
+        5. When a new element is added to the bpf_htab, it will
+           first sit at the pending-list (of the local list) first.
+           The pending-list will be flushed to the global LRU list
+           when it needs to acquire free nodes from the global list
+           next time.
+
+        * Lock Consideration:
+        The LRU list has a lock (lru_lock).  Each bucket of htab has a
+        lock (buck_lock).  If both locks need to be acquired together,
+        the lock order is always lru_lock -> buck_lock and this only
+        happens in the bpf_lru_list.c logic.
+
+        In hashtab.c, both locks are not acquired together (i.e. one
+        lock is always released first before acquiring another lock).
+
+        Signed-off-by: Martin KaFai Lau <kafai@fb.com>
+        Acked-by: Alexei Starovoitov <ast@kernel.org>
+        Signed-off-by: David S. Miller <davem@davemloft.net>
+
+Notably, there are various steps that the update algorithm attempts in order to
+enforce the LRU property which have increasing impacts on other CPUs involved
+in the operations:
+
+- Attempt to use CPU-local state to batch operations
+- Attempt to fetch free nodes from global lists
+- Attempt to pull any node from a global list and remove it from the hashmap
+- Attempt to pull any node from any CPU's list and remove it from the hashmap
+
+Even if an LRU node may be acquired, maps of type ``BPF_MAP_TYPE_LRU_HASH``
+may fail to insert the entry into the map if other CPUs are heavily contending
+on the global hashmap lock.
+
+This algorithm is described visually in the following diagram:
+
+.. kernel-figure::  map_lru_hash_update.dot
+   :alt:    Diagram outlining the LRU eviction steps taken during map update
+
+   LRU hash eviction during map update for ``BPF_MAP_TYPE_LRU_HASH`` and
+   variants
+
+Map updates start from the oval in the top right "begin ``bpf_map_update()``"
+and progress through the graph towards the bottom where the result may be
+either a successful update or a failure with various error codes. The key in
+the top right provides indicators for which locks may be involved in specific
+operations. This is intended as a visual hint for reasoning about how map
+contention may impact update operations, though the map type and flags may
+impact the actual contention on those locks, based on the logic described in
+the table above. For instance, if the map is created with type
+``BPF_MAP_TYPE_LRU_PERCPU_HASH`` and flags ``BPF_NO_COMMON_LRU`` then all map
+properties would be per-cpu.
+
+The dot file source for the above diagram is uses internal kernel function
+names for the node names in order to make the corresponding logic easier to
+find. See ``Documentation/bpf/map_lru_hash_update.dot`` for more details.
diff --git a/Documentation/bpf/map_lru_hash_update.dot b/Documentation/bpf/map_lru_hash_update.dot
new file mode 100644
index 000000000000..735482a3896d
--- /dev/null
+++ b/Documentation/bpf/map_lru_hash_update.dot
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2022 Isovalent, Inc.
+digraph {
+  node [colorscheme=accent4,style=filled] # Apply colorscheme to all nodes
+  graph [splines=ortho, nodesep=1]
+
+  subgraph cluster_key {
+    label = "Key\n(locks held during operation)";
+    rankdir = TB;
+
+    remote_lock [shape=rectangle,fillcolor=4,label="🔒 remote CPU LRU lock"]
+    hash_lock [shape=rectangle,fillcolor=3,label="🔒 hashtab lock"]
+    lru_lock [shape=rectangle,fillcolor=2,label="🔒 LRU lock"]
+    local_lock [shape=rectangle,fillcolor=1,label="🔒 local CPU LRU lock"]
+    no_lock [shape=rectangle,label="🔓 no locks held"]
+  }
+
+  begin [shape=oval,label="begin\nbpf_map_update()"]
+
+  // Nodes below with an 'fn_' prefix are roughly labeled by the C function
+  // names that initiate the corresponding logic in kernel/bpf/bpf_lru_list.c.
+  // Number suffixes and errno suffixes handle subsections of the corresponding
+  // logic in the function as of the writing of this dot.
+  fn_bpf_lru_pop_free [shape=diamond,fillcolor=1,
+    label="Local freelist\nnode available?"];
+  fn__local_list_pop_free [shape=rectangle,
+    label="Use node owned\nby this CPU"]
+
+  common_lru_check [shape=diamond,
+    label="Map created with\nBPF_NO_COMMON_LRU\nflag set?"];
+
+  fn_bpf_lru_list_pop_free_to_local [shape=rectangle,fillcolor=2,
+    label="Flush local pending,
+    Rotate Global list, move
+    LOCAL_FREE_TARGET
+    from global -> local"]
+  // Also corresponds to:
+  // fn__local_list_flush()
+  // fn_bpf_lru_list_rotate()
+  fn___bpf_lru_node_move_to_free[shape=diamond,fillcolor=2,
+    label="Able to free\nLOCAL_FREE_TARGET\nnodes?"]
+
+  fn___bpf_lru_list_shrink_inactive [shape=rectangle,fillcolor=3,
+    label="Shrink inactive list
+      up to remaining
+      LOCAL_FREE_TARGET
+      (global LRU -> local)"]
+  fn___bpf_lru_list_shrink [shape=diamond,fillcolor=2,
+    label="> 0 entries in\nlocal free list?"]
+  fn___bpf_lru_list_shrink2 [shape=rectangle,fillcolor=2,
+    label="Steal one node from
+      inactive, or if empty,
+      from active global list"]
+  fn___bpf_lru_list_shrink3 [shape=rectangle,fillcolor=3,
+    label="Try to remove\nnode from hashtab"]
+
+  fn_bpf_lru_pop_free2 [shape=diamond,label="Htab removal\nsuccessful?"]
+  common_lru_check2 [shape=diamond,
+    label="Map created with\nBPF_NO_COMMON_LRU\nflag set?"]
+
+  subgraph cluster_remote_lock {
+    label = "🔁 Iterate through CPUs\n(start from current)";
+    style = dashed;
+    rankdir=LR;
+
+    fn_bpf_lru_pop_free5 [shape=diamond,fillcolor=4,
+      label="Steal a node from\nper-cpu freelist?"]
+    fn_bpf_lru_pop_free6 [shape=rectangle,fillcolor=4,
+      label="Steal a node from
+        (1) Unreferenced pending, or
+        (2) Any pending node"]
+    fn_bpf_lru_pop_free7 [shape=rectangle,fillcolor=3,
+      label="Try to remove\nnode from hashtab"]
+    fn_htab_lru_map_update_elem [shape=diamond,
+      label="Stole node\nfrom remote\nCPU?"]
+    fn_htab_lru_map_update_elem2 [shape=diamond,label="Iterated\nall CPUs?"]
+    // Also corresponds to:
+    // fn__local_list_pop_free()
+    // fn__local_list_pop_pending()
+  }
+
+  fn_bpf_lru_list_pop_free_to_local2 [shape=rectangle,
+    label="Use node that was\nnot recently referenced"]
+  fn_bpf_lru_pop_free4 [shape=rectangle,
+    label="Use node that was\nactively referenced\nin global list"]
+  fn_htab_lru_map_update_elem_ENOMEM [shape=oval,label="return -ENOMEM"]
+  fn_htab_lru_map_update_elem3 [shape=rectangle,
+    label="Use node that was\nactively referenced\nin (another?) CPU's cache"]
+  fn_htab_lru_map_update_elem4 [shape=diamond,
+    label="Can lock this\nhashtab bucket?"]
+  fn_htab_lru_map_update_elem5 [shape=rectangle,fillcolor=3,
+    label="Update hashmap\nwith new element"]
+  fn_htab_lru_map_update_elem6 [shape=oval,label="return 0"]
+  fn_htab_lru_map_update_elem_EBUSY [shape=oval,label="return -EBUSY"]
+
+  begin -> fn_bpf_lru_pop_free
+  fn_bpf_lru_pop_free -> fn__local_list_pop_free [xlabel="Y"]
+  fn_bpf_lru_pop_free -> common_lru_check [xlabel="N"]
+  common_lru_check -> fn_bpf_lru_list_pop_free_to_local [xlabel="Y"]
+  common_lru_check -> fn___bpf_lru_list_shrink_inactive [xlabel="N"]
+  fn_bpf_lru_list_pop_free_to_local -> fn___bpf_lru_node_move_to_free
+  fn___bpf_lru_node_move_to_free ->
+    fn_bpf_lru_list_pop_free_to_local2 [xlabel="Y"]
+  fn___bpf_lru_node_move_to_free ->
+    fn___bpf_lru_list_shrink_inactive [xlabel="N"]
+  fn___bpf_lru_list_shrink_inactive -> fn___bpf_lru_list_shrink
+  fn___bpf_lru_list_shrink -> fn_bpf_lru_list_pop_free_to_local2 [xlabel = "Y"]
+  fn___bpf_lru_list_shrink -> fn___bpf_lru_list_shrink2 [xlabel="N"]
+  fn___bpf_lru_list_shrink2 -> fn___bpf_lru_list_shrink3
+  fn___bpf_lru_list_shrink3 -> fn_bpf_lru_pop_free2
+  fn_bpf_lru_pop_free2 -> fn_bpf_lru_pop_free4 [xlabel = "Y"]
+  fn_bpf_lru_pop_free2 -> common_lru_check2 [xlabel = "N"]
+  common_lru_check2 -> fn_htab_lru_map_update_elem_ENOMEM [xlabel = "Y"]
+  common_lru_check2 -> fn_bpf_lru_pop_free5 [xlabel = "N"]
+  fn_bpf_lru_pop_free5 -> fn_htab_lru_map_update_elem [xlabel = "Y"]
+  fn_bpf_lru_pop_free5 -> fn_bpf_lru_pop_free6 [xlabel = "N"]
+  fn_bpf_lru_pop_free6 -> fn_bpf_lru_pop_free7
+  fn_bpf_lru_pop_free7 -> fn_htab_lru_map_update_elem
+
+  fn_htab_lru_map_update_elem -> fn_htab_lru_map_update_elem3 [xlabel = "Y"]
+  fn_htab_lru_map_update_elem -> fn_htab_lru_map_update_elem2  [xlabel = "N"]
+  fn_htab_lru_map_update_elem2 ->
+    fn_htab_lru_map_update_elem_ENOMEM [xlabel = "Y"]
+  fn_htab_lru_map_update_elem2 -> fn_bpf_lru_pop_free5 [xlabel = "N"]
+  fn_htab_lru_map_update_elem3 -> fn_htab_lru_map_update_elem4
+
+  fn__local_list_pop_free -> fn_htab_lru_map_update_elem4
+  fn_bpf_lru_list_pop_free_to_local2 -> fn_htab_lru_map_update_elem4
+  fn_bpf_lru_pop_free4 -> fn_htab_lru_map_update_elem4
+
+  fn_htab_lru_map_update_elem4 -> fn_htab_lru_map_update_elem5 [xlabel="Y"]
+  fn_htab_lru_map_update_elem4 ->
+    fn_htab_lru_map_update_elem_EBUSY [xlabel="N"]
+  fn_htab_lru_map_update_elem5 -> fn_htab_lru_map_update_elem6
+
+  // Create invisible pad nodes to line up various nodes
+  pad0 [style=invis]
+  pad1 [style=invis]
+  pad2 [style=invis]
+  pad3 [style=invis]
+  pad4 [style=invis]
+
+  // Line up the key with the top of the graph
+  no_lock -> local_lock [style=invis]
+  local_lock -> lru_lock [style=invis]
+  lru_lock -> hash_lock [style=invis]
+  hash_lock -> remote_lock [style=invis]
+  remote_lock -> fn_bpf_lru_pop_free5 [style=invis]
+  remote_lock -> fn___bpf_lru_list_shrink [style=invis]
+
+  // Line up return code nodes at the bottom of the graph
+  fn_htab_lru_map_update_elem -> pad0 [style=invis]
+  pad0 -> pad1 [style=invis]
+  pad1 -> pad2 [style=invis]
+  pad2-> fn_htab_lru_map_update_elem_ENOMEM [style=invis]
+  fn_htab_lru_map_update_elem4 -> pad3 [style=invis]
+  pad3 -> fn_htab_lru_map_update_elem_EBUSY  [style=invis]
+
+  // Reduce diagram width by forcing some nodes to appear above others
+  fn_bpf_lru_pop_free4 -> fn_htab_lru_map_update_elem3 [style=invis]
+  common_lru_check2 -> pad4 [style=invis]
+  pad4 -> fn_bpf_lru_pop_free5 [style=invis]
+}
-- 
2.25.1

