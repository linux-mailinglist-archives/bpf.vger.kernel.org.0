Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B066E3F3C26
	for <lists+bpf@lfdr.de>; Sat, 21 Aug 2021 20:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhHUStI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 21 Aug 2021 14:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbhHUStI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 21 Aug 2021 14:49:08 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DAEC061575;
        Sat, 21 Aug 2021 11:48:28 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id j2so3397395pll.1;
        Sat, 21 Aug 2021 11:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YFp91sLeLK3hJtIZ3y93Vq2ajpewNkRNEYqAKJVS7oQ=;
        b=V3b4h+F/GH+PDcCFEl6TIXQHzyvepsirZBoz1Zop5YykyUf8NS8hlQfNZeLBFPCJFd
         Pi19PXLfGfEvuRZemH75561ed9swAYx/dgkXqhBnUmzvFyUtN8gcpK3BH2G8yTL4eWNN
         ssGAecmrqk9gvQROGW/V3lvWkzBc18FWIaCgZI2K1UFjIE2ESnpJONQwne5kX2TaUitq
         D5GHMH/kXIjZLwCARtDRzxt3rRW9qE5qtAXA5LOZzUW6Pu2Qt6vlFkcIl9RpOvae6vfA
         jr8JSOXMahCfhNmyi3qgnAgRDsIu3SvcSFDVP+5TdCXFlGnp3nKsNarnxl4+YyLRMYLT
         TkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YFp91sLeLK3hJtIZ3y93Vq2ajpewNkRNEYqAKJVS7oQ=;
        b=ewnbbtjhhIXuemXNTeJaNPi+wIaeKQcEnvlGpwSx9B9+JbvWr3LB0BaQN6pFVl4nMN
         rF0H5+WIFaVHqewPpyy5MTkBSaSV4c/IE1Y0qRryJhWNaPDL/XBLW2bOwiRu6/p1gaA3
         EkmdnjrxfJIp9jtoaq/I9yCNvpp/QQRMq5AiZaYVCYY8L3k3fNTwcNfOdQ0vXy8U2ml8
         8iZJ3UcWrYiel1DcCXp1WvWR0S3dUg8D9b7AFtVJNn8JcDc1pyBBGmTJVBgTQhfLBk35
         DLyNAD7zsuPXlOwemWsrUdOEK0lKTGtJSC8TQyOHjTg7bAIt+GaYJWbnuz9zFR7Ub+Hy
         5PlQ==
X-Gm-Message-State: AOAM5317CjCX4FZjenuCgkOAYwfTc0c6gqpz9vdREx/k7cdHN92DcLLn
        48GA6R1wqlmlp3694GPPPPp/EzBNRM8=
X-Google-Smtp-Source: ABdhPJygG/cOO1Hn8RXsr41zJ6C/F3NKCUGYXAJFAvkQhfYMzuL/yOuLfwx/vBjldZBzVQtVUvDpcg==
X-Received: by 2002:a17:90a:cb93:: with SMTP id a19mr11262395pju.215.1629571707894;
        Sat, 21 Aug 2021 11:48:27 -0700 (PDT)
Received: from localhost ([2405:201:6014:d820:9cc6:d37f:c2fd:dc6])
        by smtp.gmail.com with ESMTPSA id e3sm11186808pfi.189.2021.08.21.11.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 11:48:27 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Spencer Baugh <sbaugh@catern.com>,
        Andy Lutomirski <luto@kernel.org>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Alexander Mihalicyn <alexander@mihalicyn.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH bpf-next RFC v1 0/5] Implement file local storage
Date:   Sun, 22 Aug 2021 00:18:19 +0530
Message-Id: <20210821184824.2052643-1-memxor@gmail.com>
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

The implementation is exactly the same as bpf_inode_storage, except some
modifications to use struct file * as the key instead of struct inode *.

[0]: https://www.usenix.org/legacy/event/sec10/tech/full_papers/Watson.pdf

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
 .../bpf/prog_tests/test_local_storage.c       |  51 ++++
 .../selftests/bpf/progs/local_storage.c       |  23 ++
 16 files changed, 443 insertions(+), 5 deletions(-)
 create mode 100644 kernel/bpf/bpf_file_storage.c

-- 
2.33.0

