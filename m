Return-Path: <bpf+bounces-5841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2994A761EAE
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 18:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95B1281594
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 16:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD887200B9;
	Tue, 25 Jul 2023 16:37:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882471F17F
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 16:37:46 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0851723
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 09:37:40 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbfcc6daa9so46530165e9.3
        for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 09:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wowsignal-io.20221208.gappssmtp.com; s=20221208; t=1690303059; x=1690907859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MZD/JkvgzJERm5qcb7Qxeftco2ZAZPTxV2UUTquisO0=;
        b=R43PzUk6f72T+HjNte0MpAZXkf/H7zycsEDknZg/pvfae2lLEI5mEURZM7qgk06Kae
         4Ts618cdLWqe/bct47i8MG1m6OEVzqPWa0RinfPB+vkzdzNMOAHODVRRANFYYV+TcGEd
         baoQ4OnWdAtbilK0Ku/K/8fBxNHt9jdBJ9Aw0MxDj9m41UFFfDob6gz6GSwuDJcrUKLu
         zjQeNwLszKzTCpbsJdH4b9bLoHrhUZT95wEZ36VpJD2vOxlXHDAOs+DpV+O4ufwN2ADT
         IAz31zaB0QWYQaWoKzXXlIdMHUyeGKQj64bH93UfdpkG6WZB6n8z4luejoaDRjbyjkTb
         UEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690303059; x=1690907859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZD/JkvgzJERm5qcb7Qxeftco2ZAZPTxV2UUTquisO0=;
        b=d3pDfvEZfFhOVDiIv2Wo7CUqwT7YgUz+BSmCbrvkwSJjR+2VCePi0WR77kedFWhmLp
         RJfE4DWc+SXgDJbXsKlA8HVgKYlA2d5VhE1mCBMVt8XHhsUtT76w/cyttN2eeBmt0m/x
         XIEUhaRMyUhlP4w9LdVAXi/1+NX+zC1uR59siSbEW/nAT9y7Z4mKK6PZT+pj0eYPShmM
         rVHHaaPebFSt6arZYVEmCbg+tD9fXQCtskhHqx0WQzVNGk48k1yv6g9b/e5rA2ZouM67
         zondUVTb8zKKwU4FHd4d2ix84mTiuRLT4itQ/lDgecRH2tZaL4Fj1yymWNz5zCVb4uXH
         7lHg==
X-Gm-Message-State: ABy/qLb4nKrqSTXR3WfGC83pHKulMFaZSXJDM0FqTl40Tga1bOe8rbPS
	ULGaEMUWi33ICOWAMUXhDBbv/dyPdU/5NZn8f6lXg8YE
X-Google-Smtp-Source: APBJJlHyykPDpikvMveijw6n7THN5KhTA24wrnvWJVo/TjKE8i/0nrBXX3sY3znMG7GW9IQ9Tapx8w==
X-Received: by 2002:a05:600c:224b:b0:3fb:b34f:6cd4 with SMTP id a11-20020a05600c224b00b003fbb34f6cd4mr8599922wmm.36.1690303059062;
        Tue, 25 Jul 2023 09:37:39 -0700 (PDT)
Received: from localhost (212-51-140-210.fiber7.init7.net. [212.51.140.210])
        by smtp.gmail.com with ESMTPSA id bf7-20020a0560001cc700b00317495f88fasm10791530wrb.112.2023.07.25.09.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 09:37:38 -0700 (PDT)
From: Adam Sindelar <adam@wowsignal.io>
To: bpf@vger.kernel.org
Cc: Adam Sindelar <ats@fb.com>,
	David Vernet <void@manifault.com>,
	Brendan Jackman <jackmanb@google.com>,
	KP Singh <kpsingh@chromium.org>,
	linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Florent Revest <revest@chromium.org>
Subject: [PATCH] libbpf: Expose API to consume one ring at a time
Date: Tue, 25 Jul 2023 18:26:55 +0200
Message-Id: <20230725162654.912897-1-adam@wowsignal.io>
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
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We already provide ring_buffer__epoll_fd to enable use of external
polling systems. However, the only API available to consume the ring
buffer is ring_buffer__consume, which always checks all rings. When
polling for many events, this can be wasteful.

Signed-off-by: Adam Sindelar <adam@wowsignal.io>
---
 tools/lib/bpf/libbpf.h  |  1 +
 tools/lib/bpf/ringbuf.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

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


