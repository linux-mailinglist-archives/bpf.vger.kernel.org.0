Return-Path: <bpf+bounces-51208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BB8A31E8A
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 07:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60626162F20
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 06:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAABE1FC0FF;
	Wed, 12 Feb 2025 06:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdxTRy0I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF631FBEA8;
	Wed, 12 Feb 2025 06:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341152; cv=none; b=Ya1WCEyl7PdagC8Kx8oYQHHZFbt62wZGj9gD9k02HfZ/dqIY6pPKpncr2fC6FuFm7310wijLIrRMQ+L+6HHSNZOXg7mayIBPDIqeD+xcatzw+pyKUrafRCCzv/0SptrNXFQhw91edVjuB80b1rwHGY7X8NQbM9nfzRijhAJdMck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341152; c=relaxed/simple;
	bh=DDtM+vZerkMryfJ9Kp2UIWhKVpj3cuPoaYpevaSK4/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JCm4KlpylIsbQeoahr8TiCiptoGqDA4bAa98ob9VPZcySVu9OFB4JUOTdt0/bXSDy2nO87u/W6fADRUyqf5TLHGhMVQVL1ajqti51ZLCwRVuzroH3fQ6BVZHInIYiHK9xpvK4lPIzbEC+7K8LIZbA9fB1bzP74i0cPaWz45kyAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdxTRy0I; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2f83a8afcbbso776066a91.1;
        Tue, 11 Feb 2025 22:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739341150; x=1739945950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kfb9GI6feOAbgYzfRSzf+rdXBFIMELjuaFO2C7wE51E=;
        b=TdxTRy0I0ZB5KjVSd6XSLijigXnhgEn2hXbZihiTHlll4dHyaMazblLD/cUzJMPUI2
         bvgepMjNnnj2OHSxU/LOGxz/+o8yjHnFgykpEaJg+flSxxaFG3e/301tAXA5LGaw4uRR
         rSRmxzS3KiwFHeLwd1dMQqNqhJ2gl3iJ7wK3z1whpfWQ66ZZvXMBLEhe5RRMMsXzl2yP
         Jcnm3ierwT5vJGhGM0QOaG+HES/Sr7GrFaL+ji2aqj+03u48oEiUuIBCtNbhmlbidvnr
         za4eZ5Anz9UVv0o539NbbwmMsKBOfkDZN/TFFXZnuDONjidKlNQBd5d7jgCxJRplxYbS
         Grcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739341150; x=1739945950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kfb9GI6feOAbgYzfRSzf+rdXBFIMELjuaFO2C7wE51E=;
        b=w6K6dcIdSaJqYmByvQR2yVQHIBWnBMOBAmzM/HKIttCKqv6l6mKr5JDnWF+EAdtV0P
         WWiukHsnx/9SsuviHbbmNkDu/I13pRy7oB7iCdnLsGDsocZlEsdAkxxbqGzNjbXTrbXK
         8wef+tv/dFYoCL0cYHhw9P8i8ptGx20GKfLzpovkgoUB2l4NrKKx6hdaaovVv6eyI5gF
         V1jeteIML4u8ZQJGBoDJioFKxLnNs+Oj2+5zavLodBne2Y0dyEl+PqpoRpMwM5VatMN3
         GUZB5RiVz/e2z3bvafrpaFoMjwsNCKbMcvIpM+W7OZ115flCZxAgdF6R3LSjmGxAOXOF
         BA2w==
X-Forwarded-Encrypted: i=1; AJvYcCUqWe9r9qRZ4ABKBgfIeUO+uaGlrjQwyy/O5/WKN9oJrjjo+ZCd38fGasrdVvFKwtZkjU/Hguo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEN0rfK1jrYNS2/QNfqCsvXLhqe0akDCcOLv5tEK/R6SPnn4jX
	iQ5GdDzuNtw37OxCmZl+7KV9iEjoYphinmZi8bLIHz7pHxTvWgPN
X-Gm-Gg: ASbGncv+SEIAvgYgWahtj/1jOX4BV3XG1RqnXZEgNp6c7weoG1apPwExsqq4NSWBEi4
	mTlG1+G94wtnY0EgcJpIoZhSQHthNSvYufWCM6ais2WYZkOrHHXOTxArxCM/fx/U7lR+lWT7Soq
	O4IuuN557hQUqU2wPOjJ/UoyK14EToBkyx/Imr7W6QMusx9EpYx/SGInF8d/aGeqPGWjTsxJOgN
	4LUanfe/JWnzUY/j2OOARBBXeeFMV1v/ze6WJKbdzLfWaLUoAE2btghZ/h6dc5eY7MLQ/8qSyFA
	mVkBaLRvBRl2VrbFThUlMp3xVx2lJsgXbQ99zDHnichv4zzLtEP9TWoKNh80t1M=
X-Google-Smtp-Source: AGHT+IHybyAclk3OGXQFcS5FvranU1MdMldNfqA8eSywS3KLd4M7462uDycv4+78nFedJVfU3orlTQ==
X-Received: by 2002:a17:90b:3d4c:b0:2e2:c2b0:d03e with SMTP id 98e67ed59e1d1-2fbf5c0d985mr3080294a91.5.1739341150017;
        Tue, 11 Feb 2025 22:19:10 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683dac7sm105277835ad.142.2025.02.11.22.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 22:19:09 -0800 (PST)
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
Subject: [PATCH bpf-next v10 01/12] bpf: add networking timestamping support to bpf_get/setsockopt()
Date: Wed, 12 Feb 2025 14:18:44 +0800
Message-Id: <20250212061855.71154-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250212061855.71154-1-kerneljasonxing@gmail.com>
References: <20250212061855.71154-1-kerneljasonxing@gmail.com>
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
index fff6cdb8d11a..fa666d51dffe 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6916,6 +6916,13 @@ enum {
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


