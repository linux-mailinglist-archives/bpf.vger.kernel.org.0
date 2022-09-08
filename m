Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0BA5B25C7
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 20:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiIHSb2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 14:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiIHSb1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 14:31:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77FA74BAE;
        Thu,  8 Sep 2022 11:31:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 701F161DE1;
        Thu,  8 Sep 2022 18:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9EFBC433D6;
        Thu,  8 Sep 2022 18:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662661885;
        bh=pwiS6dxc4KyhjhtcsKVTP/Sq/be3I4Y28Qt1YVLE2zA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZZKPXlPt65enO3t/+8wobhXq8Rebtsjiw0UxB9PA+OwPCW9zOPne9ygTXi+6IBlFx
         nU6CQEeZW3c7lyl2UQ7YJB2e7F13d6HRrhH3V9AxxLUVy1yWKWTQyBFKo+8/Sve31x
         9DWPJqNX5wAmPcnTdxfuwTwtb/bQlGZ8F8bU2q/mNE5ChQGuVYwo1nRCvoIsmw7YnX
         F5my9C8bkkgiKhmAY7K8K2siA0FJJUnIo9lft8XS6qtTNYCxk+Bx+xceREcoPS1TXm
         V6bnF4iuWW6ALw5FRqiTcgNbbL1+xMrcihvsna+jcLUpjn2Ir9w/q+/aLtjDLPur3a
         3etG12xvDLP2g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0D6BB404A1; Thu,  8 Sep 2022 15:31:23 -0300 (-03)
Date:   Thu, 8 Sep 2022 15:31:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        Marco Elver <elver@google.com>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH v2] perf test: Skip sigtrap test on old kernels
Message-ID: <Yxo0+gYh+e2Ssfk+@kernel.org>
References: <20220907050407.2711513-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907050407.2711513-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Sep 06, 2022 at 10:04:07PM -0700, Namhyung Kim escreveu:
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

Cool, at some point we'll probably move this to some other global place,
doing the lazy loading and keeping it in place as probably we'll use it
more often :-)

Waiting for v2.

Thanks for working on this.

- Arnaldo

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

-- 

- Arnaldo
