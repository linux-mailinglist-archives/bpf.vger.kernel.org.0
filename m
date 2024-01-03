Return-Path: <bpf+bounces-18896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C306D82356E
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 20:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4727C1F25F98
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 19:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0C01CA9A;
	Wed,  3 Jan 2024 19:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="D8gKN+aI"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00881CF83
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355091.ppops.net [127.0.0.1])
	by mx0b-00823401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 403C8Q69026690;
	Wed, 3 Jan 2024 19:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	DKIM202306; bh=iM2Tg/ogwwQUCrHkJZEfoUR4fPTNmXRTvnvL5bFmZdM=; b=D
	8gKN+aI8+7V2Alhrcb86B7FAKG9d2rilgqGZqGx8Uminw3IsmA1wNa12qZ6/XPv7
	Y1PH0F9Ml7HrDvPe8CA7blXnjfsMrCQvqdp1rSVrdwNbSSvHCdRvuIbVKLwHY9ES
	IyY4CdB70F8J2hXViVdNvGhjoWWSRG7Me2VlHVpstVp7ywJAGwVtzXXuymuILeRZ
	GeFw1XCPfFP++kxheIAd6pZYEUCkSQ6Fkv02evpx64vRkwZmNQ/vJZdQuQlsnEfk
	YQtGSxEymLE/i1lygxrurGuWJVxc6SywjFHp6Fl+gFBrrddCqxkf6HbVRydbce6Y
	qYgoKYH8gjZU52GuszeeA==
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2041.outbound.protection.outlook.com [104.47.26.41])
	by mx0b-00823401.pphosted.com (PPS) with ESMTPS id 3vd7aw0p8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 19:16:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0+Fn7/6deFBiuBN//0dVaD7qov2kQO1Ub4OVNdvIPEfFyRQQkHjPAr0MtQgO+9PuwRt8fQ/bVfYaTOg6q6UVk6jr4WPHL+zYoR6+B4gNOdHKiazgzTNUVvAMTSTdlCSn4ejKZYRmX+54g3MExuYJ4us8QIzL0AcmhNdUmLRi4zIqQRQ6OghyFQj7bSoJ4lDLhJmZ5m7K6nqIrNqIdVXV/V3oC0sOHA+UzwtypdJOVtaRSuJo/MIECJO6DcRd0t9VKCfveAMP0ByqRite2o7urYlkSjIoSVLP2Hp6s7KHpLymSPtS0eu4TlxJqfDijBZpytCOYc03ayxzy+p9bKZug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iM2Tg/ogwwQUCrHkJZEfoUR4fPTNmXRTvnvL5bFmZdM=;
 b=XXJ5jWmg5e47tOu2KmumNTtLBCzs+dF7EB13qm4FR4A+Bo5vj6lpFeCcNJ0mk2EhMyWmkHo2MxbqGPOApMuN6VhFTf5Pk/sBvVydFHiOvOyh3qJG8ZYVv2GkP/5Uw3zRkqYU5jhlTsXFmEWH2TyLYn0A1/9MIhATME1qSfdNQxpjKZkI+0QbOpmNdSCUH2jrAGnxO6ORvM2iTzTDhvalcaKgeXdSRRpKonM1EwoCi1Hd0d00RiFkajbLMhXSP01cpJYK4CMhGNutRlxBHLCfo3+n0wQURxI7xRpqFDKwwhb1XvfCHI2g5hc0mSYbXnwVktx3TsvWqVUySNZJxNmwzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=motorola.com; dmarc=pass action=none header.from=motorola.com;
 dkim=pass header.d=motorola.com; arc=none
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com (2603:1096:101:66::5)
 by TYZPR03MB5437.apcprd03.prod.outlook.com (2603:1096:400:37::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 19:16:32 +0000
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::c0d5:21be:6c82:e5f6]) by SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::c0d5:21be:6c82:e5f6%6]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 19:16:32 +0000
From: Maxwell Bland <mbland@motorola.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Andrew Wheeler
	<awheeler@motorola.com>,
        =?utf-8?B?U2FtbXkgQlMyIFF1ZSB8IOmYmeaWjOeUnw==?=
	<quebs2@motorola.com>,
        "di_jin@brown.edu" <di_jin@brown.edu>
