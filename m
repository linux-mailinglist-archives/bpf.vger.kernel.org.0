Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEBE61F3EF5
	for <lists+bpf@lfdr.de>; Tue,  9 Jun 2020 17:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730726AbgFIPNt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Jun 2020 11:13:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730673AbgFIPNs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Jun 2020 11:13:48 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 677EE20734;
        Tue,  9 Jun 2020 15:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591715627;
        bh=Hz3L8+5ifhOMGNZlsBtp86xHQWd1bggYuz2oDBEhF8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m28NIcISxyHiFWgd1jg3MrYOc+Hyx5Bd+OamH2cMzBvS/QQjyIErVpNVHreaQpy1T
         ijC9siPL7WmL2cI7NDs0GNTfdG4G6qrYavF4jT7YeumX9VRL+Y4pJ2B8Lte9cKyix0
         pRZx1hj8NgAyYgD2AqfqhZua01yRtmeCKIM2nDUk=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B909B40AFD; Tue,  9 Jun 2020 12:13:44 -0300 (-03)
Date:   Tue, 9 Jun 2020 12:13:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        jolsa@redhat.com, tmricht@linux.ibm.com, heiko.carstens@de.ibm.com,
        mhiramat@kernel.org, iii@linux.ibm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] perf: Fix user attribute access in kprobes
Message-ID: <20200609151344.GD24868@kernel.org>
References: <20200609081019.60234-1-sumanthk@linux.ibm.com>
 <20200609081019.60234-2-sumanthk@linux.ibm.com>
 <20200609150931.GC24868@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609150931.GC24868@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Jun 09, 2020 at 12:09:31PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Jun 09, 2020 at 10:10:18AM +0200, Sumanth Korikkar escreveu:
> > Issue:
> > perf probe -a 'do_sched_setscheduler  pid policy
> > param->sched_priority@user' did not work before.
> > 
> > Fix:
> > Make (perf probe -a 'do_sched_setscheduler  pid policy
> > param->sched_priority@user') output equivalent to ftrace
> > ('p:probe/do_sched_setscheduler _text+517384 pid=%r2:s32 policy=%r3:s32
> > sched_priority=+u0(%r4):s32' > kprobe_events)
> > 
> > Other:
> > 1. Right now, __match_glob() does not handle [u]<offset>. For now, use
> >   *u]<offset>.
> > 2. @user attribute was introduced in commit 1e032f7cfa14 ("perf-probe:
> >    Add user memory access attribute support")
> > 
> > Test:
> > 1. perf probe -a 'do_sched_setscheduler  pid policy
> >    param->sched_priority@user'
> > 
> > 2 ./perf script
> >    sched 305669 [000] 1614458.838675: perf_bpf_probe:func: (2904e508)
> >    pid=261614 policy=2 sched_priority=1
> > 
> > 3. cat /sys/kernel/debug/tracing/trace
> >    <...>-309956 [006] .... 1616098.093957: 0: prio: 1
> 
> Thanks, I'm adding this:
> 
> Fixes: 1e032f7cfa14 ("perf-probe: Add user memory access attribute support")
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> So that the stable guys pick this up eventually,
> 
> That first hunk with the strcmp() return check could have gone into a
> separate patch, but I'll process it as-is for expediency,

I also added this:

ommitter testing:

Before:

  # perf probe -a 'do_sched_setscheduler pid policy param->sched_priority@user'
  param(type:sched_param) has no member sched_priority@user.
    Error: Failed to add events.
  # pahole sched_param
  struct sched_param {
        int                        sched_priority;       /*     0     4 */

        /* size: 4, cachelines: 1, members: 1 */
        /* last cacheline: 4 bytes */
  };
  #

After:

  # perf probe -a 'do_sched_setscheduler pid policy param->sched_priority@user'
  Added new event:
    probe:do_sched_setscheduler (on do_sched_setscheduler with pid policy sched_priority=param->sched_priority)

  You can now use it in all perf tools, such as:

        perf record -e probe:do_sched_setscheduler -aR sleep 1

  # cat /sys/kernel/debug/tracing/kprobe_events
  p:probe/do_sched_setscheduler _text+1113792 pid=%di:s32 policy=%si:s32 sched_priority=+u0(%dx):s32
  #

 
> - Arnaldo
>  
> > Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> > Reviewed-by: Thomas Richter <tmricht@linux.ibm.com>
> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  tools/perf/util/probe-event.c | 7 +++++--
> >  tools/perf/util/probe-file.c  | 2 +-
> >  2 files changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> > index a08f373d3305..df713a5d1e26 100644
> > --- a/tools/perf/util/probe-event.c
> > +++ b/tools/perf/util/probe-event.c
> > @@ -1575,7 +1575,7 @@ static int parse_perf_probe_arg(char *str, struct perf_probe_arg *arg)
> >  	}
> >  
> >  	tmp = strchr(str, '@');
> > -	if (tmp && tmp != str && strcmp(tmp + 1, "user")) { /* user attr */
> > +	if (tmp && tmp != str && !strcmp(tmp + 1, "user")) { /* user attr */
> >  		if (!user_access_is_supported()) {
> >  			semantic_error("ftrace does not support user access\n");
> >  			return -EINVAL;
> > @@ -1995,7 +1995,10 @@ static int __synthesize_probe_trace_arg_ref(struct probe_trace_arg_ref *ref,
> >  		if (depth < 0)
> >  			return depth;
> >  	}
> > -	err = strbuf_addf(buf, "%+ld(", ref->offset);
> > +	if (ref->user_access)
> > +		err = strbuf_addf(buf, "%s%ld(", "+u", ref->offset);
> > +	else
> > +		err = strbuf_addf(buf, "%+ld(", ref->offset);
> >  	return (err < 0) ? err : depth;
> >  }
> >  
> > diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
> > index 8c852948513e..064b63a6a3f3 100644
> > --- a/tools/perf/util/probe-file.c
> > +++ b/tools/perf/util/probe-file.c
> > @@ -1044,7 +1044,7 @@ static struct {
> >  	DEFINE_TYPE(FTRACE_README_PROBE_TYPE_X, "*type: * x8/16/32/64,*"),
> >  	DEFINE_TYPE(FTRACE_README_KRETPROBE_OFFSET, "*place (kretprobe): *"),
> >  	DEFINE_TYPE(FTRACE_README_UPROBE_REF_CTR, "*ref_ctr_offset*"),
> > -	DEFINE_TYPE(FTRACE_README_USER_ACCESS, "*[u]<offset>*"),
> > +	DEFINE_TYPE(FTRACE_README_USER_ACCESS, "*u]<offset>*"),
> >  	DEFINE_TYPE(FTRACE_README_MULTIPROBE_EVENT, "*Create/append/*"),
> >  	DEFINE_TYPE(FTRACE_README_IMMEDIATE_VALUE, "*\\imm-value,*"),
> >  };
> > -- 
> > 2.17.1
> > 
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
