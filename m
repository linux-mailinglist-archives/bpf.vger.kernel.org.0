Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108F769D7AA
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 01:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjBUAqp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Feb 2023 19:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjBUAqo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Feb 2023 19:46:44 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79AD1C7F1
        for <bpf@vger.kernel.org>; Mon, 20 Feb 2023 16:46:41 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31KMgJkj027656;
        Tue, 21 Feb 2023 00:46:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=3c0Nu2B7DjCuu9G/mbqw59tTWcLuoyq4Z2osqERdEE8=;
 b=lf4utgWtKun88HNwr9Px4dbGC9EYj6Vlb3Drs5033obBRLqO0iet9ZzSzu4Y9ShdprsR
 XwiNFVGX49AEmSPZUPj2JLHsKR5hJwgj7LAnhko2c6Q03PGiTL8LnYiQE/YLoPOsJi/K
 VsT4HLIy/oHXTU41p10oaOTnxGeD3q9CK0uJ+RW5TdBNFXJaviuCPrrB9txSDwS4RjZa
 2BqndvyxCTOJSGj2ago6MlnFWrAY7UAZvAgrFbrPqY1tU5eIde049WQt7G8xhAMQw6+B
 hkS+xQK9yt6a0SMVEmhmvTsColTu/l/+ijjymdXGq1u1ppiNSjnfawKUfFznAA0ti3Qp bA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nvhvptfj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 00:46:26 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31L0gBi7032502;
        Tue, 21 Feb 2023 00:46:25 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nvhvptfhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 00:46:25 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31KFJtka014757;
        Tue, 21 Feb 2023 00:46:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3ntpa62gxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 00:46:22 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31L0kJcE14418462
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 00:46:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C7F420043;
        Tue, 21 Feb 2023 00:46:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D54220040;
        Tue, 21 Feb 2023 00:46:18 +0000 (GMT)
Received: from [9.171.34.203] (unknown [9.171.34.203])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 21 Feb 2023 00:46:18 +0000 (GMT)
Message-ID: <b0ae5117d46948ca4d160157bc02e94c3b00fb19.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next v3 7/8] libbpf: Add MSan annotations
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Date:   Tue, 21 Feb 2023 01:46:18 +0100
In-Reply-To: <CAEf4BzZcvuCZpjKwgT_-3WaKuM82CA1Uxg3X-4E63r2o6he+sA@mail.gmail.com>
References: <20230214231221.249277-1-iii@linux.ibm.com>
         <20230214231221.249277-8-iii@linux.ibm.com>
         <CAEf4BzZcvuCZpjKwgT_-3WaKuM82CA1Uxg3X-4E63r2o6he+sA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wA95zVnfkISmWZUJTx9CNUAf4Xf1vU0m
