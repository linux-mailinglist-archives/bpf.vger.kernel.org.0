Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7846F69DF53
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 12:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbjBULy2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 06:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbjBULy1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 06:54:27 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33A41DB9C;
        Tue, 21 Feb 2023 03:54:25 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id ck15so17329537edb.0;
        Tue, 21 Feb 2023 03:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kkoVp6yPED6yV7ngjRQMFI8z6C4a0OvzfE+Clx7JMHE=;
        b=ROZElZEiajrjAZC2SwpZGaooPND6vQ7K408Ar5+BO4RNNbmxreJjXbrAHAMyEqhfJW
         jT1K8FZZAfYnIMDfLoCI8d1Y2jHqMzj05GFsXSnH5eELpkJMBw184fc6WLzKV9HsX2jq
         iiuav+xzI/1uvtFufUsRkIW25kKsx9Xq1vhC8Gt+9UX6a0IAyrMhQQ7jmpNIw2Zozj1c
         79i4NcS5/2SfOjB4aYdcA1KGaDRJn4DajYTOOa9wpBSAjik5sS5pt2VYEYuw9D/sehpG
         1Uz6XsSPcykSQSPoBni01E1KSdsw9Zvz1iIoeOsmtiv5185CWl8/nFfUuJHcllnvLThY
         aMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkoVp6yPED6yV7ngjRQMFI8z6C4a0OvzfE+Clx7JMHE=;
        b=VE9SQCLk5tj4VDLDqEFhuccnZJDWOB2DpTQRJoFapv68372g4Oz0oi+kvs5wXa+bie
         +c9Ql+M3dI86axFbm/h6Z2ZEcQeTlecnueOTV+WN3sVkz8pTaKenyPgcwNYPArRc3hyo
         DdHTzRYY1WbEExtBV6I8mhEXkff3B3E0lBQ3c7yMrMU6Cnx2LDFarVlYX9V83UtrBxLT
         UQgZ5QwZcvjc3FoBKzR1XW8QdB0j1KT0u/kDbmTLbRijw6Qw++Z6PiIGOyMMwNi9DyFx
         sO0kdPqyssMYGpf8au9QDQzsxnBnJZjAUFBd+6RJVTZAUEjt0ff6F5+9HFN0bUiqszv4
         I6xg==
X-Gm-Message-State: AO0yUKVFgiKzN/qiUpTIZb6hlkZ+I11+HKOaAeAfPsUEOzOrHRTXYxV4
        NeEsVhVzDC3cp/g3+UcEaJ0=
X-Google-Smtp-Source: AK7set9S8JPkOJxvcEzU+qMtnlk+CjruT9Yl9pG+OsoC+2omUKdHicTtf2ee74S+WwJ0+eaZhBiPzg==
X-Received: by 2002:a17:907:2bcf:b0:88d:619:15fc with SMTP id gv15-20020a1709072bcf00b0088d061915fcmr9631647ejc.21.1676980464177;
        Tue, 21 Feb 2023 03:54:24 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id dt23-20020a170906b79700b00889db195470sm7007836ejb.82.2023.02.21.03.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 03:54:23 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 21 Feb 2023 12:54:21 +0100
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Subject: Re: [PATCH 4/8] perf record: Record dropped sample count
Message-ID: <Y/Sw7RurDK/fq02m@krava>
References: <20230219061329.1001079-1-namhyung@kernel.org>
 <20230219061329.1001079-5-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230219061329.1001079-5-namhyung@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 18, 2023 at 10:13:25PM -0800, Namhyung Kim wrote:
> When it uses bpf filters, event might drop some samples.  It'd be nice
> if it can report how many samples it lost.  As LOST_SAMPLES event can
> carry the similar information, let's use it for bpf filters.
> 
> To indicate it's from BPF filters, add a new misc flag for that and
> do not display cpu load warnings.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/lib/perf/include/perf/event.h |  2 ++
>  tools/perf/builtin-record.c         | 37 ++++++++++++++++++-----------
>  tools/perf/util/bpf-filter.c        |  7 ++++++
>  tools/perf/util/bpf-filter.h        |  5 ++++
>  tools/perf/util/session.c           |  3 ++-
>  5 files changed, 39 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
> index ad47d7b31046..51b9338f4c11 100644
> --- a/tools/lib/perf/include/perf/event.h
> +++ b/tools/lib/perf/include/perf/event.h
> @@ -70,6 +70,8 @@ struct perf_record_lost {
>  	__u64			 lost;
>  };
>  
> +#define PERF_RECORD_MISC_LOST_SAMPLES_BPF (1 << 15)
> +
>  struct perf_record_lost_samples {
>  	struct perf_event_header header;
>  	__u64			 lost;

SNIP

> @@ -1914,6 +1907,7 @@ static void record__read_lost_samples(struct record *rec)
>  
>  	evlist__for_each_entry(session->evlist, evsel) {
>  		struct xyarray *xy = evsel->core.sample_id;
> +		u64 lost_count;
>  
>  		if (xy == NULL || evsel->core.fd == NULL)
>  			continue;
> @@ -1925,12 +1919,27 @@ static void record__read_lost_samples(struct record *rec)
>  
>  		for (int x = 0; x < xyarray__max_x(xy); x++) {
>  			for (int y = 0; y < xyarray__max_y(xy); y++) {
> -				__record__read_lost_samples(rec, evsel, lost, x, y);
> +				struct perf_counts_values count;
> +
> +				if (perf_evsel__read(&evsel->core, x, y, &count) < 0) {
> +					pr_err("read LOST count failed\n");
> +					goto out;
> +				}
> +
> +				if (count.lost) {
> +					__record__save_lost_samples(rec, evsel, lost,
> +								    x, y, count.lost, 0);
> +				}
>  			}
>  		}
> +
> +		lost_count = perf_bpf_filter__lost_count(evsel);
> +		if (lost_count)
> +			__record__save_lost_samples(rec, evsel, lost, 0, 0, lost_count,
> +						    PERF_RECORD_MISC_LOST_SAMPLES_BPF);

ah that's why I did not see this in kernel code, it's set by record, nice ;-)

jirka
