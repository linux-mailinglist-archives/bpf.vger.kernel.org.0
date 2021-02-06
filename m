Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BF2311EFE
	for <lists+bpf@lfdr.de>; Sat,  6 Feb 2021 18:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhBFRE3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Feb 2021 12:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBFRE1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Feb 2021 12:04:27 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828A9C06174A
        for <bpf@vger.kernel.org>; Sat,  6 Feb 2021 09:03:47 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id a16so5168509plh.8
        for <bpf@vger.kernel.org>; Sat, 06 Feb 2021 09:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=H4cezS5QnSNmcJmgECpiNInHGlmR063+pidN+nlfYDY=;
        b=GZ/868UIkH4D049tXl/mSubZQq/HqGbJvx/pSoAWUfy+TQs4vF0JA1rlDe3+4WV8dE
         DiAyLF03zyZvTtXN4E6AJMAOllBcaHLJHEdIlXVkREUBqKitNiq/ZWzxNEYUbF6Qk5iq
         okRGyum7SFwIWlT4PqAyU3/nkkiBEcR2N2PrJOXtx/lXb5d10HcLbYJ/FfIDrUEfssko
         kisSjL1wWUJcqY3a65S5mihG+gFHsXGl538ePKwUFa9j4sZ5GFNKNz1sbBiWIPJ7UH3a
         ntrbgYkDBqSLGnxN9pctquzxSodbJ5LuX/XRJRNxZhIgG4eAEKnEZPUSPFuAoYlmhI/p
         kKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H4cezS5QnSNmcJmgECpiNInHGlmR063+pidN+nlfYDY=;
        b=pzZ44byeMBS4IgJNOw26yIbw6ggjBoXSnxHll/mpPt4YG/juGx3yFGojsi0QP7i3c1
         1LPHMfon+NTIWCViFXpf7r+SXeVRwBUqiRFhnrAe/a6GhPuKssvNUO596yNICwgZuvZW
         ZFTPQNNHp1uCF63Wf73vg4Fb0gUh21UbRFuGjhtbYH/O6Vx6NkliyFAOm2qUepQ0bGJE
         F1UcyobnJKe0SMKa1UN3E/Bxw7VQ6DcyX8lS0TwPa8v/yFf+xU2iEcf32DjlG931e+lY
         qt0eQgmEptHPxETM0Hc0xvEM3KCRaXvwsFsni6VpbWRgI1U8hBj+GHTqM3u8nyN079RK
         rk0A==
X-Gm-Message-State: AOAM533LIEELGnLeIrSR6edfLuzmRWfgf0hnYabQ6NOtTl3VVkWK0B5l
        aCrSqFrsAbzC+6tUvisJRDg=
X-Google-Smtp-Source: ABdhPJxo8K8pbyRQLdykA1fgUfTMcukp5D6j29DwLxrd4k6gJZIWu9USxjsJ4lirfBOdosmxZFGqzw==
X-Received: by 2002:a17:90a:7f8a:: with SMTP id m10mr9262756pjl.102.1612631026937;
        Sat, 06 Feb 2021 09:03:46 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id j14sm11149964pjl.35.2021.02.06.09.03.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Feb 2021 09:03:46 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 bpf-next 0/7] bpf: Misc improvements
Date:   Sat,  6 Feb 2021 09:03:37 -0800
Message-Id: <20210206170344.78399-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Several improvements:
- optimize prog stats
- compute stats for sleepable progs
- prevent recursion fentry/fexit and sleepable progs
- allow map-in-map and per-cpu maps in sleepable progs

Alexei Starovoitov (7):
  bpf: Optimize program stats
  bpf: Compute program stats for sleepable programs
  bpf: Add per-program recursion prevention mechanism
  selftest/bpf: Add a recursion test
  bpf: Count the number of times recursion was prevented
  bpf: Allows per-cpu maps and map-in-map in sleepable programs
  selftests/bpf: Add a test for map-in-map and per-cpu maps in sleepable
    progs

 arch/x86/net/bpf_jit_comp.c                   | 46 ++++++++-----
 include/linux/bpf.h                           | 16 ++---
 include/linux/filter.h                        | 12 +++-
 include/uapi/linux/bpf.h                      |  1 +
 kernel/bpf/core.c                             | 16 +++--
 kernel/bpf/hashtab.c                          |  4 +-
 kernel/bpf/syscall.c                          | 16 +++--
 kernel/bpf/trampoline.c                       | 59 +++++++++++++---
 kernel/bpf/verifier.c                         |  9 ++-
 tools/bpf/bpftool/prog.c                      |  5 ++
 tools/include/uapi/linux/bpf.h                |  1 +
 .../selftests/bpf/prog_tests/fexit_stress.c   |  2 +-
 .../selftests/bpf/prog_tests/recursion.c      | 33 +++++++++
 .../bpf/prog_tests/trampoline_count.c         |  4 +-
 tools/testing/selftests/bpf/progs/lsm.c       | 69 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/recursion.c | 46 +++++++++++++
 16 files changed, 282 insertions(+), 57 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/recursion.c
 create mode 100644 tools/testing/selftests/bpf/progs/recursion.c

-- 
2.24.1

