Return-Path: <bpf+bounces-29336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E77748C1A30
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83CBFB21E50
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB62F1847;
	Fri, 10 May 2024 00:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V4Rr3vEU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EF87E6
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299508; cv=none; b=NsrOUXKZLJr3ekqJWKSo8CaCD5lwUNeRVzTDvCRynVBH+X2UGISlfh2XK8vyDRTmfavo1GBd1Ls7tKoFWKZ/JEeWdtGcnRjQOvuPBaud7j8vj7LzfbR7U36DUCEDOKAAt1eHBGD4Y1IXuGAtUCm9KD/MQxbXBI/dqkw8xYpWKKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299508; c=relaxed/simple;
	bh=EavCetVSCgCq8a1RaVsXoOaflK2PYWCs6cIGsY45SPs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=F7UHEg+Dm/69bIsgbvV8yLRkcDuXQIKd6G0m2qdJEvefBYAvFoTJ+ppelcxWE/kTUSz2+FBvnXx25pZOVeF1ftghUrZeNoWU4jkmvj8EtzDEJxXy/H21j1dAForNCO0VqqdyQT7eWXLmjMKYXlyCPNbrftaF0fTfwiO44CqqwRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V4Rr3vEU; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de57643041bso2459003276.0
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299506; x=1715904306; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6eqm/BqIluFQHvpRuckwNPKwG5hWXwTVWnnYkmrJGUM=;
        b=V4Rr3vEUcZWKPNh4YW0gJjYQr/4dOw5JseSRg5xD3YYEFpP0Xkw7t7/E+eZqVcO3pu
         59E86u9ohhWvmP6ZovTTGoki4ra03h8dndP7byhPDoAikm3V835l40RqrOfAlD4PwASd
         ubtIoHXl0KU+6LgGLMaR0AQ2xRus6ooyVctjt1aAkfVIFdCjIQHd3XCSsLCOCNLQhrpP
         O4EweZ3Lu+EUcrk1j5vjDfUWxMJNRosirtE7GPMndqBN/nEJHd0f7Ik0Orfd0UvTy4XM
         UuivO139DEYuhS7TAJaQvEmFe7ynt3s2NDNkeZ474PQdDMqOEUqmXhNmaCaLmkHnfWwW
         YLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299506; x=1715904306;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6eqm/BqIluFQHvpRuckwNPKwG5hWXwTVWnnYkmrJGUM=;
        b=TwhwAX8ETpO+dx0cQUXNa2hgzKH6JsKhbJ79xFNk2Ay7GIvQcZf5kXlKv2VFTo+WKw
         Fo9E8XgqQnYxnbvBAZemchf629ESGzkbTisxQlS719R+AANWnS3uKAR/p5Ff5gNBeNV7
         p/mMMDY4njuEq9Os6oP3U7T8aBVBDlJ9cI8ZeRPlfWYOQ0fHGXp5OobnVun5tJoMUoLM
         y1hTXPIYjzH7nZD0MTBsudN4slInvKIQVZjtaisqEzUDHbTz9OU0S9BoUOda/bSeH2L9
         COu0ZFR+QyPsU53AlIs19hGUU0QJWCeNO6IZV0Z3c8U5EC3P1wh58LsdSRcM4C3bbpYf
         Ka6g==
X-Forwarded-Encrypted: i=1; AJvYcCVPXflttUkO1MdbD94aiYTfmerNg0rRueLW97fIySsQLkzuFGEV+GszcAuNB0Z94HvKy6hiLAhbN0eMEHhcwfw2yqk3
X-Gm-Message-State: AOJu0YwEZ53Ki7zgm1qzaexhyM3No6PqFBCaw5kLZsM+GFN6T/Uhr7a1
	4zlnQVFHwV+GvXD3kCu9/2R+Dx3WI1fOzBc490NQDC6cNZwIDS6zasQUW2lCGBinKhpCTfQb/VU
	J
X-Google-Smtp-Source: AGHT+IHWZ1QbRc7CocmE11JfF95PsYEf4cv12KCkp3UCAxnICrsEj6dkC5JTWIEWOGCF8OhmKEJRJ8tMNX4=
X-Received: from yabinc-desktop.mtv.corp.google.com ([2620:15c:211:202:1b7d:8132:c198:e24f])
 (user=yabinc job=sendgmr) by 2002:a25:7486:0:b0:de5:2325:72a1 with SMTP id
 3f1490d57ef6-dee4f192850mr277203276.4.1715299505730; Thu, 09 May 2024
 17:05:05 -0700 (PDT)
Date: Thu,  9 May 2024 17:04:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000502.1257463-1-yabinc@google.com>
Subject: [PATCH v3 0/3] perf:core: Save raw sample data
From: Yabin Cui <yabinc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"

Changes since v1:
 - Check event->attr.sample_type & PERF_SAMPLE_RAW before
   calling perf_sample_save_raw_data().
 - Subject has been changed to reflect the change of solution.

Changes since v2:
 - Move sample_type check into perf_sample_save_raw_data().
 - (New patch) Move sample_type check into perf_sample_save_callchain().
 - (New patch) Move sample_type check into perf_sample_save_brstack().

Original commit message from v1:
perf/core: Trim dyn_size if raw data is absent

Yabin Cui (3):
  perf/core: Save raw sample data conditionally based on sample type
  perf: core: Check sample_type in perf_sample_save_callchain
  perf: core: Check sample_type in perf_sample_save_brstack

 arch/s390/kernel/perf_cpum_cf.c    |  2 +-
 arch/s390/kernel/perf_pai_crypto.c |  2 +-
 arch/s390/kernel/perf_pai_ext.c    |  2 +-
 arch/x86/events/amd/core.c         |  3 +--
 arch/x86/events/amd/ibs.c          |  5 ++---
 arch/x86/events/core.c             |  3 +--
 arch/x86/events/intel/ds.c         |  9 +++-----
 include/linux/perf_event.h         | 10 +++++++++
 kernel/events/core.c               | 35 +++++++++++++++---------------
 kernel/trace/bpf_trace.c           | 11 +++++-----
 10 files changed, 44 insertions(+), 38 deletions(-)

-- 
2.45.0.118.g7fe29c98d7-goog


