Return-Path: <bpf+bounces-33576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E8891EBDA
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 02:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84A731C21989
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 00:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E143415AF1;
	Tue,  2 Jul 2024 00:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a31P/Xaq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88EADDCB
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 00:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719880320; cv=none; b=fJyyEnTF7XYx34fjWrC+ZohsdGBam3z9b3AtP9b+5mLg//+f2W2Xq66mhfaYLD5DPjU9tNvri7BW7PuoavTluBaETSBVhEb5/6GmOYRQUfRtPbIsg4yok9uaPoVw3nvzePNC4kvDffPAsPFfNqNID3oBsFAMFpLblwgO28V4iBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719880320; c=relaxed/simple;
	bh=4XCpFHRC+aZJ2QuuTXksNfD5FHSZHKvnKM/uYhI5nSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hS3BifC4YOrVfZvhaJ89gRwN1AEzcWK58dhYhb5KGIWWtaIvGlJaD5FyJpdEg1pz263xHcUaTdm0M/OJ9xoxnGQxQvl6mcZmF7rTBoY9DwL9fnSQupLEeNwATM68b6WP6hy+N15eKgdCpNWnfIIOtfAwJdiit445MrfgLeBPCdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a31P/Xaq; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-701fb69e406so1496449a34.3
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2024 17:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719880318; x=1720485118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVf0BOjPzDoW+8o2/Ep68h2Xf/vD/+o27G7pp1oE7Qs=;
        b=a31P/XaqiAlwol2zWDqxc7PC9niCM2I52CznK7XD4SLOjbpKyP/RnpNY//nbn1+c0R
         rk2qKafcVScsmxBcFz0APe8m1GAvR/xRbZ73zY44Tny0743X0gZGiNA1q0vI3H2b/SXX
         5IgdZR3Ku6lidVbPr7q8g0Dssj0Z+OmvEY02s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719880318; x=1720485118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVf0BOjPzDoW+8o2/Ep68h2Xf/vD/+o27G7pp1oE7Qs=;
        b=MqI2jkBWbogR11c4k+RoumcxR8Nj3ewm2w4GF87kEb/YHrdm1dMcwshaZwWMu4Tt7U
         0xmaie9xJBK/onofBn5BBURzVWUTTJJji+f5q/SfxKJT1k9gM4Rvq+UZ5bqw//h1MvNA
         s4/z0uMkpNdPObS7Yiq2hrFIuZHDRSLrvn8XRnLP7DKmm/QS3GbYkwNKPgx4md/PzVpj
         0FoPTCt8eRF27AfTdbqDV4Va+vpt645y8CdZ8y5WdXnmlEdzpzQAm07bdLaYRTLT6MqK
         mvlJQgW/VUV0xsF+Icin8Uyppw7+LO0VM9pNejmoguyE7iWRw69uUGrqE+L+ld8YFZ2j
         E9aw==
X-Forwarded-Encrypted: i=1; AJvYcCW3wXpDxzqyCWZojVTb9oj0q9Upi9BFf5AiGgpbZS6yfoGqpgRtDkLuIGkC12iNFzG8kpWuug0Jev3iQZNHcN4H/7kb
X-Gm-Message-State: AOJu0Yym9GSsGJgKskC4bgXzYuuqYiDZAtc4bJufHL9PLWtcER9GSlGJ
	brUb/Eu9m6pYB5HDLMgQp6CaIbNldA6hhaqKafWNEndUOY7Tuui6HCxVO9yr/w==
X-Google-Smtp-Source: AGHT+IHaqHo4M481FMSmVcSNvoRJBWw0LTfV4q5F195rOeuKqUBjG5+eq48lgLE3X7ajPu+wBHzfYQ==
X-Received: by 2002:a05:6830:14cf:b0:701:ef44:e69c with SMTP id 46e09a7af769-702076be7e0mr6218595a34.10.1719880318087;
        Mon, 01 Jul 2024 17:31:58 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:32ea:b45d:f22f:94c0])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-72c69b5188csm4736064a12.3.2024.07.01.17.31.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 17:31:57 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 3/3] tools build: Correct bpf fixdep dependencies
