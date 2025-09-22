Return-Path: <bpf+bounces-69222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE13FB91C44
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 16:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D2D93AD906
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 14:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0094027B35C;
	Mon, 22 Sep 2025 14:42:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BEF1B4257;
	Mon, 22 Sep 2025 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758552166; cv=none; b=eY3r9s2QGw7vcdDMnUgCjPIFH08EO7+vrI/xKMrE+wIN3c5+tlyYMC/9SWQzEPC3VYhcqNTaFBLJ/pcyyEei1kL+LZV8GmwJCqKCTsPq4jxyixs/Eiq6DSjD4y5tkSw6VjPtewjtkE0gfvMWQGDrZk21QzUviDGe/tAyqU36Bb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758552166; c=relaxed/simple;
	bh=Fy9oWw8EZpU9EKlvXhF7WepyC69BvXaMNw2K16O/hMo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BMH1c2zUoMTBkavs2QND2A3NQBVLnJDiH7+ntt4lqCRhZ7OKAORNJxiqwnbmiY/dVTuI4gduvL2qo31ceGZl7eoeVqhaqg/7dRcDxLMdJxiLqx9a4Nlvex2Kkend0v4szBrv9R332bfRwHXk+m3dtwCMzsWUbWlDPiGuCtj06as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 83C1DB1FCD;
	Mon, 22 Sep 2025 14:42:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 2F1CE34;
	Mon, 22 Sep 2025 14:42:31 +0000 (UTC)
Date: Mon, 22 Sep 2025 10:42:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Steven Rostedt <rostedt@kernel.org>, Menglong Dong
 <menglong8.dong@gmail.com>, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 kees@kernel.org, samitolvanen@google.com, rppt@kernel.org, luto@kernel.org,
 ast@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH] tracing: fgraph: Protect return handler from recursion
 loop
Message-ID: <20250922104228.4993227e@batman.local.home>
In-Reply-To: <aNFRRa3m6Qm8zzQu@krava>
References: <20250918120939.1706585-1-dongml2@chinatelecom.cn>
	<175828305637.117978.4183947592750468265.stgit@devnote2>
	<20250919112746.09fa02c7@gandalf.local.home>
	<aM5bizfTTTAH5Xoa@krava>
	<20250922151655.1792fa0abc6c3a8d98d052c9@kernel.org>
	<aNFRRa3m6Qm8zzQu@krava>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2F1CE34
X-Stat-Signature: 5m6dza8eerdq5fheuuog9iasxo6kxxca
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+cmRNjfPhQevxwVVsrBXj76Fr4LaCEzak=
X-HE-Tag: 1758552151-367461
X-HE-Meta: U2FsdGVkX1+r8iiyTWCvVbzNqGRqFSi/LZd3+qBMFsYq55nmV1rdpVsIv1x2pIXT3AHi2UMNJUvNOaozexYK45qDrN23a9Fxq/ptGTMS3MAhkSKJ47wG1rX0wsmp801U/BQ+Dc1j5poRmYDeJXOCe0EBtaMZnR/WKJGhuWTGWBECNmruc0Q/aG02YvNRfRqp7Xu7TgvElN6VAAmRuuV+YI2R+nd+SgJogu27UJTKJH9mL6kjQPQcTfIorckUwhdogLEWlr5/LBrL1851l+zUBKSCRhBOTbXBZzgA/q+GmEsZ6hKWvQ/vWkcw1ehXTQk32pG6CcOpJEpDzJ1MdaB4DATN/LK3EagD

On Mon, 22 Sep 2025 15:38:13 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> > I found ftrace_test_recursion_trylock() allows one nest level, can you
> > make sure it is OK?  
> 
> hum, I recall being surprised by that already in the past,
> I thought we fixed that somehow, will check later today

It still does allow one level of recursion, because there's still
locations that can trace in interrupt context before the preempt count
is updated to the new context.

I looked at fixing these, but IIRC, there's several locations in
assembly that do this and it started getting messy. I guess I can try
to fix this again.

-- Steve

