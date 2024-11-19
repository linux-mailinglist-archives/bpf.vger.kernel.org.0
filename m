Return-Path: <bpf+bounces-45153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B788C9D2240
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 10:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7567B2829AC
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 09:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7911B0F0C;
	Tue, 19 Nov 2024 09:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NsNqJwFy"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445C312CDAE;
	Tue, 19 Nov 2024 09:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732007638; cv=none; b=pb7OzwRN6ssv5GnN1/JSqVDivmKhKJ/gIF0baDkHXA/9DLYhdJMPt4ox3ShcKULEIA0SbsPWmYLuLvtP7ETyxn75yYIPUxPcQTeUUhNFwjOWnTa28trW9gOJnki9MIjB9nYMNJpprk5DwPxA0Zd/v8rQzIjR41xCLJAnqUnEQcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732007638; c=relaxed/simple;
	bh=ecTbzJ5AaNWfrV0C1O4VXMVfV5Sfpj63ONG+7CIujDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOjhantewPZ0hRGL4YC1f7Fspzw/Yfh9vjmpSv0KvvAzpEbMQyc5jnfvIQ49tPoAMx7C6DbRr90J8xwBUaZ5vmSA0ABQhBhJ1CQdgzXKeaBIRQm3c2mjsRjRzKnHBUqbK/XjZExY/vjAmqUQ78QJ5JqZqTot9g6jHsED/YzUYQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NsNqJwFy; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fl+NTXtpNg4Pp8q2Lsf9iJ/z+achogFWtubvIsHu1dI=; b=NsNqJwFyPpwrWTn1KZS0+oK0VW
	HQXe0hRFdDH5zdmbQMoDS4arEhib00WDZY0CSkDBwYZh5Y4S1h3frPNXG58jLDaUsBX/jEN/XUb2M
	aiVi2NF5h5yDj8Zk/JHTOTWS7QxlDVuJSJKt1D1GpdldlMfhKsE7cY0B9DL2dzcI487dlCcIGR4wV
	JeEbOBX/9FizfuuAE28MoQy919qfM2wYtz9ppQyKLJjKRbKBC4V1/XCYzZLvZo2WY03hexfnA3V1G
	s2sJgs8CtRmbcD2ZX9UTi0qTamojZfaOVrp0YD6rscnWRsVnUfAnCazeXE2vZ5NTtvMUYCuBbHW4L
	LOF24LWA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDKIw-00000000KUn-0y7U;
	Tue, 19 Nov 2024 09:13:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 16C3A3006AB; Tue, 19 Nov 2024 10:13:49 +0100 (CET)
Date: Tue, 19 Nov 2024 10:13:48 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC perf/core 05/11] uprobes: Add mapping for optimized uprobe
 trampolines
Message-ID: <20241119091348.GE11903@noisy.programming.kicks-ass.net>
References: <20241105133405.2703607-1-jolsa@kernel.org>
 <20241105133405.2703607-6-jolsa@kernel.org>
 <20241105142327.GF10375@noisy.programming.kicks-ass.net>
 <ZypI3n-2wbS3_w5p@krava>
 <CAEf4BzZ4XgSOHz0T5nXPyd+keo=rQvH5jc0Jghw1db0a7qR9GQ@mail.gmail.com>
 <ZzkSKQSrbffwOFvd@krava>
 <CAEf4BzbSrtJWUZUcq-RouwwRxK1GOAwO++aSgjbyQf26cQMfow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbSrtJWUZUcq-RouwwRxK1GOAwO++aSgjbyQf26cQMfow@mail.gmail.com>

On Mon, Nov 18, 2024 at 10:06:51PM -0800, Andrii Nakryiko wrote:

> > > Jiri, we could also have an option to support 64-bit call, right? We'd
> > > need nop9 for that, but it's an option as well to future-proofing this
> > > approach, no?
> >
> > hm, I don't think there's call with relative 64bit offset
> 
> why do you need a relative, when you have 64 bits? ;) there is a call
> to absolute address, no?

No, there is not :/ You get to use an indirect call, which means
multiple instructions and all the speculation joy.

IFF USDT thingies have AX clobbered (I couldn't find in a hurry) then
patching the multi instruction thing is relatively straight forward, if
they don't, its going to be a pain.

