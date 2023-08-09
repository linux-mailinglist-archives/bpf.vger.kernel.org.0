Return-Path: <bpf+bounces-7286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FDE7752D1
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 08:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D15162819FD
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 06:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5CE5665;
	Wed,  9 Aug 2023 06:22:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0A03C3F;
	Wed,  9 Aug 2023 06:22:16 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2084.outbound.protection.outlook.com [40.107.8.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11B3133;
	Tue,  8 Aug 2023 23:22:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPvimagV34t1hGeIeSXr2kJF6FE/TJgUzEe8yWMtc3pbV5LQky4pzr6+slFyaDpCreL5yPkBS8A6WGOZecClgH5uQMcfeaXI5N5zhlotM4ocU+aZSNRxnis5/x10TRUqaefMcdVe/lIMjrEnRNhgCDofquV5yedWXf1ofnr2bZw4mHCUHdxuJxuZVIY7PZrc3+MqVjK880v23/rZkqaROpx2HQdhJ92H8H2FZuA4bmd461Q8IvSKbb7rIDuJnzeWFE43O2V4eG43l1oGHMUcPmNJmr9SLB+vQE6uQdI66VAyde0D27EO2mqf8gRiB471H75630EI1t5uMUb0B+Dqpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XW9ZlVUIXOQmYcNRwBbAdVxgzhvN+hqCLqPK4ylSsGM=;
 b=At3e5eVQTg+2sPVgutpoxILxnJwB9Pldry/OqIHNkgpn6Ud1pLGqlZPiS0kSIm8RWyrzhrc9IMjrBtl0g+aGtY21IYL7+M55Y6P7ogfZ3yL6mIBLuFermJUZwS21iCnyCM/L5uw/M3LLsjkDDP/44F5nDOkoqyJjvqvK9CKh6QN0NfpwM9SxHulKFp7aDD3SlUi5u77tQtLuSu1ruA2o3Yv3AyLYiy9dgJ9vpEcr/GXX1mcnZcFFWaBRoMyKts0iojhxog+H81PmzUMWXRAIooHPP0kjnKHJkf9cxGvcbUZFoo4LyxRjgOM9YwfuGOTZwSTLtKEIBPizTY2WFjMKXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XW9ZlVUIXOQmYcNRwBbAdVxgzhvN+hqCLqPK4ylSsGM=;
 b=IJDlgfLhnkl9Lwq9ee2PtjpSBvI4gZfm3KmOuRzSvh34jtPxrxRkmlwrTZaUt0ZOJYerisUE4qu/O8wPwUUreriVgFbCK2AJZ717XzIAvMaLaT+xyEmecU+H0jc6ujAe1OglWrWQcfox41RERMNEWP9Z8GoVQySeJpJ1n7SBLtE=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by AS8PR04MB8675.eurprd04.prod.outlook.com (2603:10a6:20b:42a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 06:22:11 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 06:22:11 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, Jesper Dangaard Brouer
	<jbrouer@redhat.com>, Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, "ast@kernel.org"
	<ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-linux-imx
	<linux-imx@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	Andrew Lunn <andrew@lunn.ch>
Subject: RE: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Thread-Topic: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Thread-Index:
 AQHZw3VFF5NSBizeREOxLxVc18wksa/XS8kAgACl6SCAAEHAAIAAOPLAgAAgSoCAAOhtQIAApJaAgAR1gPCAAExVAIAA3vKwgACWywCAATR9kA==
Date: Wed, 9 Aug 2023 06:22:11 +0000
Message-ID:
 <AM5PR04MB313945432F6FBAEA1667BA548812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230731060025.3117343-1-wei.fang@nxp.com>
 <20230802104706.5ce541e9@kernel.org>
 <AM5PR04MB313985C61D92E183238809138808A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <1bf41ea8-5131-7d54-c373-00c1fbcac095@redhat.com>
 <AM5PR04MB31398ABF941EBDD0907E845B8808A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <cc24e860-7d6f-7ec8-49cb-a49cb066f618@kernel.org>
 <AM5PR04MB3139D8AAAB6B96B58425BBA08809A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <ba96db35-2273-9cc5-9a32-e924e8eff37c@kernel.org>
 <AM5PR04MB313903036E0DF277FEC45722880CA@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <8fd0313b-8f6f-9814-247d-c2687d053e2a@kernel.org>
 <AM5PR04MB313980263DAD261D114B3DA4880DA@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <aa9ec752-9f59-056f-da52-7ec5047e4642@kernel.org>
In-Reply-To: <aa9ec752-9f59-056f-da52-7ec5047e4642@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|AS8PR04MB8675:EE_
x-ms-office365-filtering-correlation-id: 53f09cee-d4fe-426f-71b7-08db98a0f780
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 fXUhWyRdFjUI/O9PB8jI7hIxOxKDrofVYxb80VwY0QFJ6PshZXRfWrsP/zCsIrs782qZVIzoKxSLd2+fb61Ffxds+X5PZNRi0oCKSc+YJSc1VzOAZookwXxlwBBKWvQRNmRw6QvNKSGshf/W6LBdFJVQdxK1r94+TUpNv8w8u7bL8w8OEKwIYp6bE+LgCYK19GZ2L1mMjTsM4FgLckNKi0pCV20Yk5Sg0DmUZVpIrRe0vQh4O8bcyhM2kcj/Dmg7YFzPlzvO07Oxq6osktGWKAog3NJqfJKWBkYAciq1al6naf5wCReneHa+vzWV/wPlQ4Oyb1Hp8PbURgnre4HoEVmbWGPxGYMuWvhpJdSEU3L+I1W+NpjC/u4XwdQ0dlmH/vDgmUtHv5fhso7AIFsqflYwd6NQTHOQ/LaQ7yFACRqId5DFZpug21D0rJj+ITt0ry0iBdstBz8JPBti/gn3DQyUXioofHNbC1sJda5+55svudA2kyUJb3EkVhKBP1w8EVTd2nJYSBx85N7/wzCwGbL1WKD/nHSXPf3ZEZGzprbjqFEjUTsQBHVts+7fd9aXb2OsxHl8Bx6D/bdWWsoHFXK9buzj3FrdYtmQU1+QZEd0I/eaWoUD5Mm+kWo/fLBl
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199021)(186006)(1800799006)(86362001)(2906002)(7416002)(33656002)(44832011)(55016003)(83380400001)(6506007)(26005)(38100700002)(7696005)(54906003)(9686003)(122000001)(110136005)(4326008)(8676002)(8936002)(66446008)(66556008)(66946007)(64756008)(66476007)(76116006)(38070700005)(5660300002)(41300700001)(52536014)(71200400001)(316002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cjhyMmZtdWJ2bUtnVzNVQ1VCKzhKMmR4VkphSU9EbitGYm1TVzJqWFpyTkdP?=
 =?utf-8?B?OWdPVnZsb24rUWR3ektYUGlEcW8rMnliQ1R3R0JFWmQ2RkZCK3dTQk1Da1p3?=
 =?utf-8?B?dmpmc2RVdFNkM1NWVytjTWdRNlpwQ3dHUjA3YmgwTlNKSW1EN2taN1IrWmxq?=
 =?utf-8?B?Q0FwY2k3SURNWTB5MzZ6b2tLZFpzUmhyR3JmVm9Pb0taaWU5Z1BBYjhhU1Vv?=
 =?utf-8?B?bExhT0FPbU9qbmttLzJsV1VSVkx1YVV6SU1jUzBnQW82dnVhNDh3OERsN2t3?=
 =?utf-8?B?SHBJbjFKWTBxekhBK21WU2huVW5xby9xRDdleVo0QmhXN3hTVmtQdXc4WUdK?=
 =?utf-8?B?VWM0aWpmNms0YjNTcStkak83b3YveG5iRlhsVlFnUXdnTWlmaFVnRFZleGI4?=
 =?utf-8?B?b2pFZm1HQUNlZ3lOZi9QK1lnZDRvbzcvdzlDWStmSlJjd2hvdXoxMjVzM0J2?=
 =?utf-8?B?U2diMXR3dlNCczlVVm9jZGdWZC83cVpvcmc1WkpmaWRtTWV2eVl4ajdieXMy?=
 =?utf-8?B?Qm5Na2V3bVoySGxwRWhuRlo4VEJvc1dtUEp5NUhvaTU1dW8rTkxubFA1U2VX?=
 =?utf-8?B?cWxheVl0bm5meUtuZzl0alRxWHcrMGx3a2d6VDMvUW1MWWVwcXQzSG5MOXZB?=
 =?utf-8?B?MGJUMjJ0QjhDZkRudUMyS2xkbEpmNTBjU09XR0pvdHZjQTlvOHo2U1FoS3A4?=
 =?utf-8?B?OXhHYmlacjVZRGoyaDQxMnRBZHg3SXk3ZHhwK1pHMWRiV21ITTY4QkhuVmtR?=
 =?utf-8?B?aTlHK0hvZ1pjYUJvMWRIMWVrakNacXRzVU9NMUpwK0o0b3M0M2lnMUg2N0U4?=
 =?utf-8?B?RlZ1aFpsaUdBd3I3aUlvVDY5QVVTMmtIellSSnJoNUxndkwxTkFtU0EwTUp1?=
 =?utf-8?B?UXE2QTNZc1IycUZwU3g2bWhPNTBHbWdEaTNzemkrb3N2UzVnZ2EyaGkrbUR0?=
 =?utf-8?B?OGFPdU1lUjArbEZ1YTY2cE5welFTVzBDb0NvMWUxZUpOMmpoK1FSRkowNFJI?=
 =?utf-8?B?cGlSQ2d4OEwvcEdJN3VXTFRzRk9RSWRHYktmbXNRbEtwMVlta3hrRlZWSmh3?=
 =?utf-8?B?aWltcHV5N2JIVEpzdUdJOXRhcWxqei9iVTdUdnlFK2VFYUtZZ295S2xBVTh6?=
 =?utf-8?B?Kzg5NUpLdGsvS1k5Q1NORmxrYzZZVnhsWFpBSnJDbWpTellHWFN0UUQvQ21a?=
 =?utf-8?B?RlM2Z3RHd3BtbGxiWmJkOVBxTU14RGs5TDVsNk9ETUpnTVhsam5iMFUxQml0?=
 =?utf-8?B?eWNDMTNIZnZaUVFaNU8zZmlTemh1TmZhOGEyNHJOMmR4RXZSR3ZJWE9SNzE2?=
 =?utf-8?B?SWZ1RXJaendKYlB0M2N3ZHJ2c3F1LzRkT2NyVU5haE1QYUdjVzZDSHRsOXJ1?=
 =?utf-8?B?RTArc0kwc0M2TUxzMEpKSHV2K2ZoeE8yMGVQZGhFS0ExbEQ1UXg1NGpmL2k2?=
 =?utf-8?B?OUpXbk9pQmRCS2lhcWIyMEZKalkvdEd1VnprRjZyQ0ZWMUROcDNiU1hjQ3R3?=
 =?utf-8?B?Vm9UeVlYMWxaZ29oTDVDZ1hBSHh6V09qbG9Kd1FQRVBDMHArZkVRckZxQmZG?=
 =?utf-8?B?Ni9FcWR2NElMQkJXUDZDVzZya0p0NWIrMWZaa2JQTUY0MGUvNjVWVkpnWUpn?=
 =?utf-8?B?aWZmdXlROFI5eUJYV0hXaWRpakpIRlFDbFlGa3lQaURXSDdERzZ3WkZ0R0JB?=
 =?utf-8?B?eUNNNkd2UVlOWVBoQm1qSnM0cVNKN2p4TVE0YzZtdURwdVArYkltcGlJendq?=
 =?utf-8?B?Um5xN3h5NlhUZWJNMkc0ZkR0RXczeUdlbU1XWHY2N2dVcCtqMHVjL05oUFhs?=
 =?utf-8?B?K3hIN0I1dXVjUDJmeDlERXFnQ2FzbndEUWtJKzNKRzM0cjFXVVhyWTFnVVRZ?=
 =?utf-8?B?VlB2bzQwcS9abS91bVVLUjFaRmswajBVVE82QXBVUHdlS2xlNmtKZ2huY3d5?=
 =?utf-8?B?dlZNOHc5OElzNmhNT0l6YTlBU2JIZldIZVZMeitLWWFFNFlOZUVZelF6dFV6?=
 =?utf-8?B?UGdOUmV3RWQvMnRlbW5ONVFBZlVlalMxMlMrL0NQOVBjeHg4T3Y3Y1EzcXBr?=
 =?utf-8?B?d29qSFlLcVVjWnQ5SFhGbDhEVmVEaDBZcitaeHhsMFdXc2ptYnZUdWk4aUlk?=
 =?utf-8?Q?ORZM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f09cee-d4fe-426f-71b7-08db98a0f780
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 06:22:11.7399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wWkBA/YcC+iDdMhW+RVtXmAhWOauSIg2JF2uZA935IfQbMlTU7bJRswDbjpSHazseMqATxCxGIy2eCKXsd4O2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8675
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiA+IFRoYW5rcyB2ZXJ5IG11Y2ghDQo+ID4gWW91IHJlbWluZCBtZSwgSSBhbHdheXMgc3RhcnRl
ZCB0aGUgcGt0Z2VuIHNjcmlwdCBmaXJzdCBhbmQgdGhlbiByYW4NCj4gPiB0aGUgeGRwMiBwcm9n
cmFtIGluIHRoZSBwcmV2aW91cyB0ZXN0cy4gU28gSSBzYXcgdGhlIHRyYW5zbWl0IHNwZWVkIG9m
DQo+ID4gdGhlIGdlbmVyYXRvciB3YXMgYWx3YXlzIGdyZWF0ZXIgdGhhbiB0aGUgc3BlZWQgb2Yg
WERQX1RYIHdoZW4gSQ0KPiA+IHN0b3BwZWQgdGhlIHNjcmlwdC4gQnV0IGFjdHVhbGx5LCB0aGUg
cmVhbC10aW1lIHRyYW5zbWl0IHNwZWVkIG9mIHRoZQ0KPiA+IGdlbmVyYXRvciB3YXMgZGVncmFk
ZWQgdG8gYXMgZXF1YWwgdG8gdGhlIHNwZWVkIG9mIFhEUF9UWC4NCj4gPg0KPiANCj4gR29vZCB0
aGF0IHdlIGZpbmFsbHkgZm91bmQgdGhlIHJvb3QtY2F1c2UsIHRoYXQgZXhwbGFpbnMgd2h5IGl0
IHNlZW1zIG91cg0KPiBjb2RlIGNoYW5nZXMgZGlkbid0IGhhdmUgYW55IGVmZmVjdC4gIFRoZSBn
ZW5lcmF0b3IgZ2V0cyBhZmZlY3RlZCBhbmQNCj4gc2xvd2VkIGRvd24gZHVlIHRvIHRoZSB0cmFm
ZmljIHRoYXQgaXMgYm91bmNlZCBiYWNrIHRvIGl0LiAoSSB0cmllZCB0byBoaW50IHRoaXMNCj4g
ZWFybGllciB3aXRoIHRoZSBFdGhlcm5ldCBGbG93LUNvbnRyb2wgc2V0dGluZ3MpLg0KPiANCj4g
PiBTbyBJIHR1cm5lZCBvZmYgdGhlIHJ4IGZ1bmN0aW9uIG9mIHRoZSBnZW5lcmF0b3IgaW4gY2Fz
ZSBvZiBpbmNyZWFzaW5nDQo+ID4gdGhlIENQVSBsb2FkaW5nIG9mIHRoZSBnZW5lcmF0b3IgZHVl
IHRvIHRoZSByZXR1cm5lZCB0cmFmZmljIGZyb20geGRwMi4NCj4gDQo+IEhvdyBkaWQgeW91IHR1
cm5lZCBvZmYgdGhlIHJ4IGZ1bmN0aW9uIG9mIHRoZSBnZW5lcmF0b3I/DQo+IChJIGEgY291cGxl
IG9mIHRyaWNrcyBJIHVzZSkNCj4gDQpBY3R1YWxseSwgSSBkaWRuJ3QgcmVhbGx5IGRpc2FibGUg
dGhlIHJ4IGZ1bmN0aW9uIG9mIHRoZSBnZW5lcmF0b3IsIEkganVzdCBtYWRlDQp0aGUgZ2VuZXJh
dG9yIGhhcmR3YXJlIGF1dG9tYXRpY2FsbHkgZGlzY2FyZCB0aGUgcmV0dXJuZWQgdHJhZmZpYyBm
cm9tIHhkcDIuDQpTbyBJIHV0aWxpemVkIHRoZSBNQUMgZmlsdGVyIGZlYXR1cmUgb2YgdGhlIGhh
cmR3YXJlIGFuZCBkaWQgc29tZSBtb2RpZmljYXRpb24NCnRvIHRoZSBwa3RnZW4gc2NyaXB0IHRv
IG1ha2UgdGhlIFNNQUMgb2YgdGhlIHBhY2tldCBpcyBkaWZmZXJlbnQgZnJvbSB0aGUgTUFDDQph
ZGRyZXNzIG9mIHRoZSBnZW5lcmF0b3IuDQoNCg0KPiA+IEFuZCBJIHRlc3RlZA0KPiA+IHRoZSBw
ZXJmb3JtYW5jZSBhZ2Fpbi4gQmVsb3cgYXJlIHRoZSByZXN1bHRzLg0KPiA+DQo+ID4gUmVzdWx0
IDE6IGN1cnJlbnQgbWV0aG9kDQo+ID4gcm9vdEBpbXg4bXBldms6fiMgLi94ZHAyIGV0aDANCj4g
PiBwcm90byAxNzogICAgIDMyNjUzOSBwa3Qvcw0KPiA+IHByb3RvIDE3OiAgICAgMzI2NDY0IHBr
dC9zDQo+ID4gcHJvdG8gMTc6ICAgICAzMjY1MjggcGt0L3MNCj4gPiBwcm90byAxNzogICAgIDMy
NjQ2NSBwa3Qvcw0KPiA+IHByb3RvIDE3OiAgICAgMzI2NTUwIHBrdC9zDQo+ID4NCj4gPiBSZXN1
bHQgMjogc3luY19kbWFfbGVuIG1ldGhvZA0KPiA+IHJvb3RAaW14OG1wZXZrOn4jIC4veGRwMiBl
dGgwDQo+ID4gcHJvdG8gMTc6ICAgICAzNTM5MTggcGt0L3MNCj4gPiBwcm90byAxNzogICAgIDM1
MjkyMyBwa3Qvcw0KPiA+IHByb3RvIDE3OiAgICAgMzUzOTAwIHBrdC9zDQo+ID4gcHJvdG8gMTc6
ICAgICAzNTI2NzIgcGt0L3MNCj4gPiBwcm90byAxNzogICAgIDM1MzkxMiBwa3Qvcw0KPiA+DQo+
IA0KPiBUaGlzIGxvb2tzIG1vcmUgcHJvbWlzaW5nOg0KPiAgICgoMzUzOTEyLzMyNjU1MCktMSkq
MTAwID0gOC4zNyUgZmFzdGVyLg0KPiANCj4gT3IgZ2FpbmluZy9zYXZpbmcgYXBwcm94IDIzNiBu
YW5vc2VjIHBlciBwYWNrZXQNCj4gKCgxLzMyNjU1MC0xLzM1MzkxMikqMTBeOSkuDQo+IA0KPiA+
IE5vdGU6IHRoZSBzcGVlZCBvZiB0aGUgZ2VuZXJhdG9yIGlzIGFib3V0IDkzNTM5N3Bwcy4NCj4g
Pg0KPiA+IENvbXBhcmVkIHJlc3VsdCAxIHdpdGggcmVzdWx0IDIuIFRoZSAic3luY19kbWFfbGVu
IiBtZXRob2QgYWN0dWFsbHkNCj4gPiBpbXByb3ZlcyB0aGUgcGVyZm9ybWFuY2Ugb2YgWERQX1RY
LCBzbyB0aGUgY29uY2x1c2lvbiBmcm9tIHRoZSBwcmV2aW91cw0KPiB0ZXN0cyBpcyAqaW5jb3Jy
ZWN0Ki4NCj4gPiBJJ20gc28gc29ycnkgZm9yIHRoYXQuIDooDQo+ID4NCj4gDQo+IEknbSBoYXBw
eSB0aGF0IHdlIGZpbmFsbHkgZm91bmQgdGhlIHJvb3QtY2F1c2UuDQo+IFRoYW5rcyBmb3IgZG9p
bmcgYWxsIHRoZSByZXF1ZXN0ZWQgdGVzdHMgSSBhc2tlZCBmb3IuDQo+IA0KPiA+IEluIGFkZGl0
aW9uLCBJIGFsc28gdHJpZWQgdGhlICJkbWFfc3luY19sZW4iICsgbm90IHVzZQ0KPiA+IHhkcF9j
b252ZXJ0X2J1ZmZfdG9fZnJhbWUoKSBtZXRob2QsIHRoZSBwZXJmb3JtYW5jZSBoYXMgYmVlbiBm
dXJ0aGVyDQo+IGltcHJvdmVkLiBCZWxvdyBpcyB0aGUgcmVzdWx0Lg0KPiA+DQo+ID4gUmVzdWx0
IDM6IHN5bmNfZG1hX2xlbiArIG5vdCB1c2UgeGRwX2NvbnZlcnRfYnVmZl90b19mcmFtZSgpIG1l
dGhvZA0KPiA+IHJvb3RAaW14OG1wZXZrOn4jIC4veGRwMiBldGgwDQo+ID4gcHJvdG8gMTc6ICAg
ICAzNjkyNjEgcGt0L3MNCj4gPiBwcm90byAxNzogICAgIDM2OTI2NyBwa3Qvcw0KPiA+IHByb3Rv
IDE3OiAgICAgMzY5MjA2IHBrdC9zDQo+ID4gcHJvdG8gMTc6ICAgICAzNjkyMTQgcGt0L3MNCj4g
PiBwcm90byAxNzogICAgIDM2OTEyNiBwa3Qvcw0KPiA+DQo+ID4gVGhlcmVmb3JlLCBJJ20gaW50
ZW5kIHRvIHVzZSB0aGUgImRtYV9zeW5jX2xlbiIrIG5vdCB1c2UNCj4gPiB4ZHBfY29udmVydF9i
dWZmX3RvX2ZyYW1lKCkgbWV0aG9kIGluIHRoZSBWNSBwYXRjaC4gVGhhbmsgeW91IGFnYWluLA0K
PiA+IEplc3BlciBhbmQgSmFrdWIuIFlvdSByZWFsbHkgaGVscGVkIG1lIGEgbG90LiA6KQ0KPiA+
DQo+IA0KPiBJIHN1Z2dlc3QsIHRoYXQgVjUgcGF0Y2ggc3RpbGwgdXNlIHhkcF9jb252ZXJ0X2J1
ZmZfdG9fZnJhbWUoKSwgYW5kIHRoZW4geW91DQo+IHNlbmQgZm9sbG93dXAgcGF0Y2ggKG9yIGFz
IDIvMiBwYXRjaCkgdGhhdCByZW1vdmUgdGhlIHVzZSBvZg0KPiB4ZHBfY29udmVydF9idWZmX3Rv
X2ZyYW1lKCkgZm9yIFhEUF9UWC4gIFRoaXMgd2F5IGl0IGlzIGVhc2llciB0byBrZWVwIHRyYWNr
DQo+IG9mIHRoZSBjaGFuZ2VzIGFuZCBpbXByb3ZlbWVudHMuDQo+IA0KT2theSwgSSB3aWxsIGRv
IGl0Lg0KDQo+IEkgd291bGQgYmUgdmVyeSBpbnRlcmVzdGVkIGluIGtub3dpbmcgaWYgdGhlIE1N
SU8gdGVzdCBjaGFuZ2UgYWZ0ZXIgdGhpcw0KPiBjb3JyZWN0aW9uIHRvIHRoZSB0ZXN0bGFiL2dl
bmVyYXRvci4NCj4gDQpUaGUgcGVyZm9ybWFuY2UgaXMgc2lnbmlmaWNhbnRseSBpbXByb3ZlZCBh
cyB5b3UgZXhwZWN0ZWQsIGJ1dCBhcyBJIGV4cGxhaW5lZA0KYmVmb3JlLCBJJ20gbm90IHN1cmUg
d2hldGhlciB0aGVyZSBhcmUgdGhlIHBvdGVudGlhbCByaXNrcyBvdGhlciB0aGFuIGluY3JlYXNl
DQpsYXRlbmN5LiBTbyBJJ20gbm90IGdvaW5nIHRvIG1vZGlmeSBpdCBhdCB0aGUgbW9tZW50Lg0K
DQpCZWxvdyBpcyB0aGUgcmVzdWx0IHRoYXQgSSBjaGFuZ2VkIHRoZSBsb2dpYyB0byBkbyBhIE1N
SU8td3JpdGUgb24gcngtQkRSIGFuZA0KdHgtQkRSIHJlc3BlY3RpdmVseSBpbiB0aGUgZW5kIG9m
IHRoZSBOUEkgY2FsbGJhY2suDQoNCnJvb3RAaW14OG1wZXZrOn4jIC4veGRwMiBldGgwDQpwcm90
byAxNzogICAgIDQzNjAyMCBwa3Qvcw0KcHJvdG8gMTc6ICAgICA0MzYxNjcgcGt0L3MNCnByb3Rv
IDE3OiAgICAgNDM0MjA1IHBrdC9zDQpwcm90byAxNzogICAgIDQzNjE0MCBwa3Qvcw0KcHJvdG8g
MTc6ICAgICA0MzYxMTUgcGt0L3MNCg0K

