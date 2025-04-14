Return-Path: <bpf+bounces-55846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB59EA87BFF
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 11:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B5B1893B93
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 09:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D31626562C;
	Mon, 14 Apr 2025 09:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="G2majBNR"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF6C257AC8;
	Mon, 14 Apr 2025 09:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744623344; cv=none; b=GupNzPKCINED4PVsCSljWM7uc4zGnVgK5gXEK7KPckgpF/0aEwqGJ+6a/cYq2n8y0ztxFqnEW43QHlcL8qnRGkxwZgFyaeVt2SzRR/2xFcRDNWhhC+cKjjevnLJASuRPNjONWjZMySUAUfEnh9QFDs//DkJyZDb9bkaRb+QPJEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744623344; c=relaxed/simple;
	bh=qofaBpaVa18j32xfzQZLhDpGoO0stebsJoK1bv09/7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=paFJ0Om27LJHOu6VBifSSTAWdqxAgv9HOwpLQYmxYzPvkcjp2TRpSIjnlZ25zfjUdrClGgLW92Kin+zT7JOfaflywWAHb6F9A9siB0omYS2zoS6w7CfFjbAbywWmW4vga4m8dqOVPA39oyIfV1SXOQK3aOGQC3D8gixQdm46Urg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=G2majBNR; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=eExAn
	PO2f4LGlgR4ad3HevDpupPLJHXCFOUKXNGyZsI=; b=G2majBNRLIDFPgB2f2RQZ
	j3fOCvU80fzLKf+50eUgfDgQeEpKNLlDgWCMj6oNYNzL4+NyuIbNAZM5j/wAdbKr
	doDs+HoEFaGRDDzZ/dsy1OAsrnwSxNppkq/YyoXIg8ZO9a+4x1NXKBq2M+riHSAv
	FHDJiLTDwya8V/9kQss6lk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnj1Sb1vxnxkYWGg--.23370S3;
	Mon, 14 Apr 2025 17:34:22 +0800 (CST)
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
	hengqi.chen@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 bpf-next 1/3] libbpf: Fix event name too long error
Date: Mon, 14 Apr 2025 17:34:00 +0800
Message-Id: <20250414093402.384872-2-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250414093402.384872-1-yangfeng59949@163.com>
References: <20250414093402.384872-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnj1Sb1vxnxkYWGg--.23370S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFW7WryxZrWDZF47JFyfXrb_yoWrtr48pF
	4DZrn0yF4ftay29FZ8Jrn5Z34F9r1kGFWUJr1DJr9xZF4xWF4UZa42kF4DCF15WrZ2vay3
	Aa1jgry3Xa4xAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYlkxUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiwhwveGf808xdSAAAsY

From: Feng Yang <yangfeng@kylinos.cn>

When the binary path is excessively long, the generated probe_name in libbpf
exceeds the kernel's MAX_EVENT_NAME_LEN limit (64 bytes).
This causes legacy uprobe event attachment to fail with error code -22.

Before Fix:
	./test_progs -t attach_probe/kprobe-long_name
	......
	libbpf: failed to add legacy kprobe event for 'bpf_kfunc_looooooooooooooooooooooooooooooong_name+0x0': -EINVAL
	libbpf: prog 'handle_kprobe': failed to create kprobe 'bpf_kfunc_looooooooooooooooooooooooooooooong_name+0x0' perf event: -EINVAL
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
 tools/lib/bpf/libbpf.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b2591f5cab65..9e047641e001 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -60,6 +60,8 @@
 #define BPF_FS_MAGIC		0xcafe4a11
 #endif
 
+#define MAX_EVENT_NAME_LEN	64
+
 #define BPF_FS_DEFAULT_PATH "/sys/fs/bpf"
 
 #define BPF_INSN_SZ (sizeof(struct bpf_insn))
@@ -11142,10 +11144,10 @@ static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
 	static int index = 0;
 	int i;
 
-	snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx_%d", getpid(), kfunc_name, offset,
-		 __sync_fetch_and_add(&index, 1));
+	snprintf(buf, buf_sz, "libbpf_%u_%d_%s_0x%zx", getpid(),
+		 __sync_fetch_and_add(&index, 1), kfunc_name, offset);
 
-	/* sanitize binary_path in the probe name */
+	/* sanitize kfunc_name in the probe name */
 	for (i = 0; buf[i]; i++) {
 		if (!isalnum(buf[i]))
 			buf[i] = '_';
@@ -11270,7 +11272,7 @@ int probe_kern_syscall_wrapper(int token_fd)
 
 		return pfd >= 0 ? 1 : 0;
 	} else { /* legacy mode */
-		char probe_name[128];
+		char probe_name[MAX_EVENT_NAME_LEN];
 
 		gen_kprobe_legacy_event_name(probe_name, sizeof(probe_name), syscall_name, 0);
 		if (add_kprobe_event_legacy(probe_name, false, syscall_name, 0) < 0)
@@ -11328,7 +11330,7 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 					    func_name, offset,
 					    -1 /* pid */, 0 /* ref_ctr_off */);
 	} else {
-		char probe_name[256];
+		char probe_name[MAX_EVENT_NAME_LEN];
 
 		gen_kprobe_legacy_event_name(probe_name, sizeof(probe_name),
 					     func_name, offset);
@@ -11878,9 +11880,12 @@ static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, stru
 static void gen_uprobe_legacy_event_name(char *buf, size_t buf_sz,
 					 const char *binary_path, uint64_t offset)
 {
+	static int index = 0;
 	int i;
 
-	snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx", getpid(), binary_path, (size_t)offset);
+	snprintf(buf, buf_sz, "libbpf_%u_%d_%s_0x%zx", getpid(),
+		 __sync_fetch_and_add(&index, 1),
+		 basename((void *)binary_path), (size_t)offset);
 
 	/* sanitize binary_path in the probe name */
 	for (i = 0; buf[i]; i++) {
@@ -12312,7 +12317,7 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 		pfd = perf_event_open_probe(true /* uprobe */, retprobe, binary_path,
 					    func_offset, pid, ref_ctr_off);
 	} else {
-		char probe_name[PATH_MAX + 64];
+		char probe_name[MAX_EVENT_NAME_LEN];
 
 		if (ref_ctr_off)
 			return libbpf_err_ptr(-EINVAL);
-- 
2.43.0


