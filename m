Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7097B650700
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 05:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiLSEQF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 18 Dec 2022 23:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiLSEQB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 18 Dec 2022 23:16:01 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1420021A7
        for <bpf@vger.kernel.org>; Sun, 18 Dec 2022 20:16:00 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 79so5346776pgf.11
        for <bpf@vger.kernel.org>; Sun, 18 Dec 2022 20:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ac34a4260OiGhUdPdxmE/Jcjul2AuDI7xA9NMT5T/gM=;
        b=hEClS99ptdO9g0yJYJQWfjP66dzeQ3slgmhYQ2idzeGVzmMho8CpyMVRTxqZR7hKbP
         Jlob+XDJnN/BHMe9F5kS9EJ2OSnya2mwra8e0D2ug1tK57oi91iiY6JtWj51KO8CBjRT
         b5GpK6UrwrZeIE7EIJz/EtUcJyCHAxxyl6KFPMPXIbux4mwEgwyDtvwfGgYrCYQ40HfM
         tfrV1tw1/EPVW3PUXlz4YUkMThhstaYf57UEDzYfrQXL919CQVmcEImrTiphGyrMl6jO
         0LibS4b7vvpflwfSTc8d33JGW/REN8OZSdCiwoMvj2HBaSHcNl2WAkN2Hkl0oK8yDIYg
         t36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ac34a4260OiGhUdPdxmE/Jcjul2AuDI7xA9NMT5T/gM=;
        b=CvKBQGIvX7pBrN3r87NqjKiGGo7xxk04o/abi4v11cXAou6StoSbhZFntqrXIb20wo
         A2d6EXvYuUDdYTMOgxLRH8tHfiyL/rDpeWF2IigAcVARTkwqavxyFIIkHlQr0+sKbU9h
         UWZmjD0P15w7tcnYn1/1EG3Cu40Hl2KtMRO4rbcGIRV73v74Reo6P8ZHJxs41fN2IX02
         0pDFV7aPvLApVHZcHc2Xh9hpS+FP5g+eFVTnfvbZcavPUKlQ2FUbB6uvy0bE/u7t2BTi
         AYhl+dIwha/mPOsjZi57pbDcAKTe0KYSKFYvrXR/2B3K/pZITs9SHK1b30WbeoL5DXJd
         I0qA==
X-Gm-Message-State: ANoB5pm6LyFkqkhlp1zdobk1YiDsMSKAQSDClPrQ6Gy7B2ehKgLlMyfz
        dClUctSomkpgZG5n/CckT7igSBah5LyxdkKIxTo=
X-Google-Smtp-Source: AA0mqf57nxF23fJZEAKk1eTnDqOa0cO00+2uhY1QcgK9cv+aXOSH/pHFrnwykB6VZ7gKbN3/U3zfNw==
X-Received: by 2002:aa7:870a:0:b0:574:f201:660a with SMTP id b10-20020aa7870a000000b00574f201660amr35702568pfo.33.1671423359272;
        Sun, 18 Dec 2022 20:15:59 -0800 (PST)
Received: from localhost.localdomain ([1.202.165.115])
        by smtp.gmail.com with ESMTPSA id x28-20020aa78f1c000000b00575caf8478dsm5363055pfr.41.2022.12.18.20.15.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Dec 2022 20:15:58 -0800 (PST)
From:   xiangxia.m.yue@gmail.com
To:     bpf@vger.kernel.org
Cc:     Tonghao Zhang <xiangxia.m.yue@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hou Tao <houtao1@huawei.com>
Subject: [bpf-next v3 1/2] bpf: hash map, avoid deadlock with suitable hash mask
Date:   Mon, 19 Dec 2022 12:15:50 +0800
Message-Id: <20221219041551.69344-1-xiangxia.m.yue@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Tonghao Zhang <xiangxia.m.yue@gmail.com>

The deadlock still may occur while accessed in NMI and non-NMI
context. Because in NMI, we still may access the same bucket but with
different map_locked index.

For example, on the same CPU, .max_entries = 2, we update the hash map,
with key = 4, while running bpf prog in NMI nmi_handle(), to update
hash map with key = 20, so it will have the same bucket index but have
different map_locked index.

To fix this issue, using min mask to hash again.

Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Hou Tao <houtao1@huawei.com>
Acked-by: Yonghong Song <yhs@fb.com>
Acked-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/hashtab.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 5aa2b5525f79..974f104f47a0 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -152,7 +152,7 @@ static inline int htab_lock_bucket(const struct bpf_htab *htab,
 {
 	unsigned long flags;
 
-	hash = hash & HASHTAB_MAP_LOCK_MASK;
+	hash = hash & min_t(u32, HASHTAB_MAP_LOCK_MASK, htab->n_buckets -1);
 
 	preempt_disable();
 	if (unlikely(__this_cpu_inc_return(*(htab->map_locked[hash])) != 1)) {
@@ -171,7 +171,7 @@ static inline void htab_unlock_bucket(const struct bpf_htab *htab,
 				      struct bucket *b, u32 hash,
 				      unsigned long flags)
 {
-	hash = hash & HASHTAB_MAP_LOCK_MASK;
+	hash = hash & min_t(u32, HASHTAB_MAP_LOCK_MASK, htab->n_buckets -1);
 	raw_spin_unlock_irqrestore(&b->raw_lock, flags);
 	__this_cpu_dec(*(htab->map_locked[hash]));
 	preempt_enable();
-- 
2.27.0

