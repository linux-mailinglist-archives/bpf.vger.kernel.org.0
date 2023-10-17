Return-Path: <bpf+bounces-12485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A257CCE32
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 22:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72AB428198E
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 20:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962AA2D7BA;
	Tue, 17 Oct 2023 20:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Ud0qDK2o"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC542E3F9
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 20:36:44 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593F6100
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 13:36:43 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HHn1sA005916
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 13:36:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=Q3GLEnKghrrZvdCzNbEirRv0bMJXU8oeVo5q80XFtBg=;
 b=Ud0qDK2o7If626tyJw/+bHHbbbOZW4dxYs3N9NWnxyUzB56anOsLEThXDiG6MJcACzZG
 sIIulzcw202XnVYufQ4+4UqzMX/PCzArGKaeIjyKz+9jJtNAszF8RSHvA1GNFprl/qg5
 E6H7V9I27TMf5O7XePTSVZCgjB2vhunye/veSj1KLcBnkhM/0PqxXYtiFX72cmFE4BgB
 ddsoWElrrmOg7fwsplx0Mm9zLQ+/+etKCF7GXMWKcFXH9BIrBREU5b4wl/t83WKUee+r
 kP8IBlzQInnQ3lWEgE/+7r7Rql1rsTWu9d+kwxSRwPZSiujhwarQrtIpwR9VWJbPp6rB Wg== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tsnb0d80k-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 13:36:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yy6Xuxttwcp0zex9qUe55yXWU9J48mpDRLZxe7ATnGHRVhKO0g/4KhVcThxFlXMXQTpYRC4+yBhXTkId8O/EjRSXA51akY/eOxGy+c/URRBYlnetGK8hFD2+uQSY1lqENFmv7llZ4oVd9WRMsB+m83PBz7Yqb/JtsiKAfyBXjcrOM7u7nfjgnntuX+2BSEJIKjvPx86gfR8uzyNJvqrpKDwVy8GviYZhUkQuL2gCuCaDHhRPDxlbm0k70hElZxa1FzSChDuTCe1vaav2VMon/csvoW3psesX8YOoDCL2f7ZgGzflKBHLCPnaB6FfFbShVY42zF2IDc34yDT7dduc6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3GLEnKghrrZvdCzNbEirRv0bMJXU8oeVo5q80XFtBg=;
 b=knsDg2nHcfR9vE2NQd82c4yX9wX+DIl1X/48+8tlb9sAVCi42ZS5ZdShqMt/RwLfkfnBCWCvoeHc5m1lzP+g2zzEQyOCVTC6ws8UCkIJuMlX5krsGyMqTn5sQqcFFgSkKeZWY2DK6ZC6Ow4il6/3X9K/ZoQ9XHl+MO6PRWb78m8Cof9A3dl1Gb2tQ28ufb5+7mc1gUU7e8+lVcrbRPvoWvvmbr7/A1HNFgilzveFdezbCOEunSIT2YmJQDhEykBowS+D+8xElRtISkhz2T5oxq42dUxAPKsFr9qwm9VwQQ3IyD0lxEEhoOkadD85H9kuaczILZC5De6M7YeAuVv3aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by PH0PR15MB5657.namprd15.prod.outlook.com (2603:10b6:510:281::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Tue, 17 Oct
 2023 20:36:39 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::526c:b078:a1d1:fba8]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::526c:b078:a1d1:fba8%4]) with mapi id 15.20.6907.021; Tue, 17 Oct 2023
 20:36:39 +0000
From: Song Liu <songliubraving@meta.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
        Roberto Sassu <roberto.sassu@huaweicloud.com>
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: Add test that use fsverity
 and xattr to sign a file
Thread-Topic: [PATCH bpf-next 5/5] selftests/bpf: Add test that use fsverity
 and xattr to sign a file
Thread-Index: AQHZ/gM5diYylRpWEk+5ClNhxYAYe7BOXo2AgAAYoQA=
Date: Tue, 17 Oct 2023 20:36:39 +0000
Message-ID: <FE1E95AA-8076-454A-8B93-8918FB98729B@fb.com>
References: <20231013182644.2346458-1-song@kernel.org>
 <20231013182644.2346458-6-song@kernel.org>
 <CAADnVQK6_RNn3Bt=BKLecNrwS4pi2JOMq-h9O5qnE6EJhpitXw@mail.gmail.com>
