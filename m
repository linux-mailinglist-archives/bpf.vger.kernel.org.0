Return-Path: <bpf+bounces-34410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C0C92D63D
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 18:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E5828815B
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 16:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AAC194C66;
	Wed, 10 Jul 2024 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Htjm1nEQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03AF194AC7;
	Wed, 10 Jul 2024 16:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628696; cv=none; b=SQpmdQkzOD/W7ccyiSMwhLYqbC1vBw44jiXVnuBooOgMqQF000y3m/kW50r6WMsNBohSO7RFlTX5ynUIwCKsHEODc/n1pP7hEsAggHDSvHGODU5wqtYwHgJYHJrebYH6Qejox1PLxTAAdiZVnpSgBZgjZ8BmUCg0mxBQfrun5r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628696; c=relaxed/simple;
	bh=b28R/GkwpJAm+sBRoYcqg6mX/F5BEuGwYUPhlVhgF1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Op49riLrpwqVsAaYKyk7Ps2gApYZQa4kDDnQtFC3il7+0MKAUe7W8H4ox5Urncptq3eip+Hqh51TRUYOG6ZVMGI3ARrTttljwZ7iS/1/cxkRRTNo/5QY/uNFY9RObj1x9QyeBD/jTFSQdjI1RkRBphkEDS90Rj4nfWDaNEJSucc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Htjm1nEQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA25C32786;
	Wed, 10 Jul 2024 16:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720628696;
	bh=b28R/GkwpJAm+sBRoYcqg6mX/F5BEuGwYUPhlVhgF1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Htjm1nEQsAi2jYEy2QSuT09d1ss/ei5BNvSJXz6wJuRK7p+4OIfN4qD6grX+fVDq5
	 y9CNXG77YqXBtjxyBxkFOq6V4BKI5iFbUmmFM5FekHsrhnNVRMbQ9Bd0QZaIb4Sl4D
	 akkS5ECLtn+qUHj/AdL/1F+k+UTRkcsB14C15kgz7Z6ocrDNHpgYMhgpSEA0F57kC5
	 0J8vEDcSb16YhBQrbXyALam7+X4VnSKS2eNni7hbSU6YgCGzY55xelvOqWol9hV2AT
	 +inVoj5dlr82Y7V5mItiXEEByhEgwDJDwZJ0yVEwgnh0ajVHmbdmGaFbvJ9qSqPX4V
	 0qnvhjuYQxP1A==
Date: Wed, 10 Jul 2024 09:24:51 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, x86@kernel.org, mingo@redhat.com,
	tglx@linutronix.de, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, rihams@fb.com,
	linux-perf-users@vger.kernel.org, rick.p.edgecombe@intel.com
Subject: Re: [PATCH v4] perf,x86: avoid missing caller address in stack
 traces captured in uprobe
Message-ID: <20240710162311.gz3njyjshraeuto7@treble>
References: <20240708231127.1055083-1-andrii@kernel.org>
 <20240709101133.GI27299@noisy.programming.kicks-ass.net>
 <CAEf4Bza22X+vmirG=Xf4zPV0DTn9jVXi1SRTn9ff=LG=z2srNQ@mail.gmail.com>
 <20240710113855.GX27299@noisy.programming.kicks-ass.net>
 <CAEf4BzZFU6CEK-=eTo_LTScYCVoBCYXeH_O_AoZd8rBYiwWzdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZFU6CEK-=eTo_LTScYCVoBCYXeH_O_AoZd8rBYiwWzdg@mail.gmail.com>

On Wed, Jul 10, 2024 at 08:11:57AM -0700, Andrii Nakryiko wrote:
> On Wed, Jul 10, 2024 at 4:39 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > On Tue, Jul 09, 2024 at 10:50:00AM -0700, Andrii Nakryiko wrote:
> > > You can see it replaced the first byte, the following 3 bytes are
> > > remnants of endb64 (gdb says it's a nop? :)), and then we proceeded,
> > > you can see I stepped through a few more instructions.
> > >
> > > Works by accident?
> >
> > Yeah, we don't actually have Userspace IBT enabled yet, even on hardware
> > that supports it.
> 
> OK, I don't know what the implications are, but it's a good accident :)
> 
> Anyways, what should I do for v4? Drop is_endbr6() check or keep it?

Given the current behavior of uprobe overwriting ENDBR64 with INT3, the
is_endbr6() check still makes sense, otherwise is_uprobe_at_func_entry()
would never return true on OSes which have the ENDBR64 compiled in.

However, once userspace IBT actually gets enabled, uprobe should skip
the ENDBR64 and patch the subsequent instruction.  Then the is_endbr6()
check would no longer be needed.

-- 
Josh

