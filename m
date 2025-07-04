Return-Path: <bpf+bounces-62369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4421AF87C6
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 08:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 221311C87B52
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 06:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBD8221F34;
	Fri,  4 Jul 2025 06:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aBFWOY80"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D58423AD
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 06:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751609622; cv=none; b=jQD5XpcPDt/p9ZbvREROilrw7lAvYPFrhkTt18Q2xH8diWz9x8/U2CXy8bIdYSu6BRdoXsAOBJS9M9WcXKfKwRCKuedZtlITjdMkE20PBG7xcd1dqpEQPg/zmjz+5FPQtH0a7SM9M6UmylB2WUNyNEAW0VmVWxnrKn6VPfgcs9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751609622; c=relaxed/simple;
	bh=vibWWeiypNeSgfD8KaWdu7tU5hHsN9OdkFjF1S/hQ/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jIkj52ATUqdZpciSjTgDLij+iEIdSzAKdfTaqdFZ9YaGZPnI3Pv6LUHLEi5yLZsmcV70zXjonjnI3hNq+pdhHnpP7N+Ur4V9RuKVvI617zWiBe4aVX7uRAIOBNMoajED8MBIlw0xAt+/NgcARb+9xCOqeInnNOkVDewoJhEm59c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aBFWOY80; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751609619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LOIxiCHkeRqrvh4oeGnyLAveDHiJ5tHZOwjAWFxKiI4=;
	b=aBFWOY80SxIAmPNdGhwrgmItdo9dA5/71KEpK1QhAhlqE5GCPTGz+KgPAwGRMvGoX9TZUM
	WmCGfEiFD12k0d8N29tTNAltphnvL+ngNBR2XW3FChJIhBflZDv2kl3AAyUGkOa19MAtUP
	2GcHkZK73swCUjLdrlbkvWa/cMK7Qg8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-9Gmd7O6RN--nyKjtusaWaw-1; Fri, 04 Jul 2025 02:13:36 -0400
X-MC-Unique: 9Gmd7O6RN--nyKjtusaWaw-1
X-Mimecast-MFC-AGG-ID: 9Gmd7O6RN--nyKjtusaWaw_1751609615
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-450d290d542so3028045e9.1
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 23:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751609615; x=1752214415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LOIxiCHkeRqrvh4oeGnyLAveDHiJ5tHZOwjAWFxKiI4=;
        b=gtZEzsV4psr4QnvprcjkYbxUFUepaTRGBRBdGO9lpyZQgoNGanYN93K4cqRKBnCXnc
         PmW/mZ5pmXOufzG4dh2fn3StvfIf9Pt4BCqgT8DEQEvaNaAdcc+F1lZlrHtt2gbcXM2E
         30kn2m/dwcYZ/C8gC6WhFlH5F3MgnPxcf5ERDe2avAfhvAqRYBK2PSTG7ikOzkRAdZDt
         soeDZpPnpIIcPNcoBJUN30lgTqZ6LczLOxrSVbh/MXZJcJYalKiAE2LjtwSMasfsj00K
         K63NxTvU/3FsZOdOR0NsfHCJwVRDGGgOo0u0ynROdqyoKoXsb4M9Q2UQdnm1fvBc7qWS
         9WSg==
X-Gm-Message-State: AOJu0Yw6NEFBP5ynHMlDKM4JPppHKWV5wvAuO2tcrhLS3aMgNvSWqh88
	bmjCzHQon03mc+Tj9HmlyNljikIDLnH8OLsHsNwZ85IlVGlF5UN9V07cH/UP3Fxp7wcx12SaPqr
	OcXdypMnLYqHMI/TstfcIvyLicLCe/jycrGvzS6sDfIlVoXEPEADcoA==
X-Gm-Gg: ASbGncuqHBFKdQ3M0IkI0ge9n7/ZkGJG+sYbnfTwz8lcN4yD5Rn6gnemyolcjmQJ+gZ
	TeJV9Ie+z1uNT1Bijmbenwho3RS5lkhKrTnsaK3oQ8VaoP5PHhxIVnR+x7aZ3OTjNx2zbYjOYFB
	D5zX3uvZyO2+EJ6E5FOMMwMGRycMuRXmqNofuxowPCscpSZIQTWvuONRmYT1QzOAS5PqAYAjqL2
	lYHyhwok8LmBbs4JdT3OH7+9ROWUG68KUqYd2rOxjE0oFYZnFOpFzN1PW5dzsWnyZIXwqcu4Ize
	dHCQWg/VpecZcUzmeg+CmklI1Yj7/Yl82eWb1NEgbUPKV4QR7kCbP+BHi9U8gCmYaJw=
X-Received: by 2002:a5d:5f8d:0:b0:3a4:f70e:abda with SMTP id ffacd0b85a97d-3b4964eafb0mr892437f8f.10.1751609614723;
        Thu, 03 Jul 2025 23:13:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoMJhfrwNJgmBD505k7qthChatRHIpDmNEOIk6KYjzSERxt6mOko74Rj6CWQRsHpnW5r+IxQ==
