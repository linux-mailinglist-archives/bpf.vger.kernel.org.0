Return-Path: <bpf+bounces-60449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18376AD6B35
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 10:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A384D3A6F73
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 08:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FB32222B7;
	Thu, 12 Jun 2025 08:44:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256222040A7;
	Thu, 12 Jun 2025 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749717852; cv=none; b=M0oDrMcO0i/x8/LlhBdqnpNFdzy/5mgnR4bIu7Zv+E/+nekDVXdDgDAB3mx/iDeFKe/D/ndOtbbX/huSW7ZuOtb4GEEaCNuG2awhvJ5MgKgF/a/p5x/o1sUe0nSoYarzhpIXcLuSgrbuXyNT0PR3PPPAXeCD0OLM75Qyx/YZ1Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749717852; c=relaxed/simple;
	bh=I69bZIqiy4XEo/WWZmtDr/07/X+aYo0XsdccoBY0B7k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TzFshbPNFmPQ3A6CBBJUEAGZVzdSmxTojBV+G7RthsMcLb3zX+e0iOYTdkssr8MfeNhNFqkQchSOicBY0LXfZkR1sdXC775gRSE3y7pS+bOolYOdZMdn/6VexPpPgc2K2olWXe2Z5b83sbek0SHDohxudsyYzWBU3jJwMFvtJRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <andrii@kernel.org>, <eddyz87@gmail.com>, <mykolal@fb.com>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@fomichev.me>,
	<haoluo@google.com>, <jolsa@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <shuah@kernel.org>
CC: <mhal@rbox.co>, <jakub@cloudflare.com>, <thinker.li@gmail.com>,
	<bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Fushuai Wang <wangfushuai@baidu.com>
Subject: [PATCH bpf-next v2] selftests/bpf: fix signedness bug in redir_partial()
Date: Thu, 12 Jun 2025 16:42:08 +0800
Message-ID: <20250612084208.27722-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc7.internal.baidu.com (172.31.3.17) To
 bjkjy-mail-ex22.internal.baidu.com (172.31.50.16)
X-FEAS-Client-IP: 172.31.50.16
X-FE-Policy-ID: 52:10:53:SYSTEM

When xsend() returns -1 (error), the check 'n < sizeof(buf)' incorrectly
treats it as success due to unsigned promotion. Explicitly check for -1
first.

Fixes: a4b7193d8efd ("selftests/bpf: Add sockmap test for redirecting partial skb data")
Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 1d98eee7a2c3..f1bdccc7e4e7 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -924,6 +924,8 @@ static void redir_partial(int family, int sotype, int sock_map, int parser_map)
 		goto close;
 
 	n = xsend(c1, buf, sizeof(buf), 0);
+	if (n == -1)
+		goto close;
 	if (n < sizeof(buf))
 		FAIL("incomplete write");
 
-- 
2.36.1


