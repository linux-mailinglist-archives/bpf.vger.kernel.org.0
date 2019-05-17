Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D969C21F58
	for <lists+bpf@lfdr.de>; Fri, 17 May 2019 23:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbfEQVHF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 May 2019 17:07:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56134 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727001AbfEQVHF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 17 May 2019 17:07:05 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4HKvcoT014951;
        Fri, 17 May 2019 14:06:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=FlwZ3sRPJ1dyvs8MriW9y1iV5UtA2SyO5TtrtnNucHg=;
 b=SwW0DRhmUxN85tH9ZXJpcj0k4WAfbe8DaRKafndy9CKyIfpm0WPg7uTFwJEUrsuz8yrv
 nEsigA6lsqn2AOyF0zJuxc97ijhtd8oi8ARU2qWKhd+sLPU0q27b3SkTKnWp48pcNCX5
 22dU9KO0yjBCl9yMFKU5FnS/iGaEmcqkS/I= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sj0k70vrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 May 2019 14:06:36 -0700
Received: from ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 17 May 2019 14:06:28 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 17 May 2019 14:06:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlwZ3sRPJ1dyvs8MriW9y1iV5UtA2SyO5TtrtnNucHg=;
 b=egvKsdO19NmoQsFgWvElLCwckEZedHk61Q7nj7fmwGdcOP9B2qKncYM/rMEZUfP3nml+PRHb9HU1HJR21M0rJyWK097ywuCiSZI5IEhmKxPl2HPLGFmx2gsH6NAf255y0ADMQic/xA5HI66UwU7fI2OqKu32cPG8lYlXtx9PJhk=
Received: from BYAPR15MB2501.namprd15.prod.outlook.com (52.135.196.11) by
 BYAPR15MB2277.namprd15.prod.outlook.com (52.135.197.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Fri, 17 May 2019 21:06:26 +0000
Received: from BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::140e:9c62:f2d3:7f27]) by BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::140e:9c62:f2d3:7f27%7]) with mapi id 15.20.1878.024; Fri, 17 May 2019
 21:06:26 +0000
From:   Alexei Starovoitov <ast@fb.com>
To:     Song Liu <songliubraving@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Kairui Song <kasong@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: Getting empty callchain from perf_callchain_kernel()
Thread-Topic: Getting empty callchain from perf_callchain_kernel()
Thread-Index: AQHVDEJXYtrotGS6bU+cxwR7BKWjbKZu8J8AgAAG+ICAAAFQgIAAD2QAgACfPwCAACizAA==
Date:   Fri, 17 May 2019 21:06:25 +0000
Message-ID: <c881767d-b6f3-c53e-5c70-556d09ea8d89@fb.com>
References: <3CD3EE63-0CD2-404A-A403-E11DCF2DF8D9@fb.com>
 <20190517074600.GJ2623@hirez.programming.kicks-ass.net>
 <20190517081057.GQ2650@hirez.programming.kicks-ass.net>
 <CACPcB9cB5n1HOmZcVpusJq8rAV5+KfmZ-Lxv3tgsSoy7vNrk7w@mail.gmail.com>
 <20190517091044.GM2606@hirez.programming.kicks-ass.net>
 <8C814E68-B0B6-47E4-BDD6-917B01EC62D0@fb.com>
In-Reply-To: <8C814E68-B0B6-47E4-BDD6-917B01EC62D0@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR20CA0008.namprd20.prod.outlook.com
 (2603:10b6:300:13d::18) To BYAPR15MB2501.namprd15.prod.outlook.com
 (2603:10b6:a02:88::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::ab75]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 597ef880-eaba-45e4-1fc6-08d6db0b85c0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2277;
