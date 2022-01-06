Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD712486CB8
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 22:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244522AbiAFVvK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 16:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244453AbiAFVvJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jan 2022 16:51:09 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A2AC061245
        for <bpf@vger.kernel.org>; Thu,  6 Jan 2022 13:51:09 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k130-20020a255688000000b0060c3dcae580so7539213ybb.6
        for <bpf@vger.kernel.org>; Thu, 06 Jan 2022 13:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kdM0s6QqOxdtaUmFhX2PE5X5ddjgitMB71Dm4q7m87s=;
        b=egtzppUfJZc50O5tYkFPQXR/6GgVJz+mrQaH43+iUkKFuCPLyw1mtMYaODmRJ9dsuz
         degQTFKR+jXbAqTZQfq/+zjjW/yVSQHsmt/+gjFGhRRWLnJZ4rjp2e0k3O+6vRVKDx8S
         P/tvgsJx5pxNui0NkA5I2zsN2Fz+HYg67ngvX8zSPblK5LOB2aM/9LHAdZ/evqeArCQz
         RGu6EJOs7YpjNrI7tNvpWmj/VId3e8gBfW2nbkwkjGo3JOt65NypzdAMx0ADhjtfzJY/
         T1USgyFJP7obT9geoAK2Dlnu8nA0qrXZEtA/o0Ohs1HCX0i6bkDI92YhLySNL4dI4dJx
         PvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kdM0s6QqOxdtaUmFhX2PE5X5ddjgitMB71Dm4q7m87s=;
        b=d1m7g17Xlo43tktonQfVCGgUD2DyLsVcrRuki5w6usTBdfZdokdxXoLcNHODHUzRPl
         d2bKmYaA+wEpiU936psA+uCHHf09p9tv4Bol+b+MK5nlBl+mxRUGmL/b3SK/J98Yi+lr
         I0qUTjyDrRcVkQl9L8DUWExBp8pjpZvZC8zN7wUbVjRpEP2nnJmPO4n9So+QG35dlso+
         RQHI60/Nkl2qPUo49dAt39JgI/OeO1RjJoGR/8jdCygoeWLUTGXr1tnauyeUl504cHaz
         Z4FMo3HmuqZGq70ZEB4KOCLdzat1l85e5RaqZF+JAg04uRwVW6gb6sIG+6r3hzKHq34P
         p/Zw==
X-Gm-Message-State: AOAM532cvPh9K63/2+gfEuH7yoktfPkw3VdWwStObyHNbJC7MclLWQk4
        FY4nJjEaN6RQktomg/C8JSpgJ6OVH6o=
X-Google-Smtp-Source: ABdhPJyNu7Gfzyiuq80HsMXPFySvIdDkqMaH9rKQRtHdhnpXq4I6O/H59tabZKEca2hPsN+XkR87G7v+Hyw=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:3a2:a76c:b77f:b671])
 (user=haoluo job=sendgmr) by 2002:a25:880d:: with SMTP id c13mr79072440ybl.720.1641505868695;
 Thu, 06 Jan 2022 13:51:08 -0800 (PST)
Date:   Thu,  6 Jan 2022 13:50:51 -0800
Message-Id: <20220106215059.2308931-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH RFC bpf-next v1 0/8] Pinning bpf objects outside bpffs
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        Hao Luo <haoluo@google.com>
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

