Return-Path: <bpf+bounces-4022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B10747CF1
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 08:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAF231C20A64
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 06:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7103138F;
	Wed,  5 Jul 2023 06:20:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5147FED2;
	Wed,  5 Jul 2023 06:20:33 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2085.outbound.protection.outlook.com [40.107.7.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E2D10E3;
	Tue,  4 Jul 2023 23:20:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3ZF+th1gKlPIflRvNuULhfBptFR0gDAvLzKCiBVBfA2A1W+Sf28kP7w+j8DN+ZM3pMp/D/62/egsCw+je9zWkv4cSulWp8v2ERva+lTNbWg1kH03F4Low8djJbe45gwBU5xbzxq4Y1Vo1NX8HCdXI8glF7xrXqTxvoyVR53WJ9a3/H0EmqRQPU//OE6VqjL1Idx5jm5SwuoPDbcrrurKFAuC/Y7mF/VGyWb63ROBzJh4MpjIzBPGItNy9l62LXOA5jTw++qUCMxokTCkw4KT9qPboqTnZreFkvrE3WG7AHBeYqlbsqxooRKwIIRIKKnk0NnANJA0sIy6Eb7ayBwqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVQJYquywztt0BOP+dVn2B8zQjSKPqIBK+01Z2Bbs+s=;
 b=HtArc4O8JtBDCt2bPDvPMqiq3uAsYOME2/XxcKG3Q1g+w3J6VJfssYIIRFpkAYLjCGH7jwBiXutjsYDtpF0hREaVn+VFGUOFBhkdPdl2QbI8G6ciXomzcScdX4efiVdeR0+CnrMI7J7wJFnznGiSgtGJfELdP0UD0XT9lAjnynHph/A3+NGqbjyZXmbjGwmVKH6kmJ0X6sOHwyLG9xQhFLwd6ky3lHIJ8OOPho3QGaZBK6X1SfYDaWY5XPSSbPb+gIVX8x0OnX++8iJtg9SKKGsSPhEP8sRSAoTu9c/H/AUgT8i7O8tMgfWzsDK9e2vuyt3hJX3ui+hBmVsiSx+Hwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVQJYquywztt0BOP+dVn2B8zQjSKPqIBK+01Z2Bbs+s=;
 b=UyoCUAtg5N7std2pm0Ka3E87AwiT7NstkL2W4ZiWYSFC7FtxZ7TFYrU/V0n/kLCSiL0vUKhSUPU4L1SYfaeHnA5SH4BJkL4Om7CVM1fdf0aK1Z+ZAFyVWjPjww69wyzKBEfZUe6h2d+9dDeRjptxHs/k/QoroPC0hBkksNVjBDU=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by VI1PR04MB7085.eurprd04.prod.outlook.com (2603:10a6:800:122::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 06:20:26 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::1edd:68cb:85d0:29e0]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::1edd:68cb:85d0:29e0%7]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 06:20:26 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "ast@kernel.org" <ast@kernel.org>,
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
Thread-Index: AQHZrlKWMcGquWZZ5UGq1vf9jWNReK+qUaEAgAAZ9TA=
Date: Wed, 5 Jul 2023 06:20:26 +0000
Message-ID:
 <AM5PR04MB3139789F6CCA4BEC8A871C1D882FA@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230704082916.2135501-1-wei.fang@nxp.com>
 <20230704082916.2135501-4-wei.fang@nxp.com>
 <0443a057-767f-4f9c-afd2-37d26b606d74@lunn.ch>
