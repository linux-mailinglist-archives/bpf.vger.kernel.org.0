Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA56B40EB02
	for <lists+bpf@lfdr.de>; Thu, 16 Sep 2021 21:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbhIPTqr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Sep 2021 15:46:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48020 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232467AbhIPTqq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Sep 2021 15:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631821525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8EIXj1eTdFllKG2x0MKyDoudkx15dHgU5ERjZMzPtZk=;
        b=De+tDiYE69H3NvgFmpiesAjHpToxiu22omXMpsO7/jcGh4AJdhW4TpjbaKYaN/EBRMvpqa
        6W2VYgEZ1qFPCMEbMI5/edJS0M23YRfSVr5P54y/dNumGXBhvl298zYedrcNlVT3XWcNnQ
        CkQVJNTbPzBPfoSYKQY5DqgjQQ4aP24=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-bvwQQoDgMD-iTgXFNdCsCA-1; Thu, 16 Sep 2021 15:45:24 -0400
X-MC-Unique: bvwQQoDgMD-iTgXFNdCsCA-1
Received: by mail-wr1-f71.google.com with SMTP id r5-20020adfb1c5000000b0015cddb7216fso2841511wra.3
        for <bpf@vger.kernel.org>; Thu, 16 Sep 2021 12:45:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8EIXj1eTdFllKG2x0MKyDoudkx15dHgU5ERjZMzPtZk=;
        b=PVhsou+nP4tY7I9fnQjNsDfGypnux2myJa/IEBltGPqKAIArP8cOBuP/gFA91fEmZm
         79XYKt2/c3l0NP7vHJg3GxW9GoAb/2g4na87VQzfOJnX2UJqBSbVPX5x4oV+MB3v/JYd
         Xpk8Ty9LbfgWeqp1G/cx7N/tHV00J+7xEokl2SEVOD8p5XGGFdTf3AmiSsqA0diwMdgZ
         /AIVFU36uBnWtTvAXJ3oWTJ+LPoTlssS3+RzDFn5wBIVU/JWXg8FPFgMDyuApZFUqDVU
         a6iZzBWmMbF1noiHJzSCMLliTCVBXs2D36KDUKnurZEzKtycgD4f4PwUN4dGHvH/dwpg
         cTKw==
X-Gm-Message-State: AOAM533YKphU7/dbln5kTBBGpYUfCz0pXlylYFuOZVVtpb6CNSrpX8Jf
        t0cnYt/lp7VruNc3yMKKLBLCWRAFMRzxVVd3jXxSvfyDLl7RMyY/8rilVD91IDwEeEGRyE+s2eE
        DUsjcWwoaUEte
X-Received: by 2002:a05:6000:46:: with SMTP id k6mr8058625wrx.104.1631821522776;
        Thu, 16 Sep 2021 12:45:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnLJMUGMm7CW5qCBSs4rHGG2l/xsXrV2lGc9VELDH3HdkmfPm05RNHVGdfGH+zYIHqpHHkkg==
X-Received: by 2002:a05:6000:46:: with SMTP id k6mr8058610wrx.104.1631821522513;
        Thu, 16 Sep 2021 12:45:22 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id g9sm9062070wmg.21.2021.09.16.12.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 12:45:22 -0700 (PDT)
Date:   Thu, 16 Sep 2021 21:45:20 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH 6/8] ftrace: Add multi direct register/unregister
 interface
Message-ID: <YUOe0Pl8Rmu4lU4X@krava>
References: <20210831095017.412311-1-jolsa@kernel.org>
 <20210831095017.412311-7-jolsa@kernel.org>
 <20210914173555.056cd20c@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914173555.056cd20c@oasis.local.home>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 14, 2021 at 05:35:55PM -0400, Steven Rostedt wrote:
