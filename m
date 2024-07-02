Return-Path: <bpf+bounces-33612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D575923B53
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 12:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E21F1B21C14
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 10:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D261586D5;
	Tue,  2 Jul 2024 10:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kGUDfGYy"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FAD154449;
	Tue,  2 Jul 2024 10:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719915838; cv=none; b=pnkv5eSdkYGLDaWZ87SlmTFRU7nxih4S5ZTg0m9WPzXonD3fUuJIHn3PZ8quOVEEkq3gF1SjAQYTY1k2BCQPef5ILdictQztC/bijR8VaZ/A6Mr1zmHf5rZ/KJYx7dnIY4B1K/f6ZqS8nxjt/nV5gET0eSl95HapbNjbD8NXovU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719915838; c=relaxed/simple;
	bh=qa4CkARPGsFqAiGL1ve5C5ZCSijr/lHdCXNuTNLg2FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7ISb7FDwcurKlzWG+L/rTsbVwaIzcq0VzRjwvG6D/GE6sLS4ViHI+rbrhdB4qZzg6LJ9mJviF7feozmK8viEmZ5THW7QzTxwCJW//HfDyBEYyhkYnmwDs6XD+p5NArk7Vt3r3DRV6iSwhxhj4VekZWBgAuo/F8qnTVUx4iltxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kGUDfGYy; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qa4CkARPGsFqAiGL1ve5C5ZCSijr/lHdCXNuTNLg2FY=; b=kGUDfGYy6kZfabLc3NZBycQA8f
	SunCUsB1kh0ibA+xuFK8YKZIAiK4q8X/afBzEF86ZgHw6IJRmaM32RlHdtaTM/lYxHJZ/8FeUpXZT
	+A9XSC1Q7857XhrXRgsT7sULtIurNahdx7iRA3eMFZNRrRZWC/N2S0shOplkyUAqbSfOYsrfNrnNU
	nmVz3XV7d1qan2PShzSLQWhF6dszGRiQg5/WTTUt+HP4BB9IdzBA0AGhBl7ay7VKoHYGycJ+CsPqK
	Bsu6ci7wAo5hB1gfX7LDjQH7FcyPqMIZosWlC4t9IC30mUs/vI73N4iuXsRkKVlT7AaWwEaFyfcFB
	nfjAvxhQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOafy-00000009o48-0WPy;
	Tue, 02 Jul 2024 10:23:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B1E9C300694; Tue,  2 Jul 2024 12:23:53 +0200 (CEST)
Date: Tue, 2 Jul 2024 12:23:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, oleg@redhat.com, mingo@redhat.com,
	bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	clm@meta.com
Subject: Re: [PATCH v2 00/12] uprobes: add batched register/unregister APIs
 and per-CPU RW semaphore
Message-ID: <20240702102353.GG11386@noisy.programming.kicks-ass.net>
References: <20240701223935.3783951-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701223935.3783951-1-andrii@kernel.org>

On Mon, Jul 01, 2024 at 03:39:23PM -0700, Andrii Nakryiko wrote:
> This patch set, ultimately, switches global uprobes_treelock from RW spinlock
> to per-CPU RW semaphore, which has better performance and scales better under
> contention and multiple parallel threads triggering lots of uprobes.

Why not RCU + normal lock thing?

