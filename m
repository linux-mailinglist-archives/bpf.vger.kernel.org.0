Return-Path: <bpf+bounces-36459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E504948D0A
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 12:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D7ADB24835
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 10:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A500E1C0DE2;
	Tue,  6 Aug 2024 10:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dGgdjLZn"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952591C0DDE
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 10:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722941119; cv=none; b=Apk3VIvO/LNQP/KCR8DctkahNu/EUETLBssKPb+DF+Tl6EjM5mtCT5OUWKBfUecyPXL1wI3u8OMoD25IrK57tFWGCFbr5P4DnQhYOem+AOvCkpcQm7A+59A1terQO8BtcmUJ9Q+njRtCJliG+5Ob28EBBCbn/Pkb5YVVHIUbdGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722941119; c=relaxed/simple;
	bh=+vmp79Qb3Tls6NjnMxfgvb4gLjW13lPFJ1eRIACcW78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T443omfB1osGGRTpSgzZ7MQHzJi4NIG1kEHPVkKGe3dM9HSppYiAC/rUZGHWr7rA/pr5zpjIQAHa3BaQ93FrEm9lWenN/akTBcbeCLKiNJj1jkTq5jL6vQfUZSRPJ8m9P4ETLnyvMIbDC1O8BOslqCy8xSCwfJL1TEHkrESs1Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dGgdjLZn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722941116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gf7zpjnUN0wmUdYB8KWoxMfwdTSfpBnwuV6brudHc/Q=;
	b=dGgdjLZnjvwpMDtMHOZgEJVKVy9gNKaljt5BkLPlfSEI5fM/7LM1kkyJNr55bXF/1uKCrs
	qHDJCmklDQ4t4174BsPzpyFAhDyZ2Y7anTKgtty7zTt2/fJI4lC+I9nUCWgOY5MDf0NIoG
	5UGVbkYumKiVT5eL0E1bnu6SDhjcgl4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-NAKf1IueNUu23MhVLxz5bQ-1; Tue,
 06 Aug 2024 06:45:10 -0400
X-MC-Unique: NAKf1IueNUu23MhVLxz5bQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0170019560A2;
	Tue,  6 Aug 2024 10:45:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.155])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B3A1F1955D42;
	Tue,  6 Aug 2024 10:45:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  6 Aug 2024 12:45:05 +0200 (CEST)
Date: Tue, 6 Aug 2024 12:45:00 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
	paulmck@kernel.org
Subject: Re: [PATCH 2/8] uprobes: revamp uprobe refcounting and lifetime
 management
Message-ID: <20240806104500.GA20881@redhat.com>
References: <20240731214256.3588718-1-andrii@kernel.org>
 <20240731214256.3588718-3-andrii@kernel.org>
 <20240805134418.GA11049@redhat.com>
 <CAEf4BzYvkAYL4pPcA7ayiR_VT=g4Y1SMZy4MNX3QEV3H=PjYvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYvkAYL4pPcA7ayiR_VT=g4Y1SMZy4MNX3QEV3H=PjYvw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 08/05, Andrii Nakryiko wrote:
>
> On Mon, Aug 5, 2024 at 6:44 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 07/31, Andrii Nakryiko wrote:
> > >
> > > @@ -732,11 +776,13 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
> > >       uprobe->ref_ctr_offset = ref_ctr_offset;
> > >       init_rwsem(&uprobe->register_rwsem);
> > >       init_rwsem(&uprobe->consumer_rwsem);
> > > +     RB_CLEAR_NODE(&uprobe->rb_node);
> >
> > I guess RB_CLEAR_NODE() is not necessary?
>
> I definitely needed that with my batch API changes, but it might be
> that I don't need it anymore. But I'm a bit hesitant to remove it,

OK, lets keep it, it doesn't hurt. Just it wasn't clear to me why did
you add this initialization in this patch.

> > > @@ -1286,15 +1296,19 @@ static void build_probe_list(struct inode *inode,
> > >                       u = rb_entry(t, struct uprobe, rb_node);
> > >                       if (u->inode != inode || u->offset < min)
> > >                               break;
> > > +                     u = try_get_uprobe(u);
> > > +                     if (!u) /* uprobe already went away, safe to ignore */
> > > +                             continue;
> > >                       list_add(&u->pending_list, head);
> >
> > cosmetic nit, feel to ignore, but to me
> >
> >                         if (try_get_uprobe(u))
> >                                 list_add(&u->pending_list, head);
> >
> > looks more readable.
>
> It's not my code base to enforce my preferences, but I'll at least
> explain why I disagree. To me, something like `if (some condition)
> <break/continue>;` is a very clear indication that this item (or even
> the rest of items in case of break) won't be processed anymore.
>
> While
>
> if (some inverted condition)
>    <do some something useful>
> <might be some more code>

OK, I won't insist. To me the most confusing part is

	u = try_get_uprobe(u);
	if (!u)
	...

If you read this code for the 1st time (or you are trying to recall it
after 10 years ;) it looks as if try_get_uprobe() can return another uprobe.

> So I'll invert this just to not be PITA, but I disagree :)

If you disagree, then don't change it ;)

Oleg.


