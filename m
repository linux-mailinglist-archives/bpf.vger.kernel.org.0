Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79B356B27F
	for <lists+bpf@lfdr.de>; Fri,  8 Jul 2022 08:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237018AbiGHGEf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 02:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236692AbiGHGEe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 02:04:34 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DB710E9
        for <bpf@vger.kernel.org>; Thu,  7 Jul 2022 23:04:33 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q9so29095047wrd.8
        for <bpf@vger.kernel.org>; Thu, 07 Jul 2022 23:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6ePEqoX84WxmN+6odQ3h95S+HJI+UjjzAqfJW+tXuNc=;
        b=D1q5wj8a0KcBHF+xALUcOw+J0LetPLzB/y9v4LE7y/O1uCB38XWRZweFD+GH034IM1
         q2eZoQVAbxL0LRwzRaosHQdw6GiQEg8TCStVMTsvqciW7fJjebN4Szjh+ky0hr1WQDFp
         gGEvis5tX3S0TYlx49RWqgVhqquIBIC8lSUNiRMNfNFhoKUplve785u2cmDVFLio2i6H
         X0SKKVX5ajSweWBhPZdIQF/0qMkfb67HTJWHjUoTnH2KI4tS7N7lpJyc75ms7qLV8k55
         fQT467dWwSLMaRcDy/hFanSF2pJG4re5OMuMKOZq+KDlBZoVZFeMZWjWfhCG7plZ5gxP
         clIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ePEqoX84WxmN+6odQ3h95S+HJI+UjjzAqfJW+tXuNc=;
        b=wVAAl7bdPeYtbM8jOCCn9oPjfTNvlz5OdSGdGy9mRTmibkMikapWppw5IY6dWVROtW
         m6FYPclJNx87jVP9Jlxdql6md+DhqSuXQfsTS4lBlC4Zb5VDAVM+a7T4Z20pDlGArBbH
         /sRLkrxPIsZfI5WFL04pmGR1wg9hBnSkapFoHsuAnz8KIqP88q+iEI+fH1N+eCOP5B3v
         dnnOisYMxK1xhmM31zZS9RB+wHjoUX7MVzxYDrQa8y/Ebs1rJcYKI1fVKtrWLX+P9nU1
         634xLlxdWIaV9AOWaNCYG4UhJ3z3XWcS2jNjzdB5edBXL5UR9nXtZLkp/t7b7yo/yq9D
         pqcA==
X-Gm-Message-State: AJIora9wY5o7+aO7l1z3icfC4EorQroRVjN9DcrkPJBE+Gh2cf1s/H3w
        LaUgV0l9jttmXUhKLHoGfrBKKvh8V6E=
X-Google-Smtp-Source: AGRyM1vQbvid04WDibwNE8Fk5Lu0Q/c3Ui70bRrtuybzqruwrFThMs2DYey6emFxpjFJ2GY0LWMA8Q==
X-Received: by 2002:a05:6000:1f89:b0:21d:7dea:bd0 with SMTP id bw9-20020a0560001f8900b0021d7dea0bd0mr1527172wrb.168.1657260271453;
        Thu, 07 Jul 2022 23:04:31 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:6fc2:4af0:cc00:f99d:5d19:6e17:dc3a])
        by smtp.gmail.com with ESMTPSA id r41-20020a05600c322900b003a032c88877sm1004858wmp.15.2022.07.07.23.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 23:04:31 -0700 (PDT)
From:   Jon Doron <arilou@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net
Cc:     Jon Doron <jond@wiz.io>
Subject: [PATCH bpf-next v2 1/1] libbpf: perfbuf: allow raw access to buffers
Date:   Fri,  8 Jul 2022 09:04:16 +0300
Message-Id: <20220708060416.1788789-2-arilou@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220708060416.1788789-1-arilou@gmail.com>
References: <20220708060416.1788789-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Jon Doron <jond@wiz.io>

Add support for writing a custom event reader, by exposing the ring
buffer state, and allowing to set it's tail.

Few simple examples where this type of needed:
1. perf_event_read_simple is allocating using malloc, perhaps you want
   to handle the wrap-around in some other way.
2. Since perf buf is per-cpu then the order of the events is not
   guarnteed, for example:
   Given 3 events where each event has a timestamp t0 < t1 < t2,
   and the events are spread on more than 1 CPU, then we can end
   up with the following state in the ring buf:
   CPU[0] => [t0, t2]
   CPU[1] => [t1]
   When you consume the events from CPU[0], you could know there is
   a t1 missing, (assuming there are no drops, and your event data
   contains a sequential index).
   So now one can simply do the following, for CPU[0], you can store
   the address of t0 and t2 in an array (without moving the tail, so
   there data is not perished) then move on the CPU[1] and set the
   address of t1 in the same array.
   So you end up with something like:
   void **arr[] = [&t0, &t1, &t2], now you can consume it orderely
   and move the tails as you process in order.
