Return-Path: <bpf+bounces-71983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6352C04214
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 04:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217B819A831D
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 02:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313CE258CF2;
	Fri, 24 Oct 2025 02:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sEbM0VPc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53E114B06C;
	Fri, 24 Oct 2025 02:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761273215; cv=none; b=Y60CWEan/CvIGLaWPmeyODYved7WdNQUXaEqh1puCTZrIeXXWxZj0UJHAMA15HzqZhCAARoYRBSUaq3fSzihNkptepW7krto61p5q79SL6X1HbUtkwy+3Ae9RvhvEXtsjth84YUnfM5MKIE7Ytz/J2v9XgNov2u4P3EN7QsRuTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761273215; c=relaxed/simple;
	bh=W/KT21MQNUqapK/Ahwzqaa0gMdtJzy5ORU3UJ8PpDEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dKLsYPBtXBpnMtP3XvL3aSg37YVqPynMLsIMRofO9Dm+JB+Vi/HocD4kDA+mxC/Rf1sFWkhGfcOqysi4gIB1hgnWN2QfplVbN/oS98/TgaxO/Z/EyNqhdIfKZYqbTkIWrCtRAt6jMO/URNwVy5Fljd0LdHc8Lpf++jQ/VUjl2fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sEbM0VPc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C82C4CEE7;
	Fri, 24 Oct 2025 02:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761273215;
	bh=W/KT21MQNUqapK/Ahwzqaa0gMdtJzy5ORU3UJ8PpDEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sEbM0VPcf7wO8u21Ib036Ne5nV6tTYDWNpxmGJsiBYR35wBWvP7qfdKy0jRt3TNOg
	 4ZiERZHZd9zcE01EWAIqva4bmb8cop7sRF7Sh6UjOLQG7RbHHL/pDmT+qn22pg9lPb
	 o6pANc97iihha/4DVyemEVCGIL9ov07HbJ6xix/Fp7bicHAPts9Tkuf1MGZoCBC1y9
	 ZvSPC6lkh/tZMu4A+5Mp2lampm9tyPY83mulHnMQhOPKnbS+Xm5h50JTQFVNHKpTjt
	 Q9u5RR273h/x25m7P0Hk+b1UZnBoJvIdTfaMH/9tHjHm7KK4uWpuxHsnZdo17zmUm3
	 HMZ/0NkY5mLcQ==
Date: Thu, 23 Oct 2025 19:33:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v3 03/15] net: Add peer info to queue-get
 response
Message-ID: <20251023193333.751b686a@kernel.org>
In-Reply-To: <20251020162355.136118-4-daniel@iogearbox.net>
References: <20251020162355.136118-1-daniel@iogearbox.net>
	<20251020162355.136118-4-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Oct 2025 18:23:43 +0200 Daniel Borkmann wrote:
> Add a nested peer field to the queue-get response that returns the peered
> ifindex and queue id.
> 
> Example with ynl client:
> 
>   # ip netns exec foo ./pyynl/cli.py \
>       --spec ~/netlink/specs/netdev.yaml \
>       --do queue-get \
>       --json '{"ifindex": 3, "id": 1, "type": "rx"}'
>   {'id': 1, 'ifindex': 3, 'peer': {'id': 15, 'ifindex': 4, 'netns-id': 21}, 'type': 'rx'}

I'm struggling with the roles of what is src and dst and peer :(
No great suggestion off the top of my head but better terms would 
make this much easier to review.

The example seems to be from the container side. Do we need to show peer
info on the container side? Not just on the host side?

