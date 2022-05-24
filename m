Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8199C532475
	for <lists+bpf@lfdr.de>; Tue, 24 May 2022 09:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbiEXHxW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 May 2022 03:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbiEXHxU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 May 2022 03:53:20 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC9E5DBF1
        for <bpf@vger.kernel.org>; Tue, 24 May 2022 00:53:18 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id h13so9498635pfq.5
        for <bpf@vger.kernel.org>; Tue, 24 May 2022 00:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eiZIvmjlq4QeFIkkCBIsaFu9qrW8HKQ32EBz63sX0gk=;
        b=hGrF7CkKfpFYe6aHe2iDQSDrl/tVNbvFRkSCMm/hzl5jDM0K/88xLhm5dxzms0zbyB
         hgp9gNpbzepFG0tj7oonecWGfLd1lyl35IVjXZrQ8etTn5jesVau0qEf73mqVofh9bKK
         8MWW1zyOkQPDWU4jAXp2BBVtjczZNwfPiOX66SD1TMOvNLQDB7etlDiD0Jcecvfn9mzJ
         er9jJITjI7fdXxgrlWDzX+DhLp+VsKveGt4sY5xui+4q7U668xZSS8rrMlfjpHSx6y2d
         5cjcYaSC7P9dDWgi1jZ62Sp/yYrmeqy4mNq79lyzx8sbS9PoBaw4JWi+4lNy3Vcewclp
         mQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eiZIvmjlq4QeFIkkCBIsaFu9qrW8HKQ32EBz63sX0gk=;
        b=urlp9ALnsUD5BwMlogM4mzO/Rg0uwbYEmspQaC5/PG4V9rCWLlpt6tMJ5d2cK/BIsr
         /QHwVgFbjJaLwMaJ+S3Wd0megiuem5dAjLkzYOx1smh8iF1d1rkP+F9yPWZh0rN0SyXX
         H+TU421INrGieUEpmmu5KgNJG1CPXk2cT+lm5OyVxnAZ4Y6RGa54fuXO2HX5IXMqI4SO
         ew715X9PS206HEI35avwXN2rcoE/aNNkyjYg41+ztB5qbqXcne3IaFtAtF6J2p77l2cA
         +43rD1hUe/fB7kz+AZFLZ6m4k3s4OonV7QknPPgRio+4bmJxZu8PMQXL7f+YReSY4uZ0
         O9Gw==
X-Gm-Message-State: AOAM533Tap0j8Nkb5n4Buco6jCYP0nza2s/e9kBQgWxdFeAlxGrwyYFO
        b4qJETQMizMTuSFtyC3+OPo3XA==
X-Google-Smtp-Source: ABdhPJzUtKUdexd9Tp2iM4xdRy5IxMyuXpPxIVsYKH8m90zuTKxWmR7x3JukHf2NaL1XCKyqWxJhuA==
X-Received: by 2002:a05:6a00:be1:b0:518:86d3:4f93 with SMTP id x33-20020a056a000be100b0051886d34f93mr14573872pfu.35.1653378798151;
        Tue, 24 May 2022 00:53:18 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id m3-20020a62a203000000b00518327b7d23sm8682136pff.46.2022.05.24.00.53.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 May 2022 00:53:17 -0700 (PDT)
From:   Feng zhou <zhoufeng.zf@bytedance.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com, wangdongdong.6@bytedance.com,
        cong.wang@bytedance.com, zhouchengming@bytedance.com,
        zhoufeng.zf@bytedance.com
Subject: [PATCH v2 0/2] Optimize performance of update hash-map when free is zero
Date:   Tue, 24 May 2022 15:53:04 +0800
Message-Id: <20220524075306.32306-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

0001: Add is_empty to check whether the free list is empty or not before taking
the lock.
0002: Add benchmark to reproduce this worst case.

Changelog:
v1->v2: Addressed comments from Alexei Starovoitov.
- add a benchmark to reproduce the issue.
- Adjust the code format that avoid adding indent.
some details in here:
https://lore.kernel.org/all/877ac441-045b-1844-6938-fcaee5eee7f2@bytedance.com/T/

Feng Zhou (2):
  bpf: avoid grabbing spin_locks of all cpus when no free elems
  selftest/bpf/benchs: Add bpf_map benchmark

 kernel/bpf/percpu_freelist.c                  | 28 ++++++-
 kernel/bpf/percpu_freelist.h                  |  1 +
 tools/testing/selftests/bpf/Makefile          |  4 +-
 tools/testing/selftests/bpf/bench.c           |  2 +
 .../selftests/bpf/benchs/bench_bpf_map.c      | 78 +++++++++++++++++++
 .../selftests/bpf/benchs/run_bench_bpf_map.sh | 10 +++
 .../selftests/bpf/progs/bpf_map_bench.c       | 27 +++++++
 7 files changed, 146 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_map.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_bpf_map.sh
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_map_bench.c

-- 
2.20.1

