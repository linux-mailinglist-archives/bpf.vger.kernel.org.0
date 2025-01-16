Return-Path: <bpf+bounces-49053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6CEA13BB8
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 15:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C9B3A98BE
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 14:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6690722B8D9;
	Thu, 16 Jan 2025 14:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="o6CGFXi9"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AC522A1EA;
	Thu, 16 Jan 2025 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737036477; cv=none; b=cMeopwNHMArdmspNkSR4Xy+cPzr0E+nWecS9yS/ig47i5BFNigc/glWAXmL8QG7P5c6ljbpHWeGyBOJ7qaoAi7l5Wl/25EP9poEjzs5821kDLxbEVKC0cBVjSYuANoT9e3R71bH3UCboAW5FovdCIwln4acZkubJgEDQgc0Lyqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737036477; c=relaxed/simple;
	bh=rdeeNIYL4+G2f2mp1PyVIHyyYU4tGAMHXVJ23+oXPlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VvnUFL8LsSps2f41GK5vshUrCAjmZ4fvuse7F9WPtf4srfVlQAAYNtKI6eIpqXSJNQFYmAbZl2h7wuElRxnrJMetHMqDCSa1KwBJNDwUvMY/epVWCBfqEp0QsYEbP6KXuYV14+mQ7IqKruml1wtqWzh7oQJs6AkBNFJ7MO796sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=o6CGFXi9; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=FLZrR
	FTPsDQEkZ0qpof6MihHFc5Ug9NTVIMrA6HAbo8=; b=o6CGFXi9wA8ioKZSuizBF
	3NQnGMHqklUdLmrsFcd0IuVlgr4v8nCMmt5u9Bw1xuUcrVkZSQE3ziKVyvnt28LP
	7QyzEGIUye/zgzWG2gG2Fq1kXjL/ehALc5ckMsvnjQfuOcDEPWvWkVBZo98TK1nH
	0cDdttaC2zhEL1Sgv9hL1E=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3d5IwEolnR5IwGg--.20972S5;
	Thu, 16 Jan 2025 22:06:18 +0800 (CST)
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
Subject: [PATCH bpf v7 3/5] bpf: disable non stream socket for strparser
Date: Thu, 16 Jan 2025 22:05:29 +0800
Message-ID: <20250116140531.108636-4-mrpre@163.com>
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
X-CM-TRANSID:_____wD3d5IwEolnR5IwGg--.20972S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF18CF1DArW3Kw17KrWkCrg_yoW8AFW7pa
	n5Cw43uFW2yF4Ivan8Xa98Kr1Skw1rKryUKa4rGa4aywsrKr4YgFyrGFyayF15Kr4aga4U
	ArsrKryfCw43JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRMrWrUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiWxjWp2eJD5MwegAEsO

Currently, only TCP supports strparser, but sockmap doesn't intercept
non-TCP to attach strparser. For example, with UDP, although the
read/write handlers are replaced, strparser is not executed due to the
lack of read_sock operation.

Furthermore, in udp_bpf_recvmsg(), it checks whether psock has data, and
if not, it falls back to the native UDP read interface, making
UDP + strparser appear to read correctly. According to it's commit
history, the behavior is unexpected.

Moreover, since UDP lacks the concept of streams, we intercept it
directly. Later, we will try to support Unix streams and add more
check.

Signed-off-by: Jiayuan Chen <mrpre@163.com>
---
 net/core/sock_map.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index f1b9b3958792..c6ee2d1d9cf2 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -214,6 +214,14 @@ static struct sk_psock *sock_map_psock_get_checked(struct sock *sk)
 	return psock;
 }
 
+static bool sock_map_sk_strp_allowed(const struct sock *sk)
+{
+	/* todo: support unix stream socket */
+	if (sk_is_tcp(sk))
+		return true;
+	return false;
+}
+
 static int sock_map_link(struct bpf_map *map, struct sock *sk)
 {
 	struct sk_psock_progs *progs = sock_map_progs(map);
@@ -303,7 +311,10 @@ static int sock_map_link(struct bpf_map *map, struct sock *sk)
 
 	write_lock_bh(&sk->sk_callback_lock);
 	if (stream_parser && stream_verdict && !psock->saved_data_ready) {
-		ret = sk_psock_init_strp(sk, psock);
+		if (sock_map_sk_strp_allowed(sk))
+			ret = sk_psock_init_strp(sk, psock);
+		else
+			ret = -EOPNOTSUPP;
 		if (ret) {
 			write_unlock_bh(&sk->sk_callback_lock);
 			sk_psock_put(sk, psock);
-- 
2.43.5


