Return-Path: <bpf+bounces-69091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E6FB8C19A
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 09:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F41101C04559
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 07:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4161F279DA0;
	Sat, 20 Sep 2025 07:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4Crv/zo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEAF23815D
	for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 07:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758354327; cv=none; b=Z9m/WTa0CAHI0C+r1OygX4VydpB9IdFPqSguj1P3uvgNpkOBC6P9uX+J76uSlkwzYdit8XJD33ztOHEEfn7y3kn1gh2jt/onLJcRTfoin/CfD4oRXAzuWz4hTPYvSCPkCMSEe0+bxZX5ccU/ik7gohJ2XKLmPEPRF9uouZqOBUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758354327; c=relaxed/simple;
	bh=Lv9wHEJ/fxWrhstESXT8f2LQA4CfTBm7lTCR263JdrY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIB5ppX7B4yrcG0Fc7lby4Xi1qVhOMDGc8mwbds5boOd6KkD9bA/ICOWdqqtHCGc/mw9abq/6M6ASvJqnwqA9q3UG4Ud5rJOQSQi/AZUkfcElH9jXECAFmYDW1mza1npxA7L8t621WzgvfkJl6/RcRH7lVjHRFEUBsaexWW0gns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4Crv/zo; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-62fbc90e6f6so3017823a12.3
        for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 00:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758354324; x=1758959124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TIdlMRLTml2jFvq4pcXTja/ONkufrm1A8R2kOgYdzPA=;
        b=l4Crv/zo3tmBd7YBdfT+kMA0FN3zsm2EfXZ1RdRqVjoOlfV4u6/AW/aaiQT9RUsUNm
         s5+oNIjU+aEhVonrVYy329dgoD5S8q6MneKbqNFociHony2PVn4NqkV3qJL/oIPfUisr
         eJC1PmYmkhrZd5UpHMSuHb6+BI9ygGXme+Ny4NE8hYLOGJglY49VHR5FooY6EIdp+e9K
         R7AQByFLIlZi6nhuH5RwAmHKlAexQi8nWbGjm7xB3v7JHL/2/A4azwii0pn4oTi7Sn1a
         VWNT4ErWr49Xpx9wO6uz+lIq+u9KA606gtHPymYGy1ZtC+gIwxx/fw1SiL3vjLTog6gf
         gmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758354324; x=1758959124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TIdlMRLTml2jFvq4pcXTja/ONkufrm1A8R2kOgYdzPA=;
        b=BQNGvUlh7x8lxrJzFcq+LpI5c2qWq1JkDceubSMClowVxSISiQ8rHguwUWu5gJa4Kl
         U3uPX91L0+Jk4oKMj3D1kg/GxDc+Rl44SHy07DoUF+cYQWuUYRsC2qX+5sWs/cMQX+f8
         DOvRHxhZM/f3Px8FiOTN+Gz9ISv7B1uaeJV2A+g3YlBnuUfW9ECSvcjl+Ry3JPbcHUxz
         roYB3+5M7mjPvkhdxTVviRoeUsr8/Kb9qWx8XHNKctOvpSAKAsNBAOIwk26ryW5tRCwZ
         Q7S0i81a6YM/l3A6qDCbGmtGXxZnm10MQ55RmYkUNIEszkjxvaQxTAD8aobcQOIDgEh9
         sNSw==
X-Forwarded-Encrypted: i=1; AJvYcCWUZhLfP4cjQ7q35PyBujzHxrYtEVuP2/vdDgsteVx1LhTyKTMLe+AnoPlxoPZ8RPdbIbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR/HxR4BNwoNyJtNjsh6Ne115bFP0X//gzkFMPzIi9z2Aob8q5
	Cxxxj7nHmtxSr+YOcNi3kGgx2x3VYpbRKvP165D+q65uSh1RJXnqBAZJ
X-Gm-Gg: ASbGnctBmnUG/ahiSh5iHadeqAy8cad6MP9Bsi5vdII3g94PlyWmOaqr64pN5mCQODq
	K10ayG98iCd2uOJ9CuM2nTYuU1n85Iw2zQGzwMIdeqxPl6nHBna4xDfg8V3t2qPC+Q/n3qtMaMn
	SRu0sUvo/+83N4shJ/0LAST/1nH1zp3pAOLSUTKcXJzjMYVCV44ieQzSwcKzaUHm/0H1GPHLAtm
	v909iRuEvYmJ5X07NlEu//onpsIY2uzBihqcCqcNQV9XYDdnF/iAZXJfBONn1S1O61sOj87FunF
	ZI2sXztQFU2qUMi7AUtDvTITwggdUJ8ClMxY8dyQ/70OYxLDR2coZLVCqjbhsPvfsks380iVt0p
	YSHQdmjYQ/eJ7hUnM++Za0SJdVq2qp57g
X-Google-Smtp-Source: AGHT+IG+vDlmU5rgv0NU5tvQk47IQX8wVba4nh/X26jsh02xW8qYA4gtZEIhAzLEBfWC/+5q6/qChQ==
X-Received: by 2002:a17:907:3e84:b0:b04:ba4:8610 with SMTP id a640c23a62f3a-b24f602b9ecmr674072666b.62.1758354324005;
        Sat, 20 Sep 2025 00:45:24 -0700 (PDT)
Received: from krava (37-188-197-68.red.o2.cz. [37.188.197.68])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc5f4386esm606840966b.15.2025.09.20.00.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 00:45:23 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 20 Sep 2025 09:45:15 +0200
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, kees@kernel.org,
	samitolvanen@google.com, rppt@kernel.org, luto@kernel.org,
	ast@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] tracing: fgraph: Protect return handler from recursion
 loop
