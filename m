Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B566368EB57
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 10:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjBHJ1q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 04:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjBHJ12 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 04:27:28 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC3B47EFA;
        Wed,  8 Feb 2023 01:24:46 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so955880wma.1;
        Wed, 08 Feb 2023 01:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3nzhlTJJ6q+FjJ87NnY2aW6kctPmUKU3QmGZZsZ6Rrc=;
        b=gbP861iwK9cf7SBl9Q07YUptHGBmw3LrawyWyO3y3JBXWeaC968FODUr+/bn9mdxnZ
         U46woJn+5U4EcByc0F1nk7hKw8tIy8xaL1fqenaY4vo40F/fDpcIj/ft1Dh+nh9PBMHL
         iggEKKfnma8sYe5yJdIrbdr/Q+CBu7taQAAvj3E49vjb++vYDkrxNPmzmz/I/xlIgMzC
         uaTYtYr+0pU57r4rZnixomv7L4u1HJGRIHc+i8k2eCEt9HAYlovrnXDVhlREfx3SnxpP
         0u6uSvPQJzGDsk3b/mz63fCG3NE/Fj2ABlh/TktXYXWV/HEvcL0wFW0yTsnyS+AuZBm5
         oBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nzhlTJJ6q+FjJ87NnY2aW6kctPmUKU3QmGZZsZ6Rrc=;
        b=nVdu3p6zka3BZzcSstb55iVsThrJb4iSCzJHa+QXi/8RWYLlBOB3Ahwue2EHLu7E9t
         AAlTlvEguLMdOhAmKPo/ob+lBzF73J/AVmAPf4BIvRGgYNOM5WENjJSHIJeJMC0Y9IwX
         soLK+G93yARATXh09+S1U/YAD7gLkWlyIO6KkTQX3JSxh0XREmuPUdDa5jnPzXaPaq3X
         5oPMO8mBwDc3yFYpEm9/yeCR3+njX7usSj9L8DCOwT7e/M0N1NStc12ep9gkyzad5Zsx
         0RU6GTsLeoQwnNNkeUDMX9nyNRq3BM8xiGgeJh6GRX1PFuGnX/1ddC04SuYJBqV5xZsI
         hzgQ==
X-Gm-Message-State: AO0yUKXjkB/rflSKA04jiXwX19lOghQPiaPjWAljalh86cwZzsw9Xxq4
        8Bc5Oemx1YcTVZoQrJSnssumd6ak25nqCQ==
X-Google-Smtp-Source: AK7set9KVRxAfY0+0KrAgc2ZCEIHU1FDYEq4CdBt2apbqSP12qZ2XsjVfJwPX653H84/W3s9JbMoVg==
X-Received: by 2002:a05:600c:13c8:b0:3df:50eb:7cd9 with SMTP id e8-20020a05600c13c800b003df50eb7cd9mr5916951wmg.14.1675848285095;
        Wed, 08 Feb 2023 01:24:45 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id r17-20020adfce91000000b002c3f210e8c0sm3945257wrn.19.2023.02.08.01.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 01:24:44 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 8 Feb 2023 10:24:42 +0100
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Ian Rogers <irogers@google.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: compile error due to relocation problems in
 tools/bpf/resolve_btfids//libbpf/libbpf.a(libbpf-in.o)
