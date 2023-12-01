Return-Path: <bpf+bounces-16385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF2E800D79
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 15:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58BA5B212A8
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 14:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FE425541;
	Fri,  1 Dec 2023 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MAJKmm7P"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9ED4D6C
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 06:40:54 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1EeOAK032737;
	Fri, 1 Dec 2023 14:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=2ZvMr38UTQSlW05O40ou7eqAcgOr36AG6FUvjGXGOMU=;
 b=MAJKmm7Pg6xZlv/uWPpb1qNHR6xQ+eUi3UuM1FPejkf9TE7eeauGMSMXN2mi2oYPXsQj
 vPB4hZE+Z/tkRw4mmUt3g1NMDrIu5Fb25HEpE9Ex3UZfXp16y86Cx66sUH8EJdZnxPSG
 RIqXENekKjEJhLjsZdQxJrqqGzZm/i/ISL0KtKYldxA/7/vi/MTjE9tBO1L3OuUe7gOr
 BNv8OjpAY0ynJcw9dKsTjGhaYEOr011L9ZmvAzVZUZUeZQhUlZUKjofd5uwFfyG8dQ5M
 BTXBeIB3UFbUoDOK3jClWn6UISlH9SXlB29O6aXiVPsY8ZGWtwhdMEiczYBEibkn6Mv4 mw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uqh8rg9wu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Dec 2023 14:40:31 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B1EQpFT024196;
	Fri, 1 Dec 2023 14:40:30 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uqh8rg94n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Dec 2023 14:40:29 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1Djr1P002651;
	Fri, 1 Dec 2023 14:36:29 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukv8p5j0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Dec 2023 14:36:29 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B1EaRgS27984240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Dec 2023 14:36:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35C3620043;
	Fri,  1 Dec 2023 14:36:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA03720040;
	Fri,  1 Dec 2023 14:36:26 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Dec 2023 14:36:26 +0000 (GMT)
Message-ID: <59c3a7732d729c36c4134fc47723042e3bdafada.camel@linux.ibm.com>
Subject: Re: [PATCHv2 bpf 1/2] bpf: Add checkip argument to
 bpf_arch_text_poke
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu
 <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend
 <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Stanislav
 Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Xu Kuohai
 <xukuohai@huawei.com>,
        Will Deacon <will@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>,
        Pu Lehui <pulehui@huawei.com>,
        =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Lee Jones
 <lee@kernel.org>
Date: Fri, 01 Dec 2023 15:36:26 +0100
In-Reply-To: <20231128092850.1545199-2-jolsa@kernel.org>
References: <20231128092850.1545199-1-jolsa@kernel.org>
	 <20231128092850.1545199-2-jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: W4zWhAdBwOIBRyLONIg92-UlEx6w_c6a
X-Proofpoint-GUID: OLWfVbv9cDgNS643JNcj1fAQfZx8Gcd3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_12,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=879
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2312010101

