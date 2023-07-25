Return-Path: <bpf+bounces-5831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8F8761ADB
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 16:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51FF1281846
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 14:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496E8200C7;
	Tue, 25 Jul 2023 14:03:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDC48BFF
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 14:03:17 +0000 (UTC)
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020016.outbound.protection.outlook.com [52.101.56.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EF0106
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 07:03:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JoMvZsp2Fs6DYdyMTAGPPhMPM25cnYwJSbkfshybEFzUT3097e8GcQvhgGpZivDEt6J7/lsUNDsAfrDulKB+hH/uDcqN2+DltHL3yW2NEWmNdHg4e5f7UhXyQ4L26awBlVBWAMC9gLxl/F+Kjsq9RDsFYaqDfezAobaougcPWrs7ICFpyx4RHqbzX9xO+baB9aCNJtzltKHIuMHsYCmc0sdjyJkA6+gOmRtkryq2eKygBrbrYC/UkwqxXd59zh/7kwGbhfXRSm28c8LFnfZ5861qTwBUQSES+V40Yud2drGhrv89Il8zaJAkZT+ZoalX+JCDiv8PqcDLJhYCWnx72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orM9xmxyFwYuSwQWQ6gTQiNZcp5MlWgDxNpQSVzKc9w=;
 b=SqLLXYPp6tzluUCzUR/36so0IkwxJa7o4h1g2LTM4XuSjDYpwlS6XKt8sFtb4x/xnZjUDckZC2HLIG+MVonbyMtRDjVMdHvN8T671ymbA7YMVW7MKIjn4+sJOSfuYbFxMriDdRQmRK4sFXEGKHgU8/W3FoUjKecHOurkz97a72VAWVh9U/b86r+QTtVzzJCjJFvkcUsLfeoRB1/2ZIJJC3TbB0plBCtugzNqjAb/Cnwmx1vHkTv/Dyom4jrssDLxzmKrOgWmUX1tgWjwTPSh9Q5vyIeLtKEWQB3JQzoi+2EuoSkTWMKPxKZ/xfYeadH29vsS4vGZ5LRHs96DCwcnXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orM9xmxyFwYuSwQWQ6gTQiNZcp5MlWgDxNpQSVzKc9w=;
 b=CIL3R4Br0wSv2ys006wtepCaAWWV+sNDJkm4ueYOq/uL0O4O1kFoi/JH5Ths6hOBJE3ThOHWvXV7eGMowkoaBlaMxvvC2u+jM2l53DQHAkkf+Q49W0IEdplmefMSobxtl7/jZDQjcRflQqf5uewPwOSq+7BHqK0CBcQmEir1fjE=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by MN0PR21MB3217.namprd21.prod.outlook.com (2603:10b6:208:37a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5; Tue, 25 Jul
 2023 14:03:14 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::3cfe:3743:361a:d95b]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::3cfe:3743:361a:d95b%3]) with mapi id 15.20.6652.002; Tue, 25 Jul 2023
 14:03:14 +0000
From: Dave Thaler <dthaler@microsoft.com>
To: Watson Ladd <watsonbladd@gmail.com>, "bpf@ietf.org" <bpf@ietf.org>, bpf
	<bpf@vger.kernel.org>
Subject: RE: [Bpf] Review of draft-thaler-bpf-isa-01
Thread-Topic: [Bpf] Review of draft-thaler-bpf-isa-01
Thread-Index: AQHZvrWW9Z2mpBtp0E2+6M55X5/AaK/Kg57w
Date: Tue, 25 Jul 2023 14:03:13 +0000
Message-ID:
 <PH7PR21MB3878D8DCEF24A5F8E52BA59DA303A@PH7PR21MB3878.namprd21.prod.outlook.com>
References:
 <CACsn0ckZO+b5bRgMZhOvx+Jn-sa0g8cBD+ug1CJEdtYxSm_hgA@mail.gmail.com>
In-Reply-To:
 <CACsn0ckZO+b5bRgMZhOvx+Jn-sa0g8cBD+ug1CJEdtYxSm_hgA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3414c648-ced2-4971-8546-bdccb3c4dcc3;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-25T14:01:32Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|MN0PR21MB3217:EE_
