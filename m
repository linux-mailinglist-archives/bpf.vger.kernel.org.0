Return-Path: <bpf+bounces-77968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9069CF91AC
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 16:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08F4130321DC
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 15:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5282F33DEED;
	Tue,  6 Jan 2026 15:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2yrldDq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AaOtllve"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A4F15CD74
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767713355; cv=none; b=Y3dBvXfEZ5RZ/PfhLT1TpRV2DQKRllxeYsPTKmtgCqz7rtvOHmPpQckxOi6ivK5F9YvIJgCCudTny051tJyTkDEuaaKE5YKfwdSPELx9cC8xQZIPNB2Hrw7ovQ2TTxwSuZq7H9nP3tMBcX5Y+WYx9sFuOeYDvDpIxGypnXg0iqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767713355; c=relaxed/simple;
	bh=ORBUTAza06yVYLn8Gg5h7JdLV16kPZGZnkfL1uLRIPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEukyLVbkpuxSSObRzaZUwbCKGk8ElAcpn3hP8qVq/nRvACquM21nleNflsNDD09SHNJTIXfl44+Je1U3bKnjyS++pHgDx2rWS4bYFzY/orX/87xkr3qiXkq9/X2Cz1mmKBqMDGJ/xX9XZlpExp9pntE0GNtSLWWFukqajT7Oes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a2yrldDq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AaOtllve; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767713352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6mutPiJahqf07tX0K9jDs+Vqe+Q2f0S7Ia0chn9JrkM=;
	b=a2yrldDqBs69zbkz3iUaSTBqaGGB5t44t3qZtUhpLz29YrJ/roSt1mtE3ojdUQgryx+Chj
	BO0CWHhSOfgCATLIAUXlI9KVlahGrmZgzk7cWjIzOzE1od3Qlewrxah6ILoCfKxwd6rTeL
	HFeTHs8DrZaff9+5PJ68bZmloFJIHuA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-f3LRhvTsP9KZ2DL3NF6o-Q-1; Tue, 06 Jan 2026 10:29:11 -0500
X-MC-Unique: f3LRhvTsP9KZ2DL3NF6o-Q-1
X-Mimecast-MFC-AGG-ID: f3LRhvTsP9KZ2DL3NF6o-Q_1767713350
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-64d589a5799so1695329a12.1
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 07:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767713350; x=1768318150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6mutPiJahqf07tX0K9jDs+Vqe+Q2f0S7Ia0chn9JrkM=;
        b=AaOtllvenVvjWeWtkkiyOORyEOZ0bg1USex3MDtecTmShUSwYqny/lzE+39GbYspYE
         XW6QE+tMvIDnpML4fvCfGo/UNHihVt+FBA2T9yQJxow4+mkcov5tPc/jo+85YEN/lv1S
         cMCBpiPAKaCs9pZDoVCr+cVmtY/tUl068Eyak1Q6Sq+khFScb3FQtWusVSGFtGPP7qi4
         lGtc3tt6oTcKutIWtZROeF4X7+V8+tdtOSZKars/Co0fxI0MZ2GCn7OD23t/tXOVTsXb
         6F0exZGLEFsd74x/urofx1tbsI7WGuyBBVXMYF6VGJyAC6xkYsjv3moH2dleyfTf8ixh
         Ae5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767713350; x=1768318150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mutPiJahqf07tX0K9jDs+Vqe+Q2f0S7Ia0chn9JrkM=;
        b=aThNjTOFzMGB6BEMoHckqwBXqYc2jFOoTMqiEHSX4dSjraXlmnQ8gJ+1FVslgkXr0g
         P/1pLtkH1MpSfsue2XaPsxrnSw+JYJcLuTyXrdcGM/IE8/O2/+bb1P1TTScp16YqQVGb
         OocaTpgNKeIM3l6Rn3RTrZW/jNyuLfhsPriLqJ2HhE1iELwMy3reZwSxVA/kL1gLsxGM
         0jMjmTowpsRBm/XTiPUfCBqzkFkiYK5KkcUOzPE6Qu+CWiBx5LRfv+3lvtfz8D6kN6KA
         0kwhlDdIZBSGJ3mw51iBQTvCj3SbkUQZFZILEbeNuMp+U9lZMEb0gl8Z54aHzhM1ERpb
         2bXg==
X-Forwarded-Encrypted: i=1; AJvYcCXDh5vr4sLJa6axRK001/lOgi36UtgapE6VJjN4WKPmXwRtIIu9NQ4ELOJtbKCPbj39t6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw02GcGHJRKLTghBNdbWF3lg96LP+Y50KyCo410CuA3z97citLn
	oOFGl3TjtodMCP/jfTZm9v5sOSMe2rahcH1NGuyJZSf4tlNhusCtV7V7dTJFc0ANYrydUvq4E6b
	4uItHgbmoROmPIig86pffd0U0tQhQRORhKhB6Z8fB1o/+mCfizGiCcg==
X-Gm-Gg: AY/fxX4UZ8m7zfdHLDqD9Si8ArX8aab2Wk/lQp9PBSFrTGew58KhdEjRHaEPeAc4o/v
	9p+rbycRKomn2axTd16hjEdNpHdjiWSy7StiFkXMyr3G0HUEskJsMFCNdACWqrX9NB/8uBsE18N
	4XljAGwO38ffHdssBgldjiuKdYzvcBZlbBgJum7Mdv6dwOgKl8jV+6UheS+ut6foGNQyvlNBCNm
	ksIhuDPcfcvz1mGiGwERssz/6blkVUfQ8Ik/FRwbSobp0sgb3IV6FnX5ilFPvWowb1WKbk5nMlH
	vYKkXuW70WX6+aYh8ZFCXveD2WrouCLuRXtZ22ILLmfBBK5l+onI7bqFqQ71uuuvsbLkIE4eoo0
	KJC9Oit7oTeIUm5AQsY4k9uHhBzya44mOfw==
