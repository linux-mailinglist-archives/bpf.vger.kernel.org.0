Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A02C26654
	for <lists+bpf@lfdr.de>; Wed, 22 May 2019 16:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbfEVOxC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 May 2019 10:53:02 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37148 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728450AbfEVOxB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 May 2019 10:53:01 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4MEiSk5015190;
        Wed, 22 May 2019 07:51:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=sKbDtBGnVKIRUaCAczgStNECUOVI180S+3MwhCS8lFI=;
 b=LHVMc+/Tw/xPFyA8DqbDJADpMXcHdwQ+9kPZs5iNgMKVElJAl6msaC6n2mlJ/c4f1bn8
 DAlzFBQjtpyt1qJhyTuib1MmzuUz7stRYpMwIHhe+ce5QfiYvT3ybbuKrkee2mhcx8C4
 +4qoCD51avfjv8ePMFyU5kLi9OPotCIXJTU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2smr4jty00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 22 May 2019 07:51:23 -0700
Received: from ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 22 May 2019 07:51:22 -0700
Received: from ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) by
 ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 22 May 2019 07:51:22 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 22 May 2019 07:51:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKbDtBGnVKIRUaCAczgStNECUOVI180S+3MwhCS8lFI=;
 b=tMVyY9n0OBZG+Fk8wHU+QAOjOlCB5iYK/M0qLMex80YU3TEyKd9DuCYJverCDH42qKiiqag+X7aMELAOo0PpulwlD7tUaxmEEKbWI9+xTFGXALuOfE1EjYN5w17HcQfTGoG0OyMDtpX/YylI9F4Oq+uqvnzOn+QgBymy+najJ+8=
Received: from BYAPR15MB2501.namprd15.prod.outlook.com (52.135.196.11) by
 BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.22; Wed, 22 May 2019 14:49:08 +0000
Received: from BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::140e:9c62:f2d3:7f27]) by BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::140e:9c62:f2d3:7f27%7]) with mapi id 15.20.1900.020; Wed, 22 May 2019
 14:49:08 +0000
From:   Alexei Starovoitov <ast@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Kairui Song <kasong@redhat.com>
CC:     Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: Getting empty callchain from perf_callchain_kernel()
Thread-Topic: Getting empty callchain from perf_callchain_kernel()
Thread-Index: AQHVDEJXYtrotGS6bU+cxwR7BKWjbKZu8J8AgAAG+ICAAAFQgIAAD2QAgAO6dwCABHK6gIAADP6A
Date:   Wed, 22 May 2019 14:49:07 +0000
Message-ID: <ab047883-69f6-1175-153f-5ad9462c6389@fb.com>
References: <3CD3EE63-0CD2-404A-A403-E11DCF2DF8D9@fb.com>
 <20190517074600.GJ2623@hirez.programming.kicks-ass.net>
 <20190517081057.GQ2650@hirez.programming.kicks-ass.net>
 <CACPcB9cB5n1HOmZcVpusJq8rAV5+KfmZ-Lxv3tgsSoy7vNrk7w@mail.gmail.com>
 <20190517091044.GM2606@hirez.programming.kicks-ass.net>
 <CACPcB9cpNp5CBqoRs+XMCwufzAFa8Pj-gbmj9fb+g5wVdue=ig@mail.gmail.com>
 <20190522140233.GC16275@worktop.programming.kicks-ass.net>
