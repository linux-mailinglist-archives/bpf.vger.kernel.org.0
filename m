Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D07687D3E
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 13:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbjBBMXi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 07:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjBBMXh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 07:23:37 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16044EDE
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 04:23:24 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id hx15so5351270ejc.11
        for <bpf@vger.kernel.org>; Thu, 02 Feb 2023 04:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RzzoO+rs1yXQRPvL9/DBCfoe2p63/8FVWLt7JufeGPU=;
        b=Wp6u18MfkGKleo4qBH7fw+Tkwy04f5VJQ+N9Jk3MqDbKmGmPdfCW7gagGQok8MunBu
         11DsDXSkV2TDlsM7VfdwXUFDqc6bkJheMyrlhRsWwAAZ3j+Y8PAf3p8qecPHBhqBnkc1
         favuuW7ARTeSNfMvVAYLiAQFxNf9pMySRkSLuIbSwCf1+xDdexoKiauKclkeOdqtjO+r
         lJDxDRhf3bNwx7+WIIs0fvZ3hGPGxAA8VtziC1GMCpUXJlp4fpKL5KlZZev2olf4DFq0
         CYicwjkQHTzmHi6hn4N9C1Rwy8Ot2rLCBKctwiDpnMg3tgtefZXsQ4ejPcCA1f3V2P3P
         t+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzzoO+rs1yXQRPvL9/DBCfoe2p63/8FVWLt7JufeGPU=;
        b=pL1vogWR7rHPnuklVKVo/A763MtwZReqq/PvFmHQOjIrietp8AfM7FLDjlDBgvGP4B
         b5zi4R9PP1krBlxIPZzCN0cnUnuJPpSQHe2SGsRnwn21zq3l+TFAeIgQVS2UaG8XpIdL
         W1z9Mcz7BpkwDfsaVsX43VAKp8ti/Fdo2Iqmgx8deiPw3M5Tdy5CAbGUp3awNDt6IPgB
         Mcdz5Zy04979tp3HjSj3qTSbo/l2S+p5OS0LMzPJjkWWR429hVIZTljZyyJCSMFZMUUm
         RXgJ4fI3If34NZnIQ9ZF7glfCS9qxRhIZ1M6U/QVIZZiE5sQ5To0KIitl2iXIZheH1sY
         qTww==
X-Gm-Message-State: AO0yUKUuwuPz7VYLRu8TScJpTsp56OO6ZdZp91kBI0PYreCxj7eX8esA
        NQZIho2cogYkaI8Uw1rZfsjGzQ==
X-Google-Smtp-Source: AK7set+QuCGLAunyF8fXIbKSPCwmnjLycgzyZOx1URHO0SiCMyRsSdh+z5/KbEGvJ6v/8OKQmXx2ww==
X-Received: by 2002:a17:907:8dcd:b0:88d:5fd1:3197 with SMTP id tg13-20020a1709078dcd00b0088d5fd13197mr6933340ejc.50.1675340603570;
        Thu, 02 Feb 2023 04:23:23 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id b18-20020a170906709200b0087bd2ebe474sm10084967ejk.208.2023.02.02.04.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 04:23:22 -0800 (PST)
Date:   Thu, 2 Feb 2023 13:23:22 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Parav Pandit <parav@nvidia.com>
Cc:     mst@redhat.com, jasowang@redhat.com, davem@davemloft.net,
        kuba@kernel.org, netdev@vger.kernel.org, edumazet@google.com,
        pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, virtualization@lists.linux-foundation.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH 1/2] virtio-net: Keep stop() to follow mirror sequence of
 open()
Message-ID: <Y9urOpSJfCquaaI9@nanopsycho>
References: <20230202050038.3187-1-parav@nvidia.com>
 <20230202050038.3187-2-parav@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202050038.3187-2-parav@nvidia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thu, Feb 02, 2023 at 06:00:37AM CET, parav@nvidia.com wrote:
>Cited commit in fixes tag frees rxq xdp info while RQ NAPI is
>still enabled and packet processing may be ongoing.
>
>Follow the mirror sequence of open() in the stop() callback.
>This ensures that when rxq info is unregistered, no rx
>packet processing is ongoing.
>
>Fixes: 754b8a21a96d ("virtio_net: setup xdp_rxq_info")
>Signed-off-by: Parav Pandit <parav@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
