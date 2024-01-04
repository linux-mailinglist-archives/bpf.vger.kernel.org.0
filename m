Return-Path: <bpf+bounces-19003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC33823B01
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 04:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262EB288364
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 03:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0705223;
	Thu,  4 Jan 2024 03:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cuhko365.onmicrosoft.com header.i=@cuhko365.onmicrosoft.com header.b="JtoYeXTD"
X-Original-To: bpf@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2079.outbound.protection.outlook.com [40.107.113.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712D618640
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 03:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=link.cuhk.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=link.cuhk.edu.cn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnBdDBYy8a7DtV/WdQJWqjR2+BW9AR7m+rXOvJ1HiwjAc+enLciAXT2GlnesHh3Lj2qQjNisjjXEhFW0RJbAtLHDfmQRGo5EiTuBiEjrrykuKlxGG+p0Xp6XfhApPc0v63SYtCq1OuexWKlTWp5cWOZPwXjZhQqzFXQY+6Py9Pt5WHvm7DMgWJjVMwpYLY4atEa7UlfV4M18ZuivVh4OCSiDZonJ4R971+kPn9IMscNMI99B0VIr4bHmB7n1eWxf4r69hUKs8XIjSorw5aCY54SSQ2/HcWpu3dXsLteztqB4VO0McXSTp7Jljyp3+vrrQzMV8s/QLPC12mWcsDLSfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jIWgysWGTweyjwCg095ynhHbkS2XmiZeTcX8lM5KCI=;
 b=PKDWE3z/6wdYNY1zKD3AvSqRvXSrH4t1D7Wh06iJZ71YMsKvaObRyj4aDZ6mG6UALgPFnNKE3lLYbWkZwMu1QTekfwtfhq0uy7LVuBAQomb9tVJ/cS/byaj8tcv1Mo8CLQJfN9nJ8R04UUg63mdq0H96KHNn08X33EZymfX8DOnA086nIv4o8Zf3Bbe3hl0AIYQf28AyUcNucjLGXcv+2NzD3rDsz8KgmKlzQ4wSKYi8fTHQKhaqgzl+Q6ckNyMJWP0VcBt5XkmuYd+CLki3Z9uQfUk+2yA7ehYGO8QycD5z80yyTrXJ+BgTFDTaWBpvBLF0YZEL+T9Xm01jCSCn7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=link.cuhk.edu.cn; dmarc=pass action=none
 header.from=link.cuhk.edu.cn; dkim=pass header.d=link.cuhk.edu.cn; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cuhko365.onmicrosoft.com; s=selector2-cuhko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jIWgysWGTweyjwCg095ynhHbkS2XmiZeTcX8lM5KCI=;
 b=JtoYeXTD+DzR8cY8Cy01ti3AvCrtDTPnS4U67NssGqGtBtaUfwH4Hyz2xtWkDQnq1NFBd2v+y+XvrFraYaRCHxi28yPTDljCdXCIdoCCqrV544y8ggimg/hCjGyNGAN0dyS26tKsN5zIawVDoqCtEqCnL0/7s8b6InPTwmAgeQs=
Received: from TYWP286MB3822.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:447::6)
 by TY3P286MB3732.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3d2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 03:12:41 +0000
