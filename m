Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED63348D4B8
	for <lists+bpf@lfdr.de>; Thu, 13 Jan 2022 10:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbiAMJGV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Jan 2022 04:06:21 -0500
Received: from mx07-001d1705.pphosted.com ([185.132.183.11]:36750 "EHLO
        mx07-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232280AbiAMJGV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 13 Jan 2022 04:06:21 -0500
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20CLvkiS013019;
        Thu, 13 Jan 2022 09:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=3ytUngd5phrHjl84Ss5a6MhDwHAV5VGTksNb8Ue++HY=;
 b=mYHycexqdNfZRnZuEdvSeJG/904lq4qKwjYkLt+leVCyHCEj+7phyi7+O5rzJgT9L0no
 gpV70I8n88fy9yT6tGcbd1sd0v2/x63QFAwkpAJ2bT4SZaHfRZvJ9QrnQgWSAG9PMAIp
 cgBtX6jalIGQ0ni3t6x7tNgYmbVKHn/reWGK8TWstXkNUvJayLyYtq9omoManlujrtaP
 pmPIzVSOYw8Cy79lTfWaySOTi+glcOTm3RZ4N+m1VO+sUHc53wo5d0CBahb4VD4z6lOF
 nF0vi2sbhy8lP1nIDE2TbmrJHi0ZXX5fE2a7TYxEs2wXNOEAat48INq1idrr8b5j9WRJ HQ== 
Received: from jpn01-os0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2106.outbound.protection.outlook.com [104.47.23.106])
        by mx08-001d1705.pphosted.com with ESMTP id 3dj1bws1tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 09:05:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1UK6sJv1bDs4m+0rOsyys98qvdiTExB6T3r+CCuAcuPh2vuS+h+PJn6ohnoKHFuJwV97DRZ9iaM08Dzuilbu/8nigDIsuLw8Ey6AXwjBqBYeat2aMPPsfgkpgThRhMF3y8wMsOuYqdfK1O3oGchIhc6addooTf7So2cKfaWPG5FbV09wUWpshzh1JaWQNiq/6XVJPRbXr5Z/yM6FBR0Q5EXcbv4Dy+5uAgI5I8Y2PmyyZovGjKGxiGNOGa/SwgcqJAQ+tt3kKfhYQIh8LYhRBJOKVSNORrnaDreAFtTyx5/fBiLg8ZeN7puz5NZ8hg3JNt6IMkwFkS1KgThFi0pbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ytUngd5phrHjl84Ss5a6MhDwHAV5VGTksNb8Ue++HY=;
 b=XRS4sfHRSnL7ASKLTLT8+PXyTxhe7P7YoTJU7ER7p8bLsUW5ALlaiMS2cnLGRKhsMhx8BFEre/K+4H5Hw5Ak7zaKVjkrtiEpFnaMTl9fHmfQoi8NmyUNMYWkKOa+mc9FJs8ehXmcUjAUTN4WtWi/FnHN8/x/ZvYLh/VvWpD0Bsm/jE8u/oF43rNiAgvCOJ3t6tnSYrB0LEunbWu6CyTaDcL84C2n+sX6NXLWfm+UC2r79ITudcm82UG8u7UVX3cnZTK1HT1rNEhkM+b7RHPyQnnfRuxsbnaBLoSv9vXxPZkrHKDy6eqM+xOzJtXHQvNXjI7ALkMp3KTMNK9cpcryCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TYCPR01MB5936.jpnprd01.prod.outlook.com (2603:1096:400:42::10)
 by OSAPR01MB1555.jpnprd01.prod.outlook.com (2603:1096:603:2e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Thu, 13 Jan
 2022 09:05:49 +0000
Received: from TYCPR01MB5936.jpnprd01.prod.outlook.com
 ([fe80::4d73:10a:5d6:4b8d]) by TYCPR01MB5936.jpnprd01.prod.outlook.com
 ([fe80::4d73:10a:5d6:4b8d%5]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 09:05:49 +0000
From:   <Kenta.Tada@sony.com>
To:     <andrii@kernel.org>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kafai@fb.com>,
        <songliubraving@fb.com>, <yhs@fb.com>, <john.fastabend@gmail.com>,
        <kpsingh@kernel.org>
Subject: [PATCH v3 2/2] libbpf: Fix the incorrect register read for syscalls
 on x86_64
Thread-Topic: [PATCH v3 2/2] libbpf: Fix the incorrect register read for
 syscalls on x86_64
Thread-Index: AdgIW/c9i8qiwnzHScq3sR/b1Zfxlg==
Date:   Thu, 13 Jan 2022 09:05:49 +0000
Message-ID: <TYCPR01MB5936F73E6F6BD9FF338F4FE6F5539@TYCPR01MB5936.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc6413e3-051d-477a-6ed2-08d9d673e49c
x-ms-traffictypediagnostic: OSAPR01MB1555:EE_
x-microsoft-antispam-prvs: <OSAPR01MB15553172274F384C7ACC0BC0F5539@OSAPR01MB1555.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:747;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 61Al75AbI3p6HdiqQXJvUHOwzmeFvXYAYDzyHQqVyWyTRokN8DitC5q09R8JrHp8nyAxbODCKSqPYkpBMMJNLk1cTWOfjlePWBD285Iow2wSoVVfMjjiLNOGA23tad6WQRmxsdnK2x0EYSGc7LELqzttUVzUSqvkRJP1/8upE6vbLNlp0n27EfQmcK6B1OeIQmCIgoPsGAYM3FusCRQ2aYgdm9S12sbfUNx7uI7ILcOc+SRwKm5ZqNqjkiE0wcGE69qj4kEr2UGF7Lcz8O4FDSTXpodSyz/IH8wY1EJwyoibIB+S+8yAKNTGEeZ38FAj4u7NEBiPIW198HAkYalLZ+MS68trNJzqvH0scLPhYx80DvHAru0DgJDtMFsmGCQv6d7//DKG8vcS/5i0KuY5tNsS0qXHZlK0QW09gVMfDfGANhQCJaJFMuXLnvKjnrqfd2Yv0c+dVoqD/TmdDDMaAV9Cb5sxzpk4+lDMxEjmfjEer+nFS3AZZyO/d59zu25I3OzjZ8JujwlxhPEQIGpjxwdWQKEwA39Vje+Fs+7AJ5mTdSme+liaHbQhJsGhA0msAu+a3hKyPAX6i5C403UfwCQE+p5MhXvO1trVwjeFu26VFLFR51ZF8ZNysJWwcjKTojrkfDJKdzWviFTknxrAzm579eT8J6Nmw/BBg6uSwhEpvlNcjZ2lLkYpH84Uealr2Zf01ZB3AJ2IgvRn/sYCeGankQxita/oJicmqW6xNP4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5936.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(82960400001)(5660300002)(8936002)(55016003)(33656002)(9686003)(8676002)(52536014)(83380400001)(2906002)(66946007)(38070700005)(71200400001)(64756008)(66556008)(7696005)(76116006)(508600001)(4326008)(186003)(66446008)(66476007)(6506007)(122000001)(38100700002)(316002)(110136005)(54906003)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?miJ+qtrB5a8Zi04U4y1v7tpxXx/AWNGB+sa2hfmdd9cSMW0T0Ww19wXdoOKq?=
 =?us-ascii?Q?PCp3m9Un8mJeY1tWcLYqoqmfOQHUhv5cuGBxoRMQyRTV4E8UQXjvtuw92Xy3?=
 =?us-ascii?Q?luYAOpBIz5DxyiJQ05o3wUbOLw/NxpAFslubmDZz54lNFvkvKwP4lYa2oUT4?=
 =?us-ascii?Q?r593rqSFy98zrOOX8ktJTHqf1WTntsPjeE7YaHarjFcsMmv+wvtnj0aumKCB?=
 =?us-ascii?Q?YN0HIAp13qP3F1uR55pL8YDVYFBbKr9oHRQOoRW7Y6SUth4f8WDeTCeJIeu+?=
 =?us-ascii?Q?ZPd6+RN7BcH+TnstudTXyRHvZp4MVcwIXjhhthSlRpAsVrGevIUbPnABZpq/?=
 =?us-ascii?Q?R8YeHEh1WzMNgbGmI4oOdgCQytPavZe+ailUM+rS7j4vWF9JYmyrXZJn8FQG?=
 =?us-ascii?Q?GGDRA/pDe0OspZvhWoST4L8qnkR8BF8F8w+/mx2tLI9npGblYo1JZqo1cWT4?=
 =?us-ascii?Q?krkfn8Fr/gqcOgXuzugQ64VofuA0jy9KmCLSHMpNBehxJ5lMMzJWvB5ENjK3?=
 =?us-ascii?Q?YcdDuK/hsfZKuvcOOMoTqwut4R7CbWN9WQbs5eiVMYLY+8Al7evNhRVzZlTO?=
 =?us-ascii?Q?V9IGbaaKhaaBf9T3hVasU4Q5gQWaO89BD71oY5AremLvC8RAuk5m52RgTLKR?=
 =?us-ascii?Q?8Q+a+7zjWgo/oF0K+V4BhZJSLL8MEfQJx/B02nieGaxnRvbxEIIrkDeVJmmC?=
 =?us-ascii?Q?tL2Br5FHcwEAwz3Yn3ok4F5tPk+yTnY7hVzjmfmo+za9VjTc4m9Rk6pQTZpS?=
 =?us-ascii?Q?UbAyA3YUU2gb7Q+93Zixd5z27w/O9Ud/ip3cM+f0HYudotFXXZpJr7bjRPDt?=
 =?us-ascii?Q?T+6/lMYFRk+FG2qPYOmo3c172Ujywpqnh7Cn25Pnkul+ngukXdYk3PufPC7N?=
 =?us-ascii?Q?D6w9p8x5VHubadrcaCxO88KdiGJK2CjTMF19Zp6zFYs6zH40EUGqakNRbn2G?=
 =?us-ascii?Q?JQuqp+dBrp/BwG8lM5LKCw7o8T48ALLq97fM3tc6Rfs9GufFi5jOahK1hCBA?=
 =?us-ascii?Q?qN4sfQfKSY9BXQWnEd3Oax59ETL3+vA9+M38ld8jdxRTR0bXCqRTXH4tncFD?=
 =?us-ascii?Q?Oavu3gRDwKKkeKoNcbNjx1LuiSzLM1wLiwoI8oQtqYjp9/PYuAprpFKrmfA9?=
 =?us-ascii?Q?F9V7C/7qXsyuqeLZM/BCZTpUs9Emc35sbYBTPGKoixUMGq7wrwoM/bjxvky6?=
 =?us-ascii?Q?Fe79CDLhtRIhDHuAPVU2jzguh/9hFQe0fsY3WstGzGEKSInstezlpsxenjYz?=
 =?us-ascii?Q?GnmKz3zKwZ9gHfD6OhCfTLA+8pyySAn+CSe1BWsH71EX/JZ6oXRTMWpE2wu5?=
 =?us-ascii?Q?PgdxtQQtw+inV4MhxNAKooaeAqR7fggDMrrzfT9R7tAReIOKgXieAP4eoHtp?=
 =?us-ascii?Q?je35d1vQysWY+vwHdzLrijSIsqcnug3IOqRzcYK0kZ4xkrIizQbUz98Zu0xI?=
 =?us-ascii?Q?R2UctZHWyFRRDdbU2gZUiYiOJ7ZOH71Nal4aBucM6ubgq3PAilRj+gn3hyeu?=
 =?us-ascii?Q?EVe90tRR7elcdoO1ko2FVGSLNhjm30uN/W4I40yVVdE8+fSP4J5jHOaEl3VW?=
 =?us-ascii?Q?EAPcWoJvg/TQRIT8eDLF6nuno5XGyzqW4JWf4FsHF/nQkM/PaRw6XVEWPIYe?=
 =?us-ascii?Q?hJ7MUCDsqoL8e9waOGhaU2XesaTMHCEgvFxWIiwWYQCuT6xcg49ErxETg8pE?=
 =?us-ascii?Q?Ud4I1w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5936.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6413e3-051d-477a-6ed2-08d9d673e49c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2022 09:05:49.3426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ggw45LOOIP5pYe4P+hl33ackLebnDdd/MTDMZFQ1igzCYXndFo+Fg17HCTd8tHuSMXx91Jgpv1DalDEOUUnOxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1555
X-Proofpoint-ORIG-GUID: yLbxidRhk06BRboXicnvUhKHt0EUncMx
X-Proofpoint-GUID: yLbxidRhk06BRboXicnvUhKHt0EUncMx
X-Sony-Outbound-GUID: yLbxidRhk06BRboXicnvUhKHt0EUncMx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-13_02,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 malwarescore=0 clxscore=1015
 adultscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201130053
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a selftest to verify the behavior of PT_REGS_xxx.

Signed-off-by: Kenta Tada <Kenta.Tada@sony.com>
---
 .../bpf/prog_tests/bpf_syscall_macro_test.c   | 60 +++++++++++++++++++
 .../bpf/progs/test_bpf_syscall_macro.c        | 52 ++++++++++++++++
 2 files changed, 112 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_syscall_macr=
o_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_bpf_syscall_macr=
o.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_syscall_macro_test.=
c b/tools/testing/selftests/bpf/prog_tests/bpf_syscall_macro_test.c
new file mode 100644
index 000000000000..cd7133954210
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_syscall_macro_test.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2022 Sony Group Corporation */
+#include <sys/prctl.h>
+#include <test_progs.h>
+#include "test_bpf_syscall_macro.skel.h"
+
+void serial_test_bpf_syscall_macro(void)
+{
+	struct test_bpf_syscall_macro *skel =3D NULL;
+	int err;
+	int duration =3D 0;
+	int exp_arg1 =3D 1001;
+	unsigned long exp_arg2 =3D 12;
+	unsigned long exp_arg3 =3D 13;
+	unsigned long exp_arg4 =3D 14;
+	unsigned long exp_arg5 =3D 15;
+
+	/* check whether it can load program */
+	skel =3D test_bpf_syscall_macro__open_and_load();
+	if (CHECK(!skel, "skel_open_and_load", "skeleton open_and_load failed\n")=
)
+		goto cleanup;
+
+	/* check whether it can attach kprobe */
+	err =3D test_bpf_syscall_macro__attach(skel);
+	if (CHECK(err, "attach_kprobe", "err %d\n", err))
+		goto cleanup;
+
+	/* check whether args of syscall are copied correctly */
+	prctl(exp_arg1, exp_arg2, exp_arg3, exp_arg4, exp_arg5);
+	if (CHECK(skel->bss->arg1 !=3D exp_arg1, "syscall_arg1",
+		  "exp %d, got %d\n", exp_arg1, skel->bss->arg1)) {
+		goto cleanup;
+	}
+	if (CHECK(skel->bss->arg2 !=3D exp_arg2, "syscall_arg2",
+		  "exp %ld, got %ld\n", exp_arg2, skel->bss->arg2)) {
+		goto cleanup;
+	}
+	if (CHECK(skel->bss->arg3 !=3D exp_arg3, "syscall_arg3",
+		  "exp %ld, got %ld\n", exp_arg3, skel->bss->arg3)) {
+		goto cleanup;
+	}
+	/* it cannot copy arg4 when uses PT_REGS_PARM4 on x86_64 */
+#ifdef __x86_64__
+	if (CHECK(skel->bss->arg4_cx =3D=3D exp_arg4, "syscall_arg4_from_cx",
+		  "exp %ld, got %ld\n", exp_arg4, skel->bss->arg4_cx)) {
+		goto cleanup;
+	}
+#endif
+	if (CHECK(skel->bss->arg4 !=3D exp_arg4, "syscall_arg4",
+		  "exp %ld, got %ld\n", exp_arg4, skel->bss->arg4)) {
+		goto cleanup;
+	}
+	if (CHECK(skel->bss->arg5 !=3D exp_arg5, "syscall_arg5",
+		  "exp %ld, got %ld\n", exp_arg5, skel->bss->arg5)) {
+		goto cleanup;
+	}
+
+cleanup:
+	test_bpf_syscall_macro__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_bpf_syscall_macro.c b/t=
ools/testing/selftests/bpf/progs/test_bpf_syscall_macro.c
new file mode 100644
index 000000000000..002889d506cc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_bpf_syscall_macro.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2022 Sony Group Corporation */
+#include <linux/bpf.h>
+#include <linux/ptrace.h>
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#if defined(__TARGET_ARCH_x86)
+#define SYS_PREFIX "__x64_"
+#elif defined(__TARGET_ARCH_s390)
+#define SYS_PREFIX "__s390x_"
+#elif defined(__TARGET_ARCH_arm64)
+#define SYS_PREFIX "__arm64_"
+#else
+#define SYS_PREFIX ""
+#endif
+
+int arg1 =3D 0;
+unsigned long arg2 =3D 0;
+unsigned long arg3 =3D 0;
+unsigned long arg4_cx =3D 0;
+unsigned long arg4 =3D 0;
+unsigned long arg5 =3D 0;
+
+SEC("kprobe/" SYS_PREFIX "sys_prctl")
+int BPF_KPROBE(handle_sys_prctl)
+{
+	struct pt_regs *real_regs;
+	int orig_arg1;
+	unsigned long orig_arg2, orig_arg3, orig_arg4_cx, orig_arg4, orig_arg5;
+
+	real_regs =3D (struct pt_regs *)PT_REGS_PARM1(ctx);
+	bpf_probe_read_kernel(&orig_arg1, sizeof(orig_arg1), &PT_REGS_PARM1_SYSCA=
LL(real_regs));
+	bpf_probe_read_kernel(&orig_arg2, sizeof(orig_arg2), &PT_REGS_PARM2_SYSCA=
LL(real_regs));
+	bpf_probe_read_kernel(&orig_arg3, sizeof(orig_arg3), &PT_REGS_PARM3_SYSCA=
LL(real_regs));
+	bpf_probe_read_kernel(&orig_arg4_cx, sizeof(orig_arg4_cx), &PT_REGS_PARM4=
(real_regs));
+	bpf_probe_read_kernel(&orig_arg4, sizeof(orig_arg4), &PT_REGS_PARM4_SYSCA=
LL(real_regs));
+	bpf_probe_read_kernel(&orig_arg5, sizeof(orig_arg5), &PT_REGS_PARM5_SYSCA=
LL(real_regs));
+
+	/* copy all actual args and the wrong arg4 on x86_64 */
+	arg1 =3D orig_arg1;
+	arg2 =3D orig_arg2;
+	arg3 =3D orig_arg3;
+	arg4_cx =3D orig_arg4_cx;
+	arg4 =3D orig_arg4;
+	arg5 =3D orig_arg5;
+
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.32.0
