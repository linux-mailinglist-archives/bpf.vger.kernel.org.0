Return-Path: <bpf+bounces-45046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BA09D0352
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2024 12:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D2BA1F20403
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2024 11:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37AD1714B7;
	Sun, 17 Nov 2024 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LhASRHp6"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9F780054;
	Sun, 17 Nov 2024 11:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731844199; cv=none; b=DHSgdlldv1lTY4BvwT49H7hnCNgmPak6Dd//CPHvGu65c8CPdfp5ktv7swBN94xSxkdclzEQB5KqYPcspAL4VTxnuXHckbIFmGCGsbRtasvc7SE9b62zT9TdVaWJxuYsYTrkhmYkmQWEtsil6czPVbS9xRG80WSSie5KN56tRNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731844199; c=relaxed/simple;
	bh=BR6tEUEAXyNktteiJU0Ti9OpaPc5VMyZ8NsUTmLYRk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dy0CqLNiIebhs4y4p8fVG15URJBLL0jHCqr8BeptMiMWQQMf9Mn9MsBzMFOvWPbFC/tu/sF1qsKWt1c2QTVXygyVxpj4JdSVK4n9nTcAWWV/sXyq2Ta44r3KGxmFMbzj4mRu0JZ5VKRJ0CHfnNtqNmaQIhLyfuZ+NW0iwhTfcKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LhASRHp6; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M/R6LRXdublxiC2V1kGQuuBfrcKBn4lBOlKqBBRk3QM=; b=LhASRHp6waAsZb724BndWI0NMu
	1supTlUkplgKlO9Fj2BMINBr8rSQ3kcUSFkHNa9AJYjrpTonUfZpYjrkuNzOOIWFH4+/F4pscQ3wy
	OnFMz+mOKvJUi16OWaR3iatQc04GYG6jT9DVk0/9Qz4VrARmN89pw72Mbz/YHrQyhG0bCJVRGkLC+
	BwYiUhhuPxAchpxlTjmhOqJRfd2SeKbLF51XkKGqfAIV5Z5tOTdfc/kd7koejGMFECiDiQQC2NxN5
	j9uaS8kxMMZ4YakdRar7eu8qKcH7j5CXstnhPPfOuXuPVT2vr3HmMEqxOCrU1b7m9lzMHx8CwGS7b
	YFg+tE7A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tCdml-000000007gm-1IyX;
	Sun, 17 Nov 2024 11:49:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B92A63006B7; Sun, 17 Nov 2024 12:49:46 +0100 (CET)
Date: Sun, 17 Nov 2024 12:49:46 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC 00/11] uprobes: Add support to optimize usdt probes on
 x86_64
Message-ID: <20241117114946.GD27667@noisy.programming.kicks-ass.net>
References: <20241105133405.2703607-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105133405.2703607-1-jolsa@kernel.org>

On Tue, Nov 05, 2024 at 02:33:54PM +0100, Jiri Olsa wrote:
> hi,
> this patchset adds support to optimize usdt probes on top of 5-byte
> nop instruction.
> 
> The generic approach (optimize all uprobes) is hard due to emulating
> possible multiple original instructions and its related issues. The
> usdt case, which stores 5-byte nop seems much easier, so starting
> with that.
> 
> The basic idea is to replace breakpoint exception with syscall which
> is faster on x86_64. For more details please see changelog of patch 7.

So this is really about the fact that syscalls are faster than traps on
x86_64? Is there something similar on ARM64, or are they roughly the
same speed there?

That is, I don't think this scheme will work for the various RISC
architectures, given their very limited immediate range turns a typical
call into a multi-instruction trainwreck real quick.

Now, that isn't a problem if their exceptions and syscalls are of equal
speed.

