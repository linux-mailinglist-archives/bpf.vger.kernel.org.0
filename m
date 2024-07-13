Return-Path: <bpf+bounces-34747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E3A9307FF
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 01:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9AE1C212D1
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 23:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA28D15538C;
	Sat, 13 Jul 2024 23:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gtucker.io header.i=@gtucker.io header.b="CeSVMwlE"
X-Original-To: bpf@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B186143883;
	Sat, 13 Jul 2024 23:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720911808; cv=none; b=sRhY+05c/A+7fA3tRg1bviJxHmN8JKE6j4AGnLg8fttXW3mptjfht6edrQF7l/PY8G8FsJ+cof4tdvHcMoRvcT1WMrQTMHCjUWSHTKFKsDCA8b0BphvY1TACsHOFrH8HHACWqtlAXOs6cxtC9f3IEr8PWMgaByMf1ZfXkJWYIWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720911808; c=relaxed/simple;
	bh=p8NXwFBPiAOlfjV3EWGqt6hZlmPEpPzjs+FH73iED0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E3LYwLMOkg+KNi0Nzovo98jOCh4dCfvOuhEizd384x1smuLS5z9n4oJhxtUckekTEvvyWAWnCDJNnFU3PCHkrZUsw/23G1AY7JIN2nc7lzWFa6d7z90fYuVrgPnAUrkPgAJ/az9wBJU+pX/8K9fBAuDx9wWjUGZBCuxN3fdWAJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gtucker.io; spf=pass smtp.mailfrom=gtucker.io; dkim=pass (2048-bit key) header.d=gtucker.io header.i=@gtucker.io header.b=CeSVMwlE; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gtucker.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gtucker.io
Received: by mail.gandi.net (Postfix) with ESMTPSA id BE9BC60003;
	Sat, 13 Jul 2024 23:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gtucker.io; s=gm1;
	t=1720911798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w6SqqjryMjny8o6bM+oVjOXJc/kg3dY5WVehzcDM+j4=;
	b=CeSVMwlEAbNL6Gj1wmcouULIm4cqYz3TfhS3QMuo3ZST3WmWNieOpmukg6KDQiTsa2+rSI
	K9fu4D74lA6BMBebIP5et0OE942mIs3+sMbH+HV8hg+2X9yR/6Ul7JxWF2eE9T/wSjgROJ
	s9vGrNIP4N9JOVAuV1ohqQ3gLravDAfRXT21Qf89i53aTC3u1lme/aJdzZO974h3cF2uPC
	bquhROY7S05n5z8x/GsN37GCJTn9hyc586PCbBMIckxdy9YxWcW+qGpIuaqJ3aJ+7pe7xy
	xEaMv3nhM9XoWTJTEO/gZ3Upx39KfQCr8YZ3AK+tw7qxBSnLL/qV/Kpb5sQQrw==
Message-ID: <e0b6e4b6-549a-43dc-bc76-3f8488cf5dd2@gtucker.io>
Date: Sun, 14 Jul 2024 01:03:16 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Plumbers Testing MC potential topic: specialised toolchains
To: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, llvm@lists.linux.dev,
 rust-for-linux@vger.kernel.org, yurinnick@meta.com, bpf@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 automated-testing@lists.yoctoproject.org
References: <f80acb84-1d98-44d3-84b7-d976de77d8ce@gtucker.io>
 <20240709053031.GB2120498@thelio-3990X>
Content-Language: en-GB
From: Guillaume Tucker <gtucker@gtucker.io>
Organization: gtucker.io
In-Reply-To: <20240709053031.GB2120498@thelio-3990X>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: gtucker@gtucker.io

Hi Nathan,

