Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0883C229E20
	for <lists+bpf@lfdr.de>; Wed, 22 Jul 2020 19:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgGVROR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jul 2020 13:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgGVROR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jul 2020 13:14:17 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF08C0619E0
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2020 10:14:16 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f2so2628647wrp.7
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2020 10:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4g5Wo+MJzHD6SkvQzHsaFSmorwkBVvAJxppiWNfFnRA=;
        b=Rrb+tR373Lgh1/d2MyOIRScKbc0sdaCkTsgCEKTt5/phwUX7IRReOBtAzfP3hXY8iT
         ef3ws5TWXre1NO4DkSMMbgQDr1CAMp2UH3bbbuIICNJw+aaPTCF0Lw+67QSwc0jOTWIj
         WyLG3y2TddUhhB7jo7UoxLJIUF0Bqbi55YshA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4g5Wo+MJzHD6SkvQzHsaFSmorwkBVvAJxppiWNfFnRA=;
        b=fQYMAVICZNNFmLsaCxAnVK9erbrQsN9BHAz4EDCJJYkGU8164wBE2R5C73OqcLuNKs
         165kR1aSwAqKMCzCcxwbpzFHAbGXekumbE4v6h9zg5BBYmqk3F7JQydY6ytdMzcJtFsE
         ivawZhpR44fH3NGAa459Tk7u7u+Fv6i5zaQwlouGDAOLOXTU//dBCbKExLSMLp80TWXh
         ZFRocAVyaEluYW9EbAOgRUaJPIVSW4k8vcSHGNxci5Trc3/IarM+LEP6Ej8TDLG91d4t
         QRlRAx99tauGFggeWP2S72mOHtH2PvGApVC955Xb4bmjf2HuJ5gTlMbbxiraGvTnesvS
         zeNA==
X-Gm-Message-State: AOAM531NnfzF+iuppnXOxmL13sokC7I7qchF6FllEJg36HnHl2Uw44OS
        bTHJbDA3FS0FqXiyupC/y46zbg==
X-Google-Smtp-Source: ABdhPJyR1NdJvRXOKbmKRM1bBsO/XJWpqoRWjiyntuF6GUEEN3ja1qVDOtvbSgwRA6npgWHWG/27wQ==
X-Received: by 2002:adf:bc45:: with SMTP id a5mr464362wrh.215.1595438055264;
        Wed, 22 Jul 2020 10:14:15 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id 26sm349214wmj.25.2020.07.22.10.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 10:14:14 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v5 0/7] Generalizing bpf_local_storage
Date:   Wed, 22 Jul 2020 19:14:02 +0200
Message-Id: <20200722171409.102949-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

# v4 -> v5

- Split non-functional changes into separate commits.
- Updated the cache macros to be simpler.
- Fixed some bugs noticed by Martin.
- Updated the userspace map functions to use an fd for lookups, updates
  and deletes.
- Rebase.

# v3 -> v4

- Fixed a missing include to bpf_sk_storage.h in bpf_sk_storage.c
- Fixed some functions that were not marked as static which led to
  W=1 compilation warnings.

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


KP Singh (7):
  bpf: Renames to prepare for generalizing sk_storage.
  bpf: Generalize caching for sk_storage.
  bpf: Generalize bpf_sk_storage
  bpf: Split bpf_local_storage to bpf_sk_storage
  bpf: Implement bpf_local_storage for inodes
  bpf: Allow local storage to be used from LSM programs
  bpf: Add selftests for local_storage

 include/linux/bpf.h                           |  13 +
 include/linux/bpf_local_storage.h             | 175 ++++
 include/linux/bpf_lsm.h                       |  21 +
 include/linux/bpf_types.h                     |   3 +
 include/net/bpf_sk_storage.h                  |  12 +
 include/net/sock.h                            |   4 +-
 include/uapi/linux/bpf.h                      |  54 +-
 kernel/bpf/Makefile                           |   2 +
 kernel/bpf/bpf_inode_storage.c                | 356 ++++++++
 kernel/bpf/bpf_local_storage.c                | 519 ++++++++++++
 kernel/bpf/bpf_lsm.c                          |  21 +-
 kernel/bpf/syscall.c                          |   3 +-
 kernel/bpf/verifier.c                         |  10 +
 net/core/bpf_sk_storage.c                     | 759 ++++--------------
 security/bpf/hooks.c                          |   7 +
 .../bpf/bpftool/Documentation/bpftool-map.rst |   2 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   3 +-
 tools/bpf/bpftool/map.c                       |   3 +-
 tools/include/uapi/linux/bpf.h                |  54 +-
 tools/lib/bpf/libbpf_probes.c                 |   5 +-
 .../bpf/prog_tests/test_local_storage.c       |  60 ++
 .../selftests/bpf/progs/local_storage.c       | 136 ++++
 22 files changed, 1596 insertions(+), 626 deletions(-)
 create mode 100644 include/linux/bpf_local_storage.h
 create mode 100644 kernel/bpf/bpf_inode_storage.c
 create mode 100644 kernel/bpf/bpf_local_storage.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_local_storage.c
 create mode 100644 tools/testing/selftests/bpf/progs/local_storage.c

-- 
2.28.0.rc0.105.gf9edc3c819-goog

