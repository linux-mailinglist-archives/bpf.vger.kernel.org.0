Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0723548B
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2019 01:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfFDXzJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Jun 2019 19:55:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57224 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726463AbfFDXzI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 4 Jun 2019 19:55:08 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x54NsqZV001518;
        Tue, 4 Jun 2019 16:54:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Ns9l3H5yjsYS3OhnyeKTsKGE3BV2MkjTtjbYboVd/xg=;
 b=SmXIHRjT5KOyztvVcXkofH6EXVwUqhlwu1RKO7/oWgCYD7GvhjtzZsmnvx53cZB0Z1uM
 cu7XY4Pd7vneCDFyEMcSzB02UXy5AhqHqhQm6eh/5KLs4VT3gBQJROyuFvCo+s+mY/Qi
 8i2EmLIO4mcSDbxd4uXql4X5kdRAE7DGdU8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2swwg2s58c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 04 Jun 2019 16:54:54 -0700
Received: from ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) by
 ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 4 Jun 2019 16:54:23 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 4 Jun 2019 16:54:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ns9l3H5yjsYS3OhnyeKTsKGE3BV2MkjTtjbYboVd/xg=;
 b=rmYWFgKHfiD4lJyTi+1J856lVrlZi7c4RVBeNpd+Qolkqhl6Yz7bZtk/j0lSy6L9btEYg/cUiO8aSEFRJuiyqAwUcOlmmZZ1Y1nkFDBm3z699K9IzlvfZTWNDL9hb66eDsUrTeqUhXZRJWGtrLK9ZWpRzZaXOI6phBSpWeSYK8Y=
Received: from BYAPR15MB2968.namprd15.prod.outlook.com (20.178.237.149) by
 BYAPR15MB2934.namprd15.prod.outlook.com (20.178.237.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.18; Tue, 4 Jun 2019 23:54:22 +0000
Received: from BYAPR15MB2968.namprd15.prod.outlook.com
 ([fe80::1ccd:3dd5:6b36:eeed]) by BYAPR15MB2968.namprd15.prod.outlook.com
 ([fe80::1ccd:3dd5:6b36:eeed%5]) with mapi id 15.20.1943.018; Tue, 4 Jun 2019
 23:54:22 +0000
From:   Hechao Li <hechaol@fb.com>
To:     Song Liu <songliubraving@fb.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 0/2] Move bpf_num_possible_cpus() to libbpf_util
Thread-Topic: [PATCH 0/2] Move bpf_num_possible_cpus() to libbpf_util
Thread-Index: AQHVGyZg4tIKyBkdcUi5YVJZMJaJE6aMJ5aA//+ObIA=
Date:   Tue, 4 Jun 2019 23:54:22 +0000
Message-ID: <C4921362-A75B-4333-91C7-437B4AA4C854@fb.com>
References: <20190604223815.2487730-1-hechaol@fb.com>
 <BDC04C37-0C03-4D98-B4F2-437C7A746F88@fb.com>
