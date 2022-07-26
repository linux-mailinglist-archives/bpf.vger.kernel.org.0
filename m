Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F69581AC3
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 22:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbiGZULv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 16:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiGZULu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 16:11:50 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B088632477
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 13:11:47 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 32C7F24010D
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 22:11:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1658866306; bh=+pwq6NVUFK2jM3PKAatR7SjmY0kkYNAc2LdovX+zekE=;
        h=From:To:Cc:Subject:Date:From;
        b=ZVeNDRTlaZIVdUUmjF8kHmd6aWvT9SX5fXEOp6aqpeNXeiSlIhBrCw/Jdy3c9APXo
         lunD+HRIKGAZcS5moj+6hYrvbBRLHVXD3fMy1tCSs1l+TrZNLBJDmuvpCNSo6W5VLs
         KtYxjzo1D5PI4b32QjReA67Cit6ata7YM2qMG7BXkAAEfzOMmyIjL60xW1e7kydG+D
         bCkwFvAOn/4X6vdfOq8vdQF0qQQCgLHYH2BieqmS4WHIqMljwzKOijnt2C6tTmGSvh
         MbMWW5ovIXVvyfnoVS6O9ah+8eGQRgo5sKp6RuoldGTHQlW4tmWJzia2oniqfyFIf5
         +zLK5Chb2zUjQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Lsp350y4wz6tpG;
        Tue, 26 Jul 2022 22:11:45 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     mykolal@fb.com, Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v3 2/3] selftests/bpf: Copy over libbpf configs
Date:   Tue, 26 Jul 2022 20:11:25 +0000
Message-Id: <20220726201126.2486635-3-deso@posteo.net>
In-Reply-To: <20220726201126.2486635-1-deso@posteo.net>
References: <20220726201126.2486635-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This change integrates libbpf maintained configurations and black/white
lists [0] into the repository, co-located with the BPF selftests
themselves. We minimize the kernel configurations to keep future updates
as small as possible [1]. Furthermore, we make both kernel
configurations build on top of the existing configuration
tools/testing/selftests/bpf/config (to be concatenated before build).
Lastly, we replaced the terms blacklist & whitelist with denylist and
allowlist, respectively.

[0] https://github.com/libbpf/libbpf/tree/20f03302350a4143825cedcbd210c4d7112c1898/travis-ci/vmtest/configs
[1] https://lore.kernel.org/bpf/20220712212124.3180314-1-deso@posteo.net/T/#m30a53648352ed494e556ac003042a9ad0a8f98c6

Signed-off-by: Daniel Müller <deso@posteo.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/testing/selftests/bpf/DENYLIST       |   6 +
 tools/testing/selftests/bpf/DENYLIST.s390x |  67 ++++++
 tools/testing/selftests/bpf/config.s390x   | 147 ++++++++++++
 tools/testing/selftests/bpf/config.x86_64  | 251 +++++++++++++++++++++
 4 files changed, 471 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/DENYLIST
 create mode 100644 tools/testing/selftests/bpf/DENYLIST.s390x
 create mode 100644 tools/testing/selftests/bpf/config.s390x
 create mode 100644 tools/testing/selftests/bpf/config.x86_64

