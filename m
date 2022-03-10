Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884C94D526F
	for <lists+bpf@lfdr.de>; Thu, 10 Mar 2022 20:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237189AbiCJSye (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 13:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239137AbiCJSyd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 13:54:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC21F143474
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 10:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646938409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xUIaunNwucj36TKfCu4S1HpxFWnNf4RhBlnOtJolQcU=;
        b=TFhthyuDU0zTrGRsiR85dFI/AHesMupdJTAZlwW3i50/lvRA2M1X214tbbJOcv20rV3qqY
        0bu/Nj17dBRfilYImqQF/+CrZuGEwhP3/3y1woQD8rdQb9PdJbhx0QlfQHigbSJvL7IplE
        vwgVcnw7UeLkF59v2KdiIUz4mhlFspg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-wyKT084KM9CSM9cxU-a5cw-1; Thu, 10 Mar 2022 13:53:28 -0500
X-MC-Unique: wyKT084KM9CSM9cxU-a5cw-1
Received: by mail-ed1-f70.google.com with SMTP id i5-20020a056402054500b00415ce7443f4so3617327edx.12
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 10:53:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=xUIaunNwucj36TKfCu4S1HpxFWnNf4RhBlnOtJolQcU=;
        b=0Mo1q9j2TcQmQ6DdYfj9dc0rVgVIXRZG2Qyup23Kf43EQHzkQs3QwnOXftUSBU5OKq
         Skpp1caH4sKxPMNrZVgCxW7VDUNm29eOtrhVGR9YHgt4nNxUxWWTwOJ4L+Sj4urmekek
         pS9rWlC+7HQt8TqGw/BxMppnBj44TrpQF/JQIE34b4RuGoy9NB0QvDWNvAVVEkcL+EHz
         0HVj0mecOVMYoLxaO8xmZnjllV+C+9qJaVKvjZSp2GdaK4deALAI8KHSADQP6Yf5o/fQ
         lDrhh5nEz6+Df8sJCQsYqMYzYdIw0oBKWvPbMc0v+J4F2QQ9WDszFNVBhnqIIkwKP7GB
         KkCw==
X-Gm-Message-State: AOAM530DwVX2vA6+ykfCRurQs+Miily4qboOh+rO9KrQ1oFPx9eSlkuH
        H45cVBIxT//58tQzOvRo9fFyW4C+6Cwm6Ps2U5ZeI7f8fl91FxKsyqkFjlpzLxGKfIejABH1Ykf
        GTaxq8CnN8KdP
X-Received: by 2002:a17:907:72d0:b0:6db:4788:66a9 with SMTP id du16-20020a17090772d000b006db478866a9mr5601392ejc.516.1646938405124;
        Thu, 10 Mar 2022 10:53:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx9jILF9inhzNJdKySpj2p2+R9+7o6A0HFC7VBoy7c5Z+J0niGiA7Y1r6kmbOb3YphNyNjTRQ==
X-Received: by 2002:a17:907:72d0:b0:6db:4788:66a9 with SMTP id du16-20020a17090772d000b006db478866a9mr5601333ejc.516.1646938404026;
        Thu, 10 Mar 2022 10:53:24 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id j7-20020a1709062a0700b006bc28a6b8f1sm2064352eje.222.2022.03.10.10.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 10:53:23 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D106C1A8959; Thu, 10 Mar 2022 19:53:22 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, brouer@redhat.com,
        pabeni@redhat.com, echaudro@redhat.com, toshiaki.makita1@gmail.com,
        andrii@kernel.org
Subject: Re: [PATCH v4 bpf-next 3/3] veth: allow jumbo frames in xdp mode
In-Reply-To: <YioT2TGc8M42V2K2@lore-desk>
References: <cover.1646755129.git.lorenzo@kernel.org>
 <930b1ad3d84f7ca5a41ba75571f9146a932c5394.1646755129.git.lorenzo@kernel.org>
 <87bkyeujrv.fsf@toke.dk> <YioT2TGc8M42V2K2@lore-desk>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 10 Mar 2022 19:53:22 +0100
Message-ID: <87mthxy6zh.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Lorenzo Bianconi <lorenzo.bianconi@redhat.com> writes:

>> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>> 
>> > Allow increasing the MTU over page boundaries on veth devices
>> > if the attached xdp program declares to support xdp fragments.
>> > Enable NETIF_F_ALL_TSO when the device is running in xdp mode.
>> >
>> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> > ---
>> >  drivers/net/veth.c | 28 +++++++++++++++++-----------
>> >  1 file changed, 17 insertions(+), 11 deletions(-)
>> >
>> > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
>> > index 47b21b1d2fd9..c5a2dc2b2e4b 100644
>> > --- a/drivers/net/veth.c
>> > +++ b/drivers/net/veth.c
>> > @@ -293,8 +293,7 @@ static int veth_forward_skb(struct net_device *dev, struct sk_buff *skb,
>> >  /* return true if the specified skb has chances of GRO aggregation
>> >   * Don't strive for accuracy, but try to avoid GRO overhead in the most
>> >   * common scenarios.
>> > - * When XDP is enabled, all traffic is considered eligible, as the xmit
>> > - * device has TSO off.
>> > + * When XDP is enabled, all traffic is considered eligible.
>> >   * When TSO is enabled on the xmit device, we are likely interested only
>> >   * in UDP aggregation, explicitly check for that if the skb is suspected
>> >   * - the sock_wfree destructor is used by UDP, ICMP and XDP sockets -
>> > @@ -302,11 +301,13 @@ static int veth_forward_skb(struct net_device *dev, struct sk_buff *skb,
>> >   */
>> >  static bool veth_skb_is_eligible_for_gro(const struct net_device *dev,
>> >  					 const struct net_device *rcv,
>> > +					 const struct veth_rq *rq,
>> >  					 const struct sk_buff *skb)
>> >  {
>> > -	return !(dev->features & NETIF_F_ALL_TSO) ||
>> > -		(skb->destructor == sock_wfree &&
>> > -		 rcv->features & (NETIF_F_GRO_FRAGLIST | NETIF_F_GRO_UDP_FWD));
>> > +	return rcu_access_pointer(rq->xdp_prog) ||
>> > +	       !(dev->features & NETIF_F_ALL_TSO) ||
>> > +	       (skb->destructor == sock_wfree &&
>> > +		rcv->features & (NETIF_F_GRO_FRAGLIST | NETIF_F_GRO_UDP_FWD));
>> >  }
>> >  
>> >  static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
>> > @@ -335,7 +336,7 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
>> >  		 * Don't bother with napi/GRO if the skb can't be aggregated
>> >  		 */
>> >  		use_napi = rcu_access_pointer(rq->napi) &&
>> > -			   veth_skb_is_eligible_for_gro(dev, rcv, skb);
>> > +			   veth_skb_is_eligible_for_gro(dev, rcv, rq, skb);
>> >  	}
>> >  
>> >  	skb_tx_timestamp(skb);
>> > @@ -1525,9 +1526,14 @@ static int veth_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>> >  			goto err;
>> >  		}
>> >  
>> > -		max_mtu = PAGE_SIZE - VETH_XDP_HEADROOM -
>> > -			  peer->hard_header_len -
>> > -			  SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>> > +		max_mtu = SKB_WITH_OVERHEAD(PAGE_SIZE - VETH_XDP_HEADROOM) -
>> > +			  peer->hard_header_len;
>> 
>> Why are we no longer accounting the size of the skb_shared_info if the
>> program doesn't support frags?
>
> doing so we do not allow packets over page boundaries (so non-linear xdp_buff)
> if the attached program does not delclare to support them, right?

