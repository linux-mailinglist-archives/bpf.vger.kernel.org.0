Return-Path: <bpf+bounces-77329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E47CD76FA
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 00:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACD1F30204AB
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 23:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3099232E124;
	Mon, 22 Dec 2025 23:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="feiE/aSq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MECTrME7"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB51241139
	for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 23:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766445102; cv=none; b=VqWTB2f2rQm/NplXnmtMqOk+odSQeE09BY8MsygejPeXpzAZIbip+uDN3mv8/Se24Gj639jrTZ3uxn06/kA2oL5Mg/nnkz/duzO7DCgcoLwXIRK/aLwW5PDR284H3Uos0aL2f0VzLGVMxD1+x8kf3YFWuWtpQx7LU07nikVtaKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766445102; c=relaxed/simple;
	bh=oCCXBpGUE1iCR22Q8qeKX3CrjZmxAqORZ0DXw6h9eAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=es8WiAcDEi06mvFFVWrm142BBkyS60N4wVeqh8pGUJZlvueG0xe2XmqoA5OMewu7vPf02O/3E3aVAgDyi5S0u/xSwUo0HzQY/nDfXP1/Wapx6wpUxeun3U7zIlB/kKFL2xNH7RyL1Pnj6D32ADkkempMpIVUj0Ta6VNkNlobeKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=feiE/aSq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MECTrME7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766445099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dPPNPOPMjRxxFRHHS+WbJA2cX3PFTORJHHXde0IcY2k=;
	b=feiE/aSq0J0wO1xrxXnNd2oKlNNxeVYE9N23Ij1Rw+rkPWixDl32W5+rP/swDS509AvT03
	i3PZeI5rfZ5Ci7zYFKGWvhi0tPOPXvGYeU5M5axlRORdiLrF8DjIRBcCR0iNCFBMyj4Utu
	d0NUdgXP5rEDHpYPRq0SnML0lBsRVu4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-uQ2fDK8fPTmKE2aVnuuCtQ-1; Mon, 22 Dec 2025 18:11:37 -0500
X-MC-Unique: uQ2fDK8fPTmKE2aVnuuCtQ-1
X-Mimecast-MFC-AGG-ID: uQ2fDK8fPTmKE2aVnuuCtQ_1766445097
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4779edba8f3so29628375e9.3
        for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 15:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766445096; x=1767049896; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dPPNPOPMjRxxFRHHS+WbJA2cX3PFTORJHHXde0IcY2k=;
        b=MECTrME7ci+BiOPWbeQbWHZt0y3/ktLVf0nmLN/PXuVyFz5zfmTsf9NLIW3MQli56T
         0jh+puy1lxhbRzipk1P0go0ZP57n5A4gxwurE4DYy5zPfyZiWNtz76R0DRYvKFFvAyXG
         PwmNnVPPA6jKCOzJWRyLKQkwpYRMK3qyd7MbG9leqnkxGCSIVa0E5icFe2DPgOgH7TKQ
         hPbtLIE2IL9kbMaiAKr69VMg9eLSJPgP7ZA00wM0rOPs8nUwxdGD8XPvF7Fdbh1RWAqc
         NKgEncd177CsWQVcuxy/yY81WMlhuFKmfBNieBdNMci3cqFf5I9HYblgNq2egdELS65d
         u0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766445096; x=1767049896;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dPPNPOPMjRxxFRHHS+WbJA2cX3PFTORJHHXde0IcY2k=;
        b=oOw40REW0vKrTeyQtU+b7heUBlII+u+191d1pnY6bEa08SK2dD/ta22A1pTbfqMWEe
         cvxzAynsGF3OBhOcFzN+xKnwhMcQf/x2Rou0Mm0cQGMn2LB+GH5hvwUtpj//YXiBg9J2
         osTyfEmnacpmODYwx1RlzVR+lXKU12jHNfGK9MjMPVqed42Nmc3GncN2oz32syQId9RU
         qIJbTPFUXkKQUePzHhoQlWHPDZt4IcReGAm0TiAC27ftTwkCKvSKcbZUtlIEIQD62LyB
         TcdeWDAt6tWj8yZYzr/8of26i+M/PrBitbxY5Wuyk6UxtIW+ayBd425UxUk0dSCtDqKC
         zltw==
