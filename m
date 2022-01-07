Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE260487097
	for <lists+bpf@lfdr.de>; Fri,  7 Jan 2022 03:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345509AbiAGCjg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 21:39:36 -0500
Received: from mx08-001d1705.pphosted.com ([185.183.30.70]:41240 "EHLO
        mx08-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345477AbiAGCjc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jan 2022 21:39:32 -0500
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2071icOT011776;
        Fri, 7 Jan 2022 02:38:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=BSXuWKzfGcKGnuamGna4DciIcutzYl/l4IcvFmoq+1c=;
 b=OVTdtEW09XI/L2pvre93TLmzukoex5n85i1k+4Swmw5qIA3eYkwSHVszbt/l44EprL0y
 XSIvOdnT5AtnP2obgjlhIVR3xtDuiv0bvHXBokZg3ZANzEfUU5LIkwHT5BPGNOUetf80
 3FmYTWOAK0ncvb9GrSGDxxXOD2pc33agOHMkoYVG45P/6AmvALPLvNi4QRZfDNAtMGvu
 tMN/g1S7RaK8SAgGLVxfbwQy1cczQV/fDKojM1WcjLPFdG2/M2jYl/+6os37vyhFPfPb
 x9T+y/NlZ8IvB1ZcdRx/DDTMcJWQiMiibmSWOJF2YGQ4paxm7KJyQID/E5TjOipJrswb jg== 
Received: from jpn01-os0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2110.outbound.protection.outlook.com [104.47.23.110])
        by mx08-001d1705.pphosted.com with ESMTP id 3de4x68d8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 02:38:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtrGtxIHtf4vV936TulUL9y+oryADjNeURrW9F769CzcenuKHs1DH819AJYpsvQL7aH1LYsJxpc+KE8+bhktJwyYDRZAkYUR+retrl4L5gBZDnfJQT/Oac/KdgZqHUV26uX2AexQ5SKuJddj99cOkxjir+1kAQYpZsxqjJwH4v6rAcSTy/CWm9XusdNuVvIACdJiOCUU2VcUNMRjlaaD9nN0XHuxZmlzq6WrkKpm175b1hXd5ErYE8eYqzNplc2cxnqNP2patCr/vWpcBuK1jDdv4J456i6DAFSXj6B5cI/aAGq8sHBBeqUoDP9wV9/8kaQKgTKBNdlNDHOL+XLSyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSXuWKzfGcKGnuamGna4DciIcutzYl/l4IcvFmoq+1c=;
 b=VW7C5cwTq2NVAIBWPyvnoNuS7BY8REQOxbneTiVzgo6I19+MbZR6TALyA8ZW3lOUqEAnUpdbhj3sBfiIEI6NnVgsoZiQ3SBo/6VuD6pK4uSo8gbFJEw4x9xO6oRcUISztM2lBhzinB+BBSH7R4IUsIhuFbDnzksI6qL02NcvOYrHrcZlNRI1aw/EXiD9PHIX+JTD4eT1Ultn7x0rDADEPBlo22rMUXUxSfuf6QSc0OPPGu0eZ7OFZ+8m049C5G+QGyToDHikkiHqPXSsJ/ZYi30Il9/uuoXReT1zLzK46rfjGWIeuz9eqiYMq5Jxmu19Q1VqAiOsvADIohEunV3N/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TYCPR01MB5936.jpnprd01.prod.outlook.com (2603:1096:400:42::10)
 by TYAPR01MB2480.jpnprd01.prod.outlook.com (2603:1096:404:90::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 02:38:50 +0000
Received: from TYCPR01MB5936.jpnprd01.prod.outlook.com
 ([fe80::f814:f7e:f65c:3147]) by TYCPR01MB5936.jpnprd01.prod.outlook.com
 ([fe80::f814:f7e:f65c:3147%5]) with mapi id 15.20.4867.009; Fri, 7 Jan 2022
 02:38:49 +0000
From:   <Kenta.Tada@sony.com>
To:     <andrii@kernel.org>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kafai@fb.com>,
        <songliubraving@fb.com>, <yhs@fb.com>, <john.fastabend@gmail.com>,
        <kpsingh@kernel.org>
Subject: [PATCH v2] libbpf: Fix the incorrect register read for syscalls on
 x86_64
Thread-Topic: [PATCH v2] libbpf: Fix the incorrect register read for syscalls
 on x86_64
Thread-Index: AdgDbmTY/BRuEK6oR7OS3JTt6yRDPQ==
Date:   Fri, 7 Jan 2022 02:38:49 +0000
Message-ID: <TYCPR01MB593665A2C1E6C39169D10377F54D9@TYCPR01MB5936.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2126972f-5048-4dd0-528f-08d9d186d603
x-ms-traffictypediagnostic: TYAPR01MB2480:EE_
x-microsoft-antispam-prvs: <TYAPR01MB248067353647502CF25F22D7F54D9@TYAPR01MB2480.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:561;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mX50ABgpM4TE9S2nee5fI1wPmTjGmKXwyFOdTMyza7rCP80OH7nyDrbvxQL4yC3A1ED0tsZVPgddTfVVR1MySmczoYKm+jYRwJm7v+apjLvg7C085V82lLFAx1TrsFVLElvu/mqLU4ZEsVPwLhuz7zZJZhh5J837hMkFa7tgHHT9gf62s44Guzv5G2QlqIo+bZssNUcKkS55pG8ZZ/hwVrDNNHY4Ip6w5tECq/iXWt0EUOGeuwfTosSd4/BzCn2tPevK2a4DmKjLjnHG/YjqnUZKXGHSeZLQkStAZRgOyJKdP3u3wXZonh01a8nmPoH5cjo68YeMFYtB9PSnjYSx8kTnxuh/+xY5qhmEOlGoXudM+cWYAyEmBaXf2h2/fy+56NVu4BNnFY7efnpo8fdbLIlFhknuVcKVWXndBUntzRfPkrDBGJJ3TbE5u0MIwVEehus+nVT9DBC9s2Kg0NPHjFBIqXa3uMJEBR7B6Y/R0Y4h4/9f4/3JFYodBM3QQXbjhK+DV9SUUuXYpl3vt9MTUFRs0jbOSFZI1zBRYE9aNyemz4zI6PAG28wGUpmLOQAhtfuHN2DXdTYyR860i+uipZR7OGFjnWYTO6/+V6XkHqm4PBAXZ51Id0fAzgFwx5VdrLfchDQ6WmPx/iSeNZyyJkWv3XlgGP/Ax7eYc7wmyqj1VBlgCAARXT411iGzPN+lv5mew8cu2usQj90TtHiXqOHwQtGRoSjSnwD/OMjArgXDyjWacNUtDEDlzCyyNhAghLYUKo5hCQCwegwJKbMck+Rw5cbJmkqlkkubrtx5pAo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5936.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(55016003)(52536014)(4326008)(66446008)(7696005)(64756008)(9686003)(966005)(66946007)(508600001)(186003)(76116006)(82960400001)(66476007)(66556008)(38070700005)(71200400001)(83380400001)(33656002)(122000001)(86362001)(38100700002)(316002)(8676002)(8936002)(54906003)(110136005)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i4OGzHYBxI2j87CYDJE/WPSL6WAx01iHg+TX7K9uVNo6++LGdG6oFSbWLwBB?=
 =?us-ascii?Q?r0/H581I6oFKZ92LOmXjaRqMZnpugypiIhmIS8gq+W3TmAwF0gTOR378wFYc?=
 =?us-ascii?Q?IFp63PL2KSEd3nW/y1HJUC6Hja3Tcy5c2johDQWv3TJsyFlg34XH8e/qf5yD?=
 =?us-ascii?Q?xiE5+zz0FbMfRYR97L7rjH2grCnULcjsYKo7l1ihVS5nEKgdrW4ISLh/Tu1Y?=
 =?us-ascii?Q?sMoJxoUWb10bVIS4ol6OgjG9Jd0q6hnri3sqXr/L5LRf5QzvyqCxe7F5Udow?=
 =?us-ascii?Q?WuP0x2fx6PGjHLdCH86O3LoeSk10AZwNDJ5IfdgMMy7LCq9zNpt1KHPM71Cz?=
 =?us-ascii?Q?YjvPCv5uXf6Tkn30rfpXwCcIDgCy8Tj9Gtzq43j8I+8X14d/QIbETEmPVPDH?=
 =?us-ascii?Q?WwCANSQgKam08uevajpF5rpnxkYceknK4eSiBSst81TglVeau8WV55eaVeyg?=
 =?us-ascii?Q?YMEQ5kZCq3abDYp8RH2wvcg0Zq8QF6kECu46DEMfvr2SEqMtnTKPRrzSGonO?=
 =?us-ascii?Q?epRlXAT5cqXCOU89eZMYkJY5EYsvxfeOn6vGWjCP+lyCmIlCwwjvrzUrsedo?=
 =?us-ascii?Q?/Xe2rq+heIGC7/1b9Kq8JTmzeP3FcTiwqN62xdeRNSWbkT9PNnTENNtnR+wa?=
 =?us-ascii?Q?/KrqCbkNB/EkO8Dx0a9KIcf5aSaPLrFTBWGbUpfqtEM0kwVMhsghuJGoFMYh?=
 =?us-ascii?Q?QR9sfS3zbVp5OH5sz9zcuvEMfbrHO8FPAiy25epKIznr7zV6CrHN7MFtHTUq?=
 =?us-ascii?Q?XITdxQinVrWkoyWdBJZMOH2ly8TvW5NSQS94WN3b0KQPZEWn+PuI4nqzOXyX?=
 =?us-ascii?Q?QJeh2naIKZcPBnedfOT+Do42AV51SQOigggcmkf6FK4dkVMPn4gH9IgSeUbB?=
 =?us-ascii?Q?vM8dcOXJAStInZYS8POdJor6zFF1opeU4GaZ2lkOISAlwiq10JUAUnyWaJyi?=
 =?us-ascii?Q?E1WzGbSG8bMe0RKjyx411OylFGmJ4FFTi0Laz5NcD2a5bsoIGyDPTzrAPbb2?=
 =?us-ascii?Q?axYE31ek8B1aS6f3Eu+iff7IbME5M/tFovoNCzHx8PqY0//DKRaECiy18tun?=
 =?us-ascii?Q?1G+7hHohT62uv6u9dv3q8l9pfWpfhYgeqOLZLCbQztSKy2Yc3B97vCCmXorM?=
 =?us-ascii?Q?Lx0Gq2RflHLs9RJjhNTtDU5xgQPIXEHnruiBeXb9XkmXb3MpQIcxRQdeANuy?=
 =?us-ascii?Q?5gu/wEVBQFdFNRaZfQmHtKcf2prVJt7Ae+WB3ToQB3rb8e3qqQOE6CaLGBZ4?=
 =?us-ascii?Q?adO/kUX8Dfezi/0ZI991gnn1o23LrAdUnL2KW/Ufh7XxcYmkglH+soiS3W4G?=
 =?us-ascii?Q?0uaQ5vCQjpsyra5uODMpGw10X7rQ0n+XHYAjS+g6kdtyL6tzglVm12I2H0N6?=
 =?us-ascii?Q?5PBnNILJR4FuzjvOKYPoa2FR7XsbE8uHZpgAta8GeKtonI/FXa/0oPPTG8LS?=
 =?us-ascii?Q?TSvh5400V5Vjhw+HX3dzs9f1pkE2ALsMiCYzBYugQT5Ee8isoOuQCpSMvkKC?=
 =?us-ascii?Q?XiywoM5iArFC9j+HZzA5y0SVAePvGQdx+4awzKVvKiJt4davz9UFd62GlViA?=
 =?us-ascii?Q?h2OPRxJeiOAS/PfmJ+W11mDi/Hn7EXe9cHpQe7V5cgOpMwneZfk+apcEgBut?=
 =?us-ascii?Q?Y7Zy3KNZM8Wm7RjEw9FTgS7P7oSMW85gZ21n9kbOyZUyoezQnRm1mLilQnl9?=
 =?us-ascii?Q?qKs2DA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5936.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2126972f-5048-4dd0-528f-08d9d186d603
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 02:38:49.4750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cpB9iarc/Ssn2VKVH8V+I52WplFnwCUydbEaXdKDv/zpW/RQk5NFhqFWuIwjku8hkK9rfV+ZNhfoCaFv3cdy3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2480
X-Proofpoint-GUID: izGyV6ykxYS3Rr5fdnoXr4lqHmen_ZgE
X-Proofpoint-ORIG-GUID: izGyV6ykxYS3Rr5fdnoXr4lqHmen_ZgE
X-Sony-Outbound-GUID: izGyV6ykxYS3Rr5fdnoXr4lqHmen_ZgE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-07_01,2022-01-06_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201070015
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, rcx is read as the fourth parameter of syscall on x86_64.
But x86_64 Linux System Call convention uses r10 actually.
This commit adds the wrapper for users who want to access to
syscall params to analyze the user space.

Changelog:
----------
v1 -> v2:
- Rebase to current bpf-next
https://lore.kernel.org/bpf/20211222213924.1869758-1-andrii@kernel.org/

Signed-off-by: Kenta Tada <Kenta.Tada@sony.com>
---
 tools/lib/bpf/bpf_tracing.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 90f56b0f585f..4c3df8c122a4 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -70,6 +70,7 @@
 #define __PT_PARM2_REG si
 #define __PT_PARM3_REG dx
 #define __PT_PARM4_REG cx
+#define __PT_PARM4_REG_SYSCALL r10 /* syscall uses r10 */
 #define __PT_PARM5_REG r8
 #define __PT_RET_REG sp
 #define __PT_FP_REG bp
@@ -99,6 +100,7 @@
 #define __PT_PARM2_REG rsi
 #define __PT_PARM3_REG rdx
 #define __PT_PARM4_REG rcx
+#define __PT_PARM4_REG_SYSCALL r10 /* syscall uses r10 */
 #define __PT_PARM5_REG r8
 #define __PT_RET_REG rsp
 #define __PT_FP_REG rbp
@@ -226,6 +228,7 @@ struct pt_regs;
 #define PT_REGS_PARM2(x) (__PT_REGS_CAST(x)->__PT_PARM2_REG)
 #define PT_REGS_PARM3(x) (__PT_REGS_CAST(x)->__PT_PARM3_REG)
 #define PT_REGS_PARM4(x) (__PT_REGS_CAST(x)->__PT_PARM4_REG)
+#define PT_REGS_PARM4_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM4_REG_SYSCAL=
L)
 #define PT_REGS_PARM5(x) (__PT_REGS_CAST(x)->__PT_PARM5_REG)
 #define PT_REGS_RET(x) (__PT_REGS_CAST(x)->__PT_RET_REG)
 #define PT_REGS_FP(x) (__PT_REGS_CAST(x)->__PT_FP_REG)
