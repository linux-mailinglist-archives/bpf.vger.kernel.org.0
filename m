Return-Path: <bpf+bounces-45963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BE19E0F17
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 23:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14C71608B2
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 22:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E711DF98E;
	Mon,  2 Dec 2024 22:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bu1iqiTD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8010F2EAF7;
	Mon,  2 Dec 2024 22:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733180336; cv=none; b=OfdlGj02fC+5mMuStmj+h32jenBlMtx44Xnnbrkm9E3YBgscgOiJoELXpM2Gmj5U31KFIdSaStTaSbKwWV4OKXBWRssy4OxFGIQk4ANT5Vi8bQATWbfoZUE8RW1/IfRWuSUSLPMM2LBtlViZRJNur7vdrbFzTYzDelW3Im1ica8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733180336; c=relaxed/simple;
	bh=1VzEi2nqGyMZNDunTcDAuIXyBtSCNj+h6tD/vJwsfbg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UfLJ0jOpaIV7u3HdUlVBB9OAWRC7n91iTFiysh7fJQKeZL9BVWlqqEyJlphYQECXp8l2PAgdKhQx9IW83AHXC8MDzq+8mx8GjfTvvFOFOZRx+SJMdvwDGV0jaHccBEqGihyHaDgCwyCBQ9Yp2cQE3qu3R4XD6G4PPArdeMBC33c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bu1iqiTD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93B4C4CED1;
	Mon,  2 Dec 2024 22:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733180335;
	bh=1VzEi2nqGyMZNDunTcDAuIXyBtSCNj+h6tD/vJwsfbg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bu1iqiTDoMQHUj+1BclX0BBPCnFD00ze43u7eOzY4h/k1ymm+Sk2kCGaSX/Bc9q99
	 Jt8GUKRbXdBYnlmqD8OUmGVLE79Dt0D/ZRSMk7RsbSIUNT/62ugkb09xhFl7x3nUB7
	 obCQeV91X3QJJkT+xY5iQ3cfQ1m3ti+BDAyisWGFsitqusPtPGvx655DLXRCsINNeT
	 hna2rZTrV6QTdYFOUAGHLpQTW8BrVY45w0j9JBNIOS7QxsuPpMzgL9EX748Bvh5Ls9
	 PJY1jxxlPSOj3FWYd3fU5mJ4tyZ8Dhjd9eGd2wEU3G69SHrVBVC08q58IVxR6Kyc7c
	 Uro9IO+4kBVeA==
Date: Mon, 2 Dec 2024 14:58:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>,
 aleksander.lobakin@intel.com, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 3/3] bpf: cpumap: Add gro support
Message-ID: <20241202145854.6677e5fd@kernel.org>
In-Reply-To: <20241130-cpumap-gro-v1-3-c1180b1b5758@kernel.org>
References: <20241130-cpumap-gro-v1-0-c1180b1b5758@kernel.org>
	<20241130-cpumap-gro-v1-3-c1180b1b5758@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Nov 2024 00:11:00 +0100 Lorenzo Bianconi wrote:
> -	struct task_struct *kthread;
> +	struct napi_struct napi;

nack.
Please wait for the discussion to finish before you send next version.
-- 
pw-bot: cr

