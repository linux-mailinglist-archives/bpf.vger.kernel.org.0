Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67FFD2FC0A6
	for <lists+bpf@lfdr.de>; Tue, 19 Jan 2021 21:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388296AbhASUIz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jan 2021 15:08:55 -0500
Received: from mail-vi1eur05on2118.outbound.protection.outlook.com ([40.107.21.118]:53216
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404616AbhASTGo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jan 2021 14:06:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tfll5Jyd3haRigBU5AK9058/GkGpDAMGPeui/WDG0bL7ftkSC1uC91nEbgHbejlIk87XgZoD1fzETEQfpv002RG0n/oZQ6oUNz2pqkk3Hcc7NP8sVd9fpR41VNILTgbb3Ucwlf9Yb10PiYKQjZ6eijOZsMm1hVLfe8d5gz/ZQSj1K9C+ChgQM1ZgzrWSTiVDXv15NqJMde3AUz/F7xvjtGfwthybE9Pt4WvvZqUL3InatWsH+5mep0lFzhN392c3KrePm7Fkwlon5NQT8QjFHXx1U1ssiGgI+J0vXQig2a0oqTIh7RvyZ6/KgO5YqaQ50yZX3l8RceLCCgAPN08VyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBZEx3+M1dpgJz5pCvzWc6lb0zf8dJwIdJRymsSQKBQ=;
 b=iQ1oxSBYg/VVVIJHM3GE7lG/TyeFdqJwuIo8+UO4tDUsdvrGvWnXChq8bhwain0YQZdVPvJE64AifKrA//9ODHsrknDoCUhvtYQRU6uHxxsrRJxpNZ0DH81Vfe8AiqR7AVVE9nN0puJHf7b3ymhU3DDR8DJ3FwPeY6BDh0lXzL/m96Ia4vfCMsjjrc86aeXdE9uDOB3BKdMF1MaIr61g35TPvwCFwkOn8kBD7fIc3Y861EXHMT7+x9NWHwaNi9a0jgocpBpDrL2xFkH0svyRcZudDDz3hkO6Z2SmRPBnVuDmG6j4rXrhlhJHaVR0eUbxrI2oxELESEBGXz3Mx6OAnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bitdefender.com; dmarc=pass action=none
 header.from=bitdefender.com; dkim=pass header.d=bitdefender.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitdefender.onmicrosoft.com; s=selector2-bitdefender-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBZEx3+M1dpgJz5pCvzWc6lb0zf8dJwIdJRymsSQKBQ=;
 b=j9LXHNqsjTrObGoWMs4l52TfEmHc2RMJM1W5+7P6z5QYPW2ly1IRmlDbD9dO6QqzkSf31CPOSQ+mCsSNHsC/WDbLo+F/6e3Zn29/aYU7EJR+rQki0btxu5yd8szhttOZ65IyWXy6qDTdRDSLui+eJ9rQ+UA4S2+p7NzzPXWu3+c=
Received: from AM7PR02MB6082.eurprd02.prod.outlook.com (2603:10a6:20b:1af::16)
 by AM6PR02MB5542.eurprd02.prod.outlook.com (2603:10a6:20b:e6::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Tue, 19 Jan
 2021 19:06:00 +0000
Received: from AM7PR02MB6082.eurprd02.prod.outlook.com
 ([fe80::acfe:b76b:c9f0:5229]) by AM7PR02MB6082.eurprd02.prod.outlook.com
 ([fe80::acfe:b76b:c9f0:5229%5]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 19:06:00 +0000
From:   Mircea CIRJALIU - MELIU <mcirjaliu@bitdefender.com>
To:     "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH] bpf: helper bpf_map_peek_elem_proto points to wrong callback.
Thread-Topic: [PATCH] bpf: helper bpf_map_peek_elem_proto points to wrong
 callback.
Thread-Index: Adbulf52B1aWsMMHSjiXek5KBGg64A==
Date:   Tue, 19 Jan 2021 19:05:59 +0000
Message-ID: <AM7PR02MB6082663DFDCCE8DA7A6DD6B1BBA30@AM7PR02MB6082.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=bitdefender.com;
x-originating-ip: [95.76.23.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd70c738-ecd3-4e82-bfe6-08d8bcad4257
x-ms-traffictypediagnostic: AM6PR02MB5542:
x-microsoft-antispam-prvs: <AM6PR02MB5542D2FCABBAE99241B68F5DBBA30@AM6PR02MB5542.eurprd02.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:393;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dF07KPl2YCgdi5FzObx5dy7INBLHS0jwkyKyMexZx7QUZGNhW/VrhE5XwLdqaYxLyK8mt32W3+bkKd/AkNOcW6TaDgtnQFbZoOGetdVaIAI3yrqWFhwghKFshw60vF+jmZTtk7bBB45UnagkH/Frc5iuhtYwCO4InBwiwQ7Gy6jzlGVuznGS/SsgszhYp42C29PrbQVMopRNGkHLGC10nP0TgeAafYpJdoA50LxGwvDWKzcTcrSNOh3Nmnh2SMbSKEg13MSAfV4rkblKMs+UVupr0VHdBxDc1y13DU7JUoxgywf5SmNikk/rfE7BAeeoqnctX60ZHbNuyC3B4VlebKcRuFuUfIjX/VfFBzWEuw9IYZczLMXMRDzw+i0qkEP9s38kJe/bvWXZAl/U7CY5TJWXXauRkOh6VqA1OTiryOTLaK4u1YeJpeUgiiY856dJEZnGy/Y5NEPZztItKPu8iiHWO4BDE7EB7zIBrT0IunH1wCvRMx3KBO/lANA9isYO4QCzrfDg1qA13+YeQhmfiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR02MB6082.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(346002)(366004)(39850400004)(6506007)(8936002)(33656002)(76116006)(66476007)(66946007)(26005)(7696005)(71200400001)(2906002)(4326008)(8676002)(64756008)(316002)(66446008)(9686003)(55016002)(52536014)(4744005)(66556008)(86362001)(186003)(110136005)(83380400001)(5660300002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?CxuaplUQ/TjdBtBr/VCoLdkorThW/h1TTzT7Qbdhy/QjQfyGi/T6o3HoH0en?=
 =?us-ascii?Q?t3VMRwaEe73FrzQ2rZ3xypmcKn5A7YaOIujtf8NckC0A86b4li6Xz5gI1IUO?=
 =?us-ascii?Q?6LE0zalJXdeJZJxxXvwZWIynM/zRXET7z+g/O6oDw/nGC4LDJqz/l9DSxjP9?=
 =?us-ascii?Q?uVeTP9W/fTGDIXfQpcqrVlOZ+M309k4deATQW/AnL3PCuH5XxRo4A8YTzcl1?=
 =?us-ascii?Q?OJRXuLYb1moW1+mp1YrGmhF7KhVFDpUkwKUia17yt/c7ZWJWp7VDH/y4qzGy?=
 =?us-ascii?Q?cu/qSwolL+rAGH0ufvLP58i7UPwlIdEGfDOktMkmspE6GKXpdleFQSL/WpVJ?=
 =?us-ascii?Q?r1Aav0UbKpd/WLJNSo3mzmxBFkTEjGgME9HjsYVQqN5XiTcsXXmmr44cGPeK?=
 =?us-ascii?Q?yDJsoISjLVVe+XlAofm8kIXtaMHI23kSQezDLVzeOnaNdIFEN8jIoiJ35ZEG?=
 =?us-ascii?Q?jO/ImTFMrOlNWjD/Srhpj3k6GIso+f6ZctINeQf4ni/pGZLEgGU3tHhj72Mq?=
 =?us-ascii?Q?b0mFiZBug0kYsZSl7x+rbHXYaJwBZoNJP6vN5N7deu8/ocfcP6n4IyIgtoHG?=
 =?us-ascii?Q?UKgqMEtV2x4zWkdUUbKfr5IHN9RPNbxyEfeNJont53SmuH1wLRAa9EyI+qPf?=
 =?us-ascii?Q?eTtR0aij40FFdGem1hqmIQDkhAkiOoNJnDwZud3IDxgfZauDUwgQzIBd/2I8?=
 =?us-ascii?Q?82Pxpf3rbK3yqkLyDavfgbdFd57fILuKDItAiF/G7VU4XwaSOdk5hmgDUsDq?=
 =?us-ascii?Q?N14sSaLEX0SO+ovH4orCSWFm2LEcbsRy7Y/N0D0RuDQ03NCIJg9kTwYBlzRr?=
 =?us-ascii?Q?oGxHUUbpKJ6VyvpQPYgAl0RDFZVtL8ZYXuyG8c9VYRIbqUUJ++OsPfcj36nx?=
 =?us-ascii?Q?Sud9B1Yaz+BD3FCwYt/lKErgUr1Iql4h27qz+xrqs+NS2khNfMxOXg8ZkeeE?=
 =?us-ascii?Q?Z6meDTyceos4aRCrqxLltCVaVbwQf5j61tTNKSvAIOY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bitdefender.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR02MB6082.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd70c738-ecd3-4e82-bfe6-08d8bcad4257
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 19:06:00.0490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 487baf29-f1da-469a-9221-243f830c36f3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KjkVgW0/FTT0EmpqohT3JUFRLoFJu29ISVScwoQiccnQDr86fnEglZ15RKt13eU6E4CPq5rxEmpU0wV7TRVvD6wlAUchrbL04e+DfaN7plA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB5542
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I assume this was obtained by copy-paste.

Signed-off-by: Mircea Cirjaliu <mcirjaliu@bitdefender.com>
---
 kernel/bpf/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index bd8a3183d030..41ca280b1dc1 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -108,7 +108,7 @@ BPF_CALL_2(bpf_map_peek_elem, struct bpf_map *, map, vo=
id *, value)
 }

 const struct bpf_func_proto bpf_map_peek_elem_proto =3D {
-       .func           =3D bpf_map_pop_elem,
+       .func           =3D bpf_map_peek_elem,
        .gpl_only       =3D false,
        .ret_type       =3D RET_INTEGER,
        .arg1_type      =3D ARG_CONST_MAP_PTR,
--
2.25.1

