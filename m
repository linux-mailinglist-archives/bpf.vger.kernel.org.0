Return-Path: <bpf+bounces-52050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C47A3D245
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 08:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D181891683
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 07:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E39B1E98E1;
	Thu, 20 Feb 2025 07:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fh2xQ3mD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919E21E284C;
	Thu, 20 Feb 2025 07:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036610; cv=none; b=Jb4K4tPW3eTbkzLSZfEiBzGVsUF2Dta4WqDkI85FY8eCuMOeIjcLEdvTT7x3bNuCdsLHrJkTKzjWqlv0ppcGQO835aR71wYdXXjw85dbGVCdwkbDmTaEFeVTOXimfr+sua6XKwvF1KI454J/e3XTN2OuybzEd22+kBjoVjtf8XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036610; c=relaxed/simple;
	bh=bKrm1hiTC/nINgvY+o1Fo1gLAQbsMuznKHX0Uw3gAzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O2nNP0uWZ5JGYmpm+t3iMBhEQdqXJgGT7P0osvI0T+GrXIAFtHsZad55M0ufWIFf4HdzlZyriQVKCpTRpUA4wBq54sKFJoXAmL9lB+kSL48u26vWkl/9mjWIj7dTR+0gLbBbt4bMynW3Mfq3yeTq8/E4b+c66N0eeAv/bMgYVhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fh2xQ3mD; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22114b800f7so9743895ad.2;
        Wed, 19 Feb 2025 23:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740036608; x=1740641408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Alr0Cy5SCB+CgKRZoduXfthZLgwnrJQ/3rmN5eLpq4=;
        b=Fh2xQ3mDa/MMZjI5EDxwzKddTE4uiGhBf9HqP/5GsPE0dP/ulQszc4sGdSceihTNRf
         SI+pIzWmsSY60afyTABInnOdaN1yiGlr3d9a9JTX8m4dHcDoFKRUMITrDokrRvWeiRnY
         LZUztoH6ew97jmQJXVeMlmj8//pP9VSxZK4h6Po28o5K8+HUVXQ3+fsvGsO8BySeokRT
         N+vkdbIAJwTQDBTyhkQeN9tFUJ84c2ErLQZ3K3LUoXGPVwZWu4eHFj0nb9Z87WWAKApA
         W2Wo9aHzr3Y1LtBb/44q/3vHPOkbhpAn+346doI7WtaCO7lU3nX66w0RcLWWLhpaXa0M
         Fw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740036608; x=1740641408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Alr0Cy5SCB+CgKRZoduXfthZLgwnrJQ/3rmN5eLpq4=;
        b=ibUXuKFLoa2Bx/DI7aC1lPqeOtf5u+eWNmEAu9LdNax0KdY4QtlQVx1x7zfutn39g5
         TWw1kMNUytzWpvD03kwYFe0EE8g0Y/KT8G5KvSBwaKUhTQjalDP6U6hItelNV50Ryt32
         zeqdGpwN/E3pnpKEx5Yu+i5VqiTyvaNYyxTTn1MaTHszi7E7hBrMmeqZNa028b+krtDv
         HR/5NiFw9lf8jN3d4cF47wY4rRh6qpfnB6E4pL2Iy2hpC8vCBqpiNHuGgK7mnXoctgm3
         C18MyDurkG+ui34RMY3M1ubM/KGW7t9vmvqrivadgkekmm4ZTSq0+BhxW5LZ+va8eCJf
         CtMA==
X-Forwarded-Encrypted: i=1; AJvYcCXk2QRqXtLyHqPDEpHt/umJ6FCFnXAX2ce05txbUPUgAQzkBm/fCmraGXdS7kWPaOgtfskgMPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHUY45l2ON3QPXaUfPpYxdvVLkixu0xH2xPKOIxvFawzwJlgDV
	FvIrfQkAAIuyc+wS+36B4EUDKtWn9sNIShWjWLnEcKVJzUfRA793
X-Gm-Gg: ASbGnctthoFjMHlN+JjbnFkJ6AAmzzhlN4SzmdYgFFm6/V3wZDmkhNGX1jluq6RaZYw
	8spxp6ULB9cVZYQoiaj4UmvTXeUTUqw6SGTrHrO44pcVjVvD1rpCP1BsBpimOTglqVCOMZSjgEJ
	xwSj+mJ1UVOrpSz+ps7kvLcmqOtPK/eKVbvrRsSNOsuuXx+cdcPkViu14mEfq6Xg+3dzWx9XVpn
	7ra0+k7ewrtz22TCjoSYLk9bEds/YG39C/iMx5Nc6/CTIX1tQ6SoC96mQPoU/b0f7rhLUI9lf1X
	Bqi8Z3XxOfGbVxMef1QFl0GRyjQGCFkACzya4LJ4NY0+7OKe+14KpJWfuh3auyk=
X-Google-Smtp-Source: AGHT+IGeuTfgjjKCKKNs1GfIXAWrCK1qBRWUji+A3MTCHLcWC12oGHFwZubGg5tJU0HfOCPFTvgQCw==
X-Received: by 2002:a17:902:d2c7:b0:21f:1ae1:dd26 with SMTP id d9443c01a7336-221711d2158mr96571615ad.52.1740036607689;
        Wed, 19 Feb 2025 23:30:07 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d643sm114048205ad.126.2025.02.19.23.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 23:30:07 -0800 (PST)
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
Subject: [PATCH bpf-next v13 03/12] bpf: prevent unsafe access to the sock fields in the BPF timestamping callback
Date: Thu, 20 Feb 2025 15:29:31 +0800
Message-Id: <20250220072940.99994-4-kerneljasonxing@gmail.com>
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

The subsequent patch will implement BPF TX timestamping. It will
call the sockops BPF program without holding the sock lock.

This breaks the current assumption that all sock ops programs will
hold the sock lock. The sock's fields of the uapi's bpf_sock_ops
requires this assumption.

To address this, a new "u8 is_locked_tcp_sock;" field is added. This
patch sets it in the current sock_ops callbacks. The "is_fullsock"
test is then replaced by the "is_locked_tcp_sock" test during
sock_ops_convert_ctx_access().

The new TX timestamping callbacks added in the subsequent patch will
not have this set. This will prevent unsafe access from the new
timestamping callbacks.

Potentially, we could allow read-only access. However, this would
require identifying which callback is read-safe-only and also requires
additional BPF instruction rewrites in the covert_ctx. Since the BPF
program can always read everything from a socket (e.g., by using
bpf_core_cast), this patch keeps it simple and disables all read
and write access to any socket fields through the bpf_sock_ops
UAPI from the new TX timestamping callback.

Moreover, note that some of the fields in bpf_sock_ops are specific
to tcp_sock, and sock_ops currently only supports tcp_sock. In
the future, UDP timestamping will be added, which will also break
this assumption. The same idea used in this patch will be reused.
Considering that the current sock_ops only supports tcp_sock, the
variable is named is_locked_"tcp"_sock.

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
index bc95d2a5924f..a0e779bdbc6b 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -525,6 +525,7 @@ static void bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
 		sock_owned_by_me(sk);
 
 		sock_ops.is_fullsock = 1;
+		sock_ops.is_locked_tcp_sock = 1;
 		sock_ops.sk = sk;
 	}
 
@@ -570,6 +571,7 @@ static void bpf_skops_write_hdr_opt(struct sock *sk, struct sk_buff *skb,
 		sock_owned_by_me(sk);
 
 		sock_ops.is_fullsock = 1;
+		sock_ops.is_locked_tcp_sock = 1;
 		sock_ops.sk = sk;
 	}
 
-- 
2.43.5


