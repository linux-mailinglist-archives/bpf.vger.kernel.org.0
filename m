Return-Path: <bpf+bounces-67275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E43B41D0E
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 13:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A66A27B045C
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 11:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B79D2FABE2;
	Wed,  3 Sep 2025 11:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPBFXAQs"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFD22FA0DE
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756898908; cv=none; b=FT/95qmOH2VEr84ytxVwrarK9YHLGVXX90r03s2zG6UP8igPY912akLPiI2bjxqoLA7cw1HJGdFXAUlc3cl7uu1i0A/sAHo1LrJok0EwczaEg8J+UB5JWKsJ6SBSNNtJMwsqGOz5rak5NFFLghvTDSL6atorJVcflv2C7hMqcwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756898908; c=relaxed/simple;
	bh=8lmqRW0qjHFgJQeSbGOnenRyU84mWIk+9ffN3E+163M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHq00VM60qPecFEiFKbOcPcP7pI4/mMA3ZSpAfIeFj+WeuPebDJJNbi8Pbm7qBMMlrWGwuVexF1pPON+VPHA1JZ/Nvvnox9ovD5jxuv/MA5xy6ru11UYEybZ6k5xIllis48sqzg0/550ypTn/LEIXnUsnbuO94E1iD0fUL5Fw0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LPBFXAQs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756898906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tq5WhLnX1Puw0S1k2rypxZ8J38JL9t/8Hx2idU5bpiw=;
	b=LPBFXAQsyxpw5DsYkZUkAeX8yYxZxb/mhqOlJLrULSTNf1bZDa9VnptpO6EozHxqH/l/ye
	/qKSRA65ASB8CotE6H89XeO5qnQ/NMfpONLa2u6lDggkOcvX5TgogdlOTWKawUNOyzgbMO
	1Ut4lq9QQ41Fq1bws3D0dthete1f7Qk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-FD4yDbuaNWeSqlZxBuU7Wg-1; Wed,
 03 Sep 2025 07:28:20 -0400
X-MC-Unique: FD4yDbuaNWeSqlZxBuU7Wg-1
X-Mimecast-MFC-AGG-ID: FD4yDbuaNWeSqlZxBuU7Wg_1756898898
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99C57180058D;
	Wed,  3 Sep 2025 11:28:17 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.52])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 209A3195608E;
	Wed,  3 Sep 2025 11:28:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  3 Sep 2025 13:26:55 +0200 (CEST)
Date: Wed, 3 Sep 2025 13:26:48 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 02/11] uprobes: Skip emulate/sstep on unique
 uprobe when ip is changed
Message-ID: <20250903112648.GC18799@redhat.com>
References: <20250902143504.1224726-1-jolsa@kernel.org>
 <20250902143504.1224726-3-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902143504.1224726-3-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 09/02, Jiri Olsa wrote:
>
> If user decided to take execution elsewhere, it makes little sense
> to execute the original instruction, so let's skip it.

Exactly.

So why do we need all these "is_unique" complications? Only a single
is_unique/exclusive consumer can change regs->ip, so I guess handle_swbp()
can just do

	handler_chain(uprobe, regs);
	if (instruction_pointer(regs) != bp_vaddr)
		goto out;


> Allowing this
> behaviour only for uprobe with unique consumer attached.

But if a non-exclusive consumer changes regs->ip, we have a problem
anyway, right?

We can probably add something like

		rc = uc->handler(uc, regs, &cookie);
	+	WARN_ON(!uc->is_unique && instruction_pointer(regs) != bp_vaddr);

into handler_chain(), although I don't think this is needed.

Oleg.

> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/events/uprobes.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index b9b088f7333a..da8291941c6b 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2568,7 +2568,7 @@ static bool ignore_ret_handler(int rc)
>  	return rc == UPROBE_HANDLER_REMOVE || rc == UPROBE_HANDLER_IGNORE;
>  }
>  
> -static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
> +static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs, bool *is_unique)
>  {
>  	struct uprobe_consumer *uc;
>  	bool has_consumers = false, remove = true;
> @@ -2582,6 +2582,9 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
>  		__u64 cookie = 0;
>  		int rc = 0;
>  
> +		if (is_unique)
> +			*is_unique |= uc->is_unique;
> +
>  		if (uc->handler) {
>  			rc = uc->handler(uc, regs, &cookie);
>  			WARN(rc < 0 || rc > 2,
> @@ -2735,6 +2738,7 @@ static void handle_swbp(struct pt_regs *regs)
>  {
>  	struct uprobe *uprobe;
>  	unsigned long bp_vaddr;
> +	bool is_unique = false;
>  	int is_swbp;
>  
>  	bp_vaddr = uprobe_get_swbp_addr(regs);
> @@ -2789,7 +2793,10 @@ static void handle_swbp(struct pt_regs *regs)
>  	if (arch_uprobe_ignore(&uprobe->arch, regs))
>  		goto out;
>  
> -	handler_chain(uprobe, regs);
> +	handler_chain(uprobe, regs, &is_unique);
> +
> +	if (is_unique && instruction_pointer(regs) != bp_vaddr)
> +		goto out;
>  
>  	/* Try to optimize after first hit. */
>  	arch_uprobe_optimize(&uprobe->arch, bp_vaddr);
> @@ -2819,7 +2826,7 @@ void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vaddr)
>  		return;
>  	if (arch_uprobe_ignore(&uprobe->arch, regs))
>  		return;
> -	handler_chain(uprobe, regs);
> +	handler_chain(uprobe, regs, NULL);
>  }
>  
>  /*
> -- 
> 2.51.0
> 


