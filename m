Return-Path: <bpf+bounces-72008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AEFC055E7
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 11:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF2B40435D
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 09:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514C4309F06;
	Fri, 24 Oct 2025 09:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZY59KGDu"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C3C2ECD3A;
	Fri, 24 Oct 2025 09:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761298185; cv=none; b=QqLxLpxuYLggNuuBhWSEZmaK7uStgReq46O/n9XHTR9HuqaOAF1eZ/IRgC1U/zdEB10Q1EdSCKv1AAEgRMf65bRLGKsloxUMEI1RFPNkED0BPrkw9PCrVKy3Qdm2dnRN7cr8niZVlww4qGZADAjY8a9Ebk5KHmVXcFntj4iQTBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761298185; c=relaxed/simple;
	bh=JF76XAoKNVO9L4nQszY7FwGTkQ7OLRInClINm+CWxbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnpgHNbNM0SO8H/IVSD/YmX9ZjzT+RZ5Ng9Xnsn58m8T2dTARKTlG3UzwxJNjc3KqjtNwSWhPZCzDON8vbHExTcNkQyeK1cEv2eEKSQJJ0r+YWQhKwiS90HTdGDhqT6NYswkoRJiRmBgwO0NKMKtnQJbEUeNv7XxZXqnK5zgjoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZY59KGDu; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JF76XAoKNVO9L4nQszY7FwGTkQ7OLRInClINm+CWxbM=; b=ZY59KGDuwstrgRFBJR+P2Ayry/
	DaCwQeivOdMAlLCDL2WwKV0f3CeU7V3UG0jXw0BOhkQiU/6bVBcfeOrcMvjm2l1zlDr/cTqpSNEUB
	UGhIRTW+ISKP7PY15HTRRQYwGwNo2eV8VSzZmUOtFi9qBzY18+djW1+K8uLnbiA+pRgxNRVFmU31d
	sguSvcz2oau1XATy93UIkqoZcC0UkbHrPuQUBVhaIUD6t23LMCdYQZFkIezTjVnxUk87jYB52azrd
	MXkOQPaYqifMtZF956NVEJ9r/wLuLVkit1YHUVQJeH9XBucchNmA4G0ngwyzBfa4CMWixQO/yQKih
	R64Ow8eA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCDFJ-00000002AZn-2LKC;
	Fri, 24 Oct 2025 08:34:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1257730023C; Fri, 24 Oct 2025 11:29:26 +0200 (CEST)
Date: Fri, 24 Oct 2025 11:29:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, x86@kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>,
	Kees Cook <kees@kernel.org>, Carlos O'Donell <codonell@redhat.com>
Subject: Re: [PATCH v16 0/4] perf: Support the deferred unwinding
 infrastructure
Message-ID: <20251024092926.GI4068168@noisy.programming.kicks-ass.net>
References: <20251007214008.080852573@kernel.org>
 <20251023150002.GR4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023150002.GR4067720@noisy.programming.kicks-ass.net>

On Thu, Oct 23, 2025 at 05:00:02PM +0200, Peter Zijlstra wrote:

> Trouble is, pretty much every unwind is 510 entries long -- this cannot
> be right. I'm sure there's a silly mistake in unwind/user.c but I'm too
> tired to find it just now. I'll try again tomorrow.

PEBKAC

