Return-Path: <bpf+bounces-48640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DE4A0A895
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 12:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDBDC3A7C8B
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 11:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23C71B0F0A;
	Sun, 12 Jan 2025 11:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3aNfVeQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE20E1B0414;
	Sun, 12 Jan 2025 11:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736681886; cv=none; b=dkDw8DfFt4BQ3usHdjBYFP5rS4L8m968RiY/dUbOIX6qE6sddnAcWHkGQOv82lUBvKTFbXPrOGYLSStupCObwc++ZsrirUfxpAdxXW9yA5NZLg3VuExHvn6FSm6lYaLXmgtZ1CWshqkO9ynoVkYc9uRJQ0fiye3Q2RfQGG06I18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736681886; c=relaxed/simple;
	bh=RRpZglcOlW8NN6fN7Q6AK8rJjj/4vJD+11jGR8UY25U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WSK23m7EzjynVMJLoVOd1zUpnF6eOGWh29TsGwYDwLDqBiwxdyNpioxTlJ39wTmfTd/ZPldthqfzwb7xGwNmdoxd4uMmTxR9vOHt/EyB3wgVgjwuHDmNq1X2adpJUP+QomfshRBV0fQfVAoW7WYjuJMBwbOtukrjY4uWhNRrB/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3aNfVeQ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2163bd70069so60247125ad.0;
        Sun, 12 Jan 2025 03:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736681883; x=1737286683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMU+F6/bCdP+GeYqX6gdZ9HGbY39WxXn7I6MkDtModU=;
        b=I3aNfVeQwlKgjXrYH0EkOvifp1aHHq/lUcIpjyBbHWSYdKhuBf37L95UuPXSPBogBm
         xWgL2ew/QQg5RPP0MgBIs3a9lgnnj9uwPax8jIM1sppWNhAGIxlDm5bWHKEaQVTbL7Kr
         sgk/4/yM5DSO2dcYJW9JlhWEMLGiNejdPQlzcxHl0v/Pjy+Ie7hvfOofPdsBQSbkfD9z
         RV7dB4GLhq84vpYxNOeyy1RW0jJneSEk0db5d3p0+6xuby/Trz4QN0yUKkz8eLBiy+fv
         6v+pUlBK4s8YfB989O6nt1I+NvkCJrK33iA1/888gBJK6Og4CbOkh4W2tss4pYXquVfo
         j08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736681883; x=1737286683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMU+F6/bCdP+GeYqX6gdZ9HGbY39WxXn7I6MkDtModU=;
        b=tHzssgIIhWyXan36D9gAG46zc1SmvuJiz8iCZR3t+dzdKXAd0/HJHCRJtN8ChNq5dp
         xgNETg3JxY8E20IrvC96/XOziJ6DCKnf8MxEuuJo8LpQ1Gd5/VkNLK2AXme+a8llvsPK
         sz4PzX7Ysm72/vFJyRCMhDhy85uYUCbLZ2DYhj6p4BmXaD/hfYtAj2dqM0mzjqASXxZR
         lBL5yeB5u/u8nv4IIjJbqq4b3mIrsTt3OC5wqgL1+6rBuQb1OJMwIFBp9COwYukVpSfz
         RoqG0E2jA1cjcdiaeb6Q91iQSHLu73MAPBpR7USTcDRmz5isNd+PStwBJrRfiS52BgqM
         Ayiw==
X-Forwarded-Encrypted: i=1; AJvYcCX72SsPWEk7adPPTBphZFxxisM/ZmfZ9CSqAXZNv7iZ1uPyMaMSCkctn2MX+mp4wwl7HCUa9Og=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/coFDTVHS8HQEQoEjQfrkwiRlmci//Uh38z9lFdl072tAD1my
	D+8C+LpNxClUGCYqQn+wsF/zlwpwaw6hokN/wPzD3DcB2EWpFUYw
X-Gm-Gg: ASbGncsHRQEE25If8OaDHRLOrrMFkdVuwk60oRePhXvEvjf5lX4rc03IVTciHAlEA0E
	E3XgD8Ust3JFIAOUBa4Hj+r9d95Z0/Wz50Pkx18jmyO0AG2ij9fCc9E2mrR5LIgYv2jFgdgjMzf
	M/84+f6s6cvIsOTi/fZcvC3juP5vbITD6ODWqTKam9EQIg69Sg9vk6FfKQ0fiovb7n7Lf3uMyOo
	fNgVFfm8GM0nTXAOyAAJzHjo9uedG2wNR8jvvp/HlZXEEuZh9bdmsGWXeLQFIc4kgcAHnwjGTdt
	38cTzJuVJXDOMzMnT7U=
X-Google-Smtp-Source: AGHT+IFnzAJjZgFipwRCRhTT6utuLtxBPG8K/7SVXAy6NfTeh1S9HsDsUneBzyn3VhSrJJNdzvo31w==
X-Received: by 2002:a17:902:ec83:b0:215:e98c:c5d9 with SMTP id d9443c01a7336-21a83f57012mr195677035ad.18.1736681882977;
        Sun, 12 Jan 2025 03:38:02 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f253a98sm37353765ad.224.2025.01.12.03.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 03:38:02 -0800 (PST)
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
Subject: [PATCH net-next v5 01/15] net-timestamp: add support for bpf_setsockopt()
Date: Sun, 12 Jan 2025 19:37:34 +0800
Message-Id: <20250112113748.73504-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250112113748.73504-1-kerneljasonxing@gmail.com>
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Users can write the following code to enable the bpf extension:
bpf_setsockopt(skops, SOL_SOCKET, SK_BPF_CB_FLAGS, &flags, sizeof(flags));

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/net/sock.h             |  7 +++++++
 include/uapi/linux/bpf.h       |  8 ++++++++
 net/core/filter.c              | 25 +++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  1 +
 4 files changed, 41 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index ccf86c8a7a8a..f5447b4b78fd 100644
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
index b957cf57299e..c6dd2d2e44c8 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5222,6 +5222,23 @@ static const struct bpf_func_proto bpf_get_socket_uid_proto = {
 	.arg1_type      = ARG_PTR_TO_CTX,
 };
 
+static int sk_bpf_set_cb_flags(struct sock *sk, char *optval, bool getopt)
+{
+	u32 sk_bpf_cb_flags;
+
+	if (getopt)
+		return -EINVAL;
+
+	sk_bpf_cb_flags = *(u32 *)optval;
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
@@ -5238,6 +5255,7 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
 	case SO_MAX_PACING_RATE:
 	case SO_BINDTOIFINDEX:
 	case SO_TXREHASH:
+	case SK_BPF_CB_FLAGS:
 		if (*optlen != sizeof(int))
 			return -EINVAL;
 		break;
@@ -5247,6 +5265,13 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
 		return -EINVAL;
 	}
 
+	if (optname == SK_BPF_CB_FLAGS)
+#ifdef CONFIG_BPF_SYSCALL
+		return sk_bpf_set_cb_flags(sk, optval, getopt);
+#else
+		return -EINVAL;
+#endif
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
2.43.5


