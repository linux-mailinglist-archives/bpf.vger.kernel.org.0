Return-Path: <bpf+bounces-70392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3502BB9039
	for <lists+bpf@lfdr.de>; Sat, 04 Oct 2025 18:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9813B188BA96
	for <lists+bpf@lfdr.de>; Sat,  4 Oct 2025 16:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2779A280324;
	Sat,  4 Oct 2025 16:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K77OVNu3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F36927FD72;
	Sat,  4 Oct 2025 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759596498; cv=none; b=YzpODUw8anhbllHRjlqHD9EJ/AsjaS9Q7GBK11XDttvDG2Sm0CTwighIjiRSsJxbWrlnbfCQKByESnSLmE3YYyEDVqL7Y72NQ5FQ/cPlPXMbpFLCjSFF+bpUw5tXewqmn0WuwjhN2l/usT5ODqRWq2YiODm90OiVo7C0D0URmPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759596498; c=relaxed/simple;
	bh=cRVAbmLirjKAT9NXSzqnyQ75kH35+QNc1CpVxjQdeqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+6ZAE2OZIm7N60auJ2d5sWgiFEh9ROrj82OzagMITdygyQEdZOk6CvnnILf4HzHyiKroGTEz7/Q02ZH7ljyKhoy1QqHmuhkLs2hucnSu6tv4PHPlqSR7fsrruamLo7fpTOI7ki/NR2L5sdz3Ae22d9bblp9aNWLzsUbg9TP9LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K77OVNu3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5171C4CEF1;
	Sat,  4 Oct 2025 16:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759596498;
	bh=cRVAbmLirjKAT9NXSzqnyQ75kH35+QNc1CpVxjQdeqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K77OVNu3CZZRr2fO23ORb7vcn1oKg7XoZ8nBuurbkrjh55WW6fGIZzBQbucfzmJo+
	 J7/cAkk8SzmIToAs34ihCYv3YVfaHWEIGi9qbaAda+Wy2NBcSCq4SZnMUg0OFy58zc
	 w0dTczw6mIdx/GL1Q275b0RrFvcNVkaV1sbPbsSye1G8xkvwK1hGAIHFsDz4tFPqbG
	 JheFFBWiVswYUBm3he+kXlccHG7WjiUZR3gqPEXI+Hz82zWp0dQFzi/ZaMziVsmSnI
	 XW8xXGVzE9DgLiLNqstb1LSyroWTmFwLyTSgy1SGzgPooJv+y/AP8nDQphHXAWR9JZ
	 AIHXV5nxlUUDg==
Date: Sat, 4 Oct 2025 17:48:13 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, bpf@vger.kernel.org,
	alexanderduyck@fb.com, mohsin.bashr@gmail.com,
	vadim.fedorenko@linux.dev, jdamato@fastly.com,
	aleksander.lobakin@intel.com
Subject: Re: [PATCH net 6/9] eth: fbnic: fix reporting of alloc_failed qstats
Message-ID: <20251004164813.GK3060232@horms.kernel.org>
References: <20251003233025.1157158-1-kuba@kernel.org>
 <20251003233025.1157158-7-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003233025.1157158-7-kuba@kernel.org>

On Fri, Oct 03, 2025 at 04:30:22PM -0700, Jakub Kicinski wrote:
> Rx processing under normal circumstances has 3 rings - 2 buffer
> rings (heads, payloads) and a completion ring. All the rings
> have a struct fbnic_ring. Make sure we expose alloc_failed
> counter from the buffer rings, previously only the alloc_failed
> from the completion ring was reported, even tho all ring types
> may increment this counter (buffer rings in __fbnic_fill_bdq()).
> 
> This makes the pp_alloc_fail.py test pass, it expects the qstat
> to be incrementing as page pool injections happen.
> 
> Fixes: 67dc4eb5fc92 ("eth: fbnic: report software Rx queue stats")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


