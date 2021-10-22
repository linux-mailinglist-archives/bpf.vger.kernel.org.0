Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3266437F49
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 22:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbhJVUXA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Oct 2021 16:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbhJVUXA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Oct 2021 16:23:00 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535F9C061764
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 13:20:42 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id v10so3171665qvb.10
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 13:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QGZRv16f5XExnXn4iObzLJBi0s4BfYl5Srzvu+ICLoo=;
        b=fCbVxA6qMqMPU/mpynMau4DZgEYa9VLL72iGY8TDf3jlLGsX0QgGMzgizbHAvAS80X
         K2Q0fMdEls9fO04mf2NMyjQZhsCHX3ZX5N8xssSXM8kr10ER2vfs2N8K42L48JAcwlzf
         3oaEoR6q6+oQ7lcJTurLAg3BQuHzIV5EjYHXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QGZRv16f5XExnXn4iObzLJBi0s4BfYl5Srzvu+ICLoo=;
        b=6VgbwjRlhXjp7o7fMv6UEfDqWib77GrHrKrWkDXThZzhHqRCQaOPTMeNDGAM6LJxjY
         yJdEJlwaIKB3vIUuDNkRysX197xOq6hhcsj4/x7i8yqoJVHK8B7RGPIkdh0huKoTDG73
         p6etQjEph6wVcgXqBrX4JA0jOFo1PJaVyddRCojWEX8hhhKrZQDnZsvLiHTumivHeirQ
         O9qWB1Tp9B1rNkf6hRHalPEGYrczbylOQ2BZa7gPO61ngiAONLwpTuKX61mImZi1nqe6
         As3cWVbn1bBEMNcg/Cy4LGMW4XCZM/pkQs69Z523/+sV6WJGgnup4qfsT9r08kvuy0s4
         1YEg==
X-Gm-Message-State: AOAM532prMFKWnn6ZyT42bsNw+NO0WOMuac3/KodqNNVaMi7TVC2wp1i
        y8ySdD+u8Knrq/KgBxbiLYfzBQ==
X-Google-Smtp-Source: ABdhPJxckZm6FEOZm4by1lsAllqeLG5ShaFUIHBtFByj8nDYcG6CQ+RT1ON8D+HEHkGmNqT85dLzOw==
X-Received: by 2002:ad4:53a1:: with SMTP id j1mr1850525qvv.25.1634934039902;
        Fri, 22 Oct 2021 13:20:39 -0700 (PDT)
Received: from localhost.localdomain ([191.91.82.96])
        by smtp.gmail.com with ESMTPSA id u11sm2934594qko.119.2021.10.22.13.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 13:20:39 -0700 (PDT)
From:   =?UTF-8?q?Mauricio=20V=C3=A1squez?= <mauricio@kinvolk.io>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf-next] libbpf: fix memory leak in btf__dedup()
Date:   Fri, 22 Oct 2021 15:20:35 -0500
Message-Id: <20211022202035.48868-1-mauricio@kinvolk.io>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Free btf_dedup if btf_ensure_modifiable() returns error.

Fixes: 919d2b1dbb07 ("libbpf: Allow modification of BTF and add btf__add_str API")

Signed-off-by: Mauricio Vásquez <mauricio@kinvolk.io>
---
 tools/lib/bpf/btf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 3a01c4b7f36a..85705c10f7b2 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -2991,8 +2991,10 @@ int btf__dedup(struct btf *btf, struct btf_ext *btf_ext,
 		return libbpf_err(-EINVAL);
 	}
 
-	if (btf_ensure_modifiable(btf))
-		return libbpf_err(-ENOMEM);
+	if (btf_ensure_modifiable(btf)) {
+		err = -ENOMEM;
+		goto done;
+	}
 
 	err = btf_dedup_prep(d);
 	if (err) {
-- 
2.25.1

