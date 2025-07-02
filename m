Return-Path: <bpf+bounces-62192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A514AF6305
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 22:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1C747B01D3
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 20:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAD02F5314;
	Wed,  2 Jul 2025 20:10:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7292D373C;
	Wed,  2 Jul 2025 20:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751487016; cv=none; b=GTuZLHEiGY6cEr783DMTWnbqoQjkjea/AVPy4P507XQtIUAmAWTZLwUl5lHrTjh+K2M2/uoHG/i4d+gOoWxuBYfiHHGJYwduCuweGQb6jdMiirm9U4eTvjdaUXITVuTnt9jq6tFatIC237NP63OokMh3zqfWZqjQ6WzF0n/cx8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751487016; c=relaxed/simple;
	bh=nzLtOk+CXiy19j1c+qXN2YOSaypKxf6gyl1O+1Hw96k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kiqZAt9lZxb63Ik3LgOEYIKwrV9onx+q4DoUc2Bg7XcMCkiFN3GcBymlNGRoWS5w6uQ6XULCyoYPSmVQ2im3v3KTlBST93ssR2RpOCed6XNeol40h86nx04dVlo9YajKu9F091h8yZKdu6yJuT6LtDAUPCrAUqOtlP7Xzp3pZa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 79491C0464;
	Wed,  2 Jul 2025 20:10:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 25BFB2000E;
	Wed,  2 Jul 2025 20:10:07 +0000 (UTC)
Date: Wed, 2 Jul 2025 16:10:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra
 <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH v12 06/14] unwind_user/deferred: Add deferred unwinding
 interface
Message-ID: <20250702161005.0ed06389@batman.local.home>
In-Reply-To: <16b8f9a8-b1f8-43ac-9dad-4b83d8ca9f9f@efficios.com>
References: <20250701005321.942306427@goodmis.org>
	<20250701005451.571473750@goodmis.org>
	<20250702163609.GR1613200@noisy.programming.kicks-ass.net>
	<20250702124216.4668826a@batman.local.home>
	<CAHk-=wiXjrvif6ZdunRV3OT0YTrY=5Oiw1xU_F1L93iGLGUdhQ@mail.gmail.com>
	<20250702132605.6c79c1ec@batman.local.home>
	<20250702134850.254cec76@batman.local.home>
	<CAHk-=wiU6aox6-QqrUY1AaBq87EsFuFa6q2w40PJkhKMEX213w@mail.gmail.com>
	<482f6b76-6086-47da-a3cf-d57106bdcb39@efficios.com>
	<20250702150535.7d2596df@batman.local.home>
	<47a43d27-7eac-4f88-a783-afdd3a97bb11@efficios.com>
	<20250702152111.1bec7214@batman.local.home>
	<20250702153600.28dcf1e3@batman.local.home>
	<20250702154048.71c5a63d@batman.local.home>
	<16b8f9a8-b1f8-43ac-9dad-4b83d8ca9f9f@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 9h9bqzrzn8kj7pqoe7o7tdions79fckj
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 25BFB2000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18bEf0NTakmzstSfpVPMrAT7yaOXg6Xl6E=
X-HE-Tag: 1751487007-9541
X-HE-Meta: U2FsdGVkX18YhDIwOmvt7Nq3GZemF2igDaPgUIAFQzyiTZ4jbqKL1zC8HHre1kjHbJLFH62lIHgDE3EMN41B1+Gl3vXap2n8H5+75xJXqCPhI8c0CvE43eN8FTLYolsqwnBa9R0zOvyv2+PfFNa0Tv/jwuMvoo4bDTyKfH1mhO7mtClbtGqZVSxZX95KBG94aXPU0RbxwGbXzNSGnac3v/ZK9/+i2F+at96jJhteB5dGzzIxQrCblbThzASRkLqZnhi4ps8Lhf3piHyWgtdi3SRloGcnqMrMws0kmLvTfwHsUkWWAKc0HnuZNGTx2714nbDmgFaY1+I9DsnKIUkT919ni3uckgdAl43kR6LPbTXYp5SatiNtXdnNKxwfJicf

On Wed, 2 Jul 2025 15:48:16 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> FWIW, I liked your idea of making the cookie 64-bit with:
> 
> - 32-bit cpu number,
> - 32-bit per-CPU free running counter.
> 
> This is simple, works on 32-bit archs, and it does not overflow as often
> as time LSB because it counts execution contexts.

I have no problem with implementing that. But Linus had his concerns.
If he's OK with that version, then I'll go with that.

-- Steve

