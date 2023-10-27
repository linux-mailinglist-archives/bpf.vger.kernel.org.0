Return-Path: <bpf+bounces-13510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2047DA263
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 23:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D91282635
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 21:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA383FE23;
	Fri, 27 Oct 2023 21:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efNDDYdn"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB1E3FB2F
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 21:23:37 +0000 (UTC)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9466C1B4
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 14:23:35 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-5842a7fdc61so1451544eaf.3
        for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 14:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698441814; x=1699046614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9OZd1ZsVqLdGjpxY17xt+LSIV5vSlXewYuYJmytLXJw=;
        b=efNDDYdnSfXXwFyrT5RvhrG73sGT0p+x4mf3/cx9IoCtye2fFRUUXyx4/DY09D9TVJ
         6D1E/O6RpgxVnb5SPMNLF00npBv0iGem5tYqJJ8XhwrXBNvnuoPwbyC5KiowGo4sGf6W
         CRQulwruTSPJI/oRWGl9FO13v8VbU4P3E7vFc3guN1i516VQAMuIjh2CAlfaAn7Y+0og
         fwZPlmFmFQ2o4bDoMdgWX3tEQgOgxNZT+TDWgtRtZ4lSQAbphpieVB+aGBZDjU/X8emg
         5OHrFUWEj5KDAxQfckoKRFzPb0f7/SQmm3oig6xxidCOHWwzCuY5UsNObuxZbYfqK3iz
         T7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698441814; x=1699046614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9OZd1ZsVqLdGjpxY17xt+LSIV5vSlXewYuYJmytLXJw=;
        b=hCM2a+yCF2iAzEBbCKjco+SCTJ7mcsmP+zsI7rn8saa8Lo0JxYXJ2gaISWlacoIt6w
         K+Rt1i3PBIpqQ1eZn+2lb+thX6gpRbo1eDQdfAn8VNvLu7vTylhquqf1xAhhEi2K6UW/
         Ce1nkPhMob6lQCim0UPyN6B/TSxqTlgGnRirwOvy0UAdZz4pfTafq4lVNkFRym6ncJxQ
         IVjwjtKxyIJvzrM5oRhtmYoG/PLNL05HaiCR+LmUgJPRJkYxnMac9BKUfgLI4AIvjmTK
         fNRODrjr9BdKIAPXlJaiEZ79bs7rpNKLhU2+3uH6jIujB7RD0hYR0BR9rpIEjtSBh1wj
         wO9Q==
X-Gm-Message-State: AOJu0Yx/b8bXpjMyA2UUsOjSprVnhNcig8LNA5cIXvuOVou+1iz4HQqq
	N5rkRflkQDGL1KLHiC/dKHJWhSMFFYBi3g==
X-Google-Smtp-Source: AGHT+IH2GDhp522Y75p1x89KI7SDWgviDucJh5PXRwFcjbtiAxNWndXwyqtvpM7QELmCrgoPbnM+Og==
X-Received: by 2002:a4a:a50c:0:b0:57b:7e41:9f11 with SMTP id v12-20020a4aa50c000000b0057b7e419f11mr3747129ook.2.1698441814500;
        Fri, 27 Oct 2023 14:23:34 -0700 (PDT)
