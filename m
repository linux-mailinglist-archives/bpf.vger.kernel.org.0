Return-Path: <bpf+bounces-38168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A96960D88
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 16:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D0431F2455C
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 14:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C1B1C4ED0;
	Tue, 27 Aug 2024 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dq/jL9C3"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BAA1BA87C
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724768788; cv=none; b=qHePCmSP/2O7DYqIHQBaZUgAS/QnfUbiYehkedf4SIra/NgEMfegRVMtX2f7qRR103runP9ug2lza1fKHIpoDBrDZy6NiylCTYkPNj7pkrrpyGnAuqmxV+OoOiQRn+by/VSoMbYBSKM98ciA+eVehcxkcXy5wPW4Nj6+jhwRnXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724768788; c=relaxed/simple;
	bh=1KqMCRhRHDTcWOdf302AjkxFH5FSKKGXlvdrIrFvszw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOaAu8i5eoQ+bgUvELpDePObJ2anFewZdlWAniVV4f2bNXTqQuc28IrnTdGVejWWl4Ft493NKeeqUfxc+rRC0bspAqC3K6BbLiwRcEdNpq2CpO/6XeYrNDcnx5hG8cfBhKe7vadmYveEvZhFHELxdkimjphEoVl6bRiNZfeoukw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dq/jL9C3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724768786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ATk3FZ1Fa0HUkud8qmHhRhX+USrye2F9BZBXsUYQl2s=;
	b=Dq/jL9C39J4xh+yDYy/iQfc7QGWeWiOhk4HRYllCrijlJC3UKQVTpWHnfA22bFpkgnVAjV
	CYf1YORhms51zub29Jammdj1fwHkCyf8+gc6RwU5rOlI7odOm9xuq5Sdu4OpKWhJaFSDGK
	t3eEP95QZ5P+XwXWvlQTCv1hIbhCV7A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-228AWLEJMoe-8sS1s5gzZQ-1; Tue,
 27 Aug 2024 10:26:22 -0400
X-MC-Unique: 228AWLEJMoe-8sS1s5gzZQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45E6B1954B34;
	Tue, 27 Aug 2024 14:26:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0A3FC19560AA;
	Tue, 27 Aug 2024 14:26:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 27 Aug 2024 16:26:13 +0200 (CEST)
Date: Tue, 27 Aug 2024 16:26:08 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Tianyi Liu <i.pear@outlook.com>, andrii.nakryiko@gmail.com,
	mhiramat@kernel.org, ajor@meta.com, albancrequy@linux.microsoft.com,
	bpf@vger.kernel.org, flaniel@linux.microsoft.com,
	linux-trace-kernel@vger.kernel.org, linux@jordanrome.com,
	mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <20240827142607.GF30765@redhat.com>
References: <CAEf4Bzb29=LUO3fra40XVYN1Lm=PebBFubj-Vb038ojD6To2AA@mail.gmail.com>
 <ME0P300MB04163A2993D1B545C3533DDC9D892@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <20240825171417.GB3906@redhat.com>
 <20240825224018.GD3906@redhat.com>
 <ZsxTckUnlU_HWDMJ@krava>
 <20240826115752.GA21268@redhat.com>
 <Zs2lpd0Ni0aJoHwI@krava>
 <20240827104052.GD30765@redhat.com>
 <Zs3VWu2axL2tQXkc@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs3VWu2axL2tQXkc@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 08/27, Jiri Olsa wrote:
>
> On Tue, Aug 27, 2024 at 12:40:52PM +0200, Oleg Nesterov wrote:
> >  static bool
> >  uprobe_multi_link_filter(struct uprobe_consumer *con, struct mm_struct *mm)
> >  {
> >  	struct bpf_uprobe *uprobe;
> > +	struct task_struct *task, *t;
> > +	bool ret = false;
> >
> >  	uprobe = container_of(con, struct bpf_uprobe, consumer);
> > -	return uprobe->link->task->mm == mm;
> > +	task = uprobe->link->task;
> > +
> > +	rcu_read_lock();
> > +	for_each_thread(task, t) {
> > +		struct mm_struct *mm = READ_ONCE(t->mm);
> > +		if (mm) {
> > +			ret = t->mm == mm;
> > +			break;
> > +		}
> > +	}
> > +	rcu_read_unlock();
>
> that seems expensive if there's many threads

many threads with ->mm == NULL? In the likely case for_each_thread()
stops after the first t->mm check.

> could we check the leader first and only if it's gone fallback to this?

up to you..

Oleg.


