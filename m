Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8A4690446
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 10:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjBIJzy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 04:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBIJzx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 04:55:53 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06CF12D
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 01:55:52 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3199lOvA021778;
        Thu, 9 Feb 2023 09:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=GXJFVYQJMvU6z8uXTn4eoIWloxU3s1Svl1cS6WvUfQY=;
 b=Jb3ju18xw7ekuA/dd7sh8PjIVEExAKFnKpDZufHaSnCPMou6KioYr3Ou47SGQAPzQe0l
 6fkEHPF21GsqDIQvAbTK8mAKkNhueQmCq6l6NQ4NuMfESs6NdQYXxQC//0EPhn87YXXS
 XF7fkbPZuUq8nvw9juSXDJNsQ4yGmWS1HhxAvmqTvgvQID+mWG0sebV4wudY83cE8r1R
 CPkAnqwEeFqSAgMK5qBuxsggbl3NdnaDW5VFXaFC/J9Ww8mhO7HV8jGFCsviQm1HLyjQ
 qTBrViKe8d0EeZ7xhRxSLvYbbfXb9bn0Jy4V2YVan4/tamABABiMfYrjbtTphTGdEM7b Gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nmxgt8470-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 09:55:36 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3199laNl022696;
        Thu, 9 Feb 2023 09:55:35 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nmxgt846g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 09:55:35 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3194sPTo018248;
        Thu, 9 Feb 2023 09:55:34 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3nhf06m7r5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 09:55:33 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3199tUas23527872
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Feb 2023 09:55:30 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1954120040;
        Thu,  9 Feb 2023 09:55:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81A5A20043;
        Thu,  9 Feb 2023 09:55:29 +0000 (GMT)
Received: from [9.171.61.223] (unknown [9.171.61.223])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  9 Feb 2023 09:55:29 +0000 (GMT)
Message-ID: <804f5a8ef91933c3796e61ad1e51c1c4fe261d27.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 4/9] selftests/bpf: Forward SAN_CFLAGS and
 SAN_LDFLAGS to runqslower and libbpf
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Date:   Thu, 09 Feb 2023 10:55:29 +0100
In-Reply-To: <CAEf4BzbWjs7N=cQF2PYXKeDG2dB8JKrV0Jw=i_rvVxm4Kv02Aw@mail.gmail.com>
References: <20230208205642.270567-1-iii@linux.ibm.com>
         <20230208205642.270567-5-iii@linux.ibm.com>
         <CAEf4BzbWjs7N=cQF2PYXKeDG2dB8JKrV0Jw=i_rvVxm4Kv02Aw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Q5tW625AbPNvxt4JIhqLaevsu3ANJu8U
X-Proofpoint-ORIG-GUID: VgPIhkyYWQZQqTEl-VvOHy62BR571s0L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-09_05,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302090090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gV2VkLCAyMDIzLTAyLTA4IGF0IDE3OjAzIC0wODAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
Cj4gT24gV2VkLCBGZWIgOCwgMjAyMyBhdCAxMjo1NyBQTSBJbHlhIExlb3Noa2V2aWNoIDxpaWlA
bGludXguaWJtLmNvbT4KPiB3cm90ZToKPiA+IAo+ID4gVG8gZ2V0IHVzZWZ1bCByZXN1bHRzIGZy
b20gdGhlIE1lbW9yeSBTYW5pdGl6ZXIsIGFsbCBjb2RlIHJ1bm5pbmcKPiA+IGluIGEKPiA+IHBy
b2Nlc3MgbmVlZHMgdG8gYmUgaW5zdHJ1bWVudGVkLiBXaGVuIGJ1aWxkaW5nIHRlc3RzIHdpdGgg
b3RoZXIKPiA+IHNhbml0aXplcnMsIGl0J3Mgbm90IHN0cmljdGx5IG5lY2Vzc2FyeSwgYnV0IGlz
IGFsc28gaGVscGZ1bC4KPiA+IFNvIG1ha2Ugc3VyZSBydW5xc2xvd2VyIGFuZCBsaWJicGYgYXJl
IGNvbXBpbGVkIHdpdGggU0FOX0NGTEFHUyBhbmQKPiA+IGxpbmtlZCB3aXRoIFNBTl9MREZMQUdT
Lgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBJbHlhIExlb3Noa2V2aWNoIDxpaWlAbGludXguaWJt
LmNvbT4KPiA+IC0tLQo+ID4gwqB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvTWFrZWZpbGUg
fCA3ICsrKysrLS0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Jw
Zi9NYWtlZmlsZQo+ID4gYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvTWFrZWZpbGUKPiA+
IGluZGV4IDliNTc4NmFjNjc2ZS4uYzRiNWM0NGNkZWUyIDEwMDY0NAo+ID4gLS0tIGEvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvYnBmL01ha2VmaWxlCj4gPiArKysgYi90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9icGYvTWFrZWZpbGUKPiA+IEBAIC0yMTUsNyArMjE1LDkgQEAgJChPVVRQVVQpL3J1
bnFzbG93ZXI6ICQoQlBGT0JKKSB8Cj4gPiAkKERFRkFVTFRfQlBGVE9PTCkgJChSVU5RU0xPV0VS
X09VVFBVVCkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE9VVFBV
VD0kKFJVTlFTTE9XRVJfT1VUUFVUKQo+ID4gVk1MSU5VWF9CVEY9JChWTUxJTlVYX0JURinCoMKg
wqDCoCBcCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+ID4gQlBG
VE9PTF9PVVRQVVQ9JChIT1NUX0JVSUxEX0RJUikvYnBmdG9vbC/CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIFwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgCj4gPiBCUEZPQkpfT1VUUFVUPSQoQlVJTERfRElSKS9saWJicGbCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4gPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJQRk9CSj0kKEJQRk9CSikgQlBGX0lOQ0xVREU9JChJTkNM
VURFX0RJUikKPiA+ICYmwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQlBGT0JKPSQoQlBGT0JKKQo+ID4gQlBGX0lOQ0xV
REU9JChJTkNMVURFX0RJUinCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBFWFRSQV9DRkxBR1M9Jy1nIC1PMAo+
ID4gJChTQU5fQ0ZMQUdTKSfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIFwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRVhUUkFf
TERGTEFHUz0nJChTQU5fTERGTEFHUyknCj4gPiAmJsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGNwICQoUlVOUVNMT1dFUl9PVVRQVVQpcnVucXNsb3dlciAkQAo+ID4gCj4g
Cj4gSSB3b3VsZG4ndCBkbyBpdCBmb3IgcnVucXNsb3dlciwgd2UganVzdCBtYWtlIHN1cmUgdGhh
dCBpdCBjb21waWxlcywKPiB3ZSBkb24ndCByZWFsbHkgcnVuIGl0IGF0IGFsbC4gTm8gbmVlZCB0
byBjb21wbGljYXRlIGl0cyBidWlsZCwgSU1PLgoKcnVucXNsb3dlciBpcyBsaW5rZWQgd2l0aCB0
YXJnZXQgbGliYnBmLCB3aGljaCBpcyBpbnN0cnVtZW50ZWQuClRoaXMgcHJvZHVjZXMgdW5kZWZp
bmVkIHN5bWJvbCBlcnJvcnMsIHNpbmNlIE1TYW4gcnVudGltZSBpcyBleHBlY3RlZAp0byBiZSBh
IHBhcnQgb2YgYW4gZXhlY3V0YWJsZS4KClsuLi5dCg==

