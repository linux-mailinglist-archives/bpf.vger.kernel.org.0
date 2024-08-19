Return-Path: <bpf+bounces-37539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC46D9574AA
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 21:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0271C239DD
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 19:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2521DC482;
	Mon, 19 Aug 2024 19:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HFGC2hlz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE321DC479
	for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 19:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096587; cv=none; b=KOHJo4VVVYSFiA77jT++9GoQ2Xy0Qaru7FLIfDxTPrDB61FP7EfuKpS3OtmkrlFbtJSLYUKTVNdcrFHRs/PlmjkOW2GDeTdgxQEp/QIiICEA5mtHzjOwynVfoV8WAUNXb5EIvw4CJL4zcPlpmnaydY29Qeet93my1DUjrPweLbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096587; c=relaxed/simple;
	bh=WNH28yy+PmBMzJqodsObaUcwu18lilOTBpwdDu2a/gk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B6tWUDPQ5YInhLOtxCUWekhHQynVVpQBA/mBzLvLRDWR5dHlZBWnc1XiSeg8r9W6RGiEPqgbasaovRiWctsebOMiTLpe44zjV6SaqvCU6wgy3Nt/jWeHjEUQ6YzFiVWghKB/zrDriJdznsirxtqq0RLV+gdsuKFwaawuCab3G/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HFGC2hlz; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1724096585; x=1755632585;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5Aa4qfnr2DFpFmwn4U+Bvd8JftpcWPowpqBJnPucau0=;
  b=HFGC2hlzPsZSqP8/WCzhQtJSZmnsFYWbty918TG+EuPvTMzVWorR4knO
   MEOWw7cC4Tz9W7GDMSk5ah9RULvG3puv0zcOvQbvo4oojoqu+3EiJ8iD9
   oBx2oHkook/HIjxvOeScQGv4eGu9yGVrm+0jDE3knjWTT2XCmQOdOiJel
   s=;
X-IronPort-AV: E=Sophos;i="6.10,160,1719878400"; 
   d="scan'208";a="418092695"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 19:43:02 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:49334]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.61:2525] with esmtp (Farcaster)
 id 82e8e8a2-1a79-4d0f-8333-5af9fba4e0bf; Mon, 19 Aug 2024 19:43:01 +0000 (UTC)
X-Farcaster-Flow-ID: 82e8e8a2-1a79-4d0f-8333-5af9fba4e0bf
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 19 Aug 2024 19:43:00 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.26) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 19 Aug 2024 19:42:57 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko
	<mykolal@fb.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <bpf@vger.kernel.org>, Dan Carpenter
	<dan.carpenter@linaro.org>
Subject: [PATCH v1 bpf-next] selftest: bpf: Correct mssind comparison in test_tcp_custom_syncookie.c.
Date: Mon, 19 Aug 2024 12:42:47 -0700
Message-ID: <20240819194247.27491-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA001.ant.amazon.com (10.13.139.62) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Smatch reported a possible off-by-one in tcp_validate_cookie().

However, it's false positive because the possible range of mssind is
limited from 0 to 3 by the preceding calculation.

  mssind = (cookie & (3 << 6)) >> 6;

There's no real issue, but let's make Smatch happy to suppress the same
reports.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/bpf/6ae12487-d3f1-488b-9514-af0dac96608f@stanley.mountain/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
index 44ee0d037f95..36b842133033 100644
--- a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
+++ b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
@@ -487,12 +487,12 @@ static int tcp_validate_cookie(struct tcp_syncookie *ctx)
 
 	mssind = (cookie & (3 << 6)) >> 6;
 	if (ctx->ipv4) {
-		if (mssind > ARRAY_SIZE(msstab4))
+		if (mssind >= ARRAY_SIZE(msstab4))
 			goto err;
 
 		ctx->attrs.mss = msstab4[mssind];
 	} else {
-		if (mssind > ARRAY_SIZE(msstab6))
+		if (mssind >= ARRAY_SIZE(msstab6))
 			goto err;
 
 		ctx->attrs.mss = msstab6[mssind];
-- 
2.30.2


