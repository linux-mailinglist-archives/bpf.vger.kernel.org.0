Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9A4E8BBF
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2019 16:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389878AbfJ2PYs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Oct 2019 11:24:48 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37366 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389695AbfJ2PYr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Oct 2019 11:24:47 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9TFNHe3029493;
        Tue, 29 Oct 2019 08:24:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=wtN8PdjdefXXGDZzvQmbd/ceqlzGHiiD10ergLqROIs=;
 b=P4Cct0G7EZ9M0/CwDcc8xixQ8jGeIf9mBU0ehJ4VbJMCNvjXOwMiSnlDmp+RXDgOcpVG
 WDkyNb4Q0QQDTmaTfF4X82CErQH11bhB2J3oboqbFqrWUKN5tuWiXe4fN3FuStX76dX3
 ZwXgOZ8X22O6Nl+Bp3TjPsLuqfkMryg3CYk= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vw5usumkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 29 Oct 2019 08:24:27 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 29 Oct 2019 08:24:26 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 29 Oct 2019 08:24:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsT/UrlMLWL3sZQiG5+jL8GtgovEQZ2B9uxPVNZK/TJ9UtVsw5NcTKgNaWn1hq2luhvZdrmCzhb1rGDHEZstYGCDHbPoOL8KFzleAOWNZvS7pXcqolX3pUtOIpAjOLzqZgJB7tOa+KLjpkLTd2YibrnpWUkcwinHulFoAHs8TViPdDiw7LmytPlEvIncC9bdAcJClQ/5HQRU+OqQgGetrljLJifNASEUi+cTsKexbTgvTQLLC27/wL1RvMWd5gPagwiP2XP3D5QJAR8EZHlhu/Q68MxsYTBgKGhMlC0XTNIAksGlSVPiPiG4SZkKB05tBdJk8BdyU9xsaLD1max5VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtN8PdjdefXXGDZzvQmbd/ceqlzGHiiD10ergLqROIs=;
 b=HtJZqGlRsc5FgSKO0EtfzN1m4rC7Bz+5YPB20yYed27aq6+rMN0VaCG8qtss8YK6oFi0kKMP6phQV9nd8Czw5gqBS9piDSLcOX4+kdQJldJM2aStAwgM0y5/PHwXhQ3VUKg4OWQzEX9qAO+Qm4pO+hIQQbm5iR0HzF1oJt+SVb+o6cYdcNq0/nhXd6U0w3wIvc64p66xakmS6+YP3VLV33vuHAYwabyDpsKULLmpldCYIQvgk6stCfDV75vnRWSCU2pD88QNrMTsvRjKBD+ruAsDWR3wMUfUDmnMMkK6/Hdv43qJhshXVBFxipQjHAXOrYPAPi/vjiOSc9hZQy7tXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtN8PdjdefXXGDZzvQmbd/ceqlzGHiiD10ergLqROIs=;
 b=dSSVerrfDogJsIpDTNOW77ocAwckfHeWmzO+ipqE0039bTCvbDWQro8e+JMKjBs0B/sJOXVC9bOXztIy1yCVjkxg/LSp+jnDokHgparexKPTOW5SBtaCmwngEEYSdY5REG8mAbvgHAqZHraF4MyUIGbgNQ6qttUlOf0kouuJlxo=
Received: from MWHPR15MB1375.namprd15.prod.outlook.com (10.173.233.21) by
 MWHPR15MB1869.namprd15.prod.outlook.com (10.174.100.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Tue, 29 Oct 2019 15:24:24 +0000
Received: from MWHPR15MB1375.namprd15.prod.outlook.com
 ([fe80::e917:269c:162c:2142]) by MWHPR15MB1375.namprd15.prod.outlook.com
 ([fe80::e917:269c:162c:2142%12]) with mapi id 15.20.2387.025; Tue, 29 Oct
 2019 15:24:24 +0000
From:   Andrey Ignatov <rdna@fb.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: test narrow load from
 bpf_sysctl.write
Thread-Topic: [PATCH bpf-next] selftests/bpf: test narrow load from
 bpf_sysctl.write
Thread-Index: AQHVjmWKEYg+r57vMkSTUFaYrhGjTqdxvRUA
Date:   Tue, 29 Oct 2019 15:24:23 +0000
Message-ID: <20191029152422.GB84963@rdna-mbp>
References: <20191029143027.28681-1-iii@linux.ibm.com>
In-Reply-To: <20191029143027.28681-1-iii@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2001CA0022.namprd20.prod.outlook.com
 (2603:10b6:301:15::32) To MWHPR15MB1375.namprd15.prod.outlook.com
 (2603:10b6:300:ba::21)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::b373]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24a8b262-01c6-411e-f1e1-08d75c8413d9
