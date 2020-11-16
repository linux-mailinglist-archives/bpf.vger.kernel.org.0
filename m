Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E9F2B4559
	for <lists+bpf@lfdr.de>; Mon, 16 Nov 2020 15:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbgKPN5G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Nov 2020 08:57:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45320 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726286AbgKPN5F (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 16 Nov 2020 08:57:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605535024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=58JLtczfJC3BdQ8P9jCy+MkeQ5C3tOk88fmGaEiTy+E=;
        b=hWAQLIdsWau8gA7Gbfhuc6Mssn8X0FLDX5dkb5K/ykpwW5cXCz1WGjxbrzflaQ5OZ7lkjP
        K0o0wcDSaRTJ8gVq0lYWk0lx6t5W0OhWvLr9Fqvlm6PlXlLBRmqPKEr7q1BEaN9r6TW6pu
        NxnSh+c6kCZ6D2HgNVpL0TmwuWpOO8c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-J6T0GXroNcaXIl-aEEJi9A-1; Mon, 16 Nov 2020 08:57:03 -0500
X-MC-Unique: J6T0GXroNcaXIl-aEEJi9A-1
Received: by mail-wr1-f69.google.com with SMTP id w17so11000358wrp.11
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 05:57:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=58JLtczfJC3BdQ8P9jCy+MkeQ5C3tOk88fmGaEiTy+E=;
        b=aA97+kfXGbUjmTMz1I83G91X8e9uzXRrXJGV+DmtHreDwXmdKjRS+eIwwrDcQyDNdc
         8QH+ZvXj5b9nvmQNDJ2/KUV84642MGMNrpOH4blFodb44IhMggsHe0ZaOmk8LUnrF+/i
         NiE5rEdN+nLQdX6jzAp0s76Qg7Mxxx7tk0GVNI8jyEBJaX1YGY+Fz+BXAQo8DySXBIxL
         Ye9VUICDMV0CjyS4cUG1UR4Ga3vKOqBQO7GYIs451+NsHl7LFzRM6hIUhrxt542gccR6
         DlVWYiI4AdUYaUXVKuLb/Jmj416xKPbMqHz7yNnbKVFa6kZ3U2HkwkZM+b2HTr0hW7Ay
         ACWw==
X-Gm-Message-State: AOAM530eEOMQ+095hCw6C3OuZpQm4Lt3aoTT679hg1mhZhnwaRydnenD
        iB5+zmV9DX7dv4YvPsgmqRqSSmLkPZLH9fTLmYygYGNrOdsU3GASzX7wYCJRXTFvC7GoJ2+YUzb
        RWLqidoEQU5WV
X-Received: by 2002:a5d:62c3:: with SMTP id o3mr19653204wrv.300.1605535021977;
        Mon, 16 Nov 2020 05:57:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzAQd012oEHMVrl1W8LN6Xp/toEeL5/ngwJJSD3YTGsZHyeOFGyYa7S0sxojh5tC5FKwlvXAA==
X-Received: by 2002:a5d:62c3:: with SMTP id o3mr19653170wrv.300.1605535021798;
        Mon, 16 Nov 2020 05:57:01 -0800 (PST)
Received: from redhat.com ([147.161.8.56])
        by smtp.gmail.com with ESMTPSA id u16sm22680107wrn.55.2020.11.16.05.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 05:57:00 -0800 (PST)
Date:   Mon, 16 Nov 2020 08:55:56 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>
Cc:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        magnus.karlsson@intel.com, ast@kernel.org, daniel@iogearbox.net,
        maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
        jesse.brandeburg@intel.com, qi.z.zhang@intel.com, kuba@kernel.org,
        edumazet@google.com, jonathan.lemon@gmail.com, maximmi@nvidia.com,
        intel-wired-lan@lists.osuosl.org, netanel@amazon.com,
        akiyano@amazon.com, michael.chan@broadcom.com,
        sgoutham@marvell.com, ioana.ciornei@nxp.com,
        ruxandra.radulescu@nxp.com, thomas.petazzoni@bootlin.com,
        mcroce@microsoft.com, saeedm@nvidia.com, tariqt@nvidia.com,
        aelior@marvell.com, ecree@solarflare.com,
        ilias.apalodimas@linaro.org, grygorii.strashko@ti.com,
        sthemmin@microsoft.com, kda@linux-powerpc.org
Subject: Re: [PATCH bpf-next v2 06/10] xsk: propagate napi_id to XDP socket
 Rx path
Message-ID: <20201116085548-mutt-send-email-mst@kernel.org>
References: <20201116110416.10719-1-bjorn.topel@gmail.com>
 <20201116110416.10719-7-bjorn.topel@gmail.com>
 <20201116064953-mutt-send-email-mst@kernel.org>
 <614a7ce4-2b6b-129b-de7d-71428f7a71f6@intel.com>
 <20201116073848-mutt-send-email-mst@kernel.org>
 <585b011f-0817-a684-d1db-125bb55741fe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <585b011f-0817-a684-d1db-125bb55741fe@intel.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 16, 2020 at 02:24:56PM +0100, Björn Töpel wrote:
> On 2020-11-16 13:42, Michael S. Tsirkin wrote:
> > On Mon, Nov 16, 2020 at 01:01:40PM +0100, BjÃ¶rn TÃ¶pel wrote:
> > > 
> > > On 2020-11-16 12:55, Michael S. Tsirkin wrote:
> > > > On Mon, Nov 16, 2020 at 12:04:12PM +0100, BjÃfÂ¶rn TÃfÂ¶pel wrote:
> > > > > From: BjÃfÂ¶rn TÃfÂ¶pel <bjorn.topel@intel.com>
> > > > > 
> > > > > Add napi_id to the xdp_rxq_info structure, and make sure the XDP
> > > > > socket pick up the napi_id in the Rx path. The napi_id is used to find
> > > > > the corresponding NAPI structure for socket busy polling.
> > > > > 
> > > > > Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > > Signed-off-by: BjÃfÂ¶rn TÃfÂ¶pel <bjorn.topel@intel.com>
> > > > 
> > > > A bunch of drivers just pass in 0. could you explain when
> > > > is that ok? how bad is it if the wrong id is used?
> > > > 
> > > 
> > > If zero is passed, which is a non-valid NAPI_ID, busy-polling will never
> > > be performed.
> > > 
> > > Depending on the structure of the driver, napi might or might not be
> > > initialized (napi_id != 0) or even available. When it wasn't obvious, I
> > > simply set it to zero.
> > > 
> > > So, short; No harm if zero, but busy-polling cannot be used in an XDP
> > > context.
> > > 
> > > 
> > > [...]
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index 21b71148c532..d71fe41595b7 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -1485,7 +1485,7 @@ static int virtnet_open(struct net_device *dev)
> > > > >    			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> > > > >    				schedule_delayed_work(&vi->refill, 0);
> > > > > -		err = xdp_rxq_info_reg(&vi->rq[i].xdp_rxq, dev, i);
> > > > > +		err = xdp_rxq_info_reg(&vi->rq[i].xdp_rxq, dev, i, 0);
> > > > >    		if (err < 0)
> > > > >    			return err;
> > > > 
> > > > Should this be rq.napi.napi_id ?
> > > > 
> > > 
> > > Yes, if rq.napi.napi_id is valid here! Is it?
> > 
> > What initializes it? netif_napi_add? Then I think yes, it's
> > initialized for all queues ...
> > Needs to be tested naturally.
> > 
> 
> Yeah, netid_napi_add does the id generation.
> 
> My idea was that driver would gradually move to a correct NAPI id (given
> that it's hard to test w/o HW. Virtio however is simpler to test. :-)
> 
> 
> Björn

tun too ;)

