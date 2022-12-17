Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5383264F98F
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 16:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiLQPCW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Dec 2022 10:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiLQPCS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Dec 2022 10:02:18 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABD2E0D3
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 07:02:16 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id a14so3596701pfa.1
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 07:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ac34a4260OiGhUdPdxmE/Jcjul2AuDI7xA9NMT5T/gM=;
        b=fRZfDLwU5m1extAUTZYVjRN5Wg6tDFda1KGXRuXXKy0Oy+uav0+UCa4CZgjQ0QLatC
         0GnvnOC3hOdgnT7GND/TqjHlmUduM6mFYw9NDOUigLLuuJUZzYcjwEsdxcnVz6dKBC+S
         yjZjR7S2fUV0qwABvawSCeSmqs4VpISn3m+WbqDdDxZLZAYKeNkhCiDm3TmNVbtyFNE4
         vQOiEoQ51rVsEFiV/8cze/J2N601PxZSZzcAUbXjYvs6Ms33Mr9MBa7WySZX2/TOqWvK
         3AdZPh+KzZ5j5lAvteF6PsVVMo35ay7xPeduscv5iecA/GcDIv5jz2nGgyCbJrQAJHUV
         kCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ac34a4260OiGhUdPdxmE/Jcjul2AuDI7xA9NMT5T/gM=;
        b=7raica8ntcyh33ZhSChaiTpNV6Ej3V3OrdwEIzoBZFIfqe7mSjOH6B6S8cCdw4Qdi0
         8q8rvanacht3SA6HZTQVtpW04b1ZgzdNrn6X2PxDESrl5oZyM9cP+3hBEfZunWFxBnx4
         zFibv37zCmTKo1lRIgkxiguZxT8avQwU1cvFUUT2XvXfmENrM8yP2XGMipcgybA7YKT/
         i8VDUX5fu2aMPa6Vd0Nre7+nhYi68XBT7hcIG1z83lDuEDjbmZIuRZw34VN6Q4VaO7uL
         c2FT3MDECKGvwsriTADaE6oufX2JG6Q2rjAn+NXdRI0mD0Nes2pq/9LV0Wacoe74wTTs
         UkyA==
X-Gm-Message-State: ANoB5plTIFUu+5cQFur2bh0pSSnsDoCEzHn29G8Ih8vBDs9txBC8/f3r
        V4SA+O98uprxSskjrM3NCU//MaankJZ+uw==
X-Google-Smtp-Source: AA0mqf5OjFZgW8PFyPqqNsaW3ehvPlSdTpgv/QNUtmtEPlQ0fbcC1Z4o9KEB7aVB5hwO9Zd1H39vdg==
X-Received: by 2002:aa7:91c5:0:b0:566:900d:a1cd with SMTP id z5-20020aa791c5000000b00566900da1cdmr33181903pfa.9.1671289335803;
        Sat, 17 Dec 2022 07:02:15 -0800 (PST)
Received: from bogon.xiaojukeji.com ([111.201.145.40])
        by smtp.gmail.com with ESMTPSA id s17-20020aa78bd1000000b00576ebde78ffsm3250880pfd.192.2022.12.17.07.02.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Dec 2022 07:02:14 -0800 (PST)
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
Subject: [bpf-next v2 1/2] bpf: hash map, avoid deadlock with suitable hash mask
Date:   Sat, 17 Dec 2022 23:02:06 +0800
Message-Id: <20221217150207.58577-1-xiangxia.m.yue@gmail.com>
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

