Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B6F6F053E
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 13:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243773AbjD0L7L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 07:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243771AbjD0L7K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 07:59:10 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD3E5FCB;
        Thu, 27 Apr 2023 04:59:07 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-507bdc5ca2aso14786464a12.3;
        Thu, 27 Apr 2023 04:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682596746; x=1685188746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OIM5opgixvrOYalE8rCsEBOmPPvBNCuLSu9kQtrDeAQ=;
        b=HI8KTtnQHBV1ybyYVgTYdz26k/XYeAgozGRgAxu2OQmy502C2CDtyqPUnws7Of+FDg
         ajXRiV3AwNW1xHiRHK/S+F5vdi7gitBQp7NioL6eLChKkzOt8JgecVzRhy/kN8DqNJdT
         7S04h2e9oQhmGupfLgCrcUmEKLfiY4HuqgN9kyuKQGcz3OpzFDK1lQOtdH3rW1Dfr99K
         fsjx0uv40Arcim58LyUFivc2BrIm1w6ULBRW6b9R/Thy7a5utJk8WzZWQyfM13IwILTr
         wEDLr8rMfe5LQH+3jUI0/LscQOBVsIftK5G/DbN2Y7p8UxNrRavQEw8aOBzpEROi/M2w
         7Cyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682596746; x=1685188746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIM5opgixvrOYalE8rCsEBOmPPvBNCuLSu9kQtrDeAQ=;
        b=aIvEzO2oPuvz6MNWDDgtxBSVPXm5qiUb7/lLEBaLtAw0cPgUv25wF2SiNn2ORAX5ux
         hXPj8N0X4V56fDlH6A/DyWWOAAp79coVwqtgyU3c7oagAN6jlQQiSIWwC92WF9aOZg6w
         e/R/Q4SvUyaw8UzQQ0xtNTbJgJUVDohNgS+Myd/NuY0sQOn3PegY7sPPATRQqB5xi+Yg
         U0OiWchkq69CnnHVwLjb6Aj6Y6ivKNRmGo9Nceemkp8hvQ5vdXLPcuiOcby3VCyL4iKy
         E86bSSQ8e4WX5/NWl4r55hO0k+jHsuJ31Jrkdm0XMWGjAp4FfQ3RJSH7yFxUayIe4Ali
         3BSg==
X-Gm-Message-State: AC+VfDwT12MNFlW5ZHzjlYAXgVVJQjFfeIW4jTEkDYEv61HGVZuMm3+9
        fjWR7bNVIOrWKG2/7OQn794=
X-Google-Smtp-Source: ACHHUZ4fNiKwcvlMh2GfpcNoIS7nMpK86ksuE9z6U09wmUPgwtDsZp4HVklswGAF+ABRSEM1MTFFUQ==
X-Received: by 2002:aa7:d054:0:b0:506:b2a3:a8cd with SMTP id n20-20020aa7d054000000b00506b2a3a8cdmr1215762edo.40.1682596745539;
        Thu, 27 Apr 2023 04:59:05 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-8b88-53b7-c55c-8535.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:8b88:53b7:c55c:8535])
        by smtp.gmail.com with ESMTPSA id o25-20020aa7d3d9000000b00509bd19b869sm6722435edr.48.2023.04.27.04.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 04:59:05 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 27 Apr 2023 13:59:03 +0200
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v7 04/11] tracing/probes: Add tracepoint support on
 fprobe_events
Message-ID: <ZEpjh8ZfZMch2Av/@krava>
References: <168255826500.2565678.17719875734305974633.stgit@mhiramat.roam.corp.google.com>
 <168255830406.2565678.710162679499561673.stgit@mhiramat.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168255830406.2565678.710162679499561673.stgit@mhiramat.roam.corp.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 27, 2023 at 10:18:24AM +0900, Masami Hiramatsu (Google) wrote:

SNIP

>  	ret = traceprobe_parse_probe_arg(&ep->tp, i, argv[i], flags);
> diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> index 0049d9ef2402..7c8be8a3616f 100644
> --- a/kernel/trace/trace_fprobe.c
> +++ b/kernel/trace/trace_fprobe.c
> @@ -9,6 +9,7 @@
>  #include <linux/module.h>
>  #include <linux/rculist.h>
>  #include <linux/security.h>
> +#include <linux/tracepoint.h>
>  #include <linux/uaccess.h>
>  
>  #include "trace_dynevent.h"
> @@ -17,6 +18,7 @@
>  #include "trace_probe_tmpl.h"
>  
>  #define FPROBE_EVENT_SYSTEM "fprobes"
> +#define TRACEPOINT_EVENT_SYSTEM "tracepoints"

so the created tracepoints go under 'events/tracepoints' directory,
should the name be more fprobe specific? like under 'events/fprobe/tracepoints' ?

jirka

>  #define RETHOOK_MAXACTIVE_MAX 4096
>  
>  static int trace_fprobe_create(const char *raw_command);
> @@ -41,6 +43,8 @@ struct trace_fprobe {
>  	struct dyn_event	devent;
>  	struct fprobe		fp;
>  	const char		*symbol;
> +	struct tracepoint	*tpoint;
> +	struct module		*mod;
>  	struct trace_probe	tp;
>  };
>  
> @@ -68,6 +72,11 @@ static bool trace_fprobe_is_return(struct trace_fprobe *tf)
>  	return tf->fp.exit_handler != NULL;
>  }
>  
> +static bool trace_fprobe_is_tracepoint(struct trace_fprobe *tf)
> +{
> +	return tf->tpoint != NULL;
> +}
> +

SNIP
