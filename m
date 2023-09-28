Return-Path: <bpf+bounces-11086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9A97B2904
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 01:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 6124028295A
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 23:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3573634CEF;
	Thu, 28 Sep 2023 23:50:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4329518C0F;
	Thu, 28 Sep 2023 23:50:24 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2688E195;
	Thu, 28 Sep 2023 16:50:23 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-69101022969so12171605b3a.3;
        Thu, 28 Sep 2023 16:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695945022; x=1696549822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMt+zIF+jw6oNrS3fj8y+UDRx1fAa1Xaxe11egraIX0=;
        b=F/L+H3te0DOa1zgkD/6EoFeFcmW+jPQoU8wsdBX6a05Yiv3ptIk+595w4ay+fqx65c
         AssjbP2gtw0v7ltH96He38aEqCuvm2Oz8LJnHlgxP7BIThxOsMxclGnj4RCICXFpMVdD
         niB10JeLnM6577xagb/uDcxKsc8JThM3SE0ggFmdPQ3xrnDrNaghKeRR6rBxYRJdBiQ+
         1pp6WT9AfN40+X5jYVcBNaVhTqXE2HN1NHpJHuLomvI6lv5ZjmPUt9y1cmkuTtJ9bwZp
         CGaDPX8TpR62q7NWJRJo6O2j3LZvoDi2HUSzWlliOdJjOofG6Tj1PEmYL9NKA1p1y0zW
         YCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695945022; x=1696549822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMt+zIF+jw6oNrS3fj8y+UDRx1fAa1Xaxe11egraIX0=;
        b=lHTD89W859J/SbUXi/XK0J8LTnpe0ePBKux5B3Bk+gUVvkWNPsDzHX1Kc2x7U2GAJT
         8PtaAbJ++5IVtZ5YJ/RgMOpTwKUKVJ6FW6Z45w/qpiTtilyBV+nLxgUSsIwoahwviVTE
         FNRdyDp/I+rCoydg2NT7Axk71hb7F5alJO93aGIA9j4g0F7JHrBLWnsR3rSTPeYnsijK
         QnBw3q3dKvKcjHWdPdYLf6XyDIL/6XhA6dUs81zmxolDbmWf11xIi0097YA7U1DeJbpN
         Pa2k/oNoRj4MLPZDTscKalgsIDPTx3FLlS79JVBZjaQj5hoHrnThgbMg5WpIqR3sArYE
         KrVA==
X-Gm-Message-State: AOJu0YwIKa9/5gMWSXkpEzEXEy+BRKTC7REd+HD//pFfWTHImCcro1mU
	IKHKASreyYuTZcb91Q9QF9g=
X-Google-Smtp-Source: AGHT+IGRDnRwQiG9v//BKw6nb7aCS4Jw4ppLdPdWJMf6lz4GXoevHprt6clbVpV4VVbMAoD4XT0Q9g==
X-Received: by 2002:a05:6a00:c92:b0:68c:3f2:5ff7 with SMTP id a18-20020a056a000c9200b0068c03f25ff7mr2821852pfv.1.1695945022550;
        Thu, 28 Sep 2023 16:50:22 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:819e:1876:98c3:2f15])
        by smtp.gmail.com with ESMTPSA id q9-20020a639809000000b00573f82bb00esm13383482pgd.2.2023.09.28.16.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 16:50:22 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	bpf@vger.kernel.org
Subject: [PATCH] perf lock contention: Clear lock addr after use
Date: Thu, 28 Sep 2023 16:50:18 -0700
Message-ID: <20230928235018.2136-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

It checks the current lock to calculated the delta of contention time.
The address is saved in the tstamp map which is allocated at begining of
contention and released at end of contention.

But it's possible for bpf_map_delete_elem() to fail.  In that case, the
element in the tstamp map kept for the current lock and it makes the
next contention for the same lock tracked incorrectly.  Specificially
the next contention begin will see the existing element for the task and
it'd just return.  Then the next contention end will see the element and
calculate the time using the timestamp for the previous begin.

This can result in a large value for two small contentions happened from
time to time.  Let's clear the lock address so that it can be updated
next time even if the bpf_map_delete_elem() failed.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_skel/lock_contention.bpf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 4900a5dfb4a4..b11179452e19 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -389,6 +389,7 @@ int contention_end(u64 *ctx)
 
 	duration = bpf_ktime_get_ns() - pelem->timestamp;
 	if ((__s64)duration < 0) {
+		pelem->lock = 0;
 		bpf_map_delete_elem(&tstamp, &pid);
 		__sync_fetch_and_add(&time_fail, 1);
 		return 0;
@@ -422,6 +423,7 @@ int contention_end(u64 *ctx)
 	data = bpf_map_lookup_elem(&lock_stat, &key);
 	if (!data) {
 		if (data_map_full) {
+			pelem->lock = 0;
 			bpf_map_delete_elem(&tstamp, &pid);
 			__sync_fetch_and_add(&data_fail, 1);
 			return 0;
@@ -445,6 +447,7 @@ int contention_end(u64 *ctx)
 				data_map_full = 1;
 			__sync_fetch_and_add(&data_fail, 1);
 		}
+		pelem->lock = 0;
 		bpf_map_delete_elem(&tstamp, &pid);
 		return 0;
 	}
@@ -458,6 +461,7 @@ int contention_end(u64 *ctx)
 	if (data->min_time > duration)
 		data->min_time = duration;
 
+	pelem->lock = 0;
 	bpf_map_delete_elem(&tstamp, &pid);
 	return 0;
 }
-- 
2.42.0.582.g8ccd20d70d-goog


