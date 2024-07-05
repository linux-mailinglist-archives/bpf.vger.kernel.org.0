Return-Path: <bpf+bounces-33935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD41B92827F
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 09:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDEEA1C22CD1
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 07:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E583F144D07;
	Fri,  5 Jul 2024 07:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Eq/QQ1py"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1617B1F61C;
	Fri,  5 Jul 2024 07:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720163452; cv=none; b=Inu68SFprun6VPXzyVW0rsY5kCfVP/gPtUoEcyimf2jwEwBfeP3I12lobYdJuCl/jQg9AIg9gE0d652oThCzFlGghUHj0rkZgI1n8AUOdw0Zfv38ElVMxpliC4NhuPs9PPyXoxn3CEL+mwkHGiW6xD/gV4aXuOGx7CuAJKMD85c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720163452; c=relaxed/simple;
	bh=URZqfqwCRL/WjOjIr/reDxmP+5zhj0AQCqWJlDJ7XkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lR6AdAFcG1oUhETGq0b8aYv9gTzbfw9ntJSosaIK6T6CkUXj8GIyM0AaKSbP84bs9FazwGYQQhEREzW418qe7kInFkymcD0s0wIs4s1VZyhmab/cqeL+PUoFGBo55+bUsXZS64+Y0HZLUjmH4jrn68lTzR8hV8JwWz0Z3i1wa3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Eq/QQ1py; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=URZqfqwCRL/WjOjIr/reDxmP+5zhj0AQCqWJlDJ7XkI=; b=Eq/QQ1pyIaqtqiVJQljE85cDjS
	RHBmUWL2QU2dsvyXER8MrdufBN92zXSOziljnvz8bOZ4kAGqGgnz1UmpOvzROWtqUQmefjsi3IAzS
	UV+KB/rVwP3xuZKtOMIjM73R7PM/W1l8NV74JISjTR7jGC19DiRIhWkzg/nWDAxIzdJoxj9KVzxC7
	UFXfM+eAIOQCOm8pK7LRzsFRNctXBa9RE+aEg1f3O/6kgXQFh+fk4OyfuQPqnUpFv9zq5xn6XvN6s
	l2MZUr8zH2lweBWIfJvbw6Hrpiv61PbvjNi+/GrsW6aJNEo5xzNbjB0jsedku0pvcb62H38wl1EP5
	8zYUM4sA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPd5c-00000003hXP-0a0h;
	Fri, 05 Jul 2024 07:10:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CEEF93005AF; Fri,  5 Jul 2024 09:10:36 +0200 (CEST)
Date: Fri, 5 Jul 2024 09:10:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv2 bpf-next 1/9] uprobe: Add support for session consumer
Message-ID: <20240705071036.GW11386@noisy.programming.kicks-ass.net>
References: <20240701164115.723677-1-jolsa@kernel.org>
 <20240701164115.723677-2-jolsa@kernel.org>
 <CAEf4BzZaTNTDauJYaES-q40UpvcjNyDSfSnuU+DkSuAPSuZ8Qw@mail.gmail.com>
 <20240703081042.GM11386@noisy.programming.kicks-ass.net>
 <CAEf4BzY9zi7pKmSmrCAqJ2GowZmCZ0EnZfA5f8YvxHRk2Pj8Zw@mail.gmail.com>
 <202407031330.F9016C60B@keescook>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202407031330.F9016C60B@keescook>

On Wed, Jul 03, 2024 at 01:36:19PM -0700, Kees Cook wrote:

> Yes, please use struct_size_t(). This is exactly what it was designed for.

Kees, please, just let up, not going to happen. I'm getting really fed
up having to endlessly repeat what a piece of shite struct_size() is.

Put your time and effort into doing a proper language extension so we
can go and delete all that __builtin_*_overflow() based garbage.

