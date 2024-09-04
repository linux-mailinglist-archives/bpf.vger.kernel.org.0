Return-Path: <bpf+bounces-38883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E27C96BFE2
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 16:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FF631C24C66
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 14:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7411DC726;
	Wed,  4 Sep 2024 14:17:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1084F1DC191;
	Wed,  4 Sep 2024 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459436; cv=none; b=TwEaMH7Q1L4Ib6ywEwEydE5iTkQW/nQSONOHntqusKuWPdl/tBr4SVRl1p3gRhvMHVYn8UE19vwAsQwWayuZWDoWCIixcEhJtP9xbplZ1NdqsJNWCfZPdbCPTxDcdLrztWXpa/rp/fKwZWUJwTSDMJ5f35z6t+M7MQ4ouhh0f/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459436; c=relaxed/simple;
	bh=BlBIpqqE3Yz5nf0Jj6PJbIvarlb7gxHb3xROsk9NJ78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Obp4PYASzcWqhbBGs6oyIq3Cr/CjvTnLHp5L3896npIVYrsvRpCwRHJT95XvbtDQXWCCgcYrOzAoU/+qnF2wSAU7ab68wYqb+CtviYdYjAzh71eTwYiPvoaLKP75QnvcBoWagRRYdAagdF5lr7FBzUHcidRl9voaDHNig+0vhBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WzPgq5k1Qz4f3js2;
	Wed,  4 Sep 2024 22:16:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id CDC4F1A16CA;
	Wed,  4 Sep 2024 22:17:10 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with SMTP id _Ch0CgBnvIjfa9hmXCB4AQ--.21574S6;
	Wed, 04 Sep 2024 22:17:10 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH bpf-next v2 04/10] selftests/bpf: Limit URLS parsing logic to actual scope in vmtest
Date: Wed,  4 Sep 2024 14:19:45 +0000
Message-Id: <20240904141951.1139090-5-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904141951.1139090-1-pulehui@huaweicloud.com>
References: <20240904141951.1139090-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBnvIjfa9hmXCB4AQ--.21574S6
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4fZr4DGF1rtFyDXF1kZrb_yoW8uFW3pw
	1xWryakw1Iq3W7Wrn7XFyUuF43Gr4xCr1xGFy8Wr4Y9r17XF1qqFyIya4qqrs8W345Jr4S
	vayfWFy3Cr45taDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7I
	U0sqXPUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

The URLS array is only valid in the download_rootfs function and does
not need to be parsed globally in advance. At the same time, the logic
of loading rootfs is refactored to prepare vmtest for supporting local
rootfs.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 tools/testing/selftests/bpf/vmtest.sh | 39 +++++++++++++--------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
index ae2e5a5ca279..7d99d502691c 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -92,19 +92,6 @@ populate_url_map()
 	fi
 }
 
-download()
-{
-	local file="$1"
-
-	if [[ ! -v URLS[$file] ]]; then
-		echo "$file not found" >&2
-		return 1
-	fi
-
-	echo "Downloading $file..." >&2
-	curl -Lsf "${URLS[$file]}" "${@:2}"
-}
-
 newest_rootfs_version()
 {
 	{
@@ -118,16 +105,30 @@ newest_rootfs_version()
 
 download_rootfs()
 {
-	local rootfsversion="$1"
-	local dir="$2"
+	populate_url_map
+
+	local rootfsversion="$(newest_rootfs_version)"
+	local file="${ARCH}/libbpf-vmtest-rootfs-$rootfsversion.tar.zst"
+
+	if [[ ! -v URLS[$file] ]]; then
+		echo "$file not found" >&2
+		return 1
+	fi
+
+	echo "Downloading $file..." >&2
+	curl -Lsf "${URLS[$file]}" "${@:2}"
+}
+
+load_rootfs()
+{
+	local dir="$1"
 
 	if ! which zstd &> /dev/null; then
 		echo 'Could not find "zstd" on the system, please install zstd'
 		exit 1
 	fi
 
-	download "${ARCH}/libbpf-vmtest-rootfs-$rootfsversion.tar.zst" |
-		zstd -d | sudo tar -C "$dir" -x
+	download_rootfs | zstd -d | sudo tar -C "$dir" -x
 }
 
 recompile_kernel()
@@ -227,7 +228,7 @@ create_vm_image()
 	mkfs.ext4 -q "${rootfs_img}"
 
 	mount_image
-	download_rootfs "$(newest_rootfs_version)" "${mount_dir}"
+	load_rootfs "${mount_dir}"
 	unmount_image
 }
 
@@ -402,8 +403,6 @@ main()
 		make_command="${make_command} KBUILD_OUTPUT=${KBUILD_OUTPUT}"
 	fi
 
-	populate_url_map
-
 	local rootfs_img="${OUTPUT_DIR}/${ROOTFS_IMAGE}"
 	local mount_dir="${OUTPUT_DIR}/${MOUNT_DIR}"
 
-- 
2.34.1