X-Received: by 2002:a5d:5f8d:0:b0:3a4:f70e:abda with SMTP id ffacd0b85a97d-3b4964eafb0mr892399f8f.10.1751609614256;
        Thu, 03 Jul 2025 23:13:34 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314? ([2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b470caa1a2sm1560536f8f.42.2025.07.03.23.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 23:13:33 -0700 (PDT)
Message-ID: <2e1412dd-97c6-4fdb-ba7b-6529b032d6b9@redhat.com>
Date: Fri, 4 Jul 2025 08:13:31 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7] net: xsk: introduce XDP_MAX_TX_SKB_BUDGET
 setsockopt
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 joe@dama.to, willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20250703145045.58271-1-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250703145045.58271-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/3/25 4:50 PM, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> This patch provides a setsockopt method to let applications leverage to
> adjust how many descs to be handled at most in one send syscall. It
> mitigates the situation where the default value (32) that is too small
> leads to higher frequency of triggering send syscall.
> 
> Considering the prosperity/complexity the applications have, there is no
> absolutely ideal suggestion fitting all cases. So keep 32 as its default
> value like before.
> 
> The patch does the following things:
> - Add XDP_MAX_TX_SKB_BUDGET socket option.
> - Set max_tx_budget to 32 by default in the initialization phase as a
>   per-socket granular control.
> - Set the range of max_tx_budget as [32, xs->tx->nentries].
> 
> The idea behind this comes out of real workloads in production. We use a
> user-level stack with xsk support to accelerate sending packets and
> minimize triggering syscalls. When the packets are aggregated, it's not
> hard to hit the upper bound (namely, 32). The moment user-space stack
> fetches the -EAGAIN error number passed from sendto(), it will loop to try
> again until all the expected descs from tx ring are sent out to the driver.
> Enlarging the XDP_MAX_TX_SKB_BUDGET value contributes to less frequency of
> sendto() and higher throughput/PPS.
> 
> Here is what I did in production, along with some numbers as follows:
> For one application I saw lately, I suggested using 128 as max_tx_budget
> because I saw two limitations without changing any default configuration:
> 1) XDP_MAX_TX_SKB_BUDGET, 2) socket sndbuf which is 212992 decided by
> net.core.wmem_default. As to XDP_MAX_TX_SKB_BUDGET, the scenario behind
> this was I counted how many descs are transmitted to the driver at one
> time of sendto() based on [1] patch and then I calculated the
> possibility of hitting the upper bound. Finally I chose 128 as a
> suitable value because 1) it covers most of the cases, 2) a higher
> number would not bring evident results. After twisting the parameters,
> a stable improvement of around 4% for both PPS and throughput and less
> resources consumption were found to be observed by strace -c -p xxx:
> 1) %time was decreased by 7.8%
> 2) error counter was decreased from 18367 to 572
> 
> [1]: https://lore.kernel.org/all/20250619093641.70700-1-kerneljasonxing@gmail.com/
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> v7
> Link: https://lore.kernel.org/all/20250627110121.73228-1-kerneljasonxing@gmail.com/
> 1. use 'copy mode' in Doc
> 2. move init of max_tx_budget to a proper position
> 3. use the max value in the if condition in setsockopt
> 4. change sockopt name to XDP_MAX_TX_SKB_BUDGET
> 5. set MAX_PER_SOCKET_BUDGET to 32 instead of TX_BATCH_SIZE because they
>    have no correlation at all.
> 
> v6
> Link: https://lore.kernel.org/all/20250625123527.98209-1-kerneljasonxing@gmail.com/
> 1. use [32, xs->tx->nentries] range
> 2. Since setsockopt may generate a different value, add getsockopt to help
>    application know what value takes effect finally.
> 
> v5
> Link: https://lore.kernel.org/all/20250623021345.69211-1-kerneljasonxing@gmail.com/
> 1. remove changes around zc mode
> 
> v4
> Link: https://lore.kernel.org/all/20250619090440.65509-1-kerneljasonxing@gmail.com/
> 1. remove getsockopt as it seems no real use case.
> 2. adjust the position of max_tx_budget to make sure it stays with other
> read-most fields in one cacheline.
> 3. set one as the lower bound of max_tx_budget
> 4. add more descriptions/performance data in Doucmentation and commit message.
> 
> V3
> Link: https://lore.kernel.org/all/20250618065553.96822-1-kerneljasonxing@gmail.com/
> 1. use a per-socket control (suggested by Stanislav)
> 2. unify both definitions into one
> 3. support setsockopt and getsockopt
> 4. add more description in commit message
> 
> V2
> Link: https://lore.kernel.org/all/20250617002236.30557-1-kerneljasonxing@gmail.com/
> 1. use a per-netns sysctl knob
> 2. use sysctl_xsk_max_tx_budget to unify both definitions.
> ---
>  Documentation/networking/af_xdp.rst |  9 +++++++++
>  include/net/xdp_sock.h              |  1 +
>  include/uapi/linux/if_xdp.h         |  1 +
>  net/xdp/xsk.c                       | 21 +++++++++++++++++++--
>  tools/include/uapi/linux/if_xdp.h   |  1 +
>  5 files changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
> index dceeb0d763aa..95ff1836e5c6 100644
> --- a/Documentation/networking/af_xdp.rst
> +++ b/Documentation/networking/af_xdp.rst
> @@ -442,6 +442,15 @@ is created by a privileged process and passed to a non-privileged one.
>  Once the option is set, kernel will refuse attempts to bind that socket
>  to a different interface.  Updating the value requires CAP_NET_RAW.
>  
> +XDP_MAX_TX_SKB_BUDGET setsockopt
> +----------------------------

I'm sorry, kdoc is not happy about the above:

/home/doc-build/testing/Documentation/networking/af_xdp.rst:442:
WARNING: Title underline too short.XDP_MAX_TX_SKB_BUDGET setsockopt
----------------------------

/P


