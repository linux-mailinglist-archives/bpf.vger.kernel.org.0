Return-Path: <bpf+bounces-34055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1865929F6C
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 11:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D435B27858
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 09:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDF776C61;
	Mon,  8 Jul 2024 09:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SSOGol7g"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CC44F88C;
	Mon,  8 Jul 2024 09:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720431718; cv=none; b=qQ+VInCZSJv69Ks/lMVHTFoQz/p3020XaLLuc0HLgkhV9nyhNaSPcCJaJjETNUuF2jpKGCC9jZJFCvIHK87GeRLeV31Ll69CEjfBYs0Hq4Uc0sU6Vh4oqr6xzDxPSKEzLIjx7SgaArDLtjHryiCOX9Mz+XwAOP+4tqDGD7Nn0d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720431718; c=relaxed/simple;
	bh=ZlxeEDjHIcofzfH902WiH0niH94aGCc5LSZ68+IVe+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utPY4LDv1TZpBkP76Qj6AQsj57H5pWEl7Hg+nlloCpAKDNekjCq8fLBm/7lERhEMZmXi6BIuEZp1jRZ6a0zSlM82w3Iqz90QpbIPcrzP2xEssaS2XWbmvFf8YZKzWgWb+2CaXQmTSwG3Zk+z8gPegigyluyVgqI4un6J7Bfklgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SSOGol7g; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pKS+oSufz1eafXT5eQa4h84xYuDBPKzlEApXrtYxFeM=; b=SSOGol7g9Ouuq5bzRMTs9TPTdf
	bxfJDiNRe9AYmR2Su0dkmTB9KpZnzBV8u1UpIMyRRXWjD85UglyZPIbo5SXBaxE1iAQhlP4+5oMTJ
	Gb8wuLEwQ4Y/zMlSDUmm18ujvPgpc4Nv9LYS0XSmID9+g/6XkSkomrjfmzDuQDnhnesAvMpoOHH9w
	f8eVIljRB8rTcbJn1xpB1VyGtD/4wpptt124Wg/tEAO8V81Av7jngZcp/CQ+kjZbjbpCpd0yNXET/
	8NwoCUFgdSJ8eCDafpcc7JC1iaeY/1s6ZYNY3sxhuv/BjGx5B6eM1dPpDobg/Fjz9u2hIfUtsur/0
	mgKoUZUg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQksW-00000006hzd-22Z2;
	Mon, 08 Jul 2024 09:41:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 20FB5300694; Mon,  8 Jul 2024 11:41:48 +0200 (CEST)
Date: Mon, 8 Jul 2024 11:41:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv2 bpf-next 1/9] uprobe: Add support for session consumer
Message-ID: <20240708094148.GH11386@noisy.programming.kicks-ass.net>
References: <20240701164115.723677-1-jolsa@kernel.org>
 <20240701164115.723677-2-jolsa@kernel.org>
 <20240703085533.820f90544c3fc42edf79468d@kernel.org>
 <CAEf4Bzbn+jky3hb+tUwmDCUgUmgCBxL5Ru_9G5SO3=uTWpi=kA@mail.gmail.com>
 <ZoV3rRUHEdvTmJjG@krava>
 <CAEf4BzYKVbCEGupX47fwM0XSzwwmXs+0sVpcAdp3poFLkjMA6Q@mail.gmail.com>
 <20240705173544.9ef034c30ae93c52164ecc1b@kernel.org>
 <Zof3RIqSl6TgaVKq@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zof3RIqSl6TgaVKq@krava>

On Fri, Jul 05, 2024 at 03:38:12PM +0200, Jiri Olsa wrote:

> > Agreed. BTW, even if the uprobe is removed, the ret_handler should be called?
> > I think both 1 and 2 case, we should skip ret_handler.
> 
> do you mean what happens when the uretprobe is installed and its consumer
> is unregistered before it's triggered?
> 
> I think it won't get executed, because the consumer is removed right away,
> even if the uprobe object stays because the return_instance holds ref to it

Yep, that is my understanding too. RI keeps the uprobe object around,
but the consumers can go at any time.


