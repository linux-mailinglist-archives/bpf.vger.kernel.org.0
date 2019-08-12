Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 897CD8A663
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2019 20:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfHLSj5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Aug 2019 14:39:57 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:24164 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726424AbfHLSj4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 12 Aug 2019 14:39:56 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7CIYNw9013837
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2019 11:39:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=eyEMaYWqtESnIIzU6Mqs9jhg6NkIq2RYm8vd3xZE6as=;
 b=PiCoKbWEus9v3CSXcjwyeivCTfnm8zVrXeU5oUB5bBEjV4ciueZ+15MGuuA1ogw4I+ft
 bATblt2s4LFciQPmEYRC9+iMHhS0eqb/PkMqywfwyHjkZmlkW+C9R/6CbGiHgdtaZP+6
 VHKV6v6kBnB3yX08DKKPIzyP4DwY7l6fQIs= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2ubcy106q4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2019 11:39:55 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 12 Aug 2019 11:39:54 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id A64B78616EA; Mon, 12 Aug 2019 11:39:53 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [RESEND][PATCH v3 bpf-next] btf: expose BTF info through sysfs
Date:   Mon, 12 Aug 2019 11:39:47 -0700
Message-ID: <20190812183947.130889-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=9 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=866 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120196
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make .BTF section allocated and expose its contents through sysfs.

/sys/kernel/btf directory is created to contain all the BTFs present
inside kernel. Currently there is only kernel's main BTF, represented as
/sys/kernel/btf/kernel file. Once kernel modules' BTFs are supported,
each module will expose its BTF as /sys/kernel/btf/<module-name> file.

Current approach relies on a few pieces coming together:
1. pahole is used to take almost final vmlinux image (modulo .BTF and
   kallsyms) and generate .BTF section by converting DWARF info into
   BTF. This section is not allocated and not mapped to any segment,
   though, so is not yet accessible from inside kernel at runtime.
2. objcopy dumps .BTF contents into binary file and subsequently
   convert binary file into linkable object file with automatically
   generated symbols _binary__btf_kernel_bin_start and
   _binary__btf_kernel_bin_end, pointing to start and end, respectively,
   of BTF raw data.
3. final vmlinux image is generated by linking this object file (and
   kallsyms, if necessary). sysfs_btf.c then creates
   /sys/kernel/btf/kernel file and exposes embedded BTF contents through
   it. This allows, e.g., libbpf and bpftool access BTF info at
   well-known location, without resorting to searching for vmlinux image
   on disk (location of which is not standardized and vmlinux image
   might not be even available in some scenarios, e.g., inside qemu
   during testing).

