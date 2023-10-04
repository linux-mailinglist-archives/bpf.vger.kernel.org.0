Return-Path: <bpf+bounces-11377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC23B7B818C
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 16:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9E428281A97
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 14:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7AC15EA9;
	Wed,  4 Oct 2023 14:00:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72DD3FF1;
	Wed,  4 Oct 2023 14:00:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0377BC433C8;
	Wed,  4 Oct 2023 14:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696428006;
	bh=JkCPUsuUI3/3l9L6acemPj6CRuOU0mfuQCrxMIBBSag=;
	h=From:To:Cc:Subject:Date:From;
	b=RVWUozDKYLmqLmtB9ewVdKCS98Z5J9W8/4mez/LppskXXm+JuV9FT2FKLhDvgYW3v
	 Osysc9ZAHRrfHw9PRcyUbV93S3c4vhap9kdti4w3/+BOaxXBdqMRqD//ffSO+cu6Zz
	 K5vI1QG/is19xUbLfEH80VNrxpd2B/at91m1VULfCxak0AwBcAp/T7/NCBq8ci4Mtl
	 LxJKeXBmoABgN2zmR7gHpGypo2maq7umGjsW1wDBid03gObx/ZXDbEClUmR8AtO64f
	 4AVV/410BO3T3rIEmQW4q/O7YAR7dOrifJMQIvyZvQTh0uwBbAP3XI57cYWKKE85e8
	 uebONMAHtHTQw==
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Quentin Monnet <quentin@isovalent.com>
Cc: Dmitry Goncharov <dgoncharov@users.sf.net>,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Ian Rogers <irogers@google.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH] tools/build: Fix -s detection code for new make
Date: Wed,  4 Oct 2023 15:59:56 +0200
Message-ID: <20231004135956.987903-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Dmitry described in [1] changelog the current way of detecting
-s option is broken for new make.

Changing the tools/build -s option detection the same way as it was
fixed for root Makefile in [1].

[1] 4bf73588165b ("kbuild: Port silent mode detection to future gnu make.")

Cc: Dmitry Goncharov <dgoncharov@users.sf.net>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/build/Makefile.build | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
index fac42486a8cf..5fb3fb3d97e0 100644
--- a/tools/build/Makefile.build
+++ b/tools/build/Makefile.build
@@ -20,7 +20,15 @@ else
   Q=@
 endif
 
-ifneq ($(findstring s,$(filter-out --%,$(MAKEFLAGS))),)
+# If the user is running make -s (silent mode), suppress echoing of commands
+# make-4.0 (and later) keep single letter options in the 1st word of MAKEFLAGS.
+ifeq ($(filter 3.%,$(MAKE_VERSION)),)
+short-opts := $(firstword -$(MAKEFLAGS))
+else
+short-opts := $(filter-out --%,$(MAKEFLAGS))
+endif
+
+ifneq ($(findstring s,$(short-opts)),)
   quiet=silent_
 endif
 
-- 
2.41.0


