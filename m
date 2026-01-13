Return-Path: <bpf+bounces-78774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A070D1BB6B
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 00:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80C46309B91A
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 23:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A90336C0AF;
	Tue, 13 Jan 2026 23:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="a6zD/kSP"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE52369236;
	Tue, 13 Jan 2026 23:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768346613; cv=none; b=GmAG9EL+4MgFxgdZnJBg1Y5Bgln5Vdmfnp+aRCSNy+X3SmDMG1Vh4eC4gEiM8N/c9EkB6FGRRULTzGhkdmIjAH81CnC9Jn2nzgiRpHzPYiqA6oRQVqcFy+ub1rOUw5ORSfn9V4l4sayJX+5N2mPbRcyooqPkcNycfSZBLpfsfF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768346613; c=relaxed/simple;
	bh=A3vlB4hySHBY/s0AnJu3mpuWv1QOBJOYn2p9aPU5p8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKGsVx+k8PiJd2KkjcoYBkZisy5l7i7EP7O7QdC7UAyVCGNwNPaBYmaReKMc04h2dlG5y6joycAWLFxKZHWYYc6KDE6GX4wTTW9X0KBP11Gv70RYL1KxEO5inZkcnlASKWO4ussVUdjnNUI4lZq4zmplfq6eo/LXW8vdifWuBts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=a6zD/kSP; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=txlXogSdwXkOH5manBiLmneCO1jhgF1bkUIydh2ging=; b=a6zD/kSPXpRnVpJYg81kyYo6cu
	y8Ll5t1z5XTYv4QTp9Ifuvfn7sBQ47tBmiVoKwA8MdTZ+39eIpklL1PDsTqQcBOAi3ND+wD39QbmA
	AjREZp09i26ocDiqskY3DPpFV7K9LbKGUxt64EO8UFkFolJhf1paBC2RLRRs4715QDUyDhC1gb8fu
	Q+VbyAPiRqcGUL1RkiKwEvFjl3Bs3S5fxpoKE/NKuNnpwqvri8OB6ojQpSF12NgpNFElA9cZUxp1v
	mTbjjCWRJRKMWZFJOFtVc1mjdvYbgfSqCNMBQLgmJH2fbAiF9uI2OGLwCggDecpKou+xEJ4hO6p9M
	hL8dRJ7A==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vfnjG-0003fT-0x;
	Wed, 14 Jan 2026 00:23:14 +0100
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
Subject: [PATCH net-next v6 13/16] selftests/net: Add bpf skb forwarding program
Date: Wed, 14 Jan 2026 00:22:54 +0100
Message-ID: <20260113232257.200036-14-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113232257.200036-1-daniel@iogearbox.net>
References: <20260113232257.200036-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27879/Tue Jan 13 08:26:16 2026)

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


