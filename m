Return-Path: <bpf+bounces-38558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1929663FA
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 16:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD708B23309
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 14:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6846A1B250A;
	Fri, 30 Aug 2024 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMDVdZRC"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C891B1D5A
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725027509; cv=none; b=eJAjMTQhv4RY+jF/g9cz3bPy9MZcrMgEhtsHfKV/TWdgY+KJDF+K0PrBh6F+d1AgIBz0VcxOylDkryzJ6EON4tXzexOaXGpXdrwkr5l6c+wFooWPu2Uc3KhcIrvT6ssKsj5XohkAlj7Blrwg2lJ8PYk7VWr1s1yQX3e6zW1ZNA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725027509; c=relaxed/simple;
	bh=kzjMZaDQ+xG4BfJifsf8U6rkq0g8UeDkJLn7iHApJVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEwVsUiJ/e9Qwa/5I3nTkoRYT/zKzExjeCgyALGyi09Z4iEuMMohW8UANa7c0iUycP6rfcLwq7EPUsHpxZMRV/niesYTTCGgzwgqzW3e67HLtAhAVecTmS9OPSJ7ew6ErlUnRaiV+2aGiw7gSDypFsX2YRzo+CIUxgN+HB3Xjb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GMDVdZRC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725027506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ycVg1x9tXPFTKLRTderi7SLBgh7zP/ApOSYr7txowM=;
	b=GMDVdZRCBVGvp8ed+yFsy/oktaLRCYtIaT+BxeI2BWND3C5FsKI+JNcaskPQeq5o8t72kE
	SCp34dshju0H3jrHDmFNwOLlUJM9GujS59iJMLcpYr7bqgd/XP424VGg3eKKQ/whOTZTCX
	ppEsBJyzXYqjFgPkunzelixq8YpJxNc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-Kab89R1lP665Yn8Uhprd4Q-1; Fri,
 30 Aug 2024 10:18:21 -0400
X-MC-Unique: Kab89R1lP665Yn8Uhprd4Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87DE61954B2E;
	Fri, 30 Aug 2024 14:18:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.148])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 260813001FC3;
	Fri, 30 Aug 2024 14:18:12 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 30 Aug 2024 16:18:10 +0200 (CEST)
Date: Fri, 30 Aug 2024 16:18:03 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, paulmck@kernel.org,
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 4/8] uprobes: travers uprobe's consumer list
 locklessly under SRCU protection
Message-ID: <20240830141803.GB20163@redhat.com>
References: <20240829183741.3331213-1-andrii@kernel.org>
 <20240829183741.3331213-5-andrii@kernel.org>
 <ZtD_x9zxLjyhS37Z@krava>
 <CAEf4Bzb3mCWK5St51bRDnQ1b-aTj=2w6bi6MkZydW48s=R+CCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzb3mCWK5St51bRDnQ1b-aTj=2w6bi6MkZydW48s=R+CCA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 08/29, Andrii Nakryiko wrote:
>
> On Thu, Aug 29, 2024 at 4:10 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > > @@ -2101,17 +2110,24 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
> > >                       need_prep = true;
> > >
> > >               remove &= rc;
> > > +             has_consumers = true;
> > >       }
> > >       current->utask->auprobe = NULL;
> > >
> > >       if (need_prep && !remove)
> > >               prepare_uretprobe(uprobe, regs); /* put bp at return */
> > >
> > > -     if (remove && uprobe->consumers) {
> > > -             WARN_ON(!uprobe_is_active(uprobe));
> > > -             unapply_uprobe(uprobe, current->mm);
> > > +     if (remove && has_consumers) {
> > > +             down_read(&uprobe->register_rwsem);
> > > +
> > > +             /* re-check that removal is still required, this time under lock */
> > > +             if (!filter_chain(uprobe, current->mm)) {
> >
> > sorry for late question, but I do not follow this change..
> >
> > at this point we got 1 as handler's return value from all the uprobe's consumers,
> > why do we need to call filter_chain in here.. IIUC this will likely skip over
> > the removal?
> >
>
> Because we don't hold register_rwsem we are now racing with
> registration. So while we can get all consumers at the time we were
> iterating over the consumer list to request deletion, a parallel CPU
> can add another consumer that needs this uprobe+PID combination. So if
> we don't double-check, we are risking having a consumer that will not
> be triggered for the desired process.

Oh, yes, but this logic is wrong in that it assumes that uc->filter != NULL.
At least it adds the noticeable change in behaviour.

Suppose we have a singler consumer UC with ->filter == NULL. Now suppose
that UC->handler() returns UPROBE_HANDLER_REMOVE.

Before this patch handler_chain() calls unapply_uprobe(), and I think
we should keep this behaviour.

After this patch unapply_uprobe() won't be called: consumer_filter(UC)
returns true, UC->filter == NULL means "probe everything". But I think
that UPROBE_HANDLER_REMOVE must be respected in this case anyway.

Thanks Jiri, I missed that too :/

Oleg.


