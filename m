Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1968E4DA515
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 23:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343614AbiCOWQe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 18:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240840AbiCOWQe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 18:16:34 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982D55574F
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 15:15:20 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22FLfkuF009029
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 15:15:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=bpSyBZYfDZJO+j/9/M5sfXR5hWvYTgnecGBCL87Dlec=;
 b=QNpm4cVwFpvHAZ6wcvKMNhg3LGa/buMEcB+ENpz+hdBYoN+HNdocnz1aXKkE7+ZhDehr
 UyAmt880aiZxeUytWqqX4wz1YI4sWm7M65iB1RIyOcOsqO3hc9upsurwnA231eAXFj3h
 /QOuhcEk2Mr9BGuWhNoy9b7QEhbNEhoK6DY= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3eu2brghmn-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 15:15:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Di8EKFoDimDEanA56oSSsSbDHPJRMqjVX1StwAW7KeJ8gu4ltJ46Ia65XUS9hBI4gXUVpLyhKQOrlUW2EEOI/KOap4Meb5V/XNGh1f9l2YEwrJzOXrzdlcRH5Ri+JXhQE+HXxFvl/zo58+GemLTtXSooFMLR6Xi6EgwQsbUVIPYH8TqeldSLYJCOQvhMa429aFJ2ZLPqAh7eBhYfVdFivXl+V9WkakuXRwCVj4Lhez91FTHUPrAg9gNRDSZJlSydPZ1XjigBHYVYIREug3Az+yGSSuResb/ApZv21esvYNNmWQseCJZYYEK7ss/SZc9d1K/0Qo9Myui7WGEkGkYXFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpSyBZYfDZJO+j/9/M5sfXR5hWvYTgnecGBCL87Dlec=;
 b=QVGAKvIvKSW9YLh8tASeNoXYNd0R2+B+mIpOaqIm3rMnS6uPypwWdYiUOVk/QIuNwuF7+b2exfZgIWSa2RvqxWgsdXYhNQO0MuDqnqCwYl3t23kie+YtHQ1dAPZfjOgxT8m23yZvbz4ltrhQI9X1L5krfPZGBkdY7XnrvGDTT8CQTAbFTrG+4jEJtAomL/MwoFQ0JJ7JpD15tPidNB0cha9sRjIUAJojEFKazkF8YqpbDbgBkvRnJTIAJFJJdYI5ORhz7g2ElXTFNHj5Lqx/yGRi+jehQjhjHsPphFeQ3ka2dTfhrb8MtGIQsQXikHA4Qj7Srj9+9/BdrSAquZDTsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by BYAPR15MB2695.namprd15.prod.outlook.com (2603:10b6:a03:150::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Tue, 15 Mar
 2022 22:15:14 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3%6]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 22:15:14 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v3 5/5] selftests/bpf: test subskeleton functionality
Thread-Topic: [PATCH bpf-next v3 5/5] selftests/bpf: test subskeleton
 functionality
