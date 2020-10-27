Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975E929BF92
	for <lists+bpf@lfdr.de>; Tue, 27 Oct 2020 18:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1815587AbgJ0RDZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Oct 2020 13:03:25 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42173 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1815581AbgJ0RDY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Oct 2020 13:03:24 -0400
Received: by mail-ed1-f66.google.com with SMTP id v19so2189077edx.9
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2020 10:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VcwOwa9EHhzsLgIT0w+isolvWhZrELRj+sCf5wcyL5o=;
        b=bu6iuWWpweGAMhCSz/ektPdwFCA/R7pnbEw9LoYrlMJ+sbahe1oO6FFaIjNuaVzpZx
         Uf9AuMFXhFodPPYhIIjV4xpMslgCGY3fp8ZqAMvOr9FZzlzjW4pt7+tZavv//VfZVtVy
         EAKFROGybNBzpGmu9Vs+lckBwI/oAvY0L4SVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VcwOwa9EHhzsLgIT0w+isolvWhZrELRj+sCf5wcyL5o=;
        b=FpJzMt/NwDhk3BAhrL0ZQQWiiQP2TOQno52wLoDC2fXt9oMk+znBTWixETsgqkP5H0
         1kJgkNpu/VP7sYFzWexQizdfDV5iE9M9rwolbaJiHTtGZr/p6C78CAgv2gsOKTOpdpIT
         If0EQZgIzpgrNHMmr1WHcqBwhepbcyiJWTbIzT9DCpK0HoYyyFY1V1cYT/A8eHfKdo0K
         GOggMtzuWrTteoV76VUeTTUXTrOtl8NzwLZiENumbnmheY419ABQltUrPtQiRMNOQHVp
         JVosR37fTrEyKLydPaVzG6TMwQZwt/wJDTUozxOwGM23quZCcwbo9Q5pYbp+JVT+i61n
         Dgkw==
X-Gm-Message-State: AOAM532MwWjKSXvNayVVW/fKSReGKcjTMYEwbGjlTijKUNz51Th0uDr8
        ns0za8VfZI5jOuz1LGVWffkhXw==
X-Google-Smtp-Source: ABdhPJxr6mJXRzOgH1Mizg8jwVSb6kkt7H3J5bQ1rwoJ4/eDrIB7JU+oab7eG697io25gxJbaFOdXA==
X-Received: by 2002:a50:fc85:: with SMTP id f5mr3345693edq.187.1603818201541;
        Tue, 27 Oct 2020 10:03:21 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id ba6sm1315006edb.61.2020.10.27.10.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 10:03:20 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next 0/5]  Implement task_local_storage
Date:   Tue, 27 Oct 2020 18:03:12 +0100
Message-Id: <20201027170317.2011119-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

We already have socket and inode local storage since [1]

This patch series:

* Implements bpf_local_storage for task_struct.
* Implements the bpf_get_current_task_btf helper which returns a BTF
  pointer to the current task. Not only is this generally cleaner
  (reading from the task_struct currently requires BPF_CORE_READ), it
  also allows the BTF pointer to be used in task_local_storage helpers.
* In order to implement this helper, a RET_PTR_TO_BTF_ID is introduced
  which works similar to RET_PTR_TO_BTF_ID_OR_NULL but does not require
  a nullness check.
* Implements a detection in selftests which uses the
  task local storage to deny a running executable from unlinking itself.


[1]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=f836a56e84ffc9f1a1cd73f77e10404ca46a4616

KP Singh (5):
  bpf: Implement task local storage
  bpf: Implement get_current_task_btf and RET_PTR_TO_BTF_ID
  bpf: Fix tests for local_storage
  bpf: Update selftests for local_storage to use vmlinux.h
  bpf: Add tests for task_local_storage

 include/linux/bpf.h                           |   1 +
 include/linux/bpf_lsm.h                       |  23 ++
 include/linux/bpf_types.h                     |   1 +
 include/uapi/linux/bpf.h                      |  48 +++
 kernel/bpf/Makefile                           |   1 +
 kernel/bpf/bpf_lsm.c                          |   4 +
 kernel/bpf/bpf_task_storage.c                 | 327 ++++++++++++++++++
 kernel/bpf/syscall.c                          |   3 +-
 kernel/bpf/verifier.c                         |  20 +-
 kernel/trace/bpf_trace.c                      |  16 +
 security/bpf/hooks.c                          |   2 +
 .../bpf/bpftool/Documentation/bpftool-map.rst |   3 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   2 +-
 tools/bpf/bpftool/map.c                       |   4 +-
 tools/include/uapi/linux/bpf.h                |  48 +++
 tools/lib/bpf/libbpf_probes.c                 |   2 +
 .../bpf/prog_tests/test_local_storage.c       |  89 ++++-
 .../selftests/bpf/progs/local_storage.c       |  78 +++--
 18 files changed, 625 insertions(+), 47 deletions(-)
 create mode 100644 kernel/bpf/bpf_task_storage.c

-- 
2.29.0.rc2.309.g374f81d7ae-goog