Date: Mon,  1 Jul 2024 17:29:17 -0700
Message-ID: <20240702003119.3641219-4-briannorris@chromium.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240702003119.3641219-1-briannorris@chromium.org>
References: <20240702003119.3641219-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dependencies in tools/lib/bpf/Makefile are incorrect. Before we
recurse to build $(BPF_IN_STATIC), we need to build its 'fixdep'
executable.

I can't use the usual shortcut from Makefile.include:

  <target>: <sources> fixdep

because its 'fixdep' target relies on $(OUTPUT), and $(OUTPUT) differs
in the parent 'make' versus the child 'make' -- so I imitate it via
open-coding.

I tweak a few $(MAKE) invocations while I'm at it, because
1. I'm adding a new recursive make; and
2. these recursive 'make's print spurious lines about files that are "up
   to date" (which isn't normally a feature in Kbuild subtargets) or
   "jobserver not available" (see [1])

After this change, top-level builds result in an empty grep result from:

  $ grep 'cannot find fixdep' $(find tools/ -name '*.cmd')

[1] https://www.gnu.org/software/make/manual/html_node/MAKE-Variable.html
If we're not using $(MAKE) directly, then we need to use more '+'.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 tools/build/Makefile.include | 10 +++++++++-
 tools/lib/bpf/Makefile       |  6 +++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/build/Makefile.include b/tools/build/Makefile.include
index 8dadaa0fbb43..c95e4773b826 100644
--- a/tools/build/Makefile.include
+++ b/tools/build/Makefile.include
@@ -1,8 +1,16 @@
 # SPDX-License-Identifier: GPL-2.0-only
 build := -f $(srctree)/tools/build/Makefile.build dir=. obj
 
+# More than just $(Q), we sometimes want to suppress all command output from a
+# recursive make -- even the 'up to date' printout.
+ifeq ($(V),1)
+  SILENT_MAKE = +$(Q)$(MAKE)
+else
+  SILENT_MAKE = +$(Q)$(MAKE) --silent
+endif
+
 fixdep:
-	$(Q)$(MAKE) -C $(srctree)/tools/build CFLAGS= LDFLAGS= $(OUTPUT)fixdep
+	$(SILENT_MAKE) -C $(srctree)/tools/build CFLAGS= LDFLAGS= $(OUTPUT)fixdep
 
 fixdep-clean:
 	$(Q)$(MAKE) -C $(srctree)/tools/build clean
diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 2cf892774346..0743cf653615 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -153,7 +153,11 @@ $(BPF_IN_SHARED): force $(BPF_GENERATED)
 	echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h' differs from latest version at 'include/uapi/linux/if_xdp.h'" >&2 )) || true
 	$(Q)$(MAKE) $(build)=libbpf OUTPUT=$(SHARED_OBJDIR) CFLAGS="$(CFLAGS) $(SHLIB_FLAGS)"
 
-$(BPF_IN_STATIC): force $(BPF_GENERATED)
+$(STATIC_OBJDIR):
+	$(Q)mkdir -p $@
+
+$(BPF_IN_STATIC): force $(BPF_GENERATED) | $(STATIC_OBJDIR)
+	$(SILENT_MAKE) -C $(srctree)/tools/build CFLAGS= LDFLAGS= OUTPUT=$(STATIC_OBJDIR) $(STATIC_OBJDIR)fixdep
 	$(Q)$(MAKE) $(build)=libbpf OUTPUT=$(STATIC_OBJDIR)
 
 $(BPF_HELPER_DEFS): $(srctree)/tools/include/uapi/linux/bpf.h
-- 
2.45.2.803.g4e1b14247a-goog


