Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB47D565083
	for <lists+bpf@lfdr.de>; Mon,  4 Jul 2022 11:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbiGDJNl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Jul 2022 05:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbiGDJNk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Jul 2022 05:13:40 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB86D2C0;
        Mon,  4 Jul 2022 02:13:38 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c65so10878084edf.4;
        Mon, 04 Jul 2022 02:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uCY8bPxzV96YCvPAPmQP862IoIgvFPMrFGOHyarbwX0=;
        b=jsbKoVbBtZAkC9zdTa9hESMZLRrHU9tmcntzYXHwde6mGIo8o8nuYEMM3NxKaZYGfz
         qOiUKRG/cNBSvhWD0EWsuipkr4u8F5EOUKJDNjBJ53xXKlN/xp+BxGOFnxUfqKzkeRf9
         tcn2BrG/CjCbSvBO4avT+ejdVR53UiSDJHadX8wk1GbYqR/H4ffg8HzBEakS1pLx9zL8
         5BB04Z7SaZ+JAvrO8HTZxIR2meNh8QxMgSeTVayPsjKT2YRxazq6ev0//QZAs8i0yX2p
         7YxdsEdsTuzeJeyPLtc98dOo77kLn7JwPW/4I+Qs5RlvQJNhH2cjpp/WIb8WMb3JbI1a
         6fkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uCY8bPxzV96YCvPAPmQP862IoIgvFPMrFGOHyarbwX0=;
        b=bSPtkqjcvBGRBLmqWnJwPUzzbVgKrXoD7KRXXEvD499FqZxxiPKC/go7QJDNxNdQE7
         LhM8YoZT+s/bElsbcsjd8pNih2CGlrhcMMLTeWxIDc31s0gNevuMmWIB79GC1bAiDbdT
         /T9HX61QozJsjp3fnDuoqQEUcJFGI8fkkJGPONTeDUI64HovF54v2Hb5xME3e6Yx3MBs
         YgAWBr9zvoarls9pu/INVsHuVUIhncN0K8jtSqjUQA9j2Ead6g9HlXlVMxV/qIH1J04T
         MIzCMv30rzoqhtK0HetEDad8NWSuJ12XgAhr+Cy3pGA+NsSwNXHhA9/ymq+KLAIQQcqQ
         d01Q==
X-Gm-Message-State: AJIora9p8ixVXnpzHz5jq1zMhpxO01MByC2D8n5VKhxzlosWkKwP7ew6
        uMDGgNRv6eWRDlxgKY6O76w=
X-Google-Smtp-Source: AGRyM1tFjGSWqXs1J+d9SGsLZJlpvV6MOAOMbXiEqy6jYsJmgmWcaDP/SJg17VGDko2Ie5crrPBk6g==
X-Received: by 2002:a05:6402:d5e:b0:435:dc14:d457 with SMTP id ec30-20020a0564020d5e00b00435dc14d457mr37214149edb.58.1656926017309;
        Mon, 04 Jul 2022 02:13:37 -0700 (PDT)
Received: from krava ([151.70.14.154])
        by smtp.gmail.com with ESMTPSA id q14-20020a1709066ace00b00722e603c39asm13978655ejs.31.2022.07.04.02.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 02:13:36 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 4 Jul 2022 11:13:33 +0200
To:     Andres Freund <andres@anarazel.de>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: Re: [PATCH v2 0/5] tools: fix compilation failure caused by
 init_disassemble_info API changes
Message-ID: <YsKvPW+1RkVvq8aX@krava>
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
 <20220703212551.1114923-1-andres@anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220703212551.1114923-1-andres@anarazel.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jul 03, 2022 at 02:25:46PM -0700, Andres Freund wrote:
