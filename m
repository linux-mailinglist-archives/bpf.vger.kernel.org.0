Return-Path: <bpf+bounces-30511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2738CE8C6
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 18:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B236A1F21AC5
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 16:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644AB12F376;
	Fri, 24 May 2024 16:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="p3y5mNMA"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738AF8626E;
	Fri, 24 May 2024 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716568586; cv=none; b=K75gkhWT4HfVMEzfBOOBtxme6Svz6rFKu/mtHECCrw2dU3TZcRa+wE7WfIm5Avbxt///oFQKP7coOz43L0p9pzIJwfkt5f/E97Jl5gFB2jvmpVt8IsxYqZn14ogJrmLBnaEJl8Ib0YtyTnM2nKvHK9I89Fi1sY5d4vY87I71Ol4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716568586; c=relaxed/simple;
	bh=w269uJgL/6srq6AvmZxPTl4S/c4SeZbYLim5mBI2eZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VefUBx3ul98NlBR00g0xPHBRFiVAIMQ+dvWQjCZQ5g9pdjFjtKK0u8XbkkWnKOZEZMvQDzdBoxEMnvXC48YF6GGj7Qi+/NzexcjFdqyU6pB2LSDqMmzUumZ9+Zp3DTt9TnI7AKzqkknagrc3sl80kCPhVBN2/ihW7p4pYUrhCuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=p3y5mNMA; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=kAbJO+vdvUjq+hTE2Bsysmwx578XHIgNMugClGwrJts=; b=p3y5mNMA/GUtoRqZ8hzLo6lmT4
	RaBNYLWgzpFCXMbtdbjH9I5/7hyb4o9gz7TR5JTPwJgCMH/RIgLUe6+BvCYKm85Z6LWW8pVhI03t8
	QfdM7pFRlD+eBi0q1oCX8QH9/R42uh60L058kzLo5+Uh0+9QzM7hYZ3fBmkIqb9DkandAKVIX8/sJ
	/IZgHC3QgZ1142B8aPnKcaypmJYxnLa8TgQq508TqVpVFoz3vuLjOfGiaIlru5zPf+i7DFmrDQz4J
	etpsU8xpplNr2C2byKEDymEdvLG0652vU+3q+AVnuZG5ayrIMxXYjWv7beHfCda2r3e7fSOL7uSr0
	YxpgRvtg==;
Received: from 14.248.197.178.dynamic.dsl-lte-bonding.zhbmb00p-msn.res.cust.swisscom.ch ([178.197.248.14] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sAXu2-000IRd-JY; Fri, 24 May 2024 18:36:22 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@kernel.org
Cc: razor@blackwall.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v2 3/4] selftests/bpf: Add netkit tests for mac address
Date: Fri, 24 May 2024 18:36:18 +0200
Message-Id: <20240524163619.26001-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240524163619.26001-1-daniel@iogearbox.net>
References: <20240524163619.26001-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27285/Fri May 24 10:30:55 2024)

This adds simple tests around setting MAC addresses in the different
netkit modes.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/testing/selftests/bpf/prog_tests/tc_netkit.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_netkit.c b/tools/testing/selftests/bpf/prog_tests/tc_netkit.c
index 15ee7b2fc410..18b2e969a456 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_netkit.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_netkit.c
@@ -73,6 +73,16 @@ static int create_netkit(int mode, int policy, int peer_policy, int *ifindex,
 			 "up primary");
 	ASSERT_OK(system("ip addr add dev " netkit_name " 10.0.0.1/24"),
 			 "addr primary");
+
+	if (mode == NETKIT_L3) {
+		ASSERT_EQ(system("ip link set dev " netkit_name
+				 " addr ee:ff:bb:cc:aa:dd 2> /dev/null"), 512,
+				 "set hwaddress");
+	} else {
+		ASSERT_OK(system("ip link set dev " netkit_name
+				 " addr ee:ff:bb:cc:aa:dd"),
+				 "set hwaddress");
+	}
 	if (same_netns) {
 		ASSERT_OK(system("ip link set dev " netkit_peer " up"),
 				 "up peer");
-- 
2.34.1


