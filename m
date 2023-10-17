Return-Path: <bpf+bounces-12430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3C07CC5B8
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 16:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A2E0281AB4
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 14:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73C543AA5;
	Tue, 17 Oct 2023 14:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="YZl0ezYL"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F9341234
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 14:16:24 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58C5FF
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 07:16:22 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HDRtdu002703
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 07:16:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=4TH7fTjQHmPa5+INZaFP0o1nI15OAq11iHY8n9MWs8c=;
 b=YZl0ezYLTC6KSqwaj2A3Xkd9WbuXkwmI4/49p0OuV87E/wsKbqPwNsTR4PZn4K9K3z6L
 YB0kfL4G1u6IEN0DlhSYFjjZMCjbC93wnIl7Em+2/M2qdn28/0bFp6Mb9KHh7rhNQEUL
 d5vhndmh/tCeXHrj0Dtb8F8Pm16IfhUCme7CcCsfoo03j9hQG0s935mNypeywJuC6+U7
 50g+egk1rlbWKkeU1X1d1dLg2yu99qwi8S97mwGY/njihZEyVTBg7kuzhCzxgqLlaj0m
 eRR0zQOc7P5tPOJJ4j6dIUf7Gng5xjJFirbaaF6XQXcBSTS6B1jnDXCJiYubdNSlLs+1 fg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ts80pq2hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 07:16:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEDMkZqZkL3BXJu+XGa01iDXzN0O1XrKQqhGlIqj4pbnKehCPajZ2pWdGr/Tlhw+u9/eQkk39n3zHenqm4IL1uXIPjUn2N1d2yTATt8HbRCLv3dC7/M8o/G5VUUiKVdOlMrUbraBEqVDJtuZdaZcsXrymdWUPVLWIz8iHJZFdT6ybLJZyN6N/WnqF97e2OkyERPAPtWAqI0sYIfY2Fd0S1BdsjmpFNkxaPTpNcoJkX43Hh21+C9ojSb7UGDXQFIJ32kxrYgxbyyAgmgXBJWHsG7t4kxdvlLvigRufQfGiHiOVnLne59vQLgKNZQHR22MdvtfSvtO4hp2d8czgBKklA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TH7fTjQHmPa5+INZaFP0o1nI15OAq11iHY8n9MWs8c=;
 b=NiRWL+BgxDsKpf9TS4pt9eruNz+8dtXeb0Sdz6MZ8zi6HxbaDx5ZMB1FExzmDctbPNFs97jwX+03Qh/RYvECaeY0ZUE+Up/F5+2VzKySzprWL5LA0rE9kjdM3ZvF9iuhGWTgieTtBlCugCb1k3zWlGGr14iGCXAS+sA7leIuWSkGXfzrenY5qM+Z2iE/Bt2TaIaLn1mgcS9tiGFff6xZdaFEI5DUFKkOUnlrcocErT8F3DVyF8wnLtDCHJT8EkQwcIoNPpmJA/j93d69v93m8VKaIUM8xhPMmMB9t7Pt2qYr63teOKas9asLS7wJKMOwrSYj4CatXE8D5BVvm4ttjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by IA0PR15MB5863.namprd15.prod.outlook.com (2603:10b6:208:404::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 14:16:18 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::526c:b078:a1d1:fba8]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::526c:b078:a1d1:fba8%4]) with mapi id 15.20.6907.021; Tue, 17 Oct 2023
 14:16:18 +0000
From: Song Liu <songliubraving@meta.com>
To: Eric Biggers <ebiggers@kernel.org>
CC: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        "fsverity@lists.linux.dev" <fsverity@lists.linux.dev>,
        Alexei Starovoitov
	<ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko
	<andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team
	<kernel-team@meta.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "roberto.sassu@huaweicloud.com" <roberto.sassu@huaweicloud.com>
Subject: Re: [PATCH bpf-next 2/5] bpf, fsverity: Add kfunc
 bpf_get_fsverity_digest
Thread-Topic: [PATCH bpf-next 2/5] bpf, fsverity: Add kfunc
 bpf_get_fsverity_digest
Thread-Index: 
 AQHZ/gM4CSHRtkfGzEeIef2mRK+7CbBKcGwAgAJtOACAAHW/AIAAKAAAgAADLICAAI5kgA==
