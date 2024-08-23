Return-Path: <bpf+bounces-37943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A2795CC10
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 14:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 052411C24081
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 12:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E060185B5E;
	Fri, 23 Aug 2024 12:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="xuU2by5F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E048C185B61
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 12:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414853; cv=none; b=uUIwqxPxS1fDGVRsEFnk2xVImHVUDpIZ23s1m4JeuA/QlO6MbPmj/UDqvnX4cga6FVAiQNL0xNffDQlgItc85OlcpeRWy0jp5qETeXiH3B/W0+2/CSZWnEBNv2bwAodtV275omU1jzW/ASF5cXmw4z0tTF7nirxY7itUzx2mvoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414853; c=relaxed/simple;
	bh=FgXWQTY2TJb5IwxquDZVWo+j49w6S6x5awgcCZttj/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gCIc5vHjgphbrNFIwrP9X4fb6MSlrgrk9emABfDp+yMITleoRm/rFVgByes+hQh6YdivtC9yh7sQVMTcO1shjPAkOK/PS+EWkLgkwvTGtC4BRLtkFnHb/mrvyB92enj7oue8WPGt0UZLxZ9Kf33h7d1uujtQgypfXyaoVPbDCgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=xuU2by5F; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-428243f928fso19360465e9.0
        for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 05:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1724414850; x=1725019650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f7BlCM09z/HC3CqqFiUB1muI/5aw+Q7NR3zZIY5YkDU=;
        b=xuU2by5Fu5mWrOliQ7yRQxSSigUNh+6zUBLPEw8mS+k1WYlCdmej6jyFwcKlUvJwBg
         PuHp3u6sAE7DZwHJJGO7e1qlBeYhUraDsDwuzVNM2vl0EBlpSfXbyKczNKYWOSUsPQuW
         oU8UCzSg4kEsBp0N4/pu+iKnjX6/E2c6LUrC+mnQ3bezjNy53pBv9ZJVz7NGIYIZDk3W
         FQ2p8qCDhyt7YsTgcCbHz7OIjHSXIZGDglTF4vDCDqAepK1TSfLl5Dbi6i/jZQYKXGm9
         FHg77itIcbpnqaf3GHxoQaxIiZFiip6QA2EcPCgTa3PTMUxMqLrGPox6djdbX24FoQGj
         3ySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724414850; x=1725019650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f7BlCM09z/HC3CqqFiUB1muI/5aw+Q7NR3zZIY5YkDU=;
        b=BcdR8V4ctT6SSBuLG0Z0uZi8UsiTp8jp7KwNd0W/4DNPGnsXLfghQ+vkJk3SQtvlBM
         KyofgPAgQGjz4xhPjBTm3T9e98o24MPwWt8H0u++rA2UP6XG1bIpXSAv1benc4OV15BW
         esW6RWKs/Ms3aaHXp2Z5JMJc/nqomIlL5TiYwD9ReyDhBZfI2Wvlnf5GLVrF5cuXIUlF
         +UViggHvDYZesckvfYN5orbQHAqkfV+nUoOVgkYn93/PxL56u5/7T2/hIRvWGXDRGzGN
         LgSSfQj6HnptdKqF18DP2yIa4ln517o9krE/X9/U9vhDpcaF73Ph5m02T6HzPEnLQ8V0
         CIZg==
X-Gm-Message-State: AOJu0YwROxTv7nCqCGaAcUIk1aMnGz6bpJzJmvdkH8zDUtDa2CsyHfOd
	EVvwhDWgL/99ysFaaQpdUB7wxfj0p6VHWi47CHTP803PXOFHCCPL2oBRcNhw0L3P87FhGkv09iH
	B
X-Google-Smtp-Source: AGHT+IHJywjT+9dQwajVbn25hIHOr0igZtcIMzzSMCPss+Yp4jw2OrxzvOtE4SpmlzIeskj8Qz+a4A==
X-Received: by 2002:a05:600c:a4c:b0:428:d31:ef25 with SMTP id 5b1f17b1804b1-42acd55e90emr15253335e9.12.1724414849747;
        Fri, 23 Aug 2024 05:07:29 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5162322sm57352795e9.24.2024.08.23.05.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 05:07:29 -0700 (PDT)
Message-ID: <46b77887-863b-493b-942b-9ddf0807b83e@blackwall.org>
Date: Fri, 23 Aug 2024 15:07:28 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] netkit: Disable netpoll support
To: Daniel Borkmann <daniel@iogearbox.net>, kafai@fb.com
Cc: bpf@vger.kernel.org, Breno Leitao <leitao@debian.org>
References: <eab2d69ba2f4c260aef62e4ff0d803e9f60c2c5d.1724414250.git.daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <eab2d69ba2f4c260aef62e4ff0d803e9f60c2c5d.1724414250.git.daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/08/2024 15:00, Daniel Borkmann wrote:
> Follow-up to 45160cebd6ac ("net: veth: Disable netpoll support") to
> also disable netpoll for netkit interfaces. Same conditions apply
> here as well.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Breno Leitao <leitao@debian.org>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>  drivers/net/netkit.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> index 16789cd446e9..0681cf86284d 100644
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c
> @@ -255,6 +255,7 @@ static void netkit_setup(struct net_device *dev)
>  	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
>  	dev->priv_flags |= IFF_PHONY_HEADROOM;
>  	dev->priv_flags |= IFF_NO_QUEUE;
> +	dev->priv_flags |= IFF_DISABLE_NETPOLL;
>  
>  	dev->ethtool_ops = &netkit_ethtool_ops;
>  	dev->netdev_ops  = &netkit_netdev_ops;

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

