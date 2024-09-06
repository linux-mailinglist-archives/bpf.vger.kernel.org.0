Return-Path: <bpf+bounces-39087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2679896E6BE
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 02:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D90A5286B9D
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 00:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D257D531;
	Fri,  6 Sep 2024 00:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6HGSkX4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF70513FFC;
	Fri,  6 Sep 2024 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725582032; cv=none; b=gTAf7bOtir9N8tWQCJ9spuW2QFwO+nyHe3+qUqmlhRXm604EgwwYyHdGI+8Q6mUfiiRu6oW0aJ2ubYZyKirulMuXpS612p0mstEbfLNDSX7W482zvacEAaeahHk20DLUPp0CMqLTQ3LNwoOCmcHaDcqLQntGBvEI1Mxtc9WNkXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725582032; c=relaxed/simple;
	bh=4V8o7Ima5HsTiALZdyULmSsGXq6cAPqQaG4Zo+80WXE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8aP6MINEbAErjWGyVdUQM+LA7QJdO6AmF0PL1nSC8udLxVdPobAMct8eYhej6bBc22eUIFf/Y7Eo6YDFkoC4TSe8PAbA7txZXub17z0fHMHxa17ZD/RLW2wLC/99DgKlcRgKyTECYnHiMaaX0zOgFNFi3LwYRHDIa/7AmN4rM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6HGSkX4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87D2C4CEC3;
	Fri,  6 Sep 2024 00:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725582031;
	bh=4V8o7Ima5HsTiALZdyULmSsGXq6cAPqQaG4Zo+80WXE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A6HGSkX4KQQoEijgosNXs2DSkeWoJaozDuYE7kgCzE/dzlneEBElxw3Az9zZ+P1Fh
	 YW6ChfTAUGhMlq3fEQdypw9p1PHAfXdE3WGwZ1tOAnGEmxqnWWICfrqJfc1scCYSA9
	 ibit0x6LAGy8nkTWTyCMkbpYb42/4WQXLIA2ixWt4Llizm+42ssMp7H4SsEsjNrs1b
	 dz6HrcdqR/dg6pw2TuH8dkKw2kyEXStCCes+dW57UxTP4SWzK0SxnAmxV/yQSLCiDN
	 rXgnGx7KACi5uOYJaRRWSCQoLRC4vBwev4agIZnqRD80Wj8dEa7mKOz2MnelvRYhoX
	 9JtaaZXYqlQmg==
Date: Thu, 5 Sep 2024 17:20:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, John Fastabend
 <john.fastabend@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/9] bpf: cpumap: enable GRO for XDP_PASS
 frames
Message-ID: <20240905172029.5e9ca520@kernel.org>
In-Reply-To: <Ztnj9ujDg4NLZFDm@lore-desk>
References: <20240830162508.1009458-1-aleksander.lobakin@intel.com>
	<20240903135158.7031a3ab@kernel.org>
	<ZteAuB-QjYU6PIf7@lore-desk>
	<Ztnj9ujDg4NLZFDm@lore-desk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Sep 2024 19:01:42 +0200 Lorenzo Bianconi wrote:
> In particular, the cpumap kthread pinned on cpu 'n' can schedule the
> backlog NAPI associated to cpu 'n'. However according to my understanding
> it seems the backlog NAPI APIs (in process_backlog()) do not support GRO,
> right? Am I missing something?

I meant to use the struct directly, not to schedule it. All you need
is GRO - feed it packets, flush it. 
But maybe you can avoid the netdev allocation and patch 3 in other ways.
Using backlog NAPI was just the first thing that came to mind.

