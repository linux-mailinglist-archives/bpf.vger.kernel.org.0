Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED66B6F2231
	for <lists+bpf@lfdr.de>; Sat, 29 Apr 2023 03:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjD2Byk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 21:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjD2Byj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 21:54:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81541BF2;
        Fri, 28 Apr 2023 18:54:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7328564136;
        Sat, 29 Apr 2023 01:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC331C433EF;
        Sat, 29 Apr 2023 01:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682733277;
        bh=BWlsiIT8REbab5TGuB49NyUrCOsShh0sQvphL3NLVKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LpaSyyjadTwRWK7+Syh5iYWgZ8ulkv+wSlt2vP1DrkHRxZuUJoohxwPZzfWoCpI1f
         U/rdc/C6HItOX6PqjjYscgM01k66F7gJjhj+mY6JgqKENJ9R1/tB76GN/ZKw9nf/iN
         TMHAkUU8jz3Taal1UgAD+0H1TZZ3QVHikJZwn15XV4Gi5L/hSSUR00XMQxCZpEkNX+
         b9pJhvGQxGyE6I9m3KUWjLtke2WmLA4Pk8lH959vJpt8LHMedoo84V7rSv9j+jiGPi
         eyGhfV7v/EnSEDgMbcXiu8uFVCzSunNfQ0a3/o7x4ggALuWfu2yTA+FSrOeR3GOM/D
         a9FCu092W4ucw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 72711403B5; Fri, 28 Apr 2023 22:54:35 -0300 (-03)
Date:   Fri, 28 Apr 2023 22:54:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] perf build: Fix unescaped # in perf build-test
Message-ID: <ZEx42/HTgIjYf74z@kernel.org>
References: <20230425104414.1723571-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425104414.1723571-1-james.clark@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Apr 25, 2023 at 11:44:13AM +0100, James Clark escreveu:
> With the following bash and make versions:
> 
>   $ make --version
>   GNU Make 4.2.1
>   Built for aarch64-unknown-linux-gnu
> 
>   $ bash --version
>   GNU bash, version 5.0.17(1)-release (aarch64-unknown-linux-gnu)
> 
> This error is encountered when running the build-test target:

Thanks, applied.

- Arnaldo

 
>   $ make -C tools/perf build-test
>   tests/make:181: *** unterminated call to function 'shell': missing ')'.  Stop.
>   make: *** [Makefile:103: build-test] Error 2
> 
> Fix it by escaping the # which was causing make to interpret the rest of
> the line as a comment leaving the unclosed opening bracket.
> 
> Fixes: 56d5229471ee ("tools build: Pass libbpf feature only if libbpf 1.0+")
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/tests/make | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index d75876126631..8dd3f8090352 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
> @@ -178,7 +178,7 @@ run += make_install_prefix_slash
>  # run += make_install_pdf
>  run += make_minimal
>  
> -old_libbpf := $(shell echo "#include <bpf/libbpf.h>" | $(CC) -E -dM -x c -| egrep -q "define[[:space:]]+LIBBPF_MAJOR_VERSION[[:space:]]+0{1}")
> +old_libbpf := $(shell echo '\#include <bpf/libbpf.h>' | $(CC) -E -dM -x c -| egrep -q "define[[:space:]]+LIBBPF_MAJOR_VERSION[[:space:]]+0{1}")
>  
>  ifneq ($(old_libbpf),)
>  run += make_libbpf_dynamic
> -- 
> 2.34.1
> 

-- 

- Arnaldo
