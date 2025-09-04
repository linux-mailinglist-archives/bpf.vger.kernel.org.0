Return-Path: <bpf+bounces-67429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FD5B43A3F
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 13:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F6C4826BB
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 11:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247582FF177;
	Thu,  4 Sep 2025 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMokCMmm"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D162FD1DD
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 11:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756985097; cv=none; b=rxhy86j7cndMyJBr/lkrEacvdDb/u0zbsfrbFlLB6l/yHvi8rObN52oRPYcj4Ui6QeBehsCKzCQ4f7ncs6+KGbRSoJbUHbsbyFszq7emjg+UwGXodKQa4bQnphfy50wuQqZU9yjNL2B0tVlGqtfr/TCyeT8m9Pv+xSaJqIC1jzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756985097; c=relaxed/simple;
	bh=kf+9HDiVeFZDHfJthh5dLpO1I207zVKh8nvH272oWPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h61yrVTuQeWc4is5XRPATN44T0a5fWZldPKxDJT3Xgaqit+32iJRc6a1i6qaGVsTVWRpG+8zP5vp8Gn5dZtBJiQQNclpoA+PpaiGwyg3xy+rzfOi6XQ4spCNm7ktSocjWDSYrCu3uIj6nPZi00Z/jqwRh4JIf2deb/ep2HYugRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XMokCMmm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756985095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NNlSWipseSmsVlx3oPXi/Dm4sWLczG9la9f/1OIiTnU=;
	b=XMokCMmmVjvf4fBVvZrKqiWYm3tX69nSwgqtfjJcgZ8PUluCOII+80J6R5jAcn0ARjezdQ
	IcQwCXFMjCQlU02RXo+xDF6FUv4z+lvPaXbyVAJq1JDt0cYX9wEPrKt/T5sWfJ5slNpUYk
	3g81Zia5zlHIRjtQfnxYPAhzvgUHA+Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-nqnVc4rAM9WkkRaS95Gtzw-1; Thu,
 04 Sep 2025 07:24:49 -0400
X-MC-Unique: nqnVc4rAM9WkkRaS95Gtzw-1
X-Mimecast-MFC-AGG-ID: nqnVc4rAM9WkkRaS95Gtzw_1756985088
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E0D91800378;
	Thu,  4 Sep 2025 11:24:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.52])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 481FE3002D26;
	Thu,  4 Sep 2025 11:24:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  4 Sep 2025 13:23:25 +0200 (CEST)
Date: Thu, 4 Sep 2025 13:23:17 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 02/11] uprobes: Skip emulate/sstep on unique
 uprobe when ip is changed
Message-ID: <20250904112317.GD27255@redhat.com>
References: <20250902143504.1224726-1-jolsa@kernel.org>
 <20250902143504.1224726-3-jolsa@kernel.org>
 <20250903112648.GC18799@redhat.com>
 <aLicCjuqchpm1h5I@krava>
 <20250904084949.GB27255@redhat.com>
 <aLluB1Qe6Y9B8G_e@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLluB1Qe6Y9B8G_e@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 09/04, Jiri Olsa wrote:
>
> On Thu, Sep 04, 2025 at 10:49:50AM +0200, Oleg Nesterov wrote:
> > On 09/03, Jiri Olsa wrote:
> > >
> > > On Wed, Sep 03, 2025 at 01:26:48PM +0200, Oleg Nesterov wrote:
> > > > On 09/02, Jiri Olsa wrote:
> > > > >
> > > > > If user decided to take execution elsewhere, it makes little sense
> > > > > to execute the original instruction, so let's skip it.
> > > >
> > > > Exactly.
> > > >
> > > > So why do we need all these "is_unique" complications? Only a single
> > > > is_unique/exclusive consumer can change regs->ip, so I guess handle_swbp()
> > > > can just do
> > > >
> > > > 	handler_chain(uprobe, regs);
> > > > 	if (instruction_pointer(regs) != bp_vaddr)
> > > > 		goto out;
> > >
> > > hum, that's what I did in rfc [1] but I thought you did not like that [2]
> > >
> > > [1] https://lore.kernel.org/bpf/20250801210238.2207429-2-jolsa@kernel.org/
> > > [2] https://lore.kernel.org/bpf/20250802103426.GC31711@redhat.com/
> > >
> > > I guess I misunderstood your reply [2], I'd be happy to drop the
> > > unique/exclusive flag
> >
> > Well, but that rfc didn't introduce the exclusive consumers, and I think
> > we agree that even with these changes the non-exclusive consumers must
> > never change regs->ip?
>
> ok, got excited too soon.. so you meant getting rid of is_unique
> check only for this patch and have just change below..  but keep
> the unique/exclusive flag from patch#1

Yes, this is what I meant,

> IIUC Andrii would remove the unique flag completely?

Lets wait for Andrii...

Oleg.


