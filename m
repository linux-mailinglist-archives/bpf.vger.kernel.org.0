Return-Path: <bpf+bounces-47011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CD49F2677
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 23:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3995188541B
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 22:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8511CD1E0;
	Sun, 15 Dec 2024 22:12:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FD41D696;
	Sun, 15 Dec 2024 22:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734300773; cv=none; b=fPB2Wpab5PDKkB1dc7qAaWXXTqcB7tjMrRHJWk1YQ3VqOPGjyZ/VlNxHeMFgFkl8l/yJL6ob1P+qAFmVNzx4X4bY1pZQ/NM6HYiPiL/clzYG5sNTcAWHyKUWCPUdMsnlT8jks6WUOHHEKpebGxhmeC/zLKgeP3PRfwZ7Sgtg0bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734300773; c=relaxed/simple;
	bh=dZfDJtTdFqqAmRX/oX7LMuN1FEkz+Rtb5tsnTgahIMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rN6swj3MauZNMwgeurupIWt4TCXej11fVIf35+AkrcMvmpY8UstRL5LgBHqlf1zYvItRNMFToPh9h9/5azFPyqJoe8DAGwZQuCU78z6vy1VlLVSSpe4xsn/DtBwtgERRHThweFbAQ/Pgoiap5BXm1RtS+qI1H1OZKjXvPj1aP7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4634B1A32;
	Sun, 15 Dec 2024 14:13:19 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BF2003F720;
	Sun, 15 Dec 2024 14:12:47 -0800 (PST)
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
Subject: [PATCH v3 3/3] bpftool: Link zstd lib required by libelf
Date: Sun, 15 Dec 2024 22:12:23 +0000
Message-Id: <20241215221223.293205-4-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241215221223.293205-1-leo.yan@arm.com>
References: <20241215221223.293205-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the feature libelf-zstd is detected, the zstd lib is required by
libelf.  Link the zstd lib in this case.

Signed-off-by: Leo Yan <leo.yan@arm.com>
Tested-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/bpf/bpftool/Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index a4263dfb5e03..dd9f3ec84201 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -106,6 +106,7 @@ FEATURE_TESTS += libbfd-liberty
 FEATURE_TESTS += libbfd-liberty-z
 FEATURE_TESTS += disassembler-four-args
 FEATURE_TESTS += disassembler-init-styled
+FEATURE_TESTS += libelf-zstd
 
 FEATURE_DISPLAY := clang-bpf-co-re
 FEATURE_DISPLAY += llvm
@@ -132,6 +133,12 @@ endif
 
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


