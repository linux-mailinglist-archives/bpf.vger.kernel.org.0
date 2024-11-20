Return-Path: <bpf+bounces-45303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1819D43AE
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 22:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A530C1F21DF9
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 21:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584B71B5338;
	Wed, 20 Nov 2024 21:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="g6YKPKoJ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD6A136E21
	for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732139784; cv=none; b=CjNcNwifEYT0ejoIoGkDr5B4pycjUXRJqV/nuXxj3AQpgEvI2ofgMp0WCPEH+WiF2cFC+ZBsBKyOaPuRg69DvpItzgofdpQMZbE1a0Yj+IyGzodh6EZ239g3oaf2Ni1EPCukqs8WAO59DyTxWNV6Nybsvx4O/n54lZpkY95EE0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732139784; c=relaxed/simple;
	bh=6+lgbnDd+uaiKalhn+cBgKJ0t1CFyF/xHyj5Z2Ks67U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z0IdGk8H4/nsETs8BMy8i1idf7kiWCi2/5b2Ei5VS3Vea2nIzClz9UuXvbK68LYl1H6rKRDDRerNimdT72nL8ZPOVPcptFu5FEVw3T9Jl8q0XtBG+PGfsoklYXQhpQmGGOG8h8u6zp4XN6K76KQdc5s+5nz+Zc1S/PTReOCOeQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=g6YKPKoJ; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKIEArp010103;
	Wed, 20 Nov 2024 21:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-id:content-transfer-encoding:content-type:date
	:from:in-reply-to:message-id:mime-version:references:subject:to;
	 s=default; bh=6+lgbnDd+uaiKalhn+cBgKJ0t1CFyF/xHyj5Z2Ks67U=; b=g
	6YKPKoJ3JYven6ot/kVEN0XIr05FS3ZfA6x3WWtWZh47WheI9wiMZjOcmMTPDSHT
	IpTLDg8K+sJMiZjCoqqUjtVOCTWF7fvCGrAL59VHlFuytnK+PS5180PKoGk3bHSV
	3MziF7+GTiDAxzlhE3lObmyE/k5sbu+XiNB3rGXNZ2pR90nTYh2guPabk1t6eNtA
	RZbBeeYgKg8OTKx/V3WCeORmkQecqSueEd8dQP561d8pCjGX/9of5hpUptoUfE+m
	C6nHAKuf+bAJ///ylrz+tH7Ic+ucJ2TlG4ncBu7pbm4uw4SZsyYJC6GWnpCYVE9I
	uFUTO7Jnroy/TKZFSB1ww==
