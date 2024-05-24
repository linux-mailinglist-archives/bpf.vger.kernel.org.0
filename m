Return-Path: <bpf+bounces-30528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 084548CEB82
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 22:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88C231F228D5
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 20:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DD112E1DA;
	Fri, 24 May 2024 20:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IAD9ktp2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652E484D22
	for <bpf@vger.kernel.org>; Fri, 24 May 2024 20:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716583966; cv=none; b=gsEthUJCtQ0ZKcEvqxvezCmYvTCSm6ZlvBoYp5gSpIVRCFIchxnCeyHsSOT7Ty3j4jxmrGCbHJxGiwez3NPd12Ovz8HehLNRrVmDbQM36bJ9ODLaH8Gg75a+NNdgQ2Ns6flhtc8AjSvZS+NrRgjQMIGj3aLlpkj2PfQpdNc+ivc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716583966; c=relaxed/simple;
	bh=gCgxAKw5lQYNU12HmtYzfHgtWOefJwUEBWIEDW28LCc=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=qV9RWwL1Gm6qb9yUAutpkHoQ3oqBqqN/IAzs/jedt3vLLoNfsdfmjfY10/NBFwHJaCMoU80PTVnvxooD7+WrfkTDa0G/YYYLH4x9BLyTLZEgVm5GYz++wvuehQnUHBjtapkVewWo/xCZfzsG2yVXxt8METVaiCyTUUqdfklTxi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IAD9ktp2; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62a084a0573so11364417b3.2
        for <bpf@vger.kernel.org>; Fri, 24 May 2024 13:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716583964; x=1717188764; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xB50v1xJEh4tZDBD3Dhd7HLyGrQgpvbCGS3Q7EGX/w0=;
        b=IAD9ktp2pieAZMNUGmOtQX3oXWD5IaYbozVDgCDR4L2qY31pg3y7mj8OKm0UWlQiNF
         uAJU9qpd42U9x+rPC+uqRQVtCPi9SZ40lBwCzTdut6hLlsacYTk4RXNb1e+w4MyyXCcs
         BH24q8Xr51jbo7gv97WSI5n6QNus/U4yz1MFnDksAEPQZh8tHwKQ7oFJlboyHbKL0or4
         1Cv03DzzjwuRmTZ2KYReD8CVxxEuq6i7jRtOtTeot/uvxbaFq3n3xcBsjJK4pzNng4wo
         ppdWnB3Z52lxOJz89n++LZDR+h5qklOU3gHYPCIoUWDcyUIsl9DS7yQGgfbuV7hr2Vis
         bd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716583964; x=1717188764;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xB50v1xJEh4tZDBD3Dhd7HLyGrQgpvbCGS3Q7EGX/w0=;
        b=ha47I7b83k6HfEj/hvWiwBAgr+/v/xhZv+PNZwlCQBlXmg8OI43LmvuHEw0fzPKKQI
         ARgm/2L9x7jX7XdLuNU07Uu6ZU+dzqS2lXY8/qAucMj+2hEH9o5wfu3iCLdRDddO3b0M
         e7TO3dRaALvzdj/6jLzosq1fHYVgo69s5Y+mnys27ED/ejqHt6QIwxsltSN8yP2gnIIW
         QWm9jrfQkCluCWXH+ljOSOONZWQbQE7IWUDNFSDrpa/ldrHzAdiitNwgmJXl6oxjuJXA
         yqolwoN4HZi/BgWcY8t0MNctjD+9ztAVl5fJ6bC9XhCGYa41tQ8h6rMbPk3ofgm7a/g2
         363w==
X-Forwarded-Encrypted: i=1; AJvYcCV16+NAygyipyyRmjwe1DdNPwX0wah+1lijZYA9663gNgTUC75Jxm/0kAUjWKNU+8Yo95I/Imt5SlZoVBpCwEGVJtIZ
X-Gm-Message-State: AOJu0YyVF6JqraRo36URGHRupfsZTieNkF5tg3snvTrfjkl/sFzrCX3D
	AZjqd77KZ1t+4wARwKUVEQYPXkhdNwBc5DXAOJxeWqxZ/jXHUswomBSJ8p8IgC25d3KICxtbf1M
	OHk9jmA==
X-Google-Smtp-Source: AGHT+IEAyhX5lsFIRyG3c890XY9BUv/ot0WWIvwVB5kr3LpZpWAHUbdUSqtGYIOLdsbz8z3ovR5rl4gVgJvi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b0b5:95af:a29:375e])
 (user=irogers job=sendgmr) by 2002:a05:690c:6a06:b0:627:de4d:81b8 with SMTP
 id 00721157ae682-62a08f75ed8mr7726067b3.7.1716583964450; Fri, 24 May 2024
 13:52:44 -0700 (PDT)
Date: Fri, 24 May 2024 13:52:24 -0700
Message-Id: <20240524205227.244375-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Subject: [PATCH v3 0/3] Use BPF filters for a "perf top -u" workaround
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Changbin Du <changbin.du@huawei.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Andrii Nakryiko <andrii@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow uid and gid to be terms in BPF filters by first breaking the
connection between filter terms and PERF_SAMPLE_xx values. Calculate
the uid and gid using the bpf_get_current_uid_gid helper, rather than
from a value in the sample. Allow filters to be passed to perf top, this allows:

$ perf top -e cycles:P --filter "uid == $(id -u)"

to work as a "perf top -u" workaround, as "perf top -u" usually fails
due to processes/threads terminating between the /proc scan and the
perf_event_open.

v3. Move PERF_SAMPLE_xx asserts to sample_filter.bpf.c to avoid
    conflicting definitions between vmlinux.h and perf_event.h as
    reported by Namhyung.
v2. Allow PERF_SAMPLE_xx to be computed from the PBF_TERM_xx value
    using a shift as requested by Namhyung.

Ian Rogers (3):
  perf bpf filter: Give terms their own enum
  perf bpf filter: Add uid and gid terms
  perf top: Allow filters on events

 tools/perf/Documentation/perf-record.txt     |  2 +-
 tools/perf/Documentation/perf-top.txt        |  4 ++
 tools/perf/builtin-top.c                     |  9 +++
 tools/perf/util/bpf-filter.c                 | 33 +++++----
 tools/perf/util/bpf-filter.h                 |  5 +-
 tools/perf/util/bpf-filter.l                 | 66 +++++++++---------
 tools/perf/util/bpf-filter.y                 |  7 +-
 tools/perf/util/bpf_skel/sample-filter.h     | 40 ++++++++++-
 tools/perf/util/bpf_skel/sample_filter.bpf.c | 73 +++++++++++++++-----
 9 files changed, 169 insertions(+), 70 deletions(-)

-- 
2.45.1.288.g0e0cd299f1-goog


