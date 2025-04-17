Return-Path: <bpf+bounces-56089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B46A91159
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 03:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE718446036
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 01:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F701A5BA6;
	Thu, 17 Apr 2025 01:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="k2XxDKhN"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC0015820C;
	Thu, 17 Apr 2025 01:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744854680; cv=none; b=uaVfhNxxBcKWv73mdbawarUnxuHK2Cnr0Eod/H/hjTxDFonfOC8SbJ/E9srJEg9nhd3SFNvxmphorxHs+XexSAgS+lCQtuKVLQdIErMKgvqkliHEAaczPtY85m0Ab3LA1LOJhO1gTC6/plftcw7h/L9i7A9+4J/DuGFiDUCiD9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744854680; c=relaxed/simple;
	bh=vfzTLFgEK9ucCRsjhN2J0R5F3hhlSepXruccDpC8wTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D6ybqnt7n4tKmoDzFOqYRv4L5ldEzGsEybPpMSPXVBx5iUjflRe/bZr8oRyo0RfFVbNvGknFBfvTkn7EGfP5IjkbFXr3YK4/9iwEnnNAaglEUFtTF1qjTpuwDG809w93qRAJLvpa7sn38EhZvx147Jyv/ld+53yY6buDsmTSwUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=k2XxDKhN; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ojiGs
	O5bxjyFDGZgVnWiGgTpQU825RoxetCXi4uKK24=; b=k2XxDKhNbK/vrVtaFL0Ot
	5N5LHPiyKghuLNvkm4RgJEXBShyVBUn5Jk3AVmseeSxvDuhOBqfaM6k0XiXs6ICG
	WcFGW883em6GCOJs08cm9CgQLmJ/nIxBNM+QB0gBStPMx2RQZiikDESxCEBfu1ru
	9aWwalTIGA3eQbIdnwHyIM=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgA3kaEGXgBopyyzAg--.31710S3;
	Thu, 17 Apr 2025 09:48:59 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	hengqi.chen@gmail.com,
	olsajiri@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 bpf-next 1/3] libbpf: Fix event name too long error
Date: Thu, 17 Apr 2025 09:48:46 +0800
Message-Id: <20250417014848.59321-2-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250417014848.59321-1-yangfeng59949@163.com>
References: <20250417014848.59321-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgA3kaEGXgBopyyzAg--.31710S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxtw1fAFy5Ar48WF48KrWrAFb_yoW7uw17pF
	s8Zrn0yF4ftF42vFZ8Jr18ZryFvr4kGF4UJr1DJrsxZF4xWa1UZa42kF4kC34rWrWvvw15
	Za1jgry3Xa4xAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j1q2NUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiTRkyeGgAWamzWgAAsv

From: Feng Yang <yangfeng@kylinos.cn>

When the binary path is excessively long, the generated probe_name in libbpf
exceeds the kernel's MAX_EVENT_NAME_LEN limit (64 bytes).
This causes legacy uprobe event attachment to fail with error code -22.

The fix reorders the fields to place the unique ID before the name.
This ensures that even if truncation occurs via snprintf, the unique ID
remains intact, preserving event name uniqueness. Additionally, explicit
checks with MAX_EVENT_NAME_LEN are added to enforce length constraints.

Before Fix:
	./test_progs -t attach_probe/kprobe-long_name
	......
	libbpf: failed to add legacy kprobe event for 'bpf_testmod_looooooooooooooooooooooooooooooong_name+0x0': -EINVAL
	libbpf: prog 'handle_kprobe': failed to create kprobe 'bpf_testmod_looooooooooooooooooooooooooooooong_name+0x0' perf event: -EINVAL
	test_attach_kprobe_long_event_name:FAIL:attach_kprobe_long_event_name unexpected error: -22
	test_attach_probe:PASS:uprobe_ref_ctr_cleanup 0 nsec
	#13/11   attach_probe/kprobe-long_name:FAIL
	#13      attach_probe:FAIL

	./test_progs -t attach_probe/uprobe-long_name
	......
	libbpf: failed to add legacy uprobe event for /root/linux-bpf/bpf-next/tools/testing/selftests/bpf/test_progs:0x13efd9: -EINVAL
	libbpf: prog 'handle_uprobe': failed to create uprobe '/root/linux-bpf/bpf-next/tools/testing/selftests/bpf/test_progs:0x13efd9' perf event: -EINVAL
	test_attach_uprobe_long_event_name:FAIL:attach_uprobe_long_event_name unexpected error: -22
	#13/10   attach_probe/uprobe-long_name:FAIL
	#13      attach_probe:FAIL
