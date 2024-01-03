Return-Path: <bpf+bounces-18922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 097E5823754
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 22:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21BBA1C241C8
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 21:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E4D1DA29;
	Wed,  3 Jan 2024 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="5+Pqed04"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3341DA23
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 21:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355091.ppops.net [127.0.0.1])
	by mx0b-00823401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 403C8S2K026707;
	Wed, 3 Jan 2024 18:56:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	from:to:cc:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=DKIM202306; bh=vqzjzW
	jZu9rO3aGKW/yPR1jTOaAjWmgnnc3WiG+zlHU=; b=5+Pqed04wX5LqCDmV08h9U
	COTbGk3JuS2xolqMjKO6xT5Cd2ckAU8IGCCoZpwgKTA5rmj1wJat+p/jESUcUz1d
	cvWNG56dNf8eoCku0PtafUZWNj5ToEKZzG3Ip37QLwTG4MISbXnOf80wTXOxKjnJ
	6puATOUUSxKcfK34NSeSb9vnRuCbgX7pfsja7HZRf9YvvZIdmrWRuKFHw9g1oStR
	edyH2sWXodXUNmzvhuqeEUBwXPpULa/4Yk+tORTk6vlp87W7x5bNi/7H3uYfkvxx
	JtvZYeAiM2w5ITTNMp2H6dlWhT06KRigDrzNg25Wjagtj7h++uNwnlxNXuaQ0xag
	==
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2040.outbound.protection.outlook.com [104.47.26.40])
	by mx0b-00823401.pphosted.com (PPS) with ESMTPS id 3vd7aw0nc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 18:56:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtVEsTMjXLVPvrq5qZ6FGMEczOCgKFX3dLO7pbXP/BOp7WT5Y3B+R+cbYp70mxRug3HAOoGMMwZ2gz7Bs12q4F1yfINmXkE91OVBr+Y3BkDlFwH2vYfmgq+uXu6YmBw4XPTfGzyREd1jzLC08aGmwYo/mtfZPU/AFJZ1aPPBcD4OvVC4tJat7AYqDc49xkIugV0jpe28WEsS3fVGLmcBKvCIU3WfeBNKq6KHEzsyXQvpVzSZmU10AD/bXeQUa2lr7KHIC7RZVFsfE7sJtQms3asHiUTfyuKrUZv71gXKYxFO6WBeIV9kUhWrjK99KVtDGJesXmHDOguuvOr7VKcXkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqzjzWjZu9rO3aGKW/yPR1jTOaAjWmgnnc3WiG+zlHU=;
 b=SkfXegjURMAV42f5H1NkRLzfPZrmlQcvF5h9J+UyQmOvgvtnwPzTVA8PMJU3XJTp8AahwWO2CW+Qf7bBHWEHNsab6K9PEsJpueykjGe+NLOF820cA9+pS8+oa86F/UAeIpOMYZdjeiOIMe2iUr3svEyxP5Q9BR3z4enap/CYVpyX5aPgmoSdbqXH5LcdO5oo24mRtvBPBFeXCJJB7lXNQhS6AUxdPjC8hplbNovY/hL0GkFf85uxWlED2qmK+iGSWxb+JGPvY8AhGFYM5e40q8POeIvAn4g0+vHD9fqQyCz1YuPhdztfV9SYU8goaYpKmJl7uOVwzsvHh2qIey0BLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=motorola.com; dmarc=pass action=none header.from=motorola.com;
 dkim=pass header.d=motorola.com; arc=none
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com (2603:1096:101:66::5)
 by KL1PR0302MB5412.apcprd03.prod.outlook.com (2603:1096:820:36::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 18:56:01 +0000
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::c0d5:21be:6c82:e5f6]) by SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::c0d5:21be:6c82:e5f6%6]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 18:56:01 +0000
From: Maxwell Bland <mbland@motorola.com>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC: Andrew Wheeler <awheeler@motorola.com>,
        =?utf-8?B?U2FtbXkgQlMyIFF1ZSB8IOmYmeaWjOeUnw==?= <quebs2@motorola.com>,
        "di_jin@brown.edu" <di_jin@brown.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        "vpk@cs.brown.edu" <vpk@cs.brown.edu>,
        "v.atlidakis@gmail.com"
	<v.atlidakis@gmail.com>
