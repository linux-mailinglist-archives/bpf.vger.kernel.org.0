Return-Path: <bpf+bounces-31461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8958FD769
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 22:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D152A1C22BE7
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 20:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEEE15ECC6;
	Wed,  5 Jun 2024 20:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkvWpj7R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2C038FA6;
	Wed,  5 Jun 2024 20:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717618741; cv=none; b=qXonMELMIRP6Sh8hU41wViTOw5T52k25T2OXTqmOi1pEYWdYQt5e8EWd+0xBsWMBB3kmBdd3XMuSQ8tnDR3zQyxsaCW9sisfsCjzYGfeWxAydOeb0Qf1j1gbTPqHbEHPn1nM2+R5pQ6sKre+fonVzOYpul2pupX7R9SdPKway5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717618741; c=relaxed/simple;
	bh=qPNQ2QYoVmcsBrFb8aOxCU0KjrsWi5CgCOSprGNsTUo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=picvH3cDVdu5I+xPn2MnK0XyqoNyO9vfH+WtbYksddTOuzkXB7RWXjbvO/MkEbC33F0HqxfVhnITfRv/9HfNLFncWwZ0xFBuqGkHvz3k7p2XE+/CIxiWz2pPkfEUcdTk+J5bqxPAlGUdGT5S9OKHGZr8w9DaHo/h8nnxFsAyOHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkvWpj7R; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a68c8b90c85so30923066b.2;
        Wed, 05 Jun 2024 13:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717618738; x=1718223538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J5vnkugAixkdDcw84NSgFaMOrIfdvI8Mx6/AdL+ET3k=;
        b=WkvWpj7RfotAwYaX4tPY59Iz/2Tyq4lsiF46em0LbjFVjyQNkstKwxu+58dVwjHkwl
         b/wakWRo6ziWcWAJr0K1tdOd8fOlCOV2MMKvy9WLVwDLTCyYDXOAfzh01t2Wd2RtdvIq
         tTHbz3bZ0U4jNEfGxnFWE8UuuZUM3tKSzoFSHEjb5cqhGgbGNE5mJLpPPJUkLmGWh810
         BE04nmRewdW7qExkntiQblCtWxcDQYgzDeFonu9RMc7bmj5NXY/APQdYMqgn3spPtcbr
         CSqKdIlO7CgyNiC1KAguIh81c8Il16fOHQ1HTIKX/sMrlsHFsOXFV50HU1CG+ja1zQLP
         k5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717618738; x=1718223538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5vnkugAixkdDcw84NSgFaMOrIfdvI8Mx6/AdL+ET3k=;
        b=CsC9UxLvrFw/01j1ZJMSPEt0JbjU9I5CRS6JciU70nNKSQYHEDY2mLK7VVoH+hdHkd
         raLKSA/xp8DKq2D7tZRIgOYJ+il+46nSexWtssR0Aog3jXoI30P29cr9n9y6oNcEzBpl
         k0sYec810JgoQWhGR1iUl2Vj6s5P50WUBKfPeGljiQLcBy7D9/AVHsNiqKnFgEJo6yLF
         50bOK+k190q8QScmUKKOWWHfcRPUxMYPowrI1piyUqGFKApZRrJ6wX+xR2iPBQTwyKYC
         tGaiZUZYAAwMZtGojjVU8+jPc5bmiZBGmA5BM4PDiJt10Hx/qbFIj4w09aXw2wSHyEkd
         YqzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTUVG1rbDE+/7TSbFhaHwOYrFpFNR4j3MFZBLMyFCOFwSTt5SVgFWnD/sT68sfqNCdIQK0d3BNOkdvs+BXvuoPhuf8Q9laAUjeMSt/Q91/u2f1ABZLLYwNoxxNcJU4sIFrqeT3gNotdA2pjq/FJuNn62oZ41uuyoApmk7vt5R/IGmGasjg
X-Gm-Message-State: AOJu0YxPpo7zFcTbGnDlyyJYnMqn4G6zrXKTbJVuHVzpXPRGefU3XBcL
	rmxJp7F7Gs3E+anxi3Aphwr2LCZQH5FC1SkCeC4XV3VyQ5hXgsoF
X-Google-Smtp-Source: AGHT+IFObt3ud6A2I+57x4wHrM7zvq8TQaQWOLzG6FvHrg9EURxEtydzdkeYu62tkSVzHa9fR9dxlQ==
X-Received: by 2002:a17:906:591a:b0:a69:2bce:e41e with SMTP id a640c23a62f3a-a699f363807mr262253866b.9.1717618737955;
        Wed, 05 Jun 2024 13:18:57 -0700 (PDT)
Received: from krava ([83.240.63.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6900d7f6a3sm534291066b.90.2024.06.05.13.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 13:18:57 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 5 Jun 2024 22:18:55 +0200
To: Oleg Nesterov <oleg@redhat.com>
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
Message-ID: <ZmDIL85R_P8NhIwm@krava>
References: <20240604200221.377848-1-jolsa@kernel.org>
 <20240604200221.377848-2-jolsa@kernel.org>
 <20240605152457.GD25006@redhat.com>
 <20240605160117.GE25006@redhat.com>
 <20240605163624.GG25006@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605163624.GG25006@redhat.com>

On Wed, Jun 05, 2024 at 06:36:25PM +0200, Oleg Nesterov wrote:
> On 06/05, Oleg Nesterov wrote:
> >
> > On 06/05, Oleg Nesterov wrote:
> > >
> > > > +/*
> > > > + * Make sure all the uprobe consumers have only one type of entry
> > > > + * callback registered (either handler or handler_session) due to
> > > > + * different return value actions.
> > > > + */
> > > > +static int consumer_check(struct uprobe_consumer *curr, struct uprobe_consumer *uc)
> > > > +{
> > > > +	if (!curr)
> > > > +		return 0;
> > > > +	if (curr->handler_session || uc->handler_session)
> > > > +		return -EBUSY;
> > > > +	return 0;
> > > > +}
> > >
> > > Hmm, I don't understand this code, it doesn't match the comment...
> > >
> > > The comment says "all the uprobe consumers have only one type" but
> > > consumer_check() will always fail if the the 1st or 2nd consumer has
> > > ->handler_session != NULL ?
> > >
> > > Perhaps you meant
> > >
> > > 	if (!!curr->handler != !!uc->handler)
> > > 		return -EBUSY;
> > >
> > > ?
> >
> > OK, the changelog says
> >
> > 	Which means that there can be only single user of a uprobe (inode +
> > 	offset) when session consumer is registered to it.
> >
> > so the code is correct. But I still think the comment is misleading.
> 
> Cough... perhaps it is correct but I am still confused even we forget about
> the comment ;)
> 
> OK, uprobe can have a single consumer with ->handler_session != NULL. I guess
> this is because return_instance->data is "global".
> 
> So uprobe can have multiple handler_session == NULL consumers before
> handler_session != NULL, but not after ?

ah yea it should have done what's in the comment, so it's missing
the check for handler.. session handlers are meant to be exclusive

thanks,
jirka

