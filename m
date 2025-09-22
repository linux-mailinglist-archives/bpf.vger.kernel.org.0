Return-Path: <bpf+bounces-69214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E68B916E9
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 15:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C85AD18974B4
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 13:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B516430CDA6;
	Mon, 22 Sep 2025 13:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwT8Ol8B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EA2283FE9
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 13:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758548300; cv=none; b=CSOsjo/ZdHRyfiVwbB6UrQlnn2WVSn27RiOMIRcMMZX5yiOYhZWqQ+6KFvNXp4WwHIheCjgELjwykuSLIiGrh7/Wu4AFeAdAWQTt63sX75jxpMVXrGn1YCBAzC/Wi6Ln/9yn13CQw80h7jK1mJEds4zXONhLSt1DTjW7ZaPmjCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758548300; c=relaxed/simple;
	bh=oH4AoBve0xbicZociklSp6XKp0C3amTsaF8P8uMO+V8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+dwcBTFG2DXlqpYPHkXm9VqARX/SFXy8rfFds0TjlaENsFnmSb6YmuXFAtoIzmvRPAYe8Axyv9u6e29KFMDPYyJ00vFpE0t7iU1uGhlo2hj/x0nLRhDldnFIXtO2ahXFRff9xwZAFqlpFvC6wadMce7AWZUzI8L4P/ny/XZbgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwT8Ol8B; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ee1381b835so2901643f8f.1
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 06:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758548297; x=1759153097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pjtr/WBwKkdc0dNJq3VYkWPcGQdd+yuTUcmaT9L1px0=;
        b=FwT8Ol8BPEMqAE9zksNEIHsbaa9dq8/OszNXWV3OjA5edSdeTM6sLS6f97RAKovNVX
         vn3vYkXiOSxVlbk8JLgLrkHRmH0pxtcOcHSy8gjRIBMNyR9494hT4vCWmV7vf9TPrMA0
         CCkDP5g1H1GIMx3daUjoOEwzUdny/MEE0Od6ReAd82M4sBzp50bAuaPX25KCLUNXwnus
         IcxQXM2Ov/i0UbwzrTyyYRqKATqT6n1JLoWB7ifTlXjxXe4cWP+OUo2Xb3F/jFhcJlik
         5QKcbZ6DY6L2MUbAhtN5n7OoWGGrGrF6aguRQcjlnt4VcGakTBUwaI3tQLnVq21M5iKN
         0G4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758548297; x=1759153097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pjtr/WBwKkdc0dNJq3VYkWPcGQdd+yuTUcmaT9L1px0=;
        b=ntnkJzA+gCEhnNpvoj1zcbxhB6oAtf5tpod/e1/FqlOl+z7Mjh92eomaG3pzJGNGyq
         It9UghFWSQsffMKb3Hp/zntQG4reG8IydK+x4y1uW5n1YIM4ysX+eW6iv1ybMUpRY0vF
         Nr7FL9BAFg7BlDccd+L/FGE6GvF8tcHDHYvTJbWa8+uWrWe/UhqFToaw3cAdb1YtmR1S
         OVMcC5FDm6OiBDKZnN4mQVN1m9jjba0HdtJLz4Zo9gdVnKBpbe12egkc3bWQk2Syg6kj
         snRgePWpHibmFr6xbkXr+zf32P0HYfBjhNH1dW5LdSUn+Ew+QLx9BMaLn7YtynFLsOE4
         x9TQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCmfW2QPuZbUFdiBn93j23GqDzOI+f2FTaBoECSJQeVLeb4T3mApGFtMAmiPj/odrEOuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvAwmuDGMudfQMHe7sugqCu6UCOlfgQzMQHLwnMDOP2NBC9I0w
	KW31HLkDKwgPWt/C/Bfq99zxoJamr55AWDjiUhVT618QXObXckTI/G0u
