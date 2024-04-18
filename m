Return-Path: <bpf+bounces-27140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B29C8A9C2D
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 16:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0EDDB26134
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 14:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95B4168AE8;
	Thu, 18 Apr 2024 14:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VltlHbXc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69325165FAC
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449006; cv=none; b=Z1u/21Kdgr6wn92yp/2jvdHwx6e1zPRr6UFpo2c4vXxZlVcNMwPWngP2DBmLq5JQaR3rAfOLg0tbL0qPf1Y/pHhz8auBBKK9dmpYz7Nx/9JZhZo7LUPN/xYBMnTgtYWUSrRP1ZdfooIfLPEaQmYVlBiUoE+xfXJNe+T+KOo9ZuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449006; c=relaxed/simple;
	bh=29NSP3ckhchgCk/BenPgTMkiEk28YJODiPFZQnpe0GQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MmCukTv+v26/zENAHEbn7R4QXR0n8RuFsn13UKVf6TWcRq5imju6R3k2Mwf0C0s9VwD40kFldb9MTeIPvjFjk5vxnDNbnS53Fsc9ZuXZZdhwFOt0phC/9BaW8H6g5De0HHCxpIuUE3yKgFMxQNOdtSrZbqlGb170a6bES0ehdlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VltlHbXc; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-518e2283bd3so1302044e87.1
        for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 07:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713449001; x=1714053801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=29NSP3ckhchgCk/BenPgTMkiEk28YJODiPFZQnpe0GQ=;
        b=VltlHbXcY/hXnGG2jz+w5zDZZ/tsvF06fpogDT2sVlKafCF0s0QMQ6AJpIRz7osL47
         p0+BXPM4xu0D6iHC+6CUnEx4qbRQTFszzCFQoHGG9cWF50ZHK8DPXkmn5TBbOaM+LMWM
         gCVw8TgQN20h8i7z+RPjpWmm0e/SprTcERH0LhR65IPIQiaqPCG1zQMcXmQ+j7C2g7wu
         eS0ZdMCy1y7OWt82gzWzxUTZcXGxrzCdN+tm2LaDNI8KgSBnyV9wwmo9orq/pSkQKAmp
         jhWYNSbkOedth9j/E5AwGkdUlcuHxyE6motV7suJlp91pi1FwqO4pbgKAJ2GhWRUAl/g
         Bo8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713449001; x=1714053801;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29NSP3ckhchgCk/BenPgTMkiEk28YJODiPFZQnpe0GQ=;
        b=SDi/Tm9J2lqQHW3ZInXX5vVqs28WNAG30KJz1NZ96O7HEluNAu8YJoDOKHzxIcRP8/
         y1pe4FR5cg76OPTqDR5n2fo+BWRTAK7h2kWaHK7kSbQY3uNe2nuRXwftMgIx8t9CnF3P
         G9mH3Rt3ua5Gy2pC6S9djP13TsUoUVkOPr8bjae0PmLBeE/nkYV02DwqS7o1wIQSLlVg
         p54a+JdxdJmnv3wOUSwYq8nPSyOkfLJlaBIdlT6W6n1gfpkkG0Xh6BswfvoiCJN+kmnG
         RRoBLyB+K4zogDW+2hbg0r9POMtEglfMUkDLdlW2FMspVEPkgnDb77FS3TRVXYtLj7bw
         B5GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfSgDIvlx8K+d1Cy5GiCGWB1wDyvQS00MbxOXFt7zHrhdg9HFf98Lr/YVcAVpxlGN0oeCFsO7y8eunRchLcwFUp3ar
X-Gm-Message-State: AOJu0Yy/OWCiDTWuvhBWeZAajxuawvVSmn8RmOKUPrY+BLSrmEvHcA5e
	BGKYDyowdnfqtnDuPner/jqeIcdZiYvoy4EXDKZwTnlrJkubqSFR4ydfcW1nz/1NvAJFZ8OHTf1
	S
