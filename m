Return-Path: <bpf+bounces-11992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A03747C6505
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 08:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A5E1C20F93
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 06:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9CBD27B;
	Thu, 12 Oct 2023 06:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="gMn0CBE0"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F26613F
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 06:01:51 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F4CCA
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 23:01:48 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39BMJv3Y003098
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 23:01:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=7I2ixFZvRPxn3TKqr5iajfWBB3ULbsiDnoyFTMJgJC0=;
 b=gMn0CBE0vCtOSWv0TzheH1yZ3VHHUTXvdTYvPJC5VM3J/QyQWhoGSYtLcKKgQQYHJBpv
 LAXgxgZrnqk6a3uIwknrK6YCVlSPMTzSAHX7G8MLoOGkDU72fDZvWaSpjx4o+5CkbClj
 C6HvqoUkvZCrvd5/kWUcffLtS3JZsa5J82N3b7OMLm5wmzuVV6fQ3ZT8RSWf/MUJL0S+
 VGsOm05qs4JYK4GoWPIp+BnztHlVHv2CN4m4uiq7JhQ72cWM2yOhcLkGnqTlvs/bc5qV
 rBTpEDDpvFP+mcluYOmeqfsWVdCUkHAGtFsE3DBxht7YwuVtpoQ8s1nTf9Uw8BHcF2YL TA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tp4depyqj-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 23:01:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGgWEk9P9/2kzaoa3a9Q03rhVnmmW9IjpxkFaOjBECCtAbUHIsxwAeUl7F8Ebv+PK0YruzRgXu1OUya2yzxintPlfyD4Ny1el/+lUYieVOBmck4urQyLdnmVsFVoqLinvpTYfjnXNR8F1oOFtKJ3iGZ+vfYkUHIzr/KNEId9m1hErtsnTzWGrPmlSecYGi89KI2VM7EgUynV06VMiEsn0k6B1t5opE4W6rcnA1+B4TSCR1IpuFpZ6Wrem/ezeXP/s36QqBrv+IyPJzsApdzB+cJvtZu3Dcimr1OR1xQLL+QcH+Xfat4DQUTp45bN5hqvZ91RMal7qfwcQnjnkMNYQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7I2ixFZvRPxn3TKqr5iajfWBB3ULbsiDnoyFTMJgJC0=;
 b=PE+DCayMX1SobbX2yN/w36zFrEh/Ja8qU7nw0O/JHKbGu21rXu+Eom21CrqPq7Ad7p+MNfBGfkE1Rub1z+Lm6Xx1QeI7e2ZqBmk1kOKp0X3g0yKvSxxJk/RCybzDqm/r8bsmvU3isRDa70szOwVYAT6Wgj2vLkWkBjX1kx412c7KAkQ7GS+Nwm8eV5MnVf8DyuCeXcuONIdT3kXeUyMDpPWnl2TiZX8BbBKnXNX5sKgk94duc0YSU6tBk3OVnYqdjSjYxRY4fMIOTxFsTA7VqW/yI6qsG7AbgE305y2wdqsv9kxOPrn1vuCVKrp6Hobv0A/H1E0BApvwt8/PS2bcCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SN7PR15MB6159.namprd15.prod.outlook.com (2603:10b6:806:2e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 06:01:45 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e0e7:7606:7fef:f9de]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e0e7:7606:7fef:f9de%5]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 06:01:45 +0000
From: Song Liu <songliubraving@meta.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC: Song Liu <song@kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
        Song Liu
	<songliubraving@meta.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel
 Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin
 KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@meta.com>, Tejun
 Heo <tj@kernel.org>
Subject: Re: [PATCH v2 bpf-next] bpf: Avoid unnecessary -EBUSY from
 htab_lock_bucket
Thread-Topic: [PATCH v2 bpf-next] bpf: Avoid unnecessary -EBUSY from
 htab_lock_bucket
Thread-Index: 
 AQHZ9lwCFOQR9ydaeUieAa0xHUISRbA481YAgAAHDQCAANWeAIAAhFAAgAAbnwCAAYiEAIAHkScAgAAXuYCAAbvVgIAAWSOA
