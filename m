Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4F4B5B40
	for <lists+bpf@lfdr.de>; Wed, 18 Sep 2019 07:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfIRFvo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Sep 2019 01:51:44 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:12462 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728666AbfIRFvn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 18 Sep 2019 01:51:43 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8I5ospO022482;
        Tue, 17 Sep 2019 22:51:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=/SVmvbA+puaI8GFck6wzqX67KaEmVDFSqIjD+0veVz4=;
 b=Loqf+c6gJk/SPTzZTQQC2TOc011MGS4t+C+8dhQc80byT18s3zGeu95+DB9ZGrS4ktkJ
 HTZt6oMu7N9DwvTR2YQ8Fv6/TBW6h+EWj4XRWB8QF1s74Lw9UBMKUuEGtd2juLMeTARe
 6XujfwhR8tuQDoAO+9gAEj5kbjB+zDH8Sls= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2v37mwhfnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 17 Sep 2019 22:51:12 -0700
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 17 Sep 2019 22:51:11 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 17 Sep 2019 22:51:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6hTBZtE1ehkfuHVJOt3BQ50DPtJf93KhZ8/wrRqOvq5gSMH4UCs9p3T+0dIJY1kiwncfZ0M5kFLdAR17lvawtLFLWlt8v9UlnPxWpmdCq5VZ/34uCL0SwdDTOgdJexDkP7OO5vqzLTeOr0qUYv1Fy2p2nQVPQjBq4rzDcFAl9ivlQCMnC//iAXsv9BolswyP8SDfXFtrM9zEC3HD2qqDnoogyk9sKf9EHHsa4/68N1H/J6Jr+3VieOc+M+tgjuIVI3Ut0vwGO7Gh7qJ9VmQjlf04Z8R5w7hvPUpS/5q+vof6CRRJ4d5lVs2DBmCMHYbMw04bB3+ZGGn7OGpUFEg7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SVmvbA+puaI8GFck6wzqX67KaEmVDFSqIjD+0veVz4=;
 b=g+tf0zRc9XPRO1bM78CCbQnQErtP7fzA045er8+vzZf8YRnobDw/WxCaCwFFttHqOky/J6NhCZv/mK14ETWP+LPQEeeCdlyC8j1aJbe2u4eUUN13G8Bb2NDxQE9Tv3h2s3gIWcC0ws06GOtGgJXVedNM6E1zwR2HG4RdWppJth0KXJKysStasetn/JEkKbZICsCWyoyGU3W07tX+X822PJkWBDMlYK25Y/LvqgFYAszQ9+Q9PgXNvhVXGEWpbnx5DEmeuU1Y9t8f1Na4bYkrlPvE2QUuApdouKXSQY/xu5F5zHfrRqhrRtMZfL2bj3CRCvT66a3MgOXSe+mPHnplkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SVmvbA+puaI8GFck6wzqX67KaEmVDFSqIjD+0veVz4=;
 b=U0RocHQkKyePf740av0XeI2Pbk+gX+tSFDZrQlZqbWgZmuxPDPtguWQcN1fWcUI+alfemFRLWP31/cgnl1y+3Py1CCNjMyjJRXAY4Lmo4aZMIE7gnP2ioPvrlxd8BqrKG6oedvoYZLlyDsfVJmizavAZ3SfsjRbh2BWEZ+TuwQY=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.60.27) by
 BYAPR15MB2822.namprd15.prod.outlook.com (20.179.158.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 18 Sep 2019 05:51:10 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::95ab:61a0:29f4:e07e]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::95ab:61a0:29f4:e07e%6]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 05:51:10 +0000
From:   Yonghong Song <yhs@fb.com>
To:     "jinshan.xiong@gmail.com" <jinshan.xiong@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>
CC:     "jinshan.xiong@uber.com" <jinshan.xiong@uber.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH] staging: tracing/kprobe: filter kprobe based perf event
Thread-Topic: [PATCH] staging: tracing/kprobe: filter kprobe based perf event
Thread-Index: AQHVbeFchO1YMfVy6kGxOLPX9FlbUqcw7isA
Date:   Wed, 18 Sep 2019 05:51:10 +0000
Message-ID: <5302836c-a6a1-c160-2de2-6a5b3d2c4828@fb.com>
References: <20190918052406.21385-1-jinshan.xiong@gmail.com>
In-Reply-To: <20190918052406.21385-1-jinshan.xiong@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR06CA0058.namprd06.prod.outlook.com
 (2603:10b6:104:3::16) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:112::27)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::cce8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c15c28d-a123-4faf-c51b-08d73bfc34aa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB2822;
