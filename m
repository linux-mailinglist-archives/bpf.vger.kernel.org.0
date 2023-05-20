Return-Path: <bpf+bounces-987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD2F70A671
	for <lists+bpf@lfdr.de>; Sat, 20 May 2023 10:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5D471C20A68
	for <lists+bpf@lfdr.de>; Sat, 20 May 2023 08:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DAF20E0;
	Sat, 20 May 2023 08:41:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC60372
	for <bpf@vger.kernel.org>; Sat, 20 May 2023 08:41:42 +0000 (UTC)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CF61BB;
	Sat, 20 May 2023 01:41:40 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5289cf35eeaso1192199a12.1;
        Sat, 20 May 2023 01:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684572100; x=1687164100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vzxA/hUX8foGgVXJvxnvVqkQ7/8Ii0zngzDlNRrcVao=;
        b=osT526hGGFNfKga9XAnWB+RDp+UhUagqtAwio/C3iMrelWVrgJXT8tcECs0j58hc9r
         eHOcf0fdKdjp9mCUCLlor+yreygqZEDV+w9MDCikIWCT6t4VsPakWKG6IEc+MBUZEjH9
         79NkwpUdViEUpZX8ypoemxgt4bVRp7rp7Tim+ixB2AiSX7T3QxkVoFuU40GT3m3gt7d3
         VKFenLKZeV3n8mot8juuGmpC55fdhHi74uDGIz7GlbO9VRvDRXUd+V/x5BeGzHcM9M9w
         LChOcWa4BaRYfqBSJDb1KSSSq0ZYxfRB+4kKYZXUrl+LejEfByoDNhwxfukVEGKF8HBN
         IacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684572100; x=1687164100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vzxA/hUX8foGgVXJvxnvVqkQ7/8Ii0zngzDlNRrcVao=;
        b=bvbbOQr5KAs4FQCAg1si03sPa6RCaQASB3Vi6kwqMJTaOZdxwCaq5QVYRI51UiLUa0
         54rCqNVAQkj2uQaj79D9l1yv0uqIJ/gBSo3eiG4GJ0Rf1ipzvihHHb50EI6Nj9hnizPO
         eB1yqeQMNXdHJrXkE1gzc8UO6byWU77pHkhierWO4OpGFygS1ahwDhv6ybpIN+gXLU9n
         zUbYHZOkHOKK0TiLVN0ci3gvMfVF/wKZL6M6oRepn4njQHF0RTrTI4IiG6zEStGzeyiV
         oA1/hoSIaNJIYQPpvo4UzSqCCOUjXSsgS8hzBDH5GZYyw+mi0pAVSP3qI8MbaG1VHKrw
         aG1w==
X-Gm-Message-State: AC+VfDy0c1XsOFKCpMX4SBiHyvb1kYKge/m7En5mzxRLzAh0K35LvWec
	BP6HZ6HIN3a9TJyjNGPzl5PP35Ohx10RSg==
X-Google-Smtp-Source: ACHHUZ4STBzVjUEyLV4bd91LOoHt7wSc+I3MFY6emKyPItNgIZ+xPE+O862akqN5mtxn1XnQqCFwBw==
X-Received: by 2002:a17:90b:f84:b0:247:14ac:4d3a with SMTP id ft4-20020a17090b0f8400b0024714ac4d3amr5385444pjb.20.1684572099886;
        Sat, 20 May 2023 01:41:39 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.9])
        by smtp.gmail.com with ESMTPSA id d61-20020a17090a6f4300b0024dfbac9e2fsm2810726pjk.21.2023.05.20.01.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 01:41:39 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	bpf@vger.kernel.org,
	yhs@meta.com,
	hengqi.chen@gmail.com,
	Francis Laniel <flaniel@linux.microsoft.com>
Subject: [PATCH] block: introduce block_io_start/block_io_done tracepoints
Date: Sat, 20 May 2023 08:40:57 +0000
Message-Id: <20230520084057.1467003-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, several BCC ([0]) tools (biosnoop/biostacks/biotop) use
kprobes to blk_account_io_start/blk_account_io_done to implement
their functionalities. This is fragile because the target kernel
functions may be renamed ([1]) or inlined ([2]). So introduces two
new tracepoints for such use cases.

  [0]: https://github.com/iovisor/bcc
  [1]: https://github.com/iovisor/bcc/issues/3954
  [2]: https://github.com/iovisor/bcc/issues/4261

Tested-by: Francis Laniel <flaniel@linux.microsoft.com>
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 block/blk-mq.c               |  4 ++++
 include/trace/events/block.h | 26 ++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f6dad0886a2f..faa1c7992876 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -957,6 +957,8 @@ EXPORT_SYMBOL_GPL(blk_update_request);
 
 static inline void blk_account_io_done(struct request *req, u64 now)
 {
+	trace_block_io_done(req);
+
 	/*
 	 * Account IO completion.  flush_rq isn't accounted as a
 	 * normal IO on queueing nor completion.  Accounting the
@@ -976,6 +978,8 @@ static inline void blk_account_io_done(struct request *req, u64 now)
 
 static inline void blk_account_io_start(struct request *req)
 {
+	trace_block_io_start(req);
+
 	if (blk_do_io_stat(req)) {
 		/*
 		 * All non-passthrough requests are created from a bio with one
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 7f4dfbdf12a6..40e60c33cc6f 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -245,6 +245,32 @@ DEFINE_EVENT(block_rq, block_rq_merge,
 	TP_ARGS(rq)
 );
 
+/**
+ * block_io_start - insert a request for execution
+ * @rq: block IO operation request
+ *
+ * Called when block operation request @rq is queued for execution
+ */
+DEFINE_EVENT(block_rq, block_io_start,
+
+	TP_PROTO(struct request *rq),
+
+	TP_ARGS(rq)
+);
+
+/**
+ * block_io_done - block IO operation request completed
+ * @rq: block IO operation request
+ *
+ * Called when block operation request @rq is completed
+ */
+DEFINE_EVENT(block_rq, block_io_done,
+
+	TP_PROTO(struct request *rq),
+
+	TP_ARGS(rq)
+);
+
 /**
  * block_bio_complete - completed all work on the block operation
  * @q: queue holding the block operation
-- 
2.34.1