x-ms-traffictypediagnostic: BYAPR15MB2277:
x-microsoft-antispam-prvs: <BYAPR15MB227782439C9990D08E571CCCD70B0@BYAPR15MB2277.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(376002)(136003)(366004)(189003)(199004)(14454004)(25786009)(4326008)(53936002)(2906002)(6246003)(6116002)(66476007)(305945005)(186003)(7736002)(81156014)(99286004)(6512007)(486006)(446003)(66946007)(478600001)(68736007)(8676002)(66556008)(66446008)(71190400001)(31686004)(71200400001)(64756008)(73956011)(8936002)(81166006)(46003)(52116002)(36756003)(386003)(6506007)(110136005)(54906003)(5660300002)(31696002)(86362001)(256004)(102836004)(76176011)(6486002)(6436002)(11346002)(229853002)(316002)(53546011)(476003)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2277;H:BYAPR15MB2501.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RRA1/KwIOWTFcrjWAVlm1dhBUiqtHqxEn7xqdDWleefUgUln336Wj2lr/aIfNooHpGqvAfJzDdXShQxpxU2VqX06oIo2lvviWlNTqQ5ZE+60BNj3W+uiGMBJf4z8ITUimri5vaAXbvpa4aLXVhFuAieeTrfTLj+DHHg2OQbL7JTHN9E+sxXDz3kbENPnnv419vEZ+Sr3tlp4jTjynEm/soFBvzVp3GrGkqqv2BNVzAdGC8Wy6ZVh+ZZcDjwZamo3cHY7B1aKx6LPwknbUjsXRJJhcrQBH7kFNpefvLDa5pWB6ucQ1rZzKcRHjonmATniIun3G9DCAG8usxbnt5G4TmW8rSfmzgzRaK4FON2hrV61Q8S7E4uIzi7uUjKXhV85h4IWkm8LHlWv1HpVDRiaetN1OBTlxnelSHkmfLrouuI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00E44FC20819F64BB81712F8B1FAA513@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 597ef880-eaba-45e4-1fc6-08d6db0b85c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 21:06:25.9844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2277
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-17_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905170125
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gNS8xNy8xOSAxMTo0MCBBTSwgU29uZyBMaXUgd3JvdGU6DQo+ICtBbGV4ZWksIERhbmllbCwg
YW5kIGJwZg0KPiANCj4+IE9uIE1heSAxNywgMjAxOSwgYXQgMjoxMCBBTSwgUGV0ZXIgWmlqbHN0
cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPiB3cm90ZToNCj4+DQo+PiBPbiBGcmksIE1heSAxNywg
MjAxOSBhdCAwNDoxNTozOVBNICswODAwLCBLYWlydWkgU29uZyB3cm90ZToNCj4+PiBIaSwgSSB0
aGluayB0aGUgYWN0dWFsIHByb2JsZW0gaXMgdGhhdCBicGZfZ2V0X3N0YWNraWRfdHAgKGFuZCBt
YXliZQ0KPj4+IHNvbWUgb3RoZXIgYmZwIGZ1bmN0aW9ucykgaXMgbm93IGJyb2tlbiwgb3IsIHN0
cmF0aW5nIGFuIHVud2luZA0KPj4+IGRpcmVjdGx5IGluc2lkZSBhIGJwZiBwcm9ncmFtIHdpbGwg
ZW5kIHVwIHN0cmFuZ2VseS4gSXQgaGF2ZSBmb2xsb3dpbmcNCj4+PiBrZXJuZWwgbWVzc2FnZToN
Cj4+DQo+PiBVcmdoLCB3aGF0IGlzIHRoYXQgYnBmX2dldF9zdGFja2lkX3RwKCkgZG9pbmcgdG8g
Z2V0IHRoZSByZWdzPyBJIGNhbid0DQo+PiBmb2xsb3cuDQo+IA0KPiBJIGd1ZXNzIHdlIG5lZWQg
c29tZXRoaW5nIGxpa2UgdGhlIGZvbGxvd2luZz8gKHdlIHNob3VsZCBiZSBhYmxlIHRvDQo+IG9w
dGltaXplIHRoZSBQRVJfQ1BVIHN0dWZmKS4NCj4gDQo+IFRoYW5rcywNCj4gU29uZw0KPiANCj4g
DQo+IGRpZmYgLS1naXQgaS9rZXJuZWwvdHJhY2UvYnBmX3RyYWNlLmMgdy9rZXJuZWwvdHJhY2Uv
YnBmX3RyYWNlLmMNCj4gaW5kZXggZjkyZDZhZDVlMDgwLi5jNTI1MTQ5MDI4YTcgMTAwNjQ0DQo+
IC0tLSBpL2tlcm5lbC90cmFjZS9icGZfdHJhY2UuYw0KPiArKysgdy9rZXJuZWwvdHJhY2UvYnBm
X3RyYWNlLmMNCj4gQEAgLTY5NiwxMSArNjk2LDEzIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYnBm
X2Z1bmNfcHJvdG8gYnBmX3BlcmZfZXZlbnRfb3V0cHV0X3Byb3RvX3RwID0gew0KPiAgICAgICAg
ICAuYXJnNV90eXBlICAgICAgPSBBUkdfQ09OU1RfU0laRV9PUl9aRVJPLA0KPiAgIH07DQo+IA0K
PiArc3RhdGljIERFRklORV9QRVJfQ1BVKHN0cnVjdCBwdF9yZWdzLCBicGZfc3RhY2tpZF90cF9y
ZWdzKTsNCj4gICBCUEZfQ0FMTF8zKGJwZl9nZXRfc3RhY2tpZF90cCwgdm9pZCAqLCB0cF9idWZm
LCBzdHJ1Y3QgYnBmX21hcCAqLCBtYXAsDQo+ICAgICAgICAgICAgIHU2NCwgZmxhZ3MpDQo+ICAg
ew0KPiAtICAgICAgIHN0cnVjdCBwdF9yZWdzICpyZWdzID0gKihzdHJ1Y3QgcHRfcmVncyAqKil0
cF9idWZmOw0KPiArICAgICAgIHN0cnVjdCBwdF9yZWdzICpyZWdzID0gdGhpc19jcHVfcHRyKCZi
cGZfc3RhY2tpZF90cF9yZWdzKTsNCj4gDQo+ICsgICAgICAgcGVyZl9mZXRjaF9jYWxsZXJfcmVn
cyhyZWdzKTsNCg0KTm8uIHB0X3JlZ3MgaXMgYWxyZWFkeSBwYXNzZWQgaW4uIEl0J3MgdGhlIGZp
cnN0IGFyZ3VtZW50Lg0KSWYgd2UgY2FsbCBwZXJmX2ZldGNoX2NhbGxlcl9yZWdzKCkgYWdhaW4g
dGhlIHN0YWNrIHRyYWNlIHdpbGwgYmUgd3JvbmcuDQpicGYgcHJvZyBzaG91bGQgbm90IHNlZSBp
dHNlbGYsIGludGVycHJldGVyIG9yIGFsbCB0aGUgZnJhbWVzIGluIGJldHdlZW4uDQo=
