Return-Path: <bpf+bounces-39810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480CC977C37
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 11:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 654F1B224B1
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 09:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0201D67A6;
	Fri, 13 Sep 2024 09:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AdJlqcEY"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68F61BDA90
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726219952; cv=none; b=hJk6thgut1RADiAk183kPhsoA65i5YxOHZKSxdTwLbryobygq9akbO1rOfshOzTfrgGontPd9QXU87bLUaaK76DKS+gSHwxaNwhr8AL6ZH4vqMO/376qZ1V4VeNMseCxZTNpqf5wzZNXt7DzmfCwhRNmm4ui29M6rFFkuMg0a2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726219952; c=relaxed/simple;
	bh=cIVkaDlafyz17Lv00EsE5GUygASztsmlwwverOYBNZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJMVttnVzhcx9rXgH3bWYpA74+eB/j4+0VT14+Yal8Jf9Ipj02p0z1KA2/hrF6oKbVhb2cIGy4S+edtT5KHbC56qNKiJOTQWt9Zf25IxKph+mtaaM7/fnshi8XfVTc58tE+eybG461pTOtgnGAFLwJ+3DpU6NgvpHc2eSX5rvrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AdJlqcEY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726219949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=icP+9T+nckSCW+51d5IyXV2vWbgpkam3VDgb48zcQBk=;
	b=AdJlqcEYIWXZPjv4ybJDDFCzFZaVBZ/Qkq/CHExKoMQpzWkAAkUTZE6QwymaI5MDFkxbhs
	fYqs+TMlT6L+L7bNaxFKpy/HZscrARTduknW8j0v9s7YOcHHe/yJ3FFEE8F7HlQjIeWFtS
	6OqKB/IsQjol27tiv+GrOXDP6H2UB90=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-ChSwSbbTOymr1SyfvELLRg-1; Fri,
 13 Sep 2024 05:32:23 -0400
X-MC-Unique: ChSwSbbTOymr1SyfvELLRg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0A9C1955F10;
	Fri, 13 Sep 2024 09:32:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.25])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 952353001D10;
	Fri, 13 Sep 2024 09:32:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 13 Sep 2024 11:32:09 +0200 (CEST)
Date: Fri, 13 Sep 2024 11:32:01 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
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
Message-ID: <20240913093201.GA19305@redhat.com>
References: <20240909074554.2339984-1-jolsa@kernel.org>
 <20240909074554.2339984-2-jolsa@kernel.org>
 <20240912163539.GE27648@redhat.com>
 <ZuP5dyfgT0PHaf_4@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuP5dyfgT0PHaf_4@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 09/13, Jiri Olsa wrote:
>
> On Thu, Sep 12, 2024 at 06:35:39PM +0200, Oleg Nesterov wrote:
> > >  	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
> > >  				 srcu_read_lock_held(&uprobes_srcu)) {
> > > +		/*
> > > +		 * If we don't find return consumer, it means uprobe consumer
> > > +		 * was added after we hit uprobe and return consumer did not
> > > +		 * get registered in which case we call the ret_handler only
> > > +		 * if it's not session consumer.
> > > +		 */
> > > +		ric = return_consumer_find(ri, &iter, uc->id);
> > > +		if (!ric && uc->session)
> > > +			continue;
> > >  		if (uc->ret_handler)
> > > -			uc->ret_handler(uc, ri->func, regs);
> > > +			uc->ret_handler(uc, ri->func, regs, ric ? &ric->cookie : NULL);
> >
> > So why do we need the new uc->session member and the uc->session above ?
> >
> > If return_consumer_find() returns NULL, uc->ret_handler(..., NULL) can handle
> > this case itself?
>
> I tried to explain that in the comment above.. we do not want to
> execute session ret_handler at all in this case, because its entry
> counterpart did not run

I understand, but the session ret_handler(..., __u64 *data) can simply do

	// my ->handler() didn't run or it didn't return 0
	if (!data)
		return;

at the start?

Oleg.


