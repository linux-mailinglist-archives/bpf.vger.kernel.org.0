Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0198D6EBDBD
	for <lists+bpf@lfdr.de>; Sun, 23 Apr 2023 09:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjDWHmc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Apr 2023 03:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjDWHm3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Apr 2023 03:42:29 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CFD30CA;
        Sun, 23 Apr 2023 00:42:05 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5050497df77so4833546a12.1;
        Sun, 23 Apr 2023 00:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682235718; x=1684827718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hmxngamBqLpmbuuAmyp8lBrhC3luyh8KMPPH2GTU8M8=;
        b=FEzdkxayUbAYdOaOqfyQ50Z1pi8C7fEn+wx1HX9y7NFFGz/PSJtQa9Bb4twqEdDj4r
         GJV80/lu8u+nGyHeIpIgi9EaRM3aq9Z8pm0bsTreWT+Ehu8P5HcHvuuMWR4T94iN0UdS
         aXgm4TIEJxjj7tfa7Bw0Ur9p26jLI3twhgfna6nkUYemWqaNGwgyOtLdCPtFDFGfpVmb
         HPgVVQWUm5qGQkLZA+XK5Bu11Wk8icaBjlU9IGbtlMwj/qCWm/EHkt6GGn/6kmQq35Zo
         fSWT8+3MSBVUPR5tSpPbFXpic0zb9SLnk1AZ319X/FcREsaR8MQHnKw7PXT6XWjxX5Zd
         VQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682235718; x=1684827718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmxngamBqLpmbuuAmyp8lBrhC3luyh8KMPPH2GTU8M8=;
        b=gEYPZcj1nV8QGzD1/kVqtwxcqrbQfXmaoNY0dx3IErSxUnrG+g22MT47bBMzQ14nWN
         mVlisbXycxFK10HmsONfd6XJrg32c458pIM2Ht5LjIaCdIK+q1gp3+FgMoqqsGSQ9Jh2
         kktbApiOTV5uXJGoHc84N7LHBbuRNRyGz9mY6f1iJsjphlWEw7fu1KQ9hVfGBorEXtkW
         lkGTMgsFvnpzAhggORO8iGWmgLlmZ6nwPbEjd5wZDqewmk3RM++rPZ9mVLYx9E05QzAk
         n/xydPnRu91MLqa2wmQGHeCb7XwJWV6dFD5CHp0YZXFbUXog8EOMFUAK869yo0Rz0Cj/
         ZAjQ==
X-Gm-Message-State: AAQBX9ecTV3FUwn7Vk96Pq2bJAehwfTSWTQPTUco1sbUA13hfyrq61k7
        NAIKC6gJEXCQIBlvBTQ3e2E=
X-Google-Smtp-Source: AKy350bV3KIE8/g9FHvTK0jWz3NS2HY6Y5AyJLSqKNGHVdFyO2hq52J+bADGwPYhKg5M7n45jzEa5g==
X-Received: by 2002:a17:906:fd47:b0:94e:75f8:668 with SMTP id wi7-20020a170906fd4700b0094e75f80668mr5732534ejb.56.1682235718077;
        Sun, 23 Apr 2023 00:41:58 -0700 (PDT)
Received: from krava ([83.240.63.111])
        by smtp.gmail.com with ESMTPSA id f12-20020a50ee8c000000b00504ae3a5adfsm3561605edr.2.2023.04.23.00.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 00:41:57 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sun, 23 Apr 2023 09:41:54 +0200
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v5 4/9] tracing/probes: Add tracepoint support on
 fprobe_event
Message-ID: <ZEThQgkJV7esVGdR@krava>
References: <168198993129.1795549.8306571027057356176.stgit@mhiramat.roam.corp.google.com>
 <168198997089.1795549.1009510263722958117.stgit@mhiramat.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168198997089.1795549.1009510263722958117.stgit@mhiramat.roam.corp.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 20, 2023 at 08:26:10PM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Allow fprobe_event to trace raw tracepoints so that user can trace
> tracepoints which don't have traceevent wrappers. This new event is
> always available if fprobe event is enabled since the tracepoint is
> disabled, trace-event and dynamic event is also not available.

I thought of ftrace tracepoints wrappers as standard in distros,
could you specify which config options that involves?

> +	if (trace_fprobe_is_tracepoint(tf)) {
> +		struct tracepoint *tpoint = tf->tpoint;
> +		unsigned long ip = (unsigned long)tpoint->probestub;
> +		/*
> +		 * Here, we do 2 steps to enable fprobe on a tracepoint.
> +		 * At first, put __probestub_##TP function on the tracepoint
> +		 * and put a fprobe on the stub function.
> +		 */
> +		ret = tracepoint_probe_register_prio_may_exist(tpoint,
> +					tpoint->probestub, NULL, 0);
> +		if (ret < 0)
> +			return ret;
> +		return register_fprobe_ips(&tf->fp, &ip, 1);

nice idea

jirka

> +	}
> +
>  	/* TODO: handle filter, nofilter or symbol list */
>  	return register_fprobe(&tf->fp, tf->symbol, NULL);
>  }
> @@ -699,6 +723,12 @@ static void __unregister_trace_fprobe(struct trace_fprobe *tf)
>  	if (trace_fprobe_is_registered(tf)) {
>  		unregister_fprobe(&tf->fp);
>  		memset(&tf->fp, 0, sizeof(tf->fp));
> +		if (trace_fprobe_is_tracepoint(tf)) {
> +			tracepoint_probe_unregister(tf->tpoint,
> +					tf->tpoint->probestub, NULL);
> +			tf->tpoint = NULL;
> +			tf->mod = NULL;
> +		}
>  	}
>  }

SNIP
