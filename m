Return-Path: <bpf+bounces-34016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4B9929881
	for <lists+bpf@lfdr.de>; Sun,  7 Jul 2024 16:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ACD92851A4
	for <lists+bpf@lfdr.de>; Sun,  7 Jul 2024 14:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1FD2D05E;
	Sun,  7 Jul 2024 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dpk7iGVv"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB54A2E64B
	for <bpf@vger.kernel.org>; Sun,  7 Jul 2024 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720363724; cv=none; b=Mcg/jojwHI2LoXfCpkW6X383fnjjhGzm1MIzLKqUnKj0Oy6ebIyjvnec7E5icTcTvVsFISEr2Quyg2hrROZBhNQjwNpC0VK1SithynFpXL4ez+XEAIAIdWDXfQVDP5VZuHFW/ZtBrRiwAzmq9GMynnDZAvH+cv9FKJe0JBTYrSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720363724; c=relaxed/simple;
	bh=/l8NLaSri3IcJsgyhXFx4MKFlb+PT8ehYrJzUDUBWI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dxy0qYUHby7j4Kgn2a67opic+7ijEfrgiaehx1cuRMbTJdNHLNuFiz+cJkgiEVuFYZEBYaTDPyfS+58RtRQ59+ET+WsoFkrX6x6Acg8pmpv02gvpiSZ3QBiZ3dLDFDWZdUCtETyidx3QQj6GkzeL85Q8F1wu//RZhDapDzyaRhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dpk7iGVv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720363721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kPze5O53dVb0ihek2fyZH9t9ETrFiyFwh4FqEFeVXOc=;
	b=Dpk7iGVvSt2TPJVo+EBqJMYGsJs/E64fr8eZq1uIsI4IWohtFNXf+J3L6zk4kPYzYiE2aJ
	1fg4I4D0BQRdm/ETlpDXoBwB4BKRRqsiUeg45TRyNMzV9P66q7q8Neg4Xi2eXKi33Hm2e9
	Hr1w48IJDscL+x96Va2IJNG7glA0iOc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-X-5s_BthOpqSz0GMEoNEjg-1; Sun,
 07 Jul 2024 10:48:36 -0400
X-MC-Unique: X-5s_BthOpqSz0GMEoNEjg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD6C91955F0D;
	Sun,  7 Jul 2024 14:48:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.39])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id AB3CF1955F3B;
	Sun,  7 Jul 2024 14:48:30 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  7 Jul 2024 16:46:58 +0200 (CEST)
Date: Sun, 7 Jul 2024 16:46:53 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
	bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	clm@meta.com
Subject: Re: [PATCH v2 04/12] uprobes: revamp uprobe refcounting and lifetime
 management
Message-ID: <20240707144653.GB11914@redhat.com>
References: <20240701223935.3783951-1-andrii@kernel.org>
 <20240701223935.3783951-5-andrii@kernel.org>
 <20240705153705.GA18551@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705153705.GA18551@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

And I forgot to mention...

In any case __uprobe_unregister() can't ignore the error code from
register_for_each_vma(). If it fails to restore the original insn,
we should not remove this uprobe from uprobes_tree.

Otherwise the next handle_swbp() will send SIGTRAP to the (no longer)
probed application.

On 07/05, Oleg Nesterov wrote:
>
> Tried to read this patch, but I fail to understand it. It looks
> obvioulsy wrong to me, see below.
>
> I tend to agree with the comments from Peter, but lets ignore them
> for the moment.
>
> On 07/01, Andrii Nakryiko wrote:
> >
> >  static void put_uprobe(struct uprobe *uprobe)
> >  {
> > -	if (refcount_dec_and_test(&uprobe->ref)) {
> > +	s64 v;
> > +
> > +	/*
> > +	 * here uprobe instance is guaranteed to be alive, so we use Tasks
> > +	 * Trace RCU to guarantee that uprobe won't be freed from under us, if
> > +	 * we end up being a losing "destructor" inside uprobe_treelock'ed
> > +	 * section double-checking uprobe->ref value below.
> > +	 * Note call_rcu_tasks_trace() + uprobe_free_rcu below.
> > +	 */
> > +	rcu_read_lock_trace();
> > +
> > +	v = atomic64_add_return(UPROBE_REFCNT_PUT, &uprobe->ref);
> > +
> > +	if (unlikely((u32)v == 0)) {
>
> I must have missed something, but how can this ever happen?
>
> Suppose uprobe_register(inode) is called the 1st time. To simplify, suppose
> that this binary is not used, so _register() doesn't install breakpoints/etc.
>
> IIUC, with this change (u32)uprobe->ref == 1 when uprobe_register() succeeds.
>
> Now suppose that uprobe_unregister() is called right after that. It does
>
> 	uprobe = find_uprobe(inode, offset);
>
> this increments the counter, (u32)uprobe->ref == 2
>
> 	__uprobe_unregister(...);
>
> this wont't change the counter,
>
> 	put_uprobe(uprobe);
>
> this drops the reference added by find_uprobe(), (u32)uprobe->ref == 1.
>
> Where should the "final" put_uprobe() come from?
>
> IIUC, this patch lacks another put_uprobe() after consumer_del(), no?
>
> Oleg.


