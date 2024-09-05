Return-Path: <bpf+bounces-38986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F9A96D1AA
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 10:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C10C1C221CC
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 08:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB38219D06C;
	Thu,  5 Sep 2024 08:11:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B82E1993B1;
	Thu,  5 Sep 2024 08:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523885; cv=none; b=kb2qCabHfrG4QzI+1IWs4tkUmAQPfwI2jma3cuWpgWiVFuY2lRVAgb7aTivi8R5JzPeT8HAQWohEYVPTKwF60rt7mx1qCT4C8LHNy5W0/8k9fxj6bL3mabTb9bO8ExoR3RSsCV4gysN05fV4mPVR4k+IGARsgjjwlxynj/U3EmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523885; c=relaxed/simple;
	bh=WLrY4yuwdvfDDvJX6CZddLagP+dCGzsL+3OATvAHk/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fedexGpMg88Uw767m/W9/DEQJ+DYGxKXHKcm2qvBrg1iX66WbPU1ICq9k4Wm8M2BlhQU/m8CNo1CC02/oW/IuP7iP/YZpLVYlAjJow/xvTZDefKTa7Ttg3qOAmFZq6Wj++UKxZTqdNwfIVJd8SB8LEs/xwJLaOcJYgoYYSRU+j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WzsWF3Zdlz4f3jXS;
	Thu,  5 Sep 2024 16:11:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8A21B1A06DC;
	Thu,  5 Sep 2024 16:11:20 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with SMTP id cCh0CgD3Ii+gZ9lmMQ7AAQ--.26932S8;
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
Subject: [PATCH bpf-next v3 06/10] selftests/bpf: Enable cross platform testing for vmtest
Date: Thu,  5 Sep 2024 08:13:57 +0000
Message-Id: <20240905081401.1894789-7-pulehui@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgD3Ii+gZ9lmMQ7AAQ--.26932S8
X-Coremail-Antispam: 1UD129KBjvJXoW3AryxCFyUZFyfCrWrCFyxAFb_yoW7GF4rp3
	y8Zw42ka48WF1Sgrn7AF409FWfGw4kZrW7Gry8Xw1UZwn7JF9Fyr9ayFWDXrsxW34Syr43
	ZasagF90kw47Z37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYY7kG6xAYrwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2
	KfnxnUUI43ZEXa7IUYk9N7UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Add support cross platform testing for vmtest. The variable $ARCH in the
current script is platform semantics, not kernel semantics. Rename it to
$PLATFORM so that we can easily use $ARCH in cross-compilation. And drop
`set -u` unbound variable check as we will use CROSS_COMPILE env
variable. For now, Using PLATFORM= and CROSS_COMPILE= options will
enable cross platform testing:

  PLATFORM=<platform> CROSS_COMPILE=<toolchain> vmtest.sh -- ./test_progs

Tested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 tools/testing/selftests/bpf/vmtest.sh | 42 ++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
index 7bd2b44deb08..91f940e8ce45 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -1,7 +1,6 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-set -u
 set -e
 
 # This script currently only works for the following platforms,
@@ -9,25 +8,31 @@ set -e
 # available only for these architectures. We can also specify
 # the local rootfs image generated by the following script:
 # https://github.com/libbpf/ci/blob/main/rootfs/mkrootfs_debian.sh
-ARCH="$(uname -m)"
-case "${ARCH}" in
+PLATFORM="${PLATFORM:-$(uname -m)}"
+case "${PLATFORM}" in
 s390x)
 	QEMU_BINARY=qemu-system-s390x
 	QEMU_CONSOLE="ttyS1"
-	QEMU_FLAGS=(-smp 2)
+	HOST_FLAGS=(-smp 2 -enable-kvm)
+	CROSS_FLAGS=(-smp 2)
 	BZIMAGE="arch/s390/boot/vmlinux"
+	ARCH="s390"
 	;;
 x86_64)
 	QEMU_BINARY=qemu-system-x86_64
 	QEMU_CONSOLE="ttyS0,115200"
-	QEMU_FLAGS=(-cpu host -smp 8)
+	HOST_FLAGS=(-cpu host -enable-kvm -smp 8)
+	CROSS_FLAGS=(-smp 8)
 	BZIMAGE="arch/x86/boot/bzImage"
+	ARCH="x86"
 	;;
 aarch64)
 	QEMU_BINARY=qemu-system-aarch64
 	QEMU_CONSOLE="ttyAMA0,115200"
