Return-Path: <bpf+bounces-77257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE386CD34FA
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 19:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71B11302489A
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 18:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0413D30FC2E;
	Sat, 20 Dec 2025 18:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="EjPvUn6a";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Iua1DD3y"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0FD30F94D;
	Sat, 20 Dec 2025 18:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766254753; cv=none; b=KN7qjyZyrDg4Yn4ZB6c6SSu1ovudsCT1MFlIHWNhF8p91Z50g9SRvWpKW4d8OcJU8i9J1s5+t2jIbhqZHFQSjS4UjlLIN+r1R6MaJg0vPpgaiQfHwKwLXZ6N2obGCQQ0/meqmVeO65oElXMSI2/VHiDa0TTrrwaBGOfc90+tJV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766254753; c=relaxed/simple;
	bh=WdoUR0jNUdSohzunsK9JzqfL7Dc2cqt/x4EOV4z9gq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mib7T7LJwPdReze/xQ7Ru0697fKGtxQ/47QQZUHCX/vN+jsBdzCK4KDbYTbb8fjFFf0BiKpDKeRUoOWBnYmPcNcp4YFDrfyZKTgifBjtJLtYQ3dcLsAyd8JUEEY4DF1Kqq0NrCxHS0shD7O3ihe5Ns/h9Tt+9HGw4CZvjGvU6aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=EjPvUn6a; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Iua1DD3y; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dYXjT6G7Fz9thy;
	Sat, 20 Dec 2025 19:19:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1766254749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Jer3RuZGuNqVffmHdtz7YJt/+r6Rq84DhSrnUBE9+M=;
	b=EjPvUn6aIbwIWqSBGGMZX/JDQX8wOgmYB9GtyoIMY6LALdK+cmYeeMOhh9n1o2/H3peHvW
	9mwghE/+j1VQTVD8KoJDOaiI/Cl8ZdK1NmtkNrS4CPOfCCeUxfnlk13ZFffkDgAWpLE3Im
	Gcx4FNpVqnPszaT9Bgh31ewPsiLrsKX2u5q9irFZq6JNDEdTMUr+hl1RY8+mRI/5tGD3M9
	2HbVbJV64LOoB7N6jLSpu//epe+dB9boyOlhx4oNI9MItt9p3p9o6AUUDOia53X8bhyy05
	76nqOOlkMZI6aoCZldqjBUvwFq592o3DODsGnkejNW7NzOcxhjYwgBPvQ7oH9g==
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1766254747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Jer3RuZGuNqVffmHdtz7YJt/+r6Rq84DhSrnUBE9+M=;
	b=Iua1DD3yuEOK9m8TxXbIQcFPyh52YsYbdk5LNA7nlpeDu6GRlYj7IZF9h6LzL7q9DuzDgW
	Nhw9cNq+n4PfUXRUZubEznaO32dTReUbuRlCZfgE82WgO/xxO+Z6TPVh0onWOuGVdvYm39
	aEQtB8ij/gggjZIun7wjEH2DClBSikrT5QJhH6Q8G6EaWiB/pHtk/HFYQKnWzgT4tRA3cs
	Tgl1Id4vpIR+ua48KI6fOAZt9dByHXKjOhxsizyzFWD959H07aYVQ0U9sZS/pVIoGFszhk
	chUWu47vyNTpsjxk/Sz48CzpT45MjY8CGfilsfdzApphdtOpZW/tMJ7fiBYdyg==
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
Subject: [PATCH v4 2/2] kallsyms: Always initialize modbuildid on bpf address
Date: Sat, 20 Dec 2025 19:18:38 +0100
Message-ID: <20251220181838.63242-3-mhi@mailbox.org>
In-Reply-To: <20251220181838.63242-1-mhi@mailbox.org>
References: <20251220181838.63242-1-mhi@mailbox.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 39ur65abrfy961gkcam8h91bdnqxe1ti
X-MBO-RS-ID: e771729da8b79c55382

modbuildid is never set when kallsyms_lookup_buildid is returning via
successful bpf_address_lookup.

This leads to an uninitialized pointer dereference on x86 when
CONFIG_STACKTRACE_BUILD_ID=y inside __sprint_symbol.

Prevent this by always initializing modbuildid.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220717
Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 include/linux/filter.h | 6 ++++--
 kernel/kallsyms.c      | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index fd54fed8f95f..eb1d1c876503 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1384,12 +1384,14 @@ struct bpf_prog *bpf_prog_ksym_find(unsigned long addr);
 
 static inline int
 bpf_address_lookup(unsigned long addr, unsigned long *size,
-		   unsigned long *off, char **modname, char *sym)
+		   unsigned long *off, char **modname, const unsigned char **modbuildid, char *sym)
 {
 	int ret = __bpf_address_lookup(addr, size, off, sym);
 
 	if (ret && modname)
 		*modname = NULL;
+	if (ret && modbuildid)
+		*modbuildid = NULL;
 	return ret;
 }
 
@@ -1455,7 +1457,7 @@ static inline struct bpf_prog *bpf_prog_ksym_find(unsigned long addr)
 
 static inline int
 bpf_address_lookup(unsigned long addr, unsigned long *size,
-		   unsigned long *off, char **modname, char *sym)
+		   unsigned long *off, char **modname, const unsigned char **modbuildid, char *sym)
 {
 	return 0;
 }
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 5ca69eafda7a..b1516d3fa9c5 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -378,7 +378,7 @@ static int kallsyms_lookup_buildid(unsigned long addr,
 				    modname, modbuildid, namebuf);
 	if (!ret)
 		ret = bpf_address_lookup(addr, symbolsize,
-					 offset, modname, namebuf);
+					 offset, modname, modbuildid, namebuf);
 
 	if (!ret)
 		ret = ftrace_mod_address_lookup(addr, symbolsize,
-- 
2.50.1


