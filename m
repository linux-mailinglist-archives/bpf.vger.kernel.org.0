Return-Path: <bpf+bounces-5425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A7F75A73A
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 09:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4DFB1C2127B
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 07:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47D0171A1;
	Thu, 20 Jul 2023 07:06:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67591168C2;
	Thu, 20 Jul 2023 07:06:13 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D12C26A6;
	Thu, 20 Jul 2023 00:06:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=beWNnbhJiVeGHwDvdspzf8ccvjn8+tagdw3NUjOYwGOtrD8MpdeXXhjrZMCUPpshyDe/TEcuK+4hjdjvurBmy/stJ6wAFhSiBG0O2xqam++w3Mi1uDxSKbRVHh/Li1mDYbqSlGu7hHzDl0zD2cz6uzprsNNPsbO4di7zSTDhm0Mamvvxmq1Offpa+iONG63y5F6/YHEzqy5jut/3TTFoPmJ2D1M/DwHOUnhn+R83+SbRUraaU85FoFnQ5PSpvcr64KBdBrBVX4VSpDRPHt9r7VD8ioVxjWEfWNZHtqEFaA5FlrKf9bps82yTGMB4T/UoOPWChUiashA8QLCbExXFTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGRhxyE5SZS/1MCZ4MwGY+7L6E4b7rkX36GsWjCyTVU=;
 b=GboDihLEkL7KBmbxubH4nT0dPd25B8tjm07bjb8ROkMOL0d2W23LA/VSXjdIPpMwDJHAkzwi61meCoAM7jLxkUl+s+LrbprzIPZtRQx1jYX8LEpaHkZ4XYRQgrl85U17Fz8FDJvlU1vf2D/VYmx0gErcgs8ur05ySrfAAp1amvm24NuTDWn/nW0yRNQbfRSMJHCyph5CF4/AzimPebVhsBO/XychbHSLO4Dcb8r3KvgWq1QvLdPBE3iduGN0v+yUjPCJli89ZkmxY6vbtDa3SlB1gBDSw/85OJSV9txzNgdCIIJuxYqsrzfkgO+6GMCE/emYASG/S6pPZSUJIwqzPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGRhxyE5SZS/1MCZ4MwGY+7L6E4b7rkX36GsWjCyTVU=;
 b=hD1NpEjUtQZO9endGXjGUs/QPtxipEBY7lmmZi/iEPx7tra+8EFQWJUI/J5ZeBq3AKCSfgbcWHi3Q+ZNxmI6YLSRywwGH32O+cu//sgeiS+O22bZ3rINjwlDVTIEB55RZcc47NBlUkQcA+p+4lWsYRq3WPduWWL3L79wDvJvDB0=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by GVXPR04MB9778.eurprd04.prod.outlook.com (2603:10a6:150:110::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 07:06:06 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6588.031; Thu, 20 Jul 2023
 07:06:05 +0000
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
Thread-Index: AQHZuJuObnt/EH25Q0eb312+ucAGVK/CCCaAgAAiAvA=
Date: Thu, 20 Jul 2023 07:06:05 +0000
Message-ID:
 <AM5PR04MB3139D4C0F26B5768784B9CAF883EA@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230717103709.2629372-1-wei.fang@nxp.com>
 <20230719204553.46856b29@kernel.org>
