Return-Path: <bpf+bounces-60893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D83FADE40C
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 08:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AA5A189CB53
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 06:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF982594B4;
	Wed, 18 Jun 2025 06:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7oeYUor"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333F52580F1;
	Wed, 18 Jun 2025 06:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750229767; cv=none; b=QRGC8Eqf8LaaDRfZbzaXjJofjVaasHYJrZwafre5L+FNMbKF25AiNkWKqw/lu4pfBR/HIbMmhn0CTVe7xjqQ89Wk76iU4PiwMPXAN0YxQZYiGtsXEWxoFyPhLT9Ab9x8nn14+CJKQDw1wAUPrAIFX/Oz5ioA2gXbx1WqqHzwHYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750229767; c=relaxed/simple;
	bh=Ufj1Ve1yx1z53tof+gYkfjzJ5vn/yw4UB29+0ds9ltM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UMB33m7jHo6xIobd9VigxIWkKUL7+il15blkVJgPODBt7BtIrDBrzE70G6GQujm73axMlfzqByISLwqyd2n68995ZTVjR2RgVR8AopsrN6eRbBjHO2wKDz3DIGjLMutVCh22+TTpmC8SDW37I4huGhhAY0rE9B+yCijEy6/TzpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7oeYUor; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-312e747d2d8so356997a91.0;
        Tue, 17 Jun 2025 23:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750229765; x=1750834565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zD4epyLQ1xLlDMRfj3B+WCP+Gez/lsY1w8BlgJOMNAk=;
        b=T7oeYUorK/lr1QDgx9o4bVkuoZwbb+a27wGKTRXll2w0OIIGsDqkDxVHF3OpwruCoS
         aJaJkP1ZPbcYqoQqRPFjZcKVsWIbS88eb/SM2aRSyW51XGbrHVuypCYgvxWi5eb5ofqJ
         8lYM7pPrYmgMRMOkNerLx3EruBkO9oiseO+ea0ci8BYKVP1B+RccWzwWUETi7A7cyX/P
         EFhQXv8xAxrLOe0mDwAgO1GwPT/fi+K3J7virfN8W2CWbGN6geKOovDzxlXW283vd9s3
         77fNuf0zAKOaSQZ02k7yEhT+ir050wp2JxoHGZXOt4tneropXE6SQ2VSa2prWXnNJuZI
         PFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750229765; x=1750834565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zD4epyLQ1xLlDMRfj3B+WCP+Gez/lsY1w8BlgJOMNAk=;
        b=IZKst50rhBM9678fYEFfqzFpQSpNUj+sCLojsVZCwcKPEY9xkRf9bTYWDhp7m8722b
         Iiifb1kxyVgCGteVz0/gNxGm4qtFcjxp/8JGTuVxT8GY+a/cjBdxpGCnetMgRYlIo0mL
         zWzf446xYyGjigJkZXECpnKlOExInAkwH7Rk3UqAxjc4AWHNT0EiPcOUpsEzsL+K4Ywo
         qpDuz+nuVIHL/8bSBozR4vfew+syw0PE9tCL4TwtF8EtHmZtc75TDurUyY9pTo8gkhDn
         9nmkryv0Pz02O+VSkE5hSrZ9b/QqF+s917VYSmNapJ06DpMLAe0aptgZslx4bAhWPrfF
         fOyg==
X-Forwarded-Encrypted: i=1; AJvYcCWNyPJ8RFYuATMi9NoFd63bwwKn6rA5+LNjkve6H1soQ14DVlpbJudGQWrDRiTvUFWe4ML2mH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyC8lAUgbgvg62VsgYzQjRSgLdHdNcR3AbWZ5SmoXE5ILlazf+
	OVojjdGyaQC+3ZjbIRCcowsv47jJOsS5vTdR9YjtwKYKWBolN6QUsL02
X-Gm-Gg: ASbGnctq85ITi3lDEffqAVJ15x/onXMG7170hKYT6zoaXncmTmeGodvaa75uXxQu6Ir
	H3E1wag+oxjEtifhZmlrJw07chv8YXQKBeICvlNDL803tJuj2nkBXrniazs/5//dz+Lb1axnerg
	QHI1z+TtFYTHzH0lUxO92jUwdtIdUpuImlyMPjSVUJm4vj/yS5fcKua+BScKL33/e4Z56abN0IY
	u6o9CshKnoqI4pwgL0Ume4IH0q0P6ju3K/PiQhXMQPmEZKP9qLyzozBMwZrB01/AMvA42GKxyS3
	adXRr/tkrYDudDJaLUr6J36Ha8y7/x9YqJANyrxs/DOuXNeLI6m/95/axbCqH8cUf65ZetQomkT
	rUigkokT+Qh0NXKh2VV/vx9Ruutg0Rogn7w==
