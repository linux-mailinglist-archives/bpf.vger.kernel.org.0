Return-Path: <bpf+bounces-16240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FA37FEB61
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 10:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10261B2108A
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 09:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F4B358B2;
	Thu, 30 Nov 2023 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="K0r+XOF3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83181A3
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 01:06:30 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-332f90a375eso461975f8f.3
        for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 01:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1701335189; x=1701939989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eJ5LmNpN5QcwNvER/5g/ZnTRjIBCAtvU7kmUUks1hNI=;
        b=K0r+XOF3C1iQrXytK+rIxZgSSQ4W3ZrViMomJ53pkTXvfed3TxRzJnkSfx2jQqDvbf
         Q/adUp9UM8LyR07bO56ApOj0+oeH0PlHHQd09Pd+a6h+eBhiVO0Gpbfj9g/FQpurGSuK
         WA6kidV2RCAUeQ/d0NRPf6XbVA5p0bQehtcXy2CYNaJbTlo2DxpfIS4pcc+9/C0iZZWQ
         4ns/84AB9yOGtlsjkgrEhFFg9kw3DEx6dO9b3IniK3gjeT0TI8V5CRb0H9f1sfzbauh+
         yep7L5cZ4S+brErHelCDZx/92yTt0OLcm+91FFnCb1b0RnP+xczjF+CnHR6yE6BMBWLv
         DQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701335189; x=1701939989;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJ5LmNpN5QcwNvER/5g/ZnTRjIBCAtvU7kmUUks1hNI=;
        b=W5jojB6Zabnw9l0eEps6mF0XNOkV2Dkx/lG/Fcvr27qgDl5veXdv9pw5PZc9SkOaW2
         HUroi7fLawjpxV526dKjtLm2cmKWBkI4h7bUflkX9ckB0n27Veg1h/FEzVJ9zuL5AqYj
         lkBvaQJm1YVjL+Fq1aHE4uQsgKuQpdEvYAUNqf04kzsrve7tC1jQXcDRrZaylqkiADJp
         Qb3wUp6MXlmnJJjFy1Jql0Z09x50FWiOoANzHQPJl4KxYa27I6kZaJDRRSjNbq82czt9
         Eas3UTFgiZ3nYR6CxlZK9CFfA6qub2wDhe6qBexk7V7flp2SsNkHA0G7OrhD9bxCAFb9
         muoA==
X-Gm-Message-State: AOJu0YwpbO/6eixAAmNIwuJIPdla/++TlqfSCqmHjInJT9VBAcODr5a5
	ZD8moQCrZwJv2UCYmgQD+zXJ2KqgUIkWGISygBY=
X-Google-Smtp-Source: AGHT+IG3qiBMyklUjHLUA0JpQRxzV/uVj6ZdX1vKxXoWyydiAQzpr8xbbllWv+CAuQ+aC0bky0EhcA==
X-Received: by 2002:adf:f1c6:0:b0:333:75c:362f with SMTP id z6-20020adff1c6000000b00333075c362fmr7589388wro.45.1701335189038;
        Thu, 30 Nov 2023 01:06:29 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id e9-20020adffc49000000b00332cfd83b8dsm929523wrs.96.2023.11.30.01.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 01:06:28 -0800 (PST)
Message-ID: <51dd35c9-ff5b-5b11-04d1-9a5ae9466780@blackwall.org>
Date: Thu, 30 Nov 2023 11:06:27 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next] netkit: Add some ethtool ops to provide
 information to user
Content-Language: en-US
To: Feng zhou <zhoufeng.zf@bytedance.com>, daniel@iogearbox.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com, tangchen.1@bytedance.com
References: <20231130075844.52932-1-zhoufeng.zf@bytedance.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231130075844.52932-1-zhoufeng.zf@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/30/23 09:58, Feng zhou wrote:
> From: Feng Zhou <zhoufeng.zf@bytedance.com>
> 
> Add get_strings, get_sset_count, get_ethtool_stats to get peer
> ifindex.
> ethtool -S nk1
> NIC statistics:
>       peer_ifindex: 36
> 
> Add get_link, get_link_ksettings to get link stat.
> ethtool nk1
> Settings for nk1:
> 	...
> 	Link detected: yes
> 
> Add get_ts_info.
> ethtool -T nk1
> Time stamping parameters for nk1:
> ...
> 
> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
> ---
>   drivers/net/netkit.c | 53 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 53 insertions(+)
> 

Hi,
I don't see any point in sending peer_ifindex through ethtool, even
worse through ethtool stats. That is definitely the wrong place for it.
You can already retrieve that through netlink. About the speed/duplex
this one makes more sense, but this is the wrong way to do it.
See how we did it for virtio_net (you are free to set speed/duplex
to anything to please bonding for example). Although I doubt anyone will 
use netkit with bonding, so even that is questionable. :)

Nacked-by: Nikolay Aleksandrov <razor@blackwall.org>

Cheers,
  Nik


