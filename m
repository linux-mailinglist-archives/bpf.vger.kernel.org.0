Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E017E5BD51D
	for <lists+bpf@lfdr.de>; Mon, 19 Sep 2022 21:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiISTQl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Sep 2022 15:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiISTQk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Sep 2022 15:16:40 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F163D5AB;
        Mon, 19 Sep 2022 12:16:38 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o70-20020a17090a0a4c00b00202f898fa86so200062pjo.2;
        Mon, 19 Sep 2022 12:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=kto0Fw6Y7MnDKJFxsFF5qnCzEUoaNF/I4dExXU0Pygg=;
        b=VjiDfYA94Wdlty7c8PpPHHR0SAiAw8suAjvRNZl8DKr1ranNySZCyYU6Uc8wKMmlO4
         ajWPSD9nTUHcAyKWhydh2AmBADKS3ryImaF28B4BpcUq92zdpaAtILLrkHnZowwm4wIu
         ulnReooR/Jk3kASlu6wkM3brhC6U40ftHElGBfuvvx0p4yUREnDrOcorOHKjcl6FG+7H
         x6NeGsag+WvbMH+WhlrAONcnd2zEW7SvRw82iSb5Ulz7NtIVW0NAyodqrTTtWy4U0hG4
         2WMRYUrCMCPDDKMhNpQj2KYdrrys97VBhbReUd3ajT/bY+Ls/28feJEqMcrwC8ACma9J
         KTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=kto0Fw6Y7MnDKJFxsFF5qnCzEUoaNF/I4dExXU0Pygg=;
        b=6KV+OFKu8pUUImK/aLMgaKbYjxclLaK9MmNWx7h8bq+8WZyKJLkFwMqgVWVtMxH26b
         k5Bsdm91Bf9QLaZ114Z4l0xk24nX5EHInmRzLVd6jcwO0WaxrKAR9LmxA0Lx1X1J+kB9
         BKcI3GHJMKnd9kXGPNwr2TaG4/tf3mg1TcI/bfwwi4L26nfAQgR52KZYAR6CXSIit/2A
         UCONiGsBptrQsYpaQCaxcxsRRPuSa6Vir56X4QOo5CvItsCdeQJujxXDw/HRIVSy61T5
         eyn1GcDrDx3D+jBGZiK/RpUNMznMWjkOv623D2tEhzY83IqUZb0KNEjT4FWd8HpSPeZ4
         poZw==
X-Gm-Message-State: ACrzQf1l+aoDKdbvCMns3EVi65CJQo3Xv6/r2G6CZJkSUikogkaFouYV
        jgcUqueMdNu2TU4hyELySQZ/Tfte4Yo72A==
X-Google-Smtp-Source: AMsMyM7TbdBoV4FPU1gJ/1qkP30y9Ubrg2U2ktp5ncedp6FZk8W3EAqIpCWVyg4nMMP2mI6Tg41ezA==
X-Received: by 2002:a17:902:e212:b0:178:5c:8248 with SMTP id u18-20020a170902e21200b00178005c8248mr1260783plb.102.1663614997503;
        Mon, 19 Sep 2022 12:16:37 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id s11-20020a17090aba0b00b002036006d65bsm5965185pjr.39.2022.09.19.12.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 12:16:36 -0700 (PDT)
From:   Li Zhong <floridsleeves@gmail.com>
To:     linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Cc:     namhyung@kernel.org, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        lily <floridsleeves@gmail.com>
Subject: [PATCH v2] kernel/events/core: check return value of task_function_call()
Date:   Mon, 19 Sep 2022 12:16:11 -0700
Message-Id: <20220919191611.1589661-1-floridsleeves@gmail.com>
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

From: lily <floridsleeves@gmail.com>

Check the return value of task_function_call(), which could be error
code when the execution fails. We log this on info level.

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---
 kernel/events/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2621fd24ad26..3848631b009c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13520,7 +13520,10 @@ static void perf_cgroup_attach(struct cgroup_taskset *tset)
 	struct cgroup_subsys_state *css;
 
 	cgroup_taskset_for_each(task, css, tset)
-		task_function_call(task, __perf_cgroup_move, task);
+		if (!task_function_call(task, __perf_cgroup_move, task)) {
+			printk(KERN_INFO "perf: this process isn't running!\n");
+			continue;
+		}
 }
 
 struct cgroup_subsys perf_event_cgrp_subsys = {
-- 
2.25.1

