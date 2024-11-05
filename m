Return-Path: <bpf+bounces-44047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5751D9BCF2C
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 15:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9684B244A1
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 14:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962F21D9A69;
	Tue,  5 Nov 2024 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hE5SMa9j"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7E01D9698;
	Tue,  5 Nov 2024 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730816617; cv=none; b=mhnlfDfjZt5xMt1E8qdELdZA66roFma2i9OitSbq4aUgiUFjdCIowceLts3N3Za3oZbWQw8j8Th1icRm0cexD4iq0hiZEBVWsA/gVv5mg4IHXfoqwBhwOK1lLbnQQahKsfvQ8SZEXduLVwhkUDWI14crmUFZEmhHTZWt3xK6uqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730816617; c=relaxed/simple;
	bh=zLytG1YfSkTOzqHClOfI+HzwbqnLK1RfiSzGudw3e8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxcs+9PBw1gEWC1/02Gp7R5KCWevbRAWnbo6mI/8lFc9e00nWoG9pFNSHXttDQbLDCsPoYsKyvep14HUYiDQ1Cd/y3nNKDLeWLVRQg3EADTpoty5cd1Oy8kMBvW9V6WPEmFsfKj+xigy4TMSv72L+z5hbsSpGy2kIjaP453qJro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hE5SMa9j; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SOAGP58wCd2LK1x1wfdrBzdm/43jUDWJm6SoFRYCB5E=; b=hE5SMa9ja6bM9MX3KD8srWKF/7
	uN9q/WjHUJUzbNLDi2OMp6FBBS+7MECqEozBGOJBvqzLZ4w2SNDJYJGz9N3OI1EzFoLEnXLtx8+Ap
	KcYNPAVUwR4BhNwEV8OpFqyjxBd7ooa37zOqHi7BFak3e9tr3Ct4TWXrSLSz+9SJEUHllSteeuyox
	D+H3Tv89fDm217KCRlEkrQtyV7cxLTCdo5z0S02d9wJCPqq/h6CzD6kNtd5fVbcR3T21yBqwJ4t18
	Yt1XhMRX5XNXbKbm56e7NpouAh8zZX+c3ULbqHrE2/CUgievJsbEk3TTwZN3pFbYRV3r6N7cY/OA9
	3kMx3+QQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8KSt-0000000BlgF-2kwM;
	Tue, 05 Nov 2024 14:23:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4DA2830042E; Tue,  5 Nov 2024 15:23:27 +0100 (CET)
Date: Tue, 5 Nov 2024 15:23:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC perf/core 05/11] uprobes: Add mapping for optimized uprobe
 trampolines
Message-ID: <20241105142327.GF10375@noisy.programming.kicks-ass.net>
References: <20241105133405.2703607-1-jolsa@kernel.org>
 <20241105133405.2703607-6-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105133405.2703607-6-jolsa@kernel.org>

On Tue, Nov 05, 2024 at 02:33:59PM +0100, Jiri Olsa wrote:
> Adding interface to add special mapping for user space page that will be
> used as place holder for uprobe trampoline in following changes.
> 
> The get_tramp_area(vaddr) function either finds 'callable' page or create
> new one.  The 'callable' means it's reachable by call instruction (from
> vaddr argument) and is decided by each arch via new arch_uprobe_is_callable
> function.
> 
> The put_tramp_area function either drops refcount or destroys the special
> mapping and all the maps are clean up when the process goes down.

In another thread somewhere, Andrii mentioned that Meta has executables
with more than 4G of .text. This isn't going to work for them, is it?



