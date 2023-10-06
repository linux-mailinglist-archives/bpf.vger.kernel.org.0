Return-Path: <bpf+bounces-11552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCB67BBE2B
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 19:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009D72823D1
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 17:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22CF347D1;
	Fri,  6 Oct 2023 17:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D2A347B3
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 17:57:57 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB09D6
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 10:57:53 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 396CRier017756
	for <bpf@vger.kernel.org>; Fri, 6 Oct 2023 10:57:52 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tj6d00158-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 06 Oct 2023 10:57:52 -0700
Received: from twshared11278.41.prn1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 6 Oct 2023 10:57:51 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 2C998394AC8F4; Fri,  6 Oct 2023 10:57:47 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>, Jiri Olsa <jolsa@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 2/3] selftests/bpf: support building selftests in optimized -O2 mode
Date: Fri, 6 Oct 2023 10:57:43 -0700
Message-ID: <20231006175744.3136675-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006175744.3136675-1-andrii@kernel.org>
References: <20231006175744.3136675-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: dflrx1T1s5-I9WDyCXEmz9FYF1uT5rzP
X-Proofpoint-ORIG-GUID: dflrx1T1s5-I9WDyCXEmz9FYF1uT5rzP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_14,2023-10-06_01,2023-05-22_02
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
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

Acked-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/Makefile | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
index 99f66bdf7698..4225f975fce3 100644
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
@@ -243,7 +245,7 @@ $(OUTPUT)/runqslower: $(BPFOBJ) | $(DEFAULT_BPFTOOL) =
$(RUNQSLOWER_OUTPUT)
 		    BPFTOOL_OUTPUT=3D$(HOST_BUILD_DIR)/bpftool/		       \
 		    BPFOBJ_OUTPUT=3D$(BUILD_DIR)/libbpf			       \
 		    BPFOBJ=3D$(BPFOBJ) BPF_INCLUDE=3D$(INCLUDE_DIR)		       \
-		    EXTRA_CFLAGS=3D'-g -O0 $(SAN_CFLAGS)'			       \
+		    EXTRA_CFLAGS=3D'-g $(OPT_FLAGS) $(SAN_CFLAGS)'	       \
 		    EXTRA_LDFLAGS=3D'$(SAN_LDFLAGS)' &&			       \
 		    cp $(RUNQSLOWER_OUTPUT)runqslower $@
=20
@@ -281,7 +283,7 @@ $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $=
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
@@ -292,7 +294,7 @@ $(CROSS_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(B=
PFTOOLDIR)/Makefile)	\
 		    $(BPFOBJ) | $(BUILD_DIR)/bpftool
 	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)				\
 		    ARCH=3D$(ARCH) CROSS_COMPILE=3D$(CROSS_COMPILE)			\
-		    EXTRA_CFLAGS=3D'-g -O0'					\
+		    EXTRA_CFLAGS=3D'-g $(OPT_FLAGS)'				\
 		    OUTPUT=3D$(BUILD_DIR)/bpftool/				\
 		    LIBBPF_OUTPUT=3D$(BUILD_DIR)/libbpf/				\
 		    LIBBPF_DESTDIR=3D$(SCRATCH_DIR)/				\
@@ -315,7 +317,7 @@ $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Make=
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
@@ -324,7 +326,7 @@ $(HOST_BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)=
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


