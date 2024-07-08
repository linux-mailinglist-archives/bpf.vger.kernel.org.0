Return-Path: <bpf+bounces-34145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E9992ABC2
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 00:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B91E282A5A
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 22:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA1214F9DC;
	Mon,  8 Jul 2024 22:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gtucker.io header.i=@gtucker.io header.b="Up0O9Dca"
X-Original-To: bpf@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB8214D718;
	Mon,  8 Jul 2024 22:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720476657; cv=none; b=D1Z1a3MH5I0tBTYSVSC8thFTxx1/GkArCPzVXI8aQOJB0gww9ZXZ8xvn2XqB55NYL0LKNxJlKV0XEmz6sq6OqkQeFfp7Wx8GbpTe3wG7c1977fmbtapG8T26oN/g6PYVsMV1wDkSiDW8BlX6aHOLhWZvlsYMN2RzRcGN2utQt8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720476657; c=relaxed/simple;
	bh=5UsUObC0/KKWIMavGDA73Hj3cvjxYkOVXJo+CQyzx7E=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=CzP74cJvk7Dppu4VttwboLArg4oJQDbRybXDg+Q5RDhRtWdb66ct+0DmaRAVFqrDzTA5wiNfoY9n566T0dYXfqNukT0M3cEhT2ZQQIG+mYggeA9mlI8XxrJJpbTe/kzUu4f6E8IDUwsnBggRty4UgClhUg0MkSZhcfVb3kbh3gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gtucker.io; spf=pass smtp.mailfrom=gtucker.io; dkim=pass (2048-bit key) header.d=gtucker.io header.i=@gtucker.io header.b=Up0O9Dca; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gtucker.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gtucker.io
Received: by mail.gandi.net (Postfix) with ESMTPSA id B4DF6FF804;
	Mon,  8 Jul 2024 22:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gtucker.io; s=gm1;
	t=1720476652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oZ5wzEZQjhyCIlXR6z+QZsZFscm+l+6h9ZCxJ7SE/p0=;
	b=Up0O9DcaKTvMJZe1gWWIRVs5IJRtFv5NNVU+BdsCl3BAtQVcMdOrE9o2/NQ7FcVXWZK9U/
	IkOgTCMIhSJRNrnxAIW1mBM/PRiE/g39v54E5cmwMn650GoobrLuVXqxyRlSJB/smtwQTj
	tkgYUQMNi9IVhB/A2UjNuWSBE8r4C8jzx86ztJcT1y7BQW/QY9sDaiAYzabm4+f17EKuoW
	LbrJK6S2+8oGmUozwXLWf01arZVXl8z/yKgP1kPhg4fDRewzPh2RmKwk8o1FyvEn1zoI2R
	qyHbeVwwpJ4ibzvPFqe2kWiVCnE7ZwGaVoObP4XG8T5M2J2LNNcdwsv5soUa6A==
Message-ID: <f80acb84-1d98-44d3-84b7-d976de77d8ce@gtucker.io>
Date: Tue, 9 Jul 2024 00:10:51 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Nick Desaulniers <ndesaulniers@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>
Cc: llvm@lists.linux.dev, rust-for-linux@vger.kernel.org, yurinnick@meta.com,
 bpf@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 automated-testing@lists.yoctoproject.org
From: Guillaume Tucker <gtucker@gtucker.io>
Organization: gtucker.io
Subject: Plumbers Testing MC potential topic: specialised toolchains
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: gtucker@gtucker.io

Hello,

While exchanging a few ideas with others around the Testing
micro-conference[1] for Plumbers 2024, and based on some older
discussions, one key issue which seems to be common to several
subsystems is how to manage specialised toolchains.

By "specialised", I mean the ones that can't easily be installed
via major Linux distros or other packaging systems.  Say, if a
specific compiler revision is required with particular compiler
flags in order to build certain parts of the kernel - and maybe
even a particular compiler to build the toolchain itself.

LLVM / Clang-Built-Linux used to be in this category, and I
believe it's still the case to some extent for linux-next
although a minimal LLVM version has now been supported in
mainline for a few years.

A more critical example is eBPF, which I believe still requires a
cutting-edge version of LLVM.  For example, this is why bpf tests
are not enabled by default in kselftest.

Then Rust support in the kernel is still work-in-progress, so the
rustc compiler version has to closely follow the kernel revision.
Add to this other alternative ways to build Rust code using
rustc_codegen_gcc and native Rust support in GCC.

The list can probably be extended with things like nolibc and
unusual cross-compiler toolchains, although I guess they're also
less commonly used.  And I guess GCC support has otherwise been
pretty stable since maybe the v2.6.x days but there might still
be special cases too.  Performance and optimizations is another
factor to take into consideration.


Based on these assumptions, the issue is about reproducibility -
yet alone setting up a toolchain that can build the code at all.
For an automated system to cover these use-cases, or for any
developer wanting to work on these particular areas of the
kernel, having the ability to reliably build it in a reproducible
way using a reference toolchain adds a lot of value.  It means
better quality control, less scope for errors and unexpected
behaviour with different code paths being executed or built
differently.

The current state of the art are the kernel.org toolchains:

  https://mirrors.edge.kernel.org/pub/tools/

These are for LLVM and cross-compilers, and they already solve a
large part of the issue described above.  However, they don't
include Rust (yet), and all the dependencies need to be installed
manually which can have a significant impact on the build
result (gcc, binutils...).  One step further are the Linaro
TuxMake Docker images[2] which got some very recent blog
coverage[3].  The issues then are that not all the toolchains are
necessarily available in Docker images, they're tailored to
TuxMake use-cases, and I'm not sure to which extent upstream
kernel maintainers rely on them.


Now, I might have missed some other important aspects so please
correct me if this reasoning seems flawed in any way.  I have
however seen how hard it can be for automated systems to build
kernels correctly and in a way that developers can reproduce, so
this is no trivial issue.  Then for the Testing MC, I would be
very interested to hear whether people feel it would be
beneficial to work towards a more exhaustive solution supported
upstream: kernel.org Docker images or something close such as
Dockerfiles in Git or another type of images with all the
dependencies included.  How does that sound?

Thanks,
Guillaume

[1] https://lpc.events/event/18/contributions/1665/
[2] https://hub.docker.com/u/tuxmake
[3] https://www.linaro.org/blog/tuxmake-building-linux-with-kernel-org-toolchains/

