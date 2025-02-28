Return-Path: <bpf+bounces-52858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B6FA491E8
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 08:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 194083B8524
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 07:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DB81CB51F;
	Fri, 28 Feb 2025 07:09:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09A81C3BFC;
	Fri, 28 Feb 2025 07:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740726572; cv=none; b=rrYrVPy0jZRHBEzc3s70hMkyUnJ38nD7x4Fx+/eUVVpqlF/8HorZg7qz+i8MtB01OzmmeH9aWiU6vVCHS7sIn5LRYeECrbvsh0j2wMH5lruFRl4cTkA5QeFWKGTfsUh/nDe4THLBbEcaIda1UITJ0W247uczYVMI1GtgCv3CBSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740726572; c=relaxed/simple;
	bh=/AG9C+GuRVVRU1SYPxtaBTpy7cUYfyIbB8AtLTkLcHg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owIWvOMpCmpMqx8+3jT0xHKEtSg9j/OKVyO6MQg3iW7mGefXTyj9DfJaA0AL5F08SgAph8hZ6GXARKRDQhvnDFXNd0YhDBroxgIS+5M1hh5J/zqScgMSTRBdY5NPi/rRUF0pHJz5DlVesPDADwoKF2ajYWxZtEmwCIE3SF8X5Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Z3zk44nz7z1dyjr;
	Fri, 28 Feb 2025 15:05:16 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 5424B1A016C;
	Fri, 28 Feb 2025 15:09:23 +0800 (CST)
