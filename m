Return-Path: <bpf+bounces-4182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 815BA749571
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 08:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A17851C20CFA
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 06:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D301111;
	Thu,  6 Jul 2023 06:14:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821EB10EF;
	Thu,  6 Jul 2023 06:14:58 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2047.outbound.protection.outlook.com [40.107.6.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0661982;
	Wed,  5 Jul 2023 23:14:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2hDph98htjtxT2RHHolSz3gXDBcNF4cbTbLuzdO+wzzFNfh/5MGh8jn3JBJ1pYCsMLygXi2t/lGsgtTRdS58E0CS4ecniqsUPXrR7AVxitieo95SI/xO0tYN/qj12bQR8fLYFoee/0qR8o9bWtkQiFDEllmQEO42TmIyjqrndVQCF8QppyReLfDSUdajm6oeAr0P4Wty8/OB0dorv3yJwP2v8OyM3ndQf7XB8rz/A6VQoKIVtsDrK1K45EwBA5vWt201Q9m6qIsIYVamusjysnSA+SEV4CB8ozhi21Ry1FURbShwEyOQAVYwMWMylZhDPLDwSzcMze2HBdpPU0o3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIaphD7QBEncZNX1foqFdtBIqoEvLfrepsPhfqPXsdo=;
 b=V2lAwtd6aB3L/J9KZQiJo91B/Sz5Xd6ugeD5dbX8a5ua63yPQiVDAVW6Tk6NzCvwKIuFK/bBAHKqZ4xQuX9lNIQfRSR9bOKGpxWWl7YdJX0LAK7OCHjAcR3CazxYzkFWmzQsqIv966MFRqa+0Cic1eyl3vFdU204U1uwT2eQHanRpFsUU/TXmRxLnHeqTe+d4LmM0zWy4plIG48Ygn1uv05aYtbKfrmCuraKYZglSCTZIXxk7YPrurjMpqp2MG1no0nhBHYxGcRuNpFvRP7tva61AEklintr/wHpY54j5/enTdn9uO1fM2jgFF0UjXtTwgKwhPsOfIEwmHHcpOUt+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIaphD7QBEncZNX1foqFdtBIqoEvLfrepsPhfqPXsdo=;
 b=C4F+XPOLbdFqXxqpfK2NxZLxanrcF0K5CtYIWdB/0JixgPNj35FFzf8qRSmLPCGmvPPsVRUX5Xp95kE8XDXTNfFYjoKX86hFxVWJQHGN6RkHEAljCAH5FTeq4eOVlWq5TA2HeBrtWTn7Pshsld7IewDxPfRie1UJQfAqvtWzWt0=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by DB9PR04MB8377.eurprd04.prod.outlook.com (2603:10a6:10:25c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 06:14:54 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::1edd:68cb:85d0:29e0]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::1edd:68cb:85d0:29e0%7]) with mapi id 15.20.6544.024; Thu, 6 Jul 2023
 06:14:54 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "hawk@kernel.org"
	<hawk@kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-linux-imx
	<linux-imx@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH net 3/3] net: fec: increase the size of tx ring and update
 thresholds of tx ring
Thread-Topic: [PATCH net 3/3] net: fec: increase the size of tx ring and
 update thresholds of tx ring
Thread-Index:
 AQHZrlKWMcGquWZZ5UGq1vf9jWNReK+qUaEAgAAZ9TCAAQ/2gIAAetPwgAAcN4CAAA6X4A==
Date: Thu, 6 Jul 2023 06:14:54 +0000
Message-ID:
 <AM5PR04MB3139A8B6B107F372A5D8A7D0882CA@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230704082916.2135501-1-wei.fang@nxp.com>
	<20230704082916.2135501-4-wei.fang@nxp.com>
	<0443a057-767f-4f9c-afd2-37d26b606d74@lunn.ch>
	<AM5PR04MB3139789F6CCA4BEC8A871C1D882FA@AM5PR04MB3139.eurprd04.prod.outlook.com>
	<20230705111119.07c3dee3@kernel.org>
	<AM5PR04MB3139ED2B0F74BBD00B85A448882CA@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <20230705201155.5a05bf18@kernel.org>
