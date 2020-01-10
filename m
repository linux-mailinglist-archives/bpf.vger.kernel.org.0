Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50B59136F3A
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2020 15:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgAJOWL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jan 2020 09:22:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52430 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727993AbgAJOWL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jan 2020 09:22:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578666129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6qALNQxuZLkfcSjOtx2V7WE8uqdmA8Jf5WXA5soF1Lo=;
        b=HWLfEbMg0fjX0/frVYTzWXE1kwZMa0fbpMG240ONXyEcodkm5Fa/JaWossXMf/Sj2Z+ARU
        E6XYMgXZBNP++hsVon/WkjlvpEPh4PyAWOakmcKr8iSnyniNpZQUaZzq+YWv87gZIiVxsA
        iuW/nFWJnz4/5RkO0+y+XdNdaZLzYPk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-VEALciZBO3C8mrDNKk2ckw-1; Fri, 10 Jan 2020 09:22:08 -0500
X-MC-Unique: VEALciZBO3C8mrDNKk2ckw-1
Received: by mail-wr1-f72.google.com with SMTP id c17so956487wrp.10
        for <bpf@vger.kernel.org>; Fri, 10 Jan 2020 06:22:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=6qALNQxuZLkfcSjOtx2V7WE8uqdmA8Jf5WXA5soF1Lo=;
        b=MqX99GvXOo/TzaQmAe9lu0U93Bh2ZjkSy1+PX3u+NV72qk18saZRmigLCUkA847xDs
         dtcc/G4l6vqH76uSh+++9k9/LipK6HmceDlhST8EH7rdA9pzbH6hZzhPHALX+3AlJbdG
         VmMB/igqwglUsYfo5GhxBBWEwP9Yek9koZdV7On9Nr2gyDCG8FGc61f900sRsEeuVfmp
         5iRI6uQIuocZL3ryLcg6YiV27NykPnWZecH+Ynme8rVhsg3sN6Q5fS8ulrOsrFoGbEPb
         AtWQsn1UG4eiBKI9dttAvKVlpojZU5FUx9Y3OBAaxr+QE0+YkNfT2gy6tuLY9pkX0nBe
         c5ew==
X-Gm-Message-State: APjAAAX0bUnw+8CEK7RPIJNUppfzcXV6mtrWxjVP+bydmOmtLmBkfPTD
        2zbG1VnAnpU97b/jz4Nwk6r8YY9Iu6QcHIEKRIulKZuiKzTHcl11Fv+r8LLGD0D8+0uCSIQ4EB0
        l680zz1bbIspX
X-Received: by 2002:a7b:cf26:: with SMTP id m6mr4424756wmg.17.1578666127640;
        Fri, 10 Jan 2020 06:22:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqyvVa2vm4p5CsCS270LxDXUuc7NE59/iO4S2QrIA44Ffnc+Vw7gNcYlucsS3JeCmlhNOVFu3w==
X-Received: by 2002:a7b:cf26:: with SMTP id m6mr4424732wmg.17.1578666127410;
        Fri, 10 Jan 2020 06:22:07 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id x10sm2307129wrv.60.2020.01.10.06.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 06:22:06 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0CC6F180099; Fri, 10 Jan 2020 15:22:04 +0100 (CET)
Subject: [PATCH bpf-next 2/2] xdp: Use bulking for non-map XDP_REDIRECT
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        =?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Date:   Fri, 10 Jan 2020 15:22:04 +0100
Message-ID: <157866612392.432695.249078779633883278.stgit@toke.dk>
In-Reply-To: <157866612174.432695.5077671447287539053.stgit@toke.dk>
References: <157866612174.432695.5077671447287539053.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

Since the bulk queue used by XDP_REDIRECT now lives in struct net_device,
we can re-use the bulking for the non-map version of the bpf_redirect()
helper. This is a simple matter of having xdp_do_redirect_slow() queue the
frame on the bulk queue instead of sending it out with __bpf_tx_xdp().

Unfortunately we can't make the bpf_redirect() helper return an error if
the ifindex doesn't exit (as bpf_redirect_map() does), because we don't
have a reference to the network namespace of the ingress device at the time
the helper is called. So we have to leave it as-is and keep the device
lookup in xdp_do_redirect_slow().

With this change, the performance of the xdp_redirect sample program goes
from 5Mpps to 8.4Mpps (a 68% increase).

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/linux/bpf.h |   13 +++++++++++--
 kernel/bpf/devmap.c |   31 ++++++++++++++++++++++---------
 net/core/filter.c   |   30 ++----------------------------
 3 files changed, 35 insertions(+), 39 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b14e51d56a82..25c050202536 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -962,7 +962,9 @@ struct sk_buff;
 
 struct bpf_dtab_netdev *__dev_map_lookup_elem(struct bpf_map *map, u32 key);
 struct bpf_dtab_netdev *__dev_map_hash_lookup_elem(struct bpf_map *map, u32 key);
-void __dev_map_flush(void);
+void __dev_flush(void);
+int dev_xdp_enqueue(struct net_device *dev, struct xdp_buff *xdp,
+		    struct net_device *dev_rx);
 int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_buff *xdp,
 		    struct net_device *dev_rx);
 int dev_map_generic_redirect(struct bpf_dtab_netdev *dst, struct sk_buff *skb,
@@ -1071,13 +1073,20 @@ static inline struct net_device  *__dev_map_hash_lookup_elem(struct bpf_map *map
 	return NULL;
 }
 
-static inline void __dev_map_flush(void)
+static inline void __dev_flush(void)
 {
 }
 
 struct xdp_buff;
 struct bpf_dtab_netdev;
 
+static inline
+int dev_xdp_enqueue(struct net_device *dev, struct xdp_buff *xdp,
+		    struct net_device *dev_rx)
+{
+	return 0;
+}
+
 static inline
 int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_buff *xdp,
 		    struct net_device *dev_rx)
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index bcb05cb6b728..adbb82770d02 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -81,7 +81,7 @@ struct bpf_dtab {
 	u32 n_buckets;
 };
 
