Return-Path: <bpf+bounces-47837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1187BA0082C
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 12:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE73C16294A
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 11:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9301B1F9EC6;
	Fri,  3 Jan 2025 11:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dRAgZ/9q"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E551F9AA6;
	Fri,  3 Jan 2025 11:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735902060; cv=none; b=AeJcX1vzMbI0JoPPHpNXZ5KNq4C/7HADT1DgFEeNa4oKvlNLk4mwjK/cUv/TLMrKjaBdt7lEyDBJ6sQetaJF5d9GEBWz6Vq9R5xwdwAh/gQ9qYXBcxETXfOy457mMNOQcbVCndclM2UMKOGyvGnCqmCbrQl/F5As5tzQn4N0/PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735902060; c=relaxed/simple;
	bh=kCKe2Ks+QM4kYNmgk821lfdHE7oyY5Ac+0sddsz4bos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEsR+1I4dUMOZagL0A6p6Lkjb8r0T/0Ql/DkNkvdbQjxiOhny+tdYYqyrrqhISyUCI9+NyF1gR9ykzSE8lnm+StghNEelEZGJMyAr9mRuc94NKd3m0ZuyRGAu0r8wkn30XJQhj7TLbgKHinKAI//uYSkEyvQnr7fRzovLHAd23A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dRAgZ/9q; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kCKe2Ks+QM4kYNmgk821lfdHE7oyY5Ac+0sddsz4bos=; b=dRAgZ/9qJJL5A0d7Rz8Wh1R0oB
	m4Jn3lyT5Zh4weA+5O2WW3QwK29Go1mmZwPbgRi2s3J8J5FXnJT2lb5+i9O9E9UrvzGUnYZuo7EGP
	iq8pslLMOkUudqyfb2u5pVUFBG5nNSXTR2eanKJ+XLG0GL++DxmUnlqnR7k5C2mAWJ6LotK/2nXwS
	2JoUKzBUwzXC4AxOS4mkQsm4ZvVpMWcytrt5+Bo96XEe6LFqu4rbcU8QVP6877b6ESWSzxzgtGlB0
	ikLWQ0D97FsZluyC7CsFJA/gVanpUe4PX4Ks31uF7FU9AF+fzKD0XlWqREalMqKhnPXbtDndJUNLe
	t7dyuo0Q==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tTfQ6-00000005iPO-1wIy;
	Fri, 03 Jan 2025 11:00:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EA3F53003AF; Fri,  3 Jan 2025 12:00:45 +0100 (CET)
Date: Fri, 3 Jan 2025 12:00:45 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>, linux-kbuild@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Zheng Yejian <zhengyejian1@huawei.com>,
	Martin Kelly <martin.kelly@crowdstrike.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [POC][RFC][PATCH] build: Make weak functions visible in kallsyms
Message-ID: <20250103110045.GA22934@noisy.programming.kicks-ass.net>
References: <20241226164957.5cab9f2d@gandalf.local.home>
 <CAHk-=wiL8B2=fPaRwDPGgQhVs=3G=8Gy=QyR59L85L0GF67Gbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiL8B2=fPaRwDPGgQhVs=3G=8Gy=QyR59L85L0GF67Gbg@mail.gmail.com>

On Thu, Dec 26, 2024 at 07:35:18PM -0800, Linus Torvalds wrote:

> Btw, does this actually happen when the compiler does the mcount thing for us?

Yeah, so the linker literally just drops the symbol name on the floor,
nothing else. So all the section information -- either compiler
generated like mcount locations, or manually inserted like alternatives
-- stick around for the 'dead' code.

The only time the toolchain has enough visibility to do the right thing
is when doing a full LTO build, at that point can the compiler see the
weak function is actually unused and do 'normal' DCE, including all the
resulting extra section stuff.

