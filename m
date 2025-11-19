Return-Path: <bpf+bounces-75080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7FCC6F361
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 15:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 56E0129CFC
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 14:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955C2274676;
	Wed, 19 Nov 2025 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKga0ayy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099BF23A9B3;
	Wed, 19 Nov 2025 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763562009; cv=none; b=VYd+WacHkfyMp9528ODefD+bpX7k7F1AusuxZL57huMYaY68iDU6Z9XGxa8Y27kbSk1kmxxi+jmlRjmGdXeJ3Myv8HAIVX15Ap2kGUG6H+8lA72xmltzQUS34QJqoy2YdIn2mtglBOrlgsdAIxuFO7R1IJuPXBZxLdDBc1oEyWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763562009; c=relaxed/simple;
	bh=VQPkuPmJgnskyZfgM5xh+rZzetRGF05Z17pgdHgELLw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P004kjNXCoKIia3yWLrF9aeIlFCAJyV4w1tvNYam3OWm2f2V+6LPYf97aV7LT2LABsrzfIbJv7KSWe6ZzaD3HMIOS5T4AnoyfQwmc2VXPpnI3/x6dOsRR6s+UHkJzNg4F7O4tL+8pToAwc0Ld9fwW3xeTjpoW0kw0bzUGPh/yLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKga0ayy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A5DC4AF14;
	Wed, 19 Nov 2025 14:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763562007;
	bh=VQPkuPmJgnskyZfgM5xh+rZzetRGF05Z17pgdHgELLw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sKga0ayybmyNwuM4sPXwpK9zwbhAKMHfQq0+AVRdbuxwTJsD+0/vhyoJBBgEoNIOG
	 d0kcyQ0XJnb0+DKkbniJrDGaYMsfRwVK6+/jJsG6upUOcnNcsYpZcz1wMCTkDCHEZE
	 pEPn2zk0e9uXKMOsuQYiENbji9jIA4+PIXk5Ye97qEo+9fBJgSo8aYfSJNlSYqmgMk
	 UcKZJndBOihQSA4FmK25z/6xM7DJimGw3A1gWc1AhXUkhH5PeYkndpvhQtoJqnGx92
	 Jb+DgVdIbWCLUM44IMgm65dyTsA128OdQviH0s8TwOhqGWLNhJXJ6R6l3JeOznhvB0
	 tHbRisPDYT1mQ==
Date: Wed, 19 Nov 2025 06:20:03 -0800
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
Message-ID: <20251119062003.6ccf45f1@kernel.org>
In-Reply-To: <acf74a59-f399-4952-81d7-f99e13785fb2@nvidia.com>
References: <20251116192845.1693119-1-gal@nvidia.com>
	<20251116192845.1693119-2-gal@nvidia.com>
	<20251117173503.3774c532@kernel.org>
	<e634a466-a968-4422-a30a-49f6261d8703@nvidia.com>
	<20251118091328.052c88d6@kernel.org>
	<acf74a59-f399-4952-81d7-f99e13785fb2@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Nov 2025 13:36:09 +0200 Gal Pressman wrote:
> On 18/11/2025 19:13, Jakub Kicinski wrote:
> > On Tue, 18 Nov 2025 11:38:04 +0200 Gal Pressman wrote:  
> >> We need to take care of both cases where the whole operation is
> >> identical (e.g., ethtool debug-get), and cases where only the replies
> >> are identical (e.g., netdev dev-get). This kind of complicates the code.  
> > 
> > I was thinking just the reply. This is mostly for GET type operations.
> > Request doesn't exist for DUMP, but for DO it carries ID.  
> 
> Some dumps have requests, like ethtool's debug-get or strset-get.
> I have a patch that detects identical replies, but it's quite ugly TBH.
> I'd prefer to keep the code as is, but up to you.

It's alright. I'll poke at it after merging, but if we can't find 
a clean way it's fine.

