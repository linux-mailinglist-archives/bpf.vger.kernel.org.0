Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4E68125BF9
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2019 08:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfLSHV2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Dec 2019 02:21:28 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21338 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726155AbfLSHV1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 19 Dec 2019 02:21:27 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJ7ENSi030319;
        Wed, 18 Dec 2019 23:21:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=qGTDnivdBDKgTq2KLzJjDOk8gjcyAHtU0om/OaBD76M=;
 b=W7zWocyw6IIxW5prXk6OyPNyzX+mbglaZSqHDy5JgNtd7Dwkqu/QB1yaa3Rquh2V5KG9
 3LAke9FYb4agFTmzjATwP4tGJaP9Ji9ZhaQXMGav/+cX3ETrWwKCUawiViHTt6D6UFby
 lnGCOIwkrBQcH/J2E+eDZYPhsOBUd7npgYM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wysvhtrtw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 18 Dec 2019 23:21:13 -0800
Received: from ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Dec 2019 23:21:12 -0800
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Dec 2019 23:21:12 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 18 Dec 2019 23:21:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxazOAghe3XHV2V3Qsqyni0aaCffz+qUKXGtKxZm5a2/lwyU3PBRqQU+gZ3dJA8dQbhivQQOFZYTPkPyYTKMnR4OS23lOzYIEMdBv6b8wDcIQGiKLZg70mik/KZxu7+xsu68JPsqg8DXM+Z9BTSTClufi3/hm2xCmJoyI3cDcWgaRqx1Qi65+yv6GqQotX0ork8PqZy6JKIZSyl+zlY8Trp2NKn+9U7jf0Kjwl8ZnIeqzzZ+xg57ko0KLMVZL3EcySjIUzvp4Sc9L+f0bAJAvZVrTHD0jws5WGKmmKn83TGYG9rU/pKHaEVKgWtdzD3ohmVKfo3uHh0c39PcJ5kmog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGTDnivdBDKgTq2KLzJjDOk8gjcyAHtU0om/OaBD76M=;
 b=BBsZPQElxVjfWfVNP5oei1zXuGsXB5Z7JyQLk8wGCWbhlyqDNsxoQoSxhAhlMopoSelye5YGhkB6/rZQt7IRcXsD/7NILetXiRGm5kh0MN7wtPM8QGi3TYSy7CwrNp7knEbjwtEwcwQ/KbkXculG87IkVeGPkKa+Ax99E2LZhxmjJAyQNR+I3XKab5l6g0KPfqfGeDNFbBBzpsrdPiq5STGl0ZsAasMq81HFCpIKZxRKTiMza6pmgzw8wrVi7wcl5sk+u6wB6Z5rVJn84nBfLAOujp9jBujTO0CPPaFWEP6zohbLaAdME8o8sNHq6t+cfOS1Fp2KiaJPqRSvbeAzOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGTDnivdBDKgTq2KLzJjDOk8gjcyAHtU0om/OaBD76M=;
 b=WIJ8zpty40SKZFCf8T7e2SX/iZ4CyRt439V/kughQ94sdo+fhzEupqYubXOmrNShnVuO7cef+5GR6NMG5xfITmao8S767i4+HSNNl2vfsauR+W5Z/Vx9204daT2KdtLKNDnDg76N/qi74jidYk4eQJtpRE2lDeHBRStD8d0pBXY=
