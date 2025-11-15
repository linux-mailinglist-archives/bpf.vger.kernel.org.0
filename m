Return-Path: <bpf+bounces-74608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05A7C5FD3B
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 02:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2383E3BA7EA
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 01:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043B51DE3AC;
	Sat, 15 Nov 2025 01:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnmqR+MX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3611A8F84;
	Sat, 15 Nov 2025 01:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763169802; cv=none; b=qtsX7xAgw2TOQGUL9IqvulU4PdcnsxDfTMILbWfD9DCPo1rcc1a66ijs/ZdB0nPmnrdCds1xrCkx3R26j8KfDto5bRVS4JX7XuIIsOlaDvMwe576yu62X4+0PlgQHKAX5Z2WLuA9GzFEpLXMP+cWyN0jxISBWUpJ5PgW7KRrRz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763169802; c=relaxed/simple;
	bh=EMdA7LgelkVDzq5X2oeGm8KBPNNOdtKtMm09LzMfpWM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZhqL9oPPU77W2hgidln9ynzbLuMRix4XWV6HLLJgkQHAAjh9kk6ghw51eLHq7aO+cvVpqbP3lvnWpYKc5EeXrTSC5RJYXNG4MQHZkt5JMYj1XoF/dCwzyt1BEbTAlqFES6jlGXN5MRwvV35+L9WfTFHIf98PYz88MjEtr4ItJ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnmqR+MX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E79C4CEFB;
	Sat, 15 Nov 2025 01:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763169802;
	bh=EMdA7LgelkVDzq5X2oeGm8KBPNNOdtKtMm09LzMfpWM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cnmqR+MXWNIY93IIWSP5PhZy9V4XdM6Dc+i9FY0vBFDrhSK5jE8iX2DRe+Lue/pJq
	 6MK4oSSxyA6KlLgW/0m5Q80afT4rMM/AjjjY82icXhJnVwAGIRQhcQbdZp5tw+Lmrx
	 RAlrrdU2XUYrHxZ0T6HpLqvYHxnM6sSsaWcVd6H2cLj7y1L5zgzNUzJQ7H0l75U6RG
	 BZ+H0Wt0NbxG2fpoaIQvMLDKJ5HDrFFaH3sSu36ucYzG149L4lQKqlMZH2BN8mNhbh
	 y841A3LmAnj+v2jGzdh0sPabpuo0KcgpvH9KREtLMXk496/V+w3iuIdZXzsJPA1pJV
	 7JLrVOnubpMkA==
Date: Fri, 14 Nov 2025 17:23:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Byungchul Park <byungchul@sk.com>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 mbloch@nvidia.com, andrew+netdev@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, akpm@linux-foundation.org, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 ilias.apalodimas@linaro.org, willy@infradead.org, brauner@kernel.org,
 kas@kernel.org, yuzhao@google.com, usamaarif642@gmail.com,
 baolin.wang@linux.alibaba.com, almasrymina@google.com, toke@redhat.com,
 asml.silence@gmail.com, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 sfr@canb.auug.org.au, dw@davidwei.uk, ap420073@gmail.com,
 dtatulea@nvidia.com
Subject: Re: [RFC mm v5 1/2] page_pool: check nmdesc->pp to see its usage as
 page pool for net_iov not page-backed
Message-ID: <20251114172318.3aafc438@kernel.org>
In-Reply-To: <20251112074118.GA31149@system.software.com>
References: <20251103075108.26437-1-byungchul@sk.com>
	<20251103075108.26437-2-byungchul@sk.com>
	<20251106173320.2f8e683a@kernel.org>
	<20251107015902.GA3021@system.software.com>
	<20251106180810.6b06f71a@kernel.org>
	<20251107044708.GA54407@system.software.com>
	<20251107174129.62a3f39c@kernel.org>
	<20251112074118.GA31149@system.software.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Nov 2025 16:41:18 +0900 Byungchul Park wrote:
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 651e2c62d1dd..b42d75ecd411 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -114,10 +114,21 @@ struct net_iov {
>  			atomic_long_t pp_ref_count;
>  		};
>  	};
> +
> +	unsigned int page_type;
>  	struct net_iov_area *owner;
>  	enum net_iov_type type;

type is 4B already in net-next, so you may want to reorder @type 
with @owner to avoid a hole and increasing the struct size. 
Other than that LGTM!

struct net_iov {
	union {
		struct netmem_desc desc;                 /*     0    48 */
		struct {
			long unsigned int _flags;        /*     0     8 */
			long unsigned int pp_magic;      /*     8     8 */
			struct page_pool * pp;           /*    16     8 */
			long unsigned int _pp_mapping_pad; /*    24     8 */
			long unsigned int dma_addr;      /*    32     8 */
			atomic_long_t pp_ref_count;      /*    40     8 */
		};                                       /*     0    48 */
	};                                               /*     0    48 */
	struct net_iov_area *      owner;                /*    48     8 */
	enum net_iov_type          type;                 /*    56     4 */

	/* size: 64, cachelines: 1, members: 3 */
	/* padding: 4 */
};


