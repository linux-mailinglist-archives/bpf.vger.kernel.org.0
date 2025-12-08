Return-Path: <bpf+bounces-76278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B55CACDF7
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 11:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 475B1300B8CC
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 10:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426552FFF94;
	Mon,  8 Dec 2025 10:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwiU1Q/l"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E0621257F
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 10:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765189768; cv=none; b=j4wWbBJjj9tXlHUsRIm3jN9bxmiWi8SyZDeZAF1c5R0bEIeHZEEEKr2UAMi9sHmbB/WCcU+sWt1lxBZ6iLrcsbNkaoafy7zGyQlEArImO8rJ8Qj6CQYL6jQwM8LLG6dpZJKA0865wt8ny+7q8BMS5pI9gT5RMbZq1O7YEsM3740=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765189768; c=relaxed/simple;
	bh=Lai2720BhSwYhpwgkcvbksu2hyCojtOkg28bQeIJf4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxjb14/8nLI+vcLkwnvklKnxUL2eAP8EQL/3eZEP6YBIyWhHBgvu9T46fAj0DjnPJyGx927i5jdan3DuByCwug35vcSsbo//9o/eiCLpsdirKH2ECgskfWCDoaDTp8nioa7LI18tIEu/KjWm7pr+0Nlgn8nEizFfiwVWJ1BLaX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RwiU1Q/l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765189765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lai2720BhSwYhpwgkcvbksu2hyCojtOkg28bQeIJf4Q=;
	b=RwiU1Q/lE3KV/kxCfY6xZXzGb7Ffb4SGLpDnvLPxuXm6R0lCvSowxzeGpzN3n1C+OhyOHr
	4TSQqMx38saP5YNUA6odWlwkvPEFEBFUx9ib8idwRmgQlTDyZ2o/KzI22f1yEud0I1RR4N
	GqtBU0za0c2MSKdAahOuPT3D4PL2XOs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-Puq_hxsiMPi3trjBsX9Jew-1; Mon,
 08 Dec 2025 05:29:19 -0500
X-MC-Unique: Puq_hxsiMPi3trjBsX9Jew-1
X-Mimecast-MFC-AGG-ID: Puq_hxsiMPi3trjBsX9Jew_1765189757
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 049101956054;
	Mon,  8 Dec 2025 10:29:17 +0000 (UTC)
Received: from fedora (unknown [10.45.224.91])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E6D9F19560B0;
	Mon,  8 Dec 2025 10:29:10 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  8 Dec 2025 11:29:16 +0100 (CET)
Date: Mon, 8 Dec 2025 11:29:09 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@aculab.com>
Subject: Re: [RFC PATCH 0/8] uprobe/x86: Add support to optimize prologue
Message-ID: <aTaodcF1ACgQneRT@redhat.com>
References: <20251117124057.687384-1-jolsa@kernel.org>
 <aSSgGu8X04XoYN8D@redhat.com>
 <20251208153056.3a4e9cd3511ccf00dc12e265@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208153056.3a4e9cd3511ccf00dc12e265@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 12/08, Masami Hiramatsu wrote:
>
> On Mon, 24 Nov 2025 19:12:42 +0100
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > On 11/17, Jiri Olsa wrote:
> > >
> > > There's an additional issue that single instruction replacement does
> > > not have and it's the possibility of the user space code to jump in the
> > > middle of those 5 bytes. I think it's unlikely to happen at the function
> > > prologue, but uprobe could be placed anywhere. I'm not sure how to
> > > mitigate this other than having some enable/disable switch or config
> > > option, which is unfortunate.
> >
> > plus this breaks single-stepping... Although perhaps we don't really care.
>
> Yeah, and I think we can stop optimization if post_handler is set.

Hmm, why? This doesn't depend on whether ->ret_handler is set or not...

Oleg.


