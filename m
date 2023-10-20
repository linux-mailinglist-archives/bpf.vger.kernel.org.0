Return-Path: <bpf+bounces-12866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A647D175D
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 22:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45DE928268A
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 20:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427DB249F9;
	Fri, 20 Oct 2023 20:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZbhJEo4"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38606200DB;
	Fri, 20 Oct 2023 20:47:45 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CFCE8;
	Fri, 20 Oct 2023 13:47:45 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6ba54c3ed97so1179124b3a.2;
        Fri, 20 Oct 2023 13:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697834864; x=1698439664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0ZIMRigGTwdVjAgf14DvEXgC3201/iiyAMjiEO7lCw=;
        b=YZbhJEo4UOjprrvjrvFewOSic0H1Fdd2aWy9RxOXWOyVWMm04JY6DG4ic6DUoK+POC
         pKveaFOEcJsIVoq4Pi1pl8Vj8SDGXrfiS7zWN2xQTH/Kg2vC67oMNzTfEzpSLkWIWrFR
         5qIWBMOLTdhfDKSBy14laUy8ArK/n8vLhwg+lyRGZSrmVqTA074PJfJ0dFtPXDKhoedV
         ee6batgpo9oTJ0z9fWkqxneeYxjJthOdMCUF0Aei6x8ID/ZpmhMtxrL47kSxpAz/IHK7
         cKmHa4jE4rHAZHfwhlq0iow/5vPkLZY5KhVHTEVy7XfGpzIA26XuYYe0GwBX5CY7/G1y
         v7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697834864; x=1698439664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s0ZIMRigGTwdVjAgf14DvEXgC3201/iiyAMjiEO7lCw=;
        b=tW8GXgNNB0cmEV/D2NhWfCv4TWA2b8VK5aWXm71HVIE5i8AHjy8TPL2YPybWp+GAGq
         +HvcrER7wt5KC0Tfu0Z3kv8rxjvPP8IkMoI7pC77SPiqwG33b68AWylEMKYih1pvP0e2
         t2ErIxYjHa3K5GqnSe0Wjv/1wNamYwh2FV1YWc1FhtDZVh2Xx+qsXYIi371KFd3dEHL+
         IsQWop61xUMpiHgTlyPZzAqxuZV7fOGM7CElIyfoCigvHUB0rIZEeDgsdbE16Oqw7Ww0
         LrEkji1QxBLChBfb7Nw9UlxehXGYKtqI5sJkTJQXJm22eBnNUw4AhLjR/kB5OEb0GZ9e
         lAwg==
X-Gm-Message-State: AOJu0YzYoqzUk/5esNk0quk+nzY5HFTFjtIPtWPMqpkpdN4d5iPRrxZj
	VOhytdTCxWbeQ/2VjyKHzd4=
X-Google-Smtp-Source: AGHT+IGtL1KfgniFkyeYJwoXAdhulf7vCTfY1ZGKd2pY2Dm7K5N+SYYozkceWdlrZeW2t3JUlOPedQ==
X-Received: by 2002:a05:6a00:853:b0:6be:b79:eca with SMTP id q19-20020a056a00085300b006be0b790ecamr3278962pfk.32.1697834864411;
        Fri, 20 Oct 2023 13:47:44 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:17e0:7ea9:fbc6:4c7d])
        by smtp.gmail.com with ESMTPSA id r25-20020aa79639000000b00694f14a784bsm1971183pfg.52.2023.10.20.13.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 13:47:44 -0700 (PDT)
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
Subject: [PATCH v3 2/3] perf lock contention: Check race in tstamp elem creation
Date: Fri, 20 Oct 2023 13:47:40 -0700
Message-ID: <20231020204741.1869520-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231020204741.1869520-1-namhyung@kernel.org>
References: <20231020204741.1869520-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When pelem is NULL, it'd create a new entry with zero data.  But it
might be preempted by IRQ/NMI just before calling bpf_map_update_elem()
then there's a chance to call it twice for the same pid.  So it'd be
better to use BPF_NOEXIST flag and check the return value to prevent
the race.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_skel/lock_contention.bpf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index b11179452e19..69d31fd77cd0 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -328,7 +328,11 @@ int contention_begin(u64 *ctx)
 	if (pelem == NULL) {
 		struct tstamp_data zero = {};
 
-		bpf_map_update_elem(&tstamp, &pid, &zero, BPF_ANY);
+		if (bpf_map_update_elem(&tstamp, &pid, &zero, BPF_NOEXIST) < 0) {
+			__sync_fetch_and_add(&task_fail, 1);
+			return 0;
+		}
+
 		pelem = bpf_map_lookup_elem(&tstamp, &pid);
 		if (pelem == NULL) {
 			__sync_fetch_and_add(&task_fail, 1);
-- 
2.42.0.655.g421f12c284-goog