In-Reply-To: 
 <CAADnVQK6_RNn3Bt=BKLecNrwS4pi2JOMq-h9O5qnE6EJhpitXw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.100.2.1.4)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|PH0PR15MB5657:EE_
x-ms-office365-filtering-correlation-id: 1b4c4ab6-7060-488a-26ea-08dbcf50c3f9
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 TuvnmLP7TlwHl+LT0lD3G2p44mJW4se1RWuD458tfKb2GhSuEbmlSVqOi4llDm9EKxDCzY/pt9cC7dmxB3n2enqh7ehE8jVbtFhl+6roASA8Y+EcR7YdHuTtgTBl55F/ElIOhh+ezG+/lV9OoQI9OJntvc2zcNp9CbAxx0BsZGZ3+bfJPyO3KvFZYvzVMhK8+VqSoq7lK9CG/+z4EieV5WqceQxC4kEM6j5yH9alucMhoSkMcLM6xuNP37tePURZlgKtkRT5bKOV8+U2mfrXYkx5AeKwJs2LpR/iQdingcTRpNlxW+F6DRZGjMmCWE4MUskHJUSlOulPacfmp3PDZFqlNVKtGxeqS5Oi+ppuXFxKaYZF6mYM5qSgivpBWaBO5E1yOx7W2zsUcePWM3riqs4tAPH7Xq6V9gpFDSFpDCw/jIXfaELbU74Ado0NYUQdEGiW8MTEtxITlIX3jAdtefsJT34GpEOu2xFNDur39BaZacxApZtSHLbQTGcUEVYlG7x0HkTOa7uS0B5M+jFzcr0fy2tTzlTtvxrGWrVnW4fHbZHLGG49I96cbt+dBWFLJ08R9JXXzKY2LgvVoJcBndMYuZ6PUsCHYhp9piIYUIceTcbj95dEdhQVzuEtdDhT
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(346002)(366004)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(9686003)(6512007)(71200400001)(8936002)(53546011)(83380400001)(6506007)(7416002)(5660300002)(41300700001)(4326008)(66556008)(6486002)(2906002)(478600001)(8676002)(6916009)(66946007)(64756008)(54906003)(66446008)(66476007)(91956017)(36756003)(122000001)(38070700005)(76116006)(316002)(38100700002)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OHR2MUdocExYVWVUbVF1YS9TUVVVZHZKR3ZLMWwrQVZEckZ0THJWMS9iUkZy?=
 =?utf-8?B?Vlh0VjFFT09tdVdFeXdTaVhDajVtZnJRMUZyeFgwN0dIVnFYRGp5eDhXU0tW?=
 =?utf-8?B?OW81RVV1a1JjVGFrdURkc0VJZGJIU0gyeTV0Y0xvaGRERS81QjQvVS9sS21h?=
 =?utf-8?B?Z1R5Uk5GWUZWTjhLYXVaQ01OY2wrS3pyaTUycUJWUFVTRGxuVUJSU1hjZ1Uv?=
 =?utf-8?B?d1FwWTZyWDdhc1pDbHpkT1pTeHpTdVg0RFhuYXd5L3o0L3NXQjZOMklvZm4y?=
 =?utf-8?B?SVNFM0xTYWJVWGdScEZUdjVmMnpRcGhFMDNNZUJnZFRhTHF0eHJaaTFiZjdh?=
 =?utf-8?B?UlE0ODJFTUFXWTNzUis4Q2FkSWhKQ3k4MnI2ZjJ1ZDJyNFg3QWlrd29ZYlJI?=
 =?utf-8?B?MUVmSWY4M21QUVRVck9iaTFkK00zZWtOd3A5M0ZudzJLb2RzVERPTHZRVFpa?=
 =?utf-8?B?dnhDVlhWSGIzc2lYSjRqZUkvK3J2UmVJK1dkM3VMZ3B3UUFTL3E4TU94MGxB?=
 =?utf-8?B?V3JRcXhsQWRQMkNOcFh2b2ZyeVpNVTZ0M0xUU1p4VjBsclMreFIvWmQ0Vmxh?=
 =?utf-8?B?ODZaUzhMUllQanlMNkdXbzZqejNEVEgzWWcxeHF6VlFQd0FFT1dlRmx2aEJ6?=
 =?utf-8?B?L0dtdTIzTFg2K21YZExhcmYvUDF4RWEvWFJxK3p2QitsVXFWWnpxcjE2RWVz?=
 =?utf-8?B?SkpzSEYxVDgvQlRsc3ZJR0d2LzhPcTRiN3FwNGh5Wm9hTHFJTzl4WEsranhk?=
 =?utf-8?B?RXkrSFdaeVc5SWd5NitFck05Z1A0UldodTBhVm1Ia3RqcUgzMDNYcUd2QVVu?=
 =?utf-8?B?dnIwdFhoUm1qV2QzVmMvYUxvMVJsYlhYa1hBTittdEN1M29EdkhTNmJiUEo1?=
 =?utf-8?B?UWlyMEZiRlJWL2ZnWS9HNzNyVHY5WElZSWxzbUpxaHU2eXRoZERDVXZQaGs1?=
 =?utf-8?B?bFV0YzRxajdVUXJJNDhxb1o3ZW5jcWdNMzVqN01UdGtqSWNjbXBuV0Nidzhn?=
 =?utf-8?B?MkIzc0ZmQ1c5MlVheXRZaVRONjNoUlBYc0hoNDNvcDdrWXhkbGhNN2p0Vmxu?=
 =?utf-8?B?ME5UN3NIdjJrWU44dG9KWlZKbkVYUkRkYmJJTFNBajA4Rlp6SlFobHcwdkx6?=
 =?utf-8?B?Um12VFBTK0N3WTNMY0ZSc3NCRzF4Q2QzbThONUNLSiszZzlHK0lRcndmODVy?=
 =?utf-8?B?RjJHSkp1anZVWk02aS9QZEpsUVhFQ2xGanliVFAxQ0FSVjFkOTFmeDV5ZU84?=
 =?utf-8?B?cW9Ga01FNWVtbHd1L2ZDcGNkenB0L2FRL3laOWR1clkrUExXNXRweUhRNDRn?=
 =?utf-8?B?QjhYbkN2eU1IMWp2SDdRYlpvYzk1MkZJK1BWdzgxQSt1RFFqZkFJL0F6VUt5?=
 =?utf-8?B?WUxyYXQ3MHY5ZnpPL0FmSHcyODJ2cVNOcU4vMlZUdk1lTTMvVkZTbm5lbVhl?=
 =?utf-8?B?M3pyMTBXMzdwRE5OVzdwV0pxTVdpak05TklyeWVuRm55UnVzRG5EQnRUb2tI?=
 =?utf-8?B?SnFFL05hQWtUa2h6VGltS3d3ajRPZ0pqcmw2anVzQlFqdENieXA3UkhGZVoz?=
 =?utf-8?B?QkpoYWxqa1JQaGViSmtvZWtXTFhMSXJGWFZoTXFIVEtTY09XY3FxQ0pXaHBG?=
 =?utf-8?B?MzV1K1QwZGg2M09QVCtMRjgyTmRQVnhMMUFkdmN2V1Rmb0ZXRVh6NG4zQ20r?=
 =?utf-8?B?b1lkc1Jva2VzRFFxVFpkMGVvS3F1S0Z3VVRGMEc1UGM1K1l1N3AvVXNsTCt1?=
 =?utf-8?B?U0JsTXJVSmJScllaY3ZOUm56R0ZKMVBxSDE4bU90MWNob1Z3OG0vTXlFc3oy?=
 =?utf-8?B?MmRySUwxUTZBSHV4TGkvR2NhQ2N4UUJvUjBWMldSZFRMUzU3QWpuTWNzdW9w?=
 =?utf-8?B?VXh1Q0g3dVNvSHNXSVdDKzhEeW1xRURIZ1Bmd2RVak5DVHNPRlFVTjJidytM?=
 =?utf-8?B?NUhDemdCVlp6S1BJOGdpa0pHU0ZnKzlVd2hkK1VmSVRDTUlmZnZXdlVWSVA3?=
 =?utf-8?B?WHRUZm9qVlVyN2p1dnRpbFR5bytmcWdtaVBxcnBCUFEwV2w3OG9idWRKbGFx?=
 =?utf-8?B?ZWJrbWFMTFBkMzlucGZPaHZLVURic2EvWTJPN2h6V1IvVFI5dmIzRzdCelZn?=
 =?utf-8?B?OTUvN1k2UDY0dXJYbXdqVk9BOERMR01BRVhCU2N6ekl5dm5WZFoyL1NSemxq?=
 =?utf-8?Q?+Seuh7C3R54hc8W3415YWhs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6276BBC4A20F04D99B25687A747BECF@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4c4ab6-7060-488a-26ea-08dbcf50c3f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 20:36:39.5106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bC799cDI6RyOtRe0iBbMaoSIeP/qaqv0fxKEc+HSzrWj4dizw4NIPHJ6ImM5e2/U7fTsFFURQpJeosXOKXAQAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5657
