Return-Path: <bpf+bounces-14330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A147E2F60
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 23:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B39BB1C204FC
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 22:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EEA2EAE2;
	Mon,  6 Nov 2023 22:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="XdO6/EWe"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5348F5247
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 22:00:43 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56B7134
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 14:00:39 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6Lo5hQ014561
	for <bpf@vger.kernel.org>; Mon, 6 Nov 2023 14:00:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=Zztva4DuoE2JV/4ADBeIdG/YeRzwkF1GtymcZOHbPKs=;
 b=XdO6/EWeg59EXMSgudqiac9pn8kbW1WDnIuLvqREXrtMPRiDWfqg+3gAnp64RR5Ct3WQ
 /4nkwaOCEl729dU34yCd5D/U90QgwEnUzPAhTckRsJDjn7XQwEbeTd82IMmklcLfvVl8
 +6ubFWfJd8rfTbFaANG/68P+7A1cApj1v5gPRiaz7pDyJfE+wyBpFZLKVheH4jdOyPlq
 OYYpQ7on/vXdrWb9nkmmW8WRAm+XkBjAqGZN+805J3t05+rlGYarZlBzEMBNRH0Zm0/M
 xPl/aT8lxlI9pGJ6uVhfmCyWd9jACqRrc7ks2HQl8XE/sgjPUwh+IDqxyJGwbPmUZhV9 oQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u6ubbx84e-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 06 Nov 2023 14:00:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijcFcvVnqBmivClcLhskHkzfb+OigZJJhj3/tsqLIoA71N8HglwbLmePNQnlnNsxK8VTx5Rcs3OCAz2F8gZgagny+XwBgOZOk0C/qgv5nQc8Xcg/su+E+ymIqRUZ/aFI1dqX5Jd2LKDzgb6d+NWCepUrXW/AB1BHlBSAyty+WpPI+eH+eF93JRhWW2GHYb+mMb6ukwibC64QQe8bkLXAmbHqYizcj0urbqL3cCWGIw/rASpZ+s9UF7wgWnavIz2ZkKDK1SiI2SNbAa+uPoOWDAh/Zcp+ZjU6zuScLQk5eegIX0zm3PbBUhawCEhJYzRQmIeJB5erJ3CMzxGVo0PmBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zztva4DuoE2JV/4ADBeIdG/YeRzwkF1GtymcZOHbPKs=;
 b=dp0gZewRCbh9DuNU4rkPN2HehyNWcisvy9YJsfaHnIcL8+hZOsjFwEptEWVQSNu4SX6nXdyt9lDNQnNDk/yOOK0Bf9efh5MU0rpc/MnfAiSwE8yCYa4Ze9avLKbcDHIjV34qsIg2NVdZkeEqobjEGZ1Fk9kDlFMdztBbCHQUdKq+qvRX9mRVh8oLcW5S2ljHVr34KkWBvWefnddJr5apiD1bWxLpuBsdHMB7zTkC2P6kakIZJqGm398xYy+rinrcBHQuUslDFWEwAETk02Iyb8Wkk+zz87pwpaBIcpBe1zszVKjo8qyXMGnwZxQPoan8FTkBCDtf/e99tXQiqKtLPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SJ2PR15MB6403.namprd15.prod.outlook.com (2603:10b6:a03:569::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.11; Mon, 6 Nov
 2023 22:00:35 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::9052:3362:76e2:146d]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::9052:3362:76e2:146d%6]) with mapi id 15.20.6977.016; Mon, 6 Nov 2023
 22:00:35 +0000
From: Song Liu <songliubraving@meta.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        "fsverity@lists.linux.dev" <fsverity@lists.linux.dev>,
        Alexei Starovoitov
	<ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko
	<andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team
	<kernel-team@meta.com>,
        Eric Biggers <ebiggers@kernel.org>, Theodore Ts'o
	<tytso@mit.edu>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        KP Singh
	<kpsingh@kernel.org>, Vadim Fedorenko <vadfed@meta.com>
