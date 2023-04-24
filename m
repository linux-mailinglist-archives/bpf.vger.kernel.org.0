Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF3B6EC741
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 09:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjDXHim (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 03:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjDXHil (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 03:38:41 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E186AE7F;
        Mon, 24 Apr 2023 00:38:39 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f1950f5628so27701625e9.3;
        Mon, 24 Apr 2023 00:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682321918; x=1684913918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fCpnNeC1GLxVO8cSBcSgQyBm7wF8gZpeuq5aHD7x5G4=;
        b=Fg4I+0EdGe2GGPzVYk2u/uA9mp7pU0Nn/8vdjJQ14QAnvPszIsHu9hC752YWdWtuBw
         /QX2ZDzmSB18gF6SzzWu7+YbPCyEMkfQ6tLmdIfyjMA4IzNRCF+VHGgb0JBmB2TNwMPv
         leP9jhGfApZBMP+gS4sMhBOh9M6/fBbJg8QzoPxcUXi259wBpZhsbAXbSURa+pQhJuxY
         S2g2KcYotyxAs/pF7grKxVRPtRD9SBtnC+TqG6fWmWdHvHs2QPm1buWMCyVHtLVTzf/Z
         0B0nxjs/3Ga0Qw0moOi7YWNy0Vb1wHbIhGHsFi3swLjssfLYBLcXodhW3yc79spXcAO+
         LjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682321918; x=1684913918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCpnNeC1GLxVO8cSBcSgQyBm7wF8gZpeuq5aHD7x5G4=;
        b=Xxz2QbRT9TbvgNi0pKJ1AQEDHcelXSEs22zTxi0S+EjjmFzUdcZ6rgDErs4dUsda1Y
         60R1RjnOBja2MhQrD7pbGkhtN9IRyMvlRSm7t2cwcNFmTAWG84duiXHCnXPippFr4/sz
         wQM7HBbvLK0oDxuZqmdzSFpBjqlB5t6PI/ze1VHfdwSNnrkc6KBLP8PZZwTL4AZuZiES
         jlgkwOFBe5R9i8aH1Hk6s5jNfNORtTeVqxVEVgYQICQsLmmE0nBebIAdnrPSEAgTooty
         Hnex/cCKxwaP3j9lcpH8QNqS8wvHOJ24kzJvk17iRk7IK2BXL2ckhH94K/DOyKVPfZ1L
         IbvA==
X-Gm-Message-State: AAQBX9egz2315vI3lkPPE8bKkYZDvK+dLHMm25gNTNDRMGHl/P+/rXqx
        CRcUaDNNEitP+se5nWNCDeo=
X-Google-Smtp-Source: AKy350buA3FaT3ukDXDRelkwQFzWxvJfvb84LyWD9Xca8LqdvqE/k8wLgICUzrtQO3JAJESieYfVbg==
X-Received: by 2002:a7b:c5c7:0:b0:3f1:75d0:6151 with SMTP id n7-20020a7bc5c7000000b003f175d06151mr7010464wmk.1.1682321918225;
        Mon, 24 Apr 2023 00:38:38 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id d3-20020a05600c3ac300b003f19b3d89e9sm5174845wms.33.2023.04.24.00.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 00:38:37 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 24 Apr 2023 09:38:35 +0200
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v5 4/9] tracing/probes: Add tracepoint support on
 fprobe_event
Message-ID: <ZEYx+2WWixBkDbTn@krava>
References: <168198993129.1795549.8306571027057356176.stgit@mhiramat.roam.corp.google.com>
 <168198997089.1795549.1009510263722958117.stgit@mhiramat.roam.corp.google.com>
 <ZEThQgkJV7esVGdR@krava>
 <20230423223740.9f1186a08b3b316b5a0156e7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230423223740.9f1186a08b3b316b5a0156e7@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Apr 23, 2023 at 10:37:40PM +0900, Masami Hiramatsu wrote:
> On Sun, 23 Apr 2023 09:41:54 +0200
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > On Thu, Apr 20, 2023 at 08:26:10PM +0900, Masami Hiramatsu (Google) wrote:
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > > Allow fprobe_event to trace raw tracepoints so that user can trace
> > > tracepoints which don't have traceevent wrappers. This new event is
> > > always available if fprobe event is enabled since the tracepoint is
> > > disabled, trace-event and dynamic event is also not available.
> > 
> > I thought of ftrace tracepoints wrappers as standard in distros,
> > could you specify which config options that involves?
> 
> Ah, sorry, I'm completely confused you.
> 
> ----
> This new event is always available if fprobe event is enabled. If the
> tracepoint is disabled, trace-event and dynamic event including
> fprobe is also not available.
> ----

so this basically adds another way of attaching to tracepoint through ftrace
dynamic_events file interface.. but we can already attach to tracepoints
through ftrace via /sys/kernel/debug/tracing/events/* right?

I'm trying to find out what's the config for which this new way of attaching
tracepoints is useful

thanks,
jirka

> 
> > 
> > > +	if (trace_fprobe_is_tracepoint(tf)) {
> > > +		struct tracepoint *tpoint = tf->tpoint;
> > > +		unsigned long ip = (unsigned long)tpoint->probestub;
> > > +		/*
> > > +		 * Here, we do 2 steps to enable fprobe on a tracepoint.
> > > +		 * At first, put __probestub_##TP function on the tracepoint
> > > +		 * and put a fprobe on the stub function.
> > > +		 */
> > > +		ret = tracepoint_probe_register_prio_may_exist(tpoint,
> > > +					tpoint->probestub, NULL, 0);
> > > +		if (ret < 0)
> > > +			return ret;
> > > +		return register_fprobe_ips(&tf->fp, &ip, 1);
> > 
> > nice idea
> 
> Thanks!
> 
> 
> > 
> > jirka
> > 
> > > +	}
> > > +
> > >  	/* TODO: handle filter, nofilter or symbol list */
> > >  	return register_fprobe(&tf->fp, tf->symbol, NULL);
> > >  }
> > > @@ -699,6 +723,12 @@ static void __unregister_trace_fprobe(struct trace_fprobe *tf)
> > >  	if (trace_fprobe_is_registered(tf)) {
> > >  		unregister_fprobe(&tf->fp);
> > >  		memset(&tf->fp, 0, sizeof(tf->fp));
> > > +		if (trace_fprobe_is_tracepoint(tf)) {
> > > +			tracepoint_probe_unregister(tf->tpoint,
> > > +					tf->tpoint->probestub, NULL);
> > > +			tf->tpoint = NULL;
> > > +			tf->mod = NULL;
> > > +		}
> > >  	}
> > >  }
> > 
> > SNIP
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
