Return-Path: <bpf+bounces-58254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26076AB78E6
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 00:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D16583B7479
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 22:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A42D21CC47;
	Wed, 14 May 2025 22:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="EMeWv17R"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2291DE4EC;
	Wed, 14 May 2025 22:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747260986; cv=none; b=KENE+3vnfppD0V9Y0lGl3kTciKeTJGsnDg+PVdO0f52qcHnVBGeF4wOpVCF/wOO/prols2q4QTlfrqa0dn/OJUviD/YMP4UzdrMT8R7qJTBW+aDDkyW6uiQImlKcmMIBvViSzjbjHCOzgw87+/YMB5St1jo7GYIAF54nuHq9kj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747260986; c=relaxed/simple;
	bh=bSKkn3nM3v0HO325xfei4C6jwzh4vhH/n43cB4LwQQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XFDRRMpsc7AlcrXNPQHwyOfjlR7O99Seq6KrmpQQV3pkRHVlGXagUq3xGA4od1BE588fB/1JnNyQJSF5xFkW0LRcVS93yR+u83feHtdGwzwxFHi/qllwfmwV10jR3h+iNMIcbXmphuxysS8EuKlj39fqxWDIKi03moNuNNN9W9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=EMeWv17R; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uFKOd-001k89-MD; Thu, 15 May 2025 00:16:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=2FzBNg4m8mbkJzKlkeWZy30zedQWDfDv4O7u47x1mWw=; b=EMeWv17RUFXQ718dcHVOn3tTay
	AaR8mGj4xF+pQHfScZpqlD/wKBjZLbJTiu7jpZwgOCIPmgTrykyf/dPHrQLlu55oIGPFkVTqGgH4O
	KgRE8JP1iW8gcjjMHOfhZv/0XWEwDU4iJIKO4f8Mo8lkB1w+FFqsVIs3Jx4oJqaZSq717PSx+cRml
	Xh+rRERVqOJUt7TYhUqUtGSKQ+Cfl6SrZf6udppJl+RTjpmPtBozQyX5VU2pSZVIYyd/804M6Eavi
	u5zi+frG/qBcI4PUwmL63a+5S2IilIy872Yvh8ixQXV6e1f3oIj8CHpJAmsA203w1WvKdaLhZHOlb
	c0Sf/6xg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uFKOc-00089Q-9r; Thu, 15 May 2025 00:16:15 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uFKOJ-005bJ3-U9; Thu, 15 May 2025 00:15:56 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 15 May 2025 00:15:24 +0200
Subject: [PATCH bpf-next v3 1/8] selftests/bpf: Support af_unix SOCK_DGRAM
 socket pair creation
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-selftests-sockmap-redir-v3-1-a1ea723f7e7e@rbox.co>
References: <20250515-selftests-sockmap-redir-v3-0-a1ea723f7e7e@rbox.co>
In-Reply-To: <20250515-selftests-sockmap-redir-v3-0-a1ea723f7e7e@rbox.co>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Handle af_unix in init_addr_loopback(). For pair creation, bind() the peer
socket to make SOCK_DGRAM connect() happy.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 .../selftests/bpf/prog_tests/socket_helpers.h      | 29 ++++++++++++++++++----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/socket_helpers.h b/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
index 1bdfb79ef009b16e329a80eab8598ed97dae9119..e505c2f2595a24be9dd5b534deef4793f9a02f77 100644
--- a/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
@@ -3,6 +3,7 @@
 #ifndef __SOCKET_HELPERS__
 #define __SOCKET_HELPERS__
 
+#include <sys/un.h>
 #include <linux/vm_sockets.h>
 
 /* include/linux/net.h */
@@ -169,6 +170,15 @@ static inline void init_addr_loopback6(struct sockaddr_storage *ss,
 	*len = sizeof(*addr6);
 }
 
+static inline void init_addr_loopback_unix(struct sockaddr_storage *ss,
+					   socklen_t *len)
+{
+	struct sockaddr_un *addr = memset(ss, 0, sizeof(*ss));
+
+	addr->sun_family = AF_UNIX;
+	*len = sizeof(sa_family_t);
+}
+
 static inline void init_addr_loopback_vsock(struct sockaddr_storage *ss,
 					    socklen_t *len)
 {
@@ -190,6 +200,9 @@ static inline void init_addr_loopback(int family, struct sockaddr_storage *ss,
 	case AF_INET6:
 		init_addr_loopback6(ss, len);
 		return;
+	case AF_UNIX:
+		init_addr_loopback_unix(ss, len);
+		return;
 	case AF_VSOCK:
 		init_addr_loopback_vsock(ss, len);
 		return;
@@ -315,21 +328,27 @@ static inline int create_pair(int family, int sotype, int *p0, int *p1)
 {
 	__close_fd int s, c = -1, p = -1;
 	struct sockaddr_storage addr;
-	socklen_t len = sizeof(addr);
+	socklen_t len;
 	int err;
 
 	s = socket_loopback(family, sotype);
 	if (s < 0)
 		return s;
 
-	err = xgetsockname(s, sockaddr(&addr), &len);
-	if (err)
-		return err;
-
 	c = xsocket(family, sotype, 0);
 	if (c < 0)
 		return c;
 
+	init_addr_loopback(family, &addr, &len);
+	err = xbind(c, sockaddr(&addr), len);
+	if (err)
+		return err;
+
+	len = sizeof(addr);
+	err = xgetsockname(s, sockaddr(&addr), &len);
+	if (err)
+		return err;
+
 	err = connect(c, sockaddr(&addr), len);
 	if (err) {
 		if (errno != EINPROGRESS) {

-- 
2.49.0


