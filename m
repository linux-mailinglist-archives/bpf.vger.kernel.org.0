Return-Path: <bpf+bounces-16993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8658081BF
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 08:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F3321C21711
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 07:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE569179AD;
	Thu,  7 Dec 2023 07:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gdn8UMD4"
X-Original-To: bpf@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2066.outbound.protection.outlook.com [40.107.6.66])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDC8137;
	Wed,  6 Dec 2023 23:19:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTe+MAISuMCiSd6CHo/JpiexRMSEZ6DGRpydZNXHs0ERWN0CpRDrYgQsyKx+65cG8+G3rJZQms82K020ldvD34mRdzC6IsJHnefY4vbiJVGE30vGtEhWF8eeEq+xdIFONxmVBZuHOIOowTkjeIxWJy3+5fs8DHcLQc++b/VJpdNB2Jsg1qj9zIuvFzwKMrVx399tHEgtJn/frBZrU+QeKQHpYrOKtLQGlChhtEHI7kACF+KjeUlHZdeJpsp1HhKPXHG5qR1Q1WzN2UutbvOs/5duvdZIN1uBQxXiF/y047dJhKSxTIb7OCLAgcvsVpVOq9a8VGWdqbmbgiBA2ueETA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQbKgIVI+GFkxa/L7JfADXBMj9+xWD2x5OuhBed+7R0=;
 b=gxtiLDEtoe4IWb7MCvyA+4PPY9jb6F16UN2qq/BUaWkll2+GXnqSHsBzBaVVq9Qt98dyUxHD996a2i2YFbaZht+Zs8yOSlErR/peboUFFnQNE0e02RMcW1fgOhfPvWpqVtFG2Wi2GCU69HuAho11JwCrQ6kzpZnS3AUxT/BDrtmvxj3GJXs7IG+jFXzYCVbrw8B901jrwYV+x+6PPKIknChu6BNMUZw2uiAhnFAyqcQLMkXjd0lAs92UaJ1MQWspnZBiO+PQRU5bdAD12bQt6T809oRLYMi3wndYxBYyDlAU9OMdEEvXx+fGlJEnCbZo6QlQdiKIC1IonA6T9v9gfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQbKgIVI+GFkxa/L7JfADXBMj9+xWD2x5OuhBed+7R0=;
 b=Gdn8UMD4hKoJJDSaYRexGAdvwxRThUbdzHg8xh3EPvov0DjqQAQIqg3pyuj/GEUpXJLREIUQvQCtFw8YkoBs/TSD6iG34Efs3BwWIJazDxlr3tpFpfa9j3/QdhbjRqLVAfiWloVn0gQ4SKcgQFKJSpuae9ouUfNNEQWvP7XAhEA=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.26; Thu, 7 Dec
 2023 07:19:56 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::d6ee:d372:176b:1786]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::d6ee:d372:176b:1786%5]) with mapi id 15.20.7068.026; Thu, 7 Dec 2023
 07:19:56 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "justinstitt@google.com" <justinstitt@google.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shay Agroskin
	<shayagr@amazon.com>, Arthur Kiyanovski <akiyano@amazon.com>, David Arinzon
	<darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>, Saeed Bishara
	<saeedb@amazon.com>, Rasesh Mody <rmody@marvell.com>, Sudarsana Kalluru
	<skalluru@marvell.com>, "GR-Linux-NIC-Dev@marvell.com"
	<GR-Linux-NIC-Dev@marvell.com>, Dimitris Michailidis <dmichail@fungible.com>,
	Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Louis Peens <louis.peens@corigine.com>, Shannon
 Nelson <shannon.nelson@amd.com>, Brett Creeley <brett.creeley@amd.com>,
	"drivers@pensando.io" <drivers@pensando.io>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Ronak Doshi
	<doshir@vmware.com>, VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Dwaipayan
 Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, Hauke
 Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
	<f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>, Daniel Golle
	<daniel@makrotopia.org>, Landen Chao <Landen.Chao@mediatek.com>, DENG
 Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Linus Walleij
	<linus.walleij@linaro.org>, =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?=
	<alsi@bang-olufsen.dk>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, dl-linux-imx <linux-imx@nxp.com>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>, "UNGLinuxDriver@microchip.com"
	<UNGLinuxDriver@microchip.com>, Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan
 Lou <mengyuanlou@net-swift.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
	<hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Nick Desaulniers
	<ndesaulniers@google.com>, Nathan Chancellor <nathan@kernel.org>, Kees Cook
	<keescook@chromium.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "oss-drivers@corigine.com"
	<oss-drivers@corigine.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>