In-Reply-To: <20230705201155.5a05bf18@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|DB9PR04MB8377:EE_
x-ms-office365-filtering-correlation-id: 516d4d1a-dba2-4180-8390-08db7de850c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 VaTNi0WoiG6Xi8kjdGDqizHDHyU5AVCkc8JVn+dqa747fOQ7vXs7aZXtYD6I4wHJbHqpoAFg8MRUux9Y7FN7C2trytRhN2fmWKCAhOsO4POCCnqwHlDX7EeAGoLoMVYYc6eGRvKarVj4KpfdLfK/2E1tneE8NhoxWG76FkbUqtu3Tu+oN84nfyuvjHNadwTUIWZKRpq9lhzuwJdb8TaQj7su/QwRrN1OvGSSbd/JqMp5ruwoGrOnWj2SaQY03FcfSm6NnPkz8HPI6i+y2AWpQxoND+A/vO8lILAMuJ/gCTQbpEqM6Z6YTsg3HtDhO9JLwhKPxPODhVHUPRqrXES6mLjKqug5EEOGB2J0QdcZnjUKL10ga1uwzSjONfGV6m1EZ6LmPkafZhqa29c4QaDfrw6LQx8N/l2QtXNi4JJM+4hSiBvQts/WTu2ilYA734FSnOPIExRDKehgXI9qQP1ggNJsBhUEm+0UAKQUgvpjQKOhclnFp5O3bXZBE4bbl4ZtsvvETQasgd0cyKG5G3gs/PdNtdI3o4oSYeJwIXwfay7bsnSRXHVuBVbDR5Fu0oRdtiVHv876d3C+3FD6G7o9PaQrWzqmB1a7S3GvgPpaxh2x2Ssmv9xfPVBxgsI1MT1t
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(451199021)(66556008)(66946007)(66446008)(6916009)(4326008)(76116006)(64756008)(316002)(66476007)(38100700002)(122000001)(55016003)(38070700005)(26005)(6506007)(86362001)(478600001)(54906003)(9686003)(33656002)(186003)(53546011)(8936002)(8676002)(15650500001)(44832011)(5660300002)(52536014)(7416002)(7696005)(2906002)(83380400001)(71200400001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?OW11QUlqR1pmWEZXRTJWUGFkenBTSStvTUphVGwyU29UUmd0aThDekhRY051?=
 =?gb2312?B?L2RDczUzZEFEMUM5dy9DSmdoeXlta1ZENjBhZ0xSQnBuUVJ5Nlg3bHVHUGlH?=
 =?gb2312?B?YlFZd3hJNEx2bWVqdnYvb2JyTi9tRWxxMDk3Mm43eTFFcFNkVFZMYWxJNlNV?=
 =?gb2312?B?eGpTUWhoZEQza280dnlFWlpaQUFQajNCYSswT1RTZlV3MDltWVlhVTF4cERC?=
 =?gb2312?B?QWM3NnNLU3JzT0NFTnBtWVkrNjFYVVB4Yy9GSmhmaGRzMlF3SHRhN0YzV2xH?=
 =?gb2312?B?Nk9RT0d6UTJWYVZnWDFFbWdPd0ZDMjFMeDNWbDI2Ylo5cWZDYmY0Tng0TS9n?=
 =?gb2312?B?QlJZWGMvSnlkbmswK3Nrd2pyclE4WTV6OFNoSVpIM3FaZURtWnVtQ3FKMlRn?=
 =?gb2312?B?aTFEM3lBcmpGWWdRRVoreXo0NWtwYk42Zmp6ZERzNFAwOXppOHU5N0RsQWto?=
 =?gb2312?B?bGxJb2liZVM5OWU1MnhLMndTbmtPeVdtOXp6dkRoSVpTU3RNRVczQlFSRFF3?=
 =?gb2312?B?c2xjbkJnL002YXJENmhVaFp4WVFONW5UYzlIUURGK0YwaEVGelZ0VFlOZGJj?=
 =?gb2312?B?cllBR3dJTE82aFpsMTBnN1NaRG44bTdOcElwclkyUEFER21ER2NRMnhjVzBJ?=
 =?gb2312?B?TWxaR2ZRU01ydnpER3psMmx3akxXa2lwbnN5ZUEyT0l6eWdEV3hXUzNid294?=
 =?gb2312?B?ZC9BMEJrWEtBUHNpSGsrMGNwL0pWS0F5L2RSK3p2MS9TWjNnalhtcVcvUWl2?=
 =?gb2312?B?TGpnYlA3ditWcHlRTTlMSEZrNUVKTWhudXpQYnVpSnJOYkdkUHNmREY4QW1P?=
 =?gb2312?B?VU5vdDlyZ3VrVDhxanNHbTE3eE5UVWRUWnB4cUdIb0tDNmpjR3NGTDUyYXEz?=
 =?gb2312?B?U29VK3R6WWNGaGY5L1FyNmFGOXpWOFg3V0VKcTZxWStYMGQyK1pnZEVUaE02?=
 =?gb2312?B?MGNjNTFSMlNISnBTNUxMRnRxcmRWRjVHZ3pidElDZGNBSkNaWkJiYjRFdGlJ?=
 =?gb2312?B?aHhjSkRrdnBjRXZucXFZNDcvSlpsYUNPOWVCOWMwa2pNblphZ0tvako5Mm5Q?=
 =?gb2312?B?NmFMUUVadHp4azgvU2pKVGpUUmJCeTVPTTJHOE5sU3FQZzNGWHphRXRmZTJD?=
 =?gb2312?B?R2U3aEY1NjBTSjUrb0ZiaHhxaTlORm1PQThoVHZrQURkRnppWkNWY3FHQjBh?=
 =?gb2312?B?aDBuLzlNNGMwR21LQkRUZkZqWTkxV0Nwb1EzNS9tU2QzaENGSUs1R3kvZmVQ?=
 =?gb2312?B?MjU3RE5kcVdoM0E1TWdoMUtPM0F0b3JFQ2wyblM4NHRJWXBMUXN0L2cxUVZV?=
 =?gb2312?B?TjJBclBDZjNYSFUrZjlpSHFkdnRTVURkazV6V2tlSmxyZmNlazZsVUlRUzdJ?=
 =?gb2312?B?cnBrVzdVdm9YV1pFYU5GRU0rZ1VMaTY3TWp0QXdlakNWbVpValJHNzY4djYw?=
 =?gb2312?B?QWEyTXU1cHhzWWdobng1NXFKK3kyc3BETU4yZWp0akNUNlh2NnJUNmJyTm5W?=
 =?gb2312?B?S1R2RHYvSEdxcDNmT093V1ZlM1RMU3R6dVN1OHJqd0F1SndQUGVDYXFqeUdl?=
 =?gb2312?B?UVo2aWFlN2d1N2h1RzkxVHdMbkM1WHhNUnFaM1FFRzNCaFpzTGlQcXUyR2hD?=
 =?gb2312?B?cXd5NXBtZTY1V2tmNXkxMHVyWkJTaFE4UEFNQUpKblFjN1hpUlA5OTByVHY5?=
 =?gb2312?B?dzFoYXRUU2taZ1liMk5idWp0WnAvTVFDdHg1N3JnNzFQSzlhMTZOaHg1RElX?=
 =?gb2312?B?Tk83Q0lzL2dqVzRxY1pQVDV4ZUhIRmJKSzc3WTdSZG5rUkFZQ3J1QjFlb1l1?=
 =?gb2312?B?RElnT2RqOERoYnpTNkhLWkJkdFFabStkMHdGQXI2MS9KejZtTVhpSUI4Mnls?=
 =?gb2312?B?MXhKa2NER2o4ZVpFVlNQVEwvcVd3MThQUnJsU013ZzRRL0cwbzduYTFRM3Az?=
 =?gb2312?B?ZWRtSlo0MnFDMlpzV0pyRHNnMlJyY1FtL1o0ZWgra1FvblhsSS9SUnpqZ20v?=
 =?gb2312?B?am1MZmowRWdBVUdzUTNhSEV1ZUwyOEhyQ2ZnSGJEWC81KzNNNTZWaXhvZHdu?=
 =?gb2312?B?dWd6cHZTWlZiQjdva2RGSVhiWWs4UW4xNGdPYm1rTHV6QzloVEU4ckhZTXg0?=
 =?gb2312?Q?xGgQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 516d4d1a-dba2-4180-8390-08db7de850c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 06:14:54.3645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jJ6G94oZGbo1eTa+r780wRvtpPLH05QpVt4/Uc7wzOam71dlu4inQFjGz873D3ZvfsRjTdO+Xuh9B4dFeyfDgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8377
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDIzxOo31MI2yNUgMTE6MTINCj4gVG86IFdlaSBGYW5n
IDx3ZWkuZmFuZ0BueHAuY29tPg0KPiBDYzogQW5kcmV3IEx1bm4gPGFuZHJld0BsdW5uLmNoPjsg
ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsNCj4gZWR1bWF6ZXRAZ29vZ2xlLmNvbTsgcGFiZW5pQHJlZGhh
dC5jb207IGFzdEBrZXJuZWwub3JnOw0KPiBkYW5pZWxAaW9nZWFyYm94Lm5ldDsgaGF3a0BrZXJu
ZWwub3JnOyBqb2huLmZhc3RhYmVuZEBnbWFpbC5jb207DQo+IFNoZW53ZWkgV2FuZyA8c2hlbndl
aS53YW5nQG54cC5jb20+OyBDbGFyayBXYW5nDQo+IDx4aWFvbmluZy53YW5nQG54cC5jb20+OyBu
ZXRkZXZAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXgNCj4gPGxpbnV4LWlteEBueHAuY29t
PjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgYnBmQHZnZXIua2VybmVsLm9yZw0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIG5ldCAzLzNdIG5ldDogZmVjOiBpbmNyZWFzZSB0aGUgc2l6ZSBv
ZiB0eCByaW5nIGFuZCB1cGRhdGUNCj4gdGhyZXNob2xkcyBvZiB0eCByaW5nDQo+IA0KPiBPbiBU
aHUsIDYgSnVsIDIwMjMgMDE6NDQ6NDkgKzAwMDAgV2VpIEZhbmcgd3JvdGU6DQo+ID4gPiBCdXQg
eW91IHNob3VsZG4ndCByZXN0YXJ0IHRoZSBxdWV1ZSBmb3IgYSBzaW5nbGUgcGFja2V0IGVpdGhl
ci4NCj4gPiA+IFJlc3RhcnRpbmcgZm9yIGEgc2luZ2xlIHBhY2tldCB3YXN0ZXMgQ1BVIGN5Y2xl
cyBhcyB0aGVyZSB3aWxsIGJlDQo+ID4gPiBtdWNoIG1vcmUgc3RvcCAvIHN0YXJ0IG9wZXJhdGlv
bnMuIFR3byBsYXJnZSBwYWNrZXRzIHNlZW0gbGlrZSB0aGUNCj4gPiA+IGFic29sdXRlIG1pbmlt
dW0gcmVhc29uYWJsZSB3YWtlIHRocmVzaG9sZC4NCj4gPiA+DQo+ID4gPiBTZXR0aW5nIHR4X3N0
b3BfdGhyZXNob2xkIHRvIE1BWF9TS0JfRlJBR1MgZG9lc24ndCBzZWVtIHJpZ2h0DQo+ID4gPiBl
aXRoZXIsIGFzIHlvdSB3b24ndCBiZSBhYmxlIHRvIGFjY2VwdCBhIGZ1bGwgVFNPIGZyYW1lLg0K
PiA+ID4NCj4gPiBNYXliZSBJIHNob3VsZCBrZWVwIHRoZSB0eF9zdG9wX3RocmVzaG9sZCB1bmNo
YW5nZWQsIHNvIHRoYXQgdGhlIHF1ZXVlDQo+ID4gaXMgdG8gYmUgc3RvcHBlZCBpZiB0aGUgYXZh
aWxhYmxlIEJEcyBpcyBub3QgZW5vdWdoIGZvciBhIGZ1bGwgVFNPIGZyYW1lIHRvIGJlDQo+IGF0
dGFjaGVkLg0KPiA+IEFuZCB0aGVuIGp1c3QgY2hhbmdlIHR4X3dha2VfdGhyZXNob2xkIHRvIHR4
X3N0b3BfdGhyZXNob2xkICsgMSwgd2hpY2gNCj4gPiBJIHRoaW5rIGl0J3MgbW9yZSByZWFzb25h
YmxlLg0KPiANCj4gSG93IGFib3V0IGF0IGxlYXN0IHR4X3N0b3BfdGhyZXNob2xkICsgMiAqIE1B
WF9TS0JfRlJBR1MgPw0KSXQncyBva2F5LiBUaGUgaXBlcmYgcGVyZm9ybWFuY2UgaXMgd2VsbCBh
cyBiZWZvcmUuDQoNCj4gSWYgYSBxdWV1ZSBvZiBodW5kcmVkcyBvZiBlbnRyaWVzIGlzIG92ZXJm
bG93aW5nLCB3ZSBzaG91bGQgYmUgYWJsZSB0byBhcHBseSBhDQo+IGh5c3RlcmVzaXMgb2YgYSBm
ZXcgdGVucyBvZiBlbnRyaWVzLiBEbyB5b3Ugc2VlIGEgZGlmZmVyZW5jZSBpbiBkcm9wcz8gVGhl
DQpJIGRpZG4ndCBzZWUgdGhlcmUgd2FzIGFueSBwYWNrZXQgbG9zcy4NCg0KPiBwYWNrZXRzIGZy
b20gdGhlIHN0YWNrIHNob3VsZCBwcmVmZXJhYmx5IHN0YXkgaW4gdGhlIHFkaXNjcyBpbnN0ZWFk
IG9mIHRoZSBkcml2ZXINCj4gcXVldWUsIHdoZXJlIEFRTSBhbmQgc2NoZWR1bGluZyBjYW4gYmUg
YXBwbGllZC4NCg==

