Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F7D48D4EE
	for <lists+bpf@lfdr.de>; Thu, 13 Jan 2022 10:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbiAMJWq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Jan 2022 04:22:46 -0500
Received: from mx07-001d1705.pphosted.com ([185.132.183.11]:52240 "EHLO
        mx07-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234077AbiAMJWn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 13 Jan 2022 04:22:43 -0500
Received: from pps.filterd (m0209328.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20D2TQqa014121;
        Thu, 13 Jan 2022 09:22:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=3ytUngd5phrHjl84Ss5a6MhDwHAV5VGTksNb8Ue++HY=;
 b=G08Q1QJoskrhp7vV1ZfRiUKxRC8TSjO7nnU+h3N/Bzuv4xc/Q2f29Som/jhT3oG17TKg
 vJ7qJiA8kHcmOVp3BNF/97BCJ3ZCUDEz1YsnX/NRe+yvIh78+1+CHtyxX2v5Y0LTpf2V
 vzz5sECPTTRt7jBlDZ9KMHeWmu6RXVdtdgsOi+vla5aAxRAZzD2ECFTvf7rlUKAiQeRy
 5a+aLRiHj3BTDT3ENWau92LJvuNxvP1yTQyVOYcyMuGN1pjIEJZV8I4Qb2puqTZ05vkl
 cZAalW6N7i3XXkj5PCc1gdlIPcsHYw5hcYz7THwoMKPAaZvDQFRjWABC7KjZJTX7LLtH 9w== 
Received: from jpn01-tyc-obe.outbound.protection.outlook.com (mail-tycjpn01lp2176.outbound.protection.outlook.com [104.47.23.176])
        by mx08-001d1705.pphosted.com with ESMTP id 3dj0dwh5ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 09:22:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i88vKyXWjaAkOgJ4Ghl6ITdeNhE0gwhE3JA4mzTTEVOwlcdaw9oAlKRerO67LbCWahcIMtIG2vW09LInCx5iH4maqurAaApuvyxQkmY8VQKFfxboyu4lyVPsWGBnBLrRwWFgp4hAPRor3jkpg7+jL+lONOUtdigiZXY2xOZ1W7RH5r+v56xI5uaGG4aqQfsHOWOUrgpo5gOf7WzQMMfgwWpUkN1PakbrxRMcKrGez2HIpcc9TyKsTNmu+weePOqltbSPT4uCnPgM1IOAlDOu0OI/4viNi7UPDs3hFQjtuf8KBAhxeXy1/bTChB3+lHPmJ93PlRX86J5EglE1xQxNfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ytUngd5phrHjl84Ss5a6MhDwHAV5VGTksNb8Ue++HY=;
 b=kRBvoMaYkzqZMjqwNlW2oew6YrUJN0hCyzUEzB+l3wmCLBmwbCTOrxqDdvxcD6ouYavqCVSroS4yzEFA07eACHAgQbsCe9HlUw3EfQONpdZCHhPhe0wGziwufH1CzegMb7WTct/KoBuAppDE7B0Y44qdmXw0w9VVCxO9ovQx3cqQzbsDp1G5vG8k6HIXiOVZ/vJetipE1uqUT2RBVOEn9qnBK0io9iM3lrxvHINQKhtkXL9A3SGQPzIlG/64s3hHrT1Ye5I18ooVFY/4NMvVPiPFXeZjZAfMHVI/PYVg3A+nYSBImIw/gRfsFI7s+3x2JEagcsAgxfT7opMTtXwrQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TYCPR01MB5936.jpnprd01.prod.outlook.com (2603:1096:400:42::10)
 by TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 13 Jan
 2022 09:22:14 +0000
Received: from TYCPR01MB5936.jpnprd01.prod.outlook.com
 ([fe80::4d73:10a:5d6:4b8d]) by TYCPR01MB5936.jpnprd01.prod.outlook.com
 ([fe80::4d73:10a:5d6:4b8d%5]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 09:22:14 +0000
From:   <Kenta.Tada@sony.com>
To:     <andrii@kernel.org>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kafai@fb.com>,
        <songliubraving@fb.com>, <yhs@fb.com>, <john.fastabend@gmail.com>,
        <kpsingh@kernel.org>
Subject: [PATCH v3 2/2] libbpf: Fix the incorrect register read for syscalls
 on x86_64
Thread-Topic: [PATCH v3 2/2] libbpf: Fix the incorrect register read for
 syscalls on x86_64
Thread-Index: AdgIXe110qRfuYaHR4eLcykCXCVsWg==
Date:   Thu, 13 Jan 2022 09:22:14 +0000
Message-ID: <TYCPR01MB5936D0E5108C1EC7A5939A7DF5539@TYCPR01MB5936.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d34bac52-62b2-4eab-85f4-08d9d6762fdc
x-ms-traffictypediagnostic: TY2PR01MB4427:EE_
x-microsoft-antispam-prvs: <TY2PR01MB44277A3093A86B98A3F802CAF5539@TY2PR01MB4427.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:747;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CvWhUPEMcJaHP4mNZbNtny6LOFzRmfj7fjBaXvU0AJhVnFnJ8q1QTpwxS6GDeJeMIYen+g+OAJMRTCNrCEp0VECHr43tHtmbK/wSnZubH1dXanKrDKPAA+BXAqbPy/1/TWddotyFI00wPkWQExnvVaC43Xi/PFqg4uYxeD4wr/j1RMQLr+GYpOJbFLvfV+lBr5/QySjnAvBhOsaYZYjm0EuuBihmkkx3FULpZvaBovTJPO1KfprqVcPHDAHyioNR/q4JFLqZoIQ5Z0oR1yKvgMTX/ZLpv3TgO1P5o2RLhjUG/UTHFKQS/4aBX0Kgs60/tgoPzJQgxQ1vG8LNKxRSW5mLlGrawCyMzriyNFQxQwRtSFVQAS4PmpLn520IXyMFs3vAr9fDpmfUGwaO6oPsabxmxhlSxfc+gUNmOgF7Ky8DQZViFHHVoyIDr/soMplPMQpxACNo7a/fqS2BMgKfewlIW4UYKnKwezM/Nb0pxFXPEjxvg7B3ZQpS8MTFdzxPQRNHujMFsQSEH4hsiaQRu+UfFMiS0ITbTFSq7M3VYT2DmoKqD0GPYJV56pupgpBYS2W2geg8a0PrelAkRNJu5uHVdkIszHstqEF2XAgjFAlAoNeozNb9B0KvytZjhRCwpejCOdDFGaU8tKQW8PuI+y9Phyj+F2OAwVF9sYue1pj3tSsK2jHrVwHuPAD40ghWGmMXmEqPUK9c4BJ3VpSD9exuzId7YgOXpNrIlIEi1n0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5936.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(186003)(38070700005)(6506007)(8676002)(83380400001)(33656002)(82960400001)(86362001)(55016003)(122000001)(38100700002)(66446008)(76116006)(5660300002)(54906003)(52536014)(2906002)(508600001)(64756008)(9686003)(66556008)(316002)(66476007)(110136005)(66946007)(8936002)(4326008)(71200400001)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?12/fJyPPLFnrZY0cVay6cWP/C+thSCMvEdBZt1xHKg6BN0GC1zmWjOglxYRA?=
 =?us-ascii?Q?bl5jVbspJp/hU1AKKFlw4uS4VBXiB2Sbx3yt1l4u5YZxqJcVd2LPK5UZEMRU?=
 =?us-ascii?Q?7xRxLJlSDOWS7FtzcEBr6VISW92bJixHXv4xB1a3A7Q51MoEy2rAHObRUEIf?=
 =?us-ascii?Q?Sl2XtnrUnL0sOT/q5upjnbrcBoPRYOO4Q7MrV6p+PdGDV9h8b7+yIo0Eu8gm?=
 =?us-ascii?Q?7JmemVbiaTZ+/XqAtxlTOrkG6JVnKwWX/VcdgChCgZstHxZXqzfOdC+Af8XY?=
 =?us-ascii?Q?QyCQIh467hwAYmjXh2+W7VMJnkSfYZup7j1bqP8z7W0IX8E+Qvq15hTC4p34?=
 =?us-ascii?Q?G6gELPrIpWQKtIySEUPWNNRaitFfKI91+0njRIQwJTL0kjjoEmZ3FQWz3mqC?=
 =?us-ascii?Q?zq5flyVZOz2C2yemGjAacd+CRTZ1RkLyJtXaAZ6VwRUm7za41E+vo7uwmgeI?=
 =?us-ascii?Q?grkjY7oPO5cwiWcpoYov9laSW/7HqxWWmRxfCKhuMRm29SFXwFiUhSQFmkX3?=
 =?us-ascii?Q?bmo3DXngQasceG3BGhcg2WHjY2RtyXoc0YmBqRUcA639RGz+weq8qwOtQNTc?=
 =?us-ascii?Q?iOZU5wGbJCzW5jeo4TkPCzQZ/o5VmYGwvfZIoFd9YbQFC/802lKFxVfSC8KI?=
 =?us-ascii?Q?YcEGkpYWhYW/QsROVvlgaqwEuk+OSeib4isAdAISQjBA62S940Q4kmT1H543?=
 =?us-ascii?Q?uYumDqTuiQJFrzytEdn5jh3UxrWJEUz2sVrjHZNdZvU5smTtFA4rOUF5Udy0?=
 =?us-ascii?Q?blQqQvAe+urT9MSuIIvq9Kq6lmsoLTjcjxJqVQWRgboq0jN+qk9bcBCfod40?=
 =?us-ascii?Q?59Hg1uIhNXzpjjBShxqCExQkHOGVWYphzWxVv+CUZr7PyzSQ9NeZ2j6CWx4+?=
 =?us-ascii?Q?qpER0TTnBNh1BX8orIDNoZUsxBsOnJGASGtR7l1+5sf8Qj8DuxG5e1bvnF7Z?=
 =?us-ascii?Q?IYnbNKK5E9vVyNsGPTU+vQHx+furHcpuq0ZPtzbHW9/HFbzVp4dRqsFSB+IV?=
 =?us-ascii?Q?9HFJnB8AkSNWb0gSRT+3H9io3PuUEY9aQnpms44LLivgYpJASFWl3TGmzfqf?=
 =?us-ascii?Q?n4iRIutmF9DW9Ysk5L5MQQphGJ5HwRIg1sjJBfSHO3ceteOzx72ngapXnGvc?=
 =?us-ascii?Q?+/EC7zPUohQcFJHbXi6lB8yjxxFftem84yK23UwXYvSRPozuix1tSJ3dFUaw?=
 =?us-ascii?Q?CO5eV1IlwjSTGrcJNYuJOu/DVwXuFmAloXvwDFN26SHw1CEMd61p7PG+coY2?=
 =?us-ascii?Q?yjMu31ShlaAEObvczn/Sv1xE4lN08S3Pojoad0JkW3uYkMZTLLZZrp3t01cg?=
 =?us-ascii?Q?Nmx0N7aMQ5sH2a4kYKhWLz3+SHHqMphJMC93GX1xp6QpROH00y0qh4do+1mI?=
 =?us-ascii?Q?jg6lK2+XNt+fKJyAuRq4hk0+E0tpMu1UaTv73LAva6LzT9483BcY1oWVb30x?=
 =?us-ascii?Q?PeFcB8hzAMZcK370+/jTl7c0v1TSdiDJVcugtRS8WVJMEGIfM/IperNi9sVM?=
 =?us-ascii?Q?hLKpL9K21Tx1PqUM3KTeGxvtTGMmaLnV2Qpmfm8fAgRE/MJ8R1SRkaeBoCeT?=
 =?us-ascii?Q?1fA2C0SWoALA8unlmvhk3GdY3g0Rp5sSOvPa42czDHqMIxccv38CtLa2Habc?=
 =?us-ascii?Q?80eezqhunMj6pcNxNDiZ+TJ9eN6KdHR+7a7koi4gnxjTTjxBXyNmys0edF8j?=
 =?us-ascii?Q?TqKS6Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5936.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d34bac52-62b2-4eab-85f4-08d9d6762fdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2022 09:22:14.5852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AYp1K4xiou8CYNQnjTCjuXJbrtuTJxCtnVX/Bf9r7W7A91iR3QBt/dqM5qlMKti79on0fVRmqgXhQfKcERa9Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4427
X-Proofpoint-ORIG-GUID: lKSHpdqeI2dwd-15qYEYrRr9tYXvXk_B
X-Proofpoint-GUID: lKSHpdqeI2dwd-15qYEYrRr9tYXvXk_B
X-Sony-Outbound-GUID: lKSHpdqeI2dwd-15qYEYrRr9tYXvXk_B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-13_02,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 malwarescore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201130054
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
