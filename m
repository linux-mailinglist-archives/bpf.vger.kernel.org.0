Return-Path: <bpf+bounces-10670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E80F7ABDE3
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 07:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B4D4428287B
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 05:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE1F525F;
	Sat, 23 Sep 2023 05:35:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CE920EC
	for <bpf@vger.kernel.org>; Sat, 23 Sep 2023 05:35:53 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F1B1AB
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 22:35:51 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59e758d6236so54227747b3.1
        for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 22:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695447350; x=1696052150; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/AfDeYd3y4U8gp4T1+0CLrDpr9vwqimMAiCox+i0+u8=;
        b=Hn3VBRTiMJEEBkI6gwTaSqQTAD7HGnv4E8RQCSUkonv6Wpnfi1vjgTaAW6uoAQeAwx
         7263ONpjq795I8fZFMhSeZBCwpB9owiYfrWyHIiLIY/feIPcVB9rMqGhbl3Vc4VYc7Rm
         DNTiamzYd454hl0FqI4a8vp6hc85d9eBjYKpcjGfBz74U4hAYMoiY98fxeZZ4/vbThGH
         8PYqAr7bFnGktPi75mKyuUtmrEyyiMyuhg0MhE+JSyYoJfByQh7V0nv8oGvxXeHubo1E
         10H9A1sMzCjHb733vIxDNbmZxXlM1AoIulRLEKc0MwYh4EoIXnUAkPZGuv7XK2qeijVH
         AUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695447350; x=1696052150;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/AfDeYd3y4U8gp4T1+0CLrDpr9vwqimMAiCox+i0+u8=;
        b=uIXefiJGxwuLhPC/0rqbxM5fC+KsRNB1ubkqPYwepfIeHa/s9baX6NCi+oFuGdTOrL
         KOP0OKXBmruVpCutsm2cS3dKZDop5KfOWHQdkcRkLH2LqXdbufB/dyGPaPIbGHwczTd+
         f/WYEc63Ihii/ReQxl404dZtBeZW/lxhlylVbVjgJClqipb6xyhMYegGdf6niiKGMyXO
         BpOmPn/Z9Qpxpx7/Byu3YgvH9TNmFI6/sL72XUk1XCE85pyMnbT4UtdWtU863Desl1iy
         JU4nCY/PFNcfiq2CFQuSK3Z6PXj7iZkEyDRrbWfBrhMdr+Ujo+A7L6RxAXs4BwhhKCbG
         Ku5Q==
X-Gm-Message-State: AOJu0Yx/Rg6u0X4sPNJbIaVECm1IMrV+GzIksoFZH1wyfpxLQ0lNJo59
	frR/zKFw2xMDag5/voECiiT+KmCPDCQE
X-Google-Smtp-Source: AGHT+IFEnjvrFYTzzkb1dI9/2klEiZwWev3gToYu5hzr8ovZWNcWhYoEwlz8DIZQ9Lino1g7YG2kJaYO8amj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a376:2908:1c75:ff78])
 (user=irogers job=sendgmr) by 2002:a05:690c:72c:b0:59b:d33b:5ddc with SMTP id
 bt12-20020a05690c072c00b0059bd33b5ddcmr20810ywb.4.1695447350168; Fri, 22 Sep
 2023 22:35:50 -0700 (PDT)
Date: Fri, 22 Sep 2023 22:35:03 -0700
In-Reply-To: <20230923053515.535607-1-irogers@google.com>
Message-Id: <20230923053515.535607-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v1 06/18] perf buildid-cache: Fix use of uninitialized value
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
	James Clark <james.clark@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, llvm@lists.linux.dev, 
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
2.42.0.515.g380fc7ccd1-goog


