Return-Path: <bpf+bounces-31452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9D48FD307
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 18:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B5E51C219EB
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 16:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5571418FDB5;
	Wed,  5 Jun 2024 16:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bX3/iBvk"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A99188CDE
	for <bpf@vger.kernel.org>; Wed,  5 Jun 2024 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717605492; cv=none; b=MgSA85qoOBmL6vCfuJe+L1f6dChWlAsyNFGKuOF/uI4BDSXBgbmB4ITkCpzviSv07erTZe4VBISlWubRmkonGr94giQ9ewBRzUPqYJuVfjbwlxHEGQ9o6PkWPdSTS1ZvsRpavmvawxea3nG52AFuNPx7/dJHpqMB4AHwoFGgvwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717605492; c=relaxed/simple;
	bh=qYHQHvxEOL0+ja9/l1xmzQYzTlCH0OQ9ADs1DPd83aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPZOitNZhAHaPl3T/33ADXZkF6gv9O6YXmr+nCx92GjjfisG5YGNy9rbRAuao1pyjPuYbItk2ulPoVbxq/XyqwxDf6SW8p5dUEk7YuofbQUlj0xlW2q/xTBk6dm1TkM9CkJqvvenUIKe7IhK5BZuj7sDJo8gFIZ/Tlxm+M5w9qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bX3/iBvk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717605490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XBGg4L8V3Q5EYMEYMCQld5ntR2Bf7/IEh8rTgIfGGV0=;
	b=bX3/iBvkGc93Nx1ICIQ0/NGHp6kv7GBr00qyf7YSDoDx23CXVIJULxiTHbxqZzb+qFX1tS
	uuFHuY7Cuo5OOG+Oxf4voSzIVOZVt+8SF97tbrBpQl53HXYwXz3it6nBuXnU1nY7OV9yUF
	yr0mkD/pzK78jRi1qvon24SuWPKpFbw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632--yINWIP3P5KgloQ-Sd_GjA-1; Wed,
 05 Jun 2024 12:38:06 -0400
X-MC-Unique: -yINWIP3P5KgloQ-Sd_GjA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCB8C1954216;
	Wed,  5 Jun 2024 16:38:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.62])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0386B3000623;
	Wed,  5 Jun 2024 16:37:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  5 Jun 2024 18:36:32 +0200 (CEST)
Date: Wed, 5 Jun 2024 18:36:25 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
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
Subject: Re: [RFC bpf-next 01/10] uprobe: Add session callbacks to
 uprobe_consumer
Message-ID: <20240605163624.GG25006@redhat.com>
References: <20240604200221.377848-1-jolsa@kernel.org>
 <20240604200221.377848-2-jolsa@kernel.org>
 <20240605152457.GD25006@redhat.com>
 <20240605160117.GE25006@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605160117.GE25006@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 06/05, Oleg Nesterov wrote:
>
> On 06/05, Oleg Nesterov wrote:
> >
> > > +/*
> > > + * Make sure all the uprobe consumers have only one type of entry
> > > + * callback registered (either handler or handler_session) due to
> > > + * different return value actions.
> > > + */
> > > +static int consumer_check(struct uprobe_consumer *curr, struct uprobe_consumer *uc)
> > > +{
> > > +	if (!curr)
> > > +		return 0;
> > > +	if (curr->handler_session || uc->handler_session)
> > > +		return -EBUSY;
> > > +	return 0;
> > > +}
> >
> > Hmm, I don't understand this code, it doesn't match the comment...
> >
> > The comment says "all the uprobe consumers have only one type" but
> > consumer_check() will always fail if the the 1st or 2nd consumer has
> > ->handler_session != NULL ?
> >
> > Perhaps you meant
> >
> > 	if (!!curr->handler != !!uc->handler)
> > 		return -EBUSY;
> >
> > ?
>
> OK, the changelog says
>
> 	Which means that there can be only single user of a uprobe (inode +
> 	offset) when session consumer is registered to it.
>
> so the code is correct. But I still think the comment is misleading.

Cough... perhaps it is correct but I am still confused even we forget about
the comment ;)

OK, uprobe can have a single consumer with ->handler_session != NULL. I guess
this is because return_instance->data is "global".

So uprobe can have multiple handler_session == NULL consumers before
handler_session != NULL, but not after ?

Oleg.


