Return-Path: <bpf+bounces-11753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AB17BE9CE
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 20:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1D4C1C20E16
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 18:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9482E37141;
	Mon,  9 Oct 2023 18:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qmHE39qm"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EB434CFA
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 18:39:44 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FFCE6
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 11:39:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a483bdce7so375721276.2
        for <bpf@vger.kernel.org>; Mon, 09 Oct 2023 11:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876780; x=1697481580; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MTpWBQgPQVQy0TAZXLEWpBVQQ2YTPMy6ZmoyjFN0GGE=;
        b=qmHE39qmWSQLTvMKSb2BXWkZwWApobrmAKmtm7mq0rdAfERykcCz8xuEv/bWuEJrqR
         tnmKKm+FW/8n87xQW6j46XHC1I69IvsnbrRD+eq7avKDUZjaaLT5NPpL2+QH4kMMJGxF
         oLHBfuj8Ay9PG2bb1Xsvc5TFt1eA6gldWFNmCUu8A+Xmbb9HNYFwanXrIysLcHzqhQng
         xQghqyRJxKTcDczz03ooQZrEV0ZqSOoTmcEDLoIV6iQGziWpRLIGJechrq5dlMksBYPL
         iZL+Iogh3FbQHeZ/KNso2dBNHvlndvgG9Ia5W3q4vZXjUmeOI2uE+gvt5XMCvqQ65947
         T9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876780; x=1697481580;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MTpWBQgPQVQy0TAZXLEWpBVQQ2YTPMy6ZmoyjFN0GGE=;
        b=rm5VG0KFXoFMoGaZpqjIHbymxilaufOvRslMqnqNTwJzCToWdHcDnm9oYlidW9OcA4
         VzI1pEoG9Wur43AQtyg97hvXnp2f8D97qf8nlvxqTUH6vufuA6AqFsJ7rgVjhASxCHGQ
         qE/rlBnIm8Io/F829oF5uOntX+k+QUIg3vN383W/CXA7EtmyD/md5CRQn4NXvdNhEmgS
         zf9duXvTnWboB5kvIotOO71YzYA6/pWhuDZi2uMphF/JNPPjLrVDLbmKQbtTwOZu/yrQ
         J2tmFshorxSq/QmEuDR4MviPUPC3dkPr6E7l2LT7DBBqmMx4Uo8tmDszkRlXMhbqppHP
         /h4w==
X-Gm-Message-State: AOJu0Yy/qusX1YQzWaxhcDAYIWFUldH0Kqwvir/J9QWseE9QxDPK+5ET
	6W/Q6wlXsjWCiAH+qV3wRJa4jAWdTFJD
X-Google-Smtp-Source: AGHT+IHSFLzIMOdZMLClCkJhOThmOClRy30ep3/ZFs+55TAb6kM08lo1dDdwBNKotykaeaR7pVv7k1gDXaCN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ac4a:9b94:7158:3f4e])
 (user=irogers job=sendgmr) by 2002:a05:6902:181a:b0:d89:3ed5:6042 with SMTP
 id cf26-20020a056902181a00b00d893ed56042mr268371ybb.11.1696876780144; Mon, 09
 Oct 2023 11:39:40 -0700 (PDT)
Date: Mon,  9 Oct 2023 11:39:07 -0700
In-Reply-To: <20231009183920.200859-1-irogers@google.com>
Message-Id: <20231009183920.200859-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231009183920.200859-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v3 05/18] perf buildid-cache: Fix use of uninitialized value
From: Ian Rogers <irogers@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Tom Rix <trix@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Ming Wang <wangming01@loongson.cn>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The buildid filename is first determined and then from this the
buildid read. If getting the filename fails then the buildid will be
used for a later memcmp uninitialized. Detected by clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-buildid-cache.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index cd381693658b..e2a40f1d9225 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -277,8 +277,10 @@ static bool dso__missing_buildid_cache(struct dso *dso, int parm __maybe_unused)
 	char filename[PATH_MAX];
 	struct build_id bid;
 
-	if (dso__build_id_filename(dso, filename, sizeof(filename), false) &&
-	    filename__read_build_id(filename, &bid) == -1) {
+	if (!dso__build_id_filename(dso, filename, sizeof(filename), false))
+		return true;
+
+	if (filename__read_build_id(filename, &bid) == -1) {
 		if (errno == ENOENT)
 			return false;
 
-- 
2.42.0.609.gbb76f46606-goog


