Return-Path: <bpf+bounces-40040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D13097AFEC
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 14:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125971F24061
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 12:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AC016B75D;
	Tue, 17 Sep 2024 12:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y8oLruzz"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2D51487C8
	for <bpf@vger.kernel.org>; Tue, 17 Sep 2024 12:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726574626; cv=none; b=fQctEfyKJZhJyG0f8FwUGAOqu9yfeK5Zk/XmI5TLBzN93ndKligBbjPifCJoOT3PIDJSExGDjz+MyNTxG7lUk/xqJd4jVA1UgWxBR9usAXo5iBoUE2nTlwzWVidYXS2ZyEV0hEo5dwU15NBua+efCxFzaF0euRUjCZ9o3eybOFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726574626; c=relaxed/simple;
	bh=TWkXAPa5iC2qJ2M9E08ogHZNnPyf4KyyJGSgSeJjCwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5Cmay4TD/PwILVwJGwIPwX0qnmFORaErfYnaPRZsxKJqmceBycr8gMyxImswAQAFv4EJ9XCllvT0jDdTVmt2I9PtpGdKXInv+Jj7QIspOimgbudeEw0S0rjQE3MWNbJ81ZRlaRyMUvcXArtq+9axTBgfXET7Z4qsNPE7QhR20w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y8oLruzz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726574623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2sZwRPa3NRKFGRrkr6Lic6VO5s4JO/Gj+aPlE8EHXKA=;
	b=Y8oLruzzbf7PU2rZelPsHRcLWmbUAwo9gbbwLegzg8CBToOsnWv6E+vosfep4h4tcb0+ex
	5ZnF2ev0pbzz3J8EhNLNdsRi+fIPQoAElJsY0CsUl9ra1igHMG/qSqZSX5XHvFYdHZanWF
	Xowg4Ib0SlUEGNkVq8+/CTpNc7erMbs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-pp47hdYAPmGQhuySM0Mitg-1; Tue,
 17 Sep 2024 08:03:40 -0400
X-MC-Unique: pp47hdYAPmGQhuySM0Mitg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E3D51955F65;
	Tue, 17 Sep 2024 12:03:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.79])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id DE1A019560AF;
	Tue, 17 Sep 2024 12:03:30 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 17 Sep 2024 14:03:24 +0200 (CEST)
Date: Tue, 17 Sep 2024 14:03:17 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 02/14] uprobe: Add support for session consumer
Message-ID: <20240917120250.GA7752@redhat.com>
References: <20240917085024.765883-1-jolsa@kernel.org>
 <20240917085024.765883-3-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917085024.765883-3-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

I don't see anything wrong after a quick glance, but I don't
really understand the UPROBE_HANDLER_IGNORE logic, see below.

On 09/17, Jiri Olsa wrote:
>
> + * UPROBE_HANDLER_IWANTMYCOOKIE
> + * - Store cookie and pass it to ret_handler (if defined).

Cough ;) yes it was me who used this name in the previous discussion, but maybe

	UPROBE_HANDLER_COOKIE

will look a bit better? Feel free to ignore.

>  static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
...
> +		if (!uc->ret_handler || rc == UPROBE_HANDLER_REMOVE)
> +			continue;
> +
> +		/*
> +		 * If alloc_return_instance and push_consumer fail, the return probe
> +		 * won't be prepared, but we'll finish to execute all entry handlers.
> +		 *
> +		 * We need to store handler's return value in case the return uprobe
> +		 * gets installed and contains consumers that need to be ignored.
> +		 */
> +		if (!ri)
> +			ri = alloc_return_instance();
> +
> +		if (rc == UPROBE_HANDLER_IWANTMYCOOKIE || rc == UPROBE_HANDLER_IGNORE)
> +			ri = push_consumer(ri, push_idx++, uc->id, cookie, rc);

So this code allocates ri (which implies prepare_uretprobe!) and calls push_consumer()
even if rc == UPROBE_HANDLER_IGNORE.

Why? The comment in uprobes.h says:

	UPROBE_HANDLER_IGNORE
	- Ignore ret_handler callback for this consumer

but the ret_handler callback won't be ignored?

To me this code should do:

		if (!uc->ret_handler || UPROBE_HANDLER_REMOVE || UPROBE_HANDLER_IGNORE)
			continue;

		if (!ri)
			ri = alloc_return_instance();

		if (rc == UPROBE_HANDLER_IWANTMYCOOKIE)
			ri = push_consumer(...);

And,

>  handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
...
>  	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
>  				 srcu_read_lock_held(&uprobes_srcu)) {
> +		ric = return_consumer_find(ri, &ric_idx, uc->id);
> +		if (ric && ric->rc == UPROBE_HANDLER_IGNORE)
> +			continue;
>  		if (uc->ret_handler)
> -			uc->ret_handler(uc, ri->func, regs);
> +			uc->ret_handler(uc, ri->func, regs, ric ? &ric->cookie : NULL);
>  	}

the UPROBE_HANDLER_IGNORE check above and the new ric->rc member should die,

		if (!uc->ret_handler)
			continue;

		ric = return_consumer_find(...);
		uc->ret_handler(..., ric ? &ric->cookie : NULL);

as we have already discussed, the session ret_handler(data) can simply do

		// my ->handler() wasn't called or it didn't return
		// UPROBE_HANDLER_IWANTMYCOOKIE
		if (!data)
			return;

at the start.

Could you explain why this can't work?

Oleg.


