Return-Path: <bpf+bounces-11497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D5D7BAF12
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 01:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 979D328298D
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 23:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F6543AA0;
	Thu,  5 Oct 2023 23:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PpdONQIG"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3D843A81
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 23:09:28 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BF2D5C
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 16:09:21 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59f67676065so22243247b3.0
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 16:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547360; x=1697152160; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Btc8+OmE4IzA7UOP/eGTa4MmLZMG3XazqMQBeE66ZYs=;
        b=PpdONQIG+l/rnTq0ljQx59wae1i+ix+iFl/DO2P9TSNWJyIxXsdb3HnDxJvOF+w6xz
         RDd7k8qg/CnSYh3xwTjoVqQEmSEbUGPb6Mw1dJqYpN+9O4E+YR1AcxZ4UDoue5gQs62U
         Cex35U4yKYX18dSmKQmK4ml+Z4fohNc/7ib17IecGwKUHWKu6vpFwh0IPK8aHU60XcSO
         +2/jPTxPJ+H3arFgoLIvr3SJqWzuS74tJSa9uwkBmTl+YbgN6twjCy/mLP+M9dMGGqcb
         1zGanpr7tNww1SRO05E1EzUaI1BdXDhLegliVfVDi4Vo2GpnO5v//xlxR7T/zdWddjCl
         /F1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547360; x=1697152160;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Btc8+OmE4IzA7UOP/eGTa4MmLZMG3XazqMQBeE66ZYs=;
        b=BGRnwhi7Qxygr5PaaJ4bW4N00ZaTTKfhslNxykaW63ssgt0jkdriAfXNKAGRwrSH5t
         UUwTHgYjoTAonMWoIbn2zHs2IAOCLPXO7oyYZ3oOD6lJuAZb8+0pIJMrTuTJ/6Yon8U4
         1yLq8Fv+auQZMQaiaXqGaiO/PShznw6jD+OjdD4O/+dHmCg9yJMM70jUOoWFHZ/cvutx
         ZWUqW5axgl05n8byIrmGmKw79yqdGeaQSIM53JDVV+2AIKQDgnyFSxQwT5JbM7D4VBtf
         t6BoxvJDplX7VAdMpEe0BkEhuxMqUWvvPceoLW6I6Nv87Q/f+bCrii4Gs1rtpKYnxrzb
         dtYw==
X-Gm-Message-State: AOJu0YxOjk1q+T+rbJ1s9BCqADcv+1TrVDpUHJ5wZ7UuQjiXjO8N3pFx
	5gSOPr+QPD/ddtRsSXV8LO7dzh3LST5x
X-Google-Smtp-Source: AGHT+IFfAlyuHJuI2G/9KQCu0TQZva4KyspkcFBHCc0rPvHV/9ONdxVJXDxqSyZ675ZF86Wyxy9Zbxra+WAi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a81:bd08:0:b0:59b:c811:a702 with SMTP id
 b8-20020a81bd08000000b0059bc811a702mr118562ywi.6.1696547360615; Thu, 05 Oct
 2023 16:09:20 -0700 (PDT)
Date: Thu,  5 Oct 2023 16:08:43 -0700
In-Reply-To: <20231005230851.3666908-1-irogers@google.com>
Message-Id: <20231005230851.3666908-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 10/18] perf dlfilter: Be defensive against potential NULL dereference
From: Ian Rogers <irogers@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Tom Rix <trix@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ming Wang <wangming01@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yuan Can <yuancan@huawei.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@arm.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In the unlikely case of having a symbol without a mapping, avoid a
NULL dereference that clang-tidy warns about.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dlfilter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index 1dbf27822ee2..5e54832137a9 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -52,8 +52,10 @@ static void al_to_d_al(struct addr_location *al, struct perf_dlfilter_al *d_al)
 		d_al->sym_end = sym->end;
 		if (al->addr < sym->end)
 			d_al->symoff = al->addr - sym->start;
-		else
+		else if (al->map)
 			d_al->symoff = al->addr - map__start(al->map) - sym->start;
+		else
+			d_al->symoff = 0;
 		d_al->sym_binding = sym->binding;
 	} else {
 		d_al->sym = NULL;
-- 
2.42.0.609.gbb76f46606-goog


