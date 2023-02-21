Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8412C69DF56
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 12:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbjBULyk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 06:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbjBULyi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 06:54:38 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9FF2310C;
        Tue, 21 Feb 2023 03:54:32 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id g1so15842469edz.7;
        Tue, 21 Feb 2023 03:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ERIEpzVXeAKId+4W2uaXNGXUU/28yQJ/8pkAK4Fgyus=;
        b=H5NjRhJM8MC5HF5Hh7H3djlzi1AvQeI7LXhDuqm4NN9qnK/iIWdAYPicRKjI4JTnKd
         pOFQ+sJMYX9mTb+d3463pxciMRTNfqTD8MY9zYMVEUsYK92MdaLvagcSJAtV7nl3veLx
         DhU8pVpbGIg3b1BR6rvQFoCu3Sx2u2gHF1FUq7mjOcaVhOs87bIusk7Z84nM98hYO7mi
         j6J4IJt/wX6Tlf5OofqEKYzl8Fv8LU7MLmz5pFaGe1LL95bKFYkDOJfW8i8WCkidqFHP
         nG1s9iHkZxM4yt1mwNckIOWib61vxxSbT1PsuhGo5vr/QAxonD/1XI1jwnzT0ehTT9O3
         cFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERIEpzVXeAKId+4W2uaXNGXUU/28yQJ/8pkAK4Fgyus=;
        b=6AxfQWsNrRJIXvOrTJCaY00qq0Hy2ZI4oGC4VujdfVJUUdCeFwx0vb786ZtR2840kF
         qfvr091Pa4vmhwaos2Hso1G41rcTUwqpGMwgiNXBKwb/0b20vZOBWMXFlo+tAEvYYD1E
         WqRfTkPnWwTp4QCY5B5QyEDRtMOfLv8GWGt90NsfDljA7AyzbVXRm0z06qHoVofMuqEy
         HHuzKerfA0JiaDRVuyR+elLyP7orYLWcbWbGKqKykRU3JpRZv6kBZQHm/kO7GNcUdAVA
         ttFw3RZbWb394xMCtM86JxoJ8OrjQG08tJi9cOQv+crkwTikodgM61pelxb4DVYMd/jg
         /9rw==
X-Gm-Message-State: AO0yUKVb15NS3xXyxUU7T91ZxWb/YgkavhucBhvXcwvjbIrvh7jg/oSv
        Hb/ze7frIgDJtC8h/Ni0G6U=
X-Google-Smtp-Source: AK7set9In+3UVR+u5Lx573e6LxpP85Z64rtE7X8V3TI5hAWdu/DOOLrVbeGUPdGX1QHBwylME7LJjg==
X-Received: by 2002:a17:907:8d11:b0:87b:d3f3:dcf3 with SMTP id tc17-20020a1709078d1100b0087bd3f3dcf3mr13280743ejc.35.1676980471380;
        Tue, 21 Feb 2023 03:54:31 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id y17-20020a1709064b1100b008b7a9ff7dfdsm5081012eju.162.2023.02.21.03.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 03:54:31 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 21 Feb 2023 12:54:28 +0100
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
Subject: Re: [PATCH 3/8] perf record: Add BPF event filter support
Message-ID: <Y/Sw9Cd5nvf/YKjA@krava>
References: <20230219061329.1001079-1-namhyung@kernel.org>
 <20230219061329.1001079-4-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230219061329.1001079-4-namhyung@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 18, 2023 at 10:13:24PM -0800, Namhyung Kim wrote:

SNIP

> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 8374117e66f6..6429915d376d 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -52,6 +52,7 @@
>  #include "util/pmu-hybrid.h"
>  #include "util/evlist-hybrid.h"
>  #include "util/off_cpu.h"
> +#include "util/bpf-filter.h"
>  #include "asm/bug.h"
>  #include "perf.h"
>  #include "cputopo.h"
> @@ -1364,6 +1365,14 @@ static int record__open(struct record *rec)
>  
>  	session->evlist = evlist;
>  	perf_session__set_id_hdr_size(session);
> +
> +	evlist__for_each_entry(evlist, pos) {
> +		if (list_empty(&pos->bpf_filters))
> +			continue;
> +		rc = perf_bpf_filter__prepare(pos);
> +		if (rc)
> +			break;
> +	}

might fit better under evlist__apply_filters ?

jirka

>  out:
>  	return rc;
>  }
> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> index eeee899fcf34..0414385794ee 100644
> --- a/tools/perf/util/bpf_counter.c
> +++ b/tools/perf/util/bpf_counter.c
> @@ -781,8 +781,7 @@ extern struct bpf_counter_ops bperf_cgrp_ops;
>  
>  static inline bool bpf_counter_skip(struct evsel *evsel)
>  {
> -	return list_empty(&evsel->bpf_counter_list) &&
> -		evsel->follower_skel == NULL;
> +	return evsel->bpf_counter_ops == NULL;
>  }
>  

SNIP