Alternative approach using .incbin assembler directive to embed BTF
contents directly was attempted but didn't work, because sysfs_proc.o is
not re-compiled during link-vmlinux.sh stage. This is required, though,
to update embedded BTF data (initially empty data is embedded, then
pahole generates BTF info and we need to regenerate sysfs_btf.o with
updated contents, but it's too late at that point).

If BTF couldn't be generated due to missing or too old pahole,
sysfs_btf.c handles that gracefully by detecting that
_binary__btf_kernel_bin_start (weak symbol) is 0 and not creating
/sys/kernel/btf at all.

v2->v3:
- added Documentation/ABI/testing/sysfs-kernel-btf (Greg K-H);
- created proper kobject (btf_kobj) for btf directory (Greg K-H);
- undo v2 change of reusing vmlinux, as it causes extra kallsyms pass
  due to initially missing  __binary__btf_kernel_bin_{start/end} symbols;

v1->v2:
- allow kallsyms stage to re-use vmlinux generated by gen_btf();

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---

Resending with shorter CC list as it seems vger blocked my patch.
Added Greg's Reviewd-by, though.

 Documentation/ABI/testing/sysfs-kernel-btf | 17 +++++++
 kernel/bpf/Makefile                        |  3 ++
 kernel/bpf/sysfs_btf.c                     | 51 +++++++++++++++++++++
 scripts/link-vmlinux.sh                    | 52 ++++++++++++++--------
 4 files changed, 104 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-btf
 create mode 100644 kernel/bpf/sysfs_btf.c

diff --git a/Documentation/ABI/testing/sysfs-kernel-btf b/Documentation/ABI/testing/sysfs-kernel-btf
new file mode 100644
index 000000000000..5390f8001f96
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-btf
@@ -0,0 +1,17 @@
+What:		/sys/kernel/btf
+Date:		Aug 2019
+KernelVersion:	5.5
+Contact:	bpf@vger.kernel.org
+Description:
+		Contains BTF type information and related data for kernel and
+		kernel modules.
+
+What:		/sys/kernel/btf/kernel
+Date:		Aug 2019
+KernelVersion:	5.5
+Contact:	bpf@vger.kernel.org
+Description:
+		Read-only binary attribute exposing kernel's own BTF type
+		information with description of all internal kernel types. See
+		Documentation/bpf/btf.rst for detailed description of format
+		itself.
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 29d781061cd5..e1d9adb212f9 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -22,3 +22,6 @@ obj-$(CONFIG_CGROUP_BPF) += cgroup.o
 ifeq ($(CONFIG_INET),y)
 obj-$(CONFIG_BPF_SYSCALL) += reuseport_array.o
 endif
+ifeq ($(CONFIG_SYSFS),y)
+obj-$(CONFIG_DEBUG_INFO_BTF) += sysfs_btf.o
+endif
diff --git a/kernel/bpf/sysfs_btf.c b/kernel/bpf/sysfs_btf.c
new file mode 100644
index 000000000000..092e63b9758b
--- /dev/null
+++ b/kernel/bpf/sysfs_btf.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Provide kernel BTF information for introspection and use by eBPF tools.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/kobject.h>
+#include <linux/init.h>
+#include <linux/sysfs.h>
+
+/* See scripts/link-vmlinux.sh, gen_btf() func for details */
+extern char __weak _binary__btf_kernel_bin_start[];
+extern char __weak _binary__btf_kernel_bin_end[];
+
+static ssize_t
+btf_kernel_read(struct file *file, struct kobject *kobj,
+		struct bin_attribute *bin_attr,
+		char *buf, loff_t off, size_t len)
+{
+	memcpy(buf, _binary__btf_kernel_bin_start + off, len);
+	return len;
+}
+
+static struct bin_attribute bin_attr_btf_kernel __ro_after_init = {
+	.attr = { .name = "kernel", .mode = 0444, },
+	.read = btf_kernel_read,
+};
+
+static struct kobject *btf_kobj;
+
+static int __init btf_kernel_init(void)
+{
+	int err;
+
+	if (!_binary__btf_kernel_bin_start)
+		return 0;
+
+	btf_kobj = kobject_create_and_add("btf", kernel_kobj);
+	if (IS_ERR(btf_kobj)) {
+		err = PTR_ERR(btf_kobj);
+		btf_kobj = NULL;
+		return err;
+	}
+
+	bin_attr_btf_kernel.size = _binary__btf_kernel_bin_end -
+				   _binary__btf_kernel_bin_start;
+
+	return sysfs_create_bin_file(btf_kobj, &bin_attr_btf_kernel);
+}
+
+subsys_initcall(btf_kernel_init);
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index a7124f895b24..cb93832c6ad7 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -56,8 +56,8 @@ modpost_link()
 }
 
 # Link of vmlinux
-# ${1} - optional extra .o files
-# ${2} - output file
+# ${1} - output file
+# ${@:2} - optional extra .o files
 vmlinux_link()
 {
 	local lds="${objtree}/${KBUILD_LDS}"
@@ -70,9 +70,9 @@ vmlinux_link()
 			--start-group				\
 			${KBUILD_VMLINUX_LIBS}			\
 			--end-group				\
-			${1}"
+			${@:2}"
 
-		${LD} ${KBUILD_LDFLAGS} ${LDFLAGS_vmlinux} -o ${2}	\
+		${LD} ${KBUILD_LDFLAGS} ${LDFLAGS_vmlinux} -o ${1}	\
 			-T ${lds} ${objects}
 	else
 		objects="-Wl,--whole-archive			\
@@ -81,9 +81,9 @@ vmlinux_link()
 			-Wl,--start-group			\
 			${KBUILD_VMLINUX_LIBS}			\
 			-Wl,--end-group				\
-			${1}"
+			${@:2}"
 
-		${CC} ${CFLAGS_vmlinux} -o ${2}			\
+		${CC} ${CFLAGS_vmlinux} -o ${1}			\
 			-Wl,-T,${lds}				\
 			${objects}				\
 			-lutil -lrt -lpthread
@@ -92,23 +92,34 @@ vmlinux_link()
 }
 
 # generate .BTF typeinfo from DWARF debuginfo
