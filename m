Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7375C5A537
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2019 21:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfF1ThX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Jun 2019 15:37:23 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:24424 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726497AbfF1ThX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 28 Jun 2019 15:37:23 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5SJXV8J011608;
        Fri, 28 Jun 2019 12:36:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=3luc2HQorykzI2lHjQ9UJZ6vwXXPmiIM8freiFxzeM8=;
 b=kclVMJlwBeewBZuENEVoktxHBng/zLxkvVIi2S8K+LOBI3J5Tz8JiIJMfBeHB5GPdO5v
 T8ASZ7UrU9eqQumjxCHMtG1EaP3T4dHKlt9YhOqL+AZrf02iPjgV34M/rIrw9NF2BB2j
 1/KnVmuCaBa887n0bVMejOdUYe/DNCHWfOk= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2tdm8u17dh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 28 Jun 2019 12:36:54 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 28 Jun 2019 12:36:51 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 28 Jun 2019 12:36:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3luc2HQorykzI2lHjQ9UJZ6vwXXPmiIM8freiFxzeM8=;
 b=sy3T+dm16O9mj6cT+NKkIOA3qzIqY7Wv8nnUUvfE3q6Vl1XcTNsevnd32PK3iP9rWTEmKqCCH/+AtvrbzHHXMFPGVmUqM+SOcii1v+VtWVvPl6eRO1+V2GD70mosZThmeV8tQv6m7bLK1cY53jYEXU+pLr5rd3pwh6thZItDaa4=
Received: from BYAPR15MB2311.namprd15.prod.outlook.com (52.135.197.145) by
 BYAPR15MB3464.namprd15.prod.outlook.com (20.179.60.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.18; Fri, 28 Jun 2019 19:36:49 +0000
Received: from BYAPR15MB2311.namprd15.prod.outlook.com
 ([fe80::ede7:54b5:1ec3:de47]) by BYAPR15MB2311.namprd15.prod.outlook.com
 ([fe80::ede7:54b5:1ec3:de47%6]) with mapi id 15.20.2008.017; Fri, 28 Jun 2019
 19:36:49 +0000
From:   Lawrence Brakmo <brakmo@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>
CC:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next] bpf: fix precision tracking
Thread-Topic: [PATCH bpf-next] bpf: fix precision tracking
Thread-Index: AQHVLc3wDIUl3ilRL0KD2RCJDnBgYaaxdQqA//+LqAA=
Date:   Fri, 28 Jun 2019 19:36:49 +0000
Message-ID: <522C998F-A1C7-4948-BBF3-F474FBDEFFB2@fb.com>
References: <20190628162409.2513499-1-ast@kernel.org>
 <CAEf4BzY00WVr452Pj1JDMSG4nD47uexp+G+zHZxijZmSS1bUKw@mail.gmail.com>