Subject: [PATCH 1/2] Adding BPF NX
Thread-Topic: [PATCH 1/2] Adding BPF NX
Thread-Index: Ado+dbT9jfWatuBPQB+UpA/3vxssOw==
Date: Wed, 3 Jan 2024 18:56:00 +0000
Message-ID: 
 <SEZPR03MB6786385FE7630DC906EB0BFAB4602@SEZPR03MB6786.apcprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6786:EE_|KL1PR0302MB5412:EE_
x-ms-office365-filtering-correlation-id: add1d9ea-78bf-4132-0ea1-08dc0c8da0f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 S/6JiQdqqFD6ryfRZuKgrkKVTqtnWlhHaGs+7VBRwzFj+Ok2wMh8W8n5mH23z0DVc/nT/V0KdOdjyLaELOAmulnlrFx02T4k34X5+aEPPdc6Db6eXfHqywP0H7MzKy6jcuaQDwygZdgHmVwb/euUvgNl3q3exExLQ2Fa3yMK3v6oXNFZO6BYb6f12CJsqS4EHARd6PZa+1gSIbc2Q/9VRJMyv6tY08Z42P3dazyWwC5+ZGB9jgK/bvYHTMHTzTUcuB1PHZfPxWp9Gluia4RF3lBzB6+zMv4/M1aA86XF0bLV0Pl3jREnpVFHxnwg0OXXEJuFkfhMZuH+FOeJTOkFS0d+6SPaiJk2BCH9jAV0NWtHrC+k0AdDJwPFJzLwtaKS3y/J6B4nHk7vYX6bYxHQqqyVYesS6y5bVv0eA47E43rH1BY1VdRclf94mZr5ihMK14K8Y4T7Uju+uSx+6Egx/rINGXyuYiBHqwaiFOS6HQRxzQ5f+Wu9gQBgV350N+Dof6JKAlgQeuZd5hU1d7eLgoPyrr0BtAVIrtVOK3uHlveZxLQUyl0uP9Lhcebvvww5G2WZQGt9Us2iin4s1n3JHbPcsaXb8zyCpU1BdJbDp9UA0NEz26rJS1Coa7O6iChmkP1f3VexPSEHyLam/VeZcZSwYdXxf1fUBae7MECAnno=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6786.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(376002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(2906002)(52536014)(8936002)(4326008)(8676002)(5660300002)(54906003)(316002)(66446008)(66946007)(38070700009)(66476007)(64756008)(66556008)(76116006)(6916009)(82960400001)(86362001)(122000001)(38100700002)(26005)(9686003)(6506007)(478600001)(71200400001)(7696005)(33656002)(83380400001)(41300700001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?QXExOWY1OFdLUnc5NHkwSUdIQnIxS0pMM3B3Mm4wTDVZRElEOU92dFVJcEFi?=
 =?utf-8?B?eHV4c3M0R0t4UkRlUjJkdXFpbGcwYXI1Qm5vZi9ZYU5acjVXRjJaYnh6blZC?=
 =?utf-8?B?enI4ZktXOVk2RHdjSzlBN1N2VWFnNWJaU0dPZ1QxQXdwc0tkOUxtQm52eW5S?=
 =?utf-8?B?WVZTZFpJdkx3VUkxL0tFSW15SEtHb09KbXlzRU5TblBqM3VEK3NrR3I1c2Zu?=
 =?utf-8?B?OXBWVTNQVDdlSDVuT3RabWdnS01NMFBSLzcyUXRHcDJqQkJCa2VrQkZKbC9z?=
 =?utf-8?B?ZkIwYWZUZnRSUlVYc2pjelRzY3ZrbWMrSW40bGJ4ampOTzVuUzJBK3gxQ3ph?=
 =?utf-8?B?ek5TMysrdVdQbXJ6OUZ1ZmxkUm5HQ3RmUWdSYlpzbFdqaERERWJkdW42ZDgv?=
 =?utf-8?B?aU5RVStUQmx6ZUs3eHdJYTUzMWZ6T29zbExDR2tDRjM3UFlhVDhUUS9iRXhj?=
 =?utf-8?B?a0tjMG41dGxKaklZVkVrUE8rRy9zK2hIRi9uQzdxcmZWblpoU01vYnBOdVAw?=
 =?utf-8?B?WXIyVlJsZUk5SWd1OXFtY3E0OUJNVlJpbHZreTlJViswRVdRbkJuZ3FYNUla?=
 =?utf-8?B?S2FoblRTcmZvZmR4TGpLeWtiV0hWcWt5NTVBNXpjS3c1dWg3OStNUVQ0cXJx?=
 =?utf-8?B?L2tURmowWFptN2s4MC9mUlVlWnowWFRnbCtXc295RGRUTTU5c0RMc0dKdVFG?=
 =?utf-8?B?REl6eGFsRW1GUldaQjgwNzRPV29RVGVuNVZUT1NVTTJ3eDI4NVVwK0JnUVBI?=
 =?utf-8?B?SDByemVkY0VlenAwQ0tYLzFnakNYa1NGSWdFR3Frd255bkR3YitYN0xrenNW?=
 =?utf-8?B?clcxNC9lMUhFR29Ra2pHL3RFNXhWdEhudk5DV2s5MmY1VEFsVFlmOURRNVpW?=
 =?utf-8?B?WDM4VWVqcWkyVG1HQzBUc1B5SGpLYUFuOGpLcVZsSkpSdklYTEoxL1FTMXcx?=
 =?utf-8?B?dnF3c1krUU5kTlhaQ2J0SGRnRCtIS3hnTko3eE95QUM0N2FxT3YrQW8vMzUx?=
 =?utf-8?B?QkI1QXlmdmpiZERjc1VLYzFHM0tTc252Y3JRY1M4N08yUFFMNU1VL2ZxMVJk?=
 =?utf-8?B?djRjNmZnbkV0MFdaWjdiTEFvVzZaSmthUzN1b1U2clBqaGo3emdxUG9tVEpU?=
 =?utf-8?B?dUZkUTVNLzduSFVxQWtGMjFiTTRLT0xPMGpRNkFFK3VTZGNXMmVHaGN6YW9H?=
 =?utf-8?B?dGpCZkp3VFVjZVJPcE1NN3pTVHh5OVEzQUtFOUY5MmdobXFxUFBjSzh3L3kz?=
 =?utf-8?B?R3oxK25qQlNycDh6NDYwRGZEN0Y4U3NFZ1Q3cVp5Qk13REpmUmJUTFpFUkI1?=
 =?utf-8?B?S25FZlA3Z0x4SGdna0VHUSs0SXh0OG85aVRMYndtN0hzc3hwaTF0NzVrSXNr?=
 =?utf-8?B?WlRIaFIxY0NlZlY1d2dROUN6WlMrUGRBR2ZJRkdMOEd5L2VTL1VjVFVWT1dI?=
 =?utf-8?B?U1lndEQvVEZWUmtUZ0dBS2hKb2tjT1dKSjZ4V3Z2MHBvSWRORGI4ZGM4bWNr?=
 =?utf-8?B?Sk91ZnhtbzVEd0w2bm9MU1dJdE1ZZ0lHaFZ3NGcxUTczdDNJbXlPSU5Rb2ZC?=
 =?utf-8?B?d1FkZ0dxWlozaVlEUUV5V0hsYWE4ZTUyckt5SzZ0OG9WcDU2aE81SWtmZklu?=
 =?utf-8?B?dzFWTDF0MnZRODJ5QkVLOWFJVGN1b2YvM1AzRnc5cTJFcDJzaDFSRWNiaElM?=
 =?utf-8?B?YzF1eU5JWVdHblgzNi9qT2FqR2JEYnEwZ1MwUE9FU2MwVXBmSzFUV1loQk1T?=
 =?utf-8?B?cHFVNkd1bWU0VjJHclBLQkdsNGg3NkJ2Uk5IbENHZlJ4OE4rSmlKclBXclF2?=
 =?utf-8?B?RzFWbHZUbjNUNDlGL3QxY3J5M1prQitUUFVCeGQyaW4wb0Z0UEs4ZE1saHYw?=
 =?utf-8?B?dmxOS2VEMzArcFBrNG1rNGZRT2xnTEJqWTRrdE5jRDdzU0NJamhuR2FsYi9R?=
 =?utf-8?B?OWhsZTZzakNqblduVkxKU0RzTFNjNlZkTy9PZnh6bjZKdEtiUGgxQ3RtS0xs?=
 =?utf-8?B?TVFId2lyT2s2YmFyL3B4OVc0cHM5T01TcjJkVktnM3lqcFlaREhMUDZURkpZ?=
 =?utf-8?B?eUMvNVl2OE8xVVZ3cnRvem9SWTJWUVpHNUJyeXV0OXAvWEVyQjdPQ1JhcFhr?=
 =?utf-8?Q?Brrg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: add1d9ea-78bf-4132-0ea1-08dc0c8da0f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 18:56:00.9838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LpH51uYDIVrgjwxS82hpx1UEj7gvhCINM1RrXosEGmJ6DI5tpqLsv6RvfgZWBUTNm3hKWJiDzgfT1jlqk39KWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5412
X-Proofpoint-ORIG-GUID: AudrD0C79z3WOBLsxPdQZlu90KqBwBtT
X-Proofpoint-GUID: AudrD0C79z3WOBLsxPdQZlu90KqBwBtT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 mlxlogscore=896 spamscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401030153

RnJvbTogVGVudXQgPHRlbnV0QE5pb2JpdW0+DQpTdWJqZWN0OiBbUEFUQ0ggMS8yXSBBZGRpbmcg
QlBGIE5YDQoNClJlc2VydmUgYSBtZW1vcnkgcmVnaW9uIGZvciBCUEYgcHJvZ3JhbSwgYW5kIGNo
ZWNrIGZvciBpdCBpbiB0aGUgaW50ZXJwcmV0ZXIuIFRoaXMgc2ltdWxhdGUgdGhlIGVmZmVjdA0K
b2Ygbm9uLWV4ZWN1dGFibGUgbWVtb3J5IGZvciBCUEYgZXhlY3V0aW9uLg0KDQpTaWduZWQtb2Zm
LWJ5OiBNYXh3ZWxsIEJsYW5kIDxtYmxhbmRAbW90b3JvbGEuY29tPg0KLS0tDQphcmNoL3g4Ni9p
bmNsdWRlL2FzbS9wZ3RhYmxlXzY0X3R5cGVzLmggfCAgOSArKysrKysrKysNCiBhcmNoL3g4Ni9t
bS9mYXVsdC5jICAgICAgICAgICAgICAgICAgICAgfCAgNiArKysrKy0NCiBrZXJuZWwvYnBmL0tj
b25maWcgICAgICAgICAgICAgICAgICAgICAgfCAxNiArKysrKysrKysrKysrKysNCiBrZXJuZWwv
YnBmL2NvcmUuYyAgICAgICAgICAgICAgICAgICAgICAgfCAzNSArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKystLS0NCiA0IGZpbGVzIGNoYW5nZWQsIDYyIGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZ3RhYmxlXzY0
X3R5cGVzLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZ3RhYmxlXzY0X3R5cGVzLmgNCmluZGV4
IDM4YjU0Yjk5MmYzMi4uYWQxMTY1MWViMDczIDEwMDY0NA0KLS0tIGEvYXJjaC94ODYvaW5jbHVk
ZS9hc20vcGd0YWJsZV82NF90eXBlcy5oDQorKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZ3Rh
YmxlXzY0X3R5cGVzLmgNCkBAIC0xMjMsNiArMTIzLDkgQEAgZXh0ZXJuIHVuc2lnbmVkIGludCBw
dHJzX3Blcl9wNGQ7DQogDQogI2RlZmluZSBfX1ZNQUxMT0NfQkFTRV9MNAkweGZmZmZjOTAwMDAw
MDAwMDBVTA0KICNkZWZpbmUgX19WTUFMTE9DX0JBU0VfTDUgCTB4ZmZhMDAwMDAwMDAwMDAwMFVM
DQorI2lmZGVmIENPTkZJR19CUEZfTlgNCisjZGVmaW5lIF9fQlBGX1ZCQVNFCQkweGZmZmZlYjAw
MDAwMDAwMDBVTA0KKyNlbmRpZg0KIA0KICNkZWZpbmUgVk1BTExPQ19TSVpFX1RCX0w0CTMyVUwN
CiAjZGVmaW5lIFZNQUxMT0NfU0laRV9UQl9MNQkxMjgwMFVMDQpAQCAtMTY5LDYgKzE3MiwxMiBA
QCBleHRlcm4gdW5zaWduZWQgaW50IHB0cnNfcGVyX3A0ZDsNCiAjZGVmaW5lIFZNQUxMT0NfUVVB
UlRFUl9TSVpFCSgoVk1BTExPQ19TSVpFX1RCIDw8IDQwKSA+PiAyKQ0KICNkZWZpbmUgVk1BTExP
Q19FTkQJCShWTUFMTE9DX1NUQVJUICsgVk1BTExPQ19RVUFSVEVSX1NJWkUgLSAxKQ0KIA0KKyNp
ZmRlZiBDT05GSUdfQlBGX05YDQorI2RlZmluZSBCUEZfU0laRV9HQgkJNTEyVUwNCisjZGVmaW5l
IEJQRl9WU1RBUlQJCV9fQlBGX1ZCQVNFDQorI2RlZmluZSBCUEZfVkVORAkJKEJQRl9WU1RBUlQg
KyBfQUMoQlBGX1NJWkVfR0IgPDwgMzAsIFVMKSkNCisjZW5kaWYgLyogQ09ORklHX0JQRl9OWCAq
Lw0KKw0KIC8qDQogICogdm1hbGxvYyBtZXRhZGF0YSBhZGRyZXNzZXMgYXJlIGNhbGN1bGF0ZWQg
YnkgYWRkaW5nIHNoYWRvdy9vcmlnaW4gb2Zmc2V0cw0KICAqIHRvIHZtYWxsb2MgYWRkcmVzcy4N
CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9tbS9mYXVsdC5jIGIvYXJjaC94ODYvbW0vZmF1bHQuYw0K
aW5kZXggYWI3NzhlYWMxOTUyLi5jZmI2M2VmNzIxNjggMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9t
bS9mYXVsdC5jDQorKysgYi9hcmNoL3g4Ni9tbS9mYXVsdC5jDQpAQCAtMjM1LDcgKzIzNSwxMSBA
QCBzdGF0aWMgbm9pbmxpbmUgaW50IHZtYWxsb2NfZmF1bHQodW5zaWduZWQgbG9uZyBhZGRyZXNz
KQ0KIAlwdGVfdCAqcHRlX2s7DQogDQogCS8qIE1ha2Ugc3VyZSB3ZSBhcmUgaW4gdm1hbGxvYyBh
cmVhOiAqLw0KLQlpZiAoIShhZGRyZXNzID49IFZNQUxMT0NfU1RBUlQgJiYgYWRkcmVzcyA8IFZN
QUxMT0NfRU5EKSkNCisJaWYgKCEoYWRkcmVzcyA+PSBWTUFMTE9DX1NUQVJUICYmIGFkZHJlc3Mg
PCBWTUFMTE9DX0VORCkNCisjaWZkZWYgQlBGX05YDQorCQkmJiAhKGFkZHJlc3MgPj0gQlBGX1ZT
VEFSVCAmJiBhZGRyZXNzIDwgQlBGX1ZFTkQpDQorI2VuZGlmDQorCSkNCiAJCXJldHVybiAtMTsN
CiANCiAJLyoNCmRpZmYgLS1naXQgYS9rZXJuZWwvYnBmL0tjb25maWcgYi9rZXJuZWwvYnBmL0tj
b25maWcNCmluZGV4IDZhOTA2ZmY5MzAwNi4uNzE2MGRjYWFhNThhIDEwMDY0NA0KLS0tIGEva2Vy
bmVsL2JwZi9LY29uZmlnDQorKysgYi9rZXJuZWwvYnBmL0tjb25maWcNCkBAIC04Niw2ICs4Niwy
MiBAQCBjb25maWcgQlBGX1VOUFJJVl9ERUZBVUxUX09GRg0KIA0KIAkgIElmIHlvdSBhcmUgdW5z
dXJlIGhvdyB0byBhbnN3ZXIgdGhpcyBxdWVzdGlvbiwgYW5zd2VyIFkuDQogDQorY29uZmlnIEJQ
Rl9IQVJERU5JTkcNCisJYm9vbCAiRW5hYmxlIEJQRiBpbnRlcnByZXRlciBoYXJkZW5pbmciDQor
CXNlbGVjdCBCUEYNCisJZGVwZW5kcyBvbiBYODZfNjQgJiYgIVJBTkRPTUlaRV9NRU1PUlkgJiYg
IUJQRl9KSVRfQUxXQVlTX09ODQorCWRlZmF1bHQgbg0KKwloZWxwDQorCSAgRW5oYW5jZSBicGYg
aW50ZXJwcmV0ZXIncyBzZWN1cml0eQ0KKw0KK2NvbmZpZyBCUEZfTlgNCitib29sICJFbmFibGUg
YnBmIE5YIg0KKwlkZXBlbmRzIG9uIEJQRl9IQVJERU5JTkcgJiYgIURZTkFNSUNfTUVNT1JZX0xB
WU9VVA0KKwlkZWZhdWx0IG4NCisJaGVscA0KKwkgIEFsbG9jYXRlIGVCUEYgcHJvZ3JhbXMgaW4g
c2VwZXJhdGUgYXJlYSBhbmQgbWFrZSBzdXJlIHRoZQ0KKwkgIGludGVycHJldGVkIHByb2dyYW1z
IGFyZSBpbiB0aGUgcmVnaW9uLg0KKw0KIHNvdXJjZSAia2VybmVsL2JwZi9wcmVsb2FkL0tjb25m
aWciDQogDQogY29uZmlnIEJQRl9MU00NCmRpZmYgLS1naXQgYS9rZXJuZWwvYnBmL2NvcmUuYyBi
L2tlcm5lbC9icGYvY29yZS5jDQppbmRleCBmZTI1NGFlMDM1ZmUuLjU2ZDllOGQ0YTZkZSAxMDA2
NDQNCi0tLSBhL2tlcm5lbC9icGYvY29yZS5jDQorKysgYi9rZXJuZWwvYnBmL2NvcmUuYw0KQEAg
LTg4LDYgKzg4LDM0IEBAIHZvaWQgKmJwZl9pbnRlcm5hbF9sb2FkX3BvaW50ZXJfbmVnX2hlbHBl
cihjb25zdCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBpbnQgaywgdW5zDQogCXJldHVybiBOVUxMOw0K
IH0NCiANCisjaWZkZWYgQ09ORklHX0JQRl9OWA0KKyNkZWZpbmUgQlBGX01FTU9SWV9BTElHTiBy
b3VuZHVwX3Bvd19vZl90d28oc2l6ZW9mKHN0cnVjdCBicGZfcHJvZykgKyBcDQorCQlCUEZfTUFY
SU5TTlMgKiBzaXplb2Yoc3RydWN0IGJwZl9pbnNuKSkNCitzdGF0aWMgdm9pZCAqX19icGZfdm1h
bGxvYyh1bnNpZ25lZCBsb25nIHNpemUsIGdmcF90IGdmcF9tYXNrKQ0KK3sNCisJcmV0dXJuIF9f
dm1hbGxvY19ub2RlX3JhbmdlKHNpemUsIEJQRl9NRU1PUllfQUxJR04sIEJQRl9WU1RBUlQsIEJQ
Rl9WRU5ELA0KKwkJCWdmcF9tYXNrLCBQQUdFX0tFUk5FTCwgMCwgTlVNQV9OT19OT0RFLA0KKwkJ
CV9fYnVpbHRpbl9yZXR1cm5fYWRkcmVzcygwKSk7DQorfQ0KKw0KK3N0YXRpYyB2b2lkIGJwZl9p
bnNuX2NoZWNrX3JhbmdlKGNvbnN0IHN0cnVjdCBicGZfaW5zbiAqaW5zbikNCit7DQorCWlmICgo
dW5zaWduZWQgbG9uZylpbnNuIDwgQlBGX1ZTVEFSVA0KKwkJCXx8ICh1bnNpZ25lZCBsb25nKWlu
c24gPj0gQlBGX1ZFTkQgLSBzaXplb2Yoc3RydWN0IGJwZl9pbnNuKSkNCisJCUJVRygpOw0KK30N
CisNCisjZWxzZQ0KK3N0YXRpYyB2b2lkICpfX2JwZl92bWFsbG9jKHVuc2lnbmVkIGxvbmcgc2l6
ZSwgZ2ZwX3QgZ2ZwX21hc2spDQorew0KKwlyZXR1cm4gX192bWFsbG9jKHNpemUsIGdmcF9tYXNr
KTsNCit9DQorDQorc3RhdGljIHZvaWQgYnBmX2luc25fY2hlY2tfcmFuZ2UoY29uc3Qgc3RydWN0
IGJwZl9pbnNuICppbnNuKQ0KK3sNCit9DQorI2VuZGlmIC8qIENPTkZJR19CUEZfTlggKi8NCisN
CiBzdHJ1Y3QgYnBmX3Byb2cgKmJwZl9wcm9nX2FsbG9jX25vX3N0YXRzKHVuc2lnbmVkIGludCBz
aXplLCBnZnBfdCBnZnBfZXh0cmFfZmxhZ3MpDQogew0KIAlnZnBfdCBnZnBfZmxhZ3MgPSBicGZf
bWVtY2dfZmxhZ3MoR0ZQX0tFUk5FTCB8IF9fR0ZQX1pFUk8gfCBnZnBfZXh0cmFfZmxhZ3MpOw0K
QEAgLTk1LDcgKzEyMyw3IEBAIHN0cnVjdCBicGZfcHJvZyAqYnBmX3Byb2dfYWxsb2Nfbm9fc3Rh
dHModW5zaWduZWQgaW50IHNpemUsIGdmcF90IGdmcF9leHRyYV9mbGFnDQogCXN0cnVjdCBicGZf
cHJvZyAqZnA7DQogDQogCXNpemUgPSByb3VuZF91cChzaXplLCBQQUdFX1NJWkUpOw0KLQlmcCA9
IF9fdm1hbGxvYyhzaXplLCBnZnBfZmxhZ3MpOw0KKwlmcCA9IF9fYnBmX3ZtYWxsb2Moc2l6ZSwg
Z2ZwX2ZsYWdzKTsNCiAJaWYgKGZwID09IE5VTEwpDQogCQlyZXR1cm4gTlVMTDsNCiANCkBAIC0y
NDYsNyArMjc0LDcgQEAgc3RydWN0IGJwZl9wcm9nICpicGZfcHJvZ19yZWFsbG9jKHN0cnVjdCBi
cGZfcHJvZyAqZnBfb2xkLCB1bnNpZ25lZCBpbnQgc2l6ZSwNCiAJaWYgKHBhZ2VzIDw9IGZwX29s
ZC0+cGFnZXMpDQogCQlyZXR1cm4gZnBfb2xkOw0KIA0KLQlmcCA9IF9fdm1hbGxvYyhzaXplLCBn
ZnBfZmxhZ3MpOw0KKwlmcCA9IF9fYnBmX3ZtYWxsb2Moc2l6ZSwgZ2ZwX2ZsYWdzKTsNCiAJaWYg
KGZwKSB7DQogCQltZW1jcHkoZnAsIGZwX29sZCwgZnBfb2xkLT5wYWdlcyAqIFBBR0VfU0laRSk7
DQogCQlmcC0+cGFnZXMgPSBwYWdlczsNCkBAIC0xMzgwLDcgKzE0MDgsNyBAQCBzdGF0aWMgc3Ry
dWN0IGJwZl9wcm9nICpicGZfcHJvZ19jbG9uZV9jcmVhdGUoc3RydWN0IGJwZl9wcm9nICpmcF9v
dGhlciwNCiAJZ2ZwX3QgZ2ZwX2ZsYWdzID0gR0ZQX0tFUk5FTCB8IF9fR0ZQX1pFUk8gfCBnZnBf
ZXh0cmFfZmxhZ3M7DQogCXN0cnVjdCBicGZfcHJvZyAqZnA7DQogDQotCWZwID0gX192bWFsbG9j
KGZwX290aGVyLT5wYWdlcyAqIFBBR0VfU0laRSwgZ2ZwX2ZsYWdzKTsNCisJZnAgPSBfX2JwZl92
bWFsbG9jKGZwX290aGVyLT5wYWdlcyAqIFBBR0VfU0laRSwgZ2ZwX2ZsYWdzKTsNCiAJaWYgKGZw
ICE9IE5VTEwpIHsNCiAJCS8qIGF1eC0+cHJvZyBzdGlsbCBwb2ludHMgdG8gdGhlIGZwX290aGVy
IG9uZSwgc28NCiAJCSAqIHdoZW4gcHJvbW90aW5nIHRoZSBjbG9uZSB0byB0aGUgcmVhbCBwcm9n
cmFtLA0KQEAgLTE2OTUsNiArMTcyMyw3IEBAIHN0YXRpYyB1NjQgX19fYnBmX3Byb2dfcnVuKHU2
NCAqcmVncywgY29uc3Qgc3RydWN0IGJwZl9pbnNuICppbnNuKQ0KICNkZWZpbmUgQ09OVF9KTVAg
KHsgaW5zbisrOyBnb3RvIHNlbGVjdF9pbnNuOyB9KQ0KIA0KIHNlbGVjdF9pbnNuOg0KKwlicGZf
aW5zbl9jaGVja19yYW5nZShpbnNuKTsNCiAJZ290byAqanVtcHRhYmxlW2luc24tPmNvZGVdOw0K
IA0KIAkvKiBFeHBsaWNpdGx5IG1hc2sgdGhlIHJlZ2lzdGVyLWJhc2VkIHNoaWZ0IGFtb3VudHMg
d2l0aCA2MyBvciAzMQ0K

