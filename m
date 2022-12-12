Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0484A64A456
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 16:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbiLLPmo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 10:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiLLPmn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 10:42:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C8F1147;
        Mon, 12 Dec 2022 07:42:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5811C6112A;
        Mon, 12 Dec 2022 15:42:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854C0C433D2;
        Mon, 12 Dec 2022 15:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670859761;
        bh=vovF8+lwpmqjcYvzWQBwv2dfMuOKmPzkgOcqouX8qGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FTFsxWU2/KmSno5Nw0I1Te9qQe9dolWOvNMd6hQicz124DxVJsXyWlaostfLYiNiK
         Y7dFcX7IitR3UqSK+KXwuNTGdvuoORAXPITyjTD1yV6EHdsbDMgTYV221Js8FsQ+Oq
         XRZWaTwGAJEc7pfKFGYkro0/WAjgav5Q/d5MSCA6ANESxx/J2bfBYJ02QkewlcWGyS
         At/XnGVg8eApjY+u9w1Kn2DCk6dW8gKcweCowINp+5JCUkKABOzX3gCKi4hcASvg5e
         CtCHzhZ+Ra09gTjhav+Z/O9wMq+JHHLP8wPSSvp5c60DkDMqM6E1UN03f4BdcZS4ve
         PtSgnAuxig+ng==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 10C0540483; Mon, 12 Dec 2022 12:42:39 -0300 (-03)
Date:   Mon, 12 Dec 2022 12:42:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        bpf@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix a typo in BTF tracepoint name
Message-ID: <Y5dL77VtV4MZ2AkG@kernel.org>
References: <20221208182636.524139-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208182636.524139-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Dec 08, 2022 at 10:26:36AM -0800, Namhyung Kim escreveu:
> In the BTF, tracepoint definitions have the prefix of "btf_trace_".
> The off-cpu profilier needs to check the signature of sched_switch
> event using the definition.  But there's a typo (s/bpf/btf/) so it
> failed always.

Thanks, applied.

- Arnaldo

 
> Fixes: b36888f71c85 ("perf record: Handle argument change in sched_switch")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/bpf_off_cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
> index c257813e674e..01f70b8e705a 100644
> --- a/tools/perf/util/bpf_off_cpu.c
> +++ b/tools/perf/util/bpf_off_cpu.c
> @@ -102,7 +102,7 @@ static void check_sched_switch_args(void)
>  	const struct btf_type *t1, *t2, *t3;
>  	u32 type_id;
>  
> -	type_id = btf__find_by_name_kind(btf, "bpf_trace_sched_switch",
> +	type_id = btf__find_by_name_kind(btf, "btf_trace_sched_switch",
>  					 BTF_KIND_TYPEDEF);
>  	if ((s32)type_id < 0)
>  		return;
> -- 
> 2.39.0.rc1.256.g54fd8350bd-goog

-- 

- Arnaldo
