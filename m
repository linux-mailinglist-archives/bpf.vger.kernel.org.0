Return-Path: <bpf+bounces-51083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1D0A2FF36
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 01:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEBE81889459
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 00:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4160514B08A;
	Tue, 11 Feb 2025 00:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uODfralo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E0D22F19;
	Tue, 11 Feb 2025 00:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739234130; cv=none; b=IOMVPYMA+dgLJyfLvSUFAwi6Ur3ZL3DCUt6lo5e3HxbUtnH0/EGSwXa5OWvlLnnTsC6XA2f0kdEK3WfEq1PpLUvATtDlYTof3DuJ8AxURACjfpb06ouMNRHcNw/KwQWXu2bZnH2WVsCivSAmezgOHPrcUJBF69ddfad0JFBNrj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739234130; c=relaxed/simple;
	bh=RJLOvptniuLFOM2SuVPHG71XSa6FSB90+DGF7eT1cng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aFEKNC7J+E1+u7cw+OnqFEs3kiY4yq8g3Bo+0SJdftksp2pCaxmcRLLxmMsUEThVh+OG1/ROlDnfdyAP6/AyysZ51kp63SSfWWKbnV9ViYSD2iF72hsA/T/WGwUYWc4P2YbWzpQfn/LNGAp81WgF8jB5cAZcsJKWWBSxVYAXrS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uODfralo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F91FC4CED1;
	Tue, 11 Feb 2025 00:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739234130;
	bh=RJLOvptniuLFOM2SuVPHG71XSa6FSB90+DGF7eT1cng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uODfralo8jAlCffLiLEwgPlpFGB059bewe3/CMUqh1MVUJaxc5kywILk0ox9buY2Y
	 wvJmVhIhYPbAN9Cme4H+zXP1+ckpgJfqboggN1lpyibvJwl9Tt7T9cbCmIiE9MrCyb
	 9ynjzLlgcBxRv+sFPmq83E56cn8jUFlC+zU13AGqp56Id6GmX3y9V7fqcUiXakfNlK
	 BVB6/qpHcXoCL3Psp8cDGsM9SwXZ1FfqlJvIn1MTvRrMSXMBBLAI9L2iWfGNF3mzft
	 uLImlNR0qxUJ6h60x0TyG+fALgIpIaBMDpYQKgVbqj2jSrwv4HBXEWuJGTW4zDcK75
	 3PK2Lp+GWYUzQ==
Date: Mon, 10 Feb 2025 16:35:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 0/8] bpf: cpumap: enable GRO for XDP_PASS
 frames
Message-ID: <20250210163529.1ba7360a@kernel.org>
In-Reply-To: <7003bc18-bbff-4edd-9db5-dd1c17a88cc0@intel.com>
References: <20250205163609.3208829-1-aleksander.lobakin@intel.com>
	<79d05c4b-bcfb-4dd3-84d9-b44e64eb4e66@intel.com>
	<CANn89iLpDW5GK5WJcKezFY17hENaC2EeUW7BkkbJZuzJc5r5bw@mail.gmail.com>
	<7003bc18-bbff-4edd-9db5-dd1c17a88cc0@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 16:31:52 +0100 Alexander Lobakin wrote:
> This was rejected by Kuba in v2.
> He didn't like to have napi_id two times within napi_struct (one inside
> gro_node, one outside).

Do you mean:

  the napi_id in gro sticks out..

https://lore.kernel.org/netdev/20250113130104.5c2c02e0@kernel.org/ ?

That's more of a nudge to try harder than a "no". We explored 
the alternatives, there's no perfect way to layer this. I think 
Eric's suggestion is probably as clean as we can get.