Subject: Re: [PATCH v12 bpf-next 1/9] bpf: Add __bpf_dynptr_data* for in
 kernel use
Thread-Topic: [PATCH v12 bpf-next 1/9] bpf: Add __bpf_dynptr_data* for in
 kernel use
Thread-Index: AQHaDrO/jwlprgYk7k+uMf/3z9ZDjLBtzRAAgAAO0QA=
Date: Mon, 6 Nov 2023 22:00:35 +0000
Message-ID: <F6545A31-F23B-4422-A74C-71F8C626A709@fb.com>
References: <20231104001313.3538201-1-song@kernel.org>
 <20231104001313.3538201-2-song@kernel.org>
 <CAEf4BzadqTVe=OPiKb=F63j3pqFPayUddjf17WFw0E47zqEqOw@mail.gmail.com>
In-Reply-To: 
 <CAEf4BzadqTVe=OPiKb=F63j3pqFPayUddjf17WFw0E47zqEqOw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.100.2.1.4)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SJ2PR15MB6403:EE_
x-ms-office365-filtering-correlation-id: 582ea264-1bd3-49f1-846f-08dbdf13cdb9
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 d/dxGGD9CfjGDI9CpZlX8It7FZ9io05q8aaQ937NXokFN55ozjwDj4cpdKltCS7vNIUwAK6UrLwUzVEagYLI/g/AWYGSPKCR+oQxSXj8vQ2Bwb109x8lx0lJlh6GNFhb1PH615qnt0kfLTnAqBPYoYZbry/84rLeLamvmkC7DXZm+ToykvdNTpHEbepegQNgMss/qQMy/Q2x3MsncVXEqhlLtes8CcUirHAuIZbmuOHDNUo3nL/fZvvnP1VMyPxLSLwx/hxkvFwtLxGI96d7rm0All8w6RbHssuTzYGgRVbYMXpX+xRRecaDipwJDrjTRhUlACwpiOtvPon5pmIT0doGEDNm5uIC8DMWyS/FbEh4v4guGBGtPQTZ0NHVCTNzMIYhmwbRU6jGpPOdLxZjIjG3q56WxaD+HUUz5NlXAeaKcpSf6PVOVrUvIdBmREuUYSxGfDfl1Kps0ciF6p9CuIoA2opRO89RweD7c3RRzdzmCVJzOWwf4163M1wgZSbqgeMbhgvet+EiXuPI2z0U4EbV6wvbZF2biVWmgC3HLPSmzYmyEpzDzOT+j9bLzBCJVjXYXZ+iHZ0lbD308cfrVwRNwxwP+AXLECDk/IAzSQFpmI5/KbTuWklodrAftibI
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(136003)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(8936002)(76116006)(71200400001)(9686003)(38070700009)(6506007)(478600001)(4326008)(53546011)(6512007)(64756008)(41300700001)(8676002)(5660300002)(2906002)(7416002)(6486002)(107886003)(83380400001)(6916009)(66946007)(66446008)(91956017)(66556008)(66476007)(38100700002)(54906003)(316002)(86362001)(33656002)(122000001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TEM2VENkU1dFd3FmWWZWbFQ2NkVWOWJVRkJhdjJBTjBPelVXMGxvU0xkZ3Qr?=
 =?utf-8?B?WFJ5NzhMdFZSLytMenY4MUtPSVNCVG5jRTlpQWUrYVpqNTNNYUQ4cmF2QUZn?=
 =?utf-8?B?Mnl0TXA0RzY3Um1WNERiMVAvc3NEdlBjbEJ4WlJvSVByOFFzRUNRU0lOTzFm?=
 =?utf-8?B?dFVYbkJDTG9BSVluUWdiVGVyanVvWmVZWVkwYUVsNnhhNmJHVjVxcS9NcDFi?=
 =?utf-8?B?THhWOHk1U0h0WGN5YitqUTUrVFJqQUtjcllJZVhWMVREVnlKWFRicFNCR1Q1?=
 =?utf-8?B?TTNpeE9zMThyL3MvL2xXci9GOUUrWjh3SCs0UjZORDVQenlOaWsvdDdocFRj?=
 =?utf-8?B?T09TQk9QRnNFcWZiVnFzem9meERXTzY5WWVQa3JYeUNBNGR0UG1Say9lb1pT?=
 =?utf-8?B?eEFmM0xyTzhhL1ZOd2J2Smk2N3BmNmozdVY4S09nVytDSEJTK2M0UmVRYUdG?=
 =?utf-8?B?TVlvbGxRSGJjWEVlVUoxZnA5OGF5aGpoWDQ2RGVWdWMwQVRyNlRJT0Y2blJt?=
 =?utf-8?B?d2ZEN0ovdGtkcGcrV2wzRFpuaTNBd2lsdHAvT3d6eHh0V250UUt1UVFLMFRs?=
 =?utf-8?B?b2Vua2dhRjl3VUg0Z0hNT3gxZkFudzhzZm5hcW52d2V3ZTl2cmtlU0pEVjRU?=
 =?utf-8?B?NVl1SjhOVndITUkvUGlpSkg2Tk95eVo4ajNZL2xJeUVta29qd29tMGFzS0lx?=
 =?utf-8?B?Z1ZnbE5vTnhmZk1DOUNZcDIwWWRXcTM2WVNJMlNJMDRSZVJPc0Uwd2xrS0hS?=
 =?utf-8?B?VnVHcThqYmNCQWFDVmhvMnNQZ3BVeFJQNnRwWUFXSEZ5ZmFManM2dzNDYzJK?=
 =?utf-8?B?SHZoc1JHaGptYXVOTitjUjA0OWJqRDAzVWdjVkhXZ3dSeXZxTGN1aU03NlZR?=
 =?utf-8?B?dElBQWRVM3V5WERoc2NIREUza0lRclpZcUwwODZDclo1WjkrU25VM0diOGxU?=
 =?utf-8?B?eFQ2cGdJbnRzclZJYWk3aUNzUUI1ZEd5aVJwcXA5eDVLTFcxa25YYXpNeElx?=
 =?utf-8?B?dHdIdkZwK0tHZDV1NGkxeVZZVjJGYkdVRTQxTmdPNWpOTnBCdG9wZko1LzBs?=
 =?utf-8?B?VWFRUkhkY0c5MXhvRFNpSGJqSk5qVFhCZW93cTlVaUlhUk9VM1hqL1hvbGU4?=
 =?utf-8?B?UU9yVlUxZldlVmxOQllra0lOOXBoblVNdEFLVjEya1NYQVJad1EveWswZzFn?=
 =?utf-8?B?a1dIZkExUjY1UjZoYUJPdU1JdSttd2NXMVN0aWJCMFQ2eFg4THJoQ29tVDVT?=
 =?utf-8?B?ZVlPMXNFQ0g0aTZjK3dHdms0YzNJVCtEaVZwZ2pmVVlUUGc2NEo1RTMxZTFQ?=
 =?utf-8?B?d3p0QWdEZFRQZVpmVytvcnppR05sVFFLelgrOGxYOHhrRnB5aWpjSnRRYmht?=
 =?utf-8?B?V09acy9BWGdsV1VsVmF6Q2hINWIwYWIzenY2R2JEcHBDZDFmR3EvMWRoTERC?=
 =?utf-8?B?eis0a2JVaUNjd3Jxd0pIYStRdjNYL2hjSGtQNTlRUTBEVnViZi9jeXpCNXp0?=
 =?utf-8?B?Vlc0ODRETDhtV3ltTVl3cTRCRGh0U21YVW4xdytkK2R0QkFKZGg5SzU5NDFH?=
 =?utf-8?B?elRuQlljNUVMc1pEN1FITk1RU3hSa3NzdUFYU1R4Q1R0US8yaHRaZFhibVRq?=
 =?utf-8?B?Z2RDT2FjWVluMjR2MkFJeGlSK0FvMzdwSEZmODRkSGVaZWFqamhHc1lNY0pC?=
 =?utf-8?B?dWpGQ0pvY2RhM0wrVmtiVm53cG9oRzJvcVlPazRvM3Q1R3hQTk9PSzI1OVU0?=
 =?utf-8?B?M3pBbFRvVWk2Y2xTWXpISEVMdU5LMkJUWjFZelViMXA2TWFkd3BaQ1B1cW1Y?=
 =?utf-8?B?bEhXYmJqWU5ENXpTVElNc3MxSnkrNC9uSGczaVVuSUNLdDQrOFFFRlFIb3Vt?=
 =?utf-8?B?UmZMVjJvM2FBV2dyRWN0b3NzM1Z0UFZBTlpFTDlLZU9ZRFNCWWdMdk8wN1Fz?=
 =?utf-8?B?Y3VnMC9Tb3lrUElFdlp6WFZ3NmtXZFJacG5OQVBtWUdvQjJFZzNhQWZTUHJo?=
 =?utf-8?B?WmV6QUNvYkMvSEpzTjJ3YjVSekZvSGt0SElZbXZUcGk5MjNac09JYWNKZXJt?=
 =?utf-8?B?eHgzNWVNdmFkR3lVS1cvRHA2WEt5QjVabUEyRlpKUklXNjRPODdUbkgyVE1V?=
 =?utf-8?B?R2xycUk3a3FnT0IvZCtJeGxXMWQ5WGJCckY4Z0JwWngzbGJpUVF1VlBNcmtn?=
 =?utf-8?Q?NH3S2LypuGk0QYtSmuBQEzI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91178ACC12DA1148A864B30B660EF599@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 582ea264-1bd3-49f1-846f-08dbdf13cdb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 22:00:35.1681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LyRx3NSq1XidA2YahHoduMk5vMHnK+XzWJGF4RvmEcnFoXXSi6aSxPYNmJ2lVQcSgHZRecjJ0YcKg/yFtPGCMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB6403
X-Proofpoint-ORIG-GUID: B7bpn_QLdAPgksLl0A5aiqIiQp52aGLE
X-Proofpoint-GUID: B7bpn_QLdAPgksLl0A5aiqIiQp52aGLE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02

DQoNCj4gT24gTm92IDYsIDIwMjMsIGF0IDE6MDfigK9QTSwgQW5kcmlpIE5ha3J5aWtvIDxhbmRy
aWkubmFrcnlpa29AZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgTm92IDMsIDIwMjMg
YXQgNToxM+KAr1BNIFNvbmcgTGl1IDxzb25nQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4gDQo+PiBE
aWZmZXJlbnQgdHlwZXMgb2YgYnBmIGR5bnB0ciBoYXZlIGRpZmZlcmVudCBpbnRlcm5hbCBkYXRh
IHN0b3JhZ2UuDQo+PiBTcGVjaWZpY2FsbHksIFNLQiBhbmQgWERQIHR5cGUgb2YgZHlucHRyIG1h
eSBoYXZlIG5vbi1jb250aW51b3VzIGRhdGEuDQo+PiBUaGVyZWZvcmUsIGl0IGlzIG5vdCBhbHdh
eXMgc2FmZSB0byBkaXJlY3RseSBhY2Nlc3MgZHlucHRyLT5kYXRhLg0KPj4gDQo+PiBBZGQgX19i
cGZfZHlucHRyX2RhdGEgYW5kIF9fYnBmX2R5bnB0cl9kYXRhX3J3IHRvIHJlcGxhY2UgZGlyZWN0
IGFjY2VzcyB0bw0KPj4gZHlucHRyLT5kYXRhLg0KPj4gDQo+PiBVcGRhdGUgYnBmX3ZlcmlmeV9w
a2NzN19zaWduYXR1cmUgdG8gdXNlIF9fYnBmX2R5bnB0cl9kYXRhIGluc3RlYWQgb2YNCj4+IGR5
bnB0ci0+ZGF0YS4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogU29uZyBMaXUgPHNvbmdAa2VybmVs
Lm9yZz4NCj4+IC0tLQ0KPj4gaW5jbHVkZS9saW51eC9icGYuaCAgICAgIHwgIDIgKysNCj4+IGtl
cm5lbC9icGYvaGVscGVycy5jICAgICB8IDQ3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4+IGtlcm5lbC90cmFjZS9icGZfdHJhY2UuYyB8IDEyICsrKysrKy0tLS0N
Cj4+IDMgZmlsZXMgY2hhbmdlZCwgNTcgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+
IA0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvYnBmLmggYi9pbmNsdWRlL2xpbnV4L2Jw
Zi5oDQo+PiBpbmRleCBiNDgyNWQzY2RiMjkuLmViODRjYWYxMzNkZiAxMDA2NDQNCj4+IC0tLSBh
L2luY2x1ZGUvbGludXgvYnBmLmgNCj4+ICsrKyBiL2luY2x1ZGUvbGludXgvYnBmLmgNCj4+IEBA
IC0xMjIyLDYgKzEyMjIsOCBAQCBlbnVtIGJwZl9keW5wdHJfdHlwZSB7DQo+PiANCj4+IGludCBi
cGZfZHlucHRyX2NoZWNrX3NpemUodTMyIHNpemUpOw0KPj4gdTMyIF9fYnBmX2R5bnB0cl9zaXpl
KGNvbnN0IHN0cnVjdCBicGZfZHlucHRyX2tlcm4gKnB0cik7DQo+PiArY29uc3Qgdm9pZCAqX19i
cGZfZHlucHRyX2RhdGEoY29uc3Qgc3RydWN0IGJwZl9keW5wdHJfa2VybiAqcHRyLCB1MzIgbGVu
KTsNCj4+ICt2b2lkICpfX2JwZl9keW5wdHJfZGF0YV9ydyhjb25zdCBzdHJ1Y3QgYnBmX2R5bnB0
cl9rZXJuICpwdHIsIHUzMiBsZW4pOw0KPj4gDQo+PiAjaWZkZWYgQ09ORklHX0JQRl9KSVQNCj4+
IGludCBicGZfdHJhbXBvbGluZV9saW5rX3Byb2coc3RydWN0IGJwZl90cmFtcF9saW5rICpsaW5r
LCBzdHJ1Y3QgYnBmX3RyYW1wb2xpbmUgKnRyKTsNCj4+IGRpZmYgLS1naXQgYS9rZXJuZWwvYnBm
L2hlbHBlcnMuYyBiL2tlcm5lbC9icGYvaGVscGVycy5jDQo+PiBpbmRleCBlNDZhYzI4OGExMDgu
LmM1NjljNGM0M2JkZSAxMDA2NDQNCj4+IC0tLSBhL2tlcm5lbC9icGYvaGVscGVycy5jDQo+PiAr
KysgYi9rZXJuZWwvYnBmL2hlbHBlcnMuYw0KPj4gQEAgLTI2MTEsMyArMjYxMSw1MCBAQCBzdGF0
aWMgaW50IF9faW5pdCBrZnVuY19pbml0KHZvaWQpDQo+PiB9DQo+PiANCj4+IGxhdGVfaW5pdGNh
bGwoa2Z1bmNfaW5pdCk7DQo+PiArDQo+PiArLyogR2V0IGEgcG9pbnRlciB0byBkeW5wdHIgZGF0
YSB1cCB0byBsZW4gYnl0ZXMgZm9yIHJlYWQgb25seSBhY2Nlc3MuIElmDQo+PiArICogdGhlIGR5
bnB0ciBkb2Vzbid0IGhhdmUgY29udGludW91cyBkYXRhIHVwIHRvIGxlbiBieXRlcywgcmV0dXJu
IE5VTEwuDQo+PiArICovDQo+PiArY29uc3Qgdm9pZCAqX19icGZfZHlucHRyX2RhdGEoY29uc3Qg
c3RydWN0IGJwZl9keW5wdHJfa2VybiAqcHRyLCB1MzIgbGVuKQ0KPj4gK3sNCj4+ICsgICAgICAg
ZW51bSBicGZfZHlucHRyX3R5cGUgdHlwZTsNCj4+ICsgICAgICAgaW50IGVycjsNCj4+ICsNCj4+
ICsgICAgICAgaWYgKCFwdHItPmRhdGEpDQo+PiArICAgICAgICAgICAgICAgcmV0dXJuIE5VTEw7
DQo+PiArDQo+PiArICAgICAgIGVyciA9IGJwZl9keW5wdHJfY2hlY2tfb2ZmX2xlbihwdHIsIDAs
IGxlbik7DQo+PiArICAgICAgIGlmIChlcnIpDQo+PiArICAgICAgICAgICAgICAgcmV0dXJuIE5V
TEw7DQo+PiArICAgICAgIHR5cGUgPSBicGZfZHlucHRyX2dldF90eXBlKHB0cik7DQo+PiArDQo+
PiArICAgICAgIHN3aXRjaCAodHlwZSkgew0KPj4gKyAgICAgICBjYXNlIEJQRl9EWU5QVFJfVFlQ
RV9MT0NBTDoNCj4+ICsgICAgICAgY2FzZSBCUEZfRFlOUFRSX1RZUEVfUklOR0JVRjoNCj4+ICsg
ICAgICAgICAgICAgICByZXR1cm4gcHRyLT5kYXRhICsgcHRyLT5vZmZzZXQ7DQo+PiArICAgICAg
IGNhc2UgQlBGX0RZTlBUUl9UWVBFX1NLQjoNCj4+ICsgICAgICAgICAgICAgICByZXR1cm4gc2ti
X3BvaW50ZXJfaWZfbGluZWFyKHB0ci0+ZGF0YSwgcHRyLT5vZmZzZXQsIGxlbik7DQo+PiArICAg
ICAgIGNhc2UgQlBGX0RZTlBUUl9UWVBFX1hEUDoNCj4+ICsgICAgICAgew0KPj4gKyAgICAgICAg
ICAgICAgIHZvaWQgKnhkcF9wdHIgPSBicGZfeGRwX3BvaW50ZXIocHRyLT5kYXRhLCBwdHItPm9m
ZnNldCwgbGVuKTsNCj4+ICsNCj4+ICsgICAgICAgICAgICAgICBpZiAoSVNfRVJSX09SX05VTEwo
eGRwX3B0cikpDQo+PiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gTlVMTDsNCj4+ICsg
ICAgICAgICAgICAgICByZXR1cm4geGRwX3B0cjsNCj4+ICsgICAgICAgfQ0KPj4gKyAgICAgICBk
ZWZhdWx0Og0KPj4gKyAgICAgICAgICAgICAgIFdBUk5fT05DRSh0cnVlLCAidW5rbm93biBkeW5w
dHIgdHlwZSAlZFxuIiwgdHlwZSk7DQo+PiArICAgICAgICAgICAgICAgcmV0dXJuIE5VTEw7DQo+
PiArICAgICAgIH0NCj4+ICt9DQo+PiArDQo+IA0KPiBTb25nLCB5b3UgYmFzaWNhbGx5IHJlaW1w
bGVtZW50ZWQgYnBmX2R5bnB0cl9zbGljZSgpIGJ1dCBkaWRuJ3QgdW5pZnkNCj4gdGhlIGNvZGUu
IE5vdyB3ZSBoYXZlIHR3byBhbG1vc3QgaWRlbnRpY2FsIG5vbi10cml2aWFsIGZ1bmN0aW9ucyB3
ZSdkDQo+IG5lZWQgdG8gdXBkYXRlIGV2ZXJ5IHRpbWUgc29tZW9uZSBhZGRzIGEgbmV3IHR5cGUg
b2YgZHlucHRyLiBXaHkgbm90DQo+IGhhdmUgY29tbW9uIGhlbHBlciB0aGF0IGRvZXMgZXZlcnl0
aGluZyBib3RoIGJwZl9keW5wdHJfc2xpY2UoKSBrZnVuYw0KPiBuZWVkcyBhbmQgX19icGZfZHlu
cHRyX2RhdGEoKSBuZWVkcy4gQW5kIHRoZW4gY2FsbCBpbnRvIGl0IGZyb20gYm90aCwNCj4ga2Vl
cGluZyBhbGwgdGhlIExPQ0FMIHZzIFJJTkdCVUYgdnMgU0tCIHZzIFhEUCBsb2dpYyBpbiBvbmUg
cGxhY2U/DQo+IA0KPiBJcyB0aGVyZSBzb21lIHByb2JsZW0gdW5pZnlpbmcgdGhlbT8NCg0KSW5p
dGlhbGx5LCBJIHdhcyB0aGlua2luZyAiYnVmZmVyX19vcHQgPT0gTlVMTCAmJiBidWZmZXJfX3N6
ayAhPSAwIiB3YXMNCmEgcHJvYmxlbSBmb3IgYnBmX2R5bnB0cl9zbGljZSgpLiBBbmQgdGhlIGJ1
ZmZlcl9fb3B0ID09IE5VTEwgY2FzZSBtYXkNCm1ha2UgYSBjb21tb24gaGVscGVyIG1vcmUgY29t
cGxpY2F0ZWQuIFNvIEkgZGVjaWRlZCB0byBub3QgdW5pZnkgdGhlIHR3by4gDQoNCkFmdGVyIGEg
c2Vjb25kIGxvb2sgYXQgaXQsIEkgYWdyZWUgaXQgc2hvdWxkbid0IGJlIGEgcHJvYmxlbS4gQW5k
IGFjdHVhbGx5IA0Kd2UgY2FuIGRvOiAodGhvdWdoIHlvdSBtYXkgYXJndWUgYWdhaW5zdCkgDQoN
CmNvbnN0IHZvaWQgKl9fYnBmX2R5bnB0cl9kYXRhKGNvbnN0IHN0cnVjdCBicGZfZHlucHRyX2tl
cm4gKnB0ciwgdTMyIGxlbikNCnsNCiAgICAgICAgcmV0dXJuIGJwZl9keW5wdHJfc2xpY2UocHRy
LCAwLCBOVUxMLCBsZW4pOw0KfQ0KDQoNCkFzIHdlIGFyZSBvbiB0aGlzLCBzaGFsbCB3ZSB1cGRh
dGUgYnBmX2R5bnB0cl9zbGljZSgpIHRvIHJldHVybg0KImNvbnN0IHZvaWQgKiI/IFRoaXMgaXMg
YSBsaXR0bGUgd2VpcmQgZm9yIGJ1ZmZlcl9vcHQgIT0gTlVMTCwgY2FzZSBhcyANCmJ1ZmZlcl9v
cHQgaXMgbm90IGNvbnN0LiBCdXQgdGhlIGNvbXBpbGVyIChjbGFuZykgZG9lc24ndCBzZWVtIHRv
IA0KY29tcGxhaW4gYWJvdXQgaXQuIA0KDQpJZiB3ZSBjYW5ub3QgaGF2ZSBicGZfZHlucHRyX3Ns
aWNlKCkgcmV0dXJuIGNvbnN0IHBvaW50ZXIsIHdlIHdpbGwgbmVlZA0KYSBsaXR0bGUgbW9yZSBj
YXN0aW5nIGZvciBfX2JwZl9keW5wdHJfZGF0YSgpLiANCg0KVGhhbmtzLA0KU29uZyANCg0KDQo+
IA0KPj4gKy8qIEdldCBhIHBvaW50ZXIgdG8gZHlucHRyIGRhdGEgdXAgdG8gbGVuIGJ5dGVzIGZv
ciByZWFkIHdyaXRlIGFjY2Vzcy4gSWYNCj4+ICsgKiB0aGUgZHlucHRyIGRvZXNuJ3QgaGF2ZSBj
b250aW51b3VzIGRhdGEgdXAgdG8gbGVuIGJ5dGVzLCBvciB0aGUgZHlucHRyDQo+PiArICogaXMg
cmVhZCBvbmx5LCByZXR1cm4gTlVMTC4NCj4+ICsgKi8NCg0KDQoNCg==

