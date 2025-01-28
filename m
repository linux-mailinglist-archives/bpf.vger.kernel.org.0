Return-Path: <bpf+bounces-49934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA88CA20673
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 09:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26A42168E0B
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 08:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73ED1DF98E;
	Tue, 28 Jan 2025 08:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhLa1oME"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76451DC994;
	Tue, 28 Jan 2025 08:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738054014; cv=none; b=bfwtrDnchaxmta/l6pLbB8QTW7vQlOwnjJLGA/vjifUO36QmhxgHKBVbb/gG+dd/i9dj3gXk1cQYw4Y+YMAxI9i5WbTJXIU+eCI43Eiyfv0Cson3swzQqmaX3DoU3E+GsJIXFXy/r3pZrRY7sOmbbfZi37nCs3XXgBvjhC612zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738054014; c=relaxed/simple;
	bh=M2E4pG3pbPE82kxEJw8nQ4OUbiqFhi/0Xn+Hz7M6Qgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tXdueZCum2cVTG80wREWW5R1lGuPxxJjCKIXGtLez0BbV1dFVgSGZ9Wl8Rzz+jFoma89t8K9UxiC59kU+yeKLjHfApgQGfO/670l/JfLmeV51Jfgy7x6otPYvkAbQw7bF9RlcRKGEzp5AMRcZn1fFmf3+94kV6/ZeoUHBhuiELs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhLa1oME; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-216281bc30fso19133115ad.0;
        Tue, 28 Jan 2025 00:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738054012; x=1738658812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfGMmgvbumdhb3rVXrvLEWEq/NKmW/MgCi6J1BYZIt8=;
        b=IhLa1oMEjVHQjwnVAnMnPgiBzHhNNsESmHuFAYY3g8BnLX556SujNXvlXPqEFy3Q0Q
         p3K3RHk8nLtttFJIiI5vEc5juQ6KjSiBtvx7q56X6TfaIkZeoDUtHjYbnghMqWmTUqfD
         sJOm0eEWSJ0DfeioLd1ef6W36PF0ZGIzc98UKroIfOIxBd66ijSqKixy/jp+h0umkfEx
         oAS5KxXeHJw5oObvcAtH+G+gT/9fO4a24fdJuWbqka341+vSzl1mbbkM9p6V6+WgkpGB
         br3HgqiYqbccM3jfaDQ8Uym/eb/0WtkickyYeFj2a0IcsdcHmM6WhMsYg4umDAwWIZRl
         coAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738054012; x=1738658812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfGMmgvbumdhb3rVXrvLEWEq/NKmW/MgCi6J1BYZIt8=;
        b=qjmEhishpViewrRkjr76esArjaOiQHGUCbvsZEzwThwqoDH9HGkZulMLLj+7SkOp0Z
         NvHGs1SDtWkN2vADmWkfKoZMO/VLvLX3CRcLKMF5LoypFQpi9F0NUUFdV/B6PVen+OFS
         CmLPifsySoRVFVdrlz20L3YpjKdF3iivrDwIp67utn4lQIwxcgETqS43i4PgNHP6+lwa
         6PxeGk1JZEu1EdI6Npm6GYzDC3yiiiu4DTasdMoH67Ipx3r+5HvfzL+J/qMid01J5UkV
         jBiW/LODJ3rhnkz3TI6tBj4VpSIQjLKuOZABbKWbSqux5xmP/FrIobULxp7CWV9y13Z/
         q5LA==
X-Forwarded-Encrypted: i=1; AJvYcCXAijDHZd5nCPCdk9Te1JsyF9sqcR6eLwC1aj1ZdQOdbkEzrUoJSSOAhatLjQrRZ7DbxphDCkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvvhOwjfhyzpnZ7R02AGO0ubrDa4wrXTKtHGCuI7VPA/qYtX0E
	cKFy+hqY0Aduuvt6STPpOglwJpymqpwwNaXotjYEIjKp4eiuUy05
X-Gm-Gg: ASbGncubfNi/bNTrGr3Q7s3cJZkWsT2IbUPQTZ5BVcm9GTdjuksdTczvh6LGmx4gVjh
	yP3Ljt5VMuJlOzX8UxyCuwzAKC3pQq9/b2FCJR9DIqv+kW4pztudmX7JgPMmScd37pbFjEpUKmQ
	eY883PtbmvIDgWnNNF7W3xfyEC6RllJEbjlHvPGVtHGXAm33LRlZRktND4E+9YLr9JH6d3AWs8k
	L3I5t8s5n29Nvrke26T21UyQmrTWGiQzt2wDhA9WewlnqJrvJGv5sUngNTSFEjIQQPCVlVTbSda
	A4X5A13Nh/kwg0gWK0PmkoA3jUx4PvOJulqveIDy+B+tOzBs5d5+PA==
