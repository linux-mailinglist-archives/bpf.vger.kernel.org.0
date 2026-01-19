Return-Path: <bpf+bounces-79388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0967FD39C0A
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 02:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A080300C5CB
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 01:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D8C20C463;
	Mon, 19 Jan 2026 01:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D60PcPFI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08EE1FAC34
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 01:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768787069; cv=none; b=uvK4NB1D9yudKMAJM+bqsYNfpbm+i3Rst4uBvg/Lg5J+kaI07014oyq9/UqmlkYEX99GCoeT+sbvjHCd4mTnViDDg3MR0dQuUeLXbtr4PDnnbr1k6nlUHXO7qX0I4grTchSYzvYhPa/Ran/bIKI4jMIHHDilUcai47o4RggM8pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768787069; c=relaxed/simple;
	bh=VkcDqkYVamWxgzFand4/i5j9JzckX2bMhZN6R9QpqmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHsVCpZR5NbgoKF01lctx/Gj3c18u/lT/D4xsjS0Q4vRumCPGoWAO4umnms9O7aoH0CZOorpWFfKz8YhsYQ1PIRdj0FtAfbtRnfYBwohg81cfUt2HhzT4Fx2XHcI62142sSfiJAKwpiGWL3b3oNv2VtE3D6dsgxGJ++XRS8b4uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D60PcPFI; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-11f36012fb2so5320966c88.1
        for <bpf@vger.kernel.org>; Sun, 18 Jan 2026 17:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768787067; x=1769391867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7SUu7mR9w9aTv1c8MTdqdl262I4zy7RQjj2g442SDFA=;
        b=D60PcPFI3LSSdx1wWoA5PSzcJV61ANr077L+TjTpRF5j4wYXLFkLGNcmFp8Jq8BSYk
         ulWJWcCmkc3e/B1lMo7SKn6psBXGM8NENyiQMx4XpAOiIKv/UQ4aHFFxao9Efk7fw46B
         0N4/zPkLvWiNizcc7t6EnXnQXSy0SYXFMRfFlF6Jf805Dc4b232f8KKyTx/g+q/9YNeZ
         nA2afjRe0c3TiNAgeMSv+G3VkQ5C35GANzoKTfig/BY1wP0cerqsDs0e3OYocDiRHr3G
         qPBiKuBx0mnqpkS1ljr2e97Qp+feORvnuezj7qQNeQBdYCXmF4BswWigkowMq3fiJ8jw
         u5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768787067; x=1769391867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SUu7mR9w9aTv1c8MTdqdl262I4zy7RQjj2g442SDFA=;
        b=UduCvOHDxFFCT+pofzK1MmECH5491vs8JpFRD0p/2ZyWPBy2/h8Ws/FmiaV3jv4AWd
         c5umCbXmEDDsCmM66GG4l1iLXMCrXZ1AclgsVIh3hOpERxbSGsyZhe4awJ8ySWAiOrmw
         T44fiClL3KuibigT78UInxRd+M3tOKOqeErqRF+TEJHxCymnMf27fmwBaGMsEPFMFOnF
         RKpBPJkyI1TudY8Q8HK0OiZe0V8tpBZUVTv/9ICY2H5wuS48xwKJVaPCCR2HQvSxg3yK
         SY9C0cxBiCpcNM7N4K8yomojLE1YNWCH/+EsKDv01Q8ONYxc+4/FEAe3MPtXlEFvSlQC
         7NpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbU05+hAAgMwW2LoBT2A02WhcdGtWbnBMgDDdNS91MIPvqKt9W92BlxZC987EQcQYWk+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8kKjP7O4e9v10mlNWl6ZvEI0inB7HSvwUWUiNRL3IQbn6KShA
	HJuHbiD/6X4qm76HczRt6KXm7vd3X76hWm3cysNHAWp//9zA0TVCXjE=
