Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E66047F2A6
	for <lists+bpf@lfdr.de>; Sat, 25 Dec 2021 09:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhLYIcw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Dec 2021 03:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhLYIcw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Dec 2021 03:32:52 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71512C061757
        for <bpf@vger.kernel.org>; Sat, 25 Dec 2021 00:32:51 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id k4so9320885pgb.8
        for <bpf@vger.kernel.org>; Sat, 25 Dec 2021 00:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lWMCAQ/ELS6pWLfQV3hyvc38bw087MkSRm6yfp27vxQ=;
        b=o+ZqbPnZR8aM1dgDhKDQtHYcqhPFqFV38ZLN06FNblSIaHBdJwKwLBEL7BPG9ro413
         p0hcGnTIkzT4+JefXQxTNtvmb5U3x2EgjO30AcBHP8oS+zULjKFYrMkLqFeuGgaeX7ob
         t5Ku3Z14+9eEgZMJThem3gzPxWiTBxeo9qix695VCQE4BfWXd5gm6VY3JNh9pPDL/0rB
         T5wabALShMl20+Z0/MDaU9tZ39Zmso2gzrnei5kvpHcUZkKq9BG3GnRK6mGVqWoz7bf5
         2GotynHjfYVA7+eat8V480AsSeIqSRk5wtKGfI3W1AZK14ZVkN+1oVV1Olz0sxbTquAf
         nHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lWMCAQ/ELS6pWLfQV3hyvc38bw087MkSRm6yfp27vxQ=;
        b=hgqYsm31I5Jo7lZL00jU9qTbDb5YH1GXyarK9jMERUBf/HsVVlNsVPp/8CaejnZgIx
         WzkVLwDQRHyntflHgC5Ua1o92NoAN9k6kr3RWDFwg5yRQnXGm8NM9tnxV7PP7IQbrJgz
         S+8gdbM4Cl2fGD3BcmCjzzbK4NwnhlmoNCHm8J7yvcgkU8ZQdkTLD5rIs1BAKKXY3VlW
         sABBu1jRRYYg6C//FrKPUPoeKnRf4Xa3Fm3974eZ79NhXBb8UNwD68vUeZvNrIj6pbYV
         dK04Qm4Kef+10K7BovlcDv+cClH8fVe9mX18NGdx6TjMEJI7xxcY9b1mxh9rg82z7LB9
         PMvw==
X-Gm-Message-State: AOAM5324oLt9gmfntuRumE9dHoVvOx7fbqxnNpt+az///NEpCO4ao8G7
        kONypjDgyyQHe72ZDkXVeLcgiQ==
X-Google-Smtp-Source: ABdhPJx1BGLZJiZFW6RLAggN+qGKrN9KnEub1Uj1fcKLlJaRhZ/LdUbxiM0aXW4HQ9+90As6menNTA==
X-Received: by 2002:a05:6a00:2151:b0:4a2:5c9a:f0a9 with SMTP id o17-20020a056a00215100b004a25c9af0a9mr10074807pfk.39.1640421170937;
        Sat, 25 Dec 2021 00:32:50 -0800 (PST)
Received: from localhost.localdomain ([122.14.229.79])
        by smtp.googlemail.com with ESMTPSA id cx5sm10181713pjb.22.2021.12.25.00.32.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Dec 2021 00:32:50 -0800 (PST)
From:   Qiang Wang <wangqiang.wq.frank@bytedance.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com,
        songmuchun@bytedance.com, duanxiongchun@bytedance.com,
        shekairui@bytedance.com
Subject: [PATCH 1/2] libbpf: Use probe_name for legacy kprobe
Date:   Sat, 25 Dec 2021 16:32:41 +0800
Message-Id: <20211225083242.38498-1-wangqiang.wq.frank@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix a bug in commit 46ed5fc33db9, which wrongly used the
func_name instead of probe_name to register legacy kprobe.

Fixes: 46ed5fc33db9 ("libbpf: Refactor and simplify legacy kprobe code")
Co-developed-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Qiang Wang <wangqiang.wq.frank@bytedance.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7c74342bb668..b7d6c951fa09 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9735,7 +9735,7 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 		gen_kprobe_legacy_event_name(probe_name, sizeof(probe_name),
 					     func_name, offset);
 
-		legacy_probe = strdup(func_name);
+		legacy_probe = strdup(probe_name);
 		if (!legacy_probe)
 			return libbpf_err_ptr(-ENOMEM);
 
-- 
2.20.1

