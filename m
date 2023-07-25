Return-Path: <bpf+bounces-5859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EED877621F7
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 21:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF4A1C20C92
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 19:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93055263C2;
	Tue, 25 Jul 2023 19:02:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540ED1D2FD;
	Tue, 25 Jul 2023 19:02:18 +0000 (UTC)
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021026.outbound.protection.outlook.com [52.101.62.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C366D121;
	Tue, 25 Jul 2023 12:02:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPWnA40nqfwSCIBf3EpHAVAxs4CcFIUT4/sS3MOgJkUDf9GIVX5vphY8W1ayA9D5P7WRHs91qM+3nMJ+qdVH5Ql5G8OEfn6nGTdwraQeUIpxhdMf/9nxGGxevGo+ke+IRoy0WL0Rkr0HaarcL1Kz/kjBgAAqib+/P3CjAPnj48mim5g1Pq+pOQXDl6VXRPkR9IuiuSHkfinRBgSGBPusZWQ3JGjnfwLMa8mcr8xv3CCpcupbhScU9oJn8HRGZvV2RiGv66GWQo+WhZ+RrxzVJL97BYCjVkwIDoKav1jGyNBTe8Vx1MzH99AbmLOqE3T4rU3QcFmjq+nJ0ZwkIqxetA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sftyt76KOmFZPcSMea8jiZ88u+09UDBK2DkDz9iF6x4=;
 b=dVqR8qIOGgovdz8DwXkzRVhzNv2PHF7L133U/vd0fSADiAZIp9nEahkD5/f0rpIN60BmBz20OQHmbv2U95jLriUH6ygNLhYUKb6M9B0zxPLf9x5aUJBs6UVkFIwn996PHOF7e1jNn4fmcJbl1EeWdw+xR4elX6J2JN3Ry9jLZ1coqkuFN4r5N1NzCVU+fmeyO2gUuTC48QISPoEUwVa9oRLdB5mh08OB3lfjV1eN5higP6uH9e9eRj3NPzz2dPnSaw3F1jyr+CENXeik/sB2A3dYfBvsE8tTHiqBgGlKYglTQvCXUJ2Biym4x8PqrlXVIZsddJHNSc4l4zsIwvzMzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sftyt76KOmFZPcSMea8jiZ88u+09UDBK2DkDz9iF6x4=;
 b=iDJJIIuMD7vgAC8wQVWwc+w9DzCg683djDIR9dowB7TO+IQSxNeU72V1xrB8q3lojz4lev7BUBoH+vxCHMfn5Xjz2fSFIFUZUh004SkaJ7ZeLLueo6YRTT06b010dxGCzctc8xy6dunrIuAVwJeOyBygiaEICUIED6bglcYBo3k=
Received: from PH7PR21MB3116.namprd21.prod.outlook.com (2603:10b6:510:1d0::10)
 by SJ0PR21MB2072.namprd21.prod.outlook.com (2603:10b6:a03:397::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.4; Tue, 25 Jul
 2023 19:02:10 +0000
Received: from PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::d2:cad1:318e:224b]) by PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::d2:cad1:318e:224b%7]) with mapi id 15.20.6652.002; Tue, 25 Jul 2023
 19:02:10 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jesper Dangaard Brouer <jbrouer@redhat.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "brouer@redhat.com" <brouer@redhat.com>, Dexuan Cui <decui@microsoft.com>,
	KY Srinivasan <kys@microsoft.com>, Paul Rosswurm <paulros@microsoft.com>,
	"olaf@aepfle.de" <olaf@aepfle.de>, "vkuznets@redhat.com"
	<vkuznets@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "leon@kernel.org" <leon@kernel.org>,
	Long Li <longli@microsoft.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, Ajay Sharma
	<sharmaajay@microsoft.com>, "hawk@kernel.org" <hawk@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>
Subject: RE: [PATCH V3,net-next] net: mana: Add page pool for RX buffers
Thread-Topic: [PATCH V3,net-next] net: mana: Add page pool for RX buffers
Thread-Index: AQHZvAZSl8pOb40fXE2pDlV9gZuDN6/IzCkAgABE5NCAADEEcIABidWAgAANWGA=
Date: Tue, 25 Jul 2023 19:02:10 +0000
Message-ID:
 <PH7PR21MB3116F5612AA8303512EEBA4CCA03A@PH7PR21MB3116.namprd21.prod.outlook.com>
