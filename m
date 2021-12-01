Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1E74659D9
	for <lists+bpf@lfdr.de>; Thu,  2 Dec 2021 00:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344113AbhLAXcY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 1 Dec 2021 18:32:24 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41976 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353780AbhLAXcV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 1 Dec 2021 18:32:21 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1LdEhm005768
        for <bpf@vger.kernel.org>; Wed, 1 Dec 2021 15:28:59 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cp6tm5njv-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 15:28:59 -0800
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 15:28:41 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 48F9CB7A0B09; Wed,  1 Dec 2021 15:28:39 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 7/9] samples/bpf: clean up samples/bpf build failes
Date:   Wed, 1 Dec 2021 15:28:22 -0800
Message-ID: <20211201232824.3166325-8-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211201232824.3166325-1-andrii@kernel.org>
References: <20211201232824.3166325-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: X2NmGpsc4dLnAmjltvfhS9sHxpSJSgsZ
X-Proofpoint-GUID: X2NmGpsc4dLnAmjltvfhS9sHxpSJSgsZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-12-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 spamscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove xdp_samples_user.o rule redefinition which generates Makefile
warning and instead override TPROGS_CFLAGS. This seems to work fine when
building inside selftests/bpf.

That was one big head-scratcher before I found that generic
Makefile.target hid this surprising specialization for for xdp_samples_user.o.

Main change is to use actual locally installed libbpf headers.

Also drop printk macro re-definition (not even used!).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 samples/bpf/Makefile            | 13 ++++++++++++-
 samples/bpf/Makefile.target     | 11 -----------
 samples/bpf/hbm_kern.h          |  2 --
 samples/bpf/lwt_len_hist_kern.c |  7 -------
 4 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index a886dff1ba89..6ae62b1dc938 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -328,7 +328,7 @@ $(BPF_SAMPLES_PATH)/*.c: verify_target_bpf $(LIBBPF)
 $(src)/*.c: verify_target_bpf $(LIBBPF)
 
 libbpf_hdrs: $(LIBBPF)
-$(obj)/$(TRACE_HELPERS): | libbpf_hdrs
+$(obj)/$(TRACE_HELPERS) $(obj)/$(CGROUP_HELPERS) $(obj)/$(XDP_SAMPLE): | libbpf_hdrs
 
 .PHONY: libbpf_hdrs
 
@@ -343,6 +343,17 @@ $(obj)/hbm_out_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
 $(obj)/hbm.o: $(src)/hbm.h
 $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
 
+# Override includes for xdp_sample_user.o because $(srctree)/usr/include in
+# TPROGS_CFLAGS causes conflicts
+XDP_SAMPLE_CFLAGS += -Wall -O2 -lm \
+		     -I$(src)/../../tools/include \
+		     -I$(src)/../../tools/include/uapi \
+		     -I$(LIBBPF_INCLUDE) \
+		     -I$(src)/../../tools/testing/selftests/bpf
+
+$(obj)/$(XDP_SAMPLE): TPROGS_CFLAGS = $(XDP_SAMPLE_CFLAGS)
+$(obj)/$(XDP_SAMPLE): $(src)/xdp_sample_user.h $(src)/xdp_sample_shared.h
+
 -include $(BPF_SAMPLES_PATH)/Makefile.target
 
 VMLINUX_BTF_PATHS ?= $(abspath $(if $(O),$(O)/vmlinux))				\
diff --git a/samples/bpf/Makefile.target b/samples/bpf/Makefile.target
index 5a368affa038..7621f55e2947 100644
--- a/samples/bpf/Makefile.target
+++ b/samples/bpf/Makefile.target
@@ -73,14 +73,3 @@ quiet_cmd_tprog-cobjs	= CC  $@
       cmd_tprog-cobjs	= $(CC) $(tprogc_flags) -c -o $@ $<
 $(tprog-cobjs): $(obj)/%.o: $(src)/%.c FORCE
 	$(call if_changed_dep,tprog-cobjs)
-
-# Override includes for xdp_sample_user.o because $(srctree)/usr/include in
-# TPROGS_CFLAGS causes conflicts
-XDP_SAMPLE_CFLAGS += -Wall -O2 -lm \
-		     -I./tools/include \
-		     -I./tools/include/uapi \
-		     -I./tools/lib \
-		     -I./tools/testing/selftests/bpf
-$(obj)/xdp_sample_user.o: $(src)/xdp_sample_user.c \
-	$(src)/xdp_sample_user.h $(src)/xdp_sample_shared.h
-	$(CC) $(XDP_SAMPLE_CFLAGS) -c -o $@ $<
diff --git a/samples/bpf/hbm_kern.h b/samples/bpf/hbm_kern.h
index 722b3fadb467..1752a46a2b05 100644
--- a/samples/bpf/hbm_kern.h
+++ b/samples/bpf/hbm_kern.h
@@ -9,8 +9,6 @@
  * Include file for sample Host Bandwidth Manager (HBM) BPF programs
  */
 #define KBUILD_MODNAME "foo"
-#include <stddef.h>
-#include <stdbool.h>
 #include <uapi/linux/bpf.h>
 #include <uapi/linux/if_ether.h>
 #include <uapi/linux/if_packet.h>
diff --git a/samples/bpf/lwt_len_hist_kern.c b/samples/bpf/lwt_len_hist_kern.c
index 9ed63e10e170..1fa14c54963a 100644
--- a/samples/bpf/lwt_len_hist_kern.c
+++ b/samples/bpf/lwt_len_hist_kern.c
@@ -16,13 +16,6 @@
 #include <uapi/linux/in.h>
 #include <bpf/bpf_helpers.h>
 
-# define printk(fmt, ...)						\
-		({							\
-			char ____fmt[] = fmt;				\
-			bpf_trace_printk(____fmt, sizeof(____fmt),	\
-				     ##__VA_ARGS__);			\
-		})
-
 struct bpf_elf_map {
 	__u32 type;
 	__u32 size_key;
-- 
2.30.2

