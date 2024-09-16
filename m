Return-Path: <bpf+bounces-39986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7145979D2F
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 10:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D5A2283B4F
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 08:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218DA1465B3;
	Mon, 16 Sep 2024 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="e/SPAnpC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E012F142633
	for <bpf@vger.kernel.org>; Mon, 16 Sep 2024 08:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726476503; cv=none; b=oUkpHZdl2wHg4YszvccHPHQ320arp+kWOJmanZhpo2jZGpfb//8j2MWBo62G6owc8A1wc38CtycyDCT09qOO5bwBu2SGSAW9vBjOS31BFC8MASyJMHQKim3nsAU3iTh8N/QKCBQc5N5vDsPtjJ9TpWou21/+oA7tP5Ii5RV5OuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726476503; c=relaxed/simple;
	bh=N6rcoqk3w12a/D9xPAqhs+KhOd/lJaMejZyWunxve+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NABECaLVi3guU9Y+4Gm0N+d/iPoTV8aA3l3zlP/1xBA71LibJo0BqeTo1ro/03sxMK/9IsACexZYa0K8eAZqHRxIuG3SAm53FM22kl942cpYi0Y3OnMc8vii9c7Jf8Wo99jFQgeIPvFeamXjhL+dqB5IgaUSsbAUPIoKMco6gnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=e/SPAnpC; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f74e613a10so35026881fa.1
        for <bpf@vger.kernel.org>; Mon, 16 Sep 2024 01:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1726476500; x=1727081300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UcC7h3PGjOK5d8NQXH0Z/MFEjZnprQptlNIQrkbo1Rw=;
        b=e/SPAnpCnPdjtycKi+p43y9D3xh3N8HmLmH7OTAuIK99+MAZk1xE3jVwH4cSUiZV0h
         jPmOUeD8a9CM1/e44TbR1+u3dotq8/QuXHifEFDMy9E0UaO5zD8n/bmj5dM8U6f/iQPy
         HVrSEYJIrnylYB0IEYHwi0Ovp8uyXeU6mj+UFf4WKuXQXL0pq1cV8LUW6qkxSFzaa4RN
         U2M0sW8nayfWv3GHNOozu6+NVewr9spWMLR9WngbCTiV4cBqgL4/QQaa3KXQjcOnraLn
         6i4TXDXJpb4BSqLgHukx9Kupt8/77fax94kXDZ6SS0qcHNjClkCFMNnKsDhdxGDe2HCJ
         pnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726476500; x=1727081300;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UcC7h3PGjOK5d8NQXH0Z/MFEjZnprQptlNIQrkbo1Rw=;
        b=Q+HnNHZeMiI5FBGJSc3N6sYVoNUzf7ZnEp2Dts59n0JhZY+lhXxWVuLEp1IHEYLziD
         CEAskZzaioJssCA4y8K2rvlhNrbkweV1lSO1YeKOSrHRECXC29itLAriRRQJplnCN4wX
         StnFdRG0e76Hrndj1eTY38rWN69xiAsjXw+OZePfqaK4sj1EwWyekYjTUUGfwIBj+gho
         XBebMGSdshBgC0A3B8ss737zW+9HZ/mp17KZlpExpifH7kP2RxNiZlsyt2vqisM9FdKY
         xPkbuxW418xPoFtFd6nKDuBVG0HlcKAxsOZr2EWrrGdA+wIsEs3bfOM5zkpigq4lLy5J
         uTxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVY/0sG2cwrZmAWAOWzr7W0sXhmsiAfKsfLreFk7jwh9If3SRRTgeL0JrKwE619KkPQuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnXlRgRouQA/G+jLAcgGYdiqbCr/Rz9oZXRxZXpqeGPilvscMh
	jSl98lH4duDlGH3YpeVt1IWs/MrzRipxFdVhU/FyHbPTL18ezHkjzH8y504b188=
X-Google-Smtp-Source: AGHT+IHVgNEFXQLNwvsw20aIwYapcHuhPPJCKVRUE+fgg8Pdrhv4JmEgk+MAMUtXhhWb7XFi96kZ+A==
X-Received: by 2002:a2e:e0a:0:b0:2f3:c384:71ee with SMTP id 38308e7fff4ca-2f791b597b0mr47751931fa.33.1726476498914;
        Mon, 16 Sep 2024 01:48:18 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f43a4sm281315566b.83.2024.09.16.01.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 01:48:18 -0700 (PDT)
Message-ID: <05707e9e-08ac-4ee1-b910-883f8b4b2636@blackwall.org>
Date: Mon, 16 Sep 2024 11:48:17 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bondig: Add bond_xdp_check for bond_xdp_xmit in
 bond_main.c
To: Jiwon Kim <jiwonaid0@gmail.com>, jv@jvosburgh.net, andy@greyhouse.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, joamaki@gmail.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 syzbot+c187823a52ed505b2257@syzkaller.appspotmail.com
References: <20240916055011.16655-1-jiwonaid0@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240916055011.16655-1-jiwonaid0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/09/2024 08:50, Jiwon Kim wrote:
> Add bond_xdp_check to ensure the bond interface is in a valid state.
> 
> syzbot reported WARNING in bond_xdp_get_xmit_slave.
> In bond_xdp_get_xmit_slave, the comment says
> /* Should never happen. Mode guarded by bond_xdp_check() */.
> However, it does not check the status when entering bond_xdp_xmit.
> 
> Reported-by: syzbot+c187823a52ed505b2257@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c187823a52ed505b2257
> Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
> Signed-off-by: Jiwon Kim <jiwonaid0@gmail.com>
> ---
>  drivers/net/bonding/bond_main.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
> 

How did you figure the problem is there? Did you take any time to actually
understand it? This patch doesn't fix anything, the warning can be easily
triggered with it. The actual fix is to remove that WARN_ON() altogether
and downgrade the netdev_err() to a ratelimited version. The reason is that
we can always get to a state where at least 1 bond device has xdp program
installed which increases bpf_master_redirect_enabled_key and another bond
device which uses xdpgeneric, then install an ebpf program that simply
returns ACT_TX on xdpgeneric bond's slave and voila - you get the warning.

setup is[1]:
 $ ip l add veth0 type veth peer veth1
 $ ip l add veth3 type veth peer veth4
 $ ip l add bond0 type bond mode 6 # <- transmit-alb mode, unsupported by xdp
 $ ip l add bond1 type bond # <- rr mode by default, supported by xdp
 $ ip l set veth0 master bond1
 $ ip l set bond1 up
 $ ip l set dev bond1 xdpdrv object tx_xdp.o section xdp_tx # <- we need xdpdrv program to increase the static key, more below
 $ ip l set veth3 master bond0
 $ ip l set bond0 up
 $ ip l set veth4 up
 $ ip l set veth3 xdpgeneric object tx_xdp.o section xdp_tx # <- now we'll hit the codepath we need after veth3 Rx's a packet


If you take the time to look at the call stack and the actual code, you'll
see it goes something like (for the xdpgeneric bond slave, veth3):
...
bpf_prog_run_generic_xdp() for veth3
 -> bpf_prog_run_xdp() 
   -> __bpf_prog_run() # return ACT_TX
     -> xdp_master_redirect() # called because we have ACT_TX && netif_is_bond_slave(xdp->rxq->dev)
       -> master->netdev_ops->ndo_xdp_get_xmit_slave(master, xdp); # and here we go, WARN_ON()

I've had a patch for awhile now about this and have taken the time to look into it.
I guess it's time to dust it off and send it out for review. :)

Thanks,
 Nik

