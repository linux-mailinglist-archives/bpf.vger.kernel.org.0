Return-Path: <bpf+bounces-77256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84520CD34F1
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 19:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA1AF3017EEF
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 18:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4901030F816;
	Sat, 20 Dec 2025 18:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PABHke2F";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Pl/okMS0"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175D71AF4D5;
	Sat, 20 Dec 2025 18:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766254750; cv=none; b=pzONbfpm+r5Zw3So7ga/9pisJePzJHUF8ap0i98gaFVrFm9R4U0pehx2vpf+C3nadfx11oDN6Agoov7xKfp3Djf91qEDRH9CnzZKwoidooHfeyOp4xAn9+QjgQpOAUW9HcFSuEZ8WGvLV028qQBoVR1nRuqOFSEtn9VE35wbNc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766254750; c=relaxed/simple;
	bh=zc29lxAvDZy9dm/NNdm1x2i2SZYgafqRytEtLdHzEgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7hjktXtjBtH0AaHdnBs+UmfI0Qo1ff6Mk61VliMUubh7ea4RfaFBgQ8ceypoyXaj6o07KXINTfA6t7RQkdVtnHAkArwfpv0/iPHQO0zMIzMJxBuK44AzBUKAaq/hmTY5KobxwyLnixX5ogQYxIiKFNCZkGCQVB0EUxi7cVHLQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=PABHke2F; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Pl/okMS0; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dYXjR0Xksz9t5S;
	Sat, 20 Dec 2025 19:19:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1766254747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5seJozKuDZa9blIWrPh6M6SstzplBd3VXPYTQi2UPxE=;
	b=PABHke2FC8i2I1P0WFb8T9JUkWR5hURVN+LvsuuB9Qzl59ZJ2AywmVIfEnIOoJtf0FtboK
	nyosqSAuaBJjBzTBOWcFUOnbatXwhzYF3GE/lghN7OHvfA1/WnOXinLY/Tl6vPZz2Jmk9Q
	tPzMdcdrIkSOjUkayrcz7lsLuIsfs7vXqEqgNovVxa9HKagxJE3olSW/XUsL1Ki/M0vq0W
	H4q6xvT2pW8YBx2w8Lt1udFomEC1cdQtKBk+vgHDoku64NZ6bAZxlN45yln8Dz2uB0zsM6
	72DD5iynhdeKrIkXxjUn7MMidOBWy7Iz1AQiw9vHbjHtgEEbPUrkBxnuTJ+kcA==
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1766254744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5seJozKuDZa9blIWrPh6M6SstzplBd3VXPYTQi2UPxE=;
	b=Pl/okMS0i0lZuGrTe6Qco3pivJlWM8oS2xkV4dyPMfopzAoViay+kDJg3ap62b4Xa818FF
	JhDZKXClv6bjAy3w6Z96UiQE3nB0tBHW+1X/j/CjTinVIxmin4Yw2ACdGgELcLjXvKCbZ9
	lfhvmgoksEUEO06xURM//dZKIIbAujd3xjXLWYGAUWhBiiGHN7FXvyLjOnjabq4N+O9dpZ
	wTKgxK+ariUxU7fALfjr1y8u9Zoantn41R7sEZtRyopaP4qf/BStkF+/2YSmP75QvVxMnC
	3cOQ1ORwXXsXW0bgq+JS5aC52g7I25fsQAjyvQtDAg64+LhGSUYYg6JT3cAemA==
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com
Cc: georges.aureau@hpe.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhi@mailbox.org
Subject: [PATCH v4 1/2] kallsyms: Always initialize modbuildid on ftrace address
Date: Sat, 20 Dec 2025 19:18:37 +0100
Message-ID: <20251220181838.63242-2-mhi@mailbox.org>
In-Reply-To: <20251220181838.63242-1-mhi@mailbox.org>
References: <20251220181838.63242-1-mhi@mailbox.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ead09bac2c3e3eb23a1
X-MBO-RS-META: 6m6jtq1dprhwizzsmppdbtyzxr1q7qhf

modbuildid is never set when kallsyms_lookup_buildid is returning via
successful ftrace_mod_address_lookup.

This leads to an uninitialized pointer dereference on x86 when
CONFIG_STACKTRACE_BUILD_ID=y inside __sprint_symbol.

Prevent this by always initializing modbuildid.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220717
Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 include/linux/ftrace.h | 4 ++--
 kernel/kallsyms.c      | 2 +-
 kernel/trace/ftrace.c  | 8 +++++++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 770f0dc993cc..ed673fa2536b 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -87,11 +87,11 @@ struct ftrace_hash;
 	defined(CONFIG_DYNAMIC_FTRACE)
 int
 ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
-		   unsigned long *off, char **modname, char *sym);
+		   unsigned long *off, char **modname, const unsigned char **modbuildid, char *sym);
 #else
 static inline int
 ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
-		   unsigned long *off, char **modname, char *sym)
+		   unsigned long *off, char **modname, const unsigned char **modbuildid, char *sym)
 {
 	return 0;
 }
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 049e296f586c..5ca69eafda7a 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -382,7 +382,7 @@ static int kallsyms_lookup_buildid(unsigned long addr,
 
 	if (!ret)
 		ret = ftrace_mod_address_lookup(addr, symbolsize,
-						offset, modname, namebuf);
+						offset, modname, modbuildid, namebuf);
 
 	return ret;
 }
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index ef2d5dca6f70..6eba92a52261 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7752,7 +7752,7 @@ ftrace_func_address_lookup(struct ftrace_mod_map *mod_map,
 
 int
 ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
-		   unsigned long *off, char **modname, char *sym)
+		   unsigned long *off, char **modname, const unsigned char **modbuildid, char *sym)
 {
 	struct ftrace_mod_map *mod_map;
 	int ret = 0;
@@ -7764,6 +7764,12 @@ ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
 		if (ret) {
 			if (modname)
 				*modname = mod_map->mod->name;
+			if (modbuildid)
+#ifdef CONFIG_STACKTRACE_BUILD_ID
+				*modbuildid = mod_map->mod->build_id;
+#else
+				*modbuildid = NULL;
+#endif
 			break;
 		}
 	}
-- 
2.50.1