> On Tue, 31 Aug 2021 11:50:15 +0200
> Jiri Olsa <jolsa@redhat.com> wrote:
> 
> > Adding interface to register multiple direct functions
> > within single call. Adding following functions:
> > 
> >   register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
> >   unregister_ftrace_direct_multi(struct ftrace_ops *ops)
> > 
> > The register_ftrace_direct_multi registers direct function (addr)
> > with all functions in ops filter. The ops filter can be updated
> > before with ftrace_set_filter_ip calls.
> > 
> > All requested functions must not have direct function currently
> > registered, otherwise register_ftrace_direct_multi will fail.
> > 
> > The unregister_ftrace_direct_multi unregisters ops related direct
> > functions.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/ftrace.h |  11 ++++
> >  kernel/trace/ftrace.c  | 111 +++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 122 insertions(+)
> > 
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index d399621a67ee..e40b5201c16e 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -316,7 +316,10 @@ int ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
> >  				unsigned long old_addr,
> >  				unsigned long new_addr);
> >  unsigned long ftrace_find_rec_direct(unsigned long ip);
> > +int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
> > +int unregister_ftrace_direct_multi(struct ftrace_ops *ops);
> >  #else
> > +struct ftrace_ops;
> >  # define ftrace_direct_func_count 0
> >  static inline int register_ftrace_direct(unsigned long ip, unsigned long addr)
> >  {
> > @@ -346,6 +349,14 @@ static inline unsigned long ftrace_find_rec_direct(unsigned long ip)
> >  {
> >  	return 0;
> >  }
> > +static inline int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
> > +{
> > +	return -ENODEV;
> > +}
> > +static inline int unregister_ftrace_direct_multi(struct ftrace_ops *ops)
> > +{
> > +	return -ENODEV;
> > +}
> >  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
> >  
> >  #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index c60217d81040..7243769493c9 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -5407,6 +5407,117 @@ int modify_ftrace_direct(unsigned long ip,
> >  	return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(modify_ftrace_direct);
> > +
> > +#define MULTI_FLAGS (FTRACE_OPS_FL_IPMODIFY | FTRACE_OPS_FL_DIRECT | \
> > +		     FTRACE_OPS_FL_SAVE_REGS)
> > +
> > +static int check_direct_multi(struct ftrace_ops *ops)
> > +{
> > +	if (!(ops->flags & FTRACE_OPS_FL_INITIALIZED))
> > +		return -EINVAL;
> > +	if ((ops->flags & MULTI_FLAGS) != MULTI_FLAGS)
> > +		return -EINVAL;
> > +	return 0;
> > +}
> > +
> 
> Needs kernel doc comments as this is an interface outside this file.

right, will add

> 
> > +int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
> > +{
> > +	struct ftrace_hash *hash, *free_hash = NULL;
> > +	struct ftrace_func_entry *entry, *new;
> > +	int err = -EBUSY, size, i;
> > +
> > +	if (ops->func || ops->trampoline)
> > +		return -EINVAL;
> > +	if (!(ops->flags & FTRACE_OPS_FL_INITIALIZED))
> > +		return -EINVAL;
> > +	if (ops->flags & FTRACE_OPS_FL_ENABLED)
> > +		return -EINVAL;
> > +
> > +	hash = ops->func_hash->filter_hash;
> > +	if (ftrace_hash_empty(hash))
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&direct_mutex);
> > +
> > +	/* Make sure requested entries are not already registered.. */
> > +	size = 1 << hash->size_bits;
> > +	for (i = 0; i < size; i++) {
> > +		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
> > +			if (ftrace_find_rec_direct(entry->ip))
> > +				goto out_unlock;
> > +		}
> > +	}
> > +
> > +	/* ... and insert them to direct_functions hash. */
> > +	err = -ENOMEM;
> > +	for (i = 0; i < size; i++) {
> > +		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
> > +			new = ftrace_add_rec_direct(entry->ip, addr, &free_hash);
> > +			if (!new)
> > +				goto out_remove;
> > +			entry->direct = addr;
> > +		}
> > +	}
> > +
> > +	ops->func = call_direct_funcs;
> > +	ops->flags = MULTI_FLAGS;
> > +	ops->trampoline = FTRACE_REGS_ADDR;
> > +
> > +	err = register_ftrace_function(ops);
> > +
> > + out_remove:
> > +	if (err) {
> 
> The below code:
> 
> > +		for (i = 0; i < size; i++) {
> > +			hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
> > +				new = __ftrace_lookup_ip(direct_functions, entry->ip);
> > +				if (new) {
> > +					remove_hash_entry(direct_functions, new);
> > +					kfree(new);
> > +				}
> > +			}
> > +		}
> 
> is identical to code below.
> 
> > +	}
> > +
> > + out_unlock:
> > +	mutex_unlock(&direct_mutex);
> > +
> > +	if (free_hash) {
> > +		synchronize_rcu_tasks();
> > +		free_ftrace_hash(free_hash);
> > +	}
> > +	return err;
> > +}
> > +EXPORT_SYMBOL_GPL(register_ftrace_direct_multi);
> > +
> 
> Should have kernel doc as well.

ok

> 
> > +int unregister_ftrace_direct_multi(struct ftrace_ops *ops)
> > +{
> > +	struct ftrace_hash *hash = ops->func_hash->filter_hash;
> > +	struct ftrace_func_entry *entry, *new;
> > +	int err, size, i;
> > +
> > +	if (check_direct_multi(ops))
> > +		return -EINVAL;
> > +	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&direct_mutex);
> > +	err = unregister_ftrace_function(ops);
> > +
> > +	size = 1 << hash->size_bits;
> 
> 
> > +	for (i = 0; i < size; i++) {
> > +		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
> > +			new = __ftrace_lookup_ip(direct_functions, entry->ip);
> > +			if (new) {
> > +				remove_hash_entry(direct_functions, new);
> > +				kfree(new);
> > +			}
> > +		}
> > +	}
> 
> Would probably make sense to turn this into a static inline helper.

ok

thanks,
jirka

> 
> -- Steve
> 
> 
> > +
> > +	mutex_unlock(&direct_mutex);
> > +	return err;
> > +}
> > +EXPORT_SYMBOL_GPL(unregister_ftrace_direct_multi);
> >  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
> >  
> >  /**
> 

