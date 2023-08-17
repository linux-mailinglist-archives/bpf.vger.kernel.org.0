Return-Path: <bpf+bounces-7989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 480E677FA00
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 16:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F68281FFA
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 14:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B081643F;
	Thu, 17 Aug 2023 14:56:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5723915ADC;
	Thu, 17 Aug 2023 14:56:45 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E3830F5;
	Thu, 17 Aug 2023 07:56:25 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-52256241c50so10545496a12.3;
        Thu, 17 Aug 2023 07:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692284184; x=1692888984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+xKbzOAOfyHzPl3gLRZBxDpNmJnPRkN8+wjSWU3fB0=;
        b=GWH6ompBRUMMUjjVOxlPlV9ggAD2jXnWokXzklV1v1yVrWeGWo5OOS7j2KFYhcqA0g
         gp4fxG1/dLVqXGy/R3hnWVBuFN08DUGSEG44RRsN8BOgjGhh/qErGxhd/9LLy1VHkzZv
         c7zICFiRckBHZid4tQBlNIsq2vgf6iYkoFOxQCzdKGMBIePsxmJdD6mBdB/P+r1VHCwR
         CWLIwcHqSrHHg3u5RrkUqIWn3BAvCa2w+KV7WEyuuXeVJHtTkfUivWefiMpeyZvsHVN6
         2hZHrDAHNrstW5hZzRaeWnS1K4nsh//U80vlUZH34T8a4HaLNclP79jr+v3ZzO6duCwy
         P/Zw==
X-Gm-Message-State: AOJu0Yx7nCCvNbjqR2OUL2jr0GXHxORxyQmjy8oOGtl+B8IFtu/Ru8d6
	xJyeygI31CHEcL/GLszR/QPUdH52Et8=
X-Google-Smtp-Source: AGHT+IFbdnCec5/GG4elrASYIqG3L05Gl6U1bRerKBPRZirmGIhRzKnsh/EyfWRmkmvtSfoDA9LleA==
X-Received: by 2002:aa7:ca55:0:b0:523:b1b0:f69f with SMTP id j21-20020aa7ca55000000b00523b1b0f69fmr5285145edt.32.1692284183717;
        Thu, 17 Aug 2023 07:56:23 -0700 (PDT)
Received: from localhost (fwdproxy-cln-014.fbsv.net. [2a03:2880:31ff:e::face:b00c])
        by smtp.gmail.com with ESMTPSA id c5-20020aa7df05000000b005222b471dc4sm9750582edy.95.2023.08.17.07.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 07:56:23 -0700 (PDT)
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
Subject: [PATCH v3 6/9] io_uring/cmd: Introduce SOCKET_URING_OP_GETSOCKOPT
Date: Thu, 17 Aug 2023 07:55:51 -0700
Message-Id: <20230817145554.892543-7-leitao@debian.org>
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

Add support for getsockopt command (SOCKET_URING_OP_GETSOCKOPT), where
level is SOL_SOCKET. This is leveraging the sockptr_t infrastructure,
where a sockptr_t is either userspace or kernel space, and handled as
such.

Function io_uring_cmd_getsockopt() is inspired by __sys_getsockopt().

Differently from the getsockopt(2), the optlen field is not a userspace
pointers. In getsockopt(2), userspace provides optlen pointer, which is
overwritten by the kernel.  In this implementation, userspace passes a
u32, and the new value is returned in cqe->res. I.e., optlen is not a
pointer.

Important to say that userspace needs to keep the pointer alive until
the CQE is completed.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/uapi/linux/io_uring.h |  7 +++++++
 io_uring/uring_cmd.c          | 38 +++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 9fc7195f25df..8152151080db 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -43,6 +43,10 @@ struct io_uring_sqe {
 	union {
 		__u64	addr;	/* pointer to buffer or iovecs */
 		__u64	splice_off_in;
+		struct {
+			__u32	level;
+			__u32	optname;
+		};
 	};
 	__u32	len;		/* buffer size or number of iovecs */
 	union {
@@ -79,6 +83,7 @@ struct io_uring_sqe {
 	union {
 		__s32	splice_fd_in;
 		__u32	file_index;
+		__u32	optlen;
 		struct {
 			__u16	addr_len;
 			__u16	__pad3[1];
@@ -89,6 +94,7 @@ struct io_uring_sqe {
 			__u64	addr3;
 			__u64	__pad2[1];
 		};
+		__u64	optval;
 		/*
 		 * If the ring is initialized with IORING_SETUP_SQE128, then
 		 * this field is used for 80 bytes of arbitrary command data
@@ -729,6 +735,7 @@ struct io_uring_recvmsg_out {
 enum {
 	SOCKET_URING_OP_SIOCINQ		= 0,
 	SOCKET_URING_OP_SIOCOUTQ,
+	SOCKET_URING_OP_GETSOCKOPT,
 };
 
 #ifdef __cplusplus
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 5f32083bd0a5..7b768f1bf4df 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -168,6 +168,36 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 }
 EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);
 
+INDIRECT_CALLABLE_DECLARE(bool tcp_bpf_bypass_getsockopt(int level,
+							 int optname));
+static inline int io_uring_cmd_getsockopt(struct socket *sock,
+					  struct io_uring_cmd *cmd,
+					  unsigned int issue_flags)
+{
+	void __user *optval = u64_to_user_ptr(READ_ONCE(cmd->sqe->optval));
+	int optname = READ_ONCE(cmd->sqe->optname);
+	int optlen = READ_ONCE(cmd->sqe->optlen);
+	int level = READ_ONCE(cmd->sqe->level);
+	int err;
+
+	err = security_socket_getsockopt(sock, level, optname);
+	if (err)
+		return err;
+
+	if (level == SOL_SOCKET) {
+		err = sk_getsockopt(sock->sk, level, optname,
+				    USER_SOCKPTR(optval),
+				    KERNEL_SOCKPTR(&optlen));
+		if (err)
+			return err;
+
+		return optlen;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+#if defined(CONFIG_NET)
 int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags)
 {
 	struct socket *sock = cmd->file->private_data;
@@ -189,8 +219,16 @@ int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags)
 		if (ret)
 			return ret;
 		return arg;
+	case SOCKET_URING_OP_GETSOCKOPT:
+		return io_uring_cmd_getsockopt(sock, cmd, issue_flags);
 	default:
 		return -EOPNOTSUPP;
 	}
 }
+#else
+int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags)
+{
+	return -EOPNOTSUPP;
+}
+#endif
 EXPORT_SYMBOL_GPL(io_uring_cmd_sock);
-- 
2.34.1


