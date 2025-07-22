Return-Path: <bpf+bounces-64076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA8BB0E149
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 18:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32D64170789
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 16:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC2027A10F;
	Tue, 22 Jul 2025 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CVqUGwes"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EFC156677
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753200479; cv=none; b=nxtC8lYSPI49EbNpFLuauj2k5MndqI81DGxSFMZCEELD7zqzlkTivbm/Bi1QLNGv6BdxJsdkqOL3e788vzsxLhpzu1gFbKBCQ1nGfDlvMlG2hzbc9Jc2OVQ2imHwwgZyMrwL8YgXIagsXyyzxKXZ9Wgo89phABl8k8j8RaNspx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753200479; c=relaxed/simple;
	bh=saT6c7XJD3jEvX2OG7OPfT+XP9o4LsH20Ri4AcaMGG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FOAHCx2db8XZbd780iRfW8qvMxRoksJear+Zx47ho2lKj/Kzpu6gI/jeMiE5whYQ8kii9zPopAm5jw+mofTBLuU+BOU76o4sZC8gC32UscItCS64qW762Vn2B+cRTmh6yNXZddxIYE/lw0tw7s3wyANKSROK8yUSjjft17kujNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CVqUGwes; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <79ff6b16-2d9f-4fd7-9fa5-74b2ab2d4880@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753200473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QoMJ0plKk/fka6XBTwijmbNb2+0gpWnNYufiP8zs00E=;
	b=CVqUGwesaC/Ih9g6q2h3p6NjDtz4P8Bm+os96SrmOM8CyHd212y5z2hqYrloPBq4LyiK77
	iwInXv7jhiVLLfKwoTRFyq6pOECTzLKjlFpm6ywjan8wrBUGXhEpkm4pv0STKp10G9Yvwb
	fjd8xWHaWKkUMndI4GdSHR07JeEYJhE=
Date: Tue, 22 Jul 2025 09:07:47 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC dwarves] btf_encoder: Remove duplicates from functions
 entries
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Menglong Dong <menglong8.dong@gmail.com>, dwarves@vger.kernel.org,
 bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
 Song Liu <songliubraving@fb.com>, Eduard Zingerman <eddyz87@gmail.com>
References: <20250717152512.488022-1-jolsa@kernel.org>
 <e4fece83-8267-4929-b1aa-65a9e2882dd8@oracle.com> <aH5OW0rtSuMn1st1@krava>
 <6b4fda90fbf8f6aeeb2732bbfb6e81ba5669e2f3@linux.dev> <aH9t-GjmPga5YQmv@krava>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <aH9t-GjmPga5YQmv@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/22/25 3:54 AM, Jiri Olsa wrote:
> On Mon, Jul 21, 2025 at 11:27:31PM +0000, Ihor Solodrai wrote:
>> On 7/21/25 7:27 AM, Jiri Olsa wrote:
>>> On Mon, Jul 21, 2025 at 12:41:00PM +0100, Alan Maguire wrote:
>>>> On 17/07/2025 16:25, Jiri Olsa wrote:
>>>>> Menglong reported issue where we can have function in BTF which has
>>>>> multiple addresses in kallsysm [1].
>>>>>
>>>>> Rather than filtering this in runtime, let's teach pahole to remove
>>>>> such functions.
>>>>>
>>>>> Removing duplicate records from functions entries that have more
>>>>> at least one different address. This way btf_encoder__find_function
>>>>> won't find such functions and they won't be added in BTF.
>>>>>
>>>>> In my setup it removed 428 functions out of 77141.
>>>>>
>>>>
>>>> Is such removal necessary? If the presence of an mcount annotation is
>>>> the requirement, couldn't we just utilize
>>>>
>>>> /sys/kernel/tracing/available_filter_functions_addrs
>>>>
>>>> to map name to address safely? It identifies mcount-containing functions
>>>> and some of these appear to be duplicates, for example there I see
>>>>
>>>> ffffffff8376e8b4 acpi_attr_is_visible
>>>> ffffffff8379b7d4 acpi_attr_is_visible
>>>
>>> for that we'd need new interface for loading fentry/fexit.. programs, right?
>>>
>>> the current interface to get fentry/fexit.. attach address is:
>>>     - user specifies function name, that translates to btf_id
>>>     - in kernel that btf id translates back to function name
>>>     - kernel uses kallsyms_lookup_name or find_kallsyms_symbol_value
>>>       to get the address
>>>
>>> so we don't really know which address user wanted in the first place
>>
>> Hi Jiri, Alan.
>>
>> I stumbled on a bug today which seems to be relevant to this
>> discussion.
>>
>> I tried building the kernel with KASAN and UBSAN, and that resulted in
>> some kfuncs disappearing from vmlinux.h, triggering selftests/bpf
>> compilation errors, for example:
>>
>>        CLNG-BPF [test_progs-no_alu32] cgroup_read_xattr.bpf.o
>>      progs/cgroup_read_xattr.c:127:13: error: call to undeclared function 'bpf_cgroup_ancestor'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>>        127 |         ancestor = bpf_cgroup_ancestor(cgrp, 1);
>>            |                    ^
> 
> hi,
> I tried that and tests build for me with KASAN and UBSAN,
> both with gcc (15.1.1) and clang (22.0.0)
> 
> could you share your config?

