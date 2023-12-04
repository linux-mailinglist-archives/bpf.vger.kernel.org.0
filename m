Return-Path: <bpf+bounces-16627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F140803EE8
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 21:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B95A7B20B47
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 20:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B48A33CC3;
	Mon,  4 Dec 2023 20:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxagOF64"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948292C1AB;
	Mon,  4 Dec 2023 20:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01131C433C7;
	Mon,  4 Dec 2023 20:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701720114;
	bh=clwbxwV51CebNhYrMt84h1J/9nrIOCdwldOTtND9l08=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PxagOF64Z+9GOiYFCybYSw+vcButysFRncix2xmJL0r9EXuO+FJrrIgVvrQDgcH/C
	 6/+s2avRoRlzoP/k6Wj+qURTWxxTxARXDU799oJwsHf7ujOPZofZ76Vljpo5AUqKoF
	 iS9FNMbZpASgFNNUhnr3PIho1Rr6Nt8xzcUGgIyJsr6qVBNxT1i2HLWGktPXHTbk3Q
	 zsLmlPHAffD8zI0FW8S4P2zzsZFf4hM/v+UaBxCi7az8yUGov474x6bPynY4l4QK24
	 WFW0r93jwiXcxvNiONz33ETDuAjCbDi7lpw9wqzeeNEYZ36KTNCHFsuE/yPyv4Wp4z
	 YyJoWwudksLyA==
Date: Mon, 4 Dec 2023 12:01:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: aleksander.lobakin@intel.com, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 lorenzo.bianconi@redhat.com, bpf@vger.kernel.org, hawk@kernel.org,
 toke@redhat.com, willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 sdf@google.com
Subject: Re: [PATCH v3 net-next 2/2] xdp: add multi-buff support for xdp
 running in generic mode
Message-ID: <20231204120153.0d51729a@kernel.org>
In-Reply-To: <ZW3zvEbI6o4ydM_N@lore-desk>
References: <cover.1701437961.git.lorenzo@kernel.org>
	<c9ee1db92c8baa7806f8949186b43ffc13fa01ca.1701437962.git.lorenzo@kernel.org>
	<20231201194829.428a96da@kernel.org>
	<ZW3zvEbI6o4ydM_N@lore-desk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Dec 2023 16:43:56 +0100 Lorenzo Bianconi wrote:
> yes, I was thinking about it actually.
> I run some preliminary tests to check if we are introducing any performance
> penalties or so.
> My setup relies on a couple of veth pairs and an eBPF program to perform
> XDP_REDIRECT from one pair to another one. I am running the program in xdp
> driver mode (not generic one).
> 
> v00 (NS:ns0 - 192.168.0.1/24) <---> (NS:ns1 - 192.168.0.2/24) v01    v10 (NS:ns1 - 192.168.1.1/24) <---> (NS:ns2 - 192.168.1.2/24) v11
> 
> v00: iperf3 client
> v11: iperf3 server
> 
> I am run the test with different MTU valeus (1500B, 8KB, 64KB)
> 
> net-next veth codebase:
> =======================
> - MTU  1500: iperf3 ~  4.37Gbps
> - MTU  8000: iperf3 ~  9.75Gbps
> - MTU 64000: iperf3 ~ 11.24Gbps
> 
> net-next veth codebase + page_frag_cache instead of page_pool:
> ==============================================================
> - MTU  1500: iperf3 ~  4.99Gbps (+14%)
> - MTU  8000: iperf3 ~  8.5Gbps  (-12%)
> - MTU 64000: iperf3 ~ 11.9Gbps  ( +6%)
> 
> It seems there is no a clear win situation of using page_pool or
> page_frag_cache. What do you think?

Hm, interesting. Are the iperf processes running on different cores?
May be worth pinning (both same and different) to make sure the cache
effects are isolated.