diff --git a/tools/testing/selftests/bpf/DENYLIST b/tools/testing/selftests/bpf/DENYLIST
new file mode 100644
index 0000000..939de574
--- /dev/null
+++ b/tools/testing/selftests/bpf/DENYLIST
@@ -0,0 +1,6 @@
+# TEMPORARY
+get_stack_raw_tp    # spams with kernel warnings until next bpf -> bpf-next merge
+stacktrace_build_id_nmi
+stacktrace_build_id
+task_fd_query_rawtp
+varlen
diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
new file mode 100644
index 0000000..e33cab
--- /dev/null
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -0,0 +1,67 @@
+# TEMPORARY
+atomics                                  # attach(add): actual -524 <= expected 0                                      (trampoline)
+bpf_iter_setsockopt                      # JIT does not support calling kernel function                                (kfunc)
+bloom_filter_map                         # failed to find kernel BTF type ID of '__x64_sys_getpgid': -3                (?)
+bpf_tcp_ca                               # JIT does not support calling kernel function                                (kfunc)
+bpf_loop                                 # attaches to __x64_sys_nanosleep
+bpf_mod_race                             # BPF trampoline
+bpf_nf                                   # JIT does not support calling kernel function
+core_read_macros                         # unknown func bpf_probe_read#4                                               (overlapping)
+d_path                                   # failed to auto-attach program 'prog_stat': -524                             (trampoline)
+dummy_st_ops                             # test_run unexpected error: -524 (errno 524)                                 (trampoline)
+fentry_fexit                             # fentry attach failed: -524                                                  (trampoline)
+fentry_test                              # fentry_first_attach unexpected error: -524                                  (trampoline)
+fexit_bpf2bpf                            # freplace_attach_trace unexpected error: -524                                (trampoline)
+fexit_sleep                              # fexit_skel_load fexit skeleton failed                                       (trampoline)
+fexit_stress                             # fexit attach failed prog 0 failed: -524                                     (trampoline)
+fexit_test                               # fexit_first_attach unexpected error: -524                                   (trampoline)
+get_func_args_test	                 # trampoline
+get_func_ip_test                         # get_func_ip_test__attach unexpected error: -524                             (trampoline)
+get_stack_raw_tp                         # user_stack corrupted user stack                                             (no backchain userspace)
+kfree_skb                                # attach fentry unexpected error: -524                                        (trampoline)
+kfunc_call                               # 'bpf_prog_active': not found in kernel BTF                                  (?)
+ksyms_module                             # test_ksyms_module__open_and_load unexpected error: -9                       (?)
+ksyms_module_libbpf                      # JIT does not support calling kernel function                                (kfunc)
+ksyms_module_lskel                       # test_ksyms_module_lskel__open_and_load unexpected error: -9                 (?)
+modify_return                            # modify_return attach failed: -524                                           (trampoline)
+module_attach                            # skel_attach skeleton attach failed: -524                                    (trampoline)
+mptcp
+kprobe_multi_test                        # relies on fentry
+netcnt                                   # failed to load BPF skeleton 'netcnt_prog': -7                               (?)
+probe_user                               # check_kprobe_res wrong kprobe res from probe read                           (?)
+recursion                                # skel_attach unexpected error: -524                                          (trampoline)
+ringbuf                                  # skel_load skeleton load failed                                              (?)
+sk_assign                                # Can't read on server: Invalid argument                                      (?)
+sk_lookup                                # endianness problem
+sk_storage_tracing                       # test_sk_storage_tracing__attach unexpected error: -524                      (trampoline)
+skc_to_unix_sock                         # could not attach BPF object unexpected error: -524                          (trampoline)
+socket_cookie                            # prog_attach unexpected error: -524                                          (trampoline)
+stacktrace_build_id                      # compare_map_keys stackid_hmap vs. stackmap err -2 errno 2                   (?)
+tailcalls                                # tail_calls are not allowed in non-JITed programs with bpf-to-bpf calls      (?)
+task_local_storage                       # failed to auto-attach program 'trace_exit_creds': -524                      (trampoline)
+test_bpffs                               # bpffs test  failed 255                                                      (iterator)
+test_bprm_opts                           # failed to auto-attach program 'secure_exec': -524                           (trampoline)
+test_ima                                 # failed to auto-attach program 'ima': -524                                   (trampoline)
+test_local_storage                       # failed to auto-attach program 'unlink_hook': -524                           (trampoline)
+test_lsm                                 # failed to find kernel BTF type ID of '__x64_sys_setdomainname': -3          (?)
+test_overhead                            # attach_fentry unexpected error: -524                                        (trampoline)
+test_profiler                            # unknown func bpf_probe_read_str#45                                          (overlapping)
+timer                                    # failed to auto-attach program 'test1': -524                                 (trampoline)
+timer_crash                              # trampoline
+timer_mim                                # failed to auto-attach program 'test1': -524                                 (trampoline)
+trace_ext                                # failed to auto-attach program 'test_pkt_md_access_new': -524                (trampoline)
+trace_printk                             # trace_printk__load unexpected error: -2 (errno 2)                           (?)
+trace_vprintk                            # trace_vprintk__open_and_load unexpected error: -9                           (?)
+trampoline_count                         # prog 'prog1': failed to attach: ERROR: strerror_r(-524)=22                  (trampoline)
+verif_stats                              # trace_vprintk__open_and_load unexpected error: -9                           (?)
+vmlinux                                  # failed to auto-attach program 'handle__fentry': -524                        (trampoline)
+xdp_adjust_tail                          # case-128 err 0 errno 28 retval 1 size 128 expect-size 3520                  (?)
+xdp_bonding                              # failed to auto-attach program 'trace_on_entry': -524                        (trampoline)
+xdp_bpf2bpf                              # failed to auto-attach program 'trace_on_entry': -524                        (trampoline)
+map_kptr                                 # failed to open_and_load program: -524 (trampoline)
+bpf_cookie                               # failed to open_and_load program: -524 (trampoline)
+xdp_do_redirect                          # prog_run_max_size unexpected error: -22 (errno 22)
+send_signal                              # intermittently fails to receive signal
+select_reuseport                         # intermittently fails on new s390x setup
+xdp_synproxy                             # JIT does not support calling kernel function                                (kfunc)
+unpriv_bpf_disabled                      # fentry
diff --git a/tools/testing/selftests/bpf/config.s390x b/tools/testing/selftests/bpf/config.s390x
new file mode 100644
index 0000000..f8a7a25
--- /dev/null
+++ b/tools/testing/selftests/bpf/config.s390x
@@ -0,0 +1,147 @@
+CONFIG_9P_FS=y
+CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
+CONFIG_AUDIT=y
+CONFIG_BLK_CGROUP=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_BLK_DEV_IO_TRACE=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BONDING=y
+CONFIG_BPF_JIT_ALWAYS_ON=y
+CONFIG_BPF_JIT_DEFAULT_ON=y
+CONFIG_BPF_PRELOAD=y
+CONFIG_BPF_PRELOAD_UMD=y
+CONFIG_BPFILTER=y
+CONFIG_CGROUP_CPUACCT=y
+CONFIG_CGROUP_DEVICE=y
+CONFIG_CGROUP_FREEZER=y
+CONFIG_CGROUP_HUGETLB=y
+CONFIG_CGROUP_NET_CLASSID=y
+CONFIG_CGROUP_PERF=y
+CONFIG_CGROUP_PIDS=y
+CONFIG_CGROUP_SCHED=y
+CONFIG_CGROUPS=y
+CONFIG_CHECKPOINT_RESTORE=y
+CONFIG_CPUSETS=y
+CONFIG_CRASH_DUMP=y
+CONFIG_CRYPTO_USER_API_RNG=y
+CONFIG_CRYPTO_USER_API_SKCIPHER=y
+CONFIG_DEBUG_ATOMIC_SLEEP=y
+CONFIG_DEBUG_INFO_BTF=y
+CONFIG_DEBUG_INFO_DWARF4=y
+CONFIG_DEBUG_LIST=y
+CONFIG_DEBUG_LOCKDEP=y
+CONFIG_DEBUG_NOTIFIERS=y
+CONFIG_DEBUG_PAGEALLOC=y
+CONFIG_DEBUG_SECTION_MISMATCH=y
+CONFIG_DEBUG_SG=y
+CONFIG_DETECT_HUNG_TASK=y
+CONFIG_DEVTMPFS=y
+CONFIG_EXPERT=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
+CONFIG_FANOTIFY=y
+CONFIG_FUNCTION_PROFILER=y
+CONFIG_GDB_SCRIPTS=y
+CONFIG_HAVE_EBPF_JIT=y
+CONFIG_HAVE_KPROBES=y
+CONFIG_HAVE_KPROBES_ON_FTRACE=y
+CONFIG_HAVE_KRETPROBES=y
+CONFIG_HAVE_MARCH_Z10_FEATURES=y
+CONFIG_HAVE_MARCH_Z196_FEATURES=y
+CONFIG_HEADERS_INSTALL=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_HUGETLBFS=y
+CONFIG_HW_RANDOM=y
+CONFIG_HZ_100=y
+CONFIG_IDLE_PAGE_TRACKING=y
+CONFIG_IKHEADERS=y
+CONFIG_INET6_ESP=y
+CONFIG_INET=y
+CONFIG_INET_ESP=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_NF_IPTABLES=y
+CONFIG_IPV6_SEG6_LWTUNNEL=y
+CONFIG_IPVLAN=y
+CONFIG_JUMP_LABEL=y
+CONFIG_KERNEL_UNCOMPRESSED=y
+CONFIG_KPROBES=y
+CONFIG_KPROBES_ON_FTRACE=y
+CONFIG_KRETPROBES=y
+CONFIG_KSM=y
+CONFIG_LATENCYTOP=y
+CONFIG_LIVEPATCH=y
+CONFIG_LOCK_STAT=y
+CONFIG_MACVLAN=y
+CONFIG_MACVTAP=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_MARCH_Z196=y
+CONFIG_MARCH_Z196_TUNE=y
+CONFIG_MEMCG=y
+CONFIG_MEMORY_HOTPLUG=y
+CONFIG_MEMORY_HOTREMOVE=y
+CONFIG_MODULE_SIG=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULES=y
+CONFIG_NAMESPACES=y
+CONFIG_NET=y
+CONFIG_NET_9P=y
+CONFIG_NET_9P_VIRTIO=y
+CONFIG_NET_ACT_BPF=y
+CONFIG_NET_ACT_GACT=y
+CONFIG_NET_KEY=y
+CONFIG_NET_SCH_FQ=y
+CONFIG_NET_VRF=y
+CONFIG_NETDEVICES=y
+CONFIG_NETFILTER_XT_MATCH_BPF=y
+CONFIG_NETFILTER_XT_TARGET_MARK=y
+CONFIG_NF_TABLES=y
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NR_CPUS=256
+CONFIG_NUMA=y
+CONFIG_PACKET=y
+CONFIG_PANIC_ON_OOPS=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_PCI=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_PROC_KCORE=y
+CONFIG_PROFILING=y
+CONFIG_PROVE_LOCKING=y
+CONFIG_PTDUMP_DEBUGFS=y
+CONFIG_RC_DEVICES=y
+CONFIG_RC_LOOPBACK=y
+CONFIG_RT_GROUP_SCHED=y
+CONFIG_SAMPLE_SECCOMP=y
+CONFIG_SAMPLES=y
+CONFIG_SCHED_TRACER=y
+CONFIG_SCSI=y
+CONFIG_SCSI_VIRTIO=y
+CONFIG_SECURITY_NETWORK=y
+CONFIG_STACK_TRACER=y
+CONFIG_STATIC_KEYS_SELFTEST=y
+CONFIG_SYSVIPC=y
+CONFIG_TASK_DELAY_ACCT=y
+CONFIG_TASK_IO_ACCOUNTING=y
+CONFIG_TASK_XACCT=y
+CONFIG_TASKSTATS=y
+CONFIG_TCP_CONG_ADVANCED=y
+CONFIG_TCP_CONG_DCTCP=y
+CONFIG_TLS=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
+CONFIG_TRANSPARENT_HUGEPAGE=y
+CONFIG_TUN=y
+CONFIG_UNIX=y
+CONFIG_UPROBES=y
+CONFIG_USELIB=y
+CONFIG_USER_NS=y
+CONFIG_VETH=y
+CONFIG_VIRTIO_BALLOON=y
+CONFIG_VIRTIO_BLK=y
+CONFIG_VIRTIO_NET=y
+CONFIG_VIRTIO_PCI=y
+CONFIG_VLAN_8021Q=y
+CONFIG_XFRM_USER=y
diff --git a/tools/testing/selftests/bpf/config.x86_64 b/tools/testing/selftests/bpf/config.x86_64
new file mode 100644
index 0000000..f0859a
--- /dev/null
+++ b/tools/testing/selftests/bpf/config.x86_64
@@ -0,0 +1,251 @@
+CONFIG_9P_FS=y
+CONFIG_9P_FS_POSIX_ACL=y
+CONFIG_9P_FS_SECURITY=y
+CONFIG_AGP=y
+CONFIG_AGP_AMD64=y
+CONFIG_AGP_INTEL=y
+CONFIG_AGP_SIS=y
+CONFIG_AGP_VIA=y
+CONFIG_AMIGA_PARTITION=y
+CONFIG_AUDIT=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
+CONFIG_BINFMT_MISC=y
+CONFIG_BLK_CGROUP=y
+CONFIG_BLK_CGROUP_IOLATENCY=y
+CONFIG_BLK_DEV_BSGLIB=y
+CONFIG_BLK_DEV_IO_TRACE=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=16384
+CONFIG_BLK_DEV_THROTTLING=y
+CONFIG_BONDING=y
+CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
+CONFIG_BOOTTIME_TRACING=y
+CONFIG_BPF_JIT_ALWAYS_ON=y
+CONFIG_BPF_KPROBE_OVERRIDE=y
+CONFIG_BPF_PRELOAD=y
+CONFIG_BPF_PRELOAD_UMD=y
+CONFIG_BPFILTER=y
+CONFIG_BSD_DISKLABEL=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_CFS_BANDWIDTH=y
+CONFIG_CGROUP_CPUACCT=y
+CONFIG_CGROUP_DEVICE=y
+CONFIG_CGROUP_FREEZER=y
+CONFIG_CGROUP_HUGETLB=y
+CONFIG_CGROUP_PERF=y
+CONFIG_CGROUP_SCHED=y
+CONFIG_CGROUPS=y
+CONFIG_CMA=y
+CONFIG_CMA_AREAS=7
+CONFIG_COMPAT_32BIT_TIME=y
+CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
+CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
+CONFIG_CPU_FREQ_GOV_ONDEMAND=y
+CONFIG_CPU_FREQ_GOV_USERSPACE=y
+CONFIG_CPU_FREQ_STAT=y
+CONFIG_CPU_IDLE_GOV_LADDER=y
+CONFIG_CPUSETS=y
+CONFIG_CRC_T10DIF=y
+CONFIG_CRYPTO_BLAKE2B=y
+CONFIG_CRYPTO_DEV_VIRTIO=m
+CONFIG_CRYPTO_SEQIV=y
+CONFIG_CRYPTO_XXHASH=y
+CONFIG_DCB=y
+CONFIG_DEBUG_ATOMIC_SLEEP=y
+CONFIG_DEBUG_CREDENTIALS=y
+CONFIG_DEBUG_INFO_BTF=y
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_MEMORY_INIT=y
+CONFIG_DEFAULT_FQ_CODEL=y
+CONFIG_DEFAULT_RENO=y
+CONFIG_DEFAULT_SECURITY_DAC=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_DMA_CMA=y
+CONFIG_DNS_RESOLVER=y
+CONFIG_EFI=y
+CONFIG_EFI_STUB=y
+CONFIG_EXPERT=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
+CONFIG_FAIL_FUNCTION=y
+CONFIG_FAULT_INJECTION=y
+CONFIG_FAULT_INJECTION_DEBUG_FS=y
+CONFIG_FB=y
+CONFIG_FB_MODE_HELPERS=y
+CONFIG_FB_TILEBLITTING=y
+CONFIG_FB_VESA=y
+CONFIG_FONT_8x16=y
+CONFIG_FONT_MINI_4x6=y
+CONFIG_FONTS=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
+CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
+CONFIG_FW_LOADER_USER_HELPER=y
+CONFIG_GART_IOMMU=y
+CONFIG_GENERIC_PHY=y
+CONFIG_HARDLOCKUP_DETECTOR=y
+CONFIG_HID_A4TECH=y
+CONFIG_HID_BELKIN=y
+CONFIG_HID_CHERRY=y
+CONFIG_HID_CYPRESS=y
+CONFIG_HID_DRAGONRISE=y
+CONFIG_HID_EZKEY=y
+CONFIG_HID_GREENASIA=y
+CONFIG_HID_GYRATION=y
+CONFIG_HID_KENSINGTON=y
+CONFIG_HID_KYE=y
+CONFIG_HID_MICROSOFT=y
+CONFIG_HID_MONTEREY=y
+CONFIG_HID_PANTHERLORD=y
+CONFIG_HID_PETALYNX=y
+CONFIG_HID_SMARTJOYPLUS=y
+CONFIG_HID_SUNPLUS=y
+CONFIG_HID_TOPSEED=y
+CONFIG_HID_TWINHAN=y
+CONFIG_HID_ZEROPLUS=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_HPET=y
+CONFIG_HUGETLBFS=y
+CONFIG_HWPOISON_INJECT=y
+CONFIG_HZ_1000=y
+CONFIG_INET=y
+CONFIG_INPUT_EVDEV=y
+CONFIG_INTEL_POWERCLAMP=y
+CONFIG_IP6_NF_IPTABLES=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_IP_MROUTE=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_NF_IPTABLES=y
+CONFIG_IP_PIMSM_V1=y
+CONFIG_IP_PIMSM_V2=y
+CONFIG_IP_ROUTE_MULTIPATH=y
+CONFIG_IP_ROUTE_VERBOSE=y
+CONFIG_IPV6_MIP6=y
+CONFIG_IPV6_ROUTE_INFO=y
+CONFIG_IPV6_ROUTER_PREF=y
+CONFIG_IPV6_SEG6_LWTUNNEL=y
+CONFIG_IPV6_SUBTREES=y
+CONFIG_IRQ_POLL=y
+CONFIG_JUMP_LABEL=y
+CONFIG_KARMA_PARTITION=y
+CONFIG_KEXEC=y
+CONFIG_KPROBES=y
+CONFIG_KSM=y
+CONFIG_LEGACY_VSYSCALL_NONE=y
+CONFIG_LOG_BUF_SHIFT=21
+CONFIG_LOG_CPU_MAX_BUF_SHIFT=0
+CONFIG_LOGO=y
+CONFIG_LSM="selinux,bpf,integrity"
+CONFIG_MAC_PARTITION=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_MCORE2=y
+CONFIG_MEMCG=y
+CONFIG_MEMORY_FAILURE=y
+CONFIG_MINIX_SUBPARTITION=y
+CONFIG_MODULE_SIG=y
+CONFIG_MODULE_SRCVERSION_ALL=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULES=y
+CONFIG_MODVERSIONS=y
+CONFIG_NAMESPACES=y
+CONFIG_NET=y
+CONFIG_NET_9P=y
+CONFIG_NET_9P_VIRTIO=y
+CONFIG_NET_ACT_BPF=y
+CONFIG_NET_CLS_CGROUP=y
+CONFIG_NET_EMATCH=y
+CONFIG_NET_IPGRE_BROADCAST=y
+CONFIG_NET_L3_MASTER_DEV=y
+CONFIG_NET_SCH_DEFAULT=y
+CONFIG_NET_SCH_FQ_CODEL=y
+CONFIG_NET_TC_SKB_EXT=y
+CONFIG_NET_VRF=y
+CONFIG_NETDEVICES=y
+CONFIG_NETFILTER_NETLINK_LOG=y
+CONFIG_NETFILTER_NETLINK_QUEUE=y
+CONFIG_NETFILTER_XT_MATCH_BPF=y
+CONFIG_NETFILTER_XT_MATCH_STATISTIC=y
+CONFIG_NETLABEL=y
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_DEFAULT="utf8"
+CONFIG_NO_HZ=y
+CONFIG_NR_CPUS=128
+CONFIG_NUMA=y
+CONFIG_NUMA_BALANCING=y
+CONFIG_NVMEM=y
+CONFIG_OSF_PARTITION=y
+CONFIG_PACKET=y
+CONFIG_PANIC_ON_OOPS=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_PCI=y
+CONFIG_PCI_IOV=y
+CONFIG_PCI_MSI=y
+CONFIG_PCIEPORTBUS=y
+CONFIG_PHYSICAL_ALIGN=0x1000000
+CONFIG_POSIX_MQUEUE=y
+CONFIG_POWER_SUPPLY=y
+CONFIG_PREEMPT=y
+CONFIG_PRINTK_TIME=y
+CONFIG_PROC_KCORE=y
+CONFIG_PROFILING=y
+CONFIG_PROVE_LOCKING=y
+CONFIG_PTP_1588_CLOCK=y
+CONFIG_RC_DEVICES=y
+CONFIG_RC_LOOPBACK=y
+CONFIG_RCU_CPU_STALL_TIMEOUT=60
+CONFIG_SCHED_STACK_END_CHECK=y
+CONFIG_SCHEDSTATS=y
+CONFIG_SECURITY_NETWORK=y
+CONFIG_SECURITY_SELINUX=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_DETECT_IRQ=y
+CONFIG_SERIAL_8250_EXTENDED=y
+CONFIG_SERIAL_8250_MANY_PORTS=y
+CONFIG_SERIAL_8250_NR_UARTS=32
+CONFIG_SERIAL_8250_RSA=y
+CONFIG_SERIAL_8250_SHARE_IRQ=y
+CONFIG_SERIAL_NONSTANDARD=y
+CONFIG_SERIO_LIBPS2=y
+CONFIG_SGI_PARTITION=y
+CONFIG_SMP=y
+CONFIG_SOLARIS_X86_PARTITION=y
+CONFIG_SUN_PARTITION=y
+CONFIG_SYNC_FILE=y
+CONFIG_SYSVIPC=y
+CONFIG_TASK_DELAY_ACCT=y
+CONFIG_TASK_IO_ACCOUNTING=y
+CONFIG_TASK_XACCT=y
+CONFIG_TASKSTATS=y
+CONFIG_TCP_CONG_ADVANCED=y
+CONFIG_TCP_MD5SIG=y
+CONFIG_TLS=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_TRANSPARENT_HUGEPAGE=y
+CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
+CONFIG_TUN=y
+CONFIG_UNIX=y
+CONFIG_UNIXWARE_DISKLABEL=y
+CONFIG_USER_NS=y
+CONFIG_VALIDATE_FS_PARSER=y
+CONFIG_VETH=y
+CONFIG_VIRT_DRIVERS=y
+CONFIG_VIRTIO_BALLOON=y
+CONFIG_VIRTIO_BLK=y
+CONFIG_VIRTIO_CONSOLE=y
+CONFIG_VIRTIO_NET=y
+CONFIG_VIRTIO_PCI=y
+CONFIG_VLAN_8021Q=y
+CONFIG_X86_ACPI_CPUFREQ=y
+CONFIG_X86_CPUID=y
+CONFIG_X86_MSR=y
+CONFIG_X86_POWERNOW_K8=y
+CONFIG_XDP_SOCKETS_DIAG=y
+CONFIG_XFRM_SUB_POLICY=y
+CONFIG_XFRM_USER=y
+CONFIG_ZEROPLUS_FF=y
-- 
2.30.2