+# ${1} - vmlinux image
+# ${2} - file to dump raw BTF data into
 gen_btf()
 {
-	local pahole_ver;
+	local pahole_ver
+	local bin_arch
 
 	if ! [ -x "$(command -v ${PAHOLE})" ]; then
 		info "BTF" "${1}: pahole (${PAHOLE}) is not available"
-		return 0
+		return 1
 	fi
 
 	pahole_ver=$(${PAHOLE} --version | sed -E 's/v([0-9]+)\.([0-9]+)/\1\2/')
 	if [ "${pahole_ver}" -lt "113" ]; then
 		info "BTF" "${1}: pahole version $(${PAHOLE} --version) is too old, need at least v1.13"
-		return 0
+		return 1
 	fi
 
-	info "BTF" ${1}
+	info "BTF" ${2}
+	vmlinux_link ${1}
 	LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}
+
+	# dump .BTF section into raw binary file to link with final vmlinux
+	bin_arch=$(${OBJDUMP} -f ${1} | grep architecture | \
+		cut -d, -f1 | cut -d' ' -f2)
+	${OBJCOPY} --dump-section .BTF=.btf.kernel.bin ${1} 2>/dev/null
+	${OBJCOPY} -I binary -O ${CONFIG_OUTPUT_FORMAT} -B ${bin_arch} \
+		--rename-section .data=.BTF .btf.kernel.bin ${2}
 }
 
 # Create ${2} .o file with all symbols from the ${1} object file
@@ -153,6 +164,7 @@ sortextable()
 # Delete output files in case of error
 cleanup()
 {
+	rm -f .btf.*
 	rm -f .tmp_System.map
 	rm -f .tmp_kallsyms*
 	rm -f .tmp_vmlinux*
@@ -215,6 +227,13 @@ ${MAKE} -f "${srctree}/scripts/Makefile.modpost" vmlinux.o
 info MODINFO modules.builtin.modinfo
 ${OBJCOPY} -j .modinfo -O binary vmlinux.o modules.builtin.modinfo
 
+btf_kernel_bin_o=""
+if [ -n "${CONFIG_DEBUG_INFO_BTF}" ]; then
+	if gen_btf .tmp_vmlinux.btf .btf.kernel.bin.o ; then
+		btf_kernel_bin_o=.btf.kernel.bin.o
+	fi
+fi
+
 kallsymso=""
 kallsyms_vmlinux=""
 if [ -n "${CONFIG_KALLSYMS}" ]; then
@@ -246,11 +265,11 @@ if [ -n "${CONFIG_KALLSYMS}" ]; then
 	kallsyms_vmlinux=.tmp_vmlinux2
 
 	# step 1
-	vmlinux_link "" .tmp_vmlinux1
+	vmlinux_link .tmp_vmlinux1 ${btf_kernel_bin_o}
 	kallsyms .tmp_vmlinux1 .tmp_kallsyms1.o
 
 	# step 2
-	vmlinux_link .tmp_kallsyms1.o .tmp_vmlinux2
+	vmlinux_link .tmp_vmlinux2 .tmp_kallsyms1.o ${btf_kernel_bin_o}
 	kallsyms .tmp_vmlinux2 .tmp_kallsyms2.o
 
 	# step 3
@@ -261,18 +280,13 @@ if [ -n "${CONFIG_KALLSYMS}" ]; then
 		kallsymso=.tmp_kallsyms3.o
 		kallsyms_vmlinux=.tmp_vmlinux3
 
-		vmlinux_link .tmp_kallsyms2.o .tmp_vmlinux3
-
+		vmlinux_link .tmp_vmlinux3 .tmp_kallsyms2.o ${btf_kernel_bin_o}
 		kallsyms .tmp_vmlinux3 .tmp_kallsyms3.o
 	fi
 fi
 
 info LD vmlinux
-vmlinux_link "${kallsymso}" vmlinux
-
-if [ -n "${CONFIG_DEBUG_INFO_BTF}" ]; then
-	gen_btf vmlinux
-fi
+vmlinux_link vmlinux "${kallsymso}" "${btf_kernel_bin_o}"
 
 if [ -n "${CONFIG_BUILDTIME_EXTABLE_SORT}" ]; then
 	info SORTEX vmlinux
-- 
2.17.1

