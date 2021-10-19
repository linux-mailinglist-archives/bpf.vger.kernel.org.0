Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F8F4336FE
	for <lists+bpf@lfdr.de>; Tue, 19 Oct 2021 15:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbhJSN2j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Oct 2021 09:28:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20900 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230487AbhJSN2i (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 19 Oct 2021 09:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634649985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bUbADiikNrKItOeyvl1XlM9vGXDNaqE+WJmF5wYrcJI=;
        b=CYuXVRkmsVbk9lVVonDcwaJdK1mpvpjCwXNytbPFKqBtZWbQj6FJEPXJT3NcIyqTfD0pbZ
        XXhDvzdnEAZIhkdGs5ms6KSekX4SKUyGI2TxTsba3HVZ6pCuo8TgYUD2F1wibtTpnOMXtn
        aTW4/TK/7dOXhzWGA2SyDxotWhkraIs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-_5H67tFTNwujxkjDmbjrFA-1; Tue, 19 Oct 2021 09:26:24 -0400
X-MC-Unique: _5H67tFTNwujxkjDmbjrFA-1
Received: by mail-ed1-f72.google.com with SMTP id l10-20020a056402230a00b003db6977b694so17558069eda.23
        for <bpf@vger.kernel.org>; Tue, 19 Oct 2021 06:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bUbADiikNrKItOeyvl1XlM9vGXDNaqE+WJmF5wYrcJI=;
        b=q/x/Eck38inA3dzVvKWME1cGYAZ0U/T0PC+YAhuU0nQxPPsMqj68OzSSb/+XPsuezZ
         ilZLAgQfCiULJdby+bMEje8PUF3hTOP9UjcH+NEFcMYdxHaU7kopqSsjGHoZQulHkRqj
         sLPsBnv6IqpFTxi4qpy7L/QiZXov2NkmBr00QtS/FhcV/74T5dyH1SEs7NMjZivhFYOT
         Nf0IxMhbUsW8cUfKVrYOg/C/4Pe4lloVrQ5VALdxPagelBcNlPJmUB5yBWiKodriPplI
         QgI2mfNTZcx+HPjRrKp8ifU68VUGa3TMJsEW9dU3oDcPphscYtFasPU19AmbtcOzXyAl
         AFqw==
X-Gm-Message-State: AOAM530QxOB6ZIs508vayONyKWPiFPgvAdywv7h0P5HEDj54shBPpRx7
        MbNzYqcAUniIL59O9s/Ktg/L/hzn1uj3zMWTMkdFJJghw4RzvkrW9/KeUFwsQkKDCSilZmxD0lL
        tkW6AhztKHW+a
X-Received: by 2002:a50:9e43:: with SMTP id z61mr8607125ede.278.1634649983164;
        Tue, 19 Oct 2021 06:26:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy62EfSYdgDeaHrlAb3736SelVSwBK7IJhVFYkdE/gexnUl7p1lCZQACzD7HUYMujU/YRH2Pg==
X-Received: by 2002:a50:9e43:: with SMTP id z61mr8607094ede.278.1634649982960;
        Tue, 19 Oct 2021 06:26:22 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id q14sm10102365eji.63.2021.10.19.06.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 06:26:22 -0700 (PDT)
Date:   Tue, 19 Oct 2021 15:26:21 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH 7/8] ftrace: Add multi direct modify interface
Message-ID: <YW7HfV9+UiuYxt7N@krava>
References: <20211008091336.33616-1-jolsa@kernel.org>
 <20211008091336.33616-8-jolsa@kernel.org>
 <20211014162819.5c85618b@gandalf.local.home>
 <YWluhdDMfkNGwlhz@krava>
 <20211015100509.78d4fb01@gandalf.local.home>
 <YWq6C69rQhUcAGe+@krava>
 <20211018221015.3f145843@gandalf.local.home>
 <YW7F8kTc3Bl8AkVx@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW7F8kTc3Bl8AkVx@krava>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 19, 2021 at 03:19:48PM +0200, Jiri Olsa wrote:
> On Mon, Oct 18, 2021 at 10:10:15PM -0400, Steven Rostedt wrote:
> > On Sat, 16 Oct 2021 13:39:55 +0200
> > Jiri Olsa <jolsa@redhat.com> wrote:
> > 
> > > On Fri, Oct 15, 2021 at 10:05:09AM -0400, Steven Rostedt wrote:
> > > > On Fri, 15 Oct 2021 14:05:25 +0200
> > > > Jiri Olsa <jolsa@redhat.com> wrote:
> > > >   
> > > > > ATM I'm bit stuck on the bpf side of this whole change, I'll test
> > > > > it with my other changes when I unstuck myself ;-)  
> > > > 
> > > > If you want, I'll apply this as a separate change on top of your patch set.
> > > > As I don't see anything wrong with your current code.
> > > > 
> > > > And when you are satisfied with this, just give me a "tested-by" and I'll
> > > > push it too.  
> > > 
> > > sounds great, thanks
> > > jirka
> > 
> > Would you want to ack/review this?
> 
> hum, do you have it in some branch already? I'm getting:
> 
> patching file kernel/trace/ftrace.c
> Hunk #1 succeeded at 5521 with fuzz 1 (offset -40 lines).
> Hunk #2 FAILED at 5576.
> Hunk #3 succeeded at 5557 (offset -44 lines).
> 1 out of 3 hunks FAILED -- saving rejects to file kernel/trace/ftrace.c.rej
> 
> 
> when trying to apply on top of my changes

