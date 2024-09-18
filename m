Return-Path: <bpf+bounces-40059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8D697BA59
	for <lists+bpf@lfdr.de>; Wed, 18 Sep 2024 11:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2251F1F23D1B
	for <lists+bpf@lfdr.de>; Wed, 18 Sep 2024 09:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE7317C7A5;
	Wed, 18 Sep 2024 09:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="js5NuPoK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176646FCC
	for <bpf@vger.kernel.org>; Wed, 18 Sep 2024 09:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726653073; cv=none; b=rnIe9YBIHQLikGHBIEm6Ywoaj2wsrP+Kn1SRPMfP8iBsI3fscRLtfUotkLqeHasF32/U+RGWnWSCF2a6YSpF03SivPasacUsfuMv9euFGsEFcCKUFav3uZGktvdXSnd+W20n3FKe0tJgcLx2I1ij9VZgHDE7dFHYRuzpMCvMIXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726653073; c=relaxed/simple;
	bh=YYveKDNyLV/O+GuIZezG/H+dg/pEIjQTXZMwxfSjq/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gUMSyqXByUXH99DRRTv5u76MdZzZwpHqNCbismS9Ul2VmJcXPUL3Rak0etltc7Vjit5AHamdxjtjuLMBnxhvlEorP6QM5QS1gGL5gtC4SJx4Y2KWobHf6qvfqiof5JYb65/coaCypwxiDtvLmsS3F+8ljSXGvz51K2ZMUQ1YOPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=js5NuPoK; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso102667066b.0
        for <bpf@vger.kernel.org>; Wed, 18 Sep 2024 02:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1726653068; x=1727257868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U5Lz1QWVFmZd2N1NR4+boEn5JCoZBGXe5wWgia0cON4=;
        b=js5NuPoKWQ3/7Er/hcnJ06/MjTq1CnwJN0fwvs/Wtell0wWMwxV5iaJDLb3gcroNKj
         ZJ7sp9EWEhWHfZG9wAuDNeOMUn5UninPRsjKJzL4u8RGacMfsV0dRLQaGeIvlRJfLiSl
         OrZopnQPbGCK5MtP+YcAAqPP50RmOUOXwCCLfsT1cMmm0OFMg/l9aB3oJpXyamXHeJPw
         JqvVcQ9q6kZ/hqM1DGrXahR2ZeE90O+Cfz8QlGRMpSiNe5A6eNmdIIc4fgtO38m4a2bl
         Xx+oP0oB9B416DZnj3VY0uOGodn2k9t+XH1+CvuAqrYSQrL23cS0Rg5maAxbbbmwbIia
         LmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726653068; x=1727257868;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U5Lz1QWVFmZd2N1NR4+boEn5JCoZBGXe5wWgia0cON4=;
        b=OlS9hgOqG931ORCcsDk8/deNsRZ5yW/dvrMVg3dtSktMJK4BzbVKkJpDzh5QNkzB2w
         ++qnZK0o2eVq/hVcAFYIccbS7hL0m8V0X+b0s+dh+6aqqK6mibtFj26kRW183B3uy3hH
         zMmDm6KJbCkyFcqrZS802g8ebjtlmRmESx0mM7cXjGl9XYGSHh51RUadmZPlq19MGWge
         WG/188Rx7ZPkzHCKAmg5ZLmk/nHSk64QUp9cdJOrbqLMr6pgQgWl115QaFE3OFulU4Sd
         USbt5bCEsJpGQEda4Fsq0wrg+zLIxTftSgxD0AFBsP1ofCLUIAYe1mCDup3QXts75Dqq
         w6Rg==
X-Forwarded-Encrypted: i=1; AJvYcCU+RE6TBBj9YTnFQ75EKpLqHcY0NR2gQJvK/BzT/E24MHSS1RkueFEsHC2xsq9WMP2LX7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJAZAPWDVT4o7XzYy0OXbrbMNT3qFcLzJXHZpYGEwRJmqWYAbG
	iuKwEt0djXnW3fFuPCLUUIkdTMYMLS8faGWaXHjiCAAQRkl9sgubzDqfDSF4mcXrF8zwsptpcrS
	DMNs=
