Return-Path: <bpf+bounces-34736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 266B4930737
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 22:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA42228375F
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 20:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2150C1448DC;
	Sat, 13 Jul 2024 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="X6nzPH4X"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845EC39AC3;
	Sat, 13 Jul 2024 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720900975; cv=none; b=jqKdEVU3cF6pAw+vLH7LNkcZfNSCSVZcUFS4SsYYmDK5MbfZmwOmo5YIFAdCg7OWfPqMr1pt9I3E99kVYLiGUBloOrsZda2MMoN/WBM+9fpMdciOKWv5BsSmSA/hoOLaHZhFoQWwKH3GTgwUetfSyn4SSW8k4kbHoLtAJO/kejk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720900975; c=relaxed/simple;
	bh=WKsMuc3CiWdTI1U4xeAjkFsiboAbgVGtCnrk8+dMyCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNnK+vQIMBmLa6bfIX/NaIwqJlHXnGlANlzYfRN8gkZxfsTglvvxVr3VG3i5zop0qo0mzIHedme6+x7m2JATF3cSfRGtyaAIAO/04KQVYumPE1aJEaOh9DDoc1kjhAqRSG2VB/nCqopofrkErqqNRWD2rK0CJOMZPkuBZnKDsrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=X6nzPH4X; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sSixA-00DSpY-SH; Sat, 13 Jul 2024 22:02:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From;
	bh=Xhgcoe4TRNaoCWi9/qn8Iv02jPWQo3SzXT/Ub9QVIqg=; b=X6nzPH4X9ySd8FoLh6iM15Gw2+
	KIDJs2WzVg6uZlw7H+XWY1tRwC1kelEtTxjGF50tOo0iX1qCfqYGB4WnutIxsZ9qnK2+7ljzDJXLB
	MtEWTgeLNepqAatwWhqdMayUyt+NfKbWUvwH0MIMzpfrUc3aBFaq/gIL/NNU2NhTFiTcdpS1dHxWc
	CQvXQpJ+Ofabzf7yvabdT/q8jHeV5jqB9ltJr6rsxWHH+PTPMDzUE+4rMxc1hQBr/+tY7T6urksu9
	1lUFTLl08J9fteKXx/lp5Qe7mZGf38kIRR1abBkXpFSLTpRjyMufhXoFgQFIF4nNBMgl1xyZDBXhE
	a3A1S/qA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sSixA-0006ir-IP; Sat, 13 Jul 2024 22:02:44 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sSix4-000dGr-72; Sat, 13 Jul 2024 22:02:38 +0200
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
Subject: [PATCH bpf v4 2/4] selftest/bpf: Support SOCK_STREAM in unix_inet_redir_to_connected()
Date: Sat, 13 Jul 2024 21:41:39 +0200
Message-ID: <20240713200218.2140950-3-mhal@rbox.co>
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

Function ignores the AF_UNIX socket type argument, SOCK_DGRAM is hardcoded.
Fix to respect the argument provided.

Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Fixes: 75e0e27db6cf ("selftest/bpf: Change udp to inet in some function names")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index e91b59366030..c075d376fcab 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1828,7 +1828,7 @@ static void unix_inet_redir_to_connected(int family, int type,
 	if (err)
 		return;
 
-	if (socketpair(AF_UNIX, SOCK_DGRAM | SOCK_NONBLOCK, 0, sfd))
+	if (socketpair(AF_UNIX, type | SOCK_NONBLOCK, 0, sfd))
 		goto close_cli0;
 	c1 = sfd[0], p1 = sfd[1];
 
@@ -1840,7 +1840,6 @@ static void unix_inet_redir_to_connected(int family, int type,
 close_cli0:
 	xclose(c0);
 	xclose(p0);
-
 }
 
 static void unix_inet_skb_redir_to_connected(struct test_sockmap_listen *skel,
-- 
2.45.2


