Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871895A8384
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 18:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbiHaQvb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 12:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbiHaQv0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 12:51:26 -0400
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5BBD9D6D;
        Wed, 31 Aug 2022 09:51:23 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id w4so11273075qvs.4;
        Wed, 31 Aug 2022 09:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=9aAaQaEngCL6BkxyYUN9m2ytswI6zBzU6TE8y9SAPfA=;
        b=d1KMC1l3tTwh2FfDU1/Tlx547PLW70/rSKrj6EiKi1V8YDOlEZWj2rCVqxd2V4PIyP
         45Y2G01E6G4yr8F8VXpyIVs12scXcEpeyf4d8TKBG51fKpTXr7x4yuOulKZT9yWBgr2I
         5dlkPT1Mq163cioDEYLbPC1JSA4CcuiBccwfrZ+cCfXnrYQGttrdDsFZ96CzdvU5n9/+
         +4X7Fy1UTS9VwPNYVKuAVCGmUIS1XKq8boFEHtCPhSYTHJGF34BrFaeq4KQ23rUzlDoa
         EwznQ84BJLLlCLZc90dE+rSp6dK6LPINoSJaeCtXKiDH3Eq6xjrnvqVWoiGt8ycZ/IdB
         wLjg==
X-Gm-Message-State: ACgBeo0ZKMhn0TJL++qgEqj+AcBSUXc7zfOodcnk4jBatiT/GOcYKcTY
        5AWSM7n2RLS7wYijUX2QzzU=
X-Google-Smtp-Source: AA6agR5v6+vBfoB5JUZqxVur25B02uU3UpHTi5k8+pYJD8rifXv02XpXYmpw+luH0/W0geFUOBQ7Gg==
X-Received: by 2002:a05:6214:500f:b0:476:e61a:93a6 with SMTP id jo15-20020a056214500f00b00476e61a93a6mr21159299qvb.25.1661964681939;
        Wed, 31 Aug 2022 09:51:21 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::c6a9])
        by smtp.gmail.com with ESMTPSA id bm2-20020a05620a198200b006b5f06186aesm10515574qkb.65.2022.08.31.09.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 09:51:21 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev
Cc:     song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, void@manifault.com,
        kernel-team@fb.com
Subject: [PATCH v4 2/4] bpf: Add bpf_user_ringbuf_drain() helper
Date:   Wed, 31 Aug 2022 11:51:17 -0500
Message-Id: <20220831165119.2216749-2-void@manifault.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220831165119.2216749-1-void@manifault.com>
References: <20220831165119.2216749-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In a prior change, we added a new BPF_MAP_TYPE_USER_RINGBUF map type which
will allow user-space applications to publish messages to a ring buffer
that is consumed by a BPF program in kernel-space. In order for this
map-type to be useful, it will require a BPF helper function that BPF
programs can invoke to drain samples from the ring buffer, and invoke
callbacks on those samples. This change adds that capability via a new BPF
helper function:

bpf_user_ringbuf_drain(struct bpf_map *map, void *callback_fn, void *ctx,
                       u64 flags)

BPF programs may invoke this function to run callback_fn() on a series of
samples in the ring buffer. callback_fn() has the following signature:

long callback_fn(struct bpf_dynptr *dynptr, void *context);

Samples are provided to the callback in the form of struct bpf_dynptr *'s,
which the program can read using BPF helper functions for querying
struct bpf_dynptr's.

In order to support bpf_ringbuf_drain(), a new PTR_TO_DYNPTR register
type is added to the verifier to reflect a dynptr that was allocated by
a helper function and passed to a BPF program. Unlike PTR_TO_STACK
dynptrs which are allocated on the stack by a BPF program, PTR_TO_DYNPTR
dynptrs need not use reference tracking, as the BPF helper is trusted to
properly free the dynptr before returning. The verifier currently only
supports PTR_TO_DYNPTR registers that are also DYNPTR_TYPE_LOCAL.

Note that while the corresponding user-space libbpf logic will be added in
a subsequent patch, this patch does contain an implementation of the
.map_poll() callback for BPF_MAP_TYPE_USER_RINGBUF maps. This .map_poll()
callback guarantees that an epoll-waiting user-space producer will
receive at least one event notification whenever at least one sample is
drained in an invocation of bpf_user_ringbuf_drain(), provided that the
function is not invoked with the BPF_RB_NO_WAKEUP flag.