X-Gm-Gg: ASbGncvp1V3/KMoJhBIXuafekA6envMgGLcdFSjNA/VXwJLQ/SU13XhDoeBSMDFExel
	8f3IyBlsGd5MXLvW6EhJtGl0e/LZ0BrK8bOGqnk/+D1wRQgMOIdiovx9t7gcQsUk3KfLT2yKOJL
	aXiVFCIB16N35W8J+ONCeAhanyb/z9I/BdYiFN0Q+T1BFwJv/T/9Isg0TXKXuhHfwaJz1QFMkK2
	9o63URqVjEBUkT/x52rtAPPJZATUQorPo+8yMiUnySCS9ULyxwvgvB6K117i29JLYuVTI7PXwB0
	tuxYpIA0W4tIZoYKrhDP89KZQPbjx3GCeg5NBn0HWVB68XuXrslQ6Tt92sEr+VmpSt5+78BWh/Q
	zZH2TqtR886RXc4YSqxmNrQ==
X-Google-Smtp-Source: AGHT+IFb8QVE1JPoVN1bc6+jCc1wg3npty3iJ1lDuKaGOl7ScBmdTGUwgEUhvmpVwnZrFYD9+VLSQA==
X-Received: by 2002:a5d:5d03:0:b0:3ec:4e41:fd86 with SMTP id ffacd0b85a97d-3ee86d6cf94mr10071515f8f.50.1758548296402;
        Mon, 22 Sep 2025 06:38:16 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613dccb5e2sm241428795e9.17.2025.09.22.06.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 06:38:15 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 22 Sep 2025 15:38:13 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <aNFRRa3m6Qm8zzQu@krava>
References: <20250918120939.1706585-1-dongml2@chinatelecom.cn>
 <175828305637.117978.4183947592750468265.stgit@devnote2>
 <20250919112746.09fa02c7@gandalf.local.home>
 <aM5bizfTTTAH5Xoa@krava>
 <20250922151655.1792fa0abc6c3a8d98d052c9@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922151655.1792fa0abc6c3a8d98d052c9@kernel.org>

