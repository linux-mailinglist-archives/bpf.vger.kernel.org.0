Return-Path: <bpf+bounces-39821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F7D977EA9
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 13:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82EB81F22A04
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 11:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2B61D88A4;
	Fri, 13 Sep 2024 11:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6sVW5oh"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AB01D86D8
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726227702; cv=none; b=mSRq3aEeCqRHV2ArYdjlln7c8nvGTuWTPpkXU5KjvuOpj0hnU65sEyo5EY6LBbpfutCSPkdc2Xiaf+V1gT43QITAp3TZ4QaYq8/B34aYlZSPB/zUzaQ0KffyboS1uah1SE553evgbK5Q+X5gqNU64mpR+HvAosKBFnRHJDn74xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726227702; c=relaxed/simple;
	bh=JvvwYvhyetmEaxa4Ok6f8I1hR579EyKZ0zQapZDJJjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgw6ekhxEya6G2NWr9b0k3XXv3Hk0km6ssp2waIkaBdqHvj62SnXPU4wy6YEk2rPwR1wnCeVcmN+kLk/XyuKuKn/TWSAN7m8QjIdXdXSWu8yk1lR/O6kf20X5IZ18a6rLtEekD23tCw0caFC4vdvAEb9t+CKLCFFFY5r1k1Eucs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h6sVW5oh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726227699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bFl8pMgMCraS/0h8k8X7XF/1tEc21OrF7vh7Xgi/UvQ=;
	b=h6sVW5ohnokCqmyABnJnyLwZg5WfITR0fqru+u+JOtpkFMsxMC6NJU/eNBMEFDBqCfgcuG
	WZ/WwvOk0YhAoNWI14xt2fpUDCR7cxQZRtyBYE62wydxYLh41iVaQ9xVZORER1Dgfkt02Y
	SZS91u/Yzu4v/2TayWqUvfsy45rNwGs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-2lvjgl2yMiStlNola52Dyw-1; Fri,
 13 Sep 2024 07:41:36 -0400
X-MC-Unique: 2lvjgl2yMiStlNola52Dyw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB9AF196CDF5;
	Fri, 13 Sep 2024 11:41:33 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.25])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0DBA21956086;
	Fri, 13 Sep 2024 11:41:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 13 Sep 2024 13:41:22 +0200 (CEST)
Date: Fri, 13 Sep 2024 13:41:15 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/7] uprobe: Add support for session consumer
Message-ID: <20240913114114.GD19305@redhat.com>
References: <20240909074554.2339984-1-jolsa@kernel.org>
 <20240909074554.2339984-2-jolsa@kernel.org>
 <20240912162028.GD27648@redhat.com>
 <ZuP2YFruQDXTRi25@krava>
 <20240913105750.GC19305@redhat.com>
 <ZuQjPCdLkKnPQsu0@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuQjPCdLkKnPQsu0@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 09/13, Jiri Olsa wrote:
>
> On Fri, Sep 13, 2024 at 12:57:51PM +0200, Oleg Nesterov wrote:
>
> > static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
> > {
> > 	...
> > 	struct return_instance *ri = NULL;
> > 	int push_idx = 0;
> >
> > 	list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_read_lock_trace_held()) {
> > 		__u64 cookie = 0;
> > 		int rc = 0;
> >
> > 		if (uc->handler)
> > 			rc = uc->handler(uc, regs, &cookie);
> >
> > 		remove &= rc;
> > 		has_consumers = true;
> >
> > 		if (!uc->ret_handler || rc == UPROBE_HANDLER_REMOVE || rc == 2)
> > 			continue;
> >
> > 		if (!ri)
> > 			ri = alloc_return_instance();
> >
> > 		// or, better if (rc = UPROBE_HANDLER_I_WANT_MY_COOKIE)
> > 		if (uc->handler))
> > 			ri = push_id_cookie(ri, push_idx++, uc->id, cookie);
> > 	}
> >
> > 	if (!ZERO_OR_NULL_PTR(ri)) {
>
> should we rather bail out right after we fail to allocate ri above?

I think handler_chain() should call all the ->handler's even if
kzalloc/krealloc fails.

This is close to what the current code does, all the ->handler's are
called even if then later prepare_uretprobe()->kmalloc() fails.

Oleg.


