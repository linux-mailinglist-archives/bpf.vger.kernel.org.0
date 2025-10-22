Return-Path: <bpf+bounces-71720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4CEBFC15F
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 15:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19BCC4E7B4C
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 13:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B22C34DB71;
	Wed, 22 Oct 2025 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="PTn+OJr7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4397E34DB4A
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 13:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761138034; cv=none; b=bs//RzdH3CZ4QYal37HEG99njFF22hT7QFN+v24zgFyik9FnS0lcFO7+LP1/KFCOPM4Mce95tL97yuGeFpWlHEtuav7wMg7qVS3MDvOMhOlZFRHLHksHkYzL3CJHq2laTdu+5E+kX6IsNWo4VAS+08C0OMiuZ1d9xTNl96QIvTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761138034; c=relaxed/simple;
	bh=lj3+/9vLftsCBjCzdN+X3Nq0wpevMM5aO27bK9qqcGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iqk6/eJ2MO4zn2n6AbLOysoHQHdklCoa+PEW+6ikmAXyviNAetPtQgwkFlJpCKduGiDpjTU0o9c+frAk7Ptt3l6fcsD4K2b/vUHKd6TgBYE55VXdC/ckq6BcZvnZ9hXMtkxp7/lCTUhIqOTBAL9AeNbkB7m+u30vVrE0Xp8GpkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=PTn+OJr7; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63c3c7d3d53so8437876a12.2
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 06:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1761138032; x=1761742832; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jh5ksIpXLgI3yn70biwBJxvXCxdN+NZ47Ntk3kQ1cJ0=;
        b=PTn+OJr7MF2zFiPuTLFVHExDALR/jSjRUkBvljF1Hru5pJzzEd8FEXZ1PUb8vGMpRF
         YOnx3Bux518QljD/PQ0sE3I2oRg8f46jpZf5W+mnAahf+T8QtpyuSqsZHcYZ2OR1NN8g
         brloWwuY0s3w4Uiosfu+MubOjKCxjXCmnICSH9qPBVY4iIjwkO7esXHJQaCk8FIzLMia
         RY+yFmucdT+r80/thguCJ/1pR4T1YAoRbf4cPjIU0RzA/aWLiGo78HesRgJ+Rh7aTquW
         ++1AFaOl/EYnFjx6Wik/PcLAdKFUH2fXtJgYr/YNtA8KJwBvfDDcPIX5pfoXJfpIZrPV
         pnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761138032; x=1761742832;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh5ksIpXLgI3yn70biwBJxvXCxdN+NZ47Ntk3kQ1cJ0=;
        b=vLYH1XcOyUJCu8PuGTNDBOFjOe94Qo+21sKxPUCOUYZ+XIKqs4gsrSEA37VMeDSiSQ
         qEpjmJg7cuKitJtN4+G8vBua2Kvo7HHcbUF8w29MT9BccynZuCtnpcPG0TpsVLK315Gq
         bJ4v4AcLoDeEMVw8e0NgFvBtu4cRN3HevpL0gUunKL6P67dsztl1I0JWjyZnErmbAhOw
         OK53vFZzW4R8WNAFn0V27+wv0M1umkK5PXuiB1y16fNsLUbhHqfpxXuYDG7ZTt4vePhN
         8oixdyPT0mGlpSupynQ17mqhEo1jpZowBHNfLYa4KemwpqzGahTps5n8JPoPKx8k66IG
         XRpw==
X-Gm-Message-State: AOJu0YxId1hG5NUApaeSaDQ/pcQtHknh2jaHiUk1pd45vDBDdvG0cSDg
	PxzY0kPSk/x6fdRYaUq0lFWo9DHqjGwwHufpYrSKslFRrLlzf6tWoIfE7eZHDfr3tew=
X-Gm-Gg: ASbGncuMzCinvgnVj61VF0p0Lv0oRhra9mK4QMtwz81W7AiILKV3nEtWxFv7bEYgTlp
	68yVtXF86LfZ88Wu+vWTSTewH3+EPfC/YdF5MwqNnM2V66sg/3KJQz0EeBCK9SWvRx1Wb20IzMp
	Lh4qK3j93fg+y3cOe/WB8oi7GbN32hlDK/y/b28Bpx/SM0AYZlzl20/Y58oR4LQfQYKnHSukJeB
	jYzkGQ7ty6WdGPWNm2n18hMRFmJmF2ak+ipQ/J9Wu9LYi4fb0pCfg+7FnCdB5XWju9Hnf5qRvSs
	yc9NRs5zIarYR2V0Cy9QlrJBoVjtoz2/XkDV2FJTGlAMwBBD71wBJcuZw/pLCTHzDqtDpy8IK02
	3M2rJ/ODoE1eQ2FwZuQNncnbIX91YkfTZoZrS7NApfL3DxhLzDDSF6QAAImOd0JcP/x71nc6n7C
	SB1fQzNXNA0wmm07vizmZKNLTwZ1KXR43bP40xclneaBM=
X-Google-Smtp-Source: AGHT+IFEjQbW6rQ6MVYPA9PtdiwaaNzRaYiTiaZSKasSAGkhUbT61kH4OnM5E1/HHnZyIvoOzcB/6g==
X-Received: by 2002:a05:6402:5248:b0:63b:f76f:c87e with SMTP id 4fb4d7f45d1cf-63c1f64e87dmr20911347a12.1.1761138031552;
        Wed, 22 Oct 2025 06:00:31 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c48acf60dsm11891136a12.18.2025.10.22.06.00.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 06:00:31 -0700 (PDT)
Message-ID: <8994bee9-d384-4c95-b4f9-1f322c240242@blackwall.org>
Date: Wed, 22 Oct 2025 16:00:30 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 13/15] netkit: Implement rtnl_link_ops->alloc
 and ndo_queue_create
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-14-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251020162355.136118-14-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 19:23, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Implement rtnl_link_ops->alloc that allows the number of rx queues to be
> set when netkit is created. By default, netkit has only a single rxq (and
> single txq). The number of queues is deliberately not allowed to be changed
> via ethtool -L and is fixed for the lifetime of a netkit instance.
> 
> For netkit device creation, numrxqueues with larger than one rxq can be
> specified. These rxqs are then mappable to real rxqs in physical netdevs:
> 
>   ip link add type netkit peer numrxqueues 64      # for device pair
>   ip link add numrxqueues 64 type netkit single    # for single device
> 
> The limit of numrxqueues for netkit is currently set to 256, which allows
> binding multiple real rxqs from physical netdevs.
> 
> The implementation of ndo_queue_create() adds a new rxq during the bind
> queue operation. We allow to create queues either in single device mode or
> for the case of dual device mode for the netkit peer device which gets
> placed into the target network namespace. For dual device mode the bind
> against the primary device does not make sense for the targeted use cases,
> and therefore gets rejected.
> 
> We also need to add a lockdep class for netkit, such that lockdep does
> not trip over us, similarly done as in commit 0bef512012b1 ("net: add
> netdev_lockdep_set_classes() to virtual drivers").
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  drivers/net/netkit.c | 129 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 117 insertions(+), 12 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


