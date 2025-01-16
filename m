Return-Path: <bpf+bounces-49054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A348A13BB5
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 15:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A64B7A20DF
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 14:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3185B22B586;
	Thu, 16 Jan 2025 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JoSpqmzY"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF5B22ACDF;
	Thu, 16 Jan 2025 14:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737036485; cv=none; b=BcUc3FGfrkCDk+Ms+y2SMkeCbSwmENToU0ABf3yJNymOzlPW/Z3dkgYmQ+jHvIVFuD1QlPbknE8maviZkGlOEcMOF8U3X1aREgMS5h6eIbR+IXIJL7Xv0GdawfjtL4SKOLoqz9ybrkqdg0cvu8LEf9bLBQ3baFFERx+KBCEfVnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737036485; c=relaxed/simple;
	bh=6p0ZNiaedPTstsjUOKB/bKroZewqExukBImhrr1HPaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2rn6DW7DqsKlwPGDPCW5j9Axa4yWP/TZD6sFegMWJdg+YLWkkMPbtAHUFRq7EMP7V6uU+LOnzztyRecMOmyT9AVO4U0FQ82nZS5nzvj+78HBmRlvchhVXB7YRI5RiJlG0Ua4yZczsiUIsTsKaRwM2QrVnbue31SH8KBBA0+OlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JoSpqmzY; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=QfD0x
	ORTJ6sdWkpnFOeE2wnXCWQvBYF6SlJ27tlulQ4=; b=JoSpqmzY0qAvdbcdKcLcZ
	HeYkDGOxKbi+3M1utK13rEJR6kYUvMbuxAPyoVIF50AV4albndqf9gOuSrBMNAE5
	WEA+qdKs571EhOZuL5faQq0FUgu7Y7kuZ8wqmivLQ4PGpKsawVCx13+bApwP+tF6
	roT1YKaBYGYADQPQdu3ewk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3d5IwEolnR5IwGg--.20972S6;
	Thu, 16 Jan 2025 22:06:29 +0800 (CST)
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
Subject: [PATCH bpf v7 4/5] selftests/bpf: fix invalid flag of recv()
Date: Thu, 16 Jan 2025 22:05:30 +0800
Message-ID: <20250116140531.108636-5-mrpre@163.com>
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
X-CM-TRANSID:_____wD3d5IwEolnR5IwGg--.20972S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF4DCF45tFW5tFy5Xr1UWrg_yoW8GF1kpa
	40y34YkFWSvF1aqa1kJrsruF4rGr98Xws0kF4DWry8Ar1kJrn2qF4xKay5tFn7WrZ3Z34r
	Zwn3KFWrWw48WwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEYFAQUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbBDwbWp2eJDhZMOQAAs7

SOCK_NONBLOCK flag is only effective during socket creation, not during
recv. Use MSG_DONTWAIT instead.

Signed-off-by: Jiayuan Chen <mrpre@163.com>
---
 tools/testing/selftests/bpf/prog_tests/sockmap_basic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 884ad87783d5..0c51b7288978 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -522,8 +522,8 @@ static void test_sockmap_skb_verdict_shutdown(void)
 	if (!ASSERT_EQ(err, 1, "epoll_wait(fd)"))
 		goto out_close;
 
-	n = recv(c1, &b, 1, SOCK_NONBLOCK);
-	ASSERT_EQ(n, 0, "recv_timeout(fin)");
+	n = recv(c1, &b, 1, MSG_DONTWAIT);
+	ASSERT_EQ(n, 0, "recv(fin)");
 out_close:
 	close(c1);
 	close(p1);
@@ -628,7 +628,7 @@ static void test_sockmap_skb_verdict_fionread(bool pass_prog)
 	ASSERT_EQ(avail, expected, "ioctl(FIONREAD)");
 	/* On DROP test there will be no data to read */
 	if (pass_prog) {
-		recvd = recv_timeout(c1, &buf, sizeof(buf), SOCK_NONBLOCK, IO_TIMEOUT_SEC);
+		recvd = recv_timeout(c1, &buf, sizeof(buf), MSG_DONTWAIT, IO_TIMEOUT_SEC);
 		ASSERT_EQ(recvd, sizeof(buf), "recv_timeout(c0)");
 	}
 
-- 
2.43.5


