Return-Path: <bpf+bounces-42372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5B89A3752
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 09:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1A0CB21067
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 07:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4465C18892F;
	Fri, 18 Oct 2024 07:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Oj2cg8dJ"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4382A2BAEF;
	Fri, 18 Oct 2024 07:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729236999; cv=none; b=GcgUNRiAUpKciI+zdwWjtD/5Eh3Wy4lkG+vatl2JuvKwdr2LCe+/bRAF/+PpCYA3C+K2auaj5Q6bKDAIIb6eCv8iiR409su8YEaSjd2EQ7zDwlG0YV02NPLxWOIIyPYtAwlIr6yEG7bFEQcRb0BIAVNLT9KijUYGtJ2PuF2zmIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729236999; c=relaxed/simple;
	bh=3IfLJ4pjse76+ZyfYwtjQuaoG74v06OITHVdsWiYv/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8snB3HDLgnw3nYklKCQr60ZhSkfwki4Sn7WhkFD7O2zpzpIweiwyUrdlV1mPW1rgY3lnJQrkbrsEbWP5a/els7z7J48sdkBrL5Q9zHQ9694UPNZlLC5yjswPqWC/5JsCQHnRLD1ILhhhbsxcL+GC/4x+MBC6KBoN+omKOtzpLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Oj2cg8dJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=srtrSatCDAehrfmBU/pr314pv7W9OyFy0E8IHnhv/R4=; b=Oj2cg8dJ5LL+pWCTiTRREEMOK9
	8+T5wYe8lX7IT7R3F1AHOiyyPn5vsKvsowyvGr0KN7o2yL8+m2IYO9iiLZ2TURTQ+PQEujL3iJjxJ
	lQBkD/IgY2/P+D/92DNxvnMBz+Uvh5QsECKBDQLAwgwzJAswcC+moAqGF2aAm0Ie79TXTLoJENL+J
	77ham7tIpTbFTSQTF2vpelha73SaCavdxzGkz6X8VZi9xcNWehz9kTNZlxNCyyIpMKK2zQ9ib87c1
	SABASl8Xr7B22vLcYaznw7ytooCj5Q4L4HPqjOtCeKpdgkEB9UT6xoFyOSulhF3LcZakuroxfQRWg
	9UuiGjFw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t1hXA-0000000Cc54-2BFa;
	Fri, 18 Oct 2024 07:36:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8097B3005AF; Fri, 18 Oct 2024 09:36:28 +0200 (CEST)
Date: Fri, 18 Oct 2024 09:36:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Liao Chang <liaochang1@huawei.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"linux-perf-use." <linux-perf-users@vger.kernel.org>,
	Kernel Team <kernel-team@meta.com>
Subject: Re: The state of uprobes work and logistics
Message-ID: <20241018073628.GC17263@noisy.programming.kicks-ass.net>
References: <CAEf4BzarhiBHAQXECJzP5e-z0fbSaTpfQNPaSXwdgErz2f0vUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzarhiBHAQXECJzP5e-z0fbSaTpfQNPaSXwdgErz2f0vUA@mail.gmail.com>

On Wed, Oct 16, 2024 at 12:35:21PM -0700, Andrii Nakryiko wrote:

>   - Jiri Olsa's uprobe "session" support ([5]). This is less
> performance focused, but important functionality by itself. But I'm
> calling this out here because the first two patches are pure uprobe
> internal changes, and I believe they should go into tip/perf/core to
> avoid conflicts with the rest of pending uprobe changes.
> 
> Peter, do you mind applying those two and creating a stable tag for
> bpf-next to pull? We'll apply the rest of Jiri's series to
> bpf-next/master.

>   [5] https://lore.kernel.org/bpf/20241015091050.3731669-1-jolsa@kernel.org/

I don't actually appear to have these.. Jiri, can you bounce them my
way or resend?

