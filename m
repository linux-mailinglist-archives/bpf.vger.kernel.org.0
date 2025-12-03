Return-Path: <bpf+bounces-75995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 568BECA1F1E
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 00:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D62C430039E0
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 23:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5D62EDD62;
	Wed,  3 Dec 2025 23:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btOkNqGE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7DE2EC55C;
	Wed,  3 Dec 2025 23:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764804569; cv=none; b=reo1/bK6zdo5A6nWr3KmUkxqJyXEQnxD4T9KJWDefwm+fftCBBuv6D5cSnB8QJlj9dqToyiKB1DYtvc+yw8pqg0acpYvsadSFDQj+ZhfdIiEfxsvIGTQogsw4/fIgNksRZZ+/suzDP5I/umAOfUFXTxehR771/i3x3t+VSHmwtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764804569; c=relaxed/simple;
	bh=Luc9IVfAF83gms1cwO9+dC/IEb/6Bm7GZugt1fCl7+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XluJquNZBQf6BZTNH02y4Ajy8nD1sQzrVyBsQGfoxwUx8Hb35UJbHdBEa7RTy4LUi3HgdeU7ySqT2LXNIN1ybGtDjjOug182bwoya7ewe/Qa/gP7x4m5E8grNPtxBTjN2vNbpB4ibeP0IrLALQrij+z/skdDiEdujAhwheTc9oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btOkNqGE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85574C116C6;
	Wed,  3 Dec 2025 23:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764804569;
	bh=Luc9IVfAF83gms1cwO9+dC/IEb/6Bm7GZugt1fCl7+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=btOkNqGELxaxB04iJ5v6uRZOB0lPxcuQ/Bu/Hkz0aylksUV7vr2WyG9ShVqH1hAR4
	 JExQ4vegyH+aw44QrChLIZALUD4Cks142QFtAC6zoD3IUi6iuO4CQMRhhASFBrKD8n
	 fYMhGaP+N2e/kNi7IXly18Fzn9xldc3gye5lPwxyRbYWazmjDl3i5iKXLUD375gosC
	 aBXOknnqZAoASujlkrgrMPqsILvyV4tKhZk2lqa3U+6kiu+H72NyVI5Uo48eZpWb9M
	 RtEehsDp91Pdf9GuZxQ65P/4QZ1Muq3frc7UIpIKTM40T1Kwc+jllnkXSZQIBmtxct
	 V4/fD5otRNPYg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 2/2] perf tools: Disable BPF skeleton if no libopenssl found
Date: Wed,  3 Dec 2025 15:29:24 -0800
Message-ID: <20251203232924.1119206-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.177.g9f829587af-goog
In-Reply-To: <20251203232924.1119206-1-namhyung@kernel.org>
References: <20251203232924.1119206-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The libopenssl is required by bpftool which is needed to generate BPF
skeleton.  Disable it by setting BUILD_BPF_SKEL to 0 otherwise it'll see
build errors like below:

    CC      /build/util/bpf_skel/.tmp/bootstrap/sign.o
  sign.c:16:10: fatal error: openssl/opensslv.h: No such file or directory
     16 | #include <openssl/opensslv.h>
        |          ^~~~~~~~~~~~~~~~~~~~
  compilation terminated.
  make[3]: *** [Makefile:256: /build/util/bpf_skel/.tmp/bootstrap/sign.o] Error 1
  make[3]: *** Waiting for unfinished jobs....
  make[2]: *** [Makefile.perf:1211: /build/util/bpf_skel/.tmp/bootstrap/bpftool] Error 2
  make[1]: *** [Makefile.perf:287: sub-make] Error 2
  make: *** [Makefile:76: all] Error 2

Now it'll skip the build with the following message:

  Makefile.config:729: Warning: Disabled BPF skeletons as libopenssl is required

Closes: https://lore.kernel.org/r/aP7uq6eVieG8v_v4@google.com
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Makefile.config | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 6b62fea21a0ad1ca..fd72bfbc83b38b3c 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -704,6 +704,11 @@ ifndef NO_LIBBPF
   endif
 endif
 
+ifeq ($(feature-libopenssl), 1)
+  $(call detected,CONFIG_LIBOPENSSL)
+  CFLAGS += -DHAVE_LIBOPENSSL_SUPPORT
+endif
+
 ifndef BUILD_BPF_SKEL
   # BPF skeletons control a large number of perf features, by default
   # they are enabled.
@@ -720,6 +725,9 @@ ifeq ($(BUILD_BPF_SKEL),1)
   else ifeq ($(filter -DHAVE_LIBBPF_SUPPORT, $(CFLAGS)),)
     $(warning Warning: Disabled BPF skeletons as libbpf is required)
     BUILD_BPF_SKEL := 0
+  else ifeq ($(filter -DHAVE_LIBOPENSSL_SUPPORT, $(CFLAGS)),)
+    $(warning Warning: Disabled BPF skeletons as libopenssl is required)
+    BUILD_BPF_SKEL := 0
   else ifeq ($(call get-executable,$(CLANG)),)
     $(warning Warning: Disabled BPF skeletons as clang ($(CLANG)) is missing)
     BUILD_BPF_SKEL := 0
-- 
2.52.0.177.g9f829587af-goog


