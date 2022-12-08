Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF89646A55
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 09:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiLHIUs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 03:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiLHIUr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 03:20:47 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D82D12A88;
        Thu,  8 Dec 2022 00:20:46 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 97D2325B;
        Thu,  8 Dec 2022 09:20:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1670487644;
        bh=bOctRyFpI167+stzp4sRyQvVjJFAZplCZyJw2A7nyOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FkzlMasGlNHDGoYJIV4ld89m3rNXD9fLyo9aQzXcYxEWfuEtDBmeBNXHa9UFm6smj
         6PiyFMmR3DaSr5i9gCnSM/c3b5A8ytzvFM0/xem+ugIH24dG8CUprcndQ34myBCdot
         wsUpNCYZqQd51p05j/c+vsy/xmAy9iGWMWyuospw=
Date:   Thu, 8 Dec 2022 10:20:42 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Yuan Can <yuancan@huawei.com>
Cc:     jacopo@jmondi.org, mchehab@kernel.org,
        heikki.krogerus@linux.intel.com, ajayg@nvidia.com,
        luzmaximilian@gmail.com, jdelvare@suse.de, kabel@kernel.org,
        u.kleine-koenig@pengutronix.de, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] media: i2c: ov772x: Fix memleak in ov772x_probe()
Message-ID: <Y5GeWiUANx1j6wmh@pendragon.ideasonboard.com>
References: <20221208080625.130392-1-yuancan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221208080625.130392-1-yuancan@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Yuan,

Thank you for the patch.

On Thu, Dec 08, 2022 at 08:06:25AM +0000, Yuan Can wrote:
> A memory leak was reported when testing ov772x with bpf mock device:
> 
> AssertionError: unreferenced object 0xffff888109afa7a8 (size 8):
>   comm "python3", pid 279, jiffies 4294805921 (age 20.681s)
>   hex dump (first 8 bytes):
>     80 22 88 15 81 88 ff ff                          ."......
>   backtrace:
>     [<000000009990b438>] __kmalloc_node+0x44/0x1b0
>     [<000000009e32f7d7>] kvmalloc_node+0x34/0x180
>     [<00000000faf48134>] v4l2_ctrl_handler_init_class+0x11d/0x180 [videodev]
>     [<00000000da376937>] ov772x_probe+0x1c3/0x68c [ov772x]
>     [<000000003f0d225e>] i2c_device_probe+0x28d/0x680
>     [<00000000e0b6db89>] really_probe+0x17c/0x3f0
>     [<000000001b19fcee>] __driver_probe_device+0xe3/0x170
>     [<0000000048370519>] driver_probe_device+0x49/0x120
>     [<000000005ead07a0>] __device_attach_driver+0xf7/0x150
>     [<0000000043f452b8>] bus_for_each_drv+0x114/0x180
>     [<00000000358e5596>] __device_attach+0x1e5/0x2d0
>     [<0000000043f83c5d>] bus_probe_device+0x126/0x140
>     [<00000000ee0f3046>] device_add+0x810/0x1130
>     [<00000000e0278184>] i2c_new_client_device+0x359/0x4f0
>     [<0000000070baf34f>] of_i2c_register_device+0xf1/0x110
>     [<00000000a9f2159d>] of_i2c_notify+0x100/0x160
> unreferenced object 0xffff888119825c00 (size 256):
>   comm "python3", pid 279, jiffies 4294805921 (age 20.681s)
>   hex dump (first 32 bytes):
>     00 b4 a5 17 81 88 ff ff 00 5e 82 19 81 88 ff ff  .........^......
>     10 5c 82 19 81 88 ff ff 10 5c 82 19 81 88 ff ff  .\.......\......
>   backtrace:
>     [<000000009990b438>] __kmalloc_node+0x44/0x1b0
>     [<000000009e32f7d7>] kvmalloc_node+0x34/0x180
>     [<0000000073d88e0b>] v4l2_ctrl_new.cold+0x19b/0x86f [videodev]
>     [<00000000b1f576fb>] v4l2_ctrl_new_std+0x16f/0x210 [videodev]
>     [<00000000caf7ac99>] ov772x_probe+0x1fa/0x68c [ov772x]
>     [<000000003f0d225e>] i2c_device_probe+0x28d/0x680
>     [<00000000e0b6db89>] really_probe+0x17c/0x3f0
>     [<000000001b19fcee>] __driver_probe_device+0xe3/0x170
>     [<0000000048370519>] driver_probe_device+0x49/0x120
>     [<000000005ead07a0>] __device_attach_driver+0xf7/0x150
>     [<0000000043f452b8>] bus_for_each_drv+0x114/0x180
>     [<00000000358e5596>] __device_attach+0x1e5/0x2d0
>     [<0000000043f83c5d>] bus_probe_device+0x126/0x140
>     [<00000000ee0f3046>] device_add+0x810/0x1130
>     [<00000000e0278184>] i2c_new_client_device+0x359/0x4f0
>     [<0000000070baf34f>] of_i2c_register_device+0xf1/0x110
> 
> The reason is that if priv->hdl.error is set, ov772x_probe() jumps to the
> error_mutex_destroy without doing v4l2_ctrl_handler_free(), and all
> resources allocated in v4l2_ctrl_handler_init() and v4l2_ctrl_new_std()
> are leaked.
> 
> Fixes: 1112babde214 ("media: i2c: Copy ov772x soc_camera sensor driver")
> Signed-off-by: Yuan Can <yuancan@huawei.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/i2c/ov772x.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov772x.c b/drivers/media/i2c/ov772x.c
> index 4189e3fc3d53..a238e63425f8 100644
> --- a/drivers/media/i2c/ov772x.c
> +++ b/drivers/media/i2c/ov772x.c
> @@ -1462,7 +1462,7 @@ static int ov772x_probe(struct i2c_client *client)
>  	priv->subdev.ctrl_handler = &priv->hdl;
>  	if (priv->hdl.error) {
>  		ret = priv->hdl.error;
> -		goto error_mutex_destroy;
> +		goto error_ctrl_free;
>  	}
>  
>  	priv->clk = clk_get(&client->dev, NULL);
> @@ -1515,7 +1515,6 @@ static int ov772x_probe(struct i2c_client *client)
>  	clk_put(priv->clk);
>  error_ctrl_free:
>  	v4l2_ctrl_handler_free(&priv->hdl);
> -error_mutex_destroy:
>  	mutex_destroy(&priv->lock);
>  
>  	return ret;

-- 
Regards,

Laurent Pinchart
