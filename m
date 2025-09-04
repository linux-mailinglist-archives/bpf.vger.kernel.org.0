Return-Path: <bpf+bounces-67401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DC5B43649
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 10:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 521411B23983
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 08:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FCA2D239F;
	Thu,  4 Sep 2025 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RbmZqyvU"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E26C2C11EC
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975886; cv=none; b=BQ1CflWYb3VipUKYbbpitywGX9l4rMkJyjUvSxmtgDThoDVz7o15TgSwS/6fKH/mTWihcxjPtQcPrwB8NTfu5Vg01Pm2KFx9XaoPYuzkeFvSGo5B6tsckJe1zW69abXeTY3Zedb9154qe1YUgGqttjcYpvYdzJBxmqeF9h2HW5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975886; c=relaxed/simple;
	bh=kd8rDK6t+wVjPKffuRs99409lYJP4hc4W7ZRJeOM6K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLUblBqfnJecjYVe/j9g8ULX7q4CQCSHC0YgILxsLglL8Lgs09fp3+NgPFCPMaR3UsJlA2WclOdlvvXnRlRT1dIb8x+KZRXEDuU0XImmzmcWCb37/FkZuItJBWXRPKqvgl1y7YTJqEAHBOIs7pjRz3KGzjpGan2MQdNnThJLcbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RbmZqyvU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756975884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bt3LAXhgvrSLIKod81c7m7+ZTsO9TpO34qJq6parCmk=;
	b=RbmZqyvUixE6PQopbcrGN4aEXW0xjTMlo2JiHby0mCDGXBAanZMKE36BhAdfXidnSvbzvt
	k9xn3S2v3ljmKItODNXpP3VKlWEbjVXMKSq/dGKrFONM7WUOgvp437+CSzj8494gWeenNu
	YpCPWAH4CFJx4ByCzbLmNbye47PtnWU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-r52OELBBN9CON0H9FJYDAw-1; Thu,
 04 Sep 2025 04:51:20 -0400
X-MC-Unique: r52OELBBN9CON0H9FJYDAw-1
X-Mimecast-MFC-AGG-ID: r52OELBBN9CON0H9FJYDAw_1756975878
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7281818004D4;
	Thu,  4 Sep 2025 08:51:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.52])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4FE2E1800446;
	Thu,  4 Sep 2025 08:51:13 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  4 Sep 2025 10:49:56 +0200 (CEST)
Date: Thu, 4 Sep 2025 10:49:50 +0200
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
Message-ID: <20250904084949.GB27255@redhat.com>
References: <20250902143504.1224726-1-jolsa@kernel.org>
 <20250902143504.1224726-3-jolsa@kernel.org>
 <20250903112648.GC18799@redhat.com>
 <aLicCjuqchpm1h5I@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLicCjuqchpm1h5I@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 09/03, Jiri Olsa wrote:
>
> On Wed, Sep 03, 2025 at 01:26:48PM +0200, Oleg Nesterov wrote:
> > On 09/02, Jiri Olsa wrote:
> > >
> > > If user decided to take execution elsewhere, it makes little sense
> > > to execute the original instruction, so let's skip it.
> >
> > Exactly.
> >
> > So why do we need all these "is_unique" complications? Only a single
> > is_unique/exclusive consumer can change regs->ip, so I guess handle_swbp()
> > can just do
> >
> > 	handler_chain(uprobe, regs);
> > 	if (instruction_pointer(regs) != bp_vaddr)
> > 		goto out;
>
> hum, that's what I did in rfc [1] but I thought you did not like that [2]
>
> [1] https://lore.kernel.org/bpf/20250801210238.2207429-2-jolsa@kernel.org/
> [2] https://lore.kernel.org/bpf/20250802103426.GC31711@redhat.com/
>
> I guess I misunderstood your reply [2], I'd be happy to drop the
> unique/exclusive flag

Well, but that rfc didn't introduce the exclusive consumers, and I think
we agree that even with these changes the non-exclusive consumers must
never change regs->ip?

> > But if a non-exclusive consumer changes regs->ip, we have a problem
> > anyway, right?
> >
> > We can probably add something like
> >
> > 		rc = uc->handler(uc, regs, &cookie);
> > 	+	WARN_ON(!uc->is_unique && instruction_pointer(regs) != bp_vaddr);
> >
> > into handler_chain(), although I don't think this is needed.

Oleg.


