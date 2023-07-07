Return-Path: <bpf+bounces-4375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF0B74A883
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 03:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 404682809C9
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 01:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A608110F;
	Fri,  7 Jul 2023 01:36:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FD67F
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 01:36:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2123.outbound.protection.outlook.com [40.107.92.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A37C1FE3
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 18:36:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgoYQKqnwEdIGWPJWnJgxALEjjbXSrmywadi3lXF7JwBQY8J4ejwkEwTeytog/rXTuuwhDuHKPvPrSdboyjvVNcm8NztmvppWepT94sH1zY3tKbHxk1VickpSP8Qub8LDxzD2b7qOeeRmxEykWo6jBq9aby2GJTVA0ahfxvm0nD054F7q2bLMhaxk9neoJXi1bkJAGdguf6PmTvCIDUAasyZ4feYkZ9lReWxXYZDxSrBz5b0VdReDZe8k28qgPrqp4L6pyU6JGo/arZKM3sIqUhDInKz0/lCZ/Svp4COWZVVWqOPpeWEYFi7F/k0sVI1tgvvpq8rTNwyUK4MGkOwdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+N7//9sZxONhsSnxrGPu83Xz5yPAQh5kYYyD0Exkee4=;
 b=HjBcSYbewaVjpQDsk3gV/ZIIU065KjjTHCgrHjbH2RtqWSm5bPuldIkWvMKWN+RX1kB6ELr9IZ6TaKqgSaQLlt7tqjcG7noK0oYkxwm6AW6rpZSHfzadX/KRaRFDYT7Y579mEvGomQt4wOQT5RYfyOZIlQbaz8yHUjlA72jwSOeFe/v4if5+WJiRiwKkWgnkmBkz3CVdJlqAyJLVZousIp4bGgPChIayywS9THmBTasDG+b2+OLa7DYWN4PcalzZiFCK/1vBT2400WkIGqfQWxQ85/vss4NDqhShhEVYqJ/hG2z+YxW+YJWRxDjQTzRfXKr+oQAEqpQibA4A4BKSJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+N7//9sZxONhsSnxrGPu83Xz5yPAQh5kYYyD0Exkee4=;
 b=TLxGOzLAnfaITR8f+RoIQWzufKrTYOfz3iHGkbE+733Vg6IUy6/FpHoGKolG05irrNKefu8MKh51k+LCr0MXQ9juZDrTEKvknM2L7RayFav54+dxdhnpmJtgMtCU/Ro+t+1ZuIS6RyYfKW5fINaYI1bZzyD7LGTtQnPsyeWmCpA=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by MN0PR21MB3291.namprd21.prod.outlook.com (2603:10b6:208:37f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.5; Fri, 7 Jul
 2023 01:35:43 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::8708:6828:fb9f:7bd5]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::8708:6828:fb9f:7bd5%4]) with mapi id 15.20.6544.010; Fri, 7 Jul 2023
 01:35:43 +0000
From: Dave Thaler <dthaler@microsoft.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Subject: RE: [Bpf] Instruction set extension policy
Thread-Topic: [Bpf] Instruction set extension policy
Thread-Index: AdmwKdCg+G2TzllJT+2ICM2r0nWi5AAR1CgAAABLvuA=
Date: Fri, 7 Jul 2023 01:35:42 +0000
Message-ID:
 <PH7PR21MB3878DEA7280C274A8A18D082A32DA@PH7PR21MB3878.namprd21.prod.outlook.com>
References:
 <PH7PR21MB387813A79D0094E47914C5A8A32CA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQJhfa+g227BX=3LijoXwgh7h3Z5V_ZF8tMeMWNZguAp5g@mail.gmail.com>
In-Reply-To:
 <CAADnVQJhfa+g227BX=3LijoXwgh7h3Z5V_ZF8tMeMWNZguAp5g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=52d89986-5de2-4679-9c83-a34cda833ac1;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-07T01:28:20Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|MN0PR21MB3291:EE_
