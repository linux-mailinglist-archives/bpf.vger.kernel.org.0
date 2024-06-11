Return-Path: <bpf+bounces-31795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1721B9037C2
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 11:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9526B288AC4
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 09:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E5C176ACE;
	Tue, 11 Jun 2024 09:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="itxhBSKv"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9E1176244;
	Tue, 11 Jun 2024 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097730; cv=none; b=cE7bdpOrCgzFcuDhCCJOJPz2DCtKisWHJO0vfcgGbwqfTlVVzwkq06k+4Rqt8Q9JrywacumTr4EXLCCfqyuoxYd+cp7KzMeUPknR3xO0IK2D9QXbhp81uMvOE7dLqXoz8Eh+mjZLtoM1WcOyQfiEFjpOWK5AYWUhvlDO0ye6NVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097730; c=relaxed/simple;
	bh=GJfGdbvvDWDOSvMogO1Tx6TxQynGnwfRw1Ryjv4ZsEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmD0tH1GMKlTlr0KCJGqe/6XajOQUokF5ZAqD6Y0OSeuqivy9MjgD1tsJ/GsJwz3F3twOep+OPyHPiENGUb9gx06QuJlW+3KDFaJQ5GNJw9G50+/Z7Bg79TqfBa8JiF2fduY2JlPjGO9gByIlWH/vuO8fBATj80K7aK2wcEnoCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=itxhBSKv; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=48fO26X+Km0rKUwpbNZyNPOVhd3pCMp769Y0WYI3ihM=; b=itxhBSKv0p/wc0lUGnJR/DddVO
	9WdLWU6WuLCqw+8TiFpN+bxjI6/QGAHJDydIXBBODbEQgUvZ5J5AhG8H9TJyiNHfWxbk0luODpxKM
	kHLYskN4r4QtodTqm1ML5jE/7RNID3n0bRZUzfLD6HbeO/HAYvGTINnICZxKUCguLlLZNQuL+CXkD
	GrlYF+NNUyta+WeVJ96j4XrKNnmAwsf4offdjzwaRUWIz6jwC7Kazs+vcrAXxXQ1UjnpvuW8g1XoS
	+jnFZt/GCvKn/tJrh+cg1P4ae6LLUcdQiF9ovxpnK8XLlAXJa+SIQ/ThQRZ7s4pOqLpSUYYSwhYC0
	MQOGUddA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGxhS-000000023Ga-3ooz;
	Tue, 11 Jun 2024 09:21:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C0122302DA2; Tue, 11 Jun 2024 11:21:57 +0200 (CEST)
Date: Tue, 11 Jun 2024 11:21:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Zheng Yejian <zhengyejian1@huawei.com>
Cc: rostedt@goodmis.org, mcgrof@kernel.org, mhiramat@kernel.org,
	mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
	jpoimboe@kernel.org, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [RFC PATCH] ftrace: Skip __fentry__ location of overridden weak
 functions
Message-ID: <20240611092157.GU40213@noisy.programming.kicks-ass.net>
References: <20240607115211.734845-1-zhengyejian1@huawei.com>
 <20240607150228.GR8774@noisy.programming.kicks-ass.net>
 <57e499a4-e26d-148f-317d-233e873d11b4@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57e499a4-e26d-148f-317d-233e873d11b4@huawei.com>

On Tue, Jun 11, 2024 at 09:56:51AM +0800, Zheng Yejian wrote:
> On 2024/6/7 23:02, Peter Zijlstra wrote:

> > Oh gawd, sodding weak functions again.
> > 
> > I would suggest changing scipts/kallsyms.c to emit readily identifiable
> > symbol names for all the weak junk, eg:
> > 
> >    __weak_junk_NNNNN
> > 
> 
> Sorry for the late reply, I just had a long noon holiday :>
> 
> scripts/kallsyms.c is compiled and used to handle symbols in vmlinux.o
> or vmlinux.a, see kallsyms_step() in scripts/link-vmlinux.sh, those
> overridden weak symbols has been removed from symbol table of vmlinux.o
> or vmlinux.a. But we can found those symbols from original xx/xx.o file,
> for example, the weak free_initmem() in in init/main.c is overridden,
> its symbol is not in vmlinx but is still in init/main.o .
> 
> How about traversing all origin xx/xx.o and finding all weak junk symbols ?

You don't need to. ELF symbl tables have an entry size for FUNC type
objects, this means that you can readily find holes in the text and fill
them with a symbol.

Specifically, you can check the mcount locations against the symbol
table and for every one that falls in a hole, generate a new junk
symbol.

Also see 4adb23686795 where objtool adds these holes to the
ignore/unreachable code check.


The lack of size for kallsyms is in a large part what is causing the
problems.

