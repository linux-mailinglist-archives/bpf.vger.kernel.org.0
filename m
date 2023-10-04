Return-Path: <bpf+bounces-11336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 428C77B75C2
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 02:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 8C7FEB20979
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 00:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EC47FA;
	Wed,  4 Oct 2023 00:21:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F15336F
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 00:21:18 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CED8A7
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 17:21:14 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393KUvMb011040
	for <bpf@vger.kernel.org>; Tue, 3 Oct 2023 17:21:13 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tg728ragy-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 17:21:13 -0700
Received: from twshared22837.17.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 3 Oct 2023 17:21:12 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 1DA0039214E01; Tue,  3 Oct 2023 17:17:57 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 2/3] selftests/bpf: support building selftests in optimized -O2 mode
Date: Tue, 3 Oct 2023 17:17:49 -0700
Message-ID: <20231004001750.2939898-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004001750.2939898-1-andrii@kernel.org>
References: <20231004001750.2939898-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: JpiLjRLKgcJ0Ffp5GmGb05Z7dRkRo1hJ
X-Proofpoint-GUID: JpiLjRLKgcJ0Ffp5GmGb05Z7dRkRo1hJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_19,2023-10-02_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support for building selftests with -O2 level of optimization, which
allows more compiler warnings detection (like lots of potentially
uninitialized usage), but also is useful to have a faster-running test
for some CPU-intensive tests.

One can build optimized versions of libbpf and selftests by running:

  $ make RELEASE=3D1

There is a measurable speed up of about 10 seconds for me locally,
though it's mostly capped by non-parallelized serial tests. User CPU
time goes down by total 40 seconds, from 1m10s to 0m28s.

Unoptimized build (-O0)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary: 430/3544 PASSED, 25 SKIPPED, 4 FAILED

real    1m59.937s
user    1m10.877s
sys     3m14.880s

Optimized build (-O2)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary: 425/3543 PASSED, 25 SKIPPED, 9 FAILED

real    1m50.540s
user    0m28.406s
sys     3m13.198s

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/Makefile | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
index a25e262dbc69..55d1b1848e6c 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -27,7 +27,9 @@ endif
 BPF_GCC		?=3D $(shell command -v bpf-gcc;)
 SAN_CFLAGS	?=3D
 SAN_LDFLAGS	?=3D $(SAN_CFLAGS)
-CFLAGS +=3D -g -O0 -rdynamic						\
+RELEASE		?=3D
+OPT_FLAGS	?=3D $(if $(RELEASE),-O2,-O0)
+CFLAGS +=3D -g $(OPT_FLAGS) -rdynamic					\
 	  -Wall -Werror 						\
 	  $(GENFLAGS) $(SAN_CFLAGS)					\
 	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
@@ -241,7 +243,7 @@ $(OUTPUT)/runqslower: $(BPFOBJ) | $(DEFAULT_BPFTOOL) =
$(RUNQSLOWER_OUTPUT)
 		    BPFTOOL_OUTPUT=3D$(HOST_BUILD_DIR)/bpftool/		       \
 		    BPFOBJ_OUTPUT=3D$(BUILD_DIR)/libbpf			       \
 		    BPFOBJ=3D$(BPFOBJ) BPF_INCLUDE=3D$(INCLUDE_DIR)		       \
-		    EXTRA_CFLAGS=3D'-g -O0 $(SAN_CFLAGS)'			       \
+		    EXTRA_CFLAGS=3D'-g $(OPT_FLAGS) $(SAN_CFLAGS)'	       \
 		    EXTRA_LDFLAGS=3D'$(SAN_LDFLAGS)' &&			       \
 		    cp $(RUNQSLOWER_OUTPUT)runqslower $@
=20
@@ -279,7 +281,7 @@ $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $=
(BPFTOOLDIR)/Makefile)    \
 		    $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
 	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)			       \
 		    ARCH=3D CROSS_COMPILE=3D CC=3D"$(HOSTCC)" LD=3D"$(HOSTLD)" 	      =
 \
-		    EXTRA_CFLAGS=3D'-g -O0'				       \
+		    EXTRA_CFLAGS=3D'-g $(OPT_FLAGS)'			       \
 		    OUTPUT=3D$(HOST_BUILD_DIR)/bpftool/			       \
 		    LIBBPF_OUTPUT=3D$(HOST_BUILD_DIR)/libbpf/		       \
 		    LIBBPF_DESTDIR=3D$(HOST_SCRATCH_DIR)/			       \
@@ -290,7 +292,7 @@ $(CROSS_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(B=
PFTOOLDIR)/Makefile)	\
 		    $(BPFOBJ) | $(BUILD_DIR)/bpftool
 	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)				\
 		    ARCH=3D$(ARCH) CROSS_COMPILE=3D$(CROSS_COMPILE)			\
-		    EXTRA_CFLAGS=3D'-g -O0'					\
+		    EXTRA_CFLAGS=3D'-g $(OPT_FLAGS)'				\
 		    OUTPUT=3D$(BUILD_DIR)/bpftool/				\
 		    LIBBPF_OUTPUT=3D$(BUILD_DIR)/libbpf/				\
 		    LIBBPF_DESTDIR=3D$(SCRATCH_DIR)/				\
@@ -313,7 +315,7 @@ $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Make=
file)		       \
 	   $(APIDIR)/linux/bpf.h					       \
 	   | $(BUILD_DIR)/libbpf
 	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=3D$(BUILD_DIR)/libbpf=
/ \
-		    EXTRA_CFLAGS=3D'-g -O0 $(SAN_CFLAGS)'			       \
+		    EXTRA_CFLAGS=3D'-g $(OPT_FLAGS) $(SAN_CFLAGS)'	       \
 		    EXTRA_LDFLAGS=3D'$(SAN_LDFLAGS)'			       \
 		    DESTDIR=3D$(SCRATCH_DIR) prefix=3D all install_headers
=20
@@ -322,7 +324,7 @@ $(HOST_BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)=
/Makefile)		       \
 		$(APIDIR)/linux/bpf.h					       \
 		| $(HOST_BUILD_DIR)/libbpf
 	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR)                             =
\
-		    EXTRA_CFLAGS=3D'-g -O0' ARCH=3D CROSS_COMPILE=3D		       \
+		    EXTRA_CFLAGS=3D'-g $(OPT_FLAGS)' ARCH=3D CROSS_COMPILE=3D	       \
 		    OUTPUT=3D$(HOST_BUILD_DIR)/libbpf/			       \
 		    CC=3D"$(HOSTCC)" LD=3D"$(HOSTLD)"			       \
 		    DESTDIR=3D$(HOST_SCRATCH_DIR)/ prefix=3D all install_headers
--=20
2.34.1


