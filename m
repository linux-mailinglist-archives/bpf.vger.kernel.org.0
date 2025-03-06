Return-Path: <bpf+bounces-53464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0EDA54772
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 11:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1045E3AFBAA
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 10:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB491FCFE6;
	Thu,  6 Mar 2025 10:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmUyuxsh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3329A1FDE37;
	Thu,  6 Mar 2025 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256079; cv=none; b=F79JJXhLdQ0z6re9Vdx4yOcIWSR827DGjypdrDSn9B6Gh4R3xmqDCGV6WHC/7wKk4ahyuR1p3zWUAEynWsMncZVV4TKlGz5g42WRY33UFrIWQTHiEBUalsJHG9Xqve9MkxNzNHwxBiLd6q7qTsU0uUYMMMe2JYqRDfrbWp9HEtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256079; c=relaxed/simple;
	bh=y7BGOOgFIZDpIPxPVrgjVX+cYofJcZ2OpGZjnScXGDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1jp0Uq0llCWghRJ8/PmBE5b06OK7/SnrHO+ZgJclyNCkm0rxEUcQH2P0icxZWCb5zW7sf8vzHJ3VxYQWGGf/ODugm5pBtAQprBQpCEJe7AV9dLhduIUsHnBvln7P2HUEFJPOXZV42Ik5Pm8PCHrA6dwc99e7GbpCygeK9FOtMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmUyuxsh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5D7C4CEE0;
	Thu,  6 Mar 2025 10:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741256078;
	bh=y7BGOOgFIZDpIPxPVrgjVX+cYofJcZ2OpGZjnScXGDQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hmUyuxshB1xyXY/EAclasn1cD/x8hM4eZU9q2wejseDARO3pjYYVoDqah8RzioHAP
	 Cxhifm0jTqBBfknetpK5b5IgyFdxAnk6lRLiewmLOagspsf2vn7gT6Yr1RAPm/Nlx9
	 joCLcJQSq1ExSuWmXfNTkrXo4m5Y34EKU5yCDNBhkjWCg47B92bsdTFi20lFxAK8W7
	 wOymRfV3tC0LsUpzakWo7ccllENzNCh4mSior5Bn5/1ZAuX99SbY9/z3Q8/wQazkD2
	 XCMpwUQcTNMcSNx4ODeM7tOb5vUHuliuxfpGbKaEtQsVwoUIKAHWu663cEC6UEK5V/
	 NUbpWUDh98vlw==
Message-ID: <529122c4-a704-4d3a-8ec0-98552e7a87a2@kernel.org>
Date: Thu, 6 Mar 2025 11:14:33 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next 06/20] trait: Replace memmove calls with
 inline move
To: arthur@arthurfabre.com, netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, yan@cloudflare.com, jbrandeburg@cloudflare.com,
 thoiland@redhat.com, lbiancon@redhat.com,
 Arthur Fabre <afabre@cloudflare.com>
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
 <20250305-afabre-traits-010-rfc2-v1-6-d0ecfb869797@cloudflare.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250305-afabre-traits-010-rfc2-v1-6-d0ecfb869797@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/03/2025 15.32, arthur@arthurfabre.com wrote:
> From: Arthur Fabre <afabre@cloudflare.com>
> 
> When inserting or deleting traits, we need to move any subsequent
> traits over.
> 
> Replace it with an inline implementation to avoid the function call
> overhead. This is especially expensive on AMD with SRSO.
> 
> In practice we shouldn't have too much data to move around, and we're
> naturally limited to 238 bytes max, so a dumb implementation should
> hopefully be fast enough.
> 
> Jesper Brouer kindly ran benchmarks on real hardware with three configs:
> - Intel: E5-1650 v4
> - AMD SRSO: 9684X SRSO
> - AMD IBPB: 9684X SRSO=IBPB
> 
> 		Intel	AMD IBPB	AMD SRSO
> xdp-trait-get	5.530	3.901		9.188		(ns/op)
> xdp-trait-set	7.538	4.941		10.050		(ns/op)
> xdp-trait-move	14.245	8.865		14.834		(ns/op)
> function call	1.319	1.359		5.703		(ns/op)
> indirect call	8.922	6.251		10.329		(ns/op)
> 

I've done extensive *micro* bechmarking documented here:
  - https://github.com/xdp-project/xdp-project/tree/main/areas/hints
  - In traits0X_* files

The latest that corresponds to this patchset is in this file:
  - 
https://github.com/xdp-project/xdp-project/blob/main/areas/hints/traits07_bench-009.org

I've not done XDP_REDIRECT testing, which would likely show the bitfield 
change in xdp_frame, that Olek pointed out.

--Jesper

