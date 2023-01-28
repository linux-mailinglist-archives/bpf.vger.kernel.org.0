Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140C067F2C2
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjA1AIR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbjA1AIE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:08:04 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6598986EA4
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 16:07:44 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RMFIvk037315;
        Sat, 28 Jan 2023 00:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ihaKJzGjUFDGW3iaTJo9vKyuRr55rhjbe73r9H2SlP0=;
 b=N+UixptULOZztqtMcCJ2yD7I3U+awkCFj/DomBP5zR8hXjZ8zHsEGQeb2fitZepfNlt4
 SWJmGoVVUDoIj0S9QG3xgs/ToUQHAg8TG/BdW41jvQs65yLqiaeuD2HihsBoBApEAR5n
 ARD8iZ2UtlmcrPgdQ5iFBt2WzpPeiGxL+tG60QVWCIwE8Ksb/n+MpMUZxM+VN8YoYOH7
 DgI1JsP/j+FRNHKB6X3fIwxPrlb2b6/Aj3bHQyVZaxtf/0y+XyjvQMk5JkBETpOfTsJ8
 NxvolKaM5nEiz4jjGzrOzWMZc3X+ZodPs+VVoVgo7elSA8eoK2LKP7tXs2H4TMbXRywJ vA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncm3tecdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:27 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30RKAMh0027572;
        Sat, 28 Jan 2023 00:07:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3n87p6g5jq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:25 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30S07MYF47841586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Jan 2023 00:07:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF37E20043;
        Sat, 28 Jan 2023 00:07:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6EE6320040;
        Sat, 28 Jan 2023 00:07:21 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.11.57])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sat, 28 Jan 2023 00:07:21 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 24/31] bpf: iterators: Split iterators.lskel.h into little- and big- endian versions
Date:   Sat, 28 Jan 2023 01:06:43 +0100
Message-Id: <20230128000650.1516334-25-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128000650.1516334-1-iii@linux.ibm.com>
References: <20230128000650.1516334-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ViwezXmZZzytrtXiRbVm93H25z8qv9jV
X-Proofpoint-ORIG-GUID: ViwezXmZZzytrtXiRbVm93H25z8qv9jV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_14,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270216
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

iterators.lskel.h is little-endian, therefore bpf iterator is currently
broken on big-endian systems. Introduce a big-endian version and add
instructions regarding its generation. Unfortunately bpftool's
cross-endianness capabilities are limited to BTF right now, so the
procedure requires access to a big-endian machine or a configured
emulator.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 kernel/bpf/preload/bpf_preload_kern.c         |   6 +-
 kernel/bpf/preload/iterators/Makefile         |  12 +-
 kernel/bpf/preload/iterators/README           |   5 +-
 .../iterators/iterators.lskel-big-endian.h    | 419 ++++++++++++++++++
 ...skel.h => iterators.lskel-little-endian.h} |   0
 5 files changed, 435 insertions(+), 7 deletions(-)
 create mode 100644 kernel/bpf/preload/iterators/iterators.lskel-big-endian.h
 rename kernel/bpf/preload/iterators/{iterators.lskel.h => iterators.lskel-little-endian.h} (100%)

diff --git a/kernel/bpf/preload/bpf_preload_kern.c b/kernel/bpf/preload/bpf_preload_kern.c
index 5106b5372f0c..b56f9f3314fd 100644
--- a/kernel/bpf/preload/bpf_preload_kern.c
+++ b/kernel/bpf/preload/bpf_preload_kern.c
@@ -3,7 +3,11 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include "bpf_preload.h"
-#include "iterators/iterators.lskel.h"
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+#include "iterators/iterators.lskel-little-endian.h"
+#else
+#include "iterators/iterators.lskel-big-endian.h"
+#endif
 
 static struct bpf_link *maps_link, *progs_link;
 static struct iterators_bpf *skel;
diff --git a/kernel/bpf/preload/iterators/Makefile b/kernel/bpf/preload/iterators/Makefile
index 6762b1260f2f..8937dc6bc8d0 100644
--- a/kernel/bpf/preload/iterators/Makefile
+++ b/kernel/bpf/preload/iterators/Makefile
@@ -35,20 +35,22 @@ endif
 
 .PHONY: all clean
 
-all: iterators.lskel.h
+all: iterators.lskel-little-endian.h
+
+big: iterators.lskel-big-endian.h
 
 clean:
 	$(call msg,CLEAN)
 	$(Q)rm -rf $(OUTPUT) iterators
 
-iterators.lskel.h: $(OUTPUT)/iterators.bpf.o | $(BPFTOOL)
+iterators.lskel-%.h: $(OUTPUT)/%/iterators.bpf.o | $(BPFTOOL)
 	$(call msg,GEN-SKEL,$@)
 	$(Q)$(BPFTOOL) gen skeleton -L $< > $@
 
-
-$(OUTPUT)/iterators.bpf.o: iterators.bpf.c $(BPFOBJ) | $(OUTPUT)
+$(OUTPUT)/%/iterators.bpf.o: iterators.bpf.c $(BPFOBJ) | $(OUTPUT)
 	$(call msg,BPF,$@)
-	$(Q)$(CLANG) -g -O2 -target bpf $(INCLUDES)			      \
+	$(Q)mkdir -p $(@D)
+	$(Q)$(CLANG) -g -O2 -target bpf -m$* $(INCLUDES)		      \
 		 -c $(filter %.c,$^) -o $@ &&				      \
 	$(LLVM_STRIP) -g $@
 
diff --git a/kernel/bpf/preload/iterators/README b/kernel/bpf/preload/iterators/README
index 7fd6d39a9ad2..98e7c90ea012 100644
--- a/kernel/bpf/preload/iterators/README
+++ b/kernel/bpf/preload/iterators/README
@@ -1,4 +1,7 @@
 WARNING:
-If you change "iterators.bpf.c" do "make -j" in this directory to rebuild "iterators.skel.h".
+If you change "iterators.bpf.c" do "make -j" in this directory to
+rebuild "iterators.lskel-little-endian.h". Then, on a big-endian
+machine, do "make -j big" in this directory to rebuild
+"iterators.lskel-big-endian.h". Commit both resulting headers.
 Make sure to have clang 10 installed.
 See Documentation/bpf/bpf_devel_QA.rst
