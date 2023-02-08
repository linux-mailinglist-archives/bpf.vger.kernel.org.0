Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721C168E9B1
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 09:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjBHISl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 03:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjBHISl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 03:18:41 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369BCF760;
        Wed,  8 Feb 2023 00:18:36 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pPfez-0002kv-Cs; Wed, 08 Feb 2023 09:18:33 +0100
Message-ID: <f7922132-6645-6316-5675-0ece4197bfff@leemhuis.info>
Date:   Wed, 8 Feb 2023 09:18:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jiri Olsa <jolsa@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Ian Rogers <irogers@google.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: compile error due to relocation problems in
 tools/bpf/resolve_btfids//libbpf/libbpf.a(libbpf-in.o)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1675844316;cb84b525;
X-HE-SMSGID: 1pPfez-0002kv-Cs
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi! My daily linux-next builds for Fedora 36, 37 and 38 failed due to a
compile error today. I lack time to investigate this properly currently
(sorry!), but wanted to report it at least briefly nevertheless.

See below for the error log. I noticed there where changes from Jiri
("tools/resolve_btfids: Compile resolve_btfids as host program") and Ian
("tools/resolve_btfids: Tidy HOST_OVERRIDES") merged yesterday that
touch the code in question, which made me wonder if they cause this. But
maybe my spec file (it's based on the one from Fedora rawhide's kernel)
is doing something it shouldn't do.

Here are the build errors:

On x86_64:

> + /usr/bin/make -s 'HOSTCFLAGS=-O2  -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -m64  -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer' 'HOSTLDFLAGS=-Wl,-z,relro -Wl,--as-needed  -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes' ARCH=x86_64 'KCFLAGS= ' WITH_GCOV=0 -j2 bzImage
> /usr/bin/ld: /builddir/build/BUILD/kernel-next-20230208/linux-6.2.0-0.0.next.20230208.350.vanilla.fc38.x86_64/tools/bpf/resolve_btfids//libbpf/libbpf.a(libbpf-in.o): relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a PIE object; recompile with -fPIE
> /usr/bin/ld: failed to set dynamic section sizes: bad value
> collect2: error: ld returned 1 exit status
> make[2]: *** [Makefile:87: /builddir/build/BUILD/kernel-next-20230208/linux-6.2.0-0.0.next.20230208.350.vanilla.fc38.x86_64/tools/bpf/resolve_btfids//resolve_btfids] Error 1
> make[1]: *** [Makefile:76: bpf/resolve_btfids] Error 2
> make: *** [Makefile:1438: tools/bpf/resolve_btfids] Error 2
> make: *** Waiting for unfinished jobs....

On arm64:

> + /usr/bin/make -s 'HOSTCFLAGS=-O2  -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -mbranch-protection=standard -fasynchronous-unwind-tables -fstack-clash-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer' 'HOSTLDFLAGS=-Wl,-z,relro -Wl,--as-needed  -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes' ARCH=arm64 'KCFLAGS= ' WITH_GCOV=0 -j4 Image.gz
> /usr/bin/ld: /builddir/build/BUILD/kernel-next-20230208/linux-6.2.0-0.0.next.20230208.350.vanilla.fc38.aarch64/tools/bpf/resolve_btfids//libbpf/libbpf.a(libbpf-in.o): relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `stderr@@GLIBC_2.17' which may bind externally can not be used when making a shared object; recompile with -fPIC
> /usr/bin/ld: /builddir/build/BUILD/kernel-next-20230208/linux-6.2.0-0.0.next.20230208.350.vanilla.fc38.aarch64/tools/bpf/resolve_btfids//libbpf/libbpf.a(libbpf-in.o)(.text+0x21c): unresolvable R_AARCH64_ADR_PREL_PG_HI21 relocation against symbol `stderr@@GLIBC_2.17'
> /usr/bin/ld: final link failed: bad value
> collect2: error: ld returned 1 exit status
> make[2]: *** [Makefile:87: /builddir/build/BUILD/kernel-next-20230208/linux-6.2.0-0.0.next.20230208.350.vanilla.fc38.aarch64/tools/bpf/resolve_btfids//resolve_btfids] Error 1
> make[1]: *** [Makefile:76: bpf/resolve_btfids] Error 2
> make: *** [Makefile:1439: tools/bpf/resolve_btfids] Error 2
> make: *** Waiting for unfinished jobs....

For complete logs click on the "builder-live.log" links on
https://copr.fedorainfracloud.org/coprs/g/kernel-vanilla/next/build/5502791/


Yesterdays logs can be found here:
https://copr.fedorainfracloud.org/coprs/g/kernel-vanilla/next/build/5495974/

Ciao, Thorsten
