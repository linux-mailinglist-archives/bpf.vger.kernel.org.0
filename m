Return-Path: <bpf+bounces-78392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C177BD0C511
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 22:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FA60307F033
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 21:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E9033EB1B;
	Fri,  9 Jan 2026 21:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="WPxu5UE+"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B81E33D4E3;
	Fri,  9 Jan 2026 21:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767994024; cv=none; b=KtrKA9kzSGPgpPQx7Qh0+PnDcO5dk47IXSZjeM5ODh0BNVHHG0Rj3rIlBB+zCEuCuUSsL6fy+xKm68EMTRyWDx5ud5jxMk1VqP0+O1Vqn/7xyY1D8l+z1vgYAHSORIsWjto6css/omlDvLfK0Vqi+85DceCjLVecCln0WJOJXmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767994024; c=relaxed/simple;
	bh=Q+8on5CLPksbVyalTnoFNVm3pTzmd8RkjqmgmnvQikw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TjrKhSm8zs0SacxbwqFnRkncVyHPClVCyrKQhGVhTdl5B6dsfSM93uQ9SFQX8ZmhdOEDgN96i1N2jF75F6E6/mUpVdp3+sPaw1ApOA0JmUfEhl+EFzwx+yLWXI5X7iZnmR23Zl/73AFc4wrIKhRnvVslo+ZT3ytJKIRRK7Yqzks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=WPxu5UE+; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=h2VTpaB+EdqCwGXkQPFmK9vXQ+0Ba7kuQVb5qiU45h8=; b=WPxu5UE+tAGj9Hvrl/BqJj7BPP
	U5Y0OpGE3A1nU1WyMZ7uvWnMh9UP9TzDAm0pqcOtyyrMobh9IcoXDZjkv6RlfAUHpIk6ak5KrfEf1
	FJLZnGD8iZlKEQrNhvBss5q0bxPdyOkpyclU3WlanEHHY8/LzXHRdD8+HsrtAWH6gx9dh6sIhDYup
	tCpDO7ynB7cnH4yGc0w5A/+hKKctEziH6hxYVjqYMjL5eqcIt3QOd4Imn+SisGcNeJt2oqvIzCPtb
	RtG+UBTsvXQvffn/u10Lt5ug/Rwwus3VydREZ8I6vc67qvwUsVxg1xMyRCC/WwAZdensv3UzrDTtm
	t/mlsYig==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1veK0O-00055H-2W;
	Fri, 09 Jan 2026 22:26:48 +0100
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
Subject: [PATCH net-next v5 13/16] selftests/net: Add bpf skb forwarding program
Date: Fri,  9 Jan 2026 22:26:29 +0100
Message-ID: <20260109212632.146920-14-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109212632.146920-1-daniel@iogearbox.net>
References: <20260109212632.146920-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27875/Fri Jan  9 08:26:02 2026)

From: David Wei <dw@davidwei.uk>

Add nk_forward.bpf.c, a BPF program that forwards skbs matching some IPv6
prefix received on eth0 ifindex to a specified netkit ifindex. This will
be needed by netkit container tests.

Signed-off-by: David Wei <dw@davidwei.uk>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/drivers/net/hw/.gitignore       |  2 +
 .../selftests/drivers/net/hw/nk_forward.bpf.c | 49 +++++++++++++++++++
 2 files changed, 51 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/hw/nk_forward.bpf.c

diff --git a/tools/testing/selftests/drivers/net/hw/.gitignore b/tools/testing/selftests/drivers/net/hw/.gitignore
index 46540468a775..9ae058dba155 100644
--- a/tools/testing/selftests/drivers/net/hw/.gitignore
+++ b/tools/testing/selftests/drivers/net/hw/.gitignore
@@ -2,3 +2,5 @@
 iou-zcrx
 ncdevmem
 toeplitz
+# bpftool
+tools/
diff --git a/tools/testing/selftests/drivers/net/hw/nk_forward.bpf.c b/tools/testing/selftests/drivers/net/hw/nk_forward.bpf.c
new file mode 100644
index 000000000000..b593cd6c314c
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
+#define ctx_ptr(field)		(void *)(long)(field)
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


