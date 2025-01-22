Return-Path: <bpf+bounces-49503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1223A197E1
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 18:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5338B3AC580
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 17:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3807A217661;
	Wed, 22 Jan 2025 17:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aFoQ8dvF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EDC216E32
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 17:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737567799; cv=none; b=PfxLUqgyx4TucfNpJZO4W2HX9tL4gY6fCYUgCd9d8NJlk3EBSfx/02z3GSV23OXpz0pfk9EY/gn56fd/tDYH2LN3CQXHfsXpm2OiSwgMaMDtD2O0IPNDZ2oLYhHamBMoyQC1tBp+dfxNnVO54qj8qEgs8CT15bH6gRo50Ob7WL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737567799; c=relaxed/simple;
	bh=WJt5cb/0k5W2nwh1HNJ6Jogn97hrB3OoERDCfCptbfM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=V8UhRHeZ9v98KLP+fze/CHQGLHFyjZ/XW0nAm48FfT3Za6yi/P5bl8BFGTTTxB8xt/OXEjkxmQyA9w9z90hUhaWthEBYgKf3kLdur4v6RNk+iW7cmRhTCqF2s/pXzzBvOB0sXjfhO74723NtuYAmXCSmklRTH6lCy+PQ0fPhqkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aFoQ8dvF; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e5738e8d116so9863276.0
        for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 09:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737567797; x=1738172597; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zcjBK8L/P8OV6edsjSeaFLzzE6iK96Z0X/N4sZi7ys4=;
        b=aFoQ8dvFjCFspyzqHjC/k7PlMcAYm/Lfv6N9p/h42M7ArJwXbi7PvbK2Iuhg667IKw
         8V2E6dIY3BvbTbSL9nDZL+so7JciPJsG+hUKLtzMt/BqAjMMbzjeD89fwVuAvIJSMedj
         TsAtgdNxWMxKJb29Ehrb8oDeg16/tv5Rvtj8QYenho9O3nDFm+dGBjb4MGG3g0taMS33
         z9cACnnQehtm8BJsSRJux6ke5ZDjdWanaehWiB5N6BHr4aOULzQhRfvhj/REUEnEz992
         7zaiJllbfJG6yoj8lZfBPGs/Bs1w/Ta3dnztxoQ9db7tLxVI1bGZEMHDMWheP6OP5QS7
         I8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737567797; x=1738172597;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zcjBK8L/P8OV6edsjSeaFLzzE6iK96Z0X/N4sZi7ys4=;
        b=bIPPZ/f+sBzeiVej40QcLzdR759h+UwrntOvCdcQ7WHEdYC8dtR5knZEz7cjhQixRQ
         dHOmDWvyJYJYLtN5lHX64BNVRghAXvbXxbV4/oAgAIyhIb0Dp7nxpIAP28r2L9A/i5ql
         wcqEKmjW2/5FWbC4OrBkptPMrLx/Lr7ThUYDOONZIUWTSDZIDe8JzVo6MT7qdxBi9FYU
         2DNKUc4bZnzbNkij3PYKCgWcs2czkAlnm2hif74MhxBSqGrWC7c6SGJvxiHSaXbrWPGb
         xkiShTOVb3UiKNFGDLxSWzFadA3tdoF8PkD3JXvl8Iwn3HHnXv0TdQ0rFVMCVsEOJHBy
         wJTw==
X-Forwarded-Encrypted: i=1; AJvYcCWVdRERX9crCFuJ/hsZPKmJ8gzL+KK5sXBoDSHUmonBD7SU9mjSKy1sPX5GC9uxgulSe3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWb/PfxVYXw4QZA92ZA7fnBCLdl0CoxFiVCK62Q3v2ww9qB5/X
	vglzaWv198nZ/FHPH6UuycGAKmeBEbNolqr/wU031eC/WuJkUVHIvGc2i4zesK0kjQzBcQDkfKu
	bEVyPFA==
