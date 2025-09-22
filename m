Return-Path: <bpf+bounces-69240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E23B921EE
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 18:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD4B13A9B60
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 16:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA2F310631;
	Mon, 22 Sep 2025 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eh8V+6NY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C869280CD5
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557079; cv=none; b=WsU5u6VB0d1P1Gbg1BVTrapG3T+2V83q+tP+q5kbrlLL+DP2K64FAqGdk/bFWq6ffFwwOvrb+cvbATMcctdVUFlC6uhMJGs98sSV5IeePZvwbWxb4UZRcY1UjKXl0qnVuRyZol1TwLvxJKp4HIL+S9rmRPb6dCE00sHj9cHGN5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557079; c=relaxed/simple;
	bh=Ljl7ScAxZk2dO+3HqKN3rFODorYsVJJH+Gqu5QhG1gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFEo4JhDWrFNMbnu5h/Eyj4tiYxDkyI2LwOlHKKhp9yJOBLc5FuaAarZzfHHpRWG0FYHK79k5S8XlwRo/gWPDGmk++cAgOyJqGcsG4m682VT/nWisMVB074W7PTusNKCI5WBuod7kEsx8Yp129LtJYXKEZRt0eaTcpUd2qXL2ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eh8V+6NY; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77ee6e252e5so2718402b3a.2
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 09:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758557078; x=1759161878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bn105Zf1c9vstVchIVF2tlN/PNR2fCVJTATnppqTOaU=;
        b=eh8V+6NYcKqnWrRtpVUW+up9FeqORw8WTE6EufHqAQiDYI0TaS5Jtt/Tg+A4k8xnDX
         8ExBdrBCwgdiRwOd812H+I/MG8+t1fqpSVfxQyBH2MmR/+scbBi+uxhpN+L+lBFW2J6U
         5+Bvbb4PsfEgI6d0Nev1t25PW8WY1bsso3Bf1r0RG/QUx/ZfHxNi6nj1zMRU6YM3xRYc
         D59qw83RlfIwdhxf3bhUp4jjZQFHCEtg5J7P0x8y+yVEKqitkkftLzBjFMZu6A0n6mAU
         DThK63dXvm7cJ4EWL7yJbC/pVrUmVEHTRzINQrmQ043NCLP1++YNScIpqqdH3WeenWHs
         3HpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758557078; x=1759161878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bn105Zf1c9vstVchIVF2tlN/PNR2fCVJTATnppqTOaU=;
        b=DSPciso51RhbmKHTE+T7+lp3THy+TECl/8aJKTVC/m7bf+yN7rb+c+XkpWicC0QICN
         KM8wrhuGTeKLJ0pUvgI1R3/x77FxS+jyhqUjMKkBGwXbtV8PqycCukoEc5qoldwncbfD
         YN99V7OOA95nJ03qqJ76QidGzJUBH88ClZ2+JwXGqhDxIJuTYfOFufHPUiuKJLnrV9WI
         fdBMR4JdXe5IZIJmqGTqOXCrgrHn8cMlTg6YetT/fpO0LFH9cjrPuFUIuijDu9dJ0dSx
         NuW076xtoAwoTQEE/ar56mVIKRgAm0tqwsa4gxiM6VlaNxJ/8W1DmYfynvIPR4Qch6rG
         d/zQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqN3/zc5pucx+SRcpx03rZohYsU0/Vsm4wFhCSNygtGfu8ttzEaHAkB4cc6GajVV4EwRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEM3weFlIHi6yryCLL88xLc+OJ96++SUbvLpWAQXo25wOIRMyK
	UtcCPMjLf26cLQAuq0xQbHTWLquprUiRkJ/xbuS/SY4yn2YPK1DIKxs=
X-Gm-Gg: ASbGncvrRfhGIGA2DMtR3yq8MszKa5fire24dqEXSLjLijBH3IY414YfIvoZ+SCtIjE
	hXXe80WmQ5ITSO5AgWxdhGJPHlu6Be41ANyYHP6MJGnfm8iUgbXQPTElKLP3BFwVpMHCFUyiEcQ
	1EkPbjvMZeJPShid133mUJTNfdpHojqsm3oUYZNPTOAMzg0QQGeJOAPin3ML+hdEp0QLpsimS2Q
	Q5Nnrc1memeaG0UIxjIsibzHhbmFYAUF6/O58gId3z15H2zoUpI964RgV8WWlNgpyLIN1F7J97f
	QjUYaICG6dgA20guyVaTVS95HJuevBJAWRB1zcrJT1R4rCnxowJ9tEHUVUy3kS6GVuLN0YT0MQM
	QYSIe1fb9irki9ZrpgWCGbUy+xATKuUtaZFYM2kyMDgDzVQXpiRUOY0VZzNY54i2Ot4Erd18rw7
	bzs1y5ihAVsb/L0RDMf3mVgFBL5qoxjLS18pX3XmDlJXwTGoA6Pr1c8o+G8DZb4/0xU4eBeXS+n
	jK4
X-Google-Smtp-Source: AGHT+IFgNGiQkq6SDsfPdO8uo78KCpKKl1zg7NUJDeqgoOltS1XlWewrJE98ZUxgli6mEi4XPuM/6w==
X-Received: by 2002:a05:6a21:3391:b0:252:2bfe:b65a with SMTP id adf61e73a8af0-2925b41e6c9mr18528562637.7.1758557077400;
        Mon, 22 Sep 2025 09:04:37 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-77cfbb7ab8bsm13345159b3a.11.2025.09.22.09.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 09:04:37 -0700 (PDT)
Date: Mon, 22 Sep 2025 09:04:36 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next 03/20] net: Add ndo_queue_create callback
Message-ID: <aNFzlHafjUFOvkG3@mini-arch>
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-4-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250919213153.103606-4-daniel@iogearbox.net>

On 09/19, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Add ndo_queue_create() to netdev_queue_mgmt_ops that will create a new
> rxq specifically for mapping to a real rxq. The intent is for only
> virtual netdevs i.e. netkit and veth to implement this ndo. This will
> be called from ynl netdev fam bind-queue op to atomically create a
> mapped rxq and bind it to a real rxq.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  include/net/netdev_queues.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> index cd00e0406cf4..6b0d2416728d 100644
> --- a/include/net/netdev_queues.h
> +++ b/include/net/netdev_queues.h
> @@ -149,6 +149,7 @@ struct netdev_queue_mgmt_ops {
>  						  int idx);
>  	struct device *		(*ndo_queue_get_dma_dev)(struct net_device *dev,
>  							 int idx);
> +	int			(*ndo_queue_create)(struct net_device *dev);

kdoc is missing

