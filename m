Return-Path: <bpf+bounces-56187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6C5A92DAF
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 01:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 924FC3B0E32
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 23:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D592222C9;
	Thu, 17 Apr 2025 23:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qBrxRa1+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41092221736
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 23:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744931280; cv=none; b=LEIDkBrapcL0+aipQ3texqKndygIaMIaWKAzkNpL9i+GwgacZ7u8gZ5QtcR2/zSdfhvE7TwMqRvmjT18vPSTr16bIUN9zLxv84BOq0tj1qKOQc3YEZ1TeADQMgHv4aFHeNETZtTlI9+uq6KbMKqeNM0otyDDptq+j0ocxtQvQks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744931280; c=relaxed/simple;
	bh=mJQVFLCm9ty84JCDlLg5++0OwAqRrW5FDC64ClqBhO8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Z7RCAXmGvqsY1VpEkn9ePo/0DChXgrC3ts1MOakwV7H4lhSJXOKelxlE1L+xGA+MywF7geWeGbu3t7WlpnzlL6Ue9h9lgdA7IkoSqH4dUb8pmIpS52KLTH6oj6Vsnql7Fdi/I0TxdVZ3G7XJiAlq9gmVITjQ9U5ky0ZZcaYpXKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qBrxRa1+; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3082946f829so1747140a91.0
        for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 16:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744931278; x=1745536078; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PaI5u9A1ZK2E6Bx2qH0e5jW/HFuv3lmW4guRFbw3gqw=;
        b=qBrxRa1+ec9Ws5tbhZ5R2CKAnzVXDEeFJP3B6jGs+HI0iYWUEGJozfy8MqMkuCvm30
         LNOTriykQ+VIw+5RpRWZDNTburKjCrilgYLM8o1Cgf55zOp5SyuMohATP88D+1p8oDY3
         QoIBPiNyELe1l8s/+mhLwro4zdxuSWo7HF7Vz15o+PX1Wht69PY/8bv6M4xZsXGwsosd
         LoEWRbXP2/PfBrbSu25tyUi+8FJtzqeS1s8hoELNJI7j7NDim2EhUR6+czjC6v+ESEQW
         eU7wd5tC5nO+D3X9EI0BMQZPkCYxyet01tI6vxVFm38q1WM+3B0EU5ANIYGnHlEWywqt
         8yow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744931278; x=1745536078;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PaI5u9A1ZK2E6Bx2qH0e5jW/HFuv3lmW4guRFbw3gqw=;
        b=qCBY8K5/pG5jHa7V1cnpdolxMHBnDw6bmHVbNlkIEfZgyA2catz3YUol6nKvW6xYXm
         gvTCaMwzH3xVKqYGpX4ukKaAlIdlEco75usMs90cIPK5JaKXhpQSErZJASaH9VRJCQ0e
         LOcqlucY7xGkfD+qjv7j2fTTcJ1GwJzI8dzDFCHgtD7rNg4BsME0HS+MFWYq3n0D7PpP
         Gvs2bZQsZzbFSc6+J4r1ECkRlzZC4Q8unAzYd9cEuYUx+j343WQ/v0Raamaf5I06OgLx
         i6q7PFOipbZsrUubjkA2OTI4szy7VKbAszyrS2p5IHZCoQyuGjamHJO32fxjONrOSmt2
         utzw==
X-Forwarded-Encrypted: i=1; AJvYcCW2Ndat9XlgxWN2vVQPT8A+VYriVex9uV1UVItW+Nqw2Yhn6ecXaXx6nyHoiwRzddDVL7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxhcf4wwI5aeMfVIsZqOc5Lng2eysv/bGMR+PU8Tf6Q86RgdqJ
	DJrQ5f6IxyBWYqfhdzt5GGDapq+lqzHXRB0gji0JBQHiQY6jLgVpRyvv3VBHoIOVXU+2zuq1tdL
	JYUXDYw==
X-Google-Smtp-Source: AGHT+IF4TiTN8mIjFeWYyjcvH+QxpKzHnUuvBCtLoCycCssQ0z2iMetyKW3xvnPKYvVbL7H/8N/Pe+HdGEeN
X-Received: from pjbsf15.prod.google.com ([2002:a17:90b:51cf:b0:2fa:1fac:2695])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a4b:b0:2fe:b774:3ec8
 with SMTP id 98e67ed59e1d1-3087bcc7f59mr819081a91.23.1744931278619; Thu, 17
 Apr 2025 16:07:58 -0700 (PDT)
Date: Thu, 17 Apr 2025 16:07:23 -0700
In-Reply-To: <20250417230740.86048-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250417230740.86048-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250417230740.86048-3-irogers@google.com>
Subject: [PATCH v4 02/19] perf map: Constify objdump offset/address conversion APIs
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
2.49.0.805.g082f7c87e0-goog


