Return-Path: <bpf+bounces-55673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A11A9A84B1F
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 19:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8442B460E96
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 17:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7115528C5D0;
	Thu, 10 Apr 2025 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4s/Ek1Ie"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675A828A41F
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 17:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306607; cv=none; b=BDtx/Tqkn1FDyMIrFwJW2MdHFM5u3ZjkQdPgI1GhfqLp6fNStnDjtZ7gcJKvx1pt0jrKyDE9lXKcbWLvNfLLI/qUCH+d/AEgjRKaQjP1VBuBe+hDuvi5bhs/CVWglMdv1QvscTocJlYyLVvjfIYNHXtHxF0mXW8HOzhd5DNtL8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306607; c=relaxed/simple;
	bh=0//WmJ1MvGDNDKpdNYwdZZwJbIgzDrSYUgg+o82/7+Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=avoYgucygDLmqdzRmRSkpk8ZwlfYF2AnFLq/kuV4UZ7q59KrLdJxazwg0Gzd89Qi9Xb3ZJvQKNa0YsR/6qCsu81b7rmpUVhnhiehS4A3cZq+OfKbR0biuWwv4/qKcYHoamdV1zjvEk8mrnDolXBSEoUUdF46JFN+DPGhK/VS8DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4s/Ek1Ie; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-739764217ecso1004556b3a.0
        for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 10:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744306605; x=1744911405; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+Mtra7UpOtg1oT/vz8dBcOicq3xEBGFPtLAKmZNvNn4=;
        b=4s/Ek1Ie+mB3Ipyc5VO3QXqWlhepzmX2qy5MfsNS7cHPjqsNsIOOSb8w1f7FpeFlgG
         GrryncUXl4BC3VLfiv16C2ZhBpvqc/KZCydkjjceR0rHJ7SyfnwaJLh6bOZUAOQ48ohu
         q47dZ50o3ZRKvlSnZAg307ZlcktB4hzQKf5SZefNnQA5ELiCsC7fpWYsg+kbxfX/a5gV
         YNWzaih67f87edGr6Yvebv4QeKYwxypEpf1xh0aIUCuD0DYsrNi8tKn0JQFq0LUTsLP8
         X58cA3Uxb5yqbvx+xAGSj6Ogu8J2FIMUi0Aa1L++ONnW750baQMeiKD7eb6qrVQy19uP
         S1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744306605; x=1744911405;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Mtra7UpOtg1oT/vz8dBcOicq3xEBGFPtLAKmZNvNn4=;
        b=f+aRSHPQpi+j4Wua34eb4AoQj2YQFCFy0dbhxjJAe5n1JqJf3MHIh8E+WP3EDIyfmu
         DPBYuZ3Um8WdsPGVH77K7D1Lsd3EySJs+/i3XBrw/gBFUK5OhzHJaX31D/68/VLJKOsI
         vR2C9TM17zXae05SLNjRPlwpgfxJuj5W3BPVfjfHaS1XqRwdRXN5AUDQlQn05WfUIFa6
         vynnpgC03xZ5Z671IgLH9VcNKKaWy76/9wqxMUR8SDoJJVlG/UikX1niciS9COJNFpco
         owWZI1/Os6c2f6nRvAPHqsvsh2agYOGaq11uU17QY1rJRGIbTgS2aTHSF0giBD0HtjbC
         MMcw==
X-Forwarded-Encrypted: i=1; AJvYcCXBlR6+gcknksZmjLGHe8t9DPoYjS9EqRTmX0fh0vFA9ndKzcU90z57A4kWW2xhi1/ynWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2KaDq+rmm+ephST/9oAiBMAroAMV/JRICrUIx+5zDVpukIlKh
	VIL0zZ16NrbWi/haw86t7uvhOluOiiAjzjSyKE0hpLjcSmBWiIDvGFfq+2zA/ZnwneCE55PcJAv
	ISrGffA==
