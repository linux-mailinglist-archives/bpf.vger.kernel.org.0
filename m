Return-Path: <bpf+bounces-40116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9574B97D14B
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 08:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52DD3287F6D
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 06:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AB9433CF;
	Fri, 20 Sep 2024 06:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="QB/yFY1M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95DA38F9C
	for <bpf@vger.kernel.org>; Fri, 20 Sep 2024 06:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726814623; cv=none; b=TTQaF0CbIYgwKaJdx4Bqal4tPwRZ6tCtH2H/NdbVOKPsvJ3VOmRwySiynsAA47KJYjHek6XFh5qkYCQk7H9rCYy3G+0ifY0uJSGrzrcl63XOe40Qpq9NHA5ZTXrT1HElC4x4XzQ/urGLy1FiscmJ/Tb4cr7VueddinnlIqbuogI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726814623; c=relaxed/simple;
	bh=sOxxjmVIf9DK1JAPwTVAbAeOHGayuH0y2cxXhJoEjJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cu37r9jKn0CwQs4RqIEdXYSasLIWkz6SPqrcGBjKaM+5CsEWbThlwCUMTpC4TCRlgwXQ6bp0quKCLnFYSieY/bk4+pINHZtp5aoad1HrY69x0Qg8xRoX06B/YmDMUoB/7RtOxYgPQz3qpjjozZdhkYzxbDrRsu8WiBA2p0cEPhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=QB/yFY1M; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5365928acd0so1875690e87.2
        for <bpf@vger.kernel.org>; Thu, 19 Sep 2024 23:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1726814620; x=1727419420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LLaE4A8HWomqnZxKIsBh6iXXcm0J13/3tg8Vb7IGkgU=;
        b=QB/yFY1M86Pyo+0JMY2IrcKxjNPPaV/JKUA4jYV5ZDhiKcc2IeNxoGiAfPqIuVWmju
         zA3edRbxcLfJ3H3wtl28mU9XT8YvVsz9wD36eCwHqiujbDaKuIGzdGUlvGn9TRDu+1Eg
         3SCr+3IO1nzr1er4GN3DOxQbApbRzVjyRYcXx3/Y/KBPZc/wgyv4979jgEM79oVehAUQ
         e/UDKp4/L7B1hmywYE8V6Cu5dXwqNOwv0aSxZWYKThUy0Zc1+L8JS/prv8kAixQw7t1Q
         Oyn1hoM5Ar5pc30bHM+zLzhLYBR2YAkTXMz4hzgU0mVoPxKSdeH5YAD6FkCJddhREEf4
         6m5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726814620; x=1727419420;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LLaE4A8HWomqnZxKIsBh6iXXcm0J13/3tg8Vb7IGkgU=;
        b=EPsnq1pW0aIs0HiGJnMXxdHY3KqAYjrkCIXCnFOlJ86B15drtxEGGmR6AOwMhp19Gy
         AHZbKUGW+6wzPHuUDY/LxYOI1nLZRfsu9uh3fr/lgpLBjNh0BqhUVw+q9oBTRZOIt16E
         nOxXl5r0Wg3jP6cE1lbageDeAzgDBhkdWEbZetZCSzZoTOsYHfJ5CZCgMd5xdXE0Zpjg
         4d7pTgR+EuGA6ALVas8HYIrztEGCVxBmqNKace2NBEc+HlD4OtZGkneQxC97QR4Vv4Jm
         A0mBACjnGDBFA4Ml3mXYe+n6qHg9vLB6Yu1A3wYX+DzP2Rz5CfBtyARXoHIjTL9AR2UF
         FDAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ/muSPpHYzn5rjcoKqf3zgrRouGm3ftLSqKduyWpj0D2jyRFj78JBZbQ0MC5fUlH9mQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxATFEkO6+Ynjq4jwgRHuDbtFb9nx0CiNJgRx4rfDLT+GU9MQdO
	KKM6S22ycSN0i3n5xu0HASdh7QBHXNTKvtiLjXmQSx5pbWE5F4HwFxsipqd+zTM=
