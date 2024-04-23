Return-Path: <bpf+bounces-27573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB0E8AF5DB
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 19:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D1DF1F24146
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 17:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BFE13E029;
	Tue, 23 Apr 2024 17:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4wCMIlu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1931E13CA96;
	Tue, 23 Apr 2024 17:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713894863; cv=none; b=RLdr/jrTsWZb6mrNNlVWsD2zAPezlaaE9y7aoUi6fqojThRPBI5h/FmxVYIBsWd5i4p3TuJTc/otpCGOy2MxR02LWM5IUdOJetfqk5VoWspmQU0cFhR9D7haIyib7VbURuJD+xfdgAoeNTSJl2I4eOGroS1qOT11/YUy7yt2XRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713894863; c=relaxed/simple;
	bh=ZzNi7yvNwiyPn3p4svVXCBMMGLRPKuJ8+pFxOBldCtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O01uj/CaNnOn3yAdMdYN/p+IgfI/aIyt173cQUutFf0Tmb+U9NPQR+5Yo4tABZutantGR9U1+ct8iCJb3kTjk9fIGrxnb0CPdIIaVtRD8sk4Zk++W168gBsWFPuc9HKcBBF0f+Pskht8MOsKmdTQRvEW0MUaPl363hdn2KP2jW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4wCMIlu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0066CC116B1;
	Tue, 23 Apr 2024 17:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713894862;
	bh=ZzNi7yvNwiyPn3p4svVXCBMMGLRPKuJ8+pFxOBldCtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u4wCMIlu8OwyiSAxerkAweuCR9dR9bpaZ0gp1o7PLnus5h7LNgcwvmUCFfNi/V55b
	 3ljd/40N2bZJtA6WCOasX0IzVcSNXciEDsmAx+DKIF+tHd1yxRSHs9v9ylTj/WDQh2
	 h7o4gn1f7C4osqJVMeK2wl9Wzh6CiPXeDWwTjh7U8HC5f000siX9QGyTTat5V6rS4x
	 XMGbGskp4fx9Jwzti/QWzeNeAHsuEikqiA3CZRKjCUeyQjMWyZXfEbBxrZmUp1Cp77
	 MP72qZTvpO3ZBi9WqVDQfvI+fW4CteT5IG6m9+GUCup/PFF2SSNw5TB4lRwGAi0roz
	 0+A9xBhtMvQYg==
Date: Tue, 23 Apr 2024 14:54:18 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: dxu@dxuuu.xyz, dwarves@vger.kernel.org, andrii.nakryiko@gmail.com,
	jolsa@kernel.org, bpf@vger.kernel.org, eddyz87@gmail.com
Subject: Re: [PATCH dwarves 0/2] replace --btf_features="all" with "default"
Message-ID: <Zif1ysMXHRd01ovg@x1>
References: <20240423160200.3139270-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423160200.3139270-1-alan.maguire@oracle.com>

On Tue, Apr 23, 2024 at 05:01:58PM +0100, Alan Maguire wrote:
> Use of "all" in --btf_features is confusing; use the "default" keyword
> to request default set of BTF features for encoding instead.  Then
> non-standard features can be added in a more natural way; i.e.
> 
> --btf_features=default,reproducible_build
> 
> Patch 1 makes this change in pahole.c and documentation.
> Patch 2 adjusts the reproducible build selftest to use "default"
> instead of "all".
> 
> This series is applicable on the "next" branch.

Applied to the next branch, I also refreshed the patches adding the
alternative + syntax, its basically a one liner :-)

I'll leave it there for a day for the libbpf CI to test with it and then
will move all to 'master'.

The first patch of Daniel's series got merged as well, it would be good
to refresh the other two patches on top of what we have in 'next' now,
Daniel?

Thanks!

- Arnaldo
 
> Alan Maguire (2):
>   pahole: replace use of "all" with "default" for --btf_features
>   tests: update reproducible_build test to use "default"
> 
>  man-pages/pahole.1          |  4 +-
>  pahole.c                    | 75 +++++++++++++++++++------------------
>  tests/reproducible_build.sh |  4 +-
>  3 files changed, 43 insertions(+), 40 deletions(-)
> 
> -- 
> 2.39.3

