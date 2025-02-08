Return-Path: <bpf+bounces-50854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25342A2D580
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 11:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC393AB75E
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 10:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B2B1B3936;
	Sat,  8 Feb 2025 10:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QllGzVGz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DB91B3725;
	Sat,  8 Feb 2025 10:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739010757; cv=none; b=KuQEvlEB1PYsSw+uHOK9oXIFbtRS+tzLeHeuFu3LlLemEKsqugm1sXB3Sl6qg2BjY7x+6mUB5zo8mRtaZdiqfzN3SasmzHqRHLHuLvEzYJRAD4NGp/dBfs49tjjFXJwtOBY0jIzw5qshFQFn0N1TPoKR04llhxhWR5MUoVS+mgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739010757; c=relaxed/simple;
	bh=O/LtVesONaxr1pxjJg4rCojavnafUIXIpZWNOirrbIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ErSJ2wwFF7M43OuPHKCau2XhaCAKYo22OyS18AJxLBpUF3c0XyS2OMJoh4mSjY0g+v25CRN/PnpH2rfssz2NBiKUglDtigVEoOpi63spRYR4nqVcS96WvMjSbfoBpSjBnN49G93X6i8O1FMi5/Lqn0jEynNBQfZHc4uUqytPmwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QllGzVGz; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21f48ebaadfso42257845ad.2;
        Sat, 08 Feb 2025 02:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739010755; x=1739615555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1wHAm6t1sH0pAL4Ah9aBiIUBjLdmS33qQ+4mCf5Cy4=;
        b=QllGzVGzjm2tGTC9bZhbJ4w5zmNDDWXif9UlrSH2jfbFvB33za8vBFbVckQ+CZtDtP
         FNxdyrK1DA6mTQmH79R9J1VSLrVokeTRSzYFITyOUoLutHz9JsQ2qzaFmXKGdc94TvWD
         qC4n8fa8XbF9fvVCtQ9kKntHMkdBi1LwvjrKd3ej4ubWSoIzZpFmARla+aC+set/O8sG
         MaEhleY5KzTuZmK1dmHcxZx50R2x/rHj6tFg5f3RPMSjei0SyJTxABfZFZ1IQlmaQh/w
         IByhGjEzovpOChWVg9MPePd+vl27ZTjM94aY/dPEIa3V7hYWCRxpoWL9vvcn9tlsuy8m
         mDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739010755; x=1739615555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1wHAm6t1sH0pAL4Ah9aBiIUBjLdmS33qQ+4mCf5Cy4=;
        b=SO5BvdAEQmfJmTRm7pV7fZl2dZQT8wjVYWIhjHMPY0gYroknGkUTLqbUATYWirywJt
         ELIe+A9nW0c5FPOjl1Jp346dbEbP5y10SQ5+ggOiTVu6RhxxCVXbl1IGw/V2cn8pCKMr
         xhSp5lxEprd7U9MYqsG4UGm/FwOKtOUAJl0ZDwlWysHP8XJUwMsDHhiSdB+naXkGTHoM
         fM2SOA937aGSR3bvc0t1Eh1OcObUUcFTceG4dJ4WqN4pCZKTtz9HJ8rCu0z5rvJvqNq1
         DiXAr2fUwnzPHLmNMauBnOxIiFviQnBJnWsMuF3QGCzmQFOt6FNcebeoqT+rEXWsnrj3
         7AtA==
X-Forwarded-Encrypted: i=1; AJvYcCV5tM4elBVRxBI7OSEKYgelfbBmvQ1KcGQP7YELivpY5jd+gdaTvS75WsC6Y2uWmRNZi1JfW0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYv/jXOmcIfjSFmd3r6wDcox106/ZF2AUbnXr0qSDeHAnf3mPL
	dpeaqtYkdcsTkVpISU5ErwAsAzt31E70bi8hD32YvWSY+gkhk7BC
X-Gm-Gg: ASbGnctvkw2408QSbz1TL8CSirRYGX2onIkLKJFGVzy8eozdu7AnUjl5zGSP12zVXd+
	NJkwAQ8fmFgWVrGiwgHy5IU5jWmKcXOFgUu/cjSeXdLs1w+4pM+KMA5dR3aLSHQE3E19S1Hg7oX
	j25xYvfXqlHSXyQtJt4SlzwW3W8PNGNtaN7GXas3a/x6/dHOb+GHh2IWrjTbwKyr4aebDY9jhH3
	0AQ7KXIgFqd8T42wJX/eR/0eRqnGE/uybokLHQ5BHxY8FNANA9AAgwf78HDct16o7ymSkAhyW1R
	k8Y2K4n876NWLM8R/dLlupzhf/QcyLCzMLprZwcVuSFAxn7SjwKP1g==
X-Google-Smtp-Source: AGHT+IF/7oWaDMVS4Q+Sw8OKIn/jZMjfqdQgnZwzHquzfMcLKoILeWZLmfTfPkgNOUEz5e33Am95aA==
X-Received: by 2002:a17:903:41c7:b0:21f:6c81:f6c with SMTP id d9443c01a7336-21f6c811232mr33437925ad.41.1739010755050;
        Sat, 08 Feb 2025 02:32:35 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653af58sm44527835ad.70.2025.02.08.02.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 02:32:34 -0800 (PST)
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
Subject: [PATCH bpf-next v9 01/12] bpf: add support for bpf_setsockopt()
Date: Sat,  8 Feb 2025 18:32:09 +0800
Message-Id: <20250208103220.72294-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250208103220.72294-1-kerneljasonxing@gmail.com>
References: <20250208103220.72294-1-kerneljasonxing@gmail.com>
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


