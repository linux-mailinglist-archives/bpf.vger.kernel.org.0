Return-Path: <bpf+bounces-8325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7901784DAC
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 02:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B1A1C20B4E
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 00:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C48615B1;
	Wed, 23 Aug 2023 00:08:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6737E;
	Wed, 23 Aug 2023 00:08:57 +0000 (UTC)
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342D9CFF;
	Tue, 22 Aug 2023 17:08:55 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailnew.west.internal (Postfix) with ESMTP id EFFD32B000AD;
	Tue, 22 Aug 2023 20:08:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 22 Aug 2023 20:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1692749332; x=
	1692756532; bh=jPCtqvz3XzjkFMK7sglWGmRZBj7w2jZN4y8/YxndcMA=; b=t
	trPaLVm8aEkyenExWi45FjJkof0shENI5ArKgkfjgSFmpdmw9qmW947l4TZ/gI6q
	hOcxK8G32tVIa/qq7RsjrzayxYalyehr8mx9itnHrMCiLBl/JdvF7KlnGP9CQnzU
	iLA5zOnaFo2nMICUtmZhmeMTQttEqApx+3DBsMEwMNZ/b277UrfMcgFY1KIR1Dic
	RL0LFe5uUmNLQy0hAq5ZJQNL0mff2gghDVJlELDBR3RxH6vXjbUyfR4psk8MxTpm
	mjl8+6ninKonOuUpIFwR9A/rzfz+kOWMhocXyhS7LjeZZIF0hswuwVC4wtrlDeVI
	Qw79uz8OlGXoJgw5Fc/wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1692749332; x=
	1692756532; bh=jPCtqvz3XzjkFMK7sglWGmRZBj7w2jZN4y8/YxndcMA=; b=j
	Fp6FC2k+RlNghIdpwoluzmzhuLw9A3yyPtR8FZaqaaNoqZ7iSzbvIrnnK9kK0IwF
	SyjdGwmwX/S/CA2njbj6PvzaQiNfT32QvgRgypCCoYJA1Yi5hjuq/RO0HKfN0HSF
	aXAXdbs2m06BUnOODqwhpWJlcJYieYdMowpLpREu/7LJxxMnd0OeyubmxsRgLGSy
	vnWPEaUN2Q+clVdLXo11KiWXq98aXo1rq0AQnTv+pkF5W/MvyopCCDZr+ajo4f0m
	ujF8Qz+jMW+ezv+B/tqfP7CyMlcWvSMn7viCqpxmccSUvEbPYNVGHSSQJ/jT8TgO
	aovhZKOi8JsHVKB6CNddA==
X-ME-Sender: <xms:E07lZE8C5sL0gtD4t_TLbC-9PrlfzTLGJx6TXPIIblzUbusvPDcixg>
    <xme:E07lZMsRzIyzOJLffUgr_Llh9pFNV_y_qRzYCV3ceW0RZqpbWnu1XEiur_eAm5v_5
    U3DBdq21aInfQlwoQ>
X-ME-Received: <xmr:E07lZKBNZLMm2E2rQhqLi9ZkohK_QM27bfqOo6GmC2GdTLKBVPHXWmWUsuqP_tpZ8hA8kXqDFFANdh0xkLSvffbUAlLqnvopfXnZ_6H6rKjqWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvvddgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:E07lZEc51hMhaZPiZk2ILkKU5qagq9eXDHTROCPUXBVYY-zWxzKiPg>
    <xmx:E07lZJPxY4Vc0ixzmZHUyCUUNuME00KIOiDD9XS2JURX10aj-NoWHg>
    <xmx:E07lZOmJAkVoGJwaCj7wIOpwT3Yr21_E_-JGTb6TMfWckGnSoj01fQ>
    <xmx:FE7lZNv5rciQtkBmcdEtqRuRcFcQ44V-YoQ9iiItJYR1msxoOv0hEdReDV0>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Aug 2023 20:08:50 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: edumazet@google.com,
	hawk@kernel.org,
	martin.lau@linux.dev,
	andrii@kernel.org,
	john.fastabend@gmail.com,
	jiri@resnulli.us,
	pabeni@redhat.com,
	davem@davemloft.net,
	jhs@mojatatu.com,
	kuba@kernel.org,
	ast@kernel.org,
	xiyou.wangcong@gmail.com,
	daniel@iogearbox.net
Cc: song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH bpf-next 1/2] net: bpf: Make xdp and cls_bpf use bpf_prog_put_dev()
Date: Tue, 22 Aug 2023 18:08:30 -0600
Message-ID: <55ffbb77cd34d3460b16a3d79877d41ad7c43a34.1692748902.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692748902.git.dxu@dxuuu.xyz>
References: <cover.1692748902.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This commit adds a stubbed bpf_prog_put_dev() that is symmetric to
bpf_prog_get_type_dev() such that all bpf device attachments are using a
*_dev() API.

This gives core bpf the ability to do special refcnt handling for device
attachments.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/linux/bpf.h  |  1 +
 kernel/bpf/devmap.c  |  8 ++++----
 kernel/bpf/syscall.c |  6 ++++++
 net/core/dev.c       | 16 ++++++++--------
 net/sched/cls_bpf.c  |  4 ++--
 5 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index eced6400f778..08269ad8cc45 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2030,6 +2030,7 @@ void bpf_prog_sub(struct bpf_prog *prog, int i);
 void bpf_prog_inc(struct bpf_prog *prog);
 struct bpf_prog * __must_check bpf_prog_inc_not_zero(struct bpf_prog *prog);
 void bpf_prog_put(struct bpf_prog *prog);
