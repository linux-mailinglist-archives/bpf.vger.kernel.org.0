Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C73687D41
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 13:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjBBM0d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 07:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjBBM0c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 07:26:32 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C13B10E7
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 04:26:31 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id f7so1814334edw.5
        for <bpf@vger.kernel.org>; Thu, 02 Feb 2023 04:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S7sYYgg2jsSsqfHYoOgYRUdGHEvEeX7qXOLmHeKC8p8=;
        b=4q0dez63wK0NxgTf7F5Zykcqw+4CeVc/0tCYDtNPiMSqy9vSY3yKOlTkx6tXFZrqws
         I6Ug43xgnRW3iDn84HqXY5QuHaT1rWko/LNygdSFBmnRoEJ4x8cL668qKJMV67vo5Y3K
         HWgTz/a5D+jEpKoow0KIL0pd2C5kqJX13jh8hjCbFmy+LCS4FT3opw14/ESECSCaZOCS
         J6oKYmrrcOQ1Ridle3vUVcVErgNQm4L9d4LrgY+giiYBazUoEBMSmFGhNcqb+MWYlSH8
         eIOPwTDDmLVAY1MXX0GXR3Zn8IWEehBdXy7Y2RLjmana5EhvG6eiuUyQMqnCefTRCFTY
         VQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7sYYgg2jsSsqfHYoOgYRUdGHEvEeX7qXOLmHeKC8p8=;
        b=qOypQVkW78gebJfHpm8h3Tmh3nni+gD5d9MTqTcCtDmjUUiV03ju1LC5pjyMz/qrAR
         ygkGisiYOX+Wf+ATR+I9ONEZY3dTZFjNVbMMHdU9CnbqzNNMjqfu5QRq0muV7eEjnlBF
         RXg7NvQEvr/REmBIPBbbqNgh9WGrxMFgNKBLHN8jaWMLhyEhhMryma8n5o0Et3h5X/zj
         bLB1R4Wee7qJYQQ7mNo230jd0xXWHYHw94ZPMNSs9j9WbvAXMd6/TWmekt1G+S6kob0e
         cqVV/+INEgmBTEtNLVDgEhIsWlcJlu5/fItr0pBOMjpmBX05/9A5LoCXkAABTCcx1ov1
         Lxsg==
X-Gm-Message-State: AO0yUKWoXeJjc858Q438uVHABFtpXL7gElwkm61Wo3kGgpAGGW+Oaf49
        0zto9E/VN46BdaFmM8aOVfWukQ==
X-Google-Smtp-Source: AK7set9sq3vNdJzvyaY5Du3K2nGppq7h0EwWyufstEm28JWF8u8oBIMBlWycDc8DBS6RvVl1eI4e3A==
X-Received: by 2002:a05:6402:3488:b0:49d:9ff4:d82b with SMTP id v8-20020a056402348800b0049d9ff4d82bmr7422571edc.15.1675340790099;
        Thu, 02 Feb 2023 04:26:30 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id t15-20020a508d4f000000b004a0e2fe619esm11152263edt.39.2023.02.02.04.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 04:26:29 -0800 (PST)
Date:   Thu, 2 Feb 2023 13:26:28 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Parav Pandit <parav@nvidia.com>
Cc:     mst@redhat.com, jasowang@redhat.com, davem@davemloft.net,
        kuba@kernel.org, netdev@vger.kernel.org, edumazet@google.com,
        pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, virtualization@lists.linux-foundation.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] virtio-net: Maintain reverse cleanup order
Message-ID: <Y9ur9B6CDIwThMN6@nanopsycho>
References: <20230202050038.3187-1-parav@nvidia.com>
 <20230202050038.3187-3-parav@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202050038.3187-3-parav@nvidia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thu, Feb 02, 2023 at 06:00:38AM CET, parav@nvidia.com wrote:
>To easily audit the code, better to keep the device stop()
>sequence to be mirror of the device open() sequence.
>
>Signed-off-by: Parav Pandit <parav@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

If this is not fixing bug (which I believe is the case), you should
target it to net-next ([patch net-next] ..).


>---
> drivers/net/virtio_net.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>index b7d0b54c3bb0..1f8168e0f64d 100644
>--- a/drivers/net/virtio_net.c
>+++ b/drivers/net/virtio_net.c
>@@ -2279,9 +2279,9 @@ static int virtnet_close(struct net_device *dev)
> 	cancel_delayed_work_sync(&vi->refill);
> 
> 	for (i = 0; i < vi->max_queue_pairs; i++) {
>+		virtnet_napi_tx_disable(&vi->sq[i].napi);
> 		napi_disable(&vi->rq[i].napi);
> 		xdp_rxq_info_unreg(&vi->rq[i].xdp_rxq);
>-		virtnet_napi_tx_disable(&vi->sq[i].napi);
> 	}
> 
> 	return 0;
>-- 
>2.26.2
>
