Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD57E5188E
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2019 18:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732074AbfFXQYy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jun 2019 12:24:54 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:50404 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732073AbfFXQYy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Jun 2019 12:24:54 -0400
Received: by mail-pl1-f202.google.com with SMTP id 71so7575085pld.17
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2019 09:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PScmwSK+K9IB8yZqW06OWrhD6812WTEkgOnr9yWmmf4=;
        b=wEfx71v1btEOlvKmKmG4dkf1KGyws8CgL75i2MN8jxzFYdlqumo5TK3W+0T/ktO7k/
         HwHeQ1f0wq9/FGsZMXF4PsxNBKLN0DQflEMUoIPj5MdFDnnAkZZtOtTo4fGx2a/4hT3c
         Gev0bUeqtsRN1DCThef+94kIX01/oQ5bUsrLuXrFART5/z7+gOkArdXJDtyyGSSCs8rK
         qRGBp8PF02XPgqBvvgVaE1vy+yodX0/bLieUqDu2Yi/rQgL0qsRUZE4mFapSn19Zx/2/
         ah1UJZVEKEr1jOSK4F+1HbA0HSsKsLYtgBU9rKobFieW96WkuQL+3OGK6uLZ4Exli0V2
         OunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PScmwSK+K9IB8yZqW06OWrhD6812WTEkgOnr9yWmmf4=;
        b=SPHoG4O2OeQ0UIUz35q3EoC2OTi/bEmZUyIemtvH34nXdQIxy3S6mN21W1hOI8YvgX
         y+RulnEEtQ9F1DLGR8ko8Y8s1h2/6dUVEfBkVxhbbIDscYz+x7iaPz0NSJDajhI/Dmxx
         kpT62G133mD0JUB6FjJi7Xnv7ljFaI5S30e7eXlM3yfJLIB9+eaIG9sQN/oEQpAfKbs6
         SPpSmmECG4snqjt/v378xkGDpQ7RsCEhPvqswRZG3V91sO9QddrBS/rAa1fy7BC3C5hZ
         AL/aso8utoHJqt4IKPq5OqhcsAdCbuUqVoaIizNCEyWl1Z5HdkHiaLrPtD+Kd9mdtEwO
         eqgg==
X-Gm-Message-State: APjAAAUoFsRV0huScK6ntR1Gd8AY6+kgKCgRHMfYsyrOPXi/p+Iv/JTM
        vHXDc8sD+zexNUWsXjWG7r96IKc=
X-Google-Smtp-Source: APXvYqzMMHwmVqaFzQnYx7bu5yd1OmIKwA79DzoWPcErMHCvC7ljY+EnI7Uo/KFuXh+MSyIIpKQtQOU=
X-Received: by 2002:a63:8043:: with SMTP id j64mr18485659pgd.216.1561393493248;
 Mon, 24 Jun 2019 09:24:53 -0700 (PDT)
Date:   Mon, 24 Jun 2019 09:24:28 -0700
In-Reply-To: <20190624162429.16367-1-sdf@google.com>
Message-Id: <20190624162429.16367-9-sdf@google.com>
Mime-Version: 1.0
References: <20190624162429.16367-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next v8 8/9] bpf: add sockopt documentation
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>, Martin Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Provide user documentation about sockopt prog type and cgroup hooks.

v7:
* add description for retval=0 and optlen=-1

v6:
* describe cgroup chaining, add example

v2:
* use return code 2 for kernel bypass

Cc: Martin Lau <kafai@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 Documentation/bpf/index.rst               |  1 +
 Documentation/bpf/prog_cgroup_sockopt.rst | 82 +++++++++++++++++++++++
 2 files changed, 83 insertions(+)
 create mode 100644 Documentation/bpf/prog_cgroup_sockopt.rst

diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
index d3fe4cac0c90..801a6ed3f2e5 100644
--- a/Documentation/bpf/index.rst
+++ b/Documentation/bpf/index.rst
@@ -42,6 +42,7 @@ Program types
 .. toctree::
    :maxdepth: 1
 
