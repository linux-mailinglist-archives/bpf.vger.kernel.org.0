Return-Path: <bpf+bounces-59812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE5DACFA09
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 01:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0496D3B0196
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 23:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DBE27FD75;
	Thu,  5 Jun 2025 23:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BAXW3b58"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98846218E96
	for <bpf@vger.kernel.org>; Thu,  5 Jun 2025 23:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749166788; cv=none; b=ezndmUwMh1n5RwnjWJUcrQC1aFqXNtRKv0+vTEHzYXQ45LF53MmrrFbCdB87nTdrJlLV5U8TzbFqiEAExEBaf5QXdxZHr8CF6lHGfXs9iHRNUfuJ+RwqD4k/lIsnWBAmySxizpuNSmMrqer79LlJwOHZJ7RcUFKd3bQW8tor3Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749166788; c=relaxed/simple;
	bh=tnt16ae+y57cKBq+D4CTE9F3F2pZCLqAdbjCjREdbeI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=faqBGnBUe2YSgDnTTe3vlIUuWLA+nC+3Bji/BLhK9LIBs+NYZPOM+OLwuG+vzAMkHRYaBCf5fdC+kGJRWCBVX8BchRpDBP658Nk1WoS2R3I4nPes4kseJt01uJH2qH2+J+ybLUMZjDu8SrP+yMdwlXEV+hMjdLG/Wa8B2io/2rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BAXW3b58; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2358de17665so14391615ad.3
        for <bpf@vger.kernel.org>; Thu, 05 Jun 2025 16:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749166785; x=1749771585; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NDcnRCvhN0cGBGaiipnv7JZBgVRStFDvljhr5/yTJ1E=;
        b=BAXW3b58dU2S9PfREfoAaXL3/1vQ7WhMSVT/fKfwWbSU6uYHEkQWko+JhH34VpPf3p
         RsIJrX/0M67IF1A0/vH3KvCffydm9EFbJDBK02tH8g9wyvMXWRv1hgaoJhVjGqtGwHgI
         EtNrGCYPMTjcdmbE+ILAcRm3OZ5txqts7p3w36uIsQ+levLqvtdFUtF5ayYyX3MdNdeo
         irPXjRhYyztbRbo9emhgAFmRWF/0gzEwNtoQ0OnVESyH8c5XpfzvPCZ/3e1TxfW9nKz7
         LwjCflzKfu/F+NV82ebkJxRQAfgH2UVJDK3zdxfvhlNzuxpE+u34jKbHfKmwrHQdcCkh
         KU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749166785; x=1749771585;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NDcnRCvhN0cGBGaiipnv7JZBgVRStFDvljhr5/yTJ1E=;
        b=r8G9Gz6PJZUx/7PHsUModqhQCrVj0aPRroPpaOHABQxavTRCczjsnTdryHKEy55v8k
         7OkFVRyC9RoH/RUdde5UNdPlrsd6e9iInuyxtz0P5WuXX58fsYj5RGLZixEaroDv/O5X
         Movb16e6MGTCMeTfk1NZDQbrzREnc201FkpQ7HlUHZ2AcYoxDUqJ/xJzj2Qjb+OvPEBC
         yvtV9YFp1BQqZHUUzJX3AxARPxvEIRcLh+DVAH78hAOEkCunmzShvFBWG5ZVoN4JzLp8
         EYPXzHiUxqkBhCD315OdXDYu5BeB6RLSbyjqL10EAwADrypjIkumWIB6pgGOHb4w5vr4
         2IVg==
X-Forwarded-Encrypted: i=1; AJvYcCX6Rn5UwVCDRDyxRqKu7n6KFoR8zf4K2bhDQsh0iHZqZf1wp9aMpaI5F3yuDYiWIlvmQOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZwiYPOF2KJAmSwHnjh6ss9Ushdij/kMf1aKXfnTC8w2J/DcTb
	iWbw4Dy0NlSDBwI877GJ5/eGtOgZYtLM0mVxlo1mSs0wb8ecek33eaJ7LZGwHimMPgcnZVSP+Yi
	E1DwlhnWPkj5SvFJtkOA5pg==