I updated my ftrace/direct branch, it actually still had the previous
version.. sorry, perhaps this is the cause of fuzz

jirka

> 
> thanks,
> jirka
> 
> > 
> > -- Steve
> > 
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > Subject: [PATCH] ftrace/direct: Do not disable when switching direct callers
> > 
> > Currently to switch a set of "multi" direct trampolines from one
> > trampoline to another, a full shutdown of the current set needs to be
> > done, followed by an update to what trampoline the direct callers would
> > call, and then re-enabling the callers. This leaves a time when the
> > functions will not be calling anything, and events may be missed.
> > 
> > Instead, use a trick to allow all the functions with direct trampolines
> > attached will always call either the new or old trampoline while the
> > switch is happening. To do this, first attach a "dummy" callback via
> > ftrace to all the functions that the current direct trampoline is attached
> > to. This will cause the functions to call the "list func" instead of the
> > direct trampoline. The list function will call the direct trampoline
> > "helper" that will set the function it should call as it returns back to
> > the ftrace trampoline.
> > 
> > At this moment, the direct caller descriptor can safely update the direct
> > call trampoline. The list function will pick either the new or old
> > function (depending on the memory coherency model of the architecture).
> > 
> > Now removing the dummy function from each of the locations of the direct
> > trampoline caller, will put back the direct call, but now to the new
> > trampoline.
> > 
> > A better visual is:
> > 
> > [ Changing direct call from my_direct_1 to my_direct_2 ]
> > 
> >   <traced_func>:
> >      call my_direct_1
> > 
> >  ||||||||||||||||||||
> >  vvvvvvvvvvvvvvvvvvvv
> > 
> >   <traced_func>:
> >      call ftrace_caller
> > 
> >   <ftrace_caller>:
> >     [..]
> >     call ftrace_ops_list_func
> > 
> > 	ftrace_ops_list_func()
> > 	{
> > 		ops->func() -> direct_helper -> set rax to my_direct_1 or my_direct_2
> > 	}
> > 
> >    call rax (to either my_direct_1 or my_direct_2
> > 
> >  ||||||||||||||||||||
> >  vvvvvvvvvvvvvvvvvvvv
> > 
> >   <traced_func>:
> >      call my_direct_2
> > 
> > Link: https://lore.kernel.org/all/20211014162819.5c85618b@gandalf.local.home/
> > 
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  kernel/trace/ftrace.c | 33 ++++++++++++++++++++-------------
> >  1 file changed, 20 insertions(+), 13 deletions(-)
> > 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 30120342176e..7ad1e8ae5855 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -5561,8 +5561,12 @@ EXPORT_SYMBOL_GPL(unregister_ftrace_direct_multi);
> >   */
> >  int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
> >  {
> > -	struct ftrace_hash *hash = ops->func_hash->filter_hash;
> > +	struct ftrace_hash *hash;
> >  	struct ftrace_func_entry *entry, *iter;
> > +	static struct ftrace_ops tmp_ops = {
> > +		.func		= ftrace_stub,
> > +		.flags		= FTRACE_OPS_FL_STUB,
> > +	};
> >  	int i, size;
> >  	int err;
> >  
> > @@ -5572,21 +5576,22 @@ int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
> >  		return -EINVAL;
> >  
> >  	mutex_lock(&direct_mutex);
> > -	mutex_lock(&ftrace_lock);
> > +
> > +	/* Enable the tmp_ops to have the same functions as the direct ops */
> > +	ftrace_ops_init(&tmp_ops);
> > +	tmp_ops.func_hash = ops->func_hash;
> > +
> > +	err = register_ftrace_function(&tmp_ops);
> > +	if (err)
> > +		goto out_direct;
> >  
> >  	/*
> > -	 * Shutdown the ops, change 'direct' pointer for each
> > -	 * ops entry in direct_functions hash and startup the
> > -	 * ops back again.
> > -	 *
> > -	 * Note there is no callback called for @ops object after
> > -	 * this ftrace_shutdown call until ftrace_startup is called
> > -	 * later on.
> > +	 * Now the ftrace_ops_list_func() is called to do the direct callers.
> > +	 * We can safely change the direct functions attached to each entry.
> >  	 */
> > -	err = ftrace_shutdown(ops, 0);
> > -	if (err)
> > -		goto out_unlock;
> > +	mutex_lock(&ftrace_lock);
> >  
> > +	hash = ops->func_hash->filter_hash;
> >  	size = 1 << hash->size_bits;
> >  	for (i = 0; i < size; i++) {
> >  		hlist_for_each_entry(iter, &hash->buckets[i], hlist) {
> > @@ -5597,10 +5602,12 @@ int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
> >  		}
> >  	}
> >  
> > -	err = ftrace_startup(ops, 0);
> > +	/* Removing the tmp_ops will add the updated direct callers to the functions */
> > +	unregister_ftrace_function(&tmp_ops);
> >  
> >   out_unlock:
> >  	mutex_unlock(&ftrace_lock);
> > + out_direct:
> >  	mutex_unlock(&direct_mutex);
> >  	return err;
> >  }
> > -- 
> > 2.31.1
> > 

