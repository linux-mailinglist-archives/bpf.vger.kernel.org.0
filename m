Return-Path: <bpf+bounces-9629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE15C79A746
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 12:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B4F91C208FC
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 10:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4921E57C;
	Mon, 11 Sep 2023 10:34:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E8EE547;
	Mon, 11 Sep 2023 10:34:31 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9E0E5F;
	Mon, 11 Sep 2023 03:34:30 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-501cef42bc9so6936103e87.0;
        Mon, 11 Sep 2023 03:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694428468; x=1695033268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gptGKutv8UrS/zDN0Qmum7MxSe9eEjLIE1n6bMLfanE=;
        b=fjwGZqU0XX1eFlobZPhQwLGEaFslXYsfR6JtFiPdtqpiFqSNZZY+KEIiAh5YtLlAX6
         aPGRIpoyf2qtUGko6JOnhRFw0ofVPtyV4M7DUOagMbWTYfc9ATkPDcMC5b+mxG3eJLkF
         AuJePBlUumkPNrXhVZy9mvrVoYPo7IqufPSErTzu6mSjZAJ70T9b5MCkYZHpOhc6GfUI
         GK7+X5mzMZv0GWBYpBQWVmzu2XvgN4Fj3yHXVjblddwKQ+TzmvrFqKMy+SjkLOyrK8Yb
         0UK/vsEddCL15EcPcaMoG27aoP8PjrPGxD5Wv13hcFyhWMZSdM8B+E/0skHgEeF5gNYk
         fanA==
X-Gm-Message-State: AOJu0YzXg5hMgTwoNHfscE3OIJlqwOxE6jOg4F8DiNV7CRLurgvnz1LW
	HGTNCtq+XPBLN8Ah7qEUpxU=
X-Google-Smtp-Source: AGHT+IE04qAA52ud2RBYfVMX6E4dXcBtrekuG1o6qnVmzVtntDq44/WaDkwl7P+Orft4t/uxKZ6vzQ==
X-Received: by 2002:a05:6512:3d09:b0:4fb:89b3:3373 with SMTP id d9-20020a0565123d0900b004fb89b33373mr9263203lfv.43.1694428468123;
        Mon, 11 Sep 2023 03:34:28 -0700 (PDT)
Received: from localhost (fwdproxy-cln-118.fbsv.net. [2a03:2880:31ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id s10-20020aa7d78a000000b00523653295f9sm4399748edq.94.2023.09.11.03.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 03:34:27 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: sdf@google.com,
	axboe@kernel.dk,
	asml.silence@gmail.com,
	willemdebruijn.kernel@gmail.com,
	kuba@kernel.org,
	martin.lau@linux.dev,
	krisman@suse.de
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	io-uring@vger.kernel.org,
	pabeni@redhat.com
Subject: [PATCH v5 3/8] io_uring/cmd: Pass compat mode in issue_flags
Date: Mon, 11 Sep 2023 03:34:02 -0700
Message-Id: <20230911103407.1393149-4-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911103407.1393149-1-leitao@debian.org>
References: <20230911103407.1393149-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Create a new flag to track if the operation is running compat mode.
This basically check the context->compat and pass it to the issue_flags,
so, it could be queried later in the callbacks.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/io_uring.h | 1 +
 io_uring/uring_cmd.c     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index 106cdc55ff3b..bc53b35966ed 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -20,6 +20,7 @@ enum io_uring_cmd_flags {
 	IO_URING_F_SQE128		= (1 << 8),
 	IO_URING_F_CQE32		= (1 << 9),
 	IO_URING_F_IOPOLL		= (1 << 10),
+	IO_URING_F_COMPAT		= (1 << 11),
 };
 
 struct io_uring_cmd {
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 537795fddc87..60f843a357e0 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -128,6 +128,8 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
 		issue_flags |= IO_URING_F_SQE128;
 	if (ctx->flags & IORING_SETUP_CQE32)
 		issue_flags |= IO_URING_F_CQE32;
+	if (ctx->compat)
+		issue_flags |= IO_URING_F_COMPAT;
 	if (ctx->flags & IORING_SETUP_IOPOLL) {
 		if (!file->f_op->uring_cmd_iopoll)
 			return -EOPNOTSUPP;
-- 
2.34.1


