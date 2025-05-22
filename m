Return-Path: <bpf+bounces-58785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E80AC1753
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 01:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E629C16CE73
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 23:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E5F2C17A2;
	Thu, 22 May 2025 23:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmHiDINk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5222C1785;
	Thu, 22 May 2025 23:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747955329; cv=none; b=YYuF8AJSNVHcyB/2CR9tNvZDadUpSHpGuuc8pN8neuainFVDj4ba8aXp0J+fJ66rdZ0Pe9KGWC6EABdKBgExqihWUekogtboeF3ZNOGH3gMMeRerh0cG/A28GI1zVqRSG8YvPEzw52aP2LaNfBJe4AigpFCuu0XdUgiNWjn/WkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747955329; c=relaxed/simple;
	bh=QEfzR85v3/zt/zSaAzV3QJxBJhSb+tSKSnYDT1H9gRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftIZHjudpWMRxZOnMVy+TqZu/6RvzSsks9nBBzp+m1OsHtML4FwKZaCPuQ+iGrz6d+WOCFsaA+igtQmoDhTunzUkjW9/rWBe/iTkE0kLgN9hfhj5brkJLhd+43KVyKQL5dwLw+/cwAb59W0Vncks7FQwQXMoyaQZBR04iLjVhiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmHiDINk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3F9C4CEE4;
	Thu, 22 May 2025 23:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747955329;
	bh=QEfzR85v3/zt/zSaAzV3QJxBJhSb+tSKSnYDT1H9gRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mmHiDINk5eItvcBw97SzWVJ8AsXlYnNR5JAnDXvufgHF4fyJRSk7jz7TvBR6UULWk
	 /dEEt0XggvxEPutVz7brT58vUiiS1pZSienyjNXd0mpspgZ80rwl+N8Sn2LqGh7wTp
	 FuO9pRw5ZpMRbzBP/sJGcVRJbheY4zWTzhI3t7rG1C6l9UdyS1OdZPCYrviVqNwuWe
	 1kxdLD2tbzUqUOCgLnOWQ66gYNyWgxIxaDX87rvW7+CNksz1PG4cGkZ7VGsvALx8x4
	 JQ3dQ5OLDnVDmm+Etxp6tAX94j6p0d+YE5cSfRWSTlocJSxk1o1YnHLNMjD6/qe8qz
	 aRjzdVvDTKSEw==
Date: Thu, 22 May 2025 16:08:48 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next V2 06/11] net/mlx5e: SHAMPO: Separate pool for
 headers
Message-ID: <aC-ugDzGHB_WqKew@x130>
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
 <1747950086-1246773-7-git-send-email-tariqt@nvidia.com>
 <20250522153013.62ac43be@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250522153013.62ac43be@kernel.org>

On 22 May 15:30, Jakub Kicinski wrote:
>On Fri, 23 May 2025 00:41:21 +0300 Tariq Toukan wrote:
>> Allocate a separate page pool for headers when SHAMPO is enabled.
>> This will be useful for adding support to zc page pool, which has to be
>> different from the headers page pool.
>
>Could you explain why always allocate a separate pool?

Better flow management, 0 conditional code on data path to alloc/return
header buffers, since in mlx5 we already have separate paths to handle
header, we don't have/need bnxt_separate_head_pool() and
rxr->need_head_pool spread across the code.. 

Since we alloc and return pages in bulks, it makes more sense to manage
headers and data in separate pools if we are going to do it anyway for 
"undreadable_pools", and when there's no performance impact.

>For bnxt we do it only if ZC is enabled (or system pages are large),
>see bnxt_separate_head_pool() and page_pool_is_unreadable().
>
>Not sure if page_pool_is_unreadable() existed when this code
>was written.
>
>> -	wq_size = BIT(MLX5_GET(wq, wqc, log_wq_sz));
>> -	*pool_size += (rq->mpwqe.shampo->hd_per_wqe * wq_size) /
>> -		     MLX5E_SHAMPO_WQ_HEADER_PER_PAGE;
>> +
>> +	/* separate page pool for shampo headers */
>> +	{
>> +		int wq_size = BIT(MLX5_GET(wq, wqc, log_wq_sz));
>> +		struct page_pool_params pp_params = { };
>> +		u32 pool_size;
>
>A free standing code block? I this it's universally understood
>to be very poor coding style..
>

Sure if used excessively and incorrectly. Here it's only used for temporary
variable scoping. I don't think there is anything wrong with free-standing
blocks when used in the proper situations.