3. Assuming there are multiple CPUs and we want to start draining the
   messages from them, then we can "pick" with which one to start with
   according to the remaining free space in the ring buffer.

Signed-off-by: Jon Doron <jond@wiz.io>
---
 tools/lib/bpf/libbpf.c   | 40 ++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   | 25 +++++++++++++++++++++++++
 tools/lib/bpf/libbpf.map |  2 ++
 3 files changed, 67 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e89cc9c885b3..37299aa05185 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -12433,6 +12433,46 @@ static int perf_buffer__process_records(struct perf_buffer *pb,
 	return 0;
 }
 
+int perf_buffer__raw_ring_buf(const struct perf_buffer *pb, size_t buf_idx,
+			      void **base, size_t *buf_size, __u64 *head,
+			      __u64 *tail)
+{
+	struct perf_cpu_buf *cpu_buf;
+	struct perf_event_mmap_page *header;
+
+	if (buf_idx >= pb->cpu_cnt)
+		return libbpf_err(-EINVAL);
+
+	cpu_buf = pb->cpu_bufs[buf_idx];
+	if (!cpu_buf)
+		return libbpf_err(-ENOENT);
+
+	header = cpu_buf->base;
+	*head = ring_buffer_read_head(header);
+	*tail = header->data_tail;
+	*base = ((__u8 *)header) + pb->page_size;
+	*buf_size = pb->mmap_size;
+	return 0;
+}
+
+int perf_buffer__set_ring_buf_tail(const struct perf_buffer *pb, size_t buf_idx,
+				   __u64 tail)
+{
+	struct perf_cpu_buf *cpu_buf;
+	struct perf_event_mmap_page *header;
+
+	if (buf_idx >= pb->cpu_cnt)
+		return libbpf_err(-EINVAL);
+
+	cpu_buf = pb->cpu_bufs[buf_idx];
+	if (!cpu_buf)
+		return libbpf_err(-ENOENT);
+
+	header = cpu_buf->base;
+	ring_buffer_write_tail(header, tail);
+	return 0;
+}
+
 int perf_buffer__epoll_fd(const struct perf_buffer *pb)
 {
 	return pb->epoll_fd;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 9e9a3fd3edd8..035a0ce42139 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1381,6 +1381,31 @@ LIBBPF_API int perf_buffer__consume(struct perf_buffer *pb);
 LIBBPF_API int perf_buffer__consume_buffer(struct perf_buffer *pb, size_t buf_idx);
 LIBBPF_API size_t perf_buffer__buffer_cnt(const struct perf_buffer *pb);
 LIBBPF_API int perf_buffer__buffer_fd(const struct perf_buffer *pb, size_t buf_idx);
+/** @brief **perf_buffer__raw_ring_buf()** gets the ring buffer information for
+ * a given CPU perf buffer.
+ * This API and **perf_buffer__set_ring_buf_tail()** allow low level access
+ * to the ring buffer in order to implement a custom ring buffer drain
+ * mechanisim.
+ *
+ * @param pb the perf_buffer instance
+ * @param buf_idx the index of the perf buffer
+ * @param base will get the base of the ring buffer mmap
+ * @param buf_size will get size of the ring buffer mmap
+ * @param head gets the ring buffer head pointer
+ * @param tail gets the ring buffer tail pointer
+ * @return 0, for success
+ */
+LIBBPF_API int perf_buffer__raw_ring_buf(const struct perf_buffer *pb,
+					 size_t buf_idx, void **base,
+					 size_t *buf_size, __u64 *head,
+					 __u64 *tail);
+/** @brief **perf_buffer__set_ring_buf_tail()** sets the ring buffer tail
+ * @param pb the perf_buffer instance
+ * @param buf_idx the index of the perf buffer
+ * @param tail sets the value up-until where messages were consumed.
+ */
+LIBBPF_API int perf_buffer__set_ring_buf_tail(const struct perf_buffer *pb,
+					      size_t buf_idx, __u64 tail);
 
 typedef enum bpf_perf_event_ret
 	(*bpf_perf_event_print_t)(struct perf_event_header *hdr,
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 52973cffc20c..22fbc97839dd 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -458,6 +458,8 @@ LIBBPF_0.8.0 {
 		bpf_program__set_insns;
 		libbpf_register_prog_handler;
 		libbpf_unregister_prog_handler;
+		perf_buffer__raw_ring_buf;
+		perf_buffer__set_ring_buf_tail;
 } LIBBPF_0.7.0;
 
 LIBBPF_1.0.0 {
-- 
2.36.1