Date: Thu, 12 Oct 2023 06:01:26 +0000
Message-ID: <D1ABC3D7-BBC8-4294-BA92-EDEC29DDDF15@fb.com>
References: <20231004004350.533234-1-song@kernel.org>
 <CAEf4BzbM6yvBwT3-_7NkzKgqdoXc_G3+_5Fnv96b_2U68=Hunw@mail.gmail.com>
 <CAADnVQKMxUg3Djh8UjRPdw7RE6yOiNUgYGjG_eCPqMtnguO+fA@mail.gmail.com>
 <095DCE9A-BC4D-415F-81F6-B6C20BA08B9A@fb.com>
 <FCAD3D3A-B230-40D8-A422-DED507B95C89@fb.com>
 <A53BABCE-A22D-40B0-91BA-009B54AB8F09@fb.com>
 <92BDCF92-3219-4EDA-A6F8-1EA8D88BEE41@fb.com>
 <7a9576222aa40b1c84ad3a9ba3e64011d1a04d41.camel@linux.ibm.com>
 <CAPhsuW7yXG4pahGTuBUWYmqQzYBJji=VFLmBYotHWL82janT_A@mail.gmail.com>
 <CAEf4BzbaWL_AJ55E+nniexL04nhTegR0DWCd4bLyXW8rXVGegg@mail.gmail.com>
In-Reply-To: 
 <CAEf4BzbaWL_AJ55E+nniexL04nhTegR0DWCd4bLyXW8rXVGegg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SN7PR15MB6159:EE_
