Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29902A6A19
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 17:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbgKDQo6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 11:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgKDQo6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Nov 2020 11:44:58 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CE9C0613D3
        for <bpf@vger.kernel.org>; Wed,  4 Nov 2020 08:44:58 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id p93so23121802edd.7
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2020 08:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rGwZ4U2Yk94HbjWECDt3ZSEO8BgGsm3yANWJZznJVlE=;
        b=SKypcSJq5Q6k60k9+zKvKMbvC4/mYkkGRNBl7hNNZGDnVCCmxbSynCz14nMmMe6+oA
         nHAsVIiIuk1jY34qSoxGvxeje1+NUCFO0WDNK95TU7m04UYEx0Wb4srpx5ztwBP5pgIq
         B9IM4QVUDbWlDbmPJMm458KQBunavjl5+UWfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rGwZ4U2Yk94HbjWECDt3ZSEO8BgGsm3yANWJZznJVlE=;
        b=J01B3EuzxLkqDUQrLlFK9gSEIqpHJH0U7yJQ/+y6kNZ7XMkhoJnPVcgy5rhxTeJEMt
         0rRrE+8OiXilb6PGROIxaGpJrCbDO2lc/YDf83LC7eS9Vm5W5kOmyfdpCCYu+IQLNY2R
         Cj7eqQ3n3ZzBj+w3AIby0oVDbuN1XgDRppexBgGs2fkr8iYE1UZVlU6u1ZOkTAKinbtb
         B6HS4FuQ4Tkl7dttVMtGXjJ7nShxWt1qQ7FIx+VAipcLIRpdZv0pDDZzQZIgDnjoByG7
         DoNlqMXBUXkshnDMRaqbAUo6FOtd46wN1OgqgitOnBIPHt5z39VKZhCf09MQR8Mo39fb
         cWPg==
X-Gm-Message-State: AOAM5314FcCVPk5U6OqzS297W2y5xCx2yxYIfw/1UsC6ERQP0od2iOUY
        us+5OM2lMBQzHvIaEQAXmvk43w==
X-Google-Smtp-Source: ABdhPJx32REKyxbt2tVWS3Rsm648Cf2c14z6rQY2cwLF8aINR+bqpbGo8T9QFhDKXw1puYcdh/VrAg==
X-Received: by 2002:a50:fe98:: with SMTP id d24mr27534696edt.223.1604508297130;
        Wed, 04 Nov 2020 08:44:57 -0800 (PST)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id g20sm1283551ejz.88.2020.11.04.08.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:44:56 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v3 0/9] Implement task_local_storage
Date:   Wed,  4 Nov 2020 17:44:44 +0100
Message-Id: <20201104164453.74390-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

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
  bpf: Implement task local storage
  libbpf: Add support for task local storage
  bpftool: Add support for task local storage
  bpf: Implement get_current_task_btf and RET_PTR_TO_BTF_ID
  bpf: Allow LSM programs to use bpf spin locks
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
 kernel/bpf/bpf_task_storage.c                 | 313 ++++++++++++++++++
 kernel/bpf/syscall.c                          |   3 +-
 kernel/bpf/verifier.c                         |  34 +-
 kernel/trace/bpf_trace.c                      |  16 +
 security/bpf/hooks.c                          |   2 +
 .../bpf/bpftool/Documentation/bpftool-map.rst |   3 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   2 +-
 tools/bpf/bpftool/map.c                       |   4 +-
 tools/include/uapi/linux/bpf.h                |  48 +++
 tools/lib/bpf/libbpf_probes.c                 |   1 +
 .../bpf/prog_tests/test_local_storage.c       | 182 +++++++++-
 .../selftests/bpf/progs/local_storage.c       | 103 ++++--
 18 files changed, 741 insertions(+), 52 deletions(-)
 create mode 100644 kernel/bpf/bpf_task_storage.c

-- 
2.29.1.341.ge80a0c044ae-goog

