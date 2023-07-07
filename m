Return-Path: <bpf+bounces-4490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65ACB74B790
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 22:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B583A2810A2
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 20:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D392B17725;
	Fri,  7 Jul 2023 20:01:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CDB23C7
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 20:01:52 +0000 (UTC)
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021020.outbound.protection.outlook.com [52.101.57.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC677FE
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 13:01:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltYyOv54eW9MFgsZnGclFKuUICw67vzizlX9oGbPs3gCULnuRLwG3zvP3CtKnlXs6Riw3wWTLekwo1TDW3CnXH58rdLHu/vRGjwDU5qu0eKFxBKn5Ny1LChwyYnYrjLakneZ687d5C12h6eB7NkJufhe7JMeRn+XkAf68ocLytixYyaIC558RJyIa54JNSv6oXK8+wADetlX31x3cuVWRWnPe8tSDYcA87JIwpHkvUMoCJiLNKyOx6f6mxsVlcllDWDnk+Ytb+obrCBMuoG48aeFSS4vK1PerrwtVJwx3oJKM6d/XfmQ6EvC4hhD3LFsQ0o5hLC/+HhwmgKDJBzsYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBt/OlW+f6a7hc0xK8dtqTcr3zm51pYUuGa8qQ0G9rQ=;
 b=dTl7OUmzm/GeiuOKkq4FODB+bdEcqWl9N79pY/3eDR4JhFIRK7ncKaXAJspTDoGDwxCuenqOLkWfVJjGB++2uc5owBDPh9b+N3kWEMVXGum4DeXk+dZpj5Tj1j1Ivic3F1QKBZqs59UsAyuXqxZAy9QYc8uCnHVCZcKCehj/vx/mMndPEvqEvkLFD4/+FbLGvoc8VgGarbn0HJWaz1boVz4nCnoAZAqCv5/xGVF7YYS5xoZxB5XTNOwlTT3Hv8KsX81fQeZpyJ2YXKOKIUZiLOcmXjDbTfMh6/AJPBs0cv4qmfJs+4lhZzMbvsorWaKCmAgZC+DNWGNowQYf3SqD8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBt/OlW+f6a7hc0xK8dtqTcr3zm51pYUuGa8qQ0G9rQ=;
 b=X6BdVSjvWToy3s2WOBfEvx16IVYJj5p9Bv7xbG9yz4ROPH+HpHtqn9YyqK2jeRC79vtkx4NIMpyce2JTJ7Y8E8cELuE2/MsdnkKDM1sRQBmgIb1KLGsdICBn2Mjgj1q/HELwzHKtK5881Kjcj1OmVO1cZnXCfndqDeoBr9bJXsw=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by MN0PR21MB3484.namprd21.prod.outlook.com (2603:10b6:208:3d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.5; Fri, 7 Jul
 2023 20:01:47 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::8708:6828:fb9f:7bd5]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::8708:6828:fb9f:7bd5%4]) with mapi id 15.20.6544.010; Fri, 7 Jul 2023
 20:01:47 +0000
From: Dave Thaler <dthaler@microsoft.com>
To: Michael Richardson <mcr+ietf@sandelman.ca>, "bpf@ietf.org" <bpf@ietf.org>,
	bpf <bpf@vger.kernel.org>
Subject: RE: [Bpf] Instruction set extension policy
Thread-Topic: [Bpf] Instruction set extension policy
Thread-Index: AdmwKdCg+G2TzllJT+2ICM2r0nWi5AA0o6YAAAQp+2A=
Date: Fri, 7 Jul 2023 20:01:47 +0000
Message-ID:
 <PH7PR21MB3878059A1DDC86C7DC50F324A32DA@PH7PR21MB3878.namprd21.prod.outlook.com>
References:
 <PH7PR21MB387813A79D0094E47914C5A8A32CA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <23460.1688752596@localhost>
