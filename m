Return-Path: <bpf+bounces-69972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9988EBAA68C
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 21:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD9119219CD
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 19:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CEE24678C;
	Mon, 29 Sep 2025 19:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3OUGFkW5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73F5246789
	for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 19:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759172910; cv=none; b=qMwmNFB20uiCZnwN4ABvZVLcIOP2IDW0w5yXbNIFoN3Tal5PhWPH66OfzZ4ISOU+d5TXh+jSsltDc5EYt01A+DN+Zl+86jkY12ypKztkeTxrApK2zPY7JZo9TdjJS4MR4qxr+dTL21Y7yM/ZquQgSvpmsG3lRSSBpKZIjxFZm0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759172910; c=relaxed/simple;
	bh=jts437rB1GIJacBrxxx4epa/L3BnkDASSEk1qV6a9yg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=kUfYoTPeI4LmxvKyCLNzqnEz9FZwcv8In1zhOzbTDoCfPdPmko9FDP7c3Wabg9PJyrWByNxadB2qZmE/JXOcOdOLvEPBjfBq4Lc6fLNUQ1dgE46KYnTV/4P9RTppncT0iksK4US3RbnM2HVO/YhOZH7kvUGdJHnWQQZfoSFQMk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3OUGFkW5; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-272ed8c106eso31941625ad.2
        for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 12:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759172908; x=1759777708; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cCPSZa95CLjIX1ekaMXSBPwEqC8hhuYwGZNsoeQYOdI=;
        b=3OUGFkW507sLNe0htroiKFxKbJl9huWN8KXqz/TxarIf1pyl30HMcf7jVTrBdGn1pR
         8AeqCGvJfaZVz17LrzcCi6dOoyz4XV5w/aHXTToAYjheflhL+ID510+QABES6ARXMm7x
         Vrzffe1Wlx5/2m8Xav/c64EoL580fAGPwUjA0RSqNe99lo8YkcWrjKt6qpRAztleoYl2
         ZIHmTIYwRSESxnBaZ3+a3H6krSAsig18WG1FtbG7D7e23ZpQIeN3MI+gORr8u2iYo54h
         FVQCkNZ1UimfpI4170pAUzTPv1cLObVA3EH02ecZfSLXMe+vIHZjyImRmUhUPnGneaTS
         As7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759172908; x=1759777708;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cCPSZa95CLjIX1ekaMXSBPwEqC8hhuYwGZNsoeQYOdI=;
        b=lr5YDdzCTMnTRSeXpzQ5VM03aLBWqQL2pTPzlc8JO4/VPwVDNc/77UUV943s/ZFega
         Bu12YTITZoxlMxt/xd+LkHeTCd4TfWOTSR8COrR29jzLj9r2oM3VjX0q7RwS/9PD72Md
         Pg+Ybi7DlRibHF3IgrWS2yY3JMivgnumCQOXgNqflCLidpPtp7rPN8+LX3wedvOviw51
         ToaksnDkSSXfGgFeEXWwslD1H9nP39/e2V1vJM3WTPZ1i9E+oaxO3dnag0E4h+cAwck6
         toY4vtbHjBui2IPNAq8JpyBCopWNXLFrGEaZe9w754GGu+cPAyQAc0bENURIAiZd5n8f
         aytw==
X-Forwarded-Encrypted: i=1; AJvYcCW6JxbrsQaT74GoRM3y21TkROm5zzoV5n1y+COB1AljoFTtKYkVVU2aS/rGu0+fFZUN9wM=@vger.kernel.org
X-Gm-Message-State: AOJu0YysW2ydS/sdilBkcRZMl4V4tTs6+qdjo3GHdm3xiqSClKIfpphI
	EIdWUojCP+QgFD3d15RaWatZi8at4IwyNWSmNXUk5qTQw+ZKeJkkZVrHJ/xyb2Q0WrdkqJacqp/
	KK+I/7RavuQ==
X-Google-Smtp-Source: AGHT+IHRqf99uJlVCyIDD61PqSw9guLbG8f2axDFVLPxmfvJQ46Ggtr9CTWOji6+cSZrHK7d8OcAI0/g0sj4
X-Received: from pjbfh12.prod.google.com ([2002:a17:90b:34c:b0:32f:46d:993b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ecca:b0:269:8d16:42d1
 with SMTP id d9443c01a7336-27ed4aac32cmr171706855ad.50.1759172908198; Mon, 29
 Sep 2025 12:08:28 -0700 (PDT)
Date: Mon, 29 Sep 2025 12:07:51 -0700
In-Reply-To: <20250929190805.201446-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250929190805.201446-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.570.gb178f27e6d-goog
Message-ID: <20250929190805.201446-2-irogers@google.com>
Subject: [PATCH v6 01/15] perf map: Constify objdump offset/address conversion APIs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Collin Funk <collin.funk1@gmail.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Li Huafei <lihuafei1@huawei.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>
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
2.51.0.570.gb178f27e6d-goog


