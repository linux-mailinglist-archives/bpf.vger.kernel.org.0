Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BB75BB562
	for <lists+bpf@lfdr.de>; Sat, 17 Sep 2022 03:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiIQBsX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Sep 2022 21:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiIQBsO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Sep 2022 21:48:14 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E14AE23F;
        Fri, 16 Sep 2022 18:48:10 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id s18so17038918plr.4;
        Fri, 16 Sep 2022 18:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Xlm3IEiv0QUQAA+pAhB6W56+eUuQAk/ZKcHmJT3d2iI=;
        b=WUFhdrju3oCC2ZIYRNQeYXdQrNpq+G6g/uZ4r+gWofnMWMTmRk/FyTD8VDr6u3qPWR
         +rvB9hUPYXvVQpA49zlXfrJkuSo/DRE+vgr7K3E0hqB1zWEnIdTY8//qRWlZGTNExNCL
         90G27MiG/C9vOCozrz+ICZ1bxaYSQdZ6lU3mKGFs/sjPh57y8+QoY/0RBYuIi8OHZiq7
         PcVAup9KumXxYKamx1mTGVB/krZn2CdQMlNab7G0Pa8foF4Z2fVENl2vK7o0xqhcHP/F
         bTdbRPUj7Hj1sJBb2mgBA+jWfq3VejAEfiyivrM7Bqg3CMjJEr57JqtUPEr3w11Ta3mV
         QG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Xlm3IEiv0QUQAA+pAhB6W56+eUuQAk/ZKcHmJT3d2iI=;
        b=7CS8x5CS23nBaBn51EcD8mD79m6PRWEhu4C5iXpoygQhdanU2ai1VMDP3tsglmr2gP
         6cf5lWHslBg+jHuMDKoHiicMzsbeiUZ1ah9NCBc1OAMH1tk3Zz2z98BK+tbw2ymWpVTa
         9X0tseZQDM8AHM9jWECPeSuUtwgwNrV9SOxGEEW0yHx2vJo8a3/B7jr8l7St09kQaLKE
         Yb4zz8qONXlTgfep54SKFgQb12Gdv/YVp7X7S+9TK2YjoSzPgBLd+rLw2mUBTPiuQd3A
         azVPoB08PO5aflnDuKejy/71g8zTpv3+SFKL987xastK7aFgbHIquVcDXS/VaYe9+jJs
         uicQ==
X-Gm-Message-State: ACrzQf0PRvUu9s8AnDJtdNHV5dmnkPWReNdLT1lCrA94vsgtu40aQtw0
        1GbZk9PRc0UZsaeZwsCrWdAkG1BhV//PMw==
X-Google-Smtp-Source: AMsMyM71xMgaiF/8/lbKBPDtmeqx0ps4MzQRwy8FzckWsZE2Y4/DPMbQNUVQZwvjoTyKyWgp+9+X9Q==
X-Received: by 2002:a17:90b:4a06:b0:202:c03b:eb5c with SMTP id kk6-20020a17090b4a0600b00202c03beb5cmr8636550pjb.6.1663379289294;
        Fri, 16 Sep 2022 18:48:09 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id g3-20020aa79f03000000b005465ffaa89dsm8972011pfr.184.2022.09.16.18.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 18:48:08 -0700 (PDT)
From:   Li Zhong <floridsleeves@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     namhyung@kernel.org, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        Li Zhong <floridsleeves@gmail.com>
Subject: [PATCH v1] kernel/events/core: check return value of task_function_call()
Date:   Fri, 16 Sep 2022 18:47:46 -0700
Message-Id: <20220917014746.3828349-1-floridsleeves@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Check the return value of task_function_call(), which could be error
code when the execution fails.

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---
 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2621fd24ad26..ac0cf611b12a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13520,7 +13520,8 @@ static void perf_cgroup_attach(struct cgroup_taskset *tset)
 	struct cgroup_subsys_state *css;
 
 	cgroup_taskset_for_each(task, css, tset)
-		task_function_call(task, __perf_cgroup_move, task);
+		if (!task_function_call(task, __perf_cgroup_move, task))
+			return;
 }
 
 struct cgroup_subsys perf_event_cgrp_subsys = {
-- 
2.25.1

