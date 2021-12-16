Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53EEA4767AC
	for <lists+bpf@lfdr.de>; Thu, 16 Dec 2021 03:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbhLPCEq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Dec 2021 21:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbhLPCEq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Dec 2021 21:04:46 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED1BC061574
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 18:04:46 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id i3-20020a170902c94300b0014287dc7dcbso7268924pla.16
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 18:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=4xhJRPGTz33TsLVVEaHrcpS+70YTd6EGGFlzsB3xnSk=;
        b=JTLcxznXYfgXQt17XlvNlxMWNJMbSaNI+hGPInw8Wn68YhchsdeqQFSFoyaCVRz1ST
         TEWxq/jlP104ombWDCmiJ60lKNlfUFABNfimqz0ilcJLCtGWmTz5EcmJo+WpVvsDzIHm
         XY94GMF40y7zDE814U0ywrUJLMTangWt6qiIK3+QzbqWWgcQxyffXmD6NkPzGlnxBEGQ
         lhdY571n/gc0khsKP8jMUUoOc6yBMlAC03FFsnB4FUwhF2sV/Xj+kb5jGiXv+YSvgWj+
         db7GNkumN/QMVgh0Rvew0G12+CGSKhl3GcYyqK+NNxeCHmTI2rmEiEjsxHQHnj6J4ELg
         FfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=4xhJRPGTz33TsLVVEaHrcpS+70YTd6EGGFlzsB3xnSk=;
        b=kh71QZrewB62Y33oZjXkGeOhj8hLD0EJDsNgnohcXrcFlg1fcdI9+Y0Lt3XlTpkk0r
         TdyXPSCaZDg+FfJQmDIa9dFIveRU6CqmUvvQs0QI3Q0D0kYDGIXEoPjh2QUBY9Tb9OLo
         xHtVbpHxRLNlcKUShJUOOLB0T3QPZCxZn7wsODgliHbQY/9Q3iX3yAv0sQJtXYm8oJ/z
         ZQnd6uxV9XAPLgCOwppiEeNO4DPQMK/hYZHNp7TBz1vt6axBn4A3VHCmzXnlaz0/T9r/
         KgzZdre7Z17W8X0XD8hkOcwVkGedJ3pyiR9YBrapvnLaXarw9EejonNKQKH5m4W10M8e
         N65g==
X-Gm-Message-State: AOAM53313Up5eCkRPSqeY5//8w47+DBBDcmL2E+0jqtD+zmaGIjlcsko
        vrc10jJxF8xWUXFJOdfCYUjTOZriKI/uxe+2vQdwcYmagl5y/NjtT+umi/MWKKzXKEKsqxvKMxr
        xANZFnlSzXTpUr0kChwmBvY74wBcKTAgbmunCCOgbqrls5PpRKjakdiENckCCl7M=
X-Google-Smtp-Source: ABdhPJyWiFnltnZpvebb3xG3swl7QBh3uWdxUccdrJWrbeZ6lFAGPBPlKOSR0IQ3oKMbrTjS9t04mLWu3L/CJw==
X-Received: from zhuyifei-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edc])
 (user=zhuyifei job=sendgmr) by 2002:a05:6a00:b83:b0:49f:b555:1183 with SMTP
 id g3-20020a056a000b8300b0049fb5551183mr11731465pfj.32.1639620285591; Wed, 15
 Dec 2021 18:04:45 -0800 (PST)
Date:   Thu, 16 Dec 2021 02:04:24 +0000
Message-Id: <cover.1639619851.git.zhuyifei@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v2 bpf-next 0/5] bpf: allow cgroup progs to export custom
 retval to userspace
From:   YiFei Zhu <zhuyifei@google.com>
To:     bpf@vger.kernel.org
Cc:     Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Right now, most cgroup hooks are best used for permission checks. They
can only reject a syscall with -EPERM, so a cause of a rejection, if
the rejected by eBPF cgroup hooks, is ambiguous to userspace.
Additionally, if the syscalls are implemented in eBPF, all permission
checks and the implementation has to happen within the same filter,
as programs executed later in the series of progs are unaware of the
return values return by the previous progs.

This patch series adds two helpers, bpf_get_retval and bpf_set_retval,
that allows hooks to get/set the return value of syscall to userspace.
This also allows later progs to retrieve retval set by previous progs.

For legacy programs that rejects a syscall without setting the retval,
for backwards compatibility, if a prog rejects without itself or a
prior prog setting retval to an -err, the retval is set by the kernel
to -EPERM.

For getsockopt hooks that has ctx->retval, this variable mirrors that
that accessed by the helpers.

Additionally, the following user-visible behavior for getsockopt
hooks has changed:
  - If a prior filter rejected the syscall, it will be visible
    in ctx->retval.
  - Attempting to change the retval arbitrarily is now allowed and
    will not cause an -EFAULT.
  - If kernel rejects a getsockopt syscall before running the hooks,
    the error will be visible in ctx->retval. Returning 0 from the
    prog will not overwrite the error to -EPERM unless there is an
    explicit call of bpf_set_retval(-EPERM)

Tests have been added in this series to test the behavior of the helper
with cgroup setsockopt getsockopt hooks.

Patch 1 changes the API of macros to prepare for the next patch and
  should be a no-op.
Patch 2 moves ctx->retval to a struct pointed to by current
  task_struct.
Patch 3 implements the helpers.
Patch 4 tests the behaviors of the helpers.
Patch 5 updates a test after the test broke due to the visible changes.

v1 -> v2:
  - errno -> retval
  - split one helper to get & set helpers
  - allow retval to be set arbitrarily in the general case
  - made the helper retval and context retval mirror each other

YiFei Zhu (5):
  bpf: Make BPF_PROG_RUN_ARRAY return -err instead of allow boolean
  bpf: Move getsockopt retval to struct bpf_cg_run_ctx
  bpf: Add cgroup helpers bpf_{get,set}_retval to get/set syscall return
    value
  selftests/bpf: Test bpf_{get,set}_retval behavior with cgroup/sockopt
  selftests/bpf: Update sockopt_sk test to the use bpf_set_retval

 include/linux/bpf.h                           |  34 +-
 include/linux/filter.h                        |   5 +-
 include/uapi/linux/bpf.h                      |  18 +
 kernel/bpf/cgroup.c                           | 149 ++++--
 security/device_cgroup.c                      |   2 +-
 tools/include/uapi/linux/bpf.h                |  18 +
 .../bpf/prog_tests/cgroup_getset_retval.c     | 481 ++++++++++++++++++
 .../selftests/bpf/prog_tests/sockopt_sk.c     |   2 +-
 .../progs/cgroup_getset_retval_getsockopt.c   |  45 ++
 .../progs/cgroup_getset_retval_setsockopt.c   |  52 ++
 .../testing/selftests/bpf/progs/sockopt_sk.c  |  32 +-
 11 files changed, 750 insertions(+), 88 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_getset_retval.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_getset_retval_getsockopt.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_getset_retval_setsockopt.c

-- 
2.34.1.173.g76aa8bc2d0-goog
