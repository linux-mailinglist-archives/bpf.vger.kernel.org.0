Return-Path: <bpf+bounces-37666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D32DC95923A
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 03:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AF4D1F21A60
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 01:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95605481DB;
	Wed, 21 Aug 2024 01:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gYJ/HB2D"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21D618035
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 01:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724204080; cv=none; b=IPCQGZYs8fuGw1jivsI7qPyJGsVd0up83SUMajYiEzf6lBwHBau8IyW4Gcuob5fyVY9/qqwwYfxkrrYcg7j0IIwfk8wjWkXxHF5koG8B1AThOZSV73kir2xliuGIltOm5N/ioDBmmGhxqaDH8lfM2AH4/VDjXY8d6mzRJ1oOGvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724204080; c=relaxed/simple;
	bh=WaUVNU9PnHW/77JMMSCRJT4MA5qASTfLjfumV/GDRYw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=reoOAv1a5XqUEdpXO4KWx7NRSVn7iCsKpy9xyDsSqn6YFgFvL5Q5Fv6sJWtOATPQvjMoNzPUlJEv7LRNiy5gaYQ/oXoAzYlPe8Yl5kkzUSC5/6ZlhwB6VOosp2/LAvbaiHeSMT/+tNVTI+gT8C8qLXJz6aWyxrV3qHAmvlinlfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gYJ/HB2D; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1724204078; x=1755740078;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r18lX5Q00GeCh5RSG84b33IO8ogRZB+4Uyab6Fyawrk=;
  b=gYJ/HB2D8SL2la058SiJfQwzlrHoh4YnsoYVpr6xDiY6ijhOQkiRHUjP
   PQbCsDLq2YywjSrkzahnuwUjfEKEWyLNQDHV3EgWilGs+GwrbS/jnG2rF
   qLob4tPTgQST4BFlojVftsXzejeN9Yb2W2gqC1G7kfiFKmKAY6sQF8PoA
   Y=;
X-IronPort-AV: E=Sophos;i="6.10,163,1719878400"; 
   d="scan'208";a="117200557"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 01:34:38 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:37649]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.1:2525] with esmtp (Farcaster)
 id 6c11a33c-e333-4b39-99da-ca5c292e41e3; Wed, 21 Aug 2024 01:34:38 +0000 (UTC)
X-Farcaster-Flow-ID: 6c11a33c-e333-4b39-99da-ca5c292e41e3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 21 Aug 2024 01:34:37 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 21 Aug 2024 01:34:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Mykola Lysenko <mykolal@fb.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <bpf@vger.kernel.org>, Dan Carpenter
	<dan.carpenter@linaro.org>
Subject: [PATCH v2 bpf-next] selftest: bpf: Remove mssind boundary check in test_tcp_custom_syncookie.c.
Date: Tue, 20 Aug 2024 18:34:25 -0700
Message-ID: <20240821013425.49316-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB001.ant.amazon.com (10.13.139.152) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Smatch reported a possible off-by-one in tcp_validate_cookie().

However, it's false positive because the possible range of mssind is
limited from 0 to 3 by the preceding calculation.

  mssind = (cookie & (3 << 6)) >> 6;

Now, the verifier does not complain without the boundary check.
Let's remove the checks.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/bpf/6ae12487-d3f1-488b-9514-af0dac96608f@stanley.mountain/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 .../selftests/bpf/progs/test_tcp_custom_syncookie.c   | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
index 44ee0d037f95..eb5cca1fce16 100644
--- a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
+++ b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
@@ -486,17 +486,10 @@ static int tcp_validate_cookie(struct tcp_syncookie *ctx)
 		goto err;
 
 	mssind = (cookie & (3 << 6)) >> 6;
-	if (ctx->ipv4) {
-		if (mssind > ARRAY_SIZE(msstab4))
-			goto err;
-
+	if (ctx->ipv4)
 		ctx->attrs.mss = msstab4[mssind];
-	} else {
-		if (mssind > ARRAY_SIZE(msstab6))
-			goto err;
-
+	else
 		ctx->attrs.mss = msstab6[mssind];
-	}
 
 	ctx->attrs.snd_wscale = cookie & BPF_SYNCOOKIE_WSCALE_MASK;
 	ctx->attrs.rcv_wscale = ctx->attrs.snd_wscale;
-- 
2.30.2


