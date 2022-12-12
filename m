Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A02264A38E
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 15:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbiLLOkS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 09:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiLLOkR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 09:40:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA26D6477;
        Mon, 12 Dec 2022 06:40:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74402B80D8B;
        Mon, 12 Dec 2022 14:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDC1C433EF;
        Mon, 12 Dec 2022 14:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670856014;
        bh=YbnT6Yq83aqglOQM9XhLCXL9nplEN1NrykFoYmTXrZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Px4SvP0n/u+UVqevgVZw6zjZsqclOrP42PpZL3odSfQBfoSwm0hpgKckyqK3ahv/s
         5wHS6KpzvWGa4XCjXKD22ubkP80ANoeL8yIC/kSqL38LEYXvCYBFaaMbEg5YzImBAL
         xY9K7fnvbfmIdEiVKQER+P/cMWBOmMzJ6ca0q26H2XEmfl9o8owUb2co62nwuqZsXn
         AnrpIske3AX25oPefiB5JGdo7e1AQ4IAbAdzbTiqJskTLJSfU3EJKcr1dEukPUy9bP
         DIiySFMTMXqDdj+xb3TttFJbhOsPppanYe9dnId265bwKho37ZIKyzggUQQWot3VtD
         fYrMFNvNTykiA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 86B3D4067B; Mon, 12 Dec 2022 11:28:54 -0300 (-03)
Date:   Mon, 12 Dec 2022 11:28:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 2/3] perf build: Use libtraceevent from the system
Message-ID: <Y5c6pl4LaZVo42op@kernel.org>
References: <Y4921D+36UGdhK92@kernel.org>
 <Y494TNa0ZyPH9YSD@kernel.org>
 <Y498YP2N3gvFSr/X@kernel.org>
 <C9F248C8-AF8D-40A1-A1AD-BCC39FBA01C7@linux.vnet.ibm.com>
 <Y5DNBZNC5rBBqlJW@kernel.org>
 <36CD1041-0CAE-41C1-8086-C17854531B3E@linux.vnet.ibm.com>
 <Y5JfgyN59dSeKbUP@kernel.org>
 <Y5Jl8MeW90DXy1wT@kernel.org>
 <CAP-5=fWyb+w2EP4cGBJU3RD6E_OkBZ+3w5+YyhwX7fOA-H0aWQ@mail.gmail.com>
 <CAP-5=fXJpxq-A7VJkZv+Y0fiCuNj9bhTXJx9+FGBQtePJ92z_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXJpxq-A7VJkZv+Y0fiCuNj9bhTXJx9+FGBQtePJ92z_A@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

	Just added this to the mix to fix a the python binding:

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 34fceda3af3a9b26..e80ffbbfacfb8cc0 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -63,15 +63,18 @@ libperf = getenv('LIBPERF')
 ext_sources = [f.strip() for f in open('util/python-ext-sources')
                                if len(f.strip()) > 0 and f[0] != '#']
 
-if not '-DHAVE_LIBTRACEEVENT' in cflags:
+extra_libraries = []
+
+if '-DHAVE_LIBTRACEEVENT' in cflags:
+    extra_libraries += [ 'traceevent' ]
+else:
     ext_sources.remove('util/trace-event.c')
 
 # use full paths with source files
 ext_sources = list(map(lambda x: '%s/%s' % (src_perf, x) , ext_sources))
 
-extra_libraries = []
 if '-DHAVE_LIBNUMA_SUPPORT' in cflags:
-    extra_libraries = [ 'numa' ]
+    extra_libraries += [ 'numa' ]
 if '-DHAVE_LIBCAP_SUPPORT' in cflags:
     extra_libraries += [ 'cap' ]
 
⬢[acme@toolbox perf]$ ldd /tmp/build/perf/python/perf.cpython-310-x86_64-linux-gnu.so
	linux-vdso.so.1 (0x00007fffa59f8000)
	libunwind-x86_64.so.8 => /lib64/libunwind-x86_64.so.8 (0x00007fb4fde98000)
	libunwind.so.8 => /lib64/libunwind.so.8 (0x00007fb4fde7f000)
	liblzma.so.5 => /lib64/liblzma.so.5 (0x00007fb4fde54000)
	libtraceevent.so.1 => /lib64/libtraceevent.so.1 (0x00007fb4fde2e000)
	libnuma.so.1 => /lib64/libnuma.so.1 (0x00007fb4fde20000)
	libcap.so.2 => /lib64/libcap.so.2 (0x00007fb4fde16000)
	libc.so.6 => /lib64/libc.so.6 (0x00007fb4fdc00000)
	libgcc_s.so.1 => /lib64/libgcc_s.so.1 (0x00007fb4fdbe0000)
	/lib64/ld-linux-x86-64.so.2 (0x00007fb4fdf13000)
⬢[acme@toolbox perf]$ perf test python
 19: 'import perf' in python                                         : Ok
⬢[acme@toolbox perf]$
