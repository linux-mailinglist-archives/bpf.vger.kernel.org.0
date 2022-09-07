Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE955AFF0B
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 10:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiIGIcu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 04:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiIGIct (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 04:32:49 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B7F9DB69;
        Wed,  7 Sep 2022 01:32:48 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id kg20so1887750ejc.12;
        Wed, 07 Sep 2022 01:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=oNhXNN48XioBo9TdpjvtJUsMY1FigZdVdgZ98bYIOdo=;
        b=nJpwq+gHDtRIMVL7mDIoX+pB/1iJhaSnYn1uo5g1bEu7GAqi6bpDVsjAMHOJVEdP/R
         +3NebSOUiO9iKD4vNfY5x3wyrzNe28ZAh8oJskQkw/l9ctk4a/dFVLXIAPPAzrZT6l6I
         Jc9ND3UyiyYlFdClN3bM6iBLqGXI0BOSERUK9X1pmO0NoldME0Y7Xj4Fy26ZyCfvDC+B
         R+xMIjsoRPx1dvcj9IBa1C+OYk2lirivddKGLuo9XPYdVlL6gmRbIqvqfrBqwhmTY8Td
         nE3V6kz3eBIVRr7dfkPeI8cgZMIldBoiuD8WcVWi2hGRoaLXvTQY7rpuOUBWQpywcwpy
         X/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=oNhXNN48XioBo9TdpjvtJUsMY1FigZdVdgZ98bYIOdo=;
        b=WbHvUrCiVd0r0ND8KJWhKu9zWgQ+SFHKP3+yJj5mlPBrFUKScxLs1uMYKALK4qBvBo
         VhH8T2S3QvyfzMv4NRMEUCH3k3J15nUiW9ekkj4Co+vZPsYQ80QIrI0oyyBpMkNih4Yk
         Rbqjsvmb2NdXr9en/0VwLPQp20w2RhKQNoCrHX3Ucf8w9YNjoKNmx/r0jo7B18YBmzgk
         82cTlSM2IEe39vFywsD8AW8AkKjVxl03NAR5r0SeGV3b4eInt68zww4ikp7MFT4V95Zo
         pg3Ue2KzBZw2EB7XfBnjQD4hsxb80b7GELuGvHfWSF7kdUwGKYADqxkyXmD8fllVK09d
         r4Wg==
X-Gm-Message-State: ACgBeo3JGdY4i/TKzEUDwuiQ+8McehkYT9TPedCX1Ap05H+dNg0V6BAi
        CPl4GD+rmbnE2g8hD4bppBH5/R0+QqemXw==
X-Google-Smtp-Source: AA6agR5hBOqvhHEtaFtI2wOJZEnn984q0gfddLB8+6YLPEd1/t+okY9dufrbE8bpiQjtZshI6K4IMw==
X-Received: by 2002:a17:906:847c:b0:73f:d7cf:bf2d with SMTP id hx28-20020a170906847c00b0073fd7cfbf2dmr1591785ejc.327.1662539567297;
        Wed, 07 Sep 2022 01:32:47 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id i10-20020a170906264a00b0073cf8e0355fsm7750137ejc.208.2022.09.07.01.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 01:32:47 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 7 Sep 2022 10:32:45 +0200
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        Marco Elver <elver@google.com>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH v2] perf test: Skip sigtrap test on old kernels
Message-ID: <YxhXLQ9aOuLRLrAJ@krava>
References: <20220907050407.2711513-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907050407.2711513-1-namhyung@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 06, 2022 at 10:04:07PM -0700, Namhyung Kim wrote:
> If it runs on an old kernel, perf_event_open would fail because of the
> new fields sigtrap and sig_data.  Just skipping the test could miss an
> actual bug in the kernel.
> 
> Let's check BTF if it has the perf_event_attr.sigtrap field.
> 
> Cc: Marco Elver <elver@google.com>
> Cc: Song Liu <songliubraving@fb.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/sigtrap.c | 46 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
> index e32ece90e164..32f08ce0f2b0 100644
> --- a/tools/perf/tests/sigtrap.c
> +++ b/tools/perf/tests/sigtrap.c
> @@ -16,6 +16,8 @@
>  #include <sys/syscall.h>
>  #include <unistd.h>
>  
> +#include <bpf/btf.h>
> +
>  #include "cloexec.h"
>  #include "debug.h"
>  #include "event.h"
> @@ -54,6 +56,42 @@ static struct perf_event_attr make_event_attr(void)
>  	return attr;
>  }
>  
> +static bool attr_has_sigtrap(void)
> +{
> +	bool ret = false;
> +
> +#ifdef HAVE_BPF_SKEL
> +
> +	struct btf *btf;
> +	const struct btf_type *t;
> +	const struct btf_member *m;
> +	const char *name;
> +	int i, id;
> +
> +	/* just assume it doesn't have the field */
> +	btf = btf__load_vmlinux_btf();
> +	if (btf == NULL)
> +		return false;
> +
> +	id = btf__find_by_name_kind(btf, "perf_event_attr", BTF_KIND_STRUCT);
> +	if (id < 0)
> +		goto out;
> +
> +	t = btf__type_by_id(btf, id);
> +	for (i = 0, m = btf_members(t); i < btf_vlen(t); i++, m++) {
> +		name = btf__name_by_offset(btf, m->name_off);
> +		if (!strcmp(name, "sigtrap")) {
> +			ret = true;
> +			break;
> +		}
> +	}
> +out:
> +	btf__free(btf);
> +#endif

would it be easier to call perf_event_open for simple event with
sigtrap set (and perhaps remove_on_exec) ? perf_copy_attr checks
on reserved fields

jirka


> +
> +	return ret;
> +}
> +
>  static void
>  sigtrap_handler(int signum __maybe_unused, siginfo_t *info, void *ucontext __maybe_unused)
>  {
> @@ -139,7 +177,13 @@ static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __m
>  
>  	fd = sys_perf_event_open(&attr, 0, -1, -1, perf_event_open_cloexec_flag());
>  	if (fd < 0) {
> -		pr_debug("FAILED sys_perf_event_open(): %s\n", str_error_r(errno, sbuf, sizeof(sbuf)));
> +		if (attr_has_sigtrap()) {
> +			pr_debug("FAILED sys_perf_event_open(): %s\n",
> +				 str_error_r(errno, sbuf, sizeof(sbuf)));
> +		} else {
> +			pr_debug("perf_event_attr doesn't have sigtrap\n");
> +			ret = TEST_SKIP;
> +		}
>  		goto out_restore_sigaction;
>  	}
>  
> -- 
> 2.37.2.789.g6183377224-goog
> 
