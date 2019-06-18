Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEC8A4994F
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2019 08:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfFRGuO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Jun 2019 02:50:14 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37865 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfFRGuO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Jun 2019 02:50:14 -0400
Received: by mail-ot1-f67.google.com with SMTP id s20so12766245otp.4
        for <bpf@vger.kernel.org>; Mon, 17 Jun 2019 23:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F1uNa6FtFexED8BrkdYi+QJ3mxVBvnGOiE6mNV8TMuQ=;
        b=Ai3DslE7sIcJd3lwcHv/nfIW3mBphyUfgA4ERiWbp1nKmnX57EUkIBMuGeFXdT7pfG
         FW+l44ZOS6pT9YQMmmsJBwXjhCDuIbnT+EOSiX2bhs8hcy9G4XTUuePQGu5bCIvclU9N
         M+Q5UcimomCZHO0VG2aTeQedTT1QWSp5ft8A387fC/cCeZBWRu6+r4n8Z8vmMPVmwT22
         gEaGXNF9qds6fOLOwgu/tSpiXP/frXgklI4Ddj4OfJdKCVtItW3YXraLNJuTPqYKdLbu
         fWogpJYS9Wfejc2Q5oTyxJKmSPjosEPlFfapUcOS7yE1nA0uBHKC3rVMhHJLvqMEZf5I
         RRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F1uNa6FtFexED8BrkdYi+QJ3mxVBvnGOiE6mNV8TMuQ=;
        b=RpWvHwLTpFKbHeJUg66dV/X15DeJidHm3npGRe5+xzCtCx3fFdAp2AIKNs7U9GhNds
         sdr57AuoqiHy32CMhUyCI+pPisDSCJcFvGfP0y9CXaxKbuaR0JOLPa7J+gIkF+PU5xDU
         4gbT/IgdzvnIyvki+wYGMLq5Rluk5GkReSRlOV6ol7LLGeZncKpmImJmOGNZaLw/h4Lj
         40PG0RuLMkzywUE67i6azyU6MdeWYOUWDO1Pbt8W+6SwpklPs801MnZbDusytP3Ueta7
         2xkh0xssaaHBlH0gXoKL3H96B5g5z+1YGFB1381O22D5GQG5MtOQlA77GJErWm68cm6N
         tFQA==
X-Gm-Message-State: APjAAAVo280thjEYrjaUsMUdXgDuq7i5JkFVh8tQ7iWEwImbAoE9jtBH
        WqDf4Ea3rpQue9QMucWCGeFW/X6ckafFpw==
X-Google-Smtp-Source: APXvYqzF6FAEm6X6iuXvqsBEPGfwrQNDfuWjFLfRsqVOsMs1hrhtT+EOaKTXLQrddSKqFiN5L3rpxw==
X-Received: by 2002:a05:6830:1319:: with SMTP id p25mr2977936otq.224.1560839074504;
        Mon, 17 Jun 2019 23:24:34 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li964-79.members.linode.com. [45.33.10.79])
        by smtp.gmail.com with ESMTPSA id k3sm5360435otr.1.2019.06.17.23.24.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Jun 2019 23:24:33 -0700 (PDT)
Date:   Tue, 18 Jun 2019 14:24:23 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH 1/2] perf trace: Use pr_debug() instead of fprintf() for
 logging
Message-ID: <20190618062423.GA24549@leoy-ThinkPad-X240s>
References: <20190617091140.24372-1-leo.yan@linaro.org>
 <20190617152412.GJ1402@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617152412.GJ1402@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 17, 2019 at 12:24:12PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jun 17, 2019 at 05:11:39PM +0800, Leo Yan escreveu:
> > In the function trace__syscall_info(), it explicitly checks verbose
> > level and print out log with fprintf().  Actually, we can use
> > pr_debug() to do the same thing for debug logging.
> > 
> > This patch uses pr_debug() instead of fprintf() for debug logging; it
> > includes a minor fixing for 'space before tab in indent', which
> > dismisses git warning when apply it.
> 
> But those are not fprintf(stdout,), they explicitely redirect to the
> output file that the user may have specified using 'perf trace --output
> filename.trace' :-)

Thanks for pointing out, sorry for noise. Please drop this patch.

Thanks,
Leo Yan

> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/builtin-trace.c | 21 +++++++++------------
> >  1 file changed, 9 insertions(+), 12 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index bd1f00e7a2eb..5cd74651db4c 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -1760,12 +1760,11 @@ static struct syscall *trace__syscall_info(struct trace *trace,
> >  		 * grep "NR -1 " /t/trace_pipe
> >  		 *
> >  		 * After generating some load on the machine.
> > - 		 */
> > -		if (verbose > 1) {
> > -			static u64 n;
> > -			fprintf(trace->output, "Invalid syscall %d id, skipping (%s, %" PRIu64 ") ...\n",
> > -				id, perf_evsel__name(evsel), ++n);
> > -		}
> > +		 */
> > +		static u64 n;
> > +
> > +		pr_debug("Invalid syscall %d id, skipping (%s, %" PRIu64 ")\n",
> > +			 id, perf_evsel__name(evsel), ++n);
> >  		return NULL;
> >  	}
> >  
> > @@ -1779,12 +1778,10 @@ static struct syscall *trace__syscall_info(struct trace *trace,
> >  	return &trace->syscalls.table[id];
> >  
> >  out_cant_read:
> > -	if (verbose > 0) {
> > -		fprintf(trace->output, "Problems reading syscall %d", id);
> > -		if (id <= trace->syscalls.max && trace->syscalls.table[id].name != NULL)
> > -			fprintf(trace->output, "(%s)", trace->syscalls.table[id].name);
> > -		fputs(" information\n", trace->output);
> > -	}
> > +	pr_debug("Problems reading syscall %d", id);
> > +	if (id <= trace->syscalls.max && trace->syscalls.table[id].name != NULL)
> > +		pr_debug("(%s)", trace->syscalls.table[id].name);
> > +	pr_debug(" information\n");
> >  	return NULL;
> >  }
> >  
> > -- 
> > 2.17.1
> 
> -- 
> 
> - Arnaldo
