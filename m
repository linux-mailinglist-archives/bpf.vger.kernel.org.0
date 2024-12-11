Return-Path: <bpf+bounces-46607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CB39EC916
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 10:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D1A169098
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 09:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E941A83E5;
	Wed, 11 Dec 2024 09:31:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5E14C97;
	Wed, 11 Dec 2024 09:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733909489; cv=none; b=jF8aolgPXGhrA8Kk2REcVI1rRAsSUH8hUJfXtm3uNzKHW2CfYWsx8ZNrujrhHRhFomGgEi8trJ0ecJOyhTPKMYTANo99T3zAh9U1LEnkCzKMVBXpVy4Dnu1y07uZ6gxJ7dCpFHRXwTFPPpZ/aFd9dJv9n4r/CDQCuF3DdTorZSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733909489; c=relaxed/simple;
	bh=9S1xfuxm6ad8QaPLlRfK0CECrSiQWiO9S5j/PlfvJhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YB61luEaq2iFLRjvAkHuTO674mKB5N6g2xCgm3LWxK1QGiMrtOIhMpZf+NoqzA++zHh41xsFG4pso1q6WfLQ8iFD9JUQ2wnVuSD/7KCcefXlO9DSS8dzoEXM1KgY8FLFslwZDKXRKwboFU2ZbXdFdj+YZXDbnIhirVQiOzWfGh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEDA31063;
	Wed, 11 Dec 2024 01:31:53 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5A3F43F5A1;
	Wed, 11 Dec 2024 01:31:22 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Quentin Monnet <qmo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
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
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Guilherme Amadio <amadio@gentoo.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 0/3] bpftool: Fix the static linkage failure
Date: Wed, 11 Dec 2024 09:31:11 +0000
Message-Id: <20241211093114.263742-1-leo.yan@arm.com>
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


Leo Yan (3):
  tools build: Add feature test for libelf with ZSTD
  perf: build: Minor improvement for linking libzstd
  bpftool: Link zstd lib required by libelf

 tools/bpf/bpftool/Makefile             | 8 ++++++++
 tools/build/Makefile.feature           | 1 +
 tools/build/feature/Makefile           | 4 ++++
 tools/build/feature/test-all.c         | 4 ++++
 tools/build/feature/test-libelf-zstd.c | 9 +++++++++
 tools/perf/Makefile.config             | 8 +++++++-
 6 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 tools/build/feature/test-libelf-zstd.c

-- 
2.34.1


