Return-Path: <bpf+bounces-300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E236FE1C0
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 17:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDC6A2814CA
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 15:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378AF168AF;
	Wed, 10 May 2023 15:45:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DB96AA8
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 15:45:08 +0000 (UTC)
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-cusazon11020014.outbound.protection.outlook.com [52.101.61.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9732E10FA
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 08:45:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLAvIKFvQklNnlJ+BQZKQRlI3//GJOcUjzCBW3xD7hOdr0Qp03zBKbQYbNdH76obtu0pYGTEmGpmpPgEfyEnebkqhxF072lHLg2xjf1/uwrnOxTb6IzNTHCxQ1jd4Hq4yAXVStGPyKCopQriKp8ESjtDx11iVBJv1bHKkDnBpP5+3U6u7Fzg1NnAP7wBwwZg+52Bcl/T4KzeQDsXYb6twSYmnlLLVIo89v3gaZVWPeUADH1I1eUacllFAHsEoG/rrygOh9EJGYS8UBkr7Lpqy/Mlps66TkCsqXq/NndW0iwEFLKGcZO77y50gKt9U7xE34V/k2/pMjkWzwD/AuI0Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQoTgzDaw8DlA2Y3uCDugiqU6ZyVmWgEghD7BysXAzo=;
 b=Fq7X5U6ciO6oiMNxeVJg+1SnDBfTHJ+sB9QsIaRmaHhQePDVoqsMN2fmtkSPSssj6R76HJW3kWGLi1r88MEbA/nAAlcrVVaNfitVwaEsPkF3B7e99u9/SIEudZo3eahMEWlDnKcRF81di6zqXa1ikeSB6siQQnFQj7gYeOlcd7Wmx4VLVuRxue5xIna282G/Ackms3ePxqwIMMb1if0MxohMqui0HUyX6bvZeyrapl0ccoaI0cnU3ekbfUWDW5GNyXo95j6nS0gsSkV2FSItOO2n+LeYAlza1CCp83yQlDlkEXDWdLXEI0co3T3xtgTXDIN6UdMtCgokwdcFeLYd9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQoTgzDaw8DlA2Y3uCDugiqU6ZyVmWgEghD7BysXAzo=;
 b=PyvOeevs7kIQdG6aoCBSzovc0l1CFG+aETCTLaFHiqigrJ04oBf33QxWGsjAWAFnj0MqoGraFDe8EW9lUcQgD5KlnWC+pobQlI7cpV93sMYp34J+PqA39h6gABLQjDs9tf+SHqRPvKtNgoC+rfS7MzsoF10bULtzojkS+Y/xmsA=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by LV2PR21MB3063.namprd21.prod.outlook.com (2603:10b6:408:17c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.5; Wed, 10 May
 2023 15:45:04 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::ebee:52ea:94c9:4e43]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::ebee:52ea:94c9:4e43%7]) with mapi id 15.20.6411.002; Wed, 10 May 2023
 15:45:04 +0000
From: Dave Thaler <dthaler@microsoft.com>
To: Yonghong Song <yhs@meta.com>, Dave Thaler <dthaler1968@googlemail.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC: "bpf@ietf.org" <bpf@ietf.org>
Subject: RE: [PATCH bpf-next] Shift operations are defined to use a mask
Thread-Topic: [PATCH bpf-next] Shift operations are defined to use a mask
Thread-Index: AQHZgqFZC/QeNsBkkEu+CoXwaca4N69TgxOAgAAiq4A=
Date: Wed, 10 May 2023 15:45:04 +0000
Message-ID:
 <PH7PR21MB38783D142478D9D569188B5AA3779@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <20230509180845.1236-1-dthaler1968@googlemail.com>
 <463649c1-d641-82c8-626e-162865cc21a0@meta.com>
