Return-Path: <bpf+bounces-11998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB1C7C6570
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 08:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD2428296B
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 06:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F55D50C;
	Thu, 12 Oct 2023 06:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dtCItIPd"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2D4D2F1
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 06:24:14 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6365CF
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 23:24:12 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9ad31a1fb3so143425276.1
        for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 23:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697091852; x=1697696652; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ym33VVd2BajpUroKBZvd3tTL/sMIOEowMFesXhruLGo=;
        b=dtCItIPdQ3ab8HIPvToAzsIESurEr15VjpWWQ8yaO+Mg1RPqvT1cE14W9NklAd0jK4
         7yQ2iyo7WfgUQHpDzjw4V0bvJWMP9hGr1MpgnkicSitGIq9Hgx6OBpCyvqIgbhaytO4f
         wE2oz/3Zdc1UDmfqgeYmLjtPPZijSChFDH3QPEX6xvSQcIWUs6fsZeeHOUlMLjxtuLXh
         3p4fy/a9+mdQ/ejgOkZKtHwQ4HBkeVjdo6SW9BnVVB/NdYNT2A9GxxV+xXatq9lEOJwJ
         iQ6OC+badkskyGbxNCbXfyXX8nMbfz3mHiQ/mrp9ETD79Rv+3tw/76vxDOVuOpmZUfK+
         bGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697091852; x=1697696652;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ym33VVd2BajpUroKBZvd3tTL/sMIOEowMFesXhruLGo=;
        b=kA5/5jbPqJ6hcTjZUNvBdHZW6T22rthIGmkWf3ERsBJG61iD4WAc8a0zMMUatkrr4H
         NyR7NlDgykVzehL/p2qrlmb/8OxEcpCnzCbsNz9oyUT6ZzIjMtmURPEzu4hkr1LWeM6m
         MnxV4k9b28W/2wtJbMdWLxy9i9CLmeKNO8lmgNoMa9k4gKscOgH86LSKeWa8LlLkEDfA
         PBBgdoEtLs2ztEEl6mPwp4BZUPfNUlXljteJctyls3IElU34Od3afBIJ7qAJ2nNJRYAm
         2bsjv7DkemSNPaOBu4Mu60ddtJlHYrV/iRTIw6XS7kIi2JmKWtkqxLwDPeykNcJXzpcW
         nDmg==
X-Gm-Message-State: AOJu0Yy3VtM/f9rAlHyPGkmxQAq45vmOQR3KvkCICuQcNMs4/ZH0WlMM
	Tqz4WJKsjYlxEQVkdZSXCZr88pFyjPNU
X-Google-Smtp-Source: AGHT+IFamm+ol0Ge6e4jpFG/GjQbgher+01yNqOVMfFajP7Qe61Mum0E7T8Iepds/4dvQPRSXfa66oFUzQ9k
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7be5:14d2:880b:c5c9])
 (user=irogers job=sendgmr) by 2002:a25:870c:0:b0:d9a:3a25:36df with SMTP id
 a12-20020a25870c000000b00d9a3a2536dfmr196216ybl.8.1697091852080; Wed, 11 Oct
 2023 23:24:12 -0700 (PDT)
Date: Wed, 11 Oct 2023 23:23:49 -0700
In-Reply-To: <20231012062359.1616786-1-irogers@google.com>
Message-Id: <20231012062359.1616786-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231012062359.1616786-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 03/13] perf hist: Add missing puts to hist__account_cycles
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

Caught using reference count checking on perf top with
"--call-graph=lbr". After this no memory leaks were detected.

Fixes: 57849998e2cd ("perf report: Add processing for cycle histograms")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/hist.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 3dc8a4968beb..ac8c0ef48a7f 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2676,8 +2676,6 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 
 	/* If we have branch cycles always annotate them. */
 	if (bs && bs->nr && entries[0].flags.cycles) {
-		int i;
-
 		bi = sample__resolve_bstack(sample, al);
 		if (bi) {
 			struct addr_map_symbol *prev = NULL;
@@ -2692,7 +2690,7 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 			 * Note that perf stores branches reversed from
 			 * program order!
 			 */
-			for (i = bs->nr - 1; i >= 0; i--) {
+			for (int i = bs->nr - 1; i >= 0; i--) {
 				addr_map_symbol__account_cycles(&bi[i].from,
 					nonany_branch_mode ? NULL : prev,
 					bi[i].flags.cycles);
@@ -2701,6 +2699,12 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 				if (total_cycles)
 					*total_cycles += bi[i].flags.cycles;
 			}
+			for (unsigned int i = 0; i < bs->nr; i++) {
+				map__put(bi[i].to.ms.map);
+				maps__put(bi[i].to.ms.maps);
+				map__put(bi[i].from.ms.map);
+				maps__put(bi[i].from.ms.maps);
+			}
 			free(bi);
 		}
 	}
-- 
2.42.0.609.gbb76f46606-goog


