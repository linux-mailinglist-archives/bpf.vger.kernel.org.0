Return-Path: <bpf+bounces-37232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F28B95272E
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 02:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305601F2194B
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 00:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBE61878;
	Thu, 15 Aug 2024 00:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7TldrFL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89681362;
	Thu, 15 Aug 2024 00:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723683214; cv=none; b=tEE+Fqc3nzrxu1avswbfKfq5IDANwznqtNNbH7YUTSjj9OUKe2tB5QzxNEU+RbOFaCmg8ffSpoMrWzSxfQ9z0UA9i90I4dfFeV+ObgtBba1DMdgG7W1mQ1AqmL1RLo+xjWjQpvwvdv7px/7dXpv1TqM85qoriS2b9QlI7oZDWsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723683214; c=relaxed/simple;
	bh=fQQ7RAC1Q4Q3MLAxhDAoVqBcLxpuT2PExNe+KLXKew4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SIQyaOPQq9KW4ebozaLY6EkWCdUyqJozc++6XgjlSeHnu8RYDSUpYzpR0BlimhWv2y8URRDRcGMUSmsjaeyI7y4zFmekhfkehKWOJupelBSE/ouzjdr1qIhKDAAb5P2Ykw3uSTJp+S8AIjhnmw3PUXwGVTZm9Gt9uV+marm6DzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7TldrFL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFED7C116B1;
	Thu, 15 Aug 2024 00:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723683214;
	bh=fQQ7RAC1Q4Q3MLAxhDAoVqBcLxpuT2PExNe+KLXKew4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m7TldrFLR1+y2FcB3TPKoYS4zwqCceHmiAQXSLtqyvd/+oToHTYI1gNFRvFVY3LUt
	 fsxGAmhkss/hXOSmK7L0ndVR9MddAUYddxt4qd22yaDvKM4gHWFyZH8xIuogNX2YmM
	 G7DGNAaQVAc+Hc8CJn8s8E3DZT3rb+Aj//CMHRGhrExY2D4QV4TUNdjCktT72NCOFc
	 8XYw+cIU3+xyDguVaf9Iod8m+E9PSBhICGs+NadlLrCUb+tHn+bCxZ/ElpJBJdsl4A
	 UWE+iHy03wXEdVhOUrVIO4N/VNKkgwuSZCXNFi11HXYjfCuCNmvv7loqIsRx3zFY4f
	 2QeHjA4hpMMGg==
Date: Wed, 14 Aug 2024 17:53:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet
 <corbet@lwn.net>, Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: bpf-next experiment
Message-ID: <20240814175333.6bcaa522@kernel.org>
In-Reply-To: <CAADnVQJgwGh+Jf=DUFuX28R2bpWVezigQYObNoKJT8UbqekOHA@mail.gmail.com>
References: <CAADnVQJgwGh+Jf=DUFuX28R2bpWVezigQYObNoKJT8UbqekOHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Aug 2024 12:32:00 -0700 Alexei Starovoitov wrote:
> Couple years ago folks suggested that bpf-next should be
> a separate pull request to increase subsystem visibility.
> Back then we rejected the idea since many networking related
> changes required bpf core changes. Things are different now.
> bpf kfuncs can be added independently by various subsystems,
> verifier additions are mainly driven by sched-ext,
> so it's time to give it a shot. It's an experiment.
> If things don't work out as expected we will go back to
> the old model of feeding bpf trees through net/net-next trees.

Excellent, fingers crossed :)