On 09/07/2024 07:30, Nathan Chancellor wrote:
> Hi Guillaume,
> 
> On Tue, Jul 09, 2024 at 12:10:51AM +0200, Guillaume Tucker wrote:
>> While exchanging a few ideas with others around the Testing
>> micro-conference[1] for Plumbers 2024, and based on some older
>> discussions, one key issue which seems to be common to several
>> subsystems is how to manage specialised toolchains.
>>
>> By "specialised", I mean the ones that can't easily be installed
>> via major Linux distros or other packaging systems.  Say, if a
>> specific compiler revision is required with particular compiler
>> flags in order to build certain parts of the kernel - and maybe
>> even a particular compiler to build the toolchain itself.
> 
> I am having trouble understanding this paragraph, or maybe what it is
> getting after? While certain features in the kernel may require support
> from the compiler/toolchain (such as LTO or CFI), they should not be
> required. Perhaps you are talking about the selftests but I think that
> is distinctly different from the kernel itself. Is there a different (or
> perhaps tangible) situation that you have encounted or envision?

Right, I guess I'm biased towards automated testing use-cases
with build environments that include lots of dependencies to
build kselftest and ideally everything in the kernel source tree.
So when I wrote about building the kernel, I was thinking of all
the other things around it too and that includes some user-space
targets, hence the BPF / LLVM issue.

