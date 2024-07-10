Return-Path: <bpf+bounces-34373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6606292CE2E
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 11:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCA03B2314D
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 09:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F28F18FA18;
	Wed, 10 Jul 2024 09:29:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABA684A5B
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 09:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720603769; cv=none; b=Zkm0Lhi6dPSBdc2++h0d2W/w7taYVcMBVLwO8sKrFHKlUe4ZggIJm/pNKIzVCrUtkvMWaX3NLyNSRXTNVj10MZ5EiWzdgy44u9fANrLJk72PR4oy+wiifc6gqV0fzLl9IJ5UVfpInVxa8xehKW4ei5jWsJZbXh4fEHFo8DgPi5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720603769; c=relaxed/simple;
	bh=3kPSDf4Nyu/JiyBWKTX1xXLWK8e1r4V7yNVvWUTztC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C8TH7PsYvuUTdx1LHrDJS5ocSQ2FrRbp2baeM0QCH6B0GptUIko3NvdB1hM27whOXANwDaHuPnD5X5SzyZRqTjL9cl5OtBvVLdT/1/roOdo30HzmjIZDRhD7/hPlDHO4qXm79MotLc3WCEeSRcRk/loeuCSdxd86hun4k/GcDZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WJsxh1hVDz4f3jMf
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 17:29:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id D62301A016E
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 17:29:23 +0800 (CST)
Received: from huawei.com (unknown [7.197.88.80])
	by APP3 (Coremail) with SMTP id _Ch0CgCXpF5jVI5mTxF_Bg--.1219S4;
	Wed, 10 Jul 2024 17:29:23 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
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
	hffilwlqm@gmail.com
Subject: [PATCH bpf v3 2/3] libbpf: provide a valid attach_prog_fd before probing BPF_PROG_TYPE_EXT type
Date: Wed, 10 Jul 2024 17:29:03 +0800
Message-Id: <20240710092904.3438141-3-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710092904.3438141-1-wutengda@huaweicloud.com>
References: <20240710092904.3438141-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCXpF5jVI5mTxF_Bg--.1219S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw13Jr45tr1UXr4DurW7Jwb_yoW8AFyDpF
	ykury5Kr1UG3yfXas5G34F9a4rtFsrWr47XrsxJw1fuF1UXr48GryF9FZIyrnagFW5Jw1F
	v3y8CryDCa4avFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFa9-UUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Since an empty attach_prog_fd is no longer allowed when loading EXT bpf
program, to avoid BPF_PROG_TYPE_EXT type detection failure, just provide
a valid one before probing.

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/lib/bpf/libbpf_probes.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 9dfbe7750f56..2b09acc81be7 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -112,6 +112,7 @@ static int probe_prog_load(enum bpf_prog_type prog_type,
 	int fd, err, exp_err = 0;
 	const char *exp_msg = NULL;
 	char buf[4096];
+	int attach_prog_fd = -1;
 
 	switch (prog_type) {
 	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
@@ -148,9 +149,17 @@ static int probe_prog_load(enum bpf_prog_type prog_type,
 		opts.log_size = sizeof(buf);
 		opts.log_level = 1;
 		opts.attach_btf_id = 1;
+		/* use socket_filter as the target program to attach, because it
+		 * is the earliest and most likely BPF program to be supported.
+		 */
+		attach_prog_fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL,
+					       "GPL", insns, insns_cnt, NULL);
+		if (attach_prog_fd < 0)
+			return attach_prog_fd;
+		opts.attach_prog_fd = attach_prog_fd;
 
 		exp_err = -EINVAL;
-		exp_msg = "Cannot replace kernel functions";
+		exp_msg = "FENTRY/FEXIT program can only be attached to another program annotated with BTF";
 		break;
 	case BPF_PROG_TYPE_SYSCALL:
 		opts.prog_flags = BPF_F_SLEEPABLE;
@@ -192,6 +201,8 @@ static int probe_prog_load(enum bpf_prog_type prog_type,
 	err = -errno;
 	if (fd >= 0)
 		close(fd);
+	if (attach_prog_fd >= 0)
+		close(attach_prog_fd);
 	if (exp_err) {
 		if (fd >= 0 || err != exp_err)
 			return 0;
-- 
2.34.1


