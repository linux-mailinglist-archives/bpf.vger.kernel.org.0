Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3766576382
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 16:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiGOOS4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 10:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiGOOSy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 10:18:54 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E40022B00
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 07:18:52 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so3100705wmb.5
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 07:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DN0KEeiUrOrAzjRHtZhpECWO+4AQdVY9VD7IVruxG0M=;
        b=b7oJRHctrgT3U3+cIgo7joStpd5mIHvUs+0JzYFrft5+en+1yMQTudwWGFCU9I43JH
         CC4XNFZA+9sthmqmn/zmP/k2R70M9e4VmQLHxtPjty6AY/h6ThwD4pMJuvnLnz7O6lJ2
         w6sZEA2KqdwwdbOBqbbUBvYS+HZC8lyvhdvLmgSbFiiXz+qlklXMHbxNCoyj//pxbAom
         pH1WfFt6/Voqe+mDjS1jVhTqKR2h3jEQ1hJGJNi+xG4lBS7hmEsj7h1sXEwGPtd5QhzM
         QyW5DSME+9NKZkeIaKAQ2TD9KNwq50sRW9iuAUftquHl26hZFJPLgUMJxis52svntWoq
         /cVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DN0KEeiUrOrAzjRHtZhpECWO+4AQdVY9VD7IVruxG0M=;
        b=mkG3LVRsZb34ga/wC9SMiOWDvXJEThKZqpJxJVFPeRQ1dgeW96UqcNGTv3tDd/gPBC
         2zaQG4d4ineLy1kKAgPZQv2eME/NbHRghMnlRqpZ3Nv7rhrSc1SirQeRXzFi+gH5m/hV
         sSvEiHDhcYm0om1SkXCVTbZT0VbQTLLr9Gb+ny4aqPqNGQIsV43fuZqgQgwZi9vCsk4c
         Ej43uFwPlwohrm0oh/r4YU6HT6vdvfUd4HSYGjgwt9ZeGcTl1i/EpCumiP+CnSynCZRl
         Ejtu0THYdl4OCmZD+K/WZGRvu5S/hDVxYWy4LuFKBR4ZtDzwEwX3uVEZy8fUdn1Osul/
         2C4Q==
X-Gm-Message-State: AJIora9MwVGbOJH5RyOUkbiV5tj+PCucNqPx/+kfhGWsSE3JdJym14Ft
        JK6NSSPckUATp3eQrNB3WYwD8KUDrZI=
X-Google-Smtp-Source: AGRyM1vt8DybM7HMrSpF6StNmpOAwJaqwNRqHf0nsIu4AXFU60M0+PxFZi4K9gTYtDEBX7IVv54iKQ==
X-Received: by 2002:a05:600c:1986:b0:3a1:9fc4:b683 with SMTP id t6-20020a05600c198600b003a19fc4b683mr21001504wmq.72.1657894730642;
        Fri, 15 Jul 2022 07:18:50 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:6fc2:4af0:cc00:f99d:5d19:6e17:dc3a])
        by smtp.gmail.com with ESMTPSA id q7-20020a05600c2e4700b003a03be171b1sm5006315wmf.43.2022.07.15.07.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 07:18:50 -0700 (PDT)
From:   Jon Doron <arilou@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net
Cc:     Jon Doron <jond@wiz.io>
Subject: [PATCH bpf-next v3 1/1] libbpf: perfbuf: Add API to get the ring buffer
Date:   Fri, 15 Jul 2022 17:18:35 +0300
Message-Id: <20220715141835.93513-2-arilou@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220715141835.93513-1-arilou@gmail.com>
References: <20220715141835.93513-1-arilou@gmail.com>
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
 tools/lib/bpf/libbpf.c   | 26 ++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   |  2 ++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 29 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e89cc9c885b3..250263812194 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -12485,6 +12485,32 @@ int perf_buffer__buffer_fd(const struct perf_buffer *pb, size_t buf_idx)
 	return cpu_buf->fd;
 }
 
+/*
+ * Return the memory region of a ring buffer in *buf_idx* slot of
+ * PERF_EVENT_ARRAY BPF map. This ring buffer can be used to implement
+ * a custom events consumer.
+ * The ring buffer starts with the *struct perf_event_mmap_page*, which
+ * holds the ring buffer managment fields, when accessing the header
+ * structure it's important to be SMP aware.
+ * You can refer to *perf_event_read_simple* for a simple example.
+ */
+int perf_buffer__buffer(struct perf_buffer *pb, int buf_idx, void **buf,
+			size_t *buf_size)
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
index 9e9a3fd3edd8..78a7ab8f610a 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1381,6 +1381,8 @@ LIBBPF_API int perf_buffer__consume(struct perf_buffer *pb);
 LIBBPF_API int perf_buffer__consume_buffer(struct perf_buffer *pb, size_t buf_idx);
 LIBBPF_API size_t perf_buffer__buffer_cnt(const struct perf_buffer *pb);
 LIBBPF_API int perf_buffer__buffer_fd(const struct perf_buffer *pb, size_t buf_idx);
+LIBBPF_API int perf_buffer__buffer(struct perf_buffer *pb, int buf_idx, void **buf,
+				   size_t *buf_size);
 
 typedef enum bpf_perf_event_ret
 	(*bpf_perf_event_print_t)(struct perf_event_header *hdr,
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 52973cffc20c..971072c6dfd8 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -458,6 +458,7 @@ LIBBPF_0.8.0 {
 		bpf_program__set_insns;
 		libbpf_register_prog_handler;
 		libbpf_unregister_prog_handler;
+		perf_buffer__buffer;
 } LIBBPF_0.7.0;
 
 LIBBPF_1.0.0 {
-- 
2.36.1

