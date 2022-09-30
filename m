Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEF45F140F
	for <lists+bpf@lfdr.de>; Fri, 30 Sep 2022 22:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiI3Urc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 16:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiI3Ur3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 16:47:29 -0400
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D648201929;
        Fri, 30 Sep 2022 13:47:26 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id z18so3322760qvn.6;
        Fri, 30 Sep 2022 13:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=avgh96KHnp1/02mPbLaGLGdS7exVjQdcGWGdYgCQdZw=;
        b=Mm8MkLS17beFMhRojTH2ujKwX7alzWZXg0PzW5lycunAgJRZfam7yHK1O4eifG8q4D
         /TJLej68fdzkySucELk0MJpvNJ3t/zkB5C7ubAofX+KlvEqcjcbMNpWnTjTiYzJiNnX+
         IK1rzy9cXJE4q6583lptsqyosuPLmUn6GMfRRHnh1fCrBS+CeFXwqhw+3DbFlefqLrbc
         nwsi8qWrRDtidjUYlwHw5+OV1/wPFUJHMZ+kSbhMfR0yI85utUpe6Qvh0qFiuugu6ZPn
         OdJ6tH/rJK7rpZOZals8PUF8VzDYeB6KZxo4ItPRS/D+fUx6pXi4SsaDkuN8POhj5zvD
         bKkw==
X-Gm-Message-State: ACrzQf3MplBtg3MRpVA80STXHhDK4qKPwd/O+/mGlgxtC/FBN4z5qW19
        NM98JFOoZMfZy+5dB6JK3v6bTOV7naRN5PBz
X-Google-Smtp-Source: AMsMyM719Hjm4fE0vSD1nSQDycI5onIY+0W5O9+673bFItH7X0RmRjo5ygZNetNErayx/Y6Yv/XoDg==
X-Received: by 2002:a05:6214:29e8:b0:4ad:8cb6:9d39 with SMTP id jv8-20020a05621429e800b004ad8cb69d39mr8294865qvb.20.1664570844898;
        Fri, 30 Sep 2022 13:47:24 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::dcb2])
        by smtp.gmail.com with ESMTPSA id bq36-20020a05620a46a400b006bb29d932e1sm2987491qkb.105.2022.09.30.13.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 13:47:24 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev
Cc:     kernel-team@fb.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yhs@fb.com, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        memxor@gmail.com
Subject: [PATCH 0/2] Support storing struct task_struct objects as kptrs
Date:   Fri, 30 Sep 2022 15:47:18 -0500
Message-Id: <20220930204720.3116493-1-void@manifault.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that BPF supports adding new kernel functions with kfuncs, and storing
kernel objects in maps with kptrs, we can add a set of kfuncs which allow
struct task_struct objects to be stored in maps as referenced kptrs.

The possible use-cases for doing this are plentiful.  During tracing,
for example, it would be useful to be able to collect some tasks that
performed a certain operation, and then periodically summarize who they
are, which cgroup they're in, how much CPU time they've spent, etc.
Doing this now would require storing the task's pids along with some
relevant data to be exported to user space, and later associating the
pids to tasks in other event handlers where the data is recorded.
Another useful by-product of this is that it allows a program to pin a
task, and by proxy therefore also pin its task local storage.

This patch set adds this aforementioned set of kfuncs, along with a new
selftest suite for validation.

David Vernet (2):
  bpf: Add kfuncs for storing struct task_struct * as a kptr
  bpf/selftests: Add selftests for new task kfuncs

 kernel/bpf/helpers.c                          |  75 ++++++++-
 .../selftests/bpf/prog_tests/task_kfunc.c     | 152 ++++++++++++++++++
 .../selftests/bpf/progs/task_kfunc_common.h   |  82 ++++++++++
 .../selftests/bpf/progs/task_kfunc_failure.c  | 132 +++++++++++++++
 .../selftests/bpf/progs/task_kfunc_success.c  | 111 +++++++++++++
 5 files changed, 551 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_kfunc_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/task_kfunc_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_kfunc_success.c

--
2.37.3

