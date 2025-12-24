Return-Path: <bpf+bounces-77402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D1FCDBF31
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 11:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B41D3032972
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 10:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4700A306D3F;
	Wed, 24 Dec 2025 10:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8sxJa/G";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyPQc56u"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F9486337
	for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 10:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766571460; cv=none; b=tpHL1fYqFtETfWXFijQ9A359auJUIsXrh4OsIu1Qc+zLTwXIPZ80G0SSuKriZmfeH3gwi7C0r53eo/HnWpN0jxUE76vZKF2G7wZMRanzyuhEun6SoxvAPvFSTh5srIsJN8hkunJs9gqPzze2EztX/G+01zQ0eqv2S5elgSuJI30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766571460; c=relaxed/simple;
	bh=3QKEUFo5LXygi5n84KS64jmf6l8RWX20LRDFKQGndDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glBgcWIQ4NOhv7dBBHVCLR5SqkjdWoLST/n6T1qjRvSY95TDfYw/aDozvP/pOAn8w7JyE3vNZgiMcKQ1JrdHpSapd3Sp7U4j/4IHBCMes/dnxqlkhhEBDgbVdyfY6oJqLNXxTQ95OyrXmV4/SzGkEbCzT/XK28jSWGEpJjmj42s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M8sxJa/G; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gyPQc56u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766571457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jzP3CpgRIzIHd4j7JJHeELNPFQj8HTZPnJadpGgQjTc=;
	b=M8sxJa/GQk2vLSz7jSunXPDhytPdnF/KgOozFy6hUeyOYe+r8DfUel0+cnODG4L+jg0tB6
	Y9G2EiEwXaAGhDi+qJO8JiKVXwq0DlNH+COwAgXiV9+dsWn4R443yH1tjOGTSpP6hb7yHp
	LHjCBeVx3R/b9G8r/DWjObRyuZ4g/08=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-SGojFV1_OYmo8yKOl0iTlg-1; Wed, 24 Dec 2025 05:17:35 -0500
X-MC-Unique: SGojFV1_OYmo8yKOl0iTlg-1
X-Mimecast-MFC-AGG-ID: SGojFV1_OYmo8yKOl0iTlg_1766571454
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47910af0c8bso38182215e9.2
        for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 02:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766571454; x=1767176254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jzP3CpgRIzIHd4j7JJHeELNPFQj8HTZPnJadpGgQjTc=;
        b=gyPQc56uIqeX0CaDkJfewzq61MGoO6jXYjokTCHFjgBrcGrsNoO44X5eLN3YmKSRzu
         HXLUA2I6zfIEzIiGW5SIkjJb0m4omkMpblB68lKpwtyJk1CHcMO6EcErznHXQ+643+1R
         y3Fpbc4MZcOZR/QmaxQmbWFtRlGoXsh2orX2f7YNQEB0BeV3nfH9VUeXf7yid5kcdL0F
         wdakzKSuoFR5cciU8lBOAi21qJC1m9WPU0PXxW94p5cY3spnK3W9JXAzO1Wz9cMhsmHO
         nJcmQ2LuuSKfA/fXBbr1fHByxDSjQH588lnv6ZqiZXBrqsN+TwA8/oDrr6DIsTnC275w
         tnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766571454; x=1767176254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzP3CpgRIzIHd4j7JJHeELNPFQj8HTZPnJadpGgQjTc=;
        b=L7UsWhgRVeep4ELAINNXc+1ci7dUPutoHbyYcQUBmwa/dEDI8Y70LIf+4P26O9JdHZ
         Jv5gjxmEQmq/eLMWzeoY494PIrItYwCaAhgjs9OcgEBbhnwnewOHIKpqgeNvmoIS9cbS
         Y36EhlI2Qm3DTKaPbpe5FX43k4U2VfnQTz5QwO8yshafAc3qfWMQ/qhZJaE6hCvROasm
         p3TUD0ZK8m9Quw+BEUtc3qA28BwL84FPmpejeTMs8HWn5e3we0GWfiO+lHVFBV7nsQ8A
         xcvAGxqB0wG7loERPiQ3/NJampXS6EilCd849hiBDWE9v3dWk25On2RHIWbEtKaqMaY6
         +BSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0NdscEPMb+bIvBi5k1pSCdKAYpPep38kvll99sBHzrYaCZJ0QPp2nmdgU/eWwn02/lio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjpvss6nGmeJOsOTDXziILhsWRYXexEvBUlGdZkGb2ZN4k/evL
	ewQIMRk9CCIaPgm49tRAbPQp3df2b+DdxWkQEQ+y37S4FV7pIGrxjsAT4e534U50kSLm07k8f81
	HdoHJ787EJ5rkqB05wr6daXKAeMcycxBPEscneMhjTWQqO0KxO3ST/Q==
