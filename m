Return-Path: <bpf+bounces-50035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6376DA22196
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 17:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9E3F168055
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 16:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6451DF968;
	Wed, 29 Jan 2025 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiNC79Vc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E121C1A2399;
	Wed, 29 Jan 2025 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738167569; cv=none; b=l1Ps2WPnKyTqjdDuPD9TLmkzAWV3rjo7hWTncJQELJJoNDdbe4jVFMtW/qkpxa+cjnzbPnIjayazvn9qxkND9BJCt5eAyrrX7pbS8qShR7h2TwsnljzvoWm3sssQ6if8pcK9a9VfFJEDygE2PpRq7Pk37vWeQ59jm7h9ned8sj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738167569; c=relaxed/simple;
	bh=tfSftwsw3SrB21XJ7sFJV016rvpuZiWMOMn9qVmuYRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzitOYm4cbckNGKZWK6+1PYpEjmLmCX9e+3g5oryclxDVOyalqa/3/oD4omkdIUSLl9Cvz0/yz45UlElN+KxKL5e6NtDfw+vHVXO6CCUZH+OM9ZUmjMyArsSCXDoqzHZ4SFrCRxLQ0fcm0zZDSu3mo4otFspArbRPt8CmtQokHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiNC79Vc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F14C4CED3;
	Wed, 29 Jan 2025 16:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738167568;
	bh=tfSftwsw3SrB21XJ7sFJV016rvpuZiWMOMn9qVmuYRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JiNC79Vcc44ICGUcCP0iA7Qt5RFfni3eKu4MXDUBACs1pOp4/V11sGKMkA34JWHe3
	 /ECYRjq8OBm7ec2WRUbgt7/ZMxwA1bYnVzw2iBpyD8EXal0QS59JDXP+9jXE1pdkiS
	 ci0vsNlYDsKl/W75kM3Ws/AjRBrps7NZRY41Rj51tZu16sveerpMmKjWPWP8B9GDz+
	 UPvrwP5myH8migxnc58/pG6cF6VPtsSW6Wni447d8ClfJevoX2++XDqtvouQWCQWZq
	 LqbexangFs+D7Tkz7efp5Cojfeqx34ArF7wNeUPoq127MHHc1UNU6zhmw36jPYi5ic
	 eH420FNyzBgfA==
Date: Wed, 29 Jan 2025 06:19:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: selftests/sched_ext: testing on BPF CI
Message-ID: <Z5pVD-c9f7TmS1rA@slm.duckdns.org>
References: <3fb44500b87b0f1d8360bc7a1f3ae972d3c5282f@linux.dev>
 <Z5nYRj1L4h1KCWE1@gpd3>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5nYRj1L4h1KCWE1@gpd3>

On Wed, Jan 29, 2025 at 08:27:02AM +0100, Andrea Righi wrote:
> Hi Ihor,
> 
> On Wed, Jan 29, 2025 at 12:21:43AM +0000, Ihor Solodrai wrote:
> > Hi Tejun, Andrea.
> > 
> > I tested a couple of variants of bpf-next + sched_ext source tree,
> > just sharing the results.
> 
> Thanks for testing!
> 
> > 
> > I found a working state: BPF CI pipeline ran successfully twice
> > (that's 8 build + run of selftests/sched_ext/runner in total).
> 
> Ok.
> 
> > 
> > Working state requires most patches between sched_ext/master and
> > sched_ext/for-6.14-fixes [1], and also the patch
> >   "tools/sched_ext: Receive updates from SCX repo" [2]
> > 
> > On plain bpf-next the dsp_local_on test fails [3].
> > Without the patch [2] there is a build error [4]: missing
> > SCX_ENUM_INIT definition.
> 
> We definitely need all the patches in sched_ext/for-6.14-fixes. I think
> once Tejun sends the PR and we land the for-6.14-fixes upstream we should
> reach a stable state with the sched_ext selftests. I don't have any other
> additional pending fix at the moment.
> 
> > 
> > We probably don't want to enable selftests/sched_ext on BPF CI with
> > that many "temporary" patches. I suggest to wait until all of this is
> > merged upstream.
> 
> Sounds reasonable to me. Tejun?

Sure.

Thanks.

-- 
tejun