Thread-Index: AQHYOLokidjpb1++V0aDAKFsjqM1GA==
Date:   Tue, 15 Mar 2022 22:15:13 +0000
Message-ID: <9666648cd9f680756c53dd4286cf34e627c7c73c.1647382072.git.delyank@fb.com>
References: <cover.1647382072.git.delyank@fb.com>
In-Reply-To: <cover.1647382072.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dedf8aad-dc33-425b-02fb-08da06d147c9
x-ms-traffictypediagnostic: BYAPR15MB2695:EE_
x-microsoft-antispam-prvs: <BYAPR15MB26955B0C87462DFE86C3B9F3C1109@BYAPR15MB2695.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vwEV19A6drL78wPTWpWeZm0s4gHINRUTFBvlXRuKmvZPnsc1W7zKl+/xbdqwk9keyzyApyOU1HbmBSAXStBtoutwhOf6tpvf0caFOkqy74dsmtftOayseypHzxXmGAG3msg3goD6cjW75ZH3b17u9KwLsL+VVJHUEXkfLOBkMeST31RH0Vm/DUNcvK5UU7DvAc95F+17Xv5WQvEI1j2fvR+kr55QICzQ65hU9/G3IZbaBYGQu6u+DOzrX9r1whRP7NwHhKhPsdSlDBY0Hw3HAqjwVQlEKT3/hPJY15e2Ug2FG80zgdXXRmISQ/ejiY9tUNNrMAGPAaOw413v9fsWuBTjYkPa/Kbmu2KIouXblvWF0LEIjdiz6cGHbX6vjaATK3Aaur2CeyjximQ7EQTy7CwXUHnE67Pqn5a4Keq+AUEnrfdU5j4unXswKLJShfskocPI+A5MvDL9c1Z5qUdjaKWU9YM4TxvsUbXJ1RGrEsboz9y4ATmD+oYoPLGuao2Zv244u4JwcS0wldA3gYgu/XRs6ulEETRk8R5KQtqhSF0NvLn3KmHswNYLN2+X4YapyzAlZZJSzeP1q8CqkNE+AkAOL2Y9W8xl8UexfKUhg/9K8wMv8UL/2hcQmqtwDMJSoFR543fPBvyJUN3NlKD3GUhtjFeo5xhrrETRjWOjPLDNO/2GqMbhjbAnZ8iT5JBh9nd1d+wmCFgQxqp2caV2jA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(66946007)(6512007)(6506007)(2616005)(64756008)(38100700002)(8676002)(76116006)(66556008)(122000001)(66476007)(2906002)(186003)(83380400001)(316002)(110136005)(6486002)(38070700005)(71200400001)(508600001)(86362001)(36756003)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ht/IdzkRE624N6Dmf+l8j/vIOl2A3RKIXKuDeHc1c10snw/zYN/i8IhtXb?=
 =?iso-8859-1?Q?mw5isU/qhgeauvcIphwoHVtKTF+de+rvUQC/RahYmg//TTsxA2Vee46lLI?=
 =?iso-8859-1?Q?+QpJorBmvjIFwHV/NC08jb/vVp1SjULOZv9kF0dFPxmL/0X9tu5xggEZFi?=
 =?iso-8859-1?Q?xj+ZC++xYt07QjfgLuuyoPUb39nm6qYEAOKqb/SACPnn4egpDCe01NZmpe?=
 =?iso-8859-1?Q?Bthza+ltP2o5W3gW+IZiJHBJRq2BpZyj3xEd+x/4Y/l130I8Psk79uBPMZ?=
 =?iso-8859-1?Q?AWkZ1R4aZDizxfE0v6V5qkQyUq1K2APswf0DwQwdcFwJ3v4+gIR/eViF7/?=
 =?iso-8859-1?Q?n8m+BuLzMbViDR1/lcILSAlNhhgnX++Tofz52C1KHqPsO/NGWPfelhcpZE?=
 =?iso-8859-1?Q?NfVGvAB8EY62V9kWob7vrAKn/gO5CSXfLTc5EgbZaVJrjHh9yuSArVdd0j?=
 =?iso-8859-1?Q?l0ZroeX6bebaL+q4O8+qlqAX/r8OIsiOSroDcoVl57nQl6j7XC80R4b93+?=
 =?iso-8859-1?Q?ojxym/skzQyQTfOssHT871nm/QAKdtsufdtEQVSGAL7DbJ5n9RnSIzDy3M?=
 =?iso-8859-1?Q?p5opq2QzNAAvdtjFnubm8aDrw4sje1bv0WfrTYgo2QJnMc+T6OziIRAwYE?=
 =?iso-8859-1?Q?gDVX4OUaXDCFOAAz7d7Adh/YD1RgDcGrPAlMeKC4mUH5i3UE6X59tK4ZH0?=
 =?iso-8859-1?Q?aP5TBxGQlC+H3lkybyAz5e6mrXEYvu8QpB7hA7WrjwpwS8K2M7GJ6hi6XM?=
 =?iso-8859-1?Q?c5x/meXceiUfq8qWR7FKPy5zF6crCPjyFxLFnZjZPmR2zVTzIwevwxKSxn?=
 =?iso-8859-1?Q?ATxgZ9+EbMOPZOk7eGvZMtX9rIL3eNpnl5zsJ+qXmkqm9LW33rjQLYk0Ff?=
 =?iso-8859-1?Q?PfB1AHfYnSks6HREJEUOzKNVUzlId2xm5lQk2TM8gg/4BOoTQnZf0Z/OIi?=
 =?iso-8859-1?Q?mPdBySq1Zt2jT/A1s2rIshAXY4FMaWvHskpSyGoE0HMBhk17r9nKaCOsZQ?=
 =?iso-8859-1?Q?xG8WeXbU1vrR4oG/UZ9j7s/s62YMWdO7ZAPsRIOMQzKjmhlD8dcOH+EVjQ?=
 =?iso-8859-1?Q?2Wts9u0GVVde/DloCosvKGRousqo3Ou04GvscyZ/IBz5/yzdyjDVJ3CzSO?=
 =?iso-8859-1?Q?b0L1/J3Ri/55L9wKtmNzsRLgfF7BXStRo4/zrCMJiZAmWgz+1m/5cWmZJ+?=
 =?iso-8859-1?Q?iZ6f5jt375+DBonMRfevV/IYj3VYqATUY+A9mmUj+ToCOU16UmZyrMqmem?=
 =?iso-8859-1?Q?MaNEdsmGxLBXQYkYiBNBYf33wxWEYIapu2N/73HhjSt/zmnskzuramyfHl?=
 =?iso-8859-1?Q?wf5TZs44YaeafRbpAwGDspGb3WubikM85sdPSQQ4Rpo/9jNggq/rUW/hXs?=
 =?iso-8859-1?Q?yLO2fissdL3Z89gqcICz88qNq3js8ZN1PtDSpq+Hue7zY16hrYex2T4N7r?=
 =?iso-8859-1?Q?PEYMsP80A2i6oh5JsxWPJD8O4Dp+ZHL0bvW+erF094ld0eWZQaePaESequ?=
 =?iso-8859-1?Q?YG940dHNM6HGrOdaLSLskfHX8jD/EdUimqNV4F18Ns3dTxh3dks57RIbLn?=
 =?iso-8859-1?Q?dVojQaE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dedf8aad-dc33-425b-02fb-08da06d147c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 22:15:13.8320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A6Sk4hOf5/GjIudVLdkAVzlGH0k1GPS7gwbdeduygBn/KxVQAzOxpqnWaReaecAF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2695
