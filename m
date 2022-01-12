Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D1348CC06
	for <lists+bpf@lfdr.de>; Wed, 12 Jan 2022 20:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344058AbiALTeY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jan 2022 14:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242585AbiALTeY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jan 2022 14:34:24 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EA2C061748
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 11:34:23 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id i81-20020a253b54000000b00611b1da1f8fso1596854yba.5
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 11:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kdM0s6QqOxdtaUmFhX2PE5X5ddjgitMB71Dm4q7m87s=;
        b=V8+gjWwjm4Ky6SLe5A5IuD83oIh+f1aYiVoKyfRZoe1PTQN+9mnMtuGcCOH+pH2686
         WSyE1eG+6msHIAif2qdiOo9qYmiRhfcSGHYVV4kNzEuaRbTgHDHgwNyttE75FN4BG0wN
         HPTKoxOzp+YzVDsVBhg8f2CIfh1S9FTssSsjgWa5FkE2iz6BO3aIe7VtNSdPgoG05sHj
         Ikru9OqvIMi4qJDPJytjmaek0ugP9G4EVJ73EGuKhxsW6QSW22Nm0IYVS2KXxSJuiK0t
         4Utb5IKYTsVHc6/xsgjZRLrXfBPbC2m+GCaTq86R3iLXcZtyWd+O7lOVBvgDnRe9mSpg
         0ahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kdM0s6QqOxdtaUmFhX2PE5X5ddjgitMB71Dm4q7m87s=;
        b=ofDtWdNryLRlkZ0rBajm+kTnkzBWBNZYHaylu2be5eisbdJII0wGEqzgepaob5Kwdc
         2vsl/SuWvPTW5PUVEP1zTj9y6xxC4v7REqsqh3Ts7jRootqCf8TQjevFfyoKr2ORf3CN
         /pgVBgp/wO7ERkk+HFf+Qg1bHChOiJMayUrHLAbCOl+m8zYLIP6UkFHmwzHopVGpJXuz
         uo2LuEJsMOG1rx7lJIk/PPsmRiIkpW0CbiUZ4kf5yJDtFHFk1s8Xfd8EWlDTMJRphgz9
         vnTCclpWtgQmz8qLxbuE7QOgbhTMXdf3gZDG5jQMZWtgSFTQ3cmf4QKy6JegQEkUBokh
         BqNA==
X-Gm-Message-State: AOAM530W8f1sVACoZZvz+mpF9fmSPUO6qnVF6b5U89vJzTHTf+jfBae3
        MyWFrKVvT6tiAeKo7VZKUo/7N6OPK6c=
X-Google-Smtp-Source: ABdhPJyhqR54GLN1gtH44CVTwYRuxSEbv2EJmzrb6mL02jpxrlWdB9SUIKuAODZ7wOG5g8Qqzoa/FDbqZ+E=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:ddf2:9aea:6994:df79])
 (user=haoluo job=sendgmr) by 2002:a05:6902:114b:: with SMTP id
 p11mr1926345ybu.578.1642016063252; Wed, 12 Jan 2022 11:34:23 -0800 (PST)
Date:   Wed, 12 Jan 2022 11:31:44 -0800
Message-Id: <20220112193152.3058718-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH RESEND RFC bpf-next v1 0/8] Pinning bpf objects outside bpffs
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bpffs is a pseudo file system that persists bpf objects. Previously
bpf objects can only be pinned in bpffs, this patchset extends pinning
to allow bpf objects to be pinned (or exposed) to other file systems.

In particular, this patchset allows pinning bpf objects in kernfs. This
creates a new file entry in the kernfs file system and the created file
is able to reference the bpf object. By doing so, bpf can be used to
customize the file's operations, such as seq_show.

As a concrete usecase of this feature, this patchset introduces a
simple new program type called 'bpf_view', which can be used to format
a seq file by a kernel object's state. By pinning a bpf_view program
into a cgroup directory, userspace is able to read the cgroup's state
from file in a format defined by the bpf program.

Different from bpffs, kernfs doesn't have a callback when a kernfs node
is freed, which is problem if we allow the kernfs node to hold an extra
reference of the bpf object, because there is no chance to dec the
object's refcnt. Therefore the kernfs node created by pinning doesn't
hold reference of the bpf object. The lifetime of the kernfs node
depends on the lifetime of the bpf object. Rather than "pinning in
kernfs", it is "exposing to kernfs". We require the bpf object to be
pinned in bpffs first before it can be pinned in kernfs. When the
object is unpinned from bpffs, their kernfs nodes will be removed
automatically. This somehow treats a pinned bpf object as a persistent
"device".

We rely on fsnotify to monitor the inode events in bpffs. A new function
bpf_watch_inode() is introduced. It allows registering a callback
function at inode destruction. For the kernfs case, a callback that
removes kernfs node is registered at the destruction of bpffs inodes.
For other file systems such as sockfs, bpf_watch_inode() can monitor the
destruction of sockfs inodes and the created file entry can hold the bpf
object's reference. In this case, it is truly "pinning".

File operations other than seq_show can also be implemented using bpf.
For example, bpf may be of help for .poll and .mmap in kernfs.

Patch organization:
 - patch 1/8 and 2/8 are preparations. 1/8 implements bpf_watch_inode();
   2/8 records bpffs inode in bpf object.
 - patch 3/8 and 4/8 implement generic logic for creating bpf backed
   kernfs file.
 - patch 5/8 and 6/8 add a new program type for formatting output.
 - patch 7/8 implements cgroup seq_show operation using bpf.
 - patch 8/8 adds selftest.

Hao Luo (8):
  bpf: Support pinning in non-bpf file system.
  bpf: Record back pointer to the inode in bpffs
  bpf: Expose bpf object in kernfs
  bpf: Support removing kernfs entries
  bpf: Introduce a new program type bpf_view.
  libbpf: Support of bpf_view prog type.
  bpf: Add seq_show operation for bpf in cgroupfs
  selftests/bpf: Test exposing bpf objects in kernfs

 include/linux/bpf.h                           |   9 +-
 include/uapi/linux/bpf.h                      |   2 +
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/bpf_view.c                         | 190 ++++++++++++++
 kernel/bpf/bpf_view.h                         |  25 ++
 kernel/bpf/inode.c                            | 219 ++++++++++++++--
 kernel/bpf/inode.h                            |  54 ++++
 kernel/bpf/kernfs_node.c                      | 165 ++++++++++++
 kernel/bpf/syscall.c                          |   3 +
 kernel/bpf/verifier.c                         |   6 +
 kernel/trace/bpf_trace.c                      |  12 +-
 tools/include/uapi/linux/bpf.h                |   2 +
 tools/lib/bpf/libbpf.c                        |  21 ++
 .../selftests/bpf/prog_tests/pinning_kernfs.c | 245 ++++++++++++++++++
 .../selftests/bpf/progs/pinning_kernfs.c      |  72 +++++
 15 files changed, 995 insertions(+), 32 deletions(-)
 create mode 100644 kernel/bpf/bpf_view.c
 create mode 100644 kernel/bpf/bpf_view.h
 create mode 100644 kernel/bpf/inode.h
 create mode 100644 kernel/bpf/kernfs_node.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/pinning_kernfs.c
 create mode 100644 tools/testing/selftests/bpf/progs/pinning_kernfs.c

-- 
2.34.1.448.ga2b2bfdf31-goog

