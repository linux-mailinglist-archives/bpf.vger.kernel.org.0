Return-Path: <bpf+bounces-78659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDC5D1693B
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 04:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 761FA301F274
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 03:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53B532548B;
	Tue, 13 Jan 2026 03:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSDyqkJS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332BA2E0925;
	Tue, 13 Jan 2026 03:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768276757; cv=none; b=cYaRTxrchjYMM4eXJRmF7l0+zAXIObStfQIujdo73GXbNzCmHUmT3DSk1lRK7+oWC7nyjhHXGUDNroqbObXB4vcDfd98m6SKzkiE2G7ZOODzPTkDEcTtukrSbrEqZUtyjBzQ5q4Gt3XUHBY7PJp8xG2jPwUTHT0eC0jHIh9XXoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768276757; c=relaxed/simple;
	bh=bCWEYvlNFrSoem75fMA53D5yOUaAsEpfAtzyTLX6/F0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AzOzW3YOKzQM1uVmBJ+4igceVhqj6qQkDLRxv0tKTeppzPdsOb3VsY4frlmPxls4NSRo23oD6fCX/2JRi309UrBiDNTHg8mTlu8O5qE7+a8mPy1JI8tAd3s1x4o9g+UL9+h3qvU1ggjxLlWOm7D8gtV+vC4txO25T0TOeC992Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSDyqkJS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F13DC116C6;
	Tue, 13 Jan 2026 03:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768276756;
	bh=bCWEYvlNFrSoem75fMA53D5yOUaAsEpfAtzyTLX6/F0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fSDyqkJSsKLMraV+Vfp1Zs98tg2VL7hK0n1RN120OS4UfgNdJsv1vWhqespclt29s
	 Vo6nbwLnm/KX2g3/iIqOuxU0YFyRAxBCnZ6EGZBt4s+CAZqEZ9vKHgJeG+z78NbSH7
	 sVhEGzymM57xiRervTtU9lXOlV2Mc1CLoWqIyeG6FEpgMi9FW3KmWAtIe8qD2wKST0
	 i8M+8sr49NrXWy79a8TDCOhAEMaJQ+NRrFyT49xwZfT3K4Sldv8WNHM/0BPE/Lng6p
	 oHyDZ/JctTEFn/TnUIJ5TrfsSnK8k3ZJpZdaaDYwtyNTtb/QWONmwUoXVrhpMKcmov
	 /+NiH158ZNAWQ==
Date: Mon, 12 Jan 2026 19:59:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v5 15/16] selftests/net: Make NetDrvContEnv
 support queue leasing
Message-ID: <20260112195915.5af68b2d@kernel.org>
In-Reply-To: <20260109212632.146920-16-daniel@iogearbox.net>
References: <20260109212632.146920-1-daniel@iogearbox.net>
	<20260109212632.146920-16-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Jan 2026 22:26:31 +0100 Daniel Borkmann wrote:
> -from lib.py import cmd, ethtool, ip, CmdExitFailure, bpftool
> +from lib.py import cmd, defer, ethtool, ip, CmdExitFailure, bpftool

tools/testing/selftests/drivers/net/lib/py/env.py:10: [F401] `lib.py.defer` imported but unused