X-Gm-Gg: AY/fxX40JCqOgtlT/nAya9mOu7XNKf9KC8Ymgm353/m7JeAEO96GrURPv2JhZ21nchQ
	Rcsph8OawqpESNu9sLQ4piWK0kSezGFA1QcfIkrh450y/fVZeF/lyGuesgjxnxY8+Bsk2Ia2yas
	BpuF4OJUyA5tP/XuTzuHxa38FgfwuloG+HRve9u4zsR3rchdfjOWRT/dBn4OLE98iHpMOemOA7E
	jigbv4rnwDD8mjnOs0hNz+B8rhN4iMuqAsKEaQUNPywj0l+W3kiMjD39Lefl0c1I42C8xDemqns
	1XkOK+US+U0XWdg3mUmA2IuhzzIN80zSnj5m0eky9PxuicbGOQY4NMBcPiLWcDvCgz496vL++4e
	9aA0wylqBAW9n6dFxX0v3198jLm9QPfr/S1zInraiYinDBiNIDR38dzqhPCX3havbB5RUGZiCD2
	/G31LBEulpjWv3g9k9acvlG1+cZUJxXkf7+KtMULDkR5InuL1PBGsIbP71pTvFzC4Vt6bcZ4dZF
	MoGOQ==
X-Received: by 2002:a05:7022:e05:b0:123:330b:3a0 with SMTP id a92af1059eb24-1244b31fdb4mr6587417c88.14.1768787066785;
        Sun, 18 Jan 2026 17:44:26 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244aefac48sm11757747c88.11.2026.01.18.17.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 17:44:26 -0800 (PST)
Date: Sun, 18 Jan 2026 17:44:25 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v7 03/16] net: Add lease info to queue-get
 response
Message-ID: <aW2Mec4NWre1axmO@mini-arch>
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-4-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260115082603.219152-4-daniel@iogearbox.net>

On 01/15, Daniel Borkmann wrote:
> Populate nested lease info to the queue-get response that returns the
> ifindex, queue id with type and optionally netns id if the device
> resides in a different netns.
> 
> Example with ynl client:
> 
>   # ip a
>   [...]
>   4: enp10s0f0np0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 xdp/id:24 qdisc mq state UP group default qlen 1000
>     link/ether e8:eb:d3:a3:43:f6 brd ff:ff:ff:ff:ff:ff
>     inet 10.0.0.2/24 scope global enp10s0f0np0
>        valid_lft forever preferred_lft forever
>     inet6 fe80::eaeb:d3ff:fea3:43f6/64 scope link proto kernel_ll
>        valid_lft forever preferred_lft forever
>   [...]
> 
>   # ethtool -i enp10s0f0np0
>   driver: mlx5_core
>   [...]
> 
>   # ./pyynl/cli.py \
>       --spec ~/netlink/specs/netdev.yaml \
>       --do queue-get \
>       --json '{"ifindex": 4, "id": 15, "type": "rx"}'
>   {'id': 15,
>    'ifindex': 4,
>    'lease': {'ifindex': 8, 'netns-id': 0, 'queue': {'id': 1, 'type': 'rx'}},
>    'napi-id': 8227,
>    'type': 'rx',
>    'xsk': {}}
> 
>   # ip netns list
>   foo (id: 0)
> 
>   # ip netns exec foo ip a
>   [...]
>   8: nk@NONE: <BROADCAST,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>       link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
>       inet6 fe80::200:ff:fe00:0/64 scope link proto kernel_ll
>          valid_lft forever preferred_lft forever
>   [...]
> 
>   # ip netns exec foo ethtool -i nk
>   driver: netkit
>   [...]
> 
>   # ip netns exec foo ls /sys/class/net/nk/queues/
>   rx-0  rx-1  tx-0
> 
>   # ip netns exec foo ./pyynl/cli.py \
>       --spec ~/netlink/specs/netdev.yaml \
>       --do queue-get \
>       --json '{"ifindex": 8, "id": 1, "type": "rx"}'
>   {'id': 1, 'ifindex': 8, 'type': 'rx'}
> 
> Note that the caller of netdev_nl_queue_fill_one() holds the netdevice
> lock. For the queue-get we do not lock both devices. When queues get
> {un,}leased, both devices are locked, thus if __netif_get_rx_queue_peer()
> returns true, the peer pointer points to a valid device. The netns-id
> is fetched via peernet2id_alloc() similarly as done in OVS.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

