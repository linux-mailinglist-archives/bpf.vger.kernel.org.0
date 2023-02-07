Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3375968CB12
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 01:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjBGAYR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Feb 2023 19:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjBGAYQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Feb 2023 19:24:16 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B943B32533;
        Mon,  6 Feb 2023 16:24:08 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id d6-20020a17090ae28600b00230aa72904fso4962574pjz.5;
        Mon, 06 Feb 2023 16:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbe5ZwnW+2hhqu7fOUm3UEvMRH8Ded44FvXJC3UdrO4=;
        b=goyiGm0sX7Ba75GkWdREOvTPS2n7RJ9Q7KFWVsydT74ahpnbgy9cv8PT28pntUjt7o
         3HH27EiHhncl35wjl0LBCu9oEx/rpRrI2Fr+eBMF5F/DX1mnZXjaaWbv8J+xCMoBiaIt
         w+iI3baJLL3o7WEGlk/kdhB+YjSgGfhPAHersUAehQdVy/QSpepVct4l8N2gfrmbaQmn
         1utXIyYheiOJP/jfvVHH+PXdG7N9SLJdq9GgbzZfEAccVzdS0tueQ2J6W2FH1V43hn+8
         TrQCxiDUDMyfpzCEePiyHhQY2Rjb9fjsoHYJ/3J1C2n1Ps2tBUHob6T3mi28dtx3yhcN
         zwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kbe5ZwnW+2hhqu7fOUm3UEvMRH8Ded44FvXJC3UdrO4=;
        b=Sb6NkWkLN050Hp774PJNUCr3RV/iILqZop9YP6UsjbumOrIwW+LDmHtbpAWMq5hoDB
         vG+KSR+ypnDsuLtRkDykWs/RsOefOxhu7g1hAg1+vX+7uqFKPnrYnttg+JXKHCGcQ1nW
         ZgFuSD9oQIXM0bp2C9UbWpWG+AXGSvz3hawmJbvkEFAAz35WOYaY4OIPnDWsnR3EZO+a
         rAo22P+22ufO+xsiKFixCPrNwjsnlzUwYjzzNlfWktPHCgd5wucBkb0WWRLn4yCrR7TN
         TefCZc7XlgihJBkk72iDsI9V3ObYdKpBlKrVMSDLOZJv/hwMrEfq7rsMuLRq56TgLqQq
         6aWg==
X-Gm-Message-State: AO0yUKV4khymeRa5dMTLuqzLM1Ftkbetnwr9ngXtEZuHuQXmkBq8IInh
        0P07gIIFsv58Bkj7lsQCqjk=
X-Google-Smtp-Source: AK7set/ZGzyv0kEXWrsr1vWHkwPNwRoZ2uvhuPBKulrEDfTj8zl3/P9YZmbksrFVGw43ePbZ0tJB5g==
X-Received: by 2002:a17:902:f14a:b0:196:25b1:a032 with SMTP id d10-20020a170902f14a00b0019625b1a032mr565861plb.59.1675729448100;
        Mon, 06 Feb 2023 16:24:08 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:47cc:64dd:1572:cf18])
        by smtp.gmail.com with ESMTPSA id y1-20020a1709029b8100b00189b2b8dbedsm3544080plp.228.2023.02.06.16.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 16:24:07 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        bpf@vger.kernel.org
Subject: [PATCH 1/3] perf lock contention: Fix to save callstack for the default modified
Date:   Mon,  6 Feb 2023 16:24:01 -0800
Message-Id: <20230207002403.63590-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
In-Reply-To: <20230207002403.63590-1-namhyung@kernel.org>
References: <20230207002403.63590-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The previous change missed to set the con->save_callstack for the
LOCK_AGGR_CALLER mode resulting in no caller information.

Fixes: ebab291641be ("perf lock contention: Support filters for different aggregation")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 0d11f301fd72..a4b5c481129c 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1806,6 +1806,9 @@ static int __cmd_contention(int argc, const char **argv)
 	con.aggr_mode = aggr_mode = show_thread_stats ? LOCK_AGGR_TASK :
 		show_lock_addrs ? LOCK_AGGR_ADDR : LOCK_AGGR_CALLER;
 
+	if (con.aggr_mode == LOCK_AGGR_CALLER)
+		con.save_callstack = true;
+
 	/* for lock function check */
 	symbol_conf.sort_by_name = true;
 	symbol_conf.allow_aliases = true;
-- 
2.39.1.519.gcb327c4b5f-goog

