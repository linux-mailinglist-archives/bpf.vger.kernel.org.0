Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86D93EDB38
	for <lists+bpf@lfdr.de>; Mon, 16 Aug 2021 18:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhHPQtI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Aug 2021 12:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbhHPQtG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Aug 2021 12:49:06 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BF8C061764
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 09:48:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x5-20020a0569020505b0290592c25b8c59so17202365ybs.18
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 09:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2pXBI3DPkrMxBJGQ9ZomO9Sr2huQpV8lZhoQffbmZEI=;
        b=S0gCrI3LwcM/0wtammOB+CuVrR5xvW6a7GtQ56biFkYoI8RtTvdlFUr+XXCkW/ih9j
         Jdc1saP408Ci8EIc2Pz0ccaUed8zpAB+7zyt/dLv/6Ts9SC4rLJx8YZsiUWV9F7YVmXV
         26gKEGjZGvFEsZgPoO8p80s2w16Py9SVIE06btNaYA8IhGaTXM/YK1BaqaHgVd9NXeBy
         5NnDx4ufsOOhz/U8IOkUWivfe/e0x0heXQImKpuInh7tXAP1u4jU1Fja2EylX3pPyoyo
         bSmNJ/EhdjDZIZrwLeUTJs+B1ruxARKVd84SaCqtQIeZj0vz6Kr2TE2HCY+5hyy/BqlO
         rAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2pXBI3DPkrMxBJGQ9ZomO9Sr2huQpV8lZhoQffbmZEI=;
        b=e33Ll3uglk9WwHy1m2IVTW+afPPHxjATJlsbXqoJH5nUSjoELM61NRcXqpX7mHGi+i
         WALUaO/PCkJcz9E5QJOs3nvTZ0/abbuh+PXVw07Gn7jKLUrPrvNO2KcnntMPPI+2VBcA
         3zHEgfcRZFmCxhTlvXrUuzN/Eyjbs6KivxPOj2ebtHiB3VxputFQZ/+ywtbspIhyLYmp
         HVZOXTMH7K3NzGEkciBkI10a0yc2iE9cL4SvPex/EWwgVu5fmnENBCGt5nFu2q17xp0b
         g2Qgc5MMLo9rKf+XW5pALXzN26tIpP1CCMP3eB9Y7oz72UlPAV9CSLTy3NmPCmjG9k9i
         GplA==
X-Gm-Message-State: AOAM530GamLmhcYCfnn46SzTnrycFaIpSxx/fgxOcCSGu5tkmYxxnxyA
        ZejqsufPrtDvfcMXf6CsCsrL/ho=
X-Google-Smtp-Source: ABdhPJwzqKItWq9/8Q1d9Xf7fXBvnolae4sKR05FiKXxnc6DwHldrh7iCVHr+KRGmpDQqo/EUQPLO6k=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:afa2:caa8:d56a:b355])
 (user=sdf job=sendgmr) by 2002:a25:b7d0:: with SMTP id u16mr15293668ybj.342.1629132514566;
 Mon, 16 Aug 2021 09:48:34 -0700 (PDT)
Date:   Mon, 16 Aug 2021 09:48:32 -0700
Message-Id: <20210816164832.1743675-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH bpf-next] bpf: use kvmalloc in map_lookup_elem
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use kvmalloc/kvfree for temporary value when looking up a map.
kmalloc might not be sufficient for percpu maps where the value is big.

Can be reproduced with netcnt test on qemu with "-smp 255".

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 9a2068e39d23..ae0b1c1c8ece 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1076,7 +1076,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 	value_size = bpf_map_value_size(map);
 
 	err = -ENOMEM;
-	value = kmalloc(value_size, GFP_USER | __GFP_NOWARN);
+	value = kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
 	if (!value)
 		goto free_key;
 
@@ -1091,7 +1091,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 	err = 0;
 
 free_value:
-	kfree(value);
+	kvfree(value);
 free_key:
 	kfree(key);
 err_put:
-- 
2.33.0.rc1.237.g0d66db33f3-goog

