Return-Path: <bpf+bounces-23133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C564D86E0B9
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 12:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 126EAB218DB
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 11:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8A86D1B5;
	Fri,  1 Mar 2024 11:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJJG7BUf"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A107C6D1BB
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 11:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709293998; cv=none; b=TFBgyj0IqlPRmsFnahmJ2LLHZAOk7K0nbKjGdFtiWeR1y5fqXoJZPWz7LnK+n9hEXsF5O0k00BD/utjVn+DrlumV1xEDTDSw1kZMAoSdlek30nB3x1nCi7R1BqQP+krRxIoosaTLcB4GpVJMR9QI9U211C7MoC5rIGkKftrBlvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709293998; c=relaxed/simple;
	bh=WpidZeAtZ+YgQaVLdxWuklMA1DRtSXB3dUMvzxcxpvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+Tx0ajxtLiLcfo04tkCLlCeEYsgprxGkXffDu8kFCQ9RM54xoB+wxGd8pgFnnDH7KJ6CgzFFcEopP6O8lQJ4RrhRr+h46ab/1VW0ZbZLO+3+EGpBqeNranJ/PAhDJNGEVmDAuDwP2iyXRUS8/iSglku6ttCs7a8qSSRMzXLnNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jJJG7BUf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709293995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sXYuCfdTj1urbCJSi5THRKssGZntXNDUJ+IF7YDUqaY=;
	b=jJJG7BUfdf+wQWAShpl1UtLQTsDfd9iA3qjfCrdxQ8+PQnV96ss8aE83eIvjf/i6OukLif
	ifU/GSOYiCzzt2G3G/QH6M8cNQSniJqtlddiGTBXzPkUEXezvt29AiVcNOk+haKpgVJE5a
	8b3BNZqAaE2IYyHeeXso4i5B+oFl0Vg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-4aWSyYLBOEeiJbuNMaXwbQ-1; Fri, 01 Mar 2024 06:53:11 -0500
X-MC-Unique: 4aWSyYLBOEeiJbuNMaXwbQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-566b58e2a24so820742a12.2
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 03:53:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709293991; x=1709898791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXYuCfdTj1urbCJSi5THRKssGZntXNDUJ+IF7YDUqaY=;
        b=pruMABf5G5Q7qlP6+poXXF/hbahlDdxp+WogXdxcd9HZ/Uqnk92NyZrv/r/3UXA1cK
         QLVEYbfgJGAkosYDQBVBP0uTCUJ90zX/HfmUxl7N4j3UC6uWyVP8zBXijUszg8rdt6rr
         Lpx/FGzAwZQ+aoIgbvcoUG9FFBZ0EWX1GrvcQMEG5kfyqfS0ZrpMFm0dvnR/kxQWX0Xj
         4Krs4DOoPEksZoqCSfMwrTI/gpfoJgwD7blJCcLgh8UZAgboWTyhMI/bAiK9I560fUfo
         ALrA/XaOM50u0G91Hegj5Lq3PYk7XvfwYVzURroHIJxIZL7/wykAoXmm+4ORgNCH32BH
         PJ7A==
X-Forwarded-Encrypted: i=1; AJvYcCVRWm4evQLBA5DiwWqzS9oqom6Vlt/qdn9OwjSVzhIgd1WkuJEZvoVH2PDBGhgvSYIOovJ7vvJOB6viP+EZxrnQLOWm
X-Gm-Message-State: AOJu0Yx5MIoKZCnANGPprVLy3DuHvY35cB9xqV43xOOi99AquvQONOez
	O4Y2wSeM7euKYf0PffB2e3+b43Iwt83InQ1/adSTZ8UDhfHxGJN4EoGLQ2UkRTmmOqvkh6PWdTm
	Kba85zf17EmnBEa24PLxS9xB7VurahtqLbzl8/sClbdLMJTp2MQ==
X-Received: by 2002:a50:a411:0:b0:566:47ee:b8b4 with SMTP id u17-20020a50a411000000b0056647eeb8b4mr1225109edb.17.1709293990834;
        Fri, 01 Mar 2024 03:53:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1vmpvGelrIAwSR9YtmqYMH53YWKi9ocFIRHHKWtTOAKDOP50IotWgGwt5cBRTSNWEE/hvcg==
X-Received: by 2002:a50:a411:0:b0:566:47ee:b8b4 with SMTP id u17-20020a50a411000000b0056647eeb8b4mr1225097edb.17.1709293990541;
        Fri, 01 Mar 2024 03:53:10 -0800 (PST)
Received: from redhat.com ([2.52.158.48])
        by smtp.gmail.com with ESMTPSA id d18-20020a056402001200b00566d43ed4dasm439183edu.68.2024.03.01.03.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:53:09 -0800 (PST)
Date: Fri, 1 Mar 2024 06:53:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: wangyunjian <wangyunjian@huawei.com>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"bjorn@kernel.org" <bjorn@kernel.org>,
	"magnus.karlsson@intel.com" <magnus.karlsson@intel.com>,
	"maciej.fijalkowski@intel.com" <maciej.fijalkowski@intel.com>,
	"jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	xudingke <xudingke@huawei.com>, "liwei (DT)" <liwei395@huawei.com>
