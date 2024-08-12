Return-Path: <bpf+bounces-36886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7274394EBCF
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 13:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5C991C20CAF
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 11:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB40175D2A;
	Mon, 12 Aug 2024 11:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Knf67Tqf"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF8E16FF5F
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723462195; cv=none; b=RXOy2G75M595uG9p9pDig07iqjw9Aj7M1iZYnVedQl483hmZL9p1w+BASl+7rAifAXGMcHnNIzReDN2p08oYAtr+jr+y3Ta9r91d38Gz2as0+oR/g1JRjS9B9z6sBVFcxT9R70N7o7/uSKnvVMSq4mccqIapd6PvL/IxtoVy2wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723462195; c=relaxed/simple;
	bh=BcS7e5OSUdegHmPBjuOnztz2GWyLnhPJwGxbx8iNC9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umrSsNdPYsqYOMYw7dIIMLB+zXoBt6udm69ZrpIpaIWwAE5cAkuplVx1OP5qh+Aa9b7xseoKz8NB0NH+PA8TIXvFWZ6ujtFcQ5voj0G9fz7wPcwAyxDczj2QOiX3rNaBSNFl6WjavA9db6wx00hKDfk1eOSbx/IpFugzEKpAgZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Knf67Tqf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723462192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dOjdqADSWC8inLVd6ovXTdUwFoHmzNkQ2gTz2o2Yt4Y=;
	b=Knf67TqfzrL91eO2w8f2rt5Nt264oWYmD5ei7XA2x112igUaIGlYBIxd0cL94126YfL355
	HxndFEqCsiKEJQgFADKhHdPtd7McjQqDEEFYkZQgPQ4JTNr4PjBu50t3G7tpl77jBWuAtU
	NojutjLm0RCqPkRSJEzsrNw1RjXk6kc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-m5cnWKV1PdS9PLq1WPeyZg-1; Mon,
 12 Aug 2024 07:29:49 -0400
X-MC-Unique: m5cnWKV1PdS9PLq1WPeyZg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9924A1953961;
	Mon, 12 Aug 2024 11:29:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.102])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 86E9C19560A3;
	Mon, 12 Aug 2024 11:29:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 12 Aug 2024 13:29:43 +0200 (CEST)
Date: Mon, 12 Aug 2024 13:29:29 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Liao Chang <liaochang1@huawei.com>
Cc: mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, andrii@kernel.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 2/2] uprobes: Remove the spinlock within
 handle_singlestep()
Message-ID: <20240812112929.GB11656@redhat.com>
References: <20240809061004.2112369-1-liaochang1@huawei.com>
 <20240809061004.2112369-3-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809061004.2112369-3-liaochang1@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 08/09, Liao Chang wrote:
>
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -75,6 +75,7 @@ struct uprobe_task {
>  
>  	struct uprobe			*active_uprobe;
>  	unsigned long			xol_vaddr;
> +	bool				deny_signal;

Ack, but... I can't believe I am arguing with the naming ;)
Can we have a better name for this flag?

	utask->signal_denied ?
	utask->restore_sigpending ?

or just

	utask->sigpending ?

utask->deny_signal looks as if handle_singlestep/whatever should
"deny" the pending signal cleared by uprobe_deny_signal(), while
it fact it should restore TIF_SIGPENDING.

Oleg.

>  
>  	struct return_instance		*return_instances;
>  	unsigned int			depth;
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 76a51a1f51e2..77934fbd1370 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1979,6 +1979,7 @@ bool uprobe_deny_signal(void)
>  	WARN_ON_ONCE(utask->state != UTASK_SSTEP);
>  
>  	if (task_sigpending(t)) {
> +		utask->deny_signal = true;
>  		clear_tsk_thread_flag(t, TIF_SIGPENDING);
>  
>  		if (__fatal_signal_pending(t) || arch_uprobe_xol_was_trapped(t)) {
> @@ -2288,9 +2289,10 @@ static void handle_singlestep(struct uprobe_task *utask, struct pt_regs *regs)
>  	utask->state = UTASK_RUNNING;
>  	xol_free_insn_slot(current);
>  
> -	spin_lock_irq(&current->sighand->siglock);
> -	recalc_sigpending(); /* see uprobe_deny_signal() */
> -	spin_unlock_irq(&current->sighand->siglock);
> +	if (utask->deny_signal) {
> +		set_thread_flag(TIF_SIGPENDING);
> +		utask->deny_signal = false;
> +	}
>  
>  	if (unlikely(err)) {
>  		uprobe_warn(current, "execute the probed insn, sending SIGILL.");
> -- 
> 2.34.1
> 


