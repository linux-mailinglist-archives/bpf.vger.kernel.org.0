Return-Path: <bpf+bounces-13382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F407D8CD5
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 03:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D333D1C21026
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 01:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984D817D1;
	Fri, 27 Oct 2023 01:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8ULpVB2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0804910E9;
	Fri, 27 Oct 2023 01:35:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DEDAC433C9;
	Fri, 27 Oct 2023 01:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698370510;
	bh=bX9iU4fJgIDvj2HWp6daGLv3deXYF2h0HetQpc9+0ws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E8ULpVB2szSNjiimxwDdpqQ7/y50Vy5gaepRQ1zMcjyzaJr+u1x9/rGpRRwTyyQom
	 JjS/J4y7wLsU1sLY/Mkt8ERaCb2Tm0F9NujixEJymkKKvdwQSqtHyGx+H0pDc1kBmR
	 BhZKJubNxV6Jbs1kVqzAH7HEJYCVEPini/b8qXezcnjtSgeZRlupK0v9dh9nSFjkwc
	 YzihAdlJ2TmKfLgxNFhLeiNmGY8Y/wxn55879UEibWHLEYuD2dwRnULfGlms+6+X9C
	 gDmA+k/6tYF8W2eXlt6p9nUHzQ6huGAOJMsoxzthUT0WfB2XWxTqsOvrvAP//qPDVK
	 /jPev5yg23Aag==
Date: Thu, 26 Oct 2023 18:35:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Vadim Fedorenko <vadfed@meta.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: add skcipher API support to TC/XDP
 programs
Message-ID: <20231026183509.471af050@kernel.org>
In-Reply-To: <a10cdab4-ab67-1cd2-0827-52c3755a464f@linux.dev>
References: <20231026015938.276743-1-vadfed@meta.com>
	<20231026144759.5ce20f4c@kernel.org>
	<a10cdab4-ab67-1cd2-0827-52c3755a464f@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Oct 2023 00:29:29 +0100 Vadim Fedorenko wrote:
> > Does anything prevent them from being used simultaneously
> > by difference CPUs?  
> 
> The algorithm configuration and the key can be used by different CPUs
> simultaneously

Makes sense, got confused ctx vs req. You allocate req on the fly.

> >> +	case BPF_DYNPTR_TYPE_SKB:
> >> +		return skb_pointer_if_linear(ptr->data, ptr->offset, __bpf_dynptr_size(ptr));  
> > 
> > dynptr takes care of checking if skb can be written to?  
> 
> dynptr is used to take care of size checking, but this particular part is used
> to provide plain buffer from skb. I'm really sure if we can (or should) encrypt
> or decrypt in-place, so API now assumes that src and dst are different buffers.

Not sure this answers my question. What I'm asking is basically whether
for destination we need to call __bpf_dynptr_is_rdonly() or something
already checks that.

