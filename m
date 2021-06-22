Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049323B0BC4
	for <lists+bpf@lfdr.de>; Tue, 22 Jun 2021 19:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbhFVRsW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Jun 2021 13:48:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232523AbhFVRsK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Jun 2021 13:48:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EC1F60720;
        Tue, 22 Jun 2021 17:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624383954;
        bh=KYdzhVdFqcr+mEgygSRn+EYzmtQszmTzzU/stbjWEHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aIRNL91loyTVbyaokWbLXKeDr5gkxubHgZ6zn8SIjxfVF/TYN46qw6OfIbz9rn8dn
         7zh0ks3O4wlNMJp5IYy1IETc5NZR95llRjrpvHFXuphMkHYnK3YmPFAk1DN9oBbB4S
         FdcOOlL0KNV8o9GlzbS0Lv/2K2JTOqyQZF4jjnZFDcKo7hp9KdVEZU9TtzqOgzP4KY
         VWDD4Qf9eY+h8ojBNxfmamja8rpP2vBKmz3sYHLf0M9yDs5VHGfZ1rg/YhIpEAsiAm
         pmqhMwXQyWo55qEpCTIBRn1pKraUAAP1P4VbHS4z+K1HxOi0nHQDA5rmX22158tOtg
         260SPyPqeaWvQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B578040B1A; Tue, 22 Jun 2021 14:45:51 -0300 (-03)
Date:   Tue, 22 Jun 2021 14:45:51 -0300
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
Subject: Re: [PATCH v2 1/3] perf test: Pass the verbose option to shell tests
Message-ID: <YNIhzyKPqfFvvoYs@kernel.org>
References: <20210621215648.2991319-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621215648.2991319-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Jun 21, 2021 at 02:56:46PM -0700, Ian Rogers escreveu:
> Having a verbose option will allow shell tests to provide extra failure
> details when the fail or skip.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/builtin-test.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index cbbfe48ab802..e1ed60567b2f 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -577,10 +577,13 @@ struct shell_test {
>  static int shell_test__run(struct test *test, int subdir __maybe_unused)
>  {
>  	int err;
> -	char script[PATH_MAX];
> +	char script[PATH_MAX + 3];

This looks strange, i.e. if it is a _path_ _MAX_, why add 3 chars past
that max when generating a _path_? I'll drop the above hunk and keep the
rest, ok?

- Arnaldo

>  	struct shell_test *st = test->priv;
>  
> -	path__join(script, sizeof(script), st->dir, st->file);
> +	path__join(script, sizeof(script) - 3, st->dir, st->file);
> +
> +	if (verbose)
> +		strncat(script, " -v", sizeof(script) - strlen(script) - 1);
>  
>  	err = system(script);
>  	if (!err)
