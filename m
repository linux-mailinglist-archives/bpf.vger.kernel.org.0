Return-Path: <bpf+bounces-74658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D40C60C4E
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 23:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 456D2359B7D
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 22:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0DC25F97C;
	Sat, 15 Nov 2025 22:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y/qbIx5W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D3E259CBF
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 22:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763247403; cv=none; b=JHyqb5qJonXH6DZVlwUxHamXr5trbJ5lyYVHA1rS9qRe58v7k8coEfc01fBCSIxPx4IPih+vWFTDEszFbtQBujj1woG04epbGR31CWu7RT6NlMtZ0PxhQWz167HZXMr9yVujseIiYfpSOL/lbDB1+9XyuUy4PcPE5U53usb2mjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763247403; c=relaxed/simple;
	bh=IRddIqUtwNi+AV55PXrVdRjSup1mSpc0MTZ8UM5J3EE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QhanPoTitqI1vfslv8R62k7YwXxj324d4nUT99b+k0iVdCnPmAZXs+Rq3H0ko7yZbfZjrN5DTjHfjA17taAF+/Wm+okMTsePt2zgL5nv4lEY/aI76AjPRSD2W8xQPWjT3oHudqL5uPmoRsfMS6Uwypji+vsh7M9Ysh2LQdzJvjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y/qbIx5W; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4775ae5684fso15940055e9.1
        for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 14:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763247400; x=1763852200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kLOmfcGszNcREdllxFMniLyDC8fKR9Rrc1ubu80Dpk=;
        b=Y/qbIx5WrHBUYe2S75QwB9Dkp7/8cOzNfNURa8yCNNlm8EZ33VBXRWCzz5s9P0dH6F
         u90PjMzq9GQboLVZycmIv8uTr/CUHYxixClQStaFL9wa/3Ul463yBU+4cT61vBPirSO5
         OYDs2dQ9oZtjLdKIkg8xj9DveAjVnHlQ/TXAKdAfzs0G2hLGDFsxzzBGhvHT83L6CEwy
         jUX3/eP9cIkZiZbEH+t1dexirmicYRyuQ13U26CkEl+gBwwidHVUctGUdhh+r2hzTU8O
         Kzt4HbrlMilyW0tdEqOAB44/DQikTbkugcB6LhCFnHMQCr5Fz0zIis3tsJp/XW/j1ALl
         yOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763247400; x=1763852200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4kLOmfcGszNcREdllxFMniLyDC8fKR9Rrc1ubu80Dpk=;
        b=AJpUFG5UPz++ckjLgc+wdFSLy6f4hSV9Bcc798495BLkmhTeNxBPrGXy/KwXSpsjr1
         o8uNmSPjytwQL22+pJWAFxUbnTsww/Pc1yf6xwwUEokNCna0hPOqzZPtvi4JkHoVT5Wq
         JvqAZECBVULjiVYbmB8v3WzFkNxMfjvxVt3ZERRkA3xjItBrJtU3usEN1gCSy8IXqiWH
         GsKGgXkv/v80MTpuBOhgfaURFMpjQrEif41Fb4CQ3voGeuL1EtgkLZ4aeRQGqpdekv6L
         ywRIfYYF8U/4uPyJKD4xXZxMuC7D73H98Uri4ygAoTNXqi/t4cAFiaNVZuUxOKZCMed8
         mAfw==
X-Gm-Message-State: AOJu0YwvFOZdCWgsbfQaiFtuOsFnKEMrkf804EiAn/AdZ2C6jNHu8Okf
	snoNdfs8wI+G8MgDcY6oLfi3f8+TyNgaV1l575xZztH8s4TSQsaQ7lfSFXNcROfCGDgLiVDUwXK
	lIukVLXY=
