Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F43364A832
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 20:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbiLLTnt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 14:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbiLLTns (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 14:43:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B481AE5A;
        Mon, 12 Dec 2022 11:43:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3040061055;
        Mon, 12 Dec 2022 19:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A64C433EF;
        Mon, 12 Dec 2022 19:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670874226;
        bh=rD36OgSW9nxOVIDEi7MSFw/sLfTp84WYYyv0K7cklcQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bgajqwJOlplNaipjV8m6W8OK44uOLMLh3nYh79M9UKhQb0uPulUcjNd3HEuF7kXye
         bzOmjadA9C0B+btU2bfyLcXO4/nPI2/Fjdhh9bfzidK7JtAbrUhQmO3N28icE1/btn
         QfydXLLV9kaJGvxC9Lvei5SYFkAb2AOSVzIqg4gwh01v7RoT+krtXsLUpzjjm2/Vrk
         D3sAIn2YVFNN9ufZeNrRZNP8Mh9pLlGyJNlhRKmFCpagTFfqoLAvvuqwg7huwUVlBt
         9kfcKo6xqJZw47PG4Pl4NXS8sdWET8jRsAgRtLUbzCb9usANFH+nHmPdeBo0bEOev5
         KGJ84Mrlg8s4Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C4F8740483; Mon, 12 Dec 2022 16:43:43 -0300 (-03)
Date:   Mon, 12 Dec 2022 16:43:43 -0300
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
Message-ID: <Y5eEbxVOHaUPw9UI@kernel.org>
References: <20221209190727.759804-1-namhyung@kernel.org>
 <20221209190727.759804-2-namhyung@kernel.org>
 <Y5eEJd/AhSzUfILO@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y5eEJd/AhSzUfILO@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Dec 12, 2022 at 04:42:30PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Dec 09, 2022 at 11:07:24AM -0800, Namhyung Kim escreveu:
> > Accessing BPF maps should use the same data types.  Add bpf_skel/lock_data.h
> > to define the common data structures.  No functional changes.
> 
> You forgot to update one of the stack_id users, that field got renamed:
> 
> util/bpf_skel/lock_contention.bpf.c:144:6: error: no member named 'stack_id' in 'struct contention_key'
>         key.stack_id = pelem->stack_id;
>         ~~~ ^
> 1 error generated.
> make[2]: *** [Makefile.perf:1075: /tmp/build/perf/util/bpf_skel/.tmp/lock_contention.bpf.o] Error 1
> make[1]: *** [Makefile.perf:236: sub-make] Error 2
> make: *** [Makefile:113: install-bin] Error 2
> make: Leaving directory '/var/home/acme/git/perf/tools/perf'
> 
>  Performance counter stats for 'make -k NO_LIBTRACEEVENT=1 BUILD_BPF_SKEL=1 CORESIGHT=1 O=/tmp/build/perf -C tools/perf install-bin':
> 
>      7,005,216,342      cycles:u
>     11,851,225,594      instructions:u                   #    1.69  insn per cycle
> 
>        3.168945139 seconds time elapsed
> 
>        1.730964000 seconds user
>        1.578932000 seconds sys
> 
> 
> ⬢[acme@toolbox perf]$ git log --oneline -4
> f6e7a5f1db49dc8e (HEAD) perf lock contention: Add lock_data.h for common data
> 5d9b55713c5c037f perf python: Account for multiple words in CC
> d9078bf3f3320457 perf off_cpu: Fix a typo in BTF tracepoint name, it should be 'btf_trace_sched_switch'
> 3b7ea76f0f7844f5 perf test: Update event group check for support of uncore event
> ⬢[acme@toolbox perf]$
> 
> After some point it builds.
> 
> I'm fixing this to keep it bisectable.

I folded this:


diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 0f63cc28ccbabd21..64fd1e040ac86e58 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -141,7 +141,7 @@ int contention_end(u64 *ctx)
 
 	duration = bpf_ktime_get_ns() - pelem->timestamp;
 
-	key.stack_id = pelem->stack_id;
+	key.stack_or_task_id = pelem->stack_id;
 	data = bpf_map_lookup_elem(&lock_stat, &key);
 	if (!data) {
 		struct contention_data first = {
