Return-Path: <bpf+bounces-34008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE3F9294D3
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 19:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42CAA1F21B0B
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 17:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2145213B798;
	Sat,  6 Jul 2024 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfWTs2oa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD3F23BE;
	Sat,  6 Jul 2024 17:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720285533; cv=none; b=lwG6Q6a7JqjfhKzTTkd5JQNf+nMt8sl9aDUXVEOI/LCC2+r8+KuOagz5XtN2H0R3vo3dhpIUj/bNmxjEyM3kOJipA/xS6oydrHTJ/0GrvnOnjA3lNYmzuTXmUI4AjMJvlP1qE0yEXlqTsUK2PkcM46zjNP5/y639jhrQPMfgVnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720285533; c=relaxed/simple;
	bh=4dYGD48/HrgHYMB0/AKBv55cuuhhH/mjZjASn8v6DUA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NonvY76jHgI6KBSORFRYeEJLaQkmfs0iNaOQepXODDyoaqYYFuq6nmFlv2WJnfIgMtfHmkLj9ScNJD2KaiAuKxcNMm5KphLnhk4yaVXraUB2SkGlnJuCCBRUaTC+M0+kzscIwohQKVrBBkQivPQbTU1VR02Ao+0fuinoR5Hidtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EfWTs2oa; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-58b447c51bfso3229082a12.2;
        Sat, 06 Jul 2024 10:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720285530; x=1720890330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6bRUbU9RljerJmfJNtxCJsDTINixdX/nlJzpTUfyZY8=;
        b=EfWTs2oadbEgSsebYiSYtiYFysa1uoPzITU5D81SZR9SN49y7JExZ/vcoywRUEJJi9
         8arrm7IrboNLIYpqFwPDvKRAwD9PbKOBfQfT+uEy9AVSdqPfYqlu4mcYrpeZgQ/+mT8M
         81JxRDJeKSKyaoO5jFvuztSuI/fULEQCuKgCC/5oadUvVJRYSjE29W4lZxaDEKapkII9
         n1u5DhC1ACr4wlryGoeD5Jceo31XAvDaI7qYH5NVWdsH6ZQmHmQuP0kbM6qaIzoR+cj7
         sAdVSDV1G3o7Xgw9Y0NP4xHMJLUCLOG5bPB9QaDouQ5WxD6zCGudTkaICh1jsSC8DtXY
         +zAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720285530; x=1720890330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bRUbU9RljerJmfJNtxCJsDTINixdX/nlJzpTUfyZY8=;
        b=wYz2qs7RryaoN69n6dkkOx7NtiKiP/xhqQvBgDOnlAfBhTMrot7e4+88o0LcDZ0gp1
         KZd9DakWZVebrYnIy7kKDDBRUfbfpsbiDdhEgkBQJFho6VIklbmyeg01XoHQC+bFyJUL
         KJaQj38wH8O16qlOsoa4qbErJUZpC6+J+xrmcNeN9drcwz9iNq43UPO0mMFkgdiDXLdO
         wPjbfISxtAd0H6twYWjKPS3PObkhsHHFSW39CermmAYfUctUbyu96hFfqySezmM1Lfrt
         kBhDChS/1QmVy37v6tr7Tebovk5l/tmmBrGlk12/cHYC3JELNc5x1KqxtNVXrnTVCSQG
         4S+w==
X-Forwarded-Encrypted: i=1; AJvYcCXEuxg1xBO4GtDvZObZtx2GictQhUpjb4alPXoczWCuQpnIMuvvzObNe/ejx5e8SUi+CJY36b8YOG2ElonQmnhIkKIf5tIHnGeJdwCIXs7g8548UuB8CQQ1CWOI75YPZMqtXKjTJL+A
X-Gm-Message-State: AOJu0YzYlElt5SAS0Z+mOSxDh3103KqA/B7rQ574nap6RsBi4C7iQ1GY
	YP+KanhFUfB+imlX0QKGXsmJ7YzZ0D8IJdllIyQjxQcL3waTTUIq
