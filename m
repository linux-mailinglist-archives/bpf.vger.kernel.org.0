Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E944699C6A
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 19:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjBPSiw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 13:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBPSiv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 13:38:51 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABB343930;
        Thu, 16 Feb 2023 10:38:50 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 24so1840470pgt.7;
        Thu, 16 Feb 2023 10:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SuLdwLtfLsyKrMS8dI+1/4NFezsn+c9OtrFVwK/ARsA=;
        b=g7BW0FLF9CZ568xaYDBEUXjVspPkAaIk1NQp1MjeWnJC6NWS/5EC2HeQaOejVOXAa2
         rnx2IjNt5yBPwecP9jkrTVCsT35F1fJ5UJbCrQwl9j1nbggCaKyJYZ/jeZlSX79sAss0
         1DAX2SHHu7UeHAfH+biB99+2FcRoDk0oYmOeWajeIKzF9IRHTgNRYLWMWx1gpaIPFgjC
         QxNHQgDrT71wwWHGv1row3zXEroWcF9QXR147Gr10WSlN6y2mKMMDppVvLknAjTprcLG
         LgX8qkuMEUaNIZJXIlnodR+KgZw6KNPJBMNkjZi5R7ybWyoVDTWECotB7l1gxSgshjGV
         tFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SuLdwLtfLsyKrMS8dI+1/4NFezsn+c9OtrFVwK/ARsA=;
        b=iet5/37M6/qCC1aFDARVjrVX6VX3GbR5eQa0AhGzzGCWc0evA+kAkVXw+z3KZ57hvO
         AnWglYJlrk8mc+fLgRWFlZQsPW8lMLidbp1S2ISa8EJP/ayphgnxpGYcpin1cX/58ObA
         5x1Ve8cPHGMx1Zn2og9ZAv9wpVGZvYCSEdz3iORmd75Q/PXZr9gP75YAzELcaVl8tJ6V
         Z1PR8NHmK7ojOHKN8pWrZtVKo6nW8ALm/69pbQa7/LmUxc1j/1JeFJONFrMw+8rV7gHO
         76guClMWXmKUf8iBxpAQiuLLtZxfvXJfGDbI1/4G2OCnZBap6DMTutoX7b+FzHZhyQgQ
         khUQ==
X-Gm-Message-State: AO0yUKUa2mf5USs4mX2cbtdHeMkw0+wosfkXA6NqO/Bw1bl5Q+f9Ug7a
        Tae++KbjM5Hnx/GrrIUmvrAF1P5mCNk=
X-Google-Smtp-Source: AK7set/aje9IQy6+W9Gi4gllMJPg9aafvoLMyhy5QeuG1pEKiKWelzO3bLxDFZ6vwCo/oMvjCgiNtA==
X-Received: by 2002:a62:5250:0:b0:596:15de:ea1e with SMTP id g77-20020a625250000000b0059615deea1emr5729416pfb.9.1676572730265;
        Thu, 16 Feb 2023 10:38:50 -0800 (PST)
Received: from google.com ([2620:15c:2d4:203:cb24:bfe1:41f4:4b12])
        by smtp.gmail.com with ESMTPSA id n20-20020aa79054000000b005921c46cbadsm1663672pfo.99.2023.02.16.10.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 10:38:49 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
Date:   Thu, 16 Feb 2023 10:38:46 -0800
From:   Namhyung Kim <namhyung@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
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
Message-ID: <Y+54Nla62F+dutdu@google.com>
References: <20230214050452.26390-1-namhyung@kernel.org>
 <20230214050452.26390-5-namhyung@kernel.org>
 <Y+5YaQt7Fme65a78@krava>
 <Y+5ajnitOAxjdn2C@kernel.org>
 <Y+5bGS9clWPS+B5J@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+5bGS9clWPS+B5J@krava>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Jiri and Arnaldo,

On Thu, Feb 16, 2023 at 05:34:33PM +0100, Jiri Olsa wrote:
> On Thu, Feb 16, 2023 at 01:32:14PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Feb 16, 2023 at 05:23:05PM +0100, Jiri Olsa escreveu:
> > > On Mon, Feb 13, 2023 at 09:04:49PM -0800, Namhyung Kim wrote:
> > > 
> > > SNIP
> > > 
> > > > @@ -1929,12 +1923,27 @@ static void record__read_lost_samples(struct record *rec)
> > > >  
> > > >  		for (int x = 0; x < xyarray__max_x(xy); x++) {
> > > >  			for (int y = 0; y < xyarray__max_y(xy); y++) {
> > > > -				__record__read_lost_samples(rec, evsel, lost, x, y);
> > > > +				struct perf_counts_values count;
> > > > +
> > > > +				if (perf_evsel__read(&evsel->core, x, y, &count) < 0) {
> > > > +					pr_err("read LOST count failed\n");
> > > > +					goto out;
> > > > +				}
> > > > +
> > > > +				if (count.lost) {
> > > > +					__record__save_lost_samples(rec, evsel, lost,
> > > > +								    x, y, count.lost, 0);
> > > > +				}
> > > >  			}
> > > >  		}
> > > > +
> > > > +		lost_count = perf_bpf_filter__lost_count(evsel);
> > > > +		if (lost_count)
> > > > +			__record__save_lost_samples(rec, evsel, lost, 0, 0, lost_count,
> > > > +						    PERF_RECORD_MISC_LOST_SAMPLES_BPF);
> > > 
> > > hi,
> > > I can't see PERF_RECORD_MISC_LOST_SAMPLES_BPF in the tip/perf/core so can't compile,
> > > what do I miss?
> > 
> > Humm, but you shouldn't need kernel headers to build tools/perf/, right?
> 
> right, should be also in tools/include headers

Yeah, sorry about that.  I'm not sure how I missed the part.

I put it in tools/lib/perf/include/perf/event.h only as it does nothing
with kernel.  Will fix in v2.

Thanks,
Namhyung

---8<---

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index ad47d7b31046..51b9338f4c11 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -70,6 +70,8 @@ struct perf_record_lost {
        __u64                    lost;
 };

+#define PERF_RECORD_MISC_LOST_SAMPLES_BPF (1 << 15)
+
 struct perf_record_lost_samples {
        struct perf_event_header header;
        __u64                    lost;

