Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8664354AC
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2019 02:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfFEATJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Jun 2019 20:19:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35256 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726341AbfFEATI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 4 Jun 2019 20:19:08 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5504xpc009271;
        Tue, 4 Jun 2019 17:18:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=O94Qyjj2m1bi2SVgDx5TWQMuJ41iIAFo3Qbxx9dzcbI=;
 b=UgY1pnR+dCr5NtmT7zaWkw1bkBmFASW4iBrEztmETAZZwVM2faDNdv4gVqRLdCmabcDU
 7dpetovtFjzEdJSYigic/c2n2WfZMQvYnIpIopOceX/z1ivAcnsN4CPXJN+o5gW5t4io
 XGQw4fmbG4h98jH3BPAoN7/emelnFmqU05M= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2swwg2s7h6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 04 Jun 2019 17:18:48 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 4 Jun 2019 17:18:47 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 4 Jun 2019 17:18:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O94Qyjj2m1bi2SVgDx5TWQMuJ41iIAFo3Qbxx9dzcbI=;
 b=WOnnM3CYJBDQqLpWE83cV59Y9X9RLgege8cT08UZWnT+zwiqianp0ZFfkHpGeW7e5r2ZCDoa48s0uqYx2Cx5MG4kIcrCZjjX2es7o/WaFsY2j/MRb3eP+opq4sV623gnnZqtRuUOSdbUyVpLeKGmbCv3XCo55QzMgZxAznj8uqk=
Received: from BYAPR15MB2968.namprd15.prod.outlook.com (20.178.237.149) by
 BYAPR15MB2456.namprd15.prod.outlook.com (52.135.200.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Wed, 5 Jun 2019 00:18:46 +0000
Received: from BYAPR15MB2968.namprd15.prod.outlook.com
 ([fe80::1ccd:3dd5:6b36:eeed]) by BYAPR15MB2968.namprd15.prod.outlook.com
 ([fe80::1ccd:3dd5:6b36:eeed%5]) with mapi id 15.20.1943.018; Wed, 5 Jun 2019
 00:18:46 +0000
From:   Hechao Li <hechaol@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 0/2] Move bpf_num_possible_cpus() to libbpf_util
Thread-Topic: [PATCH 0/2] Move bpf_num_possible_cpus() to libbpf_util
Thread-Index: AQHVGyZg4tIKyBkdcUi5YVJZMJaJE6aMJ5aA//+ObICAAHkzAP//jZ+A
Date:   Wed, 5 Jun 2019 00:18:46 +0000
Message-ID: <4F4DDA32-3BF0-40D7-BA75-7FA1A9FD0843@fb.com>
References: <20190604223815.2487730-1-hechaol@fb.com>
 <BDC04C37-0C03-4D98-B4F2-437C7A746F88@fb.com>
 <C4921362-A75B-4333-91C7-437B4AA4C854@fb.com>
 <a6761839-7b1c-3504-0a96-28452c5b1450@iogearbox.net>
