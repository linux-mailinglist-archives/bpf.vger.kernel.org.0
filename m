Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 404C248B2E
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2019 20:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfFQSCF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Jun 2019 14:02:05 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:43447 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbfFQSCF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Jun 2019 14:02:05 -0400
Received: by mail-pg1-f202.google.com with SMTP id p7so2403721pgr.10
        for <bpf@vger.kernel.org>; Mon, 17 Jun 2019 11:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nJpydzbPak9Eg8s7xRZ7/o8RHZeBNqY37LOtGQ3WNlY=;
        b=kLNAgFlZnrXl+BN0LZkAmCiC5EEg6vwBQlGfoc+KpEn4Hf3r7HOENoXJgsa2DD7pUf
         hI1CyrssUsqCHVnRvZIiYLS2Nu/KBWSSm3fBO6hZf+s8aTiZxqyUz0kbz4V+U4Z/0Rbm
         rue9D4n3yJkyA5mIzCBwM2YrBrLOAoflIRYVOIpRouQiMuaIXPY51tyGf7/kb61CxKK2
         z4iBsVrtCfdLlkEtYg89YB+/v+p7F4y7bX0H8hJnGhwLYkBQkwXSJNuMMManT2fAwSEC
         u51KGdj7jRIQTi3jw4Q27SutjBXOBsKm1zYrz2wIsdwotGYIlV2rk/YFq+BguIbkKGJF
         HDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nJpydzbPak9Eg8s7xRZ7/o8RHZeBNqY37LOtGQ3WNlY=;
        b=O6xKad05170ORRNGYMB0v+0am8Eyga83ir5GABqRz5ynqi2qiajb76FruuXIyKTc0f
         6Jk4E3/6ZqW8Hyb4cmqigFyX9DPhmaNVYl49Iws5V8ApnD4DolpX6hPh7LS+YGI3Rf/L
         xKGZ7kIe4Bg/oVr8t32L3+gIJmqNIjrmwXPUmHRCQ18Pqs6RlzfrKMC7PA/8hXRagSIH
         OOek6/OrH4R1YAcDO41Z7+9F+41bpTnaZeyb0MQqwTOSfwajtV2KwwQiw/uA/EU8rSb4
         Y0ydnQ/XDRE2mQGarpxgD/n22Cael95MDtKPXN3dY/iFS+Be49XcqymUmSyJdsTt8CDO
         VIcw==
X-Gm-Message-State: APjAAAUrQitxHSP684KrEy8GwPdg4ZuFoRk0VabQ5SiLIvJI5orMI7O7
        2+ww+rwTX4Bhc+aVt+S01W7UMUs=
X-Google-Smtp-Source: APXvYqyPLznNUF2+eeXDxWfdNKqfwBD92iAwfzCjOMv4dONWjweNoSxWDTqTi7tP/B+I8g740PD6lPE=
X-Received: by 2002:a63:f146:: with SMTP id o6mr5967pgk.179.1560794523619;
 Mon, 17 Jun 2019 11:02:03 -0700 (PDT)
Date:   Mon, 17 Jun 2019 11:01:08 -0700
In-Reply-To: <20190617180109.34950-1-sdf@google.com>
Message-Id: <20190617180109.34950-9-sdf@google.com>
Mime-Version: 1.0
References: <20190617180109.34950-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next v6 8/9] bpf: add sockopt documentation
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

v6:
* describe cgroup chaining, add example

v2:
* use return code 2 for kernel bypass

Cc: Martin Lau <kafai@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 Documentation/bpf/index.rst               |  1 +
 Documentation/bpf/prog_cgroup_sockopt.rst | 72 +++++++++++++++++++++++
 2 files changed, 73 insertions(+)
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
index 000000000000..8b9d55a3e655
--- /dev/null
+++ b/Documentation/bpf/prog_cgroup_sockopt.rst
@@ -0,0 +1,72 @@
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
+``BPF_CGROUP_SETSOCKOPT`` has a read-only context and this hook has
+access to cgroup and socket local storage.
+
+BPF_CGROUP_GETSOCKOPT
+=====================
+
+``BPF_CGROUP_GETSOCKOPT`` has to fill in ``optval`` and adjust
+``optlen`` accordingly. Input ``optlen`` contains the maximum length
+of data that can be returned to the userspace. In other words, BPF
+program can't increase ``optlen``, it can only decrease it.
+
+Return Type
+===========
+
+* ``0`` - reject the syscall, ``EPERM`` will be returned to the userspace.
+* ``1`` - success: after returning from the BPF hook, kernel will also
+  handle this socket option.
+* ``2`` - success: after returning from the BPF hook, kernel will _not_
+  handle this socket option; control will be returned to the userspace
+  instead.
+
+Cgroup Inheritance
+==================
+
+Suppose, there is the following cgroup hierarchy where each cgroup
+has BPF_CGROUP_GETSOCKOPT attached at each level with
+BPF_F_ALLOW_MULTI flag::
+
+  A (root)
+   \
+    B
+     \
+      C
+
+When the application calls getsockopt syscall from the cgroup C,
+the programs are executed from the bottom up: C, B, A. As long as
+BPF programs in the chain return 1, the execution continues. If
+some program in the C, B, A chain returns 2 (bypass kernel) or
+0 (EPERM), the control is immediately passed passed back to the
+userspace. This is in contrast with any existing per-cgroup BPF
+hook where all programs are called, even if some of them return
+0 (EPERM).
+
+In the example above, if C returns 1 (continue) and then B returns
+0 (EPERM) or 2 (bypass kernel), the program attached to A will _not_
+be executed.
+
+Example
+=======
+
+See ``tools/testing/selftests/bpf/progs/sockopt_sk.c`` for an example
+of BPF program that handles socket options.
-- 
2.22.0.410.gd8fdbe21b5-goog

