Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BF464C744
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 11:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237870AbiLNKjI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 05:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiLNKjG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 05:39:06 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D4D23167
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 02:39:05 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 142so1701447pga.1
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 02:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VZm9GhQRwrMyYINPX/F65U/umc4ZnamMlTLDNv2w3qg=;
        b=JiqB7A5XNlWO5fEiRohQSc6WbJYHJZ6bkL5wZ8XWq6wrjh0oerY0zyZzdRX3KPN5ov
         spIw2KtAvIqz1K9HqcQp6FeuVNv27pnjjXPYvlRyTFky41n64K0iGU81Y9xZyO6JYAoI
         t02UeNdCOs3zguw8htVsOKfL90yl1EhqbiJzq7Yqsi3rK5n7LJ4zxPn4AI/HQTTL6z/3
         BzZxz64e6T3IgC/JtdpzUO12EOrO/6BkRmHkH6NZD3kjin/bClPxvodnlVbK1+KX7LqB
         XdjbkmH78KrMjC/7LqRdMbyGoqY2IY/26Dy91mA1jlEviEJaNnC/QioHISwVi784gfUu
         yryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZm9GhQRwrMyYINPX/F65U/umc4ZnamMlTLDNv2w3qg=;
        b=xsa2saiVRIPkKpcxIdes6e/tfRVbEnN5ba8HVppxdM+5DmwMaj3x8vpOd46VVChtK8
         T4lLYBPLL43cc0tYpYvt46JOVeMbP3dyXU9HjbaZ0cXCILcukpoptVC/HgqpP1fFy4pA
         Uxk0YtqfjwLTTAmgaJtWyXl3whjcWwTA20b/YUSnUgo+VwGmVj6wBsVOKUS6QNwgHkxI
         WjhgwMfqC0qNFUA6S1naGVLmgsltUtrU5taT8LKx//pZyLT2w6SNyTmZdCg723QCfXIk
         tHZSNpqyjBIRFDGnnJodGPPHAr2Ec2+CF04WjVWYjVK893kmVELGaIAHZ+WfTEsjO29h
         55bQ==
X-Gm-Message-State: ANoB5pkagp74gOAsjs52Hnsiz/M3kBVaAYQpOOhvxVz7aohEl5EHNipG
        XwYfwTSpx+3KzZ4Ily87pUeyvc5kEH/cJRwf
X-Google-Smtp-Source: AA0mqf5iFqs/6uMtcl5iUKMFy4oYMzmHEZQBb6RShHr7nHm7x9EKh5mw6ytTdI30R48V7FrL0NRq+g==
X-Received: by 2002:aa7:8b42:0:b0:56b:abd4:83b1 with SMTP id i2-20020aa78b42000000b0056babd483b1mr23459588pfd.2.1671014344440;
        Wed, 14 Dec 2022 02:39:04 -0800 (PST)
Received: from localhost.localdomain ([111.201.145.40])
        by smtp.gmail.com with ESMTPSA id o76-20020a62cd4f000000b005751f455e0esm9177272pfg.120.2022.12.14.02.39.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Dec 2022 02:39:03 -0800 (PST)
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
Subject: [bpf-next 1/2] bpf: hash map, avoid deadlock with suitable hash mask
Date:   Wed, 14 Dec 2022 18:38:56 +0800
Message-Id: <20221214103857.69082-1-xiangxia.m.yue@gmail.com>
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
---
 kernel/bpf/hashtab.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 5aa2b5525f79..8b25036a8690 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -152,7 +152,7 @@ static inline int htab_lock_bucket(const struct bpf_htab *htab,
 {
 	unsigned long flags;
 
-	hash = hash & HASHTAB_MAP_LOCK_MASK;
+	hash = hash & min(HASHTAB_MAP_LOCK_MASK, htab->n_buckets -1);
 
 	preempt_disable();
 	if (unlikely(__this_cpu_inc_return(*(htab->map_locked[hash])) != 1)) {
@@ -171,7 +171,7 @@ static inline void htab_unlock_bucket(const struct bpf_htab *htab,
 				      struct bucket *b, u32 hash,
 				      unsigned long flags)
 {
-	hash = hash & HASHTAB_MAP_LOCK_MASK;
+	hash = hash & min(HASHTAB_MAP_LOCK_MASK, htab->n_buckets -1);
 	raw_spin_unlock_irqrestore(&b->raw_lock, flags);
 	__this_cpu_dec(*(htab->map_locked[hash]));
 	preempt_enable();
-- 
2.27.0

