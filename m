Return-Path: <bpf+bounces-67952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8BAB50931
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 01:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3BDC680A35
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 23:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255D72874F7;
	Tue,  9 Sep 2025 23:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWKIclvk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6AA272E61;
	Tue,  9 Sep 2025 23:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757460257; cv=none; b=bSNvvTnrcVjdET8/jtrTM0wXN1FiA7HbBv2n4zR7ycPtQoBg7YCdqdvv9lTlrkIveqYbJ+LihJT8VktVb8243GMNQFsstvDFX5SIO5vlBwJINTKUq3ywh2Y3AO3sdnbDdJvR+vd9tcWsocsqYeZWLz9Taodanr3JRLhDOuSn1E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757460257; c=relaxed/simple;
	bh=9qgPARpfukaz9TiE15ixw5tZhDNXX2rFuRgp98dSgsY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aX7fXd7KW4V/3Lwt3iPvepaWmk/NVg8OahRdJFOhKq1ut/8UtHEuqRSNgLNpMrL7gqznoD9UD6Mh23wHZPtjNR1JjhEdhL/6FCTbpwHVfdHBFCfvIrxgOmd5IRQVqOWxzsSyBbTrGImfyRJGoOS379ZReKV+fSFZ6HaXb0v+I2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWKIclvk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB15C4CEF4;
	Tue,  9 Sep 2025 23:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757460256;
	bh=9qgPARpfukaz9TiE15ixw5tZhDNXX2rFuRgp98dSgsY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pWKIclvkJ73SsOQWaP8bDr0FnorQnyZ766W1Qzcr4kF7qw6UA4va7YHhoEcAmwZlv
	 OmBaLbHaU8+lbjrC/0e+4xF+VIfJFPrKXm/AorKOkaRTLQI1rM0UGXdKfjaJ+BKxK2
	 B2K3E/0fkVNY4s2V1FaZdoCeEYBtTD5MKWZov8J3VIV04nrfyLLCKlOCUM2qZRVHnR
	 pjRWaqytmbDplwPcwSUJx2QjS9Ihg+PdFLkEMvz6X1g17lM4T4NFTVpxQ0//gcOydQ
	 +Ksuo1BFIQTnhXL9Yk2liLBNX9SldWi+K1PfdxBBjxG5/jokuGoBh8bU255UjiIRhq
	 +dEhvQaHCanzQ==
Date: Tue, 9 Sep 2025 16:24:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me,
 michael.chan@broadcom.com, anthony.l.nguyen@intel.com,
 marcin.s.wojtas@gmail.com, tariqt@nvidia.com, mbloch@nvidia.com,
 jasowang@redhat.com, bpf@vger.kernel.org, aleksander.lobakin@intel.com,
 pavan.chebbi@broadcom.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH net-next 1/2] net: xdp: pass full flags to
 xdp_update_skb_shared_info()
Message-ID: <20250909162414.0cf09278@kernel.org>
In-Reply-To: <669d9245-ac4b-4d43-aea3-cc30ac5836a4@kernel.org>
References: <20250905221539.2930285-1-kuba@kernel.org>
	<20250905221539.2930285-2-kuba@kernel.org>
	<669d9245-ac4b-4d43-aea3-cc30ac5836a4@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Sep 2025 15:30:00 +0200 Jesper Dangaard Brouer wrote:
> I'm fine with the name xdp_update_skb_frags_info().
> But I want to point out that the function *does* also update shinfo.
> The xdp_buff/xdp-frame have a compatible layout for shinfo, except for a
> union with sinfo->destructor_arg, which we need to clear.  This is a
> transition point from XDP to SKB, which is why I think the function name
> change is appropiate.

Fair point.
My initial confusion was because I expected xdp_update_skb_shared_info()
to _only_ update shinfo.

> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > ---
> > v1:
> >   - rename skb_flags arg to xdp_flags  
> 
> Thanks for that. You kept the function name xdp_buff_get_skb_flags(),
> indicating this is "skb_flags". I don't think it matters much, so to
> avoid bikesheeting I'm just going to ACK this.

Thanks! Happy to respin with whatever names, if anyone expresses 
a strong opinion. Otherwise I'll fix the typo and apply tomorrow. 
Indeed the risk of bikeshedding is rather high here :)

