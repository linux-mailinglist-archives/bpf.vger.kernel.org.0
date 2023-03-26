Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B09D6C9362
	for <lists+bpf@lfdr.de>; Sun, 26 Mar 2023 11:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjCZJWW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Mar 2023 05:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjCZJWU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Mar 2023 05:22:20 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C2F5BB1;
        Sun, 26 Mar 2023 02:22:19 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id t19so5854847qta.12;
        Sun, 26 Mar 2023 02:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679822537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4JUY0vHvLERzzHWhNq8Rp87qcHqbkDVGp191/I1Fx0o=;
        b=hxPGVTILocq4nVaMiPMZ+SChKdyPTIUO2eHI7YCoUEHkOB5mK5TxFtSs1jCKOUPltB
         xykIzzPNFliOyqGx5MZoG/R2wB4+OgBiBgr9CYJAKiXmBJMNC08/+X8naNgmlbkhbPgy
         3KplZNvj6cImdSZ72dAZGR7JS/GvIFsOkBoQp5umvFqDz2VMDNUS8FU6OTfyGfahpeBf
         UsaKolEb9DWSuloVPXcVhleg0kUaoKxAhWq78chCp7T/wEx8uZP9JoFw51eUGt00joYz
         VGx7N7K6YHPOZjUjdiwXPwB9YkKdSmT84qQwDFechghEBJhitGcoLk2vS6ZthdODqDIA
         Q+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679822537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4JUY0vHvLERzzHWhNq8Rp87qcHqbkDVGp191/I1Fx0o=;
        b=WL7xqxtTK2cmtizlZef+TCvGV2o7/PCUVOd4pOI3JuGubXxz9eiTiHFdeB+XQDNvRu
         gwJ2nPRlk0KFo7TifJHMo/UEQCTe3LLUqNJ+zt5UFv1TOTKKG0lUZnLyA9Y1uR2D7Vhj
         W8RImHYtp9kq/1uJbwJoSoQ9+miF7SqfpUxwJHyXa3UtYVknjnHZeG5KTZ33F9zP5YsD
         D0Wzmry2xGZ3+D0c4ag29ZFzVk6mMKQeXBd0X5qX2SAWQ6rRYy/kIozSjq0ZYnlh/k++
         yCDTyBy+CEATlFNfyCby1AyJxuwfE7Vrzyz2Oocmp95jsz+1TnCuKf/Vh4RqjHJDNQIf
         od4w==
X-Gm-Message-State: AO0yUKWNFdWMkNAN/7pC9+ZK+K2xEM9RWaREzQuCOWaKRjpU7hEh4qjT
        mQl3qyTal7E3lznB4Ua8JbE=
X-Google-Smtp-Source: AK7set9TQzi3X0S39HxxJgzr/e5oAq0ITGXEKrPv9HvQXPBphCrYAtfB0F+0ePye1aAQNqV3OvZOvA==
X-Received: by 2002:a05:622a:1983:b0:3e0:3d65:19d2 with SMTP id u3-20020a05622a198300b003e03d6519d2mr14458863qtc.20.1679822537149;
        Sun, 26 Mar 2023 02:22:17 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:1000:1a1f:5400:4ff:fe5e:1d32])
        by smtp.gmail.com with ESMTPSA id y5-20020ac87085000000b003e014845d9esm10257987qto.74.2023.03.26.02.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 02:22:16 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 00/13] bpf: Introduce BPF namespace 
Date:   Sun, 26 Mar 2023 09:21:55 +0000
Message-Id: <20230326092208.13613-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently only CAP_SYS_ADMIN can iterate BPF object IDs and convert IDs
to FDs, that's intended for BPF's security model[1]. Not only does it
prevent non-privilidged users from getting other users' bpf program, but
also it prevents the user from iterating his own bpf objects.

