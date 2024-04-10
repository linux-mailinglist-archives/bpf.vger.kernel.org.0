Return-Path: <bpf+bounces-26335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A04EA89E6F3
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 02:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58CB2283AB7
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 00:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD9EA55;
	Wed, 10 Apr 2024 00:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgDGr5W+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA4919E;
	Wed, 10 Apr 2024 00:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712709591; cv=none; b=PikxkSgMfBiQvDNnlAqywjRTPn5kWJy38cf2g4PfeqYErxs6YyUKwL4+LFEOS5gC5Bn1JH0s/sFM6kso1WfOFRHFdZXYD5m9RPUuKzWgmJhAfk5MP0JyeS1Hue4mT+jJIHvsemPz8Py3phZr68slwhHTQbc0Be/qalvAOmK8TGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712709591; c=relaxed/simple;
	bh=rPIGcmKkaKL77xy0kE1sS+HitVg+d/OiK8zkBdMTGF4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LSmq3q9iwMgpVM4VjOjwSh1waNTUPGcesNnDC95PabPRRlpD9E9UpH78CZB/rtqKYfxhLrWyr3/2lx1fYhmy7TIxGkQ33nwEVd+UDQ8vuOUflLbAB+LiQfhNgdALoyOYyRgOAAbUsT05rvWonyVLORIx86A74ZU3v5KBPGCaGgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgDGr5W+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05537C433F1;
	Wed, 10 Apr 2024 00:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712709591;
	bh=rPIGcmKkaKL77xy0kE1sS+HitVg+d/OiK8zkBdMTGF4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lgDGr5W+S1Mo/vVh51AzT36WYsN43KOdv2HUfV5OeoOGAeleNf+qD1QCKnVmw0f0U
	 KO/r9TUZ8143nBmmM0Qm0kfLSuNPR+q603FcX4WKnZ9O2zPhGlRLyZk9ouI3oEE2u+
	 xS4V4CtN5844T1z0xi98+DiGzT+tVt6J9U0tn83SkLMJlJBqb8J70g1FlMh3BnZk1t
	 PFyuwjn9p18IQ3bR9TgpM4o/aAIY9pOiY2znYey78v9rqgcBeo9vq8WCC/pnMi2gxg
	 TMgOlogCc1vvBqYyXQZzoy3ij/wFam0X+B4vIoxFbJH+PSXVmgCcnY4V7cUgtU0Uy/
	 ZcEuE+smnLljw==
Date: Tue, 9 Apr 2024 17:39:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Julien Panis <jpanis@baylibre.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Sumit Semwal
 <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>, Ratheesh Kannoth <rkannoth@marvell.com>, Naveen
 Mamindlapalli <naveenm@marvell.com>, danishanwar@ti.com,
 yuehaibing@huawei.com, rogerq@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH net-next v8 2/3] net: ethernet: ti: Add desc_infos
 member to struct k3_cppi_desc_pool
Message-ID: <20240409173948.66abe6fa@kernel.org>
In-Reply-To: <20240223-am65-cpsw-xdp-basic-v8-2-f3421b58da09@baylibre.com>
References: <20240223-am65-cpsw-xdp-basic-v8-0-f3421b58da09@baylibre.com>
	<20240223-am65-cpsw-xdp-basic-v8-2-f3421b58da09@baylibre.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 08 Apr 2024 11:38:03 +0200 Julien Panis wrote:
>  		goto gen_pool_create_fail;
>  	}
>  
> +	pool->desc_infos = kcalloc(pool->num_desc,
> +				   sizeof(*pool->desc_infos), GFP_KERNEL);
> +	if (!pool->desc_infos) {
> +		ret = -ENOMEM;
> +		dev_err(pool->dev,
> +			"pool descriptor infos alloc failed %d\n", ret);

Please don't add errors on mem alloc failures. They just bloat the
kernel, there will be a rather large OOM splat in the logs if GFP_KERNEL
allocation fails.

> +		kfree_const(pool_name);
> +		goto gen_pool_desc_infos_alloc_fail;
> +	}
> +
>  	pool->gen_pool->name = pool_name;

If you add the new allocation after this line, I think you wouldn't
have to free pool_name under the if () explicitly.
-- 
pw-bot: cr