x-ms-office365-filtering-correlation-id: 379633ea-997b-4c5d-dba0-08db7e8a7a4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jYumcv/4rsF/I38A1ZDODcItNb/9Lg2Fxpi8M7i6IoDxAv4jjWAOSUJWvqJncuyCMdp+XaMGye3lpx6DUk29r678tT/2wZQi/RLaE/agC6QiEe0paSskgvgxWBre5waT9Zxg2TMXXPoB9N/zNVI07OuwFb+XW9AEhJ1LK+y/4GRgAUiZebUlK9BEyxVZ0ePr9vuBir9H5wZWnY55EhuUU4o8wfB2yXUP3Z68c2bAzAYrsRo18vexVOdnmbfHefVNX1Riyq2FlIP2LyZxnHhFlIwWZpioBRzc0P/RBnAp06zh0FkNvvGBfgfbigOSE4e1LSelaV0fhAiXLG3wCmVrKYSFiiNJjD2t8q1AcwXy802pZnOEFZA5MkdivqSELw4EpeNNi2UCUEpWrheMGpW0p8DIHHPZ3b8n9k8XArmZgykd6lm9pTC1QeneenFSWmmpE6Pb1HGbkwi27GCG0+ifMeBgT24dLnaGR3wwsaDe08ydQqIRfkuJUXMgBaVTj8ANMBmRh/tm/naf1ajlhBFIsF0nWYO5s4QJHD5BPVABfq6z2jjgPatW7NTVn+ESUkq9dTk49bclAiKQCi2TxxrWHwZXsbALgvvKm4YFshZ0dTYxgIRF0oQ1GamcCLJtTzCWIoDLSsXwrIjIEI0zCqov09aOS4j171/uMB5n1Bh71wg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199021)(478600001)(71200400001)(7696005)(10290500003)(76116006)(54906003)(26005)(38100700002)(6506007)(53546011)(186003)(9686003)(2906002)(8990500004)(8936002)(66446008)(122000001)(66476007)(5660300002)(66556008)(8676002)(316002)(41300700001)(4326008)(6916009)(64756008)(82950400001)(66946007)(82960400001)(52536014)(38070700005)(86362001)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aDBVTys2cFB2YTVQbk1hZU5qU3VEUUR5SmJIcm1RTkEwT0lKdFVtb2lTRWRy?=
 =?utf-8?B?bFRFY2pOckpnbmo0NXoyS1NXVnlVZ1c0MS9wQXNaQ2RTS1NBRE9NcTRFclQ3?=
 =?utf-8?B?T0FJa1FrbG1HY0NkdVVWU29qeXZsditLb2hQOTdsSWQ4OUpsZFBCa1BLZzFj?=
 =?utf-8?B?Zlc3R25UZklpQWNCb1hERG5yR0FHeG1lZThGcVFMQkU3cVhSeFFVL21vY3Qv?=
 =?utf-8?B?Q3UwTytTbGtQM2lXdXJHVUlmYm9mRlpqclRCMDRLTDZrazZUYjNuamFlTVdZ?=
 =?utf-8?B?WUJMNWNUN0N6OGY4TW9ocW5VNmlaNGF1WER1OEwySWQ5dmdSK2dMNzZucFc5?=
 =?utf-8?B?UnIwNkFRdEh5SGhOZTZ2QzYvK2prc2VJMCs4T3ZoUWtEQ25aVnVITFV1dFlL?=
 =?utf-8?B?L0xyYWxoc2lXS3hBMkJiQlp5Wm1mT003SnV0UGVnWW9ZakJ0VTE2YmVBMzRM?=
 =?utf-8?B?bk16UFlPKzhTSWZXYlVVcGNuVDdxeE9DZzJ4eU41SGxyT2N0RitIOWdDSSsv?=
 =?utf-8?B?dWMyYmswNDMyWDFpSFFWQURIRnRGSlRFbU1YMjZ3WHR6WEY0dnQvell2TG03?=
 =?utf-8?B?K1VjQWlHMnByV2lza1RydCtDanF3UkdBZlhNUTJ4L2pJK3ROV2tPQis0aUtj?=
 =?utf-8?B?QnJONE1SbUlpWnpRc0VjdG9ZOWUyVkswekQyaVlER0NYSUljVEdxakM3MGFW?=
 =?utf-8?B?VWllK2FTclNwVWQvaHZMUnpVc0lNZnY1V25tSUhnTWtCWjhvTkFCN0NYcEJK?=
 =?utf-8?B?NHBTZmVDVVd5WDhWdjY5MkhEczdxM1dvUmxwT1lNYmNjVGV4YXdPN1hoSXFM?=
 =?utf-8?B?YTUwdWRCOVlxNk1zeTgvckE5c0Q2cUZCNEwvVmJ6eEErYmtWOEJSdVpmRTl2?=
 =?utf-8?B?c2FuWStyV3p5WXF3aDFFK3JwYVBZaHdmUS9zVkRlRWJkRlg4S3BjY0lPVG9r?=
 =?utf-8?B?dzIwWTRPMjFDOUhNRkZON0dQR2dSSDY3S1dwVDBjV29qSTlpbVBmN3pjZlVV?=
 =?utf-8?B?UENxSkNxWFF1UFljcW9MRi9oalQvaFJ3SDhJdlJHTldwTkJZZDJ0SnRIaEND?=
 =?utf-8?B?ZHZYSTNlVHhTdnoyRzNJR21IMk5yWmdNZy9DbnNPUkkzQ3dTYmZWUDF1anFR?=
 =?utf-8?B?LzczYUxOdk1oSEIyWjlFWHArZHpxV3ArNnE0UCtsTjFPazlFbktNSjY3aVZ0?=
 =?utf-8?B?ZERVTFc3L3doUW5TVGJMdjRFYnVjeGRjTVNNN1p5NTUxck0rVTFkN3E0UkVX?=
 =?utf-8?B?UE13SC9CUUNmVitERml3VjlTaStSMklVbmY3THBkdTYzYUlaMTBzaWt3bE9q?=
 =?utf-8?B?QmdidkM0TXd2VTM0REd6bUpJRGEyWjB1K3dxWDg5SmxMVjlnVldyTHRjQnNm?=
 =?utf-8?B?Z0V6U1J0aGwzL3BWcmpuR3pXTW93YkRaTEhpNVFPdkRkSkNzNVZmZzhlL3Vx?=
 =?utf-8?B?bzRTRjlqT0xISzNKbzNmVDU0dFE2bjJWd2VqZ2hmWlltRFRhTkJyU0RmQ1pi?=
 =?utf-8?B?TEJoTXV5OG5XTzlMbURSbW8zMFUwUm51OVlJZ2N5MTJvRDFDVnJJNmFFMmMz?=
 =?utf-8?B?QzZjeVdtVjkvanlLTUFiaUNINkVyNFRmdmVKSzY5aGpVVFNyWm9qcFlwT3hP?=
 =?utf-8?B?enBHU1ZGbTVNc2drdU5PeEJBZU9PREp6N3J4Y0dQY3o4QVFtV1RKWmQza3Vt?=
 =?utf-8?B?S3dwbzMzVmFNakd1OUxadzJETVFHdmRXenBpSEx4U251cElNN0Fod0d0Y1FK?=
 =?utf-8?B?UEI4MjIrWEhCbVlyeWVkdXEzTVBOMDhRdDlFd05hQ051Ymtkc1kyTzB4YlBn?=
 =?utf-8?B?RnRVaEF0aHBrcVRPNFFSRWtqaEpsLzBCQllzQWhFajNIdUUwR0owSGh3R25n?=
 =?utf-8?B?bkpFUnBCajlPcEwraUIwRTljdjU0VE5Vcm0xVkI0K3pJRXlyWGQrNVJGZUVx?=
 =?utf-8?B?OU93d2YvQzJYQTFjQ09GRDcycmRvaXcyWjlXTDJYRWNzOUhlaVlMaGowOWlt?=
 =?utf-8?B?TG5lSTRaOE1EcC9BWmJualdjVS9oZy92WFJ1WGlqSDQ1SkNJLzF1cGpjcUZr?=
 =?utf-8?B?eE5xakxVRXZCWkh3MHlSYkZ5R1NyQ25RdFQ5YkhOaWZyZGVhVWpxNWVnd002?=
 =?utf-8?B?NGk4MHd6c3VTWG03S21PSmN6V0VUMDBYOFQ0U3lIZE9rTjVFTXRzejNMTHRW?=
 =?utf-8?B?U1E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 379633ea-997b-4c5d-dba0-08db7e8a7a4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 01:35:42.5271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +IPjPpNdccTvqSZjsBSZIqwKauKSUzpCCxj5SXUV0SMIBRagHK57vbO6qIg2XELO1X+7ccKLH2+zvy6kGqfbp3IKL0F+u8Y8oB45JHT9zDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3291
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

