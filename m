Return-Path: <bpf+bounces-51495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC82AA3535B
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 02:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6167C16DF8C
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 01:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0416535946;
	Fri, 14 Feb 2025 01:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyC26Fko"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D37CA64;
	Fri, 14 Feb 2025 01:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739494866; cv=none; b=PVIShaR3yMIiq3ZnihfMKZJc+vEfZq62KhE6SY8pAfwVZWj8iMpPL0/VwthrqsY4jfXmhAKwrb50qfhz14dyWB8sdLhqjgq4VQv2T0dseXLBPtz/zeO/ghe0ZgZCMIU7EQEDK3ZdrPhRXowJkipktNGP7EdKJ3nijsnOXekIEJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739494866; c=relaxed/simple;
	bh=bKrm1hiTC/nINgvY+o1Fo1gLAQbsMuznKHX0Uw3gAzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JdV/+LQ6It9vb2FFuxbV7ayWSXV57waw7sFXaX5FR3aZ3Mt3BCxQRWiDw8K2F1Irf/pdb/3gEuC0aoL7MKkcXXbAq6f8eTnE7DGL3x608ckcdOeeptsQaXREjhA51rWbAnlblDV2sDPExxF6p3gYL8fZDwzpmpc6oJk9x5ETiQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyC26Fko; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220e83d65e5so13857475ad.1;
        Thu, 13 Feb 2025 17:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739494864; x=1740099664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Alr0Cy5SCB+CgKRZoduXfthZLgwnrJQ/3rmN5eLpq4=;
        b=JyC26FkodYCdv3HUuWo1ZKXqqeaoF28UI2KFdQoAFVxA0BL42jwl9LTZxwhBy9mO0G
         x1jlfWNaKrVRL/1G0EXrHp7BSkAnCB2iRcuVUcJk4LJ5DyOOaOHgekPYs2lPX0k/6GMz
         pZKCRdj9CBvQXaDIk0ERitPG+WmvXiOrjhEjOMLYnYtzwZwkyoA2mfPniRjyJaN+U6Kw
         cJv5ULcxf6ajh3xV+qlfd9h84A4rjcxjaE0Pb2yc+/JXGVbO6faSfAkzdFIylxk6xptw
         USXn//hpGPPOy/PAGKC38YPliOdzd/xXqC/JPGlXvh+gZxiM+htj1k/remHXLrtriwD4
         ucHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739494864; x=1740099664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Alr0Cy5SCB+CgKRZoduXfthZLgwnrJQ/3rmN5eLpq4=;
        b=k2i21Vpgzg8CqQ0Y3fAWlG0zpfpqNAjyBWo/cBe9u2ohafA5PZAQb8v8BeesQ2cVWq
         EXe463D8yFZGbeb7hy1xyy2S/FK90XBp4ty/A0hAt1UWWubF0Z86b3lexrujTirLq8cD
         YWBIg5smAQ+CLhjyG2N6yi1hdsFu6nMKOiEacRJpNLK6DQAS2/ZvBsdJsweeQOkjvv0Y
         RxhV8sccUX9usVRdhoQBNJhQIrVZpx1ePFJWEBr+P064Rd3MVN7igDqHbokyoyNewZpP
         v7+RjDimI2hDLusUR5dnfZnzDk82tq+iavAGzKYc+yTHLi7rzNfj9i9GgM12sgn+3BU5
         CKXA==
X-Forwarded-Encrypted: i=1; AJvYcCUI8NnBI58VIk8tOH71G+rpcNnHEYbXJjMrpt55xAT7PKjIn8DA3Va82u1mNEv4b9IlDFqg2B4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEBAUNbHscYjBgn4LinKUs60dt2drI0qLMfWGIWuUJacFStGWC
	YEldCBY9Q5vzO6anVIsownCUPbBDoRlbZdORYUa0qJtEmo8bpFjs
X-Gm-Gg: ASbGncs67V8cy6/R+IzZl26nrJtUdmrW9H2c9MlNS/ULi7p7eQ2NCHDUebK3yajMjk2
	LvC0QekgoFyH9odaifEtXn7wAM+0npG26hwP4pT6vPI+enE/ExOQKZvRUvx7ewnhJITI0p/yY3I
	phdgsZcK2rgnSDlsDMCEJYUzgR0ZQegrSgvgIjsMMzNQOVbE2o6zCPncxnE95LudlXr+QqGFzcx
	Mu7wP/8gcUFJDty1PXQ/ztmqg+XFrZTUA6q0iCOWRxyPoU4rXfIs0/LDzzkK+wsFvHXC4i17zEA
	yEnwTqrD+U5MoOKw3qWWANf4Q79n4yiISDTels02ZMc0cz68vY0IKA==
X-Google-Smtp-Source: AGHT+IHWxFAE42zfVksUmAwqklSodiqbmsiv5SWUoCRrl3vqWza/iZQq7H6+SoJgcp/MOSyPgd/8Qg==
X-Received: by 2002:a17:902:dac6:b0:220:da88:2009 with SMTP id d9443c01a7336-220da8820d6mr59346725ad.45.1739494863937;
        Thu, 13 Feb 2025 17:01:03 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d534db68sm18629565ad.39.2025.02.13.17.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 17:01:03 -0800 (PST)
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
Subject: [PATCH bpf-next v11 03/12] bpf: prevent unsafe access to the sock fields in the BPF timestamping callback
Date: Fri, 14 Feb 2025 09:00:29 +0800
Message-Id: <20250214010038.54131-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250214010038.54131-1-kerneljasonxing@gmail.com>
References: <20250214010038.54131-1-kerneljasonxing@gmail.com>
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


