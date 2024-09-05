Return-Path: <bpf+bounces-38984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A5896D1A5
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 10:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47B611F2A556
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 08:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CF0199249;
	Thu,  5 Sep 2024 08:11:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0087F199251;
	Thu,  5 Sep 2024 08:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523884; cv=none; b=fm0qvb00GJdmEPT5IysXF+Brq+ii3UG0rdQVs27/uZagvrMtf5vy6G4XferQNX1Qpir9ZVucbDo1K1vy96kBtGDjtwUdIzeKA8p7SoDsjlGVez3fSNXENVGugB1epbeiAc/YmaCzE2Fl7E03gzyYqG64E3QyoWQ0hKUd2CgbB2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523884; c=relaxed/simple;
	bh=yvisZw7rSUnpiD/1gR2nXJ9X28Uo8dA8a+f9fuCjNIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dLL5UHzoaWbEFqa9qu25zGaTakk+TdeehEZ50rTWvgXKNHRz9c604y5scfUYcPESYAuLYVWtr1EAderHehvo5kaX+XnE8PhnPVRLBbSq+1EKciknEzDkuuoKk6qFmDqlFxd3SHmXc2tkaYAZp4pQQji0OwW5keLLbPnlRZKF5DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WzsWB6bPBz4f3l24;
	Thu,  5 Sep 2024 16:11:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CC8E51A058E;
	Thu,  5 Sep 2024 16:11:18 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with SMTP id cCh0CgD3Ii+gZ9lmMQ7AAQ--.26932S7;
	Thu, 05 Sep 2024 16:11:18 +0800 (CST)
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
Subject: [PATCH bpf-next v3 05/10] selftests/bpf: Support local rootfs image for vmtest
Date: Thu,  5 Sep 2024 08:13:56 +0000
Message-Id: <20240905081401.1894789-6-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905081401.1894789-1-pulehui@huaweicloud.com>
References: <20240905081401.1894789-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgD3Ii+gZ9lmMQ7AAQ--.26932S7
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1xAF4DZr48Cr4rXw1UJrb_yoW5ZrWfpa
	1kXw1Ykr9agF13XF1fJrW8WF4rGF1kWry7G34xXrWUuwn3tFykXr1SyFWjqFW3Wa4FqrZx
	A34SvF98uw1UA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUI-eODUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Support vmtest to use local rootfs image generated by [0] that is
consistent with BPF CI. Now we can specify the local rootfs image
through the `-l` parameter like as follows:

  vmtest.sh -l ./libbpf-vmtest-rootfs-2024.08.22-noble-amd64.tar.zst -- ./test_progs

Meanwhile, some descriptions have been flushed.

Link: https://github.com/libbpf/ci/blob/main/rootfs/mkrootfs_debian.sh [0]
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 tools/testing/selftests/bpf/README.rst |  2 --
 tools/testing/selftests/bpf/vmtest.sh  | 21 ++++++++++++++++-----
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
index 9b974e425af3..4a1e74b17109 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -85,8 +85,6 @@ In case of linker errors when running selftests, try using static linking:
           If you want to change pahole and llvm, you can change `PATH` environment
           variable in the beginning of script.
 
-.. note:: The script currently only supports x86_64 and s390x architectures.
-
 Additional information about selftest failures are
 documented here.
 
diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
index 87d93f29c565..7bd2b44deb08 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -4,9 +4,11 @@
 set -u
 set -e
 
-# This script currently only works for x86_64 and s390x, as
-# it is based on the VM image used by the BPF CI, which is
-# available only for these architectures.
+# This script currently only works for the following platforms,
+# as it is based on the VM image used by the BPF CI, which is
+# available only for these architectures. We can also specify
+# the local rootfs image generated by the following script:
+# https://github.com/libbpf/ci/blob/main/rootfs/mkrootfs_debian.sh
 ARCH="$(uname -m)"
 case "${ARCH}" in
 s390x)
@@ -34,6 +36,7 @@ aarch64)
 esac
 DEFAULT_COMMAND="./test_progs"
 MOUNT_DIR="mnt"
+LOCAL_ROOTFS_IMAGE=""
 ROOTFS_IMAGE="root.img"
 OUTPUT_DIR="$HOME/.bpf_selftests"
 KCONFIG_REL_PATHS=("tools/testing/selftests/bpf/config"
@@ -69,6 +72,7 @@ or
 
 Options:
 
+	-l)             Specify the path to the local rootfs image.
 	-i)		Update the rootfs image with a newer version.
 	-d)		Update the output directory (default: ${OUTPUT_DIR})
 	-j)		Number of jobs for compilation, similar to -j in make
@@ -128,7 +132,11 @@ load_rootfs()
 		exit 1
 	fi
 
-	download_rootfs | zstd -d | sudo tar -C "$dir" -x
+	if [[ -n "${LOCAL_ROOTFS_IMAGE}" ]]; then
+		cat "${LOCAL_ROOTFS_IMAGE}" | zstd -d | sudo tar -C "$dir" -x
+	else
+		download_rootfs | zstd -d | sudo tar -C "$dir" -x
+	fi
 }
 
 recompile_kernel()
@@ -342,8 +350,11 @@ main()
 	local exit_command="poweroff -f"
 	local debug_shell="no"
 
-	while getopts ':hskid:j:' opt; do
+	while getopts ':hskl:id:j:' opt; do
 		case ${opt} in
+		l)
+			LOCAL_ROOTFS_IMAGE="$OPTARG"
+			;;
 		i)
 			update_image="yes"
 			;;
-- 
2.34.1


