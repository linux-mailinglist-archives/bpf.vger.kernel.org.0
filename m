Return-Path: <bpf+bounces-5096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCEC75668F
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 16:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A43B281397
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 14:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD0FAD52;
	Mon, 17 Jul 2023 14:37:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B35253A4;
	Mon, 17 Jul 2023 14:37:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67ED1E72;
	Mon, 17 Jul 2023 07:37:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehtR0RjXpZmsCZQy4fkJBdXen1bc9Xo9o6+Rzw0jEQxmyEGoX2x+mFMmX/hZKklSxwPTFIO4a1hPTZickPXBBD1K5VZbvNdbu32PMXyWEFEkx1y2qtZ7okTvk0OFy/QlsvSB9FuWpnGZnzb7Bbgcf68IDowZ5kc1DUa+f/brwR7A1cC2y5laBO8rdHd09Dsdy6NF+siCkLS/nmjuLkxW8tXAedlHHUd/+8+3meX/q1DfHdh0lcSiMElfqbUP5npcTfMOZR3kLfIDt0cS/uY8ZSCwyk4v2dswZARj/b30wFbTVGmojLHeUf9JsG8Zu8YfSwsqSnMxRupoWJvOM5OgkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBa/hlzINfylb88M3nBZuoaA9MH4aJfUe3FAJ0S/GjA=;
 b=WRa0MSKIzz44b7S7zcV6QMSjTZfrY3m10O1WomObJ3GKT3bLhSH6Gjkjw94YJRJGQGlro8VUhgIojlTZ6R3ibENNtxnBe2Wv/MVeARLjzhbUQDQ5dWkEEKNe7yo9nqhM6Ch5SANQOQj9pHXpBhBB2D/0D/IHT0Zmmw+83aOVIgG71hCkcjjmNwPbFtQIrxM+S7jBNxLzTIzm1EedsYpwl24813CjLi79zS/ZpnQAmiKc6WyKumUHDqCBjFu3agWt4FXvD0mBUnwJ3Vqee80w0TtEzD5dEFALOlZUxMZv2B0hDosp0adc3q6VnZN+PtVJkCqzaDNdDzRwwYCm93l95Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBa/hlzINfylb88M3nBZuoaA9MH4aJfUe3FAJ0S/GjA=;
 b=YSYC2z7jFPpeEC2uH6qSmCiQVlHY9WvjSKSGWf2lk2L3HKyBcQd6iy5eVgb0d6ZXUMsYaeEPRbGR1sEp2yGr4lHZG4ezYvYtMA9zDF3DvtKnW+UN+Ny0v3jw21U2gvsjQ/QQw1hrjMIHfBU1+spKdZOKo8PuG/8RPitrkV8QbZSB5iGg9Babcp9CnRRq1YB203DxHkkjgbgLvzZr4j3kA1aWNFig55PHFP6tTADF3fMfSpg9zDQxsa0jUmQE1bwkNspUlXnsaln4r0OJYbTYM+DTnLiGHTXg/ZSv6+BOwAonkxGU5Jdk8651gr7MzQF3BJLyrMSGtt4hx3tXu50VOg==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 14:37:44 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::e9ca:72a9:17b1:f859]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::e9ca:72a9:17b1:f859%3]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 14:37:44 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jbrouer@redhat.com" <jbrouer@redhat.com>
CC: "atzin@redhat.com" <atzin@redhat.com>, "linyunsheng@huawei.com"
	<linyunsheng@huawei.com>, "saeed@kernel.org" <saeed@kernel.org>,
	"ttoukan.linux@gmail.com" <ttoukan.linux@gmail.com>, "maxtram95@gmail.com"
	<maxtram95@gmail.com>, "kheib@redhat.com" <kheib@redhat.com>,
	"brouer@redhat.com" <brouer@redhat.com>, "jbenc@redhat.com"
	<jbenc@redhat.com>, "alexander.duyck@gmail.com" <alexander.duyck@gmail.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ilias.apalodimas@linaro.org"
	<ilias.apalodimas@linaro.org>, Tariq Toukan <tariqt@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "fmaurer@redhat.com"
	<fmaurer@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, "mkabat@redhat.com"
	<mkabat@redhat.com>, "lorenzo@kernel.org" <lorenzo@kernel.org>
Subject: Re: mlx5 XDP redirect leaking memory on kernel 6.3
Thread-Topic: mlx5 XDP redirect leaking memory on kernel 6.3
Thread-Index:
 AQHZjY743nR7ST598kifD6Q1M3DiL69oDfyAgE+tU4CAAA45gIAAUDMAgAAJPICABjpogA==
