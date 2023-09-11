Return-Path: <bpf+bounces-9633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6815A79A74E
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 12:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22704280E3E
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 10:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818EE11710;
	Mon, 11 Sep 2023 10:34:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE6C11708;
	Mon, 11 Sep 2023 10:34:45 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EDE120;
	Mon, 11 Sep 2023 03:34:44 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-99bed101b70so535449366b.3;
        Mon, 11 Sep 2023 03:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694428482; x=1695033282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/I9YoLGdl+XHs7ScA4HJEHOnhgbL9HGLXsGbg3gSig=;
        b=n/jB+W5t3QhD4NRePzymMX3aCeY1Vglvrg1A/QWIliOLblPqR8eZcK8eqrGZbqdGa/
         cH8+UgKemF9nzE8uS4cedCOXorsWTx7S5YCwWyfXd9SraBIQ3PlclC9dQ6qwlOMQUQKF
         gOnQpfDB1yr63KOGloKw3cLsQLDid3Wsh+/sA1d0FE4RjTBBUUIh1x3EbPlSeoj5KET5
         hpmnrwWRBtZXK9qazoculzUyUEvu2HNAYjXzYm3wF93/JPAiJXdnxPl/rHC2WHLBYOPB
         IbZ/TjDWdnkX6/B0DRXN5tdM84Ov43Qh35itora8o3Tk0kvIeUdQLyPLkBQHtbhRsLN1
         SY/g==
X-Gm-Message-State: AOJu0Yxi1lvEvGwl4/5r30AkKp+fllFhkFQc+Bs/bSp7P+QZXl94WEnt
	ogoXJgdKovXdJGfCIdiXcNE=
X-Google-Smtp-Source: AGHT+IHVfcyOfYRQ6q3iOIqmDl/n55XPIQHVUcFKogiWMqLJfS3ZozsL36G2IcqIVqZoXGJcpb2jYg==
X-Received: by 2002:a17:906:535d:b0:9a3:c4f4:12de with SMTP id j29-20020a170906535d00b009a3c4f412demr5746001ejo.37.1694428482195;
        Mon, 11 Sep 2023 03:34:42 -0700 (PDT)
Received: from localhost (fwdproxy-cln-010.fbsv.net. [2a03:2880:31ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id rl9-20020a170907216900b0099cbe71f3b5sm5071048ejb.0.2023.09.11.03.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 03:34:41 -0700 (PDT)
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
Subject: [PATCH v5 7/8] io_uring/cmd: Introduce SOCKET_URING_OP_SETSOCKOPT
Date: Mon, 11 Sep 2023 03:34:06 -0700
Message-Id: <20230911103407.1393149-8-leitao@debian.org>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support for SOCKET_URING_OP_SETSOCKOPT. This new command is similar
to setsockopt(2). This implementation leverages the function
do_sock_setsockopt(), which is shared with the setsockopt() system call
path.

Important to say that userspace needs to keep the pointer's memory alive
until the operation is completed. I.e, the memory could not be
deallocated before the CQE is returned to userspace.

Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/uapi/linux/io_uring.h |  1 +
 io_uring/uring_cmd.c          | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 1c789ee6462d..99cdb2c1e240 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -743,6 +743,7 @@ enum {
 	SOCKET_URING_OP_SIOCINQ		= 0,
 	SOCKET_URING_OP_SIOCOUTQ,
 	SOCKET_URING_OP_GETSOCKOPT,
+	SOCKET_URING_OP_SETSOCKOPT,
 };
 
 #ifdef __cplusplus
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 2806330a021f..7592af629b18 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -180,6 +180,20 @@ static inline int io_uring_cmd_getsockopt(struct socket *sock,
 	return do_sock_getsockopt(sock, compat, level, optname, optval, optlen);
 }
 
+static inline int io_uring_cmd_setsockopt(struct socket *sock,
+					  struct io_uring_cmd *cmd,
+					  unsigned int issue_flags)
+{
+	void __user *optval = u64_to_user_ptr(READ_ONCE(cmd->sqe->optval));
+	int optlen = READ_ONCE(cmd->sqe->optlen);
+	bool compat = !!(issue_flags & IO_URING_F_COMPAT);
+	int optname = READ_ONCE(cmd->sqe->optname);
+	int level = READ_ONCE(cmd->sqe->level);
+
+	return do_sock_setsockopt(sock, compat, level, optname, optval,
+				  optlen);
+}
+
 #if defined(CONFIG_NET)
 int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags)
 {
@@ -204,6 +218,8 @@ int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags)
 		return arg;
 	case SOCKET_URING_OP_GETSOCKOPT:
 		return io_uring_cmd_getsockopt(sock, cmd, issue_flags);
+	case SOCKET_URING_OP_SETSOCKOPT:
+		return io_uring_cmd_setsockopt(sock, cmd, issue_flags);
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.34.1


