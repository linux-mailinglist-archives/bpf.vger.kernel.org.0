Return-Path: <bpf+bounces-34739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EE2930739
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 22:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD0CE1F22088
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 20:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7AF146A6D;
	Sat, 13 Jul 2024 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="MQddVh/t"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F07A38F9C
	for <bpf@vger.kernel.org>; Sat, 13 Jul 2024 20:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720900977; cv=none; b=BHtagsQg7JL/vC5WFlhCQNjRiXQkyJJDFz6QHK1XX+30xp3X69XlWKvIJCZcuGq7BAxXn1WvS2e1DINpYs1HCGfYyOecoSbe7nEZBmypAZTJZxrZfvPOPTNcHv7yAoyk4I1AvTgOpKQx6JGpW1b2ypEAzGgi6NHbKZ5fdqj2nvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720900977; c=relaxed/simple;
	bh=N/Z3HFmO2AXE6huMIvGqcP+lT+FUIEnDDmWHMQW5zns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHuZ9FasA8+eTvMdODjwqZPLvqL5QCerwq2AfvKZYf3FjyjmtG7j0K6VrEvSospPywJNMB1T8ONi3MYp7n6TxnuMkAXwWejWJws+aBIMlgXzdBufb8NGtTu7V2Sb2P9GWqMlc4+xblaI+bM5FphOwZ4z9AD/IdY8hpnMN5uTXho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=MQddVh/t; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sSix9-00DSpN-8N; Sat, 13 Jul 2024 22:02:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From;
	bh=r6hML+r1vb36y7UX7CxhAKVd6k+PTlZ7WPcopW5IeW8=; b=MQddVh/tTclI8fW54lpNPwuKL5
	Vv20P7Pk/KqByWDRRzFjOxMPgza+OxSt4r8rzS4NjdIj6yujL3gvy76BvX3PsTYU2o0XE0STvSb+1
	lL5CRnOxf8QM/23UVF05PAXst5Ls+RpcBWnxuMnMgy0o9AepF43/ZDjfC6a+MMPWzUYrHEHsxsup3
	vXJan81Yf2FH5+a4vZZAT9mmdpFb1WnavHXC/xlB4W/Qv843FqYDxZW7eMMXCO/BxB8vPcFuu5GTb
	H+0svkkZDN8pXLlpW/Ya10zWkciaDMjlLeONRKRLKnOVA2lchccqEUNpI2c6nKytVhPpDcohRiuXH
	sbPd2srQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sSix8-0002yZ-SR; Sat, 13 Jul 2024 22:02:43 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sSix4-000dGr-Qw; Sat, 13 Jul 2024 22:02:38 +0200
From: Michal Luczaj <mhal@rbox.co>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	kuniyu@amazon.com,
	Rao.Shoaib@oracle.com,
	cong.wang@bytedance.com,
	Michal Luczaj <mhal@rbox.co>
Subject: [PATCH bpf v4 3/4] selftest/bpf: Parametrize AF_UNIX redir functions to accept send() flags
Date: Sat, 13 Jul 2024 21:41:40 +0200
Message-ID: <20240713200218.2140950-4-mhal@rbox.co>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240713200218.2140950-1-mhal@rbox.co>
References: <20240713200218.2140950-1-mhal@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend pairs_redir_to_connected() and unix_inet_redir_to_connected() with a
send_flags parameter. Replace write() with send() allowing packets to be
sent as MSG_OOB.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 .../selftests/bpf/prog_tests/sockmap_listen.c | 48 ++++++++++---------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index c075d376fcab..3514a344bee6 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -29,6 +29,8 @@
 
 #include "sockmap_helpers.h"
 
+#define NO_FLAGS 0
+
 static void test_insert_invalid(struct test_sockmap_listen *skel __always_unused,
 				int family, int sotype, int mapfd)
 {
@@ -1376,7 +1378,8 @@ static void test_redir(struct test_sockmap_listen *skel, struct bpf_map *map,
 
 static void pairs_redir_to_connected(int cli0, int peer0, int cli1, int peer1,
 				     int sock_mapfd, int nop_mapfd,
-				     int verd_mapfd, enum redir_mode mode)
+				     int verd_mapfd, enum redir_mode mode,
+				     int send_flags)
 {
 	const char *log_prefix = redir_mode_str(mode);
 	unsigned int pass;
@@ -1396,11 +1399,9 @@ static void pairs_redir_to_connected(int cli0, int peer0, int cli1, int peer1,
 			return;
 	}
 
-	n = write(cli1, "a", 1);
-	if (n < 0)
-		FAIL_ERRNO("%s: write", log_prefix);
+	n = xsend(cli1, "a", 1, send_flags);
 	if (n == 0)
-		FAIL("%s: incomplete write", log_prefix);
+		FAIL("%s: incomplete send", log_prefix);
 	if (n < 1)
 		return;
 
@@ -1432,7 +1433,8 @@ static void unix_redir_to_connected(int sotype, int sock_mapfd,
 		goto close0;
 	c1 = sfd[0], p1 = sfd[1];
 
-	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, -1, verd_mapfd, mode);
+	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, -1, verd_mapfd,
+				 mode, NO_FLAGS);
 
 	xclose(c1);
 	xclose(p1);
@@ -1722,7 +1724,8 @@ static void udp_redir_to_connected(int family, int sock_mapfd, int verd_mapfd,
 	if (err)
 		goto close_cli0;
 
-	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, -1, verd_mapfd, mode);
+	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, -1, verd_mapfd,
+				 mode, NO_FLAGS);
 
 	xclose(c1);
 	xclose(p1);
