Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54106ADFED
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 14:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjCGNGc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 08:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjCGNFm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 08:05:42 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA617B4AF;
        Tue,  7 Mar 2023 05:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678194312; x=1709730312;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=+vbr9rIbJSDX3OWKNxWC1uREEyrLtgxy3MbKqbQOSmw=;
  b=RxwID/qXgqFBG3h3s6ltc784XbhtVO7n3tI0j81Xx8bnGBkUsdh+OE0l
   99rv1RCCPOHN5aJpsN9EZ21V8UWjJ1IFtoM60NvyLLbBPDT3B/LNuIVMS
   a92ACILumrwEMLoZMB/gBfStZJXPrRnH47c982B/s5gLAc12Rs3s5Erjv
   l7fJRhEs/7fCSPtUMa4yOPqOvFLULKypaShYSBTxKsbjy/rqO3RUeBP/A
   wRqmEwKiGXMy5uOgABP6KWf+v1C4lQ8FLBAfRicutZiX2hSLNolDBxxl7
   5WykN1XuGcqOGuAhqaogTKu1dT7XiLX2D1vHFhMsdHL8tQPdzmaKwGyZ+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="400666219"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400"; 
   d="scan'208";a="400666219"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 05:03:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="800383592"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400"; 
   d="scan'208";a="800383592"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.218.236])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 05:03:23 -0800
Message-ID: <bf7a4d48-ebf5-301e-5142-e728242c8b6a@intel.com>
Date:   Tue, 7 Mar 2023 15:03:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/8] perf bpf filter: Introduce basic BPF filter
 expression
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <song@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>, Hao Luo <haoluo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
References: <20230222230141.1729048-1-namhyung@kernel.org>
 <20230222230141.1729048-2-namhyung@kernel.org>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230222230141.1729048-2-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 23/02/23 01:01, Namhyung Kim wrote:
> This implements a tiny parser for the filter expressions used for BPF.
> Each expression will be converted to struct perf_bpf_filter_expr and
> be passed to a BPF map.
> 
> For now, I'd like to start with the very basic comparisons like EQ or
> GT.  The LHS should be a term for sample data and the RHS is a number.
> The expressions are connected by a comma.  For example,
> 
>     period > 10000
>     ip < 0x1000000000000, cpu == 3
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/Build        | 16 +++++++
>  tools/perf/util/bpf-filter.c | 37 ++++++++++++++++
>  tools/perf/util/bpf-filter.h | 36 ++++++++++++++++
>  tools/perf/util/bpf-filter.l | 82 ++++++++++++++++++++++++++++++++++++
>  tools/perf/util/bpf-filter.y | 54 ++++++++++++++++++++++++
>  5 files changed, 225 insertions(+)
>  create mode 100644 tools/perf/util/bpf-filter.c
>  create mode 100644 tools/perf/util/bpf-filter.h
>  create mode 100644 tools/perf/util/bpf-filter.l
>  create mode 100644 tools/perf/util/bpf-filter.y
> 
> diff --git a/tools/perf/util/bpf-filter.h b/tools/perf/util/bpf-filter.h
> new file mode 100644
> index 000000000000..fd5b1164a322
> --- /dev/null
> +++ b/tools/perf/util/bpf-filter.h
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0

/* */ is preferred SPDX comment style for header files
