Return-Path: <bpf+bounces-57450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB72AAB755
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 08:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6951C06C39
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 06:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FA3385CA3;
	Tue,  6 May 2025 00:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYMJn4W7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED722EFB8F;
	Mon,  5 May 2025 23:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486660; cv=none; b=l976VYO8W6HYZzO1153fB8/nTc2A9FOOxSqcKxAXyigjusixRChuS9ULvhJiEQiQuP/badJ6KakM1yblsc4gq7BREgDdMi3+wtHWZkjd213Slr3dmwK0NLOGKdrs4Fh0qdcVzXbeTE3oafp5qErJHUY9JTmdN5RvVyIlZC6g4B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486660; c=relaxed/simple;
	bh=sp0Bc0d0L61Rb4tMpOoh/ccLekA5iIagdLOTWh7AADM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UoisCY/WLNJGjjawytxgpOOuV1NupqfCXVjJ8VR/Y8HalTOj3iJKR6L1jkjqTaeZbR3j/kkaR0+ycGUf/uC47i1t3/0cONqIxwCQPKLEqoEtfLDGaa8UMwfDIgAPjk/pNu402VsYV4k0deYmQ4cu8wvsDQMbg+xUw4ucRh08qDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYMJn4W7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A9BC4CEE4;
	Mon,  5 May 2025 23:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486660;
	bh=sp0Bc0d0L61Rb4tMpOoh/ccLekA5iIagdLOTWh7AADM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CYMJn4W7A3Mbl5RXCFy+UlCuw+3n0ZVngZXHpgp6RZNnudUJp3SNHX+zrYpKhFXwC
	 lJJ33KwP/ByauP7bQ7RUkQwddIHZqlpAMIfb4fnuBMDjV/C3/XdD+HeXsdAoOuVD+8
	 juJpZg0Gx/ABn1i+ZyFmWX21neulIL3pzJTDPIXdIMLoQp9ByyNc2RrQQwsyPCXQgl
	 OWxNfIZWZNtt15Oi2B8cWfUhRveaDP8T2HAZN8KpP/j1XkamPQ8J98d1c1oI7mSKJh
	 EwGxxTbdKXpuDnYmc61w6ZCvfCBfBSAuVxVzxqjGbM51Q6FQm0OJmfK72ko5WE0wio
	 kjPDpEVsT1/zw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kerneljasonxing@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	edumazet@google.com,
	ncardwell@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	martin.lau@linux.dev,
	dsahern@kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 142/212] bpf: Prevent unsafe access to the sock fields in the BPF timestamping callback
Date: Mon,  5 May 2025 19:05:14 -0400
Message-Id: <20250505230624.2692522-142-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Jason Xing <kerneljasonxing@gmail.com>

[ Upstream commit fd93eaffb3f977b23bc0a48d4c8616e654fcf133 ]

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
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://patch.msgid.link/20250220072940.99994-4-kerneljasonxing@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/filter.h | 1 +
 include/net/tcp.h      | 1 +
 net/core/filter.c      | 8 ++++----
 net/ipv4/tcp_input.c   | 2 ++
 net/ipv4/tcp_output.c  | 2 ++
 5 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index f3ef1a8965bb2..09cc8fb735f02 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1319,6 +1319,7 @@ struct bpf_sock_ops_kern {
 	void	*skb_data_end;
 	u8	op;
 	u8	is_fullsock;
+	u8	is_locked_tcp_sock;
 	u8	remaining_opt_len;
 	u64	temp;			/* temp and everything after is not
 					 * initialized to 0 before calling
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 83e0362e3b721..63caa3181dfe6 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2409,6 +2409,7 @@ static inline int tcp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
 	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
 	if (sk_fullsock(sk)) {
 		sock_ops.is_fullsock = 1;
+		sock_ops.is_locked_tcp_sock = 1;
 		sock_owned_by_me(sk);
 	}
 
diff --git a/net/core/filter.c b/net/core/filter.c
index d713696d0832a..abf489c2ed102 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -10239,10 +10239,10 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
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
@@ -10327,10 +10327,10 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
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
index db1a99df29d55..16f4a41a068e4 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -168,6 +168,7 @@ static void bpf_skops_parse_hdr(struct sock *sk, struct sk_buff *skb)
 	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
 	sock_ops.op = BPF_SOCK_OPS_PARSE_HDR_OPT_CB;
 	sock_ops.is_fullsock = 1;
+	sock_ops.is_locked_tcp_sock = 1;
 	sock_ops.sk = sk;
 	bpf_skops_init_skb(&sock_ops, skb, tcp_hdrlen(skb));
 
@@ -184,6 +185,7 @@ static void bpf_skops_established(struct sock *sk, int bpf_op,
 	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
 	sock_ops.op = bpf_op;
 	sock_ops.is_fullsock = 1;
+	sock_ops.is_locked_tcp_sock = 1;
 	sock_ops.sk = sk;
 	/* sk with TCP_REPAIR_ON does not have skb in tcp_finish_connect */
 	if (skb)
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 40568365cdb3b..2f109f1968253 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -509,6 +509,7 @@ static void bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
 		sock_owned_by_me(sk);
 
 		sock_ops.is_fullsock = 1;
+		sock_ops.is_locked_tcp_sock = 1;
 		sock_ops.sk = sk;
 	}
 
@@ -554,6 +555,7 @@ static void bpf_skops_write_hdr_opt(struct sock *sk, struct sk_buff *skb,
 		sock_owned_by_me(sk);
 
 		sock_ops.is_fullsock = 1;
+		sock_ops.is_locked_tcp_sock = 1;
 		sock_ops.sk = sk;
 	}
 
-- 
2.39.5