@@ -1780,7 +1783,8 @@ static void inet_unix_redir_to_connected(int family, int type, int sock_mapfd,
 	if (err)
 		goto close;
 
-	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, -1, verd_mapfd, mode);
+	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, -1, verd_mapfd,
+				 mode, NO_FLAGS);
 
 	xclose(c1);
 	xclose(p1);
@@ -1815,10 +1819,9 @@ static void inet_unix_skb_redir_to_connected(struct test_sockmap_listen *skel,
 	xbpf_prog_detach2(verdict, sock_map, BPF_SK_SKB_VERDICT);
 }
 
-static void unix_inet_redir_to_connected(int family, int type,
-					int sock_mapfd, int nop_mapfd,
-					int verd_mapfd,
-					enum redir_mode mode)
+static void unix_inet_redir_to_connected(int family, int type, int sock_mapfd,
+					 int nop_mapfd, int verd_mapfd,
+					 enum redir_mode mode, int send_flags)
 {
 	int c0, c1, p0, p1;
 	int sfd[2];
@@ -1832,8 +1835,8 @@ static void unix_inet_redir_to_connected(int family, int type,
 		goto close_cli0;
 	c1 = sfd[0], p1 = sfd[1];
 
-	pairs_redir_to_connected(c0, p0, c1, p1,
-				 sock_mapfd, nop_mapfd, verd_mapfd, mode);
+	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, nop_mapfd,
+				 verd_mapfd, mode, send_flags);
 
 	xclose(c1);
 	xclose(p1);
@@ -1858,31 +1861,32 @@ static void unix_inet_skb_redir_to_connected(struct test_sockmap_listen *skel,
 	skel->bss->test_ingress = false;
 	unix_inet_redir_to_connected(family, SOCK_DGRAM,
 				     sock_map, -1, verdict_map,
-				     REDIR_EGRESS);
+				     REDIR_EGRESS, NO_FLAGS);
 	unix_inet_redir_to_connected(family, SOCK_DGRAM,
 				     sock_map, -1, verdict_map,
-				     REDIR_EGRESS);
+				     REDIR_EGRESS, NO_FLAGS);
 
 	unix_inet_redir_to_connected(family, SOCK_DGRAM,
 				     sock_map, nop_map, verdict_map,
-				     REDIR_EGRESS);
+				     REDIR_EGRESS, NO_FLAGS);
 	unix_inet_redir_to_connected(family, SOCK_STREAM,
 				     sock_map, nop_map, verdict_map,
-				     REDIR_EGRESS);
+				     REDIR_EGRESS, NO_FLAGS);
+
 	skel->bss->test_ingress = true;
 	unix_inet_redir_to_connected(family, SOCK_DGRAM,
 				     sock_map, -1, verdict_map,
-				     REDIR_INGRESS);
+				     REDIR_INGRESS, NO_FLAGS);
 	unix_inet_redir_to_connected(family, SOCK_STREAM,
 				     sock_map, -1, verdict_map,
-				     REDIR_INGRESS);
+				     REDIR_INGRESS, NO_FLAGS);
 
 	unix_inet_redir_to_connected(family, SOCK_DGRAM,
 				     sock_map, nop_map, verdict_map,
-				     REDIR_INGRESS);
+				     REDIR_INGRESS, NO_FLAGS);
 	unix_inet_redir_to_connected(family, SOCK_STREAM,
 				     sock_map, nop_map, verdict_map,
-				     REDIR_INGRESS);
+				     REDIR_INGRESS, NO_FLAGS);
 
 	xbpf_prog_detach2(verdict, sock_map, BPF_SK_SKB_VERDICT);
 }
-- 
2.45.2


