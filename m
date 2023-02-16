Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1E6699A0F
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 17:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBPQcV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 11:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBPQcV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 11:32:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E53497C5;
        Thu, 16 Feb 2023 08:32:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02CCFB828F1;
        Thu, 16 Feb 2023 16:32:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF25C4339B;
        Thu, 16 Feb 2023 16:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676565137;
        bh=SdwRkhrTgubITR7LoCM6csaPxtac6AqTfrJPOaGWVhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b/AkaUzY0WWVwUsfam89eFtAVf1NtUzY+2bUUaZrtsvy4XoU4uiXer3PvSR6fCb2N
         jIMEbInkfRRa3cd2H1b+mkJYY98iDcVsOXbLxR21MJIrL4RTt/X6ko1ox0NH3fHKDh
         xhqisNdrfdxjLXwEaKguQ9FeyZGciXgiQ/JAmX1/RrQST2OqnkHNOMXTXV86m5b2t5
         hbO3W4nHK1MsQxP0Cnc7Aw/h2hYkxpKXjQavQIse4AOCBUusmmVhSwGrHeXcXxe68h
         IjE/O1S8XxsrR9rQqBGoBBrY+EQH3pX/0tQOXxdrwrMZDRsBMno2ds4pL/crve35W1
         c+bzBr8LtOhBw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C91AD40025; Thu, 16 Feb 2023 13:32:14 -0300 (-03)
Date:   Thu, 16 Feb 2023 13:32:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
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
Message-ID: <Y+5ajnitOAxjdn2C@kernel.org>
References: <20230214050452.26390-1-namhyung@kernel.org>
 <20230214050452.26390-5-namhyung@kernel.org>
 <Y+5YaQt7Fme65a78@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+5YaQt7Fme65a78@krava>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Feb 16, 2023 at 05:23:05PM +0100, Jiri Olsa escreveu:
> On Mon, Feb 13, 2023 at 09:04:49PM -0800, Namhyung Kim wrote:
> 
> SNIP
> 
> > @@ -1929,12 +1923,27 @@ static void record__read_lost_samples(struct record *rec)
> >  
> >  		for (int x = 0; x < xyarray__max_x(xy); x++) {
> >  			for (int y = 0; y < xyarray__max_y(xy); y++) {
> > -				__record__read_lost_samples(rec, evsel, lost, x, y);
> > +				struct perf_counts_values count;
> > +
> > +				if (perf_evsel__read(&evsel->core, x, y, &count) < 0) {
> > +					pr_err("read LOST count failed\n");
> > +					goto out;
> > +				}
> > +
> > +				if (count.lost) {
> > +					__record__save_lost_samples(rec, evsel, lost,
> > +								    x, y, count.lost, 0);
> > +				}
> >  			}
> >  		}
> > +
> > +		lost_count = perf_bpf_filter__lost_count(evsel);
> > +		if (lost_count)
> > +			__record__save_lost_samples(rec, evsel, lost, 0, 0, lost_count,
> > +						    PERF_RECORD_MISC_LOST_SAMPLES_BPF);
> 
> hi,
> I can't see PERF_RECORD_MISC_LOST_SAMPLES_BPF in the tip/perf/core so can't compile,
> what do I miss?

Humm, but you shouldn't need kernel headers to build tools/perf/, right?

- Arnaldo
