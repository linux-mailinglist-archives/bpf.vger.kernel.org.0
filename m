Return-Path: <bpf+bounces-49150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CA4A14771
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 02:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45E7A160373
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 01:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7CE1F957;
	Fri, 17 Jan 2025 01:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjTQ3yHP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC49033FE;
	Fri, 17 Jan 2025 01:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737076615; cv=none; b=i5ghw+STT0z2let1h1KtYdhHRuQAiCk/H7Tm44Ao3f9AjACa5r2iUjF+02w9YBdajDyy01etwlodWzseTNRKnSMhbteLWoLnc4ybMmj0gwnWY5ViljmDW1lvGN6ZDwHhFGqcJLBEcxe4b62QQytkNhywqMCTXx728S6p3S37yWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737076615; c=relaxed/simple;
	bh=wpGSkA8KU2sbXBmkC8JnCz66wx3cee+PtPWJ+dZqfoE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ebp/UYyYHNuU3HsLPn0hbWU+RgCPzSHEEqxm9ElT+tAceSqePnHix/potir5y5vlbmQC2D/TFXfx+FtXqCigN1aI+FVYdovFWLq8+knKIIKlELdXrvxLgzISZx15g/napUl2lxpSHYVhYwvTCfYxpJxIcCdbFgvjzslDPWZpV3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjTQ3yHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCEBC4CED6;
	Fri, 17 Jan 2025 01:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737076615;
	bh=wpGSkA8KU2sbXBmkC8JnCz66wx3cee+PtPWJ+dZqfoE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rjTQ3yHPvT7ytaCdrDqt8PVEjVTL9Dbw4jW+3jQWaZiZG36V6wjMs0HTy3Tp5l50m
	 WitajvwYsVzpXpjnzZ9sBuk+WHG5g2wko6bjdWocb3Yxl+41Xwcib+14PE53g3nrAf
	 AS4EvmLtTN7NJqTHACXxTYIXdqV081dwr0ST902PxDg47hTugumsDvfLH9FiNMpggI
	 XEAYR+iM5hWzugKkyDXK+pKZknAzbd9OI+AqA6qypJt2q2pjhDuA6KHE1nsruMRn2C
	 Xa6SWnkttBmbsp0LzjjXSEBoAgmTiOAYya6X/glS1W0IzIe4L/AQ/C8Y0FbFBD+Lvi
	 sZ1pn58uYGaHQ==
Date: Thu, 16 Jan 2025 17:16:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Xu
 <dxu@dxuuu.xyz>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/8] bpf: cpumap: switch to GRO from
 netif_receive_skb_list()
Message-ID: <20250116171653.1f1b6fd4@kernel.org>
In-Reply-To: <20250115151901.2063909-4-aleksander.lobakin@intel.com>
References: <20250115151901.2063909-1-aleksander.lobakin@intel.com>
	<20250115151901.2063909-4-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jan 2025 16:18:56 +0100 Alexander Lobakin wrote:
> +		empty = __ptr_ring_empty(rcpu->queue);
> +		if (packets += n >= NAPI_POLL_WEIGHT || empty) {

please remove the assignment from the condition

