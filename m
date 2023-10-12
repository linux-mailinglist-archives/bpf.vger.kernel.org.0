Return-Path: <bpf+bounces-12006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7003D7C657D
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 08:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A16461C21174
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 06:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1772D2FD;
	Thu, 12 Oct 2023 06:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qp8RZwl6"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F32D50E
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 06:24:43 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FA41B5
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 23:24:33 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59f7d109926so9723857b3.2
        for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 23:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697091872; x=1697696672; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=flxfAGeU36X3VCWvCeBnyhGj7NRxqRtkjKz9SEhq+zk=;
        b=Qp8RZwl6K+UKiZuC0kkyEe1H4Dhxz1Q8ofiKc7xh4psBeYZL5MAAFeNeyu00AXzr/H
         O86dFjRmhv86edW3lyAfIsA9fl7OkdB1dnKHoz12KrDJLt2TleEL1pB/rXW1KOVKrAws
         QUQG9pxv3eMH4wAwZwB8XoZGCPnUy835T/KsTHrvMJ+MfsfqnG3Qi0l3mUVnSOdVPk9S
         Hlrcs+dWL0uLJ4yAIbfMe42o724+HWKx0CtsN2ikMCdRxgPwuV2VK1lSSTqs2EQr26vB
         9rBsoUZMAU/LdWtF0ZEPytcQNBKNTNwGlfc02UEBxuC0aiKcOLokSj9IhegbCuHykG7v
         uiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697091872; x=1697696672;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=flxfAGeU36X3VCWvCeBnyhGj7NRxqRtkjKz9SEhq+zk=;
        b=EXmaK55nVCC1aYAkanf39cEDB4pGT89cAZtxeUOMp1+gaWRC85X+UUqyOrYpHT3ypy
         cZBJBDeWolLojpI5MPYHOVlZlLbt1XS1HrwupR5O/f0AsvV6Obno6RlQKlLxXyVbtZ/s
         HtilIXc4CifeFfESbDomEgIoqaWkZOF+ttk5XLkrkqkC6FaWSAsn6LrMT3hiDMr4LGVb
         OMVP324w4tnCq1KwPar3ugpHI2FpDnllWBHIaBMBbrfRxYlxjg2IKpC5GSxG1IHwmRYj
         NQ+2YrQJkzQjHU6Fl1CDqK81p3I4ePjqwF58CBjAT7N529xt529wrcGnw7EpFYPs5eFh
         EbnQ==
X-Gm-Message-State: AOJu0YwtpsyQ/CI0mqoOdiOSBgGtdEOSbQZJHvHdwEaxFGXYOcm/0wgj
	MBjX66npzWEVzxqFY2opDeEIrqsZCKfM
X-Google-Smtp-Source: AGHT+IGdUdinYuEq8T3uAohDpFLB8P8wmRDQ5QHEXJxvYYgkout89ScuOm/SWzNEJeVgK30fxeyLC6iN4e5k
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7be5:14d2:880b:c5c9])
 (user=irogers job=sendgmr) by 2002:a81:a909:0:b0:59b:e97e:f7e3 with SMTP id
 g9-20020a81a909000000b0059be97ef7e3mr422912ywh.2.1697091872656; Wed, 11 Oct
 2023 23:24:32 -0700 (PDT)
Date: Wed, 11 Oct 2023 23:23:57 -0700
In-Reply-To: <20231012062359.1616786-1-irogers@google.com>
Message-Id: <20231012062359.1616786-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231012062359.1616786-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 11/13] libperf: Lazily allocate mmap event copy
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
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The event copy in the mmap is used to have storage to a read
event. Not all users of mmaps read the events, such as perf record, so
switch the allocation to being on first read rather than being
embedded within the perf_mmap.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/include/internal/mmap.h | 2 +-
 tools/lib/perf/mmap.c                  | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/include/internal/mmap.h b/tools/lib/perf/include/internal/mmap.h
index 5a062af8e9d8..b11aaf5ed645 100644
--- a/tools/lib/perf/include/internal/mmap.h
+++ b/tools/lib/perf/include/internal/mmap.h
@@ -33,7 +33,7 @@ struct perf_mmap {
 	bool			 overwrite;
 	u64			 flush;
 	libperf_unmap_cb_t	 unmap_cb;
-	char			 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
+	void			*event_copy;
 	struct perf_mmap	*next;
 };
 
diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
index 2184814b37dd..91ae46aac378 100644
--- a/tools/lib/perf/mmap.c
+++ b/tools/lib/perf/mmap.c
@@ -51,6 +51,8 @@ int perf_mmap__mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
 
 void perf_mmap__munmap(struct perf_mmap *map)
 {
+	free(map->event_copy);
+	map->event_copy = NULL;
 	if (map && map->base != NULL) {
 		munmap(map->base, perf_mmap__mmap_len(map));
 		map->base = NULL;
@@ -226,6 +228,13 @@ static union perf_event *perf_mmap__read(struct perf_mmap *map,
 			unsigned int len = min(sizeof(*event), size), cpy;
 			void *dst = map->event_copy;
 
+			if (!dst) {
+				dst = malloc(PERF_SAMPLE_MAX_SIZE);
+				if (!dst)
+					return NULL;
+				map->event_copy = dst;
+			}
+
 			do {
 				cpy = min(map->mask + 1 - (offset & map->mask), len);
 				memcpy(dst, &data[offset & map->mask], cpy);
-- 
2.42.0.609.gbb76f46606-goog


