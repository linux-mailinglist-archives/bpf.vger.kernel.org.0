Return-Path: <bpf+bounces-5165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D503D757A6E
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 13:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E579280CE3
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 11:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D5FC2F9;
	Tue, 18 Jul 2023 11:26:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A7B1FD8;
	Tue, 18 Jul 2023 11:26:46 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2107.outbound.protection.outlook.com [40.107.7.107])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B3A1706;
	Tue, 18 Jul 2023 04:26:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZweEKGqMoQXR06eOCZwBd4cvtz6cdB2IjWrq7WRPzEjTYJGKNPLDQSNF25KafiBeYgIGOm877FTrdXXKHozlzfPsD3nkXAPYhP3p42UJ7C3b3a9IcKEgsPA8Ps/SXDLPafbPIMWq6sIeWUWrxpvcoiVkeB2qMEvZkMXXe5E82PjfDctt0ukWccoxlK57LNJXGXP/7a8Vr1wXsavZT5ev2wja06hClqWuj3NOaTRgIdwmrk/BDyh53E7KQ3ZFtBFokno/HWxH/smuyhFefijvjAVhAVxpRN5T0W9pt3t1COLU8+eYFY1iArKDgezu8WwRTTRV5kFXnhK70jz05XmX+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbjsLL0lgbwvaihBcK7h6nwShEskZvYzHaz5spSZikE=;
 b=CeiKVWZkIn2KfHvu6emBuGr1bMSbt86FGNRdPCMbOmFc1r6HYpERo+oOr0XY/wqKZPZxNDbVBcwCNPnEKV02+WnqVKlhrHcbfD3VRqxRBTeCrBwjvWMy6GqPBay3M5ZVdcajXEdvT2Ws5TnykQEBnyYxSuvIknNT3IfSTxPAdiBuTQN3itIquA2WY8KmVEK7oOiz7Cr28Fn35IfZuQ3BdtwAbIL/QEHq6p1J1tXsvtQBvGiwrPjwjGydbYel06Eb0kpMrM+9IyEPpH9A8+EiXLO2jb0qmwc83Va+YWc8QkRWsyh2wzR0WhSRE/NV3m26g5pB6n3nG/6Zib7Wd1US9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbjsLL0lgbwvaihBcK7h6nwShEskZvYzHaz5spSZikE=;
 b=OY2SA/lfyx8FgoTcigtmc9eK9iPHZeTZIKkOZhzbDV8io3psLuv97mfXfw8uG1ZQw8OwZIEhNCUYqCE8ok+9+S3PZZY2D5zIR8Vrp+UP5Ml1NXRIsVNwuB2q9GhRw17bnQrSm34dIDldPYww6rzkoByxJUi2om3/O13WpwwCMn4=
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by AM8P189MB1460.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:236::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 11:26:39 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670%6]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 11:26:39 +0000
From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
To: Simon Horman <simon.horman@corigine.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony
 Nguyen <anthony.l.nguyen@intel.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Magnus Karlsson
	<magnus.karlsson@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>
Subject: RE: [PATCH iwl-next v3 3/4] igb: add AF_XDP zero-copy Rx support
Thread-Topic: [PATCH iwl-next v3 3/4] igb: add AF_XDP zero-copy Rx support
Thread-Index: AQHZtXdn9oHjn0Y79EWp91vR1zBcKa+6kRSAgATW6AA=
Date: Tue, 18 Jul 2023 11:26:39 +0000
Message-ID:
 <DBBP189MB1433AECC674945B7176D18DB9538A@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
References: <20230713104717.29475-1-sriram.yagnaraman@est.tech>
 <20230713104717.29475-4-sriram.yagnaraman@est.tech>
 <ZLJljUETnhH92kIV@corigine.com>
