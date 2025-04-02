Return-Path: <bpf+bounces-55151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECD8A78E39
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 14:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EB02188E4AF
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 12:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D366E238176;
	Wed,  2 Apr 2025 12:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QFBFVjWd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Uta/GO1P"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072CA219306
	for <bpf@vger.kernel.org>; Wed,  2 Apr 2025 12:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743596523; cv=none; b=ZTCByjG5Rw4GZoAFelbJFeUbxFj76UEf8+Wd6/MAKrRuyOLFkkXt1VQC4l/QaWcT0vq2YjtrG/oCx5s0b4LiHEY2IOPr4+4xdiMkYBQUFYsGKD94trm52Ws6DnCiriupFKh5B5xuFJyvHhYjWYv+PeCq1Y+FlU8QUGbHABS9ZIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743596523; c=relaxed/simple;
	bh=UBRum9l8MDa8213xrmZLZNobQGTlhvD8h4dGzOkWOvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPteqclM+552qQCiUr9T8p11bxGG5/55zSERmh7h5Jn9F7EGENefKQYTPgkNgenpgIdhW/pxfwJeuA53SQ0o2hDMGq6WCR2LKvJ1npRTN36ZYGB9LYJ/yYLjUTCN8kU+F/bFqvJ68Rp8H+rx3NDiOghuxhCXtWB2EswSNe9we90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QFBFVjWd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Uta/GO1P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 2 Apr 2025 14:21:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743596520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b6+P3J0MCvupXRbN02OWH0YultdezJqThw7DALLJrzA=;
	b=QFBFVjWdkTa4twVOnqIludcA54iv6QsTjo5u5kbDierfTugdiFivzt4uJ43owKWmRlmtq+
	ll8uSjzNz+chB6oA1ungE5LJzN8Pt5EKIo7KBpTraCy9QHqKGWgYk3oORZM1GdkSQ2Zfzv
	d839j6RATBqSmloLh7UKg3aA+o7+iWRW0aPgm57WSU75y+vk1kkQEhSRvuKs9b3bqKqRfW
	U7qkoIiZ1lBG7zdvJn7pPwPy0zDSai58JvHf4EX/fBTiBpQnBNsT0ZNHVX4j8gbxf2DqkS
	p5xXaIbSFDVpWyUpPSP3DXqfv54Ovv6oayHbrWDsx1rxV7PhFn6nbrcKy6anCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743596520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b6+P3J0MCvupXRbN02OWH0YultdezJqThw7DALLJrzA=;
	b=Uta/GO1PllKhaWjzjlrHFjkzBYUVuG2ab0T4w4qPrKDnGoftcv65sXE6twYY01hIfXmF84
	IUaHBiJJbVKVuvBQ==
From: Sebastian Sewior <bigeasy@linutronix.de>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Peter Ziljstra <peterz@infradead.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: uprobe splat in PREEMP_RT
Message-ID: <20250402122158.j_8VoHQ-@linutronix.de>
References: <CAADnVQLLOHZmPO4X_dQ+cTaSDvzdWHzA0qUqQDhLFYL3D6xPxg@mail.gmail.com>
 <20250401172225.06b01b22@gandalf.local.home>
 <CAEf4BzbVmUfDVEs1ndy5hr2YYA5xgt7NODjNhy4x+Syfbr1yaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4BzbVmUfDVEs1ndy5hr2YYA5xgt7NODjNhy4x+Syfbr1yaA@mail.gmail.com>

On 2025-04-01 15:01:55 [-0700], Andrii Nakryiko wrote:
> So, write_seqcount_begin()'s documentation states:
> 
> /**
>  * write_seqcount_begin() - start a seqcount_t write side critical section
>  * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
>  *
>  * Context: sequence counter write side sections must be serialized and
>  * non-preemptible. Preemption will be automatically disabled if and
>  * only if the seqcount write serialization lock is associated, and
>  * preemptible.  If readers can be invoked from hardirq or softirq
>  * context, interrupts or bottom halves must be respectively disabled.
>  */
> 
> 
> In our case we cannot have readers invoked from hardirq/softirq. It's
> the writer that can be invoked from hardirq (timer).
> 
> So what did I do incorrectly here? Should I still disable hardirqs
> just to satisfy that seqprop_assert()?

You don't have a lock associated with the seqcount. The writer side
ensure that there can only be one writer because the timer can only fire
once.
The reader side uses raw_seqcount_try_begin() so it does not require the
writer to make progress. Meaning if it preempts the writer then it will
continue and make progress.
If these conditions remain, why not
s/write_seqcount_begin/raw_write_seqcount_begin// ? This would avoid the
checks as per "I know best" and I don't have a reason why a lock would
make sense to exclude multiple writers.

> Peter, any opinion?

Sebastian

