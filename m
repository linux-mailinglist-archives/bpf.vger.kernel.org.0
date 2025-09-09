Return-Path: <bpf+bounces-67919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E56DB503DD
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 19:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E74724E079D
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 17:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCB43168EB;
	Tue,  9 Sep 2025 17:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="QDmmp3c5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55592393DFE
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 17:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437242; cv=none; b=VmxKc04BEHKObG1Xd3rfvTZ1r8hTZ4w5NxosITryc6EtLb2hRJMjhZzjW1K2nN7VPMba2OxoQwbNa9XUGDeOaxVxjM4aEPrfOsYURwqafoinR5ewF0nkCVUOlm4JhLRehZXXf2Soq0Z5GFRzaaOa/YrtX2YXPHf+nZpl8R8MtZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437242; c=relaxed/simple;
	bh=B+xgdr1C6P5heG8S2i0OWS0hHvUXHjG0RJEe2JSYgzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dVBxbNiUoOuUd5Nee+g1zdkN2QuA9Fl+eQVk+3goABRyKo2rQEoezjOiDyZXmfWSsRdWXmFQPU/1LupOnFa02rPtTzMs9iOURWSU2fOmky2Z7arnuIT507Fugq758OayGUzn23gtuH++dHsgiylGKuBUTFTNTBuBokN5cf6g5Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=QDmmp3c5; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b520539e95bso488962a12.3
        for <bpf@vger.kernel.org>; Tue, 09 Sep 2025 10:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1757437240; x=1758042040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZbYtl31RFVMg+mwteDyDuq5sBeGQX9ziuJeNiYcEDU=;
        b=QDmmp3c5Tb2pTR6ukn+FWKM4RzKqRq518t2nqvnnxEUPNovR17HaA8SF4GS5Vl2rVR
         7rZDvLsRIcs3KkHb2RnQaNMuM9LHXJiLVZxqbx7aL6xCvA76n4eWOTiBygyNgr8vO92/
         aUWx/gvbRn2LQf5Ii/73+edHNeAIrpr3PXca/eplHUIknDidqkINDCV+qN+b2hCRomuG
         gTOPdJeg/HqcISdVgN1Jc0PNtFwVvNBJaE1bVKPH7wOqFLu1B+k6qBlgYjrA5Pu72AG+
         jQQoe51uYEq7hwqHZJGbEJORT4r2Z3qnq/ThZ7ygLa9Sdywsp0R9U6KOueM9XxkLwym0
         MpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757437240; x=1758042040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZbYtl31RFVMg+mwteDyDuq5sBeGQX9ziuJeNiYcEDU=;
        b=qHL5aa6hKsdNdhDx/Q5uhJ8VGPlG+wW5GXEWOno2Hv70WjZNHphaFwMpsBdQnf95Np
         DAMdIH2kuNAKdrmmCf7fslesUUsTcav2+Eg6VWtTMhN1fC5VRv+8Zim+volqsskzgxwI
         q0EF7OCnGUD6IwfGmXBJ81U1GRP/RMcUPhc9w03sEhhQ1CXbBMKLFW5YJOhKrXfEuDXu
         YjUOAfhKraScBIyJAaN49cnU5JADn/16EKMlqM+gCto6HApTUKqcsc0vVGG/zltnJXh9
         rW5I1pX5BdHU6z+kER97/wxm0va2foYV/3cEt4pKgs8VVO8/12Q9iH8RHht620nszZEi
         CmSw==
X-Gm-Message-State: AOJu0YxlA7MaB/S/dJzCiMDVJ7G/J1nNEoPFF1hMUZjBDmrW5iZiy2EM
	tXX6JEazx6PSCcW8c8w66thLoLO0g2YSZynzuVUdd8dvLHUJI7sqkuhTzn1M8pAj+LJW0ExZPtr
	6QE/F
X-Gm-Gg: ASbGncs2mDwsCKvgC7tEbgDwyKNK7q52qcvcNYxAyzJ3h8rsJGi1nmK7x7Rng9r+PuC
	UBQuUStg7sdyi7n+1uL9xrA5L/H5e5iqejsVyPDP+NetoskvkRV+tyOvu3fB7DdVJYzhrGlrbgD
	fBGfL6mX0AdNubhK6+MCoQ8JJWib11ePRlr6fWDBW4VXsQeJjqB3yqYBYq+TA3pQ2tMkmSp/rhk
	TGEj5AdzrM6PD8hXzQXzlsVPzqSGl5ak4f/UIYh/eIKmiLHANklcilI37gdzPJqyFIWYoTpdAvP
	UF6IP+PAgcXodOy5jF3S2TNfdOBqa90rT51ApUaDHmQB0lxftaZ0aMaGx54B+VM2GO58J8BqSAz
	puvUnH90oYel2HHqNfyQC5PK5otLmWfarVYI=
X-Google-Smtp-Source: AGHT+IGNNKlrgLR3E3621uDnNOGb4wdM44wDiJfalszkhDOOpsc7b3dy05YSpCtEISg6/6h9sEO4SQ==
X-Received: by 2002:a05:6a20:1585:b0:245:ff00:5315 with SMTP id adf61e73a8af0-25344bcb6fbmr10583845637.3.1757437240125;
        Tue, 09 Sep 2025 10:00:40 -0700 (PDT)
