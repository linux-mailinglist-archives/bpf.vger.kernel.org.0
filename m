Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41546F0F3E
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 01:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344382AbjD0Xsm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 19:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344184AbjD0Xsi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 19:48:38 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151F91FF1;
        Thu, 27 Apr 2023 16:48:38 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b5465fb99so7558337b3a.1;
        Thu, 27 Apr 2023 16:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682639317; x=1685231317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Hvu69ObOjDcoWXd9/X9TroW2MzYAQKs3/cK182eTWso=;
        b=g3HuvbQZVP2pSxXHQq5VztWSAvsdyuZP5ZBaS5Wt/5ogAm1OprxA2RbaMZdQ+CTVcW
         k5JDl+Dcfesu1P3kGh5FBK2y8B/KyTo+TQeVUoZKNh6fsBgRa0V/HCWx0Qo0pekT4kAy
         VVS8BFIcUEDGhJ5XM3tg2YstfH50R6xRfWvkrj4icOIHKzHh4/9k53278/nOLXhrBQxc
         5NZGCk9uww6uKK/Fh9uZSeIQfnX+jMZvOYecRE5EP076c4iWCNxaTqggLYfPGg8lRLZp
         2izea5nCTvQyYiFHEHhluYXtX7V527ho5YDkQTeoHdoXhejgoCU7tp8ZBIIN59z7oRj0
         f6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682639317; x=1685231317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hvu69ObOjDcoWXd9/X9TroW2MzYAQKs3/cK182eTWso=;
        b=flxv8fm7QO/xWXFXzn/faJkUK0AmaqnqoKqN70XHLXct02hxg9Az00q8EEA5w+fjP6
         KXbM7uHBLkqN5hC6uV6n9ZwIIgmNWEqtlwnNUozh4K4sme9CqPkXfb6bjVYu1p8YZzwJ
         wDMN50KgTqz7DrZvuL01BAZeY7hTudDSi6ply1QG9k6A0LihS7uMUqiWyNV+WA3WTVth
         Yi52Di9Cc1StjgUe2sJ5SX9WX1u3J8yncxqRQanSMwdTC6U1t+gta8zh3k12fANqJQOV
         bHCYynz77oKEzD68H86Aydx60fl1SQEHQfDi6dNEp/9hrLaT0ZPSDlgNXzrPFO5fIkUu
         hJ6w==
X-Gm-Message-State: AC+VfDwnGLm+FHuiSx2m2TlVR6QVujjBnRNOxOkr2upDqYQG8hQNqnI5
        Sg1W2nQ+EhC3IN7R9b9bI5s=
X-Google-Smtp-Source: ACHHUZ5twpgHIou96UOgioEHtYhnInA8Y/z/VeuakgmD02qRVv5fFPq1lyN7zXAxXzDzlnLqkTqoow==
X-Received: by 2002:a05:6a00:23c1:b0:63d:3d08:4792 with SMTP id g1-20020a056a0023c100b0063d3d084792mr5334327pfc.32.1682639316271;
        Thu, 27 Apr 2023 16:48:36 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:55cd:594d:edb:e780])
        by smtp.gmail.com with ESMTPSA id p5-20020a056a000b4500b0062a56e51fd7sm13769425pfo.188.2023.04.27.16.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 16:48:35 -0700 (PDT)
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
        Hao Luo <haoluo@google.com>, Song Liu <song@kernel.org>
Subject: [PATCH 1/2] perf lock contention: Fix struct rq lock access
Date:   Thu, 27 Apr 2023 16:48:32 -0700
Message-ID: <20230427234833.1576130-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
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

The BPF CO-RE's ignore suffix rule requires three underscores.
Otherwise it'd fail like below:

  $ sudo perf lock contention -ab
  libbpf: prog 'collect_lock_syms': BPF program load failed: Invalid argument
  libbpf: prog 'collect_lock_syms': -- BEGIN PROG LOAD LOG --
  reg type unsupported for arg#0 function collect_lock_syms#380
  ; int BPF_PROG(collect_lock_syms)
  0: (b7) r6 = 0                        ; R6_w=0
  1: (b7) r7 = 0                        ; R7_w=0
  2: (b7) r9 = 1                        ; R9_w=1
  3: <invalid CO-RE relocation>
  failed to resolve CO-RE relocation <byte_off> [381] struct rq__new.__lock (0:0 @ offset 0)

Fixes: 0c1228486bef ("perf lock contention: Support pre-5.14 kernels")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_skel/lock_contention.bpf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 8911e2a077d8..30c193078bdb 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -418,11 +418,11 @@ int contention_end(u64 *ctx)
 
 extern struct rq runqueues __ksym;
 
-struct rq__old {
+struct rq___old {
 	raw_spinlock_t lock;
 } __attribute__((preserve_access_index));
 
-struct rq__new {
+struct rq___new {
 	raw_spinlock_t __lock;
 } __attribute__((preserve_access_index));
 
@@ -434,8 +434,8 @@ int BPF_PROG(collect_lock_syms)
 
 	for (int i = 0; i < MAX_CPUS; i++) {
 		struct rq *rq = bpf_per_cpu_ptr(&runqueues, i);
-		struct rq__new *rq_new = (void *)rq;
-		struct rq__old *rq_old = (void *)rq;
+		struct rq___new *rq_new = (void *)rq;
+		struct rq___old *rq_old = (void *)rq;
 
 		if (rq == NULL)
 			break;
-- 
2.40.1.495.gc816e09b53d-goog

