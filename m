Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452611FD610
	for <lists+bpf@lfdr.de>; Wed, 17 Jun 2020 22:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgFQU3t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Jun 2020 16:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgFQU3t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Jun 2020 16:29:49 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232A6C061755
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 13:29:49 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c3so3731017wru.12
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 13:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t92nn/934rDsHxnKVkmTEP0HhKGlC9xXPsegf8PDBsU=;
        b=nYH5W8VhxubKKfVGihc8D9v4VwWpyKiHYBiPViozBv4EG/bhRuCwNevHpTsSj2ectK
         RYFe3LOj/rLashNR2k9gNQm8fTrVLJDQA95GJcW3oKQ4/WPHlriQAzqTY8J4hLVXgX0n
         CzaKEAozrdoZ9esSMWbv9XbZBTlCsDtuMAswE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t92nn/934rDsHxnKVkmTEP0HhKGlC9xXPsegf8PDBsU=;
        b=CsXKa6wyrIl742hHYvl0AJci/fe2MxyqhC2rL53qkH5FUzx5oiXXA5AOWFupkAviL7
         4ia3mDoMVhKRZTwog3iarm2Ot6O/uRmMCgJsYW9Nzij84SpirdU4w6qIxXnccVe1LRWZ
         8D8MveAa0+gtySeWglCwJKWnZ+w4eUFwv6XHaoD9mHjTzp1hvy/+4WCeqFBIR2t9r6PC
         AmH8Fgf7O4gTdKDtAdbvTD2Du5n9w5gQaaw7fP3BIoSZS7oAkEWwO/QXPKD5PEK10/6X
         AFZx0sL086x79dGVc1kCmoGdSQAOE84+awvs68scq20QwkSesUtmxCh8cpdSjYgr339g
         2EBQ==
X-Gm-Message-State: AOAM531br4T609tlRCdXGETlzvN1MoFprm4MhG1+j2qExXeraIJbAM97
        vYUwfFog3QyWRqf2Enabii45GXQPt6s=
X-Google-Smtp-Source: ABdhPJzPLMsyj/rAMh1Yh8t14gifZt0YfrzPWT4JOYxcwtwTgJoVsU8s3Pz6kZPU4TAoFcrfV13zdw==
X-Received: by 2002:a5d:684a:: with SMTP id o10mr985856wrw.4.1592425787517;
        Wed, 17 Jun 2020 13:29:47 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id o10sm812845wrq.40.2020.06.17.13.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 13:29:46 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>
Subject: [PATCH bpf-next v2 0/4] Generalizing bpf_local_storage
Date:   Wed, 17 Jun 2020 22:29:37 +0200
Message-Id: <20200617202941.3034-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

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

 .../bpf_local_storage.h}                      |  15 +-
 include/linux/bpf_lsm.h                       |  21 +
 include/linux/bpf_types.h                     |   1 +
 include/net/sock.h                            |   4 +-
 include/uapi/linux/bpf.h                      |  56 +-
 kernel/bpf/Makefile                           |   1 +
 .../bpf/bpf_local_storage.c                   | 933 ++++++++++++------
 kernel/bpf/bpf_lsm.c                          |  20 +-
 kernel/bpf/cgroup.c                           |   2 +-
 kernel/bpf/syscall.c                          |   3 +-
 kernel/bpf/verifier.c                         |  10 +
 net/bpf/test_run.c                            |   2 +-
 net/core/Makefile                             |   1 -
 net/core/filter.c                             |   2 +-
 net/core/sock.c                               |   2 +-
 net/ipv4/bpf_tcp_ca.c                         |   2 +-
 net/ipv4/inet_diag.c                          |   2 +-
 security/bpf/hooks.c                          |   7 +
 tools/bpf/bpftool/map.c                       |   1 +
 tools/include/uapi/linux/bpf.h                |  56 +-
 tools/lib/bpf/libbpf_probes.c                 |   5 +-
 .../bpf/prog_tests/test_local_storage.c       |  60 ++
 .../selftests/bpf/progs/local_storage.c       | 137 +++
 23 files changed, 1038 insertions(+), 305 deletions(-)
 rename include/{net/bpf_sk_storage.h => linux/bpf_local_storage.h} (72%)
 rename net/core/bpf_sk_storage.c => kernel/bpf/bpf_local_storage.c (50%)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_local_storage.c
 create mode 100644 tools/testing/selftests/bpf/progs/local_storage.c

-- 
2.27.0.111.gc72c7da667-goog

