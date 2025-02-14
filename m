Return-Path: <bpf+bounces-51493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F35FA35357
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 02:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8BCF3ABDC9
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 01:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E115228;
	Fri, 14 Feb 2025 01:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XG6lZ5Wm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C06825776;
	Fri, 14 Feb 2025 01:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739494855; cv=none; b=hlqgb6zN48zH61OGchvQ4r02dPc8Ss07boRh3N9o5XEzoxCnJCuoj7mA8l0W3LRhmK6kygR74KdlrykT484aMikeLsLLIjkzeVUtZKbm3lEJr83jIEnnu/fIOI/+lKp+53hMKFcrJQn1qEN+wLwP4znp/6wrXexSbt5Hn5dEtKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739494855; c=relaxed/simple;
	bh=DDtM+vZerkMryfJ9Kp2UIWhKVpj3cuPoaYpevaSK4/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VkB5uN+eO5RKjOObnNuqDqWLz2hHLnth5OMtoxMINNSlu6Z+cEhgyg6z0ibtu33qB6oAN1uazzqxIIJmYodS6+Vk+BYiZ3XXA6cxZDTJOlRKJBkjLObQ1BSZkGQks83w+s0AhWZM8/bvjwkcUCK0E3dsD2kfsiGjIVY1ZM6XKPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XG6lZ5Wm; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220ca204d04so19744365ad.0;
        Thu, 13 Feb 2025 17:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739494853; x=1740099653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kfb9GI6feOAbgYzfRSzf+rdXBFIMELjuaFO2C7wE51E=;
        b=XG6lZ5WmFezJqitLS+VXrDGDmqQRdjkDcLN4n6AQZ8hjnhmwrlOxUL+5JhghpzzJNl
         UoxBFUzSMgDi1O4Zu+1Q5aA9o1R9oUG3TmG2QnzyusBoXZRd5gsV82YpOMkFk2aSAkev
         zOfUDtIPd4SrkqX63zzAr85sXI6dHtB53ongq5hD4Que+9KA5CWSkIo+Jkv+hfCU3kVT
         9it3dSHNPOmredP9H/mDSl7CQaVeLdlZm82ksENy1by6lSbeGK77Z0iFPLl+eKLYiT0J
         l1i+jxrdaAsCK9G133QCHgTzhDn85rQUhsDBXmlHlfwnLSYENp/vv6eqfMcuanWkbK8s
         raqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739494853; x=1740099653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kfb9GI6feOAbgYzfRSzf+rdXBFIMELjuaFO2C7wE51E=;
        b=VrslZUtrUgYEWT6KpfdixewQH4aUacvFC85P3ga0g69vLzkybcFmIIfqH5kyQFRF9A
         hsa6pfjjhBUWpmDwAgVkXUklqjfHHT8rOxsT8sijyyYGbCiVGf+LxHJByQZ3Gr/b23fG
         IVOaAeyFhu7F2rd81eCPHjufy32YDox6C3sAqrC+MaCYNayHPyecQK0GcTzTyX2SHnQU
         3vZanQTVQmy7dGnZ5SyYIcRS39qayNiokdfTPPLrFO/vSSyMrS+gjB8thuCksQNsv9jC
         Tw91e+LA54I9jjQ3TBihb9geogNVS/a3vF3eIHPIEbemehHtRf0+mcuO+8N6hjuCitHf
         lb5A==
X-Forwarded-Encrypted: i=1; AJvYcCXrmmGzRVv6Tt/nEr2V68oBbM35dWojAxbXb4XNgWjSoEhdtkPezo7nNiPAWeTtV+O3o+WGkII=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLeUT41iWMH2/7Zo2LUXrk0BkJizlEJQXHSYmPoQ5+Y45AIhu9
	KJtgRbXf0FCrPKYIlyt8A2JRl/nFYnNN0bvHhBkSRwfwgKBXTi3v
X-Gm-Gg: ASbGncvy/WiJj6BFnIQ+S9YSc387nEgj7o9fz8ox1ltlskIiI1f63RZ1KaDp/7mQcte
	BzhQDx6o4LV8GRMfelhfZS1uRW2iuVzrIrDsh8Da1dTE2OP+qD90qXOSc7d1NWN2r3zVMDsVy4d
	t5XfouJaH2OAhq/vbm7BV5tqMelOG+v4WcdtK+oag3ahREd41hiegRAsZ5wgzQH0CPgrMeTKMXM
	KpU4hphilAb7UHBP/mG6d6yTdcRr0/b2Dm1aWWtDrOzUy21lmXtIzB50rjsg9q5FBwzQ3bG0KCB
	XX7rA6/5Nd+cLw4XrY2l2MH20KrU1l7GqUJ4v2e5CFI9tD/zFzhIEw==
X-Google-Smtp-Source: AGHT+IHKaJyEf3iewG7Zn/TBw4ZB4yeBRF9Ka637mBFAvVKkNBi7xb7XsFHJqY1Ldr9pVYZROMYm5Q==
X-Received: by 2002:a17:903:950:b0:220:e63c:5b08 with SMTP id d9443c01a7336-220e63c5e07mr44086105ad.11.1739494853115;
        Thu, 13 Feb 2025 17:00:53 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d534db68sm18629565ad.39.2025.02.13.17.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 17:00:52 -0800 (PST)
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
Subject: [PATCH bpf-next v11 01/12] bpf: add networking timestamping support to bpf_get/setsockopt()
Date: Fri, 14 Feb 2025 09:00:27 +0800
Message-Id: <20250214010038.54131-2-kerneljasonxing@gmail.com>
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


