Return-Path: <bpf+bounces-38892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD1096BFF5
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 16:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551F0286686
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 14:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922EE1DFE23;
	Wed,  4 Sep 2024 14:17:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB401DEFD8;
	Wed,  4 Sep 2024 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459443; cv=none; b=R9S5ZIwxlqIhw0YO4alhcERIH+3dM9XVejkRFP7zpJSauiwv0LKJ+0kKDWTdlTt55A6ktS50SVJAYaiW3PyX+PxBrzkofIe+yBmdkIXSJ1FJeuu4+F0R0hnR3MUDKYnGGW0L86kSZwmWxpmR4UbyRwuJQZ0OBjkJVrr1PqwyVy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459443; c=relaxed/simple;
	bh=Ey9n/C7/W1KXb3C4O0ZWrItcZQcO1j37HEJdCKbuOi4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TjPmeRS0bhQKlzpGWRi0IOEQQsW+GaqsnoGEf9GcQT8LZgvNQJYl4fY5LTerTU+zGpxXJkq7smk+0nSRn1SjWwsEnhZrP8MWcOtqZWc9kNQjGczvTBc+gUdtbBuv2fojIkTwybarWyj0ghFBjfC6C+x2pPmAkT7ZEeHs9nPuxuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WzPgy2f2pz4f3kK1;
	Wed,  4 Sep 2024 22:17:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id A085C1A1427;
	Wed,  4 Sep 2024 22:17:12 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with SMTP id _Ch0CgBnvIjfa9hmXCB4AQ--.21574S9;
	Wed, 04 Sep 2024 22:17:12 +0800 (CST)
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
Subject: [PATCH bpf-next v2 07/10] selftests/bpf: Add config.riscv64
Date: Wed,  4 Sep 2024 14:19:48 +0000
Message-Id: <20240904141951.1139090-8-pulehui@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgBnvIjfa9hmXCB4AQ--.21574S9
X-Coremail-Antispam: 1UD129KBjvJXoWxGr43tF4fAw17uF1DZr1UWrg_yoW5WF4xpr
	n7JrW8Jr18Jr17KrW7AryDGrZ8tr1DJFWUJr17Xr1UJw1ktw4fJr1Fyr4UGr1UXa18Xr4r
	AF97GF13Zr1UJw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
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

Add config.riscv64 for both BPF CI and local vmtest.

Tested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 tools/testing/selftests/bpf/config.riscv64 | 84 ++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/config.riscv64

diff --git a/tools/testing/selftests/bpf/config.riscv64 b/tools/testing/selftests/bpf/config.riscv64
new file mode 100644
index 000000000000..bb7043a80e1a
--- /dev/null
+++ b/tools/testing/selftests/bpf/config.riscv64
@@ -0,0 +1,84 @@
+CONFIG_AUDIT=y
+CONFIG_BLK_CGROUP=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BONDING=y
+CONFIG_BPF_JIT_ALWAYS_ON=y
+CONFIG_BPF_PRELOAD=y
+CONFIG_BPF_PRELOAD_UMD=y
+CONFIG_CGROUPS=y
+CONFIG_CGROUP_CPUACCT=y
+CONFIG_CGROUP_DEVICE=y
+CONFIG_CGROUP_FREEZER=y
+CONFIG_CGROUP_HUGETLB=y
+CONFIG_CGROUP_NET_CLASSID=y
+CONFIG_CGROUP_PERF=y
+CONFIG_CGROUP_PIDS=y
+CONFIG_CGROUP_SCHED=y
+CONFIG_CPUSETS=y
+CONFIG_DEBUG_ATOMIC_SLEEP=y
+CONFIG_DEBUG_FS=y
+CONFIG_DETECT_HUNG_TASK=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_EXPERT=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
+CONFIG_FRAME_POINTER=y
+CONFIG_HARDLOCKUP_DETECTOR=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_HUGETLBFS=y
+CONFIG_INET=y
+CONFIG_IPV6_SEG6_LWTUNNEL=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_JUMP_LABEL=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_KPROBES=y
+CONFIG_MEMCG=y
+CONFIG_NAMESPACES=y
+CONFIG_NET=y
+CONFIG_NETDEVICES=y
+CONFIG_NETFILTER_XT_MATCH_BPF=y
+CONFIG_NET_ACT_BPF=y
+CONFIG_NET_L3_MASTER_DEV=y
+CONFIG_NET_VRF=y
+CONFIG_NONPORTABLE=y
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NR_CPUS=256
+CONFIG_PACKET=y
+CONFIG_PANIC_ON_OOPS=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_PCI=y
+CONFIG_PCI_HOST_GENERIC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_PRINTK_TIME=y
+CONFIG_PROC_KCORE=y
+CONFIG_PROFILING=y
+CONFIG_RCU_CPU_STALL_TIMEOUT=60
+CONFIG_RISCV_EFFICIENT_UNALIGNED_ACCESS=y
+CONFIG_RISCV_ISA_C=y
+CONFIG_RISCV_PMU=y
+CONFIG_RISCV_PMU_SBI=y
+CONFIG_RT_GROUP_SCHED=y
+CONFIG_SECURITY_NETWORK=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_SMP=y
+CONFIG_SOC_VIRT=y
+CONFIG_SYSVIPC=y
+CONFIG_TCP_CONG_ADVANCED=y
+CONFIG_TLS=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_TUN=y
+CONFIG_UNIX=y
+CONFIG_UPROBES=y
+CONFIG_USER_NS=y
+CONFIG_VETH=y
+CONFIG_VLAN_8021Q=y
+CONFIG_VSOCKETS_LOOPBACK=y
+CONFIG_XFRM_USER=y
-- 
2.34.1