In-Reply-To: <463649c1-d641-82c8-626e-162865cc21a0@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=52878068-d485-42a0-8373-7a5eb9c1dcef;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-10T15:38:43Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|LV2PR21MB3063:EE_
x-ms-office365-filtering-correlation-id: 9d21635d-a0b0-4631-8cd0-08db516d863f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Cp0GRU7yaDJ/5l1hT01jLc/KKijDO0jMtvlE0HlNWRNeuI7fbsa9f2pa1RkI6CecmMvygayc+ZBqIpyePGLB4AWWCAlxTeSuWhIVjEzf/bia+G5Lxai9wt9KUDqtBb3yThz0eS3dTmfctBozSrXEnlYTgnBIun78ityk66mn8hJCzWglN4NuryAwe7Uhn1ejwTIpk95RdqxInA5qV3OyxCr1D072X0zLRmb8UACYDnKI0yiOmZqzT6Dph326z+XAI2+p3NQ3dlJCVjnFlkuilNekhGO2NrbCeHVaLopjjG7qBL39i3BqOtVI/KHEgNhEDDKgU5a6mltvBXdd9CkfG1tKiVfdEyHx/zuGOp/J7xo+bvqigBlJY15QYFd2HBWOQGMOtlv6ipq+qG5+f7jY5U3WtFQQ0OPzIpcLqt0tsUodPUBsJtuzDGUgxsxl6K6zd5zVqiQG5Aa3K6MEF7N7FtSKa0nc9vK1IteS6GIyWH9IDa0moZ0u0CD6kVOMWI/vc+nHkocJ3Uf4cmC6hkJ85qWMzltwoe+TkS7R2txGdTPmlabxduClVS59L23FGIM3BPihHjBsrrP39t2LGTufZJyFo44iCqClPjdsGrJRtkMXQIymnIDvkPjQfyQjW68YTIrvirCoSs7QM3a5BMzDaT56WdbHL/iHDLbcRPB617U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199021)(186003)(55016003)(10290500003)(478600001)(86362001)(110136005)(33656002)(7696005)(71200400001)(38100700002)(38070700005)(52536014)(4744005)(5660300002)(8936002)(8676002)(76116006)(66556008)(66476007)(66446008)(64756008)(66946007)(41300700001)(122000001)(8990500004)(316002)(786003)(4326008)(82950400001)(53546011)(2906002)(26005)(82960400001)(6506007)(9686003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VU80bnBNK2MrYk5ncFFtM0tuQkZxOXAxY3p6R3kzcW5YM1k3Q0pVYVJnQVV6?=
 =?utf-8?B?dTBTY29ac3Q4ci9BSG0vM0d1SDFoeklBTGIwQjJ5WGFaMXdxZjF1Rk5BRlcy?=
 =?utf-8?B?SmRueExxbWZVNWV1WHBHeWZaR1lqc2lBdTdaZU44dlFGNmxsdlVxbjh0WW95?=
 =?utf-8?B?R1l1VnZNWWJUaXRmeGtNSjB4aFppVjZMRkNTSWp0Tmh3N3FJU3IrcnZRYVM1?=
 =?utf-8?B?T3pXTXloSGhjRFBjYTVJUkY1czNIQmNGNFc3SUpWdVVFdmVJZ3dtT2dJMVBP?=
 =?utf-8?B?NHMxOEhSYW9SUVZ5dnhMRVZFTURObWNqb1pIRkhoVVRCZWhEa0VKaGxsRTVq?=
 =?utf-8?B?Y0p3R2ttTlJ6QVh1ZVBQTE52UE5kWm1scmVOblBjZTZYWTQzRUFQSVQwdDlK?=
 =?utf-8?B?TmtvTzV2aFFuRmlET3IreFNFUkZwQVJoRmQwWFRObFUyOTRoUUhFUmczNWli?=
 =?utf-8?B?Q0xqRmYxU2xnQ3BoenhBb2trdW9lcnQvOWxYc0V4andCbnA3R21ZTHhYMGdK?=
 =?utf-8?B?bGhXcC9aNFJGQTZxY2JVS1AzaGI2L08xV2xDMkJ2a25QYTBzZWt5U29XcUF6?=
 =?utf-8?B?WEhCNDVxcGZvSXl1Z1BNSFFSUzA3UDRVdXRaTnRVWlVudjhEN0RXVWl4aEgr?=
 =?utf-8?B?QVpxZWVBVzFWL09vcTNoT25YclJwWW93YTF3RWhhelBhVyswQ0VySTV1enZP?=
 =?utf-8?B?b2QySS9vN1pWWEtZV1hTT2F3R0VnNExvcnFoYTg2dmhLckRFemx1NkRmYk9C?=
 =?utf-8?B?Z0hBeWhvUThXVGxBYkRXN1FnanF5VzZqYWdNemxVUnhnT0dRb3hIUEZoUVNH?=
 =?utf-8?B?YmNDdHN2TUZIQ1VTT0FzR1R6SHNSSzl0ZnBBSWwzMkJyVVBoQlUxdm9FNGNI?=
 =?utf-8?B?Q25WQ1pxOVRZS1h0dkMvNW04OFp3NU5wRFFpbEVRci8xL1dLM1Y4YW5jT2cx?=
 =?utf-8?B?VTlvbEF1Y3FaTlBFcU8yTlZIRVdaWnBiY3NESU5NN1V3bzA1KzM2Z3huZ1hB?=
 =?utf-8?B?S1pqWnJIVWdlb3dWdTBhNXZqN25QcE1DOEpYblF1YVhzZHEzZHNKSjV3MFdB?=
 =?utf-8?B?RmhVYStkOWhoZlh4N0dkRWVFRTE1MkVpaTJWVHZBSjdVbHV4ai8rWGZXREdW?=
 =?utf-8?B?QUkrc3FHV3VvSDFNZTE4MkFqRk9ucVNnWStyck1tRE1uK3lGb0Y4K0hrYTd6?=
 =?utf-8?B?eThKSVNHR25BMU9lSFhPNDZPNW1lTVBqTzBoNUJETEpzMTNBTW1xc0Y0cjZz?=
 =?utf-8?B?RFpaMk55U1FZMCtoVUNGcVhLbjQ0WkhZdFovRnJ4alRBS0N0UnRkU2Mvckt0?=
 =?utf-8?B?ZkUxREdMVnBQYXFHS3BlYmhIOXZGWUhrdjZpOC9yUmhxbENpbDEycUg1cmJ5?=
 =?utf-8?B?c29yQjAwOTNZTkgyOHVLQ0l6SlJQaGxjUGRGQzgwd0VIbExpNVdBTEZDOUlD?=
 =?utf-8?B?M0xPZktiUnYxME00NjNVS3NEbzgraXFIM1N0azNaaGhjNm5RSzNiZE9lbnJL?=
 =?utf-8?B?djNSalIwR1hRZkVEUkExUkovckE3QmNSdnEwRm14cjAyV3NuaFMwQjFyUytG?=
 =?utf-8?B?WERsVzkxUkZZOFdTRWlkazBBVU9IRjNrd1dCc21kZGZLZVFGakc5SnYzRDB6?=
 =?utf-8?B?YzRFMlA4QTdVTytONnBybXZlbzd6Wjd3bTEvdjRVUkJFbFNOdkNuRnZkVHha?=
 =?utf-8?B?cmdMRE83SlBSUm9TallvcG1Xc1BMMWVraXNoVEJJbnI5aGY1QU1BYWN3WjND?=
 =?utf-8?B?ZjhDdEx2STVydGdsTkRnejZLcDlEYWRBcS8xRHYwdnRwSHNCZ2p5MWtrYUJ2?=
 =?utf-8?B?OXVTc1l3NkVSdnB4NEJ0YVFBUE81MGE0SjNlR21wVzVLWi9FcGw2bk5JOVVH?=
 =?utf-8?B?alQ0blcwekpIYnBFWGMxQkxjcGJQN3JjR3BYVzVkKzBXUGpNM20rZUtCNFhl?=
 =?utf-8?B?OUlGaE1wSSs2ZjZQUE01bVhwaGJWOER0SGt0c0p4TE0wUjF3c1EySWQrbUNC?=
 =?utf-8?B?MUZnZHdXN1luRytuZjdjemx1MForczJ0QWw1OXI1bU4yTHdVU0hBSFFPak1k?=
 =?utf-8?B?R3EzQ1pFL2UrR09tUkVEUUlJYkp1RUFwZkcweFBmSDEwY2J3TGdWRDVwbks3?=
 =?utf-8?Q?kS/fCAUdoSk1XJgGKYxoFxHmf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d21635d-a0b0-4631-8cd0-08db516d863f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 15:45:04.8639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XWZ2ls6gELystWQw4FA27ar7d75jZ5TvOtDrB4qY9X27IvqlitDHwuDJ5KuBvqOVbOVbEreMo0W4fNQ9wq0gdj9+GhQv0mYPz3A/8Iqy3c8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3063
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

WW9uZ2hvbmcgU29uZyA8eWhzQG1ldGEuY29tPiB3cm90ZToNCj4gT24gNS85LzIzIDExOjA4IEFN
LCBEYXZlIFRoYWxlciB3cm90ZToNCj4gPiBGcm9tOiBEYXZlIFRoYWxlciA8ZHRoYWxlckBtaWNy
b3NvZnQuY29tPg0KPiA+DQo+ID4gVXBkYXRlIHRoZSBkb2N1bWVudGF0aW9uIHJlZ2FyZGluZyBz
aGlmdCBvcGVyYXRpb25zIHRvIGV4cGxhaW4gdGhlIHVzZQ0KPiA+IG9mIGEgbWFzaywgc2luY2Ug
b3RoZXJ3aXNlIHNoaWZ0aW5nIGJ5IGEgdmFsdWUgb3V0IG9mIHJhbmdlIChsaWtlDQo+ID4gbmVn
YXRpdmUpIGlzIHVuZGVmaW5lZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IERhdmUgVGhhbGVy
IDxkdGhhbGVyQG1pY3Jvc29mdC5jb20+DQo+IA0KPiBMR1RNIHdpdGggYSBmZXcgbml0IGJlbG93
Lg0KPiANCj4gQWNrZWQtYnk6IFlvbmdob25nIFNvbmcgPHloc0BmYi5jb20+DQpbLi4uXQ0KPiA+
IC1CUEZfQVJTSCAgMHhjMCAgIHNpZ24gZXh0ZW5kaW5nIHNoaWZ0IHJpZ2h0DQo+ID4gK0JQRl9B
UlNIICAweGMwICAgc2lnbiBleHRlbmRpbmcgZHN0ID4+PSAoc3JjICYgbWFzaykNCj4gDQo+IAkJ
ICAgIGRzdCBzPj49IChzcmMgJiBtYXNrKQ0KPiA/DQoNCkkgaGFkIHRob3VnaHQgYWJvdXQgdGhh
dCwgYnV0IGJhc2VkIG9uIEpvc2UncyBMU0YvTU0vQlBGIA0KcHJlc2VudGF0aW9uIHllc3RlcmRh
eSB0aGVyZSBhcmUgbXVsdGlwbGUgc3VjaCBzeW50YXhlcy4NCg0KIj4+PSIgdnMgInM+Pj0iIGlz
IG9ubHkgb25lIG9mIHNldmVyYWwuICBUaGVyZSdzICI+PiIgdnMgIj4+PiIsDQp0aGVyZSdzIGFz
c2VtYmx5LWxpa2UsIGV0Yy4gICBTbyBJIHRob3VnaHQgdGhhdCBpdCB3b3VsZCB0YWtlDQptb3Jl
IHRleHQgdG8gZGVmaW5lICJzPj4iIGFzIG1lYW5pbmcgc2lnbmluZyBleHRlbmRpbmcgcmlnaHQN
CnNoaWZ0LCB0aGFuIGp1c3Qgc2F5aW5nIHNpZ24gZXh0ZW5kaW5nICI+Pj0iIGhlcmUuICBBbmQg
SSBkaWRuJ3QNCndhbnQgdG8ganVzdCBhc3N1bWUgdGhlIHJlYWRlciBrbm93cyB3aGF0ICJzPj4i
IG1lYW5zDQp3aXRob3V0IGRlZmluaW5nIGl0IHNpbmNlIG5laXRoZXIgdGhlIEMgc3RhbmRhcmQg
bm9yIGdjYyB1c2UNCiJzPj4iLg0KDQpUaGFua3MgZm9yIHRoZSBBY2suDQoNCkRhdmUNCg0K

