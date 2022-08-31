Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27B45A8382
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 18:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiHaQvV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 12:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiHaQvU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 12:51:20 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F5072EEC;
        Wed, 31 Aug 2022 09:51:19 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id cr9so11409796qtb.13;
        Wed, 31 Aug 2022 09:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=d88fmSpkkY6F2ZKIwxwgsU6nVAd26ZE20XMqAoaFMaU=;
        b=Q7mKqdN3wJFvFIOIcbwpQww9SqY5pXhLSyfuhOdqVa/6MJQtIb+VOkGzlhMhoHVOdf
         KNOOJy1Xvk75toM0B2Fc3fr2VS13dD7/Fn/ALZHQf0EkVCezLlN7P8a4UQrhpTcSFbtz
         yVho1Jf22Dm0tHcGgZ1I2PdeBkTI9QbBdIHgDIVtKpK0drGRef0Kqlzh7zeB5du5oYVU
         pMFSpYfXYnyvCS+ElDLj/KYLWAu+A9tZY+31P8U0KQcZTipvehOXyAhLb+uSzh69/6Sn
         BULlS8oQoKRI5wlb110d/nyeNOzRzLhDVaKEM4K9GDAIjtqVMWH1xpo98foivpN6YAEb
         KYyA==
X-Gm-Message-State: ACgBeo2WhlvV3rIzXnJMmAd15kZgeGiFRQM0KGV7S6545PtcoSHxq5g4
        It5OS1JCy1unz4CIcCEylLA=
X-Google-Smtp-Source: AA6agR6rWzbCkc+KWxcHV67KtyfcUUWbmJgU1GQZJSfu1DcnEbMz7qrOG5eB0gOdGLrW03Yg56EtkA==
X-Received: by 2002:a05:622a:12:b0:343:7535:6981 with SMTP id x18-20020a05622a001200b0034375356981mr20046450qtw.287.1661964678552;
        Wed, 31 Aug 2022 09:51:18 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::c6a9])
        by smtp.gmail.com with ESMTPSA id h5-20020a05622a170500b0034490214788sm9309334qtk.49.2022.08.31.09.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 09:51:18 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev
Cc:     song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, void@manifault.com,
        kernel-team@fb.com
Subject: [PATCH v4 1/4] bpf: Define new BPF_MAP_TYPE_USER_RINGBUF map type
Date:   Wed, 31 Aug 2022 11:51:16 -0500
Message-Id: <20220831165119.2216749-1-void@manifault.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We want to support a ringbuf map type where samples are published from
user-space, to be consumed by BPF programs. BPF currently supports a
kernel -> user-space circular ring buffer via the BPF_MAP_TYPE_RINGBUF
map type.  We'll need to define a new map type for user-space -> kernel,
as none of the helpers exported for BPF_MAP_TYPE_RINGBUF will apply
to a user-space producer ring buffer, and we'll want to add one or
more helper functions that would not apply for a kernel-producer
ring buffer.

This patch therefore adds a new BPF_MAP_TYPE_USER_RINGBUF map type
definition. The map type is useless in its current form, as there is no
way to access or use it for anything until we one or more BPF helpers. A
follow-on patch will therefore add a new helper function that allows BPF
programs to run callbacks on samples that are published to the ring
buffer.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: David Vernet <void@manifault.com>
---
 include/linux/bpf_types.h                     |  1 +
 include/uapi/linux/bpf.h                      |  1 +
 kernel/bpf/ringbuf.c                          | 62 +++++++++++++++++--
 kernel/bpf/verifier.c                         |  3 +
 .../bpf/bpftool/Documentation/bpftool-map.rst |  2 +-
 tools/bpf/bpftool/map.c                       |  2 +-
 tools/include/uapi/linux/bpf.h                |  1 +
 tools/lib/bpf/libbpf.c                        |  1 +
 8 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index 2b9112b80171..2c6a4f2562a7 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -126,6 +126,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_STRUCT_OPS, bpf_struct_ops_map_ops)
 #endif
 BPF_MAP_TYPE(BPF_MAP_TYPE_RINGBUF, ringbuf_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_BLOOM_FILTER, bloom_filter_map_ops)
