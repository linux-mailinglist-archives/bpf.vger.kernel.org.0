Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A7742F02A
	for <lists+bpf@lfdr.de>; Fri, 15 Oct 2021 14:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238635AbhJOMHh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Oct 2021 08:07:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20848 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238617AbhJOMHg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 15 Oct 2021 08:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634299530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JvoH5oMSp2BXCD8LbAzv1uYST/vLBcsCP136QtwFNwM=;
        b=PanOJQeOja2mHxSxrPSR7QAXUJTV8UgSiLOa83uNxsLMXst84iTk0DT55n+Q3x4q5BjXRA
        DPlGLGJ9o36E2a3K2l8yECOsQb6hEyZZ1nCLw772g9pp1qKU9pP8DZNzQF8RANd6WGNdm1
        kATi6OkmWSR5yaSww1Ve2sDLKDQ6HU8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-X21YDV-3O6eUBUf4SM3YIg-1; Fri, 15 Oct 2021 08:05:29 -0400
X-MC-Unique: X21YDV-3O6eUBUf4SM3YIg-1
Received: by mail-wr1-f71.google.com with SMTP id v15-20020adfa1cf000000b00160940b17a2so5835437wrv.19
        for <bpf@vger.kernel.org>; Fri, 15 Oct 2021 05:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JvoH5oMSp2BXCD8LbAzv1uYST/vLBcsCP136QtwFNwM=;
        b=jWR6Vms2mk6xCkfLuT5sRJt5lCMHH0AI/vDXW/Sg32olsUJe0VNp9CS/QffAhWYJtL
         +T2L3/FF/+IODKBKrxiFsgHhFReSJkBDoed+HJnTn5VThYWzhDC25xmTpZT8phJ3G3wT
         0FvxjTFaIvorvafpgsxmVIQcwqikqKQVLWTqUCR1rH6Fzr7kTtirK4oeoTE2BHWpvmIa
         CZcokta7+wxYSJGFBojlMDNbRotsMHwpUhshgik32NDlvkm0Vav0Pg2LvfiCgQ0Z0y7p
         jb+QsbHcm6aruG+tP3umM9anJ2Tr5cT4qyphbIEvx9PAnuU1SVyBYVNV9iDZE9f7hPeZ
         5wCQ==
X-Gm-Message-State: AOAM530heHMzGYwgo5VXhowCPa8FWOeq5YIIYPcoOOJkt2CW6L7MR+pn
        Sw1fcRHTfda9PsrHymrpdq7ZbdlmXf5JQW1j1oMihPJaaF+nxksexiY4GRAH3tUeutMrqO/9PLn
        UvnhCyOjNjddR
X-Received: by 2002:a1c:a558:: with SMTP id o85mr12304154wme.110.1634299527661;
        Fri, 15 Oct 2021 05:05:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPw+HEJn+F00fk/SX9viUW+5VgyF3kV0jrtkEF8y8/rC2NWO+DXscmzJBN5cRnME77odizdw==
X-Received: by 2002:a1c:a558:: with SMTP id o85mr12304122wme.110.1634299527418;
        Fri, 15 Oct 2021 05:05:27 -0700 (PDT)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id r9sm4560020wrn.95.2021.10.15.05.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 05:05:26 -0700 (PDT)
Date:   Fri, 15 Oct 2021 14:05:25 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH 7/8] ftrace: Add multi direct modify interface
Message-ID: <YWluhdDMfkNGwlhz@krava>
References: <20211008091336.33616-1-jolsa@kernel.org>
 <20211008091336.33616-8-jolsa@kernel.org>
 <20211014162819.5c85618b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014162819.5c85618b@gandalf.local.home>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 14, 2021 at 04:28:19PM -0400, Steven Rostedt wrote:
