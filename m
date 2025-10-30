Return-Path: <bpf+bounces-73043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A41C21111
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 16:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1A83AD7B3
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 15:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146AF321F48;
	Thu, 30 Oct 2025 15:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edkEQwtJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864A42D97B9;
	Thu, 30 Oct 2025 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839737; cv=none; b=FyH0iHgeNyu/kh/lJ4Z60S/Jk0utEzgFe7NLz3F2O5W4j6DVIJV3RcwNT63PWa/0p9/0JURUUQaWGkZlLfIWicUYTjjI8ze95YUbdYdt8ibH73c7kKA5Pz6samWkQvCx9+RCOhlE1ZMVPVFJNCmfjv6/XBihqKkd4P5IhI/iijo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839737; c=relaxed/simple;
	bh=lGCUohRp6hJAKwlqRVvL36r3Y9On03CdokfXh8Ty36w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JynTonga1dbxnaSVd/Cra4dE+6fNsh0lBq0+LzNZr71an0eXC0XsxWHw7lGUjDdl9ivcQNFWR93e84P62TmOTkEKH66feOoUpOvYhGltdNOrveuKrG9pkhilo7NtKq4NTC95fegkKAd6bEyTkIobj7wVDjrpdaDVoZSLKUQ1UeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edkEQwtJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E53C4CEF1;
	Thu, 30 Oct 2025 15:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761839737;
	bh=lGCUohRp6hJAKwlqRVvL36r3Y9On03CdokfXh8Ty36w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=edkEQwtJIioNRgjivyENkbUddl8JboBZ0Cn7LYJLMcr9SrygqxumaOEcfFSt05gp2
	 f2FOwxYONMMCUKJM5H5A9KL65QBnveQaHmfNSCseEBIoL3zKO+4pGTA2Pmz5/Be3xe
	 E6PlPNbj8ze4euinSh2w1N1s2ssRAGaGpfG4M6o3Ob0VWbg6fsnUIGbP8/JnAIGKZG
	 EyUqjd0oHcQQw/WPz09Vuo7V095gczT/BfTTnQtYzAi/2AwH0dA4XD1IWtTrxTezvt
	 IIynf7NkqcGYPBlTv/nQ9UtesvZNxo9153CNwjRgGWxRqGomGNKfVpnw3w1a9ojt5f
	 32m44JI/mY/Eg==
Date: Thu, 30 Oct 2025 08:55:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jason Xing <kerneljasonxing@gmail.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <bjorn@kernel.org>,
 <magnus.karlsson@intel.com>, <maciej.fijalkowski@intel.com>,
 <jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
 <joe@dama.to>, <willemdebruijn.kernel@gmail.com>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v2] xsk: add indirect call for xsk_destruct_skb
Message-ID: <20251030085535.4f658dd8@kernel.org>
In-Reply-To: <e290a675-fc1e-4edf-833c-aa82af073d30@intel.com>
References: <20251026145824.81675-1-kerneljasonxing@gmail.com>
	<54d1ac44-8e53-4056-8061-0c620d9ec4bf@redhat.com>
	<e290a675-fc1e-4edf-833c-aa82af073d30@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 11:59:58 +0100 Alexander Lobakin wrote:
> >> managed to see a huge improvement[1], the same situation can also be
> >> applied in xsk scenario.
> >>
> >> This patch adds an indirect call for xsk and helps current copy mode
> >> improve the performance by around 1% stably which was observed with
> >> IXGBE at 10Gb/sec loaded.   
> >
> > If I follow the conversation correctly, Jakub's concern is mostly about
> > this change affecting only the copy mode.
> >
> > Out of sheer ignorance on my side is not clear how frequent that
> > scenario is. AFAICS, applications could always do zero-copy with proper
> > setup, am I correct?!?  
>
> It is correct only when the target driver implements zero-copy
> driver-side XSk. While it's true for modern Ethernet drivers for real
> NICs, "virtual" drivers like virtio-net, veth etc. usually don't have it.
> It's not as common usecase as using XSk on real NICs, but still valid
> and widely used.

To be clear my main concern is that the XDP<>skb conversions are 
an endless source of bugs and complexity. We have one fix for XDP->skb
on the list from Maciej and another for AF_XDP from Fernando which
tried to create an XDP skb_ext. We are digging a deeper and deeper
hole with all this fallback stuff, and it will affect performance
of both normal skb and XDP paths. Optimizing AF_XDP fallback is
shortsighted.

