Return-Path: <bpf+bounces-34194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C5392AF6D
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 07:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDB6A1F21D6C
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 05:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E0212D1FD;
	Tue,  9 Jul 2024 05:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWrGFqI+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B1C63A;
	Tue,  9 Jul 2024 05:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720503034; cv=none; b=C672Ip5xi3IvDTSzXPTaPXjmvLnCIa6WOAbGh5nB7H5QMB83U218Uw++aqB6utlUOBlrj4aJu16RPvxf8iGrZ8XbmfY4JIqI8cJBsH7tvW+upjJ9wcFL1rWM2eOrAYBKWpSxe6lbybYEHAlqNJ9MhXQhsMr7NH7khSiy6ghVq+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720503034; c=relaxed/simple;
	bh=3v5wbcP0hZPdO4H71xPWdtsCXwN4cSEbDdTpxtfZxbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLVTnwlMfMjmw+M+Uh7TuTCVFYwCyIrTxOOo51/Y3UeQodnzYEWd4IaG/7oT1dIku3y91BXs49pCm1epnRKsjEPafi8UsEK4Ec+Fn5mRyWwbgvqTa07UWQJwZWQ/kXMUM0Z0sUyEtlB3/A1n++pq3WoRanrhGCIGkPXBBEtLPCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWrGFqI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1ED3C4AF07;
	Tue,  9 Jul 2024 05:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720503033;
	bh=3v5wbcP0hZPdO4H71xPWdtsCXwN4cSEbDdTpxtfZxbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sWrGFqI+R41C2LlSVz0Bz3IJXyX0qmmOMlUWtw+s84NUrvt+zLC8aT5v4ves3coeO
	 hly5Q5XmqSRWKVV0PDqtQrkDFEqKcDmLreiwvucLkjgA3Y8GHgMi2qlD6F4W4/Cuwi
	 b1fKbzkHDhPVQ72AjQIqM4cu/5l8CBK5abH3pl3EKwQsVE7K65qKJGsIELXvx6J/j9
	 g2nC2n/NbaSRT/mkAO4IDsFzL6cVBX0Vgjd6luFC3FxGVZ72XJaTEbayOQDVGzaWsU
	 Y7OoRFdmm5/5WhaA7EOiWd7bMOgBEBPnPdpmh8UdJsahZdUfx3Vo7asSrpNYgxbUER
	 udg46dZi1lqgQ==
Date: Mon, 8 Jul 2024 22:30:31 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Guillaume Tucker <gtucker@gtucker.io>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	llvm@lists.linux.dev, rust-for-linux@vger.kernel.org,
	yurinnick@meta.com, bpf@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	automated-testing@lists.yoctoproject.org
Subject: Re: Plumbers Testing MC potential topic: specialised toolchains
Message-ID: <20240709053031.GB2120498@thelio-3990X>
References: <f80acb84-1d98-44d3-84b7-d976de77d8ce@gtucker.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f80acb84-1d98-44d3-84b7-d976de77d8ce@gtucker.io>

Hi Guillaume,

On Tue, Jul 09, 2024 at 12:10:51AM +0200, Guillaume Tucker wrote:
> While exchanging a few ideas with others around the Testing
> micro-conference[1] for Plumbers 2024, and based on some older
> discussions, one key issue which seems to be common to several
> subsystems is how to manage specialised toolchains.
> 
> By "specialised", I mean the ones that can't easily be installed
> via major Linux distros or other packaging systems.  Say, if a
> specific compiler revision is required with particular compiler
> flags in order to build certain parts of the kernel - and maybe
> even a particular compiler to build the toolchain itself.

I am having trouble understanding this paragraph, or maybe what it is
getting after? While certain features in the kernel may require support
from the compiler/toolchain (such as LTO or CFI), they should not be
required. Perhaps you are talking about the selftests but I think that
is distinctly different from the kernel itself. Is there a different (or
perhaps tangible) situation that you have encounted or envision?

> LLVM / Clang-Built-Linux used to be in this category, and I
> believe it's still the case to some extent for linux-next
> although a minimal LLVM version has now been supported in
> mainline for a few years.

Yes, we committed to a minimum version a few years ago. We have had to
bump it twice for various reasons since then but I have tried to be
fairly methodical about selecting a version that should be available
enough. Has that caused problems?

