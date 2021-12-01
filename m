Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14952464B8A
	for <lists+bpf@lfdr.de>; Wed,  1 Dec 2021 11:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348592AbhLAK2d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Dec 2021 05:28:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22722 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348557AbhLAK2b (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 1 Dec 2021 05:28:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638354309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NUuEbHoZMvDjZ6xkgKYJQ/5wnlYmlybqTTOhVgFntb0=;
        b=N6C3+r8ihG6LOtJrsQfPCzf4lLFsm2pHd5Lgi1MFtHUTFrIbr8/MIAmIGWLX7DmLJWv6F1
        i+esgD1iNhoWP8rs+QjK2/CA6jpC8BwfSxAFuRZgwKJvPB4EWkoiV3T6OKAUelC8q8ylsD
        0WpFdoxNODKIERZsnD1my7PH0ozO9Zw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-430-S1BwKeXVO4mAgNywb5b0-Q-1; Wed, 01 Dec 2021 05:25:08 -0500
X-MC-Unique: S1BwKeXVO4mAgNywb5b0-Q-1
Received: by mail-ed1-f72.google.com with SMTP id q17-20020aa7da91000000b003e7c0641b9cso19855321eds.12
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 02:25:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent:cc
         :subject:content-language:to:references:in-reply-to
         :content-transfer-encoding;
        bh=NUuEbHoZMvDjZ6xkgKYJQ/5wnlYmlybqTTOhVgFntb0=;
        b=k9ljJhbkSUAqw8Tcum+lZvNL82fXZbuVzZgn0+dIf6miUy58lY1VKJu5OIkEP8cdcv
         HQoC/guersn6idlwT7x9V2JHt2KJrughXC1xIAzZg0iP8KkH9D3aiAd5Dods71AaKjoa
         yyqZ/nw/KVNXdinGZoWnX9/1AuO+V22GjM+ZOgtSmrAevZGMkGGESYnltGXAig9LyqH/
         LxwM6HDOseOGgSlj5/l8cxm4Wak1DOpcjmUsbZBwBA662Ms7aMyb+7rbdOol1ZE3y8Wn
         Mfsw5mQbwYlHBmHR7DFVV8gxjlTbLmlPo4cDPrTUbm9IV7Wsrq32rGcT2D/RKHdTqgoT
         6Xuw==
X-Gm-Message-State: AOAM531ICZzzUCRd2Bb8RWlEc6s2c2pfYALn+USwfSLivYJYNCUqYDvv
        MHiLyjLt0n4tZWBXbg4BY3/ZhICOPnATIIvTW8+T2obGy2RpIzknv2AmBBBzY4wk14pbDOWySs7
        0vrNHu0DbVdnh
X-Received: by 2002:a05:6402:2814:: with SMTP id h20mr7208837ede.288.1638354307276;
        Wed, 01 Dec 2021 02:25:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx7zWt7d2gxC7lYVybBM9KToK1+c4o6A1wxtmjadhCt1FFxFU/uPQVp+adHi1ddtzJRLjd+fg==
X-Received: by 2002:a05:6402:2814:: with SMTP id h20mr7208804ede.288.1638354307090;
        Wed, 01 Dec 2021 02:25:07 -0800 (PST)
Received: from [192.168.2.13] (3-14-107-185.static.kviknet.dk. [185.107.14.3])
        by smtp.gmail.com with ESMTPSA id gn16sm10716476ejc.67.2021.12.01.02.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 02:25:06 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <78c7dbae-ea41-5afc-bd13-66969145fbd1@redhat.com>
Date:   Wed, 1 Dec 2021 11:25:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Cc:     brouer@redhat.com, netdev@vger.kernel.org, sasha.neftin@intel.com,
        vitaly.lifshits@intel.com, maciej.fijalkowski@intel.com,
        magnus.karlsson@intel.com, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org,
        andrii@kernel.org
Subject: Re: [PATCH net-next 0/2][pull request] 1GbE Intel Wired LAN Driver
 Updates 2021-11-30
Content-Language: en-US
To:     Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
        kuba@kernel.org
References: <20211130175918.3705966-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20211130175918.3705966-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 30/11/2021 18.59, Tony Nguyen wrote:
> Jesper Dangaard Brouer says:
> 
> Changes to fix and enable XDP metadata to a specific Intel driver igc.
> Tested with hardware i225 that uses driver igc, while testing AF_XDP
> access to metadata area.
> 
> The following are changes since commit 196073f9c44be0b4758ead11e51bc2875f98df29:
>    net: ixp4xx_hss: drop kfree for memory allocated with devm_kzalloc
> and are available in the git repository at:
>    git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 1GbE
> 
> Jesper Dangaard Brouer (2):
>    igc: AF_XDP zero-copy metadata adjust breaks SKBs on XDP_PASS
>    igc: enable XDP metadata in driver
> 
>   drivers/net/ethernet/intel/igc/igc_main.c | 37 +++++++++++++++--------
>   1 file changed, 25 insertions(+), 12 deletions(-)


Thanks Tony for taking care of these :-)
The adjustments looks good to me.

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

--Jesper