Message-ID: <Y+NqWnMx/PQmnFiD@krava>
References: <f7922132-6645-6316-5675-0ece4197bfff@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7922132-6645-6316-5675-0ece4197bfff@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 08, 2023 at 09:18:31AM +0100, Thorsten Leemhuis wrote:
> Hi! My daily linux-next builds for Fedora 36, 37 and 38 failed due to a
> compile error today. I lack time to investigate this properly currently
> (sorry!), but wanted to report it at least briefly nevertheless.
> 
> See below for the error log. I noticed there where changes from Jiri
> ("tools/resolve_btfids: Compile resolve_btfids as host program") and Ian
> ("tools/resolve_btfids: Tidy HOST_OVERRIDES") merged yesterday that
> touch the code in question, which made me wonder if they cause this. But
> maybe my spec file (it's based on the one from Fedora rawhide's kernel)
> is doing something it shouldn't do.
> 
> Here are the build errors:
> 
> On x86_64:
> 
> > + /usr/bin/make -s 'HOSTCFLAGS=-O2  -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -m64  -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer' 'HOSTLDFLAGS=-Wl,-z,relro -Wl,--as-needed  -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes' ARCH=x86_64 'KCFLAGS= ' WITH_GCOV=0 -j2 bzImage
> > /usr/bin/ld: /builddir/build/BUILD/kernel-next-20230208/linux-6.2.0-0.0.next.20230208.350.vanilla.fc38.x86_64/tools/bpf/resolve_btfids//libbpf/libbpf.a(libbpf-in.o): relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a PIE object; recompile with -fPIE
> > /usr/bin/ld: failed to set dynamic section sizes: bad value
> > collect2: error: ld returned 1 exit status
> > make[2]: *** [Makefile:87: /builddir/build/BUILD/kernel-next-20230208/linux-6.2.0-0.0.next.20230208.350.vanilla.fc38.x86_64/tools/bpf/resolve_btfids//resolve_btfids] Error 1
> > make[1]: *** [Makefile:76: bpf/resolve_btfids] Error 2
> > make: *** [Makefile:1438: tools/bpf/resolve_btfids] Error 2
> > make: *** Waiting for unfinished jobs....
> 
> On arm64:
> 
> > + /usr/bin/make -s 'HOSTCFLAGS=-O2  -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -mbranch-protection=standard -fasynchronous-unwind-tables -fstack-clash-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer' 'HOSTLDFLAGS=-Wl,-z,relro -Wl,--as-needed  -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes' ARCH=arm64 'KCFLAGS= ' WITH_GCOV=0 -j4 Image.gz
> > /usr/bin/ld: /builddir/build/BUILD/kernel-next-20230208/linux-6.2.0-0.0.next.20230208.350.vanilla.fc38.aarch64/tools/bpf/resolve_btfids//libbpf/libbpf.a(libbpf-in.o): relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `stderr@@GLIBC_2.17' which may bind externally can not be used when making a shared object; recompile with -fPIC
> > /usr/bin/ld: /builddir/build/BUILD/kernel-next-20230208/linux-6.2.0-0.0.next.20230208.350.vanilla.fc38.aarch64/tools/bpf/resolve_btfids//libbpf/libbpf.a(libbpf-in.o)(.text+0x21c): unresolvable R_AARCH64_ADR_PREL_PG_HI21 relocation against symbol `stderr@@GLIBC_2.17'
> > /usr/bin/ld: final link failed: bad value
> > collect2: error: ld returned 1 exit status
> > make[2]: *** [Makefile:87: /builddir/build/BUILD/kernel-next-20230208/linux-6.2.0-0.0.next.20230208.350.vanilla.fc38.aarch64/tools/bpf/resolve_btfids//resolve_btfids] Error 1
> > make[1]: *** [Makefile:76: bpf/resolve_btfids] Error 2
> > make: *** [Makefile:1439: tools/bpf/resolve_btfids] Error 2
> > make: *** Waiting for unfinished jobs....
> 
> For complete logs click on the "builder-live.log" links on
> https://copr.fedorainfracloud.org/coprs/g/kernel-vanilla/next/build/5502791/
> 
> 
> Yesterdays logs can be found here:
> https://copr.fedorainfracloud.org/coprs/g/kernel-vanilla/next/build/5495974/
> 
> Ciao, Thorsten

ciao ;-)

I managed to reproduce and patch below fixes the issue for me,
could you please test?

I have in stack several other fixes for this, would be great
if you could test them, I'll cc you 

jirka


---
diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index 2abdd85b4a08..ac548a7baa73 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -19,7 +19,7 @@ endif
 
 # Overrides for the prepare step libraries.
 HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)" \
-		  CROSS_COMPILE=""
+		  CROSS_COMPILE="" EXTRA_CFLAGS="$(HOSTCFLAGS)"
 
 RM      ?= rm
 HOSTCC  ?= gcc
