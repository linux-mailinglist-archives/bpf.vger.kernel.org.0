Return-Path: <bpf+bounces-11788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D737BF268
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 07:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D75E3281DC7
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 05:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED6F9444;
	Tue, 10 Oct 2023 05:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZN8RcoiF"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E4C63A5;
	Tue, 10 Oct 2023 05:46:23 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84ED2AC;
	Mon,  9 Oct 2023 22:46:20 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-690d8fb3b7eso4668248b3a.1;
        Mon, 09 Oct 2023 22:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696916780; x=1697521580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=uvYgbd6jsaxRvqO2oO/xtebxfgxyUR4b8FU8FPolyTQ=;
        b=ZN8RcoiFcfC24Na+zm1RWNKXxgNC+ERmTsykvdk5lHRzskZIHpn0QPFpwoLyY9W1He
         JP1zK+ypaNrrOynnWG5SkMFDFTCJq7MTnVyRf7S0KvHJEOwl/x6rqD+2UQ+RPsNUBFqJ
         3s6PUZKFkvf3Vbub/LHMobbu8aRF3u1GveLMIr9o+P3uWfuhqk8b6eMhrzNIkNBE2ZlZ
         yg1rrQPdKTKAZ+vdgu4nzev/hNXT7OQNOphw4hcPid4Mx0Yv5XbWdlIeehZZhLPO/g66
         34YJDM3slFHTzVu/LOpi8Asn6Qb0MUAj1J1Tw83jBdkeOJGrPFwFDPjIG6/YYJ1HLTk/
         E3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696916780; x=1697521580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvYgbd6jsaxRvqO2oO/xtebxfgxyUR4b8FU8FPolyTQ=;
        b=RFlXnD7AZXyMhLpsBhN93xCJ2mhaXvgdq2PWCoK/NQBn/xe1r6bmO6N2uy59GoeV1P
         K1e+IQYPznne2gig7KmTy3HUQILzXkAF1lS45WIsiMxEvxJAcaQup3lE+AOLvO/ghaE9
         cCY3ix1o90SyZUQIJ+me0SDX31pK9f0mp+bcXD0dfBkpfyEHtTu5pTQNaW4H+VuWJ2rU
         NdR/Wk3VVT/2GDwoA0o9b2vZxqoO5EpxmP80LegaU5GnLv8IRfyrxf06GTf5+rC4FmJf
         2IakXHI58h4kGFB7kFf9OatgjGI+z5DSAlzNvg1SqDzCj5UzcIFPlWF+E08VV6v0rc05
         Xlfg==
X-Gm-Message-State: AOJu0YzFt+KBGUBrTRGSgVcYJWTsj1sJ+1TS7MQRMzh4xaA9u+T6uCnK
	NqkpTorDThJCaPI/jCzyoiQ=
X-Google-Smtp-Source: AGHT+IGSXYrNljbSBZ8JLJG1lxLjBrIBoLUDtOS6inCVelawQFY9TLT3ojme9OmifOlqQQgRQPlURA==
X-Received: by 2002:a05:6a21:a5a8:b0:152:6b63:f1e5 with SMTP id gd40-20020a056a21a5a800b001526b63f1e5mr24226512pzc.38.1696916779861;
        Mon, 09 Oct 2023 22:46:19 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:2749:d38c:68c4:434f])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902b28a00b001c60a2b5c61sm10590084plr.134.2023.10.09.22.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 22:46:19 -0700 (PDT)
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
Subject: [PATCH v2 1/2] perf lock contention: Clear lock addr after use
Date: Mon,  9 Oct 2023 22:46:16 -0700
Message-ID: <20231010054617.1901616-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
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
2.42.0.609.gbb76f46606-goog


