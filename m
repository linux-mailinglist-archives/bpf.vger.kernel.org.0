Return-Path: <bpf+bounces-50440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3837CA279C1
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 19:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D4616780A
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 18:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EB721772A;
	Tue,  4 Feb 2025 18:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaL27D67"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E61D21771D;
	Tue,  4 Feb 2025 18:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738693841; cv=none; b=YWfMM4X9CZi7lnPHL1IvxKQU2mUZyjd9Ezl6SAy1tRjC0k89LgKRz7F9ea1VsWe+WCqRy8r/94262ZrusL+lPfK63w0nJl7oATWkjaDtTAdOCqFQTFYFJ8IVSlJ8E58fVKX5cTAyn3qui9XXPncZGN19FuCDJxpHE4KjIz/dNpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738693841; c=relaxed/simple;
	bh=O/LtVesONaxr1pxjJg4rCojavnafUIXIpZWNOirrbIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CSQ5K8EQ9kZs/Mwo95kdgFg3pkOcH1YaKiu1dnThIligzjtHU8yBng8q+Dud3jNFv/W7mz+iyvxq3RNOs6vn6H9T3p9OsWTGrXz10FMaMB/JG3CCg0g3RDqHEFb8/iEJYAF9Iw1s0Z0rhapclkNqt6bKqNWS6VfMdDYCWdBHjAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaL27D67; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21effc750d2so19475485ad.3;
        Tue, 04 Feb 2025 10:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738693839; x=1739298639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1wHAm6t1sH0pAL4Ah9aBiIUBjLdmS33qQ+4mCf5Cy4=;
        b=DaL27D67mmUYL6cNwG3KVjk0uiyzqsscRVl+T/+dIIWLnCsNakbl6hVZdTrGeC55ay
         HRDrMW5CWOm0IgBSWnyPFfqcKzTtX59KgxhI4fa6Z2xQ0uwT+e1lhSte4Hi/0M1vtgyj
         j/2Qdk5aCcXwYUm8/TSTAo8UPOB7Deoz8dlWh2fDJglU4IMFjEuGMeDm1hBS0lA+0fxp
         +k3Ndky35vkGz/Am7YDPOv+bCVUOemiQpZpLwHCwGyNLCE/EaFmsBm+7OBGHbrF/khfr
         wrKtqoA+8zPggLYWMwiPx+gz3OYIp/+3P1+D61zCG80tTepyRpkRfz9zHga0OKf8uqEN
         OiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738693839; x=1739298639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1wHAm6t1sH0pAL4Ah9aBiIUBjLdmS33qQ+4mCf5Cy4=;
        b=vYPwO0egqEr8epLgJlyJP1IMlw24ReVN7jnGEki8Zan/z4dxLy64XG5Ez4pIXFa1+O
         P1itcgxePTKs3RS+0pjXQM5YlnwNnMcI+S/fJeMfpCNID9u7dpe7/APQSY9uyCOMH91u
         7kw6xPuPQQ+7FJlPnofe4sd5BM/Mrz1awnccedz+GwoqNxQlqHebv7orQ5naD/3PA/4l
         dV9roNQScv0ENonit0BDRz48mvSkonk/hLBv072HFPGugYh8QBXiWjFo2TzSuvt7SOpT
         s2DGtQUulFgE2BN4BpLRXbu42+w1eJfe3rwnLAuEJlCqdmfE/vj6jVQfmBEk2vI3yBHt
         ZL0w==
X-Forwarded-Encrypted: i=1; AJvYcCX6DwL7kHY1camI6TqbgN+3tB0dqOjG48IAv+Qt2Ib0AHPxyYnGsLxE1ISKcCuwSEVbtAICMm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YybEpq5MWULdc3fU7zMO+lmpcoV/4usIswhplGKdVfJeqh39CoD
	aHUZ3J3Mbp8G0hIFyaHGI/mYHyWxOBMkq5J4JGIuVM+mGaFPJFXY
X-Gm-Gg: ASbGncvluwQhANRAoQgXfQgFk+4Clh445tY7ygMKCqYNVVLlrK0yuZKABjU2Hd0k0DY
	oFOZODngYOOdJAzShNaliwumua1N/HuUWB3MmfUFTqda2bftrMKWq4JwsH5uICEf5XiMFD51Y/O
	rK2fYXiq2Kyz0NNfT3vlztYQ3XILVJP5mRl/CzzJ7xES84zPBEj6bjgOYMyX0izHuEwDUuLgPiZ
	9DPZmfMR6NRJHiodJDPIHET57dJ2eLCss0OvXWhXSecOQcc32UKQtbrqII5chW2sN3s/5jSTIKf
	GPvn1B/v4ALDjy76GZmKqIFRQlKw1py2GhCVlseRdmirb8HAeify6A==
X-Google-Smtp-Source: AGHT+IGdeKbDbqw9Ir+TE0OiPKB0OTr8fWzAFMaMcJOKSEQYkWHehaxcoTRwiwEOV4iOtGwb8tq0zQ==
X-Received: by 2002:a17:902:d54d:b0:21f:7bd:57f1 with SMTP id d9443c01a7336-21f07bd59a7mr38340435ad.53.1738693839120;
        Tue, 04 Feb 2025 10:30:39 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f848a99a45sm11590591a91.38.2025.02.04.10.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 10:30:38 -0800 (PST)
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
	horms@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH bpf-next v8 01/12] bpf: add support for bpf_setsockopt()
Date: Wed,  5 Feb 2025 02:30:13 +0800
Message-Id: <20250204183024.87508-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250204183024.87508-1-kerneljasonxing@gmail.com>
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Users can write the following code to enable the bpf extension:
int flags = SK_BPF_CB_TX_TIMESTAMPING;
int opts = SK_BPF_CB_FLAGS;
bpf_setsockopt(skops, SOL_SOCKET, opts, &flags, sizeof(flags));

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/net/sock.h             |  3 +++
 include/uapi/linux/bpf.h       |  8 ++++++++
 net/core/filter.c              | 23 +++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  1 +
 4 files changed, 35 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 8036b3b79cd8..7916982343c6 100644
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
@@ -445,6 +446,8 @@ struct sock {
 	u32			sk_reserved_mem;
 	int			sk_forward_alloc;
 	u32			sk_tsflags;
+#define SK_BPF_CB_FLAG_TEST(SK, FLAG) ((SK)->sk_bpf_cb_flags & (FLAG))
+	u32			sk_bpf_cb_flags;
 	__cacheline_group_end(sock_write_rxtx);
 
 	__cacheline_group_begin(sock_write_tx);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 2acf9b336371..6116eb3d1515 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6913,6 +6913,13 @@ enum {
 	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
 };
 
+/* Definitions for bpf_sk_cb_flags */
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
index 2acf9b336371..70366f74ef4e 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7091,6 +7091,7 @@ enum {
 	TCP_BPF_SYN_IP		= 1006, /* Copy the IP[46] and TCP header */
 	TCP_BPF_SYN_MAC         = 1007, /* Copy the MAC, IP[46], and TCP header */
 	TCP_BPF_SOCK_OPS_CB_FLAGS = 1008, /* Get or Set TCP sock ops flags */
+	SK_BPF_CB_FLAGS		= 1009, /* Used to set socket bpf flags */
 };
 
 enum {
-- 
2.43.5


