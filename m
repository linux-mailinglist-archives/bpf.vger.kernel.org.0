Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D3255383E
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 18:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351718AbiFUQzX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jun 2022 12:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349156AbiFUQzX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 12:55:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 507801BE9E
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 09:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655830519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rTki38oTENU+woJKWPFljcLvdz9r8Pf46Okg0hK6I+U=;
        b=HF0G1jiFhGZ0V08UWfGQ7CzogrSRSsHLVVFJ0rzzvmpRvCppMJXRz5Zddr2MRJuFljmjsl
        IqkU9hqKMv7atZsXXe5E8lNqksGTF3CB6DGyuHqOeWMs98zqgwiJs6t6riRa+Y1p8TQNyb
        odgafuMFXKjIHkQzaqGVon3o+y1Gmes=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-tzYenl8GMIys0EwGU4Qiag-1; Tue, 21 Jun 2022 12:55:18 -0400
X-MC-Unique: tzYenl8GMIys0EwGU4Qiag-1
Received: by mail-lf1-f69.google.com with SMTP id bi38-20020a0565120ea600b0047f640eaee0so3875796lfb.4
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 09:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent:cc
         :subject:content-language:to:references:in-reply-to
         :content-transfer-encoding;
        bh=rTki38oTENU+woJKWPFljcLvdz9r8Pf46Okg0hK6I+U=;
        b=K5yrQrhlBpGbudRB7G8+eYUsnIzcYQtmvqPWHMNzCpPiBRzFv1HdpvOi2PcRyCm7Iq
         fNP9fgsPLigJHoRQsV8Zf+inHsCVVfz23Y9kk2t2Hvp0MibR0NUaIXkJW2C/NmYCc35l
         XuojVT/SVPZZWlJH5SpwplgQzLMjK5nkcHkmrxho/w3r7RaX1zH19KGY8YqXCa6nZ6ZY
         hVnvZRYM8KgzxbAzAt/zzpe3D4T+THP9sfDsff49RRfaaj4C9oD7ElMQZJ9AjM4bTP/i
         oBzXqfuj+Y1erRDaixD4PCdM9LODXxobcenum0wAriyWH983pVDwNdfwQYEq6OQPqcog
         dqvg==
X-Gm-Message-State: AJIora/3scaB/3spmhp1cpSvleGra6HdT+J+My4ec2hNFPO39ObKzfOx
        ZHYP3OwmD5Gq4ipCDgrf79yYlusZ4ecvEdK/rliAionbYhVaFjPNdWu11JspLa2nY5F9MLHAzgm
        eDHX2NXgLAU+8
X-Received: by 2002:a05:6512:108f:b0:479:48b0:b650 with SMTP id j15-20020a056512108f00b0047948b0b650mr17162606lfg.33.1655830516618;
        Tue, 21 Jun 2022 09:55:16 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v0629lBjiYvZP5ilH0gpbjEwcEANsPdXOtP5FLp+L4l3IkSdwquz6sjc+9PdaNYEfQ4pXSGg==
X-Received: by 2002:a05:6512:108f:b0:479:48b0:b650 with SMTP id j15-20020a056512108f00b0047948b0b650mr17162590lfg.33.1655830516405;
        Tue, 21 Jun 2022 09:55:16 -0700 (PDT)
Received: from [192.168.0.50] (87-59-106-155-cable.dk.customer.tdc.net. [87.59.106.155])
        by smtp.gmail.com with ESMTPSA id r8-20020a2e94c8000000b0024f3d1daedesm2001516ljh.102.2022.06.21.09.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 09:55:15 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <0a45e625-22c4-23d7-bb45-964cb9993b71@redhat.com>
Date:   Tue, 21 Jun 2022 18:55:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Cc:     brouer@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH net] virtio_net: fix xdp_rxq_info bug after suspend/resume
Content-Language: en-US
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
References: <20220621114845.3650258-1-stephan.gerhold@kernkonzept.com>
In-Reply-To: <20220621114845.3650258-1-stephan.gerhold@kernkonzept.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 21/06/2022 13.48, Stephan Gerhold wrote:
> The following sequence currently causes a driver bug warning
> when using virtio_net:
> 
>    # ip link set eth0 up
>    # echo mem > /sys/power/state (or e.g. # rtcwake -s 10 -m mem)
>    <resume>
>    # ip link set eth0 down
> 
>    Missing register, driver bug
>    WARNING: CPU: 0 PID: 375 at net/core/xdp.c:138 xdp_rxq_info_unreg+0x58/0x60

I love seeing that the sanity check we added are actually catching bugs
in drives like this :-)))

>    Call trace:
>     xdp_rxq_info_unreg+0x58/0x60
>     virtnet_close+0x58/0xac
>     __dev_close_many+0xac/0x140
>     __dev_change_flags+0xd8/0x210
>     dev_change_flags+0x24/0x64
>     do_setlink+0x230/0xdd0
>     ...
> 
> This happens because virtnet_freeze() frees the receive_queue
> completely (including struct xdp_rxq_info) but does not call
> xdp_rxq_info_unreg(). Similarly, virtnet_restore() sets up the
> receive_queue again but does not call xdp_rxq_info_reg().
> 
> Actually, parts of virtnet_freeze_down() and virtnet_restore_up()
> are almost identical to virtnet_close() and virtnet_open(): only
> the calls to xdp_rxq_info_(un)reg() are missing. This means that
> we can fix this easily and avoid such problems in the future by
> just calling virtnet_close()/open() from the freeze/restore handlers.
> 
> Aside from adding the missing xdp_rxq_info calls the only difference
> is that the refill work is only cancelled if netif_running(). However,
> this should not make any functional difference since the refill work
> should only be active if the network interface is actually up.
> 
> Fixes: 754b8a21a96d ("virtio_net: setup xdp_rxq_info")
> Signed-off-by: Stephan Gerhold<stephan.gerhold@kernkonzept.com>
> ---
>   drivers/net/virtio_net.c | 25 ++++++-------------------
>   1 file changed, 6 insertions(+), 19 deletions(-)

LGTM

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

