Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E293DC078
	for <lists+bpf@lfdr.de>; Fri, 30 Jul 2021 23:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbhG3VzD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Jul 2021 17:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbhG3Vy7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Jul 2021 17:54:59 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54521C0613D3
        for <bpf@vger.kernel.org>; Fri, 30 Jul 2021 14:54:54 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id f14-20020a05600c154eb02902519e4abe10so10020493wmg.4
        for <bpf@vger.kernel.org>; Fri, 30 Jul 2021 14:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oR4P9L4KKr44JNTPbDBtIFkptWWblU19aYjH7eeEE94=;
        b=ekgJT8ZTFxMPkmH3ncsyncIA1it6pmJFkW2ngMZRBhF1M9xXJhEikQpwmnr0V4T4/x
         6CoGAo7fxY8NQX93EXcZanEA7PjtZf9RXKWlDbvRfYqJWpOaOAh4FwVxOaxU3crDN/kk
         8Q483lY7InXY8iPholHM6PuUf97zRf6zsLjDXZ6LaEGrpxfXloLHMipMzTxm8077778P
         qdU2D4Sc7e49cfPvcbfQu0lvkc8zEMUoEWzI7/G9cZML6Ik9QiEfrHnxXzACWiu+dRuO
         rttQFevgbuBM4K1mv/QIVCZ+t4UZSisHVw8M4ZbxSIjzVXU83Q4yybXNcXjONwNuHNzk
         dJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oR4P9L4KKr44JNTPbDBtIFkptWWblU19aYjH7eeEE94=;
        b=FBaMgtiXZ8mY84ACQ/vt8H54dE5zAD3oz3utsVNs50IektzsHLQ2KSPf5nSWF4rOGD
         Bq2QqF301XNYP7p8VEMCEDt14T6nODeqRgR9VHHF0Bwl9YQt02Fxkzgywzsec5tG2arL
         RidGb0+vSgasQ7HspOT7b3RV/hXoF2iPDjJFbtoxHdQvoCqHOHT/hsYIo0ykD45xrcSg
         wfJDn5mtGwfnLDQWjH3xBQbxrqNRHl1xiafFVhGKGuvuh7lS0O/BSFOtTTtYTJfLUVjU
         0raooiqBRIh2OZJ1BKMdw8lWW7g2VA1c83FPqV/2Nn5nvDXWbd2kUhjwZvGni08D3XtI
         pZow==
X-Gm-Message-State: AOAM530tzEOru67O+LJvkc/yu781j83WpOxtRXJzXVrmPDw++zEDoLLF
        ofJFV2bT2kVoOWjqxGmNtKPKlA==
X-Google-Smtp-Source: ABdhPJwTNcGSKppCKmqdZqEl+WXEfyRBCCBbcJUMBg5GZmkdGN7j7aTOsnLvWDxMj78Aepn2+dcwgw==
X-Received: by 2002:a7b:ce08:: with SMTP id m8mr5367251wmc.21.1627682092892;
        Fri, 30 Jul 2021 14:54:52 -0700 (PDT)
Received: from localhost.localdomain ([149.86.78.245])
        by smtp.gmail.com with ESMTPSA id v15sm3210871wmj.39.2021.07.30.14.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 14:54:52 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v2 0/7] tools: bpftool: update, synchronise and validate types and options
Date:   Fri, 30 Jul 2021 22:54:28 +0100
Message-Id: <20210730215435.7095-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To work with the different program types, map types, attach types etc.
supported by eBPF, bpftool needs occasional updates to learn about the new
features supported by the kernel. When such types translate into new
keyword for the command line, updates are expected in several locations:
typically, the help message displayed from bpftool itself, the manual page,
and the bash completion file should be updated. The options used by the
different commands for bpftool should also remain synchronised at those
locations.

Several omissions have occurred in the past, and a number of types are
still missing today. This set is an attempt to improve the situation. It
brings up-to-date the lists of types or options in bpftool, and also adds a
Python script to the BPF selftests to automatically check that most of
these lists remain synchronised.

v2:
- Reformat some lines in the bash completion file.
- Do not reformat attach types, to preserve git-blame history.
- Do not call Python script from tools/testing/selftests/bpf/Makefile.

Quentin Monnet (7):
  tools: bpftool: slightly ease bash completion updates
  selftests/bpf: check consistency between bpftool source, doc,
    completion
  tools: bpftool: complete and synchronise attach or map types
  tools: bpftool: update and synchronise option list in doc and help msg
  selftests/bpf: update bpftool's consistency script for checking
    options
  tools: bpftool: document and add bash completion for -L, -B options
  tools: bpftool: complete metrics list in "bpftool prog profile" doc

 .../bpf/bpftool/Documentation/bpftool-btf.rst |  48 +-
 .../bpftool/Documentation/bpftool-cgroup.rst  |   3 +-
 .../bpftool/Documentation/bpftool-feature.rst |   2 +-
 .../bpf/bpftool/Documentation/bpftool-gen.rst |   9 +-
 .../bpftool/Documentation/bpftool-iter.rst    |   2 +
 .../bpftool/Documentation/bpftool-link.rst    |   3 +-
 .../bpf/bpftool/Documentation/bpftool-map.rst |   3 +-
 .../bpf/bpftool/Documentation/bpftool-net.rst |   2 +-
 .../bpftool/Documentation/bpftool-perf.rst    |   2 +-
 .../bpftool/Documentation/bpftool-prog.rst    |  36 +-
 .../Documentation/bpftool-struct_ops.rst      |   2 +-
 tools/bpf/bpftool/Documentation/bpftool.rst   |  12 +-
 tools/bpf/bpftool/bash-completion/bpftool     |  66 +-
 tools/bpf/bpftool/btf.c                       |   3 +-
 tools/bpf/bpftool/cgroup.c                    |   3 +-
 tools/bpf/bpftool/common.c                    |   6 +
 tools/bpf/bpftool/feature.c                   |   1 +
 tools/bpf/bpftool/gen.c                       |   3 +-
 tools/bpf/bpftool/iter.c                      |   2 +
 tools/bpf/bpftool/link.c                      |   3 +-
 tools/bpf/bpftool/main.c                      |   3 +-
 tools/bpf/bpftool/main.h                      |   3 +-
 tools/bpf/bpftool/map.c                       |   5 +-
 tools/bpf/bpftool/net.c                       |   1 +
 tools/bpf/bpftool/perf.c                      |   5 +-
 tools/bpf/bpftool/prog.c                      |   8 +-
 tools/bpf/bpftool/struct_ops.c                |   2 +-
 .../selftests/bpf/test_bpftool_synctypes.py   | 586 ++++++++++++++++++
 28 files changed, 763 insertions(+), 61 deletions(-)
 create mode 100755 tools/testing/selftests/bpf/test_bpftool_synctypes.py

-- 
2.30.2

