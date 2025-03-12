Return-Path: <bpf+bounces-53889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1EAA5DF17
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 15:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC2017B766
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 14:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375B024E00B;
	Wed, 12 Mar 2025 14:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="oEuNhfUS";
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="JQWV4fap"
X-Original-To: bpf@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD9E187554;
	Wed, 12 Mar 2025 14:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790199; cv=none; b=YyS6pz0V6LxixUFMSPcsG6PCSWCx3JRQPF/rnQrKOA4mAbID5qgM/6qdlaIoGxTCB8t/+RAB/n92DJeVpsO32uGQquCo2Vimz57mFa+D1q6/m+OSw9GYhcBHTzzcfX6aWjpgNilIoSGfPzFTUzwPPrSGRaLfUwZz2+2WMjzKGHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790199; c=relaxed/simple;
	bh=ldj3KMi3XaPxZCMznmNtQPshgi9xepQ9J4uFLCANZUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3l90pk73KFO6PlUrDYRoiloYKkANBv96KCcgoHrtyQ2HZ1JsEhoMGtK8Ea35pHmd2/jXH15w+oTrxiL24cCbzwmupc9bEKdLl3pMaI/oUkGRpa/Xe0wAKHdDXd7OsgQVmTwt6iKnsPRIF0TKvDaQ0QZGlxtfRghA1b4uZjB62o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=oEuNhfUS; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=JQWV4fap; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: by mail.netfilter.org (Postfix, from userid 109)
	id 4A15D6027F; Wed, 12 Mar 2025 15:36:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1741790194;
	bh=4Jhu0TA5DYAjWCLQUDu5om3YqGmvRM3uv7cDNm88F8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oEuNhfUSndjiFjkgUNV4nda+rFdq1fICaSob4NxGFUgoF9a5ao7zqSMStdefmjh9U
	 TJC4sQI5CaED63Fi0aS7E7x8KAPq0eV3rH6qt7iG+3kKvYF51VatX8k/dHgqZWez5v
	 Sq0/buG81/0tjdwfftgg7zsgfRj2JKWlTNFrFij/YY2Xhsasy1O1YWeUzIVMV8c1tP
	 1y7a0jF+am0nRdaioQmYlJvhvDUxGuZS5Mfj7YkyGLcRtN3QlCPNrvwZ5LZD0xHV0e
	 Cn0PkiCNCbHOQU4DkFLBzQbWvqbiXgkAydxnMYw1is/1Wc1j3ebH8tgXYz8auHRhzX
	 +G47YIrA8xGWw==
X-Spam-Level: 
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 4EEA16027F;
	Wed, 12 Mar 2025 15:36:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1741790191;
	bh=4Jhu0TA5DYAjWCLQUDu5om3YqGmvRM3uv7cDNm88F8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JQWV4fappayooALiuH9kg3I7Yed8nZy6D2tjAz0LbpQDKbppRm6Sz6PChG0RT8Uia
	 mLg3OuqY1ENvGtBQXXJM07BShHFsFkbr6QTKpVQcbEmLSIEqQ6FLN/v4c61mMyP/Xu
	 i4qyRz2eKDExGWUGuxBkTvrUixhj6UahtyZYJ0euHAmNthto+A/fqQX0Nm7lQG8iIu
	 LqkkUE6oy89wvj7JQxqJjrJ+nl8adZZEakJeO8Mkk7sbhVPpFw7yLUTzI51onprRWO
	 jfDP2q+x/w/sbiU5l74+gLArwqyhogtRjdPt+9wc8pBijxIG7xitRTk38vfETBxSTQ
	 ZI752FWpPShMQ==
Date: Wed, 12 Mar 2025 15:36:28 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Kohei Enju <enjuk@amazon.com>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	syzbot+83fed965338b573115f7@syzkaller.appspotmail.com,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Yi-Hung Wei <yihung.wei@gmail.com>, Florian Westphal <fw@strlen.de>,
	kohei.enju@gmail.com
Subject: Re: [PATCH net v1] netfilter: nf_conncount: Fully initialize struct
 nf_conncount_tuple in insert_tree()
Message-ID: <Z9Gb7O7puuERyyww@calendula>
References: <20250309080816.87224-2-enjuk@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250309080816.87224-2-enjuk@amazon.com>

On Sun, Mar 09, 2025 at 05:07:38PM +0900, Kohei Enju wrote:
> Since commit b36e4523d4d5 ("netfilter: nf_conncount: fix garbage
> collection confirm race"), `cpu` and `jiffies32` were introduced to
> the struct nf_conncount_tuple.
> 
> The commit made nf_conncount_add() initialize `conn->cpu` and
> `conn->jiffies32` when allocating the struct.
> In contrast, count_tree() was not changed to initialize them.
> 
> By commit 34848d5c896e ("netfilter: nf_conncount: Split insert and
> traversal"), count_tree() was split and the relevant allocation
> code now resides in insert_tree().
> Initialize `conn->cpu` and `conn->jiffies32` in insert_tree().

Applied to nf.git, thanks

