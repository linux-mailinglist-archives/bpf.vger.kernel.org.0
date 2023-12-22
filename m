Return-Path: <bpf+bounces-18611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866F481CB5E
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 15:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19BF6B22C4F
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 14:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261071D55D;
	Fri, 22 Dec 2023 14:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jR60heL5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA00E200D9
	for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 14:34:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DD5C433C8;
	Fri, 22 Dec 2023 14:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703255693;
	bh=wD+DMULNfcm5v8XBB1zPgHfSQmHjnNJXjMQ/L2uZCUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jR60heL5YoJ84gLmfHknmBiULDdGVsMMFgLQPfZCYpy78qODZ1J1sj/eVo4tR/f8z
	 DwF5RCDyZbO6L6vA/PV94WL9baUoKHKWqNn9tDDmndx9HosFKmLvGdiYyIn6raooh0
	 6euKwvSP+2R+sicagkmQNX20Ga751Z8xj1Xl2OK7lP4lu7JezvrfqYI69yJcX5yh4V
	 QYCThon4gk1S3HT31/NBvXkQZPkoCKAiXrSXikKI2n53dH9WXlvcjBjUk7jr4hzRJ4
	 eP3lk91zvAlNy7Cbj2nmvs/mXx9QDbUSNrvQ4k8wq4r26626NRHUZljsLU+dUiRY+N
	 Vz9xmjFVSUFUg==
Date: Fri, 22 Dec 2023 19:59:25 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: bpf@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	Song Liu <songliubraving@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH 1/2] powerpc/bpf: ensure module addresses are supported
Message-ID: <qi7rglfbf5bzkbsvuzpfrjwglobltam2ejvvf2hmdau2jd6qqf@af2q5pxoiywz>
References: <20231220165622.246723-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220165622.246723-1-hbathini@linux.ibm.com>

On Wed, Dec 20, 2023 at 10:26:21PM +0530, Hari Bathini wrote:
> Currently, bpf jit code on powerpc assumes all the bpf functions and
> helpers to be kernel text. This is false for kfunc case, as function
> addresses are mostly module addresses in that case. Ensure module
> addresses are supported to enable kfunc support.
> 
> This effectively reverts commit feb6307289d8 ("powerpc64/bpf: Optimize
> instruction sequence used for function calls") and commit 43d636f8b4fd
> ("powerpc64/bpf elfv1: Do not load TOC before calling functions") that
> assumed only kernel text for bpf functions/helpers.
> 
> Also, commit b10cb163c4b3 ("powerpc64/bpf elfv2: Setup kernel TOC in
> r2 on entry") that paved the way for the commits mentioned above is
> reverted.

Instead of that, can we detect kfunc and use separate set of 
instructions just for those?

Unless unavoidable, I would prefer to retain the existing optimal
sequence using TOC for calls to bpf kernel helpers, since those are a 
lot more common than kfunc.

- Naveen


