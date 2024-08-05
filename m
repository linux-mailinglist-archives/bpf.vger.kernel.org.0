Return-Path: <bpf+bounces-36390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C03E947B8D
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 15:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95CF81C2121A
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 13:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F415615746B;
	Mon,  5 Aug 2024 13:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Eo+FuoeM"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B5418026
	for <bpf@vger.kernel.org>; Mon,  5 Aug 2024 13:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722863266; cv=none; b=Z4NQ0sDFHkd4hKCIr2Dx6IfFW4mSiMpxmkDtR++Q/IXN5rXpHaUr8PaIaXBFoT3KwbC0DQaNF6EFVwHHk15DnkHEShDG9CdSiyIwP2V8aL6z1MBLxdpcv7sfIXMQbNwXI8R0HsdHBc6049CBiz5giS7VQHxr+yavA3CCIavicFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722863266; c=relaxed/simple;
	bh=Ow7HQiSbKpZ/tx40y08QtCm4jBDo0WJepVl6mnuFXSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fICvPhTz2rqP8wEtMWZXlCQhsJSyBddWr3rZIU/g46qoBqI2RWkoV9lhUWR8IrDpGiLnVCCdZPzXdIZD++wsmFaDSIpKYF7z6r4Q1FO1Y+iO+HeX7BavmXfIsEn0+7/t3AErOumYkzmfrlSODe3dBZRXlaHUDuWd8q0Y8GzuBAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Eo+FuoeM; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 5 Aug 2024 07:07:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722863261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QfG1rJMsx4sMmonFqR1+PwROmhJclutVLEX60dLFZ00=;
	b=Eo+FuoeM3vl1bq7vba78BuIAIe24SeA3ZrCOL/r/k21TgiI8WQWNqHUh8mZxqnqFTPsJ4L
	oMbZj5G2EqCHemHIId4RYcZvVM3LarmC+AyZENIsBz5pekbMzun1J5qQYn08PsgYri1GQA
	j3G2BluHDT2ovwSGXPWWw94MfeTYJXg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jose Fernandez <jose.fernandez@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: BPF arena atomic example not working
Message-ID: <i3vhnsonkddufpjgutryllczwqemjnwebjyw7tlciiy7wpgsmh@gwbe4xld24cj>
References: <c5i2ggshxbl66rm7jiy2fbqg2s5roiqjq6fv5u3pswlxodz2xw@cn47hrarvapn>
 <s2pee4ycr6u7jlpp2y4zibmwtqb4ak3z25zvizlgfgrez4dpvm@27bbxbskjxgj>
 <CAADnVQLH62GEB+uwjqqUa+uGhNyvBsDCFzQkyK2rYr-G9Ubtcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLH62GEB+uwjqqUa+uGhNyvBsDCFzQkyK2rYr-G9Ubtcw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On 24/08/04 05:31PM, Alexei Starovoitov wrote:
> On Sun, Aug 4, 2024 at 1:40 PM Jose Fernandez <jose.fernandez@linux.dev> wrote:
> >
> > On 24/08/04 09:59AM, Jose Fernandez wrote:
> > > Hi folks,
> > >
> > > I have not found BPF arena documentation, beyond the patches and selftests.
> > > I'm using the arena_atomics selftest as reference to create a simple BPF program
> > > that increments a value atomically.
> > >
> > > bpf: https://github.com/jfernandez/bpf-playground/blob/main/arena.bpf.c
> > > userspace: https://github.com/jfernandez/bpf-playground/blob/main/arena.c
> > > common header: https://github.com/jfernandez/bpf-playground/blob/main/bpf_arena_common.h
> > >
> > > I'm using the 6.10.2 kernel and libbpf 1.4.3.
> >
> > I forgot to mention that I was using the latest clang release (18.1.8), and this
> > turned out to be the issue. The arena bpf program loaded after I used clang
> > compiled from the llvm-project master branch.
> >
> > I now realise that __BPF_FEATURE_ADDR_SPACE_CAST flag is only available starting
> > with the 19.1.0 RC:
> >
> > $ git --no-pager tag --contains 65b123e287d1320170bb3317179bc917f21852fa
> > llvmorg-19.1.0-rc1
> > llvmorg-20-init
> 
> 
> That is correct and sorry about this footgun in bpf_arena_common.h.
> The cast_kern() and cast_user() macros were added there only for
> selftests to make sure the kernel part of arena is tested when llvm is
> older than 19 which is likely the case for many bpf developers.
> The cast_kern/user() are obviously unnecessary with llvm 19+.

Hi Aexei, thank you for confirming.

> I think we need to create a common directory/repo somewhere
> with ready-to-be-consumed .h and .c with various algorithms based on arena.
> So people don't repeat your debugging experience.

After I got the atomic example working, I moved to a custom struct based on
the list and htab examples. Another surprise was that bpf_arena_alloc_pages()
requires the bpf prog to be sleepable. Will this always be the case?

I want to use arenas in a non-sleepable raw tracepoint program. Your description
in the patch says that you could fault-in pages from userspace to avoid needing 
to call bpf_arena_alloc_pages() from bpf. I haven't been able to figure out the
correct pattern do this. I'm happy to subtmit a selftest if you could provide
a few pointers.

> For example I've copy pasted glob_match() from kernel to bpf prog and
> it works:
> https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git/commit/?h=arena&id=7fd6f96cc80ac8e1ba2838bb1570dd4aed81c567
> More such examples/samples are needed to realize the power of arena.

