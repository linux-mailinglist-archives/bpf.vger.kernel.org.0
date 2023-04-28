Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA14E6F0FF6
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 03:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344729AbjD1BWc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 21:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344303AbjD1BWa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 21:22:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AAB212D;
        Thu, 27 Apr 2023 18:22:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DAF461DE4;
        Fri, 28 Apr 2023 01:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9654CC433D2;
        Fri, 28 Apr 2023 01:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682644949;
        bh=XaCC5NAJmW00ZGy4LFRYDHsTuAomILBmil6dBGf4mvo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dNXwIngTdD4iZDNgfN3c43qvxxIFCrRA904hegsAfZ+yYn2b+JkdXk68VVKTlX53r
         npFYhrwGCm926XQvWBcJF2FaS9+sL05EjDN/J4w31qNiDRIAqklnGx3dq1evuz54nh
         oSM2mJDogYbDpRp2WCPZcjVMgjYBPrwvaKxebMPWw7BzJLQUpJZ+IFUbU5j9WKEAlA
         HwKalIldF9ve0bGPnIu0PraNW96XOV6NysRYw7OWac5PRJSaBnCrZSRVRDO+gGtkMR
         115mSA945fJc8d3tmYZ8qVfW8QsAcTBDpcldXg8Zggtl9uc6h3jPH4wrBFFdKkU1FP
         UJS4hXbTb7J0Q==
Date:   Fri, 28 Apr 2023 10:22:24 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v7 04/11] tracing/probes: Add tracepoint support on
 fprobe_events
Message-Id: <20230428102224.061dfbc9a925ab550cb978a8@kernel.org>
In-Reply-To: <ZEpjh8ZfZMch2Av/@krava>
References: <168255826500.2565678.17719875734305974633.stgit@mhiramat.roam.corp.google.com>
        <168255830406.2565678.710162679499561673.stgit@mhiramat.roam.corp.google.com>
        <ZEpjh8ZfZMch2Av/@krava>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 27 Apr 2023 13:59:03 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Thu, Apr 27, 2023 at 10:18:24AM +0900, Masami Hiramatsu (Google) wrote:
> 
> SNIP
> 
> >  	ret = traceprobe_parse_probe_arg(&ep->tp, i, argv[i], flags);
> > diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> > index 0049d9ef2402..7c8be8a3616f 100644
> > --- a/kernel/trace/trace_fprobe.c
> > +++ b/kernel/trace/trace_fprobe.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/module.h>
> >  #include <linux/rculist.h>
> >  #include <linux/security.h>
> > +#include <linux/tracepoint.h>
> >  #include <linux/uaccess.h>
> >  
> >  #include "trace_dynevent.h"
> > @@ -17,6 +18,7 @@
> >  #include "trace_probe_tmpl.h"
> >  
> >  #define FPROBE_EVENT_SYSTEM "fprobes"
> > +#define TRACEPOINT_EVENT_SYSTEM "tracepoints"
> 
> so the created tracepoints go under 'events/tracepoints' directory,
> should the name be more fprobe specific? like under 'events/fprobe/tracepoints' ?

No, because trace event only support single-level class directory, and
I think this can provide a more abstract interface to the user.

Thanks,

> 
> jirka
> 
> >  #define RETHOOK_MAXACTIVE_MAX 4096
> >  
> >  static int trace_fprobe_create(const char *raw_command);
> > @@ -41,6 +43,8 @@ struct trace_fprobe {
> >  	struct dyn_event	devent;
> >  	struct fprobe		fp;
> >  	const char		*symbol;
> > +	struct tracepoint	*tpoint;
> > +	struct module		*mod;
> >  	struct trace_probe	tp;
> >  };
> >  
> > @@ -68,6 +72,11 @@ static bool trace_fprobe_is_return(struct trace_fprobe *tf)
> >  	return tf->fp.exit_handler != NULL;
> >  }
> >  
> > +static bool trace_fprobe_is_tracepoint(struct trace_fprobe *tf)
> > +{
> > +	return tf->tpoint != NULL;
> > +}
> > +
> 
> SNIP


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
