Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7042430B4
	for <lists+bpf@lfdr.de>; Thu, 13 Aug 2020 00:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgHLWPs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Aug 2020 18:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgHLWPr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Aug 2020 18:15:47 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F60FC061383
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2020 15:15:47 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id b22so3266391oic.8
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2020 15:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zkFmS4lhourxIPS4nRwSR7knOjqPCKlD3ZtMlJSoIPw=;
        b=aiZSNhPwl1N0n/NAAMFyLI1hcEPsUdLvv5dTjX3oVZVhZszLgaR8Dm/uS7n1SVcw2w
         j6BXwSWxbdy1ib0yKE7cepkpNJMztwvYqfQH8WxS6BITMO0nv9zbBz/coztDcR58/1gJ
         MGFbAD2vN0QM7l4ijcu6KSnFENpDP+4KOT72zPgkjl3rAMHjjfrZFB8362nsEDQvOv+c
         gG6RV5ewfhhf/AdQYiJxp9RTk/PQFUzdHSlZliLpNEc6NhAIi/fDRv1iMbJQM3WvhFtm
         4Oj/QtKQCJ2lyJwHXwrU0byJTmpRbARW2U6LPc+iV6Yy5RVA+fk4/UosMEc+FuS4p7fo
         Pdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zkFmS4lhourxIPS4nRwSR7knOjqPCKlD3ZtMlJSoIPw=;
        b=TEYxWq/sJuEGdJ/BMIH8iKzvkAIn6cTMMy+nkl6++mRJCdcdsU8nMcg7Wnmej+lMlm
         xKUiAt223XeJFd5xJogyPWdm3olocxqUVobQ3x1n/yJNK8BHxqCwHabwDs7gQNWE366D
         P/zeLriuLb6Ue8dVxxzgPFYDh+FSOX4vln7sv6TF+4L/qVj0CwObDdCHOYwLqNDJXKoJ
         ZU5X4YGWI9p72RChOSjuXlCeP2lZDpKJBdT1FU06EjiHNoheK/ikw52I8gRbBRkgoMak
         G2RLW5uN/8E0NHBe3SUt2/xODsogJVQ/Zr5w927SUv0WaKcBZQx8JSt17TUL29F94mVx
         GAnA==
X-Gm-Message-State: AOAM532f+1QcENaQUhfqYfK0ejJIg+u+5+R7ijy89CEh8D0opjjHd8fx
        pRwYq5EIfhX+w5Z82I0gTZf4mg==
X-Google-Smtp-Source: ABdhPJxUJvudfvVYCwSyrWgrpazlrDLoii6vv6fDp5AwJjZ7DgFzOhwZz8DIcb5zuMXrkd5on8PlZQ==
X-Received: by 2002:a54:4f1a:: with SMTP id e26mr1095994oiy.171.1597270546628;
        Wed, 12 Aug 2020 15:15:46 -0700 (PDT)
Received: from alago.cortijodelrio.net (CableLink-189-219-73-83.Hosts.InterCable.net. [189.219.73.83])
        by smtp.googlemail.com with ESMTPSA id l17sm720788otn.2.2020.08.12.15.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 15:15:46 -0700 (PDT)
From:   =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Thomas Hebb <tommyhebb@gmail.com>,
        =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Stephane Eranian <eranian@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org (open list),
        netdev@vger.kernel.org (open list:BPF (Safe dynamic programs and tools)),
        bpf@vger.kernel.org (open list:BPF (Safe dynamic programs and tools))
Subject: [PATCH] tools build feature: Quote CC and CXX for their arguments
Date:   Wed, 12 Aug 2020 17:15:17 -0500
Message-Id: <20200812221518.2869003-1-daniel.diaz@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When using a cross-compilation environment, such as OpenEmbedded,
the CC an CXX variables are set to something more than just a
command: there are arguments (such as --sysroot) that need to be
passed on to the compiler so that the right set of headers and
libraries are used.

For the particular case that our systems detected, CC is set to
the following:

  export CC="aarch64-linaro-linux-gcc  --sysroot=/oe/build/tmp/work/machine/perf/1.0-r9/recipe-sysroot"

Without quotes, detection is as follows:

  Auto-detecting system features:
  ...                         dwarf: [ OFF ]
  ...            dwarf_getlocations: [ OFF ]
  ...                         glibc: [ OFF ]
  ...                          gtk2: [ OFF ]
  ...                        libbfd: [ OFF ]
  ...                        libcap: [ OFF ]
  ...                        libelf: [ OFF ]
  ...                       libnuma: [ OFF ]
  ...        numa_num_possible_cpus: [ OFF ]
  ...                       libperl: [ OFF ]
  ...                     libpython: [ OFF ]
  ...                     libcrypto: [ OFF ]
  ...                     libunwind: [ OFF ]
  ...            libdw-dwarf-unwind: [ OFF ]
  ...                          zlib: [ OFF ]
  ...                          lzma: [ OFF ]
  ...                     get_cpuid: [ OFF ]
  ...                           bpf: [ OFF ]
  ...                        libaio: [ OFF ]
  ...                       libzstd: [ OFF ]
  ...        disassembler-four-args: [ OFF ]

  Makefile.config:414: *** No gnu/libc-version.h found, please install glibc-dev[el].  Stop.
  Makefile.perf:230: recipe for target 'sub-make' failed
  make[1]: *** [sub-make] Error 2
  Makefile:69: recipe for target 'all' failed
  make: *** [all] Error 2

With CC and CXX quoted, some of those features are now detected.

Fixes: e3232c2f39ac ("tools build feature: Use CC and CXX from parent")

Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
---
 tools/build/Makefile.feature | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 774f0b0ca28a..e7818b44b48e 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -8,7 +8,7 @@ endif
 
 feature_check = $(eval $(feature_check_code))
 define feature_check_code
-  feature-$(1) := $(shell $(MAKE) OUTPUT=$(OUTPUT_FEATURES) CC=$(CC) CXX=$(CXX) CFLAGS="$(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1))" CXXFLAGS="$(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))" LDFLAGS="$(LDFLAGS) $(FEATURE_CHECK_LDFLAGS-$(1))" -C $(feature_dir) $(OUTPUT_FEATURES)test-$1.bin >/dev/null 2>/dev/null && echo 1 || echo 0)
+  feature-$(1) := $(shell $(MAKE) OUTPUT=$(OUTPUT_FEATURES) CC="$(CC)" CXX="$(CXX)" CFLAGS="$(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1))" CXXFLAGS="$(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))" LDFLAGS="$(LDFLAGS) $(FEATURE_CHECK_LDFLAGS-$(1))" -C $(feature_dir) $(OUTPUT_FEATURES)test-$1.bin >/dev/null 2>/dev/null && echo 1 || echo 0)
 endef
 
 feature_set = $(eval $(feature_set_code))
-- 
2.25.1

