Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CB53ABC81
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 21:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbhFQTVR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 15:21:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232733AbhFQTVQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Jun 2021 15:21:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD38D613CB;
        Thu, 17 Jun 2021 19:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623957548;
        bh=dQx9GNo8/dKMJOBYJVEAPIPFPLBir1HJFwkmMUcGrcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SO3tbdxhAdZivFy698NbEheUp2ZudQaOABYU4ZKP2MLe1z/phYlne+MlwYqNLSv+W
         ebOLdYH9O6r5AsOOL0nCfyk3JagrLLLmDQ9sVudOYcXPlvdO4uVA4URstZf4+D5pK6
         sU8eqi/k8ESwhvRoOP/Y2yuMRaSzGejUlC6X+aTmfGC50Xga4oFGn9yRXkt8QzFKni
         I/NdpA/niakRQJAlzxm+aLa8WjofZ+dc+OFRU87B1FRPbKk0wfyvjdpqda7LF4/4YL
         1skpi9p5o9bnc+K2fvhQO4R3oJdF/sxMaNQP7rkZubDPLdVTCgoaqlLrm9j2bCeECd
         FAaascit5woXA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8D81840F21; Thu, 17 Jun 2021 16:19:06 -0300 (-03)
Date:   Thu, 17 Jun 2021 16:19:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH 2/4] perf test: Pass the verbose option to shell tests
Message-ID: <YMugKlkH7lTWxTQ/@kernel.org>
References: <20210617184216.2075588-1-irogers@google.com>
 <20210617184216.2075588-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617184216.2075588-2-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Jun 17, 2021 at 11:42:14AM -0700, Ian Rogers escreveu:
> Having a verbose option will allow shell tests to provide extra failure
> details when the fail or skip.
 

Thanks, applied to perf/core.

- Arnaldo

> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/builtin-test.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index cbbfe48ab802..a8160b1684de 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -577,11 +577,14 @@ struct shell_test {
>  static int shell_test__run(struct test *test, int subdir __maybe_unused)
>  {
>  	int err;
> -	char script[PATH_MAX];
> +	char script[PATH_MAX + 3];
>  	struct shell_test *st = test->priv;
>  
>  	path__join(script, sizeof(script), st->dir, st->file);
>  
> +	if (verbose)
> +		strncat(script, " -v", sizeof(script));
> +
>  	err = system(script);
>  	if (!err)
>  		return TEST_OK;
> -- 
> 2.32.0.288.g62a8d224e6-goog
> 

-- 

- Arnaldo
