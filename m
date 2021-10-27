Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2076D43C2E1
	for <lists+bpf@lfdr.de>; Wed, 27 Oct 2021 08:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238624AbhJ0GXZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 02:23:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30989 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239972AbhJ0GXW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 27 Oct 2021 02:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635315657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y5IbjGZT6ncLji1412wTNCgblKToa0KMNUhBknTBoOE=;
        b=fyIhbyY+5do4asd2R+68O/0Xo+ekWMOaRhZ7rS9HwinyTKHQ8vH0BCeutNzw90AyeNMo13
        nq/pOFd9CBY/BlWQ+e36tnBGQUfkod/8Rbu8erQRzHDa14uD6svRLPaQrD61me3jbZ05ig
        cOk7wpqBJ/bz5ZANnSqHcbNk75Y+AXQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-dTUb1sFJM6GePq5dJOO1kA-1; Wed, 27 Oct 2021 02:20:55 -0400
X-MC-Unique: dTUb1sFJM6GePq5dJOO1kA-1
Received: by mail-ed1-f70.google.com with SMTP id t18-20020a056402021200b003db9e6b0e57so1329492edv.10
        for <bpf@vger.kernel.org>; Tue, 26 Oct 2021 23:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:cc:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y5IbjGZT6ncLji1412wTNCgblKToa0KMNUhBknTBoOE=;
        b=zpIhIlgmPFSG3i5fy0mYv6WJHpMtHmalRUy7tx1Ri2+w52liuwL3K8vUQKMmnWaBJV
         MEzMiXnM+RCf44TdQ+wMwI3yriSQo3HW8kktFI97KgJxZNcbevPiUFAYFT1uh3pCdljK
         bUKadEPJuK5S02cnHZJtgqYu23rKrLLTOLxHLRWVTk8HH8WIPxfxokTtkZ7IyJmSqKnQ
         TmajhP16YLrwf6nrQ9j30sYkcuOOGDI3ks0WaWyKLhjm0MVHa2MTITlIIQ0RHsEVMy/1
         G15g08XNW4rweD6vKU9UpEUk6rJ3Fhfh+8xuS+xx6T1RV0J4WiK+CF/x5EjTYDeMrF8H
         nHsw==
X-Gm-Message-State: AOAM5326UuklVcnqDLYsNO/XK/66j9rAVAeHis28j6be2yMPbBRsv23q
        zjX8n8na91gq7UlsWerDHP5OdWYU62+BWI+CFmzNzpNMXYoAG6y6WHPHkeET2ucmVvMxPLHNdVb
        Fx+lsP5uQh5P6
X-Received: by 2002:aa7:d34f:: with SMTP id m15mr42149456edr.40.1635315654700;
        Tue, 26 Oct 2021 23:20:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxL1weoF88I/0V+Lz+k0kuNgr3cDwX0UE1tb2DCxFcXqabkq8zk5Ay5zmfolyIHuRIgkMJmNQ==
X-Received: by 2002:aa7:d34f:: with SMTP id m15mr42149436edr.40.1635315654540;
        Tue, 26 Oct 2021 23:20:54 -0700 (PDT)
Received: from [192.168.42.238] (3-14-107-185.static.kviknet.dk. [185.107.14.3])
        by smtp.gmail.com with ESMTPSA id s12sm343243edc.48.2021.10.26.23.20.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 23:20:53 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     brouer@redhat.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Subject: Re: [PATCH net-next] xdp: Remove redundant warning
To:     Yajun Deng <yajun.deng@linux.dev>, ast@kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
        hawk@kernel.org, john.fastabend@gmail.com
References: <20211027013856.1866-1-yajun.deng@linux.dev>
Message-ID: <095fa222-824a-b38c-3432-35bdb61bab88@redhat.com>
Date:   Wed, 27 Oct 2021 08:20:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211027013856.1866-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 27/10/2021 03.38, Yajun Deng wrote:
> There is a warning in xdp_rxq_info_unreg_mem_model() when reg_state isn't
> equal to REG_STATE_REGISTERED, so the warning in xdp_rxq_info_unreg() is
> redundant.
 >
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

I guess/wonder if we should mark this as a fix for:

Fixes: dce5bd6140a4 ("xdp: export xdp_rxq_info_unreg_mem_model")

> ---
>   net/core/xdp.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index cc92ccb38432..5ddc29f29bad 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -143,8 +143,6 @@ void xdp_rxq_info_unreg(struct xdp_rxq_info *xdp_rxq)
>   	if (xdp_rxq->reg_state == REG_STATE_UNUSED)
>   		return;
>   
> -	WARN(!(xdp_rxq->reg_state == REG_STATE_REGISTERED), "Driver BUG");
> -
>   	xdp_rxq_info_unreg_mem_model(xdp_rxq);
>   
>   	xdp_rxq->reg_state = REG_STATE_UNREGISTERED;
> 