X-Google-Smtp-Source: AGHT+IGh+5daTFsNyDKlbll7KebWFSlnclyKmAwqiRqpM+wguKxxuLaiVoIA7Zfzj5R3BOYGBvdN6A==
X-Received: by 2002:a17:907:3f91:b0:a8d:5f69:c839 with SMTP id a640c23a62f3a-a8ffabbcc0cmr2879337466b.15.1726653068106;
        Wed, 18 Sep 2024 02:51:08 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612df75csm568606066b.149.2024.09.18.02.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 02:51:07 -0700 (PDT)
Message-ID: <ebef9a36-d060-4df3-b139-3dda4a84484a@blackwall.org>
Date: Wed, 18 Sep 2024 12:51:06 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] bonding: Add net_ratelimit for
 bond_xdp_get_xmit_slave in bond_main.c
To: Jiwon Kim <jiwonaid0@gmail.com>, jv@jvosburgh.net, andy@greyhouse.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, joamaki@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, syzbot+c187823a52ed505b2257@syzkaller.appspotmail.com
References: <20240918083545.9591-1-jiwonaid0@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240918083545.9591-1-jiwonaid0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/09/2024 11:35, Jiwon Kim wrote:
> Add net_ratelimit to reduce warnings and logs.
> This addresses the WARNING in bond_xdp_get_xmit_slave reported by syzbot.
> 

This commit message is severely lacking. I did the heavy lifting and gave you
detailed analysis of the problem, please describe the actual issue and why
this is ok to do. Also the subject is confusing, it should give a concise
summary of what the patch is trying to do and please don't include filenames in it.
You can take a look at other commits for examples.

> Setup:
>     # Need xdp_tx_prog with return XDP_TX;
>     ip l add veth0 type veth peer veth1
>     ip l add veth3 type veth peer veth4
>     ip l add bond0 type bond mode 6 # <- BOND_MODE_ALB, unsupported by xdp
>     ip l add bond1 type bond # <- BOND_MODE_ROUNDROBIN by default
>     ip l set veth0 master bond1
>     ip l set bond1 up
>     ip l set dev bond1 xdpdrv object tx_xdp.o section xdp_tx
>     ip l set veth3 master bond0
>     ip l set bond0 up
>     ip l set veth4 up
>     ip l set veth3 xdpgeneric object tx_xdp.o section xdp_tx

Care to explain why this setup would trigger anything?

> 
> Reported-by: syzbot+c187823a52ed505b2257@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c187823a52ed505b2257
> Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
> Signed-off-by: Jiwon Kim <jiwonaid0@gmail.com>
> ---
> v2: Change the patch to fix bond_xdp_get_xmit_slave
> ---
>  drivers/net/bonding/bond_main.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index b560644ee1b1..91b9cbdcf274 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -5610,9 +5610,12 @@ bond_xdp_get_xmit_slave(struct net_device *bond_dev, struct xdp_buff *xdp)
>  		break;
>  
>  	default:
> -		/* Should never happen. Mode guarded by bond_xdp_check() */
> -		netdev_err(bond_dev, "Unknown bonding mode %d for xdp xmit\n", BOND_MODE(bond));
> -		WARN_ON_ONCE(1);
> +		/* This might occur when a bond device increases bpf_master_redirect_enabled_key,
> +		 * and another bond device with XDP_TX and bond slave.
> +		 */

The comment is confusing and needs to be reworded or dropped altogether.

> +		if (net_ratelimit())
> +			netdev_err(bond_dev, "Unknown bonding mode %d for xdp xmit\n",
> +				   BOND_MODE(bond));
>  		return NULL;
>  	}
>  


