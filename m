Return-Path: <bpf+bounces-9017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BF678E342
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 01:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FC211C20850
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 23:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EC58C1F;
	Wed, 30 Aug 2023 23:28:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD958C11
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 23:28:35 +0000 (UTC)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4E4C9
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 16:28:33 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-79216d8e2cfso11373239f.1
        for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 16:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1693438113; x=1694042913; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qO4oHVMeF3PN/FsRZDW5+HN48tR0F4cYrDjxuervmcc=;
        b=Eu0NVCbcNENxU4orBwSrtqGgmihSut/PWtGAPbw2wOyvpCJQdk7hA6lP1g+1k5d+C7
         ae4Acdh+Fa3efuCr0CsyLWOOQpbtJ6O9GHm1jAJ24eZbnawbLwDTFOjH49qe1ma56c//
         1OqWXvFVOJUSD881Qje3Xm91ynq7X286LsgY1SYf2Rr4aX2dDTTaJhIPhwigMKoWJ1m/
         /bcH8wrXonwgGfg1MjaMBxTXXhjNdjlz6htRtPhHKU7PIDMrzpgOhJeoTJKhOKsQbXzx
         22F/riaYP6Nm644PCunG8fGX7fl78eSIaqYk4oAz7dQnmakq3S6UAzjti2zC3H2kndfs
         0AaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693438113; x=1694042913;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qO4oHVMeF3PN/FsRZDW5+HN48tR0F4cYrDjxuervmcc=;
        b=NM02o9De793uEvBdOvX+914FvlS5lrZjNbbWwV6jbUSBzQEslkyNsnzn0kOXMZk7S6
         eB14O95NJgJ9anftvvtgVcspXbRUCT6Sp5zrZYYGKYbuH+OUSgT7P8YQCpbLyQb3+571
         0fUaOkos1Pf5+imyw6YdKVD0YDL4KsNyF+vKvZ55+33sVR60x4N3jpUF/kC7xjVxGQIp
         ZdAmBd3RpdIYes9vB1p0GzoOFr02X5hirzw1rxxaBn4+4v2fiJpyyUpnZoLIph8LRvVx
         UhpmJjbizAZ4o0eVhxvmgB0zu9Cd+d7anOiXcWdtdF7vzLJo4c/4zXVp6DeyBvxeZgF6
         8pFg==
X-Gm-Message-State: AOJu0Yxk8ctGjasFsy/Gr1etkhx+UuFsPKudqr5VZl0GjNe763Y/4AvM
	4NTTk9QVguXtXxU2Dxn/4Py23Q==
X-Google-Smtp-Source: AGHT+IGHZX6zgxZVgpuwzmQ02MWpvEuUfxgBDG8q3JehNd8n4slhLq/nkl0RKY60VYpQx78mOh9ZbA==
X-Received: by 2002:a6b:e914:0:b0:783:57ae:1894 with SMTP id u20-20020a6be914000000b0078357ae1894mr4089814iof.9.1693438113284;
        Wed, 30 Aug 2023 16:28:33 -0700 (PDT)
Received: from dev-mkhalfella2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id x17-20020a029711000000b0041d73d0a412sm56753jai.19.2023.08.30.16.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 16:28:32 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: willemdebruijn.kernel@gmail.com
Cc: alexanderduyck@fb.com,
	bpf@vger.kernel.org,
	brouer@redhat.com,
	davem@davemloft.net,
	dhowells@redhat.com,
	edumazet@google.com,
	keescook@chromium.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	mkhalfella@purestorage.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	stable@vger.kernel.org