-static DEFINE_PER_CPU(struct list_head, dev_map_flush_list);
+static DEFINE_PER_CPU(struct list_head, dev_flush_list);
 static DEFINE_SPINLOCK(dev_map_lock);
 static LIST_HEAD(dev_map_list);
 
@@ -357,16 +357,16 @@ static int bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
 	goto out;
 }
 
-/* __dev_map_flush is called from xdp_do_flush_map() which _must_ be signaled
+/* __dev_flush is called from xdp_do_flush_map() which _must_ be signaled
  * from the driver before returning from its napi->poll() routine. The poll()
  * routine is called either from busy_poll context or net_rx_action signaled
  * from NET_RX_SOFTIRQ. Either way the poll routine must complete before the
  * net device can be torn down. On devmap tear down we ensure the flush list
  * is empty before completing to ensure all flush operations have completed.
  */
-void __dev_map_flush(void)
+void __dev_flush(void)
 {
-	struct list_head *flush_list = this_cpu_ptr(&dev_map_flush_list);
+	struct list_head *flush_list = this_cpu_ptr(&dev_flush_list);
 	struct xdp_dev_bulk_queue *bq, *tmp;
 
 	rcu_read_lock();
@@ -398,7 +398,7 @@ static int bq_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
 		      struct net_device *dev_rx)
 
 {
-	struct list_head *flush_list = this_cpu_ptr(&dev_map_flush_list);
+	struct list_head *flush_list = this_cpu_ptr(&dev_flush_list);
 	struct xdp_dev_bulk_queue *bq = this_cpu_ptr(dev->xdp_bulkq);
 
 	if (unlikely(bq->count == DEV_MAP_BULK_SIZE))
@@ -419,10 +419,9 @@ static int bq_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
 	return 0;
 }
 
-int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_buff *xdp,
-		    struct net_device *dev_rx)
+static inline int _xdp_enqueue(struct net_device *dev, struct xdp_buff *xdp,
+			       struct net_device *dev_rx)
 {
-	struct net_device *dev = dst->dev;
 	struct xdp_frame *xdpf;
 	int err;
 
@@ -440,6 +439,20 @@ int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_buff *xdp,
 	return bq_enqueue(dev, xdpf, dev_rx);
 }
 
+int dev_xdp_enqueue(struct net_device *dev, struct xdp_buff *xdp,
+		    struct net_device *dev_rx)
+{
+	return _xdp_enqueue(dev, xdp, dev_rx);
+}
+
+int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_buff *xdp,
+		    struct net_device *dev_rx)
+{
+	struct net_device *dev = dst->dev;
+
+	return _xdp_enqueue(dev, xdp, dev_rx);
+}
+
 int dev_map_generic_redirect(struct bpf_dtab_netdev *dst, struct sk_buff *skb,
 			     struct bpf_prog *xdp_prog)
 {
@@ -760,7 +773,7 @@ static int __init dev_map_init(void)
 	register_netdevice_notifier(&dev_map_notifier);
 
 	for_each_possible_cpu(cpu)
-		INIT_LIST_HEAD(&per_cpu(dev_map_flush_list, cpu));
+		INIT_LIST_HEAD(&per_cpu(dev_flush_list, cpu));
 	return 0;
 }
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 42fd17c48c5f..550488162fe1 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3458,32 +3458,6 @@ static const struct bpf_func_proto bpf_xdp_adjust_meta_proto = {
 	.arg2_type	= ARG_ANYTHING,
 };
 
-static int __bpf_tx_xdp(struct net_device *dev,
-			struct bpf_map *map,
-			struct xdp_buff *xdp,
-			u32 index)
-{
-	struct xdp_frame *xdpf;
-	int err, sent;
-
-	if (!dev->netdev_ops->ndo_xdp_xmit) {
-		return -EOPNOTSUPP;
-	}
-
-	err = xdp_ok_fwd_dev(dev, xdp->data_end - xdp->data);
-	if (unlikely(err))
-		return err;
-
-	xdpf = convert_to_xdp_frame(xdp);
-	if (unlikely(!xdpf))
-		return -EOVERFLOW;
-
-	sent = dev->netdev_ops->ndo_xdp_xmit(dev, 1, &xdpf, XDP_XMIT_FLUSH);
-	if (sent <= 0)
-		return sent;
-	return 0;
-}
-
 static noinline int
 xdp_do_redirect_slow(struct net_device *dev, struct xdp_buff *xdp,
 		     struct bpf_prog *xdp_prog, struct bpf_redirect_info *ri)
@@ -3499,7 +3473,7 @@ xdp_do_redirect_slow(struct net_device *dev, struct xdp_buff *xdp,
 		goto err;
 	}
 
-	err = __bpf_tx_xdp(fwd, NULL, xdp, 0);
+	err = dev_xdp_enqueue(fwd, xdp, dev);
 	if (unlikely(err))
 		goto err;
 
@@ -3529,7 +3503,7 @@ static int __bpf_tx_xdp_map(struct net_device *dev_rx, void *fwd,
 
 void xdp_do_flush_map(void)
 {
-	__dev_map_flush();
+	__dev_flush();
 	__cpu_map_flush();
 	__xsk_map_flush();
 }

