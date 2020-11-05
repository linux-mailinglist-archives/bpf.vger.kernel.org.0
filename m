Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0C42A813F
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 15:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgKEOsB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 09:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730977AbgKEOsA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 09:48:00 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3CDC0613CF
        for <bpf@vger.kernel.org>; Thu,  5 Nov 2020 06:47:59 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id za3so3016275ejb.5
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2020 06:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dO+JlXlnkrnBDZXYdaSU/QyOlrQwphJnoU4gOQSY0iI=;
        b=Z3mu7WHsTm8xDIs0TbK+N/FmKgu8ELMCdpB9N6m8YdFcBphzZfHbjkJLJXIImEsVh7
         rWvKFI6/H4ttEdZhNTVql/VPoJBha1ro4NVuwMwZYugIh39+b6lhtlfmq4PkfbcDZaKe
         aZUnLcCKExZN/KnhmIGZaVAdU1HWyMHIsgsbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dO+JlXlnkrnBDZXYdaSU/QyOlrQwphJnoU4gOQSY0iI=;
        b=Tg5+gBWi9vOZjuVdT5YLVNFvb8fklCxcEohG8SrnY9OPZkQtXpzLjrj7NtNodKGQJF
         EVLUj20i1vPMrhiYVadcfQhtRGhno0+neuzx2kjdsVYk0B0QwhEReff00uMti9/9t6Yb
         9WxpnNymH7J9Yl0mwOtPklKo52R4e2/gl+X3kzGUgDHI58o3ycrXmzYMrgvEvPhHi/Qh
         3tlqwmjc7G1AqwD4DgpygxF7z6nIEt2kkqUQiElpAggBmqWAfJ2U4pSH22sPXAvjWryg
         Loj+NgM2wRGyACP0UilB8ePzigU0Jy05We4+c6d0WND5MXZSMobROgEE6qVD0ULgbkAZ
         L2+w==
X-Gm-Message-State: AOAM533TE3pGwVs8/eqNP0l7BNkaMr6GD1FPzt10PXke+YcDGU1PHA6U
        kC9tF50lDKK9mhy/qxTgUc9N1g==
X-Google-Smtp-Source: ABdhPJyVzWxZBL0MLYEnX9+KJQ7ctg5Ow66hsK0HnaZoE1Ow7uzXqVz63ib17Wc4F6VXIdIgLAv/1w==
X-Received: by 2002:a17:906:d285:: with SMTP id ay5mr2590782ejb.84.1604587677900;
        Thu, 05 Nov 2020 06:47:57 -0800 (PST)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id z13sm1075870ejp.30.2020.11.05.06.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 06:47:57 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v4 0/9] Implement task_local_storage
Date:   Thu,  5 Nov 2020 15:47:46 +0100
Message-Id: <20201105144755.214341-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

# v3 -> v4

- Move the patch that exposes spin lock helpers to LSM programs as the
  first patch as some of the changes in the implementation are actually
  for spin locks.
- Clarify the comment in the bpf_task_storage_{get, delete} helper as
  discussed with Martin.
- Added Martin's ack and rebased.

# v2 -> v3

- Added bpf_spin_locks to the selftests for local storage, found that
  these are not available for LSM programs.
- Made spin lock helpers available for LSM programs (except sleepable
  programs which need more work).
- Minor fixes for includes and added short commit messages for patches
  that were split up for libbpf and bpftool.
- Added Song's acks.

# v1 -> v2

- Updated the refcounting for task_struct and simplified conversion
  of fd -> struct pid.
- Some fixes suggested by Martin and Andrii, notably:
   * long return type for the bpf_task_storage_delete helper (update
     for bpf_inode_storage_delete will be sent separately).
   * Remove extra nullness check to task_storage_ptr in map syscall
     ops.
   * Changed the argument signature of the BPF helpers to use
     task_struct pointer in uapi headers.
   * Remove unnecessary verifier logic for the bpf_get_current_task_btf
     helper.
   * Split the changes for bpftool and libbpf.
- Exercised syscall operations for local storage (kept a simpler verison
  in test_local_storage.c, the eventual goal will be to update
  sk_storage_map.c for all local storage types).
- Formatting fixes + Rebase.

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

KP Singh (9):
  bpf: Allow LSM programs to use bpf spin locks
  bpf: Implement task local storage
  libbpf: Add support for task local storage
  bpftool: Add support for task local storage
  bpf: Implement get_current_task_btf and RET_PTR_TO_BTF_ID
  bpf: Fix tests for local_storage
  bpf: Update selftests for local_storage to use vmlinux.h
  bpf: Add tests for task_local_storage
  bpf: Exercise syscall operations for inode and sk storage

 include/linux/bpf.h                           |   1 +
 include/linux/bpf_lsm.h                       |  23 ++
 include/linux/bpf_types.h                     |   1 +
 include/uapi/linux/bpf.h                      |  48 +++
 kernel/bpf/Makefile                           |   1 +
 kernel/bpf/bpf_lsm.c                          |   8 +
 kernel/bpf/bpf_task_storage.c                 | 315 ++++++++++++++++++
 kernel/bpf/syscall.c                          |   3 +-
 kernel/bpf/verifier.c                         |  37 +-
 kernel/trace/bpf_trace.c                      |  16 +
 security/bpf/hooks.c                          |   2 +
 .../bpf/bpftool/Documentation/bpftool-map.rst |   3 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   2 +-
 tools/bpf/bpftool/map.c                       |   4 +-
 tools/include/uapi/linux/bpf.h                |  48 +++
 tools/lib/bpf/libbpf_probes.c                 |   1 +
 .../bpf/prog_tests/test_local_storage.c       | 182 +++++++++-
 .../selftests/bpf/progs/local_storage.c       | 103 ++++--
 18 files changed, 741 insertions(+), 57 deletions(-)
 create mode 100644 kernel/bpf/bpf_task_storage.c

-- 
2.29.1.341.ge80a0c044ae-goog

