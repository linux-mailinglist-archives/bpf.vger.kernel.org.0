Return-Path: <bpf+bounces-69213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B33B4B9110F
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 14:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C4FB423FE2
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 12:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468B2306B06;
	Mon, 22 Sep 2025 12:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="WRFNRSbW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CF6305E14
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 12:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758542849; cv=none; b=j2A0viboeiSJYubkbIMkVZsaI6QR8VRE0gA6VbMNRDASMq2ogDow8+5ve6+7/DaWi3eV4Ez2SV1KO0k0PUcrnBN8nFg58HRTaOzrB+7KBnANkVB44d0rp9TOfn7utn0o7DVgG3R/xvuEK0p97xQD3REygQ3WotIc4sPshGwr/ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758542849; c=relaxed/simple;
	bh=DVcPbszETqDHHK8qlzPBuEKPE7LbZrIWqmngLLuVmgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lkqb8e3fGqdjZv1xWg42WDjaFMXzn6snpqPwIr5lA7T6vmXsJYreFRb871I5Qnvoi0GaJbvZypbj2yXv5eqCR0IseJEWbLlEmEaobsI+EFMGE+obmvlx6aTDQEZ6tDJCLcKmPPbsOASZJk99iSUWCZUBny9t4ik4v5dcOOmtB9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=WRFNRSbW; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57cfe6656dcso1319526e87.1
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 05:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1758542846; x=1759147646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8jM2pnJ1B8JxuL/d0YmLtjvLcDHew5XSTZjid5H7F9Q=;
        b=WRFNRSbWuYmbC8bojHAF8Zaqqgt5L5w0yX42qFF/d529b+juL25t/jQun99zglGsZW
         y1kUAueRbrEWcWsj6tuYgYA0aEJSDHyB36bhSINCu7K65Lrt4l3rb1L1hNc4az+HYt2O
         ZvW8MoW1f5toGOxzAqHT9x4ip5Zg6FBNAVWXzFPWkdZ1hhZ8uYDRaLyykoq7jeVTJ5/4
         tjscWS0PBp0fya9RU3W1hwFG8ld3hSR4+HJ0h9zZ4S9ob5xLKHFopxmzl8al+7bzNQSu
         r99rfoWnjO46VFC+5+bZ76c8YDevqWp1rlmFp+I7hdr8MiHJHIRqdAR1+sHv0MzXFZrM
         02CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758542846; x=1759147646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8jM2pnJ1B8JxuL/d0YmLtjvLcDHew5XSTZjid5H7F9Q=;
        b=b0uxuMiX4A9z4937v5vLZehpyK/A+/rgJx21ApkacjfF0qsXql6x960Vm7F8Fyp0CS
         U6LOg/2lU2dFXBv1S7WZj+AGk1o/ONBAzK+a3z/d+qe9s6o51o8K3CSnbvgRs3wC1syj
         pL0cVTfvEWHTBcDzF4JL5QsUXeXt4F2rKASrm8z9/+qvGgf6n2uUnOcvKaK6gy+1Em0z
         G0K4eqIGVIPQsjolSccAqyY8yiLoqxJdbILecS20v7CDnFTsLe2QWdvjzfQdu4/i6FOh
         HGJaUIqqepfNhLOWY2Jd2iH4SVejBXwd+Ugv+S66mMePVqx1edeIYRONAOmdMek+SqmL
         Zm3w==
X-Gm-Message-State: AOJu0Yyspyjy8ux5M2M+uSRc804P8Oz5urkDQXBhCdoG92qwGb9u0PyK
	mnet0Rqj36LBhzOo+ZaDGxeItdu8HoghjYu7J1oQgRdVrd58QBvFdUc6wsKt9IOt58A=
X-Gm-Gg: ASbGncsEuks1TqoEAEDN068JWRsrKNEJj/VBaic0D8mAs3YoKEamcvRyMlrBQYLLplV
	tUqxT8zI+UY7pwX+NknjCnI9AnJdPqY1/lXaOdSDBu71pfsijnmWZGguy/zFYDWiEEBU0+iujN2
	f1gW50nhSxhPUNtQu6k+Wt3+P6am7nBey/Iz/TghmmyAoH7DcqqMlCAj7Rsnr+MnTwLmqdMM86b
	ljjOblRdshu5nfPrZD1JLPG4l21+RYyNIKB6FOpLeH6RPcr4DOMaemdy/Rcn+ZboC8DWkn8/8pR
	nYFvUf1+u6k9YZVn9XbUiVZkJ5hZH3aP70dU7h/j2/vyv592LM/i66hAu6ysWAnlFDhyoumIBZK
	kzWZkjkQg4Pq637hXQZMvj7HTM4Ctn0lqPs+U/qkRSnMLDnmGwJrgSIhjcqBCKdq1VgH7BnleTm
	Jy1g==
