Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AB4471237
	for <lists+bpf@lfdr.de>; Sat, 11 Dec 2021 07:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhLKGuE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Dec 2021 01:50:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43191 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229619AbhLKGuD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 11 Dec 2021 01:50:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639205402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5GGR6Yk8NIseTbnIhyrb7g88g2mKiujPf5SqxqWYHYM=;
        b=ieDwajB8DU8tdwtF0k1lwxI7MwzwZdYa8qa0AFJntqqn6uidO4QpxVpIYJIs37rAmGkHTz
        nMvWdFT89RT+yfEUmMd9qDSoyQkDjjb3yQ4usOCNzG1bETlsn6tg4HgXz58UlzTNQKcquP
        SivgPBU/8CDOQD2rC1a7QSUfmz9dCo4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-183-UN-26QSTNIKep0qJmeEf-A-1; Sat, 11 Dec 2021 01:50:01 -0500
X-MC-Unique: UN-26QSTNIKep0qJmeEf-A-1
Received: by mail-lf1-f71.google.com with SMTP id e23-20020a196917000000b0041bcbb80798so5127258lfc.3
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 22:50:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent:cc
         :subject:content-language:to:references:in-reply-to
         :content-transfer-encoding;
        bh=5GGR6Yk8NIseTbnIhyrb7g88g2mKiujPf5SqxqWYHYM=;
        b=WAryrgta3+IWIqqx3pUxoBchKJxOgPU6NBw8KPjY4PZfa7MQr1gAEqK+mg/XWNKgrd
         Mv6QyX0Szj+HyCG1NbnF0D5UzSm10ccEkG/b+lTx5guEMrd/tvInxYgcv8rBD2CLRuVl
         NaysMQiHnLuvZm0EGtVK2CjB+vw1LqfkOhJ2PbvYYEuQH8upbe3K8Gu51zqrlwq5BN+K
         g+asJl1obcEs6mZLjlq4LkpKOfKWxFsZJLzhR0u31+gxKyphZkZ3GewgKaI+wpKxM0e7
         Ex56Xo/MJxlPcuYbRJctbwHT5lM85dO7RXNF5Y5vuls2B6p2N2eF8gs82QBOY0tfG/26
         2ZPA==
X-Gm-Message-State: AOAM530EYw4C7FtSrbogmx3C7JgoSyAnb/QTpDnng4gGmnXoCdBaH9OM
        H0nGcTTwLzYgPtXpG72uv/ZEg96Rc4OGfbdLbJvvICnP+oZu+pvOuOT1acubIHDaagw1txRMPn1
        pn4tx9JsBrIzW
X-Received: by 2002:a2e:530d:: with SMTP id h13mr17088876ljb.95.1639205399783;
        Fri, 10 Dec 2021 22:49:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyabu8u398AkOeDvIjdTAMwe4DjCUEMSQhyd/hCvyqhhF33q3z0ei+lXyLKzAfL6cAYrDLWRw==
X-Received: by 2002:a2e:530d:: with SMTP id h13mr17088859ljb.95.1639205399593;
        Fri, 10 Dec 2021 22:49:59 -0800 (PST)
Received: from [192.168.0.50] (87-59-106-155-cable.dk.customer.tdc.net. [87.59.106.155])
        by smtp.gmail.com with ESMTPSA id u7sm527290lfo.251.2021.12.10.22.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 22:49:58 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <35b5bf44-3901-1d75-99d0-43c98def22b9@redhat.com>
Date:   Sat, 11 Dec 2021 07:49:56 +0100
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
Subject: Re: [PATCH v20 bpf-next 23/23] xdp: disable XDP_REDIRECT for xdp
 multi-buff
Content-Language: en-US
To:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
References: <cover.1639162845.git.lorenzo@kernel.org>
 <a6b33109dea5e82d975ea1ee229f7714d0ffdf77.1639162846.git.lorenzo@kernel.org>
In-Reply-To: <a6b33109dea5e82d975ea1ee229f7714d0ffdf77.1639162846.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/12/2021 20.14, Lorenzo Bianconi wrote:
> XDP_REDIRECT is not fully supported yet for xdp multi-buff since not
> all XDP capable drivers can map non-linear xdp_frame in ndo_xdp_xmit
> so disable it for the moment.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---

LGTM you addressed my last review comments.

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

I do expect followup patches that add support for ndo_xdp_xmit in drivers...


>   net/core/filter.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 14860931733d..def6e9f451a7 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4186,6 +4186,13 @@ int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
>   	struct bpf_map *map;
>   	int err;
>   
> +	/* XDP_REDIRECT is not fully supported yet for xdp multi-buff since
> +	 * not all XDP capable drivers can map non-linear xdp_frame in
> +	 * ndo_xdp_xmit.
> +	 */
> +	if (unlikely(xdp_buff_is_mb(xdp) && map_type != BPF_MAP_TYPE_CPUMAP))
> +		return -EOPNOTSUPP;
> +
>   	ri->map_id = 0; /* Valid map id idr range: [1,INT_MAX[ */
>   	ri->map_type = BPF_MAP_TYPE_UNSPEC;
>   
> 