X-Google-Smtp-Source: AGHT+IEEaAqAaRn0OgbuNYh5fB4s3wbKRYCkPSN2nyv1oCLgvcIRJoVOQEt5V3SOR++8k+CwHg+lTQ==
X-Received: by 2002:ac2:5b5b:0:b0:518:d5c4:d9b7 with SMTP id i27-20020ac25b5b000000b00518d5c4d9b7mr1966338lfp.16.1713449000512;
        Thu, 18 Apr 2024 07:03:20 -0700 (PDT)
Received: from [192.168.1.70] ([84.102.31.74])
        by smtp.gmail.com with ESMTPSA id w25-20020a17090633d900b00a51cdde5d9bsm931130eja.225.2024.04.18.07.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 07:03:19 -0700 (PDT)
Message-ID: <7f7fb71a-6d15-46f1-b63c-b569a2e230b7@baylibre.com>
Date: Thu, 18 Apr 2024 16:03:15 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 0/3] Add minimal XDP support to TI AM65 CPSW
 Ethernet driver
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Naveen Mamindlapalli <naveenm@marvell.com>,
 Jacob Keller <jacob.e.keller@intel.com>, danishanwar@ti.com,
 yuehaibing@huawei.com, rogerq@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
References: <20240223-am65-cpsw-xdp-basic-v9-0-2c194217e325@baylibre.com>
 <260d258f-87a1-4aac-8883-aab4746b32d8@ti.com>
 <08319f88-36a9-445a-9920-ad1fba666b6a@baylibre.com>
 <1da48c7e-ba87-4f7a-b6d1-d35961005ab0@ti.com>
Content-Language: en-US
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <1da48c7e-ba87-4f7a-b6d1-d35961005ab0@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/18/24 13:25, Siddharth Vadapalli wrote:
> On Thu, Apr 18, 2024 at 01:17:47PM +0200, Julien Panis wrote:
>> On 4/18/24 13:00, Siddharth Vadapalli wrote:
>>> On 12-04-2024 21:08, Julien Panis wrote:
>>>> This patch adds XDP support to TI AM65 CPSW Ethernet driver.
>>>>
>>>> The following features are implemented: NETDEV_XDP_ACT_BASIC,
>>>> NETDEV_XDP_ACT_REDIRECT, and NETDEV_XDP_ACT_NDO_XMIT.
>>>>
>>>> Zero-copy and non-linear XDP buffer supports are NOT implemented.
>>>>
>>>> Besides, the page pool memory model is used to get better performance.
>>>>
>>>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
>>> Hello Julien,
>>>
>>> This series crashes Linux on AM62ax SoC which also uses the
>>> AM65-CPSW-NUSS driver:
>>> https://gist.github.com/Siddharth-Vadapalli-at-TI/5ed0e436606001c247a7da664f75edee
>>>
>>> Regards,
>>> Siddharth.
>> Hello Siddharth.
>>
>> Thanks for the log. I can read:
>> [    1.966094] Missing net_device from driver
>>
>> Did you check that nodes exist in the device tree for the net devices ?
> Yes it exists. The device-tree used was also built with linux-next
> tagged next-20240417. The node corresponding to eth0 is cpsw_port1 which
> is present and enabled in the device-tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts?h=next-20240417#n644
>
> Regards,
> Siddharth.

I could reproduce the bug by disabling 'cpsw_port2' in my device tree,
which is 'k3-am625-sk.dts' for the board I use.

A condition is missing in am65_cpsw_create_xdp_rxqs() and
am65_cpsw_destroy_xdp_rxqs() functions.

For these 2 functions, the code which is in the for loop should be
run only when port ethX is enabled. That's why it crashes with
your device tree (cpsw_port2 is disabled, which is not the case by
default for the board I developed with).

I'll send a patch to fix the issue. Thanks for reporting it.

Julien

