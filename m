Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9276866315B
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 21:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237528AbjAIUV5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 15:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237790AbjAIUVh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 15:21:37 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5171137394;
        Mon,  9 Jan 2023 12:21:29 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id o8-20020a17090a9f8800b00223de0364beso14001548pjp.4;
        Mon, 09 Jan 2023 12:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BfLWbxwmeIcnP60qUaxTkT+UNDL1dMHtYWhgT82Ix3Y=;
        b=M3ooEhAfCMXq5T2e6WD8wm/7kb1JanJ73CexRmKTGc5h50OUKsyfJfkz/CGN+f6uv+
         cQFIZ8dV+KMUJ9744pLhYoJjRAPJrDa7A6rDRUh0NGK8tDltsrNZj0TNaZQTdLybvCVZ
         KwWhs1tjK7nIl+YxJ3mBjVLil2POxOH4NT0PvO7Cs9bpBcwDiXxdSX3U52wJX4pLC+ae
         iO1os8IWc/LYzRzLPqlmJJX8szhhfn/TrdfkOlM74tjkhu0PCesnFiIFt/FDqNh1Jt/+
         fgzd30MUveoB1x2Kc5r5T0e4uWh99MDX2o2bSCs0YrzZ9Pq9vJILBPgrbElfHrDs+sSg
         wBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfLWbxwmeIcnP60qUaxTkT+UNDL1dMHtYWhgT82Ix3Y=;
        b=KQb0bswCpqcDDBJ84SK55CVBDFpsDZ6Cugjp6MoN8mg3qag+Mv+/yAzT1UWFadboPg
         Ng3fNVMzmg4bPJX1+WabbKh8V8XQRRBEE6IlVqLRcI1a8C10dTDSMrYFZeqYKTzcpN0f
         zm18BdKwtYI+V4hyvbmEIofP4g41l+vPXaJR7QiJxVcFtnE0RUG3cCOK+Lh/JQrwOUw8
         IiRiusjvCKaqBXDY2oKMpiFdtMmtjUcsYetiHqxJj3EO6r038JlgsvSYvBKMsRoHIJuv
         0ZjfW71qo0C5z23A0gDGDo7EEfDW9aj8RIA/TlWAvmJ6tEcpnxQORMf1Imu9NOSyCRNL
         4BMw==
X-Gm-Message-State: AFqh2kr3Y7D0iP/IaTYZ9caUiuN63dZxE0cnrCEg7XmchytvLjQYaAlW
        LljDOy45fjt+YLxC8AXnMtNiMjEzQOQ=
X-Google-Smtp-Source: AMrXdXsri71BWmGBerekLOcITlgcce1QsiRN2lUPRQk0L8F42rTyHX/GYkf5ApuG8q3zkP4Jwy7l2w==
X-Received: by 2002:a17:90a:7301:b0:226:e9c1:6122 with SMTP id m1-20020a17090a730100b00226e9c16122mr11777926pjk.25.1673295688693;
        Mon, 09 Jan 2023 12:21:28 -0800 (PST)
Received: from google.com ([2601:647:6780:ff0:a4e0:323d:112b:426d])
        by smtp.gmail.com with ESMTPSA id c10-20020a17090a674a00b002263faf8431sm3669844pjm.17.2023.01.09.12.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 12:21:28 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
Date:   Mon, 9 Jan 2023 12:21:25 -0800
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, bpf@vger.kernel.org
Subject: Re: [PATCH 2/3] perf/core: Set data->sample_flags in
 perf_prepare_sample()
Message-ID: <Y7x3RUd67smv3EFQ@google.com>
References: <20221229204101.1099430-1-namhyung@kernel.org>
 <20221229204101.1099430-2-namhyung@kernel.org>
 <Y7wFJ+NF0NwnmzLa@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y7wFJ+NF0NwnmzLa@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Peter,

On Mon, Jan 09, 2023 at 01:14:31PM +0100, Peter Zijlstra wrote:
> On Thu, Dec 29, 2022 at 12:41:00PM -0800, Namhyung Kim wrote:
> 
> So I like the general idea; I just think it's turned into a bit of a
> mess. That is code is already overly branchy which is known to hurt
> performance, we should really try and not make it worse than absolutely
> needed.

Agreed.

