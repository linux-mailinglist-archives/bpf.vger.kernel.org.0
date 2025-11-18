Return-Path: <bpf+bounces-74996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD99C6AE37
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 18:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 350A62CCFE
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 17:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24E63A79A2;
	Tue, 18 Nov 2025 17:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r409iXWd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB453A5E86;
	Tue, 18 Nov 2025 17:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763486012; cv=none; b=NkS/JtZOnK6hF7bawM4LLaUI/WSCjet6dppenY5Row++HtlHJEjjp4acvEGhUjyFE7gEhyvJuRCO1R2VGGIGrJ68y/7387il8p1vtpVwVAXhEx6ljLzD3OIpoVfq4GOKPHhT0GCv2kjzB+/+6F6ywsQwmoO0iiKfNGruflfaaVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763486012; c=relaxed/simple;
	bh=ggNhrLVSuJqH6QwhZSmvni68NhR4jn+ys9UmYoZ2dS0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KI5zJmsqk1wXEGXd3dmqSdbsGxK5lg1Hpf4RQpZX8J0KZtbPevq4xdU9KTrctMyHmUDYeXHJv9tJzb+6p5VHohBapOEy9ErJ+d2fFw9il0qRMDaCRTBuf5mUIT7RQVlaVv9Hsg0BPwxzVRRusZ6YIRTFq8k8lm5XjOpUVg1c9jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r409iXWd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80EB1C4CEF5;
	Tue, 18 Nov 2025 17:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763486011;
	bh=ggNhrLVSuJqH6QwhZSmvni68NhR4jn+ys9UmYoZ2dS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r409iXWdNYBga6hQ7E3WWFb7ae2KNM0nZsNpiuC7qlBvrll0LfrENOCdRBrnGQe24
	 O+JM46sKT4thoYF5rSaN4lJespIamyHTIGNyhTFYATdaffmwH58ImmpCBfrOHbKGCz
	 PKMtGB/+zIgRFH0qANQcCJNmIu/wLRGv81lUs5dfYmmGROvI5ws8LJgQnRGY75tYE7
	 3naGu8OSlgAR8kaLPfRs2j/3q5joJ3mjpuS1SujjWwFVMsMZQtZ+x4JAWJn0RUXKzn
	 wflRTOgActJedaD/u8wMYpOWa3GEBa3bWZ5caEbZOqTSRQNQi3F+bl0aupmZLwqmCn
	 4ZJFfaPRcYskQ==
Date: Tue, 18 Nov 2025 09:13:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, Donald Hunter
 <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 bpf@vger.kernel.org, Nimrod Oren <noren@nvidia.com>
Subject: Re: [PATCH net-next 1/3] tools: ynl: cli: Add --list-attrs option
 to show operation attributes
Message-ID: <20251118091328.052c88d6@kernel.org>
In-Reply-To: <e634a466-a968-4422-a30a-49f6261d8703@nvidia.com>
References: <20251116192845.1693119-1-gal@nvidia.com>
	<20251116192845.1693119-2-gal@nvidia.com>
	<20251117173503.3774c532@kernel.org>
	<e634a466-a968-4422-a30a-49f6261d8703@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Nov 2025 11:38:04 +0200 Gal Pressman wrote:
> > Could you try to detect that do and dump replies are identical 
> > and combine them? They are the same more often than not so 
> > I think it'd be nice to avoid printing the same info twice.  
> 
> We need to take care of both cases where the whole operation is
> identical (e.g., ethtool debug-get), and cases where only the replies
> are identical (e.g., netdev dev-get). This kind of complicates the code.

I was thinking just the reply. This is mostly for GET type operations.
Request doesn't exist for DUMP, but for DO it carries ID.

> I'll give it a few more attempts, but maybe this should come as a
> followup to this series.

