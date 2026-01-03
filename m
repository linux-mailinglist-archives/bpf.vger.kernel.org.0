Return-Path: <bpf+bounces-77732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10198CEFD3C
	for <lists+bpf@lfdr.de>; Sat, 03 Jan 2026 10:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3ACB3030922
	for <lists+bpf@lfdr.de>; Sat,  3 Jan 2026 09:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABA82F5A0D;
	Sat,  3 Jan 2026 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BFul5Vgc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NpPsZ1q5"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128972550AF
	for <bpf@vger.kernel.org>; Sat,  3 Jan 2026 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767431395; cv=none; b=lvNPReQJXyWY9VRE6BKIWeJzBXezKIyOaje2UGyjtWwBUCeRI43S/d2hJAR/2se0GBnq7pH8daYAD4Kw01IXAwEEXfUa8s4eJmj/cxgEtqZteAyVshxS+jPSx2AGfrw1CM6LsOZ5YCYupKGP3eChax1GK0Pko9pYI1UYRkb2l2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767431395; c=relaxed/simple;
	bh=ldez5d92BdAl3byc2thVTHIHXgt5PkMPJ6fUBHlWUnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvLXz1+TJIEPSInktCKzET1tDb/j++l8M91GNDIDrFQEK3pa2VhKDtSNlufOKT+nyroCyS1hYQ0szd+VqkVE9ph3C8RXMiphqGAvvN3v0PgaEWOPV3xn3MLN1WbqcL/lcdzPO1uxOxp0vulM00Cx9rKMn/Wnyrws6VlHm8ATgV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BFul5Vgc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NpPsZ1q5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767431391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tq0jkdY4zJO1gSHxLtVmIGWnvHEbldLGU4oXd1Fb7ZY=;
	b=BFul5VgcoSkA+sHoqQl9417t9Rrj0MBVygSB/CWVXuXtzdLlMb5KO3LlMUjtXdlpsYgA/a
	1Ns9Okjlp/DI0hkxVrdk2SShjr2qA7uqraHrjzKaTDC/glwzIYtluG3Qhor0e8dhwCjIEU
	9jS4Ke28lRhiJ5gjvQoqLNIMMRGiD94=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-szdNnWR0MMKdHG3_vwUt8Q-1; Sat, 03 Jan 2026 04:09:50 -0500
X-MC-Unique: szdNnWR0MMKdHG3_vwUt8Q-1
X-Mimecast-MFC-AGG-ID: szdNnWR0MMKdHG3_vwUt8Q_1767431389
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4310062d97bso7120468f8f.0
        for <bpf@vger.kernel.org>; Sat, 03 Jan 2026 01:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767431389; x=1768036189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tq0jkdY4zJO1gSHxLtVmIGWnvHEbldLGU4oXd1Fb7ZY=;
        b=NpPsZ1q5Qz5BDF+g/CSKbAPqqO6XB4JKctL/oxF0VRpymZn2FT6SfX+bioHRee/n7Z
         ML55agCbO3ggne21siqZgZTfwfl1HJD2aSbM1uB9Vm7Iq8eDj4WdWxjMdU30aSd27aG+
         VD37fxBn03j46CXKcPTDgd9dQ+7FvivVK+9ZjS4aRpJIsdJFdXhPoO1Jc+la/vxADplw
         WIrqx4B2U+QSjngp3P4842+BkmgLmOKHaGX3d7fBSPZoD/4aCiYdkRfLIVLHIK3nvg6L
         kDQDgCemWBoi99SS/SfwBKaub28WsW+2opmxenhjKDxKJAuNWX36WYQkW5K/CaN4AGBL
         IQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767431389; x=1768036189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tq0jkdY4zJO1gSHxLtVmIGWnvHEbldLGU4oXd1Fb7ZY=;
        b=WTe2nT2HPjraBU717Mj2deVtWYBT4DTB7OHNBMuuDmAhMW8iFyPCOooTu9d76y0vvl
         54E09M2f4AUBPWPTc0/wDOFo9DgEt3TuX6ZMSLWpMN2HQCoyRSw4YXsp7vzfnRaEMNvF
         zMOZs8cB8Ko+QpHLnzlOQvRMFZTHkQDPHsLM7UanmCjqZN2AeApPwjxyYkRL6z/dddwS
         fa4B1eOIJl0klprjr/a2gVFBsfSdpI1aNLsX/rr0Xjb9nb3lyR1DfA9hjhluKvfL8y+L
         OuVAhbPV1CqD56nlfAm9+Tyt63SqjH7k3WkkMZyML397jFARKpSWRIL7Ho1Io//b4XX0
         q8HA==
X-Forwarded-Encrypted: i=1; AJvYcCWbJ2P2Y8z+0h3r4tHJCCpUkl/FYkntOKasQ1lutChZYNaga9xX+tcCPQ6JMKRTu6Y5tnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyREXOZ96z14BkhZvHYrwkY4f3FWD2y7Ng3qKNjnhdDn6BBy2cI
	2G+NmbJKm0nzxD0wc1ZZ4+SwKMgq2TtBX/8oS0MogLx8dK4uuy6x3g0+5D6xdRlZoU9zGi6S61Q
	l543StgELHy8ROYuTCbrw1+N4maPAP/2h8fVlJs48YT/KrvvmkfhpjA==
