Return-Path: <bpf+bounces-51799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F369A39253
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 06:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E95403B171D
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 05:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD931AF0D0;
	Tue, 18 Feb 2025 05:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bn6Q2nJ5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F05019F104;
	Tue, 18 Feb 2025 05:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739854931; cv=none; b=LXzOEbFllqhIiV4xPZjT5aMoyQW0787TQ0Wjmtw39h3ONRuIIWfujqjBaj+BD5bf9xAKe2hZ58T3FHCnqn7X+Q/BEq+xCI1PJLjc0x4vd6nBpmM8cVKR4Gp0sq6yCZCp2u66YElnF0jFbGEZCTgRIVQvetLOf300LRJ0G0ExBYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739854931; c=relaxed/simple;
	bh=DDtM+vZerkMryfJ9Kp2UIWhKVpj3cuPoaYpevaSK4/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YhNoYPY9yQI5FXwFcg+dvP5EwpAWMxbC8aerkeNJXQSn+U2vKPozedUIaKJ915ZPDTps6gKRxFincbCNGF5T2+Ylxh5MH5EzVeeWDhBAbtAQwH2Ly4Gkl5evYWcBaPuy5D7Ujwo6t33rowYxMLyfwczrutT1DFRreOuDIPyQZYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bn6Q2nJ5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220ca204d04so66637115ad.0;
        Mon, 17 Feb 2025 21:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739854929; x=1740459729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kfb9GI6feOAbgYzfRSzf+rdXBFIMELjuaFO2C7wE51E=;
        b=bn6Q2nJ5pNnwsp2fELaLM1p2dni2vTUwwbQf+xpbFoHGvxKPOI1wI0q+IFSceznGBW
         IBbL3p6rrNrwP1p0Fasr5dU9TKfylHSYMHI2OQzUOgJdvlPH+txMYSkKl32v+QgrR6tA
         LIueepxvQ2L3Xdj8lBu92d/LaHHdm5QNiH01iBmbJjN4BV5MEsdDnsg0rVzr8YbTUzAN
         15ROBCkpLDh60ev7NaoHXQtxd5QI5vF2Kd6LkS+nfATbZ48j9sx5ImNvdHg+PrU0yEIH
         cu6Qs9QpGikNNHXTizU4tKmgf5HQUXkYa4spb/lL+QUyNESZyBCGcb3VjvEmVtKKnzNw
         9IwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739854929; x=1740459729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kfb9GI6feOAbgYzfRSzf+rdXBFIMELjuaFO2C7wE51E=;
        b=ZInfXf29HwLSHQREEArEiMsEsi4yBwAgRWfbT6+7SBTVXX+EWGJRgwRBA0NgFHga47
         2cp1LbZaVPqlE2TBScfUM6jyia08QgTBoyf2wgxTqInyfdm4fnqL0DEL36Mhuu9ik8eB
         zWBB200019Gi01p1RaVe9WMt4HIRU5vPLx2h0jbOY+NOKBM0ut1s7fPYfmI7OBw/fp1p
         8RFxFy5Zre3azwZfevBm774J+9dJL0tHLA9+5w7p56283ZWPovXBAVajrhulAawqmXkd
         h2zFXKGWV1dwjk0wST2Y+C34C0+JnR9WEVHbITgwgqptej64WnC8Yj6VSfZgYjE97guL
         K64w==
X-Forwarded-Encrypted: i=1; AJvYcCXCe5avnOIRSooooy0hnDSo8v8vk4OApJqIP89NItgI5B5ixzOOCMjO0kNCC/Gn0RbR3l4qxGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0IGOdhWrFv1W6x7D9796IaOioHT6rx1x1IK4Ns/RxsX7w7MPI
	OiS8HAdvNxVqKh9on+wqtIeUwkpAyY48+F9p9jxLKgC7sB84hxbJ
X-Gm-Gg: ASbGncuNwY+XhIX516Bf7NBwGg1BWCbZ+/zsUA5vk2A+4xAwa8FN1NNIhLokGYoyeVK
	qcM8LcfQeGeU46g7lN1vl65XLrrCMm1D37fjokik5kphgjlKWb6gkwCTHfZodzWSUfQJnZ4wu2y
	wny3cac86K6QXTMtsMjc3s29pioQP9P9P/Z8u5d3kDk7uQI6FjE9bnO9LpcPIYt4m361QkoNpxg
	+HZheYZ6N2sq9xnqMclgfhZDBiCgZBLJ6Y2r5PMtG5aiD4RjyS3o71FR7AjhJx7vQzLfAr4SvG3
	4YrrrkKIB/fXZCnm4Zz69JEqMSJYZIW+9nLQx3vSFTM10kLKmpazFCQTldEdVnI=
X-Google-Smtp-Source: AGHT+IH8asg/MVoVMADaOjKCy5UOrL/BXtdMPTP4xOEZEniFcwiAze36Tys5tzX6YtzxY5REtK4lbg==
X-Received: by 2002:a05:6a20:a120:b0:1ee:7fa1:9156 with SMTP id adf61e73a8af0-1ee8cb0e995mr23992033637.3.1739854929546;
        Mon, 17 Feb 2025 21:02:09 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adda5be52f1sm4337938a12.34.2025.02.17.21.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 21:02:09 -0800 (PST)
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
Subject: [PATCH bpf-next v12 01/12] bpf: add networking timestamping support to bpf_get/setsockopt()
Date: Tue, 18 Feb 2025 13:01:14 +0800
Message-Id: <20250218050125.73676-2-kerneljasonxing@gmail.com>
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

The new SK_BPF_CB_FLAGS and new SK_BPF_CB_TX_TIMESTAMPING are
added to bpf_get/setsockopt. The later patches will implement the
BPF networking timestamping. The BPF program will use
bpf_setsockopt(SK_BPF_CB_FLAGS, SK_BPF_CB_TX_TIMESTAMPING) to
enable the BPF networking timestamping on a socket.

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
index fff6cdb8d11a..fa666d51dffe 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6916,6 +6916,13 @@ enum {
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
@@ -7094,6 +7101,7 @@ enum {
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


