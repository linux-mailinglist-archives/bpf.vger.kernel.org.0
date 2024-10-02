Return-Path: <bpf+bounces-40786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FA298E3A6
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 21:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941681F23EB0
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 19:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B524D216A26;
	Wed,  2 Oct 2024 19:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="skfYeJxa"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5B3216A05
	for <bpf@vger.kernel.org>; Wed,  2 Oct 2024 19:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727898101; cv=none; b=kUym7XKxSA07wCLssK/9njqhLmlDKVN7MfSu5PDVXjjTcquzAY/3IzLas9BB2yOBjC71ChWjB2Dh1sXgFZixIxCMo3cT8OkfJnSf+FJuzCaWGGdPPbHalH0nkK3bFdNuypiFk64qXiRZ0JjEIne5XjAReYuDYakcK2EhygBt1qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727898101; c=relaxed/simple;
	bh=K4JmIVnqL1CdalNvyJGXWIIVFwAaf6QMlDclXTLv4p8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZEC/f4/6HvOrnSrmNhTwWzE+xKGydb0xmspBaybxhRWNl/5vjpzb3zdnU96jrEQqROw56Uk7v6v9jbKJIFT/KC9KixqrEiuxu6LWzKiRR1QW1iVR7XXQKq1gD8sR1NQuH6I+WdxK3f6lvDE7Ge25x9SIRxP5CzY2kuYKJgpmE3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=skfYeJxa; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4aa21712-2643-42e5-a995-d53cf0a53158@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727898097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=52ZTLl/8wUBJJgZayC7fgNR7d1z1uHZK/4jdVO08y2w=;
	b=skfYeJxa5bEjU4xIECYRj5UtdgItnifcRXuCN5+Y6G/+kA/T0mm/7yLmorPOfdj11ql/gZ
	3+NBPMNmqmJedj6j3l79LaIumzoClF8VLED6vDYQx2uyiRczcb3dlPgx/Ff2VgSV0QsspK
	0w655y7gtUcyE+k9wvZm+r7aSQ4o5PQ=
Date: Wed, 2 Oct 2024 20:41:33 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 4/6] xsk: carry a copy of xdp_zc_max_segs within
 xsk_buff_pool
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org
References: <20241002155441.253956-1-maciej.fijalkowski@intel.com>
 <20241002155441.253956-5-maciej.fijalkowski@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241002155441.253956-5-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 02/10/2024 16:54, Maciej Fijalkowski wrote:
> This so we avoid dereferencing struct net_device within hot path.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>   include/net/xsk_buff_pool.h | 1 +
>   net/xdp/xsk_buff_pool.c     | 1 +
>   net/xdp/xsk_queue.h         | 2 +-
>   3 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> index 468a23b1b4c5..8223581d95f8 100644
> --- a/include/net/xsk_buff_pool.h
> +++ b/include/net/xsk_buff_pool.h
> @@ -77,6 +77,7 @@ struct xsk_buff_pool {
>   	u32 chunk_shift;
>   	u32 frame_len;
>   	u8 tx_metadata_len; /* inherited from umem */
> +	u32 xdp_zc_max_segs;

It's better not to make holes in the struct. And looks like it's better
to move it closer to free_list_cnt to put it on the same cache line with
tx_descs which is accessed earlier in xskq_cons_read_desc_batch()
(though the last point is not strict because both cache lines should be
hot at the moment)

>   	u8 cached_need_wakeup;
>   	bool uses_need_wakeup;
>   	bool unaligned;