x-ms-office365-filtering-correlation-id: b9f70826-55dd-4dcd-3b8a-08db8d17e349
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 c/cpC2e4kguEl821SIO8exyTsWkNff2uVJE9hN66cjAT+PB8hlhwV9L9o4dmN6RPRmDiD0BUT5BGcvw1rYNVFjFXnbh8EvxEWvULinqWhfD7TMjej0VIxUaBMhnTWcmUw4F81Mw0z4OeqmAeMM5dYTuGrhbpTuwa+vFGrMdT40RYXQyZSmAEOEQZGK+Rki9Y7MrHsLQzbPjV7gY3JnkK/AJDzI+dM4UkSlPO1loQyMj2vNVo3dttZvCQPGmMYvILOKd6R0oGE27Yd0IKtWx8RD2qja9rEHeNiAfkCzdvXhZPGZTmf9BHuczGHK/AGn8dpn9B7Yuu5PCKm3jCX8dNU0oW8xJGBqVgpFnFQNMDTBKIBc5ECBS4qzXTTfGuiUwgKhKCtOnc9XRL5baW3bvdqMDSsRthitum42EAkdOwNGi6MGyZWRlcygaUpNAdY/dDxLJMbfDRKsK/W02LiN7yV6nxERLjlzTkMm4zyk1ioMRbLawJ0h4JCJX/zy39jgYQ9P3B6X1wh5WYLVPupo0VhCijSkXwIh/wf2h2PpJxZWY0cnjjC7SkM8flrJEU66TK8QsT8K2d1whO7efVh00eNdVs7jkG2yNN/6Mtu4qNauDSmo2Oa4jI7/T2K8+e8fQqeCzOsOT1f4hGEzNkxIvsSLHehPw0xquDSHIKm9apBbE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199021)(8990500004)(55016003)(52536014)(5660300002)(4744005)(2906002)(478600001)(10290500003)(110136005)(7696005)(71200400001)(316002)(8676002)(41300700001)(8936002)(66946007)(66446008)(64756008)(66556008)(66476007)(76116006)(33656002)(83380400001)(86362001)(38100700002)(122000001)(82950400001)(82960400001)(38070700005)(9686003)(186003)(6506007)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b2UwMndKb1NOUU9RdDltRFhNZGt4cVozOGR1MFlSYjdDTjdCL0t3UkFTUzlq?=
 =?utf-8?B?OG5ua25uV3h0Y0JxOXUvaGM0ODNPQlZVdUFCZUlYTGZ0N29oeitCSy92K0JW?=
 =?utf-8?B?Y0ZoWTl1OEpmcnFMWVJCa2dGY3B4ZFlIS3FDTjRxTGpSb0lzWDBBcWgyRDBn?=
 =?utf-8?B?NFFnOFEwRmovNVYwYWI1emlweWxYZzVqOGVjSm95TFYwK0c4TThKd3Bvc21Q?=
 =?utf-8?B?MzBmN0hKK3hOSHhJQ0phekMrRy9CczhaZ2xqZGhQY3gvR2k1OVNlRFkrZ2V1?=
 =?utf-8?B?Y1llNG0wQlJXRzRzNzgwbWdxMjRDNXd0YmZuTVVGamxqQ1hJd3BqK25FRjhO?=
 =?utf-8?B?dzJ3UVp3a3Q5WnhBb3RKdndMU0dCYXdyMUhCZEdHM1VxdmhhalNvMG9tQWhr?=
 =?utf-8?B?N0JpMDVvc2VyZGZmT3BqRXNqWDBVUWJ1QS9OVzBBV1ZiNkFqdGQ1WFExRGxP?=
 =?utf-8?B?MXBkek9WcDIyOGVnRmh5ZTY3eWxrRDNPWUNhZUZOdXVvSnplRkJhM0Z1MzdW?=
 =?utf-8?B?WkgvN1FQS3VHMzEzVjFFUHMySzk1UUtndDZqdmdFdjBYNVZHdEpkSmNYeEt4?=
 =?utf-8?B?YVZjdDI5SmtLN09ZL2F0UE5ERE9TK1JnU1cvVW5nTitVN0gzbUU5UGtJYm5j?=
 =?utf-8?B?TkZQVFUzeDU5aHdiTGI1THZ3Z1VjOHN4NHZtVkF2VFN3QVBCSnF6Vng2VzNw?=
 =?utf-8?B?bG1oUGpxRkNYblNNYkl5OEZ0SUwwcmdNR1hIdHgzQ1FkdnVFK1ZSNXNCNGhR?=
 =?utf-8?B?dkxRWXVWY2NBaCtSRmZTSW10bkRBNm5mTmhlR2g4R1ZobFZaM2VlazRmc0JL?=
 =?utf-8?B?QXpvR3RsYlhFZU1kNGlQUkJJVS9aekV1RUVQd2JQSVhZN2FFalNQOUorMDJW?=
 =?utf-8?B?Y294dUtwWTZRNE5qNnEzOFIxTndISjNyRHBXODZMbWZ6UDEwa0dmcjgxcEJ4?=
 =?utf-8?B?VS9QUFYvUklETHc3WU4rQWFXRDQ0RWlCSCswYW5NRTkvTjQ1VjFVajhodUls?=
 =?utf-8?B?SmJ1ZlZlVXdSSE5lM0JPTE92Qjl2RXV1a1gydUZTcEN0Y05rSlVyTWF2TGVC?=
 =?utf-8?B?OU1HVDVqZVlZVldZOEErclRjU1ozbGJLb1ZPVm94dXpSZWVhMEs3VFRCQXFN?=
 =?utf-8?B?V0VOK3RSTEs2aXQ3WHNlZlZpNXcybVBFWG9DVm16N3BPNXZGdXc3QXFkR0xC?=
 =?utf-8?B?bldoS0FHcDMzZGs5T1N1SHFzYjZjNSt4TlBFS2o1eU5YSmZTb1hmbGgvRTd0?=
 =?utf-8?B?eHFyKy9OZ0hQZTVJNWFjMXlOMmNqMTJKUzVYb1d4UzVybmRBVWJMdEZqMWJ1?=
 =?utf-8?B?Y01RRXdaNWlOWEc2U0NTY1k3eHFvTHBrRklDc3hyTXVBZjBPZ2NYMEdSTjVx?=
 =?utf-8?B?RlRpUm1TZnZmS3RSMXZYTVVUeTNvOUI2QXRQR0ZLaDlTQ25NUnhiczY0Rmxv?=
 =?utf-8?B?R2hhVGtwUWloVEozK0J3ZjRZcVdtTkhDMjdwRStVNGxuQWpvb3FnMUxzNkFR?=
 =?utf-8?B?OEY2QmpXRFk4ak9EcHJKME1BemcyL3dkNmw0RHhlbURXNEx2MStwVERuSzlC?=
 =?utf-8?B?R3huSjlQbk8vL3p5c09MK2lOcCtBd1krVEg5MEUva1BOcWRDZlViY2F5QnZq?=
 =?utf-8?B?N24vRlJiZ29OUk5UYWhhdDVNL01IVlBkTUJ5NWw1dWFFN0NwYklBak1GS3NO?=
 =?utf-8?B?MjB5bkkvQnNxUk1pVFcxa0xmaEhBaFI2SGxUWlc1NXd3Zml2Mm1zWFZFeGRm?=
 =?utf-8?B?ajdUb0dnVTYycUU1UXhwTFBPZFFKem9lNGdZSlNVZjMxazNYdmlUMlhKaElN?=
 =?utf-8?B?dUd2OVdWVkF5d1BGaFJBSk9obkFRSDVKeTZyelRmZCtJekppeHFtZFZ3QStS?=
 =?utf-8?B?cUVsWVlrVVJmL0tlSTdPeFVIRkh2QzBvZUtqQTFMVDRIUWs5L2c1RDU2aUtZ?=
 =?utf-8?B?VExyd1pTM1lSY2hsbmJmdkh1bHJZTUtLckVYVUdyci9wVjZnZTVzOTUwYWI2?=
 =?utf-8?B?N0JQbmpTd2kwNG0wV2cwY0p0VU5iUzFQeHN6RS9WeE9yQ0ZrNndzbmttcDEy?=
 =?utf-8?B?MEFjRjBRaitWSmEwZWM4eDVYN3hEUWR2QXFvMkpFZXR6T1dGOVlxa05nN3h4?=
 =?utf-8?B?WFNCUXRObmkrbTYxVWRIOVhGOWJubjlaZUQyc2ZoQ2JKN2hGVHVOVTBvekFM?=
 =?utf-8?B?QXBMVFZtSWUyNlBrQ1pZTGZkMHlVbThiZWoycC9HcUt1MCtkbElCbGRORFlU?=
 =?utf-8?B?N2FCTEtuMHBWTlJScEQwNXJtTXp3PT0=?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f70826-55dd-4dcd-3b8a-08db8d17e349
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 14:03:13.9614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tVpIsBB9SNlnc3ZmjIA07ln/UgrdkAkdQdezwewjMGq+zUOAZgUYt6c4B3M6KaDL5FeFiTUHN+FBQUGFe5xD0AWhezWj9PEwDvmyq6YLGbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3217
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SSBhbSBmb3J3YXJkaW5nIHRoZSBlbWFpbCBiZWxvdyAoYWZ0ZXIgY29udmVydGluZyBIVE1MIHRv
IHBsYWluIHRleHQpDQp0byB0aGUgbWFpbHRvOmJwZkB2Z2VyLmtlcm5lbC5vcmcgbGlzdCBzbyBy
ZXBsaWVzIGNhbiBnbyB0byBib3RoIGxpc3RzLg0KDQpQbGVhc2UgdXNlIHRoaXMgb25lIGZvciBh
bnkgcmVwbGllcy4NCg0KVGhhbmtzLA0KRGF2ZQ0KDQo+IEZyb206IEJwZiA8YnBmLWJvdW5jZXNA
aWV0Zi5vcmc+IE9uIEJlaGFsZiBPZiBXYXRzb24gTGFkZA0KPiBTZW50OiBNb25kYXksIEp1bHkg
MjQsIDIwMjMgMTA6MDUgUE0NCj4gVG86IGJwZkBpZXRmLm9yZw0KPiBTdWJqZWN0OiBbQnBmXSBS
ZXZpZXcgb2YgZHJhZnQtdGhhbGVyLWJwZi1pc2EtMDENCj4NCj4gRGVhciBCUEYgd2csDQo+DQo+
IEkgdG9vayBhIGxvb2sgYXQgdGhlIGRyYWZ0IGFuZCB0aGluayBpdCBoYXMgc29tZSBpc3N1ZXMs
IHVuc3VycHJpc2luZ2x5IGF0IHRoaXMgc3RhZ2UuIE9uZSBpcw0KPiB0aGUgc3BlY2lmaWNhdGlv
biBzZWVtcyB0byB1c2UgYW4gdW5kZXJzcGVjaWZpZWQgQyBwc2V1ZG8gY29kZSBmb3Igb3BlcmF0
aW9ucyB2cw0KPiBkZWZpbmluZyB0aGVtIG1hdGhlbWF0aWNhbGx5Lg0KPg0KPiBUaGUgZ29vZCBu
ZXdzIGlzIEkgdGhpbmsgdGhpcyBpcyB2ZXJ5IGZpeGFibGUgYWx0aG91Z2ggdGVkaW91cy4NCj4N
Cj4gVGhlIG90aGVyIHRob3JuaWVyIGlzc3VlcyBhcmUgbWVtb3J5IG1vZGVsIGV0Yy4gQnV0IHRo
ZSBvdmVyYWxsIHN0cnVjdHVyZSBzZWVtcyBnb29kDQo+IGFuZCB0aGUgZG9jdW1lbnQgb3ZlcmFs
bCBtYWtlcyBzZW5zZS4NCj4NCj4gU2luY2VyZWx5LA0KPiBXYXRzb24gTGFkZA0K

