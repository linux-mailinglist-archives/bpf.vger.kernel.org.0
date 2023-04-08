Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BD46DB91E
	for <lists+bpf@lfdr.de>; Sat,  8 Apr 2023 07:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjDHFwO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 8 Apr 2023 01:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjDHFwN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 8 Apr 2023 01:52:13 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49D17ED0
        for <bpf@vger.kernel.org>; Fri,  7 Apr 2023 22:52:12 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54c01480e3cso84811517b3.1
        for <bpf@vger.kernel.org>; Fri, 07 Apr 2023 22:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680933132;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PaCuvDcWhP2cDa4Q6QNDOLtZbZ3fUX/ydwsiXo8AOEQ=;
        b=ghgDlhmdSf6EDth7OpctKVg9Yoh/tWaSiBhrYQowh9CR2mGkgYU4wXv/JxQMz+2UAs
         k2Iy4NThdkqwxSfTl7Md3HV/bPw3onn85xQI6OYPoJ3+pdLl3HOB95QIoZSGKnBPoLR1
         7ASdrjtPr77+nOaXcInGpEoKonO52742HQoL3ExF9xHpa6N7HqK0ZaLIG8QqF3e71Eu9
         QCPJXi5gmrXPhlQOrR9hxlzXeorK1/ZsLGpSTH/TpVgj1FPaBKrXlCGcqXlMAiSITqiI
         0M/d+q3EOhjhyuiUurzSzlLz11xfyl8yly8AvBRomw0oi1dkalAd9Xvo7+tOn7uS/yBB
         zvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680933132;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PaCuvDcWhP2cDa4Q6QNDOLtZbZ3fUX/ydwsiXo8AOEQ=;
        b=pZHIUOmPv5AE7tfKeLmxOrQdyj38VoMLPJQ8sPbLi5LwlrMtuIxCe9ixLoYnBcVNcM
         j80Jp8uXSWxVnYp/Qfm3ehaWLjiUlwTPbCowwDNpTgNE43nW3UK9temAS33F7hErNUXK
         fLwB5oGttC4cWrbhZN/ukubzEjgDVHO/8cVaB4ye8vZ3rLOz7BPKoQF1fhzMyMLIf/+K
         4Ick5R0iR442pqFEiGhsU4bCh8wmZN5u0LsmCO0nezJzk8o0edIgXc2uvPRdLEVfV1PI
         OUuqBSJYh0HVlg+hV4fHcmQ1ISs9UB4g1ar7EhgcEhV73TN+q2mXZKEhVk2CIJkps+/7
         trlw==
X-Gm-Message-State: AAQBX9efQwPLtM52SqIT85xPlcByHgKuOHoUByeIVuPSyr4eLq9JRY8x
        envHpbumqMkp9635AYROdvIrXfbdYrFM
X-Google-Smtp-Source: AKy350YOn6EDZcM6g2K/kJ64r7qb7nb1g6AqbF0ZKf3EWu7T9j29NGNrPc5tNzDCHvyOPDHJbuy1IbcWjKVf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b240:9cdf:7861:b23e])
 (user=irogers job=sendgmr) by 2002:a81:af5d:0:b0:52e:e095:d840 with SMTP id
 x29-20020a81af5d000000b0052ee095d840mr2334348ywj.0.1680933132008; Fri, 07 Apr
 2023 22:52:12 -0700 (PDT)
Date:   Fri,  7 Apr 2023 22:52:07 -0700
Message-Id: <20230408055208.1283832-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v1 1/2] perf lock contention: Support pre-5.14 kernels
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

struct rq's variable __lock was renamed from lock in 5.14.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_skel/lock_contention.bpf.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 23f6e63544ed..8911e2a077d8 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -418,6 +418,14 @@ int contention_end(u64 *ctx)
 
 extern struct rq runqueues __ksym;
 
+struct rq__old {
+	raw_spinlock_t lock;
+} __attribute__((preserve_access_index));
+
+struct rq__new {
+	raw_spinlock_t __lock;
+} __attribute__((preserve_access_index));
+
 SEC("raw_tp/bpf_test_finish")
 int BPF_PROG(collect_lock_syms)
 {
@@ -426,11 +434,16 @@ int BPF_PROG(collect_lock_syms)
 
 	for (int i = 0; i < MAX_CPUS; i++) {
 		struct rq *rq = bpf_per_cpu_ptr(&runqueues, i);
+		struct rq__new *rq_new = (void *)rq;
+		struct rq__old *rq_old = (void *)rq;
 
 		if (rq == NULL)
 			break;
 
-		lock_addr = (__u64)&rq->__lock;
+		if (bpf_core_field_exists(rq_new->__lock))
+			lock_addr = (__u64)&rq_new->__lock;
+		else
+			lock_addr = (__u64)&rq_old->lock;
 		lock_flag = LOCK_CLASS_RQLOCK;
 		bpf_map_update_elem(&lock_syms, &lock_addr, &lock_flag, BPF_ANY);
 	}
-- 
2.40.0.577.gac1e443424-goog