X-Google-Smtp-Source: AGHT+IHjMsA32JUNyYrE5ynFOEp+2BjfqFm+7Rxrhk8GyBXEqp2v7J7EKJJdXxdN94R+wdNESa1MEg==
X-Received: by 2002:a17:906:2a58:b0:a77:dbe2:31ff with SMTP id a640c23a62f3a-a77dbe23251mr213225166b.66.1720285530062;
        Sat, 06 Jul 2024 10:05:30 -0700 (PDT)
Received: from krava (37-188-174-24.red.o2.cz. [37.188.174.24])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77dcf8bf36sm106380866b.36.2024.07.06.10.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 10:05:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 6 Jul 2024 19:05:24 +0200
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
	linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
	bpf@vger.kernel.org, paulmck@kernel.org, clm@meta.com
Subject: Re: [PATCH v2 04/12] uprobes: revamp uprobe refcounting and lifetime
 management
Message-ID: <Zol5VIvCRE__dUS-@krava>
References: <20240701223935.3783951-1-andrii@kernel.org>
 <20240701223935.3783951-5-andrii@kernel.org>
 <20240705153705.GA18551@redhat.com>
 <Zol4MjpXdXPXQKXI@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zol4MjpXdXPXQKXI@krava>

On Sat, Jul 06, 2024 at 07:00:34PM +0200, Jiri Olsa wrote:
> On Fri, Jul 05, 2024 at 05:37:05PM +0200, Oleg Nesterov wrote:
> > Tried to read this patch, but I fail to understand it. It looks
> > obvioulsy wrong to me, see below.
> > 
> > I tend to agree with the comments from Peter, but lets ignore them
> > for the moment.
> > 
> > On 07/01, Andrii Nakryiko wrote:
> > >
> > >  static void put_uprobe(struct uprobe *uprobe)
> > >  {
> > > -	if (refcount_dec_and_test(&uprobe->ref)) {
> > > +	s64 v;
> > > +
> > > +	/*
> > > +	 * here uprobe instance is guaranteed to be alive, so we use Tasks
> > > +	 * Trace RCU to guarantee that uprobe won't be freed from under us, if
> > > +	 * we end up being a losing "destructor" inside uprobe_treelock'ed
> > > +	 * section double-checking uprobe->ref value below.
> > > +	 * Note call_rcu_tasks_trace() + uprobe_free_rcu below.
> > > +	 */
> > > +	rcu_read_lock_trace();
> > > +
> > > +	v = atomic64_add_return(UPROBE_REFCNT_PUT, &uprobe->ref);
> > > +
> > > +	if (unlikely((u32)v == 0)) {
> > 
> > I must have missed something, but how can this ever happen?
> > 
> > Suppose uprobe_register(inode) is called the 1st time. To simplify, suppose
> > that this binary is not used, so _register() doesn't install breakpoints/etc.
> > 
> > IIUC, with this change (u32)uprobe->ref == 1 when uprobe_register() succeeds.
> > 
> > Now suppose that uprobe_unregister() is called right after that. It does
> > 
> > 	uprobe = find_uprobe(inode, offset);
> > 
> > this increments the counter, (u32)uprobe->ref == 2
> > 
> > 	__uprobe_unregister(...);
> > 
> > this wont't change the counter,
> 
> __uprobe_unregister calls delete_uprobe that calls put_uprobe ?

ugh, wrong sources.. ok, don't know ;-)

jirka

> 
> jirka
> 
> > 
> > 	put_uprobe(uprobe);
> > 
> > this drops the reference added by find_uprobe(), (u32)uprobe->ref == 1.
> > 
> > Where should the "final" put_uprobe() come from?
> > 
> > IIUC, this patch lacks another put_uprobe() after consumer_del(), no?
> > 
> > Oleg.
> > 

