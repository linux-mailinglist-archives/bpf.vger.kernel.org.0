Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091423E191C
	for <lists+bpf@lfdr.de>; Thu,  5 Aug 2021 18:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhHEQKi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Aug 2021 12:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhHEQKh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Aug 2021 12:10:37 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE870C061765;
        Thu,  5 Aug 2021 09:10:21 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b11so7293654wrx.6;
        Thu, 05 Aug 2021 09:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6Vv+kISC72wCvpQeciFaDZJ9IKz+oFeH/BbvTmATNf8=;
        b=hiWjjzG1huKDfL1b3dCLW7eMwzKOuFzCukRzEXiXQnAspWCJHh03CKdzcj7WDpdL4w
         9u9VAeGIPvPMlT+q6z+KAp8U0gxQvKv3sjvE6aGKSXgZnnY7DTOErbx7fqAPhaSbzOqK
         7h1OswVpmdxZFHCgBl5+mhYvZ/Sh6EJ6APqiBlSX1MCj4jZ5ppBJ0kGFkvNGZ7/0eHk7
         mBihME8GAhRz0UBAj9qXz3O/aT6GlUkuoZ3CO4MYNzXeSmkOaQbY/yjXpJtd+RzKZ6Cq
         i2wIA6rQM7elLG5e5t/zkExJj9FaDsLAaAC0DFanMQMpSGpwvC6HHyv3pcQg1jycnIEf
         A8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6Vv+kISC72wCvpQeciFaDZJ9IKz+oFeH/BbvTmATNf8=;
        b=M2J9F25Brmsn9UuW1HXZPSjnJmZpd1WNQbxsba523/DBOIWyc4Olet0mDqraGDnMD9
         /GBRlKh9jC3wPRxfGWWPYHGO2Fhr3OSs380oWh/jnWfhlyKfy1MwA4ud+MjD65mujdDH
         Y/pWvfjqBvdW7Ef/i7ZmknbpGUtvf7mWefJefJhLg5gfkV84/nnwZRHgzFSVQnGU9HMH
         A+fZn5dBGc7DI0SFiBQ53HR+Dn+6BHydV4/XQ0q5jdkHtqHN9mSSST2yf3b6jHE2sOru
         /eGwlugBJpxsQ8RvZ4TmtNmiTwXn0nuRZNyN2EdlKCewEcWFsrjmQRwP6uvW8S0blm5h
         yOcg==
X-Gm-Message-State: AOAM532e1rskelbaG8J+zvuo+FL9MjiRjFApFekJAhWT/88u/VwqXvsv
        taNhPMMRM0p1O1iHTZV0X+nsz+1ZKSoVDlE=
X-Google-Smtp-Source: ABdhPJz/WhBcD5A1IuoTfqgvn3THvKshJzgP2iC++3Ia+Dskgo8NYoksf6RkhPFws+62VZ9NKfy0VA==
X-Received: by 2002:adf:e6c4:: with SMTP id y4mr6120948wrm.220.1628179820204;
        Thu, 05 Aug 2021 09:10:20 -0700 (PDT)
Received: from localhost.localdomain ([77.109.191.101])
        by smtp.gmail.com with ESMTPSA id n5sm5843968wme.47.2021.08.05.09.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 09:10:19 -0700 (PDT)
From:   Jussi Maki <joamaki@gmail.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, daniel@iogearbox.net, j.vosburgh@gmail.com,
        andy@greyhouse.net, vfalico@gmail.com, andrii@kernel.org,
        maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
        Jussi Maki <joamaki@gmail.com>
Subject: [PATCH bpf-next v6 2/7] net: core: Add support for XDP redirection to slave device
Date:   Sat, 31 Jul 2021 05:57:33 +0000
Message-Id: <20210731055738.16820-3-joamaki@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210731055738.16820-1-joamaki@gmail.com>
References: <20210609135537.1460244-1-joamaki@gmail.com>
 <20210731055738.16820-1-joamaki@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds the ndo_xdp_get_xmit_slave hook for transforming XDP_TX
into XDP_REDIRECT after BPF program run when the ingress device
is a bond slave.

The dev_xdp_prog_count is exposed so that slave devices can be checked
for loaded XDP programs in order to avoid the situation where both
bond master and slave have programs loaded according to xdp_state.

