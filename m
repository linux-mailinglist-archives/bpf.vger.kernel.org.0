Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1081675DE8
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 20:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjATTZ0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 14:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjATTZZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 14:25:25 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2F1743BD;
        Fri, 20 Jan 2023 11:25:23 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id e8so4967951qts.1;
        Fri, 20 Jan 2023 11:25:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/kc7AaPOcHteOKew81r1S1dAZ0Mdp93MYKSIOizaI3Q=;
        b=S/AX5GnQGTPeyLSpHgPwJS8dKQjnxvc0JmBLrKZIQR/RKwUQlpwcM6BI4Gfo9yhmhh
         3jx4hynulY/+dRSoPOweAsitzfK0jEMaWemoQtJKHDHYo85V5mtU9eqgdUaOub5gxPbw
         QKflG2ERM944wCFEe3FJt2sNFya2+rgFfjw7TOzE4Wnk6602B2JomjXYUZ6qtv/TnNzG
         UU7AW0CVnOMFtzWlS/aOjP39ffWaTEYq0xjhdRX787hWu4Is1WHn0PFFvwEcBhCj/tYy
         3tWyYcGN1Pgjp80+3vTsJk+6I3J6mNmPPnXwak1V8X2PGPHySGuaVIffk4eAFH1YVI1G
         F/Eg==
X-Gm-Message-State: AFqh2kqM+gDzgzCGz5LGr0d1umh+tW77qxfPKvujSgCcmAujHs5p9gtw
        ktca/u+PqCAEZhUPdknfCypyofkSZ+rQVfkl
X-Google-Smtp-Source: AMrXdXvbmmhovr2O8WBwfllqoHWPU9P1TiQItq7rJ0pEUEjg+ZIxIrUPlBytoWGXJdGDwR9/VL+MAA==
X-Received: by 2002:ac8:1207:0:b0:3b6:310f:a170 with SMTP id x7-20020ac81207000000b003b6310fa170mr21558799qti.9.1674242721889;
        Fri, 20 Jan 2023 11:25:21 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:2fc9])
        by smtp.gmail.com with ESMTPSA id g25-20020ac870d9000000b003b63238615fsm7694888qtp.46.2023.01.20.11.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 11:25:21 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org, memxor@gmail.com
Subject: [PATCH bpf-next v2 0/9] Enable cpumasks to be used as kptrs
Date:   Fri, 20 Jan 2023 13:25:14 -0600
Message-Id: <20230120192523.3650503-1-void@manifault.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is part 2 of https://lore.kernel.org/all/20230119235833.2948341-1-void@manifault.com/

Changelog:
----------
v1 -> v2:
- Put back 'static' keyword in bpf_find_btf_id()
  (kernel test robot <lkp@intel.com>)
- Surround cpumask kfuncs in __diag() blocks to avoid no-prototype build
  warnings (kernel test robot <lkp@intel.com>)
- Enable ___init suffixes to a type definition to signal that a type is
  a nocast alias of another type. That is, that when passed to a kfunc
  that expects one of the two types, the verifier will reject the other
  even if they're equivalent according to the C standard (Kumar and
  Alexei)
- Reject NULL for all trusted args, not just PTR_TO_MEM (Kumar)
- Reject both NULL and PTR_MAYBE_NULL for all trusted args (Kumar and
  Alexei )
- Improve examples given in cpumask documentation (Alexei)
- Use __success macro for nested_trust test (Alexei)
- Fix comment typo in struct bpf_cpumask comment header.
- Fix another example in the bpf_cpumask doc examples.
- Add documentation for ___init suffix change mentioned above.

David Vernet (9):
  bpf: Enable annotating trusted nested pointers
  bpf: Allow trusted args to walk struct when checking BTF IDs
  bpf: Disallow NULLable pointers for trusted kfuncs
  bpf: Enable cpumasks to be queried and used as kptrs
  selftests/bpf: Add nested trust selftests suite
  selftests/bpf: Add selftest suite for cpumask kfuncs
  bpf/docs: Document cpumask kfuncs in a new file
  bpf/docs: Document how nested trusted fields may be defined
  bpf/docs: Document the nocast aliasing behavior of ___init

 Documentation/bpf/cpumasks.rst                | 396 +++++++++++++++
 Documentation/bpf/index.rst                   |   1 +
 Documentation/bpf/kfuncs.rst                  |  76 ++-
 include/linux/bpf.h                           |   8 +
 kernel/bpf/Makefile                           |   1 +
 kernel/bpf/btf.c                              | 122 +++++
 kernel/bpf/cpumask.c                          | 477 ++++++++++++++++++
 kernel/bpf/verifier.c                         |  67 ++-
 tools/testing/selftests/bpf/DENYLIST.s390x    |   2 +
 .../selftests/bpf/prog_tests/cgrp_kfunc.c     |   4 +-
 .../selftests/bpf/prog_tests/cpumask.c        |  74 +++
 .../selftests/bpf/prog_tests/nested_trust.c   |  12 +
 .../selftests/bpf/prog_tests/task_kfunc.c     |   4 +-
 .../selftests/bpf/progs/cpumask_common.h      | 114 +++++
 .../selftests/bpf/progs/cpumask_failure.c     | 125 +++++
 .../selftests/bpf/progs/cpumask_success.c     | 426 ++++++++++++++++
 .../selftests/bpf/progs/nested_trust_common.h |  12 +
 .../bpf/progs/nested_trust_failure.c          |  33 ++
 .../bpf/progs/nested_trust_success.c          |  31 ++
 19 files changed, 1976 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/bpf/cpumasks.rst
 create mode 100644 kernel/bpf/cpumask.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cpumask.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/nested_trust.c
 create mode 100644 tools/testing/selftests/bpf/progs/cpumask_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/cpumask_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/cpumask_success.c
 create mode 100644 tools/testing/selftests/bpf/progs/nested_trust_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/nested_trust_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/nested_trust_success.c

-- 
2.39.0

