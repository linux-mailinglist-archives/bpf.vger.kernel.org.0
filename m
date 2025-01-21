Return-Path: <bpf+bounces-49317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC479A175AF
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 02:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A093A4B72
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 01:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E198D148832;
	Tue, 21 Jan 2025 01:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edWBTMw9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12105028C;
	Tue, 21 Jan 2025 01:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737422970; cv=none; b=c1fY/+czYYBtGPXxPuW6qm1yUVWoRSKDIdmMIDs+MFTfFDsvw0yxal5IFmDArNRdvVyE4fvi5M2z0SPdv0q9aMKQgkuxduaPmlFMj9F8iGPtbhYSZ9R/N6Lblv240IVyoULqJIqsmXfcmdH2HnHOFNNmGCVxIeokV7JQ2/O9syk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737422970; c=relaxed/simple;
	bh=Mt2YWj/OjScewMDsPH2Ntvpf2c4snwR3Pvqpb/tvsRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i54DFARfSCSorCqRf5gR3+stfnVBySGhzFxN0Yyx0/slPdOfSiAF5alAJJXA2TCrtsyVDRd6JvdgfG/Zt/O0gz+sw139VOeEBJw3ih3aM+SLzAHC13j/bHYpydvK1iY2SDn1cyZWxGEyWaiWbhuiBQ7Vo411VcRZwpgnlk2SWM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edWBTMw9; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2efd81c7ca4so6790256a91.2;
        Mon, 20 Jan 2025 17:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737422968; x=1738027768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4VJSRGKihhLslplbWEU790/b3AShcED91qmujEVpMY=;
        b=edWBTMw9mTmhHZ+K1Q+6u3rrvFWW6YhuUp4B1jzp9CPNnJrH6rGIF1sIfRP5WKjSh8
         4niZKgV3gNVjTPajEmzT9tN/nnbBcgC+InWX4XGDTRVadD/LGf2v8Ct3QL6sVECUON3/
         snidCJzzzRj9zot1s4rMzNiU0ee4R7kl8AHQi16UDMXD6UGw7JHFlLi+udQDoea7cFGY
         UhBri4hjl4qvWc2h+o+sXvLb5MTKIiYm+wQHMrpCS84IZ2y5VLYBZr9wSVo9v1QSBGL/
         t3bx5jwqK+oMZCVsJiIoatbZikIVzFQjcitQwQ5y/NDzSWh4Icz8A02lx/9a43GzrvnX
         SUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737422968; x=1738027768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4VJSRGKihhLslplbWEU790/b3AShcED91qmujEVpMY=;
        b=nrZtHm3/g7cJbbG+LiE2zPLfVnj2WhqJzrTxW9I1PO+9zOAVfJnteJXxXUFlhI35rr
         OfC6faCpL038kLxY75xOOPaKmWdrQWnp66k5RxDJcvalqK0dWt996/y50OEN8E6zKnss
         tAbKc3n88Z/Z2Ih+briw/Bghn6YSCqZI3Zr7j190DMxIWG44jhGbHFRoUdsZGvk2QP51
         Ua1j/pEU08O1hllaWif+3Uc75wCf4ZM0BR4yCpentd1P4VxtFg/XpyBnSv1zA55OsarT
         I7D+yEUaLhS8nCGU97trdMncepzrrmCH1H/XQ/c/0My1gwIHx4MgUf3wdpy0TZGFfUQ1
         RqXw==
X-Forwarded-Encrypted: i=1; AJvYcCWzShdhVV0xaTQpsX5e/Lsq+VgtXvcJTZdXi4+PbL5zogT4ww+ToPgkIeuSsNLtuAjiBlERVKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZWedgF1F+Z656vHFCV/1E+6MgSdrpMO21JCFd0aDayGQDaEbc
	EhbP8ysydY44iTlLXBoV/1NbUQAMNT3J2inPK4eRLmriUa9a+8PVxoSmvJbz
X-Gm-Gg: ASbGncuY8UH6EEbdXfwQ1oysVP0+ydP7fwq5B8H8vOeAhJNpHobMIPWyKALP+aapgUC
	RMXBkIJfqK7UGBrep3yllLA1lGrO9BJOEACIDCDNTXAqCitQR1AHZG3Mkp5h+7inqjgJWvcnkwV
	Wx/SJp7B35A5MdTAcOV9MxS/A9UZ77ZDKd4TzfXwnVFq9OoJK+UZQn1Ym38QNeLygjokqp6oNJ+
	EjjLV63+kkGVzkis5FTZH+37Bpp7oWQE/GcQsaQ/GdS/HvGEoT2kJRjbB7gIo8UZbK/qkRTTNc+
	hFN2VSPht9oqLu98lcVEChC9E1Qy/9ve
X-Google-Smtp-Source: AGHT+IETSQxYuuW7A5kfIf+9Is9ki9CU2MNKqFpuNW+SVmNCoFfcKJv1svuPWG2f0v6Wv94DCVxNEw==
X-Received: by 2002:a05:6a00:288e:b0:727:3935:dc83 with SMTP id d2e1a72fcca58-72daf950d22mr18959207b3a.10.1737422968058;
        Mon, 20 Jan 2025 17:29:28 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba55c13sm7702059b3a.129.2025.01.20.17.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 17:29:27 -0800 (PST)
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
Subject: [RFC PATCH net-next v6 03/13] bpf: stop UDP sock accessing TCP fields in bpf callbacks
Date: Tue, 21 Jan 2025 09:28:51 +0800
Message-Id: <20250121012901.87763-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250121012901.87763-1-kerneljasonxing@gmail.com>
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Applying the new member allow_tcp_access in the existing callbacks
where is_fullsock is set to 1 can help us stop UDP socket accessing
struct tcp_sock, or else it could be catastrophe leading to panic.

For now, those existing callbacks are used only for TCP. I believe
in the short run, we will have timestamping UDP callbacks support.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/linux/filter.h | 1 +
 include/net/tcp.h      | 1 +
 net/core/filter.c      | 8 ++++----
 net/ipv4/tcp_input.c   | 2 ++
 net/ipv4/tcp_output.c  | 2 ++
 5 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index a3ea46281595..1b1333a90b4a 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1508,6 +1508,7 @@ struct bpf_sock_ops_kern {
 	void	*skb_data_end;
 	u8	op;
 	u8	is_fullsock;
+	u8	allow_tcp_access;
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
index 8e2715b7ac8a..fdd305b4cfbb 100644
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