Received: from TYWP286MB3822.JPNP286.PROD.OUTLOOK.COM
 ([fe80::6fa9:a85c:1adc:827b]) by TYWP286MB3822.JPNP286.PROD.OUTLOOK.COM
 ([fe80::6fa9:a85c:1adc:827b%4]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 03:12:40 +0000
From: "Aoyang Fang (SSE, 222010547)" <aoyangfang@link.cuhk.edu.cn>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "bpf@ietf.org" <bpf@ietf.org>
CC: "void@manifault.com" <void@manifault.com>
Subject: [PATCH] update the consistency issue in documentation
Thread-Topic: [PATCH] update the consistency issue in documentation
Thread-Index: AQHaPrvgz1htAWG5g0GpJpM0pJumoQ==
Date: Thu, 4 Jan 2024 03:12:40 +0000
Message-ID: <3A7D0A57-02EF-4ACB-A599-1029CFCA7E74@link.cuhk.edu.cn>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=link.cuhk.edu.cn;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWP286MB3822:EE_|TY3P286MB3732:EE_
x-ms-office365-filtering-correlation-id: 6b400a82-a466-442a-3aab-08dc0cd302ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 F0/ERUlKP99wPR2PbYlw0RS3aNIZB3AHbJVOFx7uDcLY1I4fBn2bRafOArL409nBjWaQQwUMPNAHSTdsgqw107zCeKY2Vt9p8iQoRttBJnhEPvdl1ResjiUrRBcZmKoQV0jnVRj6436LqCtbc/3KKuzjkyy1Sqel52vN3b7DZdd8ScxQMU+sov8uUqLkq+PN6MMQBweFtUe/McXBobo/FgzSQcIb70xEiucSi4l1yIPIMDt4+9rIBTZqXXhMzGoM4wY03IcyjFaNQ7IdUnFxSKnLFzjmhhUJ4iW20IMzgFYRsoNOCJaCVUATs4wLZiV+9SxSXCdfmOPvPyMVqMYZDDJF9SoYo14sFU4NsY0ycNb7yFJyTCKPYJ1uHjcAMmTsSFcaL+l/gk7zVAkecyXgnrjBOg4P9HMdyoVKozHaRqO0Lzd3DMQ8VIKKwgvTUQ1xcL8GLaJPulwAE39Rph42EraTajOn7nfEQUS9dWXJ9PW6jX88fCJyXXKPR1PVJj0PS5sFLNDum2EJcFcXUII+e1EgbsNTmxqWBAs8ywIIPn+b3Z8ILROnY55l0TrssXVP77R5Z56SYftjJY/9w+HfAPZgM8Mim9w7U1mm1bmBFJI2VbE6oIXZnpySYAW6kQxAYxRWkWUT906JNbK01Mnbhg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB3822.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(346002)(39850400004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(8676002)(4326008)(41320700001)(2906002)(5660300002)(478600001)(71200400001)(6506007)(6512007)(53546011)(64756008)(66446008)(66556008)(76116006)(66946007)(316002)(66476007)(786003)(110136005)(8936002)(6486002)(41300700001)(38070700009)(83380400001)(122000001)(2616005)(86362001)(38100700002)(26005)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?I1Rm8UpCrykiPL1phWhcEHv+IHHCH2Dhb+sXNGO+cSrPSD/E3KXXm4dmdScn?=
 =?us-ascii?Q?1CZVd5DMMQ0vhlaquq1Cyi7i4/drmfoVoWUPtW+rCJETx5+npOBU+ym+CzqJ?=
 =?us-ascii?Q?swL1p2ViRqk2iR19WH9xBvRiozD82HNt8pTpPsHIYTVBbFMRYu65GinOEty8?=
 =?us-ascii?Q?RQQdH4605jLRdN6AjC+zWc96Q5yo1aJTYbHK7QZDZf/LOnpcy5TnzdxjXsiQ?=
 =?us-ascii?Q?LVD0aQDEGUSpfVLzJqcTe67O+C6LzumvOS/Tz98J5iXGmUyQKas/+L60OLPU?=
 =?us-ascii?Q?nBPn5dm1aXxxpVXRNDgHmr2+ahc6xuU9BzsE8m6CL0gwZkPFVu0zTpYMUVcm?=
 =?us-ascii?Q?smb6xWE3y9X6SrRnKagseep7eVcCywzNi9dMRQX9sK+fpkzmxLDlR5B4nFE8?=
 =?us-ascii?Q?LXJB+6lVMIkmAZAYqcCmZOCycJ6P2q42BL18encM1idKQL2ITNcMn4C1inmk?=
 =?us-ascii?Q?5xr6+1OlYYpskgclr4O3kc5f+BHVDT2NBqMK68k/n42gwYS9sYKTZyGUsQeR?=
 =?us-ascii?Q?QLFbI0f9kNY2glmPFksf5Qz8Xv6E6+MyMxpKlXz2qO+X0cA+HaOHQ1G4igh4?=
 =?us-ascii?Q?cDACjsWJ1abk91aWucg+rELM7k9AocR79GQFGh6ghP1AcOfRJ2I8SKNzIGRY?=
 =?us-ascii?Q?DnYmezU+WM5c++HtN2oOVBu/v50aN/21Qth/o8dt667ybe0KOfr4rVnguW6n?=
 =?us-ascii?Q?Uex0npreGwDAjuwmSs1zyShkkFQcV1xPvD6zAU+sUcvxSZ3QJEz7gP41lEDS?=
 =?us-ascii?Q?Ta1Zud+85UCP/oqAWWVOPPy+WEmHNVs0CtA64Up8JcVLV8+6BwF/ej6jfZMt?=
 =?us-ascii?Q?BjlmgnoRPAdbKHgpEqWCUa+K2mwKHG6T64G6ZDOO48128Ew/7DAIIn32BLsW?=
 =?us-ascii?Q?qNUNOZueZjfr4CzFMhsoS5udcYWWDfDoYIyi99CD/dew+pNp1nc8MeKIhnvL?=
 =?us-ascii?Q?Actor+w84ZvBSoSgoNhyK3L3Ur1fKEG1A5MVgoOQUruEBSizt7musg/Jvhip?=
 =?us-ascii?Q?4vonFZ+H4pEHCXCy3dCqQrerAKeK7CfAOS5VX8V3DBvdLAbYn4uCGGgHERvk?=
 =?us-ascii?Q?AWXiSu7W2INIf8dPXS6UCZ2eYbi/uH+FlQwFzEPYsbE1k/Dhq8P5ExBxoDpI?=
 =?us-ascii?Q?cNuqqngaH/hkEUSdsHSdI87kHDZthi9Vab/G4dvuMUgR439QeURczVy5OrUb?=
 =?us-ascii?Q?o/FniWSNjLLRkrR7Xm07aSFjvvpwqDeMK6vJqQ7oGF8oLgAOQSxwUSB/Z6CO?=
 =?us-ascii?Q?CPi/N9HDfC+pH0kQ6Ipm2wwsoTYR11mI7HqQBRjyyNNo8lBdcNGdQyU6qDJJ?=
 =?us-ascii?Q?pB52HDLWOBxAsryj+vj6aWDSdsZOsaqXQJ+zAqpg2vOS3aspvE26jV5hpAAw?=
 =?us-ascii?Q?iz4HUKZcxMQdmDw7f5WjmOG+ui9gT4KBlI2RQWu9HPcyh6CYaPJvDMpitsVF?=
 =?us-ascii?Q?OVuiHydcmiV4FbadjYj0uwTosdKhs/QrjOGM+92LvR/Xr2KBvTJcN056Eu0u?=
 =?us-ascii?Q?vCu6OGusRhVfu8gOBF9YF+MZ5r8L35DGZC9BZiOwg6+dEljIwJCa+LWwz1T5?=
 =?us-ascii?Q?rZGif8W6+EUhzOgLHhU4JhxdI+kM6rh7BZTmerHJ6oh7t7YNBcvnOwvq6kLD?=
 =?us-ascii?Q?Iw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DD654C668D7F8F42A34CD27A924BF85C@JPNP286.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: link.cuhk.edu.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB3822.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b400a82-a466-442a-3aab-08dc0cd302ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 03:12:40.5998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e5898b7a-9c87-4a4b-b22a-2df3f355e01e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sGcZRQr+aKrj+2wGhm8aJbxJGaRUA8qAgYXlZiG4hauVTxo/oW7WQASQ/jGozgq3FyqX3OoyhvfsL0e+tuNz1KfhoSMiPJRMS0kmL/4buio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3732

From fa9f3f47ddeb3e9a615c17aea57d2ecd53a7d201 Mon Sep 17 00:00:00 2001
From: lincyawer <53161583+Lincyaw@users.noreply.github.com>
Date: Thu, 4 Jan 2024 10:51:36 +0800
Subject: [PATCH] The original documentation of BPF_JMP instructions is some=
how
misleading. The code part of instruction, e.g., BPF_JEQ's value is noted as
0x1, however, in `include/uapi/linux/bpf.h`, the value of BPF_JEQ is 0x10. =
At
the same time, the description convention is inconsistent with the BPF_ALU,
whose code are also 4bit, but the value of BPF_ADD is 0x00

Signed-off-by: lincyawer <53161583+Lincyaw@users.noreply.github.com>
---
.../bpf/standardization/instruction-set.rst | 34 +++++++++----------
1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docume=
ntation/bpf/standardization/instruction-set.rst
index 245b6defc..dee3b1fa8 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -355,23 +355,23 @@ The 'code' field encodes the operation as below:
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D =3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
code value src description notes
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D =3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
-BPF_JA 0x0 0x0 PC +=3D offset BPF_JMP class
-BPF_JA 0x0 0x0 PC +=3D imm BPF_JMP32 class
-BPF_JEQ 0x1 any PC +=3D offset if dst =3D=3D src
-BPF_JGT 0x2 any PC +=3D offset if dst > src unsigned
-BPF_JGE 0x3 any PC +=3D offset if dst >=3D src unsigned
-BPF_JSET 0x4 any PC +=3D offset if dst & src
-BPF_JNE 0x5 any PC +=3D offset if dst !=3D src
-BPF_JSGT 0x6 any PC +=3D offset if dst > src signed
-BPF_JSGE 0x7 any PC +=3D offset if dst >=3D src signed
-BPF_CALL 0x8 0x0 call helper function by address see `Helper functions`_
-BPF_CALL 0x8 0x1 call PC +=3D imm see `Program-local functions`_
-BPF_CALL 0x8 0x2 call helper function by BTF ID see `Helper functions`_
-BPF_EXIT 0x9 0x0 return BPF_JMP only
-BPF_JLT 0xa any PC +=3D offset if dst < src unsigned
-BPF_JLE 0xb any PC +=3D offset if dst <=3D src unsigned
-BPF_JSLT 0xc any PC +=3D offset if dst < src signed
-BPF_JSLE 0xd any PC +=3D offset if dst <=3D src signed
+BPF_JA 0x00 0x0 PC +=3D offset BPF_JMP class
+BPF_JA 0x00 0x0 PC +=3D imm BPF_JMP32 class
+BPF_JEQ 0x10 any PC +=3D offset if dst =3D=3D src
+BPF_JGT 0x20 any PC +=3D offset if dst > src unsigned
+BPF_JGE 0x30 any PC +=3D offset if dst >=3D src unsigned
+BPF_JSET 0x40 any PC +=3D offset if dst & src
+BPF_JNE 0x50 any PC +=3D offset if dst !=3D src
+BPF_JSGT 0x60 any PC +=3D offset if dst > src signed
+BPF_JSGE 0x70 any PC +=3D offset if dst >=3D src signed
+BPF_CALL 0x80 0x0 call helper function by address see `Helper functions`_
+BPF_CALL 0x80 0x1 call PC +=3D imm see `Program-local functions`_
+BPF_CALL 0x80 0x2 call helper function by BTF ID see `Helper functions`_
+BPF_EXIT 0x90 0x0 return BPF_JMP only
+BPF_JLT 0xa0 any PC +=3D offset if dst < src unsigned
+BPF_JLE 0xb0 any PC +=3D offset if dst <=3D src unsigned
+BPF_JSLT 0xc0 any PC +=3D offset if dst < src signed
+BPF_JSLE 0xd0 any PC +=3D offset if dst <=3D src signed
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D =3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
The BPF program needs to store the return value into register R0 before doi=
ng a
--=20
2.42.0=

