Return-Path: <bpf+bounces-76293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8861CADBB9
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 17:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B1D2304BD93
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 16:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDAB2E718F;
	Mon,  8 Dec 2025 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BIKsjaZ4"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350E62652B6;
	Mon,  8 Dec 2025 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765210898; cv=none; b=jB6KgZUZc+JLNgeWQyglDY599bUIIZOt/0slwbu7G4PUu/IltoYq/6L1TvWajTSR4TeYooZZawCfxjwg+l7Wbq35WbPPZ3Q2B3m0DWGYnzBZWKt7Lt7R2f47ZLjD9fXGyhiz63y+qj2fgYoRb+bW4nScQmhWNCzn0YS2efglEEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765210898; c=relaxed/simple;
	bh=ZD71hBYxaR+ZHzEmU8BhHeNKlVJKQGBG8vgqedg1ZWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AfoTca2Ks9MVeQ8xW8JCYpHUk+NGIchlDTNaPHtHuHrYAr1uOc4vwZaZLazCCiqu3uutuMUSY2OYWkF2HKIAopvoIeHwGPr43gwjeyPi+tvc31D9mRGjyfsXKQshoHW6UoTmzXHh30uMwk5I0duKfgw6XBDnCMvjD9MJA7MYyhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BIKsjaZ4; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765210896; x=1796746896;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZD71hBYxaR+ZHzEmU8BhHeNKlVJKQGBG8vgqedg1ZWw=;
  b=BIKsjaZ4XRlq5Gfcy7T+uxz9eaMZVcSqPmAvha8Ov91Ctn52hGAgtrlZ
   5XqIr2y2fzgul4VoM+THgN5GuxL2Ah3nQdilaKuQY8c+GSMrkwJoEzjqN
   z+AYHoZvYLE5K3Zs+I0km4YBv9XdTfzmBbRrNX/kk3DyQoItX2ITvdMrY
   FiOO0Q5MJrfFnldt94wjHwSBxGSotoeLZmuVaA9BCFJyFmktadYaYARx3
   MvJvHrM1CmLlKFgRgSFwraOMf02GlN7bY6N2QDPc/YRydPp59192ScPx7
   KSKEU73X/8qdlZnLkoW2PkFc1HSSXkT/3Wg8E/RfXQAsrtiRmQFHcRG2w
   Q==;
X-CSE-ConnectionGUID: 7opAbvFiTyCeBnNsM0rdZA==
X-CSE-MsgGUID: 9ZPWAGQxRamfs/j9OTyIcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="70774720"
X-IronPort-AV: E=Sophos;i="6.20,259,1758610800"; 
   d="scan'208";a="70774720"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 08:21:29 -0800
X-CSE-ConnectionGUID: nMn0+/xjRumNVi0ANFOSqA==
X-CSE-MsgGUID: c/4HKgiUTneN4J5vqgLYbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,259,1758610800"; 
   d="scan'208";a="200136395"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 08 Dec 2025 08:21:24 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id E27AD98; Mon, 08 Dec 2025 17:21:22 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alexei Starovoitov <ast@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
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
	Matt Bobrowski <mattbobrowski@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v1 1/1] bpf: Mark BPF printing functions with __printf() attribute
Date: Mon,  8 Dec 2025 17:18:01 +0100
Message-ID: <20251208161800.2902699-2-andriy.shevchenko@linux.intel.com>
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

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512061425.x0qTt9ww-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202512061640.9hKTnB8p-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202512081321.2h9ThWTg-lkp@intel.com/
Fixes: 10aceb629e19 ("bpf: Add bpf_trace_vprintk helper")
Fixes: 7b15523a989b ("bpf: Add a bpf_snprintf helper")
Fixes: 492e639f0c22 ("bpf: Add bpf_seq_printf and bpf_seq_write helpers")
Fixes: f3694e001238 ("bpf: add BPF_CALL_x macros for declaring helpers")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

This is combined change and I think there is no need to split it, but if required
I can do it in a four changes. Note, the culprits are older than 4 years and stable
kernels anyway don't go that deep nowadays.

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