In-Reply-To: <a6761839-7b1c-3504-0a96-28452c5b1450@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::3:26c3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 767d74f7-763d-4fda-1dd6-08d6e94b6040
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB2456;
x-ms-traffictypediagnostic: BYAPR15MB2456:
x-microsoft-antispam-prvs: <BYAPR15MB24566C3E0E769CDE46719764D5160@BYAPR15MB2456.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00594E8DBA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(396003)(346002)(366004)(39860400002)(189003)(199004)(14454004)(25786009)(8676002)(305945005)(478600001)(6246003)(82746002)(53936002)(73956011)(4326008)(91956017)(76116006)(66556008)(64756008)(66476007)(66446008)(68736007)(81156014)(81166006)(8936002)(66946007)(7736002)(14444005)(256004)(86362001)(36756003)(71190400001)(33656002)(186003)(6116002)(6512007)(446003)(2906002)(2616005)(486006)(11346002)(46003)(6636002)(476003)(6486002)(316002)(53546011)(71200400001)(229853002)(6436002)(54906003)(110136005)(76176011)(102836004)(99286004)(5660300002)(6506007)(83716004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2456;H:BYAPR15MB2968.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iCq/CICfyatPmAuvXoqK8WITkDxqiceWkBmAwQHSodkOcr4QXHrHnhpkyNJ1AUud+pBXq+9YMpguNVMPHSYCUfo7CbfXK6X99l9rQ7ys+Axmq8+qjahcZBvhNDF9lqed0iAcgMAH3FQWGGbIwt3E5q6bOQsZ8OlJvYOaEQ5rQkuOPQwCd39zQFWq02xD+lLFIktzYJh7YlFWuezvNcq8P8JIm47XaMqHpJ2yW6s0t/d6KeCcQP4S5V/r7Xw0kEfWJGPZbHlUU1UJzHHVeozo+V3G/5TQqywNG13v6AARK6sLzF1JFwl+4O34oS2Lh3M1QR3h987VchHv4IoElnF2QE0d+KVdSukwA00H3nilMd7Id6ByMCTBjLjrvbXQQGle83WyQA3diQa9vdcKKaKX0CcQiJhREDFEVm79Zk9RJDA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3FDF214383B56B4B8A994C89FAED426F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 767d74f7-763d-4fda-1dd6-08d6e94b6040
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2019 00:18:46.3039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hechaol@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2456
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-04_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906040152
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SSBsb29rZWQgaW50byBjdXJyZW50IHB1YmxpYyBBUElzIGluIGxpYmJwZi5oIGFuZCBicGYuaC4g
TW9zdCBvZiB0aGVtIHNlZW0gdG8gYmUgZGlyZWN0bHkgcmVsYXRlZCB0byBicGYgb2JqZWN0L3By
b2dyYW0vbWFwLiBCdXQgdGhpcyBmdW5jdGlvbiwgYnBmX251bV9wb3NzaWJsZV9jcHVzKCksIGlz
IGp1c3QgYSB1dGlsaXR5IHVzZWQgd2hpbGUgbG9va2luZyB1cCBwZXItQ1BVIG1hcHMuIEkgYW0g
bm90IHN1cmUgaWYgaXQgaXMgYXBwcm9wcmlhdGUgdG8gbWFrZSBpdCBhbiBvZmZpY2lhbCBBUEku
IFlvbmdob25nLCB0aGUgYXV0aG9yIG9mIGxpYmJwZl91dGlsLmgsIGFsc28gYXNrZWQgbWUgdG8g
cHV0IGl0IGludG8gbGliYnBmX3V0aWwuIEJ1dCBJIGFtIGZpbmUgd2l0aCBlaXRoZXIgd2F5LiBJ
IGNhbiBtb3ZlIGl0IHRvIGxpYmJwZi5oLy5jIGlmIHlvdSBhbGwgYWdyZWUuDQoNClRoYW5rcywN
CkhlY2hhbw0KDQrvu79PbiA2LzQvMTksIDU6MDggUE0sICJEYW5pZWwgQm9ya21hbm4iIDxkYW5p
ZWxAaW9nZWFyYm94Lm5ldD4gd3JvdGU6DQoNCiAgICBPbiAwNi8wNS8yMDE5IDAxOjU0IEFNLCBI
ZWNoYW8gTGkgd3JvdGU6DQogICAgPiBJIHB1dCB0aGUgaW1wbGVtZW50YXRpb24gaW4gbGliYnBm
X3V0aWwuYyBtYWlubHkgYmVjYXVzZSBpdCBkZXBlbmRzIG9uIHByX3dhcm5pbmcgZGVmaW5lZCBp
biBsaWJicGZfaW50ZXJuYWwuaC4gSWYgaW5jbHVkaW5nIGxpYmJwZl9pbnRlcm5hbC5oIGluIGxp
YmJwZl91dGlsLmgsIHRoZW4gdGhlIGludGVybmFsIHN0dWZmIHdpbGwgYmUgZXhwb3NlZCB0byB3
aG9ldmVyIGluY2x1ZGUgbGliYnBmX3V0aWwuaC4gQnV0IGxldCBtZSBrbm93IGlmIHRoZXJlIGlz
IGEgYmV0dGVyIHdheSB0byBwcmludCB0aGUgZXJyb3IgbWVzc2FnZXMgb3RoZXIgdGhhbiBkZXBl
bmRpbmcgb24gbGliYnBmX2ludGVybmFsLiANCiAgICA+IA0KICAgID4gVGhhbmtzLA0KICAgID4g
SGVjaGFvDQogICAgPiANCiAgICA+IE9uIDYvNC8xOSwgNDo0MCBQTSwgIlNvbmcgTGl1IiA8c29u
Z2xpdWJyYXZpbmdAZmIuY29tPiB3cm90ZToNCiAgICA+IA0KICAgID4gICAgIA0KICAgID4gICAg
ID4gT24gSnVuIDQsIDIwMTksIGF0IDM6MzggUE0sIEhlY2hhbyBMaSA8aGVjaGFvbEBmYi5jb20+
IHdyb3RlOg0KICAgID4gICAgID4gDQogICAgPiAgICAgPiBHZXR0aW5nIG51bWJlciBvZiBwb3Nz
aWJsZSBDUFVzIGlzIGNvbW1vbmx5IHVzZWQgZm9yIHBlci1DUFUgQlBGIG1hcHMgDQogICAgPiAg
ICAgPiBhbmQgcGVyZl9ldmVudF9tYXBzLiBQdXR0aW5nIGl0IGludG8gYSBjb21tb24gcGxhY2Ug
Y2FuIGF2b2lkIGR1cGxpY2F0ZSANCiAgICA+ICAgICA+IGltcGxlbWVudGF0aW9ucy4NCiAgICA+
ICAgICA+IA0KICAgID4gICAgID4gSGVjaGFvIExpICgyKToNCiAgICA+ICAgICA+ICBBZGQgYnBm
X251bV9wb3NzaWJsZV9jcHVzIHRvIGxpYmJwZl91dGlsDQogICAgPiAgICAgPiAgVXNlIGJwZl9u
dW1fcG9zc2libGVfY3B1cyBpbiBicGZ0b29sIGFuZCBzZWxmdGVzdHMNCiAgICA+ICAgICA+IA0K
ICAgID4gICAgID4gdG9vbHMvYnBmL2JwZnRvb2wvY29tbW9uLmMgICAgICAgICAgICAgICAgICAg
IHwgNTMgKystLS0tLS0tLS0tLS0tLQ0KICAgID4gICAgID4gdG9vbHMvbGliL2JwZi9CdWlsZCAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0NCiAgICA+ICAgICA+IHRvb2xzL2xpYi9i
cGYvbGliYnBmX3V0aWwuYyAgICAgICAgICAgICAgICAgICB8IDYxICsrKysrKysrKysrKysrKysr
KysNCiAgICA+ICAgICA+IHRvb2xzL2xpYi9icGYvbGliYnBmX3V0aWwuaCAgICAgICAgICAgICAg
ICAgICB8ICA3ICsrKw0KICAgID4gICAgID4gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL2Jw
Zl91dGlsLmggICAgICAgIHwgNDIgKysrLS0tLS0tLS0tLQ0KICAgID4gICAgID4gLi4uL3NlbGZ0
ZXN0cy9icGYvcHJvZ190ZXN0cy9sNGxiX2FsbC5jICAgICAgIHwgIDIgKy0NCiAgICA+ICAgICA+
IC4uLi9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMveGRwX25vaW5saW5lLmMgICB8ICAyICstDQog
ICAgPiAgICAgPiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvdGVzdF9idGYuYyAgICAgICAg
fCAgMiArLQ0KICAgID4gICAgID4gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Rlc3RfbHJ1
X21hcC5jICAgIHwgIDIgKy0NCiAgICA+ICAgICA+IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Jw
Zi90ZXN0X21hcHMuYyAgICAgICB8ICA2ICstDQogICAgPiAgICAgPiAxMCBmaWxlcyBjaGFuZ2Vk
LCA4OCBpbnNlcnRpb25zKCspLCA5MSBkZWxldGlvbnMoLSkNCiAgICA+ICAgICA+IGNyZWF0ZSBt
b2RlIDEwMDY0NCB0b29scy9saWIvYnBmL2xpYmJwZl91dGlsLmMNCiAgICA+ICAgICA+IA0KICAg
ID4gICAgID4gLS0gDQogICAgPiAgICAgPiAyLjE3LjENCiAgICA+ICAgICA+IA0KICAgID4gICAg
IA0KICAgID4gICAgIFRoZSBjaGFuZ2UgaXMgbW9zdGx5IHN0cmFpZ2h0Zm9yd2FyZC4gSG93ZXZl
ciwgSSBhbSBub3Qgc3VyZSB3aGV0aGVyDQogICAgPiAgICAgdGhleSBzaG91bGQgYmUgYWRkZWQg
dG8gbGliYnBmX3V0aWwuaC4gTWF5YmUgbGliYnBmLmggaXMgYSBiZXR0ZXIgDQogICAgPiAgICAg
cGxhY2U/DQogICAgPiAgICAgDQogICAgPiAgICAgRGFuaWVsIGFuZCBBbGV4ZWksIHdoYXQncyB5
b3VyIHJlY29tbWVuZGF0aW9uIGhlcmU/IA0KICAgIA0KICAgIEhtLCBsb29rcyBsaWtlIHRoZSBw
YXRjaCBkaWQgbm90IG1ha2UgaXQgdG8gdGhlIGxpc3QgKHlldD8pLiBBZ3JlZSBpdCBtYWtlcw0K
ICAgIHNlbnNlIHRvIG1vdmUgaXQgaW50byBsaWJicGYgZ2l2ZW4gY29tbW9uIHVzZSBmb3IgcGVy
LUNQVS9wZXJmLWV2ZW50IG1hcHMuDQogICAgR2l2ZW4gZnJvbSB0aGUgZGlmZiBzdGF0IGl0J3Mg
bm90IGFkZGVkIHRvIGxpYmJwZi5tYXAsIGlzIHRoZXJlIGEgcmVhc29uIHRvDQogICAgbm90IGFk
ZCBpdCB0bywgc2F5LCB0b29scy9saWIvYnBmL2xpYmJwZi5jIGFuZCBleHBvc2UgaXQgYXMgb2Zm
aWNpYWwgQVBJPw0KICAgIA0KICAgIFRoYW5rcywNCiAgICBEYW5pZWwNCiAgICANCg0K
