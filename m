Return-Path: <bpf+bounces-76419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB71CB38E3
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 18:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF042305758B
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 17:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B228326936;
	Wed, 10 Dec 2025 17:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VU4AKrL/";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="p0qpUSdB"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AA523D7CE;
	Wed, 10 Dec 2025 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765386247; cv=none; b=WGYojmnWpcbGzHkh+TycBQzRtNIJq/gpq1+QRTrU1QS4lzGcMEPG8k2iv7wo4dvO42f+b2Bb2nsFFwQSgHAhox+kOWENIwoDp1dswZNf7nnVGUROR5GGjD0ATNq1K/Dk87L3IMZvnCeVNLbq+k436YWp73KhEgZ8DgU3tFdFUfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765386247; c=relaxed/simple;
	bh=Hu2AttW4xzY26nsM9I2ujaUsTANNkYeDrhL6cP9EuYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YnRtnP/tIwnzJecJo70RVyMAehn71vYmJi/KI1MzxvsoUmPiq30dmHXeviuk1dPr0BkWQTmbaPFWWvRYbqmqe3WWnTTKZJM1+PmHR+9lFv3m1wi6UGZAurKeQVNeTdy3XZsvMBCVY2Zw/7eZoedE8aJntj+IIB9S8fFdIEIefg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=VU4AKrL/; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=p0qpUSdB; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dRMWQ5gNtz9sm3;
	Wed, 10 Dec 2025 18:04:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1765386242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7Jo2RTOWuHkU87jPUoJ6/w2UPT3Mu6jcGyYVn5ez6a4=;
	b=VU4AKrL/e8m3o9fw9vMTYnOU1c/izwoeEWXpcWOy6lnf3jb7xDrpZT/ZLQZ8MQ92zFtZJh
	o5lhjsBTKZPmaJ03UJZAJz31XKRM/eDWtjcWuVR9DWsn4axrFJbmMMwwMBKIsoAHPlmMg1
	gVgqOrjei4fI/ATSUyGk+ybbxFDf0i/VFE4XWGeqg+mPPHWlRqsi1Bn4yGocER1ZubAJQX
	HqVpdQOKWXCXx66GvWc99j2biGF9bj6RbUIGR8Ac2HBXQK11cSocPbf/V1ZeswrDNhbzCq
	B0UvBwKQ05Mqey0I1KkHg2WGvfj3SU6mD3Lng4fFJspJuNJdozzzUOMAPoKiPg==
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1765386240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7Jo2RTOWuHkU87jPUoJ6/w2UPT3Mu6jcGyYVn5ez6a4=;
	b=p0qpUSdB2+ZqnsNWdpH5zQ2TBXumTS/3i8bs7DV0e/qkcNutHTBdssoBCD5N5uHFomyRyf
	sEkjPw0BKTuZVVwjGeFXfdsNYE0Kh9bofAo/J2qlmnS3Mp9l3DA59M3vZDRjo/U0FSsc3y
	xXpLUMSEvklh86RDY1D9rSxGY/KAZm8ka8PH8z2NEDb74Rx4JfJPvW7DQQFpZn8vR+Nb2x
	Sged0q/5hfpN8v7v39H4/fwQNbPLm6yH6zl/bM7xTCUo7SDdi3xLvkLMvRpgpvEA74es3r
	Jlz2V2uUJR0ey/BU77y/kqJmZTI4TpbOo158ZQlz7HRyeH2JFrrZz+tJTNQjVw==
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: georges.aureau@hpe.com,
	Maurice Hieronymus <mhi@mailbox.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3] kallsyms: Always initialize modbuildid
Date: Wed, 10 Dec 2025 18:03:45 +0100
Message-ID: <20251210170347.28053-1-mhi@mailbox.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 95k41dfegnbfup8dbni7ezdyb4o5sz3n
X-MBO-RS-ID: 45020c523c85462699b

modbuildid is never set when kallsyms_lookup_buildid is returning via
successful bpf_address_lookup or ftrace_mod_address_lookup.

This leads to an uninitialized pointer dereference on x86 when
CONFIG_STACKTRACE_BUILD_ID=y inside __sprint_symbol.

Prevent this by always initializing modbuildid.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220717
Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
Changes to v2:
 - Check if CONFIG_STACKTRACE_BUILD_ID is enabled to prevent build fail
Changes to v1:
 - Set modbuildid in ftrace_func_address_lookup

 include/linux/filter.h | 6 ++++--
 include/linux/ftrace.h | 4 ++--
 kernel/kallsyms.c      | 4 ++--
 kernel/trace/ftrace.c  | 8 +++++++-
 4 files changed, 15 insertions(+), 7 deletions(-)

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
index 3ec2033c0774..4e4aef987747 100644
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
@@ -7761,6 +7761,12 @@ ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
 		if (ret) {
 			if (modname)
 				*modname = mod_map->mod->name;
+			if (modbuildid)
+#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
+				*modbuildid = mod_map->mod->build_id;
+#else
+				*modbuildid = NULL;
+#endif
 			break;
 		}
 	}

base-commit: 0048fbb4011ec55c32d3148b2cda56433f273375
-- 
2.50.1


