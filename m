Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A898358CB9D
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 17:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243818AbiHHPyH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 11:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243825AbiHHPyC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 11:54:02 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75D11572B;
        Mon,  8 Aug 2022 08:54:01 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id h22so6803519qta.3;
        Mon, 08 Aug 2022 08:54:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=UlHSuxkQSQ3o+bH8xHspFJMLiMBG1bEpBXDqeJ5N5NM=;
        b=LSRCGkiyLkf901K0uGJfay0Y9vZTOsblx/0klFjQKyOiww0lvYNakTIh+2w5epYe7q
         uv0QaSMwUJmMNxK2jy9+qVGkUHqsJ/XnhcAAXJqK2lUDwp5+0v9DTNIxfyTg8ZyKnW3t
         rbafOrEBweMn6l+mYd5g7sVA2ATiLtXTmeqYuyESIDEBiv1I0kdmm9nBvDNkgcMawzQd
         S9TIXmBww4N4M0c5DlBvkhwp5Tk7vusyEJWdjFxdVUpFgJZXOHZnZWU83p0lO0tNGdO5
         gGTe+u+9JXzd/RCy7aBQ6yz6TDMrSTelyUPpDGLG+TIipUCKl45E/PFuVQwN2wiqSu1p
         sYAQ==
X-Gm-Message-State: ACgBeo1i785dcQpRTyAGUGCPsizyHSo3A7YRcPC05lkqU31z9MmxbiGn
        iosm7kJv1Kh+FIiEAtR0mmSswsOoAorzzA==
X-Google-Smtp-Source: AA6agR4JoS/Ww+DYDejYnKITOHhTiV3e5/vNAEm4htMRPYCqMN5JVlsOOmMgK0D4fuFEunITSFOWmg==
X-Received: by 2002:a05:622a:198c:b0:342:fd20:239c with SMTP id u12-20020a05622a198c00b00342fd20239cmr2797362qtc.358.1659974040491;
        Mon, 08 Aug 2022 08:54:00 -0700 (PDT)
Received: from localhost (fwdproxy-ash-018.fbsv.net. [2a03:2880:20ff:12::face:b00c])
        by smtp.gmail.com with ESMTPSA id j11-20020ac874cb000000b00342fbe7f3a2sm1700557qtr.70.2022.08.08.08.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 08:54:00 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, tj@kernel.org, joannelkoong@gmail.com,
        linux-kernel@vger.kernel.org, Kernel-team@fb.com
Subject: [PATCH 2/5] bpf: Define new BPF_MAP_TYPE_USER_RINGBUF map type
Date:   Mon,  8 Aug 2022 08:53:38 -0700
Message-Id: <20220808155341.2479054-2-void@manifault.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220808155341.2479054-1-void@manifault.com>
References: <20220808155341.2479054-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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
index 7bf9ba1329be..a341f877b230 100644
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
index ded4faeca192..29e2de42df15 100644
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
index 938ba1536249..4a9562c62af0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6196,6 +6196,8 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
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
index 59a217ca2dfd..ce0ce713faf9 100644
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
index 77e3797cf75a..9c1f2d09f44e 100644
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
2.30.2