X-Proofpoint-GUID: vetZOYxJO2n1f8i72DVo7qWZwTXE8brJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_18,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302210003
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVGh1LCAyMDIzLTAyLTE2IGF0IDE1OjI4IC0wODAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
Cj4gT24gVHVlLCBGZWIgMTQsIDIwMjMgYXQgMzoxMiBQTSBJbHlhIExlb3Noa2V2aWNoIDxpaWlA
bGludXguaWJtLmNvbT4KPiB3cm90ZToKPiA+IAo+ID4gTVNhbiBydW5zIGludG8gYSBmZXcgZmFs
c2UgcG9zaXRpdmVzIGluIGxpYmJwZi4gVGhleSBhbGwgY29tZSBmcm9tCj4gPiB0aGUKPiA+IGZh
Y3QgdGhhdCBNU2FuIGRvZXMgbm90IGtub3cgYW55dGhpbmcgYWJvdXQgdGhlIGJwZiBzeXNjYWxs
LAo+ID4gcGFydGljdWxhcmx5LCB3aGF0IGl0IHdyaXRlcyB0by4KPiA+IAo+ID4gQWRkIF9fbGli
YnBmX21hcmtfbWVtX3dyaXR0ZW4oKSBmdW5jdGlvbiB0byBtYXJrIG1lbW9yeSBtb2RpZmllZCBi
eQo+ID4gdGhlCj4gPiBicGYgc3lzY2FsbCwgYW5kIGEgZmV3IGNvbnZlbmllbmNlIHdyYXBwZXJz
LiBVc2UgdGhlIGFic3RyYWN0IG5hbWUKPiA+IChpdAo+ID4gY291bGQgYmUgZS5nLiBsaWJicGZf
bXNhbl91bnBvaXNvbigpKSwgYmVjYXVzZSBpdCBjYW4gYmUgdXNlZCBmb3IKPiA+IFZhbGdyaW5k
IGluIHRoZSBmdXR1cmUgYXMgd2VsbC4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogSWx5YSBMZW9z
aGtldmljaCA8aWlpQGxpbnV4LmlibS5jb20+Cj4gPiAtLS0KPiA+IMKgdG9vbHMvbGliL2JwZi9i
cGYuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE2MQo+ID4gKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0KPiA+IMKgdG9vbHMvbGliL2JwZi9idGYuY8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8wqDCoCAxICsKPiA+IMKgdG9vbHMvbGliL2JwZi9saWJicGYuY8KgwqDCoMKgwqDC
oMKgwqDCoCB8wqDCoCAxICsKPiA+IMKgdG9vbHMvbGliL2JwZi9saWJicGZfaW50ZXJuYWwuaCB8
wqAgMzggKysrKysrKysKPiA+IMKgNCBmaWxlcyBjaGFuZ2VkLCAxOTQgaW5zZXJ0aW9ucygrKSwg
NyBkZWxldGlvbnMoLSkKPiAKClsuLi5dCgo+ID4gKy8qIEhlbHBlciBtYWNyb3MgZm9yIHRlbGxp
bmcgbWVtb3J5IGNoZWNrZXJzIHRoYXQgYW4gYXJyYXkgcG9pbnRlZAo+ID4gdG8gYnkKPiA+ICsg
KiBhIHN0cnVjdCBicGZfe2J0ZixsaW5rLG1hcCxwcm9nfV9pbmZvIG1lbWJlciBpcyBpbml0aWFs
aXplZC4KPiA+IEJlZm9yZSBkb2luZwo+ID4gKyAqIHRoYXQsIHRoZXkgbWFrZSBzdXJlIHRoYXQg
a2VybmVsIGhhcyBwcm92aWRlZCB0aGUgcmVzcGVjdGl2ZQo+ID4gbWVtYmVyLgo+ID4gKyAqLwo+
ID4gKwo+ID4gKy8qIEhhbmRsZSBhcnJheXMgd2l0aCBhIGNlcnRhaW4gZWxlbWVudCBzaXplLiAq
Lwo+ID4gKyNkZWZpbmUgX19NQVJLX0lORk9fQVJSQVlfV1JJVFRFTihwdHIsIG5yLCBlbGVtX3Np
emUpIGRvCj4gPiB7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+ID4g
K8KgwqDCoMKgwqDCoCBpZiAoaW5mb19sZW4gPj0gb2Zmc2V0b2ZlbmQodHlwZW9mKCppbmZvKSwg
cHRyKQo+ID4gJibCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbmZvX2xlbiA+PSBvZmZzZXRvZmVuZCh0eXBlb2YoKmlu
Zm8pLCBucikKPiA+ICYmwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IFwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbmZvLQo+ID4gPnB0cinCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxpYmJwZl9tYXJrX21lbV93cml0dGVuKHU2NF90b19wdHIo
aW5mby0KPiA+ID5wdHIpLMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGluZm8tPm5yICoKPiA+IGVsZW1fc2l6ZSk7wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+ID4gK30gd2hpbGUgKDApCj4gPiArCj4gPiArLyogSGFu
ZGxlIGFycmF5cyB3aXRoIGEgY2VydGFpbiBlbGVtZW50IHR5cGUuICovCj4gPiArI2RlZmluZSBN
QVJLX0lORk9fQVJSQVlfV1JJVFRFTihwdHIsIG5yLAo+ID4gdHlwZSnCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4gPiArwqDC
oMKgwqDCoMKgIF9fTUFSS19JTkZPX0FSUkFZX1dSSVRURU4ocHRyLCBuciwgc2l6ZW9mKHR5cGUp
KQo+ID4gKwo+ID4gKy8qIEhhbmRsZSBhcnJheXMgd2l0aCBlbGVtZW50IHNpemUgZGVmaW5lZCBi
eSBhIHN0cnVjdCBtZW1iZXIuICovCj4gPiArI2RlZmluZSBNQVJLX0lORk9fUkVDX0FSUkFZX1dS
SVRURU4ocHRyLCBuciwgcmVjX3NpemUpIGRvCj4gPiB7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIFwKPiA+ICvCoMKgwqDCoMKgwqAgaWYgKGluZm9fbGVuID49IG9mZnNldG9m
ZW5kKHR5cGVvZigqaW5mbyksCj4gPiByZWNfc2l6ZSkpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBcCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX01BUktfSU5G
T19BUlJBWV9XUklUVEVOKHB0ciwgbnIsIGluZm8tCj4gPiA+cmVjX3NpemUpO8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgXAo+ID4gK30gd2hpbGUgKDApCj4gPiArCj4gPiArLyogSGFuZGxlIG51bGwt
dGVybWluYXRlZCBzdHJpbmdzLiAqLwo+ID4gKyNkZWZpbmUgTUFSS19JTkZPX1NUUl9XUklUVEVO
KHB0ciwgbnIpIGRvCj4gPiB7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+ID4gK8KgwqDCoMKgwqDCoCBpZiAoaW5m
b19sZW4gPj0gb2Zmc2V0b2ZlbmQodHlwZW9mKCppbmZvKSwgcHRyKQo+ID4gJibCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpbmZvX2xlbiA+PSBvZmZzZXRvZmVuZCh0eXBlb2YoKmluZm8pLCBucikKPiA+ICYmwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoCBpbmZvLQo+ID4gPnB0cinCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGxpYmJwZl9tYXJrX21lbV93cml0dGVuKHU2NF90b19wdHIoaW5mby0KPiA+ID5wdHIpLMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlu
Zm8tPm5yICsKPiA+IDEpO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBcCj4gPiArfSB3aGlsZSAoMCkKPiA+ICsKPiA+ICsvKiBIZWxwZXIgZnVuY3Rpb25z
IGZvciB0ZWxsaW5nIG1lbW9yeSBjaGVja2VycyB0aGF0IGFycmF5cwo+ID4gcG9pbnRlZCB0byBi
eQo+ID4gKyAqIGJwZl97YnRmLGxpbmssbWFwLHByb2d9X2luZm8gbWVtYmVycyBhcmUgaW5pdGlh
bGl6ZWQuCj4gPiArICovCj4gPiArCj4gPiArc3RhdGljIHZvaWQgbWFya19wcm9nX2luZm9fd3Jp
dHRlbihzdHJ1Y3QgYnBmX3Byb2dfaW5mbyAqaW5mbywKPiA+IF9fdTMyIGluZm9fbGVuKQo+ID4g
K3sKPiA+ICvCoMKgwqDCoMKgwqAgTUFSS19JTkZPX0FSUkFZX1dSSVRURU4obWFwX2lkcywgbnJf
bWFwX2lkcywgX191MzIpOwo+ID4gK8KgwqDCoMKgwqDCoCBNQVJLX0lORk9fQVJSQVlfV1JJVFRF
TihqaXRlZF9rc3ltcywgbnJfaml0ZWRfa3N5bXMsCj4gPiBfX3U2NCk7Cj4gPiArwqDCoMKgwqDC
oMKgIE1BUktfSU5GT19BUlJBWV9XUklUVEVOKGppdGVkX2Z1bmNfbGVucywKPiA+IG5yX2ppdGVk
X2Z1bmNfbGVucywgX191MzIpOwo+ID4gK8KgwqDCoMKgwqDCoCBNQVJLX0lORk9fUkVDX0FSUkFZ
X1dSSVRURU4oZnVuY19pbmZvLCBucl9mdW5jX2luZm8sCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZnVuY19p
bmZvX3JlY19zaXplKTsKPiA+ICvCoMKgwqDCoMKgwqAgTUFSS19JTkZPX1JFQ19BUlJBWV9XUklU
VEVOKGxpbmVfaW5mbywgbnJfbGluZV9pbmZvLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxpbmVfaW5mb19y
ZWNfc2l6ZSk7Cj4gPiArwqDCoMKgwqDCoMKgIE1BUktfSU5GT19SRUNfQVJSQVlfV1JJVFRFTihq
aXRlZF9saW5lX2luZm8sCj4gPiBucl9qaXRlZF9saW5lX2luZm8sCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aml0ZWRfbGluZV9pbmZvX3JlY19zaXplKTsKPiA+ICvCoMKgwqDCoMKgwqAgTUFSS19JTkZPX0FS
UkFZX1dSSVRURU4ocHJvZ190YWdzLCBucl9wcm9nX3RhZ3MsCj4gPiBfX3U4W0JQRl9UQUdfU0la
RV0pOwo+ID4gK30KPiA+ICsKPiA+ICtzdGF0aWMgdm9pZCBtYXJrX2J0Zl9pbmZvX3dyaXR0ZW4o
c3RydWN0IGJwZl9idGZfaW5mbyAqaW5mbywgX191MzIKPiA+IGluZm9fbGVuKQo+ID4gK3sKPiA+
ICvCoMKgwqDCoMKgwqAgTUFSS19JTkZPX0FSUkFZX1dSSVRURU4oYnRmLCBidGZfc2l6ZSwgX191
OCk7Cj4gPiArwqDCoMKgwqDCoMKgIE1BUktfSU5GT19TVFJfV1JJVFRFTihuYW1lLCBuYW1lX2xl
bik7Cj4gPiArfQo+ID4gKwo+ID4gK3N0YXRpYyB2b2lkIG1hcmtfbGlua19pbmZvX3dyaXR0ZW4o
c3RydWN0IGJwZl9saW5rX2luZm8gKmluZm8sCj4gPiBfX3UzMiBpbmZvX2xlbikKPiA+ICt7Cj4g
PiArwqDCoMKgwqDCoMKgIHN3aXRjaCAoaW5mby0+dHlwZSkgewo+ID4gK8KgwqDCoMKgwqDCoCBj
YXNlIEJQRl9MSU5LX1RZUEVfUkFXX1RSQUNFUE9JTlQ6Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBNQVJLX0lORk9fU1RSX1dSSVRURU4ocmF3X3RyYWNlcG9pbnQudHBfbmFtZSwK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcmF3X3RyYWNlcG9pbnQudHBfbmFtZV9sZW4pOwo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gPiArwqDCoMKgwqDCoMKgIGNhc2Ug
QlBGX0xJTktfVFlQRV9JVEVSOgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTUFS
S19JTkZPX1NUUl9XUklUVEVOKGl0ZXIudGFyZ2V0X25hbWUsCj4gPiBpdGVyLnRhcmdldF9uYW1l
X2xlbik7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiA+ICvCoMKg
wqDCoMKgwqAgZGVmYXVsdDoKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFr
Owo+ID4gK8KgwqDCoMKgwqDCoCB9Cj4gPiArfQo+ID4gKwo+ID4gKyN1bmRlZiBNQVJLX0lORk9f
U1RSX1dSSVRURU4KPiA+ICsjdW5kZWYgTUFSS19JTkZPX1JFQ19BUlJBWV9XUklUVEVOCj4gPiAr
I3VuZGVmIE1BUktfSU5GT19BUlJBWV9XUklUVEVOCj4gPiArI3VuZGVmIF9fTUFSS19JTkZPX0FS
UkFZX1dSSVRURU4KPiAKPiBVZ2guLi4gSSB3YXNuJ3QgYSBiaWcgZmFuIG9mIGFkZGluZyBhbGwg
dGhlc2UgIm1hcmtfbWVtX3dyaXR0ZW4iCj4gYWNyb3NzIGEgYnVuY2ggb2YgQVBJcyB0byBiZWdp
biB3aXRoLCBidXQgdGhpcyBwYXJ0IGlzIHJlYWxseSBwdXR0aW5nCj4gbWUgb2ZmLgo+IAo+IEkg
bGlrZSB0aGUgYnBmX3ttYXAsYnRmLHByb2csYnRmfV9pbmZvX2J5X2ZkKCkgaW1wcm92ZW1lbnRz
IHlvdSBkaWQsCj4gYnV0IG1heWJlIGFkZGluZyB0aGVzZSBNU2FuIGFubm90YXRpb25zIGlzIGEg
Yml0IHRvbyBtdWNoPwo+IEFwcGxpY2F0aW9ucyB0aGF0IHJlYWxseSBjYXJlIGFib3V0IHRoaXMg
d2hvbGUgImRvIEkgcmVhZAo+IHVuaW5pdGlhbGl6ZWQgbWVtb3J5IiBidXNpbmVzcyBjb3VsZCBk
byB0aGVpciBvd24gc2ltcGxlciB3cmFwcGVycyBvbgo+IHRvcCBvZiBsaWJicGYgQVBJcywgcmln
aHQ/Cj4gCj4gTWF5YmUgd2Ugc2hvdWxkIHN0YXJ0IHRoZXJlIGZpcnN0IGFuZCBzZWUgaWYgdGhl
cmUgaXMgbW9yZSBkZW1hbmQgdG8KPiBoYXZlIGJ1aWx0LWluIGxpYmJwZiBzdXBwb3J0PwoKSSBj
YW4gdHJ5IG1vdmluZyBhbGwgdGhpcyB0byBzZWxmdGVzdHMuCkFsdGVybmF0aXZlbHkgdGhpcyBj
b3VsZCBiZSBtYWRlIGEgcGFydCBvZiBMTFZNIHNhbml0aXplcnMsIGJ1dCB0aGVuCndlwqBjb21l
IGJhY2sgdG8gdGhlIHF1ZXN0aW9uIG9mIHJlc29sdmluZyBmZCB0eXBlcy4KCj4gQlRXLCBpcyB0
aGlzIGFsbCBuZWVkZWQgZm9yIEFTYW4gYXMgd2VsbD8KCk5vdCBzdHJpY3RseSBuZWVkZWQsIGJ1
dCB0aGlzIHdvdWxkIGhlbHAgZGV0ZWN0aW5nIGJhZCB3cml0ZXMuCgo+IE9uZSBtb3JlIHdvcnJ5
IEkgaGF2ZSBpcyB0aGF0IGdpdmVuIHdlIGRvbid0IGV4ZXJjaXNlIGFsbCB0aGVzZQo+IHNhbml0
aXplcnMgcmVndWxhcmx5IGluIEJQRiBDSSwgd2UnbGwga2VlcCBmb3JnZXR0aW5nIGFkZGluZyBu
ZXcKPiBhbm5vdGF0aW9ucyBhbmQgYWxsIHRoaXMgbWFjaGluZXJ5IHdpbGwgc3RhcnQgYml0IHJv
dHRpbmcuCj4gCj4gU28gSSdkIHNheSB0aGF0IHdlIHNob3VsZCBmaXJzdCBtYWtlIHN1cmUgdGhh
dCB3ZSBoYXZlIHNhbml0aXplcgo+IGJ1aWxkcy9ydW5zIGluIEJQRiBDSSwgYmVmb3JlIHNpZ25p
bmcgdXAgZm9yIG1haW50YWluaW5nIHRoZXNlCj4gImFubm90YXRpb25zIi4KCkknbGwgd2FpdCB1
bnRpbCBMTFZNIGZvbGtzIHJldmlldyBteSBwYXRjaGVzLCBhbmQgdGhlbiBzZWUgaWYgSSBjYW4K
YWRkIE1TYW4gdG8gdGhlIENJLiBDb25maWd1cmluZyBpdCBsb2NhbGx5IHdhc24ndCB0b28gY29t
cGxpY2F0ZWQsCnRoZSBtYWluIGRpZmZpY3VsdHkgaXMgdGhhdCBvbmUgbmVlZHMgaW5zdHJ1bWVu
dGVkIHpsaWIgYW5kIGVsZnV0aWxzLgpGb3IgdGhlIENJLCB0aGV5IGNhbiBiZSBwcmVidWlsdCBh
bmQgdXBsb2FkZWQgdG8gUzMsIGFuZCB0aGVuIGFkZGVkCnRvIHRoZSBidWlsZCBlbnZpcm9ubWVu
dCBhbmQgdGhlIGltYWdlLgoKWy4uLl0K