X-Forwarded-Encrypted: i=1; AJvYcCVASA/BjE88JAd7onWzXb1xoQNHvppTd3Cd+4fXfDCRlWCodZKhg0NAommeUbzBBMDvayE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh80hFaIhux6b1ncv9cRO6L022OpJOvMCaGMylwJ3IGUV/rAXZ
	uqUYgCevQPFLaRerjSCUi8Ulcxqxi4FZ+OKL/xl8BnXzGqgSqPEHhxFASM+n8/zSKInbgJ3eaXf
	xkN/QO7hBa69DZpqN8ktV5xgjAFns+OlHJb/LQrmPGvCu5s19VCDPQ8OV4S6ERA==
X-Gm-Gg: AY/fxX5nfeV1Y1CsuYXPkuDBfrgMKlzSVpDZywaY0aGlI3LTIiAZV4R+mmk2MxNEc0m
	5c5yERB2elxgNgR/raTBUrlT+pUM4hHRjlgT+aSWGjjNXuu/ui7njCs3+s1/k/K2Sstw6AT8MKv
	phA5KRCAZKPCUFy5CLNlIYpYC1CwVxzXgI8bA7d5vI3vL3MPsylMRwjUK0F5I406KeHaS4BkI4X
	0JpOk3DLAl69BHU9kvXaRsNb3T0laiX42R0hhv5BR5YqELFk8XTM64D5zP374obRH+eCsEpt0KR
	ckxqoFLf3o+xbUQTrk4D9Xm6RWmaZfan/2JAxhmfz+GJusJDcW2p+U1+pIT1vHa/KovFTusiP70
	M9tMfKRI/3EkMxihFy4tmspWvani2jeLgtQ==
X-Received: by 2002:a05:600c:470e:b0:475:da1a:53f9 with SMTP id 5b1f17b1804b1-47d1954778dmr120484425e9.14.1766445096189;
        Mon, 22 Dec 2025 15:11:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZnH6RIGYW1MsxLJNgh4oMlwKuJpGhdhfxC1W33oi/D5BDRkFdDtQdOFDpKGUYkFD3zA4oSQ==
X-Received: by 2002:a05:600c:470e:b0:475:da1a:53f9 with SMTP id 5b1f17b1804b1-47d1954778dmr120484145e9.14.1766445095620;
        Mon, 22 Dec 2025 15:11:35 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be272eaf8sm262805125e9.5.2025.12.22.15.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 15:11:34 -0800 (PST)
Date: Mon, 22 Dec 2025 18:11:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Bui Quang Minh <minhquangbui99@gmail.com>,
	Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] virtio-net: enable all napis before scheduling
 refill work
Message-ID: <20251222180931-mutt-send-email-mst@kernel.org>
References: <20251212152741.11656-1-minhquangbui99@gmail.com>
 <CACGkMEtzXmfDhiQiq=5qPGXG+rJcxGkWk0CZ4X_2cnr2UVH+eQ@mail.gmail.com>
 <3f5613e9-ccd0-4096-afc3-67ee94f6f660@gmail.com>
 <CACGkMEs+Mse7nhPPiqbd2doeGtPD2QD3BM_cztr6e=VfuiobHQ@mail.gmail.com>
 <5434a67e-dd6e-4cd1-870b-fdd32ad34a28@gmail.com>
 <20251221084218-mutt-send-email-mst@kernel.org>
 <8e69a404-18bf-4c91-a6c7-59d5ae831591@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e69a404-18bf-4c91-a6c7-59d5ae831591@redhat.com>

