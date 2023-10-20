Return-Path: <bpf+bounces-12865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA8E7D175C
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 22:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AABCB2160C
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 20:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FF0224E2;
	Fri, 20 Oct 2023 20:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gk2nIdCc"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378EF1802E;
	Fri, 20 Oct 2023 20:47:45 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC491D51;
	Fri, 20 Oct 2023 13:47:43 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6b5cac99cfdso1157386b3a.2;
        Fri, 20 Oct 2023 13:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697834863; x=1698439663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Mm7dtlx0Z3ORS3BpllS20dd9G/AciSYgKTckitgJskM=;
        b=gk2nIdCc3be2ppxntJ0kb3coXmOqwnvKChPTqLAXDndxiomFoOV0T04nefrUJygfg4
         W7tBAnLSlK66I1MCmXI+rxjqK0zxJ5EujjHeYWOlT1ZmNJNkeo994P63GxoP0mq1eg/Q
         2oaGXuJbSGH2Q1g0kfP1vFsm75LFl+QoO3cu9/qgNy3NKsuEVuYt8S6tPMrrvz59zfp6
         2mYqs0U/QUscZW5XM8GDJkYtkHiUhe7bZoR8MsLTXZVjem7BWK1n0d49vOPR3zDMq5Zu
         WLn5uhLUeRQqXfuxj8oY3TIDsJPg86xmh7pNZ29JPApr+B+VE5olcdrLP6dkYtTuFr7F
         bm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697834863; x=1698439663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mm7dtlx0Z3ORS3BpllS20dd9G/AciSYgKTckitgJskM=;
        b=CpZkfAl61CEyQKgSwE2+mJyUUjM60uqrcdVjf/xPLk0vCNRO8hZEdTmPwf01csBRcK
         ohHydfs3F7ycxU7iK0Osf3abzVI+kmOO+uNvjlw8EWpT6XS7U8h3CnyWA7/5YrtBZmSI
         8O9vI7AKsyhBkFvVKi2f2Ga0PRqR4kJ9xXmempiLEJJx3U5qNHVesdk69ExPvNFfuzsZ
         ShB2AslFM+wLj6ajy5ZTVZT1mr7VfEeWd6LLojCyuq0F9pgWc76XPiT8T30RJ+VYB4F+
         0h7H4ucW9acTrEylo/NEzlg/86mY4BSWoemhkJ5WpkaPTw9e9/zzQ76kZTVyAczE73mJ
         DUuQ==
X-Gm-Message-State: AOJu0YxrS/xNkTKTyOT4FfMZwKThGxoR1p28iAsoi7yE7KOuKPKKCTgK
	NnhTndWjjxvOFYVvpVZg0YM=
X-Google-Smtp-Source: AGHT+IGNAW08UrC9GMhPGqpScR5qg4UfBmZqwC6ITV1HsWdo7h5JeeE5B0GTahaJ7KzNxv3P6sKk8A==
X-Received: by 2002:aa7:88d0:0:b0:68e:41e9:10be with SMTP id k16-20020aa788d0000000b0068e41e910bemr2696426pff.20.1697834863278;
        Fri, 20 Oct 2023 13:47:43 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:17e0:7ea9:fbc6:4c7d])
        by smtp.gmail.com with ESMTPSA id r25-20020aa79639000000b00694f14a784bsm1971183pfg.52.2023.10.20.13.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 13:47:42 -0700 (PDT)
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
Subject: [PATCH v3 1/3] perf lock contention: Clear lock addr after use
Date: Fri, 20 Oct 2023 13:47:39 -0700
Message-ID: <20231020204741.1869520-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.42.0.655.g421f12c284-goog


