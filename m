Return-Path: <bpf+bounces-20072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0EC8389EB
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 10:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64461F2255F
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 09:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57FA5820F;
	Tue, 23 Jan 2024 09:04:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74522B9C0;
	Tue, 23 Jan 2024 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706000644; cv=none; b=gQrxTzYqzy+VrHF93xQ4C3gPvqfubeLk0xGuVxXtgR5AwCToH+Ev5ivXYMvSDRJcjvgx155piwAfRlLkmwo2h11jk+20epjHk0cxcINMgaxKF3foxLV/C+GDchzOen+raZ2G3ySjLGsk6SNt7RVZgaXH0WEPHGssLqd6968Zh5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706000644; c=relaxed/simple;
	bh=+bF4yBUz0ber9088HP+LpsNeEjO/74eF4W/xqSeAXzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCv8g1wkjUCVKiyNFNg2/06czx8CBHH95uZjaXFBTcIvB0r1nfE+T73TL548stT0sCCRURpLj6W6BSLUYSSZoUjVXhpXKTaVPvcGGeb7djnc7S2z3HqJCH1w/W1biEnQstClHgMb0ObDwe0MSWfh+8kXuwRqb2meDmlw5Lgc1ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxuvD6gK9lQBYEAA--.16510S3;
	Tue, 23 Jan 2024 17:03:54 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxLs_4gK9lWhMUAA--.24458S3;
	Tue, 23 Jan 2024 17:03:53 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Hou Tao <houtao@huaweicloud.com>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v7 1/2] selftests/bpf: Move is_jit_enabled() into testing_helpers
Date: Tue, 23 Jan 2024 17:03:50 +0800
Message-ID: <20240123090351.2207-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240123090351.2207-1-yangtiezhu@loongson.cn>
References: <20240123090351.2207-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxLs_4gK9lWhMUAA--.24458S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZw4DJr4kZrWDXw1fuF45urX_yoW5XF4xpa
	yfGw12kr18tF1fJr17XrWUWF4FgrZ7XrWUt3s0qrW5Zr47Jr97Xr4xKFW0qF9xurZ0gFZ3
	Z3WIqFyY9w4xXFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VACjcxG62k0Y48FwI0_
	Jr0_Gr1lYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY
	0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	jxJ5rUUUUU=

Currently, is_jit_enabled() is only used in test_progs, move it into
testing_helpers so that it can be used in test_verifier. While at it,
remove the second argument "0" of open() as Hou Tao suggested.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Acked-by: Hou Tao <houtao1@huawei.com>
Acked-by: Song Liu <song@kernel.org>
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


