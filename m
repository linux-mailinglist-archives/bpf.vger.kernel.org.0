Return-Path: <bpf+bounces-4015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A60F747B50
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 03:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3A05281002
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 01:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49F1A32;
	Wed,  5 Jul 2023 01:56:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A6F7F6;
	Wed,  5 Jul 2023 01:56:20 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03A110F2;
	Tue,  4 Jul 2023 18:56:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mioGTHFAVacz7InpLOELlCG0M2hH6zn3ZrSEKGIYIMMD/Sge8+DOIJPYPC+bxUs6naMI3bEYkihDT4Ce+iXRusM/PfuR0Ah0sNhfG0K7tKCxeBFx2Fbv862luknIW7A9bWAc2pUlm8usZpaobF5ONXitCdD5JdVjnzMXeGXDGnCkpgTlH3X5G1LruDQIELFk5jiTrfueKl6osN/zWbOzAS8h5DKdEm4dP9U6V3Lbufp3LWVgXf0HriSkO9v3D+2RSo2gp1ZvA9Xe1S6MrYqS8jSoscxEd3sL8SFQNNo3xvXkMO0X5WLBxI4DNckenStlMiRQgwLpdhg1KHxdJDX0Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcAx3tJLOhZftGhQp+87ijoJupwaDZS8DGZEVglalTQ=;
 b=GOz6nu2EewmYzxEEEHecp4r+9QPh9t+VFvnQMJnFWe/bt07oXqm0XVgX/hYLGHEDDfJ0O2Yz3q+a9r9iSeBjw+cz/vj6m8ZNUi/2P6lX+zIfyVfjcO5Bu75F8/LZFsYIgDaZJPrkhQty7vajW/hSUFwnY3g5Zwsc1b8A6hheMdiKLpWTWkbr2uCIbp8NAE3C50f+1S9zP76cwqLJBXjgkAZXf+aJ9TtjgtnH1vDoW9yZr4PK1xl6n9O5x15CxX6Ig1kUGexVNhQLbnv5MfsNJKg+Rrczf/yVBCQnO9h1QIVMGLR/O8S3UaXhxMu6OUdbI6xD4/pLhC9+U6cKZitv3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcAx3tJLOhZftGhQp+87ijoJupwaDZS8DGZEVglalTQ=;
 b=b+PXh2/C1xelEfFLVuAOOoHuXVWO9J+zEDnYoU4D5yvrfDjCrVJManEhLEC2VEJIjZ24efX14l486Z6tKeJp/gOrICAXUDGGPOe0cwIMwsgq+1AowuYzcpNKREI32WTcWWgRAm52svaDqq9jvMRrV3i2S0hezd4jub8FoLpHmxs=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by AM9PR04MB8891.eurprd04.prod.outlook.com (2603:10a6:20b:40a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 01:56:16 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::1edd:68cb:85d0:29e0]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::1edd:68cb:85d0:29e0%7]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 01:56:16 +0000
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
Subject: RE: [PATCH net 2/3] net: fec: recycle pages for transmitted XDP
 frames
Thread-Topic: [PATCH net 2/3] net: fec: recycle pages for transmitted XDP
 frames
Thread-Index: AQHZrlKPZOZIltzWjkCAumTK+5R4Sa+qR14AgAAbMHA=
Date: Wed, 5 Jul 2023 01:56:16 +0000
Message-ID:
 <AM5PR04MB3139619B482EA03D3B8DEC06882FA@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230704082916.2135501-1-wei.fang@nxp.com>
 <20230704082916.2135501-3-wei.fang@nxp.com>
 <2e3d30c1-f885-42f5-91c5-878da079d8a9@lunn.ch>