Received: from kwepemn200003.china.huawei.com (7.202.194.126) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 28 Feb 2025 15:09:23 +0800
Received: from localhost.localdomain (10.175.101.6) by
 kwepemn200003.china.huawei.com (7.202.194.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 28 Feb 2025 15:09:21 +0800
From: zhangmingyi <zhangmingyi5@huawei.com>
To: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <yanan@huawei.com>,
	<wuchangye@huawei.com>, <xiesongyang@huawei.com>, <liuxin350@huawei.com>,
	<liwei883@huawei.com>, <tianmuyang@huawei.com>, <zhangmingyi5@huawei.com>
Subject: [PATCH bpf-next v3 1/2] Introduced to support the ULP to get or set sockets
Date: Fri, 28 Feb 2025 15:06:27 +0800
Message-ID: <20250228070628.3219087-2-zhangmingyi5@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250228070628.3219087-1-zhangmingyi5@huawei.com>
References: <20250228070628.3219087-1-zhangmingyi5@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemn200003.china.huawei.com (7.202.194.126)

From: Mingyi Zhang <zhangmingyi5@huawei.com>

Note that tcp_getsockopt and tcp_setsockopt support TCP_ULP, while
bpf_getsockopt and bpf_setsockopt do not support TCP_ULP.
I think we can add the handling of this case.

We want call bpf_setsockopt to replace the kernel module in the TCP_ULP
case. The purpose is to customize the behavior in connect and sendmsg.
We have an open source community project kmesh (kmesh.net). Based on
this, we refer to some processes of tcp fastopen to implement delayed
connet and perform HTTP DNAT when sendmsg.In this case, we need to parse
HTTP packets in the bpf program and set TCP_ULP for the specified socket.

Signed-off-by: Mingyi Zhang <zhangmingyi5@huawei.com>
Signed-off-by: Xin Liu <liuxin350@huawei.com>
---
 include/net/tcp.h   |  2 +-
 net/core/filter.c   |  1 +
 net/ipv4/tcp.c      |  2 +-
 net/ipv4/tcp_ulp.c  | 28 +++++++++++++++-------------
 net/mptcp/subflow.c |  2 +-
 5 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index e9b37b76e894..f26e92099b86 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2582,7 +2582,7 @@ struct tcp_ulp_ops {
 };
 int tcp_register_ulp(struct tcp_ulp_ops *type);
 void tcp_unregister_ulp(struct tcp_ulp_ops *type);
-int tcp_set_ulp(struct sock *sk, const char *name);
+int tcp_set_ulp(struct sock *sk, const char *name, bool load);
 void tcp_get_available_ulp(char *buf, size_t len);
 void tcp_cleanup_ulp(struct sock *sk);
 void tcp_update_ulp(struct sock *sk, struct proto *p,
diff --git a/net/core/filter.c b/net/core/filter.c
index 713d6f454df3..bdb5c43d6fb0 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5380,6 +5380,7 @@ static int sol_tcp_sockopt(struct sock *sk, int optname,
 	case TCP_CONGESTION:
 		return sol_tcp_sockopt_congestion(sk, optval, optlen, getopt);
 	case TCP_SAVED_SYN:
+	case TCP_ULP:
 		if (*optlen < 1)
 			return -EINVAL;
 		break;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0d704bda6c41..88ccd0e211f9 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3744,7 +3744,7 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		name[val] = 0;
 
 		sockopt_lock_sock(sk);
-		err = tcp_set_ulp(sk, name);
+		err = tcp_set_ulp(sk, name, !has_current_bpf_ctx());
 		sockopt_release_sock(sk);
 		return err;
 	}
diff --git a/net/ipv4/tcp_ulp.c b/net/ipv4/tcp_ulp.c
index 2aa442128630..9e828d4c2932 100644
--- a/net/ipv4/tcp_ulp.c
+++ b/net/ipv4/tcp_ulp.c
@@ -33,10 +33,7 @@ static struct tcp_ulp_ops *tcp_ulp_find(const char *name)
 
 static const struct tcp_ulp_ops *__tcp_ulp_find_autoload(const char *name)
 {
-	const struct tcp_ulp_ops *ulp = NULL;
-
-	rcu_read_lock();
-	ulp = tcp_ulp_find(name);
+	const struct tcp_ulp_ops *ulp = tcp_ulp_find(name);
 
 #ifdef CONFIG_MODULES
 	if (!ulp && capable(CAP_NET_ADMIN)) {
@@ -46,10 +43,6 @@ static const struct tcp_ulp_ops *__tcp_ulp_find_autoload(const char *name)
 		ulp = tcp_ulp_find(name);
 	}
 #endif
-	if (!ulp || !try_module_get(ulp->owner))
-		ulp = NULL;
-
-	rcu_read_unlock();
 	return ulp;
 }
 
@@ -154,15 +147,24 @@ static int __tcp_set_ulp(struct sock *sk, const struct tcp_ulp_ops *ulp_ops)
 	return err;
 }
 
-int tcp_set_ulp(struct sock *sk, const char *name)
+int tcp_set_ulp(struct sock *sk, const char *name, bool load)
 {
 	const struct tcp_ulp_ops *ulp_ops;
+	int err = 0;
 
 	sock_owned_by_me(sk);
 
-	ulp_ops = __tcp_ulp_find_autoload(name);
-	if (!ulp_ops)
-		return -ENOENT;
+	rcu_read_lock();
+	if (!load)
+		ulp_ops = tcp_ulp_find(name);
+	else
+		ulp_ops = __tcp_ulp_find_autoload(name);
+
+	if (!ulp_ops || !try_module_get(ulp_ops->owner))
+		err = -ENOENT;
+	rcu_read_unlock();
 
-	return __tcp_set_ulp(sk, ulp_ops);
+	if (!err)
+		err = __tcp_set_ulp(sk, ulp_ops);
+	return err;
 }
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index fd021cf8286e..fb936d280b83 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1776,7 +1776,7 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 	sf->sk->sk_net_refcnt = 1;
 	get_net_track(net, &sf->sk->ns_tracker, GFP_KERNEL);
 	sock_inuse_add(net, 1);
-	err = tcp_set_ulp(sf->sk, "mptcp");
+	err = tcp_set_ulp(sf->sk, "mptcp", true);
 	if (err)
 		goto err_free;
 
-- 
2.43.0


