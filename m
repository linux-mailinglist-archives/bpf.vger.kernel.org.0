Return-Path: <bpf+bounces-59678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF686ACE5C2
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 22:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080F5189A71F
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 20:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D410F1EB5C2;
	Wed,  4 Jun 2025 20:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="rEFzY9e6"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67C5339A1
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 20:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749068954; cv=none; b=hsDo8ypUyPsHBlAOYVQ5w+DDgrABDGOhSSiPydticbWrONWMtL9rk1stGIaPq/4SqI1PPJGdoe6FueIuZ5VVBZirDCGWUYeSkI2sJ5o+/ETqt10jtI5DkU4xtpVHA49dlX0pvyMMD+a6rbPwR4ifIR3nsff2OaPRMzf99cUfnQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749068954; c=relaxed/simple;
	bh=0uii7h7FZ1NVWJ6MjZE1CWqnpQer1aZIP2TNrTuzQgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aCGFpKBjpHcVsia2mQdv9MZCIka++bgvlDXfrloi9goKKxv5WV9+IhaVSNa/r62FXC5LI6+y49DO9prwILCpaOzO+27gj5tACzcY5nRMDwZcgvrxI0FmwiV7o3YWlCpmmeDR7TcV8LfJFwg1Ke3VG4X3iIIGnVqDqsPFN+SaW5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=rEFzY9e6; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554H8T7Q011480;
	Wed, 4 Jun 2025 20:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=0uii7h7FZ1NVWJ6MjZE1CWqnpQer1aZIP2TNrTuzQgE=; b=rEFz
	Y9e6+5tTCySpxuQQvVfrdiTos+j+vzUv1jwBZSktrIg03+waVtEwdyPZDv5tUuCX
	FgEpUnzvr4bFk0VSJvVBz+AtEgEtDvXo9+HXFumT6m8Qwe7ZmY/q3QkOnHNdvW37
	0+FewcRkp7Jo9ismnqHgrtGPSTMjhioA/1674R+L3rdsqYFfI0yT6iFdgjxFcTEc
	14NdetzjELyIJ+XoRdvNAe2brUHjfUduTDoeIQps7nYangt88Havr8c2k1y7bP7Y
	6JhMl8YPRLLK2sWd8hatpr7gJeAfaBmvyVhm8YdYQ1TUHJzCoV3LGeDfDJtHxqmB
	R7vrxbFeku8shHRJ4Q==
