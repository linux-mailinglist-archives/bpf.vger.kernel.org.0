Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9A14A6686
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 21:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiBAUzl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 15:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiBAUzk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Feb 2022 15:55:40 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC107C061714
        for <bpf@vger.kernel.org>; Tue,  1 Feb 2022 12:55:39 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id r9-20020a6560c9000000b00343fa9529e5so10995511pgv.18
        for <bpf@vger.kernel.org>; Tue, 01 Feb 2022 12:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=P0fhmv9LunS75BE8jJrWpX2XAenYYbzr/blDuojXLgY=;
        b=njk9lbaWPVy1YcoQkD++10xy9Pcs66jQhwNO0JLKsPQmGvEyAVsHzj2TlO0ynzeON6
         wbG9qGdCoW6NH1lq1ZUf3Hn+x4S8UfSRgI1GTggeFpg3Wo6tbIsKuUvJW2Kv6FeCiFEi
         6oahXtgvhujNvHCf9/JQV8QMlDzbDmHcMRovKzA/fRSb8gKItWGg/5PAk9vtQHcyQbPG
         d7x4UPwfVcxrEgkopAf+pvzyOZJvY1aVXJgTCat/RnDJRPa63BYQObEqknom0FbFPkE+
         RoAVCZMCjYZYavsN1cTYmOuB2qYzwhc47dRgOZZ4/qX3aQHOcu62j1EvVyWfm9P37diS
         M4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=P0fhmv9LunS75BE8jJrWpX2XAenYYbzr/blDuojXLgY=;
        b=D4ItqG4ITT9lxqiu5VK5/E5S1+6FQ42RPwyjDOoFMxLmm/XKC1pGXxD39WWxtcHu2k
         GHwFjDAbTDhX5f61PpSQCQC0v12rN9j8Qczrebvdbm2RW/80pM2Ya/9O+3Bzi/S7snjt
         QnSh1QElMcHpO9JZYiraRCf1dMtG/o7SxW0d7LaO7151Vr4fuUOba/WCaSpwfw2Bvn+H
         Aen90DTm3zKuHoR6tVG1llYvQIs7zGYa/EydTvlhg1QZyoXo8q0nG0miACViUwTpd8/Y
         e+GET9tFNUxOgCpyc7R5Cru4YGq9wkQGkh6vxOK3lgT6wyTcgOSHpwvU/I2C+o0XTff0
         +KHg==
X-Gm-Message-State: AOAM533onI8h6V1QOet0dpQ0OGwBA36rKydpz4nW7+2nrqYTDFfYAuIL
        ArIcrJaIaap4Vh45btuBQr7oXDEIsAk=
X-Google-Smtp-Source: ABdhPJzwiVun/CMtOP9irD+PbxlYzas1r71Z3x/IbYjCYzmYOgFJfJQdpujnottqj6N/F3KM9Fq1QXZEgsw=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:1cdb:a263:2495:80fd])
 (user=haoluo job=sendgmr) by 2002:a17:903:1042:: with SMTP id
 f2mr27997904plc.115.1643748939163; Tue, 01 Feb 2022 12:55:39 -0800 (PST)
Date:   Tue,  1 Feb 2022 12:55:29 -0800
Message-Id: <20220201205534.1962784-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH RFC bpf-next v2 0/5] Extend cgroup interface with bpf
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset introduces a new program type to extend the cgroup interfaces.
It extends the bpf filesystem (bpffs) to allow creating a directory
hierarchy that tracks any kernfs hierarchy, in particular cgroupfs. Each
subdirectory in this hierarchy will keep a reference to a corresponding
kernfs node when created. This is done by associating a new data
structure (called "tag" in this patchset) to the bpffs directory inodes.
File inode in bpffs holds a reference to bpf object and directory inode
may point to a tag, which holds a kernfs node.

A bpf object can be pinned in these directories and objects can choose to
enable inheritance in tagged directories. In this patchset, a new
program type "cgroup_view" is introduced, which supports inheritance.
More specifically, when a link to cgroup_view prog is pinned in a bpffs
directory, it tags the directory and connects the directory to the root
cgroup. Subdirectories created underneath has to match a subcgroup, and
when created, they will inherit the pinned cgroup_view link from the
parent directory.

The pinned cgroup_view objects can be read as files. When the object is
read, it tries to get the cgroup its parent directory is matched to.
Failure to get the cgroup's reference will not run the cgroup_view prog.
Users can implement cgroup_view program to define what to print out to
the file, given the cgroup object.

See patch 5/5 for an example of how this works.

Userspace has to manually create/remove directories in bpffs to mirror
the cgroup hierarchy. It was suggested using overlayfs to create a
hierarchy that contains both cgroupfs and bpffs. But after some
experiments, I found overlayfs is not intended to be used this way:
overlayfs assumes the underlying filesystem will not change [1], but our
underlaying fs (i.e. cgroupfs) will change and cause weird behavior. So
I didn't pursue in that direction.

This patchset v2 is only for demonstrating the high level design. There
are a lot of places in its implementation that can be improved. Cgroup_view
is a type of bpf_iter, because seqfile printing has been supported well
in bpf_iter, although cgroup_view is not iterating kernel objects.

Changes v1->v2:
 - Complete redesign. v1 implements pinning bpf objects in cgroupfs[2].
   v2 implements object inheritance in bpffs. Due to its simplicity,
   bpffs is better for implementing inheritance compared to cgroupfs.
 - Extend selftest to include a more realistic use case. The selftests
   in v2 developed a cgroup-level sched performance metric and exported
   through the new prog type.

[1] https://www.kernel.org/doc/html/latest/filesystems/overlayfs.html#changes-to-underlying-filesystems
[2] https://lore.kernel.org/bpf/Ydd1IIUG7%2F3kQRcR@google.com/

Hao Luo (5):
  bpf: Bpffs directory tag
  bpf: Introduce inherit list for dir tag.
  bpf: cgroup_view iter
  bpf: Pin cgroup_view
  selftests/bpf: test for pinning for cgroup_view link

 include/linux/bpf.h                           |   2 +
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/bpf_iter.c                         |  11 +
 kernel/bpf/cgroup_view_iter.c                 | 114 ++++++++
 kernel/bpf/inode.c                            | 272 +++++++++++++++++-
 kernel/bpf/inode.h                            |  55 ++++
 .../selftests/bpf/prog_tests/pinning_cgroup.c | 143 +++++++++
 tools/testing/selftests/bpf/progs/bpf_iter.h  |   7 +
 .../bpf/progs/bpf_iter_cgroup_view.c          | 232 +++++++++++++++
 9 files changed, 829 insertions(+), 9 deletions(-)
 create mode 100644 kernel/bpf/cgroup_view_iter.c
 create mode 100644 kernel/bpf/inode.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/pinning_cgroup.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_cgroup_view.c

-- 
2.35.0.rc2.247.g8bbb082509-goog

