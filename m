Return-Path: <bpf+bounces-5573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D88075BC4B
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 04:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D1E61C21465
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 02:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8945A639;
	Fri, 21 Jul 2023 02:29:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501A638F;
	Fri, 21 Jul 2023 02:29:36 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2070.outbound.protection.outlook.com [40.107.104.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D292211B;
	Thu, 20 Jul 2023 19:29:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqoTofNi/pHtiFfAzL9XObcDJw1RKRLq0IHdiCdOAuGdNLLlLP7JxXStlZjDJfXTdpe/DaC4znLkxkdrEBLj7g6UNmBbajL0DjraNdmVBZ38P2UzezwPnIVRnYuXuEq7i1ephmsJmhzdA9aCv1YEr5zg8TE3ES+xE148/9ftdTnxGmPv+fMYxS0GO24EehKBvq1eKtcoyTEed/xiwakNaQPQlMnSovSPKLGoPWx54wgMbqL8ssTPYIXFSxh4yfk74JX8ZMxFQqFNowrtg3LaigdC5i+XM4UiWte110263k5udfXvsUc3Skxy+lYe7IVNHGfbAHop03dwd/VZAtUt7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3PAz9W7TXU2dbhrLwoQgOy0XNaU2+950N5P25J8VBI=;
 b=nt0WDvpK3hw8RNie5mJ38c8X7KF0pc1aEmcuUXhFlfaTsoZ/pJX1VCma7V9up0IIjdz2HqX+91vr2Flazs0GqSN7QYwEKJyGn8RoYVUgkQNVELlivSMV3SKMYInJwYppRmusCTnclS+6J4/s8FENDdi3vkTNHNX+MwZcb73jj00j0DJRWZnFAm8rXnD8IKHqT++MPZEYcB3mCjw8xu9IGspdvY7fxlvsl+Tl9JJIukcaG+uhf9pPl9v/ybxbYLFlL88ldRQ0ediHAm8D8nDL1gp7IMpT0ouc+OQj7gB0kb1wJwXvkJ0nl0C7qSTOhcVWljMPr7NH+cSwRPXjBlgq6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3PAz9W7TXU2dbhrLwoQgOy0XNaU2+950N5P25J8VBI=;
 b=eL3MsWr5TrEtwb5PDOiiQPd7lnpWruRiZdFd0i6rF4DdImK3YevX380hQy1DuAcf9w5k72Y07YWgBIDBjZyQx3m9kxcoJVqbZORb14kNUctF6wyPeQI26rqodCsxNoMc3wmt0oZxQfCYkPMEU/ctZKmwd7kHDtOxtMeJmRbqQr4=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by AS8PR04MB7928.eurprd04.prod.outlook.com (2603:10a6:20b:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Fri, 21 Jul
 2023 02:29:31 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 02:29:31 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "hawk@kernel.org" <hawk@kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-linux-imx
	<linux-imx@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH net-next] net: fec: add XDP_TX feature support
Thread-Topic: [PATCH net-next] net: fec: add XDP_TX feature support
Thread-Index: AQHZuJuObnt/EH25Q0eb312+ucAGVK/CCCaAgAAiAvCAAKEwgIAArLsg
Date: Fri, 21 Jul 2023 02:29:30 +0000
Message-ID:
 <AM5PR04MB313958BDA681DA11B5A9FC0B883FA@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230717103709.2629372-1-wei.fang@nxp.com>
	<20230719204553.46856b29@kernel.org>
	<AM5PR04MB3139D4C0F26B5768784B9CAF883EA@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <20230720082431.5428050e@kernel.org>
In-Reply-To: <20230720082431.5428050e@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|AS8PR04MB7928:EE_
x-ms-office365-filtering-correlation-id: 0a51745d-0dd6-41ae-096d-08db89925060
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 X+VEgtApIzABHpY3Hxn/BoR0GGvHYx4+gxnYDqOICgoe8Uqa9Ta+VZqa8KgvjrdQxfiZwezJSQBqe3On8rP/syrt1rzwENjS1StIdmd8W9VWBe5zsApDfFRHgn5JznUKC4FKbNlc5Pq9CmxTJeKAiNqn+4BaWE+H4nCpF9FRP/SCAtEOoi0fWIV6l6ZeMPaGGaPpc66nsZrtLykOaCTOCRdp5hMsTjkzc6OcFRQE3Z/krg0HCDdz6k5PZTkj27uctBAeeRMbfHg1WJbLI1so8vUx0kne6/NQ42aFw3J29pTp/Rd18HTD30lMCS5z1e0LiSZUrodl+s8GqBagvTX89iUUaqmGJN1E2k66L///8+2dV3gvtcjNfB5/cXe8nDnYFnigcMTJ6I18fmmvSnzh83a0l+lBYtU4N87PrNWpJGlcunkewODVAD9dTHPpqTwwfBu2ybPSvTl9Cp87q3hwY31dgZu/wi5aSIDuVDKSW3Qhnu0hRAUANvjcLMuIVHfLSqIumMQR6T4/OZl0jz/AOpFSOb/ij8o8SDCT9YijeMECpSRl6NpPJMOXOGlQSnmdCybqMG+DaO2r3NkYCi5FNIB6wK6YuzVxTnPTSUFOAJQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199021)(2906002)(83380400001)(38070700005)(86362001)(33656002)(122000001)(38100700002)(55016003)(41300700001)(6506007)(53546011)(9686003)(966005)(66446008)(66476007)(76116006)(66556008)(66946007)(6916009)(316002)(71200400001)(4326008)(64756008)(7696005)(186003)(26005)(7416002)(8936002)(8676002)(478600001)(54906003)(5660300002)(44832011)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?MUNmcWZhVFM2Y29vSmdvRnA4UEVMTiswRm5ZQ1pYQ0V6dURTZVFjSmlCeXls?=
 =?gb2312?B?bDJSQlArYU5XNzhHTXNvWE12a280ZlRkbGhpK1lqV0dIQnVMYmdKZmE0YmFW?=
 =?gb2312?B?VHd5MEY3d2dZdW56YjJtZlhxYVdHTFJuUWxEMGs4Qmh3VDJCZG1pcmg1VVBu?=
 =?gb2312?B?a2FmM3V0Y3RnYy92azhzV0JYK0dNb2ZQOTJqaXVGKzJNWHRlQ2lzQlM0bDZP?=
 =?gb2312?B?b1Rna2lCN2ppR1BlaXVYRjR4UHRkZjU0d3VTUm84NnZlS2xWdFgyQ1J3YS92?=
 =?gb2312?B?eUkweUZ0MGVTVDNjRXJYRWpXczVYekw3b29kYTRMVE9EdkMyVW5ybVpnNHQ5?=
 =?gb2312?B?V0cvRjZDRUtkb1o5VVhJSzIvYkJHMFQxdTZTN1RhTzJKQllwZGYrSFpQbmZS?=
 =?gb2312?B?aENzeGU0UlhYTDJiV0NycnNERUszY0hiY0xPMytxeXlqS0VnUm9ZSmdoc0Ja?=
 =?gb2312?B?RDJFQ1d0YjFXTW5SanV0ODl2ZXZNYzBYU01WN0hHaWtuL2I1UzRWZjI5UW5T?=
 =?gb2312?B?UjRkL1ErMGpwTWNLVXdmR0NuV2kyblJSaUs4MDlxTVdDRnAyL1ZRZTQvOTA2?=
 =?gb2312?B?bGRNU1hmWXpDckVmWUptYWk4ekZGNTFlMWNQVjRmQm5IbExmK2NDd0JrT3c4?=
 =?gb2312?B?cFlTZEFxdmZNU2FDTHRhcGZ2d3pDcjNBNi9aUTZtZHJWQys1QlVVTXg5Smtq?=
 =?gb2312?B?ZnBoMmhNNmdDTWVYYVZUWlQwSVVVRUE1VUVwVHowcXhSSHBic1lWYXpVbU84?=
 =?gb2312?B?c3lkZGVRZkk2TUVBMXlMTXp4eng2TkFaa1VKdks4YmkwdGZWbGI2NHM2dFA5?=
 =?gb2312?B?ODFCSkZYSDJPeGFwMjFweFNlb0phNlUvUXhpaHl4L3orb0NWZ1k2OXE2UFpq?=
 =?gb2312?B?OUh5UEhHZm83ZHBBWlE0ekRjSzZCQ0hjUldFVjhLbmxzcVNzQjEzSTBLWUhY?=
 =?gb2312?B?VkFyRGFPb2ppL3QvWGdIeTZiNVdmRUkwcG92a3pzd05aY1Q4UjAwQVJud1R0?=
 =?gb2312?B?eGkyMndCVU1OZFNFT2JlMGp3c0xuTG1RMTdGMWdjMW9HbzMzTElXcmNtZ1Z6?=
 =?gb2312?B?TVhDWTZnQmcxamRKK21KVkxlNllEeGsxd1ZqVDRPTE13aFRUejZhNll6RFJI?=
 =?gb2312?B?cHIrSWFEMkxEcFJoQzdIbWJjUENqMTF6L2Y5SzFObVZSVzFUcWZhdXJDVm9V?=
 =?gb2312?B?N1hqUlVlaXUyVWZPZ1FvRFd1TWh3UzM3ZDFuaGxPMSs2dkdwM0gwelkxWUtk?=
 =?gb2312?B?MnYrN2V6YXBkVzQxbktDd0hhaXRHTEFqTTl4dU9hbEZGQ2VyeC9pRk9CS1J2?=
 =?gb2312?B?VVU0TnFxblNPZnlYTUh6cERFWml2TUVXN0tJWFBFOTdFMm9HUkdFRmxiSnNX?=
 =?gb2312?B?dXBYclZxQUFqZ0p5dnVpSU1FRjZtaG5rTEZ4dm5hbUo0SVkwUzN2MUlNZng0?=
 =?gb2312?B?Rm1jaFV4bEdSUmxJclBGenNEOHc4NTdnRlFXcVZUSHlKNkliOHc3WURFRk41?=
 =?gb2312?B?ejVOMW9tWDVoRFNFYjFxdEJQRHR2ejVLQUhHUFFGd0Q5Mi9UVzRVVThtTnF6?=
 =?gb2312?B?MlhRZjRtcC9qcmhUZDBvV1llWW5BQUVGOFBrOFJRRWxRWDJxZzRCdEgrWHo0?=
 =?gb2312?B?Rm1XSFFROTY5c2F1amFFOVR6eXhGaHNreEM2Tk92ekNuRk8rYkhwd1BqMm90?=
 =?gb2312?B?a1hqS2puUWMzTGJwYWV5V2MzeGpFYldyaDhOUmpvaXoyVXplTVIvVGtmZG50?=
 =?gb2312?B?WUplRTE1NUVuMFU4RUpqR0U3L3RvaWs3VlZtYkRuSFc4bXN5N3RDaHVmMUtl?=
 =?gb2312?B?Z1FObEdadEhBUnRncEFTZTlWekZZMFE2UWt1czVEM1ZiV3hpZi9aZmI4S2lT?=
 =?gb2312?B?ZVFSblV6c1dWbkN6QUJ1YS9SSmxseG8yMnJ1RnVraEdJSDdPYW85RHdDUHZB?=
 =?gb2312?B?RkNFK2l4ZlZxSnhVbjcrc3BiSXFkRy9DWFZvWE84V3VPN0JZVWlvNXRVSklQ?=
 =?gb2312?B?OXZmZlZJeFJmZkhGeWRZajJnTzIzMUExMnhNeUJuKzgvM1lYTWE4VVd4cnFJ?=
 =?gb2312?B?d1dWL3JWdXpvN2V2REVPbmt4cmp5Y1NjMjdzN3F1OFVBT2pWQkhrSWJVeGNK?=
 =?gb2312?Q?ud2o=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a51745d-0dd6-41ae-096d-08db89925060
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 02:29:30.9484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d5fonZRMkp6fPC3RxmreVsPf+o0mPjSYkrxuuTny4+4EhInfj08MXViR5LfSww1eEDwallgjIkpYemK/JE6RNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7928
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDIzxOo31MIyMMjVIDIzOjI1DQo+IFRvOiBXZWkgRmFu
ZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gQ2M6IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0
QGdvb2dsZS5jb207IHBhYmVuaUByZWRoYXQuY29tOw0KPiBhc3RAa2VybmVsLm9yZzsgZGFuaWVs
QGlvZ2VhcmJveC5uZXQ7IGhhd2tAa2VybmVsLm9yZzsNCj4gam9obi5mYXN0YWJlbmRAZ21haWwu
Y29tOyBDbGFyayBXYW5nIDx4aWFvbmluZy53YW5nQG54cC5jb20+OyBTaGVud2VpDQo+IFdhbmcg
PHNoZW53ZWkud2FuZ0BueHAuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgt
aW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGJwZkB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQtbmV4dF0gbmV0
OiBmZWM6IGFkZCBYRFBfVFggZmVhdHVyZSBzdXBwb3J0DQo+IA0KPiBPbiBUaHUsIDIwIEp1bCAy
MDIzIDA3OjA2OjA1ICswMDAwIFdlaSBGYW5nIHdyb3RlOg0KPiA+ID4gQXJlIHlvdSB0YWtpbmcg
YnVkZ2V0IGludG8gYWNjb3VudD8gV2hlbiBOQVBJIGlzIGNhbGxlZCB3aXRoIGJ1ZGdldA0KPiA+
ID4gb2YgMCB3ZSBhcmUgKm5vdCogaW4gbmFwaSAvIHNvZnRpcnEgY29udGV4dC4gWW91IGNhbid0
IGJlIHByb2Nlc3NpbmcNCj4gPiA+IGFueSBYRFAgdHggdW5kZXIgc3VjaCBjb25kaXRpb25zIChp
dCBtYXkgYmUgYSBuZXRwb2xsIGNhbGwgZnJvbSBJUlENCj4gY29udGV4dCkuDQo+ID4NCj4gPiBB
Y3R1YWxseSwgdGhlIGZlYyBkcml2ZXIgbmV2ZXIgdGFrZXMgdGhlIGJ1ZGdldCBpbnRvIGFjY291
bnQgZm9yDQo+ID4gY2xlYW5pbmcgdXAgdHggQkQgcmluZy4gVGhlIGJ1ZGdldCBpcyBvbmx5IHZh
bGlkIGZvciByeC4NCj4gDQo+IEkga25vdywgdGhhdCdzIHdoYXQgSSdtIGNvbXBsYWluaW5nIGFi
b3V0LiBYRFAgY2FuIG9ubHkgcnVuIGluIG5vcm1hbCBOQVBJDQo+IGNvbnRleHQsIGkuZS4gd2hl
biBOQVBJIGlzIGNhbGxlZCB3aXRoIGJ1ZGdldCAhPSAwLiBUaGF0IHdvcmtzIG91dCB3aXRob3V0
IGFueQ0KPiBjaGFuZ2VzIG9uIFJ4LCBpZiBidWRnZXQgaXMgemVybyBkcml2ZXJzIGFscmVhZHkg
ZG9uJ3QgcHJvY2VzcyBSeC4gQnV0IHNpbWlsYXINCj4gY2hhbmdlIG11c3QgYmUgZG9uZSBvbiBU
eCB3aGVuIGFkZGluZyBYRFAgc3VwcG9ydC4gWW91IGNhbiBzdGlsbCBwcm9jZXNzIGFsbA0KPiBu
b3JtYWwgc2tiIHBhY2tldHMgb24gVHggd2hlbiBidWRnZXQgaXMgMCAoaW4gZmFjdCB5b3Ugc2hv
dWxkKSwgYnV0IHlvdQ0KPiBfY2FuJ3RfIHByb2Nlc3MgYW55IFhEUCBUeCBmcmFtZS4NClNvcnJ5
LCBJIGRpZCBub3QgcmVhbGl6ZSB0aGF0IHdlIGNhbiBub3QgcHJvY2VzcyBhbnkgdHggWERQIHBh
Y2tldCBpZiB0aGUgImJ1ZGdldCINCmlzIDAuIEkgbm90aWNlZCB5b3VyIGxhdGVzdCBjbGFyaWZp
Y2F0aW9uIFsxXSBpbiBuYXBpLnJzdCwgSSBiZWxpZXZlIGl0IHdpbGwgaGVscCBtYW55DQpwZW9w
bGUgYXZvaWQgdGhpcyBwcm9ibGVtIGxpa2UgbWUuIFRoYW5rIHlvdSB2ZXJ5IG11Y2guDQpbMV06
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi8yMDIzMDcyMDE2MTMyMy4yMDI1Mzc5LTEt
a3ViYUBrZXJuZWwub3JnL1QvDQoNCg==

