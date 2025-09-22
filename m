Return-Path: <bpf+bounces-69249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97831B923F6
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 18:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1E1F2A4912
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 16:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4173126BE;
	Mon, 22 Sep 2025 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJIrtBjh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD743126A0
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 16:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758558946; cv=none; b=H+X3J3Ksyzji2bWBfG4EX9s0puR+9dK2J5hnQCxf7qW/7xCT2xXL5PUDYy72ZcR3EG3nYR36QiMe3GktiBLiY780+vQm0tHuoM//GUghFz4sSngJ/uYehHMKXmJCoLwnVpP+O7fAKtz253fudcjeNzqn+ZvrDyIPw7WiKvRgH6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758558946; c=relaxed/simple;
	bh=sHi7b3T/ZLdvyBIC+qISsiJxbsLBU33rXd0d2LElTu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Edp+Z1+xUxhxJr+KgG6hcrZL4BiRq95Or7EgqG9UxsllrZYrzw/eIWaCiywmNmlyvXWXcEptWm/gjPRiH/GoGb8sj9r3GLJD4cBzCIjS4fXOQO7tqGL5hIk/BKa7iXsQG/TgRE2s/EneVij0GCKC0NcRXQ8vspzqdcun8vQ2bho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJIrtBjh; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b54a2ab01ffso3203696a12.2
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 09:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758558944; x=1759163744; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Zejsegc+8xqQ9kyy+zjHL2oglb/+dwjs07vbMFj+CU=;
        b=mJIrtBjhHxI1+lPckbVbbgkYZKW1YVd841D7+GyRQlyYpYOL9iSzTWT+rCulWggjdF
         1wZCOY5ocWQ6DsppK9kwpQKAnFAE/TmTl11JhuuE75KMINvJq6wp8UHfPcB1DKTgcF/9
         axN5dOjZ5O7Q/3fzAwY6zJ8vqabBYxDgsi07aMJ9r+op9tLvlMFpSk9fISOSaQWKiHpH
         5yKTURlECIpAiooRGuwqeCMOkBQ7bId+l1H5gaC1kR4N4MIpQvL9rLNnBFhmhBrtrYmx
         +P311ZmfT3XsAGGvh7zJs37L2dtnlttyQHUg0OJskhK8cqZfgUR54rxqziw+DD1hclw5
         KB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758558944; x=1759163744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Zejsegc+8xqQ9kyy+zjHL2oglb/+dwjs07vbMFj+CU=;
        b=Ko0UK4fKPuIIr6qDj7Iico66vW8Zv2myfruQZvfCbayVcVAKQp/EnL2zjL067jJ3Rd
         woT1QEvA3xKsLm5S9AeQCLX7qe9y2E3TwMhrQrtxpgy9lvCGa5yoXfhGOOPnVqeC/tiP
         jjUueDootEuP6yNKLOHASn546M3GSCWvZQS32dDVgxIUnQK6eWniILPGVE3eDAvW1aic
         b3lSLytO5eeZdsDohQ4OQbXEKMdZwcMkTYDN6+sEvXSr4+qTm9RrB3Zm9tn81+SfkdlO
         SuTA6Ml9eSraq1bGgtSTxGiXNu583O7RLIrbeXECOhIhBpr5Gfc7v+6hItAYk5ClDIgr
         jYjw==
X-Forwarded-Encrypted: i=1; AJvYcCVQKFDbKmYxWRysLIMVm5ZGLRYYk19qMrEgdd47HCmemuYiL9lQGXFsUlkuK1gEU6IPoB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtjc6FjLmU0xSt+g8842Iy4xl1JnGvPY/HbW3WCUXmjMT2mr2n
	S+E/lH/gpGwC/mOVpUhRPZSw6Gpr9CN5KKB9bRcHyOfogi1aPdynLsA=
X-Gm-Gg: ASbGncsEILeWglI80KCJKgL3yI8Plo6wguMVXAVV/aW42yMu4RRf7OZGJgDaa7ulDdv
	itXQsUoGBtrtuWiFsoPw+fyQTU2h+xyPegM8DFMwELEOCTrFIapGX0hogMdbGdvdWF4zNOFXIuc
	2YY7XrRNnC6LhWyAqJrefjxNDxPXZHfVlYX2Cd0dLcK6jOFCYKNzWmzKsL24sL2fWzR/R4vIVEf
	1AYRasxV8GyZG+PEeR9MXE+0+NuJAi0WmNY+ZM0/afXppx0ipNZWpUZZcACL5kkG9Bt13rUOEZv
	hcyJBXAMVgwZWfu636Qfig34IB7+waLOR1e/OWVlhx48Hdx4L5TM7jS/IeuChClTrix5cguc06y
	dfgq6Iuz5nr9nPHaJbmi7bG/uEm4ffFE4cccbCRXLsP6UYcFA88Ps5olPVvSf15NGr8kYR/IksQ
	tUJCd8Tlgsv+2O0A0EqVS9AQzZ+nRUo4R9vZ2tqZGflWNsRpyx4llKvZ7Ug1nFrh1qKDsPEIcXn
	OgN
X-Google-Smtp-Source: AGHT+IFSgdA/KR+aImb49Fk/fhScu517VMdwG6QqqWoN6p6yvorjbtv7g5EjG9hpo3GZPKyxvG5GkQ==
X-Received: by 2002:a17:90a:d44f:b0:330:7f80:bbd9 with SMTP id 98e67ed59e1d1-33098385c68mr14019658a91.31.1758558944102;
        Mon, 22 Sep 2025 09:35:44 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b552fa85110sm7698823a12.45.2025.09.22.09.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 09:35:43 -0700 (PDT)
Date: Mon, 22 Sep 2025 09:35:43 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next 08/20] net: Proxy net_mp_{open,close}_rxq for
 mapped queues
Message-ID: <aNF632NGqn893xlJ@mini-arch>
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-9-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250919213153.103606-9-daniel@iogearbox.net>

On 09/19, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> When a process in a container wants to setup a memory provider, it will
> use the virtual netdev and a mapped rxq, and call net_mp_{open,close}_rxq
> to try and restart the queue. At this point, proxy the queue restart on
> the real rxq in the physical netdev.
> 
> For memory providers (io_uring zero-copy rx and devmem), it causes the
> real rxq in the physical netdev to be filled from a memory provider that
> has DMA mapped memory from a process within a container.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  net/core/netdev_rx_queue.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
> index c7d9341b7630..238d3cd9677e 100644
> --- a/net/core/netdev_rx_queue.c
> +++ b/net/core/netdev_rx_queue.c
> @@ -105,13 +105,21 @@ int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
>  
>  	if (!netdev_need_ops_lock(dev))
>  		return -EOPNOTSUPP;
> -
>  	if (rxq_idx >= dev->real_num_rx_queues) {
>  		NL_SET_ERR_MSG(extack, "rx queue index out of range");
>  		return -ERANGE;
>  	}
> +
>  	rxq_idx = array_index_nospec(rxq_idx, dev->real_num_rx_queues);
> +	rxq = __netif_get_rx_queue_peer(&dev, &rxq_idx);
>  
> +	/* Check again since dev might have changed */
> +	if (!netdev_need_ops_lock(dev))
> +		return -EOPNOTSUPP;

But if old dev != new dev, the new dev is not gonna be locked, right?
Are you not triggering netdev_assert_locked from
netdev_rx_queue_restart?

You might need to resolve the new dev+queue in the callers in order
to do proper locking.

