Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B9E67E391
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 12:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjA0Lid (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 06:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbjA0Lic (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 06:38:32 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CE462240
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 03:38:04 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RB9WRY026743;
        Fri, 27 Jan 2023 11:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=PTjADg7m27BCig0NX/Srii3XTsu0HcNg3AdhBaiCLf0=;
 b=F4yrwJDprna+VtID+XA8YJmOGFHxh+UHlmdZf6Pt1UJSa9P4L/AXV8/gE/AlfGJ9WphA
 5lmyjMiflejSM7mKO9WTqVPzNEo6vp1AVOo1bTXprS5982fc+M+ppqiPm40tMu3Q3s5W
 UN2qCf89diESL8Sg1Zq7FHUN9SMXiGCvURRE3n9lxp5mTzmw2G1pzSfy1ruA3tzG7xfu
 hJG6gj1o1+7NnjmZfWalYNYeTiamwR3iuOgTUjobUoZATutuT24mChnYQMXWmjolUQ8n
 dfTYzCx1QYqu7M7+wLRg4kCBOEISq/SA1+yxOT9Zfq6t8b6Fmt80ypqLv4ig38RegEuB ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncb55uth8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 11:36:39 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30RBQx9P009758;
        Fri, 27 Jan 2023 11:36:39 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncb55utgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 11:36:39 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30R5XXWM026670;
        Fri, 27 Jan 2023 11:36:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3n87p6ffnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 11:36:37 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30RBaX7Q19136800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 11:36:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7506320040;
        Fri, 27 Jan 2023 11:36:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA28220043;
        Fri, 27 Jan 2023 11:36:32 +0000 (GMT)
Received: from [9.179.11.57] (unknown [9.179.11.57])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jan 2023 11:36:32 +0000 (GMT)
Message-ID: <2dd35469c9df5d6ab81d798467e13eab82b1d254.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 24/24] s390/bpf: Implement
 bpf_jit_supports_kfunc_call()
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Fri, 27 Jan 2023 12:36:32 +0100
In-Reply-To: <20230126012812.vqg3oktknpnvvssf@macbook-pro-6.dhcp.thefacebook.com>
References: <20230125213817.1424447-1-iii@linux.ibm.com>
         <20230125213817.1424447-25-iii@linux.ibm.com>
         <20230126012812.vqg3oktknpnvvssf@macbook-pro-6.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nvFXQAorlqvO5kFPpHiUNdNwYoqA3B7A
X-Proofpoint-ORIG-GUID: SGhVJ5SVmS8g84toSdCMEKXGsF3nvLJq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_06,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 priorityscore=1501 phishscore=0 mlxscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270109
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gV2VkLCAyMDIzLTAxLTI1IGF0IDE3OjI4IC0wODAwLCBBbGV4ZWkgU3Rhcm92b2l0b3Ygd3Jv
dGU6Cj4gT24gV2VkLCBKYW4gMjUsIDIwMjMgYXQgMTA6Mzg6MTdQTSArMDEwMCwgSWx5YSBMZW9z
aGtldmljaCB3cm90ZToKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAv
KiBTaWduLWV4dGVuZCB0aGUga2Z1bmMgYXJndW1lbnRzLiAqLwo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGlmIChpbnNuLT5zcmNfcmVnID09IEJQRl9QU0VVRE9fS0ZVTkNfQ0FM
TCkgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBt
ID0gYnBmX2ppdF9maW5kX2tmdW5jX21vZGVsKGZwLCBpbnNuKTsKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKCFtKQo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJu
IC0xOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBmb3IgKGogPSAwOyBqIDwgbS0+bnJfYXJnczsgaisrKSB7Cj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoc2ln
bl9leHRlbmQoaml0LCBCUEZfUkVHXzEgKyBqLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBtLT5hcmdfc2l6ZVtqXSwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgbS0+YXJnX2ZsYWdzW2pdKSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqByZXR1cm4gLTE7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoH0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gCj4gSXMgdGhp
cyBiZWNhdXNlIHMzOTAgZG9lc24ndCBoYXZlIHN1YnJlZ2lzdGVycz8KPiBDb3VsZCB5b3UgZ2l2
ZSBhbiBleGFtcGxlIHdoZXJlIGl0J3MgbmVjZXNzYXJ5Pwo+IEknbSBndWVzc2luZyBhIGJwZiBw
cm9nIGNvbXBpbGVkIHdpdGggYWx1MzIgYW5kIG9wZXJhdGVzIG9uIHNpZ25lZAo+IGludAo+IHRo
YXQgaXMgcGFzc2VkIGludG8gYSBrZnVuYyB0aGF0IGV4cGVjdHMgJ2ludCcgaW4gNjQtYml0IHJl
Zz8KClByZWNpc2VseS4gVGhlIHRlc3QgYWRkZWQgaW4gMTMvMjQgZmFpbHMgd2l0aG91dCB0aGlz
OgoKdmVyaWZ5X3N1Y2Nlc3M6UEFTUzpza2VsIDAgbnNlYyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIAp2ZXJpZnlfc3VjY2VzczpQQVNTOmJwZl9vYmplY3RfX2ZpbmRfcHJv
Z3JhbV9ieV9uYW1lIDAgbnNlYyAgICAgICAgICAgCnZlcmlmeV9zdWNjZXNzOlBBU1M6a2Z1bmNf
Y2FsbF90ZXN0NCAwIG5zZWMgICAgICAgICAgICAgICAgICAgICAgICAgICAKdmVyaWZ5X3N1Y2Nl
c3M6RkFJTDpyZXR2YWwgdW5leHBlY3RlZCByZXR2YWw6IGFjdHVhbCA0Mjk0OTY2MDY1ICE9CmV4
cGVjdGVkIC0xMjM0ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAKIzk0LzEwICAga2Z1bmNfY2FsbC9rZnVuY19jYWxsX3Rlc3Q0OkZBSUwgICAg
ICAgICAgICAgICAgICAgIAoKTG9va2luZyBhdCB0aGUgYXNzZW1ibHk6Cgo7IGxvbmcgbm9pbmxp
bmUgYnBmX2tmdW5jX2NhbGxfdGVzdDQoc2lnbmVkIGNoYXIgYSwgc2hvcnQgYiwgaW50IGMsCmxv
bmcgZCkKMDAwMDAwMDAwMDkzNmE3OCA8YnBmX2tmdW5jX2NhbGxfdGVzdDQ+OgogIDkzNmE3ODog
ICAgICAgYzAgMDQgMDAgMDAgMDAgMDAgICAgICAgamdub3AgICA5MzZhNzgKPGJwZl9rZnVuY19j
YWxsX3Rlc3Q0Pgo7IAlyZXR1cm4gKGxvbmcpYSArIChsb25nKWIgKyAobG9uZyljICsgZDsKICA5
MzZhN2U6ICAgICAgIGI5IDA4IDAwIDQ1ICAgICAgICAgICAgIGFnciAgICAgJXI0LCVyNQogIDkz
NmE4MjogICAgICAgYjkgMDggMDAgNDMgICAgICAgICAgICAgYWdyICAgICAlcjQsJXIzCiAgOTM2
YTg2OiAgICAgICBiOSAwOCAwMCAyNCAgICAgICAgICAgICBhZ3IgICAgICVyMiwlcjQKICA5MzZh
OGE6ICAgICAgIGMwIGY0IDAwIDFlIDNiIDI3ICAgICAgIGpnICAgICAgY2ZlMGQ4CjxfX3MzOTBf
aW5kaXJlY3RfanVtcF9yMTQ+CgpBcyBwZXIgdGhlIHMzOTB4IEFCSSwgYnBmX2tmdW5jX2NhbGxf
dGVzdDQoKSBoYXMgdGhlIHJpZ2h0IHRvIGFzc3VtZQp0aGF0IGEsIGIgYW5kIGMgYXJlIHNpZ24t
ZXh0ZW5kZWQgYnkgdGhlIGNhbGxlciwgd2hpY2ggcmVzdWx0cyBpbiB1c2luZwo2NC1iaXQgYWRk
aXRpb25zIChhZ3IpIHdpdGhvdXQgYW55IGFkZGl0aW9uYWwgY29udmVyc2lvbnMuCgpPbiB0aGUg
SklUZWQgY29kZSBzaWRlICh3aXRob3V0IHRoaXMgaHVuaykgd2UgaGF2ZToKCjsgdG1wID0gYnBm
X2tmdW5jX2NhbGxfdGVzdDQoLTMsIC0zMCwgLTIwMCwgLTEwMDApOwo7ICAgICAgICA1OiAgICAg
ICBiNCAxMCAwMCAwMCBmZiBmZiBmZiBmZCB3MSA9IC0zCiAgIDB4M2ZmN2ZkY2RhZDQ6ICAgICAg
IGxsaWxmICAgJXIyLDB4ZmZmZmZmZmQKOyAgICAgICAgNjogICAgICAgYjQgMjAgMDAgMDAgZmYg
ZmYgZmYgZTIgdzIgPSAtMzAKICAgMHgzZmY3ZmRjZGFkYTogICAgICAgbGxpbGYgICAlcjMsMHhm
ZmZmZmZlMgo7ICAgICAgICA3OiAgICAgICBiNCAzMCAwMCAwMCBmZiBmZiBmZiAzOCB3MyA9IC0y
MDAKICAgMHgzZmY3ZmRjZGFlMDogICAgICAgbGxpbGYgICAlcjQsMHhmZmZmZmYzOAo7ICAgICAg
IDg6ICAgICAgIGI3IDQwIDAwIDAwIGZmIGZmIGZjIDE4IHI0ID0gLTEwMDAKICAgMHgzZmY3ZmRj
ZGFlNjogICAgICAgbGdmaSAgICAlcjUsLTEwMDAKICAgMHgzZmY3ZmRjZGFlYzogICAgICAgbXZj
ICAgICA2NCg0LCVyMTUpLDE2MCglcjE1KQogICAweDNmZjdmZGNkYWYyOiAgICAgICBsZ3JsICAg
ICVyMSxicGZfa2Z1bmNfY2FsbF90ZXN0NEBHT1QKICAgMHgzZmY3ZmRjZGFmODogICAgICAgYnJh
c2wgICAlcjE0LF9fczM5MF9pbmRpcmVjdF9qdW1wX3IxCgpUaGlzIGZpcnN0IDMgbGxpbGZzIGFy
ZSAzMi1iaXQgbG9hZHMsIHRoYXQgbmVlZCB0byBiZSBzaWduLWV4dGVuZGVkCnRvIDY0IGJpdHMu
Cgo+ID4gK2Jvb2wgYnBmX2ppdF9zdXBwb3J0c19rZnVuY19jYWxsKHZvaWQpCj4gPiArewo+ID4g
K8KgwqDCoMKgwqDCoMKgcmV0dXJuIHRydWU7Cj4gPiArfQo+IAo+IFRpbWVseSA6KSBUaGFua3Mg
Zm9yIHdvcmtpbmcgaXQuCgo=

