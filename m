Return-Path: <bpf+bounces-68711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A39D3B81F25
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 23:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AB507BDB85
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 21:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7B6304963;
	Wed, 17 Sep 2025 21:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIzvUw3I"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D492D2749CE;
	Wed, 17 Sep 2025 21:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758144161; cv=none; b=Qv3VHvPxJ1QzRw840APn+sgOLsOIDoavjhU38OfFWRhk9EM7IWoJQE6LMzZ4c0+pUgCBVQY3BO52N3iIoEZ3SqV0sCxTNST4h2X3K5LYlVqvbt9/z+H7TqojdzljOdU6S52bozXFemOc/vhSNuY3pBsL5fqP3rhe369nwz/zvcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758144161; c=relaxed/simple;
	bh=VhFn1wpwrS1RDDHi1pYQzMzqmS3pgxJXwPkAvzdGmLM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q/pq33TlU/HG+zboWtRkYzF5X3AOgJtrrhluqBCVne57LS7ROaYcHLZ7Lt25bdaRsDNZOIZ0WRjLwq3mD5956WNf+RkilKYTJVP9Hdb5C+NlyTKqTJLS8F49VkHt7W/9auz7hosqJYJOlPVrFny7JURINvkoh+KrsHJb5y6N8js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIzvUw3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44B8C4CEE7;
	Wed, 17 Sep 2025 21:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758144161;
	bh=VhFn1wpwrS1RDDHi1pYQzMzqmS3pgxJXwPkAvzdGmLM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pIzvUw3I0UOxJ6ri0qF8bQvssPEiHWybKK6nGydjeutCXElYZ9adAh3YJ3EyL0YFZ
	 mnnxRj5kO/X/R71T18nqEOh3fQb4w6qAQbwyrun5vWoe9iGmgn41r56qrZ6ALIuFFt
	 Zb8tHdUmZB7cQs/bbSeq3QptZMe0+bdYXiJZ1diC2ZhrLI34FL7t681u3PAKTe5PtP
	 XsOYEOgAPB7cIAFjMf62RhzPYp2zZCboUspqGLFZ4FtUQIh55mbbfCXjPwL4Hvguxp
	 o6+BpsoGJfGEsvdQVU2JuWs8Y8tkAfLpoJwG5TFaoImj8K/zsupfyy269wS+vOlIm6
	 ZI7zD4pcQ/Ekg==
Date: Wed, 17 Sep 2025 14:22:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>, noren@nvidia.com
Cc: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, paul.chaignon@gmail.com, stfomichev@gmail.com,
 martin.lau@kernel.org, mohsin.bashr@gmail.com, dtatulea@nvidia.com,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 maciej.fijalkowski@intel.com, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v3 0/6] Add kfunc bpf_xdp_pull_data
Message-ID: <20250917142239.245e9ed2@kernel.org>
In-Reply-To: <a9ce1249-f459-440f-a234-bdb8dd4238f2@linux.dev>
References: <20250915224801.2961360-1-ameryhung@gmail.com>
	<a9ce1249-f459-440f-a234-bdb8dd4238f2@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Sep 2025 11:50:01 -0700 Martin KaFai Lau wrote:
> On 9/15/25 3:47 PM, Amery Hung wrote:
> >   include/net/xdp_sock_drv.h                    |  21 ++-
> >   kernel/bpf/verifier.c                         |  13 ++
> >   net/bpf/test_run.c                            |  26 ++-
> >   net/core/filter.c                             | 123 +++++++++++--
> >   .../bpf/prog_tests/xdp_context_test_run.c     |   4 +-
> >   .../selftests/bpf/prog_tests/xdp_pull_data.c  | 174 ++++++++++++++++++
> >   .../selftests/bpf/progs/test_xdp_pull_data.c  |  48 +++++
> >   .../selftests/net/lib/xdp_native.bpf.c        |  89 +++++++--  
> 
> I think the next re-spin should be ready. Jakub, can this be landed to 
> bpf-next/master alone and will be available in net-next after the upcoming merge 
> window, considering it is almost rc7?

Nimrod, are you waiting for these before you send you dyn_ptr flavor of
XDP tests? Other than Nimrod's work I don't see a problem.