Oh, sorry, somehow completely skipped over the addition of the
SKB_WITH_OVERHEAD() - so thought you were removing the sizeof(struct
skb_shared_info) from the calculation...

>> > +		/* Allow increasing the max_mtu if the program supports
>> > +		 * XDP fragments.
>> > +		 */
>> > +		if (prog->aux->xdp_has_frags)
>> > +			max_mtu += PAGE_SIZE * MAX_SKB_FRAGS;
>> > +
>> >  		if (peer->mtu > max_mtu) {
>> >  			NL_SET_ERR_MSG_MOD(extack, "Peer MTU is too large to set XDP");
>> >  			err = -ERANGE;
>> > @@ -1549,7 +1555,7 @@ static int veth_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>> >  		}
>> >  
>> >  		if (!old_prog) {
>> > -			peer->hw_features &= ~NETIF_F_GSO_SOFTWARE;
>> > +			peer->hw_features &= ~NETIF_F_GSO_FRAGLIST;
>> 
>> The patch description says we're enabling TSO, but this change enables a
>> couple of other flags as well. Also, it's not quite obvious to me why
>> your change makes this possible? Is it because we can now execute XDP on
>> a full TSO packet at once? Because then this should be coupled to the
>> xdp_has_frags flag of the XDP program? Or will the TSO packet be
>> segmented before it hits the XDP program? But then this change has
>> nothing to do with the rest of your series?
>
> actually tso support is not mandatory for this feature (even if it is probably
> meaningful). I will drop it from v5 and we can take care of it in a susequent
> patch.

OK, SGTM

-Toke