Date: Mon, 17 Jul 2023 14:37:44 +0000
Message-ID: <32726772de5996305d0cfd4b6948933c47cb7927.camel@nvidia.com>
References: <d862a131-5e31-bd26-84f7-fd8764ca9d48@redhat.com>
	 <00ca7beb7fe054a3ba1a36c61c1e3b1314369f11.camel@nvidia.com>
	 <6d47e22e-f128-ec8f-bbdc-c030483a8783@redhat.com>
	 <cc918a244723bffe17f528fc1b9a82c0808a22be.camel@nvidia.com>
	 <324a5a08-3053-6ab6-d47e-7413d9f2f443@redhat.com>
	 <2023071357-unscrew-customary-fbae@gregkh>
In-Reply-To: <2023071357-unscrew-customary-fbae@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|LV2PR12MB5869:EE_
x-ms-office365-filtering-correlation-id: cf63f39b-5d7a-4bcf-f3d9-08db86d361f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 d+mhhcUCjLRbypNgrCB/Q1UgRBCddXfb7ySzTyU5efr2/eSR94rsdZf3zgEaQTyHyEB14x+1kLXQ8uksQfpwjrgbJJIZtcEEH6ZNkLdLj5EKTkBS1GvyU/foKjF9HLyIVQOm7TSCLbgMNxg0RdTppvzEr6tOi03+2dTrcaq/5dkpOnGSYcwLQOXU0DHVBTMZMipTZ43JOyvoNiew4ov1CJBMc1whg2KWXRzqnjr2s3i/kNAxITvY5MjVbx18x5ouW7ofgzCUKlCipnPBGt7kbULN95bd1Pe4wyRLb0AlsUkLvLdz5wTB794HFrR+7Sa5kvLFCHb9OfsmCTBnTdibM5JXDRh5fZ1hXO7d/Ntx7DlOFwrYRgwq0nnsrgi2BbMcSrBwcx7R8XIt5Zac6j3B83USAcAAHPWxoo/oayO0CMJmX+0iCXxBPZ4SdjQv5E1eIv0loD0oTUutC/RKs91419fhkbXxq8FFfpkd+QhvIT4EOcDMvhhPBbVYVpne5EG5/5TCG1P26z4CQcjtEyj9Ivcmm6HTm72Lc5bWwMd0jVytIuZy/E5KE0Xqnaq+qJvyQufuUk2itLYzTFLJFWMcqkhPyclxF9hqvbjCupc8FALirSB7aJZvC9Yf7pIZj/wQ0NO+jaXo9+5mNjQjoCX6W1iXQP86vEKM/KT5T4mOC8j6ELDGYaOCKbgMuep8iINs
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199021)(478600001)(71200400001)(6486002)(54906003)(91956017)(110136005)(2616005)(38070700005)(86362001)(2906002)(76116006)(186003)(6506007)(36756003)(966005)(6512007)(66556008)(38100700002)(122000001)(4326008)(66946007)(66446008)(66476007)(41300700001)(64756008)(5660300002)(316002)(8936002)(7416002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MkxqMVBJN2pXN3ZTN2R0eUh6ZWtCMm81UitLRUszZFFGdmM1cjJ3RkN5Y3ow?=
 =?utf-8?B?bStoT3ZxUzVLY2hMb3FjaHQ0OWc0aWVRdHF2cjlrYmh5N2ZCY0RpSDFTRXZ4?=
 =?utf-8?B?ZDdRVkVQOCtURXpXSkRSK1dodG9lcTNTZjNlMGhrQUc5a0s3aEJnb0N6WUo0?=
 =?utf-8?B?OFZpM0FYcWQ1ZXVlWVZ3RStHRjNEcEthWFRoU1lIRnhKSklLdlBZQjJmbU1Z?=
 =?utf-8?B?bUNidnF1Y0JqNkhERUhpaFMvR1Rka1ZKWGhNN0htWVA2VmpsMkQxNDFidWRL?=
 =?utf-8?B?T1ZqdjJXM3h6ajVnWVJwTXY5U1BlelBUekpNK3prcjZTV2VkMEFKRTVweVNY?=
 =?utf-8?B?c1pPeGloWmQ4YkdaZFFpc3ByVGJjMDByNzMzVDF3blViOWx6TFp3ZW45RTk1?=
 =?utf-8?B?RE1FUGw0NDJaVWhDL0ZSSjYzRHFIUENtZUgvZmJ5V0VwZk1BaUgwb1pmZWgz?=
 =?utf-8?B?eEx3YzV5Zit6VXh2QWs0OSt1aTBWNThKMUc4NGlsUDFSdGphTnU1WHlmOXhY?=
 =?utf-8?B?OXZNMVVTTG5lQ2pOSG9BR3o0SGhrK3F2b3JsVHJiYkxsY1RVUDZhS1V6a0NB?=
 =?utf-8?B?QXBTSWRSOVdhVC9RZEVzRk5BZzJRNFREcmpLcFFvY09lekE1emYya3VXNnVV?=
 =?utf-8?B?dEZjdHVvZG0xakVQb0ZTU3pXMFc3OXU0SkhZcTlyQ0crWWlWOFVoU0V0NzVl?=
 =?utf-8?B?QjRKaUZ2R0hjaUd2Mm81Wk5veXNlZnNLdUpjN0o5VHE4dDZVa0RxSkZnY2x6?=
 =?utf-8?B?b1cwYUU0bkdieHFDcy9OMThieGd6dFI5Z1VLTnpNUS8yWWlRZkhnYVY1SFZU?=
 =?utf-8?B?amdneFVMcjNydVdDOUdNam12UFptclZjU2NIMWU3aWdBNE5Oa0UyUUNTbmFm?=
 =?utf-8?B?WEhZZEJwUklra1Z5N0Z6YzNPUjJHQzZjc2hzcHI3MzJGTXBJaTNVclgwalRE?=
 =?utf-8?B?djJzQ1d2cTZ3V2N1dEM4cWZwZGVleFpLR0tDeHc1MHlmcjFDNEhvY0lnbUF3?=
 =?utf-8?B?bkpTdWEzd1dzYTBoblpyKzZvKzBxaFNuY2V4R1FiMldvQzJ4UzhHZ1NGQ0xG?=
 =?utf-8?B?VEltOG1xc1hJTG1RUUJnc2dudElKNzBDaXdYWld0YjJBQTdreDBuR1NXUzJY?=
 =?utf-8?B?Z05aajZEa1dKaWhnMHlZSnNGWU8yMVl5SEFEcGdaWTZ2TFRKOXU1cjhVZGRN?=
 =?utf-8?B?eTY1VzdzampnRklFT29MdENsM1hJMHhFdE5zUDFDK3JIYzNUWmhhRlFMVmtj?=
 =?utf-8?B?QytNeUJZQXdlVXY2dDl5UDFwN09TMW5OcmdSNjFuNnExaHZ0VHB1dHRoSXcz?=
 =?utf-8?B?N002TDl2NnJFS0hDOGZDYnZZK1Z0d2dRQlBST0V1c2JQQmdhc1NsKzVxSDRu?=
 =?utf-8?B?R09rSUYxZG9BK0orc0YrUWFsbHZNRE5LSzRiemxiVzh1VmJKUy9UVDA0b3dZ?=
 =?utf-8?B?TTQ4Q0U5L3hzZ25IUzR1Vi9wUitNT1R5ZGlzYTZhclM5aXFlZUtoeFJPaGoz?=
 =?utf-8?B?OGJmQTJJWFhUbzdVaXI5TkF6aWh1ODVSY2RTSXk1NGpFQTdIR0JSNVFnU0o1?=
 =?utf-8?B?cEpoR2FVTWVxSFhaWndoQWV6YkJPQSs3TjZvNWlKdTNhaDYvMzVPZnErMU84?=
 =?utf-8?B?NjVnZjVWaHB1T011bzd1V3lmZDVxd05FYWthWDcrK3JFSlhCQnhRMTl2ZTY0?=
 =?utf-8?B?NDdXRkthTzFvT1FZeFhxenVHVjVKelZmUzR5Y2pLMGcraGIwOE9BY0s4SVJw?=
 =?utf-8?B?VnpwMXlVdnNhUVpjVy9ta2hSV1F1N0thQW1seDlsSStrMlFoMU5VVkxwVzk4?=
 =?utf-8?B?K0Z3eFZkaU5QVWlBTm5kMXNGbE1QMGd4SUZqWmNUemZwNDkySVY4eVdiRkh4?=
 =?utf-8?B?S1dWQ1hvckU1NHB4ZFRRcTFka3BuTEZLeERvTk9vSHF6aGtHQ2FvUkhBcDJB?=
 =?utf-8?B?aHpxakt1QUh5K1kya0l0Wjg3d0RvSmFremdxUm44RDc3MDA2c2dId1hKem8x?=
 =?utf-8?B?OTJKNXhvMzNxWXhxUU5hWUdwV1h1c2VKZDN0encyL1VkREhlZ0FHZGxrQWdU?=
 =?utf-8?B?NURaaWpIWVR5aEsyRXNLRTA1SHFmVldkTXRERTYyY3N0dkVNN2w3MEFyWmJw?=
 =?utf-8?B?MEpabnJzUno3czFzdlIvTHE5VGVtckhBRmQ4bVlpY3Zwb3c1MGE2Q0x0Y3lm?=
 =?utf-8?Q?zS5Vjrf3n47OsgMhuJEqFzydRxZBFpV3gFFRuxhUvLm+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AAF16E669C1D7045B78B829ECB002935@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cf63f39b-5d7a-4bcf-f3d9-08db86d361f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2023 14:37:44.2643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QrFKZ+SOQr97Ok9yCkO82xtXqF0xaMJPDTJUmx+/rY62DpPOT0uCxk3gTmSlEVnNvT9bZZWeKYMrXcy19LlPjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5869
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gVGh1LCAyMDIzLTA3LTEzIGF0IDE3OjMxICswMjAwLCBHcmVnIEtIIHdyb3RlOg0KPiBPbiBU
aHUsIEp1bCAxMywgMjAyMyBhdCAwNDo1ODowNFBNICswMjAwLCBKZXNwZXIgRGFuZ2FhcmQgQnJv
dWVyIHdyb3RlOg0KPiA+IA0KPiA+IA0KPiA+IE9uIDEzLzA3LzIwMjMgMTIuMTEsIERyYWdvcyBU
YXR1bGVhIHdyb3RlOg0KPiA+ID4gR2kgSmVzcGVyLA0KPiA+ID4gT24gVGh1LCAyMDIzLTA3LTEz
IGF0IDExOjIwICswMjAwLCBKZXNwZXIgRGFuZ2FhcmQgQnJvdWVyIHdyb3RlOg0KPiA+ID4gPiBI
aSBEcmFnb3MsDQo+ID4gPiA+IA0KPiA+ID4gPiBCZWxvdyB5b3UgcHJvbWlzZWQgdG8gd29yayBv
biBhIGZpeCBmb3IgWERQIHJlZGlyZWN0IG1lbW9yeSBsZWFrLi4uDQo+ID4gPiA+IFdoYXQgaXMg
dGhlIHN0YXR1cz8NCj4gPiA+ID4gDQo+ID4gPiBUaGUgZml4IGdvdCBtZXJnZWQgaW50byBuZXQg
YSB3ZWVrIGFnbzoNCj4gPiA+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L25ldGRldi9uZXQuZ2l0L2NvbW1pdC9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxs
YW5veC9tbHg1L2NvcmU/aWQ9N2FiZDk1NWE1OGZiMGZjZDRlNzU2ZmEyMDY1YzAzYWU0ODhmY2Zh
Nw0KPiA+ID4gDQo+ID4gPiBKdXN0IGZvcmdvdCB0byBmb2xsb3cgdXAgb24gdGhpcyB0aHJlYWQu
IFNvcnJ5IGFib3V0IHRoYXQuLi4NCj4gPiA+IA0KPiA+IA0KPiA+IEdvb2QgdG8gc2VlIGl0IGJl
aW5nIGZpeGVkIGluIG5ldC5naXQgY29tbWl0Og0KPiA+IMKgN2FiZDk1NWE1OGZiICgibmV0L21s
eDVlOiBSWCwgRml4IHBhZ2VfcG9vbCBwYWdlIGZyYWdtZW50IHRyYWNraW5nIGZvcg0KPiA+IFhE
UCIpDQo+ID4gDQo+ID4gVGhpcyBuZWVkIHRvIGJlIGJhY2twb3J0ZWQgaW50byBzdGFibGUgdHJl
ZSA2LjMsIGJ1dCBJIGNhbiBzZWUgNi4zLjEzIGlzDQo+ID4gbWFya2VkIEVPTCAoRW5kLW9mLUxp
ZmUpLg0KPiA+IENhbiB3ZSBzdGlsbCBnZXQgdGhpcyBmaXggYXBwbGllZD8gKENjLiBHcmVnS0gp
DQo+IA0KPiA8Zm9ybWxldHRlcj4NCj4gDQo+IFRoaXMgaXMgbm90IHRoZSBjb3JyZWN0IHdheSB0
byBzdWJtaXQgcGF0Y2hlcyBmb3IgaW5jbHVzaW9uIGluIHRoZQ0KPiBzdGFibGUga2VybmVsIHRy
ZWUuwqAgUGxlYXNlIHJlYWQ6DQo+IMKgwqDCoCBodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9o
dG1sL2xhdGVzdC9wcm9jZXNzL3N0YWJsZS1rZXJuZWwtcnVsZXMuaHRtbA0KPiBmb3IgaG93IHRv
IGRvIHRoaXMgcHJvcGVybHkuDQo+IA0KPiA8L2Zvcm1sZXR0ZXI+DQpTby4uLkkgYW0gYSBiaXQg
Y29uZnVzZWQ6IHNob3VsZCBJIHNlbmQgdGhlIHBhdGNoIHRvIHN0YWJsZSBmb3IgNi4xMyBhY2Nv
cmRpbmcNCnRvIHRoZSBzdGFibGUgc3VibWlzc2lvbiBydWxlcyBvciBpcyBpdCB0b28gbGF0ZT8N
Cg0KVGhhbmtzLA0KRHJhZ29zDQo=

