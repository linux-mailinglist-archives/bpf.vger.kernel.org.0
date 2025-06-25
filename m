Return-Path: <bpf+bounces-61521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBC2AE82D0
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 14:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6177C189DADC
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 12:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFB925B31A;
	Wed, 25 Jun 2025 12:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGvghHQg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D5420ED;
	Wed, 25 Jun 2025 12:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750854939; cv=none; b=VI6xL2lfPmVImLvCrbjbx/TO93hP2twShSyzHEq0aVxWzbV3bsiwOZVk7zbACZThATm+KfHfTdO0Pb4QQ5CfnV4M2qPtIF+HOtsusw8p/XGRDPdyk4HIEtuv4GBazwnNATM8OcsQiwOF7bz1iiEIzX7fJyoR/4N40Bt2FMbSxps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750854939; c=relaxed/simple;
	bh=8FXzTrRkJr0cco/CuYEG0CoNl9/a4X+qy4M0ytDky0s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rppHAoMhvozOW66VZVURBBOlVgBA5KTshEq/eVm+mZ6kxkUw3zlcVLcysRtfNz1piC6xhlBUnbPsLSk9WFJP+9wKVVSNKuGWkJK53npim/XLju+F8M/+Xx9Pu1fzRdHcakyhbCX8Vx6tEL4CdDArVV490rKKrGsfTHMRDzgqjgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGvghHQg; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-234b9dfb842so59764285ad.1;
        Wed, 25 Jun 2025 05:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750854937; x=1751459737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lMbxrnYbLGj4kuh2UGjRlAbTQgP/Mg+Bg95YryHbJ5E=;
        b=SGvghHQglBKQxxQR4mrscFguMj72mwFQfMLtgQiPOfCppriOPDQ+6RMKabCyG/iKei
         VtwRDmKj1E4xq3dSZYz9TJndjmsUCU7LvswRW0Q5hM8SdLNVJfqRG3oVYABb1Yu+OBM8
         HYtdijFncOiv2vlumYzngeO9m81yaz5V905GutKHmM9TA/52koaKWmqinVw4ATQ4EswD
         0U48E3UCz/M+lZjcCtO35g3Wu7TAh/hW6c6dqrgxQs1IeWtrYvkQFIu92bWEkKc2bmzW
         NO/drjYIBvjElbGNkp+5FCBrIdH/hvcb66uVSYu6zV0m3PK8ibUBr4fA16C0cRmhRRTS
         bk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750854937; x=1751459737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMbxrnYbLGj4kuh2UGjRlAbTQgP/Mg+Bg95YryHbJ5E=;
        b=DA03ln5Wk3x7+4UmMZV17Mq0NjAHUhKzZwJ0wUGXo16r5AKlQismAz6fqatnu9RKAk
         T//Asq2gMvoRZmIJfOaEP8wqKFBOmfRj1FFcy44pBoIt4pIJBuXiPegDAE0Q0STNSt20
         hw9CmbZuXCq4LFZWppDRDVaCeKJjsQidafc11elgBU7tC7/r3eX3EAKcTUn6YECTiHHP
         r7Kmme+jyyUBSvJBrva20NgapVdFFi/N2q8WERWLrcWTtq+PEpIzg3LzWrpWxD8gtKgW
         QYuMPnoNzyz2BnJJ0PiCr2V48K1WqUuYfZIE8cB9cle6kpurx9gmDFkMEm7FNt6oFW+Y
         LUmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyh8eB4fFNUHt1iwxXt7kwgRrV52WOYjfDSrVwvGS4Zz3UWZFJaArnbirg81J6ur28PQHu38k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYqK4/MR1Ah/49aFJyWwc/7AIfvxmZAO3XWV/fuosmPVerFjX0
	gUcjRHCuMQO9CjXHODWB3ahF1efmvNak8D2UtC1uvkAPjG/CQFbV460m
X-Gm-Gg: ASbGnctitY4/6nnmN/5AqxRnweMs0yhCEmbYkXmU0EvfiLZvKKrtwYuNXtqalxKbEij
	xIlqfScpwx7+Cd/+6NZlEWgvbecniZj2sOUeLbYQ8M793KGgs1VtiQGkOj2sFn4iJzlDH0/0AOH
	aeugxEKO8y9JfVEs4yWoBc6LksEvR9ZV8LW5cmDbWyQfmc/HUhMUHapJTMVaUuXLm2IK5Xwj2lI
	hLeQ6QmGjptYNWIsFWJ9J7lHYu2X7aL41g5ZRobEdqPaTV1kHPTmRHvCiG+vTwls/KBUtu4rKxa
	t8VD28nIy3o77Nr1ssUx7lSaoIJu/dCmWJn83hsUmftDuTDcPMRg13z34O+Ubb9firrJw2EcYIq
	G8+o9ysc820ZL1vcyCLXaHA==
X-Google-Smtp-Source: AGHT+IGvtgBjUcwWyHm5eDORglo+mq4soDAW743LIMjkeF3Yu6SQymuBy1Pyfq6BfauyW/DiLibYyA==
X-Received: by 2002:a17:903:2f4c:b0:236:9dd9:b75d with SMTP id d9443c01a7336-23824062f58mr54431295ad.40.1750854936791;
        Wed, 25 Jun 2025 05:35:36 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.26.0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83f1e1fsm136159655ad.83.2025.06.25.05.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 05:35:36 -0700 (PDT)
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
Subject: [PATCH net-next v5] net: xsk: introduce XDP_MAX_TX_BUDGET setsockopt
Date: Wed, 25 Jun 2025 20:35:27 +0800
Message-Id: <20250625123527.98209-1-kerneljasonxing@gmail.com>
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
- Convert TX_BATCH_SIZE tx_budget_spent.
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

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
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
 Documentation/networking/af_xdp.rst |  8 ++++++++
 include/net/xdp_sock.h              |  1 +
 include/uapi/linux/if_xdp.h         |  1 +
 net/xdp/xsk.c                       | 20 ++++++++++++++++----
 tools/include/uapi/linux/if_xdp.h   |  1 +
 5 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
index dceeb0d763aa..9eb6f7b630a5 100644
--- a/Documentation/networking/af_xdp.rst
+++ b/Documentation/networking/af_xdp.rst
@@ -442,6 +442,14 @@ is created by a privileged process and passed to a non-privileged one.
 Once the option is set, kernel will refuse attempts to bind that socket
 to a different interface.  Updating the value requires CAP_NET_RAW.
 
+XDP_MAX_TX_BUDGET setsockopt
+----------------------------
+
+This setsockopt sets the maximum number of descriptors that can be handled
+and passed to the driver at one send syscall. It is applied in the non-zero
+copy mode to allow application to tune the per-socket maximum iteration for
+better throughput and less frequency of send syscall. Default is 32.
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
index 72c000c0ae5f..97aded3555c1 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -33,8 +33,7 @@
 #include "xdp_umem.h"
 #include "xsk.h"
 
-#define TX_BATCH_SIZE 32
-#define MAX_PER_SOCKET_BUDGET (TX_BATCH_SIZE)
+#define MAX_PER_SOCKET_BUDGET 32
 
 void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
 {
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
2.41.3


