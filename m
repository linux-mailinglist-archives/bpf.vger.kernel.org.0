Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAD5F3BE1B
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2019 23:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389949AbfFJVIw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Jun 2019 17:08:52 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:36442 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389799AbfFJVIv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Jun 2019 17:08:51 -0400
Received: by mail-oi1-f202.google.com with SMTP id l5so2767288oih.3
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2019 14:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ICt8unkfgBC7WFQ3SzlOOLIw6vRRyqFe1e0RPZOj5V8=;
        b=Sj2lcK54w1SCvsZ3GZn23+44shb9wyS9/d6FOlgKyApPwdJoBFiHdiqO4hrPwgGlU3
         9BRh40x9qvHOXzz2/qejMoVrg7iaqq/wzgDfpUTWc0Rm/gsGmDgEfjfOJRMOu24TVOnL
         cMxfbzJzD7B+4w+J9CuKavweaYvOM/y0K/YVsJx12da79P9RQCtQU61oSLBDx0q0j6MJ
         ueFdeY/PO9OAOjeh5r6TkNsTEdRpbMc65Ir/JIN8vYPou6cR/hn02KjjrYbtO6IEq9V0
         okKv1a4h16QFWlr3K9ZGRZe4gxnpokDaaqBG1N4z0jTFPftZeByarnsONarnRXrot+/7
         OBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ICt8unkfgBC7WFQ3SzlOOLIw6vRRyqFe1e0RPZOj5V8=;
        b=A8O8I7D6yfc/e4olu5YsBmulputmnexY5EgKWX6xbJJKuZF6FuhOlg+LWi1RU4HLDv
         3jyGxwQlIm+XRTnyvE0ZYsvSL9S9c4HlmXqR7kkIVEW4Q1bANMgIAcmjHVce+4lFuvBs
         Vi9yAXMLvh8vBFnN2/76H5kolLPJkdI3C7OwrLnC85SGzTfVhbAjRbFV1XOkXcYwxLYg
         HjbAYtZDZQ+IrFwnRZoE+FL+BXY1qfbdJC4BeGIZmkk08or4DTu/NwE44nJh7XK/Sl16
         LtZh4vjm9mtyA6KuSYKnG5mQiCfDxmo4ZSEfUcciv4ggxBa9dDbFvrI5CqMdJD9Adepf
         A26A==
X-Gm-Message-State: APjAAAVtYbhipfzz1Exwt1vrMmhqj0GPtBpfF0qWweJh/HNhOndhrEb1
        SLu5VyDaTmIwxDEUmpn4WBShIrU=
X-Google-Smtp-Source: APXvYqzM0EqUDtcLIxeVLHoZQmg9KNnqdnJIt5ym/tR9W8FLrRfhXhvtvygQqQWqZotCHlAMsdLhtBE=
X-Received: by 2002:a05:6830:93:: with SMTP id a19mr391872oto.127.1560200931254;
 Mon, 10 Jun 2019 14:08:51 -0700 (PDT)
Date:   Mon, 10 Jun 2019 14:08:29 -0700
In-Reply-To: <20190610210830.105694-1-sdf@google.com>
Message-Id: <20190610210830.105694-8-sdf@google.com>
Mime-Version: 1.0
References: <20190610210830.105694-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH bpf-next v5 7/8] bpf: add sockopt documentation
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

v2:
* use return code 2 for kernel bypass

Cc: Martin Lau <kafai@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 Documentation/bpf/index.rst               |  1 +
 Documentation/bpf/prog_cgroup_sockopt.rst | 39 +++++++++++++++++++++++
 2 files changed, 40 insertions(+)
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
index 000000000000..b117451ab571
--- /dev/null
+++ b/Documentation/bpf/prog_cgroup_sockopt.rst
@@ -0,0 +1,39 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+BPF_PROG_TYPE_SOCKOPT
+=====================
+
+``BPF_PROG_TYPE_SOCKOPT`` program type can be attached to two cgroup hooks:
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
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

