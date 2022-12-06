Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F3F644991
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 17:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbiLFQmf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 11:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbiLFQmP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 11:42:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BFBB78;
        Tue,  6 Dec 2022 08:41:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 816EBB81ABD;
        Tue,  6 Dec 2022 16:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9DCC433D6;
        Tue,  6 Dec 2022 16:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670344906;
        bh=HlJQ4eRLfHR8dcnECvHx7rGMnpL4KimybsIhObUDC7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jXpeduI7LCovVll8PwL/gLrOS2eN1DjDCe0jf5vtUyTVY9qOOsNtzh33daVEpZX5Q
         5iolGtOFw1uyf9+q+XhGGv8BRD33+w2l97pC0H8PrhJk4lBVkfCvDDGuYwG82sjBKh
         Ad7gxNZLgUlaoXw2tqe/Yf5V6XxBZkqAcYKT71GXuj5nf1t2cVqt6MxR2FbIrCG80W
         iwysDDPf+xdA45P62zDvkXNqgV+OcMUmfv0mI4QVs1q0bw4AXtUg4vNzok4Ba8Vgwx
         dKhI4bi6W+4R4BvzWtFQEde4zuVzI5MciN093XgUCX0kFR7TorZma9PrfM5yGluhfJ
         ve0OjwVkfWAXQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id ED43640404; Tue,  6 Dec 2022 13:41:41 -0300 (-03)
Date:   Tue, 6 Dec 2022 13:41:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 2/3] perf build: Use libtraceevent from the system
Message-ID: <Y49wxSIK7dJ7iTDg@kernel.org>
References: <20221205225940.3079667-1-irogers@google.com>
 <20221205225940.3079667-3-irogers@google.com>
 <Y49qiCIiyaehEOaG@kernel.org>
 <Y49rvLO2RnJBBNL/@kernel.org>
 <Y49skYa5VYPMU+RF@kernel.org>
 <Y49uKfzfCoZ1ok62@kernel.org>
 <Y49vx0v6Z7EiR8jr@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y49vx0v6Z7EiR8jr@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Dec 06, 2022 at 01:37:27PM -0300, Arnaldo Carvalho de Melo escreveu:
> 
> Below makes it progress a bit, now to look at the perl Context stuff.
> 

Add this to the mix:

diff --git a/tools/perf/Build b/tools/perf/Build
index edafe3cb3d075f00..c11ac63be7f755df 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -52,7 +52,7 @@ CFLAGS_builtin-report.o          += -DDOCDIR="BUILD_STR($(srcdir_SQ)/Documentation)"
 perf-y += util/
 perf-y += arch/
 perf-y += ui/
-perf-y += scripts/
+perf-$(CONFIG_TRACEEVENT) += scripts/
 perf-$(CONFIG_TRACE) += trace/beauty/

 gtk-y += ui/gtk/


 Now to look at the BUILD_BPF_SKEL=1 kaboom:

 [acme@quaco perf]$ alias m
alias m='rm -rf ~/libexec/perf-core/ ; make -k NO_LIBTRACEEVENT=1 BUILD_BPF_SKEL=1 O=/tmp/build/perf -C tools/perf install-bin && perf test python'
[acme@quaco perf]$ m
make: Entering directory '/home/acme/git/perf/tools/perf'
  BUILD:   Doing 'make -j8' parallel build
  <SNIP>
/usr/bin/ld: /tmp/build/perf/perf-in.o: in function `add_work':
/home/acme/git/perf/tools/perf/util/bpf_kwork.c:285: undefined reference to `perf_kwork_add_work'
/usr/bin/ld: /tmp/build/perf/perf-in.o: in function `lock_contention_read':
/home/acme/git/perf/tools/perf/util/bpf_lock_contention.c:156: undefined reference to `is_lock_function'
collect2: error: ld returned 1 exit status
make[2]: *** [Makefile.perf:674: /tmp/build/perf/perf] Error 1
make[1]: *** [Makefile.perf:236: sub-make] Error 2
make: *** [Makefile:113: install-bin] Error 2
make: Leaving directory '/home/acme/git/perf/tools/perf'
[acme@quaco perf]$
