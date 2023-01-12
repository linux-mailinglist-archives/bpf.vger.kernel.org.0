Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C8F6685D7
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 22:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjALVsv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Jan 2023 16:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240782AbjALVrh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 16:47:37 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D223434756;
        Thu, 12 Jan 2023 13:40:29 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id a184so14781571pfa.9;
        Thu, 12 Jan 2023 13:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hw1JZT4caRKOkdMu9I0bZSzXZiCQYqiKX0Yt62R8CcM=;
        b=RcFJQebsL1oo93IC8w4Oxta1bemGsbrJW5pMa303hyHmzRNvU7QBOBjeX85vkrLEMI
         Sk8rvxoUTPBaDeQKT680TOM72ra1sjElMwvEJgEJg0Ixa1MHLja3gUAB5dX2sqdGdS+B
         2Ftg662VuXT/wTPCOj17BJlqy3JKqPcihaJF9+HMrbcRO0NM+nDcEmtBjx/IFreBBKcV
         hEYBr7jIEVgn3SgMffwhKIVJvoRsqwkc4pY6hlH3ftDgyMONnAebid7/JZlnztEwWDRL
         MZtAQtFWAI5VqoXoV9cSAyctDSmahTV6wIziVVoFz8qE/VCP3fHp+HqVMDhDeyg/RYwW
         YUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hw1JZT4caRKOkdMu9I0bZSzXZiCQYqiKX0Yt62R8CcM=;
        b=xZZErkY3MCSEchY1+UfF4tsyDHjS/ACCM/gc7dyESV00VoHFtHow9BV1NIDHJ4hY8R
         wuePVcJpNEtaEt2NxTW690K6XTba6a/War6jjz83vKpu9OgSd3H10L8Xa5eIV0J/rQ1Y
         r8UH8uBvw8RFoOmucELfMnDyvaPqiXfvu7fyNFWE1Mne85ENP/N59LWGnLYJjPuTRof/
         d/KJTbIDG+wkzs19C4LC2MypVhFldICGf9jfDr09YpcsfY5o7lXCjDg672YIBWsPvYMC
         ADOdl8pITXyaKTbm15IU1YsrCLbimL0sAwlSu2mO6pfal0tOb1dTCwGhH+PtHpv13X1i
         azfg==
X-Gm-Message-State: AFqh2kpq7KwigFDN92GKJ8ZYmFn20s9PNMV8JM6IVtJNGKlmIzZyjKoH
        G8t7U4V+paN23YwCzzpAel8=
X-Google-Smtp-Source: AMrXdXumgzPYKmHuVCA/C0WD1hyzao8lVSTgn1LDJ9sa/DSxpejlrQSYdKclEkw1PD+HtkBrLGNIAQ==
X-Received: by 2002:a62:f211:0:b0:581:68ea:50 with SMTP id m17-20020a62f211000000b0058168ea0050mr56865082pfh.26.1673559629520;
        Thu, 12 Jan 2023 13:40:29 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:b71e:23d4:aa6a:47c0])
        by smtp.gmail.com with ESMTPSA id q20-20020aa79834000000b0058134d2df41sm11344605pfl.146.2023.01.12.13.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 13:40:29 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Song Liu <song@kernel.org>,
        bpf@vger.kernel.org
Subject: [PATCH 8/8] perf/core: Call perf_prepare_sample() before running BPF
Date:   Thu, 12 Jan 2023 13:40:15 -0800
Message-Id: <20230112214015.1014857-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230112214015.1014857-1-namhyung@kernel.org>
References: <20230112214015.1014857-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As BPF can access sample data, it needs to populate the data.  Also
remove the logic to get the callchain specifically as it's covered by
the perf_prepare_sample() now.

Cc: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/events/core.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5c4f3fa3d2b7..af8365fb639a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10363,13 +10363,7 @@ static void bpf_overflow_handler(struct perf_event *event,
 	rcu_read_lock();
 	prog = READ_ONCE(event->prog);
 	if (prog) {
-		if (prog->call_get_stack &&
-		    (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
-		    !(data->sample_flags & PERF_SAMPLE_CALLCHAIN)) {
-			data->callchain = perf_callchain(event, regs);
-			data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
-		}
-
+		perf_prepare_sample(data, event, regs);
 		ret = bpf_prog_run(prog, &ctx);
 	}
 	rcu_read_unlock();
-- 
2.39.0.314.g84b9a713c41-goog

