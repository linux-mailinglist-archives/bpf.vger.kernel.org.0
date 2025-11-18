Return-Path: <bpf+bounces-74842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5826DC66D9C
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 02:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2271D4E1B83
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 01:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9842D3A6A;
	Tue, 18 Nov 2025 01:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjAb2Qi1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B156D1EB5E3;
	Tue, 18 Nov 2025 01:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763429894; cv=none; b=h+XeumgKIcLY5pNygNPipKloDpPXkxPnWwdfTvt0P9gmsKwgySjh9jRL6Lg5KM/5I3iQ75lDdRCLdG5Fg48auDug1VEbXZSXwoTtdgGNcLKijhXuethdeeGY3LHJSaoLTpqtx7EWE4XOMG8Cg1Lf45sKQkmtoRWMlUjdB+87RH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763429894; c=relaxed/simple;
	bh=wljjnQ89dc13vqxN1wOQ/q+yKNWHzy1Tmf9Re2+eT3w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ctob+x8NKvqJdkXkd6Dt75XFaF580ykC4REqtFFltBJaajB/Yj29RF3Gl/itAYhehuNnXsR/2mcigjeTMy7gThHyn2Mpid+Y4hNn8vr1SMwbP9Img1AAieYNVxgDHF5cDBrSCM7bcKKtd0dDW9QUCe6A7CqazuO+wYbMeJKA5rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjAb2Qi1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E59C19423;
	Tue, 18 Nov 2025 01:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763429894;
	bh=wljjnQ89dc13vqxN1wOQ/q+yKNWHzy1Tmf9Re2+eT3w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qjAb2Qi1CwJZ0124keP5R2t7WiCAGLHMYJB2xv1NWYvUrDbmCn7AmNGj9RvOeoq/B
	 RTVR7jMvQ8KShPCGIWhaMaQLO+imeNRS+Bl0cok5ENYIObMM7cOqtsAA1ecMQCi4nS
	 Jq5ITQzC7HVOglUyh04LYBu069OeRTKWLe2qxIkicge6WpsgcKivB0QfaZdUxUpSKH
	 HnhWy1Q4UWbeUjM3BMhsVwAr2pmD8BwucSblB8HJJKXABm5bn3IU64w+pF4YtL3+Su
	 z8hdB8537iN+DoGmymxVMOZgDTwKETl+VyuqUfbQXmErHYvA5lTP59HHTBfhVbQ0lm
	 JUyVbrk8JJw8A==
Date: Mon, 17 Nov 2025 17:38:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 <bpf@vger.kernel.org>, Nimrod Oren <noren@nvidia.com>
Subject: Re: [PATCH net-next 1/3] tools: ynl: cli: Add --list-attrs option
 to show operation attributes
Message-ID: <20251117173811.0b600b80@kernel.org>
In-Reply-To: <20251116192845.1693119-2-gal@nvidia.com>
References: <20251116192845.1693119-1-gal@nvidia.com>
	<20251116192845.1693119-2-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Nov 2025 21:28:43 +0200 Gal Pressman wrote:
> Add a --list-attrs option to the YNL CLI that displays information about
> netlink operations, including request and reply attributes.
> This eliminates the need to manually inspect YAML spec files to
> determine the JSON structure required for operations, or understand the
> structure of the reply.

I _think_ these two pylint issues are new / should be fixed:

tools/net/ynl/pyynl/cli.py:166:0: W0311: Bad indentation. Found 16 spaces, expected 12 (bad-indentation)

tools/net/ynl/pyynl/cli.py:166:42: E0606: Possibly using variable 'op' before assignment (possibly-used-before-assignment)
-- 
pw-bot: cr

