Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA51FE8E18
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2019 18:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfJ2R3a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Oct 2019 13:29:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46846 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727456AbfJ2R33 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Oct 2019 13:29:29 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9TGsF8D087470
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2019 13:29:28 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vxrru2nr4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2019 13:29:28 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Tue, 29 Oct 2019 17:29:26 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 29 Oct 2019 17:29:24 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9THSm3Z41943478
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 17:28:48 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6AC2711C058;
        Tue, 29 Oct 2019 17:29:22 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D12F11C04C;
        Tue, 29 Oct 2019 17:29:22 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.96.221])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 29 Oct 2019 17:29:21 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] bpf: add s390 testing documentation
Date:   Tue, 29 Oct 2019 18:29:16 +0100
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19102917-0028-0000-0000-000003B0D6EF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102917-0029-0000-0000-0000247318D9
Message-Id: <20191029172916.36528-1-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-29_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910290150
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This commits adds a document that explains how to test BPF in an s390
QEMU guest.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---

I've been asked a few times how to test BPF on s390, so I took some time
to compile from various sources and test the attached guide.

Known limitations:

- Debian host or debootstrap-based chroot is required. Compiling for
  s390 on other popular distros is much more tedious.
- When using a little-endian host, BTF must be disabled. pahole doesn't
  seem to support cross-compilation right now.

Documentation/bpf/index.rst |   9 ++
 Documentation/bpf/s390.rst  | 205 ++++++++++++++++++++++++++++++++++++
 2 files changed, 214 insertions(+)
 create mode 100644 Documentation/bpf/s390.rst

diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
index 801a6ed3f2e5..4f5410b61441 100644
--- a/Documentation/bpf/index.rst
+++ b/Documentation/bpf/index.rst
@@ -47,6 +47,15 @@ Program types
    prog_flow_dissector
 
 
+Testing BPF
+===========
+
+.. toctree::
+   :maxdepth: 1
+
+   s390
+
+
 .. Links:
 .. _Documentation/networking/filter.txt: ../networking/filter.txt
 .. _man-pages: https://www.kernel.org/doc/man-pages/
