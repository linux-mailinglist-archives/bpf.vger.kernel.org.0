Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0A36231F9
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 19:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiKISDA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 13:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiKISCV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 13:02:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AABA27CD8;
        Wed,  9 Nov 2022 10:01:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1E7DB81F68;
        Wed,  9 Nov 2022 18:01:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534BEC433D6;
        Wed,  9 Nov 2022 18:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668016861;
        bh=o9wTu/uqSuvdOyiepZ3oFdSFK2MQWtuIFpBt23bEtU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rG02Xt5hmMd6WxUE4MxWTCf4oMF3Xoie56LpENu7uxTvTeMyyhtJ1M5lLU8l+u11P
         m88Elu4UGVsV3hcMLNdZpW2v8XxkvpnTDJWM9s3PDEkLjbxsUv7xm2KbNd1RpvsYxU
         VwIHIUvwE9eOZwmLIugAKVfTW57Q67WckG0JvXBKodszdK3O904iX7jdRw9Z/T8Lk+
         vr1oe0HIQ/txYXcFUSe41g+kZLs38MebRJRdW8ymqj4bJ+U7y9fZ/SJkyvKwonObTx
         kz+lSb40wl3cXUc2LWoSpWcG/nQR9pf5zXa6Gt/CKEkxrfqJRoYiWn7FCiiEFbEkRF
         q58XCLxHyarQQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E08B34034E; Wed,  9 Nov 2022 15:00:58 -0300 (-03)
Date:   Wed, 9 Nov 2022 15:00:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 00/14] Fix perf tools/lib includes
Message-ID: <Y2vq2tWzdBzIwA6H@kernel.org>
References: <20221108073518.1154450-1-irogers@google.com>
 <Y2vG13WVahGoib57@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y2vG13WVahGoib57@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Nov 09, 2022 at 12:27:19PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Nov 07, 2022 at 11:35:04PM -0800, Ian Rogers escreveu:
> > The previous build would add -Itools/lib and get dependencies for
> > libtraceevent, libsubcmd, libsymbol, libapi and libbpf meaning that
> > overriding these libraries would change the link time dependency but
> > the headers would erroneously come from tools/lib. Fix the build to
> > install headers and then depend on these. To reduce exposing internal
> > headers/APIs some clean up is performed. tools/lib/symbol has a
> > Makefile added, while tools/lib/api and tools/lib/subcmd have install
> > targets added. The pattern used for the dependencies in Makefile.perf
> > is modelled on libbpf.
> 
> It builds with O=, I tried it one by one, but  there are problems with
> make from a detached tarball, that is how I do the container builds, see
> below, I'm trying to figure this out...
> 
> ⬢[acme@toolbox perf]$ make perf-tar-src-pkg
>   TAR
>   PERF_VERSION = 6.1.rc3.g7e5d8b7a1fbd
> ⬢[acme@toolbox perf]$ mv perf-6.1.0-rc3.tar /tmp
> ⬢[acme@toolbox perf]$ cd /tmp
> ⬢[acme@toolbox tmp]$ tar xf perf-6.1.0-rc3.tar
> ⬢[acme@toolbox tmp]$ cd perf-6.1.0-rc3/
> ⬢[acme@toolbox perf-6.1.0-rc3]$ make -C tools/perf
> make: Entering directory '/tmp/perf-6.1.0-rc3/tools/perf'
>   BUILD:   Doing 'make -j32' parallel build
>   HOSTCC  fixdep.o
>   HOSTLD  fixdep-in.o
>   LINK    fixdep
> 
> Auto-detecting system features:
<SNIP>
> ...                                   dwarf: [ on  ]
>   CC      jvmti/libjvmti.o
> make[3]: *** No rule to make target '/tmp/perf-6.1.0-rc3/tools/perf/libsymbol/libsymbol.a'.  Stop.
> make[2]: *** [Makefile.perf:907: /tmp/perf-6.1.0-rc3/tools/perf/libsymbol/libsymbol.a] Error 2
> make[2]: *** Waiting for unfinished jobs....

So this cures it:

diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
index f5d72f936a6bad2c..c8e8e05b4ff1f56f 100644
--- a/tools/perf/MANIFEST
+++ b/tools/perf/MANIFEST
@@ -13,8 +13,7 @@ tools/lib/ctype.c
 tools/lib/hweight.c
 tools/lib/rbtree.c
 tools/lib/string.c
-tools/lib/symbol/kallsyms.c
-tools/lib/symbol/kallsyms.h
+tools/lib/symbol
 tools/lib/find_bit.c
 tools/lib/bitmap.c
 tools/lib/list_sort.c
