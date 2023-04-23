Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E6A6EBFC8
	for <lists+bpf@lfdr.de>; Sun, 23 Apr 2023 15:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjDWNhs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Apr 2023 09:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDWNhr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Apr 2023 09:37:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC75CE4C;
        Sun, 23 Apr 2023 06:37:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FAD3615A7;
        Sun, 23 Apr 2023 13:37:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D47FC433D2;
        Sun, 23 Apr 2023 13:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682257065;
        bh=lNfqEnclLuJur3CxKKHX89bLr+bFUK+pfiFE5PZ+yb0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y2ag7jrrZt3K9gQQ4Wy7akb6i6qKkojkn0dTiIOWP8kDb7nU0urvtnH79TTvkhHSl
         aOMAORKv6qRLehUXSHH6SOTb6P+hSwdDTa7hgMdbgsyZWcJS+n9CRWpaTVYQ8HYbzF
         HmtkzLLOgWZX7Vsg/JjeTpze9YjgR9mt+QCDGf4pJAM8wpMj7AJE2UmckYxxsiCYDl
         WEmD67f6qC8EYFBnIFB5WbLBy6oBRcSJWTZ0idj/+eKpUi1vLMq7T9L+2oDHSBCnt1
         u6Ufbx0hf/7CLt2udpsj0bvBuN8WDGTFVB1GA5FmOv+Cn6/o0fDBvfC1MJCvh38LBJ
         mQ1is2Edt63wQ==
Date:   Sun, 23 Apr 2023 22:37:40 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v5 4/9] tracing/probes: Add tracepoint support on
 fprobe_event
Message-Id: <20230423223740.9f1186a08b3b316b5a0156e7@kernel.org>
In-Reply-To: <ZEThQgkJV7esVGdR@krava>
References: <168198993129.1795549.8306571027057356176.stgit@mhiramat.roam.corp.google.com>
        <168198997089.1795549.1009510263722958117.stgit@mhiramat.roam.corp.google.com>
        <ZEThQgkJV7esVGdR@krava>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 23 Apr 2023 09:41:54 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Thu, Apr 20, 2023 at 08:26:10PM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Allow fprobe_event to trace raw tracepoints so that user can trace
> > tracepoints which don't have traceevent wrappers. This new event is
> > always available if fprobe event is enabled since the tracepoint is
> > disabled, trace-event and dynamic event is also not available.
> 
> I thought of ftrace tracepoints wrappers as standard in distros,
> could you specify which config options that involves?

Ah, sorry, I'm completely confused you.

----
This new event is always available if fprobe event is enabled. If the
tracepoint is disabled, trace-event and dynamic event including
fprobe is also not available.
----

> 
> > +	if (trace_fprobe_is_tracepoint(tf)) {
> > +		struct tracepoint *tpoint = tf->tpoint;
> > +		unsigned long ip = (unsigned long)tpoint->probestub;
> > +		/*
> > +		 * Here, we do 2 steps to enable fprobe on a tracepoint.
> > +		 * At first, put __probestub_##TP function on the tracepoint
> > +		 * and put a fprobe on the stub function.
> > +		 */
> > +		ret = tracepoint_probe_register_prio_may_exist(tpoint,
> > +					tpoint->probestub, NULL, 0);
> > +		if (ret < 0)
> > +			return ret;
> > +		return register_fprobe_ips(&tf->fp, &ip, 1);
> 
> nice idea

Thanks!


> 
> jirka
> 
> > +	}
> > +
> >  	/* TODO: handle filter, nofilter or symbol list */
> >  	return register_fprobe(&tf->fp, tf->symbol, NULL);
> >  }
> > @@ -699,6 +723,12 @@ static void __unregister_trace_fprobe(struct trace_fprobe *tf)
> >  	if (trace_fprobe_is_registered(tf)) {
> >  		unregister_fprobe(&tf->fp);
> >  		memset(&tf->fp, 0, sizeof(tf->fp));
> > +		if (trace_fprobe_is_tracepoint(tf)) {
> > +			tracepoint_probe_unregister(tf->tpoint,
> > +					tf->tpoint->probestub, NULL);
> > +			tf->tpoint = NULL;
> > +			tf->mod = NULL;
> > +		}
> >  	}
> >  }
> 
> SNIP


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
