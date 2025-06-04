Return-Path: <bpf+bounces-59638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD598ACE0B4
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 16:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 023DC7AB3C7
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 14:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20A9290DB3;
	Wed,  4 Jun 2025 14:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="OpPCoiu4"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961E232C85
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749048469; cv=none; b=gD8LhZmc7BfifaYvDEWBXyqvQY/acNFTZpb5d3lLfi1ThdsPpjiJZE2VmPDYKAJzwTxdnTPvS/xP8viz3w9Bgxc0yxB9dYbURLWsox8Gs96nh2V2j5lX3EIEL27QWirz5vrFcePD+I9VmbB1IlKKcdSX3SQrhhk+0QkJVD/kEh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749048469; c=relaxed/simple;
	bh=3DRdGW+/6kLxN4oMOJIy0AzJCewnF9NtkHA36sExoBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=avqqmBVY1p7S5NCtwNIIV7HRGzffv6ICKaA/WFjl5IWO1DEjqkiSj2n3OBLn63s1IMO/qTT9GsdyyNomnCpVLYf9rNo53KOq8nWjOgCU3svMgzF/ciL7tEmyKK1ZaQAjN2h6up0lBJzf/s5CAyE+nkwZe0u3gcHk/IT1teVlIwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=OpPCoiu4; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554CqIGH013442;
	Wed, 4 Jun 2025 14:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=3DRdGW+/6kLxN4oMOJIy0AzJCewnF9NtkHA36sExoBg=; b=OpPC
	oiu4pkvHX3MyNyMfKF+QVdh2wJMEkb3cq14RcuCoOcrCCz76up74Np2Vh7lXfeOl
	JnZ42e84yJI9ZqOHyDdt066UK5N6GluxmfsCoKpaO/IQ2GGci4H+utt2XzL8hcRy
	MqnKge9yo7bhHdO9q5idwJhT1KRYYxaAwXJH/joU0Bn+rMCeFQ9bwiwj7LNvuaue
	SP2DnYH1C9VxjXDg6oEDtqs3JDTMZMZ6sAabcKL31gyATKtVS8hIlixw2gYhfaSL
	MswD8NW0xEMT4/WdD5agvRgbed2heRW3qgw9/LoPnG2spi4ZUsfM3G18k/LIS4oG
	CFRIlVFPGbVen9JxhA==
