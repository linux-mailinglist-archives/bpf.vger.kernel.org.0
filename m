Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEC65ACDCD
	for <lists+bpf@lfdr.de>; Mon,  5 Sep 2022 10:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237434AbiIEIeQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Sep 2022 04:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238033AbiIEIdz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Sep 2022 04:33:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F259140BFF
        for <bpf@vger.kernel.org>; Mon,  5 Sep 2022 01:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662366748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S4JK4m0m3+hN9/NjyD45TlkaSX2pzOEl0JORrLG6mzs=;
        b=YeNjLLR3zUg8fQLeuW3wzkjIYVPWu4bcvr3wuT8gAb6KWLq8FMTavfAwWO+9EVWdTxc8ZS
        LVtuXXy7WsmeGy6TZVScwC/HW7zxM1/P/B91oyIOENBFWctT+EtMdfEu8OEiuMIWq0x2Ix
        MdhMofBotyuQ/Sx8gBuLoW02BgZ8QOU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-581-N0DopPe1NgWh1LXBYrJMoA-1; Mon, 05 Sep 2022 04:32:26 -0400
X-MC-Unique: N0DopPe1NgWh1LXBYrJMoA-1
Received: by mail-pl1-f197.google.com with SMTP id x6-20020a170902ec8600b001754410b6d0so5760207plg.10
        for <bpf@vger.kernel.org>; Mon, 05 Sep 2022 01:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=S4JK4m0m3+hN9/NjyD45TlkaSX2pzOEl0JORrLG6mzs=;
        b=KDIUsYXysrEU6T0glBQ7k/Vy25e869RaWUgySSP4N6OD7tumveqvC5CT7UlSZ4NKlh
         LKm9IsISJTQ1pdyfud1QiHFFI57PLTOZnYHGypxqE12MyAIJLPdR/OyBFNGwokEBGt+3
         V15XhaXjx4TilFPfvDAW64xwDQOsMMCnwg6BrITOB+7G4s6OUy9upyuLHamkSnOdtGWr
         ZXm3T8NC5dNGxZ2ccldpvsRJRkJCva2Fl/G5c+gslPQ7D7iq4dUmB/m9nxqB4v4z+APD
         6WBx3rGOfRGdurhVfiXTjlKh1lYflC2bDhcv7nrmGBSsGG4fB+gKqiP910JgORVtqdv9
         du+g==
X-Gm-Message-State: ACgBeo3b9nCN4h7c5CPWMOVo1alg+OnrfSZIgOAKo5mAzsI+L/p3T0Xb
        eRxATLNv9f5AWIvCLi/lmx6qePB44FxNdeQ6mZxwl0AmIlRwYvx4K+JUN8vTJNYLhkmiIiafwZk
        vR8OajG8rmYLC
X-Received: by 2002:a17:90b:1d8b:b0:200:5367:5ecd with SMTP id pf11-20020a17090b1d8b00b0020053675ecdmr5847730pjb.165.1662366745421;
        Mon, 05 Sep 2022 01:32:25 -0700 (PDT)
X-Google-Smtp-Source: AA6agR55K+TMI7e0v4Qj3djAA88LyYePDornUMNHcPRaFDkQVGBJ3mgtkBq2b8FE5Hf5q95howCsPg==
X-Received: by 2002:a17:90b:1d8b:b0:200:5367:5ecd with SMTP id pf11-20020a17090b1d8b00b0020053675ecdmr5847703pjb.165.1662366745129;
        Mon, 05 Sep 2022 01:32:25 -0700 (PDT)
Received: from [10.72.13.239] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id o20-20020aa79794000000b0052c7ff2ac74sm7345483pfp.17.2022.09.05.01.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 01:32:24 -0700 (PDT)
Message-ID: <10630d99-e0bd-c067-8766-19266b38d2fe@redhat.com>
Date:   Mon, 5 Sep 2022 16:32:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH] vhost-net: support VIRTIO_F_RING_RESET
Content-Language: en-US
To:     Kangjie Xu <kangjie.xu@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org
Cc:     mst@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        hengqi@linux.alibaba.com, xuanzhuo@linux.alibaba.com
References: <20220825085610.80315-1-kangjie.xu@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220825085610.80315-1-kangjie.xu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


在 2022/8/25 16:56, Kangjie Xu 写道:
> Add VIRTIO_F_RING_RESET, which indicates that the driver can reset a
> queue individually.
>
> VIRTIO_F_RING_RESET feature is added to virtio-spec 1.2. The relevant
> information is in
>      oasis-tcs/virtio-spec#124
>      oasis-tcs/virtio-spec#139
>
> The implementation only adds the feature bit in supported features. It
> does not require any other changes because we reuse the existing vhost
> protocol.
>
> The virtqueue reset process can be concluded as two parts:
> 1. The driver can reset a virtqueue. When it is triggered, we use the
> set_backend to disable the virtqueue.
> 2. After the virtqueue is disabled, the driver may optionally re-enable
> it. The process is basically similar to when the device is started,
> except that the restart process does not need to set features and set
> mem table since they do not change. QEMU will send messages containing
> size, base, addr, kickfd and callfd of the virtqueue in order.
> Specifically, the host kernel will receive these messages in order:
>      a. VHOST_SET_VRING_NUM
>      b. VHOST_SET_VRING_BASE
>      c. VHOST_SET_VRING_ADDR
>      d. VHOST_SET_VRING_KICK
>      e. VHOST_SET_VRING_CALL
>      f. VHOST_NET_SET_BACKEND
> Finally, after we use set_backend to attach the virtqueue, the virtqueue
> will be enabled and start to work.
>
> Signed-off-by: Kangjie Xu <kangjie.xu@linux.alibaba.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>
> Test environment and method:
>      Host: 5.19.0-rc3
>      Qemu: QEMU emulator version 7.0.50 (With vq rset support)
>      Guest: 5.19.0-rc3 (With vq reset support)
>      Test Cmd: ethtool -g eth1; ethtool -G eth1 rx $1 tx $2; ethtool -g eth1;
>
>      The drvier can resize the virtio queue, then virtio queue reset function should
>      be triggered.
>
>      The default is split mode, modify Qemu virtio-net to add PACKED feature to
>      test packed mode.
>
> Guest Kernel Patch:
>      https://lore.kernel.org/bpf/20220801063902.129329-1-xuanzhuo@linux.alibaba.com/
>
> QEMU Patch:
>      https://lore.kernel.org/qemu-devel/cover.1661414345.git.kangjie.xu@linux.alibaba.com/
>
> Looking forward to your review and comments. Thanks.
>
>   drivers/vhost/net.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 68e4ecd1cc0e..8a34928d4fef 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -73,7 +73,8 @@ enum {
>   	VHOST_NET_FEATURES = VHOST_FEATURES |
>   			 (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
>   			 (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
> -			 (1ULL << VIRTIO_F_ACCESS_PLATFORM)
> +			 (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
> +			 (1ULL << VIRTIO_F_RING_RESET)
>   };
>   
>   enum {