After Fix:
	./test_progs -t attach_probe/uprobe-long_name
	#13/10   attach_probe/uprobe-long_name:OK
	#13      attach_probe:OK
	Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

	./test_progs -t attach_probe/kprobe-long_name
	#13/11   attach_probe/kprobe-long_name:OK
	#13      attach_probe:OK
	Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

Fixes: 46ed5fc33db9 ("libbpf: Refactor and simplify legacy kprobe code")
Fixes: cc10623c6810 ("libbpf: Add legacy uprobe attaching support")
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 tools/lib/bpf/libbpf.c | 43 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b2591f5cab65..940c265acfe2 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -60,6 +60,8 @@
 #define BPF_FS_MAGIC		0xcafe4a11
 #endif
 
+#define MAX_EVENT_NAME_LEN	64
+
 #define BPF_FS_DEFAULT_PATH "/sys/fs/bpf"
 
 #define BPF_INSN_SZ (sizeof(struct bpf_insn))
@@ -11136,16 +11138,16 @@ static const char *tracefs_available_filter_functions_addrs(void)
 			     : TRACEFS"/available_filter_functions_addrs";
 }
 
-static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
-					 const char *kfunc_name, size_t offset)
+static void gen_probe_legacy_event_name(char *buf, size_t buf_sz,
+					const char *name, size_t offset)
 {
 	static int index = 0;
 	int i;
 
-	snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx_%d", getpid(), kfunc_name, offset,
-		 __sync_fetch_and_add(&index, 1));
+	snprintf(buf, buf_sz, "libbpf_%u_%d_%s_0x%zx", getpid(),
+		 __sync_fetch_and_add(&index, 1), name, offset);
 
-	/* sanitize binary_path in the probe name */
+	/* sanitize name in the probe name */
 	for (i = 0; buf[i]; i++) {
 		if (!isalnum(buf[i]))
 			buf[i] = '_';
@@ -11270,9 +11272,9 @@ int probe_kern_syscall_wrapper(int token_fd)
 
 		return pfd >= 0 ? 1 : 0;
 	} else { /* legacy mode */
-		char probe_name[128];
+		char probe_name[MAX_EVENT_NAME_LEN];
 
-		gen_kprobe_legacy_event_name(probe_name, sizeof(probe_name), syscall_name, 0);
+		gen_probe_legacy_event_name(probe_name, sizeof(probe_name), syscall_name, 0);
 		if (add_kprobe_event_legacy(probe_name, false, syscall_name, 0) < 0)
 			return 0;
 
@@ -11328,10 +11330,10 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 					    func_name, offset,
 					    -1 /* pid */, 0 /* ref_ctr_off */);
 	} else {
-		char probe_name[256];
+		char probe_name[MAX_EVENT_NAME_LEN];
 
-		gen_kprobe_legacy_event_name(probe_name, sizeof(probe_name),
-					     func_name, offset);
+		gen_probe_legacy_event_name(probe_name, sizeof(probe_name),
+					    func_name, offset);
 
 		legacy_probe = strdup(probe_name);
 		if (!legacy_probe)
@@ -11875,20 +11877,6 @@ static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, stru
 	return ret;
 }
 
-static void gen_uprobe_legacy_event_name(char *buf, size_t buf_sz,
-					 const char *binary_path, uint64_t offset)
-{
-	int i;
-
-	snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx", getpid(), binary_path, (size_t)offset);
-
-	/* sanitize binary_path in the probe name */
-	for (i = 0; buf[i]; i++) {
-		if (!isalnum(buf[i]))
-			buf[i] = '_';
-	}
-}
-
 static inline int add_uprobe_event_legacy(const char *probe_name, bool retprobe,
 					  const char *binary_path, size_t offset)
 {
@@ -12312,13 +12300,14 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 		pfd = perf_event_open_probe(true /* uprobe */, retprobe, binary_path,
 					    func_offset, pid, ref_ctr_off);
 	} else {
-		char probe_name[PATH_MAX + 64];
+		char probe_name[MAX_EVENT_NAME_LEN];
 
 		if (ref_ctr_off)
 			return libbpf_err_ptr(-EINVAL);
 
-		gen_uprobe_legacy_event_name(probe_name, sizeof(probe_name),
-					     binary_path, func_offset);
+		gen_probe_legacy_event_name(probe_name, sizeof(probe_name),
+					    strrchr(binary_path, '/') ? : binary_path,
+					    func_offset);
 
 		legacy_probe = strdup(probe_name);
 		if (!legacy_probe)
-- 
2.43.0


