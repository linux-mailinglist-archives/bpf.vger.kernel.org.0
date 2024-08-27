Return-Path: <bpf+bounces-38138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7859607F1
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 12:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2661F23509
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 10:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70BD19E825;
	Tue, 27 Aug 2024 10:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fGT/gQg/"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B08019DF41
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 10:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724756117; cv=none; b=DyHMHwosAXlfI4zoPTIwkoSj2e+BWewuH3LDE0OOLF3m7mr1j+F6Np62x5/g2/acs4qFGp3kGhn+QKL4UUUbJ3GMY6GA2uE7q8yoJyRhlX2LdkralFVhgnC7vCRh9t+6xwzBGni2MJL5HZon+fYslxVsLHRNvttqLNXelcpuLps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724756117; c=relaxed/simple;
	bh=xVl53fOfv/QhiqPGZVR+l9iWoS1+yj8Odrcph0zmNAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDKZCyZ3cO88QvaPMJKFJfa34+XpnLnQo2+pb35sIU00fYzqAyvoV9DC8nyo8KjxdcS9aSiD8bpBTWohYm9HFyUa6JpAfajOwChoyCmRXzwfANijFNYoDCXFeas2+4nKhZb8m+MREY2V4MPcLUN4dr+ntVPfm9e91mU4u7y4Xmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fGT/gQg/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724756115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h++flRTV6zEZsuM3dMWhkpW8l+7toYFd2wAsYZAVxWU=;
	b=fGT/gQg/wWsnmRBTwuHo4fYdcnkqBkR2+7sTs2bdtpGK5airFugg7bGSAsQkv+G7h9pJes
	xLT+tTfEoDZ4dzr4B0LLDTC8XOsd9Ea5tVhYG4Tqk24QkBkxmE8ZW4/CUyQ18bH6znnS0O
	HfjWE0MZ4ti6Cq62yMaff19Vqx/JaGk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-68zrnNmmOieF4R4IrWting-1; Tue,
 27 Aug 2024 06:55:11 -0400
X-MC-Unique: 68zrnNmmOieF4R4IrWting-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 370581955D55;
	Tue, 27 Aug 2024 10:55:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1756A1955F40;
	Tue, 27 Aug 2024 10:55:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 27 Aug 2024 12:55:02 +0200 (CEST)
Date: Tue, 27 Aug 2024 12:54:56 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Tianyi Liu <i.pear@outlook.com>, andrii.nakryiko@gmail.com,
	mhiramat@kernel.org, ajor@meta.com, albancrequy@linux.microsoft.com,
	bpf@vger.kernel.org, flaniel@linux.microsoft.com,
	linux-trace-kernel@vger.kernel.org, linux@jordanrome.com,
	mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <20240827105455.GE30765@redhat.com>
References: <CAEf4Bzb29=LUO3fra40XVYN1Lm=PebBFubj-Vb038ojD6To2AA@mail.gmail.com>
 <ME0P300MB04163A2993D1B545C3533DDC9D892@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <20240825171417.GB3906@redhat.com>
 <20240825224018.GD3906@redhat.com>
 <ZsxTckUnlU_HWDMJ@krava>
 <20240826115752.GA21268@redhat.com>
 <Zs2lpd0Ni0aJoHwI@krava>
 <Zs2oV5R2blKw5c9w@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs2oV5R2blKw5c9w@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 08/27, Jiri Olsa wrote:
>
> On Tue, Aug 27, 2024 at 12:08:39PM +0200, Jiri Olsa wrote:
> > >
> > > 	-	if (link->task && current->mm != link->task->mm)
> > > 	+	if (link->task && !same_thread_group(current, link->task))
> > >
> > > in uprobe_prog_run() to make "filter by *process*" true, but this won't
> > > fix the problem with link->task->mm == NULL in uprobe_multi_link_filter().
> >
> > would the same_thread_group(current, link->task) work in such case?
> > (zombie leader with other alive threads)
>
> should uprobe_perf_filter use same_thread_group as well instead
> of mm pointers check?

uprobe_perf_filter or uprobe_multi_link_filter ?

In any case I don't think same_thread_group(current, whatever) can work.

For example, uc->filter() can be called from uprobe_register() paths. In
this case "current" is the unrelated task which does, say, perf-record, etc.
Even if uc->filter() was only called from handler_chain(), it couldn't work,
think of UPROBE_HANDLER_REMOVE.

See also another email I sent a minute ago.

Oleg.


