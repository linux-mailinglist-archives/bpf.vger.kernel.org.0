Return-Path: <bpf+bounces-58859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC61BAC2A64
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 21:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60A54E72BF
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 19:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DA01D54D8;
	Fri, 23 May 2025 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZjsSgCo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2CD19D8B7;
	Fri, 23 May 2025 19:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748028177; cv=none; b=i0wgrW1MPDUg6lYbrjEre9W0TlvJWbevVlDrlRx5FjZaKNjGDaMY0EK3Zt+gZHsCoMtILAAllIiOleFXIJeKU57BegsGjKlVfwoQBWL+3kiUHkBNPg9OIqq2LwzLeXWk/i8mvxxUL/+lYQJ+nA1CyK11vng/Td05EX231uLD8PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748028177; c=relaxed/simple;
	bh=aXlcNpzad5/yn3h/jgNhYnmF1/tsA8Bo02CTPnSUR08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJJZqaxjM4VEaZrSltxATC6Emiggwp1kOdHrCK+WxuzeBsFIs75Gybp1oucYcvYbQmM010FKKfQW0JxPqrMfiolGGgbNUDEaIlwkCkp8NnG4dGdt97L0jkBOaIHFFLhf1tUywkUqR8yt+MHouNQ0mhlLXqeLiAFywdCMyAQQ0dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZjsSgCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A98C4CEE9;
	Fri, 23 May 2025 19:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748028177;
	bh=aXlcNpzad5/yn3h/jgNhYnmF1/tsA8Bo02CTPnSUR08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QZjsSgCofwvPBSIjN/m1J3siBoRjWYzCOejdAFvlJv7/04kjNfw4yxmQJ6C/1AUWH
	 MSocIHO97YIPBocP95O5o2IdeJdyQbuf5rysjTe+Bs5c5QBDoH3Mut4CSnayfihcKy
	 V1kBBfJkiEUAl18Ai7FJwtBWDek5ZdoEK8n0kU3SnOn1Ja13IyMXfPeyIvYBP8tInw
	 Xt+eCjiAplQbmKM/5/KviSGyFOOK/sZPnpgiZEXnnLAyiZ7f1paT5v09BmiyIQtMyW
	 DnnBi+ylVt1ZvDf2Uo6m1ZLoqaMmvEtg+C9jJy1IvcipNooewJFi//l+/kOvjv+E+T
	 x/X4zpcFlfPLA==
Date: Fri, 23 May 2025 12:22:55 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
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
Subject: Re: [PATCH net-next V2 08/11] net/mlx5e: Convert over to netmem
Message-ID: <aDDLD_JoKJs5iv2q@x130>
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
 <1747950086-1246773-9-git-send-email-tariqt@nvidia.com>
 <CAHS8izNeKdsys4VCEW5F1gDoK7dPJZ6fAew3700TwmH3=tT_ag@mail.gmail.com>
 <aC-5N9GuwbP73vV7@x130>
 <CAHS8izNgY3APhLZWjYwEWyq3g=JiCBWFUcnY4nrXpntnp8zKhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNgY3APhLZWjYwEWyq3g=JiCBWFUcnY4nrXpntnp8zKhw@mail.gmail.com>

On 23 May 10:58, Mina Almasry wrote:
>On Thu, May 22, 2025 at 4:54 PM Saeed Mahameed <saeed@kernel.org> wrote:
>> >>  static inline void
>> >>  mlx5e_copy_skb_header(struct mlx5e_rq *rq, struct sk_buff *skb,
>> >> -                     struct page *page, dma_addr_t addr,
>> >> +                     netmem_ref netmem, dma_addr_t addr,
>> >>                       int offset_from, int dma_offset, u32 headlen)
>> >>  {
>> >> -       const void *from = page_address(page) + offset_from;
>> >> +       const void *from = netmem_address(netmem) + offset_from;
>> >
>> >I think this needs a check that netmem_address != NULL and safe error
>> >handling in case it is? If the netmem is unreadable, netmem_address
>> >will return NULL, and because you add offset_from to it, you can't
>> >NULL check from as well.
>> >
>>
>> Nope, this code path is not for GRO_HW, it is always safe to assume this is
>> not iov_netmem.
>>
>
>OK, thanks for checking. It may be worth it to add
>DEBUG_NET_WARN_ON_ONCE(netmem_address(netmem)); in these places where

Too ugly and will only be caught in DEBUG env with netmem_iov enabled on a
somehow broken driver, so if you already doing that I am sure
you won't mind a crash :) in your debug env.. 

Also I don't expect any of mlx5 developers to confuse between header data
split paths and other paths.. but maybe a comment somewhere should cover
this gap.

>you're assuming the netmem is readable and has a valid address. It
>would be a very subtle bug later on if someone moves the code or
>something and suddenly you have unreadable netmem being funnelled
>through these code paths. But up to you.
>

Cosmin, let's add comments on the shampo skb functions and the relevant
lines of code, maybe it will help preventing future mistakes.

>-- 
>Thanks,
>Mina
>

