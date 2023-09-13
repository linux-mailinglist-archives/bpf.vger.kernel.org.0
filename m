Return-Path: <bpf+bounces-9927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D57379ED16
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 17:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E91A7281608
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 15:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEC6200D4;
	Wed, 13 Sep 2023 15:28:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774F0200CE;
	Wed, 13 Sep 2023 15:28:37 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982B71BFE;
	Wed, 13 Sep 2023 08:28:36 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-9ada6b0649fso89404266b.1;
        Wed, 13 Sep 2023 08:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694618915; x=1695223715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2/uGjka4vxabDaOe18mLCK6HUraAejeoqQZCxCnFKY=;
        b=VfJSKC77ByBcDP5hwQNKU/LaZwJU8mhW2J4lGCflQxJPYPBlWv8MiUWM07pMeF2wNd
         imYd9kG5dFn/Lf7mka/dZ3KEm6lSVQAGB02YgPBle68EW5RHWzgArYNVQAtTW/jEWkXM
         BosC1Hztq8dQtrhNZgt828eA69e44l7VpJWko32kQ+ob058GwExIm6SDoqKWATVmRaGZ
         UKrSSDg/RL8eWx32NeMIUYBR2gn33WjeQhU/ms1mi+SqLVcH0+cyOqBQoWGawsrOSkXn
         hzHyING9VjwoB++ZbrrQt0cxEDKHQ8QWeDxJUn7m+OZ+URrv+KJ0c2dbJdUjstsc4hwM
         Iuag==
X-Gm-Message-State: AOJu0YxN2qqEXXLVi6WWDSmv0En5elmsYUId1mLdbnrccbVTEG9TzYWt
	DnqR8Y5h79cpMEuXqEvNBuzL98F7oAM=
X-Google-Smtp-Source: AGHT+IFPL0fdft0J2qmWcyGh3tAon9o5pRYXkFbBm4VNhe/VvDNL5sshV+GwHDo59c5fUujl0nGqDw==
X-Received: by 2002:a17:906:1050:b0:9aa:17a2:e3fa with SMTP id j16-20020a170906105000b009aa17a2e3famr2523073ejj.72.1694618914957;
        Wed, 13 Sep 2023 08:28:34 -0700 (PDT)
Received: from localhost (fwdproxy-cln-011.fbsv.net. [2a03:2880:31ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id l26-20020a1709061c5a00b009894b476310sm8516152ejg.163.2023.09.13.08.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 08:28:34 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: sdf@google.com,
	axboe@kernel.dk,
	asml.silence@gmail.com,
	willemdebruijn.kernel@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	martin.lau@linux.dev,
	krisman@suse.de
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [PATCH v6 7/8] io_uring/cmd: Introduce SOCKET_URING_OP_SETSOCKOPT
Date: Wed, 13 Sep 2023 08:27:43 -0700
Message-Id: <20230913152744.2333228-8-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913152744.2333228-1-leitao@debian.org>
References: <20230913152744.2333228-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index a2a6ac0c503b..2266c829d1c4 100644
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


