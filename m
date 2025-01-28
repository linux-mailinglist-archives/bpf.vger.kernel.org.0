Return-Path: <bpf+bounces-49932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCFEA20671
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 09:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F88E7A56E6
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 08:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889451DF731;
	Tue, 28 Jan 2025 08:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AORW5FDB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999F21E521;
	Tue, 28 Jan 2025 08:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738054004; cv=none; b=m5QkMRWNoM8zuVnhrtNcVatdXiXVX+ePmmJZR/W0RNmUAYAueHRkCYGjVeFnYfDoHdqm3BIX2CCFMmbw8XTfGNKHLx8XOpWH9JYLxZ3w9WoUK4GD6XeXmrsWigNQekTS7M/xWxwu9GFKU8hQFv/fgz3fz7gfcTGilqI8y218WGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738054004; c=relaxed/simple;
	bh=wrbYn3EK4NGao4rFHvVEf04A0D3Y5+FtZCFu0/lzvec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZnsJSFXgbC52e1/qlUKBb3RwB0Ub851Oyt9h+jBtrjxc325/aZXvfa5XS8inovfqvt3xy6/trJWgCFV6zjhfOV51XsSCKXI7fNUsa/Nm7eyrvsKXHTllhiZAF/jdgrQw6xusCM9Z97nzKAuJASwq02a7bmOKjkQnlDaCNS+pQNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AORW5FDB; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-216401de828so97129535ad.3;
        Tue, 28 Jan 2025 00:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738054002; x=1738658802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEQ9weNA2CyTmGDk3/BYG9T6+PKgmDlsp/plMw8ftEE=;
        b=AORW5FDBOFFNi24d+PUbxMYhu9ud9siEhSoLHiqxOLfM/oIxXfUwYKzs6dF07ASRhT
         UXdlOLWLoZPU2S/lDtN4Ss2E+ur/F6AKEUdbsnbcKpC3EG9QlMw7Ud0y7UGbXmtK4iis
         qVKVA9P9GknqYh9ft7xKxi59YxiAverIL4LZw8tu2YRF5JFle34yh+5n2wTO9zly6M97
         oj48ybQgej3uRJ+dFnm7JDcj9CQgj4VCYxWBs57CrNAu9pwZfZBAyyVmD7nu9/8ufThy
         lRKbMLTmihy4grZ8Dwa06uqiE2o0uckax049wuBRti9SZtpXPtkFfZjP8KlgDL5d/bRA
         zl/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738054002; x=1738658802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEQ9weNA2CyTmGDk3/BYG9T6+PKgmDlsp/plMw8ftEE=;
        b=m6rJrIs82joetgujfgXPsJ2Q+3ZoKLMdf4P2nvzni4of9URwrXL4dt9qyzZlHcR6q1
         Zg1LrIx5rXHA4/a5jw6HCNhUIU8UZcmRdQhmN+lemeVtrZw4IluN7yPYXgMW34ndrRvx
         HwNU3m+akkuwvIeAePi5dOEn8I3S3oEOiBUDJqvSrMCCTp6ToU01rQdR/VE3BcfGz2Km
         e994dSLeyqXMBq/48FOsXSHcoICqdCUDAcYgzvPHDRSeyFNnlqc5fRoyRkBp+3UcX1J2
         RDZbDQdsQdJWV36xMff9IuL2/+ZIm8odLACv5Djy5sfxWl5y6O0iT6bHw0DQ1pWsdjlH
         Zh7g==
X-Forwarded-Encrypted: i=1; AJvYcCUoNrl0zXf5b0nWfKDqe6EWeJHgrwWLvE3GVEhrp53zGGCKFQxnIdZL39BQ22ghP8DQBK/gQvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1QG9gUPYXx+tPbKXt6Z9uj/zXRfZ23/OTKvdK6ggGoMPn2dy9
	wWIgfOwrh1TY2X4sgaY/TUFjgaPIKcoCrqLEzbD+HnXh0FxATUBBs3bBSTTVs50=
X-Gm-Gg: ASbGncu7cybuaoznl1la7H/hq0mBxxpDZNkvFOZPyH3uYD9rbkc3MUsMpfAxlxpeKJG
	GhiagP4vIOXFMtoiPf1vG8vkZ93w6Y/U/wKPJO8iiraxYG+F7TlVk9hpDMqBBt1NczlmK0O5HnI
	ojPyn2h61d5ZolrfcR/CcvcdjJYI/R0y3XkX4JPBuNuE6PCIFfl5ULckSybHTjRWNjF+wZ162GF
	Ir1uqTdIcS2U6HCoAuD+3lRxIZW6CstkZ3fC091ERWJ9bFvMWYFrLU4NrDHCXIcspYxRgb+HVU0
	4AeTUP1LA8PkTYyYcDXHijrhtV6xs7lRcSkfX4EZj70tbax72C4mag==
