Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D716CB206
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 00:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjC0W5Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 18:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjC0W5P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 18:57:15 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB33D1FF3;
        Mon, 27 Mar 2023 15:57:14 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id fb38so6763447pfb.7;
        Mon, 27 Mar 2023 15:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679957834; x=1682549834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pZq/tE3Ime66Eff4zF6BNW0V2oykqPbi7rtW7dsDQrg=;
        b=iuBNExzhq7IYRXi33wGistpI+OsvEZMGpg6DH2srXQHqfJMj3yR/RxiLB/YFktY27O
         J8dWK438cz1Z6zBSHh4l1T44l3YHOoP8BXB+jaa4b/Slxw8HrmdDX8q65dAzgIcq4EeU
         ZzBbm3uOn38iyYkwVTfsDWet3ChGkjB1Xg/oJplIkuW1rfBsIotL3OR38WxYIfRZOmr+
         RS9epJHDoT6UAlJJ9jUmBl+9yUpGVuwQ6cyP17a75i+5QNfNqeAiIWzTHajzwSnc6n0i
         S7ghshSVsqJnPJyJoOm3fNm+mH03blpu1QVrHniliELKA7alNGiIQsLFFcXmqnBEfwPQ
         +oUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679957834; x=1682549834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZq/tE3Ime66Eff4zF6BNW0V2oykqPbi7rtW7dsDQrg=;
        b=Vb2V4Z40U/ImII1lwCA+sYHmn01658r8c4TNr63ALPnKTPJI39TJFRtxwofWcmTTrW
         d1HTRHExTaVeyrrkECcf67UUG5Ats2TJQpVsPZNIadvJpxKpnItqMK0LlGUT6+hmwv86
         +hpfXrBK+8Ym9ENOBIKOumaKUKaSxIuoncV0axhM3C8QTrcJZ4q5OIx+bPAtEsZnFZBA
         +s6SguisYVV0xzX9ixKvMVH5Xm1vBHvkw6hWszcGInYIPRfXOWVtUDJkSCcaWSIjGrLO
         pJrk/+CFVSTN4UwKWWWbzkPed0Fi5q5pHTs1aXAbETfxKutWb0WmxyvQw9nexpAQ02Ix
         iELA==
X-Gm-Message-State: AAQBX9c/bsN6HzHvDesnOtzshNyZ3EZPjvPR9+77tp+Zn7UWtxOpQNm/
        5AD/uWlHwrOuSdp9eBDORtY=
X-Google-Smtp-Source: AKy350ZrbHX5ujApaU/q8xz8/33bP/1AJLbH4PavvuxVIHBkisc+Q/BDewsSuvoCQbVk2HVAdKJBCw==
X-Received: by 2002:a62:1d51:0:b0:622:ece1:35d3 with SMTP id d78-20020a621d51000000b00622ece135d3mr12560546pfd.5.1679957833991;
        Mon, 27 Mar 2023 15:57:13 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:44b0:4cdc:1028:ab64:920d])
        by smtp.gmail.com with ESMTPSA id c11-20020aa781cb000000b0062d84986823sm2383579pfn.169.2023.03.27.15.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 15:57:13 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Hao Luo <haoluo@google.com>,
        bpf@vger.kernel.org
Subject: [PATCH 1/2] perf lock contention: Fix debug stat if no contention
Date:   Mon, 27 Mar 2023 15:57:10 -0700
Message-Id: <20230327225711.245738-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It should not divide if the total number is 0.  Otherwise it'd show
NaN in the bad rate output.  Also add a whitespace in the "output
for debug" message.

  $ sudo perf lock contention -abv true
  Looking at the vmlinux_path (8 entries long)
  symsrc__init: cannot get elf header.
  Using /proc/kcore for kernel data
  Using /proc/kallsyms for symbols
   contended   total wait     max wait     avg wait         type   caller

  === output for debug===

  bad: 0, total: 0
  bad rate: -nan %     <-------------------------  (here)
  histogram of events caused bad sequence
      acquire: 0
     acquired: 0
    contended: 0
      release: 0

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 3c8a19ebc496..82dd2dfe5692 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1323,10 +1323,10 @@ static void print_bad_events(int bad, int total)
 	for (i = 0; i < BROKEN_MAX; i++)
 		broken += bad_hist[i];
 
-	if (quiet || (broken == 0 && verbose <= 0))
+	if (quiet || total == 0 || (broken == 0 && verbose <= 0))
 		return;
 
-	pr_info("\n=== output for debug===\n\n");
+	pr_info("\n=== output for debug ===\n\n");
 	pr_info("bad: %d, total: %d\n", bad, total);
 	pr_info("bad rate: %.2f %%\n", (double)bad / (double)total * 100);
 	pr_info("histogram of events caused bad sequence\n");
-- 
2.40.0.348.gf938b09366-goog

