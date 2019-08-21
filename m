Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD3BD98352
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2019 20:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbfHUSoI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Aug 2019 14:44:08 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54026 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728511AbfHUSoH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 21 Aug 2019 14:44:07 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7LIXmLw030294;
        Wed, 21 Aug 2019 11:43:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ZF82EjY/seItOsECRLqLxB69TEhoMdDBTLlaBG9AjI8=;
 b=hFRSSPAi4kqyQ3XwUuuE09zaL7csdbXfztXKIC58NOQmKrPDGFygzpPjL9shHbm5nKIe
 hM4yYpSzU9pEQGYkjSRlqPgK2T0CJ37u/7DsoJbgDJ/TUJIUbLH9beeni0AvSUCvzrz4
 WLGnYEYzipNAA406qzcZasjGmyrgdC2DkMA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2uh867s21v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 21 Aug 2019 11:43:54 -0700
Received: from ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 21 Aug 2019 11:43:53 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 21 Aug 2019 11:43:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hA4BNgzzxvcI98+xYVrKoaFz4wp8NG2vV6ZeYKrIfGbqHpgP0snMbPrWjxIEt/smqNb1vhLFUBuZKcdfuMFO1s98LfK6EhFbGOP4gCbcZnzftmmqCIxW9TZY5PO0Gz8OL4lvQZz5ABvNrpOrUh0yeYDvXU+qNMKUJa7KVH8ILmOJ+RPikBM2oaBhGkbjCid1J499nwW1HpaZwjBZ7iYB3OtDTkI5F8Obmt1fe02eNPLm9VEoZBHv6tVsjs553qLNAY/AuCPo4wJRemqfM8Jk3sX2nvmlx9ctLwhCYuRHQ9QUl3Oayu3PhbygBs17VRx3z7D+q2lhr9IxiGfUMQY+Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZF82EjY/seItOsECRLqLxB69TEhoMdDBTLlaBG9AjI8=;
 b=HC9KPFeLlpJqMfBv5f+vO5GKNy1hkhQXkNR++Itq5lWeDs6lzTo3gNfj2nR5gI7ga4amHe2iZ0uPSj/H2CpJ/K/5nZeIECwxHqDF9tklmh4YDhpaspARFgTkaqNpN/mldxsejNKEFfKV61CMxxFRUn2X9QOekdCREIXQTIakrvangkaYoW9ea2WZZ0tETYPdEszKp2qUm8wZ3h/UC3CUEFHbukNkwHhPIYRYDaGHAj3ILddLe/aU4n5xXE4UN7lHpIiIxeaB3WJAl2G4SzBdDGoajSDeS6swP5a8yq04d1DPNV/1oH7r/0vN2xQBQbtEXOfuiW6HJHj10pCiEhIqZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZF82EjY/seItOsECRLqLxB69TEhoMdDBTLlaBG9AjI8=;
 b=S9JXzYIMngACeB5lxazX9KKviYBRZZY+5njhYtuCbcGYCQBFSn4Bu2L9Mwi76p90PoJIlsEJixpe7RSmL+gXeLeuFhJVbP0ZADrbEEMXPTHMvbBo+A4xRDzB8lJjZuk9Z6uB/ZhNoYKkg2vb0u6WYvPOJkWoMOwVVsLcmNEKboY=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2661.namprd15.prod.outlook.com (20.179.156.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Wed, 21 Aug 2019 18:43:49 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d95b:271:fa7e:e978]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d95b:271:fa7e:e978%5]) with mapi id 15.20.2178.020; Wed, 21 Aug 2019
 18:43:49 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Daniel Xu <dxu@dxuuu.xyz>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>
Subject: Re: [PATCH v3 bpf-next 1/4] tracing/probe: Add
 PERF_EVENT_IOC_QUERY_PROBE ioctl
Thread-Topic: [PATCH v3 bpf-next 1/4] tracing/probe: Add
 PERF_EVENT_IOC_QUERY_PROBE ioctl
Thread-Index: AQHVWBDfYHIXKLzjJEaHryqNNkv52KcFXMkAgACQf4CAAANPgA==
Date:   Wed, 21 Aug 2019 18:43:49 +0000
Message-ID: <5ecdcd72-255d-26d1-baf3-dc64498753c2@fb.com>
References: <20190820144503.GV2332@hirez.programming.kicks-ass.net>
 <BWENHQJIN885.216UOYEIWNGFU@dlxu-fedora-R90QNFJV>
 <20190821110856.GB2349@hirez.programming.kicks-ass.net>
 <62874df3-cae0-36a1-357f-b59484459e52@fb.com>
 <20190821183155.GE2349@hirez.programming.kicks-ass.net>
