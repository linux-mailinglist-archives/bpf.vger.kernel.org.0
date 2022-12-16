Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226FB64EBC8
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 14:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiLPNC5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 08:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiLPNCz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 08:02:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB85AB48D;
        Fri, 16 Dec 2022 05:02:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88237620B5;
        Fri, 16 Dec 2022 13:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5715C433EF;
        Fri, 16 Dec 2022 13:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671195774;
        bh=Zqx8PemfNkIgR0VSjlq+cSSIc1mNqP5HstKuh5k7PvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BpC4XSYaVer0QbtlOxiYn/qwe6V2XeUXMVzBAjZy3fz9wIQ4vZYOtx/SlhpFw4UrJ
         Ar/jbSb+JqW+ms4efYSI1yfMdoil2BxaIZee6Pb4+KzxjVWx4uPTF8e7KhsE+ssFiG
         AcgFIx6TewgsncKns95P8wb80rqcuj9dC3syZ0Bt49yf6snpzRa/tGnwfJOaxyD8By
         iJhkjX6NZ2J7qIj2hIFrWtRpES3bffNevn4+AyqNSyuuTmnSskzWkmWeiX4ZaMWif/
         nzhVvtxo/EE9CrXa5bY3woCBUCzQy17ORc6aoTjRybvUuTB1ImWDpSaVjO4iLWP/Hb
         BqTiY/n9at7Hw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 46F1540367; Fri, 16 Dec 2022 10:02:51 -0300 (-03)
Date:   Fri, 16 Dec 2022 10:02:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] tools lib perf: fix install_pkgconfig target
Message-ID: <Y5xse0o0gbyFjeV7@kernel.org>
References: <20221202045743.2639466-1-irogers@google.com>
 <20221202045743.2639466-3-irogers@google.com>
 <Y5w+F+aqN5L1CuuG@tuxmaker.boeblingen.de.ibm.com>
 <Y5w/cWKyb8vpNMfA@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5w/cWKyb8vpNMfA@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Dec 16, 2022 at 10:50:41AM +0100, Alexander Gordeev escreveu:
> Commit 47e02b94a4c9 ("tools lib perf: Add dependency test
> to install_headers") misses the notion of $(DESTDIR_SQ)
> for install_pkgconfig target, which leads to error:
> 
> install: cannot create regular file '/usr/lib64/pkgconfig/libperf.pc': Permission denied
> make: *** [Makefile:210: install_pkgconfig] Error 1

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  tools/lib/perf/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
> index 30b7f91e7147..d8cad124e4c5 100644
> --- a/tools/lib/perf/Makefile
> +++ b/tools/lib/perf/Makefile
> @@ -208,7 +208,7 @@ install_headers: $(INSTALL_HDRS) $(INSTALL_INTERNAL_HDRS)
>  
>  install_pkgconfig: $(LIBPERF_PC)
>  	$(call QUIET_INSTALL, $(LIBPERF_PC)) \
> -		$(call do_install,$(LIBPERF_PC),$(libdir_SQ)/pkgconfig,644)
> +		$(call do_install,$(LIBPERF_PC),$(DESTDIR_SQ)$(libdir_SQ)/pkgconfig,644)
>  
>  install_doc:
>  	$(Q)$(MAKE) -C Documentation install-man install-html install-examples
> -- 
> 2.34.1

-- 

- Arnaldo
