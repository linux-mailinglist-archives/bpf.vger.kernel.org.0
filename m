Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660483AA536
	for <lists+bpf@lfdr.de>; Wed, 16 Jun 2021 22:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbhFPUYk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Jun 2021 16:24:40 -0400
Received: from mail-eopbgr670074.outbound.protection.outlook.com ([40.107.67.74]:17999
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233355AbhFPUYj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Jun 2021 16:24:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InDD3cI4NBT8SW3YdLPqebDH1u1kxiFVeoXk8+CYX5gQTynWCb7VojV/+uP0fCR8UI6vXUQobvfxB1acREXwT7bOczwqFncaK7gJbY4gqhtf5Ku1C40DuiIeZpHWaLs4ZdXU7TKoeFrz0jOSnaOycHnOZNiOTpKxxsTQfK68MvWLMfizhSo5gAFgAi2Yrevft3NyoMe6u7dP5ZqyJRUlMxfnCoxXJ1v2kUOpBEODinTWf56u2KZ+tjnJD4tmkV/iYetN83npXx/my3kS3KkSs6KPi+rSBb/Epxbsl4+Vcl+5OklXkSqWob+n5/e1LkT9mX8RYG7k5uYCLuNY7d3hnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsdoR0A3MM4UilHIzeQ+ZFEB8waofxmOvFqFJUG9sMw=;
 b=LeHREWajzDqp+kb23fAwiSdok94i2Oi8jvZynpq7jQppti5GYWbt47jtSZtRQONg3750djzAXXw0aeLfoms1o45QVouVaUst0muxxmwZDp0mFmg7y3cjI+CFVtaMHkDgazL0kPnRjjFmTpB0Yp/SlwK15vyUmi8E8LzYvR6VNBlJbjigJkavgZ1BaSEd1X5LzDioH5cBrpY19ZNyUIy73sJ5areOc67DJ3zcbt7NbVNS58SR1GwNMmSUlzykC9AKOCuiptnhEZqus89EFZ0NksNI4ZP2hhEUOyh3wAMxmWo8rF4rf02WzJ2vxaJe803y/Z7VzTedieSBUYr37mh5iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=165gc.onmicrosoft.com; dmarc=pass action=none
 header.from=165gc.onmicrosoft.com; dkim=pass header.d=165gc.onmicrosoft.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=165gc.onmicrosoft.com;
 s=selector1-165gc-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsdoR0A3MM4UilHIzeQ+ZFEB8waofxmOvFqFJUG9sMw=;
 b=Q1Iz8x/wp3KLZxMFrjlIKOov7VF3ZLo9yv31ZGLWSyXddbsKdw666UJGmoZy05s4l/HHEPJQRDfs5ID8MT8VK4N2myf8TPDRR1+77MeNrtQU8HSzXUAV2U3+uuTBgBSMfLGR60IA9gjO1W5NhnVTaQpISvJUSPyQdSfvsJbBxK0=
Received: from YQXPR0101MB0759.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:17::24) by YQXPR01MB3863.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:52::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Wed, 16 Jun
 2021 20:22:31 +0000
Received: from YQXPR0101MB0759.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c132:2223:87d:9e86]) by YQXPR0101MB0759.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c132:2223:87d:9e86%6]) with mapi id 15.20.4242.019; Wed, 16 Jun 2021
 20:22:31 +0000
