Return-Path: <bpf+bounces-56804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAB0A9E409
	for <lists+bpf@lfdr.de>; Sun, 27 Apr 2025 19:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA34A7AD119
	for <lists+bpf@lfdr.de>; Sun, 27 Apr 2025 17:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBC41531DB;
	Sun, 27 Apr 2025 17:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0QaRjoE"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D7F4A11
	for <bpf@vger.kernel.org>; Sun, 27 Apr 2025 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745773960; cv=none; b=q6dLXl2a/KsbQdT27ZKhmGL7gZQoPiEPL1pdvMNbVxJQku8DCV73YAK4GZH0N+9gwny0UQxo4ZQvsoJ6ShOAoKBpCwxMpyG3qD2c6oQ8YP4M8Hr82M21T+gCI7i9/4KpGAXp/H8bJXjsDqP7B/xrbn0Lp1+3lhxfPIQaOit7VPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745773960; c=relaxed/simple;
	bh=/UX2eRg/DxKbZA4wXsLnH0EE2F/jJhGgRQ6zS46tbKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GM4jw2RFresvwxf9Ex4H1EVZMHXvPFZZHTwTdB6ms26k9ZpGafFM0bGHDY8/0PdeHBtmWj+xm60RSaPVWswNHxZ7QWgHS54nWj3lNBDyEu9aPV4ARPaNTQIv1WVb2iqJOEhFVemLVQ433m7ooiu1BXHPNHsp9m5cihX+slDYO90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0QaRjoE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745773958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vSo5qlLIAZ4o+8kKkCdWcYkoEy2DHr0WHSd64t2G4bM=;
	b=F0QaRjoEUN4h12f/mKKEkFrkwIFPso00Co6fgjRunXQS3e5mCRFkPC6q7P5tHajBiezgEk
	fpX9RYNOdYSyWc96YHXcQaY1MOg8G3KLKwd4G4v688KvsY6i1JkowPEwibFZxCZGRhQnEf
	nSomv6MIINsIizYkT9pYHCTkQHUQiK8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-McLM3ZcROEq8TXP7O4_W_w-1; Sun,
 27 Apr 2025 13:12:32 -0400
X-MC-Unique: McLM3ZcROEq8TXP7O4_W_w-1
X-Mimecast-MFC-AGG-ID: McLM3ZcROEq8TXP7O4_W_w_1745773949
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8386B19560AA;
	Sun, 27 Apr 2025 17:12:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.18])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 563B5180045C;
	Sun, 27 Apr 2025 17:12:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 27 Apr 2025 19:11:51 +0200 (CEST)
Date: Sun, 27 Apr 2025 19:11:43 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 10/22] uprobes/x86: Add support to optimize
 uprobes
Message-ID: <20250427171143.GA27775@redhat.com>
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-11-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421214423.393661-11-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

I didn't actually read this patch yet, but let me ask anyway...

On 04/21, Jiri Olsa wrote:
>
> +static int swbp_optimize(struct vm_area_struct *vma, unsigned long vaddr, unsigned long tramp)
> +{
> +	struct write_opcode_ctx ctx = {
> +		.base = vaddr,
> +	};
> +	char call[5];
> +	int err;
> +
> +	relative_call(call, vaddr, tramp);
> +
> +	/*
> +	 * We are in state where breakpoint (int3) is installed on top of first
> +	 * byte of the nop5 instruction. We will do following steps to overwrite
> +	 * this to call instruction:
> +	 *
> +	 * - sync cores
> +	 * - write last 4 bytes of the call instruction
> +	 * - sync cores
> +	 * - update the call instruction opcode
> +	 */
> +
> +	text_poke_sync();

Hmm. I would like to understand why exactly we need at least this first
text_poke_sync() before "write last 4 bytes of the call instruction".


And... I don't suggest to do this right now, but I am wondering if we can
use mm_cpumask(vma->vm_mm) later, I guess we don't care if we race with
switch_mm_irqs_off() which can add another CPU to this mask...

> +void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
> +{
> +	struct mm_struct *mm = current->mm;
> +	uprobe_opcode_t insn[5];
> +
> +	/*
> +	 * Do not optimize if shadow stack is enabled, the return address hijack
> +	 * code in arch_uretprobe_hijack_return_addr updates wrong frame when
> +	 * the entry uprobe is optimized and the shadow stack crashes the app.
> +	 */
> +	if (shstk_is_enabled())
> +		return;

Not sure I fully understand the comment/problem, but what if
prctl(ARCH_SHSTK_ENABLE) is called after arch_uprobe_optimize() succeeds?

Oleg.