> On Fri,  8 Oct 2021 11:13:35 +0200
> Jiri Olsa <jolsa@redhat.com> wrote:
> 
> > +	/*
> > +	 * Shutdown the ops, change 'direct' pointer for each
> > +	 * ops entry in direct_functions hash and startup the
> > +	 * ops back again.
> > +	 *
> > +	 * Note there is no callback called for @ops object after
> > +	 * this ftrace_shutdown call until ftrace_startup is called
> > +	 * later on.
> > +	 */
> > +	err = ftrace_shutdown(ops, 0);
> > +	if (err)
> > +		goto out_unlock;
> 
> I believe I said before that we can do this by adding a stub ops that match
> all the functions with the direct ops being modified. This will cause the
> loop function to be called, which will call the direct function helper,
> which will then call the direct function that is found. That is, there is
> no "pause" in calling the direct callers. Either the old direct is called,
> or the new one. When the function returns, all are calling the new one.
> 
> That is, instead of:
> 
> [ Changing direct call from my_direct_1 to my_direct_2 ]
> 
>   <traced_func>:
>      call my_direct_1
> 
>  ||||||||||||||||||||
>  vvvvvvvvvvvvvvvvvvvv
> 
>   <traced_func>:
>      nop
> 
>  ||||||||||||||||||||
>  vvvvvvvvvvvvvvvvvvvv
> 
>   <traced_func>:
>      call my_direct_2
> 
> 
> We have it do:
> 
>   <traced_func>:
>      call my_direct_1
> 
>  ||||||||||||||||||||
>  vvvvvvvvvvvvvvvvvvvv
> 
>   <traced_func>:
>      call ftrace_caller
> 
> 
>   <ftrace_caller>:
>     [..]
>     call ftrace_ops_list_func
> 
> 
> ftrace_ops_list_func()
> {
> 	ops->func() -> direct_helper -> set rax to my_direct_1 or my_direct_2
> }
> 
>    call rax (to either my_direct_1 or my_direct_2

nice! :) I did not see that as a problem and something that can be
done later, thanks for doing this

> 
>  ||||||||||||||||||||
>  vvvvvvvvvvvvvvvvvvvv
> 
>   <traced_func>:
>      call my_direct_2
> 
> 
> I did this on top of this patch:

ATM I'm bit stuck on the bpf side of this whole change, I'll test
it with my other changes when I unstuck myself ;-)

thanks,
jirka

> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/trace/ftrace.c | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 30120342176e..7ad1e8ae5855 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5561,8 +5561,12 @@ EXPORT_SYMBOL_GPL(unregister_ftrace_direct_multi);
>   */
>  int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
>  {
> -	struct ftrace_hash *hash = ops->func_hash->filter_hash;
> +	struct ftrace_hash *hash;
>  	struct ftrace_func_entry *entry, *iter;
> +	static struct ftrace_ops tmp_ops = {
> +		.func		= ftrace_stub,
> +		.flags		= FTRACE_OPS_FL_STUB,
> +	};
>  	int i, size;
>  	int err;
>  
> @@ -5572,21 +5576,22 @@ int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
>  		return -EINVAL;
>  
>  	mutex_lock(&direct_mutex);
> -	mutex_lock(&ftrace_lock);
> +
> +	/* Enable the tmp_ops to have the same functions as the direct ops */
> +	ftrace_ops_init(&tmp_ops);
> +	tmp_ops.func_hash = ops->func_hash;
> +
> +	err = register_ftrace_function(&tmp_ops);
> +	if (err)
> +		goto out_direct;
>  
>  	/*
> -	 * Shutdown the ops, change 'direct' pointer for each
> -	 * ops entry in direct_functions hash and startup the
> -	 * ops back again.
> -	 *
> -	 * Note there is no callback called for @ops object after
> -	 * this ftrace_shutdown call until ftrace_startup is called
> -	 * later on.
> +	 * Now the ftrace_ops_list_func() is called to do the direct callers.
> +	 * We can safely change the direct functions attached to each entry.
>  	 */
> -	err = ftrace_shutdown(ops, 0);
> -	if (err)
> -		goto out_unlock;
> +	mutex_lock(&ftrace_lock);
>  
> +	hash = ops->func_hash->filter_hash;
>  	size = 1 << hash->size_bits;
>  	for (i = 0; i < size; i++) {
>  		hlist_for_each_entry(iter, &hash->buckets[i], hlist) {
> @@ -5597,10 +5602,12 @@ int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
>  		}
>  	}
>  
> -	err = ftrace_startup(ops, 0);
> +	/* Removing the tmp_ops will add the updated direct callers to the functions */
> +	unregister_ftrace_function(&tmp_ops);
>  
>   out_unlock:
>  	mutex_unlock(&ftrace_lock);
> + out_direct:
>  	mutex_unlock(&direct_mutex);
>  	return err;
>  }
> -- 
> 2.31.1
> 