Received: from MWHPR15MB1294.namprd15.prod.outlook.com (10.175.3.150) by
 MWHPR15MB1135.namprd15.prod.outlook.com (10.175.2.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Thu, 19 Dec 2019 07:20:57 +0000
Received: from MWHPR15MB1294.namprd15.prod.outlook.com
 ([fe80::5160:b3c0:bed1:e26c]) by MWHPR15MB1294.namprd15.prod.outlook.com
 ([fe80::5160:b3c0:bed1:e26c%10]) with mapi id 15.20.2559.012; Thu, 19 Dec
 2019 07:20:57 +0000
Received: from localhost (2620:10d:c090:180::99d4) by CO1PR15CA0096.namprd15.prod.outlook.com (2603:10b6:101:21::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend Transport; Thu, 19 Dec 2019 07:20:56 +0000
From:   Andrey Ignatov <rdna@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next 5/6] selftests/bpf: Convert test_cgroup_attach
 to prog_tests
Thread-Topic: [PATCH v3 bpf-next 5/6] selftests/bpf: Convert
 test_cgroup_attach to prog_tests
Thread-Index: AQHVtjMgQxtxd2MUekWCo4H0PqCl6afBDU2A
Date:   Thu, 19 Dec 2019 07:20:56 +0000
Message-ID: <20191219072055.GB16266@rdna-mbp.dhcp.thefacebook.com>
References: <cover.1576720240.git.rdna@fb.com>
 <a13336d12dff699d2b437ffa024adc1d95c97fcd.1576720240.git.rdna@fb.com>
 <CAEf4Bzb2_UqGJxxXvqqpdymzrE06dhj4-XWg5ndsgDndNw787w@mail.gmail.com>
In-Reply-To: <CAEf4Bzb2_UqGJxxXvqqpdymzrE06dhj4-XWg5ndsgDndNw787w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO1PR15CA0096.namprd15.prod.outlook.com
 (2603:10b6:101:21::16) To MWHPR15MB1294.namprd15.prod.outlook.com
 (2603:10b6:320:25::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::99d4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7f6900b-1aa6-4662-8f1f-08d78453fd9a
x-ms-traffictypediagnostic: MWHPR15MB1135:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB11353CC0B8F58D720997D930A8520@MWHPR15MB1135.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39850400004)(376002)(136003)(366004)(189003)(199004)(9686003)(2906002)(6486002)(33656002)(86362001)(4001150100001)(1076003)(54906003)(71200400001)(186003)(16526019)(53546011)(66476007)(66556008)(66446008)(316002)(66946007)(64756008)(6916009)(8936002)(81166006)(81156014)(8676002)(6496006)(52116002)(5660300002)(478600001)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1135;H:MWHPR15MB1294.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2JvLX02OoCkpkzCaSy2sJchaniUO6cPzUlWdnNdEG/fKSlgHwiJH2Pu007E5Yqvq/CNr4HKYUIXjji3uMTEHgG+Ozvb/V8yAOFWbrcpUOCSyzTGW2f2epx3DN1cnt3+mvRCDqMbcWcs8/0IqL7vyYXX3l8tzDvs0J1wHW8xaEj6OZKEFkzQgfSY5q2WqjxmeQWusbsIqApU0NuUEpqstpigPf7dj35PCkVAFXJSp9306LFk/qan9PoMlA3k98+vFMbROaf+W39l6Z2zlNLfBR4m4WJSA0YtgDGag2bV63GS4NVjl5n0rHvEykxQrcJIZq/EugyqR+yhBI2pz6peTGrpdlvu1vl8hvlOyvzp1CeuKk4M+ZuaEtOPRQ/amLu1Q4GxPgwv+VsSKwa9wJ2WHuNsMvGODcHXiFIJUmx4WGsgxOqE0jfZivl2nQoDDDara
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E866DC0B12F1D4A80C98C363B47D989@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f6900b-1aa6-4662-8f1f-08d78453fd9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 07:20:57.0000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hk6nM9BQD2oVzJpIoZG3EPBP0n8Bnx+g1mHNCEioWNznClRVJD0pjGdrOYXAv/qj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1135
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_08:2019-12-17,2019-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912190061
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

QW5kcmlpIE5ha3J5aWtvIDxhbmRyaWkubmFrcnlpa29AZ21haWwuY29tPiBbV2VkLCAyMDE5LTEy
LTE4IDIyOjExIC0wODAwXToNCj4gT24gV2VkLCBEZWMgMTgsIDIwMTkgYXQgNjoxNCBQTSBBbmRy
ZXkgSWduYXRvdiA8cmRuYUBmYi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gQ29udmVydCB0ZXN0X2Nn
cm91cF9hdHRhY2ggdG8gcHJvZ190ZXN0cy4NCj4gPg0KPiA+IFRoaXMgY2hhbmdlIGRvZXMgYSBs
b3Qgb2YgdGhpbmdzIGJ1dCBpbiBtYW55IGNhc2VzIGl0J3MgcHJldHR5IGV4cGVuc2l2ZQ0KPiA+
IHRvIHNlcGFyYXRlIHRoZW0sIHNvIHRoZXkgZ28gaW4gb25lIGNvbW1pdC4gTmV2ZXJ0aGVsZXNz
IHRoZSBsb2dpYyBpcw0KPiA+IGtldHAgYXMgaXMgYW5kIGNoYW5nZXMgbWFkZSBhcmUganVzdCBt
b3ZpbmcgdGhpbmdzIGFyb3VuZCwgc2ltcGxpZnlpbmcNCj4gPiB0aGVtICh3L28gY2hhbmdpbmcg
dGhlIG1lYW5pbmcgb2YgdGhlIHRlc3RzKSBhbmQgbWFraW5nIHByb2dfdGVzdHMNCj4gPiBjb21w
YXRpYmxlOg0KPiA+DQo+ID4gKiBzcGxpdCB0aGUgMyB0ZXN0cyBpbiB0aGUgZmlsZSBpbnRvIDMg
c2VwYXJhdGUgZmlsZXMgaW4gcHJvZ190ZXN0cy87DQo+ID4NCj4gPiAqIHJlbmFtZSB0aGUgdGVz
dCBmdW5jdGlvbnMgdG8gdGVzdF88ZmlsZV9iYXNlX25hbWU+Ow0KPiA+DQo+ID4gKiByZW1vdmUg
dW51c2VkIGluY2x1ZGVzLCBjb25zdGFudHMsIHZhcmlhYmxlcyBhbmQgZnVuY3Rpb25zIGZyb20g
ZXZlcnkNCj4gPiAgIHRlc3Q7DQo+ID4NCj4gPiAqIHJlcGxhY2UgYGlmYC1zIHdpdGggb3IgYGlm
IChDSEVDSygpKWAgd2hlcmUgYWRkaXRpb25hbCBjb250ZXh0IHNob3VsZA0KPiA+ICAgYmUgbG9n
Z2VkIGFuZCB3aXRoIGBpZiAoQ0hFQ0tfRkFJTCgpKWAgd2hlcmUgbGluZSBudW1iZXIgaXMgZW5v
dWdoOw0KPiA+DQo+ID4gKiBzd2l0Y2ggZnJvbSBgbG9nX2VycigpYCB0byBsb2dnaW5nIHZpYSBg
Q0hFQ0soKWA7DQo+ID4NCj4gPiAqIHJlcGxhY2UgYGFzc2VydGAtcyB3aXRoIGBDSEVDS19GQUlM
KClgIHRvIGF2b2lkIGNyYXNoaW5nIHRoZSB3aG9sZQ0KPiA+ICAgdGVzdF9wcm9ncyBpZiBvbmUg
YXNzZXJ0aW9uIGZhaWxzOw0KPiA+DQo+ID4gKiByZXBsYWNlIGNncm91cF9oZWxwZXJzIHdpdGgg
dGVzdF9fam9pbl9jZ3JvdXAoKSBpbg0KPiA+ICAgY2dyb3VwX2F0dGFjaF9vdmVycmlkZSBvbmx5
LCBvdGhlciB0ZXN0cyBuZWVkIG1vcmUgZmluZS1ncmFpbmVkDQo+ID4gICBjb250cm9sIGZvciBj
Z3JvdXAgY3JlYXRpb24vZGVsZXRpb24gc28gY2dyb3VwX2hlbHBlcnMgYXJlIHN0aWxsIHVzZWQN
Cj4gPiAgIHRoZXJlOw0KPiA+DQo+ID4gKiBzaW1wbGlmeSBjZ3JvdXBfYXR0YWNoX2F1dG9kZXRh
Y2ggYnkgc3dpdGNoaW5nIHRvIGVhc2llc3QgcG9zc2libGUNCj4gPiAgIHByb2dyYW0gc2luY2Ug
dGhpcyB0ZXN0IGRvZXNuJ3QgcmVhbGx5IG5lZWQgc3VjaCBhIGNvbXBsaWNhdGVkIHByb2dyYW0N
Cj4gPiAgIGFzIGNncm91cF9hdHRhY2hfbXVsdGkgZG9lczsNCj4gPg0KPiA+ICogcmVtb3ZlIHRl
c3RfY2dyb3VwX2F0dGFjaC5jIGl0c2VsZi4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuZHJl
eSBJZ25hdG92IDxyZG5hQGZiLmNvbT4NCj4gPiAtLS0NCj4gPiAgdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvYnBmLy5naXRpZ25vcmUgICAgICAgIHwgICAxIC0NCj4gPiAgdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvYnBmL01ha2VmaWxlICAgICAgICAgIHwgICAzICstDQo+ID4gIC4uLi9icGYvcHJv
Z190ZXN0cy9jZ3JvdXBfYXR0YWNoX2F1dG9kZXRhY2guYyB8IDExMSArKysrDQo+ID4gIC4uLi9i
cGYvcHJvZ190ZXN0cy9jZ3JvdXBfYXR0YWNoX211bHRpLmMgICAgICB8IDIzOCArKysrKysrKw0K
PiA+ICAuLi4vYnBmL3Byb2dfdGVzdHMvY2dyb3VwX2F0dGFjaF9vdmVycmlkZS5jICAgfCAxNDgg
KysrKysNCj4gPiAgLi4uL3NlbGZ0ZXN0cy9icGYvdGVzdF9jZ3JvdXBfYXR0YWNoLmMgICAgICAg
IHwgNTcxIC0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICA2IGZpbGVzIGNoYW5nZWQsIDQ5OCBpbnNl
cnRpb25zKCspLCA1NzQgZGVsZXRpb25zKC0pDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy9jZ3JvdXBfYXR0YWNoX2F1dG9kZXRh
Y2guYw0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBm
L3Byb2dfdGVzdHMvY2dyb3VwX2F0dGFjaF9tdWx0aS5jDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0
NCB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy9jZ3JvdXBfYXR0YWNoX292
ZXJyaWRlLmMNCj4gPiAgZGVsZXRlIG1vZGUgMTAwNjQ0IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2JwZi90ZXN0X2Nncm91cF9hdHRhY2guYw0KPiA+DQo+IA0KPiBbLi4uXQ0KPiANCj4gPiArDQo+
ID4gKyAgICAgICBpZiAoQ0hFQ0tfRkFJTChzZXR1cF9jZ3JvdXBfZW52aXJvbm1lbnQoKSkpDQo+
ID4gKyAgICAgICAgICAgICAgIGdvdG8gZXJyOw0KPiA+ICsNCj4gPiArICAgICAgIGNnMSA9IGNy
ZWF0ZV9hbmRfZ2V0X2Nncm91cCgiL2NnMSIpOw0KPiA+ICsgICAgICAgaWYgKENIRUNLX0ZBSUwo
Y2cxIDwgMCkpDQo+ID4gKyAgICAgICAgICAgICAgIGdvdG8gZXJyOw0KPiA+ICsgICAgICAgY2cy
ID0gY3JlYXRlX2FuZF9nZXRfY2dyb3VwKCIvY2cxL2NnMiIpOw0KPiA+ICsgICAgICAgaWYgKENI
RUNLX0ZBSUwoY2cyIDwgMCkpDQo+ID4gKyAgICAgICAgICAgICAgIGdvdG8gZXJyOw0KPiA+ICsg
ICAgICAgY2czID0gY3JlYXRlX2FuZF9nZXRfY2dyb3VwKCIvY2cxL2NnMi9jZzMiKTsNCj4gPiAr
ICAgICAgIGlmIChDSEVDS19GQUlMKGNnMyA8IDApKQ0KPiA+ICsgICAgICAgICAgICAgICBnb3Rv
IGVycjsNCj4gPiArICAgICAgIGNnNCA9IGNyZWF0ZV9hbmRfZ2V0X2Nncm91cCgiL2NnMS9jZzIv
Y2czL2NnNCIpOw0KPiA+ICsgICAgICAgaWYgKENIRUNLX0ZBSUwoY2c0IDwgMCkpDQo+ID4gKyAg
ICAgICAgICAgICAgIGdvdG8gZXJyOw0KPiA+ICsgICAgICAgY2c1ID0gY3JlYXRlX2FuZF9nZXRf
Y2dyb3VwKCIvY2cxL2NnMi9jZzMvY2c0L2NnNSIpOw0KPiA+ICsgICAgICAgaWYgKENIRUNLX0ZB
SUwoY2c1IDwgMCkpDQo+ID4gKyAgICAgICAgICAgICAgIGdvdG8gZXJyOw0KPiA+ICsNCj4gPiAr
ICAgICAgIGlmIChDSEVDS19GQUlMKGpvaW5fY2dyb3VwKCIvY2cxL2NnMi9jZzMvY2c0L2NnNSIp
KSkNCj4gPiArICAgICAgICAgICAgICAgZ290byBlcnI7DQo+ID4gKw0KPiA+ICsgICAgICAgaWYg
KENIRUNLKGJwZl9wcm9nX2F0dGFjaChhbGxvd19wcm9nWzBdLCBjZzEsIEJQRl9DR1JPVVBfSU5F
VF9FR1JFU1MsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJQRl9GX0FM
TE9XX01VTFRJKSwNCj4gPiArICAgICAgICAgICAgICAgICAicHJvZzBfYXR0YWNoX3RvX2NnMV9t
dWx0aSIsICJlcnJubz0lZFxuIiwgZXJybm8pKQ0KPiA+ICsgICAgICAgICAgICAgICBnb3RvIGVy
cjsNCj4gPiArDQo+ID4gKyAgICAgICBpZiAoQ0hFQ0soIWJwZl9wcm9nX2F0dGFjaChhbGxvd19w
cm9nWzBdLCBjZzEsIEJQRl9DR1JPVVBfSU5FVF9FR1JFU1MsDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBCUEZfRl9BTExPV19NVUxUSSksDQo+ID4gKyAgICAgICAgICAg
ICAgICAgImZhaWxfc2FtZV9wcm9nX2F0dGFjaF90b19jZzEiLCAidW5leHBlY3RlZCBzdWNjZXNz
XG4iKSkNCj4gPiArICAgICAgICAgICAgICAgZ290byBlcnI7DQo+ID4gKw0KPiA+ICsgICAgICAg
aWYgKENIRUNLKGJwZl9wcm9nX2F0dGFjaChhbGxvd19wcm9nWzFdLCBjZzEsIEJQRl9DR1JPVVBf
SU5FVF9FR1JFU1MsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJQRl9G
X0FMTE9XX01VTFRJKSwNCj4gPiArICAgICAgICAgICAgICAgICAicHJvZzFfYXR0YWNoX3RvX2Nn
MV9tdWx0aSIsICJlcnJubz0lZFxuIiwgZXJybm8pKQ0KPiA+ICsgICAgICAgICAgICAgICBnb3Rv
IGVycjsNCj4gPiArDQo+ID4gKyAgICAgICBpZiAoQ0hFQ0soYnBmX3Byb2dfYXR0YWNoKGFsbG93
X3Byb2dbMl0sIGNnMiwgQlBGX0NHUk9VUF9JTkVUX0VHUkVTUywNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgQlBGX0ZfQUxMT1dfT1ZFUlJJREUpLA0KPiA+ICsgICAgICAg
ICAgICAgICAgICJwcm9nMl9hdHRhY2hfdG9fY2cyX292ZXJyaWRlIiwgImVycm5vPSVkXG4iLCBl
cnJubykpDQo+ID4gKyAgICAgICAgICAgICAgIGdvdG8gZXJyOw0KPiA+ICsNCj4gPiArICAgICAg
IGlmIChDSEVDSyhicGZfcHJvZ19hdHRhY2goYWxsb3dfcHJvZ1szXSwgY2czLCBCUEZfQ0dST1VQ
X0lORVRfRUdSRVNTLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCUEZf
Rl9BTExPV19NVUxUSSksDQo+ID4gKyAgICAgICAgICAgICAgICAgInByb2czX2F0dGFjaF90b19j
ZzNfbXVsdGkiLCAiZXJybm89JWRcbiIsIGVycm5vKSkNCj4gPiArICAgICAgICAgICAgICAgZ290
byBlcnI7DQo+ID4gKw0KPiA+ICsgICAgICAgaWYgKENIRUNLKGJwZl9wcm9nX2F0dGFjaChhbGxv
d19wcm9nWzRdLCBjZzQsIEJQRl9DR1JPVVBfSU5FVF9FR1JFU1MsDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEJQRl9GX0FMTE9XX09WRVJSSURFKSwNCj4gPiArICAgICAgICAgICAg
ICAgICAicHJvZzRfYXR0YWNoX3RvX2NnNF9vdmVycmlkZSIsICJlcnJubz0lZFxuIiwgZXJybm8p
KQ0KPiA+ICsgICAgICAgICAgICAgICBnb3RvIGVycjsNCj4gPiArDQo+ID4gKyAgICAgICBpZiAo
Q0hFQ0soYnBmX3Byb2dfYXR0YWNoKGFsbG93X3Byb2dbNV0sIGNnNSwgQlBGX0NHUk9VUF9JTkVU
X0VHUkVTUywgMCksDQo+ID4gKyAgICAgICAgICAgICAgICAgInByb2c1X2F0dGFjaF90b19jZzVf
bm9uZSIsICJlcnJubz0lZFxuIiwgZXJybm8pKQ0KPiA+ICsgICAgICAgICAgICAgICBnb3RvIGVy
cjsNCj4gDQo+IG5pdDogdGhpcyBsb29rcyBsaWtlIGEgZ29vZCBjYW5kaWRhdGUgZm9yIGEgbG9v
cC4uLg0KDQpUaGVzZSB0ZXN0cyBjYW4gYmVuZWZpdCBmcm9tIGEgbG90IG9mIGNsZWFudXAgc3Rl
cHMgYW5kIHllYWgsIHRoaXMgY2FuDQpiZSBvbmUgb2YgdGhlbS4gSSdkIHByZWZlciB0byBkZWFs
IHdpdGggaXQgc2VwYXJhdGVseSB0aG91Z2ggc2luY2UgaXQNCnNob3VsZG4ndCBiZSBhIGJsb2Nr
ZXIgZm9yIHRoaXMgcGF0Y2ggc2V0LiBUaGF0J3Mgd2h5IEkgcHJlc2VydmVkIHRoaXMNCmxvZ2lj
IHdpdGgganVzdCBhZGRpbmcgY2hlY2tzLg0KDQoNCj4gPiArICAgICAgIENIRUNLX0ZBSUwoc3lz
dGVtKFBJTkdfQ01EKSk7DQo+ID4gKyAgICAgICBDSEVDS19GQUlMKGJwZl9tYXBfbG9va3VwX2Vs
ZW0obWFwX2ZkLCAma2V5LCAmdmFsdWUpKTsNCj4gPiArICAgICAgIENIRUNLX0ZBSUwodmFsdWUg
IT0gMSArIDIgKyA4ICsgMzIpOw0KPiA+ICsNCj4gDQo+IFsuLi5dDQo+IA0KPiA+IC1pbnQgbWFp
bih2b2lkKQ0KPiA+IC17DQo+ID4gLSAgICAgICBpbnQgKCp0ZXN0c1tdKSh2b2lkKSA9IHsNCj4g
PiAtICAgICAgICAgICAgICAgdGVzdF9mb29fYmFyLA0KPiA+IC0gICAgICAgICAgICAgICB0ZXN0
X211bHRpcHJvZywNCj4gPiAtICAgICAgICAgICAgICAgdGVzdF9hdXRvZGV0YWNoLA0KPiA+IC0g
ICAgICAgfTsNCj4gPiAtICAgICAgIGludCBlcnJvcnMgPSAwOw0KPiA+IC0gICAgICAgaW50IGk7
DQo+ID4gLQ0KPiA+IC0gICAgICAgZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUodGVzdHMpOyBp
KyspDQo+ID4gLSAgICAgICAgICAgICAgIGlmICh0ZXN0c1tpXSgpKQ0KPiA+IC0gICAgICAgICAg
ICAgICAgICAgICAgIGVycm9ycysrOw0KPiANCj4gRGVwZW5kaW5nIG9uIHdoYXQgeW91IHRoaW5r
IGlzIGJldHRlciBzdHJ1Y3R1cmUgKEkgY291bGRuJ3QgZm9sbG93DQo+IHRocm91Z2ggZW50aXJl
IHRlc3QgbG9naWMuLi4pLCB5b3UgY291bGQgaGF2ZSBkb25lIHRoaXMgYXMgYSBzaW5nbGUNCj4g
dGVzdCB3aXRoIDMgc3VidGVzdHMuIFNlYXJjaCBmb3IgdGVzdF9fc3RhcnRfc3VidGVzdCgpLiBJ
ZiB0aGF0IHNhdmVzDQo+IHlvdSBzb21lIGR1cGxpY2F0aW9uLCBJIHRoaW5rIGl0J3Mgd29ydGgg
Y29udmVydGluZyAod2hpY2ggd2lsbCBiZQ0KPiAxLXRvLTEgd2l0aCBvcmlnaW5hbCBzdHJ1Y3R1
cmUpLg0KDQpZZWFoLCBJIHNhdyB0ZXN0X19zdGFydF9zdWJ0ZXN0KCkgYW5kIGNoZWNrZWQgaWYg
aXQgd291bGQgZml0IGhlcmUuIElNTw0KaXQgd291bGRuJ3Qgc2luY2UgdGhlc2UgdGVzdHMgZG9u
J3QgaGF2ZSBtdWNoIGluIGNvbW1vbiBhbmQgY2FuJ3QgYmUNCmNvbnZlcnRlZCB0bywgc2F5LCBw
YXJhbWV0cml6ZWQgdGVzdHMgdGhhdCBkaWZmZXIgb25seSBpbiBpbnB1dCB0aGF0IGNhbg0KYmUg
ZWFzaWx5IGRlc2NyaWJlZCBieSBhIHN0cnVjdC4gVGhleSBkbyBjb3ZlciBwYXJ0cyBvZiBzYW1l
IGZlYXR1cmUNCihjZ3JvdXAgYXR0YWNoKSBidXQgZm9jdXMgb24gZGlmZmVyZW50IHBhcnRzIG9m
IGl0LiBUaGF0J3Mgd2h5IHNlcGFyYXRlDQpmaWxlcy4gVGhpcyBhY3R1YWxseSBoZWxwZWQgdG8g
aWRlbnRpZnkgYW5kIHJlbW92ZSBhIGJ1bmNoIG9mIGp1bmsgZnJvbQ0KZWFjaCB0ZXN0IChsaWtl
IHNpbXBsaWZ5aW5nIHRlc3RpbmcgcHJvZyBpbiBhdXRvZGV0YWNoKS4NCg0KDQo+IEJ1dCBlaXRo
ZXIgd2F5IHRoYW5rcyBhIGxvdCBmb3IgZG9pbmcgdGhlIGNvbnZlcnRpb24sIGJyaW5ncyBhcw0K
PiBhbm90aGVyIHN0ZXAgY2xvc2VyIHRvIG1vcmUgdW5pZm9ybSBhbmQgY29uc29saWRhdGVkIHRl
c3RpbmcgaW5mcmEuDQo+IA0KPiA+IC0NCj4gPiAtICAgICAgIGlmIChlcnJvcnMpDQo+ID4gLSAg
ICAgICAgICAgICAgIHByaW50ZigidGVzdF9jZ3JvdXBfYXR0YWNoOkZBSUxcbiIpOw0KPiA+IC0g
ICAgICAgZWxzZQ0KPiA+IC0gICAgICAgICAgICAgICBwcmludGYoInRlc3RfY2dyb3VwX2F0dGFj
aDpQQVNTXG4iKTsNCj4gPiAtDQo+ID4gLSAgICAgICByZXR1cm4gZXJyb3JzID8gRVhJVF9GQUlM
VVJFIDogRVhJVF9TVUNDRVNTOw0KPiA+IC19DQo+ID4gLS0NCj4gPiAyLjE3LjENCj4gPg0KDQot
LSANCkFuZHJleSBJZ25hdG92DQo=
