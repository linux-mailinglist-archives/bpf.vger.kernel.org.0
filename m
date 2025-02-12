Return-Path: <bpf+bounces-51210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94220A31E8F
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 07:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 307201884202
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 06:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCC31FBCB9;
	Wed, 12 Feb 2025 06:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mlkf/oTq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685FC1DF751;
	Wed, 12 Feb 2025 06:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341164; cv=none; b=U1gle/VXxa61ThthTWA1WVUqavtB3pE/IKX5xk2UNi1N/KEZRMBFCn1ilZb7uRyvogtH4/OYzSTbm3tKK0cu1oU6dG1f7G8ym7SvWTwqiO72UIyDQY6AiWKLs0sutLpj8sr38ugNGCp3Nr26Nv7qlvYQISieBB1haNBtwdReeBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341164; c=relaxed/simple;
	bh=bKrm1hiTC/nINgvY+o1Fo1gLAQbsMuznKHX0Uw3gAzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b9Dfwk+QDP3TNHvKMGiEuvFQLUBzinwepL3bW07/LNtazlwyglm8xudGEvPdsEvt+0rsFDaOxSHH6ZG7Qwqv6rNkqp5jzCmKFqBAiXB0C11bBQlhXq1Sh3/BSzexpsCZ5J0tze0jPNMhDdHzQsG5xW07fHSw/KJ3lmh1n0rN6sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mlkf/oTq; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21fa56e1583so45681235ad.3;
        Tue, 11 Feb 2025 22:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739341161; x=1739945961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Alr0Cy5SCB+CgKRZoduXfthZLgwnrJQ/3rmN5eLpq4=;
        b=Mlkf/oTqgJZ2Zm1hyQXPWW02IQWbdHAeTb4lDOY/i/BwxgALWfyiptF9LGZTBsmAR8
         J+5NiVJws1ASQ4ojq9ACGX76niAGGdoWNmLGtKohpnEP0eROlBOBx+qb95Ft+ju8Xub9
         wpwP0TX7kRjaMUaz1/MczAKRhOnXwNU4msYhjdt+6bsgWt19d3ABF1XDLqTcffVdp+DR
         wjKba1yxWoutBf+8oahVVz5jWX2LpTYf5QFurqPjilWYNKYDmKxHzF+vmG49DAfsJ0Xk
         yPi3JmyEN253d7uCVxyjhi8lQsO2svxQ2cwFX8/G/AZKk8eeOc1ob0oA9LzsV52yzX3H
         8uMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739341161; x=1739945961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Alr0Cy5SCB+CgKRZoduXfthZLgwnrJQ/3rmN5eLpq4=;
        b=rjbiE6IY34fGBJcaltynEbAy+fHt7gwtW/oTQDEy1GfH8Wd8mosDw8omEZ11ddqGRs
         4QH0jk28u7/AhSstzJymzTSy7KzzbgxLwARxlDbZ3CuvqI+DGoRlKVqOE/W32xLrz5DY
         qoRtgDoczNvqn7rmFUd/dKSUx1BSPF1L1LeBvbDI6dwVH6EuwYZRPuCMLCSRZBwilHh+
         xBITNKze5iuJj12Ud5t2FPedGvm96y42+5Me5jcdRy3T8oDM3CvyMcwZ5NnOAf9bk97S
         9jmVvfk3hcHM4ejAkkJccgRqx+z+l+69JexFwVXQOCVeAJo7JOcnu1yyUNtQF93708Yb
         1SGg==
X-Forwarded-Encrypted: i=1; AJvYcCVYcMjjf+bwlia1mbumM3yLOrchTfxL/mBhSIggGgOl1/TC6ahwKMVRMsGmqcdohgvJ/jTC3OA=@vger.kernel.org
X-Gm-Message-State: AOJu0YypLVrzDKRHL9AHK4H4Zim5lKY+sTOJrXpNrIJQsXllhboSA+m4
	QERc6/mW6d04sCx+nw+JucIsQ4sP5PSji1yA0heHPvSG7dFOCPF5
X-Gm-Gg: ASbGnctL8L1UjZyGEdJeVu9fyiFNtqRnMZ7Znr29q3UEwQf8uP+QSeg3naWtYLAZTPB
	Rd+6y0E7IXYWvRMKJxu+3D1p+0aewH9VAXejZxdrR3eI8LaQG60f+MAUg1X2YenqTBxonqStLOh
	Q2pjgLLu+riRlYIGcRpx2IQvuomzP/oKcxtp3Rszo99H/x6DzCR56+FOz9DMftpuuztHq58Mbgk
	fnyqV2KkxezHIemySgBtWBml2ZXDvcWamZpJJTydhS+Cb01E2LxGDPFS8/8JPhRwqpjYZ7mFzkr
	nuv5W+ujWK0+LSnOe6Ft4R0sgvkNaTC6qojj9uxiJ4olheCedBFLa3Bo1KUTy6o=
X-Google-Smtp-Source: AGHT+IFTSpDEuSPC+UeZdAEwTY9ll8uNzhdZ6C/JkSNebRPmpV8HU+/ocw97ZKfEdB6A0LiK9Q0J9g==
X-Received: by 2002:a17:902:f786:b0:21f:3e2d:7d35 with SMTP id d9443c01a7336-220bbad5edcmr39078345ad.15.1739341161535;
        Tue, 11 Feb 2025 22:19:21 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683dac7sm105277835ad.142.2025.02.11.22.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 22:19:21 -0800 (PST)
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
Subject: [PATCH bpf-next v10 03/12] bpf: prevent unsafe access to the sock fields in the BPF timestamping callback
Date: Wed, 12 Feb 2025 14:18:46 +0800
Message-Id: <20250212061855.71154-4-kerneljasonxing@gmail.com>
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


