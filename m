Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2485064491E
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 17:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiLFQXv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 11:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiLFQXu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 11:23:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265AECE22;
        Tue,  6 Dec 2022 08:23:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5BCE617D4;
        Tue,  6 Dec 2022 16:23:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72F2C433D6;
        Tue,  6 Dec 2022 16:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670343829;
        bh=ad2lDY343TkFcWm5TqcqRjN3pJz83g/1a8BC4bGnAAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xp8z5kv0ju5bSohNsyOhDhwmxRGwI82eDsPE2xrTJSB7nziBMdGe3aT3Mu1uAFbEZ
         ZyBeZNfB5IbtsRK2YMgxmJLg9p44Y23TPp9cFkGgX1CtGXBf9VmoJZsp/uknivFtFV
         u/eeE5bjGXSNUtzp0RvyCZbudYVtAl6j0i4rv2oeEYGKOxA4EvDadZhvVvi4CEyH88
         LD3w0dv2FCwtNaPZzG+UiDFqQw7UETEv87W+Rdj7k/6ECNs0/RJqJhlVL3CXhTY/Ig
         h+I9l+Xh9xRvBJV3VgCayC+1GyglQSm/1AdGjvEX76uMHq2heXdLMXXvPMZivCIwa+
         +OZlP3Sru+tiQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2F4F240404; Tue,  6 Dec 2022 13:23:45 -0300 (-03)
Date:   Tue, 6 Dec 2022 13:23:45 -0300
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
Message-ID: <Y49skYa5VYPMU+RF@kernel.org>
References: <20221205225940.3079667-1-irogers@google.com>
 <20221205225940.3079667-3-irogers@google.com>
 <Y49qiCIiyaehEOaG@kernel.org>
 <Y49rvLO2RnJBBNL/@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y49rvLO2RnJBBNL/@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Dec 06, 2022 at 01:20:12PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Dec 06, 2022 at 01:15:04PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Dec 05, 2022 at 02:59:39PM -0800, Ian Rogers escreveu:
> > > Remove the LIBTRACEEVENT_DYNAMIC and LIBTRACEFS_DYNAMIC. If
> > > libtraceevent isn't installed or NO_LIBTRACEEVENT=1 is passed to the
> > > build, don't compile in libtraceevent and libtracefs support. This
> > > also disables CONFIG_TRACE that controls "perf
> > > trace". CONFIG_TRACEEVENT is used to control enablement in
> > > Build/Makefiles, HAVE_LIBTRACEEVENT is used in C code. Without
> > > HAVE_LIBTRACEEVENT tracepoints are disabled and as such the commands
> > > kmem, kwork, lock, sched and timechart are removed. The majority of
> > > commands continue to work including "perf test".
> > 
> > Had just this .rej and I fixed it up manually, testing now:
> 
> Investigating:
> 
> [acme@quaco perf]$ rpm -q libtraceevent-devel
> libtraceevent-devel-1.5.3-2.fc36.x86_64
> [acme@quaco perf]$
> [acme@quaco perf]$ grep -i traceevent /tmp/build/perf/FEATURE-DUMP
> feature-libtraceevent=1
> [acme@quaco perf]$
> 
> [acme@quaco perf]$ alias m
> alias m='rm -rf ~/libexec/perf-core/ ; perf stat -e cycles:u,instructions:u make -k BUILD_BPF_SKEL=1 O=/tmp/build/perf -C tools/perf install-bin && perf test python'
> [acme@quaco perf]$
> 
> [acme@quaco perf]$ rpm -ql libtraceevent-devel | grep \.h$ | xargs grep tep_print_flag_sym
> /usr/include/traceevent/event-parse.h:struct tep_print_flag_sym {
> /usr/include/traceevent/event-parse.h:	struct tep_print_flag_sym	*next;
> /usr/include/traceevent/event-parse.h:	struct tep_print_flag_sym	*flags;
> /usr/include/traceevent/event-parse.h:	struct tep_print_flag_sym	*symbols;
> [acme@quaco perf]$
> 
> util/scripting-engines/trace-event-perl.c:104:43: error: ‘struct tep_print_flag_sym’ declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
>   104 | static void define_symbolic_values(struct tep_print_flag_sym *field,
>       |                                           ^~~~~~~~~~~~~~~~~~
> util/scripting-engines/trace-event-perl.c: In function ‘define_symbolic_values’:

This cured it, folding into your patch:

diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index 5b602b6d46854133..0bacb49408f84adf 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -27,6 +27,7 @@
 #include <errno.h>
 #include <linux/bitmap.h>
 #include <linux/time64.h>
+#include <traceevent/event-parse.h>
 
 #include <stdbool.h>
 /* perl needs the following define, right after including stdbool.h */
