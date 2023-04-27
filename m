Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D006F0F3C
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 01:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344447AbjD0Xs5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 19:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344235AbjD0Xsj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 19:48:39 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336E61FF5;
        Thu, 27 Apr 2023 16:48:39 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b7b54642cso6491808b3a.0;
        Thu, 27 Apr 2023 16:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682639318; x=1685231318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNOWzjzDN8/IL6kFuuC3MOAdiIjEwK+a4rVMlscXpEU=;
        b=Dy7KxEsSsT4BcpH9K6b7Bs+cMCFyYE7TTBHgYFYjQ+mDHmmEDEU9IOttf5pPaZ1bJ5
         z8m5jSGjO573huyo5zG7pA4Q14nWilvb35KzW6HFdRPALYZEnCqpt/YeXb61HwrsWVyR
         P2LgiH92QNwB5cLsxbzcJb7dQD8oTmqkoSVmjAb4aosfoQP7AvrsHOovgixa6Ui00hRj
         XhIcXf78a7NBr8mZW4u2pFW35l4UjEkXFuQ1pouT6JzfZmAE0x5QXhWgz38qhLmz2gQN
         7LpHDF/hjaBqtaPrnESEriRZzn6gawMAkamuNwHq+V3Xw2zc4xPCxJuRqQBqz8su1rbH
         u5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682639318; x=1685231318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZNOWzjzDN8/IL6kFuuC3MOAdiIjEwK+a4rVMlscXpEU=;
        b=GgE2b5KOuP2Csv05tVln/FZuO2uh7ayktKswz5m1mD+Ke+JY71/QES+RaJHsF+80JX
         yG72AbBfbL9JTB0ypbFxLbW9gUvV09jFSHGcmfd9azjYK3AuZO9jsrycP8uWA7k/PCnC
         lf0k3G5vl2kDZzHvObRNHpgvvOxNU6roLI+m+Hvqyzlc8ObyJEgT3E+pBiH2vMmupVhN
         dP69X8AWVQ96M4est5v0X8pV8xtDuCcAj5psbS/K7BhG60FzJiVkAQVPvzVEZBMd5nrK
         or94XVt2ptKAkyxeVeCa2dQ2Xan/CaUSM1m5Easph7FwVJp/n8xaHYaApbj+AEHlqn57
         W2Zg==
X-Gm-Message-State: AC+VfDzcU6dFE72FM0+hCuyzZveohXWdKn0aztvJvSJyDs7qlrP/qiGr
        8GlHmFddqsbAo+dP+H1GtY8=
X-Google-Smtp-Source: ACHHUZ4loax0r2ryQ/NZLnyN+uRJNYa/sl5VGC+6EMy431qxGiQy5fee6GUa+agQ7duwis9GuJGimA==
X-Received: by 2002:a05:6a00:24c4:b0:640:f220:d16e with SMTP id d4-20020a056a0024c400b00640f220d16emr5154594pfv.11.1682639318519;
        Thu, 27 Apr 2023 16:48:38 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:55cd:594d:edb:e780])
        by smtp.gmail.com with ESMTPSA id p5-20020a056a000b4500b0062a56e51fd7sm13769425pfo.188.2023.04.27.16.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 16:48:38 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>, Song Liu <song@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH 2/2] perf lock contention: Rework offset calculation with BPF CO-RE
Date:   Thu, 27 Apr 2023 16:48:33 -0700
Message-ID: <20230427234833.1576130-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
In-Reply-To: <20230427234833.1576130-1-namhyung@kernel.org>
References: <20230427234833.1576130-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It seems BPF CO-RE reloc doesn't work well with the pattern that gets
the field-offset only.  Use offsetof() to make it explicit so that
the compiler would generate the correct code.

Fixes: 0c1228486bef ("perf lock contention: Support pre-5.14 kernels")
Co-developed-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_skel/lock_contention.bpf.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 30c193078bdb..8d3cfbb3cc65 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -429,21 +429,21 @@ struct rq___new {
 SEC("raw_tp/bpf_test_finish")
 int BPF_PROG(collect_lock_syms)
 {
-	__u64 lock_addr;
+	__u64 lock_addr, lock_off;
 	__u32 lock_flag;
 
+	if (bpf_core_field_exists(struct rq___new, __lock))
+		lock_off = offsetof(struct rq___new, __lock);
+	else
+		lock_off = offsetof(struct rq___old, lock);
+
 	for (int i = 0; i < MAX_CPUS; i++) {
 		struct rq *rq = bpf_per_cpu_ptr(&runqueues, i);
-		struct rq___new *rq_new = (void *)rq;
-		struct rq___old *rq_old = (void *)rq;
 
 		if (rq == NULL)
 			break;
 
-		if (bpf_core_field_exists(rq_new->__lock))
-			lock_addr = (__u64)&rq_new->__lock;
-		else
-			lock_addr = (__u64)&rq_old->lock;
+		lock_addr = (__u64)(void *)rq + lock_off;
 		lock_flag = LOCK_CLASS_RQLOCK;
 		bpf_map_update_elem(&lock_syms, &lock_addr, &lock_flag, BPF_ANY);
 	}
-- 
2.40.1.495.gc816e09b53d-goog