Sure. This is a slightly modified BPF CI config, pasting:

CONFIG_BLK_DEV_LOOP=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BPF=y
CONFIG_BPF_EVENTS=y
CONFIG_BPF_JIT=y
CONFIG_BPF_KPROBE_OVERRIDE=y
CONFIG_BPF_LIRC_MODE2=y
CONFIG_BPF_LSM=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
CONFIG_CGROUP_BPF=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_AES=y
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_BTF=y
CONFIG_DEBUG_INFO_DWARF4=y
CONFIG_DMABUF_HEAPS=y
CONFIG_DMABUF_HEAPS_SYSTEM=y
CONFIG_DUMMY=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_FPROBE=y
CONFIG_FTRACE_SYSCALLS=y
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FS_VERITY=y
CONFIG_GENEVE=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IMA=y
CONFIG_IMA_READ_POLICY=y
CONFIG_IMA_WRITE_POLICY=y
CONFIG_INET_ESP=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_RAW=y
CONFIG_IP_NF_TARGET_SYNPROXY=y
CONFIG_IPV6=y
CONFIG_IPV6_FOU=y
CONFIG_IPV6_FOU_TUNNEL=y
CONFIG_IPV6_GRE=y
CONFIG_IPV6_SEG6_BPF=y
CONFIG_IPV6_SIT=y
CONFIG_IPV6_TUNNEL=y
CONFIG_KEYS=y
CONFIG_LIRC=y
CONFIG_LWTUNNEL=y
CONFIG_MODULE_SIG=y
CONFIG_MODULE_SRCVERSION_ALL=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_MPLS=y
CONFIG_MPLS_IPTUNNEL=y
CONFIG_MPLS_ROUTING=y
CONFIG_MPTCP=y
CONFIG_NET_ACT_GACT=y
CONFIG_NET_ACT_SKBMOD=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_ACT=y
CONFIG_NET_CLS_BPF=y
CONFIG_NET_CLS_FLOWER=y
CONFIG_NET_CLS_MATCHALL=y
CONFIG_NET_FOU=y
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_NET_IPGRE=y
CONFIG_NET_IPGRE_DEMUX=y
CONFIG_NET_IPIP=y
CONFIG_NET_MPLS_GSO=y
CONFIG_NET_SCH_BPF=y
CONFIG_NET_SCH_FQ=y
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_SCH_HTB=y
CONFIG_NET_SCHED=y
CONFIG_NETDEVSIM=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_NETFILTER_SYNPROXY=y
CONFIG_NETFILTER_XT_CONNMARK=y
CONFIG_NETFILTER_XT_MATCH_STATE=y
CONFIG_NETFILTER_XT_TARGET_CT=y
CONFIG_NETKIT=y
CONFIG_NF_CONNTRACK=y
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_DEFRAG_IPV4=y
CONFIG_NF_DEFRAG_IPV6=y
CONFIG_NF_TABLES=y
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NF_TABLES_IPV4=y
CONFIG_NF_TABLES_IPV6=y
CONFIG_NETFILTER_INGRESS=y
CONFIG_NF_FLOW_TABLE=y
CONFIG_NF_FLOW_TABLE_INET=y
CONFIG_NETFILTER_NETLINK=y
CONFIG_NFT_FLOW_OFFLOAD=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP6_NF_IPTABLES=y
CONFIG_IP6_NF_FILTER=y
CONFIG_NF_NAT=y
CONFIG_PACKET=y
CONFIG_RC_CORE=y
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SYN_COOKIES=y
CONFIG_TEST_BPF=m
CONFIG_UDMABUF=y
CONFIG_USERFAULTFD=y
CONFIG_VSOCKETS=y
CONFIG_VXLAN=y
CONFIG_XDP_SOCKETS=y
CONFIG_XFRM_INTERFACE=y
CONFIG_TCP_CONG_DCTCP=y
CONFIG_TCP_CONG_BBR=y
CONFIG_9P_FS_POSIX_ACL=y
CONFIG_9P_FS_SECURITY=y
CONFIG_9P_FS=y
CONFIG_CRYPTO_DEV_VIRTIO=y
CONFIG_FUSE_FS=y
CONFIG_FUSE_PASSTHROUGH=y
CONFIG_NET_9P_VIRTIO=y
CONFIG_NET_9P=y
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_BLK=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_VIRTIO_FS=y
CONFIG_VIRTIO_NET=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_VSOCKETS_COMMON=y
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_AMIGA_PARTITION=y
CONFIG_AUDIT=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BINFMT_MISC=y
CONFIG_BLK_CGROUP=y
CONFIG_BLK_CGROUP_IOLATENCY=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_BLK_DEV_THROTTLING=y
CONFIG_BONDING=y
CONFIG_BOOTTIME_TRACING=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_PRELOAD=y
CONFIG_BPF_PRELOAD_UMD=y
CONFIG_BSD_DISKLABEL=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_SCHED=y
CONFIG_CGROUPS=y
CONFIG_CMA=y
CONFIG_CMA_AREAS=7
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPUSETS=y
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_XXHASH=y
CONFIG_DCB=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_INFO_BTF=y
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_DEFAULT_FQ_CODEL=y
CONFIG_DEFAULT_RENO=y
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_DMA_CMA=y
CONFIG_DNS_RESOLVER=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EXPERT=y
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_FAIL_FUNCTION=y
CONFIG_FAULT_INJECTION=y
CONFIG_FAULT_INJECTION_DEBUG_FS=y
CONFIG_FB=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y
CONFIG_FB_VESA=y
CONFIG_FONT_8x16=y
CONFIG_FONT_MINI_4x6=y
CONFIG_FONTS=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_GART_IOMMU=y
CONFIG_GENERIC_PHY=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_HID_A4TECH=y
CONFIG_HID_BELKIN=y
CONFIG_HID_CHERRY=y
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
CONFIG_HID_EZKEY=y
CONFIG_HID_GREENASIA=y
CONFIG_HID_GYRATION=y
CONFIG_HID_KENSINGTON=y
CONFIG_HID_KYE=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_PANTHERLORD=y
CONFIG_HID_PETALYNX=y
CONFIG_HID_SMARTJOYPLUS=y
CONFIG_HID_SUNPLUS=y
CONFIG_HID_TOPSEED=y
CONFIG_HID_TWINHAN=y
CONFIG_HID_ZEROPLUS=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_HPET=y
CONFIG_HUGETLBFS=y
CONFIG_HWPOISON_INJECT=y
CONFIG_HZ_1000=y
CONFIG_INET=y
CONFIG_INPUT_EVDEV=y
CONFIG_INTEL_POWERCLAMP=y
CONFIG_IP6_NF_IPTABLES=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IPV6_MIP6=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
CONFIG_IPV6_SUBTREES=y
CONFIG_IRQ_POLL=y
CONFIG_JUMP_LABEL=y
CONFIG_KARMA_PARTITION=y
CONFIG_KEXEC=y
CONFIG_KPROBES=y
CONFIG_KSM=y
CONFIG_LEGACY_VSYSCALL_NONE=y
CONFIG_LOG_BUF_SHIFT=21
CONFIG_LOG_CPU_MAX_BUF_SHIFT=0
CONFIG_LOGO=y
CONFIG_LSM="selinux,bpf,integrity"
CONFIG_MAC_PARTITION=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_MCORE2=y
CONFIG_MEMCG=y
CONFIG_MEMORY_FAILURE=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_NAMESPACES=y
CONFIG_NET=y
CONFIG_NET_ACT_BPF=y
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_EMATCH=y
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_NET_L3_MASTER_DEV=y
CONFIG_NET_SCH_DEFAULT=y
CONFIG_NET_SCH_FQ_CODEL=y
CONFIG_NET_TC_SKB_EXT=y
CONFIG_NET_VRF=y
CONFIG_NETDEVICES=y
CONFIG_NETFILTER_NETLINK_LOG=y
CONFIG_NETFILTER_NETLINK_QUEUE=y
CONFIG_NETFILTER_XT_MATCH_BPF=y
CONFIG_NETFILTER_XT_MATCH_STATISTIC=y
CONFIG_NETLABEL=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NO_HZ=y
CONFIG_NR_CPUS=128
CONFIG_NUMA=y
CONFIG_NUMA_BALANCING=y
CONFIG_NVMEM=y
CONFIG_OSF_PARTITION=y
CONFIG_PACKET=y
CONFIG_PANIC_ON_OOPS=y
CONFIG_PARTITION_ADVANCED=y
CONFIG_PCI=y
CONFIG_PCI_IOV=y
CONFIG_PCI_MSI=y
CONFIG_PCIEPORTBUS=y
CONFIG_PHYSICAL_ALIGN=0x1000000
CONFIG_POSIX_MQUEUE=y
CONFIG_POWER_SUPPLY=y
CONFIG_PREEMPT=y
CONFIG_PRINTK_TIME=y
CONFIG_PROC_KCORE=y
CONFIG_PROFILING=y
CONFIG_PROVE_LOCKING=y
CONFIG_PTP_1588_CLOCK=y
CONFIG_RC_DEVICES=y
CONFIG_RC_LOOPBACK=y
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_SCHEDSTATS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_SELINUX=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_SERIO_LIBPS2=y
CONFIG_SGI_PARTITION=y
CONFIG_SMP=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_SUN_PARTITION=y
CONFIG_SYNC_FILE=y
CONFIG_SYSVIPC=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
CONFIG_TASK_XACCT=y
CONFIG_TASKSTATS=y
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_MD5SIG=y
CONFIG_TLS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_TUN=y
CONFIG_UNIX=y
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_USER_NS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_VETH=y
CONFIG_VIRT_DRIVERS=y
CONFIG_VLAN_8021Q=y
CONFIG_VSOCKETS=y
CONFIG_VSOCKETS_LOOPBACK=y
CONFIG_X86_ACPI_CPUFREQ=y
CONFIG_X86_CPUID=y
CONFIG_X86_MSR=y
CONFIG_X86_POWERNOW_K8=y
CONFIG_XDP_SOCKETS_DIAG=y
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_USER=y
CONFIG_ZEROPLUS_FF=y
CONFIG_SCHED_CLASS_EXT=y
CONFIG_CGROUPS=y
CONFIG_CGROUP_SCHED=y
CONFIG_EXT_GROUP_SCHED=y
CONFIG_BPF=y
CONFIG_BPF_SYSCALL=y
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_BTF=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
CONFIG_KASAN_VMALLOC=y
CONFIG_UBSAN=y