x-ms-traffictypediagnostic: MWHPR15MB1869:
x-microsoft-antispam-prvs: <MWHPR15MB18699CD508CE011BF30350DCA8610@MWHPR15MB1869.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(346002)(396003)(39860400002)(376002)(366004)(199004)(189003)(186003)(256004)(33716001)(14444005)(71190400001)(5024004)(99286004)(102836004)(46003)(71200400001)(4326008)(2906002)(11346002)(6246003)(6506007)(54906003)(386003)(6116002)(446003)(478600001)(316002)(6916009)(476003)(25786009)(33656002)(6436002)(86362001)(52116002)(66556008)(66476007)(64756008)(66446008)(486006)(76176011)(7736002)(6512007)(229853002)(6486002)(81156014)(14454004)(5660300002)(66946007)(9686003)(8936002)(305945005)(1076003)(8676002)(81166006)(4001150100001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1869;H:MWHPR15MB1375.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FH5Bguj6L0tHhf6fJNzUVqc00v6RgqB9v5FAtTeT3mbggAxZW+CJ/QNsFmb1s9J+dOBhrwKr4YnTPmdFiVLZVHkXjrzIqbqBxHpVwlghwuyOq5HmU+4koDGF3yj66/vg9eQjQuzIt28RYANbSt8pvPfe7rfw/RG4/Ncvln9XG5HIjJuLX+osqGlK8RftVqiEMkVjM9g3Mt2WnshJLjWZCS3xTwlnbSu6v0OeDq0hIQ6BX/cHiwPhg5d/d8fOpoQSIgFfkg3Nsh9kLq76lzLOgbj6myqyoVTb+yU7jfDvXcS0fPnnfjW1lhqaqqYDUr8bUliD7VoL7IbT8VufX/zcoTkp0YNrON9G2CjRWn9xivE5NvJ0JP8lyzrFrs/qn4qi2oaewW36Jb5Px1e/TXEDf4YXn14bRF4IrtMjRrQtiCpT5zQ2MHFdAY0ZmOnOaEoA
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4AD9B1A9DD5AA54E90852B952B1D16E5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a8b262-01c6-411e-f1e1-08d75c8413d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 15:24:23.8011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S4P24x0RdYkWPnn8IdT2SmSUSWkJW3dGwc8uAIEgMTNiCHIIODF4B2XfOIzXEk5I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1869
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-29_05:2019-10-28,2019-10-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 phishscore=0 adultscore=0 spamscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910290143
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SWx5YSBMZW9zaGtldmljaCA8aWlpQGxpbnV4LmlibS5jb20+IFtUdWUsIDIwMTktMTAtMjkgMDc6
MzEgLTA3MDBdOg0KPiBUaGVyZSBhcmUgdGVzdHMgZm9yIGZ1bGwgYW5kIG5hcnJvd3MgbG9hZHMg
ZnJvbSBicGZfc3lzY3RsLmZpbGVfcG9zLCBidXQNCj4gZm9yIGJwZl9zeXNjdGwud3JpdGUgb25s
eSBmdWxsIGxvYWQgaXMgdGVzdGVkLiBBZGQgdGhlIG1pc3NpbmcgdGVzdC4NCj4gDQo+IFN1Z2dl
c3RlZC1ieTogQW5kcmV5IElnbmF0b3YgPHJkbmFAZmIuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBJ
bHlhIExlb3Noa2V2aWNoIDxpaWlAbGludXguaWJtLmNvbT4NCg0KVGhhbmsgeW91IQ0KDQpBY2tl
ZC1ieTogQW5kcmV5IElnbmF0b3YgPHJkbmFAZmIuY29tPg0KDQo+IC0tLQ0KPiAgdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvYnBmL3Rlc3Rfc3lzY3RsLmMgfCAyMyArKysrKysrKysrKysrKysrKysr
KysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1n
aXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvdGVzdF9zeXNjdGwuYyBiL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2JwZi90ZXN0X3N5c2N0bC5jDQo+IGluZGV4IGEzMjBlMzg0NGIxNy4u
N2FmZjkwNzAwM2QzIDEwMDY0NA0KPiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYv
dGVzdF9zeXNjdGwuYw0KPiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvdGVzdF9z
eXNjdGwuYw0KPiBAQCAtMTIwLDYgKzEyMCwyOSBAQCBzdGF0aWMgc3RydWN0IHN5c2N0bF90ZXN0
IHRlc3RzW10gPSB7DQo+ICAJCS5uZXd2YWwgPSAiKG5vbmUpIiwgLyogc2FtZSBhcyBkZWZhdWx0
LCBzaG91bGQgZmFpbCBhbnl3YXkgKi8NCj4gIAkJLnJlc3VsdCA9IE9QX0VQRVJNLA0KPiAgCX0s
DQo+ICsJew0KPiArCQkuZGVzY3IgPSAiY3R4OndyaXRlIHN5c2N0bDp3cml0ZSByZWFkIG9rIG5h
cnJvdyIsDQo+ICsJCS5pbnNucyA9IHsNCj4gKwkJCS8qIHU2NCB3ID0gKHUxNil3cml0ZSAmIDE7
ICovDQo+ICsjaWYgX19CWVRFX09SREVSID09IF9fTElUVExFX0VORElBTg0KPiArCQkJQlBGX0xE
WF9NRU0oQlBGX0gsIEJQRl9SRUdfNywgQlBGX1JFR18xLA0KPiArCQkJCSAgICBvZmZzZXRvZihz
dHJ1Y3QgYnBmX3N5c2N0bCwgd3JpdGUpKSwNCj4gKyNlbHNlDQo+ICsJCQlCUEZfTERYX01FTShC
UEZfSCwgQlBGX1JFR183LCBCUEZfUkVHXzEsDQo+ICsJCQkJICAgIG9mZnNldG9mKHN0cnVjdCBi
cGZfc3lzY3RsLCB3cml0ZSkgKyAyKSwNCj4gKyNlbmRpZg0KPiArCQkJQlBGX0FMVTY0X0lNTShC
UEZfQU5ELCBCUEZfUkVHXzcsIDEpLA0KPiArCQkJLyogcmV0dXJuIDEgLSB3OyAqLw0KPiArCQkJ
QlBGX01PVjY0X0lNTShCUEZfUkVHXzAsIDEpLA0KPiArCQkJQlBGX0FMVTY0X1JFRyhCUEZfU1VC
LCBCUEZfUkVHXzAsIEJQRl9SRUdfNyksDQo+ICsJCQlCUEZfRVhJVF9JTlNOKCksDQo+ICsJCX0s
DQo+ICsJCS5hdHRhY2hfdHlwZSA9IEJQRl9DR1JPVVBfU1lTQ1RMLA0KPiArCQkuc3lzY3RsID0g
Imtlcm5lbC9kb21haW5uYW1lIiwNCj4gKwkJLm9wZW5fZmxhZ3MgPSBPX1dST05MWSwNCj4gKwkJ
Lm5ld3ZhbCA9ICIobm9uZSkiLCAvKiBzYW1lIGFzIGRlZmF1bHQsIHNob3VsZCBmYWlsIGFueXdh
eSAqLw0KPiArCQkucmVzdWx0ID0gT1BfRVBFUk0sDQo+ICsJfSwNCj4gIAl7DQo+ICAJCS5kZXNj
ciA9ICJjdHg6d3JpdGUgc3lzY3RsOnJlYWQgd3JpdGUgcmVqZWN0IiwNCj4gIAkJLmluc25zID0g
ew0KPiAtLSANCj4gMi4yMy4wDQo+IA0KDQotLSANCkFuZHJleSBJZ25hdG92DQo=
