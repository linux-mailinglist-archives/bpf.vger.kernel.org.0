Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9356D970C
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 14:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbjDFMbg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 08:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbjDFMbf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 08:31:35 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E6F7692
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 05:31:29 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336AWv0H018009;
        Thu, 6 Apr 2023 12:31:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=GhYZlWzOhZukFAipRUN041JgtpFWnIot17ttF5EOovw=;
 b=oPbeeI1WG4JFfaHxGhdiLs7oJiReS3nT2WgKnU3yHMjyz0vxaaXiTiC6LNgApR7A/go+
 kJjCEJSHKUmdTcg8QLt3c43YMFBc/RZWj4ixUI+ZRXn0uAo2EGWm5isQuxprg8my/26S
 3AMhdhhiCMKM1c94u4TyHaGU9MWKF7pE8RKmCJ2lEYXOMly7eBx0aDNTwk9HTDqqM8H9
 A4pRTUZyf9w9uQ+urRzuq962rmVF/kjc9ScbRbK9J2DkW3E4KN+k0NWChpMpCCLWZfrO
 yBpbFrKy+SYQK38vjWeK0DuAsPxppArEa5eLt6JwuCGSWYaJSwa52yPs5gjRZq2EXYha nQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ps993d4an-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 12:31:14 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 336C8cXe013171;
        Thu, 6 Apr 2023 12:31:14 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ps993d49a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 12:31:13 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3360CYcK023064;
        Thu, 6 Apr 2023 12:31:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3ppbvfu87b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 12:31:11 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 336CV7Un45351248
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Apr 2023 12:31:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 735F320043;
        Thu,  6 Apr 2023 12:31:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA64C20040;
        Thu,  6 Apr 2023 12:31:06 +0000 (GMT)
Received: from [9.179.11.172] (unknown [9.179.11.172])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  6 Apr 2023 12:31:06 +0000 (GMT)
Message-ID: <62501084abbb6cc9492df60ff4d427a17e731fe4.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next v6] bpf: Support 64-bit pointers to kfuncs
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Stanislav Fomichev <sdf@google.com>
Date:   Thu, 06 Apr 2023 14:31:06 +0200
In-Reply-To: <ZC6UgfMdSZJ8BCT8@krava>
References: <20230405213453.49756-1-iii@linux.ibm.com>
         <ZC6UgfMdSZJ8BCT8@krava>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nRPkjZtzVTv1djnoX1ot1LTop7_Z6TOJ
