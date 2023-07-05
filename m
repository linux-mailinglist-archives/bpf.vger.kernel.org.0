Return-Path: <bpf+bounces-4023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AF6747D14
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 08:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2831281011
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 06:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABAD137F;
	Wed,  5 Jul 2023 06:31:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A8E636;
	Wed,  5 Jul 2023 06:31:06 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51C210CF;
	Tue,  4 Jul 2023 23:31:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBsZNmsQq2KW2ITXM3r6kRIku8l2A3ZOFD3F9mZBxukxAWx4MdTtD1OOfZtlZMTpC55qHFxRc9CIer4VC/8B/0sK+lmuVxPXQ+CD0A7X2213vwEp5SYKkeDFqQIHClQlSW5ea8tBGruTztfEADP+AKpFyr97QhV1ddlvcLFm+WZcwGXQP8N8iFigijv0oxlLkz0CiEcPqefj2zznCIf2zv64LQJWH/43Z97yl6on4dcGeHrwua0AUiso2xhdQnYyd2Cfha/0lwsZbOzWjt31BUtUZesmR3mY7JYTpMNfR4lWju5jJUW7e3tuzr4KSADQFCyo33VyGdKgDm4yPnS63g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20NK/701TxiRbwVK12VOrFk0WpixUm4jn8HkrHLUG08=;
 b=gAppMgMPmdjBuKhDQ6JbUQE2b2M5aoocTBGGOtjdX0k7DfWjp9xi03xM5v9hSDZFpdjmbXYX8Vpgsxx44yp5N9y1h4M3kHA8ta6Z1KLoA+RohE/3mRuioa8Mgt68JEzjHG1JnnXKKmrzzofZWaaI2YCPH7aYpKnbYHZTxUg94RFeMsGSxxmxgfm0NTxYuxmO6Tz2rGFPKahYeeye4WSPEDW4TrpdtqaLwAIEOiXwBe6gbgrBhM/a3Xdxk81nvxdwcIUdkVoBAafSl6JeHiw5broROXGSdyhiuV6aZZRJ0UG1HoJyaYJhEFn7wrHY7wOvDMVGk1PKR00uEGVz7xefGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20NK/701TxiRbwVK12VOrFk0WpixUm4jn8HkrHLUG08=;
 b=r1ZhLaziXPNNlI2E5y69N93BMKUXFpnQMHKBZ+GYUmNaDH1+TqMyaeTxS3ZNVwI4zg2LyXydYXG40km0YqeWufUXjvVXDm1WdaQFmlXG4ASL5Kbh6fEIA4v5zEA+RSJHoMA1jsodjNtd6LQjDAodkcPpWTJg9eSgU6f9bIfD2tM=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by AM7PR04MB6967.eurprd04.prod.outlook.com (2603:10a6:20b:108::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 06:31:01 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::1edd:68cb:85d0:29e0]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::1edd:68cb:85d0:29e0%7]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 06:31:01 +0000
From: Wei Fang <wei.fang@nxp.com>
To: =?ks_c_5601-1987?B?VG9rZSBIqappbGFuZC1KqapyZ2Vuc2Vu?= <toke@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "hawk@kernel.org"
	<hawk@kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-linux-imx
	<linux-imx@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH net 1/3] net: fec: dynamically set the
 NETDEV_XDP_ACT_NDO_XMIT feature of XDP
Thread-Topic: [PATCH net 1/3] net: fec: dynamically set the
 NETDEV_XDP_ACT_NDO_XMIT feature of XDP
Thread-Index: AQHZrlKH9DPlrN0i90eHtHUSPhb6oq+qRYCAgAADioCAAG3JsA==
Date: Wed, 5 Jul 2023 06:31:00 +0000
Message-ID:
 <AM5PR04MB313999EB0E85DFE30F071317882FA@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230704082916.2135501-1-wei.fang@nxp.com>
 <20230704082916.2135501-2-wei.fang@nxp.com>
 <5b1182d5-a147-4bfd-9ac8-b33462e97b10@lunn.ch> <87mt0bb5cm.fsf@toke.dk>
