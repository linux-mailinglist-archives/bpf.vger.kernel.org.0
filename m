Return-Path: <bpf+bounces-52048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D07A3D244
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 08:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D84A3AA82C
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 07:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3934F1E885C;
	Thu, 20 Feb 2025 07:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHmy20p+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385CF25760;
	Thu, 20 Feb 2025 07:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036597; cv=none; b=Pt/yDDTODH5cfudi2L/hNPIZvl88WA41esTKrAgEjkmbTXIXvNYRJxqaHe57X8bPsg/8We6eD2hSOkdiSxPI3pcAyNXXc1LVrARpMZ5Dxfspr2dK7tEuC9qz92eJp4j6THht0pWrHo+eySC6IpF52OA8el8nM91AGwaquzYqn2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036597; c=relaxed/simple;
	bh=6jOBXQ0/BeF1R0G4OuKYN32U0jVvUvMDDDlTPGH/BHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pk8bAtuv7gTmU0NiqdqOu75L+KsN+wlr+PNVPHE6rg1Dlshf6bExsLxOQBUN/Xx3xgDVJhttKwC3ktUquFSDpyUCC+TKNWRHqF0oQ9YIclQQS9DjTFwGk6Y7SjBgwJZQyknYJYa4iCoN5m8o+E4iEmPIxpCceChMFdDnbJoC2YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHmy20p+; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fbfe16cc39so1221759a91.3;
        Wed, 19 Feb 2025 23:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740036595; x=1740641395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SIpMNJaEln02czHucseSyDjX69GDtQ/wBexwQPO1aI=;
        b=nHmy20p+y3a216RAkPTfMwyxlx6Me8TncFj8s9V0nWpRhacEl2wHXVFA4rbY5QLxI7
         uNNH2ARoMu0Y9icVfV5fLG8s51ri61SycS14aeRuen1HBAXbCwXbNnmFAExg31ZvLynG
         +s7nWCVcIMnqOgMa1do2qSbwp7dszhKs3ifWh7oyYE2NeE6HVR/nbD75lg5fyDtiXJKm
         6buBPE3s+uHqBiBDcZEkDxSZRekEqS/O1ZT4RACaO61n+j+Iv2AQHGrkQFHjV1Cp+v4A
         UO1z03+VQYp3OBoUHqLdZuqP0M8mf1nXcYENnPtDGrokG9Ide2O3yaBw8sGXRVOMdZ3t
         t6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740036595; x=1740641395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SIpMNJaEln02czHucseSyDjX69GDtQ/wBexwQPO1aI=;
        b=PdewIbnysLrX3dZ6lot5AgNt7qdHcwjKYI8gxYP4Qg7wqcE5M6PHuEm62HimH4+LU7
         KYIeO+XBdGDs0JMlLngGSnPxl4pMRAP03C9fp4pVoInaoHF8knDhIYOKvhb3TfjsxuIe
         5pC7CqMxqM9/GB2m85mmNuHeFeICbmw+r8zKnd6LTSpjubSlDCY7t6pz75WiBLmXdp6B
         XBgEZZ8/62WUuxPzp0y78QWi9+Ayl/qJczZnk4L2SbbZpr67Fy9E5suQ2T3BZCLrSvoV
         ihDQABmQdcDu+BhhHYTCkshTIVqKJZ7PKvc2NiGoKtoOQHq26HcZCuSTmggVjW7ja7kv
         xWuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxQ/rdwgdAhZjMvqz8m+G9ki48KpTbxNNexZyoBn/3LVY1lIzwFqBdDXeAc8cO+DbhQHiT3pI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKUcGnIK40DaTKAgZOnQFUUzaG1Kh/9YDgoLjapYFQkpAe0LX+
	kQb9/j0PwhxW+R/lVyLEz9lruLww5hJxGR7Jago9BQgRhLRAwn5A
X-Gm-Gg: ASbGncsjta55kYqvRWh8mj5Nvd5dTqrhhdAwySt0tPFb3uFPQ1voucSZmU1MAHIV1xu
	rDNk9ZT/l3xZiz+RMexiSAeoLR5b5zWa3M2KefQn35Jqf6ZtA9cldtWgjajnavqZ8cRb2cBzXoD
	b6xIO+0Mn8Yjp6nE2N1H7aOYn5IuaU9QeMDilRBMCGOOEOtzlpT2OIO1NXTni3GE/emvLVO9Azp
	nROfkYI9VZIubunLPQPHOXaMLgsePPoDRbJRqzAFwjBxz7XptoOrJY1wbLswyWESO/lYIKhXSWe
	iVdNyVnJFCkxAC3e1gaK3q1cXv9CTpHeBlTknzfn8MGoUei6ESRTLt3InGd+3EM=
X-Google-Smtp-Source: AGHT+IGXIaOuiQLLXQ5vWEmsXYHmUFb741WLr/m3jayVFh7DZEI8i6JghMWXxCo5yP1kWdv3k3cMWw==
X-Received: by 2002:a17:90b:2f8f:b0:2ef:2d9f:8e58 with SMTP id 98e67ed59e1d1-2fc411508famr28198550a91.34.1740036595430;
        Wed, 19 Feb 2025 23:29:55 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d643sm114048205ad.126.2025.02.19.23.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 23:29:55 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	ykolal@fb.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH bpf-next v13 01/12] bpf: add networking timestamping support to bpf_get/setsockopt()