And then:

$ make olddefconfig && make -j$(nproc) all

I was at 42be23e8f2dc of bpf-next, using GCC 14:

$ gcc --version
gcc (Ubuntu 14.2.0-4ubuntu2~24.04) 14.2.0


> 
>>
>> Here is a piece of vmlinux.h diff between CONFIG_UBSAN=y/n:
>>
>>      --- ./tools/testing/selftests/bpf/tools/include/vmlinux.h	2025-07-21 17:35:14.415733105 +0000
>>      +++ ubsan_vmlinux.h	2025-07-21 17:33:10.455312623 +0000
>>      @@ -117203,7 +117292,6 @@
>>       extern int bpf_arena_reserve_pages(void *p__map, void __attribute__((address_space(1))) *ptr__ign, u32 page_cnt) __weak __ksym;
>>       extern __bpf_fastcall void *bpf_cast_to_kern_ctx(void *obj) __weak __ksym;
>>       extern struct cgroup *bpf_cgroup_acquire(struct cgroup *cgrp) __weak __ksym;
>>      -extern struct cgroup *bpf_cgroup_ancestor(struct cgroup *cgrp, int level) __weak __ksym;
>>       extern struct cgroup *bpf_cgroup_from_id(u64 cgid) __weak __ksym;
>>       extern int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__str, struct bpf_dynptr *value_p) __weak __ksym;
>>       extern void bpf_cgroup_release(struct cgroup *cgrp) __weak __ksym;
>>      @@ -117260,7 +117348,6 @@
>>       extern bool bpf_dynptr_is_rdonly(const struct bpf_dynptr *p) __weak __ksym;
>>       extern int bpf_dynptr_memset(struct bpf_dynptr *p, u32 offset, u32 size, u8 val) __weak __ksym;
>>       extern __u32 bpf_dynptr_size(const struct bpf_dynptr *p) __weak __ksym;
>>      -extern void *bpf_dynptr_slice(const struct bpf_dynptr *p, u32 offset, void *buffer__opt, u32 buffer__szk) __weak __ksym;
>>       extern void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr *p, u32 offset, void *buffer__opt, u32 buffer__szk) __weak __ksym;
>>       extern int bpf_fentry_test1(int a) __weak __ksym;
>>       extern int bpf_get_dentry_xattr(struct dentry *dentry, const char *name__str, struct bpf_dynptr *value_p) __weak __ksym;
>>      @@ -117287,7 +117374,6 @@
>>       extern int bpf_iter_num_new(struct bpf_iter_num *it, int start, int end) __weak __ksym;
>>       extern int *bpf_iter_num_next(struct bpf_iter_num *it) __weak __ksym;
>>       extern void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it) __weak __ksym;
>>      -extern int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id, u64 flags) __weak __ksym;
>>       extern struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *it) __weak __ksym;
>>       extern void bpf_iter_task_destroy(struct bpf_iter_task *it) __weak __ksym;
>>       extern int bpf_iter_task_new(struct bpf_iter_task *it, struct task_struct *task__nullable, unsigned int flags) __weak __ksym;
>>      @@ -117373,11 +117459,8 @@
>>       extern int bpf_strspn(const char *s__ign, const char *accept__ign) __weak __ksym;
>>       extern int bpf_strstr(const char *s1__ign, const char *s2__ign) __weak __ksym;
>>       extern struct task_struct *bpf_task_acquire(struct task_struct *p) __weak __ksym;
>>      -extern struct task_struct *bpf_task_from_pid(s32 pid) __weak __ksym;
>>      -extern struct task_struct *bpf_task_from_vpid(s32 vpid) __weak __ksym;
>>       extern struct cgroup *bpf_task_get_cgroup1(struct task_struct *task, int hierarchy_id) __weak __ksym;
>>       extern void bpf_task_release(struct task_struct *p) __weak __ksym;
>>      -extern long int bpf_task_under_cgroup(struct task_struct *task, struct cgroup *ancestor) __weak __ksym;
>>       extern void bpf_throw(u64 cookie) __weak __ksym;
>>       extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p, struct bpf_dynptr *sig_p, struct bpf_key *trusted_keyring) __weak __ksym;
>>       extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
>>      @@ -117412,15 +117495,10 @@
>>       extern u32 scx_bpf_cpuperf_cur(s32 cpu) __weak __ksym;
>>       extern void scx_bpf_cpuperf_set(s32 cpu, u32 perf) __weak __ksym;
>>       extern s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __weak __ksym;
>>      -extern void scx_bpf_destroy_dsq(u64 dsq_id) __weak __ksym;
>>      -extern void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __weak __ksym;
>>       extern void scx_bpf_dispatch_cancel(void) __weak __ksym;
>>       extern bool scx_bpf_dispatch_from_dsq(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak __ksym;
>>      -extern void scx_bpf_dispatch_from_dsq_set_slice(struct bpf_iter_scx_dsq *it__iter, u64 slice) __weak __ksym;
>>      -extern void scx_bpf_dispatch_from_dsq_set_vtime(struct bpf_iter_scx_dsq *it__iter, u64 vtime) __weak __ksym;
>>       extern u32 scx_bpf_dispatch_nr_slots(void) __weak __ksym;
>>       extern void scx_bpf_dispatch_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __weak __ksym;
>>      -extern bool scx_bpf_dispatch_vtime_from_dsq(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak __ksym;
>>       extern void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __weak __ksym;
>>       extern void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __weak __ksym;
>>       extern bool scx_bpf_dsq_move(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak __ksym;
>>      @@ -117428,10 +117506,8 @@
>>       extern void scx_bpf_dsq_move_set_vtime(struct bpf_iter_scx_dsq *it__iter, u64 vtime) __weak __ksym;
>>       extern bool scx_bpf_dsq_move_to_local(u64 dsq_id) __weak __ksym;
>>       extern bool scx_bpf_dsq_move_vtime(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak __ksym;
>>      -extern s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __weak __ksym;
>>       extern void scx_bpf_dump_bstr(char *fmt, long long unsigned int *data, u32 data__sz) __weak __ksym;
>>       extern void scx_bpf_error_bstr(char *fmt, long long unsigned int *data, u32 data__sz) __weak __ksym;
>>      -extern void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __weak __ksym;
>>       extern void scx_bpf_exit_bstr(s64 exit_code, char *fmt, long long unsigned int *data, u32 data__sz) __weak __ksym;
>>       extern const struct cpumask *scx_bpf_get_idle_cpumask(void) __weak __ksym;
>>       extern const struct cpumask *scx_bpf_get_idle_cpumask_node(int node) __weak __ksym;
>>
>> Then I checked the difference between BTFs, and found that there is no
>> DECL_TAG 'bpf_kfunc' produced for the affected functions:
>>
>>      $ diff -u vmlinux.btf.out vmlinux_ubsan.btf.out | grep -C5 cgroup_ancestor
>>      +[52749] FUNC 'bpf_cgroup_acquire' type_id=52748 linkage=static
>>      +[52750] DECL_TAG 'bpf_kfunc' type_id=52749 component_idx=-1
>>      +[52751] FUNC_PROTO '(anon)' ret_type_id=426 vlen=2
>>              'cgrp' type_id=426
>>              'level' type_id=21
>>      -[52681] FUNC 'bpf_cgroup_ancestor' type_id=52680 linkage=static
>>      -[52682] DECL_TAG 'bpf_kfunc' type_id=52681 component_idx=-1
>>      -[52683] FUNC_PROTO '(anon)' ret_type_id=3987 vlen=2
>>      +[52752] FUNC 'bpf_cgroup_ancestor' type_id=52751 linkage=static
>>      +[52753] FUNC_PROTO '(anon)' ret_type_id=3987 vlen=2
>>              'attach_type' type_id=1767
>>              'attach_btf_id' type_id=34
>>      -[52684] FUNC 'bpf_cgroup_atype_find' type_id=52683 linkage=static
>>      -[52685] FUNC_PROTO '(anon)' ret_type_id=0 vlen=2
>>
>> Which is clearly wrong and suggests a bug.
>>
>> After some debugging, I found that the problem is in
>> btf_encoder__find_function(), and more specifically in
>> the comparator used for bsearch and qsort.
>>
>>     static int functions_cmp(const void *_a, const void *_b)
>>     {
>>     	const struct elf_function *a = _a;
>>     	const struct elf_function *b = _b;
>>
>>     	/* if search key allows prefix match, verify target has matching
>>     	 * prefix len and prefix matches.
>>     	 */
>>     	if (a->prefixlen && a->prefixlen == b->prefixlen)
>>     		return strncmp(a->name, b->name, b->prefixlen);
>>     	return strcmp(a->name, b->name);
>>     }
>>
>> For this particular vmlinux that I compiled,
>> btf_encoder__find_function("bpf_cgroup_ancestor", prefixlen=0) returns
>> NULL, even though there is an elf_function struct for
>> bpf_cgroup_ancestor in the table.
>>
>> The reason for it is that bsearch() happens to hit
>> "bpf_cgroup_ancestor.cold" in the table first.
>> strcmp("bpf_cgroup_ancestor", "bpf_cgroup_ancestor.cold)") gives a
>> negative value, but bpf_cgroup_ancestor entry is stored in the other
>> direction in the table.
>>
>> This is surprising at the first glance, because we use the same
>> functions_cmp both for search and for qsort.
>>
>> But as it turns we are actually using two different comparators within
>> functions_cmp(): we set key.prefixlen=0 for exact match and when it's
>> non-zero we search for prefix match. When sorting the table, there are
>> no entries with prefixlen=0, so the order of elements is not exactly
>> right for the bsearch().
>>
>> That's a nasty bug, but as far as I understand, all this complexity is
>> unnecessary in case of '.cold' suffix, because they simply are not
>> supposed to be in the elf_functions table: it's usually just a piece
>> of a target function.
>>
>> There are a couple of ways this particular bug could be fixed
>> (filtering out .cold symbols, for example). But I think this bug and
>> the problem Jiri is trying to solve stems from the fact that one
>> function name, which is an identifier the users care about the most,
>> may be associated with many ELF symbols and/or addresses.
>>
>> What is clear to me in the context of pahole's BTF encoding is that we
>> want elf_functions table to only have a single entry per name (where
>> name is an actual name that might be referred to by users, not an ELF
>> sym name), and have a deterministic mechanism for selecting one (or
>> none) func from many at the time of processing ELF data.
>>
>> The current implementation is just buggy in this regard.
>>
>> I am not aware of long term plans for addressing this, though it looks
>> like this was discussed before. I'd appreciate if you share any
>> relevant threads.
> 
> I did some ill attempt to have function addresses in BTF but that never
> took place.. I thought perhaps Alan took over that, but can't find any
> evidence ;-)
> 
> jirka