Subject: Re: [PATCH net-next v2 3/3] tun: AF_XDP Tx zero-copy support
Message-ID: <20240301065141-mutt-send-email-mst@kernel.org>
References: <1709118356-133960-1-git-send-email-wangyunjian@huawei.com>
 <7d478cb842e28094f4d6102e593e3de25ab27dfe.camel@redhat.com>
 <223aeca6435342ec8a4d57c959c23303@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <223aeca6435342ec8a4d57c959c23303@huawei.com>

On Fri, Mar 01, 2024 at 11:45:52AM +0000, wangyunjian wrote:
> > -----Original Message-----
> > From: Paolo Abeni [mailto:pabeni@redhat.com]
> > Sent: Thursday, February 29, 2024 7:13 PM
> > To: wangyunjian <wangyunjian@huawei.com>; mst@redhat.com;
> > willemdebruijn.kernel@gmail.com; jasowang@redhat.com; kuba@kernel.org;
> > bjorn@kernel.org; magnus.karlsson@intel.com; maciej.fijalkowski@intel.com;
> > jonathan.lemon@gmail.com; davem@davemloft.net
> > Cc: bpf@vger.kernel.org; netdev@vger.kernel.org;
> > linux-kernel@vger.kernel.org; kvm@vger.kernel.org;
> > virtualization@lists.linux.dev; xudingke <xudingke@huawei.com>; liwei (DT)
> > <liwei395@huawei.com>
> > Subject: Re: [PATCH net-next v2 3/3] tun: AF_XDP Tx zero-copy support
> > 
> > On Wed, 2024-02-28 at 19:05 +0800, Yunjian Wang wrote:
> > > @@ -2661,6 +2776,54 @@ static int tun_ptr_peek_len(void *ptr)
> > >  	}
> > >  }
> > >
> > > +static void tun_peek_xsk(struct tun_file *tfile) {
> > > +	struct xsk_buff_pool *pool;
> > > +	u32 i, batch, budget;
> > > +	void *frame;
> > > +
> > > +	if (!ptr_ring_empty(&tfile->tx_ring))
> > > +		return;
> > > +
> > > +	spin_lock(&tfile->pool_lock);
> > > +	pool = tfile->xsk_pool;
> > > +	if (!pool) {
> > > +		spin_unlock(&tfile->pool_lock);
> > > +		return;
> > > +	}
> > > +
> > > +	if (tfile->nb_descs) {
> > > +		xsk_tx_completed(pool, tfile->nb_descs);
> > > +		if (xsk_uses_need_wakeup(pool))
> > > +			xsk_set_tx_need_wakeup(pool);
> > > +	}
> > > +
> > > +	spin_lock(&tfile->tx_ring.producer_lock);
> > > +	budget = min_t(u32, tfile->tx_ring.size, TUN_XDP_BATCH);
> > > +
> > > +	batch = xsk_tx_peek_release_desc_batch(pool, budget);
> > > +	if (!batch) {
> > 
> > This branch looks like an unneeded "optimization". The generic loop below
> > should have the same effect with no measurable perf delta - and smaller code.
> > Just remove this.
> > 
> > > +		tfile->nb_descs = 0;
> > > +		spin_unlock(&tfile->tx_ring.producer_lock);
> > > +		spin_unlock(&tfile->pool_lock);
> > > +		return;
> > > +	}
> > > +
> > > +	tfile->nb_descs = batch;
> > > +	for (i = 0; i < batch; i++) {
> > > +		/* Encode the XDP DESC flag into lowest bit for consumer to differ
> > > +		 * XDP desc from XDP buffer and sk_buff.
> > > +		 */
> > > +		frame = tun_xdp_desc_to_ptr(&pool->tx_descs[i]);
> > > +		/* The budget must be less than or equal to tx_ring.size,
> > > +		 * so enqueuing will not fail.
> > > +		 */
> > > +		__ptr_ring_produce(&tfile->tx_ring, frame);
> > > +	}
> > > +	spin_unlock(&tfile->tx_ring.producer_lock);
> > > +	spin_unlock(&tfile->pool_lock);
> > 
> > More related to the general design: it looks wrong. What if
> > get_rx_bufs() will fail (ENOBUF) after successful peeking? With no more
> > incoming packets, later peek will return 0 and it looks like that the
> > half-processed packets will stay in the ring forever???
> > 
> > I think the 'ring produce' part should be moved into tun_do_read().
> 
> Currently, the vhost-net obtains a batch descriptors/sk_buffs from the
> ptr_ring and enqueue the batch descriptors/sk_buffs to the virtqueue'queue,
> and then consumes the descriptors/sk_buffs from the virtqueue'queue in
> sequence. As a result, TUN does not know whether the batch descriptors have
> been used up, and thus does not know when to return the batch descriptors.
> 
> So, I think it's reasonable that when vhost-net checks ptr_ring is empty,
> it calls peek_len to get new xsk's descs and return the descriptors.
> 
> Thanks

What you need to think about is that if you peek, another call
in parallel can get the same value at the same time.


> > 
> > Cheers,
> > 
> > Paolo
> 


