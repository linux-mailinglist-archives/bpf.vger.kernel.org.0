Return-Path: <bpf+bounces-6183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA85766905
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 11:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8433C2826AD
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 09:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F96210961;
	Fri, 28 Jul 2023 09:35:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18936D305
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 09:35:44 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB5210EC
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 02:35:42 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9c0391749so29196751fa.0
        for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 02:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wowsignal-io.20221208.gappssmtp.com; s=20221208; t=1690536940; x=1691141740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JSbAR7dWxwhLJYW8XT5bgVlaA1SWINOC/DZLLBHhIYo=;
        b=lIoVuOtw/ATsFdZ7Lm4PGDkfR9lmoNWmdnio9/6Nm4oXrrxm4DUz+ar+vI0yCE8D2/
         crIsqShYOkjA0W5guOU5wR+2YXYEEGXhsAhuLHC/uLHZzMthPusUjRy50cCs6RfWtIks
         q+Q8dzMkeheMOO8vfqGme5RwvOyszbNpdAOJ4DQj9iNeUSho/xbDbwYm0VnnSl6zkZzS
         0H1xAz9Jm0QhEspBJVeIjdfsmsmdTnoPzYrXnhiG64V89m9vPsbmGHwNXbmFc1/MlA9D
         8503yc59+xGXsZDIgfFrTgmeGcby6sUWBLGxsr/iRnl13SXKkZHgqUDej9esVnAPWgwH
         U6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690536940; x=1691141740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JSbAR7dWxwhLJYW8XT5bgVlaA1SWINOC/DZLLBHhIYo=;
        b=hi4zcN8r3QkEhkxXbuRWgxbDD9p+Gh4F4Xy0pvVw1UIpEeKuqU+zTcvoPnBFXLWbH1
         Ce1o3RTVNQ8bqojewPAA6weJSbzdJYMubqLJ+yi8eNLNQmwarvVEHV8j+YFSijJWjhy2
         oZz7JIhyyCg9gHTL2T1/WXSmzXajesz/H+beox5OeKksQMjRDArJ0U2E5jLdRn/k5DN5
         d+u4MPUHck0B5BohBvjke/IhXJ6cHSfUTFoYiFTib4ER606l67s/zO3UcgFlt9H2QPyb
         W8MyCCjLnI0k2k7/xFr/AcF8yLNm47MYMuUYhfEnOIeqclOH+GjBDUrCFXIqh45gNz6o
         /Scg==
X-Gm-Message-State: ABy/qLbIc0YaXGkuulprNzbx1Nf8MtNxqLzTDWchLtvLH5m6voF0/J/n
	hBGRRbnd+LZcRK4g9e8JWV/h9P6c18FPJ+waaOK5Dqx+
X-Google-Smtp-Source: APBJJlEHZ7r1CaEonFBJjkbPox8z5/FfBaI8gpUQi3c+2Olbd3dDjPeZZ3+w/AabJVmtob4/bpGObA==
X-Received: by 2002:a2e:95c6:0:b0:2b7:339c:f791 with SMTP id y6-20020a2e95c6000000b002b7339cf791mr1345168ljh.25.1690536939979;
        Fri, 28 Jul 2023 02:35:39 -0700 (PDT)
Received: from localhost (212-51-140-210.fiber7.init7.net. [212.51.140.210])
        by smtp.gmail.com with ESMTPSA id t6-20020a5d6906000000b0031760af2331sm4248180wru.100.2023.07.28.02.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 02:35:39 -0700 (PDT)
From: Adam Sindelar <adam@wowsignal.io>
To: bpf@vger.kernel.org
Cc: Adam Sindelar <ats@fb.com>,
	David Vernet <void@manifault.com>,
	Brendan Jackman <jackmanb@google.com>,
	KP Singh <kpsingh@chromium.org>,
	linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v5] libbpf: Expose API to consume one ring at a time
Date: Fri, 28 Jul 2023 11:33:47 +0200
Message-Id: <20230728093346.673994-1-adam@wowsignal.io>
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
v1->v2: Added entry to libbpf.map
v2->v3: Correctly set errno and handle overflow
v3->v4: Fixed an embarrasing typo from zealous autocomplete
v4->v5: Added a selftest to show usage

 tools/lib/bpf/libbpf.h                        |  1 +
 tools/lib/bpf/libbpf.map                      |  1 +
 tools/lib/bpf/ringbuf.c                       | 22 ++++++++++++++++
 .../selftests/bpf/prog_tests/ringbuf_multi.c  | 26 +++++++++++++++++++
 4 files changed, 50 insertions(+)

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
diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
index 1455911d9fcbe..8123efc94d1a8 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
@@ -29,6 +29,11 @@ static int process_sample(void *ctx, void *data, size_t len)
 		CHECK(s->value != 777, "sample2_value", "exp %ld, got %ld\n",
 		      777L, s->value);
 		break;
+	case 2:
+		CHECK(ring != 2, "sample3_ring", "exp %d, got %d\n", 2, ring);
+		CHECK(s->value != 1337, "sample3_value", "exp %ld, got %ld\n",
+		      1337L, s->value);
+		break;
 	default:
 		CHECK(true, "extra_sample", "unexpected sample seq %d, val %ld\n",
 		      s->seq, s->value);
@@ -45,6 +50,8 @@ void test_ringbuf_multi(void)
 	int err;
 	int page_size = getpagesize();
 	int proto_fd = -1;
+	int epoll_fd;
+	struct epoll_event events[2];
 
 	skel = test_ringbuf_multi__open();
 	if (CHECK(!skel, "skel_open", "skeleton open failed\n"))
@@ -124,6 +131,25 @@ void test_ringbuf_multi(void)
 	CHECK(skel->bss->total != 2, "err_total", "exp %ld, got %ld\n",
 	      2L, skel->bss->total);
 
+	/* validate APIs to support external polling */
+	epoll_fd = ring_buffer__epoll_fd(ringbuf);
+
+	/* expect events on either ring to trigger through the epoll_fd */
+	skel->bss->target_ring = 2;
+	skel->bss->value = 1337;
+	syscall(__NR_getpgid);
+
+	err = epoll_wait(epoll_fd, events, sizeof(events) / sizeof(struct epoll_event), -1);
+	if (CHECK(err != 1, "epoll_wait", "epoll_wait exp %d, got %d\n", 1, err))
+		goto cleanup;
+	if (CHECK(!(events[0].events & EPOLLIN), "epoll_event", "expected EPOLLIN\n"))
+		goto cleanup;
+
+	/* epoll data can be used to consume only the affected ring */
+	err = ring_buffer__consume_ring(ringbuf, events[0].data.u32);
+	CHECK(err != 1, "consume_ring", "consume_ring %u exp %d, got %d\n",
+		  events[0].data.u32, 1, err);
+
 cleanup:
 	if (proto_fd >= 0)
 		close(proto_fd);
-- 
2.39.2


