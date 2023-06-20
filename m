Return-Path: <bpf+bounces-2912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B15B5736B9F
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 14:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68ED4281254
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 12:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0635C15492;
	Tue, 20 Jun 2023 12:10:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA670101FA
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 12:10:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DB3C6
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 05:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687263047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jy/+r4rsS5OLs8lIEixgzyvEXrfFC1+IJpcFMmCdJIw=;
	b=GLbNGTH7bzPCsxWKdsqRpIVP0KI1KybvDEOpdZDQsqgkqewYcOaiatKA8b4HQx69fzoiRO
	0F4kFGISOyp/BkpF9WECKlzTcM/vx2uj5nHJuTKwSog2FxRR9/M38lAh/lEkaor0HFFsk1
	8f6tGKiUjGxPB8i+BW93AGsEFKNPdKo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-YY26jDUhOl6QOBmpQB72wA-1; Tue, 20 Jun 2023 08:10:46 -0400
X-MC-Unique: YY26jDUhOl6QOBmpQB72wA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30fb1f3c30aso1662139f8f.0
        for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 05:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687263045; x=1689855045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jy/+r4rsS5OLs8lIEixgzyvEXrfFC1+IJpcFMmCdJIw=;
        b=LXC26RGhcKMOnjT5QEbnV4OfkbA6Sb2uGWtRhiJzCfBnmmGH4CNx58KI+16v3o3x3e
         5rlDDzZCkXHHhoS3nzt/dxvodcUcnGjdtQRezRMG798jbcbnuLoC6n8nTgAVohUfqMsV
         Ec4kByCAfAxsAnWLtPGsId/uiVI8/zdmuniWNIQu65Lk3Vh1xIVIW3lQLV6gR3XCW11r
         3ToR8Cjz/BkaAtNaFb6xbx277Y48h+FZDv8VRU0J/tlX2GH4GsXoL7EKMk6QyWazr3ox
         p8YRAPf1BdMYyaolmOnAODgTkPVdtubOAySuZv4RYkku6Cm5PuBJaf0jiy+ZL7VwNTo5
         vykQ==
X-Gm-Message-State: AC+VfDwiJe4heFv1Y4zcGpRcrbDEv+JNfaQIrt3n8nCnC58GexSM+mJX
	oG2YdA9Sv+SvM79GhSo3oi1I+ycYLR1trZug+ECKLdMY8LOorcmVp7uEPgnaDfQ2WAK1/QF3KsV
	VTKzDsd1ulIfk
X-Received: by 2002:a05:6000:151:b0:312:74a9:8267 with SMTP id r17-20020a056000015100b0031274a98267mr2768959wrx.9.1687263044977;
        Tue, 20 Jun 2023 05:10:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4o3WLGlF5SCCHdCRZYT0k+yMAEiPyItIfLz1AjY2paRSx+F7MlavxYLZPNwCaM78K9q/1BYQ==
X-Received: by 2002:a05:6000:151:b0:312:74a9:8267 with SMTP id r17-20020a056000015100b0031274a98267mr2768935wrx.9.1687263044521;
        Tue, 20 Jun 2023 05:10:44 -0700 (PDT)
Received: from redhat.com ([2.52.15.156])
        by smtp.gmail.com with ESMTPSA id y10-20020a5d4aca000000b0030ae6432504sm1878710wrs.38.2023.06.20.05.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 05:10:43 -0700 (PDT)
Date: Tue, 20 Jun 2023 08:10:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net-next 3/4] virtio-net: support coexistence of XDP and
 _F_GUEST_CSUM
Message-ID: <20230620080926-mutt-send-email-mst@kernel.org>
References: <20230619105738.117733-1-hengqi@linux.alibaba.com>
 <20230619105738.117733-4-hengqi@linux.alibaba.com>
 <20230619072320-mutt-send-email-mst@kernel.org>
 <20230620032430.GE74977@h68b04307.sqa.eu95>
 <20230620064711-mutt-send-email-mst@kernel.org>
 <20230620110148.GF74977@h68b04307.sqa.eu95>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620110148.GF74977@h68b04307.sqa.eu95>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 20, 2023 at 07:01:48PM +0800, Heng Qi wrote:
> On Tue, Jun 20, 2023 at 06:50:34AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Jun 20, 2023 at 11:24:30AM +0800, Heng Qi wrote:
> > > On Mon, Jun 19, 2023 at 07:26:44AM -0400, Michael S. Tsirkin wrote:
> > > > On Mon, Jun 19, 2023 at 06:57:37PM +0800, Heng Qi wrote:
> > > > > We are now re-probing the csum related fields and  trying
> > > > > to have XDP and RX hw checksum capabilities coexist on the
> > > > > XDP path. For the benefit of:
> > > > > 1. RX hw checksum capability can be used if XDP is loaded.
> > > > > 2. Avoid packet loss when loading XDP in the vm-vm scenario.
> > > > > 
> > > > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > ---
> > > > >  drivers/net/virtio_net.c | 36 ++++++++++++++++++++++++------------
> > > > >  1 file changed, 24 insertions(+), 12 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index 07b4801d689c..25b486ab74db 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -1709,6 +1709,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
> > > > >  	struct net_device *dev = vi->dev;
> > > > >  	struct sk_buff *skb;
> > > > >  	struct virtio_net_hdr_mrg_rxbuf *hdr;
> > > > > +	__u8 flags;
> > > > >  
> > > > >  	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
> > > > >  		pr_debug("%s: short packet %i\n", dev->name, len);
> > > > > @@ -1717,6 +1718,8 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
> > > > >  		return;
> > > > >  	}
> > > > >  
> > > > > +	flags = ((struct virtio_net_hdr_mrg_rxbuf *)buf)->hdr.flags;
> > > > > +
> > > > >  	if (vi->mergeable_rx_bufs)
> > > > >  		skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
> > > > >  					stats);
> > > > 
> > > > what's going on here?
> > > 
> > > Hi, Michael.
> > > 
> > > Is your question about the function of this code?
> > > 1. If yes,
> > > this sentence saves the flags value in virtio-net-hdr in advance
> > > before entering the XDP processing logic, so that it can be used to
> > > judge further logic after XDP processing.
> > > 
> > > If _NEEDS_CSUM is included in flags before XDP processing, then after
> > > XDP processing we need to re-probe the csum fields and calculate the
> > > pseudo-header checksum.
> > 
> > Yes but we previously used this:
> > -       hdr = skb_vnet_hdr(skb);
> > which pokes at the copy in skb cb.
> > 
> > Is anything wrong with this?
> > 
> 
> This is where we save the hdr when there is no XDP loaded (note that
> this is the complete hdr, including flags, and also including GSO and
> other information). When XDP is loaded, because hdr is invalid, we will
> not save it into skb->cb.
> 
> But the above situation is not what we want. Now our purpose is to save
> the hdr information before XDP processing, that is, when the driver has
> just received the packet and has not built the skb (in fact, we only
> need flags). Therefore, only flags are saved here.
> 
> Thanks.

I don't get it. this seems to be the only use of flags:


+       if (unlikely(vi->xdp_enabled)) {
+               if (virtnet_set_csum_after_xdp(vi, skb, flags) < 0) {
+                       pr_debug("%s: errors occurred in flow dissector setting csum",
+                                dev->name);
+                       goto frame_err;
+               }

looks like skb has already been created here.

is there another use of flags that I missed?



> > It seems preferable not to poke at the header an extra time.
> > 
> > -- 
> > MST


