Return-Path: <bpf+bounces-6061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB15764D6F
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 10:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B6928224D
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 08:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18F3D51B;
	Thu, 27 Jul 2023 08:33:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E211D50F
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 08:33:05 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516099025
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 01:32:44 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3128fcd58f3so722949f8f.1
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 01:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wowsignal-io.20221208.gappssmtp.com; s=20221208; t=1690446702; x=1691051502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+FIdkei8j0Z6dR9PWH32VtzS9uGAiomSHDdNkPEK7YY=;
        b=A10BdUL/7HPmH5SS6q6httZ/Ojp8CeeZnqh8XMF/reS6CnkaZHsCBdPZ7Rfnoan4MT
         Eh2p80CGonbJeNmu2mdQVkB0MLxXq+SOXVUGhvdDwHowd2L6by0G0AbW++W7ITXPgdsf
         v9I62RUYrngrGiwDhj26BSQcr41j8dns1uE0IatYMAiZepfDaCCsBcPuwykeEoNy8S6S
         N8PEHEKH4DAYv1p78mKQNFMBRKVoBXNeLitLT2pHOx0MDDyxHPpVDwZ7KP0bjfDSMUG9
         UjnE2ZkpEHNehAuh+LyS3oRk/C/ez69FCMmngj14wc7CROEfPVflcvuUppapokC+HjGA
         6aGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690446702; x=1691051502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+FIdkei8j0Z6dR9PWH32VtzS9uGAiomSHDdNkPEK7YY=;
        b=DRPpdYkoAfiIdIj1zVX+oZ5PSHKBMCUvka6uYZqcs2U7j+gMoDBQPGSd3D2J0u50Kc
         ciTD3963AZOj3FkKdzFNGRVAqIJ+vJ691gUBRx5MeH/10sfuT2ycX7Y81Ln66DqX8+Sj
         bz+sky3468g1Rl5rixXUiiPXN4fVTfg6bSxH6i104nPcd4FbdQTNjvXDUeLSkWGA5STQ
         i+bpbhspcyu44QMdEwXZv1uCyOWxkgN+e/VV+b/XbUoBakWQu6y6h2EjiD9b+FPLxeP3
         2Ai8yLcta9/f6aY+VD1GBsenS/D4I99H/hG3sE6oC7fmdMhc3MJ71bC+/2qcvMXqqKEo
         dBEA==
X-Gm-Message-State: ABy/qLbz6Yk9rFE3pNPqEQLYtuTAc7oaPL7FMmUt2TxEYVMzo8+ZUhzB
	+e+f46/eRKUOjnQVD9cIV6/Sb2fxEMtzABHD5NWQExi1
X-Google-Smtp-Source: APBJJlFs+78ZtEvnBVELBgSLCy1PWM5/Gt0i7cgS1zxYweehf2AKKbyxppMOIWBjWSc9MH+r5K8qcA==
X-Received: by 2002:a5d:4cc7:0:b0:315:9362:3c70 with SMTP id c7-20020a5d4cc7000000b0031593623c70mr1225842wrt.60.1690446702139;
        Thu, 27 Jul 2023 01:31:42 -0700 (PDT)
Received: from localhost (212-51-140-210.fiber7.init7.net. [212.51.140.210])
        by smtp.gmail.com with ESMTPSA id k13-20020a056000004d00b003176bd661fasm1284502wrx.116.2023.07.27.01.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:31:41 -0700 (PDT)
From: Adam Sindelar <adam@wowsignal.io>
To: bpf@vger.kernel.org
Cc: Adam Sindelar <ats@fb.com>,
	David Vernet <void@manifault.com>,
	Brendan Jackman <jackmanb@google.com>,
	KP Singh <kpsingh@chromium.org>,
	linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v3] libbpf: Expose API to consume one ring at a time
Date: Thu, 27 Jul 2023 10:23:12 +0200
Message-Id: <20230727082311.284075-1-adam@wowsignal.io>
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
index 02199364db136..9f72b8c4504a7 100644
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
+		return libbpf_error(res);
+
+	if (res > INT_MAX)
+		return INT_MAX;
+	return res
+}
+
 /* Poll for available data and consume records, if any are available.
  * Returns number of records consumed (or INT_MAX, whichever is less), or
  * negative number, if any of the registered callbacks returned error.
-- 
2.39.2


