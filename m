Return-Path: <bpf+bounces-48642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6185FA0A899
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 12:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8721675F3
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 11:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D611B1D65;
	Sun, 12 Jan 2025 11:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GA+7W1f5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3D61ABED7;
	Sun, 12 Jan 2025 11:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736681895; cv=none; b=WbyU2jQ8qN2oluJLb4nneE9e464Oi/CiKea7LQyV0VOPWeMPOJQRf34LjEE2xI63gsnVVZ1Lka2ykY/AK/dl3IZQvw0GwvLOcvh2vT5DAhPsAlLL7X2C8f5J9j9Ad2iv/sXzYSnzR8+RgORYz2IomLNwbSZxDEIfGCXx/sDMUYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736681895; c=relaxed/simple;
	bh=Hu6sj4YlNIIq1o19KtqVt8sq2Hf+2qUtX/5DmW9NxHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WMKtpMfgJwGXuOCqZAcI3kLv2xbALar6Xdc7AU6v+53BamR1kTkO/3gccFq7B6gqd3GXW5aCNB1UJPVIZn7GBiLTNh3x8EYjRxXXVdRtt3aaanA1Hk5N/23nX3OCLeJrBowXqTaneB80O33H1Blzu2jYQtmd607FKhGwHsnlMBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GA+7W1f5; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21649a7bcdcso55827335ad.1;
        Sun, 12 Jan 2025 03:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736681894; x=1737286694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLjMFqMa0MLBHoGjYV+ZgrPN+yneWJOf3SVcKyDiUGI=;
        b=GA+7W1f5KMgK7+a+KEiZO0gf2Rc+A3SCKy8MwCWWDz2AsVTf0l1MUtgUGFvzaFet9f
         OYOggZDF3OJRVwvKs7tVXnRzwKBowt5gcqvUv5uUs/sA7vfAK4HobVtpOfiQpIAiWX2n
         VQl6XtA/OkERZ9xd7GJkisPX1w9JwTtaxNbN+9VlvqQ0fjaZxw0Qnc/5n/GLp/AewA8I
         hqHfc7D5VOtcE11AU/o2u26hdif8BzeH2b+hnPIeuhhNbK4DRqX+nQ8g8LddMHpqhJDv
         9qkrpI2g/lacFoVI22XbQAaYu9wyTbkRKltxaS/4HafV3+UqRKOFLDy9zlWoraIz2Vib
         seCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736681894; x=1737286694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLjMFqMa0MLBHoGjYV+ZgrPN+yneWJOf3SVcKyDiUGI=;
        b=eEg3zW7xdQGHdBnK5TugET/GzycCzaeka/icDb4PXPjD8yFPrlliItUDRL8Hnrt+mM
         /ltOmFXo/ieu9LN/sNyG5GfLjp10xJvPtewD8eGZSXKIAGwBY4R34ex0j26SQeBiV0BZ
         NvDipgwZYXRQHX033xB5OH1yreW4Q+umKeQ/faNtwhvbTl8i6oTW/FqS5nLtmWcTSNiL
         S/Tx8TEjEgvZk8e8nsrnz6QzruEphApC2oqDckaSUoLWEn4KeeDO62072+ekSgfFtHRw
         lkP8DF+bgLL4c75ye1DxyZfbVZynZCIBSpct8glDKO6Cg0gc/Jmjn0bKXGwnu4khgNrs
         atEw==
X-Forwarded-Encrypted: i=1; AJvYcCXDLKdIHw1Tmnc/LOBRCc3SsV323SvEUb+HJ9swpL9hga7uBuFdYk7mY3Qh7c55bu8TElqpyqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9oNvhaf7t0ABsXLs/mwMa7BwFSVw8pyuW0y3+Ad52+tn34gSh
	Fm/C4PRxd4XhyVImecp5oW8UQ5GmEp+bKFUyY2ZGjVSZyi62lY3K
X-Gm-Gg: ASbGncv/XhKSQbJ3RvIpRB3M3hl1has6eYB6LZMTNJ9pEvUv13YJtpM5Qf+5mlsbuFy
	HAKOe+vbbS7+iduV/go97067l/ChEE6sSzF3v+qCSOYKnSmXk6OyLLZSva4c8ks7lqwgrt3jOpm
	24pFbDtyr3Q4B4TDaMY49ETx6jZ+MSbtpjTic6VWHwg0v6eeZIpdFHxpJLEmsv0o45hDYLW72+L
	n+F2g1xSLLozLClPSSI+LIS+LXM6GLq6xhEMSI6ohGq9wVK1b3GMNrOTPfxCQT+nyeCTE/2UCa2
	nVxxfPVlWMrG8K3InWU=
