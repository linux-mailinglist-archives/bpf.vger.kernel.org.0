Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA864DA78D
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 02:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353012AbiCPBuT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 21:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353015AbiCPBuS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 21:50:18 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACE35E14E
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 18:49:05 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22G1YC99005106
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 18:49:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=prlauYYkFo6CrRd12j0xqSY9DwY6J6otxG++BxiHu04=;
 b=aavwEmnmKW+wytAxvJ0UZH0RdsCHcxpyUp7Xj+C3CJigGGa4sbHR19bAczxmFY7Zh7Lf
 EHRPExj6SnCH7Z8gNLRmmXLLStAwZBU2cgHDqsL6Hp9DjG/KcIj0ekRH8I8qRqbSkeXO
 uAWNbOtaFu5k7fY0Ux04UOYB5x27USIcmzE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3eu6bc02gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 18:49:04 -0700
Received: from twshared29473.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 18:49:03 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 560142103FD8; Tue, 15 Mar 2022 18:48:54 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/3] bpf: selftests: Remove libcap usage from test_verifier
Date:   Tue, 15 Mar 2022 18:48:54 -0700
Message-ID: <20220316014854.2257030-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220316014841.2255248-1-kafai@fb.com>
References: <20220316014841.2255248-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: UTD8bySCOxAP3ibBCUba3vUP2h47bRZR
X-Proofpoint-ORIG-GUID: UTD8bySCOxAP3ibBCUba3vUP2h47bRZR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-15_11,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch removes the libcap usage from test_verifier.
The cap_*_effective() helpers added in the earlier patch are
used instead.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/testing/selftests/bpf/Makefile        |  3 +-
 tools/testing/selftests/bpf/test_verifier.c | 89 ++++++---------------
 2 files changed, 28 insertions(+), 64 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
index fe12b4f5fe20..1c6e55740019 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -195,6 +195,7 @@ $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(BPFOB=
J)
 CGROUP_HELPERS	:=3D $(OUTPUT)/cgroup_helpers.o
 TESTING_HELPERS	:=3D $(OUTPUT)/testing_helpers.o
 TRACE_HELPERS	:=3D $(OUTPUT)/trace_helpers.o
+CAP_HELPERS	:=3D $(OUTPUT)/cap_helpers.o
=20
 $(OUTPUT)/test_dev_cgroup: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_skb_cgroup_id_user: $(CGROUP_HELPERS) $(TESTING_HELPERS)
@@ -211,7 +212,7 @@ $(OUTPUT)/test_lirc_mode2_user: $(TESTING_HELPERS)
 $(OUTPUT)/xdping: $(TESTING_HELPERS)
 $(OUTPUT)/flow_dissector_load: $(TESTING_HELPERS)
 $(OUTPUT)/test_maps: $(TESTING_HELPERS)
-$(OUTPUT)/test_verifier: $(TESTING_HELPERS)
+$(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS)
=20
 BPFTOOL ?=3D $(DEFAULT_BPFTOOL)
 $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefi=
le)    \
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/=
selftests/bpf/test_verifier.c
index 92e3465fbae8..091848662b7a 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -22,8 +22,7 @@
 #include <limits.h>
 #include <assert.h>
=20
-#include <sys/capability.h>
-
+#include <linux/capability.h>
 #include <linux/unistd.h>
 #include <linux/filter.h>
 #include <linux/bpf_perf_event.h>
@@ -42,6 +41,7 @@
 #  define CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS 1
 # endif
 #endif
+#include "cap_helpers.h"
 #include "bpf_rand.h"
 #include "bpf_util.h"
 #include "test_btf.h"
@@ -62,6 +62,10 @@
 #define F_NEEDS_EFFICIENT_UNALIGNED_ACCESS	(1 << 0)
 #define F_LOAD_WITH_STRICT_ALIGNMENT		(1 << 1)
=20
+/* need CAP_BPF, CAP_NET_ADMIN, CAP_PERFMON to load progs */
+#define ADMIN_CAPS (1ULL << CAP_NET_ADMIN |	\
+		    1ULL << CAP_PERFMON |	\
+		    1ULL << CAP_BPF)
 #define UNPRIV_SYSCTL "kernel/unprivileged_bpf_disabled"
 static bool unpriv_disabled =3D false;
 static int skips;