QWxleGVpIFN0YXJvdm9pdG92IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cml0ZXM6
DQo+IE9uIFRodSwgSnVsIDYsIDIwMjMgYXQgMTA6MDDigK9BTSBEYXZlIFRoYWxlcg0KPiA8ZHRo
YWxlcj00MG1pY3Jvc29mdC5jb21AZG1hcmMuaWV0Zi5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gVGhl
IGNoYXJ0ZXIgZm9yIHRoZSBuZXdseSBmb3JtZWQgSUVURiBCUEYgV0cgaW5jbHVkZXM6DQo+ID4N
Cj4gPiDigJxUaGUgQlBGIHdvcmtpbmcgZ3JvdXAgaXMgaW5pdGlhbGx5IHRhc2tlZCB3aXRoIOKA
piBjcmVhdGluZyBhIGNsZWFyIHByb2Nlc3MNCj4gZm9yIGV4dGVuc2lvbnMsIOKApuKAnQ0KPiA+
DQo+ID4NCj4gPg0KPiA+IEkgd2FudGVkIHRvIGtpY2sgb2ZmIGEgZGlzY3Vzc2lvbiBvZiB0aGlz
IHRvcGljIGluIHByZXBhcmF0aW9uIGZvcg0KPiA+IGRpc2N1c3Npb24gYXQgSUVURiAxMTcuDQo+
ID4NCj4gPg0KPiA+DQo+ID4gT25jZSB0aGUgQlBGIElTQSBpcyBwdWJsaXNoZWQgaW4gYW4gUkZD
LCB3ZSBleHBlY3QgbW9yZSBpbnN0cnVjdGlvbnMNCj4gPiBtYXkgYmUgYWRkZWQgb3ZlciB0aW1l
LiAgSXQgc2VlbXMgdW5kZXNpcmFibGUgdG8gZGVsYXkgdXNlIHN1Y2gNCj4gPiBhZGRpdGlvbnMg
dW50aWwNCj4gPg0KPiA+IGFub3RoZXIgUkZDIGNhbiBiZSBwdWJsaXNoZWQsIGFsdGhvdWdoIGhh
dmluZyB0aGVtIGFwcGVhciBpbiBhbiBSRkMNCj4gPiB3b3VsZCBiZSBhIGdvb2QgdGhpbmcgaW4g
bXkgdmlldy4NCj4gPg0KPiA+DQo+ID4NCj4gPiBQZXJzb25hbGx5LCBJIGVudmlzaW9uIHN1Y2gg
YWRkaXRpb25zIHRvIGFwcGVhciBpbiBhbiBSRkMgcGVyDQo+ID4gZXh0ZW5zaW9uDQo+ID4NCj4g
PiAoaS5lLiwgc2V0IG9mIGFkZGl0aW9ucykgcmF0aGVyIHRoYW4gb2Jzb2xldGluZyB0aGUgb3Jp
Z2luYWwgSVNBIFJGQy4NCj4gPiBTbyBJIHdvdWxkIHByb3Bvc2UgdGhlIGFiaWxpdHkgdG8gcmVm
ZXJlbmNlIGFub3RoZXIgZG9jdW1lbnQgKGUuZy4sDQo+ID4gb25lIGluIHRoZSBMaW51eCBrZXJu
ZWwgdHJlZSkgaW4gdGhlIG1lYW50aW1lLg0KPiA+DQo+ID4NCj4gPg0KPiA+IEZvciBjb21wYXJp
c29uLCB0aGUgSUFOQSByZWdpc3RyeSBmb3IgVVJJIHNjaGVtZXMgYXQgWy4uLl0gZGVmaW5lcyBz
dGF0dXMgdmFsdWVzIGZvciDigJxQZXJtYW5lbnTigJ0gYW5kDQo+ID4g4oCcUHJvdmlzaW9uYWzi
gJ0gd2l0aCBkaWZmZXJlbnQgcmVnaXN0cmF0aW9uIHBvbGljaWVzIGZvciBlYWNoIG9mIHRob3Nl
DQo+ID4gdHdvIHN0YXR1c2VzLg0KDQpJIGhhdmUgdG8gY29ycmVjdCBteXNlbGYsIGl0IGFjdHVh
bGx5IGhhcyAzLCB0aGUgdGhpcmQgYmVpbmcgSGlzdG9yaWNhbCwgd2hpY2ggZG9lcw0KbWFrZSBz
ZW5zZSBmb3IgZGVwcmVjYXRlZCBpbnN0cnVjdGlvbnMuDQoNCj4gPiBTaW1pbGFybHksIEkgd291
bGQgcHJvcG9zZSBhcyBhIHN0cmF3bWFuIHVzaW5nIGFuIElBTkEgcmVnaXN0cnkgKGFzDQo+ID4g
bW9zdCBJRVRGIHN0YW5kYXJkcyBkbykgdGhhdCByZXF1aXJlcyBzYXkgYW4gSUVURiBTdGFuZGFy
ZHMgVHJhY2sgUkZDDQo+ID4gZm9yDQo+ID4NCj4gPiDigJxQZXJtYW5lbnTigJ0gc3RhdHVzLCBh
bmQg4oCcU3BlY2lmaWNhdGlvbiByZXF1aXJlZOKAnSAoYSBwdWJsaWMNCj4gPiBzcGVjaWZpY2F0
aW9uIHJldmlld2VkIGJ5IGEgZGVzaWduYXRlZCBleHBlcnQpIGZvciDigJxQcm92aXNpb25hbOKA
nQ0KPiByZWdpc3RyYXRpb25zLg0KPiA+IFNvIHVwZGF0aW5nIGEgZG9jdW1lbnQgaW4gc2F5IHRo
ZSBMaW51eCBrZXJuZWwgdHJlZSB3b3VsZCBiZQ0KPiA+IHN1ZmZpY2llbnQgZm9yIFByb3Zpc2lv
bmFsIHJlZ2lzdHJhdGlvbiwgYW5kIHRoZSBzdGF0dXMgb2YgYW4NCj4gPiBpbnN0cnVjdGlvbiB3
b3VsZCBjaGFuZ2UgdG8gUGVybWFuZW50IG9uY2UgaXQgYXBwZWFycyBpbiBhbiBSRkMuDQo+IA0K
PiBUaGUgZGVmaW5pdGlvbiBvZiBzdGF0dXMgYW5kIHRoZSBzZW1hbnRpY3MgbWFrZSBzZW5zZSwg
YnV0IEkgc3VzcGVjdCB0bw0KPiBpbXBsZW1lbnQgdGhlbSB2aWEgZnVsbCBJQU5BIHdvdWxkIHJl
cXVpcmUgdG8gbGlzdCBldmVyeSBpbnN0cnVjdGlvbiBlbmNvZGluZw0KPiBpbiB0aGUgcmVnaXN0
cnkgYW5kIHRoYXQncyB3aGVyZSBJQU5BIGtleS92YWx1ZSBtYXBwaW5nIHdvbid0IHdvcmsuDQo+
IDgtYml0IG9wY29kZSBpcyBvZnRlbiBub3QgZW5vdWdoIHRvIGRlbm90ZSBhbiBpbnN0cnVjdGlv
bi4NCj4gQWxsIG9mIHYxLHYyLHYzLHY0IGV4aXN0aW5nIGV4dGVuc2lvbnMgdG8gQlBGIElTQSBo
YXBwZW5lZCBieSBhIGNvbWJpbmF0aW9uDQo+IG9mIG5ldyA4LWJpdCBvcGNvZGVzIGFuZCB1c2lu
ZyByZXNlcnZlZCBiaXRzIGluIG90aGVyIHBhcnRzIG9mIDY0LWJpdCBpbnNuLg0KPiBOb3cgd2Ug
cHJldHR5IG11Y2ggcmFuIG91dCBvZiA4LWJpdCBvcGNvZGVzLg0KPiBTbyB0aGVyZSBpcyByZWFs
bHkgbm90aGluZyB0aGUgSUFOQSByZWdpc3RyeSBjYW4gaGVscCB3aXRoLg0KDQpJIGRvbid0IHNl
ZSBhbnkgcHJvYmxlbSB3aXRoIGRlZmluaW5nIGFuIElBTkEgcmVnaXN0cnkgd2l0aCBtdWx0aXBs
ZSAia2V5IiBmaWVsZHMNCihvcGNvZGUrc3JjK2ltbSkuICBBbGwgZXhpc3RpbmcgaW5zdHJ1Y3Rp
b25zIGNhbiBiZSBkb25lIGFzIHN1Y2guDQoNCkJlbG93IGlzIHN0cmF3bWFuIHRleHQgdGhhdCBJ
IHRoaW5rIGZvbGxvd3MgSUFOQSdzIHJlcXVpcmVtZW50cyBvdXRsaW5lZA0KaW4gUkZDIDgxMjYu
Li4NCg0KLURhdmUNCg0KLS0tIHNuaXAgLS0tDQpJQU5BIENvbnNpZGVyYXRpb25zDQo9PT09PT09
PT09PT09PT09PT09DQoNClRoaXMgZG9jdW1lbnQgcHJvcG9zZXMgYSBuZXcgSUFOQSByZWdpc3Ry
eSBmb3IgQlBGIGluc3RydWN0aW9ucywgYXMgZm9sbG93czoNCg0KKiBOYW1lIG9mIHRoZSByZWdp
c3RyeTogQlBGIEluc3RydWN0aW9uIFNldA0KKiBOYW1lIG9mIHRoZSByZWdpc3RyeSBncm91cDog
c2FtZSBhcyByZWdpc3RyeSBuYW1lDQoqIFJlcXVpcmVkIGluZm9ybWF0aW9uIGZvciByZWdpc3Ry
YXRpb25zOiBUaGUgdmFsdWVzIHRvIGFwcGVhciBpbiB0aGUgZW50cnkgZmllbGRzLg0KKiBTeW50
YXggb2YgcmVnaXN0cnkgZW50cmllczogRWFjaCBlbnRyeSBoYXMgdGhlIGZvbGxvd2luZyBmaWVs
ZHM6DQogICogb3Bjb2RlOiBhIDEtYnl0ZSB2YWx1ZSBpbiBoZXggZm9ybWF0IGluZGljYXRpbmcg
dGhlIHZhbHVlIG9mIHRoZSBvcGNvZGUgZmllbGQNCiAgKiBzcmM6IGEgNC1iaXQgdmFsdWUgaW4g
aGV4IGZvcm1hdCBpbmRpY2F0aW5nIHRoZSB2YWx1ZSBvZiB0aGUgc3JjIGZpZWxkLCBvciAiYW55
Ig0KICAqIGltbTogZWl0aGVyIGEgdmFsdWUgaW4gaGV4IGZvcm1hdCBpbmRpY2F0aW5nIHRoZSB2
YWx1ZSBvZiB0aGUgaW1tIGZpZWxkLCBvciAiYW55Ig0KICAqIGRlc2NyaXB0aW9uOiBkZXNjcmlw
dGlvbiBvZiB3aGF0IHRoZSBpbnN0cnVjdGlvbiBkb2VzLCB0eXBpY2FsbHkgaW4gcHNldWRvY29k
ZQ0KICAqIHJlZmVyZW5jZTogYSByZWZlcmVuY2UgdG8gdGhlIGRlZmluaW5nIHNwZWNpZmljYXRp
b24NCiAgKiBzdGF0dXM6IFBlcm1hbmVudCwgUHJvdmlzaW9uYWwsIG9yIEhpc3RvcmljYWwNCiog
UmVnaXN0cmF0aW9uIHBvbGljeSAoc2VlIFJGQyA4MTI2IHNlY3Rpb24gNCBmb3IgZGV0YWlscyk6
DQogICogUGVybWFuZW50OiBTdGFuZGFyZHMgYWN0aW9uDQogICogUHJvdmlzaW9uYWw6IFNwZWNp
ZmljYXRpb24gcmVxdWlyZWQNCiAgKiBIaXN0b3JpY2FsOiBTcGVjaWZpY2F0aW9uIHJlcXVpcmVk
DQoqIEluaXRpYWwgcmVnaXN0cmF0aW9uczogU2VlIHRoZSBBcHBlbmRpeC4gSW5zdHJ1Y3Rpb25z
IG90aGVyIHRoYW4gdGhvc2UgbGlzdGVkDQogIGFzIGRlcHJlY2F0ZWQgYXJlIFBlcm1hbmVudC4g
QW55IGxpc3RlZCBhcyBkZXByZWNhdGVkIGFyZSBIaXN0b3JpY2FsLg0KDQo=

