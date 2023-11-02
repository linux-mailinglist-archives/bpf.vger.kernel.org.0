Return-Path: <bpf+bounces-14000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 062347DF99C
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 19:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 709EEB21201
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 18:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA99A21115;
	Thu,  2 Nov 2023 18:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="F0+5NCSz"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6796F2110F
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 18:11:11 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5BD269D
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 11:09:43 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3A2GZa8k001577
	for <bpf@vger.kernel.org>; Thu, 2 Nov 2023 11:09:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=HM1QjZOC7o6hmPtuzyO+T06BTljx7hXeVsSHH2wmteE=;
 b=F0+5NCSz4NgOVy6R5nJCdVWaX1NhTqaETNQwVSNEBY7YGVaa2K8EJMSGpFnUhdA3lmTH
 U2iQ/eXOSbR0rk4CV8AwquyqC+a8TJ5GoFZNKftiTsGPIS/4AQzQf6jtSklXHaNvyTr+
 bH7XyzVrq7Q+uCakHPlqe64DecM6IztAKZ+pDXqTCzuPl7Yni135U1k3vjQJnlSWtpyE
 pzX0S6xrRF8EnY9YoPLDeDRXlceKaGmhH+O/QrskIhWyHjhiwdhjzuXofx2OuVndtg+/
 ncQdZy6iEq3YGg0hMtMB5jzHqezXVnXSCBE/k68Bxi//sGhmwgEEuzZpL0MT6iYgHZTQ wg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by m0089730.ppops.net (PPS) with ESMTPS id 3u3ytff6sx-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 11:09:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eH3HlKZPf1Gfjb+oPCi7jbQAyD0OD9T/q6FwE3K4/kZZLR3CJ5rpCkpkJlGKaCLoZsjL0PekeuLZM1pMA+oI9UZ6XEfl82mEuUUZ1RHULNfZCpzbAUiz9KVIl3m0ZkEiX3+HJvs3ZUTgtsbMR9Avj+Ozn/yLi7cruvWT0zkSONbsUWYWPNzlzXoCqtORWDySjswOPGfLfiPlnuEPPNG4uSGETdYPbBZOuRabZwb922USbPfZ9HSeeA0CA97eFiuryUsG+Oeu3ep33bqo6GqSpB8YEg6qxF+2YYsa9mynUjuzHVsJkQi0Ciu7sVLp2ne/m8qcT43EqLvQDf4UxKG7tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HM1QjZOC7o6hmPtuzyO+T06BTljx7hXeVsSHH2wmteE=;
 b=Z1D20hoiKI+IfSbNfOHr4k3RxW4CW0Sr3zjYoC4GVnfbhGq7gXswgKM8iOcf1UCTyZYI7HsBZWIMevqDsSMrl9z4ExqafikitPG+LOrV/wQ26kEf9ToSySN0L1TrJIzbB3er5ZXDpQ+YlyMOBuqgXfdR2S7Z5qYgGtRA5xhyQ5sEg4eBs5xJ13WHRwrbGFEs9YlgiUKekRObE119cbiW53htNKxh1bvTI5y268BPlBeR83pA8U8GOMJq0WYafG1BStLnoGBftbQ0N70L/yaY7NTKcNWcCHX8Ujz+Zva9dc+Nj+lkqLxzSfNUGWZ6JIKq6MONkfKxtnjHzzny7/gLbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH0PR15MB5117.namprd15.prod.outlook.com (2603:10b6:510:c4::8)
 by IA1PR15MB6269.namprd15.prod.outlook.com (2603:10b6:208:450::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 18:09:24 +0000
Received: from PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::9255:45ad:aadf:e172]) by PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::9255:45ad:aadf:e172%6]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 18:09:24 +0000
From: Song Liu <songliubraving@meta.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        "fsverity@lists.linux.dev" <fsverity@lists.linux.dev>,
        Alexei Starovoitov
	<ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko
	<andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team
	<kernel-team@meta.com>,
        Eric Biggers <ebiggers@kernel.org>, Theodore Ts'o
	<tytso@mit.edu>,
        "roberto.sassu@huaweicloud.com"
	<roberto.sassu@huaweicloud.com>
