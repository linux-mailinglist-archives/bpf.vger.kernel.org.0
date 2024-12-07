Return-Path: <bpf+bounces-46352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE05A9E8147
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 18:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAB831667DA
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 17:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1053F14EC4B;
	Sat,  7 Dec 2024 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKFGj2Fe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162FD14600F;
	Sat,  7 Dec 2024 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733593101; cv=none; b=GnG1N5Qq3ozjNSW5QxKjw5kgvfj+61Xm8Cf6wLR/cGXzG/K61xSV21mqjFVPCKKpV27ZxgMnNOtMOnc/UGVVTvBX/QSIDIMXsxqEooBiJlPIvZcdNp53wn7Zw1fLCIiHxxeibSasp37PadwBcO886Xz8SHQlgSgcJnWpKAUHn2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733593101; c=relaxed/simple;
	bh=EAv0nRuk5iJtSgk1vb2BP6RDUY0M27mYv8F1ElXKQhY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j6g5sXxSNgjgcuuy3ZmeKTkAlF/wgCSijm/P93CBDlxmF2oa1QmmtI3FHHeRjj8ShqH4G4/f7+Igt+Pd9q3qXlpZiUbs8VG7SUBt62HSpcGQuUFgpFMs2/yGxd+tkOrHXS9v6lm7x1Cko7AnBGGuH3nYl3/r/7fpnl332ho7MGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKFGj2Fe; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ee67e9287fso2738085a91.0;
        Sat, 07 Dec 2024 09:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733593099; x=1734197899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RslnRGt5iqfI+pyUJX2gqICL9YLAn3n1Le/RRq3vWXg=;
        b=AKFGj2FeOvmNQ+qHoi6dqM6WeL1/ymkE5m2prWtO/gjBXZXNdrOSXLqMRtZWMcYQ2A
         TnAb/5xMBj+Zsa3/TC6Iwm2DkwgDEhDh4CMgYSOUR/fnnmFkPBGTrB7JIHCGaeR5HLpK
         Q40pPZH4EGdtl5dWSdhvpipyZcw5aeoM5Yo2YHuj1ESdZM6EFGq6RdWWHu3hivjMXfpZ
         qosDk4yN/QJlKstXMZM0srXyEJHoZinF5z95aczZQsKDz5etp9G/Gp3qngVXJbOBUSiA
         delrAtzqXRP12W9SuFo/0x1PC0MRwbpbg+/vvAIXt7Jbog4AFdIeihjZERbwPyRPiJuc
         rpvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733593099; x=1734197899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RslnRGt5iqfI+pyUJX2gqICL9YLAn3n1Le/RRq3vWXg=;
        b=OnqbtzbbaJL+tyrBgGsjzHxFZw/S9exgYQQqAmAXhExvyrvg4Pv8wgYBCxLbKbG9xk
         YIwMn3zA8eB65TEXu+IxgVP42DsZalBKmMoVZ6osBLkQoUstaji2fL3zcD1mgYMzvSTe
         JWKH9axPhBwRNRyAqyLhllorKVcn3pnYjo3mdpNa0zTKRn7kiLi7BnORK47L0UKoGJ0L
         Tl4TsLKQjNpqzJEbGGDnge4dlCNHGRBz7Q+xnHhXXUJOAkwpdOU8LjaEW8FQpvGPzm00
         INsRYo/YecrrWrFuJ2g8sp8mH0U6BPU+5pM4sWkRKNttdcL2ecdKIgmraPnFxHGnl39q
         2nzg==
X-Forwarded-Encrypted: i=1; AJvYcCVtNky2gsseJZOR528UVuRhw/gaw3B0rTUwFhYQflsYM1drDign87D9ZPrlP6jx00G96TPcxzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7RIiEZlou7Xsghd5RkCSfY0tvSE3RUEHZgDkW3IosvbcCUiKh
	6zQFl4NBsRTKVMAQBQVzCESXdXOLY0ZR7FLb750PZgNP2vgAJOxV
X-Gm-Gg: ASbGncsmRznHv1pjSokHFT8+YJQra4pRixWpM4Yy+iH/y4nrEhhW6jr+L9+raMq1i8G
	5mSI/zuDRHhsOpbAkorDID9G10ko6scc1eLNnCPe9bW0vilqx2aR1rs/hcL0Ng9FZDSNlUlFo57
	7/HfnzAWkmKaFErRXRZ5GUyE+xZlCKFNDSQMle0XK2BZ7g9E7cC2IE1Ck/RhzoKYOy7LtIi5YEE
	Xi82CzW8p84ht+NK+mP1MUmly0IMsx0vo1okV6Om+00YYp2359dsJg17h7Iim+Mb0EWqsmo4qLq
	HcA6ZoanjGNC
