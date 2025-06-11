Return-Path: <bpf+bounces-60290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E389AAD4854
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 04:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34003A69C9
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 02:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5F51632D7;
	Wed, 11 Jun 2025 02:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyriQXiF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0F9154C17
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 02:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749607526; cv=none; b=sBKyTCYW1uGCCv95fDG9LtFLEmyEejlaiHzt1agJ7VsDToFd5WB253tyjB3BolF8uSYC18xIfiWpZR5vmmgAXcU4dlQSJ6VjE48FCU2tH1mtHUtvnjjsywc0mwg04YUveQbXOPCSEaKHR17uIm48SZ268trrMGN6SFA6Qqqnzew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749607526; c=relaxed/simple;
	bh=A51pa5/WPgp2e8i40HxCGD3ZD76gKs7+NQ43jxy+d9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srDjSqirh+p5xFAu7MkVSoMunwNsYu7VyDN3he8r59JCXCdPc0iZTCb4y+33xVopaoI2OJxV9gtEwXhpw1SLimjD4wj7XMGREjBX007KS6Nc9i0ncnXd6Sm3c1POxEp8WmEKilpJd+o9vQm/aJf0gSX6Uf/d1AUV0w7ImDcSu64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyriQXiF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0307DC4CEED;
	Wed, 11 Jun 2025 02:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749607525;
	bh=A51pa5/WPgp2e8i40HxCGD3ZD76gKs7+NQ43jxy+d9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DyriQXiFzqJa1ac6hdkQcZfTiX4DP+cTupGXG9L5ERo5k4ZTBHsB5D+6q7/ZkPL8d
	 8tpHW10IYriUGEi4prIzad/nK9ClWHb8iUPjPV5Hm2pC+LOpRhGOMLApv/HzY5IEFE
	 uNhLcgnuiMXvmcP+AE0mdxAyY56Gyg+R18TS3b5qopIopfLb5CNF6V/jPBBR5W1kqA
	 3i3Dvh4O8TuZg3PuIv/Uhkk79FrYlUly0hM1KJ+1m2Yc3wbNpU2ppxhX0gxjUniNxt
	 rIN1l7hrx6SBkVZEP5NWtNDw6/nFV2h1bIPHxuGbv8hDnL3M4lz59l9e47yrzQgJC1
	 AH5iABPZol9/g==
Date: Tue, 10 Jun 2025 19:05:22 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: bpf-restrict-fs fails to load without
 DYNAMIC_FTRACE_WITH_DIRECT_CALLS on arm64
Message-ID: <20250611020522.GA3981304@ax162>
References: <20250610232418.GA3544567@ax162>
 <CAADnVQ+jNQyC=RcoiwDXeHj9y6CGzr322scz_8uGwCDVx-Od4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+jNQyC=RcoiwDXeHj9y6CGzr322scz_8uGwCDVx-Od4Q@mail.gmail.com>

On Tue, Jun 10, 2025 at 04:37:24PM -0700, Alexei Starovoitov wrote:
> On Tue, Jun 10, 2025 at 4:24 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > I was able to figure out that enabling CONFIG_CFI_CLANG was the culprit
> > for the change in behavior but it does not appear to be the root cause,
> > as I can get the same error with GCC and the following diff (which
> > happens with CFI_CLANG because of the CALL_OPS dependency):
...
> > -       select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS \
> > -               if DYNAMIC_FTRACE_WITH_ARGS && DYNAMIC_FTRACE_WITH_CALL_OPS
> >         select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS \
> >                 if (DYNAMIC_FTRACE_WITH_ARGS && !CFI_CLANG && \
> >                     (CC_IS_CLANG || !CC_OPTIMIZE_FOR_SIZE))
> >
...
> That's expected.
> See how kernel/bpf/trampoline.c is using DYNAMIC_FTRACE_WITH_DIRECT_CALLS.
> 
> Theoretically we can make bpf trampoline work without it,
> but why bother? Just enable this config.

As I note above, this is incompatible with CONFIG_CFI_CLANG, which is
more important for my particular area of testing and maintenance. Since
you note this is expected, I will just go back to ignoring the warning
in my kernel logs :) thank you for the quick response!

Cheers,
Nathan