X-Received: by 2002:a17:907:97c7:b0:b80:11fd:793b with SMTP id a640c23a62f3a-b8426a6849bmr317261966b.19.1767713349832;
        Tue, 06 Jan 2026 07:29:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWb6y9xsvseC+MSQM10NdjJ3BS0aRkbGgQvy+bzZrBc9IB4ICJIxfQsaMFe9coDqIqquWjJA==
X-Received: by 2002:a17:907:97c7:b0:b80:11fd:793b with SMTP id a640c23a62f3a-b8426a6849bmr317258866b.19.1767713349329;
        Tue, 06 Jan 2026 07:29:09 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a27c760sm261977866b.24.2026.01.06.07.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 07:29:08 -0800 (PST)
Date: Tue, 6 Jan 2026 10:29:05 -0500
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
	bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/3] virtio-net: don't schedule delayed refill
 worker
Message-ID: <20260106100959-mutt-send-email-mst@kernel.org>
References: <20260106150438.7425-1-minhquangbui99@gmail.com>
 <20260106150438.7425-2-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106150438.7425-2-minhquangbui99@gmail.com>

On Tue, Jan 06, 2026 at 10:04:36PM +0700, Bui Quang Minh wrote:
> When we fail to refill the receive buffers, we schedule a delayed worker
> to retry later. However, this worker creates some concurrency issues.
> For example, when the worker runs concurrently with virtnet_xdp_set,
> both need to temporarily disable queue's NAPI before enabling again.
> Without proper synchronization, a deadlock can happen when
> napi_disable() is called on an already disabled NAPI. That
> napi_disable() call will be stuck and so will the subsequent
> napi_enable() call.
> 
> To simplify the logic and avoid further problems, we will instead retry
> refilling in the next NAPI poll.
> 
> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
> Cc: stable@vger.kernel.org
> Suggested-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

and CC stable I think. Can you do that pls?

> ---
>  drivers/net/virtio_net.c | 48 +++++++++++++++++++++-------------------
>  1 file changed, 25 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1bb3aeca66c6..f986abf0c236 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3046,16 +3046,16 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>  	else
>  		packets = virtnet_receive_packets(vi, rq, budget, xdp_xmit, &stats);
>  
> +	u64_stats_set(&stats.packets, packets);
>  	if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
> -		if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
> -			spin_lock(&vi->refill_lock);
> -			if (vi->refill_enabled)
> -				schedule_delayed_work(&vi->refill, 0);
> -			spin_unlock(&vi->refill_lock);
> -		}
> +		if (!try_fill_recv(vi, rq, GFP_ATOMIC))
> +			/* We need to retry refilling in the next NAPI poll so
> +			 * we must return budget to make sure the NAPI is
> +			 * repolled.
> +			 */
> +			packets = budget;
>  	}
>  
> -	u64_stats_set(&stats.packets, packets);
>  	u64_stats_update_begin(&rq->stats.syncp);
>  	for (i = 0; i < ARRAY_SIZE(virtnet_rq_stats_desc); i++) {
>  		size_t offset = virtnet_rq_stats_desc[i].offset;
> @@ -3230,9 +3230,10 @@ static int virtnet_open(struct net_device *dev)
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
>  		if (i < vi->curr_queue_pairs)
> -			/* Make sure we have some buffers: if oom use wq. */
> -			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> -				schedule_delayed_work(&vi->refill, 0);
> +			/* Pre-fill rq agressively, to make sure we are ready to
> +			 * get packets immediately.
> +			 */
> +			try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
>  
>  		err = virtnet_enable_queue_pair(vi, i);
>  		if (err < 0)
> @@ -3472,16 +3473,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
>  				struct receive_queue *rq,
>  				bool refill)
>  {
> -	bool running = netif_running(vi->dev);
> -	bool schedule_refill = false;
> +	if (netif_running(vi->dev)) {
> +		/* Pre-fill rq agressively, to make sure we are ready to get
> +		 * packets immediately.
> +		 */
> +		if (refill)
> +			try_fill_recv(vi, rq, GFP_KERNEL);
>  
> -	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
> -		schedule_refill = true;
> -	if (running)
>  		virtnet_napi_enable(rq);
> -
> -	if (schedule_refill)
> -		schedule_delayed_work(&vi->refill, 0);
> +	}
>  }
>  
>  static void virtnet_rx_resume_all(struct virtnet_info *vi)
> @@ -3829,11 +3829,13 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>  	}
>  succ:
>  	vi->curr_queue_pairs = queue_pairs;
> -	/* virtnet_open() will refill when device is going to up. */
> -	spin_lock_bh(&vi->refill_lock);
> -	if (dev->flags & IFF_UP && vi->refill_enabled)
> -		schedule_delayed_work(&vi->refill, 0);
> -	spin_unlock_bh(&vi->refill_lock);
> +	if (dev->flags & IFF_UP) {
> +		local_bh_disable();
> +		for (int i = 0; i < vi->curr_queue_pairs; ++i)
> +			virtqueue_napi_schedule(&vi->rq[i].napi, vi->rq[i].vq);
> +
> +		local_bh_enable();
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.43.0


