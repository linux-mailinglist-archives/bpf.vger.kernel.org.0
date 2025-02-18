Return-Path: <bpf+bounces-51801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DA6A39254
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 06:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 363993B2F26
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 05:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF711B0411;
	Tue, 18 Feb 2025 05:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfFjySqH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478831AE01C;
	Tue, 18 Feb 2025 05:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739854944; cv=none; b=Cgo1yPBxONL1bym5Imh12YR6Sz2uGeNyJMzqYDSOpf7xCiRJARAqsrxj7H4Ni8ETgcyFb4MvK93KLYtjTvCBtBSSm5JRjl457LDwsSVWzvB3rsmI+wFgl0HOg8y6hvzfJudJooSCI13MSpl/j9g5SssHs7+aVQ+bC9ehbJ7SygE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739854944; c=relaxed/simple;
	bh=bKrm1hiTC/nINgvY+o1Fo1gLAQbsMuznKHX0Uw3gAzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eWgfAfALewEZphw89kV4wSmmqtcsGPE1UBhXhTQOPuHAwzO6xs5/BIBwir+1fy60iODXUfWuKj/xyBFcQIjh5kJ/M2FQpQsHP88tcmgdy9tNNdW7kMAFa8ivPdE/l51i+1i4xLcT8tnYOnUbcw2bKEkpYVnaQc3jOQZKGY/TUpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfFjySqH; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220c665ef4cso73637725ad.3;
        Mon, 17 Feb 2025 21:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739854941; x=1740459741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Alr0Cy5SCB+CgKRZoduXfthZLgwnrJQ/3rmN5eLpq4=;
        b=OfFjySqHf6cMXtVeCBJBSt5E7JrhhGjhIr2iqrJm+9asTxO68ETHHjXGNSWxpkZFMI
         NbbCdGuKGXRL8YbqpIwD4MKz0YyjzU4KS9GkJkDb2BM6SH1wu5ovzPXWW9LB8X284YWs
         8zWz8OR0Kc4iNjo5JHKDAYODukWUYaYp6XxvJA1FAPSUxCKHzNdSWX7Zy1b50TnLF53E
         LeNn3X/yhENpgFfgWYOx8MvkkkZMGux29ddWf056wsS81Q2oDDNWWLaZONSDPdDM73lI
         NT1fKW8ohaB7nFAtZ8+c4z6dJOO5rQOCcrKAVM8ql+NyKvO7yrdH+puOn35whN+RPAhE
         ZMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739854941; x=1740459741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Alr0Cy5SCB+CgKRZoduXfthZLgwnrJQ/3rmN5eLpq4=;
        b=Z+uzjpyVVtcEwXFdd153Y44DMaGFYrBkKhB6FhH8Vz3ACgdN3kkWr9nPLRYIxl9F85
         n7+ydY74UnM5DWLwYlrCA0TGnXxGE7tVB725kIRW12Fnrmsa5ZQS3OCdIDZRRGaOgjiS
         RnR7oMoTh+chSVpMgpc4bHTPIGuyPUZLBeEG/H7HEFheTUFD1ISPNB0y9Yqy1HAunpKO
         4mrh64Pgi1/x0i94wvXKRnJZ8lVFZ8l/VehmKMW3EkcM85iJpRmMHHadbOGdwfwpbnYu
         oB4G6b+OSPBDFRNbB2vTudox9Ck4dPUyMqZP5CiDraw3PYW0aJJQ787NVbvCCF7wnlfq
         eDzg==
X-Forwarded-Encrypted: i=1; AJvYcCWVrZbzqUKRyWmNQEiMVGU9zk1TfSvcUpnOdCgVeldgcJsg5j/Ua869hsxagn54EohsiWwurl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyDZeylWDbDREuPSOeGM2pb8wrBn+ix85pE+S7njqYrZNODZkH
	mP6esCXWbD/i/vpms3wE+wXFa/87WFgaDTKUKKPnxxIWK92CNXyu
X-Gm-Gg: ASbGncvsIgWMCAbk+86pSxtabx09zV7sL+yv+aDIQEZbdgzn/fSxiLa5WJVwFAyEDCt
	iXN6YeHeuSagTNtpIz0yis6YemX5o0plEIXigUuQdH+NyIYO/N1wVHdACPqsqjrfS7SYjac07E6
	dv6OnOvpfw9+Pu8eqOBYJ6ybXfmqS9Yw2fsPYo6Q5lohwK+Gn9qS211nzoCadA7C80mRRrliZVJ
	znce8nk4x82FbQL9jbesS4N0HgfBjOSZh7dIndhX80Xa/aLDkS/unVMW0/Nz/eiI4hM0kOqQdWq
	tiRQpVlfppCjQ4AvYxtDjVayY3mRIlKNzJ7L+BF7ECr3+gk9S3S9hj2u/W45mNk=
X-Google-Smtp-Source: AGHT+IGaWyF5GNI0ZDtgXzpTHIDHF5EAZDNjVL9/zkUW/fyN6Nq8v8afcyhoXBQ2Evf1my7QRCfsBA==
X-Received: by 2002:a05:6a20:2d23:b0:1e1:ce4d:a144 with SMTP id adf61e73a8af0-1ee8c98f0b1mr22599545637.0.1739854941433;
        Mon, 17 Feb 2025 21:02:21 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adda5be52f1sm4337938a12.34.2025.02.17.21.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 21:02:21 -0800 (PST)
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
Subject: [PATCH bpf-next v12 03/12] bpf: prevent unsafe access to the sock fields in the BPF timestamping callback
Date: Tue, 18 Feb 2025 13:01:16 +0800
Message-Id: <20250218050125.73676-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250218050125.73676-1-kerneljasonxing@gmail.com>
References: <20250218050125.73676-1-kerneljasonxing@gmail.com>
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


