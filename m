Return-Path: <bpf+bounces-34740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6799C93073B
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 22:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22D9928385D
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 20:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB41A14D42C;
	Sat, 13 Jul 2024 20:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="vXpa0xci"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F76D3B79F
	for <bpf@vger.kernel.org>; Sat, 13 Jul 2024 20:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720900984; cv=none; b=A55aEDPBpcbDdYiP0v3xws3Lp9gv3eUS9FH0HWejZTL8BHGqteO6E7pO2LHpzl1kgzT2USiqPOuPDlVifZNS22GLjAnH5YOpsl5MWf9q/lY5DeRgslyUkle+5KMe6P1RaWFrPvGZ0wYmQvJFBIQjtOxfOkDWdz17yLDZBNtj7Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720900984; c=relaxed/simple;
	bh=TXwPxX6Qdn+/gZe8Kopqse3gkocvJBUEMehzQg7TAdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O8XBrmSDOn6Hab219jA912smpesPwOK6vgJcSkgr9/QJ+2Z+hMH5LUrZAHMkG7AzbBCl+LDEtGJqn0WhemADs2UzhB8eLqTsVVfVoURwHdEEeHpPnVac/yX5aO7bdqqct9WJZF/6Itkm3Z3PIdzIp/QGTaAOgJ9klyXYbibGzo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=vXpa0xci; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sSixP-00FbRX-Tl; Sat, 13 Jul 2024 22:02:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From;
	bh=pomxw5sZvcJ4LmouT8EC+bB5Bn8jwkyoPWjJwOHu0uU=; b=vXpa0xciz0Hu00A53Zt3fqwHve
	HDpdzX1Nec5YCEgpTiXn/9l8B5MPPFs+10ZOegYtYCuw+XSXhj1cdeZND4Bd05H5Uk4cYNtidRFNk
	0MNIR1IwPddJuRCtkbRYnm+uwESBicZxOrDInaoqNo6ui5H/c9ZvV+B7gC7epDsLQ7XJgS0IC5JoD
	X6/owgOWs2VjYoxQ/kWas4XiFozeoE94e8EaY0zplD4EZZvfB0vwqnXUr+sWYtZsX9hjpO01WWxjv
	xjSFk8cqbk933L7F/lVhs2dKGNiQwj7+jrjuk0cL54kbaYhbC6j5wEsb3FHcOZLVLyjhxeNU+n+BZ
	cKN1NkHg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sSixP-0006kw-Jw; Sat, 13 Jul 2024 22:02:59 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sSix5-000dGr-Dv; Sat, 13 Jul 2024 22:02:39 +0200
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
Subject: [PATCH bpf v4 4/4] selftest/bpf: Test sockmap redirect for AF_UNIX MSG_OOB
Date: Sat, 13 Jul 2024 21:41:41 +0200
Message-ID: <20240713200218.2140950-5-mhal@rbox.co>
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

Verify that out-of-band packets are silently dropped before they reach the
redirection logic.

The idea is to test with a 2 byte long send(). Should a MSG_OOB flag be in
use, only the last byte will be treated as out-of-band. Test fails if
verd_mapfd indicates a wrong number of packets processed (e.g. if OOB
wasn't dropped at the source) or if it was possible to recv() MSG_OOB from
the mapped socket, or if any stale OOB data have been left reachable from
the unmapped socket.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 .../selftests/bpf/prog_tests/sockmap_listen.c | 36 +++++++++++++++++--
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 3514a344bee6..9ce0e0e0b7da 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1399,10 +1399,11 @@ static void pairs_redir_to_connected(int cli0, int peer0, int cli1, int peer1,
 			return;
 	}
 
-	n = xsend(cli1, "a", 1, send_flags);
-	if (n == 0)
+	/* Last byte is OOB data when send_flags has MSG_OOB bit set */
+	n = xsend(cli1, "ab", 2, send_flags);
+	if (n >= 0 && n < 2)
 		FAIL("%s: incomplete send", log_prefix);
-	if (n < 1)
+	if (n < 2)
 		return;
 
 	key = SK_PASS;
@@ -1417,6 +1418,25 @@ static void pairs_redir_to_connected(int cli0, int peer0, int cli1, int peer1,
 		FAIL_ERRNO("%s: recv_timeout", log_prefix);
 	if (n == 0)
 		FAIL("%s: incomplete recv", log_prefix);
+
+	if (send_flags & MSG_OOB) {
+		/* Check that we can't read OOB while in sockmap */
+		errno = 0;
+		n = recv(peer1, &b, 1, MSG_OOB | MSG_DONTWAIT);
+		if (n != -1 || errno != EOPNOTSUPP)
+			FAIL("%s: recv(MSG_OOB): expected EOPNOTSUPP: retval=%d errno=%d",
+			     log_prefix, n, errno);
+
+		/* Remove peer1 from sockmap */
+		xbpf_map_delete_elem(sock_mapfd, &(int){ 1 });
+
+		/* Check that OOB was dropped on redirect */
+		errno = 0;
+		n = recv(peer1, &b, 1, MSG_OOB | MSG_DONTWAIT);
+		if (n != -1 || errno != EINVAL)
+			FAIL("%s: recv(MSG_OOB): expected EINVAL: retval=%d errno=%d",
+			     log_prefix, n, errno);
+	}
 }
 
 static void unix_redir_to_connected(int sotype, int sock_mapfd,
@@ -1873,6 +1893,11 @@ static void unix_inet_skb_redir_to_connected(struct test_sockmap_listen *skel,
 				     sock_map, nop_map, verdict_map,
 				     REDIR_EGRESS, NO_FLAGS);
 
+	/* MSG_OOB not supported by AF_UNIX SOCK_DGRAM */
+	unix_inet_redir_to_connected(family, SOCK_STREAM,
+				     sock_map, nop_map, verdict_map,
+				     REDIR_EGRESS, MSG_OOB);
+
 	skel->bss->test_ingress = true;
 	unix_inet_redir_to_connected(family, SOCK_DGRAM,
 				     sock_map, -1, verdict_map,
@@ -1888,6 +1913,11 @@ static void unix_inet_skb_redir_to_connected(struct test_sockmap_listen *skel,
 				     sock_map, nop_map, verdict_map,
 				     REDIR_INGRESS, NO_FLAGS);
 
+	/* MSG_OOB not supported by AF_UNIX SOCK_DGRAM */
+	unix_inet_redir_to_connected(family, SOCK_STREAM,
+				     sock_map, nop_map, verdict_map,
+				     REDIR_INGRESS, MSG_OOB);
+
 	xbpf_prog_detach2(verdict, sock_map, BPF_SK_SKB_VERDICT);
 }
 
-- 
2.45.2


