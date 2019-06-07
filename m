Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B62893920E
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2019 18:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730787AbfFGQ3l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jun 2019 12:29:41 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:49615 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730775AbfFGQ3k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Jun 2019 12:29:40 -0400
Received: by mail-qt1-f201.google.com with SMTP id 97so2265102qtb.16
        for <bpf@vger.kernel.org>; Fri, 07 Jun 2019 09:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5w1rHDEgykvg+sQcOr0DvAmAd6C30bFeeDMr27zQ+cU=;
        b=cNtwItOpBVvg+Lrk/tY9pXQsO1xOgqYbrRVE94H6BVJD3eGMLoG09UVUPHUtPaNypN
         cuW3RQZZOmfDSH/u8dbHBxitIU44gXZ/u3Jwopt36zb/q9otgUH2l15NdNFxJoXNg0j8
         wB9S5dyn2xXleQQIIVefiP9/pCV4vfIfKW3MVOMCsANgigh3LvV8gnELmaDA+gQuo5Wd
         Sn/1MUurdXd6y5A6ywPceeThVq5c/Rbhrothpo7j2uyckJv1f1PtrEc0cWCinVVQNI3/
         d2ly8acJ4dXAI/BGxUEs8fRZjWV+0UWIeeSWgkjAiqfSAp9DeP9NB3vPQuy13RAKjvWN
         7YnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5w1rHDEgykvg+sQcOr0DvAmAd6C30bFeeDMr27zQ+cU=;
        b=HOOoq5rjV9V17pszYJd4YU1yegs/Qy762uTUWqCcEB3FByLfMTqVPGa2V3f85nzHF1
         Lh/SBU5ZvCiQXxxKKN4G0ZuKdSpVhB4EXtCTWLPAVRkutXlFWCNpVUBwnixcE59QvG7U
         FPHrApIIQn34rLHyXy+OffVkI9AbBinEUaJrf0FHPikHm1vh75ldwHooIz57s2pbsqt/
         6THiozqW+AYTxuTRb+AkCu21a7Q9aXigtANhhQ7DaAgo6HZgu4Ag7TyrHzcvk2cd8MYA
         V/zuOAqWNlONAJPkiHho4UBmNaqidatW8JYD/9duExX2wra/zWmUtnI8pwIUlT7FHFHm
         1vxQ==
X-Gm-Message-State: APjAAAX50Fb7F6xWMVuflmOUsL+o+MjTywt3/G07wEHdzxvNsIaF9mbi
        f48phoHqXGbBXdR4gd6igq5AdL4=
X-Google-Smtp-Source: APXvYqyxMA/WQRb3S3kzR7dCsZuTciJvXSDGe6u/5GqtAOZHTQAKLIZhY1wVwtt3JYYKo7FG3i1Z+9A=
X-Received: by 2002:a0c:d1f0:: with SMTP id k45mr28404317qvh.69.1559924979294;
 Fri, 07 Jun 2019 09:29:39 -0700 (PDT)
Date:   Fri,  7 Jun 2019 09:29:19 -0700
In-Reply-To: <20190607162920.24546-1-sdf@google.com>
Message-Id: <20190607162920.24546-8-sdf@google.com>
Mime-Version: 1.0
References: <20190607162920.24546-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH bpf-next v3 7/8] bpf: add sockopt documentation
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Provide user documentation about sockopt prog type and cgroup hooks.

v2:
* use return code 2 for kernel bypass

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
2.22.0.rc1.311.g5d7573a151-goog

