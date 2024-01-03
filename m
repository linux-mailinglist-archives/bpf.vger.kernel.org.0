Return-Path: <bpf+bounces-18869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA25823101
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 17:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 143F71F24EB5
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 16:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4154C1B28E;
	Wed,  3 Jan 2024 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="LImUppuF"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B831B26C
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355088.ppops.net [127.0.0.1])
	by m0355088.ppops.net (8.17.1.24/8.17.1.24) with ESMTP id 403EAwlg031424
	for <bpf@vger.kernel.org>; Wed, 3 Jan 2024 16:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	from:to:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=DKIM202306; bh=wyAB8W
	I/lxvjo0qeZsPX57ypx17T/IBzAvSULqfTKP8=; b=LImUppuFl+5g/EOclAc2iq
	ehQIbkVOSxOJqmQMDUAkMaJSJY3kGpK9ZocnB8cux36/FvRW6xNkrA+Va38IcpfA
	5oVKWfu9SB09jnqwW6ct+FDQTL4NxvS0LF2TnkOLBh5gsSkjf/Nv/bVFGSGD8V+T
	zLY0UcLw5gUhQ2mApMFWsQQkcyQAbhFgIJVBYodDi2boMYawLIdOuOGzTHqVIGWz
	VeTzHqaAQ+cFKSbEPb+eWeJJ0YyfbKTiT8bhnUT/FI2sg8YfaQDispYm0lTDSjxy
	Gu8kMkT/2t1xUPAGn0Bm/KAqeWP/B0DokfPsLYwcVsOgSD92ACliTimDLpa1lIHQ
	==
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2041.outbound.protection.outlook.com [104.47.26.41])
	by m0355088.ppops.net (PPS) with ESMTPS id 3vcp3f2p1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 16:06:36 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXafyhvjFjMOMFfAHtbZKPSl+jScPLvUuXb22qUoD0G2xMlyeFPXF7r0pNVF55fGGyk4t9RzGK7rI9vpX2YB1+ZG+jjSZiQ2f2hR3wR2WVTZn8MvUjAqv45Vn+LhGlYYIA9m8dWNL+87oaMRQcKM6BW3/V1VHcLq0BG6MKaa+AD5TOKWYC1Ss0Jjvs7hK5g9reyimFsxqZvnl3Y9vDQqIn/r/UbXTqGOsKJ3mHu8GjN7BEOQFkYRDYBiPw6iRBsYAOuLptQs6LkLLg6xFM6mdkFbiZwM5MoNRlcIQvSYtwe23vfOA1qLLknl+GymXuQzFUDaku+IX3upo1k0Gfaabg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyAB8WI/lxvjo0qeZsPX57ypx17T/IBzAvSULqfTKP8=;
 b=hlK6MUuhktsxTFXJpVH9qW9Cv4XvD+96dEncIyA6JKKHnXNTaFD/sIAmzaRzBIAl+e3dQk3eljnWeeKnj/jbCN+zRGFtang4VnYAngaCx+GQIwhnGYWKhRYklumCG5qb/WMhjI+ronWVBP9Q0FbE3f36sVp9MNUhiizvyItDEPW8151sFInk2eR7Ab+KfOhvP14GlNVTfuNZO2LW2M2RY5KnN8pBVp9N3IoTNbBtu2Qu33aK6suiz4vdaJrj+ez3r+wF/Zn08qVSPJoF2rcPm1xByn8m5g08w9G8DBiVtuagV+DOgRQKSNakW9rk7yjpcpkqK048cO3GELQzwtzHVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=motorola.com; dmarc=pass action=none header.from=motorola.com;
 dkim=pass header.d=motorola.com; arc=none
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com (2603:1096:101:66::5)
 by JH0PR03MB8052.apcprd03.prod.outlook.com (2603:1096:990:37::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 16:06:33 +0000
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::c0d5:21be:6c82:e5f6]) by SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::c0d5:21be:6c82:e5f6%6]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 16:06:32 +0000
From: Maxwell Bland <mbland@motorola.com>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: FW: BPF-NX+CFI is a good upstreaming candidate
Thread-Topic: FW: BPF-NX+CFI is a good upstreaming candidate
Thread-Index: Ado+XqZ09nd8MMJ1RLW0jnRnc6C+Jg==
Date: Wed, 3 Jan 2024 16:06:32 +0000
Message-ID: 
 <SEZPR03MB6786598744F4D5DE29C46651B4602@SEZPR03MB6786.apcprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6786:EE_|JH0PR03MB8052:EE_