Received: from t14.. ([104.133.198.228])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a6a814esm251733a12.29.2025.09.09.10.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 10:00:39 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Aditi Ghag <aditi.ghag@isovalent.com>
Subject: [RFC PATCH bpf-next 11/14] bpf: Introduce BPF_SOCK_OPS_UDP_CONNECTED_CB
Date: Tue,  9 Sep 2025 10:00:05 -0700
Message-ID: <20250909170011.239356-12-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909170011.239356-1-jordan@jrife.io>
References: <20250909170011.239356-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the BPF_SOCK_OPS_UDP_CONNECTED_CB callback as a sockops hook where
connected UDP sockets can be inserted into a socket map. This is
invoked on calls to connect() for UDP sockets right after the socket is
hashed. Together with the next patch, this provides the missing piece
allowing us to fully manage the contents of a socket hash in an
environment where we want to keep track of all UDP and TCP sockets
connected to some backend.

is_locked_tcp_sock was recently introduced in [1] to prevent access to
TCP-specific socket fields in contexts where the socket lock isn't held.
This patch extends the use of this field to prevent access to these
fields in UDP socket contexts.

Note: Technically, there should be nothing preventing the use of
      bpf_sock_ops_setsockopt() and bpf_sock_ops_getsockopt() in this
      context, but I've avoided removing the is_locked_tcp_sock_ops()
      guard from these helpers for now to keep the changes in this patch
      series more focused.

[1]: https://lore.kernel.org/all/20250220072940.99994-4-kerneljasonxing@gmail.com/

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 include/net/udp.h              | 43 ++++++++++++++++++++++++++++++++++
 include/uapi/linux/bpf.h       |  3 +++
 net/ipv4/udp.c                 |  1 +
 net/ipv6/udp.c                 |  1 +
 tools/include/uapi/linux/bpf.h |  3 +++
 5 files changed, 51 insertions(+)

diff --git a/include/net/udp.h b/include/net/udp.h
index e2af3bda90c9..0f55c489e90f 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -18,6 +18,7 @@
 #ifndef _UDP_H
 #define _UDP_H
 
+#include <linux/filter.h>
 #include <linux/list.h>
 #include <linux/bug.h>
 #include <net/inet_sock.h>
@@ -25,6 +26,7 @@
 #include <net/sock.h>
 #include <net/snmp.h>
 #include <net/ip.h>
+#include <linux/bpf-cgroup.h>
 #include <linux/ipv6.h>
 #include <linux/seq_file.h>
 #include <linux/poll.h>
@@ -661,4 +663,45 @@ struct sk_psock;
 int udp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore);
 #endif
 
+#ifdef CONFIG_BPF
+
+/* Call BPF_SOCK_OPS program that returns an int. If the return value
+ * is < 0, then the BPF op failed (for example if the loaded BPF
+ * program does not support the chosen operation or there is no BPF
+ * program loaded).
+ */
+static inline int udp_call_bpf(struct sock *sk, int op)
+{
+	struct bpf_sock_ops_kern sock_ops;
+	int ret;
+
+	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
+	if (sk_fullsock(sk)) {
+		sock_ops.is_fullsock = 1;
+		/* sock_ops.is_locked_tcp_sock not set. This prevents
+		 * access to TCP-specific fields.
+		 */
+		sock_owned_by_me(sk);
+	}
+
+	sock_ops.sk = sk;
+	sock_ops.op = op;
+
+	ret = BPF_CGROUP_RUN_PROG_SOCK_OPS(&sock_ops);
+	if (ret == 0)
+		ret = sock_ops.reply;
+	else
+		ret = -1;
+	return ret;
+}
+
+#else
+
+static inline int udp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
+{
+	return -EPERM;
+}
+
+#endif /* CONFIG_BPF */
+
 #endif	/* _UDP_H */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 22761dea4635..e30515af1f27 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7122,6 +7122,9 @@ enum {
 					 * sendmsg timestamp with corresponding
 					 * tskey.
 					 */
+	BPF_SOCK_OPS_UDP_CONNECTED_CB,	/* Called on connect() for UDP sockets
+					 * right after the socket is hashed.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index cc3ce0f762ec..2d51d0ead70d 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2153,6 +2153,7 @@ static int udp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	res = __ip4_datagram_connect(sk, uaddr, addr_len);
 	if (!res)
 		udp4_hash4(sk);
+	udp_call_bpf(sk, BPF_SOCK_OPS_UDP_CONNECTED_CB);
 	release_sock(sk);
 	return res;
 }
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 6a68f77da44b..304b43851e16 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1310,6 +1310,7 @@ static int udpv6_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	res = __ip6_datagram_connect(sk, uaddr, addr_len);
 	if (!res)
 		udp6_hash4(sk);
+	udp_call_bpf(sk, BPF_SOCK_OPS_UDP_CONNECTED_CB);
 	release_sock(sk);
 	return res;
 }
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 22761dea4635..e30515af1f27 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7122,6 +7122,9 @@ enum {
 					 * sendmsg timestamp with corresponding
 					 * tskey.
 					 */
+	BPF_SOCK_OPS_UDP_CONNECTED_CB,	/* Called on connect() for UDP sockets
+					 * right after the socket is hashed.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.43.0


