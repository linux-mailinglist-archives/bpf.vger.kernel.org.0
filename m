Return-Path: <bpf+bounces-34310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 297C192C6A3
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 01:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5A4282C02
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 23:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64E4189F35;
	Tue,  9 Jul 2024 23:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q86xnVCh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BBA187860;
	Tue,  9 Jul 2024 23:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720568196; cv=none; b=Ozu4DWToU1zK+CcdsHJ0CWae/6YVE3cDFGMWaZJ+yXaz8jmFqCpBJgp928OxBmtvPep3bllOva2iiBR3vYYNenEAZTWGMwSpMX7T9ec2yjVaVdvY3AhISBEo+EehQMBYBDvrBr6yKQK+H7XKR9rc3+OyOr3dRTFank83vct6nq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720568196; c=relaxed/simple;
	bh=Rzz2X632DwEjauRQmmY8Am/FI63cuDBIHSurv0RdLhc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NBktTerP3DbvU1vUOLnrB8s908Q6mdFGJ/mWyadmgujgEUYYzgY2aQCQ58uRqB/4vEprP24kmaJwCnjBdMvK4PqtSd+wmp2e7aUkbcv6PpFuaoPak8yoFBJ+E16LIHBXKXqIW7AoB8yd2m/8B+K4JTVV96XRY2oNZ9HVVyYZOac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q86xnVCh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5D4C3277B;
	Tue,  9 Jul 2024 23:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720568195;
	bh=Rzz2X632DwEjauRQmmY8Am/FI63cuDBIHSurv0RdLhc=;
	h=From:To:Cc:Subject:Date:From;
	b=Q86xnVChYU/DBMONx+tr6qDI0rcs0dGHxhY/as7u4nuJ0hWFPa0PHq/HHK9k5HEOn
	 dNbWw7YLZSzW5W/U7+L8AArgG594bqntRmaAFamMQmJGnjsKKeut6mk4aQl/7U7kl2
	 airabSbwKUrk4crKFYJzyJ+c7hakcIC820s2o0Lx4FyhtogC3JcT/pChH0/Akskz4B
	 Fu2QydABN+4dKHrKH8cK5rfZPcijM5MFvO5RBr5HmNbOaIMExEtcmG8fDRM6agIZKM
	 f5qHZ9E3tE4X9PAcoGWY5pYVT3E07UgTzWC70INIIDlATH/FTJVn2MKDM/ROAIR3cl
	 F/CHF55KEooMA==
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
Date: Wed, 10 Jul 2024 08:36:31 +0900
Message-Id: <172056819167.201571.250053007194508038.stgit@devnote2>
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


