Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6CB4B3358
	for <lists+bpf@lfdr.de>; Sat, 12 Feb 2022 06:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbiBLF5t convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 12 Feb 2022 00:57:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiBLF5s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 12 Feb 2022 00:57:48 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AED928E3E
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 21:57:46 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21C0YklV004026
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 21:57:46 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e62fk0xh3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 21:57:46 -0800
Received: from twshared13833.42.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Feb 2022 21:57:44 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 4821110BF5C6F; Fri, 11 Feb 2022 21:57:38 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: add Skeleton templated wrapper as an example
Date:   Fri, 11 Feb 2022 21:57:33 -0800
Message-ID: <20220212055733.539056-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220212055733.539056-1-andrii@kernel.org>
References: <20220212055733.539056-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: gZbZ5fBiDpHj7tExU_WrBN3rNvVZMBLT
X-Proofpoint-GUID: gZbZ5fBiDpHj7tExU_WrBN3rNvVZMBLT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-12_02,2022-02-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 lowpriorityscore=0 clxscore=1034 phishscore=0 adultscore=0 impostorscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 mlxlogscore=816 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202120035
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add an example of how to build C++ template-based BPF skeleton wrapper.
It's an actually runnable valid use of skeleton through more C++-like
interface. Note that skeleton destuction happens implicitly through
Skeleton<T>'s destructor.

Also make test_cpp runnable as it would have crashed on invalid btf
passed into btf_dump__new().

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/test_cpp.cpp | 87 +++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_cpp.cpp b/tools/testing/selftests/bpf/test_cpp.cpp
index e00201de2890..773f165c4898 100644
--- a/tools/testing/selftests/bpf/test_cpp.cpp
+++ b/tools/testing/selftests/bpf/test_cpp.cpp
@@ -5,18 +5,100 @@
 #include <bpf/btf.h>
 #include "test_core_extern.skel.h"
 
-/* do nothing, just make sure we can link successfully */
+template <typename T>
+class Skeleton {
+private:
+	T *skel;
+public:
+	Skeleton(): skel(nullptr) { }
+
+	~Skeleton() { if (skel) T::destroy(skel); }
+
+	int open(const struct bpf_object_open_opts *opts = nullptr)
+	{
+		int err;
+
+		if (skel)
+			return -EBUSY;
+
+		skel = T::open(opts);
+		err = libbpf_get_error(skel);
+		if (err) {
+			skel = nullptr;
+			return err;
+		}
+
+		return 0;
+	}
+
+	int load() { return T::load(skel); }
+
+	int attach() { return T::attach(skel); }
+
+	void detach() { return T::detach(skel); }
+
+	const T* operator->() const { return skel; }
+
+	T* operator->() { return skel; }
+
+	const T *get() const { return skel; }
+};
 
 static void dump_printf(void *ctx, const char *fmt, va_list args)
 {
 }
 
+static void try_skeleton_template()
+{
+	Skeleton<test_core_extern> skel;
+	std::string prog_name;
+	int err;
+	LIBBPF_OPTS(bpf_object_open_opts, opts);
+
+	err = skel.open(&opts);
+	if (err) {
+		fprintf(stderr, "Skeleton open failed: %d\n", err);
+		return;
+	}
+
+	skel->data->kern_ver = 123;
+	skel->data->int_val = skel->data->ushort_val;
+
+	err = skel.load();
+	if (err) {
+		fprintf(stderr, "Skeleton load failed: %d\n", err);
+		return;
+	}
+
+	if (!skel->kconfig->CONFIG_BPF_SYSCALL)
+		fprintf(stderr, "Seems like CONFIG_BPF_SYSCALL isn't set?!\n");
+
+	err = skel.attach();
+	if (err) {
+		fprintf(stderr, "Skeleton attach failed: %d\n", err);
+		return;
+	}
+
+	prog_name = bpf_program__name(skel->progs.handle_sys_enter);
+	if (prog_name != "handle_sys_enter")
+		fprintf(stderr, "Unexpected program name: %s\n", prog_name.c_str());
+
+	bpf_link__destroy(skel->links.handle_sys_enter);
+	skel->links.handle_sys_enter = bpf_program__attach(skel->progs.handle_sys_enter);
+
+	skel.detach();
+
+	/* destructor will destory underlying skeleton */
+}
+
 int main(int argc, char *argv[])
 {
 	struct btf_dump_opts opts = { };
 	struct test_core_extern *skel;
 	struct btf *btf;
 
+	try_skeleton_template();
+
 	/* libbpf.h */
 	libbpf_set_print(NULL);
 
@@ -25,7 +107,8 @@ int main(int argc, char *argv[])
 
 	/* btf.h */
 	btf = btf__new(NULL, 0);
-	btf_dump__new(btf, dump_printf, nullptr, &opts);
+	if (!libbpf_get_error(btf))
+		btf_dump__new(btf, dump_printf, nullptr, &opts);
 
 	/* BPF skeleton */
 	skel = test_core_extern__open_and_load();
-- 
2.30.2

