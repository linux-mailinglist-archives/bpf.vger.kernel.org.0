Return-Path: <bpf+bounces-79005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A80C1D231B7
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 09:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CC38E3033DC1
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 08:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F037C33509B;
	Thu, 15 Jan 2026 08:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="OZNgqwl8"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3992B331A5E;
	Thu, 15 Jan 2026 08:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768465606; cv=none; b=fP6mMiRjdwv/4EXqRro6CPksINKng9U7bqGbMe07qnv2u+1kFoGZWTEt4TjO7fegUnmSt0whAVAW2zwF9eKHeJe2Ikzd67fnanLvRf6+kjLFeOlosI6FZv/d6oWPFKqQnWg1NKZ9fpxbo/Zvxkduo3RfKzNbprdVXt2jqcNuug0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768465606; c=relaxed/simple;
	bh=A3vlB4hySHBY/s0AnJu3mpuWv1QOBJOYn2p9aPU5p8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Doq7mLo+2Cgc9Hjjc3lJxSPdVsRejs57HynqIK1bPRoJ2x/Q+vmt1JrzwjTzKTdTnij26/TSGeMQoGpkllD6kPxUyh6B71YEis1hDa068opuZ9xMb7sb+iKZnC65FFd7pspJilVRcU62pw4d9NuvmF6YEnQu9btYeW4yofztr4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=OZNgqwl8; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=txlXogSdwXkOH5manBiLmneCO1jhgF1bkUIydh2ging=; b=OZNgqwl8bHONMV6yGFOiVM/WOW
	KhdustE4PxTQTZ1ImvxK5LXAmQzRL+vLHkUAei57y6Q9bJsq4XEP+BHYdL7L30U79RXtW8tGtrRWC
	ko1WA6OMKxWlZUm3kQh0j5mY5Oo7CEAUi6ahOD8LLRUwJKX7dx7v5xhvKcizzaXqLj75sGEIm0NZ/
	lr68EkUpRFjkyZq49OijK7Wjpd0eV0M7hZ94U3CdF4v6HAjEd+OoTur+h+cRKoba7EPTvcw3gmRGZ
	lh3XybpHjItwlftMHNtPivtmB0d6EmrB0eC7PxRFkgaR0TJfGUSd5ddtDik7OxZP4uTNuEV1UWlLR
	4Z46yusg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vgIgN-000Nrg-37;
	Thu, 15 Jan 2026 09:26:20 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	razor@blackwall.org,
	pabeni@redhat.com,
	willemb@google.com,
	sdf@fomichev.me,
	john.fastabend@gmail.com,
	martin.lau@kernel.org,
	jordan@jrife.io,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	dw@davidwei.uk,
	toke@redhat.com,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: [PATCH net-next v7 13/16] selftests/net: Add bpf skb forwarding program
Date: Thu, 15 Jan 2026 09:26:00 +0100
Message-ID: <20260115082603.219152-14-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115082603.219152-1-daniel@iogearbox.net>
References: <20260115082603.219152-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27881/Thu Jan 15 08:25:08 2026)

From: David Wei <dw@davidwei.uk>

Add nk_forward.bpf.c, a BPF program that forwards skbs matching some IPv6
prefix received on eth0 ifindex to a specified netkit ifindex. This will
be needed by netkit container tests.

Signed-off-by: David Wei <dw@davidwei.uk>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/drivers/net/hw/nk_forward.bpf.c | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/hw/nk_forward.bpf.c

diff --git a/tools/testing/selftests/drivers/net/hw/nk_forward.bpf.c b/tools/testing/selftests/drivers/net/hw/nk_forward.bpf.c
new file mode 100644
index 000000000000..86ebfc1445b6
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nk_forward.bpf.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <linux/pkt_cls.h>
+#include <linux/if_ether.h>
+#include <linux/ipv6.h>
+#include <linux/in6.h>
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_helpers.h>
+
+#define TC_ACT_OK 0
+#define ETH_P_IPV6 0x86DD
+
+#define ctx_ptr(field)		((void *)(long)(field))
+
+#define v6_p64_equal(a, b)	(a.s6_addr32[0] == b.s6_addr32[0] && \
+				 a.s6_addr32[1] == b.s6_addr32[1])
+
+volatile __u32 netkit_ifindex;
+volatile __u8 ipv6_prefix[16];
+
+SEC("tc/ingress")
+int tc_redirect_peer(struct __sk_buff *skb)
+{
+	void *data_end = ctx_ptr(skb->data_end);
+	void *data = ctx_ptr(skb->data);
+	struct in6_addr *peer_addr;
+	struct ipv6hdr *ip6h;
+	struct ethhdr *eth;
+
+	peer_addr = (struct in6_addr *)ipv6_prefix;
+
+	if (skb->protocol != bpf_htons(ETH_P_IPV6))
+		return TC_ACT_OK;
+
+	eth = data;
+	if ((void *)(eth + 1) > data_end)
+		return TC_ACT_OK;
+
+	ip6h = data + sizeof(struct ethhdr);
+	if ((void *)(ip6h + 1) > data_end)
+		return TC_ACT_OK;
+
+	if (!v6_p64_equal(ip6h->daddr, (*peer_addr)))
+		return TC_ACT_OK;
+
+	return bpf_redirect_peer(netkit_ifindex, 0);
+}
+
+char __license[] SEC("license") = "GPL";
-- 
2.43.0


