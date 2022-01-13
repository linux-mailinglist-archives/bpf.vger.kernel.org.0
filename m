Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5DD48D4B5
	for <lists+bpf@lfdr.de>; Thu, 13 Jan 2022 10:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiAMJFw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Jan 2022 04:05:52 -0500
Received: from mx08-001d1705.pphosted.com ([185.183.30.70]:49728 "EHLO
        mx08-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231681AbiAMJFv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 13 Jan 2022 04:05:51 -0500
Received: from pps.filterd (m0209320.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20D4mQOD012686;
        Thu, 13 Jan 2022 09:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=NfWmatZxezpU8DErt5IyGLfQ5X7bq/nKiaQI0Mqtpl8=;
 b=GLvsoMORXxgPEjTofwUCPfaVg2HJbCJbCxy4Q/IK64YylXBSQpHOrU/4ar0C7yTCtg6d
 hrHrbFdTzeG8agdmiqDoANNxW49/4Ko0rxhn96Etp3GyOIsZvK+2GqpYDRyG7t6rFySB
 Ekd/BibCxac6CpP1vvdkG7RunFS78MUxNnB43PlVbAiYbtDxkl8Lyx5GnBwuSbGvBOyr
 DDN1mVzahKd3ePBuAZ4OTFWIONTQG99vxLsJ+gttoUZzq2lfmqp6LZ80NWraYZr8t/gg
 JvJzNiyTJwncEbGp8iZDx3EfVn6DoY78MnrdUFXEjSefgHwORcyRLRrqb7rl3H4JRDEH GA== 
Received: from jpn01-os0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2107.outbound.protection.outlook.com [104.47.23.107])
        by mx08-001d1705.pphosted.com with ESMTP id 3dj0du0w7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 09:05:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaWkmyMolK4+ltCyj7zkZIUw2kCPgaUHRJ30RRyC5TwNN4CywcFf5OxsUnA0Lxfrrhmf7sh8wP2pGwMRgtas1wI+DPXMFDqrN7n4hPxK/6e1wEJMoYxt5OphjuR7KEa1D4Fwa3jjs/aoITRUcnpbvlkcoHeFZ4UH0UVGTWngNyNGFO5MZlLADqA1KAQUQYR/jedZ1CLDS4Lx9Uz0wTeQjzlFfIepJrf5atFrBjHKKAcFSSQG+IPMghecVRHch0Si7GWTj+EH3UPx+lYo4L6Z0aIkJoEiX1IwtVHDf+D31DDW+K09xjcQV2gKGzot2XvckuF1CUwRnqCUsUfG192J+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfWmatZxezpU8DErt5IyGLfQ5X7bq/nKiaQI0Mqtpl8=;
 b=VO7oTBTAHs2YK4NJrCKadQqHewys/+1gCimpSE9vLo6P/FMVgTFFACHoEn8WGEupMs3AaU9zzwpXCRxq4QUZ7StlVJVjR1oFv8FXbqeRDPanqNyzXPM3b17n7TNbFlnODZWfLcEe26QdV3Dq352jL7XuUIj87dh7erBXS/ZnPVIIB6Al8qkmibxv7hJ1jDVgZn1YeZ0IAPl4XMOWyXGCpAQyJXJ92f6051EzP1Actfr8beVL3cP9Oxqq0qVtjzvNxlXY3tyYOkB5Ec2ffvre4zSFgTQcuHRirRjI/UWQzMpt4r/0JV3pGfjvps5IDLY01TszG8SA3sqKh5HqRc8tkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TYCPR01MB5936.jpnprd01.prod.outlook.com (2603:1096:400:42::10)
 by OSAPR01MB1555.jpnprd01.prod.outlook.com (2603:1096:603:2e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Thu, 13 Jan
 2022 09:05:17 +0000
Received: from TYCPR01MB5936.jpnprd01.prod.outlook.com
 ([fe80::4d73:10a:5d6:4b8d]) by TYCPR01MB5936.jpnprd01.prod.outlook.com
 ([fe80::4d73:10a:5d6:4b8d%5]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 09:05:17 +0000
From:   <Kenta.Tada@sony.com>
To:     <andrii@kernel.org>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kafai@fb.com>,
        <songliubraving@fb.com>, <yhs@fb.com>, <john.fastabend@gmail.com>,
        <kpsingh@kernel.org>
Subject: [PATCH v3 1/2] libbpf: Fix the incorrect register read for syscalls
 on x86_64
Thread-Topic: [PATCH v3 1/2] libbpf: Fix the incorrect register read for
 syscalls on x86_64
Thread-Index: AdgIW/lz/N8+hFvwTg2FEMAC7Jb/Qw==
Date:   Thu, 13 Jan 2022 09:05:16 +0000
Message-ID: <TYCPR01MB593607CDEC583121CFDC4830F5539@TYCPR01MB5936.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78ae70b1-b6c3-43f5-625a-08d9d673d14c
x-ms-traffictypediagnostic: OSAPR01MB1555:EE_
x-microsoft-antispam-prvs: <OSAPR01MB1555D06E492461B2641F30E7F5539@OSAPR01MB1555.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:820;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YBs+ZXSgndrC264HOXuyxCCcRgpu87ZFykhpsW1XCB9FVi7SGaNahzi8oroSwQLeAZ+euwR3enZFbQ442lb3cRrNWq6TEi6HBHwua5JhIdeTeLJxkJ5OouXZItTUYk3pnpt37RCHIIX6dKvfvNrrZCW1No/mZSzH77cphqQqeRCnIvVWX7nXG4/YPmOJH97CDFZbSKbLY9ZeAmhIGJchwKic18GJxJBnTQyEIVjU/zA8XZYgyBGXVl8JFTyePFdd2lyTK4Umqir1hXMog1F21Pv/+1kwhoDygqJbnthcuiDcImS6iO8RlIPviIjq5gh7VrH9kXNKRHePQ8zxbQ9dvxPbcatJZSanIRGY+S4oIc0nmMIlTdKBNgB3qWKuaX+5Jn3xfwjKkw8eK6t5cC3nIU58p2EPhS4ZKwgOjWz7q11fDyCfbgJKlR2AkCE5RYUzbBw1KRmqlnQKJKkMsF+tENkDz68r5oq/yIrXjgaeY/08Qt4c86nXve1D/Owb0eZgFs2HJ8gAAaCL7Ml0fJPQfraZTIuOyJ3c04BY+FohBkB8SPciXEB30ykJdrNbaAOPWA6i4bX+Jmh3Iax9gQQIjR5eTVlkSGuMLKUXTK0P1i9n2tZNHUwIMFXONEq6DmbodswyQpNOR+I2XSks0NO3p3k/mnrHGQjDCB6SLHrP8zXDE11Gv5SFGEo0DBE2QG7Ub9T16evP0REMClPKI1H34Sdqf2y1PGbMxcqYG+dCQ9ax6SWINeQFkTAPZcydbs5uXKc2PnHGfRsjXYQLRiV1pyC9Hc2PiwVMUjozquwpS/Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5936.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(4326008)(6506007)(122000001)(66446008)(66476007)(66946007)(38070700005)(76116006)(508600001)(71200400001)(64756008)(66556008)(7696005)(316002)(110136005)(966005)(38100700002)(54906003)(82960400001)(5660300002)(8936002)(86362001)(2906002)(52536014)(83380400001)(33656002)(55016003)(9686003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wxkT5CM4Tp03yTtGIN+YwQ9Quw8fn8xbzqMyKdbcCqei6ZttrkqyXHHBJiI1?=
 =?us-ascii?Q?4CKo9OKj/dd8OFiJBpKM4nENOvUFfiH4hLpjnV+mBslrnRreyXM5cNiteAO1?=
 =?us-ascii?Q?oRg5KYw/+OC5m0gQ2b72b9t9oSg74hUsG5o+8vw7Ci/S2h/KTDPXxhfFdUrp?=
 =?us-ascii?Q?6A3/V5TQ0q6zX9q4XZ679Kb0jTu28xyBKqNEsAuhWHEpuP4J7x06KEf0BNrI?=
 =?us-ascii?Q?VZbrl7/7Nd5l63UWDL7mlrwHuJqixPSC59CC0r9gtCp6FXrjX9DGg9jzbv/A?=
 =?us-ascii?Q?TSgzInAYQP3J/x7w2fB/aUVVV9/ffWLC88J1twbPreAgnPqPTWA9cwYqObfj?=
 =?us-ascii?Q?UnecSeMPI88lY8JY18e+KVcA59K5RFAFJLuMniuBAdQc3D+OZFITSZJdcnNt?=
 =?us-ascii?Q?Wv5ssesQgXxR7S5OaTMS+PLPTkEvIuLRc6QIZs0lOK2AicxIlE6ym/sahpW+?=
 =?us-ascii?Q?OyvnAeVv8/UGhOAp+iiY6IrhrygPJVwnJMtgy08sWr2X4vUgPexeoZL0Y0Wr?=
 =?us-ascii?Q?1nkTovqOgQq6oLSBhtvK/729rnJT3Do6BC2DP9EXpFDFT4Rv9hPtYXdBrS4S?=
 =?us-ascii?Q?r3Me496PexGNOR1yoTZ5MuglAYcpU2YsMHI2TEmmShxHcR/YhlTsZpIccrh9?=
 =?us-ascii?Q?//QnwTxt9v3ws4NFUfN/ymfuRJyHqrpsq0DLUDfMprWAX/ApDjfEW8NhbeAT?=
 =?us-ascii?Q?Yz6yyyTBYAYh5ZOt45hM2Q7wd9g+l9UBGZ8v8HaJgPJ9Zg0DJaTX7ZRGsAoe?=
 =?us-ascii?Q?dl4z4HZsSMahc6+R1Ew8jVvrxXy2jNRPO10idfaocmGIEjJ9WnlYxqS6KyUS?=
 =?us-ascii?Q?gj/SwnDgX4EsPF1orJiK98wTE4La5VTvfv6/bAj6HzFBF7PXc0BRlxkR2cqe?=
 =?us-ascii?Q?TP1pU3quMnGofjzzxd6gdPx5rC6YRcKhhsLtG6KzJXcfC8G1/XrrkpJIkwOy?=
 =?us-ascii?Q?AlYTC5D9Linz7jMFvZ6rO/rjkzwP8/AQMRuHmj7NKcm7Fw4te3v9yO1IraEz?=
 =?us-ascii?Q?cviLdS+emopOaQDxFlJzQbsAPO2fVhRJuZba/yUS23kEaMUEsLZV/nONnt8Q?=
 =?us-ascii?Q?oWUctgxi/Pz/ICg7aeBw7q/daI9jAWSvJbfBOgomhGjrpH4H/qsEyQYuLdP+?=
 =?us-ascii?Q?/yBmb6aEiXlp8BMxZg7HNRd0jXO9rQ4JEN1Yn60XiOMIpXeDQ3O1ToAaXcuJ?=
 =?us-ascii?Q?gZswpgZuradY2punuT6Jy5aLdUeV1G9V+FQzWnXbq1/obZVPjVDtzHUXPQgW?=
 =?us-ascii?Q?OMKDFmEgwQFkubP4aUBaYvPr4skivkWCWYCPujhVdGCO23T4UNpPFQIb2SOy?=
 =?us-ascii?Q?QVPwOIzXXsHgSk0Qv3/OKyt3XpUCK6bRy/v95zk46Dw8HE9OKApyBs8Ag/X2?=
 =?us-ascii?Q?0BjR21loLCHmJlguG8YSFgC9ksQlH/EmtINc25K051lKNgj/4NdwnChlFyCq?=
 =?us-ascii?Q?1Hw1dpIJb35de7hB29bhU728t+cIgiIig678kKjBE1QBUTAUsYvHNo+B82wO?=
 =?us-ascii?Q?1hdxN3mqAfU04lAt1VC4emUFJQO49InTOZZCZp3GEroLhnIN2nC+MAgIHhOt?=
 =?us-ascii?Q?t2zgbLok2JsF51U8xZbggyPZMXB1/LYCFYVSaLuH/JFsbBG5kLITg6P12Uxv?=
 =?us-ascii?Q?2KLT6izzzP41dK/PB8e3HpAdkyU1cbVuaOKkJ8+v4crSFYug1vSMQucDfBZN?=
 =?us-ascii?Q?RFyyLw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5936.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ae70b1-b6c3-43f5-625a-08d9d673d14c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2022 09:05:16.9725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FCMzzwBHcOSfU1ucNoikSKgmJxHb5wH6GRnPpdMOeuRZca5ipA/RP9HRTv5rFZ/+rvjfBT/m/t96CuR+oLBZ0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1555
X-Proofpoint-ORIG-GUID: nydNfIb7YzdlTS50ToC9efr0m_cX67tr
X-Proofpoint-GUID: nydNfIb7YzdlTS50ToC9efr0m_cX67tr
X-Sony-Outbound-GUID: nydNfIb7YzdlTS50ToC9efr0m_cX67tr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-13_02,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201130053
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

v2 -> v3:
- Modify the definition of SYSCALL macros for only targeted archs.
- Define __BPF_TARGET_MISSING variants for completeness.
- Remove CORE variants. These macros will not be used.
- Add a selftest.

Signed-off-by: Kenta Tada <Kenta.Tada@sony.com>
---
 tools/lib/bpf/bpf_tracing.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 90f56b0f585f..d209e75dbdbd 100644
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
@@ -263,6 +265,16 @@ struct pt_regs;
=20
 #endif
=20
+#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1(x)
+#define PT_REGS_PARM2_SYSCALL(x) PT_REGS_PARM2(x)
+#define PT_REGS_PARM3_SYSCALL(x) PT_REGS_PARM3(x)
+#ifdef __PT_PARM4_REG_SYSCALL
+#define PT_REGS_PARM4_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM4_REG_SYSCAL=
L)
+#else /* __PT_PARM4_REG_SYSCALL */
+#define PT_REGS_PARM4_SYSCALL(x) PT_REGS_PARM4(x)
+#endif
+#define PT_REGS_PARM5_SYSCALL(x) PT_REGS_PARM5(x)
+
 #else /* defined(bpf_target_defined) */
=20
 #define PT_REGS_PARM1(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
@@ -290,6 +302,12 @@ struct pt_regs;
 #define BPF_KPROBE_READ_RET_IP(ip, ctx) ({ _Pragma(__BPF_TARGET_MISSING); =
0l; })
 #define BPF_KRETPROBE_READ_RET_IP(ip, ctx) ({ _Pragma(__BPF_TARGET_MISSING=
); 0l; })
=20
+#define PT_REGS_PARM1_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_PARM2_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_PARM3_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_PARM4_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_PARM5_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+
 #endif /* defined(bpf_target_defined) */
=20
 #ifndef ___bpf_concat
--=20
2.32.0