In-Reply-To: <CAEf4BzY00WVr452Pj1JDMSG4nD47uexp+G+zHZxijZmSS1bUKw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1a.0.190609
x-originating-ip: [2620:10d:c090:200::2:13b8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba92a7ba-f73d-4344-2a1e-08d6fbfff6f6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR15MB3464;
x-ms-traffictypediagnostic: BYAPR15MB3464:
x-microsoft-antispam-prvs: <BYAPR15MB346440EDC15B59505BCFD88BA9FC0@BYAPR15MB3464.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(136003)(376002)(346002)(189003)(199004)(54906003)(58126008)(110136005)(316002)(5660300002)(6246003)(66946007)(76116006)(66446008)(66556008)(73956011)(91956017)(66476007)(81166006)(8676002)(8936002)(7736002)(305945005)(6116002)(81156014)(64756008)(4326008)(256004)(46003)(71200400001)(71190400001)(36756003)(2906002)(86362001)(446003)(11346002)(476003)(2616005)(486006)(25786009)(99286004)(33656002)(14454004)(478600001)(76176011)(229853002)(6486002)(53546011)(6506007)(6436002)(102836004)(53936002)(186003)(6512007)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3464;H:BYAPR15MB2311.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dNdbcWJxodg2aDBJ7X2/XyjQNi6CQLFFST191k0cUOf29HIwYBuuxEEGgyQShEMm/5shU9jkoJrqq8adswowvhWY1zKOMQ8IyUgyaanM3eVXXjVpumybm2nCki412ejuclC4Kg1pSBXPLyenpTzm1EnXwlaXI29Ha1LAzCw5smJfdF9mhSJuEnBeje0AnWF9XXkzKydW7+BbkdJjVwML0Wxb1W+OD8r+LmGp4c3AhOUAoMEgWxWaNJwTJ2ly/R4oVNwak/9DgyO9nsgW8t3VOZHFbx9PZZ5TZBqbOX8KD/ROcg9Nlr+xBskpg6AyQBOCAJuzUCAUSXkx/oC/3cpVj4p1c3aEK9xI7SA0nHLBahcTVSclDvVb8S5Xx0kZFKCHBn4t4lsfTw6Omq6+vprEQg3CbUx/o3cW4qIKi85EJYY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <152FFBCEACC87F4D910872E669905C52@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ba92a7ba-f73d-4344-2a1e-08d6fbfff6f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 19:36:49.6085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: brakmo@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3464
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-28_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906280222
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQrvu79PbiA2LzI4LzE5LCAxMjozMyBQTSwgIm5ldGRldi1vd25lckB2Z2VyLmtlcm5lbC5vcmcg
b24gYmVoYWxmIG9mIEFuZHJpaSBOYWtyeWlrbyIgPG5ldGRldi1vd25lckB2Z2VyLmtlcm5lbC5v
cmcgb24gYmVoYWxmIG9mIGFuZHJpaS5uYWtyeWlrb0BnbWFpbC5jb20+IHdyb3RlOg0KDQogICAg
T24gRnJpLCBKdW4gMjgsIDIwMTkgYXQgOToyNSBBTSBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFzdEBr
ZXJuZWwub3JnPiB3cm90ZToNCiAgICA+DQogICAgPiBXaGVuIGVxdWl2YWxlbnQgc3RhdGUgaXMg
Zm91bmQgdGhlIGN1cnJlbnQgc3RhdGUgbmVlZHMgdG8gcHJvcGFnYXRlIHByZWNpc2lvbiBtYXJr
cy4NCiAgICA+IE90aGVyd2lzZSB0aGUgdmVyaWZpZXIgd2lsbCBwcnVuZSB0aGUgc2VhcmNoIGlu
Y29ycmVjdGx5Lg0KICAgID4NCiAgICA+IFRoZXJlIGlzIGEgcHJpY2UgZm9yIGNvcnJlY3RuZXNz
Og0KICAgID4gICAgICAgICAgICAgICAgICAgICAgIGJlZm9yZSAgICAgIGJlZm9yZSAgICBicm9r
ZW4gICAgZml4ZWQNCiAgICA+ICAgICAgICAgICAgICAgICAgICAgICBjbnN0IHNwaWxsICBwcmVj
aXNlICAgcHJlY2lzZQ0KICAgID4gYnBmX2xiLURMQl9MMy5vICAgICAgIDE5MjMgICAgICAgIDgx
MjggICAgICAxODYzICAgICAgMTg5OA0KICAgID4gYnBmX2xiLURMQl9MNC5vICAgICAgIDMwNzcg
ICAgICAgIDY3MDcgICAgICAyNDY4ICAgICAgMjY2Ng0KICAgID4gYnBmX2xiLURVTktOT1dOLm8g
ICAgIDEwNjIgICAgICAgIDEwNjIgICAgICA1NDQgICAgICAgNTQ0DQogICAgPiBicGZfbHhjLURE
Uk9QX0FMTC5vICAgMTY2NzI5ICAgICAgMzgwNzEyICAgIDIyNjI5ICAgICAzNjgyMw0KICAgID4g
YnBmX2x4Yy1EVU5LTk9XTi5vICAgIDE3NDYwNyAgICAgIDQ0MDY1MiAgICAyODgwNSAgICAgNDUz
MjUNCiAgICA+IGJwZl9uZXRkZXYubyAgICAgICAgICA4NDA3ICAgICAgICAzMTkwNCAgICAgNjgw
MSAgICAgIDcwMDINCiAgICA+IGJwZl9vdmVybGF5Lm8gICAgICAgICA1NDIwICAgICAgICAyMzU2
OSAgICAgNDc1NCAgICAgIDQ4NTgNCiAgICA+IGJwZl9seGNfaml0Lm8gICAgICAgICAzOTM4OSAg
ICAgICAzNTk0NDUgICAgNTA5MjUgICAgIDY5NjMxDQogICAgPiBPdmVyYWxsIHByZWNpc2lvbiB0
cmFja2luZyBpcyBzdGlsbCB2ZXJ5IGVmZmVjdGl2ZS4NCiAgICA+DQogICAgPiBGaXhlczogYjVk
YzAxNjNkOGZkICgiYnBmOiBwcmVjaXNlIHNjYWxhcl92YWx1ZSB0cmFja2luZyIpDQogICAgPiBS
ZXBvcnRlZC1ieTogTGF3cmVuY2UgQnJha21vIDxicmFrbW9AZmIuY29tPg0KICAgID4gU2lnbmVk
LW9mZi1ieTogQWxleGVpIFN0YXJvdm9pdG92IDxhc3RAa2VybmVsLm9yZz4NCiAgICA+IC0tLQ0K
ICAgIA0KICAgIA0KICAgIEFja2VkLWJ5OiBBbmRyaWkgTmFrcnlpa28gPGFuZHJpaW5AZmIuY29t
Pg0KICAgIA0KVGVzdGVkLWJ5OiBMYXdyZW5jZSBCcmFrbW8gPGJyYWttb0BmYi5jb20+DQogICAg
DQogICAgPiBTZW5kaW5nIHRoZSBmaXggZWFybHkgdy9vIHRlc3RzLCBzaW5jZSBJJ20gdHJhdmVs
aW5nLg0KICAgID4gV2lsbCBhZGQgcHJvcGVyIHRlc3RzIHdoZW4gSSdtIGJhY2suDQogICAgPiAt
LS0NCiAgICA+ICBrZXJuZWwvYnBmL3ZlcmlmaWVyLmMgfCAxMjEgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tDQogICAgPiAgMSBmaWxlIGNoYW5nZWQsIDEwNyBpbnNl
cnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkNCiAgICA+DQogICAgPiBkaWZmIC0tZ2l0IGEva2Vy
bmVsL2JwZi92ZXJpZmllci5jIGIva2VybmVsL2JwZi92ZXJpZmllci5jDQogICAgPiBpbmRleCA2
YjU2MjNkMzIwZjkuLjYyYWZjNDA1OGNlZCAxMDA2NDQNCiAgICA+IC0tLSBhL2tlcm5lbC9icGYv
dmVyaWZpZXIuYw0KICAgID4gKysrIGIva2VybmVsL2JwZi92ZXJpZmllci5jDQogICAgPiBAQCAt
MTY1OSwxNiArMTY1OSwxOCBAQCBzdGF0aWMgdm9pZCBtYXJrX2FsbF9zY2FsYXJzX3ByZWNpc2Uo
c3RydWN0IGJwZl92ZXJpZmllcl9lbnYgKmVudiwNCiAgICA+ICAgICAgICAgICAgICAgICB9DQog
ICAgPiAgfQ0KICAgID4NCiAgICA+IC1zdGF0aWMgaW50IG1hcmtfY2hhaW5fcHJlY2lzaW9uKHN0
cnVjdCBicGZfdmVyaWZpZXJfZW52ICplbnYsIGludCByZWdubykNCiAgICA+ICtzdGF0aWMgaW50
IF9fbWFya19jaGFpbl9wcmVjaXNpb24oc3RydWN0IGJwZl92ZXJpZmllcl9lbnYgKmVudiwgaW50
IHJlZ25vLA0KICAgID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCBzcGkp
DQogICAgPiAgew0KICAgID4gICAgICAgICBzdHJ1Y3QgYnBmX3ZlcmlmaWVyX3N0YXRlICpzdCA9
IGVudi0+Y3VyX3N0YXRlOw0KICAgID4gICAgICAgICBpbnQgZmlyc3RfaWR4ID0gc3QtPmZpcnN0
X2luc25faWR4Ow0KICAgID4gICAgICAgICBpbnQgbGFzdF9pZHggPSBlbnYtPmluc25faWR4Ow0K
ICAgID4gICAgICAgICBzdHJ1Y3QgYnBmX2Z1bmNfc3RhdGUgKmZ1bmM7DQogICAgPiAgICAgICAg
IHN0cnVjdCBicGZfcmVnX3N0YXRlICpyZWc7DQogICAgPiAtICAgICAgIHUzMiByZWdfbWFzayA9
IDF1IDw8IHJlZ25vOw0KICAgID4gLSAgICAgICB1NjQgc3RhY2tfbWFzayA9IDA7DQogICAgPiAr
ICAgICAgIHUzMiByZWdfbWFzayA9IHJlZ25vID49IDAgPyAxdSA8PCByZWdubyA6IDA7DQogICAg
PiArICAgICAgIHU2NCBzdGFja19tYXNrID0gc3BpID49IDAgPyAxdWxsIDw8IHNwaSA6IDA7DQog
ICAgPiAgICAgICAgIGJvb2wgc2tpcF9maXJzdCA9IHRydWU7DQogICAgPiArICAgICAgIGJvb2wg
bmV3X21hcmtzID0gZmFsc2U7DQogICAgPiAgICAgICAgIGludCBpLCBlcnI7DQogICAgPg0KICAg
ID4gICAgICAgICBpZiAoIWVudi0+YWxsb3dfcHRyX2xlYWtzKQ0KICAgID4gQEAgLTE2NzYsMTgg
KzE2NzgsNDMgQEAgc3RhdGljIGludCBtYXJrX2NoYWluX3ByZWNpc2lvbihzdHJ1Y3QgYnBmX3Zl
cmlmaWVyX2VudiAqZW52LCBpbnQgcmVnbm8pDQogICAgPiAgICAgICAgICAgICAgICAgcmV0dXJu
IDA7DQogICAgPg0KICAgID4gICAgICAgICBmdW5jID0gc3QtPmZyYW1lW3N0LT5jdXJmcmFtZV07
DQogICAgPiAtICAgICAgIHJlZyA9ICZmdW5jLT5yZWdzW3JlZ25vXTsNCiAgICA+IC0gICAgICAg
aWYgKHJlZy0+dHlwZSAhPSBTQ0FMQVJfVkFMVUUpIHsNCiAgICA+IC0gICAgICAgICAgICAgICBX
QVJOX09OQ0UoMSwgImJhY2t0cmFjaW5nIG1pc3VzZSIpOw0KICAgID4gLSAgICAgICAgICAgICAg
IHJldHVybiAtRUZBVUxUOw0KICAgID4gKyAgICAgICBpZiAocmVnbm8gPj0gMCkgew0KICAgID4g
KyAgICAgICAgICAgICAgIHJlZyA9ICZmdW5jLT5yZWdzW3JlZ25vXTsNCiAgICA+ICsgICAgICAg
ICAgICAgICBpZiAocmVnLT50eXBlICE9IFNDQUxBUl9WQUxVRSkgew0KICAgID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgV0FSTl9PTkNFKDEsICJiYWNrdHJhY2luZyBtaXN1c2UiKTsNCiAgICA+
ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUZBVUxUOw0KICAgID4gKyAgICAgICAg
ICAgICAgIH0NCiAgICA+ICsgICAgICAgICAgICAgICBpZiAoIXJlZy0+cHJlY2lzZSkNCiAgICA+
ICsgICAgICAgICAgICAgICAgICAgICAgIG5ld19tYXJrcyA9IHRydWU7DQogICAgPiArICAgICAg
ICAgICAgICAgZWxzZQ0KICAgID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmVnX21hc2sgPSAw
Ow0KICAgID4gKyAgICAgICAgICAgICAgIHJlZy0+cHJlY2lzZSA9IHRydWU7DQogICAgPiAgICAg
ICAgIH0NCiAgICA+IC0gICAgICAgaWYgKHJlZy0+cHJlY2lzZSkNCiAgICA+IC0gICAgICAgICAg
ICAgICByZXR1cm4gMDsNCiAgICA+IC0gICAgICAgZnVuYy0+cmVnc1tyZWdub10ucHJlY2lzZSA9
IHRydWU7DQogICAgPg0KICAgID4gKyAgICAgICB3aGlsZSAoc3BpID49IDApIHsNCiAgICA+ICsg
ICAgICAgICAgICAgICBpZiAoZnVuYy0+c3RhY2tbc3BpXS5zbG90X3R5cGVbMF0gIT0gU1RBQ0tf
U1BJTEwpIHsNCiAgICA+ICsgICAgICAgICAgICAgICAgICAgICAgIHN0YWNrX21hc2sgPSAwOw0K
ICAgID4gKyAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQogICAgPiArICAgICAgICAgICAg
ICAgfQ0KICAgID4gKyAgICAgICAgICAgICAgIHJlZyA9ICZmdW5jLT5zdGFja1tzcGldLnNwaWxs
ZWRfcHRyOw0KICAgID4gKyAgICAgICAgICAgICAgIGlmIChyZWctPnR5cGUgIT0gU0NBTEFSX1ZB
TFVFKSB7DQogICAgPiArICAgICAgICAgICAgICAgICAgICAgICBzdGFja19tYXNrID0gMDsNCiAg
ICA+ICsgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KICAgID4gKyAgICAgICAgICAgICAg
IH0NCiAgICA+ICsgICAgICAgICAgICAgICBpZiAoIXJlZy0+cHJlY2lzZSkNCiAgICA+ICsgICAg
ICAgICAgICAgICAgICAgICAgIG5ld19tYXJrcyA9IHRydWU7DQogICAgPiArICAgICAgICAgICAg
ICAgZWxzZQ0KICAgID4gKyAgICAgICAgICAgICAgICAgICAgICAgc3RhY2tfbWFzayA9IDA7DQog
ICAgPiArICAgICAgICAgICAgICAgcmVnLT5wcmVjaXNlID0gdHJ1ZTsNCiAgICA+ICsgICAgICAg
ICAgICAgICBicmVhazsNCiAgICA+ICsgICAgICAgfQ0KICAgID4gKw0KICAgID4gKyAgICAgICBp
ZiAoIW5ld19tYXJrcykNCiAgICA+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsNCiAgICA+ICsg
ICAgICAgaWYgKCFyZWdfbWFzayAmJiAhc3RhY2tfbWFzaykNCiAgICA+ICsgICAgICAgICAgICAg
ICByZXR1cm4gMDsNCiAgICA+ICAgICAgICAgZm9yICg7Oykgew0KICAgID4gICAgICAgICAgICAg
ICAgIERFQ0xBUkVfQklUTUFQKG1hc2ssIDY0KTsNCiAgICA+IC0gICAgICAgICAgICAgICBib29s
IG5ld19tYXJrcyA9IGZhbHNlOw0KICAgID4gICAgICAgICAgICAgICAgIHUzMiBoaXN0b3J5ID0g
c3QtPmptcF9oaXN0b3J5X2NudDsNCiAgICA+DQogICAgPiAgICAgICAgICAgICAgICAgaWYgKGVu
di0+bG9nLmxldmVsICYgQlBGX0xPR19MRVZFTCkNCiAgICA+IEBAIC0xNzMwLDEyICsxNzU3LDE1
IEBAIHN0YXRpYyBpbnQgbWFya19jaGFpbl9wcmVjaXNpb24oc3RydWN0IGJwZl92ZXJpZmllcl9l
bnYgKmVudiwgaW50IHJlZ25vKQ0KICAgID4gICAgICAgICAgICAgICAgIGlmICghc3QpDQogICAg
PiAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCiAgICA+DQogICAgPiArICAgICAgICAg
ICAgICAgbmV3X21hcmtzID0gZmFsc2U7DQogICAgPiAgICAgICAgICAgICAgICAgZnVuYyA9IHN0
LT5mcmFtZVtzdC0+Y3VyZnJhbWVdOw0KICAgID4gICAgICAgICAgICAgICAgIGJpdG1hcF9mcm9t
X3U2NChtYXNrLCByZWdfbWFzayk7DQogICAgPiAgICAgICAgICAgICAgICAgZm9yX2VhY2hfc2V0
X2JpdChpLCBtYXNrLCAzMikgew0KICAgID4gICAgICAgICAgICAgICAgICAgICAgICAgcmVnID0g
JmZ1bmMtPnJlZ3NbaV07DQogICAgPiAtICAgICAgICAgICAgICAgICAgICAgICBpZiAocmVnLT50
eXBlICE9IFNDQUxBUl9WQUxVRSkNCiAgICA+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmIChy
ZWctPnR5cGUgIT0gU0NBTEFSX1ZBTFVFKSB7DQogICAgPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHJlZ19tYXNrICY9IH4oMXUgPDwgaSk7DQogICAgPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KICAgID4gKyAgICAgICAgICAgICAgICAgICAgICAg
fQ0KICAgID4gICAgICAgICAgICAgICAgICAgICAgICAgaWYgKCFyZWctPnByZWNpc2UpDQogICAg
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG5ld19tYXJrcyA9IHRydWU7DQogICAg
PiAgICAgICAgICAgICAgICAgICAgICAgICByZWctPnByZWNpc2UgPSB0cnVlOw0KICAgID4gQEAg
LTE3NTYsMTEgKzE3ODYsMTUgQEAgc3RhdGljIGludCBtYXJrX2NoYWluX3ByZWNpc2lvbihzdHJ1
Y3QgYnBmX3ZlcmlmaWVyX2VudiAqZW52LCBpbnQgcmVnbm8pDQogICAgPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUZBVUxUOw0KICAgID4gICAgICAgICAgICAgICAg
ICAgICAgICAgfQ0KICAgID4NCiAgICA+IC0gICAgICAgICAgICAgICAgICAgICAgIGlmIChmdW5j
LT5zdGFja1tpXS5zbG90X3R5cGVbMF0gIT0gU1RBQ0tfU1BJTEwpDQogICAgPiArICAgICAgICAg
ICAgICAgICAgICAgICBpZiAoZnVuYy0+c3RhY2tbaV0uc2xvdF90eXBlWzBdICE9IFNUQUNLX1NQ
SUxMKSB7DQogICAgPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0YWNrX21hc2sg
Jj0gfigxdWxsIDw8IGkpOw0KICAgID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBj
b250aW51ZTsNCiAgICA+ICsgICAgICAgICAgICAgICAgICAgICAgIH0NCiAgICA+ICAgICAgICAg
ICAgICAgICAgICAgICAgIHJlZyA9ICZmdW5jLT5zdGFja1tpXS5zcGlsbGVkX3B0cjsNCiAgICA+
IC0gICAgICAgICAgICAgICAgICAgICAgIGlmIChyZWctPnR5cGUgIT0gU0NBTEFSX1ZBTFVFKQ0K
ICAgID4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKHJlZy0+dHlwZSAhPSBTQ0FMQVJfVkFM
VUUpIHsNCiAgICA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RhY2tfbWFzayAm
PSB+KDF1bGwgPDwgaSk7DQogICAgPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNv
bnRpbnVlOw0KICAgID4gKyAgICAgICAgICAgICAgICAgICAgICAgfQ0KICAgID4gICAgICAgICAg
ICAgICAgICAgICAgICAgaWYgKCFyZWctPnByZWNpc2UpDQogICAgPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIG5ld19tYXJrcyA9IHRydWU7DQogICAgPiAgICAgICAgICAgICAgICAg
ICAgICAgICByZWctPnByZWNpc2UgPSB0cnVlOw0KICAgID4gQEAgLTE3NzIsNiArMTgwNiw4IEBA
IHN0YXRpYyBpbnQgbWFya19jaGFpbl9wcmVjaXNpb24oc3RydWN0IGJwZl92ZXJpZmllcl9lbnYg
KmVudiwgaW50IHJlZ25vKQ0KICAgID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBy
ZWdfbWFzaywgc3RhY2tfbWFzayk7DQogICAgPiAgICAgICAgICAgICAgICAgfQ0KICAgID4NCiAg
ICA+ICsgICAgICAgICAgICAgICBpZiAoIXJlZ19tYXNrICYmICFzdGFja19tYXNrKQ0KICAgID4g
KyAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQogICAgPiAgICAgICAgICAgICAgICAgaWYg
KCFuZXdfbWFya3MpDQogICAgPiAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCiAgICA+
DQogICAgPiBAQCAtMTc4MSw2ICsxODE3LDE1IEBAIHN0YXRpYyBpbnQgbWFya19jaGFpbl9wcmVj
aXNpb24oc3RydWN0IGJwZl92ZXJpZmllcl9lbnYgKmVudiwgaW50IHJlZ25vKQ0KICAgID4gICAg
ICAgICByZXR1cm4gMDsNCiAgICA+ICB9DQogICAgPg0KICAgID4gK3N0YXRpYyBpbnQgbWFya19j
aGFpbl9wcmVjaXNpb24oc3RydWN0IGJwZl92ZXJpZmllcl9lbnYgKmVudiwgaW50IHJlZ25vKQ0K
ICAgID4gK3sNCiAgICA+ICsgICAgICAgcmV0dXJuIF9fbWFya19jaGFpbl9wcmVjaXNpb24oZW52
LCByZWdubywgLTEpOw0KICAgID4gK30NCiAgICA+ICsNCiAgICA+ICtzdGF0aWMgaW50IG1hcmtf
Y2hhaW5fcHJlY2lzaW9uX3N0YWNrKHN0cnVjdCBicGZfdmVyaWZpZXJfZW52ICplbnYsIGludCBz
cGkpDQogICAgPiArew0KICAgID4gKyAgICAgICByZXR1cm4gX19tYXJrX2NoYWluX3ByZWNpc2lv
bihlbnYsIC0xLCBzcGkpOw0KICAgID4gK30NCiAgICA+DQogICAgPiAgc3RhdGljIGJvb2wgaXNf
c3BpbGxhYmxlX3JlZ3R5cGUoZW51bSBicGZfcmVnX3R5cGUgdHlwZSkNCiAgICA+ICB7DQogICAg
PiBAQCAtNzExNCw2ICs3MTU5LDQ2IEBAIHN0YXRpYyBpbnQgcHJvcGFnYXRlX2xpdmVuZXNzKHN0
cnVjdCBicGZfdmVyaWZpZXJfZW52ICplbnYsDQogICAgPiAgICAgICAgIHJldHVybiAwOw0KICAg
ID4gIH0NCiAgICA+DQogICAgPiArLyogZmluZCBwcmVjaXNlIHNjYWxhcnMgaW4gdGhlIHByZXZp
b3VzIGVxdWl2YWxlbnQgc3RhdGUgYW5kDQogICAgPiArICogcHJvcGFnYXRlIHRoZW0gaW50byB0
aGUgY3VycmVudCBzdGF0ZQ0KICAgID4gKyAqLw0KICAgID4gK3N0YXRpYyBpbnQgcHJvcGFnYXRl
X3ByZWNpc2lvbihzdHJ1Y3QgYnBmX3ZlcmlmaWVyX2VudiAqZW52LA0KICAgID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHN0cnVjdCBicGZfdmVyaWZpZXJfc3RhdGUgKm9s
ZCkNCiAgICA+ICt7DQogICAgPiArICAgICAgIHN0cnVjdCBicGZfcmVnX3N0YXRlICpzdGF0ZV9y
ZWc7DQogICAgPiArICAgICAgIHN0cnVjdCBicGZfZnVuY19zdGF0ZSAqc3RhdGU7DQogICAgPiAr
ICAgICAgIGludCBpLCBlcnIgPSAwOw0KICAgID4gKw0KICAgID4gKyAgICAgICBzdGF0ZSA9IG9s
ZC0+ZnJhbWVbb2xkLT5jdXJmcmFtZV07DQogICAgPiArICAgICAgIHN0YXRlX3JlZyA9IHN0YXRl
LT5yZWdzOw0KICAgID4gKyAgICAgICBmb3IgKGkgPSAwOyBpIDwgQlBGX1JFR19GUDsgaSsrLCBz
dGF0ZV9yZWcrKykgew0KICAgID4gKyAgICAgICAgICAgICAgIGlmIChzdGF0ZV9yZWctPnR5cGUg
IT0gU0NBTEFSX1ZBTFVFIHx8DQogICAgPiArICAgICAgICAgICAgICAgICAgICFzdGF0ZV9yZWct
PnByZWNpc2UpDQogICAgPiArICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCiAgICA+
ICsgICAgICAgICAgICAgICBpZiAoZW52LT5sb2cubGV2ZWwgJiBCUEZfTE9HX0xFVkVMMikNCiAg
ICA+ICsgICAgICAgICAgICAgICAgICAgICAgIHZlcmJvc2UoZW52LCAicHJvcGFnYXRpbmcgciVk
XG4iLCBpKTsNCiAgICA+ICsgICAgICAgICAgICAgICBlcnIgPSBtYXJrX2NoYWluX3ByZWNpc2lv
bihlbnYsIGkpOw0KICAgID4gKyAgICAgICAgICAgICAgIGlmIChlcnIgPCAwKQ0KICAgID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGVycjsNCiAgICA+ICsgICAgICAgfQ0KICAgID4g
Kw0KICAgID4gKyAgICAgICBmb3IgKGkgPSAwOyBpIDwgc3RhdGUtPmFsbG9jYXRlZF9zdGFjayAv
IEJQRl9SRUdfU0laRTsgaSsrKSB7DQogICAgPiArICAgICAgICAgICAgICAgaWYgKHN0YXRlLT5z
dGFja1tpXS5zbG90X3R5cGVbMF0gIT0gU1RBQ0tfU1BJTEwpDQogICAgPiArICAgICAgICAgICAg
ICAgICAgICAgICBjb250aW51ZTsNCiAgICA+ICsgICAgICAgICAgICAgICBzdGF0ZV9yZWcgPSAm
c3RhdGUtPnN0YWNrW2ldLnNwaWxsZWRfcHRyOw0KICAgID4gKyAgICAgICAgICAgICAgIGlmIChz
dGF0ZV9yZWctPnR5cGUgIT0gU0NBTEFSX1ZBTFVFIHx8DQogICAgPiArICAgICAgICAgICAgICAg
ICAgICFzdGF0ZV9yZWctPnByZWNpc2UpDQogICAgPiArICAgICAgICAgICAgICAgICAgICAgICBj
b250aW51ZTsNCiAgICA+ICsgICAgICAgICAgICAgICBpZiAoZW52LT5sb2cubGV2ZWwgJiBCUEZf
TE9HX0xFVkVMMikNCiAgICA+ICsgICAgICAgICAgICAgICAgICAgICAgIHZlcmJvc2UoZW52LCAi
cHJvcGFnYXRpbmcgZnAlZFxuIiwNCiAgICA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgKC1pIC0gMSkgKiBCUEZfUkVHX1NJWkUpOw0KICAgID4gKyAgICAgICAgICAgICAgIGVyciA9
IG1hcmtfY2hhaW5fcHJlY2lzaW9uX3N0YWNrKGVudiwgaSk7DQogICAgPiArICAgICAgICAgICAg
ICAgaWYgKGVyciA8IDApDQogICAgPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZXJy
Ow0KICAgID4gKyAgICAgICB9DQogICAgPiArICAgICAgIHJldHVybiAwOw0KICAgID4gK30NCiAg
ICA+ICsNCiAgICA+ICBzdGF0aWMgYm9vbCBzdGF0ZXNfbWF5YmVfbG9vcGluZyhzdHJ1Y3QgYnBm
X3ZlcmlmaWVyX3N0YXRlICpvbGQsDQogICAgPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBzdHJ1Y3QgYnBmX3ZlcmlmaWVyX3N0YXRlICpjdXIpDQogICAgPiAgew0KICAgID4gQEAg
LTcyMDYsNiArNzI5MSwxNCBAQCBzdGF0aWMgaW50IGlzX3N0YXRlX3Zpc2l0ZWQoc3RydWN0IGJw
Zl92ZXJpZmllcl9lbnYgKmVudiwgaW50IGluc25faWR4KQ0KICAgID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICogdGhpcyBzdGF0ZSBhbmQgd2lsbCBwb3AgYSBuZXcgb25lLg0KICAgID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICovDQogICAgPiAgICAgICAgICAgICAgICAgICAgICAgICBl
cnIgPSBwcm9wYWdhdGVfbGl2ZW5lc3MoZW52LCAmc2wtPnN0YXRlLCBjdXIpOw0KICAgID4gKw0K
ICAgID4gKyAgICAgICAgICAgICAgICAgICAgICAgLyogaWYgcHJldmlvdXMgc3RhdGUgcmVhY2hl
ZCB0aGUgZXhpdCB3aXRoIHByZWNpc2lvbiBhbmQNCiAgICA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAqIGN1cnJlbnQgc3RhdGUgaXMgZXF1aXZhbGVudCB0byBpdCAoZXhjZXB0IHByZWNzaW9u
IG1hcmtzKQ0KICAgID4gKyAgICAgICAgICAgICAgICAgICAgICAgICogdGhlIHByZWNpc2lvbiBu
ZWVkcyB0byBiZSBwcm9wYWdhdGVkIGJhY2sgaW4NCiAgICA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAqIHRoZSBjdXJyZW50IHN0YXRlLg0KICAgID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICovDQogICAgPiArICAgICAgICAgICAgICAgICAgICAgICBlcnIgPSBlcnIgPyA6IHB1c2hfam1w
X2hpc3RvcnkoZW52LCBjdXIpOw0KICAgID4gKyAgICAgICAgICAgICAgICAgICAgICAgZXJyID0g
ZXJyID8gOiBwcm9wYWdhdGVfcHJlY2lzaW9uKGVudiwgJnNsLT5zdGF0ZSk7DQogICAgPiAgICAg
ICAgICAgICAgICAgICAgICAgICBpZiAoZXJyKQ0KICAgID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICByZXR1cm4gZXJyOw0KICAgID4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0
dXJuIDE7DQogICAgPiAtLQ0KICAgID4gMi4yMC4wDQogICAgPg0KICAgIA0KDQo=