In-Reply-To: <87mt0bb5cm.fsf@toke.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|AM7PR04MB6967:EE_
x-ms-office365-filtering-correlation-id: ab4e26b1-3331-4c72-4baa-08db7d216684
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 R/gg3EVjKnQYGZney4Hy+IVIpiBHUeRyCpkpRGqc2L/puS05H1zjUBLb+seIhlqnk30JLrPzAyuIOdZJqVy/sNJkFjYu/iyWlI4BVY3CJ1oPl6LLMbtz28+1EfPXWoIg3tBGyI3QckrBVKbKVvShtLAG/L5thtd/l/r1eblmOt7b37tqMHrxuvftA4fb4Zkmvy9A2zMutxZ3DGiQdeh5+pqHX/WCt2Ltj8MPvk0t5rAUAaCNx4Xp+l1kyeT7x6gfGpQSe8OaNbSaPbVxqQ0djnHhKTfJDJfCHvMDKBt+LLed1ApnT5O5ySAfjL7x8cL6+zPmTwpfMfdIsIVbKgTig9xU5k40/m07fL+LrRnnFvZE+Kc+f+NtMePnE3pFyTtOaQHvZ3IIUdqrvlTCZd/o3vgdNHPOLxB6orceNmjvPGLJVWYAqPccLQ0jAZvv2ZhUPt1BUGUSHCYmzItrqEuWZOlbeg8E+avrKcgxIVNJpd+JKPg3BkJggtjL0V37684+V/hG12FItu/sD6xM7/tFpk84jvwlfsAnzzoEcc66kze1nnQcloQkD/hWKhSuAr3cZq1dqLIlqQpURXHamf8gaBZB6w+BhdTPnaocG3KI5H/o7HFb69Qu7+3xGM74yhjR
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(451199021)(76116006)(66446008)(64756008)(38100700002)(66476007)(66556008)(66946007)(4326008)(122000001)(55016003)(186003)(86362001)(33656002)(71200400001)(38070700005)(7696005)(9686003)(6506007)(26005)(53546011)(478600001)(54906003)(110136005)(8936002)(8676002)(44832011)(5660300002)(7416002)(52536014)(41300700001)(2906002)(316002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?ks_c_5601-1987?B?NlpHOHV3bVVESnB1bWZheUhlY3FqaFFjUlpQWTZKMHgydHlqNkc3?=
 =?ks_c_5601-1987?B?UUg3OTF3VG43QXE1b0ZnaUhVTW9YTGxXZ1p6aU9PdVVVTUdOWDRn?=
 =?ks_c_5601-1987?B?WFJ1UjFoazVkTmVXWlBtRnhsd0NEYjFiT3RpU2tmNkdIKzFwMXVk?=
 =?ks_c_5601-1987?B?U0xUZlVIa0dDTTJxQUhFQ2o2NGxSb1RrUjd1QnI1ZU5FRTAwKzVB?=
 =?ks_c_5601-1987?B?Q0szcmFhL3VRdzFaV0Z2d1ZwYUZnL2VRR1g2OEhaSFZxdDlodnBo?=
 =?ks_c_5601-1987?B?dDUwR1hKbUZtblIrUkM3UDdFNEVLVEl2ZG54b2tnZEhIaGJvazB1?=
 =?ks_c_5601-1987?B?aStiaDVwRG9uWnJ4K1Rnc3ZEYWMrcndVdTJuWVNZSDNybjN1RjNp?=
 =?ks_c_5601-1987?B?dkRQNTI3d21UM1JRbnB2Q1JRUDZEb3RFVC94Q1RwWjBBc2IwVjhy?=
 =?ks_c_5601-1987?B?UlBPM2h4azlHcXo1dkJUdWFDOURxcUlDVytydGxwNmFVdnppcjZO?=
 =?ks_c_5601-1987?B?OW1sN1RQNkhtRzl1NGFVZGtDVVdsTnN1eFlUT2tERkpwbGhaMS8v?=
 =?ks_c_5601-1987?B?cS81TG4zZ2xDMnV3OTY5ejZMTW5MbzVTdGxFL3pPVFNOaVJsa2Y3?=
 =?ks_c_5601-1987?B?L0Y3ZFdlWE02QmZJNER5ckNlTFFiZ1g1RFdKNjM2dUlGRnhOVTBw?=
 =?ks_c_5601-1987?B?Njh2NkluK2pJaTdqRnBPOE5YL3ZJSlc5WlV1TVNXYjJWY3g5SFhM?=
 =?ks_c_5601-1987?B?NjAxcHVrN1lDU3Z6cFgwaVNVc2JpMkJjV09PYlprTVlJZU9uUlpS?=
 =?ks_c_5601-1987?B?QUlsbFJkRGloLzRtRG1oVXRrVlhtb0NXZG1qUzdUSlBRZWRkNVgr?=
 =?ks_c_5601-1987?B?cGszUnlJMERFR0gwZmNOM2Z3NG5haFFlVHpQdTBHRlE0N0JsWm1X?=
 =?ks_c_5601-1987?B?MmlZemljTlNzMGo1YXU0TFd4bDVOcHkvV2JjS3g4bDNlSHkvajdL?=
 =?ks_c_5601-1987?B?QTVOLzhBUEVmUkNsd1FIWFZTL3p1dlE0ODkwV05EU0gyeng0OU8r?=
 =?ks_c_5601-1987?B?SnBBL3JXbHV3ZG42T0o1eGh3T0JyOERucU0wK3Y2eEl0ZWlwb1Fm?=
 =?ks_c_5601-1987?B?VXhaUjVvZkNQQ0lEMkVpWUNJc1MzbitnZTd0M1U2bm8zdGJGb2ZF?=
 =?ks_c_5601-1987?B?K3RnT3ZMTHYwbkk1MkxZd21kM3JKTzFoTk5wTXB6QjdQZjdhWDJ0?=
 =?ks_c_5601-1987?B?Z3pwQUhxbUtUVkEvSzQ1cElJQWZUMmFpenBLWEIxV0lSNnJScEJJ?=
 =?ks_c_5601-1987?B?ZlF2K1JlWGRKakF5VkFaMFo4RG9SYk9TV1NpOEFGcTdZSkFQS2tv?=
 =?ks_c_5601-1987?B?d2RsMnViNzBvdzdsRG1IQUJkdmVIZWUvd1dqREhEcVZ2azBPVXVm?=
 =?ks_c_5601-1987?B?TTQ5bWQ0TFI5d1IrMWo1U0daTlJOUGkvWUgxTWhKcVd5S2xwVG51?=
 =?ks_c_5601-1987?B?VWpRM1ZUcDFZVlU5RldtWC9VbjBBY0swVEExeVpzTENZN3VJVjht?=
 =?ks_c_5601-1987?B?eUVOSnBMaHJ5b2doWFZ4QUg4cEgvTlc0SW9iSTNhRDROVzJXTlJx?=
 =?ks_c_5601-1987?B?MXBkSTFMTVhoT2pvYmh2NS9MVTRqaFNtb2UzQ0xCRkUvWU5vRXE1?=
 =?ks_c_5601-1987?B?djNEUnJ2a0ZxbTZuaUZxS09xT1BLTFJWZzBtV3lWNytwUnVGSlN6?=
 =?ks_c_5601-1987?B?MmdnUGtGVzNHWXVoRG5jS2kxUWdsbjRpRkZJbWN6L1hGeWpvVWNU?=
 =?ks_c_5601-1987?B?UW1wVTZxazUxbkc2Z3J0V0lOYW9oWWZqd2gzOEwxanBEaStheHB1?=
 =?ks_c_5601-1987?B?aVh5RXB1M2dEbndIYmxUYUdacVh1UUZ2ZWRkTUo0amR5cFhuSUxD?=
 =?ks_c_5601-1987?B?TWpGWk4vWGs3SmZlWjhQZUs1YUNkdERKTU1YbGQ4ZUVzRVBWMVgx?=
 =?ks_c_5601-1987?B?UVZrelp0aCtvWFliMWRaY0dZN0pqcmZmQlRjdzRxVEZOa3RaN2RW?=
 =?ks_c_5601-1987?B?aC9MVkUyNGFQc2dYVWpNOGFNcHFuY3Y3Yi9nYUVZM08wSEJyVXlw?=
 =?ks_c_5601-1987?B?MHBxOWlnQ2RFY21BMWRpeGhUQWNEQUFSUC9PaTV0elZ3Z3ZSWk45?=
 =?ks_c_5601-1987?B?VkI5UkF2R2VtVXlCZHFpOFRmYVFTTUxJUko5S3Y1cVdJOFdVYnpX?=
 =?ks_c_5601-1987?B?cWFaTFEzUEhiYkZmNlBJRzNES3BSL3B1SEQvQlgrbFFWZWg3NVpZ?=
 =?ks_c_5601-1987?B?bUp6YndHRlBNS2ZJLzROdENUdzJXSFJydmJTU1pHbUN2VWNoR2lE?=
 =?ks_c_5601-1987?B?a0lrWWxwT2Joais3ekE5bjFzajRzem5tR21mVjU1Y3g3YVplK2kv?=
 =?ks_c_5601-1987?Q?IRRcjOPpWmsfWUmLuFY=3D?=
Content-Type: text/plain; charset="ks_c_5601-1987"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4e26b1-3331-4c72-4baa-08db7d216684
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 06:31:01.0018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N7IzXEAaAfxmjWXH8T1F3WLoDE27U2T7ObZ7tceHuFIX0T7lQDaOBXyrInkNJGGp3j+UWsI/ID6iu4hS2rMumw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6967
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUb2tlIEipqmlsYW5kLUqpqnJn
ZW5zZW4gPHRva2VAcmVkaGF0LmNvbT4NCj4gU2VudDogMjAyM9K0N+rFNeztIDc6NTQNCj4gVG86
IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD47IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29t
Pg0KPiBDYzogZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBr
ZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNvbTsgYXN0QGtlcm5lbC5vcmc7IGRhbmllbEBp
b2dlYXJib3gubmV0Ow0KPiBoYXdrQGtlcm5lbC5vcmc7IGpvaG4uZmFzdGFiZW5kQGdtYWlsLmNv
bTsgU2hlbndlaSBXYW5nDQo+IDxzaGVud2VpLndhbmdAbnhwLmNvbT47IENsYXJrIFdhbmcgPHhp
YW9uaW5nLndhbmdAbnhwLmNvbT47DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4
LWlteCA8bGludXgtaW14QG54cC5jb20+Ow0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBicGZAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0IDEvM10gbmV0
OiBmZWM6IGR5bmFtaWNhbGx5IHNldCB0aGUNCj4gTkVUREVWX1hEUF9BQ1RfTkRPX1hNSVQgZmVh
dHVyZSBvZiBYRFANCj4gDQo+IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD4gd3JpdGVzOg0K
PiANCj4gPiBPbiBUdWUsIEp1bCAwNCwgMjAyMyBhdCAwNDoyOToxNFBNICswODAwLCB3ZWkuZmFu
Z0BueHAuY29tIHdyb3RlOg0KPiA+PiBGcm9tOiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4N
Cj4gPj4NCj4gPj4gV2hlbiBhIFhEUCBwcm9ncmFtIGlzIGluc3RhbGxlZCBvciB1bmluc3RhbGxl
ZCwgZmVjX3Jlc3RhcnQoKSB3aWxsIGJlDQo+ID4+IGludm9rZWQgdG8gcmVzZXQgTUFDIGFuZCBi
dWZmZXIgZGVzY3JpcHRvciByaW5ncy4gSXQncyByZWFzb25hYmxlIG5vdA0KPiA+PiB0byB0cmFu
c21pdCBhbnkgcGFja2V0IGR1cmluZyB0aGUgcHJvY2VzcyBvZiByZXNldC4gSG93ZXZlciwgdGhl
DQo+ID4+IE5FVERFVl9YRFBfQUNUX05ET19YTUlUIGJpdCBvZiB4ZHBfZmVhdHVyZXMgaXMgZW5h
YmxlZCBieSBkZWZhdWx0LA0KPiA+PiB0aGF0IGlzIHRvIHNheSwgaXQncyBwb3NzaWJsZSB0aGF0
IHRoZSBmZWNfZW5ldF94ZHBfeG1pdCgpIHdpbGwgYmUNCj4gPj4gaW52b2tlZCBldmVuIGlmIHRo
ZSBwcm9jZXNzIG9mIHJlc2V0IGlzIG5vdCBmaW5pc2hlZC4gSW4gdGhpcyBjYXNlLA0KPiA+PiB0
aGUgcmVkaXJlY3RlZCBYRFAgZnJhbWVzIG1pZ2h0IGJlIGRyb3BwZWQgYW5kIGF2YWlsYWJsZSB0
cmFuc21pdCBCRHMNCj4gPj4gbWF5IGJlIGluY29ycmVjdGx5IGRlZW1lZCBpbnN1ZmZpY2llbnQu
IFNvIHRoaXMgcGF0Y2ggZGlzYWJsZSB0aGUNCj4gPj4gTkVUREVWX1hEUF9BQ1RfTkRPX1hNSVQg
ZmVhdHVyZSBieSBkZWZhdWx0IGFuZCBkeW5hbWljYWxseQ0KPiBjb25maWd1cmUNCj4gPj4gdGhp
cyBmZWF0dXJlIHdoZW4gdGhlIGJwZiBwcm9ncmFtIGlzIGluc3RhbGxlZCBvciB1bmluc3RhbGxl
ZC4NCj4gPg0KPiA+IEkgZG9uJ3Qga25vdyBtdWNoIGFib3V0IFhEUCwgc28gcGxlYXNlIGV4Y3Vz
ZSB3aGF0IG1pZ2h0IGJlIGEgc3R1cGlkDQo+ID4gcXVlc3Rpb24uDQo+ID4NCj4gPiBJcyB0aGlz
IGEgZ2VuZXJpYyBpc3N1ZT8gU2hvdWxkIHRoaXMNCj4gPiB4ZHBfZmVhdHVyZXNfY2xlYXJfcmVk
aXJlY3RfdGFyZ2V0KGRldikgLw0KPiA+IHhkcF9mZWF0dXJlc19zZXRfcmVkaXJlY3RfdGFyZ2V0
KGRldiwgZmFsc2UpIGJlIGRvbmUgaW4gdGhlIGNvcmU/DQo+IA0KPiBObywgYmVjYXVzZSBub3Qg
YWxsIGRyaXZlcnMgcmVxdWlyZSBhbiBYRFAgcHJvZ3JhbSB0byBiZSBhdHRhY2hlZCB0byBzdXBw
b3J0DQo+IGJlaW5nIGEgcmVkaXJlY3QgdGFyZ2V0ICh3aGljaCBpcyBvbmUgb2YgdGhlIHJlYXNv
bnMgd2UgaW50cm9kdWNlZCB0aGVzZQ0KPiBmZWF0dXJlIGJpdHMgaW4gdGhlIGZpcnN0IHBsYWNl
IDopKS4NCj4gDQoNCkhpIFRva2UsDQpUaGFua3MgZm9yIHlvdXIgZXhwbGFuYXRpb24gc28gbXVj
aC4gOikNCg0K