Subject: [PATCH 1/2] Adding BPF NX
Thread-Topic: [PATCH 1/2] Adding BPF NX
Thread-Index: AQHaPnlcQ/EeS56CsE2L+Zet/Q/kJw==
Date: Wed, 3 Jan 2024 19:16:32 +0000
Message-ID: 
 <SEZPR03MB6786B27446DE261893D911B5B4602@SEZPR03MB6786.apcprd03.prod.outlook.com>
References: 
 <SEZPR03MB6786598744F4D5DE29C46651B4602@SEZPR03MB6786.apcprd03.prod.outlook.com>
 <2024010317-undercoat-widow-e087@gregkh>
 <SEZPR03MB678613E8257AD66C6CE47410B4602@SEZPR03MB6786.apcprd03.prod.outlook.com>
In-Reply-To: 
 <SEZPR03MB678613E8257AD66C6CE47410B4602@SEZPR03MB6786.apcprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6786:EE_|TYZPR03MB5437:EE_
x-ms-office365-filtering-correlation-id: 63542b0d-f80e-43a9-c4ac-08dc0c907ec0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 7sUQUWfhkGk5oTehjjwumi5De+RR0H42Vtyz0j8Ap9lD8grjK80tCs5cSxILPymdy3AtIRCkN+k6t5qwcniP0/KKyvV3ywaRKh5i6gPVxpyMRj+hDvdqwwwesSVGZvXJxTpPgBObfYSuI7kwATHF5bJG5nlw13OGQIE+N8B6zQK1vCXk6YVrbiFXDIW+we9vNOFAyCHG2Ex+xDNgaHDIfinsfxYXGBSqBu0r6vBSMmylS0yyrWzIZD/2IRpH+I+Q+PsWx4wxJxVFdgAcSHA1rh/p5OVxadk6Z30g8OR/aB0Lefpn8Dt1GKjWZdngYN6C3oA/qD7c4FeH1AAcCa0t5Gl/L++JdmiGJHpYzmsTm+aem/4QCt1iMVCgACpexF/koMYagj6+lrzTiLBCxcZ7CK4L3xXt77IdKN7QJwfR9ZFJ/uZSgVpkahBakGJV+NieTGfy6+1P0MQkGNyNcJTS6t2XopnpEs6dneFvgEfhU6mtkNGu+K5rz2bQxa7c20yKq2wMwLrkfBrSSWF2YKNEKPXVgKqEjcaqFKSKGZj4AoQCRQ9vV6vwXMjXqkRxiYWCVsIrkjvZHB0/b4yw1JEU5CUvcHNQ5DNQoGCUfYDVbCpPJmLE6OjQUcS66PO+W9azPQdXIpllrkSy/csAsKqvWyn3zGS5jo9nMLx1j/C+srs=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6786.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(41300700001)(2906002)(26005)(38100700002)(2940100002)(122000001)(82960400001)(54906003)(8676002)(52536014)(8936002)(316002)(71200400001)(5660300002)(4326008)(478600001)(6506007)(64756008)(7696005)(66556008)(76116006)(9686003)(66476007)(66446008)(6916009)(66946007)(86362001)(38070700009)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?d3V2MTg2UStmaU83dXgrUmpoL1V6ZmZmVC94UUR5NjEvdHBFZTE3eitlRDdJ?=
 =?utf-8?B?TlFkUnk1NGNpaUx1cVhHWURIenJTZGNKVTVhZGdVVy9NV0VZRDZYK3dnOWxl?=
 =?utf-8?B?MmJ3bzdlNzU4c1VVb0NrcXJ5N0c1NmMva0hkM0NoQTZvVjdONGFkZFhzR1V3?=
 =?utf-8?B?c2F1djR5TUxvbkJrY3RGTitoeXNyQWNVSHdGdnhhVFpIS1BZZkVlaHpRK0ZQ?=
 =?utf-8?B?c1dLK25WNmRleFlsZXl3MDdNMlVqaitIVUF4c2cyQ0FEVnphZWJHbzFTQmJ3?=
 =?utf-8?B?RXhNc2daUTdkMlNscWxHSjZ6SXdVcnNoNFRhK0RHNEhVWmtCajFyU09uQWRT?=
 =?utf-8?B?V1lJdzlCVEJPUGJqc3dwRHdJUjhtS3pkNGNNUjBCNlI1OVV5MVMzbDdKMVBn?=
 =?utf-8?B?K0orb0dnM2tKWkhmNjdHN3d0SkVMS3dQMTIyZ2xQeDlHYXhxKzhWSTF1RytI?=
 =?utf-8?B?QmlMejhYZ0NiY2k2b2xYR3d1aTR4VUY5RTlqb0JOY3RFdWw2bHhWbXViN2ZY?=
 =?utf-8?B?MU5IbUZDaFdXaE5laVl6VmxxRDRPYU1sSE9uL2g0UTJ5dTFFVjRwVjdBaVRQ?=
 =?utf-8?B?NWJOWXJERGdnTFJMZDdlSmN1Y1d1cWVsblZYb1dKcitaN2lsc1UvNW1HVHRk?=
 =?utf-8?B?cUFWOFVKaFA1WnFNVFEvWEpRVnJ0NmxOT1NPeVZEbzNMamhBUGdsZ0JzK0t1?=
 =?utf-8?B?RHVxOWJjR1htRkZ3SHpoVGw3czMwZXc5Sk82MnhzbklrTDVJTHhiUlUwbkUy?=
 =?utf-8?B?OFBzVFFoWXdTQUFWaHA0VHN4ZmVSS0xWOG5sZEJTSWFqeFVudjMzR3RsY3g4?=
 =?utf-8?B?RmV3TW1BaUdMcWhoT1FsTzVNSmtNVkJWd21PZzN5dFJkMGlFeEVPMTlWclF1?=
 =?utf-8?B?UGpKV0ZyMlRjT0lPMmVkaXgxTG5WUTlkeEVYeDBZSzArMzVFcHNudmZaU2NE?=
 =?utf-8?B?dStmQ0Q0ZmdIZnpPNWJQTFUrTWpqeFhiUGlOcmdIeHg0U1c5UWhpSkpkalBs?=
 =?utf-8?B?emw4dDk5dHAwWnZkbWlqOWFpME5jcHcybkVIMlV2ZnJ1elNmVVg5cTYwSDRo?=
 =?utf-8?B?UmNoVFNPdjE0UHJJN1cwU0VMend5TjgvR3Z0VWJORzROL2ovSHcrL051M21O?=
 =?utf-8?B?ZVd0c09IcGk5a2VBa2dzTGkydlg0Zi9FRE1QaE45YmpWQm5oT0wvWHNicm1r?=
 =?utf-8?B?TnJBbXF0Z1k4KzdLNksyN2N4aTI3YktvTGd6UXRzTzN4WnY4Wk5lZ3JGcTUw?=
 =?utf-8?B?c0JCUmFQd1lhTW4yUHoxRzBJT3Rib04wdWxDeEYvVzJqZE9WemVhMGpEdkdI?=
 =?utf-8?B?Zjhxcm96eWJKYXBlWDRXNHQrNGc2VlpaK3QwaXhGQUdaSU51b1FSRHg2V2dp?=
 =?utf-8?B?OU1oejA1dGFRL0RiMzN0Sm80NlExcTdqMHVreERhYlhhTi81Z1NObGg2Q3JO?=
 =?utf-8?B?R1Fpa2hwRlNjR2hjcjY0S0o0cnpJVnFRb0dUNjFYeGZsOG1tQi9iYUJUaGlo?=
 =?utf-8?B?c3UxamhQMkVZeTNXTkh5V2tKSERaazVVV3Q5SzlEajYrS2dlWVYyQ2RCTXRX?=
 =?utf-8?B?dEkyaXd2TEdCTSt1VlBKd1dDKzZxRUlwbWZrVmJlUkUzKzJGcWk0OWp2T293?=
 =?utf-8?B?R0FxVVFJYVVETU1uL1VZMG5RbDdWalZ6eVExL2ZDeEMwaTdMdm5yUGJsWVJL?=
 =?utf-8?B?NTRwRGorQ2tIcWNoSDQ1c2c5bVFvSU5iYjBMWTRheTRWcXBZYkxhbVpFZnJj?=
 =?utf-8?B?dU5TeWVYbEd6b2xObjNXRnBld2YzcmxVQVRab3pIbkFnQVpqRDBEMk1UL042?=
 =?utf-8?B?MXhSYjdKSXBwWllBL1E1ZytLM0I0Y2NuenZoTmFPczJQWGpzUWFzY1VyWmNa?=
 =?utf-8?B?Tk9uemR4Mkswc3JSYmFjcGlPemNZbXl0NXJkSHVKZXd3aDZ5OWltN01Kd0Nk?=
 =?utf-8?B?ZGxNdWoyNGxDNzhIdmlLOHdqdTFNZkoybExvL2hlaGdiOXp0RGg0bDNBcFg1?=
 =?utf-8?B?SS8vY0VxSHJjZWp4OVpjaS9PQmtLekJBQ1IwTEFqWk54WGlPVk5QWGt4NUdR?=
 =?utf-8?B?emM1YmVpQ2R6d0RJQXlnY2lBVXZ3dkpyYUFtSzBUcmwxdnQvcGl1UzdIMkZK?=
 =?utf-8?Q?ZTC4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: motorola.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6786.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63542b0d-f80e-43a9-c4ac-08dc0c907ec0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 19:16:32.0986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T1W6DO5DTN/lS9MUl8lSEERIhFmhBF0aVZi2u+fixwjZka/MdL0/DlcKa9rdeBoZwJf1DWc2+9dw+wZnXDOmZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5437
