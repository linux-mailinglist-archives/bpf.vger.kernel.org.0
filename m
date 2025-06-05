Return-Path: <bpf+bounces-59712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD89ACEDAE
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 12:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B13413ABC42
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 10:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D252153FB;
	Thu,  5 Jun 2025 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I19/7Rbp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BC11A7262;
	Thu,  5 Jun 2025 10:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749119541; cv=none; b=ECOW+6R1lV4gKJPg5gN1XuecPBVGgogzqO67D9CEc8g5U77g4TVe2dwqF2rYCGsAeYbL6KAYDuolThn3/bbnAvRQhjUQ8qq6o9tO+pXp//kSqQCKs0QXSrWwO4SKWHzR7VdNSOs9nstv42rw35XHwkpXCuJqUil0mcvcmi4MXwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749119541; c=relaxed/simple;
	bh=2gO7PwgVWx+9PJ0gy7nF/BYJCRAv8Img8db1uQ0fA3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rg62m7L4XD0U+Vh70MR794WYoRvbs5aTNejSe2lyTFLwNuSiP9/T3zFmbAalVC/40FCaT3CQ0ssEWxuPSHerZle/tvXA61i8CMIuTauipwC+g2+FzG6ym8wMlxpyEk0EwUlptW09X461B5FypAmzUBwB1jGCyJsMHoaBhWkcY+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I19/7Rbp; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-604b9c53f6fso1579393a12.2;
        Thu, 05 Jun 2025 03:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749119536; x=1749724336; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RcMUQCfxa0uC8pzdzvPwMQlIQ3/k2Rjbm8T9aOOzae0=;
        b=I19/7RbptVPI4OkqBkZzCw+daeyq1jaXjW9M3FuSj3U40uuZALrmHPpnUFcX8Acj+p
         XVjHLyg0/eIacgYbYWuURwP6E7pZDra45IpeA6+rV7OfBecRDMn2vE6cgDvEa1DAIfu9
         CHr5yhoHUmKXLanSCCiJfOVdvz1cBKdDpUX7szVVbTS+mIN4wXY0TI0ETvc2CMxtDNlM
         LAtBxFiobOqENfdxvirxA3rvqfOEyThTOEDoXzDgjoRjJwpLvFhUV4qG7idZiyDs5w66
         xzu/dCBNb4zSRQKSTKuQ6KQd/xPljEeC+RTW0gnuOtmkGOYPgMAC5iSCtlWQmRGrR7tp
         CSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749119536; x=1749724336;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RcMUQCfxa0uC8pzdzvPwMQlIQ3/k2Rjbm8T9aOOzae0=;
        b=RP7YgF7jLVms4EOPcd8ncQJ2vQIGl71uLzTde11IRmn/n8LO/XbXsSjwT/A0xO6X5k
         paejjhPL2ucsL+3BKaY5IdLRBo6mNH0wVZsHUdHv8z7PBseSRVPRtvPvg3DetIf/DtaN
         5BSTXWZyjCvOrrZFFdcfxie7tsAOB9TuRB6K40YtrOQ2G0NOcrnMz8KzoKfsPzxoicgM
         9U57s+XVAoiTZPXVbYfwbHXwx59rQu7XAF7DCngnNW8w8S5yUqRn7U+KQkQr0yBEy58f
         A0qsnRfQx50YHze7QBZSRbDLJYH+JV6wQJ2SR7WhzWQqKMqiWQ9+FTSgzsfkMktTNhRN
         N7uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgDGa6Wpv7QAJc9t+zsKxOjkFyeMnbq6E67/HiTpp3uVBixca7ZgfDwgHsjCKHescHA+WIRkZp@vger.kernel.org, AJvYcCXG1FZGNw3+FqDTB7cuVYnOoXD0j5E1UTtM7ikAhICQbRhn+fh3RLeli5+N8i3S2T7qzfA=@vger.kernel.org, AJvYcCXxdGs/rFPoIsTIwnveY95pPPvBLfxNxWiXksIn7CCyAJuF0mSF+zLslLrMzP+70ZSu4SYdFKZ5SuKh9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdmNkZ3JXZorLvoMfSBHWFGeVHz8W1sWPBBelByzm13vd6CqfY
	IRibr85KGrkJSPzsxF2FFv8/fZ/sjLsuRQm/BF+ifO0Bj06Vq44IhfGC
X-Gm-Gg: ASbGncuxJBB/3JvgHLnedrLEj4f6OeG6BVcH/cvujkE5Nzwn/dVXHaHFG/VT0QlphyE
	OvRXuTtrxtkh+pXpVodvB4HmHmW1GblgkFNowGP55Aksr2Gv9gvBTaZVw+nTwu6N3jvA37ovka/
	1Q0AwXS4mIFd6QbZcCgaq7GxaJG0hxMJWlODhC2kfsNdLq5OFKWsycEH8o+DEHALYyCtCGBZ4AH
	5UL2limeZdi+CN8e/yB8RDXbcLoVD2lmL8BD+lIwKB2+QY0O8CzF/NLCVmBYUXGu7WWTE4LZEse
	JIrBwbeD6MCmu1uIxwiAHufzEtasT+tz64hjXTe3FpeD8a8foCkxB1FVtvPCSqQY
X-Google-Smtp-Source: AGHT+IGJV4w4MyjgzgbWc6ZlWikV0SpiTCf2D3BKmMkklaQZpTnw0Xa1hsU1I+YbdE/tucex19ZGDQ==
X-Received: by 2002:a05:6402:1e8f:b0:603:5a23:2997 with SMTP id 4fb4d7f45d1cf-606ea15f285mr6577294a12.17.1749119536398;
        Thu, 05 Jun 2025 03:32:16 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::22f? ([2620:10d:c092:600::1:d66f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-606f0d84327sm2114656a12.30.2025.06.05.03.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 03:32:15 -0700 (PDT)
Message-ID: <96d3ffe0-b743-4596-aaee-87cce1603756@gmail.com>
Date: Thu, 5 Jun 2025 11:33:35 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 07/18] page_pool: use netmem put API in
 page_pool_return_netmem()
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, toke@redhat.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-8-byungchul@sk.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250604025246.61616-8-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/25 03:52, Byungchul Park wrote:
> Use netmem put API, put_netmem(), instead of put_page() in
> page_pool_return_netmem().
> 
> While at it, delete #include <linux/mm.h> since the last put_page() in
> page_pool.c has been just removed with this patch.
> 
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> ---
>   net/core/page_pool.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index b7680dcb83e4..dab89bc69f10 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -20,7 +20,6 @@
>   #include <linux/dma-direction.h>
>   #include <linux/dma-mapping.h>
>   #include <linux/page-flags.h>
> -#include <linux/mm.h> /* for put_page() */
>   #include <linux/poison.h>
>   #include <linux/ethtool.h>
>   #include <linux/netdevice.h>
> @@ -712,7 +711,7 @@ static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
>   /* Disconnects a page (from a page_pool).  API users can have a need
>    * to disconnect a page (from a page_pool), to allow it to be used as
>    * a regular page (that will eventually be returned to the normal
> - * page-allocator via put_page).
> + * page-allocator via put_netmem()).
>    */
>   static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem)
>   {
> @@ -733,7 +732,7 @@ static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem)
>   
>   	if (put) {
>   		page_pool_clear_pp_info(netmem);
> -		put_page(netmem_to_page(netmem));
> +		put_netmem(netmem);

Same comment as well. I guess we shouldn't even be returning "put"
from memory providers.

-- 
Pavel Begunkov


