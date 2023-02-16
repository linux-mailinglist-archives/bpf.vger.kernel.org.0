Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372966999E3
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 17:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjBPQXT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 11:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjBPQXS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 11:23:18 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92ACC2CC44;
        Thu, 16 Feb 2023 08:23:09 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id r18so1950642wmq.5;
        Thu, 16 Feb 2023 08:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZaZpaZyKc2DplIs/9QVPf6ipKOfM/9KljO6oqwZ2imI=;
        b=L/sTlh0uy4R2QyLmqXlLVnobaBrICtszGn9xlRvWUhyaCVInMP43TSh72YceM4+orS
         JoZ+i5mZrt9csqigXH7aY+cjKuoi70y57271wXRMqyDKNxX/Q5CcXEc3Tc+kEqipJjTQ
         Dylv3jVXv4ca8ZwhgwMKNttRM6mejUI8UbAsYdPEJghHfOeicPG2fGP5zzP8q/DaH2Lx
         Od1rQYnMlDJ2mRLIRj3TI3+SwxF7VjbaVXq3OkrxHaprAVfQucQyGrQC9warCa1vxDN9
         plFMPUd44djjHaQjZVspdXTvP9kBXpTERV1cBbNQm+dWWUMqx07EtUtW5oRnu/EPGX02
         qGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZaZpaZyKc2DplIs/9QVPf6ipKOfM/9KljO6oqwZ2imI=;
        b=oGZm2lJOKdxrVnBymoJEdHUdwvZmuIdf7q0x5MyIiwcJVZ1dF8RypOx+NLn5PCkoWL
         3hp7u2FBnBqux2Eb10hdBxf7az3pVrFWwa44UVahNXBBsntDyYsifUtUzk5+3QT291LJ
         bNrh0NMy2a2LSzWSugobvb2Bmde2PDbdrEAYJCVrIsV7EBpYeWUaRQXltS2t068hBxMq
         Ga84O5afXb4oNnDUcbZK1Vq7rqtsxniwLbTZ1gffLi48AVcgdtyPGU2N9TjEgQSm4f6+
         Wb2Y4r/d+NZlkPUVZTt3LXg0zWd66dU2pxIfKto6P08dsv6p6Kw5YhRVuex9JNS6oppO
         eBCg==
X-Gm-Message-State: AO0yUKXAzjOUdRK2zjqEkgYEUTUhFJLJigJK0nElzcqbipVCch43NMd5
        Ax/0e7sXmilYf4JkmL6RAwE=
X-Google-Smtp-Source: AK7set/nQpY/nblha38OjKGEVdXjoIjByakGjT1uvowXoCffJrvnPsjaUPdnAFHE7e7EU6X5q97S8A==
X-Received: by 2002:a05:600c:13c3:b0:3e2:40e:9475 with SMTP id e3-20020a05600c13c300b003e2040e9475mr4838321wmg.16.1676564588129;
        Thu, 16 Feb 2023 08:23:08 -0800 (PST)
Received: from krava ([81.6.34.132])
        by smtp.gmail.com with ESMTPSA id e1-20020a05600c4e4100b003e0015c8618sm5930010wmq.6.2023.02.16.08.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 08:23:07 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 16 Feb 2023 17:23:05 +0100
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
Subject: Re: [PATCH 4/7] perf record: Record dropped sample count
Message-ID: <Y+5YaQt7Fme65a78@krava>
References: <20230214050452.26390-1-namhyung@kernel.org>
 <20230214050452.26390-5-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214050452.26390-5-namhyung@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 13, 2023 at 09:04:49PM -0800, Namhyung Kim wrote:

SNIP

> @@ -1929,12 +1923,27 @@ static void record__read_lost_samples(struct record *rec)
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

hi,
I can't see PERF_RECORD_MISC_LOST_SAMPLES_BPF in the tip/perf/core so can't compile,
what do I miss?

thanks,
jirka