References: <1689966321-17337-1-git-send-email-haiyangz@microsoft.com>
 <1af55bbb-7aff-e575-8dc1-8ba64b924580@redhat.com>
 <PH7PR21MB3116F8A97F3626AB04915B96CA02A@PH7PR21MB3116.namprd21.prod.outlook.com>
 <PH7PR21MB311675E57B81B49577ADE98FCA02A@PH7PR21MB3116.namprd21.prod.outlook.com>
 <729b360c-4d79-1025-f5be-384b17f132d3@redhat.com>
In-Reply-To: <729b360c-4d79-1025-f5be-384b17f132d3@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=60666082-2b7c-425c-aa9e-f9d880f18a60;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-25T18:48:48Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3116:EE_|SJ0PR21MB2072:EE_
x-ms-office365-filtering-correlation-id: bdd4ce79-0d46-4e3c-4c44-08db8d41a648
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tnr2e71rw9y+LKwDORVZVTWdpig3R2o3BrUdXePNurngvucccGkjXBs3BuysT2xxkFAeU++uSx08br58ct41u9Q12j4+dJPGeGQL1izkoH9JpcoIFP4WDCp0Tl457NKLrUxC83OTNUrMovQ0aS4Xrw4QoAzFY/aw4k28ZpKU3qEKIl+iwN1hgaixm3rokulJfeCebsDAHYkz7MgbU7JRuTrUsNU4U2if3QoOOBNAoBGDqXFSSOUDnS0VGIHab5o+qg6Jd98l6SZ6TRbbznTHWZt8pyZT0zrmiwvdsjrC7kxu5h4qoHBTnVpJ90C65OJqasdYef/H1Mf1ILVI/2qo/g9UIjcF28heavlSjHF1GOfb1OJ2WxwAGU6qbWaSe9pf/ZoE61XB5pg2gAr55PL/VFnE+9WcBzzhR7jK9DmfPIreLPI3rVrsqwC/mSD6zjeNSOVLmMooF7Ppq8k+xTGqYrC5blfPPI9oq6C+wvtSNVXkyGqZh1KMYcD/MDfP6UgUlWvJHPtkgzphXtVu9J//zbo+p30CWEuLfEXRN6JpvQg8TtiDJE0+7kurOTOs7OQu1MQsnzZ72LdGRzzVq7hdhCHrd7rVIQcwrcIFedl6eeizGFSsnpkX5+nz8O8Q2Rnwt8yPxDzM8gUhXOyd18BhZUCC+PS6Hl3QS/qq21QIZ20=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3116.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199021)(38070700005)(83380400001)(82950400001)(38100700002)(122000001)(82960400001)(9686003)(2906002)(33656002)(186003)(6506007)(26005)(8990500004)(86362001)(52536014)(478600001)(5660300002)(10290500003)(55016003)(71200400001)(7416002)(7696005)(41300700001)(110136005)(4326008)(64756008)(66556008)(66476007)(54906003)(8936002)(66446008)(316002)(76116006)(66946007)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZEdjOWhSWEVjS0FMNnhva0VBaEU5ZHd6TnVyTzY0SVdxa1RFay9OREI5aXNt?=
 =?utf-8?B?K0NUdUdUQWtsTVl1WWlOYW92WlRyeHI3UWNaVWtON0YxcWNUWFJiWDlDaXk2?=
 =?utf-8?B?YndQRHRLVHJwKzBDc0ZFalc1MTFrZ2NXS1U5akd6ZmpZOTUxSWljMnBXNWhS?=
 =?utf-8?B?bkRYajNIcXRITVJLVGRUaWtFOFFSQ3dSRHVOemxPUmZORGdVb2xGRFQrSU14?=
 =?utf-8?B?RVhEeitNWFpXSEFodEh2d1YrT05mRWFaVHV1SzFkY3NZTWlrUWZyall2SWJO?=
 =?utf-8?B?RjRPeUcveEpmWnJYZW9GN3B0ZHhBSjhMQVZNVGxmNUZMdkNwMFdiSEdZanhV?=
 =?utf-8?B?RnE1QlRNamIyeldOdldheDF3N2RjTHI5RDduOXFGNGZKNDY2ekxTNnZ4NU1R?=
 =?utf-8?B?cThUWldFcms2a250WU01SGt6WEFOTHV1aFN0ZGR0dkZodytzOEE4ZjFWdXFz?=
 =?utf-8?B?VFJFNTVGMmFTTUFPcmoySENmOWFjd1VmWWI0S2VXWms4SjlWY1NHaHM3cnBv?=
 =?utf-8?B?Y1VEUldIREhiM2thZzVLQTR5Z25UK09MRnZXUWQra0F5dWd6Mnl3ZVJxZ2Nr?=
 =?utf-8?B?MS94RVZjNXRFdkk2UWVPMlA2RHEybW8yTHZ0T2s1bEthMldnM1R4anNWR0I4?=
 =?utf-8?B?VStXVGhpT0RnVzY0THBSTCtCRXhFZGwzK3l6YUcxeDFxdHlOa0hrMHAyRERr?=
 =?utf-8?B?SHNjSVdHM1o3dnMwbXh0NUk0eDd6ZGgzQmlzeUZlNDRVZTQ5dS9IYkRDZE5V?=
 =?utf-8?B?TjFwYkhObGtYVUtsaThiNHREKzZVcTlhcGdIdTZIRmg4UjdNakdqY09UaHpZ?=
 =?utf-8?B?bTZ0cHFqek5kSFF3T0FDOHBGTlRyRjZ0Y0ZVbmRJMzduSy9Vdjg3bWp5dWNr?=
 =?utf-8?B?WFBuVE1IZmdzSHpWRGp3c1B1KzdQSUNtVGtXa3IvcXk0ZUVEWlViNk9SWlRR?=
 =?utf-8?B?TDFiUWtlK1gvQkRUcGMzODAydWdqYkVnR1dnZ3ZxamhjdDJNc3UvbERBcjFM?=
 =?utf-8?B?UTduUFU4OTBRd3lCcWRlSktqTk8vUGY1R2ZHUGF6U2xjQll2SWptb0VlTUVV?=
 =?utf-8?B?alRGT2x1V3VueU9VV2pPUHF5UE9Qc0I3cFBLV2RSaUM5NTZCdlN5b0hSWHJk?=
 =?utf-8?B?YndYVHBkN2RLMXlkRDdtQjVFdUJXZ1pDc3pnQWVrQm5GSW04YStJRFJUMXMv?=
 =?utf-8?B?aFFqOXNVc2RPQlB6K2FVbEMxZktaS0YweFZMZktFcUJLdGFMN3RYd1Juek83?=
 =?utf-8?B?cHBoSTl5QzRZYmhXa2lKQzJMRXlQZW9uWnBnZGpadjZEbGl0UkRZZ2ViNnl6?=
 =?utf-8?B?NHNBdGpDbFJOcjZuR29LbVVMRVlqYWVGM0RQbDlWWjNTcWJpbXFQMm01dDhO?=
 =?utf-8?B?ZjRYcEVZbjVrSlJQaFkzbVF3WDF0ZlRsdkNpUjlIazB2M2h2MDRldTI4ZzRE?=
 =?utf-8?B?bkFXcExuZlQ1Z0ZvL3dER01Oa29LQXNTVlcxRGp5MjcxeXhKVzBYb1RTWUJH?=
 =?utf-8?B?dWF2dFhuVDlxRE9qVThCK2k3SWlQOElUckdsWGIyRXEwZ2RFNUFmK1dGTXho?=
 =?utf-8?B?WWRGQnowZzNZWXphUEN4VlphbVBzWGUyOHRVamlrRzk1QjVVZW1FVHlQZkFh?=
 =?utf-8?B?YXpiN3pyY2VJa29pMmlYeGFvczZxZ0xtdVpuMXZrNDJrNkh6Zmk4Qnd5MHJW?=
 =?utf-8?B?SjNhcERUMVlwMlVhMUtvQVZGaEhrd1J1eDY5aXZVeDV5V1VPTzRHN1ZkY216?=
 =?utf-8?B?b05YbU1lZ2dTUFFjL0RyR3hNNEs4aUNyVXhRc0FLT2RqblNvd3dIbmpxTlVD?=
 =?utf-8?B?ZXFaeDgwb3phT3cyQzVWQXczdDUxbVFCWDdzVUVPUjJ3VU1lWXRIZDhGMjd1?=
 =?utf-8?B?YWFjZm5EdmlndFFZR05Zanh4dU90bXlybDhHYWRrR0t6TTc1UXcyZkFVQ0lx?=
 =?utf-8?B?SUNGNU1CNWhmK2tPZjNBT0owNWZOQXp3TExYdEJjbGN1cVl4Nm1jVlpOTGNB?=
 =?utf-8?B?Q2FuQ0xYVU9qZ1ZOVE1jUDgycGc1c1dRV1Urc1JjbndCUWZuWmhVc1VNbk9t?=
 =?utf-8?B?SzVlTUZqMWpJUkhqYzI3UkFOdmxjNHFNTVUxZytYY1J1SmZ4SlhVSmFvbW1Z?=
 =?utf-8?Q?H4Hp/0dqXq9sRxn0JTwDqjnXb?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3116.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd4ce79-0d46-4e3c-4c44-08db8d41a648
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 19:02:10.4963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PgtB1DF3j6rGIVm4byXNjHBPZh5/YKotF6A4tF7KKL8OMl2erXvPKhZoKYd+5BHFZfxrHfc5HyJlkoJuHifejQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB2072
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmVzcGVyIERhbmdhYXJk
IEJyb3VlciA8amJyb3VlckByZWRoYXQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBKdWx5IDI1LCAy
MDIzIDI6MDEgUE0NCj4gPj4NCj4gPj4gT3VyIGRyaXZlciBpcyB1c2luZyBOVU1BIDAgYnkgZGVm
YXVsdCwgc28gSSBpbXBsaWNpdGx5IGFzc2lnbiBOVU1BIG5vZGUgaWQNCj4gPj4gdG8gemVybyBk
dXJpbmcgcG9vbCBpbml0Lg0KPiA+Pg0KPiA+PiBBbmQsIGlmIHRoZSBJUlEvQ1BVIGFmZmluaXR5
IGlzIGNoYW5nZWQsIHRoZSBwYWdlX3Bvb2xfbmlkX2NoYW5nZWQoKQ0KPiA+PiB3aWxsIHVwZGF0
ZSB0aGUgbmlkIGZvciB0aGUgcG9vbC4gRG9lcyB0aGlzIHNvdW5kIGdvb2Q/DQo+ID4+DQo+ID4N
Cj4gPiBBbHNvLCBzaW5jZSBvdXIgZHJpdmVyIGlzIGdldHRpbmcgdGhlIGRlZmF1bHQgbm9kZSBm
cm9tIGhlcmU6DQo+ID4gCWdjLT5udW1hX25vZGUgPSBkZXZfdG9fbm9kZSgmcGRldi0+ZGV2KTsN
Cj4gPiBJIHdpbGwgdXBkYXRlIHRoaXMgcGF0Y2ggdG8gc2V0IHRoZSBkZWZhdWx0IG5vZGUgYXMg
YWJvdmUsIGluc3RlYWQgb2YgaW1wbGljaXRseQ0KPiA+IGFzc2lnbmluZyBpdCB0byAwLg0KPiA+
DQo+IA0KPiBJbiB0aGF0IGNhc2UsIEkgYWdyZWUgdGhhdCBpdCBtYWtlIHNlbnNlIHRvIHVzZSBk
ZXZfdG9fbm9kZSgmcGRldi0+ZGV2KSwNCj4gbGlrZToNCj4gCXBwcm0ubmlkID0gZGV2X3RvX25v
ZGUoJnBkZXYtPmRldik7DQo+IA0KPiBEcml2ZXIgbXVzdCBoYXZlIGEgcmVhc29uIGZvciBhc3Np
Z25pbmcgZ2MtPm51bWFfbm9kZSBmb3IgdGhpcyBoYXJkd2FyZSwNCj4gd2hpY2ggaXMgb2theS4g
VGhhdCBpcyB3aHkgcGFnZV9wb29sIEFQSSBhbGxvd3MgZHJpdmVyIHRvIGNvbnRyb2wgdGhpcy4N
Cj4gDQo+IEJ1dCB0aGVuIEkgZG9uJ3QgdGhpbmsgeW91IHNob3VsZCBjYWxsIHBhZ2VfcG9vbF9u
aWRfY2hhbmdlZCgpIGxpa2UNCj4gDQo+IAlwYWdlX3Bvb2xfbmlkX2NoYW5nZWQocnhxLT5wYWdl
X3Bvb2wsIG51bWFfbWVtX2lkKCkpOw0KPiANCj4gQmVjYXVzZSB0aGVuIHlvdSB3aWxsIChhdCBm
aXJzdCBwYWNrZXQgcHJvY2Vzc2luZyBldmVudCkgcmV2ZXJ0IHRoZQ0KPiBkZXZfdG9fbm9kZSgp
IHNldHRpbmcgdG8gdXNlIG51bWFfbWVtX2lkKCkgb2YgcHJvY2Vzc2luZy9ydW5uaW5nIENQVS4N
Cj4gKEluIGVmZmVjdCB0aGlzIHdpbGwgYmUgdGhlIHNhbWUgYXMgc2V0dGluZyBOVU1BX05PX05P
REUpLg0KPiANCj4gSSBrbm93LCBtbHg1IGRvIGNhbGwgcGFnZV9wb29sX25pZF9jaGFuZ2VkKCks
IGJ1dCB0aGV5IHNob3dlZCBiZW5jaG1hcmsNCj4gbnVtYmVycyB0aGF0IHRoaXMgd2FzIHByZWZl
cnJlZCBhY3Rpb24sIGV2ZW4td2hlbiBzeXNhZG0gaGFkDQo+ICJtaXNjb25maWd1cmVkIiB0aGUg
ZGVmYXVsdCBzbXBfYWZmaW5pdHkgUlgtcHJvY2Vzc2luZyB0byBoYXBwZW4gb24gYQ0KPiByZW1v
dGUgTlVNQSBub2RlLiAgQUZBSUsgbWx4NSBrZWVwcyB0aGUgZGVzY3JpcHRvciByaW5ncyBvbiB0
aGUNCj4gb3JpZ2luYWxseSBjb25maWd1cmVkIE5VTUEgbm9kZSB0aGF0IGNvcnJlc3BvbmRzIHRv
IHRoZSBOSUMgUENJZSBzbG90Lg0KDQpJbiBtYW5hX2dkX3NldHVwX2lycXMoKSwgd2Ugc2V0IHRo
ZSBkZWZhdWx0IElSUS9DUFUgYWZmaW5pdHkgdG8gZ2MtPm51bWFfbm9kZSANCnRvbywgc28gaXQg
d29uJ3QgcmV2ZXJ0IHRoZSBuaWQgaW5pdGlhbCBzZXR0aW5nLiANCg0KQ3VycmVudGx5LCB0aGUg
QXp1cmUgaHlwZXJ2aXNvciBhbHdheXMgaW5kaWNhdGVzIG51bWEgMCBhcyBkZWZhdWx0LiAoSW4g
DQp0aGUgZnV0dXJlLCBpdCB3aWxsIHN0YXJ0IHRvIHByb3ZpZGUgdGhlIGFjY3VyYXRlIGRlZmF1
bHQgZGV2IG5vZGUuKSBXaGVuIGEgDQp1c2VyIG1hbnVhbGx5IGNoYW5nZXMgdGhlIElSUS9DUFUg
YWZmaW5pdHkgZm9yIHBlcmYgdHVuaW5nLCB3ZSB3YW50IHRvIA0KYWxsb3cgcGFnZV9wb29sX25p
ZF9jaGFuZ2VkKCkgdG8gdXBkYXRlIHRoZSBwb29sLiBJcyB0aGlzIE9LPw0KDQpUaGFua3MsDQot
IEhhaXlhbmcNCg0K

