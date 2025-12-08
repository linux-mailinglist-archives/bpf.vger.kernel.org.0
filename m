Return-Path: <bpf+bounces-76289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 75285CADA38
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 16:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07E28301D626
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 15:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A963224B1B;
	Mon,  8 Dec 2025 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LEb+kpnn"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C879E1D86FF;
	Mon,  8 Dec 2025 15:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765208872; cv=none; b=q7ehg/o3S3ObqGuDvv8e7V4PIewXDesQA42v8DI3ElGxZW1UuE1qUgLx8V+sxu0tQX5ufVRLeRgFnxsgcCwNIOeKJewOe+6jNn0j9JdRQvXLb1ip3007W5nsW7K387VBO3wr/kHAG6+HPUPI1yow80/mZmXemDpVI7UVy5fxN08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765208872; c=relaxed/simple;
	bh=xF1zaGreaMniCM5CNPSiAEiGyhOLswX+I31/sLqARBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QspgXTMtH37+A9thdx74VNFPGLIX2pFfWIMPMrgAU5FOSHRnpn2eRgYXev4W0w6hj04L3yqgmg+lWp+M0GFzR+X0vJYK15ohz6Mhs5alBmAlqH/RaE0wCFsZuLFyY8IPlCXRZsIwOzqp9qJVVNfaycAZjCUrXkpi+3HmZnjM590=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LEb+kpnn; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765208871; x=1796744871;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xF1zaGreaMniCM5CNPSiAEiGyhOLswX+I31/sLqARBw=;
  b=LEb+kpnnUA/vbfjsZpwOAD3PgyEgwlZLiDOPRDtl3ixruaPsdvrLHKYS
   7Z4pFTyFE5CYknwgBzaVshMvTyECU+70tF0NkH9EvMwY1rN2Ii1br21+L
   IsI+sxgtaD48SrDHJbYvrikEcY+2AOHjPQcmpsIZUhAwYCIrQk0Yr7wJA
   Non5+DYwyG6HTHond54VE3kdDuA9NaaQM/K/hemFD5l0LN2faC5iPug2L
   mHaPOJ6QGI2KLFLZvby/QmiTJGGvu+baMHBISjWPLATMLpC0FKHRFwFZR
   YdEAl7F4RHYOuMpDEUofad1OOisnt+YSdycG1hCSL1SbC1hAZFHYCUr7e
   w==;
X-CSE-ConnectionGUID: DXvURgTgQVOU+1/Fqo+G/Q==
X-CSE-MsgGUID: btmumwHvRGmm8v8p2hoX2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="78510617"
X-IronPort-AV: E=Sophos;i="6.20,259,1758610800"; 
   d="scan'208";a="78510617"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 07:47:50 -0800
X-CSE-ConnectionGUID: RPr1hMxCTG6erqF5TKd4aw==
X-CSE-MsgGUID: tbK4SwKkQjalcfP0P8R/iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,259,1758610800"; 
   d="scan'208";a="196732625"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 08 Dec 2025 07:47:46 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id E65A498; Mon, 08 Dec 2025 16:47:44 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alexei Starovoitov <ast@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
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
	Matt Bobrowski <mattbobrowski@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mirsad Todorovac <mtodorovac69@yahoo.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] : Mark BPF printing functions with __printf() attribute
Date: Mon,  8 Dec 2025 16:47:33 +0100
Message-ID: <20251208154733.2901633-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The printing functions in BPF code are using printf() type of format,
and compiler is not happy about them as is:

kernel/bpf/helpers.c:1069:9: error: function ‘____bpf_snprintf’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
 1069 |         err = bstr_printf(str, str_size, fmt, data.bin_args);
      |         ^~~

kernel/trace/bpf_trace.c:377:9: error: function ‘____bpf_trace_printk’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
  377 |         ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.bin_args);
      |         ^~~

kernel/trace/bpf_trace.c:433:9: error: function ‘____bpf_trace_vprintk’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
  433 |         ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.bin_args);
      |         ^~~

kernel/trace/bpf_trace.c:475:9: error: function ‘____bpf_seq_printf’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
  475 |         seq_bprintf(m, fmt, data.bin_args);
      |         ^~~~~~~~~~~

Fix the compilation errors by adding __printf() attribute. For that
we need to pass it down to the BPF_CALL_x() and wrap into PRINTF_BPF_CALL_*()
to make code neater.

| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512061425.x0qTt9ww-lkp@intel.com/
| Closes: https://lore.kernel.org/oe-kbuild-all/202512061640.9hKTnB8p-lkp@intel.com/
| Closes: https://lore.kernel.org/oe-kbuild-all/202512081321.2h9ThWTg-lkp@intel.com/

Fixes:
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/filter.h   | 24 +++++++++++++++---------
 kernel/bpf/helpers.c     |  2 +-
 kernel/trace/bpf_trace.c |  6 +++---
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index fd54fed8f95f..31034a74af22 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -607,9 +607,9 @@ static inline bool insn_is_cast_user(const struct bpf_insn *insn)
 	__BPF_MAP(n, __BPF_DECL_ARGS, __BPF_N, u64, __ur_1, u64, __ur_2,       \
 		  u64, __ur_3, u64, __ur_4, u64, __ur_5)
 