On Mon, Dec 22, 2025 at 12:58:01PM +0100, Paolo Abeni wrote:
> On 12/21/25 2:42 PM, Michael S. Tsirkin wrote:
> > On Fri, Dec 19, 2025 at 12:03:29PM +0700, Bui Quang Minh wrote:
> >> On 12/17/25 09:58, Jason Wang wrote:
> >>> On Wed, Dec 17, 2025 at 12:23 AM Bui Quang Minh
> >>> <minhquangbui99@gmail.com> wrote:
> >>>> I think we can unconditionally schedule the delayed refill after
> >>>> enabling all the RX NAPIs (don't check the boolean schedule_refill
> >>>> anymore) to ensure that we will have refill work. We can still keep the
> >>>> try_fill_recv here to fill the receive buffer earlier in normal case.
> >>>> What do you think?
> >>> Or we can have a reill_pending
> >>
> >> Okay, let me implement this in the next version.
> >>
> >>> but basically I think we need something
> >>> that is much more simple. That is, using a per rq work instead of a
> >>> global one?
> >>
> >> I think we can leave this in a net-next patch later.
> >>
> >> Thanks,
> >> Quang Minh
> > 
> > i am not sure per rq is not simpler than this pile of tricks.
> FWIW, I agree with Michael: the diffstat of the current patch is quite
> scaring, I don't think a per RQ work would be significantly larger, but
> should be significantly simpler to review and maintain.
> 
> I suggest doing directly the per RQ work implementation.
> 
> Thanks!
> 
> Paolo

I mean a stupidly mechanical move of all refill to per RQ is
rather trivial (CB). Compiled only, feel free to reuse.

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0369dda5ed60..4eb90b4e7b0f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -379,6 +379,15 @@ struct receive_queue {
 	struct xdp_rxq_info xsk_rxq_info;
 
 	struct xdp_buff **xsk_buffs;
+
+	/* Work struct for delayed refilling if we run low on memory. */
+	struct delayed_work refill;
+
+	/* Is delayed refill enabled? */
+	bool refill_enabled;
+
+	/* The lock to synchronize the access to refill_enabled */
+	spinlock_t refill_lock;
 };
 
 #define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
