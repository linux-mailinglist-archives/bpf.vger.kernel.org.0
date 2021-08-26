Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9073F8921
	for <lists+bpf@lfdr.de>; Thu, 26 Aug 2021 15:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242503AbhHZNkG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Aug 2021 09:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbhHZNkG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Aug 2021 09:40:06 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED38EC061757;
        Thu, 26 Aug 2021 06:39:18 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id m26so2816166pff.3;
        Thu, 26 Aug 2021 06:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g8BGx0Ba10IsHwKsa7FzG5NnzcV5Ex49w3yDNQPok2U=;
        b=pJkEISWL/bU9vH8h9V8nsTX97MRUPQiNyJFoPS3si5V2B7zsTfbUadc6l8BWy0zptd
         uf2Yead7L5K/rFeT8oB+tYaAJYvLUXvJX5zR7uhw54bHmXLrI6M92iRoFfl2jBx/6vvN
         Y2t8cgO2xXiFaG0lF/BQa6XwJJM3HRei5bZ5lB9UeUFOSl9HggoeQQGo50YeDCfmvVy+
         QoEH/+PtMf/7ytO7FzRJli+edZWjLoRqMEMfpmuIwCzVX3XfS8dCUF5pDs+3Y4EOaWTd
         uGceqCjCMhD1nCUt8QgnXOXAcoDhZTJxImWnqM3Ioy6/QkA12+j8oubW77BXYJPxmeO5
         JKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g8BGx0Ba10IsHwKsa7FzG5NnzcV5Ex49w3yDNQPok2U=;
        b=fFapy+sZLZFTRNECZjKNZ8mzbPT4IUSn8dZBmk91R7Iu18aaRZIzJea5niMbLy0rkE
         i4ACK0iAIBQDNGhYWkzQ5LSTfS/xHeMZQQ7qUlM0aMvv/r7dNEBK0o4hB7zLpW97sbIw
         2t2XU+WW9fxHvjvyrGDEEEqIuOJq328kg0K+jYUIy2bb3o5bvkMT4iRSTWFgtpdUiWmn
         zT0DLdxtXJe1vhGbCpKDw3Jx5FcJaRbu7DKfCS4n/pTGGA1wGpnnVwWk0P+4gwfZmdPV
         svNcqa8zWj7uCDV93WJ4+bEy74h2JAcH8Q2Y+ByK73IMUQJtYNuS3QynFhrEz5WpzywL
         LkUQ==
X-Gm-Message-State: AOAM532zTob9phDNtlCRb3E4xlKuDDA9lo3hxNnGwb52IDgUJXSFR/8O
        o+fmeDafjmM+13znWciJm87nXBxDg6I=
X-Google-Smtp-Source: ABdhPJzASv/6AbUjEuve2eNqS8IeJFLvptgHhP9dy7GfgqRVXgVnGPInwLnvmte2fBW23aJc9czNJg==
X-Received: by 2002:a63:eb41:: with SMTP id b1mr3494470pgk.236.1629985158140;
        Thu, 26 Aug 2021 06:39:18 -0700 (PDT)
Received: from localhost ([2405:201:6014:d820:9cc6:d37f:c2fd:dc6])
        by smtp.gmail.com with ESMTPSA id b7sm1181677pgs.64.2021.08.26.06.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 06:39:17 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Spencer Baugh <sbaugh@catern.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Alexander Mihalicyn <alexander@mihalicyn.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH bpf-next v2 0/5] Implement file local storage
Date:   Thu, 26 Aug 2021 19:09:08 +0530
Message-Id: <20210826133913.627361-1-memxor@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series implements a file local storage map for eBPF LSM programs. This
allows to tie lifetime of data in the map to an open file description (in POSIX
parlance). Like other local storage map types, lifetime of data is tied to the
struct file instance.

The main purpose is a general purpose map keyed by fd where the open file
underlying the fd (struct file *) serves as the key into the map. It is possible
to use struct file * from kernelspace, but sharing update access with userspace
means userspace has no way except kcmp-aring with another known fd with a key.
This is pretty wasteful.

It can also be used to treat the map as a set of files that have been added to
it, such that multiples sets can be looked up for matching purposes in O(1)
instead of O(n) using kcmp(2) from userspace (for same struct file *).

There are multiple other usecases served by this map. One of the motivating ones
is the ability to now implement a Capsicum [0] style capability based sandbox
using eBPF LSM, but the actual mechanism is much more generic and allows
applications to enforce rights of their own per open file that they delegate to
other users by conventional fd-passing on UNIX (dup/fork/SCM_RIGHTS).

Implementation is similar to that of bpf_inode_storage, with some modifications
to use struct file * as map key.

[0]: https://www.usenix.org/legacy/event/sec10/tech/full_papers/Watson.pdf

Changelog:
----------
RFC v1 -> v2
v1: https://lore.kernel.org/bpf/20210821184824.2052643-1-memxor@gmail.com

 * Expand selftest to demonstrate sample use, and add spin lock in test

Kumar Kartikeya Dwivedi (5):
  bpf: Implement file local storage
  tools: sync bpf.h header
  libbpf: Add bpf_probe_map_type support for file local storage
  tools: bpf: update bpftool for file_storage map
  tools: testing: Add selftest for file local storage map

 include/linux/bpf_lsm.h                       |  21 ++
 include/linux/bpf_types.h                     |   1 +
 include/uapi/linux/bpf.h                      |  39 +++
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/bpf_file_storage.c                 | 244 ++++++++++++++++++
 kernel/bpf/bpf_lsm.c                          |   4 +
 kernel/bpf/syscall.c                          |   3 +-
 kernel/bpf/verifier.c                         |  10 +
 security/bpf/hooks.c                          |   2 +
 .../bpf/bpftool/Documentation/bpftool-map.rst |   2 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   3 +-
 tools/bpf/bpftool/map.c                       |   3 +-
 tools/include/uapi/linux/bpf.h                |  39 +++
 tools/lib/bpf/libbpf_probes.c                 |   1 +
 .../bpf/prog_tests/test_local_storage.c       |  55 ++++
 .../selftests/bpf/progs/local_storage.c       |  43 +++
 16 files changed, 467 insertions(+), 5 deletions(-)
 create mode 100644 kernel/bpf/bpf_file_storage.c

-- 
2.33.0