X-Google-Smtp-Source: AGHT+IFgJjjUcQLw4Ei6BKrKXmw3ZwpIzC1uCEX4VfueXD/mftnBhrBzvhQwyx4+6hZKgLvbyNdwFQ==
X-Received: by 2002:a17:902:f681:b0:216:1cfa:2bda with SMTP id d9443c01a7336-21c3564858emr700146585ad.43.1738054012064;
        Tue, 28 Jan 2025 00:46:52 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414e2b8sm75873275ad.205.2025.01.28.00.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 00:46:51 -0800 (PST)
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
Subject: [PATCH bpf-next v7 03/13] bpf: stop unsafely accessing TCP fields in bpf callbacks
Date: Tue, 28 Jan 2025 16:46:10 +0800
Message-Id: <20250128084620.57547-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250128084620.57547-1-kerneljasonxing@gmail.com>
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "allow_tcp_access" flag is added to indicate that the callback
site has a tcp_sock locked.

Applying the new member allow_tcp_access in the existing callbacks
where is_fullsock is set to 1 can help us stop UDP socket accessing
struct tcp_sock and stop TCP socket without sk lock protecting does
the similar thing, or else it could be catastrophe leading to panic.

To keep it simple, instead of distinguishing between read and write
access, we disallow all read/write access to the tcp_sock through
the older bpf_sock_ops ctx. The new timestamping callbacks can use
newer helpers to read everything from a sk (e.g. bpf_core_cast), so
nothing is lost.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/linux/filter.h | 5 +++++
 include/net/tcp.h      | 1 +
 net/core/filter.c      | 8 ++++----
 net/ipv4/tcp_input.c   | 2 ++
 net/ipv4/tcp_output.c  | 2 ++
 5 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index a3ea46281595..1569e9f31a8c 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1508,6 +1508,11 @@ struct bpf_sock_ops_kern {
 	void	*skb_data_end;
 	u8	op;
 	u8	is_fullsock;
+	u8	allow_tcp_access;	/* Indicate that the callback site
+					 * has a tcp_sock locked. Then it
+					 * would be safe to access struct
+					 * tcp_sock.
+					 */
 	u8	remaining_opt_len;
 	u64	temp;			/* temp and everything after is not
 					 * initialized to 0 before calling
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5b2b04835688..293047694710 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2649,6 +2649,7 @@ static inline int tcp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
 	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
 	if (sk_fullsock(sk)) {
 		sock_ops.is_fullsock = 1;
+		sock_ops.allow_tcp_access = 1;
 		sock_owned_by_me(sk);
 	}
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 1c6c07507a78..dc0e67c5776a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -10381,10 +10381,10 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
 		}							      \
 		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(			      \
 						struct bpf_sock_ops_kern,     \
-						is_fullsock),		      \
+						allow_tcp_access),	      \
 				      fullsock_reg, si->src_reg,	      \
 				      offsetof(struct bpf_sock_ops_kern,      \
-					       is_fullsock));		      \
+					       allow_tcp_access));	      \
 		*insn++ = BPF_JMP_IMM(BPF_JEQ, fullsock_reg, 0, jmp);	      \
 		if (si->dst_reg == si->src_reg)				      \
 			*insn++ = BPF_LDX_MEM(BPF_DW, reg, si->src_reg,	      \
@@ -10469,10 +10469,10 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
 					       temp));			      \
 		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(			      \
 						struct bpf_sock_ops_kern,     \
-						is_fullsock),		      \
+						allow_tcp_access),	      \
 				      reg, si->dst_reg,			      \
 				      offsetof(struct bpf_sock_ops_kern,      \
-					       is_fullsock));		      \
+					       allow_tcp_access));	      \
 		*insn++ = BPF_JMP_IMM(BPF_JEQ, reg, 0, 2);		      \
 		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(			      \
 						struct bpf_sock_ops_kern, sk),\
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index eb82e01da911..77185479ed5e 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -169,6 +169,7 @@ static void bpf_skops_parse_hdr(struct sock *sk, struct sk_buff *skb)
 	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
 	sock_ops.op = BPF_SOCK_OPS_PARSE_HDR_OPT_CB;
 	sock_ops.is_fullsock = 1;
+	sock_ops.allow_tcp_access = 1;
 	sock_ops.sk = sk;
 	bpf_skops_init_skb(&sock_ops, skb, tcp_hdrlen(skb));
 
@@ -185,6 +186,7 @@ static void bpf_skops_established(struct sock *sk, int bpf_op,
 	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
 	sock_ops.op = bpf_op;
 	sock_ops.is_fullsock = 1;
+	sock_ops.allow_tcp_access = 1;
 	sock_ops.sk = sk;
 	/* sk with TCP_REPAIR_ON does not have skb in tcp_finish_connect */
 	if (skb)
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 0e5b9a654254..695749807c09 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -522,6 +522,7 @@ static void bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
 		sock_owned_by_me(sk);
 
 		sock_ops.is_fullsock = 1;
+		sock_ops.allow_tcp_access = 1;
 		sock_ops.sk = sk;
 	}
 
@@ -567,6 +568,7 @@ static void bpf_skops_write_hdr_opt(struct sock *sk, struct sk_buff *skb,
 		sock_owned_by_me(sk);
 
 		sock_ops.is_fullsock = 1;
+		sock_ops.allow_tcp_access = 1;
 		sock_ops.sk = sk;
 	}
 
-- 
2.43.5