Sending an event notification for every sample is not an option, as it
could cause the system to hang due to invoking irq_work_queue() in
too-frequent succession. So as to try and optimize for the common case,
however, bpf_user_ringbuf_drain() will also send an event notification
whenever a sample being drained causes the ring buffer to no longer be
full. This heuristic may not help some user-space producers, as a
producer can publish samples of varying size, and there may not be
enough space in the ring buffer after the first sample is drained which
causes it to no longer be full. In this case, the producer may have to
wait until bpf_ringbuf_drain() returns to receive an event notification.

Signed-off-by: David Vernet <void@manifault.com>
---
 include/linux/bpf.h            |  11 +-
 include/uapi/linux/bpf.h       |  36 ++++++
 kernel/bpf/helpers.c           |   2 +
 kernel/bpf/ringbuf.c           | 201 ++++++++++++++++++++++++++++++++-
 kernel/bpf/verifier.c          |  61 +++++++++-
 tools/include/uapi/linux/bpf.h |  36 ++++++
 6 files changed, 335 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9c1674973e03..e5c8508dca10 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -402,7 +402,7 @@ enum bpf_type_flag {
 	/* DYNPTR points to memory local to the bpf program. */
 	DYNPTR_TYPE_LOCAL	= BIT(8 + BPF_BASE_TYPE_BITS),
 
-	/* DYNPTR points to a ringbuf record. */
+	/* DYNPTR points to a kernel-produced ringbuf record. */
 	DYNPTR_TYPE_RINGBUF	= BIT(9 + BPF_BASE_TYPE_BITS),
 
 	/* Size is known at compile time. */
@@ -607,6 +607,7 @@ enum bpf_reg_type {
 	PTR_TO_MEM,		 /* reg points to valid memory region */
 	PTR_TO_BUF,		 /* reg points to a read/write buffer */
 	PTR_TO_FUNC,		 /* reg points to a bpf program function */
+	PTR_TO_DYNPTR,		 /* reg points to a dynptr */
 	__BPF_REG_TYPE_MAX,
 
 	/* Extended reg_types. */
@@ -1334,6 +1335,11 @@ struct bpf_array {
 #define BPF_MAP_CAN_READ	BIT(0)
 #define BPF_MAP_CAN_WRITE	BIT(1)
 
+/* Maximum number of user-producer ringbuffer samples that can be drained in
+ * a call to bpf_user_ringbuf_drain().
+ */
+#define BPF_MAX_USER_RINGBUF_SAMPLES (128 * 1024)
+
 static inline u32 bpf_map_flags_to_cap(struct bpf_map *map)
 {
 	u32 access_flags = map->map_flags & (BPF_F_RDONLY_PROG | BPF_F_WRONLY_PROG);
@@ -2433,6 +2439,7 @@ extern const struct bpf_func_proto bpf_loop_proto;
 extern const struct bpf_func_proto bpf_copy_from_user_task_proto;
 extern const struct bpf_func_proto bpf_set_retval_proto;
 extern const struct bpf_func_proto bpf_get_retval_proto;
+extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
 
 const struct bpf_func_proto *tracing_prog_func_proto(
   enum bpf_func_id func_id, const struct bpf_prog *prog);
@@ -2577,7 +2584,7 @@ enum bpf_dynptr_type {
 	BPF_DYNPTR_TYPE_INVALID,
 	/* Points to memory that is local to the bpf program */
 	BPF_DYNPTR_TYPE_LOCAL,
-	/* Underlying data is a ringbuf record */
+	/* Underlying data is a kernel-produced ringbuf record */
 	BPF_DYNPTR_TYPE_RINGBUF,
 };
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index b1c36904831a..4ac6ac6af6c5 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5387,6 +5387,41 @@ union bpf_attr {
  *	Return
  *		Current *ktime*.
  *
+ * long bpf_user_ringbuf_drain(struct bpf_map *map, void *callback_fn, void *ctx, u64 flags)
+ *	Description
+ *		Drain samples from the specified user ring buffer, and invoke
+ *		the provided callback for each such sample:
+ *
+ *		long (\*callback_fn)(struct bpf_dynptr \*dynptr, void \*ctx);
+ *
+ *		If **callback_fn** returns 0, the helper will continue to try
+ *		and drain the next sample, up to a maximum of
+ *		BPF_MAX_USER_RINGBUF_SAMPLES samples. If the return value is 1,
+ *		the helper will skip the rest of the samples and return. Other
+ *		return values are not used now, and will be rejected by the
+ *		verifier.
+ *	Return
+ *		The number of drained samples if no error was encountered while
+ *		draining samples. If a user-space producer was epoll-waiting on
+ *		this map, and at least one sample was drained, they will
+ *		receive an event notification notifying them of available space
+ *		in the ring buffer. If the BPF_RB_NO_WAKEUP flag is passed to
+ *		this function, no wakeup notification will be sent. If there
+ *		are no samples in the ring buffer, 0 is returned.
+ *
+ *		On failure, the returned value is one of the following:
+ *
+ *		**-EBUSY** if the ring buffer is contended, and another calling
+ *		context was concurrently draining the ring buffer.
+ *
+ *		**-EINVAL** if user-space is not properly tracking the ring
+ *		buffer due to the producer position not being aligned to 8
+ *		bytes, a sample not being aligned to 8 bytes, or the producer
+ *		position not matching the advertised length of a sample.
+ *
+ *		**-E2BIG** if user-space has tried to publish a sample which is
+ *		larger than the size of the ring buffer, or which cannot fit
+ *		within a struct bpf_dynptr.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5598,6 +5633,7 @@ union bpf_attr {
 	FN(tcp_raw_check_syncookie_ipv4),	\
 	FN(tcp_raw_check_syncookie_ipv6),	\
 	FN(ktime_get_tai_ns),		\
+	FN(user_ringbuf_drain),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index fc08035f14ed..99edbad08752 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1627,6 +1627,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_dynptr_write_proto;
 	case BPF_FUNC_dynptr_data:
 		return &bpf_dynptr_data_proto;
+	case BPF_FUNC_user_ringbuf_drain:
+		return &bpf_user_ringbuf_drain_proto;
 	default:
 		break;
 	}
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 0a8de712ecbe..d1d97744e92d 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -38,6 +38,22 @@ struct bpf_ringbuf {
 	struct page **pages;
 	int nr_pages;
 	spinlock_t spinlock ____cacheline_aligned_in_smp;
+	/* For user-space producer ring buffers, an atomic_t busy bit is used
+	 * to synchronize access to the ring buffers in the kernel, rather than
+	 * the spinlock that is used for kernel-producer ring buffers. This is
+	 * done because the ring buffer must hold a lock across a BPF program's
+	 * callback:
+	 *
+	 *    __bpf_user_ringbuf_peek() // lock acquired
+	 * -> program callback_fn()
+	 * -> __bpf_user_ringbuf_sample_release() // lock released
+	 *
+	 * It is unsafe and incorrect to hold an IRQ spinlock across what could
+	 * be a long execution window, so we instead simply disallow concurrent
+	 * access to the ring buffer by kernel consumers, and return -EBUSY from
+	 * __bpf_user_ringbuf_peek() if the busy bit is held by another task.
+	 */
+	atomic_t busy ____cacheline_aligned_in_smp;
 	/* Consumer and producer counters are put into separate pages to
 	 * allow each position to be mapped with different permissions.
 	 * This prevents a user-space application from modifying the
@@ -58,7 +74,7 @@ struct bpf_ringbuf {
 	 * user-space. User-space producers also use bits of the header to
 	 * communicate to the kernel, but the kernel must carefully check and
 	 * validate each sample to ensure that they're correctly formatted, and
-	 * fully contained within the ringbuffer.
+	 * fully contained within the ring buffer.
 	 */
 	unsigned long consumer_pos __aligned(PAGE_SIZE);
 	unsigned long producer_pos __aligned(PAGE_SIZE);
@@ -153,6 +169,7 @@ static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t data_sz, int numa_node)
 		return NULL;
 
 	spin_lock_init(&rb->spinlock);
+	atomic_set(&rb->busy, 0);
 	init_waitqueue_head(&rb->waitq);
 	init_irq_work(&rb->work, bpf_ringbuf_notify);
 
@@ -288,8 +305,13 @@ static unsigned long ringbuf_avail_data_sz(struct bpf_ringbuf *rb)
 	return prod_pos - cons_pos;
 }
 
-static __poll_t ringbuf_map_poll(struct bpf_map *map, struct file *filp,
-				 struct poll_table_struct *pts)
+static u32 ringbuf_total_data_sz(const struct bpf_ringbuf *rb)
+{
+	return rb->mask + 1;
+}
+
+static __poll_t ringbuf_map_poll_kern(struct bpf_map *map, struct file *filp,
+				      struct poll_table_struct *pts)
 {
 	struct bpf_ringbuf_map *rb_map;
 
@@ -301,13 +323,26 @@ static __poll_t ringbuf_map_poll(struct bpf_map *map, struct file *filp,
 	return 0;
 }
 
+static __poll_t ringbuf_map_poll_user(struct bpf_map *map, struct file *filp,
+				      struct poll_table_struct *pts)
+{
+	struct bpf_ringbuf_map *rb_map;
+
+	rb_map = container_of(map, struct bpf_ringbuf_map, map);
+	poll_wait(filp, &rb_map->rb->waitq, pts);
+
+	if (ringbuf_avail_data_sz(rb_map->rb) < ringbuf_total_data_sz(rb_map->rb))
+		return  EPOLLOUT | EPOLLWRNORM;
+	return 0;
+}
+
 BTF_ID_LIST_SINGLE(ringbuf_map_btf_ids, struct, bpf_ringbuf_map)
 const struct bpf_map_ops ringbuf_map_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
 	.map_alloc = ringbuf_map_alloc,
 	.map_free = ringbuf_map_free,
 	.map_mmap = ringbuf_map_mmap_kern,
-	.map_poll = ringbuf_map_poll,
+	.map_poll = ringbuf_map_poll_kern,
 	.map_lookup_elem = ringbuf_map_lookup_elem,
 	.map_update_elem = ringbuf_map_update_elem,
 	.map_delete_elem = ringbuf_map_delete_elem,
@@ -321,6 +356,7 @@ const struct bpf_map_ops user_ringbuf_map_ops = {
 	.map_alloc = ringbuf_map_alloc,
 	.map_free = ringbuf_map_free,
 	.map_mmap = ringbuf_map_mmap_user,
+	.map_poll = ringbuf_map_poll_user,
 	.map_lookup_elem = ringbuf_map_lookup_elem,
 	.map_update_elem = ringbuf_map_update_elem,
 	.map_delete_elem = ringbuf_map_delete_elem,
@@ -362,7 +398,7 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 		return NULL;
 
 	len = round_up(size + BPF_RINGBUF_HDR_SZ, 8);
-	if (len > rb->mask + 1)
+	if (len > ringbuf_total_data_sz(rb))
 		return NULL;
 
 	cons_pos = smp_load_acquire(&rb->consumer_pos);
@@ -509,7 +545,7 @@ BPF_CALL_2(bpf_ringbuf_query, struct bpf_map *, map, u64, flags)
 	case BPF_RB_AVAIL_DATA:
 		return ringbuf_avail_data_sz(rb);
 	case BPF_RB_RING_SIZE:
-		return rb->mask + 1;
+		return ringbuf_total_data_sz(rb);
 	case BPF_RB_CONS_POS:
 		return smp_load_acquire(&rb->consumer_pos);
 	case BPF_RB_PROD_POS:
@@ -603,3 +639,156 @@ const struct bpf_func_proto bpf_ringbuf_discard_dynptr_proto = {
 	.arg1_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_RINGBUF | OBJ_RELEASE,
 	.arg2_type	= ARG_ANYTHING,
 };
+
+static int __bpf_user_ringbuf_peek(struct bpf_ringbuf *rb, void **sample, u32 *size)
+{
+	int err, busy = 0;
+	u32 hdr_len, sample_len, total_len, flags, *hdr;
+	u64 cons_pos, prod_pos;
+
+	/* If another consumer is already consuming a sample, wait for them to finish. */
+	if (!atomic_try_cmpxchg(&rb->busy, &busy, 1))
+		return -EBUSY;
+
+	/* Synchronizes with smp_store_release() in user-space producer. */
+	prod_pos = smp_load_acquire(&rb->producer_pos);
+	if (prod_pos % 8) {
+		err = -EINVAL;
+		goto err_unlock;
+	}
+
+	/* Synchronizes with smp_store_release() in __bpf_user_ringbuf_sample_release() */
+	cons_pos = smp_load_acquire(&rb->consumer_pos);
+	if (cons_pos >= prod_pos) {
+		err = -ENOSPC;
+		goto err_unlock;
+	}
+
+	hdr = (u32 *)((uintptr_t)rb->data + (uintptr_t)(cons_pos & rb->mask));
+	/* Synchronizes with smp_store_release() in user-space producer. */
+	hdr_len = smp_load_acquire(hdr);
+	flags = hdr_len & (BPF_RINGBUF_BUSY_BIT | BPF_RINGBUF_DISCARD_BIT);
+	sample_len = hdr_len & ~flags;
+	total_len = round_up(sample_len + BPF_RINGBUF_HDR_SZ, 8);
+
+	/* The sample must fit within the region advertised by the producer position. */
+	if (total_len > prod_pos - cons_pos) {
+		err = -EINVAL;
+		goto err_unlock;
+	}
+
+	/* The sample must fit within the data region of the ring buffer. */
+	if (total_len > ringbuf_total_data_sz(rb)) {
+		err = -E2BIG;
+		goto err_unlock;
+	}
+
+	/* The sample must fit into a struct bpf_dynptr. */
+	err = bpf_dynptr_check_size(sample_len);
+	if (err) {
+		err = -E2BIG;
+		goto err_unlock;
+	}
+
+	if (flags & BPF_RINGBUF_DISCARD_BIT) {
+		/* If the discard bit is set, the sample should be skipped.
+		 *
+		 * Update the consumer pos, and return -EAGAIN so the caller
+		 * knows to skip this sample and try to read the next one.
+		 */
+		smp_store_release(&rb->consumer_pos, cons_pos + total_len);
+		err = -EAGAIN;
+		goto err_unlock;
+	}
+
+	if (flags & BPF_RINGBUF_BUSY_BIT) {
+		err = -ENOSPC;
+		goto err_unlock;
+	}
+
+	*sample = (void *)((uintptr_t)rb->data +
+			   (uintptr_t)((cons_pos + BPF_RINGBUF_HDR_SZ) & rb->mask));
+	*size = sample_len;
+	return 0;
+
+err_unlock:
+	atomic_set(&rb->busy, 0);
+	return err;
+}
+
+static void __bpf_user_ringbuf_sample_release(struct bpf_ringbuf *rb, size_t size, u64 flags)
+{
+	u64 consumer_pos;
+	u32 rounded_size = round_up(size + BPF_RINGBUF_HDR_SZ, 8);
+
+	/* Using smp_load_acquire() is unnecessary here, as the busy-bit
+	 * prevents another task from writing to consumer_pos after it was read
+	 * by this task with smp_load_acquire() in __bpf_user_ringbuf_peek().
+	 */
+	consumer_pos = rb->consumer_pos;
+	 /* Synchronizes with smp_load_acquire() in user-space producer. */
+	smp_store_release(&rb->consumer_pos, consumer_pos + rounded_size);
+
+	/* Prevent the clearing of the busy-bit from being reordered before the
+	 * storing of the updated rb->consumer_pos value.
+	 */
+	smp_mb__before_atomic();
+	atomic_set(&rb->busy, 0);
+
+	if (flags & BPF_RB_FORCE_WAKEUP)
+		irq_work_queue(&rb->work);
+}
+
+BPF_CALL_4(bpf_user_ringbuf_drain, struct bpf_map *, map,
+	   void *, callback_fn, void *, callback_ctx, u64, flags)
+{
+	struct bpf_ringbuf *rb;
+	long samples, discarded_samples = 0, ret = 0;
+	bpf_callback_t callback = (bpf_callback_t)callback_fn;
+	u64 wakeup_flags = BPF_RB_NO_WAKEUP | BPF_RB_FORCE_WAKEUP;
+
+	if (unlikely(flags & ~wakeup_flags))
+		return -EINVAL;
+
+	rb = container_of(map, struct bpf_ringbuf_map, map)->rb;
+	for (samples = 0; samples < BPF_MAX_USER_RINGBUF_SAMPLES && ret == 0; samples++) {
+		int err;
+		u32 size;
+		void *sample;
+		struct bpf_dynptr_kern dynptr;
+
+		err = __bpf_user_ringbuf_peek(rb, &sample, &size);
+		if (err) {
+			if (err == -ENOSPC) {
+				break;
+			} else if (err == -EAGAIN) {
+				discarded_samples++;
+				continue;
+			} else {
+				ret = err;
+				goto schedule_work_return;
+			}
+		}
+
+		bpf_dynptr_init(&dynptr, sample, BPF_DYNPTR_TYPE_LOCAL, 0, size);
+		ret = callback((uintptr_t)&dynptr, (uintptr_t)callback_ctx, 0, 0, 0);
+		__bpf_user_ringbuf_sample_release(rb, size, flags);
+	}
+	ret = samples - discarded_samples;
+
+schedule_work_return:
+	if (flags & BPF_RB_FORCE_WAKEUP)
+		irq_work_queue(&rb->work);
+	else if (!(flags & BPF_RB_NO_WAKEUP) && samples > 0)
+		irq_work_queue(&rb->work);
+	return ret;
+}
+
+const struct bpf_func_proto bpf_user_ringbuf_drain_proto = {
+	.func		= bpf_user_ringbuf_drain,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_CONST_MAP_PTR,
+	.arg2_type	= ARG_PTR_TO_FUNC,
+	.arg3_type	= ARG_PTR_TO_STACK_OR_NULL,
+	.arg4_type	= ARG_ANYTHING,
+};
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 37ce3208c626..5ecad2ccb29d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -561,6 +561,7 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
 		[PTR_TO_BUF]		= "buf",
 		[PTR_TO_FUNC]		= "func",
 		[PTR_TO_MAP_KEY]	= "map_key",
+		[PTR_TO_DYNPTR]		= "dynptr_ptr",
 	};
 
 	if (type & PTR_MAYBE_NULL) {
@@ -5666,6 +5667,12 @@ static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK }
 static const struct bpf_reg_types const_str_ptr_types = { .types = { PTR_TO_MAP_VALUE } };
 static const struct bpf_reg_types timer_types = { .types = { PTR_TO_MAP_VALUE } };
 static const struct bpf_reg_types kptr_types = { .types = { PTR_TO_MAP_VALUE } };
+static const struct bpf_reg_types dynptr_types = {
+	.types = {
+		PTR_TO_STACK,
+		PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL,
+	}
+};
 
 static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_MAP_KEY]		= &map_key_value_types,
@@ -5692,7 +5699,7 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_CONST_STR]		= &const_str_ptr_types,
 	[ARG_PTR_TO_TIMER]		= &timer_types,
 	[ARG_PTR_TO_KPTR]		= &kptr_types,
-	[ARG_PTR_TO_DYNPTR]		= &stack_ptr_types,
+	[ARG_PTR_TO_DYNPTR]		= &dynptr_types,
 };
 
 static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
@@ -6035,6 +6042,13 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		err = check_mem_size_reg(env, reg, regno, true, meta);
 		break;
 	case ARG_PTR_TO_DYNPTR:
+		/* We only need to check for initialized / uninitialized helper
+		 * dynptr args if the dynptr is not PTR_TO_DYNPTR, as the
+		 * assumption is that if it is, that a helper function
+		 * initialized the dynptr on behalf of the BPF program.
+		 */
+		if (base_type(reg->type) == PTR_TO_DYNPTR)
+			break;
 		if (arg_type & MEM_UNINIT) {
 			if (!is_dynptr_reg_valid_uninit(env, reg)) {
 				verbose(env, "Dynptr has to be an uninitialized dynptr\n");
@@ -6207,7 +6221,9 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 			goto error;
 		break;
 	case BPF_MAP_TYPE_USER_RINGBUF:
-		goto error;
+		if (func_id != BPF_FUNC_user_ringbuf_drain)
+			goto error;
+		break;
 	case BPF_MAP_TYPE_STACK_TRACE:
 		if (func_id != BPF_FUNC_get_stackid)
 			goto error;
@@ -6327,6 +6343,10 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		if (map->map_type != BPF_MAP_TYPE_RINGBUF)
 			goto error;
 		break;
+	case BPF_FUNC_user_ringbuf_drain:
+		if (map->map_type != BPF_MAP_TYPE_USER_RINGBUF)
+			goto error;
+		break;
 	case BPF_FUNC_get_stackid:
 		if (map->map_type != BPF_MAP_TYPE_STACK_TRACE)
 			goto error;
@@ -6882,6 +6902,29 @@ static int set_find_vma_callback_state(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static int set_user_ringbuf_callback_state(struct bpf_verifier_env *env,
+					   struct bpf_func_state *caller,
+					   struct bpf_func_state *callee,
+					   int insn_idx)
+{
+	/* bpf_user_ringbuf_drain(struct bpf_map *map, void *callback_fn, void
+	 *			  callback_ctx, u64 flags);
+	 * callback_fn(struct bpf_dynptr_t* dynptr, void *callback_ctx);
+	 */
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_0]);
+	callee->regs[BPF_REG_1].type = PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL;
+	__mark_reg_known_zero(&callee->regs[BPF_REG_1]);
+	callee->regs[BPF_REG_2] = caller->regs[BPF_REG_3];
+
+	/* unused */
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_3]);
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
+
+	callee->in_callback_fn = true;
+	return 0;
+}
+
 static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 {
 	struct bpf_verifier_state *state = env->cur_state;
@@ -7343,12 +7386,18 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	case BPF_FUNC_dynptr_data:
 		for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
 			if (arg_type_is_dynptr(fn->arg_type[i])) {
+				struct bpf_reg_state *reg = &regs[BPF_REG_1 + i];
+
 				if (meta.ref_obj_id) {
 					verbose(env, "verifier internal error: meta.ref_obj_id already set\n");
 					return -EFAULT;
 				}
-				/* Find the id of the dynptr we're tracking the reference of */
-				meta.ref_obj_id = stack_slot_get_id(env, &regs[BPF_REG_1 + i]);
+
+				if (base_type(reg->type) != PTR_TO_DYNPTR)
+					/* Find the id of the dynptr we're
+					 * tracking the reference of
+					 */
+					meta.ref_obj_id = stack_slot_get_id(env, reg);
 				break;
 			}
 		}
@@ -7357,6 +7406,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			return -EFAULT;
 		}
 		break;