X-Proofpoint-ORIG-GUID: zg3F4QOZr1n48DJW85IKbNfrLvH2yJ-7
X-Proofpoint-GUID: zg3F4QOZr1n48DJW85IKbNfrLvH2yJ-7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 mlxlogscore=949 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401030156

RnJvbTogVGVudXQgPHRlbnV0QE5pb2JpdW0+DQpTdWJqZWN0OiBbUEFUQ0ggMS8yXSBBZGRpbmcg
QlBGIE5YDQoNClJlc2VydmUgYSBtZW1vcnkgcmVnaW9uIGZvciBCUEYgcHJvZ3JhbSwgYW5kIGNo
ZWNrIGZvciBpdCBpbiB0aGUgaW50ZXJwcmV0ZXIuIFRoaXMgc2ltdWxhdGUgdGhlIGVmZmVjdCBv
ZiBub24tZXhlY3V0YWJsZSBtZW1vcnkgZm9yIEJQRiBleGVjdXRpb24uDQoNClNpZ25lZC1vZmYt
Ynk6IE1heHdlbGwgQmxhbmQgPG1ibGFuZEBtb3Rvcm9sYS5jb20+DQotLS0NCmFyY2gveDg2L2lu
Y2x1ZGUvYXNtL3BndGFibGVfNjRfdHlwZXMuaCB8ICA5ICsrKysrKysrKw0KIGFyY2gveDg2L21t
L2ZhdWx0LmMgICAgICAgICAgICAgICAgICAgICB8ICA2ICsrKysrLQ0KIGtlcm5lbC9icGYvS2Nv
bmZpZyAgICAgICAgICAgICAgICAgICAgICB8IDE2ICsrKysrKysrKysrKysrKw0KIGtlcm5lbC9i
cGYvY29yZS5jICAgICAgICAgICAgICAgICAgICAgICB8IDM1ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0tLQ0KIDQgZmlsZXMgY2hhbmdlZCwgNjIgaW5zZXJ0aW9ucygrKSwgNCBkZWxl
dGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BndGFibGVfNjRf
dHlwZXMuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BndGFibGVfNjRfdHlwZXMuaA0KaW5kZXgg
MzhiNTRiOTkyZjMyLi5hZDExNjUxZWIwNzMgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS9wZ3RhYmxlXzY0X3R5cGVzLmgNCisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BndGFi
bGVfNjRfdHlwZXMuaA0KQEAgLTEyMyw2ICsxMjMsOSBAQCBleHRlcm4gdW5zaWduZWQgaW50IHB0
cnNfcGVyX3A0ZDsNCiANCiAjZGVmaW5lIF9fVk1BTExPQ19CQVNFX0w0CTB4ZmZmZmM5MDAwMDAw
MDAwMFVMDQogI2RlZmluZSBfX1ZNQUxMT0NfQkFTRV9MNSAJMHhmZmEwMDAwMDAwMDAwMDAwVUwN
CisjaWZkZWYgQ09ORklHX0JQRl9OWA0KKyNkZWZpbmUgX19CUEZfVkJBU0UJCTB4ZmZmZmViMDAw
MDAwMDAwMFVMDQorI2VuZGlmDQogDQogI2RlZmluZSBWTUFMTE9DX1NJWkVfVEJfTDQJMzJVTA0K
ICNkZWZpbmUgVk1BTExPQ19TSVpFX1RCX0w1CTEyODAwVUwNCkBAIC0xNjksNiArMTcyLDEyIEBA
IGV4dGVybiB1bnNpZ25lZCBpbnQgcHRyc19wZXJfcDRkOw0KICNkZWZpbmUgVk1BTExPQ19RVUFS
VEVSX1NJWkUJKChWTUFMTE9DX1NJWkVfVEIgPDwgNDApID4+IDIpDQogI2RlZmluZSBWTUFMTE9D
X0VORAkJKFZNQUxMT0NfU1RBUlQgKyBWTUFMTE9DX1FVQVJURVJfU0laRSAtIDEpDQogDQorI2lm
ZGVmIENPTkZJR19CUEZfTlgNCisjZGVmaW5lIEJQRl9TSVpFX0dCCQk1MTJVTA0KKyNkZWZpbmUg
QlBGX1ZTVEFSVAkJX19CUEZfVkJBU0UNCisjZGVmaW5lIEJQRl9WRU5ECQkoQlBGX1ZTVEFSVCAr
IF9BQyhCUEZfU0laRV9HQiA8PCAzMCwgVUwpKQ0KKyNlbmRpZiAvKiBDT05GSUdfQlBGX05YICov
DQorDQogLyoNCiAgKiB2bWFsbG9jIG1ldGFkYXRhIGFkZHJlc3NlcyBhcmUgY2FsY3VsYXRlZCBi
eSBhZGRpbmcgc2hhZG93L29yaWdpbiBvZmZzZXRzDQogICogdG8gdm1hbGxvYyBhZGRyZXNzLg0K
ZGlmZiAtLWdpdCBhL2FyY2gveDg2L21tL2ZhdWx0LmMgYi9hcmNoL3g4Ni9tbS9mYXVsdC5jIGlu
ZGV4IGFiNzc4ZWFjMTk1Mi4uY2ZiNjNlZjcyMTY4IDEwMDY0NA0KLS0tIGEvYXJjaC94ODYvbW0v
ZmF1bHQuYw0KKysrIGIvYXJjaC94ODYvbW0vZmF1bHQuYw0KQEAgLTIzNSw3ICsyMzUsMTEgQEAg
c3RhdGljIG5vaW5saW5lIGludCB2bWFsbG9jX2ZhdWx0KHVuc2lnbmVkIGxvbmcgYWRkcmVzcykN
CiAJcHRlX3QgKnB0ZV9rOw0KIA0KIAkvKiBNYWtlIHN1cmUgd2UgYXJlIGluIHZtYWxsb2MgYXJl
YTogKi8NCi0JaWYgKCEoYWRkcmVzcyA+PSBWTUFMTE9DX1NUQVJUICYmIGFkZHJlc3MgPCBWTUFM
TE9DX0VORCkpDQorCWlmICghKGFkZHJlc3MgPj0gVk1BTExPQ19TVEFSVCAmJiBhZGRyZXNzIDwg
Vk1BTExPQ19FTkQpICNpZmRlZiBCUEZfTlgNCisJCSYmICEoYWRkcmVzcyA+PSBCUEZfVlNUQVJU
ICYmIGFkZHJlc3MgPCBCUEZfVkVORCkgI2VuZGlmDQorCSkNCiAJCXJldHVybiAtMTsNCiANCiAJ
LyoNCmRpZmYgLS1naXQgYS9rZXJuZWwvYnBmL0tjb25maWcgYi9rZXJuZWwvYnBmL0tjb25maWcN
CmluZGV4IDZhOTA2ZmY5MzAwNi4uNzE2MGRjYWFhNThhIDEwMDY0NA0KLS0tIGEva2VybmVsL2Jw
Zi9LY29uZmlnDQorKysgYi9rZXJuZWwvYnBmL0tjb25maWcNCkBAIC04Niw2ICs4NiwyMiBAQCBj
b25maWcgQlBGX1VOUFJJVl9ERUZBVUxUX09GRg0KIA0KIAkgIElmIHlvdSBhcmUgdW5zdXJlIGhv
dyB0byBhbnN3ZXIgdGhpcyBxdWVzdGlvbiwgYW5zd2VyIFkuDQogDQorY29uZmlnIEJQRl9IQVJE
RU5JTkcNCisJYm9vbCAiRW5hYmxlIEJQRiBpbnRlcnByZXRlciBoYXJkZW5pbmciDQorCXNlbGVj
dCBCUEYNCisJZGVwZW5kcyBvbiBYODZfNjQgJiYgIVJBTkRPTUlaRV9NRU1PUlkgJiYgIUJQRl9K
SVRfQUxXQVlTX09ODQorCWRlZmF1bHQgbg0KKwloZWxwDQorCSAgRW5oYW5jZSBicGYgaW50ZXJw
cmV0ZXIncyBzZWN1cml0eQ0KKw0KK2NvbmZpZyBCUEZfTlgNCitib29sICJFbmFibGUgYnBmIE5Y
Ig0KKwlkZXBlbmRzIG9uIEJQRl9IQVJERU5JTkcgJiYgIURZTkFNSUNfTUVNT1JZX0xBWU9VVA0K
KwlkZWZhdWx0IG4NCisJaGVscA0KKwkgIEFsbG9jYXRlIGVCUEYgcHJvZ3JhbXMgaW4gc2VwZXJh
dGUgYXJlYSBhbmQgbWFrZSBzdXJlIHRoZQ0KKwkgIGludGVycHJldGVkIHByb2dyYW1zIGFyZSBp
biB0aGUgcmVnaW9uLg0KKw0KIHNvdXJjZSAia2VybmVsL2JwZi9wcmVsb2FkL0tjb25maWciDQog
DQogY29uZmlnIEJQRl9MU00NCmRpZmYgLS1naXQgYS9rZXJuZWwvYnBmL2NvcmUuYyBiL2tlcm5l
bC9icGYvY29yZS5jDQppbmRleCBmZTI1NGFlMDM1ZmUuLjU2ZDllOGQ0YTZkZSAxMDA2NDQNCi0t
LSBhL2tlcm5lbC9icGYvY29yZS5jDQorKysgYi9rZXJuZWwvYnBmL2NvcmUuYw0KQEAgLTg4LDYg
Kzg4LDM0IEBAIHZvaWQgKmJwZl9pbnRlcm5hbF9sb2FkX3BvaW50ZXJfbmVnX2hlbHBlcihjb25z
dCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBpbnQgaywgdW5zDQogCXJldHVybiBOVUxMOw0KIH0NCiAN
CisjaWZkZWYgQ09ORklHX0JQRl9OWA0KKyNkZWZpbmUgQlBGX01FTU9SWV9BTElHTiByb3VuZHVw
X3Bvd19vZl90d28oc2l6ZW9mKHN0cnVjdCBicGZfcHJvZykgKyBcDQorCQlCUEZfTUFYSU5TTlMg
KiBzaXplb2Yoc3RydWN0IGJwZl9pbnNuKSkNCitzdGF0aWMgdm9pZCAqX19icGZfdm1hbGxvYyh1
bnNpZ25lZCBsb25nIHNpemUsIGdmcF90IGdmcF9tYXNrKQ0KK3sNCisJcmV0dXJuIF9fdm1hbGxv
Y19ub2RlX3JhbmdlKHNpemUsIEJQRl9NRU1PUllfQUxJR04sIEJQRl9WU1RBUlQsIEJQRl9WRU5E
LA0KKwkJCWdmcF9tYXNrLCBQQUdFX0tFUk5FTCwgMCwgTlVNQV9OT19OT0RFLA0KKwkJCV9fYnVp
bHRpbl9yZXR1cm5fYWRkcmVzcygwKSk7DQorfQ0KKw0KK3N0YXRpYyB2b2lkIGJwZl9pbnNuX2No
ZWNrX3JhbmdlKGNvbnN0IHN0cnVjdCBicGZfaW5zbiAqaW5zbikNCit7DQorCWlmICgodW5zaWdu
ZWQgbG9uZylpbnNuIDwgQlBGX1ZTVEFSVA0KKwkJCXx8ICh1bnNpZ25lZCBsb25nKWluc24gPj0g
QlBGX1ZFTkQgLSBzaXplb2Yoc3RydWN0IGJwZl9pbnNuKSkNCisJCUJVRygpOw0KK30NCisNCisj
ZWxzZQ0KK3N0YXRpYyB2b2lkICpfX2JwZl92bWFsbG9jKHVuc2lnbmVkIGxvbmcgc2l6ZSwgZ2Zw
X3QgZ2ZwX21hc2spDQorew0KKwlyZXR1cm4gX192bWFsbG9jKHNpemUsIGdmcF9tYXNrKTsNCit9
DQorDQorc3RhdGljIHZvaWQgYnBmX2luc25fY2hlY2tfcmFuZ2UoY29uc3Qgc3RydWN0IGJwZl9p
bnNuICppbnNuKQ0KK3sNCit9DQorI2VuZGlmIC8qIENPTkZJR19CUEZfTlggKi8NCisNCiBzdHJ1
Y3QgYnBmX3Byb2cgKmJwZl9wcm9nX2FsbG9jX25vX3N0YXRzKHVuc2lnbmVkIGludCBzaXplLCBn
ZnBfdCBnZnBfZXh0cmFfZmxhZ3MpDQogew0KIAlnZnBfdCBnZnBfZmxhZ3MgPSBicGZfbWVtY2df
ZmxhZ3MoR0ZQX0tFUk5FTCB8IF9fR0ZQX1pFUk8gfCBnZnBfZXh0cmFfZmxhZ3MpOw0KQEAgLTk1
LDcgKzEyMyw3IEBAIHN0cnVjdCBicGZfcHJvZyAqYnBmX3Byb2dfYWxsb2Nfbm9fc3RhdHModW5z
aWduZWQgaW50IHNpemUsIGdmcF90IGdmcF9leHRyYV9mbGFnDQogCXN0cnVjdCBicGZfcHJvZyAq
ZnA7DQogDQogCXNpemUgPSByb3VuZF91cChzaXplLCBQQUdFX1NJWkUpOw0KLQlmcCA9IF9fdm1h
bGxvYyhzaXplLCBnZnBfZmxhZ3MpOw0KKwlmcCA9IF9fYnBmX3ZtYWxsb2Moc2l6ZSwgZ2ZwX2Zs
YWdzKTsNCiAJaWYgKGZwID09IE5VTEwpDQogCQlyZXR1cm4gTlVMTDsNCiANCkBAIC0yNDYsNyAr
Mjc0LDcgQEAgc3RydWN0IGJwZl9wcm9nICpicGZfcHJvZ19yZWFsbG9jKHN0cnVjdCBicGZfcHJv
ZyAqZnBfb2xkLCB1bnNpZ25lZCBpbnQgc2l6ZSwNCiAJaWYgKHBhZ2VzIDw9IGZwX29sZC0+cGFn
ZXMpDQogCQlyZXR1cm4gZnBfb2xkOw0KIA0KLQlmcCA9IF9fdm1hbGxvYyhzaXplLCBnZnBfZmxh
Z3MpOw0KKwlmcCA9IF9fYnBmX3ZtYWxsb2Moc2l6ZSwgZ2ZwX2ZsYWdzKTsNCiAJaWYgKGZwKSB7
DQogCQltZW1jcHkoZnAsIGZwX29sZCwgZnBfb2xkLT5wYWdlcyAqIFBBR0VfU0laRSk7DQogCQlm
cC0+cGFnZXMgPSBwYWdlczsNCkBAIC0xMzgwLDcgKzE0MDgsNyBAQCBzdGF0aWMgc3RydWN0IGJw
Zl9wcm9nICpicGZfcHJvZ19jbG9uZV9jcmVhdGUoc3RydWN0IGJwZl9wcm9nICpmcF9vdGhlciwN
CiAJZ2ZwX3QgZ2ZwX2ZsYWdzID0gR0ZQX0tFUk5FTCB8IF9fR0ZQX1pFUk8gfCBnZnBfZXh0cmFf
ZmxhZ3M7DQogCXN0cnVjdCBicGZfcHJvZyAqZnA7DQogDQotCWZwID0gX192bWFsbG9jKGZwX290
aGVyLT5wYWdlcyAqIFBBR0VfU0laRSwgZ2ZwX2ZsYWdzKTsNCisJZnAgPSBfX2JwZl92bWFsbG9j
KGZwX290aGVyLT5wYWdlcyAqIFBBR0VfU0laRSwgZ2ZwX2ZsYWdzKTsNCiAJaWYgKGZwICE9IE5V
TEwpIHsNCiAJCS8qIGF1eC0+cHJvZyBzdGlsbCBwb2ludHMgdG8gdGhlIGZwX290aGVyIG9uZSwg
c28NCiAJCSAqIHdoZW4gcHJvbW90aW5nIHRoZSBjbG9uZSB0byB0aGUgcmVhbCBwcm9ncmFtLA0K
QEAgLTE2OTUsNiArMTcyMyw3IEBAIHN0YXRpYyB1NjQgX19fYnBmX3Byb2dfcnVuKHU2NCAqcmVn
cywgY29uc3Qgc3RydWN0IGJwZl9pbnNuICppbnNuKQ0KICNkZWZpbmUgQ09OVF9KTVAgKHsgaW5z
bisrOyBnb3RvIHNlbGVjdF9pbnNuOyB9KQ0KIA0KIHNlbGVjdF9pbnNuOg0KKwlicGZfaW5zbl9j
aGVja19yYW5nZShpbnNuKTsNCiAJZ290byAqanVtcHRhYmxlW2luc24tPmNvZGVdOw0KIA0KIAkv
KiBFeHBsaWNpdGx5IG1hc2sgdGhlIHJlZ2lzdGVyLWJhc2VkIHNoaWZ0IGFtb3VudHMgd2l0aCA2
MyBvciAzMQ0K