X-Proofpoint-GUID: lTDkx6GB6iHjYs-FkjxRgYSaKTBF_sne
X-Proofpoint-ORIG-GUID: lTDkx6GB6iHjYs-FkjxRgYSaKTBF_sne
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

This patch changes the selftests/bpf Makefile to also generate
a subskel.h for every skel.h it would have normally generated.

Separately, it also introduces a new subskeleton test which tests
library objects, externs, weak symbols, kconfigs, and user maps.

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 tools/testing/selftests/bpf/.gitignore        |  1 +
 tools/testing/selftests/bpf/Makefile          | 12 ++-
 .../selftests/bpf/prog_tests/subskeleton.c    | 78 +++++++++++++++++++
 .../selftests/bpf/progs/test_subskeleton.c    | 28 +++++++
 .../bpf/progs/test_subskeleton_lib.c          | 61 +++++++++++++++
 .../bpf/progs/test_subskeleton_lib2.c         | 16 ++++
 6 files changed, 194 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/subskeleton.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_subskeleton.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_subskeleton_lib.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/test_subskeleton_lib2=
.c

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftes=
ts/bpf/.gitignore
index a7eead8820a0..595565eb68c0 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -31,6 +31,7 @@ test_tcp_check_syncookie_user
 test_sysctl
 xdping
 test_cpp
+*.subskel.h
 *.skel.h
 *.lskel.h
 /no_alu32
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests=
/bpf/Makefile
index fe12b4f5fe20..8949ace58c33 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -326,7 +326,13 @@ endef
 SKEL_BLACKLIST :=3D btf__% test_pinning_invalid.c test_sk_assign.c
=20
 LINKED_SKELS :=3D test_static_linked.skel.h linked_funcs.skel.h		\
