Return-Path: <bpf+bounces-70983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C79BDEA45
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 15:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42F3A19A5E30
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 13:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B1E32A3D1;
	Wed, 15 Oct 2025 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nYs+uFcj"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED8713C8EA;
	Wed, 15 Oct 2025 13:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760533600; cv=none; b=j7IotJkrpyYmYCubE67CXeuz2Bmu9/CUiCR/iuPMBqiliQSl7jVV7ny94bz37ickznyrqfQAufKtOGPy5RvWrvVJTyjiH3vOM6SycooQyx+SHBw5y5QyUN1zqEOjHRFfT64HhDV2UPQdhpCyQyiuRFpjoPttV2HBKPx8/HXoQi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760533600; c=relaxed/simple;
	bh=scvZl06Q7RpCKqLlktuAfZ/d+iCx1R0MWbtOwG2+CMk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uyipM0NT1XQadxvCYB3VLMAHTJKCujjaP5IkMotT0ts9wmrzfmwCWLNpKx55RBhi/UbJ9wzqUxHReXDo2OmTBXvX0tzu78/zCuMQ7xbxo6hdRAY+OIp2AoI95RQ6XZ6wRHpcZRLKN59ZXnKBar8vJki5aDFpLQcnTpc0d5CpfVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nYs+uFcj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FCIgXq016580;
	Wed, 15 Oct 2025 13:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=scvZl0
	6Q7RpCKqLlktuAfZ/d+iCx1R0MWbtOwG2+CMk=; b=nYs+uFcjUBYPzs0A8/HdMx
	PndeyAUbUTPneknK4jttGQzDTx9bJ0ZdydBQhD5Gi30Pazhdi+jNZzP09u4e0Zwq
	GFPmegDYyfIU1xbR8l/2mNdIxXq2XJ7Ds2g6cd122hDS7eNO14sDNf1K5vH4YMoS
	twV/5Cia5cCREiTwXpSTLs9p8qV4uCHH0v0WCFqlyDUs6ACwJ0J5D6h6chIk2z40
	J46Opmcia9ATrypNtYLBwnlRkcczUKAXZ9wUD6YjUA87CtIfVxBi1zNh5b1ixKDW
	QK0/6Jp6BHZTGoz5eM7ozuTabsvZ4lkAyruYBDCzGYQgkXNUaCZ/HzsT/Eh9qPsw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qcnrc39k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 13:05:41 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59FCjM1v011022;
	Wed, 15 Oct 2025 13:05:41 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qcnrc39e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 13:05:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59FBU85T018353;
	Wed, 15 Oct 2025 13:05:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49s3rfa2mx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 13:05:40 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59FD5ceC61604230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 13:05:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44E87200D4;
	Wed, 15 Oct 2025 13:05:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D060200D3;
	Wed, 15 Oct 2025 13:05:36 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.111.86.218])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Oct 2025 13:05:36 +0000 (GMT)
Message-ID: <21909f5d6a29819249f2b36f5e9911d593afea7c.camel@linux.ibm.com>
Subject: Re: [PATCH 6.12 000/262] 6.12.53-rc1 review
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
        conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
        achill@achill.org, Daniel Borkmann <daniel@iogearbox.net>,
        Dan Carpenter
 <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell	
 <anders.roxell@linaro.org>,
        Ben Copeland <benjamin.copeland@linaro.org>,
        linux-s390@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        bpf	
 <bpf@vger.kernel.org>