diff --git a/kernel/bpf/preload/iterators/iterators.lskel-big-endian.h b/kernel/bpf/preload/iterators/iterators.lskel-big-endian.h
new file mode 100644
index 000000000000..ebdc6c0cdb70
--- /dev/null
+++ b/kernel/bpf/preload/iterators/iterators.lskel-big-endian.h
@@ -0,0 +1,419 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+/* THIS FILE IS AUTOGENERATED BY BPFTOOL! */
+#ifndef __ITERATORS_BPF_SKEL_H__
+#define __ITERATORS_BPF_SKEL_H__
+
+#include <bpf/skel_internal.h>
+
+struct iterators_bpf {
+	struct bpf_loader_ctx ctx;
+	struct {
+		struct bpf_map_desc rodata;
+	} maps;
+	struct {
+		struct bpf_prog_desc dump_bpf_map;
+		struct bpf_prog_desc dump_bpf_prog;
+	} progs;
+	struct {
+		int dump_bpf_map_fd;
+		int dump_bpf_prog_fd;
+	} links;
+};
+
+static inline int
+iterators_bpf__dump_bpf_map__attach(struct iterators_bpf *skel)
+{
+	int prog_fd = skel->progs.dump_bpf_map.prog_fd;
+	int fd = skel_link_create(prog_fd, 0, BPF_TRACE_ITER);
+
+	if (fd > 0)
+		skel->links.dump_bpf_map_fd = fd;
+	return fd;
+}
+
+static inline int
+iterators_bpf__dump_bpf_prog__attach(struct iterators_bpf *skel)
+{
+	int prog_fd = skel->progs.dump_bpf_prog.prog_fd;
+	int fd = skel_link_create(prog_fd, 0, BPF_TRACE_ITER);
+
+	if (fd > 0)
+		skel->links.dump_bpf_prog_fd = fd;
+	return fd;
+}
+
+static inline int
+iterators_bpf__attach(struct iterators_bpf *skel)
+{
+	int ret = 0;
+
+	ret = ret < 0 ? ret : iterators_bpf__dump_bpf_map__attach(skel);
+	ret = ret < 0 ? ret : iterators_bpf__dump_bpf_prog__attach(skel);
+	return ret < 0 ? ret : 0;
+}
+
+static inline void
+iterators_bpf__detach(struct iterators_bpf *skel)
+{
+	skel_closenz(skel->links.dump_bpf_map_fd);
+	skel_closenz(skel->links.dump_bpf_prog_fd);
+}
+static void
+iterators_bpf__destroy(struct iterators_bpf *skel)
+{
+	if (!skel)
+		return;
+	iterators_bpf__detach(skel);
+	skel_closenz(skel->progs.dump_bpf_map.prog_fd);
+	skel_closenz(skel->progs.dump_bpf_prog.prog_fd);
+	skel_closenz(skel->maps.rodata.map_fd);
+	skel_free(skel);
+}
+static inline struct iterators_bpf *
+iterators_bpf__open(void)
+{
+	struct iterators_bpf *skel;
+
+	skel = skel_alloc(sizeof(*skel));
+	if (!skel)
+		goto cleanup;
+	skel->ctx.sz = (void *)&skel->links - (void *)skel;
+	return skel;
+cleanup:
+	iterators_bpf__destroy(skel);
+	return NULL;
+}
+
+static inline int
+iterators_bpf__load(struct iterators_bpf *skel)
+{
+	struct bpf_load_and_run_opts opts = {};
+	int err;
+
+	opts.ctx = (struct bpf_loader_ctx *)skel;
+	opts.data_sz = 6008;
+	opts.data = (void *)"\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xeb\x9f\x01\0\
+\0\0\0\x18\0\0\0\0\0\0\x04\x1c\0\0\x04\x1c\0\0\x05\x18\0\0\0\0\x02\0\0\0\0\0\0\
+\x02\0\0\0\x01\x04\0\0\x02\0\0\0\x10\0\0\0\x13\0\0\0\x03\0\0\0\0\0\0\0\x18\0\0\
+\0\x04\0\0\0\x40\0\0\0\0\x02\0\0\0\0\0\0\x08\0\0\0\0\x02\0\0\0\0\0\0\x0d\0\0\0\
+\0\x0d\0\0\x01\0\0\0\x06\0\0\0\x1c\0\0\0\x01\0\0\0\x20\x01\0\0\0\0\0\0\x04\x01\
+\0\0\x20\0\0\0\x24\x0c\0\0\x01\0\0\0\x05\0\0\0\xc2\x04\0\0\x03\0\0\0\x18\0\0\0\
+\xd0\0\0\0\x09\0\0\0\0\0\0\0\xd4\0\0\0\x0b\0\0\0\x40\0\0\0\xdf\0\0\0\x0b\0\0\0\
+\x80\0\0\0\0\x02\0\0\0\0\0\0\x0a\0\0\0\xe7\x07\0\0\0\0\0\0\0\0\0\0\xf0\x08\0\0\
+\0\0\0\0\x0c\0\0\0\xf6\x01\0\0\0\0\0\0\x08\0\0\0\x40\0\0\x01\xb3\x04\0\0\x03\0\
+\0\0\x18\0\0\x01\xbb\0\0\0\x0e\0\0\0\0\0\0\x01\xbe\0\0\0\x11\0\0\0\x20\0\0\x01\
+\xc3\0\0\0\x0e\0\0\0\xa0\0\0\x01\xcf\x08\0\0\0\0\0\0\x0f\0\0\x01\xd5\x01\0\0\0\
+\0\0\0\x04\0\0\0\x20\0\0\x01\xe2\x01\0\0\0\0\0\0\x01\x01\0\0\x08\0\0\0\0\x03\0\
+\0\0\0\0\0\0\0\0\0\x10\0\0\0\x12\0\0\0\x10\0\0\x01\xe7\x01\0\0\0\0\0\0\x04\0\0\
+\0\x20\0\0\0\0\x02\0\0\0\0\0\0\x14\0\0\x02\x4b\x04\0\0\x02\0\0\0\x10\0\0\0\x13\
+\0\0\0\x03\0\0\0\0\0\0\x02\x5e\0\0\0\x15\0\0\0\x40\0\0\0\0\x02\0\0\0\0\0\0\x18\
+\0\0\0\0\x0d\0\0\x01\0\0\0\x06\0\0\0\x1c\0\0\0\x13\0\0\x02\x63\x0c\0\0\x01\0\0\
+\0\x16\0\0\x02\xaf\x04\0\0\x01\0\0\0\x08\0\0\x02\xb8\0\0\0\x19\0\0\0\0\0\0\0\0\
+\x02\0\0\0\0\0\0\x1a\0\0\x03\x09\x04\0\0\x06\0\0\0\x38\0\0\x01\xbb\0\0\0\x0e\0\
+\0\0\0\0\0\x01\xbe\0\0\0\x11\0\0\0\x20\0\0\x03\x16\0\0\0\x1b\0\0\0\xc0\0\0\x03\
+\x27\0\0\0\x15\0\0\x01\0\0\0\x03\x30\0\0\0\x1d\0\0\x01\x40\0\0\x03\x3a\0\0\0\
+\x1e\0\0\x01\x80\0\0\0\0\x02\0\0\0\0\0\0\x1c\0\0\0\0\x0a\0\0\0\0\0\0\x10\0\0\0\
+\0\x02\0\0\0\0\0\0\x1f\0\0\0\0\x02\0\0\0\0\0\0\x20\0\0\x03\x84\x04\0\0\x02\0\0\
+\0\x08\0\0\x03\x92\0\0\0\x0e\0\0\0\0\0\0\x03\x9b\0\0\0\x0e\0\0\0\x20\0\0\x03\
+\x3a\x04\0\0\x03\0\0\0\x18\0\0\x03\xa5\0\0\0\x1b\0\0\0\0\0\0\x03\xad\0\0\0\x21\
+\0\0\0\x40\0\0\x03\xb3\0\0\0\x23\0\0\0\x80\0\0\0\0\x02\0\0\0\0\0\0\x22\0\0\0\0\
+\x02\0\0\0\0\0\0\x24\0\0\x03\xb7\x04\0\0\x01\0\0\0\x04\0\0\x03\xc2\0\0\0\x0e\0\
+\0\0\0\0\0\x04\x2b\x04\0\0\x01\0\0\0\x04\0\0\x04\x34\0\0\0\x0e\0\0\0\0\0\0\0\0\
+\x03\0\0\0\0\0\0\0\0\0\0\x1c\0\0\0\x12\0\0\0\x23\0\0\x04\xaa\x0e\0\0\0\0\0\0\
+\x25\0\0\0\0\0\0\0\0\x03\0\0\0\0\0\0\0\0\0\0\x1c\0\0\0\x12\0\0\0\x0e\0\0\x04\
+\xbe\x0e\0\0\0\0\0\0\x27\0\0\0\0\0\0\0\0\x03\0\0\0\0\0\0\0\0\0\0\x1c\0\0\0\x12\
+\0\0\0\x20\0\0\x04\xd4\x0e\0\0\0\0\0\0\x29\0\0\0\0\0\0\0\0\x03\0\0\0\0\0\0\0\0\
+\0\0\x1c\0\0\0\x12\0\0\0\x11\0\0\x04\xe9\x0e\0\0\0\0\0\0\x2b\0\0\0\0\0\0\0\0\
+\x03\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\x12\0\0\0\x04\0\0\x05\0\x0e\0\0\0\0\0\0\x2d\
+\0\0\0\x01\0\0\x05\x08\x0f\0\0\x04\0\0\0\x62\0\0\0\x26\0\0\0\0\0\0\0\x23\0\0\0\
+\x28\0\0\0\x23\0\0\0\x0e\0\0\0\x2a\0\0\0\x31\0\0\0\x20\0\0\0\x2c\0\0\0\x51\0\0\
+\0\x11\0\0\x05\x10\x0f\0\0\x01\0\0\0\x04\0\0\0\x2e\0\0\0\0\0\0\0\x04\0\x62\x70\
+\x66\x5f\x69\x74\x65\x72\x5f\x5f\x62\x70\x66\x5f\x6d\x61\x70\0\x6d\x65\x74\x61\
+\0\x6d\x61\x70\0\x63\x74\x78\0\x69\x6e\x74\0\x64\x75\x6d\x70\x5f\x62\x70\x66\
+\x5f\x6d\x61\x70\0\x69\x74\x65\x72\x2f\x62\x70\x66\x5f\x6d\x61\x70\0\x30\x3a\
+\x30\0\x2f\x68\x6f\x6d\x65\x2f\x69\x69\x69\x2f\x6c\x69\x6e\x75\x78\x2d\x6b\x65\
+\x72\x6e\x65\x6c\x2d\x74\x6f\x6f\x6c\x63\x68\x61\x69\x6e\x2f\x73\x72\x63\x2f\
+\x6c\x69\x6e\x75\x78\x2f\x6b\x65\x72\x6e\x65\x6c\x2f\x62\x70\x66\x2f\x70\x72\
+\x65\x6c\x6f\x61\x64\x2f\x69\x74\x65\x72\x61\x74\x6f\x72\x73\x2f\x69\x74\x65\
+\x72\x61\x74\x6f\x72\x73\x2e\x62\x70\x66\x2e\x63\0\x09\x73\x74\x72\x75\x63\x74\
+\x20\x73\x65\x71\x5f\x66\x69\x6c\x65\x20\x2a\x73\x65\x71\x20\x3d\x20\x63\x74\
+\x78\x2d\x3e\x6d\x65\x74\x61\x2d\x3e\x73\x65\x71\x3b\0\x62\x70\x66\x5f\x69\x74\
+\x65\x72\x5f\x6d\x65\x74\x61\0\x73\x65\x71\0\x73\x65\x73\x73\x69\x6f\x6e\x5f\
+\x69\x64\0\x73\x65\x71\x5f\x6e\x75\x6d\0\x73\x65\x71\x5f\x66\x69\x6c\x65\0\x5f\
+\x5f\x75\x36\x34\0\x75\x6e\x73\x69\x67\x6e\x65\x64\x20\x6c\x6f\x6e\x67\x20\x6c\
+\x6f\x6e\x67\0\x30\x3a\x31\0\x09\x73\x74\x72\x75\x63\x74\x20\x62\x70\x66\x5f\
+\x6d\x61\x70\x20\x2a\x6d\x61\x70\x20\x3d\x20\x63\x74\x78\x2d\x3e\x6d\x61\x70\
+\x3b\0\x09\x69\x66\x20\x28\x21\x6d\x61\x70\x29\0\x30\x3a\x32\0\x09\x5f\x5f\x75\
+\x36\x34\x20\x73\x65\x71\x5f\x6e\x75\x6d\x20\x3d\x20\x63\x74\x78\x2d\x3e\x6d\
+\x65\x74\x61\x2d\x3e\x73\x65\x71\x5f\x6e\x75\x6d\x3b\0\x09\x69\x66\x20\x28\x73\
+\x65\x71\x5f\x6e\x75\x6d\x20\x3d\x3d\x20\x30\x29\0\x09\x09\x42\x50\x46\x5f\x53\
+\x45\x51\x5f\x50\x52\x49\x4e\x54\x46\x28\x73\x65\x71\x2c\x20\x22\x20\x20\x69\
+\x64\x20\x6e\x61\x6d\x65\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\
+\x6d\x61\x78\x5f\x65\x6e\x74\x72\x69\x65\x73\x5c\x6e\x22\x29\x3b\0\x62\x70\x66\
+\x5f\x6d\x61\x70\0\x69\x64\0\x6e\x61\x6d\x65\0\x6d\x61\x78\x5f\x65\x6e\x74\x72\
+\x69\x65\x73\0\x5f\x5f\x75\x33\x32\0\x75\x6e\x73\x69\x67\x6e\x65\x64\x20\x69\
+\x6e\x74\0\x63\x68\x61\x72\0\x5f\x5f\x41\x52\x52\x41\x59\x5f\x53\x49\x5a\x45\
+\x5f\x54\x59\x50\x45\x5f\x5f\0\x09\x42\x50\x46\x5f\x53\x45\x51\x5f\x50\x52\x49\
+\x4e\x54\x46\x28\x73\x65\x71\x2c\x20\x22\x25\x34\x75\x20\x25\x2d\x31\x36\x73\
+\x25\x36\x64\x5c\x6e\x22\x2c\x20\x6d\x61\x70\x2d\x3e\x69\x64\x2c\x20\x6d\x61\
+\x70\x2d\x3e\x6e\x61\x6d\x65\x2c\x20\x6d\x61\x70\x2d\x3e\x6d\x61\x78\x5f\x65\
+\x6e\x74\x72\x69\x65\x73\x29\x3b\0\x7d\0\x62\x70\x66\x5f\x69\x74\x65\x72\x5f\
+\x5f\x62\x70\x66\x5f\x70\x72\x6f\x67\0\x70\x72\x6f\x67\0\x64\x75\x6d\x70\x5f\
+\x62\x70\x66\x5f\x70\x72\x6f\x67\0\x69\x74\x65\x72\x2f\x62\x70\x66\x5f\x70\x72\
+\x6f\x67\0\x09\x73\x74\x72\x75\x63\x74\x20\x62\x70\x66\x5f\x70\x72\x6f\x67\x20\
+\x2a\x70\x72\x6f\x67\x20\x3d\x20\x63\x74\x78\x2d\x3e\x70\x72\x6f\x67\x3b\0\x09\
+\x69\x66\x20\x28\x21\x70\x72\x6f\x67\x29\0\x62\x70\x66\x5f\x70\x72\x6f\x67\0\
+\x61\x75\x78\0\x09\x61\x75\x78\x20\x3d\x20\x70\x72\x6f\x67\x2d\x3e\x61\x75\x78\
+\x3b\0\x09\x09\x42\x50\x46\x5f\x53\x45\x51\x5f\x50\x52\x49\x4e\x54\x46\x28\x73\
+\x65\x71\x2c\x20\x22\x20\x20\x69\x64\x20\x6e\x61\x6d\x65\x20\x20\x20\x20\x20\
+\x20\x20\x20\x20\x20\x20\x20\x20\x61\x74\x74\x61\x63\x68\x65\x64\x5c\x6e\x22\
+\x29\x3b\0\x62\x70\x66\x5f\x70\x72\x6f\x67\x5f\x61\x75\x78\0\x61\x74\x74\x61\
+\x63\x68\x5f\x66\x75\x6e\x63\x5f\x6e\x61\x6d\x65\0\x64\x73\x74\x5f\x70\x72\x6f\
+\x67\0\x66\x75\x6e\x63\x5f\x69\x6e\x66\x6f\0\x62\x74\x66\0\x09\x42\x50\x46\x5f\
+\x53\x45\x51\x5f\x50\x52\x49\x4e\x54\x46\x28\x73\x65\x71\x2c\x20\x22\x25\x34\
+\x75\x20\x25\x2d\x31\x36\x73\x20\x25\x73\x20\x25\x73\x5c\x6e\x22\x2c\x20\x61\
+\x75\x78\x2d\x3e\x69\x64\x2c\0\x30\x3a\x34\0\x30\x3a\x35\0\x09\x69\x66\x20\x28\
+\x21\x62\x74\x66\x29\0\x62\x70\x66\x5f\x66\x75\x6e\x63\x5f\x69\x6e\x66\x6f\0\
+\x69\x6e\x73\x6e\x5f\x6f\x66\x66\0\x74\x79\x70\x65\x5f\x69\x64\0\x30\0\x73\x74\
+\x72\x69\x6e\x67\x73\0\x74\x79\x70\x65\x73\0\x68\x64\x72\0\x62\x74\x66\x5f\x68\
+\x65\x61\x64\x65\x72\0\x73\x74\x72\x5f\x6c\x65\x6e\0\x09\x74\x79\x70\x65\x73\
+\x20\x3d\x20\x62\x74\x66\x2d\x3e\x74\x79\x70\x65\x73\x3b\0\x09\x62\x70\x66\x5f\
+\x70\x72\x6f\x62\x65\x5f\x72\x65\x61\x64\x5f\x6b\x65\x72\x6e\x65\x6c\x28\x26\
+\x74\x2c\x20\x73\x69\x7a\x65\x6f\x66\x28\x74\x29\x2c\x20\x74\x79\x70\x65\x73\
+\x20\x2b\x20\x62\x74\x66\x5f\x69\x64\x29\x3b\0\x09\x73\x74\x72\x20\x3d\x20\x62\
+\x74\x66\x2d\x3e\x73\x74\x72\x69\x6e\x67\x73\x3b\0\x62\x74\x66\x5f\x74\x79\x70\
+\x65\0\x6e\x61\x6d\x65\x5f\x6f\x66\x66\0\x09\x6e\x61\x6d\x65\x5f\x6f\x66\x66\
+\x20\x3d\x20\x42\x50\x46\x5f\x43\x4f\x52\x45\x5f\x52\x45\x41\x44\x28\x74\x2c\
+\x20\x6e\x61\x6d\x65\x5f\x6f\x66\x66\x29\x3b\0\x30\x3a\x32\x3a\x30\0\x09\x69\
+\x66\x20\x28\x6e\x61\x6d\x65\x5f\x6f\x66\x66\x20\x3e\x3d\x20\x62\x74\x66\x2d\
+\x3e\x68\x64\x72\x2e\x73\x74\x72\x5f\x6c\x65\x6e\x29\0\x09\x72\x65\x74\x75\x72\
+\x6e\x20\x73\x74\x72\x20\x2b\x20\x6e\x61\x6d\x65\x5f\x6f\x66\x66\x3b\0\x30\x3a\
+\x33\0\x64\x75\x6d\x70\x5f\x62\x70\x66\x5f\x6d\x61\x70\x2e\x5f\x5f\x5f\x66\x6d\
+\x74\0\x64\x75\x6d\x70\x5f\x62\x70\x66\x5f\x6d\x61\x70\x2e\x5f\x5f\x5f\x66\x6d\
+\x74\x2e\x31\0\x64\x75\x6d\x70\x5f\x62\x70\x66\x5f\x70\x72\x6f\x67\x2e\x5f\x5f\
+\x5f\x66\x6d\x74\0\x64\x75\x6d\x70\x5f\x62\x70\x66\x5f\x70\x72\x6f\x67\x2e\x5f\
+\x5f\x5f\x66\x6d\x74\x2e\x32\0\x4c\x49\x43\x45\x4e\x53\x45\0\x2e\x72\x6f\x64\
+\x61\x74\x61\0\x6c\x69\x63\x65\x6e\x73\x65\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\x09\x4c\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x02\0\0\0\x04\0\0\0\x62\0\0\0\
+\x01\0\0\0\x80\0\0\0\0\0\0\0\0\x69\x74\x65\x72\x61\x74\x6f\x72\x2e\x72\x6f\x64\
+\x61\x74\x61\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x2f\0\0\0\0\0\0\0\0\0\0\0\0\x20\
+\x20\x69\x64\x20\x6e\x61\x6d\x65\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\
+\x20\x20\x6d\x61\x78\x5f\x65\x6e\x74\x72\x69\x65\x73\x0a\0\x25\x34\x75\x20\x25\
+\x2d\x31\x36\x73\x25\x36\x64\x0a\0\x20\x20\x69\x64\x20\x6e\x61\x6d\x65\x20\x20\
+\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x61\x74\x74\x61\x63\x68\x65\x64\
+\x0a\0\x25\x34\x75\x20\x25\x2d\x31\x36\x73\x20\x25\x73\x20\x25\x73\x0a\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\x47\x50\x4c\0\0\0\0\0\x79\x21\0\0\0\0\0\0\x79\x62\0\0\
+\0\0\0\0\x79\x71\0\x08\0\0\0\0\x15\x70\0\x1a\0\0\0\0\x79\x12\0\x10\0\0\0\0\x55\
+\x10\0\x08\0\0\0\0\xbf\x4a\0\0\0\0\0\0\x07\x40\0\0\xff\xff\xff\xe8\xbf\x16\0\0\
+\0\0\0\0\x18\x26\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xb7\x30\0\0\0\0\0\x23\xb7\x50\0\0\
+\0\0\0\0\x85\0\0\0\0\0\0\x7e\x61\x17\0\0\0\0\0\0\x7b\xa1\xff\xe8\0\0\0\0\xb7\
+\x10\0\0\0\0\0\x04\xbf\x27\0\0\0\0\0\0\x0f\x21\0\0\0\0\0\0\x7b\xa2\xff\xf0\0\0\
+\0\0\x61\x17\0\x14\0\0\0\0\x7b\xa1\xff\xf8\0\0\0\0\xbf\x4a\0\0\0\0\0\0\x07\x40\
+\0\0\xff\xff\xff\xe8\xbf\x16\0\0\0\0\0\0\x18\x26\0\0\0\0\0\0\0\0\0\0\0\0\0\x23\
+\xb7\x30\0\0\0\0\0\x0e\xb7\x50\0\0\0\0\0\x18\x85\0\0\0\0\0\0\x7e\xb7\0\0\0\0\0\
+\0\0\x95\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x07\0\0\0\0\0\0\0\x42\0\0\0\x9a\0\x01\x3c\
+\x1e\0\0\0\x01\0\0\0\x42\0\0\0\x9a\0\x01\x3c\x24\0\0\0\x02\0\0\0\x42\0\0\x01\
+\x0d\0\x01\x44\x1d\0\0\0\x03\0\0\0\x42\0\0\x01\x2e\0\x01\x4c\x06\0\0\0\x04\0\0\
+\0\x42\0\0\x01\x3d\0\x01\x40\x1d\0\0\0\x05\0\0\0\x42\0\0\x01\x62\0\x01\x58\x06\
+\0\0\0\x07\0\0\0\x42\0\0\x01\x75\0\x01\x5c\x03\0\0\0\x0e\0\0\0\x42\0\0\x01\xfb\
+\0\x01\x64\x02\0\0\0\x1e\0\0\0\x42\0\0\x02\x49\0\x01\x6c\x01\0\0\0\0\0\0\0\x02\
+\0\0\0\x3e\0\0\0\0\0\0\0\x08\0\0\0\x08\0\0\0\x3e\0\0\0\0\0\0\0\x10\0\0\0\x02\0\
+\0\x01\x09\0\0\0\0\0\0\0\x20\0\0\0\x08\0\0\x01\x39\0\0\0\0\0\0\0\x70\0\0\0\x0d\
+\0\0\0\x3e\0\0\0\0\0\0\0\x80\0\0\0\x0d\0\0\x01\x09\0\0\0\0\0\0\0\xa0\0\0\0\x0d\
+\0\0\x01\x39\0\0\0\0\0\0\0\x1a\0\0\0\x20\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x64\x75\x6d\x70\x5f\x62\x70\x66\x5f\
+\x6d\x61\x70\0\0\0\0\0\0\0\0\0\0\0\x1c\0\0\0\0\0\0\0\x08\0\0\0\0\0\0\0\0\0\0\0\
+\x01\0\0\0\x10\0\0\0\0\0\0\0\0\0\0\0\x09\0\0\0\x01\0\0\0\0\0\0\0\x07\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\0\x62\x70\x66\x5f\x69\x74\x65\x72\x5f\
+\x62\x70\x66\x5f\x6d\x61\x70\0\0\0\0\0\0\0\0\x47\x50\x4c\0\0\0\0\0\x79\x21\0\0\
+\0\0\0\0\x79\x62\0\0\0\0\0\0\x79\x11\0\x08\0\0\0\0\x15\x10\0\x3b\0\0\0\0\x79\
+\x71\0\0\0\0\0\0\x79\x12\0\x10\0\0\0\0\x55\x10\0\x08\0\0\0\0\xbf\x4a\0\0\0\0\0\
+\0\x07\x40\0\0\xff\xff\xff\xd0\xbf\x16\0\0\0\0\0\0\x18\x26\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\x31\xb7\x30\0\0\0\0\0\x20\xb7\x50\0\0\0\0\0\0\x85\0\0\0\0\0\0\x7e\x7b\
+\xa6\xff\xc8\0\0\0\0\x61\x17\0\0\0\0\0\0\x7b\xa1\xff\xd0\0\0\0\0\xb7\x30\0\0\0\
+\0\0\x04\xbf\x97\0\0\0\0\0\0\x0f\x93\0\0\0\0\0\0\x79\x17\0\x28\0\0\0\0\x79\x87\
+\0\x30\0\0\0\0\x15\x80\0\x18\0\0\0\0\xb7\x20\0\0\0\0\0\0\x0f\x12\0\0\0\0\0\0\
+\x61\x11\0\x04\0\0\0\0\x79\x38\0\x08\0\0\0\0\x67\x10\0\0\0\0\0\x03\x0f\x31\0\0\
+\0\0\0\0\x79\x68\0\0\0\0\0\0\xbf\x1a\0\0\0\0\0\0\x07\x10\0\0\xff\xff\xff\xf8\
+\xb7\x20\0\0\0\0\0\x08\x85\0\0\0\0\0\0\x71\xb7\x10\0\0\0\0\0\0\x79\x3a\xff\xf8\
+\0\0\0\0\x0f\x31\0\0\0\0\0\0\xbf\x1a\0\0\0\0\0\0\x07\x10\0\0\xff\xff\xff\xf4\
+\xb7\x20\0\0\0\0\0\x04\x85\0\0\0\0\0\0\x71\xb7\x30\0\0\0\0\0\x04\x61\x1a\xff\
+\xf4\0\0\0\0\x61\x28\0\x10\0\0\0\0\x3d\x12\0\x02\0\0\0\0\x0f\x61\0\0\0\0\0\0\
+\xbf\x96\0\0\0\0\0\0\x7b\xa9\xff\xd8\0\0\0\0\x79\x17\0\x18\0\0\0\0\x7b\xa1\xff\
+\xe0\0\0\0\0\x79\x17\0\x20\0\0\0\0\x79\x11\0\0\0\0\0\0\x0f\x13\0\0\0\0\0\0\x7b\
+\xa1\xff\xe8\0\0\0\0\xbf\x4a\0\0\0\0\0\0\x07\x40\0\0\xff\xff\xff\xd0\x79\x1a\
+\xff\xc8\0\0\0\0\x18\x26\0\0\0\0\0\0\0\0\0\0\0\0\0\x51\xb7\x30\0\0\0\0\0\x11\
+\xb7\x50\0\0\0\0\0\x20\x85\0\0\0\0\0\0\x7e\xb7\0\0\0\0\0\0\0\x95\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\x17\0\0\0\0\0\0\0\x42\0\0\0\x9a\0\x01\x80\x1e\0\0\0\x01\0\0\0\
+\x42\0\0\0\x9a\0\x01\x80\x24\0\0\0\x02\0\0\0\x42\0\0\x02\x7f\0\x01\x88\x1f\0\0\
+\0\x03\0\0\0\x42\0\0\x02\xa3\0\x01\x94\x06\0\0\0\x04\0\0\0\x42\0\0\x02\xbc\0\
+\x01\xa0\x0e\0\0\0\x05\0\0\0\x42\0\0\x01\x3d\0\x01\x84\x1d\0\0\0\x06\0\0\0\x42\
+\0\0\x01\x62\0\x01\xa4\x06\0\0\0\x08\0\0\0\x42\0\0\x02\xce\0\x01\xa8\x03\0\0\0\
+\x10\0\0\0\x42\0\0\x03\x3e\0\x01\xb0\x02\0\0\0\x17\0\0\0\x42\0\0\x03\x79\0\x01\
+\x04\x06\0\0\0\x1a\0\0\0\x42\0\0\x03\x3e\0\x01\xb0\x02\0\0\0\x1b\0\0\0\x42\0\0\
+\x03\xca\0\x01\x10\x0f\0\0\0\x1c\0\0\0\x42\0\0\x03\xdf\0\x01\x14\x2d\0\0\0\x1e\
+\0\0\0\x42\0\0\x04\x16\0\x01\x0c\x0d\0\0\0\x20\0\0\0\x42\0\0\x03\x3e\0\x01\xb0\
+\x02\0\0\0\x21\0\0\0\x42\0\0\x03\xdf\0\x01\x14\x02\0\0\0\x24\0\0\0\x42\0\0\x04\
+\x3d\0\x01\x18\x0d\0\0\0\x27\0\0\0\x42\0\0\x03\x3e\0\x01\xb0\x02\0\0\0\x28\0\0\
+\0\x42\0\0\x04\x3d\0\x01\x18\x0d\0\0\0\x2b\0\0\0\x42\0\0\x04\x3d\0\x01\x18\x0d\
+\0\0\0\x2c\0\0\0\x42\0\0\x04\x6b\0\x01\x1c\x1b\0\0\0\x2d\0\0\0\x42\0\0\x04\x6b\
+\0\x01\x1c\x06\0\0\0\x2e\0\0\0\x42\0\0\x04\x8e\0\x01\x24\x0d\0\0\0\x30\0\0\0\
+\x42\0\0\x03\x3e\0\x01\xb0\x02\0\0\0\x3f\0\0\0\x42\0\0\x02\x49\0\x01\xc0\x01\0\
+\0\0\0\0\0\0\x14\0\0\0\x3e\0\0\0\0\0\0\0\x08\0\0\0\x08\0\0\0\x3e\0\0\0\0\0\0\0\
+\x10\0\0\0\x14\0\0\x01\x09\0\0\0\0\0\0\0\x20\0\0\0\x18\0\0\0\x3e\0\0\0\0\0\0\0\
+\x28\0\0\0\x08\0\0\x01\x39\0\0\0\0\0\0\0\x80\0\0\0\x1a\0\0\0\x3e\0\0\0\0\0\0\0\
+\x90\0\0\0\x1a\0\0\x01\x09\0\0\0\0\0\0\0\xa8\0\0\0\x1a\0\0\x03\x71\0\0\0\0\0\0\
+\0\xb0\0\0\0\x1a\0\0\x03\x75\0\0\0\0\0\0\0\xc0\0\0\0\x1f\0\0\x03\xa3\0\0\0\0\0\
+\0\0\xd8\0\0\0\x20\0\0\x01\x09\0\0\0\0\0\0\0\xf0\0\0\0\x20\0\0\0\x3e\0\0\0\0\0\
+\0\x01\x18\0\0\0\x24\0\0\0\x3e\0\0\0\0\0\0\x01\x50\0\0\0\x1a\0\0\x01\x09\0\0\0\
+\0\0\0\x01\x60\0\0\0\x20\0\0\x04\x65\0\0\0\0\0\0\x01\x88\0\0\0\x1a\0\0\x01\x39\
+\0\0\0\0\0\0\x01\x98\0\0\0\x1a\0\0\x04\xa6\0\0\0\0\0\0\x01\xa0\0\0\0\x18\0\0\0\
+\x3e\0\0\0\0\0\0\0\x1a\0\0\0\x41\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x64\x75\x6d\x70\x5f\x62\x70\x66\x5f\x70\x72\
+\x6f\x67\0\0\0\0\0\0\0\0\0\0\x1c\0\0\0\0\0\0\0\x08\0\0\0\0\0\0\0\0\0\0\0\x01\0\
+\0\0\x10\0\0\0\0\0\0\0\0\0\0\0\x19\0\0\0\x01\0\0\0\0\0\0\0\x12\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\0\x62\x70\x66\x5f\x69\x74\x65\x72\x5f\x62\x70\
+\x66\x5f\x70\x72\x6f\x67\0\0\0\0\0\0\0";
+	opts.insns_sz = 2216;
+	opts.insns = (void *)"\
+\xbf\x61\0\0\0\0\0\0\xbf\x1a\0\0\0\0\0\0\x07\x10\0\0\xff\xff\xff\x78\xb7\x20\0\
+\0\0\0\0\x88\xb7\x30\0\0\0\0\0\0\x85\0\0\0\0\0\0\x71\x05\0\0\x14\0\0\0\0\x61\
+\x1a\xff\x78\0\0\0\0\xd5\x10\0\x01\0\0\0\0\x85\0\0\0\0\0\0\xa8\x61\x1a\xff\x7c\
+\0\0\0\0\xd5\x10\0\x01\0\0\0\0\x85\0\0\0\0\0\0\xa8\x61\x1a\xff\x80\0\0\0\0\xd5\
+\x10\0\x01\0\0\0\0\x85\0\0\0\0\0\0\xa8\x61\x1a\xff\x84\0\0\0\0\xd5\x10\0\x01\0\
+\0\0\0\x85\0\0\0\0\0\0\xa8\x18\x06\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x61\x10\0\0\0\0\
+\0\0\xd5\x10\0\x02\0\0\0\0\xbf\x91\0\0\0\0\0\0\x85\0\0\0\0\0\0\xa8\xbf\x07\0\0\
+\0\0\0\0\x95\0\0\0\0\0\0\0\x61\x06\0\x08\0\0\0\0\x18\x16\0\0\0\0\0\0\0\0\0\0\0\
+\0\x0e\x68\x63\x10\0\0\0\0\0\0\x61\x06\0\x0c\0\0\0\0\x18\x16\0\0\0\0\0\0\0\0\0\
+\0\0\0\x0e\x64\x63\x10\0\0\0\0\0\0\x79\x06\0\x10\0\0\0\0\x18\x16\0\0\0\0\0\0\0\
+\0\0\0\0\0\x0e\x58\x7b\x10\0\0\0\0\0\0\x18\x06\0\0\0\0\0\0\0\0\0\0\0\0\x05\0\
+\x18\x16\0\0\0\0\0\0\0\0\0\0\0\0\x0e\x50\x7b\x10\0\0\0\0\0\0\xb7\x10\0\0\0\0\0\
+\x12\x18\x26\0\0\0\0\0\0\0\0\0\0\0\0\x0e\x50\xb7\x30\0\0\0\0\0\x1c\x85\0\0\0\0\
+\0\0\xa6\xbf\x70\0\0\0\0\0\0\xc5\x70\xff\xd4\0\0\0\0\x63\xa7\xff\x78\0\0\0\0\
+\x61\x0a\xff\x78\0\0\0\0\x18\x16\0\0\0\0\0\0\0\0\0\0\0\0\x0e\xa0\x63\x10\0\0\0\
+\0\0\0\x61\x06\0\x1c\0\0\0\0\x15\0\0\x03\0\0\0\0\x18\x16\0\0\0\0\0\0\0\0\0\0\0\
+\0\x0e\x7c\x63\x10\0\0\0\0\0\0\xb7\x10\0\0\0\0\0\0\x18\x26\0\0\0\0\0\0\0\0\0\0\
+\0\0\x0e\x70\xb7\x30\0\0\0\0\0\x48\x85\0\0\0\0\0\0\xa6\xbf\x70\0\0\0\0\0\0\xc5\
+\x70\xff\xc3\0\0\0\0\x18\x16\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x63\x17\0\0\0\0\0\0\
+\x79\x36\0\x20\0\0\0\0\x15\x30\0\x08\0\0\0\0\x18\x16\0\0\0\0\0\0\0\0\0\0\0\0\
+\x0e\xb8\xb7\x20\0\0\0\0\0\x62\x61\x06\0\x04\0\0\0\0\x45\0\0\x02\0\0\0\x01\x85\
+\0\0\0\0\0\0\x94\x05\0\0\x01\0\0\0\0\x85\0\0\0\0\0\0\x71\x18\x26\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\x61\x02\0\0\0\0\0\0\x18\x16\0\0\0\0\0\0\0\0\0\0\0\0\x0f\x28\x63\
+\x10\0\0\0\0\0\0\x18\x06\0\0\0\0\0\0\0\0\0\0\0\0\x0f\x20\x18\x16\0\0\0\0\0\0\0\
+\0\0\0\0\0\x0f\x30\x7b\x10\0\0\0\0\0\0\x18\x06\0\0\0\0\0\0\0\0\0\0\0\0\x0e\xb8\
+\x18\x16\0\0\0\0\0\0\0\0\0\0\0\0\x0f\x38\x7b\x10\0\0\0\0\0\0\xb7\x10\0\0\0\0\0\
+\x02\x18\x26\0\0\0\0\0\0\0\0\0\0\0\0\x0f\x28\xb7\x30\0\0\0\0\0\x20\x85\0\0\0\0\
+\0\0\xa6\xbf\x70\0\0\0\0\0\0\xc5\x70\xff\x9f\0\0\0\0\x18\x26\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\x61\x02\0\0\0\0\0\0\x18\x16\0\0\0\0\0\0\0\0\0\0\0\0\x0f\x48\x63\x10\
+\0\0\0\0\0\0\xb7\x10\0\0\0\0\0\x16\x18\x26\0\0\0\0\0\0\0\0\0\0\0\0\x0f\x48\xb7\
+\x30\0\0\0\0\0\x04\x85\0\0\0\0\0\0\xa6\xbf\x70\0\0\0\0\0\0\xc5\x70\xff\x92\0\0\
+\0\0\x18\x06\0\0\0\0\0\0\0\0\0\0\0\0\x0f\x50\x18\x16\0\0\0\0\0\0\0\0\0\0\0\0\
+\x11\x70\x7b\x10\0\0\0\0\0\0\x18\x06\0\0\0\0\0\0\0\0\0\0\0\0\x0f\x58\x18\x16\0\
+\0\0\0\0\0\0\0\0\0\0\0\x11\x68\x7b\x10\0\0\0\0\0\0\x18\x06\0\0\0\0\0\0\0\0\0\0\
+\0\0\x10\x58\x18\x16\0\0\0\0\0\0\0\0\0\0\0\0\x11\xb0\x7b\x10\0\0\0\0\0\0\x18\
+\x06\0\0\0\0\0\0\0\0\0\0\0\0\x10\x60\x18\x16\0\0\0\0\0\0\0\0\0\0\0\0\x11\xc0\
+\x7b\x10\0\0\0\0\0\0\x18\x06\0\0\0\0\0\0\0\0\0\0\0\0\x10\xf0\x18\x16\0\0\0\0\0\
+\0\0\0\0\0\0\0\x11\xe0\x7b\x10\0\0\0\0\0\0\x18\x06\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\x18\x16\0\0\0\0\0\0\0\0\0\0\0\0\x11\xd8\x7b\x10\0\0\0\0\0\0\x61\x06\0\x08\0\0\
+\0\0\x18\x16\0\0\0\0\0\0\0\0\0\0\0\0\x11\x78\x63\x10\0\0\0\0\0\0\x61\x06\0\x0c\
+\0\0\0\0\x18\x16\0\0\0\0\0\0\0\0\0\0\0\0\x11\x7c\x63\x10\0\0\0\0\0\0\x79\x06\0\
+\x10\0\0\0\0\x18\x16\0\0\0\0\0\0\0\0\0\0\0\0\x11\x80\x7b\x10\0\0\0\0\0\0\x61\
+\x0a\xff\x78\0\0\0\0\x18\x16\0\0\0\0\0\0\0\0\0\0\0\0\x11\xa8\x63\x10\0\0\0\0\0\
+\0\x18\x16\0\0\0\0\0\0\0\0\0\0\0\0\x11\xf0\xb7\x20\0\0\0\0\0\x11\xb7\x30\0\0\0\
+\0\0\x0c\xb7\x40\0\0\0\0\0\0\x85\0\0\0\0\0\0\xa7\xbf\x70\0\0\0\0\0\0\xc5\x70\
+\xff\x5c\0\0\0\0\x18\x06\0\0\0\0\0\0\0\0\0\0\0\0\x11\x60\x63\x07\0\x6c\0\0\0\0\
+\x77\x70\0\0\0\0\0\x20\x63\x07\0\x70\0\0\0\0\xb7\x10\0\0\0\0\0\x05\x18\x26\0\0\
+\0\0\0\0\0\0\0\0\0\0\x11\x60\xb7\x30\0\0\0\0\0\x8c\x85\0\0\0\0\0\0\xa6\xbf\x70\
+\0\0\0\0\0\0\x18\x06\0\0\0\0\0\0\0\0\0\0\0\0\x11\xd0\x61\x10\0\0\0\0\0\0\xd5\
+\x10\0\x02\0\0\0\0\xbf\x91\0\0\0\0\0\0\x85\0\0\0\0\0\0\xa8\xc5\x70\xff\x4a\0\0\
+\0\0\x63\xa7\xff\x80\0\0\0\0\x18\x06\0\0\0\0\0\0\0\0\0\0\0\0\x12\x08\x18\x16\0\
+\0\0\0\0\0\0\0\0\0\0\0\x16\xe0\x7b\x10\0\0\0\0\0\0\x18\x06\0\0\0\0\0\0\0\0\0\0\
+\0\0\x12\x10\x18\x16\0\0\0\0\0\0\0\0\0\0\0\0\x16\xd8\x7b\x10\0\0\0\0\0\0\x18\
+\x06\0\0\0\0\0\0\0\0\0\0\0\0\x14\x18\x18\x16\0\0\0\0\0\0\0\0\0\0\0\0\x17\x20\
+\x7b\x10\0\0\0\0\0\0\x18\x06\0\0\0\0\0\0\0\0\0\0\0\0\x14\x20\x18\x16\0\0\0\0\0\
+\0\0\0\0\0\0\0\x17\x30\x7b\x10\0\0\0\0\0\0\x18\x06\0\0\0\0\0\0\0\0\0\0\0\0\x15\
+\xb0\x18\x16\0\0\0\0\0\0\0\0\0\0\0\0\x17\x50\x7b\x10\0\0\0\0\0\0\x18\x06\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\x18\x16\0\0\0\0\0\0\0\0\0\0\0\0\x17\x48\x7b\x10\0\0\0\0\
+\0\0\x61\x06\0\x08\0\0\0\0\x18\x16\0\0\0\0\0\0\0\0\0\0\0\0\x16\xe8\x63\x10\0\0\
+\0\0\0\0\x61\x06\0\x0c\0\0\0\0\x18\x16\0\0\0\0\0\0\0\0\0\0\0\0\x16\xec\x63\x10\
+\0\0\0\0\0\0\x79\x06\0\x10\0\0\0\0\x18\x16\0\0\0\0\0\0\0\0\0\0\0\0\x16\xf0\x7b\
+\x10\0\0\0\0\0\0\x61\x0a\xff\x78\0\0\0\0\x18\x16\0\0\0\0\0\0\0\0\0\0\0\0\x17\
+\x18\x63\x10\0\0\0\0\0\0\x18\x16\0\0\0\0\0\0\0\0\0\0\0\0\x17\x60\xb7\x20\0\0\0\
+\0\0\x12\xb7\x30\0\0\0\0\0\x0c\xb7\x40\0\0\0\0\0\0\x85\0\0\0\0\0\0\xa7\xbf\x70\
+\0\0\0\0\0\0\xc5\x70\xff\x13\0\0\0\0\x18\x06\0\0\0\0\0\0\0\0\0\0\0\0\x16\xd0\
+\x63\x07\0\x6c\0\0\0\0\x77\x70\0\0\0\0\0\x20\x63\x07\0\x70\0\0\0\0\xb7\x10\0\0\
+\0\0\0\x05\x18\x26\0\0\0\0\0\0\0\0\0\0\0\0\x16\xd0\xb7\x30\0\0\0\0\0\x8c\x85\0\
+\0\0\0\0\0\xa6\xbf\x70\0\0\0\0\0\0\x18\x06\0\0\0\0\0\0\0\0\0\0\0\0\x17\x40\x61\
+\x10\0\0\0\0\0\0\xd5\x10\0\x02\0\0\0\0\xbf\x91\0\0\0\0\0\0\x85\0\0\0\0\0\0\xa8\
+\xc5\x70\xff\x01\0\0\0\0\x63\xa7\xff\x84\0\0\0\0\x61\x1a\xff\x78\0\0\0\0\xd5\
+\x10\0\x02\0\0\0\0\xbf\x91\0\0\0\0\0\0\x85\0\0\0\0\0\0\xa8\x61\x0a\xff\x80\0\0\
+\0\0\x63\x60\0\x28\0\0\0\0\x61\x0a\xff\x84\0\0\0\0\x63\x60\0\x2c\0\0\0\0\x18\
+\x16\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x61\x01\0\0\0\0\0\0\x63\x60\0\x18\0\0\0\0\xb7\
+\0\0\0\0\0\0\0\x95\0\0\0\0\0\0\0";
+	err = bpf_load_and_run(&opts);
+	if (err < 0)
+		return err;
+	return 0;
+}
+
+static inline struct iterators_bpf *
+iterators_bpf__open_and_load(void)
+{
+	struct iterators_bpf *skel;
+
+	skel = iterators_bpf__open();
+	if (!skel)
+		return NULL;
+	if (iterators_bpf__load(skel)) {
+		iterators_bpf__destroy(skel);
+		return NULL;
+	}
+	return skel;
+}
+
+__attribute__((unused)) static void
+iterators_bpf__assert(struct iterators_bpf *s __attribute__((unused)))
+{
+#ifdef __cplusplus
+#define _Static_assert static_assert
+#endif
+#ifdef __cplusplus
+#undef _Static_assert
+#endif
+}
+
+#endif /* __ITERATORS_BPF_SKEL_H__ */
diff --git a/kernel/bpf/preload/iterators/iterators.lskel.h b/kernel/bpf/preload/iterators/iterators.lskel-little-endian.h
similarity index 100%
rename from kernel/bpf/preload/iterators/iterators.lskel.h
rename to kernel/bpf/preload/iterators/iterators.lskel-little-endian.h
-- 
2.39.1

