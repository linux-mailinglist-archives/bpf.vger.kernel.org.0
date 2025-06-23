Return-Path: <bpf+bounces-61254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22083AE3389
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 04:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A357C188CB60
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 02:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E520519CC2E;
	Mon, 23 Jun 2025 02:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ts+XtQBN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA017B663;
	Mon, 23 Jun 2025 02:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750644836; cv=none; b=bUtP6MtJBmIGPMHPwJ12CKzuEOi3DBsve7v/UJgCJNSMxYuD0Knxg8B6wv8la4A1F+bhMThDTtKs6sCk1VM4e+7BvcUTN4AoDCtX7ZAOME/sGfog9u0MtC+M3q2DVxnRlPYKJNFVk44njBsxe3H/qGDZitd9H9G4yUwenaBqTiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750644836; c=relaxed/simple;
	bh=osd8vh9dxPhuJmykDXubbfhYH+uvJzC+BBL3YwVie5U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qgVDDbOHIDUUD/G/OQq7K/dzfy3zHK0pTtFygOyh+wrliN6/91KDgRR02EZIqU/8Iomvc7y4BGLJI6dTo3mfZCbRVpCvjdb5fLJV5sf2w2YVMLaO95OsNiVsvZx3fRPFEJZtRUHz8lPGECK5tzhVyhKhSXELzq+nSY/GTOCbRwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ts+XtQBN; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-74924255af4so1165023b3a.1;
        Sun, 22 Jun 2025 19:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750644834; x=1751249634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NlLlODHYtW3EzsnIstO40WCoCwlv50yz5b7WzvJPc3Q=;
        b=Ts+XtQBNtrql69t02USrIniQkwRyi5zwH3RJcu9M/QtUg4BWm2qtVofCMhOEFo1jwm
         xdZRnh/ZS+PJsbpIDK2nf+2r9C6ENaToZRJNmDnctvCFE/n4TwvviiBz/5m2HpwsFPsI
         y9OTroXCO7W62wVrsPRhdA3tm6X+zWYD4vU8WomyJsFnnKmMgN93NeSFdUOEqAaF+bcA
         3TGXAMjEHSeRjrvx4/o5ZCdAHRi55G0E3PKnAtA+eujh2LRBYJYp7EsRQeAA9WkrVKUv
         jxL7JEzCYC32IeIs5oAZJ02x21CkJ4vGQLgrENY1Hi/EL3HweenWD3EJI7jeFu9tEqlI
         3FHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750644834; x=1751249634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NlLlODHYtW3EzsnIstO40WCoCwlv50yz5b7WzvJPc3Q=;
        b=GKiESO/2cJWOBcMGH5ld0jP0fU7RxwabQiKO+mKKsOsC8FJ94Ka8zbr92kzdcLTy4F
         fAvCydIGWSAQJ/894BMQHUAiNpDRUTxgf1UPkXFWQxC9ebrvQ1NVYtQ/MNfJriughSVJ
         7zfgf3Raa3BgCKs1VArLHU30mJDRL98NCtWO8eFk/d/0U878TGnkmIywAO26+lyu+IpJ
         UJy/RrwrREpqL3ScqDxwfVknjIavjVx46hmq8EXM5yytDsfPyewXdbzNHOsTmsgVKS9z
         lDNcDg9ATjBR3pKn6nVtzNSY9P9j8ANy5Dt6y9+qWo/hnzwjxtCdh+F6GtLaeDUMHNfa
         VaSw==
X-Forwarded-Encrypted: i=1; AJvYcCVIOTwseO/QanZ6IjnTefJPMlVoB/bU9XsU1jFYornWEyj7ksqcAmxG91G03T8ZSUIcQqNL8Vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwavhXxCCTkBidiciFmX1NK+TFjqaPH1Vl+6PZ9MavVBslbYWf6
	L1eIw4jeK8JGg21+EXkcp5eKA+LlT/qbMWYNr01G2W8dOZ5C8Ib2Do0CQRYsHQ==
