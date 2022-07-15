Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80565765C0
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 19:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbiGORP7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 13:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbiGORP6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 13:15:58 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262CC43E6C
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 10:15:56 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id a5so7558474wrx.12
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 10:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=84fRZgCz92llVayL94uIYfOOoekmnLfcLxc8caTvIgY=;
        b=h0nQ8qozKUh6SyN8sVHhYXhN4mpA6OERYW+1YeemAtoM7v1y04G/BhBqBlunC+naMi
         mczuTXBbdY3rWClDHF/OS33EgQrHz958/LgB56MYMZNwtL8XSUL6ncLJIDfPQ73Er0tu
         t7SKr6ogxaWRn49czq67zyTPLpmeVUioLRSigWqQm+0fYFvRA2S9zyaK9W/HLaHFhoMd
         htIjytD03QJpWgclOMDXzXC+ee4d/eK/JDgwa2Ol5UwUVagfPDZXKD2KfVB3KACtaROG
         eX7oPz/ll0NlSVxH2bT+WOWKfO5IsagttQCJEtHwchNDLQDWLiNUZnwJbXVdvGSLhc3o
         i/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=84fRZgCz92llVayL94uIYfOOoekmnLfcLxc8caTvIgY=;
        b=DGzDlvTKdgYc5I9dwXCPVlSSU2bWRELgLPMxUQb67K6yoH60D7oJEFq/1QNx7kWw0X
         FCnj/nIJBjVMeGgOCI8gt3nD0E2hf/BStCcPlV6Z5gHHd6fS0oWx7KTfjuxSSculrqtA
         KJeW5r6Pqh83fHV/dlk2AkGgfhufr2okqb47VX1wmXCub2jr5Tx++XCls7fZYW127rno
         /7hCG2IJAgCMPBPqtDQv1JQGycPE5/nGc8Pz3Zf6OEMJKK45x9BfKFjmR/z8Wqx8J5FB
         pH7Hs7s4KEs5PsSCVrzQClFhDOlbFwMApJVA5EO6L6MOJ+FN+aRAbjUJgDATvWKnM3KY
         FTmg==
X-Gm-Message-State: AJIora/LUPmkUTHizj3CBligAsnDkd5/i4xoVmWJ9qbkwPw6vkz/udm4
        QILxdaS/P7e4nt0ueAMWXfjU8PUBpIg=
X-Google-Smtp-Source: AGRyM1tn+dDQyVesSFRTelVYWIeHmfg3hxesG2GFGjxVUGdCtdu6Wy15PplYRfC4cpFFSYEGQt23Lg==
X-Received: by 2002:a5d:5606:0:b0:21d:dfb5:f15e with SMTP id l6-20020a5d5606000000b0021ddfb5f15emr2359127wrv.404.1657905354310;
        Fri, 15 Jul 2022 10:15:54 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:6fc2:4af0:cc00:f99d:5d19:6e17:dc3a])
        by smtp.gmail.com with ESMTPSA id i15-20020a5d438f000000b0021d4d6355efsm4223502wrq.109.2022.07.15.10.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 10:15:53 -0700 (PDT)
From:   Jon Doron <arilou@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net
Cc:     Jon Doron <jond@wiz.io>
Subject: [PATCH bpf-next v4] libbpf: perfbuf: Add API to get the ring buffer
Date:   Fri, 15 Jul 2022 20:15:40 +0300
Message-Id: <20220715171540.134813-1-arilou@gmail.com>
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
 tools/lib/bpf/libbpf.map |  2 ++
 3 files changed, 34 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e89cc9c885b3..c18bdb9b6e85 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -12485,6 +12485,22 @@ int perf_buffer__buffer_fd(const struct perf_buffer *pb, size_t buf_idx)
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
index 9e9a3fd3edd8..9cd9fc1a16d2 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1381,6 +1381,22 @@ LIBBPF_API int perf_buffer__consume(struct perf_buffer *pb);
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
 
 typedef enum bpf_perf_event_ret
 	(*bpf_perf_event_print_t)(struct perf_event_header *hdr,
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 52973cffc20c..75cf9d4c871b 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -461,5 +461,7 @@ LIBBPF_0.8.0 {
 } LIBBPF_0.7.0;
 
 LIBBPF_1.0.0 {
+	global:
+		perf_buffer__buffer;
 	local: *;
 };
-- 
2.36.1

