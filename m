Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655564C000D
	for <lists+bpf@lfdr.de>; Tue, 22 Feb 2022 18:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiBVRWb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Feb 2022 12:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiBVRWb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Feb 2022 12:22:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5695B10856A
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 09:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645550523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Rov6ncWmYdTpBP7J4wDIuhDW3idvx8q/MaZIno7w/U=;
        b=HJfA4e9wIWn+JM3nJFpudBeaKh/mRkgsIks9rzJqenlvsl+waVJFTYABA94xCTUSX5YnyI
        FF5Xqx5j2lk509X0pSl4xY9wpqA5PAmJPQ32nxRpOvWSSScFM9mvhbkGORhTgcnhzg8Cjl
        4jnB+Odr3syMvyb7EsXO7yDvxF7pBoU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-AIZCwHNCPEiCxHcpRbzkBg-1; Tue, 22 Feb 2022 12:22:01 -0500
X-MC-Unique: AIZCwHNCPEiCxHcpRbzkBg-1
Received: by mail-wr1-f70.google.com with SMTP id j27-20020adfb31b000000b001ea8356972bso1484159wrd.1
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 09:22:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=9Rov6ncWmYdTpBP7J4wDIuhDW3idvx8q/MaZIno7w/U=;
        b=NJTNToF+NPuIS5GnLIRfJDFg3mRfwtwsWV5cBpx00IqtKfvspxWN2lOlVVT1650jJt
         ZKkwKYonL3pucvxQfio4kltH6azqjrEnQ6M9lIgW8b8W7GgZ+JMu02wCbi2M6EselVTW
         MCC4woTL51S2JTkU46swzOHemM0LQ6i42duNYsHrA28ExwnP/uWwnOgxUXUwe3nUi+eY
         zb1ZreLbpWMb2WKT0OeV7cUJXSrIHRCDfoVj2O5pcttmVSRIG/9Vz0eZTAVbSYhhA4gY
         AYYsP23cErtUweW3jxst/Cu+2RrFEwcLxix8FE8sIwWktSpBNpfVOKtvAgV212QSJoU4
         A2fQ==
X-Gm-Message-State: AOAM5311XH5OwA+uG/XCeHDvOL6AhecPPKF4aNhlipwTF5kVJ+atWtI0
        Rvp80Q5PPDsuXQJq9BAJGNTzl1Q4zD8pEvWIYKogDZPuyIc0/0g8By/9rIAd0a1zRGX2bvtfppY
        IRz+lv843LPgi
X-Received: by 2002:adf:db4f:0:b0:1e6:8b9a:f96c with SMTP id f15-20020adfdb4f000000b001e68b9af96cmr19760538wrj.454.1645550519112;
        Tue, 22 Feb 2022 09:21:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzU0F81CvONtbml/nEQM9lMsb1ySsOfNVDClBM4DT9J6t+jRiYpdSCfDFDOSLFWru6zTY4NVg==
X-Received: by 2002:adf:db4f:0:b0:1e6:8b9a:f96c with SMTP id f15-20020adfdb4f000000b001e68b9af96cmr19760514wrj.454.1645550518808;
        Tue, 22 Feb 2022 09:21:58 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-108-216.dyn.eolo.it. [146.241.108.216])
        by smtp.gmail.com with ESMTPSA id i15sm3599765wmq.23.2022.02.22.09.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 09:21:58 -0800 (PST)
Message-ID: <0c9bc29843cd1697aa89ebceb61b8efe8156a9e8.camel@redhat.com>
Subject: Re: [PATCH v2 bpf-next 3/3] veth: allow jumbo frames in xdp mode
From:   Paolo Abeni <pabeni@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, brouer@redhat.com, toke@redhat.com,
        echaudro@redhat.com, lorenzo.bianconi@redhat.com,
        toshiaki.makita1@gmail.com, andrii@kernel.org
Date:   Tue, 22 Feb 2022 18:21:56 +0100
In-Reply-To: <15943b59b1638515770b7ab841b0d741dc314c3a.1644930125.git.lorenzo@kernel.org>
References: <cover.1644930124.git.lorenzo@kernel.org>
         <15943b59b1638515770b7ab841b0d741dc314c3a.1644930125.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2022-02-15 at 14:08 +0100, Lorenzo Bianconi wrote:
> Allow increasing the MTU over page boundaries on veth devices
> if the attached xdp program declares to support xdp fragments.
> Enable NETIF_F_ALL_TSO when the device is running in xdp mode.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/veth.c | 26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index a45aaaecc21f..2e048f957bc6 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -292,8 +292,6 @@ static int veth_forward_skb(struct net_device *dev, struct sk_buff *skb,
>  /* return true if the specified skb has chances of GRO aggregation
>   * Don't strive for accuracy, but try to avoid GRO overhead in the most
>   * common scenarios.
> - * When XDP is enabled, all traffic is considered eligible, as the xmit
> - * device has TSO off.
>   * When TSO is enabled on the xmit device, we are likely interested only
>   * in UDP aggregation, explicitly check for that if the skb is suspected
>   * - the sock_wfree destructor is used by UDP, ICMP and XDP sockets -
> @@ -334,7 +332,8 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
>  		 * Don't bother with napi/GRO if the skb can't be aggregated
>  		 */
>  		use_napi = rcu_access_pointer(rq->napi) &&
> -			   veth_skb_is_eligible_for_gro(dev, rcv, skb);
> +			   (rcu_access_pointer(rq->xdp_prog) ||
> +			    veth_skb_is_eligible_for_gro(dev, rcv, skb));

Sorry for the late feedback. I think the code would be more readable if
you move the additional check inside 'veth_skb_is_eligible_for_gro' and
adjust veth_skb_is_eligible_for_gro() comment accordingly.

Thanks!

Paolo