X-Google-Smtp-Source: AGHT+IGD/jn0d6LdkWrAOucGmU5CI1mFNI4XovrTeMWdsjpZHgr8vX7aDRSEomQXgS6HuxCZugjO1Q==
X-Received: by 2002:a05:6512:350d:b0:57d:a4e9:5b00 with SMTP id 2adb3069b0e04-57da4e95c80mr1678442e87.30.1758542846178;
        Mon, 22 Sep 2025 05:07:26 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a9668043sm3191553e87.110.2025.09.22.05.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 05:07:25 -0700 (PDT)
Message-ID: <51de8bdf-e8e9-418b-8d6e-c559b8e831df@blackwall.org>
Date: Mon, 22 Sep 2025 15:05:25 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/20] netkit: Support for io_uring zero-copy and
 AF_XDP
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com
References: <20250919213153.103606-1-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250919213153.103606-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/20/25 00:31, Daniel Borkmann wrote:
> Containers use virtual netdevs to route traffic from a physical netdev
> in the host namespace. They do not have access to the physical netdev
> in the host and thus can't use memory providers or AF_XDP that require
> reconfiguring/restarting queues in the physical netdev.
> 
> This patchset adds the concept of queue peering to virtual netdevs that
> allow containers to use memory providers and AF_XDP at _native speed_!
> These mapped queues are bound to a real queue in a physical netdev and
> act as a proxy.
> 
> Memory providers and AF_XDP operations takes an ifindex and queue id,
> so containers would pass in an ifindex for a virtual netdev and a queue
> id of a mapped queue, which then gets proxied to the underlying real
> queue. Peered queues are created and bound to a real queue atomically
> through a generic ynl netdev operation.
> 
> We have implemented support for this concept in netkit and tested the
> latter against Nvidia ConnectX-6 (mlx5) as well as Broadcom BCM957504
> (bnxt_en) 100G NICs. For more details see the individual patches.
> 
> Daniel Borkmann (10):
>    net: Add ndo_{peer,unpeer}_queues callback
>    net, ethtool: Disallow mapped real rxqs to be resized
>    xsk: Move NETDEV_XDP_ACT_ZC into generic header
>    xsk: Move pool registration into single function
>    xsk: Add small helper xp_pool_bindable
>    xsk: Change xsk_rcv_check to check netdev/queue_id from pool
>    xsk: Proxy pool management for mapped queues
>    netkit: Add single device mode for netkit
>    netkit: Document fast vs slowpath members via macros
>    netkit: Add xsk support for af_xdp applications
> 
> David Wei (10):
>    net, ynl: Add bind-queue operation
>    net: Add peer to netdev_rx_queue
>    net: Add ndo_queue_create callback
>    net, ynl: Implement netdev_nl_bind_queue_doit
>    net, ynl: Add peer info to queue-get response
>    net: Proxy net_mp_{open,close}_rxq for mapped queues
>    netkit: Implement rtnl_link_ops->alloc
>    netkit: Implement ndo_queue_create
>    netkit: Add io_uring zero-copy support for TCP
>    tools, ynl: Add queue binding ynl sample application
> 
>   Documentation/netlink/specs/netdev.yaml |  54 ++++
>   drivers/net/netkit.c                    | 362 ++++++++++++++++++++----
>   include/linux/netdevice.h               |  15 +-
>   include/net/netdev_queues.h             |   1 +
>   include/net/netdev_rx_queue.h           |  55 ++++
>   include/net/xdp_sock_drv.h              |   8 +-
>   include/uapi/linux/if_link.h            |   6 +
>   include/uapi/linux/netdev.h             |  20 ++
>   net/core/netdev-genl-gen.c              |  14 +
>   net/core/netdev-genl-gen.h              |   1 +
>   net/core/netdev-genl.c                  | 144 +++++++++-
>   net/core/netdev_rx_queue.c              |  15 +-
>   net/ethtool/channels.c                  |  10 +-
>   net/xdp/xsk.c                           |  27 +-
>   net/xdp/xsk.h                           |   5 +-
>   net/xdp/xsk_buff_pool.c                 |  29 +-
>   tools/include/uapi/linux/netdev.h       |  20 ++
>   tools/net/ynl/samples/bind.c            |  56 ++++
>   18 files changed, 750 insertions(+), 92 deletions(-)
>   create mode 100644 tools/net/ynl/samples/bind.c
> 

I have reviewed the set and it looks good to me. To be fair, I have reviewed
it privately before as well. I really like the changes, we have discussed some
of the ideas implemented before. Personally I especially like the io_uring support
and think that some new interesting use cases will come out of it.

Nice work, for the set:
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

Cheers,
  Nik


