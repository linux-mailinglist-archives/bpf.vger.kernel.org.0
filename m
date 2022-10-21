Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFDF608086
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 23:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJUVHn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 17:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJUVHn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 17:07:43 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215EA2A1D9C
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 14:07:42 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id f23so3434719plr.6
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 14:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uc+6uMEr+Nur58MWAQQndTb6Fg0AVFJzMYMHoCKwPXI=;
        b=HsVx+b3iYNOB9lcsYbZlmSux3HIqEiNlZDiE7p/zZ7bCMqGzNMAhZfw5f8kqvUXqMv
         PX935ep2Pr2PddigEb77p4gclPpPzSq7svPG+kotLLl5+fPrTaW7Tx9Atrgv6mh+vk0m
         MJPuL4rtS3YmtFQH8p5cu860Nh7o9DhPalei9YfUx5F3JB2wsQhFJlLyyAfAfGA9Zlj5
         jXoreYMRmrVNMHchv7fhQrejmOeEES81+BlHuvGdeJJI3gxNj5vhZ0fRWetwqrkWrxUO
         ZFZL7kM8mG30uHSGF0LuDIBOys0JOGMdlMf79Z6E2DS4VJ3LoWtaskSyOtSwhO6KYzVr
         PhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uc+6uMEr+Nur58MWAQQndTb6Fg0AVFJzMYMHoCKwPXI=;
        b=PM+h+T4JeQFJb4DAJRdeeNWlngnHY0G8Q2bKrvLDsoUOAqH2ywa51HG23Avi00dnzH
         JxB5ikXJ7HmfP0KKspdCxVfgrkUUoxOCOknrRAdAM9qUtlvn8jL1a67+DnTYbStpK/6i
         BDUW6goz4xwtJ98P1K3ntAAiH8nHBjv6j4dk4rsx1dEdGkcvZpg/1fuEobkU0eBsPbqm
         K91SO/OWq6yg240mT2U0twN6Jxz8xRCJ3LAJ0fIvdGmPXMxDOXQKyYBFoZoN1iI7BO5h
         +K4mJjhLd89uSyaArvdcg8UpQ97urFOaIxq2H3BruRHz3S+4mQ9YjoejTtojnfvGunTZ
         H1pg==
X-Gm-Message-State: ACrzQf2PsQUIQXc8/qfvlSBfnOTt0H20fYUADtSw2WLMJMpvcev5qiUz
        PGzSfd61YdSaeGh0S6OrvNw=
X-Google-Smtp-Source: AMsMyM70ay2SrMC3eUGv5Y2G+ACQ/ZYTwhCZwDidxdc49TjeW70ZZX6Pc7wt0Cr+6ipUHT3tfYw4ww==
X-Received: by 2002:a17:902:d502:b0:185:4eaf:fb0f with SMTP id b2-20020a170902d50200b001854eaffb0fmr21398762plg.139.1666386461470;
        Fri, 21 Oct 2022 14:07:41 -0700 (PDT)
Received: from localhost (fwdproxy-prn-020.fbsv.net. [2a03:2880:ff:14::face:b00c])
        by smtp.gmail.com with ESMTPSA id i10-20020a170902e48a00b00186616b8fbasm4022259ple.10.2022.10.21.14.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 14:07:40 -0700 (PDT)
From:   Manu Bretelle <chantr4@gmail.com>
To:     chantr4@gmail.com, bpf@vger.kernel.org, andrii@kernel.org,
        mykolal@fb.com, daniel@iogearbox.net, martin.lau@linux.dev,
        yhs@fb.com
Subject: [PATCH bpf-next 2/4] selftests/bpf: Add config.aarch64
Date:   Fri, 21 Oct 2022 14:06:59 -0700
Message-Id: <20221021210701.728135-3-chantr4@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221021210701.728135-1-chantr4@gmail.com>
References: <20221021210701.728135-1-chantr4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UPPERCASE_75_100 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

config.aarch64, similarly to config.{s390x,x86_64} is a config enabling
building a kernel on aarch64 to be used in bpf's
selftests/kernel-patches CI.

Signed-off-by: Manu Bretelle <chantr4@gmail.com>
---
 tools/testing/selftests/bpf/config.aarch64 | 181 +++++++++++++++++++++
 1 file changed, 181 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/config.aarch64

