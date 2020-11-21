Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75AD72BBDBD
	for <lists+bpf@lfdr.de>; Sat, 21 Nov 2020 08:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgKUHIm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 21 Nov 2020 02:08:42 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:25166 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725934AbgKUHIm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 21 Nov 2020 02:08:42 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0AL77jbS019454
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2020 23:08:41 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 34whfkye6x-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2020 23:08:41 -0800
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 20 Nov 2020 23:08:39 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 3F1AF2EC9D02; Fri, 20 Nov 2020 23:08:37 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Bruce Allan <bruce.w.allan@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH RESEND bpf-next 1/2] kbuild: skip module BTF generation for out-of-tree external modules
Date:   Fri, 20 Nov 2020 23:08:28 -0800
Message-ID: <20201121070829.2612884-1-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-21_03:2020-11-20,2020-11-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 malwarescore=0 phishscore=0 suspectscore=15 priorityscore=1501
 impostorscore=0 mlxlogscore=878 lowpriorityscore=0 spamscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011210047
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In some modes of operation, Kbuild allows to build modules without having
vmlinux image around. In such case, generation of module BTF is impossible.
This patch changes the behavior to emit a warning about impossibility of
generating kernel module BTF, instead of breaking the build. This is especially
important for out-of-tree external module builds.

In vmlinux-less mode:

$ make clean
$ make modules_prepare
$ touch drivers/acpi/button.c
$ make M=drivers/acpi
...
  CC [M]  drivers/acpi/button.o
  MODPOST drivers/acpi/Module.symvers
  LD [M]  drivers/acpi/button.ko
  BTF [M] drivers/acpi/button.ko
Skipping BTF generation for drivers/acpi/button.ko due to unavailability of vmlinux
...
$ readelf -S ~/linux-build/default/drivers/acpi/button.ko | grep BTF -A1
... empty ...

Now with normal build:

$ make all
...
LD [M]  drivers/acpi/button.ko
BTF [M] drivers/acpi/button.ko
...
$ readelf -S ~/linux-build/default/drivers/acpi/button.ko | grep BTF -A1
  [60] .BTF              PROGBITS         0000000000000000  00029310
       000000000000ab3f  0000000000000000           0     0     1

Reported-by: Bruce Allan <bruce.w.allan@intel.com>
Fixes: 5f9ae91f7c0d ("kbuild: Build kernel module BTFs if BTF is enabled and pahole supports it")
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 scripts/Makefile.modfinal | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 02b892421f7a..d49ec001825d 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -38,7 +38,12 @@ quiet_cmd_ld_ko_o = LD [M]  $@
 	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
 
 quiet_cmd_btf_ko = BTF [M] $@
-      cmd_btf_ko = LLVM_OBJCOPY=$(OBJCOPY) $(PAHOLE) -J --btf_base vmlinux $@
+      cmd_btf_ko = 							\
+	if [ -f vmlinux ]; then						\
+		LLVM_OBJCOPY=$(OBJCOPY) $(PAHOLE) -J --btf_base vmlinux $@; \
+	else								\
+		printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
+	fi;
 
 # Same as newer-prereqs, but allows to exclude specified extra dependencies
 newer_prereqs_except = $(filter-out $(PHONY) $(1),$?)
@@ -49,7 +54,7 @@ if_changed_except = $(if $(call newer_prereqs_except,$(2))$(cmd-check),      \
 	printf '%s\n' 'cmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
 
 # Re-generate module BTFs if either module's .ko or vmlinux changed
-$(modules): %.ko: %.o %.mod.o scripts/module.lds vmlinux FORCE
+$(modules): %.ko: %.o %.mod.o scripts/module.lds $(if $(KBUILD_BUILTIN),vmlinux) FORCE
 	+$(call if_changed_except,ld_ko_o,vmlinux)
 ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	+$(if $(newer-prereqs),$(call cmd,btf_ko))
-- 
2.24.1

