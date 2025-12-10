Return-Path: <bpf+bounces-76418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F88CB37A8
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 17:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA86231895EF
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 16:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD5B30DED1;
	Wed, 10 Dec 2025 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="aOJ0iSxS";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="de9WIyVL"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7FE286410;
	Wed, 10 Dec 2025 16:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765384122; cv=none; b=BTOuAGeHhDUxlfPfcp+VRnwPUoGS+c9HoyW8JifsjCRw6D9z+XkZerdxP5fJF1QKd3HUGoVRaXn1FfKc+7lGREWX9nJFxIkzfmKKvONU9fKEuFYAr6GI/GXERS9Cm6sNqEOTzul9SFu+e+UyVQNWSnqsZTdhVepRu/lCjEzgOOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765384122; c=relaxed/simple;
	bh=912PMwC0PW/tyDHiHG7FUN5Pw0l4UWo25uGgaa1GOMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fleiUlEEGYnVoWAFcJ+o5+DnSR770PHD83Cna4nH2IEPfkHVS97DLp1NdPLzsvGpMp2S3B/X06+kVFjbg/StK6xnauoK3FI3G3Nsq0WUZ6HZQkhkyR+3REOM/+F4ZOaxDkZd2muSqyDJcm9gsIWHDG726hJ5If+QDfpEya5kq5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=aOJ0iSxS; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=de9WIyVL; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dRLkZ0f2lz9tWv;
	Wed, 10 Dec 2025 17:28:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1765384118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RYeuZT/X81caxfsas1QmCpH6G2xgwjsZAdIbqpM3ZfQ=;
	b=aOJ0iSxSJvYwFQo7lRkroSmjBptTRSQHYBW2r7qiiMPUuFg0ZWn6rHS4DRN2N8t0FBoCJr
	Sd1vN9e4HDoIhLrrEtA0LaS4SlKc8Nocx+bVrJgDgCGqQcV0y61hFszHatH0Hpoqgx0nvL
	ILvnbabBXYdsT+WygSWixzWjr371Ttozn3cr4ihUZC3eYiU7YmAp16/HEhXaH2Qq1Jvd0a
	kYHYp3YJDyIaHISQc+JVQRIn0NXXkubA8cplW/6UwQ1JDb4339gDOtEkEEtG7TNoINFf26
	2cxhLO7IkEU7fmouGkSQeizmykINNDbVWOTHp/+hUwtQunXLmY1Zz9zCLsqmYg==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=de9WIyVL;
	spf=pass (outgoing_mbo_mout: domain of mhi@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=mhi@mailbox.org
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1765384115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RYeuZT/X81caxfsas1QmCpH6G2xgwjsZAdIbqpM3ZfQ=;
	b=de9WIyVLiDpI908b8pKZLacqqhoHeSduBLsukygDXebC4BX7fTng4iicBtr3/iGxRIs2vX
	dIJNscdmb+XfIqSVHjP1qOXWF8WsUZJv0gGz3z46DBNrGkM3GABboVCzzsGQx5I5PZ4lSc
	P7iKr+hQoLWBQ8/b/nQmaqPON9cBIY4Ac/UAEcvA2MRzgqPgFSg2DhpLcUkBvT6Wp1gAJV
	OaMCECdh8qsQW8xVkSakXFbZPTM5FymQkvGn+N1LF5QS4femEthjgzFY+1EAuOem+cWN9Z
	N6OhNcfJ6bHZYgVpwpEXnwxUuY+y0+Bv+ewylCsV17ZDDV3vzWR0omUvfZtjGA==
To: Alexei Starovoitov <ast@kernel.org>,
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
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Maurice Hieronymus <mhi@mailbox.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] kallsyms: Always initialize modbuildid
Date: Wed, 10 Dec 2025 17:28:15 +0100
Message-ID: <20251210162817.102401-1-mhi@mailbox.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 28eb29aed541ecbee35
X-MBO-RS-META: h9jnwkmtx6xjsbqmmbi8zskj67urhj5c
X-Rspamd-Queue-Id: 4dRLkZ0f2lz9tWv

modbuildid is never set when kallsyms_lookup_buildid is returning via
successful bpf_address_lookup or ftrace_mod_address_lookup.

This leads to an uninitialized pointer dereference on x86 when
CONFIG_STACKTRACE_BUILD_ID=y inside __sprint_symbol.

Prevent this by always initializing modbuildid.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220717
Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 include/linux/filter.h | 6 ++++--
 include/linux/ftrace.h | 4 ++--
 kernel/kallsyms.c      | 4 ++--
 kernel/trace/ftrace.c  | 4 +++-
 4 files changed, 11 insertions(+), 7 deletions(-)

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
index 049e296f586c..b1516d3fa9c5 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -378,11 +378,11 @@ static int kallsyms_lookup_buildid(unsigned long addr,
 				    modname, modbuildid, namebuf);
 	if (!ret)
 		ret = bpf_address_lookup(addr, symbolsize,
-					 offset, modname, namebuf);
+					 offset, modname, modbuildid, namebuf);
 
 	if (!ret)
 		ret = ftrace_mod_address_lookup(addr, symbolsize,
-						offset, modname, namebuf);
+						offset, modname, modbuildid, namebuf);
 
 	return ret;
 }
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 3ec2033c0774..63a926926709 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7749,7 +7749,7 @@ ftrace_func_address_lookup(struct ftrace_mod_map *mod_map,
 
 int
 ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
-		   unsigned long *off, char **modname, char *sym)
+		   unsigned long *off, char **modname, const unsigned char **modbuildid, char *sym)
 {
 	struct ftrace_mod_map *mod_map;
 	int ret = 0;
@@ -7761,6 +7761,8 @@ ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
 		if (ret) {
 			if (modname)
 				*modname = mod_map->mod->name;
+			if (modbuildid)
+				*modbuildid = mod_map->mod->build_id;
 			break;
 		}
 	}

base-commit: 0048fbb4011ec55c32d3148b2cda56433f273375
-- 
2.50.1


