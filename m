Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CB4590950
	for <lists+bpf@lfdr.de>; Fri, 12 Aug 2022 01:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbiHKXuF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Aug 2022 19:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236013AbiHKXuB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Aug 2022 19:50:01 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4E59C8DE;
        Thu, 11 Aug 2022 16:50:00 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id h4so7916422qtj.11;
        Thu, 11 Aug 2022 16:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=o1i1P7ZYEDFAHq3+mM3wwgPEcCvB3rOJ7Mg49hLrpUg=;
        b=BKhC/d1h1aPiS9wIh2VpsiFr9/Xm1IZnUmq5QqNuP4T+Z0ej/k/qN53aR80LLM7Esm
         Q44F4VEWdPche0bgL5SKGuEvLYIoBYOU1tszs3VZSvH2jx+tk5EgfHvXndmHwVGDPDw1
         HJQZqQK4Zcz+/Urw2cX4RbJepzxqIEoo2eezPsf+ikIFM9eEZvrUAMmF0nxTHez/uEnI
         sPRgByUX26k8zwary+qzeMrGSkEk5tMFobzIyGaKO42hl5Tw2AF9UyXEnv8knoKNvAf4
         5KOjue+0roN3jQ63S1TezqPpjhdBnKtn7KFZ1ic9YNAp5vMZVgQ9WgjN6wihc3RfqL5W
         QMlw==
X-Gm-Message-State: ACgBeo3Kq2sH3szmgJ+U/ZPRlDcLXpUfgyiU8zYtsiwlxFxrPj0hTBqG
        1F2fjZm5GNHZsZ1ufVEGVnvaEyto62vdHeB2
X-Google-Smtp-Source: AA6agR67+1Y3EhfKcxXiGkLEgTmlP1NOuYJtAYGnPir0tHXzFEUjXBEmnpQAI9h4uGCGiTUZXyvTMA==
X-Received: by 2002:ac8:5dcf:0:b0:341:fab1:9411 with SMTP id e15-20020ac85dcf000000b00341fab19411mr1507026qtx.650.1660261799105;
        Thu, 11 Aug 2022 16:49:59 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::bfe0])
        by smtp.gmail.com with ESMTPSA id f5-20020a05620a408500b006b5d8eb2414sm486970qko.120.2022.08.11.16.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 16:49:58 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Cc:     haoluo@google.com, joannelkoong@gmail.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com,
        song@kernel.org, yhs@fb.com, kernel-team@fb.com, tj@kernel.org
Subject: [PATCH v2 1/4] bpf: Define new BPF_MAP_TYPE_USER_RINGBUF map type
Date:   Thu, 11 Aug 2022 18:49:38 -0500
Message-Id: <20220811234941.887747-2-void@manifault.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220811234941.887747-1-void@manifault.com>
References: <20220811234941.887747-1-void@manifault.com>
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
user-space to BPF programs. BPF currently supports a kernel -> user-space
circular ringbuffer via the BPF_MAP_TYPE_RINGBUF map type. We'll need to
define a new map type for user-space -> kernel, as none of the helpers
exported for BPF_MAP_TYPE_RINGBUF will apply to a user-space producer
ringbuffer, and we'll want to add one or more helper functions that would
not apply for a kernel-producer ringbuffer.

This patch therefore adds a new BPF_MAP_TYPE_USER_RINGBUF map type
definition. The map type is useless in its current form, as there is no way
to access or use it for anything until we add more BPF helpers. A follow-on
patch will therefore add a new helper function that allows BPF programs to
run callbacks on samples that are published to the ringbuffer.

Signed-off-by: David Vernet <void@manifault.com>
---
 include/linux/bpf_types.h      |  1 +
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/ringbuf.c           | 70 +++++++++++++++++++++++++++++-----
 kernel/bpf/verifier.c          |  3 ++
 tools/include/uapi/linux/bpf.h |  1 +
 tools/lib/bpf/libbpf.c         |  1 +
 6 files changed, 68 insertions(+), 9 deletions(-)

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
index 7d1e2794d83e..b8ec9e741a43 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -909,6 +909,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_INODE_STORAGE,
 	BPF_MAP_TYPE_TASK_STORAGE,
 	BPF_MAP_TYPE_BLOOM_FILTER,
+	BPF_MAP_TYPE_USER_RINGBUF,
 };
 
 /* Note that tracing related programs such as
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index b483aea35f41..c0f3bca4bb09 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -38,12 +38,32 @@ struct bpf_ringbuf {
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
+	 * Only the page containing the consumer position, and whether the
+	 * ringbuffer is currently being consumed via a 'busy' bit, are
+	 * mapped r/o in user-space. Sample headers may not be used to
+	 * communicate any information between kernel consumers, as a
+	 * user-space application could modify its contents at any time.
 	 */
