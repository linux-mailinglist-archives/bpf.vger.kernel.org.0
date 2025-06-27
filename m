Return-Path: <bpf+bounces-61747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99A3AEB5D3
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 13:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06F2C7ADE7C
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 11:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3364E2D12F7;
	Fri, 27 Jun 2025 11:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjLlc/zv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7AD2D12EF;
	Fri, 27 Jun 2025 11:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751022103; cv=none; b=CWFcAjI3rTrUYhjnS/QviWirdc2KR1VPsC43foJS+lZMi7JaARBm4GR6zlaGVrA+i21lOlXb+feI7rPt7xln3lUzGr1P4MkvdMs7PtrvLaCuLjjhVBcm36/ivDtlM6BgvM5i2zwINCzyL1CEh2lSds8fnQaeWVrqZzUh41xg6M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751022103; c=relaxed/simple;
	bh=tWjE5rL+ALHBK/SpLXj4tlD1jnmf9XHD+AgAA3V9LtI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mqt1LL14MFVHdohfxvJNqgAGfyX//wcXo7su3b2DfrjOVHPKya7w54ReNIdPiojvwsiMKnjKX1g5ZczbwNzyduk0hKxEdJNEn1O9ZlZxx/El1s/pZv5UsIMNsgUgQAuR3/n0GSDIsqvD17Rv+3R3y7YShxeJ95E1dx26Wd5rV88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjLlc/zv; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-748f5a4a423so1392138b3a.1;
        Fri, 27 Jun 2025 04:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751022101; x=1751626901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfJUkaGpQKRJTmRnispFKp1Kv+mcej8I9IRdLedBS3M=;
        b=NjLlc/zv3j3Q5JRxf+i4JwHvEyaxECeaqKyS8cGyxRp7XgjK78vZ7pjHDlPcF/Ga4s
         XpL53652B0IvdelTlOcQOpdJGDtGMFSfxl/7LbNAyGI/osvEYpR76nTLipdDs8Cpo6uq
         R1A8QU1fpTCqdTwwO2pVAwCD8/baTk0OjagG/pe1y4ftiBRudPedWDcL7KkSPb61cCV7
         kDzw7hXnqD12NtZqakHOZk81HQAJxn1yPkSOTGzpYvYawSC7OU3CULe84ON6hYkAK6Pi
         tgJhj2KJi+42O7ozvyHaw6QhWeEBatQ0ayAxK99QiFbi7cF8c/kXaFn5lik5UWO9jB3g
         VBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751022101; x=1751626901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZfJUkaGpQKRJTmRnispFKp1Kv+mcej8I9IRdLedBS3M=;
        b=FOzQO7iOHkhnyS8B8bZCLPVqtSx3Y+ZLqVcYeOUD9Mtm+3nlSnDHBf05VPWZ3drbPT
         E6CSeGvscxR5mWUHiEpjAmtHglPSfmQbXyZRsSn8eglTT+3BuR5mVauNP+cnsmxnihlU
         X5VBx86xaKQIsdWWJ7GZ9J5lVUo56h0OdD8HqvqpTUEpP678InxLRLx2R32A+EZmbCQN
         2JRw/7/dKCKgWI09Z5+NuJAAn/9oSG3QZP84yL26nU9px5gRDBgyUWXWCmCnVEAokvtR
         QjK1013hlVsRhBxaxhvDX7zrn8JVGwZFtGOasvRp7175kl9qSlNdN6xjLcMXN03eHJzY
         i8Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWzMw6bAxLxDKMDVDp03OSKBh3jaDbLTAJ6Y958dFQwJgncr3n2TBV6yJjwyVxGBcyQmdzDQSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ftnLmCPX1LMpxd5YiLBDLUguiivS26hI6N65qvODldbTfSVg
	Fy8G6zONWKYvN2UTRR9YnSAqGUDrP2pboDtKyQZlL55fcKNGxVttsM2y
X-Gm-Gg: ASbGncuqoB3lBOOcLndwFtPy7hiH2+gwzOEokgZfpemdFNbLp9DQHu8MMkBrH41CyAx
	RR6+9xm4AONkh3O38UKQtqKAIQtsNyG/RsAgInIE5fOsdzyf6bqu5QErV74HTnyln5zNjX+VXBF
	/a0TUL7ZTSlbQ3XsqHoIxtU5wJmNBpRUxnaRea6wb9z1AFLKtkK8Fw83Gao1jUBxoNQ7MNla+dX
	GScnkj0LPZCeWUapMT97g1NebQ2XkMpCY0+Jb3I7J88+DMRoaqhR7o+DgSGFX2/+3D+FtUA3l1T
	VWLkgVIru2Xjm4ugn/T6DOWrRTY3hvigCcSlcGZh1Eu3xVWSaWz9LOYZGXtx9wbTgFVrKVe/6Ln
	rx6zJhiUiphqKQj1HePjjQViLXBezFWUySQ==