x-ms-traffictypediagnostic: BYAPR15MB2822:
x-microsoft-antispam-prvs: <BYAPR15MB2822D3DF473E06C1BF1251B5D38E0@BYAPR15MB2822.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(376002)(39860400002)(396003)(346002)(199004)(189003)(54906003)(486006)(478600001)(4326008)(102836004)(186003)(71190400001)(71200400001)(31696002)(2201001)(76176011)(99286004)(53546011)(25786009)(52116002)(386003)(11346002)(110136005)(86362001)(316002)(5660300002)(46003)(14454004)(6506007)(256004)(476003)(446003)(2616005)(2906002)(81156014)(8676002)(81166006)(305945005)(6116002)(8936002)(7736002)(66446008)(6486002)(6436002)(36756003)(229853002)(6512007)(66556008)(66946007)(66476007)(64756008)(31686004)(2501003)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2822;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LG3VXi4sQHshdFgPE49xb5qjC+c0hch70pFdMMiSTSVP4OPg01HRz/qUiVd1ZuKp5Dgq97kh2GiweDr5T1t8/Ous7bQzYP9h2uPgDDORpGCPev6ROp6iQP3O11EBTxjU2o3bF+Ke/zbNv1Rct0J/TdapnO6tnzZzAxA8+ZmuZCb16gJ/+qAEaKhdJGPo2J1aS+U6CZrZI+UbSLkevDQ65Fzi8BMFptazNF8UxUXwT+7cj++JBhxKPZtLl6dWadc+5uKBl5y8bj+TvGN69NEDrI8Vdh9o2fGV5opAzuG+DB6PUBV+3TVWguYM8RDo+Y5HG/4pTf8o1YnmTNOL0FwXnRT81UfcF2+3VNmt6HdpihhAfBEHFy7KNq7v4qqcrnXCAPCapEiT9XWfhy1PX+pC8KJhcQ2/y8cBvIMGIgH7O7g=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3134A8AF3E4DDF4BBE869632F13D78AB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c15c28d-a123-4faf-c51b-08d73bfc34aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 05:51:10.2086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wl3heL+mA0RR0l+686FRpEdiM5JFz6T+csPPn4tlNHnY4ok/+54rJ3ERtsQf2xj+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2822
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-18_04:2019-09-17,2019-09-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011
 malwarescore=0 mlxlogscore=775 mlxscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909180062
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQpBZGRpbmcgY2MgdG8gYnBmQHZnZXIua2VybmVsLm9yZyBtYWlsaW5nIGxpc3Qgc2luY2UgdGhp
cyBpcyByZWFsbHkNCmJwZiByZWxhdGVkLg0KDQpPbiA5LzE3LzE5IDEwOjI0IFBNLCBqaW5zaGFu
Lnhpb25nQGdtYWlsLmNvbSB3cm90ZToNCj4gRnJvbTogSmluc2hhbiBYaW9uZyA8amluc2hhbi54
aW9uZ0BnbWFpbC5jb20+DQo+IA0KPiBJbnZva2luZyBicGYgcHJvZ3JhbSBvbmx5IGlmIGtwcm9i
ZSBiYXNlZCBwZXJmX2V2ZW50IGhhcyBiZWVuIGFkZGVkIGludG8NCj4gdGhlIHBlcmNwdSBsaXN0
LiBUaGlzIGlzIGVzc2VudGlhbCB0byBtYWtlIGV2ZW50IHRyYWNpbmcgZm9yIGNncm91cCB0byB3
b3JrDQo+IHByb3Blcmx5Lg0KDQpUaGUgaXNzdWUgYWN0dWFsbHkgZXhpc3RzIGZvciBicGYgcHJv
Z3JhbXMgd2l0aCBrcHJvYmUsIHVwcm9iZSwgDQp0cmFjZXBvaW50IGFuZCB0cmFjZV9zeXNjYWxs
X2VudGVyL2V4aXQuDQoNCkluIGFsbCB0aGVzZSBwbGFjZXMsIGJwZiBwcm9ncmFtIGlzIGNhbGxl
ZCByZWdhcmRsZXNzIG9mDQp3aGV0aGVyIHRoZXJlIGFyZSBwZXJmIGV2ZW50cyBvciBub3Qgb24g
dGhpcyBjcHUuDQpUaGlzIHByb3ZpZGVzIGJwZiBwcm9ncmFtcyBtb3JlIG9wcG9ydHVuaXRpZXMg
dG8gc2VlDQp0aGUgZXZlbnRzLiBJIGd1ZXNzIHRoaXMgaXMgYnkgZGVzaWduLg0KQWxleGVpL0Rh
bmllbCwgY291bGQgeW91IGNsYXJpZnk/DQoNClRoaXMsIHVuZm9ydHVuYXRlbHksIGhhcyBhIGNv
bnNlcXVlbmNlIG9uIGNncm91cC4NCkN1cnJlbnRseSwgcGVyZiBldmVudCBjZ3JvdXAgYmFzZWQg
b24gZmlsdGVyaW5nDQooUEVSRl9GTEFHX1BJRF9DR1JPVVApIHdvbid0IHdvcmsgZm9yIGJwZiBw
cm9ncmFtcw0Kd2l0aCBrcHJvYmVlL3Vwcm9iZS90cmFjZXBvaW50L3RyYWNlX3N5c2NhbGwuDQpU
aGUgcmVhc29uIGlzIHRoZSBzYW1lLCBicGYgcHJvZ3JhbXMgc2VlDQptb3JlIGV2ZW50cyB0aGFu
IHdoYXQgcGVyZiBoYXMgY29uZmlndXJlZC4NCg0KdGhlIG92ZXJmbG93IGludGVycnVwdCAobm1p
KSBiYXNlZCBwZXJmX2V2ZW50IGJwZiBwcm9ncmFtcw0KYXJlIG5vdCBpbXBhY3RlZC4NCg0KQW55
IHN1Z2dlc3Rpb25zIG9uIHdoYXQgaXMgdGhlIHByb3BlciB3YXkgdG8gbW92ZQ0KZm9yd2FyZD8N
Cg0KT25lIHdheSB0byBzdGFydCB0byBob25vciBldmVudHMgb25seSBwZXJtaXR0ZWQgYnkgcGVy
Zg0KbGlrZSB3aGF0IHRoaXMgcGF0Y2ggZGlkLiBCdXQgSSBhbSBub3Qgc3VyZSB3aGV0aGVyIHRo
aXMNCmNvbnRyYWRpY3RzIHRoZSBvcmlnaW5hbCBtb3RpdmF0aW9uIGZvciBicGYgcHJvZ3JhbXMN
CnRvIHNlZSBhbGwgZXZlbnRzIHJlZ2FyZGxlc3MuDQoNCkFub3RoZXIgd2F5IGlzIHRvIGRvIGZp
bHRlcmluZyBpbnNpZGUgYnBmIHByb2dyYW0uDQpXZSBhbHJlYWR5IGhhdmUgYnBmX2dldF9jZ3Jv
dXBfaWQoKSBoZWxwZXIuDQpXZSBtYXkgbmVlZCBhbm90aGVyIGhlbHBlciB0byBjaGVjayB3aGV0
aGVyIHRoZSBjdXJyZW50DQppcyAoYSBkZXNjZW5kYW50IG9mKSBhbm90aGVyIGNncm91cCBhcyBp
dCBpcyBvZnRlbiB0aGUgY2FzZXMNCnRvIHRyYWNlIGFsbCBwcm9jZXNzZXMgdW5kZXIgb25lIHBh
cmVudCBjZ3JvdXAgd2hpY2ggbWF5IGhhdmUgbWFueQ0KY2hpbGQgY2dyb3Vwcy4NCg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogSmluc2hhbiBYaW9uZyA8amluc2hhbi54aW9uZ0BnbWFpbC5jb20+DQo+
IC0tLQ0KPiAgIGtlcm5lbC90cmFjZS90cmFjZV9rcHJvYmUuYyB8IDEzICsrKysrKysrLS0tLS0N
Cj4gICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2tlcm5lbC90cmFjZS90cmFjZV9rcHJvYmUuYyBiL2tlcm5lbC90cmFj
ZS90cmFjZV9rcHJvYmUuYw0KPiBpbmRleCA5ZDQ4M2FkOWJiNmMuLjQwZWYwZjE5NDVmNyAxMDA2
NDQNCj4gLS0tIGEva2VybmVsL3RyYWNlL3RyYWNlX2twcm9iZS5jDQo+ICsrKyBiL2tlcm5lbC90
cmFjZS90cmFjZV9rcHJvYmUuYw0KPiBAQCAtMTE3MSwxMSArMTE3MSwxOCBAQCBzdGF0aWMgaW50
DQo+ICAga3Byb2JlX3BlcmZfZnVuYyhzdHJ1Y3QgdHJhY2Vfa3Byb2JlICp0aywgc3RydWN0IHB0
X3JlZ3MgKnJlZ3MpDQo+ICAgew0KPiAgIAlzdHJ1Y3QgdHJhY2VfZXZlbnRfY2FsbCAqY2FsbCA9
IHRyYWNlX3Byb2JlX2V2ZW50X2NhbGwoJnRrLT50cCk7DQo+ICsJc3RydWN0IGhsaXN0X2hlYWQg
KmhlYWQgPSB0aGlzX2NwdV9wdHIoY2FsbC0+cGVyZl9ldmVudHMpOw0KPiAgIAlzdHJ1Y3Qga3By
b2JlX3RyYWNlX2VudHJ5X2hlYWQgKmVudHJ5Ow0KPiAtCXN0cnVjdCBobGlzdF9oZWFkICpoZWFk
Ow0KPiAgIAlpbnQgc2l6ZSwgX19zaXplLCBkc2l6ZTsNCj4gICAJaW50IHJjdHg7DQo+ICAgDQo+
ICsJLyoNCj4gKwkgKiBJZiBoZWFkIGlzIGVtcHR5LCB0aGUgcHJvY2VzcyBjdXJyZW50bHkgcnVu
bmluZyBvbiB0aGlzIGNwdSBpcyBub3QNCj4gKwkgKiBpbnRlcmVzdGVkIGJ5IGtwcm9iZSBwZXJm
IFBNVS4NCj4gKwkgKi8NCj4gKwlpZiAoaGxpc3RfZW1wdHkoaGVhZCkpDQo+ICsJCXJldHVybiAw
Ow0KPiArDQo+ICAgCWlmIChicGZfcHJvZ19hcnJheV92YWxpZChjYWxsKSkgew0KPiAgIAkJdW5z
aWduZWQgbG9uZyBvcmlnX2lwID0gaW5zdHJ1Y3Rpb25fcG9pbnRlcihyZWdzKTsNCj4gICAJCWlu
dCByZXQ7DQo+IEBAIC0xMTkzLDEwICsxMjAwLDYgQEAga3Byb2JlX3BlcmZfZnVuYyhzdHJ1Y3Qg
dHJhY2Vfa3Byb2JlICp0aywgc3RydWN0IHB0X3JlZ3MgKnJlZ3MpDQo+ICAgCQkJcmV0dXJuIDA7
DQo+ICAgCX0NCj4gICANCj4gLQloZWFkID0gdGhpc19jcHVfcHRyKGNhbGwtPnBlcmZfZXZlbnRz
KTsNCj4gLQlpZiAoaGxpc3RfZW1wdHkoaGVhZCkpDQo+IC0JCXJldHVybiAwOw0KPiAtDQo+ICAg
CWRzaXplID0gX19nZXRfZGF0YV9zaXplKCZ0ay0+dHAsIHJlZ3MpOw0KPiAgIAlfX3NpemUgPSBz
aXplb2YoKmVudHJ5KSArIHRrLT50cC5zaXplICsgZHNpemU7DQo+ICAgCXNpemUgPSBBTElHTihf
X3NpemUgKyBzaXplb2YodTMyKSwgc2l6ZW9mKHU2NCkpOw0KPiANCg==
