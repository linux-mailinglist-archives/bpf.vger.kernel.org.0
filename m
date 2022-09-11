Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39ACC5B5115
	for <lists+bpf@lfdr.de>; Sun, 11 Sep 2022 22:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiIKUPA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Sep 2022 16:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIKUO7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Sep 2022 16:14:59 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC1513FAD
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 13:14:57 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bq9so12315752wrb.4
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 13:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=N6hkRxS6q5f5lV8QADM8mkfoMtaHf3+J3PmlbhzqNjk=;
        b=vKZ3mQah1KT5vNLO/Y4qy1izztM1XbfP2sVlsSRaPhW/8nJ5WTL1tKad2l3Fe15sH8
         m8mnXEv/M6I/fIY9Kf/5pvDAet+2p91snu50ZIyBOiikvu8sh2BQqOvIBLxmXg9JOh0O
         IIyA5qFVvrxJdamg35pFtdQ3ZBfwWTNfg+PigpjAdBA5nO1QG6hkqwTslC5b/+vg6Pd3
         uZiuQMSkYQSdp7kYE0TOQnN+TCphauxo6OQzrdYoV2NEj+SjsLBwPDIvNJZEAhxGSW4R
         8ykugKshqYoWenun/fjY32AkH6CNP8Trc7pfEy3f8FRqkMbQdIBWV8CSWcVSyWpFaCaH
         lIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=N6hkRxS6q5f5lV8QADM8mkfoMtaHf3+J3PmlbhzqNjk=;
        b=cwLcLbFVg7e8qywPMfl89MafGEPJJdejQWBRVLi85J+9GhXRDt7ajYfhVPTtOKV1Sh
         oArbo4/APzfcfYbi5XTok/RkbGl3bUbRGCjkI2R22wldz9IQb5zSPIGJbw5APfnkIsB3
         cRZcIlxU2fNGLIAhNI/0MLHLFFNY11+BGs9/UyNiuU2JnU8fsz9Y8e+dHPqUKyfQN5Hr
         9yz6RvU6hwnvlTNrv3VLsNp/6SflOYU2xcPCd0i3MJFqZiK9N8wdWZEmi6wkZ0dfUGwP
         J4ne0bvhkgid+U5t4wXRNvUs8aB8GKIwYKa+x1qWE2RwrOwZGokcPcDxDDjHFNrKBBHO
         n/Gg==
X-Gm-Message-State: ACgBeo2vZVaxi3fjktfC2I423CIqTuc55ebXqJSvOyTCdF0MSau83Y1v
        Cj/eEqy7gk48lQJD9O0yAjbOKg==
X-Google-Smtp-Source: AA6agR7EsNWnX7Kh6ccKQS7c6QFbaPlooauWU/e11q9o5jpSWOZV2k8P4iWw2fn3iMCIaw84JRKM/w==
X-Received: by 2002:a5d:65c2:0:b0:228:68b7:e7b2 with SMTP id e2-20020a5d65c2000000b0022868b7e7b2mr13128521wrw.440.1662927296035;
        Sun, 11 Sep 2022 13:14:56 -0700 (PDT)
Received: from harfang.access.network ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id bh16-20020a05600c3d1000b003a60ff7c082sm7603789wmb.15.2022.09.11.13.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 13:14:54 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v2 0/8] bpftool: Add LLVM as default library for disassembling JIT-ed programs
Date:   Sun, 11 Sep 2022 21:14:43 +0100
Message-Id: <20220911201451.12368-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To disassemble instructions for JIT-ed programs, bpftool has relied on the
libbfd library. This has been problematic in the past: libbfd's interface
is not meant to be stable and has changed several times, hence the
detection of the two related features from the Makefile
(disassembler-four-args and disassembler-init-styled). When it comes to
shipping bpftool, this has also caused issues with several distribution
maintainers unwilling to support the feature (for example, Debian's page
for binutils-dev, libbfd's package, says: "Note that building Debian
packages which depend on the shared libbfd is Not Allowed.").

This patchset adds support for LLVM as the primary library for
disassembling instructions for JIT-ed programs.

We keep libbfd as a fallback. One reason for this is that currently it
works well, we have all we need in terms of features detection in the
Makefile, so it provides a fallback for disassembling JIT-ed programs if
libbfd is installed but LLVM is not. The other reason is that libbfd
supports nfp instruction for Netronome's SmartNICs and can be used to
disassemble offloaded programs, something that LLVM cannot do (Niklas
confirmed that the feature is still in use). However, if libbfd's interface
breaks again in the future, we might reconsider keeping support for it.

v2:
  - Pass callback when creating the LLVM disassembler, so that the
    branch targets are printed as addresses (instead of byte offsets).
  - Add last commit to "support" other arch with LLVM, although we don't
    know any supported triple yet.
  - Use $(LLVM_CONFIG) instead of llvm-config in Makefile.
  - Pass components to llvm-config --libs to limit the number of
    libraries to pass on the command line, in Makefile.
  - Rebase split of FEATURE_TESTS and FEATURE_DISPLAY in Makefile.

Quentin Monnet (8):
  bpftool: Define _GNU_SOURCE only once
  bpftool: Remove asserts from JIT disassembler
  bpftool: Split FEATURE_TESTS/FEATURE_DISPLAY definitions in Makefile
  bpftool: Group libbfd defs in Makefile, only pass them if we use
    libbfd
  bpftool: Refactor disassembler for JIT-ed programs
  bpftool: Add LLVM as default library for disassembling JIT-ed programs
  bpftool: Support setting alternative arch for JIT disasm with LLVM
  bpftool: Add llvm feature to "bpftool version"

 .../bpftool/Documentation/common_options.rst  |   8 +-
 tools/bpf/bpftool/Makefile                    |  72 +++--
 tools/bpf/bpftool/common.c                    |  12 +-
 tools/bpf/bpftool/iter.c                      |   2 +
 tools/bpf/bpftool/jit_disasm.c                | 261 +++++++++++++++---
 tools/bpf/bpftool/main.c                      |  10 +
 tools/bpf/bpftool/main.h                      |  32 +--
 tools/bpf/bpftool/map.c                       |   1 -
 tools/bpf/bpftool/net.c                       |   2 +
 tools/bpf/bpftool/perf.c                      |   2 +
 tools/bpf/bpftool/prog.c                      |  23 +-
 tools/bpf/bpftool/xlated_dumper.c             |   2 +
 12 files changed, 322 insertions(+), 105 deletions(-)

-- 
2.34.1