X-Google-Smtp-Source: AGHT+IGck6iBXWnNQNNAFess+zdbWD1500PKjbeASn2i5vUzvBiLOSAywNQo35XWkC8hVAcuERbytCMZU2Ub
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:807b:be79:d5c3:ee5c])
 (user=irogers job=sendgmr) by 2002:a05:690c:6211:b0:6ee:4b9d:df44 with SMTP
 id 00721157ae682-6f6eb947731mr567087b3.8.1737567797019; Wed, 22 Jan 2025
 09:43:17 -0800 (PST)
Date: Wed, 22 Jan 2025 09:42:52 -0800
In-Reply-To: <20250122174308.350350-1-irogers@google.com>
Message-Id: <20250122174308.350350-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122174308.350350-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Subject: [PATCH v3 02/18] perf map: Constify objdump offset/address conversion APIs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Changbin Du <changbin.du@huawei.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Make the map argument const as the conversion act won't modify the map
and this allows other callers to use a const struct map.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/map.c | 19 +++++++++++++++----
 tools/perf/util/map.h |  6 +++---
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index d729438b7d65..a22a423792d7 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -514,6 +514,8 @@ void srccode_state_free(struct srccode_state *state)
 	state->line = 0;
 }
 
+static const struct kmap *__map__const_kmap(const struct map *map);
+
 /**
  * map__rip_2objdump - convert symbol start address to objdump address.
  * @map: memory map
@@ -525,9 +527,9 @@ void srccode_state_free(struct srccode_state *state)
  *
  * Return: Address suitable for passing to "objdump --start-address="
  */
-u64 map__rip_2objdump(struct map *map, u64 rip)
+u64 map__rip_2objdump(const struct map *map, u64 rip)
 {
-	struct kmap *kmap = __map__kmap(map);
+	const struct kmap *kmap = __map__const_kmap(map);
 	const struct dso *dso = map__dso(map);
 
 	/*
@@ -570,7 +572,7 @@ u64 map__rip_2objdump(struct map *map, u64 rip)
  *
  * Return: Memory address.
  */
-u64 map__objdump_2mem(struct map *map, u64 ip)
+u64 map__objdump_2mem(const struct map *map, u64 ip)
 {
 	const struct dso *dso = map__dso(map);
 
@@ -587,7 +589,7 @@ u64 map__objdump_2mem(struct map *map, u64 ip)
 }
 
 /* convert objdump address to relative address.  (To be removed) */
-u64 map__objdump_2rip(struct map *map, u64 ip)
+u64 map__objdump_2rip(const struct map *map, u64 ip)
 {
 	const struct dso *dso = map__dso(map);
 
@@ -619,6 +621,15 @@ struct kmap *__map__kmap(struct map *map)
 	return (struct kmap *)(&RC_CHK_ACCESS(map)[1]);
 }
 
+static const struct kmap *__map__const_kmap(const struct map *map)
+{
+	const struct dso *dso = map__dso(map);
+
+	if (!dso || !dso__kernel(dso))
+		return NULL;
+	return (struct kmap *)(&RC_CHK_ACCESS(map)[1]);
+}
+
 struct kmap *map__kmap(struct map *map)
 {
 	struct kmap *kmap = __map__kmap(map);
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 4262f5a143be..768501eec70e 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -133,13 +133,13 @@ static inline u64 map__unmap_ip(const struct map *map, u64 ip_or_rip)
 }
 
 /* rip/ip <-> addr suitable for passing to `objdump --start-address=` */
-u64 map__rip_2objdump(struct map *map, u64 rip);
+u64 map__rip_2objdump(const struct map *map, u64 rip);
 
 /* objdump address -> memory address */
-u64 map__objdump_2mem(struct map *map, u64 ip);
+u64 map__objdump_2mem(const struct map *map, u64 ip);
 
 /* objdump address -> rip */
-u64 map__objdump_2rip(struct map *map, u64 ip);
+u64 map__objdump_2rip(const struct map *map, u64 ip);
 
 struct symbol;
 struct thread;
-- 
2.48.1.262.g85cc9f2d1e-goog


