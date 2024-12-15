Return-Path: <bpf+bounces-47008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4383E9F2670
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 23:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98838188506E
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 22:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7ED51C3054;
	Sun, 15 Dec 2024 22:12:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF101D696;
	Sun, 15 Dec 2024 22:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734300763; cv=none; b=LlDtF4uZ8Jktc0yGu9gJKsXSAFgvkFQDOaz3kv9SJMfJoYUSWtDLfGs71THAE9N+DOvCJ89sQTwTJVXU3pLdIileD4XPbkp0ZRyy7j5T0p/bExioBLMCsT6vHNxuawfN9DYRl8pz8tcNbT/yh8l6dqgAILtmzukeUYTqeHRALi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734300763; c=relaxed/simple;
	bh=pc2uylv1ntsRPEnes+mJCv7XlY/EKoFkSA4uEYWsiec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FzOJCjbIHECMcc/m0NQrAfjQ/Q6ViqiaGhLub2YpohCQeQevygSz+RruSe0e97e/TYMkQZYJiH7BXF0NcYRX39QATUn15MUK09L4+v4qglyX4s9jx0sby++qqgb6nR9Y4vz/W+Z6LHiik0yEeBMN6ih4U52VgGjtck6ZK9Z0nHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 404DA1424;
	Sun, 15 Dec 2024 14:13:08 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BCE6B3F720;
	Sun, 15 Dec 2024 14:12:36 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Nick Terrell <terrelln@fb.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Guilherme Amadio <amadio@gentoo.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 0/3] bpftool: Fix the static linkage failure
Date: Sun, 15 Dec 2024 22:12:20 +0000
Message-Id: <20241215221223.293205-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series follows up on the discussion in [1] for fixing the static
linkage issue in bpftool.

Patch 01 introduces a new feature for libelf-zstd.  If this feature
is detected, it means the zstd lib is required by libelf.

Patch 02 is a minor improvement for linking the zstd lib in the perf.

Patch 03 fixes the static build failure by linking the zstd lib when
the feature-libelf-zstd is detected.

[1] https://lore.kernel.org/linux-perf-users/Z1H9-9xrWM4FBbNI@mini-arch/T/#m2300b127424e9e2ace7da497a20d88534eb6866f

Changes from v2:
- Refined commit log in patch 01 for recording info that from which
  libelf version it requires to link libzstd. (Quentin)
- Removed to display feature 'libelf-zstd' in bpftool. (Quentin)
- Added Test and Ack tags. Thanks all! (Quentin/Jiri/Namhyung/Andrii)


Leo Yan (3):
  tools build: Add feature test for libelf with ZSTD
  perf: build: Minor improvement for linking libzstd
  bpftool: Link zstd lib required by libelf

 tools/bpf/bpftool/Makefile             | 7 +++++++
 tools/build/Makefile.feature           | 1 +
 tools/build/feature/Makefile           | 4 ++++
 tools/build/feature/test-all.c         | 4 ++++
 tools/build/feature/test-libelf-zstd.c | 9 +++++++++
 tools/perf/Makefile.config             | 8 +++++++-
 6 files changed, 32 insertions(+), 1 deletion(-)
 create mode 100644 tools/build/feature/test-libelf-zstd.c

-- 
2.34.1