-#define BPF_CALL_x(x, attr, name, ...)					       \
+#define BPF_CALL_x(x, __attr, attr, name, ...)				       \
 	static __always_inline						       \
-	u64 ____##name(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__));   \
+	__attr u64 ____##name(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__));     \
 	typedef u64 (*btf_##name)(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__)); \
 	attr u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__));    \
 	attr u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__))     \
@@ -620,14 +620,20 @@ static inline bool insn_is_cast_user(const struct bpf_insn *insn)
 	u64 ____##name(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__))
 
 #define __NOATTR
-#define BPF_CALL_0(name, ...)	BPF_CALL_x(0, __NOATTR, name, __VA_ARGS__)
-#define BPF_CALL_1(name, ...)	BPF_CALL_x(1, __NOATTR, name, __VA_ARGS__)
-#define BPF_CALL_2(name, ...)	BPF_CALL_x(2, __NOATTR, name, __VA_ARGS__)
-#define BPF_CALL_3(name, ...)	BPF_CALL_x(3, __NOATTR, name, __VA_ARGS__)
-#define BPF_CALL_4(name, ...)	BPF_CALL_x(4, __NOATTR, name, __VA_ARGS__)
-#define BPF_CALL_5(name, ...)	BPF_CALL_x(5, __NOATTR, name, __VA_ARGS__)
+#define BPF_CALL_0(name, ...)	BPF_CALL_x(0, __NOATTR, __NOATTR, name, __VA_ARGS__)
+#define BPF_CALL_1(name, ...)	BPF_CALL_x(1, __NOATTR, __NOATTR, name, __VA_ARGS__)
+#define BPF_CALL_2(name, ...)	BPF_CALL_x(2, __NOATTR, __NOATTR, name, __VA_ARGS__)
+#define BPF_CALL_3(name, ...)	BPF_CALL_x(3, __NOATTR, __NOATTR, name, __VA_ARGS__)
+#define BPF_CALL_4(name, ...)	BPF_CALL_x(4, __NOATTR, __NOATTR, name, __VA_ARGS__)
+#define BPF_CALL_5(name, ...)	BPF_CALL_x(5, __NOATTR, __NOATTR, name, __VA_ARGS__)
 
-#define NOTRACE_BPF_CALL_1(name, ...)	BPF_CALL_x(1, notrace, name, __VA_ARGS__)
+#define PRINTF_BPF_CALL_x(p, name, x, ...)				       \
+	BPF_CALL_x(x, __printf(p, 0), __NOATTR, name, __VA_ARGS__)
+
+#define PRINTF_BPF_CALL_4(p, name, ...)		PRINTF_BPF_CALL_x(p, name, 4, __VA_ARGS__)
+#define PRINTF_BPF_CALL_5(p, name, ...)		PRINTF_BPF_CALL_x(p, name, 5, __VA_ARGS__)
+
+#define NOTRACE_BPF_CALL_1(name, ...)	BPF_CALL_x(1, __NOATTR, notrace, name, __VA_ARGS__)
 
 #define bpf_ctx_range(TYPE, MEMBER)						\
 	offsetof(TYPE, MEMBER) ... offsetofend(TYPE, MEMBER) - 1
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index db72b96f9c8c..cbc66865e3dc 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1046,7 +1046,7 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
 	return err;
 }
 
-BPF_CALL_5(bpf_snprintf, char *, str, u32, str_size, char *, fmt,
+PRINTF_BPF_CALL_5(3, bpf_snprintf, char *, str, u32, str_size, char *, fmt,
 	   const void *, args, u32, data_len)
 {
 	struct bpf_bprintf_data data = {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d57727abaade..5fd46b4bcf48 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -359,7 +359,7 @@ static const struct bpf_func_proto bpf_probe_write_user_proto = {
 #define MAX_TRACE_PRINTK_VARARGS	3
 #define BPF_TRACE_PRINTK_SIZE		1024
 
-BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
+PRINTF_BPF_CALL_5(1, bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
 	   u64, arg2, u64, arg3)
 {
 	u64 args[MAX_TRACE_PRINTK_VARARGS] = { arg1, arg2, arg3 };
@@ -412,7 +412,7 @@ const struct bpf_func_proto *bpf_get_trace_printk_proto(void)
 	return &bpf_trace_printk_proto;
 }
 
-BPF_CALL_4(bpf_trace_vprintk, char *, fmt, u32, fmt_size, const void *, args,
+PRINTF_BPF_CALL_4(1, bpf_trace_vprintk, char *, fmt, u32, fmt_size, const void *, args,
 	   u32, data_len)
 {
 	struct bpf_bprintf_data data = {
@@ -455,7 +455,7 @@ const struct bpf_func_proto *bpf_get_trace_vprintk_proto(void)
 	return &bpf_trace_vprintk_proto;
 }
 
-BPF_CALL_5(bpf_seq_printf, struct seq_file *, m, char *, fmt, u32, fmt_size,
+PRINTF_BPF_CALL_5(2, bpf_seq_printf, struct seq_file *, m, char *, fmt, u32, fmt_size,
 	   const void *, args, u32, data_len)
 {
 	struct bpf_bprintf_data data = {
-- 
2.50.1