X-Google-Smtp-Source: AGHT+IFcErhHakR+9+0m3lm17hsAm48PBRS23GokGyI5MbD2z738Bqmds+kRc6sGyrIzAO38+JcH/Q==
X-Received: by 2002:a17:90b:53c5:b0:2ea:5054:6c49 with SMTP id 98e67ed59e1d1-2ef6919e613mr10841219a91.0.1733593099366;
        Sat, 07 Dec 2024 09:38:19 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2708b807sm6963793a91.43.2024.12.07.09.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 09:38:19 -0800 (PST)
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
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v4 01/11] net-timestamp: add support for bpf_setsockopt()
Date: Sun,  8 Dec 2024 01:37:53 +0800
Message-Id: <20241207173803.90744-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241207173803.90744-1-kerneljasonxing@gmail.com>
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Users can write the following code to enable the bpf extension:
bpf_setsockopt(skops, SOL_SOCKET, SK_BPF_CB_FLAGS, &flags, sizeof(flags));

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/sock.h             |  7 +++++++
 include/uapi/linux/bpf.h       |  8 ++++++++
 net/core/filter.c              | 22 ++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  1 +
 4 files changed, 38 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 7464e9f9f47c..0dd464ba9e46 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -303,6 +303,7 @@ struct sk_filter;
   *	@sk_stamp: time stamp of last packet received
   *	@sk_stamp_seq: lock for accessing sk_stamp on 32 bit architectures only
   *	@sk_tsflags: SO_TIMESTAMPING flags
+  *	@sk_bpf_cb_flags: used for bpf_setsockopt
   *	@sk_use_task_frag: allow sk_page_frag() to use current->task_frag.
   *			   Sockets that can be used under memory reclaim should
   *			   set this to false.
@@ -445,6 +446,12 @@ struct sock {
 	u32			sk_reserved_mem;
 	int			sk_forward_alloc;
 	u32			sk_tsflags;
+#ifdef CONFIG_BPF_SYSCALL
+#define SK_BPF_CB_FLAG_TEST(SK, FLAG) ((SK)->sk_bpf_cb_flags & (FLAG))
+	u32			sk_bpf_cb_flags;
+#else
+#define SK_BPF_CB_FLAG_TEST(SK, FLAG) 0
+#endif
 	__cacheline_group_end(sock_write_rxtx);
 
 	__cacheline_group_begin(sock_write_tx);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 4162afc6b5d0..e629e09b0b31 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6903,6 +6903,13 @@ enum {
 	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
 };
 
+/* Definitions for bpf_sk_cb_flags */
+enum {
+	SK_BPF_CB_TX_TIMESTAMPING	= 1<<0,
+	SK_BPF_CB_MASK			= (SK_BPF_CB_TX_TIMESTAMPING - 1) |
+					   SK_BPF_CB_TX_TIMESTAMPING
+};
+
 /* List of known BPF sock_ops operators.
  * New entries can only be added at the end
  */
@@ -7081,6 +7088,7 @@ enum {
 	TCP_BPF_SYN_IP		= 1006, /* Copy the IP[46] and TCP header */
 	TCP_BPF_SYN_MAC         = 1007, /* Copy the MAC, IP[46], and TCP header */
 	TCP_BPF_SOCK_OPS_CB_FLAGS = 1008, /* Get or Set TCP sock ops flags */
+	SK_BPF_CB_FLAGS		= 1009, /* Used to set socket bpf flags */
 };
 
 enum {
diff --git a/net/core/filter.c b/net/core/filter.c
index 6625b3f563a4..f7e9f88e09b1 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5214,6 +5214,24 @@ static const struct bpf_func_proto bpf_get_socket_uid_proto = {
 	.arg1_type      = ARG_PTR_TO_CTX,
 };
 
+static int sk_bpf_set_cb_flags(struct sock *sk, sockptr_t optval, bool getopt)
+{
+	int sk_bpf_cb_flags;
+
+	if (getopt)
+		return -EINVAL;
+
+	if (copy_from_sockptr(&sk_bpf_cb_flags, optval, sizeof(sk_bpf_cb_flags)))
+		return -EFAULT;
+
+	if (sk_bpf_cb_flags & ~SK_BPF_CB_MASK)
+		return -EINVAL;
+
+	sk->sk_bpf_cb_flags = sk_bpf_cb_flags;
+
+	return 0;
+}
+
 static int sol_socket_sockopt(struct sock *sk, int optname,
 			      char *optval, int *optlen,
 			      bool getopt)
@@ -5230,6 +5248,7 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
 	case SO_MAX_PACING_RATE:
 	case SO_BINDTOIFINDEX:
 	case SO_TXREHASH:
+	case SK_BPF_CB_FLAGS:
 		if (*optlen != sizeof(int))
 			return -EINVAL;
 		break;
@@ -5239,6 +5258,9 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
 		return -EINVAL;
 	}
 
+	if (optname == SK_BPF_CB_FLAGS)
+		return sk_bpf_set_cb_flags(sk, KERNEL_SOCKPTR(optval), getopt);
+
 	if (getopt) {
 		if (optname == SO_BINDTODEVICE)
 			return -EINVAL;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 4162afc6b5d0..6b0a5b787b12 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7081,6 +7081,7 @@ enum {
 	TCP_BPF_SYN_IP		= 1006, /* Copy the IP[46] and TCP header */
 	TCP_BPF_SYN_MAC         = 1007, /* Copy the MAC, IP[46], and TCP header */
 	TCP_BPF_SOCK_OPS_CB_FLAGS = 1008, /* Get or Set TCP sock ops flags */
+	SK_BPF_CB_FLAGS		= 1009, /* Used to set socket bpf flags */
 };
 
 enum {
-- 
2.37.3