> binutils changed the signature of init_disassemble_info(), which now causes
> compilation failures for tools/{perf,bpf} on e.g. debian unstable. Relevant
> binutils commit:
> https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=60a3da00bd5407f07
> 
> I first fixed this without introducing the compat header, as suggested by
> Quentin, but I thought the amount of repeated boilerplate was a bit too
> much. So instead I introduced a compat header to wrap the API changes. Even
> tools/bpf/bpftool/jit_disasm.c, which needs its own callbacks for json, imo
> looks nicer this way.
> 
> I'm not regular contributor, so it very well might be my procedures are a
> bit off...
> 
> I am not sure I added the right [number of] people to CC?
> 
> WRT the feature test: Not sure what the point of the -DPACKAGE='"perf"' is,
> nor why tools/perf/Makefile.config sets some LDFLAGS/CFLAGS that are also
> in feature/Makefile and why -ldl isn't needed in the other places. But...
> 
> V2:
> - split patches further, so that tools/bpf and tools/perf part are entirely
>   separate
> - included a bit more information about tests I did in commit messages
> - add a maybe_unused to fprintf_json_styled's style argument
> 
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Sedat Dilek <sedat.dilek@gmail.com>
> Cc: Quentin Monnet <quentin@isovalent.com>
> To: bpf@vger.kernel.org
> To: linux-kernel@vger.kernel.org
> Link: https://lore.kernel.org/lkml/20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de
> Link: https://lore.kernel.org/lkml/CA+icZUVpr8ZeOKCj4zMMqbFT013KJz2T1csvXg+VSkdvJH1Ubw@mail.gmail.com
> 
> Andres Freund (5):
>   tools build: add feature test for init_disassemble_info API changes
>   tools include: add dis-asm-compat.h to handle version differences
>   tools perf: Fix compilation error with new binutils
>   tools bpf_jit_disasm: Fix compilation error with new binutils
>   tools bpftool: Fix compilation error with new binutils

I think the disassembler checks should not be displayed by default,
with your change I can see all the time:

...        disassembler-four-args: [ on  ]
...      disassembler-init-styled: [ OFF ]


could you please squash something like below in? moving disassembler
checks out of sight and do manual detection

thanks,
jirka


---
diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 339686b99a6e..bce9a9b52b2c 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -69,8 +69,6 @@ FEATURE_TESTS_BASIC :=                  \
         setns				\
         libaio				\
         libzstd				\
-        disassembler-four-args		\
-        disassembler-init-styled	\
         file-handle
 
 # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
@@ -106,7 +104,9 @@ FEATURE_TESTS_EXTRA :=                  \
          libbpf-bpf_create_map		\
          libpfm4                        \
          libdebuginfod			\
-         clang-bpf-co-re
+         clang-bpf-co-re		\
+         disassembler-four-args		\
+         disassembler-init-styled
 
 
 FEATURE_TESTS ?= $(FEATURE_TESTS_BASIC)
@@ -135,9 +135,7 @@ FEATURE_DISPLAY ?=              \
          get_cpuid              \
          bpf			\
          libaio			\
-         libzstd		\
-         disassembler-four-args	\
-         disassembler-init-styled
+         libzstd
 
 # Set FEATURE_CHECK_(C|LD)FLAGS-all for all FEATURE_TESTS features.
 # If in the future we need per-feature checks/flags for features not
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index ee417c321adb..2aa0bad11f05 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -914,8 +914,6 @@ ifndef NO_LIBBFD
         FEATURE_CHECK_LDFLAGS-disassembler-init-styled += -liberty -lz -ldl
       endif
     endif
-    $(call feature_check,disassembler-four-args)
-    $(call feature_check,disassembler-init-styled)
   endif
 
   ifeq ($(feature-libbfd-buildid), 1)
@@ -1025,6 +1023,9 @@ ifdef HAVE_KVM_STAT_SUPPORT
     CFLAGS += -DHAVE_KVM_STAT_SUPPORT
 endif
 
+$(call feature_check,disassembler-four-args)
+$(call feature_check,disassembler-init-styled)
+
 ifeq ($(feature-disassembler-four-args), 1)
     CFLAGS += -DDISASM_FOUR_ARGS_SIGNATURE
 endif
