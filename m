Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA5D4DBB2A
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 00:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237131AbiCPXiv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 19:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245373AbiCPXiu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 19:38:50 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFD4167DF
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 16:37:34 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22GHCdMP028583
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 16:37:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=bpSyBZYfDZJO+j/9/M5sfXR5hWvYTgnecGBCL87Dlec=;
 b=eo6+Un4OkzARWQh7ZGYXGD+mhuQf8D6IBYNz06CMXvpl8q43ho8ZnLzBCy5bwn71++Bt
 o4MBp/02nz7Ua/4jfFeUvQXQCcWhMQYWMc8U0wN/KdlbNt/7Fso2XUP6et/vWBvymgH7
 cfJVsE8cbsQH14qobl8ducJQsn80FVzg1cQ= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3eucf464d8-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 16:37:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUnazgl3OT7+da4zBfWbmgbvcOUWiCuBN3qMhYB+7sJ49/Xnw/wnqg3H9QLnhLJTvDTHGa/wu+mXPKJfben3+SAHmiqFZ1u1GtML+R6AAf9KXtFllqwYX+LI0+GUkfnraaGyA4WIb/+n9gofleyiBJpGssTE9XAaL+gYDZjBuURxd7p6Wy5ek1R4PXpddXPQyTrSqko+nyx0pp7CSX6tenZM2g9XyeieqqACG1pp8WYGoAiiwPvMOO8s7Kk0MzryFGCBVvQqfNm08GxVyXD/cha2yfp7mlQrWJPgsGyL08yNoSmZaXBiBd1oMA3q4s8+eJMvKaLr4N+8dtYjH3TZDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpSyBZYfDZJO+j/9/M5sfXR5hWvYTgnecGBCL87Dlec=;
 b=OBxisdKXxsmwTN8A6leuqIj/eYVJ9B7lYd+el4CQriFVGjJZbOfgdwMwL06+nlUQOl+ctbSkS+1QqM5xwb+lYm+kKYagJlkaLk7ksPI20tF1oX/D4tYq9ckIKw5J33pntaFoiej7JxB9QV7tUVAmM/t8dkcLvFiXC8EW2yI95I4/PgyFr3MQnLvOYM7lKpOmDGr/enRfoO2BJwGAw3D5DhaOWsv+X4YDpARJVBUAnGzTG4qwr6SGvr5IHCqAPc72B/9hx4s6fBnN3khjw+dQefXxb8k3wq1QN2McPKoytNINJpzaeRtJZ/XmzIUsY+/M1gXSyr5giTNc/O6sqbFuxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by DM5PR1501MB2182.namprd15.prod.outlook.com (2603:10b6:4:a4::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 16 Mar
 2022 23:37:31 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3%6]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 23:37:31 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v4 5/5] selftests/bpf: test subskeleton functionality
Thread-Topic: [PATCH bpf-next v4 5/5] selftests/bpf: test subskeleton
 functionality
