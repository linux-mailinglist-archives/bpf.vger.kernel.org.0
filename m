Return-Path: <bpf+bounces-69167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C40B8E9B0
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 01:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9782918973F5
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 23:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89DB244660;
	Sun, 21 Sep 2025 23:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzO8yhS/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528241D416E;
	Sun, 21 Sep 2025 23:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758498480; cv=none; b=CLlWfRArswmEAPlQtZKIG2y6GFg8h/60Ut0Je1ivROW5uctGZC/7ienCQbbT/GsEQYLmETCWid9VF7JA8Tb0ma1GlZXS086zKz4VATPO7q1P7RQPp7Zrnpe3yJzqJnMREMXZcVLITcglFuw7VHBc3EVfJUZMoD1d7wM1VYBi+LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758498480; c=relaxed/simple;
	bh=c1N6iUXtyma0PYLPTtaJzrrxv2w+FmE45bhak9xoyIs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=spPzA6/bd4rlUelQ44Bm7QG+49conual79m21l1gqDySpQIeW4LFmIw8nL1ulze0mRnNh3u4cmduCRJVKrCKRnAuxterECnnLss4iCPrCfSv7wg1Q/Em5KXgSKq6Elx1NboZeyXH8dBLKaUluQDHd7kSP4tKPv3MQTs9hZKRHhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzO8yhS/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C9AC4CEE7;
	Sun, 21 Sep 2025 23:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758498479;
	bh=c1N6iUXtyma0PYLPTtaJzrrxv2w+FmE45bhak9xoyIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TzO8yhS/nItE7z1XoabHem9Ljd7NchsnRzR5/gpml3SiBKlgEjona26FT490sr0yv
	 zRRRomh/9hq5PTHhdHiBDcDH2YbeMOHMQsQyw2C46IaItfUmXS9KT4sHc1Jzd/xdZu
	 L1syppnU12qlEn1hWCHC/y5f4ohnGahDzdJZone7shztqn1ulyF+XieONMzA2nkmo6
	 zHzuFsxJPyZRG4ZSgdzxjR9uW7yQhzyuVS8S2FG7A7ZhMk92eDtdHVu7hM5P1h7ior
	 cFy4dmD31c6kgRcHj3JHDD1WLD9JUEu0T2KxWbEvqP7pJcx+OaylhFytYGTNpfccRK
	 Lslz21dvyvZKQ==
Date: Sun, 21 Sep 2025 19:47:41 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>, Sam
 James <sam@gentoo.org>
Subject: Re: [PATCH v16 06/10] unwind deferred: Use bitmask to determine
 which callbacks to call
Message-ID: <20250921194741.77e6f3b8@batman.local.home>
In-Reply-To: <vxdnyz3e6c5whsd4let47ms75a7kcjykzud6x7d6pwkfd4yd2z@odddgxwsst4d>
References: <20250729182304.965835871@kernel.org>
	<20250729182405.822789300@kernel.org>
	<vxdnyz3e6c5whsd4let47ms75a7kcjykzud6x7d6pwkfd4yd2z@odddgxwsst4d>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Sep 2025 18:00:30 -0700
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> > +		return old & bit;  
> 
> Per the function comment, the function returns 0, 1, or negative.  So
> this should be 
> 
> 		return !!(old & bit)
> 
> right?

Right. Thanks!

-- Steve