> 
> >  kernel/events/core.c | 86 ++++++++++++++++++++++++++++++++------------
> >  1 file changed, 63 insertions(+), 23 deletions(-)
> > 
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index eacc3702654d..70bff8a04583 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -7582,14 +7582,21 @@ void perf_prepare_sample(struct perf_event_header *header,
> >  	filtered_sample_type = sample_type & ~data->sample_flags;
> >  	__perf_event_header__init_id(header, data, event, filtered_sample_type);
> >  
> > -	if (sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CODE_PAGE_SIZE))
> > -		data->ip = perf_instruction_pointer(regs);
> > +	if (sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CODE_PAGE_SIZE)) {
> > +		/* attr.sample_type may not have PERF_SAMPLE_IP */
> 
> Right, but that shouldn't matter, IIRC its OK to have more bits set in
> data->sample_flags than we have set in attr.sample_type. It just means
> we have data available for sample types we're (possibly) not using.
> 
> That is, I think you can simply write this like:
> 
> > +		if (!(data->sample_flags & PERF_SAMPLE_IP)) {
> > +			data->ip = perf_instruction_pointer(regs);
> > +			data->sample_flags |= PERF_SAMPLE_IP;
> > +		}
> > +	}
> 
> 	if (filtered_sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CODE_PAGE_SIZE)) {
> 		data->ip = perf_instruction_pointer(regs);
> 		data->sample_flags |= PERF_SAMPLE_IP);
> 	}
> 
> 	...
> 
> 	if (filtered_sample_type & PERF_SAMPLE_CODE_PAGE_SIZE) {
> 		data->code_page_size = perf_get_page_size(data->ip);
> 		data->sample_flags |= PERF_SAMPLE_CODE_PAGE_SIZE;
> 	}
> 
> Then after a single perf_prepare_sample() run we have:
> 
>   pre			|	post
>   ----------------------------------------
>   0			|	0
>   IP			|	IP
>   CODE_PAGE_SIZE	|	IP|CODE_PAGE_SIZE
>   IP|CODE_PAGE_SIZE	|	IP|CODE_PAGE_SIZE
> 
> So while data->sample_flags will have an extra bit set in the 3rd case,
> that will not affect perf_sample_outout() which only looks at data->type
> (== attr.sample_type).
> 
> And since data->sample_flags will have both bits set, a second run will
> filter out both and avoid the extra work (except doing that will mess up
> the branch predictors).

Yeah, it'd be better to check filtered_sample_type in the first place.

Btw, I was thinking about a hypothetical scenario that IP set by a PMU
driver not from the regs.  In this case, having CODE_PAGE_SIZE will
overwrite the IP.  I don't think we need to worry about that for now
since PMU drivers updates the regs (using set_linear_ip).  But it seems
like a possible scenario for something like PEBS or IBS.

> 
> 
> >  	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
> >  		int size = 1;
> >  
> > -		if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN)
> > +		if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN) {
> >  			data->callchain = perf_callchain(event, regs);
> > +			data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
> > +		}
> >  
> >  		size += data->callchain->nr;
> >  
> 
> This, why can't this be:
> 
> 	if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN) {
> 		data->callchain = perf_callchain(event, regs);
> 		data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
> 
> 		header->size += (1 + data->callchain->nr) * sizeof(u64);
> 	}
> 
> I suppose this is because perf_event_header lives on the stack of the
> overflow handler and all that isn't available / relevant for the BPF
> thing.

Right, it needs to calculate the data size for each sample data.

> 
> And we can't pull that out into anther function without adding yet
> another branch fest.
> 
> However; inspired by your next patch; we can do something like so:
> 
> 	if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN) {
> 		data->callchain = perf_callchain(event, regs);
> 		data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
> 
> 		data->size += (1 + data->callchain->nr) * sizeof(u64);
> 	}

This is fine as long as all other places (like in PMU drivers) set the
callchain update the sample data size accordingly.  If not, we can get
the callchain but the data size will be wrong.

> 
> And then have __perf_event_output() (or something thereabout) do:
> 
> 	perf_prepare_sample(data, event, regs);
> 	perf_prepare_header(&header, data, event);
> 	err = output_begin(&handle, data, event, header.size);
> 	if (err)
> 		goto exit;
> 	perf_output_sample(&handle, &header, data, event);
> 	perf_output_end(&handle);
> 
> With perf_prepare_header() being something like:
> 
> 	header->type = PERF_RECORD_SAMPLE;
> 	header->size = sizeof(*header) + event->header_size + data->size;
> 	header->misc = perf_misc_flags(regs);
> 	...
> 
> Hmm ?
> 
> (same for all the other sites)

Looks good.  But I'm confused by the tip-bot2 messages saying it's
merged.  Do you want me to work on it as a follow up?

Thanks,
Namhyung
