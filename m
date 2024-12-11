Return-Path: <bpf+bounces-46610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 249869EC923
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 10:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9E4281BEC
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 09:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0ACE2210C0;
	Wed, 11 Dec 2024 09:31:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980B61A83E5;
	Wed, 11 Dec 2024 09:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733909499; cv=none; b=peXFVVkFn3+zjtrFbJscXsLJ2NjWYrOcvgDsjAqJic/4wx+1zeimEsbvojqDtUuMNyhSELjmPvkDxwUSUI/DaXAX82snVX48xHQnFExrI7/y8uvL1uGYKHBazu/8ZdDPj1kr6rJBtDWr2pTTLzrf7uteLvzaOgYQDKd1I/q9pww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733909499; c=relaxed/simple;
	bh=h5PW0NQebtRhPbFzeEM2+4jOCjLuzVNQAkAakIMMjcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kRzZ/b3iTRoGYQNKXGzWtaJB0jOblguOfrsolVbaaiFsjv65M2IV8NygrYWfTZHvwE1Xx+kJZohIeRQX2oijVjLue+xhUGPEdnPZ+mVGuOSKtGn1W2UiBqMX9ZTNjdpZnKuJIUhyWbmxgVbAO4NzkkIHkoMIERA39wXsZxMYkbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7B721713;
	Wed, 11 Dec 2024 01:32:04 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 63C663F5A1;
	Wed, 11 Dec 2024 01:31:33 -0800 (PST)
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
Subject: [PATCH v2 3/3] bpftool: Link zstd lib required by libelf
Date: Wed, 11 Dec 2024 09:31:14 +0000
Message-Id: <20241211093114.263742-4-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211093114.263742-1-leo.yan@arm.com>
References: <20241211093114.263742-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the feature-libelf-zstd is detected, the zstd lib is required by
libelf.  Link the zstd lib in this case.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/bpf/bpftool/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index a4263dfb5e03..469f841abaff 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -106,6 +106,7 @@ FEATURE_TESTS += libbfd-liberty
 FEATURE_TESTS += libbfd-liberty-z
 FEATURE_TESTS += disassembler-four-args
 FEATURE_TESTS += disassembler-init-styled
+FEATURE_TESTS += libelf-zstd
 
 FEATURE_DISPLAY := clang-bpf-co-re
 FEATURE_DISPLAY += llvm
@@ -113,6 +114,7 @@ FEATURE_DISPLAY += libcap
 FEATURE_DISPLAY += libbfd
 FEATURE_DISPLAY += libbfd-liberty
 FEATURE_DISPLAY += libbfd-liberty-z
+FEATURE_DISPLAY += libelf-zstd
 
 check_feat := 1
 NON_CHECK_FEAT_TARGETS := clean uninstall doc doc-clean doc-install doc-uninstall
@@ -132,6 +134,12 @@ endif
 
 LIBS = $(LIBBPF) -lelf -lz
 LIBS_BOOTSTRAP = $(LIBBPF_BOOTSTRAP) -lelf -lz
+
+ifeq ($(feature-libelf-zstd),1)
+LIBS += -lzstd
+LIBS_BOOTSTRAP += -lzstd
+endif
+
 ifeq ($(feature-libcap), 1)
 CFLAGS += -DUSE_LIBCAP
 LIBS += -lcap
-- 
2.34.1


