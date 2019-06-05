Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50946362E5
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2019 19:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfFERlX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Jun 2019 13:41:23 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39208 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726593AbfFERlX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 5 Jun 2019 13:41:23 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x55HWj85014524;
        Wed, 5 Jun 2019 10:41:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=5J/khWFyC5JmBjOzgmVwttmm/xf9yC1tw8/rBLpme9Q=;
 b=olL8dq8u0Eu9pU7/bayQOBfV+bjp/cFfm3ND921JJ/qdiSlfIgcSNCSxbtFwpde7GsPS
 v1/JmCDkHvHNS+OX0Djx9a90iyxZGYZ1KiOXec98/vxwINyWPYmB2N3D5/GrJjf/wFaM
 XXr7PNzvMuP59uRwyd5hV5I/+43d0LBSGb4= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sxg7h0hhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 05 Jun 2019 10:41:02 -0700
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 5 Jun 2019 10:41:01 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 5 Jun 2019 10:41:01 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 5 Jun 2019 10:41:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5J/khWFyC5JmBjOzgmVwttmm/xf9yC1tw8/rBLpme9Q=;
 b=LAmUCs0s/nDgUk85hzy2ZmuTZu+3AMMMq2K/BbpQjQwxrHLw29GWNZbq0XMpYNOkRBiPZfl19zYcYRpFt2MBKs6lkl9GweMhFOnACa9pRgIvUctYhTyqg06LKtVjD+0RTRtYyR+M3S2Ywi3Oa8dS6KpybHIR5AazXOQxH/9Q4YQ=
Received: from BYAPR15MB2968.namprd15.prod.outlook.com (20.178.237.149) by
 BYAPR15MB3432.namprd15.prod.outlook.com (20.179.59.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Wed, 5 Jun 2019 17:40:59 +0000
Received: from BYAPR15MB2968.namprd15.prod.outlook.com
 ([fe80::1ccd:3dd5:6b36:eeed]) by BYAPR15MB2968.namprd15.prod.outlook.com
 ([fe80::1ccd:3dd5:6b36:eeed%5]) with mapi id 15.20.1965.011; Wed, 5 Jun 2019
 17:40:59 +0000
From:   Hechao Li <hechaol@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH 0/2] Move bpf_num_possible_cpus() to libbpf_util
Thread-Topic: [PATCH 0/2] Move bpf_num_possible_cpus() to libbpf_util
Thread-Index: AQHVGyZg4tIKyBkdcUi5YVJZMJaJE6aMJ5aA//+ObICAAHkzAP//jZ+AgAE3sAD//+uBAA==
Date:   Wed, 5 Jun 2019 17:40:59 +0000
Message-ID: <8E01213E-C06A-4251-9982-FF8394A4BFF5@fb.com>
References: <20190604223815.2487730-1-hechaol@fb.com>
 <BDC04C37-0C03-4D98-B4F2-437C7A746F88@fb.com>
 <C4921362-A75B-4333-91C7-437B4AA4C854@fb.com>
 <a6761839-7b1c-3504-0a96-28452c5b1450@iogearbox.net>
 <4F4DDA32-3BF0-40D7-BA75-7FA1A9FD0843@fb.com>
 <2a6ab005-0ac1-be09-d5dc-05ea672cbf9a@iogearbox.net>