In container environment, some users want to run bpf programs in their
containers. These users can run their bpf programs under CAP_BPF and
some other specific CAPs, but they can't inspect their bpf programs in a
generic way. For example, the bpftool can't be used as it requires
CAP_SYS_ADMIN. That is very inconvenient.

Without CAP_SYS_ADMIN, the only way to get the information of a bpf object
which is not created by the process itself is with SCM_RIGHTS, that
requires each processes which created bpf object has to implement a unix
domain socket to share the fd of a bpf object between different
processes, that is really trivial and troublesome.

Hence we need a better mechanism to get bpf object info without
CAP_SYS_ADMIN. 

BPF namespace is introduced in this patchset with an attempt to remove 
the CAP_SYS_ADMIN requirement. The user can create bpf map, prog and
link in a specific bpf namespace, then these bpf objects will not be
visible to the users in a different bpf namespace. But these bpf
objects are visible to its parent bpf namespace, so the sys admin can 
still iterate and inspect them.

BPF namespace is similar to PID namespace, and the bpf objects are
similar to tasks, so BPF namespace is very easy to understand. These
patchset only implements BPF namespace for bpf map, prog and link. In the
future we may extend it to other bpf objects like btf, bpffs and etc.
For example, we can allow some of the BTF objects to be used in
non-init bpf namespace, then the container user can only trace the
processes running in his container, but can't get the information of
tasks running in other containers.

A simple example is introduced into selftests/bpf on how to use the bpf
namespace.

Putting bpf map, prog and link into bpf namespace is the first step.
Let's start with it.

[1]. https://lore.kernel.org/bpf/20200513230355.7858-1-alexei.starovoitov@gmail.com/

Yafang Shao (13):
  fork: New clone3 flag for BPF namespace
  proc_ns: Extend the field type in struct proc_ns_operations to long
  bpf: Implement bpf namespace
  bpf: No need to check if id is 0
  bpf: Make bpf objects id have the same alloc and free pattern
  bpf: Helpers to alloc and free object id in bpf namespace
  bpf: Add bpf helper to get bpf object id
  bpf: Alloc and free bpf_map id in bpf namespace
  bpf: Alloc and free bpf_prog id in bpf namespace
  bpf: Alloc and free bpf_link id in bpf namespace
  bpf: Allow iterating bpf objects with CAP_BPF in bpf namespace
  bpf: Use bpf_idr_lock array instead
  selftests/bpf: Add selftest for bpf namespace

 fs/proc/namespaces.c                      |   4 +
 include/linux/bpf.h                       |   9 +-
 include/linux/bpf_namespace.h             |  88 ++++++++++
 include/linux/nsproxy.h                   |   4 +
 include/linux/proc_ns.h                   |   3 +-
 include/linux/user_namespace.h            |   1 +
 include/uapi/linux/bpf.h                  |   7 +
 include/uapi/linux/sched.h                |   1 +
 kernel/bpf/Makefile                       |   1 +
 kernel/bpf/bpf_namespace.c                | 283 ++++++++++++++++++++++++++++++
 kernel/bpf/offload.c                      |  16 +-
 kernel/bpf/syscall.c                      | 262 ++++++++++-----------------
 kernel/bpf/task_iter.c                    |  12 ++
 kernel/fork.c                             |   5 +-
 kernel/nsproxy.c                          |  19 +-
 kernel/trace/bpf_trace.c                  |   2 +
 kernel/ucount.c                           |   1 +
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c |  13 +-
 tools/include/uapi/linux/bpf.h            |   7 +
 tools/testing/selftests/bpf/Makefile      |   3 +-
 tools/testing/selftests/bpf/test_bpfns.c  |  76 ++++++++
 21 files changed, 637 insertions(+), 180 deletions(-)
 create mode 100644 include/linux/bpf_namespace.h
 create mode 100644 kernel/bpf/bpf_namespace.c
 create mode 100644 tools/testing/selftests/bpf/test_bpfns.c

-- 
1.8.3.1

