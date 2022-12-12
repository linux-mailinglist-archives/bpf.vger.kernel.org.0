Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E9B64A835
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 20:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbiLLTpk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 14:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbiLLTpk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 14:45:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030AC11461;
        Mon, 12 Dec 2022 11:45:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC50BB80E05;
        Mon, 12 Dec 2022 19:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49ED6C433F0;
        Mon, 12 Dec 2022 19:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670874336;
        bh=OsDBLlHaZh13anyxhYD8NWH+ASlzd43Kdbc8VEY6kgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PPNgg+ZpfBQhDSGzOEF/xH907Odul1VKVZcbcGZio+XiCH7k1F2wKUjPpHrhyoEgH
         Nwy01EYCZqKppsWdKRSn++8Lhi10gDRv+4wQxaatkpD+FQFWUNCgLe/tVCNovjnH+p
         jiH82WCfCVgl79QCOFcMDMGApTtia5EjQ9VQJ9mLLvhei8v7w5z7/APVZRKNE4kl06
         kEo5IpGsErdcKNNnzPv+oCZBW/x0VYcgdBsv7IzEl5/5tgTO7EXWpbPGgWGSsLxYQX
         tPdnmkvHJqlnHreRyh7yiUZBmh+6Bl6h6q1f3IaJJY1whDZPaIuNf/7gKevlZ7yj6r
         p/oGLUDhqQAhw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C3E5140483; Mon, 12 Dec 2022 16:45:33 -0300 (-03)
Date:   Mon, 12 Dec 2022 16:45:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Blake Jones <blakejones@google.com>, bpf@vger.kernel.org
Subject: Re: [PATCH 1/4] perf lock contention: Add lock_data.h for common data
Message-ID: <Y5eE3Udv03uM4zhQ@kernel.org>
References: <20221209190727.759804-1-namhyung@kernel.org>
 <20221209190727.759804-2-namhyung@kernel.org>
 <Y5eEJd/AhSzUfILO@kernel.org>
 <Y5eEbxVOHaUPw9UI@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y5eEbxVOHaUPw9UI@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Dec 12, 2022 at 04:43:43PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Dec 12, 2022 at 04:42:30PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Dec 09, 2022 at 11:07:24AM -0800, Namhyung Kim escreveu:
> > > Accessing BPF maps should use the same data types.  Add bpf_skel/lock_data.h
> > > to define the common data structures.  No functional changes.
> > 
> > You forgot to update one of the stack_id users, that field got renamed:
> > 
> > util/bpf_skel/lock_contention.bpf.c:144:6: error: no member named 'stack_id' in 'struct contention_key'
> >         key.stack_id = pelem->stack_id;
> >         ~~~ ^
> > 1 error generated.
> > make[2]: *** [Makefile.perf:1075: /tmp/build/perf/util/bpf_skel/.tmp/lock_contention.bpf.o] Error 1
> > make[1]: *** [Makefile.perf:236: sub-make] Error 2
> > make: *** [Makefile:113: install-bin] Error 2
> > make: Leaving directory '/var/home/acme/git/perf/tools/perf'
> > 
> >  Performance counter stats for 'make -k NO_LIBTRACEEVENT=1 BUILD_BPF_SKEL=1 CORESIGHT=1 O=/tmp/build/perf -C tools/perf install-bin':
> > 
> >      7,005,216,342      cycles:u
> >     11,851,225,594      instructions:u                   #    1.69  insn per cycle
> > 
> >        3.168945139 seconds time elapsed
> > 
> >        1.730964000 seconds user
> >        1.578932000 seconds sys
> > 
> > 
> > ⬢[acme@toolbox perf]$ git log --oneline -4
> > f6e7a5f1db49dc8e (HEAD) perf lock contention: Add lock_data.h for common data
> > 5d9b55713c5c037f perf python: Account for multiple words in CC
> > d9078bf3f3320457 perf off_cpu: Fix a typo in BTF tracepoint name, it should be 'btf_trace_sched_switch'
> > 3b7ea76f0f7844f5 perf test: Update event group check for support of uncore event
> > ⬢[acme@toolbox perf]$
> > 
> > After some point it builds.
> > 
> > I'm fixing this to keep it bisectable.
> 
> I folded this:
> 
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> index 0f63cc28ccbabd21..64fd1e040ac86e58 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -141,7 +141,7 @@ int contention_end(u64 *ctx)
>  
>  	duration = bpf_ktime_get_ns() - pelem->timestamp;
>  
> -	key.stack_id = pelem->stack_id;
> +	key.stack_or_task_id = pelem->stack_id;
>  	data = bpf_map_lookup_elem(&lock_stat, &key);
>  	if (!data) {
>  		struct contention_data first = {


And then fixed up this:

Could not apply 3d4947c7bd10beba... perf lock contention: Implement -t/--threads option for BPF
⬢[acme@toolbox perf]$
⬢[acme@toolbox perf]$
⬢[acme@toolbox perf]$ git diff
diff --cc tools/perf/util/bpf_skel/lock_contention.bpf.c
index 64fd1e040ac86e58,cd405adcd252b82d..0000000000000000
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@@ -141,7 -168,13 +168,17 @@@ int contention_end(u64 *ctx

        duration = bpf_ktime_get_ns() - pelem->timestamp;

++<<<<<<< HEAD
 +      key.stack_or_task_id = pelem->stack_id;
++=======
+       if (aggr_mode == LOCK_AGGR_CALLER) {
+               key.stack_or_task_id = pelem->stack_id;
+       } else {
+               key.stack_or_task_id = pid;
+               update_task_data(pid);
+       }
+
++>>>>>>> 3d4947c7bd10beba (perf lock contention: Implement -t/--threads option for BPF)
