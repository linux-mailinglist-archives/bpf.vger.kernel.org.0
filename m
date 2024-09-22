Return-Path: <bpf+bounces-40175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C91CB97E24A
	for <lists+bpf@lfdr.de>; Sun, 22 Sep 2024 17:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50866B20B08
	for <lists+bpf@lfdr.de>; Sun, 22 Sep 2024 15:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FE81BDDF;
	Sun, 22 Sep 2024 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WK4o85T6"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662F8EEDB
	for <bpf@vger.kernel.org>; Sun, 22 Sep 2024 15:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727018873; cv=none; b=NF/xmYaDrB7b9TxhkuSzm6MKPq0bFVaUiPnlIM45K33tFFFcelRUiddnDArG6iLPlInPZRtgxfr6eXmaKmIeltyz4mF984XzjoFvmMt2IF2UqS3Z69I4hkHA9qV8YcVwtduogN5fVS0jfuFeHb2F5xH63ktr40RIMSkbQh+yJlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727018873; c=relaxed/simple;
	bh=5KxbnNxFTyBpHlxGL2EYcm6h4Y1pBVBEDHpol40RRP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OabJuXeZFhLJkw2VSfqefteaS+CW62UxdLAKvwtOLlN4+3nqAWp8mc1eHUetkBCAwdrH0LOnWVeNo3QbcPIZ9zhLMRPEbDOFJKE9UMMy1ypiZz69InT20sm1TlqE9I+45hAHi4PgqWMzrzXjZSLJl2FXb2sii/5o+VUeQa08XJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WK4o85T6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727018871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WmAfg/OBadr+At/TXJr37YT1rjHHfOwPshCtnw9S2o0=;
	b=WK4o85T6YCdQs2EeGhpRvOM6A7+BFbRr4aR0SPbzrjUUgYkeekZ+4/zwL0x1tMOGgb8Jpp
	b+mqi375WD/hfHmHpqeXcZDVJEcSeECV3lTUHUnEWtpNOAUOycbX2ZBPjZUqtgwmL18YH/
	n9CgLmTXKkGh7FhzInR8tyN4zJvDMbM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-y9Mf_d30PSGznNZhHB5JkA-1; Sun,
 22 Sep 2024 11:27:45 -0400
X-MC-Unique: y9Mf_d30PSGznNZhHB5JkA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5089E190ECE8;
	Sun, 22 Sep 2024 15:27:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.14])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0FCFA19560AB;
	Sun, 22 Sep 2024 15:27:36 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 22 Sep 2024 17:27:30 +0200 (CEST)
Date: Sun, 22 Sep 2024 17:27:23 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
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
Message-ID: <20240922152722.GA12833@redhat.com>
References: <20240917085024.765883-1-jolsa@kernel.org>
 <20240917085024.765883-3-jolsa@kernel.org>
 <20240917120250.GA7752@redhat.com>
 <Zul7UCsftY_ZX6wT@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zul7UCsftY_ZX6wT@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Damn, sorry for delay :/

And sorry, still can't understand, see below...

On 09/17, Jiri Olsa wrote:
>
> On Tue, Sep 17, 2024 at 02:03:17PM +0200, Oleg Nesterov wrote:
> >
> > To me this code should do:
> >
> > 		if (!uc->ret_handler || UPROBE_HANDLER_REMOVE || UPROBE_HANDLER_IGNORE)
> > 			continue;
> >
> > 		if (!ri)
> > 			ri = alloc_return_instance();
> >
> > 		if (rc == UPROBE_HANDLER_IWANTMYCOOKIE)
> > 			ri = push_consumer(...);
> >
> > And,
> >
> > >  handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
> > ...
> > >  	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
> > >  				 srcu_read_lock_held(&uprobes_srcu)) {
> > > +		ric = return_consumer_find(ri, &ric_idx, uc->id);
> > > +		if (ric && ric->rc == UPROBE_HANDLER_IGNORE)
> > > +			continue;
> > >  		if (uc->ret_handler)
> > > -			uc->ret_handler(uc, ri->func, regs);
> > > +			uc->ret_handler(uc, ri->func, regs, ric ? &ric->cookie : NULL);
> > >  	}
> >
> > the UPROBE_HANDLER_IGNORE check above and the new ric->rc member should die,
> >
> > 		if (!uc->ret_handler)
> > 			continue;
> >
> > 		ric = return_consumer_find(...);
> > 		uc->ret_handler(..., ric ? &ric->cookie : NULL);
> >
> > as we have already discussed, the session ret_handler(data) can simply do
> >
> > 		// my ->handler() wasn't called or it didn't return
> > 		// UPROBE_HANDLER_IWANTMYCOOKIE
> > 		if (!data)
> > 			return;
> >
> > at the start.
> >
> > Could you explain why this can't work?
>
> I'll try ;-) it's for the case when consumer does not use UPROBE_HANDLER_IWANTMYCOOKIE
>
> let's have 2 consumers on single uprobe, consumer-A returning UPROBE_HANDLER_IGNORE
> and the consumer-B returning zero, so we want the return uprobe installed, but we
> want just consumer-B to be executed
>
>   - so uprobe gets installed and handle_uretprobe_chain goes over all consumers
>     calling ret_handler callback
>
>   - but we don't know consumer-A needs to be ignored, and it does not
>     expect cookie so we have no way to find out it needs to be ignored

How does this differ from the case when consumer-A returns _REMOVE but another
consumer returns 0?

But what I really can't understand is

	and it does not
	expect cookie so we have no way to find out it needs to be ignored

If we change the code as I suggested above, push_consumer() won't be called
if consumer-A returns UPROBE_HANDLER_IGNORE.

This means that handle_uretprobe_chain() -> return_consumer_find() will
return NULL, so handle_uretprobe_chain() won't pass the valid cookie to
consumer-A's ret_handler callback, it will pass data => NULL.

So, again, why can't consumer-A's ret_handler callback do

	// my ->handler() wasn't called or it didn't return
	// UPROBE_HANDLER_IWANTMYCOOKIE
	if (!data)
		return;

at the start?

Why the UPROBE_HANDLER_IGNORE case is more problematic than the
UPROBE_HANDLER_REMOVE case?

Oleg.


