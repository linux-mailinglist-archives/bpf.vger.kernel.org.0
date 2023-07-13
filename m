Return-Path: <bpf+bounces-4948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DD8751E82
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 12:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B9F2281D17
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 10:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C94A1078F;
	Thu, 13 Jul 2023 10:11:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71AB8C14;
	Thu, 13 Jul 2023 10:11:07 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AB31FDB;
	Thu, 13 Jul 2023 03:11:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQNzMX4L4Xf6QALnIr7mmNWUGc86C8azyMQD7YfoCymWWhbavVOZ2JaXSVqEZcvM/zcHKoSXRoHNjPup2reia+17Wxf/iPAauEqFdzM9F8DBLorwHZ+q3dbD1XeBWwVaFW5eS/RTfbzyaZnJKsUMX0I98NUQ370ZvziyE8DxK6g/ytwPoLAGHOAh7j6XYerVWIFi0bqsmzlemqL6kzlaEpNhTxpBWJH6hTe+MN6Nm3TuAGb07c8wvhPZckdwwokWRMLEunYHSvqUwE3+MmTBZurqSbdYS1KlkiiwvPoPbOvDdnPns4//btCdXixpg+BbFjGd/pS1hMCruoo2LSqt5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82xmBzEr0kqSC1Qz09taIv8q//MR4jRNLNUN4gmULok=;
 b=S6zveb6yYJ3jkhIS25+NldsTC6lJ6gKCqFpQ07m/T9dXrA69cw4SkpNe5Hbt7eypIKgoi8lHPc9FViMTChLITUlyOuR9Iqy1z9YqzDeoiuOBzLAhvD6O/tvMf4c8iLHQJIzABa4g8+v/k/7w6OfJQ0oz2awntd3hLUZHBbBqDi/ZaSSWibaHvINhXg/KSSozQAeeVnce2vARulCmJoQ0fFzQFDS2gt17KXBUdo6rozP2W46xt70DhsPl8xDnADPj7gZO/J/1oMa00MXv4ckO+weVDWZV5L897OpH6V4k/se/zuU5K9ZityTuSslU6LV6wdLIB/4HQzMeUL4N3N2tCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82xmBzEr0kqSC1Qz09taIv8q//MR4jRNLNUN4gmULok=;
 b=UPmLxu/lZcrasIeEbJYiAJr+7xqY6jR2Pe+Iyz8i2mPfVyq5CEv5+rf9JRsCgBdMGrnt5Z4jFPfx4I0zRjdd1GbEGu1fhczU+wE8ONhvN62BxkY1jpvpQjHwNZU5EzK5CDlRjSA1V3ovG0h13giecxbNVaG6Pze9kUHPiTL3RxEmDVu3fsKw2HVviu0i4gztmUdZUL/jss0DHvt9IuPYU2iOVr1wgnDwnKkMOmwEZPiTCHe5x7sU0yk3dOU1b+w8hdt+XbQMKk0HnWUa3rE4AbdKCuhHEp8xHxDSRB/z5qToCw4JEKnpHy62ridq7W5s+aoIZyvWQMem01XK7MDcMg==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by CY5PR12MB6323.namprd12.prod.outlook.com (2603:10b6:930:20::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 10:11:04 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::e9ca:72a9:17b1:f859]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::e9ca:72a9:17b1:f859%3]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 10:11:03 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, "ttoukan.linux@gmail.com"
	<ttoukan.linux@gmail.com>, "jbrouer@redhat.com" <jbrouer@redhat.com>, Saeed
 Mahameed <saeedm@nvidia.com>, "saeed@kernel.org" <saeed@kernel.org>,
	"linyunsheng@huawei.com" <linyunsheng@huawei.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "maxtram95@gmail.com" <maxtram95@gmail.com>, "lorenzo@kernel.org"
	<lorenzo@kernel.org>, "alexander.duyck@gmail.com"
	<alexander.duyck@gmail.com>, "kheib@redhat.com" <kheib@redhat.com>,
	"ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
	"mkabat@redhat.com" <mkabat@redhat.com>, "brouer@redhat.com"
	<brouer@redhat.com>, "atzin@redhat.com" <atzin@redhat.com>,
	"fmaurer@redhat.com" <fmaurer@redhat.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "jbenc@redhat.com" <jbenc@redhat.com>
Subject: Re: mlx5 XDP redirect leaking memory on kernel 6.3
Thread-Topic: mlx5 XDP redirect leaking memory on kernel 6.3
Thread-Index: AQHZjY743nR7ST598kifD6Q1M3DiL69oDfyAgE+tU4CAAA45gA==
Date: Thu, 13 Jul 2023 10:11:02 +0000
Message-ID: <cc918a244723bffe17f528fc1b9a82c0808a22be.camel@nvidia.com>
References: <d862a131-5e31-bd26-84f7-fd8764ca9d48@redhat.com>
	 <00ca7beb7fe054a3ba1a36c61c1e3b1314369f11.camel@nvidia.com>
	 <6d47e22e-f128-ec8f-bbdc-c030483a8783@redhat.com>
In-Reply-To: <6d47e22e-f128-ec8f-bbdc-c030483a8783@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|CY5PR12MB6323:EE_
x-ms-office365-filtering-correlation-id: 7ae9d0d5-7ee1-42e4-231a-08db838976a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 f/j3HeyBYgenrO38m4321fYVue1oSTqeLPUfeDLp/tjuJuu1QlxyHouJcWWQLcwQXbsICoZ8IHTJqhT83YQix1jZJn0CT+qvSGAFN/f8r4F3lqlB9nsdMXPTcbt6xuLUC58wcbI1W0cmcXbYOIi6IhC9i1zPvySbLZbFIu2cPcQ0Od4wLZ1jplZkZBoPLYGKfMGjqjXJfvbSYcVil4KCYo27qf+/YYig6XBqzv97dq9my68j5HgmOJiWiTDYbD5JdTCaV0EkA/qMfp/p4VqAo3ScxeMUByPQ5QPcK2/Lmm9OhwZndpCIND/FxYUYgC6gU30W7LqYCz9ZSNHz3ep2ZYwDuaHGiKXTnR1hVINKI/VBLtHPCSRtcvh8XdkLJdie/L5MIHxfYCow/Olj+kCplt2CFn1KaHO6WH4D2TryRmF4nbnYcphPLy/W+Tk87XDYJNQB9woYctcf5D38EZUaNiZG5nOK/7YGJEMAqHuqQlo1vrXyd3e3fx9XSsMTSZDiCbjVkWv1wpDtjaJrxLj8A4lwVfi5DIzVHVLOIyXB4sY73+ZsrNv0eOPf/AsNwvrP5egPlZ8Fj+O1Z5umz7U5PigLoN0NZCOmjVWTYRCNhui7v9Xlm2prAG16lfwWLpSlQe4ilMapZnW3eLa3/qBl1oU2T7rnEjl3a9XKk2Lpyl9Z3ZPk5Qv87t58BJeSBLJ22otZqy2VAE2hlWYVH1IhSA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199021)(2906002)(38070700005)(83380400001)(6506007)(186003)(66556008)(66946007)(71200400001)(76116006)(91956017)(966005)(6486002)(6512007)(66446008)(66476007)(54906003)(110136005)(478600001)(38100700002)(86362001)(122000001)(2616005)(4326008)(316002)(36756003)(7416002)(41300700001)(64756008)(5660300002)(8936002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MkVuWm9WVzBlQTg4ZGgwbFpaMW5Sd0RDZU0vZUlWN0J6bUIzYUFQc3AvMVBx?=
 =?utf-8?B?YVQ4TFZUanZ3S3FzN04wSUFHYlR6Y05OMlA5b1hqK3JjK095QUhFeEZYRjRu?=
 =?utf-8?B?dkdtMEtoYUZYajE0bGZNS0J1WktTbDNLOFdpbjRsTDlFRFQ0dmY2M3dOdWRS?=
 =?utf-8?B?WnllRU0yMk95LzJkMWZIb2orUXA2NHdFRGRiSFJ3bEdWNHl0ZWJDb0FsakVD?=
 =?utf-8?B?a0RFTUhOS0ltVFQrc1ZpNzRnUExVelR4dU1qLzRHK3FveGZWeEdxSkRLNkV6?=
 =?utf-8?B?K0hiTkZBc0wvV244alJjWklnOEFXK0VoQkJoaUwxTG5qRmVxc242V3cyY3hK?=
 =?utf-8?B?bENNd25kajRadFRVemwxdDZnejRqVXFQL0pHQ1MvTUVlcVozckVYLzdwNE83?=
 =?utf-8?B?TjE4UGoyYlAwVXRNNTJleERnTzlndDluc2MvWnF3TEhHSDdEQThRV0NNbzEy?=
 =?utf-8?B?MnRubFJ2MHpHbTEzemViK1Z6UjcxN3ZqUFZxUGJvN01hczNIeWVOMnRUVzlV?=
 =?utf-8?B?bkh2TjhlRFF2Q0diYnFYbDJDU1doNGIvSU1adXdMUnZYcUp6NFAwZVVZT2dH?=
 =?utf-8?B?ajVjNlZUZ0pqOTVoZFo2V2szbUt2cXY1VTR4c2pKZWd6MmdPaVE1MktFd3VW?=
 =?utf-8?B?SDYrYUU3aWFLOWxrbG9YUlB1SWsxTFdsZnRFV3JLRzZxM0oyVkp5SjQrQUdX?=
 =?utf-8?B?WUREQTFmc2k2Rm5idHZ3OEpXdG41ZFBpaXlaNVVMTVNGTjkvZnlUTlo3QS80?=
 =?utf-8?B?Y3Fzd0ZiNGV0QU9BVlN1bUdNQ01HcDhVczJjZGMyRHVWVi9EeWJ4eU04N3E1?=
 =?utf-8?B?MTBDV1g1OG5IZFVSY3RtZ0F4ay9BM3lySFdIQXZNbld6QndtUjBFbWp0VlR0?=
 =?utf-8?B?U01UcVYva2d6ZXlXRHBuZlE4Vi9CTUZZb1FnbVRyZ01MTzZGTjMxWlNVQXFN?=
 =?utf-8?B?SE4vMzRMR2lPclBnTW5MRDNOcVlzRW15NUR0SGdIY0MvQWxiajJEc3VjcDlp?=
 =?utf-8?B?MlRTNGFsd0lnMlRucnBVWHM4Q2FoV1hhdkVRVmxMd05jcVZyRFJLZFBLbk4y?=
 =?utf-8?B?R3dmWjkxaWFLT2wwYzZiY2x5cVA2MCsyYW1BbTlpdTlVT3cvU1ZOSmhGMk9l?=
 =?utf-8?B?eVFpNVRuSXBnVHhtVEVhTTluaW5YK0VrR0NIc3BhekJabCtsQlJlQ0M4U3dF?=
 =?utf-8?B?bWYxNnhxRzNVV01LeS9PdXJZTldzZ3A1VFNwZ1VyRDBNdlN0OEhrUGZNMUZp?=
 =?utf-8?B?a2w1UWlPb1dFQ09nM3F4anM1ZDZQY1RNWVoycGJwYU5nMHlkam02Z05oREFp?=
 =?utf-8?B?T3VyY3lqOVdTVnZ5a1QyVXJSUzBPZWVJdGZ0QmFtK1c2Q1VWck1xRmprbHJD?=
 =?utf-8?B?SGZDSjVkL1RzVWRGdXVMaytjZVNGVVYvdjVyZ0R5VmpyaSt0NXdRUjBlWE9s?=
 =?utf-8?B?SWtLNU1kYWc1czNpS21Kb29IUGpwZlhJRU1PQ2ZRTVpUUi9kL2hyT3pOZW1u?=
 =?utf-8?B?RmpDajkrYjBGUUZTM3JaQ1c2UzFSOVlucGQ1RXZSYXF6dkIyVWJLa0poMkNS?=
 =?utf-8?B?Zk9JRnpFT0srYkZYT05CQ2g4T25CRGdZV1JEbk8xTm1raE9GL3NIelBDMWlO?=
 =?utf-8?B?U2hFYXc4QW5YSzBISFh1SHF5VXRrK0lOSGZ2dGtTREZJZFFhamhNVXp6L0lH?=
 =?utf-8?B?dTZWY3NkdTRadlJsMmRmTXRveHJDckxHUmFnV1VDZjVtOEd4UVVrYXZhcXBN?=
 =?utf-8?B?S3J6cGtVK04zTjBobHZLcUVaaUtRWGtpN0pnOWpaeTFUeGhTZEhISWYwOS9S?=
 =?utf-8?B?a09QWkpuME96NjhraGhDNWd0ZXdOMU14ZXFnaDVOVHNVSDcwTldvMFA0TEJD?=
 =?utf-8?B?THJTVEswWDBYUmtMWklpWTFlbFBtTGhWcDBtTVJMRGVoUUZwY1VTV3BZa3Nr?=
 =?utf-8?B?WWZCV2pFblQ0Ri8rdjhCSzNuNGVQd1AwczRTOEdpMi96V2p6YTZKdUJJNVhz?=
 =?utf-8?B?SE8xc08rNGhYYXZQRUVxakxCd3psa1I2cVNKWVNndEZoWGkwNVRqWlF1RHZQ?=
 =?utf-8?B?NWphbFZMd3BQS2wwdmFvVTUrWWpoSGp2TVBtOUZEU3B5bFBTMjNCOWlxdU1y?=
 =?utf-8?B?VE91RTkrVHg4bS9rSWJWOEladXVwUlorMldSdWpuSkRrbTVIT3FTK1d5WU5M?=
 =?utf-8?Q?byMSCejhu0QkQ97zOJf13Efm1x8UfvR3Rc5OJSJG8BQI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6900D55A300AF24B90125E8BB065D315@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae9d0d5-7ee1-42e4-231a-08db838976a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 10:11:02.7442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MQ0FRDw9mZ3ZyPKApB08sVoMPoHtbmB9N0VEzXi420C61WaAgcH5EHwGjChsZkH9IzGhqqQ/VwDUCyHHmlNPXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6323
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

R2kgSmVzcGVyLA0KT24gVGh1LCAyMDIzLTA3LTEzIGF0IDExOjIwICswMjAwLCBKZXNwZXIgRGFu
Z2FhcmQgQnJvdWVyIHdyb3RlOg0KPiBIaSBEcmFnb3MsDQo+IA0KPiBCZWxvdyB5b3UgcHJvbWlz
ZWQgdG8gd29yayBvbiBhIGZpeCBmb3IgWERQIHJlZGlyZWN0IG1lbW9yeSBsZWFrLi4uDQo+IFdo
YXQgaXMgdGhlIHN0YXR1cz8NCj4gDQpUaGUgZml4IGdvdCBtZXJnZWQgaW50byBuZXQgYSB3ZWVr
IGFnbzoNCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25l
dGRldi9uZXQuZ2l0L2NvbW1pdC9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2Nv
cmU/aWQ9N2FiZDk1NWE1OGZiMGZjZDRlNzU2ZmEyMDY1YzAzYWU0ODhmY2ZhNw0KDQpKdXN0IGZv
cmdvdCB0byBmb2xsb3cgdXAgb24gdGhpcyB0aHJlYWQuIFNvcnJ5IGFib3V0IHRoYXQuLi4NCg0K
VGhhbmtzLA0KRHJhZ29zDQoNCj4gT24gMjMvMDUvMjAyMyAxOC4zNSwgRHJhZ29zIFRhdHVsZWEg
d3JvdGU6DQo+ID4gDQo+ID4gT24gVHVlLCAyMDIzLTA1LTIzIGF0IDE3OjU1ICswMjAwLCBKZXNw
ZXIgRGFuZ2FhcmQgQnJvdWVyIHdyb3RlOg0KPiA+ID4gDQo+ID4gPiBXaGVuIHRoZSBtbHg1IGRy
aXZlciBydW5zIGFuIFhEUCBwcm9ncmFtIGRvaW5nIFhEUF9SRURJUkVDVCwgdGhlbiBtZW1vcnkN
Cj4gPiA+IGlzIGdldHRpbmcgbGVha2VkLiBPdGhlciBYRFAgYWN0aW9ucywgbGlrZSBYRFBfRFJP
UCwgWERQX1BBU1MgYW5kIFhEUF9UWA0KPiA+ID4gd29ya3MgY29ycmVjdGx5LiBJIHRlc3RlZCBi
b3RoIHJlZGlyZWN0aW5nIGJhY2sgb3V0IHNhbWUgbWx4NSBkZXZpY2UgYW5kDQo+ID4gPiBjcHVt
YXAgcmVkaXJlY3QgKHdpdGggWERQX1BBU1MpLCB3aGljaCBib3RoIGNhdXNlIGxlYWtpbmcuDQo+
ID4gPiANCj4gPiA+IEFmdGVyIHJlbW92aW5nIHRoZSBYRFAgcHJvZywgd2hpY2ggYWxzbyBjYXVz
ZSB0aGUgcGFnZV9wb29sIHRvIGJlDQo+ID4gPiByZWxlYXNlZCBieSBtbHg1LCB0aGVuIHRoZSBs
ZWFrcyBhcmUgdmlzaWJsZSB2aWEgdGhlIHBhZ2VfcG9vbCBwZXJpb2RpYw0KPiA+ID4gaW5mbGln
aHQgcmVwb3J0cy4gSSBoYXZlIHRoaXMgYnBmdHJhY2VbMV0gdG9vbCB0aGF0IEkgYWxzbyB1c2Ug
dG8gZGV0ZWN0DQo+ID4gPiB0aGUgcHJvYmxlbSBmYXN0ZXIgKG5vdCB3YWl0aW5nIDYwIHNlYyBm
b3IgYSByZXBvcnQpLg0KPiA+ID4gDQo+ID4gPiDCoMKgIFsxXQ0KPiA+ID4gaHR0cHM6Ly9naXRo
dWIuY29tL3hkcC1wcm9qZWN0L3hkcC1wcm9qZWN0L2Jsb2IvbWFzdGVyL2FyZWFzL21lbS9icGZ0
cmFjZS9wYWdlX3Bvb2xfdHJhY2tfc2h1dGRvd24wMS5idA0KPiA+ID4gDQo+ID4gPiBJJ3ZlIGJl
ZW4gZGVidWdnaW5nIGFuZCByZWFkaW5nIHRocm91Z2ggdGhlIGNvZGUgZm9yIGEgY291cGxlIG9m
IGRheXMsDQo+ID4gPiBidXQgSSd2ZSBub3QgZm91bmQgdGhlIHJvb3QtY2F1c2UsIHlldC4gSSB3
b3VsZCBhcHByZWNpYXRlIG5ldyBpZGVhcw0KPiA+ID4gd2hlcmUgdG8gbG9vayBhbmQgZnJlc2gg
ZXllcyBvbiB0aGUgaXNzdWUuDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gVG8gTGluLCBpdCBsb29r
cyBsaWtlIG1seDUgdXNlcyBQUF9GTEFHX1BBR0VfRlJBRywgYW5kIG15IGN1cnJlbnQNCj4gPiA+
IHN1c3BpY2lvbiBpcyB0aGF0IG1seDUgZHJpdmVyIGRvZXNuJ3QgZnVsbHkgcmVsZWFzZSB0aGUg
YmlhcyBjb3VudCAoaGludA0KPiA+ID4gc2VlIE1MWDVFX1BBR0VDTlRfQklBU19NQVgpLg0KPiA+
ID4gDQo+ID4gDQo+ID4gVGhhbmtzIGZvciB0aGUgcmVwb3J0IEplc3Blci4gSW5jaWRlbnRhbGx5
IEkndmUganVzdCBwaWNrZWQgdXAgdGhpcyBpc3N1ZQ0KPiA+IHRvZGF5DQo+ID4gYXMgd2VsbC4N
Cj4gPiANCj4gPiBPbiBYRFAgcmVkaXJlY3QgYW5kIHR4LCB0aGUgcGFnZSBpcyBzZXQgdG8gc2tp
cCB0aGUgYmlhcyBjb3VudGVyIHJlbGVhc2UNCj4gPiB3aXRoDQo+ID4gdGhlIGV4cGVjdGF0aW9u
IHRoYXQgcGFnZV9wb29sX3B1dF9kZWZyYWdnZWRfcGFnZSB3aWxsIGJlIGNhbGxlZCBmcm9tIFsx
XS4NCj4gPiBCdXQsDQo+ID4gYXMgSSBmb3VuZCBvdXQgbm93LCBkdXJpbmcgWERQIHJlZGlyZWN0
IG9ubHkgb25lIGZyYWdtZW50IG9mIHRoZSBwYWdlIGlzDQo+ID4gcmVsZWFzZWQgaW4geGRwIGNv
cmUgWzJdLiBUaGlzIGlzIHdoZXJlIHRoZSBsZWFrIGlzIGNvbWluZyBmcm9tLg0KPiA+IA0KPiA+
IFdlJ2xsIHByb3ZpZGUgYSBmaXggc29vbi4NCj4gPiANCj4gPiBbMV0NCj4gPiBodHRwczovL2dp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9uZXRkZXYvbmV0LW5leHQuZ2l0
L3RyZWUvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuL3hkcC5jI242
NjUNCj4gPiANCj4gPiBbMl0NCj4gPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC9uZXRkZXYvbmV0LW5leHQuZ2l0L3RyZWUvbmV0L2NvcmUveGRwLmMjbjM5
MA0KPiA+IA0KPiA+IFRoYW5rcywNCj4gPiBEcmFnb3MNCj4gPiANCj4gPiANCj4gDQoNCg==

