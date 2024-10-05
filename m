Return-Path: <bpf+bounces-41051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9E1991703
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 15:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B4C28364F
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 13:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439D91514EE;
	Sat,  5 Oct 2024 13:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="DUw7tgzO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC7214A60C
	for <bpf@vger.kernel.org>; Sat,  5 Oct 2024 13:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728135494; cv=none; b=rBKCdGEPc1ZKO52su7Zl39ck0Xi14bXg6IO8Q82D+9oD8Q0lHhdKlKQntb3MjJPdqdInBR4HIOo+0bKsrCiUOSRjEJj5ScCuT7OyFPKyu0x4CvfnD8cjZpBdpseAaTxxJkOi9Y97o+wKcH+PnELqUQdcL8No9GI7mhav4WUiM+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728135494; c=relaxed/simple;
	bh=PBr6/dfIa1Z4Ms8k3qQYTzZ7OeZkeUo6p01mrrCA5YA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ehe7DUEEJozq89/txXsLqXpIWarC33mqGDpufUMMaa65MtztetY7PeIAzxh6kiQ7Q9RoJNd9UQvnh76UNOBEVKDQy3ndaDnXwo+hYFOvLvsbFBsF2ruzoynuNfCG4kRvW3lO70Z8mDOsrQogIJQ8q0UDPLciSyOpy9BLUZcJlDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=DUw7tgzO; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42ca4e0299eso26168095e9.2
        for <bpf@vger.kernel.org>; Sat, 05 Oct 2024 06:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1728135491; x=1728740291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3CqnQ70DTr/Y6AcuCA8XH8gKPRqxEzhLJBZL6l8Tp90=;
        b=DUw7tgzO6iY64IzjthMC6ZYuC0WsS5YWDlDa561zEX80rZ1DZXB+DXe1R/lRaRsRSf
         RGJY8Cb9qnn7KXkIuW8lwVT+OoxzfmwxxqUql+gfoUph1goh0KHVXtRxu6YEHB6ZZEVQ
         vT8VNQwD5WNj2dAIYU9Szj5LtxbCaBz4+loxA+AlTg9JMFM0W3AVMUPXHKfEMnxbjS5C
         WrbsXYywOBdphWDc1mxyDdUX0okeL9LWI17daTRJt9pAG6bf2EbzK/TucKuCDnXBv9Of
         aTcC2Sq25dz1qvMGSubYi9OawANHUYt2bKK/xgKH5+V6ClHG9dCMfWOc3FEYml0TtZue
         rQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728135491; x=1728740291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3CqnQ70DTr/Y6AcuCA8XH8gKPRqxEzhLJBZL6l8Tp90=;
        b=j6g5OruFPE6FOoe2XD+oQ7mnLBqROibCXDJeo6gUQ5c2+Nd7xFNFBxCTfAwnu0cVqd
         f+ktsUVKDI3YuelAhFQrXxYxW4GJO/WUDYkxzRiJEPEExM+4jCXBFoMkGuibWBSawT6F
         ENV0k8gNniR+YsG2tRbDpAELTOVWR0tmf7fzOa1pAQx5fXy02J/0NLZlWd5TbsNI2CkZ
         cmKAgwK/dvWRxr1ZXDuwUQWYKWD2O+IK0S4OoopLnpzMphVNGTgiWg1qyTde6KN2e77v
         czaLdfNQf54YEX9TiAOLgprbdcLdQO/MVJkHWUKhEcQ83HBrJJoOdToKso1+tVxAWc1P
         7lRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9DgSYKS424ojV4zgw7HXUobSlCIbhUsOforKxY73kqkC/6VP/wRIj7NJUrpHnXT7L9C0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOnguhL8iK1or4Q5CqxEmDqhej9ecxiM1wXuGV/Bl0hEfBlai1
	f7y5O2aamwiI5J7Ygo4EiJXkZCIVICvEManfKd8u4TGrLXYQjGle4ZWvx1labAQ=
X-Google-Smtp-Source: AGHT+IF5gqT7Vy1K1OF2hajNiOdWhdhxVdqq4WISlD8V+79szW62g+Y+lRLjghT3Egbtx0R+WW1c5g==
X-Received: by 2002:a05:600c:6c11:b0:42f:7c9e:1f96 with SMTP id 5b1f17b1804b1-42f85b64a22mr45635515e9.1.1728135491291;
        Sat, 05 Oct 2024 06:38:11 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89e8334bsm22894435e9.7.2024.10.05.06.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 06:38:10 -0700 (PDT)
Message-ID: <8c763b0e-743c-4f10-a497-8ede27eefe26@blackwall.org>
Date: Sat, 5 Oct 2024 16:38:09 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/5] netkit: Add option for scrubbing skb meta
 data
To: Daniel Borkmann <daniel@iogearbox.net>, martin.lau@linux.dev
Cc: kuba@kernel.org, jrife@google.com, tangchen.1@bytedance.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20241004101335.117711-1-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241004101335.117711-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/10/2024 13:13, Daniel Borkmann wrote:
> Jordan reported that when running Cilium with netkit in per-endpoint-routes
> mode, network policy misclassifies traffic. In this direct routing mode
> of Cilium which is used in case of GKE/EKS/AKS, the Pod's BPF program to
> enforce policy sits on the netkit primary device's egress side.
> 
> The issue here is that in case of netkit's netkit_prep_forward(), it will
> clear meta data such as skb->mark and skb->priority before executing the
> BPF program. Thus, identity data stored in there from earlier BPF programs
> (e.g. from tcx ingress on the physical device) gets cleared instead of
> being made available for the primary's program to process. While for traffic
> egressing the Pod via the peer device this might be desired, this is
> different for the primary one where compared to tcx egress on the host
> veth this information would be available.
> 
> To address this, add a new parameter for the device orchestration to
> allow control of skb->mark and skb->priority scrubbing, to make the two
> accessible from BPF (and eventually leave it up to the program to scrub).
> By default, the current behavior is retained. For netkit peer this also
> enables the use case where applications could cooperate/signal intent to
> the BPF program.
> 
> Note that struct netkit has a 4 byte hole between policy and bundle which
> is used here, in other words, struct netkit's first cacheline content used
> in fast-path does not get moved around.
> 
> Fixes: 35dfaad7188c ("netkit, bpf: Add bpf programmable net device")
> Reported-by: Jordan Rife <jrife@google.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Link: https://github.com/cilium/cilium/issues/34042
> ---
>  v1 -> v2:
>    - Use NLA_POLICY_MAX (Jakub)
>    - Document scrub behavior in if_link.h uapi header (Jakub)
> 
>  drivers/net/netkit.c         | 68 +++++++++++++++++++++++++++++-------
>  include/uapi/linux/if_link.h | 15 ++++++++
>  2 files changed, 70 insertions(+), 13 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



