Return-Path: <bpf+bounces-51051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB15A2FB69
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 22:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23E11888B92
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 21:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F4D1F4625;
	Mon, 10 Feb 2025 21:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKbOI3bM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC04264609;
	Mon, 10 Feb 2025 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739221705; cv=none; b=UvHjoYgBmyriVQHwUUgfrZX1/8M5Tx3P4Ju2DNbR9QZAu1nM4G95O54dXpBDFD/VH2yy+NAC8EoAUw6mwUS9yP1/+RpQJORp70WBFaubb+mP4eRCD2CKgylWthDXXbE8BoMTpmHKzDW7XZtSILRg9QZOMYoT7r3YH/gRVqyJ91Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739221705; c=relaxed/simple;
	bh=ifYlc+ym4R8P85YHqdId6Knc8r20F8vpm7Pw13cLVR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbN4s3/YChs0Z782DPyydwe+MDoF6oijualQDH2Dczh+Rrd0VaaFGllZdMbTeE7vq8mlvtsAUkMF+7pU/BrYn/Fp3DSViMQ2VbvU9oKOHOu+CQOafWthSr+3DoBqXMuG339pbtB++fc6Jr600Uap9HVNG6BC2TlfPiy+L2SYmok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKbOI3bM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFC1C4CEE6;
	Mon, 10 Feb 2025 21:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739221705;
	bh=ifYlc+ym4R8P85YHqdId6Knc8r20F8vpm7Pw13cLVR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PKbOI3bMxVUQnTwWf1Tj9+lOl3wcPZtmllQ30Fz3SisR7YINJIcLOZA6sWJoOFx23
	 W0Dh/NIsdK6fauMJQmyeQJZMjProtNmiajYRvOo/X1tzybxkz9jS6ctwg1CwUItvtr
	 9kxr+VCxx0HrnbBg/uVOLw08yYXEIECdxDc77RtLGljdZQrmzqm6HW5VZPlwUuYjig
	 tCmuv/lvFYaRNpVfMWox5npWr0xhtvD8sV3Y0sGx6hCrMLfuJzFw+erD94kRyeLiv+
	 LiyJhyUXy2fo1ZTk9C4+tAEA6hHd5iUimCS6yb49gGQJ9zYCx1yYLw1a93fuCukoJX
	 jmDqANUYbpFQA==
Date: Mon, 10 Feb 2025 21:08:19 +0000
From: Simon Horman <horms@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jason Baron <jbaron@akamai.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Nathan Chancellor <nathan@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] unroll: add generic loop unroll helpers
Message-ID: <20250210210819.GF554665@kernel.org>
References: <20250206182630.3914318-1-aleksander.lobakin@intel.com>
 <20250206182630.3914318-2-aleksander.lobakin@intel.com>
 <20250209110725.GB554665@kernel.org>
 <fa01e28e-b75d-4d60-b10a-ccf3e544ff1e@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa01e28e-b75d-4d60-b10a-ccf3e544ff1e@intel.com>

On Mon, Feb 10, 2025 at 04:49:14PM +0100, Alexander Lobakin wrote:
> From: Simon Horman <horms@kernel.org>
> Date: Sun, 9 Feb 2025 11:07:25 +0000
> 
> > On Thu, Feb 06, 2025 at 07:26:26PM +0100, Alexander Lobakin wrote:
> >> There are cases when we need to explicitly unroll loops. For example,
> >> cache operations, filling DMA descriptors on very high speeds etc.
> >> Add compiler-specific attribute macros to give the compiler a hint
> >> that we'd like to unroll a loop.
> >> Example usage:
> >>
> >>  #define UNROLL_BATCH 8
> >>
> >> 	unrolled_count(UNROLL_BATCH)
> >> 	for (u32 i = 0; i < UNROLL_BATCH; i++)
> >> 		op(priv, i);
> >>
> >> Note that sometimes the compilers won't unroll loops if they think this
> >> would have worse optimization and perf than without unrolling, and that
> >> unroll attributes are available only starting GCC 8. For older compiler
> >> versions, no hints/attributes will be applied.
> >> For better unrolling/parallelization, don't have any variables that
> >> interfere between iterations except for the iterator itself.
> >>
> >> Co-developed-by: Jose E. Marchesi <jose.marchesi@oracle.com> # pragmas
> >> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> >> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> >> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> > 
> > Hi Alexander,
> > 
> > This patch adds four variants of the unrolled helper.  But as far as I can
> > tell the patch-set only makes use of one of them, unrolled_count().
> > 
> > I think it would be best if this patch only added helpers that are used.
> 
> I thought they might help people in future.
> I can remove them if you insist. BTW the original patch from Jose also
> added several variants.

I do slightly prefer only adding what is used.

