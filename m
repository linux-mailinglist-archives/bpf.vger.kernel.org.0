Return-Path: <bpf+bounces-12669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1767CF032
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 08:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEAA31C20D75
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 06:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198106126;
	Thu, 19 Oct 2023 06:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fOy6dT2D"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E2546671
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 06:38:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BAE126
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 23:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697697504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Blqwk8CZOAuxak9k7tu36Lndth1mX4n5z0UG75CC1Vc=;
	b=fOy6dT2DGyJt8LXN9J71coKyMQDt1LSvkwZwiGdHyqR+pR8SpT9JvUdJGLkPUzJj4qDz26
	8mnMp9WALeQJyNmagyagUnsc1K1KPv6Otyg6TnCodNTLA/zi119wKt3VS1mueX2nbOMLVF
	lySqNYz2/AJJpK1ULtqrViRSadlDYag=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-jp4lKj2qNuqHv2Cq1otFNw-1; Thu, 19 Oct 2023 02:38:23 -0400
X-MC-Unique: jp4lKj2qNuqHv2Cq1otFNw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f41a04a297so55413775e9.3
        for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 23:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697697502; x=1698302302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Blqwk8CZOAuxak9k7tu36Lndth1mX4n5z0UG75CC1Vc=;
        b=YbSyBPgKGagGvnOchykxDTQ0tsRbqCciqzTczwjBcmhiYzpYr1YtPItcaAbrCn9IE7
         vT4KEsrf0NRvPWECdoJM13jT3IiLC76ZC5L8eCzLJSVaQ/jdslc5drC15fMPXE0K9POp
         +v94MZzIRyDa0KEpxtww6Om5STofDAbKyDyPszs4quOAT3V+jE0QEzih0kRrYlXVFe8j
         hSBWFwiOGCJDnfB30vTASnfd+meaUC9shEBz4IJU8RlcuPVwVHfi/3PiH5ukUpa8HSr2
         48YHOq2yZw8Dh96jZdXx9+wQ5qD4ZrEl76kR+FTL5cTPf5Zk49MxnpgiXCCGSc9d82jY
         nsmQ==
X-Gm-Message-State: AOJu0YwEZT27xbjXre2LCMKeoVyzE5qV3bFkOQk8lEoNbksi4gPGYn3b
	Y4sepq/gPxbe+sZdowDqgPhPvlXd561ZgmUEuY+ZEItkfUInZOu3getrfRusEVzCQdVClmtqOtm
	KCbHPpFyzoHpE
X-Received: by 2002:a05:600c:c0c:b0:407:7e5f:ffb9 with SMTP id fm12-20020a05600c0c0c00b004077e5fffb9mr1104333wmb.9.1697697502080;
        Wed, 18 Oct 2023 23:38:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9qh0cDCENMRB0qEBa29pUmbeWcdQ3FQ1ygusFYggBDj+0Bntc+WUE/xD8GAaiDYHR1Jei5w==
X-Received: by 2002:a05:600c:c0c:b0:407:7e5f:ffb9 with SMTP id fm12-20020a05600c0c0c00b004077e5fffb9mr1104320wmb.9.1697697501762;
        Wed, 18 Oct 2023 23:38:21 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
        by smtp.gmail.com with ESMTPSA id j20-20020a05600c1c1400b004065daba6casm3604423wms.46.2023.10.18.23.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 23:38:21 -0700 (PDT)
Date: Thu, 19 Oct 2023 02:38:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v1 13/19] virtio_net: xsk: tx:
 virtnet_free_old_xmit() distinguishes xsk buffer
Message-ID: <20231019023739-mutt-send-email-mst@kernel.org>
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <20231016120033.26933-14-xuanzhuo@linux.alibaba.com>
 <20231016164434.3a1a51e1@kernel.org>
 <1697508125.07194-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1697508125.07194-1-xuanzhuo@linux.alibaba.com>

On Tue, Oct 17, 2023 at 10:02:05AM +0800, Xuan Zhuo wrote:
> On Mon, 16 Oct 2023 16:44:34 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> > On Mon, 16 Oct 2023 20:00:27 +0800 Xuan Zhuo wrote:
> > > @@ -305,9 +311,15 @@ static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
> > >
> > >  			stats->bytes += xdp_get_frame_len(frame);
> > >  			xdp_return_frame(frame);
> > > +		} else {
> > > +			stats->bytes += virtnet_ptr_to_xsk(ptr);
> > > +			++xsknum;
> > >  		}
> > >  		stats->packets++;
> > >  	}
> > > +
> > > +	if (xsknum)
> > > +		xsk_tx_completed(sq->xsk.pool, xsknum);
> > >  }
> >
> > sparse complains:
> >
> > drivers/net/virtio/virtio_net.h:322:41: warning: incorrect type in argument 1 (different address spaces)
> > drivers/net/virtio/virtio_net.h:322:41:    expected struct xsk_buff_pool *pool
> > drivers/net/virtio/virtio_net.h:322:41:    got struct xsk_buff_pool
> > [noderef] __rcu *pool
> >
> > please build test with W=1 C=1
> 
> OK. I will add C=1 to may script.
> 
> Thanks.

And I hope we all understand, rcu has to be used properly it's not just
about casting the warning away.

-- 
MST


