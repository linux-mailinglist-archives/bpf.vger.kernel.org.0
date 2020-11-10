Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB822ACA6C
	for <lists+bpf@lfdr.de>; Tue, 10 Nov 2020 02:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbgKJBZ5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 9 Nov 2020 20:25:57 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1706 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727311AbgKJBZw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 9 Nov 2020 20:25:52 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AA1PkCO015261
        for <bpf@vger.kernel.org>; Mon, 9 Nov 2020 17:25:52 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34pbxxg50d-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2020 17:25:52 -0800
Received: from intmgw001.08.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 9 Nov 2020 17:25:38 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 8E58D2EC9244; Mon,  9 Nov 2020 17:19:40 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <jeyu@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v4 bpf-next 3/5] kbuild: build kernel module BTFs if BTF is enabled and pahole supports it
Date:   Mon, 9 Nov 2020 17:19:30 -0800
Message-ID: <20201110011932.3201430-4-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201110011932.3201430-1-andrii@kernel.org>
References: <20201110011932.3201430-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-09_15:2020-11-05,2020-11-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 suspectscore=9 adultscore=0 mlxscore=0 phishscore=0
 clxscore=1034 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011100009
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Detect if pahole supports split BTF generation, and generate BTF for each
selected kernel module, if it does. This is exposed to Makefiles and C code as
CONFIG_DEBUG_INFO_BTF_MODULES flag.

Kernel module BTF has to be re-generated if either vmlinux's BTF changes or
module's .ko changes. To achieve that, I needed a helper similar to
if_changed, but that would allow to filter out vmlinux from the list of
updated dependencies for .ko building. I've put it next to the only place that
uses and needs it, but it might be a better idea to just add it along the
other if_changed variants into scripts/Kbuild.include.

Each kernel module's BTF deduplication is pretty fast, as it does only
incremental BTF deduplication on top of already deduplicated vmlinux BTF. To
show the added build time, I've first ran make only just built kernel (to
establish the baseline) and then forced only BTF re-generation, without
regenerating .ko files. The build was performed with -j60 parallelization on
56-core machine. The final time also includes bzImage building, so it's not
a pure BTF overhead.

$ time make -j60
...
make -j60  27.65s user 10.96s system 782% cpu 4.933 total
$ touch ~/linux-build/default/vmlinux && time make -j60
...
make -j60  123.69s user 27.85s system 1566% cpu 9.675 total

So 4.6 seconds real time, with noticeable part spent in compressed vmlinux and
bzImage building.

To show size savings, I've built my kernel configuration with about 700 kernel
modules with full BTF per each kernel module (without deduplicating against
vmlinux) and with split BTF against deduplicated vmlinux (approach in this
patch). Below are top 10 modules with biggest BTF sizes. And total size of BTF
data across all kernel modules.

It shows that split BTF "compresses" 115MB down to 5MB total. And the biggest
kernel modules get a downsize from 500-570KB down to 200-300KB.

FULL BTF
========

$ for f in $(find . -name '*.ko'); do size -A -d $f | grep BTF | awk '{print $2}'; done | awk '{ s += $1 } END { print s }'
115710691

$ for f in $(find . -name '*.ko'); do printf "%s %d\n" $f $(size -A -d $f | grep BTF | awk '{print $2}'); done | sort -nr -k2 | head -n10
./drivers/gpu/drm/i915/i915.ko 570570
./drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko 520240
./drivers/gpu/drm/radeon/radeon.ko 503849
./drivers/infiniband/hw/mlx5/mlx5_ib.ko 491777
./fs/xfs/xfs.ko 411544
./drivers/net/ethernet/intel/i40e/i40e.ko 403904
./drivers/net/ethernet/broadcom/bnx2x/bnx2x.ko 398754
./drivers/infiniband/core/ib_core.ko 397224
./fs/cifs/cifs.ko 386249
./fs/nfsd/nfsd.ko 379738

SPLIT BTF
=========

$ for f in $(find . -name '*.ko'); do size -A -d $f | grep BTF | awk '{print $2}'; done | awk '{ s += $1 } END { print s }'
5194047

$ for f in $(find . -name '*.ko'); do printf "%s %d\n" $f $(size -A -d $f | grep BTF | awk '{print $2}'); done | sort -nr -k2 | head -n10
./drivers/gpu/drm/i915/i915.ko 293206
./drivers/gpu/drm/radeon/radeon.ko 282103
./fs/xfs/xfs.ko 222150
./drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko 198503
./drivers/infiniband/hw/mlx5/mlx5_ib.ko 198356
./drivers/net/ethernet/broadcom/bnx2x/bnx2x.ko 113444
./fs/cifs/cifs.ko 109379
./arch/x86/kvm/kvm.ko 100225
./drivers/gpu/drm/drm.ko 94827
./drivers/infiniband/core/ib_core.ko 91188

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 lib/Kconfig.debug         |  9 +++++++++
 scripts/Makefile.modfinal | 20 ++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d7a7bc3b6098..1e78faaf20a5 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -274,6 +274,15 @@ config DEBUG_INFO_BTF
 	  Turning this on expects presence of pahole tool, which will convert
 	  DWARF type info into equivalent deduplicated BTF type info.
 
+config PAHOLE_HAS_SPLIT_BTF
+	def_bool $(success, test `$(PAHOLE) --version | sed -E 's/v([0-9]+)\.([0-9]+)/\1\2/'` -ge "119")
+
+config DEBUG_INFO_BTF_MODULES
+	def_bool y
+	depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
+	help
+	  Generate compact split BTF type information for kernel modules.
+
 config GDB_SCRIPTS
 	bool "Provide GDB scripts for kernel debugging"
 	help
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index ae01baf96f4e..02b892421f7a 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -6,6 +6,7 @@
 PHONY := __modfinal
 __modfinal:
 
+include include/config/auto.conf
 include $(srctree)/scripts/Kbuild.include
 
 # for c_flags
@@ -36,8 +37,23 @@ quiet_cmd_ld_ko_o = LD [M]  $@
 		-T scripts/module.lds -o $@ $(filter %.o, $^);		\
 	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
 
-$(modules): %.ko: %.o %.mod.o scripts/module.lds FORCE
-	+$(call if_changed,ld_ko_o)
+quiet_cmd_btf_ko = BTF [M] $@
+      cmd_btf_ko = LLVM_OBJCOPY=$(OBJCOPY) $(PAHOLE) -J --btf_base vmlinux $@
+
+# Same as newer-prereqs, but allows to exclude specified extra dependencies
+newer_prereqs_except = $(filter-out $(PHONY) $(1),$?)
+
+# Same as if_changed, but allows to exclude specified extra dependencies
+if_changed_except = $(if $(call newer_prereqs_except,$(2))$(cmd-check),      \
+	$(cmd);                                                              \
+	printf '%s\n' 'cmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
+
+# Re-generate module BTFs if either module's .ko or vmlinux changed
+$(modules): %.ko: %.o %.mod.o scripts/module.lds vmlinux FORCE
+	+$(call if_changed_except,ld_ko_o,vmlinux)
+ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+	+$(if $(newer-prereqs),$(call cmd,btf_ko))
+endif
 
 targets += $(modules) $(modules:.ko=.mod.o)
 
-- 
2.24.1

