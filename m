Return-Path: <bpf+bounces-49145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F4BA1471D
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 01:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D91C73AA8C7
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 00:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035902AEFB;
	Fri, 17 Jan 2025 00:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XC6jD6go"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7200427456;
	Fri, 17 Jan 2025 00:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737074990; cv=none; b=LHV306eb6dd6tyAuk19tZTWYCCo41y8aRr0/REGMhLtRWyP0wuXowklS5azxs0cu/5Ay7JLsLeNDIg3lhsbwaIMGPNtUKz3mGS5EwklVoiV8/5Z7NaLSzhED1UQj71wA7RqAUGEmJ7R0M6L0iB3dAWHB6F/lEaiGZEnwbZnyDrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737074990; c=relaxed/simple;
	bh=aoyvKN0iAO2WS0loA6/samuHz5/CUn6rUL1rTHs7cuo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i5isZvRNqGeLemSHlvKMbY3abzWUCquIW+yPQ/RRVpW+B/uLovoUlqt7YqzQPtnJMXUNFGgtHLrak1XjD7gx1LKVNf94jFD3mqQaDTcKxjoCwZEEcjd2+WaohjwgdY6I3Q5nwXxEhIvch6rPAhAyejSH4L/a7k6qQGCqsZhKRQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XC6jD6go; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EECAC4CED6;
	Fri, 17 Jan 2025 00:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737074990;
	bh=aoyvKN0iAO2WS0loA6/samuHz5/CUn6rUL1rTHs7cuo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XC6jD6go3CuftN+YzjZ64PLRPxSlzVA1/fBlZ1wSOV0NuJedTV+/10qGzeegf8N4W
	 V6wCWLy0qxrQqb1LPRK6WwUBvGgMzIlnngvEAR+HTsO+9QNH3HbOTwGmr8c0itaU1K
	 XNXv2HBMNUzXzErond5kBstD/kaENYb1r+wya32YST5lSdQ1uAmzE2LF7M6URvf4+i
	 WMh9OWcQDBTvxkypyRfc7EaOYEHz5gAL2kIB5NciviajT8Xd82wNn2tTCEhCg9Grzq
	 GYFDGN1NYSckhGXWou90u8vIXu+10TeTZREKaRj81yWlli7lQRj0NY+jcmynp22iLO
	 ZRTGuXdN1+HGw==
Date: Thu, 16 Jan 2025 16:49:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 srk@ti.com, danishanwar@ti.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: ethernet: ti: am65-cpsw: streamline
 .probe() error handling
Message-ID: <20250116164948.5a7f4fd4@kernel.org>
In-Reply-To: <c0a72a9a-3c1e-4bdf-9647-6cb9d962fad7@kernel.org>
References: <20250115-am65-cpsw-streamline-v1-0-326975c36935@kernel.org>
	<20250115-am65-cpsw-streamline-v1-2-326975c36935@kernel.org>
	<Z4ga6N7brU1FrQzx@shell.armlinux.org.uk>
	<c0a72a9a-3c1e-4bdf-9647-6cb9d962fad7@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 14:07:40 +0200 Roger Quadros wrote:
> Another motivation for doing so was this paragraph found in
> Documentation/process/maintainer-netdev.rst:
> 
> |Netdev remains skeptical about promises of all "auto-cleanup" APIs,
> |including even ``devm_`` helpers, historically. They are not the preferred
> |style of implementation, merely an acceptable one.

FWIW, the devm_ part of this is mostly to stop people from posting
"devm_ conversion" patches for some ancient drivers. Most devm_
uses are perfectly fine.

But as you pointed out, if you have to free the resources manually 
as well the devm_ scheme becomes a distraction.

