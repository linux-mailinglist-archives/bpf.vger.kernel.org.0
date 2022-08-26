Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7105A2C99
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 18:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344664AbiHZQoW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 12:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344647AbiHZQoB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 12:44:01 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8FBE095F
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 09:43:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31f5960500bso33278807b3.14
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 09:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=byVpB80TV/x11qGZZj1V9Hbrrk6J+Ff/Bi0KHWzM1Uo=;
        b=ROEzNU2vLJMBQ/ebGwfQ6eGsi2A4XeOX0z4/AtBTW7uH+wvBDbvD9U7dJUuGUu0/t/
         RG9SYRmEyQo81EQ6zm3BjTZyRAd/U+mfJ7acDyId27JWIUA+paGfqTwDijvDB5d96jS4
         0Evlu4LK9nXucMq0urv221+RSew0RsqU7Avx7QFSET/cxIFWkyK8hulDJfmqHHoDNT5d
         xzKrx5b6n0zWGgGV0Vid5qk43WAwDqZ2pDO3Z9r3V/WssKhdPELqolGKQo+4CFfR2Ggh
         H3RSQhX3uRz8yinHvLoTXXd77gH0H5rzVUCKfgzHXTupkv1hVDBVI3XndkxCFQPKiQVA
         mRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=byVpB80TV/x11qGZZj1V9Hbrrk6J+Ff/Bi0KHWzM1Uo=;
        b=pfLdM2fwmOIJ1IT7FXEEpC6kH3R7UFodcT1vSbSHLptlNGBlkCCxkf2hMBYnQrSRvz
         vec2FWj0ypU38nt0/sh358vJHJX14TPbDW0eqeaUjye5nXKm+4fFMrvWjAiUI5WnO+bh
         0IykO7/2/QyFhtJwWzq/WUdNT0qNZYfYdmkbkC6wct6YXup+LmWg523XZYNVZsdpfmWY
         JaHwpopTVFLA9OU2tXmzNzhf4EumZMVuNEXS7nynjcJHmlA90Y86IIX5RTfQ2v590J1r
         TZVCDn33R0/U10atnd+Z1QF05CUtTFGQ9pRG3WJELx5DLvxLhvp61x9VtAJ0+DAz1eS3
         uf9Q==
X-Gm-Message-State: ACgBeo3sDYLJnqWiQTZKlg8jw85qRFHI3v9RMGiPOFMA9E+miS3NVN9H
        v+uESTjVkT8bw4YIV9zfS3aJ/7tSa/cA
X-Google-Smtp-Source: AA6agR6+TnZFZIJcRd/XLNKJvnwoJOukG+FHhTf/+Ns3Gs61SwVZyHKl1Nu9OjgbFxM6njZlSR8C8NrDOQey
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ccb1:c46b:7044:2508])
 (user=irogers job=sendgmr) by 2002:a25:afc6:0:b0:695:8a28:1dc6 with SMTP id
 d6-20020a25afc6000000b006958a281dc6mr494579ybj.500.1661532207957; Fri, 26 Aug
 2022 09:43:27 -0700 (PDT)
Date:   Fri, 26 Aug 2022 09:42:29 -0700
In-Reply-To: <20220826164242.43412-1-irogers@google.com>
Message-Id: <20220826164242.43412-6-irogers@google.com>
Mime-Version: 1.0
References: <20220826164242.43412-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 05/18] perf bpf: Remove unused pthread.h include
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Weiguo Li <liwg06@foxmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Dario Petrillo <dario.pk1@gmail.com>,
        Hewenliang <hewenliang4@huawei.com>,
        yaowenbin <yaowenbin1@huawei.com>,
        Wenyu Liu <liuwenyu7@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Quentin Monnet <quentin@isovalent.com>,
        William Cohen <wcohen@redhat.com>,
        Andres Freund <andres@anarazel.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        Colin Ian King <colin.king@intel.com>,
        James Clark <james.clark@arm.com>,
        Fangrui Song <maskray@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

No pthread usage in bpf-event.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-event.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index 144a8a24cc69..1bcbd4fb6c66 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -4,7 +4,6 @@
 
 #include <linux/compiler.h>
 #include <linux/rbtree.h>
-#include <pthread.h>
 #include <api/fd/array.h>
 #include <stdio.h>
 
-- 
2.37.2.672.g94769d06f0-goog