@@ -441,9 +450,6 @@ struct virtnet_info {
 	/* Packet virtio header size */
 	u8 hdr_len;
 
-	/* Work struct for delayed refilling if we run low on memory. */
-	struct delayed_work refill;
-
 	/* UDP tunnel support */
 	bool tx_tnl;
 
@@ -451,12 +457,6 @@ struct virtnet_info {
 
 	bool rx_tnl_csum;
 
-	/* Is delayed refill enabled? */
-	bool refill_enabled;
-
-	/* The lock to synchronize the access to refill_enabled */
-	spinlock_t refill_lock;
-
 	/* Work struct for config space updates */
 	struct work_struct config_work;
 
@@ -720,18 +720,11 @@ static void virtnet_rq_free_buf(struct virtnet_info *vi,
 		put_page(virt_to_head_page(buf));
 }
 
-static void enable_delayed_refill(struct virtnet_info *vi)
+static void disable_delayed_refill(struct receive_queue *rq)
 {
-	spin_lock_bh(&vi->refill_lock);
-	vi->refill_enabled = true;
-	spin_unlock_bh(&vi->refill_lock);
-}
-
-static void disable_delayed_refill(struct virtnet_info *vi)
-{
-	spin_lock_bh(&vi->refill_lock);
-	vi->refill_enabled = false;
-	spin_unlock_bh(&vi->refill_lock);
+	spin_lock_bh(&rq->refill_lock);
+	rq->refill_enabled = false;
+	spin_unlock_bh(&rq->refill_lock);
 }
 
 static void enable_rx_mode_work(struct virtnet_info *vi)
@@ -2935,38 +2928,20 @@ static void virtnet_napi_disable(struct receive_queue *rq)
 
 static void refill_work(struct work_struct *work)
 {
-	struct virtnet_info *vi =
-		container_of(work, struct virtnet_info, refill.work);
+	struct receive_queue *rq = container_of(work, struct receive_queue,
+						refill.work);
+	struct virtnet_info *vi = rq->vq->vdev->priv;
 	bool still_empty;
-	int i;
 
-	for (i = 0; i < vi->curr_queue_pairs; i++) {
-		struct receive_queue *rq = &vi->rq[i];
+	napi_disable(&rq->napi);
+	still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
+	virtnet_napi_do_enable(rq->vq, &rq->napi);
 
-		/*
-		 * When queue API support is added in the future and the call
-		 * below becomes napi_disable_locked, this driver will need to
-		 * be refactored.
-		 *
-		 * One possible solution would be to:
-		 *   - cancel refill_work with cancel_delayed_work (note:
-		 *     non-sync)
-		 *   - cancel refill_work with cancel_delayed_work_sync in
-		 *     virtnet_remove after the netdev is unregistered
-		 *   - wrap all of the work in a lock (perhaps the netdev
-		 *     instance lock)
-		 *   - check netif_running() and return early to avoid a race
-		 */
-		napi_disable(&rq->napi);
-		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
-		virtnet_napi_do_enable(rq->vq, &rq->napi);
-
-		/* In theory, this can happen: if we don't get any buffers in
-		 * we will *never* try to fill again.
-		 */
-		if (still_empty)
-			schedule_delayed_work(&vi->refill, HZ/2);
-	}
+	/* In theory, this can happen: if we don't get any buffers in
+	 * we will *never* try to fill again.
+	 */
+	if (still_empty)
+		schedule_delayed_work(&rq->refill, HZ / 2);
 }
 
 static int virtnet_receive_xsk_bufs(struct virtnet_info *vi,
@@ -3033,10 +3008,10 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 
 	if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
 		if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
-			spin_lock(&vi->refill_lock);
-			if (vi->refill_enabled)
-				schedule_delayed_work(&vi->refill, 0);
-			spin_unlock(&vi->refill_lock);
+			spin_lock(&rq->refill_lock);
+			if (rq->refill_enabled)
+				schedule_delayed_work(&rq->refill, 0);
+			spin_unlock(&rq->refill_lock);
 		}
 	}
 
@@ -3216,13 +3191,14 @@ static int virtnet_open(struct net_device *dev)
 	struct virtnet_info *vi = netdev_priv(dev);
 	int i, err;
 
-	enable_delayed_refill(vi);
-
 	for (i = 0; i < vi->max_queue_pairs; i++) {
+		/* Enable refill work before enabling NAPI */
+		vi->rq[i].refill_enabled = true;
+
 		if (i < vi->curr_queue_pairs)
 			/* Make sure we have some buffers: if oom use wq. */
 			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
-				schedule_delayed_work(&vi->refill, 0);
+				schedule_delayed_work(&vi->rq[i].refill, 0);
 
 		err = virtnet_enable_queue_pair(vi, i);
 		if (err < 0)
@@ -3241,11 +3217,10 @@ static int virtnet_open(struct net_device *dev)
 	return 0;
 
 err_enable_qp:
-	disable_delayed_refill(vi);
-	cancel_delayed_work_sync(&vi->refill);
-
 	for (i--; i >= 0; i--) {
+		disable_delayed_refill(&vi->rq[i]);
 		virtnet_disable_queue_pair(vi, i);
+		cancel_delayed_work_sync(&vi->rq[i].refill);
 		virtnet_cancel_dim(vi, &vi->rq[i].dim);
 	}
 
@@ -3437,29 +3412,19 @@ static void __virtnet_rx_pause(struct virtnet_info *vi,
 	}
 }
 
+static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
+{
+	disable_delayed_refill(rq);
+	cancel_delayed_work_sync(&rq->refill);
+	__virtnet_rx_pause(vi, rq);
+}
+
 static void virtnet_rx_pause_all(struct virtnet_info *vi)
 {
 	int i;
 
-	/*
-	 * Make sure refill_work does not run concurrently to
-	 * avoid napi_disable race which leads to deadlock.
-	 */
-	disable_delayed_refill(vi);
-	cancel_delayed_work_sync(&vi->refill);
 	for (i = 0; i < vi->max_queue_pairs; i++)
-		__virtnet_rx_pause(vi, &vi->rq[i]);
-}
-
-static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
-{
-	/*
-	 * Make sure refill_work does not run concurrently to
-	 * avoid napi_disable race which leads to deadlock.
-	 */
-	disable_delayed_refill(vi);
-	cancel_delayed_work_sync(&vi->refill);
-	__virtnet_rx_pause(vi, rq);
+		virtnet_rx_pause(vi, &vi->rq[i]);
 }
 
 static void __virtnet_rx_resume(struct virtnet_info *vi,
@@ -3474,15 +3439,17 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
 	if (running)
 		virtnet_napi_enable(rq);
 
+	spin_lock_bh(&rq->refill_lock);
+	rq->refill_enabled = true;
 	if (schedule_refill)
-		schedule_delayed_work(&vi->refill, 0);
+		schedule_delayed_work(&rq->refill, 0);
+	spin_unlock_bh(&rq->refill_lock);
 }
 
 static void virtnet_rx_resume_all(struct virtnet_info *vi)
 {
 	int i;
 
-	enable_delayed_refill(vi);
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		if (i < vi->curr_queue_pairs)
 			__virtnet_rx_resume(vi, &vi->rq[i], true);
@@ -3493,7 +3460,6 @@ static void virtnet_rx_resume_all(struct virtnet_info *vi)
 
 static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
 {
-	enable_delayed_refill(vi);
 	__virtnet_rx_resume(vi, rq, true);
 }
 
@@ -3768,6 +3734,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 	struct virtio_net_rss_config_trailer old_rss_trailer;
 	struct net_device *dev = vi->dev;
 	struct scatterlist sg;
+	int i;
 
 	if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
 		return 0;
@@ -3821,10 +3788,14 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 succ:
 	vi->curr_queue_pairs = queue_pairs;
 	/* virtnet_open() will refill when device is going to up. */
-	spin_lock_bh(&vi->refill_lock);
-	if (dev->flags & IFF_UP && vi->refill_enabled)
-		schedule_delayed_work(&vi->refill, 0);
-	spin_unlock_bh(&vi->refill_lock);
+	if (dev->flags & IFF_UP) {
+		for (i = 0; i < vi->curr_queue_pairs; i++) {
+			spin_lock_bh(&vi->rq[i].refill_lock);
+			if (vi->rq[i].refill_enabled)
+				schedule_delayed_work(&vi->rq[i].refill, 0);
+			spin_unlock_bh(&vi->rq[i].refill_lock);
+		}
+	}
 
 	return 0;
 }
@@ -3834,10 +3805,6 @@ static int virtnet_close(struct net_device *dev)
 	struct virtnet_info *vi = netdev_priv(dev);
 	int i;
 
-	/* Make sure NAPI doesn't schedule refill work */
-	disable_delayed_refill(vi);
-	/* Make sure refill_work doesn't re-enable napi! */
-	cancel_delayed_work_sync(&vi->refill);
 	/* Prevent the config change callback from changing carrier
 	 * after close
 	 */
@@ -3848,7 +3815,9 @@ static int virtnet_close(struct net_device *dev)
 	cancel_work_sync(&vi->config_work);
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
+		disable_delayed_refill(&vi->rq[i]);
 		virtnet_disable_queue_pair(vi, i);
+		cancel_delayed_work_sync(&vi->rq[i].refill);
 		virtnet_cancel_dim(vi, &vi->rq[i].dim);
 	}
 
