Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B5658CBA1
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 17:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243860AbiHHPyV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 11:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243842AbiHHPyJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 11:54:09 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC291573F;
        Mon,  8 Aug 2022 08:54:07 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id cr9so3516271qtb.13;
        Mon, 08 Aug 2022 08:54:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=19HrfcO3m7LOXb54hoGBrvcioc04OeO+gZ6JJNsP4ac=;
        b=g0ZRZtQkC3jq5U1pnNYbNNDx0dGftrSqZ58/Y61hQoSMlwlu6BWEYpzDWL2hP3VP+X
         wjsl3+ztKA488UBfmfGQVHgGc1vYWK2hVQIzHFGoSdpXfNvShVcHDZcE4yqvZwPyTilo
         TNUx4z8hK2Tzww3bwSCePmcTuCou9KpPfBG02b0CkRs5JvfXtr5sHFwZ++5nijtGgX79
         8Pnl7jwwBRzX8EffiwQciRT7lx6QG1SD0l9EWGzsFJUsv0tMKITOynMMz92A4BT6XjW8
         1tbDOf3Fbza0wZFaqMn1q/LB15rP7LpFkH3/6Yzi6hV70EPyQqe6Q55ypL+VRPH+SPz+
         caCQ==
X-Gm-Message-State: ACgBeo0Aoh9MIr0+tnY9wq5n59Nmi8R4v8InVSrZLfynJC3bGxBC/1/2
        3POTOSZPBoS6Xu86dXBvoartW9X4DSXGaw==
X-Google-Smtp-Source: AA6agR6f3DhIOSJrauj9QlR/TyosCDfd+fVqfHhQpC4CSdMFwyAo4JgzVHRMOff1lwoDYTUBJw9KSA==
X-Received: by 2002:a05:622a:48b:b0:31f:2416:2f3f with SMTP id p11-20020a05622a048b00b0031f24162f3fmr16073046qtx.376.1659974046252;
        Mon, 08 Aug 2022 08:54:06 -0700 (PDT)