The Rust example is also a good one as it requires a cutting-edge
version of rustc (see Miguel's email).

The issue I'm referring to is basically about non-trivial
toolchains.  Say, if you just install your distro's gcc, make and
a few tools, you can build a standard kernel image and it'll
basically work the same when built on any other major distro.
Then if someone or a test system reports a bug, it should be
trivial to reproduce it while in this standard build zone.

However, as soon as some runtime behaviour gets closely tied to a
specific toolchain, then it becomes harder to reproduce or even
build the code in the first place.  And this is also oftentimes
where the most bugs occur since it's under active development.

Maybe some real-world examples would help, I'll think about it.

>> LLVM / Clang-Built-Linux used to be in this category, and I
>> believe it's still the case to some extent for linux-next
>> although a minimal LLVM version has now been supported in
>> mainline for a few years.
> 
> Yes, we committed to a minimum version a few years ago. We have had to
> bump it twice for various reasons since then but I have tried to be
> fairly methodical about selecting a version that should be available
> enough. Has that caused problems?

No particular problems, that's great.  The LLVM minimum supported
version is more recent than the minimum GCC one, LLVM 13.0.1 was
released in 2022 and GCC 5.1 in 2015, so there's just a slightly
tighter requirement for LLVM but no big deal.

I was more referring to linux-next and potentially the need to
have a very recent LLVM version to reach full test coverage.

>> A more critical example is eBPF, which I believe still requires a
>> cutting-edge version of LLVM.  For example, this is why bpf tests
>> are not enabled by default in kselftest.
> 
> This sounds like something to bring up to the BPF folks, has anyone
> interacted with them to discuss this situation and see if stabilization
> for the sake of testing is possible?

Yes, well I'm sure it has been discussed in the past but maybe
this could be revived to check if things have become more stable.

>> Based on these assumptions, the issue is about reproducibility -
>> yet alone setting up a toolchain that can build the code at all.
>> For an automated system to cover these use-cases, or for any
>> developer wanting to work on these particular areas of the
>> kernel, having the ability to reliably build it in a reproducible
>> way using a reference toolchain adds a lot of value.  It means
>> better quality control, less scope for errors and unexpected
>> behaviour with different code paths being executed or built
>> differently.
>>
>> The current state of the art are the kernel.org toolchains:
>>
>>   https://mirrors.edge.kernel.org/pub/tools/
>>
>> These are for LLVM and cross-compilers, and they already solve a
>> large part of the issue described above.  However, they don't
>> include Rust (yet), and all the dependencies need to be installed
> 
> As Miguel pointed out in a side thread, there are some Rust toolchains
> available:
> 
> https://lore.kernel.org/rust-for-linux/CANiq72mYRkmRffFjNLWd4_Bws5nEyTYvm3xroT-hoDiWMqUOTA@mail.gmail.com/
> 
> I will try to make those more discoverable from the LLVM folder.

My bad - and thanks, others might hit the same issue.

>> manually which can have a significant impact on the build
>> result (gcc, binutils...).  One step further are the Linaro
> 
> I have considered trying to statically compile LLVM (we started the
> effort some time ago but I have not been able to get back to it) but
> honestly, the xz disaster made me worry about building a static
> toolchain with a potentially vulnerable dependency, either necessitating
> removing the toolchain or rebuilding it.

Ah yes, security is an important point I hadn't considered enough
for this topic.  Regardless of how the tools get bundled
e.g. static build, binary tarball, Docker image etc., providing
them comes with the burden of keeping on top of all the security
updates.  This may also be very beneficial, say if some reference
Docker images for building the kernel are properly kept up to
date it will save some work from people using them.  More food
for thought.

> FWIW, I don't think the list of dependencies for the LLVM toolchain is
> too long. In fact, it appears they are all installed in a default Fedora
> image.

Ack.

>> TuxMake Docker images[2] which got some very recent blog
>> coverage[3].  The issues then are that not all the toolchains are
> 
> Ah, interesting, I did not realize that there was a blog post, that is
> cool!
> 
>> necessarily available in Docker images, they're tailored to
>> TuxMake use-cases, and I'm not sure to which extent upstream
>> kernel maintainers rely on them.
> 
> FWIW, the general vibe I get from kernel maintainers is most are pretty
> old school. I know some that use tuxmake but I suspect most probably
> just use their own scripts and wrappers that they have developed over
> the years. Part of the reason I made the toolchains as tarballs is so
> that all a maintainer has to do is install it to somewhere on the hard
> drive then they can just use LLVM=<prefix>/bin/ to use it.

Sure, my experience has been that new ways of doing things can be
enabled as long as they don't break the old ways.  So if some
Docker images or Yocto packages are built on top of the plain
tarballs as a common denominator, they're just optional things
and nothing would change for people using the tarballs directly.

>> Now, I might have missed some other important aspects so please
>> correct me if this reasoning seems flawed in any way.  I have
>> however seen how hard it can be for automated systems to build
>> kernels correctly and in a way that developers can reproduce, so
>> this is no trivial issue.  Then for the Testing MC, I would be
> 
> Right, I think reproducibility and ease of setup/use is really
> important.
> 
>> very interested to hear whether people feel it would be
>> beneficial to work towards a more exhaustive solution supported
>> upstream: kernel.org Docker images or something close such as
>> Dockerfiles in Git or another type of images with all the
>> dependencies included.  How does that sound?
> 
> A few thoughts around this:
> 
> Having first party Dockerfiles could be useful but how would they be
> used? Perhaps building a kernel in such a container could be plumbed
> into Kbuild, such that the container manager could be invoked to build
> the image if it does not exist then build the kernel in that image? This
> might be a lofty idea but it would remove a lot of the friction of using
> containers to build the kernel so that more people would adopt it?

That's a great idea, and I think it's why having a live
discussion at Plumbers would make sense as it's going to be
harder to reach answers in a thread like this.

> Another aspect of this is discoverability. I think a big problem with a
> project like TuxMake is that while it is developed for the kernel
> community, it is not a first party project, so without word of mouth,
> there is not a great way for other people to hear about it.
> 
> I think it would be a good idea to try and solicit feedback from the
> greater kernel community at large to ensure that whatever solution is
> decided on will work for both testing systems and
> developers/maintainers. I think that a first party solution for having a
> consistent and easy to set up/work with build environment has been
> needed for some time but unfortunately, I am not sure how much
> discussion around this problem has happened directly with those folks.

Yes, that was my intention here with this thread to start
widening the audience with the upstream community.  My
understanding is that the issue hasn't been suitably framed to
enable constructive discussion yet.  I'll consider submitting a
proposal for the Toolchain track next.

>> [1] https://lpc.events/event/18/contributions/1665/
>> [2] https://hub.docker.com/u/tuxmake
>> [3] https://www.linaro.org/blog/tuxmake-building-linux-with-kernel-org-toolchains/
> 
> As an aside, consider using me as a point of contact for anything
> ClangBuiltLinux related instead of Nick going forward, he has stepped
> away to focus on LLVM libc for the immediate future.

Noted, thank you.

> Thanks a lot for bring up this topic. I think it is important to work on
> and I look forward to talking through this at Plumbers.

That would be greatly appreciated.  Many thanks already for your
insightful feedback.

Best wishes,
Guillaume


