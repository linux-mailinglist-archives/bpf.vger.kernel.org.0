Return-Path: <bpf+bounces-11671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B527BD03F
	for <lists+bpf@lfdr.de>; Sun,  8 Oct 2023 23:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 748FE281723
	for <lists+bpf@lfdr.de>; Sun,  8 Oct 2023 21:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EDC1A71F;
	Sun,  8 Oct 2023 21:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nr9xi+td"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0176119BD9;
	Sun,  8 Oct 2023 21:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CA2C433C7;
	Sun,  8 Oct 2023 21:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696800190;
	bh=JkCPUsuUI3/3l9L6acemPj6CRuOU0mfuQCrxMIBBSag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nr9xi+tdBgg1RMISwHGs0IvG2/OwNlvGQV2nj5NTPQztsm+oO3DJzeM3m9n+2q6lg
	 KmL/TLLh6ZMWynHolS+TtHtOGpZeKzBxGFVsS1ftFKzXT821n43VbscpIKdYAWyoNI
	 gGQdGpdHRLXHZY7T/XFWNW1NaRj27UXFsHIEtXDsDPqeVXYmn54+wsXl4P6F1lKoA8
	 IEw9Lc+XKNQmYrcpHMkjDjdNcY/Zb2qilUdA6T/xaEV05p7ELcDI541Om91zo5vlFH
	 CF+unv6d9oCQ6no4uF5BUVVhVm/eCPHt5hUczFTecOcyOjsCtUD25gUHNDzbqFGTqs
	 X0PY4JpBDzrOg==
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
Subject: [PATCHv2 1/2] tools/build: Fix -s detection code in tools/build/Makefile.build
Date: Sun,  8 Oct 2023 23:22:50 +0200
Message-ID: <20231008212251.236023-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231008212251.236023-1-jolsa@kernel.org>
References: <20231008212251.236023-1-jolsa@kernel.org>
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