In-Reply-To: <BDC04C37-0C03-4D98-B4F2-437C7A746F88@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::3:26c3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52c0d30b-a9c9-43bb-4c20-08d6e947f79e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR15MB2934;
x-ms-traffictypediagnostic: BYAPR15MB2934:
x-microsoft-antispam-prvs: <BYAPR15MB29345F40C7BED7E2E922A2A0D5150@BYAPR15MB2934.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0058ABBBC7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(396003)(136003)(376002)(199004)(189003)(229853002)(6116002)(486006)(46003)(256004)(14444005)(2616005)(476003)(53546011)(5660300002)(6506007)(99286004)(86362001)(6512007)(186003)(2906002)(316002)(36756003)(76176011)(6486002)(6436002)(446003)(102836004)(25786009)(11346002)(4326008)(66476007)(73956011)(14454004)(37006003)(82746002)(68736007)(64756008)(54906003)(66446008)(76116006)(66556008)(478600001)(6636002)(6862004)(81166006)(8676002)(81156014)(6246003)(71200400001)(83716004)(7736002)(305945005)(33656002)(71190400001)(8936002)(53936002)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2934;H:BYAPR15MB2968.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IHQIv83mJu1zNtqn1DtWBf5YNqNK1g1ak1nxAPIAGfMkfZaqJm8EW2T55sMWm+Bf/w1GZewReOIdiD4u1LiEzFUNq3ikPM2kMQzUV4HXVyQiYyPHewftlpFyqbQaiaOOX+E5CS5ac/UKCL3/A8K9ShmkhFbNFumyUDa84JK9LbvwgqbE3tBh4Fsj2oipFVO4+BT6vpxywRzshttLG0AU3UJGJtIV9NpW59dyRxc+naBp2UORiCARKzRKn30m00pT1/C8gqF1CsR5iGLwU9YKLAGQkQ7igQg9janWGzbfgFqgOnVjOAu9mNAjyfKKhENMnFb6X+JS0M767ywIU4AQzyPC0AzZBEB0JjB79qGg/lRCgCY7vZwMbKOxr9Uu/cC5EC0WMymG17S2hKKdzHjrol5uHxHrcBMKY70pKTnms0k=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B789488F364D6040A38EAAF5994CBA5E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c0d30b-a9c9-43bb-4c20-08d6e947f79e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2019 23:54:22.4021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hechaol@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2934
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-04_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=945 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906040151
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SSBwdXQgdGhlIGltcGxlbWVudGF0aW9uIGluIGxpYmJwZl91dGlsLmMgbWFpbmx5IGJlY2F1c2Ug
aXQgZGVwZW5kcyBvbiBwcl93YXJuaW5nIGRlZmluZWQgaW4gbGliYnBmX2ludGVybmFsLmguIElm
IGluY2x1ZGluZyBsaWJicGZfaW50ZXJuYWwuaCBpbiBsaWJicGZfdXRpbC5oLCB0aGVuIHRoZSBp
bnRlcm5hbCBzdHVmZiB3aWxsIGJlIGV4cG9zZWQgdG8gd2hvZXZlciBpbmNsdWRlIGxpYmJwZl91
dGlsLmguIEJ1dCBsZXQgbWUga25vdyBpZiB0aGVyZSBpcyBhIGJldHRlciB3YXkgdG8gcHJpbnQg
dGhlIGVycm9yIG1lc3NhZ2VzIG90aGVyIHRoYW4gZGVwZW5kaW5nIG9uIGxpYmJwZl9pbnRlcm5h
bC4gDQoNClRoYW5rcywNCkhlY2hhbw0KDQrvu79PbiA2LzQvMTksIDQ6NDAgUE0sICJTb25nIExp
dSIgPHNvbmdsaXVicmF2aW5nQGZiLmNvbT4gd3JvdGU6DQoNCiAgICANCiAgICA+IE9uIEp1biA0
LCAyMDE5LCBhdCAzOjM4IFBNLCBIZWNoYW8gTGkgPGhlY2hhb2xAZmIuY29tPiB3cm90ZToNCiAg
ICA+IA0KICAgID4gR2V0dGluZyBudW1iZXIgb2YgcG9zc2libGUgQ1BVcyBpcyBjb21tb25seSB1
c2VkIGZvciBwZXItQ1BVIEJQRiBtYXBzIA0KICAgID4gYW5kIHBlcmZfZXZlbnRfbWFwcy4gUHV0
dGluZyBpdCBpbnRvIGEgY29tbW9uIHBsYWNlIGNhbiBhdm9pZCBkdXBsaWNhdGUgDQogICAgPiBp
bXBsZW1lbnRhdGlvbnMuDQogICAgPiANCiAgICA+IEhlY2hhbyBMaSAoMik6DQogICAgPiAgQWRk
IGJwZl9udW1fcG9zc2libGVfY3B1cyB0byBsaWJicGZfdXRpbA0KICAgID4gIFVzZSBicGZfbnVt
X3Bvc3NpYmxlX2NwdXMgaW4gYnBmdG9vbCBhbmQgc2VsZnRlc3RzDQogICAgPiANCiAgICA+IHRv
b2xzL2JwZi9icGZ0b29sL2NvbW1vbi5jICAgICAgICAgICAgICAgICAgICB8IDUzICsrLS0tLS0t
LS0tLS0tLS0NCiAgICA+IHRvb2xzL2xpYi9icGYvQnVpbGQgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAyICstDQogICAgPiB0b29scy9saWIvYnBmL2xpYmJwZl91dGlsLmMgICAgICAgICAg
ICAgICAgICAgfCA2MSArKysrKysrKysrKysrKysrKysrDQogICAgPiB0b29scy9saWIvYnBmL2xp
YmJwZl91dGlsLmggICAgICAgICAgICAgICAgICAgfCAgNyArKysNCiAgICA+IHRvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL2JwZi9icGZfdXRpbC5oICAgICAgICB8IDQyICsrKy0tLS0tLS0tLS0NCiAg
ICA+IC4uLi9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvbDRsYl9hbGwuYyAgICAgICB8ICAyICst
DQogICAgPiAuLi4vc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3hkcF9ub2lubGluZS5jICAgfCAg
MiArLQ0KICAgID4gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Rlc3RfYnRmLmMgICAgICAg
IHwgIDIgKy0NCiAgICA+IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi90ZXN0X2xydV9tYXAu
YyAgICB8ICAyICstDQogICAgPiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvdGVzdF9tYXBz
LmMgICAgICAgfCAgNiArLQ0KICAgID4gMTAgZmlsZXMgY2hhbmdlZCwgODggaW5zZXJ0aW9ucygr
KSwgOTEgZGVsZXRpb25zKC0pDQogICAgPiBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvbGliL2Jw
Zi9saWJicGZfdXRpbC5jDQogICAgPiANCiAgICA+IC0tIA0KICAgID4gMi4xNy4xDQogICAgPiAN
CiAgICANCiAgICBUaGUgY2hhbmdlIGlzIG1vc3RseSBzdHJhaWdodGZvcndhcmQuIEhvd2V2ZXIs
IEkgYW0gbm90IHN1cmUgd2hldGhlcg0KICAgIHRoZXkgc2hvdWxkIGJlIGFkZGVkIHRvIGxpYmJw
Zl91dGlsLmguIE1heWJlIGxpYmJwZi5oIGlzIGEgYmV0dGVyIA0KICAgIHBsYWNlPw0KICAgIA0K
ICAgIERhbmllbCBhbmQgQWxleGVpLCB3aGF0J3MgeW91ciByZWNvbW1lbmRhdGlvbiBoZXJlPyAN
CiAgICANCiAgICBUaGFua3MsDQogICAgU29uZw0KICAgIA0KICAgIA0KICAgIA0KICAgIA0KDQo=
