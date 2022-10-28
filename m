Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7E06119D0
	for <lists+bpf@lfdr.de>; Fri, 28 Oct 2022 20:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiJ1SBt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Oct 2022 14:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiJ1SBp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Oct 2022 14:01:45 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B16211290;
        Fri, 28 Oct 2022 11:01:40 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id e4so5416208pfl.2;
        Fri, 28 Oct 2022 11:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUx8fY5yV5k6b3NAzZ7ONnYGBUoPPnSRBV9IAdB2IcQ=;
        b=R5qTkGNPJ2owG22N7vSR56g7SchuiPlUzXI4dNN1k/rvLdTdqG4kadsZfKegVIwN3o
         TvJ+pVZ2pU3FtvqqRVpQ3m52vnAGIAr95xQetLdYfQ4vq28RiTHw9kdJTuDUysll5xnO
         3Tos32ojE0o1gtPF2NjT8CPvwK8nzy+JcYOsS6vVJSWpMIbTbdX6T63xKsDjuBi3Kiu1
         eVING4QaSDU1jdHSCxToNVDMQIros4oZD2YpJHGXTO+mfkDRwiM4NmeqUN5cSUCyrQW7
         1/kY9mkFENtb2XZzYGnwY+R5EFuLHvnUUHAawQEd0e6id73h9c/3NLyUoYcwZAtB8cSw
         cPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bUx8fY5yV5k6b3NAzZ7ONnYGBUoPPnSRBV9IAdB2IcQ=;
        b=bscsi6Us4db1wZnhialOlVVYmGLNL28PjeBy+ULBGEDa+nA6hPhf8lLHziaFvl0R6U
         BMgvYt1X2ocTVAa6vj37pJM4Id/PNUsepAQSzXD8++Ibu9wgwp4Fdxbq9JN5uB3mMtiA
         R15UCFXLG6sODhBYIWmGJB3Dg9J4PqZF2StFxWXeetGKBkegAXIB+twBNXphPJciUb6a
         cN5haWj1nSC9dh/y9I+5nmcX26cen/oy+ejxRdsLxGmO43IS4V3V00jYlLfSaCwg2V6F
         xVgZ3a27pvkuFv1rv/MBkcYxiHc61EqO7GjMtJ7DOxQzxgR7z1LlbtRxRYav9d+9HwMf
         dD7Q==
X-Gm-Message-State: ACrzQf3+u7hfy7izE+tmR8BD8wzoZ7hBH/Wi9cm/rRKh/flH/uV5tO0x
        MoEAPbRo+et/IADdVYTrT8A=
X-Google-Smtp-Source: AMsMyM4/4142AtL9gDKsW66R2DQwFckkQXdIqI8rIATA3ZjgBGVT7PVXnop8c1DLVI7LR3SYgeTyiQ==
X-Received: by 2002:a63:1308:0:b0:440:5517:c99d with SMTP id i8-20020a631308000000b004405517c99dmr636154pgl.550.1666980100358;
        Fri, 28 Oct 2022 11:01:40 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:976f:f075:7c14:87a2])
        by smtp.gmail.com with ESMTPSA id n3-20020a170903110300b00186b86ed450sm3400236plh.156.2022.10.28.11.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 11:01:38 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        bpf@vger.kernel.org
Subject: [PATCH 4/4] perf lock contention: Increase default stack skip to 4
Date:   Fri, 28 Oct 2022 11:01:28 -0700
Message-Id: <20221028180128.3311491-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
In-Reply-To: <20221028180128.3311491-1-namhyung@kernel.org>
References: <20221028180128.3311491-1-namhyung@kernel.org>
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

In most configurations, it works well with skipping 4 entries by
default.  If some systems still have 3 BPF internal stack frames,
the next frame should be in a lock function which will be skipped
later when it tries to find a caller.  So increasing to 4 won't
affect such systems too.

With --stack-skip=0, I can see something like this:

    24     49.84 us      7.41 us      2.08 us        mutex   bpf_prog_e1b85959d520446c_contention_begin+0x12e
                    0xffffffffc045040e  bpf_prog_e1b85959d520446c_contention_begin+0x12e
                    0xffffffffc045040e  bpf_prog_e1b85959d520446c_contention_begin+0x12e
                    0xffffffff82ea2071  bpf_trace_run2+0x51
                    0xffffffff82de775b  __bpf_trace_contention_begin+0xb
                    0xffffffff82c02045  __mutex_lock+0x245
                    0xffffffff82c019e3  __mutex_lock_slowpath+0x13
                    0xffffffff82c019c0  mutex_lock+0x20
                    0xffffffff830a083c  kernfs_iop_permission+0x2c

Cc: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/lock-contention.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
index b8cb8830b7bc..e3c061b1795b 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -91,7 +91,7 @@ struct thread_stat {
  * Number of stack trace entries to skip when finding callers.
  * The first few entries belong to the locking implementation itself.
  */
-#define CONTENTION_STACK_SKIP  3
+#define CONTENTION_STACK_SKIP  4
 
 /*
  * flags for lock:contention_begin
-- 
2.38.1.273.g43a17bfeac-goog