In-Reply-To: <0443a057-767f-4f9c-afd2-37d26b606d74@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|VI1PR04MB7085:EE_
x-ms-office365-filtering-correlation-id: a323c097-8993-4ab7-f39f-08db7d1fec2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rOWE7sL+ofHwKQm/t3Gp+s2dLQQ9HybCekSaqLedeevRff+4g1qRCkDGuyv3fwvXDURp5/Swm5N9LEMPDBgSaPtP1Z/FTJpuEorRhJXEI7XyFOqWpO80r8ORVC2rq5UudYkTcukaYx63E0J+ntPwWGSLJEpl/VkmiJMcP5r54bNtMysDcpgKndie8UVR8+oWvCbmqRzBPTgDt7DQB7k1pMeWQyU3qZqhsaNAuszYsel/h5Bzraz2jPKZRL3jIq4/RNb1XZqiRuoYfJf0Jjtqg9QbsGn4r8UklR5Wlz9EWM4STLCbPuf9BqCzC2vavznMXg+HdUIIlBmkISqb2smcd0XcJbAeUfQSzHrRZuQnHbFsg5NGm5IbTFYQ4ELRNZ598U/PO6N9HzB67/KsRoHXXQpgMyR7F28fFkAt6A+QOjGahQNGugcXk+dNssNPY0BMn9mG6qNMHNKdQ5OUoVSD8whQCtXJGyU9yImoV55CBEOozORMWGd7GOi7K7FzsN4sc/cwvkw18AzRQsPBgRO+xzdESd9xx2d7X6PMvdUaLrb4BQudph8bPNEurpTy8OhTXIIhrLprNgYF+QOHpgKSap+8n2IGhvjC4aW9or3q/JWg4SoWnx9e6+xr7MSBBe90
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199021)(8676002)(54906003)(8936002)(478600001)(9686003)(26005)(41300700001)(15650500001)(52536014)(33656002)(7416002)(71200400001)(2906002)(5660300002)(44832011)(30864003)(86362001)(7696005)(66446008)(4326008)(122000001)(316002)(66556008)(6506007)(66946007)(55016003)(38100700002)(66476007)(64756008)(76116006)(6916009)(38070700005)(53546011)(186003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?N3l1NmVpMngwaEIzanhodElOM25Pckg1RE5EelkwK0FnWlozV3pnR2Uxb25z?=
 =?gb2312?B?dTNpNXlDbzk2ZGhzbkJKaFAxdy90SXROcUtSSGxQWXpaZE1qTXRCbzZPZjl6?=
 =?gb2312?B?OGNwN1FOU0EzWlBuU2RyYUNQWkhUT0sraENCbmZLdlR3NVJYallwU3ZnVXFm?=
 =?gb2312?B?N2NxQkQ4aFNyQi9IamdGU2NVMnVVNUYveDJldCs4ODVLRjl2bEVsR29iWHNm?=
 =?gb2312?B?SUsxcWgrRm5zdWNGSS9yY012QWdpRHFtOC81bVRtcWo5QkdkSzFpNk9ISWlx?=
 =?gb2312?B?YmpwT3N0WStDWmxhVmtrMHRvbVB3SGtMcytnTksya05BaGlsS0UxRXhoNGF4?=
 =?gb2312?B?amFHNlJSRzdmWjdHaythSzM4ZWxMOUx4bmROcEVQZGxMbVRkeTlsY3hwTVVl?=
 =?gb2312?B?TTFSTDlERWFSUVhhdHJXam9NOW5yVFR1T3VHbTdoekYySXppdElPakFsclgz?=
 =?gb2312?B?WlAzL0tYa1prdEROSHZ6RnR0SGFkVXZ3dlV5K1VhcVIyYTZPZnJjdTF6ZnlW?=
 =?gb2312?B?Mkw2T3U1emlva2tLS0dKenNhNDVDeG8vY2ZicGFZSGo4RmRCNzUwSGZTdU1B?=
 =?gb2312?B?NmRxV29iKzdtNllCL0gxM3FkWFVuWTFzTmtSajJpd2RneS9aRnJIUFNOMXVM?=
 =?gb2312?B?U0l2WURLQjBGajBORXl1WE5MMkhvek5FMU02c3NTaWhZOTlVaC82eEFJYzhR?=
 =?gb2312?B?c3kzRmphV0duN25KOXdoTVZHRHdKTEFFaXpZT0xwWUFzcmRZek1XdVY1bTJW?=
 =?gb2312?B?WWl4eUFidlQ0WFl2TFpRVGs2aWVUK0svcVFiQkVlSTRaaXlJclh6RERHVUVC?=
 =?gb2312?B?WlJ3V2NzVzNkZlhzZktTTnR4eElNeWE0Qm9LdEx5Z1FKdnlJOGdQREw4L0o1?=
 =?gb2312?B?RkZnYjdjVGhzd0VDbmI0NWg0bnF2U214Y0JrYW9rNEsrYTJmT3Roa1lXT3R3?=
 =?gb2312?B?K3lYdzR0SitXTFdWTXZpeDVKNXFIQlAzRHN6WjJKaHM1YitzOWxFeFZ1cUU0?=
 =?gb2312?B?cXBTU1FCMHpsLzgzSWZJb2hHSlMrdzN5VS8rbEhYcUQ4MCtwaHhUNFd1enRQ?=
 =?gb2312?B?QXpUWUxad3BNUGtvTGNhc1RpSU1mNkJySllaVVNrZ2pQZ3dzditMakVNYTIx?=
 =?gb2312?B?OFQ3TmExV2pzYjRjTENqZ2Z3dytFMXp3WjJDcGFTcVRvMFQweStZL0tycThx?=
 =?gb2312?B?dlAwOWtwaUFUUjJhOXdKOXJxdVQ2dk1ieFdqQTdCNzVtbjVqbGJpMTFJY2Uw?=
 =?gb2312?B?REFpbnlLTnF5VjNXSSt4dnJJNFVMUW45eUNGc254NGRHT3NaSzlKSlcrZXpR?=
 =?gb2312?B?VGtlS3lOY1FGaVQxN3RtYVZ6WlNVOXpneFhITFBQRFFrM20xZTZRL2VhdnFp?=
 =?gb2312?B?NzRsUWJ3cGc0TTJIaHp6Ym0yWmREMnNxZnNmSDBrcWtaWjgyeExtbll1WFBJ?=
 =?gb2312?B?UXd0OTFJVllOY0Y2dThtcGd3YVBtUHBnQW4xN2t0ZitFbDlLVjYyMHdOeHpE?=
 =?gb2312?B?WU1tRVJDYnVHNHpoWSs1MWMyNmU1WWtERkxOSklKL0ZucEN2aEYyZGdvdk5Y?=
 =?gb2312?B?ck1WRzRiZVVVRkFha2VmRGJ1OFNhR1RBL1gvcVJ1QW5kMzJWWE4wMVg2VDRI?=
 =?gb2312?B?bk1WZEVNR1ZuTVpaNXVEMGVUSm9saXBRRjc0dkRUUHdORDlXUGNQYVM3SDds?=
 =?gb2312?B?RDZSamtWV1pONEJObDNsaHNDSXNDOVVFVlNzdnZWa1I3NFYvWVN1dktoWC9m?=
 =?gb2312?B?R2t1a0RIaUU3dVNvOWE4bmV4cVNzYkZRQ2Q3YWhCZ3Q3bkNaOFNObUNBTEZv?=
 =?gb2312?B?c3BVZ2FZNTZwdzNmTTBBUmNaYURPdUZJZ3BrVlJpMDFLQnBzNVpCaW1TeVhW?=
 =?gb2312?B?d280dXpMR01xYXlwOXhOZ3FQREJwcUc1SkRCYU5UMW1xdHpXMVZEbnF1MnRV?=
 =?gb2312?B?bzNqeVFDM0F1MlExV3BlQm4vN04zUk9GeElRRXlHaENMbkdYN2tPMncrRXJZ?=
 =?gb2312?B?b0paRGp5a1dDOEE4dE83M2tWbllSTDRiUEFSRFUxVHg3VHJ3OVJRSVJoV2Nr?=
 =?gb2312?B?ZDBwaFU5QStzMTlBbXdMRVYwajZQNy9RYkdHT29UWndYa2h1NHhPM051eGRJ?=
 =?gb2312?Q?Kpnc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a323c097-8993-4ab7-f39f-08db7d1fec2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 06:20:26.2606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r8aqOMurMcKM9qxnzzSUZ9NootDZWV5hcy+MWiDvP/t5JO35CjGJMsSfTtKNIMbtw9o21hgDq3vjllVBp1xvQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7085
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmRyZXcgTHVubiA8YW5kcmV3
QGx1bm4uY2g+DQo+IFNlbnQ6IDIwMjPE6jfUwjXI1SA4OjI1DQo+IFRvOiBXZWkgRmFuZyA8d2Vp
LmZhbmdAbnhwLmNvbT4NCj4gQ2M6IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2ds
ZS5jb207IGt1YmFAa2VybmVsLm9yZzsNCj4gcGFiZW5pQHJlZGhhdC5jb207IGFzdEBrZXJuZWwu
b3JnOyBkYW5pZWxAaW9nZWFyYm94Lm5ldDsNCj4gaGF3a0BrZXJuZWwub3JnOyBqb2huLmZhc3Rh
YmVuZEBnbWFpbC5jb207IFNoZW53ZWkgV2FuZw0KPiA8c2hlbndlaS53YW5nQG54cC5jb20+OyBD
bGFyayBXYW5nIDx4aWFvbmluZy53YW5nQG54cC5jb20+Ow0KPiBuZXRkZXZAdmdlci5rZXJuZWwu
b3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsNCj4gbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgYnBmQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IG5ldCAzLzNdIG5ldDogZmVjOiBpbmNyZWFzZSB0aGUgc2l6ZSBvZiB0eCByaW5nIGFuZCB1cGRh
dGUNCj4gdGhyZXNob2xkcyBvZiB0eCByaW5nDQo+IA0KPiA+IEFmdGVyIHRyeWluZyB2YXJpb3Vz
IG1ldGhvZHMsIEkgdGhpbmsgdGhhdCBpbmNyZWFzZSB0aGUgc2l6ZSBvZiB0eCBCRA0KPiA+IHJp
bmcgaXMgc2ltcGxlIGFuZCBlZmZlY3RpdmUuIE1heWJlIHRoZSBiZXN0IHJlc29sdXRpb24gaXMg
dGhhdA0KPiA+IGFsbG9jYXRlIE5BUEkgZm9yIGVhY2ggcXVldWUgdG8gaW1wcm92ZSB0aGUgZWZm
aWNpZW5jeSBvZiB0aGUgTkFQSQ0KPiA+IGNhbGxiYWNrLCBidXQgdGhpcyBjaGFuZ2UgaXMgYSBi
aXQgYmlnIGFuZCBJIGRpZG4ndCB0cnkgdGhpcyBtZXRob2QuDQo+ID4gUGVyaGVwcyB0aGlzIG1l
dGhvZCB3aWxsIGJlIGltcGxlbWVudGVkIGluIGEgZnV0dXJlIHBhdGNoLg0KPiANCj4gSG93IGRv
ZXMgdGhpcyBhZmZlY3QgcGxhdGZvcm1zIGxpa2UgVnlicmlkIHdpdGggaXRzIGZhc3QgRXRoZXJu
ZXQ/DQpTb3JyeSwgSSBkb24ndCBoYXZlIHRoZSBWeWJyaWQgcGxhdGZvcm0sIGJ1dCBJIHRoaW5r
IEkgZG9uJ3QgdGhpbmsgaXQgaGFzIG11Y2gNCmltcGFjdCwgYXQgbW9zdCBpdCBqdXN0IHRha2Vz
IHVwIHNvbWUgbW9yZSBtZW1vcnkuDQoNCj4gRG9lcyB0aGUgYnVyc3QgbGF0ZW5jeSBnbyB1cD8N
Ck5vLCBmb3IgZmVjLCB3aGVuIGEgcGFja2V0IGlzIGF0dGFjaGVkIHRvIHRoZSBCRHMsIHRoZSBz
b2Z0d2FyZSB3aWxsIGltbWVkaWF0ZWx5DQp0cmlnZ2VyIHRoZSBoYXJkd2FyZSB0byBzZW5kIHRo
ZSBwYWNrZXQuIEluIGFkZGl0aW9uLCBJIHRoaW5rIGl0IG1heSBpbXByb3ZlIHRoZQ0KbGF0ZW5j
eSwgYmVjYXVzZSB0aGUgc2l6ZSBvZiB0aGUgdHggcmluZyBiZWNvbWVzIGxhcmdlciwgYW5kIG1v
cmUgcGFja2V0cyBjYW4gYmUNCmF0dGFjaGVkIHRvIHRoZSBCRCByaW5nIGZvciBidXJzdCB0cmFm
ZmljLg0KDQo+IA0KPiA+IEluIGFkZHRpb24sIHRoaXMgcGF0Y2ggYWxzbyB1cGRhdGVzIHRoZSB0
eF9zdG9wX3RocmVzaG9sZCBhbmQgdGhlDQo+ID4gdHhfd2FrZV90aHJlc2hvbGQgb2YgdGhlIHR4
IHJpbmcuIEluIHByZXZpb3VzIGxvZ2ljLCB0aGUgdmFsdWUgb2YNCj4gPiB0eF9zdG9wX3RocmVz
aG9sZCBpcyAyMTcsIGhvd2V2ZXIsIHRoZSB2YWx1ZSBvZiB0eF93YWtlX3RocmVzaG9sZCBpcw0K
PiA+IDE0NywgaXQgZG9lcyBub3QgbWFrZSBzZW5zZSB0aGF0IHR4X3dha2VfdGhyZXNob2xkIGlz
IGxlc3MgdGhhbg0KPiA+IHR4X3N0b3BfdGhyZXNob2xkLg0KPiANCj4gV2hhdCBkbyB0aGVzZSBh
Y3R1YWxseSBtZWFuPyBJIGNvdWxkIGltYWdpbmUgdGhhdCBhcyB0aGUgcmluZyBmaWxscyB5b3Ug
ZG9uJ3QNCj4gd2FudCB0byBzdG9wIHVudGlsIGl0IGlzIDIxNy81MTIgZnVsbC4gVGhlcmUgaXMg
dGhlbiBzb21lIGh5c3RlcmVzaXMsIHN1Y2ggdGhhdCBpdA0KPiBoYXMgdG8gZHJvcCBiZWxvdyAx
NDcvNTEyIGJlZm9yZSBtb3JlIGNhbiBiZSBhZGRlZD8NCj4gDQpZb3UgbXVzdCBoYXZlIG1pc3Vu
ZGVyc3Rvb2QsIGxldCBtZSBleHBsYWluIG1vcmUgY2xlYXJseSwgdGhlIHF1ZXVlIHdpbGwgYmUN
CnN0b3BwZWQgd2hlbiB0aGUgYXZhaWxhYmxlIEJEcyBhcmUgbGVzcyB0aGFuIHR4X3N0b3BfdGhy
ZXNob2xkICgyMTcgQkRzKS4gQW5kDQp0aGUgcXVldWUgd2lsbCBiZSB3YWtlZCB3aGVuIHRoZSBh
dmFpbGFibGUgQkRzIGFyZSBncmVhdGVyIHRoYW4gdHhfd2FrZV90aHJlc2hvbGQNCigxNDcgQkRz
KS4gU28gaW4gbW9zdCBjYXNlcywgdGhlIGF2YWlsYWJsZSBCRHMgYXJlIGdyZWF0ZXIgdGhhbiB0
eF93YWtlX3RocmVzaG9sZA0Kd2hlbiB0aGUgcXVldWUgaXMgc3RvcHBlZCwgdGhlIG9ubHkgZWZm
ZWN0IGlzIHRvIGRlbGF5IHBhY2tldCBzZW5kaW5nLg0KSW4gbXkgb3BpbmlvbiwgdHhfd2FrZV90
aHJlc2hvbGQgc2hvdWxkIGJlIGdyZWF0ZXIgdGhhbiB0eF9zdG9wX3RocmVzaG9sZCwgd2UNCnNo
b3VsZCBzdG9wIHF1ZXVlIHdoZW4gdGhlIGF2YWlsYWJsZSBCRHMgYXJlIG5vdCBlbm91Z2ggZm9y
IGEgc2tiIHRvIGJlIGF0dGFjaGVkLg0KQW5kIHdha2UgdGhlIHF1ZXVlIHdoZW4gdGhlIGF2YWls
YWJsZSBCRHMgYXJlIHN1ZmZpY2llbnQgZm9yIGEgc2tiLg0KDQo+ID4gQmVzaWRlcywgYm90aCBY
RFAgcGF0aCBhbmQgJ3Nsb3cgcGF0aCcgc2hhcmUgdGhlIHR4IEJEIHJpbmdzLiBTbyBpZg0KPiA+
IHR4X3N0b3BfdGhyZXNob2xkIGlzIDIxNywgaW4gdGhlIGNhc2Ugb2YgaGVhdnkgWERQIHRyYWZm
aWMsIHRoZSBzbG93DQo+ID4gcGF0aCBpcyBlYXNpbHkgdG8gYmUgc3RvcHBlZCwgdGhpcyB3aWxs
IGhhdmUgYSBzZXJpb3VzIGltcGFjdCBvbiB0aGUNCj4gPiBzbG93IHBhdGguDQo+IA0KPiBQbGVh
c2UgcG9zdCB5b3VyIGlwZXJmIHJlc3VsdHMgZm9yIHZhcmlvdXMgcGxhdGZvcm1zLCBzbyB3ZSBj
YW4gc2VlIHRoZSBlZmZlY3RzIG9mDQo+IHRoaXMuIFdlIGdlbmVyYWxseSBkb24ndCBhY2NlcHQg
dHVuaW5nIHBhdGNoZXMgd2l0aG91dCBiZW5jaG1hcmtzIHdoaWNoDQo+IHByb3ZlIHRoZSBpbXBy
b3ZlbWVudHMsIGFuZCBhbHNvIHNob3cgdGhlcmUgaXMgbm8gcmVncmVzc2lvbi4gQW5kIGdpdmVu
IHRoZQ0KPiB3aWRlIHZhcmlldHkgb2YgU29DcyB1c2luZyB0aGUgRkVDLCBpIGV4cGVjdCB0ZXN0
aW5nIG9uIGEgbnVtYmVyIG9mIFNvQ3MsIGJ1dA0KPiBGYXN0IGFuZCAxRy4NCj4gDQpCZWxvdyBh
cmUgdGhlIHJlc3VsdHMgb24gaS5NWDZVTC84TU0vOE1QLzhVTFAvOTMgcGxhdGZvcm1zLCBpLk1Y
NlVMIGFuZA0KOFVMUCBvbmx5IHN1cHBvcnQgRmFzdCBldGhlcm5ldC4gT3RoZXJzIHN1cHBvcnQg
MUcuDQoxLjEgaS5NWDZVTCB3aXRoIHR4IHJpbmcgc2l6ZSA1MTINCnJvb3RAaW14NnVsN2Q6fiMg
aXBlcmYzIC1jIDE5Mi4xNjguMy42DQpDb25uZWN0aW5nIHRvIGhvc3QgMTkyLjE2OC4zLjYsIHBv
cnQgNTIwMQ0KWyAgNV0gbG9jYWwgMTkyLjE2OC4zLjkgcG9ydCA0NzE0OCBjb25uZWN0ZWQgdG8g
MTkyLjE2OC4zLjYgcG9ydCA1MjAxDQpbIElEXSBJbnRlcnZhbCAgICAgICAgICAgVHJhbnNmZXIg
ICAgIEJpdHJhdGUgICAgICAgICBSZXRyICBDd25kDQpbICA1XSAgIDAuMDAtMS4wMCAgIHNlYyAg
MTAuMSBNQnl0ZXMgIDg0LjkgTWJpdHMvc2VjICAgIDAgICAgMTAzIEtCeXRlcw0KWyAgNV0gICAx
LjAwLTIuMDAgICBzZWMgIDkuODggTUJ5dGVzICA4Mi42IE1iaXRzL3NlYyAgICAwICAgIDEwMyBL
Qnl0ZXMNClsgIDVdICAgMi4wMC0zLjAwICAgc2VjICA5LjgyIE1CeXRlcyAgODIuNyBNYml0cy9z
ZWMgICAgMCAgICAxMDMgS0J5dGVzDQpbICA1XSAgIDMuMDAtNC4wMCAgIHNlYyAgOS44MiBNQnl0
ZXMgIDgyLjQgTWJpdHMvc2VjICAgIDAgICAgMTAzIEtCeXRlcw0KWyAgNV0gICA0LjAwLTUuMDAg
ICBzZWMgIDkuODggTUJ5dGVzICA4Mi45IE1iaXRzL3NlYyAgICAwICAgIDEwMyBLQnl0ZXMNClsg
IDVdICAgNS4wMC02LjAwICAgc2VjICA5Ljk0IE1CeXRlcyAgODMuNCBNYml0cy9zZWMgICAgMCAg
ICAxMDMgS0J5dGVzDQpbICA1XSAgIDYuMDAtNy4wMCAgIHNlYyAgMTAuMSBNQnl0ZXMgIDg0LjMg
TWJpdHMvc2VjICAgIDAgICAgMTAzIEtCeXRlcw0KWyAgNV0gICA3LjAwLTguMDAgICBzZWMgIDku
ODIgTUJ5dGVzICA4Mi40IE1iaXRzL3NlYyAgICAwICAgIDEwMyBLQnl0ZXMNClsgIDVdICAgOC4w
MC05LjAwICAgc2VjICA5LjgyIE1CeXRlcyAgODIuNCBNYml0cy9zZWMgICAgMCAgICAxMDMgS0J5
dGVzDQpbICA1XSAgIDkuMDAtMTAuMDAgIHNlYyAgOS44OCBNQnl0ZXMgIDgyLjkgTWJpdHMvc2Vj
ICAgIDAgICAgMTAzIEtCeXRlcw0KLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0g
LSAtIC0gLSAtIC0gLQ0KWyBJRF0gSW50ZXJ2YWwgICAgICAgICAgIFRyYW5zZmVyICAgICBCaXRy
YXRlICAgICAgICAgUmV0cg0KWyAgNV0gICAwLjAwLTEwLjAwICBzZWMgIDk5LjAgTUJ5dGVzICA4
My4xIE1iaXRzL3NlYyAgICAwICAgICAgICAgICAgIHNlbmRlcg0KWyAgNV0gICAwLjAwLTEwLjAx
ICBzZWMgIDk4LjggTUJ5dGVzICA4Mi44IE1iaXRzL3NlYyAgICAgICAgICAgICAgICAgIHJlY2Vp
dmVyDQoNCjEuMiBpLk1YNlVMIHdpdGggdHggcmluZyBzaXplIDEwMjQNCnJvb3RAaW14NnVsN2Q6
fiMgaXBlcmYzIC1jIDE5Mi4xNjguMy42DQpDb25uZWN0aW5nIHRvIGhvc3QgMTkyLjE2OC4zLjYs
IHBvcnQgNTIwMQ0KWyAgNV0gbG9jYWwgMTkyLjE2OC4zLjkgcG9ydCA1NTY3MCBjb25uZWN0ZWQg
dG8gMTkyLjE2OC4zLjYgcG9ydCA1MjAxDQpbIElEXSBJbnRlcnZhbCAgICAgICAgICAgVHJhbnNm
ZXIgICAgIEJpdHJhdGUgICAgICAgICBSZXRyICBDd25kDQpbICA1XSAgIDAuMDAtMS4wMCAgIHNl
YyAgMTAuMiBNQnl0ZXMgIDg1LjQgTWJpdHMvc2VjICAgIDAgICAgMjM2IEtCeXRlcw0KWyAgNV0g
ICAxLjAwLTIuMDAgICBzZWMgIDEwLjEgTUJ5dGVzICA4NC42IE1iaXRzL3NlYyAgICAwICAgIDIz
NiBLQnl0ZXMNClsgIDVdICAgMi4wMC0zLjAwICAgc2VjICAxMC4yIE1CeXRlcyAgODUuNSBNYml0
cy9zZWMgICAgMCAgICAyNDkgS0J5dGVzDQpbICA1XSAgIDMuMDAtNC4wMCAgIHNlYyAgMTAuMSBN
Qnl0ZXMgIDg1LjEgTWJpdHMvc2VjICAgIDAgICAgMjQ5IEtCeXRlcw0KWyAgNV0gICA0LjAwLTUu
MDAgICBzZWMgIDEwLjEgTUJ5dGVzICA4NC43IE1iaXRzL3NlYyAgICAwICAgIDI0OSBLQnl0ZXMN
ClsgIDVdICAgNS4wMC02LjAwICAgc2VjICAxMC4wIE1CeXRlcyAgODQuMSBNYml0cy9zZWMgICAg
MCAgICAyNDkgS0J5dGVzDQpbICA1XSAgIDYuMDAtNy4wMCAgIHNlYyAgMTAuMSBNQnl0ZXMgIDg1
LjEgTWJpdHMvc2VjICAgIDAgICAgMjQ5IEtCeXRlcw0KWyAgNV0gICA3LjAwLTguMDAgICBzZWMg
IDEwLjEgTUJ5dGVzICA4NC45IE1iaXRzL3NlYyAgICAwICAgIDI0OSBLQnl0ZXMNClsgIDVdICAg
OC4wMC05LjAwICAgc2VjICAxMC4zIE1CeXRlcyAgODUuOSBNYml0cy9zZWMgICAgMCAgICAyNDkg
S0J5dGVzDQpbICA1XSAgIDkuMDAtMTAuMDAgIHNlYyAgMTAuMiBNQnl0ZXMgIDg1LjYgTWJpdHMv
c2VjICAgIDAgICAgMjQ5IEtCeXRlcw0KLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAt
IC0gLSAtIC0gLSAtIC0gLQ0KWyBJRF0gSW50ZXJ2YWwgICAgICAgICAgIFRyYW5zZmVyICAgICBC
aXRyYXRlICAgICAgICAgUmV0cg0KWyAgNV0gICAwLjAwLTEwLjAwICBzZWMgICAxMDEgTUJ5dGVz
ICA4NS4xIE1iaXRzL3NlYyAgICAwICAgICAgICAgICAgIHNlbmRlcg0KWyAgNV0gICAwLjAwLTEw
LjAxICBzZWMgICAxMDEgTUJ5dGVzICA4NC41IE1iaXRzL3NlYyAgICAgICAgICAgICAgICAgIHJl
Y2VpdmVyDQoNCjIuMSBpLk1YOFVMUCB3aXRoIHR4IHJpbmcgc2l6ZSA1MTINCnJvb3RAaW14OHVs
cGV2azp+IyBpcGVyZjMgLWMgMTkyLjE2OC4zLjYNCkNvbm5lY3RpbmcgdG8gaG9zdCAxOTIuMTY4
LjMuNiwgcG9ydCA1MjAxDQpbICA1XSBsb2NhbCAxOTIuMTY4LjMuOSBwb3J0IDU0MzQyIGNvbm5l
Y3RlZCB0byAxOTIuMTY4LjMuNiBwb3J0IDUyMDENClsgSURdIEludGVydmFsICAgICAgICAgICBU
cmFuc2ZlciAgICAgQml0cmF0ZSAgICAgICAgIFJldHIgIEN3bmQNClsgIDVdICAgMC4wMC0xLjAw
ICAgc2VjICAxMC44IE1CeXRlcyAgOTAuMyBNYml0cy9zZWMgICAgMCAgIDk5LjAgS0J5dGVzDQpb
ICA1XSAgIDEuMDAtMi4wMCAgIHNlYyAgOS45NCBNQnl0ZXMgIDgzLjQgTWJpdHMvc2VjICAgIDAg
ICA5OS4wIEtCeXRlcw0KWyAgNV0gICAyLjAwLTMuMDAgICBzZWMgIDEwLjIgTUJ5dGVzICA4NS41
IE1iaXRzL3NlYyAgICAwICAgOTkuMCBLQnl0ZXMNClsgIDVdICAgMy4wMC00LjAwICAgc2VjICA5
Ljk0IE1CeXRlcyAgODMuNCBNYml0cy9zZWMgICAgMCAgIDk5LjAgS0J5dGVzDQpbICA1XSAgIDQu
MDAtNS4wMCAgIHNlYyAgMTAuMiBNQnl0ZXMgIDg1LjUgTWJpdHMvc2VjICAgIDAgICA5OS4wIEtC
eXRlcw0KWyAgNV0gICA1LjAwLTYuMDAgICBzZWMgIDkuOTQgTUJ5dGVzICA4My40IE1iaXRzL3Nl
YyAgICAwICAgOTkuMCBLQnl0ZXMNClsgIDVdICAgNi4wMC03LjAwICAgc2VjICA5LjY5IE1CeXRl
cyAgODEuMyBNYml0cy9zZWMgICAgMCAgIDk5LjAgS0J5dGVzDQpbICA1XSAgIDcuMDAtOC4wMCAg
IHNlYyAgOS45NCBNQnl0ZXMgIDgzLjQgTWJpdHMvc2VjICAgIDAgICA5OS4wIEtCeXRlcw0KWyAg
NV0gICA4LjAwLTkuMDAgICBzZWMgIDkuNjkgTUJ5dGVzICA4MS4zIE1iaXRzL3NlYyAgICAwICAg
OTkuMCBLQnl0ZXMNClsgIDVdICAgOS4wMC0xMC4wMCAgc2VjICAxMC4yIE1CeXRlcyAgODUuNSBN
Yml0cy9zZWMgICAgMCAgIDk5LjAgS0J5dGVzDQotIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0g
LSAtIC0gLSAtIC0gLSAtIC0gLSAtDQpbIElEXSBJbnRlcnZhbCAgICAgICAgICAgVHJhbnNmZXIg
ICAgIEJpdHJhdGUgICAgICAgICBSZXRyDQpbICA1XSAgIDAuMDAtMTAuMDAgIHNlYyAgIDEwMCBN
Qnl0ZXMgIDg0LjMgTWJpdHMvc2VjICAgIDAgICAgICAgICAgICAgc2VuZGVyDQpbICA1XSAgIDAu
MDAtOS45MCAgIHNlYyAgIDEwMCBNQnl0ZXMgIDg0LjcgTWJpdHMvc2VjICAgICAgICAgICAgICAg
ICAgcmVjZWl2ZXINCg0KMi4xIGkuTVg4VUxQIHdpdGggdHggcmluZyBzaXplIDEwMjQNCnJvb3RA
aW14OHVscGV2azp+IyBpcGVyZjMgLWMgMTkyLjE2OC4zLjYNCkNvbm5lY3RpbmcgdG8gaG9zdCAx
OTIuMTY4LjMuNiwgcG9ydCA1MjAxDQpbICA1XSBsb2NhbCAxOTIuMTY4LjMuOSBwb3J0IDQ0Nzcw
IGNvbm5lY3RlZCB0byAxOTIuMTY4LjMuNiBwb3J0IDUyMDENClsgSURdIEludGVydmFsICAgICAg
ICAgICBUcmFuc2ZlciAgICAgQml0cmF0ZSAgICAgICAgIFJldHIgIEN3bmQNClsgIDVdICAgMC4w
MC0xLjAwICAgc2VjICAxMC43IE1CeXRlcyAgOTAuMSBNYml0cy9zZWMgICAgMCAgIDkzLjMgS0J5
dGVzDQpbICA1XSAgIDEuMDAtMi4wMCAgIHNlYyAgOS45NCBNQnl0ZXMgIDgzLjQgTWJpdHMvc2Vj
ICAgIDAgICA5My4zIEtCeXRlcw0KWyAgNV0gICAyLjAwLTMuMDAgICBzZWMgIDEwLjIgTUJ5dGVz
ICA4NS41IE1iaXRzL3NlYyAgICAwICAgOTMuMyBLQnl0ZXMNClsgIDVdICAgMy4wMC00LjAwICAg
c2VjICAxMC4xIE1CeXRlcyAgODUuMCBNYml0cy9zZWMgICAgMCAgIDkzLjMgS0J5dGVzDQpbICA1
XSAgIDQuMDAtNS4wMCAgIHNlYyAgOS45NCBNQnl0ZXMgIDgzLjQgTWJpdHMvc2VjICAgIDAgICAg
MTAwIEtCeXRlcw0KWyAgNV0gICA1LjAwLTYuMDAgICBzZWMgIDEwLjIgTUJ5dGVzICA4NS41IE1i
aXRzL3NlYyAgICAwICAgIDEwMCBLQnl0ZXMNClsgIDVdICAgNi4wMC03LjAwICAgc2VjICA5LjY5
IE1CeXRlcyAgODEuMyBNYml0cy9zZWMgICAgMCAgICAxMDAgS0J5dGVzDQpbICA1XSAgIDcuMDAt
OC4wMCAgIHNlYyAgOS45NCBNQnl0ZXMgIDgzLjQgTWJpdHMvc2VjICAgIDAgICAgMTAwIEtCeXRl
cw0KWyAgNV0gICA4LjAwLTkuMDAgICBzZWMgIDEwLjIgTUJ5dGVzICA4NS41IE1iaXRzL3NlYyAg
ICAwICAgIDEwMCBLQnl0ZXMNClsgIDVdICAgOS4wMC0xMC4wMCAgc2VjICA5LjY5IE1CeXRlcyAg
ODEuMyBNYml0cy9zZWMgICAgMCAgICAxMDAgS0J5dGVzDQotIC0gLSAtIC0gLSAtIC0gLSAtIC0g
LSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtDQpbIElEXSBJbnRlcnZhbCAgICAgICAgICAgVHJh
bnNmZXIgICAgIEJpdHJhdGUgICAgICAgICBSZXRyDQpbICA1XSAgIDAuMDAtMTAuMDAgIHNlYyAg
IDEwMSBNQnl0ZXMgIDg0LjQgTWJpdHMvc2VjICAgIDAgICAgICAgICAgICAgc2VuZGVyDQpbICA1
XSAgIDAuMDAtOS45MiAgIHNlYyAgIDEwMCBNQnl0ZXMgIDg0LjggTWJpdHMvc2VjICAgICAgICAg
ICAgICAgICAgcmVjZWl2ZXINCg0KMy4xIGkuTVg4TU0gd2l0aCB0eCByaW5nIHNpemUgNTEyDQpy
b290QGlteDhtbWV2azp+IyBpcGVyZjMgLWMgMTkyLjE2OC4zLjYNCkNvbm5lY3RpbmcgdG8gaG9z
dCAxOTIuMTY4LjMuNiwgcG9ydCA1MjAxDQpbICA1XSBsb2NhbCAxOTIuMTY4LjMuOSBwb3J0IDU1
NzM0IGNvbm5lY3RlZCB0byAxOTIuMTY4LjMuNiBwb3J0IDUyMDENClsgSURdIEludGVydmFsICAg
ICAgICAgICBUcmFuc2ZlciAgICAgQml0cmF0ZSAgICAgICAgIFJldHIgIEN3bmQNClsgIDVdICAg
MC4wMC0xLjAwICAgc2VjICAgMTExIE1CeXRlcyAgIDkzNCBNYml0cy9zZWMgICAgMCAgICA1Nzcg
S0J5dGVzDQpbICA1XSAgIDEuMDAtMi4wMCAgIHNlYyAgIDExMiBNQnl0ZXMgICA5MzcgTWJpdHMv
c2VjICAgIDAgICAgNTc3IEtCeXRlcw0KWyAgNV0gICAyLjAwLTMuMDAgICBzZWMgICAxMTIgTUJ5
dGVzICAgOTQyIE1iaXRzL3NlYyAgICAwICAgIDYwOSBLQnl0ZXMNClsgIDVdICAgMy4wMC00LjAw
ICAgc2VjICAgMTEzIE1CeXRlcyAgIDk0NSBNYml0cy9zZWMgICAgMCAgICA2MzggS0J5dGVzDQpb
ICA1XSAgIDQuMDAtNS4wMCAgIHNlYyAgIDExMiBNQnl0ZXMgICA5NDEgTWJpdHMvc2VjICAgIDAg
ICAgNjM4IEtCeXRlcw0KWyAgNV0gICA1LjAwLTYuMDAgICBzZWMgICAxMTIgTUJ5dGVzICAgOTQy
IE1iaXRzL3NlYyAgICAwICAgIDYzOCBLQnl0ZXMNClsgIDVdICAgNi4wMC03LjAwICAgc2VjICAg
MTEyIE1CeXRlcyAgIDk0MiBNYml0cy9zZWMgICAgMCAgICA2MzggS0J5dGVzDQpbICA1XSAgIDcu
MDAtOC4wMCAgIHNlYyAgIDExMiBNQnl0ZXMgICA5NDMgTWJpdHMvc2VjICAgIDAgICAgNjM4IEtC
eXRlcw0KWyAgNV0gICA4LjAwLTkuMDAgICBzZWMgICAxMTIgTUJ5dGVzICAgOTQzIE1iaXRzL3Nl
YyAgICAwICAgIDYzOCBLQnl0ZXMNClsgIDVdICAgOS4wMC0xMC4wMCAgc2VjICAgMTEyIE1CeXRl
cyAgIDk0MiBNYml0cy9zZWMgICAgMCAgICA2MzggS0J5dGVzDQotIC0gLSAtIC0gLSAtIC0gLSAt
IC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtDQpbIElEXSBJbnRlcnZhbCAgICAgICAgICAg
VHJhbnNmZXIgICAgIEJpdHJhdGUgICAgICAgICBSZXRyDQpbICA1XSAgIDAuMDAtMTAuMDAgIHNl
YyAgMS4xMCBHQnl0ZXMgICA5NDEgTWJpdHMvc2VjICAgIDAgICAgICAgICAgICAgc2VuZGVyDQpb
ICA1XSAgIDAuMDAtMTAuMDAgIHNlYyAgMS4wOSBHQnl0ZXMgICA5MzggTWJpdHMvc2VjICAgICAg
ICAgICAgICAgICAgcmVjZWl2ZXINCg0KMy4yIGkuTVg4TU0gd2l0aCB0eCByaW5nIHNpemUgMTAy
NA0Kcm9vdEBpbXg4bW1ldms6fiMgaXBlcmYzIC1jIDE5Mi4xNjguMy42DQpDb25uZWN0aW5nIHRv
IGhvc3QgMTkyLjE2OC4zLjYsIHBvcnQgNTIwMQ0KWyAgNV0gbG9jYWwgMTkyLjE2OC4zLjkgcG9y
dCA1MzM1MCBjb25uZWN0ZWQgdG8gMTkyLjE2OC4zLjYgcG9ydCA1MjAxDQpbIElEXSBJbnRlcnZh
bCAgICAgICAgICAgVHJhbnNmZXIgICAgIEJpdHJhdGUgICAgICAgICBSZXRyICBDd25kDQpbICA1
XSAgIDAuMDAtMS4wMCAgIHNlYyAgIDExNCBNQnl0ZXMgICA5NTIgTWJpdHMvc2VjICAgIDAgICAg
NTg1IEtCeXRlcw0KWyAgNV0gICAxLjAwLTIuMDAgICBzZWMgICAxMTIgTUJ5dGVzICAgOTQyIE1i
aXRzL3NlYyAgICAwICAgIDU4NSBLQnl0ZXMNClsgIDVdICAgMi4wMC0zLjAwICAgc2VjICAgMTEz
IE1CeXRlcyAgIDk0NyBNYml0cy9zZWMgICAgMCAgICA1ODUgS0J5dGVzDQpbICA1XSAgIDMuMDAt
NC4wMCAgIHNlYyAgIDExMiBNQnl0ZXMgICA5NDAgTWJpdHMvc2VjICAgIDAgICAgNjQ4IEtCeXRl
cw0KWyAgNV0gICA0LjAwLTUuMDAgICBzZWMgICAxMTIgTUJ5dGVzICAgOTQ0IE1iaXRzL3NlYyAg
ICAwICAgIDY0OCBLQnl0ZXMNClsgIDVdICAgNS4wMC02LjAwICAgc2VjICAgMTEyIE1CeXRlcyAg
IDk0NCBNYml0cy9zZWMgICAgMCAgICA2NDggS0J5dGVzDQpbICA1XSAgIDYuMDAtNy4wMCAgIHNl
YyAgIDExMSBNQnl0ZXMgICA5MzMgTWJpdHMvc2VjICAgIDAgICAgNjQ4IEtCeXRlcw0KWyAgNV0g
ICA3LjAwLTguMDAgICBzZWMgICAxMTIgTUJ5dGVzICAgOTQ0IE1iaXRzL3NlYyAgICAwICAgIDY0
OCBLQnl0ZXMNClsgIDVdICAgOC4wMC05LjAwICAgc2VjICAgMTEyIE1CeXRlcyAgIDk0NCBNYml0
cy9zZWMgICAgMCAgICA2NDggS0J5dGVzDQpbICA1XSAgIDkuMDAtMTAuMDAgIHNlYyAgIDExMiBN
Qnl0ZXMgICA5NDQgTWJpdHMvc2VjICAgIDAgICAgNjQ4IEtCeXRlcw0KLSAtIC0gLSAtIC0gLSAt
IC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLQ0KWyBJRF0gSW50ZXJ2YWwgICAgICAg
ICAgIFRyYW5zZmVyICAgICBCaXRyYXRlICAgICAgICAgUmV0cg0KWyAgNV0gICAwLjAwLTEwLjAw
ICBzZWMgIDEuMTAgR0J5dGVzICAgOTQzIE1iaXRzL3NlYyAgICAwICAgICAgICAgICAgIHNlbmRl
cg0KWyAgNV0gICAwLjAwLTEwLjAwICBzZWMgIDEuMDkgR0J5dGVzICAgOTQwIE1iaXRzL3NlYyAg
ICAgICAgICAgICAgICAgIHJlY2VpdmVyDQoNCjQuMSBpLk1YOE1QIHdpdGggdHggcmluZyBzaXpl
IDUxMg0Kcm9vdEBpbXg4bXBldms6fiMgaXBlcmYzIC1jIDE5Mi4xNjguMy42DQpDb25uZWN0aW5n
IHRvIGhvc3QgMTkyLjE2OC4zLjYsIHBvcnQgNTIwMQ0KWyAgNV0gbG9jYWwgMTkyLjE2OC4zLjkg
cG9ydCA1MTg5MiBjb25uZWN0ZWQgdG8gMTkyLjE2OC4zLjYgcG9ydCA1MjAxDQpbIElEXSBJbnRl
cnZhbCAgICAgICAgICAgVHJhbnNmZXIgICAgIEJpdHJhdGUgICAgICAgICBSZXRyICBDd25kDQpb
ICA1XSAgIDAuMDAtMS4wMCAgIHNlYyAgIDExNCBNQnl0ZXMgICA5NTkgTWJpdHMvc2VjICAgIDAg
ICAgNTk0IEtCeXRlcw0KWyAgNV0gICAxLjAwLTIuMDAgICBzZWMgICAxMTIgTUJ5dGVzICAgOTQw
IE1iaXRzL3NlYyAgICAwICAgIDYyNiBLQnl0ZXMNClsgIDVdICAgMi4wMC0zLjAwICAgc2VjICAg
MTEzIE1CeXRlcyAgIDk0NiBNYml0cy9zZWMgICAgMCAgICA2MjYgS0J5dGVzDQpbICA1XSAgIDMu
MDAtNC4wMCAgIHNlYyAgIDExMiBNQnl0ZXMgICA5MzcgTWJpdHMvc2VjICAgIDAgICAgNjI2IEtC
eXRlcw0KWyAgNV0gICA0LjAwLTUuMDAgICBzZWMgICAxMTIgTUJ5dGVzICAgOTQwIE1iaXRzL3Nl
YyAgICAwICAgIDYyNiBLQnl0ZXMNClsgIDVdICAgNS4wMC02LjAwICAgc2VjICAgMTEyIE1CeXRl
cyAgIDk0MCBNYml0cy9zZWMgICAgMCAgICA2MjYgS0J5dGVzDQpbICA1XSAgIDYuMDAtNy4wMCAg
IHNlYyAgIDExMyBNQnl0ZXMgICA5NDYgTWJpdHMvc2VjICAgIDAgICAgNjI2IEtCeXRlcw0KWyAg
NV0gICA3LjAwLTguMDAgICBzZWMgICAxMTIgTUJ5dGVzICAgOTM5IE1iaXRzL3NlYyAgICAwICAg
IDYyNiBLQnl0ZXMNClsgIDVdICAgOC4wMC05LjAwICAgc2VjICAgMTExIE1CeXRlcyAgIDkzNSBN
Yml0cy9zZWMgICAgMCAgICA2MjYgS0J5dGVzDQpbICA1XSAgIDkuMDAtMTAuMDAgIHNlYyAgIDEx
MiBNQnl0ZXMgICA5NDMgTWJpdHMvc2VjICAgIDAgICAgNjI2IEtCeXRlcw0KLSAtIC0gLSAtIC0g
LSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLQ0KWyBJRF0gSW50ZXJ2YWwgICAg
ICAgICAgIFRyYW5zZmVyICAgICBCaXRyYXRlICAgICAgICAgUmV0cg0KWyAgNV0gICAwLjAwLTEw
LjAwICBzZWMgIDEuMTAgR0J5dGVzICAgOTQzIE1iaXRzL3NlYyAgICAwICAgICAgICAgICAgIHNl
bmRlcg0KWyAgNV0gICAwLjAwLTEwLjAwICBzZWMgIDEuMDkgR0J5dGVzICAgOTQwIE1iaXRzL3Nl
YyAgICAgICAgICAgICAgICAgIHJlY2VpdmVyDQoNCjQuMiBpLk1YOE1QIHdpdGggdHggcmluZyBz
aXplIDEwMjQNCnJvb3RAaW14OG1wZXZrOn4jIGlwZXJmMyAtYyAxOTIuMTY4LjMuNg0KQ29ubmVj
dGluZyB0byBob3N0IDE5Mi4xNjguMy42LCBwb3J0IDUyMDENClsgIDVdIGxvY2FsIDE5Mi4xNjgu
My45IHBvcnQgMzc5MjIgY29ubmVjdGVkIHRvIDE5Mi4xNjguMy42IHBvcnQgNTIwMQ0KWyBJRF0g
SW50ZXJ2YWwgICAgICAgICAgIFRyYW5zZmVyICAgICBCaXRyYXRlICAgICAgICAgUmV0ciAgQ3du
ZA0KWyAgNV0gICAwLjAwLTEuMDAgICBzZWMgICAxMTMgTUJ5dGVzICAgOTUxIE1iaXRzL3NlYyAg
ICAwICAgIDYwOCBLQnl0ZXMNClsgIDVdICAgMS4wMC0yLjAwICAgc2VjICAgMTEyIE1CeXRlcyAg
IDkzNyBNYml0cy9zZWMgICAgMCAgICA2MDggS0J5dGVzDQpbICA1XSAgIDIuMDAtMy4wMCAgIHNl
YyAgIDExMyBNQnl0ZXMgICA5NDcgTWJpdHMvc2VjICAgIDAgICAgNjA4IEtCeXRlcw0KWyAgNV0g
ICAzLjAwLTQuMDAgICBzZWMgICAxMTEgTUJ5dGVzICAgOTM0IE1iaXRzL3NlYyAgICAwICAgIDYw
OCBLQnl0ZXMNClsgIDVdICAgNC4wMC01LjAwICAgc2VjICAgMTEyIE1CeXRlcyAgIDk0MiBNYml0
cy9zZWMgICAgMCAgICA2MDggS0J5dGVzDQpbICA1XSAgIDUuMDAtNi4wMCAgIHNlYyAgIDExMiBN
Qnl0ZXMgICA5MzkgTWJpdHMvc2VjICAgIDAgICAgNjA4IEtCeXRlcw0KWyAgNV0gICA2LjAwLTcu
MDAgICBzZWMgICAxMTMgTUJ5dGVzICAgOTQ5IE1iaXRzL3NlYyAgICAwICAgIDYwOCBLQnl0ZXMN
ClsgIDVdICAgNy4wMC04LjAwICAgc2VjICAgMTEyIE1CeXRlcyAgIDk0MiBNYml0cy9zZWMgICAg
MCAgICA2MDggS0J5dGVzDQpbICA1XSAgIDguMDAtOS4wMCAgIHNlYyAgIDExMiBNQnl0ZXMgICA5
MzYgTWJpdHMvc2VjICAgIDAgICAgNjA4IEtCeXRlcw0KWyAgNV0gICA5LjAwLTEwLjAwICBzZWMg
ICAxMTIgTUJ5dGVzICAgOTQyIE1iaXRzL3NlYyAgICAwICAgIDYwOCBLQnl0ZXMNCi0gLSAtIC0g
LSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0NClsgSURdIEludGVydmFs
ICAgICAgICAgICBUcmFuc2ZlciAgICAgQml0cmF0ZSAgICAgICAgIFJldHINClsgIDVdICAgMC4w
MC0xMC4wMCAgc2VjICAxLjEwIEdCeXRlcyAgIDk0MiBNYml0cy9zZWMgICAgMCAgICAgICAgICAg
ICBzZW5kZXINClsgIDVdICAgMC4wMC0xMC4wMCAgc2VjICAxLjA5IEdCeXRlcyAgIDkzOSBNYml0
cy9zZWMgICAgICAgICAgICAgICAgICByZWNlaXZlcg0KDQo1LjEgaS5NWDkzIHdpdGggdHggcmlu
ZyBzaXplIDUxMg0Kcm9vdEBpbXg5M2V2azp+IyBpcGVyZjMgLWMgMTkyLjE2OC4zLjYNCkNvbm5l
Y3RpbmcgdG8gaG9zdCAxOTIuMTY4LjMuNiwgcG9ydCA1MjAxDQpbICA1XSBsb2NhbCAxOTIuMTY4
LjMuOSBwb3J0IDQ0MjE2IGNvbm5lY3RlZCB0byAxOTIuMTY4LjMuNiBwb3J0IDUyMDENClsgSURd
IEludGVydmFsICAgICAgICAgICBUcmFuc2ZlciAgICAgQml0cmF0ZSAgICAgICAgIFJldHIgIEN3
bmQNClsgIDVdICAgMC4wMC0xLjAwICAgc2VjICAgMTE1IE1CeXRlcyAgIDk2NSBNYml0cy9zZWMg
ICAgMCAgICA2NTYgS0J5dGVzDQpbICA1XSAgIDEuMDAtMi4wMCAgIHNlYyAgIDExMSBNQnl0ZXMg
ICA5MzQgTWJpdHMvc2VjICAgIDAgICAgNjU2IEtCeXRlcw0KWyAgNV0gICAyLjAwLTMuMDAgICBz
ZWMgICAxMTIgTUJ5dGVzICAgOTQ0IE1iaXRzL3NlYyAgICAwICAgIDY1NiBLQnl0ZXMNClsgIDVd
ICAgMy4wMC00LjAwICAgc2VjICAgMTEyIE1CeXRlcyAgIDk0NCBNYml0cy9zZWMgICAgMCAgICA2
NTYgS0J5dGVzDQpbICA1XSAgIDQuMDAtNS4wMCAgIHNlYyAgIDExMiBNQnl0ZXMgICA5NDQgTWJp
dHMvc2VjICAgIDAgICAgNjU2IEtCeXRlcw0KWyAgNV0gICA1LjAwLTYuMDAgICBzZWMgICAxMTEg
TUJ5dGVzICAgOTMzIE1iaXRzL3NlYyAgICAwICAgIDY1NiBLQnl0ZXMNClsgIDVdICAgNi4wMC03
LjAwICAgc2VjICAgMTEyIE1CeXRlcyAgIDk0NCBNYml0cy9zZWMgICAgMCAgICA2NTYgS0J5dGVz
DQpbICA1XSAgIDcuMDAtOC4wMCAgIHNlYyAgIDExMiBNQnl0ZXMgICA5NDQgTWJpdHMvc2VjICAg
IDAgICAgNjU2IEtCeXRlcw0KWyAgNV0gICA4LjAwLTkuMDAgICBzZWMgICAxMTIgTUJ5dGVzICAg
OTQ0IE1iaXRzL3NlYyAgICAwICAgIDY1NiBLQnl0ZXMNClsgIDVdICAgOS4wMC0xMC4wMCAgc2Vj
ICAgMTEyIE1CeXRlcyAgIDk0NCBNYml0cy9zZWMgICAgMCAgICA2NTYgS0J5dGVzDQotIC0gLSAt
IC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtDQpbIElEXSBJbnRlcnZh
bCAgICAgICAgICAgVHJhbnNmZXIgICAgIEJpdHJhdGUgICAgICAgICBSZXRyDQpbICA1XSAgIDAu
MDAtMTAuMDAgIHNlYyAgMS4xMCBHQnl0ZXMgICA5NDQgTWJpdHMvc2VjICAgIDAgICAgICAgICAg
ICAgc2VuZGVyDQpbICA1XSAgIDAuMDAtMTAuMDAgIHNlYyAgMS4xMCBHQnl0ZXMgICA5NDEgTWJp
dHMvc2VjICAgICAgICAgICAgICAgICAgcmVjZWl2ZXINCg0KNS4yIGkuTVg5MyB3aXRoIHR4IHJp
bmcgc2l6ZSAxMDI0DQpyb290QGlteDkzZXZrOn4jIGlwZXJmMyAtYyAxOTIuMTY4LjMuNg0KQ29u
bmVjdGluZyB0byBob3N0IDE5Mi4xNjguMy42LCBwb3J0IDUyMDENClsgIDVdIGxvY2FsIDE5Mi4x
NjguMy45IHBvcnQgNTEwNTggY29ubmVjdGVkIHRvIDE5Mi4xNjguMy42IHBvcnQgNTIwMQ0KWyBJ
RF0gSW50ZXJ2YWwgICAgICAgICAgIFRyYW5zZmVyICAgICBCaXRyYXRlICAgICAgICAgUmV0ciAg
Q3duZA0KWyAgNV0gICAwLjAwLTEuMDAgICBzZWMgICAxMTQgTUJ5dGVzICAgOTU5IE1iaXRzL3Nl
YyAgICAwICAgIDU4OCBLQnl0ZXMNClsgIDVdICAgMS4wMC0yLjAwICAgc2VjICAgMTEyIE1CeXRl
cyAgIDkzNSBNYml0cy9zZWMgICAgMCAgICA2NDkgS0J5dGVzDQpbICA1XSAgIDIuMDAtMy4wMCAg
IHNlYyAgIDExMiBNQnl0ZXMgICA5NDQgTWJpdHMvc2VjICAgIDAgICAgNjQ5IEtCeXRlcw0KWyAg
NV0gICAzLjAwLTQuMDAgICBzZWMgICAxMTIgTUJ5dGVzICAgOTQ0IE1iaXRzL3NlYyAgICAwICAg
IDY0OSBLQnl0ZXMNClsgIDVdICAgNC4wMC01LjAwICAgc2VjICAgMTEyIE1CeXRlcyAgIDk0NCBN
Yml0cy9zZWMgICAgMCAgICA2NDkgS0J5dGVzDQpbICA1XSAgIDUuMDAtNi4wMCAgIHNlYyAgIDEx
MiBNQnl0ZXMgICA5NDQgTWJpdHMvc2VjICAgIDAgICAgNjQ5IEtCeXRlcw0KWyAgNV0gICA2LjAw
LTcuMDAgICBzZWMgICAxMTEgTUJ5dGVzICAgOTMzIE1iaXRzL3NlYyAgICAwICAgIDY0OSBLQnl0
ZXMNClsgIDVdICAgNy4wMC04LjAwICAgc2VjICAgMTEyIE1CeXRlcyAgIDk0NCBNYml0cy9zZWMg
ICAgMCAgICA2NDkgS0J5dGVzDQpbICA1XSAgIDguMDAtOS4wMCAgIHNlYyAgIDExMiBNQnl0ZXMg
ICA5NDQgTWJpdHMvc2VjICAgIDAgICAgNjQ5IEtCeXRlcw0KWyAgNV0gICA5LjAwLTEwLjAwICBz
ZWMgICAxMTIgTUJ5dGVzICAgOTQ0IE1iaXRzL3NlYyAgICAwICAgIDY0OSBLQnl0ZXMNCi0gLSAt
IC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0NClsgSURdIEludGVy
dmFsICAgICAgICAgICBUcmFuc2ZlciAgICAgQml0cmF0ZSAgICAgICAgIFJldHINClsgIDVdICAg
MC4wMC0xMC4wMCAgc2VjICAxLjEwIEdCeXRlcyAgIDk0MyBNYml0cy9zZWMgICAgMCAgICAgICAg
ICAgICBzZW5kZXINClsgIDVdICAgMC4wMC0xMC4wMCAgc2VjICAxLjEwIEdCeXRlcyAgIDk0MCBN
Yml0cy9zZWMgICAgICAgICAgICAgICAgICByZWNlaXZlcg0K

