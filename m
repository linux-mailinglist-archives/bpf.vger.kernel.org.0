Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B614D47BED0
	for <lists+bpf@lfdr.de>; Tue, 21 Dec 2021 12:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhLULWi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Dec 2021 06:22:38 -0500
Received: from mx07-001d1705.pphosted.com ([185.132.183.11]:37146 "EHLO
        mx07-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237087AbhLULWe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Dec 2021 06:22:34 -0500
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BL8nvOM014624;
        Tue, 21 Dec 2021 11:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=D6CT8jt/MS0pBVJncQXtki20Wm4hv0zbYsGpyLI9aoY=;
 b=JRJSgq3hQaLC5Xk/KuKdAR9ZZXmRHT8EBiGGRn6YZrdvGDsY5fY9TKIDUuZbzlKX0dtc
 YgKebqCwaEF/PCXTYZhD3t8sMnlxYa3vaksLsW/UKjsv7ZKMG80adDQ4xyZ0dZLI6UJ+
 cP3U9aYyoA27zP2EqsZQbXJe89XTXx4f59e2Kc6YxJLsTw2N9cUqYkUSz3523dtD+n72
 cLEtUaILw7S/HRuvgTPaUWuqbuWwvWFqfSzA3uu8PvEqktOS0APYKDtWFP+G2faXeH2O
 ByBZC4VnYCXQjtBL7ut43eHecVe+YJNf6jjbygs3h3aPBE6Lv6QTjIUXph4zwUL7CQJk jQ== 
Received: from jpn01-os0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2109.outbound.protection.outlook.com [104.47.23.109])
        by mx08-001d1705.pphosted.com with ESMTP id 3d15uj2bpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Dec 2021 11:22:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAeppax8VdXiWqwy3hhItPDUtZrano48WykKCS6FhRQzB6o10AX5gxQsKvQgorHwx2gSW/B3zgaub30yaCu654Q1mwsp7mzeFfFXEGYMdjmvXQDZjPeW62JvRjM9fCx04dkacDlxyyezluMQkqP8mVuqAxKusQyxE3f9W+J1Ebdyp/eCvoT8icHcRcComj3+kPiJVJ1EeKnNJCN5qkmr7LKqrbbB5LQEhxZYier1Y/4TXDwi3HC8YXD5s6Zw9X26NT+ghyw7NbbmDuo2dMy4GOrpLxJmaBqDDf2flkjC6eW800RWm2fD6fdA0SNsOQnjpysJyN4KHjrwxM/k/ZJCOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6CT8jt/MS0pBVJncQXtki20Wm4hv0zbYsGpyLI9aoY=;
 b=FSGw/zFQoj/uPeAlaidKWQU/H7n7ryzdE3uzGccrak95+q4qjCXlE2HDKnVb6ij2Fg1Y5xwev3ZhGhbBQ6cvrpGV8qoAqYKNokD2/vmthguNs3Zbv7C93fbQNmJMVA1/GJJ2TlCrh+V3CPFt6vETBMFv/KD1ded+IdddYoDl+ueEuOP5cqAtii2PDCuzFI2mqj/oHhGP0Zw5ClvvxnfU1TFEB5knSvusG5bk09F5EVrm13W902hlzPFT7Uv5pJ1yxrFZaMmiomM8Ike5GMC98Asw/d+tk/S22v7fx9H/wypdMMdjqDJwpA/loegpuBdfz5bScKiuqkd4w5V7mS4Rtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TYCPR01MB5936.jpnprd01.prod.outlook.com (2603:1096:400:42::10)
 by TY2PR01MB2140.jpnprd01.prod.outlook.com (2603:1096:404:f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Tue, 21 Dec
 2021 11:21:59 +0000
Received: from TYCPR01MB5936.jpnprd01.prod.outlook.com
 ([fe80::f814:f7e:f65c:3147]) by TYCPR01MB5936.jpnprd01.prod.outlook.com
 ([fe80::f814:f7e:f65c:3147%5]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 11:21:59 +0000
From:   <Kenta.Tada@sony.com>
To:     <andrii@kernel.org>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kafai@fb.com>,
        <songliubraving@fb.com>, <yhs@fb.com>, <john.fastabend@gmail.com>,
        <kpsingh@kernel.org>
Subject: [PATCH] libbpf: Fix the incorrect register read for syscalls on
 x86_64
Thread-Topic: [PATCH] libbpf: Fix the incorrect register read for syscalls on
 x86_64
Thread-Index: Adf2Wq/aKz/L3iqWSU+AnW3rkIDyVQ==
Date:   Tue, 21 Dec 2021 11:21:59 +0000
Message-ID: <TYCPR01MB59360988D96E23FBA97DAE0AF57C9@TYCPR01MB5936.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4cddeb2d-2b34-453c-eb5f-08d9c4741adc
x-ms-traffictypediagnostic: TY2PR01MB2140:EE_
x-microsoft-antispam-prvs: <TY2PR01MB21409DA6B234BFB7DF07D204F57C9@TY2PR01MB2140.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:660;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4mB6XjC8VV0COpGZ4DIcZbkhrf5go7WMXGIL9ft0YIQWCvVfR+YQRjJEq3PZ3oKQejw6qnzQbcKA+IQ4cPtldf63cBwgZJXSUz00UvQZUHvbl0VgVoMdwK6hxSonpif3t+gOPljq+niaxzVPOOkj9fjWgdN90nvmNKtfJaNp2YAK9j8pdvvJGD73LRw6sE4TqDD40I/SHsX1e5lpTNms0j5uz/Y75brgtrbvxqPNy0P5IHBN95CrscdYtintOkJk8Z08m+4oV5tIsmthJv1MOGaeq+JONgWipX7lE/nb2qNFNDbF1cgym9DrYhdhk0evNItLjjmkmWWS7Zk+guygsoP9a0+xOICA5MTKdJyOPzysxMp1splvLH3MSzn2Zs2T8lT302JPED+7AyLcwPFvDGiA+nZeNFtJ71gHWCyAHMpbKQJ4bBO9+Q13fLelb1A6wpMBfBNzojgO8K/5ypviwwlkuY96mXu41cNOmvljp4aYPvrAu9DRnzR0HxSI7Q6lhOqUbrXX0MsMp4BUvqyTJHyJPODaqeLJPN+Ej3ifyZm1z9HQh4lr3eKavzAczMmepcydC8UPskleAy70X5sU/jGYezXCpe32bmuJij10AIHQstv6dALIJ0C1UdcbXQ7CZdM7EQ2g4hf8Y02xewPsmhFToDv09pmRBaUn7iLlhjFD1ONnAWOTyvefrHG4uf+sfu26MOQypIux5/Jvhnbt7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5936.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(9686003)(82960400001)(110136005)(76116006)(55016003)(64756008)(38070700005)(66476007)(86362001)(8676002)(66946007)(2906002)(52536014)(54906003)(6506007)(66556008)(8936002)(71200400001)(316002)(38100700002)(83380400001)(33656002)(508600001)(4326008)(186003)(122000001)(5660300002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PNHQmPmeD7pOpetrs5N9lZ5Y0OQqDYZgkSQBDN1YCFwea1ocWu5ylATa+NYT?=
 =?us-ascii?Q?YVJMhCgBWz/PDvXNTI8see0A/fdynC4bLS1vZxSlMNNQOmQijZqGHjLT9GNh?=
 =?us-ascii?Q?4/njV5hX7a0FQ/YvbpbrQQn5JsDzNpTzo/AX9YG5dJronETnWEXMZy/2iRbv?=
 =?us-ascii?Q?eY+IppahRdNyBHOdzUYwl0my9Yg4wdOBVCY1I47VQ1qzVi3NASYnFbjl7eWP?=
 =?us-ascii?Q?j1DjjkFUgLFZxGOF2QtnZutSS7qGWaxIsPTgi/e528aYgLxYumN0sxtlbHOI?=
 =?us-ascii?Q?MtAa72S5xfglpclEPLTB4Eg4EjGWNF3jAyQBC+pAQCmS5ldClkN2kHwz5aVc?=
 =?us-ascii?Q?LjrveVzHXsiE/hdRlY6oawx6b0O3CAvuo0dq5zZJSO4dU2t8fuW8xn7fqaVK?=
 =?us-ascii?Q?BJS8Wv+Bd1YJ1Q0nK8n1GodZSHBVWsNUGwvvK89yJLwt1N/uiRczEPvi4W32?=
 =?us-ascii?Q?GbzT5bndOUxukg9CsaCocZpvA1wIGy9zn8iaqc46miY6N+gLLZ+4tOa08ijr?=
 =?us-ascii?Q?Jr96O+zyZ1UwVX2T/KNa4CYhVXJQv4V59rOSM6TtY7S8r8MbBY1Jlcveyv/j?=
 =?us-ascii?Q?5T6U3So/zTxChnhq4fSWE6HYxVcphjI0VwOqzcnnANJiZoAGoC5OteU9S0CX?=
 =?us-ascii?Q?+IsfqQ4ACo9GrS700aoLj55ysLR4MmPcX2sqHWdcEvk36jqSYXjZy0xX32C7?=
 =?us-ascii?Q?2gy2B++NWxwmbrnIOWpqC65Ov6qow+WZHaA4lye9Acqbnes0FFvZKL7C3RkR?=
 =?us-ascii?Q?+M6zB6ePljqmSMrBcDdwytC5P/sXU/dIAPldDXgTwOcJNCz+BzX2ufxGcl7C?=
 =?us-ascii?Q?Ss1M9exmnZwM5l5MPSHbgocR8y6cQhYUAAKecSEV5n8J9oYsTkLc723RYpk+?=
 =?us-ascii?Q?T3MYHwuSjvHO0JNJ+ZulzA0neg3yraVrmjN5QKldvNCfCy/g8R3RpHTcIyhp?=
 =?us-ascii?Q?eM6OS9YWfvCV91NTtbheiUzwuQbbCIulKyYPm0psCUExuazgPc6mtpT3iBq0?=
 =?us-ascii?Q?M4qxzQeL4ejSqJpWn0kmac9uWYgrlVusB1Rg8ZwTZK27LIzGsodSYJWOu8tX?=
 =?us-ascii?Q?IWFdfpJYa8aeh2KhWrEkoBBOcfKn8iC7enYdVhdDaX4tRmNsxNDroPYX/0R8?=
 =?us-ascii?Q?wg9qktK8Ifs5NSlMzgOCp2qfksE9g9mgXILXW0MpjyogcnG9tFUoCtIT28/V?=
 =?us-ascii?Q?IjHAymbDiPP5isvYG8OYLw0eGK9Lifcdf4jnHlE9NF2TwlFT3L6MK8tg0pcJ?=
 =?us-ascii?Q?kg1pgwBpTwwNxHYDRSuqkzBZxkIDiysrZqx/5IbhLD4qf8O5vvvJL3yzj6VP?=
 =?us-ascii?Q?CTDBCvKFPMgG/ar9MCYgM3Ik4DgHE31ocYiOY+aDPvIurjCIvaBWGuDXtC80?=
 =?us-ascii?Q?5vPVdkICqlJyRrgWdmrKBDlogGV3ZDAZ2vIlJsAcec1qGW1fToeXYxScAeWb?=
 =?us-ascii?Q?nCTj/EkCKNcjk2fesC7xKfdd7SSMjRK7/5FArO04Ktzh0e9bwcq8ZTebRHrI?=
 =?us-ascii?Q?/sos6d/Wv3aFVxX24vlePrjLsc7ZJSawM+4eMlRV+fpNdYTB5SW4bAK+pVPc?=
 =?us-ascii?Q?rTyfr07oBiS0nLGkjGKvlmQabWn08FzhhSsXe2Q90NLeI2z04ALFKHsjTZyS?=
 =?us-ascii?Q?Y5l6alwJ1qwE5S9e1S6jwD0jHhhhQQDyVxDlCe/aVN0fPREvHDT+mnSS+c5F?=
 =?us-ascii?Q?11z8Sw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5936.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cddeb2d-2b34-453c-eb5f-08d9c4741adc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2021 11:21:59.4791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Ej1uivcH8i/VfHRxpnhkY2D0yvpz6DF4E9X/ypGyPsJnvcYLBm7xqg8XqKCApfYBJOLWqTYYNumqoT/l/dsoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2140
X-Proofpoint-GUID: TRKONiJJUqwhbCALamgSjYJZzyyU0mMM
X-Proofpoint-ORIG-GUID: TRKONiJJUqwhbCALamgSjYJZzyyU0mMM
X-Sony-Outbound-GUID: TRKONiJJUqwhbCALamgSjYJZzyyU0mMM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-21_04,2021-12-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 mlxlogscore=912 suspectscore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 impostorscore=0
 clxscore=1011 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112210050
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, rcx is read as the fourth parameter of syscall on x86_64.
But x86_64 Linux System Call convention uses r10 actually.
This commit adds the wrapper for users who want to access to
syscall params to analyze the user space.

Signed-off-by: Kenta Tada <Kenta.Tada@sony.com>
---
 tools/lib/bpf/bpf_tracing.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index db05a5937105..f6fcccd9b10c 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -67,10 +67,15 @@
 #if defined(__KERNEL__) || defined(__VMLINUX_H__)
=20
 #define PT_REGS_PARM1(x) ((x)->di)
+#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1(x)
 #define PT_REGS_PARM2(x) ((x)->si)
+#define PT_REGS_PARM2_SYSCALL(x) PT_REGS_PARM2(x)
 #define PT_REGS_PARM3(x) ((x)->dx)
+#define PT_REGS_PARM3_SYSCALL(x) PT_REGS_PARM3(x)
 #define PT_REGS_PARM4(x) ((x)->cx)
+#define PT_REGS_PARM4_SYSCALL(x) ((x)->r10) /* syscall uses r10 */
 #define PT_REGS_PARM5(x) ((x)->r8)
+#define PT_REGS_PARM5_SYSCALL(x) PT_REGS_PARM5(x)
 #define PT_REGS_RET(x) ((x)->sp)
 #define PT_REGS_FP(x) ((x)->bp)
 #define PT_REGS_RC(x) ((x)->ax)
@@ -78,10 +83,15 @@
 #define PT_REGS_IP(x) ((x)->ip)
=20
 #define PT_REGS_PARM1_CORE(x) BPF_CORE_READ((x), di)
+#define PT_REGS_PARM1_CORE_SYSCALL(x) PT_REGS_PARM1_CORE(x)
 #define PT_REGS_PARM2_CORE(x) BPF_CORE_READ((x), si)
+#define PT_REGS_PARM2_CORE_SYSCALL(x) PT_REGS_PARM2_CORE(x)
 #define PT_REGS_PARM3_CORE(x) BPF_CORE_READ((x), dx)
+#define PT_REGS_PARM3_CORE_SYSCALL(x) PT_REGS_PARM3_CORE(x)
 #define PT_REGS_PARM4_CORE(x) BPF_CORE_READ((x), cx)
+#define PT_REGS_PARM4_CORE_SYSCALL(x) BPF_CORE_READ((x), r10) /* syscall u=
ses r10 */
 #define PT_REGS_PARM5_CORE(x) BPF_CORE_READ((x), r8)
+#define PT_REGS_PARM5_CORE_SYSCALL(x) PT_REGS_PARM5_CORE(x)
 #define PT_REGS_RET_CORE(x) BPF_CORE_READ((x), sp)
 #define PT_REGS_FP_CORE(x) BPF_CORE_READ((x), bp)
 #define PT_REGS_RC_CORE(x) BPF_CORE_READ((x), ax)
@@ -117,10 +127,15 @@
 #else
=20
 #define PT_REGS_PARM1(x) ((x)->rdi)
+#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1(x)
 #define PT_REGS_PARM2(x) ((x)->rsi)
+#define PT_REGS_PARM2_SYSCALL(x) PT_REGS_PARM2(x)
 #define PT_REGS_PARM3(x) ((x)->rdx)
+#define PT_REGS_PARM3_SYSCALL(x) PT_REGS_PARM3(x)
 #define PT_REGS_PARM4(x) ((x)->rcx)
+#define PT_REGS_PARM4_SYSCALL(x) ((x)->r10) /* syscall uses r10 */
 #define PT_REGS_PARM5(x) ((x)->r8)
+#define PT_REGS_PARM5(x) PT_REGS_PARM5(x)
 #define PT_REGS_RET(x) ((x)->rsp)
 #define PT_REGS_FP(x) ((x)->rbp)
 #define PT_REGS_RC(x) ((x)->rax)
@@ -128,10 +143,15 @@
 #define PT_REGS_IP(x) ((x)->rip)
=20
 #define PT_REGS_PARM1_CORE(x) BPF_CORE_READ((x), rdi)
+#define PT_REGS_PARM1_CORE_SYSCALL(x) PT_REGS_PARM1_CORE(x)
 #define PT_REGS_PARM2_CORE(x) BPF_CORE_READ((x), rsi)
+#define PT_REGS_PARM2_CORE_SYSCALL(x) PT_REGS_PARM2_CORE(x)
 #define PT_REGS_PARM3_CORE(x) BPF_CORE_READ((x), rdx)
+#define PT_REGS_PARM3_CORE_SYSCALL(x) PT_REGS_PARM3_CORE(x)
 #define PT_REGS_PARM4_CORE(x) BPF_CORE_READ((x), rcx)
+#define PT_REGS_PARM4_CORE_SYSCALL(x) BPF_CORE_READ((x), r10) /* syscall u=
ses r10 */
 #define PT_REGS_PARM5_CORE(x) BPF_CORE_READ((x), r8)
+#define PT_REGS_PARM5_CORE_SYSCALL(x) PT_REGS_PARM5_CORE(x)
 #define PT_REGS_RET_CORE(x) BPF_CORE_READ((x), rsp)
 #define PT_REGS_FP_CORE(x) BPF_CORE_READ((x), rbp)
 #define PT_REGS_RC_CORE(x) BPF_CORE_READ((x), rax)
--=20
2.32.0