Signed-off-by: Jussi Maki <joamaki@gmail.com>
---
 include/linux/filter.h    | 13 ++++++++++++-
 include/linux/netdevice.h |  6 ++++++
 net/core/dev.c            | 13 ++++++++++++-
 net/core/filter.c         | 25 +++++++++++++++++++++++++
 4 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index ba36989f711a..7ea1cc378042 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -761,6 +761,10 @@ static inline u32 bpf_prog_run_clear_cb(const struct bpf_prog *prog,
 
 DECLARE_BPF_DISPATCHER(xdp)
 
+DECLARE_STATIC_KEY_FALSE(bpf_master_redirect_enabled_key);
+
+u32 xdp_master_redirect(struct xdp_buff *xdp);
+
 static __always_inline u32 bpf_prog_run_xdp(const struct bpf_prog *prog,
 					    struct xdp_buff *xdp)
 {
@@ -768,7 +772,14 @@ static __always_inline u32 bpf_prog_run_xdp(const struct bpf_prog *prog,
 	 * under local_bh_disable(), which provides the needed RCU protection
 	 * for accessing map entries.
 	 */
-	return __BPF_PROG_RUN(prog, xdp, BPF_DISPATCHER_FUNC(xdp));
+	u32 act = __BPF_PROG_RUN(prog, xdp, BPF_DISPATCHER_FUNC(xdp));
+
+	if (static_branch_unlikely(&bpf_master_redirect_enabled_key)) {
+		if (act == XDP_TX && netif_is_bond_slave(xdp->rxq->dev))
+			act = xdp_master_redirect(xdp);
+	}
+
+	return act;
 }
 
 void bpf_prog_change_xdp(struct bpf_prog *prev_prog, struct bpf_prog *prog);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 42f6f866d5f3..a380786429e1 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1321,6 +1321,9 @@ struct netdev_net_notifier {
  *	that got dropped are freed/returned via xdp_return_frame().
  *	Returns negative number, means general error invoking ndo, meaning
  *	no frames were xmit'ed and core-caller will free all frames.
+ * struct net_device *(*ndo_xdp_get_xmit_slave)(struct net_device *dev,
+ *					        struct xdp_buff *xdp);
+ *      Get the xmit slave of master device based on the xdp_buff.
  * int (*ndo_xsk_wakeup)(struct net_device *dev, u32 queue_id, u32 flags);
  *      This function is used to wake up the softirq, ksoftirqd or kthread
  *	responsible for sending and/or receiving packets on a specific
@@ -1539,6 +1542,8 @@ struct net_device_ops {
 	int			(*ndo_xdp_xmit)(struct net_device *dev, int n,
 						struct xdp_frame **xdp,
 						u32 flags);
+	struct net_device *	(*ndo_xdp_get_xmit_slave)(struct net_device *dev,
+							  struct xdp_buff *xdp);
 	int			(*ndo_xsk_wakeup)(struct net_device *dev,
 						  u32 queue_id, u32 flags);
 	struct devlink_port *	(*ndo_get_devlink_port)(struct net_device *dev);
@@ -4071,6 +4076,7 @@ typedef int (*bpf_op_t)(struct net_device *dev, struct netdev_bpf *bpf);
 int dev_change_xdp_fd(struct net_device *dev, struct netlink_ext_ack *extack,
 		      int fd, int expected_fd, u32 flags);
 int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
+u8 dev_xdp_prog_count(struct net_device *dev);
 u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode);
 
 int __dev_forward_skb(struct net_device *dev, struct sk_buff *skb);
diff --git a/net/core/dev.c b/net/core/dev.c
index 3ee58876e8f5..27023ea933dd 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9353,7 +9353,7 @@ static struct bpf_prog *dev_xdp_prog(struct net_device *dev,
 	return dev->xdp_state[mode].prog;
 }
 
-static u8 dev_xdp_prog_count(struct net_device *dev)
+u8 dev_xdp_prog_count(struct net_device *dev)
 {
 	u8 count = 0;
 	int i;
@@ -9363,6 +9363,7 @@ static u8 dev_xdp_prog_count(struct net_device *dev)
 			count++;
 	return count;
 }
+EXPORT_SYMBOL_GPL(dev_xdp_prog_count);
 
 u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode)
 {
@@ -9456,6 +9457,8 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
 {
 	unsigned int num_modes = hweight32(flags & XDP_FLAGS_MODES);
 	struct bpf_prog *cur_prog;
+	struct net_device *upper;
+	struct list_head *iter;
 	enum bpf_xdp_mode mode;
 	bpf_op_t bpf_op;
 	int err;
@@ -9494,6 +9497,14 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
 		return -EBUSY;
 	}
 
+	/* don't allow if an upper device already has a program */
+	netdev_for_each_upper_dev_rcu(dev, upper, iter) {
+		if (dev_xdp_prog_count(upper) > 0) {
+			NL_SET_ERR_MSG(extack, "Cannot attach when an upper device already has a program");
+			return -EEXIST;
+		}
+	}
+
 	cur_prog = dev_xdp_prog(dev, mode);
 	/* can't replace attached prog with link */
 	if (link && cur_prog) {
diff --git a/net/core/filter.c b/net/core/filter.c
index faf29fd82276..ff62cd39046d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3950,6 +3950,31 @@ void bpf_clear_redirect_map(struct bpf_map *map)
 	}
 }
 
+DEFINE_STATIC_KEY_FALSE(bpf_master_redirect_enabled_key);
+EXPORT_SYMBOL_GPL(bpf_master_redirect_enabled_key);
+
+u32 xdp_master_redirect(struct xdp_buff *xdp)
+{
+	struct net_device *master, *slave;
+	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+
+	master = netdev_master_upper_dev_get_rcu(xdp->rxq->dev);
+	slave = master->netdev_ops->ndo_xdp_get_xmit_slave(master, xdp);
+	if (slave && slave != xdp->rxq->dev) {
+		/* The target device is different from the receiving device, so
+		 * redirect it to the new device.
+		 * Using XDP_REDIRECT gets the correct behaviour from XDP enabled
+		 * drivers to unmap the packet from their rx ring.
+		 */
+		ri->tgt_index = slave->ifindex;
+		ri->map_id = INT_MAX;
+		ri->map_type = BPF_MAP_TYPE_UNSPEC;
+		return XDP_REDIRECT;
+	}
+	return XDP_TX;
+}
+EXPORT_SYMBOL_GPL(xdp_master_redirect);
+
 int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
 		    struct bpf_prog *xdp_prog)
 {
-- 
2.17.1