X-Google-Smtp-Source: AGHT+IEtnTdWsIG6RSlbujnQtmVZpuH1mZixKMM8JLrsLXHgTbXBclHr/bkw6UQeiu8QyxsSHi5Ixw==
X-Received: by 2002:a17:90b:5627:b0:311:abba:53b6 with SMTP id 98e67ed59e1d1-3157c856847mr2096287a91.14.1750229765296;
        Tue, 17 Jun 2025 23:56:05 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de782e2sm91844535ad.103.2025.06.17.23.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 23:56:04 -0700 (PDT)
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
	joe@dama.to
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2] net: xsk: add sysctl_xsk_max_tx_budget in the xmit path
Date: Wed, 18 Jun 2025 14:55:53 +0800
Message-Id: <20250618065553.96822-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

For some applications, it's quite useful to let users have the chance to
tune the max budget, like accelerating transmission, when xsk is sending
packets. Exposing such a knob also helps auto/AI tuning in the long run.

The patch unifies two definitions into one that is 32 by default and
makes the sysctl knob namespecified.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v2
Link: https://lore.kernel.org/all/20250617002236.30557-1-kerneljasonxing@gmail.com/
1. use a per-netns sysctl knob
2. use sysctl_xsk_max_tx_budget to unify both definitions.
---
 include/net/netns/core.h   |  1 +
 include/net/xdp_sock.h     |  2 +-
 net/core/net_namespace.c   |  1 +
 net/core/sysctl_net_core.c |  8 ++++++++
 net/xdp/xsk.c              | 12 ++++++------
 5 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/net/netns/core.h b/include/net/netns/core.h
index 9b36f0ff0c20..f1ff15fd0032 100644
--- a/include/net/netns/core.h
+++ b/include/net/netns/core.h
@@ -14,6 +14,7 @@ struct netns_core {
 
 	int	sysctl_somaxconn;
 	int	sysctl_optmem_max;
+	int	sysctl_xsk_max_tx_budget;
 	u8	sysctl_txrehash;
 	u8	sysctl_tstamp_allow_data;
 
diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index e8bd6ddb7b12..57b26ad12aa1 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -65,7 +65,7 @@ struct xdp_sock {
 	struct xsk_queue *tx ____cacheline_aligned_in_smp;
 	struct list_head tx_list;
 	/* record the number of tx descriptors sent by this xsk and
-	 * when it exceeds MAX_PER_SOCKET_BUDGET, an opportunity needs
+	 * when it exceeds sysctl_xsk_max_tx_budget, an opportunity needs
 	 * to be given to other xsks for sending tx descriptors, thereby
 	 * preventing other XSKs from being starved.
 	 */
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index ae54f26709ca..890f8dc28690 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -396,6 +396,7 @@ static __net_init void preinit_net_sysctl(struct net *net)
 	net->core.sysctl_optmem_max = 128 * 1024;
 	net->core.sysctl_txrehash = SOCK_TXREHASH_ENABLED;
 	net->core.sysctl_tstamp_allow_data = 1;
+	net->core.sysctl_xsk_max_tx_budget = 32;
 }
 
 /* init code that must occur even if setup_net() is not called. */
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 5dbb2c6f371d..a51d9c7246ee 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -667,6 +667,14 @@ static struct ctl_table netns_core_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.proc_handler	= proc_dointvec_minmax
 	},
+	{
+		.procname	= "xsk_max_tx_budget",
+		.data		= &init_net.core.sysctl_xsk_max_tx_budget,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.extra1		= SYSCTL_ONE,
+		.proc_handler	= proc_dointvec_minmax
+	},
 	{
 		.procname	= "txrehash",
 		.data		= &init_net.core.sysctl_txrehash,
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 72c000c0ae5f..15df133b50d7 100644
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
@@ -424,7 +421,10 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
 	rcu_read_lock();
 again:
 	list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
-		if (xs->tx_budget_spent >= MAX_PER_SOCKET_BUDGET) {
+		struct sock *sk = (struct sock *)xs;
+		int max_budget = READ_ONCE(sock_net(sk)->core.sysctl_xsk_max_tx_budget);
+
+		if (xs->tx_budget_spent >= max_budget) {
 			budget_exhausted = true;
 			continue;
 		}
@@ -778,8 +778,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 static int __xsk_generic_xmit(struct sock *sk)
 {
+	u32 max_budget = READ_ONCE(sock_net(sk)->core.sysctl_xsk_max_tx_budget);
 	struct xdp_sock *xs = xdp_sk(sk);
-	u32 max_batch = TX_BATCH_SIZE;
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
-- 
2.43.5


