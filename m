Return-Path: <bpf+bounces-7037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDF677099D
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 22:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A298428260A
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 20:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607C01DA25;
	Fri,  4 Aug 2023 20:21:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E171BF1E;
	Fri,  4 Aug 2023 20:21:00 +0000 (UTC)
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021018.outbound.protection.outlook.com [52.101.57.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322144C2F;
	Fri,  4 Aug 2023 13:20:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhsxSM4w5CCWYPZgqRHSggZjlCv1kVq2OEUCvPHahqzL/E7glCAud1J+oA3GL3Rn51OGta6TrD8CkdXWOXXLu8HX+htCx99C02t3x0IatYsQ2NhvM3f08DDeN2ykvD8NuPshpRKR5SF1A7zN8Jgp2avuf50cr01reQUV9FQIUBMBtQW4A+/UA9dsHL/CZq7qkOsV1mOGCRRb5eJmW1H9aBqln7tvK3+mj83cjpDJeGO8gDc8vLIlpeFsQIZrXDRHDDmdPboI6eK9PIs82Q2g6iT7hxKY+MnNrjazwNU4DVeZlrinRzA1QPMq6wjKyhNiHKLrQZnPSttiwZ/8fMT/xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWExkzn5tYpZbwx7nKxSSgWxAy2MwBMp8T+SyUKkp+U=;
 b=OgshAs85grP6kfJRvSpNcCSd6LoXZfkQtL9BmU6BETp379E4iUtwIzgrjqk8O+KAkUQI+px1fS7m9YDgQeNZcBX/Jf3La0ortwpiTHOrXNwFdx5xHU8okSPfu2MPBPxf88iFPQLa0GFJKOUGQxH4oA+oexxs/AoNTKTOeM1fFvm3IREgcttx+mb1jJS7AicLa1Plskw5+tK/4bm3hLCkAED9eP9o8TxBWJBxK1mdlDAXYnxjn2vhj3FSJtNf/zf5uaJK3nYEKx5buqu1PJOXjk60oW5giDvLE2+jTqdZFnT0lHGOAx15DQEy9/Dc8+0bOCOR5ux++EqJI2ksY81byw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWExkzn5tYpZbwx7nKxSSgWxAy2MwBMp8T+SyUKkp+U=;
 b=OY0/enZlaiqApWaknHeDcCit4/4VZuUrN1NGaw+UEdpj41fhBRwCrVyGGmmP+CI1Y17kXlNIy/Ta5/cJrjy5717w5ctdVLZdYnqJz22Iul3YzadUI8PZD4GMnc8OR/GxegLiGJqittk8MHANPdhQdjopr5fJwTHii4u55K3eGSs=
Received: from PH7PR21MB3116.namprd21.prod.outlook.com (2603:10b6:510:1d0::10)
 by CH3PR21MB4019.namprd21.prod.outlook.com (2603:10b6:610:17d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.10; Fri, 4 Aug
 2023 20:20:53 +0000
Received: from PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::d2:cad1:318e:224b]) by PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::d2:cad1:318e:224b%7]) with mapi id 15.20.6678.010; Fri, 4 Aug 2023
 20:20:53 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Dexuan Cui <decui@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Paul
 Rosswurm <paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets
	<vkuznets@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "leon@kernel.org" <leon@kernel.org>,
	Long Li <longli@microsoft.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, Ajay Sharma
	<sharmaajay@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>
Subject: RE: [PATCH V5,net-next] net: mana: Add page pool for RX buffers
Thread-Topic: [PATCH V5,net-next] net: mana: Add page pool for RX buffers
Thread-Index: AQHZxWxElFMJ0At90U2RdnTp8hONm6/XzRoAgAIqxoCAAJsyYA==
Date: Fri, 4 Aug 2023 20:20:53 +0000
Message-ID:
 <PH7PR21MB3116E2C35824D8F673363B36CA09A@PH7PR21MB3116.namprd21.prod.outlook.com>
References: <1690999650-9557-1-git-send-email-haiyangz@microsoft.com>
 <e1093991-6f54-2c8d-c713-babac0d216d4@intel.com>
 <7d159ee4-7361-c04a-681e-1afc74765c5b@kernel.org>