+BPF_MAP_TYPE(BPF_MAP_TYPE_USER_RINGBUF, user_ringbuf_map_ops)
 
 BPF_LINK_TYPE(BPF_LINK_TYPE_RAW_TRACEPOINT, raw_tracepoint)
 BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 962960a98835..b1c36904831a 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -928,6 +928,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_INODE_STORAGE,
 	BPF_MAP_TYPE_TASK_STORAGE,
 	BPF_MAP_TYPE_BLOOM_FILTER,
+	BPF_MAP_TYPE_USER_RINGBUF,
 };
 
 /* Note that tracing related programs such as
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index b483aea35f41..0a8de712ecbe 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -38,10 +38,27 @@ struct bpf_ringbuf {
 	struct page **pages;
 	int nr_pages;
 	spinlock_t spinlock ____cacheline_aligned_in_smp;
-	/* Consumer and producer counters are put into separate pages to allow
-	 * mapping consumer page as r/w, but restrict producer page to r/o.
-	 * This protects producer position from being modified by user-space
-	 * application and ruining in-kernel position tracking.
+	/* Consumer and producer counters are put into separate pages to
+	 * allow each position to be mapped with different permissions.
+	 * This prevents a user-space application from modifying the
+	 * position and ruining in-kernel tracking. The permissions of the
+	 * pages depend on who is producing samples: user-space or the
+	 * kernel.
+	 *
+	 * Kernel-producer
+	 * ---------------
+	 * The producer position and data pages are mapped as r/o in
+	 * userspace. For this approach, bits in the header of samples are
+	 * used to signal to user-space, and to other producers, whether a
+	 * sample is currently being written.
+	 *
+	 * User-space producer
+	 * -------------------
+	 * Only the page containing the consumer position is mapped r/o in
+	 * user-space. User-space producers also use bits of the header to
+	 * communicate to the kernel, but the kernel must carefully check and
+	 * validate each sample to ensure that they're correctly formatted, and
+	 * fully contained within the ringbuffer.
 	 */
 	unsigned long consumer_pos __aligned(PAGE_SIZE);
 	unsigned long producer_pos __aligned(PAGE_SIZE);
@@ -224,7 +241,7 @@ static int ringbuf_map_get_next_key(struct bpf_map *map, void *key,
 	return -ENOTSUPP;
 }
 
-static int ringbuf_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
+static int ringbuf_map_mmap_kern(struct bpf_map *map, struct vm_area_struct *vma)
 {
 	struct bpf_ringbuf_map *rb_map;
 
@@ -242,6 +259,26 @@ static int ringbuf_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
 				   vma->vm_pgoff + RINGBUF_PGOFF);
 }
 