X-Google-Smtp-Source: AGHT+IF4hUdT+Q2G6c+vUpbwu9O87JppL5I67ZUk3t65MgkG6I3J6peyc1vWRpImgLU05TvzYAY5fA==
X-Received: by 2002:a17:902:d48f:b0:216:282d:c697 with SMTP id d9443c01a7336-21c35544097mr616315645ad.27.1738054001706;
        Tue, 28 Jan 2025 00:46:41 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414e2b8sm75873275ad.205.2025.01.28.00.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 00:46:41 -0800 (PST)
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
Subject: [PATCH bpf-next v7 01/13] net-timestamp: add support for bpf_setsockopt()
Date: Tue, 28 Jan 2025 16:46:08 +0800
Message-Id: <20250128084620.57547-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250128084620.57547-1-kerneljasonxing@gmail.com>
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
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
 include/net/sock.h             |  3 +++
 include/uapi/linux/bpf.h       |  8 ++++++++
 net/core/filter.c              | 23 +++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  1 +
 4 files changed, 35 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 8036b3b79cd8..7916982343c6 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -303,6 +303,7 @@ struct sk_filter;
   *	@sk_stamp: time stamp of last packet received
   *	@sk_stamp_seq: lock for accessing sk_stamp on 32 bit architectures only
   *	@sk_tsflags: SO_TIMESTAMPING flags
+  *	@sk_bpf_cb_flags: used in bpf_setsockopt()
   *	@sk_use_task_frag: allow sk_page_frag() to use current->task_frag.
   *			   Sockets that can be used under memory reclaim should
   *			   set this to false.
@@ -445,6 +446,8 @@ struct sock {
 	u32			sk_reserved_mem;
 	int			sk_forward_alloc;
 	u32			sk_tsflags;
+#define SK_BPF_CB_FLAG_TEST(SK, FLAG) ((SK)->sk_bpf_cb_flags & (FLAG))
+	u32			sk_bpf_cb_flags;
 	__cacheline_group_end(sock_write_rxtx);
 
 	__cacheline_group_begin(sock_write_tx);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 2acf9b336371..6116eb3d1515 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6913,6 +6913,13 @@ enum {
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
@@ -7091,6 +7098,7 @@ enum {
 	TCP_BPF_SYN_IP		= 1006, /* Copy the IP[46] and TCP header */
 	TCP_BPF_SYN_MAC         = 1007, /* Copy the MAC, IP[46], and TCP header */
 	TCP_BPF_SOCK_OPS_CB_FLAGS = 1008, /* Get or Set TCP sock ops flags */
+	SK_BPF_CB_FLAGS		= 1009, /* Used to set socket bpf flags */
 };
 
 enum {
diff --git a/net/core/filter.c b/net/core/filter.c
index 2ec162dd83c4..1c6c07507a78 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5222,6 +5222,25 @@ static const struct bpf_func_proto bpf_get_socket_uid_proto = {
 	.arg1_type      = ARG_PTR_TO_CTX,
 };
 
+static int sk_bpf_set_get_cb_flags(struct sock *sk, char *optval, bool getopt)
+{
+	u32 sk_bpf_cb_flags;
+
+	if (getopt) {
+		*(u32 *)optval = sk->sk_bpf_cb_flags;
+		return 0;
+	}
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
@@ -5238,6 +5257,7 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
 	case SO_MAX_PACING_RATE:
 	case SO_BINDTOIFINDEX:
 	case SO_TXREHASH:
+	case SK_BPF_CB_FLAGS:
 		if (*optlen != sizeof(int))
 			return -EINVAL;
 		break;
@@ -5247,6 +5267,9 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
 		return -EINVAL;
 	}
 
+	if (optname == SK_BPF_CB_FLAGS)
+		return sk_bpf_set_get_cb_flags(sk, optval, getopt);
+
 	if (getopt) {
 		if (optname == SO_BINDTODEVICE)
 			return -EINVAL;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 2acf9b336371..70366f74ef4e 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7091,6 +7091,7 @@ enum {
 	TCP_BPF_SYN_IP		= 1006, /* Copy the IP[46] and TCP header */
 	TCP_BPF_SYN_MAC         = 1007, /* Copy the MAC, IP[46], and TCP header */
 	TCP_BPF_SOCK_OPS_CB_FLAGS = 1008, /* Get or Set TCP sock ops flags */
+	SK_BPF_CB_FLAGS		= 1009, /* Used to set socket bpf flags */
 };
 
 enum {
-- 
2.43.5


