Return-Path: <bpf+bounces-54969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71E5A767CB
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 16:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 429713AA601
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 14:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7248F214216;
	Mon, 31 Mar 2025 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K8rpHU1d"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCD621127E;
	Mon, 31 Mar 2025 14:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431119; cv=none; b=fROW61EwtKO16KP8g90+NBt3ZkKTCOQHMv6XiqcKG3jnGNlH6IYlf8xkPe3mTHL/Euj8txm0ej7yyTxkYpfMeqD7jtQZ98lPGWzbPrRuJ3/QDE0e5Rg8c1u408B/f1FfQQlwavstNKPvzXKDcuA8CqoGt/7l9kGCeN3mM8ODkuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431119; c=relaxed/simple;
	bh=4aUz1xj3vVmwgN1eViSGQG3qretKX+eYkC21ZSuhNk8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=J0FI55mMOKXGHmr5tLeDmi0V6csoj+yULq1DHPPdZwlx30HdEWqPjHG817+EsHwptj2tRG7sX5sl9X6OKMGvTrHD4LWOF0L9xn1kVpOHDRyH/O1GSIvygztXFZgDNulTe52yRr/ibP6txAEpZ46liIw8M8UyzQIB2BIK/IbRt/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=K8rpHU1d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE50C4CEE4;
	Mon, 31 Mar 2025 14:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1743431118;
	bh=4aUz1xj3vVmwgN1eViSGQG3qretKX+eYkC21ZSuhNk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K8rpHU1dx5QbCWIRUXuL4nESgRfGnQyUq4b9H2kBrUWvbzATK+tY90gkdU6md2FPN
	 lK4bBc386qG9Pg3bEIpyS/ZbjD6HTSIybDGJGam1dTkFb/7D0BMnJQ2zDy83Cjukiu
	 o/7CFeEjQqYYi7CLKi4fqngjCRMowuReAOhOUpUE=
Date: Mon, 31 Mar 2025 07:25:17 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Luiz Capitulino <luizcap@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Borkmann
 <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, Networking
 <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the bpf-next tree with the mm tree
Message-Id: <20250331072517.53ff2504faa074ac0a417ae3@linux-foundation.org>
In-Reply-To: <7e816e0f-19af-4ef2-bf84-fc762ecbae26@redhat.com>
References: <20250311120422.1d9a8f80@canb.auug.org.au>
	<20250331102749.205e92cc@canb.auug.org.au>
	<7e816e0f-19af-4ef2-bf84-fc762ecbae26@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 10:19:34 -0400 Luiz Capitulino <luizcap@redhat.com> wrote:

> >>   -	page_ext_put(page_ext);
> >>    
> >>    	if (alloc_handle != early_handle)
> >>    		/*
> > 
> > This is now a conflict between the mm-stable tree and Linus' tree.
> 
> What's the best way to resolve this? Should I post again or can we just use your fix?

It's in Linus's hands now...

