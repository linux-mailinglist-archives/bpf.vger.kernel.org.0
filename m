Return-Path: <bpf+bounces-66333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94695B325D4
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 02:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BF16B632CF
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 00:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B242165F13;
	Sat, 23 Aug 2025 00:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YYfV1iqs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFA513D521
	for <bpf@vger.kernel.org>; Sat, 23 Aug 2025 00:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755909155; cv=none; b=TKCZONThoayaJTW7HhiEuHcpyeN9o0ri2B5MlkBBot2Z4aqgsPbdT4c4hhJLQrawPhaFM6BSac0yvBU2SUgaBLwbTby+fY/QJON9EP+LecTxGJ+AdqJPAgQg0PlQv86/fmqt9ydgQQuyiGWaiHavlJGxLS59l6DwXFmEx/4r9b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755909155; c=relaxed/simple;
	bh=4XYuTBlR6hYwFS1ueXSOzYaxTcNFVQsqr4/c3vmzres=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=fDk+mOZE1kMMfyRu0O0XDhdvDL11hsUJq2Tk0JIrZOnDEb1PupUJKRs8Pt5SJkvmNkLceVPc+Agv0ss/B3hBU0JMk7IYtJxQKvXMTer/e2zHqYA81UiadC8al+2BvERilbvk4f/dkjJ8yT5XGk1znipB508b+Qr6Obur9Ll4RAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YYfV1iqs; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24458027f67so58164805ad.1
        for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 17:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755909153; x=1756513953; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ijg4Ede0urfZx4RJgifti/T7L7s4uVTkA9wvhJHnqsE=;
        b=YYfV1iqs5pb0OBg0tBJiYzaV4wm3vm9zrC73Lq274G2giRvpMbXLcptuXKZXu9VdNj
         6udt/JC2LhZQgQIGqlQh4s73gXRQf4O+eIKsCHUietmCvVI3pmsH/8K5s0ebOfibFg3s
         pPIHikj9h4lyt+0l87fgN7r6hq+zcelrzFE0q2+eP0AY0lTgWgXISjQgbDUR8BLr5LU8
         g0fc/bLcmqIT4QwonTwRFA3r0RrZeHo4+MqLEID/gV+S4VwSrxhT+iGLqj+TOVrFBNX0
         H/cQtApBnxdBFSHA5ult30m43KtzsFygZEs/WSv44LRlsSkYVpVjKpLqjjjAodbkNAoC
         G6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755909153; x=1756513953;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ijg4Ede0urfZx4RJgifti/T7L7s4uVTkA9wvhJHnqsE=;
        b=TxjTpqF2rki3+RYiRz4Co5EfgGMywMrNbDP1oGzfPkkAf/nSYhu5nLPRj6VD9a5DYi
         PF/48chK0oJb7lhlJwUrTR7VUEuxwFomSUZQ6jV2Sm9HSZe6msc4yF2cWQLd6FWgOXvZ
         MMdDaDQ9uPIB2z6A+SLuwcPC3cFrzj+d/frPcxkY2VXvS42EiSbAEJtC8Dx/PZbwvit+
         PmCRC4Fi8NwkCayJmylUCGsxB7wNUKOEpkBxdhAbZrCQF6tGFRPMSu+bitIHRUqlP6ex
         Kfm4P3QhjYi2YxetsNOU2ulbTcXzH6PyncexfhFtwM16gVOAZtUJGTjCSt9thYr9+oM6
         CQfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXICdMrr7mlnNDLjVf7APPtdm5bUYkLhs/DoB1WUxFahxSRaL326tyfuPLIPjGPB/Ofqps=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcplmU8FpM22x8MGqB4qtwzG+kHRzgE9YOBR9HYOSZocYgosQ7
	mGhW+bS9dZQ+WdWe6mKLadP1TR6xVFDJ72dlQIkGtU+gZn5uso+J5Zxvy2Rw31USzQmb62uadzo
	Uc5Kp7+CQYQ==
X-Google-Smtp-Source: AGHT+IGMYeCxsgrlwx1si54aEYiTjcsFA8gfzIiUxjxIYcOIKjCABHao1VnvVTFQKEPtCEduDnI1c7IR/WiK
X-Received: from plcr17.prod.google.com ([2002:a17:903:151:b0:240:285a:2adc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f54d:b0:246:571:4b21
 with SMTP id d9443c01a7336-2462ef49e52mr64510395ad.58.1755909152887; Fri, 22
 Aug 2025 17:32:32 -0700 (PDT)
Date: Fri, 22 Aug 2025 17:31:58 -0700
In-Reply-To: <20250823003216.733941-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250823003216.733941-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250823003216.733941-3-irogers@google.com>
Subject: [PATCH v5 02/19] perf map: Constify objdump offset/address conversion APIs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
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
index b46c68c24d1c..41cdddc987ee 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -513,6 +513,8 @@ void srccode_state_free(struct srccode_state *state)
 	state->line = 0;
 }
 
+static const struct kmap *__map__const_kmap(const struct map *map);
+
 /**
  * map__rip_2objdump - convert symbol start address to objdump address.
  * @map: memory map
@@ -524,9 +526,9 @@ void srccode_state_free(struct srccode_state *state)
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
@@ -569,7 +571,7 @@ u64 map__rip_2objdump(struct map *map, u64 rip)
  *
  * Return: Memory address.
  */
-u64 map__objdump_2mem(struct map *map, u64 ip)
+u64 map__objdump_2mem(const struct map *map, u64 ip)
 {
 	const struct dso *dso = map__dso(map);
 
@@ -586,7 +588,7 @@ u64 map__objdump_2mem(struct map *map, u64 ip)
 }
 
 /* convert objdump address to relative address.  (To be removed) */
-u64 map__objdump_2rip(struct map *map, u64 ip)
+u64 map__objdump_2rip(const struct map *map, u64 ip)
 {
 	const struct dso *dso = map__dso(map);
 
@@ -618,6 +620,15 @@ struct kmap *__map__kmap(struct map *map)
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
index 9cadf533a561..979b3e11b9bc 100644
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
2.51.0.rc2.233.g662b1ed5c5-goog