X-Gm-Gg: AY/fxX7gQfJvz5ZUXxwUfYmc6oMfqKTgNwdmEovxGpwnTFEjv4QqRFM9rt+TGNQxZ0/
	oYKDbqo5FrWv9gv8w9bZXBehnVFoK2P8MY0EDTTO1U8ATpXPPrpQMahhlBVSiyu1quM2NuJTvM9
	oktdUuPnVeLwKYfOVXClW7uEX9qRJyRvZv6RiCTCARuizhoZ/NJSzu1rwBSoFxSe67eoazyACdR
	uBGlNq2IthBY92BwLfHRfYChGHcdb2P6JcAAys9eU5K7u3lDp/cImbwB8dqyP8ecvuvqq0+/EYj
	4aCXFOyODgRlrD5a2VLkzt6D3F7y3i/m1SXs7atzDU87gGUQlQt9Y6h6NXw9K/k9FRkIU2zFZfq
	GTStajg==
X-Received: by 2002:a5d:5d89:0:b0:432:852d:5662 with SMTP id ffacd0b85a97d-432852d56a5mr30674770f8f.63.1767431389325;
        Sat, 03 Jan 2026 01:09:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYLL6f78Du5FScscQaiLWlIJB1Wva0vpUEGAfls0P0WsGyyJi5vvm363jZpONr4qk72U69EA==
X-Received: by 2002:a5d:5d89:0:b0:432:852d:5662 with SMTP id ffacd0b85a97d-432852d56a5mr30674733f8f.63.1767431388784;
        Sat, 03 Jan 2026 01:09:48 -0800 (PST)
Received: from redhat.com ([2a06:c701:73d7:4800:ba30:1c4a:380d:b509])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1aee5sm89698857f8f.4.2026.01.03.01.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 01:09:48 -0800 (PST)
Date: Sat, 3 Jan 2026 04:09:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net v2 2/3] virtio-net: remove unused delayed refill
 worker
Message-ID: <20260103040903-mutt-send-email-mst@kernel.org>
References: <20260102152023.10773-1-minhquangbui99@gmail.com>
 <20260102152023.10773-3-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102152023.10773-3-minhquangbui99@gmail.com>

On Fri, Jan 02, 2026 at 10:20:22PM +0700, Bui Quang Minh wrote:
> Since we change to retry refilling receive buffer in NAPI poll instead

change->switched

> of delayed worker, remove all unused delayed refill worker code.

unused -> now unused

