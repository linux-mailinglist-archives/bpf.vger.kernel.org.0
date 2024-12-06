Return-Path: <bpf+bounces-46341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2CB9E7CDE
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 00:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23AFA1887B39
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 23:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B731FC0F5;
	Fri,  6 Dec 2024 23:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="cYP7pG0m"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FE01F3D3D
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 23:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733528801; cv=none; b=iVR9DpV16wuijKvSFc9GKDfpd6zztAKTrYX42ROjJDZKm7GI/wwfE7QVHjoE6KTKkKKqqroU1V6JrRXW4NhC1zYHxfCrqhkDHUhx894dK4mjT5jd8jYribiOc4wU58N050l4Bl2ZPUdK9TVH/6NpFuzyDxkKTBQCfDNVmSOafIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733528801; c=relaxed/simple;
	bh=AXHfSVA6sbYMyx7llheqO3Xp8HnB4ejP0MUnZrbHevs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SdxqBC6j6gD2RXK/7oLShpIQhfZA5okP9NEtjEpcm15b3csFmFNhFQGn6Blvnlu0yjRboY67iKJ8h9q0BMFrn5ivKeqECn0V7Mv7QoF7YFSmIJMfdtDx6zWcVFyiSog8RfnStS+fez+S1H6TsWhz16OGeVyh5INiYf6KNgn0PBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=cYP7pG0m; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6MYcuZ002284;
	Fri, 6 Dec 2024 23:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-id:content-transfer-encoding:content-type:date
	:from:in-reply-to:message-id:mime-version:references:subject:to;
	 s=default; bh=AXHfSVA6sbYMyx7llheqO3Xp8HnB4ejP0MUnZrbHevs=; b=c
	YP7pG0mzUp6eS+QEQdtllcBphoA9bw5ejnQXXXMxrZxwjGhPPm0zv36aqeY3ausl
	IHVnPeJnbfVTqEzGHmtVTMTBJwWZbYp3N4JMIhzTcPxCcngK+L7UPMVek5Y2Wvzd
	OCSsyGGEVjjJgcGoyPchLAOoqXbnDE4OH3E5XEyrtzb5WhbM7SryTmrXSaaXznr4
	CRejgYhOqlppxZPObMtVNvWZSPrQMTOgryc+GOvL8hZAbGi8hpeI7PbCemEL4+F3
	njXYIGQRU1LmyLeAp4CT9UxsOgcOsCCzV6r5cvfhbsqIVNNX/pSO/IVT1862hx6+
	WwzeZcUdkXO1Tki8ObKhA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 43ca6er1w1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 23:08:26 +0000 (GMT)
Received: from 04wpexch06.crowdstrike.sys (10.100.11.99) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 6 Dec 2024 23:08:25 +0000
Received: from 04wpexch06.crowdstrike.sys ([fe80::9386:41e4:ec25:9fd5]) by
 04wpexch06.crowdstrike.sys ([fe80::9386:41e4:ec25:9fd5%9]) with mapi id
 15.02.1544.009; Fri, 6 Dec 2024 23:08:25 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC: "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org"
	<ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>
Subject: Re: CONFIG_X86_X32_ABI silently breaks some fentry hooks
Thread-Topic: CONFIG_X86_X32_ABI silently breaks some fentry hooks
Thread-Index: AQHbGn1IBv6Qgmi38kyuqgRRJU67tLLaMoUA
Date: Fri, 6 Dec 2024 23:08:25 +0000
Message-ID: <ddedd6fdd8865d885ee141c33ebb03d83fc3d897.camel@crowdstrike.com>
References: <7136605d24de9b1fc62d02a355ef11c950a94153.camel@crowdstrike.com>
In-Reply-To: <7136605d24de9b1fc62d02a355ef11c950a94153.camel@crowdstrike.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-disclaimer: USA
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF404C5D5E110747AD40E6FD393EB567@crowdstrike.sys>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-GUID: mnSm_AWXgwXwrZJT_mTIz1-DJH_bUAih
X-Authority-Analysis: v=2.4 cv=Ft///3rq c=1 sm=1 tr=0 ts=675383ea cx=c_pps a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17 a=xqWC_Br6kY4A:10 a=EjBHVkixTFsA:10 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=VwQbUJbxAAAA:8 a=AiHppB-aAAAA:8
 a=snVGZ65Z-9Dwo9w7mA8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: mnSm_AWXgwXwrZJT_mTIz1-DJH_bUAih
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxlogscore=579 mlxscore=0 phishscore=0
 clxscore=1011 impostorscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412060176

T24gV2VkLCAyMDI0LTEwLTA5IGF0IDExOjU4IC0wNzAwLCBNYXJ0aW4gS2VsbHkgd3JvdGU6DQo+
IEhpIGFsbCwgSSB3YW50IHRvIHJlcG9ydCBhIHZlcnkgc3RyYW5nZSBpc3N1ZXMgSSBmb3VuZC4g
U3BlY2lmaWNhbGx5LA0KPiBvbiBsYXRlc3QgbWFzdGVyLCBJIGZvdW5kIHRoYXQgc2V0dGluZyBD
T05GSUdfWDg2X1gzMl9BQkk9eSBjYXVzZXMNCj4gc29tZQ0KPiBmZW50cnkgQlBGIGhvb2tzIHRv
IGJlIHNpbGVudGx5IGlnbm9yZWQuIE1vc3QgaG9va3Mgc3RpbGwgd29yayBmaW5lLA0KPiBidXQg
c29tZSBkbyBub3QsIGFuZCB0aGUgc2FtZSBmdW5jdGlvbiB3b3JrcyBmaW5lIGFzIGEga3Byb2Jl
LiBUaGUNCj4gaXNzdWUgYXBwZWFycyB0byBiZSAxMDAlIHJlcHJvZHVjaWJsZSBmb3IgYSBnaXZl
biBmdW5jdGlvbiBob29rLg0KPiANCg0KVGhpcyB3YXMgcm9vdC1jYXVzZWQgdG8gYmUgdGhlIHNh
bWUgaXNzdWUgYXMgdGhlIG9uZSBhZGRyZXNzZWQgaW4gdGhpcw0KKHVubWVyZ2VkKSBwYXRjaCBz
ZXJpZXM6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjQwNzIzMDYzMjU4LjIyNDA2
MTAtMS16aGVuZ3llamlhbkBodWF3ZWljbG91ZC5jb20vDQoNCkVzc2VudGlhbGx5IHRoaXMgaGFz
IHRvIGRvIHdpdGggZnRyYWNlIGFuZCB3ZWFrIGZ1bmN0aW9ucy4NCg==

