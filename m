Return-Path: <bpf+bounces-34386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9309692D1B5
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 14:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C577D1C23B6B
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 12:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9C51922F2;
	Wed, 10 Jul 2024 12:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pd0Z887G"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF82128369;
	Wed, 10 Jul 2024 12:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720614865; cv=none; b=ro8W70WnevC4i7Qh5RlOFMQOaNqxbu9kPs88EDsHH6ZTfDX74sF9tHogBLBj7k3eVdctIPySZOrmsRLiBH7HpzJXcDoDqf0ndZcw5J2CLu/CZKD9BclcWaBBF6QYFcxCx6Tp3JJoQvRMT9Ur8e5hI/Pb5gshb2vXfLiFqVhR/kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720614865; c=relaxed/simple;
	bh=wewUG4IZchjeZssOIuJfKJylJpoaeDqsB1KujGr5eHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGMhhKwayDuctcSGPMTEQEBh4zB0lO+RQ6sQN6P8hVkNquXoXPynWZOHbC1zxVS4rXtCL4TJvoK2enuZ/u5s+DV17YzEzx1nXvqoGizRPyXoB4JynJZh4XaLIN4KOhcXgwDhCHan+eoviolRWqZNZX7jAZ3+AJTysYLVDvxeink=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Pd0Z887G; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=48Y4AkOsRZ9alFneJAl39JsCkF7IC2qXmdtCVDdzxKk=; b=Pd0Z887GwhyPOXnZEoAU33AOq1
	uGPX5oFdiowKCT3gB5cN3h6+DUDxS+o27rZWuakQXKVKOFxXNH0dprc935HA348i55X7RI9qlThx+
	Zr7hV0a4h2QTSnDlJz5qZtack32BpD6QUTBEItgclstfsW75AUB0x7v8ulpBqxz6AAUM3JQQ1wpbq
	eksmq4wd3aTxuG09gDmwWZgwdkri/4QB3mB6y2XQ9JjhpgDiqkqsjXfEk+Z+W6zamRkfw5Ty6mlpZ
	3HKIQ2vhSvTwrOe75UdJvjsZcPTFyZ7lHlkAF9joJfG3W35LyyzucYpjb7IEjs1J11sRgtTQ/vS9H
	KbuRn90Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRWWY-00000009H4Y-2XuR;
	Wed, 10 Jul 2024 12:34:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2CF9C300694; Wed, 10 Jul 2024 14:34:18 +0200 (CEST)
Date: Wed, 10 Jul 2024 14:34:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, mingo@kernel.org,
	andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, oleg@redhat.com, jolsa@kernel.org,
	clm@meta.com, paulmck@kernel.org, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
Message-ID: <20240710123418.GH28838@noisy.programming.kicks-ass.net>
References: <20240708091241.544262971@infradead.org>
 <20240709075651.122204f1358f9f78d1e64b62@kernel.org>
 <CAEf4BzY6tXrDGkW6mkxCY551pZa1G+Sgxeuex==nvHUEp9ynpg@mail.gmail.com>
 <CAEf4BzZbjqoNw4jJkO3TOmPJSxyCAze56YeUQULPbK3oLmOvsA@mail.gmail.com>
 <20240710101239.GW27299@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710101239.GW27299@noisy.programming.kicks-ass.net>

On Wed, Jul 10, 2024 at 12:12:39PM +0200, Peter Zijlstra wrote:

> > [   11.262797] ------------[ cut here ]------------
> > [   11.263162] refcount_t: underflow; use-after-free.
> > [   11.263474] WARNING: CPU: 1 PID: 2409 at lib/refcount.c:28
> > refcount_warn_saturate+0x99/0xda
> > [   11.263995] Modules linked in: bpf_testmod(OE) aesni_intel(E)
> > crypto_simd(E) floppy(E) cryptd(E) i2c_piix4(E) crc32c_intel(E)
> > button(E) i2c_core(E) i6300esb(E) pcspkr(E) serio_raw(E)
> > [   11.265105] CPU: 1 PID: 2409 Comm: test_progs Tainted: G
> > OE      6.10.0-rc6-gd3f5cbffe86b #1263
> > [   11.265740] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> > [   11.266507] RIP: 0010:refcount_warn_saturate+0x99/0xda
> > [   11.266862] Code: 05 ba 29 1d 02 01 e8 e2 c0 b4 ff 0f 0b c3 80 3d
> > aa 29 1d 02 00 75 53 48 c7 c7 20 59 50 82 c6 05 9a 29 1d 02 01 e8 c3
> > c0 b4 ff <0f> 0b c3 80 3d 8a 29 1d 02 00 75 34 a
> > [   11.268099] RSP: 0018:ffffc90001fbbd60 EFLAGS: 00010282
> > [   11.268451] RAX: 0000000000000026 RBX: ffff88810f333000 RCX: 0000000000000027
> > [   11.268931] RDX: 0000000000000000 RSI: ffffffff82580a45 RDI: 00000000ffffffff
> > [   11.269417] RBP: ffff888105937818 R08: 0000000000000000 R09: 0000000000000000
> > [   11.269910] R10: 00000000756f6366 R11: 0000000063666572 R12: ffff88810f333030
> > [   11.270387] R13: ffffc90001fbbb80 R14: ffff888100535190 R15: dead000000000100
> > [   11.270870] FS:  00007fc938bd2d00(0000) GS:ffff88881f680000(0000)
> > knlGS:0000000000000000
> > [   11.271363] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   11.271725] CR2: 000000000073a005 CR3: 00000001127d5004 CR4: 0000000000370ef0
> > [   11.272220] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [   11.272693] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [   11.273182] Call Trace:
> > [   11.273370]  <TASK>
> > [   11.273518]  ? __warn+0x8b/0x14d
> > [   11.273753]  ? report_bug+0xdb/0x151
> > [   11.273997]  ? refcount_warn_saturate+0x99/0xda
> > [   11.274326]  ? handle_bug+0x3c/0x5b
> > [   11.274564]  ? exc_invalid_op+0x13/0x5c
> > [   11.274831]  ? asm_exc_invalid_op+0x16/0x20
> > [   11.275119]  ? refcount_warn_saturate+0x99/0xda
> > [   11.275428]  uprobe_unregister_nosync+0x61/0x7c
> > [   11.275768]  __probe_event_disable+0x5d/0x7d
> > [   11.276069]  probe_event_disable+0x50/0x58
> 
> This I'll have to stare at for a bit.

I found one put_uprobe() that should've now been a srcu_read_unlock().
That might explain things.