In-Reply-To: <ZLJljUETnhH92kIV@corigine.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBP189MB1433:EE_|AM8P189MB1460:EE_
x-ms-office365-filtering-correlation-id: 52c79d06-2ebc-45a0-5d3f-08db8781daec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ALV6LpI8bBJZO8Z+llOpQFfXnNLbark1t8ewVoFEYgRLbr/YX00hVq3MyqVNi1rwu+Ro600SE/ylDZ6ebsB5Rg+sw+Y1hETMvhp9E0/1g+TZwfImytfSQsdcVCN3S6Ru0+kJxZKRi/SkHllv62amo8cxBjfObcQs52GleSylCYGOElxB3KMhOdnWpNEDI+SVUqMEFXZd5uOf5a1kYe2F40v+KMLAbWrefWd2peao2p3b+a9T/Qu2wOhex6ZqEUvQNIlC9JHk0u3Up6W8qc9hBYjLvmoXt7TifBlgJV2ZpFz/msmR+1kanUfK/FyM7f4iVqvP6XUOdPNhWbiSfH833RTUpDU5MiZIiRBxLwA37fDnjAnTcewqas05u9wPL1ccvhX4C0kpMkwOQnuCgZ2j0sp2jHUwQxe/yjMYLFBTSAsWCl7Vpjr8/7WPBrTsDjDaE1oq8u+Q/H4i21T7bOyywpeU3qPSsqBWZJwHP8cdo0c+5UOHtoqGfDZKyM1mVWGdiXHoCRg5bxiv9I0DDktRkH7zRcRFC6/iaocR2ofhj+0LZr7Od/6nSu+EoGv6xNIELjxZ9LQpZ9eZk9faL/BSeIulQ8/cEbKx/lcA9BCrKoWVVFwXZaQnynXxPpjSHNTf
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(39830400003)(376002)(366004)(346002)(136003)(451199021)(86362001)(8936002)(316002)(5660300002)(66556008)(7416002)(52536014)(4326008)(8676002)(76116006)(44832011)(66946007)(41300700001)(478600001)(2906002)(7696005)(71200400001)(26005)(54906003)(6506007)(53546011)(9686003)(66446008)(186003)(6916009)(66574015)(83380400001)(66476007)(64756008)(55016003)(122000001)(38100700002)(38070700005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bGlXSUV1eG96TzFTU2RVNjBoVUpmV1NKQ05vK0t3V2VITHhZSFRUN0l0RGt5?=
 =?utf-8?B?NVloMnRjK2FwUUIzTEUxU0N2U3o2ek5KbHgrNXkwQmI2R3BYc2g1cGZETVZm?=
 =?utf-8?B?YzJsWGExYmlydlFLYzVLSGM3UUVzMXRNUG9TRnN1Zk1EYllNK3AwdlQxT0hw?=
 =?utf-8?B?cHJhWWdXeUVRRktzS0tiRUhVZnFRUFprcis5aDNpZUszRGM5S1F5TnZuSnVC?=
 =?utf-8?B?b0lORzRIRXI0cTVHd1ZITGExYXVpbjJ1dWxDYWJ3UTdBV1JRRmk5VVRjdjB1?=
 =?utf-8?B?MUxVQVR5QlMzSXc5bnMwODRKNzA4S1NNOStjREEyOTdXREF4WmxBUVpTOGph?=
 =?utf-8?B?S3FBOHVTbzV2UUc3TXV1NnM4d2xMcHpRMHI0MTJWS0d3dlNvMjFPSzBrcVRQ?=
 =?utf-8?B?a1pLTGkvbFBsTkNoNGh3TEFtV20rYmdnVWUweGRtZ3ByUjlpbHpOazMrNG92?=
 =?utf-8?B?SUx2SEM2YnNvb0FoT3RZZ0c1d3ZVb0UrbWRYeXc2eGVxOVZLYmlWZWZqaUFW?=
 =?utf-8?B?alVwWXZ5OEQxajdQVnVNQzUxaExDOWxoYjB0Q3pWZjgwaGpIOW9PVDk5RmpG?=
 =?utf-8?B?OGFXMk5WY2tUNGZOcGFTbU15UlZteWJqd2cwQXExWEdnRjA3Q1BDblhuQTM0?=
 =?utf-8?B?U0hPKzR4ZjhqK3dkT284Zlo4RW1XbmpPZWJ4eG9xTmJCdERWRDQ5cXZHNXNW?=
 =?utf-8?B?bVFybjlxVXQ1VjJjYWhRQ25xTHdINGxuRVBtT3hsZ29UZEs5bXRRMXNYcGRw?=
 =?utf-8?B?Rlk2bUcwb0V5OTQxcjZxajlyYlNzKy9tekp0YXJSOHpYUDZnNUNpWWZudkEz?=
 =?utf-8?B?MXdMTzljR1g1bU8vazlnZDlzNEZFZDl6WUJmdXBMNTBXYy8wRVFFaDRRcGpD?=
 =?utf-8?B?NGpLY3R1MmNoaTJXMWZmTDQxMnIrRWtPMXpZQ3Y0c3B0THRIbWdPRDlCNklr?=
 =?utf-8?B?MmRtL1pOdk9pY3RFcS8vbWZWSmJybjN3RWpOaXNkcEhpV0F6T29MQ1BjeUM2?=
 =?utf-8?B?Ujl2L2VwM3M1WllKb3NvUW1leGNaQ1pEdXptU25abUJHOCtnK25qY2w1Ym82?=
 =?utf-8?B?U0ZLRHUwZjV2MjlnSUxydTV4YjJEZTZmVU9aUXdoZzZ2RUNjbzYxVi9Za1dM?=
 =?utf-8?B?RVM2SVV2OGxiSEV1Y0Vkc3F2RGV4M3lzZ3krK3psSUgwSjgwN2F1a3lZakt3?=
 =?utf-8?B?RndLYTRMYjE1ejFSMC8zd1hEUDNULzgzL3Z1MkU4WUQ3UmxONDFYbnZIM3NS?=
 =?utf-8?B?VjBXTjRPZmtHdWdLZHQwYjIvc3JrZnhWTzd4cjhnK1lpK1dqdkRxK3hCL0hR?=
 =?utf-8?B?VEFJLzJmeE16VGorSjdKRFNpVUcrdFgwL3psWWZseldhOHRvQUJwYU1KTWhw?=
 =?utf-8?B?NkZVa0k4RnBDNVF4aGxUZXY2MjIwOForYVZkZm5nU0tKTklrV0JUS2FkdWIv?=
 =?utf-8?B?Tk9oN01KaGJaSzhMM1EvZUxlbXI0ZjkxWVArd09TbXI1ZnhvcFo3cHI5NERn?=
 =?utf-8?B?cG5qa041SFFYc1ZSY2s3ZlJnOW52cFFaMVAzamJGVXFQQzhrTmk1MXZXUzN6?=
 =?utf-8?B?SkhUQ2ppRTgzaUlqTWZSekdhZzY1czVyT1pLNGFSSFVXZFZ0V0xPUmdYZVh6?=
 =?utf-8?B?VjZYMEFWSkZRRk50VkVadG5xU1F2MWhaT285d1BtWGZjVm1FQ2I5UExyZm9s?=
 =?utf-8?B?RTgwY2VsZ3hESk5YVVYvdFNkTU5DWXZMektONk10UXh3SEoxQkl1aFFoR3pR?=
 =?utf-8?B?dG9rZ2JMbXZ3TXkxYjkwTG5WMjhVWFpyQVpGV0w2KzJiRzBETjgzVHRhekJa?=
 =?utf-8?B?ckNDcGJvSzE1cThBK0tyYUFZSk1SLzV5WWlicDcvQTZGT1pxL0hCaDVXYkZx?=
 =?utf-8?B?SFBoMHdhZ00xeEdod3lWbVFRWm5XWUd2YXdNMGFSTHhCV3dONDBkbGMxNE9B?=
 =?utf-8?B?b1lRMEh0UGI4aFEveGNMbmh1L0ltMXoyQmxBdDFsdWM2Y2FmaHdub29jNWxZ?=
 =?utf-8?B?dU15cHBMaFBCNGl2YTl3YXhnMnhmK3F0M3RuWmgxSzZZbUlYSGZjdk9RcEhO?=
 =?utf-8?B?c2xUOGpNWFZCRHRUVDZyNWtGSXdrTFlxK1MvbThRNkQ4Y2NkcDh2alREQnQw?=
 =?utf-8?Q?7Ks3+SEqvh7CbSecYqSk1q2Xm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c79d06-2ebc-45a0-5d3f-08db8781daec
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 11:26:39.6477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /3nW4/Mvh12n70vzSNW8maRIPYkXFU0LQ9gBn0Jq4157YQg3B5i0Oh92gD29RwuDxLGxYcBBmBQNiFy0/wrpYMDm1V5EET+BuLwWe7y34aQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P189MB1460
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2ltb24gSG9ybWFuIDxz
aW1vbi5ob3JtYW5AY29yaWdpbmUuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgMTUgSnVseSAyMDIz
IDExOjIzDQo+IFRvOiBTcmlyYW0gWWFnbmFyYW1hbiA8c3JpcmFtLnlhZ25hcmFtYW5AZXN0LnRl
Y2g+DQo+IENjOiBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZzsgYnBmQHZnZXIua2Vy
bmVsLm9yZzsNCj4gbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgSmVzc2UgQnJhbmRlYnVyZyA8amVz
c2UuYnJhbmRlYnVyZ0BpbnRlbC5jb20+Ow0KPiBUb255IE5ndXllbiA8YW50aG9ueS5sLm5ndXll
bkBpbnRlbC5jb20+OyBEYXZpZCBTIC4gTWlsbGVyDQo+IDxkYXZlbUBkYXZlbWxvZnQubmV0Pjsg
RXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWINCj4gS2ljaW5za2kgPGt1
YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IEFsZXhlaQ0K
PiBTdGFyb3ZvaXRvdiA8YXN0QGtlcm5lbC5vcmc+OyBEYW5pZWwgQm9ya21hbm4gPGRhbmllbEBp
b2dlYXJib3gubmV0PjsNCj4gSmVzcGVyIERhbmdhYXJkIEJyb3VlciA8aGF3a0BrZXJuZWwub3Jn
PjsgSm9obiBGYXN0YWJlbmQNCj4gPGpvaG4uZmFzdGFiZW5kQGdtYWlsLmNvbT47IEJqw7ZybiBU
w7ZwZWwgPGJqb3JuQGtlcm5lbC5vcmc+OyBNYWdudXMNCj4gS2FybHNzb24gPG1hZ251cy5rYXJs
c3NvbkBpbnRlbC5jb20+OyBNYWNpZWogRmlqYWxrb3dza2kNCj4gPG1hY2llai5maWphbGtvd3Nr
aUBpbnRlbC5jb20+OyBKb25hdGhhbiBMZW1vbg0KPiA8am9uYXRoYW4ubGVtb25AZ21haWwuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIGl3bC1uZXh0IHYzIDMvNF0gaWdiOiBhZGQgQUZfWERQ
IHplcm8tY29weSBSeCBzdXBwb3J0DQo+IA0KPiBPbiBUaHUsIEp1bCAxMywgMjAyMyBhdCAxMjo0
NzoxNlBNICswMjAwLCBTcmlyYW0gWWFnbmFyYW1hbiB3cm90ZToNCj4gPiBBZGQgc3VwcG9ydCBm
b3IgQUZfWERQIHplcm8tY29weSByZWNlaXZlIHBhdGguDQo+ID4NCj4gPiBXaGVuIEFGX1hEUCB6
ZXJvLWNvcHkgaXMgZW5hYmxlZCwgdGhlIHJ4IGJ1ZmZlcnMgYXJlIGFsbG9jYXRlZCBmcm9tDQo+
ID4gdGhlIHhzayBidWZmIHBvb2wgdXNpbmcgaWdiX2FsbG9jX3J4X2J1ZmZlcnNfemMuDQo+ID4N
Cj4gPiBVc2UgeHNrX3Bvb2xfZ2V0X3J4X2ZyYW1lX3NpemUgdG8gc2V0IFNSUkNUTCByeCBidWYg
c2l6ZSB3aGVuDQo+ID4gemVyby1jb3B5IGlzIGVuYWJsZWQuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBTcmlyYW0gWWFnbmFyYW1hbiA8c3JpcmFtLnlhZ25hcmFtYW5AZXN0LnRlY2g+DQo+IA0K
PiAuLi4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ln
Yi9pZ2JfbWFpbi5jDQo+ID4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2IvaWdiX21h
aW4uYw0KPiA+IGluZGV4IDJjMWUxZDcwYmNmOS4uOGVlZDNkMGFiNGZjIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYi9pZ2JfbWFpbi5jDQo+ID4gKysrIGIv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdiL2lnYl9tYWluLmMNCj4gPiBAQCAtNTAyLDEy
ICs1MDIsMTQgQEAgc3RhdGljIHZvaWQgaWdiX2R1bXAoc3RydWN0IGlnYl9hZGFwdGVyDQo+ID4g
KmFkYXB0ZXIpDQo+ID4NCj4gPiAgCQlmb3IgKGkgPSAwOyBpIDwgcnhfcmluZy0+Y291bnQ7IGkr
Kykgew0KPiA+ICAJCQljb25zdCBjaGFyICpuZXh0X2Rlc2M7DQo+ID4gLQkJCXN0cnVjdCBpZ2Jf
cnhfYnVmZmVyICpidWZmZXJfaW5mbzsNCj4gPiAtCQkJYnVmZmVyX2luZm8gPSAmcnhfcmluZy0+
cnhfYnVmZmVyX2luZm9baV07DQo+ID4gKwkJCXN0cnVjdCBpZ2JfcnhfYnVmZmVyICpidWZmZXJf
aW5mbyA9IE5VTEw7DQo+ID4gIAkJCXJ4X2Rlc2MgPSBJR0JfUlhfREVTQyhyeF9yaW5nLCBpKTsN
Cj4gPiAgCQkJdTAgPSAoc3RydWN0IG15X3UwICopcnhfZGVzYzsNCj4gPiAgCQkJc3RhdGVyciA9
IGxlMzJfdG9fY3B1KHJ4X2Rlc2MtDQo+ID53Yi51cHBlci5zdGF0dXNfZXJyb3IpOw0KPiA+DQo+
ID4gKwkJCWlmICghcnhfcmluZy0+eHNrX3Bvb2wpDQo+ID4gKwkJCQlidWZmZXJfaW5mbyA9ICZy
eF9yaW5nLT5yeF9idWZmZXJfaW5mb1tpXTsNCj4gPiArDQo+ID4gIAkJCWlmIChpID09IHJ4X3Jp
bmctPm5leHRfdG9fdXNlKQ0KPiA+ICAJCQkJbmV4dF9kZXNjID0gIiBOVFUiOw0KPiA+ICAJCQll
bHNlIGlmIChpID09IHJ4X3JpbmctPm5leHRfdG9fY2xlYW4pIEBAIC01MzAsNyArNTMyLDcNCj4g
QEAgc3RhdGljDQo+ID4gdm9pZCBpZ2JfZHVtcChzdHJ1Y3QgaWdiX2FkYXB0ZXIgKmFkYXB0ZXIp
DQo+ID4gIAkJCQkJKHU2NClidWZmZXJfaW5mby0+ZG1hLA0KPiANCj4gSGkgU3JpcmFtLA0KPiAN
Cj4gSGVyZSBidWZmZXJfaW5mbyBpcyBkZXJlZmVyZW5jZWQuLi4NCj4gDQo+ID4gIAkJCQkJbmV4
dF9kZXNjKTsNCj4gPg0KPiA+IC0JCQkJaWYgKG5ldGlmX21zZ19wa3RkYXRhKGFkYXB0ZXIpICYm
DQo+ID4gKwkJCQlpZiAobmV0aWZfbXNnX3BrdGRhdGEoYWRhcHRlcikgJiYgYnVmZmVyX2luZm8N
Cj4gJiYNCj4gDQo+IEFuZCBoZXJlIGJ1ZmZlcl9pbmZvIGlzIGNoZWNrZWQgYWdhaW5zdCBOVUxM
Lg0KPiANCj4gVGhpcyBjb21iaW5hdGlvbiBkb2Vzbid0IHNlZW0gcXVpdGUgcmlnaHQuDQoNCkFD
SywgSSB3aWxsIGZpeCB0aGlzLiBJIGFtIHVuYWJsZSB0byB0ZXN0IHRoaXMgcGF0aCB0aG91Z2gu
DQoNCj4gDQo+ID4gIAkJCQkgICAgYnVmZmVyX2luZm8tPmRtYSAmJiBidWZmZXJfaW5mby0+cGFn
ZSkgew0KPiA+ICAJCQkJCXByaW50X2hleF9kdW1wKEtFUk5fSU5GTywgIiIsDQo+ID4gIAkJCQkJ
ICBEVU1QX1BSRUZJWF9BRERSRVNTLA0K

