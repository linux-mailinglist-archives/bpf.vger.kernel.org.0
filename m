Return-Path: <bpf+bounces-43290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD5D9B2E79
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 12:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39401F224CD
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 11:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88861DF97C;
	Mon, 28 Oct 2024 11:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhzQqzMj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1E21DF96B;
	Mon, 28 Oct 2024 11:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730113609; cv=none; b=HKn/r2zjTDYqubKRT2vUYcnk0gNSLdr2+D8zcxKISH0O+IP7070EsFUJpnj2f3ZPNn+dpMUCRx1qbsvknF9Z6XX6FVo7KkRvrOWsyM1l0vZpAKe/bHua73OKwZsCZIn/sVj+GkQSWMz0TqZcu5BDiTuaSfMw9O0qFPYeHOXilCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730113609; c=relaxed/simple;
	bh=RWx2cq8Cr0BPhZZ/C99Z5w3kmuS5XcUTo9ioPrVfges=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jGMznzsCSI6G0w7fFjBKzeTgCxPGepYZV+auzyQIgQKd6GLyqU4lTmy3xQHqQGdUoOGC1h8MhiqvqQzFkZ05VfNLN4PPdjZB0MQwgrJrnPiAhUbj/9Syjy9bxlnFcRSFYb3eRaIkh53M3Q2QsWrrEWZ+DWUoYH4JkbICE/7QExU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhzQqzMj; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20cf3e36a76so39704355ad.0;
        Mon, 28 Oct 2024 04:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730113607; x=1730718407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyOUNRXsLlQkNpP9ouZlfMLDHIlRndz2Tp+MnGE5vek=;
        b=FhzQqzMjQAOAmFYjW+Ztwd9mTWhKhP8CIFTM6f64Cn6hKz597/11h9nhrEU+oGYDB1
         5Z+tgarZOr36icOec0ij5Xmv6FNoxvGAehn94knO9sod1hwQESs5uJXeJ/3E8vQ9NC9S
         da89f00N68AUeuJUSLMNzhWce1XO8hpEj0nJlOXVLo5/3yLhALDGDzfub8i4MjlU/q2j
         C7Kc2KEn0nmS4AOvV/MbgTHn3yfarXEH7Fq5hjdvgtymP047aD2lxfQOPNquTjk/LJAF
         JHTtmIN4zaYSyxLIibLWWk+VVNe459fzODDeg8e5qCg44pIcHV4JoLFK8uUtN1EogGP4
         cEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730113607; x=1730718407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyOUNRXsLlQkNpP9ouZlfMLDHIlRndz2Tp+MnGE5vek=;
        b=tf+ORDBO0OmnDxIDU9f4jcm19mH+YTCL9F8XHFrbQVtWPztqP+QQGQux7Xckc958bh
         PbS/V6j3acy8tjK/ZK9ptgWHvPnRroOeFsqLguk7m7vJBnnNNQf6kfszReix9WK5VOQU
         znjmC1TFAbrBsaOYRkKAOEGfXxK7t5RwViidZsA3irdJTF4OjBq3Wq8HARtHg7iiJq5z
         CfTJu/cNemwJnJedP1VPcjSkQNdkY3OW59qMIoyqaiPbSrbj7jb+dMFTEd5VaFBWmVjb
         NQodeXp0JTtc/OYhcgs+GNls68fBqThw8Blik5yPSb/3adeqewkeYnRWZ+aZG98UlczF
         IqZA==
X-Forwarded-Encrypted: i=1; AJvYcCUi/p/Yx4cN5aOQ+f8xXz3GXKStyvK9ZPoMZsHBElvmDtcbaG4r640Mu0f+gj9NxZcppjCRVkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+/g2K9Jusy9tWm34fOKsLfBZarBbQUiBuwIe9HTYHmdsrYgCL
	f1qxukt0wdKK8odz2AVYDdSKET+N3VC8sAO9V6Xi+cj1xmz5ZicK
X-Google-Smtp-Source: AGHT+IGS1bzg/gwvpIdRydLEL7OGdevQ3AmJX3ezBAQa0c7ed8W99f0SVn6zCMpst662e6jTTxfIAg==
X-Received: by 2002:a17:903:1c6:b0:20e:5777:1b8d with SMTP id d9443c01a7336-210c6ccf10dmr108030805ad.57.1730113606759;
        Mon, 28 Oct 2024 04:06:46 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc04bdb6sm48130905ad.255.2024.10.28.04.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 04:06:46 -0700 (PDT)
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
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 07/14] net-timestamp: add a new triggered point to set sk_tsflags_bpf in UDP layer
Date: Mon, 28 Oct 2024 19:05:28 +0800
Message-Id: <20241028110535.82999-8-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241028110535.82999-1-kerneljasonxing@gmail.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This patch behaves like how cmsg feature works, that is to say,
check and set on each call of udp_sendmsg before passing sk_tsflags_bpf
to cork tsflags.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/sock.h             | 1 +
 include/uapi/linux/bpf.h       | 3 +++
 net/core/skbuff.c              | 2 +-
 net/ipv4/udp.c                 | 1 +
 tools/include/uapi/linux/bpf.h | 3 +++
 5 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 062f405c744e..cf7fea456455 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2828,6 +2828,7 @@ static inline bool sk_listener_or_tw(const struct sock *sk)
 }
 
 void sock_enable_timestamp(struct sock *sk, enum sock_flags flag);
+void timestamp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args);
 int sock_recv_errqueue(struct sock *sk, struct msghdr *msg, int len, int level,
 		       int type);
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6fc3bd12b650..055ffa7c965c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7028,6 +7028,9 @@ enum {
 					 * feature is on. It indicates the
 					 * recorded timestamp.
 					 */
+	BPF_SOCK_OPS_TS_UDP_SND_CB,	/* Called when every udp_sendmsg
+					 * syscall is triggered
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 8b2a79c0fe1c..0b571306f7ea 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5622,7 +5622,7 @@ static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
 	__skb_complete_tx_timestamp(skb, sk, tstype, opt_stats);
 }
 
-static void timestamp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
+void timestamp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
 {
 	struct bpf_sock_ops_kern sock_ops;
 
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 9a20af41e272..e768421abc37 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1264,6 +1264,7 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	if (!corkreq) {
 		struct inet_cork cork;
 
+		timestamp_call_bpf(sk, BPF_SOCK_OPS_TS_UDP_SND_CB, 0, NULL);
 		skb = ip_make_skb(sk, fl4, getfrag, msg, ulen,
 				  sizeof(struct udphdr), &ipc, &rt,
 				  &cork, msg->msg_flags);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 6fc3bd12b650..055ffa7c965c 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7028,6 +7028,9 @@ enum {
 					 * feature is on. It indicates the
 					 * recorded timestamp.
 					 */
+	BPF_SOCK_OPS_TS_UDP_SND_CB,	/* Called when every udp_sendmsg
+					 * syscall is triggered
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.37.3


