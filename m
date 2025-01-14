Return-Path: <bpf+bounces-48837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F42BA11037
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 19:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECE7B188A8FA
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 18:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874611FAC34;
	Tue, 14 Jan 2025 18:34:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7661C3BFC
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 18:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736879669; cv=none; b=nTVSuTvn1wp8vmgbjsJnfHGUy7OQHLFzjk7XdhXObAqLGx6F4ZJ0s46dxYEb9jxUOcpbwX2P1O5P8TWsfv/VoyS/znPKbvo7ihcWsX2eEyyLNAIPWhXa1gVumwVS5kQRAvmuo8OxvzFZAlH2MO2nh7uJMkjdhgXDkxZH2/Qh8BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736879669; c=relaxed/simple;
	bh=TCk37ADalF3aq/BZXWzqjpMIRqFWWMFb/uy2rQz9iJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bcm9ETyErhQvh1HLmidvDnLt1YfIS2pZeDrnbf9FeHjP916TLXGgiclQMPYluBkJ5SVoD62j1Q4VtNQEjEZRBUCSp5rFPfkBJeFw9xj5cnKMpazeiSMpV5/hYQttWJScdhkxKOePTlq3V31tU4shejrcwM61gY87pyhprhiySvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C7EC4CEDD;
	Tue, 14 Jan 2025 18:34:26 +0000 (UTC)
Date: Tue, 14 Jan 2025 13:34:27 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Michal Hocko <mhocko@suse.com>,
 bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Sebastian
 Sewior <bigeasy@linutronix.de>, Hou Tao <houtao1@huawei.com>, Johannes
 Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>, Matthew
 Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Jann
 Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, linux-mm
 <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v4 1/6] mm, bpf: Introduce try_alloc_pages()
 for opportunistic page allocation
Message-ID: <20250114133427.428e9ab6@gandalf.local.home>
In-Reply-To: <CAADnVQ+kGLtY0eWwaSL4To3z1KwgmsASvYHFkUXtyiVbvCNDbA@mail.gmail.com>
References: <20250114021922.92609-1-alexei.starovoitov@gmail.com>
	<20250114021922.92609-2-alexei.starovoitov@gmail.com>
	<20250114095355.GM5388@noisy.programming.kicks-ass.net>
	<Z4Y6PS3Nj8EMt9Mx@tiehlicka>
	<20250114103946.GC8362@noisy.programming.kicks-ass.net>
	<CAADnVQ+kGLtY0eWwaSL4To3z1KwgmsASvYHFkUXtyiVbvCNDbA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jan 2025 10:29:04 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> Seriously, though, the number of things that still run in hard irq context
> in RT is so small that if some tracing BPF prog is attached there
> it should be using prealloc mode. Full prealloc is still
> the default for bpf hash map.

The one thing to watch out for is hrtimer trace events. They will be called
in hard irq context even in RT. If a BPF program is attached to one of
them, then that could be an issue.

-- Steve