Date: Wed, 15 Oct 2025 15:05:35 +0200
In-Reply-To: <2025101523-foster-impotent-6649@gregkh>
References: <20251013144326.116493600@linuxfoundation.org>
	 <CA+G9fYsdErtgqKuyPfFhMS9haGKavBVCHQnipv2EeXM3OK0-UQ@mail.gmail.com>
	 <CA+G9fYuV-J7N0cAy30X+rLCRrER071nMkk9JC6kjDw1U0gEzJg@mail.gmail.com>
	 <69b2bf4c5d3aa7fd9c5b6822a03666f616eafe13.camel@linux.ibm.com>
	 <2025101523-foster-impotent-6649@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5ZA6iws c=1 sm=1 tr=0 ts=68ef9c25 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=ag1SF4gXAAAA:8 a=9YlEqVn2KRIrlsf5RyQA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=Yupwre4RP9_Eg_Bd0iYG:22
 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-GUID: 9yI1mQ5idsAuKORT-Mlyv0w-AMzdO1R9
X-Proofpoint-ORIG-GUID: 6uhBW9rRcAok-eHE2zmpzIM3aTzS0OAe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEwMDE0MCBTYWx0ZWRfX4uiFaQ4+xfnH
 MAyB/U7JHJn3KqWrx27FNNMdp8nf4sp6bALYGGu8cKl+35B1VOcS4DmfmNuMd8YsjEypAIeP3gX
 Kwa+wug7EDZkukBwirOMuQqvd5aIGlxwO/Ob2JxSQ+hKiptFl3aJsiJCEaR5LAHSBV1d9RKuKpN
 zFVCgFkg1nnWvYTFH3PdyXYUPXDCBpPFRgwVtDHziLv8ZQKvKv6S333pANrmnEhESkmoMnuM9td
 lZCBqTNZh9pp3TjsN2Nc1tjIb++KLmEP8tx3Z1A9wV5VueKgqBFAo/fJH1VUiiOrf7S8LR4o/pM
 4slsSAJeNsMhOlIiU04+NxBKUxhtJ3CpPeX0xWt5zzsOrCqISwCCsPfwUuR3y8IKhq8dRV/5h/b
 WtUkeRTAQl1gQKYIUGr96igdgp6Byw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510100140