On Mon, Sep 22, 2025 at 03:16:55PM +0900, Masami Hiramatsu wrote:
> On Sat, 20 Sep 2025 09:45:15 +0200
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > On Fri, Sep 19, 2025 at 11:27:46AM -0400, Steven Rostedt wrote:
> > > On Fri, 19 Sep 2025 20:57:36 +0900
> > > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> > > 
> > > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > 
> > > > function_graph_enter_regs() prevents itself from recursion by
> > > > ftrace_test_recursion_trylock(), but __ftrace_return_to_handler(),
> > > > which is called at the exit, does not prevent such recursion.
> > > > Therefore, while it can prevent recursive calls from
> > > > fgraph_ops::entryfunc(), it is not able to prevent recursive calls
> > > > to fgraph from fgraph_ops::retfunc(), resulting in a recursive loop.
> > > > This can lead an unexpected recursion bug reported by Menglong.
> > > > 
> > > >  is_endbr() is called in __ftrace_return_to_handler -> fprobe_return
> > > >   -> kprobe_multi_link_exit_handler -> is_endbr.  
> > > 
> > > So basically its if the handler for the return part calls something that it
> > > is tracing, it can trigger the recursion?
> > > 
> > > > 
> > > > To fix this issue, acquire ftrace_test_recursion_trylock() in the
> > > > __ftrace_return_to_handler() after unwind the shadow stack to mark
> > > > this section must prevent recursive call of fgraph inside user-defined
> > > > fgraph_ops::retfunc().
> > > > 
> > > > This is essentially a fix to commit 4346ba160409 ("fprobe: Rewrite
> > > > fprobe on function-graph tracer"), because before that fgraph was
> > > > only used from the function graph tracer. Fprobe allowed user to run
> > > > any callbacks from fgraph after that commit.
> > > 
> > > I would actually say it's because before this commit, the return handler
> > > callers never called anything that the entry handlers didn't already call.
> > > If there was recursion, the entry handler would catch it (and the entry
> > > tells fgraph if the exit handler should be called).
> > > 
> > > The difference here is with fprobes, you can have the exit handler calling
> > > functions that the entry handler does not, which exposes more cases where
> > > recursion could happen.
> > 
> > so IIUC we have return kprobe multi probe on is_endbr and now we do:
> > 	
> > 	is_endbr()
> > 	{ -> function_graph_enter_regs installs return probe
> > 	  ...
> > 	} -> __ftrace_return_to_handler
> > 	       fprobe_return
> > 	         kprobe_multi_link_exit_handler
> > 	           is_endbr
> > 		   { -> function_graph_enter_regs installs return probe
> > 		     ...
> > 		   } -> __ftrace_return_to_handler
> > 		          fprobe_return
> > 		            kprobe_multi_link_exit_handler
> > 			      is_endbr
> > 			      { -> function_graph_enter_regs installs return probe
> > 			        ...
> > 			      } -> __ftrace_return_to_handler
> > 			           ... recursion
> > 
> > 
> > with the fix:
> > 
> > 	is_endbr()
> > 	{ -> function_graph_enter_regs installs return probe
> > 	  ...
> > 	} -> __ftrace_return_to_handler
> > 	       fprobe_return
> > 	         kprobe_multi_link_exit_handler
> > 	           ...
> > 	           is_endbr
> > 		   { ->  function_graph_enter_regs
> > 		           ftrace_test_recursion_trylock fails and we do NOT install return probe
> >                      ...
> > 		   }
> > 
> > 
> > there's is_endbr call also in kprobe_multi_link_handler, but it won't
> > trigger recursion, because function_graph_enter_regs already uses
> > ftrace_test_recursion_trylock 
> > 
> > 
> > if above is correct then the fix looks good to me
> > 
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> Hi Jiri,
> 
> I found ftrace_test_recursion_trylock() allows one nest level, can you
> make sure it is OK?

hum, I recall being surprised by that already in the past,
I thought we fixed that somehow, will check later today

thanks,
jirka

> 
> Thank you,
> 
> > 
> > thanks,
> > jirka
> > 
> > 
> > > 
> > > > 
> > > > Reported-by: Menglong Dong <menglong8.dong@gmail.com>
> > > > Closes: https://lore.kernel.org/all/20250918120939.1706585-1-dongml2@chinatelecom.cn/
> > > > Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > ---
> > > >  kernel/trace/fgraph.c |   12 ++++++++++++
> > > >  1 file changed, 12 insertions(+)
> > > > 
> > > > diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> > > > index 1e3b32b1e82c..08dde420635b 100644
> > > > --- a/kernel/trace/fgraph.c
> > > > +++ b/kernel/trace/fgraph.c
> > > > @@ -815,6 +815,7 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
> > > >  	unsigned long bitmap;
> > > >  	unsigned long ret;
> > > >  	int offset;
> > > > +	int bit;
> > > >  	int i;
> > > >  
> > > >  	ret_stack = ftrace_pop_return_trace(&trace, &ret, frame_pointer, &offset);
> > > > @@ -829,6 +830,15 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
> > > >  	if (fregs)
> > > >  		ftrace_regs_set_instruction_pointer(fregs, ret);
> > > >  
> > > > +	bit = ftrace_test_recursion_trylock(trace.func, ret);
> > > > +	/*
> > > > +	 * This must be succeeded because the entry handler returns before
> > > > +	 * modifying the return address if it is nested. Anyway, we need to
> > > > +	 * avoid calling user callbacks if it is nested.
> > > > +	 */
> > > > +	if (WARN_ON_ONCE(bit < 0))
> > > 
> > > I'm not so sure we need the warn on here. We should probably hook it to the
> > > recursion detection infrastructure that the function tracer has.
> > > 
> > > The reason I would say not to have the warn on, is because we don't have a
> > > warn on for recursion happening at the entry handler. Because this now is
> > > exposed by fprobe allowing different routines to be called at exit than
> > > what is used in entry, it can easily be triggered.
> > > 
> > > -- Steve
> > > 
> > > 
> > > 
> > > > +		goto out;
> > > > +
> > > >  #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
> > > >  	trace.retval = ftrace_regs_get_return_value(fregs);
> > > >  #endif
> > > > @@ -852,6 +862,8 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
> > > >  		}
> > > >  	}
> > > >  
> > > > +	ftrace_test_recursion_unlock(bit);
> > > > +out:
> > > >  	/*
> > > >  	 * The ftrace_graph_return() may still access the current
> > > >  	 * ret_stack structure, we need to make sure the update of
> > > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

