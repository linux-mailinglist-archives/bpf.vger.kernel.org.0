Return-Path: <bpf+bounces-26740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32788A482E
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 08:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D636281EFB
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 06:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDE81CAAF;
	Mon, 15 Apr 2024 06:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hcGRw8SM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05A117C6D
	for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 06:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713162992; cv=none; b=K5XneK91JYT5O4n5nhRzrIXXUr3PbfAiU3x0kmfZOaJN2PUkYD2kHiKnjC8CxlCNp1ZBRQYZdDxtyQ27r9hzGI5eZCrMNVpmYAXmo0BubWszrJpekp+HpnARjpVl/3ThuwS4kvWYOTiz5+YXN6hBBYL9qxOkq6xZIuMOeoWtGSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713162992; c=relaxed/simple;
	bh=1d/EDYFwGSGnOUpbaeGtzTmb3A7VDzDqdL9koovPZnk=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=h5cRdIU2qb5n8JJR0wk9xGfTGvhM4J8cVSFWZPk9HF07/4BZuwTviZGeGecwF0ayLXKzRt2/0E0vVqwo/AA1fk6T97jLvEF0dDlGFaqeTZ+jtRF8xmtFEnAxALy6PrL8TsRZ8bXZKqmUppYYPF35Su4Mq3Y5UXc48ENgzF5puVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hcGRw8SM; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61510f72bb3so49280697b3.0
        for <bpf@vger.kernel.org>; Sun, 14 Apr 2024 23:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713162989; x=1713767789; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wB0mFKuGZHW/z83jZ9UZ1kMmy9iw6kq5zXLeGG3r0jQ=;
        b=hcGRw8SMOTvoMtNVOokID05DyO7/dYhklcK3EuiJjHeIoPV5l9mEE/LT3saizYkMeB
         Qbbm3JHrFlTt0kt1DNFNkXM9ZvxqTZ+3MURAKWxyz1X2jXvcy6OFC4gMoJ89SnLuF/fG
         5qgtV4imNjqEhhc/8e5bIf+3Ogh4egdqCxVdgaB/R+sKU+pGluxKAXJ8TzzI+m/HyQjn
         ynyej5z1M89YxJJyhrBuJFCk+V5cg96zG61erH3jrzC0tewtaS0g8gTJDw0+m7TpLmRU
         Cr8PpGvlPBG3Hpl9e6m93SIsK2STdJn+Y0uvR+/yMlB3Zm6fFoJDvrh2hc6Yg3usFD53
         hg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713162989; x=1713767789;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wB0mFKuGZHW/z83jZ9UZ1kMmy9iw6kq5zXLeGG3r0jQ=;
        b=b54IAnG8s1LpxlRAtdm/OHAbvgNeOJ+5ihfGviOCT0p2O9ZjtQkZY5IfhwXvIu6vdn
         6ONfn6lzVI6Zpjvp+8u9wol0ZdGcLu1BS0m9kPLWFEdQlDM8EMXtdW1tosERDrExGGVS
         nrhJC7pDEiDRxKV4gH0mtg+2sUyxJRd+r7HaVssmJR/JzlJcWi0cBjD8fUQK3ch7Rc9D
         TK412mp+h2ibUU9o7pXa/jqFfqMBhVnzNIvnyCRBImsm2AaWvNkXorMoWgCPQOjmolZS
         RqtghsCRms0pHk5WToL0KPbRQtSC65ClyQvjf8MPQJyRmW+o+vxMn+8LGfHZTVs9xl06
         yqJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxHv4CGCqFQKlnL4nvNYiqqp/FU1bW9+THMmd9VsxyUJYlDXKZRag1u0gMbcYx8qZ1Vp1S088MbP/VWjN0qWHW2mwp
X-Gm-Message-State: AOJu0YxM+JxubOKXL4+tbKVRVrdo4HcderuDVwqavJ6DgpDZf6I6cBWR
	D9+xATuuc12Hb3GidlzoIiXMpad3TBK2TxV57weiGCx66tRr1JvxPq/UPnPZ/sSqr9jAZDgXB8N
	q6J2tMA==
X-Google-Smtp-Source: AGHT+IFla4MrX294yqIP+FWtWzJmxqGcQ32XqueDUfsH1OcnJlS4SzKTAazV/kcLnzG+SAXlo39sSpcyIttX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f304:d776:d707:4b57])
 (user=irogers job=sendgmr) by 2002:a05:690c:a:b0:618:9588:e9db with SMTP id
 bc10-20020a05690c000a00b006189588e9dbmr1908547ywb.2.1713162989579; Sun, 14
 Apr 2024 23:36:29 -0700 (PDT)
Date: Sun, 14 Apr 2024 23:36:17 -0700
Message-Id: <20240415063626.453987-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v1 0/9] Consistently prefer sysfs/json events
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

As discussed in:
https://lore.kernel.org/lkml/20240217005738.3744121-1-atishp@rivosinc.com/
preferring sysfs/json events consistently (with or without a given
PMU) will enable RISC-V's hope to customize legacy events in the perf
tool.

Some minor clean-up is performed on the way.

Ian Rogers (9):
  perf parse-events: Factor out '<event_or_pmu>/.../' parsing
  perf parse-events: Directly pass PMU to parse_events_add_pmu
  perf parse-events: Avoid copying an empty list
  perf pmu: Refactor perf_pmu__match
  perf tests parse-events: Use branches rather than cache-references
  perf parse-events: Legacy cache names on all PMUs and lower priority
  perf parse-events: Handle PE_TERM_HW in name_or_raw
  perf parse-events: Constify parse_events_add_numeric
  perf parse-events: Prefer sysfs/json hardware events over legacy

 tools/perf/tests/parse-events.c |   6 +-
 tools/perf/util/parse-events.c  | 201 ++++++++++++++++++++++----------
 tools/perf/util/parse-events.h  |  16 +--
 tools/perf/util/parse-events.l  |  76 ++++++------
 tools/perf/util/parse-events.y  | 166 +++++++++-----------------
 tools/perf/util/pmu.c           |  27 +++--
 tools/perf/util/pmu.h           |   2 +-
 7 files changed, 262 insertions(+), 232 deletions(-)

-- 
2.44.0.683.g7961c838ac-goog


