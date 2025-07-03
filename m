Return-Path: <bpf+bounces-62293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341E5AF788D
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 16:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A923A4BA6
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 14:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C192EF9A6;
	Thu,  3 Jul 2025 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxwRstni"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A48D2EE276;
	Thu,  3 Jul 2025 14:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554255; cv=none; b=PL7nHdrEAxoEoUS4DIJwzwCQba/ajZDl1By5u/BC64xlQrDp0WdGmTAruoFN7sblC3DhoXK/cLOSS21bKj9dK+9HWWSUHwKDdhQxcmzxPCqncXAu+Sdxnm2/grt8FjFhF0GrsDMOLA1rWJpRuUGyy1lEyLuwrEl4ILjw4sAtAKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554255; c=relaxed/simple;
	bh=+aYImCSAbfTWXumNGDL/e1sBgqJjefwWyiKtXXrLJ30=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z+dV8KDoF6zjdUm04M7yBCox9FEfS8286eGPM5eEaxNIQ4BuEkT7KWgMEy6cyts/chJGIWxW59BjVVixUp57s/3SmFngRb+FedQ66WRbuGC0MUQWI8YGzstnRYJt86FskkRxDjjpl0QAluTBpPFDAQUj7za06JHZRq7t9zFTm5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxwRstni; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-313f68bc519so61803a91.0;
        Thu, 03 Jul 2025 07:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751554253; x=1752159053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ghEtv2XWUrpnnDEqCRu2DJ1E3mdFA7WnrvN95ViKIAA=;
        b=QxwRstniPqQWCFI2F/SjaSwmUXDDtYRY2KszeEicWxRLtG9buK9ZMcXNNYfLklWX5P
         o7ZYVsBWjbOrdEXCPEB5NdQTjARoJg1JwMxEI4DLgKIzbxqFo4vL8dbUfgWNeH7VrziJ
         0vHXfE6Gzn6zOuoNbx0oSBVqIBOSrU+JxWsMPtgHticGFX4w7uyaLtutZRC9hHGYZrvQ
         3C+8kLhNLwhaXnJX/JTBQpfHrHsGChK+jh6QfBwSM1vIb7vlHpWPeA+WKaj3KuYBEKd2
         haamaT0xJPf70fxyFMkGnqYvSxYirkYq8aEFBY4g21gUcbrtoGbc32Y59csaaVeBayQ3
         66mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751554253; x=1752159053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ghEtv2XWUrpnnDEqCRu2DJ1E3mdFA7WnrvN95ViKIAA=;
        b=MGOjlFUUvUNqgbp5pmYa7LlERZpSYJkkAfkO6A/oIUAAoYddW/eBNDCfzyNzgidl4G
         Cbb08GdRPc9Yb+TPSe79rLUf73VkZUvX43k1h24U2iojiesQArIwSHFNBSHzdqpLEIBc
         FNwu+QXFUimhoTn1mWpJnN8hKdXK2nzzo3A3t3l5ZBoocPEGA1UQcUaZtUlpaP6CmWCG
         7RFDPpIHoTfVi0eqXcUyjtVlx970Mp1jKT37Laq0hvSmnTzBfHSwQdNPdcWER5tXk3bD
         Fv0P8czU4j6D6Zw8a6eBER8QBoWe7/roRZU43oYDohNfig3U1nPIvHdqahqeIBr8BPJA
         f0Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXrPjXLiVPcu52wvRUBLWPPkHg9G0WLej52MvH7HfoSwXyzPSyKAnrHLozi7ObgF2pAe6VU04U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBnzFKV052mv53yRi6R5SW3JYShursMJOxTLxIHoSMTXhLgur6
	1M+jRlSq5g3GDhwhyDbHFLHBUpGjVn7289BfHqTiIJ8x69qxEWLJrgm7KCkEF/lvuQQ=
X-Gm-Gg: ASbGncsd2ntwUndt4CYVF7R1i7SoJWDzCG5cKZdGFsNEQiM0SAvi2SzczDa4dM7O0kx
	oWkWmfXDDmdgL+ArRvHYWQyKKI9efZeCf7xqDyoxGTVa1h7ymf9DGQ1jsw9bDiFYKj6doFSVc2/
	43vjUus1RG7T6dZfrFlufOanRlryyRC6ua9mOEVCGDwkh7PYfSgnSO8nWqX8YDmJF7lBmr2x4M3
	5H9K1x4hxgT33LzY/j9rcrmTjW2I9QXmpv1h3DcwD7PI2hiuxMg6KfsT9gOkqfQtWZFTwjnFScb
	xK+5RzS0FarRO75lGro1VRJPNgZRfxNiJayaEuNwUFwhqz+08UhnEDp/WncZ/y57Zcy3bL8TPKM
	WCnnMrUD0zSw5ma6nfjo1dQ==
X-Google-Smtp-Source: AGHT+IGhJswT39ngCgnG/9BD0aLYPdBPbkL54kFaKYkRhq232pJllreyulhTAoJGGpb86oKgpVfTuQ==
X-Received: by 2002:a17:90a:da8e:b0:311:ef19:824d with SMTP id 98e67ed59e1d1-31a90b1a29emr9816029a91.2.1751554253212;
        Thu, 03 Jul 2025 07:50:53 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.26.0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cd1acfcsm2633424a91.43.2025.07.03.07.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 07:50:52 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	joe@dama.to,
	willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v7] net: xsk: introduce XDP_MAX_TX_SKB_BUDGET setsockopt
Date: Thu,  3 Jul 2025 22:50:45 +0800
Message-Id: <20250703145045.58271-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This patch provides a setsockopt method to let applications leverage to
adjust how many descs to be handled at most in one send syscall. It
mitigates the situation where the default value (32) that is too small
leads to higher frequency of triggering send syscall.

Considering the prosperity/complexity the applications have, there is no
absolutely ideal suggestion fitting all cases. So keep 32 as its default
value like before.

The patch does the following things:
- Add XDP_MAX_TX_SKB_BUDGET socket option.
- Set max_tx_budget to 32 by default in the initialization phase as a
  per-socket granular control.
- Set the range of max_tx_budget as [32, xs->tx->nentries].

The idea behind this comes out of real workloads in production. We use a
user-level stack with xsk support to accelerate sending packets and
minimize triggering syscalls. When the packets are aggregated, it's not
hard to hit the upper bound (namely, 32). The moment user-space stack
fetches the -EAGAIN error number passed from sendto(), it will loop to try
again until all the expected descs from tx ring are sent out to the driver.
Enlarging the XDP_MAX_TX_SKB_BUDGET value contributes to less frequency of
sendto() and higher throughput/PPS.

Here is what I did in production, along with some numbers as follows:
For one application I saw lately, I suggested using 128 as max_tx_budget
because I saw two limitations without changing any default configuration:
1) XDP_MAX_TX_SKB_BUDGET, 2) socket sndbuf which is 212992 decided by
net.core.wmem_default. As to XDP_MAX_TX_SKB_BUDGET, the scenario behind
this was I counted how many descs are transmitted to the driver at one
time of sendto() based on [1] patch and then I calculated the
possibility of hitting the upper bound. Finally I chose 128 as a
suitable value because 1) it covers most of the cases, 2) a higher
number would not bring evident results. After twisting the parameters,
a stable improvement of around 4% for both PPS and throughput and less
resources consumption were found to be observed by strace -c -p xxx:
1) %time was decreased by 7.8%
2) error counter was decreased from 18367 to 572

[1]: https://lore.kernel.org/all/20250619093641.70700-1-kerneljasonxing@gmail.com/

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v7
Link: https://lore.kernel.org/all/20250627110121.73228-1-kerneljasonxing@gmail.com/
1. use 'copy mode' in Doc
2. move init of max_tx_budget to a proper position
3. use the max value in the if condition in setsockopt
4. change sockopt name to XDP_MAX_TX_SKB_BUDGET
5. set MAX_PER_SOCKET_BUDGET to 32 instead of TX_BATCH_SIZE because they
   have no correlation at all.

v6
Link: https://lore.kernel.org/all/20250625123527.98209-1-kerneljasonxing@gmail.com/
1. use [32, xs->tx->nentries] range
2. Since setsockopt may generate a different value, add getsockopt to help
   application know what value takes effect finally.

v5
Link: https://lore.kernel.org/all/20250623021345.69211-1-kerneljasonxing@gmail.com/
1. remove changes around zc mode

v4
Link: https://lore.kernel.org/all/20250619090440.65509-1-kerneljasonxing@gmail.com/
1. remove getsockopt as it seems no real use case.
2. adjust the position of max_tx_budget to make sure it stays with other
read-most fields in one cacheline.
3. set one as the lower bound of max_tx_budget
4. add more descriptions/performance data in Doucmentation and commit message.

V3
Link: https://lore.kernel.org/all/20250618065553.96822-1-kerneljasonxing@gmail.com/
1. use a per-socket control (suggested by Stanislav)
2. unify both definitions into one
3. support setsockopt and getsockopt
4. add more description in commit message

V2
Link: https://lore.kernel.org/all/20250617002236.30557-1-kerneljasonxing@gmail.com/
1. use a per-netns sysctl knob
2. use sysctl_xsk_max_tx_budget to unify both definitions.
---
 Documentation/networking/af_xdp.rst |  9 +++++++++
 include/net/xdp_sock.h              |  1 +
 include/uapi/linux/if_xdp.h         |  1 +
 net/xdp/xsk.c                       | 21 +++++++++++++++++++--
 tools/include/uapi/linux/if_xdp.h   |  1 +
 5 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
index dceeb0d763aa..95ff1836e5c6 100644
--- a/Documentation/networking/af_xdp.rst
+++ b/Documentation/networking/af_xdp.rst
@@ -442,6 +442,15 @@ is created by a privileged process and passed to a non-privileged one.
 Once the option is set, kernel will refuse attempts to bind that socket
 to a different interface.  Updating the value requires CAP_NET_RAW.
 
+XDP_MAX_TX_SKB_BUDGET setsockopt
+----------------------------
+
+This setsockopt sets the maximum number of descriptors that can be handled
+and passed to the driver at one send syscall. It is applied in the copy
+mode to allow application to tune the per-socket maximum iteration for
+better throughput and less frequency of send syscall.
+Allowed range is [32, xs->tx->nentries].
+
 XDP_STATISTICS getsockopt
 -------------------------
 
diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index e8bd6ddb7b12..ce587a225661 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -84,6 +84,7 @@ struct xdp_sock {
 	struct list_head map_list;
 	/* Protects map_list */
 	spinlock_t map_list_lock;
+	u32 max_tx_budget;
 	/* Protects multiple processes in the control path */
 	struct mutex mutex;
 	struct xsk_queue *fq_tmp; /* Only as tmp storage before bind */
diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
index 44f2bb93e7e6..23a062781468 100644
--- a/include/uapi/linux/if_xdp.h
+++ b/include/uapi/linux/if_xdp.h
@@ -79,6 +79,7 @@ struct xdp_mmap_offsets {
 #define XDP_UMEM_COMPLETION_RING	6
 #define XDP_STATISTICS			7
 #define XDP_OPTIONS			8
+#define XDP_MAX_TX_SKB_BUDGET		9
 
 struct xdp_umem_reg {
 	__u64 addr; /* Start of packet data area */
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 72c000c0ae5f..07ee585bec7a 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -34,7 +34,7 @@
 #include "xsk.h"
 
 #define TX_BATCH_SIZE 32
-#define MAX_PER_SOCKET_BUDGET (TX_BATCH_SIZE)
+#define MAX_PER_SOCKET_BUDGET 32
 
 void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
 {
@@ -779,7 +779,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 static int __xsk_generic_xmit(struct sock *sk)
 {
 	struct xdp_sock *xs = xdp_sk(sk);
-	u32 max_batch = TX_BATCH_SIZE;
+	u32 max_batch;
 	bool sent_frame = false;
 	struct xdp_desc desc;
 	struct sk_buff *skb;
@@ -796,6 +796,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 	if (xs->queue_id >= xs->dev->real_num_tx_queues)
 		goto out;
 
+	max_batch = READ_ONCE(xs->max_tx_budget);
 	while (xskq_cons_peek_desc(xs->tx, &desc, xs->pool)) {
 		if (max_batch-- == 0) {
 			err = -EAGAIN;
@@ -1437,6 +1438,21 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
 		mutex_unlock(&xs->mutex);
 		return err;
 	}
+	case XDP_MAX_TX_SKB_BUDGET:
+	{
+		unsigned int budget;
+
+		if (optlen != sizeof(budget))
+			return -EINVAL;
+		if (copy_from_sockptr(&budget, optval, sizeof(budget)))
+			return -EFAULT;
+		if (!xs->tx ||
+		    budget < TX_BATCH_SIZE || budget > xs->tx->nentries)
+			return -EACCES;
+
+		WRITE_ONCE(xs->max_tx_budget, budget);
+		return 0;
+	}
 	default:
 		break;
 	}
@@ -1734,6 +1750,7 @@ static int xsk_create(struct net *net, struct socket *sock, int protocol,
 
 	xs = xdp_sk(sk);
 	xs->state = XSK_READY;
+	xs->max_tx_budget = TX_BATCH_SIZE;
 	mutex_init(&xs->mutex);
 
 	INIT_LIST_HEAD(&xs->map_list);
diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
index 44f2bb93e7e6..23a062781468 100644
--- a/tools/include/uapi/linux/if_xdp.h
+++ b/tools/include/uapi/linux/if_xdp.h
@@ -79,6 +79,7 @@ struct xdp_mmap_offsets {
 #define XDP_UMEM_COMPLETION_RING	6
 #define XDP_STATISTICS			7
 #define XDP_OPTIONS			8
+#define XDP_MAX_TX_SKB_BUDGET		9
 
 struct xdp_umem_reg {
 	__u64 addr; /* Start of packet data area */
-- 
2.41.3