Subject: Re: [PATCH v6 bpf-next 1/9] bpf: Expose bpf_dynptr_slice* kfuncs for
 in kernel use
Thread-Topic: [PATCH v6 bpf-next 1/9] bpf: Expose bpf_dynptr_slice* kfuncs for
 in kernel use
Thread-Index: AQHaBtWtXGZzUbSmaEqOAh6YLQP6IbBnTUAAgAADvYCAAAHqAIAADs0A
Date: Thu, 2 Nov 2023 18:09:24 +0000
Message-ID: <15A85D6B-56E5-4C9F-B7AB-A62F3DA8294C@fb.com>
References: <20231024235551.2769174-1-song@kernel.org>
 <20231024235551.2769174-2-song@kernel.org>
 <CAEf4Bzbr8dgksh2z+4nEkAFdV9gquhR+HROULKdTkWrUpSM9-Q@mail.gmail.com>
 <CAEf4BzbDFDX30Y_Hcmd__hgDp+m6X+htr-wTeBtaoauEnrEdLw@mail.gmail.com>
 <CAEf4BzaD+FV_PM8_4yWnZVed9pXE-KX6CwpYEmiUDpMRQDNEXQ@mail.gmail.com>
In-Reply-To: 
 <CAEf4BzaD+FV_PM8_4yWnZVed9pXE-KX6CwpYEmiUDpMRQDNEXQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.100.2.1.4)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR15MB5117:EE_|IA1PR15MB6269:EE_
