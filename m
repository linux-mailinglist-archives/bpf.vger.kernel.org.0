Return-Path: <bpf+bounces-50856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E88A2D584
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 11:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A34FD3AB7D8
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 10:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1CD1B3957;
	Sat,  8 Feb 2025 10:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7KgVad/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958C1192D76;
	Sat,  8 Feb 2025 10:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739010769; cv=none; b=hUz0KZHE8J0sdU/dMcVhCULThbXp/FF5zPoDwiJtVYP+Ibqt1h6naB0JcLmCgQXCD2ZD4ntFarQvOtKTyEMf9QKyg9+bdpEFgy8PYCh1eh3F/5jveDP/RrLUsn/0bqA0S3qsszF1qnIgJKI7bJrf3CUWUVhPruc9m/E+OhCYvW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739010769; c=relaxed/simple;
	bh=qebGorEVmhaLcbNODRfEQPtuqwcjndyNILJZilkRnRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TzXdvFtulnE045JO9LjPPMPZZOCmVLE28h5vBlLnrNvxAtEY+Q/rPhPoF2h8MSAQ9Y1/3CHBWK69sDuFPuE3/OonJq9hJU8+aHtI8Aw6m4jkKuZAjWxKjUrhnAaRYDHpNKaI45zlZzFMSmfAogu4+9DhWwze+tSyK87cxas0bQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7KgVad/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f40deb941so54404515ad.2;
        Sat, 08 Feb 2025 02:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739010767; x=1739615567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZ27h7SBKv7V7VURx8pxVTy3b3Nbl5mN4WLzXEPAFFc=;
        b=C7KgVad/BFju11QiGz43ScBCcqEwOvAYdddpj+TNk7hyfSqRibG9mVzT5Ju29Xwf66
         8YIp1xsVxizQMm6C1mXzg5MfErpEeqcoeHostM89hVp7saJr7pTyqTxOjFJ8yCnJdXOV
         LA5va16ZyVFeHtlNkf4tdByqQpXjNOUfpOGpl9idU+KlLkbTHfilLfE9mUwoiFPTzdaJ
         8x5smU1Djq00QTkl3C+sxwUylbndQYmE2boFCbDaBrarjl4Fw9oclTlM/r1xOLKW2m9m
         JwozLaxiXXlXIOsl42ng3T0tjTxY/y48xBdLU/kQL/3V3ODXFYQDulTNvdi7pPPtByp+
         XfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739010767; x=1739615567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZ27h7SBKv7V7VURx8pxVTy3b3Nbl5mN4WLzXEPAFFc=;
        b=QeWW+bHdj1ic+94W8qGPJ+CuBpQkYBpUrRGsb7QkSHJdSEHOUhTRTEDJJ6FsCttMm4
         QabNPzxz6L/hWCOiQ+guK4R4+mQ7tRerjrgnq3/L8c34vV9TKhSMjeWSogkXmt6m0tla
         bkwTu3Wrq/Kz9Q+Azv9482H+5m9aG+867a3xsP6zbQqiDjA12wAsUnVn+5zIbZM3Q9vY
         vg+ZyYS/MPrmJF1qptQsSGnXqhqrz8a7V/M59D+OJ6IBP9aTjx5EIHtZBOaGY2XO5vcT
         RCj+rNh5Ulpx/JVbMh2ab0gxEuvoB8M2of/nUasL0wUW2aHPdWlGddEh8YYCHh4G6Uiz
         325A==
X-Forwarded-Encrypted: i=1; AJvYcCVGb06/XLF/F3uHFqyE2cIE4qYmRbQgDqvU+Na9wmBt38N0rymta56eEVSCWacmgNFbEWTae0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT9tyI4sPTn4JDE3QKbP6eLJdVkmstm+mxn28g1D3CnQnTd0uz
	a6XFXEHAXuutFrxcVB2Em8GxBAL/dEVyrCTypoL6Laf3aR30Vkg3
X-Gm-Gg: ASbGncui4voDoIBYT+dXslitcgqSTAjhykCu88HN4opvO0z9gi0JETx9/m+HEm0LDQ3
	50P2KOoDp/KZbSiqenH77kUgq7DCEyx6KN/dhMDSBPR8Nk6rVAN1ogjEZoNRkLkdjRwh+nLnC0w
	qgaB9ym8aHAxtbl9jZ6gW+3qip8hP7sX0FLiC6/o2g//KmmbeayxhxH7BZq2+JlGNMYogdcY22o
	nfVoQOZJ4Ucj2icMwG/IA1db6d6UuILXAiY2kILVrf0mNRfWMb4cTOMNWFbEboAHCinENZzzBJd
	UxPjlsEIIqH5tqSDIJDQlS56PzVMiF5IdI0HPW5MYsjtHFZzWXIpoQ==