+   prog_cgroup_sockopt
    prog_cgroup_sysctl
    prog_flow_dissector
 
diff --git a/Documentation/bpf/prog_cgroup_sockopt.rst b/Documentation/bpf/prog_cgroup_sockopt.rst
new file mode 100644
index 000000000000..24985740711a
--- /dev/null
+++ b/Documentation/bpf/prog_cgroup_sockopt.rst
@@ -0,0 +1,82 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================
+BPF_PROG_TYPE_CGROUP_SOCKOPT
+============================
+
+``BPF_PROG_TYPE_CGROUP_SOCKOPT`` program type can be attached to two
+cgroup hooks:
+
+* ``BPF_CGROUP_GETSOCKOPT`` - called every time process executes ``getsockopt``
+  system call.
+* ``BPF_CGROUP_SETSOCKOPT`` - called every time process executes ``setsockopt``
+  system call.
+
+The context (``struct bpf_sockopt``) has associated socket (``sk``) and
+all input arguments: ``level``, ``optname``, ``optval`` and ``optlen``.
+
+BPF_CGROUP_SETSOCKOPT
+=====================
+
+``BPF_CGROUP_SETSOCKOPT`` is triggered *before* the kernel handling of
+sockopt and it has mostly read-only context (it can modify only ``optlen``).
+This hook has access to cgroup and socket local storage.
+
+If BPF program sets ``optlen`` to -1, the control will be returned
+back to the userspace after all other BPF programs in the cgroup
+chain finish (i.e. kernel ``setsockopt`` handling will *not* be executed).
+
+Note, that the only acceptable value to set to ``optlen`` is -1. Any
+other value will trigger ``EFAULT``.
+
+Return Type
+-----------
+
+* ``0`` - reject the syscall, ``EPERM`` will be returned to the userspace.
+* ``1`` - success, continue with next BPF program in the cgroup chain.
+
+BPF_CGROUP_GETSOCKOPT
+=====================
+
+``BPF_CGROUP_GETSOCKOPT`` is triggered *after* the kernel handing of
+sockopt. The BPF hook can observe ``optval``, ``optlen`` and ``retval``
+if it's interested in whatever kernel has returned. BPF hook can override
+the values above, adjust ``optlen`` and reset ``retval`` to 0. If ``optlen``
+has been increased above initial ``setsockopt`` value (i.e. userspace
+buffer is too small), ``EFAULT`` is returned.
+
+Note, that the only acceptable value to set to ``retval`` is 0 and the
+original value that the kernel returned. Any other value will trigger
+``EFAULT``.
+
+Return Type
+-----------
+
+* ``0`` - reject the syscall, ``EPERM`` will be returned to the userspace.
+* ``1`` - success: copy ``optval`` and ``optlen`` to userspace, return
+  ``retval`` from the syscall (note that this can be overwritten by
+  the BPF program from the parent cgroup).
+
+Cgroup Inheritance
+==================
+
+Suppose, there is the following cgroup hierarchy where each cgroup
+has ``BPF_CGROUP_GETSOCKOPT`` attached at each level with
+``BPF_F_ALLOW_MULTI`` flag::
+
+  A (root, parent)
+   \
+    B (child)
+
+When the application calls ``getsockopt`` syscall from the cgroup B,
+the programs are executed from the bottom up: B, A. First program
+(B) sees the result of kernel's ``getsockopt``. It can optionally
+adjust ``optval``, ``optlen`` and reset ``retval`` to 0. After that
+control will be passed to the second (A) program which will see the
+same context as B including any potential modifications.
+
+Example
+=======
+
+See ``tools/testing/selftests/bpf/progs/sockopt_sk.c`` for an example
+of BPF program that handles socket options.
-- 
2.22.0.410.gd8fdbe21b5-goog

