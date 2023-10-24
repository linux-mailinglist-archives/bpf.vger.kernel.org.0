Return-Path: <bpf+bounces-13174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6587D5DF5
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 00:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BED031C20CAA
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 22:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3233B798;
	Tue, 24 Oct 2023 22:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ScfbKZHU"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251052D611
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 22:16:20 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE125128
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 15:16:18 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OIdDvo017068
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 15:16:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=xkHf5Vdc7lPOz1CtUSBfDlxPmoTyG43p3r5s3Xnc4/g=;
 b=ScfbKZHUTGzI+wvORvWZQR78Ng46HosG47iQ2c7e/kkOccX4oytX5piX2Q8sv1M6c4+T
 jaGmBO56DIIcdkaMksrTbNI9zKYFCnToSuCr3EzEMOpmfc+Zjyi5sNLsg4FQQph4BwrM
 yfD43EWhj1iUc2RzLISVEyTP2HUT5Lb2rX9o1XThgFBsjsro4d9xCPPQfLH5RX1iuR2o
 LI+Bgji2UqmFRfdxclZpalkyZF+dSSq/a5GVD+da9LZIvqop+2n269KYq+PEuh+2QNSr
 cMP4kjfQCaQOVzIbmNUORlodleE21g2yrFaKC4v+lzRS7TVQJxpKuhYOiaIvum25Z6Ps GA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3txkcwsayu-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 15:16:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ssu9f+BEJipSCkY5qy0H+P4zXzygGXmpcksCBox8JGjq6pj9Zs8bpRPZKx+nbMcClN6dLcP3LuuiYIV+byx9rwlWB7/QxZZNavg5HP8HeIOalhQTGuEMMrTUw8tKKbgA/qkSRbiz+oQI0umyl9z09LdPHqsCFzM0w4IsxCoAFLFCSoY4DS+wA1Ik1ppVMgpQa3CLEzQgr6NCaLrPWdhL+ZuPK2KsMBsVnhUQ29JHYEUxuFpBy38SBzcqKr0WDaKixbgfSSJPTzPk9UQNaWMadxm0hhmj9PjTlthNOHYTJFMMdwgz4TaslKBQQZzwEAQ9A3ebxbbXCxBN6QXlb9bd4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkHf5Vdc7lPOz1CtUSBfDlxPmoTyG43p3r5s3Xnc4/g=;
 b=OUvILtUX8xmn/2OeQuYfRX5HCuWH3V8StnIanauSQppn2Z4VchcPJqLq1fxIuiJVF4GvM5JeQzs1ZHp2NOZk+pnj9aRAit+T7g2gq6XWZsqBkb7m+LhlRfPssk3w1M4Bdmtcx6JmcGrzIjBBFCfhVJOfYBLB8uoHGx6fVK5EtYzY9i9fvdySsYwSpkVUFSFazykFVEQGlc9VNIihYDePqsg7vTMioocaZ9GqyA6jbKQw1HYHfrx0XWeIvYOps1kHXeuTDfwWyrmhkL9JZjBXjyPL/AE5m580cAYWYB5asj21cjqL9Emmgn8MwGKaQyktSzsc94In6CKdQly0QdP5ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SJ0PR15MB4501.namprd15.prod.outlook.com (2603:10b6:a03:376::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.14; Tue, 24 Oct
 2023 22:16:14 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c495:8487:66f1:18be]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c495:8487:66f1:18be%4]) with mapi id 15.20.6933.014; Tue, 24 Oct 2023
 22:16:14 +0000
From: Song Liu <songliubraving@meta.com>
To: Jiri Olsa <olsajiri@gmail.com>
CC: Song Liu <songliubraving@meta.com>, Song Liu <song@kernel.org>,
        bpf
	<bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Ilya Leoshkevich
	<iii@linux.ibm.com>
