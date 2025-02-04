Return-Path: <bpf+bounces-50442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1558BA279C9
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 19:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E6157A2995
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 18:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4439C217F33;
	Tue,  4 Feb 2025 18:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnEf2Il5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A1415252D;
	Tue,  4 Feb 2025 18:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738693852; cv=none; b=KsOaGgL7odcs7kckIHA4Ik4hi9dXh82tTT4zPF590spSs0RlTFLocTCzYuZbobNWzjvA3OAOOmUUWqCvjPGNsG3NSOgwbOvzkS53pMym80v0+shUokOwVfwtEuvlylj+RTJndPyMjSAuGJqKE5mu9/izscl0McKEwEJrvm/D5x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738693852; c=relaxed/simple;
	bh=MLD9T3qwxPtVejKczEo2KAlFAckOD1gc6Qklzlst2CA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G7wZQmhuZDMw3lx9bsJP/g4Sdw3JKQBUx/jkdMaJwPK689spei4dSbW/1dzmB7xevc83a6pqSVo4+KtXAya+IjIZuCsc/YDzD3HLp7EvpgaTtIb6jvgXWhE3RU8lWnEmyafIedHBs7bbDHX/zmEV4J9cpCMQ2l5VRxJW/frSbO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnEf2Il5; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso845527a91.1;
        Tue, 04 Feb 2025 10:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738693850; x=1739298650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWstQy3dCNpqCO9EXUugHvZBlUNMHzyCKni0JRwI1IE=;
        b=UnEf2Il51sT0IxNTfBjNRk0uI3n0RFQ7VyivD2EqV28PX4+GuyECs1IpzvAlHSPz87
         Clxzwijn/zFurz4rydvcdHRWtnOGuMZUC7CO2/tDKJvUu+W83IT2g+5GPlxgA84gwA8d
         YUrBtJbDb+mL4WJUcQBPjhtbKofZtIV5B7JSzfJ/MgyDWjYsqIOmKS6fS87cDX2qV5oR
         JAG4orEoS/jrBZVj8B3CrMLHfIxhmZjRR9YO1sdeIvnxejMgof9Y4Cn9/i0Wu1tQbh5O
         W0PwcL3LzofEzR3vvyFF8xIzN2X3z02V4uruf5vHhGt/erp4d/s93c7a7oIXD77BMLOY
         UZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738693850; x=1739298650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWstQy3dCNpqCO9EXUugHvZBlUNMHzyCKni0JRwI1IE=;
        b=nySkdBo+22SVS8JPgsTHd8O0jxqmZM3CdXBaxSTwh9F1lfssRP52vfjLoIqfqehd4Q
         OTWMUUSaX2czd1IyRfy/pCc4HwkU8S+Bd/cyQ5R4tGS/2X0wqrl4F1T+XwLpnaKoigQy
         lQL4/WMKSGoHROun1fskGm5QDyN8g3gWhar6Wh7mmH7ysbsxpxKaBh4C9hyxVrvkdmC7
         sblZNMX0H5WmYL/HfY93vmsP4z8YAqFRt2PUj95a56YIK17DWi1HMT6yeqgdPjcWRSZH
         0KAIn0FDiXihymJym8Pgsq8sOX6j/NsYynYVWeGWfI7VYQPhFCFeEvQ7dwfX8Z2D8zMw
         noog==
X-Forwarded-Encrypted: i=1; AJvYcCX7ZDGoHnC88jGnAWBPJSR2uwQx25UOy5USylg4IPUUz7osLtAa8fLuneiAltvcf6biVBEvCqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfLcT35oXYj2XwUaz1SFUhnAjsEnQ2OdxPMUAaEUh3sGO/Rd9n
	HqEV4ap7m6Pe1BNwQ4PnVVLqVk5TOPghGvzMIl7xlJF8IDT0wudk
X-Gm-Gg: ASbGncsSHjLpoSXR2lhRbgFH2xKvop7Hif2Ky5oK8vNsa1p6fUonmSrbYsLI+0d5Lpu
	Oy/5VSCS/3JjRvgBrwM9bta+lTKkkJZX1yXgdUVJ7VPsmOoKVJ2pokdckhiO5tawiNzNLChtSHy
	JBm8kIaeIxSk8yun9Frq5fij6TTAi2n7MD6Nx3eQ7WuH3V1UdbldqtY374wugpZh3tiLrAdExSh
	di+KDOWkBxryosmfim47Cpvqt77dULWJfDpTXEZHSN7ajQxP6e+N4IVK+NYra9FPPY3/tvGLEHf
	qd/SziC6Qm3T2ss1OtYrlqT1luE73z6jt5js808zl88W3P0DseX1iA==
X-Google-Smtp-Source: AGHT+IF9ZZK3TXsoVwWuewKkZZcnV5TTDgRhxYuLjTDzXvZXUaApMvJg7FlTWd5Penkc+fmCq1PGGw==
X-Received: by 2002:a17:90a:c2c5:b0:2ef:2d9f:8e55 with SMTP id 98e67ed59e1d1-2f83abdf0fdmr44421512a91.17.1738693850389;
        Tue, 04 Feb 2025 10:30:50 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f848a99a45sm11590591a91.38.2025.02.04.10.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 10:30:50 -0800 (PST)
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
Subject: [PATCH bpf-next v8 03/12] bpf: stop unsafely accessing TCP fields in bpf callbacks
Date: Wed,  5 Feb 2025 02:30:15 +0800
Message-Id: <20250204183024.87508-4-kerneljasonxing@gmail.com>
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

The "allow_tcp_access" flag is added to indicate that the callback
site has a tcp_sock locked.

Applying the new member allow_tcp_access in the existing callbacks
where is_fullsock is set to 1 can stop UDP socket accessing struct
tcp_sock and stop TCP socket without sk lock protecting does the
similar thing, or else it could be catastrophe leading to panic.

To keep it simple, instead of distinguishing between read and write
access, users aren't allowed all read/write access to the tcp_sock
through the older bpf_sock_ops ctx. The new timestamping callbacks
can use newer helpers to read everything from a sk (e.g. bpf_core_cast),
so nothing is lost.

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


