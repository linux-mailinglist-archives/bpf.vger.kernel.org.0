Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED1E4702AE
	for <lists+bpf@lfdr.de>; Fri, 10 Dec 2021 15:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241916AbhLJOYq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Dec 2021 09:24:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59352 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242038AbhLJOYb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Dec 2021 09:24:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639146056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZUmTL6mHiI4qVCv3TwDVYIRmeC8P3WFvwYJf7M1Ri2g=;
        b=ad53lhef2fkjfD7DmmPcMu/LkKQlKxBfdOv1uJqkXji6NvIcBZeSGxfWTIz6nPpqvF5Ze3
        6LE5oS5gxOaWfu6qjX/0sHIowKT6Na5AMiHoDvWAXhedw4JJNiht9/U0BWuEUgxJItINRd
        E5yCNfq2ILoSbEiWkS3OE9RmGTmIsXE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-512-JxoPGG8yNdKnIAvK5RCLyA-1; Fri, 10 Dec 2021 09:20:55 -0500
X-MC-Unique: JxoPGG8yNdKnIAvK5RCLyA-1
Received: by mail-ed1-f72.google.com with SMTP id v10-20020aa7d9ca000000b003e7bed57968so8267500eds.23
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 06:20:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZUmTL6mHiI4qVCv3TwDVYIRmeC8P3WFvwYJf7M1Ri2g=;
        b=fgkhpwEa4JB5OHfyqPwDvJq8NWO2Y4s1YzFN2uLxBe1+axh/CfUbwpnzaeCpn9LU2t
         BeRwBeHjpzkS3LhbZF/RoZ9sFTyZd7K8pMDAIq4f5J2sTxOfESbxRPvoTPlGWJ/GDL4N
         d9CSWkYnuq5R9Ym1pV0Z3VBO4o3/kekl2atfVkGFiS8gl8sXrfg+1iFtLnsle7mKvQg2
         VWC6Osmue9Mwfs7+Mi8xPMvRBGU1GqsdCOR5ujJ+K7T/DS/HJT+kQgs60EL4+5gIFeAS
         QKP85YsnXHH0F3Cq8XUNaQ9lJqQNCEPIr2V7mpUEt8iboSskTCuafqc5s+8SIh8uwFdk
         fgBQ==
X-Gm-Message-State: AOAM533Cw3SGW72hDz/4tu8vuBJzDLCVi16561uFXoneJpfSKuuMO5Fm
        vedqSMnvsmODkZusMT8n1zbeqANyqjl+52rMAOUZ0539qeHztfW/kYCVpjCqazfVdF5IQ3fKenK
        sumLODMp4P0h9
X-Received: by 2002:a05:6402:b64:: with SMTP id cb4mr38168096edb.325.1639146053474;
        Fri, 10 Dec 2021 06:20:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzG+aoyOHKEHDPx7jc0NW7U9sPmaBQjmZdKvigQ4eo4eN+oY1mkzLE+s8SPt+Wrl0dM2PKpQQ==
X-Received: by 2002:a05:6402:b64:: with SMTP id cb4mr38167981edb.325.1639146052451;
        Fri, 10 Dec 2021 06:20:52 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id c7sm1586607ejd.91.2021.12.10.06.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 06:20:48 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 46BA1180450; Fri, 10 Dec 2021 15:20:47 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 4/8] xdp: Move conversion to xdp_frame out of map functions
Date:   Fri, 10 Dec 2021 15:20:04 +0100
Message-Id: <20211210142008.76981-5-toke@redhat.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211210142008.76981-1-toke@redhat.com>
References: <20211210142008.76981-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

All map redirect functions except XSK maps convert xdp_buff to xdp_frame
before enqueueing it. So move this conversion of out the map functions
and into xdp_do_redirect(). This removes a bit of duplicated code, but more
importantly it makes it possible to support caller-allocated xdp_frame
structures, which will be added in a subsequent commit.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/linux/bpf.h | 20 ++++++++++----------
 kernel/bpf/cpumap.c |  8 +-------
 kernel/bpf/devmap.c | 32 +++++++++++---------------------
 net/core/filter.c   | 24 +++++++++++++++++-------
 4 files changed, 39 insertions(+), 45 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8bbf08fbab66..691bb397500e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1621,17 +1621,17 @@ void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth);
 struct btf *bpf_get_btf_vmlinux(void);
 
 /* Map specifics */
-struct xdp_buff;
+struct xdp_frame;
 struct sk_buff;
 struct bpf_dtab_netdev;
 struct bpf_cpu_map_entry;
 
 void __dev_flush(void);
-int dev_xdp_enqueue(struct net_device *dev, struct xdp_buff *xdp,
+int dev_xdp_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
 		    struct net_device *dev_rx);
-int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_buff *xdp,
+int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_frame *xdpf,
 		    struct net_device *dev_rx);
