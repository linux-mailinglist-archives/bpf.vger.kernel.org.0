Return-Path: <bpf+bounces-326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A76DA6FEA36
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 05:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DCE52815CD
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 03:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656F517750;
	Thu, 11 May 2023 03:31:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322547FC
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 03:31:14 +0000 (UTC)
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-cusazon11020019.outbound.protection.outlook.com [52.101.61.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1369310C9
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 20:31:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U46q2lj+sLra0jkUEVximIBAFaMPSuJmNwkGo8Ju+Lxg7vD0teiHgL6VrSPOsZZKj9jjeZx1HAbGozw9AF5TTw/wOA5bSSMwGGVzTF22d+5c7kcsPaWy4rUJMJXmppGM5kSPbpaERjh2wTs89Chg8XiN87YO0cFbvolZuCA65nbXw0mJAKUg3NbIE+LmzJ3CkUU8d7yNL3GQd3LXICbXRQesI53MXACaWVPL6lxeP/07Lv+C2QWZT/3zpOCgU9tvRxEW8aHR24UjKMFA3faHT9ja52RTvu5xHApV8GCWnUD2ETayQSz9Sr8uWzlzeyAuure3I+O6aIlE29LYT5x1vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANtsV/ggL/8+AIKKie56PvgXh2PJsWgvWMW8gnSKuP8=;
 b=Vu4Kx5ljcjrIQi54FdYZqGdFdWKXX5dn+BXsagGPyu9IQ9rBB4zVzLkc60D/Odh2aadk2TwbgyW94ZqaGmgtmkMZNmJRDWJsPeDvE90N2t6gdCVQA4ufWRVKEHQkzzJgNCDc68MrdE0+CJ15NcSiY5WMbXC2XK7Y153D9Ml0jZAWqs9LlBnVt3TgJvFRUGx58fvvTq/Xt8rcGGgN/KsL5WvQEAq3nEW6g0IP2ZToSD5DHVqaH0GQTPJ7YaZCdJt0IlAgURmTcTFzo5Bw8K+jonrZjTZCcXLdwy4+MSZCnJnsfA22u/fXxLcQOvShJF1REx4KaXRnRvi2TR2osauxaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANtsV/ggL/8+AIKKie56PvgXh2PJsWgvWMW8gnSKuP8=;
 b=BjtQgSgXGqWwKRnT3vCTVVs1kY5c0P2K1cwnyF8jxLU6nYINwcYlGcepAK7L+yWkDIUPCXJwNrhuCgoAFkJJhlRCB7B0M+4fNNiFgbO3yyOYEcEmozNol9YsjbjJ+PZI/NTcIAKyTpkYGA4FjOdqdL9z6rteQgPKvuoh9dSnMuY=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by SA0PR21MB2012.namprd21.prod.outlook.com (2603:10b6:806:132::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.5; Thu, 11 May
 2023 03:31:08 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::ebee:52ea:94c9:4e43]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::ebee:52ea:94c9:4e43%7]) with mapi id 15.20.6411.002; Thu, 11 May 2023
 03:31:07 +0000
From: Dave Thaler <dthaler@microsoft.com>
To: Yonghong Song <yhs@meta.com>, Dave Thaler <dthaler1968@googlemail.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC: "bpf@ietf.org" <bpf@ietf.org>
Subject: RE: [PATCH bpf-next] Shift operations are defined to use a mask
Thread-Topic: [PATCH bpf-next] Shift operations are defined to use a mask
Thread-Index: AQHZgqFZC/QeNsBkkEu+CoXwaca4N69TgxOAgAAiq4CAAINHgIAAQvHQ
Date: Thu, 11 May 2023 03:31:07 +0000
Message-ID:
 <PH7PR21MB38782FB8019C5574A14D4408A3749@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <20230509180845.1236-1-dthaler1968@googlemail.com>
 <463649c1-d641-82c8-626e-162865cc21a0@meta.com>
 <PH7PR21MB38783D142478D9D569188B5AA3779@PH7PR21MB3878.namprd21.prod.outlook.com>
 <e702f65c-0d6a-d9d6-12d7-d25d3597966b@meta.com>
In-Reply-To: <e702f65c-0d6a-d9d6-12d7-d25d3597966b@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1692f505-70d7-477b-894b-6eda7ff1db24;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-11T03:28:11Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|SA0PR21MB2012:EE_
x-ms-office365-filtering-correlation-id: 3d89e5f1-f98f-4e2d-b0ea-08db51d0287d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rrnKGWzpinuYqZpm7T0gOZGKTjkmVlmDsZRZiLUI1IiS2y7CzW80IbNbOhkawhD9AelJDP5lf/qtKjThTsmdAzYVANs9eCA9/pxGS95XnhakcQTPad6oyRzjFICJZ/pLMTswrolFZTbTfjXXrK0g4SiHxmCkDqm4sscqOtqwJG5rU7I/VyCVMLJvt4rukaChxnTAVvWSdWl218m/bRPB2+D3qpL/xEHeFUCBrKiU4Khk3PTakGn8bbsLEi0TyJ8qj+Xas6W4Wgw5TsRMTx9SOEn3fw6r/CnZd5nBHhTb02VMJFAlkM517HXoEWs935WcAx06Fx1rJXasJ5Wl9cMgT6JUa1EBFEmSqsyJbt/h29b2iCwFa+1MSx9OmLfdzjICRDHlYlgEIM1x+qD7SYBhBNygN3U/REC6XM4MBNydcXPGbV9xzKmxuFH2VFuzxsOfwucF5+u+oxYCyZxoLRBtUvg+3qSPubhJLTyTWwOobP79mAjewSnv7oUnihIycF02FzX3y3TNFv+L5qlqPYr4/ZhOpzE9iho4pJItgktyd2OkeYK8cC0CNUPtkA9JdvArL2HoVoywbj8t/TLqrf4aHIqX9viszOw7fhe+EaQcFFwKF5OyHVF+a5OeWp6Z+Ii5EuBgkH0nvMxg9ULPIaRT30Bo6m/i4o0eTC/63Ej8zKo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199021)(83380400001)(38100700002)(41300700001)(4326008)(38070700005)(122000001)(82960400001)(33656002)(82950400001)(316002)(8936002)(8676002)(786003)(6506007)(7696005)(9686003)(26005)(10290500003)(64756008)(53546011)(478600001)(76116006)(66946007)(66556008)(66446008)(66476007)(8990500004)(5660300002)(52536014)(2906002)(86362001)(186003)(55016003)(110136005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K2hmWWs0VEFoWjNzb3BmZmd4OWk2MGZGV0lvWXArVlJzTzJwd0Q1ZWVlWDhl?=
 =?utf-8?B?NHRBMmhvekthUG9pQXcrRGlDU2VDRFlXdERrRFZ2am0rU2o4OVdqREE2ZWJH?=
 =?utf-8?B?aTg0NGZIOFRmbVhSN0F2LzlPdHQzbmViNUg5UnJXMUFyR2VkZ3hYMzQzTjN4?=
 =?utf-8?B?dmJYSmtMVXQ3ODdSNC80dU1jc0FRSFdOYTREOFVFMVlqOXFBK0VLSGY0L3k2?=
 =?utf-8?B?ZnZzamplMkUzQXlNRlBrMkhwNCtNMk1FOEpPc3BhR2dGckpDQ0ozQWNMTS9x?=
 =?utf-8?B?T0xPK0J6b0FaOHB1V0Ixa0tlUUxOSkRsYXpjYy9uV2t1bSsyQi9RRWZtQ3Nw?=
 =?utf-8?B?MHRhRForUU5jcFd3WDkzNFlpazZuOHAvdjI1K3dOQlVMVUtjbEs5VHpCbzRp?=
 =?utf-8?B?YkZranAvMVBhMVJmdEtNMWN0ZldBWXZYeXUzcy9yWjR4dHJJOUxMSzhHaWRY?=
 =?utf-8?B?Qml2ZTgwcStNSWV4d3ROc1pUNkJxVkJVT0V3dE1yUWtYOW9YdlcvdzV5VWpz?=
 =?utf-8?B?TFFDbjZtdDZIM3lrcGxid010QVZSZnN0cWdqZDNwVWVUZ3NYRGxCMDZSTStS?=
 =?utf-8?B?SmlXU1Q1aFZ3MHV2ZUljY2d6bjRBY3RDMU9LYVFnZVVXWXNhaHNuM2E1aEYr?=
 =?utf-8?B?Rzg4UE83cExHOXB1OXRSWlUzcHYzNEw3OVY5SjlzVFZvMTVEK1dqQ1dHZXBW?=
 =?utf-8?B?RFhhZ01PdDA1Rmx6UHJLUkUyVXJuSGpmcmJtdFR6SE9vMDNJVHBybEhXSk9U?=
 =?utf-8?B?aG5xdC81cEZ1YzNOdm16SFlSOXhETWVsZUlGNHF3b3B0UldSclZLMEllUVlY?=
 =?utf-8?B?UlFtcEVOZGdwZWRmV2NxNkdGMGVIKy91NGVGVGdTUkVNVExERHhoaVVGeFdG?=
 =?utf-8?B?UU95aDd4K0V5Q09YQ0NFUWI3R0xkRlM3YzFSNDg0d1F0Z2x6aTNWT2dnT1J4?=
 =?utf-8?B?Tm1xZFlHVG9mNjBEUUp6dnVFNXRLcGpkTWhNZnVldnRrbTUzQmVzb0R1bXpN?=
 =?utf-8?B?NkNoQjhvWGlDUyt5dmJqWmZ6VjdZQ0dMcU5zUjlOWmJjUVFjc3gwWVhmbWZu?=
 =?utf-8?B?NjdxYyt5YVZZTEdOc1lFQUhDa3ZpUXRpN0dGS0JtNDNyeDB1a2J0S3EwTEdx?=
 =?utf-8?B?VVM5YXVCOXczZDg4NE1DdnJzOFRDT2pHV1hPQmlLTjV4Q0dOcHk1b2c0OVZm?=
 =?utf-8?B?UVIrcUp0ekl1SkZHZ3ZjRlBqU0p6R0UyMktZcVRCeXpZWkxUYmFNL3NtL24v?=
 =?utf-8?B?SmZjbVJPNHFad3gyTSt2VmsvQ05oTWQvelNwdUgzb2lzWk1MQVh5dWVUMXZi?=
 =?utf-8?B?cmsvWHRYYmJWWmZkdytSSjU2ZHVRR1liTzY2Y2cvVHBjZmJ1WGc5SU5rRnFW?=
 =?utf-8?B?NDg4Y2RnWWlOVmE4bERyTElRcHM1V1RFOXJ5YVNNcTN2VHhNcERJRVJVR2xJ?=
 =?utf-8?B?RlNLMHA2VzhJMXRWMjloTE9sQlJ3MGh3enVZOXRMcXlsRzVUWW1HWVE2Y21R?=
 =?utf-8?B?L2V2cFN6ZGNwZFZRNkhEZGtjVEhhRzBOYVRZQkFhaG9uT3VEd2lrNjBYWE9B?=
 =?utf-8?B?YUNheWpSczRHSmYwcE5yRjBSMzV0UFMzMmlsQkxKM1F6ZzdlRHFHdTE0RGxS?=
 =?utf-8?B?ejlHWDErMGljeXVONlRaUkxnTzFMaWQxOUp0TWFkN1Y2Z1AxLzNOZm9CYzZC?=
 =?utf-8?B?YzRDY1dSTm9MaWE5dkN6VmZFeERRWWxIVXJPZUlLRGF2Zk5ORkFoS0pGdC9i?=
 =?utf-8?B?c3RySm9icktUbDk0WWlOQk5EbUlnWkFBWW1iLzg3eGh6d25wK0hqOW0xTlBU?=
 =?utf-8?B?Y1psTUdvMThpNXprYmZpRzJhdXkvL3BWbGJ0UFNtbmVFbkZWbmNHc21XZ2w0?=
 =?utf-8?B?eWdpbnoyR09rNEpLSCsvelIzYW5SQUx0SVJ0UXJwWjhpSTBNeWdrTVFLNFlr?=
 =?utf-8?B?S0NGR2luNDFZOEdFekpSOXdvTmloSHVyUFN2UHFsV3h3MDZXTjIxcGlrV2Iz?=
 =?utf-8?B?dlJxNVlwVFJXY2lqSjlOd3AvTzRnZ1hTemRsclRoRk9kZTVXUFB0TTZDaUtL?=
 =?utf-8?B?dVZ0OWpINmRrdmVyaUxDUmJWTkMwYThTUmJUUG4vSWZnZnhUczByaXl6TGg0?=
 =?utf-8?B?VjJLWHNwQWF5ak1qam10R2FMODd2ZGxERjh4aituRThCdlQxbk9ISGNDTEZZ?=
 =?utf-8?B?Q3c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d89e5f1-f98f-4e2d-b0ea-08db51d0287d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2023 03:31:07.7166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pXTj+LuIL9haiAEVnQqUlZeVjq3TkLxL4NOpuzuNvGIhefqbfkF6/WTXtQgW9Iod0Lnp0ZOrfCyjboVwuTQceKNG4KEjmArWQJlM5+Q1/Tg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB2012
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

WW9uZ2hvbmcgU29uZyA8eWhzQG1ldGEuY29tPiB3cm90ZTogDQo+IE9uIDUvMTAvMjMgODo0NSBB
TSwgRGF2ZSBUaGFsZXIgd3JvdGU6DQo+ID4gWW9uZ2hvbmcgU29uZyA8eWhzQG1ldGEuY29tPiB3
cm90ZToNCj4gPj4gT24gNS85LzIzIDExOjA4IEFNLCBEYXZlIFRoYWxlciB3cm90ZToNCj4gPj4+
IEZyb206IERhdmUgVGhhbGVyIDxkdGhhbGVyQG1pY3Jvc29mdC5jb20+DQo+ID4+Pg0KPiA+Pj4g
VXBkYXRlIHRoZSBkb2N1bWVudGF0aW9uIHJlZ2FyZGluZyBzaGlmdCBvcGVyYXRpb25zIHRvIGV4
cGxhaW4gdGhlDQo+ID4+PiB1c2Ugb2YgYSBtYXNrLCBzaW5jZSBvdGhlcndpc2Ugc2hpZnRpbmcg
YnkgYSB2YWx1ZSBvdXQgb2YgcmFuZ2UNCj4gPj4+IChsaWtlDQo+ID4+PiBuZWdhdGl2ZSkgaXMg
dW5kZWZpbmVkLg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IERhdmUgVGhhbGVyIDxkdGhh
bGVyQG1pY3Jvc29mdC5jb20+DQo+ID4+DQo+ID4+IExHVE0gd2l0aCBhIGZldyBuaXQgYmVsb3cu
DQo+ID4+DQo+ID4+IEFja2VkLWJ5OiBZb25naG9uZyBTb25nIDx5aHNAZmIuY29tPg0KPiA+IFsu
Li5dDQo+ID4+PiAtQlBGX0FSU0ggIDB4YzAgICBzaWduIGV4dGVuZGluZyBzaGlmdCByaWdodA0K
PiA+Pj4gK0JQRl9BUlNIICAweGMwICAgc2lnbiBleHRlbmRpbmcgZHN0ID4+PSAoc3JjICYgbWFz
aykNCj4gPj4NCj4gPj4gCQkgICAgZHN0IHM+Pj0gKHNyYyAmIG1hc2spDQo+ID4+ID8NCj4gPg0K
PiA+IEkgaGFkIHRob3VnaHQgYWJvdXQgdGhhdCwgYnV0IGJhc2VkIG9uIEpvc2UncyBMU0YvTU0v
QlBGIHByZXNlbnRhdGlvbg0KPiA+IHllc3RlcmRheSB0aGVyZSBhcmUgbXVsdGlwbGUgc3VjaCBz
eW50YXhlcy4NCj4gPg0KPiA+ICI+Pj0iIHZzICJzPj49IiBpcyBvbmx5IG9uZSBvZiBzZXZlcmFs
LiAgVGhlcmUncyAiPj4iIHZzICI+Pj4iLA0KPiA+IHRoZXJlJ3MgYXNzZW1ibHktbGlrZSwgZXRj
LiAgIFNvIEkgdGhvdWdodCB0aGF0IGl0IHdvdWxkIHRha2UNCj4gPiBtb3JlIHRleHQgdG8gZGVm
aW5lICJzPj4iIGFzIG1lYW5pbmcgc2lnbmluZyBleHRlbmRpbmcgcmlnaHQgc2hpZnQsDQo+ID4g
dGhhbiBqdXN0IHNheWluZyBzaWduIGV4dGVuZGluZyAiPj49IiBoZXJlLiAgQW5kIEkgZGlkbid0
IHdhbnQgdG8ganVzdA0KPiA+IGFzc3VtZSB0aGUgcmVhZGVyIGtub3dzIHdoYXQgInM+PiIgbWVh
bnMgd2l0aG91dCBkZWZpbmluZyBpdCBzaW5jZQ0KPiA+IG5laXRoZXIgdGhlIEMgc3RhbmRhcmQg
bm9yIGdjYyB1c2UgInM+PiIuDQo+IA0KPiBnY2Mgd2lsbCBpbXBsZW1lbnQgY2xhbmcgYXNtIHN5
bnRheCBhcyB3ZWxsLiBTbyBmb3IgdGhlIGNvbnNpc3RlbmN5IG9mIHZlcmlmaWVyDQo+IGxvZywg
YnBmdG9vbCB4bGF0ZWQgZHVtcCwgYW5kIGxsdm0tb2JqZHVtcCByZXN1bHQuDQo+IEkgdGhpbmsg
dXNpbmcgInM+Pj0iIHN5bnRheCBpcyB0aGUgYmVzdC4NCg0KSnVzdCBwb3N0aW5nIHRvIHRoZSBs
aXN0IHdoYXQgd2UgZGlzY3Vzc2VkIGluIHBlcnNvbiB0b2RheS4NCkkgd2lsbCBkbyB0aGlzIGlu
IGEgc3Vic2VxdWVudCBzdWJtaXNzaW9uIHNpbmNlIHRoYXQgY29tbWVudCBhbHNvIGFmZmVjdHMN
CnRoZSBjb21wYXJpc29uIG9wZXJhdG9ycywgc28gdHJlYXRpbmcgaXQgYXMgc2VwYXJhdGUgZnJv
bSB0aGlzIHBhdGNoLg0KDQo+IFRoZSBmb2xsb3dpbmcgdGFibGUgaXMgdGhlIGFsdSBvcGNvZGUg
aW4ga2VybmVsL2JwZi9kaXNhc20uYyAodXNlZCBieSBib3RoDQo+IGtlcm5lbCB2ZXJpZmllciBh
bmQgYnBmdG9vbCB4bGF0ZWQgZHVtcCk6DQo+IA0KPiBjb25zdCBjaGFyICpjb25zdCBicGZfYWx1
X3N0cmluZ1sxNl0gPSB7DQo+ICAgICAgICAgIFtCUEZfQUREID4+IDRdICA9ICIrPSIsDQo+ICAg
ICAgICAgIFtCUEZfU1VCID4+IDRdICA9ICItPSIsDQo+ICAgICAgICAgIFtCUEZfTVVMID4+IDRd
ICA9ICIqPSIsDQo+ICAgICAgICAgIFtCUEZfRElWID4+IDRdICA9ICIvPSIsDQo+ICAgICAgICAg
IFtCUEZfT1IgID4+IDRdICA9ICJ8PSIsDQo+ICAgICAgICAgIFtCUEZfQU5EID4+IDRdICA9ICIm
PSIsDQo+ICAgICAgICAgIFtCUEZfTFNIID4+IDRdICA9ICI8PD0iLA0KPiAgICAgICAgICBbQlBG
X1JTSCA+PiA0XSAgPSAiPj49IiwNCj4gICAgICAgICAgW0JQRl9ORUcgPj4gNF0gID0gIm5lZyIs
DQo+ICAgICAgICAgIFtCUEZfTU9EID4+IDRdICA9ICIlPSIsDQo+ICAgICAgICAgIFtCUEZfWE9S
ID4+IDRdICA9ICJePSIsDQo+ICAgICAgICAgIFtCUEZfTU9WID4+IDRdICA9ICI9IiwNCj4gICAg
ICAgICAgW0JQRl9BUlNIID4+IDRdID0gInM+Pj0iLA0KPiAgICAgICAgICBbQlBGX0VORCA+PiA0
XSAgPSAiZW5kaWFuIiwNCj4gfTsNCj4gDQo+IEFsc28sIGluIERvY3VtZW50YXRpb24vYnBmL2lu
c3RydWN0aW9uLXNldC5yc3Q6DQo+IA0KPiA9PT09PT09PSAgPT09PT0NCj4gPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiBjb2RlICAg
ICAgdmFsdWUgIGRlc2NyaXB0aW9uDQo+ID09PT09PT09ICA9PT09PQ0KPiA9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+IEJQRl9BREQg
ICAweDAwICAgZHN0ICs9IHNyYw0KPiBCUEZfU1VCICAgMHgxMCAgIGRzdCAtPSBzcmMNCj4gQlBG
X01VTCAgIDB4MjAgICBkc3QgXCo9IHNyYw0KPiBCUEZfRElWICAgMHgzMCAgIGRzdCA9IChzcmMg
IT0gMCkgPyAoZHN0IC8gc3JjKSA6IDANCj4gQlBGX09SICAgIDB4NDAgICBkc3QgXHw9IHNyYw0K
PiBCUEZfQU5EICAgMHg1MCAgIGRzdCAmPSBzcmMNCj4gQlBGX0xTSCAgIDB4NjAgICBkc3QgPDw9
IHNyYw0KPiBCUEZfUlNIICAgMHg3MCAgIGRzdCA+Pj0gc3JjDQo+IEJQRl9ORUcgICAweDgwICAg
ZHN0ID0gfnNyYw0KPiBCUEZfTU9EICAgMHg5MCAgIGRzdCA9IChzcmMgIT0gMCkgPyAoZHN0ICUg
c3JjKSA6IGRzdA0KPiBCUEZfWE9SICAgMHhhMCAgIGRzdCBePSBzcmMNCj4gQlBGX01PViAgIDB4
YjAgICBkc3QgPSBzcmMNCj4gQlBGX0FSU0ggIDB4YzAgICBzaWduIGV4dGVuZGluZyBzaGlmdCBy
aWdodA0KPiBCUEZfRU5EICAgMHhkMCAgIGJ5dGUgc3dhcCBvcGVyYXRpb25zIChzZWUgYEJ5dGUg
c3dhcCBpbnN0cnVjdGlvbnNgXyBiZWxvdykNCj4gPT09PT09PT0gID09PT09DQo+ID09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gDQo+
IEluIHRoZSBhYm92ZSwgdGhlIEJQRl9ORUcgaXMgc3BlY2lmaWVkIGFzICdkc3QgPSB+c3JjYCwg
d2hpY2ggaXMgbm90IGNvcnJlY3QsIGl0DQo+IHNob3VsZCBiZSAnZHN0ID0gLWRzdCcuDQo+IA0K
PiBTZWUga2VybmVsL2JwZi9jb3JlLmM6DQo+ICAgICAgICAgIEFMVV9ORUc6DQo+ICAgICAgICAg
ICAgICAgICAgRFNUID0gKHUzMikgLURTVDsNCj4gICAgICAgICAgICAgICAgICBDT05UOw0KPiAg
ICAgICAgICBBTFU2NF9ORUc6DQo+ICAgICAgICAgICAgICAgICAgRFNUID0gLURTVDsNCj4gICAg
ICAgICAgICAgICAgICBDT05UOw0KPiANCj4gQ291bGQgeW91IGhlbHAgZml4IGl0Pw0KDQpZZXMg
SSBjYW4gcHV0IGl0IGludG8gdGhlIHNhbWUgcGF0Y2ggYXMgdGhlIG90aGVyIGNoYW5nZQ0KZGlz
Y3Vzc2VkIGFib3ZlLg0KDQpXb3VsZCBsaWtlIHRvIHNlZSB0aGUgY3VycmVudCBvbmUgbWVyZ2Vk
IHNvIEkgY2FuIGJhc2UNCnRoZSBuZXh0IG9uZSBvbiB0b3Agb2YgdGhpcyBvbmUuDQoNClRoYW5r
cywNCkRhdmUNCg==