@@ -973,47 +977,19 @@ struct libcap {
=20
 static int set_admin(bool admin)
 {
-	cap_t caps;
-	/* need CAP_BPF, CAP_NET_ADMIN, CAP_PERFMON to load progs */
-	const cap_value_t cap_net_admin =3D CAP_NET_ADMIN;
-	const cap_value_t cap_sys_admin =3D CAP_SYS_ADMIN;
-	struct libcap *cap;
-	int ret =3D -1;
-
-	caps =3D cap_get_proc();
-	if (!caps) {
-		perror("cap_get_proc");
-		return -1;
-	}
-	cap =3D (struct libcap *)caps;
-	if (cap_set_flag(caps, CAP_EFFECTIVE, 1, &cap_sys_admin, CAP_CLEAR)) {
-		perror("cap_set_flag clear admin");
-		goto out;
-	}
-	if (cap_set_flag(caps, CAP_EFFECTIVE, 1, &cap_net_admin,
-				admin ? CAP_SET : CAP_CLEAR)) {
-		perror("cap_set_flag set_or_clear net");
-		goto out;
-	}
-	/* libcap is likely old and simply ignores CAP_BPF and CAP_PERFMON,
-	 * so update effective bits manually
-	 */
+	int err;
+
 	if (admin) {
-		cap->data[1].effective |=3D 1 << (38 /* CAP_PERFMON */ - 32);
-		cap->data[1].effective |=3D 1 << (39 /* CAP_BPF */ - 32);
+		err =3D cap_enable_effective(ADMIN_CAPS, NULL);
+		if (err)
+			perror("cap_enable_effective(ADMIN_CAPS)");
 	} else {
-		cap->data[1].effective &=3D ~(1 << (38 - 32));
-		cap->data[1].effective &=3D ~(1 << (39 - 32));
-	}
-	if (cap_set_proc(caps)) {
-		perror("cap_set_proc");
-		goto out;
+		err =3D cap_disable_effective(ADMIN_CAPS, NULL);
+		if (err)
+			perror("cap_disable_effective(ADMIN_CAPS)");
 	}
-	ret =3D 0;
-out:
-	if (cap_free(caps))
-		perror("cap_free");
-	return ret;
+
+	return err;
 }
=20
 static int do_prog_test_run(int fd_prog, bool unpriv, uint32_t expected_=
val,
@@ -1291,31 +1267,18 @@ static void do_test_single(struct bpf_test *test,=
 bool unpriv,
=20
 static bool is_admin(void)
 {
-	cap_flag_value_t net_priv =3D CAP_CLEAR;
-	bool perfmon_priv =3D false;
-	bool bpf_priv =3D false;
-	struct libcap *cap;
-	cap_t caps;
-
-#ifdef CAP_IS_SUPPORTED
-	if (!CAP_IS_SUPPORTED(CAP_SETFCAP)) {
-		perror("cap_get_flag");
-		return false;
-	}
-#endif
-	caps =3D cap_get_proc();
-	if (!caps) {
-		perror("cap_get_proc");
+	__u64 caps;
+
+	/* The test checks for finer cap as CAP_NET_ADMIN,
+	 * CAP_PERFMON, and CAP_BPF instead of CAP_SYS_ADMIN.
+	 * Thus, disable CAP_SYS_ADMIN at the beginning.
+	 */
+	if (cap_disable_effective(1ULL << CAP_SYS_ADMIN, &caps)) {
+		perror("cap_disable_effective(CAP_SYS_ADMIN)");
 		return false;
 	}
-	cap =3D (struct libcap *)caps;
-	bpf_priv =3D cap->data[1].effective & (1 << (39/* CAP_BPF */ - 32));
-	perfmon_priv =3D cap->data[1].effective & (1 << (38/* CAP_PERFMON */ - =
32));
-	if (cap_get_flag(caps, CAP_NET_ADMIN, CAP_EFFECTIVE, &net_priv))
-		perror("cap_get_flag NET");
-	if (cap_free(caps))
-		perror("cap_free");
-	return bpf_priv && perfmon_priv && net_priv =3D=3D CAP_SET;
+
+	return (caps & ADMIN_CAPS) =3D=3D ADMIN_CAPS;
 }
=20
 static void get_unpriv_disabled()
--=20
2.30.2