-	unsigned long consumer_pos __aligned(PAGE_SIZE);
+	struct {
+		unsigned long consumer_pos;
+		atomic_t busy;
+	} __aligned(PAGE_SIZE);
 	unsigned long producer_pos __aligned(PAGE_SIZE);
 	char data[] __aligned(PAGE_SIZE);
 };
@@ -141,6 +161,7 @@ static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t data_sz, int numa_node)
 
 	rb->mask = data_sz - 1;
 	rb->consumer_pos = 0;
+	atomic_set(&rb->busy, 0);
 	rb->producer_pos = 0;
 
 	return rb;
@@ -224,15 +245,23 @@ static int ringbuf_map_get_next_key(struct bpf_map *map, void *key,
 	return -ENOTSUPP;
 }
 
-static int ringbuf_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
+static int ringbuf_map_mmap(struct bpf_map *map, struct vm_area_struct *vma,
+			    bool kernel_producer)
 {
 	struct bpf_ringbuf_map *rb_map;
 
 	rb_map = container_of(map, struct bpf_ringbuf_map, map);
 
 	if (vma->vm_flags & VM_WRITE) {
-		/* allow writable mapping for the consumer_pos only */
-		if (vma->vm_pgoff != 0 || vma->vm_end - vma->vm_start != PAGE_SIZE)
+		if (kernel_producer) {
+			/* allow writable mapping for the consumer_pos only */
+			if (vma->vm_pgoff != 0 || vma->vm_end - vma->vm_start != PAGE_SIZE)
+				return -EPERM;
+		/* For user ringbufs, disallow writable mappings to the
+		 * consumer pointer, and allow writable mappings to both the
+		 * producer position, and the ring buffer data itself.
+		 */
+		} else if (vma->vm_pgoff == 0)
 			return -EPERM;
 	} else {
 		vma->vm_flags &= ~VM_MAYWRITE;
@@ -242,6 +271,16 @@ static int ringbuf_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
 				   vma->vm_pgoff + RINGBUF_PGOFF);
 }
 
+static int ringbuf_map_mmap_kern(struct bpf_map *map, struct vm_area_struct *vma)
+{
+	return ringbuf_map_mmap(map, vma, true);
+}
+
+static int ringbuf_map_mmap_user(struct bpf_map *map, struct vm_area_struct *vma)
+{
+	return ringbuf_map_mmap(map, vma, false);
+}
+
 static unsigned long ringbuf_avail_data_sz(struct bpf_ringbuf *rb)
 {
 	unsigned long cons_pos, prod_pos;
@@ -269,7 +308,7 @@ const struct bpf_map_ops ringbuf_map_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
 	.map_alloc = ringbuf_map_alloc,
 	.map_free = ringbuf_map_free,
-	.map_mmap = ringbuf_map_mmap,
+	.map_mmap = ringbuf_map_mmap_kern,
 	.map_poll = ringbuf_map_poll,
 	.map_lookup_elem = ringbuf_map_lookup_elem,
 	.map_update_elem = ringbuf_map_update_elem,
@@ -278,6 +317,19 @@ const struct bpf_map_ops ringbuf_map_ops = {
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
index 2c1f8069f7b7..970ec5c7ce05 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6202,6 +6202,8 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		    func_id != BPF_FUNC_ringbuf_discard_dynptr)
 			goto error;
 		break;
+	case BPF_MAP_TYPE_USER_RINGBUF:
+		goto error;
 	case BPF_MAP_TYPE_STACK_TRACE:
 		if (func_id != BPF_FUNC_get_stackid)
 			goto error;
@@ -12681,6 +12683,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 			}
 			break;
 		case BPF_MAP_TYPE_RINGBUF:
+		case BPF_MAP_TYPE_USER_RINGBUF:
 		case BPF_MAP_TYPE_INODE_STORAGE:
 		case BPF_MAP_TYPE_SK_STORAGE:
 		case BPF_MAP_TYPE_TASK_STORAGE:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index e174ad28aeb7..ee04b71969b4 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -909,6 +909,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_INODE_STORAGE,
 	BPF_MAP_TYPE_TASK_STORAGE,
 	BPF_MAP_TYPE_BLOOM_FILTER,
+	BPF_MAP_TYPE_USER_RINGBUF,
 };
 
 /* Note that tracing related programs such as
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 917d975bd4c6..244d7b883dc8 100644
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