-int dev_map_enqueue_multi(struct xdp_buff *xdp, struct net_device *dev_rx,
+int dev_map_enqueue_multi(struct xdp_frame *xdpf, struct net_device *dev_rx,
 			  struct bpf_map *map, bool exclude_ingress);
 int dev_map_generic_redirect(struct bpf_dtab_netdev *dst, struct sk_buff *skb,
 			     struct bpf_prog *xdp_prog);
@@ -1640,7 +1640,7 @@ int dev_map_redirect_multi(struct net_device *dev, struct sk_buff *skb,
 			   bool exclude_ingress);
 
 void __cpu_map_flush(void);
-int cpu_map_enqueue(struct bpf_cpu_map_entry *rcpu, struct xdp_buff *xdp,
+int cpu_map_enqueue(struct bpf_cpu_map_entry *rcpu, struct xdp_frame *xdpf,
 		    struct net_device *dev_rx);
 int cpu_map_generic_redirect(struct bpf_cpu_map_entry *rcpu,
 			     struct sk_buff *skb);
@@ -1818,26 +1818,26 @@ static inline void __dev_flush(void)
 {
 }
 
-struct xdp_buff;
+struct xdp_frame;
 struct bpf_dtab_netdev;
 struct bpf_cpu_map_entry;
 
 static inline
-int dev_xdp_enqueue(struct net_device *dev, struct xdp_buff *xdp,
+int dev_xdp_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
 		    struct net_device *dev_rx)
 {
 	return 0;
 }
 
 static inline
-int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_buff *xdp,
+int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_frame *xdpf,
 		    struct net_device *dev_rx)
 {
 	return 0;
 }
 
 static inline
-int dev_map_enqueue_multi(struct xdp_buff *xdp, struct net_device *dev_rx,
+int dev_map_enqueue_multi(struct xdp_frame *xdpf, struct net_device *dev_rx,
 			  struct bpf_map *map, bool exclude_ingress)
 {
 	return 0;
@@ -1865,7 +1865,7 @@ static inline void __cpu_map_flush(void)
 }
 
 static inline int cpu_map_enqueue(struct bpf_cpu_map_entry *rcpu,
-				  struct xdp_buff *xdp,
+				  struct xdp_frame *xdpf,
 				  struct net_device *dev_rx)
 {
 	return 0;
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 585b2b77ccc4..12798b2c68d9 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -746,15 +746,9 @@ static void bq_enqueue(struct bpf_cpu_map_entry *rcpu, struct xdp_frame *xdpf)
 		list_add(&bq->flush_node, flush_list);
 }
 
-int cpu_map_enqueue(struct bpf_cpu_map_entry *rcpu, struct xdp_buff *xdp,
+int cpu_map_enqueue(struct bpf_cpu_map_entry *rcpu, struct xdp_frame *xdpf,
 		    struct net_device *dev_rx)
 {
-	struct xdp_frame *xdpf;
-
-	xdpf = xdp_convert_buff_to_frame(xdp);
-	if (unlikely(!xdpf))
-		return -EOVERFLOW;
-
 	/* Info needed when constructing SKB on remote CPU */
 	xdpf->dev_rx = dev_rx;
 
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index f02d04540c0c..f29f439fac76 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -467,24 +467,19 @@ static void bq_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
 	bq->q[bq->count++] = xdpf;
 }
 
-static inline int __xdp_enqueue(struct net_device *dev, struct xdp_buff *xdp,
+static inline int __xdp_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
 				struct net_device *dev_rx,
 				struct bpf_prog *xdp_prog)
 {
-	struct xdp_frame *xdpf;
 	int err;
 
 	if (!dev->netdev_ops->ndo_xdp_xmit)
 		return -EOPNOTSUPP;
 
-	err = xdp_ok_fwd_dev(dev, xdp->data_end - xdp->data);
+	err = xdp_ok_fwd_dev(dev, xdpf->len);
 	if (unlikely(err))
 		return err;
 
-	xdpf = xdp_convert_buff_to_frame(xdp);
-	if (unlikely(!xdpf))
-		return -EOVERFLOW;
-
 	bq_enqueue(dev, xdpf, dev_rx, xdp_prog);
 	return 0;
 }
@@ -520,27 +515,27 @@ static u32 dev_map_bpf_prog_run_skb(struct sk_buff *skb, struct bpf_dtab_netdev
 	return act;
 }
 
-int dev_xdp_enqueue(struct net_device *dev, struct xdp_buff *xdp,
+int dev_xdp_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
 		    struct net_device *dev_rx)
 {
-	return __xdp_enqueue(dev, xdp, dev_rx, NULL);
+	return __xdp_enqueue(dev, xdpf, dev_rx, NULL);
 }
 
-int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_buff *xdp,
+int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_frame *xdpf,
 		    struct net_device *dev_rx)
 {
 	struct net_device *dev = dst->dev;
 
-	return __xdp_enqueue(dev, xdp, dev_rx, dst->xdp_prog);
+	return __xdp_enqueue(dev, xdpf, dev_rx, dst->xdp_prog);
 }
 
-static bool is_valid_dst(struct bpf_dtab_netdev *obj, struct xdp_buff *xdp)
+static bool is_valid_dst(struct bpf_dtab_netdev *obj, struct xdp_frame *xdpf)
 {
 	if (!obj ||
 	    !obj->dev->netdev_ops->ndo_xdp_xmit)
 		return false;
 
-	if (xdp_ok_fwd_dev(obj->dev, xdp->data_end - xdp->data))
+	if (xdp_ok_fwd_dev(obj->dev, xdpf->len))
 		return false;
 
 	return true;
@@ -586,14 +581,13 @@ static int get_upper_ifindexes(struct net_device *dev, int *indexes)
 	return n;
 }
 
-int dev_map_enqueue_multi(struct xdp_buff *xdp, struct net_device *dev_rx,
+int dev_map_enqueue_multi(struct xdp_frame *xdpf, struct net_device *dev_rx,
 			  struct bpf_map *map, bool exclude_ingress)
 {
 	struct bpf_dtab *dtab = container_of(map, struct bpf_dtab, map);
 	struct bpf_dtab_netdev *dst, *last_dst = NULL;
 	int excluded_devices[1+MAX_NEST_DEV];
 	struct hlist_head *head;
-	struct xdp_frame *xdpf;
 	int num_excluded = 0;
 	unsigned int i;
 	int err;
@@ -603,15 +597,11 @@ int dev_map_enqueue_multi(struct xdp_buff *xdp, struct net_device *dev_rx,
 		excluded_devices[num_excluded++] = dev_rx->ifindex;
 	}
 
-	xdpf = xdp_convert_buff_to_frame(xdp);
-	if (unlikely(!xdpf))
-		return -EOVERFLOW;
-
 	if (map->map_type == BPF_MAP_TYPE_DEVMAP) {
 		for (i = 0; i < map->max_entries; i++) {
 			dst = rcu_dereference_check(dtab->netdev_map[i],
 						    rcu_read_lock_bh_held());
-			if (!is_valid_dst(dst, xdp))
+			if (!is_valid_dst(dst, xdpf))
 				continue;
 
 			if (is_ifindex_excluded(excluded_devices, num_excluded, dst->dev->ifindex))
@@ -634,7 +624,7 @@ int dev_map_enqueue_multi(struct xdp_buff *xdp, struct net_device *dev_rx,
 			head = dev_map_index_hash(dtab, i);
 			hlist_for_each_entry_rcu(dst, head, index_hlist,
 						 lockdep_is_held(&dtab->index_lock)) {
-				if (!is_valid_dst(dst, xdp))
+				if (!is_valid_dst(dst, xdpf))
 					continue;
 
 				if (is_ifindex_excluded(excluded_devices, num_excluded,
diff --git a/net/core/filter.c b/net/core/filter.c
index fe27c91e3758..bfa4ffbced35 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3964,12 +3964,24 @@ int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
 	enum bpf_map_type map_type = ri->map_type;
 	void *fwd = ri->tgt_value;
 	u32 map_id = ri->map_id;
+	struct xdp_frame *xdpf;
 	struct bpf_map *map;
 	int err;
 
 	ri->map_id = 0; /* Valid map id idr range: [1,INT_MAX[ */
 	ri->map_type = BPF_MAP_TYPE_UNSPEC;
 
+	if (map_type == BPF_MAP_TYPE_XSKMAP) {
+		err = __xsk_map_redirect(fwd, xdp);
+		goto out;
+	}
+
+	xdpf = xdp_convert_buff_to_frame(xdp);
+	if (unlikely(!xdpf)) {
+		err = -EOVERFLOW;
+		goto err;
+	}
+
 	switch (map_type) {
 	case BPF_MAP_TYPE_DEVMAP:
 		fallthrough;
@@ -3977,17 +3989,14 @@ int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
 		map = READ_ONCE(ri->map);
 		if (unlikely(map)) {
 			WRITE_ONCE(ri->map, NULL);
-			err = dev_map_enqueue_multi(xdp, dev, map,
+			err = dev_map_enqueue_multi(xdpf, dev, map,
 						    ri->flags & BPF_F_EXCLUDE_INGRESS);
 		} else {
-			err = dev_map_enqueue(fwd, xdp, dev);
+			err = dev_map_enqueue(fwd, xdpf, dev);
 		}
 		break;
 	case BPF_MAP_TYPE_CPUMAP:
-		err = cpu_map_enqueue(fwd, xdp, dev);
-		break;
-	case BPF_MAP_TYPE_XSKMAP:
-		err = __xsk_map_redirect(fwd, xdp);
+		err = cpu_map_enqueue(fwd, xdpf, dev);
 		break;
 	case BPF_MAP_TYPE_UNSPEC:
 		if (map_id == INT_MAX) {
@@ -3996,7 +4005,7 @@ int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
 				err = -EINVAL;
 				break;
 			}
-			err = dev_xdp_enqueue(fwd, xdp, dev);
+			err = dev_xdp_enqueue(fwd, xdpf, dev);
 			break;
 		}
 		fallthrough;
@@ -4004,6 +4013,7 @@ int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
 		err = -EBADRQC;
 	}
 
+out:
 	if (unlikely(err))
 		goto err;
 
-- 
2.34.0

