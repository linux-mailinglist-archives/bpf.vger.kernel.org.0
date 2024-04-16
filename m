Return-Path: <bpf+bounces-26897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DB08A638F
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 08:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93011283BC7
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 06:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABD66F077;
	Tue, 16 Apr 2024 06:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d7dsJHEw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD286DD0D
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 06:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248162; cv=none; b=IR6XTxqx3Zmod3+j0UbPLl4I7QW+wajfS8B4Y8IRBX4z/WVX5Yoj5ioDFxgLdF0wcjqFAHedjLZb7JBLDmoORcfR9aByM3YyGyNEqIJZTxB74SVC5alP2mxnRPHAVmwirC5CGWwyfRBgErVRLMRHTKeMqj2W80PA8O61+pKJ/6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248162; c=relaxed/simple;
	bh=lOkYV7UGjD7uAxaUJi//kJNpEQe6aaH4534slbGiVvI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=C5fphLrirqyE0vsRXWCWc9qN4wmRsHgi/sv54DIDF3PIiHNglzWubFpcl2d8ucoeYuLnN2oCrs3P0BohFPGCoQH134vMJjH0Edlltd8h1xo4SL5rAQZ3w2R7KQQY2Q3xdEo2+8lsNES6suXo9cn1AQDxwIYKoCXvaNeB8bhbEPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d7dsJHEw; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6150e36ca0dso59251557b3.1
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 23:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713248160; x=1713852960; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ykRC4diMMUuCn1traUy9Psb15efHJHW4XPDrKAUvlVg=;
        b=d7dsJHEwoGbzVJyhb9z95qeHkUoM0lJlG7dgYzjC0nKumwiF9wshNHwulLAaALs1y9
         jHnga1kxnggAaAfEoNWXwaKwUVOtpx+NdEu3do6aCIkaz68EGsRw+Pup6+YsdCAqIUAH
         XX16xlHkYQk1TcR0INwF2gq7xiR6zfiEagUKEhCLgnaBx09kT7/HQ8DukDzbGNU51QXz
         V62WvmwExH/b+qncoP+EujYRak7QHyReivee7q2NmZCibjFkJgachDStOpWYHtsTTgxS
         8iUy88wXyBVm4hzDWcHFk5r+GwXwCCkeh57Qo7RRqZfm8sGfvOLv6/xYzgqFdWTBzzG3
         /OCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713248160; x=1713852960;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ykRC4diMMUuCn1traUy9Psb15efHJHW4XPDrKAUvlVg=;
        b=isbzMcDDLT51y8UX2P+3v2flKr03EgpEx2sSUNSbkoh4iwbad1tSoAaskn9q2tH3eO
         3ApmK8xIkdYh8ZnrxySDnPS8tMipnry3mYKFgN+4BJXuxELnMS3b3W15Xw4zBF8TW/oJ
         Jtlg1ZNygU3NjU3gBqmDS4n97ZilkCY2zrMOsMvugk4LH+EAiJNgbi10i86CF6Woug1G
         nWFc5dp6q4ImJYgkbrI9h+L58607oWHf7XAaxK7mFrpzvMx9pbvAyVUDfw8phmKiT6mu
         83cKUuA0VCUx885Brw8XEOhmarOfFrvYPyeJfV0msrD1kBIJ0Eqhx7r7T/VA5aAuVZaP
         cXeg==
X-Forwarded-Encrypted: i=1; AJvYcCXXTXl0A84kUfEqi6E3ClwsdCulLT/HX30Ur/zXNs+6k+YmR9ExrQOoVeKivzjZ2hl1uQ4rWtP6Gnyos5Q2UexCYwmE
X-Gm-Message-State: AOJu0YyG2pbprfqoTv2GtB5uhJgTWX4unUygWkwmtfx/ubzv7c4vGm8X
	JsGFfd5W2tBPXumvDYDRA/G8mm7m8MkKYBivYlehy6Q4fYvVdgYpDzRlTXK4ftcZzacv49XGvW8
	rS+WQgQ==
X-Google-Smtp-Source: AGHT+IE1BkM8u1uMxF/LJ+oAvk+/Ck61XwF1nrFOd9+nZTm6s22+JsAiR5ckes/nbIKLU3LTA7VFsn18XwaJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:30c8:f541:acad:b4f7])
 (user=irogers job=sendgmr) by 2002:a0d:d44e:0:b0:61a:d0d2:b31 with SMTP id
 w75-20020a0dd44e000000b0061ad0d20b31mr1012904ywd.3.1713248160541; Mon, 15 Apr
 2024 23:16:00 -0700 (PDT)
Date: Mon, 15 Apr 2024 23:15:23 -0700
In-Reply-To: <20240416061533.921723-1-irogers@google.com>
Message-Id: <20240416061533.921723-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416061533.921723-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v2 07/16] perf parse-events: Handle PE_TERM_HW in name_or_raw
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org, 
	Beeman Strong <beeman@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"

Avoid duplicate logic for name_or_raw and PE_TERM_HW by having a rule
to turn PE_TERM_HW into a name_or_raw.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 31 +++++--------------------------
 1 file changed, 5 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 7764e5895210..254f8aeca461 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -603,6 +603,11 @@ event_term
 }
 
 name_or_raw: PE_RAW | PE_NAME | PE_LEGACY_CACHE
+|
+PE_TERM_HW
+{
+	$$ = $1.str;
+}
 
 event_term:
 PE_RAW
@@ -644,20 +649,6 @@ name_or_raw '=' PE_VALUE
 	$$ = term;
 }
 |
-name_or_raw '=' PE_TERM_HW
-{
-	struct parse_events_term *term;
-	int err = parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_USER,
-					 $1, $3.str, &@1, &@3);
-
-	if (err) {
-		free($1);
-		free($3.str);
-		PE_ABORT(err);
-	}
-	$$ = term;
-}
-|
 PE_LEGACY_CACHE
 {
 	struct parse_events_term *term;
@@ -710,18 +701,6 @@ PE_TERM '=' name_or_raw
 	$$ = term;
 }
 |
-PE_TERM '=' PE_TERM_HW
-{
-	struct parse_events_term *term;
-	int err = parse_events_term__str(&term, $1, /*config=*/NULL, $3.str, &@1, &@3);
-
-	if (err) {
-		free($3.str);
-		PE_ABORT(err);
-	}
-	$$ = term;
-}
-|
 PE_TERM '=' PE_TERM
 {
 	struct parse_events_term *term;
-- 
2.44.0.683.g7961c838ac-goog


