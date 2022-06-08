Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5305422C4
	for <lists+bpf@lfdr.de>; Wed,  8 Jun 2022 08:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbiFHFIk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jun 2022 01:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbiFHFIc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jun 2022 01:08:32 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B643BCC46
        for <bpf@vger.kernel.org>; Tue,  7 Jun 2022 19:11:01 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id u18so16403915plb.3
        for <bpf@vger.kernel.org>; Tue, 07 Jun 2022 19:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J1xTU6kj0/mXxD+Ml9TPjDN30P//McYOe7F06FaSLhc=;
        b=BDN2paihn1LCyhLcp4pP9rIPTRr4vLDEEADf8vnc8LBhTkSHVMtYpbHSDk0LmEpJ3P
         0QsQ4xcEAQ6mR7KHehHmVsf/fWbrWOLJqMA3C7wB6W0RRpM5JnLPlHPzW42eEYGlPD/g
         b7ixAiiAizc05j6l9TC8iNb+FhfSxSIB5GedeD9cRRDbw1VBHgLVM1zA3K+OvirQHDY9
         FocZ73WmXw3ISGxpOAwzf7naIyjAfY8oIYw2cwaOCfx8pg4yLYQkpkc6ZXboWo67BlHe
         uizjLucbvk/HRFRcL/5fzFkl1+jMmyDycdLqETntdULGwTRhc+EKVReGZB8AI/d1KALW
         KIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J1xTU6kj0/mXxD+Ml9TPjDN30P//McYOe7F06FaSLhc=;
        b=xptWFCX/CefDUu3U34H7WycaZd8RWuQyHq1KZ+civPFoxqEdcPIlUHNsxkFXvi2/8v
         UqgAy8smi9YpEP9wOQ4qpeyxyqg4UcXLy2BcXkW6c5ngwYnfXGyS1ym7CecguxeK2F13
         KEsUDmvmRuQNF5IhGh4QdLqieS1fGIPagmMkws5SMg7Q451kZ4+thhaKuAB6ctVxKlqk
         CDgzxzcdc5TtTPBsBSUfUtwJFJn2Mi9/od8gS6zBLXM0EZ7A5WVh8vjJum6183FQyo/9
         S2A2vbKGpNlf6zBrEhjFwD//4H90SwoBZ8Zxkyoz8LbK9PB9hdAZ6IUDhvnBqOCRFjWg
         ilTQ==
X-Gm-Message-State: AOAM533lOXxZLRtaR9ehTZ3jmvONJeIfCVowNpGtP+5XaHj8KMdVA8fP
        DimXqlnbi36kbToojFyk7r5xWQ==
X-Google-Smtp-Source: ABdhPJyOtBnUKFIXKz2YiKYmMkeKDNdYHJ5kDFk1kSUTeqre5MwAtUnqpD/YnlfoT75RoZ8erq6BzQ==
X-Received: by 2002:a17:902:ee54:b0:163:bdf4:1112 with SMTP id 20-20020a170902ee5400b00163bdf41112mr31483056plo.89.1654654260881;
        Tue, 07 Jun 2022 19:11:00 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902680700b001651562eb16sm13166636plk.124.2022.06.07.19.10.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jun 2022 19:11:00 -0700 (PDT)
From:   Feng zhou <zhoufeng.zf@bytedance.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com, wangdongdong.6@bytedance.com,
        cong.wang@bytedance.com, zhouchengming@bytedance.com,
        zhoufeng.zf@bytedance.com
Subject: [PATCH v5 0/2] Optimize performance of update hash-map when free is zero
Date:   Wed,  8 Jun 2022 10:10:48 +0800
Message-Id: <20220608021050.47279-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Feng Zhou <zhoufeng.zf@bytedance.com>

We encountered bad case on big system with 96 CPUs that
alloc_htab_elem() would last for 1ms. The reason is that after the
prealloc hashtab has no free elems, when trying to update, it will still
grab spin_locks of all cpus. If there are multiple update users, the
competition is very serious.

0001: Use head->first to check whether the free list is empty or not before taking
the lock.
0002: Add benchmark to reproduce this worst case.

Changelog:
v4->v5: Addressed comments from Alexei Starovoitov.
- Use head->first.
- Use cpu+max_entries.
some details in here:
https://lore.kernel.org/bpf/20220601084149.13097-1-zhoufeng.zf@bytedance.com/

v3->v4: Addressed comments from Daniel Borkmann.
- Use READ_ONCE/WRITE_ONCE.
some details in here:
https://lore.kernel.org/all/20220530091340.53443-1-zhoufeng.zf@bytedance.com/

v2->v3: Addressed comments from Alexei Starovoitov, Andrii Nakryiko.
- Adjust the way the benchmark is tested.
- Adjust the code format.
some details in here:
https://lore.kernel.org/all/20220524075306.32306-1-zhoufeng.zf@bytedance.com/T/

v1->v2: Addressed comments from Alexei Starovoitov.
- add a benchmark to reproduce the issue.
- Adjust the code format that avoid adding indent.
some details in here:
https://lore.kernel.org/all/877ac441-045b-1844-6938-fcaee5eee7f2@bytedance.com/T/

Feng Zhou (2):
  bpf: avoid grabbing spin_locks of all cpus when no free elems
  selftest/bpf/benchs: Add bpf_map benchmark

 kernel/bpf/percpu_freelist.c                  | 20 ++--
 tools/testing/selftests/bpf/Makefile          |  4 +-
 tools/testing/selftests/bpf/bench.c           |  2 +
 .../benchs/bench_bpf_hashmap_full_update.c    | 96 +++++++++++++++++++
 .../run_bench_bpf_hashmap_full_update.sh      | 11 +++
 .../bpf/progs/bpf_hashmap_full_update_bench.c | 40 ++++++++
 6 files changed, 166 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_full_update.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_bpf_hashmap_full_update.sh
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_hashmap_full_update_bench.c

-- 
2.20.1

