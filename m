Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FA76EC28B
	for <lists+bpf@lfdr.de>; Sun, 23 Apr 2023 23:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjDWV4z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Apr 2023 17:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDWV4y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Apr 2023 17:56:54 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5519FE76;
        Sun, 23 Apr 2023 14:56:53 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b51fd2972so3090804b3a.3;
        Sun, 23 Apr 2023 14:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682287013; x=1684879013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=GSgAcoXgSDnWS/7yo+J3yz1PI9CqV55UTloz7w6JFJg=;
        b=mI8g70FtRaOn0BDc513vRcKXtM2bIrOVEJBBwwqGUpjE+COcmbbHdqgvYmWHKoT3Cl
         lSYv0Le0/hihWHj6WuI9eyKL1MFAnjX4LMqgj06Vkdot3yc3QwxpcdXUi9crt5ehbdua
         6Q8ROTyKY6tR5A6vU0zkEcBd7YybPV5OdClqACO+Y4LpYo8awTI97SDHBbuNKW3otXdr
         NgmoAmdQScalAl1q4r4O1ukXAadbyPf4s15pF8va6zVoqsf/TAXNXuvSq1PGTTyeNx5H
         Ofptob2i/KM7178cRUcXiOhSc05QtnkoDCFllQJN1WHJiGcy0phED6mgpjBKr77VJqOQ
         /0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682287013; x=1684879013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSgAcoXgSDnWS/7yo+J3yz1PI9CqV55UTloz7w6JFJg=;
        b=T0bQh/nQfXLLleZS5p7bbBJ8hjyNkzI1r8defNurHeb9jE5IRjmSCgTlqMCKhd/K9M
         vArEcxXECqMMe+Zo/P99fapQzENP2rTuGzB/xBUa4mAS6VPc6OcmUq0tGEr7dQZAyh76
         +PbPqoFOpk/zTtt7Fnl5RLptyUEBvFC2bYidRUF0mc2FdqDgC7bp+tP5Vt2MXZIYfc4s
         nP6sNHWvmnQOGAICabyHXDHsjdIacxojs0YYItl1UXPOUJFmVsMsqURKCZFays+e3J+M
         nFcz9txTOQF9c6UiD/Zo+W/w/GF/iXmFwRugn6+PrHdeZqZQ+xENbidN38Vw/PsaxKrD
         1wzA==
X-Gm-Message-State: AAQBX9c6N966aUIBktxnbUpKHGflLU/6tpf6/mzkR90OhtbCv+FDg7cU
        GNouAJqDxDwobPIYtIJslso=
X-Google-Smtp-Source: AKy350bxTKCgkE0vmaTH9OzhX0yQCdIJm/bTBrn2ymbEUGtlBxpehl5opTmCv0u/D+Z+pqvYAoS3ig==
X-Received: by 2002:a05:6a00:1ad1:b0:63b:89a2:d624 with SMTP id f17-20020a056a001ad100b0063b89a2d624mr15378143pfv.12.1682287012528;
        Sun, 23 Apr 2023 14:56:52 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6700:7f00:2833:1d0a:7988:4146])
        by smtp.gmail.com with ESMTPSA id 123-20020a621881000000b00627df85cd72sm5990230pfy.199.2023.04.23.14.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 14:56:52 -0700 (PDT)
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
        Song Liu <song@kernel.org>
Subject: [PATCH] perf lock contention: Fix struct rq lock access
Date:   Sun, 23 Apr 2023 14:56:50 -0700
Message-ID: <20230423215650.287812-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
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
2.40.0.634.g4ca3ef3211-goog