T24gVHVlLCAyMDIzLTExLTI4IGF0IDEwOjI4ICswMTAwLCBKaXJpIE9sc2Egd3JvdGU6Cj4gV2Ug
bmVlZCB0byBiZSBhYmxlIHRvIHNraXAgaXAgYWRkcmVzcyBjaGVjayBmb3IgY2FsbGVyIGluIGZv
bGxvd2luZwo+IGNoYW5nZXMuIEFkZGluZyBjaGVja2lwIGFyZ3VtZW50IHRvIGFsbG93IHRoYXQu
Cj4gCj4gU2lnbmVkLW9mZi1ieTogSmlyaSBPbHNhIDxqb2xzYUBrZXJuZWwub3JnPgo+IC0tLQo+
IMKgYXJjaC9hcm02NC9uZXQvYnBmX2ppdF9jb21wLmPCoMKgIHzCoCAzICsrLQo+IMKgYXJjaC9y
aXNjdi9uZXQvYnBmX2ppdF9jb21wNjQuYyB8wqAgNSArKystLQo+IMKgYXJjaC9zMzkwL25ldC9i
cGZfaml0X2NvbXAuY8KgwqDCoCB8wqAgMyArKy0KPiDCoGFyY2gveDg2L25ldC9icGZfaml0X2Nv
bXAuY8KgwqDCoMKgIHwgMjQgKysrKysrKysrKysrKy0tLS0tLS0tLS0tCj4gwqBpbmNsdWRlL2xp
bnV4L2JwZi5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyICstCj4gwqBrZXJuZWwvYnBm
L2FycmF5bWFwLmPCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgOCArKysrLS0tLQo+IMKga2VybmVs
L2JwZi9jb3JlLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyICstCj4gwqBrZXJu
ZWwvYnBmL3RyYW1wb2xpbmUuY8KgwqDCoMKgwqDCoMKgwqAgfCAxMiArKysrKystLS0tLS0KPiDC
oDggZmlsZXMgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKSwgMjcgZGVsZXRpb25zKC0pCgpbLi4u
XQoKPiAtLS0gYS9hcmNoL3g4Ni9uZXQvYnBmX2ppdF9jb21wLmMKPiArKysgYi9hcmNoL3g4Ni9u
ZXQvYnBmX2ppdF9jb21wLmMKPiBAQCAtNDM1LDE5ICs0MzUsMjEgQEAgc3RhdGljIGludCBfX2Jw
Zl9hcmNoX3RleHRfcG9rZSh2b2lkICppcCwgZW51bQo+IGJwZl90ZXh0X3Bva2VfdHlwZSB0LAo+
IMKgfQo+IMKgCj4gwqBpbnQgYnBmX2FyY2hfdGV4dF9wb2tlKHZvaWQgKmlwLCBlbnVtIGJwZl90
ZXh0X3Bva2VfdHlwZSB0LAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgdm9pZCAqb2xkX2FkZHIsIHZvaWQgKm5ld19hZGRyKQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdm9pZCAqb2xkX2FkZHIsIHZvaWQgKm5ld19hZGRy
LCBib29sIGNoZWNraXApCj4gwqB7Cj4gLcKgwqDCoMKgwqDCoMKgaWYgKCFpc19rZXJuZWxfdGV4
dCgobG9uZylpcCkgJiYKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqAgIWlzX2JwZl90ZXh0X2FkZHJl
c3MoKGxvbmcpaXApKQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKiBCUEYgcG9r
aW5nIGluIG1vZHVsZXMgaXMgbm90IHN1cHBvcnRlZCAqLwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqByZXR1cm4gLUVJTlZBTDsKPiArwqDCoMKgwqDCoMKgwqBpZiAoY2hlY2tpcCkg
ewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoIWlzX2tlcm5lbF90ZXh0KChs
b25nKWlwKSAmJgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIWlzX2Jw
Zl90ZXh0X2FkZHJlc3MoKGxvbmcpaXApKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgLyogQlBGIHBva2luZyBpbiBtb2R1bGVzIGlzIG5vdCBzdXBwb3J0
ZWQgKi8KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJl
dHVybiAtRUlOVkFMOwo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgLyoKPiAtwqDCoMKgwqDCoMKgwqAg
KiBTZWUgZW1pdF9wcm9sb2d1ZSgpLCBmb3IgSUJUIGJ1aWxkcyB0aGUgdHJhbXBvbGluZSBob29r
IGlzCj4gcHJlY2VkZWQKPiAtwqDCoMKgwqDCoMKgwqAgKiB3aXRoIGFuIEVOREJSIGluc3RydWN0
aW9uLgo+IC3CoMKgwqDCoMKgwqDCoCAqLwo+IC3CoMKgwqDCoMKgwqDCoGlmIChpc19lbmRicigq
KHUzMiAqKWlwKSkKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaXAgKz0gRU5EQlJf
SU5TTl9TSVpFOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKgo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBTZWUgZW1pdF9wcm9sb2d1ZSgpLCBmb3IgSUJUIGJ1
aWxkcyB0aGUgdHJhbXBvbGluZQo+IGhvb2sgaXMgcHJlY2VkZWQKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICogd2l0aCBhbiBFTkRCUiBpbnN0cnVjdGlvbi4KPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGlmIChpc19lbmRicigqKHUzMiAqKWlwKSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGlwICs9IEVOREJSX0lOU05fU0laRTsKCkRvIHdlIHJlYWxseSB3
YW50IHRvIHNraXAgdGhlIElQIGFkanVzdG1lbnQgdG9vPwoKPiArwqDCoMKgwqDCoMKgwqB9Cj4g
wqAKPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIF9fYnBmX2FyY2hfdGV4dF9wb2tlKGlwLCB0LCBv
bGRfYWRkciwgbmV3X2FkZHIpOwo+IMKgfQoKWy4uLl0K


