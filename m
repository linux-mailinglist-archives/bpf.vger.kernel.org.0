Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93EE4219562
	for <lists+bpf@lfdr.de>; Thu,  9 Jul 2020 02:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgGIA5A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jul 2020 20:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgGIA47 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jul 2020 20:56:59 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FD1C08C5C1
        for <bpf@vger.kernel.org>; Wed,  8 Jul 2020 17:56:59 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f18so521411wrs.0
        for <bpf@vger.kernel.org>; Wed, 08 Jul 2020 17:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wb8mEauBikv1z1IJwGKgH3voixL0iElDmd8Bx85M4tk=;
        b=Mqy/kb1eLDhPFr9NT7lgGvkr2TCkf0JJcBWowOBu+nBgLG2lMEviLlqY5CE/DdoZlP
         EimHNa3yg7DdfTdqnwFnyPmewkkETQTHkcxiKa3oQ29AFUC3Ljv0QEOuh6aUE9UJZ0hJ
         CJY41FjbxNy3jNmTAOatwKyQO+THpo6oErSb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wb8mEauBikv1z1IJwGKgH3voixL0iElDmd8Bx85M4tk=;
        b=M77BctWvJ7r7fEP1pAjR+8jA+sYu9zOn5H0u9h2WaUKrpMaTrSk8h3UYkzMh92tDyK
         qvU4MkcnP8COSa3hFnXzDE9Y/i4dNv+YtDBgaMbacjVY9eJ0+yi3nVvreA+lDCkpYoZd
         vXp2Gar2Cc3aJe/1aF4C9Pw7sV8ZmrNMKgN7tyEr4prUwzBtYVsYBToxImlrCIXmoIWx
         ikzXnXlE+KyUVSynlvmAb2lE9QIrrJHrC7zLr4zmthcLawJdYMzJFQPk/CMhalIM79OT
         oZABfEDgr7OMdfYZpFjWeCqnZGUl8pEtB2L90M5/SZo4hus6jbZ3z+Hryq+BgbqbeAtE
         RsiQ==
X-Gm-Message-State: AOAM532GE5ZruUCNur4U7ewxJV3HWWpRWlr9zlvC8jIp18SyPNJ5YhZb
        zfXQoehpCGV0ZD2cozFLVnc7NREEhgM=
X-Google-Smtp-Source: ABdhPJztUAF/9/91ngWFLhds3ZEX9y6DnZrkqmOUmp0epDrn6Kmy2umnlt2DQ/W/TuXBQ8Cz/hsEcg==
X-Received: by 2002:adf:80e6:: with SMTP id 93mr58983367wrl.17.1594256217739;
        Wed, 08 Jul 2020 17:56:57 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id f15sm2465498wrx.91.2020.07.08.17.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 17:56:57 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v3 0/4] Generalizing bpf_local_storage
Date:   Thu,  9 Jul 2020 02:56:50 +0200
Message-Id: <20200709005654.3324272-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

# v2 -> v3

* Restructured the code as per Martin's suggestions:
  - Common functionality in bpf_local_storage.c
  - bpf_sk_storage functionality remains in net/bpf_sk_storage.
  - bpf_inode_storage is kept separate as it is enabled only with
    CONFIG_BPF_LSM.
* A separate cache for inode and sk storage with macros to define it.
* Use the ops style approach as suggested by Martin instead of the
  enum + switch style.
* Added the inode map to bpftool bash completion and docs.
* Rebase and indentation fixes.

# v1 -> v2

* Use the security blob pointer instead of dedicated member in
  struct inode.
* Better code re-use as suggested by Alexei.
* Dropped the inode count arithmetic as pointed out by Alexei.
* Minor bug fixes and rebase.

bpf_sk_storage can already be used by some BPF program types to annotate
socket objects. These annotations are managed with the life-cycle of the
object (i.e. freed when the object is freed) which makes BPF programs
much simpler and less prone to errors and leaks.

This patch series:

* Generalizes the bpf_sk_storage infrastructure to allow easy
  implementation of local storage for other objects
* Implements local storage for inodes
* Makes both bpf_{sk, inode}_storage available to LSM programs.

Local storage is safe to use in LSM programs as the attachment sites are
limited and the owning object won't be freed, however, this is not the
case for tracing. Usage in tracing is expected to follow a white-list
based approach similar to the d_path helper
(https://lore.kernel.org/bpf/20200506132946.2164578-1-jolsa@kernel.org).

Access to local storage would allow LSM programs to implement stateful
detections like detecting the unlink of a running executable from the
examples shared as a part of the KRSI series
https://lore.kernel.org/bpf/20200329004356.27286-1-kpsingh@chromium.org/
and
https://github.com/sinkap/linux-krsi/blob/patch/v1/examples/samples/bpf/lsm_detect_exec_unlink.c



KP Singh (4):
  bpf: Generalize bpf_sk_storage
  bpf: Implement bpf_local_storage for inodes
  bpf: Allow local storage to be used from LSM programs
  bpf: Add selftests for local_storage

 include/linux/bpf.h                           |  14 +
 include/linux/bpf_local_storage.h             | 190 ++++
 include/linux/bpf_lsm.h                       |  21 +
 include/linux/bpf_types.h                     |   3 +
 include/net/bpf_sk_storage.h                  |   2 +
 include/net/sock.h                            |   4 +-
 include/uapi/linux/bpf.h                      |  54 +-
 kernel/bpf/Makefile                           |   2 +
 kernel/bpf/bpf_inode_storage.c                | 333 +++++++
 kernel/bpf/bpf_local_storage.c                | 517 +++++++++++
 kernel/bpf/bpf_lsm.c                          |  21 +-
 kernel/bpf/syscall.c                          |   3 +-
 kernel/bpf/verifier.c                         |  10 +
 net/core/bpf_sk_storage.c                     | 826 ++++--------------
 security/bpf/hooks.c                          |   7 +
 .../bpf/bpftool/Documentation/bpftool-map.rst |   2 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   3 +-
 tools/bpf/bpftool/map.c                       |   3 +-
 tools/include/uapi/linux/bpf.h                |  54 +-
 tools/lib/bpf/libbpf_probes.c                 |   5 +-
 .../bpf/prog_tests/test_local_storage.c       |  60 ++
 .../selftests/bpf/progs/local_storage.c       | 136 +++
 22 files changed, 1599 insertions(+), 671 deletions(-)
 create mode 100644 include/linux/bpf_local_storage.h
 create mode 100644 kernel/bpf/bpf_inode_storage.c
 create mode 100644 kernel/bpf/bpf_local_storage.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_local_storage.c
 create mode 100644 tools/testing/selftests/bpf/progs/local_storage.c

-- 
2.27.0.389.gc38d7665816-goog

