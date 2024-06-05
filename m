Return-Path: <bpf+bounces-31458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DE58FD486
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 19:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D65C28AA03
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 17:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D321957E6;
	Wed,  5 Jun 2024 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PnMOpkGL"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A55194ACA
	for <bpf@vger.kernel.org>; Wed,  5 Jun 2024 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610280; cv=none; b=IptT+d8tPpi2As6F+470RTIfL14lYYULnhndX1LBTyvFfapXe4oqGTNZOB1l2MOxjkm8JSTwi1Hlo5Il4P64bOo04LC8V82FuXdMdNj0BqkiDkRf1NLYSE8uzpC01G6PRM0uGKGLqvmkIBQz2ibQ1rLn5dUFc0ND5MxdacuVnRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610280; c=relaxed/simple;
	bh=M+kTfQgopDw6pRHN5KgPqRjscFYLhvqP2Cm8FVR4IoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTBQBdyOrAjpu/D0m0m3CVcLuHCnq3nc13QtGnpJQBY/Fob+Gm98U040THgSSzFsmjz76pbIBwbT+8LOa8+YDlzS+r990rMlKmInNowBpMf6c3EFU89oG5fnKakRw7nqf8wKIXzAGRlhE8j6wowqsaCAqgqD43Bvlap0Y0v+jMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PnMOpkGL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717610277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VuJ4fNB8fhXRvR11VmS6YjcKZS/vPkYMz+xJwYDKrdE=;
	b=PnMOpkGL7uTbq05ljgYn+9PAR6iRYVBN3qoXpYP2SKY2xEnBgEjuZAkN4Wp7X7pkFqgKRM
	/eMbgdgnK4aKlqgdnFXPDqYc6m11bL2v964doScdEWSyiW8clPi0fP/mYznWhMpXUBFESa
	8BIKD2W/qwYQgCnrg/XVtzNMHKQpGgk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-IkNazG97MHS7anzZWG_1Mw-1; Wed, 05 Jun 2024 13:57:53 -0400
X-MC-Unique: IkNazG97MHS7anzZWG_1Mw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E2D0B85A588;
	Wed,  5 Jun 2024 17:57:52 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.62])
	by smtp.corp.redhat.com (Postfix) with SMTP id DE3E5408A433;
	Wed,  5 Jun 2024 17:57:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  5 Jun 2024 19:56:24 +0200 (CEST)
Date: Wed, 5 Jun 2024 19:56:19 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC bpf-next 01/10] uprobe: Add session callbacks to
 uprobe_consumer
Message-ID: <20240605175619.GH25006@redhat.com>
References: <20240604200221.377848-1-jolsa@kernel.org>
 <20240604200221.377848-2-jolsa@kernel.org>
 <CAEf4BzbzgTzvnPRJ24gdhuxN02_w8iNNFn4URh0vEp-t69oPnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbzgTzvnPRJ24gdhuxN02_w8iNNFn4URh0vEp-t69oPnA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 06/05, Andrii Nakryiko wrote:
>
> so any such
> limitations will cause problems, issue reports, investigation, etc.

Agreed...

> As one possible solution, what if we do
>
> struct return_instance {
>     ...
>     u64 session_cookies[];
> };
>
> and allocate sizeof(struct return_instance) + 8 *
> <num-of-session-consumers> and then at runtime pass
> &session_cookies[i] as data pointer to session-aware callbacks?

I too thought about this, but I guess it is not that simple.

Just for example. Suppose we have 2 session-consumers C1 and C2.
What if uprobe_unregister(C1) comes before the probed function
returns?

We need something like map_cookie_to_consumer().

> > +       /* The handler_session callback return value controls execution of
> > +        * the return uprobe and ret_handler_session callback.
> > +        *  0 on success
> > +        *  1 on failure, DO NOT install/execute the return uprobe
> > +        *    console warning for anything else
> > +        */
> > +       int (*handler_session)(struct uprobe_consumer *self, struct pt_regs *regs,
> > +                              unsigned long *data);
> > +       int (*ret_handler_session)(struct uprobe_consumer *self, unsigned long func,
> > +                                  struct pt_regs *regs, unsigned long *data);
> > +
>
> We should try to avoid an alternative set of callbacks, IMO. Let's
> extend existing ones with `unsigned long *data`,

Oh yes, agreed.

And the comment about the return value looks confusing too. I mean, the
logic doesn't differ from the ret-code from ->handler().

"DO NOT install/execute the return uprobe" is not true if another
non-session-consumer returns 0.

Oleg.


