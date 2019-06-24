Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE85F50037
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2019 05:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfFXDaA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Jun 2019 23:30:00 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9912 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726936AbfFXDaA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 23 Jun 2019 23:30:00 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x5O3StHq013518;
        Sun, 23 Jun 2019 20:29:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=q07u1rapyj2+hD9nQJNdwWG04vJ74NHNepRzJEp7IGU=;
 b=BleYE8qBT1IqCAPSKGA8n7XSuzUDW1gUpxBm2BJ4rx7bBHrlGgmmroB9yiy3tW2vZDkw
 0Vcg2wbnWgfvOeTcHQe5P5lHYS9syHwS+TwlnUQ8xufFKK7ojTLFcQJMy5iCPQpf0BOU
 zZ1k8UkP5wNo/5ZRl2b+JgWeryW2sg7kUW4= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2t9ftnmptb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 23 Jun 2019 20:29:39 -0700
Received: from prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Sun, 23 Jun 2019 20:29:38 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Sun, 23 Jun 2019 20:29:38 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Sun, 23 Jun 2019 20:29:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q07u1rapyj2+hD9nQJNdwWG04vJ74NHNepRzJEp7IGU=;
 b=scLYkqUu26NFs5HeUPmkyZlGwprPmeNctuyn88ldVFs1wtwpe/9bvVVODaC5CHIVZkP6YBBgIVfyL7EnZLZwdJFHmZS0If0g3rV8BKyeL/7pF+WlLHTfbpPYeAB9z8SEaAwLx8GzvKWE6uQNC8Rf82eW4eLhPLXsUqBsy4VcV58=