x-ms-office365-filtering-correlation-id: 5f7ef6b7-aaae-4a9d-b4ab-08dbcae8ab7c
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 M7JgwwyiEZ9U9RuP29eZatLQ20Qv36d7JRfh/pIJnEhJsfSumSGdrpkNbXS1X8+52qC9TpUI5fUKGfWb526hc8XCWPRMZQE5NFxATHFQPSTUZPsX/eKGcpQcm5i9epbR1CVnXKeGdKeZk34cZlcxtn8YYdjNxMDu64v2mIn+RTFM4mR5ZRo9kRVL75zktfP8NVf5LfPwWulyUGLYbLp7ZJatctuoxWPRYeKCf1u8tZgXN0JeG2Jef4IZcULT+YdISFb+nDYtLhxZSvpQ8hMPl+k0d/g2WPl4KtbqqIKhdobJ1vEklIvxZ0hK+jv4ZUB9XevHmJ49YM2YybF6SR3V+56qJQ+APuQLl4NDV/vFWfl9B7E1Uqx5uH43T1owWreW+NdGi011rC1GiokreCKv2it/cOOm8wm/oyo+JUrEI3AAhkUr1R7gSEmTGRVEMVE9aO1cDRfSM6FjqQk+P6JWh4TNXBK8H1hBUIrMogeM8ovJjxjLIycyIhkCfnT1NPBLvmc5oEc/z4EGgyjYY9YquKHeutfyVy0uXImKyGDwfVU6JxM3AujOsJdSy/1xyq/YQYRbLkbUAjvuylF3+5dgfk2CyeaWJOnSrIx7kwi21eLPxlI3QMluEwMwBfyf2QHO
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(478600001)(6486002)(53546011)(6506007)(86362001)(6666004)(36756003)(71200400001)(41300700001)(8936002)(8676002)(4326008)(316002)(54906003)(6916009)(91956017)(66946007)(66446008)(64756008)(66476007)(76116006)(66556008)(4744005)(9686003)(7416002)(2906002)(33656002)(6512007)(5660300002)(122000001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Yy90Y2FGOXArME12QURsb3ZyNUZBbStiTXIxNjdkRFNKNEo1RGNHL0VGNXNW?=
 =?utf-8?B?aXBOeDRYMEZtT29Ga09hd1lLQjRTY2RLQWd1U2kvNVNEV1dIcitvVjZjVTdK?=
 =?utf-8?B?ampyZDZrZzRFd1RLN00va1ptQ1dmdC9kcDlEdWJZRUdTQkV5dDRvQnpBTjN5?=
 =?utf-8?B?UkZQNVJmUUpKcCtLbC95UlluZjVlWjlITHczQ3VOUW44SmhWaFlSbVpMY2xr?=
 =?utf-8?B?bG9HRERPaUZxTndxQldxTkt0QVVkVEoxRFlnQ0x4K214UkJXNE9URzdiMlVs?=
 =?utf-8?B?SUdaTFdDQTNQM0gwNlBoSEhmWGlSVnh2Q1BJL0VpOUZaYWdHNkZsSDhyTG12?=
 =?utf-8?B?WU91UmYrbWpXVUF4c2lnRndkMERhc3VneWRySXZ4V3dSU1p0dlg2MmEzb2ds?=
 =?utf-8?B?TmxheGhpZndGeWtOMUI2U3M1d0VRSkxyOWZLSU5Qc1ZVS2t2a01lcWZOUXBt?=
 =?utf-8?B?MWppVFg0VXY2SGxZQlhBajdKUVhpcDJkbUtLU3ptK29WU285aUlrcUg1Wmp1?=
 =?utf-8?B?YUZnV1ZxMmM1M0RQYWJsV0NSV3Z3UFh2RmswRUpqTXprbmVOUHJrWmc4Q3hQ?=
 =?utf-8?B?UGt5UHJDTUlJUEUrd1RsS1Ryb1dOM0F2NG5vQytHd0JyZ3lYckhoVm0ydVRr?=
 =?utf-8?B?Y3dXdmtIMzJKUGhXZ1o1ZmZBTzllRnVKSS92a0ZQa25FVG1qcVJ6ZCtDb1dx?=
 =?utf-8?B?bGx0cWI5cGxXVnY0WGlBZHYra05qUVdUL214MHBhd0xrV25ZbEhKalZyYTNo?=
 =?utf-8?B?dE45bXhkSzA4SzVxeVRFY3hMTW5SS3FKMWxUa3NnRU5pMGZQTHlEQzZrWWxD?=
 =?utf-8?B?R09aL2xzUXhWczBicnZWdmcyL0U1L1hsVVNSR045WG9qZVdsQTRObCtFbEh1?=
 =?utf-8?B?QTc1Y2tObDh1a3hxSHk4a1d6WGthc0hjSjZibktuamNqaDRhU1Z3N3pIL2tw?=
 =?utf-8?B?dHRWSHFjSkpZODlZOFJ5OVlGbktFRmZYa1NWLzg1ZWtjMUI1bTFZSXBrejlq?=
 =?utf-8?B?SHZiY1R0cGY5eFhrbktRZi9jVlc1M3lFbjNaZnBKSzZUb2s4dzRkWmo1TW1o?=
 =?utf-8?B?eTdSSVhZWklFWEd1VzB4ZCt6eU1DdUE3Smw4RGpra2xMVzZySjVZZUtlS3F5?=
 =?utf-8?B?NW9WemlyVCtUeERxTllZU213bjJzTTQzLzZkbHNkd1RoSG9Lc2JWY0ZXbDFq?=
 =?utf-8?B?U0U0MW1UK0ZqWng0cExCcElUbW9OY21mbVlhU1UyektJOXZvUFJZd2Jaakk0?=
 =?utf-8?B?NUkyU0JObk5kcWwvTTVyWUw0V0FDdmtjcjVUL3hOaDRUWlkzeUdPK05lNStM?=
 =?utf-8?B?dWNBaC9CamVyelZ6UnQ1RXU3bzl4TDRGaWUvRmEwLzV5NVRnNFkwaGJVd3Yr?=
 =?utf-8?B?KzJLeWlHQWFzU2pJL2VZU1M5MXBvMndiUFVLeThEQ2JvUjJwWEQvTXl1SjBn?=
 =?utf-8?B?UUFmK1g5SWVWZ21wdVZON0N1R1lEKzNpcmtONnVPV3ZrMnVuamllRUNjRU5T?=
 =?utf-8?B?WWVUWDhZZi81YlFNZ1dBVk52dzhqUnMwbi9vQWpBRkZUZnhEU3QvSmRIRDZD?=
 =?utf-8?B?ZFJPYU83R2pkWjF1UlRuUFhEN0ExVXMxV0phK2ppek1ocHhVKzdMVzBCTE8v?=
 =?utf-8?B?b0FVSDhXUUVxYmVpVDhpMG44NTBuSXNSSGltdUJSZDd5YVlXYlJhMTNvTkNu?=
 =?utf-8?B?bmZsdGxZRGx1MXRoa1lJQ05MZ2Q1dDVnM2xwdUo1SjB5a1dJYm81ZHhFVnht?=
 =?utf-8?B?czBYaGdPNldKSGNqMUk5VjFvdTE0a05YalpqNkNnYkFGSEtsZTNrc1p0dTl2?=
 =?utf-8?B?TUZhRVNMcFlBKzhCV3F3WHI1YlhFd0crQlJHeHk2RXR3YVpTQnAwSlZMSVB0?=
 =?utf-8?B?SDY1YmNSYlBTOFdOdWxVLzR4dEpFWVpkajRzTEl0N2QyRGpjdnZPdVRJY0lZ?=
 =?utf-8?B?UzJSZXN3MEpZa094QzlwT05lcXVTb3R5RWtsOWd1RjF4ZVdXU2llRjFqb3Bn?=
 =?utf-8?B?Tk1rV0NPMklJOVlxZkFra0NTWHhtdTFyVUxIYXJlZ3FMTGd0Z1JrRldvT003?=
 =?utf-8?B?L2ZKallKenVJSEVuK1NPb3l1VUduSCtyWmdZUzMzYjk3Zlp4YXpSNDdxODMx?=
 =?utf-8?B?NitLbVhlaDJGQUtNejZ5M3dyTGYxRnZMN3NaSFI3UzNZSXNuV0plVE9XN1RE?=
 =?utf-8?Q?xHDCkMHAlkfapgxNv08uSks=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <878758A9E6DDA84DBF471D04640E1DFB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7ef6b7-aaae-4a9d-b4ab-08dbcae8ab7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 06:01:26.0855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SdL5njJYrlcfAd9uFUfjJQEi4wH9CECUOl2wezB9UHIWJvYPCxzXW+FwnsjdXTE3/Q44Tdd4wYc38g33iLO0jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB6159
X-Proofpoint-GUID: ERpHqJt0SamXDD1etCk1R-IaLfCaFnwd
X-Proofpoint-ORIG-GUID: ERpHqJt0SamXDD1etCk1R-IaLfCaFnwd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_02,2023-10-11_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCj4gT24gT2N0IDExLCAyMDIzLCBhdCA1OjQyIFBNLCBBbmRyaWkgTmFrcnlpa28gPGFuZHJp
aS5uYWtyeWlrb0BnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBPY3QgMTAsIDIwMjMg
YXQgMzoxM+KAr1BNIFNvbmcgTGl1IDxzb25nQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4gDQo+PiBI
aSBJbHlhLA0KPj4gDQo+PiBPbiBUdWUsIE9jdCAxMCwgMjAyMyBhdCAxOjQ54oCvUE0gSWx5YSBM
ZW9zaGtldmljaCA8aWlpQGxpbnV4LmlibS5jb20+IHdyb3RlOg0KPj4+IA0KPj4gWy4uLl0NCj4+
Pj4gDQo+Pj4+IFRoYW5rcywNCj4+Pj4gU29uZw0KPj4+PiANCj4+Pj4gUFM6IHRoZSByb290IGlt
YWdlIGZyb20gdGhlIENJIGlzIG5vdCBlYXN5IHRvIHVzZS4gSG9wZWZ1bGx5IHlvdQ0KPj4+PiBo
YXZlIHNvbWV0aGluZyBiZXR0ZXIgdGhhbiB0aGF0Lg0KPj4+IA0KPj4+IEhpLA0KPj4+IA0KPj4+
IFRoYW5rcyBmb3IgcG9zdGluZyB0aGUgYW5hbHlzaXMgYW5kIGxpbmtzIHRvIHRoZSBhcnRpZmFj
dHMsIHRoYXQgc2F2ZWQNCj4+PiBtZSBxdWl0ZSBzb21lIHRpbWUuIFRoZSBjcmFzaCBpcyBjYXVz
ZWQgYnkgYSBiYWNrY2hhaW4gaXNzdWUgaW4gdGhlDQo+Pj4gdHJhbXBvbGluZSBjb2RlIGFuZCBo
YXMgbm90aGluZyB0byBkbyB3aXRoIHlvdXIgcGF0Y2g7IEkndmUgcG9zdGVkIHRoZQ0KPj4+IGZp
eCBoZXJlIFsxXS4NCj4+IA0KPj4gVGhhbmtzIGZvciB0aGUgZml4IQ0KPj4gDQo+PiBTb25nDQo+
IA0KPiBTb25nLCBjYW4geW91IHBsZWFzZSByZXNlbmQgeW91ciBwYXRjaCBzbyB0aGF0IENJIGNh
biB0ZXN0IGl0IGFnYWluIG9uDQo+IHRvcCBvZiBJbHlhJ3MgY2hhbmdlcz8gVGhhbmtzIQ0KDQpT
dXJlLiBKdXN0IHNlbnQgdGhlIHBhdGNoIHRvIGJwZiB0cmVlLiANCg0KVGhhbmtzLA0KU29uZw0K
DQo=