X-Google-Smtp-Source: AGHT+IHkApzvtk2YetkkzXxAbNhQxIXXDwv4cVFBTxLtuF6gUjOlcPTT7ewOC5ZvQI/xKNnNQ7rLng==
X-Received: by 2002:aa7:88c7:0:b0:742:ae7e:7da8 with SMTP id d2e1a72fcca58-74af6ee4838mr4269137b3a.8.1751022100988;
        Fri, 27 Jun 2025 04:01:40 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57f0e62sm1927599b3a.162.2025.06.27.04.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 04:01:40 -0700 (PDT)
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
Subject: [PATCH net-next v6] net: xsk: introduce XDP_MAX_TX_BUDGET set/getsockopt
Date: Fri, 27 Jun 2025 19:01:21 +0800
Message-Id: <20250627110121.73228-1-kerneljasonxing@gmail.com>
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
- Convert TX_BATCH_SIZE to tx_budget_spent.
- Set tx_budget_spent to 32 by default in the initialization phase as a
  per-socket granular control. 32 is also the min value for
  tx_budget_spent.
- Set the range of tx_budget_spent as [32, xs->tx->nentries].

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
 Documentation/networking/af_xdp.rst |  9 +++++++
 include/net/xdp_sock.h              |  1 +
 include/uapi/linux/if_xdp.h         |  1 +
 net/xdp/xsk.c                       | 39 ++++++++++++++++++++++++++---
 tools/include/uapi/linux/if_xdp.h   |  1 +
 5 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
index dceeb0d763aa..253afee00162 100644
--- a/Documentation/networking/af_xdp.rst
+++ b/Documentation/networking/af_xdp.rst
@@ -442,6 +442,15 @@ is created by a privileged process and passed to a non-privileged one.
 Once the option is set, kernel will refuse attempts to bind that socket
 to a different interface.  Updating the value requires CAP_NET_RAW.
 
+XDP_MAX_TX_BUDGET setsockopt
+----------------------------
+
+This setsockopt sets the maximum number of descriptors that can be handled
+and passed to the driver at one send syscall. It is applied in the non-zero
+copy mode to allow application to tune the per-socket maximum iteration for
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
index 72c000c0ae5f..41efe7b27b0e 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -33,8 +33,8 @@
 #include "xdp_umem.h"
 #include "xsk.h"
 
-#define TX_BATCH_SIZE 32
-#define MAX_PER_SOCKET_BUDGET (TX_BATCH_SIZE)
+#define TX_BUDGET_SIZE 32
+#define MAX_PER_SOCKET_BUDGET 32
 
 void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
 {
@@ -779,7 +779,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 static int __xsk_generic_xmit(struct sock *sk)
 {
 	struct xdp_sock *xs = xdp_sk(sk);
-	u32 max_batch = TX_BATCH_SIZE;
+	u32 max_budget = READ_ONCE(xs->max_tx_budget);
 	bool sent_frame = false;
 	struct xdp_desc desc;
 	struct sk_buff *skb;
@@ -797,7 +797,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 		goto out;
 
 	while (xskq_cons_peek_desc(xs->tx, &desc, xs->pool)) {
-		if (max_batch-- == 0) {
+		if (max_budget-- == 0) {
 			err = -EAGAIN;
 			goto out;
 		}
@@ -1437,6 +1437,21 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
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
+		if (!xs->tx || xs->tx->nentries < TX_BUDGET_SIZE)
+			return -EACCES;
+
+		WRITE_ONCE(xs->max_tx_budget,
+			   clamp(budget, TX_BUDGET_SIZE, xs->tx->nentries));
+		return 0;
+	}
 	default:
 		break;
 	}
@@ -1588,6 +1603,21 @@ static int xsk_getsockopt(struct socket *sock, int level, int optname,
 
 		return 0;
 	}
+	case XDP_MAX_TX_BUDGET:
+	{
+		unsigned int budget;
+
+		if (len < sizeof(budget))
+			return -EINVAL;
+
+		budget = READ_ONCE(xs->max_tx_budget);
+		if (copy_to_user(optval, &budget, sizeof(budget)))
+			return -EFAULT;
+		if (put_user(sizeof(budget), optlen))
+			return -EFAULT;
+
+		return 0;
+	}
 	default:
 		break;
 	}
@@ -1734,6 +1764,7 @@ static int xsk_create(struct net *net, struct socket *sock, int protocol,
 
 	xs = xdp_sk(sk);
 	xs->state = XSK_READY;
+	xs->max_tx_budget = TX_BUDGET_SIZE;
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


