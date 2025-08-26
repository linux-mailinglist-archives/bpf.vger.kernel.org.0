Return-Path: <bpf+bounces-66508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2C8B354C5
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 08:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2BC1B61F1A
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 06:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA212F60A5;
	Tue, 26 Aug 2025 06:51:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069571F03EF;
	Tue, 26 Aug 2025 06:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756191071; cv=none; b=M3zvrKyb6vSKou5qI/v6Gt2uFVmxpOpi3LXTCLIGrZ9jF8vjfvecgheYWfMXmztx3UsvI8ZdQOPbIUp8SdGLOs0vPsrVCX5AKoFgLnNGtr4QcH/ypByV6q0+Ff0wBplS7nKgFOZjWpOTv7ay4V1/CTCNqg/G2zuIVKcJUUocWUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756191071; c=relaxed/simple;
	bh=Dhcw2LVk+CjWFnJza20NnRyE5UvD3ExPFBohI1uSXPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CyFssjOY7grf7XPD18vLSVjikBJTomnWtkXdVToB82CcL2mAO1fkyvsrCMaSamrfKa367WQRfPfyCKg8+Vw2ZDwYdf94PPnfg/fhxffWkempwD1GW+O9Pxhm4XNIahnWQdeALKeWcY/kKmkwHZC/nSLWptI/J5s0oWlcEL3qMEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Dxfb9TWa1owUEDAA--.5188S3;
	Tue, 26 Aug 2025 14:50:59 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxH8JRWa1oQG1pAA--.11176S2;
	Tue, 26 Aug 2025 14:50:58 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] selftests/bpf: Remove entries from config.{arch} already present in config
Date: Tue, 26 Aug 2025 14:50:57 +0800
Message-ID: <20250826065057.11415-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxH8JRWa1oQG1pAA--.11176S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jr4fuF4xGryDCrWrWF13WrX_yoW3Wr43pw
	18Jw48tF18JF15ArWxCrWDGFZ8tFnrJFW7Gr13Jr15Zw18J3yxJr4xKF4UJrZ8WFZxXr4r
	Aas3KF13ZF4UJ3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AK
	xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcCD7UUUUU

`config.{arch}` had entries already present in `config`.

When generating the config used by vmtest, concatenate the `config` file
with the `config.{arch}` one, making those entries duplicated, so remove
those duplications.

Use the following command to get the differences:

  $ comm -1 -2  <(sort tools/testing/selftests/bpf/config.x86_64) <(sort tools/testing/selftests/bpf/config)
  $ comm -1 -2  <(sort tools/testing/selftests/bpf/config.aarch64) <(sort tools/testing/selftests/bpf/config)
  $ comm -1 -2  <(sort tools/testing/selftests/bpf/config.riscv64) <(sort tools/testing/selftests/bpf/config)
  $ comm -1 -2  <(sort tools/testing/selftests/bpf/config.ppc64el) <(sort tools/testing/selftests/bpf/config)
  $ comm -1 -2  <(sort tools/testing/selftests/bpf/config.s390x) <(sort tools/testing/selftests/bpf/config)

