Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB2C57668E
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 20:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiGOSLj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 14:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiGOSLi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 14:11:38 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF111564EE
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 11:11:36 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a5so7774549wrx.12
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 11:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nBvVEQH2p2zGPdbwMp+shWqmHxHEjbjDEOwnJfUKbEg=;
        b=R+zIjvsu7qDNywC3Da70qKNwUXF+1Qc7EBlqpRhyKWL96yLaafT8WTwXCmLpdU3nMG
         NgLW9PI4yTR4hNLBlI9bvhtUMkpsm9MnyG9y2g7CovQWBYsJj288FlSRvJpAd8+mcGfH
         S57TlwAzYuyUGVqjlJkCBjbVgYAFz8Xa+6wjibjjJYsb8QF86cv6oiI196GE8rxWjsb5
         xLr1VduVfy17ksNYAZQiV42uG+6NeQ+9jHvHW+x0vj8E+6fwqLixDleZURjewU9JHFnG
         74DqTZH/5yfq3ACEV4PuIYJKRjmCoBuYzWj9MR4KNSORS+/20psmtx6oct5X+QPpHXGg
         aHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nBvVEQH2p2zGPdbwMp+shWqmHxHEjbjDEOwnJfUKbEg=;
        b=dyAoxypQToqQUxFgyiXLiitT4p9wr4OXaENE3ooWvPw5lp8PGt2hdWHcmveo5/p6S7
         dQFKwDe/VV+7EoQu6ID6l0Ip8nX9jfPH6Yv5c0JtWQciM86sv8pCbZRHZPGHbFgjdybn
         ycIA/7fDrv3j1dIvQX8stYzqQwxVQzMWOAadJd7lVFI5c6j9dNMJ3ZDkVzNSW6w3sEf3
         0jDywnOTS8QddDfj017ySRI1Y7uzqAKXf8kn9AW002oocezJ/uFReP7iyZEI0v2kDXAZ
         zid5OAEzM45iX0dNhaJgG2zYmxpv6KTqmX68KBXh/x4HhjzpptAmSMfYP93UIg7LVklw
         cgkw==
X-Gm-Message-State: AJIora/KbqsQ4wzTCVk4koYtB1vA9ugyEDGalneDw279/xjDnQjT9Rk9
        Yfjwn7vS5piHT3ANw+VLFqDJJ9UnFxs=
X-Google-Smtp-Source: AGRyM1vmjxgsFacqFdYnthUKAhNq2N5shumfXouwyRKSsU9xtkAGIcpsxTKrY2LHB8C8HWSo+wWsNw==
X-Received: by 2002:a05:6000:180f:b0:21d:68f8:c4ac with SMTP id m15-20020a056000180f00b0021d68f8c4acmr13996294wrh.193.1657908694942;
        Fri, 15 Jul 2022 11:11:34 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:6fc2:4af0:cc00:f99d:5d19:6e17:dc3a])
        by smtp.gmail.com with ESMTPSA id b4-20020a05600c150400b003a03185231bsm5596548wmg.31.2022.07.15.11.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 11:11:34 -0700 (PDT)
From:   Jon Doron <arilou@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net
Cc:     Jon Doron <jond@wiz.io>
Subject: [PATCH bpf-next v5] libbpf: perfbuf: Add API to get the ring buffer
Date:   Fri, 15 Jul 2022 21:11:22 +0300
Message-Id: <20220715181122.149224-1-arilou@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Jon Doron <jond@wiz.io>

Add support for writing a custom event reader, by exposing the ring
buffer.

With the new API perf_buffer__buffer() you will get access to the
raw mmaped()'ed per-cpu underlying memory of the ring buffer.

This region contains both the perf buffer data and header
(struct perf_event_mmap_page), which manages the ring buffer
state (head/tail positions, when accessing the head/tail position
it's important to take into consideration SMP).
With this type of low level access one can implement different types of
consumers here are few simple examples where this API helps with:

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
 tools/lib/bpf/libbpf.c   | 16 ++++++++++++++++
 tools/lib/bpf/libbpf.h   | 16 ++++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 33 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 68da1aca406c..77ae83308199 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11734,6 +11734,22 @@ int perf_buffer__buffer_fd(const struct perf_buffer *pb, size_t buf_idx)
 	return cpu_buf->fd;
 }
 
+int perf_buffer__buffer(struct perf_buffer *pb, int buf_idx, void **buf, size_t *buf_size)
+{
+	struct perf_cpu_buf *cpu_buf;
+
+	if (buf_idx >= pb->cpu_cnt)
+		return libbpf_err(-EINVAL);
+
+	cpu_buf = pb->cpu_bufs[buf_idx];
+	if (!cpu_buf)
+		return libbpf_err(-ENOENT);
+
+	*buf = cpu_buf->base;
+	*buf_size = pb->mmap_size;
+	return 0;
+}
+
 /*
  * Consume data from perf ring buffer corresponding to slot *buf_idx* in
  * PERF_EVENT_ARRAY BPF map without waiting/polling. If there is no data to
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index e4d5353f757b..c51d6e6b3066 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1053,6 +1053,22 @@ LIBBPF_API int perf_buffer__consume(struct perf_buffer *pb);
 LIBBPF_API int perf_buffer__consume_buffer(struct perf_buffer *pb, size_t buf_idx);
 LIBBPF_API size_t perf_buffer__buffer_cnt(const struct perf_buffer *pb);
 LIBBPF_API int perf_buffer__buffer_fd(const struct perf_buffer *pb, size_t buf_idx);
+/**
+ * @brief **perf_buffer__buffer()** returns the per-cpu raw mmap()'ed underlying
+ * memory region of the ring buffer.
+ * This ring buffer can be used to implement a custom events consumer.
+ * The ring buffer starts with the *struct perf_event_mmap_page*, which
+ * holds the ring buffer managment fields, when accessing the header
+ * structure it's important to be SMP aware.
+ * You can refer to *perf_event_read_simple* for a simple example.
+ * @param pb the perf buffer structure
+ * @param buf_idx the buffer index to retreive
+ * @param buf (out) gets the base pointer of the mmap()'ed memory
+ * @param buf_size (out) gets the size of the mmap()'ed region
+ * @return 0 on success, negative error code for failure
+ */
+LIBBPF_API int perf_buffer__buffer(struct perf_buffer *pb, int buf_idx, void **buf,
+				   size_t *buf_size);
 
 struct bpf_prog_linfo;
 struct bpf_prog_info;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 94b589ecfeaa..4c4c40b8f935 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -362,4 +362,5 @@ LIBBPF_1.0.0 {
 		libbpf_bpf_link_type_str;
 		libbpf_bpf_map_type_str;
 		libbpf_bpf_prog_type_str;
+		perf_buffer__buffer;
 };
-- 
2.36.1