Received: from mail.crowdstrike.com (74-209-223-77.static.ash01.latisys.net [74.209.223.77] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 472phc0fxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 14:47:41 +0000 (GMT)
Received: from [10.82.59.34] (10.100.11.122) by 03WPEXCH010.crowdstrike.sys
 (10.80.52.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Jun 2025
 14:47:38 +0000
Message-ID: <7831ec6d-8d5c-4fc1-9bd9-1b0dfc93eb16@crowdstrike.com>
Date: Wed, 4 Jun 2025 10:47:36 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: Bad vmalloc address during BPF hooks unload
To: Jiri Olsa <olsajiri@gmail.com>
CC: <bpf@vger.kernel.org>, <joe.kimpel@crowdstrike.com>,
        Mark Fontana
	<mark.fontana@crowdstrike.com>,
        Viktor Malik <vmalik@redhat.com>
References: <6947880c-a749-438f-bfcb-91afe7238d7e@crowdstrike.com>
 <aD9vDX0boYLzvibc@krava>
Content-Language: en-US
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
In-Reply-To: <aD9vDX0boYLzvibc@krava>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: base64
X-ClientProxiedBy: 04WPEXCH005.crowdstrike.sys (10.100.11.69) To
 03WPEXCH010.crowdstrike.sys (10.80.52.162)
X-Disclaimer: USA
X-Proofpoint-GUID: P1i1oia_R4R3JEGPAOW7ROl-Y_o5YJ47
X-Proofpoint-ORIG-GUID: P1i1oia_R4R3JEGPAOW7ROl-Y_o5YJ47
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDExMCBTYWx0ZWRfXzmC4c0F1rfnj
 5IoYadNPD7lRjCMVihYJ54+CPtyDhHftxzOQptMQA2qXTPJj0LzziJG7tSofN43eoNcMV+H128G
 wXa5Z4KzqRxTFNKs4z3tbjrZ3Rf+6I2PvnLUYIlHaMF8T4C1oGA2gabQl/V1xgiPjaqWfNtFQAP
 WvCeNrl6zQQlqW0/FZIwiUqBFFuxYl1/5gXkDHm48lDp7EsRHnzywVqCTkyqvX/suxhE4KwRoT7
 UOf46FU81J7Rx1MkJkshBDNmhjicoq8f+YZJ7y0gq8XHQV5C82B/KDBsqDqH9t2YtZWB2GQomkm
 8d9qQTqIHWy21v2WnOLAG+h6Rk+FqlV5xYZGJ13KNpV77i1PA8cn59wE5EBAEXcLUGBSQufyyjl
 OBU8eunT/N93otpR+fuID1OpnrOvE7T2M61hBCX12ps4tP89lyh7GTtfOgTK1Yw6Q3H4MXdZ
X-Authority-Analysis: v=2.4 cv=Jae8rVKV c=1 sm=1 tr=0 ts=68405c8d cx=c_pps
 a=gZx6DIAxr9wtOoIAvRqG0Q==:117 a=gZx6DIAxr9wtOoIAvRqG0Q==:17
 a=EjBHVkixTFsA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=iSt4sp40Dg8dhv6zV2AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 clxscore=1011 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=925 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040110

T24gNi8zLzI1IDE3OjU0LCBKaXJpIE9sc2Egd3JvdGU6DQo+IE9uIFR1ZSwgSnVuIDAzLCAy
MDI1IGF0IDA0OjEzOjE4UE0gLTA0MDAsIEFuZHJleSBHcm9kem92c2t5IHdyb3RlOg0KPj4g
SGksIHdlIG9ic2VydmUgYmVsbG93IHJhbmRvbSB3YXJuaW5nIG9jY2FzaW9uYWxseSBkdXJp
bmcgQlBGIGhvb2tzIHVubG9hZCwNCj4+IHdlIG9ubHkgc2VlIGl0IG9uIHJoZWw4IGtlcm5l
bHMgcmFuZ2luZyBmcm9tIDguNi04LjEwIHNvIGl0IG1pZ2h0IGJlDQo+PiBzb21ldGhpbmcg
UkhFTCBzcGVjaWZpYyBhbmQgbm90IHVwc3RyZWFtIGlzc3VlcywgaSBzdGlsbCB3YXMgaG9w
aW5nIHRvIGdldA0KPj4gc29tZSBhZHZpc2Ugb3IgY2x1ZXMgZnJvbSBCUEYgZXhwZXJ0cyBo
ZXJlLg0KPiBoaSwNCj4gdW5sZXNzIHlvdSByZXByb2R1Y2Ugb24gdXBzdHJlYW0gb3Igc29t
ZSBzdGFibGUga2VybmVsIEknbSBhZnJhaWQgdGhlcmUncyBub3QNCj4gbXVjaCB0aGF0IGNh
biBiZSBkb25lIGluIGhlcmUNCj4NCj4gamlya2ENCg0KDQpUaGFua3MgSmlyaSwgeWVzLCBp
IHVuZGVyc3RhbmQgdGhlIGxpbWl0YXRpb25zIHNpbmNlIHRoaXMgbWlnaHQgYmUgYSANCnJl
c3VsdCBvZiBzb21lDQpSSEVMIGtlcm5lbCB0cmVlIHNwZWNpZmljIGJhZCBwYXRjaGVzIGNo
ZXJyeS1waWtpbmcvbWVyZ2UgZnJvbSB1cHN0cmVhbSANCmludG8gdGhlaXIgb3duIHRyZWVz
LiBJIHdhcw0KanVzdCBob3BwaW5nIHRoYXQgdGhpcyByaW5ncyBhbnkgYmVsbHMgdG8gYW55
b25lIGluIHRoZSBFLUJQRiBjb21tdW5pdHkgDQphcyBpdCB0dXJucw0KdG8gYmUgcmVhbGx5
IGhhcmQgdG8gcmVwcm8gYW5kIGhlbmNlIGFsc28gdG8gYmlzZWN0Lg0KDQpUaGFua3MsDQpB
bmRyZXkuDQoNCj4NCj4NCj4+IFRoYW5rcyxBbmRyZXkNCj4+DQo+PiBbIDU3MTQuMDcxNjEz
XSBXQVJOSU5HOiBDUFU6IDAgUElEOiAyMDY1MyBhdCBtbS92bWFsbG9jLmM6MzMwDQo+PiB2
bWFsbG9jX3RvX3BhZ2UrMHgyMWUvMHgyMzANCj4+IFsgNTcxNC4wNzk2NjhdIE1vZHVsZXMg
bGlua2VkIGluOiBuZnRfY2hhaW5fbmF0IGlwdF9NQVNRVUVSQURFIG5mX25hdA0KPj4gbmZf
Y29ubnRyYWNrIG5mX2RlZnJhZ19pcHY2IG5mX2RlZnJhZ19pcHY0IHZldGggbmZ0X2NvdW50
ZXIgaXB0X1JFSkVDVA0KPj4gbmZfcmVqZWN0X2lwdjQgbmZ0X2NvbXBhdCBmYWxjb25fbHNt
X3Bpbm5lZF83NDEzKEUpIGJpbmZtdF9taXNjIHRjcF9kaWFnDQo+PiB1ZHBfZGlhZyBpbmV0
X2RpYWcgbmZfdGFibGVzIG5mbmV0bGluayBvdmVybGF5IGludGVsX3JhcGxfbXNyDQo+PiBp
bnRlbF9yYXBsX2NvbW1vbiBhbWRfZW5lcmd5IHBjc3BrciBpMmNfcGlpeDQgeGZzIGxpYmNy
YzMyYyBudm1lX3RjcChYKQ0KPj4gbnZtZV9mYWJyaWNzIHNkX21vZCBzZyBjcmN0MTBkaWZf
cGNsbXVsIGNyYzMyX3BjbG11bCBjcmMzMmNfaW50ZWwgdmlydGlvX25ldA0KPj4gZ2hhc2hf
Y2xtdWxuaV9pbnRlbCBuZXRfZmFpbG92ZXIgdmlydGlvX3Njc2kgZmFpbG92ZXIgc2VyaW9f
cmF3IG52bWUNCj4+IG52bWVfY29yZSB0MTBfcGkgZG1fbWlycm9yIGRtX3JlZ2lvbl9oYXNo
IGRtX2xvZyBkbV9tb2QgZnVzZSBbbGFzdCB1bmxvYWRlZDoNCj4+IGZhbGNvbl9uZl9uZXRj
b250YWluXQ0KPj4gWyA1NzE0LjEzMTM3Ml0gUmVkIEhhdCBmbGFnczogZUJQRi9ldmVudCBl
QlBGL3Jhd3RyYWNlDQo+PiBbIDU3MTQuMTM2MzUxXSBDUFU6IDAgUElEOiAyMDY1MyBDb21t
OiBmYWxjb24tc2Vuc29yLWIgS2R1bXA6IGxvYWRlZA0KPj4gVGFpbnRlZDogR8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgRcKgIFggLS0tLS0tLS0tIC3CoCAtIDQuMTguMC00NzcuMTAuMS5l
bDhfOC54ODZfNjQgIzENCj4+IFsgNTcxNC4xNDg5NjRdIEhhcmR3YXJlIG5hbWU6IEdvb2ds
ZSBHb29nbGUgQ29tcHV0ZSBFbmdpbmUvR29vZ2xlIENvbXB1dGUNCj4+IEVuZ2luZSwgQklP
UyBHb29nbGUgMDUvMDcvMjAyNQ0KPj4gWyA1NzE0LjE1ODI4M10gUklQOiAwMDEwOnZtYWxs
b2NfdG9fcGFnZSsweDIxZS8weDIzMA0KPj4gWyA1NzE0LjE2MzA4Nl0gQ29kZTogMjggZjEg
YjAgMDAgNDggODEgZTcgMDAgMDAgMDAgYzAgZTkgMTkgZmYgZmYgZmYgNDggOGINCj4+IDNk
IDU1IDViIDBkIDAxIDQ4IDgxIGU3IDAwIGYwIGZmIGZmIDQ4IDg5IGZhIGViIDhjIDBmIDBi
IGU5IDEwIGZlIGZmIGZmIDwwZj4NCj4+IDBiIDMxIGMwIGU5IGY5IGYwIGIwIDAwIDY2IDBm
IDFmIDg0IDAwIDAwIDAwIDAwIDAwIDBmIDFmIDQ0IDAwDQo+PiBbIDU3MTQuMTgxOTQ5XSBS
U1A6IDAwMTg6ZmZmZmFkOTkwMTdiM2QxMCBFRkxBR1M6IDAwMDEwMjkzDQo+PiBbIDU3MTQu
MTg3MjcxXSBSQVg6IDAwMDAwMDAwMDAwMDAwNjMgUkJYOiBmZmZmZGVhZDA1ODI5ZDgwIFJD
WDoNCj4+IDAwMDAwMDAwMDAwMDAwMDANCj4+IFsgNTcxNC4xOTQ1MDBdIFJEWDogMDAwMDAw
MDAwMDAwMDAwMCBSU0k6IGZmZmZmZmZmYzIyMDAwNDkgUkRJOg0KPj4gMDAwMDAwMDAwMDAw
MDAwMA0KPj4gWyA1NzE0LjIwMTc0OV0gUkJQOiBmZmZmZmZmZmMyMWZmMDQ5IFIwODogMDAw
MDAwMDAwMDAwMDAwMCBSMDk6DQo+PiAwMDAwMDAwMDAwMDAwMDAxDQo+PiBbIDU3MTQuMjA4
OTc3XSBSMTA6IGZmZmY4YjkwMWJiNDAzYzAgUjExOiAwMDAwMDAwMDAwMDAwMDAxIFIxMjoN
Cj4+IDAwMDAwMDAwMDAwMDAwMDENCj4+IFsgNTcxNC4yMTYyMDZdIFIxMzogZmZmZmFkOTkw
MTdiM2Q1ZiBSMTQ6IGZmZmZmZmZmYzIyMDAwNDkgUjE1Og0KPj4gZmZmZjhiOTAwYTBiZGQ4
MA0KPj4gWyA1NzE0LjIyMzQzOF0gRlM6wqAgMDAwMDdmZjc2NmRhNGMwMCgwMDAwKSBHUzpm
ZmZmOGI5MTM3YzAwMDAwKDAwMDApDQo+PiBrbmxHUzowMDAwMDAwMDAwMDAwMDAwDQo+PiBb
IDU3MTQuMjMxNjIzXSBDUzrCoCAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAw
MDA4MDA1MDAzMw0KPj4gWyA1NzE0LjIzNzQ2Nl0gQ1IyOiAwMDAwNjAzMDAwMjYxMDAwIENS
MzogMDAwMDAwMDFiMzQzODAwNCBDUjQ6DQo+PiAwMDAwMDAwMDAwMzcwZWYwDQo+PiBbIDU3
MTQuMjQ0Njk5XSBDYWxsIFRyYWNlOg0KPj4gWyA1NzE0LjI0NzI0NV3CoCBfX3RleHRfcG9r
ZSsweDIwNy8weDI2MA0KPj4gWyA1NzE0LjI1MDkyNl3CoCB0ZXh0X3Bva2VfYnBfYmF0Y2gr
MHg4NS8weDI3MA0KPj4gWyA1NzE0LjI1NTEyMl3CoCA/IGJwZl90cmFtcG9saW5lXzY0NDI0
ODkwNDZfMCsweDQ5LzB4MTAwMA0KPj4gWyA1NzE0LjI2MDM2MV3CoCB0ZXh0X3Bva2VfYnAr
MHg0NC8weDcwDQo+PiBbIDU3MTQuMjYzOTU0XcKgIF9fYnBmX2FyY2hfdGV4dF9wb2tlKzB4
MWEyLzB4MWIwDQo+PiBbIDU3MTQuMjY4NDEyXcKgIGJwZl90cmFtcF9pbWFnZV9wdXQrMHgy
Yi8weDYwDQo+PiBbIDU3MTQuMjcyNjA4XcKgIGJwZl90cmFtcG9saW5lX3VwZGF0ZSsweDIw
NS8weDQ0MA0KPj4gWyA1NzE0LjI3NzE1MV3CoCBicGZfdHJhbXBvbGluZV91bmxpbmtfcHJv
ZysweDdhLzB4YzANCj4+IFsgNTcxNC4yODE5NTRdwqAgYnBmX3RyYWNpbmdfbGlua19yZWxl
YXNlKzB4MTYvMHg0MA0KPj4gWyA1NzE0LjI4NjU4NV3CoCBicGZfbGlua19mcmVlKzB4MmIv
MHg1MA0KPj4gWyA1NzE0LjI5MDI2M13CoCBicGZfbGlua19yZWxlYXNlKzB4MTEvMHgyMA0K
Pj4gWyA1NzE0LjI5NDE5NV3CoCBfX2ZwdXQrMHhiZS8weDI1MA0KPj4gWyA1NzE0LjI5NzM0
OF3CoCB0YXNrX3dvcmtfcnVuKzB4OGEvMHhiMA0KPj4gWyA1NzE0LjMwMTAyMV3CoCBleGl0
X3RvX3VzZXJtb2RlX2xvb3ArMHhlZi8weDEwMA0KPj4gWyA1NzE0LjMwNTQ3N13CoCBkb19z
eXNjYWxsXzY0KzB4MTljLzB4MWIwDQo+PiBbIDU3MTQuMzA5MzI0XcKgIGVudHJ5X1NZU0NB
TExfNjRfYWZ0ZXJfaHdmcmFtZSsweDYxLzB4YzYNCj4+IFsgNTcxNC4zMTQ0NzVdIFJJUDog
MDAzMzoweDdmZjc2Njc3OWI0Nw0KPj4gWyA1NzE0LjMxODE2NF0gQ29kZTogMTIgYjggMDMg
MDAgMDAgMDAgMGYgMDUgNDggM2QgMDAgZjAgZmYgZmYgNzcgM2IgYzMgNjYNCj4+IDkwIDUz
IDg5IGZiIDQ4IDgzIGVjIDEwIGU4IGU0IGZiIGZmIGZmIDg5IGRmIDg5IGMyIGI4IDAzIDAw
IDAwIDAwIDBmIDA1IDw0OD4NCj4+IDNkIDAwIGYwIGZmIGZmIDc3IDJiIDg5IGQ3IDg5IDQ0
IDI0IDBjIGU4IDI2IGZjIGZmIGZmIDhiIDQ0IDI0DQo+PiBbIDU3MTQuMzM3MDI5XSBSU1A6
IDAwMmI6MDAwMDdmZmY5MDU4ZjNkMCBFRkxBR1M6IDAwMDAwMjkzIE9SSUdfUkFYOg0KPj4g
MDAwMDAwMDAwMDAwMDAwMw0KPj4gWyA1NzE0LjM0NDY5NV0gUkFYOiAwMDAwMDAwMDAwMDAw
MDAwIFJCWDogMDAwMDAwMDAwMDAwMDI3NSBSQ1g6DQo+PiAwMDAwN2ZmNzY2Nzc5YjQ3DQo+
PiBbIDU3MTQuMzUxOTI2XSBSRFg6IDAwMDAwMDAwMDAwMDAwMDAgUlNJOiAwMDAwN2ZmNzY2
ZDg3MGUwIFJESToNCj4+IDAwMDAwMDAwMDAwMDAyNzUNCj4+IFsgNTcxNC4zNTkxNTZdIFJC
UDogMDAwMDdmZmY5MDU4ZjQwMCBSMDg6IDAwMDAwMDAwMDAwMDAwMjAgUjA5Og0KPj4gMDAw
MDAwMDAwMDAwMWE4Yw0KPj4gWyA1NzE0LjM2NjM4N10gUjEwOiAwMDAwN2ZmZjkwNThlYzQ4
IFIxMTogMDAwMDAwMDAwMDAwMDI5MyBSMTI6DQo+PiAwMDAwN2ZmNzY1ZmM0NzU4DQo+PiBb
IDU3MTQuMzczNjE4XSBSMTM6IDAwMDAwMDAwMDAwMDAwMjkgUjE0OiAwMDAwN2ZmNzY1ZmM5
NTI4IFIxNToNCj4+IDAwMDA2MTkwMDAwMDBhODANCj4+IFsgNTcxNC4zODA4NTFdIC0tLVsg
ZW5kIHRyYWNlIGU2ZTYwNjZlYTdlMDkwZmEgXS0tLQ0KPj4NCg0K