@@ -237,6 +240,7 @@ struct pt_regs;
 #define PT_REGS_PARM2_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM2_=
REG)
 #define PT_REGS_PARM3_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM3_=
REG)
 #define PT_REGS_PARM4_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM4_=
REG)
+#define PT_REGS_PARM4_CORE_SYSCALL(x) BPF_CORE_READ(__PT_REGS_CAST(x), __P=
T_PARM4_REG_SYSCALL)
 #define PT_REGS_PARM5_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM5_=
REG)
 #define PT_REGS_RET_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_RET_REG)
 #define PT_REGS_FP_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_FP_REG)
@@ -292,6 +296,22 @@ struct pt_regs;
=20
 #endif /* defined(bpf_target_defined) */
=20
+#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1(x)
+#define PT_REGS_PARM2_SYSCALL(x) PT_REGS_PARM2(x)
+#define PT_REGS_PARM3_SYSCALL(x) PT_REGS_PARM3(x)
+#ifndef PT_REGS_PARM4_SYSCALL
+#define PT_REGS_PARM4_SYSCALL(x) PT_REGS_PARM4(x)
+#endif
+#define PT_REGS_PARM5_SYSCALL(x) PT_REGS_PARM5(x)
+
+#define PT_REGS_PARM1_CORE_SYSCALL(x) PT_REGS_PARM1_CORE(x)
+#define PT_REGS_PARM2_CORE_SYSCALL(x) PT_REGS_PARM2_CORE(x)
+#define PT_REGS_PARM3_CORE_SYSCALL(x) PT_REGS_PARM3_CORE(x)
+#ifndef PT_REGS_PARM4_CORE_SYSCALL
+#define PT_REGS_PARM4_CORE_SYSCALL(x) PT_REGS_PARM4_CORE(x)
+#endif
+#define PT_REGS_PARM5_CORE_SYSCALL(x) PT_REGS_PARM5_CORE(x)
+
 #ifndef ___bpf_concat
 #define ___bpf_concat(a, b) a ## b
 #endif
--=20
2.32.0
