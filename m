Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1580E478146
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 01:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhLQA2I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 19:28:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53703 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230519AbhLQA17 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Dec 2021 19:27:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639700878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ikL+2IcIaOaXnLsz9KqosZl75IKRygJU8v59fEwhY0I=;
        b=I90xaVDTsC+yT0fWjlnlxwMNynJGAVCJHnpXgFWf4u+cbMLxYqCEUCPv+YCoWM8zrPO7tm
        mts/+ZNqD1vhykyxUB5zZo8YkEsA4X1rPfVXJNS9SpqXU6C1MOraCL9lW+xClesDWXTxUr
        jyNqmZsTFvhfJquv6+i/gYMIb3W7iuc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-320-zOT4_s4QPYu6FgXFI3weTg-1; Thu, 16 Dec 2021 19:27:57 -0500
X-MC-Unique: zOT4_s4QPYu6FgXFI3weTg-1
Received: by mail-ed1-f69.google.com with SMTP id s12-20020a50ab0c000000b003efdf5a226fso404324edc.10
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 16:27:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ikL+2IcIaOaXnLsz9KqosZl75IKRygJU8v59fEwhY0I=;
        b=C+RVrkKteLP9yP7fNBXl9uszxaZMeubagCWeVqV8E8YWx/iNuElPkKFrQkYs+6nigV
         wCfVXr8od4v6kYfe/l/Ow7Hoc+8PNuw57HBeLYUoPK+7+d7TII7yQlzuimV39otO7OtC
         enYaExsAr/wIlDXa7r/IMSVv2QaUp0nD4RFBCav+4ARD4xzBj2bs2ZdoPDHB7lmYIiKA
         5ZFJnzr+mq7nL/2G9ShUIhk5RZYIU1Dwhbr9FUWOXbd8rmu5O5kUl9fzbKuqONFBycNS
         wqnjXn9OnQxrRe/7YWE7Mf4eLkgjFxQE0OC8UEGQXl5+3kIjX+oHxJnvczVFZaymFvW2
         StSg==
X-Gm-Message-State: AOAM531KmhWiILPKFdzJbC/Y6oPvmbz27QDxZXZM86QLRpRt3FeeuXVV
        X95Vn4aQxEC2xjZhvzh7HP0GQuRMpdB3vox4DLBdD8apy42LKs7wH9Uh7GErQJbXNinEG1NGDZD
        tR7SFjpBFiU+L
X-Received: by 2002:aa7:d741:: with SMTP id a1mr437253eds.21.1639700875468;
        Thu, 16 Dec 2021 16:27:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzuc1FDeQHvXlBR8BTqJ4D9r3xTrFFq5jKo38DSu1OpsOpNTh0z4FCq1qfGEMzOV5lQqUo+Sw==
X-Received: by 2002:aa7:d741:: with SMTP id a1mr437191eds.21.1639700874635;
        Thu, 16 Dec 2021 16:27:54 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a3sm2320140ejd.16.2021.12.16.16.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:27:52 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 52C9C180441; Fri, 17 Dec 2021 01:27:52 +0100 (CET)
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
Subject: [PATCH bpf-next v4 4/7] xdp: Move conversion to xdp_frame out of map functions
Date:   Fri, 17 Dec 2021 01:27:38 +0100
Message-Id: <20211217002741.146797-5-toke@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217002741.146797-1-toke@redhat.com>
References: <20211217002741.146797-1-toke@redhat.com>
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
index 965fffaf0308..7d0513a85a2d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1616,17 +1616,17 @@ void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth);
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
@@ -1635,7 +1635,7 @@ int dev_map_redirect_multi(struct net_device *dev, struct sk_buff *skb,
 			   bool exclude_ingress);
 
 void __cpu_map_flush(void);
-int cpu_map_enqueue(struct bpf_cpu_map_entry *rcpu, struct xdp_buff *xdp,
+int cpu_map_enqueue(struct bpf_cpu_map_entry *rcpu, struct xdp_frame *xdpf,
 		    struct net_device *dev_rx);
 int cpu_map_generic_redirect(struct bpf_cpu_map_entry *rcpu,
 			     struct sk_buff *skb);
@@ -1813,26 +1813,26 @@ static inline void __dev_flush(void)
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
@@ -1860,7 +1860,7 @@ static inline void __cpu_map_flush(void)
 }
 
 static inline int cpu_map_enqueue(struct bpf_cpu_map_entry *rcpu,
-				  struct xdp_buff *xdp,
+				  struct xdp_frame *xdpf,
 				  struct net_device *dev_rx)
 {
 	return 0;
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 0421061d95f1..b3e6b9422238 100644
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
index 6feea293ff10..fe019dbdb3f0 100644
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
index 3f656391af7e..f4540c800f4a 100644
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
2.34.1

