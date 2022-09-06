Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588765AEB1B
	for <lists+bpf@lfdr.de>; Tue,  6 Sep 2022 15:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238453AbiIFNri (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 09:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbiIFNq3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 09:46:29 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA43B7F24A
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 06:38:56 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id c131-20020a1c3589000000b003a84b160addso8915168wma.2
        for <bpf@vger.kernel.org>; Tue, 06 Sep 2022 06:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=x99CMymo2dDjTVa5z8o7iAxDkiuX6N5lOPd0KrR5QNE=;
        b=rAiKN4dmSZMuFKF3jx9NBgsGOH2ar+dLfbdIP2UT/f59cnPWFmVO3Z/4xqq1MwUpAC
         XeQl8t0sWMM51XutnD6lMl4lT/l0wc+Z/JmSGQMaSqwwLcdGHqYPxPCu5DY4YI043neR
         QJM39XfR+Y+s9HfO8sLmJ8tB7h5jJweVC1ETt14obNsiJlc5nb4BcIRAb/PLDZ/nA/1L
         GBpL1uuzstFEw7aIJQp8vokdQJQIqFn8vktySvADgFfytO7iwZ/wL60twnG8qrSt0alc
         kSJUhyay8suNNijvs/YkP0ctyCI/Q2M7n1El6UunM6qaIjuTSyTkLxR1LCkhs5l76omP
         w2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=x99CMymo2dDjTVa5z8o7iAxDkiuX6N5lOPd0KrR5QNE=;
        b=zvvVQTC4/OtGMWjAS8gFGwgm7JYka1unzx+mmxxvCVoTyhUQtyxIlmRbcFcLzqLdiD
         Ev7Im2En7I4rYvFN4T9aQwmwL/2T1ns0iMpJMs6cTEOOKkD0OdJ5Gqjd1+4wQY4ZUPC8
         oHUrz8GKR9Qrd61flK/rBpl8L3npKXBlYxrPj5WqpnV4hViqJ31vLKaMFyJPfdH6saM0
         lvxQ/RllQO9jApovFDVX1569FT7+LDjL6NVHd+J554Z76Zx6N/LHy5dt1rL2n5+QmDuv
         2ZVp1Qo5P/2O9fI9uQyCVQVP5M8KafWYva7E7fkGzu8CNkziXmzmAgsUg5IJtNmCZbFE
         vS3A==
X-Gm-Message-State: ACgBeo3HT1lpnxJEkBSkLUmVQscUXZq4iiS9Q7ivWC1BChUglZSAX++7
        6z449Wv8gIDCkctaSaY4eR5gZg==
X-Google-Smtp-Source: AA6agR6UD5O7+cnLv88iB9K5PfBKtg1zUn4mgN97xgDnY27eUhQQebIklrzqc32Z/yjxDijH5gQOoQ==
X-Received: by 2002:a05:600c:4f85:b0:3a6:243d:3b7d with SMTP id n5-20020a05600c4f8500b003a6243d3b7dmr13987288wmq.84.1662471391621;
        Tue, 06 Sep 2022 06:36:31 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id n189-20020a1ca4c6000000b003a5c244fc13sm21775621wme.2.2022.09.06.06.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 06:36:31 -0700 (PDT)
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
Subject: [PATCH bpf-next 0/7] bpftool: Add LLVM as default library for disassembling JIT-ed programs
Date:   Tue,  6 Sep 2022 14:36:06 +0100
Message-Id: <20220906133613.54928-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
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

Quentin Monnet (7):
  bpftool: Define _GNU_SOURCE only once
  bpftool: Remove asserts from JIT disassembler
  bpftool: Split FEATURE_TESTS/FEATURE_DISPLAY definitions in Makefile
  bpftool: Group libbfd defs in Makefile, only pass them if we use
    libbfd
  bpftool: Refactor disassembler for JIT-ed programs
  bpftool: Add LLVM as default library for disassembling JIT-ed programs
  bpftool: Add llvm feature to "bpftool version"

 .../bpftool/Documentation/common_options.rst  |   8 +-
 tools/bpf/bpftool/Makefile                    |  65 +++--
 tools/bpf/bpftool/common.c                    |   2 +
 tools/bpf/bpftool/iter.c                      |   2 +
 tools/bpf/bpftool/jit_disasm.c                | 244 ++++++++++++++----
 tools/bpf/bpftool/main.c                      |  10 +
 tools/bpf/bpftool/main.h                      |  29 ++-
 tools/bpf/bpftool/map.c                       |   1 -
 tools/bpf/bpftool/net.c                       |   2 +
 tools/bpf/bpftool/perf.c                      |   2 +
 tools/bpf/bpftool/prog.c                      |  17 +-
 tools/bpf/bpftool/xlated_dumper.c             |   2 +
 12 files changed, 291 insertions(+), 93 deletions(-)

-- 
2.34.1

