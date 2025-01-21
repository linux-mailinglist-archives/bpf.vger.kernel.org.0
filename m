Return-Path: <bpf+bounces-49315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 357E2A175AB
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 02:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4013B3A4854
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 01:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A317912C499;
	Tue, 21 Jan 2025 01:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inlGe7v6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F6B70814;
	Tue, 21 Jan 2025 01:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737422960; cv=none; b=OHgzbnj7F6gYkL89tgTCFjnzmcFJtv9C/1aq+IV0DP/DWR01uKUOoOmnUK8LI/xKupSROGSTzQvSTaXBMu+eBs8smUQsHvdtLG23kWAAzcnZHAM8h5u6qBHaH+2l1kuL2GMFk4uR3/OXVyyiioE5nevwA4HPIYmofnUe9Tk1+VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737422960; c=relaxed/simple;
	bh=OpVgZbTHsTj6V68AluOERUM8K5utIBu/I7orSr3m6Mg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lKXubMihzHZZ6yaJme+liGko4ybb0FGYQ+LQfwd2uoHZRLRsG6mhVOM7lM6hRVTldCo4Uis19mCNgFSQ5vq9okYDzurSYEugenMVSb/d1c195UsNj6roNQUcwwUPk2S33GZDiL7Uk0+J1xTIC92afbcQLXrC0YwDKnNblTlrNYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inlGe7v6; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21680814d42so82348915ad.2;
        Mon, 20 Jan 2025 17:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737422956; x=1738027756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktT8LCaPSw6wlCGFys9DzU2r3YJ39A8VYSOpln33MbU=;
        b=inlGe7v6U6bxdPteE4zWtADp07JKSI5sBWMk2EKlQOy/jRPos8tFo/40+HhbTazMTp
         zyCEkshOD46FoI7Wm7rYaJK287C02qekaOd4F4YCfJbEF64SOYArvZsunOeqb5RyGqVV
         zDxbeEm98eQeoQ2HZUai6mZGGRNNBkDWFhmegrrMXTnWRWNdqUllzSH58/jsMJOYOuwN
         oBoVuEs9oRYaTt/+HTZolcgkalbGAQoybKW+7pWMWyE2gakk1WbzlxxY05cXNGUpsm9V
         MZwU44neqKooRnvB2eKhDAu4VXbboC28ZIt1pmbdcFExpjsJ7z+m8d2BBIor2p/grolq
         vDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737422956; x=1738027756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktT8LCaPSw6wlCGFys9DzU2r3YJ39A8VYSOpln33MbU=;
        b=KonsZC7AJg7QLNJtsdoknKY8eyxg/HW8qcH8p6mXdexb7k/sVIBT2krZqjXa33eR+k
         F8LZxw+0qY+zeFZdzFPIVXiOq1Hm0ARhhCm2VYLCX9ZFXjYqDnRhv2dxelHaP7R89v35
         YQeB9UGuBLLOL1xn286BVlEO4LUHdOpbBHKoATjELynfZUKySGu8awPzmOU/GygQc7Uj
         7ZOlfBYLmlkbsUr7JDjCS84WbS6F0zVGcQs+WHKLlmkFk07VKDFpQVFy45t2x3fBG8RV
         jvOu0gwamTTPMTgnZP7eViIYqqNV9jLpSm0vf4MjNQqCsoagm0Dzv84LGeVruPpA4TVj
         ertA==
X-Forwarded-Encrypted: i=1; AJvYcCUvt9U4ePm8NpS10TIurKgUxENL+e6kg12EUTyC8D+gsYXeRd9gMhGNMTn0iXQT1mJr5ijeq90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/hQuERWHFIS5XlyWVWvNcREW3Rtmq4HOEQ+vGI+uNQgn8uDuO
	aPBqMSry8c5YQz4kvVRMeYDhv0TeMh6vkFS9dFnsJt00ciY8Uwuk
X-Gm-Gg: ASbGnctUMvOGJ1Gby02b6HJbxBNdBpdZOQGYRjMlP1owVoX9BBjmqX2dq5uLsaHzWt3
	o8LKXuBUvKnPOFWiAXgkVfUWGcDmP5GrWJUT1YQUDjbx24AOeuEuPxrem6SLS0Jt381Fr2An/Sd
	g8EfGSJifzSSv4DNzzuIfq3qg9SwwcWjFb3dHQ7JkdM+SerBFkE5FAKjYHN1YixXeg7/DophynD
	EyP4C4xsboHR4T27yRr87QmV1s66gR3J450KkB08BG30wCk9GwzFWVeveewKntL1cAGJcRr6tFK
	ucWXfNBT0yqsAn2OLou3PWDPvP+nQwQT
X-Google-Smtp-Source: AGHT+IEHVGeAzU0qxiATSrnfvpUNUmeygYgm4X9uQ41zIioZeY5nXJDWrhQLhVwg4nnG8WNSAxdgIQ==
X-Received: by 2002:a05:6a00:1804:b0:725:9f02:489a with SMTP id d2e1a72fcca58-72dafa8382cmr20258676b3a.17.1737422956309;
        Mon, 20 Jan 2025 17:29:16 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba55c13sm7702059b3a.129.2025.01.20.17.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 17:29:15 -0800 (PST)
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
Subject: [RFC PATCH net-next v6 01/13] net-timestamp: add support for bpf_setsockopt()
Date: Tue, 21 Jan 2025 09:28:49 +0800
Message-Id: <20250121012901.87763-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250121012901.87763-1-kerneljasonxing@gmail.com>
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
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
index 5b5996901ccc..8e2715b7ac8a 100644
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