In-Reply-To: <2e3d30c1-f885-42f5-91c5-878da079d8a9@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|AM9PR04MB8891:EE_
x-ms-office365-filtering-correlation-id: 12750a55-a585-46dd-11d2-08db7cfb04d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rkhi7AMVXjo74A1xwTELQ1AlnkSvDQgoI6+Pnsjb+gsOSPvocKM5PtrM3k8bSJvdAgIOV3Gu2rbhzH8MJMPwV6v6SXS5zEEz/CqC+NECRJCBsFFM9l3n5n+Vm6EIjKAmFrDfTOKXgfUDfeXhEPI3UtpQXJ6KIOc+EoPn2uXp2egVGwxk0FI2+cNFZegRudESwJMA9kN3EPnn27GqxQclnqlc4Cfry/gDfW0ugzyxStz+SzWK+xAMSirI/eOHR3lXCz98qgxq9jk0OWWPcNup4eZlI4NZzKR5CKQdg4ZgxH623yOXGxAxoZWsqSLTFPTSGo5QyPejxFvnYLX/gnI5RDo31iyah0zi/U0sLnTIioyHeWuME8dweh81PLdg8cQT2v9AIsc6FRclBox8/ldKwFsbFBP0NwuwT2dE9epHkNtTa0Y8Ha7xdt7PnHo1+I18XQC4l8zqfAatE0wk+UQK9r6KO3yZcD13QMybWoAJj+L5JFkzglwXfveuyLkCesNCWPer8gO4MbyKmSzKvzuqEUm6mrpF+OtPr5UfIzEZTtQvPHqq1Zrf3FdUDBE2Adw3em/hCoLZooxwQ0Rmhq+i5NwgbehIN6EpQVmzSZyOVr8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(451199021)(8936002)(64756008)(66556008)(5660300002)(8676002)(55016003)(86362001)(53546011)(83380400001)(316002)(122000001)(38070700005)(38100700002)(41300700001)(6916009)(66476007)(76116006)(4326008)(66946007)(66446008)(186003)(9686003)(33656002)(26005)(7696005)(6506007)(54906003)(71200400001)(478600001)(2906002)(52536014)(44832011)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?N3R4UDJBM2NQQlI5VmF4UzZqQ2hBWHNoZEVZRDlxb2dKeTBNN3Nsc3hTWVV5?=
 =?gb2312?B?OUZUV3JVT3p2NGtsdkNTUGg5dlJPcXFGU3ZQc2NFbXF5RUkwSUw1Q1VtTXc4?=
 =?gb2312?B?NlVQOFdEeDVjSHk3UGFGTENsblJUWFlaMkNoWUNoTE1ucDh6djc5SnU4Wngv?=
 =?gb2312?B?OHVzZHRlVWxpU0xzK1pZVjhqcTdkWWVrNzludFNSaGhuSGZyU0cxT01qUEp0?=
 =?gb2312?B?eVZnTVRpbVFwV2xVZkVFcTl5c3VabGlNTDhLaGwyZy9RK2lUYUZwbTZDK2dE?=
 =?gb2312?B?RldwcytITC9wOW9RMC9uMUJxSXd2cGNQY3FCN1o5Y0Nxa3h6ZldBWjBuODlN?=
 =?gb2312?B?RXpxd1VjRk5tbElnWm5qaHJKREVQOFRzU3dVS3BkTU1wbC9QVnpTNlozZERI?=
 =?gb2312?B?VXRIRDF0OEx6WGFvVHc1czRXSisxUWFiNWVsRldkeU14YUpHYU9OVWxEaWtp?=
 =?gb2312?B?TTk3UGxEWWlkTjNiMHQ5TUYyVUxjR25JZ1hUQkc2K2pRb3BsVHZxbk1BcUJ4?=
 =?gb2312?B?d1hqZlVEaXJxSmJacmNrcTB0Tjc1cjVmVnVJREdZVzl0WUdYQVFqQ0dyZGdq?=
 =?gb2312?B?TENGVVNBZXpTS1RuemhPWFQ4Mmd3b0dtWm16QUpWdWcrTE9GRmgxL3Mrc0FN?=
 =?gb2312?B?Z3NZdXZZUkxyRVhzY3JVTnBGczJYb0ZaM2J6cUZKRmJSc2RQSXFrUFJTZmMx?=
 =?gb2312?B?eDdONGRsVk5DdDhWRkVxSFpJWUVQVEhyV3FKRmFEQTZKQy9zSEljY0xtVkpJ?=
 =?gb2312?B?REovVzNiaFFZdGpxQmRKZU90WFVCdkphcTdsYWxqbExSb1c1VFhqRHBPaHI0?=
 =?gb2312?B?RVhTOHBsc2Y5Z0EvSm5TVmZQb1FEMVhTcWlPcmFldmpoUDlKTFB5RVM5emxB?=
 =?gb2312?B?UnpCSUp2T1RPNGdnUEQxYTBOdHh2bi94OFBDeGVXcit0VTJUTkxxZnZsSzhp?=
 =?gb2312?B?ZDhTRXBUbWRreTcwTjFsaGp2SzZjcUgvYks5Qm4wSlpiSkEycmdMaTFkWTNa?=
 =?gb2312?B?MUdGbDQrWGhwU01sY09rbm51MXk1WjJ0UVhIVWxBVEtMYmxjK0ZFQUF6T1VM?=
 =?gb2312?B?TXhJdlUrZ0V3aU1tT3k1bUc1ZndmVTVmbGUvS3piWnlRVlEvalFIZEh6TE9w?=
 =?gb2312?B?TWxRWDBsNnBZMGNIdEZaQXI2MG4xRGdjNnY2aTVBYlZ3eUUremVIM3d2eExE?=
 =?gb2312?B?akhlNi9wbXNvQ3F3M1I1akJPUU5HL0d1a0lKbFNVOFBSTzExYkhuUzF5QmZ4?=
 =?gb2312?B?QWdaYkQ1eHN6SEswUUtPejRIR05mbksrQWdGTDFHUEgxTEhhQ0VoK2tyL0ZE?=
 =?gb2312?B?MGh3UEorcUF2elBJdGdQZ1Z6Qi9tLzlJR3M0Ukp5KzFwR1c3d0hGSXAxN0ht?=
 =?gb2312?B?em5teWUrTkpXREtXbGNoL3dtNnhYNGUvMktxWUh5TWFYU1E2dTlOWGJCeXJE?=
 =?gb2312?B?VjRkelNQSlZPV2U5QjRtUUFBdTRqK0N5aGdrUFNpQWhZSkdZbGhBa2NJeElj?=
 =?gb2312?B?ZHlWVXVDN2x4WVVQWUhlbEpoMzZVbm5GK2xnaXBtVGpqQkVZM2FOYVNySjZZ?=
 =?gb2312?B?UFB5LzMyNDBvT1FDSkgyeWt4NDZjeCtueDlIbzV5bncyR3dhRWk3VHBPcTN4?=
 =?gb2312?B?NkwxRE5meElnQmNqbUtKRzFBcVpKMGM4WGo3aHNBelZ1akZnOWJhMEFFZW85?=
 =?gb2312?B?ck05NHVPaHFLMzgxcHo0RGw3QTB2M0k0S0lSdWlncmlueE1sWjkxVGNRWjcy?=
 =?gb2312?B?NVM4MU1lbXRDQi9OZk5aWnYxYXZid202TzYvRWQvdFpMazVpaDNsaWdZZkdy?=
 =?gb2312?B?QU5RRXRTUFIya3B1U0ZVN1BneUN6djYxWWlNZERNbVdKRmh1dzVEUklxTmdo?=
 =?gb2312?B?cHlBcGorMHc0NmwzZlQzTlhId01neStUZ3hNOWVBWlV0NEsyTDZ4N2tqaDJC?=
 =?gb2312?B?eVFaVEQ3VmxlV3lRbEtaNzhzbzBxamdHVERYVWxXb3RKNU1lZ1lxSm5ucnJJ?=
 =?gb2312?B?bWRrb09BVjFLNkZUclcwZHMyWVBVd3hGTVlHTDgzYXBSd3IvZm9uWU5SenVq?=
 =?gb2312?B?OTJJT1RiMXdSOXdsUXFtS28wUzhPSSs3bTZkNllsa2xZME10ZzBYOHkybHBv?=
 =?gb2312?Q?X4mI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 12750a55-a585-46dd-11d2-08db7cfb04d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 01:56:16.2399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nT4XtfO7af4qnvfB5atYKd+VXCvR4EbVGav/dbHeUUo1qiA/uqIBq4nYgfO5msulkJFIgdxXlDJt9H/EN8166w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8891
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFuZHJldyBMdW5uIDxhbmRy
ZXdAbHVubi5jaD4NCj4gU2VudDogMjAyM8TqN9TCNcjVIDc6NDgNCj4gVG86IFdlaSBGYW5nIDx3
ZWkuZmFuZ0BueHAuY29tPg0KPiBDYzogZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29v
Z2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNvbTsgYXN0QGtlcm5l
bC5vcmc7IGRhbmllbEBpb2dlYXJib3gubmV0Ow0KPiBoYXdrQGtlcm5lbC5vcmc7IGpvaG4uZmFz
dGFiZW5kQGdtYWlsLmNvbTsgU2hlbndlaSBXYW5nDQo+IDxzaGVud2VpLndhbmdAbnhwLmNvbT47
IENsYXJrIFdhbmcgPHhpYW9uaW5nLndhbmdAbnhwLmNvbT47DQo+IG5ldGRldkB2Z2VyLmtlcm5l
bC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+Ow0KPiBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBicGZAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggbmV0IDIvM10gbmV0OiBmZWM6IHJlY3ljbGUgcGFnZXMgZm9yIHRyYW5zbWl0dGVkIFhEUCBm
cmFtZXMNCj4gDQo+ID4gIAkvKiBTYXZlIHNrYiBwb2ludGVyICovDQo+ID4gLQl0eHEtPnR4X3Nr
YnVmZltpbmRleF0gPSBza2I7DQo+ID4gKwl0eHEtPnR4X2J1ZltpbmRleF0uc2tiID0gc2tiOw0K
PiANCj4gV2hhdCBhYm91dCB0eHEtPnR4X2J1ZltpbmRleF0udHlwZSA/DQo+IA0Kd2UgcmVzdG9y
ZSB0aGUgYnVmZmVyIHR5cGUgdG8gRkVDX1RYQlVGX1RfU0tCIHdoZW4gcmVjeWNsaW5nIHRoZSBi
dWZmZXIgZGVzY3JpcHRvciwNCnNvIHRoZXJlIGlzIG5vIG5lZWQgdG8gc2V0IGl0IGFnYWluIGhl
cmUuDQoNCj4gPiBAQCAtODYyLDcgKzg2MCw3IEBAIHN0YXRpYyBpbnQgZmVjX2VuZXRfdHhxX3N1
Ym1pdF90c28oc3RydWN0DQo+IGZlY19lbmV0X3ByaXZfdHhfcSAqdHhxLA0KPiA+ICAJfQ0KPiA+
DQo+ID4gIAkvKiBTYXZlIHNrYiBwb2ludGVyICovDQo+ID4gLQl0eHEtPnR4X3NrYnVmZltpbmRl
eF0gPSBza2I7DQo+ID4gKwl0eHEtPnR4X2J1ZltpbmRleF0uc2tiID0gc2tiOw0KPiANCj4gaGVy
ZSBhcyB3ZWxsLg0KPiANCj4gPiArCQkJCS8qIHJlc3RvcmUgZGVmYXVsdCB0eCBidWZmZXIgdHlw
ZTogRkVDX1RYQlVGX1RfU0tCICovDQo+ID4gKwkJCQl0eHEtPnR4X2J1ZltpXS50eXBlID0gRkVD
X1RYQlVGX1RfU0tCOw0KPiANCj4gU2VlbXMgZXJyb3IgcHJvbmUuIEl0IHdvdWxkIGJlIHNhZmVy
IHRvIGV4cGxpY2l0bHkgc2V0IGl0IG5leHQgdG8NCj4gYXNzaWduaW5nIC5za2IvLnhkcC4NCkkg
YWxzbyBjb25zaWRlcmVkIHRoaXMgbWV0aG9kLCBidXQgaW4gdGhlIGNhc2Ugd2hlbiBza2IgaGFz
IGZyYWdzIG9yIFRTTywNCndlIG9ubHkgbmVlZCB0byBzZXQgc2tiIHBvaW50ZXIgZm9yIHRoZSBm
aXJzdCB0eHEtPnR4X2J1ZiwgYnV0IHdlIG5lZWQgdG8NCmV4cGxpY2l0bHkgc2V0IHRoZSB0eXBl
IGZvciBhbGwgdHhxLT50eF9idWYgY29ycmVzcG9uZGluZyB0byB0aGUgc2tiLiBUaGlzIG1heQ0K
Y29uZnVzZSBvdGhlcnMuDQpBcyBmb3IgeW91ciBjb25jZXJuIGFib3V0IGJlaW5nIGVycm9yLXBy
b25lLiBJIGRvbid0IHRoaW5rIGl0IHNob3VsZCBiZSwgSQ0KcmVzZXQgdGhlIHR5cGUgdG8gRkVD
X1RYQlVGX1RfU0tCIGluIGFsbCBwbGFjZXMgd2hlcmUgYnVmZmVycyBhcmUgcmVjeWNsZWQNCm9y
IGNsZWFyZWQuDQoNCj4gDQo+IAkgIEFuZHJldw0K