x-ms-office365-filtering-correlation-id: 9645270d-a6a4-475c-767c-08dc0c75f433
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 4HAx2D7k7IvutobRsh5DUi/XSqI5sav6HIsyuXq5KJx4/K3SC3EiCyrUoIYUvhsyv93H2dClkHwhyfMCN7D2lG54gleHEluLFTqeIURIsxbL92FLeHJ5wHVRn9n6S/sQ+I/9veEa8y/umKmpzvnN0fri5CYGlGpvBArnjRpDpnHyWoLIbhHtmZ2G61jyDsUJB20cZHymyoQXV0flr0VEi9pRtIahVlnwzCRYtYlbrgCSshv1IY1ZDL02eBlimtO2kuNYw+PjjFdWwlRaRfPAdI4PUM7Me5FrbgzRsAOKd9XQpvJGx4PVf1GV8yCs1VhptcWaJ2nQfS8K2BJvMPiP+30RvEVB/WzC3YckW072twFSqTu8gb81FzM09dEzcmdLb3F4XdgtTpwOjnbcWitPzJ0ibHIbHziM62GZorZWpxhH42JN6Oja/9HjBHYt75KAnh5ijSxHwmRrGGD4QsJXnGCPEMIN5x+dOQxKT0Py5wjQSJlItepuirwmNf9WRt0K1pRLrNtvJCRml7r8QA6XOoLjm44AVdv4EN5fdF/UQ2L6K0szPAmrxtVXuTCWb9CD8BK1ydJH8jMnGfvdc15P4qn1d8Y8A2zfaESzJMMQuQ2eRK+OZY3CThx/AlAvTr9x4vcpEdee4Zr6cvKGP63nnQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6786.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(396003)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(55016003)(26005)(83380400001)(6506007)(86362001)(38070700009)(38100700002)(82960400001)(33656002)(52536014)(7696005)(5660300002)(71200400001)(9686003)(76116006)(8936002)(8676002)(316002)(66556008)(122000001)(66476007)(66446008)(64756008)(6916009)(478600001)(41300700001)(2906002)(966005)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WDl4c3lBbzFRejNuelhrV0ora0p1cGFVU25pWGkxTS9McFJDMWMrRTNuamxw?=
 =?utf-8?B?ek9Ld1pmUE1zTld5dXZuTWU2a2Mxb1RTalFtbGowV2Qwb1BLdU02bFZwUUpO?=
 =?utf-8?B?SnY3b3ZXKzRITEdQY0taUUV2SmJSOUJDRURrN3lnaDhYRVRjUWkrSmdoRGRx?=
 =?utf-8?B?Tk5vcGg4eUIxQzVJeDRGRWJnUzhVM1kvTm1NclEyYnkxQ09tZ0lIL1NQZzRr?=
 =?utf-8?B?MjVQSld1Sit5WWJFZGxvYk1wZGRZZE0zazdDQVpsUHp4aFpzV2ZRRGpiRXJG?=
 =?utf-8?B?VlczNncreERwKzRVUWR6cE00S0NTdEMxV1M5emRuQmIyajZWTzl3ZkZGMlNP?=
 =?utf-8?B?M1c1Mk41ZzRRZlJicmROeXFFMTRLVGtUUWRTdjNMZ2l5ZVNYYjc3K2xNTnBk?=
 =?utf-8?B?bS9tY2ZhRldhYUNvV3R6WGQxRmJ0SGlPaUthK0ZHQ3hDQnVwcytYOGkvaWw5?=
 =?utf-8?B?QU9HeWcySXBOaW5LYStqd3gwTTl4T1FVRGpWZ3RQVHVrbXVRTFdqSy9vQkdL?=
 =?utf-8?B?U2VRbFVGNUF1NE5DVTZJT042R2Fyb1NqbW9adjZqUmNaQ3RxSEtyajJqdUxp?=
 =?utf-8?B?R0NyTmZJOG91MUtXY2NNYm9ncUpJaE5pWTB0VU9xVlRSa3JGUDVMNDRNWFVZ?=
 =?utf-8?B?anBjOGVzQ3hlaUZ4eDBGZk4wSFcrdjVPdW5ITGhoMDRPd3VkQ2xBT3FpQmRw?=
 =?utf-8?B?cWg0dFdnUmRqMGJZUXp5cUZOQ21KMjViWjIzUEZlOTdoVlZFeEd5V1I5d2hz?=
 =?utf-8?B?OS9jMGhMNmFoRmd2M2I3WGVIdnBIUEZZQU1qZ1M2MVJGT3V3akdWK0xPZzV2?=
 =?utf-8?B?NEg2VkR1RVdyUDZMQU1NWXZmNDhzaEh4N0tSVTBuNmhydHJ4QUZ0enZpUk5h?=
 =?utf-8?B?ZWN1QUlLKytNR2pnLzkzYnA1QkV0cnlMcEhTbVhud1hBb2pyZllFZi91Zzdw?=
 =?utf-8?B?MW80UERLdUZhR2lvazh6TGRWa1NQZ2k3TlJJSUlQZHkzUkl0NExOYXplNXYx?=
 =?utf-8?B?eVZFWEdkZmhaeFNsNllhTWJyWlI1OHh2a0MyemhuaWlTNGRZZmdsdFZoNEdl?=
 =?utf-8?B?TEFHMDJhaEpRbEhQeFRMNkc5Tks0MFVOdDZGQnJaZk5zWFNsU2x3S3NLZm0w?=
 =?utf-8?B?Y0dKelE2T0Vqek5BUDlpRHNNejNjUWtUYlVKNG9RUExRZXU5RHZ2NXZiRFBT?=
 =?utf-8?B?R1d6Ujl4MUlYRmwrdFpGMlFWLzJBYnZMRncrTzBBb1ljTnBtZk1rcG9PTUF0?=
 =?utf-8?B?Y2lqcm9CL0k1c2dlMllneE8zdXZjSVZiL3AwWjZNWE1lWXYwTVVRUzRNY3oy?=
 =?utf-8?B?aWRjckZiZlpWWEZ3N3lLTDhHY3RQeE5UZVBhdC9XRkwzUnlUQmZBMHN4a1Ny?=
 =?utf-8?B?Y2R6RHo0bFdjOXJCN3p6SGttNHVBeDZxQXpPTm5XVjVOM1l0WmNNSGo4QkN1?=
 =?utf-8?B?Vm5vQWZEVDl5dGpwMytIc2JTR2R1YTQxaThXeTlwMVdNcElmV1VabjJjcXBK?=
 =?utf-8?B?eW9Dd3B1OWdVdldlc21UL0VEVkxBRnFCbnFBa0dWeWFoYmdVdFlTSjduQUFJ?=
 =?utf-8?B?aStSa1dXRzl6SFE0bk9ScEdBTUxxdHYvTlRRQXM4ekt6dzRhd2tHZ1BPd1BW?=
 =?utf-8?B?MERLRlRJUlZLYmJTNGNERFJMUjZMNHpDVmgyUFRSTmd5K1JNWFovZHBmNDBt?=
 =?utf-8?B?Rzg0VFZJa1h5NmdsZE1adytySTJsaVRlOFlJZHpwc2N4cXl3c3lnd1R4NDJE?=
 =?utf-8?B?R1R1N0cxeDJiMHd1SUUvMkJXWFd6dXFWNHNLeUVPVTFic2M1V0JGMUtRd3Nt?=
 =?utf-8?B?aGRHNE9EcUdwUnJJalc1emQwV2RjWm84MEllUmFZSks0V1l2ZWh0NUU1MXFP?=
 =?utf-8?B?MW9WY3p4UGg0azNrQXRUaG9tTDBRZllwNlczR0tpMUk1YlkxMzlKYnc2RTJv?=
 =?utf-8?B?Qkd1M2sxWjYyNGFhMGc0ZjRYRDNraUtkaFpVN3Q5RFJBakhxN1o4Qkd4ZGdI?=
 =?utf-8?B?TGx4YWpVdmF0QWVWblJudUxacDVmMHdZZkJMYnFTT04yTm96eGgzVEIwalZX?=
 =?utf-8?B?YWVUbkN0ZG1zQjYzK2t6b2xuMy9qa3BRbWxjNGNjdk9JSHZWb2V5Y20wUldL?=
 =?utf-8?Q?2//Q=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9645270d-a6a4-475c-767c-08dc0c75f433
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 16:06:32.6905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qy19E8gxHcwrvmEQly1e3ISgLwSzlrH8Qf/fWXllOFrAh/yrLavtnuSgFXR0NaBjAmWHtSnX7Vuph6i0zJ1TCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8052
X-Proofpoint-GUID: oh722Vp6rxgwaTqdaTirA5p6k_8nHdou
X-Proofpoint-ORIG-GUID: oh722Vp6rxgwaTqdaTirA5p6k_8nHdou
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=578 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401030131

