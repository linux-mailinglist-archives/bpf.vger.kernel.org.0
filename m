Return-Path: <bpf+bounces-58250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB55AB781A
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 23:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8875A3AA56F
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 21:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0E8221F2C;
	Wed, 14 May 2025 21:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="d9T3kbWg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE701EA7D6;
	Wed, 14 May 2025 21:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747258839; cv=none; b=P9Fg3etNULEE9Tw1EmtF7+QrLUJ0kRnfG8MrldqZF+sdMmJCoa1/GKg9mZODX/1EjhDAu4ELd6r4Fg8+7nk2O98yqtRUZuoAA8hEKmsPF/Ko4J6NBvgsIAdtRvY71SSOsKCcw/x62Bb/u3tN6M+0MgEH3tbU3IBr99G2BS0aYfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747258839; c=relaxed/simple;
	bh=ZF/eADNpfy1fbl2t8r6cgpTYI1FtnULmtTlBEy5oc6U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oicHUmqRPCbDQbR6+ChsPbjecTsoIPKWsOYC0r27GEyr1Xq/GhNNafnerG8FaiBqtuByFca6q0FiWiqav9a6pxpzsZrpwRezmE8kdJ74TQW2nlxUBXOsgZD72jtPBKBGG6U4hTBiuDcQeI5py+ziNTGw1VpgnnCNNtshwO+ZLxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=d9T3kbWg; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747258838; x=1778794838;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CTYMMtDoKtiGw6dvc8yJt46kSFhgishDPo6btXQJDJo=;
  b=d9T3kbWgm1iC7Pomjyt8vDmRPTQe7mezV+MQP/FC6TXlEqghUU5FQ1ot
   2rIpRUo2I8l1Oo/Ur2IO8KSF/8Z3DjEphRXOitPBUMgZf3ryBD7LsjWtr
   rCIem65wIkL97FcF1+h2+fUS61LWO9VHtybCJ3oGczvIQdIBx/LtAhrlY
   5aoPCRRUsxrPeHYnUPAEVZqhzNSsgBMdNd2nZti2HKZTbbfXmUHMm9/jO
   U3DFopbnhjeJeBQTZ7vD7dH7JtFhC/pJmDpOrdeoH7lYmFEw8OOnp5KmT
   BmZB6Nf4W1jvxXYVE69NvXDiB6RXr3takzby7g3Sc1S2j/7oK3wqECqx4
   g==;
X-IronPort-AV: E=Sophos;i="6.15,289,1739836800"; 
   d="scan'208";a="93303472"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 21:40:34 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:63321]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.244:2525] with esmtp (Farcaster)
 id b5f7b238-682b-4c39-b8ae-361665eab6b0; Wed, 14 May 2025 21:40:33 +0000 (UTC)
X-Farcaster-Flow-ID: b5f7b238-682b-4c39-b8ae-361665eab6b0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 21:40:33 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 21:40:30 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>
CC: Mykola Lysenko <mykolal@fb.com>, Martin KaFai Lau <martin.lau@linux.dev>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH v1 bpf-next] selftest: bpf: Relax TCPOPT_WINDOW validation in test_tcp_custom_syncookie.c.
Date: Wed, 14 May 2025 14:40:20 -0700
Message-ID: <20250514214021.85187-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The custom syncookie test expects TCPOPT_WINDOW to be 7 based on the
kernel’s behaviour at the time, but the upcoming series [0] will bump
it to 10.

Let's relax the test to allow any valid TCPOPT_WINDOW value in the
range 1–14.

Link: https://lore.kernel.org/netdev/20250513193919.1089692-1-edumazet@google.com/ #[0]
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
index eb5cca1fce16..7d5293de1952 100644
--- a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
+++ b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
@@ -294,7 +294,9 @@ static int tcp_validate_sysctl(struct tcp_syncookie *ctx)
 	    (ctx->ipv6 && ctx->attrs.mss != MSS_LOCAL_IPV6))
 		goto err;
 
-	if (!ctx->attrs.wscale_ok || ctx->attrs.snd_wscale != 7)
+	if (!ctx->attrs.wscale_ok ||
+	    !ctx->attrs.snd_wscale ||
+	    ctx->attrs.snd_wscale >= BPF_SYNCOOKIE_WSCALE_MASK)
 		goto err;
 
 	if (!ctx->attrs.tstamp_ok)
-- 
2.49.0


