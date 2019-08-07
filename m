Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7E3E8441A
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2019 08:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfHGGBh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Aug 2019 02:01:37 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49128 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726289AbfHGGBh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Aug 2019 02:01:37 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7761WV0032697;
        Tue, 6 Aug 2019 23:01:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=1UBySQS4TaeNfMjrIfHpPymgmqVVb9lZWsv+pJwNF5U=;
 b=A+ZI4H61EuwcSOiOo9WA2B8OYCLGNtdoAJWxwIH053POlJlq6fOszD7S8eVbKropBF+q
 C6iynCjdruFKh1WP5A3HxiMPNIQzIF3TxuG6FbbYyJ5b52R55tnKj2PucHBk8mFzqk8l
 anLicyPyirYkjykZt1G2tsYJeT4mFTfqBrM= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2u7h5hhbpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 06 Aug 2019 23:01:31 -0700
Received: from prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 6 Aug 2019 23:01:26 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 6 Aug 2019 23:01:25 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 6 Aug 2019 23:01:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbbFeBTqL8QaG1xli4ZQ47GwevaeNdd5lX6b6TtduNkypLHNBTsGAq4+XOKJLLVvUq3vojaq5bpfHq0tJlLW76cpi+p0i+MBDvVqOw5yYB1ibnxkQIP6Wt3vS3fwOjWNt5mdaQYq8GyknwBK1lkg4pqdAsB1SBgVFeBE1QcJvyVeqWyKqi1m1uhiNf/yJz51Kc1tV2IyQ+w6o4C7Jbr1TByDmajpVvha56Xkisy3YRkMV2KOBo9gJ1Jv3NtNmSYKLJfzSVuYG0QDpH+jouCHbKlzsypbOP+LbpNfopO2E2wAC8q/cpDD3Akw4fhwvDHPMTIkV6OI+u4GzKc2mqdWgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UBySQS4TaeNfMjrIfHpPymgmqVVb9lZWsv+pJwNF5U=;
 b=hIrXDgPM5PvyQsiDAeUGxojafVk04WzSuuTY3LLmO3JyqinJfd79iL+9VMDhY03sXOadlIZf6g2js08WkBHxeBRX40sWCJr1YJL48IEfwwB2nkJZpflZu8fbcYfKLSlRGsum0R4VuOChFVoiaUhx0z2rrRs5pvPmsPsEb4K+aRBJ9CuPiiv+V4xDlYLtB4HoQg+35CNK9tYG3bK3BZucCb6nbfn7lc2bM0rOZooO718XBpwdxhkTeTdjmqSy4SmhdjnNP/rVH/bfG0AbFOwNy9NxhEPgNlvggloOhdsEe9wDNVpsEMPeeJSnBzUhagtanEKkapOoVKZE14xN6XTzmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UBySQS4TaeNfMjrIfHpPymgmqVVb9lZWsv+pJwNF5U=;
 b=APA7E19PDmkFleQJ+S6eOjWMIkuEpfmUyIROljGxgTORD27lBPnvYk/weiup8XIXhlwyB8VRnBTL4raPoTksOjhMKhsokm0xIgm5ASW4MN8nw750aJnGQroIhgrzp6i76Fqr022r2sYh14AoJkWra1Z4IyVl1T5Ni5SJ4FXaDx4=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2550.namprd15.prod.outlook.com (20.179.155.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.13; Wed, 7 Aug 2019 06:01:24 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::e499:ecba:ec04:abac]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::e499:ecba:ec04:abac%5]) with mapi id 15.20.2136.018; Wed, 7 Aug 2019
 06:01:24 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Daniel Xu <dxu@dxuuu.xyz>, Song Liu <songliubraving@fb.com>,
        "Andrii Nakryiko" <andriin@fb.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 3/3] tracing/kprobe: Add self test for
 PERF_EVENT_IOC_QUERY_KPROBE
Thread-Topic: [PATCH 3/3] tracing/kprobe: Add self test for
 PERF_EVENT_IOC_QUERY_KPROBE
Thread-Index: AQHVTLCnIKmRW01SNUqHQJTXM1eNJabvMa8A
Date:   Wed, 7 Aug 2019 06:01:24 +0000
Message-ID: <a43758be-df80-a7c6-622a-18d7c79f5865@fb.com>
References: <20190806234201.6296-1-dxu@dxuuu.xyz>
 <20190806234201.6296-2-dxu@dxuuu.xyz>