-	QEMU_FLAGS=(-M virt,gic-version=3 -cpu host -smp 8)
+	HOST_FLAGS=(-M virt,gic-version=3 -cpu host -enable-kvm -smp 8)
+	CROSS_FLAGS=(-M virt,gic-version=3 -cpu cortex-a76 -smp 8)
 	BZIMAGE="arch/arm64/boot/Image"
+	ARCH="arm64"
 	;;
 *)
 	echo "Unsupported architecture"
@@ -41,7 +46,7 @@ ROOTFS_IMAGE="root.img"
 OUTPUT_DIR="$HOME/.bpf_selftests"
 KCONFIG_REL_PATHS=("tools/testing/selftests/bpf/config"
 	"tools/testing/selftests/bpf/config.vm"
-	"tools/testing/selftests/bpf/config.${ARCH}")
+	"tools/testing/selftests/bpf/config.${PLATFORM}")
 INDEX_URL="https://raw.githubusercontent.com/libbpf/ci/master/INDEX"
 NUM_COMPILE_JOBS="$(nproc)"
 LOG_FILE_BASE="$(date +"bpf_selftests.%Y-%m-%d_%H-%M-%S")"
@@ -61,6 +66,10 @@ tools/testing/selftests/bpf. e.g:
 If no command is specified and a debug shell (-s) is not requested,
 "${DEFAULT_COMMAND}" will be run by default.
 
+Using PLATFORM= and CROSS_COMPILE= options will enable cross platform testing:
+
+  PLATFORM=<platform> CROSS_COMPILE=<toolchain> $0 -- ./test_progs -t test_lsm
+
 If you build your kernel using KBUILD_OUTPUT= or O= options, these
 can be passed as environment variables to the script:
 
@@ -100,7 +109,7 @@ newest_rootfs_version()
 {
 	{
 	for file in "${!URLS[@]}"; do
-		if [[ $file =~ ^"${ARCH}"/libbpf-vmtest-rootfs-(.*)\.tar\.zst$ ]]; then
+		if [[ $file =~ ^"${PLATFORM}"/libbpf-vmtest-rootfs-(.*)\.tar\.zst$ ]]; then
 			echo "${BASH_REMATCH[1]}"
 		fi
 	done
@@ -112,7 +121,7 @@ download_rootfs()
 	populate_url_map
 
 	local rootfsversion="$(newest_rootfs_version)"
-	local file="${ARCH}/libbpf-vmtest-rootfs-$rootfsversion.tar.zst"
+	local file="${PLATFORM}/libbpf-vmtest-rootfs-$rootfsversion.tar.zst"
 
 	if [[ ! -v URLS[$file] ]]; then
 		echo "$file not found" >&2
@@ -253,12 +262,17 @@ EOF
 		exit 1
 	fi
 
+	if [[ "${PLATFORM}" != "$(uname -m)" ]]; then
+		QEMU_FLAGS=("${CROSS_FLAGS[@]}")
+	else
+		QEMU_FLAGS=("${HOST_FLAGS[@]}")
+	fi
+
 	${QEMU_BINARY} \
 		-nodefaults \
 		-display none \
 		-serial mon:stdio \
 		"${QEMU_FLAGS[@]}" \
-		-enable-kvm \
 		-m 4G \
 		-drive file="${rootfs_img}",format=raw,index=1,media=disk,if=virtio,cache=none \
 		-kernel "${kernel_bzimage}" \
@@ -389,6 +403,11 @@ main()
 
 	trap 'catch "$?"' EXIT
 
+	if [[ "${PLATFORM}" != "$(uname -m)" ]] && [[ -z "${CROSS_COMPILE}" ]]; then
+		echo "Cross-platform testing needs to specify CROSS_COMPILE"
+		exit 1
+	fi
+
 	if [[ $# -eq 0  && "${debug_shell}" == "no" ]]; then
 		echo "No command specified, will run ${DEFAULT_COMMAND} in the vm"
 	else
@@ -396,7 +415,8 @@ main()
 	fi
 
 	local kconfig_file="${OUTPUT_DIR}/latest.config"
-	local make_command="make -j ${NUM_COMPILE_JOBS} KCONFIG_CONFIG=${kconfig_file}"
+	local make_command="make ARCH=${ARCH} CROSS_COMPILE=${CROSS_COMPILE} \
+			    -j ${NUM_COMPILE_JOBS} KCONFIG_CONFIG=${kconfig_file}"
 
 	# Figure out where the kernel is being built.
 	# O takes precedence over KBUILD_OUTPUT.
-- 
2.34.1