> A more critical example is eBPF, which I believe still requires a
> cutting-edge version of LLVM.  For example, this is why bpf tests
> are not enabled by default in kselftest.

This sounds like something to bring up to the BPF folks, has anyone
interacted with them to discuss this situation and see if stabilization
for the sake of testing is possible?

> Based on these assumptions, the issue is about reproducibility -
> yet alone setting up a toolchain that can build the code at all.
> For an automated system to cover these use-cases, or for any
> developer wanting to work on these particular areas of the
> kernel, having the ability to reliably build it in a reproducible
> way using a reference toolchain adds a lot of value.  It means
> better quality control, less scope for errors and unexpected
> behaviour with different code paths being executed or built
> differently.
> 
> The current state of the art are the kernel.org toolchains:
> 
>   https://mirrors.edge.kernel.org/pub/tools/
> 
> These are for LLVM and cross-compilers, and they already solve a
> large part of the issue described above.  However, they don't
> include Rust (yet), and all the dependencies need to be installed

As Miguel pointed out in a side thread, there are some Rust toolchains
available:

https://lore.kernel.org/rust-for-linux/CANiq72mYRkmRffFjNLWd4_Bws5nEyTYvm3xroT-hoDiWMqUOTA@mail.gmail.com/

I will try to make those more discoverable from the LLVM folder.

> manually which can have a significant impact on the build
> result (gcc, binutils...).  One step further are the Linaro

I have considered trying to statically compile LLVM (we started the
effort some time ago but I have not been able to get back to it) but
honestly, the xz disaster made me worry about building a static
toolchain with a potentially vulnerable dependency, either necessitating
removing the toolchain or rebuilding it.

FWIW, I don't think the list of dependencies for the LLVM toolchain is
too long. In fact, it appears they are all installed in a default Fedora
image.

> TuxMake Docker images[2] which got some very recent blog
> coverage[3].  The issues then are that not all the toolchains are

Ah, interesting, I did not realize that there was a blog post, that is
cool!

> necessarily available in Docker images, they're tailored to
> TuxMake use-cases, and I'm not sure to which extent upstream
> kernel maintainers rely on them.

FWIW, the general vibe I get from kernel maintainers is most are pretty
old school. I know some that use tuxmake but I suspect most probably
just use their own scripts and wrappers that they have developed over
the years. Part of the reason I made the toolchains as tarballs is so
that all a maintainer has to do is install it to somewhere on the hard
drive then they can just use LLVM=<prefix>/bin/ to use it.

> Now, I might have missed some other important aspects so please
> correct me if this reasoning seems flawed in any way.  I have
> however seen how hard it can be for automated systems to build
> kernels correctly and in a way that developers can reproduce, so
> this is no trivial issue.  Then for the Testing MC, I would be

Right, I think reproducibility and ease of setup/use is really
important.

> very interested to hear whether people feel it would be
> beneficial to work towards a more exhaustive solution supported
> upstream: kernel.org Docker images or something close such as
> Dockerfiles in Git or another type of images with all the
> dependencies included.  How does that sound?

A few thoughts around this:

Having first party Dockerfiles could be useful but how would they be
used? Perhaps building a kernel in such a container could be plumbed
into Kbuild, such that the container manager could be invoked to build
the image if it does not exist then build the kernel in that image? This
might be a lofty idea but it would remove a lot of the friction of using
containers to build the kernel so that more people would adopt it?

Another aspect of this is discoverability. I think a big problem with a
project like TuxMake is that while it is developed for the kernel
community, it is not a first party project, so without word of mouth,
there is not a great way for other people to hear about it.

I think it would be a good idea to try and solicit feedback from the
greater kernel community at large to ensure that whatever solution is
decided on will work for both testing systems and
developers/maintainers. I think that a first party solution for having a
consistent and easy to set up/work with build environment has been
needed for some time but unfortunately, I am not sure how much
discussion around this problem has happened directly with those folks.

> [1] https://lpc.events/event/18/contributions/1665/
> [2] https://hub.docker.com/u/tuxmake
> [3] https://www.linaro.org/blog/tuxmake-building-linux-with-kernel-org-toolchains/

As an aside, consider using me as a point of contact for anything
ClangBuiltLinux related instead of Nick going forward, he has stepped
away to focus on LLVM libc for the immediate future.

Thanks a lot for bring up this topic. I think it is important to work on
and I look forward to talking through this at Plumbers.

Cheers,
Nathan

