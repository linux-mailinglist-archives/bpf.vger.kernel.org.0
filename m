Return-Path: <bpf+bounces-54524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E624A6B41D
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 06:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02CC33B6903
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 05:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940E51E98E0;
	Fri, 21 Mar 2025 05:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Is8WS9WC"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFCC1DE2DF
	for <bpf@vger.kernel.org>; Fri, 21 Mar 2025 05:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742536027; cv=none; b=OOjlQGzsED8FJHEGuUor1NZxtyyHGK0qt/TZw6ISwRfLNQlFM/OR+MVPCcBroRi1dQzhbzUYZpmTuj+rAy26cFDlNFAwspN0X/mau5zA+PHUZ1PG0dL/MdDULog2P1eybmTzS5m2S463+Zgf6a7fnholSUbV5cOTxdQu2tM7qV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742536027; c=relaxed/simple;
	bh=zWaWLv8mZZ3c0OlGokbpvPezMRC2fFlQi9qpRM7VBoY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=blnW1W6P97rLE65z7kKS+8qEg7Dupr2HuEjaGsjO/vMdkmpa0wLcuhw/+XyUqfE19x0PC2+e5E3BEPEOmRx12whl9MICzuYQDYcXap305152zEX+uUN61GNj+ggU3N8tIfgsawf2wcDSwuRepABu0/p4k83kJiFT2se+1vmZQTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Is8WS9WC; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1974322e-8c30-4c01-a566-642ed2bc7086@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742536020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jkcFP/O+Z3B/eFBZgX9t3W8dn1rxY/BeKgw+K5HzFRc=;
	b=Is8WS9WCS7cpn+ZW8U8Ztirrs8LiXCARvLZTKBqwCREJjjVO106Y/obwqU8jG8i+jVcbc0
	NYJXxiklNi+3KK5PO6x6x7f8hlvq0np5te/MH4cjlVVfZush77E5Q7V42GtBskAhF2ssG8
	ljyo1OCA41BDNLGzwROgZTNgVRaHmUo=
Date: Thu, 20 Mar 2025 22:46:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [RFC PATCH bpf-next 0/3] Avoid skipping sockets with socket
 iterators
To: Jordan Rife <jrife@google.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>,
 Yonghong Song <yonghong.song@linux.dev>,
 Aditi Ghag <aditi.ghag@isovalent.com>
References: <20250313233615.2329869-1-jrife@google.com>
 <384c31a4-f0d7-449b-a7a4-2994f936d049@linux.dev>
 <CADKFtnQk+Ve57h0mMY1o2u=ZDaqNuyjx=vtE8fzy0q-9QK52tw@mail.gmail.com>
 <CADKFtnQyiz_r_vfyYfTvzi3MvNpRt62mDrNyEvp9tm82UcSFjQ@mail.gmail.com>
 <08387a7e-55b0-4499-a225-07207453c8d5@linux.dev>
 <CADKFtnThYT4Jp1Nio8iW+uEdj8+khGmAYaLxW-w5LO4tnLZdkA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CADKFtnThYT4Jp1Nio8iW+uEdj8+khGmAYaLxW-w5LO4tnLZdkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/18/25 5:23 PM, Jordan Rife wrote:
>> imo, this is not a problem for bpf. The bpf prog has access to many fields of a
>> udp_sock (ip addresses, ports, state...etc) to make the right decision. The bpf
>> prog can decide if that rehashed socket needs to be bpf_sock_destroy(), e.g. the
>> saddr in this case because of inet_reset_saddr(sk) before the rehash. From the
>> bpf prog's pov, the rehashed udp_sock is not much different from a new udp_sock
>> getting added from the userspace into the later bucket.
> 
> As a user of BPF iterators, I would, and did, find this behavior quite
> surprising. If BPF iterators make no promises about visiting each
> thing exactly once, then should that be made explicit somewhere (maybe
> it already is?)? I think the natural thing for a user is to assume
> that an iterator will only visit each "thing" once and to write their

I can see the argument that the bpf_sock_destroy() kfunc does not work as 
expected if the expectation is the sk will not be rehashed. Is it your use case? 
I am open to have another bpf_sock_destroy() kfunc to disallow the rehash but 
that will be different from the current udp_disconnect() behavior which will 
need a separate discussion. I currently don't have this use case though.

> code accordingly. Using my example from before, counting the number of
> sockets I destroyed, needs to be implemented differently if I might
> revisit the same socket during iteration by explicitly filtering for
> duplicates inside the BPF program (possibly by filtering out sockets
> where the state is TCP_CLOSE, for example) or userspace. While in this
> particular example it isn't all that important if I get the count
> wrong, how do we know other users of BPF iterators won't make the same
> assumption where repeats matter more? I still think it would be nice
> if iterators themselves guaranteed exactly-once semantics but
> understand if this isn't the direction you want BPF iterators to go.

