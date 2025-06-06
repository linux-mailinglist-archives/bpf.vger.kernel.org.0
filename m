Return-Path: <bpf+bounces-59845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E93D0ACFD93
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 09:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77CB61898735
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 07:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA10283FF1;
	Fri,  6 Jun 2025 07:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dOGGcEf0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2DC7FD;
	Fri,  6 Jun 2025 07:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749195415; cv=none; b=QoKeI0orHwOpBmM/K94chKhd+IKGHfzhVcLLbbJfgg2ly+eZwLdb4lVGAGM9zAWvcQgVAzGgk0QSOKdEEP6F4VPIuWNFQ7TJTuCrAg/s6tEyecHyWO/j1PphL07SdACVMEV38nNda2MmvRZIyGa1b4j/dRYVUN8BocFEF0qxyew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749195415; c=relaxed/simple;
	bh=3vNIocilUM9Bye5uYJE5jZIZc2lHbptQak1eWPmieEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPy6wNVlz9fN2I0DPMdC3FhPJHMYGHihmqepF9R/YWOSkbYQVsJrUlCfRn9K5RalNxHJt/Vh146jcczIVGlH6X+mpe3T818JhatvSg1jgk0FMnHPdmigSKhT2+La06UxjZGEeNTsQ89ZLT/T02V8VnTCpWKpyYWTwdLEYqmC+lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dOGGcEf0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01DDC4CEEB;
	Fri,  6 Jun 2025 07:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749195414;
	bh=3vNIocilUM9Bye5uYJE5jZIZc2lHbptQak1eWPmieEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dOGGcEf0PrWYQgKLe+IdneMVo2FYmHPFcxNYmyLaPPRacRSlADdx+CD9i6xfOONzY
	 cb5kFl6PSBpJ2VfP5xCNaY5Z3nqp0gFohpfbZwgVB+TSuCZtG9TmTR2IRgnpUJ0I20
	 8zf0WIpQmCpDF4lY0ptcnfHpXrizMx6Gtj7ciFUg=
Date: Fri, 6 Jun 2025 09:36:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Suleiman Souhlal <suleiman@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Ian Rogers <irogers@google.com>, ssouhlal@freebsd.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [RESEND][PATCH] tools/resolve_btfids: Fix build when cross
 compiling kernel with clang.
Message-ID: <2025060617-citation-greedy-ba05@gregkh>
References: <20250606052301.810338-1-suleiman@google.com>
 <20250606053650.863215-1-suleiman@google.com>
 <2025060650-detached-boozy-8716@gregkh>
 <CABCjUKA-ghX8MHPai5mfC4dZgS8pxi3LAvh3Wnm0VCt4QmU2Hw@mail.gmail.com>
 <2025060620-stainless-unedited-ddfc@gregkh>
 <CABCjUKB4OgQoGv+Eg7q3zmJXXw8dWfEo_AP-XfzxHDoodtxhXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABCjUKB4OgQoGv+Eg7q3zmJXXw8dWfEo_AP-XfzxHDoodtxhXg@mail.gmail.com>

On Fri, Jun 06, 2025 at 03:21:45PM +0900, Suleiman Souhlal wrote:
> On Fri, Jun 6, 2025 at 3:20 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Jun 06, 2025 at 03:08:09PM +0900, Suleiman Souhlal wrote:
> > > On Fri, Jun 6, 2025 at 3:05 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Fri, Jun 06, 2025 at 02:36:50PM +0900, Suleiman Souhlal wrote:
> > > > > When cross compiling the kernel with clang, we need to override
> > > > > CLANG_CROSS_FLAGS when preparing the step libraries for
> > > > > resolve_btfids.
> > > > >
> > > > > Prior to commit d1d096312176 ("tools: fix annoying "mkdir -p ..." logs
> > > > > when building tools in parallel"), MAKEFLAGS would have been set to a
> > > > > value that wouldn't set a value for CLANG_CROSS_FLAGS, hiding the
> > > > > fact that we weren't properly overriding it.
> > > > >
> > > > > Cc: stable@vger.kernel.org
> > > > > Fixes: 56a2df7615fa ("tools/resolve_btfids: Compile resolve_btfids as host program")
> > > > > Signed-off-by: Suleiman Souhlal <suleiman@google.com>
> > > > > ---
> > > > >  tools/bpf/resolve_btfids/Makefile | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > You forgot to say why this is a resend :(
> > >
> > > I wasn't sure how to say it. It didn't occur to me that I could have
> > > replied to it with the reason.
> >
> > That goes below the --- line and it would be a v2, not a RESEND as you
> > changed something:
> >
> > > It was because I had "Signed-of-by:" instead of "Signed-off-by:".
> >
> > Which means it was not identical to the first version (a RESEND means a
> > maintainer can take either as they are the same).
> 
> Ah. Should I resend it as a v2?

Think about what you would want to see if you were on the recieving end
of thousands of patches and had to try to figure out what to ignore and
what to pay attention to...

thanks,

greg k-h

