Return-Path: <bpf+bounces-78273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB5AD06C4B
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 02:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6D42C30116E2
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 01:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDE8226863;
	Fri,  9 Jan 2026 01:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfgr/RA4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49657184524;
	Fri,  9 Jan 2026 01:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767923345; cv=none; b=LuO7pqitpoQU0Pu+zPzZ432Bqz1hwluoBRh0KYQ2BwVAb7kign2XgYsPzzXUPHN+/9Qg2iEzcc3sgx/2raAYi5hhB+te+/kVQtLMBpfvsHu8SxubITof4b0Inj5OIolf1fhaQk7O6rozCmtT00I/0gvTrzpN8GeulDFgotXUSyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767923345; c=relaxed/simple;
	bh=TKAtAkkRkG3fIlVVD7i881OYAVyJfLwxsk9rNKjwkKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JzMh0Rvc52mKRt30oyEqqNvMkxdOvdaI5KvCIYcemEDOgEd1aNkp5X0y3uUnnO4fdsbvjbSg1Oi38rZ5ux7D2YO4q8lKvTX1f/j4XmT2KQOS/g0hOgOHC9z3ORdcw3omhZSwL8xRX2SM65TvSZnqM10HC5L8/GDDwBv7TJyE3mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfgr/RA4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DE1C116C6;
	Fri,  9 Jan 2026 01:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767923344;
	bh=TKAtAkkRkG3fIlVVD7i881OYAVyJfLwxsk9rNKjwkKQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pfgr/RA4t57U139lrC8Rf6eTR9TslDzmFV+X989mU+i4FTTfrc1mnVFv48A+gViZJ
	 TnXGsf3Qpbvz/NDi/gHa1ky+4kKzL5F6W6W/bHx1KklWp8vLuakM119lB1u5LDqGgB
	 9mtuvrFMQQNy5EeFD7wPbj3Jv28lGL36AG3tFIEDhuhUn8/IttJIx1Te45ycuusypV
	 htlT2m4LmgY5hHHzPAURiCahSqsNqmRCN+pxp5qGNjQXBD3hoKAQo1l96usEYi2ipK
	 CZwfDheE9koL+0ta44SRCdjYTOYO3HgAhZoIHIaomumWoJuwOWVF6wXWffhSr2CWl1
	 5PWhbgZ8s2gdA==
Date: Thu, 8 Jan 2026 17:49:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Simon Horman <horms@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next v3 00/17] Decouple skb metadata tracking from
 MAC header offset
Message-ID: <20260108174903.59323f72@kernel.org>
In-Reply-To: <87ecnzj49h.fsf@cloudflare.com>
References: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
	<20260108074741.00bd532f@kernel.org>
	<87ecnzj49h.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 08 Jan 2026 20:25:30 +0100 Jakub Sitnicki wrote:
> Man, that makes me think I'm a terrible speaker.
> Or you just missed my talk :-)

You're a great speaker, but not necessarily listener ;)
IIRC there was no time for discussion

> </joke>

> If it is the overall approach that feels wrong, I'm definitely open to
> discussing alternatives.

To reduce the one-off feeling of the mechanism it'd be great to shove
this state into an skb extension for example. Then if we optimize it
and possibly make it live inline in the frame all the other skb
extensions will benefit too.