@@ -5793,7 +5762,6 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
-	enable_delayed_refill(vi);
 	enable_rx_mode_work(vi);
 
 	if (netif_running(vi->dev)) {
@@ -6550,7 +6518,6 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 	if (!vi->rq)
 		goto err_rq;
 
-	INIT_DELAYED_WORK(&vi->refill, refill_work);
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		vi->rq[i].pages = NULL;
 		netif_napi_add_config(vi->dev, &vi->rq[i].napi, virtnet_poll,
@@ -6567,6 +6534,8 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 		u64_stats_init(&vi->rq[i].stats.syncp);
 		u64_stats_init(&vi->sq[i].stats.syncp);
 		mutex_init(&vi->rq[i].dim_lock);
+		INIT_DELAYED_WORK(&vi->rq[i].refill, refill_work);
+		spin_lock_init(&vi->rq[i].refill_lock);
 	}
 
 	return 0;
@@ -6892,7 +6861,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
 	INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
-	spin_lock_init(&vi->refill_lock);
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
 		vi->mergeable_rx_bufs = true;
@@ -7156,7 +7124,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 	net_failover_destroy(vi->failover);
 free_vqs:
 	virtio_reset_device(vdev);
-	cancel_delayed_work_sync(&vi->refill);
+	for (i = 0; i < vi->max_queue_pairs; i++)
+		cancel_delayed_work_sync(&vi->rq[i].refill);
 	free_receive_page_frags(vi);
 	virtnet_del_vqs(vi);
 free:


