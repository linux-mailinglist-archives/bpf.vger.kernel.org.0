Return-Path: <bpf+bounces-11416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3947B9928
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 02:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id ABAFC281CFF
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 00:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0AA36B;
	Thu,  5 Oct 2023 00:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="POipuMAL"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DAE7F
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 00:12:47 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680A890
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 17:12:46 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3950CiRK006948
	for <bpf@vger.kernel.org>; Wed, 4 Oct 2023 17:12:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=BmNg9k+CvAW7LjXx4CEEKjk6YyEhPvX3gVJLfRHKX2k=;
 b=POipuMALNtzkZe/2rZ6sVePTUpjKleKbK6JqhGMxO5IM2FGEX22Pl2Wr6YijUuGPG8io
 EUTwW0WJsAnEOPgqqf5euCk9/2IGhrK+TeFcJ/gjXL4gBQz6vEPX0pGKAyVznzr2/nC7
 908OOevq2EMc8wPA/RbdoBrKFyWDh2myRwywby1OfIA1UUK4yFq0nj+rovm5a0Fn7vYy
 Mil32sQj6gu0PiqXnyN1WIncfitUrWKF/7IO1v1U2kAw6eavK/bNDeDBXwYV5R3YJYow
 D+hRrqUBx6dieajzcpNVRnHW4B4yyFqVNP+7Uft+NTdhyZHXw5t8KaDonp+QK5bMGcw+ +g== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3thh73rghq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 04 Oct 2023 17:12:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzRDD5HnCKHXX8+qdjrtvWkOs/hz6eIpJR9faZ0uKxwxQsmswbq1s+i8i/VpEm4QMpZv/PBYtNaOYn5QAhBwtvT8WaZIAATvjLqajMb/Oox4l5/6Zl+s2cikRPpSJvr0Dumwp/pQgrgoKBUIYI8lPZQiKbMMWpnIrg1a2IvgE6TfsG41W+7UP0KWPuEYiUdlVPlpXhs22qpPQxeCU6SHjzA9fGgUiDuO6lWl82Cly/cZM6hNtZdY4BCfHQNZrHPSh/bux+L+mo5kSs7fixcvmMWPijHpzYEvVpC6kkVaCxa7phOv+sDlx1Svf4FpETx9KExQHCjXxyXTbmrY9IhgCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmNg9k+CvAW7LjXx4CEEKjk6YyEhPvX3gVJLfRHKX2k=;
 b=lJ0FUPnVAWM+nu17KOERvqT+xrXZDMeU0dcDdLkCz9nrnfmeIGUlQxKsmSTOTcuMzomJh7Yx5mkIEsjgQRFGvquV0+V2iNjPfpB1YOsRGlZePMjU9iYSkbluVxeZFgHHEE3D5HZk0YwtbIKmYRf2ixYW/bJ11ar8hpTnldytEJ7umvBwVq8okVjNptXLqtufpgYPkdddVtwmRO75XATMSMz/Jo859FOS6NAi3xN1tq4pEus/qkt6PM41SPBnLEdDkEpF3jnMw/XwA42CttpldyZlO5pzLr8g/W+QVvtn09G7vYsms4mv7TbCGiRysl5pQPa3hHDUmJoCQJWClwLsHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by IA1PR15MB5773.namprd15.prod.outlook.com (2603:10b6:208:3fd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Thu, 5 Oct
 2023 00:12:12 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e0e7:7606:7fef:f9de]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e0e7:7606:7fef:f9de%5]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 00:12:11 +0000
From: Song Liu <songliubraving@meta.com>
To: Song Liu <songliubraving@meta.com>
CC: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko
	<andrii.nakryiko@gmail.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, Song Liu
	<song@kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov
	<ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko
	<andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team
	<kernel-team@meta.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 bpf-next] bpf: Avoid unnecessary -EBUSY from
 htab_lock_bucket
Thread-Topic: [PATCH v2 bpf-next] bpf: Avoid unnecessary -EBUSY from
 htab_lock_bucket
Thread-Index: AQHZ9lwCFOQR9ydaeUieAa0xHUISRbA481YAgAAHDQCAANWeAIAAhFAA
Date: Thu, 5 Oct 2023 00:11:52 +0000
Message-ID: <FCAD3D3A-B230-40D8-A422-DED507B95C89@fb.com>
References: <20231004004350.533234-1-song@kernel.org>
 <CAEf4BzbM6yvBwT3-_7NkzKgqdoXc_G3+_5Fnv96b_2U68=Hunw@mail.gmail.com>
 <CAADnVQKMxUg3Djh8UjRPdw7RE6yOiNUgYGjG_eCPqMtnguO+fA@mail.gmail.com>
 <095DCE9A-BC4D-415F-81F6-B6C20BA08B9A@fb.com>
In-Reply-To: <095DCE9A-BC4D-415F-81F6-B6C20BA08B9A@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|IA1PR15MB5773:EE_
x-ms-office365-filtering-correlation-id: ce764a66-220a-4d93-ca1c-08dbc537ad98
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Ez1W4bN89tdL9/x+vf/4FxUcVRNKP/p8MHtCcPGC885rV1fgyyteUheOPeucvxys/QAvpu0LJXF+wNCay7wjVsITqwZb7yHJpIo0BVR58EK+jNGSpQBPScvzvIdTREyJRUlyoiQwuCndVbs78DFFhOiRPCWcwtP6eqoUfQqsgL1ZWotJXDHn9oQL2Qi+67AQYB27K/qAqmlUc1LtyljC4lTW96putO2K3olmtsQZulIj2O62ednzupRoClWHwZ0PBJSE1s+wMUJsUnqFJKJ34E1XHfo2pelvjfktxGgGFuALur2T7rPtsZNJkD1AQ9MqI5K8e45WwZ/JWaU7LzgbVa4aeCi3SjVKgTYDvnVbPWyqxEkDyFLi90CCu4nWWhe5U0t3/LtKywvGAWWdGzF1yvNhx4PYJqiafj30MHNZass4O1N/bM1VAjob0vG/CM5z5FgVu5mjm1Cmp47UIuVS7cq8aNSyUALdyCIhxWEfSaELofInmIWmYv54vmzitsOVRC26nI5MPK3HCEdG/DTO7wNKMarb5/xElyIX/rK5bvhna3FLP9+IYUcSMBK3KEZznPlgc1hT8tt7Jqbj0XpckqVU6AoE3esVoCIWccpUEpc=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(366004)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(316002)(122000001)(38070700005)(38100700002)(33656002)(36756003)(86362001)(83380400001)(64756008)(54906003)(41300700001)(66946007)(4326008)(5660300002)(6862004)(8676002)(66476007)(66446008)(8936002)(66556008)(91956017)(2906002)(76116006)(6200100001)(7416002)(6512007)(6506007)(53546011)(71200400001)(9686003)(966005)(478600001)(6486002)(6666004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UFZ5TUVZZUtIMDQxRkJKYnppU0xncy83UFQ3dytrZFA2TUdHYVJXZEgzbE5L?=
 =?utf-8?B?WDA5OFVaTWlGaE55dXVIanNsblh6MFRZS2hLc3FhdWVHM2Ryb2wySVBPbm9W?=
 =?utf-8?B?NFFpZmI2R25pUnFHTExqMjBoTVpLbDhoMWV3dkt0a0t5b1NSOG8yMmhOQUhS?=
 =?utf-8?B?cXFRZ1Yzd21aam90MStWY1MwOHpUSU1BbDRRM3pURkowdS9BMUFDU285YXcr?=
 =?utf-8?B?Zy90YjNialNMa2tuSTg1ZURpY2hHTEwxY3d6NjJPaUU0M2liWjFBczNYbE5G?=
 =?utf-8?B?L1F2Ynd5UGxJVFZHVDdEbHdOTVYwVHk2VHRvbmNJSWdjdHZoSjNnc1JpN3hX?=
 =?utf-8?B?ZFBzYWFJUysyeXZjd0t5RFZPL2hQR05vaWRKNjFpanFPQ3ZFUmgvc1hodkFs?=
 =?utf-8?B?eE40ekdWNElVaTYwNU1RM2lQZWJTU045Wit6aEVvMTU5bjdOTkVjM00wT2FG?=
 =?utf-8?B?cTVMSDRVTEZRdkNrTkZEaE5mYVBZYkRlRVVPdm1pZ1h0SGR5S0ltSWhIQXlX?=
 =?utf-8?B?R3lmbU03NDF6RTFWcG1GSm5uOW4rcWpZdUdTS1dtYVQzRkx4Z0ZhL0hRRGVN?=
 =?utf-8?B?aTNuenNDZmJHUWtvUXlLd29TUnpGVGZXeW9WSjdkL2JjUXAvWm5TUXhCSHBW?=
 =?utf-8?B?eHZUNTFBYTUrUGU2YWR1UjI0WC8zcy9aNXhkQk9qaXRodXNYQkR1WW5WZkYw?=
 =?utf-8?B?Nk1VZGZVRzhJSXIxdzgxb0lJMW1UVDErNjFodmlzTlphL3ZobDlKSytvZERy?=
 =?utf-8?B?N2dXM0JqKzAyZDhmV2VrZlR4QnJFWDhMcGwwcjQxNkhlSTlJeEZycW9ZVlJp?=
 =?utf-8?B?K1Q0dWo5WlpOajdtTFVyc25mS0lSYXlDNFpMUTl4SGpKeDcrdUJBVFV5dWtv?=
 =?utf-8?B?Y3dkenVTSjlhUDR4OXVja3EwZXJmeHNVVUdlTWtlQjNCbTJKOUpwVkE2cUZt?=
 =?utf-8?B?NHAxdFpTeU1McjV3U3kvYXRoN3hubzZQWGFlY0hHUWJVVng4cHhKSWF5WjYx?=
 =?utf-8?B?MDlKVGQzbnNWZG5md2RXOWNBY2VWV0o5Z0t0NkZXWU42dWR5aUJzZWtsSWJM?=
 =?utf-8?B?WVM3My9tVVBBREpDb2N4ZWVYSDZabzJsNGNYQkZJQnY3UUM1bC9jV2RlVUFJ?=
 =?utf-8?B?eUk1Y3RJTDYyd1hwdUhFU0F4bUorQTJLYm5KK05lelVGdHcwL3ZxaHVRN2p3?=
 =?utf-8?B?L0tFa2dpcFJnN1pGMC9uSWlPMFloK01XRXlMemlKbS9naStoVExUb2h2QWlh?=
 =?utf-8?B?dTZLcWQvQUE4aTFmN0hxYTd0bmNkN0lDeXNXN2VNR0xoSldZY2dVci9NWmdN?=
 =?utf-8?B?OGpQTXNwOGVoNkd1WWtrMjF6SnJaTm9ldjFuVElaWTNuUGhPZUxlc0l4SnFj?=
 =?utf-8?B?NWloT0dRdGppU05TeTROT0pqYUNBM2tGSW1tVWowbXlMOUJwSDVpNERCU3Nx?=
 =?utf-8?B?T0tVWjIrR1BvUjY3SmxYZUMxVjB4NFRVZk9aTEt3YTQ0cUZTYTJTY1FJOXZx?=
 =?utf-8?B?Rkx6N011ZXE2bk93bGZwVnNXWVV4SmU4cHhldk5TSEd0SVRNS1Vmb056b3pW?=
 =?utf-8?B?a28rVFB2UUNDRTdBUnNvM3NKSlFRZTE4TWdSMTJwTEhnQVFIekx3bzlEODh3?=
 =?utf-8?B?Z0RMR1lBQXFXbG0rZEZGeGVjZ3lpMGxTeVlLZWV0WU9XK0pxd1pPMXNPWXJt?=
 =?utf-8?B?Z2J0WjRXTVlVbmYyMlU5ZjFVdjR1by9YNlNaZnExeDBiWFRaeG5kbWZpejZm?=
 =?utf-8?B?Y0JiWGxDS2Voak55UklsR2JHejY3QlZYMFduV3dWeVJQcm1ZKzFPcEk4SUlt?=
 =?utf-8?B?SlFVVTZlQUhPTU05RlBKYzh0a2RwcklKUWNoSFBCSmtzYkZwaUFsRjZZaDFx?=
 =?utf-8?B?UlducFh4bjJyNWRHbndGMzNqNElodTZSQ295aXpramQycnJRbEpOQndRaktP?=
 =?utf-8?B?VENUYmVHTmFCblFzRzB1L3A3NVlzUnNtQ01FY2lvckN5d3BwZ1l6Z2w4YkZn?=
 =?utf-8?B?elMzckRtUmsybTl0SUpSU1JjOVlweWF1ZUMwaWZIem9UTVFPa0FSNnFSbjF6?=
 =?utf-8?B?YkVxVDBnNFEwWHhpaHdETXRkcEc3SUc3WHRzcmlnZG8wT1dxVHYxVG40QzFU?=
 =?utf-8?B?SEFtcmhmRko2VE43WDhUakVDcXhMMTlTK28rcVQ0UFA4Q3lBSVVmTkd6RnUr?=
 =?utf-8?Q?4IbXksdXPVYNEmFexnd8ens=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FAB0C2AE9D9AD848A29C74735FEA748B@namprd15.prod.outlook.com>
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce764a66-220a-4d93-ca1c-08dbc537ad98
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 00:11:52.8953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Tb4y21RYSyGHnhO0GOZZM4xuX5jL8Rzh/S1MwD4Mb61twjSdrSRLV+O1hAB8SiGHS+PuhI1gEyLby7312TRoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5773
X-Proofpoint-ORIG-GUID: umhuKXK5IQmSVj6dPaIbxq2LbMQAjzXc
X-Proofpoint-GUID: umhuKXK5IQmSVj6dPaIbxq2LbMQAjzXc
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_13,2023-10-02_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCj4gT24gT2N0IDQsIDIwMjMsIGF0IDk6MTggQU0sIFNvbmcgTGl1IDxzb25nbGl1YnJhdmlu
Z0BtZXRhLmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gDQo+PiBPbiBPY3QgMywgMjAyMywgYXQgODoz
MyBQTSwgQWxleGVpIFN0YXJvdm9pdG92IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3
cm90ZToNCj4+IA0KPj4gT24gVHVlLCBPY3QgMywgMjAyMyBhdCA4OjA44oCvUE0gQW5kcmlpIE5h
a3J5aWtvDQo+PiA8YW5kcmlpLm5ha3J5aWtvQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4g
T24gVHVlLCBPY3QgMywgMjAyMyBhdCA1OjQ14oCvUE0gU29uZyBMaXUgPHNvbmdAa2VybmVsLm9y
Zz4gd3JvdGU6DQo+Pj4+IA0KPj4+PiBodGFiX2xvY2tfYnVja2V0IHVzZXMgdGhlIGZvbGxvd2lu
ZyBsb2dpYyB0byBhdm9pZCByZWN1cnNpb246DQo+Pj4+IA0KPj4+PiAxLiBwcmVlbXB0X2Rpc2Fi
bGUoKTsNCj4+Pj4gMi4gY2hlY2sgcGVyY3B1IGNvdW50ZXIgaHRhYi0+bWFwX2xvY2tlZFtoYXNo
XSBmb3IgcmVjdXJzaW9uOw0KPj4+PiAgMi4xLiBpZiBtYXBfbG9ja1toYXNoXSBpcyBhbHJlYWR5
IHRha2VuLCByZXR1cm4gLUJVU1k7DQo+Pj4+IDMuIHJhd19zcGluX2xvY2tfaXJxc2F2ZSgpOw0K
Pj4+PiANCj4+Pj4gSG93ZXZlciwgaWYgYW4gSVJRIGhpdHMgYmV0d2VlbiAyIGFuZCAzLCBCUEYg
cHJvZ3JhbXMgYXR0YWNoZWQgdG8gdGhlIElSUQ0KPj4+PiBsb2dpYyB3aWxsIG5vdCBhYmxlIHRv
IGFjY2VzcyB0aGUgc2FtZSBoYXNoIG9mIHRoZSBoYXNodGFiIGFuZCBnZXQgLUVCVVNZLg0KPj4+
PiBUaGlzIC1FQlVTWSBpcyBub3QgcmVhbGx5IG5lY2Vzc2FyeS4gRml4IGl0IGJ5IGRpc2FibGlu
ZyBJUlEgYmVmb3JlDQo+Pj4+IGNoZWNraW5nIG1hcF9sb2NrZWQ6DQo+Pj4+IA0KPj4+PiAxLiBw
cmVlbXB0X2Rpc2FibGUoKTsNCj4+Pj4gMi4gbG9jYWxfaXJxX3NhdmUoKTsNCj4+Pj4gMy4gY2hl
Y2sgcGVyY3B1IGNvdW50ZXIgaHRhYi0+bWFwX2xvY2tlZFtoYXNoXSBmb3IgcmVjdXJzaW9uOw0K
Pj4+PiAgMy4xLiBpZiBtYXBfbG9ja1toYXNoXSBpcyBhbHJlYWR5IHRha2VuLCByZXR1cm4gLUJV
U1k7DQo+Pj4+IDQuIHJhd19zcGluX2xvY2soKS4NCj4+Pj4gDQo+Pj4+IFNpbWlsYXJseSwgdXNl
IHJhd19zcGluX3VubG9jaygpIGFuZCBsb2NhbF9pcnFfcmVzdG9yZSgpIGluDQo+Pj4+IGh0YWJf
dW5sb2NrX2J1Y2tldCgpLg0KPj4+PiANCj4+Pj4gU3VnZ2VzdGVkLWJ5OiBUZWp1biBIZW8gPHRq
QGtlcm5lbC5vcmc+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFNvbmcgTGl1IDxzb25nQGtlcm5lbC5v
cmc+DQo+Pj4+IA0KPj4+PiAtLS0NCj4+Pj4gQ2hhbmdlcyBpbiB2MjoNCj4+Pj4gMS4gVXNlIHJh
d19zcGluX3VubG9jaygpIGFuZCBsb2NhbF9pcnFfcmVzdG9yZSgpIGluIGh0YWJfdW5sb2NrX2J1
Y2tldCgpLg0KPj4+PiAgKEFuZHJpaSkNCj4+Pj4gLS0tDQo+Pj4+IGtlcm5lbC9icGYvaGFzaHRh
Yi5jIHwgNyArKysrKy0tDQo+Pj4+IDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+Pj4+IA0KPj4+IA0KPj4+IE5vdyBpdCdzIG1vcmUgc3ltbWV0cmljYWwg
YW5kIHNlZW1zIGNvcnJlY3QgdG8gbWUsIHRoYW5rcyENCj4+PiANCj4+PiBBY2tlZC1ieTogQW5k
cmlpIE5ha3J5aWtvIDxhbmRyaWlAa2VybmVsLm9yZz4NCj4+PiANCj4+Pj4gZGlmZiAtLWdpdCBh
L2tlcm5lbC9icGYvaGFzaHRhYi5jIGIva2VybmVsL2JwZi9oYXNodGFiLmMNCj4+Pj4gaW5kZXgg
YThjN2UxYzVhYmZhLi5mZDhkNGIwYWRkZmMgMTAwNjQ0DQo+Pj4+IC0tLSBhL2tlcm5lbC9icGYv
aGFzaHRhYi5jDQo+Pj4+ICsrKyBiL2tlcm5lbC9icGYvaGFzaHRhYi5jDQo+Pj4+IEBAIC0xNTUs
MTMgKzE1NSwxNSBAQCBzdGF0aWMgaW5saW5lIGludCBodGFiX2xvY2tfYnVja2V0KGNvbnN0IHN0
cnVjdCBicGZfaHRhYiAqaHRhYiwNCj4+Pj4gICAgICAgaGFzaCA9IGhhc2ggJiBtaW5fdCh1MzIs
IEhBU0hUQUJfTUFQX0xPQ0tfTUFTSywgaHRhYi0+bl9idWNrZXRzIC0gMSk7DQo+Pj4+IA0KPj4+
PiAgICAgICBwcmVlbXB0X2Rpc2FibGUoKTsNCj4+Pj4gKyAgICAgICBsb2NhbF9pcnFfc2F2ZShm
bGFncyk7DQo+Pj4+ICAgICAgIGlmICh1bmxpa2VseShfX3RoaXNfY3B1X2luY19yZXR1cm4oKiho
dGFiLT5tYXBfbG9ja2VkW2hhc2hdKSkgIT0gMSkpIHsNCj4+Pj4gICAgICAgICAgICAgICBfX3Ro
aXNfY3B1X2RlYygqKGh0YWItPm1hcF9sb2NrZWRbaGFzaF0pKTsNCj4+Pj4gKyAgICAgICAgICAg
ICAgIGxvY2FsX2lycV9yZXN0b3JlKGZsYWdzKTsNCj4+Pj4gICAgICAgICAgICAgICBwcmVlbXB0
X2VuYWJsZSgpOw0KPj4+PiAgICAgICAgICAgICAgIHJldHVybiAtRUJVU1k7DQo+Pj4+ICAgICAg
IH0NCj4+Pj4gDQo+Pj4+IC0gICAgICAgcmF3X3NwaW5fbG9ja19pcnFzYXZlKCZiLT5yYXdfbG9j
aywgZmxhZ3MpOw0KPj4+PiArICAgICAgIHJhd19zcGluX2xvY2soJmItPnJhd19sb2NrKTsNCj4+
IA0KPj4gU29uZywNCj4+IA0KPj4gdGFrZSBhIGxvb2sgYXQgczM5MCBjcmFzaCBpbiBCUEYgQ0ku
DQo+PiBJIHN1c3BlY3QgdGhpcyBwYXRjaCBpcyBjYXVzaW5nIGl0Lg0KPiANCj4gSXQgaW5kZWVk
IGxvb2tzIGxpa2UgdHJpZ2dlcmVkIGJ5IHRoaXMgcGF0Y2guIEJ1dCBJIGhhdmVuJ3QgZmlndXJl
ZA0KPiBvdXQgd2h5IGl0IGhhcHBlbnMuIHYxIHNlZW1zIG9rIGZvciB0aGUgc2FtZSB0ZXN0cy4g
DQoNCkkgZ3Vlc3MgSSBmaW5hbGx5IGZpZ3VyZWQgb3V0IHRoaXMgKHNob3VsZCBiZSBzaW1wbGUp
IGJ1Zy4gSWYgSSBnb3QgaXQgDQpjb3JyZWN0bHksIHdlIG5lZWQ6DQoNCmRpZmYgLS1naXQgYy9r
ZXJuZWwvYnBmL2hhc2h0YWIuYyB3L2tlcm5lbC9icGYvaGFzaHRhYi5jDQppbmRleCBmZDhkNGIw
YWRkZmMuLjFjZmEyMzI5YTUzYSAxMDA2NDQNCi0tLSBjL2tlcm5lbC9icGYvaGFzaHRhYi5jDQor
Kysgdy9rZXJuZWwvYnBmL2hhc2h0YWIuYw0KQEAgLTE2MCw2ICsxNjAsNyBAQCBzdGF0aWMgaW5s
aW5lIGludCBodGFiX2xvY2tfYnVja2V0KGNvbnN0IHN0cnVjdCBicGZfaHRhYiAqaHRhYiwNCiAg
ICAgICAgICAgICAgICBfX3RoaXNfY3B1X2RlYygqKGh0YWItPm1hcF9sb2NrZWRbaGFzaF0pKTsN
CiAgICAgICAgICAgICAgICBsb2NhbF9pcnFfcmVzdG9yZShmbGFncyk7DQogICAgICAgICAgICAg
ICAgcHJlZW1wdF9lbmFibGUoKTsNCisgICAgICAgICAgICAgICAqcGZsYWdzID0gZmxhZ3M7DQog
ICAgICAgICAgICAgICAgcmV0dXJuIC1FQlVTWTsNCiAgICAgICAgfQ0KDQoNClJ1bm5pbmcgQ0kg
dGVzdHMgaGVyZToNCg0KaHR0cHM6Ly9naXRodWIuY29tL2tlcm5lbC1wYXRjaGVzL2JwZi9wdWxs
LzU3NjkNCg0KSWYgaXQgd29ya3MsIEkgd2lsbCBzZW5kIHYzLiANCg0KVGhhbmtzLA0KU29uZw0K
DQpQUzogczM5MHggQ0kgaXMgcnVubmluZyBzbG93LiBJIGdvdCBzb21lIGpvYnMgc3RheWVkIGlu
IHRoZSBxdWV1ZSANCmZvciBtb3JlIHRoYW4gYSBob3VyLiANCg0KPiANCj4gU29uZw0KPiANCj4+
IA0KPj4gSWx5YSwNCj4+IA0KPj4gZG8geW91IGhhdmUgYW4gaWRlYSB3aGF0IGlzIGdvaW5nIG9u
Pw0KPiANCg0K