-		linked_vars.skel.h linked_maps.skel.h
+		linked_vars.skel.h linked_maps.skel.h 			\
+		test_subskeleton.skel.h test_subskeleton_lib.skel.h
+
+# In the subskeleton case, we want the test_subskeleton_lib.subskel.h file
+# but that's created as a side-effect of the skel.h generation.
+test_subskeleton.skel.h-deps :=3D test_subskeleton_lib2.o test_subskeleton=
_lib.o test_subskeleton.o
+test_subskeleton_lib.skel.h-deps :=3D test_subskeleton_lib2.o test_subskel=
eton_lib.o
=20
 LSKELS :=3D kfunc_call_test.c fentry_test.c fexit_test.c fexit_sleep.c \
 	test_ringbuf.c atomics.c trace_printk.c trace_vprintk.c \
@@ -404,6 +410,7 @@ $(TRUNNER_BPF_SKELS): %.skel.h: %.o $(BPFTOOL) | $(TRUN=
NER_OUTPUT)
 	$(Q)$$(BPFTOOL) gen object $$(<:.o=3D.linked3.o) $$(<:.o=3D.linked2.o)
 	$(Q)diff $$(<:.o=3D.linked2.o) $$(<:.o=3D.linked3.o)
 	$(Q)$$(BPFTOOL) gen skeleton $$(<:.o=3D.linked3.o) name $$(notdir $$(<:.o=
=3D)) > $$@
+	$(Q)$$(BPFTOOL) gen subskeleton $$(<:.o=3D.linked3.o) name $$(notdir $$(<=
:.o=3D)) > $$(@:.skel.h=3D.subskel.h)
=20
 $(TRUNNER_BPF_LSKELS): %.lskel.h: %.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
 	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
@@ -421,6 +428,7 @@ $(TRUNNER_BPF_SKELS_LINKED): $(TRUNNER_BPF_OBJS) $(BPFT=
OOL) | $(TRUNNER_OUTPUT)
 	$(Q)diff $$(@:.skel.h=3D.linked2.o) $$(@:.skel.h=3D.linked3.o)
 	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
 	$(Q)$$(BPFTOOL) gen skeleton $$(@:.skel.h=3D.linked3.o) name $$(notdir $$=
(@:.skel.h=3D)) > $$@
+	$(Q)$$(BPFTOOL) gen subskeleton $$(@:.skel.h=3D.linked3.o) name $$(notdir=
 $$(@:.skel.h=3D)) > $$(@:.skel.h=3D.subskel.h)
 endif
=20
 # ensure we set up tests.h header generation rule just once
@@ -557,6 +565,6 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 EXTRA_CLEAN :=3D $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)	\
 	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
 	feature bpftool							\
-	$(addprefix $(OUTPUT)/,*.o *.skel.h *.lskel.h no_alu32 bpf_gcc bpf_testmo=
d.ko)
+	$(addprefix $(OUTPUT)/,*.o *.skel.h *.lskel.h *.subskel.h no_alu32 bpf_gc=
c bpf_testmod.ko)
=20
 .PHONY: docs docs-clean