In-Reply-To: <2a6ab005-0ac1-be09-d5dc-05ea672cbf9a@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::8a3e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6867376b-b353-4c19-1a53-08d6e9dcf8e2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB3432;
x-ms-traffictypediagnostic: BYAPR15MB3432:
x-microsoft-antispam-prvs: <BYAPR15MB343271A0285FDC1A7E6C4CFCD5160@BYAPR15MB3432.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00594E8DBA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(376002)(136003)(39860400002)(199004)(189003)(71200400001)(6116002)(81156014)(76116006)(8936002)(33656002)(316002)(54906003)(110136005)(83716004)(66946007)(66446008)(64756008)(73956011)(66556008)(66476007)(81166006)(8676002)(14454004)(6246003)(305945005)(46003)(6486002)(229853002)(446003)(71190400001)(86362001)(6436002)(7736002)(6512007)(11346002)(5660300002)(53936002)(2616005)(476003)(478600001)(486006)(76176011)(82746002)(4326008)(36756003)(2906002)(99286004)(25786009)(68736007)(6636002)(6506007)(14444005)(186003)(256004)(102836004)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3432;H:BYAPR15MB2968.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4e7md4DpH4BipTua7rj/1rWADA9f5f9bP+u4l+WUeNH7d4aQaGXKqEeq1dyxN4YxNgQmWGGIHn/7s8AIZ6QuIKQFb7gfbW8CH5mlatGV6ZJ/CTKKL4wZaeZfcCe+l0ircx3lwgbYk+sdYUe5lYTcPuhCrSIIiUNUf4lBMd6FwrwbDgovSfIEBdOErSD8fhnqgb+/OFsfxlrNgJSl4O8ZUYvJmT9OTT+SV3MS5kP78DqYmlRjVc5a5CwuuRczch3/LpeBDlEPyXGlv/yunxyBT0GlG3biubInCPCcmNsCelU+D48GSq6Vb2iByssmWFwNrqoQFMr5snCkfhIsVwBBJJy4zBEtctQmjmZk/igaZ8evw0poFmXP0/5dQ9IhYDhan3fBQyx4fCTWULz7MF2Pbq5XqWqBaFYNJhuoNtDYIZs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A999C5A344484E40B2CD45C6D1F91075@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6867376b-b353-4c19-1a53-08d6e9dcf8e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2019 17:40:59.5239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hechaol@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3432
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-05_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906050110
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQo+IE9uIEp1biA1LCAyMDE5LCBhdCA0OjU0IEFNLCBEYW5pZWwgQm9ya21hbm4gPGRhbmllbEBp
b2dlYXJib3gubmV0PiB3cm90ZToNCj4NCj4gT24gMDYvMDUvMjAxOSAwMjoxOCBBTSwgSGVjaGFv
IExpIHdyb3RlOg0KPj4gSSBsb29rZWQgaW50byBjdXJyZW50IHB1YmxpYyBBUElzIGluIGxpYmJw
Zi5oIGFuZCBicGYuaC4gTW9zdCBvZiB0aGVtIHNlZW0gdG8gYmUgZGlyZWN0bHkgcmVsYXRlZCB0
byBicGYgb2JqZWN0L3Byb2dyYW0vbWFwLiBCdXQgdGhpcyBmdW5jdGlvbiwgYnBmX251bV9wb3Nz
aWJsZV9jcHVzKCksIGlzIGp1c3QgYSB1dGlsaXR5IHVzZWQgd2hpbGUgbG9va2luZyB1cCBwZXIt
Q1BVIG1hcHMuIEkgYW0gbm90IHN1cmUgaWYgaXQgaXMgYXBwcm9wcmlhdGUgdG8gbWFrZSBpdCBh
biBvZmZpY2lhbCBBUEkuIFlvbmdob25nLCB0aGUgYXV0aG9yIG9mIGxpYmJwZl91dGlsLmgsIGFs
c28gYXNrZWQgbWUgdG8gcHV0IGl0IGludG8gbGliYnBmX3V0aWwuIEJ1dCBJIGFtIGZpbmUgd2l0
aCBlaXRoZXIgd2F5LiBJIGNhbiBtb3ZlIGl0IHRvIGxpYmJwZi5oLy5jIGlmIHlvdSBhbGwgYWdy
ZWUuDQo+DQo+IChwbGVhc2UgYXZvaWQgdG9wLXBvc3RpbmcpDQo+DQo+IEl0J3MgYSBnb29kIHF1
ZXN0aW9uLCBJIHRoaW5rIGl0IGRlcGVuZHMgaG93IG11Y2ggd2Ugd2FudCB0byBhaWRlIHVzZXJz
IGNvbnN1bWluZyBsaWJicGYNCj4gdGhhdCBhcmUgdXNpbmcgcGVyLUNQVSBtYXBzLCBmb3IgZXhh
bXBsZS4gSWYgd2Ugb25seSB3YW50IHRvIHJldXNlIGl0IGZvciBpbi10cmVlIHNlbGZ0ZXN0cywN
Cj4gaXQncyBmaW5lIHRvIGtlZXAgaXQgaW4gYW4gdW5leHBvc2VkIGludGVybmFsIGhlYWRlciB0
aGF0IHNlbGZ0ZXN0cyB3b3VsZCBpbmNsdWRlLg0KPiBPdGhlciBvcHRpb24gY291bGQgYmUgdG8g
ZXhwb3NlIGFuZCBwcmVmaXggYXMgbGliYnBmX251bV9wb3NzaWJsZV9jcHVzKCkgdG8gZGVub3Rl
IGl0J3MgYQ0KPiBtaXNjIGhlbHBlciBhbmQgcGVyaGFwcyBhbHNvIG1vdmUgZjM1MTViNWQwYjcx
ICgiYnBmOiBwcm92aWRlIGEgZ2VuZXJpYyBtYWNybyBmb3IgcGVyY3B1DQo+IHZhbHVlcyBmb3Ig
c2VsZnRlc3RzIikgaW50byBsaWJicGYuIEknZCBiZSBmaW5lIGVpdGhlciB3YXksIG15IHByZWZl
cmVuY2UgaXMgdG8gYWRkIGl0DQo+IGFzIGFuIGxpYmJwZl8gQVBJIGdpdmVuIHVzZXJzIHdvdWxk
IG5lZWQgc29tZXRoaW5nIGFsb25nIHRoZXNlIGxpbmVzIHdoZW4gd2Fsa2luZyB0aGUgdmFsdWUN
Cj4gYW55d2F5LiBTZWUgZTAwYzdiMjE2ZjM0ICgiYnBmOiBmaXggbXVsdGlwbGUgaXNzdWVzIGlu
IHNlbGZ0ZXN0IHN1aXRlIGFuZCBzYW1wbGVzIikgZm9yDQo+IGNvbnRleHQgb24gd2h5IHRoaXMg
aGVscGVyIHdhcyBhZGRlZCBhbmQgc3lzY29uZihfU0NfTlBST0NFU1NPUlNfQ09ORikgdXNlIHdv
dWxkIGJlIGJyb2tlbg0KPiBpbiB0aGlzIGNvbnRleHQuDQo+DQo+IFRoYW5rcywNCj4gRGFuaWVs
DQo+DQo+PiBUaGFua3MsDQo+PiBIZWNoYW8NCj4+DQo+PiBPbiA2LzQvMTksIDU6MDggUE0sICJE
YW5pZWwgQm9ya21hbm4iIDxkYW5pZWxAaW9nZWFyYm94Lm5ldD4gd3JvdGU6DQo+Pg0KPj4gICAg
T24gMDYvMDUvMjAxOSAwMTo1NCBBTSwgSGVjaGFvIExpIHdyb3RlOg0KPj4+IEkgcHV0IHRoZSBp
bXBsZW1lbnRhdGlvbiBpbiBsaWJicGZfdXRpbC5jIG1haW5seSBiZWNhdXNlIGl0IGRlcGVuZHMg
b24gcHJfd2FybmluZyBkZWZpbmVkIGluIGxpYmJwZl9pbnRlcm5hbC5oLiBJZiBpbmNsdWRpbmcg
bGliYnBmX2ludGVybmFsLmggaW4gbGliYnBmX3V0aWwuaCwgdGhlbiB0aGUgaW50ZXJuYWwgc3R1
ZmYgd2lsbCBiZSBleHBvc2VkIHRvIHdob2V2ZXIgaW5jbHVkZSBsaWJicGZfdXRpbC5oLiBCdXQg
bGV0IG1lIGtub3cgaWYgdGhlcmUgaXMgYSBiZXR0ZXIgd2F5IHRvIHByaW50IHRoZSBlcnJvciBt
ZXNzYWdlcyBvdGhlciB0aGFuIGRlcGVuZGluZyBvbiBsaWJicGZfaW50ZXJuYWwuDQo+Pj4NCj4+
PiBUaGFua3MsDQo+Pj4gSGVjaGFvDQo+Pj4NCj4+PiBPbiA2LzQvMTksIDQ6NDAgUE0sICJTb25n
IExpdSIgPHNvbmdsaXVicmF2aW5nQGZiLmNvbT4gd3JvdGU6DQo+Pj4NCj4+Pg0KPj4+PiBPbiBK
dW4gNCwgMjAxOSwgYXQgMzozOCBQTSwgSGVjaGFvIExpIDxoZWNoYW9sQGZiLmNvbT4gd3JvdGU6
DQo+Pj4+DQo+Pj4+IEdldHRpbmcgbnVtYmVyIG9mIHBvc3NpYmxlIENQVXMgaXMgY29tbW9ubHkg
dXNlZCBmb3IgcGVyLUNQVSBCUEYgbWFwcw0KPj4+PiBhbmQgcGVyZl9ldmVudF9tYXBzLiBQdXR0
aW5nIGl0IGludG8gYSBjb21tb24gcGxhY2UgY2FuIGF2b2lkIGR1cGxpY2F0ZQ0KPj4+PiBpbXBs
ZW1lbnRhdGlvbnMuDQo+Pj4+DQo+Pj4+IEhlY2hhbyBMaSAoMik6DQo+Pj4+IEFkZCBicGZfbnVt
X3Bvc3NpYmxlX2NwdXMgdG8gbGliYnBmX3V0aWwNCj4+Pj4gVXNlIGJwZl9udW1fcG9zc2libGVf
Y3B1cyBpbiBicGZ0b29sIGFuZCBzZWxmdGVzdHMNCj4+Pj4NCj4+Pj4gdG9vbHMvYnBmL2JwZnRv
b2wvY29tbW9uLmMgICAgICAgICAgICAgICAgICAgIHwgNTMgKystLS0tLS0tLS0tLS0tLQ0KPj4+
PiB0b29scy9saWIvYnBmL0J1aWxkICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiArLQ0K
Pj4+PiB0b29scy9saWIvYnBmL2xpYmJwZl91dGlsLmMgICAgICAgICAgICAgICAgICAgfCA2MSAr
KysrKysrKysrKysrKysrKysrDQo+Pj4+IHRvb2xzL2xpYi9icGYvbGliYnBmX3V0aWwuaCAgICAg
ICAgICAgICAgICAgICB8ICA3ICsrKw0KPj4+PiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYv
YnBmX3V0aWwuaCAgICAgICAgfCA0MiArKystLS0tLS0tLS0tDQo+Pj4+IC4uLi9zZWxmdGVzdHMv
YnBmL3Byb2dfdGVzdHMvbDRsYl9hbGwuYyAgICAgICB8ICAyICstDQo+Pj4+IC4uLi9zZWxmdGVz
dHMvYnBmL3Byb2dfdGVzdHMveGRwX25vaW5saW5lLmMgICB8ICAyICstDQo+Pj4+IHRvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2JwZi90ZXN0X2J0Zi5jICAgICAgICB8ICAyICstDQo+Pj4+IHRvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi90ZXN0X2xydV9tYXAuYyAgICB8ICAyICstDQo+Pj4+IHRv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi90ZXN0X21hcHMuYyAgICAgICB8ICA2ICstDQo+Pj4+
IDEwIGZpbGVzIGNoYW5nZWQsIDg4IGluc2VydGlvbnMoKyksIDkxIGRlbGV0aW9ucygtKQ0KPj4+
PiBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvbGliL2JwZi9saWJicGZfdXRpbC5jDQo+Pj4+DQo+
Pj4+IC0tDQo+Pj4+IDIuMTcuMQ0KPj4+Pg0KPj4+DQo+Pj4gICAgVGhlIGNoYW5nZSBpcyBtb3N0
bHkgc3RyYWlnaHRmb3J3YXJkLiBIb3dldmVyLCBJIGFtIG5vdCBzdXJlIHdoZXRoZXINCj4+PiAg
ICB0aGV5IHNob3VsZCBiZSBhZGRlZCB0byBsaWJicGZfdXRpbC5oLiBNYXliZSBsaWJicGYuaCBp
cyBhIGJldHRlcg0KPj4+ICAgIHBsYWNlPw0KPj4+DQo+Pj4gICAgRGFuaWVsIGFuZCBBbGV4ZWks
IHdoYXQncyB5b3VyIHJlY29tbWVuZGF0aW9uIGhlcmU/DQo+Pg0KPj4gICAgSG0sIGxvb2tzIGxp
a2UgdGhlIHBhdGNoIGRpZCBub3QgbWFrZSBpdCB0byB0aGUgbGlzdCAoeWV0PykuIEFncmVlIGl0
IG1ha2VzDQo+PiAgICBzZW5zZSB0byBtb3ZlIGl0IGludG8gbGliYnBmIGdpdmVuIGNvbW1vbiB1
c2UgZm9yIHBlci1DUFUvcGVyZi1ldmVudCBtYXBzLg0KPj4gICAgR2l2ZW4gZnJvbSB0aGUgZGlm
ZiBzdGF0IGl0J3Mgbm90IGFkZGVkIHRvIGxpYmJwZi5tYXAsIGlzIHRoZXJlIGEgcmVhc29uIHRv
DQo+PiAgICBub3QgYWRkIGl0IHRvLCBzYXksIHRvb2xzL2xpYi9icGYvbGliYnBmLmMgYW5kIGV4
cG9zZSBpdCBhcyBvZmZpY2lhbCBBUEk/DQo+Pg0KPj4gICAgVGhhbmtzLA0KPj4gICAgRGFuaWVs
DQo+Pg0KPj4NCj4NCg0KVGhhbmtzIGEgbG90IGZvciB0aGUgZGV0YWlsZWQgZXhwbGFuYXRpb24s
IERhbmllbC4gQW5kIHNvcnJ5IGZvciB0aGUgcmVwbHkgZm9ybWF0LiBTdXJlLCBJIHdpbGwgYWRk
IGl0IGFzIGEgbGliYnBmXw0KQVBJIGluc3RlYWQuIE1vdmluZyAgdGhlIG1hY3JvIEJQRl9ERUNM
QVJFX1BFUkNQVSBpbiBzZWxmdGVzdCB1dGlsIHRvIGxpYmJwZiBhbHNvIG1ha2VzIHNlbnNlIHRv
IG1lLg0KSG93ZXZlciwgc2luY2UgYnBmX251bV9wb3NzaWJsZV9jcHVzIGluIHNlbGZ0ZXN0IGV4
aXRzIHRoZSBwcm9jZXNzIGluIGNhc2Ugb2YgZmFpbHVyZXMsIHdoaWNoIGlzIG5vdCBnb29kIGZv
cg0KYSB1c2VyIGZhY2luZyBBUEksIGhvdyBhYm91dCBtYWtpbmcgI0NQVSBhIHBhcmFtIGFuZCBk
ZWZpbmUgaXQgYXMNCg0KI2RlZmluZSBCUEZfREVDTEFSRV9QRVJDUFUodHlwZSwgbmFtZSwgbmNw
dSkgXA0KICAgICAgICAgICAgIHN0cnVjdCB7IHR5cGUgdjsgfSBfX2JwZl9wZXJjcHVfdmFsX2Fs
aWduIG5hbWVbbmNwdV0NCg0KQW5kIHRoZSB1c2VyIHNob3VsZCBkbw0KaW50IG5jcHUgPSBsaWJi
cGZfbnVtX3Bvc3NpYmxlX2NwdXMoKTsNCi8vIGVycm9yIGhhbmRsaW5nIGlmIG5jcHUgPD0wDQpC
UEZfREVDTEFSRV9QRVJDUFUobG9uZywgdmFsdWUsIG5jcHUpDQoNClRoZSBwcm9ibGVtIG9mIHRo
aXMgbWV0aG9kIGlzLCB0aGUgdXNlciBtYXkgc3RpbGwgcGFzcyBzeXNjb25mKF9TQ19OUFJPQ0VT
U09SU19DT05GKSBhcyBuY3B1Lg0KSSB0aGluayB0aGlzIGNhbiBiZSBhdm9pZGVkIGJ5IHB1dHRp
bmcgc29tZSBjb21tZW50cyBhcm91bmQgdGhpcyBtYWNyby4gRG9lcyBpdCBtYWtlIHNlbnNlPw0K
DQpUaGFua3MsDQpIZWNoYW8NCg0K
