Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D20B216DD5
	for <lists+bpf@lfdr.de>; Wed,  8 May 2019 01:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfEGXba (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 May 2019 19:31:30 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59014 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726091AbfEGXb3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 May 2019 19:31:29 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x47NISKS022490;
        Tue, 7 May 2019 16:31:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=JSJvbUliBU3rVKVcofIr0VufwCgif+s/8dopNgTVl+c=;
 b=d2jx093He6q4IEweyC1qHU2TwhO00fP57DPZ5xHWYSHKTdN2nBafK5lOqZPx+RtDa2An
 6WC2NwNvSg+Jj3TqQZftinXMCCTMym13t2nJeRx5Pd6XX8BnvOpyPnkbG6Pa8zTrFLCR
 EP2/tjbfCW5BhuKMScBD7cfF3D3uUEl8gyM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sbd0rspf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 07 May 2019 16:31:08 -0700
Received: from ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) by
 ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 7 May 2019 16:31:06 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 7 May 2019 16:31:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSJvbUliBU3rVKVcofIr0VufwCgif+s/8dopNgTVl+c=;
 b=hTSBzkuE00jbOc4gIkHuyDZNUIAk/urf1WTa+dopF0QI8HtAYHGAg07V64HaSotPAr+MohHRnah3dmUNXOMYiHiCIkgTFMr42EyldjfMqPGy7XVhhnpmKkHFdbz345Jl7og7w7d+d3/87rBLEbHqER985lK5rArqSH9TfX0mWJk=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1263.namprd15.prod.outlook.com (10.175.3.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Tue, 7 May 2019 23:31:04 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15%11]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 23:31:04 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        "Yonghong Song" <yhs@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: perf BPF annotation output validation
