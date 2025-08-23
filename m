Return-Path: <bpf+bounces-66369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8593EB32C48
	for <lists+bpf@lfdr.de>; Sun, 24 Aug 2025 00:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589DA1B679EA
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 22:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580932ECD10;
	Sat, 23 Aug 2025 22:04:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94523213E90;
	Sat, 23 Aug 2025 22:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755986656; cv=none; b=XU3CF8g9/sx0iQVovZy85kQqblkyg2H0FgbMoyS7h1oX1kQYAa8kIi4A8l3MCgqaKeUq7fK67P+G/EHXajxUBbvkJMViOkLdyKQtUo40deNMiBwsl6s/aM4uOS5xQtEA1LklFZGzvBR7AnM5Yo9GFZmPWOhSyk+rJ17Ct8D1r0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755986656; c=relaxed/simple;
	bh=p8FPxRkpiveFIPvuznvmmdtULMo3VmRFVUcfwq1IO/c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HTBwcCSh9ErVzbLitwrcN/K2bOh4kE7uFBk7pkj+EysO5NgOSnhSjYJI4OcgBtxQbOoTg4bKSKv2ShjYc/xMCPH3ZLx+70uLDQrwIP1GXUpjHV4nMoeblCrqnnrom/9NTWcDB/QnV4rxqYldC63gu85Ytk/Wryir25WsuGLwfCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (2.8.3.0.0.0.0.0.0.0.0.0.0.0.0.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a::382])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 1DA29340E2B;
	Sat, 23 Aug 2025 22:04:08 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>
Cc: acme@kernel.org,  adityag@linux.ibm.com,  adrian.hunter@intel.com,
  ak@linux.intel.com,  alexander.shishkin@linux.intel.com,
  amadio@gentoo.org,  atrajeev@linux.vnet.ibm.com,  bpf@vger.kernel.org,
  chaitanyas.prakash@arm.com,  changbin.du@huawei.com,
  charlie@rivosinc.com,  dvyukov@google.com,  james.clark@linaro.org,
  jolsa@kernel.org,  justinstitt@google.com,  kan.liang@linux.intel.com,
  kjain@linux.ibm.com,  lihuafei1@huawei.com,
  linux-kernel@vger.kernel.org,  linux-perf-users@vger.kernel.org,
  llvm@lists.linux.dev,  mark.rutland@arm.com,  mhiramat@kernel.org,
  mingo@redhat.com,  morbo@google.com,  namhyung@kernel.org,
  nathan@kernel.org,  nick.desaulniers+lkml@gmail.com,
  peterz@infradead.org,  sesse@google.com,  song@kernel.org
Subject: Re: [PATCH v5 00/19] Support dynamic opening of capstone/llvm
 remove BUILD_NONDISTRO
In-Reply-To: <CAP-5=fV+-VZ+SsGL1SJGYMEv-gwkv1AKk_6MZJ4tLBrCXFnMQA@mail.gmail.com>
Organization: Gentoo
References: <87ldnacz33.fsf@gentoo.org> <87cy8mcyy4.fsf@gentoo.org>
	<CAP-5=fV+-VZ+SsGL1SJGYMEv-gwkv1AKk_6MZJ4tLBrCXFnMQA@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 31.0.50
Date: Sat, 23 Aug 2025 23:04:06 +0100
Message-ID: <87zfbpae5l.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ian Rogers <irogers@google.com> writes:

> On Fri, Aug 22, 2025 at 11:52=E2=80=AFPM Sam James <sam@gentoo.org> wrote:
>>
>> > A few months ago, objdump was the only way to get
>> > source line support [0]. Is that still the case?
>>
>> ... or is this perhaps handled by "[PATCH v5 18/19] perf srcline:
>> Fallback between addr2line implementations", in which case, shouldn't
>> that really land first so people can try the LLVM impl and use the
>> binutils one if it fails?
>
> So my opinion, BUILD_NON_DISTRO isn't supported and the code behind it
> should go away. Please don't do anything to the contrary or enable it
> for your distribution - this was supposed to be implied by the name.

We're principally a source-based distribution, so it's not as much of an
issue.

> The forking and running addr2line gets around the license issue that
> is GPLv3* but comes with a performance overhead. It also has a
> maintenance overhead supporting llvm and binutil addr2line, when the
> addr2line output changes things break, etc. (LLVM has been evolving
> their output but I'm not aware of it breaking things yet). We should
> (imo) delete the forking and running addr2line support, it fits the
> billing of something we can do when capstone and libLLVM support
> aren't there but the code is a hot mess and we don't do exhaustive
> testing against the many addr2line flavors, the best case is buyer
> beware. Capstone is derived from libLLVM, I'm not sure it makes sense
> having 2 libraries for this stuff. There's libLLVM but what it
> provides through a C API is a mess requiring the C++ shimming. Tbh, I
> think most of what these libraries provide we should just get over
> ourselves and provide in perf itself. For example, does it make sense
> to be trying to add type annotations to objdump output, to just update
> objdump or have a disassembler library where we can annotate things as
> we see fit? Library bindings don't break when text output formats get
> tweaked. Given we're doing so much dwarf processing, do we need a
> library for that or should that just be in-house? We can side step
> most of this mess by starting again in python as is being shown in the
> textual changes that bring with it stuff like console flame graphs:
> https://lore.kernel.org/lkml/CAP-5=3DfU=3Dz8kcY4zjezoxSwYf9vczYzHztiMSBvJ=
xdwwBPVWv2Q@mail.gmail.com/
> So I think long term we make the perf tool minimal with minimal
> dependencies (ie no addr2line, libLLVM, etc.), we work on having nice
> stuff in the python stuff where we can reuse or build new libraries
> for addr2line, objdump-ing, etc. Use >1 thread, use asyncio, etc.

Yeah, this absolutely sounds like the right direction indeed. I'm glad
to hear it.

>
> For where we are now, ie no python stuff, BUILD_NON_DISTRO should go
> away as nobody is maintaining it and hasn't for 2 years (what happens
> when libbfd and libiberty change?)

They don't change often, though. The fixes are usually trivial when they
do arise.

> We should focus on making the best
> of what we have via libraries/tools that are supported - while not
> forcing the libraries to be there or making the perf binary massive by
> dragging in say libLLVM. The patch series pushes in that direction and
> I commend it to the reader.
>
> No, reordering the patches to compare performance of binutils doesn't
> make sense, just build with and without the patch series if you want
> to do this, but also don't do this as BUILD_NON_DISTRO should go away.

I was asking purely because of the *functionality loss*, though, not
performance. In the thread I linked from just a few months ago with Ingo
Molnar, there was a real issue with llvm or capstone-based disassembly
not showing source information. I'd hit the same problem. Is that fixed now?

This is my principal concern rather than the LLVM dependency (even if
I'd love to avoid that, I understand and appreciate the arguments you're
making above and intent on future direction).

>
> Thanks,
> Ian
>
> * (As I understand the issue IANAL) GPLv3 and GPLv2 can't be linked
> together. Why not just use GPLv3? A major issue for me is that GPLv3
> adds a requirement for =E2=80=9CInstallation Information=E2=80=9D to be p=
rovided,
> which means placing a binary in a cryptographically signed OS
> partition you'd need to reveal the signing key which defeats the
> purpose of signing the partition to ensure you aren't hacked. I like
> open source and using the code, I don't want to be hacked by giving to
> the hackers my signing keys.

I think the way people usually handle this is allowing a custom key to
be added, but then it taints the device. That's how I think routers seem
to handle it often anyway.