X-Google-Smtp-Source: AGHT+IEmnMredzHi+kLR2kEbURd83yYUSGj17LZ1HUJ2i9FaI931sECRooZZKkRPThkfOxUi4yLEd8ZfEGNF
X-Received: from pfhx5.prod.google.com ([2002:a05:6a00:1885:b0:736:47b8:9b88])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8486:b0:737:cd8:2484
 with SMTP id d2e1a72fcca58-73bbf4d8419mr4445932b3a.6.1744306604719; Thu, 10
 Apr 2025 10:36:44 -0700 (PDT)
Date: Thu, 10 Apr 2025 10:36:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250410173631.1713627-1-irogers@google.com>
Subject: [PATCH v2 00/12] Move uid filtering to BPF filters
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Levi Yun <yeoreum.yun@arm.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Rather than scanning /proc and skipping PIDs based on their UIDs, use
BPF filters for uid filtering. The /proc scanning in thread_map is
racy as the PID may exit before the perf_event_open causing perf to
abort. BPF UID filters are more robust as they avoid the race. Add a
helper for commands that support UID filtering and wire up. Remove the
non-BPF UID filtering support given it doesn't work.

v2: Add a perf record uid test (Namhyung) and force setting
    system-wide for perf trace and perf record (Namhyung). Ensure the
    uid filter isn't set on tracepoint evsels.

v1: https://lore.kernel.org/lkml/20250111190143.1029906-1-irogers@google.com/

Ian Rogers (12):
  perf tests record: Cleanup improvements
  perf bench evlist-open-close: Reduce scope of 2 variables
  perf parse-events filter: Use evsel__find_pmu
  perf target: Separate parse_uid into its own function
  perf parse-events: Add parse_uid_filter helper
  perf record: Switch user option to use BPF filter
  perf tests record: Add basic uid filtering test
  perf top: Switch user option to use BPF filter
  perf trace: Switch user option to use BPF filter
  perf bench evlist-open-close: Switch user option to use BPF filter
  perf target: Remove uid from target
  perf thread_map: Remove uid options

 tools/perf/bench/evlist-open-close.c        | 76 ++++++++++++---------
 tools/perf/builtin-ftrace.c                 |  1 -
 tools/perf/builtin-kvm.c                    |  2 -
 tools/perf/builtin-record.c                 | 27 +++++---
 tools/perf/builtin-stat.c                   |  4 +-
 tools/perf/builtin-top.c                    | 22 +++---
 tools/perf/builtin-trace.c                  | 27 +++++---
 tools/perf/tests/backward-ring-buffer.c     |  1 -
 tools/perf/tests/event-times.c              |  8 +--
 tools/perf/tests/keep-tracking.c            |  2 +-
 tools/perf/tests/mmap-basic.c               |  2 +-
 tools/perf/tests/openat-syscall-all-cpus.c  |  2 +-
 tools/perf/tests/openat-syscall-tp-fields.c |  1 -
 tools/perf/tests/openat-syscall.c           |  2 +-
 tools/perf/tests/perf-record.c              |  1 -
 tools/perf/tests/perf-time-to-tsc.c         |  2 +-
 tools/perf/tests/shell/record.sh            | 36 ++++++++--
 tools/perf/tests/switch-tracking.c          |  2 +-
 tools/perf/tests/task-exit.c                |  1 -
 tools/perf/tests/thread-map.c               |  2 +-
 tools/perf/util/bpf-filter.c                |  2 +-
 tools/perf/util/evlist.c                    |  3 +-
 tools/perf/util/parse-events.c              | 33 ++++++---
 tools/perf/util/parse-events.h              |  1 +
 tools/perf/util/python.c                    | 10 +--
 tools/perf/util/target.c                    | 54 ++-------------
 tools/perf/util/target.h                    | 15 +---
 tools/perf/util/thread_map.c                | 32 +--------
 tools/perf/util/thread_map.h                |  6 +-
 tools/perf/util/top.c                       |  4 +-
 tools/perf/util/top.h                       |  1 +
 31 files changed, 178 insertions(+), 204 deletions(-)

-- 
2.49.0.604.gff1f9ca942-goog