diff --git a/Documentation/bpf/s390.rst b/Documentation/bpf/s390.rst
new file mode 100644
index 000000000000..21ecb309daea
--- /dev/null
+++ b/Documentation/bpf/s390.rst
@@ -0,0 +1,205 @@
+===================
+Testing BPF on s390
+===================
+
+1. Introduction
+***************
+
+IBM Z are mainframe computers, which are descendants of IBM System/360 from
+year 1964. They are supported by the Linux kernel under the name "s390". This
+document describes how to test BPF in an s390 QEMU guest.
+
+2. One-time setup
+*****************
+
+The following is required to build and run the test suite:
+
+  * s390 GCC
+  * s390 development headers and libraries
+  * Clang with BPF support
+  * QEMU with s390 support
+  * Disk image with s390 rootfs
+
+Debian supports installing compiler and libraries for s390 out of the box.
+Users of other distros may use debootstrap in order to set up a Debian chroot::
+
+  sudo debootstrap \
+    --variant=minbase \
+    --include=sudo \
+    testing \
+    ./s390-toolchain
+  sudo mount --rbind /dev ./s390-toolchain/dev
+  sudo mount --rbind /proc ./s390-toolchain/proc
+  sudo mount --rbind /sys ./s390-toolchain/sys
+  sudo chroot ./s390-toolchain
+
+Once on Debian, the build prerequisites can be installed as follows::
+
+  sudo dpkg --add-architecture s390x
+  sudo apt-get update
+  sudo apt-get install \
+    bc \
+    bison \
+    cmake \
+    debootstrap \
+    dwarves \
+    flex \
+    g++ \
+    gcc \
+    g++-s390x-linux-gnu \
+    gcc-s390x-linux-gnu \
+    gdb-multiarch \
+    git \
+    make \
+    python3 \
+    qemu-system-misc \
+    qemu-utils \
+    rsync \
+    libcap-dev:s390x \
+    libelf-dev:s390x \
+    libncurses-dev
+
+Latest Clang targeting BPF can be installed as follows::
+
+  git clone https://github.com/llvm/llvm-project.git
+  ln -s ../../clang llvm-project/llvm/tools/
+  mkdir llvm-project-build
+  cd llvm-project-build
+  cmake \
+    -DLLVM_TARGETS_TO_BUILD=BPF \
+    -DCMAKE_BUILD_TYPE=Release \
+    -DCMAKE_INSTALL_PREFIX=/opt/clang-bpf \
+    ../llvm-project/llvm
+  make
+  sudo make install
+  export PATH=/opt/clang-bpf/bin:$PATH
+
+The disk image can be prepared using a loopback mount and debootstrap::
+
+  qemu-img create -f raw ./s390.img 1G
+  sudo losetup -f ./s390.img
+  sudo mkfs.ext4 /dev/loopX
+  mkdir ./s390.rootfs
+  sudo mount /dev/loopX ./s390.rootfs
+  sudo debootstrap \
+    --foreign \
+    --arch=s390x \
+    --variant=minbase \
+    --include=" \
+      iproute2, \
+      iputils-ping, \
+      isc-dhcp-client, \
+      kmod, \
+      libcap2, \
+      libelf1, \
+      netcat, \
+      procps" \
+    testing \
+    ./s390.rootfs
+  sudo umount ./s390.rootfs
+  sudo losetup -d /dev/loopX
+
+3. Compilation
+**************
+
+In addition to the usual Kconfig options required to run the BPF test suite, it
+is also helpful to select::
+
+  CONFIG_NET_9P=y
+  CONFIG_9P_FS=y
+  CONFIG_NET_9P_VIRTIO=y
+  CONFIG_VIRTIO_PCI=y
+
+as that would enable a very easy way to share files with the s390 virtual
+machine.
+
+Compiling kernel, modules and testsuite, as well as preparing gdb scripts to
+simplify debugging, can be done using the following commands::
+
+  make ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- menuconfig
+  make ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- bzImage modules scripts_gdb
+  make ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- \
+    -C tools/testing/selftests \
+    TARGETS=bpf \
+    INSTALL_PATH=$PWD/tools/testing/selftests/kselftest_install \
+    install
+
+4. Running the test suite
+*************************
+
+The virtual machine can be started as follows::
+
+  qemu-system-s390x \
+    -cpu max,zpci=on \
+    -smp 2 \
+    -m 4G \
+    -kernel linux/arch/s390/boot/compressed/vmlinux \
+    -drive file=./s390.img,if=virtio,format=raw \
+    -nographic \
+    -append 'root=/dev/vda rw console=ttyS1' \
+    -virtfs local,path=./linux,security_model=none,mount_tag=linux \
+    -object rng-random,filename=/dev/urandom,id=rng0 \
+    -device virtio-rng-ccw,rng=rng0 \
+    -netdev user,id=net0 \
+    -device virtio-net-ccw,netdev=net0
+
+When using this on a real IBM Z, ``-enable-kvm`` may be added for better
+performance. When starting the virtual machine for the first time, disk image
+setup must be finalized using the following command::
+
+  /debootstrap/debootstrap --second-stage
+
+Directory with the code built on the host as well as ``/proc`` and ``/sys``
+need to be mounted as follows::
+
+  mkdir -p /linux
+  mount -t 9p linux /linux
+  mount -t proc proc /proc
+  mount -t sysfs sys /sys
+
+After that, the test suite can be run using the following commands::
+
+  cd /linux/tools/testing/selftests/kselftest_install
+  ./run_kselftest.sh
+
+As usual, tests can be also run individually::
+
+  cd /linux/tools/testing/selftests/bpf
+  ./test_verifier
+
+5. Debugging
+************
+
+It is possible to debug the s390 kernel using QEMU GDB stub, which is activated
+by passing ``-s`` to QEMU.
+
+It is preferable to turn KASLR off, so that gdb would know where to find the
+kernel image in memory, by building the kernel with::
+
+  RANDOMIZE_BASE=n
+
+GDB can then be attached using the following command::
+
+  gdb-multiarch -ex 'target remote localhost:1234' ./vmlinux
+
+6. Network
+**********
+
+In case one needs to use the network in the virtual machine in order to e.g.
+install additional packages, it can be configured using::
+
+  dhclient eth0
+
+7. Links
+********
+
+This document is a compilation of techniques, whose more comprehensive
+descriptions can be found by following these links:
+
+- `Debootstrap <https://wiki.debian.org/EmDebian/CrossDebootstrap>`_
+- `Multiarch <https://wiki.debian.org/Multiarch/HOWTO>`_
+- `Building LLVM <https://llvm.org/docs/CMake.html>`_
+- `Cross-compiling the kernel <https://wiki.gentoo.org/wiki/Embedded_Handbook/General/Cross-compiling_the_kernel>`_
+- `QEMU s390x Guest Support <https://wiki.qemu.org/Documentation/Platforms/S390X>`_
+- `Plan 9 folder sharing over Virtio <https://wiki.qemu.org/Documentation/9psetup>`_
+- `Using GDB with QEMU <https://wiki.osdev.org/Kernel_Debugging#Use_GDB_with_QEMU>`_
-- 
2.23.0

