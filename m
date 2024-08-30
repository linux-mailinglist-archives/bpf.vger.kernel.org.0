Return-Path: <bpf+bounces-38529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE439658B3
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 09:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4AC01C21475
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 07:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803701586E7;
	Fri, 30 Aug 2024 07:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pIVKLswp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406F91531FE
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 07:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003399; cv=none; b=FrVZ0LOdHNWtxp2UjzAwctU5RBaHFORYL8Z+ZpLDXj0sCXWYHppSPSHot+azWGi1PY8FYMrhKuPTxUqc7yLY73gUYGd5QBj/vadL7mU2/AoxNJDsg8ah0u5r9gOX1cLnijoYgh9GkS/aD1jEVWMLRhA5WLaZ3UwvDDPX5yzWJPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003399; c=relaxed/simple;
	bh=x8/BarACP66DHb2OmZ3Q/oMwacV43SJiRhJBLFSb+/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i07dX3K/VsJHQWJrnZlNwdbYO0niwzTV3auxHp1naMPF6pQdDd6aANRezeR6Uko7Zlq8aw9++wIgtTrJl5DwKlrfnuduq1NBEdUEjq+j5B9SlxjHYvyz6WF9huxPShlNVvg6lqr+d3/flCxNnba6mMSQcbHaNwV3Wn9yxB14D6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pIVKLswp; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53438aa64a4so1749142e87.3
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 00:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725003394; x=1725608194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aq3ZbOruMFHcebgoxqzGvdWYBubRMesb2UNv/9i5+1w=;
        b=pIVKLswpJeA04xBBN68YH5i66RmcqTmqEmw1ezfLPHrAaG7xFN3KzpVGMOsPWfaf5p
         UC459T7/GcJXu55OXscCDLhTHQefxAsuDkMTUdRtnax4w8vPvOMDEAlaCQcAns5Y4zC9
         Laot2ozrMzb/lkei5U53Xipz0Bx2RcZP/JGht4TzOKfVGn/rTkX1pVA0EACg16KCnYQD
         Burp75T1tIkT9Wt818gfw4wQm3rbffrqWcIm39IjDwAdh7DdPB5aoHjyHapFNZeWepRa
         W0bK6REbeBOi1PoYYw8FHeDleAwM/dBATYFnWslgep+2dO9/0tB/sPtYNDlAz6sWHfkQ
         8VOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725003394; x=1725608194;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aq3ZbOruMFHcebgoxqzGvdWYBubRMesb2UNv/9i5+1w=;
        b=QQstAZ/O6mKnLO5RcHtvrmG8HetE+gkAwz7XZrIn/26aXa6qt+zyt1VrHnmfA39NEQ
         oRzM62aZL+uY+dmqCdiuI3FZDCZ3eveJQQWm4MMCrFm6+RV4JEwoa7cWRzx1kH6xdkz0
         YiEdEcE3stvGRWVQ0rssusgxENb9ECRmxvKrycvzCzt81omZoyYQ8pUqrLUznCKNvC5Z
         /GfIDBU+OLn78WQeuAloPH15RMgVvuHRI8RUVNd+8G+40ZcDvjqdNIbuVKxCrfkuwU6h
         zXwxXfWU1pjz0qDD/SP1CtL18bJmfyyLx8CwK5ZXVVB5uN21jpNrf231cca6Lfa0mnzr
         2rPw==
X-Forwarded-Encrypted: i=1; AJvYcCUelX1Wt+tyz0pA9xIIhzOJRM0VW4dRFr5NQ2gYNIQOo19LcXVFIdvb43kdXdAb17x9wXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydg+floI5tFVOnVgELgVA54yK6x6nyk9F51wXSWIxKIqdZHhAq
	2LDu8WuEju//zBVhwBlRqSC8cZoiVjhK8wLrpHMzQvZYFrsPO2nQpJgTBawymn0=
X-Google-Smtp-Source: AGHT+IHfZUNiJUPiW9T4fMW2U3bxiTqLrbAacKaLA5/BgyjZPfqSwAZgANQ1GW4OoLjjFNcSXi9d5g==
X-Received: by 2002:a05:6512:3b92:b0:533:4620:ebfb with SMTP id 2adb3069b0e04-53546b042camr714413e87.21.1725003393937;
        Fri, 30 Aug 2024 00:36:33 -0700 (PDT)
Received: from [192.168.1.94] (56.31.102.84.rev.sfr.net. [84.102.31.56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898922710csm181746966b.223.2024.08.30.00.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 00:36:33 -0700 (PDT)
Message-ID: <e86dade9-a151-42e4-94e2-7710bcd3a6a6@baylibre.com>
Date: Fri, 30 Aug 2024 09:36:30 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/3] net: ethernet: ti: am65-cpsw: Fix XDP
 implementation
To: Roger Quadros <rogerq@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Jacob Keller <jacob.e.keller@intel.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
 Md Danish Anwar <danishanwar@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Govindarajan Sriramakrishnan <srk@ti.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20240829-am65-cpsw-xdp-v1-0-ff3c81054a5e@kernel.org>
Content-Language: en-US
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <20240829-am65-cpsw-xdp-v1-0-ff3c81054a5e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/29/24 14:03, Roger Quadros wrote:
> The XDP implementation on am65-cpsw driver is broken in many ways
> and this series fixes it.
>
> Below are the current issues that are being fixed:
>
> 1)  The following XDP_DROP test from [1] stalls the interface after
>      250 packets.
>      ~# xdb-bench drop -m native eth0
>      This is because new RX requests are never queued. Fix that.
>
> 2)  The below XDP_TX test from [1] fails with a warning
>      [  499.947381] XDP_WARN: xdp_update_frame_from_buff(line:277): Driver BUG: missing reserved tailroom
>      ~# xdb-bench tx -m native eth0
>      Fix that by using PAGE_SIZE during xdp_init_buf().
>
> 3)  In XDP_REDIRECT case only 1 packet was processed in rx_poll.
>      Fix it to process up to budget packets.
>      ~# ./xdp-bench redirect -m native eth0 eth0
>
> 4)  If number of TX queues are set to 1 we get a NULL pointer
>      dereference during XDP_TX.
>      ~# ethtool -L eth0 tx 1
>      ~# ./xdp-trafficgen udp -A <ipv6-src> -a <ipv6-dst> eth0 -t 2
>      Transmitting on eth0 (ifindex 2)
>      [  241.135257] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030
>
> 5)  Net statistics is broken for XDP_TX and XDP_REDIRECT
>
> [1] xdp-tools suite https://github.com/xdp-project/xdp-tools
>
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
> Roger Quadros (3):
>        net: ethernet: ti: am65-cpsw: fix XDP_DROP, XDP_TX and XDP_REDIRECT
>        net: ethernet: ti: am65-cpsw: Fix NULL dereference on XDP_TX
>        net: ethernet: ti: am65-cpsw: Fix RX statistics for XDP_TX and XDP_REDIRECT
>
>   drivers/net/ethernet/ti/am65-cpsw-nuss.c | 82 +++++++++++++++++++-------------
>   1 file changed, 49 insertions(+), 33 deletions(-)
> ---
> base-commit: 5be63fc19fcaa4c236b307420483578a56986a37
> change-id: 20240829-am65-cpsw-xdp-d5876b25335c
>
> Best regards,

Thank you for the fixes Roger.

Acked-by: Julien Panis <jpanis@baylibre.com>


