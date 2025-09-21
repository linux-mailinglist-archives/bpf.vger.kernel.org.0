Return-Path: <bpf+bounces-69163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CF9B8E940
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 00:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534F517A465
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 22:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E84274B28;
	Sun, 21 Sep 2025 22:52:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521231D5174;
	Sun, 21 Sep 2025 22:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758495140; cv=none; b=JUdtsyDyfXbTfNB4y5b1YsDNhZbQGrPcJbKmZHynnULF3ADx4hJfMVnV22Mb4Lb5445YFHpGrTO/CAVRjfaF6g8IycvB6xM14ITKiN/nJhpyoAQu5MfjsHqc8HU7nudRFZo4P6QdWrBPuCZ99DJpGc4so2sns4/ZgZaKNHYnyeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758495140; c=relaxed/simple;
	bh=l6iB8zEC32wE/0xRKZAEOKfkRmHgBdDZEOE8AUayh/M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a69G/B+j5BEJAkplJZu1jd385q0NNXHZURByOzI8/xKHABlsK2Tly2g5ylI/zQgfAn4XwJAFqrM5WoxF7mNl0LTYXmH4m0Y0tkNjrSdOL30XXWBBfV1p/vocGI/D/Wr5boOw9Nsv/rR8oFHjwTvnTBji2d/+GzarEyxcr1bzyDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id A1129140436;
	Sun, 21 Sep 2025 22:52:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 47E512002B;
	Sun, 21 Sep 2025 22:52:04 +0000 (UTC)
Date: Sun, 21 Sep 2025 18:52:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Steven Rostedt
 <rostedt@kernel.org>, Menglong Dong <menglong8.dong@gmail.com>,
 jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 kees@kernel.org, samitolvanen@google.com, rppt@kernel.org, luto@kernel.org,
 ast@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH] tracing: fgraph: Protect return handler from recursion
 loop
Message-ID: <20250921185203.561676ad@batman.local.home>
In-Reply-To: <20250921130519.d1bf9ba2713bd9cb8a175983@kernel.org>
References: <20250918120939.1706585-1-dongml2@chinatelecom.cn>
	<175828305637.117978.4183947592750468265.stgit@devnote2>
	<20250919112746.09fa02c7@gandalf.local.home>
	<20250921130519.d1bf9ba2713bd9cb8a175983@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ymjgf5r4ph4miwi3whi5e3di6tdf3psp
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 47E512002B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18P5y9ZRtFgbQJyiNAHzWvyyES5VKcbakI=
X-HE-Tag: 1758495124-875404
X-HE-Meta: U2FsdGVkX1+FbqB4YdQR/TVeMe3gUqMQgNczUCEbyU4RO+OheBoWHICpYVR8RknLRiSrRM1TlcgSHtu1NbdyBvpJ8KfZGGEkzIaC4ySNsM70lTDqTibAYq2HF4tO7YDYjNmofIXm7fBuDsX1hgTjzo4avFePDe84OJ9ig/K/rG3+Ta+dvZ/T4mcXpU6oCM0Bm+n/ap+5kq1qELckN/HmYimKjF9ndkvDS4U2bF/YOGcw1tpXYNz/BwG28M6seXMtkrsHFT0VVTSqVKIUbwfdw3dXliOTII4YnFhveGRuqV4J5XL9Z+2jr1gypyDNqjKYjwniGyw+0lLlRjFrHcHVq3QRjCpDDCuk

On Sun, 21 Sep 2025 13:05:19 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

>  
> > The reason I would say not to have the warn on, is because we don't have a
> > warn on for recursion happening at the entry handler. Because this now is
> > exposed by fprobe allowing different routines to be called at exit than
> > what is used in entry, it can easily be triggered.  
> 
> At the entry, if it detect recursion, it exits soon. But here we have to
> process stack unwind to get the return address. This recursion_trylock()
> is to mark this is in the critical section, not detect it.

Ah, because the first instance of the exit callback sets the recursion
bit. This will cause recursed entry calls to detect the recursion bit
and return without setting the exit handler to be called.

That is, by setting the recursion bit in the exit handler, it will cause
a recursion in entry to fail before the exit is called again.

I'd like to update the comment:

+	bit = ftrace_test_recursion_trylock(trace.func, ret);
+	/*
+	 * This must be succeeded because the entry handler returns before
+	 * modifying the return address if it is nested. Anyway, we need to
+	 * avoid calling user callbacks if it is nested.
+	 */
+	if (WARN_ON_ONCE(bit < 0))
+		goto out;
+

to:

	/*
	 * Setting the recursion bit here will cause the graph entry to
	 * detect recursion before the exit handle will. If the ext
	 * handler detects recursion, something went wrong.
	 */
	if (WARN_ON_ONCE(bit < 0))

-- Steve

