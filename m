Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 539B63B992
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2019 18:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbfFJQeo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Jun 2019 12:34:44 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:45871 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbfFJQen (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Jun 2019 12:34:43 -0400
Received: by mail-oi1-f201.google.com with SMTP id i6so2947083oib.12
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2019 09:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ICt8unkfgBC7WFQ3SzlOOLIw6vRRyqFe1e0RPZOj5V8=;
        b=D4y5izwgdhbNr5meNLEBdjGWqkGaa/58pwgKzRDyYexct0qwJ72utvgFeH2xsP/hlo
         Fg3jzwfQsWIFVE33Q4jQ7ExWYhUe2ksaef5zRwBvpjJLb1J6/JDbTUhyOXJnJlxFgp6p
         TQKUmyLVG998+TLEVISTtxU6mX0HDjUjXK00evok4Ei3lqW9EJsFLIn5oJOHhyEioee7
         EuGd+w2+g9qS5BqAbbRyoCkfmqKFTRxHQg/mPbp3rkQ88kuNSAlooS2qRl42QTgqXgPU
         uGypYASB561PDgiIL597FIIRD7Owngf3BA498ToKz54WmAMsDDRyluJE4hEN/2YQZ5iH
         vBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ICt8unkfgBC7WFQ3SzlOOLIw6vRRyqFe1e0RPZOj5V8=;
        b=Y7S35jkUjdwYpuHWrKkxLVx+Nfs40GaC7/EBqnTtF/XTb7uq6ooZP49I2dikqQaDfI
         XDqVGJ+q1GyOQwovEgxFm/Sdi6t8bQj5NCfS648mvqs696i2wkfAZ8FiY1oE6IsqwZTg
         rDDo8QOuVgR5P3FTZ/ycP8KBrl1y6DDNTHIkRFCSSvSQ4IY7RSxTspiQpueOYc1OmyL3
         BelMq/KMWSPmZK9H2iONAsc5fnSsTnJoPrRp03c+DNEvC6GrGFITKuDiT+ez4pCuNgJ4
         Dptl/PXqJ5AtM/edsf2y/j7j9+8N912YroN+xdgVOYVLVsHFdtNEnqsS3ADljlRT6ZN9
         /dHQ==
X-Gm-Message-State: APjAAAWBYIAti0Z4n3Q65Ntk1fWT6+ipB1SmhmdznRI//iAZnW8Zw2gW
        C7rXTqZXvHXfrkZpIyz5AH8C/KY=
X-Google-Smtp-Source: APXvYqwv1pyGJIJvVpZHsvTIkgIv3UTnCyfZzwG4/0izxEUUt9+1jB4S7uVfsr8njcXuCgZ5LohRDe4=
X-Received: by 2002:aca:c786:: with SMTP id x128mr12176416oif.146.1560184482381;
 Mon, 10 Jun 2019 09:34:42 -0700 (PDT)
Date:   Mon, 10 Jun 2019 09:34:20 -0700
In-Reply-To: <20190610163421.208126-1-sdf@google.com>
Message-Id: <20190610163421.208126-8-sdf@google.com>
Mime-Version: 1.0
References: <20190610163421.208126-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH bpf-next v4 7/8] bpf: add sockopt documentation
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