In-Reply-To: <7d159ee4-7361-c04a-681e-1afc74765c5b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=814d23f7-f445-41c9-be70-e58cdf230c62;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-04T20:05:04Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3116:EE_|CH3PR21MB4019:EE_
x-ms-office365-filtering-correlation-id: 96a64def-54ac-4b9c-2e16-08db95284d84
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 MfNFRDbcdpKrXB++LnttB4H/+dP4prA6KEbauaYhv9lOHuq4Uub3QyZv7Zk4YKXkoebrgNzsyOo5XJN+hQILOOh5nVEAqTf2BL7w+Us7NXStzf4HKGmfAI6IVMe5RntLqQ1vX0+xQA7qyXiqrsMFgmL0pEYxcp59NJW3uVOPldjR4pg35Gu/yii04VvhE+qPtbFuR+jASNu2LU+lY0zRzvNhm/U9pUstsnnYUuvIOfrC6PzcE0Q14P8PGDV277n++QYbThDcTKPcbyLdUlV5FiFNlwgE9xbZjTMj09lEXCNEIUFjzNTXheiPxCR2hhz2/eB34cOpPpDs+ydtTpZr6LUlvh1c4iCI/vG+rsWN6NUD9C7jKZQMpmhg9aXP22ndqzxPwryXIV1C1iMc+HJb/4ykOOTDWDkP8pjkAuSoYayxo6IwelBFefc2CeRlTFKwzrY7vyT21LT57U5LGJKAg3oZFlcFaBpEziqvwwkY14idlp6zGGhYwEX3VBMqIYt8rEfeZ1ISJuCg/stz5b1yZFEZ8cwYZVvlXHMYRmiy/AEDqF8S95MZBv1exM4kTxCSdTrN+b4dC75ZLJNW9vvaJLzlfMVUXmAAHBkx17Wf3SJ/qfooWYCKY4WCW0nrF4VX1utcDotr5Y21MsRluzipnD9viesAmClU/oFg3ijUOGQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3116.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199021)(186006)(1800799003)(53546011)(6506007)(5660300002)(10290500003)(478600001)(33656002)(9686003)(8936002)(8676002)(7416002)(71200400001)(8990500004)(26005)(7696005)(55016003)(66946007)(76116006)(66556008)(86362001)(66476007)(82960400001)(66446008)(82950400001)(41300700001)(38070700005)(122000001)(64756008)(4326008)(786003)(316002)(38100700002)(2906002)(110136005)(52536014)(83380400001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RXk3QWEzdkdBYVhISTNmejZQRWVzbFRheXd0MVlLZGlGaHg1MXB5NHQwUHA0?=
 =?utf-8?B?bEtVU2Y4U2hRWTlNOCtIWXQzZVJTWi9HNFJsU3E1NHRSakF2bHZVNG9VTzBV?=
 =?utf-8?B?M1dDUkptWmdwZXFrYWx0UzVvL3N3ZkdpMHdPTWFpa0oyaEdSNVJXNFdCaTMx?=
 =?utf-8?B?MXlyRDZmYXJmaXdmRFJRN2pkanlTR0lJZlh5WTFWVjhyKzlsZ0VsZ1Y5K0Nw?=
 =?utf-8?B?dVRtV0hZV3NKOVBMYTFPV2hqempNVXJtRmpVOFZ1TTdpb3J4SFc3aWhjd0xm?=
 =?utf-8?B?NkdJU3dUUE5DVWd2VFlubElPOCsyV3VwWUEyK0tqMXJwQm4rS3p3dkxDMVZN?=
 =?utf-8?B?eVpUalA4OHFDbU4zZVV4TjJCL01BUGJTYXRwWXQ5cWt0dkk3YVR3VnF3L01x?=
 =?utf-8?B?cDNBUm12S2NsK1FWSTNsWGNPTEFnS3krYUVSZkxyWjFkeW1PMnV0NlRGZ0g4?=
 =?utf-8?B?ZGtoRk5DTUp3Mm5pT2ZObFN0S3YwSFVlOXhpSXIrL1BQdHFaWmpFZjlmUWZx?=
 =?utf-8?B?dmRuTEdjMkJ2ZlpUaDdqVVJRMHVneUp5b2dCTnhZeHpVS2kweEZUa2ZlWDNn?=
 =?utf-8?B?dFdvU3IwR2FmZExyYm1sRkFmQ0lNN2RVZDlaazJLZmVML0VidUwxdERNTHdp?=
 =?utf-8?B?SVZPaXgyQVVubGcvbHlxdksreTRNVVlBVzBWOTRNMHNDRU90YTFGeDJiQU5I?=
 =?utf-8?B?KzdyeXI2SmhXTnBEa05wWDBiZTJ4WXVUOE1TMklGeUwycHhnVm5JYmd5REdR?=
 =?utf-8?B?UUtWM25SeEtlWnRWTXUrU3d6RkFaWmVvRnUvb0ZnNXd0MUtCS2xlSURqTWJ6?=
 =?utf-8?B?aW9INlFIOWN2MnAwcjNkU3YvckdDaDljRVFQOUk4eStOdy9ER2ZQNmtsOWQ1?=
 =?utf-8?B?VmlsVnAyVW8yNzNOQlZ6UnRFdVREc0tCdTdFd3dLbXlxRitFVTBiOFpmMU00?=
 =?utf-8?B?czZ1aEZlOThPRFZuQTlmdHRVZEZ6czUxMjhvM0VYbHJYMm5uOXNRa1RZV2Z4?=
 =?utf-8?B?SENBMThQWjJ6K1ZPZzQ2NEg1VFVJd25xNjdaOUNUNlpBTDJ6aTQ2VU1uWnlN?=
 =?utf-8?B?OVoxTG9hc2FSellJS1pkRmY3QXZhMXA4OWFiRkZjQnQvc3BsNmVOU1hReUtB?=
 =?utf-8?B?MjU0Um5aNUNVSlJxZnBxaVh5ZW5xcEs3LzNUOC82SVMrUlE3YUo4S1BOTWQ0?=
 =?utf-8?B?U3VSSzhBMmswVkhoWGptUE9PdHQ1VHhTZCthTG5DbjVwRExjWmJUUkw4ODNL?=
 =?utf-8?B?Zkc4RENYQTBGTi9xK1VFMWMxV0JZT1VhMS9mbHhKY1BGMklWL3JkWnYyQlJu?=
 =?utf-8?B?Rk43WG5hTmU5V3BoN0FIVmZoT1NocFRDQ0tDQUxvQWowc1dpNWQ5azRBZWVU?=
 =?utf-8?B?T2I5ZFZmbGQ4WWs5UVgxTHFkb2Jjam0vOStZOEVkUjExbkFnNUh1S0FhWmlr?=
 =?utf-8?B?VG9nc3YzU1R2NFpXNnRwQkdDZnl3QW1NTlpjZ3FaYjBNalhER0x0K2krSDdF?=
 =?utf-8?B?dVpSbnlTMXpHTERMbXVLd012TEQzSE45T3oyN2ZBMVoyVnphaDJyNDYwN1Qx?=
 =?utf-8?B?T3F3SkhzTHlGcE5qQlZCWHM5RnZjb1RwWkNZMWJoM09jMW14YUJ3eTJBQnJ2?=
 =?utf-8?B?V1R6NW9FdGdyUGlGYmhpNHNkMmd5ZnZBaXJkcTlvSFZteER5eVBxanFIUEtL?=
 =?utf-8?B?WTNMRWQwdGV3WUd0MzhTUUlYTHVPYnRpV0Z6S3oyRmNhV3o5T00wNjZCQ0lX?=
 =?utf-8?B?emxYdHRYd3dhZDVYM3pCc0gwL2N1dWpCbmp1MWNUdkZxb3BYYUNoaTdnQ25q?=
 =?utf-8?B?dG1WK2hZL0djSFhMeFQwZFFuY3pLK3A2Z21aNnFKbWRUYVJORUR5UWdmVmcx?=
 =?utf-8?B?dFppSUJ0RnQ3aVkxa0dkZG1HUVlidXA2eHNNSWR6NXMxdDgxWWVFZ2pka0ky?=
 =?utf-8?B?c3ErOGNtSlhNMmdGdjExMXdGWmlERCt6VzRnbmlPRTM0VmhKYjhFT0k1dmhL?=
 =?utf-8?B?TGp6MXp1ckNGV2NadWpoT2VXOGpCd1dxR21QOEVXbDRLT01LdlVBSmNoVVF2?=
 =?utf-8?B?dUtqQ3kvNjk1Zy9BS09iRXg1SGVoSVgyQ3BJVXVlaWQ5dFhRVGZTcW1iSURX?=
 =?utf-8?Q?UH9avN38+ZqgAnD5/pvoAqF41?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a64def-54ac-4b9c-2e16-08db95284d84
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 20:20:53.4329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IVIm+6NrSSEdLunMxsjPtLmMyA5d5frm6BZ+qzKQq+KytNYE1w8Vmc6IQhMH/sS3zAMbgqIWALJwrJX/BUsuug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR21MB4019
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmVzcGVyIERhbmdhYXJk
IEJyb3VlciA8aGF3a0BrZXJuZWwub3JnPg0KPiBTZW50OiBGcmlkYXksIEF1Z3VzdCA0LCAyMDIz
IDY6NTAgQU0NCj4gVG86IEplc3NlIEJyYW5kZWJ1cmcgPGplc3NlLmJyYW5kZWJ1cmdAaW50ZWwu
Y29tPjsgSGFpeWFuZyBaaGFuZw0KPiA8aGFpeWFuZ3pAbWljcm9zb2Z0LmNvbT47IGxpbnV4LWh5
cGVydkB2Z2VyLmtlcm5lbC5vcmc7DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IERl
eHVhbiBDdWkgPGRlY3VpQG1pY3Jvc29mdC5jb20+OyBLWSBTcmluaXZhc2FuIDxreXNAbWljcm9z
b2Z0LmNvbT47DQo+IFBhdWwgUm9zc3d1cm0gPHBhdWxyb3NAbWljcm9zb2Z0LmNvbT47IG9sYWZA
YWVwZmxlLmRlOyB2a3V6bmV0cw0KPiA8dmt1em5ldHNAcmVkaGF0LmNvbT47IGRhdmVtQGRhdmVt
bG9mdC5uZXQ7IHdlaS5saXVAa2VybmVsLm9yZzsNCj4gZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3Vi
YUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNvbTsNCj4gbGVvbkBrZXJuZWwub3JnOyBMb25n
IExpIDxsb25nbGlAbWljcm9zb2Z0LmNvbT47DQo+IHNzZW5nYXJAbGludXgubWljcm9zb2Z0LmNv
bTsgbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRhbmllbEBpb2dlYXJib3gubmV0OyBq
b2huLmZhc3RhYmVuZEBnbWFpbC5jb207IGJwZkB2Z2VyLmtlcm5lbC5vcmc7DQo+IGFzdEBrZXJu
ZWwub3JnOyBBamF5IFNoYXJtYSA8c2hhcm1hYWpheUBtaWNyb3NvZnQuY29tPjsgaGF3a0BrZXJu
ZWwub3JnOw0KPiB0Z2x4QGxpbnV0cm9uaXguZGU7IHNocmFkaGFndXB0YUBsaW51eC5taWNyb3Nv
ZnQuY29tOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgSWxpYXMgQXBhbG9kaW1h
cyA8aWxpYXMuYXBhbG9kaW1hc0BsaW5hcm8ub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFY1
LG5ldC1uZXh0XSBuZXQ6IG1hbmE6IEFkZCBwYWdlIHBvb2wgZm9yIFJYIGJ1ZmZlcnMNCj4gDQo+
IA0KPiANCj4gT24gMDMvMDgvMjAyMyAwMy40NCwgSmVzc2UgQnJhbmRlYnVyZyB3cm90ZToNCj4g
PiBPbiA4LzIvMjAyMyAxMTowNyBBTSwgSGFpeWFuZyBaaGFuZyB3cm90ZToNCj4gPj4gQWRkIHBh
Z2UgcG9vbCBmb3IgUlggYnVmZmVycyBmb3IgZmFzdGVyIGJ1ZmZlciBjeWNsZSBhbmQgcmVkdWNl
IENQVQ0KPiA+PiB1c2FnZS4NCj4gPj4NCj4gDQo+IENhbiB5b3UgYWRkIHNvbWUgaW5mbyBvbiB0
aGUgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQgdGhpcyBwYXRjaCBnaXZlcz8NCkkgd2lsbCBhZGQg
dGhpcyB0byB0aGUgcGF0Y2ggZGVzY3JpcHRpb24uDQoNCj4gDQo+IFlvdXIgcHJldmlvdXMgcG9z
dCBtZW50aW9uZWQ6DQo+ICA+IFdpdGggaXBlcmYgYW5kIDEyOCB0aHJlYWRzIHRlc3QsIHRoaXMg
cGF0Y2ggaW1wcm92ZWQgdGhlIHRocm91Z2hwdXQNCj4gYnkgMTItMTUlLCBhbmQgZGVjcmVhc2Vk
IHRoZSBJUlEgYXNzb2NpYXRlZCBDUFUncyB1c2FnZSBmcm9tIDk5LTEwMCUgdG8NCj4gMTAtNTAl
Lg0KPiANCj4gDQo+ID4+IFRoZSBzdGFuZGFyZCBwYWdlIHBvb2wgQVBJIGlzIHVzZWQuDQo+ID4+
DQo+ID4+IFNpZ25lZC1vZmYtYnk6IEhhaXlhbmcgWmhhbmcgPGhhaXlhbmd6QG1pY3Jvc29mdC5j
b20+DQo+ID4+IC0tLQ0KPiA+PiBWNToNCj4gPj4gSW4gZXJyIHBhdGgsIHNldCBwYWdlX3Bvb2xf
cHV0X2Z1bGxfcGFnZSguLi4sIGZhbHNlKSBhcyBzdWdnZXN0ZWQgYnkNCj4gPj4gSmFrdWIgS2lj
aW5za2kNCj4gPj4gVjQ6DQo+ID4+IEFkZCBuaWQgc2V0dGluZywgcmVtb3ZlIHBhZ2VfcG9vbF9u
aWRfY2hhbmdlZCgpLCBhcyBzdWdnZXN0ZWQgYnkNCj4gPj4gSmVzcGVyIERhbmdhYXJkIEJyb3Vl
cg0KPiA+PiBWMzoNCj4gPj4gVXBkYXRlIHhkcCBtZW0gbW9kZWwsIHBvb2wgcGFyYW0sIGFsbG9j
IGFzIHN1Z2dlc3RlZCBieSBKYWt1YiBLaWNpbnNraQ0KPiA+PiBWMjoNCj4gPj4gVXNlIHRoZSBz
dGFuZGFyZCBwYWdlIHBvb2wgQVBJIGFzIHN1Z2dlc3RlZCBieSBKZXNwZXIgRGFuZ2FhcmQgQnJv
dWVyDQo+ID4+IC0tLQ0KPiA+DQo+ID4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL25ldC9tYW5hL21h
bmEuaCBiL2luY2x1ZGUvbmV0L21hbmEvbWFuYS5oDQo+ID4+IGluZGV4IDAyNGFkOGRkYjI3ZS4u
YjEyODU5NTExODM5IDEwMDY0NA0KPiA+PiAtLS0gYS9pbmNsdWRlL25ldC9tYW5hL21hbmEuaA0K
PiA+PiArKysgYi9pbmNsdWRlL25ldC9tYW5hL21hbmEuaA0KPiA+PiBAQCAtMjgwLDYgKzI4MCw3
IEBAIHN0cnVjdCBtYW5hX3JlY3ZfYnVmX29vYiB7DQo+ID4+ICAgCXN0cnVjdCBnZG1hX3dxZV9y
ZXF1ZXN0IHdxZV9yZXE7DQo+ID4+DQo+ID4+ICAgCXZvaWQgKmJ1Zl92YTsNCj4gPj4gKwlib29s
IGZyb21fcG9vbDsgLyogYWxsb2NhdGVkIGZyb20gYSBwYWdlIHBvb2wgKi8NCj4gPg0KPiA+IHN1
Z2dlc3QgeW91IHVzZSBmbGFncyBhbmQgbm90IGJvb2xzLCBhcyBib29scyB3YXN0ZSA3IGJpdHMg
ZWFjaCwgcGx1cw0KPiA+IHlvdXIgcGFja2luZyBvZiB0aGlzIHN0cnVjdCB3aWxsIGJlIGZ1bGwg
b2YgaG9sZXMsIG1hZGUgd29yc2UgYnkgdGhpcw0KPiA+IHBhdGNoLiAoc2VlIHBhaG9sZSB0b29s
KQ0KPiA+DQo+IA0KPiBBZ3JlZWQuDQpUaGFua3MsIEkgd2lsbCBkbyB0aGlzIHdoZW4gYWRkaW5n
IG1vcmUgZmxhZ3MgaW4gZnV0dXJlIHBhdGNoZXMuDQoNCj4gDQo+ID4NCj4gPj4NCj4gPj4gICAJ
LyogU0dMIG9mIHRoZSBidWZmZXIgZ29pbmcgdG8gYmUgc2VudCBoYXMgcGFydCBvZiB0aGUgd29y
ayByZXF1ZXN0LiAqLw0KPiA+PiAgIAl1MzIgbnVtX3NnZTsNCj4gPj4gQEAgLTMzMCw2ICszMzEs
OCBAQCBzdHJ1Y3QgbWFuYV9yeHEgew0KPiA+PiAgIAlib29sIHhkcF9mbHVzaDsNCj4gPj4gICAJ
aW50IHhkcF9yYzsgLyogWERQIHJlZGlyZWN0IHJldHVybiBjb2RlICovDQo+ID4+DQo+ID4+ICsJ
c3RydWN0IHBhZ2VfcG9vbCAqcGFnZV9wb29sOw0KPiA+PiArDQo+ID4+ICAgCS8qIE1VU1QgQkUg
VEhFIExBU1QgTUVNQkVSOg0KPiA+PiAgIAkgKiBFYWNoIHJlY2VpdmUgYnVmZmVyIGhhcyBhbiBh
c3NvY2lhdGVkIG1hbmFfcmVjdl9idWZfb29iLg0KPiA+PiAgIAkgKi8NCj4gPg0KPiA+DQo+ID4g
VGhlIHJlc3Qgb2YgdGhlIHBhdGNoIGxvb2tzIG9rIGFuZCBpcyByZW1hcmthYmx5IGNvbXBhY3Qg
Zm9yIGENCj4gPiBjb252ZXJzaW9uIHRvIHBhZ2UgcG9vbC4gSSdkIHByZWZlciBzb21lb25lIHdp
dGggbW9yZSBwYWdlIHBvb2wgZXhwb3N1cmUNCj4gPiByZXZpZXcgdGhpcyBmb3IgY29ycmVjdG5l
c3MsIGJ1dCBGV0lXDQo+ICA+DQo+IA0KPiBCb3RoIEpha3ViIGFuZCBJIGhhdmUgcmV2aWV3ZWQg
dGhlIHBhZ2VfcG9vbCBwYXJ0cywgYW5kIEkgdGhpbmsgd2UgYXJlDQo+IGluIGEgZ29vZCBwbGFj
ZS4NCj4gDQo+IExvb2tpbmcgYXQgdGhlIGRyaXZlciwgSSB3b25kZXIgd2h5IHlvdSBhcmUga2Vl
cGluZyB0aGUgZHJpdmVyIGxvY2FsDQo+IG1lbW9yeSBjYWNoZSAod2hlbiBQUCBpcyBhbHNvIGNv
bnRhaW5zIGEgbWVtb3J5IGNhY2hlKSA/DQo+IChJIGFzc3VtZSB0aGVyZSBpcyBhIGdvb2QgcmVh
c29uLCBzbyB0aGlzIGlzIG5vdCBibG9ja2luZyBwYXRjaCkNCg0KWW91IG1lYW4gdGhlICJlbHNl
IiBwYXJ0IG9mIHRoZSBjb2RlIGJlbG93PyBJdCdzIGZvciBhIGNvbXBvdW5kIHBhZ2UgZnJvbQ0K
bmFwaV9hbGxvY19mcmFnKCksIG5vdCBmcm9tIHRoZSBwb29sLiBJZiBhbnkgZXJyb3IgaGFwcGVu
cywgIHdlIHNhdmUgaXQNCmxvY2FsbHkgZm9yIHJlLXVzZS4NCg0KZHJvcDoNCiAgICAgICAgaWYg
KGZyb21fcG9vbCkgew0KICAgICAgICAgICAgICAgIHBhZ2VfcG9vbF9yZWN5Y2xlX2RpcmVjdChy
eHEtPnBhZ2VfcG9vbCwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dmlydF90b19oZWFkX3BhZ2UoYnVmX3ZhKSk7DQogICAgICAgIH0gZWxzZSB7DQogICAgICAgICAg
ICAgICAgV0FSTl9PTl9PTkNFKHJ4cS0+eGRwX3NhdmVfdmEpOw0KICAgICAgICAgICAgICAgIC8q
IFNhdmUgZm9yIHJldXNlICovDQogICAgICAgICAgICAgICAgcnhxLT54ZHBfc2F2ZV92YSA9IGJ1
Zl92YTsNCiAgICAgICAgfQ0KDQoNCj4gDQo+ID4NCj4gPiBSZXZpZXdlZC1ieTogSmVzc2UgQnJh
bmRlYnVyZyA8amVzc2UuYnJhbmRlYnVyZ0BpbnRlbC5jb20+DQo+IA0KPiBUaGFua3MgZm9yIHRh
a2luZyB5b3VyIHRpbWUgdG8gcmV2aWV3Lg0KPiANCj4gSSdtIHJlYWR5IHRvIEFDSyBvbmNlIHRo
ZSBkZXNjcmlwdGlvbiBpcyBpbXByb3ZlZCBhIGJpdCA6LSkNCj4gDQo+IC0tSmVzcGVyDQo+IHB3
LWJvdDogY3INCg==

