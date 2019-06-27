Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC6658BD0
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2019 22:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfF0UjU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jun 2019 16:39:20 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:47003 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfF0UjU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Jun 2019 16:39:20 -0400
Received: by mail-pf1-f201.google.com with SMTP id g21so2288464pfb.13
        for <bpf@vger.kernel.org>; Thu, 27 Jun 2019 13:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GJhU23UOif2GjRZjRfYE41MfOFchIeWrR2OXEPXvEXs=;
        b=qrjiZ4cpcxsONfl52ajC+WG3SumFTBpHTwM7iz42ZnH5xzWNWR8yUHbeaR/49wabHC
         vqa58pBL8B0JCVShFeFL+27bKvfVsnxzwO/SDyY7BdvHTsw1OyyTXawblZ3X3JslWjV3
         r0plDOXI+fy96Q17fAKnIJGJ/9p87+8qT0Ob2BHYoyHwcbGi446TdMU3fHoCfWqa2MY2
         lT4oHR1NFEbp9CSym7epQ+kT1UVPa0h7hBYtNlGKKD3qCMrJKuN/vTAdigdrqEPvk0pG
         nunS+PR0geN/zmJ+F8+5GX6dhzNF4hMVcsHYPJfQBv7tNWOsEqB2qB6dXEZJii4VCkeC
         jh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GJhU23UOif2GjRZjRfYE41MfOFchIeWrR2OXEPXvEXs=;
        b=G/tMS3rXrynRLPr6JiGQdGge7nmheAV2/KieZV4+kKZd0+q6ldHPmtTOza2CtNOOEX
         ag0Dx10M5CSly0wpsDtWUWZurAlye0azMpNQN8e4pFmubSW/y7QjhMiIpiua4TwP78VZ
         KSvTIgwWgtx7eoG7vHhg+UT0pm1J35JRjB+xvq//ogj0YeXJNwigi68wI7QUIyBu0PhR
         Q92nbyoJklVr3OnFGXuf3pfgzirZzKNNr/08lPf9twit4y+Xv9cqj+e616IIIgON0fwK
         p1ejWG73tFACRfMWeV/LeH7HH1gm9fgdwbea436SBj9QpEpFGlST3HCEj/g4VhJoebbg
         tayw==
X-Gm-Message-State: APjAAAUJjXIWwLO6cGxftY8IiE3VLiepvbqjhVcJ4JwQ5kqq5L/LuI7j
        NpqVygAlXlE/GNuU/OxsOqu5vHM=
X-Google-Smtp-Source: APXvYqz0B/vD9TZlv4Ut8CK2n0U1QbmfsPZecbke/WClpwuDdZTO6dt1D0/7svG3jN6QSGNX5/gsW6M=
X-Received: by 2002:a63:511b:: with SMTP id f27mr5513548pgb.135.1561667958602;
 Thu, 27 Jun 2019 13:39:18 -0700 (PDT)
Date:   Thu, 27 Jun 2019 13:38:54 -0700
In-Reply-To: <20190627203855.10515-1-sdf@google.com>
Message-Id: <20190627203855.10515-9-sdf@google.com>
Mime-Version: 1.0
References: <20190627203855.10515-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next v9 8/9] bpf: add sockopt documentation
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Andrii Nakryiko <andriin@fb.com>, Martin Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Provide user documentation about sockopt prog type and cgroup hooks.

v9:
* add details about setsockopt context and inheritance

v7:
* add description for retval=0 and optlen=-1

v6:
* describe cgroup chaining, add example

v2:
* use return code 2 for kernel bypass

Cc: Andrii Nakryiko <andriin@fb.com>
Cc: Martin Lau <kafai@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 Documentation/bpf/index.rst               |  1 +
 Documentation/bpf/prog_cgroup_sockopt.rst | 93 +++++++++++++++++++++++
 2 files changed, 94 insertions(+)
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
index 000000000000..c47d974629ae
--- /dev/null
+++ b/Documentation/bpf/prog_cgroup_sockopt.rst
@@ -0,0 +1,93 @@
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
+sockopt and it has writable context: it can modify the supplied arguments
+before passing them down to the kernel. This hook has access to the cgroup
+and socket local storage.
+
+If BPF program sets ``optlen`` to -1, the control will be returned
+back to the userspace after all other BPF programs in the cgroup
+chain finish (i.e. kernel ``setsockopt`` handling will *not* be executed).
+
+Note, that ``optlen`` can not be increased beyond the user-supplied
+value. It can only be decreased or set to -1. Any other value will
+trigger ``EFAULT``.
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
+has been increased above initial ``getsockopt`` value (i.e. userspace
+buffer is too small), ``EFAULT`` is returned.
+
+This hook has access to the cgroup and socket local storage.
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
+Same for ``BPF_CGROUP_SETSOCKOPT``: if the program is attached to
+A and B, the trigger order is B, then A. If B does any changes
+to the input arguments (``level``, ``optname``, ``optval``, ``optlen``),
+then the next program in the chain (A) will see those changes,
+*not* the original input ``setsockopt`` arguments. The potentially
+modified values will be then passed down to the kernel.
+
+Example
+=======
+
+See ``tools/testing/selftests/bpf/progs/sockopt_sk.c`` for an example
+of BPF program that handles socket options.
-- 
2.22.0.410.gd8fdbe21b5-goog

