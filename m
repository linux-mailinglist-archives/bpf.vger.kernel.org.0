Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8AFB46A289
	for <lists+bpf@lfdr.de>; Mon,  6 Dec 2021 18:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbhLFRPT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Dec 2021 12:15:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21785 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239283AbhLFRPS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 6 Dec 2021 12:15:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638810709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oYJSRXlCQvqoekkmUT1Fgmbdlhji9wMR6mcn5EGWQwM=;
        b=bE/n4ctN9/iwVqA5mSm9z1Gr0qCniuAQUI/cDJ6mj37b9VYdv/qCx8ZC/ROSos37ZnYF5g
        lYBnHjcSghEgYF+eoTKMtxmMd4AOW2fxQ+XenzArk9/ecEfE39ZWqaaZXCsjvkCGJl5sTt
        7xvmXSdmHCPLbtkYo8oMPZbb8qv6jCQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-goDnkK-QP9-HkxsGtf5HzA-1; Mon, 06 Dec 2021 12:11:46 -0500
X-MC-Unique: goDnkK-QP9-HkxsGtf5HzA-1
Received: by mail-ed1-f72.google.com with SMTP id eg20-20020a056402289400b003eb56fcf6easo8857320edb.20
        for <bpf@vger.kernel.org>; Mon, 06 Dec 2021 09:11:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent:cc
         :subject:content-language:to:references:in-reply-to
         :content-transfer-encoding;
        bh=oYJSRXlCQvqoekkmUT1Fgmbdlhji9wMR6mcn5EGWQwM=;
        b=1RFCOjjCLlNPULoQM1yA/9OV68b1KAl2L3UD3Fz5Z8dodzkn0wBMOnzuz/DlezdZoF
         1d/07jRPRNV/AWYMCMUZVW8Fts47SyXO0AwvvNWtlKaXC9VBODz6AZhTxqViPM3QHGmS
         0L8OlR/fgj/tiwy40brGMJehxwQmW6XRxH95GTKoJD5OJ5zC6UCK8QzPFCNZweZP32P1
         YOuabjqiBQEhz963vLX4H8m7ebem7on/MeRxxbmJYHWXC3E7cgrOssKkHV9DwBEGxVl4
         q/YvnAqsGwlFdia09lc9Mi3zA9gUMzQ6Iez8YFvr8tkpArnXfdBsSNBFXBOOQuy0lb1l
         wnSA==
X-Gm-Message-State: AOAM53163aZqzWNYxhc0pvqSCaiWW+vFYKowPTtZ5+ePDzpyn0ke1RnC
        iuCOa/qdIXDMlzS4maKFMKNriUSpIaXxkzwIribkGCKmVzqlrPUq0cQnIxDhbC6F7kBh8iDath3
        2ukjRnvHHXB/Z
X-Received: by 2002:a17:906:52d8:: with SMTP id w24mr48564713ejn.296.1638810705567;
        Mon, 06 Dec 2021 09:11:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzyoD56llMY1ZDKzFDTD4gBAP/S5avR11d4drDEw8qzIJZQpt9yV7apY6Nc+5UF8JmIlgAWxQ==
X-Received: by 2002:a17:906:52d8:: with SMTP id w24mr48564681ejn.296.1638810705381;
        Mon, 06 Dec 2021 09:11:45 -0800 (PST)
Received: from [192.168.2.13] (3-14-107-185.static.kviknet.dk. [185.107.14.3])
        by smtp.gmail.com with ESMTPSA id h7sm9563725ede.40.2021.12.06.09.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 09:11:44 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <88f9b4e9-9074-a507-426d-7c947f1e2b13@redhat.com>
Date:   Mon, 6 Dec 2021 18:11:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Cc:     brouer@redhat.com, lorenzo.bianconi@redhat.com,
        davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, shayagr@amazon.com, john.fastabend@gmail.com,
        dsahern@kernel.org, echaudro@redhat.com, jasowang@redhat.com,
        alexander.duyck@gmail.com, saeed@kernel.org,
        maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
        tirthendu.sarkar@intel.com, toke@redhat.com
Subject: Re: [PATCH v19 bpf-next 23/23] xdp: disable XDP_REDIRECT for xdp
 multi-buff
Content-Language: en-US
To:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
References: <cover.1638272238.git.lorenzo@kernel.org>
 <df855fe05b80746fa7f657fce78b24d582f133cb.1638272239.git.lorenzo@kernel.org>
In-Reply-To: <df855fe05b80746fa7f657fce78b24d582f133cb.1638272239.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 30/11/2021 12.53, Lorenzo Bianconi wrote:
> XDP_REDIRECT is not fully supported yet for xdp multi-buff since not
> all XDP capable drivers can map non-linear xdp_frame in ndo_xdp_xmit
> so disable it for the moment.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>   net/core/filter.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index b70725313442..a87d835d1122 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4189,6 +4189,13 @@ int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
>   	struct bpf_map *map;
>   	int err;
>   
> +	/* XDP_REDIRECT is not fully supported yet for xdp multi-buff since
> +	 * not all XDP capable drivers can map non-linear xdp_frame in
> +	 * ndo_xdp_xmit.
> +	 */
> +	if (unlikely(xdp_buff_is_mb(xdp)))
> +		return -EOPNOTSUPP;
> +

This approach also exclude 'cpumap' use-case, which you AFAIK have added 
MB support for in this patchset.

Generally this check is hopefully something we can remove again, once 
drivers add MB ndo_xdp_xmit support.


>   	ri->map_id = 0; /* Valid map id idr range: [1,INT_MAX[ */
>   	ri->map_type = BPF_MAP_TYPE_UNSPEC;
>   
> 

