Return-Path: <bpf+bounces-10093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7887A0FBF
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 23:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0B41C21183
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 21:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66825273CD;
	Thu, 14 Sep 2023 21:20:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB400273CA
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 21:20:09 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2517D2723
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 14:20:09 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59bcabc69easo20067837b3.1
        for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 14:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694726408; x=1695331208; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YO3ZTyHFm+00gT95r949gZji8+XYvbCsq+dhsmDC+Ok=;
        b=E2tqCAxPd3bvCjWpCu1Mdk81qd7sNmUQscYrFGIN4qeq1ugNv5edtqC0V+gUnG2fpl
         OguXR94Cg1gct+QfZy2nG6MO5lGlZiygLIuJ+Wp4R04WhrShZRFyGi4Zz3y3jh34gbnH
         QYyrRBbQp6YRVXaL7cjm28TvkQcTnFk6Qovm6GL7LTEChcgyygRulO0m0AYF/wAAgXL9
         r6xF1iur7uNSFI7cBbSI8qhlDDYkrtXmDH61YJ6sOUdoGuhe8bAvXVStv6UYQHlXoEHN
         P6kUnKPUoAAoOLC4dnauYDG0DpxxB0VSJj/fIEb1z8BbaoN4+t7cfbw5x7+YaJiBpl87
         J2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694726408; x=1695331208;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YO3ZTyHFm+00gT95r949gZji8+XYvbCsq+dhsmDC+Ok=;
        b=so64hajUTA3oCWdnto74YgsSh78EHttNsybLk+Tlp7kJKhdbwdAHGocxGy0z5ItoKQ
         HfrTUy/l/p0LQufoI0n4CU7iMR6rPZaeXGnEsfGrxKp1znl8wgNGm1DTv2RHJ/Bq7OTH
         9zDcACTO3I8fz4EN757lD47jkwxUjRCyWxxTcXaJVXgq9Z8oyRqRjcTDh3edzQ2v6eIp
         Ehld6a4pXHq85EhD1M7DzffrOTdLhE7BvzC78znnU20Im9eZErtkUXX2cP/8240OHp+B
         eJDt2Y48CCn83DLquc7JqqCBQOgeROeLabeg6dhifeyoWHprwOqzVli8yCvAXMIwgKPC
         wcNQ==
X-Gm-Message-State: AOJu0YwGZ6TBjCFsdufqee5pU4UEUtE3eoW3J9lQgLz72asALYNcd/dK
	DZbuFWhCN29vzTHiV8yzF7R4BK50jBYZ
X-Google-Smtp-Source: AGHT+IGCEX/KOyc+NQTtFfPYAWgFXG6kDLqyIKgl2lhi89WqTIgea5kl72TnA6Q8vTJoreHIXz9tXTcmvDM3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:5357:1d03:3084:aacb])
 (user=irogers job=sendgmr) by 2002:a81:af11:0:b0:589:a5c6:4a8e with SMTP id
 n17-20020a81af11000000b00589a5c64a8emr175716ywh.1.1694726408395; Thu, 14 Sep
 2023 14:20:08 -0700 (PDT)
Date: Thu, 14 Sep 2023 14:19:48 -0700
In-Reply-To: <20230914211948.814999-1-irogers@google.com>
Message-Id: <20230914211948.814999-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230914211948.814999-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Subject: [PATCH v1 5/5] perf test: Detect off-cpu support from build options
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Patrice Duroux <patrice.duroux@gmail.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Use perf version to detect whether BPF skeletons were enabled in a
build rather than a failing perf record.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/record_offcpu.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/shell/record_offcpu.sh
index a0d14cd0aa79..a1ef8f0d2b5c 100755
--- a/tools/perf/tests/shell/record_offcpu.sh
+++ b/tools/perf/tests/shell/record_offcpu.sh
@@ -28,7 +28,7 @@ test_offcpu_priv() {
     err=2
     return
   fi
-  if perf record --off-cpu -o /dev/null --quiet true 2>&1 | grep BUILD_BPF_SKEL
+  if perf version --build-options 2>&1 | grep HAVE_BPF_SKEL | grep -q OFF
   then
     echo "off-cpu test [Skipped missing BPF support]"
     err=2
-- 
2.42.0.459.ge4e396fd5e-goog


