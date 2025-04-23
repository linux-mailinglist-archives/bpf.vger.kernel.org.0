Return-Path: <bpf+bounces-56469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EACA97B82
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 02:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF551B61424
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 00:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2870A1FAA;
	Wed, 23 Apr 2025 00:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddbpABZZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D97733DB;
	Wed, 23 Apr 2025 00:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745366612; cv=none; b=PMmub82/vwwX+QoQatnpnUbp2ePNOs+slBdQHsktTs2OqqRlO6OgdF9H0gvaUkO6/58vvmIKdnHCuZYOCvFIsffLvAUtEtoPNR7iIFL53wTka+jisOMmhCr/ZoV3+meckbMmkYcy/8TkKP+KNXNBmZRd0L6H3XJW+Jew8gGNfYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745366612; c=relaxed/simple;
	bh=en1R4ZF4hD6JaXdEWowCEJQiD6Q12apOn7tseGVXg44=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tAPYVwcfIyKrtsj8DVmYveFyjk50W1eZWNrjBBumjkcKmCpg3Ohow2xf9x5r856zOVqbbQbVrxdPqVQiDdY7byKr/GKl5xoZqcESbncqVOD2/qRCCrIKgP0/Hy+f1LLPSSNTzeL8zTqiao5TAxWWwbkFAKlmETPy3+ZsRYL2IRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddbpABZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E9DC4CEE9;
	Wed, 23 Apr 2025 00:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745366612;
	bh=en1R4ZF4hD6JaXdEWowCEJQiD6Q12apOn7tseGVXg44=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ddbpABZZ8tQT8CUB8SnkBZ3gfqAxgTU22NsG4tAPnSU7nxi6Fsp7LaFKLPV6qvtYJ
	 20nWbC1PHF7lzRlkdqmjDVyHOn/SIIyJmeu4QCVslwlrV1ytwX1A/k0XT1YDVLJbqf
	 B4RNOtWMpcY+bF86k0OGuh9LTMw6THrGipTGem4/jAMNy8U1h0M9Njz8leaOAz246u
	 EkGf3u+tyjElznWP31cbH3loRNhKFjhbDH28sxAtYCLrfCpXa71k7GmSsVx9rD9YBy
	 pJhl3PiP8smaZs56HFOgUXHrNMYMEXKFe6IMqY8wMdpIdkBbjNWFHdNfNgph8K++Bo
	 b/GgIjTlNYLVw==
Date: Tue, 22 Apr 2025 17:03:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: Allow XDP dev bounded program to perform
 XDP_REDIRECT into maps
Message-ID: <20250422170330.71e47a70@kernel.org>
In-Reply-To: <aAgdECkTiP-po7HP@mini-arch>
References: <20250422-xdp-prog-bound-fix-v1-1-0b581fa186fe@kernel.org>
	<aAgdECkTiP-po7HP@mini-arch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Apr 2025 15:49:52 -0700 Stanislav Fomichev wrote:
> > +	if (map->map_type == BPF_MAP_TYPE_DEVMAP &&
> > +	    prog->expected_attach_type != BPF_XDP_DEVMAP)
> > +		return true;
> > +
> > +	if (map->map_type == BPF_MAP_TYPE_CPUMAP &&
> > +	    prog->expected_attach_type != BPF_XDP_CPUMAP)
> > +		return true;  
> 
> Not sure I understand, what does it mean exactly? That it's ok to add
> a dev-bound program to the dev/cpumap if the program itself is gonna
> be attached only to the real device? Can you expand more on the specific
> use-case?

And an upstream offload which supports it..