In-Reply-To: <20190821183155.GE2349@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR13CA0044.namprd13.prod.outlook.com
 (2603:10b6:300:95::30) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:f330]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbd2d10d-87ca-4c62-15d7-08d726678169
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB2661;
x-ms-traffictypediagnostic: BYAPR15MB2661:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB266109363152EC07B59DA9C1D3AA0@BYAPR15MB2661.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(39860400002)(136003)(199004)(189003)(36756003)(64756008)(7416002)(81156014)(66556008)(386003)(14454004)(81166006)(6506007)(54906003)(53546011)(478600001)(52116002)(31686004)(2906002)(6512007)(76176011)(71200400001)(5660300002)(31696002)(6116002)(186003)(102836004)(6436002)(6486002)(66446008)(6246003)(316002)(86362001)(8936002)(71190400001)(4326008)(53936002)(256004)(8676002)(2616005)(6916009)(46003)(229853002)(486006)(66476007)(66946007)(446003)(7736002)(5024004)(25786009)(476003)(99286004)(305945005)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2661;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4bXSgARJQXUjD421AD/kzFZH17qImeVWB+1lEb42IJHdltk1fvA1eVg+aMr/WYIGrFVLzQBU4uhA+AmY9tP6p0dYCd7Adfo2+JxdGrYiKcxT9taVLo2+r5P7vULHxg5fKPwCEcG4uGbD5aT6Q3T5E6gW4hz+jMpTA5rPBvTU6GTZswShw98kdz+uh1CGncSU0k+9/nGHi0AgBAbJ4cnuBjvmQE+zEQ9bV4sxUZrr25qQoZ0A3RCfsQdwd7885n3poiMZZ8GsHsuWVooY9evEKsWaiOyCHUGXycGsJoI7z2nfSiKRSlknfzBT6uvNvu5SgOaYngR535GNwR6x7YMRG9LTQlX/cF0wavVtOeLSXzmWaDcs7+elvh+dpsDA47VwnayH3PtioktUM8fuwy/492pjZl/l/YLxjbS3OtWVwQg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E33811E1312E6D41A5C997F352A1FE8B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd2d10d-87ca-4c62-15d7-08d726678169
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 18:43:49.2898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 88nKzxg/zogw0YNCv5cfQ+6LTVpEcO6wBgp/nOK0IBb0gxoJD+ET3JhEdeoOsYEM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2661
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-21_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908210182
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDgvMjEvMTkgMTE6MzEgQU0sIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBPbiBXZWQs
IEF1ZyAyMSwgMjAxOSBhdCAwNDo1NDo0N1BNICswMDAwLCBZb25naG9uZyBTb25nIHdyb3RlOg0K
Pj4gQ3VycmVudGx5LCBpbiBrZXJuZWwvdHJhY2UvYnBmX3RyYWNlLmMsIHdlIGhhdmUNCj4+DQo+
PiB1bnNpZ25lZCBpbnQgdHJhY2VfY2FsbF9icGYoc3RydWN0IHRyYWNlX2V2ZW50X2NhbGwgKmNh
bGwsIHZvaWQgKmN0eCkNCj4+IHsNCj4+ICAgICAgICAgICB1bnNpZ25lZCBpbnQgcmV0Ow0KPj4N
Cj4+ICAgICAgICAgICBpZiAoaW5fbm1pKCkpIC8qIG5vdCBzdXBwb3J0ZWQgeWV0ICovDQo+PiAg
ICAgICAgICAgICAgICAgICByZXR1cm4gMTsNCj4+DQo+PiAgICAgICAgICAgcHJlZW1wdF9kaXNh
YmxlKCk7DQo+Pg0KPj4gICAgICAgICAgIGlmICh1bmxpa2VseShfX3RoaXNfY3B1X2luY19yZXR1
cm4oYnBmX3Byb2dfYWN0aXZlKSAhPSAxKSkgew0KPiANCj4gWWVzLCBJJ20gYXdhcmUgb2YgdGhh
dC4NCj4gDQo+PiBJbiB0aGUgYWJvdmUsIHRoZSBldmVudHMgd2l0aCBicGYgcHJvZ3JhbSBhdHRh
Y2hlZCB3aWxsIGJlIG1pc3NlZA0KPj4gaWYgdGhlIGNvbnRleHQgaXMgbm1pIGludGVycnVwdCwg
b3IgaWYgc29tZSByZWN1cnNpb24gaGFwcGVucyBldmVuIHdpdGgNCj4+IHRoZSBzYW1lIG9yIGRp
ZmZlcmVudCBicGYgcHJvZ3JhbXMuDQo+PiBJbiBjYXNlIG9mIHJlY3Vyc2lvbiwgdGhlIGV2ZW50
cyB3aWxsIG5vdCBiZSBzZW50IHRvIHJpbmcgYnVmZmVyLg0KPiANCj4gQW5kIHdoaWxlIHRoYXQg
aXMgc2lnbmlmaWNhbnRseSB3b3JzZSB0aGFuIHdoYXQgZnRyYWNlL3BlcmYgaGF2ZSwgaXQgaXMN
Cj4gZnVuZGFtZW50YWxseSB0aGUgc2FtZSB0aGluZy4NCj4gDQo+IHBlcmYgYWxsb3dzIChhbmQg
aWlyYyBmdHJhY2UgZG9lcyB0b28pIDQgbmVzdGVkIGNvbnRleHQgcGVyIENQVQ0KPiAodGFzayxz
b2Z0aXJxLGlycSxubWkpIGJ1dCBhbnkgcmVjdXJzaW9uIHdpdGhpbiB0aG9zZSBjb250ZXh0IGFu
ZCB3ZQ0KPiBkcm9wIHN0dWZmLg0KPiANCj4gVGhlIEJQRiBzdHVmZiBpcyBqdXN0IG1vcmUgZWFn
ZXIgdG8gZHJvcCB0aGluZ3Mgb24gdGhlIGZsb29yLCBidXQgaXQgaXMNCj4gZnVuZGFtZW50YWxs
eSB0aGUgc2FtZS4NCj4gDQo+PiBBIGxvdCBvZiBicGYtYmFzZWQgdHJhY2luZyBwcm9ncmFtcyB1
c2VzIG1hcHMgdG8gY29tbXVuaWNhdGUgYW5kDQo+PiBkbyBub3QgYWxsb2NhdGUgcmluZyBidWZm
ZXIgYXQgYWxsLg0KPiANCj4gU28gZXh0ZW5kaW5nIFBFUkZfUkVDT1JEX0xPU1QgZG9lc24ndCB3
b3JrLiBCdXQgUEVSRl9GT1JNQVRfTE9TVCBtaWdodA0KPiBzdGlsbCB3b3JrIGZpbmU7IGJ1dCB5
b3UgZ2V0IHRvIGltcGxlbWVudCBpdCBmb3IgYWxsIHNvZnR3YXJlIGV2ZW50cy4NCg0KQ291bGQg
eW91IGdpdmUgbW9yZSBzcGVjaWZpY3MgYWJvdXQgUEVSRl9GT1JNQVRfTE9TVD8gR29vZ2xpbmcg
DQoiUEVSRl9GT1JNQVRfTE9TVCIgb25seSB5aWVsZHMgdHdvIGVtYWlscyB3aGljaCB3ZSBhcmUg
ZGlzY3Vzc2luZyBoZXJlIDotKA0KDQo+IA0KPj4gTWF5YmUgd2UgY2FuIHN0aWxsIHVzZSBpb2N0
bCBiYXNlZCBhcHByb2FjaCB3aGljaCBpcyBsaWdodCB3ZWlnaHRlZA0KPj4gY29tcGFyZWQgdG8g
cmluZyBidWZmZXIgYXBwcm9hY2g/IElmIGEgZmQgaGFzIGJwZiBhdHRhY2hlZCwgbmhpdC9ubWlz
c2VzDQo+PiBtZWFucyB0aGUga3Byb2JlIGlzIHByb2Nlc3NlZCBieSBicGYgcHJvZ3JhbSBvciBu
b3QuDQo+IA0KPiBUaGVyZSBpcyBub3RoaW5nIGtwcm9iZSBzcGVjaWZpYyBoZXJlLiBLcHJvYmVz
IGp1c3QgYXBwZWFyIHRvIGJlIHRoZQ0KPiBvbmx5IG9uZSBhY3R1YWxseSBhY2NvdW50aW5nIHRo
ZSByZWN1cnNpb24gY2FzZXMsIGJ1dCBldmVyeW9uZSBoYXMNCj4gdGhlbS4NCg0KU29ycnkgdG8g
YmUgc3BlY2lmaWMsIGtwcm9iZSBpcyBqdXN0IGFuIGV4YW1wbGUsIEkgYWN0dWFsbHkgcmVmZXJz
IHRvIA0KYW55IHBlcmYgZXZlbnQgd2hlcmUgYnBmIGNhbiBhdHRhY2ggdG8sIHdoaWNoIHRoZW9y
ZXRpY2FsbHkgYXJlIGFueQ0KcGVyZiBldmVudHMgd2hpY2ggY2FuIGJlIG9wZW5lZCB3aXRoICJw
ZXJmX2V2ZW50X29wZW4iIHN5c2NhbGwgYWx0aG91Z2ggDQpzb21lIG9mIHRoZW0gKGUuZy4sIHNv
ZnR3YXJlIGV2ZW50cz8pIG1heSBub3QgaGF2ZSBicGYgcnVubmluZyBob29rcyB5ZXQuDQoNCj4g
DQo+PiBDdXJyZW50bHksIGZvciBkZWJ1Z2ZzLCB0aGUgbmhpdC9ubWlzc2VzIGluZm8gaXMgZXhw
b3NlZCBhdA0KPj4ge2t8dX1wcm9iZV9wcm9maWxlLiBBbHRlcm5hdGl2ZSwgd2UgY291bGQgZXhw
b3NlIHRoZSBuaGl0L25taXNzZXMNCj4+IGluIC9wcm9jL3NlbGYvZmRpbmZvLzxmZD4uIFVzZXIg
Y2FuIHF1ZXJ5IHRoaXMgaW50ZXJmYWNlIHRvDQo+PiBnZXQgbnVtYmVycy4NCj4gDQo+IE5vLCB3
ZSdyZSBub3QgYWRkaW5nIHN0dWZmIHRvIHByb2NmcyBmb3IgdGhpcy4NCg0KTm8gcHJvYmxlbS4g
SnVzdCBhIHN1Z2dlc3Rpb24uDQo=