Received: from localhost (fwdproxy-ash-004.fbsv.net. [2a03:2880:20ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id ff6-20020a05622a4d8600b0033fc75c3469sm4057920qtb.27.2022.08.08.08.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 08:54:05 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, tj@kernel.org, joannelkoong@gmail.com,
        linux-kernel@vger.kernel.org, Kernel-team@fb.com
Subject: [PATCH 4/5] bpf: Add libbpf logic for user-space ring buffer
Date:   Mon,  8 Aug 2022 08:53:40 -0700
Message-Id: <20220808155341.2479054-4-void@manifault.com>
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

Now that all of the logic is in place in the kernel to support user-space
produced ringbuffers, we can add the user-space logic to libbpf.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/ringbuf.c          |   7 +-
 tools/lib/bpf/libbpf.c        |  10 +-
 tools/lib/bpf/libbpf.h        |  19 +++
 tools/lib/bpf/libbpf.map      |   6 +
 tools/lib/bpf/libbpf_probes.c |   1 +
 tools/lib/bpf/ringbuf.c       | 216 ++++++++++++++++++++++++++++++++++
 6 files changed, 256 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index fc589fc8eb7c..a10558e79ec8 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -639,7 +639,9 @@ static int __bpf_user_ringbuf_poll(struct bpf_ringbuf *rb, void **sample,
 	if (!atomic_try_cmpxchg(&rb->busy, &busy, 1))
 		return -EBUSY;
 
-	/* Synchronizes with smp_store_release() in user-space. */
+	/* Synchronizes with smp_store_release() in __ring_buffer_user__commit()
+	 * in user-space.
+	 */
 	prod_pos = smp_load_acquire(&rb->producer_pos);
 	/* Synchronizes with smp_store_release() in
 	 * __bpf_user_ringbuf_sample_release().
@@ -695,6 +697,9 @@ __bpf_user_ringbuf_sample_release(struct bpf_ringbuf *rb, size_t size,
 	/* To release the ringbuffer, just increment the producer position to
 	 * signal that a new sample can be consumed. The busy bit is cleared by
 	 * userspace when posting a new sample to the ringbuffer.
+	 *
+	 * Synchronizes with smp_load_acquire() in ring_buffer_user__reserve()
+	 * in user-space.
 	 */
 	smp_store_release(&rb->consumer_pos, rb->consumer_pos + size +
 			  BPF_RINGBUF_HDR_SZ);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 9c1f2d09f44e..f7fe09dce643 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2367,6 +2367,12 @@ static size_t adjust_ringbuf_sz(size_t sz)
 	return sz;
 }
 
+static bool map_is_ringbuf(const struct bpf_map *map)
+{
+	return map->def.type == BPF_MAP_TYPE_RINGBUF ||
+	       map->def.type == BPF_MAP_TYPE_USER_RINGBUF;
+}
+
 static void fill_map_from_def(struct bpf_map *map, const struct btf_map_def *def)
 {
 	map->def.type = def->map_type;
@@ -2381,7 +2387,7 @@ static void fill_map_from_def(struct bpf_map *map, const struct btf_map_def *def
 	map->btf_value_type_id = def->value_type_id;
 
 	/* auto-adjust BPF ringbuf map max_entries to be a multiple of page size */
-	if (map->def.type == BPF_MAP_TYPE_RINGBUF)
+	if (map_is_ringbuf(map))
 		map->def.max_entries = adjust_ringbuf_sz(map->def.max_entries);
 
 	if (def->parts & MAP_DEF_MAP_TYPE)
@@ -4363,7 +4369,7 @@ int bpf_map__set_max_entries(struct bpf_map *map, __u32 max_entries)
 	map->def.max_entries = max_entries;
 
 	/* auto-adjust BPF ringbuf map max_entries to be a multiple of page size */
-	if (map->def.type == BPF_MAP_TYPE_RINGBUF)
+	if (map_is_ringbuf(map))
 		map->def.max_entries = adjust_ringbuf_sz(map->def.max_entries);
 
 	return 0;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 61493c4cddac..6d1d0539b08d 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1009,6 +1009,7 @@ LIBBPF_API int bpf_tc_query(const struct bpf_tc_hook *hook,
 
 /* Ring buffer APIs */
 struct ring_buffer;
+struct ring_buffer_user;
 
 typedef int (*ring_buffer_sample_fn)(void *ctx, void *data, size_t size);
 
@@ -1028,6 +1029,24 @@ LIBBPF_API int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms);
 LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
 LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
 
+struct ring_buffer_user_opts {
+	size_t sz; /* size of this struct, for forward/backward compatibility */
+};
+
+#define ring_buffer_user_opts__last_field sz
+
+LIBBPF_API struct ring_buffer_user *
+ring_buffer_user__new(int map_fd, const struct ring_buffer_user_opts *opts);
+LIBBPF_API void *ring_buffer_user__reserve(struct ring_buffer_user *rb,
+					   uint32_t size);
+LIBBPF_API void *ring_buffer_user__poll(struct ring_buffer_user *rb,
+					uint32_t size, int timeout_ms);
+LIBBPF_API void ring_buffer_user__submit(struct ring_buffer_user *rb,
+					 void *sample);
+LIBBPF_API void ring_buffer_user__discard(struct ring_buffer_user *rb,
+					  void *sample);
+LIBBPF_API void ring_buffer_user__free(struct ring_buffer_user *rb);
+
 /* Perf buffer APIs */
 struct perf_buffer;
 
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 119e6e1ea7f1..8db11040df1b 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -365,4 +365,10 @@ LIBBPF_1.0.0 {
 		libbpf_bpf_map_type_str;
 		libbpf_bpf_prog_type_str;
 		perf_buffer__buffer;
+		ring_buffer_user__discard;
+		ring_buffer_user__free;
+		ring_buffer_user__new;
+		ring_buffer_user__poll;
+		ring_buffer_user__reserve;
+		ring_buffer_user__submit;
 };
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 6d495656f554..f3a8e8e74eb8 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -231,6 +231,7 @@ static int probe_map_create(enum bpf_map_type map_type)
 			return btf_fd;
 		break;
 	case BPF_MAP_TYPE_RINGBUF:
+	case BPF_MAP_TYPE_USER_RINGBUF:
 		key_size = 0;
 		value_size = 0;
 		max_entries = 4096;
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 8bc117bcc7bc..86e3c11d8486 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -39,6 +39,17 @@ struct ring_buffer {
 	int ring_cnt;
 };
 
+struct ring_buffer_user {
+	struct epoll_event event;
+	unsigned long *consumer_pos;
+	unsigned long *producer_pos;
+	void *data;
+	unsigned long mask;
+	size_t page_size;
+	int map_fd;
+	int epoll_fd;
+};
+
 static void ringbuf_unmap_ring(struct ring_buffer *rb, struct ring *r)
 {
 	if (r->consumer_pos) {
@@ -300,3 +311,208 @@ int ring_buffer__epoll_fd(const struct ring_buffer *rb)
 {
 	return rb->epoll_fd;
 }
+
+static void __user_ringbuf_unmap_ring(struct ring_buffer_user *rb)
+{
+	if (rb->consumer_pos) {
+		munmap(rb->consumer_pos, rb->page_size);
+		rb->consumer_pos = NULL;
+	}
+	if (rb->producer_pos) {
+		munmap(rb->producer_pos, rb->page_size + 2 * (rb->mask + 1));
+		rb->producer_pos = NULL;
+	}
+}
+
+void ring_buffer_user__free(struct ring_buffer_user *rb)
+{
+	if (!rb)
+		return;
+
+	__user_ringbuf_unmap_ring(rb);
+
+	if (rb->epoll_fd >= 0)
+		close(rb->epoll_fd);
+
+	free(rb);
+}
+
+static int __ring_buffer_user_map(struct ring_buffer_user *rb, int map_fd)
+{
+
+	struct bpf_map_info info;
+	__u32 len = sizeof(info);
+	void *tmp;
+	struct epoll_event *rb_epoll;
+	int err;
+
+	memset(&info, 0, sizeof(info));
+
+	err = bpf_obj_get_info_by_fd(map_fd, &info, &len);
+	if (err) {
+		err = -errno;
+		pr_warn("user ringbuf: failed to get map info for fd=%d: %d\n",
+			map_fd, err);
+		return libbpf_err(err);
+	}
+
+	if (info.type != BPF_MAP_TYPE_USER_RINGBUF) {
+		pr_warn("user ringbuf: map fd=%d is not BPF_MAP_TYPE_USER_RINGBUF\n",
+			map_fd);
+		return libbpf_err(-EINVAL);
+	}
+
+	rb->map_fd = map_fd;
+	rb->mask = info.max_entries - 1;
+
+	/* Map read-only consumer page */
+	tmp = mmap(NULL, rb->page_size, PROT_READ, MAP_SHARED, map_fd, 0);
+	if (tmp == MAP_FAILED) {
+		err = -errno;
+		pr_warn("user ringbuf: failed to mmap consumer page for map fd=%d: %d\n",
+			map_fd, err);
+		return libbpf_err(err);
+	}
+	rb->consumer_pos = tmp;
+
+	/* Map read-write the producer page and data pages. We map the data
+	 * region as twice the total size of the ringbuffer to allow the simple
+	 * reading and writing of samples that wrap around the end of the
+	 * buffer.  See the kernel implementation for details.
+	 */
+	tmp = mmap(NULL, rb->page_size + 2 * info.max_entries,
+		   PROT_READ | PROT_WRITE, MAP_SHARED, map_fd, rb->page_size);
+	if (tmp == MAP_FAILED) {
+		err = -errno;
+		pr_warn("user ringbuf: failed to mmap data pages for map fd=%d: %d\n",
+			map_fd, err);
+		return libbpf_err(err);
+	}
+
+	rb->producer_pos = tmp;
+	rb->data = tmp + rb->page_size;
+
+	rb_epoll = &rb->event;
+	rb_epoll->events = EPOLLOUT;
+	if (epoll_ctl(rb->epoll_fd, EPOLL_CTL_ADD, map_fd, rb_epoll) < 0) {
+		err = -errno;
+		pr_warn("user ringbuf: failed to epoll add map fd=%d: %d\n",
+			map_fd, err);
+		return libbpf_err(err);
+	}
+
+	return 0;
+}
+
+struct ring_buffer_user *
+ring_buffer_user__new(int map_fd, const struct ring_buffer_user_opts *opts)
+{
+	struct ring_buffer_user *rb;
+	int err;
+
+	if (!OPTS_VALID(opts, ring_buffer_opts))
+		return errno = EINVAL, NULL;
+
+	rb = calloc(1, sizeof(*rb));
+	if (!rb)
+		return errno = ENOMEM, NULL;
+
+	rb->page_size = getpagesize();
+
+	rb->epoll_fd = epoll_create1(EPOLL_CLOEXEC);
+	if (rb->epoll_fd < 0) {
+		err = -errno;
+		pr_warn("user ringbuf: failed to create epoll instance: %d\n",
+			err);
+		goto err_out;
+	}
+
+	err = __ring_buffer_user_map(rb, map_fd);
+	if (err)
+		goto err_out;
+
+	return rb;
+
+err_out:
+	ring_buffer_user__free(rb);
+	return errno = -err, NULL;
+}
+
+static void __ring_buffer_user__commit(struct ring_buffer_user *rb)
+{
+	uint32_t *hdr;
+	uint32_t total_len;
+	unsigned long prod_pos;
+
+	prod_pos = *rb->producer_pos;
+	hdr = rb->data + (prod_pos & rb->mask);
+
+	total_len = *hdr + BPF_RINGBUF_HDR_SZ;
+
+	/* Synchronizes with smp_load_acquire() in __bpf_user_ringbuf_poll() in
+	 * the kernel.
+	 */
+	smp_store_release(rb->producer_pos, prod_pos + total_len);
+}
+
+/* Discard a previously reserved sample into the ring buffer. Because the user
+ * ringbuffer is assumed to be single producer, this can simply be a no-op, and
+ * the producer pointer is left in the same place as when it was reserved.
+ */
+void ring_buffer_user__discard(struct ring_buffer_user *rb, void *sample)
+{}
+
+/* Submit a previously reserved sample into the ring buffer.
+ */
+void ring_buffer_user__submit(struct ring_buffer_user *rb, void *sample)
+{
+	__ring_buffer_user__commit(rb);
+}
+
+/* Reserve a pointer to a sample in the user ring buffer. This function is *not*
+ * thread safe, and the ring-buffer supports only a single producer.
+ */
+void *ring_buffer_user__reserve(struct ring_buffer_user *rb, uint32_t size)
+{
+	uint32_t *hdr;
+	/* 64-bit to avoid overflow in case of extreme application behavior */
+	size_t avail_size, total_size, max_size;
+	unsigned long cons_pos, prod_pos;
+
+	/* Synchronizes with smp_store_release() in __bpf_user_ringbuf_poll() in
+	 * the kernel.
+	 */
+	cons_pos = smp_load_acquire(rb->consumer_pos);
+	/* Synchronizes with smp_store_release() in __ring_buffer_user__commit()
+	 */
+	prod_pos = smp_load_acquire(rb->producer_pos);
+
+	max_size = rb->mask + 1;
+	avail_size = max_size - (prod_pos - cons_pos);
+	total_size = size + BPF_RINGBUF_HDR_SZ;
+
+	if (total_size > max_size || avail_size < total_size)
+		return NULL;
+
+	hdr = rb->data + (prod_pos & rb->mask);
+	*hdr = size;
+
+	/* Producer pos is updated when a sample is submitted. */
+
+	return (void *)rb->data + ((prod_pos + BPF_RINGBUF_HDR_SZ) & rb->mask);
+}
+
+/* Poll for available space in the ringbuffer, and reserve a record when it
+ * becomes available.
+ */
+void *ring_buffer_user__poll(struct ring_buffer_user *rb, uint32_t size,
+			     int timeout_ms)
+{
+	int cnt;
+
+	cnt = epoll_wait(rb->epoll_fd, &rb->event, 1, timeout_ms);
+	if (cnt < 0)
+		return NULL;
+
+	return ring_buffer_user__reserve(rb, size);
+}
-- 
2.30.2

