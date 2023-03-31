Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4156D1887
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 09:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjCaHZy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 03:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjCaHZw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 03:25:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4DA1733
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 00:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680247505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VPSbdMbPx11k4M8+J8Q+rCNz0C06kx/qXnXgmGgyU7E=;
        b=HFoWmgZiBLSeBw0ZQ4o5QTdo7sZmLQ7UN387zRddqzYNjEq3ee1oUebEDoxY9iYlUxeimb
        fCSZCGvIFtxiBsin3Wo6ovwI/83pWuGAUgZJoE9sS4hwWd0TmrUBkYD8SD/fJZuXmvWryH
        EBv6ibolPewvuwVe4i/hslicYLx03M0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-K6G1p0i_P0CiyU8DQObEIQ-1; Fri, 31 Mar 2023 03:25:04 -0400
X-MC-Unique: K6G1p0i_P0CiyU8DQObEIQ-1
Received: by mail-wr1-f72.google.com with SMTP id b14-20020a05600003ce00b002cfefd8e637so2292933wrg.15
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 00:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680247502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPSbdMbPx11k4M8+J8Q+rCNz0C06kx/qXnXgmGgyU7E=;
        b=SQy/huEN/JXb2IBhTl5mOmpPFhSdRuUsGfuotKgPJV1xhelV5fJzrmCMiINmh6Yhh4
         fjJNsrM31R2xpMJmOuYQp2TQdWCRT+q10Tw8188xtFDtnZc1yJa8FwGiVcGP9q0KQl4k
         fKbadRjkeV52CKLIYWXKeVZR2ehxOe55eeAWLiNgrGuFtya/bOx8isUwSXvrX7EyqWrR
         hLXsey9FKZaZAe9BeaV/0h6jkbguKYgMMpMS/Ek6R+3KiJNarOU8UcDfp+ejoLmoIABl
         hRZSjntAzTG2raD9Py6gH3Y65wmhMNsRvhVNkYmFWgFCxgZPmSS4bVbvu35fFzgEweAB
         9Xhw==
X-Gm-Message-State: AAQBX9dQ0yrSMWLF8nk3LMItSffA1RFJKafbpizvS/bAACc6pxDj4uOl
        gYzarOkXja81Wziz6lBnyY8TOAnzdFPfjl0mYmgFD6tzHl6WJSx5ptDHpNg/s7UbV9SfPr63Z8j
        O6zBMSxCCATeaMfKpODmW
X-Received: by 2002:a05:600c:241:b0:3f0:3a57:f01e with SMTP id 1-20020a05600c024100b003f03a57f01emr2956400wmj.4.1680247502186;
        Fri, 31 Mar 2023 00:25:02 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y08BdWXqdQRGJH998OLYyVlQMH54B5che3e83idrXE64Gc4f2CsyU9Ise5WEsqQaQFWkNEIg==
X-Received: by 2002:a05:600c:241:b0:3f0:3a57:f01e with SMTP id 1-20020a05600c024100b003f03a57f01emr2956380wmj.4.1680247501930;
        Fri, 31 Mar 2023 00:25:01 -0700 (PDT)
Received: from redhat.com ([2.52.159.107])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c315000b003eda46d6792sm8851744wmo.32.2023.03.31.00.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 00:25:01 -0700 (PDT)
Date:   Fri, 31 Mar 2023 03:24:56 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next 8/8] virtio_net: introduce receive_small_xdp()
Message-ID: <20230331032429-mutt-send-email-mst@kernel.org>
References: <20230328120412.110114-1-xuanzhuo@linux.alibaba.com>
 <20230328120412.110114-9-xuanzhuo@linux.alibaba.com>
 <343825bad568ec0a21c283f876585585b040da9f.camel@redhat.com>
 <1680247235.3085878-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1680247235.3085878-2-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 31, 2023 at 03:20:35PM +0800, Xuan Zhuo wrote:
> On Thu, 30 Mar 2023 12:48:22 +0200, Paolo Abeni <pabeni@redhat.com> wrote:
> > On Tue, 2023-03-28 at 20:04 +0800, Xuan Zhuo wrote:
> > > @@ -949,15 +1042,11 @@ static struct sk_buff *receive_small(struct net_device *dev,
> > >  {
> > >  	struct sk_buff *skb;
> > >  	struct bpf_prog *xdp_prog;
> > > -	unsigned int xdp_headroom = (unsigned long)ctx;
> > > -	unsigned int header_offset = VIRTNET_RX_PAD + xdp_headroom;
> > > +	unsigned int header_offset = VIRTNET_RX_PAD;
> > >  	unsigned int headroom = vi->hdr_len + header_offset;
> >
> > This changes (reduces) the headroom for non-xpd-pass skbs.
> >
> > [...]
> > > +	buf += header_offset;
> > > +	memcpy(skb_vnet_hdr(skb), buf, vi->hdr_len);
> >
> > AFAICS, that also means that receive_small(), for such packets, will
> > look for the virtio header in a different location. Is that expected?
> 
> 
> That is a mistake.
> 
> Will fix.
> 
> Thanks.

Do try to test small and big packet configurations though, too.

> >
> > Thanks.
> >
> > Paolo
> >

