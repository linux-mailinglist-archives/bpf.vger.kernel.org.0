Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2328042421A
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 18:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbhJFQEw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 12:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhJFQEw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Oct 2021 12:04:52 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3BFC061746
        for <bpf@vger.kernel.org>; Wed,  6 Oct 2021 09:03:00 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id pi19-20020a17090b1e5300b0019fdd3557d3so2677692pjb.5
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 09:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VFW0mvH9fAR0DyV/OzmGb0GsaJcv7wQOzO14q8nlSKE=;
        b=EmCKRIMboYXPWnaRMvRTr+PzcYdWqamjoBq+PqmtotaFOkutZnUZidy2uZxUyBnSQh
         6jDHr4szLn3cvYmXXuhinzUDnIqO5vaoR1K4zK+Admjp/nUdbWv5YTskLJrSkkXnzbQN
         8DhqrYhEnmW2hPwor1LHOlBdOOzDYnhdG9i70YaDrJu2PogwfO8eTVhmTBSQ2+RVuB0w
         jo9VejLuDyGKsMZmCM+PxRoy4XHOkA6OffAL/PHaZa15LWjsJlNS4EgW0zPMtPJ56KsZ
         84y8MPu2mfvPR07Zr+eVGM8PbG+KgBEB9mtvCcxAvR/TYGX9rgMKwpy+w0wJAoIlegWN
         KECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VFW0mvH9fAR0DyV/OzmGb0GsaJcv7wQOzO14q8nlSKE=;
        b=uKJUfCkayZH78BvXXEZ1IpH1pzr3uFuumEZZD14UHAaQ6h8YkmSPO2eDzmOsLqssz2
         fsO+DySEe00wi8LCwjLJuvvID6kHsmalzW311m/6fIpowR+zgrmrnTT6V8rF5J1JH1ja
         B2Z+I8Xhvlio18juPFQLlumQ+VUBLvLKUtrmasqIyFk9jNyJwUKw1VvO+yvl0g4sh/iE
         +tLn62ojFvUZo3hNkLyBHVsZM9AUGF6pVC4ZNc2AzKgNr/3Y3PvGszR9/dynjC6u1jGd
         +5OiQPoJ3l5sWBQhOWeDIepnnpg/NdzRBnOGqxFJ2C069xzD58CFi1jfIkf8pvtaxXeg
         DgZg==
X-Gm-Message-State: AOAM532pGzmLodqmBbOEFotb5vDOLR8gI8t+KcOerzlxNF26YY8DAoRB
        cXsIzrRoOs7wQY7mD2ARcgXlQqMWh1o=
X-Google-Smtp-Source: ABdhPJwfEb4nDrqHrfMvabcTI29qhKm4XG3WvKFVPDnyUwVMahvl1htA4eFi2kSbqLa59aZ7XwGKxw==
X-Received: by 2002:a17:90b:4a81:: with SMTP id lp1mr11965108pjb.124.1633536179237;
        Wed, 06 Oct 2021 09:02:59 -0700 (PDT)
Received: from localhost.localdomain ([98.47.144.235])
        by smtp.gmail.com with ESMTPSA id x19sm20906098pfn.105.2021.10.06.09.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 09:02:58 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH bpf-next 0/3] bpf: allow cgroup progs to export custom errnos to userspace
Date:   Wed,  6 Oct 2021 09:02:39 -0700
Message-Id: <cover.1633535940.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <zhuyifei@google.com>

Right now, most cgroup hooks are best used for permission checks. They
can only reject a syscall with -EPERM, so a cause of a rejection, if
the rejected by eBPF cgroup hooks, is ambiguous to userspace.
Additionally, if the syscalls are implemented in eBPF, all permission
checks and the implementation has to happen within the same filter,
as programs executed later in the series of progs are unaware of the
return values return by the previous progs.

This patch series adds a helper, bpf_export_errno, that allows hooks
to get/set the errno exported by eBPF to userspace. Invoking the helper
with a positive errno will set the exported errno, and invoking the
helper with zero will return the previously set errno. This means
that an errno, once set, can be overridden but cannot be unset. This
also allows later progs to retrieve errnos set by previous progs.

For legacy programs that rejects a syscall without setting the exported
errno, for backwards compatibility, if a prog rejects without itself
or a prior prog setting errno, the errno is set by the kernel to -EPERM.

Tests have been added in this series to test the behavior of the helper
with cgroup setsockopt getsockopt hooks.

Patch 1 changes the API of macros to prepare for the next patch and
  should be a no-op.
Patch 2 implements the helper and the tracking of errno.
Patch 3 tests the behaviors of the helper.

YiFei Zhu (3):
  bpf: Make BPF_PROG_RUN_ARRAY return -errno instead of allow boolean
  bpf: Add cgroup helper bpf_export_errno to get/set exported errno
    value
  selftests/bpf: Test bpf_export_errno behavior with cgroup/sockopt

 include/linux/bpf.h                           |  27 +-
 include/uapi/linux/bpf.h                      |  14 +
 kernel/bpf/cgroup.c                           |  65 ++-
 security/device_cgroup.c                      |   2 +-
 tools/include/uapi/linux/bpf.h                |  14 +
 .../bpf/prog_tests/cgroup_export_errno.c      | 472 ++++++++++++++++++
 .../progs/cgroup_export_errno_getsockopt.c    |  45 ++
 .../progs/cgroup_export_errno_setsockopt.c    |  52 ++
 8 files changed, 651 insertions(+), 40 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_export_errno.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_export_errno_getsockopt.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_export_errno_setsockopt.c

--
2.33.0