This is similar with commit 7a42af4b94f1 ("selftests/bpf: Remove entries
from config.s390x already present in config").

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/bpf/config.aarch64 | 12 ------------
 tools/testing/selftests/bpf/config.ppc64el |  1 -
 tools/testing/selftests/bpf/config.riscv64 |  1 -
 tools/testing/selftests/bpf/config.s390x   | 11 -----------
 tools/testing/selftests/bpf/config.x86_64  |  5 -----
 5 files changed, 30 deletions(-)

diff --git a/tools/testing/selftests/bpf/config.aarch64 b/tools/testing/selftests/bpf/config.aarch64
index e1495a4bbc99..7efad36ceb26 100644
--- a/tools/testing/selftests/bpf/config.aarch64
+++ b/tools/testing/selftests/bpf/config.aarch64
@@ -31,10 +31,7 @@ CONFIG_COMPAT=y
 CONFIG_CPUSETS=y
 CONFIG_CRASH_DUMP=y
 CONFIG_CRYPTO_USER_API_RNG=y
-CONFIG_CRYPTO_USER_API_SKCIPHER=y
 CONFIG_DEBUG_ATOMIC_SLEEP=y
-CONFIG_DEBUG_INFO_BTF=y
-CONFIG_DEBUG_INFO_DWARF4=y
 CONFIG_DEBUG_INFO_REDUCED=n
 CONFIG_DEBUG_LIST=y
 CONFIG_DEBUG_LOCKDEP=y
@@ -46,7 +43,6 @@ CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DEVTMPFS=y
 CONFIG_DRM=y
-CONFIG_DUMMY=y
 CONFIG_EXPERT=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
@@ -70,13 +66,11 @@ CONFIG_HZ_100=y
 CONFIG_IDLE_PAGE_TRACKING=y
 CONFIG_IKHEADERS=y
 CONFIG_INET6_ESP=y
-CONFIG_INET_ESP=y
 CONFIG_INET=y
 CONFIG_INPUT_EVDEV=y
 CONFIG_IP_ADVANCED_ROUTER=y
 CONFIG_IP_MULTICAST=y
 CONFIG_IP_MULTIPLE_TABLES=y
-CONFIG_IP_NF_IPTABLES=y
 CONFIG_IPV6_SEG6_LWTUNNEL=y
 CONFIG_IPVLAN=y
 CONFIG_JUMP_LABEL=y
@@ -97,22 +91,18 @@ CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_NAMESPACES=y
 CONFIG_NET_ACT_BPF=y
-CONFIG_NET_ACT_GACT=y
 CONFIG_NETDEVICES=y
 CONFIG_NETFILTER_XT_MATCH_BPF=y
 CONFIG_NETFILTER_XT_TARGET_MARK=y
 CONFIG_NET_KEY=y
-CONFIG_NET_SCH_FQ=y
 CONFIG_NET_VRF=y
 CONFIG_NET=y
-CONFIG_NF_TABLES=y
 CONFIG_NLMON=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_NR_CPUS=256
 CONFIG_NUMA=y
 CONFIG_OVERLAY_FS=y
 CONFIG_PACKET_DIAG=y
-CONFIG_PACKET=y
 CONFIG_PANIC_ON_OOPS=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_PCI_HOST_GENERIC=y
@@ -149,7 +139,6 @@ CONFIG_TASK_XACCT=y
 CONFIG_TCG_TIS=y
 CONFIG_TCG_TPM=y
 CONFIG_TCP_CONG_ADVANCED=y
-CONFIG_TCP_CONG_DCTCP=y
 CONFIG_TLS=y
 CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_TMPFS=y
@@ -161,6 +150,5 @@ CONFIG_UPROBES=y
 CONFIG_USER_NS=y
 CONFIG_VETH=y
 CONFIG_VLAN_8021Q=y
-CONFIG_VSOCKETS=y
 CONFIG_VSOCKETS_LOOPBACK=y
 CONFIG_XFRM_USER=y
diff --git a/tools/testing/selftests/bpf/config.ppc64el b/tools/testing/selftests/bpf/config.ppc64el
index 9acf389dc4ce..b53afb5e0b71 100644
--- a/tools/testing/selftests/bpf/config.ppc64el
+++ b/tools/testing/selftests/bpf/config.ppc64el
@@ -54,7 +54,6 @@ CONFIG_NET=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_NONPORTABLE=y
 CONFIG_NR_CPUS=256
-CONFIG_PACKET=y
 CONFIG_PANIC_ON_OOPS=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_PCI_HOST_GENERIC=y
diff --git a/tools/testing/selftests/bpf/config.riscv64 b/tools/testing/selftests/bpf/config.riscv64
index bb7043a80e1a..7bee24a79a71 100644
--- a/tools/testing/selftests/bpf/config.riscv64
+++ b/tools/testing/selftests/bpf/config.riscv64
@@ -48,7 +48,6 @@ CONFIG_NET_VRF=y
 CONFIG_NONPORTABLE=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_NR_CPUS=256
-CONFIG_PACKET=y
 CONFIG_PANIC_ON_OOPS=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_PCI=y
diff --git a/tools/testing/selftests/bpf/config.s390x b/tools/testing/selftests/bpf/config.s390x
index 26c3bc2ce11d..db61878148e4 100644
--- a/tools/testing/selftests/bpf/config.s390x
+++ b/tools/testing/selftests/bpf/config.s390x
@@ -22,10 +22,7 @@ CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_CPUSETS=y
 CONFIG_CRASH_DUMP=y
 CONFIG_CRYPTO_USER_API_RNG=y
-CONFIG_CRYPTO_USER_API_SKCIPHER=y
 CONFIG_DEBUG_ATOMIC_SLEEP=y
-CONFIG_DEBUG_INFO_BTF=y
-CONFIG_DEBUG_INFO_DWARF4=y
 CONFIG_DEBUG_LIST=y
 CONFIG_DEBUG_LOCKDEP=y
 CONFIG_DEBUG_NOTIFIERS=y
@@ -56,11 +53,9 @@ CONFIG_IDLE_PAGE_TRACKING=y
 CONFIG_IKHEADERS=y
 CONFIG_INET6_ESP=y
 CONFIG_INET=y
-CONFIG_INET_ESP=y
 CONFIG_IP_ADVANCED_ROUTER=y
 CONFIG_IP_MULTICAST=y
 CONFIG_IP_MULTIPLE_TABLES=y
-CONFIG_IP_NF_IPTABLES=y
 CONFIG_IPV6_SEG6_LWTUNNEL=y
 CONFIG_IPVLAN=y
 CONFIG_JUMP_LABEL=y
@@ -83,18 +78,14 @@ CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_NAMESPACES=y
 CONFIG_NET=y
 CONFIG_NET_ACT_BPF=y
-CONFIG_NET_ACT_GACT=y
 CONFIG_NET_KEY=y
-CONFIG_NET_SCH_FQ=y
 CONFIG_NET_VRF=y
 CONFIG_NETDEVICES=y
 CONFIG_NETFILTER_XT_MATCH_BPF=y
 CONFIG_NETFILTER_XT_TARGET_MARK=y
-CONFIG_NF_TABLES=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_NR_CPUS=256
 CONFIG_NUMA=y
-CONFIG_PACKET=y
 CONFIG_PANIC_ON_OOPS=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_PCI=y
@@ -119,7 +110,6 @@ CONFIG_TASK_IO_ACCOUNTING=y
 CONFIG_TASK_XACCT=y
 CONFIG_TASKSTATS=y
 CONFIG_TCP_CONG_ADVANCED=y
-CONFIG_TCP_CONG_DCTCP=y
 CONFIG_TLS=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
@@ -131,6 +121,5 @@ CONFIG_UPROBES=y
 CONFIG_USER_NS=y
 CONFIG_VETH=y
 CONFIG_VLAN_8021Q=y
-CONFIG_VSOCKETS=y
 CONFIG_VSOCKETS_LOOPBACK=y
 CONFIG_XFRM_USER=y
diff --git a/tools/testing/selftests/bpf/config.x86_64 b/tools/testing/selftests/bpf/config.x86_64
index 5e713ef7caa3..42ad817b00ae 100644
--- a/tools/testing/selftests/bpf/config.x86_64
+++ b/tools/testing/selftests/bpf/config.x86_64
@@ -44,7 +44,6 @@ CONFIG_CRYPTO_SEQIV=y
 CONFIG_CRYPTO_XXHASH=y
 CONFIG_DCB=y
 CONFIG_DEBUG_ATOMIC_SLEEP=y
-CONFIG_DEBUG_INFO_BTF=y
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_DEBUG_MEMORY_INIT=y
 CONFIG_DEFAULT_FQ_CODEL=y
@@ -104,12 +103,10 @@ CONFIG_HZ_1000=y
 CONFIG_INET=y
 CONFIG_INPUT_EVDEV=y
 CONFIG_INTEL_POWERCLAMP=y
-CONFIG_IP6_NF_IPTABLES=y
 CONFIG_IP_ADVANCED_ROUTER=y
 CONFIG_IP_MROUTE=y
 CONFIG_IP_MULTICAST=y
 CONFIG_IP_MULTIPLE_TABLES=y
-CONFIG_IP_NF_IPTABLES=y
 CONFIG_IP_PIMSM_V1=y
 CONFIG_IP_PIMSM_V2=y
 CONFIG_IP_ROUTE_MULTIPATH=y
@@ -162,7 +159,6 @@ CONFIG_NUMA=y
 CONFIG_NUMA_BALANCING=y
 CONFIG_NVMEM=y
 CONFIG_OSF_PARTITION=y
-CONFIG_PACKET=y
 CONFIG_PANIC_ON_OOPS=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_PCI=y
@@ -220,7 +216,6 @@ CONFIG_VALIDATE_FS_PARSER=y
 CONFIG_VETH=y
 CONFIG_VIRT_DRIVERS=y
 CONFIG_VLAN_8021Q=y
-CONFIG_VSOCKETS=y
 CONFIG_VSOCKETS_LOOPBACK=y
 CONFIG_X86_ACPI_CPUFREQ=y
 CONFIG_X86_CPUID=y
-- 
2.42.0


