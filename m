Return-Path: <bpf+bounces-45960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 353EE9E0F03
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 23:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5330B2397D
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 22:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075691DF97A;
	Mon,  2 Dec 2024 22:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQKpE+OQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBA32EAF7;
	Mon,  2 Dec 2024 22:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733179661; cv=none; b=FQkV6nbYSIAGZFguAxoTWFN9C0mP/bj5/Cjazp415XYCNPGegMv1IshCAI57qUcWPOoIm1sW3WQEE7+Bva6976MQEFtUGDGk1+aq1tVS8o0tfIy8YisZuxBYlu//NcL5m4yDNivPQ75mykZRowVvn/nz/nOlsUayy5kWZWd4oEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733179661; c=relaxed/simple;
	bh=5V9dNA/lg2vKIQqYisN0pggYDLsi/k90WZhdNW3xD0c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bhb0yWKk0d17ePEKrUCUaI76PP9kWbQ4yIzjA6ZwGwcwIlltABcaC2L6H0+eIlYdmIFQ8miXq232JjwQ6h4d5jL+dxzP04uoWaq8xdOfY/GhmLahLImWNNyzqxa52DAMHKFJMUiN56ehKJ2MebZSnBfDj9K/ypemy+mGx4IAkeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQKpE+OQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B446C4CED1;
	Mon,  2 Dec 2024 22:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733179661;
	bh=5V9dNA/lg2vKIQqYisN0pggYDLsi/k90WZhdNW3xD0c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NQKpE+OQHkS0cQU7S6/YePYZeLoIfBoG3D9PYAO/tQo/HxxE+zqAdAmYkblsB1Z72
	 d+O9L+ogzm+WZQ1UyBAkJQcEUxtQ7ZG5uZe1QxsYElBG9BjnBXeme6YRUEIiIRU01d
	 OMrPJZs83eyjysnuar6/ynWsOlvtBCJlctS6IcS5S0W7G0nlhuU3PsguSJV808Oa1b
	 PTGn1auDScjzK/78zbW5tV3jaLkTXfjCe8cq2eODBH1c/UVhMhDYZ9mffQgu6J9ek1
	 pAgUbsfsKgu876+U1B10+McVJFjdeL52ES9TSphLdtje9DN6738SRySpfNmPFXkZnV
	 nH8Uw+PeHXjcQ==
Date: Mon, 2 Dec 2024 14:47:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, "Lorenzo Bianconi"
 <lorenzo.bianconi@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, David Miller <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>
Subject: Re: [RFC/RFT v2 0/3] Introduce GRO support to cpumap codebase
Message-ID: <20241202144739.7314172d@kernel.org>
In-Reply-To: <6db67537-6b7b-4700-9801-72b6640fc609@intel.com>
References: <cover.1726480607.git.lorenzo@kernel.org>
	<amx5t3imrrh56m7vtsmlhdzlggtv2mlhywk6266syjmijpgs2o@s2z7dollcf7l>
	<ZwZe6Bg5ZrXLkDGW@lore-desk>
	<55d2ac1c-0619-4b24-b8ab-6eb5f553c1dd@intel.com>
	<ZwZ7fr_STZStsnln@lore-desk>
	<c3e20036-2bb3-4bca-932c-33fd3801f138@intel.com>
	<c21dc62c-f03e-4b26-b097-562d45407618@intel.com>
	<01dcfecc-ab8e-43b8-b20c-96cc476a826d@intel.com>
	<b319014e-519c-4c2d-8b6d-1632357e66cd@app.fastmail.com>
	<rntmnecd6w7ntnazqloxo44dub2snqf73zn2jqwuur6io2xdv7@4iqbg5odgmfq>
	<05991551-415c-49d0-8f14-f99cb84fc5cb@intel.com>
	<a2ebba59-bf19-4bb9-9952-c2f63123b7cd@app.fastmail.com>
	<6db67537-6b7b-4700-9801-72b6640fc609@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Nov 2024 11:36:53 +0100 Alexander Lobakin wrote:
> > tcp_rr results were unaffected.  
> 
> @ Jakub,

Context? What doesn't work and why?

