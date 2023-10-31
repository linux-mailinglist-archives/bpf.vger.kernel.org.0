Return-Path: <bpf+bounces-13757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E773C7DD7BE
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 22:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636FE2817E7
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 21:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E014249ED;
	Tue, 31 Oct 2023 21:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVppXTTO"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18A8EEA2
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 21:27:51 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DC9B9
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 14:27:50 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6cd09f51fe0so3550553a34.1
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 14:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698787669; x=1699392469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UldHiEfbNixhoGZziFzkGsGZjUM85AdNIN2RpBGCLiU=;
        b=OVppXTTOrKXUqnPYdz8U+x60Kh7HRASWdM0EfQjDQy96mXRzFa+3jMNnDtwjQk0Fmp
         vhz8Y0orsWM6KEe/UcHIAIAqzvlQ2/00gQ2aVd+R1ZJFa5CbDXKOKzfGNuY9Le2GduuG
         1CToTAPNX6eiTz4jWwMAPyLB2fi5oTxLaTR2jEonY5FN346vIzCBmR5fnKi+GiPRjqRL
         oPS/tpDC2JH1YnMpu19vkKeIHs/823iWn2xRn4rs4SEit5GKz1NxaKdPfh6ZCjXKWCHa
         F8xRlNNGsjFDEZ5SOIkYlC4VsNj5tHbUuJvBpkJmp2t/XU2fQAOilGJ0p8WDYmFPJrJ9
         GULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698787669; x=1699392469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UldHiEfbNixhoGZziFzkGsGZjUM85AdNIN2RpBGCLiU=;
        b=B/5POuy5f6a7ZNF56rtKJnOMMNxb9KY5rkYTt1ueK/zWQhb/KQb5I1oDiKj27SdNdt
         RmIgKJCKbsYn+Jxkf6vYEHlShtTzLKHoJFLtz68RgrX5yiS3C9z4nSqQqL5HeP0pPeLX
         z2sisxYuAOoRM3/Xyto0jsDiJro6jw+81dNAeQHewW00YX9rjorgl4kgBbZA4gPzuR1N
         8I8NlsCPFMbBRSzG20/NE6gkY0E7MwL1b48vhhNVA8dvsB4tWTtBr68ju9lob5SwWLln
         exgLCBR1kyhaCa8aMKmuqWKizfr6NAOYrb9Ajg72pA34b+BWcg5/Fb48GC296AOHErWP
         b+6w==
X-Gm-Message-State: AOJu0YzCO+D/H4D0vGoRS4lvUgwBQH63qEWFQLGX5O06lgEkJDLu88vo
	otJKWCoGbmqs5KrzbAXZb19X+SiHszSGAw==
X-Google-Smtp-Source: AGHT+IFSieqtk2i0cCIrrjy54lrYl6WFeSszSK7B7dOZcuwjjGDjwjfdHaFaSnhDgTEbRacMGh82pQ==
X-Received: by 2002:a05:6830:2684:b0:6d3:12be:804d with SMTP id l4-20020a056830268400b006d312be804dmr2695172otu.20.1698787669224;
        Tue, 31 Oct 2023 14:27:49 -0700 (PDT)
Received: from localhost (fwdproxy-vll-008.fbsv.net. [2a03:2880:12ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id m24-20020a9d6ad8000000b006b87f593877sm21760otq.37.2023.10.31.14.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 14:27:48 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next ] selftests/bpf: consolidate VIRTIO/9P configs in config.vm file
Date: Tue, 31 Oct 2023 14:27:17 -0700
Message-Id: <20231031212717.4037892-1-chantr4@gmail.com>
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

By moving them to `config,vm`, we should have selftest kernels which are
equal in term of VM functionalities when they include this file.

The set of config unabled were picked using

    grep -h -E '(_9P|_VIRTIO)' config.x86_64 config | sort | uniq

added to `config.vm` and then
    grep -vE '(_9P|_VIRTIO)' config.{x86_64,aarch64,s390x}

as a side-effect, some config may have disappeared to the aarch64 and
s390x kernels, but they should not be needed. CI will tell.

Signed-off-by: Manu Bretelle <chantr4@gmail.com>
---
 tools/testing/selftests/bpf/config.aarch64 | 16 ----------------
 tools/testing/selftests/bpf/config.s390x   |  9 ---------
 tools/testing/selftests/bpf/config.vm      | 12 ++++++++++++
 tools/testing/selftests/bpf/config.x86_64  | 12 ------------
 tools/testing/selftests/bpf/vmtest.sh      |  4 +++-
 5 files changed, 15 insertions(+), 38 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/config.vm

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
diff --git a/tools/testing/selftests/bpf/config.vm b/tools/testing/selftests/bpf/config.vm
new file mode 100644
index 000000000000..a9746ca78777
--- /dev/null
+++ b/tools/testing/selftests/bpf/config.vm
@@ -0,0 +1,12 @@
+CONFIG_9P_FS=y
+CONFIG_9P_FS_POSIX_ACL=y
+CONFIG_9P_FS_SECURITY=y
+CONFIG_CRYPTO_DEV_VIRTIO=y
+CONFIG_NET_9P=y
+CONFIG_NET_9P_VIRTIO=y
+CONFIG_VIRTIO_BALLOON=y
+CONFIG_VIRTIO_BLK=y
+CONFIG_VIRTIO_CONSOLE=y
+CONFIG_VIRTIO_NET=y
+CONFIG_VIRTIO_PCI=y
+CONFIG_VIRTIO_VSOCKETS_COMMON=y
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
diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
index 685034528018..65d14f3bbe30 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -36,7 +36,9 @@ DEFAULT_COMMAND="./test_progs"
 MOUNT_DIR="mnt"
 ROOTFS_IMAGE="root.img"
 OUTPUT_DIR="$HOME/.bpf_selftests"
-KCONFIG_REL_PATHS=("tools/testing/selftests/bpf/config" "tools/testing/selftests/bpf/config.${ARCH}")
+KCONFIG_REL_PATHS=("tools/testing/selftests/bpf/config"
+	"tools/testing/selftests/bpf/config.vm"
+	"tools/testing/selftests/bpf/config.${ARCH}")
 INDEX_URL="https://raw.githubusercontent.com/libbpf/ci/master/INDEX"
 NUM_COMPILE_JOBS="$(nproc)"
 LOG_FILE_BASE="$(date +"bpf_selftests.%Y-%m-%d_%H-%M-%S")"
-- 
2.39.3


