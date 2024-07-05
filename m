Return-Path: <bpf+bounces-33962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F517928BE1
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 17:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B34A81F23E74
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 15:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B014C16C85F;
	Fri,  5 Jul 2024 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMKC6/rC"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BCE18AF4
	for <bpf@vger.kernel.org>; Fri,  5 Jul 2024 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720193933; cv=none; b=gfIaazTpBgF4kpH/kgp61ZH6vIzOdjAPYclMUWZiX5la/21p/r0i++wsqnqfIOwIeZB8CAx33AN23ZTxdFUj+vSVyz6zmh2bsqtXG9QGaq0QFzsOUizZ4RgL7KxVcA7FqWZKMaawzrtWdtg0LOzm7CQQlWmlttTHLcuGrrMmigI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720193933; c=relaxed/simple;
	bh=41FDXoLRQbEfjnnHaMUInmuBQSDKm2cwwwRa5tJ+QTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tp5eQ8Zl5hmbpAUtcYChlVyvtjlLGfWqOJndNF61HtJMh4O7LIGoIMB/v58VZwrBO1gzGPxh2CWZ2IRofSI0oTgLrpN7CIHSVzjpIgcjmvQ7rg1VHPZlMAdb1yqpc1N90bPp3ryYYyzLecx9MeL/Yn3aHiqjKjRfxF8rwk/0MB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EMKC6/rC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720193930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=68WZ7TzyfoBWuOyYKBhJ9+r1SmixyKt9M1fmEXrjdZg=;
	b=EMKC6/rCuCb3pPdOcjaX/VlYMrQsRXCy9a5st4tMK7L2WOygmtYAS7SK+r0Z0PXmYqy2A0
	oGQw5XWyd2Th7NfzVPYWFw2gsNtODNAr6bo6Nm1DywT+JotRTvgXYBNt6hiyPhM0vbJ9w0
	Eg8X1VZfjvStvrF5rpgSwcWeZWn2jTc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-gS6LY6k0NeyU_VwnY5SFrQ-1; Fri,
 05 Jul 2024 11:38:47 -0400
X-MC-Unique: gS6LY6k0NeyU_VwnY5SFrQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EAD321955F44;
	Fri,  5 Jul 2024 15:38:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.9])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 332B1195605F;
	Fri,  5 Jul 2024 15:38:41 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  5 Jul 2024 17:37:10 +0200 (CEST)
Date: Fri, 5 Jul 2024 17:37:05 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
	bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	clm@meta.com
Subject: Re: [PATCH v2 04/12] uprobes: revamp uprobe refcounting and lifetime
 management
Message-ID: <20240705153705.GA18551@redhat.com>
References: <20240701223935.3783951-1-andrii@kernel.org>
 <20240701223935.3783951-5-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701223935.3783951-5-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Tried to read this patch, but I fail to understand it. It looks
obvioulsy wrong to me, see below.

I tend to agree with the comments from Peter, but lets ignore them
for the moment.

On 07/01, Andrii Nakryiko wrote:
>
>  static void put_uprobe(struct uprobe *uprobe)
>  {
> -	if (refcount_dec_and_test(&uprobe->ref)) {
> +	s64 v;
> +
> +	/*
> +	 * here uprobe instance is guaranteed to be alive, so we use Tasks
> +	 * Trace RCU to guarantee that uprobe won't be freed from under us, if
> +	 * we end up being a losing "destructor" inside uprobe_treelock'ed
> +	 * section double-checking uprobe->ref value below.
> +	 * Note call_rcu_tasks_trace() + uprobe_free_rcu below.
> +	 */
> +	rcu_read_lock_trace();
> +
> +	v = atomic64_add_return(UPROBE_REFCNT_PUT, &uprobe->ref);
> +
> +	if (unlikely((u32)v == 0)) {

I must have missed something, but how can this ever happen?

Suppose uprobe_register(inode) is called the 1st time. To simplify, suppose
that this binary is not used, so _register() doesn't install breakpoints/etc.

IIUC, with this change (u32)uprobe->ref == 1 when uprobe_register() succeeds.

Now suppose that uprobe_unregister() is called right after that. It does

	uprobe = find_uprobe(inode, offset);

this increments the counter, (u32)uprobe->ref == 2

	__uprobe_unregister(...);

this wont't change the counter,

	put_uprobe(uprobe);

this drops the reference added by find_uprobe(), (u32)uprobe->ref == 1.

Where should the "final" put_uprobe() come from?

IIUC, this patch lacks another put_uprobe() after consumer_del(), no?

Oleg.


