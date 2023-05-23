Return-Path: <bpf+bounces-1121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBF970E49C
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 20:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBDDE1C20DBA
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 18:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70FB21CDD;
	Tue, 23 May 2023 18:25:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC2F2098A
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 18:25:41 +0000 (UTC)
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021016.outbound.protection.outlook.com [52.101.57.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD4191
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 11:25:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRr3PuAAqqyF5WTiOnB6mv2tM3WiWKLH5X2NRW/fKDSJtIW4sSXZrEVpVcfyjDB568Ay8brHqEyMhnHzjS65sWAJSKd+PAob+es13kvbztTw8/OI6gZvBzj2o8rMLHclJhXNGlQ74RBF64cNT5manBcj0/ThEFyFDdEjD5nFiGy/+vdYqXxbyyqP18Y6EMFijjCfmDwPIeEH/IGMZ5e6o6N2iJRZZRAIyMyy8mDIDGgoHaszJeB9VblH4NB/Wzb3jujUfxqyNLnifqHYNV0UNbZhD8y9VNV0MTGL9pwGgo+JO8X9MPAZZ0eZH68HmcsDRivuqIMvXDpXjXbjOwCBzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuAsRqS12LZGc/PDmlepaSwOeqXHwJXCcsIu5IrbSo4=;
 b=LIBeg7f+tlRwnuY/IhHDPthKFN4lX65FNDGo1lGrOycAjfa9wRQfMkMW8mQF3zwCL8lvAyNfGQHQLpaWX83H1V67zXAwdIZfcfNRMTmV813uKJOfmOesKUYgzMl7CcXc+kfEYq5WgDMK/6So6ca5UWBiLG43nZaKYVlYVjxkV8U6Mw9j6gJE13FegcBqiLNlZorlbnWSJBgm9xFI2GJK3bN32gJCjQCvEttdQKFwfhGu8FaqILcteOdx9MNUo6rdj0+mdSE4DUWXvSAusnvAMmttJLl61yW2kvJXCy6VatzonRdEWTz3EOkNj/gU8ewUvBhvQiG62hARYod2cvRw2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuAsRqS12LZGc/PDmlepaSwOeqXHwJXCcsIu5IrbSo4=;
 b=XyNSMcsVFWzzhfK51f2bSz8ubnU9lbqd6nzlUIwbEOyTZ3PaVIKXJvz05dzwo1pIQPB4FdqPgkG5VKVydGLse/jn1HWMbOxslVywYO43skSObmKybdxQaQtp6be2i/G1m6ns33bc8bgSZNgyHtod5AK6UhiKbxxtR5YXZA52UFQ=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by DS0PR21MB3950.namprd21.prod.outlook.com (2603:10b6:8:116::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.6; Tue, 23 May
 2023 18:25:18 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::b892:e1d5:71ec:8149]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::b892:e1d5:71ec:8149%4]) with mapi id 15.20.6433.013; Tue, 23 May 2023
 18:25:17 +0000
From: Dave Thaler <dthaler@microsoft.com>
To: Michael Richardson <mcr+ietf@sandelman.ca>, "bpf@ietf.org" <bpf@ietf.org>,
	bpf <bpf@vger.kernel.org>
Subject: RE: [Bpf] IETF BPF working group draft charter
Thread-Topic: [Bpf] IETF BPF working group draft charter
Thread-Index:
 AdmIWSmp8uIYgrASRIKQXfLbLZQgdgAeO2knAAYWUOAAMSGf+AAD196wAPVwpgAAAwOVAAAA5HRA
Date: Tue, 23 May 2023 18:25:17 +0000
Message-ID:
 <PH7PR21MB3878D5DC4D0621C28011BF18A340A@PH7PR21MB3878.namprd21.prod.outlook.com>
References:
 <PH7PR21MB38780769D482CC5F83768D3CA37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87v8grkn67.fsf@gnu.org>
 <PH7PR21MB3878BCFA99C1585203982670A37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87r0rdy26o.fsf@gnu.org>
 <PH7PR21MB3878B869D69FD35FA718AF5DA37FA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230523163200.GD20100@maniforge> <18272.1684864698@localhost>
