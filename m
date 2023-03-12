Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156B36B6A86
	for <lists+bpf@lfdr.de>; Sun, 12 Mar 2023 20:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjCLTGo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Mar 2023 15:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjCLTGl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 12 Mar 2023 15:06:41 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8662FCD0
        for <bpf@vger.kernel.org>; Sun, 12 Mar 2023 12:06:10 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id x11so10694568pln.12
        for <bpf@vger.kernel.org>; Sun, 12 Mar 2023 12:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1678647969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rOMUBGsRZzHSU3oSHykC3REPB9FrAxNbZraK4eFDcQI=;
        b=XtB/N5XrDFO/ucntG2OMKTiWLPRIULt9hK2U2iGr6/UQ6jeYO6pFDLH+T/vY4tCF6n
         EjOMwvCstWy4z5RRbykAQMFA6MnwxDkMfwmZ3VJZAMIT5IE2omI4wh4ls2rLNp7jD7GR
         aOB0drMh7gFbGcdayh3TXC2+Uvue66pp7nW/XW5NH9O1xMl9xy7i4ytQ6yakQ5JaPIS6
         fD8kCn0kdOzF26OBnHqbu1N27akolhXX++WtMEm1ZJGaKNNF68H6OBicK8tQbcg3F4fv
         uz8TFLgrfZShS4IatrdeDJeckj2fTO+Ep9YzgBMrWe6U2N5BiNDKHNb8Cb2eKb1nevWS
         yElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678647969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rOMUBGsRZzHSU3oSHykC3REPB9FrAxNbZraK4eFDcQI=;
        b=OdaLvat0jVtrs3qBhXLoyKr2ru6BpWvUenrhFxkptP+vi1Mm3BV+XlFrrN39Gj/IoA
         JqziIvf690lO2iBz0Z8M5jOj8QwfItZnMh8sXpE7moa/3w7Ub34qSr1fSusNcPJf5anS
         INIagsa7dh9RRL+sfjb6E77/Zb+7Hcn9GHhSOVWpbO73CXJ4zgZV/EHDu8uU+ey1PgLT
         b42rZ3e3mzc3wAeaFcNKpzuU5C0tS6207BjXZwBHqQYaP5Wdpds659LZQK9oLJPkOYMT
         whwfoRi9ODa2ZYZFWQDaGgXKhzquB/uBHEOxma/VU5tO2MOja5o414un1n0zUJ0rUvLu
         +XYw==
X-Gm-Message-State: AO0yUKU+h47SsjIdeBtvAq5sXBKSjtf4id63oVrNwLl/jFTyKEkfBkc0
        +/sAFFY4+Jzy+erUP5D5pTXW00BeoxD4mDayvwpOXQ==
X-Google-Smtp-Source: AK7set+lvdu4fS+rS3QWFBMXVZA3tYY0bwEupe1RcWF33D6AsWxMo4OYmcho/cE8OVcftdqJs8n4Yg==
X-Received: by 2002:a17:902:ec8a:b0:19d:138b:7c4a with SMTP id x10-20020a170902ec8a00b0019d138b7c4amr38249664plg.3.1678647968685;
        Sun, 12 Mar 2023 12:06:08 -0700 (PDT)
Received: from carnotaurus.. (c-73-231-147-44.hsd1.ca.comcast.net. [73.231.147.44])
        by smtp.gmail.com with ESMTPSA id ld14-20020a170902face00b0019f387f2dc3sm1590903plb.24.2023.03.12.12.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 12:06:08 -0700 (PDT)
From:   Joe Stringer <joe@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, corbet@lwn.net, martin.lau@linux.dev,
        bagasdotme@gmail.com, maxtram95@gmail.com
Subject: [PATCH bpf-next v3] docs/bpf: Add LRU internals description and graph
Date:   Sun, 12 Mar 2023 12:05:59 -0700
Message-Id: <20230312190600.324573-1-joe@isovalent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
v3: Use standard table syntax
    Replace inline commit message with reference to commit
    Fix incorrect Y/N label for common LRU check
    Rename some dotfile variables to reduce confusion between cases
    Minor wording touchups
v2: Fix issue that caused initial email submission to fail
---
 Documentation/bpf/map_hash.rst            |  62 ++++++++
 Documentation/bpf/map_lru_hash_update.dot | 166 ++++++++++++++++++++++
 2 files changed, 228 insertions(+)
 create mode 100644 Documentation/bpf/map_lru_hash_update.dot

diff --git a/Documentation/bpf/map_hash.rst b/Documentation/bpf/map_hash.rst
index 8669426264c6..61602ce26561 100644
--- a/Documentation/bpf/map_hash.rst
+++ b/Documentation/bpf/map_hash.rst
@@ -1,5 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0-only
 .. Copyright (C) 2022 Red Hat, Inc.
+.. Copyright (C) 2022-2023 Isovalent, Inc.
 
 ===============================================
 BPF_MAP_TYPE_HASH, with PERCPU and LRU Variants
