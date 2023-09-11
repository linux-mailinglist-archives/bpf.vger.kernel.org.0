Return-Path: <bpf+bounces-9669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3B779AA71
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 19:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3DB91C20432
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 17:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191FD154BE;
	Mon, 11 Sep 2023 17:06:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB2F156C6
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 17:06:08 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BB912A
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 10:06:07 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58cbf62bae8so49917337b3.3
        for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 10:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694451966; x=1695056766; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B+1JF0nXPGoS/vVdsOZGIJs7CEBRG2VuSy9rJAtNprY=;
        b=5BE5OcUUXBss0ejL7AyeJWL0MVOiaWhzHM7YmpFVYa7AUDz/z26MI4nTsRql0+s5gx
         NmKvOyRNZc1KrLdWGpIxSKEawR2SLmZ+nCL014P9ikwZ78f3LN+PUudDS/hcz9op0EJy
         bBMWTDpVqmkdLkDmWwr7MK/CA7eXeg33zQaaimfrqdlPxs951euiwm9ByI0MMGnPekSa
         TVv84rz9pIQHh+v701zV153HB5a5Fpcsy2MDxLcO1EvrBQWJbHNYWtMOUslXGgD6c20b
         Dyygp2aZGAAMVddit4/ZSIaOIgN8tmT0uVbWvY5Cj8XXGs1tuOUb94UEPiUwzb5Nj2Hc
         WlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694451966; x=1695056766;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B+1JF0nXPGoS/vVdsOZGIJs7CEBRG2VuSy9rJAtNprY=;
        b=gjvSbLY6UOeC2076Sp+okwwuG79K1cOGT3DLJ9XLRrCyjIbCYrlqTlspRJ5DJiwEYC
         XRc69kRj+9N1wTZY+TI3qBt5E/Ap2yEb+awETsNKlna/qSv/a9GC8ulEvom975EjZ4Uz
         u7m9Kjsit7xaS63z+qLRyUl4NRh4FS6sSVC9unwWdNc3ToEjUD62q/HGEGpMiVxkYbHC
         OShz1yaBKQMwvkxxwMSBxBAtd4HprhHEwqGaN0gFMzQahRAI5veQNzZA41PJmA4n40LS
         B1NP3GVJX2qmXlnfUppX+dSAcbC+se8tklfYN6WGxWocMhfTMlBmeynYW2jy1kIy6mcw
         JTXg==
X-Gm-Message-State: AOJu0Yw6HocvcaA0vUUg95rGa/4iH58MFazjP4XMuODLWTfbNzW+6FZv
	o0EMl4jwHXXtGn+irv39MG6bc6NFQdxA
X-Google-Smtp-Source: AGHT+IEYi4t5k8LUPrFyZM7IByX5LTESJDfzfvk31cVZDMoClizybOgg9g6ptBh8r+jVlC5Vjlvh5W/Wtdhm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6a92:55a:3ba0:c74b])
 (user=irogers job=sendgmr) by 2002:a81:d441:0:b0:584:3d8f:a425 with SMTP id
 g1-20020a81d441000000b005843d8fa425mr276417ywl.10.1694451966387; Mon, 11 Sep
 2023 10:06:06 -0700 (PDT)
Date: Mon, 11 Sep 2023 10:05:55 -0700
Message-Id: <20230911170559.4037734-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH v1 1/5] perf parse-events: Remove unused header files
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The fnmatch header is now used in the PMU matching logic in pmu.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 21bfe7e0d944..ef03728b7ea3 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -9,11 +9,8 @@
 #define YYDEBUG 1
 
 #include <errno.h>
-#include <fnmatch.h>
-#include <stdio.h>
 #include <linux/compiler.h>
 #include <linux/types.h>
-#include <linux/zalloc.h>
 #include "pmu.h"
 #include "pmus.h"
 #include "evsel.h"
-- 
2.42.0.283.g2d96d420d3-goog


