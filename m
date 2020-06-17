Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3569F1FC328
	for <lists+bpf@lfdr.de>; Wed, 17 Jun 2020 03:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgFQBE1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Jun 2020 21:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbgFQBEX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Jun 2020 21:04:23 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07AFC0613EE
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2020 18:04:22 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id j16so584966qka.11
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2020 18:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2CrLirlaHAmpJk5kLUn85BP1eGSiGI6fSEUxktNV0QA=;
        b=ZVhBtc1w6d4rwoHbUdHbgpZ8HX+pGtyWu4h6+apBtM0FLFC8vviz+NpS3PgZm+v3If
         /NZJxDHy8DNIfJQnKbL6lIjVUFGxAI9LkCyj+2TuyXvzBO+gS6r4IX9fUzRWECdMUQqJ
         AkejeV0e0036IjqKExSfZprBvKMU/4nwEwzQH8L7FelmJFMUNVDrrl0aJluZTaeifv6F
         2SBn+GqFJ80v+e6vSA1rzE2P79TKo5QJgtBabdWI8kg6SeSZ6RMjXpeSjEMy+PIbgGyT
         Ko6o9LygqpTG0OH1pmOplaLc0tqDdaARTlHySh3GF4yEWU0HDWutzNYbVXRsohB9zKei
         GFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2CrLirlaHAmpJk5kLUn85BP1eGSiGI6fSEUxktNV0QA=;
        b=eAC/Q6duKG0D2T5h6PEIq3Z3gXMjf+jgVgel4tSdbxBqwN6ua/DUL9PAtT+jZhbMww
         ZMLTT+cDPLIptNZwKp0xnSe3zxB+rw0s3DB80/I/yS0CEvImOdrCTuPTlKOnfgrIqKzG
         uL3fRWAZ2n+RVauldloE2o6qc8GZ3s4o9VcfRlkmpYUMVLbW6jAAzPLt9S2diDbVeJj7
         qyR+8WVknD8FdT7SneArH3Cnu4oOawN8jmthCE+Xb+MiPDOLVLqBFt7ko8pAQTPN/XNN
         BnKt3g3Y7fnkEeJzBAtBp65iV+XVnpRHzVPnOQ4ieLPzPHWMcjmtaExQfe14iitcKgja
         kgHA==
X-Gm-Message-State: AOAM531eQ5QC3dFrD/meGzeFryDgXJFGoSUMnqB7EFISFWllXH3ZRSU5
        tHE1eR54yoL05Tn058nR8l5QUig=
X-Google-Smtp-Source: ABdhPJwIdK30fqgjFPehn3672rL1ww9JBMgZJdErUkcgVnk9eCXsg4LZ2AZ4olVtymRGg1FM0Hw4LcA=
X-Received: by 2002:ad4:556e:: with SMTP id w14mr5112805qvy.137.1592355862157;
 Tue, 16 Jun 2020 18:04:22 -0700 (PDT)
Date:   Tue, 16 Jun 2020 18:04:16 -0700
In-Reply-To: <20200617010416.93086-1-sdf@google.com>
Message-Id: <20200617010416.93086-3-sdf@google.com>
Mime-Version: 1.0
References: <20200617010416.93086-1-sdf@google.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH bpf v5 3/3] bpf: document optval > PAGE_SIZE behavior for
 sockopt hooks
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Extend existing doc with more details about requiring ctx->optlen = 0
for handling optval > PAGE_SIZE.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 Documentation/bpf/prog_cgroup_sockopt.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/bpf/prog_cgroup_sockopt.rst b/Documentation/bpf/prog_cgroup_sockopt.rst
index c47d974629ae..172f957204bf 100644
--- a/Documentation/bpf/prog_cgroup_sockopt.rst
+++ b/Documentation/bpf/prog_cgroup_sockopt.rst
@@ -86,6 +86,20 @@ then the next program in the chain (A) will see those changes,
 *not* the original input ``setsockopt`` arguments. The potentially
 modified values will be then passed down to the kernel.
 
+Large optval
+============
+When the ``optval`` is greater than the ``PAGE_SIZE``, the BPF program
+can access only the first ``PAGE_SIZE`` of that data. So it has to options:
+
+* Set ``optlen`` to zero, which indicates that the kernel should
+  use the original buffer from the userspace. Any modifications
+  done by the BPF program to the ``optval`` are ignored.
+* Set ``optlen`` to the value less than ``PAGE_SIZE``, which
+  indicates that the kernel should use BPF's trimmed ``optval``.
+
+When the BPF program returns with the ``optlen`` greater than
+``PAGE_SIZE``, the userspace will receive ``EFAULT`` errno.
+
 Example
 =======
 
-- 
2.27.0.290.gba653c62da-goog

