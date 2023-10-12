Return-Path: <bpf+bounces-11999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4159B7C6571
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 08:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6410B1C21084
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 06:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94D1D513;
	Thu, 12 Oct 2023 06:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z1U58E5G"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16579D2FD
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 06:24:17 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF44E1
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 23:24:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a509861acso853745276.2
        for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 23:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697091854; x=1697696654; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EeU4glzf7AMn8qq7ueoEKKj+mEB5KFmYHLHv3WfeocA=;
        b=Z1U58E5GbHMjbK2/Qvu2IUfacU3bHmWnp/dsMURmSj5lXZzDXJRBfgRJNJwFu6ZWNv
         ZWaf0aImIotiOsM2ZQM8NlxyHZKsjUQpTrDW5ZISggs4ur0oMZAGQwCjhx85jNkG/Us/
         gAPLvqsl2Db44SNrZwhbLqk2V3VS86xavDAB7+hTkeRFv/dLY1zqKPHn0UTAeH8IDIUH
         W3XUan4+Sb4LzaRnByD9tx000aOkrs4JZ0JHlei5KtBz2SZLB/elFKpAOGulIMv0hZnT
         5zKKTDft6mPn+7/1VpE5qwgYWjAoNkfCO8sCtHfLFkQWJE56T1T1D59ySmuyAH5vjOot
         t45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697091854; x=1697696654;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EeU4glzf7AMn8qq7ueoEKKj+mEB5KFmYHLHv3WfeocA=;
        b=GrMj5HxWueycmrJ4P514cAXslbON6DGA+maJWwuAWtQoKhiBrawDrXFSxkcvTcTZXE
         eARdDqW83sdPIlNfQO9EyfFjzRvyoZ2FNNiO62/Y0a32AlH8zm2g/YgI75yQF6tYteFk
         mqZzJh08J2hWdgl3NSKGH5dU9kJkoyqzY/RoSJ5b2k7i/Y0wW1R+hf0QO/qBC40gGhqP
         klwE0grx2uLXe4vX95IoaVqRnWn3F0vFsMSMpUlF4zVYXVJXx/R7EovrozrexywIS+Hd
         A2Gi8xOjYqW3EIdXgvlAX4dOTzx+o4xBed3sNX50PEzS7mcmdeShN7OtAL1DU8vBNYk5
         v2yQ==
X-Gm-Message-State: AOJu0Yxae4Ykoyhfrzo7OSG/UpT2bClD2q5CRb/dumIbbl8QhRxRVbg+
	LjlTJ++de24gG326qjUpt9yEi2QNNrI/
X-Google-Smtp-Source: AGHT+IFbaF0JvsrJA8Pyi6Osn51e51XYhIhZKsVyPx7J9ZnrwG3gy+KXZ6E7OltXta56RlS+hciubo+AXwqC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7be5:14d2:880b:c5c9])
 (user=irogers job=sendgmr) by 2002:a25:d510:0:b0:d89:4247:4191 with SMTP id
 r16-20020a25d510000000b00d8942474191mr430367ybe.3.1697091854712; Wed, 11 Oct
 2023 23:24:14 -0700 (PDT)
Date: Wed, 11 Oct 2023 23:23:50 -0700
In-Reply-To: <20231012062359.1616786-1-irogers@google.com>
Message-Id: <20231012062359.1616786-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231012062359.1616786-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 04/13] perf threads: Remove unused dead thread list
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Song Liu <song@kernel.org>, 
	Sandipan Das <sandipan.das@amd.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	James Clark <james.clark@arm.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Leo Yan <leo.yan@linaro.org>, 
	German Gomez <german.gomez@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Artem Savkov <asavkov@redhat.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 40826c45eb0b ("perf thread: Remove notion of dead threads")
removed dead threads but the list head wasn't removed. Remove it here.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 1 -
 tools/perf/util/machine.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e0e2c4a943e4..8e5085b77c7b 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -67,7 +67,6 @@ static void machine__threads_init(struct machine *machine)
 		threads->entries = RB_ROOT_CACHED;
 		init_rwsem(&threads->lock);
 		threads->nr = 0;
-		INIT_LIST_HEAD(&threads->dead);
 		threads->last_match = NULL;
 	}
 }
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index d034ecaf89c1..1279acda6a8a 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -35,7 +35,6 @@ struct threads {
 	struct rb_root_cached  entries;
 	struct rw_semaphore    lock;
 	unsigned int	       nr;
-	struct list_head       dead;
 	struct thread	       *last_match;
 };
 
-- 
2.42.0.609.gbb76f46606-goog


