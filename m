Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10EE569B56
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 09:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiGGHOE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jul 2022 03:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbiGGHOB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jul 2022 03:14:01 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0DF2FFC9
        for <bpf@vger.kernel.org>; Thu,  7 Jul 2022 00:14:00 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id s1so24971026wra.9
        for <bpf@vger.kernel.org>; Thu, 07 Jul 2022 00:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YRCuLQR+YYdyH8ItaWoVjGZ7iB5/Td9YEOP/4JYUmHk=;
        b=cZuLiG9U/KtKRh/UHJrErJf4DxCCvPHz62LLNJQTNM+tRajnt+XiKu/n5RQC/oAgh4
         Bjzwc930J7w90hy02yC3WLqvtjXz5KRHRfdkjDZj703sCl3e9s/lA54geQj/ONK4O4xG
         n45idrZ3qKgcoJ5Z6i9rDylDXWQ6phiSngOza791cXYNzpoebfOlKRX/Dmkeyrfh5UrY
         5T6NTS3CkJSpJ88D8iR6xSeffszRIg269BnDzF1VVvbBrOM+zYptrL4MzPY9NZIDJ4mh
         W+SihIERbTdLQijXFYy5azaDGRhIiN2WbkD4zvlZTBYt4rAcj/kvbRoJg+8YhhVmlaS+
         8Luw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YRCuLQR+YYdyH8ItaWoVjGZ7iB5/Td9YEOP/4JYUmHk=;
        b=3olM4wocnjexqshgnZjoHnIT8h87OBuAzB2IdzumFCKHhxjBVMANltreEKS7z+x+Wk
         EqceChTTeEU71ka2rZpfD/NEE5cOYNfBfllv5Rz97/LBCmzUxS9GapeliefW4u905w6y
         9ig7gLEpxplNe7D+v4Mfchv6Giud7DrVT22n/Om5qOD9ZPrvHVtwvYTVjWZcqK16U+zE
         R2WyJl2FjVwnpQRnfD2+UW/6C+kToG+kwdv6pcRKDxozXXo8BzmQdPKc9WwWlYGsXlwd
         oOJHMwmoNQUfpdg3tzHdvdGaJF//tTWyI4yyOcFdla5KqZmxdkfgiYhh8WCFksYZosNy
         64nQ==
X-Gm-Message-State: AJIora9IceCkV5atAQmaOP1Lsx27npDwOHaTfUck3Gufm/1NxCwg58cR
        CS5FKijPE/ef9Kd0zENt4HnggdtQ9tM=
X-Google-Smtp-Source: AGRyM1vQboKLIeU4KLN1li3/pBpHRqLvyQVoWpIXpqr5X2bMKjZWWDRzVjqPc80JB2DlR6kvCU6WKg==
X-Received: by 2002:a5d:6d46:0:b0:21b:933d:7950 with SMTP id k6-20020a5d6d46000000b0021b933d7950mr40842038wri.679.1657178038778;
        Thu, 07 Jul 2022 00:13:58 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:6fc2:4af0:cc00:f99d:5d19:6e17:dc3a])
        by smtp.gmail.com with ESMTPSA id g14-20020a7bc4ce000000b003a2cf1ba9e2sm855604wmk.6.2022.07.07.00.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 00:13:58 -0700 (PDT)
From:   Jon Doron <arilou@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net
Cc:     Jon Doron <jond@wiz.io>
Subject: [PATCH v1 1/1] libbpf: perfbuf: allow raw access to buffers
Date:   Thu,  7 Jul 2022 10:13:39 +0300
Message-Id: <20220707071339.1486742-2-arilou@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707071339.1486742-1-arilou@gmail.com>
References: <20220707071339.1486742-1-arilou@gmail.com>
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

Add API for perfbuf to support writing a custom event reader.

Signed-off-by: Jon Doron <jond@wiz.io>
---
 tools/lib/bpf/libbpf.c | 40 ++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h |  6 ++++++
 2 files changed, 46 insertions(+)

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
index 9e9a3fd3edd8..b6f6b6a12d70 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1381,6 +1381,12 @@ LIBBPF_API int perf_buffer__consume(struct perf_buffer *pb);
 LIBBPF_API int perf_buffer__consume_buffer(struct perf_buffer *pb, size_t buf_idx);
 LIBBPF_API size_t perf_buffer__buffer_cnt(const struct perf_buffer *pb);
 LIBBPF_API int perf_buffer__buffer_fd(const struct perf_buffer *pb, size_t buf_idx);
+LIBBPF_API int perf_buffer__raw_ring_buf(const struct perf_buffer *pb,
+					 size_t buf_idx, void **base,
+					 size_t *buf_size, __u64 *head,
+					 __u64 *tail);
+LIBBPF_API int perf_buffer__set_ring_buf_tail(const struct perf_buffer *pb,
+					      size_t buf_idx, __u64 tail);
 
 typedef enum bpf_perf_event_ret
 	(*bpf_perf_event_print_t)(struct perf_event_header *hdr,
-- 
2.36.1