X-Google-Smtp-Source: AGHT+IFuXzRORga5Dmk9/L+Pxcwu+xMHqKLCGya8YJ2Rs88eamAIkwNoUBbM8v62BYkf8O24nioegA==
X-Received: by 2002:a17:903:41c7:b0:21f:6c81:f63 with SMTP id d9443c01a7336-21f6c8111aamr24510375ad.16.1739010765249;
        Sat, 08 Feb 2025 02:32:45 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653af58sm44527835ad.70.2025.02.08.02.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 02:32:44 -0800 (PST)
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
Subject: [PATCH bpf-next v9 03/12] bpf: stop unsafely accessing TCP fields in bpf callbacks
Date: Sat,  8 Feb 2025 18:32:11 +0800
Message-Id: <20250208103220.72294-4-kerneljasonxing@gmail.com>
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

The "is_locked_tcp_sock" flag is added to indicate that the callback
site has a tcp_sock locked.

Apply the new member is_locked_tcp_sock in the existing callbacks
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
 include/linux/filter.h | 1 +
 include/net/tcp.h      | 1 +
 net/core/filter.c      | 8 ++++----
 net/ipv4/tcp_input.c   | 2 ++
 net/ipv4/tcp_output.c  | 2 ++
 5 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index a3ea46281595..d36d5d5180b1 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1508,6 +1508,7 @@ struct bpf_sock_ops_kern {
 	void	*skb_data_end;
 	u8	op;
 	u8	is_fullsock;
+	u8	is_locked_tcp_sock;
 	u8	remaining_opt_len;
 	u64	temp;			/* temp and everything after is not
 					 * initialized to 0 before calling
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5b2b04835688..4c4dca59352b 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2649,6 +2649,7 @@ static inline int tcp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
 	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
 	if (sk_fullsock(sk)) {
 		sock_ops.is_fullsock = 1;
+		sock_ops.is_locked_tcp_sock = 1;
 		sock_owned_by_me(sk);
 	}
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 1c6c07507a78..8631036f6b64 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -10381,10 +10381,10 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
 		}							      \
 		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(			      \
 						struct bpf_sock_ops_kern,     \
-						is_fullsock),		      \
+						is_locked_tcp_sock),	      \
 				      fullsock_reg, si->src_reg,	      \
 				      offsetof(struct bpf_sock_ops_kern,      \
-					       is_fullsock));		      \
+					       is_locked_tcp_sock));	      \
 		*insn++ = BPF_JMP_IMM(BPF_JEQ, fullsock_reg, 0, jmp);	      \
 		if (si->dst_reg == si->src_reg)				      \
 			*insn++ = BPF_LDX_MEM(BPF_DW, reg, si->src_reg,	      \
@@ -10469,10 +10469,10 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
 					       temp));			      \
 		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(			      \
 						struct bpf_sock_ops_kern,     \
-						is_fullsock),		      \
+						is_locked_tcp_sock),	      \
 				      reg, si->dst_reg,			      \
 				      offsetof(struct bpf_sock_ops_kern,      \
-					       is_fullsock));		      \
+					       is_locked_tcp_sock));	      \
 		*insn++ = BPF_JMP_IMM(BPF_JEQ, reg, 0, 2);		      \
 		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(			      \
 						struct bpf_sock_ops_kern, sk),\
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index eb82e01da911..95733dcdfb4b 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -169,6 +169,7 @@ static void bpf_skops_parse_hdr(struct sock *sk, struct sk_buff *skb)
 	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
 	sock_ops.op = BPF_SOCK_OPS_PARSE_HDR_OPT_CB;
 	sock_ops.is_fullsock = 1;
+	sock_ops.is_locked_tcp_sock = 1;
 	sock_ops.sk = sk;
 	bpf_skops_init_skb(&sock_ops, skb, tcp_hdrlen(skb));
 
@@ -185,6 +186,7 @@ static void bpf_skops_established(struct sock *sk, int bpf_op,
 	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
 	sock_ops.op = bpf_op;
 	sock_ops.is_fullsock = 1;
+	sock_ops.is_locked_tcp_sock = 1;
 	sock_ops.sk = sk;
 	/* sk with TCP_REPAIR_ON does not have skb in tcp_finish_connect */
 	if (skb)
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 0e5b9a654254..75e935ec7916 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -522,6 +522,7 @@ static void bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
 		sock_owned_by_me(sk);
 
 		sock_ops.is_fullsock = 1;
+		sock_ops.is_locked_tcp_sock = 1;
 		sock_ops.sk = sk;
 	}
 
@@ -567,6 +568,7 @@ static void bpf_skops_write_hdr_opt(struct sock *sk, struct sk_buff *skb,
 		sock_owned_by_me(sk);
 
 		sock_ops.is_fullsock = 1;
+		sock_ops.is_locked_tcp_sock = 1;
 		sock_ops.sk = sk;
 	}
 
-- 
2.43.5