> 
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 86 ----------------------------------------
>  1 file changed, 86 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index ac514c9383ae..7e77a05b5662 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -441,9 +441,6 @@ struct virtnet_info {
>  	/* Packet virtio header size */
>  	u8 hdr_len;
>  
> -	/* Work struct for delayed refilling if we run low on memory. */
> -	struct delayed_work refill;
> -
>  	/* UDP tunnel support */
>  	bool tx_tnl;
>  
> @@ -451,12 +448,6 @@ struct virtnet_info {
>  
>  	bool rx_tnl_csum;
>  
> -	/* Is delayed refill enabled? */
> -	bool refill_enabled;
> -
> -	/* The lock to synchronize the access to refill_enabled */
> -	spinlock_t refill_lock;
> -
>  	/* Work struct for config space updates */
>  	struct work_struct config_work;
>  
> @@ -720,20 +711,6 @@ static void virtnet_rq_free_buf(struct virtnet_info *vi,
>  		put_page(virt_to_head_page(buf));
>  }
>  
> -static void enable_delayed_refill(struct virtnet_info *vi)
> -{
> -	spin_lock_bh(&vi->refill_lock);
> -	vi->refill_enabled = true;
> -	spin_unlock_bh(&vi->refill_lock);
> -}
> -
> -static void disable_delayed_refill(struct virtnet_info *vi)
> -{
> -	spin_lock_bh(&vi->refill_lock);
> -	vi->refill_enabled = false;
> -	spin_unlock_bh(&vi->refill_lock);
> -}
> -
>  static void enable_rx_mode_work(struct virtnet_info *vi)
>  {
>  	rtnl_lock();
> @@ -2948,42 +2925,6 @@ static void virtnet_napi_disable(struct receive_queue *rq)
>  	napi_disable(napi);
>  }
>  
> -static void refill_work(struct work_struct *work)
> -{
> -	struct virtnet_info *vi =
> -		container_of(work, struct virtnet_info, refill.work);
> -	bool still_empty;
> -	int i;
> -
> -	for (i = 0; i < vi->curr_queue_pairs; i++) {
> -		struct receive_queue *rq = &vi->rq[i];
> -
> -		/*
> -		 * When queue API support is added in the future and the call
> -		 * below becomes napi_disable_locked, this driver will need to
> -		 * be refactored.
> -		 *
> -		 * One possible solution would be to:
> -		 *   - cancel refill_work with cancel_delayed_work (note:
> -		 *     non-sync)
> -		 *   - cancel refill_work with cancel_delayed_work_sync in
> -		 *     virtnet_remove after the netdev is unregistered
> -		 *   - wrap all of the work in a lock (perhaps the netdev
> -		 *     instance lock)
> -		 *   - check netif_running() and return early to avoid a race
> -		 */
> -		napi_disable(&rq->napi);
> -		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
> -		virtnet_napi_do_enable(rq->vq, &rq->napi);
> -
> -		/* In theory, this can happen: if we don't get any buffers in
> -		 * we will *never* try to fill again.
> -		 */
> -		if (still_empty)
> -			schedule_delayed_work(&vi->refill, HZ/2);
> -	}
> -}
> -
>  static int virtnet_receive_xsk_bufs(struct virtnet_info *vi,
>  				    struct receive_queue *rq,
>  				    int budget,
> @@ -3222,8 +3163,6 @@ static int virtnet_open(struct net_device *dev)
>  	struct virtnet_info *vi = netdev_priv(dev);
>  	int i, err;
>  
> -	enable_delayed_refill(vi);
> -
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
>  		if (i < vi->curr_queue_pairs)
>  			/* If this fails, we will retry later in
> @@ -3249,9 +3188,6 @@ static int virtnet_open(struct net_device *dev)
>  	return 0;
>  
>  err_enable_qp:
> -	disable_delayed_refill(vi);
> -	cancel_delayed_work_sync(&vi->refill);
> -
>  	for (i--; i >= 0; i--) {
>  		virtnet_disable_queue_pair(vi, i);
>  		virtnet_cancel_dim(vi, &vi->rq[i].dim);
> @@ -3445,24 +3381,12 @@ static void virtnet_rx_pause_all(struct virtnet_info *vi)
>  {
>  	int i;
>  
> -	/*
> -	 * Make sure refill_work does not run concurrently to
> -	 * avoid napi_disable race which leads to deadlock.
> -	 */
> -	disable_delayed_refill(vi);
> -	cancel_delayed_work_sync(&vi->refill);
>  	for (i = 0; i < vi->max_queue_pairs; i++)
>  		__virtnet_rx_pause(vi, &vi->rq[i]);
>  }
>  
>  static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
>  {
> -	/*
> -	 * Make sure refill_work does not run concurrently to
> -	 * avoid napi_disable race which leads to deadlock.
> -	 */
> -	disable_delayed_refill(vi);
> -	cancel_delayed_work_sync(&vi->refill);
>  	__virtnet_rx_pause(vi, rq);
>  }
>  
> @@ -3486,7 +3410,6 @@ static void virtnet_rx_resume_all(struct virtnet_info *vi)
>  {
>  	int i;
>  
> -	enable_delayed_refill(vi);
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
>  		if (i < vi->curr_queue_pairs)
>  			__virtnet_rx_resume(vi, &vi->rq[i], true);
> @@ -3497,7 +3420,6 @@ static void virtnet_rx_resume_all(struct virtnet_info *vi)
>  
>  static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
>  {
> -	enable_delayed_refill(vi);
>  	__virtnet_rx_resume(vi, rq, true);
>  }
>  
> @@ -3848,10 +3770,6 @@ static int virtnet_close(struct net_device *dev)
>  	struct virtnet_info *vi = netdev_priv(dev);
>  	int i;
>  
> -	/* Make sure NAPI doesn't schedule refill work */
> -	disable_delayed_refill(vi);
> -	/* Make sure refill_work doesn't re-enable napi! */
> -	cancel_delayed_work_sync(&vi->refill);
>  	/* Prevent the config change callback from changing carrier
>  	 * after close
>  	 */
> @@ -5807,7 +5725,6 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>  
>  	virtio_device_ready(vdev);
>  
> -	enable_delayed_refill(vi);
>  	enable_rx_mode_work(vi);
>  
>  	if (netif_running(vi->dev)) {
> @@ -6564,7 +6481,6 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
>  	if (!vi->rq)
>  		goto err_rq;
>  
> -	INIT_DELAYED_WORK(&vi->refill, refill_work);
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
>  		vi->rq[i].pages = NULL;
>  		netif_napi_add_config(vi->dev, &vi->rq[i].napi, virtnet_poll,
> @@ -6906,7 +6822,6 @@ static int virtnet_probe(struct virtio_device *vdev)
>  
>  	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
>  	INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
> -	spin_lock_init(&vi->refill_lock);
>  
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
>  		vi->mergeable_rx_bufs = true;
> @@ -7170,7 +7085,6 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	net_failover_destroy(vi->failover);
>  free_vqs:
>  	virtio_reset_device(vdev);
> -	cancel_delayed_work_sync(&vi->refill);
>  	free_receive_page_frags(vi);
>  	virtnet_del_vqs(vi);
>  free:
> -- 
> 2.43.0