X-Gm-Gg: ASbGncvcmWQR2x0KIR+dpc/zxMN87Lfbuzpjj912eDP9T+kv779McgDSsf6dvKCPWwj
	hd/O6CwqqDatcLhx52LnLop7YfYO3dh/SaMDCFKXzdgpowTKJtCIfk9MVI9xUo6dDEMMo2xwvLE
	sbpnPoLluhCVNCN8gflJTjGA05w01LqvfAUKj4Z4+uvylsJJ/6Ul43psyyVWrNDPpBkO145K2sR
	tfAiFjsYWgRBOcMHn4pBQnm5K3Q8JfJ+SwZLFYkoN9SzQGFl0diNRL7cIxI1HhCmcWU1w2buoEb
	jbStAz2cyLAjecl3ddXoajUNF7cZoj46m/W9P/bHx8TnA4zf+Nx3P167FoQd0NITPfytyccyWDx
	Mf/2gsFvinA38LaT+ZK+6WQkkGkx1hPF+hA==
X-Google-Smtp-Source: AGHT+IGH4KqpNHxV8UVMUrncWO1BpA8RB8ok/A+CnHCZrYnaAZcXUR+97dmy8Zy3VwMhFyTdsoxx4A==
X-Received: by 2002:a05:6a20:7d9e:b0:201:85f4:ade6 with SMTP id adf61e73a8af0-22026e92bddmr16337377637.27.1750644833842;
        Sun, 22 Jun 2025 19:13:53 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a6c87f5sm7111701b3a.178.2025.06.22.19.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 19:13:53 -0700 (PDT)
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
Subject: [PATCH net-next v4] net: xsk: introduce XDP_MAX_TX_BUDGET setsockopt
Date: Mon, 23 Jun 2025 10:13:45 +0800
Message-Id: <20250623021345.69211-1-kerneljasonxing@gmail.com>
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
- Add XDP_MAX_TX_BUDGET socket option.
- Unify TX_BATCH_SIZE and MAX_PER_SOCKET_BUDGET into single one
  tx_budget_spent.
- Set tx_budget_spent to 32 by default in the initialization phase as a
  per-socket granular control.

The idea behind this comes out of real workloads in production. We use a
user-level stack with xsk support to accelerate sending packets and
minimize triggering syscalls. When the packets are aggregated, it's not
hard to hit the upper bound (namely, 32). The moment user-space stack
fetches the -EAGAIN error number passed from sendto(), it will loop to try
again until all the expected descs from tx ring are sent out to the driver.
Enlarging the XDP_MAX_TX_BUDGET value contributes to less frequency of
sendto() and higher throughput/PPS.

Here is what I did in production, along with some numbers as follows:
For one application I saw lately, I suggested using 128 as max_tx_budget
because I saw two limitations without changing any default configuration:
1) XDP_MAX_TX_BUDGET, 2) socket sndbuf which is 212992 decided by
net.core.wmem_default. As to XDP_MAX_TX_BUDGET, the scenario behind
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

In terms of how xsk transmits packets, there are two known modes: one is
non-copy mode (that is what I used) and the other is zerocopy mode.
Zerocopy modes also has two different versions, one is non-batched
version and the other is batched version. Only non-batched version which
is normally treated as a fallback solution potentially has the same
max_tx_budget limitation issue as non-copy mode. So the patch adjusts
MAX_PER_SOCKET_BUDGET as well. It's worth mentioning that for non-batched
version may be stopped before hitting the limit of max_tx_budget due to
another budget limitation the caller (like ixgbe_xmit_zc()) of
xsk_tx_peek_desc() has.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
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
 include/net/xdp_sock.h              |  3 ++-
 include/uapi/linux/if_xdp.h         |  1 +
 net/xdp/xsk.c                       | 24 ++++++++++++++++++------
 tools/include/uapi/linux/if_xdp.h   |  1 +
 5 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
index dceeb0d763aa..fc9b608b96e1 100644
--- a/Documentation/networking/af_xdp.rst
+++ b/Documentation/networking/af_xdp.rst
@@ -442,6 +442,15 @@ is created by a privileged process and passed to a non-privileged one.
 Once the option is set, kernel will refuse attempts to bind that socket
 to a different interface.  Updating the value requires CAP_NET_RAW.
 
+XDP_MAX_TX_BUDGET setsockopt
+----------------------------
+
+This setsockopt sets the maximum number of descriptors that can be handled
+and passed to the driver at one send syscall. It is applied in two cases:
+non-zero copy mode and non-batched version of zero copy mode, to break
+the maximum iteration limitation for better throughput and less frequency
+of send syscall.
+
 XDP_STATISTICS getsockopt
 -------------------------
 
diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index e8bd6ddb7b12..fca7723ad8b3 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -65,7 +65,7 @@ struct xdp_sock {
 	struct xsk_queue *tx ____cacheline_aligned_in_smp;
 	struct list_head tx_list;
 	/* record the number of tx descriptors sent by this xsk and
-	 * when it exceeds MAX_PER_SOCKET_BUDGET, an opportunity needs
+	 * when it exceeds max_tx_budget, an opportunity needs
 	 * to be given to other xsks for sending tx descriptors, thereby
 	 * preventing other XSKs from being starved.
 	 */
@@ -84,6 +84,7 @@ struct xdp_sock {
 	struct list_head map_list;
 	/* Protects map_list */
 	spinlock_t map_list_lock;
+	u32 max_tx_budget;
 	/* Protects multiple processes in the control path */
 	struct mutex mutex;
 	struct xsk_queue *fq_tmp; /* Only as tmp storage before bind */
diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
index 44f2bb93e7e6..07c6d21c2f1c 100644
--- a/include/uapi/linux/if_xdp.h
+++ b/include/uapi/linux/if_xdp.h
@@ -79,6 +79,7 @@ struct xdp_mmap_offsets {
 #define XDP_UMEM_COMPLETION_RING	6
 #define XDP_STATISTICS			7
 #define XDP_OPTIONS			8
+#define XDP_MAX_TX_BUDGET		9
 
 struct xdp_umem_reg {
 	__u64 addr; /* Start of packet data area */
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 72c000c0ae5f..011a7cddf870 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -33,9 +33,6 @@
 #include "xdp_umem.h"
 #include "xsk.h"
 
-#define TX_BATCH_SIZE 32
-#define MAX_PER_SOCKET_BUDGET (TX_BATCH_SIZE)
-
 void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
 {
 	if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
@@ -424,7 +421,9 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
 	rcu_read_lock();
 again:
 	list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
-		if (xs->tx_budget_spent >= MAX_PER_SOCKET_BUDGET) {
+		int max_budget = READ_ONCE(xs->max_tx_budget);
+
+		if (xs->tx_budget_spent >= max_budget) {
 			budget_exhausted = true;
 			continue;
 		}
@@ -779,7 +778,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 static int __xsk_generic_xmit(struct sock *sk)
 {
 	struct xdp_sock *xs = xdp_sk(sk);
-	u32 max_batch = TX_BATCH_SIZE;
+	u32 max_budget = READ_ONCE(xs->max_tx_budget);
 	bool sent_frame = false;
 	struct xdp_desc desc;
 	struct sk_buff *skb;
@@ -797,7 +796,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 		goto out;
 
 	while (xskq_cons_peek_desc(xs->tx, &desc, xs->pool)) {
-		if (max_batch-- == 0) {
+		if (max_budget-- == 0) {
 			err = -EAGAIN;
 			goto out;
 		}
@@ -1437,6 +1436,18 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
 		mutex_unlock(&xs->mutex);
 		return err;
 	}
+	case XDP_MAX_TX_BUDGET:
+	{
+		unsigned int budget;
+
+		if (optlen != sizeof(budget))
+			return -EINVAL;
+		if (copy_from_sockptr(&budget, optval, sizeof(budget)))
+			return -EFAULT;
+
+		WRITE_ONCE(xs->max_tx_budget, max(budget, 1));
+		return 0;
+	}
 	default:
 		break;
 	}
@@ -1734,6 +1745,7 @@ static int xsk_create(struct net *net, struct socket *sock, int protocol,
 
 	xs = xdp_sk(sk);
 	xs->state = XSK_READY;
+	xs->max_tx_budget = 32;
 	mutex_init(&xs->mutex);
 
 	INIT_LIST_HEAD(&xs->map_list);
diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
index 44f2bb93e7e6..07c6d21c2f1c 100644
--- a/tools/include/uapi/linux/if_xdp.h
+++ b/tools/include/uapi/linux/if_xdp.h
@@ -79,6 +79,7 @@ struct xdp_mmap_offsets {
 #define XDP_UMEM_COMPLETION_RING	6
 #define XDP_STATISTICS			7
 #define XDP_OPTIONS			8
+#define XDP_MAX_TX_BUDGET		9
 
 struct xdp_umem_reg {
 	__u64 addr; /* Start of packet data area */
-- 
2.43.5