X-Google-Smtp-Source: AGHT+IH1WWA5xu6CBh1XrDpontq1UPp/scaC/ProBgb6LrQX0jQQHvjP/0MchngwrbX/aTJQ9hU4dw==
X-Received: by 2002:a17:902:d492:b0:216:2bd7:1c2e with SMTP id d9443c01a7336-21a83f54a67mr208613255ad.18.1736681893748;
        Sun, 12 Jan 2025 03:38:13 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f253a98sm37353765ad.224.2025.01.12.03.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 03:38:13 -0800 (PST)
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
Subject: [PATCH net-next v5 03/15] bpf: introduce timestamp_used to allow UDP socket fetched in bpf prog
Date: Sun, 12 Jan 2025 19:37:36 +0800
Message-Id: <20250112113748.73504-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250112113748.73504-1-kerneljasonxing@gmail.com>
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

timestamp_used consists of two parts, one is is_fullsock, the other
one is for UDP socket which will be support in the next round.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/linux/filter.h | 1 +
 net/core/filter.c      | 4 ++--
 net/core/sock.c        | 1 +
 net/ipv4/tcp_input.c   | 2 ++
 net/ipv4/tcp_output.c  | 2 ++
 5 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index a3ea46281595..daca3fe48b8f 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1508,6 +1508,7 @@ struct bpf_sock_ops_kern {
 	void	*skb_data_end;
 	u8	op;
 	u8	is_fullsock;
+	u8	timestamp_used;
 	u8	remaining_opt_len;
 	u64	temp;			/* temp and everything after is not
 					 * initialized to 0 before calling
diff --git a/net/core/filter.c b/net/core/filter.c
index c6dd2d2e44c8..1ac996ec5e0f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -10424,10 +10424,10 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
 		}							      \
 		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(			      \
 						struct bpf_sock_ops_kern,     \
-						is_fullsock),		      \
+						timestamp_used),	      \
 				      fullsock_reg, si->src_reg,	      \
 				      offsetof(struct bpf_sock_ops_kern,      \
-					       is_fullsock));		      \
+					       timestamp_used));	      \
 		*insn++ = BPF_JMP_IMM(BPF_JEQ, fullsock_reg, 0, jmp);	      \
 		if (si->dst_reg == si->src_reg)				      \
 			*insn++ = BPF_LDX_MEM(BPF_DW, reg, si->src_reg,	      \
diff --git a/net/core/sock.c b/net/core/sock.c
index e06bcafb1b2d..dbb9326ae9d1 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -958,6 +958,7 @@ void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
 	if (sk_is_tcp(sk) && sk_fullsock(sk))
 		sock_ops.is_fullsock = 1;
 	sock_ops.sk = sk;
+	sock_ops.timestamp_used = 1;
 	__cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS);
 }
 #endif
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 4811727b8a02..cad41ad34bd5 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -169,6 +169,7 @@ static void bpf_skops_parse_hdr(struct sock *sk, struct sk_buff *skb)
 	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
 	sock_ops.op = BPF_SOCK_OPS_PARSE_HDR_OPT_CB;
 	sock_ops.is_fullsock = 1;
+	sock_ops.timestamp_used = 1;
 	sock_ops.sk = sk;
 	bpf_skops_init_skb(&sock_ops, skb, tcp_hdrlen(skb));
 
@@ -185,6 +186,7 @@ static void bpf_skops_established(struct sock *sk, int bpf_op,
 	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
 	sock_ops.op = bpf_op;
 	sock_ops.is_fullsock = 1;
+	sock_ops.timestamp_used = 1;
 	sock_ops.sk = sk;
 	/* sk with TCP_REPAIR_ON does not have skb in tcp_finish_connect */
 	if (skb)
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 0e5b9a654254..7b4d1dfd57d4 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -522,6 +522,7 @@ static void bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
 		sock_owned_by_me(sk);
 
 		sock_ops.is_fullsock = 1;
+		sock_ops.timestamp_used = 1;
 		sock_ops.sk = sk;
 	}
 
@@ -567,6 +568,7 @@ static void bpf_skops_write_hdr_opt(struct sock *sk, struct sk_buff *skb,
 		sock_owned_by_me(sk);
 
 		sock_ops.is_fullsock = 1;
+		sock_ops.timestamp_used = 1;
 		sock_ops.sk = sk;
 	}
 
-- 
2.43.5


