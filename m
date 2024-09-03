Return-Path: <bpf+bounces-38833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B88096A99F
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 23:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 457F01F226C4
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 21:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F1B1D7E55;
	Tue,  3 Sep 2024 20:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzrhLSnR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280F61EBFEF;
	Tue,  3 Sep 2024 20:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396720; cv=none; b=LnzZTNWQWCvAH1rtbTOMiendVGXllZ1OKBB7ir6CUbGdSfCdS7hpTFWkQ5Ca04ijfs/kfudes93JpE3pCA3jq+sFYsURpWr32ygXMqd/LhGkn+8Wk6MqqXMaX2rx8CG6FnOguyNTLqP+hMh6tWbq0u3PPa3rjtCExl+0R6eBdSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396720; c=relaxed/simple;
	bh=pIONA04OSg0VAgdAwpmy9VgALuxObMqTee+32jw8lkU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GieXmm34MEEoyAPk94EDNMrNfXIOi7Nv42tzGZ1MMGTHJBiqb1gw9h5Q8JUfIJV3BzQN9kF/Bm3NaY13nj2NxN/2rHK1SwINw+7DG8cGIh8sO9HdMpd7wQ3OEwCYM2FO6CZN70//aHnJzS0nwF5D/9Mox5LU/NCIeh5JlkO1WYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzrhLSnR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB8DC4CEC5;
	Tue,  3 Sep 2024 20:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396719;
	bh=pIONA04OSg0VAgdAwpmy9VgALuxObMqTee+32jw8lkU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DzrhLSnRfS2UbJN6lFCBuwjOLr0IcuTAQ+aPNiGcigjGRJFSNzYn5SPfascORSsfw
	 DU/9W43tnf44FQsxDw7YjJJPNZD5SNxN0mDTqEC9dCVAQaBtZvVwMoB9VQLwNSnSGX
	 T3cJ+n9gbl36vk7Qd8BPeqSapx1PiPhDLPU6f+htS3ztqvGQW4uQkeWqxq2TkWO6c+
	 HKlLm3ivxEo2u6XvYsWKRfbGc7dMLOHcXdZRwHNa5/5IRHt1iEnNY5LFjCABt855fe
	 znNc3+djqRGLWgh2MYIsUFNls3rGQxNz7sWhQ0nxN9koJs4Knx0FlceEZdIMDMxeFA
	 2H96nI+wXVMSw==
Date: Tue, 3 Sep 2024 13:51:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, John Fastabend
 <john.fastabend@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/9] bpf: cpumap: enable GRO for XDP_PASS
 frames
Message-ID: <20240903135158.7031a3ab@kernel.org>
In-Reply-To: <20240830162508.1009458-1-aleksander.lobakin@intel.com>
References: <20240830162508.1009458-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Aug 2024 18:24:59 +0200 Alexander Lobakin wrote:
> * patch 4: switch cpumap from a custom kthread to a CPU-pinned
>   threaded NAPI;

Could you try to use the backlog NAPI? Allocating a fake netdev and
using NAPI as a threading abstraction feels like an abuse. Maybe try
to factor out the necessary bits? What we want is using the per-cpu 
caches, and feeding GRO. None of the IRQ related NAPI functionality
fits in here.