X-Google-Smtp-Source: AGHT+IFYc/zDgQiOV93CNO/o/R1jy+aordDFcbQRV8R86JE7XcZO4DTMEjkiBq8Mwj3Lv/fNs3rUBg==
X-Received: by 2002:a05:6512:39c4:b0:536:581c:9d9f with SMTP id 2adb3069b0e04-536ad16b327mr692425e87.24.1726814619733;
        Thu, 19 Sep 2024 23:43:39 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90613304dasm797860266b.197.2024.09.19.23.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 23:43:39 -0700 (PDT)
Message-ID: <8dfc3125-b4fd-4209-89c5-a5a85a1d65a6@blackwall.org>
Date: Fri, 20 Sep 2024 09:43:37 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] bonding: Fix unnecessary warnings and logs from
 bond_xdp_get_xmit_slave()
To: Jiwon Kim <jiwonaid0@gmail.com>, jv@jvosburgh.net, andy@greyhouse.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, joamaki@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, syzbot+c187823a52ed505b2257@syzkaller.appspotmail.com
References: <20240918140602.18644-1-jiwonaid0@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240918140602.18644-1-jiwonaid0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/09/2024 17:06, Jiwon Kim wrote:
> syzbot reported a WARNING in bond_xdp_get_xmit_slave. To reproduce
> this[1], one bond device (bond1) has xdpdrv, which increases
> bpf_master_redirect_enabled_key. Another bond device (bond0) which is
> unsupported by XDP but its slave (veth3) has xdpgeneric that returns
> XDP_TX. This triggers WARN_ON_ONCE() from the xdp_master_redirect().
> To reduce unnecessary warnings and improve log management, we need to
> delete the WARN_ON_ONCE() and add ratelimit to the netdev_err().
> 
> [1] Steps to reproduce:
>     # Needs tx_xdp with return XDP_TX;
>     ip l add veth0 type veth peer veth1
>     ip l add veth3 type veth peer veth4
>     ip l add bond0 type bond mode 6 # BOND_MODE_ALB, unsupported by XDP
>     ip l add bond1 type bond # BOND_MODE_ROUNDROBIN by default
>     ip l set veth0 master bond1
>     ip l set bond1 up
>     # Increases bpf_master_redirect_enabled_key
>     ip l set dev bond1 xdpdrv object tx_xdp.o section xdp_tx
>     ip l set veth3 master bond0
>     ip l set bond0 up
>     ip l set veth4 up
>     # Triggers WARN_ON_ONCE() from the xdp_master_redirect()
>     ip l set veth3 xdpgeneric object tx_xdp.o section xdp_tx
> 
> Reported-by: syzbot+c187823a52ed505b2257@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c187823a52ed505b2257
> Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
> Signed-off-by: Jiwon Kim <jiwonaid0@gmail.com>
> ---
> v3: Fix subject and description
> v2: Change the patch to fix bond_xdp_get_xmit_slave
> ---
>  drivers/net/bonding/bond_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index b560644ee1b1..b1bffd8e9a95 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -5610,9 +5610,9 @@ bond_xdp_get_xmit_slave(struct net_device *bond_dev, struct xdp_buff *xdp)
>  		break;
>  
>  	default:
> -		/* Should never happen. Mode guarded by bond_xdp_check() */
> -		netdev_err(bond_dev, "Unknown bonding mode %d for xdp xmit\n", BOND_MODE(bond));
> -		WARN_ON_ONCE(1);
> +		if (net_ratelimit())
> +			netdev_err(bond_dev, "Unknown bonding mode %d for xdp xmit\n",
> +				   BOND_MODE(bond));
>  		return NULL;
>  	}
>  

Looks good to me, but next time wait 1 day before reposting another version.
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>


