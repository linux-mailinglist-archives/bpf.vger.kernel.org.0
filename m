Return-Path: <bpf+bounces-31445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D291C8FD198
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 17:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314FB288CF0
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 15:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D7547F64;
	Wed,  5 Jun 2024 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6GHnbDM"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5527C1494BD
	for <bpf@vger.kernel.org>; Wed,  5 Jun 2024 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717601203; cv=none; b=T0Em4iOGpUPvsH4rf1fnWPBVgJdRe9QBUO174kTn4n55i3uOPU3B0NuIJL7MpOsdqNkJTjX0NCJGghfJVhE46XekvhepRqaFxEk245jHZv4zOgULM2A3gkV6wgdn/G6T8FXJxG232FFITm1XmM7bYSu4iprfFaJy2UuOxwheWRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717601203; c=relaxed/simple;
	bh=bNuWGrfh+H7Fav06wVfQOoCuk0r6nLVCkcxz3VrlPag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaVx2zf9Bbv9h2Cax7KfVWudYwoPxz3YzafXPfqjni6qTJzkZzbg4JtBNr5W6+6/pTo0kx93J4g/2ckVz58z1nx6E6TOFGuZB69pTVxQaBnBv0OGvY0GQKHQzoBuVRkPE0Dkg+iEzBQyYMwQ0gXC5UA9GdcwAhmbZXUtqXkjk8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y6GHnbDM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717601201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JBCoiHutLk0vWvVe2jPtxGY0YZJBt3gZWD7D6OcdQ4I=;
	b=Y6GHnbDMW/pcifhH9pwuCpUD52p/BLEQCvMu9Ho35lR9PrncezBaQlVWtTtE0HJxKrSO9m
	Zq4TiQFUF6IEeXC7LUHjeOdy7zBicsZ2XmatVI4WdrSzfBUK+EERNvaHObufCHtL/Sub3N
	1TdXFWlSn8xkBhtO1UXdhZyNM5WE/p4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-1Nq6HuAwPg6NLiDZHQWiFg-1; Wed, 05 Jun 2024 11:26:35 -0400
X-MC-Unique: 1Nq6HuAwPg6NLiDZHQWiFg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A5878032F8;
	Wed,  5 Jun 2024 15:26:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.50])
	by smtp.corp.redhat.com (Postfix) with SMTP id 32B02C15970;
	Wed,  5 Jun 2024 15:26:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  5 Jun 2024 17:25:01 +0200 (CEST)
Date: Wed, 5 Jun 2024 17:24:57 +0200
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
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC bpf-next 01/10] uprobe: Add session callbacks to
 uprobe_consumer
Message-ID: <20240605152457.GD25006@redhat.com>
References: <20240604200221.377848-1-jolsa@kernel.org>
 <20240604200221.377848-2-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604200221.377848-2-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

I'll try to read this code tomorrow, right now I don't really understand
what does it do and why.

However,

On 06/04, Jiri Olsa wrote:
>
>  struct uprobe_consumer {
> +	/*
> +	 * The handler callback return value controls removal of the uprobe.
> +	 *  0 on success, uprobe stays
> +	 *  1 on failure, remove the uprobe
> +	 *    console warning for anything else
> +	 */
>  	int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs);

This is misleading. It is not about success/failure, it is about filtering.

consumer->handler() returns UPROBE_HANDLER_REMOVE if this consumer is not
interested in this task, so this uprobe can be removed (unless another
consumer returns 0).

> +/*
> + * Make sure all the uprobe consumers have only one type of entry
> + * callback registered (either handler or handler_session) due to
> + * different return value actions.
> + */
> +static int consumer_check(struct uprobe_consumer *curr, struct uprobe_consumer *uc)
> +{
> +	if (!curr)
> +		return 0;
> +	if (curr->handler_session || uc->handler_session)
> +		return -EBUSY;
> +	return 0;
> +}

Hmm, I don't understand this code, it doesn't match the comment...

The comment says "all the uprobe consumers have only one type" but
consumer_check() will always fail if the the 1st or 2nd consumer has
->handler_session != NULL ?

Perhaps you meant

	if (!!curr->handler != !!uc->handler)
		return -EBUSY;

?

Oleg.


