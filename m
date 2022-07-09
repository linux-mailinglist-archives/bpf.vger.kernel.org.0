Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C107356C57F
	for <lists+bpf@lfdr.de>; Sat,  9 Jul 2022 02:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiGIAid (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 20:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiGIAi3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 20:38:29 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBF88C140;
        Fri,  8 Jul 2022 17:30:36 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657326634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ADYFef2dhxd8+x7QZlU5pjPg3v772ubcP31/2D1XlmI=;
        b=ikXDP09OMwIP8qm9d0t3habipvuLSnv3b4kLHC9tJODJKgs18KSBciUYYv6Htd2DuejyKl
        dCP/CtT1BAcp68ahR7BVeYJxD4q5Yk+jT0Zxg0D4Xcnhst6mkMYlpLgMBLncVOCVua5Rsp
        wgMdhK7K+g6JodLCa3YbJ95K74Q+aAo=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Shakeel Butt <shakeelb@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH bpf-next] bpf: reparent bpf maps on memcg offlining
Date:   Fri,  8 Jul 2022 17:28:58 -0700
Message-Id: <20220709002858.129534-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The memory consumed by a mpf map is always accounted to the memory
cgroup of the process which created the map. The map can outlive
the memory cgroup if it's used by processes in other cgroups or
is pinned on bpffs. In this case the map pins the original cgroup
in the dying state.

For other types of objects (slab objects, non-slab kernel allocations,
percpu objects and recently LRU pages) there is a reparenting process
implemented: on cgroup offlining charged objects are getting
reassigned to the parent cgroup. Because all charges and statistics
are fully recursive it's a fairly cheap operation.

For efficiency and consistency with other types of objects, let's do
the same for bpf maps. Fortunately thanks to the objcg API, the
required changes are minimal.

Please, note that individual allocations (slabs, percpu and large
kmallocs) already have the reparenting mechanism. This commit adds
it to the saved map->memcg pointer by replacing it to map->objcg.
Because dying cgroups are not visible for a user and all charges are
recursive, this commit doesn't bring any behavior changes for a user.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/bpf.h  |  2 +-
 kernel/bpf/syscall.c | 35 +++++++++++++++++++++++++++--------
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2b21f2a3452f..85a4db3e0536 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -221,7 +221,7 @@ struct bpf_map {
 	u32 btf_vmlinux_value_type_id;
 	struct btf *btf;
 #ifdef CONFIG_MEMCG_KMEM
-	struct mem_cgroup *memcg;
+	struct obj_cgroup *objcg;
 #endif
 	char name[BPF_OBJ_NAME_LEN];
 	struct bpf_map_off_arr *off_arr;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ab688d85b2c6..432cbbc74ba6 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -419,35 +419,52 @@ void bpf_map_free_id(struct bpf_map *map, bool do_idr_lock)
 #ifdef CONFIG_MEMCG_KMEM
 static void bpf_map_save_memcg(struct bpf_map *map)
 {
-	map->memcg = get_mem_cgroup_from_mm(current->mm);
+	/* Currently if a map is created by a process belonging to the root
+	 * memory cgroup, get_obj_cgroup_from_current() will return NULL.
+	 * So we have to check map->objcg for being NULL each time it's
+	 * being used.
+	 */
+	map->objcg = get_obj_cgroup_from_current();
 }
 
 static void bpf_map_release_memcg(struct bpf_map *map)
 {
-	mem_cgroup_put(map->memcg);
+	if (map->objcg)
+		obj_cgroup_put(map->objcg);
+}
+
+static struct mem_cgroup *bpf_map_get_memcg(struct bpf_map *map) {
+	if (map->objcg)
+		return get_mem_cgroup_from_objcg(map->objcg);
+
+	return root_mem_cgroup;
 }
 
 void *bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t flags,
 			   int node)
 {
-	struct mem_cgroup *old_memcg;
+	struct mem_cgroup *memcg, *old_memcg;
 	void *ptr;
 
-	old_memcg = set_active_memcg(map->memcg);
+	memcg = bpf_map_get_memcg(map);
+	old_memcg = set_active_memcg(memcg);
 	ptr = kmalloc_node(size, flags | __GFP_ACCOUNT, node);
 	set_active_memcg(old_memcg);
+	mem_cgroup_put(memcg);
 
 	return ptr;
 }
 
 void *bpf_map_kzalloc(const struct bpf_map *map, size_t size, gfp_t flags)
 {
-	struct mem_cgroup *old_memcg;
+	struct mem_cgroup *memcg, *old_memcg;
 	void *ptr;
 
-	old_memcg = set_active_memcg(map->memcg);
+	memcg = bpf_map_get_memcg(map);
+	old_memcg = set_active_memcg(memcg);
 	ptr = kzalloc(size, flags | __GFP_ACCOUNT);
 	set_active_memcg(old_memcg);
+	mem_cgroup_put(memcg);
 
 	return ptr;
 }
@@ -455,12 +472,14 @@ void *bpf_map_kzalloc(const struct bpf_map *map, size_t size, gfp_t flags)
 void __percpu *bpf_map_alloc_percpu(const struct bpf_map *map, size_t size,
 				    size_t align, gfp_t flags)
 {
-	struct mem_cgroup *old_memcg;
+	struct mem_cgroup *memcg, *old_memcg;
 	void __percpu *ptr;
 
-	old_memcg = set_active_memcg(map->memcg);
+	memcg = bpf_map_get_memcg(map);
+	old_memcg = set_active_memcg(memcg);
 	ptr = __alloc_percpu_gfp(size, align, flags | __GFP_ACCOUNT);
 	set_active_memcg(old_memcg);
+	mem_cgroup_put(memcg);
 
 	return ptr;
 }
-- 
2.36.1

