Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6D96C88F3
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 00:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjCXXC2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 19:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjCXXC1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 19:02:27 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3061DB84
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 16:02:24 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e18so3216689wra.9
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 16:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679698943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uSgCOA0MnpM5H6jLzcm2Saf3Yw8Vr2r+856bEhlBba0=;
        b=U5Ao1yi+7r2S1cwwiHTlHSa/CJJiRqOVEo3keFazzm66WHUMnzChcSYik7hP+jUntG
         st8zUcKCPiyHW6KYTH8me7Y3JCyhGSsYerMX1NkCgO3gqkEnZDo9WaJoovIxULKQi43H
         DQ+cU/PIe+Y5Ql4PQ1Os7OoeRkDrsvcUFIneK06PzOEueZvaw3LHvwmTVo3FI7d3JYoZ
         QjR48udw+UkGc5XAK+hPUGF7atjNLD1p9S9WBszfCH/MY6H3LqH0uFgttzWsDb9j9DKl
         rSEbC5JU8nF33FEBY6e4pczATH022FTOF+X91L3wa8b17QOUdy4KqQbIhf3WRobh0rXq
         yuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679698943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uSgCOA0MnpM5H6jLzcm2Saf3Yw8Vr2r+856bEhlBba0=;
        b=mAQaezu3dCc+hjvL84ri7QleLe/DAtt1DDcE0Fzi/OOfLWizcOVopqfg6uQ6bvzd3k
         +NVX/bQuO+dlBuuyX+hNZ/dBVQQRQbR9+ynt5eLhvWchTC3cJ0UlwenILBFLe9e+BJZi
         sTv8qC/DYHnycg8NwsPUWEdcULvea05rxW1PS6AHnuRiVYCwdfPg/4fz2ayjl3nhUK8f
         ijrZtHt20WSW5Jarzp3fM2OYUUTQj4cDx1Cr2+xm8ew5nS9t4OZonn8lWwo6uu88k95l
         WHh5lf45c5tzerqQ7Lva4lmiuq2RAI6HH/wPR6EGAPr8dSWJlBOtaf5v8BzIgjAlFXFi
         7YrA==
X-Gm-Message-State: AAQBX9d0eYbP3hj7lT/v5xD6FCbrtpZ6+cPuN8ofs/znjci2VvzBDVBx
        +feUK9bNHtGbO1u0ffOGwUAj6g==
X-Google-Smtp-Source: AKy350bMZEbRrDdbeNNdQ6BflXUOoXIwWFHVQ8Jww6mB9+syUzGys5KN5/rNrgO35NicwlJjBEd/Zw==
X-Received: by 2002:adf:ef91:0:b0:2ce:a697:75c7 with SMTP id d17-20020adfef91000000b002cea69775c7mr3525511wro.33.1679698943313;
        Fri, 24 Mar 2023 16:02:23 -0700 (PDT)
Received: from harfang.fritz.box ([2a02:8011:e80c:0:c17f:3e3e:3455:90b])
        by smtp.gmail.com with ESMTPSA id c16-20020adffb50000000b002c56179d39esm19340342wrs.44.2023.03.24.16.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 16:02:22 -0700 (PDT)
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
        bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 0/5] bpftool: Add inline annotations when dumping program CFGs
Date:   Fri, 24 Mar 2023 23:02:04 +0000
Message-Id: <20230324230209.161008-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This set contains some improvements for bpftool's "visual" program dump
option, which produces the control flow graph in a DOT format. The main
objective is to add support for inline annotations on such graphs, so that
we can have the C source code for the program showing up alongside the
instructions, when available. The last commits also make it possible to
display the line numbers or the bare opcodes in the graph, as supported by
regular program dumps.

Quentin Monnet (5):
  bpftool: Fix documentation about line info display for prog dumps
  bpftool: Fix bug for long instructions in program CFG dumps
  bpftool: Support inline annotations when dumping the CFG of a program
  bpftool: Support "opcodes", "linum", "visual" simultaneously
  bpftool: Support printing opcodes and source file references in CFG

 .../bpftool/Documentation/bpftool-prog.rst    | 18 ++---
 tools/bpf/bpftool/bash-completion/bpftool     | 18 +++--
 tools/bpf/bpftool/btf_dumper.c                | 51 ++++++++++++
 tools/bpf/bpftool/cfg.c                       | 29 +++----
 tools/bpf/bpftool/cfg.h                       |  5 +-
 tools/bpf/bpftool/main.h                      |  2 +
 tools/bpf/bpftool/prog.c                      | 78 ++++++++++---------
 tools/bpf/bpftool/xlated_dumper.c             | 52 ++++++++++++-
 tools/bpf/bpftool/xlated_dumper.h             |  3 +-
 9 files changed, 184 insertions(+), 72 deletions(-)

-- 
2.34.1

