Return-Path: <bpf+bounces-52573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E00AA44EE9
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 22:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E22217B70F
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 21:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0F1210185;
	Tue, 25 Feb 2025 21:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="IUbygT/9"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC3920E6FB;
	Tue, 25 Feb 2025 21:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740518982; cv=none; b=RpTwYWGcffCu4Y/gZYBm+qL7L/bP6pem/B8sZZj3jnhl4PEuQU0IiSyQGAbOVPoDqg9ClmW+2j0H6vljjVw25uPPYncn2tPGeLI3GJdszmknUHdimwyiwGEOmfnVSRx97CMdGg0OvwFnWw9KDvhQj6sm8FXT+TQl4b1jRMR3o4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740518982; c=relaxed/simple;
	bh=aHHyjCAajZkQBWBMhyoGC/7GAgkHuLUmQVhT+GBpm8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qEy7VXk4Vxtv6xXwomUL/yBU5OzvewpjN1avvXPnC6YX5YHy8N2/H4mYRH6C5HFy1cnJVJzjB3TLhPnalZKHeSib2Ph2h7ZUf7/rqkhDoqjDe92fHSpW8xvH35aVNUbUu00db/T6P86C2csslY5f+2PO5FCXbF/N8NRu/Vm0WPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=IUbygT/9; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=NPV+XQRTDkSrWqMSsd/KziJIjpUy3f0cPCBDdb7eSPg=; b=IUbygT/9dPtUnipf9zMkO3mWPZ
	MbTJrXWnnS0PXZAIsTFJMT+0G8bmAuKqmMEdRjAuwVXQS1XHU71SX2uedDOPwL0KE+dI1NTAiW38v
	mlry7ayptZtL9mcK8PxcysD76hVrHo/Rf2qZqvabOc9ExNronCaj1LCUNIiNoYuk2nyO2j3aoMvGl
	yFAlzBzOoTeg8FTGD23XOHk96ox3cb1808N/kN3AKvE7jpCnp2w5cc083U3sCD0iQyklj68K0jIHp
	+JPRfdtwzHqpv9ilgQzPIRZn2wj+NBOXsrfN2zm7vcp8JTceYg1VZkcWtKz9yil6rPmicaMRQLwP7
	2/bBP3ug==;
Received: from 22.248.197.178.dynamic.cust.swisscom.net ([178.197.248.22] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1tn2Ua-000HHd-1R;
	Tue, 25 Feb 2025 22:29:28 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Philo Lu <lulie@linux.alibaba.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH net] netkit: Remove double invocation to clear ipvs property flag
Date: Tue, 25 Feb 2025 22:29:27 +0100
Message-ID: <20250225212927.69271-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27560/Tue Feb 25 10:44:40 2025)

With ipvs_reset() now done unconditionally in skb_scrub_packet()
we would then call the former twice netkit_prep_forward(). Thus
remove the now unnecessary explicit call.

Fixes: de2c211868b9 ("ipvs: Always clear ipvs_property flag in skb_scrub_packet()")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Philo Lu <lulie@linux.alibaba.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Martin KaFai Lau <martin.lau@kernel.org>
---
 [ Sending to net since de2c211868b9 is in net ]

 drivers/net/netkit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 1e1b00756be7..20088f781376 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -65,7 +65,6 @@ static void netkit_prep_forward(struct sk_buff *skb,
 	skb_reset_mac_header(skb);
 	if (!xnet)
 		return;
-	ipvs_reset(skb);
 	skb_clear_tstamp(skb);
 	if (xnet_scrub)
 		netkit_xnet(skb);
-- 
2.43.0