diff --git a/tools/testing/selftests/bpf/prog_tests/subskeleton.c b/tools/t=
esting/selftests/bpf/prog_tests/subskeleton.c
new file mode 100644
index 000000000000..9c31b7004f9c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/subskeleton.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include "test_subskeleton.skel.h"
+#include "test_subskeleton_lib.subskel.h"
+
+static void subskeleton_lib_setup(struct bpf_object *obj)
+{
+	struct test_subskeleton_lib *lib =3D test_subskeleton_lib__open(obj);
+
+	if (!ASSERT_OK_PTR(lib, "open subskeleton"))
+		return;
+
+	*lib->rodata.var1 =3D 1;
+	*lib->data.var2 =3D 2;
+	lib->bss.var3->var3_1 =3D 3;
+	lib->bss.var3->var3_2 =3D 4;
+
+	test_subskeleton_lib__destroy(lib);
+}
+
+static int subskeleton_lib_subresult(struct bpf_object *obj)
+{
+	struct test_subskeleton_lib *lib =3D test_subskeleton_lib__open(obj);
+	int result;
+
+	if (!ASSERT_OK_PTR(lib, "open subskeleton"))
+		return -EINVAL;
+
+	result =3D *lib->bss.libout1;
+	ASSERT_EQ(result, 1 + 2 + 3 + 4 + 5 + 6, "lib subresult");
+
+	ASSERT_OK_PTR(lib->progs.lib_perf_handler, "lib_perf_handler");
+	ASSERT_STREQ(bpf_program__name(lib->progs.lib_perf_handler),
+		     "lib_perf_handler", "program name");
+
+	ASSERT_OK_PTR(lib->maps.map1, "map1");
+	ASSERT_STREQ(bpf_map__name(lib->maps.map1), "map1", "map name");
+
+	ASSERT_EQ(*lib->data.var5, 5, "__weak var5");
+	ASSERT_EQ(*lib->data.var6, 6, "extern var6");
+	ASSERT_TRUE(*lib->kconfig.CONFIG_BPF_SYSCALL, "CONFIG_BPF_SYSCALL");
+
+	test_subskeleton_lib__destroy(lib);
+	return result;
+}
+
+void test_subskeleton(void)
+{
+	int err, result;
+	struct test_subskeleton *skel;
+
+	skel =3D test_subskeleton__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	skel->rodata->rovar1 =3D 10;
+	skel->rodata->var1 =3D 1;
+	subskeleton_lib_setup(skel->obj);
+
+	err =3D test_subskeleton__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	err =3D test_subskeleton__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto cleanup;
+
+	/* trigger tracepoint */
+	usleep(1);
+
+	result =3D subskeleton_lib_subresult(skel->obj) * 10;
+	ASSERT_EQ(skel->bss->out1, result, "unexpected calculation");
+
+cleanup:
+	test_subskeleton__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_subskeleton.c b/tools/t=
esting/selftests/bpf/progs/test_subskeleton.c
new file mode 100644
index 000000000000..006417974372
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_subskeleton.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include <stdbool.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+/* volatile to force a read, compiler may assume 0 otherwise */
+const volatile int rovar1;
+int out1;
+
+/* Override weak symbol in test_subskeleton_lib */
+int var5 =3D 5;
+
+extern volatile bool CONFIG_BPF_SYSCALL __kconfig;
+
+extern int lib_routine(void);
+
+SEC("raw_tp/sys_enter")
+int handler1(const void *ctx)
+{
+	(void) CONFIG_BPF_SYSCALL;
+
+	out1 =3D lib_routine() * rovar1;
+	return 0;
+}
+
+char LICENSE[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_subskeleton_lib.c b/too=
ls/testing/selftests/bpf/progs/test_subskeleton_lib.c
new file mode 100644
index 000000000000..ecfafe812c36
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_subskeleton_lib.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include <stdbool.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+/* volatile to force a read */
+const volatile int var1;
+volatile int var2 =3D 1;
+struct {
+	int var3_1;
+	__s64 var3_2;
+} var3;
+int libout1;
+
+extern volatile bool CONFIG_BPF_SYSCALL __kconfig;
+
+int var4[4];
+
+__weak int var5 SEC(".data");
+
+/* Fully contained within library extern-and-definition */
+extern int var6;
+
+int var7 SEC(".data.custom");
+
+int (*fn_ptr)(void);
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, __u32);
+	__type(value, __u32);
+	__uint(max_entries, 16);
+} map1 SEC(".maps");
+
+extern struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, __u32);
+	__type(value, __u32);
+	__uint(max_entries, 16);
+} map2 SEC(".maps");
+
+int lib_routine(void)
+{
+	__u32 key =3D 1, value =3D 2;
+
+	(void) CONFIG_BPF_SYSCALL;
+	bpf_map_update_elem(&map2, &key, &value, BPF_ANY);
+
+	libout1 =3D var1 + var2 + var3.var3_1 + var3.var3_2 + var5 + var6;
+	return libout1;
+}
+
+SEC("perf_event")
+int lib_perf_handler(struct pt_regs *ctx)
+{
+	return 0;
+}
+
+char LICENSE[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_subskeleton_lib2.c b/to=
ols/testing/selftests/bpf/progs/test_subskeleton_lib2.c
new file mode 100644
index 000000000000..80238486b7ce
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_subskeleton_lib2.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+int var6 =3D 6;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, __u32);
+	__type(value, __u32);
+	__uint(max_entries, 16);
+} map2 SEC(".maps");
+
+char LICENSE[] SEC("license") =3D "GPL";
--=20
2.34.1
