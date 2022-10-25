Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA1360CFDD
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 17:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiJYPDl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 11:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiJYPDl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 11:03:41 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEA11B2BBD
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 08:03:40 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id o4so13350452wrq.6
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 08:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eBbYbX9sHKUfIMrpnZaL6KkPE/xXyNGMbm/Q+qNbw/0=;
        b=AQsZdynBJycLXcQFN/uiFmTA9TyPBOOrMp8Pn4k+o43hjc8tIpwOtcsdy3tJlhQksU
         ZLkXs1x/j6dVzi0inaWopBaWyb1DHQttwFsyNGJRRJRwNd/xw/ecCGKWPXfzKIe7FuMb
         sWkmNd1dBQnaIpFAPXVZft5DK5D0QUF5xI1vJ6CH7Fl2e76Ofq0HOIOE4Zurk6Gs8Z7M
         ZKUtJo9keuK5ZgVroV4grxi/qyQ0xYV2Z2r0rzPhqJ17su3DTyg9DEURzwTbGvpuKLVd
         +9JqCJyTrcjFzVv8CafOHA4F4fFP4JW/hia9hCmR2IfvhOupKW5bAiO6oGJVnI25mYNU
         zVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eBbYbX9sHKUfIMrpnZaL6KkPE/xXyNGMbm/Q+qNbw/0=;
        b=UOtJJZCMX0ZekM0J2c89VQ3ee97Cw4iOdtTrLreBVnUmGP2GN+CU+NsLFISASycxi5
         8O0DAmE5+XVCt6Sm7P12zBcoCg4Z6kAe3FK+5sp5xlrvTEBq5cKElRxNxpQt4Kmlvkiv
         LVBYKbfvelVugukd1UCHPIghU7MFx4Vwt2W6fDRgzKHG8m0dP1pbM1euC+2BdGLE+JPX
         5ZTJ2HCOvMcdIUZOMxf1Aqj5248Zd2EhdqXzwY57YnuetCZKx0dqjU4QlVnJbRs8TVsA
         mebfV0llKSxVvj+vV0kxP+lupddIjVceG0nl7BjOEdh0mCzpSnK1VsxjEBPIuy8ihs78
         hS6A==
X-Gm-Message-State: ACrzQf1+cTZft05LisuVlm05DLiZhKM0euIqTeKjc4WCvDOK1aIJXq0W
        yo+I+HlBlZUkKm8bWNa4deNxEQ==
X-Google-Smtp-Source: AMsMyM4S5DzWOTqk9/JrqYZOzVr147r+/Ixh5cbRuet+x5/DfeWTij3k3O0g3T9TtNEIQrlK4rnFGg==
X-Received: by 2002:a5d:5c13:0:b0:236:5575:a3fd with SMTP id cc19-20020a5d5c13000000b002365575a3fdmr15253202wrb.475.1666710218593;
        Tue, 25 Oct 2022 08:03:38 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id i7-20020adff307000000b0023659925b2asm2724182wro.51.2022.10.25.08.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 08:03:37 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 0/8] bpftool: Add LLVM as default library for disassembling JIT-ed programs
Date:   Tue, 25 Oct 2022 16:03:21 +0100
Message-Id: <20221025150329.97371-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

v4:
  - Rebase to address a conflict with commit 2c76238eaddd ("bpftool: Add
    "bootstrap" feature to version output").

v3:
  - Extend commit description (patch 6) with notes on llvm-dev and LLVM's
    disassembler stability.

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
 tools/bpf/bpftool/main.c                      |   7 +
 tools/bpf/bpftool/main.h                      |  32 +--
 tools/bpf/bpftool/map.c                       |   1 -
 tools/bpf/bpftool/net.c                       |   2 +
 tools/bpf/bpftool/perf.c                      |   2 +
 tools/bpf/bpftool/prog.c                      |  23 +-
 tools/bpf/bpftool/xlated_dumper.c             |   2 +
 12 files changed, 319 insertions(+), 105 deletions(-)

-- 
2.34.1