Thread-Index: AQHYOY7OL0rfKFu3gUWToAwEtc5y+Q==
Date:   Wed, 16 Mar 2022 23:37:31 +0000
Message-ID: <1bd24956940bbbfe169bb34f7f87b11df52ef011.1647473511.git.delyank@fb.com>
References: <cover.1647473511.git.delyank@fb.com>
In-Reply-To: <cover.1647473511.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4b8148a-fbe9-48be-bf66-08da07a5f0ee
x-ms-traffictypediagnostic: DM5PR1501MB2182:EE_
x-microsoft-antispam-prvs: <DM5PR1501MB21822C84FE3E9BF5B5ED8A16C1119@DM5PR1501MB2182.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DfrBqey20bAxBNd/+RNRmJet0DzBCAyP5lUwd2a3lKNXZaR26y1RpwnXuJDdVPwLEbJ6vXCt4X3bJGro1fCQt5mEhYR3akCa/LQutXIg++8mbwsQJ4nSOnUV7mbIFPq4s8W5Ifwoa0RFnvqK61XIs3SgxH/w9bDRM4nxMac2LUXM2nKJBezV7KseXYFFYHhCvL5bhlujA5KBGBBZNrvWbaG9jVlZmVLBrY2HylKY+3NuuiatrEzD2KZCMWmhU5SDwWEvXJZA/Zfwey8kn7QVPpCuXWhDjJDCjGrqFoAoTXh461m3ff+8LT1fze/qgQNKUL7YY7SFox1nexgiSW9V425TTo8ABuY91aOtz+N5qTxzoubYGKC1PhCK5AR4RmBGRxaSp5UsTYEF7aa2QNc2JFcJe2SdXbQPUWR/x4/V+lHXqWw4L3GXPFEXGv0yaQWDsEgG1lCK4YEWDe/lXFrTeIMozVXkJ38+JKhNATQjkQ+oqHdSe6jRotw83oATFKHdAD1WYnmDAesO7r9mRTJXIfxVNaic/KwsYIE7ZTUFSqPQly+PvlPQDtc5ZrCNOxyeJkMffNlQDh58JReV97l4slFtSV17Fzl9wtyQWwB/zs6yYWkthX9dElWcBZQp0K+ckqiwC9rWj9i0vbgft2rODGKqN7l8gqlNS7wxcb/D0vImulzHSFW8wOQu7mWF/oawkYuj+NnZzJT4SoffM6SeDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(2616005)(5660300002)(110136005)(316002)(38070700005)(6486002)(71200400001)(508600001)(64756008)(8676002)(6512007)(122000001)(6506007)(66476007)(66446008)(86362001)(76116006)(66946007)(66556008)(91956017)(38100700002)(36756003)(186003)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UHvMa4WhgvqyX05pfrjWGPzkhwmsNsyWGCOHaoZ25u+OG0aJpAgLwneITM?=
 =?iso-8859-1?Q?V5xHc5cQ4D0F6UiDRM4n6v3n2987xyQGcJTvgoERkB1k5HW4gIghxjvec/?=
 =?iso-8859-1?Q?AeTUexZ1WeGUMK5nRuRh8KTFaz9VOgswPLkZidXf6461ITdxmkJ9ECmCcA?=
 =?iso-8859-1?Q?dR9YHKWAau6s7EEoJSvzgy4pA03HjVWnrSzDzN0odwzamNy3TjWOig/MFp?=
 =?iso-8859-1?Q?NxVu7OQPkvXQZ3Wd9DSxpr5V3IvemulC5IFnWAmpb7CxJYlGwj76JwfjTn?=
 =?iso-8859-1?Q?VGK8NTkQlJJ+Wpd4FQcIjrSI+uVxX55ofILF/OW3LMC6OZrDIn+7yBVBSy?=
 =?iso-8859-1?Q?iY5mEHN+nZ5URTz9+S+xVhfy6wuxBJ3cA7dk8kGKPWKy/8sXpX5ZXb4isk?=
 =?iso-8859-1?Q?8Ies3v9y11wP7uaOX6cxpHII6QRVXFoly4s/GQRvMKXqCP8FlpCAbqHKRR?=
 =?iso-8859-1?Q?bMFdrN5NBe1wcUw2bULRevVvn7Z2XbCWostpP2BQFHnX5eb9FEN+O5Vxha?=
 =?iso-8859-1?Q?NhFpG9kZPGU/70nVjVEalwMyOmryI6VqfMVmfsNxbOJgt0sZtAk5u+SNiO?=
 =?iso-8859-1?Q?f31GPjjOsYO2rtaMHAgGgDFendA4NBQL5Y07BUs2X67iUmvZym9JMI1ASJ?=
 =?iso-8859-1?Q?H88n/CDPNSCa5mnOUEY2KxedPkg04NdBF+ixL0xjYIvheHjo+SDMvWIEJe?=
 =?iso-8859-1?Q?ppl5eG1waibitI5IKijsXCX4QlEkXVEU6i0tBW/3YE7aAOvodkymllGEUw?=
 =?iso-8859-1?Q?qAA3qromsaN1r/fop4DBJZtwhkv9nnSRDuzH4mOOb28Dd7U/uXTafa5vxu?=
 =?iso-8859-1?Q?qom+O38NuUzjyzCh2szsnd3xb0ivJpcunylGxRuEP7sY9lXZ1E5nc999Ih?=
 =?iso-8859-1?Q?rKkIvDUq2OsiCJBQc2O/c+C/hDXt70P5O6IJLB0b5AzMeDivqVh6IMx5+i?=
 =?iso-8859-1?Q?X3QFz6SXxw7UgXCpatS/Qphy3XJUVXckGJ4pWLp7RPYqcmuNQJmGHxru3N?=
 =?iso-8859-1?Q?jRNcA42rP2iVbiIa/FrDcA4LrQd75C0paAGZv2XWVOyZd28OcqsbMtkSQA?=
 =?iso-8859-1?Q?XE0WHSzS3ZIEnTl9MAva4WMhlk5Z9qBoBkGu5NIar51kzAmEE1pR8aBytq?=
 =?iso-8859-1?Q?jAbFvQETl3uj1A/v9Kkh7NtlOnncc9MU68P0MhZGjov+TJv9tC5pSFqREV?=
 =?iso-8859-1?Q?COSg9LMhxiNks1l+mNQGsQ6I6XatGfrAvPdz+subqmp/z5JG0ezmIiUS0F?=
 =?iso-8859-1?Q?Vp/i4zh3DmPz7OaZ6yskCXOwoBLTGIvwYf+2uscxZL5ORLfG3Unr3Xm0jd?=
 =?iso-8859-1?Q?26VU6b5tvk7M6AG5DQrNZ3jrHUhlITJecN9YkD4aMluMQjUi1XTsWAadPl?=
 =?iso-8859-1?Q?xPuGwb2K03VP2dM0uxyXfzi7cHgW3Vs7nTtB/T1htF9FehaMUtX3vpQy1g?=
 =?iso-8859-1?Q?L94LiaLa/FIrFf8MTBMPulBfq7gTbN24QjoOE/ioeiA9hJpyCeRFVr1PVY?=
 =?iso-8859-1?Q?tTq/Cj3Rvnx546w4S8WxC7kZ9pga1C20yk4wcGg7sDRqomaGGVMMJ5zk9F?=
 =?iso-8859-1?Q?+kvf5wA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b8148a-fbe9-48be-bf66-08da07a5f0ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 23:37:31.8742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DdxRegNfvrmLvXnwoXiRl7SAnfvd8+uvp/TpI0OK8GSYnsGwtlaJhiDUmt0+XJ+C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1501MB2182
X-Proofpoint-ORIG-GUID: w5wwgu9kyHg6gCmg5XbCP_5xFMlEhZrv
X-Proofpoint-GUID: w5wwgu9kyHg6gCmg5XbCP_5xFMlEhZrv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-16_09,2022-03-15_01,2022-02-23_01
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