X-Gm-Gg: AY/fxX4Cc7mQ67gxf0+3rxH1UaYk3SlpJfyDFTxT0Hdeo/xSoSMRKrhJj8dNC5zITfd
	ePQ5nOiQKxZhfp2+R0uJZpAX2YoEKbJnICkLUL36XZK/KRHT1H6FzY1+EdL/Iexty91GN/UPJlU
	UCKKQY5ayhwljrcKSvgElVB3bCuc+rIVE88ybsHr0ZKCMZ13pxSFzbsrfvZux0yrMm2/FSdAFDU
	n1XTh7MOv65/XvjjLUkyCISeMAKHSneoT+QpCXoSFawsocLUtmvRZxpboH8nQIbh4ZF9yj3iRyA
	ruiOsY0T7wyiQg7PBYWrmapll+2iQVWnsxDsZw+FcKiEBMo/nW8M1O1wWKo4fJKJEAYM8m7c6dk
	u
X-Received: by 2002:a05:600c:444b:b0:477:9814:6882 with SMTP id 5b1f17b1804b1-47d1953b77fmr150409875e9.5.1766571454143;
        Wed, 24 Dec 2025 02:17:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSLHXjoue22ycWh04PhviD8xBwMq2igG9VbtveaphLk/VbLO+tvT/RScqlygcnULbaItpauA==
X-Received: by 2002:a05:600c:444b:b0:477:9814:6882 with SMTP id 5b1f17b1804b1-47d1953b77fmr150409605e9.5.1766571453707;
        Wed, 24 Dec 2025 02:17:33 -0800 (PST)
Received: from redhat.com ([31.187.78.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be27b0d5asm343055335e9.13.2025.12.24.02.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 02:17:33 -0800 (PST)
Date: Wed, 24 Dec 2025 05:17:30 -0500
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
Subject: Re: [PATCH net 3/3] virtio-net: schedule the pending refill work
 after being enabled
Message-ID: <20251224051636-mutt-send-email-mst@kernel.org>
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-4-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223152533.24364-4-minhquangbui99@gmail.com>

On Tue, Dec 23, 2025 at 10:25:33PM +0700, Bui Quang Minh wrote:
> As we need to move the enable_delayed_refill after napi_enable, it's
> possible that a refill work needs to be scheduled in virtnet_receive but
> it cannot. This can make the receive side stuck because if we don't have
> any receive buffers, there will be nothing trigger the refill logic. So
> in case it happens, in virtnet_receive, set the rx queue's
> refill_pending, then when the refill work is enabled again, a refill
> work will be scheduled.
> 
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>

Sounds like this fixes a bug previous patch introduces?
The thing to do is to reorder these two patches then.

> ---
>  drivers/net/virtio_net.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8016d2b378cf..ddc62dab2f9a 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -383,6 +383,9 @@ struct receive_queue {
>  	/* Is delayed refill enabled? */
>  	bool refill_enabled;
>  
> +	/* A refill work needs to be scheduled when delayed refill is enabled */
> +	bool refill_pending;
> +
>  	/* The lock to synchronize the access to refill_enabled */
>  	spinlock_t refill_lock;
>  
> @@ -720,10 +723,13 @@ static void virtnet_rq_free_buf(struct virtnet_info *vi,
>  		put_page(virt_to_head_page(buf));
>  }
>  
> -static void enable_delayed_refill(struct receive_queue *rq)
> +static void enable_delayed_refill(struct receive_queue *rq,
> +				  bool schedule_refill)
>  {
>  	spin_lock_bh(&rq->refill_lock);
>  	rq->refill_enabled = true;
> +	if (rq->refill_pending || schedule_refill)
> +		schedule_delayed_work(&rq->refill, 0);
>  	spin_unlock_bh(&rq->refill_lock);
>  }
>  
> @@ -3032,6 +3038,8 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>  			spin_lock(&rq->refill_lock);
>  			if (rq->refill_enabled)
>  				schedule_delayed_work(&rq->refill, 0);
> +			else
> +				rq->refill_pending = true;
>  			spin_unlock(&rq->refill_lock);
>  		}
>  	}
> @@ -3228,11 +3236,8 @@ static int virtnet_open(struct net_device *dev)
>  		if (err < 0)
>  			goto err_enable_qp;
>  
> -		if (i < vi->curr_queue_pairs) {
> -			enable_delayed_refill(&vi->rq[i]);
> -			if (schedule_refill)
> -				schedule_delayed_work(&vi->rq[i].refill, 0);
> -		}
> +		if (i < vi->curr_queue_pairs)
> +			enable_delayed_refill(&vi->rq[i], schedule_refill);
>  	}
>  
>  	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> @@ -3480,9 +3485,7 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
>  	if (running)
>  		virtnet_napi_enable(rq);
>  
> -	enable_delayed_refill(rq);
> -	if (schedule_refill)
> -		schedule_delayed_work(&rq->refill, 0);
> +	enable_delayed_refill(rq, schedule_refill);
>  }
>  
>  static void virtnet_rx_resume_all(struct virtnet_info *vi)
> -- 
> 2.43.0


