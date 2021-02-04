Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50E530FD03
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 20:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbhBDThL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 14:37:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:57218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238995AbhBDThK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Feb 2021 14:37:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7C2B64E42;
        Thu,  4 Feb 2021 19:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612467389;
        bh=bYqGG4a16KHOik6MKrpDxLVgzs1GX2Wsdphl21DzrAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FamY1gXff7OqlHCervRAoDS4ETWDc+Q/UHJLHo2kUOgus75Rn7xZ/zCpLUtO/2sLu
         G83xC9tuDIA6U7Z05Y0e/1aUI/ibfi7/b5d7iowsTrGzssMxnm/iqidmqs7hQiPzc0
         9YHAOPy4hlWwE/4Dz3H/XvOPjEui5onRGP2oZMfo0+ARznrvEtaFE93CBEj8RORBB9
         9VaWW7WJAk96DAbIrgzxNDmORF71mJ3UHsps19hXD7CRgpChdl4UdPgNmSShl4mp+n
         m0Mma2SzgfMNR2iwqC4QPYciNiJrowHDJV7cJB+XN8+UO3vzotbPug3uWdLa49gSVJ
         wtXYp51f+9AlA==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v2 2/2] bpf/selftests: Update the IMA test to use BPF ring buffer
Date:   Thu,  4 Feb 2021 19:36:22 +0000
Message-Id: <20210204193622.3367275-3-kpsingh@kernel.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210204193622.3367275-1-kpsingh@kernel.org>
References: <20210204193622.3367275-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Instead of using shared global variables between userspace and BPF, use
the ring buffer to send the IMA hash on the BPF ring buffer. This helps
in validating both IMA and the usage of the ringbuffer in sleepable
programs.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 .../selftests/bpf/prog_tests/test_ima.c       | 23 ++++++++++---
 tools/testing/selftests/bpf/progs/ima.c       | 33 ++++++++++++++-----
 2 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_ima.c b/tools/testing/selftests/bpf/prog_tests/test_ima.c
index 61fca681d524..b54bc0c351b7 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_ima.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_ima.c
@@ -9,6 +9,7 @@
 #include <unistd.h>
 #include <sys/wait.h>
 #include <test_progs.h>
+#include <linux/ring_buffer.h>
 
 #include "ima.skel.h"
 
@@ -31,9 +32,18 @@ static int run_measured_process(const char *measured_dir, u32 *monitored_pid)
 	return -EINVAL;
 }
 
+static u64 ima_hash_from_bpf;
+
+static int process_sample(void *ctx, void *data, size_t len)
+{
+	ima_hash_from_bpf = *((u64 *)data);
+	return 0;
+}
+
 void test_test_ima(void)
 {
 	char measured_dir_template[] = "/tmp/ima_measuredXXXXXX";
+	struct ring_buffer *ringbuf;
 	const char *measured_dir;
 	char cmd[256];
 
@@ -44,6 +54,11 @@ void test_test_ima(void)
 	if (CHECK(!skel, "skel_load", "skeleton failed\n"))
 		goto close_prog;
 
+	ringbuf = ring_buffer__new(bpf_map__fd(skel->maps.ringbuf),
+				   process_sample, NULL, NULL);
+	if (!ASSERT_OK_PTR(ringbuf, "ringbuf"))
+		goto close_prog;
+
 	err = ima__attach(skel);
 	if (CHECK(err, "attach", "attach failed: %d\n", err))
 		goto close_prog;
@@ -60,11 +75,9 @@ void test_test_ima(void)
 	if (CHECK(err, "run_measured_process", "err = %d\n", err))
 		goto close_clean;
 
-	CHECK(skel->data->ima_hash_ret < 0, "ima_hash_ret",
-	      "ima_hash_ret = %ld\n", skel->data->ima_hash_ret);
-
-	CHECK(skel->bss->ima_hash == 0, "ima_hash",
-	      "ima_hash = %lu\n", skel->bss->ima_hash);
+	err = ring_buffer__consume(ringbuf);
+	ASSERT_EQ(err, 1, "num_samples_or_err");
+	ASSERT_NEQ(ima_hash_from_bpf, 0, "ima_hash");
 
 close_clean:
 	snprintf(cmd, sizeof(cmd), "./ima_setup.sh cleanup %s", measured_dir);
diff --git a/tools/testing/selftests/bpf/progs/ima.c b/tools/testing/selftests/bpf/progs/ima.c
index 86b21aff4bc5..96060ff4ffc6 100644
--- a/tools/testing/selftests/bpf/progs/ima.c
+++ b/tools/testing/selftests/bpf/progs/ima.c
@@ -9,20 +9,37 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
-long ima_hash_ret = -1;
-u64 ima_hash = 0;
 u32 monitored_pid = 0;
 
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 1 << 12);
+} ringbuf SEC(".maps");
+
 char _license[] SEC("license") = "GPL";
 
 SEC("lsm.s/bprm_committed_creds")
-int BPF_PROG(ima, struct linux_binprm *bprm)
+void BPF_PROG(ima, struct linux_binprm *bprm)
 {
-	u32 pid = bpf_get_current_pid_tgid() >> 32;
+	u64 ima_hash = 0;
+	u64 *sample;
+	int ret;
+	u32 pid;
+
+	pid = bpf_get_current_pid_tgid() >> 32;
+	if (pid == monitored_pid) {
+		ret = bpf_ima_inode_hash(bprm->file->f_inode, &ima_hash,
+					 sizeof(ima_hash));
+		if (ret < 0 || ima_hash == 0)
+			return;
+
+		sample = bpf_ringbuf_reserve(&ringbuf, sizeof(u64), 0);
+		if (!sample)
+			return;
 
-	if (pid == monitored_pid)
-		ima_hash_ret = bpf_ima_inode_hash(bprm->file->f_inode,
-						  &ima_hash, sizeof(ima_hash));
+		*sample = ima_hash;
+		bpf_ringbuf_submit(sample, 0);
+	}
 
-	return 0;
+	return;
 }
-- 
2.30.0.365.g02bc693789-goog

