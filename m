Return-Path: <bpf+bounces-7986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E9577F9F5
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 16:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B2C1C20C77
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 14:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E4B154BC;
	Thu, 17 Aug 2023 14:56:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E99115496;
	Thu, 17 Aug 2023 14:56:39 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8735D3A97;
	Thu, 17 Aug 2023 07:56:15 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4fe28f92d8eso12187734e87.1;
        Thu, 17 Aug 2023 07:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692284173; x=1692888973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZB7zodArDhWbuVqBQO5jZlDc1cl4dj72Y3+CgGSOBM=;
        b=B3TCKNGJ/H8/9j1l0709nsRCR57AsXAfsqQvDVHfmHrIq7Gl04KZnOl0XHveK/q3x9
         XNZzWUNHnkWCC4ndHBMW8J5hU3Vi0+U2G24OjFdUPj/VfGIJJwIW33q8nNBTHX43SlJS
         DnACohA2NKT/TeJNavr4XyoAOWU/loMps/1EZbbkaddeVyBve1qKjpb3oibq0W7dfS6b
         cFLDIt4Ilqxmrew0LEO4BWINN7kZfoVXN6u6DSn7DrK/+3Oq1bdj4sEg1QT9X+eXt9OK
         7yagysII9bUReSqzIFReAh+rJWKSwP3pCISvSQ176+rhQarGUCppPMgKEfHik26g3Z3O
         cMWQ==
X-Gm-Message-State: AOJu0Yw1DCwFIb2nO4eGf5KXMg0ECWrhWC5ouu4eucCIoHAuMrhHTWo+
	q2YuBNTQhSIluNqpyQZKWN4=
X-Google-Smtp-Source: AGHT+IHkFtWdt13rVSZyph83D2DvyT4aJpO+ylqoJpkWBio3b0LJQDIihgMYn0enN+UH1BA82JADqg==
X-Received: by 2002:a05:6512:3b8d:b0:4ff:8c9e:eb0d with SMTP id g13-20020a0565123b8d00b004ff8c9eeb0dmr5941971lfv.0.1692284173282;
        Thu, 17 Aug 2023 07:56:13 -0700 (PDT)
Received: from localhost (fwdproxy-cln-119.fbsv.net. [2a03:2880:31ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id t8-20020a056402020800b005236b47116asm9911547edv.70.2023.08.17.07.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 07:56:12 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: sdf@google.com,
	axboe@kernel.dk,
	asml.silence@gmail.com,
	willemdebruijn.kernel@gmail.com,
	martin.lau@linux.dev
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	io-uring@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	krisman@suse.de
Subject: [PATCH v3 4/9] io_uring/cmd: Pass compat mode in issue_flags
Date: Thu, 17 Aug 2023 07:55:49 -0700
Message-Id: <20230817145554.892543-5-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817145554.892543-1-leitao@debian.org>
References: <20230817145554.892543-1-leitao@debian.org>
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
index 8e7a03c1b20e..5f32083bd0a5 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -129,6 +129,8 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
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