diff --git a/tools/testing/selftests/bpf/config.aarch64 b/tools/testing/selftests/bpf/config.aarch64
new file mode 100644
index 000000000000..1f0437644186
--- /dev/null
+++ b/tools/testing/selftests/bpf/config.aarch64
@@ -0,0 +1,181 @@
+CONFIG_9P_FS=y
+CONFIG_ARCH_VEXPRESS=y
+CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
+CONFIG_ARM_SMMU_V3=y
+CONFIG_ATA=y
+CONFIG_AUDIT=y
+CONFIG_BINFMT_MISC=y
+CONFIG_BLK_CGROUP=y
+CONFIG_BLK_DEV_BSGLIB=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_BLK_DEV_IO_TRACE=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_BONDING=y
+CONFIG_BPFILTER=y
+CONFIG_BPF_JIT_ALWAYS_ON=y
+CONFIG_BPF_JIT_DEFAULT_ON=y
+CONFIG_BPF_PRELOAD_UMD=y
+CONFIG_BPF_PRELOAD=y
+CONFIG_BRIDGE=m
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
+CONFIG_CHR_DEV_SG=y
+CONFIG_COMPAT=y
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
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_DEVTMPFS=y
+CONFIG_DRM_VIRTIO_GPU=y
+CONFIG_DRM=y
+CONFIG_DUMMY=y
+CONFIG_EXPERT=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_FANOTIFY=y
+CONFIG_FB=y
+CONFIG_FUNCTION_PROFILER=y
+CONFIG_FUSE_FS=y
+CONFIG_FW_CFG_SYSFS_CMDLINE=y
+CONFIG_FW_CFG_SYSFS=y
+CONFIG_GDB_SCRIPTS=y
+CONFIG_HAVE_EBPF_JIT=y
+CONFIG_HAVE_KPROBES_ON_FTRACE=y
+CONFIG_HAVE_KPROBES=y
+CONFIG_HAVE_KRETPROBES=y
+CONFIG_HEADERS_INSTALL=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_HUGETLBFS=y
+CONFIG_HW_RANDOM_VIRTIO=y
+CONFIG_HW_RANDOM=y
+CONFIG_HZ_100=y
+CONFIG_IDLE_PAGE_TRACKING=y
+CONFIG_IKHEADERS=y
+CONFIG_INET6_ESP=y
+CONFIG_INET_ESP=y
+CONFIG_INET=y
+CONFIG_INPUT_EVDEV=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_NF_IPTABLES=y
+CONFIG_IPV6_SEG6_LWTUNNEL=y
+CONFIG_IPVLAN=y
+CONFIG_JUMP_LABEL=y
+CONFIG_KERNEL_UNCOMPRESSED=y
+CONFIG_KPROBES_ON_FTRACE=y
+CONFIG_KPROBES=y
+CONFIG_KRETPROBES=y
+CONFIG_KSM=y
+CONFIG_LATENCYTOP=y
+CONFIG_LIVEPATCH=y
+CONFIG_LOCK_STAT=y
+CONFIG_MACVLAN=y
+CONFIG_MACVTAP=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_MAILBOX=y
+CONFIG_MEMCG=y
+CONFIG_MEMORY_HOTPLUG=y
+CONFIG_MEMORY_HOTREMOVE=y
+CONFIG_NAMESPACES=y
+CONFIG_NET_9P_VIRTIO=y
+CONFIG_NET_9P=y
+CONFIG_NET_ACT_BPF=y
+CONFIG_NET_ACT_GACT=y
+CONFIG_NETDEVICES=y
+CONFIG_NETFILTER_XT_MATCH_BPF=y
+CONFIG_NETFILTER_XT_TARGET_MARK=y
+CONFIG_NET_KEY=y
+CONFIG_NET_SCH_FQ=y
+CONFIG_NET_VRF=y
+CONFIG_NET=y
+CONFIG_NF_TABLES=y
+CONFIG_NLMON=y
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NR_CPUS=256
+CONFIG_NUMA=y
+CONFIG_OVERLAY_FS=y
+CONFIG_PACKET_DIAG=y
+CONFIG_PACKET=y
+CONFIG_PANIC_ON_OOPS=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_PCI_HOST_GENERIC=y
+CONFIG_PCI=y
+CONFIG_PL320_MBOX=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_PROC_KCORE=y
+CONFIG_PROFILING=y
+CONFIG_PROVE_LOCKING=y
+CONFIG_PTDUMP_DEBUGFS=y
+CONFIG_RC_DEVICES=y
+CONFIG_RC_LOOPBACK=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_PL031=y
+CONFIG_RT_GROUP_SCHED=y
+CONFIG_SAMPLE_SECCOMP=y
+CONFIG_SAMPLES=y
+CONFIG_SCHED_AUTOGROUP=y
+CONFIG_SCHED_TRACER=y
+CONFIG_SCSI_CONSTANTS=y
+CONFIG_SCSI_LOGGING=y
+CONFIG_SCSI_SCAN_ASYNC=y
+CONFIG_SCSI_VIRTIO=y
+CONFIG_SCSI=y
+CONFIG_SECURITY_NETWORK=y
+CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
+CONFIG_SERIAL_AMBA_PL011=y
+CONFIG_STACK_TRACER=y
+CONFIG_STATIC_KEYS_SELFTEST=y
+CONFIG_SYSVIPC=y
+CONFIG_TASK_DELAY_ACCT=y
+CONFIG_TASK_IO_ACCOUNTING=y
+CONFIG_TASKSTATS=y
+CONFIG_TASK_XACCT=y
+CONFIG_TCG_TIS=y
+CONFIG_TCG_TPM=y
+CONFIG_TCP_CONG_ADVANCED=y
+CONFIG_TCP_CONG_DCTCP=y
+CONFIG_TLS=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_TMPFS=y
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
+CONFIG_VIRTIO_CONSOLE=y
+CONFIG_VIRTIO_FS=y
+CONFIG_VIRTIO_INPUT=y
+CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
+CONFIG_VIRTIO_MMIO=y
+CONFIG_VIRTIO_NET=y
+CONFIG_VIRTIO_PCI=y
+CONFIG_VLAN_8021Q=y
+CONFIG_VSOCKETS=y
+CONFIG_XFRM_USER=y
-- 
2.30.2