Subject: Re: [PATCH v4 bpf-next 6/7] bpf: Use arch_bpf_trampoline_size
Thread-Topic: [PATCH v4 bpf-next 6/7] bpf: Use arch_bpf_trampoline_size
Thread-Index: AQHaAe2ZfpaJB5njXEqwnaK0GTInKrBZdosAgAACCYCAAAZJgIAADKGA
Date: Tue, 24 Oct 2023 22:16:14 +0000
Message-ID: <CAB927C7-5EED-4A5F-B7C7-847DA99B46EA@fb.com>
References: <20231018180336.1696131-1-song@kernel.org>
 <20231018180336.1696131-7-song@kernel.org> <ZTgwkGP5z519re/0@krava>
 <5FAF1455-7EB1-42C8-BD72-213A92A5F43B@fb.com> <ZTg3i4FeZQnfTVC7@krava>
In-Reply-To: <ZTg3i4FeZQnfTVC7@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.100.2.1.4)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SJ0PR15MB4501:EE_
x-ms-office365-filtering-correlation-id: d8e020b0-8dbf-4c61-ca9c-08dbd4ded61a
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 FAFtaoo5sfsEG2oLLLLYJV9vENFpcYxJ6eeKEpv6J/4lVnj+QeqBEhPGBU6jbV4tEHM2qWj2QjVTAzkrYdtEfdpJs3fw4JXpXmLBBfkd4uu0YeaRCaFdvVvCyzyTW4Mid44o1/XslYnyuliGtfZyIlcJp/xyxUWqkh90+K1AIbCjQlQZFpupK0cCSyex9XgNwUPiRlrGYt9mI//yDjdbOpl1KsrqxDdn0vW9rb+MesMtlG2KCG4//Dfk+GR3ousP5TmkpmeoUhHHEibKzfnzCDxWX79w1HokZynrS74Yt+t/3uWdjPEErHs01olYO19zn6JqlCkrneJIERv7oowLeDEZHC3jYR82Kqwwetl6L7UjTFpqUtq1eFRUiA5CrxIPER7tts/h0n9cddFR0QCrrYmS63VU9VvytIHRJXyEWkehkcJaLyPNK2neMceR+KDliCAT/ByZJjaypr/FNqdK02/h9oeDZu+r5hR2at3ixpbwfG+GcWxD0kzdOKG/RkNvgZGLxLK8VbWqLQfaIgvCzE9DJ/OPqFCHxHXzxRdig3wJqImC0QBBJUR/ewEE/cnw2ji6CtfAKZ+ZWeiaYR3l5R8kELGeXBqgAGMnY2mZ7R8hSXx54SJw81gOdTKCR09/
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(366004)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(71200400001)(53546011)(6512007)(6506007)(9686003)(36756003)(122000001)(66556008)(33656002)(54906003)(64756008)(66446008)(66476007)(316002)(478600001)(6916009)(6486002)(38100700002)(86362001)(76116006)(66946007)(91956017)(41300700001)(4326008)(8676002)(8936002)(38070700009)(2906002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dUhRV2d0aS9HZTU1UE9aeHZWYUk1Tlh5ZGd3a0F4S1ZRaGhoY0JLSU5QVitX?=
 =?utf-8?B?TlFHNDMrcUVZL2IyN3Q5bEdua2l3bGNKbTZsTFVjSi9WWDdSZ0pGMzhQS2pn?=
 =?utf-8?B?bi9lUHpCdFRXMVdpNmtzTmR6bnpaTzh3VTVxOE9FTVpMWlRYNFlrUjBNY3Fo?=
 =?utf-8?B?RVlvcVg5emhuOHF3Mno1SnVHMzlYZ1hCQThpMHRxVmFaL1JNUWJEdnpEeThW?=
 =?utf-8?B?dEFuQVRkM2s1bk12cDN4MWlRenEya09KUUkwcUthU29xZ2ZPV3VHUk9aZ1p3?=
 =?utf-8?B?RVJ1ZkZkVHFUcklGUmJVTWRxTmRwSzkvbFRNU1JwRUp2cDExMThyclJyZFZR?=
 =?utf-8?B?eEhra1VWSER3cUlkeFRBbjcvbUY0Yzd4bktjbEdVcWlmTVorWDh4M0YzR3Jj?=
 =?utf-8?B?Wk1jTk1wVUdUeEQvaVdPN0gxUTVsREpDWTBhd1NNaG92anZxMFVYQ0FFR0pm?=
 =?utf-8?B?ZHJ1VEFlZ01Qd1hYcjM2TEJGVmhRKzRsYVIzOTJZZ2xWa0ZRZlRtdFlvWjU0?=
 =?utf-8?B?U2pVVGJaSWY5VW5SeGc2b3JINFZCZk9tRVhGVWdueldzNmNRMGw0M0xGS3FT?=
 =?utf-8?B?djRlYWt3RzNTS2Rxd1AwbFJCOFNNZ0g4N1dlYk1XMkNnNWhhNjlPSTNCMWoz?=
 =?utf-8?B?V3IvdWVTYy9HSmJhY1A2eWpFYUpJQXY3Z2pFeUNTOFM4cFpHdVc1alhGbVoz?=
 =?utf-8?B?bVJSWGVJNFM0bkhxTEliVklRTU9SSW5UZDZFeUpxclZ6eTNPZ3owczhJek9a?=
 =?utf-8?B?RVhGWmI5alJUME4rWDBEZllVVWZWL0FkZHhMM3BuYklDWjJsblNlbXBWQUhN?=
 =?utf-8?B?Yi9PN2M4aG1oc09GM1dFRm0xT01vM2NWcHlRbGkwd1VSdlFqMnc3SFdrSzRX?=
 =?utf-8?B?emhWV3VGcEF1UDgwdEVNM0ZHMmJ4TFY0NndQSDVUMTVTcCtYU0hGenpUWmIx?=
 =?utf-8?B?QlVoVWdhMzh2TTAvOVE0TXBYUkdBdWFkL2hPKzJNVXlkTHNHbkZQM2NVZ2xE?=
 =?utf-8?B?YmlxRGk1TWtiN2tFTkJwbVZWNWhNZldSL3RsWUExaFFxM2srTXVOdSttVlgw?=
 =?utf-8?B?cUNVK3NQMk1FWXhOV095clNQK0psUER3VEJob2FISnY2NHUwcjhRcFVGMWdp?=
 =?utf-8?B?cHU3QW9JM0ljR1VrQnd6TytVZlJ2aTZvd3dwYTZLZVpTaW14RnhwbjZmMlNa?=
 =?utf-8?B?blA4ZDZ3dytzWWRVSWY0ZWFVTFU0Ull4ZERSZGZzU29pSnh0QmVsbWtyRHlZ?=
 =?utf-8?B?Y01CVUhtVFhNMkREY25ucTFxWGt6UEVRd3RwRHUySW9tc3MvcjVxcHFJNnc2?=
 =?utf-8?B?VWFGK3FuNWxKOGt5MjZLSVk1OHZ1WW9kN3lEZU1xS2tuMWlFaE91Wm5YY2xY?=
 =?utf-8?B?TzYrVWhoNHZaS1Z4T2JGMnB1RlFYaW5OUlBQWFBmVmkxZHlBUllTRXVBZUZB?=
 =?utf-8?B?aHdHY3FvcXpEeXBvMUJhdVFJSVQ4MHNNN2x6M0phdW1wWUNRWmVNTGl1RWtB?=
 =?utf-8?B?NzMySjczZTRYZGFKcGxZT0xwSmJnZFBvZHRzVjdhRHVmZnFlUDVIN3RpQzE4?=
 =?utf-8?B?SVliU3BDaWZGZG1MT21tUXdGUjJRS3lrbE8xZnRmS09HRjduSmxCOG5aYURk?=
 =?utf-8?B?bDdrWjdhdXhRUW10UjhYT3BJT0s1Zkx1TjQvbW5WN0JwQ2lnSW9QY1NoaXdz?=
 =?utf-8?B?bnhzYjlkM0Zzak01WU5WbmwxODVqY1ZScnpPWm13MVJPL0ZqMkpabDRtbDhO?=
 =?utf-8?B?OGRlcXlqaDdzbXVITkJQeW4zVzdBMFhnRy9saTFqNjJ5SWhlZUphSFo1RE9j?=
 =?utf-8?B?MWh4MGQyYUJqS3lUbU1pdzdWY0NYUGlub21RQ2xsSkpWaFpYekl5RHM5WnZM?=
 =?utf-8?B?OFFPbWt4d2pZMWtGWmVUbE5Uei9oZ0ZBNGZFSFZ3SzVTWWhUN1B6d2tEbEgx?=
 =?utf-8?B?M2FzcHduMkRPMUZCSE8yeklLbHdPUzNhSTNzVURUSmFWQzQ4d0ZWQkJaeUI3?=
 =?utf-8?B?d0NKTjZTdCtrZCtyUHJhVkY5NEJ5bTR0T2NqWHhja2JjRzlVZllPUWJTalNx?=
 =?utf-8?B?NDFUS0J1SzF3bW10UUFsSC9aTzV5bFpaSzZpa1BEZnlEdjZxVzZPLy8wTXln?=
 =?utf-8?B?cGpuaXgwNjJ2YW9sMW9wbkhQbDlvbDNINkpTSXFvNlg3R1FUQmlxUkhmUHhN?=
 =?utf-8?Q?Qff++qLp8lMROaW+rTMBnkA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBCBD2FA9F23104281146403541E75E0@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e020b0-8dbf-4c61-ca9c-08dbd4ded61a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 22:16:14.2398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SQhAtyB+pDcwxppoOkxVyrxlFtWZRB7jRQ7k58gfXHDaDf1d9DXsqjg6K30AKZYVdKCaGsQaQaS+Ct/V1yPpCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4501
X-Proofpoint-GUID: vsxSmHrPziHAppw-dwRPi0lLsR6xPVZc
X-Proofpoint-ORIG-GUID: vsxSmHrPziHAppw-dwRPi0lLsR6xPVZc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_22,2023-10-24_01,2023-05-22_02

DQoNCj4gT24gT2N0IDI0LCAyMDIzLCBhdCAyOjMw4oCvUE0sIEppcmkgT2xzYSA8b2xzYWppcmlA
Z21haWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgT2N0IDI0LCAyMDIzIGF0IDA5OjA4OjMy
UE0gKzAwMDAsIFNvbmcgTGl1IHdyb3RlOg0KPiANCj4gU05JUA0KPiANCj4+Pj4gQEAgLTM0OSw3
ICszNDksNyBAQCBzdGF0aWMgdm9pZCBicGZfdHJhbXBfaW1hZ2VfcHV0KHN0cnVjdCBicGZfdHJh
bXBfaW1hZ2UgKmltKQ0KPj4+PiBjYWxsX3JjdV90YXNrc190cmFjZSgmaW0tPnJjdSwgX19icGZf
dHJhbXBfaW1hZ2VfcHV0X3JjdV90YXNrcyk7DQo+Pj4+IH0NCj4+Pj4gDQo+Pj4+IC1zdGF0aWMg
c3RydWN0IGJwZl90cmFtcF9pbWFnZSAqYnBmX3RyYW1wX2ltYWdlX2FsbG9jKHU2NCBrZXkpDQo+
Pj4+ICtzdGF0aWMgc3RydWN0IGJwZl90cmFtcF9pbWFnZSAqYnBmX3RyYW1wX2ltYWdlX2FsbG9j
KHU2NCBrZXksIGludCBzaXplKQ0KPj4+PiB7DQo+Pj4+IHN0cnVjdCBicGZfdHJhbXBfaW1hZ2Ug
KmltOw0KPj4+PiBzdHJ1Y3QgYnBmX2tzeW0gKmtzeW07DQo+Pj4+IEBAIC0zNjAsMTIgKzM2MCwx
MyBAQCBzdGF0aWMgc3RydWN0IGJwZl90cmFtcF9pbWFnZSAqYnBmX3RyYW1wX2ltYWdlX2FsbG9j
KHU2NCBrZXkpDQo+Pj4+IGlmICghaW0pDQo+Pj4+IGdvdG8gb3V0Ow0KPj4+PiANCj4+Pj4gLSBl
cnIgPSBicGZfaml0X2NoYXJnZV9tb2RtZW0oUEFHRV9TSVpFKTsNCj4+Pj4gKyBlcnIgPSBicGZf
aml0X2NoYXJnZV9tb2RtZW0oc2l6ZSk7DQo+Pj4+IGlmIChlcnIpDQo+Pj4+IGdvdG8gb3V0X2Zy
ZWVfaW07DQo+Pj4+ICsgaW0tPnNpemUgPSBzaXplOw0KPj4+PiANCj4+Pj4gZXJyID0gLUVOT01F
TTsNCj4+Pj4gLSBpbS0+aW1hZ2UgPSBpbWFnZSA9IGFyY2hfYWxsb2NfYnBmX3RyYW1wb2xpbmUo
UEFHRV9TSVpFKTsNCj4+Pj4gKyBpbS0+aW1hZ2UgPSBpbWFnZSA9IGFyY2hfYWxsb2NfYnBmX3Ry
YW1wb2xpbmUoc2l6ZSk7DQo+Pj4+IGlmICghaW1hZ2UpDQo+Pj4+IGdvdG8gb3V0X3VuY2hhcmdl
Ow0KPj4+PiANCj4+PiANCj4+PiBoaSwNCj4+PiB0aGVyZSdzIGNhbGwgaW4gaGVyZSB0byBhZGQg
dGhlIGltYWdlIHN5bWJvbA0KPj4+IA0KPj4+IGJwZl9pbWFnZV9rc3ltX2FkZChpbWFnZSwga3N5
bSk7DQo+Pj4gDQo+Pj4gd2hpY2ggc2V0czoNCj4+PiANCj4+PiBrc3ltLT5lbmQgPSBrc3ltLT5z
dGFydCArIFBBR0VfU0laRTsNCj4+PiANCj4+PiB3ZSBzaG91bGQgc2V0IGl0IHRvICdrc3ltLT5z
dGFydCArIHNpemUnIG5vdw0KPj4gDQo+PiBHcmVhdCBjYXRjaCEgRml4aW5nIHRoaXMgaW4gdjUu
IA0KPj4gDQo+Pj4gDQo+Pj4gYW5kIEkgdGhpbmsgdGhhdCBjYW4gcHJvYmFibHkgc2NyZXcgdXAg
dGhlIGJwZl9wcm9nX2tzeW1fZmluZA0KPj4+IGFuZCBpdCBtaWdodCBiZSB0aGUgcmVhc29uIHdo
eSBJJ20gZ2V0dGluZyBub3cgdGhlIGNyYXNoIGJlbG93DQo+PiANCj4+IEhvdyBlYXN5IGlzIGl0
IHRvIHRyaWdnZXIgdGhlIGNyYXNoPw0KPiANCj4gSSBoaXQgdGhhdCBieSBydW5uaW5nIHdob2xl
IHRlc3RfcHJvZ3MgZWFzaWx5Li4gSSdtIGFzc3VtaW5nIGl0J3MgdGhlDQo+IGV4Y2VwdGlvbnMg
dGVzdCBjYXNlLCBidXQgSSBjb3VsZCBub3QgdHJpZ2dlciBpdCBqdXN0IHdpdGggJy10IGV4Y2Vw
dGlvbnMnDQo+IA0KPiBhdHRhY2hpbmcgdGhlIC5jb25maWcNCg0KDQpJIGNhbiByZXByb2R1Y2Ug
aXQgd2l0aDogDQogDQogICAgLi90ZXN0X3Byb2dzIC1qICAgLXQgZXhjZXB0LGZlbnRyeSxmZXhp
dCx0Y3ANCg0KYW5kIGZpeGluZyBrc3ltIGZpeGVzIGl0LiANCg0KSSB3aWxsIHNlbmQgdjUgd2l0
aCB0aGUgZml4LiANCg0KVGhhbmtzLA0KU29uZw0KDQoNCg==

