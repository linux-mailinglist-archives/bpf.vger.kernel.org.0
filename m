Return-Path: <bpf+bounces-6063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2272764D9C
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 10:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD6E82822C9
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 08:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782EAC2E7;
	Thu, 27 Jul 2023 08:36:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FC58489
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 08:36:34 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580C212672
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 01:36:13 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fb5bcb9a28so1175713e87.3
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 01:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wowsignal-io.20221208.gappssmtp.com; s=20221208; t=1690446969; x=1691051769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O2wrzhWx+47YfIynN9uLYZgBiAlpxfP+vVN0o8guwaA=;
        b=M7DZmUq1wAJNqP3efqYAQosIIM+CE/R9FA3xiMLuDHqZnmA2kjYxTnLfNbDEQy2qi/
         HrjSU7t//Hh70HE75AyjfO68YYY7/vpWkPCzOn43KKaxB216NXBKzWEk2kN9PDqBR+Iz
         9/qvMefi1GHeGbOIURzf0g5QwK/xkzQHkH4P9KbqEosi8zx6HerWYfZvsQXTrS/aEqx7
         4LU7uV2w1uTR99B6sfv67f2ByGU5ABeNcSJBVk5NRh2bVWUxIO9LicSzQ1EmQqK33qww
         LxQzEw1d0VSLPeGzdDXbfO5rB6CAHftTHgiXHU25aJWZq/EZNpuVtvKG6/bNZs7lkxWq
         J4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690446969; x=1691051769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O2wrzhWx+47YfIynN9uLYZgBiAlpxfP+vVN0o8guwaA=;
        b=DR6k87qTaqhEr7CvAYqOH3oVFRKQVxrajUFnuDd1O8IREwVem3eRKnQtu+kYBuAWOb
         /zj4hA1Po1PlnQHayxe4YN8/alhKIZeA6TKpKl/jDodnel4qkUgOKwMt3wkcDmptQpqU
         eSlIHa/lTxNyWqtzAo7Z7JDMv0r6n9UH0GC0oS/ghkwTFWcuLng+uZ9TaAzDjuewFoWR
         OkGuA+gyduYoy30R0zK0sniFxJkVGP36YqGDouPdmnXl4g4csKCpTRi6A04AUhb3NVap
         KvXLNncdi5Hw5XSijF0FU6rL7FLOO6PnEwgxGa8omLQXK/M+pUVNE4cuhBIM+0+kNxov
         t1UA==
X-Gm-Message-State: ABy/qLYTzx1glGT2iJrekbLT6Sjj8jhnJnMCSALoLYXAjBK6a7rVZyVW
	dCVCZVDKdR7lwKxIwXCW8K9ak4GjWsFwVfsWCUSWqLZD
X-Google-Smtp-Source: APBJJlHa3RX51lM3Mi/JS7edY3dEn3be6jpAPQp1vf6v8GiWMGedK/SGGJvYUz28VPePc0J34L7CdQ==
X-Received: by 2002:a2e:b015:0:b0:2b6:d326:156d with SMTP id y21-20020a2eb015000000b002b6d326156dmr1169576ljk.19.1690446969125;
        Thu, 27 Jul 2023 01:36:09 -0700 (PDT)
Received: from localhost (212-51-140-210.fiber7.init7.net. [212.51.140.210])
        by smtp.gmail.com with ESMTPSA id o12-20020adfcf0c000000b00301a351a8d6sm1305676wrj.84.2023.07.27.01.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:36:08 -0700 (PDT)
From: Adam Sindelar <adam@wowsignal.io>
To: bpf@vger.kernel.org
Cc: Adam Sindelar <ats@fb.com>,
	David Vernet <void@manifault.com>,
	Brendan Jackman <jackmanb@google.com>,
	KP Singh <kpsingh@chromium.org>,
	linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v4] libbpf: Expose API to consume one ring at a time
Date: Thu, 27 Jul 2023 10:34:38 +0200
Message-Id: <20230727083436.293201-1-adam@wowsignal.io>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We already provide ring_buffer__epoll_fd to enable use of external
polling systems. However, the only API available to consume the ring
buffer is ring_buffer__consume, which always checks all rings. When
polling for many events, this can be wasteful.

Signed-off-by: Adam Sindelar <adam@wowsignal.io>
---
v1->v2: Added entry to libbpf.map
v2->v3: Correctly set errno and handle overflow
v3->v4: Fixed an embarrasing typo from zealous autocomplete

 tools/lib/bpf/libbpf.h   |  1 +
 tools/lib/bpf/libbpf.map |  1 +
 tools/lib/bpf/ringbuf.c  | 22 ++++++++++++++++++++++
 3 files changed, 24 insertions(+)

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
index 02199364db136..457469fc7d71e 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -290,6 +290,28 @@ int ring_buffer__consume(struct ring_buffer *rb)
 	return res;
 }
 
+/* Consume available data from a single RINGBUF map identified by its ID.
+ * The ring ID is returned in epoll_data by epoll_wait when called with
+ * ring_buffer__epoll_fd.
+ */
+int ring_buffer__consume_ring(struct ring_buffer *rb, uint32_t ring_id)
+{
+	struct ring *ring;
+	int64_t res;
+
+	if (ring_id >= rb->ring_cnt)
+		return libbpf_err(-EINVAL);
+
+	ring = &rb->rings[ring_id];
+	res = ringbuf_process_ring(ring);
+	if (res < 0)
+		return libbpf_err(res);
+
+	if (res > INT_MAX)
+		return INT_MAX;
+	return res;
+}
+
 /* Poll for available data and consume records, if any are available.
  * Returns number of records consumed (or INT_MAX, whichever is less), or
  * negative number, if any of the registered callbacks returned error.
-- 
2.39.2