From:   Jonathan Edwards <jonathan.edwards@165gc.onmicrosoft.com>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH] add multiple program checks to bpf_object__probe_loading
Thread-Topic: [PATCH] add multiple program checks to bpf_object__probe_loading
Thread-Index: AQHXYuz5AR1ZJMlwh0uuYAkX3/XW3A==
Date:   Wed, 16 Jun 2021 20:22:31 +0000
Message-ID: <YQXPR0101MB075902232E6458F07FBB78E39D0F9@YQXPR0101MB0759.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=165gc.onmicrosoft.com;
x-originating-ip: [174.91.65.25]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb71a9f0-b8d5-4dff-2e87-08d931047845
x-ms-traffictypediagnostic: YQXPR01MB3863:
x-microsoft-antispam-prvs: <YQXPR01MB3863E09FCCA1AC3BC7A8B1BB9D0F9@YQXPR01MB3863.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: caFfwudiUr4BVqI9F22L4Ak0Q7oa/aYAlVhJi9Co0OdRVZZQXdszISdZNxMVdxc3ZElJgW5PGxpBom4EJ5Pn8bE01tWvG78fqi8ejhF5Z7eRQuPXk2DwOY4TDkX3kIna/HZ2HVjc4LotLvf557r1rcxq/zoVuPpk3hsyW4/irvzX0Oz7AhI0PUoDhI2Bd+UN6YyIwsG0gCNfpJiRMmQVMVNLQFzD7C4u+Y4kdTPEZUVe4nrlfHlPT77Ut3CvSzusvmbSCEplYMqc2B2xExfI0duMCSJtgAoECrmhPu1H5GHHNGAK2AE5DhXYyeD8mzALlJi4YJ2iBNLShxB1owgxHawMW+T0OdAA46TAiwtts8/5TZdnsQzr6IbFAfjuvLVJhKeuXWkHvEyCf5tN8XEhYl2fgvjItChNtb1+TOWBQSw4wfoydqu9FJQqgPsrxPLd94EIh+tKwJa3/71zlpOZzuQf4P/lVGdBhNjWJ18CvEeQSWphumsB8cDXded9POmyVeK5IDOjpoqGClYVOMRy+Uql2aM5g7An1nOEV484qf45PIW89xD3TyTodT7eVvtTmwfNMzywuHzjmieeEpRk5EBDuGnKGVCe5G6TGAPXqMQR2PtnkoCEQKBmsb0qwrTru+0M0bGzXNL0alYMhlKmgHMWlNr3kqdaCa1GJfrWh8nno6IsxfHDvVLnc5pAC8OgNTX5+PTzYFj/rH23Kgic6AGYUCTTVn5jPLA7Mxc0hwk7fl36v5Vb6NkC7ZzO0M8G3qD38e4pATFi/aVzZDyAlw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR0101MB0759.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(396003)(136003)(39830400003)(122000001)(38100700002)(66446008)(76116006)(64756008)(6916009)(55016002)(966005)(66556008)(66946007)(7696005)(44832011)(316002)(66476007)(33656002)(5660300002)(83380400001)(52536014)(478600001)(86362001)(6506007)(186003)(71200400001)(8936002)(2906002)(26005)(8676002)(9686003)(101420200003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vJLj1aythin9ysJqzENTNmTENv76nQ1y0L8rd2CecFgQ5xHi5P+IgsruGf?=
 =?iso-8859-1?Q?7+20yOnVgwSvZ0mbDzusGG6dtMu2hMozv5SfRwtZLF8MfIz/uwlbWW74rK?=
 =?iso-8859-1?Q?cCL2Flt560bUFmOtHrKIyuklfw6rZbC+7xer2C4uakmI72EeESPYrWrJTY?=
 =?iso-8859-1?Q?MQCh9/wm03FL12fVoFMfaOFCsAs6XF7im67Q4evibLYUpyyBlvUEn9KiX0?=
 =?iso-8859-1?Q?Im/X05fV7JIsDqS/tGrBFf8VTJxY06djol/JqTtWO5mDOxkzpahVRCmcvs?=
 =?iso-8859-1?Q?wPVw9HKRljwuA9riv81F/G4NoyBjYAV9z6GeKYtOJXABQ+qDp93YHn6Vfg?=
 =?iso-8859-1?Q?1BM+2dVxX0rP2pmn+11T7W/7wECvKAzFGglLgOTGLZxNGz3x5wObjZ1KkC?=
 =?iso-8859-1?Q?IezSOPoD6u3RRBK9+yp569K7pqwj4gsLlLBI0nJb616FwXinvS528Jew4v?=
 =?iso-8859-1?Q?DNQ9RPBVkHMLgbbgSferKa7NRCLWyMIGNIZg5TRDNMUFYuPYIdH9VYu8xH?=
 =?iso-8859-1?Q?JNg/VL7gOtyFjd2CCO63XD4r9UzqYMo8Tn5drwuQsuWrYNxNr3nqJ/gYte?=
 =?iso-8859-1?Q?JK5Cg5BmZeYv4TYhK+mlKvMCakeC1FULD5zguKqZ2Wyo2Zyg4AZ8g0kJUr?=
 =?iso-8859-1?Q?rAIycqRBSzbGOB4mEiyhZHev4kKJ/mb84twjy1r8LkPulqARFqUh1LwbSY?=
 =?iso-8859-1?Q?M2tJVi/aF310Kh6waCP0DCNqk5Vu6SuYQ2cwRUsYCbI2Ac7yDtJT3RD/WE?=
 =?iso-8859-1?Q?QAk7He4TjahsKDAQQ1kY07Xrmlx3aRiBQ8B8i/rGW44p8KFuBQb+jl7Ex3?=
 =?iso-8859-1?Q?qUhYDw45UQK/jfg9ehHzbD28WKOPCDkEo3FJJ/snUx+3b3K5MmgbzBmMAL?=
 =?iso-8859-1?Q?YRCws6Vy6lLHvhn68L+r7vNQHGQpBibEU4//zWkzhXhjIX0kW/O5fhMI58?=
 =?iso-8859-1?Q?GWzc3RRh5RFvf7TSdqy8tyBWugH/4zmlXaO+SCCrCso3W7unILnI5spkh/?=
 =?iso-8859-1?Q?h3Zpn8aeZJ6n42FyAyPyULnifKacISJeUF/E5j0xFY1kS+w0MMNRg061qd?=
 =?iso-8859-1?Q?XgVeq2rrCRTkoDl2Uh90ZqO+Q/UbYIEBcagMGqQV3Hjap8gCDluB6KLDzt?=
 =?iso-8859-1?Q?2InAUKEs6xtIqfAPwsGkl66DBtRg67I6Q/dTQzdA26tvbK001UbycM0/xh?=
 =?iso-8859-1?Q?DR56akV7CIqCmT1rQr2DMZgcnPVrGfztlxoye8WeEh3m3fjv5IhF6b4SoE?=
 =?iso-8859-1?Q?OPC7RfVqJJm7RgrrcMJUMczddLTDRXkvHQpIcO25YDMViC7z8+SVri/kiQ?=
 =?iso-8859-1?Q?mU9Lhuh4TDjr5AzDm9wXSANRLczg5fVrpClm2lXTPh7YXrU=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: 165gc.onmicrosoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQXPR0101MB0759.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bb71a9f0-b8d5-4dff-2e87-08d931047845
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 20:22:31.6036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fa9b7bc4-84f2-4ea2-932a-26ca2f5fb014
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dq9e4c+Ake6UUIY05Ov/DR54yEWfiUDMetnrsGk+bM7RWjqw6oNgAR3D3MWcCdEXqWgGBVWRSq7wnydZsMWImrX9WPnPlEuBawiERO4uhUcZVsAWZNHJ+HNFELZbIXle
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB3863
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

eBPF has been backported for RHEL 7 w/ kernel 3.10-940+ (https://www.redhat=
.com/en/blog/introduction-ebpf-red-hat-enterprise-linux-7).=0A=
=0A=
However only the following program types are supported (https://access.redh=
at.com/articles/3550581)=0A=
=0A=
BPF_PROG_TYPE_KPROBE=0A=
BPF_PROG_TYPE_TRACEPOINT=0A=
BPF_PROG_TYPE_PERF_EVENT=0A=
=0A=
Source is here: https://access.redhat.com/labs/rhcb/RHEL-7.9/kernel-3.10.0-=
1160.25.1.el7/sources/raw/kernel/bpf/syscall.c#_code.1177=0A=
=0A=
For libbpf 0.4.0 (db9614b6bd69746809d506c2786f914b0f812c37) this causes an =
EINVAL return during the bpf_object__probe_loading call which only checks t=
o see if programs of type BPF_PROG_TYPE_SOCKET_FILTER can load as a test.=
=0A=
=0A=
Quick discussion with anakryiko (https://github.com/libbpf/libbpf/issues/32=
0) indicated a preference for trying to load multiple program types before =
failing (e.g SOCKET_FILTER, then KPROBE). On older kernels KPROBE requires =
attr.kern_version =3D=3D LINUX_VERSION_CODE, which may not always be availa=
ble (out of tree builds). TRACEPOINT will work without needing to know the =
version. We can use multiple tests.=0A=
=0A=
The following suggestion will try multiple program types and return success=
fully if one passes. TRACEPOINT works for the ebpf backport for RHEL 7, KPR=
OBE on newer kernels (e.g 5+)=0A=
=0A=
---=0A=
 src/libbpf.c | 6 ++++++=0A=
 1 file changed, 6 insertions(+)=0A=
=0A=
diff --git a/src/libbpf.c b/src/libbpf.c=0A=
index 5e13c9d..c33acf1 100644=0A=
--- a/src/libbpf.c=0A=
+++ b/src/libbpf.c=0A=
@@ -4002,6 +4002,12 @@ bpf_object__probe_loading(struct bpf_object *obj)=0A=
 	attr.license =3D "GPL";=0A=
 =0A=
 	ret =3D bpf_load_program_xattr(&attr, NULL, 0);=0A=
+=0A=
+	attr.prog_type =3D BPF_PROG_TYPE_KPROBE;=0A=
+	ret =3D (ret < 0) ? bpf_load_program_xattr(&attr, NULL, 0) : ret;=0A=
+	attr.prog_type =3D BPF_PROG_TYPE_TRACEPOINT;=0A=
+	ret =3D (ret < 0) ? bpf_load_program_xattr(&attr, NULL, 0) : ret;=0A=
+=0A=
 	if (ret < 0) {=0A=
 		ret =3D errno;=0A=
 		cp =3D libbpf_strerror_r(ret, errmsg, sizeof(errmsg));=0A=
-- =0A=
2.17.1=0A=