X-Gm-Gg: ASbGncusXtsw1PE7ovKPdbyLsQy5Pm1mFM/5erYzqIMMgc3a58UPtrgcgxhDNxDJAzC
	xPiMYNvaSe4bzZrXGlwyxi0PPPfDgJBHyF+awVWsyKDY0Cn8Fs2KWkBCPV2axQreNfixs0Lxobo
	tflGHRJUf1g24w+2qeUFZZNx6jyMAX70fFGgMnT9+o3+QbPsIKsS1TVBFkqOihJ0r15gS52klG2
	Zz4alJ+IItkaPh98XJljQoVDy05uT1KecORYn1Yn4yV+3H3n1rO5pH7JkisUQD1AXkCCLilq0hE
	/op1BsvIqDDvijY+e3tWXYMq1W63+S9dQm28YkIh4dABPYUb4QO+FBs7oYDEO377c8iOYff8dMT
	Gy+NJ8NyfGVshJCqJtOM/K2C9etY89l4z6bL1x4bkoP3sEJmLK/VuCwIaAFLdNgK+pSqlRnO8bi
	N/xah2nHKDmxYNzhRmdoI/yn+lEfrm9Wx9T+4Ynf2kV1uHOyQpQQ==
X-Google-Smtp-Source: AGHT+IFLVDoqoGskZ7MybkZYq547SpmYOBch5zZQEBS6OPlqP2gwNUILqNPcLqack3TT+ywYO2yYxg==
X-Received: by 2002:a05:600c:4452:b0:477:832c:86ae with SMTP id 5b1f17b1804b1-4778fe5c755mr66428595e9.12.1763247400108;
        Sat, 15 Nov 2025 14:56:40 -0800 (PST)
Received: from F15.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ba1462c605sm6641971b3a.21.2025.11.15.14.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 14:56:38 -0800 (PST)
From: Hoyeon Lee <hoyeon.lee@suse.com>
To: bpf@vger.kernel.org
Cc: Hoyeon Lee <hoyeon.lee@suse.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Shubham Sharma <slopixelz@gmail.com>,
	Saket Kumar Bhaskar <skb99@linux.ibm.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Jordan Rife <jordan@jrife.io>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [bpf-next v1 3/5] selftests/bpf: move common TCP helpers into bpf_tracing_net.h
Date: Sun, 16 Nov 2025 07:55:38 +0900
Message-ID: <20251115225550.1086693-4-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251115225550.1086693-1-hoyeon.lee@suse.com>
References: <20251115225550.1086693-1-hoyeon.lee@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some BPF selftests contain identical copies of the min(), max(),
before(), and after() helpers. These repeated snippets are the same
across the tests and do not need to be defined separately.

Move these helpers into bpf_tracing_net.h so they can be shared by
TCP related BPF programs. This removes repeated code and keeps the
helpers in a single place.

Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
---
 tools/testing/selftests/bpf/progs/bpf_cc_cubic.c      |  9 ---------
 tools/testing/selftests/bpf/progs/bpf_cubic.c         |  7 -------
 tools/testing/selftests/bpf/progs/bpf_dctcp.c         |  6 ------
 tools/testing/selftests/bpf/progs/bpf_tracing_net.h   | 11 +++++++++++
 .../selftests/bpf/progs/tcp_ca_write_sk_pacing.c      |  2 --
 5 files changed, 11 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_cc_cubic.c b/tools/testing/selftests/bpf/progs/bpf_cc_cubic.c
index 4e51785e7606..9af19dfe4e80 100644
--- a/tools/testing/selftests/bpf/progs/bpf_cc_cubic.c
+++ b/tools/testing/selftests/bpf/progs/bpf_cc_cubic.c
@@ -22,10 +22,6 @@
 #define TCP_PACING_CA_RATIO (120)
 #define TCP_REORDERING (12)
 
-#define min(a, b) ((a) < (b) ? (a) : (b))
-#define max(a, b) ((a) > (b) ? (a) : (b))
-#define after(seq2, seq1) before(seq1, seq2)
-
 extern void cubictcp_init(struct sock *sk) __ksym;
 extern void cubictcp_cwnd_event(struct sock *sk, enum tcp_ca_event event) __ksym;
 extern __u32 cubictcp_recalc_ssthresh(struct sock *sk) __ksym;