Rm9yd2FyZGluZyB0byBCUEYgbWFpbGluZyBsaXN0IGFzIHBsYWludGV4dCB0byBtYXRjaCB0aGUg
bWFpbCBzZXJ2ZXIgcmVzdHJpY3Rpb25zLg0KDQpGcm9tIHdoYXQgSSB1bmRlcnN0YW5kLCBMaW51
eCBzZWN1cml0eSB0ZWFtIGlzIHJlYWN0aXZlIHJhdGhlciB0aGFuIHByb2FjdGl2ZSwgc28gbWF5
YmUgdGhlIGJlbG93IGlzIGEgbW9vdCBwb2ludCwgYnV0IEknZCBsb3ZlIHRvIHNlZSBCUEYtTlgr
Q0ZJIGlmIHBvc3NpYmxlLg0KDQpPcmlnaW5hbGx5IHNlbnQgdG8gZGlfamluQGJyb3duLmVkdTsg
di5hdGxpZGFraXNAZ21haWwuY29tOyB2cGtAY3MuYnJvd24uZWR1OyBkYm9ya21hbkBrZXJuZWwu
b3JnOyBsc2YtcGNAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IGJwZkB2Z2VyLmtlcm5lbC5v
cmc7IEFuZHJldyBXaGVlbGVyIDxhd2hlZWxlckBtb3Rvcm9sYS5jb20+OyBTYW1teSBCUzIgUXVl
IHwg6ZiZ5paM55SfIDxxdWViczJAbW90b3JvbGEuY29tPg0KDQpEZWFyIEppbiBldCBhbC4gRGFu
aWVsIEJvcmttYW4sIGFuZCBMU0YvQlBGIG1haWxpbmcgbGlzdHMsDQoNCkFsdGhvdWdoIGEgZmV3
IG1vbnRocyBsYXRlLCBKaW4gZXQgYWwu4oCZcyBVU0VOSVggQVRD4oCZMjMgRVBGIHB1YmxpY2F0
aW9uIGhlcmUgKGh0dHBzOi8vY3MuYnJvd24uZWR1L352cGsvcGFwZXJzL2VwZi5hdGMyMy5wZGYp
IGlzIGdyZWF0LiBJdCB3YXMgYSByZWxpZWYgdG8gc2VlIHRoZSBlZmZvcnRzIGluIGh0dHBzOi8v
Z2l0bGFiLmNvbS9icm93bi1zc2wvZXBmLy0vYmxvYi9tYXN0ZXIvbGludXgtNS4xMC9wYXRjaGVz
LzAwMDMtQWRkaW5nLUJQRi1OWC5wYXRjaD9yZWZfdHlwZT1oZWFkcyBhbmQgcmVsYXRlZCBmaWxl
cy4NCg0KQlBGLU5YK0NGSSB3b3VsZC9jb3VsZC9zaG91bGQgYmUgYSBncmVhdCB1cHN0cmVhbWlu
ZyBjYW5kaWRhdGUuIEkgYW0gbm90IHN1cmUgaG93IHdlbGwgQlBGLU5YK0NGSSBnZW5lcmFsaXpl
cyB0byB0aGUgZnVsbCBrZXJuZWwgZWNvc3lzdGVtIGdpdmVuIHRoZSBhcHByb2FjaCByZXF1aXJl
cyBhIGRlZGljYXRlZCB2bWFsbG9jIG1lbW9yeSByZWdpb24sIGJ1dCB0aGUgaWRlYSBQWE4gaXMg
bm8gbG9uZ2VyIGJlIGVuZm9yY2VkIGF0IGEgUE1ELWxldmVsIGdyYW51bGFyaXR5IGJlY2F1c2Ug
b2YgZUJQRiBpcyB1bmZvcnR1bmF0ZS4NCg0KQlBGLUlTUiBpcyBsaWtlbHkgb3ZlcmtpbGwgcGVy
Zm9ybWFuY2Utd2lzZSBhcyBhIG1lY2hhbmlzbSBhbmQgY2FuIGJlIGhhbmRsZWQvcmVmaW5lZCB2
aWEga3Byb2JlcyByYXRoZXIgdGhhbiBkaXJlY3QgcGF0Y2hlcy4NCg0KSmluIGV0IGFsLiwgZG8g
eW91IGhhcHBlbiB0byBoYXZlIHBlcmZvcm1hbmNlIG51bWJlcnMgZm9yIGp1c3QgTlgrQ0ZJLCBv
ciBrbm93bGVkZ2Ugb2YgaG93IHdlbGwgdGhpcyBtYXkgYXBwbHkgdG8gNi4qKyBrZXJuZWxzPyBX
aXRoIHlvdXIgYmxlc3NpbmcsIGFuZCBpZiB0aGUgbWFpbGluZyBsaXN0IHBlZXJzIGFyZSBzdXBw
b3J0aXZlLCB3ZSBzaG91bGQgZGlzY3VzcyB5b3VyIHdvcmsgYW5kIEJQRiBzZWN1cml0eSBhdCBo
dHRwczovL2V2ZW50cy5saW51eGZvdW5kYXRpb24ub3JnL2xzZm1tYnBmL3Byb2dyYW0vY2ZwLy4N
Cg0KTWF4d2VsbCBCbGFuZA0KTW90b3JvbGENCg==