In-Reply-To: <23460.1688752596@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c2c5336e-2c45-42c0-a633-f6800a41e29f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-07T19:55:49Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|MN0PR21MB3484:EE_
x-ms-office365-filtering-correlation-id: 8b8b86d9-e984-42d8-4953-08db7f24fed8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 39E3ffjtoiTXswQ0xmEOVp/xQHgFN2Ar5UcawYN623whV8CICuw2mTXDb54ujthfFDT3k8xE7NtosFT2xZ1D5WfUDmqatRnfTbodTzkUHgOwp4VHckbaMtMSV+xxYn+izXP6+22t56ydgxIFL7jHhw66+ICN+VpKW1wDglYzRhYySt4cOjH6gtlspH/7hi6zi4v3LtJ+YXZAAl7JuunwhDQ1VgTzvZOQe9v7LMKDE6rs2KECEtbI3kr3CTZQQj/cIhI7yvzkN0OLS1oLlqvGRgSykUdQgxU8Ufx+v5+R+s8ZHBBEd/jpfhhajVftje5c/1wra3ymLaRKomCLfSzH+q9hin9MO+dXhYH91iH1Q2y+oYpitHBTQ9Iatqdny96JEHCiaO1uLxqije9ngSg/P5vt4nmqBDqkRsvFy+rDDimsA7LIA6DwK+r0e4tuCDE5tMnOOE7x/Wvb6WPDps0edzB/hdVqOEhH9eaVic2KJKcKb2Gj2q9+umbpEoOtcs9Ts8x4zHbc5C1iwBgaI3dNxNvIoRfQVm0cZ8lMfC+W4UG4J7HUUErS0F05lP+ShHxDX8bK7oiJPu33PwW0ZlPX7zYwyAiS8xUBfKn0+b8GfCdGYF5Ss65CRgXijIoyZ/1QOJhySm78B/ALp1l6yJfGd4u6h7cp9fcLvZuK8+6kVbE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(451199021)(33656002)(10290500003)(86362001)(7696005)(76116006)(316002)(110136005)(64756008)(66476007)(66556008)(66446008)(66946007)(478600001)(71200400001)(55016003)(5660300002)(2906002)(6506007)(122000001)(8676002)(8936002)(82950400001)(38100700002)(38070700005)(52536014)(82960400001)(41300700001)(8990500004)(9686003)(53546011)(186003)(26005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QkJWNlZFVDdmL054c0gxZFFjcjRRRVRLbGthbEN2SXZlVUFrL2F0YzBBblNa?=
 =?utf-8?B?STh3VzcxNTVyYzVqWDdLRDRxaFlRVERWZEVUTCtyMk54eE53OENEYU5hNEJK?=
 =?utf-8?B?SFNtODdmazNEc01GK0VKTDNQK0RGZkNuMUY3R1hGdndFc3RUVUNrTmVvSGtI?=
 =?utf-8?B?R0xnTU1RVG5TSzAxWjhWYkt0S2dYQ1VHa2hpbys3QzRUc1hSQnk3MUxCMi9S?=
 =?utf-8?B?eC8vendVYW9vSTd1Q2VnWjA5QWJZVGFEVFBCOVpGSitlQmVFdlBOZnpGSGJs?=
 =?utf-8?B?SGxjOFFEdjJUZmppWkxLNkxIQ2lIeG1RMXZFeW5obnRXK09Yc2VBL1NmUFNK?=
 =?utf-8?B?Q1lPcXVPeGQ5Wi9jUWlZVkVqT001WXFZYTBGcE5wQlNvdno1RFVtWHNSRVJz?=
 =?utf-8?B?bUU2dERPeitUSWFTY256TklOSEg5QktiM2J6aUs4cHBtcis0Qll6bFdOOTZ0?=
 =?utf-8?B?VWZ3Z2pIQzk0LzE3SzROOTQxUmgyUmxIeVROYklPWUlYWmtySHhkNVpaZ1Va?=
 =?utf-8?B?YWFoOEs1REVOQ3lySElrdDJrUFEzWmFsRnRwM0QvWjJoeU41YUxxb2VyYUVx?=
 =?utf-8?B?a1hNT2pQbXdyaDBPZGN2N1pFZFBpdkVqOFBOOEoydllKRmE1dWNHTnhpbzc5?=
 =?utf-8?B?YndQTzFvSFBmb2c5VDcyaXgyUXhwRVZIb2ZhRjcxSFhkZzF6a3ZSUXZkdmkr?=
 =?utf-8?B?dFZCMFlSazBhLzM3aEpKOEhFdUNYMC9jdlFCTyszZVdVL0V6N0lzN2hYNjBZ?=
 =?utf-8?B?M1lrdis4NXRXV3R2QXMxbis1YWl0SjAzNjA5RWtiZlhlRzkrMEVCalQyM2ll?=
 =?utf-8?B?TnZvS0tnVlJPaFFsSEJXQWJYdzlMeVh1QjZKWkZsRXR5REl6d3Y3QmRGU3Rs?=
 =?utf-8?B?aElqbFRhNEhLWGxPUm5idkRsWDduVnNCVnpGRGFUeFVXZDVaRzZRRkNYZlZn?=
 =?utf-8?B?bUJ0UjFCM0pEc1g1S1BTTFJKaGZnN3RHYVFNYkx2aHViWWM3SUZHSHhoTEor?=
 =?utf-8?B?VzNvc1RtcWtQdGhnbUlyRkRhYjZWN1QwWVYyS3lmR3hXR1NKVmtudmhxZnZi?=
 =?utf-8?B?bVVmaXo4N2dzUThxZ2k3V2JFSXR2OG9GTFQ0c2FjVkJJVk5lMnFCTDc4MmdG?=
 =?utf-8?B?YkRqM25PTnArWGJDOUJWTGFMdnAyZW1QMENad2JSWmJ4M3N0ZFJCUVF1clhG?=
 =?utf-8?B?QmRmYU9PUDBNNFRCSVBDWEtkNDJibFMwT2Y0V3JEcmh6Wlp2SkVrZm1zbk0z?=
 =?utf-8?B?djk3ZytaaTRrZE85eC9DUEtLU0pRTkJ0Ry9ocm10aGhROWRhV2V1bHNEdDF0?=
 =?utf-8?B?VlZ1dm5RdnJhZlE5Z0xXdXZaeGRrZVlDKzVjU0NFVlFqYnYwRGtTajBuU3NW?=
 =?utf-8?B?Y0ErQWEvTUVaYU1kZlg4eEE0M2xjMHl4UU5RcU9iR1EzT3p0c0FacHh6ZFVL?=
 =?utf-8?B?WlArZ1RNQVFOeEpyTFB5WE5qQXNKQWhYTzlDeWJzUklyaVJuWGdoUFhzckFn?=
 =?utf-8?B?Y3JqeWNaMjZtRm5Tb1FEa2JLTm5YM1ZTUFQySFlhRlIzRWpmNFloZ2JjSkZ4?=
 =?utf-8?B?bzlaZXdSU2RrcHgrSTc0YllSejc4VmFOcHM0RWdJR3RnS3Aza1E3WHBvVjhY?=
 =?utf-8?B?T3hIK2lnNm1NQ2dlWWxKQ1hncFpSM2dSL2RaVGFiSVUwYUJDdVczUCtlay9B?=
 =?utf-8?B?ckVhS01lTVNlWTd4Wkd1RUpKNDUxdTZXYWcramJmbUJBdlpDRFk5UldXeHVG?=
 =?utf-8?B?dG1XYVIvd0dIUGZzNkR2Z2RLaDJ6SnJXd1A1ZHpFN3FLM0FMWlRENGFoZVJ2?=
 =?utf-8?B?VUpjWWRmQzREVnFLeDRKb0FxUTFudndycG81OVZYdUJORGdpMjk5aWlRRXFx?=
 =?utf-8?B?cnVkQkJFREppUTVaaENqOTExTjFUblhtc0hvb2lHNEY0TTFtdGhEeWM0cEQ0?=
 =?utf-8?B?dlkzU0R0MHNzNmFkL1FVNlF5b29WYmpHTnJWS2hOOUNabjlnbE1BQzZ1V3A0?=
 =?utf-8?B?QlJHRnNWWjNnUzZjd3IvZ0djUWwzME5sNEVGTktXK0hyT041OWJFSGlxN2Ny?=
 =?utf-8?B?dXYwc1UralpsNHo5T21nT2VadExPTjdHTUNpQTlFT2pHU0VFQlF2ZmVVekpS?=
 =?utf-8?B?cWJVSTZDR3JzMmVTdDNBT1pUcTV4ekxRY3gyWWNRci9wNDVIVk5pbER1TFJR?=
 =?utf-8?B?dXc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8b86d9-e984-42d8-4953-08db7f24fed8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 20:01:47.3591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4QoZHbbBy1M/fr8Z8gQtl8VawMl/o+ZcRD4D9Y6nGBytuLpC/HYpIgQNBnIIppd7mXaVnF329u8IpfTcqogu9Mkn2V7LCvKbrKoei32i9mY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3484
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNoYWVsIFJpY2hhcmRzb24g
PG1jcitpZXRmQHNhbmRlbG1hbi5jYT4NCj4gU2VudDogRnJpZGF5LCBKdWx5IDcsIDIwMjMgMTA6
NTcgQU0NCj4gVG86IERhdmUgVGhhbGVyIDxkdGhhbGVyQG1pY3Jvc29mdC5jb20+OyBicGZAaWV0
Zi5vcmc7IGJwZg0KPiA8YnBmQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtCcGZd
IEluc3RydWN0aW9uIHNldCBleHRlbnNpb24gcG9saWN5DQo+IA0KPiBEYXZlIFRoYWxlciA8ZHRo
YWxlcj00MG1pY3Jvc29mdC5jb21AZG1hcmMuaWV0Zi5vcmc+IHdyb3RlOg0KPiAgICAgPiBPbmNl
IHRoZSBCUEYgSVNBIGlzIHB1Ymxpc2hlZCBpbiBhbiBSRkMsIHdlIGV4cGVjdCBtb3JlIGluc3Ry
dWN0aW9ucw0KPiAgICAgPiBtYXkgYmUgYWRkZWQgb3ZlciB0aW1lLiAgSXQgc2VlbXMgdW5kZXNp
cmFibGUgdG8gZGVsYXkgdXNlIHN1Y2gNCj4gICAgID4gYWRkaXRpb25zIHVudGlsIGFub3RoZXIg
UkZDIGNhbiBiZSBwdWJsaXNoZWQsIGFsdGhvdWdoIGhhdmluZyB0aGVtDQo+ICAgICA+IGFwcGVh
ciBpbiBhbiBSRkMgd291bGQgYmUgYSBnb29kIHRoaW5nIGluIG15IHZpZXcuDQo+IA0KPiBhZ3Jl
ZWQuDQo+IA0KPiAgICAgPiBQZXJzb25hbGx5LCBJIGVudmlzaW9uIHN1Y2ggYWRkaXRpb25zIHRv
IGFwcGVhciBpbiBhbiBSRkMgcGVyIGV4dGVuc2lvbg0KPiAgICAgPiAoaS5lLiwgc2V0IG9mIGFk
ZGl0aW9ucykgcmF0aGVyIHRoYW4gb2Jzb2xldGluZyB0aGUgb3JpZ2luYWwgSVNBIFJGQy4NCj4g
ICAgID4gU28gSSB3b3VsZCBwcm9wb3NlIHRoZSBhYmlsaXR5IHRvIHJlZmVyZW5jZSBhbm90aGVy
IGRvY3VtZW50IChlLmcuLCBvbmUNCj4gICAgID4gaW4gdGhlIExpbnV4IGtlcm5lbCB0cmVlKSBp
biB0aGUgbWVhbnRpbWUuDQo+IA0KPiBUaGF0IHNlZW1zIGxpa2UgYSByZWFsbHkgZ29vZCBwbGFu
Lg0KPiBUaGV5IHdvbid0IGhhdmUgdG8gYmUgbG9uZyBkb2N1bWVudHMgZWl0aGVyLg0KPiBJdCB3
b3VsZCBiZSBuaWNlIGlmIHRoZXJlIGNvdWxkIGJlIHN1ZmZpY2llbnQgdGVtcGxhdGUgc28gdGhh
dCB0aGV5IGRvbid0IG5lZWQNCj4gYSBsb3Qgb2YgY3Jvc3MtYXJlYSByZXZpZXcgdG8gcHVibGlz
aC4NCj4gDQo+IFRoZXJlIGlzIGFsc28gYSB0aG91Z2h0IHRoYXQgdGhlcmUgaXMgc2ltcGx5IGEg
InllYXJseSIgd3JhcCB1cCBvZiBhbGwNCj4gYWxsb2NhdGlvbnMuDQo+IA0KPiAgICAgPiBTaW1p
bGFybHksIEkgd291bGQgcHJvcG9zZSBhcyBhIHN0cmF3bWFuIHVzaW5nIGFuIElBTkEgcmVnaXN0
cnkgKGFzDQo+ICAgICA+IG1vc3QgSUVURiBzdGFuZGFyZHMgZG8pIHRoYXQgcmVxdWlyZXMgc2F5
IGFuIElFVEYgU3RhbmRhcmRzIFRyYWNrIFJGQw0KPiAgICAgPiBmb3IgIlBlcm1hbmVudCIgc3Rh
dHVzLCBhbmQgIlNwZWNpZmljYXRpb24gcmVxdWlyZWQiIChhIHB1YmxpYw0KPiAgICAgPiBzcGVj
aWZpY2F0aW9uIHJldmlld2VkIGJ5IGEgZGVzaWduYXRlZCBleHBlcnQpIGZvciAiUHJvdmlzaW9u
YWwiDQo+ICAgICA+IHJlZ2lzdHJhdGlvbnMuICBTbyB1cGRhdGluZyBhIGRvY3VtZW50IGluIHNh
eSB0aGUgTGludXgga2VybmVsIHRyZWUNCj4gICAgID4gd291bGQgYmUgc3VmZmljaWVudCBmb3Ig
UHJvdmlzaW9uYWwgcmVnaXN0cmF0aW9uLCBhbmQgdGhlIHN0YXR1cyBvZiBhbg0KPiAgICAgPiBp
bnN0cnVjdGlvbiB3b3VsZCBjaGFuZ2UgdG8gUGVybWFuZW50IG9uY2UgaXQgYXBwZWFycyBpbiBh
biBSRkMuDQo+IA0KPiAgICAgPiBUaG91Z2h0cz8NCj4gDQo+IEkgdGhpbmsgaXQgaW1wb3J0YW50
IHRvIGRpc3Rpbmd1aXNoIGZvciB0aGUgZ3JvdXAgYmV0d2Vlbg0KPiBleHBlcmltZW50YWwvcHJp
dmF0ZS11c2Ugc3BhY2UgYW5kIHByb3Zpc2lvbmFsLg0KDQpZZXMuICBSaWdodCBub3cgSSBkb24n
dCBzZWUgYSBuZWVkIHRvIGhhdmUgZXhwZXJpbWVudGFsL3ByaXZhdGUtdXNlIHNwYWNlLg0KSWYg
YW55b25lIGVsc2UgZG9lcywgcGxlYXNlIHNwZWFrIHVwLg0KDQo+IEkgZG9uJ3QgdGhpbmsgeW91
IHdhbnQgdG8gcmVudW1iZXIgYW4gaW5zdHJ1Y3Rpb24gd2hlbiBpdCBnb2VzIHRvIFBlcm1hbmVu
dA0KPiBzdGF0dXMuDQoNCkFncmVlLiAgQXMgd2l0aCB0aGUgVVJJIHNjaGVtZSByZWdpc3RyeSwg
dGhlIGFzc2lnbmVkIHZhbHVlcyBuZWVkIG5vdCBjaGFuZ2UNCndoZW4gc29tZXRoaW5nIGdvZXMg
ZnJvbSBQcm92aXNpb25hbCB0byBQZXJtYW5lbnQsIG9ubHkgdGhlIHN0YXR1cyBsYWJlbA0KY2hh
bmdlcy4gIFRoZXJlIGlzIG5vIG51bWJlcmluZyBzcGFjZSBkaXZpc2lvbiBmb3IgUHJvdmlzaW9u
YWwuDQoNCj4gSSBhbHNvIHRoaW5rIHRoYXQgeW91IHdhbnQgdG8gcnVuIHRoaXMgYXMgRWFybHkg
QWxsb2NhdGlvbnMsIHNvIHRoYXQgdGhleQ0KPiBoYXZlIGEgc3Vuc2V0IGNsYXVzZSwgYW5kIHRo
ZSBwcm9jZXNzIGZvciBzdW5zZXR0aW5nIHN1Y2ggYW4gYWxsb2NhdGlvbiBzaG91bGQNCj4gYmUg
Y2xlYXIuDQoNClRoYXQncyBhIGZpbmUgZGlzY3Vzc2lvbiB0byBoYXZlLiAgUHJvdmlzaW9uYWwg
VVJJIHNjaGVtZXMgaGF2ZSBubyBzdWNoDQpzdW5zZXQgY2xhdXNlLiAgSSBtaWdodCBhcmd1ZSB0
aGF0IHN1YnNldCBjbGF1c2VzIGFyZSBvbmx5IHVzZWZ1bCB3aGVuIHNwYWNlDQppcyBzY2FyY2Uu
ICBSaWdodCBub3csIHRoYXQncyBub3QgdGhlIGNhc2Ugd2hlbiB5b3UgY29uc2lkZXIgb3Bjb2Rl
K3NyYytpbW0NCmFzIHRoZSBzcGFjZSBhdmFpbGFibGUuDQoNCj4gWW91IG1heSBhbHNvIG5lZWQg
dG8gd3JpdHRlbiBwb2xpY3kgKGluIHRoZSBMaW51eCBrZXJuZWwgRG9jdW1lbnRhdGlvbikNCj4g
YWJvdXQgYmFjay1wYXRjaGluZyBvZiBQcm92aXNpb25hbCBudW1iZXJzIGludG8gdmVuZG9yIGJy
YW5jaGVzIGFuZC9vciBMVFMNCj4gYnJhbmNoZXMuDQo+IA0KPiBDYW4gdGhlcmUgYmUgc3VidGxl
IHNlbWFudGljIGNoYW5nZXMgdG8gUHJvdmlzaW9uYWwgYWxsb2NhdGlvbnM/DQo+IChTdWNoIGFz
IHdoYXQgaGFwcGVucyB3aGVuIGludmFsaWQgZGF0YSBvY2N1cnM/ICBUaGUgZGl2aWRlLWJ5LXpl
cm8NCj4gZXF1aXZhbGVudCkNCg0KSSdkIGV4cGVjdCB0aGUgYW5zd2VyIHRvIGJlIHRoZSBzYW1l
IGFzIGZvciBQZXJtYW5lbnQgYWxsb2NhdGlvbnMuDQpPZmZoYW5kLCBJIHdvdWxkIHNheSAieWVz
IiwgdGhvdWdoIG9mIGNvdXJzZSBvbmUgbmVlZHMgYSBwbGFuIGZvcg0KYmFja3dhcmRzIGNvbXBh
dGliaWxpdHkgaWYgc28uDQoNCkRhdmUNCg==

