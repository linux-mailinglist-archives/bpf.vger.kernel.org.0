Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F16699A1B
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 17:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjBPQel (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 11:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBPQek (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 11:34:40 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA805598;
        Thu, 16 Feb 2023 08:34:37 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id m10so2437013wrn.4;
        Thu, 16 Feb 2023 08:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V5mbbHr7+rxGbIXSGncjaubKdnUrIww50oZqIFjYJZo=;
        b=BopkFU8dI1eMwvqpTHwxXPMlaxwMzh3V1KpkAyDnAEYyuni3jQqx0v3fR9FPfPGl1/
         TPL59TjF1gTqIejaFGD8Y0DFla1UqZnD6kcIIEhFLyi8URhhpqYnOPupDFSek+AWC7nH
         JHQspuQLuPg/I9ycUdLZ9qrOwQFdDajxjAqhlTK+pbgm0Hy1ApIeVFQRYKj3IDvlhLU0
         Mh6+LVg4KKjiEQrWUg2gRLb2Py0fYiPHZWteonRaWewkqADCZY6P1Rtj6aZcSbKSBlrK
         hSrbS6gkeqTLHeHyQwFrxqmfUJ3Pb0GtxO7DrRam5k1t+I4BkcDcn2dZEsMwS34w/F3w
         TJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5mbbHr7+rxGbIXSGncjaubKdnUrIww50oZqIFjYJZo=;
        b=jHtVK//lmKPFueYxRMFlrhKUplkng8wk4RvhBM8jOgcnzplbXQUrWXto/JsqKHVjdc
         jPt0cIrd/1PgYl8mb6BSXgU/78SILTm+1THGZSuSOds5jRyfgX4urx9K9NXx1x1CH7YZ
         TFYzdihfMakJLLr/vwe5HJFzEVI+9y4GByiVQHWo1jKPDWoNOASqfQVzbwuvuz951kv2
         wwdaNOhafwDtwwDXZlJlavvpLSpj7GUmSiQmxkSK5wfZMvZ1QzuiqYSCo3PbrmJj1ZhW
         8PDKkM0cQBcTMfa1hZTtBtqc+0Iju7evZPZkoCtSdTcYCUFPXuWnBfDOSDIm+R7wf3oL
         czLQ==
X-Gm-Message-State: AO0yUKWfniFIt4HNTQbQpcnnEnaM+6Sd+SFspJrAiRzAXgYaWintoyuH
        ejMeed8DE1P1qYHLDdNHFOo=
X-Google-Smtp-Source: AK7set+cF5ukJVIj32LL2ud5SKNxFU7d1pPyGv2S4UZaYDjB/c+b5fRC/Jywu3sz+0NhCCjZ0ClJTQ==
X-Received: by 2002:adf:fa45:0:b0:2c5:56f6:52c7 with SMTP id y5-20020adffa45000000b002c556f652c7mr5923045wrr.64.1676565276294;
        Thu, 16 Feb 2023 08:34:36 -0800 (PST)
Received: from krava ([81.6.34.132])
        by smtp.gmail.com with ESMTPSA id n13-20020adfe34d000000b002c546d169ddsm1950227wrj.11.2023.02.16.08.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 08:34:35 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 16 Feb 2023 17:34:33 +0100
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <song@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>, Hao Luo <haoluo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 4/7] perf record: Record dropped sample count
Message-ID: <Y+5bGS9clWPS+B5J@krava>
References: <20230214050452.26390-1-namhyung@kernel.org>
 <20230214050452.26390-5-namhyung@kernel.org>
 <Y+5YaQt7Fme65a78@krava>
 <Y+5ajnitOAxjdn2C@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+5ajnitOAxjdn2C@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 16, 2023 at 01:32:14PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Feb 16, 2023 at 05:23:05PM +0100, Jiri Olsa escreveu:
> > On Mon, Feb 13, 2023 at 09:04:49PM -0800, Namhyung Kim wrote:
> > 
> > SNIP
> > 
> > > @@ -1929,12 +1923,27 @@ static void record__read_lost_samples(struct record *rec)
> > >  
> > >  		for (int x = 0; x < xyarray__max_x(xy); x++) {
> > >  			for (int y = 0; y < xyarray__max_y(xy); y++) {
> > > -				__record__read_lost_samples(rec, evsel, lost, x, y);
> > > +				struct perf_counts_values count;
> > > +
> > > +				if (perf_evsel__read(&evsel->core, x, y, &count) < 0) {
> > > +					pr_err("read LOST count failed\n");
> > > +					goto out;
> > > +				}
> > > +
> > > +				if (count.lost) {
> > > +					__record__save_lost_samples(rec, evsel, lost,
> > > +								    x, y, count.lost, 0);
> > > +				}
> > >  			}
> > >  		}
> > > +
> > > +		lost_count = perf_bpf_filter__lost_count(evsel);
> > > +		if (lost_count)
> > > +			__record__save_lost_samples(rec, evsel, lost, 0, 0, lost_count,
> > > +						    PERF_RECORD_MISC_LOST_SAMPLES_BPF);
> > 
> > hi,
> > I can't see PERF_RECORD_MISC_LOST_SAMPLES_BPF in the tip/perf/core so can't compile,
> > what do I miss?
> 
> Humm, but you shouldn't need kernel headers to build tools/perf/, right?

right, should be also in tools/include headers

jirka
