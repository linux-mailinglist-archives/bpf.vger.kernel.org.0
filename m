Return-Path: <bpf+bounces-39751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AB7976E93
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 18:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 052511C23A6A
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 16:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03558149C50;
	Thu, 12 Sep 2024 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULRB1NGU"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1583A1DB
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726158056; cv=none; b=REvdEeJaZbTDEWmjyrs4Ifoav26uTHf0YuI7DiWr4ee4PPWjeXdplD2jqOCiKyn99GKqDV0eTza3O7hQZ+jr013VGuK3lcJlMyKOcsKQPQYtjtJdCUFQdFH76JlOh13rAMxrEAc4DO/WKwpBkApLVLEhpP6lYYWoUT6XSvsPGrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726158056; c=relaxed/simple;
	bh=61FjxYnFqoZjOQnqRNBNaBrHVxuHKhvfYWTDzANo+5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLkVZBxrGXLXUuEEEOii1bAHZ72eWFysXxDw97lTx9VMkdpb4ZGCjfcr4dQLZ1kc8eSuZLIEQte6LA/CABXzt9bvnVSPzNIn6HVpMYwEkf/1zbSIx0uLAtZgd93OqAH4Uar3rYn3ldo8YAbtJqH7IcmLeDHUzL8DrzsqtFyK3i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ULRB1NGU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726158053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ig6fjTDvlYtMVYhCJ7RrIH/6U1AxI1tHu5V3SG2FN9M=;
	b=ULRB1NGUQT2YU3QND+wDKfYxNT4lcJkb6t5PL9paMTaM8UpVNKADrmdxsHMFb2+eSWMCCe
	ra7sVYhrnly1CE9CJMxDNbF03wINVBrquSSAW+lNq9Eu4PzCtwn1BYvJW6GFflJRcngnuO
	mDhiikF+snzLoXJA2ji3hu6YqewOuOA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-V78Nc_s2NjqbgP2OY2heiA-1; Thu,
 12 Sep 2024 12:20:52 -0400
X-MC-Unique: V78Nc_s2NjqbgP2OY2heiA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 107A61955F3C;
	Thu, 12 Sep 2024 16:20:49 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.62])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 959B61956052;
	Thu, 12 Sep 2024 16:20:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 12 Sep 2024 18:20:37 +0200 (CEST)
Date: Thu, 12 Sep 2024 18:20:29 +0200
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
Subject: Re: [PATCHv3 1/7] uprobe: Add support for session consumer
Message-ID: <20240912162028.GD27648@redhat.com>
References: <20240909074554.2339984-1-jolsa@kernel.org>
 <20240909074554.2339984-2-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909074554.2339984-2-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 09/09, Jiri Olsa wrote:
>
>  static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
>  {
>  	struct uprobe_consumer *uc;
>  	int remove = UPROBE_HANDLER_REMOVE;
> -	bool need_prep = false; /* prepare return uprobe, when needed */
> +	struct return_consumer *ric = NULL;
> +	struct return_instance *ri = NULL;
>  	bool has_consumers = false;
>
>  	current->utask->auprobe = &uprobe->arch;
>
>  	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
>  				 srcu_read_lock_held(&uprobes_srcu)) {
> +		__u64 cookie = 0;
>  		int rc = 0;
>
>  		if (uc->handler) {
> -			rc = uc->handler(uc, regs);
> -			WARN(rc & ~UPROBE_HANDLER_MASK,
> +			rc = uc->handler(uc, regs, &cookie);
> +			WARN(rc < 0 || rc > 2,
>  				"bad rc=0x%x from %ps()\n", rc, uc->handler);
>  		}
>
> -		if (uc->ret_handler)
> -			need_prep = true;
> -
> +		/*
> +		 * The handler can return following values:
> +		 * 0 - execute ret_handler (if it's defined)
> +		 * 1 - remove uprobe
> +		 * 2 - do nothing (ignore ret_handler)
> +		 */
>  		remove &= rc;
>  		has_consumers = true;
> +
> +		if (rc == 0 && uc->ret_handler) {

should we enter this block if uc->handler == NULL?

> +			/*
> +			 * Preallocate return_instance object optimistically with
> +			 * all possible consumers, so we allocate just once.
> +			 */
> +			if (!ri) {
> +				ri = alloc_return_instance(uprobe->consumers_cnt);

This doesn't look right...

Suppose we have a single consumer C1, so uprobe->consumers_cnt == 1 and
alloc_return_instance() allocates return_instance with for a single consumer,
so that only ri->consumers[0] is valid.

Right after that uprobe_register()->consumer_add() adds another consumer
C2 with ->ret_handler != NULL.

On the next iteration return_consumer_next() will return the invalid addr
== &ri->consumers[1].

perhaps this needs krealloc() ?

> +				if (!ri)
> +					return;

Not sure we should simply return if kzalloc fails... at least it would be better
to clear current->utask->auprobe.

> +	if (ri && !remove)
> +		prepare_uretprobe(uprobe, regs, ri); /* put bp at return */
> +	else
> +		kfree(ri);

Well, if ri != NULL then remove is not possible, afaics... ri != NULL means
that at least one ->handler() returned rc = 0, thus "remove" must be zero.

So it seems you can just do

	if (ri)
		prepare_uretprobe(...);


Didn't read other parts of your patch yet ;)

Oleg.


