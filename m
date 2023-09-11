Return-Path: <bpf+bounces-9672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB40D79AA74
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 19:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A8C1C20942
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 17:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1370715AC4;
	Mon, 11 Sep 2023 17:06:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27B8A950
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 17:06:15 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C40121
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 10:06:14 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59222a14ee1so55437557b3.1
        for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 10:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694451974; x=1695056774; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jM+dJg6+Q8M1FZ5UU9eubWWeg2o94iYO63nHk29mZE0=;
        b=cqu1njkytaLXL7/8cI1UInw/4EjXigL/8mJ9US1MNLyV/Vv+Ycg3aYCo/UQshw7LmX
         b8WTHsxZDHZw00N0HU4CAt8y+Kolf88o+0YXuuldfrxk9m+GpvZQQu5wchpoGXbYNB52
         GLH2OEoNQExO3S2n0A7M2vK7CWWVNic3LxDI2MqVIKrWYgGoQGJcZBAYAU7Q2WscVdjW
         Kl+V7+k+BWMLaIbgrLYUTqvIdoVnCa0qynoI/azz0JQsHf6QIeroiaRQwhYp0GqRYVd8
         N/JizA7dZm8Oe8K3kiLTqiTyYJqlqVDliue9m5ezeslTFoCpLHANsD/II5OhgfaqEzJg
         VH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694451974; x=1695056774;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jM+dJg6+Q8M1FZ5UU9eubWWeg2o94iYO63nHk29mZE0=;
        b=uLiMvIjGhuCLaEakOpq2n43L4/qirEpSqK8Q2voHCXiKOpqwQhqWEbL/fkkH/VzQH6
         tI2CesANsQxidySkpBuMudiUxx0l/30+zYjWaVgElEq+0eKkZouHS3ukVasSkFqpuYWf
         8cHEHQFNK/hfX3rbTJTh6E9zPIUBe05RgG9N83c90KBieiKEkfvrzYvrTI2gUxgpQske
         rEtHToK34gkhoaOz4J81ow5XjxknZxDSLfk9Plq9jJgdaVesrZpgLZBoC8Th7Oh3e3t1
         albVvZBx8cf6SI1ZhnD3I1cxcsfJ4FgStHzULPLI1QGmoYaa5BH+hJl3m2k+T/GiFqG9
         zP0Q==
X-Gm-Message-State: AOJu0YwZ1d/BAhxKly/6b/Nf9YNeg0R2ooAf+f+6T7rB1FXzYYh5P08f
	8iw9A35yvQDqfye/3j1gKajLvZMosWFu
X-Google-Smtp-Source: AGHT+IEf8EOkd7KXi4dLHtAwPVr8ZfIkJi8rUiMAIwb+DURWDmpuxRsLBlZRkx2NkJr+aWBkJOO0mSOsV17o
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6a92:55a:3ba0:c74b])
 (user=irogers job=sendgmr) by 2002:a81:eb12:0:b0:586:b332:8618 with SMTP id
 n18-20020a81eb12000000b00586b3328618mr263769ywm.7.1694451973822; Mon, 11 Sep
 2023 10:06:13 -0700 (PDT)
Date: Mon, 11 Sep 2023 10:05:58 -0700
In-Reply-To: <20230911170559.4037734-1-irogers@google.com>
Message-Id: <20230911170559.4037734-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230911170559.4037734-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH v1 4/5] perf pmu: Add YYDEBUG
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Gaosheng Cui <cuigaosheng1@huawei.com>, 
	Rob Herring <robh@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

YYDEBUG enables line numbers and other error helpers in the generated
pmu-bison.c. Conditionally enabled only for debug builds.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.y | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/pmu.y b/tools/perf/util/pmu.y
index 600c8c158c8e..198907a8a48a 100644
--- a/tools/perf/util/pmu.y
+++ b/tools/perf/util/pmu.y
@@ -5,6 +5,10 @@
 
 %{
 
+#ifndef NDEBUG
+#define YYDEBUG 1
+#endif
+
 #include <linux/compiler.h>
 #include <linux/list.h>
 #include <linux/bitmap.h>
-- 
2.42.0.283.g2d96d420d3-goog


