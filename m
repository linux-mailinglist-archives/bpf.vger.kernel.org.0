Return-Path: <bpf+bounces-73821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B0FC3AC70
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 13:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D378C4E434D
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 12:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F9F322768;
	Thu,  6 Nov 2025 12:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RwQHY1yT"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2CA320CCC;
	Thu,  6 Nov 2025 12:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762430630; cv=none; b=kRv93LbNH8pDk7SBfVaq2JgQxXFj0Ru2uZY3W5kbJmqvLtvW1gRKoObmLvisaC4K8Kv8AjYmlc6Upd2+8sCwoi9K5rqOKSAg/k3Se/kNUe4rZYje1PuWqui19ish93wEZMSnykjojJVGKd10qNHbVWIZoxHtSV+CjaEdXbjKmVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762430630; c=relaxed/simple;
	bh=xPndWYHrKjIW683VqdFxYivnaq7QyI30qDB4XxDAx+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVpzoVYlYV2RnWC4COorZongMkAdAeF/J28hGh6PxH0o/l63VjDSUWLZS8Mdv+f+D1DwOUzGSSLF8taJ6VgG6T+fsRNOL7u6e/+eM/zQpaF9AQciybXJYJFgn0lPSLz5oTjPP1JU9sB9UwMRj/oHHqbdX8XqwHWHCo2LN4ZkM5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RwQHY1yT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xPndWYHrKjIW683VqdFxYivnaq7QyI30qDB4XxDAx+s=; b=RwQHY1yTSWq4C00HsYAl4bt3nt
	feySs10IXq3vXo1uLTpC+Aob0Lz710z4gH8FxVn6wxbS0YH9HtuzEAOZnu7q6PFnQMCtfrr9OsPN5
	5pbFnfiUu6Fpeb2wTHRBFrPbhda4OucBf4RRAlA/wRzuQvJ8ZAIV8H5+LrLEJNk95xUHd1j4JvijO
	Ba8Xzd0OY7ItD6JN93TruTgdxiujYMEcWKqoG/T79PSOZn9TQVF5NZ6rE3SagHLiJkcq4JbxEmN3Y
	w4zqfvVa6b7FMRiBUdiOHTW5wB5U0/VHuEm8OCERX88EbuYq4sVE9lnwp+xL9JCyV8aaa9q3WynQa
	CQ7xj0sA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGyi2-00000001JlR-3fq8;
	Thu, 06 Nov 2025 12:03:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DCA2430023C; Thu, 06 Nov 2025 13:03:22 +0100 (CET)
Date: Thu, 6 Nov 2025 13:03:22 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, jiang.biao@linux.dev,
	bpf <bpf@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf,x86: do RSB balance for trampoline
Message-ID: <20251106120322.GU4067720@noisy.programming.kicks-ass.net>
References: <20251104104913.689439-1-dongml2@chinatelecom.cn>
 <CAADnVQKQXcUxjJ2uYNu1nvhFYt=KhN8QYAiGXrt_YwUsjMFOuA@mail.gmail.com>
 <4465519.ejJDZkT8p0@7950hx>
 <1986305.taCxCBeP46@7950hx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1986305.taCxCBeP46@7950hx>

On Wed, Nov 05, 2025 at 03:46:47PM +0800, Menglong Dong wrote:

> The "return POS" will miss the RSB, but the later return
> will hit it.

Right this. The moment you have an asymmetry in the RSB all future RETs
will miss and that sucks. Missing one but then hitting all the others is
much better.

Anyway, I see this thread came to a good conclusion. Just one more note,
people are working on supervisor shadow stack support, which is going to
make all these things even more 'fun' :-)

