Return-Path: <bpf+bounces-12684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 559147CF30C
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 10:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873971C20980
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 08:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C45315AD1;
	Thu, 19 Oct 2023 08:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9jH7pcJ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5184B156DB
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 08:43:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA472198A
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 01:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697704984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AlqhhHztKcdEt3pYJWxTUFdsjzqtezTAvUlB2zTyOgA=;
	b=a9jH7pcJCR6DVbvpHNeXpnHF+iixdYT4v5chFfsVGoOqZeid+TyajgxRNAdN7LarF0LsNb
	81cFR8R89xxfj/n5Co8+GZDGpmZWjt4t9WxLII4znedgKuhv1ietHuZ4gw+8v/8sC0mbhy
	/kdi2qBxfKrkRw44HI9+/l5XPa/Pf3Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-BGY_ivj8OhSkIK9NRkf8AA-1; Thu, 19 Oct 2023 04:43:03 -0400
X-MC-Unique: BGY_ivj8OhSkIK9NRkf8AA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4084163ecd9so5839525e9.3
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 01:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697704982; x=1698309782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlqhhHztKcdEt3pYJWxTUFdsjzqtezTAvUlB2zTyOgA=;
        b=lNFMl8Ejm4hECqKbr332b7pRaN+w41MI7psw0p16rZtQscPmbbQaneLzjU+tLexPBf
         dpYhBeQdH51dRIH+0GrIRA777GpnLsB3FpETjKC5g7kUXNcMKpe4pZKTyPaxsH5NgkMf
         2jfGGSiwv55nPdVprn3ibAsg5cRY4cVP90RSLOFq9tqY2XsMzObQrFIalnTO1EF0JkF5
         GiX0MF0C6Zv5vErLWJJzAkIX/yCC/7ke20dLNDGn+r0WkbW6+E/iklOfFfQHAXOLXj4k
         LGMuMMF++JGAxj23ilgESRZioQ3OhaSSFDA+13nZe3wIFSKMwCbr9GJaqR0yA3DrvtqY
         Gp0w==
X-Gm-Message-State: AOJu0YwXWratlPo69SLtGkSDmj+TPmK+fcF6bNFSh8UfaF8OV/EAZ9ug
	RQOlyFWi7u0xfWnT+883EIyOI9uQpECJVPzURwpwl+n2V8Xa5oTNUECdkzckiLwKsbEo5PO3qSb
	mPIH0rhiWnEP+
X-Received: by 2002:a05:600c:19ca:b0:407:5b54:bb0c with SMTP id u10-20020a05600c19ca00b004075b54bb0cmr1374846wmq.19.1697704981959;
        Thu, 19 Oct 2023 01:43:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcs+PI3KpQMhigTtyQ8yweB5gsDVKRRB+EK96wCv4w25J7K7DMddnUtKuq/gzlzEZ+F/Hmfw==
X-Received: by 2002:a05:600c:19ca:b0:407:5b54:bb0c with SMTP id u10-20020a05600c19ca00b004075b54bb0cmr1374826wmq.19.1697704981619;
        Thu, 19 Oct 2023 01:43:01 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
        by smtp.gmail.com with ESMTPSA id o30-20020a05600c511e00b004063cd8105csm3878145wms.22.2023.10.19.01.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 01:43:01 -0700 (PDT)
Date: Thu, 19 Oct 2023 04:42:56 -0400
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
Message-ID: <20231019043958-mutt-send-email-mst@kernel.org>
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <20231016120033.26933-14-xuanzhuo@linux.alibaba.com>
 <20231016164434.3a1a51e1@kernel.org>
 <1697508125.07194-1-xuanzhuo@linux.alibaba.com>
 <20231019023739-mutt-send-email-mst@kernel.org>
 <1697699628.4189832-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1697699628.4189832-1-xuanzhuo@linux.alibaba.com>

On Thu, Oct 19, 2023 at 03:13:48PM +0800, Xuan Zhuo wrote:
> On Thu, 19 Oct 2023 02:38:16 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Tue, Oct 17, 2023 at 10:02:05AM +0800, Xuan Zhuo wrote:
> > > On Mon, 16 Oct 2023 16:44:34 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> > > > On Mon, 16 Oct 2023 20:00:27 +0800 Xuan Zhuo wrote:
> > > > > @@ -305,9 +311,15 @@ static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
> > > > >
> > > > >  			stats->bytes += xdp_get_frame_len(frame);
> > > > >  			xdp_return_frame(frame);
> > > > > +		} else {
> > > > > +			stats->bytes += virtnet_ptr_to_xsk(ptr);
> > > > > +			++xsknum;
> > > > >  		}
> > > > >  		stats->packets++;
> > > > >  	}
> > > > > +
> > > > > +	if (xsknum)
> > > > > +		xsk_tx_completed(sq->xsk.pool, xsknum);
> > > > >  }
> > > >
> > > > sparse complains:
> > > >
> > > > drivers/net/virtio/virtio_net.h:322:41: warning: incorrect type in argument 1 (different address spaces)
> > > > drivers/net/virtio/virtio_net.h:322:41:    expected struct xsk_buff_pool *pool
> > > > drivers/net/virtio/virtio_net.h:322:41:    got struct xsk_buff_pool
> > > > [noderef] __rcu *pool
> > > >
> > > > please build test with W=1 C=1
> > >
> > > OK. I will add C=1 to may script.
> > >
> > > Thanks.
> >
> > And I hope we all understand, rcu has to be used properly it's not just
> > about casting the warning away.
> 
> 
> Yes. I see. I will use rcu_dereference() and rcu_read_xxx().
> 
> Thanks.

When you do, pls don't forget to add comments documenting what does
rcu_read_lock and synchronize_rcu.


-- 
MST


