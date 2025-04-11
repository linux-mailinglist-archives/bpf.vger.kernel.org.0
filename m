Return-Path: <bpf+bounces-55711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F200FA85628
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 10:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CA279A5491
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 08:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B561329347D;
	Fri, 11 Apr 2025 08:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SnvHmIab"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBB41DDC04;
	Fri, 11 Apr 2025 08:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744358793; cv=none; b=Pl+txfD5o/mS5Fpp9oIaEXa4TMU4k5tMO+urjuMC9q0h2vYdqr6FRbkz8xqhnAN3sgVojCC7VIB23yW1a7xSLeOzlibZVOgKKXSXHzUokBN8qlXO+a+f7ntMgcnQZQKftZkAMBXC8pHvZh6T4YDEpDJwRvhxqJoNv1l9m/kqGBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744358793; c=relaxed/simple;
	bh=aZHzk9mHUHuKkgLKuqiBfClbxLb+SK7ytOYvOtjiLf0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mv1ymbOJXEra/+dP/8kyW1XKUjiPd+SW1Bv/9xYibPE2mwWOjiv7/Z7tGQZVhw8oeYW1NwS3RR8lmoogOTLcfLiSIqjRgrDINtSVUoYSKTFrzuka0Bi1EoxU/xn2p+3sDXwTjQf/ODrZ/t9CXTlyCg+wCunr7J2c+eWnraRwh+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SnvHmIab; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=k59//
	27XfCXLpT5e958gSQ/VKTUfEmYdEQyopnj+B54=; b=SnvHmIab6pNEVafcatzk2
	ZibxD6yxP2GlhMEtMENj/4S89JeO/sgIZYOejBhb0hDGnKi2lucgRgl1j0RT73sd
	8cH2MX6RjfBiisuDfuUDQJMeFHp9jrVGf//dmWDn8ocN+CF3gZTLTPyqk/avaiYE
	pPi5auaRouYooz5+ZtHTCA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3n7Bazfhn_vEoFw--.59222S2;
	Fri, 11 Apr 2025 16:05:47 +0800 (CST)
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
Subject: [PATCH bpf-next v2] libbpf: Fix event name too long error
Date: Fri, 11 Apr 2025 16:05:45 +0800
Message-Id: <20250411080545.319865-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n7Bazfhn_vEoFw--.59222S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF1DCr4rur45tw15tFW5Wrg_yoWrWFy3pF
	s8Ar1YyF4ftr42qF95Jr18ZryFvw4kJr1UJr1DArsxAF4xWF4UX3W2kF45Gr15XrnFv345
	Xa1UGry7Jry7JrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjuWLUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiTQ4seGf4y1RSBwAAsC

From: Feng Yang <yangfeng@kylinos.cn>

When the binary path is excessively long, the generated probe_name in libbpf
exceeds the kernel's MAX_EVENT_NAME_LEN limit (64 bytes).
This causes legacy uprobe event attachment to fail with error code -22.

Use basename() to extract the base filename from the full binary path, removing directory prefixes.
Example: /root/loooooooooooooooooooooooooooooooooooong_name -> loooooooooooooooooooooooooooooooooooong_name.

String Length Limitation: Apply %.32s in snprintf to truncate the base filename to 32 characters.
Example: loooooooooooooooooooooooooooooooooooong_name -> looooooooooooooooooooooooooooooo.

Before Fix:
	libbpf: binary_path: /root/loooooooooooooooooooooooooooooooooooong_name
	libbpf: probe_name: libbpf_32296__root_loooooooooooooooooooooooooooooooooooong_name_0x1106
	libbpf: failed to add legacy uprobe event for /root/loooooooooooooooooooooooooooooooooooong_name:0x1106: -22

After Fix:
	libbpf: binary_path: /root/loooooooooooooooooooooooooooooooooooong_name
	libbpf: probe_name: libbpf_36178_looooooooooooooooooooooooooooooo_0x1106

Fixes: 46ed5fc33db9 ("libbpf: Refactor and simplify legacy kprobe code")
Fixes: cc10623c6810 ("libbpf: Add legacy uprobe attaching support")
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
Changes in v2:
- Use basename() and %.32s to fix. Thanks, Hengqi Chen!
- Link to v1: https://lore.kernel.org/all/20250410052712.206785-1-yangfeng59949@163.com/
---
 tools/lib/bpf/libbpf.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b2591f5cab65..7e10c7c66819 100644
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
+	snprintf(buf, buf_sz, "libbpf_%u_%.32s_0x%zx_%d", getpid(), kfunc_name,
+		 offset, __sync_fetch_and_add(&index, 1));
 
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
@@ -11880,7 +11882,8 @@ static void gen_uprobe_legacy_event_name(char *buf, size_t buf_sz,
 {
 	int i;
 
-	snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx", getpid(), binary_path, (size_t)offset);
+	snprintf(buf, buf_sz, "libbpf_%u_%.32s_0x%zx", getpid(),
+		 basename((void *)binary_path), (size_t)offset);
 
 	/* sanitize binary_path in the probe name */
 	for (i = 0; buf[i]; i++) {
@@ -12312,7 +12315,7 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 		pfd = perf_event_open_probe(true /* uprobe */, retprobe, binary_path,
 					    func_offset, pid, ref_ctr_off);
 	} else {
-		char probe_name[PATH_MAX + 64];
+		char probe_name[MAX_EVENT_NAME_LEN];
 
 		if (ref_ctr_off)
 			return libbpf_err_ptr(-EINVAL);
-- 
2.43.0


