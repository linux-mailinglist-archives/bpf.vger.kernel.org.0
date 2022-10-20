Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEDA606058
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 14:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiJTMhX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 08:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiJTMhV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 08:37:21 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA158495C0
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 05:37:19 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i9so1007241wrv.5
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 05:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Op65lAhBw6SfQpttbf1EU5zxcamK/QNu4qZbYd8JLI=;
        b=Ng6sHVSEkpKmvU0iC/6koigYqpH/UvaTQrUCXUI0smqpU3/qpkn2abu7h/WDmNnMk7
         NpxVRfqtDe0CTpRQg1fWoRozV73wmNXcE9usj5JSTJsddSBCtaFxF720E7FMoa0tpNQV
         KJJ4BVfs+55topofJnLOkFUwAiNYGAwk5SLc/ARMS0qcnEBqLlgfoZHhvKDPFA77p+eT
         eRtvZBUmsckROQXKhqvEGF7wBFTMEYDI3/+3KakyMCZeccyOdZOJoPbOhAIh/tX1O5xg
         K/DSRFkotaxQq9YQ1w4QeLzJvtxd8BLuscQMT4wmUEtMQMijHYekFriKlc650bq4yyUI
         wQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Op65lAhBw6SfQpttbf1EU5zxcamK/QNu4qZbYd8JLI=;
        b=oawX+eBikbBPyEJUQ7glm/6g5KGQ8I3u1n+Po0zeDzHBCbIc/FlyRVHvWYXHVU2ISc
         u5sn7Wk/WgGtQeRgnH1CY7vaJiH5AhYpxsZblzXAGhULYTCkexLQyChEgUvQ2+Sv4zNZ
         +8RUsAFoZ0MrdPn1q1hZxtUssutoO8ZHJ4edDLLXjdvWojbNjk8u97z+UBCVY4bINAct
         /y2NsOqqnG+iHPsIy7U4q524g5P+xRaje8H4ySquXx/6/6H7FaHM2oJjwZD+OtSqEke3
         aqdqSzODm7mhi1TDqaCcvPK8Tr1HndN4kDDHy5d+ECylkWG4qh2huT0oSKm6sR1OyY8P
         U7Zw==
X-Gm-Message-State: ACrzQf1o0iLwm3qH5r1+Eqd+/kLZ9o91nZy0KcAaPLtqjtJ+ZUbhUmdi
        QRHs+jz9fuL/0F4Ydw/zlCkNAw==
X-Google-Smtp-Source: AMsMyM4ZR6RuUtwAEXXcyUsBKiLdaqq6TubMuMx3IvLRz26HCG43Tuy5F2SD8Oal9FGAdODi4hKH0A==
X-Received: by 2002:adf:e109:0:b0:225:4ca5:80d5 with SMTP id t9-20020adfe109000000b002254ca580d5mr8393794wrz.465.1666269438372;
        Thu, 20 Oct 2022 05:37:18 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d504a000000b0022a9246c853sm16329581wrt.41.2022.10.20.05.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 05:37:17 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 0/8] bpftool: Add LLVM as default library for disassembling JIT-ed programs
Date:   Thu, 20 Oct 2022 13:36:56 +0100
Message-Id: <20221020123704.91203-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

v3:
  - Extend commit description (patch 6) with notes on llvm-dev and
    LLVM's disassembler stability.

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