Message-ID: <aM5bizfTTTAH5Xoa@krava>
References: <20250918120939.1706585-1-dongml2@chinatelecom.cn>
 <175828305637.117978.4183947592750468265.stgit@devnote2>
 <20250919112746.09fa02c7@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919112746.09fa02c7@gandalf.local.home>

On Fri, Sep 19, 2025 at 11:27:46AM -0400, Steven Rostedt wrote:
> On Fri, 19 Sep 2025 20:57:36 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > function_graph_enter_regs() prevents itself from recursion by
> > ftrace_test_recursion_trylock(), but __ftrace_return_to_handler(),
> > which is called at the exit, does not prevent such recursion.
> > Therefore, while it can prevent recursive calls from
> > fgraph_ops::entryfunc(), it is not able to prevent recursive calls
> > to fgraph from fgraph_ops::retfunc(), resulting in a recursive loop.
> > This can lead an unexpected recursion bug reported by Menglong.
> > 
> >  is_endbr() is called in __ftrace_return_to_handler -> fprobe_return
> >   -> kprobe_multi_link_exit_handler -> is_endbr.  
> 
> So basically its if the handler for the return part calls something that it
> is tracing, it can trigger the recursion?
> 
> > 
> > To fix this issue, acquire ftrace_test_recursion_trylock() in the
> > __ftrace_return_to_handler() after unwind the shadow stack to mark
> > this section must prevent recursive call of fgraph inside user-defined
> > fgraph_ops::retfunc().
> > 
> > This is essentially a fix to commit 4346ba160409 ("fprobe: Rewrite
> > fprobe on function-graph tracer"), because before that fgraph was
> > only used from the function graph tracer. Fprobe allowed user to run
> > any callbacks from fgraph after that commit.
> 
> I would actually say it's because before this commit, the return handler
> callers never called anything that the entry handlers didn't already call.
> If there was recursion, the entry handler would catch it (and the entry
> tells fgraph if the exit handler should be called).
> 
> The difference here is with fprobes, you can have the exit handler calling
> functions that the entry handler does not, which exposes more cases where
> recursion could happen.

so IIUC we have return kprobe multi probe on is_endbr and now we do:
	
	is_endbr()
	{ -> function_graph_enter_regs installs return probe
	  ...
	} -> __ftrace_return_to_handler
	       fprobe_return
	         kprobe_multi_link_exit_handler
	           is_endbr
		   { -> function_graph_enter_regs installs return probe
		     ...
		   } -> __ftrace_return_to_handler
		          fprobe_return
		            kprobe_multi_link_exit_handler
			      is_endbr
			      { -> function_graph_enter_regs installs return probe
			        ...
			      } -> __ftrace_return_to_handler
			           ... recursion


with the fix:

	is_endbr()
	{ -> function_graph_enter_regs installs return probe
	  ...
	} -> __ftrace_return_to_handler
	       fprobe_return
	         kprobe_multi_link_exit_handler
	           ...
	           is_endbr
		   { ->  function_graph_enter_regs
		           ftrace_test_recursion_trylock fails and we do NOT install return probe
                     ...
		   }


there's is_endbr call also in kprobe_multi_link_handler, but it won't
trigger recursion, because function_graph_enter_regs already uses
ftrace_test_recursion_trylock 


if above is correct then the fix looks good to me

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> 
> > 
> > Reported-by: Menglong Dong <menglong8.dong@gmail.com>
> > Closes: https://lore.kernel.org/all/20250918120939.1706585-1-dongml2@chinatelecom.cn/
> > Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/fgraph.c |   12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> > index 1e3b32b1e82c..08dde420635b 100644
> > --- a/kernel/trace/fgraph.c
> > +++ b/kernel/trace/fgraph.c
> > @@ -815,6 +815,7 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
> >  	unsigned long bitmap;
> >  	unsigned long ret;
> >  	int offset;
> > +	int bit;
> >  	int i;
> >  
> >  	ret_stack = ftrace_pop_return_trace(&trace, &ret, frame_pointer, &offset);
> > @@ -829,6 +830,15 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
> >  	if (fregs)
> >  		ftrace_regs_set_instruction_pointer(fregs, ret);
> >  
> > +	bit = ftrace_test_recursion_trylock(trace.func, ret);
> > +	/*
> > +	 * This must be succeeded because the entry handler returns before
> > +	 * modifying the return address if it is nested. Anyway, we need to
> > +	 * avoid calling user callbacks if it is nested.
> > +	 */
> > +	if (WARN_ON_ONCE(bit < 0))
> 
> I'm not so sure we need the warn on here. We should probably hook it to the
> recursion detection infrastructure that the function tracer has.
> 
> The reason I would say not to have the warn on, is because we don't have a
> warn on for recursion happening at the entry handler. Because this now is
> exposed by fprobe allowing different routines to be called at exit than
> what is used in entry, it can easily be triggered.
> 
> -- Steve
> 
> 
> 
> > +		goto out;
> > +
> >  #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
> >  	trace.retval = ftrace_regs_get_return_value(fregs);
> >  #endif
> > @@ -852,6 +862,8 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
> >  		}
> >  	}
> >  
> > +	ftrace_test_recursion_unlock(bit);
> > +out:
> >  	/*
> >  	 * The ftrace_graph_return() may still access the current
> >  	 * ret_stack structure, we need to make sure the update of
> 