Received: from mail.crowdstrike.com (74-209-223-77.static.ash01.latisys.net [74.209.223.77] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 431mv78jya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 21:55:56 +0000 (GMT)
Received: from 03WPEXCH009.crowdstrike.sys (10.80.52.161) by
 03wpexch16.crowdstrike.sys (10.80.52.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 20 Nov 2024 21:55:55 +0000
Received: from 03WPEXCH10.crowdstrike.sys (10.80.52.140) by
 03WPEXCH009.crowdstrike.sys (10.80.52.161) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 20 Nov 2024 13:55:54 -0800
Received: from 03WPEXCH10.crowdstrike.sys ([fe80::3707:e9de:74e7:2dde]) by
 03WPEXCH10.crowdstrike.sys ([fe80::3707:e9de:74e7:2dde%9]) with mapi id
 15.02.1544.009; Wed, 20 Nov 2024 21:55:54 +0000
From: Francis Deslauriers <francis.deslauriers@crowdstrike.com>
To: "maxim@isovalent.com" <maxim@isovalent.com>
CC: "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org"
	<ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: Re: Recent eBPF verifier rejects program that was accepted by 6.8
 eBPF verifier
Thread-Topic: Re: Recent eBPF verifier rejects program that was accepted by
 6.8 eBPF verifier
Thread-Index: AQHbO5b4Cl3SiiALEU2Q5xrW0IfjPQ==
Date: Wed, 20 Nov 2024 21:55:54 +0000
Message-ID: <60676451033326e9fc10c836f3739858beddbb61.camel@crowdstrike.com>
References: <50b7301fcfd0682c9923b3639c1589f3eb37af33.camel@crowdstrike.com>
	 <CAD0BsJWf=28Cte5KBpM_O6bsB55kfR885f2ikfn1+UmJHgMYqg@mail.gmail.com>
In-Reply-To: <CAD0BsJWf=28Cte5KBpM_O6bsB55kfR885f2ikfn1+UmJHgMYqg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-disclaimer: USA
Content-Type: text/plain; charset="utf-8"
Content-ID: <121BAB23CBA7D14AA17F6DE5819BAA8D@crowdstrike.sys>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-GUID: L2xDPDHklxElgnx5m9XD5ekqK7zTzviU
X-Authority-Analysis: v=2.4 cv=SYGldeRu c=1 sm=1 tr=0 ts=673e5aec cx=c_pps a=gZx6DIAxr9wtOoIAvRqG0Q==:117 a=gZx6DIAxr9wtOoIAvRqG0Q==:17 a=xqWC_Br6kY4A:10 a=EjBHVkixTFsA:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=pl6vuDidAAAA:8 a=p8Hr7QA-AAAA:8 a=psnyiEVZqaLzXD0ZpTIA:9 a=QEXdDO2ut3YA:10 a=Nk6gH44JAh1yPMgKJKsv:22
X-Proofpoint-ORIG-GUID: L2xDPDHklxElgnx5m9XD5ekqK7zTzviU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411200155

SGkgTWF4aW0sDQoNCk9uIFdlZCwgMjAyNC0xMS0yMCBhdCAyMjozMyArMDIwMCwgTWF4aW0gTWlr
aXR5YW5za2l5IHdyb3RlOg0KPiBIaSBGcmFuY2lzLA0KPiANCj4gT24gRnJpLCAxNSBOb3YgMjAy
NCBhdCAyMjo1OSwgRnJhbmNpcyBEZXNsYXVyaWVycw0KPiA8ZnJhbmNpcy5kZXNsYXVyaWVyc0Bj
cm93ZHN0cmlrZS5jb20+IHdyb3RlOg0KPiA+IEkgYWRkZWQgYSBzdHJpcHBlZCBkb3duIGxpYmJw
ZiByZXByb2R1Y2VyIGJhc2VkIG9uIHRoZSBsaWJicGYtDQo+ID4gYm9vdHN0cmFwIHJlcG8gdG8N
Cj4gPiBzaG93Y2FzZSB0aGlzIGlzc3VlIChzZWUgYmVsb3cpLiBOb3RlIHRoYXQgaWYgSSBjaGFu
Z2UgdGhlDQo+ID4gUlVMRV9MSVNUX1NJWkUgZnJvbQ0KPiA+IDM4MCB0byAzMCwgdGhlIHZlcmlm
aWVyIGFjY2VwdHMgdGhlIHByb2dyYW0uDQo+ID4gDQo+ID4gSSBiaXNlY3RlZCB0aGUgaXNzdWUg
ZG93biB0byB0aGlzIGNvbW1pdDoNCj4gPiDCoMKgwqDCoMKgwqDCoCBjb21taXQgOGVjZmMzNzFk
ODI5YmZlZDc1ZTBlZjJjYWI0NWIyMjkwYjk4MmY2NA0KPiA+IMKgwqDCoMKgwqDCoMKgIEF1dGhv
cjogTWF4aW0gTWlraXR5YW5za2l5IDxtYXhpbUBpc292YWxlbnQuY29tPg0KPiA+IMKgwqDCoMKg
wqDCoMKgIERhdGU6wqDCoCBNb24gSmFuIDggMjI6NTI6MDIgMjAyNCArMDIwMA0KPiA+IA0KPiA+
IMKgwqDCoMKgwqDCoMKgIGJwZjogQXNzaWduIElEIHRvIHNjYWxhcnMgb24gc3BpbGwNCj4gDQo+
IFRoaXMgY29tbWl0IHdhcyBwYXJ0IG9mIGEgc2VyaWVzIHdpdGggYSBmZXcgbmV3IGZlYXR1cmVz
IHRoYXQgYXJlDQo+IGluZGVlZCBleHBlY3RlZCB0byByYWlzZSB0aGUgY29tcGxleGl0eSB3aXRo
IHNvbWUgcHJvZ3JhbXMuIFRvDQo+IGNvbXBlbnNhdGUgZm9yIGl0LCBhIHBhdGNoIGJ5IEVkdWFy
ZCB3YXMgc3VibWl0dGVkIHdpdGhpbiB0aGUgc2FtZQ0KPiBzZXJpZXMuIENvdWxkIHlvdSBwbGVh
c2UgdGVzdCB5b3VyIHByb2dyYW0gb24gdGhpcyBrZXJuZWwgY29tbWl0Pw0KPiANCj4gNmVmYmRl
MjAwYmYzIGJwZjogSGFuZGxlIHNjYWxhciBzcGlsbCB2cyBhbGwgTUlTQyBpbiBzdGFja3NhZmUo
KQ0KVGhhdCBjb21taXQgd2FzIGluY2x1ZGVkIGluIHRoZSBjb21taXQgZnJvbSBtYXN0ZXIgdGhh
dCBJIHRlc3RlZC4NCj4gDQo+IEkuZS4gd2hldGhlciBpdCBwYXNzZXMgb3IgZmFpbHMsIGFuZCBJ
ZiBpdCBmYWlscywgd2hhdCdzIHRoZSBiaWdnZXN0DQo+IFJVTEVfTElTVF9TSVpFIHRoYXQgcGFz
c2VzLiBMZXQncyBzZWUgaWYgRWR1YXJkJ3MgcGF0Y2ggaGVscHMNCj4gcGFydGlhbGx5IG9yIGRv
ZXNuJ3QgYWRkcmVzcyB0aGlzIGlzc3VlIGF0IGFsbCAob3IgaGVscHMgZnVsbHksIGJ1dA0KPiB0
aGVyZSBpcyBhbm90aGVyIHJlZ3Jlc3Npb24gYWZ0ZXIgaGlzIGNvbW1pdCkuDQo+IA0KPiA+IEl0
J3MgbXkgdW5kZXJzdGFuZGluZyB0aGF0IGEgZUJQRiBwcm9ncmFtIHRoYXQgaXMgYWNjZXB0ZWQg
Ynkgb25lDQo+ID4gdmVyc2lvbiBvZiB0aGUgdmVyaWZpZXIgc2hvdWxkIGJlIGFjY2VwdGVkIG9u
IGFsbCBzdWJzZXF1ZW50DQo+ID4gdmVyc2lvbnMuDQo+IA0KPiBUaGF0J3MgYmFzaWNhbGx5IHRo
ZSBnb2FsLiBPYnZpb3VzbHksIHNvbWUgbmV3IGZlYXR1cmVzIHdpbGwgaW5jcmVhc2UNCj4gdGhl
IHZlcmlmaWNhdGlvbiBjb21wbGV4aXR5LCBidXQgd2UgYXJlIHRyeWluZyB0byBjb21wZW5zYXRl
IGZvciBpdA0KPiBvcg0KPiB0byBtYWtlIGl0IGluc2lnbmlmaWNhbnQuDQo+IA0KPiBGb3IgZXhh
bXBsZSwgd2hlbiBJIGludHJvZHVjZWQgbXkgY2hhbmdlcyAod2l0aCBFZHVhcmQncyBwYXRjaCks
IEkNCj4gdGVzdGVkIHRoZSBjb21wbGV4aXR5IGJlZm9yZSBhbmQgYWZ0ZXIgb24gdGhlIHNldCBv
ZiBCUEYgcHJvZ3JhbXMNCj4gdGhhdA0KPiBpbmNsdWRlZCBrZXJuZWwgc2VsZnRlc3RzIGFuZCBD
aWxpdW06DQo+IA0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L25ldGRldmJwZi9jb3Zlci8yMDI0MDEwODIwNTIwOS44Mzgz
NjUtMS1tYXh0cmFtOTVAZ21haWwuY29tL19fOyEhQm1kelMzX2xWOUhkS0c4ITBQUWNNcXJoUWkx
MVBjcmMzWEZSV2U4a3RDN09FS1RFUWFxck5KVS1CczduSVlKWkJzTEJTN1NVSmgxM25XcENBcGFa
aElBbVZyRnk4a2w5czJGVzZwdUpjVEUkDQo+IMKgDQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20v
djMvX19odHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbmV0ZGV2YnBmL2NvdmVy
LzIwMjQwMTI3MTc1MjM3LjUyNjcyNi0xLW1heHRyYW05NUBnbWFpbC5jb20vX187ISFCbWR6UzNf
bFY5SGRLRzghMFBRY01xcmhRaTExUGNyYzNYRlJXZThrdEM3T0VLVEVRYXFyTkpVLUJzN25JWUpa
QnNMQlM3U1VKaDEzbldwQ0FwYVpoSUFtVnJGeThrbDlzMkZXVzAxcjQ5WSQNCj4gwqANCj4gDQo+
IEFzIHlvdSBjYW4gc2VlLCBFZHVhcmQncyBwYXRjaCByZWFsbHkgaGVscGVkIHdpdGggbW9zdCBy
ZWdyZXNzaW9ucywNCj4gYW5kIHRoZSB3aG9sZSBwaWN0dXJlIGxvb2tlZCBnb29kIGVub3VnaC4g
QXBwYXJlbnRseSAoaWYgdGhpcyBzZXJpZXMNCj4gaXMgaW5kZWVkIHRoZSBjdWxwcml0KSwgeW91
ciBwcm9ncmFtIHVzZXMgc29tZSBwYXR0ZXJuIHRoYXQgd2Fzbid0DQo+IGNvdmVyZWQgYnkgdGhl
IHNldCBvZiBwcm9ncmFtcyB0aGF0IEkgY2hlY2tlZC4NCj4gDQo+ID4gSSdtIGludmVzdGlnYXRp
bmcgaG93IHRoaXMgY29tbWl0IGFmZmVjdHMgaG93IGluc3RydWN0aW9ucyBhcmUNCj4gPiBjb3Vu
dGVkDQo+ID4gwqBhbmQgd2h5IGl0IGxlYWRzIHRvIHN1Y2ggYSBkcmFzdGljIGNoYW5nZSBmb3Ig
dGhpcyBwYXJ0aWN1bGFyDQo+ID4gcHJvZ3JhbS4NCj4gDQo+IEknZCBndWVzcywgbW9zdCBsaWtl
bHksIHNvbWV0aGluZyBpbnNpZGUgdGhlIGxvb3AgYm9keSBiZWNhbWUgbW9yZQ0KPiBjb21wbGV4
IHRvIHZlcmlmeSwgYW5kIGl0J3MgcmVwZWF0ZWQgMzgwIHRpbWVzLCBmdXJ0aGVyIGluY3JlYXNp
bmcNCj4gdGhlDQo+IHRvdGFsIGNvbXBsZXhpdHkuDQo+IA0KPiBJIHdvbmRlciB3aGVyZSAzODAg
Y29tZXMgZnJvbS4gSXMgaXQganVzdCB0aGUgbWF4aW11bSBudW1iZXIgb2YNCj4gaXRlcmF0aW9u
cyB0aGF0IHRoZSBvbGQgdmVyaWZpZXIgY291bGQgaGFuZGxlPyBPciBkb2VzIGl0IGhhdmUgYQ0K
PiBkZWVwZXIgbWVhbmluZz8NCg0KVGhhdCdzIGl0LiBJdCB3YXMgdGhlIGxhcmdlc3QgbnVtYmVy
IG9mIGl0ZXJhdGlvbnMgdGhhdCB3YXMgYWNjZXB0ZWQgYnkNCmFsbCB0aGUga2VybmVsIHZlcmlm
aWVyIHZlcnNpb25zIHdlIHN1cHBvcnQuDQo+IA0KPiBJcyBicGZfbG9vcCBhbiBvcHRpb24gZm9y
IHlvdT8NCg0KV2UgYXJlIGV4cGxvcmluZyBuZXcgYXBwcm9hY2hlcyBmb3Igb3VyIGZ1dHVyZSBy
ZWxlYXNlcyBidXQgb3VyIHBhc3QNCnJlbGVhc2VzIGNhbid0IGJlIGNoYW5nZWQuDQo+IA0KPiA+
IEkgd2FudGVkIHRvIHNoYXJlIG15IGZpbmRpbmdzIGVhcmx5IGluIGNhc2Ugc29tZW9uZSBoYXMg
YW55IGhpbnRzDQo+ID4gZm9yIG1lLg0KPiA+IA0KPiA+IFRvIHJlcHJvZHVjZSwgdXNlIHRoZSBm
b2xsb3dpbmcgZmlsZSBhcyBhIGRyb3AgaW4gcmVwbGFjZW1lbnQgb2YNCj4gPiBsaWJicGYtYm9v
c3RyYXAncyBleGFtcGxlcy9jL3RjLmJwZi5jOg0KPiANCj4gSSByZXByb2R1Y2VkIHRoZSBpc3N1
ZSBvbiA2LjExLjYsIHRoZSBoaWdoZXN0IFJVTEVfTElTVF9TSVpFIHRoYXQNCj4gd29ya3MgZm9y
IG1lIGlzIDM1LCBidXQgSSBjdXJyZW50bHkgbGFjayB0aW1lIHRvIHRha2UgYSBkZWVwZXIgbG9v
ay4NCj4gRG8geW91IGhhdmUgYW55IG5ldyBmaW5kaW5ncyBpbiB0aGUgbWVhbndoaWxlPw0KDQpO
bywgSSBoYXZlbid0IGZvdW5kIGFueXRoaW5nIG9idmlvdXMuIE15IGN1cnJlbnQgaHlwb3RoZXNp
cyBpcyB0aGF0DQpiZWNhdXNlIHdlIG5ldyBhc3NpZ24gSURzIHdlIGxvc3Qgc29tZSBvcHBvcnR1
bml0aWVzIGZvciBzdGF0ZSBwcnVuaW5nLg0KSW4gb3RoZXIgd29yZHMsIHN0YXRlcyB0aGF0IHdl
cmUgY29uc2lkZXJlZCBpZGVudGljYWwgYmVmb3JlIHRoZSBjb21taXQNCmFyZSBub3cgY29uc2lk
ZXJlZCBkaXN0aW5jdCBiZWNhdXNlIG9mIHRoZSBJRHMgYW5kIHRodXMgY2FuJ3QgYmUNCnBydW5l
ZC4gVGhpcyBpcyBhIHdpbGQgZ3Vlc3M7IEknbSBub3QgdmVyeSBmYW1pbGlhciB3aXRoIHRoZSB2
ZXJpZmllci4NCg0KV2hhdCdzIHJlYWxseSBvZGQgaXMgaG93IGJpZyB0aGUganVtcCBpczogZnJv
bSAzODAgdG8gMzUuDQoNCkNoZWVycywNCkZyYW5jaXMNCg0K

