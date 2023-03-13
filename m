Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A496B840F
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 22:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjCMVil (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 17:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCMVij (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 17:38:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D98610EF;
        Mon, 13 Mar 2023 14:38:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB715B81185;
        Mon, 13 Mar 2023 21:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D88C433EF;
        Mon, 13 Mar 2023 21:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678743514;
        bh=vF/674kzpvGDnbsvqtRnlVuhwhYaIr9h8oZ+eov17wM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZeKLeZZPhL1jDhWf7Tv/JnNxElMy/euDqugHwSyyLJS7Bjk9fQ0O7buPxKeBcyv0+
         kBYVAvGQXaxe76zy9PAY7XEkzGE7sxk+3V6PkIps3m43UY7o5wfIi5dovzccJbQM6s
         ZuyUxrjMNCFY4pPsxk4Lr5rziV3Rha+LLcx7biq2CMxWeU8TkBlFxuV4OA19MQrKWl
         QwtNrDEcOj37C9MwetTxugqGr3SoedjDsL6XGMIlsxiaS/Ft+V+KMNVJTFH6Fu7Rsr
         zuEbIJxMEVbD/biSVgDT0LbsKP6mJdkmAR9YwiitxpHZ8nO7gnccR6eTGWTwOzqLG5
         Xh8ExfL2qJKHw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AFCC14049F; Mon, 13 Mar 2023 18:38:31 -0300 (-03)
Date:   Mon, 13 Mar 2023 18:38:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andres Freund <andres@anarazel.de>,
        Quentin Monnet <quentin@isovalent.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v2 2/3] perf build: Remove libbpf pre-1.0 feature tests
Message-ID: <ZA+X14KllWXrlr7C@kernel.org>
References: <20230116010115.490713-1-irogers@google.com>
 <20230116010115.490713-3-irogers@google.com>
 <ZA+RUCE4vAgBlQRh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZA+RUCE4vAgBlQRh@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Mar 13, 2023 at 06:10:40PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Sun, Jan 15, 2023 at 05:01:14PM -0800, Ian Rogers escreveu:
> > The feature tests were necessary for libbpf pre-1.0, but as the libbpf
> > implies at least 1.0 we can remove these now.
> 
> So I added this:
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 8b0bd3aa018ef166..b715cd4f43f4a014 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -580,7 +580,7 @@ ifndef NO_LIBELF
>            EXTLIBS += -lbpf
>            $(call detected,CONFIG_LIBBPF_DYNAMIC)
>          else
> -          dummy := $(error Error: No libbpf devel library found, please install libbpf-devel);
> +          dummy := $(error Error: No libbpf devel library found or older than v1.0, please install/update libbpf-devel);
>          endif
>        else
>          # Libbpf will be built as a static library from tools/lib/bpf.
> 
> To better reflect the failure reason:
> 
> ⬢[acme@toolbox perf-tools-next]$ cat /tmp/build/perf-tools-next/feature/test-libbpf.make.output
> test-libbpf.c:5:2: error: #error At least libbpf 1.0 is required for Linux tools.
>     5 | #error At least libbpf 1.0 is required for Linux tools.
>       |  ^~~~~
> ⬢[acme@toolbox perf-tools-next]$ rpm -q libbpf-devel
> libbpf-devel-0.8.0-2.fc37.x86_64
> ⬢[acme@toolbox perf-tools-next]$
> 
> I'll see if I can make the build test conditional on libbpf being >= 1.0

I'm trying with this:

⬢[acme@toolbox libbpf]$ git log --oneline -1 9476dce6fe905a6bf1d4c483f7b2b8575c4ffb2d
9476dce6fe905a6b libbpf: remove deprecated low-level APIs
⬢[acme@toolbox libbpf]$ git tag --contains 9476dce6fe905a6bf1d4c483f7b2b8575c4ffb2d
v1.0.0
v1.0.1
v1.1.0
⬢[acme@toolbox libbpf]$

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 531324c3dab594e1..f866c58b916f4d7a 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -63,6 +63,7 @@ endif
 
 has = $(shell which $1 2>/dev/null)
 python_perf_so := $(shell $(MAKE) python_perf_target|grep "Target is:"|awk '{print $$3}')
+old_libbpf := $(shell grep -q LIBBPF_DEPRECATED /usr/include/bpf/bpf.h)
 
 # standard single make variable specified
 make_clean_all      := clean all
@@ -151,7 +152,9 @@ run += make_no_libaudit
 run += make_no_libbionic
 run += make_no_auxtrace
 run += make_no_libbpf
+ifneq ($(old_libbpf),)
 run += make_libbpf_dynamic
+endif
 run += make_no_libbpf_DEBUG
 run += make_no_libcrypto
 run += make_no_sdt