Date: Tue, 17 Oct 2023 14:16:18 +0000
Message-ID: <338D3CA0-2AAA-4F61-A336-3739DE8EE2DB@fb.com>
References: <20231013182644.2346458-1-song@kernel.org>
 <20231013182644.2346458-3-song@kernel.org>
 <20231015070714.GF10525@sol.localdomain>
 <CAPhsuW42L6cfyxLR30kc1zSWQr8_JyxoUv1EuRVZpoAix3bm8A@mail.gmail.com>
 <20231017031206.GA1907@sol.localdomain>
 <CAPhsuW4u2GNL8BmEPPtYjc1KtP4Dx+wqtX1fc2eMPYB_6LmrRA@mail.gmail.com>
 <20231017054637.GH1907@sol.localdomain>
In-Reply-To: <20231017054637.GH1907@sol.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.100.2.1.4)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|IA0PR15MB5863:EE_
x-ms-office365-filtering-correlation-id: 9e5e2284-7ec4-4564-8ea9-08dbcf1ba167
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 CXIMhY82qPRcaPWZjfrl9cKK8qR4ChPZzFcnAK56y89IedBAsGAXjjz+H88EPrmoO9Bgc6FP35b88ZqKBYnkoEQDOsHmo8mf1V8IoXbf4oxI/J73bPFF2vWG+3vE9+L6qh/B4+Jxht4LjwiQ8kK55CgHTmFbvfA+jNtLGGoS9udM1qvK4TB7qMWoio5aB4pL9aZhRdAKg84uRNykiIuOoX0ICjCYnVhxhQaox/jKiMVlqqLcEaReKSqv2ZUZBQ4381EYFR/+A1daVsNRZqd3cdW0rDiNUPRIjduu4qPmYf0mMY1lUIB6glYUmfoLTlcGI+btmoV9BiQK6INEP3Mq2RZjH3IzsIPgHH/cYprTpmTDJQfLcXvlK4U9tP5h/6cfiX65jMEEf76UcSZL6xv3MeO+BjFWenYBTTAQwZL4p3UD07miVx9M+ReK5ahGBKuLT44jMbcZ7r06ee+b6QiUZTiCCAs9jEBHLM4g0+RfYskZzZKBWUE+ihEeKHHM9Tw3WpiwDMWIE7jc0YlXT5GqSxf6RB6eFBR4WP3Thz+t0SLh3lpGpG6ZnnqVdRBeZwBfp1AgIas3gYjZesS0Z2IkGiDbE7E6AaZZCKvFP0OE+wO7SLau1tD0TCTWBeAIRn9h
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(366004)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(6506007)(53546011)(71200400001)(5660300002)(2906002)(36756003)(33656002)(9686003)(122000001)(38070700005)(38100700002)(86362001)(6512007)(7416002)(64756008)(6486002)(478600001)(41300700001)(6916009)(316002)(91956017)(66446008)(66556008)(66946007)(54906003)(66476007)(76116006)(4326008)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UCtDaHptN1A2VjR3amtXc0kvVG5URFozVnJZeldUc3RWeldVQ2lxTExPRGYx?=
 =?utf-8?B?WHRHcGtjRHRvZys0YWVWeEYrZm5MZ2RWREZQeWw0MlE1My9tbG1LbHJKYklL?=
 =?utf-8?B?Y3hUOVhSQlBiUXlPY2FNV1I5YURwT1lKOHJ5MVZKa0F6MXpDekJSeCtNNnB3?=
 =?utf-8?B?Z1N5WnJEUFNlWm96VHFWK0w1SnB6UTBBTDFqcmJKK05VTytpcUMwMlZQVmQ5?=
 =?utf-8?B?YXBMUFBwU0plMU1YWno2cy9LR1FnRFd2NEs4YkptQnBweHp5WlNXdndPRDha?=
 =?utf-8?B?YnZ3dUR3Ym9pODlPbUtSYTJLUkQrRGxiZHhtdGpkbE9kaDBZSU9xT1hJT2tU?=
 =?utf-8?B?S2k2NmVwQVFxNTY5SzR6K0ZpNFovaFR5THJSTDNudHBDRGNzOW9Rb3p5Zk92?=
 =?utf-8?B?U0JtTjZPMllkQWdDT1R2dHRCQnc4MXdlcGlqNktIRWhYYnlBT0ZHUXJvUEEx?=
 =?utf-8?B?Si84TFhSN1U3SnhWRSt6dGF5RzNraE8weXExdGJoMG1uUndHYWp0bUxoSzg0?=
 =?utf-8?B?RnpieTd1T1RCaFZtcmdQTVhNSVAyakJjWlpyZDJPQThQUlBQd3JkcjEvSW41?=
 =?utf-8?B?Zk1tRWtMaWZNMlFYeU9nUFVsVnJlUUdYSmpzK0RDU0NtSitBcUppWUlzNlg4?=
 =?utf-8?B?YmgvK20xdTdFK1ZDNUJzVjdLTFRrSjZFb3FncWwwZE5KODBKQkc5VDVHMTda?=
 =?utf-8?B?a1lhbW54ZzQzc3BxdERiRkdtQ0dkNVBpdDVlcmI0RHRuOUZkdlhORXFvZ3B5?=
 =?utf-8?B?SUs3OC9XN2VYUDZqQlZ6NVZ1NFdtaDRHQ1ZLNUd5N1dvMWVjSGQ1SUZ2NUY5?=
 =?utf-8?B?TGhkUFA2ODVlL0tTZVg4cXpWTHpkdGhaZ0pJSWMrSXZEYThUOGFiMkNGMTNX?=
 =?utf-8?B?VG5sc2hOaUNaa0o1RU01eStOYVBnOHBOZUszVHVkWlBONzNvaGVid1Q0UGI3?=
 =?utf-8?B?TjNkMm9zUEdqREtyeGJFUllyTGpWM01HVEpBMEl2TFRxamNINnVuNDBFR2ND?=
 =?utf-8?B?ZW1MWGVWY2JkSGtuWXV5U3NhcStWeU9yTU1ZNC9ndHhORnhCRitja0QxeVpP?=
 =?utf-8?B?Z213RHhQSExqbkdYeWtLNDVUR2duOEppMU5VVVNVbWU5YmtSM0poV1lzT0JO?=
 =?utf-8?B?dkkxY1VYRDl3NjRQRTA5blMxNW83MDlOV1k2UUJLRkxFWFZmVGxwbE5KdlZM?=
 =?utf-8?B?NXVyUGJhWFZYRWFaUDlHTDJ6U1ZVZys1L0o5MEpCZ3ZhSDVtWW1XcHhoV1RN?=
 =?utf-8?B?TlIyRFY5MUZjaHlCRHlEMng5RXloZG90ckpXMTVCWVVTSWQ2MzJxMUlTRnlG?=
 =?utf-8?B?OU9mR08wSDFvQzIrelJhMi8rbWk0VkwwQnpPVkVSL0k3c2luVzE5Z0tGeTIz?=
 =?utf-8?B?dm5hdm5DTlkzb2FCaWpRa0ZvYkswalo0UHN3UUZ3d1p0KzBWc1Fic1ZUdTZ4?=
 =?utf-8?B?RC9rR3BtNEhnQmJXWDljQ2t3MXFaYjlWbTdlR0c2elhmcGJhMTB6ODdnQ2p0?=
 =?utf-8?B?Nk43NHYwR3dKYmxVaXdLN2tmd1JzbTdqTkNtQStxR0F4cHZIUjlyblJ6TXhs?=
 =?utf-8?B?bS9HdTk0YlBYS3IwUTJZekg2ZWtVM3VtZndxZjREZTcwOHYwb3dockJUL3ZQ?=
 =?utf-8?B?c3VGWkF1eUplOHpjbnNTWHBVQjFaTkZFSVg5clZscW0vcGtkODJZZUkydUNt?=
 =?utf-8?B?M1JrQ20rQkw2UXZlUFhWTEthaEVGbDh6d1J3d3RqSDVKRE9LTzB0aE1zMzF3?=
 =?utf-8?B?Tkhrby9RL1NPV0M4blowMlRlL3ZQc2lWWHQxM2V2Z2I2M3psdWxNRThCRXNG?=
 =?utf-8?B?NlU2cjVsZXFqR2QyQ3JtbktpVmJXV3lvVk5KVnpsWGNTN2FnTVpxWlQvTnlZ?=
 =?utf-8?B?bGtuMnBCQmxUQ2xDL2R1Qy9vSTJxeDhFQ25KRk1Zcjl6KzlvZk41b240Z2U1?=
 =?utf-8?B?dlFWc3lvbkZkbHJ3aHpVZGZGSk9BcDFVSUM1UEdyQy9acjlDcm53SkYzVFc0?=
 =?utf-8?B?cFRQaUpSZC9QU2tLZHJiUjIwaFhVUVdBc1lRNnFLbW5hTVBFZjhQOXd1TWJ2?=
 =?utf-8?B?ZW1zQjFoTkVDT01hcjFWai80bjBZdG9acUYxNWFpVVBtTXJVcnAvVW14aG5I?=
 =?utf-8?B?VG5sMnFRbWM1a3NWUUJMTjFiNDZxK00xeWJUdmRRMkRnT0tUWFBVNm9UeHdp?=
 =?utf-8?Q?imEQnd7AJA/uNad1nKB52Uo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B69DB244B535945B463447B0B612ABA@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5e2284-7ec4-4564-8ea9-08dbcf1ba167
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 14:16:18.1690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1w/ssXksNytdEpaaMKu2y9JMMP2t4z5j0VgXfvguluHkU2IUWCGugFS7Vcf6ZKR5qZttp7SQ5uJiI3+n9HhKag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR15MB5863
X-Proofpoint-GUID: 5IhRwb0anfe2sZZtHoaKrO-tT8GiQ4_R
X-Proofpoint-ORIG-GUID: 5IhRwb0anfe2sZZtHoaKrO-tT8GiQ4_R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_03,2023-10-17_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCj4gT24gT2N0IDE2LCAyMDIzLCBhdCAxMDo0NuKAr1BNLCBFcmljIEJpZ2dlcnMgPGViaWdn
ZXJzQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gTW9uLCBPY3QgMTYsIDIwMjMgYXQgMTA6
MzU6MTZQTSAtMDcwMCwgU29uZyBMaXUgd3JvdGU6DQo+PiBPbiBNb24sIE9jdCAxNiwgMjAyMyBh
dCA4OjEy4oCvUE0gRXJpYyBCaWdnZXJzIDxlYmlnZ2Vyc0BrZXJuZWwub3JnPiB3cm90ZToNCj4+
PiANCj4+PiBPbiBNb24sIE9jdCAxNiwgMjAyMyBhdCAwMToxMDo0MFBNIC0wNzAwLCBTb25nIExp
dSB3cm90ZToNCj4+Pj4gT24gU3VuLCBPY3QgMTUsIDIwMjMgYXQgMTI6MDfigK9BTSBFcmljIEJp
Z2dlcnMgPGViaWdnZXJzQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+IFsuLi5dDQo+
Pj4+Pj4gKyAqLw0KPj4+Pj4+ICtfX2JwZl9rZnVuYyBpbnQgYnBmX2dldF9mc3Zlcml0eV9kaWdl
c3Qoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBicGZfZHlucHRyX2tlcm4gKmRpZ2VzdF9wdHIp
DQo+Pj4+Pj4gK3sNCj4+Pj4+PiArICAgICBjb25zdCBzdHJ1Y3QgaW5vZGUgKmlub2RlID0gZmls
ZV9pbm9kZShmaWxlKTsNCj4+Pj4+PiArICAgICBzdHJ1Y3QgZnN2ZXJpdHlfZGlnZXN0ICphcmcg
PSBkaWdlc3RfcHRyLT5kYXRhOw0KPj4+Pj4gDQo+Pj4+PiBXaGF0IGFsaWdubWVudCBpcyBndWFy
YW50ZWVkIGhlcmU/DQo+Pj4+IA0KPj4+PiBkcm5wdHIgZG9lc24ndCBub3QgcHJvdmlkZSBhbGln
bm1lbnQgZ3VhcmFudGVlIGZvciBkaWdlc3RfcHRyLT5kYXRhLg0KPj4+PiBJZiB3ZSBuZWVkIGFs
aWdubWVudCBndWFyYW50ZWUsIHdlIG5lZWQgdG8gYWRkIGl0IGhlcmUuDQo+Pj4gDQo+Pj4gU28g
dGVjaG5pY2FsbHkgaXQncyB3cm9uZyB0byBjYXN0IGl0IHRvIHN0cnVjdCBmc3Zlcml0eV9kaWdl
c3QsIHRoZW4uDQo+PiANCj4+IFdlIGNhbiBlbmZvcmNlIGFsaWdubWVudCBoZXJlLiBXb3VsZCBf
X2FsaWduZWQoMikgYmUgc3VmZmljaWVudD8NCj4+IA0KPiANCj4gRG8geW91IG1lYW4gc29tZXRo
aW5nIGxpa2UgdGhlIGZvbGxvd2luZzoNCj4gDQo+IGlmICghSVNfQUxJR05FRCgodWludHB0cl90
KWRpZ2VzdF9wdHItPmRhdGEsIF9fYWxpZ25vZl9fKCphcmcpKSkNCj4gcmV0dXJuIC1FSU5WQUw7
DQoNCkkgd2FzIHRoaW5raW5nIGFib3V0IGhhcmQtY29kaW5nIHRoZSBhbGlnbm1lbnQgcmVxdWly
ZW1lbnQuIA0KX19hbGlnbm9mX18gaXMgbXVjaCBiZXR0ZXIuIFRoYW5rcyBmb3IgdGhlIHN1Z2dl
c3Rpb24hDQoNClNvbmc=