T24gV2VkLCAyMDI1LTEwLTE1IGF0IDEwOjQ2ICswMjAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6Cj4gT24gVHVlLCBPY3QgMTQsIDIwMjUgYXQgMDQ6NDU6MTFQTSArMDIwMCwgSWx5YSBMZW9z
aGtldmljaCB3cm90ZToKPiA+IE9uIFR1ZSwgMjAyNS0xMC0xNCBhdCAxOTozOCArMDUzMCwgTmFy
ZXNoIEthbWJvanUgd3JvdGU6Cj4gPiA+IE9uIFR1ZSwgMTQgT2N0IDIwMjUgYXQgMTY6NTYsIE5h
cmVzaCBLYW1ib2p1Cj4gPiA+IDxuYXJlc2gua2FtYm9qdUBsaW5hcm8ub3JnPiB3cm90ZToKPiA+
ID4gPiAKPiA+ID4gPiBPbiBNb24sIDEzIE9jdCAyMDI1IGF0IDIwOjM4LCBHcmVnIEtyb2FoLUhh
cnRtYW4KPiA+ID4gPiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOgo+ID4gPiA+
ID4gCj4gPiA+ID4gPiBUaGlzIGlzIHRoZSBzdGFydCBvZiB0aGUgc3RhYmxlIHJldmlldyBjeWNs
ZSBmb3IgdGhlIDYuMTIuNTMKPiA+ID4gPiA+IHJlbGVhc2UuCj4gPiA+ID4gPiBUaGVyZSBhcmUg
MjYyIHBhdGNoZXMgaW4gdGhpcyBzZXJpZXMsIGFsbCB3aWxsIGJlIHBvc3RlZCBhcyBhCj4gPiA+
ID4gPiByZXNwb25zZQo+ID4gPiA+ID4gdG8gdGhpcyBvbmUuwqAgSWYgYW55b25lIGhhcyBhbnkg
aXNzdWVzIHdpdGggdGhlc2UgYmVpbmcKPiA+ID4gPiA+IGFwcGxpZWQsCj4gPiA+ID4gPiBwbGVh
c2UKPiA+ID4gPiA+IGxldCBtZSBrbm93Lgo+ID4gPiA+ID4gCj4gPiA+ID4gPiBSZXNwb25zZXMg
c2hvdWxkIGJlIG1hZGUgYnkgV2VkLCAxNSBPY3QgMjAyNSAxNDo0Mjo0MSArMDAwMC4KPiA+ID4g
PiA+IEFueXRoaW5nIHJlY2VpdmVkIGFmdGVyIHRoYXQgdGltZSBtaWdodCBiZSB0b28gbGF0ZS4K
PiA+ID4gPiA+IAo+ID4gPiA+ID4gVGhlIHdob2xlIHBhdGNoIHNlcmllcyBjYW4gYmUgZm91bmQg
aW4gb25lIHBhdGNoIGF0Ogo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAKPiA+ID4gPiA+IGh0dHBz
Oi8vd3d3Lmtlcm5lbC5vcmcvcHViL2xpbnV4L2tlcm5lbC92Ni54L3N0YWJsZS1yZXZpZXcvcGF0
Y2gtNi4xMi41My1yYzEuZ3oKPiA+ID4gPiA+IG9yIGluIHRoZSBnaXQgdHJlZSBhbmQgYnJhbmNo
IGF0Ogo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAKPiA+ID4gPiA+IGdpdDovL2dpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9zdGFibGUvbGludXgtCj4gPiA+ID4gPiBzdGFi
bGUtcmMuZ2l0IGxpbnV4LTYuMTIueQo+ID4gPiA+ID4gYW5kIHRoZSBkaWZmc3RhdCBjYW4gYmUg
Zm91bmQgYmVsb3cuCj4gPiA+ID4gPiAKPiA+ID4gPiA+IHRoYW5rcywKPiA+ID4gPiA+IAo+ID4g
PiA+ID4gZ3JlZyBrLWgKPiA+ID4gPiAKPiA+ID4gPiBUaGUgUzM5MCBkZWZjb25maWcgYnVpbGRz
IGZhaWxlZCBvbiB0aGUgTGludXggc3RhYmxlLXJjCj4gPiA+ID4gNi4xMi41My1yYzEKPiA+ID4g
PiBhbmQgNi42LjExMi1yYzEgdGFnIGJ1aWxkIGR1ZSB0byBmb2xsb3dpbmcgYnVpbGQgd2Fybmlu
Z3MgLwo+ID4gPiA+IGVycm9ycwo+ID4gPiA+IHdpdGggZ2NjIGFuZCBjbGFuZyB0b29sY2hhaW5z
Lgo+ID4gPiA+IAo+ID4gPiA+IEFsc28gc2VlbiBvbiA2LjYuMTEyLXJjMS4KPiA+ID4gPiAKPiA+
ID4gPiAqIHMzOTAsIGJ1aWxkCj4gPiA+ID4gwqAgLSBjbGFuZy0yMS1kZWZjb25maWcKPiA+ID4g
PiDCoCAtIGNsYW5nLW5pZ2h0bHktZGVmY29uZmlnCj4gPiA+ID4gwqAgLSBjbGFuZy1uaWdodGx5
LWxrZnRjb25maWctaGFyZGVuaW5nCj4gPiA+ID4gwqAgLSBjbGFuZy1uaWdodGx5LWxrZnRjb25m
aWctbHRvLWZ1bGwKPiA+ID4gPiDCoCAtIGNsYW5nLW5pZ2h0bHktbGtmdGNvbmZpZy1sdG8tdGhp
bmcKPiA+ID4gPiDCoCAtIGdjYy0xNC1hbGxtb2Rjb25maWcKPiA+ID4gPiDCoCAtIGdjYy0xNC1k
ZWZjb25maWcKPiA+ID4gPiDCoCAtIGdjYy0xNC1sa2Z0Y29uZmlnLWhhcmRlbmluZwo+ID4gPiA+
IMKgIC0gZ2NjLTgtZGVmY29uZmlnLWZlNDAwOTNkCj4gPiA+ID4gwqAgLSBnY2MtOC1sa2Z0Y29u
ZmlnLWhhcmRlbmluZwo+ID4gPiA+IMKgIC0ga29yZy1jbGFuZy0yMS1sa2Z0Y29uZmlnLWhhcmRl
bmluZwo+ID4gPiA+IMKgIC0ga29yZy1jbGFuZy0yMS1sa2Z0Y29uZmlnLWx0by1mdWxsCj4gPiA+
ID4gwqAgLSBrb3JnLWNsYW5nLTIxLWxrZnRjb25maWctbHRvLXRoaW5nCj4gPiA+ID4gCj4gPiA+
ID4gRmlyc3Qgc2VlbiBvbiA2LjEyLjUzLXJjMQo+ID4gPiA+IEdvb2Q6IHY2LjEyLjUyCj4gPiA+
ID4gQmFkOiA2LjEyLjUzLXJjMSBhbHNvIHNlZW4gb24gNi42LjExMi1yYzEKPiA+ID4gPiAKPiA+
ID4gPiBSZWdyZXNzaW9uIEFuYWx5c2lzOgo+ID4gPiA+IC0gTmV3IHJlZ3Jlc3Npb24/IHllcwo+
ID4gPiA+IC0gUmVwcm9kdWNpYmlsaXR5PyB5ZXMKPiA+ID4gPiAKPiA+ID4gPiBCdWlsZCByZWdy
ZXNzaW9uczogYXJjaC9zMzkwL25ldC9icGZfaml0X2NvbXAuYzoxODEzOjQ5OiBlcnJvcjoKPiA+
ID4gPiAnc3RydWN0IGJwZl9qaXQnIGhhcyBubyBtZW1iZXIgbmFtZWQgJ2ZyYW1lX29mZicKPiA+
ID4gPiAKPiA+ID4gPiBSZXBvcnRlZC1ieTogTGludXggS2VybmVsIEZ1bmN0aW9uYWwgVGVzdGlu
ZyA8bGtmdEBsaW5hcm8ub3JnPgo+ID4gPiA+IAo+ID4gPiA+ICMgQnVpbGQgZXJyb3IKPiA+ID4g
PiBhcmNoL3MzOTAvbmV0L2JwZl9qaXRfY29tcC5jOiBJbiBmdW5jdGlvbiAnYnBmX2ppdF9pbnNu
JzoKPiA+ID4gPiBhcmNoL3MzOTAvbmV0L2JwZl9qaXRfY29tcC5jOjE4MTM6NDk6IGVycm9yOiAn
c3RydWN0IGJwZl9qaXQnCj4gPiA+ID4gaGFzCj4gPiA+ID4gbm8KPiA+ID4gPiBtZW1iZXIgbmFt
ZWQgJ2ZyYW1lX29mZicKPiA+ID4gPiDCoDE4MTMgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfRU1JVDYoMHhkMjAzZjAwMCB8IChqaXQtCj4gPiA+ID4g
PmZyYW1lX29mZgo+ID4gPiA+ICsKPiA+ID4gPiDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXn4KPiA+ID4gPiBhcmNoL3MzOTAvbmV0L2JwZl9qaXRf
Y29tcC5jOjIxMTo1NTogbm90ZTogaW4gZGVmaW5pdGlvbiBvZgo+ID4gPiA+IG1hY3JvCj4gPiA+
ID4gJ19FTUlUNicKPiA+ID4gPiDCoCAyMTEgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICoodTMyICopIChqaXQtPnByZ19idWYgKyBqaXQtPnByZykgPQo+ID4gPiA+IChvcDEpO8Kg
wqDCoMKgIFwKPiA+ID4gPiDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiA+ID4gPiBefn4KPiA+ID4gPiBpbmNsdWRlL2xpbnV4
L3N0ZGRlZi5oOjE2OjMzOiBlcnJvcjogaW52YWxpZCB1c2Ugb2YgdW5kZWZpbmVkCj4gPiA+ID4g
dHlwZQo+ID4gPiA+ICdzdHJ1Y3QgcHJvZ19mcmFtZScKPiA+ID4gPiDCoMKgIDE2IHwgI2RlZmlu
ZSBvZmZzZXRvZihUWVBFLCBNRU1CRVIpwqAKPiA+ID4gPiBfX2J1aWx0aW5fb2Zmc2V0b2YoVFlQ
RSwKPiA+ID4gPiBNRU1CRVIpCj4gPiA+ID4gwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBefn5+fn5+fn5+
fn5+fn5+fn4KPiA+ID4gPiBhcmNoL3MzOTAvbmV0L2JwZl9qaXRfY29tcC5jOjIxMTo1NTogbm90
ZTogaW4gZGVmaW5pdGlvbiBvZgo+ID4gPiA+IG1hY3JvCj4gPiA+ID4gJ19FTUlUNicKPiA+ID4g
PiDCoCAyMTEgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICoodTMyICopIChqaXQt
PnByZ19idWYgKyBqaXQtPnByZykgPQo+ID4gPiA+IChvcDEpO8KgwqDCoMKgIFwKPiA+ID4gPiDC
oMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAKPiA+ID4gPiBefn4KPiA+ID4gPiBhcmNoL3MzOTAvbmV0L2JwZl9qaXRfY29tcC5jOjE4
MTQ6NDY6IG5vdGU6IGluIGV4cGFuc2lvbiBvZgo+ID4gPiA+IG1hY3JvCj4gPiA+ID4gJ29mZnNl
dG9mJwo+ID4gPiA+IMKgMTgxNCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4g
PiA+ID4gb2Zmc2V0b2Yoc3RydWN0IHByb2dfZnJhbWUsCj4gPiA+ID4gwqDCoMKgwqDCoCB8wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF5+fn5+fn5+Cj4gPiA+ID4gaW5jbHVkZS9s
aW51eC9zdGRkZWYuaDoxNjozMzogZXJyb3I6IGludmFsaWQgdXNlIG9mIHVuZGVmaW5lZAo+ID4g
PiA+IHR5cGUKPiA+ID4gPiAnc3RydWN0IHByb2dfZnJhbWUnCj4gPiA+ID4gwqDCoCAxNiB8ICNk
ZWZpbmUgb2Zmc2V0b2YoVFlQRSwgTUVNQkVSKcKgCj4gPiA+ID4gX19idWlsdGluX29mZnNldG9m
KFRZUEUsCj4gPiA+ID4gTUVNQkVSKQo+ID4gPiA+IMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXn5+fn5+
fn5+fn5+fn5+fn5+Cj4gPiA+ID4gYXJjaC9zMzkwL25ldC9icGZfaml0X2NvbXAuYzoyMTI6NTk6
IG5vdGU6IGluIGRlZmluaXRpb24gb2YKPiA+ID4gPiBtYWNybwo+ID4gPiA+ICdfRU1JVDYnCj4g
PiA+ID4gwqAgMjEyIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqKHUxNiAqKSAo
aml0LT5wcmdfYnVmICsgaml0LT5wcmcgKyA0KQo+ID4gPiA+ID0KPiA+ID4gPiAob3AyKTsgXAo+
ID4gPiA+IMKgwqDCoMKgwqAKPiA+ID4gPiB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiA+ID4gPiBefn4KPiA+ID4gPiBhcmNoL3Mz
OTAvbmV0L2JwZl9qaXRfY29tcC5jOjE4MTY6NDE6IG5vdGU6IGluIGV4cGFuc2lvbiBvZgo+ID4g
PiA+IG1hY3JvCj4gPiA+ID4gJ29mZnNldG9mJwo+ID4gPiA+IMKgMTgxNiB8wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHhmMDAw
IHwgb2Zmc2V0b2Yoc3RydWN0Cj4gPiA+ID4gcHJvZ19mcmFtZSwKPiA+ID4gPiDCoMKgwqDCoMKg
IHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBefn5+fn5+fgo+ID4gPiA+IGFyY2gvczM5MC9uZXQv
YnBmX2ppdF9jb21wLmM6IEluIGZ1bmN0aW9uCj4gPiA+ID4gJ19fYXJjaF9wcmVwYXJlX2JwZl90
cmFtcG9saW5lJzoKPiA+ID4gPiBpbmNsdWRlL2xpbnV4L3N0ZGRlZi5oOjE2OjMzOiBlcnJvcjog
aW52YWxpZCB1c2Ugb2YgdW5kZWZpbmVkCj4gPiA+ID4gdHlwZQo+ID4gPiA+ICdzdHJ1Y3QgcHJv
Z19mcmFtZScKPiA+ID4gPiDCoMKgIDE2IHwgI2RlZmluZSBvZmZzZXRvZihUWVBFLCBNRU1CRVIp
wqAKPiA+ID4gPiBfX2J1aWx0aW5fb2Zmc2V0b2YoVFlQRSwKPiA+ID4gPiBNRU1CRVIpCj4gPiA+
ID4gwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBefn5+fn5+fn5+fn5+fn5+fn4KPiA+ID4gPiBhcmNoL3Mz
OTAvbmV0L2JwZl9qaXRfY29tcC5jOjIxMjo1OTogbm90ZTogaW4gZGVmaW5pdGlvbiBvZgo+ID4g
PiA+IG1hY3JvCj4gPiA+ID4gJ19FTUlUNicKPiA+ID4gPiDCoCAyMTIgfMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICoodTE2ICopIChqaXQtPnByZ19idWYgKyBqaXQtPnByZyArIDQp
Cj4gPiA+ID4gPQo+ID4gPiA+IChvcDIpOyBcCj4gPiA+ID4gwqDCoMKgwqDCoAo+ID4gPiA+IHzC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oAo+ID4gPiA+IF5+fgo+ID4gPiA+IGFyY2gvczM5MC9uZXQvYnBmX2ppdF9jb21wLmM6MjgxMzoz
Mzogbm90ZTogaW4gZXhwYW5zaW9uIG9mCj4gPiA+ID4gbWFjcm8KPiA+ID4gPiAnb2Zmc2V0b2Yn
Cj4gPiA+ID4gwqAyODEzIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIDB4ZjAwMCB8IG9mZnNldG9mKHN0cnVjdAo+ID4gPiA+IHByb2dfZnJhbWUsCj4gPiA+
ID4gdGFpbF9jYWxsX2NudCkpOwo+ID4gPiA+IMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXn5+fn5+fn4K
PiA+ID4gPiBtYWtlWzVdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6MjI5Ogo+ID4gPiA+
IGFyY2gvczM5MC9uZXQvYnBmX2ppdF9jb21wLm9dIEVycm9yIDEKPiA+ID4gPiAKPiA+ID4gPiBU
aGUgZ2l0IGJsYW1lIGlzIHBvaW50aW5nIHRvLAo+ID4gPiA+IMKgJCBnaXQgYmxhbWUgLUwgMTgx
M8KgIGFyY2gvczM5MC9uZXQvYnBmX2ppdF9jb21wLmMKPiA+ID4gPiDCoMKgIDE2MjUxM2Q3ZDgx
NDg3IChJbHlhIExlb3Noa2V2aWNoKcKgwqDCoCBfRU1JVDYoMHhkMjAzZjAwMCB8Cj4gPiA+ID4g
KGppdC0KPiA+ID4gPiA+IGZyYW1lX29mZiArCj4gPiA+ID4gCj4gPiA+ID4gQ29tbWl0IHBvaW50
aW5nIHRvLAo+ID4gPiA+IMKgwqAgczM5MC9icGY6IFdyaXRlIGJhY2sgdGFpbCBjYWxsIGNvdW50
ZXIgZm9yIEJQRl9QU0VVRE9fQ0FMTAo+ID4gPiA+IMKgwqAgWyBVcHN0cmVhbSBjb21taXQgYzg2
MWE2YjE0NzEzN2QxMGI1ZmY4OGEyYzQ5MmJhMzc2Y2QxYjhiMCBdCj4gPiA+IAo+ID4gPiBBbmRl
cnMgYmlzZWN0ZWQgcmVwb3J0ZWQgcmVncmVzc2lvbnMgYW5kIGFsc28gc3VnZ2VzdGVkIHRoZQo+
ID4gPiBtaXNzaW5nCj4gPiA+IHBhdGNoZXMuCj4gPiA+IAo+ID4gPiBJbHlhIExlb3Noa2V2aWNo
LAo+ID4gPiBJcyBpdCBhIGdvb2QgaWRlYSB0byBiYWNrcG9ydCAvIGNoZXJyeSBwaWNrIHRoZXNl
IHR3byBwYXRjaGVzIG9uCj4gPiA+IHRoZQo+ID4gPiA2LjEyIGJyYW5jaCA/Cj4gPiA+IAo+ID4g
PiBiMjI2OGQ1NTBkMjAgKCJzMzkwL2JwZjogQ2VudHJhbGl6ZSBmcmFtZSBvZmZzZXQgY2FsY3Vs
YXRpb25zIikKPiA+ID4gZTI2ZDUyM2VkZjJhICgiczM5MC9icGY6IERlc2NyaWJlIHRoZSBmcmFt
ZSB1c2luZyBhIHN0cnVjdAo+ID4gPiBpbnN0ZWFkIG9mCj4gPiA+IGNvbnN0YW50cyIpCj4gPiAK
PiA+IFRoYW5rIHlvdSBmb3IgdGhlIHJlcG9ydCBhbmQgdGhlIGludmVzdGlnYXRpb24hCj4gPiAK
PiA+IEkgdGhpbmsgaXQgd291bGQgYmUgYSBnb29kIGlkZWEgdG8gYmFja3BvcnQgdGhlc2UuCj4g
PiBCb3RoIGFyZSBORkMgY2hhbmdlcyB0aGF0IHdlbnQgaW50byB2Ni4xNyBhbmQgdGhlcmUgd2Vy
ZSBubwo+ID4gY29tcGxhaW50cy4KPiA+IAo+ID4gRm9yIHY2LjYgd2UgYWxzbyBuZWVkIHRoaXMg
b25lIChhbHNvIE5GQyk6Cj4gPiAKPiA+IDY3YWVkMjdiY2Q0NiAoInMzOTAvYnBmOiBDaGFuZ2Ug
c2Vlbl9yZWcgdG8gYSBtYXNrIikKPiAKPiBUaGFua3MgZm9yIHRoZSBpbmZvLCBJJ2xsIGdvIGRy
b3AgdGhlIG9yaWdpbmFsIG9mZmVuZGluZyBjb21taXQgZnJvbQo+IGJvdGggcXVldWVzLsKgIENh
biBzb21lb25lIHBsZWFzZSByZXN1Ym1pdCBhbGwgb2YgdGhlIG5lZWRlZCBjaGFuZ2VzCj4gZm9y
Cj4gdXMgdG8gYXBwbHkgc28gdGhhdCBJIGFtIHN1cmUgdG8gZ2V0IHRoZW0gYWxsIGNvcnJlY3Rs
eT8KCldpbGwgZG87IHRoZXkgcmVxdWlyZSBhIHZlcnkgbWlub3IgY29uZmxpY3QgcmVzb2x1dGlv
bi4KCj4gCj4gdGhhbmtzLAo+IAo+IGdyZWcgay1oCg==


