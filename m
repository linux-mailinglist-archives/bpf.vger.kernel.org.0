Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6B4614763
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 11:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiKAKDj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 06:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiKAKDa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 06:03:30 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FA81CC;
        Tue,  1 Nov 2022 03:03:24 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id n12so35645367eja.11;
        Tue, 01 Nov 2022 03:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ZrcswFZBF81Q/nP09ykFVBZohF+XO4K+4aZyxDJ6+Y=;
        b=IbzRpbRGrxUe8bFkUWbd+UVCHkiCp2lQ90gia1ANOZ7/uUQveSP6avnxrhDttY6ed4
         ij8KStd16Og3oqmP0TB6j5j1UMgD2yBnGPVKx2ZIhKBJx3VQnRUeunjRQ1mnkKVRAlx+
         4GHtzkI0r7L783IyLzqA2cutB0zD2PpovPPC14ImFFnoQE/RVv6B57ZSViK9onsiNV4h
         RoVv055vKNRXPeYDygVR8iZ7Nn5fYXd1Xlfmrets1xQ1x2xnD4HjtH396i55iLF0vuWb
         NP72nnsyVkRbWrZ8vAORwrBUjRiS7DwIOXYA11D0Yk/GYjoYXyPeBmOUaYEoBc+6Jklj
         5TNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ZrcswFZBF81Q/nP09ykFVBZohF+XO4K+4aZyxDJ6+Y=;
        b=hqrPLIN9BsjtG+T61iQEw7BI0uhrQGCNUSXsayrtQTFK8zWl7/1aswKUd9RfI1jSBl
         LEglSqetfOZKXySYNU4lCuuibHoQgSnYwZaEZ5cKPkWjHchrV0levBl6mWJhSW4GwCdG
         ymlvFqE94zCe+ZH+nVHNtXhp66cuRhabTa4FupZeGtWzP+rXOhJqo8lBhQMNkVPedsGq
         ZDZK50LnKfZqa1mbuGK2a9p/XuDoA49uVflc8MJX/4/lZl2ZhSGPFNLdleIyfurkVJmm
         PR80kM5rTlW3pShVI/znLOYhvmXA+g+Jae++JOIyF/MpH3Q9e5+4EmRLnrClFMxv711D
         bPtw==
X-Gm-Message-State: ACrzQf0iePv2Kmh7rzbaWMUJNreNNOI/a0bF1DhLBjzuqAeaUgb29pBe
        YcJmFs/C+GEwwM9gsiPNAWw=
X-Google-Smtp-Source: AMsMyM79aIzudnMIVUl8P+lUeQtXrLA3pz6dTn3iJkfEm1C+7sBzx59DbvgGb7+okZLszERsRnPrVw==
X-Received: by 2002:a17:907:7243:b0:7ad:88f8:7ef1 with SMTP id ds3-20020a170907724300b007ad88f87ef1mr17303423ejc.12.1667297002502;
        Tue, 01 Nov 2022 03:03:22 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id qo14-20020a170907874e00b0078d3f96d293sm4027026ejc.30.2022.11.01.03.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 03:03:22 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 1 Nov 2022 11:03:19 +0100
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH bpf-next 1/3] perf/core: Prepare sample data before
 calling BPF
Message-ID: <Y2Du5/Iolphxcbv2@krava>
References: <20221101052340.1210239-1-namhyung@kernel.org>
 <20221101052340.1210239-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101052340.1210239-2-namhyung@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 31, 2022 at 10:23:38PM -0700, Namhyung Kim wrote:
> To allow bpf overflow handler to access the perf sample data, it needs to
> prepare missing but requested data before calling the handler.
> 
> I'm taking a conservative approach to allow a list of sample formats only
> instead of allowing them all.  For now, IP and ADDR data are allowed and
> I think it's good enough to build and verify general BPF-based sample
> filters for perf events.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  kernel/events/core.c | 40 +++++++++++++++++++++++++++++++---------
>  1 file changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index aefc1e08e015..519f30c33a24 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7329,8 +7329,10 @@ void perf_prepare_sample(struct perf_event_header *header,
>  	filtered_sample_type = sample_type & ~data->sample_flags;
>  	__perf_event_header__init_id(header, data, event, filtered_sample_type);
>  
> -	if (sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CODE_PAGE_SIZE))
> -		data->ip = perf_instruction_pointer(regs);
> +	if (sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CODE_PAGE_SIZE)) {
> +		if (filtered_sample_type & PERF_SAMPLE_IP)
> +			data->ip = perf_instruction_pointer(regs);
> +	}
>  
>  	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
>  		int size = 1;
> @@ -10006,6 +10008,32 @@ static void perf_event_free_filter(struct perf_event *event)
>  }
>  
>  #ifdef CONFIG_BPF_SYSCALL
> +static void bpf_prepare_sample(struct bpf_prog *prog,
> +			       struct perf_event *event,
> +			       struct perf_sample_data *data,
> +			       struct pt_regs *regs)
> +{
> +	u64 filtered_sample_type;
> +
> +	filtered_sample_type = event->attr.sample_type & ~data->sample_flags;

could we add the same comment in here as is in perf_prepare_sample

        /*
         * Clear the sample flags that have already been done by the
         * PMU driver.
         */

it took me while to recall while we set addr to 0 in here ;-)

thanks,
jirka

> +
> +	if (prog->call_get_stack &&
> +	    (filtered_sample_type & PERF_SAMPLE_CALLCHAIN)) {
> +		data->callchain = perf_callchain(event, regs);
> +		data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
> +	}
> +
> +	if (filtered_sample_type & PERF_SAMPLE_IP) {
> +		data->ip = perf_instruction_pointer(regs);
> +		data->sample_flags |= PERF_SAMPLE_IP;
> +	}
> +
> +	if (filtered_sample_type & PERF_SAMPLE_ADDR) {
> +		data->addr = 0;
> +		data->sample_flags |= PERF_SAMPLE_ADDR;
> +	}
> +}
> +
>  static void bpf_overflow_handler(struct perf_event *event,
>  				 struct perf_sample_data *data,
>  				 struct pt_regs *regs)
> @@ -10023,13 +10051,7 @@ static void bpf_overflow_handler(struct perf_event *event,
>  	rcu_read_lock();
>  	prog = READ_ONCE(event->prog);
>  	if (prog) {
> -		if (prog->call_get_stack &&
> -		    (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
> -		    !(data->sample_flags & PERF_SAMPLE_CALLCHAIN)) {
> -			data->callchain = perf_callchain(event, regs);
> -			data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
> -		}
> -
> +		bpf_prepare_sample(prog, event, data, regs);
>  		ret = bpf_prog_run(prog, &ctx);
>  	}
>  	rcu_read_unlock();
> -- 
> 2.38.1.273.g43a17bfeac-goog
> 