In-Reply-To: <18272.1684864698@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=febdaea1-89f9-4fa8-8599-540b53ed10df;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-23T18:23:51Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|DS0PR21MB3950:EE_
x-ms-office365-filtering-correlation-id: e81ba3b5-119a-4fd8-3420-08db5bbb0f51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tAVGoCh4IjFNjzP8rIFbnezIk/abFLMVWci+YM7lNeJxuFSaPtwVD9ns7eF85HS5F5Xh6YGx0cp9onJ47Ji+Rth0vSeGaAxRaAJ4h2XhpsCnrQgumxIugLWH01HBe58S7DMJ8tlHrcrZzSrOsqMijqE5IUzRlJ89vE+Y/Wy7rEBODcHQG0WaLs9357PpuCbSu4zc9UJlQ8jJM/g9ZIiOV6nplS/3KXh7CYvogRCRjixHiuVw/nXuoX6q7/0jCY1v4jKlqvxREh32jnqwyY4vCN40pB4yOOUsMsb7eaofAErA9ZY1loqE4lehpZNcZlsQIB5tBUdSHqwaJ6iTiCtDhBcjz8nkhFYQT4+l3sKFyiOSG86Uz3JPEWcEC7dNmw+SKiwRkb/0OgjGhTVaasfbvmqw4Kl3K42K1Q57BobYvosTWPcYw+16cnb44DI6Md4QqEQOmzQCvdZbYoc2ku+dIj0AsAEX7fD9nIbNE8szSAXUf97ceP0QBprBrAibih9Fh5umoq2/0Usyi2QKMU3NJ09vbUJSFjLKWbrTy3lNSgyBPihP5na3dAIYj59HwIC0EfU9EM84+FbQnExMnY5zxlydPFrof6VmHPkzuTOcUDR+VUVLmLfwJ/NjiDvthMANV4Mw0en9DgpzI/PSXEFy5JudnZKRVKsnYNrLi7R9C6M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199021)(786003)(10290500003)(478600001)(9686003)(26005)(6506007)(53546011)(110136005)(316002)(71200400001)(41300700001)(76116006)(66556008)(66446008)(66476007)(64756008)(7696005)(66946007)(8936002)(8676002)(52536014)(5660300002)(86362001)(55016003)(2906002)(4744005)(83380400001)(33656002)(66574015)(122000001)(38100700002)(38070700005)(82950400001)(186003)(8990500004)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z2doelBPMUY2UGVXaURRUS9FSDd0cXFYc21pWjRRc3dGSmI2dzJZY1pYZE5w?=
 =?utf-8?B?am9hTGJVdUd0RWZzQWNtQ3hMZWFtenR3QU40WE41RGo5NGtjbGROM2l3UkND?=
 =?utf-8?B?aGNxSVg5NEpORTVjTStWaTNCbVdzVWFIZEFLUUZzQmVSMmNYcU5KMWNtVmp2?=
 =?utf-8?B?dDRjSGtGK0g1UmVRWVhDaGtzSDhMY09GRi9kLzNTL0FlMkgyTmpJY3FqTEsx?=
 =?utf-8?B?bkVBNm9GUUw1UjVnaGsvL25ac2luNmluWTVQd092eVJDSXV3YWJzTGh3TGdQ?=
 =?utf-8?B?bm5ONXYrWTFtVlprODltby8rWkRrN0o3anQvdTVESjZoQnBzTWxNZ3NsZFRD?=
 =?utf-8?B?NGZBZmc2UXhocTVlSFZEbTdWd0l0WENzQlVzMmhwODMvNTFJOXhQZzR1Q0dQ?=
 =?utf-8?B?QVBEYVVGNjAyNURVVTlLUHFickdOc1RhL3VHT3NhOVREK2VpVy81QXlwUlJ3?=
 =?utf-8?B?NU9XaW9yYlkvVXlZME5kR0dUUW5wTG5jT1o5QU5yVlR2WktoS3VobllUZ0pK?=
 =?utf-8?B?OXlPR05QRjBLY21UeGF0K3ZZWStaSEYydnpHQ3RLa25rK3d4TDlPdTlOaldR?=
 =?utf-8?B?NGwyN0NlbmxlVlhLQno5aHFLY0pkdm1xcXVsRnA0YkhsTDhLOVRPTnc5TUxF?=
 =?utf-8?B?dHozQ1V6d0ZtQTc0R3lWMm4yL3AzaGlRN1J0akp6NHJMSXZvNm0rK2FubGov?=
 =?utf-8?B?TWRGTUZPa0pRSk9NUDVaZy94aVM0U3FqdStLQlpCbzZFd3JxRmNQOUdRS0tZ?=
 =?utf-8?B?bWMvUzR5VVZsZU1EL0NMelBpVENyMWRlMy92OUhTaDh2RGFndzdRcjg4SDRG?=
 =?utf-8?B?WkdWMzZYUTJaMUNWNTl3aU80anQrL2ZTYXJXYXFmRmlrUkd3SGpXbG82S1Rr?=
 =?utf-8?B?cG54eEZpOGo4WFdpNmRqSnpmN2xiMDB3QTNVcnFhcDg5REpqckpHMk4yZnpr?=
 =?utf-8?B?OGtpZTcvWWNLN2tUZ1F3QkplbGpiVTF3WnB5M0ZFYnNsdUpYZzUwTkRIQi84?=
 =?utf-8?B?OWhnRndueU9nMlF5YUVZeEZmczVnbDVBcFhFdWFkUmVzdmRLaVM4ekZua1J5?=
 =?utf-8?B?ZFR3OWg0a3kyQngrak9IbE5wNDltQ3NMRXJIeFkvbUlpNGczSXBoYWcrL3Zj?=
 =?utf-8?B?bTZxN0pGa0VPT04ySkx3ME56VllYaW8rMEZpRkgyU3FYWjN6TFhjTXpGRGJN?=
 =?utf-8?B?SnVOT3dyR1R2V2R4eG4wZUQvWGROQ1IyV3F2djBReEN0TWlOWlF4NG9sem1j?=
 =?utf-8?B?aU9BcDZLZnhkdzA2UkFnSVRxbzFXaldySGpVZ1d4R0Y2Yktqb0hlT2lSUXRD?=
 =?utf-8?B?enpvTDhKU2R1VHZ4ZUo3NEFwSVduczFudGZOUGphTlZxa2RaVTk4dWtvbmlt?=
 =?utf-8?B?QzJEMitneVZPYnFXY1BtS1QwUHhMaUhwM1RrTEpLM25PYk1TSldQSXd0OHF5?=
 =?utf-8?B?Z3N6ZVR4bVdTYlU2ZFpZNTZ0Mmh5NVRISDZ1VlRiOWMxM1dnNlVIcENCQnhK?=
 =?utf-8?B?QlVUdkV1bGVJOXB5Wk5sUFJEalBERWRLS1ZyeUdHQm8vTEEyV1VFbC9mYlc2?=
 =?utf-8?B?dWdQS2FJTE5iNk9jbE9BUEhTQUc2aGsrTDE2MlIyNGZlcG9jcVc4YWh4d0NE?=
 =?utf-8?B?cXZiLzhIMVpjcE5wcWNqZ3UzQ1lGZ1czTm1tcm9Jb3dQUW5DNlRjK1RoeEtJ?=
 =?utf-8?B?VWMvTHg3Vkl4SDBZMTdHQ25GUEx4SWtXQUJ4bUJQdmVlMTl3QitUVHFSbFN6?=
 =?utf-8?B?TjJ3UWhrQXl6QVhaUGxiTlJ2Rk5KZEVUUThzajhZMllxSEExaG5XQUN5ZUtl?=
 =?utf-8?B?eWdsL1h0UTJwd1czZVNVZ3ZhUmp5Wm9NOGJHK0R3c1R5aWZ1UDQ4cnJNUVdj?=
 =?utf-8?B?RWdLblFEbXF3NUJ6aEhYTHZJOEdkQ0dqUEQ1d2ZFNXZXVFV4TUxDWkkrZmpW?=
 =?utf-8?B?NmRqdmg4U3ZoMnRrS1R3bFY4TUE1aXJUMEdVOXBOR0NzcnVQVXVKOVRnTzBX?=
 =?utf-8?B?d3M3WDdYWm42KzQ4dytxV2hUMGhURnI0VmNtWXExZVVaeElFakdpT1BkL0VX?=
 =?utf-8?B?R25MUnQ4YnN2bC9MTUE4ZytQK0d5a1NxQUxreWwzbmRxS2xBaFJhK2dDbUYr?=
 =?utf-8?B?a2xiZ1gzb2tSRmp5MThUN2QzSHlaQzlGaTBna1RMdm9YZFRBSjliNmZpcXND?=
 =?utf-8?B?RkE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e81ba3b5-119a-4fd8-3420-08db5bbb0f51
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 18:25:17.6554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IqsOlqYnU1JkpxPseCWvpQfvOVRO0IW43pbYTO30OdYBrfZhMCA6e0lxMdzX5jS+PYZWXq+nHyqZqczjs30wQ2p00sDZOCFWLu1VEOVuii0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR21MB3950
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T25lIHBvc3NpYmlsaXR5IHdoaWNoIGlzIHVudXN1YWwgYnV0IGhhcyBiZWVuIGRvbmUgaW4gc29t
ZSBjYXNlcyBpcw0KdG8gaGF2ZSBhbiBJbmZvcm1hdGlvbmFsIFJGQyBmb3Igc29tZXRoaW5nIHRo
YXQgaXMgbGF0ZXIgc3RhbmRhcmRpemVkDQpieSBhbm90aGVyIGJvZHkuICAoUkZDIDM2NzggaXMg
b25lIG9mIGEgY291cGxlIG9mIHN1Y2ggZXhhbXBsZXMuKQ0KDQpEYXZlDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQnBmIDxicGYtYm91bmNlc0BpZXRmLm9yZz4gT24g
QmVoYWxmIE9mIE1pY2hhZWwgUmljaGFyZHNvbg0KPiBTZW50OiBUdWVzZGF5LCBNYXkgMjMsIDIw
MjMgMTA6NTggQU0NCj4gVG86IGJwZkBpZXRmLm9yZzsgYnBmIDxicGZAdmdlci5rZXJuZWwub3Jn
Pg0KPiBTdWJqZWN0OiBSZTogW0JwZl0gSUVURiBCUEYgd29ya2luZyBncm91cCBkcmFmdCBjaGFy
dGVyDQo+IA0KPiANCj4gRGF2aWQgVmVybmV0IDx2b2lkQG1hbmlmYXVsdC5jb20+IHdyb3RlOg0K
PiAgICAgPiBBcyBmYXIgYXMgSSBrbm93IChwbGVhc2UgY29ycmVjdCBtZSBpZiBJJ20gd3Jvbmcp
LCB0aGVyZSBpc24ndCByZWFsbHkgYQ0KPiAgICAgPiBwcmVjZWRlbmNlIGZvciBzdGFuZGFyZGl6
aW5nIEFCSXMgbGlrZSB0aGlzLiBGb3IgZXhhbXBsZSwgeDg2IGNhbGxpbmcNCj4gDQo+IEFsbCBv
ZiB0aGUgZUJQRiB3b3JrIHNlZW1zIHVucHJlY2VkZW50ZWQuDQo+IEkgZG9uJ3Qgc2VlIGhhdmlu
ZyB0aGlzIGluIHRoZSBjaGFydGVyIGlzIGEgcHJvYmxlbS4NCj4gDQo+IFdlIG1heSBmYWlsIHRv
IGdldCBjb25zZW5zdXMgb24gaXQsIGFuZCBub3QgbWFrZSBhIG1pbGVzdG9uZSwgYnV0IEkgZG9u
J3Qgc2VlIGENCj4gcmVhc29uIG5vdCB0byBiZSBhbGxvd2VkIHRvIHRhbGsgYWJvdXQgdGhpcy4N
Cj4gKGFuZCBtYXliZSBpbiB0aGUgZW5kLCBpdCdzIGEgbm8tb3ApDQo+IA0KPiAtLQ0KPiBNaWNo
YWVsIFJpY2hhcmRzb24gPG1jcitJRVRGQHNhbmRlbG1hbi5jYT4gICAuIG8gTyAoIElQdjYgScO4
VCBjb25zdWx0aW5nICkNCj4gICAgICAgICAgICBTYW5kZWxtYW4gU29mdHdhcmUgV29ya3MgSW5j
LCBPdHRhd2EgYW5kIFdvcmxkd2lkZQ0KPiANCj4gDQo+IA0KDQo=