Thread-Topic: perf BPF annotation output validation
Thread-Index: AQHU/F8kWHJANV9Z/EG8f4pTDAMxxKZgYSCA
Date:   Tue, 7 May 2019 23:31:04 +0000
Message-ID: <0444239B-5A9A-4C81-BAD5-73D6BA53E653@fb.com>
References: <20190426183707.GE23426@kernel.org>
In-Reply-To: <20190426183707.GE23426@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:200::2:a662]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d768f14-a239-447c-b202-08d6d34412e8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1263;
x-ms-traffictypediagnostic: MWHPR15MB1263:
x-microsoft-antispam-prvs: <MWHPR15MB1263BD70D1F30593575038A5B3310@MWHPR15MB1263.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(366004)(396003)(376002)(39860400002)(189003)(199004)(305945005)(316002)(25786009)(11346002)(6116002)(99286004)(82746002)(86362001)(54906003)(14454004)(6246003)(102836004)(6506007)(4326008)(6512007)(76116006)(73956011)(66946007)(229853002)(66446008)(53936002)(66476007)(66556008)(64756008)(2906002)(186003)(76176011)(6436002)(6916009)(81166006)(68736007)(81156014)(446003)(36756003)(8676002)(6486002)(7736002)(486006)(476003)(2616005)(57306001)(33656002)(5660300002)(46003)(256004)(83716004)(71200400001)(71190400001)(478600001)(8936002)(50226002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1263;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Jp4tBpQEBYVmwXCUbCUDuHCvasnFpv3/4Po23bKCqKrJ8msG/Ly3tT5kD8NvtsHmNSjndtoK7wG8zVOamDjFNmkb5DwKq+nQy7HA083CmmK4+cimUpITX3UN6ompuSoh4MUf9tH2h8XeKsRIr8C1aIlpO0ECOM33UFcaqsVXeBzSpNauth2aQT6/hXe6Pa3ZGZTFCXdiKV0muQQJMdDTbl+7pan7dSlgonSkxH7CYEqBCrl/02X8u7t5dboMkK9NBMGtkPeCBdw+yGVUjkqIYkIWPX7tIuxD+CsqPW7dnatXgasPMRQe8Iy47d3zkM9dC6YpPDbKshSIsnuQSHybYaRVirdy+4QOxedaHCMiFDDIE2vy+/jwRkkN3zKYbqe/wpmVAXIfpjahh80AZ4aFxGkvrmQoRnqU7W7zlU+uuH4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B200B97EA905F34A9785C98673D523AE@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d768f14-a239-447c-b202-08d6d34412e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 23:31:04.7039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1263
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-07_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905070145
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

U29tZSB1cGRhdGVzIG9uIHRoZXNlIG91dHB1dCBpc3N1ZXMuIA0KDQo+IA0KPiBTb25nLCBJIGFs
c28gbm90aWNlZCB0aGF0IHNvdXJjZSBjb2RlIGlzIG5vdCBiZWluZyBpbnRlcm1peGVkIGZvciB0
aGUNCj4gLS1zdGRpbyBhbm5vdGF0aW9uLCB3aGlsZSBpdCB3b3JrcywgdG8gc29tZSBkZWdyZWUs
IGZvciAnLS10dWknLCBpLmUuDQoNCkkgYW0gbm90IHNlZWluZyBwcm9ibGVtIHdpdGggdGhlIC0t
c3RkaW8yIG91dHB1dCwgbGlrZToNCg0KW3Jvb3RAa2VybmVsdGVzdDAwNS4wMS5mcmMyIH4vYnBm
XSMgfi9wZXJmIGFubm90YXRlIC0tc3RkaW8yIGJwZl9wcm9nXzlhN2ZkNTRlMjJhYWY4ZWJfYnBm
X3Byb2cxIHwgaGVhZCAtbiAzMA0KU2FtcGxlczogMjUgIG9mIGV2ZW50ICdjeWNsZXMnLCA0MDAw
IEh6LCBFdmVudCBjb3VudCAoYXBwcm94Lik6IDE0NjkwMDk0LCBbcGVyY2VudDogbG9jYWwgcGVy
aW9kXQ0KYnBmX3Byb2dfOWE3ZmQ1NGUyMmFhZjhlYl9icGZfcHJvZzEoKSBicGZfcHJvZ185YTdm
ZDU0ZTIyYWFmOGViX2JwZl9wcm9nMQ0KUGVyY2VudCAgICAgIGludCBicGZfcHJvZzEodm9pZCAq
Y3R4KQ0KIDE2LjA0ICAgICAgICAgcHVzaCAgICVyYnANCg0KICAgICAgICAgICAgICAgbW92ICAg
ICVyc3AsJXJicA0KICAgICAgICAgICAgICAgc3ViICAgICQweDMwLCVyc3ANCiAgICAgICAgICAg
ICAgIHN1YiAgICAkMHgyOCwlcmJwDQogIDcuOTggICAgICAgICBtb3YgICAgJXJieCwweDAoJXJi
cCkNCiAgNC4wMyAgICAgICAgIG1vdiAgICAlcjEzLDB4OCglcmJwKQ0KICA0LjAzICAgICAgICAg
bW92ICAgICVyMTQsMHgxMCglcmJwKQ0KICAgICAgICAgICAgICAgbW92ICAgICVyMTUsMHgxOCgl
cmJwKQ0KICAgICAgICAgICAgICAgeG9yICAgICVlYXgsJWVheA0KICAgICAgICAgICAgICAgbW92
ICAgICVyYXgsMHgyMCglcmJwKQ0KICAzLjk5ICAgICAgICAgbW92ICAgICVyZGksJXJieA0KICAg
ICAgICAgICAgICAgeG9yICAgICVlZGksJWVkaQ0KICAgICAgICAgICAgICAgIF9fdTMyIGtleSA9
IDA7DQogICAgICAgICAgICAgICBtb3YgICAgJWVkaSwtMHg0KCVyYnApDQogIDQuMDEgICAgICAg
ICBtb3YgICAgJXJicCwlcnNpDQogICAgICAgICAgICAgaW50IGJwZl9wcm9nMSh2b2lkICpjdHgp
DQogICAgICAgICAgICAgICBhZGQgICAgJDB4ZmZmZmZmZmZmZmZmZmZmYywlcnNpDQogICAgICAg
ICAgICAgICAgZGF0YSA9IGJwZl9tYXBfbG9va3VwX2VsZW0oJnN0YWNrZGF0YV9tYXAsICZrZXkp
Ow0KICAgICAgICAgICAgICAgbW92YWJzICQweGZmZmY4ODlmYzQ0OTE2MDAsJXJkaQ0KDQogICAg
ICAgICAgICAg4oaSIGNhbGxxICAqZmZmZmZmZmZlMGY0ZmFmMQ0KICAgICAgICAgICAgICAgbW92
ICAgICVyYXgsJXIxMw0KICAgICAgICAgICAgICAgIGlmICghZGF0YSkNCiAgICAgICAgICAgICAg
IGNtcCAgICAkMHgwLCVyMTMNCiAgICAgICAgICAgICDihpIgamUgICAgIDANCiAgICAgICAgICAg
ICAgICBkYXRhLT5waWQgPSBicGZfZ2V0X2N1cnJlbnRfcGlkX3RnaWQoKTsNCg0KTWF5YmUgSmly
aSdzIHJlY2VudCBwYXRjaGVzIGZpeGVkIGl0IGFscmVhZHk/IA0KDQo+IHdoZW4geW91IGRvICdw
ZXJmIHRvcCcsIHByZXNzICcvYnBmJyB0byBzaG93IGp1c3Qgc3ltYm9scyB3aXRoIHRoYXQNCj4g
c3Vic3RyaW5nIGFuZCB0aGVuIHByZXNzIGVudGVyIG9yICdBJyB0byBhbm5vdGF0ZSwgd2UgY2Fu
IHNlZSB0aGUNCj4gb3JpZ2luYWwgQyBzb3VyY2UgY29kZSBmb3IgdGhlIEJQRiBwcm9ncmFtLCBi
dXQgaXQgaXMgbWFuZ2xpbmcgdGhlDQo+IHNjcmVlbiBzb21ldGltZXMsIEkgbmVlZCB0byB0cnkg
YW5kIGZpeCwgcGxlYXNlIHRha2UgYSBsb29rIGlmIHlvdSBoYXZlDQo+IHRoZSB0aW1lLg0KDQpT
dGlsbCBuZWVkIHRvIGxvb2sgaW50byB0aGUgbWFuZ2xpbmcgaXNzdWUuIA0KDQo+IA0KPiBBbHNv
IHRoaW5ncyBsaWtlIHRoZSBjYWxscSB0YXJnZXRzIG5lZWQgc29tZSB3b3JrIHRvIHRlbGwgd2hh
dCBmdW5jdGlvbg0KPiBpcyB0aGF0LCB3aGljaCBhcyBJIHNhaWQgaXNuJ3QgYXBwZWFyaW5nIG9u
IHRoZSAtLXN0ZGlvMiBvdXRwdXQsIGJ1dA0KPiBhcHBlYXJzIG9uIHRoZSAtLXR1aSwgaS5lLiB3
ZSBuZWVkIHRvIHJlc29sdmUgdGhhdCBzeW1ib2wgdG8gY2hlY2sgaG93DQo+IHRvIG1hcCBiYWNr
IHRvIGEgQlBGIGhlbHBlciBvciBhbnkgb3RoZSBjYWxscSB0YXJnZXQuDQoNClN0aWxsIG5lZWQg
dG8gbG9vayBpbnRvIHJlc29sdmluZyBzeW1ib2xzLiANCg0KPiANCj4gQWxzbywgd2hhdCBhYm91
dCB0aG9zZSAnamUgMCcsIGkuZS4gdGhlIHRhcmdldCBpcyBiZWluZyBtaXNpbnRlcnByZXRlZA0K
PiBvciBpcyB0aGlzIHNvbWUgQlBGIGNvbnN0cnVjdCBJIHNob3VsZCd2ZSBrbm93IGFib3V0PyA6
KQ0KPiANCj4gIDIuNjggICAwLjAwICAgMC4wMCAgIDAuMDAgICAgICAgICBtb3YgICAgJXJkaSwl
cmJ4ICAgICAgICAgICAgICAgICAgICANCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAg4oaSIGNhbGxxICAqZmZmZmZmZmZkMzU5NDg3ZiAgICAgICAgICAgIA0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIG1vdiAgICAlZWF4LC0weDE0OCglcmJwKSAgICAgICAg
ICAgIA0KPiAgOS42MSAgIDAuMDAgICAwLjAwICAgMC4wMCAgICAgICAgIG1vdiAgICAlcmJwLCVy
c2kgICAgICAgICAgICAgICAgICAgIA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGFkZCAgICAkMHhmZmZmZmZmZmZmZmZmZWI4LCVyc2kgICAgIA0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIG1vdmFicyAkMHhmZmZmOWQ1NTZjNzc2YzAwLCVyZGkNCj4g
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIOKGkiBjYWxscSAgKmZmZmZmZmZm
ZDM1OTViMmYgICAgICAgICAgICANCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBjbXAgICAgJDB4MCwlcmF4ICAgICAgICAgICAgICAgICAgICANCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAg4oaSIGplICAgICAwICAgICAgICAgICAgICAgICAgICAgICAgICAg
IA0KPiAgMC4wMCAgIDEuMjUgICAwLjAwICAgMC4wMCAgICAgICAgIGFkZCAgICAkMHgzOCwlcmF4
ICAgICAgICAgICAgICAgICAgIA0KPiAgMC44MCAgIDAuMjEgICAwLjAwICAgMC4wMCAgICAgICAg
IHhvciAgICAlcjEzZCwlcjEzZCAgICAgICAgICAgICAgICAgIA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGNtcCAgICAkMHgwLCVyYXggICAgICAgICAgICAgICAgICAgIA0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICDihpIgam5lICAgIDAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
bW92ICAgICVyYnAsJXJkaSAgICAgICAgICAgICAgICAgICAgDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgYWRkICAgICQweGZmZmZmZmZmZmZmZmZlYjgsJXJkaQ0KPiANCg0K
VGhlICdqZSAwJyBpc3N1ZSBpcyB0cmlja3kuIFRoZSBtYWdpYyBoYXBwZW5zIGluIF9fYW5ub3Rh
dGlvbl9saW5lX193cml0ZSgpLiANCkJlY2F1c2Ugc3ltYm9sX19kaXNhc3NlbWJsZV9icGYoKSB0
YWtlcyBzb21lIHNob3J0IGN1dHMsIGl0IGRvZXNuJ3QgcHJvdmlkZQ0KZGF0YSBpZGVudGljYWwg
dG8gb2JqZHVtcC4gSW4gdGhpcyBjYXNlLCBzeW1ib2xfX2Rpc2Fzc2VtYmxlX2JwZigpIGdlbmVy
YXRlcyANCnNvbWV0aGluZyBsaWtlIA0KDQogICAgIGplICAgICAweDAwMDAwMDAwMDAwMDAxN2EN
Cg0Kd2hpY2ggaXMgdGhlIHNhbWUgYXMgd2hhdCB3ZSBzZWUgZnJvbSBicGZ0b29sIGR1bXAuIERp
c2Fzc2VtYmxlIG9mIGtlcm5lbCANCmZ1bmN0aW9ucyBsb29rcyBsaWtlIA0KDQogICAgIGptcCAg
ICBmZmZmZmZmZjgxMTBhM2VmIDxxdWV1ZWRfc3Bpbl9sb2NrX3Nsb3dwYXRoKzB4MTJmPg0KDQpf
X2Fubm90YXRpb25fbGluZV9fd3JpdGUoKSB3cml0ZXMgdGhlIGZpcnN0IG9uZSBhcyANCiAgICAg
DQogICAgIGplICAwDQoNCndoaWxlIHdyaXRlcyB0aGUgc2Vjb25kIG9uZSBhcw0KDQogICDihpEg
am1wICAgICAgICAxMmYNCg0KVGhlcmVmb3JlLCB0aGUgcHJvYmxlbSBpcyBub3QgZnJvbSBkaXNh
c3NlbWJsZXIoKSBjYWxsLCBidXQgZnJvbSB0aGUgcG9zdA0KcHJvY2Vzc2luZyBvZiBpdC4gSSBz
dGlsbCBuZWVkIHRpbWUgdG8gZmlndXJlIG91dCB0aGUgYmVzdCB3YXkgdG8gZml4IHRoaXMuIA0K
QW55IHN1Z2dlc3Rpb25zIGFyZSBoaWdobHkgYXBwcmVjaWF0ZWQuIA0KDQpUaGFua3MsDQpTb25n
DQoNCg0K
