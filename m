Return-Path: <bpf+bounces-49051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 476FFA13BAD
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 15:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F863A8F29
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 14:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF49022ACE3;
	Thu, 16 Jan 2025 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XH/40w+b"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C18E2A1D1;
	Thu, 16 Jan 2025 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737036472; cv=none; b=UM8gycOYEgwykDJKyIcIP9DItRRjCrkcxaO6acHOt35X1RswXPyr/3MiZ+1+/m/Ui8ywo5GfUlBLxpyap3Gc4XoWjzQ+Ybf1TXMYbM8XNIhJ3VxkqD4E2MzxYjoLUwraYy6qMyvjJLPB/YtMAoveJLsf2H8qhU5kZ99/2G10Z0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737036472; c=relaxed/simple;
	bh=vOYUjUAyC0hHTdPQ9/AHfWTVZtlpmsfG8hcgdPX706k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5+uPTaqbj0gcpAQapK2cG9nXUiign9q04o8WXTPXxGd2wzHNFK+Eeem++LRggoFjy49rxBpMAYaWlIqnDOc2duxvQ0QBN9lAGkUOmjepXWxNoHRVxWaV/cH/ct28wq6YUZOMt5vEWkaB8gD3IMpsciQitvA7MZmeDPUJ+OrrcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XH/40w+b; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=5X2rJ
	irB0QbNMvHRFRihO2o4Ausoa1Vwp1oEwPUN/yA=; b=XH/40w+bEYFTErwK9CGV1
	1c93flJVcpbs8OleXywpmtHf1wfKIgbU8eLtmU+9oCxPSF34koalRwNMtz3skovg
	A2fsepftR7rUyANGasTmkqgr6CD9zlmvQYzYPldgsNsHTeUznbYHNk2+vveWmwy0
	cpKU2/nJhnJKC5a7XqweI0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3d5IwEolnR5IwGg--.20972S3;
	Thu, 16 Jan 2025 22:05:58 +0800 (CST)
From: Jiayuan Chen <mrpre@163.com>
To: bpf@vger.kernel.org,
	jakub@cloudflare.com,
	john.fastabend@gmail.com
Cc: netdev@vger.kernel.org,
	martin.lau@linux.dev,
	ast@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	song@kernel.org,
	andrii@kernel.org,
	mhal@rbox.co,
	yonghong.song@linux.dev,
	daniel@iogearbox.net,
	xiyou.wangcong@gmail.com,
	horms@kernel.org,
	corbet@lwn.net,
	eddyz87@gmail.com,
	cong.wang@bytedance.com,
	shuah@kernel.org,
	mykolal@fb.com,
	jolsa@kernel.org,
	haoluo@google.com,
	sdf@fomichev.me,
	kpsingh@kernel.org,
	linux-doc@vger.kernel.org,
	Jiayuan Chen <mrpre@163.com>
Subject: [PATCH bpf v7 1/5] strparser: add read_sock callback
Date: Thu, 16 Jan 2025 22:05:27 +0800
Message-ID: <20250116140531.108636-2-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250116140531.108636-1-mrpre@163.com>
References: <20250116140531.108636-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3d5IwEolnR5IwGg--.20972S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFW7Jr1xtFyrXF45AFy5Jwb_yoW5uFy5pF
	nxCa97Wr47tFy8Zan3Jr97KrWYgr1rKayUCFyFq34SyF4DGryYqFyFkr1jyF1UGr4rZFW5
	KrsxWr43Zr1DZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piAnY7UUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiDxrWp2eJEGsjEwABsA

Added a new read_sock handler, allowing users to customize read operations
instead of relying on the native socket's read_sock.

Signed-off-by: Jiayuan Chen <mrpre@163.com>
---
 Documentation/networking/strparser.rst | 11 ++++++++++-
 include/net/strparser.h                |  2 ++
 net/strparser/strparser.c              | 11 +++++++++--
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/strparser.rst b/Documentation/networking/strparser.rst
index 6cab1f74ae05..e41c18eee2f4 100644
--- a/Documentation/networking/strparser.rst
+++ b/Documentation/networking/strparser.rst
@@ -112,7 +112,7 @@ Functions
 Callbacks
 =========
 
-There are six callbacks:
+There are seven callbacks:
 
     ::
 
@@ -182,6 +182,15 @@ There are six callbacks:
     the length of the message. skb->len - offset may be greater
     then full_len since strparser does not trim the skb.
 
+    ::
+
+	int (*read_sock)(struct strparser *strp, read_descriptor_t *desc,
+                     sk_read_actor_t recv_actor);
+
+    read_sock is called when the user specify it, allowing for customized
+    read operations. If the callback is not set (NULL in strp_init) native
+    read_sock operation of the socket is used.
+
     ::
 
 	int (*read_sock_done)(struct strparser *strp, int err);
diff --git a/include/net/strparser.h b/include/net/strparser.h
index 41e2ce9e9e10..0a83010b3a64 100644
--- a/include/net/strparser.h
+++ b/include/net/strparser.h
@@ -43,6 +43,8 @@ struct strparser;
 struct strp_callbacks {
 	int (*parse_msg)(struct strparser *strp, struct sk_buff *skb);
 	void (*rcv_msg)(struct strparser *strp, struct sk_buff *skb);
+	int (*read_sock)(struct strparser *strp, read_descriptor_t *desc,
+			 sk_read_actor_t recv_actor);
 	int (*read_sock_done)(struct strparser *strp, int err);
 	void (*abort_parser)(struct strparser *strp, int err);
 	void (*lock)(struct strparser *strp);
diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
index 8299ceb3e373..95696f42647e 100644
--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -347,7 +347,10 @@ static int strp_read_sock(struct strparser *strp)
 	struct socket *sock = strp->sk->sk_socket;
 	read_descriptor_t desc;
 
-	if (unlikely(!sock || !sock->ops || !sock->ops->read_sock))
+	if (unlikely(!sock || !sock->ops))
+		return -EBUSY;
+
+	if (unlikely(!strp->cb.read_sock && !sock->ops->read_sock))
 		return -EBUSY;
 
 	desc.arg.data = strp;
@@ -355,7 +358,10 @@ static int strp_read_sock(struct strparser *strp)
 	desc.count = 1; /* give more than one skb per call */
 
 	/* sk should be locked here, so okay to do read_sock */
-	sock->ops->read_sock(strp->sk, &desc, strp_recv);
+	if (strp->cb.read_sock)
+		strp->cb.read_sock(strp, &desc, strp_recv);
+	else
+		sock->ops->read_sock(strp->sk, &desc, strp_recv);
 
 	desc.error = strp->cb.read_sock_done(strp, desc.error);
 
@@ -468,6 +474,7 @@ int strp_init(struct strparser *strp, struct sock *sk,
 	strp->cb.unlock = cb->unlock ? : strp_sock_unlock;
 	strp->cb.rcv_msg = cb->rcv_msg;
 	strp->cb.parse_msg = cb->parse_msg;
+	strp->cb.read_sock = cb->read_sock;
 	strp->cb.read_sock_done = cb->read_sock_done ? : default_read_sock_done;
 	strp->cb.abort_parser = cb->abort_parser ? : strp_abort_strp;
 
-- 
2.43.5


