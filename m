Return-Path: <bpf+bounces-49442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D71BEA18BE8
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 07:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18A8A16AEC9
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 06:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C621B87E9;
	Wed, 22 Jan 2025 06:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OEcwJO/P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7320C1B0F33
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 06:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737527045; cv=none; b=PBXGLegfMh4l8FwJ7Cnz+Q04/ybOvMe94U9XWRO4NkhaMWEMGEtZdnsFZP8cgAfe680h2rtBgquKjVO7tmSrunxhpMbrSZjzeHg1+iMAZPh+SG8C638k488824GmxlPYdGuyarZnAA/KaZTZspMc8rgYRmSrepE0yT8AwnNZOWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737527045; c=relaxed/simple;
	bh=Qmq55MBFFDlIdUOT+YCdRI2WTxYpsmxURFZ8UOnIG5k=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=TKyUPX+7CUgoQq7JnMzQOat0XDGB6Q3gntjca5TdD9Kt6fgf2NEzUzXAVBNeVblfOF4xyRx1mna63XY37X28QkHwvmqVgQB4UCHamuXATlgs+HWS1qjzfaGtdAskAlyct2gHkhC+1ETyDwUqa38/jbpRZ57qMAZqZSV6Ydz2YnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OEcwJO/P; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3a0f608b88so14681857276.0
        for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 22:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737527042; x=1738131842; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kWzjT8BGnYGxE3H8fS5inyNnD+mPb+JDTto8cogfHm8=;
        b=OEcwJO/PcJ7tCjmdFyihQKTJaN5sxCvk7mIuXM2aKP7ArHVL3TWemg1jcgWQouMca/
         JM7ZXjPYR88nyOpGvf99pk4JBPbHtxzmIhMNB66zqBXKlcqx1ecBgJze3UjTPMWfMl7r
         XaXXnOnsytFzllX6bRFYr4nd3A/H2pqF769GaBqVmsep+H/j+Q0JibbkxKPpRBeYCXCo
         FBPQS2tI1wxEIQZYOGYCaJTvZvjevQQ4RY21JUL8bijKww3iNvuyUd5saq2ihQoWAS+M
         u6sgTQynzJMoTbThTtdPzSelYcyY0Qp28QiG86/B0KEzNJ7z6ZpO5Gju/QpxHOhZciVA
         Inhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737527042; x=1738131842;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kWzjT8BGnYGxE3H8fS5inyNnD+mPb+JDTto8cogfHm8=;
        b=rADtJL5BuXP70F8cwrOO7NU+NHWhH4nHHLnMuRRgIer1LsdoqDjftjm2ty9pD6zSfA
         w+XtvM4h6K/++dqRkgzajWqzHS+vFa4wQ6vupHTFTclYtyt4ENu5idcclLPNdzZobwEu
         /D8WpJEVkno+jXD12TGDIlp7QlNqk1dA9oaiZR3Eig1S/OHzkpyUbywWmzV36ZXOJIVZ
         nKskO7JZxiw2yMl/Ml2GgxBKh0D11H0HHKmldRtyXqP69f2jEy278DWc+sP9rKjeGPKt
         yIp6zyepNulmWy0KXPIBkFRB+8vXvnaY0M90YPR7VqnKws9svmvRBJIXe2cG3xVSZe0U
         0nTg==
X-Forwarded-Encrypted: i=1; AJvYcCV+PnmabzYB1g3rqnZnAi1j4qhOjuiETsYCFG9PJXWtztcFQeYgsf2DIoMjoFTQ5rr4twA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx62ydZXjhVlYu9i8PGE34Z+qix5ZUcX5/kEwpgaEyLm2zl+Brw
	J3IxvQQulxpY+OHTYU3/ILVezGTXkGJaOQix/AUOAZvP9toY6mIK4pcjdrpbuq+KP6KtGJDXduz
	WtbLCNA==
X-Google-Smtp-Source: AGHT+IEkQrVl+S1ecATwU/x39/z+G48tsIZyI5LDZqnLUZLk9fS8HATbtR2ta/8MhmTWSqrSAgqjrw5VZEOC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:807b:be79:d5c3:ee5c])
 (user=irogers job=sendgmr) by 2002:a25:538a:0:b0:e39:91bc:eef5 with SMTP id
 3f1490d57ef6-e57b103b91emr42227276.2.1737527042387; Tue, 21 Jan 2025 22:24:02
 -0800 (PST)
Date: Tue, 21 Jan 2025 22:23:17 -0800
In-Reply-To: <20250122062332.577009-1-irogers@google.com>
Message-Id: <20250122062332.577009-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122062332.577009-1-irogers@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Subject: [PATCH v2 02/17] perf map: Constify objdump offset/address conversion APIs
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
2.48.0.rc2.279.g1de40edade-goog