Subject: [PATCH v2] skbuff: skb_segment, Call zero copy functions before using skbuff frags
Date: Wed, 30 Aug 2023 17:28:11 -0600
Message-Id: <20230830232811.9876-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <64ed7188a2745_9cf208e1@penguin.notmuch>
References: <64ed7188a2745_9cf208e1@penguin.notmuch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,T_SPF_PERMERROR autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Commit bf5c25d60861 ("skbuff: in skb_segment, call zerocopy functions
once per nskb") added the call to zero copy functions in skb_segment().
The change introduced a bug in skb_segment() because skb_orphan_frags()
may possibly change the number of fragments or allocate new fragments
altogether leaving nrfrags and frag to point to the old values. This can
cause a panic with stacktrace like the one below.

[  193.894380] BUG: kernel NULL pointer dereference, address: 00000000000000bc
[  193.895273] CPU: 13 PID: 18164 Comm: vh-net-17428 Kdump: loaded Tainted: G           O      5.15.123+ #26
[  193.903919] RIP: 0010:skb_segment+0xb0e/0x12f0
[  194.021892] Call Trace:
[  194.027422]  <TASK>
[  194.072861]  tcp_gso_segment+0x107/0x540
[  194.082031]  inet_gso_segment+0x15c/0x3d0
[  194.090783]  skb_mac_gso_segment+0x9f/0x110
[  194.095016]  __skb_gso_segment+0xc1/0x190
[  194.103131]  netem_enqueue+0x290/0xb10 [sch_netem]
[  194.107071]  dev_qdisc_enqueue+0x16/0x70
[  194.110884]  __dev_queue_xmit+0x63b/0xb30
[  194.121670]  bond_start_xmit+0x159/0x380 [bonding]
[  194.128506]  dev_hard_start_xmit+0xc3/0x1e0
[  194.131787]  __dev_queue_xmit+0x8a0/0xb30
[  194.138225]  macvlan_start_xmit+0x4f/0x100 [macvlan]
[  194.141477]  dev_hard_start_xmit+0xc3/0x1e0
[  194.144622]  sch_direct_xmit+0xe3/0x280
[  194.147748]  __dev_queue_xmit+0x54a/0xb30
[  194.154131]  tap_get_user+0x2a8/0x9c0 [tap]
[  194.157358]  tap_sendmsg+0x52/0x8e0 [tap]
[  194.167049]  handle_tx_zerocopy+0x14e/0x4c0 [vhost_net]
[  194.173631]  handle_tx+0xcd/0xe0 [vhost_net]
[  194.176959]  vhost_worker+0x76/0xb0 [vhost]
[  194.183667]  kthread+0x118/0x140
[  194.190358]  ret_from_fork+0x1f/0x30
[  194.193670]  </TASK>

In this case calling skb_orphan_frags() updated nr_frags leaving nrfrags
local variable in skb_segment() stale. This resulted in the code hitting
i >= nrfrags prematurely and trying to move to next frag_skb using
list_skb pointer, which was NULL, and caused kernel panic. Move the call
to zero copy functions before using frags and nr_frags.

Fixes: bf5c25d60861 ("skbuff: in skb_segment, call zerocopy functions once per nskb")
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reported-by: Amit Goyal <agoyal@purestorage.com>
Cc: stable@vger.kernel.org
---
 net/core/skbuff.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a298992060e6..18a33dc2d6af 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4354,21 +4354,20 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	struct sk_buff *segs = NULL;
 	struct sk_buff *tail = NULL;
 	struct sk_buff *list_skb = skb_shinfo(head_skb)->frag_list;
-	skb_frag_t *frag = skb_shinfo(head_skb)->frags;
 	unsigned int mss = skb_shinfo(head_skb)->gso_size;
 	unsigned int doffset = head_skb->data - skb_mac_header(head_skb);
-	struct sk_buff *frag_skb = head_skb;
 	unsigned int offset = doffset;
 	unsigned int tnl_hlen = skb_tnl_header_len(head_skb);
 	unsigned int partial_segs = 0;
 	unsigned int headroom;
 	unsigned int len = head_skb->len;
+	struct sk_buff *frag_skb;
+	skb_frag_t *frag;
 	__be16 proto;
 	bool csum, sg;
-	int nfrags = skb_shinfo(head_skb)->nr_frags;
 	int err = -ENOMEM;
 	int i = 0;
-	int pos;
+	int nfrags, pos;
 
 	if ((skb_shinfo(head_skb)->gso_type & SKB_GSO_DODGY) &&
 	    mss != GSO_BY_FRAGS && mss != skb_headlen(head_skb)) {
@@ -4445,6 +4444,13 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	headroom = skb_headroom(head_skb);
 	pos = skb_headlen(head_skb);
 
+	if (skb_orphan_frags(head_skb, GFP_ATOMIC))
+		return ERR_PTR(-ENOMEM);
+
+	nfrags = skb_shinfo(head_skb)->nr_frags;
+	frag = skb_shinfo(head_skb)->frags;
+	frag_skb = head_skb;
+
 	do {
 		struct sk_buff *nskb;
 		skb_frag_t *nskb_frag;
@@ -4465,6 +4471,10 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		    (skb_headlen(list_skb) == len || sg)) {
 			BUG_ON(skb_headlen(list_skb) > len);
 
+			nskb = skb_clone(list_skb, GFP_ATOMIC);
+			if (unlikely(!nskb))
+				goto err;
+
 			i = 0;
 			nfrags = skb_shinfo(list_skb)->nr_frags;
 			frag = skb_shinfo(list_skb)->frags;
@@ -4483,12 +4493,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 				frag++;
 			}
 
-			nskb = skb_clone(list_skb, GFP_ATOMIC);
 			list_skb = list_skb->next;
 
-			if (unlikely(!nskb))
-				goto err;
-
 			if (unlikely(pskb_trim(nskb, len))) {
 				kfree_skb(nskb);
 				goto err;
@@ -4564,12 +4570,16 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		skb_shinfo(nskb)->flags |= skb_shinfo(head_skb)->flags &
 					   SKBFL_SHARED_FRAG;
 
-		if (skb_orphan_frags(frag_skb, GFP_ATOMIC) ||
-		    skb_zerocopy_clone(nskb, frag_skb, GFP_ATOMIC))
+		if (skb_zerocopy_clone(nskb, list_skb, GFP_ATOMIC))
 			goto err;
 
 		while (pos < offset + len) {
 			if (i >= nfrags) {
+				if (skb_orphan_frags(list_skb, GFP_ATOMIC) ||
+				    skb_zerocopy_clone(nskb, list_skb,
+						       GFP_ATOMIC))
+					goto err;
+
 				i = 0;
 				nfrags = skb_shinfo(list_skb)->nr_frags;
 				frag = skb_shinfo(list_skb)->frags;
@@ -4583,10 +4593,6 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 					i--;
 					frag--;
 				}
-				if (skb_orphan_frags(frag_skb, GFP_ATOMIC) ||
-				    skb_zerocopy_clone(nskb, frag_skb,
-						       GFP_ATOMIC))
-					goto err;
 
 				list_skb = list_skb->next;
 			}
-- 
2.17.1


