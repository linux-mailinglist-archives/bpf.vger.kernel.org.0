Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DD0644936
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 17:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbiLFQam (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 11:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbiLFQal (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 11:30:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B22BC99;
        Tue,  6 Dec 2022 08:30:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94E69B81AB4;
        Tue,  6 Dec 2022 16:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF38C433D6;
        Tue,  6 Dec 2022 16:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670344237;
        bh=uSs6ZfsXTI/wj4FOJ5tx7pLbTvH5TLILgvDFOd+upCk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jpTEBnQ4ijo+hjdHrhyL5S4f3BbTcxVAHDyIGBS4hFyi57RZBNDTT65FzCS4ywwX+
         6/WF1iLkxyjCQZi4hvXM0mewXlUMLtlF8VFLHb5G1qSCq29ORVnifXEjtAmFK60Ocd
         TvcMQbVlDmMWEf9Ddj6XLjtSQh6SwE7QJHfssCDvfHDxWtZpgwMJ4kvnSUUMGYJ7R0
         RL3dU19QCDbwoVZ8e4o3Kga1ApFXz5pbJFDNfYyH2lTdZLPWnLA/YVlgIhnC3osAZ7
         wuasijiyF1xWX3J1TK29Qe/erQADZSYnzvauGbcRW8ZY/Vh240lMhCk9ghz0A7czbf
         kjfnblnZyFTqw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 91D9740404; Tue,  6 Dec 2022 13:30:33 -0300 (-03)
Date:   Tue, 6 Dec 2022 13:30:33 -0300
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
Message-ID: <Y49uKfzfCoZ1ok62@kernel.org>
References: <20221205225940.3079667-1-irogers@google.com>
 <20221205225940.3079667-3-irogers@google.com>
 <Y49qiCIiyaehEOaG@kernel.org>
 <Y49rvLO2RnJBBNL/@kernel.org>
 <Y49skYa5VYPMU+RF@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y49skYa5VYPMU+RF@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Dec 06, 2022 at 01:23:45PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Dec 06, 2022 at 01:20:12PM -0300, Arnaldo Carvalho de Melo escreveu:
> > 
> > util/scripting-engines/trace-event-perl.c:104:43: error: ‘struct tep_print_flag_sym’ declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
> >   104 | static void define_symbolic_values(struct tep_print_flag_sym *field,
> >       |                                           ^~~~~~~~~~~~~~~~~~
> > util/scripting-engines/trace-event-perl.c: In function ‘define_symbolic_values’:
> 
> This cured it, folding into your patch:
> 
> diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
> index 5b602b6d46854133..0bacb49408f84adf 100644
> --- a/tools/perf/util/scripting-engines/trace-event-perl.c
> +++ b/tools/perf/util/scripting-engines/trace-event-perl.c
> @@ -27,6 +27,7 @@
>  #include <errno.h>
>  #include <linux/bitmap.h>
>  #include <linux/time64.h>
> +#include <traceevent/event-parse.h>
>  
>  #include <stdbool.h>
>  /* perl needs the following define, right after including stdbool.h */

Building with NO_LIBTRACEEVENT=1 I get:

  CC      /tmp/build/perf/util/cap.o
util/data-convert-bt.c: In function ‘get_tracepoint_field_type’:
util/data-convert-bt.c:194:36: error: invalid use of undefined type ‘struct tep_format_field’
  194 |         unsigned long flags = field->flags;
      |                                    ^~
util/data-convert-bt.c:196:21: error: ‘TEP_FIELD_IS_STRING’ undeclared (first use in this function)
  196 |         if (flags & TEP_FIELD_IS_STRING)
      |                     ^~~~~~~~~~~~~~~~~~~
util/data-convert-bt.c:196:21: note: each undeclared identifier is reported only once for each function it appears in
util/data-convert-bt.c:199:23: error: ‘TEP_FIELD_IS_SIGNED’ undeclared (first use in this function)
  199 |         if (!(flags & TEP_FIELD_IS_SIGNED)) {
      |                       ^~~~~~~~~~~~~~~~~~~
util/data-convert-bt.c:201:29: error: ‘TEP_FIELD_IS_LONG’ undeclared (first use in this function)
  201 |                 if (flags & TEP_FIELD_IS_LONG || flags & TEP_FIELD_IS_POINTER)
      |                             ^~~~~~~~~~~~~~~~~


working on it...
