Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21EF44846D0
	for <lists+bpf@lfdr.de>; Tue,  4 Jan 2022 18:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbiADRP3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Jan 2022 12:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235358AbiADRPU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Jan 2022 12:15:20 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2701EC061792
        for <bpf@vger.kernel.org>; Tue,  4 Jan 2022 09:15:20 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id e10-20020a17090301ca00b001491f26bcd4so4510351plh.23
        for <bpf@vger.kernel.org>; Tue, 04 Jan 2022 09:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+bcEJi4WzzyiKhKLsU2ww4K+EdT28L6iR0Z8vuM7BRQ=;
        b=M/bkmnqitn5T9yy1v0pTpylproK/234DuvO3O+D3akxK0wQhS/RMkDY6m0e32hnA//
         ED52YkcMIyia+i1pnG2/Bw7YpVmk4ScM0cgoOcMz7/vDjq1Iu1okVhT0BzGkkAb2lbSd
         lLjhe1mgHYuAQKNTKQCgyK+4JpT45rxGH+QTYjVlCOzNQYzHSPPOabtn9NH7/3P/Tim7
         kIbRXRDX6jZAhTUDcOtX2/FmqkjsPLiSEOfJaoNkGX4/MVuH9H497SgtYXwLhzZ4mBYh
         g+MNHScyxeholQQujtnTUh/eCM486IG1Ox4puMw0dbjK4ETrwBzmeuiBxzRgV6aFUSoR
         e1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+bcEJi4WzzyiKhKLsU2ww4K+EdT28L6iR0Z8vuM7BRQ=;
        b=ZDYi4L4ZYirPRVeg2PlBK7vBGD+bUwyYPfA9KsjBG1DOn/ZmsykHgcEYhHVb4O/oTZ
         s1YQ9HaYOzVYG20zP2fP8Hd4s0Ya/x0TIfx7bz6d4DqoL7N0SzDwJZbfgreLftTB974P
         fk7CX2LTY6EpMQ8BdBhy478EidQnvIfqvxLDlGi7qbG9bpWgOEMH0eiJK2RP5YMnSiof
         L3fKbMC94+4MijtWDJG7eDvRHfj4sRI2PWmRXE5EFbrDFp0yXaD/0Axliy1pMfcg/9iV
         7I3hLtNgCo4W0nWtRIxx/cw+0RHFGbEzbrGJsVOuYnvPIB5G2my1YZdoQvEs/A8A8SLJ
         KKdA==
X-Gm-Message-State: AOAM5327CS6aUUFhAmGU1TxZ9/Fl9/N1fz+FJjCiJUslC/Og3O8bOwkD
        VSQO+KyILeSd0Hr3GtEXim/QJp47d+LyJicTDiZZi76B0TYr4VvyrqH14YkvMp3I/Cgsn52eR9c
        xu/9CYn0RzWFm9sUChaMTM/n2wnOwPlhdjRXELRC+yJ/IXW6QQhrTXGvV8t1WPTU=
X-Google-Smtp-Source: ABdhPJztzaZsQQvSGnNDbbEtvpKowQKY6OEJlGGFTNBUSS9cHOwf6zmWnixipKqDyH48eb3PcOHeTVkM2b6WFw==
X-Received: from zhuyifei-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edc])
 (user=zhuyifei job=sendgmr) by 2002:a05:6a00:114e:b0:4bc:b9f1:7215 with SMTP
 id b14-20020a056a00114e00b004bcb9f17215mr7145870pfm.13.1641316519142; Tue, 04
 Jan 2022 09:15:19 -0800 (PST)
Date:   Tue,  4 Jan 2022 17:15:01 +0000
Message-Id: <cover.1641316155.git.zhuyifei@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 bpf-next 0/4] bpf: allow cgroup progs to export custom
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

v1 -> v2:
  - errno -> retval
  - split one helper to get & set helpers
  - allow retval to be set arbitrarily in the general case
  - made the helper retval and context retval mirror each other

v2 -> v3:
  - squashed sockopt_sk test change to the patch that broke it

YiFei Zhu (4):
  bpf: Make BPF_PROG_RUN_ARRAY return -err instead of allow boolean
  bpf: Move getsockopt retval to struct bpf_cg_run_ctx
  bpf: Add cgroup helpers bpf_{get,set}_retval to get/set syscall return
    value
  selftests/bpf: Test bpf_{get,set}_retval behavior with cgroup/sockopt

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
2.34.1.448.ga2b2bfdf31-goog