x-ms-office365-filtering-correlation-id: 74af980c-7691-4c9b-f4d2-08dbdbced89f
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 7DCg+aZinLhwuFLHHy5E32sz1ll5YxTCeCtl4WrkUNqMPiOc2ctay9yyGFosVFzvKqbaS97+kt66s64JpLhsSl7vYjlyLyoZb3T0uZEpg07+PvA7lx8fO+xvekfsePkOiamoCBP1AZWcrVQrmZmhBFeyMqEzgU63JHryDLXClLyliUUQ7ebh4YW5gcKKQQ0nHrP1VlrSMgHI/9B1vPqgokV5NJFWLMfiaSLNdweyzFdy6cGzQDoL7I0J7Rebq25wewl0ZWWi/szu64rTBziK1hmgTxAWW8JTDyYMbbBYT/SOz7iBBwaT870rHqumbiZl2QYboc6Z9p8ZASAKMToeTQiWF/02xv/n2O5jg1Y0VxDQMhUqYsjwHezqnN0O+NJzBFqU/qjS/Dw0WKPxoo1vwmtUyZBZRJuoPZyu5AbB9y8c0TQN2p8oJ+OItGGw/CIhxL4W8jHs4MhOa+9/bqVd2nsdFWw+hAdVfeFj7vQL26WvHqpy7ucI9saVCeZxKLPoFcY+wqam56EJD9jO11Y8XUk5bWWEtHGQe1r11LFpbCPO0CmiLy0QWkojFZc35Fzgdd8/u+jR4LcljxEAHPRD3MUjlYA+Su+AZO9ofwYCEbeh6rc5xXuJY7XBYT2eubk8
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5117.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(346002)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(41300700001)(5660300002)(6486002)(4326008)(8936002)(8676002)(7416002)(2906002)(66946007)(66476007)(66556008)(64756008)(316002)(76116006)(91956017)(54906003)(66446008)(6916009)(86362001)(478600001)(83380400001)(36756003)(38070700009)(71200400001)(6512007)(53546011)(9686003)(122000001)(6506007)(33656002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RnlraTFHb3puLzZZUnYydGlKNmVpSE54bWZEOVc5RzVweGxLN0dSUDhGb01B?=
 =?utf-8?B?Y3lYS3RmTThDdnZVc3hCdTE4amxCSG9hMDJCSG5YVjVvUGlHUk81elR0K01M?=
 =?utf-8?B?TTd4TjQ5aFZLL3NwdjI0Z0N2ckZwTzhoY01ESHpCZVZ5cVBhb2Z4ZnBTd3pJ?=
 =?utf-8?B?Zno4Nk00VkZHNVBjZ2dkUnRHZDFPTXlqaks2SUFVLy9tdmY1R0hhTi94THJX?=
 =?utf-8?B?K1FBOE5HbVdaQ2pocTMyWUJUUjQ2WjFSeGdGWDljODV1TVNDSW45YXdlTXBJ?=
 =?utf-8?B?aDBNMnkxM3l1TEZUWkFoeWFBRmsyTlhxTlo2Sk1PRUNqMjMyaVpxb2RuK3Fa?=
 =?utf-8?B?bVg1OXd4ZE0yKzNIZnQraVljeWRRbGtQVzZxR0M2UDY0OTVpQzBmY0FnUisy?=
 =?utf-8?B?UG0rQlBuVjZUUVoyNGJ3emtDK2RrekNBWWh0TGtUdlduRi91LzFwNzRlM2pQ?=
 =?utf-8?B?VkFFS2E2R2RNT0NqRUFSeTY2alV6b1dlYlhPRmlIVFF0aUVWcW1QMWNUdEtu?=
 =?utf-8?B?L0VGSGZ0QmNXVWNmZEFsWGRiaHlway9ic21rcHU1bXpja3EyOHRsQlJQNTVa?=
 =?utf-8?B?SmZyS1lkY0tQc0tZUVJpNkpvUnNJbFcyZ3pTbmRRb2p3em5pQWRqSVRRVjcz?=
 =?utf-8?B?bklHcEVkeG5XbmFNOFJ3eEsyMVYvNFB5QVFrV1ZHVnRwTWk0OGh1YlJpck9H?=
 =?utf-8?B?TUh5Vk9tTldpVitJdHl0L2ZnQmgwcEVwclRkbVZTQld3aHBmdTBmNUlsL3RT?=
 =?utf-8?B?SjEwWjQ3emlFdGpGZDFwS3BTL2ZQbjFWQUVLTDhpYUl3bHUzRTFwY3FSdGo3?=
 =?utf-8?B?Wi9LamdneklpdEl4WDNqaSttaytvS3FIVWZrNTIvUC8vbm13bXlsbkZ4V3RJ?=
 =?utf-8?B?Z3RCaCsra2hrRXhUMS9VaG5RTmdTWGZ6K1N3b2NxMCtrYXR3V2Y5bEV2d3hs?=
 =?utf-8?B?RER4VENKaE5tK2RBR2RVOWo2UURLTjdwbDhOd2U3SUw1VFlwdTZGMEJMazZD?=
 =?utf-8?B?V3I4VDBNYnVCSGo5TVR2UlViOW1wV1FLR2ZhN09NdEF2aTZxUzEzS1RUdHE0?=
 =?utf-8?B?K0tNVWxQTENZUjBiY1gya1JpVCt1dHU3emhoc3d0dDFTTUF4K0tzSjVVdFVE?=
 =?utf-8?B?WDBwQzYrditic0JFRytZTzNFUFlHWmdSNnhxVnFzSkoyZGtaMHllTi81em5D?=
 =?utf-8?B?dUVIY3hqZ0d4Q1l0eHFrTURwMk5mT054WUtVNkJPcFlYdXJqM2k5alc2QldY?=
 =?utf-8?B?TUVyY0xSMVplVG4rZHlMeE5wWm5yOXY1blZFWUM0SnJCUGw5ZW9qWC8raVNy?=
 =?utf-8?B?cjRLcngrYTZWanlkK0RQRlhPUHJ6U0tDRlhBU2ttOVhXaFZrb0RoRHM2SjBm?=
 =?utf-8?B?QXNDUDRodTNlNmc3cTZzQU0vMGlMUTYzcUVYaVJ0dmZvUEhTQUtHQnhlTzlx?=
 =?utf-8?B?dnJSMEhNdUxKVWlUeGZlMXR4RWxpbnN1K05NUnpkS2UyU2VOSFN0eUt2SlRw?=
 =?utf-8?B?ZmhrSy9kcVJ5U1g0dFA0U1g0UjQ5bEZRNHJBOGFFb2FDTm1ibEtrK1VkQkpl?=
 =?utf-8?B?NHBGQ21hbmJQRzNrY1dCWGlmU3d2LzJpSnBZZVQwbEdoeHZDZjlYKzJKY2F1?=
 =?utf-8?B?dUdDeVhFZWZKdGpkcTNKaXM1Zm1MWkowYmhqRHJ3bmhRRXZXTG55c0ZOYk5u?=
 =?utf-8?B?b2hzZUdYVTc0R01qUGh4QUdkM090MFMrTkljQnJpUEhycWRHa2RETFRaOUdO?=
 =?utf-8?B?MUZzRUNobG9ZcUQzSzRxUVBHZllWeGJVZlVmemJPR1k3cWpwTmJwaW9QbTZ5?=
 =?utf-8?B?U3ZOdkZibW5OOGZZV3Bza3AwblA1bE1KWEZab2ZScWNUMHRNdzhoNFBvZ3pk?=
 =?utf-8?B?bE9KNjdFNjA2QldLRytTOVVCRGVlcWkvM3cvaTN2RDNJNnoxN3lHeSsxKyt6?=
 =?utf-8?B?K1k5MWhsVXFCR2FVWnFPNHhCOWUwcEduZG04Y3dRMGhUOXJ3elIyK3c2dm1j?=
 =?utf-8?B?aGNwQWxxbjZmSG9xT0N2RXBGancwcUdRT2ZvcmhSK04yM1ZSd0g3Rm5BeHEr?=
 =?utf-8?B?SitVK0lKNk9BTDI5dzBtMUlYc3BXWTNXblZ6dGRGT0xKMG4wcGJ4YU9JZWNr?=
 =?utf-8?B?Zm0rRmEzdkpqQjJzTlI2RUFCQWVuMXdzWjhNbWRBWGR3b1RkWXJwYy84NUto?=
 =?utf-8?Q?AChWx0gXLg8/UDsD/Q7cVT4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CEF068F973304944BA758AF2F8744355@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB5117.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74af980c-7691-4c9b-f4d2-08dbdbced89f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 18:09:24.6618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xeOFdHDM+O1WbS6RRbXsOhUgjD3BQpA54utO2cyjNKCbfCNdG+jYuN0GlbpK4X4CfHKoP2dKlJoN2BU+53ALGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB6269
X-Proofpoint-GUID: 4J9mmipc-tayl5WvZvXgNvMLnvJFhJWp
X-Proofpoint-ORIG-GUID: 4J9mmipc-tayl5WvZvXgNvMLnvJFhJWp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-02_08,2023-11-02_03,2023-05-22_02

DQoNCj4gT24gTm92IDIsIDIwMjMsIGF0IDEwOjE24oCvQU0sIEFuZHJpaSBOYWtyeWlrbyA8YW5k
cmlpLm5ha3J5aWtvQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIE5vdiAyLCAyMDIz
IGF0IDEwOjA54oCvQU0gQW5kcmlpIE5ha3J5aWtvDQo+IDxhbmRyaWkubmFrcnlpa29AZ21haWwu
Y29tPiB3cm90ZToNCj4+IA0KPj4gT24gVGh1LCBOb3YgMiwgMjAyMyBhdCA5OjU24oCvQU0gQW5k
cmlpIE5ha3J5aWtvDQo+PiA8YW5kcmlpLm5ha3J5aWtvQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4g
DQo+Pj4gT24gVHVlLCBPY3QgMjQsIDIwMjMgYXQgNDo1NuKAr1BNIFNvbmcgTGl1IDxzb25nQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPj4+PiANCj4+Pj4ga2Z1bmNzIGJwZl9keW5wdHJfc2xpY2UgYW5k
IGJwZl9keW5wdHJfc2xpY2VfcmR3ciBhcmUgdXNlZCBieSBCUEYgcHJvZ3JhbXMNCj4+Pj4gdG8g
YWNjZXNzIHRoZSBkeW5wdHIgZGF0YS4gVGhleSBhcmUgYWxzbyB1c2VmdWwgZm9yIGluIGtlcm5l
bCBmdW5jdGlvbnMNCj4+Pj4gdGhhdCBhY2Nlc3MgZHlucHRyIGRhdGEsIGZvciBleGFtcGxlLCBi
cGZfdmVyaWZ5X3BrY3M3X3NpZ25hdHVyZS4NCj4+Pj4gDQo+Pj4+IEFkZCBicGZfZHlucHRyX3Ns
aWNlIGFuZCBicGZfZHlucHRyX3NsaWNlX3Jkd3IgdG8gYnBmLmggc28gdGhhdCBrZXJuZWwNCj4+
Pj4gZnVuY3Rpb25zIGNhbiB1c2UgdGhlbSBpbnN0ZWFkIG9mIGFjY2Vzc2luZyBkeW5wdHItPmRh
dGEgZGlyZWN0bHkuDQo+Pj4+IA0KPj4+PiBVcGRhdGUgYnBmX3ZlcmlmeV9wa2NzN19zaWduYXR1
cmUgdG8gdXNlIGJwZl9keW5wdHJfc2xpY2UgaW5zdGVhZCBvZg0KPj4+PiBkeW5wdHItPmRhdGEu
DQo+Pj4+IA0KPj4+PiBBbHNvLCB1cGRhdGUgdGhlIGNvbW1lbnRzIGZvciBicGZfZHlucHRyX3Ns
aWNlIGFuZCBicGZfZHlucHRyX3NsaWNlX3Jkd3INCj4+Pj4gdGhhdCB0aGV5IG1heSByZXR1cm4g
ZXJyb3IgcG9pbnRlcnMgZm9yIEJQRl9EWU5QVFJfVFlQRV9YRFAuDQo+Pj4+IA0KPj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBTb25nIExpdSA8c29uZ0BrZXJuZWwub3JnPg0KPj4+PiAtLS0NCj4+Pj4gaW5j
bHVkZS9saW51eC9icGYuaCAgICAgIHwgIDQgKysrKw0KPj4+PiBrZXJuZWwvYnBmL2hlbHBlcnMu
YyAgICAgfCAxNiArKysrKysrKy0tLS0tLS0tDQo+Pj4+IGtlcm5lbC90cmFjZS9icGZfdHJhY2Uu
YyB8IDE1ICsrKysrKysrKysrLS0tLQ0KPj4+PiAzIGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlv
bnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KPj4+PiANCj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGludXgvYnBmLmggYi9pbmNsdWRlL2xpbnV4L2JwZi5oDQo+Pj4+IGluZGV4IGI0ODI1ZDNjZGIy
OS4uM2VkM2FlMzdjYmRmIDEwMDY0NA0KPj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2JwZi5oDQo+
Pj4+ICsrKyBiL2luY2x1ZGUvbGludXgvYnBmLmgNCj4+Pj4gQEAgLTEyMjIsNiArMTIyMiwxMCBA
QCBlbnVtIGJwZl9keW5wdHJfdHlwZSB7DQo+Pj4+IA0KPj4+PiBpbnQgYnBmX2R5bnB0cl9jaGVj
a19zaXplKHUzMiBzaXplKTsNCj4+Pj4gdTMyIF9fYnBmX2R5bnB0cl9zaXplKGNvbnN0IHN0cnVj
dCBicGZfZHlucHRyX2tlcm4gKnB0cik7DQo+Pj4+ICt2b2lkICpicGZfZHlucHRyX3NsaWNlKGNv
bnN0IHN0cnVjdCBicGZfZHlucHRyX2tlcm4gKnB0ciwgdTMyIG9mZnNldCwNCj4+Pj4gKyAgICAg
ICAgICAgICAgICAgICAgICB2b2lkICpidWZmZXJfX29wdCwgdTMyIGJ1ZmZlcl9fc3prKTsNCj4+
Pj4gK3ZvaWQgKmJwZl9keW5wdHJfc2xpY2VfcmR3cihjb25zdCBzdHJ1Y3QgYnBmX2R5bnB0cl9r
ZXJuICpwdHIsIHUzMiBvZmZzZXQsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICB2
b2lkICpidWZmZXJfX29wdCwgdTMyIGJ1ZmZlcl9fc3prKTsNCj4+Pj4gDQo+Pj4+ICNpZmRlZiBD
T05GSUdfQlBGX0pJVA0KPj4+PiBpbnQgYnBmX3RyYW1wb2xpbmVfbGlua19wcm9nKHN0cnVjdCBi
cGZfdHJhbXBfbGluayAqbGluaywgc3RydWN0IGJwZl90cmFtcG9saW5lICp0cik7DQo+Pj4+IGRp
ZmYgLS1naXQgYS9rZXJuZWwvYnBmL2hlbHBlcnMuYyBiL2tlcm5lbC9icGYvaGVscGVycy5jDQo+
Pj4+IGluZGV4IGU0NmFjMjg4YTEwOC4uYWY1MDU5ZjExZTgzIDEwMDY0NA0KPj4+PiAtLS0gYS9r
ZXJuZWwvYnBmL2hlbHBlcnMuYw0KPj4+PiArKysgYi9rZXJuZWwvYnBmL2hlbHBlcnMuYw0KPj4+
PiBAQCAtMjI3MCwxMCArMjI3MCwxMCBAQCBfX2JwZl9rZnVuYyBzdHJ1Y3QgdGFza19zdHJ1Y3Qg
KmJwZl90YXNrX2Zyb21fcGlkKHMzMiBwaWQpDQo+Pj4+ICAqIGJwZl9keW5wdHJfc2xpY2Ugd2ls
bCBub3QgaW52YWxpZGF0ZSBhbnkgY3R4LT5kYXRhL2RhdGFfZW5kIHBvaW50ZXJzIGluDQo+Pj4+
ICAqIHRoZSBicGYgcHJvZ3JhbS4NCj4+Pj4gICoNCj4+Pj4gLSAqIFJldHVybjogTlVMTCBpZiB0
aGUgY2FsbCBmYWlsZWQgKGVnIGludmFsaWQgZHlucHRyKSwgcG9pbnRlciB0byBhIHJlYWQtb25s
eQ0KPj4+PiAtICogZGF0YSBzbGljZSAoY2FuIGJlIGVpdGhlciBkaXJlY3QgcG9pbnRlciB0byB0
aGUgZGF0YSBvciBhIHBvaW50ZXIgdG8gdGhlIHVzZXINCj4+Pj4gLSAqIHByb3ZpZGVkIGJ1ZmZl
ciwgd2l0aCBpdHMgY29udGVudHMgY29udGFpbmluZyB0aGUgZGF0YSwgaWYgdW5hYmxlIHRvIG9i
dGFpbg0KPj4+PiAtICogZGlyZWN0IHBvaW50ZXIpDQo+Pj4+ICsgKiBSZXR1cm46IE5VTEwgb3Ig
ZXJyb3IgcG9pbnRlciBpZiB0aGUgY2FsbCBmYWlsZWQgKGVnIGludmFsaWQgZHlucHRyKSwgcG9p
bnRlcg0KPj4+IA0KPj4+IEhvbGQgb24sIG5vcGUsIHRoaXMgb25lIHNob3VsZG4ndCByZXR1cm4g
ZXJyb3IgcG9pbnRlciBiZWNhdXNlIGl0J3MNCj4+PiB1c2VkIGZyb20gQlBGIHByb2dyYW0gc2lk
ZSBhbmQgQlBGIHByb2dyYW0gaXMgY2hlY2tpbmcgZm9yIE5VTEwgb25seS4NCj4+PiBEb2VzIGl0
IGFjdHVhbGx5IHJldHVybiBlcnJvciBwb2ludGVyLCB0aG91Z2g/DQoNClJpZ2h0LiBrZnVuYyBz
aG91bGQgbm90IHJldHVybiBlcnJvciBwb2ludGVyLiANCg0KPj4gDQo+PiBTbyBJIGp1c3QgY2hl
Y2tlZCB0aGUgY29kZSAoc2hvdWxkIGhhdmUgZG9uZSBpdCBiZWZvcmUgcmVwbHlpbmcsDQo+PiBz
b3JyeSkuIEl0IGlzIGEgYnVnIHRoYXQgc2xpcHBlZCB0aHJvdWdoIHdoZW4gYWRkaW5nIGJwZl94
ZHBfcG9pbnRlcigpDQo+PiB1c2FnZS4gV2Ugc2hvdWxkIGFsd2F5cyByZXR1cm4gTlVMTCBmcm9t
IHRoaXMga2Z1bmMgb24gZXJyb3INCj4+IGNvbmRpdGlvbnMuIExldCdzIGZpeCBpdCBzZXBhcmF0
ZWx5LCBidXQgcGxlYXNlIGRvbid0IGNoYW5nZSB0aGUNCj4+IGNvbW1lbnRzLg0KPj4gDQo+Pj4g
DQo+Pj4gSSdtIGdlbmVyYWxseSBza2VwdGljYWwgb2YgYWxsb3dpbmcgdG8gY2FsbCBrZnVuY3Mg
ZGlyZWN0bHkgZnJvbQ0KPj4+IGludGVybmFsIGtlcm5lbCBjb2RlLCB0YmgsIGFuZCBjb25jZXJu
cyBsaWtlIHRoaXMgYXJlIG9uZSByZWFzb24gd2h5Lg0KPj4+IEJQRiB2ZXJpZmllciBzZXRzIHVw
IHZhcmlvdXMgY29uZGl0aW9ucyB0aGF0IGtmdW5jcyBoYXZlIHRvIGZvbGxvdywNCj4+PiBhbmQg
aXQgc2VlbXMgZXJyb3ItcHJvbmUgdG8gbWl4IHRoaXMgdXAgd2l0aCBpbnRlcm5hbCBrZXJuZWwg
dXNhZ2UuDQo+Pj4gDQo+PiANCj4+IFJlYWRpbmcgYnBmX2R5bnB0cl9zbGljZV9yZHdyIGNvZGUs
IGl0IGRvZXMgbG9vayBleGFjdGx5IGxpa2Ugd2hhdCB5b3UNCj4+IHdhbnQsIGRlc3BpdGUgdGhl
IGNvbmZ1c2luZ2x5LWxvb2tpbmcgMCwgTlVMTCwgMCBhcmd1bWVudHMuIFNvIEkgZ3Vlc3MNCj4+
IEknbSBmaW5lIGV4cG9zaW5nIGl0IGRpcmVjdGx5LCBidXQgaXQgc3RpbGwgZmVlbHMgbGlrZSBp
dCB3aWxsIGJpdGUgdXMNCj4+IGF0IHNvbWUgcG9pbnQgbGF0ZXIuDQo+IA0KPiBPaywgbm93IEkn
bSBhdCBwYXRjaCAjNS4gVGhpbmsgYWJvdXQgd2hhdCB5b3UgYXJlIGRvaW5nIGhlcmUuIFlvdSBh
cmUNCj4gYXNraW5nIGJwZl9keW5wdHJfc2xpY2VfcmRydygpIGlmIHlvdSBjYW4gZ2V0IGEgZGly
ZWN0bHkgd3JpdGFibGUNCj4gcG9pbnRlciB0byBhIGRhdGEgYXJlYSBvZiBsZW5ndGggKnplcm8q
LiBTbyBpZiBpdCdzIFNLQiwgZm9yIGV4YW1wbGUsDQo+IHRoZW4geWVhaCwgeW91J2xsIGJlIGdy
YW50ZWQgYSBwb2ludGVyLiBCdXQgdGhlbiB5b3UgYXJlIHByb2NlZWRpbmcgdG8NCj4gd3JpdGUg
dXAgdG8gc2l6ZW9mKHN0cnVjdCBmc3Zlcml0eV9kaWdlc3QpIGJ5dGVzLCBhbmQgdGhhdCBjYW4g
Y3Jvc3MNCj4gaW50byBub24tY29udGlndW91cyBtZW1vcnkuDQo+IA0KPiBTbyBJJ2xsIHRha2Ug
aXQgYmFjaywgbGV0J3Mgbm90IGV4cG9zZSB0aGlzIGtmdW5jIGRpcmVjdGx5IHRvIGtlcm5lbA0K
PiBjb2RlLiBMZXQncyBoYXZlIGEgc2VwYXJhdGUgaW50ZXJuYWwgaGVscGVyIHRoYXQgd2lsbCBy
ZXR1cm4gZWl0aGVyDQo+IHZhbGlkIHBvaW50ZXIgb3IgTlVMTCBmb3IgYSBnaXZlbiBkeW5wdHIs
IGJ1dCB3aWxsIHJlcXVpcmUgdmFsaWQNCj4gbm9uLXplcm8gbWF4IHNpemUuIFNvbWV0aGluZyB3
aXRoIHRoZSBzaWduYXR1cmUgbGlrZSBiZWxvdw0KPiANCj4gdm9pZCAqIF9fYnBmX2R5bnB0cl9k
YXRhX3J3KGNvbnN0IHN0cnVjdCBicGZfZHlucHRyX2tlcm4gKnB0ciwgdTMyIGxlbik7DQo+IA0K
PiBJZiBwdHIgY2FuIHByb3ZpZGUgYSBkaXJlY3QgcG9pbnRlciB0byBtZW1vcnkgb2YgbGVuZ3Ro
ICpsZW4qLCBncmVhdC4NCj4gSWYgbm90LCByZXR1cm4gTlVMTC4gVGhpcyB3aWxsIGJlIGFuIGFw
cHJvcHJpYXRlIGludGVybmFsIEFQSSBmb3IgYWxsDQo+IHRoZSB1c2UgY2FzZXMgeW91IGFyZSBh
ZGRpbmcgd2hlcmUgd2Ugd2lsbCBiZSB3cml0aW5nIGJhY2sgaW50byBkeW5wdHINCj4gZnJvbSBv
dGhlciBrZXJuZWwgQVBJcyB3aXRoIHRoZSBhc3N1bXB0aW9uIG9mIGNvbnRpZ3VvdXMgbWVtb3J5
DQo+IHJlZ2lvbi4NCg0KU291bmRzIGdvb2QuIEZpeGluZyB0aGlzIGluIHRoZSBuZXh0IHZlcnNp
b24uIA0KDQpUaGFua3MsDQpTb25nDQoNCg==

