Return-Path: <bpf+bounces-34309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F97B92C6A1
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 01:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAFD41C21D1F
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 23:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C19F189F27;
	Tue,  9 Jul 2024 23:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JW+S/rZx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B30B144D00;
	Tue,  9 Jul 2024 23:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720568170; cv=none; b=YHuHivt8WehDGp8cZgA6wnXPa8hv89lmyIRgHVU0W5FzE6Uc7zpdkgY/QPIREdds7PH1MhSbzyKI2JoMhbiKEfk2Ypyn6nT7yK6VcyFrfvEHUAbgAy1EXL49WGD7et7U9IzzvxKiKWTDzmzXPulT91SkvPSDjALfrKGA18O8ynE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720568170; c=relaxed/simple;
	bh=Rzz2X632DwEjauRQmmY8Am/FI63cuDBIHSurv0RdLhc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fpYdXTMy6C3w/az2xnCznEA6GyPAZYFsfWjQbH/P6nS7p3LTaEabt4QBV8FBzTOu06/qgVPAEsdSV3C/ryNDIljgsWLu6fHcLg46AL+vlL3oinFI3qgj/kXDqQz0lGNavAnw5HgGeDcLxlZTOu1ZswnVk2GQiVi/KglrYeoqFLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JW+S/rZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FCCC3277B;
	Tue,  9 Jul 2024 23:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720568169;
	bh=Rzz2X632DwEjauRQmmY8Am/FI63cuDBIHSurv0RdLhc=;
	h=From:To:Cc:Subject:Date:From;
	b=JW+S/rZx4aOJpsB+shqmCv/5NYK6PjmISC3TT4wXUqTG+CIJ7qJl5UmBDCFUwR1Wh
	 /oWjZ5g5tk4NvxZPBbx5eTeVGC/OF8Cl50IIcAJSISBXluUp078i62MFPng4ffImjS
	 wkZyhZSaGM1TnwrQuk54bjrNuj77ajEbbB6wcFu04hRntBCqoAtsOiltYiLBkjChaJ
	 iMqcSexsORGtD0RNydZQOqtCw3u8xvPJYiBqT26dpFAkcJaOfqVTO96fQuPYW73fAL
	 xCAGq75rl7iy4a2FC8gTDLHI/z+KLVs/kfC+4H5vO1AZQoSNRQGEzwvSTO5duC+1qn
	 L9ZZd5fSkOsYw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	Nikolay Kuratov <kniv@yandex-team.ru>,
	bpf@vger.kernel.org
Subject: [PATCH] tracing/kprobes: Fix build error when find_module() is not available
Date: Wed, 10 Jul 2024 08:36:05 +0900
Message-Id: <172056816536.201432.15815034738461167690.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

The kernel test robot reported that the find_module() is not available
if CONFIG_MODULES=n.
Fix this error by hiding find_modules() in #ifdef CONFIG_MODULES with
related rcu locks as try_module_get_by_name().

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407070744.RcLkn8sq-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202407070917.VVUCBlaS-lkp@intel.com/
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |   25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 4cee3442bcce..61a6da808203 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -794,6 +794,24 @@ static int validate_module_probe_symbol(const char *modname, const char *symbol)
 	return 0;
 }
 
+#ifdef CONFIG_MODULES
+/* Return NULL if the module is not loaded or under unloading. */
+static struct module *try_module_get_by_name(const char *name)
+{
+	struct module *mod;
+
+	rcu_read_lock_sched();
+	mod = find_module(name);
+	if (mod && !try_module_get(mod))
+		mod = NULL;
+	rcu_read_unlock_sched();
+
+	return mod;
+}
+#else
+#define try_module_get_by_name(name)	(NULL)
+#endif
+
 static int validate_probe_symbol(char *symbol)
 {
 	struct module *mod = NULL;
@@ -805,12 +823,7 @@ static int validate_probe_symbol(char *symbol)
 		modname = symbol;
 		symbol = p + 1;
 		*p = '\0';
-		/* Return 0 (defer) if the module does not exist yet. */
-		rcu_read_lock_sched();
-		mod = find_module(modname);
-		if (mod && !try_module_get(mod))
-			mod = NULL;
-		rcu_read_unlock_sched();
+		mod = try_module_get_by_name(modname);
 		if (!mod)
 			goto out;
 	}


