Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE46582862
	for <lists+bpf@lfdr.de>; Wed, 27 Jul 2022 16:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbiG0OQ7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jul 2022 10:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbiG0OQ6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jul 2022 10:16:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E5D26D5;
        Wed, 27 Jul 2022 07:16:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D21D617C0;
        Wed, 27 Jul 2022 14:16:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58CFC433D6;
        Wed, 27 Jul 2022 14:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658931416;
        bh=gIDMcqNCaRR8LmuzfgBqCB914E1w1kgLj7kbJfKcQaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SlClN9KNnNHbE2ZN05xmkOP04lErHEV5K3Vw0XT2glqnmXDbU6zF7TW54OB+aE6fn
         xNh7xvl47F1s+NfX3SuruFcYHEJj+KE9JWl6r4yRDIPiAwhyCiChCh17lpJdKjbU2B
         xIvRrVRfPkhwW26jjI6qzpRkAp91jGbQKAtvcD/5z1F0qayVbAGt1L0TA44k5M7s7o
         jAIhHsXkpQMgRF1WeMfbso9m7t/z2vMAl1LBKcaFSleUT2brAkA+fIXpmGBg8zQtGd
         /f1U6O3+aGiSPm6IQO9dNltlFvh9so0VOfAicCSZHNvVJQBNM766vTnX69OCMW9QKK
         qVled27QP8LzQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E77CB405DD; Wed, 27 Jul 2022 11:16:53 -0300 (-03)
Date:   Wed, 27 Jul 2022 11:16:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
        Christy Lee <christylee@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf bpf: Remove undefined behavior from
 bpf_perf_object__next
Message-ID: <YuFI1Thhls+dYE2I@kernel.org>
References: <20220726220921.2567761-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726220921.2567761-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Jul 26, 2022 at 03:09:21PM -0700, Ian Rogers escreveu:
> bpf_perf_object__next folded the last element in the list test with the
> empty list test. However, this meant that offsets were computed against
> null and that a struct list_head was compared against a struct
> bpf_perf_object. Working around this with clang's undefined behavior
> sanitizer required -fno-sanitize=null and -fno-sanitize=object-size.
> in 
> Remove the undefined behav(ior by using the regular Linux list APIs and
> handling the starting case separately from the end testing case. Looking
> at uses like bpf_perf_object__for_each, as the constant NULL or non-NULL
> argument can be constant propagated the code is no less efficient.

Nicely spotted!

In some places people solve this with list_first_entry_or_null(), like
in cs_etm__queue_aux_records().

Applied.

- Arnado
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/bpf-loader.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
> indelx f8ad581ea247..cdd6463a5b68 100644
> --- a/tools/perf/util/bpf-loader.c
> +++ b/tools/perf/util/bpf-loader.c
> @@ -63,20 +63,16 @@ static struct hashmap *bpf_map_hash;
>  static struct bpf_perf_object *
>  bpf_perf_object__next(struct bpf_perf_object *prev)
>  {
> -	struct bpf_perf_object *next;
> -
> -	if (!prev)
> -		next = list_first_entry(&bpf_objects_list,
> -					struct bpf_perf_object,
> -					list);
> -	else
> -		next = list_next_entry(prev, list);
> +	if (!prev) {
> +		if (list_empty(&bpf_objects_list))
> +			return NULL;
>  
> -	/* Empty list is noticed here so don't need checking on entry. */
> -	if (&next->list == &bpf_objects_list)
> +		return list_first_entry(&bpf_objects_list, struct bpf_perf_object, list);
> +	}
> +	if (list_is_last(&prev->list, &bpf_objects_list))
>  		return NULL;
>  
> -	return next;
> +	return list_next_entry(prev, list);
>  }
>  
>  #define bpf_perf_object__for_each(perf_obj, tmp)	\
> -- 
> 2.37.1.359.gd136c6c3e2-goog

-- 

- Arnaldo
