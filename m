Return-Path: <bpf+bounces-32758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB4F912DDC
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 21:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815C61F24401
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 19:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63E717B4F5;
	Fri, 21 Jun 2024 19:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fTMnABQu"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047BF15FCF6
	for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 19:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718998366; cv=none; b=r2EFnh/yC3Yb3aCjq4plj7eozUfPhYL/Ty3kJmKLZf6NsjrRcVp3siOqqN9lGw8WiZCu1o6Zi6pVWOuEyA9klc8WUlMJb4mYZaJtLbLwokjRUOZrARjZnIelCdakF+AKqndjHRo+OV3z2PA8C+kLexbUb1XH0Ynal+PK4k78ggM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718998366; c=relaxed/simple;
	bh=z78AqR6z7mIfpnhE4/lGwoqgAT6n8pYryOkKdmY91ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFnnqK78nooyLp8LKJ+50KcJ77b986Y7BhmyWx/Y6ekTUvNLnHdGci4oSZvdEJeVABjgz3lBn/RbSdGRnqyW+olbv1LrqwYPD9PNLrK4Kd/iG8jWtHo+vhuFCm44sFW6uXCsyubHTgq5CJXb/9FZddAQbdLiiCxNnPbUgjL4cfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fTMnABQu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718998363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6EhGfcYIBQtq+J45Jgju4cRB0R3NaQDqFXGN3qp7tW4=;
	b=fTMnABQuJAejx12tbJ36bp4W4ThQVXJqO7yDVynVT2qBK1sGrXbUKqbmfPPIRIOI4a/Cqp
	mYq8xf+O6fntey4jxH3chVY5QglJZrSxqlZsw0w8OxJBgRviQxyiqu7nH2bnXPTezkR3Ee
	/gE02DDkjpIg1Io5wW0D0wTuK3jpdZg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532-n_NVXbiIMESewHMpXoYfnw-1; Fri,
 21 Jun 2024 15:32:41 -0400
X-MC-Unique: n_NVXbiIMESewHMpXoYfnw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39AEE195604F;
	Fri, 21 Jun 2024 19:32:36 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.9.79])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09A131955E80;
	Fri, 21 Jun 2024 19:32:27 +0000 (UTC)
Date: Fri, 21 Jun 2024 15:32:23 -0400
From: Phil Auld <pauld@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, joshdon@google.com, brho@google.com,
	pjt@google.com, derkling@google.com, haoluo@google.com,
	dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
	riel@surriel.com, changwoo@igalia.com, himadrics@inria.fr,
	memxor@gmail.com, andrea.righi@canonical.com,
	joel@joelfernandes.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 04/30] sched: Add sched_class->switching_to() and expose
 check_class_changing/changed()
Message-ID: <20240621193223.GB51310@lorien.usersys.redhat.com>
References: <20240618212056.2833381-1-tj@kernel.org>
 <20240618212056.2833381-5-tj@kernel.org>
 <20240621165327.GA51310@lorien.usersys.redhat.com>
 <ZnXSFrn6wNqk21GS@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnXSFrn6wNqk21GS@slm.duckdns.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Fri, Jun 21, 2024 at 09:18:46AM -1000 Tejun Heo wrote:
> Hello, Phil.
> 
> On Fri, Jun 21, 2024 at 12:53:27PM -0400, Phil Auld wrote:
> > > A new BPF extensible sched_class will have callbacks that allow the BPF
> > > scheduler to keep track of relevant task states (like priority and cpumask).
> > > Those callbacks aren't called while a task is on a different sched_class.
> > > When a task comes back, we wanna tell the BPF progs the up-to-date state
> > 
> > "wanna" ?   How about "want to"?
> > 
> > That makes me wanna stop reading right there... :)
> 
> Sorry about that. Have been watching for it recently but this log was
> written a while ago, so...
>
> > > +/*
> > > + * ->switching_to() is called with the pi_lock and rq_lock held and must not
> > > + * mess with locking.
> > > + */
> > > +void check_class_changing(struct rq *rq, struct task_struct *p,
> > > +			  const struct sched_class *prev_class)
> > > +{
> > > +	if (prev_class != p->sched_class && p->sched_class->switching_to)
> > > +		p->sched_class->switching_to(rq, p);
> > > +}
> > 
> > Does this really need wrapper? The compiler may help but it doesn't seem to
> > but you're doing a function call and passing in prev_class just to do a
> > simple check.  I guess it's not really a fast path. Just seemed like overkill.
> 
> This doesn't really matter either way but wouldn't it look weird if it's not
> symmetric with check_class_changed()?

Fair enough.  It was just a thought.


Cheers,
Phil


> 
> Thanks.
> 
> -- 
> tejun
> 

-- 


