Return-Path: <bpf+bounces-75462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38CDC853A9
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 14:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73E153B1602
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 13:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2C423EA95;
	Tue, 25 Nov 2025 13:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyPpYoPo"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473062459EA
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764078316; cv=none; b=OjzH6NuQL/YTZE+c4W+OynQnXxTqJadhEzZ/K0Aix6ia2+cDw49vxZZz1xRKJuuMkUwdERId9//m9qCiaQrPB5FByg7Tb0b++jMwcJSQUWuiHafuKgRk4/KgL3Ou3CVdPbbsu41s3m35XbMrjKg/lFUxDQSyNXA0UEcXzVJwmLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764078316; c=relaxed/simple;
	bh=UYHR5Ac4tZNNbRS8zBCdwL6LoHdLKzpH1P31hhx2JNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuQCp5QJEhYL1sh9156bRtoDv6MxOXAYH8eiNJXA1n0TFhdjSXbe6srqY+jJtbFVkaWpx+fjZQLqmW2AmW1OoOvwvDacgWsQsTWmRQTgwQGA+rtks0rdaHfo8CyIk1OlWN0iXItRQyvb71RfCVofPfV5khxOgXKuEI16GFYPHKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eyPpYoPo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764078313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GVMX2ox8QdzhMFnPrP8f7oVFxmESShAdruJb0tDYGYw=;
	b=eyPpYoPonrp3HR0OhWnMxWP1wOIucbGH2JreVCijb0MclI0rXB+7wgCHrP0JueKjK+K912
	df5xcnq2L1/qBdlL70FF/4205/5i7Q/PaJzlZ4JXq6aYbW9fqnCcTUDk9/RnBN7JE4deHd
	pYGVcHglgV3Tv/1TeUULgotAgv74TWY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-aR2Ij-vzPTCxRbfzxECeAw-1; Tue,
 25 Nov 2025 08:45:09 -0500
X-MC-Unique: aR2Ij-vzPTCxRbfzxECeAw-1
X-Mimecast-MFC-AGG-ID: aR2Ij-vzPTCxRbfzxECeAw_1764078308
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E5171800250;
	Tue, 25 Nov 2025 13:45:08 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.102])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 844603003761;
	Tue, 25 Nov 2025 13:45:03 +0000 (UTC)
Date: Tue, 25 Nov 2025 10:45:01 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Tomas Glozar <tglozar@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	John Kacur <jkacur@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:\\b|_)bpf(?:\\b|_)" <bpf@vger.kernel.org>
Subject: Re: [rtla 05/13] rtla: Simplify argument parsing
Message-ID: <oamfaffwyj6y3mtmhjxlk5u552xvdc4xd6is4dg2mxyh55ebe5@y6fsy73ig5ez>
References: <20251117184409.42831-1-wander@redhat.com>
 <20251117184409.42831-6-wander@redhat.com>
 <e96f06667d07fe7f207fc8769218967d22cf7634.camel@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e96f06667d07fe7f207fc8769218967d22cf7634.camel@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Nov 24, 2025 at 06:46:33PM -0600, Crystal Wood wrote:
> On Mon, 2025-11-17 at 15:41 -0300, Wander Lairson Costa wrote:
> 
> >  
> > +/*
> > + * extract_arg - extract argument value from option token
> > + * @token: option token (e.g., "file=trace.txt")
> > + * @opt: option name to match (e.g., "file")
> > + *
> > + * Returns pointer to argument value after "=" if token matches "opt=",
> > + * otherwise returns NULL.
> > + */
> > +#define extract_arg(token, opt) (				\
> > +	strlen(token) > STRING_LENGTH(opt "=") &&		\
> > +	!strncmp_static(token, opt "=")				\
> > +		? (token) + STRING_LENGTH(opt "=") : NULL )
> 
> This could be implemented as a function (albeit without the
> concatenation trick)... but if it must be a macro, at least encase it
> with ({ }) so it behaves more like a function.
> 
> > +
> >  /*
> >   * actions_parse - add an action based on text specification
> >   */
> >  int
> >  actions_parse(struct actions *self, const char *trigger, const char *tracefn)
> >  {
> > +
> >  	enum action_type type = ACTION_NONE;
> 
> Why this blank line?
> 

Must be a typo during the rebase process. I will remove it.

> 
> > diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
> > index 160491f5de91c..f7ff548f7fba7 100644
> > --- a/tools/tracing/rtla/src/utils.h
> > +++ b/tools/tracing/rtla/src/utils.h
> > @@ -13,8 +13,18 @@
> >  #define MAX_NICE		20
> >  #define MIN_NICE		-19
> >  
> > -#define container_of(ptr, type, member)({			\
> > -	const typeof(((type *)0)->member) *__mptr = (ptr);	\
> [snip]
> > +#define container_of(ptr, type, member)({				\
> > +	const typeof(((type *)0)->member) *__mptr = (ptr);		\
> >  	(type *)((char *)__mptr - offsetof(type, member)) ; })
> 
> It's easier to review patches when they don't make unrelated aesthetic
> changes...
> 

It is just git messing up the diff. No actual change.

> -Crystal
> 