In-Reply-To: <20190522140233.GC16275@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR07CA0072.namprd07.prod.outlook.com (2603:10b6:100::40)
 To BYAPR15MB2501.namprd15.prod.outlook.com (2603:10b6:a02:88::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::9fb6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b423561-71ac-48fe-3bb5-08d6dec4a3f6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB3384;
x-ms-traffictypediagnostic: BYAPR15MB3384:
x-microsoft-antispam-prvs: <BYAPR15MB338489B644EBFD81C185216CD7000@BYAPR15MB3384.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(366004)(376002)(39860400002)(189003)(199004)(7736002)(305945005)(36756003)(6246003)(54906003)(99286004)(68736007)(14454004)(4326008)(6116002)(478600001)(25786009)(76176011)(2906002)(446003)(486006)(186003)(31686004)(52116002)(476003)(2616005)(386003)(6506007)(53546011)(11346002)(53936002)(46003)(102836004)(316002)(8676002)(6486002)(81156014)(31696002)(71190400001)(71200400001)(86362001)(81166006)(73956011)(256004)(66946007)(6436002)(5024004)(110136005)(5660300002)(229853002)(8936002)(66476007)(66556008)(64756008)(66446008)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3384;H:BYAPR15MB2501.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sa+SP/LIBVUKgSLWeUKvRj0++KKVopvhhvUy8QAn0iaNyiK4WIfxi1veGtoM89mx817l/TfF7dM/aEGGVn3gE8YWNYmwFD7pU9+fej9UenCEHMs9MsBFJKMT/NifleBnYH9RxTtyljpWel5q3cQXQzyRfuGnlDNR3pOxDqbQ0jIxtafv9eYsBQtF7r7edz3e8IiFDgiNjPw8k6hedoplcSjGMDYXOhNBeaFps+E3z6MjhMx0HSkuGj1UU5ppeL2rQKbL+wEk6jztUVyBNEnpxJZUhxI3YZHK3+Q8iKVKEUxC4vTWMUBYt+SGZvK/X9XPx5SWqJe7Wbyb3QJrFCS4twzxVnS2JCOrW7xH5hj6zvGS99UZCvoUXmgkEW13wrropIKisk8CmXx5ZsdPmJV4AaCDc8np8W+tP+c2phVjdhY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F061B130DBC5948B404DEA6DB676E69@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b423561-71ac-48fe-3bb5-08d6dec4a3f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 14:49:08.0274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3384
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-22_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905220105
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gNS8yMi8xOSA3OjAyIEFNLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4gDQo+PiBJZiB0aGUg
dW53aW5kZXIgY291bGQgdHJhY2UgYmFjayB0aHJvdWdoIHRoZSBicGYgZnVuYyBjYWxsIHRoZW4g
dGhlcmUNCj4+IHdpbGwgYmUgbm8gc3VjaCBwcm9ibGVtLg0KPiANCj4gV2h5IGNvdWxkbid0IGl0
IHRyYWNlIGJhY2sgdGhyb3VnaCB0aGUgYnBmIHN0dWZmPyBBbmQgaG93IGNhbiB3ZSBmaXgNCj4g
dGhhdD8NCg0KTW9zdCBvZiB0aGUgdGltZSB0aGVyZSBpcyBubyAndHJhY2luZyB0aHJvdWdoIGJw
ZiBzdHVmZicuDQpicGYgaW5mcmEgaXMgcHJlc2VydmluZyAncHRfcmVncyonIHRoYXQgd2FzIGNv
bGxlY3RlZCBiZWZvcmUNCmFueSBicGYgdGhpbmdzIHN0YXJ0IGV4ZWN1dGluZy4NClRoZSByZWFz
b24gaXMgdGhhdCBicGYgY2FuIGJlIGV4ZWN1dGVkIHZpYSBpbnRlcnByZXRlciBhbmQNCmRpcmVj
dGx5IHdoZW4gSklUZWQuDQpJbiBib3RoIGNhc2VzIGNvbGxlY3RlZCBzdGFjayB0cmFjZXMgc2hv
dWxkIGJlIHRoZSBzYW1lIG9yDQppdCdzIGNvbmZ1c2luZyB0aGUgdXNlcnMgYW5kIHRoZXkgY2Fu
bm90IGNvbXBlbnNhdGUgZm9yIHN1Y2gNCmRpZmZlcmVuY2UuDQoNClRoZSBvbmx5IGV4Y2VwdGlv
biBpcyByYXdfdHJhY2Vwb2ludCwgc2luY2UgaXQncyB0aGUgbW9zdA0KbWluaW1hbGlzdGljIHdh
eSBvZiBjYWxsaW5nIGJwZiBhbmQga2VybmVsIHNpZGUgZG9lc24ndCBkbw0KYW55dGhpbmcgYmVm
b3JlIGNhbGxpbmcgaW50byBicGYuDQpPbmx5IGluIHN1Y2ggY2FzZSBicGYgc2lkZSBoYXMgdG8g
Y2FsbCBwZXJmX2ZldGNoX2NhbGxlcl9yZWdzKCkuDQpTZWUgYnBmX2dldF9zdGFja2lkX3Jhd190
cCgpLg0KQnV0IHRoaXMgdGVzdCBjYXNlIGlzIGFjdHVhbGx5IHdvcmtpbmchDQpJdCdzIGNvdmVy
ZWQgYnkgcHJvZ190ZXN0cy9zdGFja3RyYWNlX21hcF9yYXdfdHAuYyBhbmQNCml0IHBhc3Nlcy4N
ClRoZSBvbmUgdGhhdCBpcyBicm9rZW4gaXMgcHJvZ190ZXN0cy9zdGFja3RyYWNlX21hcC5jDQpU
aGVyZSB3ZSBhdHRhY2ggYnBmIHRvIHN0YW5kYXJkIHRyYWNlcG9pbnQgd2hlcmUNCmtlcm5lbCBz
dXBwb3NlIHRvIGNvbGxlY3QgcHRfcmVncyBiZWZvcmUgY2FsbGluZyBpbnRvIGJwZi4NCkFuZCB0
aGF0J3Mgd2hhdCBicGZfZ2V0X3N0YWNraWRfdHAoKSBpcyBkb2luZy4NCkl0IHBhc3NlcyBwdF9y
ZWdzICh0aGF0IHdhcyBjb2xsZWN0ZWQgYmVmb3JlIGFueSBicGYpDQppbnRvIGJwZl9nZXRfc3Rh
Y2tpZCgpIHdoaWNoIGNhbGxzIGdldF9wZXJmX2NhbGxjaGFpbigpLg0KU2FtZSB0aGluZyB3aXRo
IGtwcm9iZXMsIHVwcm9iZXMuDQoNCg0K
