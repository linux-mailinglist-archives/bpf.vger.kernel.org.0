Return-Path: <bpf+bounces-55483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1ABA815B3
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 21:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BDC13B3575
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 19:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3FD244198;
	Tue,  8 Apr 2025 19:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAcmoqeY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6721DA60F;
	Tue,  8 Apr 2025 19:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139635; cv=none; b=o0r2xjlmrSCLkS8ScPf/VgBO7YKpTP4Ben4WAUG1lxcKjRU61IvsPUR1pv6C7a3JbS6VSI2Yma5wq1dx24ozv5XvnvtU6V8PRog5MYb977jQH7hVrR5KfVewxMTA+4/LHTTBrSPUr1UVCAogk34cFcbd8ggUPrluDflODzTnq7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139635; c=relaxed/simple;
	bh=5DRa4EjABnqaxCONQi4w4JP1EalHC6671KkxCCi0Fzs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pFC5OHKg02VVC3pCarHx/UeNU1RxPQC1/7pmfuIskoQjw6+C1KTIJSGMqYARRX8SW+bwm/DnU8trEaykmGPWk2O4JWv/eWVJhcwxzRH1uiDxKZxq7V6+cLcyf/VxqzD4NLP9TGbWXUcHu2nyBTIcCorYKqV7EWkqJJe0kZMWtDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAcmoqeY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B24C4CEE5;
	Tue,  8 Apr 2025 19:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744139634;
	bh=5DRa4EjABnqaxCONQi4w4JP1EalHC6671KkxCCi0Fzs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PAcmoqeY8NOC6IKQgd+rhVff/TQUVbjUrNGWcC0ybL9oWMD2ofAddjwCzbWSV4DZR
	 yczqJ1wJG4E5G2ccTTI0C42i8suKrfvnMuUaiVR+BYcq/6WRJU2H1SFVnLQ5UMzIEa
	 0AoB/aYmwVXADDsbQPkY+vAn5vdA1ptyYcLTBHEVU3RGZy9habdt/P92X0IOZAgr8y
	 ntONC5aNaghc2ld53zdmgU83hXdJPis9y91HR5rRlC9Y9XCgohvqNbO1hvYZiegR11
	 0huf6QJRE53jzWR3ZSer6Hjg0NSCn8vaUTQ3uf5GMcSPrT1s7nbSBNs5LaFTynaX3M
	 vy6UAGYwlVZCw==
Date: Tue, 8 Apr 2025 12:13:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon
 Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mina
 Almasry <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, Pavel Begunkov
 <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH net-next v8 1/2] page_pool: Move pp_magic check into
 helper functions
Message-ID: <20250408121352.6a2349a9@kernel.org>
In-Reply-To: <20250407-page-pool-track-dma-v8-1-da9500d4ba21@redhat.com>
References: <20250407-page-pool-track-dma-v8-0-da9500d4ba21@redhat.com>
	<20250407-page-pool-track-dma-v8-1-da9500d4ba21@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 07 Apr 2025 18:53:28 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index b7f13f087954bdccfe1e263d39a59bfd1d738ab6..6f9ef1634f75701ae0be146ad=
d1ea2c11beb6e48 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4248,4 +4248,25 @@ int arch_lock_shadow_stack_status(struct task_stru=
ct *t, unsigned long=20

> +static inline bool page_pool_page_is_pp(struct page *page)
> +{
> +	return false;
> +}
> +#endif
> +
> +

extra empty line here

>  #endif /* _LINUX_MM_H */
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index 36eb57d73abc6cfc601e700ca08be20fb8281055..31e6c5c6724b1cffbf5ad2535=
b3eaee5dec54d9d 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -264,6 +264,7 @@ void page_pool_destroy(struct page_pool *pool);
>  void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(vo=
id *),
>  			   const struct xdp_mem_info *mem);
>  void page_pool_put_netmem_bulk(netmem_ref *data, u32 count);
> +

and here

>  #else
>  static inline void page_pool_destroy(struct page_pool *pool)
>  {
--=20
pw-bot: cr