@@ -34,11 +30,6 @@ extern __u32 tcp_reno_undo_cwnd(struct sock *sk) __ksym;
 extern void cubictcp_acked(struct sock *sk, const struct ack_sample *sample) __ksym;
 extern void cubictcp_cong_avoid(struct sock *sk, __u32 ack, __u32 acked) __ksym;
 
-static bool before(__u32 seq1, __u32 seq2)
-{
-	return (__s32)(seq1-seq2) < 0;
-}
-
 static __u64 div64_u64(__u64 dividend, __u64 divisor)
 {
 	return dividend / divisor;
diff --git a/tools/testing/selftests/bpf/progs/bpf_cubic.c b/tools/testing/selftests/bpf/progs/bpf_cubic.c
index f089faa97ae6..46fb2b37d3a7 100644
--- a/tools/testing/selftests/bpf/progs/bpf_cubic.c
+++ b/tools/testing/selftests/bpf/progs/bpf_cubic.c
@@ -20,13 +20,6 @@
 char _license[] SEC("license") = "GPL";
 
 #define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
-#define min(a, b) ((a) < (b) ? (a) : (b))
-#define max(a, b) ((a) > (b) ? (a) : (b))
-static bool before(__u32 seq1, __u32 seq2)
-{
-	return (__s32)(seq1-seq2) < 0;
-}
-#define after(seq2, seq1) 	before(seq1, seq2)
 
 extern __u32 tcp_slow_start(struct tcp_sock *tp, __u32 acked) __ksym;
 extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) __ksym;
diff --git a/tools/testing/selftests/bpf/progs/bpf_dctcp.c b/tools/testing/selftests/bpf/progs/bpf_dctcp.c
index 32c511bcd60b..1cc83140849f 100644
--- a/tools/testing/selftests/bpf/progs/bpf_dctcp.c
+++ b/tools/testing/selftests/bpf/progs/bpf_dctcp.c
@@ -13,16 +13,10 @@
 #ifndef EBUSY
 #define EBUSY 16
 #endif
-#define min(a, b) ((a) < (b) ? (a) : (b))
-#define max(a, b) ((a) > (b) ? (a) : (b))
 #define min_not_zero(x, y) ({			\
 	typeof(x) __x = (x);			\
 	typeof(y) __y = (y);			\
 	__x == 0 ? __y : ((__y == 0) ? __x : min(__x, __y)); })
-static bool before(__u32 seq1, __u32 seq2)
-{
-	return (__s32)(seq1-seq2) < 0;
-}
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
index 17db400f0e0d..39e98e16c113 100644
--- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
+++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
@@ -5,6 +5,17 @@
 #include <vmlinux.h>
 #include <bpf/bpf_core_read.h>
 
+#define min(a, b) ((a) < (b) ? (a) : (b))
+#define max(a, b) ((a) > (b) ? (a) : (b))
+
+static inline bool before(__u32 seq1, __u32 seq2)
+{
+	return (__s32)(seq1 - seq2) < 0;
+}
+
+#define after(seq2, seq1) before(seq1, seq2)
+
+
 #define AF_INET			2
 #define AF_INET6		10
 
diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_write_sk_pacing.c b/tools/testing/selftests/bpf/progs/tcp_ca_write_sk_pacing.c
index a58b5194fc89..022291f21dfb 100644
--- a/tools/testing/selftests/bpf/progs/tcp_ca_write_sk_pacing.c
+++ b/tools/testing/selftests/bpf/progs/tcp_ca_write_sk_pacing.c
@@ -8,8 +8,6 @@ char _license[] SEC("license") = "GPL";
 
 #define USEC_PER_SEC 1000000UL
 
-#define min(a, b) ((a) < (b) ? (a) : (b))
-
 static unsigned int tcp_left_out(const struct tcp_sock *tp)
 {
 	return tp->sacked_out + tp->lost_out;
-- 
2.51.1


