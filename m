Return-Path: <bpf+bounces-5951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 962E6763734
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 15:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5308B281E92
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 13:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B380C151;
	Wed, 26 Jul 2023 13:10:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0505ABA43
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 13:10:57 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C101FC4
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 06:10:56 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fc04692e20so66863885e9.0
        for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 06:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wowsignal-io.20221208.gappssmtp.com; s=20221208; t=1690377054; x=1690981854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bATIaA6LQXRSZJACQ6TfpjUUXUJadMivsNlfpPDYAoY=;
        b=nSWbZevUMUYV6zgWbsW1IByr4aLDiUu+v2C9iL0m4qjiZKXn9qpb5jCMykSISS97ep
         1fXc8vJPyIoSFxoGFrlRV3oG8Q2M5cma+P1TQn/3Prv4RxiSPsWBaEKDA1WbZ2uT+aUO
         UAaDt6zhyQbd8AuxfKCECAU/8zhwGQS/NdcfHWc2xkSUc2sSL+GFUgxGLYDRWtSGtIIO
         qOdT25mS5WMwgmrW3NY3FkaNOgmt9bMbtTFHgigIanFoJg4pmU4zbeG5zdFHSeIMJHLn
         pDLvew4GXmWObHrn35QFRCEemzo6e0w5TiQ1SI9Eoc+gN9W4oS+GDMEV2g/JBFn0A+Ne
         AiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690377054; x=1690981854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bATIaA6LQXRSZJACQ6TfpjUUXUJadMivsNlfpPDYAoY=;
        b=ZdRzq35aJGlaZZaNn3yfFCFQVJcmXBdXapRNgCVeafcfdIyZDN7/ciSbJav9lYWDxZ
         8ZkUPFNtsFi9RqMHdmqMJlleGbpYX93q69KCrMXBVAiGYrtORW2S0eKH29F18VuWu3ex
         L/9E8oXiX2AGgt/lSGBp7ZtpMorKkNxjehY0zgfeAYAKHCt0ZrKZ5u6vf27fss9/8MlZ
         zjhv6qbRjSz+i6zHm+eXywt2VeDMRFb4XNHjTPeCSiKmOvS9w0PasP9R4O+cA4076bhL
         2Fq4zdQoTQV6WViNRD4Qdd64L4FgOHpCD0agWqCsMhUfMrVbXWR2wRISESP/kReoPnKy
         hmlQ==
X-Gm-Message-State: ABy/qLZZorR1kiQx3fglPpVySDpFq/A3+l70Q4T7CZP2nFRBSufHvCce
	lUvUZTFNUH/kSnH13Y8jRw05DUb0SAVYlKxGQyl4r15/
X-Google-Smtp-Source: APBJJlEvByG95YVt5n5013sBm/Gdu9d6b97o2ESe3K8JUQsn9Xx3YlYdAF+DPqKaaBf+0F+DZe/B0g==
X-Received: by 2002:a5d:4f10:0:b0:314:521:ce0a with SMTP id c16-20020a5d4f10000000b003140521ce0amr1485864wru.40.1690377054117;
        Wed, 26 Jul 2023 06:10:54 -0700 (PDT)
Received: from localhost (212-51-140-210.fiber7.init7.net. [212.51.140.210])
        by smtp.gmail.com with ESMTPSA id r5-20020a5d52c5000000b003143bb5ecd5sm19838856wrv.69.2023.07.26.06.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 06:10:53 -0700 (PDT)
From: Adam Sindelar <adam@wowsignal.io>
To: bpf@vger.kernel.org
Cc: Adam Sindelar <ats@fb.com>,
	David Vernet <void@manifault.com>,
	Brendan Jackman <jackmanb@google.com>,
	KP Singh <kpsingh@chromium.org>,
	linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v2] libbpf: Expose API to consume one ring at a time
Date: Wed, 26 Jul 2023 15:09:46 +0200
Message-Id: <20230726130944.6873-1-adam@wowsignal.io>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We already provide ring_buffer__epoll_fd to enable use of external
polling systems. However, the only API available to consume the ring
buffer is ring_buffer__consume, which always checks all rings. When
polling for many events, this can be wasteful.

Signed-off-by: Adam Sindelar <adam@wowsignal.io>
---
v0->v1: Added entry to libbpf.map

 tools/lib/bpf/libbpf.h   |  1 +
 tools/lib/bpf/libbpf.map |  1 +
 tools/lib/bpf/ringbuf.c  | 15 +++++++++++++++
 3 files changed, 17 insertions(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 55b97b2087540..20ccc65eb3f9d 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1195,6 +1195,7 @@ LIBBPF_API int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 				ring_buffer_sample_fn sample_cb, void *ctx);
 LIBBPF_API int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms);
 LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
+LIBBPF_API int ring_buffer__consume_ring(struct ring_buffer *rb, uint32_t ring_id);
 LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
 
 struct user_ring_buffer_opts {
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 9c7538dd5835e..42dc418b4672f 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -398,4 +398,5 @@ LIBBPF_1.3.0 {
 		bpf_prog_detach_opts;
 		bpf_program__attach_netfilter;
 		bpf_program__attach_tcx;
+		ring_buffer__consume_ring;
 } LIBBPF_1.2.0;
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 02199364db136..8d087bfc7d005 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -290,6 +290,21 @@ int ring_buffer__consume(struct ring_buffer *rb)
 	return res;
 }
 
+/* Consume available data from a single RINGBUF map identified by its ID.
+ * The ring ID is returned in epoll_data by epoll_wait when called with
+ * ring_buffer__epoll_fd.
+ */
+int ring_buffer__consume_ring(struct ring_buffer *rb, uint32_t ring_id)
+{
+	struct ring *ring;
+
+	if (ring_id >= rb->ring_cnt)
+		return libbpf_err(-EINVAL);
+
+	ring = &rb->rings[ring_id];
+	return ringbuf_process_ring(ring);
+}
+
 /* Poll for available data and consume records, if any are available.
  * Returns number of records consumed (or INT_MAX, whichever is less), or
  * negative number, if any of the registered callbacks returned error.
-- 
2.39.2