In-Reply-To: <20190806234201.6296-2-dxu@dxuuu.xyz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR0201CA0108.namprd02.prod.outlook.com
 (2603:10b6:301:75::49) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1dec]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b6378eb-3df4-47d0-2160-08d71afcad98
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB2550;
x-ms-traffictypediagnostic: BYAPR15MB2550:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB255017458D9AA50B9AEE5526D3D40@BYAPR15MB2550.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(376002)(366004)(396003)(346002)(199004)(189003)(86362001)(486006)(52116002)(31696002)(81156014)(81166006)(7736002)(14454004)(476003)(25786009)(256004)(5024004)(11346002)(14444005)(2616005)(229853002)(99286004)(6486002)(53936002)(2906002)(305945005)(46003)(446003)(36756003)(6436002)(68736007)(102836004)(31686004)(6506007)(53546011)(386003)(5660300002)(6512007)(478600001)(186003)(8676002)(6246003)(6636002)(76176011)(66556008)(64756008)(66446008)(316002)(66946007)(71200400001)(71190400001)(110136005)(54906003)(4326008)(8936002)(66476007)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2550;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6k6qpFVrZinTyaztrc1Ci9co47+tdaBpuglxuvPja5nzCZUAkUH4+yjhR2lXLUqUQ6xJx9PFYcXRXbVOD5KjuhrCzzs73suDVg8v2IY5/VjfykstkJD5BeXguMtW2ctvMWlBoJJcxHHL0TeEWhoSF4u+IIevuFf7f9N7Fcpw+XldXCtqnR3lTH5ruYribpjDj+rcDJofop1Peix4wjlRP+XOi+eDhlgXpNSzE926AJygO48BdNysBbpcxIziXqSlJ0snUvBTG8w2hM28szv6MZ1VpCiItGzCJCsJTjxnNZT0Xqz6rt2RGJHthl3xMyzasePVCFzR6DVx9dxQOAw4TnReTiNIyUjrQ7EZEna3dBYnCDbAhVRgL7pru6NxjV/x/YrE/9u92SH76lpwuAahuun0LLighA9O0ijolUS9y00=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB5A259ADA95064A865B59F9E2267633@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6378eb-3df4-47d0-2160-08d71afcad98
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 06:01:24.4592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yhs@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2550
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-07_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908070065
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDgvNi8xOSA0OjQyIFBNLCBEYW5pZWwgWHUgd3JvdGU6DQo+IC0tLQ0KPiAgIHRvb2xz
L2luY2x1ZGUvdWFwaS9saW51eC9wZXJmX2V2ZW50LmggICAgICAgICB8IDIzICsrKysrKysrKysN
Cj4gICAuLi4vc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL2F0dGFjaF9wcm9iZS5jICAgfCA0MyAr
KysrKysrKysrKysrKysrKysrDQoNCkNvdWxkIHlvdSBzZXBhcmF0ZSB0aGlzIGludG8gdHdvIHBh
dGNoZXM/DQogICAgb25lIHBhdGNoIGZvciB1YXBpIHVwZGF0ZSB0b29scy9pbmNsdWRlL3VhcGkv
bGludXgvcGVyZl9ldmVudC5oDQogICAgYW5kIHRoZSBvdGhlciBmb3IgLi4uL3NlbGZ0ZXN0cy9i
cGYvcHJvZ190ZXN0cy9hdHRhY2hfcHJvYmUuYw0KVGhlIHJlYXNvbiBpcyB0byBoZWxwIGxpYmJw
ZiBtaXJyb3Igc3luYydpbmcuDQoNCj4gICAyIGZpbGVzIGNoYW5nZWQsIDY2IGluc2VydGlvbnMo
KykNCj4gDQo+IGRpZmYgLS1naXQgYS90b29scy9pbmNsdWRlL3VhcGkvbGludXgvcGVyZl9ldmVu
dC5oIGIvdG9vbHMvaW5jbHVkZS91YXBpL2xpbnV4L3BlcmZfZXZlbnQuaA0KPiBpbmRleCA3MTk4
ZGRkMGM2YjEuLjRhNWUxODYwNmJhZiAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvaW5jbHVkZS91YXBp
L2xpbnV4L3BlcmZfZXZlbnQuaA0KPiArKysgYi90b29scy9pbmNsdWRlL3VhcGkvbGludXgvcGVy
Zl9ldmVudC5oDQo+IEBAIC00NDcsNiArNDQ3LDI4IEBAIHN0cnVjdCBwZXJmX2V2ZW50X3F1ZXJ5
X2JwZiB7DQo+ICAgCV9fdTMyCWlkc1swXTsNCj4gICB9Ow0KPiAgIA0KPiArLyoNCj4gKyAqIFN0
cnVjdHVyZSB1c2VkIGJ5IGJlbG93IFBFUkZfRVZFTlRfSU9DX1FVRVJZX0tQUk9FIGNvbW1hbmQN
Cj4gKyAqIHRvIHF1ZXJ5IGluZm9ybWF0aW9uIGFib3V0IHRoZSBrcHJvYmUgYXR0YWNoZWQgdG8g
dGhlIHBlcmYNCj4gKyAqIGV2ZW50Lg0KPiArICovDQo+ICtzdHJ1Y3QgcGVyZl9ldmVudF9xdWVy
eV9rcHJvYmUgew0KPiArICAgICAgIC8qDQo+ICsgICAgICAgICogU2l6ZSBvZiBzdHJ1Y3R1cmUg
Zm9yIGZvcndhcmQvYmFja3dhcmQgY29tcGF0aWJpbGl0eQ0KPiArICAgICAgICAqLw0KPiArICAg
ICAgIF9fdTMyICAgc2l6ZTsNCj4gKyAgICAgICAvKg0KPiArICAgICAgICAqIFNldCBieSB0aGUg
a2VybmVsIHRvIGluZGljYXRlIG51bWJlciBvZiB0aW1lcyB0aGlzIGtwcm9iZQ0KPiArICAgICAg
ICAqIHdhcyB0ZW1wb3JhcmlseSBkaXNhYmxlZA0KPiArICAgICAgICAqLw0KPiArICAgICAgIF9f
dTY0ICAgbm1pc3NlZDsNCj4gKyAgICAgICAvKg0KPiArICAgICAgICAqIFNldCBieSB0aGUga2Vy
bmVsIHRvIGluZGljYXRlIG51bWJlciBvZiB0aW1lcyB0aGlzIGtwcm9iZQ0KPiArICAgICAgICAq
IHdhcyBoaXQNCj4gKyAgICAgICAgKi8NCj4gKyAgICAgICBfX3U2NCAgIG5oaXQ7DQo+ICt9Ow0K
PiArDQo+ICAgLyoNCj4gICAgKiBJb2N0bHMgdGhhdCBjYW4gYmUgZG9uZSBvbiBhIHBlcmYgZXZl
bnQgZmQ6DQo+ICAgICovDQo+IEBAIC00NjIsNiArNDg0LDcgQEAgc3RydWN0IHBlcmZfZXZlbnRf
cXVlcnlfYnBmIHsNCj4gICAjZGVmaW5lIFBFUkZfRVZFTlRfSU9DX1BBVVNFX09VVFBVVAkJX0lP
VygnJCcsIDksIF9fdTMyKQ0KPiAgICNkZWZpbmUgUEVSRl9FVkVOVF9JT0NfUVVFUllfQlBGCQlf
SU9XUignJCcsIDEwLCBzdHJ1Y3QgcGVyZl9ldmVudF9xdWVyeV9icGYgKikNCj4gICAjZGVmaW5l
IFBFUkZfRVZFTlRfSU9DX01PRElGWV9BVFRSSUJVVEVTCV9JT1coJyQnLCAxMSwgc3RydWN0IHBl
cmZfZXZlbnRfYXR0ciAqKQ0KPiArI2RlZmluZSBQRVJGX0VWRU5UX0lPQ19RVUVSWV9LUFJPQkUJ
CV9JT1dSKCckJywgMTIsIHN0cnVjdCBwZXJmX2V2ZW50X3F1ZXJ5X2twcm9iZSAqKQ0KPiAgIA0K
PiAgIGVudW0gcGVyZl9ldmVudF9pb2NfZmxhZ3Mgew0KPiAgIAlQRVJGX0lPQ19GTEFHX0dST1VQ
CQk9IDFVIDw8IDAsDQo+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYv
cHJvZ190ZXN0cy9hdHRhY2hfcHJvYmUuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9w
cm9nX3Rlc3RzL2F0dGFjaF9wcm9iZS5jDQo+IGluZGV4IDVlY2MyNjdkOThiMC4uNWYxMThlOWEx
NDY5IDEwMDY0NA0KPiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0
cy9hdHRhY2hfcHJvYmUuYw0KPiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJv
Z190ZXN0cy9hdHRhY2hfcHJvYmUuYw0KPiBAQCAtMzgsOSArMzgsMTIgQEAgdm9pZCB0ZXN0X2F0
dGFjaF9wcm9iZSh2b2lkKQ0KPiAgIAlzdHJ1Y3QgYnBmX2xpbmsgKmtyZXRwcm9iZV9saW5rID0g
TlVMTDsNCj4gICAJc3RydWN0IGJwZl9saW5rICp1cHJvYmVfbGluayA9IE5VTEw7DQo+ICAgCXN0
cnVjdCBicGZfbGluayAqdXJldHByb2JlX2xpbmsgPSBOVUxMOw0KPiArCWludCBrcHJvYmVfZmQs
IGtyZXRwcm9iZV9mZDsNCj4gICAJaW50IHJlc3VsdHNfbWFwX2ZkOw0KPiAgIAlzaXplX3QgdXBy
b2JlX29mZnNldDsNCj4gICAJc3NpemVfdCBiYXNlX2FkZHI7DQo+ICsJc3RydWN0IHBlcmZfZXZl
bnRfcXVlcnlfa3Byb2JlIGtwcm9iZV9xdWVyeTsNCj4gKwlzdHJ1Y3QgcGVyZl9ldmVudF9xdWVy
eV9rcHJvYmUga3JldHByb2JlX3F1ZXJ5Ow0KDQpTaW5jZSB5b3UgYXJlIGFkZGluZyBuZXcgZmll
bGRzLCBjb3VsZCB5b3UgdHJ5IHRvIG1haW50YWluIHJldmVyc2UNCkNocmlzdG1hcyBjb2Rpbmcg
c3R5bGU/DQoNCj4gICANCj4gICAJYmFzZV9hZGRyID0gZ2V0X2Jhc2VfYWRkcigpOw0KPiAgIAlp
ZiAoQ0hFQ0soYmFzZV9hZGRyIDwgMCwgImdldF9iYXNlX2FkZHIiLA0KPiBAQCAtMTE2LDYgKzEx
OSw0NiBAQCB2b2lkIHRlc3RfYXR0YWNoX3Byb2JlKHZvaWQpDQo+ICAgCS8qIHRyaWdnZXIgJiB2
YWxpZGF0ZSBrcHJvYmUgJiYga3JldHByb2JlICovDQo+ICAgCXVzbGVlcCgxKTsNCj4gICANCj4g
KwlrcHJvYmVfZmQgPSBicGZfbGlua19fZ2V0X3BlcmZfZmQoa3Byb2JlX2xpbmspOw0KPiArCWlm
IChDSEVDSyhrcHJvYmVfZmQgPCAwLCAia3Byb2JlX2dldF9wZXJmX2ZkIiwNCj4gKwkgICAgImZh
aWxlZCB0byBnZXQgcGVyZiBmZCBmcm9tIGtwcm9iZSBsaW5rXG4iKSkNCj4gKwkJZ290byBjbGVh
bnVwOw0KPiArDQo+ICsJa3JldHByb2JlX2ZkID0gYnBmX2xpbmtfX2dldF9wZXJmX2ZkKGtyZXRw
cm9iZV9saW5rKTsNCj4gKwlpZiAoQ0hFQ0soa3Byb2JlX2ZkIDwgMCwgImtwcm9iZV9nZXRfcGVy
Zl9mZCIsDQoNCnR5cG86IGtwcm9iZV9mZCA9PiBrcmV0cHJvYmVfZmQsIGtyZXRwcm9iZV9nZXRf
cGVyZl9mZD8NCg0KPiArCSAgICAiZmFpbGVkIHRvIGdldCBwZXJmIGZkIGZyb20ga3Byb2JlIGxp
bmtcbiIpKQ0KDQprcmV0cHJvYmUgbGluaz8NCg0KPiArCQlnb3RvIGNsZWFudXA7DQo+ICsNCj4g
KwltZW1zZXQoJmtwcm9iZV9xdWVyeSwgMCwgc2l6ZW9mKGtwcm9iZV9xdWVyeSkpOw0KPiArCWtw
cm9iZV9xdWVyeS5zaXplID0gc2l6ZW9mKGtwcm9iZV9xdWVyeSk7DQo+ICsJZXJyID0gaW9jdGwo
a3Byb2JlX2ZkLCBQRVJGX0VWRU5UX0lPQ19RVUVSWV9LUFJPQkUsICZrcHJvYmVfcXVlcnkpOw0K
PiArCWlmIChDSEVDSyhlcnIsICJnZXRfa3Byb2JlX2lvY3RsIiwNCj4gKwkJICAiZmFpbGVkIHRv
IGlzc3VlIGtwcm9iZSBxdWVyeSBpb2N0bFxuIikpDQo+ICsJCWdvdG8gY2xlYW51cDsNCj4gKwlp
ZiAoQ0hFQ0soa3Byb2JlX3F1ZXJ5Lm5taXNzZWQgPiAwLCAiZ2V0X2twcm9iZV9pb2N0bCIsDQo+
ICsJCSAgInJlYWQgaW5jb3JlY3Qgbm1pc3NlZCBmcm9tIGtwcm9iZV9pb2N0bDogJWxsdVxuIiwN
Cj4gKwkJICBrcHJvYmVfcXVlcnkubm1pc3NlZCkpDQo+ICsJCWdvdG8gY2xlYW51cDsNCj4gKwlp
ZiAoQ0hFQ0soa3Byb2JlX3F1ZXJ5Lm5oaXQgPD0gMCwgImdldF9rcHJvYmVfaW9jdGwiLA0KDQpu
aGl0IGlzIF9fdTY0LCBpdCBjYW5ub3QgYmUgbGVzcyB0aGFuIDAuDQoNCj4gKwkJICAicmVhZCBp
bmNvcmVjdCBuaGl0IGZyb20ga3Byb2JlX2lvY3RsOiAlbGx1XG4iLA0KPiArCQkgIGtwcm9iZV9x
dWVyeS5uaGl0KSkNCj4gKwkJZ290byBjbGVhbnVwOw0KPiArDQo+ICsJbWVtc2V0KCZrcmV0cHJv
YmVfcXVlcnksIDAsIHNpemVvZihrcmV0cHJvYmVfcXVlcnkpKTsNCj4gKwlrcmV0cHJvYmVfcXVl
cnkuc2l6ZSA9IHNpemVvZihrcmV0cHJvYmVfcXVlcnkpOw0KPiArCWVyciA9IGlvY3RsKGtyZXRw
cm9iZV9mZCwgUEVSRl9FVkVOVF9JT0NfUVVFUllfS1BST0JFLCAma3JldHByb2JlX3F1ZXJ5KTsN
Cj4gKwlpZiAoQ0hFQ0soZXJyLCAiZ2V0X2tyZXRwcm9iZV9pb2N0bCIsDQo+ICsJCSAgImZhaWxl
ZCB0byBpc3N1ZSBrcHJvYmUgcXVlcnkgaW9jdGxcbiIpKQ0KPiArCQlnb3RvIGNsZWFudXA7DQo+
ICsJaWYgKENIRUNLKGtyZXRwcm9iZV9xdWVyeS5ubWlzc2VkID4gMCwgImdldF9rcmV0cHJvYmVf
aW9jdGwiLA0KPiArCQkgICJyZWFkIGluY29yZWN0IG5taXNzZWQgZnJvbSBrcmV0cHJvYmVfaW9j
dGw6ICVsbHVcbiIsDQo+ICsJCSAga3JldHByb2JlX3F1ZXJ5Lm5taXNzZWQpKQ0KPiArCQlnb3Rv
IGNsZWFudXA7DQo+ICsJaWYgKENIRUNLKGtyZXRwcm9iZV9xdWVyeS5uaGl0IDw9IDAsICJnZXRf
a3JldHByb2JlX2lvY3RsIiwNCg0KPD0gMCA9PiA9PSAwPw0KDQo+ICsJCSAgInJlYWQgaW5jb3Jl
Y3QgbmhpdCBmcm9tIGtyZXRwcm9iZV9pb2N0bDogJWxsdVxuIiwNCj4gKwkJICBrcmV0cHJvYmVf
cXVlcnkubmhpdCkpDQo+ICsJCWdvdG8gY2xlYW51cDsNCj4gKw0KPiAgIAllcnIgPSBicGZfbWFw
X2xvb2t1cF9lbGVtKHJlc3VsdHNfbWFwX2ZkLCAma3Byb2JlX2lkeCwgJnJlcyk7DQo+ICAgCWlm
IChDSEVDSyhlcnIsICJnZXRfa3Byb2JlX3JlcyIsDQo+ICAgCQkgICJmYWlsZWQgdG8gZ2V0IGtw
cm9iZSByZXM6ICVkXG4iLCBlcnIpKQ0KPiANCg==
