Return-Path: <bpf+bounces-29832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D43B48C70DC
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 06:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B66E1F24040
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 04:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5611182AF;
	Thu, 16 May 2024 04:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PN9Pakz4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E1515E83
	for <bpf@vger.kernel.org>; Thu, 16 May 2024 04:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715833203; cv=none; b=bwqpS0pB5pcGuMAOafxoaNBtGBLoUe1FM4BZYjEHvefDaLgaXPY/YFOlEY/IPYXmbK6n35JYuON1+QdEphFbF9hlWcfE7Hwp1wBvKwG/iVTiJjvEA5evC0csBdKwSmOwxVGHpTvRk3+mB1xk1eJiTj+9SzFYnH02u3mxb9mjLs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715833203; c=relaxed/simple;
	bh=lHHwkYfHA8wjarLgp5Pin3R8Kdwmiap6eamnf3fEAj8=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=JZqIv7Yq6fUWC9ZPwEP1FiBEqBHWqxGJTFmc/MUkBwkPnxs0C5OF1kO9Wv90R9pDwHEhkzk4Ska/tAj+qGS2AoFv6Lo4I1QL5T20vI0fxN9qgu3EG6iCf6qXk6hEalHOPg2OMBCDrjUWrXVxYX+96h4ZCRn98GfidReLMwrQoaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PN9Pakz4; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61bea0c36bbso151285107b3.2
        for <bpf@vger.kernel.org>; Wed, 15 May 2024 21:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715833201; x=1716438001; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NhvrEJQEtg7mfpXP1eaEk1iTrmpUehU3kjsviXcKots=;
        b=PN9Pakz4SXgiav6BxBSqXt+qB/OAbcUzUB281zKhngB03cLS+oQ0j8QxbK9i91dprF
         Mhs9LRH/zwdrijMPsG0FLAd4jCFZozqyGYPOKUjgA9YfSj6h+NbGv7xqDMIoRP4HxqUa
         jJr37v6Kny0s5HSznqjAlThPODBrF+vJhBCx6xz+oarmpLucmADCVxkzp1+Sub4NuBlw
         0xyV7+aNHDAF21dNo8r/PQFfq+jdTy5enYplpA5c5qhey6dr8OWCi8zAhfbIdsz31h+y
         je1GdNI1aQRpRatMc8GzpAYLn9oBABRN2KBfz262BD+nx4NVIngsV+S9DKdq9tqT6OsP
         P3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715833201; x=1716438001;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NhvrEJQEtg7mfpXP1eaEk1iTrmpUehU3kjsviXcKots=;
        b=nai5PHwsCtDBl3flz24R+2haZ5/TEiporxWjDHvDBzL00ubze6rOWR/AkaSCB3MWmC
         6+FSwx5L1ePoqxV8cBpcLMUfnem5qg90nfzABWQKKwPx1r5/Lw7O4TsGoR/lHqYI4t+s
         LcanoWNVputZjaYdQui0s88b7b2qTz0TVjRDbvbYfeLj83ZqT1WdOp4CW/uvZ5kJ/m7m
         WvM7dwYN+zu3mc8a0kosECtP3zwD1nXE0Le4iXR8ekHL+ULmFInZJrCjlg9zUoxa8XN8
         JxQfGZCjJN02zh2DV0ab2PYzEDbNmTHmODIKfxOLdA1HR21ivb+CuGQrKCMkMxqxqjjW
         /pBg==
X-Forwarded-Encrypted: i=1; AJvYcCWCNWCHlT07uy9mX2UaLn3DcAKalqOH6pO0etCHjlSRvQqf7pDFWQqz7ScTXzpDOPxNK+n3S5LRWdwzO/APS12F8AqH
X-Gm-Message-State: AOJu0Yw8UptGUJ6Uqdb+ubsuzuWtyCEX5szq0Ks1zTPmcioVEGguT1d9
	iYn5hsC3J6yLGmBZF0tRwFwZ6rbfqwt1SE9KSgHqNSi7kBHfyE1KVFjFRSi5uRngkb4a83vYKdW
	EtOgsng==
X-Google-Smtp-Source: AGHT+IG7tjaXXbXKUovZxPYRnXIcz16bs4tMWPRVs26fsA8k2+yRtiUieQLjMyGUvC+JI76UlHP2+h+y5haK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bac3:cca1:c362:572])
 (user=irogers job=sendgmr) by 2002:a05:690c:668f:b0:61a:bda3:a78c with SMTP
 id 00721157ae682-622afd81d04mr45306547b3.0.1715833201091; Wed, 15 May 2024
 21:20:01 -0700 (PDT)
Date: Wed, 15 May 2024 21:19:45 -0700
Message-Id: <20240516041948.3546553-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1 0/3] Use BPF filters for a "perf top -u" workaround
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Changbin Du <changbin.du@huawei.com>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow uid and gid to be terms in BPF filters by first breaking the
connection between filter terms and PERF_SAMPLE_xx values. Calculate
the uid and gid using the bpf_get_current_uid_gid helper, rather than
from a value in the sample. Allow filters to be passed to perf top, this allows:

$ perf top -e cycles:P --filter "uid == $(id -u)"

to work as a "perf top -u" workaround, as "perf top -u" usually fails
due to processes/threads terminating between the /proc scan and the
perf_event_open.

Ian Rogers (3):
  perf bpf filter: Give terms their own enum
  perf bpf filter: Add uid and gid terms
  perf top: Allow filters on events

 tools/perf/Documentation/perf-record.txt     |  2 +-
 tools/perf/Documentation/perf-top.txt        |  4 ++
 tools/perf/builtin-top.c                     |  9 +++
 tools/perf/util/bpf-filter.c                 | 55 ++++++++++++----
 tools/perf/util/bpf-filter.h                 |  5 +-
 tools/perf/util/bpf-filter.l                 | 66 +++++++++----------
 tools/perf/util/bpf-filter.y                 |  7 +-
 tools/perf/util/bpf_skel/sample-filter.h     | 27 +++++++-
 tools/perf/util/bpf_skel/sample_filter.bpf.c | 67 +++++++++++++++-----
 9 files changed, 172 insertions(+), 70 deletions(-)

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