X-Google-Smtp-Source: AGHT+IE08Liy+8XoaNuzTwlPDbj/7tKOpfke7hKYWkK2lSlrA+Kus4J6Gi1Kh2n6bA1jf6qd+QV8AiCpIQqVUCU3
X-Received: from pllg10.prod.google.com ([2002:a17:902:740a:b0:235:6d5:688b])
 (user=blakejones job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f545:b0:235:1706:2002 with SMTP id d9443c01a7336-23601b49461mr15371205ad.0.1749166784846;
 Thu, 05 Jun 2025 16:39:44 -0700 (PDT)
Date: Thu,  5 Jun 2025 16:39:30 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250605233934.1881839-1-blakejones@google.com>
Subject: [PATCH v2 0/4] perf: generate events for BPF metadata
From: Blake Jones <blakejones@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Chun-Tse Shao <ctshao@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yujie Liu <yujie.liu@intel.com>, 
	Graham Woodward <graham.woodward@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Ben Gainey <ben.gainey@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit ffa915f46193 ("Merge branch 'bpf_metadata'"), from September 2020,
added support to the kernel, libbpf, and bpftool to treat read-only BPF
variables that have names starting with 'bpf_metadata_' specially. This
patch series updates perf to handle these variables similarly, allowing a
perf.data file to capture relevant information about BPF programs on the
system being profiled.

When it encounters a BPF program, it reads the program's maps to find an
'.rodata' map with 'bpf_metadata_' variables. If it finds one, it extracts
their values as strings, and creates a new PERF_RECORD_BPF_METADATA
synthetic event using that data. It does this both for BPF programs that
were loaded when a 'perf record' starts, as well as for programs that are
loaded while the profile is running. For the latter case, it stores the
metadata for the duration of the profile, and then dumps it at the end of
the profile, where it's in a better context to do so.

The PERF_RECORD_BPF_METADATA event holds an array of key-value pairs, where
the key is the variable name (minus the "bpf_metadata_" prefix) and the
value is the variable's value, formatted as a string. There is one such
event generated for each BPF subprogram. Generating it per subprogram
rather than per program allows it to be correlated with PERF_RECORD_KSYMBOL
events; the metadata event's "prog_name" is designed to be identical to the
"name" field of a perf_record_ksymbol. This allows specific BPF metadata to
be associated with each BPF address range in the collection.

Changes:

* v1 -> v2:
  - Split out libbpf change and send it to the bpf tree.
  - Add feature detection to perf to detect the libbpf change.
  - Allow the feature to be skipped if the libbpf support is not found.
  - Add an example of a PERF_RECORD_BPF_METADATA record.
  - Change calloc() calls to zalloc().
  - Don't check for NULL before calling free().
  - Update the perf_event header when it is created, rather than
    storing the event size and updating it later.
  - Add a BPF metadata variable (with the perf version) to all
    perf BPF programs.
  - Update the selftest to look for the new perf_version variable.
  - Split out the selftest into its own patch.
  - Link to v1:
    https://lore.kernel.org/linux-perf-users/20250521222725.3895192-1-blakejones@google.com/T/#t

Blake Jones (4):
  perf: detect support for libbpf's emit_strings option
  perf: collect BPF metadata from existing BPF programs
  perf: collect BPF metadata from new programs, and display the new
    event
  perf: add test for PERF_RECORD_BPF_METADATA collection

 tools/build/Makefile.feature                |   1 +
 tools/build/feature/Makefile                |   4 +
 tools/build/feature/test-libbpf-strings.c   |  10 +
 tools/lib/perf/include/perf/event.h         |  18 +
 tools/perf/Documentation/perf-check.txt     |   1 +
 tools/perf/Makefile.config                  |  12 +
 tools/perf/Makefile.perf                    |   3 +-
 tools/perf/builtin-check.c                  |   1 +
 tools/perf/builtin-inject.c                 |   1 +
 tools/perf/builtin-record.c                 |   8 +
 tools/perf/builtin-script.c                 |  15 +-
 tools/perf/tests/shell/test_bpf_metadata.sh |  76 ++++
 tools/perf/util/bpf-event.c                 | 378 ++++++++++++++++++++
 tools/perf/util/bpf-event.h                 |  13 +
 tools/perf/util/bpf_skel/perf_version.h     |  17 +
 tools/perf/util/env.c                       |  19 +-
 tools/perf/util/env.h                       |   4 +
 tools/perf/util/event.c                     |  21 ++
 tools/perf/util/event.h                     |   1 +
 tools/perf/util/header.c                    |   1 +
 tools/perf/util/session.c                   |   4 +
 tools/perf/util/synthetic-events.h          |   2 +
 tools/perf/util/tool.c                      |  14 +
 tools/perf/util/tool.h                      |   3 +-
 24 files changed, 622 insertions(+), 5 deletions(-)
 create mode 100644 tools/build/feature/test-libbpf-strings.c
 create mode 100755 tools/perf/tests/shell/test_bpf_metadata.sh
 create mode 100644 tools/perf/util/bpf_skel/perf_version.h

-- 
2.50.0.rc0.604.gd4ff7b7c86-goog


