Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF136591B5
	for <lists+bpf@lfdr.de>; Thu, 29 Dec 2022 21:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbiL2UoE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Dec 2022 15:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbiL2Ung (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Dec 2022 15:43:36 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B68A18387;
        Thu, 29 Dec 2022 12:41:07 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id jn22so19944749plb.13;
        Thu, 29 Dec 2022 12:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+7CR58SPvhZSbvxiF3pO3ff849ICg9QIOe5C8t8+9o=;
        b=XrHqS0Trcpa4Hn59n/py1EEYcBPf8OPeyq9pDLIzTLmc/xTM376UuDQEjqJbvCAU0O
         pORf3gMmzYLe6R6hrjbjjIGN5qmJV4O2/BKkPVmwM1z7ByVSh2bcGKH43sI0Gobopw16
         DQsgYebDdH0VDoKCNIrLtkyH+2Q7Um0LAte1tKWw4mMaVoHkVzs7TYSsDcypOIyKxMsc
         s+mhNPoFfCm4+dmMbj0DhoNlvqk+b03iA2p6FWQIRkkzMk0/yqOdxHqbOxN0MLvyMgfM
         0mq1aQp1ceQpBx+NBXusEz9OjzyOZSHvnCd5XwR2EQi1iHi0LMRMHORnfmfF6weed7il
         PDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5+7CR58SPvhZSbvxiF3pO3ff849ICg9QIOe5C8t8+9o=;
        b=Os/5xXIiOKmcwQRYrYcs8XXmF5+63gcNt4j34xkT3kzUmfvoMVlrbpLJVEnsUKwq/V
         IlRCIPlNAQDi42qFkwumrIcO/98y0ld6wy4Syp0bFGUyVzK45fb/4tjrS/i84n8VHxxB
         us8rcqySRCbsRpI2biI6XsDis2IlRBTjolZg9Ba83J9H6yp2dM9rKeIolgpYgSykBwcc
         38cUFzHuel3HFUSX7SAkv3hxXSAOVuDYKnYGJrdeMpck8ODMvS8FLALzw2FYBVkLDV/K
         IJqX5DhdJ5ccZWZ2jCgTRtFr16d3UfkBhu48s3NcT8Io3LQp+YHuP09Ymx7WRVTZ6wvP
         N8GA==
X-Gm-Message-State: AFqh2kq4RAeXIjVzzgkKUNRwzAxKx/I9SoYe2rdmmvteUHXA6tCPBtAz
        /jYWrZypjptcSYsOlqyPnTVm1iTcq2CyCw==
X-Google-Smtp-Source: AMrXdXuamyUtbCEYIAxU87Kwz446hazHbxIhbYjn3tc/7GQegmmiAhB4yDaqhA2edKHhkxWXcOAjag==
X-Received: by 2002:a17:903:31d5:b0:191:4539:d2c1 with SMTP id v21-20020a17090331d500b001914539d2c1mr30581759ple.47.1672346466671;
        Thu, 29 Dec 2022 12:41:06 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:d74d:9c28:5a9d:f5b9])
        by smtp.gmail.com with ESMTPSA id q15-20020a17090311cf00b001754fa42065sm13413824plh.143.2022.12.29.12.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 12:41:06 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, bpf@vger.kernel.org
Subject: [PATCH 3/3] perf/core: Save calculated sample data size
Date:   Thu, 29 Dec 2022 12:41:01 -0800
Message-Id: <20221229204101.1099430-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221229204101.1099430-1-namhyung@kernel.org>
References: <20221229204101.1099430-1-namhyung@kernel.org>
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

To avoid duplicate work in perf_prepare_sample(), save the final header
size in data->saved_size.  It's initialized to 0 and set to an actual
value at the end of perf_prepare_sample().

If it sees a non-zero value that means it's the second time of the call
and it knows the sample data is populated already.  So update the header
size with the data->saved_size and bail out.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/perf_event.h |  2 ++
 kernel/events/core.c       | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index dd565306f479..ccde631a0cb4 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1103,6 +1103,7 @@ struct perf_sample_data {
 	 */
 	u64				sample_flags;
 	u64				period;
+	u64				saved_size;
 
 	/*
 	 * Fields commonly set by __perf_event_header__init_id(),
@@ -1158,6 +1159,7 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
 	/* remaining struct members initialized in perf_prepare_sample() */
 	data->sample_flags = PERF_SAMPLE_PERIOD;
 	data->period = period;
+	data->saved_size = 0;
 
 	if (addr) {
 		data->addr = addr;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 70bff8a04583..dac4d76e2877 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7575,6 +7575,15 @@ void perf_prepare_sample(struct perf_event_header *header,
 	header->misc = 0;
 	header->misc |= perf_misc_flags(regs);
 
+	/*
+	 * If it called perf_prepare_sample() already, it set the all data fields
+	 * and recorded the final size to data->saved_size.
+	 */
+	if (data->saved_size) {
+		header->size = data->saved_size;
+		return;
+	}
+
 	/*
 	 * Clear the sample flags that have already been done by the
 	 * PMU driver.
@@ -7796,6 +7805,8 @@ void perf_prepare_sample(struct perf_event_header *header,
 	 * do here next.
 	 */
 	WARN_ON_ONCE(header->size & 7);
+
+	data->saved_size = header->size;
 }
 
 static __always_inline int
-- 
2.39.0.314.g84b9a713c41-goog

