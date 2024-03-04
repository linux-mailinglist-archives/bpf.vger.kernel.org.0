Return-Path: <bpf+bounces-23283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 268CA86FB27
	for <lists+bpf@lfdr.de>; Mon,  4 Mar 2024 08:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F713B20FE9
	for <lists+bpf@lfdr.de>; Mon,  4 Mar 2024 07:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA83168AF;
	Mon,  4 Mar 2024 07:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahcrYj1d"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C60214A93
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 07:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709538901; cv=none; b=SLr63/8AsDljsIc83zkapAZ/wmx59lXPV2du6Tj7LwLiMo9jpy97a4szNwH+NB60AEsFONATV4Oj8e1xypxHPHtL77PwGU00uWhnUgbjDxhVghP3QfkuwdYZUT+OSi6ozqtLTVJnZ5JDX0Z4UzNrjejXd3+gOj0geSrPcomBz8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709538901; c=relaxed/simple;
	bh=p6Urnz+2Ta3f7kOkPM5DbFuLip3NAfCMXzcs08p4wBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NhWoZLJl0ZK9Za0wpI+rpFCwbOcMR1I6iBmDWukapvgYKMGqKeBN0TCAjoUsQe6Z1fnraUmv7ffGexwN5SfuB/R8IECDhUkWxwuU2ljoFyyznXkvzxKYglBeEPNBdInEoqr99Yhdbyu/uxWpJhdt8PLQl7S/MdejfrO9pVuvSus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahcrYj1d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DCDC433C7;
	Mon,  4 Mar 2024 07:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709538901;
	bh=p6Urnz+2Ta3f7kOkPM5DbFuLip3NAfCMXzcs08p4wBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ahcrYj1dyiqeI3FybO9o3aXX0MLEyrxXvIg4Hq/LjLd/8bn5nhNwjUoq8uYLe0Ml7
	 NxC0ub4AubKaEjlt054LymegP0FHpoZStH80tU0a4A9ScXeQaUWHHXAgxHoLhCkMvL
	 Bu2BAHGQ7bqf5hL2B6L8oVg3E8otol7ZUbWn+JAWyUncSvpeq/oY5CR1JqVbPoHMJg
	 nZC0lhtkuq5rgdsQ3/3ZKHAzdFJ+YjLfDbjA9rTgRRX4h0gqWIJsqQ+dI+40IIdbqZ
	 cCX6EN1NiDFXsxM1L/qOAsSFM2iWNfoSeHnvaeyVtw+UOJBZU3FWPizOY1HNOE+V7Q
	 shceRKWhU9xIg==
Date: Mon, 4 Mar 2024 09:54:08 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	torvalds@linux-foundation.org, brho@google.com, hannes@cmpxchg.org,
	lstoakes@gmail.com, akpm@linux-foundation.org, urezki@gmail.com,
	hch@infradead.org, boris.ostrovsky@oracle.com,
	sstabellini@kernel.org, jgross@suse.com, linux-mm@kvack.org,
	xen-devel@lists.xenproject.org, kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 2/3] mm, xen: Separate xen use cases from
 ioremap.
Message-ID: <ZeV-IE-65yiIwFSY@kernel.org>
References: <20240223235728.13981-1-alexei.starovoitov@gmail.com>
 <20240223235728.13981-3-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223235728.13981-3-alexei.starovoitov@gmail.com>

On Fri, Feb 23, 2024 at 03:57:27PM -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> xen grant table and xenbus ring are not ioremap the way arch specific code is using it,
> so let's add VM_XEN flag to separate them from VM_IOREMAP users.
> xen will not and should not be calling ioremap_page_range() on that range.
> /proc/vmallocinfo will print such region as "xen" instead of "ioremap" as well.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  arch/x86/xen/grant-table.c         | 2 +-
>  drivers/xen/xenbus/xenbus_client.c | 2 +-
>  include/linux/vmalloc.h            | 1 +
>  mm/vmalloc.c                       | 7 +++++--
>  4 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/xen/grant-table.c b/arch/x86/xen/grant-table.c
> index 1e681bf62561..b816db0349c4 100644
> --- a/arch/x86/xen/grant-table.c
> +++ b/arch/x86/xen/grant-table.c
> @@ -104,7 +104,7 @@ static int arch_gnttab_valloc(struct gnttab_vm_area *area, unsigned nr_frames)
>  	area->ptes = kmalloc_array(nr_frames, sizeof(*area->ptes), GFP_KERNEL);
>  	if (area->ptes == NULL)
>  		return -ENOMEM;
> -	area->area = get_vm_area(PAGE_SIZE * nr_frames, VM_IOREMAP);
> +	area->area = get_vm_area(PAGE_SIZE * nr_frames, VM_XEN);
>  	if (!area->area)
>  		goto out_free_ptes;
>  	if (apply_to_page_range(&init_mm, (unsigned long)area->area->addr,
> diff --git a/drivers/xen/xenbus/xenbus_client.c b/drivers/xen/xenbus/xenbus_client.c
> index 32835b4b9bc5..b9c81a2d578b 100644
> --- a/drivers/xen/xenbus/xenbus_client.c
> +++ b/drivers/xen/xenbus/xenbus_client.c
> @@ -758,7 +758,7 @@ static int xenbus_map_ring_pv(struct xenbus_device *dev,
>  	bool leaked = false;
>  	int err = -ENOMEM;
>  
> -	area = get_vm_area(XEN_PAGE_SIZE * nr_grefs, VM_IOREMAP);
> +	area = get_vm_area(XEN_PAGE_SIZE * nr_grefs, VM_XEN);
>  	if (!area)
>  		return -ENOMEM;
>  	if (apply_to_page_range(&init_mm, (unsigned long)area->addr,
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index c720be70c8dd..223e51c243bc 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -28,6 +28,7 @@ struct iov_iter;		/* in uio.h */
>  #define VM_FLUSH_RESET_PERMS	0x00000100	/* reset direct map and flush TLB on unmap, can't be freed in atomic context */
>  #define VM_MAP_PUT_PAGES	0x00000200	/* put pages and free array in vfree */
>  #define VM_ALLOW_HUGE_VMAP	0x00000400      /* Allow for huge pages on archs with HAVE_ARCH_HUGE_VMALLOC */
> +#define VM_XEN			0x00000800	/* xen use cases */
>  
>  #if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
>  	!defined(CONFIG_KASAN_VMALLOC)

There's also VM_DEFER_KMEMLEAK a line below:

#if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
	!defined(CONFIG_KASAN_VMALLOC)
#define VM_DEFER_KMEMLEAK	0x00000801	/* defer kmemleak object creation */
#else
#define VM_DEFER_KMEMLEAK	0
#endif

It should be adjusted as well.
I think it makes sense to use an enumeration for vm_flags, just like as
Suren did for GFP
(https://lore.kernel.org/linux-mm/20240224015800.2569851-1-surenb@google.com/)

-- 
Sincerely yours,
Mike.