Received: from mail.crowdstrike.com (74-209-223-77.static.ash01.latisys.net [74.209.223.77] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4728uccfje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 20:29:03 +0000 (GMT)
Received: from [10.82.59.34] (10.100.11.122) by 03WPEXCH010.crowdstrike.sys
 (10.80.52.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Jun 2025
 20:29:00 +0000
Message-ID: <8b53b900-a0cc-4373-b005-b47b7199566f@crowdstrike.com>
Date: Wed, 4 Jun 2025 16:28:59 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: Bad vmalloc address during BPF hooks unload
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: Jiri Olsa <olsajiri@gmail.com>, bpf <bpf@vger.kernel.org>,
        <joe.kimpel@crowdstrike.com>,
        Mark Fontana <mark.fontana@crowdstrike.com>,
        Viktor Malik <vmalik@redhat.com>
References: <6947880c-a749-438f-bfcb-91afe7238d7e@crowdstrike.com>
 <aD9vDX0boYLzvibc@krava>
 <7831ec6d-8d5c-4fc1-9bd9-1b0dfc93eb16@crowdstrike.com>
 <CAADnVQKONAkX8G2qXYS8gBVKq52gn4Pb39x_3fRi0EetVPT3jw@mail.gmail.com>
Content-Language: en-US
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
In-Reply-To: <CAADnVQKONAkX8G2qXYS8gBVKq52gn4Pb39x_3fRi0EetVPT3jw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: base64
X-ClientProxiedBy: 04WPEXCH016.crowdstrike.sys (10.100.11.68) To
 03WPEXCH010.crowdstrike.sys (10.80.52.162)
X-Disclaimer: USA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDE2MyBTYWx0ZWRfXygcPXinvjtsn
 UQGl9LnzZrj+mHqyVBxG83rK5+rK3orGLAT5DOPfqjsDX35oLFKgP/xqztqHF4O3Jg6TWsExSUj
 CgzoVlgc8SHrsP883IjmfAetQMPTIrleQeIRGHV5gWVV1q92KEzNygFE6b/oZ0Hs6Bm0i9nOKhU
 ZZcffrM5Z9q4443n3uKId+3JNud0TQaIHbOZe7PNhIUnVtRMjZLTy0U8CzkFG5uQGziKXmhCrDa
 1ct9ElMsVR4F7rXrhy554/k2JZeSxzgUvFP1pbfBwOn9gnKaw04Ig/EfFeXY29RhfCEJNbVl2TB
 LhvdB+n+acso05u8E0+J9RTiUbAHS0zbeYXWpqw4ZXStdBELCkYQFU++/EVRnbFm2b75ZOO0JtI
 vjSxFsTpMdjTvI7YTbJ1PMmU9ozXX+Hq0AIpTVw42XXh7zl37agJCqBTw9nbBqPw6semg34s
X-Authority-Analysis: v=2.4 cv=UJbdHDfy c=1 sm=1 tr=0 ts=6840ac8f cx=c_pps
 a=gZx6DIAxr9wtOoIAvRqG0Q==:117 a=gZx6DIAxr9wtOoIAvRqG0Q==:17
 a=EjBHVkixTFsA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=pl6vuDidAAAA:8
 a=IQLERqfcJWVY-AbuucoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: VfxM04-0yxSjuEET6lZScoJTthik6Ao5
X-Proofpoint-ORIG-GUID: VfxM04-0yxSjuEET6lZScoJTthik6Ao5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=906 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506040163

T24gNi80LzI1IDE1OjM3LCBBbGV4ZWkgU3Rhcm92b2l0b3Ygd3JvdGU6DQo+IE9uIFdlZCwg
SnVuIDQsIDIwMjUgYXQgNzo0OeKAr0FNIEFuZHJleSBHcm9kem92c2t5DQo+IDxhbmRyZXku
Z3JvZHpvdnNreUBjcm93ZHN0cmlrZS5jb20+IHdyb3RlOg0KPj4gT24gNi8zLzI1IDE3OjU0
LCBKaXJpIE9sc2Egd3JvdGU6DQo+Pj4gT24gVHVlLCBKdW4gMDMsIDIwMjUgYXQgMDQ6MTM6
MThQTSAtMDQwMCwgQW5kcmV5IEdyb2R6b3Zza3kgd3JvdGU6DQo+Pj4+IEhpLCB3ZSBvYnNl
cnZlIGJlbGxvdyByYW5kb20gd2FybmluZyBvY2Nhc2lvbmFsbHkgZHVyaW5nIEJQRiBob29r
cyB1bmxvYWQsDQo+Pj4+IHdlIG9ubHkgc2VlIGl0IG9uIHJoZWw4IGtlcm5lbHMgcmFuZ2lu
ZyBmcm9tIDguNi04LjEwIHNvIGl0IG1pZ2h0IGJlDQo+Pj4+IHNvbWV0aGluZyBSSEVMIHNw
ZWNpZmljIGFuZCBub3QgdXBzdHJlYW0gaXNzdWVzLCBpIHN0aWxsIHdhcyBob3BpbmcgdG8g
Z2V0DQo+Pj4+IHNvbWUgYWR2aXNlIG9yIGNsdWVzIGZyb20gQlBGIGV4cGVydHMgaGVyZS4N
Cj4+PiBoaSwNCj4+PiB1bmxlc3MgeW91IHJlcHJvZHVjZSBvbiB1cHN0cmVhbSBvciBzb21l
IHN0YWJsZSBrZXJuZWwgSSdtIGFmcmFpZCB0aGVyZSdzIG5vdA0KPj4+IG11Y2ggdGhhdCBj
YW4gYmUgZG9uZSBpbiBoZXJlDQo+Pj4NCj4+PiBqaXJrYQ0KPj4NCj4+IFRoYW5rcyBKaXJp
LCB5ZXMsIGkgdW5kZXJzdGFuZCB0aGUgbGltaXRhdGlvbnMgc2luY2UgdGhpcyBtaWdodCBi
ZSBhDQo+PiByZXN1bHQgb2Ygc29tZQ0KPj4gUkhFTCBrZXJuZWwgdHJlZSBzcGVjaWZpYyBi
YWQgcGF0Y2hlcyBjaGVycnktcGlraW5nL21lcmdlIGZyb20gdXBzdHJlYW0NCj4+IGludG8g
dGhlaXIgb3duIHRyZWVzLiBJIHdhcw0KPj4ganVzdCBob3BwaW5nIHRoYXQgdGhpcyByaW5n
cyBhbnkgYmVsbHMgdG8gYW55b25lIGluIHRoZSBFLUJQRiBjb21tdW5pdHkNCj4+IGFzIGl0
IHR1cm5zDQo+PiB0byBiZSByZWFsbHkgaGFyZCB0byByZXBybyBhbmQgaGVuY2UgYWxzbyB0
byBiaXNlY3QuDQo+IEkgZG9uJ3QgcmVtZW1iZXIgc2VlaW5nIHNwbGF0IGxpa2UgdGhpcy4N
Cj4NCj4gQWxzbyBtbS92bWFsbG9jLmM6MzMwIHRlbGxzIHVzIG5vdGhpbmcuDQo+IEl0J3Mg
bm90IGNsZWFyIHdoYXQgdm1hbGxvY190b19wYWdlKCkgaXMgY29tcGxhaW5pbmcgYWJvdXQu
DQo+IEknbSBndWVzc2luZyB0aGF0IGl0J3Mgbm90IGEgdm1hbGxvYyBhZGRyZXNzID8NCg0K
IEZyb20gbG9va2luZyBhdCB0aGUgcmVsZXZhbnQgUkhFTCBrZXJuZWwgc291cmNlIHRyZWUg
aSBzZWUgdGhhdCANCm1tL3ZtYWxsb2MuYzozMzAgbWFwcyB0byBXQVJOX09OX09OQ0UocG1k
X2JhZCgqcG1kKSk7IFNvIGl0IHBhc3NlZCB0aGUgDQpwdWRfYmFkIGNoZWNrIHJpZ2h0IGJl
Zm9yZSB0aGF0IGJ1dCBmYWlsZWQgb24gdGhpcyBvbmUuIFRoZSBSSEVMIA0KZnVuY3Rpb24g
aXMgaWRlbnRpY2FsIHRvIHRoZSB1cHN0cmVhbSBzdGFnaW5nIHY0LjE4L3NvdXJjZS9tbS92
bWFsbG9jLmMgDQotIHZtYWxsb2NfdG9fcGFnZSgpDQoNCkluIGFueSBjYXNlLCB0aGFua3Mg
Zm9yIHlvdXIgYWR2aXNlIGFuZCBzdXBwb3J0LCBJIHdpbGwgdHJ5IHRvIGZvbGxvdyB1cCAN
CndpdGggUkhFTCBrZXJuZWwgdGVhbSBhbmQgcG9zc2libHkNClZpY3RvciBoZXJlIGZyb20g
UmVkaGF0IGNhbiBnaXZlIG1lIHNvbWUgcG9pbnRlciB3aG8gdG8gYXBwcm9hY2ggZm9yIA0K
dGhpcyBmcm9tIFJlZGhhdCA/DQoNCkFuZHJleQ0KDQo+IFdoaWNoIHdvdWxkIG1lYW4gdGhh
dCBpbS0+aXBfYWZ0ZXJfY2FsbCBwb2ludHMgc29tZXdoZXJlIHdyb25nLg0KPiBBbmQgd2h5
IHdvdWxkIHRoYXQgYmUgc3BvcmFkaWMgaXMgYW55Ym9keSdzIGd1ZXNzLg0KDQoNCg==