Received: from BYAPR15MB2501.namprd15.prod.outlook.com (52.135.196.11) by
 BYAPR15MB2248.namprd15.prod.outlook.com (52.135.197.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 03:29:23 +0000
Received: from BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::60a3:8bdd:1ea2:3702]) by BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::60a3:8bdd:1ea2:3702%7]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 03:29:22 +0000
From:   Alexei Starovoitov <ast@fb.com>
To:     Roman Gushchin <guro@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Tejun Heo <tj@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf: fix cgroup bpf release synchronization
Thread-Topic: [PATCH bpf-next] bpf: fix cgroup bpf release synchronization
Thread-Index: AQHVKjTnfXTg4w17SUSy4+EivgF2L6aqJZmA
Date:   Mon, 24 Jun 2019 03:29:21 +0000
Message-ID: <91017042-1b59-6110-dfdd-13cfbbec1ae1@fb.com>
References: <20190624023051.4168487-1-guro@fb.com>
In-Reply-To: <20190624023051.4168487-1-guro@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR15CA0030.namprd15.prod.outlook.com
 (2603:10b6:300:ad::16) To BYAPR15MB2501.namprd15.prod.outlook.com
 (2603:10b6:a02:88::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:2311]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a096a053-f78d-478a-57f1-08d6f85425db
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB2248;
x-ms-traffictypediagnostic: BYAPR15MB2248:
x-microsoft-antispam-prvs: <BYAPR15MB224837A588DD22825328E621D7E00@BYAPR15MB2248.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(346002)(376002)(366004)(189003)(199004)(446003)(52116002)(14454004)(110136005)(99286004)(54906003)(8936002)(81166006)(2906002)(53936002)(305945005)(6246003)(81156014)(31686004)(7736002)(6486002)(229853002)(256004)(8676002)(14444005)(5024004)(6512007)(2501003)(71190400001)(71200400001)(6436002)(36756003)(316002)(76176011)(186003)(25786009)(102836004)(86362001)(2616005)(4326008)(53546011)(66946007)(73956011)(476003)(64756008)(66556008)(66476007)(68736007)(6506007)(66446008)(386003)(46003)(11346002)(478600001)(6116002)(486006)(31696002)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2248;H:BYAPR15MB2501.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fqKg1dux5aDJeYMSoH7eJJ5hUEOJEd2wkAbGL/5c7eUO01r20R3RS0calapsT6w2yV+ZEJZbYN0JQc1ZqcNHaJGg9h2a06LD1Ln3c9JimFNjHWpQ0Cz/tDsLx+knaGjSBb8N+319vZa395NUoBZ+WquQqj2QmGiAztFl1IMzfHBVO0XiAmdxLuNcb6Ah0FxnQv5lAWxSx3et485L/jhNQlEPILsSkcnVzdxKybBI/dCG9CrPiWVpwMsSa+xcmvfmYKC6Xfn6/li8Jd0qRhAheMGm2voYtmEHj7ii0C9iXSsHlakJ5C6OCzkNsVFDD3BNgt7p6zfalV6uCbLNOi0LZP+cvL7MP87CmqVUbsDDV2w3EDOUIGMc7G0shCVyCAYxyYEjV+qTB/eg2jPeaWvDAeds9lCim/5YgN6Ul6GO3U4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <51017A5837F88B4C9B114849454B92EF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a096a053-f78d-478a-57f1-08d6f85425db
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 03:29:21.9184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ast@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2248
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=967 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906240027
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gNi8yMy8xOSA3OjMwIFBNLCBSb21hbiBHdXNoY2hpbiB3cm90ZToNCj4gU2luY2UgY29tbWl0
IDRiZmMwYmIyYzYwZSAoImJwZjogZGVjb3VwbGUgdGhlIGxpZmV0aW1lIG9mIGNncm91cF9icGYN
Cj4gZnJvbSBjZ3JvdXAgaXRzZWxmIiksIGNncm91cF9icGYgcmVsZWFzZSBvY2N1cnMgYXN5bmNo
cm9ub3VzbHkNCj4gKGZyb20gYSB3b3JrZXIgY29udGV4dCksIGFuZCBiZWZvcmUgdGhlIHJlbGVh
c2Ugb2YgdGhlIGNncm91cCBpdHNlbGYuDQo+IA0KPiBUaGlzIGludHJvZHVjZWQgYSBwcmV2aW91
c2x5IG5vbi1leGlzdGluZyByYWNlIGJldHdlZW4gdGhlIHJlbGVhc2UNCj4gYW5kIHVwZGF0ZSBw
YXRocy4gRS5nLiBpZiBhIGxlYWYncyBjZ3JvdXBfYnBmIGlzIHJlbGVhc2VkIGFuZCBhIG5ldw0K
PiBicGYgcHJvZ3JhbSBpcyBhdHRhY2hlZCB0byB0aGUgb25lIG9mIGFuY2VzdG9yIGNncm91cHMg
YXQgdGhlIHNhbWUNCj4gdGltZS4gVGhlIHJhY2UgbWF5IHJlc3VsdCBpbiBkb3VibGUtZnJlZSBh
bmQgb3RoZXIgbWVtb3J5IGNvcnJ1cHRpb25zLg0KPiANCj4gVG8gZml4IHRoZSBwcm9ibGVtLCBs
ZXQncyBwcm90ZWN0IHRoZSBib2R5IG9mIGNncm91cF9icGZfcmVsZWFzZSgpDQo+IHdpdGggY2dy
b3VwX211dGV4LCBhcyBpdCB3YXMgZWZmZWN0aXZlbHkgcHJldmlvdXNseSwgd2hlbiBhbGwgdGhp
cw0KPiBjb2RlIHdhcyBjYWxsZWQgZnJvbSB0aGUgY2dyb3VwIHJlbGVhc2UgcGF0aCB3aXRoIGNn
cm91cCBtdXRleCBoZWxkLg0KPiANCj4gQWxzbyBtYWtlIHN1cmUsIHRoYXQgd2UgZG9uJ3QgbGVh
dmUgYWxyZWFkeSBmcmVlZCBwb2ludGVycyB0byB0aGUNCj4gZWZmZWN0aXZlIHByb2cgYXJyYXlz
LiBPdGhlcndpc2UsIHRoZXkgY2FuIGJlIHJlbGVhc2VkIGFnYWluIGJ5DQo+IHRoZSB1cGRhdGUg
cGF0aC4gSXQgd2Fzbid0IG5lY2Vzc2FyeSBiZWZvcmUsIGJlY2F1c2UgcHJldmlvdXNseQ0KPiB0
aGUgdXBkYXRlIHBhdGggY291bGRuJ3Qgc2VlIHN1Y2ggYSBjZ3JvdXAsIGFzIGNncm91cF9icGYg
YW5kIGNncm91cA0KPiBpdHNlbGYgd2VyZSByZWxlYXNlZCB0b2dldGhlci4NCg0KSSB0aG91Z2h0
IGR5aW5nIGNncm91cCB3b24ndCBoYXZlIGFueSBjaGlsZHJlbiBjZ3JvdXBzID8NCkl0IHNob3Vs
ZCBoYXZlIGJlZW4gZW1wdHkgd2l0aCBubyB0YXNrcyBpbnNpZGUgaXQ/DQpPbmx5IHNvbWUgcmVz
b3VyY2VzIGFyZSBzdGlsbCBoZWxkPw0KbXV0ZXggYW5kIHplcm8gaW5pdCBhcmUgaGlnaGx5IHN1
c3BpY2lvdXMuDQpJdCBmZWVscyB0aGF0IGNncm91cF9icGZfcmVsZWFzZSBpcyBjYWxsZWQgdG9v
IGVhcmx5Lg0KDQpUaGlua2luZyBmcm9tIGFub3RoZXIgYW5nbGUuLi4gaWYgY2hpbGQgY2dyb3Vw
cyBjYW4gc3RpbGwgYXR0YWNoIHRoZW4NCnRoaXMgYnBmX3JlbGVhc2UgaXMgYnJva2VuLiBUaGUg
Y29kZSBzaG91bGQgYmUNCmNhbGxpbmcgX19jZ3JvdXBfYnBmX2RldGFjaCgpIG9uZSBieSBvbmUg
dG8gbWFrZSBzdXJlDQp1cGRhdGVfZWZmZWN0aXZlX3Byb2dzKCkgaXMgY2FsbGVkLCBzaW5jZSBk
ZXNjZW5kYW50IGFyZSBzdGlsbA0Kc29ydC1vZiBhbGl2ZSBhbmQgY2FuIGF0dGFjaD8NCg0KTXkg
bW9uZXkgaXMgb24gJ3RvbyBlYXJseScuDQpNYXkgYmUgY2dyb3VwIGlzIG5vdCBkeWluZyA/DQpK
dXN0IGNncm91cF9za19mcmVlKCkgaXMgY2FsbGVkIG9uIHRoZSBsYXN0IHNvY2tldCBhbmQNCnRo
aXMgYXV0by1kZXRhY2ggbG9naWMgZ290IHRyaWdnZXJlZCBpbmNvcnJlY3RseT8NCg==