X-Proofpoint-ORIG-GUID: Y7A62XZmpAcAZpkaZO2JllqcqIqDizsC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_06,2023-04-06_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 spamscore=0 priorityscore=1501 impostorscore=0 clxscore=1011 phishscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304060106
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVGh1LCAyMDIzLTA0LTA2IGF0IDExOjQ0ICswMjAwLCBKaXJpIE9sc2Egd3JvdGU6Cj4gT24g
V2VkLCBBcHIgMDUsIDIwMjMgYXQgMTE6MzQ6NTNQTSArMDIwMCwgSWx5YSBMZW9zaGtldmljaCB3
cm90ZToKPiAKPiBTTklQCj4gCj4gPiDCoAo+ID4gK2ludCBicGZfZ2V0X2tmdW5jX2FkZHIoY29u
c3Qgc3RydWN0IGJwZl9wcm9nICpwcm9nLCB1MzIgZnVuY19pZCwKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdTE2IGJ0Zl9mZF9pZHgsIHU4ICoqZnVuY19h
ZGRyKQo+ID4gK3sKPiA+ICvCoMKgwqDCoMKgwqDCoGNvbnN0IHN0cnVjdCBicGZfa2Z1bmNfZGVz
YyAqZGVzYzsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoGRlc2MgPSBmaW5kX2tmdW5jX2Rlc2Mo
cHJvZywgZnVuY19pZCwgYnRmX2ZkX2lkeCk7Cj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoIWRlc2Mp
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FRkFVTFQ7Cj4gPiAr
Cj4gPiArwqDCoMKgwqDCoMKgwqAqZnVuY19hZGRyID0gKHU4ICopZGVzYy0+YWRkcjsKPiA+ICvC
oMKgwqDCoMKgwqDCoHJldHVybiAwOwo+ID4gK30KPiA+ICsKPiA+IMKgc3RhdGljIHN0cnVjdCBi
dGYgKl9fZmluZF9rZnVuY19kZXNjX2J0ZihzdHJ1Y3QgYnBmX3ZlcmlmaWVyX2Vudgo+ID4gKmVu
diwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHMxNiBvZmZzZXQpCj4gPiDCoHsKPiA+IEBA
IC0yNjcyLDE0ICsyNjkxLDE5IEBAIHN0YXRpYyBpbnQgYWRkX2tmdW5jX2NhbGwoc3RydWN0Cj4g
PiBicGZfdmVyaWZpZXJfZW52ICplbnYsIHUzMiBmdW5jX2lkLCBzMTYgb2Zmc2V0KQo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVJTlZBTDsKPiA+IMKgwqDCoMKg
wqDCoMKgwqB9Cj4gPiDCoAo+ID4gLcKgwqDCoMKgwqDCoMKgY2FsbF9pbW0gPSBCUEZfQ0FMTF9J
TU0oYWRkcik7Cj4gPiAtwqDCoMKgwqDCoMKgwqAvKiBDaGVjayB3aGV0aGVyIG9yIG5vdCB0aGUg
cmVsYXRpdmUgb2Zmc2V0IG92ZXJmbG93cyBkZXNjLQo+ID4gPmltbSAqLwo+ID4gLcKgwqDCoMKg
wqDCoMKgaWYgKCh1bnNpZ25lZCBsb25nKShzMzIpY2FsbF9pbW0gIT0gY2FsbF9pbW0pIHsKPiA+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB2ZXJib3NlKGVudiwgImFkZHJlc3Mgb2Yg
a2VybmVsIGZ1bmN0aW9uICVzIGlzIG91dAo+ID4gb2YgcmFuZ2VcbiIsCj4gPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZ1bmNfbmFtZSk7Cj4gPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FSU5WQUw7Cj4gPiArwqDCoMKgwqDC
oMKgwqBpZiAoYnBmX2ppdF9zdXBwb3J0c19mYXJfa2Z1bmNfY2FsbCgpKSB7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY2FsbF9pbW0gPSBmdW5jX2lkOwo+ID4gK8KgwqDCoMKg
wqDCoMKgfSBlbHNlIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjYWxsX2lt
bSA9IEJQRl9DQUxMX0lNTShhZGRyKTsKPiAKPiB3ZSBjb21wdXRlIGNhbGxfaW1tIGFnYWluIGlu
IGZpeHVwX2tmdW5jX2NhbGwsIHNlZW1zIGxpa2Ugd2UgY291bGQKPiBzdG9yZQo+IHRoZSBhZGRy
ZXNzIGFuZCB0aGUgZnVuY19pZCBpbiBkZXNjIGFuZCBoYXZlIGZpeHVwX2tmdW5jX2NhbGwgZG8g
dGhlCj4gaW5zbi0+aW1tIHNldHVwCgpXZSBjYW4gZHJvcCB0aGlzIGRpZmYgaW4gZml4dXBfa2Z1
bmNfY2FsbCgpOgoKLSAgICAgICBpbnNuLT5pbW0gPSBkZXNjLT5pbW07CisgICAgICAgaWYgKCFi
cGZfaml0X3N1cHBvcnRzX2Zhcl9rZnVuY19jYWxsKCkpCisgICAgICAgICAgICAgICBpbnNuLT5p
bW0gPSBCUEZfQ0FMTF9JTU0oZGVzYy0+YWRkcik7CgppbiBvcmRlciB0byBhdm9pZCBkdXBsaWNh
dGluZyB0aGUgaW1tIGNhbGN1bGF0aW9uIGxvZ2ljLCBidXQgSSdtIG5vdApzdXJlIGlmIHdlIHdh
bnQgdG8gbW92ZSB0aGUgZW50aXJlIGRlc2MtPmltbSBzZXR1cCB0aGVyZS4KCkZvciBleGFtcGxl
LCBmaXh1cF9rZnVuY19jYWxsKCkgY29uc2lkZXJzIGtmdW5jX3RhYiBjb25zdCwgd2hpY2ggaXMg
YQpuaWNlIHByb3BlcnR5IHRoYXQgSSB0aGluayBpcyB3b3J0aCBrZWVwaW5nLgoKQW5vdGhlciBv
cHRpb24gd291bGQgYmUgdG8gZHJvcCBkZXNjLT5pbW0sIGJ1dCBoYXZpbmcgaXQgaXMgdmVyeQpj
b252ZW5pZW50IGZvciBkb2luZyBsb29rdXBzIHRoZSBzYW1lIHdheSBvbiBhbGwgYXJjaGl0ZWN0
dXJlcy4gCgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qIENoZWNrIHdoZXRo
ZXIgdGhlIHJlbGF0aXZlIG9mZnNldCBvdmVyZmxvd3MKPiA+IGRlc2MtPmltbSAqLwo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICgodW5zaWduZWQgbG9uZykoczMyKWNhbGxf
aW1tICE9IGNhbGxfaW1tKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHZlcmJvc2UoZW52LCAiYWRkcmVzcyBvZiBrZXJuZWwgZnVuY3Rpb24gJXMK
PiA+IGlzIG91dCBvZiByYW5nZVxuIiwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZ1bmNfbmFtZSk7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRUlOVkFMOwo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiA+IMKgwqDCoMKgwqDCoMKgwqB9
Cj4gPiDCoAo+ID4gKwo+IAo+IG5pdCwgZXh0cmEgbGluZQoKT3VjaC4gVGhhbmtzIGZvciBzcG90
dGluZyB0aGlzLgoKPiAKPiA+IMKgwqDCoMKgwqDCoMKgwqBpZiAoYnBmX2Rldl9ib3VuZF9rZnVu
Y19pZChmdW5jX2lkKSkgewo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBlcnIg
PSBicGZfZGV2X2JvdW5kX2tmdW5jX2NoZWNrKCZlbnYtPmxvZywKPiA+IHByb2dfYXV4KTsKPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGVycikKPiA+IEBAIC0yNjkwLDYg
KzI3MTQsNyBAQCBzdGF0aWMgaW50IGFkZF9rZnVuY19jYWxsKHN0cnVjdAo+ID4gYnBmX3Zlcmlm
aWVyX2VudiAqZW52LCB1MzIgZnVuY19pZCwgczE2IG9mZnNldCkKPiA+IMKgwqDCoMKgwqDCoMKg
wqBkZXNjLT5mdW5jX2lkID0gZnVuY19pZDsKPiA+IMKgwqDCoMKgwqDCoMKgwqBkZXNjLT5pbW0g
PSBjYWxsX2ltbTsKPiA+IMKgwqDCoMKgwqDCoMKgwqBkZXNjLT5vZmZzZXQgPSBvZmZzZXQ7Cj4g
PiArwqDCoMKgwqDCoMKgwqBkZXNjLT5hZGRyID0gYWRkcjsKPiA+IMKgwqDCoMKgwqDCoMKgwqBl
cnIgPSBidGZfZGlzdGlsbF9mdW5jX3Byb3RvKCZlbnYtPmxvZywgZGVzY19idGYsCj4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZnVuY19wcm90bywgZnVuY19uYW1lLAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZk
ZXNjLT5mdW5jX21vZGVsKTsKPiA+IEBAIC0yNjk5LDE5ICsyNzI0LDE5IEBAIHN0YXRpYyBpbnQg
YWRkX2tmdW5jX2NhbGwoc3RydWN0Cj4gPiBicGZfdmVyaWZpZXJfZW52ICplbnYsIHUzMiBmdW5j
X2lkLCBzMTYgb2Zmc2V0KQo+ID4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiBlcnI7Cj4gPiDCoH0K
PiA+IMKgCj4gPiAtc3RhdGljIGludCBrZnVuY19kZXNjX2NtcF9ieV9pbW0oY29uc3Qgdm9pZCAq
YSwgY29uc3Qgdm9pZCAqYikKPiA+ICtzdGF0aWMgaW50IGtmdW5jX2Rlc2NfY21wX2J5X2ltbV9v
ZmYoY29uc3Qgdm9pZCAqYSwgY29uc3Qgdm9pZCAqYikKPiA+IMKgewo+ID4gwqDCoMKgwqDCoMKg
wqDCoGNvbnN0IHN0cnVjdCBicGZfa2Z1bmNfZGVzYyAqZDAgPSBhOwo+ID4gwqDCoMKgwqDCoMKg
wqDCoGNvbnN0IHN0cnVjdCBicGZfa2Z1bmNfZGVzYyAqZDEgPSBiOwo+ID4gwqAKPiA+IC3CoMKg
wqDCoMKgwqDCoGlmIChkMC0+aW1tID4gZDEtPmltbSkKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqByZXR1cm4gMTsKPiA+IC3CoMKgwqDCoMKgwqDCoGVsc2UgaWYgKGQwLT5pbW0g
PCBkMS0+aW1tKQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtMTsK
PiA+ICvCoMKgwqDCoMKgwqDCoGlmIChkMC0+aW1tICE9IGQxLT5pbW0pCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIGQwLT5pbW0gPCBkMS0+aW1tID8gLTEgOiAxOwo+
ID4gK8KgwqDCoMKgwqDCoMKgaWYgKGQwLT5vZmZzZXQgIT0gZDEtPm9mZnNldCkKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gZDAtPm9mZnNldCA8IGQxLT5vZmZzZXQg
PyAtMSA6IDE7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7Cj4gPiDCoH0KPiA+IMKgCj4g
Cj4gU05JUAo+IAo+ID4gKy8qIHJlcGxhY2UgYSBnZW5lcmljIGtmdW5jIHdpdGggYSBzcGVjaWFs
aXplZCB2ZXJzaW9uIGlmIG5lY2Vzc2FyeQo+ID4gKi8KPiA+ICtzdGF0aWMgdm9pZCBmaXh1cF9r
ZnVuY19kZXNjKHN0cnVjdCBicGZfdmVyaWZpZXJfZW52ICplbnYsCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBicGZfa2Z1
bmNfZGVzYyAqZGVzYykKPiA+ICt7Cj4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgYnBmX3Byb2cg
KnByb2cgPSBlbnYtPnByb2c7Cj4gPiArwqDCoMKgwqDCoMKgwqB1MzIgZnVuY19pZCA9IGRlc2Mt
PmZ1bmNfaWQ7Cj4gPiArwqDCoMKgwqDCoMKgwqB1MTYgb2Zmc2V0ID0gZGVzYy0+b2Zmc2V0Owo+
ID4gK8KgwqDCoMKgwqDCoMKgYm9vbCBzZWVuX2RpcmVjdF93cml0ZTsKPiA+ICvCoMKgwqDCoMKg
wqDCoHZvaWQgKnhkcF9rZnVuYzsKPiA+ICvCoMKgwqDCoMKgwqDCoGJvb2wgaXNfcmRvbmx5Owo+
ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKGJwZl9kZXZfYm91bmRfa2Z1bmNfaWQoZnVuY19p
ZCkpIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB4ZHBfa2Z1bmMgPSBicGZf
ZGV2X2JvdW5kX3Jlc29sdmVfa2Z1bmMocHJvZywKPiA+IGZ1bmNfaWQpOwo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICh4ZHBfa2Z1bmMpIHsKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGVzYy0+YWRkciA9ICh1bnNpZ25lZCBs
b25nKXhkcF9rZnVuYzsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmV0dXJuOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKiBmYWxsYmFjayB0byBkZWZhdWx0IGtm
dW5jIHdoZW4gbm90IHN1cHBvcnRlZCBieQo+ID4gbmV0ZGV2ICovCj4gPiArwqDCoMKgwqDCoMKg
wqB9Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAob2Zmc2V0KQo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybjsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChm
dW5jX2lkID09IHNwZWNpYWxfa2Z1bmNfbGlzdFtLRl9icGZfZHlucHRyX2Zyb21fc2tiXSkKPiA+
IHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzZWVuX2RpcmVjdF93cml0ZSA9
IGVudi0+c2Vlbl9kaXJlY3Rfd3JpdGU7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgaXNfcmRvbmx5ID0gIW1heV9hY2Nlc3NfZGlyZWN0X3BrdF9kYXRhKGVudiwgTlVMTCwKPiA+
IEJQRl9XUklURSk7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYg
KGlzX3Jkb25seSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgZGVzYy0+YWRkciA9ICh1bnNpZ25lZAo+ID4gbG9uZylicGZfZHlucHRyX2Zyb21fc2ti
X3Jkb25seTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKiByZXN0
b3JlIGVudi0+c2Vlbl9kaXJlY3Rfd3JpdGUgdG8gaXRzIG9yaWdpbmFsCj4gPiB2YWx1ZSwgc2lu
Y2UKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBtYXlfYWNjZXNzX2RpcmVj
dF9wa3RfZGF0YSBtdXRhdGVzIGl0Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICovCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZW52LT5zZWVuX2RpcmVjdF93
cml0ZSA9IHNlZW5fZGlyZWN0X3dyaXRlOwo+ID4gK8KgwqDCoMKgwqDCoMKgfQo+IAo+IGNvdWxk
IHdlIGRvIHRoaXMgZGlyZWN0bHkgaW4gYWRkX2tmdW5jX2NhbGw/CgpJbml0aWFsbHkgSSB0aG91
Z2h0IHRoYXQgaXQgd2Fzbid0IHBvc3NpYmxlLCBiZWNhdXNlCm1heV9hY2Nlc3NfZGlyZWN0X3Br
dF9kYXRhKCkgbWF5IGRlcGVuZCBvbiBkYXRhIGdhdGhlcmVkIGR1cmluZwp2ZXJpZmljYXRpb24u
IEJ1dCBvbiBhIHNlY29uZCBsb29rIHRoYXQncyBzaW1wbHkgbm90IHRoZSBjYXNlLCBzbyB0aGlz
CmNvZGUgY2FuIGluZGVlZCBiZSBtb3ZlZCB0byBhZGRfa2Z1bmNfY2FsbCgpLgoKPiAKPiB0aGFu
a3MsCj4gamlya2EKClsuLi5dCg==

