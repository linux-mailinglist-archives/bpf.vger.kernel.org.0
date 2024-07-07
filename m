Return-Path: <bpf+bounces-34018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 228999299F7
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 00:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3A631F21312
	for <lists+bpf@lfdr.de>; Sun,  7 Jul 2024 22:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FCD6F2FA;
	Sun,  7 Jul 2024 22:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="XTquWd9Z"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ED512E55;
	Sun,  7 Jul 2024 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720391384; cv=none; b=KdSSd4j5ii0iYdXaWg8OnM8q3tbCud7BL13av2F5wQDF+YCFsLY6OLwouduKmdPfaxXkc+LrHZj5cACcKi5A/UaUVsqKdb3sYa5WtaM/mIcc7iwYmdVhUKjAGxnuaOTFyhF+0U8e7UzF26jqp831omInfBPL8qYavM4ke3sK1Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720391384; c=relaxed/simple;
	bh=dGUOgYZXO+dYc4Hd2aEZo7E1ZNs9m6oaDpq8IcnWEaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQfE8lW4Md0Gl8y7GzPPIV8x1ocXP2gFiEAdSWKl6Tt5cnNfz8BuhLn7dG+2HGm4lgBoAm/QvmTC8NT/KIodOFyXQGzlT8JwckyvmDHjVOhf0NqdGPLGnzmPGLqKVHa9qlNcyhEWxF1LCRtUXHlGAI4P3aMLyZvH550HtQE8aJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=XTquWd9Z; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sQaO1-00H8ig-A7; Mon, 08 Jul 2024 00:29:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From;
	bh=E4IXG40cCmALJCoKYDNrqUR7yMYyRtdiJB1SHvERVGo=; b=XTquWd9ZHlzloP5OkvTkhb8+wW
	vZWtMfohM6X3ipEbgHClu2WnkZSCePVhNAzhrSNcretd5LmqokfAaCH+SHIK+b0ujFtCvBqmtpim+
	FiZ1pThKNYdKf3LKtbvQv8Jd60KjZBu41py1TbXCktR6Aksw+hvbb9dK5C7IUXpVerSvLhg5avfSP
	FuSctR0ZsvwOt+da6QwaIn/Wb3h1/Z7tnxll+MhmMz2jzD4ocEXp05RNMQX/ogRUwb6/ZXKft4laa
	8Aq5t7jlqcXw8K0AXlWjBqrcx5mQI0aHOGm7Dm+wwSGmcAsnQ/CWBJBxDXLY/P7uneJ/MjEQ1lcb9
	7osUCOjg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sQaNw-00060Z-0K; Mon, 08 Jul 2024 00:29:32 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sQaNb-009IHx-F4; Mon, 08 Jul 2024 00:29:11 +0200
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
Subject: [PATCH bpf v3 3/4] selftest/bpf: Parametrize AF_UNIX redir functions to accept send() flags
Date: Sun,  7 Jul 2024 23:28:24 +0200
Message-ID: <20240707222842.4119416-4-mhal@rbox.co>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240707222842.4119416-1-mhal@rbox.co>
References: <20240707222842.4119416-1-mhal@rbox.co>
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
 .../selftests/bpf/prog_tests/sockmap_listen.c | 40 +++++++++++++------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index c075d376fcab..59e16f8f2090 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1374,9 +1374,10 @@ static void test_redir(struct test_sockmap_listen *skel, struct bpf_map *map,
 	}
 }
 
-static void pairs_redir_to_connected(int cli0, int peer0, int cli1, int peer1,
-				     int sock_mapfd, int nop_mapfd,
-				     int verd_mapfd, enum redir_mode mode)
+static void __pairs_redir_to_connected(int cli0, int peer0, int cli1, int peer1,
+				       int sock_mapfd, int nop_mapfd,
+				       int verd_mapfd, enum redir_mode mode,
+				       int send_flags)
 {
 	const char *log_prefix = redir_mode_str(mode);
 	unsigned int pass;
@@ -1396,11 +1397,9 @@ static void pairs_redir_to_connected(int cli0, int peer0, int cli1, int peer1,
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
 
@@ -1418,6 +1417,14 @@ static void pairs_redir_to_connected(int cli0, int peer0, int cli1, int peer1,
 		FAIL("%s: incomplete recv", log_prefix);
 }
 
+static void pairs_redir_to_connected(int cli0, int peer0, int cli1, int peer1,
+				     int sock_mapfd, int nop_mapfd,
+				     int verd_mapfd, enum redir_mode mode)
+{
+	__pairs_redir_to_connected(cli0, peer0, cli1, peer1, sock_mapfd,
+				   nop_mapfd, verd_mapfd, mode, 0);
+}
+
 static void unix_redir_to_connected(int sotype, int sock_mapfd,
 			       int verd_mapfd, enum redir_mode mode)
 {
@@ -1815,10 +1822,9 @@ static void inet_unix_skb_redir_to_connected(struct test_sockmap_listen *skel,
 	xbpf_prog_detach2(verdict, sock_map, BPF_SK_SKB_VERDICT);
 }
 
-static void unix_inet_redir_to_connected(int family, int type,
-					int sock_mapfd, int nop_mapfd,
-					int verd_mapfd,
-					enum redir_mode mode)
+static void __unix_inet_redir_to_connected(int family, int type, int sock_mapfd,
+					   int nop_mapfd, int verd_mapfd,
+					   enum redir_mode mode, int send_flags)
 {
 	int c0, c1, p0, p1;
 	int sfd[2];
@@ -1832,8 +1838,8 @@ static void unix_inet_redir_to_connected(int family, int type,
 		goto close_cli0;
 	c1 = sfd[0], p1 = sfd[1];
 
-	pairs_redir_to_connected(c0, p0, c1, p1,
-				 sock_mapfd, nop_mapfd, verd_mapfd, mode);
+	__pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, nop_mapfd,
+				   verd_mapfd, mode, send_flags);
 
 	xclose(c1);
 	xclose(p1);
@@ -1842,6 +1848,14 @@ static void unix_inet_redir_to_connected(int family, int type,
 	xclose(p0);
 }
 
+static void unix_inet_redir_to_connected(int family, int type, int sock_mapfd,
+					 int nop_mapfd, int verd_mapfd,
+					 enum redir_mode mode)
+{
+	__unix_inet_redir_to_connected(family, type, sock_mapfd, nop_mapfd,
+				       verd_mapfd, mode, 0);
+}
+
 static void unix_inet_skb_redir_to_connected(struct test_sockmap_listen *skel,
 					    struct bpf_map *inner_map, int family)
 {
-- 
2.45.2