X-Proofpoint-GUID: 3zuNhAZXoQe1FNm93HxDvGEv903gf2ni
X-Proofpoint-ORIG-GUID: 3zuNhAZXoQe1FNm93HxDvGEv903gf2ni
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_03,2023-10-17_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCj4gT24gT2N0IDE3LCAyMDIzLCBhdCAxMjowOOKAr1BNLCBBbGV4ZWkgU3Rhcm92b2l0b3Yg
PGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gRnJpLCBPY3Qg
MTMsIDIwMjMgYXQgMTE6MjnigK9BTSBTb25nIExpdSA8c29uZ0BrZXJuZWwub3JnPiB3cm90ZToN
Cj4+IA0KPj4gKyNkZWZpbmUgTUFHSUNfU0laRSA4DQo+PiArY2hhciBkaWdlc3RbTUFHSUNfU0la
RSArIHNpemVvZihzdHJ1Y3QgZnN2ZXJpdHlfZGlnZXN0KSArIFNIQTI1Nl9ESUdFU1RfU0laRV07
DQo+PiArDQo+PiArX191MzIgbW9uaXRvcmVkX3BpZDsNCj4+ICtjaGFyIHhhdHRyX25hbWVbXSA9
ICJ1c2VyLnNpZyI7DQo+PiArY2hhciBzaWdbTUFYX1NJR19TSVpFXTsNCj4+ICtfX3UzMiBzaWdf
c2l6ZTsNCj4+ICtfX3UzMiB1c2VyX2tleXJpbmdfc2VyaWFsOw0KPj4gKw0KPj4gK1NFQygibHNt
LnMvZmlsZV9vcGVuIikNCj4+ICtpbnQgQlBGX1BST0codGVzdF9maWxlX29wZW4sIHN0cnVjdCBm
aWxlICpmKQ0KPj4gK3sNCj4+ICsgICAgICAgc3RydWN0IGJwZl9keW5wdHIgZGlnZXN0X3B0ciwg
c2lnX3B0ciwgbmFtZV9wdHI7DQo+PiArICAgICAgIHN0cnVjdCBicGZfa2V5ICp0cnVzdGVkX2tl
eXJpbmc7DQo+PiArICAgICAgIF9fdTMyIHBpZDsNCj4+ICsgICAgICAgaW50IHJldDsNCj4+ICsN
Cj4+ICsgICAgICAgcGlkID0gYnBmX2dldF9jdXJyZW50X3BpZF90Z2lkKCkgPj4gMzI7DQo+PiAr
ICAgICAgIGlmIChwaWQgIT0gbW9uaXRvcmVkX3BpZCkNCj4+ICsgICAgICAgICAgICAgICByZXR1
cm4gMDsNCj4+ICsNCj4+ICsgICAgICAgLyogZGlnZXN0X3B0ciBwb2ludHMgdG8gZnN2ZXJpdHlf
ZGlnZXN0ICovDQo+PiArICAgICAgIGJwZl9keW5wdHJfZnJvbV9tZW0oZGlnZXN0ICsgTUFHSUNf
U0laRSwgc2l6ZW9mKGRpZ2VzdCkgLSBNQUdJQ19TSVpFLCAwLCAmZGlnZXN0X3B0cik7DQo+PiAr
DQo+PiArICAgICAgIHJldCA9IGJwZl9nZXRfZnN2ZXJpdHlfZGlnZXN0KGYsICZkaWdlc3RfcHRy
KTsNCj4+ICsgICAgICAgLyogTm8gdmVyaXR5LCBhbGxvdyBhY2Nlc3MgKi8NCj4+ICsgICAgICAg
aWYgKHJldCA8IDApDQo+PiArICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+PiArDQo+PiArICAg
ICAgIC8qIE1vdmUgZGlnZXN0X3B0ciB0byBmc3Zlcml0eV9mb3JtYXR0ZWRfZGlnZXN0ICovDQo+
PiArICAgICAgIGJwZl9keW5wdHJfZnJvbV9tZW0oZGlnZXN0LCBzaXplb2YoZGlnZXN0KSwgMCwg
JmRpZ2VzdF9wdHIpOw0KPj4gKw0KPj4gKyAgICAgICAvKiBSZWFkIHNpZ25hdHVyZSBmcm9tIHhh
dHRyICovDQo+PiArICAgICAgIGJwZl9keW5wdHJfZnJvbV9tZW0oc2lnLCBzaXplb2Yoc2lnKSwg
MCwgJnNpZ19wdHIpOw0KPj4gKyAgICAgICBicGZfZHlucHRyX2Zyb21fbWVtKHhhdHRyX25hbWUs
IHNpemVvZih4YXR0cl9uYW1lKSwgMCwgJm5hbWVfcHRyKTsNCj4+ICsgICAgICAgcmV0ID0gYnBm
X2dldF9maWxlX3hhdHRyKGYsICZuYW1lX3B0ciwgJnNpZ19wdHIpOw0KPj4gKyAgICAgICAvKiBO
byBzaWduYXR1cmUsIHJlamVjdCBhY2Nlc3MgKi8NCj4+ICsgICAgICAgaWYgKHJldCA8IDApDQo+
PiArICAgICAgICAgICAgICAgcmV0dXJuIC1FUEVSTTsNCj4+ICsNCj4+ICsgICAgICAgdHJ1c3Rl
ZF9rZXlyaW5nID0gYnBmX2xvb2t1cF91c2VyX2tleSh1c2VyX2tleXJpbmdfc2VyaWFsLCAwKTsN
Cj4+ICsgICAgICAgaWYgKCF0cnVzdGVkX2tleXJpbmcpDQo+PiArICAgICAgICAgICAgICAgcmV0
dXJuIC1FTk9FTlQ7DQo+PiArDQo+PiArICAgICAgIC8qIFZlcmlmeSBzaWduYXR1cmUgKi8NCj4+
ICsgICAgICAgcmV0ID0gYnBmX3ZlcmlmeV9wa2NzN19zaWduYXR1cmUoJmRpZ2VzdF9wdHIsICZz
aWdfcHRyLCB0cnVzdGVkX2tleXJpbmcpOw0KPj4gKw0KPj4gKyAgICAgICBicGZfa2V5X3B1dCh0
cnVzdGVkX2tleXJpbmcpOw0KPj4gKyAgICAgICByZXR1cm4gcmV0Ow0KPj4gK30NCj4gDQo+IEkg
dGhpbmsgdGhlIFVYIGlzIGN1bWJlcnNvbWUuDQo+IFB1dHRpbmcgYSBOVUxMIHRlcm1pbmF0ZWQg
c3RyaW5nIGludG8gZHlucHRyIG5vdCBvbmx5IGEgc291cmNlDQo+IGNvZGUgdWdsaW5lc3MsIGJ1
dCBpdCBhZGRzIHJ1bi10aW1lIG92ZXJoZWFkIHRvby4NCj4gV2UgYmV0dGVyIGFkZCBwcm9wZXIg
QyBzdHlsZSBzdHJpbmcgc3VwcG9ydCBpbiB0aGUgdmVyaWZpZXIsDQo+IHNvIHRoYXQgYnBmX2dl
dF9maWxlX3hhdHRyKCkgY2FuIGxvb2sgbGlrZSBub3JtYWwgQy4NCg0KVGhhdCB3aWxsIGluZGVl
ZCBsb29rIG11Y2ggYmV0dGVyLiBMZXQgbWUgY2hlY2sgd2hhdCBkbyB3ZSBuZWVkIA0KbWFrZSB0
aGlzIGhhcHBlbi4NCg0KVGhhbmtzLA0KU29uZw0KDQo=