Subject: RE: [PATCH net-next v5 3/3] net: Convert some ethtool_sprintf() to
 ethtool_puts()
Thread-Topic: [PATCH net-next v5 3/3] net: Convert some ethtool_sprintf() to
 ethtool_puts()
Thread-Index: AQHaKJo5wFQFbv+VkUSy8LnWqnhMTbCdaX4g
Date: Thu, 7 Dec 2023 07:19:56 +0000
Message-ID:
 <AM5PR04MB31397A652DD88CE04078B569888BA@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20231206-ethtool_puts_impl-v5-0-5a2528e17bf8@google.com>
 <20231206-ethtool_puts_impl-v5-3-5a2528e17bf8@google.com>
In-Reply-To: <20231206-ethtool_puts_impl-v5-3-5a2528e17bf8@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|PA4PR04MB7982:EE_
x-ms-office365-filtering-correlation-id: 31d38b83-8202-4cfb-fd38-08dbf6f4ea2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 V1nSTyP8D9C3iKIMj0O2Iu0ONwkODNL3ZzZsEjSOvoW7b4m68IBvoJb5+npBGwEpFBRqgtTST4WRU/81T3LyGUSRUXFtN4hf8loe+aMXKlA2Qn7dvhN5CA+RwUZOBUCbJ+3IKiIA6G3F+OJdk4t+dVB1YKP+BYmvqOdNY2Aa467YY6L5f3HSooyGJjbdc3pKTRQRDzqJRdP/y1nlAkISceJCZ3BNr5RTuGDN459op62XTj1VlPwvKv12TAiWxnfy0ozg97eyOhiH2H8q8dZtJSRGSfFieLAx+0rUk4//jlTBimXK/xvoqQhnGmFXqFCfWRdgtjxbKyJsfP7uCwCEv3f2PEV3uJJV2zs0TYkCKvbywCQh2AYj5O1x4x3N3HSs8SwVmlFPEboF2qIgXE7Sv/UCt9X1+n+AfFBRQvzenighd2ckOXXlaijxDAZxXyMEtBAhF0ap/+mNFxPOyjBiV9JPkpkSpl578TI3SHb3O8QYZ7zkTpb+6vwZZQWJzUVtx78g6j+IhPKj9wtkDkqana3mK5/qCkGgXoCVWCCxa8ysZF9nx2xcBpLI6/8aTheKKApWQwBg3+8xTBwW07NTfcLjfxhjkHG7XrE6GEYNxda0qapdjnVlQSc7l0MzIXMikEDpbo6+C1RrKbErYM61gQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39860400002)(346002)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(38100700002)(122000001)(55016003)(8936002)(1191002)(66556008)(4326008)(8676002)(7696005)(110136005)(66446008)(71200400001)(52536014)(64756008)(66476007)(66946007)(76116006)(54906003)(86362001)(316002)(38070700009)(7416002)(5660300002)(53546011)(44832011)(7406005)(6506007)(7366002)(33656002)(9686003)(2906002)(478600001)(921008)(26005)(41300700001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bDYvQW1aZ0p2MnJ2ZWVlR1B6MWpmaXdGL3IxalJ2RGJ1bVZycUk5UVdRTDFU?=
 =?utf-8?B?ZXE0UnpuNUllZ05OMHlFLzBuVFpMYmhnM0tIYXIwaG1Zc2R4QklDMTJGejBZ?=
 =?utf-8?B?MjR4eTdDZkpTRlpXRU9PTW0xc3FRalVpMk1melZpV1ZkUS9iUC94dzNoZTA2?=
 =?utf-8?B?MjNTc1RWQVJrYXJzSTNTYzJFODZRWGk3RUxaellybCtwK3pLdTFBZ1AwdEJ1?=
 =?utf-8?B?SjJZWnp0SThNbU9rSkhiZ29FQW9ZQnNWam5MTmZvUldiSWkwQ0tKUE94M2FZ?=
 =?utf-8?B?RHErcjFVZDdjVHVKS2VDUUpOWHBySkx2T1hHV3pFUkxpalZrSURlYStXaFBN?=
 =?utf-8?B?d3JjZXZVMS9iOE5Xd1RsNEZ6NkU4R1QrSEN4Y3FJRWNjTXVjNlFVbzZvbmdS?=
 =?utf-8?B?eFVvVVBKdkhqaFFjcGRjOXNLQ00zRkYvcXNaSisraHJrRW81cHlhS3QySVF6?=
 =?utf-8?B?Rms2cG1TcG1TR3E3cUEvN2J5WWVtMXlMNmtyRkRSSTdGNTNEMnBvdGNpZ0RZ?=
 =?utf-8?B?VEdiUk9PUkEvREZLRFA1amRFY2ZFUElXRWovOTJpVThWckRBZ0VEYk1vZFhr?=
 =?utf-8?B?MW5jOFo5eSt4UXBKS05YdGl4SER6a1h1YXFGa3phV3llalBUSnlRMFhTR3Ry?=
 =?utf-8?B?ZUlwdktLb0RNRTNKWHZCZGkwd1VkK0pDTjBSUFpjRmpRQTZXVFMrN1VabmQr?=
 =?utf-8?B?eHh2S2hNR3BReXF4aEZtQ2ZhSlg5Wkw4dG9aN0QyWnlYUG5oMzNEd0NmVnA2?=
 =?utf-8?B?Z1FpUlU1a1lOVGhLUllUUmhnMnFISFkwMWQ2RnU2bUUwTC9WclpJUzBrb0d6?=
 =?utf-8?B?b1RXVnBYYlJWTC9ZSllSblI1dUwvVnRKN2hxdkVHODVvQUFPb3FmMHRvMDZR?=
 =?utf-8?B?WVIyN0pWV3doK0ZQQkZobVRhNW1OTk9JVTVQSllqaEsxMGxhYUZ1QWFITW1M?=
 =?utf-8?B?cTlKdENCZ09ZMncrR1g5Y2FCTmtjdnBXRHIrQUlZdGdsNGRDb2ZKOW1JR2xI?=
 =?utf-8?B?ZzFCNTJ2ajJKUUFXSWhjL3JBVHExUisxb3hSL1NkQkd1eW9uSlZZZVRncDFW?=
 =?utf-8?B?RGxwVDlWdkovVWp3T1pzVzlybUZYOHVCTm0xU3ZYUmgycjZRUysraEEyams2?=
 =?utf-8?B?SW1ncHloQWtPbXVLcnpoT2VteUExREdLY1VUekhRRldQRXQ5dVp4NnJKZkhI?=
 =?utf-8?B?QitYOHJMRDZDUFg2aHMvMjhKYzFOVmlPem9zWXlWazVmcGVXa0tPYjRYMVN6?=
 =?utf-8?B?OXJFRHMwejhIdkpQYjc3ZFEzYzZaVkd4TlR3ZzJHTHFGYWpwYjNhejY0c2Q1?=
 =?utf-8?B?MWpReldTdXFnUEpHZlFQQXk4ZkU4ZzhYWU5ZWXhoemtVcmMzd3NoOHorN0lZ?=
 =?utf-8?B?SFVuajBtKzBKZGZBeVRtYjZlMFhFSEpxTWVMaXZrSHhjWEVXWEpDT1B4TDRQ?=
 =?utf-8?B?TTV5OWwvRlFxWTNlVGpmRnd6YlNZTEMxR2Jic2ltN3g1OW1vbFF4aG9HdXNF?=
 =?utf-8?B?Si9oZWprSkpNcmVuczFUcm9neXU2M0g5a2d4RmFXSDJSbnh0RTd0ZG40MkRT?=
 =?utf-8?B?Q01DbEpZNllxcG5WUVZvaGJ0MkwxeVhPUERhTS9ENndKUnZzZHhEVm01Vm1X?=
 =?utf-8?B?SVNXcWlieEtlZTN0RHpwUTJ3NlJ5a1ZYMlNVVGxaa0NKYVNuWXhpUjAyWHE0?=
 =?utf-8?B?RHlES1Vzd0tVOWJNMXVLa2xBSTg5QzBTcU8zS3FlTEliN3lhWEJjUVp5bk1n?=
 =?utf-8?B?YlBpQjduUzlQQlIvZlFWbERDa0NsMFQ4TWR3cG9yRW1saTc3WUp3cGJjc0d5?=
 =?utf-8?B?SEJ2SWsyRHFDbENpT1B5OU1UN3ZlR3I4TjlzMUhzRDQzemlSNFBudzJjM3RR?=
 =?utf-8?B?bDNOZFA3cjN0TVRENnZvRWhjV292YzZpdUNzN05OdHVlR09xd05keFhxWS9q?=
 =?utf-8?B?ZHk2bUk4NmI2VFFwaDRUcnJzaERaMENFOVA5U0plQVZ3K0ZyWExreWRWU0lJ?=
 =?utf-8?B?V1VpOEt2ZlhYN2VXMDZqKzU5VHpTa2oyYzN5ZXdlZlZDVHJPRnFsRWlDZjBR?=
 =?utf-8?B?TzQzbjQzNDFCNkU5aC9yUG1jeThYMVZnV25KWEtUTGxnSjRtOHlUbUxNYlJm?=
 =?utf-8?Q?uczU=3D?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d38b83-8202-4cfb-fd38-08dbf6f4ea2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 07:19:56.4014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zuoHTbz0LKEvrM6umtgnCBTK4mOcx3fjp2ITnoFUVCjGG+ALd5pHYyjHP3nkMPOeT1rPqAjphaYqEpyqTFzPBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7982

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBqdXN0aW5zdGl0dEBnb29nbGUu
Y29tIDxqdXN0aW5zdGl0dEBnb29nbGUuY29tPg0KPiBTZW50OiAyMDIz5bm0MTLmnIg35pelIDc6
MTYNCj4gVG86IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVt
YXpldA0KPiA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5l
bC5vcmc+OyBQYW9sbyBBYmVuaQ0KPiA8cGFiZW5pQHJlZGhhdC5jb20+OyBTaGF5IEFncm9za2lu
IDxzaGF5YWdyQGFtYXpvbi5jb20+OyBBcnRodXINCj4gS2l5YW5vdnNraSA8YWtpeWFub0BhbWF6
b24uY29tPjsgRGF2aWQgQXJpbnpvbg0KPiA8ZGFyaW56b25AYW1hem9uLmNvbT47IE5vYW0gRGFn
YW4gPG5kYWdhbkBhbWF6b24uY29tPjsgU2FlZWQNCj4gQmlzaGFyYSA8c2FlZWRiQGFtYXpvbi5j
b20+OyBSYXNlc2ggTW9keSA8cm1vZHlAbWFydmVsbC5jb20+Ow0KPiBTdWRhcnNhbmEgS2FsbHVy
dSA8c2thbGx1cnVAbWFydmVsbC5jb20+OyBHUi1MaW51eC1OSUMtRGV2QG1hcnZlbGwuY29tOw0K
PiBEaW1pdHJpcyBNaWNoYWlsaWRpcyA8ZG1pY2hhaWxAZnVuZ2libGUuY29tPjsgWWlzZW4gWmh1
YW5nDQo+IDx5aXNlbi56aHVhbmdAaHVhd2VpLmNvbT47IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0
YUBodWF3ZWkuY29tPjsgSmVzc2UNCj4gQnJhbmRlYnVyZyA8amVzc2UuYnJhbmRlYnVyZ0BpbnRl
bC5jb20+OyBUb255IE5ndXllbg0KPiA8YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBMb3Vp
cyBQZWVucyA8bG91aXMucGVlbnNAY29yaWdpbmUuY29tPjsNCj4gU2hhbm5vbiBOZWxzb24gPHNo
YW5ub24ubmVsc29uQGFtZC5jb20+OyBCcmV0dCBDcmVlbGV5DQo+IDxicmV0dC5jcmVlbGV5QGFt
ZC5jb20+OyBkcml2ZXJzQHBlbnNhbmRvLmlvOyBLLiBZLiBTcmluaXZhc2FuDQo+IDxreXNAbWlj
cm9zb2Z0LmNvbT47IEhhaXlhbmcgWmhhbmcgPGhhaXlhbmd6QG1pY3Jvc29mdC5jb20+OyBXZWkg
TGl1DQo+IDx3ZWkubGl1QGtlcm5lbC5vcmc+OyBEZXh1YW4gQ3VpIDxkZWN1aUBtaWNyb3NvZnQu
Y29tPjsgUm9uYWsgRG9zaGkNCj4gPGRvc2hpckB2bXdhcmUuY29tPjsgVk13YXJlIFBWLURyaXZl
cnMgUmV2aWV3ZXJzDQo+IDxwdi1kcml2ZXJzQHZtd2FyZS5jb20+OyBBbmR5IFdoaXRjcm9mdCA8
YXB3QGNhbm9uaWNhbC5jb20+OyBKb2UNCj4gUGVyY2hlcyA8am9lQHBlcmNoZXMuY29tPjsgRHdh
aXBheWFuIFJheSA8ZHdhaXBheWFucmF5MUBnbWFpbC5jb20+Ow0KPiBMdWthcyBCdWx3YWhuIDxs
dWthcy5idWx3YWhuQGdtYWlsLmNvbT47IEhhdWtlIE1laHJ0ZW5zDQo+IDxoYXVrZUBoYXVrZS1t
LmRlPjsgQW5kcmV3IEx1bm4gPGFuZHJld0BsdW5uLmNoPjsgRmxvcmlhbiBGYWluZWxsaQ0KPiA8
Zi5mYWluZWxsaUBnbWFpbC5jb20+OyBWbGFkaW1pciBPbHRlYW4gPG9sdGVhbnZAZ21haWwuY29t
PjsgQXLEsW7DpyDDnE5BTA0KPiA8YXJpbmMudW5hbEBhcmluYzkuY29tPjsgRGFuaWVsIEdvbGxl
IDxkYW5pZWxAbWFrcm90b3BpYS5vcmc+OyBMYW5kZW4NCj4gQ2hhbyA8TGFuZGVuLkNoYW9AbWVk
aWF0ZWsuY29tPjsgREVORyBRaW5nZmFuZyA8ZHFmZXh0QGdtYWlsLmNvbT47DQo+IFNlYW4gV2Fu
ZyA8c2Vhbi53YW5nQG1lZGlhdGVrLmNvbT47IE1hdHRoaWFzIEJydWdnZXINCj4gPG1hdHRoaWFz
LmJnZ0BnbWFpbC5jb20+OyBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubw0KPiA8YW5nZWxvZ2lv
YWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPjsgTGludXMgV2FsbGVpag0KPiA8bGludXMu
d2FsbGVpakBsaW5hcm8ub3JnPjsgQWx2aW4gxaBpcHJhZ2EgPGFsc2lAYmFuZy1vbHVmc2VuLmRr
PjsgV2VpIEZhbmcNCj4gPHdlaS5mYW5nQG54cC5jb20+OyBTaGVud2VpIFdhbmcgPHNoZW53ZWku
d2FuZ0BueHAuY29tPjsgQ2xhcmsNCj4gV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29tPjsgZGwt
bGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IExhcnMNCj4gUG92bHNlbiA8bGFycy5wb3Zs
c2VuQG1pY3JvY2hpcC5jb20+OyBTdGVlbiBIZWdlbHVuZA0KPiA8U3RlZW4uSGVnZWx1bmRAbWlj
cm9jaGlwLmNvbT47IERhbmllbCBNYWNob24NCj4gPGRhbmllbC5tYWNob25AbWljcm9jaGlwLmNv
bT47IFVOR0xpbnV4RHJpdmVyQG1pY3JvY2hpcC5jb207IEppYXdlbg0KPiBXdSA8amlhd2Vud3VA
dHJ1c3RuZXRpYy5jb20+OyBNZW5neXVhbiBMb3UNCj4gPG1lbmd5dWFubG91QG5ldC1zd2lmdC5j
b20+OyBIZWluZXIgS2FsbHdlaXQgPGhrYWxsd2VpdDFAZ21haWwuY29tPjsNCj4gUnVzc2VsbCBL
aW5nIDxsaW51eEBhcm1saW51eC5vcmcudWs+OyBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFzdEBrZXJu
ZWwub3JnPjsNCj4gRGFuaWVsIEJvcmttYW5uIDxkYW5pZWxAaW9nZWFyYm94Lm5ldD47IEplc3Bl
ciBEYW5nYWFyZCBCcm91ZXINCj4gPGhhd2tAa2VybmVsLm9yZz47IEpvaG4gRmFzdGFiZW5kIDxq
b2huLmZhc3RhYmVuZEBnbWFpbC5jb20+DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBOaWNrIERlc2F1bG5pZXJzDQo+IDxuZGVzYXVs
bmllcnNAZ29vZ2xlLmNvbT47IE5hdGhhbiBDaGFuY2VsbG9yIDxuYXRoYW5Aa2VybmVsLm9yZz47
IEtlZXMNCj4gQ29vayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPjsgaW50ZWwtd2lyZWQtbGFuQGxp
c3RzLm9zdW9zbC5vcmc7DQo+IG9zcy1kcml2ZXJzQGNvcmlnaW5lLmNvbTsgbGludXgtaHlwZXJ2
QHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
OyBsaW51eC1tZWRpYXRla0BsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBicGZAdmdlci5rZXJuZWwu
b3JnOyBKdXN0aW4gU3RpdHQgPGp1c3RpbnN0aXR0QGdvb2dsZS5jb20+DQo+IFN1YmplY3Q6IFtQ
QVRDSCBuZXQtbmV4dCB2NSAzLzNdIG5ldDogQ29udmVydCBzb21lIGV0aHRvb2xfc3ByaW50Zigp
IHRvDQo+IGV0aHRvb2xfcHV0cygpDQo+IA0KPiBUaGlzIHBhdGNoIGNvbnZlcnRzIHNvbWUgYmFz
aWMgY2FzZXMgb2YgZXRodG9vbF9zcHJpbnRmKCkgdG8gZXRodG9vbF9wdXRzKCkuDQo+IA0KPiBU
aGUgY29udmVyc2lvbnMgYXJlIHVzZWQgaW4gY2FzZXMgd2hlcmUgZXRodG9vbF9zcHJpbnRmKCkg
d2FzIGJlaW5nIHVzZWQNCj4gd2l0aCBqdXN0IHR3byBhcmd1bWVudHM6DQo+IHwgICAgICAgZXRo
dG9vbF9zcHJpbnRmKCZkYXRhLCBidWZmZXJbaV0ubmFtZSk7DQo+IG9yIHdoZW4gaXQncyB1c2Vk
IHdpdGggZm9ybWF0IHN0cmluZzogIiVzIg0KPiB8ICAgICAgIGV0aHRvb2xfc3ByaW50ZigmZGF0
YSwgIiVzIiwgYnVmZmVyW2ldLm5hbWUpOw0KPiB3aGljaCBib3RoIG5vdyBiZWNvbWU6DQo+IHwg
ICAgICAgZXRodG9vbF9wdXRzKCZkYXRhLCBidWZmZXJbaV0ubmFtZSk7DQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBKdXN0aW4gU3RpdHQgPGp1c3RpbnN0aXR0QGdvb2dsZS5jb20+DQo+IC0tLQ0KPiAg
ZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMgICAgICAgICAgfCAgNCAr
LQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWlu
LmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYw0KPiBpbmRl
eCBjM2I3Njk0YTc0ODUuLmJhZTk1MzZkZTc2NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gQEAgLTI5MzIsMTAgKzI5MzIsMTAgQEAgc3RhdGlj
IHZvaWQgZmVjX2VuZXRfZ2V0X3N0cmluZ3Moc3RydWN0DQo+IG5ldF9kZXZpY2UgKm5ldGRldiwN
Cj4gIAlzd2l0Y2ggKHN0cmluZ3NldCkgew0KPiAgCWNhc2UgRVRIX1NTX1NUQVRTOg0KPiAgCQlm
b3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShmZWNfc3RhdHMpOyBpKyspIHsNCj4gLQkJCWV0aHRv
b2xfc3ByaW50ZigmZGF0YSwgIiVzIiwgZmVjX3N0YXRzW2ldLm5hbWUpOw0KPiArCQkJZXRodG9v
bF9wdXRzKCZkYXRhLCBmZWNfc3RhdHNbaV0ubmFtZSk7DQo+ICAJCX0NCj4gIAkJZm9yIChpID0g
MDsgaSA8IEFSUkFZX1NJWkUoZmVjX3hkcF9zdGF0X3N0cnMpOyBpKyspIHsNCj4gLQkJCWV0aHRv
b2xfc3ByaW50ZigmZGF0YSwgIiVzIiwgZmVjX3hkcF9zdGF0X3N0cnNbaV0pOw0KPiArCQkJZXRo
dG9vbF9wdXRzKCZkYXRhLCBmZWNfeGRwX3N0YXRfc3Ryc1tpXSk7DQo+ICAJCX0NCj4gIAkJcGFn
ZV9wb29sX2V0aHRvb2xfc3RhdHNfZ2V0X3N0cmluZ3MoZGF0YSk7DQo+IA0KDQpSZXZpZXdlZC1i
eTogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo=