+static int ringbuf_map_mmap_user(struct bpf_map *map, struct vm_area_struct *vma)
+{
+	struct bpf_ringbuf_map *rb_map;
+
+	rb_map = container_of(map, struct bpf_ringbuf_map, map);
+
+	if (vma->vm_flags & VM_WRITE) {
+		if (vma->vm_pgoff == 0)
+			/* Disallow writable mappings to the consumer pointer,
+			 * and allow writable mappings to both the producer
+			 * position, and the ring buffer data itself.
+			 */
+			return -EPERM;
+	} else {
+		vma->vm_flags &= ~VM_MAYWRITE;
+	}
+	/* remap_vmalloc_range() checks size and offset constraints */
+	return remap_vmalloc_range(vma, rb_map->rb, vma->vm_pgoff + RINGBUF_PGOFF);
+}
+
 static unsigned long ringbuf_avail_data_sz(struct bpf_ringbuf *rb)
 {
 	unsigned long cons_pos, prod_pos;
@@ -269,7 +306,7 @@ const struct bpf_map_ops ringbuf_map_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
 	.map_alloc = ringbuf_map_alloc,
 	.map_free = ringbuf_map_free,
-	.map_mmap = ringbuf_map_mmap,
+	.map_mmap = ringbuf_map_mmap_kern,
 	.map_poll = ringbuf_map_poll,
 	.map_lookup_elem = ringbuf_map_lookup_elem,
 	.map_update_elem = ringbuf_map_update_elem,
@@ -278,6 +315,19 @@ const struct bpf_map_ops ringbuf_map_ops = {
 	.map_btf_id = &ringbuf_map_btf_ids[0],
 };
 
+BTF_ID_LIST_SINGLE(user_ringbuf_map_btf_ids, struct, bpf_ringbuf_map)
+const struct bpf_map_ops user_ringbuf_map_ops = {
+	.map_meta_equal = bpf_map_meta_equal,
+	.map_alloc = ringbuf_map_alloc,
+	.map_free = ringbuf_map_free,
+	.map_mmap = ringbuf_map_mmap_user,
+	.map_lookup_elem = ringbuf_map_lookup_elem,
+	.map_update_elem = ringbuf_map_update_elem,
+	.map_delete_elem = ringbuf_map_delete_elem,
+	.map_get_next_key = ringbuf_map_get_next_key,
+	.map_btf_id = &user_ringbuf_map_btf_ids[0],
+};
+
 /* Given pointer to ring buffer record metadata and struct bpf_ringbuf itself,
  * calculate offset from record metadata to ring buffer in pages, rounded
  * down. This page offset is stored as part of record metadata and allows to
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0194a36d0b36..37ce3208c626 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6206,6 +6206,8 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		    func_id != BPF_FUNC_ringbuf_discard_dynptr)
 			goto error;
 		break;
+	case BPF_MAP_TYPE_USER_RINGBUF:
+		goto error;
 	case BPF_MAP_TYPE_STACK_TRACE:
 		if (func_id != BPF_FUNC_get_stackid)
 			goto error;
@@ -12705,6 +12707,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 			}
 			break;
 		case BPF_MAP_TYPE_RINGBUF:
+		case BPF_MAP_TYPE_USER_RINGBUF:
 		case BPF_MAP_TYPE_INODE_STORAGE:
 		case BPF_MAP_TYPE_SK_STORAGE:
 		case BPF_MAP_TYPE_TASK_STORAGE:
diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index 7c188a598444..7f3b67a8b48f 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -55,7 +55,7 @@ MAP COMMANDS
 |		| **devmap** | **devmap_hash** | **sockmap** | **cpumap** | **xskmap** | **sockhash**
 |		| **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_storage**
 |		| **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf** | **inode_storage**
-|		| **task_storage** | **bloom_filter** }
+|		| **task_storage** | **bloom_filter** | **user_ringbuf** }
 
 DESCRIPTION
 ===========
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 38b6bc9c26c3..9a6ca9f31133 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1459,7 +1459,7 @@ static int do_help(int argc, char **argv)
 		"                 devmap | devmap_hash | sockmap | cpumap | xskmap | sockhash |\n"
 		"                 cgroup_storage | reuseport_sockarray | percpu_cgroup_storage |\n"
 		"                 queue | stack | sk_storage | struct_ops | ringbuf | inode_storage |\n"
-		"                 task_storage | bloom_filter }\n"
+		"                 task_storage | bloom_filter | user_ringbuf }\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
 		"                    {-f|--bpffs} | {-n|--nomount} }\n"
 		"",
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index f4ba82a1eace..c1f9c3766956 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -928,6 +928,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_INODE_STORAGE,
 	BPF_MAP_TYPE_TASK_STORAGE,
 	BPF_MAP_TYPE_BLOOM_FILTER,
+	BPF_MAP_TYPE_USER_RINGBUF,
 };
 
 /* Note that tracing related programs such as
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 3ad139285fad..6b580ba027ba 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -163,6 +163,7 @@ static const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_INODE_STORAGE]		= "inode_storage",
 	[BPF_MAP_TYPE_TASK_STORAGE]		= "task_storage",
 	[BPF_MAP_TYPE_BLOOM_FILTER]		= "bloom_filter",
+	[BPF_MAP_TYPE_USER_RINGBUF]             = "user_ringbuf",
 };
 
 static const char * const prog_type_name[] = {
-- 
2.37.1