Received: from localhost (fwdproxy-vll-004.fbsv.net. [2a03:2880:12ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id e15-20020a4aaacf000000b0057b8baf00bbsm521369oon.22.2023.10.27.14.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 14:23:34 -0700 (PDT)
From: Manu Bretelle <chantr4@gmail.com>
To: bpf@vger.kernel.org,
	quentin@isovalent.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Subject: [PATCH bpf-next] selftests/bpf: consolidate VIRTIO/9P configs in the generic config file
Date: Fri, 27 Oct 2023 14:23:04 -0700
Message-Id: <20231027212304.3354504-1-chantr4@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Those configs are needed to be able to run VM somewhat consistently.
For instance, ATM, s390x is missing the `CONFIG_VIRTIO_CONSOLE` which
prevents s390x kernels built in CI to leverage qemu-guest-agent.

By moving them to `config`, we should have selftest kernels which are
equal in term of functionalities.

The set of config unabled were picked using

    grep -h -E '(_9P|_VIRTIO)' config.x86_64 config | sort | uniq

added to `config` and then
    grep -vE '(_9P|_VIRTIO)' config.{x86_64,aarch64,s390x}

as a side-effect, some config may have disappeared to the aarch64 and
s390x kernels, but they should not be needed. CI will tell.

Signed-off-by: Manu Bretelle <chantr4@gmail.com>
---
 tools/testing/selftests/bpf/config         | 13 +++++++++++++
 tools/testing/selftests/bpf/config.aarch64 | 16 ----------------
 tools/testing/selftests/bpf/config.s390x   |  9 ---------
 tools/testing/selftests/bpf/config.x86_64  | 12 ------------
 4 files changed, 13 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 3ec5927ec3e5..c22a068bc1de 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -86,3 +86,16 @@ CONFIG_VXLAN=y
 CONFIG_XDP_SOCKETS=y
 CONFIG_XFRM_INTERFACE=y
 CONFIG_VSOCKETS=y
+# VIRTIO/9P configs to run in VMs
+CONFIG_9P_FS_POSIX_ACL=y
+CONFIG_9P_FS_SECURITY=y
+CONFIG_9P_FS=y
+CONFIG_CRYPTO_DEV_VIRTIO=y
+CONFIG_NET_9P_VIRTIO=y
+CONFIG_NET_9P=y
+CONFIG_VIRTIO_BALLOON=y
+CONFIG_VIRTIO_BLK=y
+CONFIG_VIRTIO_CONSOLE=y
+CONFIG_VIRTIO_NET=y
+CONFIG_VIRTIO_PCI=y
+CONFIG_VIRTIO_VSOCKETS_COMMON=y
diff --git a/tools/testing/selftests/bpf/config.aarch64 b/tools/testing/selftests/bpf/config.aarch64
index 253821494884..fa8ecf626c73 100644
--- a/tools/testing/selftests/bpf/config.aarch64
+++ b/tools/testing/selftests/bpf/config.aarch64
@@ -1,4 +1,3 @@
-CONFIG_9P_FS=y
 CONFIG_ARCH_VEXPRESS=y
 CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
 CONFIG_ARM_SMMU_V3=y
@@ -46,7 +45,6 @@ CONFIG_DEBUG_SG=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DEVTMPFS=y
-CONFIG_DRM_VIRTIO_GPU=y
 CONFIG_DRM=y
 CONFIG_DUMMY=y
 CONFIG_EXPERT=y
@@ -67,7 +65,6 @@ CONFIG_HAVE_KRETPROBES=y
 CONFIG_HEADERS_INSTALL=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_HUGETLBFS=y
-CONFIG_HW_RANDOM_VIRTIO=y
 CONFIG_HW_RANDOM=y
 CONFIG_HZ_100=y
 CONFIG_IDLE_PAGE_TRACKING=y
@@ -99,8 +96,6 @@ CONFIG_MEMCG=y
 CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_NAMESPACES=y
-CONFIG_NET_9P_VIRTIO=y
-CONFIG_NET_9P=y
 CONFIG_NET_ACT_BPF=y
 CONFIG_NET_ACT_GACT=y
 CONFIG_NETDEVICES=y
@@ -140,7 +135,6 @@ CONFIG_SCHED_TRACER=y
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_LOGGING=y
 CONFIG_SCSI_SCAN_ASYNC=y
-CONFIG_SCSI_VIRTIO=y
 CONFIG_SCSI=y
 CONFIG_SECURITY_NETWORK=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
@@ -167,16 +161,6 @@ CONFIG_UPROBES=y
 CONFIG_USELIB=y
 CONFIG_USER_NS=y
 CONFIG_VETH=y
-CONFIG_VIRTIO_BALLOON=y
-CONFIG_VIRTIO_BLK=y
-CONFIG_VIRTIO_CONSOLE=y
-CONFIG_VIRTIO_FS=y
-CONFIG_VIRTIO_INPUT=y
-CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
-CONFIG_VIRTIO_MMIO=y
-CONFIG_VIRTIO_NET=y
-CONFIG_VIRTIO_PCI=y
-CONFIG_VIRTIO_VSOCKETS_COMMON=y
 CONFIG_VLAN_8021Q=y
 CONFIG_VSOCKETS=y
 CONFIG_VSOCKETS_LOOPBACK=y
diff --git a/tools/testing/selftests/bpf/config.s390x b/tools/testing/selftests/bpf/config.s390x
index 2ba92167be35..e93330382849 100644
--- a/tools/testing/selftests/bpf/config.s390x
+++ b/tools/testing/selftests/bpf/config.s390x
@@ -1,4 +1,3 @@
-CONFIG_9P_FS=y
 CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
 CONFIG_AUDIT=y
 CONFIG_BLK_CGROUP=y
@@ -84,8 +83,6 @@ CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_NAMESPACES=y
 CONFIG_NET=y
-CONFIG_NET_9P=y
-CONFIG_NET_9P_VIRTIO=y
 CONFIG_NET_ACT_BPF=y
 CONFIG_NET_ACT_GACT=y
 CONFIG_NET_KEY=y
@@ -114,7 +111,6 @@ CONFIG_SAMPLE_SECCOMP=y
 CONFIG_SAMPLES=y
 CONFIG_SCHED_TRACER=y
 CONFIG_SCSI=y
-CONFIG_SCSI_VIRTIO=y
 CONFIG_SECURITY_NETWORK=y
 CONFIG_STACK_TRACER=y
 CONFIG_STATIC_KEYS_SELFTEST=y
@@ -136,11 +132,6 @@ CONFIG_UPROBES=y
 CONFIG_USELIB=y
 CONFIG_USER_NS=y
 CONFIG_VETH=y
-CONFIG_VIRTIO_BALLOON=y
-CONFIG_VIRTIO_BLK=y
-CONFIG_VIRTIO_NET=y
-CONFIG_VIRTIO_PCI=y
-CONFIG_VIRTIO_VSOCKETS_COMMON=y
 CONFIG_VLAN_8021Q=y
 CONFIG_VSOCKETS=y
 CONFIG_VSOCKETS_LOOPBACK=y
diff --git a/tools/testing/selftests/bpf/config.x86_64 b/tools/testing/selftests/bpf/config.x86_64
index 2e70a6048278..f7bfb2b09c82 100644
--- a/tools/testing/selftests/bpf/config.x86_64
+++ b/tools/testing/selftests/bpf/config.x86_64
@@ -1,6 +1,3 @@
-CONFIG_9P_FS=y
-CONFIG_9P_FS_POSIX_ACL=y
-CONFIG_9P_FS_SECURITY=y
 CONFIG_AGP=y
 CONFIG_AGP_AMD64=y
 CONFIG_AGP_INTEL=y
@@ -45,7 +42,6 @@ CONFIG_CPU_IDLE_GOV_LADDER=y
 CONFIG_CPUSETS=y
 CONFIG_CRC_T10DIF=y
 CONFIG_CRYPTO_BLAKE2B=y
-CONFIG_CRYPTO_DEV_VIRTIO=y
 CONFIG_CRYPTO_SEQIV=y
 CONFIG_CRYPTO_XXHASH=y
 CONFIG_DCB=y
@@ -145,8 +141,6 @@ CONFIG_MEMORY_FAILURE=y
 CONFIG_MINIX_SUBPARTITION=y
 CONFIG_NAMESPACES=y
 CONFIG_NET=y
-CONFIG_NET_9P=y
-CONFIG_NET_9P_VIRTIO=y
 CONFIG_NET_ACT_BPF=y
 CONFIG_NET_CLS_CGROUP=y
 CONFIG_NET_EMATCH=y
@@ -228,12 +222,6 @@ CONFIG_USER_NS=y
 CONFIG_VALIDATE_FS_PARSER=y
 CONFIG_VETH=y
 CONFIG_VIRT_DRIVERS=y
-CONFIG_VIRTIO_BALLOON=y
-CONFIG_VIRTIO_BLK=y
-CONFIG_VIRTIO_CONSOLE=y
-CONFIG_VIRTIO_NET=y
-CONFIG_VIRTIO_PCI=y
-CONFIG_VIRTIO_VSOCKETS_COMMON=y
 CONFIG_VLAN_8021Q=y
 CONFIG_VSOCKETS=y
 CONFIG_VSOCKETS_LOOPBACK=y
-- 
2.39.3