+void bpf_prog_put_dev(struct bpf_prog *prog);
 
 void bpf_prog_free_id(struct bpf_prog *prog);
 void bpf_map_free_id(struct bpf_map *map);
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 4d42f6ed6c11..b5d33a87a560 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -212,7 +212,7 @@ static void dev_map_free(struct bpf_map *map)
 			hlist_for_each_entry_safe(dev, next, head, index_hlist) {
 				hlist_del_rcu(&dev->index_hlist);
 				if (dev->xdp_prog)
-					bpf_prog_put(dev->xdp_prog);
+					bpf_prog_put_dev(dev->xdp_prog);
 				dev_put(dev->dev);
 				kfree(dev);
 			}
@@ -228,7 +228,7 @@ static void dev_map_free(struct bpf_map *map)
 				continue;
 
 			if (dev->xdp_prog)
-				bpf_prog_put(dev->xdp_prog);
+				bpf_prog_put_dev(dev->xdp_prog);
 			dev_put(dev->dev);
 			kfree(dev);
 		}
@@ -800,7 +800,7 @@ static void __dev_map_entry_free(struct rcu_head *rcu)
 
 	dev = container_of(rcu, struct bpf_dtab_netdev, rcu);
 	if (dev->xdp_prog)
-		bpf_prog_put(dev->xdp_prog);
+		bpf_prog_put_dev(dev->xdp_prog);
 	dev_put(dev->dev);
 	kfree(dev);
 }
@@ -884,7 +884,7 @@ static struct bpf_dtab_netdev *__dev_map_alloc_node(struct net *net,
 
 	return dev;
 err_put_prog:
-	bpf_prog_put(prog);
+	bpf_prog_put_dev(prog);
 err_put_dev:
 	dev_put(dev->dev);
 err_out:
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 10666d17b9e3..d8e5530598f3 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2164,6 +2164,12 @@ void bpf_prog_put(struct bpf_prog *prog)
 }
 EXPORT_SYMBOL_GPL(bpf_prog_put);
 
+void bpf_prog_put_dev(struct bpf_prog *prog)
+{
+	bpf_prog_put(prog);
+}
+EXPORT_SYMBOL_GPL(bpf_prog_put_dev);
+
 static int bpf_prog_release(struct inode *inode, struct file *filp)
 {
 	struct bpf_prog *prog = filp->private_data;
diff --git a/net/core/dev.c b/net/core/dev.c
index 17e6281e408c..ed0ece344416 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5676,7 +5676,7 @@ static int generic_xdp_install(struct net_device *dev, struct netdev_bpf *xdp)
 	case XDP_SETUP_PROG:
 		rcu_assign_pointer(dev->xdp_prog, new);
 		if (old)
-			bpf_prog_put(old);
+			bpf_prog_put_dev(old);
 
 		if (old && !new) {
 			static_branch_dec(&generic_xdp_needed_key);
@@ -9167,7 +9167,7 @@ static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mode,
 	err = bpf_op(dev, &xdp);
 	if (err) {
 		if (prog)
-			bpf_prog_put(prog);
+			bpf_prog_put_dev(prog);
 		return err;
 	}
 
@@ -9202,7 +9202,7 @@ static void dev_xdp_uninstall(struct net_device *dev)
 		if (link)
 			link->dev = NULL;
 		else
-			bpf_prog_put(prog);
+			bpf_prog_put_dev(prog);
 
 		dev_xdp_set_link(dev, mode, NULL);
 	}
@@ -9326,7 +9326,7 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
 	else
 		dev_xdp_set_prog(dev, mode, new_prog);
 	if (cur_prog)
-		bpf_prog_put(cur_prog);
+		bpf_prog_put_dev(cur_prog);
 
 	return 0;
 }
@@ -9445,7 +9445,7 @@ static int bpf_xdp_link_update(struct bpf_link *link, struct bpf_prog *new_prog,
 
 	if (old_prog == new_prog) {
 		/* no-op, don't disturb drivers */
-		bpf_prog_put(new_prog);
+		bpf_prog_put_dev(new_prog);
 		goto out_unlock;
 	}
 
@@ -9457,7 +9457,7 @@ static int bpf_xdp_link_update(struct bpf_link *link, struct bpf_prog *new_prog,
 		goto out_unlock;
 
 	old_prog = xchg(&link->prog, new_prog);
-	bpf_prog_put(old_prog);
+	bpf_prog_put_dev(old_prog);
 
 out_unlock:
 	rtnl_unlock();
@@ -9568,9 +9568,9 @@ int dev_change_xdp_fd(struct net_device *dev, struct netlink_ext_ack *extack,
 
 err_out:
 	if (err && new_prog)
-		bpf_prog_put(new_prog);
+		bpf_prog_put_dev(new_prog);
 	if (old_prog)
-		bpf_prog_put(old_prog);
+		bpf_prog_put_dev(old_prog);
 	return err;
 }
 
diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
index 382c7a71f81f..20129d73dab4 100644
--- a/net/sched/cls_bpf.c
+++ b/net/sched/cls_bpf.c
@@ -258,7 +258,7 @@ static int cls_bpf_init(struct tcf_proto *tp)
 static void cls_bpf_free_parms(struct cls_bpf_prog *prog)
 {
 	if (cls_bpf_is_ebpf(prog))
-		bpf_prog_put(prog->filter);
+		bpf_prog_put_dev(prog->filter);
 	else
 		bpf_prog_destroy(prog->filter);
 
@@ -391,7 +391,7 @@ static int cls_bpf_prog_from_efd(struct nlattr **tb, struct cls_bpf_prog *prog,
 	if (tb[TCA_BPF_NAME]) {
 		name = nla_memdup(tb[TCA_BPF_NAME], GFP_KERNEL);
 		if (!name) {
-			bpf_prog_put(fp);
+			bpf_prog_put_dev(fp);
 			return -ENOMEM;
 		}
 	}
-- 
2.41.0