+	case BPF_FUNC_user_ringbuf_drain:
+		err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
+					set_user_ringbuf_callback_state);
+		break;
 	}
 
 	if (err)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index c1f9c3766956..4c847873e879 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5387,6 +5387,41 @@ union bpf_attr {
  *	Return
  *		Current *ktime*.
  *
+ * long bpf_user_ringbuf_drain(struct bpf_map *map, void *callback_fn, void *ctx, u64 flags)
+ *	Description
+ *		Drain samples from the specified user ring buffer, and invoke
+ *		the provided callback for each such sample:
+ *
+ *		long (\*callback_fn)(struct bpf_dynptr \*dynptr, void \*ctx);
+ *
+ *		If **callback_fn** returns 0, the helper will continue to try
+ *		and drain the next sample, up to a maximum of
+ *		BPF_MAX_USER_RINGBUF_SAMPLES samples. If the return value is 1,
+ *		the helper will skip the rest of the samples and return. Other
+ *		return values are not used now, and will be rejected by the
+ *		verifier.
+ *	Return
+ *		The number of drained samples if no error was encountered while
+ *		draining samples. If a user-space producer was epoll-waiting on
+ *		this map, and at least one sample was drained, they will
+ *		receive an event notification notifying them of available space
+ *		in the ring buffer. If the BPF_RB_NO_WAKEUP flag is passed to
+ *		this function, no wakeup notification will be sent. If there
+ *		are no samples in the ring buffer, 0 is returned.
+ *
+ *		On failure, the returned value is one of the following:
+ *
+ *		**-EBUSY** if the ring buffer is contended, and another calling
+ *		context was concurrently draining the ring buffer.
+ *
+ *		**-EINVAL** if user-space is not properly tracking the ring
+ *		buffer due to the producer position not being aligned to 8
+ *		bytes, a sample not being aligned to 8 bytes, or the producer
+ *		position not matching the advertised length of a sample.
+ *
+ *		**-E2BIG** if user-space has tried to publish a sample which is
+ *		larger than the size of the ring buffer, or which cannot fit
+ *		within a struct bpf_dynptr.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5598,6 +5633,7 @@ union bpf_attr {
 	FN(tcp_raw_check_syncookie_ipv4),	\
 	FN(tcp_raw_check_syncookie_ipv6),	\
 	FN(ktime_get_tai_ns),		\
+	FN(user_ringbuf_drain),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.37.1

