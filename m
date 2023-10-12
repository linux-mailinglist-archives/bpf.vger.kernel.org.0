Return-Path: <bpf+bounces-12030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5587C6EC5
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 15:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58BFE282C09
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 13:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74B92940B;
	Thu, 12 Oct 2023 13:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/0cRI1K"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670E327712
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 13:07:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9926894
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 06:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697116050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6RsmbdmHeIJjajNpJlxE4knqBt1TJWSS+6uc9jgSnK8=;
	b=M/0cRI1KUeBMbDkg++FV6NHiSCplY9sicEY4llaDf80pP0vZjaLYpHT4dDamr6vxUghZvv
	ThjScP5W5R2oXwu0q28qBOBsd3x0k/DHp+dG0MMvNWpZgvWz9I/IQqQcdKK6ejl20FSHs/
	6gtqyaTpseIZkSSvn026wrCpRXjwuCQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-F974aTLJNd6GnrzfOxnYIQ-1; Thu, 12 Oct 2023 09:07:28 -0400
X-MC-Unique: F974aTLJNd6GnrzfOxnYIQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f5df65f9f4so6390865e9.2
        for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 06:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697116047; x=1697720847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RsmbdmHeIJjajNpJlxE4knqBt1TJWSS+6uc9jgSnK8=;
        b=V3Z/PJZ9uvor32ZpvABWUPJSae2IGbKBdg/cJ9qYIozCIyrD3bB1dqaKlwkIfm/mSu
         hYehbIofdFsE+UnxtXR7BeM9XK3CJ5MILFa7/r6Sh59HNf/G140Xxmd3CJpGUHT7okO9
         cgE2HKy3dqWTHRZauvhuRpIapqoh4PIrSu+N0tVoo5ogKizXJqcC/LV7fYgHAo4eHCvd
         wZnSgx26eUjriHjXEaeyAopzD+jjwvwqh+4VUkDRqfQm+Au85Vlfu3jQPh6jqoTo7I6f
         qsisSfDICMJMuKe7OLjbXUUo11J/CUTqOwn1AqKkAoyFEMlOZD2gFEa3looQOqps+aqY
         XTUg==
X-Gm-Message-State: AOJu0Yy5CSnbLOMDksOxLGmlH4uh3JGnCthXAcwJh7eY53XAeijtCA5d
	QXmOva+/MWiRP49SpyV/l9R7MLQ2U9jFximjOiqmBOTkl02seidukgsG4fYtlDlDRGY0W7J60Th
	BgEV76KZQvfob
X-Received: by 2002:a05:600c:2219:b0:405:1c19:b747 with SMTP id z25-20020a05600c221900b004051c19b747mr20736209wml.15.1697116047568;
        Thu, 12 Oct 2023 06:07:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENFzPHy318ZIAZGjzjpy4+I+lUIwRej9/NXgZPJcOdLn4eVm1MWxNkCTzCBfrKN6XADTgSJQ==
X-Received: by 2002:a05:600c:2219:b0:405:1c19:b747 with SMTP id z25-20020a05600c221900b004051c19b747mr20736181wml.15.1697116047160;
        Thu, 12 Oct 2023 06:07:27 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600c290200b004063d8b43e7sm21849039wmd.48.2023.10.12.06.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 06:07:26 -0700 (PDT)
Date: Thu, 12 Oct 2023 09:07:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH vhost 21/22] virtio_net: update tx timeout record
Message-ID: <20231012090632-mutt-send-email-mst@kernel.org>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011092728.105904-22-xuanzhuo@linux.alibaba.com>
 <20231012050936-mutt-send-email-mst@kernel.org>
 <1697101953.6236846-1-xuanzhuo@linux.alibaba.com>
 <20231012052017-mutt-send-email-mst@kernel.org>
 <1697111642.7917345-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1697111642.7917345-2-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 07:54:02PM +0800, Xuan Zhuo wrote:
> On Thu, 12 Oct 2023 05:36:56 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Thu, Oct 12, 2023 at 05:12:33PM +0800, Xuan Zhuo wrote:
> > > On Thu, 12 Oct 2023 05:10:55 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Wed, Oct 11, 2023 at 05:27:27PM +0800, Xuan Zhuo wrote:
> > > > > If send queue sent some packets, we update the tx timeout
> > > > > record to prevent the tx timeout.
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > ---
> > > > >  drivers/net/virtio/xsk.c | 10 ++++++++++
> > > > >  1 file changed, 10 insertions(+)
> > > > >
> > > > > diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> > > > > index 7abd46bb0e3d..e605f860edb6 100644
> > > > > --- a/drivers/net/virtio/xsk.c
> > > > > +++ b/drivers/net/virtio/xsk.c
> > > > > @@ -274,6 +274,16 @@ bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
> > > > >
> > > > >  	virtnet_xsk_check_queue(sq);
> > > > >
> > > > > +	if (stats.packets) {
> > > > > +		struct netdev_queue *txq;
> > > > > +		struct virtnet_info *vi;
> > > > > +
> > > > > +		vi = sq->vq->vdev->priv;
> > > > > +
> > > > > +		txq = netdev_get_tx_queue(vi->dev, sq - vi->sq);
> > > > > +		txq_trans_cond_update(txq);
> > > > > +	}
> > > > > +
> > > > >  	u64_stats_update_begin(&sq->stats.syncp);
> > > > >  	sq->stats.packets += stats.packets;
> > > > >  	sq->stats.bytes += stats.bytes;
> > > >
> > > > I don't get what this is doing. Is there some kind of race here you
> > > > are trying to address? And what introduced the race?
> > >
> > >
> > > Because the xsk xmit shares the send queue with the kernel xmit,
> > > then when I do benchmark, the xsk will always use the send queue,
> > > so the kernel may have no chance to do xmit, the tx watchdog
> > > thinks that the send queue is hang and prints tx timeout log.
> > >
> > > So I call the txq_trans_cond_update() to tell the tx watchdog
> > > that the send queue is working.
> > >
> > > Thanks.
> >
> > Don't like this hack.
> > So packets are stuck in queue - that's not good is it?
> > Is ours the only driver that shares queues like this?
> 
> NO.
> 
> And txq_trans_cond_update() is called by many net drivers for the similar reason.
> 
> Thanks

Hmm it seems you are right. OK, sorry about the noise.

> 
> >
> > >
> > > >
> > > > > --
> > > > > 2.32.0.3.g01195cf9f
> > > >
> > > >
> >