Date: Thu, 20 Feb 2025 15:29:29 +0800
Message-Id: <20250220072940.99994-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250220072940.99994-1-kerneljasonxing@gmail.com>
References: <20250220072940.99994-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new SK_BPF_CB_FLAGS and new SK_BPF_CB_TX_TIMESTAMPING are
added to bpf_get/setsockopt. The later patches will implement the
BPF networking timestamping. The BPF program will use
bpf_setsockopt(SK_BPF_CB_FLAGS, SK_BPF_CB_TX_TIMESTAMPING) to
enable the BPF networking timestamping on a socket.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/net/sock.h             |  3 +++
 include/uapi/linux/bpf.h       |  8 ++++++++
 net/core/filter.c              | 23 +++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  8 ++++++++
 4 files changed, 42 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 8036b3b79cd8..870c3672d9af 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -303,6 +303,7 @@ struct sk_filter;
   *	@sk_stamp: time stamp of last packet received
   *	@sk_stamp_seq: lock for accessing sk_stamp on 32 bit architectures only
   *	@sk_tsflags: SO_TIMESTAMPING flags
+  *	@sk_bpf_cb_flags: used in bpf_setsockopt()
   *	@sk_use_task_frag: allow sk_page_frag() to use current->task_frag.
   *			   Sockets that can be used under memory reclaim should
   *			   set this to false.
@@ -525,6 +526,8 @@ struct sock {
 	u8			sk_txtime_deadline_mode : 1,
 				sk_txtime_report_errors : 1,
 				sk_txtime_unused : 6;
+#define SK_BPF_CB_FLAG_TEST(SK, FLAG) ((SK)->sk_bpf_cb_flags & (FLAG))
+	u8			sk_bpf_cb_flags;
 
 	void			*sk_user_data;
 #ifdef CONFIG_SECURITY
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index fff6cdb8d11a..3a2af105fff0 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6916,6 +6916,13 @@ enum {
 	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
 };
 
+/* Definitions for sk_bpf_cb_flags */
+enum {
+	SK_BPF_CB_TX_TIMESTAMPING	= 1<<0,
+	SK_BPF_CB_MASK			= (SK_BPF_CB_TX_TIMESTAMPING - 1) |
+					   SK_BPF_CB_TX_TIMESTAMPING
+};
+
 /* List of known BPF sock_ops operators.
  * New entries can only be added at the end
  */
@@ -7094,6 +7101,7 @@ enum {
 	TCP_BPF_SYN_IP		= 1006, /* Copy the IP[46] and TCP header */
 	TCP_BPF_SYN_MAC         = 1007, /* Copy the MAC, IP[46], and TCP header */
 	TCP_BPF_SOCK_OPS_CB_FLAGS = 1008, /* Get or Set TCP sock ops flags */
+	SK_BPF_CB_FLAGS		= 1009, /* Used to set socket bpf flags */
 };
 
 enum {
diff --git a/net/core/filter.c b/net/core/filter.c
index 2ec162dd83c4..1c6c07507a78 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5222,6 +5222,25 @@ static const struct bpf_func_proto bpf_get_socket_uid_proto = {
 	.arg1_type      = ARG_PTR_TO_CTX,
 };
 
+static int sk_bpf_set_get_cb_flags(struct sock *sk, char *optval, bool getopt)
+{
+	u32 sk_bpf_cb_flags;
+
+	if (getopt) {
+		*(u32 *)optval = sk->sk_bpf_cb_flags;
+		return 0;
+	}
+
+	sk_bpf_cb_flags = *(u32 *)optval;
+
+	if (sk_bpf_cb_flags & ~SK_BPF_CB_MASK)
+		return -EINVAL;
+
+	sk->sk_bpf_cb_flags = sk_bpf_cb_flags;
+
+	return 0;
+}
+
 static int sol_socket_sockopt(struct sock *sk, int optname,
 			      char *optval, int *optlen,
 			      bool getopt)
@@ -5238,6 +5257,7 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
 	case SO_MAX_PACING_RATE:
 	case SO_BINDTOIFINDEX:
 	case SO_TXREHASH:
+	case SK_BPF_CB_FLAGS:
 		if (*optlen != sizeof(int))
 			return -EINVAL;
 		break;
@@ -5247,6 +5267,9 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
 		return -EINVAL;
 	}
 
+	if (optname == SK_BPF_CB_FLAGS)
+		return sk_bpf_set_get_cb_flags(sk, optval, getopt);
+
 	if (getopt) {
 		if (optname == SO_BINDTODEVICE)
 			return -EINVAL;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 2acf9b336371..0d4c348e42de 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6913,6 +6913,13 @@ enum {
 	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
 };
 
+/* Definitions for sk_bpf_cb_flags */
+enum {
+	SK_BPF_CB_TX_TIMESTAMPING	= 1<<0,
+	SK_BPF_CB_MASK			= (SK_BPF_CB_TX_TIMESTAMPING - 1) |
+					   SK_BPF_CB_TX_TIMESTAMPING
+};
+
 /* List of known BPF sock_ops operators.
  * New entries can only be added at the end
  */
@@ -7091,6 +7098,7 @@ enum {
 	TCP_BPF_SYN_IP		= 1006, /* Copy the IP[46] and TCP header */
 	TCP_BPF_SYN_MAC         = 1007, /* Copy the MAC, IP[46], and TCP header */
 	TCP_BPF_SOCK_OPS_CB_FLAGS = 1008, /* Get or Set TCP sock ops flags */
+	SK_BPF_CB_FLAGS		= 1009, /* Used to set socket bpf flags */
 };
 
 enum {
-- 
2.43.5


