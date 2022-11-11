Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486BA625467
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 08:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiKKH1U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 02:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiKKH1S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 02:27:18 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEB6657D9;
        Thu, 10 Nov 2022 23:27:17 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id o4so5337171wrq.6;
        Thu, 10 Nov 2022 23:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88ryav6TjdsBnuYHNgOaRaKfsuTkckPVXqoY4uilu+s=;
        b=pL5ImJSeUAk8JdsH1VE9cmKYRBNoP5wd5R1gm7DPnQb7kKZMfjkD4Qa7PQ7jSdQmnl
         XcyV1uA3Ir2iK/sb8Tjh3fFqSNGHxlnZUuFgln+Q9LTf5LNOe5S+W5cryUHTu1PH6vZS
         g6vpiNbCLS6iTaffhffTVIZzuBKcQEi2EObpdXbff0yHCgiIvRAn4PFPm/6kvmXBTbmg
         /AxRRFTqqj4L4I41BOQA6d2QkRoqqMMgwDywATcOmV1g1lhVLjFFqAbCcO16pL4qjd//
         Dtlt1+36ujwYXAkqaW3LIChu19NRm+viZ7NrNv3a8zxzQuw6cm9JREXWRwUVaXiZuwP5
         8uTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88ryav6TjdsBnuYHNgOaRaKfsuTkckPVXqoY4uilu+s=;
        b=tXEV+ZQxsO1cp177Z2pbDgUbAsznDKp+3PY2fxheZkEc1N7vWT+d7l7NUoiNvLweOT
         Wyw8DpNLqIN6q/Op60vrnrbkjtA/0s/nbxVl87hDW3DGTwOp6HqlX8mlwBa5h9uXSnvB
         0dPQYWp4EfSVgjW2kDzEWTnwZwFGc64RuEoAobOR8x91wpUq/ZAVmEOOvtKB5BMSOz+1
         qalYnZ0YZX+BCTTM6eUmWTJeOjtstjtdos7QclFzGAbWmT52I/G3JBrgw7S0mGSyiP/A
         Uw7pTrZtLyuTJdTrDFJuhdRtf6A8I8/YcuX3wnwikchm5VkXaJL2VDrJIlYIHd4OogG2
         CkOQ==
X-Gm-Message-State: ANoB5pmqsnromWa0xPQO6Mm7V5zYMTgfUG97h7PSfjU9ZoL4lPTroQdz
        GDVSTN6OQlcD2Ecaiv79rtE=
X-Google-Smtp-Source: AA0mqf6xxlopbmCifV1vDxNwLYg89KRXWLRf6Da8Zp1T0pn5pzhTFhh3FoGdsb0EA6JDcILxxJxiBQ==
X-Received: by 2002:a5d:4b8c:0:b0:236:e52d:b0d7 with SMTP id b12-20020a5d4b8c000000b00236e52db0d7mr421841wrt.46.1668151635760;
        Thu, 10 Nov 2022 23:27:15 -0800 (PST)
Received: from felia.fritz.box (200116b8262ac400710df4e5ad386bbd.dip.versatel-1u1.de. [2001:16b8:262a:c400:710d:f4e5:ad38:6bbd])
        by smtp.gmail.com with ESMTPSA id o15-20020a05600c510f00b003c6d21a19a0sm2101690wms.29.2022.11.10.23.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 23:27:15 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] perf: remove unneeded assignment in find_get_context()
Date:   Fri, 11 Nov 2022 08:26:56 +0100
Message-Id: <20221111072656.14591-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit bd2756811766 ("perf: Rewrite core context handling") refactors
find_get_context() and with that, the err variable does not need to be
initialized to -EINVAL, as it is set again before all further uses.

Remove this unneeded assignment. No functional change.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 kernel/events/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index c7157f8d8d2f..836f8fbb9980 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4735,7 +4735,6 @@ find_get_context(struct task_struct *task, struct perf_event *event)
 		return ctx;
 	}
 
-	err = -EINVAL;
 retry:
 	ctx = perf_lock_task_context(task, &flags);
 	if (ctx) {
-- 
2.17.1

