Return-Path: <bpf+bounces-19520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0429582D45F
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 08:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B9F51C210E9
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 07:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370B863DA;
	Mon, 15 Jan 2024 07:00:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54D82572;
	Mon, 15 Jan 2024 07:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxuvD816Rli0MAAA--.1331S3;
	Mon, 15 Jan 2024 15:00:12 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Ax3c7716RlzbIBAA--.8673S3;
	Mon, 15 Jan 2024 15:00:12 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Hou Tao <houtao@huaweicloud.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 1/2] selftests/bpf: Move is_jit_enabled() to testing_helpers
Date: Mon, 15 Jan 2024 15:00:09 +0800
Message-ID: <20240115070010.12338-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240115070010.12338-1-yangtiezhu@loongson.cn>
References: <20240115070010.12338-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Ax3c7716RlzbIBAA--.8673S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZw4DJr43AFyUGFW8JFWrJFc_yoW5Gw1xpa
	yfGw12kr1UtF1fJr17Jr4UWF4FgrZ7XrWUt3s0qrW5Zrs7JryxXr4xKFW0qF9xurZ0gFZ3
	Za4IqFy5ur4xXFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8qsjUUUUUU==

Currently, is_jit_enabled() is only used in test_progs, move it to
testing_helpers so that it can be used in test_verifier. While at
it, remove the second argument "0" of open() as Hou Tao suggested.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/bpf/test_progs.c      | 18 ------------------
 tools/testing/selftests/bpf/testing_helpers.c | 18 ++++++++++++++++++
 tools/testing/selftests/bpf/testing_helpers.h |  1 +
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 1b9387890148..808550986f30 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -547,24 +547,6 @@ int bpf_find_map(const char *test, struct bpf_object *obj, const char *name)
 	return bpf_map__fd(map);
 }
 
-static bool is_jit_enabled(void)
-{
-	const char *jit_sysctl = "/proc/sys/net/core/bpf_jit_enable";
-	bool enabled = false;
-	int sysctl_fd;
-
-	sysctl_fd = open(jit_sysctl, 0, O_RDONLY);
-	if (sysctl_fd != -1) {
-		char tmpc;
-
-		if (read(sysctl_fd, &tmpc, sizeof(tmpc)) == 1)
-			enabled = (tmpc != '0');
-		close(sysctl_fd);
-	}
-
-	return enabled;
-}
-
 int compare_map_keys(int map1_fd, int map2_fd)
 {
 	__u32 key, next_key;
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index 106ef05586b8..a59e56d804ee 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -457,3 +457,21 @@ int get_xlated_program(int fd_prog, struct bpf_insn **buf, __u32 *cnt)
 	*buf = NULL;
 	return -1;
 }
+
+bool is_jit_enabled(void)
+{
+	const char *jit_sysctl = "/proc/sys/net/core/bpf_jit_enable";
+	bool enabled = false;
+	int sysctl_fd;
+
+	sysctl_fd = open(jit_sysctl, O_RDONLY);
+	if (sysctl_fd != -1) {
+		char tmpc;
+
+		if (read(sysctl_fd, &tmpc, sizeof(tmpc)) == 1)
+			enabled = (tmpc != '0');
+		close(sysctl_fd);
+	}
+
+	return enabled;
+}
diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
index e099aa4da611..d14de81727e6 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -52,5 +52,6 @@ struct bpf_insn;
  */
 int get_xlated_program(int fd_prog, struct bpf_insn **buf, __u32 *cnt);
 int testing_prog_flags(void);
+bool is_jit_enabled(void);
 
 #endif /* __TESTING_HELPERS_H */
-- 
2.42.0