In-Reply-To: <20230719204553.46856b29@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|GVXPR04MB9778:EE_
x-ms-office365-filtering-correlation-id: fcf7c77a-dfe3-4ddd-e560-08db88efc93a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yF25SH9XiOuV5vSG+NcBAPC2pbQK63gQ7URDV8JMYCOSLPbHukVngQ7Z4BXg707r7162NqEXdBBcbIxyBbwwoPyuudARl0XSU4Bx5Oli/IyxE2HPvVrIDF24Xhwvq3MOTVJ1UDAQucunpER/se2XSxOULD3eARAgTHFSo8sSEd9CIMUOvzIlI9xm56cyfdIw+VCVlPe6w9pmZYcYISUprwgCcHWPK54w8tOUOU76lrTi/HW0BR1BmNbh3HtgTUGTMyF1Z/jDNJpWMu06NJEs7K+9yYoekZqDfG5P78Ptgll/CSgODwioLVZ7Uz6UM4Zzk0sO/q3ub6gb6LWzJ2QqWW3lzNXWBhbcF49FWM4aI7ZW5ogRz+rspoRaodwVMm+SCL2UVwqGfloh2iZBWfUVsd48Xie1d248ICjW/CIkDae0vUeuLJ2In/ZRorsSNSesSktKdOcW4xP4HwAGnv2UTkwy1k0wxD6IUf7nV+xKikOchhLJbl9njwFuXn2jXP/lgTmMPxirONjl+IR3siJsnhGUvhh/tuyeIoyGvEgbuQCJcStZebJ7XEHTsv/MXVL2m/k+N8sUgh2B83hrnCf4rXdpKn8So4aFzR3PYGj7VzH2VG6Y+NyHrqBGRLFXaJgD
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199021)(2906002)(54906003)(478600001)(38070700005)(41300700001)(52536014)(44832011)(7416002)(8936002)(8676002)(5660300002)(66556008)(66476007)(66946007)(76116006)(66446008)(64756008)(55016003)(4326008)(6916009)(33656002)(316002)(86362001)(122000001)(26005)(71200400001)(53546011)(186003)(6506007)(9686003)(83380400001)(38100700002)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?bFRJem5DLytKVStIdmxBd3Y1QmZYMDBlSWlXQUxtdXAxc3V3Njk5NWlhY3Ax?=
 =?gb2312?B?MDRqM1BUcU5lY21EdzJCWHg4YTMvM0dZWW5GaGcyVTJVWC91TldLdXEzQ3kx?=
 =?gb2312?B?ekhpQ29tSGVlVm1wZDdqL3RWOEY3QzNmMUNiNnJlbkNaNzVUYnpKSm1PZ0RW?=
 =?gb2312?B?eWxoZzFxMnJjeXpDSFp3Z2IyMzZqS21wenlhMS8wUTJFYWhrcVViMHlUMlM0?=
 =?gb2312?B?eTh2STRzbXhad0paL1RoYUJDY2pTaU9IZ1BEUHZHSy9wcVN1OXFtdXFsdjZZ?=
 =?gb2312?B?U2QyZDRGMTVkaDBSVDhGaW90RjRjcHQrY0dCd092aUlWWGVCMlV3T3FMKzdW?=
 =?gb2312?B?WmNyQXpwQVlxd25WdEE1aGhDbzNodjY1VWdLT3VrejNqc1JZcjE2UXZBNVdM?=
 =?gb2312?B?cFpyZzhBR1ZXa3JvY1Y5SmZvM0w3ZjQ2YkloM2d4NUI4c3poa05PMlhQYXlB?=
 =?gb2312?B?SEN3ZjMva09uSTZ5ZHZmRWZxU3BUVDU4cWhRaEJmYTdQNUc5amJSTmV5ejdk?=
 =?gb2312?B?TmNPUTUyOXNDdkVIOVBWMzk4Si9kaFVDZGNDT1BxNHppczUvYXpKOEtYajRq?=
 =?gb2312?B?VE9ZaDNja1haaTFRSnBDcmp2WCt6SmxpaHdyUUk1QThzbGNHTjJkbjYwL0lM?=
 =?gb2312?B?M3lyNEhoNUFFRG1NbFFYNEwxNlFtY0E2SVE0SDA1ZFk5YVRBWHJOYkQ2SEVB?=
 =?gb2312?B?MEluZHdaRG1CcVQ1dXNRTTlCOHV0YjJ1c0x6dXNWR0xXZkZtZS9KR3ZDZGZS?=
 =?gb2312?B?RU1Ud2cvUWlKdVZVemt4ZkhoNmZkSzMvOXdFLzQ4ZDRmVWZnVEVIMkxkS293?=
 =?gb2312?B?dmYwS21LeG4zTURtWWhzUFRoejJ5NTl6cHhkRnI1clNJZk5oNjZ1VXRKT1Vx?=
 =?gb2312?B?MTZpcGFJTERTbGJXTG1UZmxNNFdCZnlWQ0xzbmJweDhtL3NubzQvY1U3OHlP?=
 =?gb2312?B?Q2VxUGcxSHFtOElLTXN1Y0hxY3lMejBhT0MrKzFzMGtVSjQ3aTZvWWFVNzgr?=
 =?gb2312?B?NE54OGY3cENMT3hiZ0tGd1FmV1U3UzFaOFA4VjVvT3M3YWlMRmRJdEYzejNx?=
 =?gb2312?B?dnBZZmlpbkdyNHFOZGE2QjVUU2VpWVhkVmI5dC9nVEVHZUd2WHR3RkY2cnBL?=
 =?gb2312?B?YUJxTnJLb2QwVURZblVnQmUybjJIbzRzNnpxb2pWRWlCWW5HU3VRZ2E2ZjhI?=
 =?gb2312?B?eUc0TVYzRFV1RzhweEVPV2xuR3NmMUdzMlVlSVF5YXZSNzFsQlR6aUhORmNo?=
 =?gb2312?B?REFBblpKTm5wQjlGTlFMQy9OS08rYjhzMVdRVVZHeXFtVmNubHN0Ui80OUJm?=
 =?gb2312?B?NUtkNkljVElUQ004ZE1LT1ZKM3RuY0pEdFg3a0E3U1g3Rm4wWDVvNmpxcHVm?=
 =?gb2312?B?M0lKMUFaaDVnQmtwbUkvWWsvN20zRmNQU2xUcWQzNHBNbVRXbUdQUXQ1akV6?=
 =?gb2312?B?TlpjY0xaMlQzSnBaOTBXWTRnVU84cGxNUkZDOEJRSzVrOHI1dGdKaHhkV2l1?=
 =?gb2312?B?NHhTWDRSV3BRdkVMMVh5U2ViakJMNUExTUcrUC9kdUVxb2dpcjlJMDArM3Y0?=
 =?gb2312?B?QWdFTC9wSE5XVGZlamhIZk5RWFNqeTc5Yzc4MnF2UWZPME54NGpWQWxtc1hl?=
 =?gb2312?B?anpUM2twU3ltYkZOcWROTyt0WFdWb25pVEZwa1krTy80VnlVY0VVVURRbjZ5?=
 =?gb2312?B?Nkc2MlRaVDd5Y1hlV0JMZ0RVVzd2SStQWDk0VVV5a3g5YkNiMkhkMFk2alRV?=
 =?gb2312?B?WlBGZThVL3ExaFRLTTY0NnhHdVp4UEtLZXNyUUkweUc5Zzc5bUJjSkE3aWha?=
 =?gb2312?B?SFZnTFJzSHVNMXlZNkxzaW02V1BlaUJoNVc0LzdBUUVWclJNZlRFdS8wU0Iv?=
 =?gb2312?B?UUF3bmFIOVNTd1VLUmVmQXB2cnltRUhkYzA0RkNZZDJhQzM3MmVxdmU2cFRL?=
 =?gb2312?B?TlpJb1B3anJtakVXUENBZGorWnA5a3NjSnBiZE5pNGE3eFJ1VU9xRkRrYndM?=
 =?gb2312?B?eVh6QkZnSFJYTW5OYmhYZGVtRlltWUZuY2NUZ2J0cXRRTWRTSXpQcDJkbkpJ?=
 =?gb2312?B?YWFwdHhDVjZqZ2J0MEpHQ1drcXYrVkJSQjY1TVZkOFNlOW1FTFBhaTYrdE9t?=
 =?gb2312?Q?L2wU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf7c77a-dfe3-4ddd-e560-08db88efc93a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 07:06:05.7374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fKGOg1r+IHdN+0xk92a5ZnZ+kLK2fsgwuF0ejmWoFB3kSVgrQ7q+ieDO/MZMiuReiD7OIaoIA90acDMNuQPWfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9778
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDIzxOo31MIyMMjVIDExOjQ2DQo+IFRvOiBXZWkgRmFu
ZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gQ2M6IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0
QGdvb2dsZS5jb207IHBhYmVuaUByZWRoYXQuY29tOw0KPiBhc3RAa2VybmVsLm9yZzsgZGFuaWVs
QGlvZ2VhcmJveC5uZXQ7IGhhd2tAa2VybmVsLm9yZzsNCj4gam9obi5mYXN0YWJlbmRAZ21haWwu
Y29tOyBDbGFyayBXYW5nIDx4aWFvbmluZy53YW5nQG54cC5jb20+OyBTaGVud2VpDQo+IFdhbmcg
PHNoZW53ZWkud2FuZ0BueHAuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgt
aW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGJwZkB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQtbmV4dF0gbmV0
OiBmZWM6IGFkZCBYRFBfVFggZmVhdHVyZSBzdXBwb3J0DQo+IA0KPiBPbiBNb24sIDE3IEp1bCAy
MDIzIDE4OjM3OjA5ICswODAwIFdlaSBGYW5nIHdyb3RlOg0KPiA+IC0JCQl4ZHBfcmV0dXJuX2Zy
YW1lKHhkcGYpOw0KPiA+ICsJCQlpZiAodHhxLT50eF9idWZbaW5kZXhdLnR5cGUgPT0gRkVDX1RY
QlVGX1RfWERQX05ETykNCj4gPiArCQkJCXhkcF9yZXR1cm5fZnJhbWUoeGRwZik7DQo+ID4gKwkJ
CWVsc2UNCj4gPiArCQkJCXhkcF9yZXR1cm5fZnJhbWVfcnhfbmFwaSh4ZHBmKTsNCj4gDQo+IEFy
ZSB5b3UgdGFraW5nIGJ1ZGdldCBpbnRvIGFjY291bnQ/IFdoZW4gTkFQSSBpcyBjYWxsZWQgd2l0
aCBidWRnZXQgb2YgMCB3ZQ0KPiBhcmUgKm5vdCogaW4gbmFwaSAvIHNvZnRpcnEgY29udGV4dC4g
WW91IGNhbid0IGJlIHByb2Nlc3NpbmcgYW55IFhEUCB0eCB1bmRlcg0KPiBzdWNoIGNvbmRpdGlv
bnMgKGl0IG1heSBiZSBhIG5ldHBvbGwgY2FsbCBmcm9tIElSUSBjb250ZXh0KS4NCkFjdHVhbGx5
LCB0aGUgZmVjIGRyaXZlciBuZXZlciB0YWtlcyB0aGUgYnVkZ2V0IGludG8gYWNjb3VudCBmb3Ig
Y2xlYW5pbmcgdXAgdHggQkQNCnJpbmcuIFRoZSBidWRnZXQgaXMgb25seSB2YWxpZCBmb3Igcngu
DQoNCj4gDQo+ID4gK3N0YXRpYyBpbnQgZmVjX2VuZXRfeGRwX3R4X3htaXQoc3RydWN0IG5ldF9k
ZXZpY2UgKm5kZXYsDQo+ID4gKwkJCQlzdHJ1Y3QgeGRwX2J1ZmYgKnhkcCkNCj4gPiArew0KPiA+
ICsJc3RydWN0IHhkcF9mcmFtZSAqeGRwZiA9IHhkcF9jb252ZXJ0X2J1ZmZfdG9fZnJhbWUoeGRw
KTsNCj4gPiArCXN0cnVjdCBmZWNfZW5ldF9wcml2YXRlICpmZXAgPSBuZXRkZXZfcHJpdihuZGV2
KTsNCj4gPiArCXN0cnVjdCBmZWNfZW5ldF9wcml2X3R4X3EgKnR4cTsNCj4gPiArCWludCBjcHUg
PSBzbXBfcHJvY2Vzc29yX2lkKCk7DQo+ID4gKwlzdHJ1Y3QgbmV0ZGV2X3F1ZXVlICpucTsNCj4g
PiArCWludCBxdWV1ZSwgcmV0Ow0KPiA+ICsNCj4gPiArCXF1ZXVlID0gZmVjX2VuZXRfeGRwX2dl
dF90eF9xdWV1ZShmZXAsIGNwdSk7DQo+ID4gKwl0eHEgPSBmZXAtPnR4X3F1ZXVlW3F1ZXVlXTsN
Cj4gPiArCW5xID0gbmV0ZGV2X2dldF90eF9xdWV1ZShmZXAtPm5ldGRldiwgcXVldWUpOw0KPiA+
ICsNCj4gPiArCV9fbmV0aWZfdHhfbG9jayhucSwgY3B1KTsNCj4gPiArDQo+ID4gKwlyZXQgPSBm
ZWNfZW5ldF90eHFfeG1pdF9mcmFtZShmZXAsIHR4cSwgeGRwZiwgZmFsc2UpOw0KPiA+ICsNCj4g
PiArCV9fbmV0aWZfdHhfdW5sb2NrKG5xKTsNCj4gDQo+IElmIHlvdSdyZSByZXVzaW5nIHRoZSBz
YW1lIHF1ZXVlcyBhcyB0aGUgc3RhY2sgeW91IG5lZWQgdG8gY2FsbA0KPiB0eHFfdHJhbnNfY29u
ZF91cGRhdGUoKSBhdCBzb21lIHBvaW50LCBvdGhlcndpc2UgdGhlIHN0YWNrIG1heSBwcmludCBh
IHNwbGF0DQo+IGNvbXBsYWluaW5nIHRoZSBxdWV1ZSBnb3Qgc3R1Y2suDQpZZXMsIHlvdSBhcmUg
YWJzb2x1dGVseSByaWdodC4gSSdsbCBhZGQgdHhxX3RyYW5zX2NvbmRfdXBkYXRlKCkgaW4gdGhl
IG5leHQNCnZlcnNpb24uIFRoYW5rcyENCg0K

