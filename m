Return-Path: <bpf+bounces-19835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAAA8320CD
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 22:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 514E5B24BB1
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 21:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E71A2EAE6;
	Thu, 18 Jan 2024 21:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rDTVD8FN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2D531A60
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 21:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705612689; cv=none; b=MjVmtNEN/8wX8XyoybRNvY1JPJUqxkwkeb6pPT9JVX7/fut6ijHYLzWAL8Q56vo81RY0JIWx38x7DzJ+p1acUhltbjwq/kaPEkT68VPXns4CVMQbsf3h4Najx88JqiMYj9iOIZDros5ScWvO81FEzftBysCU0VCytK5SeBVqDTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705612689; c=relaxed/simple;
	bh=QcvsMlGTmNouqMzWup8X2j9+jBtANHLU4NR7gYc/wXM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LE3/eyMCy/4aveL2ekN1ANMQi9bT0AyN+Hzo4uSGQQiyMO57yxmRvYs8x0clZvD6fWfTkxHEbQnIOAhOXUfOXkIMllUGHSl6LpX9kqSiBy4MjwjzExG0QMYIC9gwcuMhndV3bXvkaRjuovIK6vhXAQJemdwIPZ0SayIJIgx3Dh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rDTVD8FN; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705612689; x=1737148689;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=auJOf+n3bre4rHc7+8uoxFRvP6gYYWiWpDkgJpygbr4=;
  b=rDTVD8FNkXAHBHsgjBi6qpnY4+6d0UKM5CgzpfUFxkcS+pj6gDFqTLrY
   65cP/DnOxp5kPkQ6TpwpURNbSqQCqDLkt6BCeHyCKnTCVOWcL9Uu76ma1
   gDsq/+FWRRsSUhQvpDmY0+rCFoE6Bh0EQecc3kQ4BOaRvHJwhncb0heGC
   o=;
X-IronPort-AV: E=Sophos;i="6.05,203,1701129600"; 
   d="scan'208";a="178938559"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-00fceed5.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 21:18:06 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1d-m6i4x-00fceed5.us-east-1.amazon.com (Postfix) with ESMTPS id 214B0A0C45;
	Thu, 18 Jan 2024 21:18:04 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:28237]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.164:2525] with esmtp (Farcaster)
 id 1532f97a-40f2-4828-8bd7-53906b45d0c6; Thu, 18 Jan 2024 21:18:04 +0000 (UTC)
X-Farcaster-Flow-ID: 1532f97a-40f2-4828-8bd7-53906b45d0c6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 18 Jan 2024 21:18:03 +0000
Received: from 88665a182662.ant.amazon.com (10.88.183.204) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 18 Jan 2024 21:18:01 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Martin KaFai Lau <martin.lau@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <bpf@vger.kernel.org>, kernel test robot
	<lkp@intel.com>
Subject: [PATCH v1 bpf-next] bpf: Define struct bpf_tcp_req_attrs when CONFIG_SYN_COOKIES=n.
Date: Thu, 18 Jan 2024 13:17:51 -0800
Message-ID: <20240118211751.25790-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB001.ant.amazon.com (10.13.139.160) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

kernel test robot reported the warning below:

  >> net/core/filter.c:11842:13: warning: declaration of 'struct bpf_tcp_req_attrs' will not be visible outside of this function [-Wvisibility]
      11842 |                                         struct bpf_tcp_req_attrs *attrs, int attrs__sz)
            |                                                ^
     1 warning generated.

struct bpf_tcp_req_attrs is defined under CONFIG_SYN_COOKIES
but used in kfunc without the config.

Let's move struct bpf_tcp_req_attrs definition outside of
CONFIG_SYN_COOKIES guard.

Fixes: b9c3eca5c086 ("bpf: tcp: Support arbitrary SYN Cookie.")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401180418.CUVc0hxF-lkp@intel.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/tcp.h | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 451dc1373970..58e65af74ad1 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -498,6 +498,22 @@ struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
 					    struct tcp_options_received *tcp_opt,
 					    int mss, u32 tsoff);
 
+#if IS_ENABLED(CONFIG_BPF)
+struct bpf_tcp_req_attrs {
+	u32 rcv_tsval;
+	u32 rcv_tsecr;
+	u16 mss;
+	u8 rcv_wscale;
+	u8 snd_wscale;
+	u8 ecn_ok;
+	u8 wscale_ok;
+	u8 sack_ok;
+	u8 tstamp_ok;
+	u8 usec_ts_ok;
+	u8 reserved[3];
+};
+#endif
+
 #ifdef CONFIG_SYN_COOKIES
 
 /* Syncookies use a monotonic timer which increments every 60 seconds.
@@ -600,20 +616,6 @@ static inline bool cookie_ecn_ok(const struct net *net, const struct dst_entry *
 }
 
 #if IS_ENABLED(CONFIG_BPF)
-struct bpf_tcp_req_attrs {
-	u32 rcv_tsval;
-	u32 rcv_tsecr;
-	u16 mss;
-	u8 rcv_wscale;
-	u8 snd_wscale;
-	u8 ecn_ok;
-	u8 wscale_ok;
-	u8 sack_ok;
-	u8 tstamp_ok;
-	u8 usec_ts_ok;
-	u8 reserved[3];
-};
-
 static inline bool cookie_bpf_ok(struct sk_buff *skb)
 {
 	return skb->sk;
-- 
2.30.2