@@ -206,3 +207,64 @@ Userspace walking the map elements from the map declared above:
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
++------------------------+---------------------------+----------------------------------+
+|                        | ``BPF_MAP_TYPE_LRU_HASH`` | ``BPF_MAP_TYPE_LRU_PERCPU_HASH`` |
++========================+===========================+==================================+
+| ``BPF_NO_COMMON_LRU``  | Per-CPU LRU, global map   | Per-CPU LRU, per-cpu map         |
++------------------------+---------------------------+----------------------------------+
+| ``!BPF_NO_COMMON_LRU`` | Global LRU, global map    | Global LRU, per-cpu map          |
++------------------------+---------------------------+----------------------------------+
+
+Notably, there are various steps that the update algorithm attempts in order to
+enforce the LRU property which have increasing impacts on other CPUs involved
+in the following operation attempts:
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
+This algorithm is described visually in the following diagram. See the
+description in commit 3a08c2fd7634 ("bpf: LRU List") for a full explanation of
+the corresponding operations:
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
+The dot file source for the above figure uses internal kernel function names
+for the node names in order to make the corresponding logic easier to find.
diff --git a/Documentation/bpf/map_lru_hash_update.dot b/Documentation/bpf/map_lru_hash_update.dot
new file mode 100644
index 000000000000..3a44ebec501e
--- /dev/null
+++ b/Documentation/bpf/map_lru_hash_update.dot
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2022-2023 Isovalent, Inc.
+digraph {
+  node [colorscheme=accent4,style=filled] # Apply colorscheme to all nodes
+  graph [splines=ortho, nodesep=1]
+
+  subgraph cluster_key {
+    label = "Key\n(locks held during operation)";
+    rankdir = TB;
+
+    remote_lock [shape=rectangle,fillcolor=4,label="remote CPU LRU lock"]
+    hash_lock [shape=rectangle,fillcolor=3,label="hashtab lock"]
+    lru_lock [shape=rectangle,fillcolor=2,label="LRU lock"]
+    local_lock [shape=rectangle,fillcolor=1,label="local CPU LRU lock"]
+    no_lock [shape=rectangle,label="no locks held"]
+  }
+
+  begin [shape=oval,label="begin\nbpf_map_update()"]
+
+  // Nodes below with an 'fn_' prefix are roughly labeled by the C function
+  // names that initiate the corresponding logic in kernel/bpf/bpf_lru_list.c.
+  // Number suffixes and errno suffixes handle subsections of the corresponding
+  // logic in the function as of the writing of this dot.
+
+  // The following corresponds to bpf_lru_pop_free() for common LRU case.
+  local_freelist_check [shape=diamond,fillcolor=1,
+    label="Local freelist\nnode available?"];
+  // The following corresponds to __local_list_pop_free() for common LRU case.
+  use_local_node [shape=rectangle,
+    label="Use node owned\nby this CPU"]
+
+  common_lru_check [shape=diamond,
+    label="Map created with\ncommon LRU?\n(!BPF_NO_COMMON_LRU)"];
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
+  local_freelist_check2 [shape=diamond,label="Htab removal\nsuccessful?"]
+  common_lru_check2 [shape=diamond,
+    label="Map created with\ncommon LRU?\n(!BPF_NO_COMMON_LRU)"];
+
+  subgraph cluster_remote_lock {
+    label = "Iterate through CPUs\n(start from current)";
+    style = dashed;
+    rankdir=LR;
+
+    local_freelist_check5 [shape=diamond,fillcolor=4,
+      label="Steal a node from\nper-cpu freelist?"]
+    local_freelist_check6 [shape=rectangle,fillcolor=4,
+      label="Steal a node from
+        (1) Unreferenced pending, or
+        (2) Any pending node"]
+    local_freelist_check7 [shape=rectangle,fillcolor=3,
+      label="Try to remove\nnode from hashtab"]
+    fn_htab_lru_map_update_elem [shape=diamond,
+      label="Stole node\nfrom remote\nCPU?"]
+    fn_htab_lru_map_update_elem2 [shape=diamond,label="Iterated\nall CPUs?"]
+    // Also corresponds to:
+    // use_local_node()
+    // fn__local_list_pop_pending()
+  }
+
+  fn_bpf_lru_list_pop_free_to_local2 [shape=rectangle,
+    label="Use node that was\nnot recently referenced"]
+  local_freelist_check4 [shape=rectangle,
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
+  begin -> local_freelist_check
+  local_freelist_check -> use_local_node [xlabel="Y"]
+  local_freelist_check -> common_lru_check [xlabel="N"]
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
+  fn___bpf_lru_list_shrink3 -> local_freelist_check2
+  local_freelist_check2 -> local_freelist_check4 [xlabel = "Y"]
+  local_freelist_check2 -> common_lru_check2 [xlabel = "N"]
+  common_lru_check2 -> local_freelist_check5 [xlabel = "Y"]
+  common_lru_check2 -> fn_htab_lru_map_update_elem_ENOMEM [xlabel = "N"]
+  local_freelist_check5 -> fn_htab_lru_map_update_elem [xlabel = "Y"]
+  local_freelist_check5 -> local_freelist_check6 [xlabel = "N"]
+  local_freelist_check6 -> local_freelist_check7
+  local_freelist_check7 -> fn_htab_lru_map_update_elem
+
+  fn_htab_lru_map_update_elem -> fn_htab_lru_map_update_elem3 [xlabel = "Y"]
+  fn_htab_lru_map_update_elem -> fn_htab_lru_map_update_elem2  [xlabel = "N"]
+  fn_htab_lru_map_update_elem2 ->
+    fn_htab_lru_map_update_elem_ENOMEM [xlabel = "Y"]
+  fn_htab_lru_map_update_elem2 -> local_freelist_check5 [xlabel = "N"]
+  fn_htab_lru_map_update_elem3 -> fn_htab_lru_map_update_elem4
+
+  use_local_node -> fn_htab_lru_map_update_elem4
+  fn_bpf_lru_list_pop_free_to_local2 -> fn_htab_lru_map_update_elem4
+  local_freelist_check4 -> fn_htab_lru_map_update_elem4
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
+  remote_lock -> local_freelist_check5 [style=invis]
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
+  local_freelist_check4 -> fn_htab_lru_map_update_elem3 [style=invis]
+  common_lru_check2 -> pad4 [style=invis]
+  pad4 -> local_freelist_check5 [style=invis]
+}
-- 
2.34.1

