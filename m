Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA4C147500
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2020 00:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgAWXtX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 18:49:23 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:3640 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728665AbgAWXtX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Jan 2020 18:49:23 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00NNjIjs030124;
        Thu, 23 Jan 2020 15:48:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=3wEr0kwihbN/aSGgJSnfBgm5cyEkqu8AW4+PTqneJSo=;
 b=C7rlh2yj29K0HiEAQ6cI/Yf76kmNxgSLoQortaXvNpOHmKIvRREkiuiQO6HqkU1i1ypY
 uMg9RRkwjZea8FUDnlE7nh5XdgOODCeuPU0RV9PwDXngQkxc863nG9K6usHz9955lk4Q
 c6UnMcTifMgu5n9WSFkivpw2coRxIKQEfQ0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xq49c4ggv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Jan 2020 15:48:56 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 23 Jan 2020 15:48:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGswrgQIBE/jXI4QdzGMAmVmwTTjyjxL2O5CdW5gAYgslwjp8L7KvWO//xyQM6J9rGKFctpbnomNK0/oEpsJe0MDeWWmRmOAmiKNmRAXshDiUtty1cfXgKMjTJWMYrpFFK5DuwQxdMTW3mueV0utmgpJEMapADhmG952sA4lczESwy+NleqGUv82ysqZxwqTirXCfrigAqy3QNNzGibPx3AhTkIbthGP+cd8Rkhn2ociqGhdx3nzpKLZWPqF/F0WEEQdINn4TKBWfQC9rWJJaFgQPMjTEJvwWpuKKtr/g0dH/7t/UFCT1msnvKCI7oUoy4I9j6S3+cI3E5VKze5vgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wEr0kwihbN/aSGgJSnfBgm5cyEkqu8AW4+PTqneJSo=;
 b=TLrqCyTkjqwW5OKe2B1PEs3IL0RNVMrOGAtnYiAw/hzAuVqA/ufPLz8QowazkWpTQUFfqokHZXxBGdv8aOZcN3WsoCWv2uljHso7y3LZCvs8PMboypS1Spimu7CqURuoL7F0wxrgrHgCeUTZbQ95mlOCIojlt7dG3r308CsJRePU1dBS1m7UOV8OfMeWXKz1d41sQWoRmckajtrd4oyTkLjRktzYkrYdjgqpnXvIB24enk0i9bEyemXK5SIbGFR80kbQNKHT6QljG4nXCDCHzFTAj/wimXfLhSiietQSd4hfVnEymxHRR3ndHIUDrQV5ay+sD57rLHG1Bx4a0sLRBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wEr0kwihbN/aSGgJSnfBgm5cyEkqu8AW4+PTqneJSo=;
 b=NJCTaxa+OzX4eSIFN8+qB0VD3fQJQS//laeWfScuMOUex3vNpk91EqoaX4P4g+zCzsFcRApxOm9jmL2LjPWd2LpSDu64IKnS/bvIWH6ukVDFIg/oJ2ZHGbQyXQbNI2WiuCd+wPw/bU8Wg1yn2ztV7XkSnSbIk0bwh9p2N+zGIeE=
Received: from DM6PR15MB3001.namprd15.prod.outlook.com (20.178.231.16) by
 DM6PR15MB2730.namprd15.prod.outlook.com (20.179.164.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Thu, 23 Jan 2020 23:48:55 +0000
Received: from DM6PR15MB3001.namprd15.prod.outlook.com
 ([fe80::1d74:b392:183e:c8c2]) by DM6PR15MB3001.namprd15.prod.outlook.com
 ([fe80::1d74:b392:183e:c8c2%6]) with mapi id 15.20.2644.028; Thu, 23 Jan 2020
 23:48:55 +0000
Received: from macbook-pro-52.dhcp.thefacebook.com (2620:10d:c090:200::3:d9ea) by MWHPR22CA0012.namprd22.prod.outlook.com (2603:10b6:300:ef::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend Transport; Thu, 23 Jan 2020 23:48:53 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Daniel Xu <dxu@dxuuu.xyz>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>
Subject: Re: [PATCH v3 bpf-next 1/3] bpf: Add bpf_perf_prog_read_branches()
 helper
Thread-Topic: [PATCH v3 bpf-next 1/3] bpf: Add bpf_perf_prog_read_branches()
 helper
Thread-Index: AQHV0jNjlQny4mUlfUCZG6n7Skv20qf46uqA
Date:   Thu, 23 Jan 2020 23:48:55 +0000
Message-ID: <5f8e2ffd-9368-cb0c-9591-c6b7ecb8edb0@fb.com>
References: <20200123212312.3963-1-dxu@dxuuu.xyz>
 <20200123212312.3963-2-dxu@dxuuu.xyz>
In-Reply-To: <20200123212312.3963-2-dxu@dxuuu.xyz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0012.namprd22.prod.outlook.com
 (2603:10b6:300:ef::22) To DM6PR15MB3001.namprd15.prod.outlook.com
 (2603:10b6:5:13c::16)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:d9ea]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de68e52f-1817-45fc-1326-08d7a05ece7f
x-ms-traffictypediagnostic: DM6PR15MB2730:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR15MB273073A9C0EF7705BC721AB4D30F0@DM6PR15MB2730.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(39860400002)(396003)(366004)(199004)(189003)(66446008)(478600001)(5660300002)(81156014)(8676002)(64756008)(81166006)(53546011)(8936002)(66476007)(66556008)(31686004)(36756003)(6506007)(52116002)(110136005)(54906003)(2906002)(316002)(4326008)(86362001)(31696002)(71200400001)(66946007)(2616005)(186003)(6512007)(6636002)(6486002)(16526019);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB2730;H:DM6PR15MB3001.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DlwhomCMoh1GCIxlTYA/4DAwvZ7ZpcwXCCIHMW5WSvnwBk3acX8roCqVyuret4ALqBE474n/YB6u2jkEC1qtS3LxR9QUwPvLtvV3fc0HsETfCHoyoyGMumqfJIpScQk1wZCZubCFBy08Etbw0paNhl0zuWDHf/KYOySOf78CFtuK9bUTrOId3K4xdRoL8MRbGEEd0chwGY8ESLOlIuZspO0GiBMNsXWrHYGWeAtZoNO6KzFC+7MSwDPdhnKg3k0tR9SMygMvxfpsEv7gEGOfP4ubW27jdHFcXv7DECDJAYh2NzB7J3lNS25oGJzed3q+1vvKW1lXG1cLFh2QxKm6Kww+q0H/W1sE74WdGtML+zGpRZBy2wul0VTHdkRAb9hoa268xAmxI1kDyI5fgz4Sb0slLeQeZ00dePl2Nz2CJXD11UQUsg9QPqkkOpLquyzr
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9FCA0C026767C4B9028EDED55D86991@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: de68e52f-1817-45fc-1326-08d7a05ece7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 23:48:55.0547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KLpJI9Bpxu88cpZ6pD2oiB1Ikr6dP1MG2Z9DIjnX/2gzSsKaRn8iKArQ+ufMIPW7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2730
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-23_13:2020-01-23,2020-01-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0 suspectscore=0
 clxscore=1011 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001230177
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDEvMjMvMjAgMToyMyBQTSwgRGFuaWVsIFh1IHdyb3RlOg0KPiBCcmFuY2ggcmVjb3Jk
cyBhcmUgYSBDUFUgZmVhdHVyZSB0aGF0IGNhbiBiZSBjb25maWd1cmVkIHRvIHJlY29yZA0KPiBj
ZXJ0YWluIGJyYW5jaGVzIHRoYXQgYXJlIHRha2VuIGR1cmluZyBjb2RlIGV4ZWN1dGlvbi4gVGhp
cyBkYXRhIGlzDQo+IHBhcnRpY3VsYXJseSBpbnRlcmVzdGluZyBmb3IgcHJvZmlsZSBndWlkZWQg
b3B0aW1pemF0aW9ucy4gcGVyZiBoYXMgaGFkDQo+IGJyYW5jaCByZWNvcmQgc3VwcG9ydCBmb3Ig
YSB3aGlsZSBidXQgdGhlIGRhdGEgY29sbGVjdGlvbiBjYW4gYmUgYSBiaXQNCj4gY29hcnNlIGdy
YWluZWQuDQo+IA0KPiBXZSAoRmFjZWJvb2spIGhhdmUgc2VlbiBpbiBleHBlcmltZW50cyB0aGF0
IGFzc29jaWF0aW5nIG1ldGFkYXRhIHdpdGgNCj4gYnJhbmNoIHJlY29yZHMgY2FuIGltcHJvdmUg
cmVzdWx0cyAoYWZ0ZXIgcG9zdHByb2Nlc3NpbmcpLiBXZSBnZW5lcmFsbHkNCj4gdXNlIGJwZl9w
cm9iZV9yZWFkXyooKSB0byBnZXQgbWV0YWRhdGEgb3V0IG9mIHVzZXJzcGFjZS4gVGhhdCdzIHdo
eSBicGYNCj4gc3VwcG9ydCBmb3IgYnJhbmNoIHJlY29yZHMgaXMgdXNlZnVsLg0KPiANCj4gQXNp
ZGUgZnJvbSB0aGlzIHBhcnRpY3VsYXIgdXNlIGNhc2UsIGhhdmluZyBicmFuY2ggZGF0YSBhdmFp
bGFibGUgdG8gYnBmDQo+IHByb2dzIGNhbiBiZSB1c2VmdWwgdG8gZ2V0IHN0YWNrIHRyYWNlcyBv
dXQgb2YgdXNlcnNwYWNlIGFwcGxpY2F0aW9ucw0KPiB0aGF0IG9taXQgZnJhbWUgcG9pbnRlcnMu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgWHUgPGR4dUBkeHV1dS54eXo+DQo+IC0tLQ0K
PiAgIGluY2x1ZGUvdWFwaS9saW51eC9icGYuaCB8IDE1ICsrKysrKysrKysrKysrLQ0KPiAgIGtl
cm5lbC90cmFjZS9icGZfdHJhY2UuYyB8IDMxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4gICAyIGZpbGVzIGNoYW5nZWQsIDQ1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmggYi9pbmNsdWRlL3Vh
cGkvbGludXgvYnBmLmgNCj4gaW5kZXggZjFkNzRhMmJkMjM0Li41MGM1ODBjOGEyMDEgMTAwNjQ0
DQo+IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC9icGYuaA0KPiArKysgYi9pbmNsdWRlL3VhcGkv
bGludXgvYnBmLmgNCj4gQEAgLTI4OTIsNiArMjg5MiwxOCBAQCB1bmlvbiBicGZfYXR0ciB7DQo+
ICAgICoJCU9idGFpbiB0aGUgNjRiaXQgamlmZmllcw0KPiAgICAqCVJldHVybg0KPiAgICAqCQlU
aGUgNjQgYml0IGppZmZpZXMNCj4gKyAqDQo+ICsgKiBpbnQgYnBmX3BlcmZfcHJvZ19yZWFkX2Jy
YW5jaGVzKHN0cnVjdCBicGZfcGVyZl9ldmVudF9kYXRhICpjdHgsIHZvaWQgKmJ1ZiwgdTMyIGJ1
Zl9zaXplKQ0KPiArICoJRGVzY3JpcHRpb24NCj4gKyAqCQlGb3IgZW4gZUJQRiBwcm9ncmFtIGF0
dGFjaGVkIHRvIGEgcGVyZiBldmVudCwgcmV0cmlldmUgdGhlDQoNCmVuID0+IGFuDQoNCj4gKyAq
CQlicmFuY2ggcmVjb3JkcyAoc3RydWN0IHBlcmZfYnJhbmNoX2VudHJ5KSBhc3NvY2lhdGVkIHRv
ICpjdHgqDQo+ICsgKgkJYW5kIHN0b3JlIGl0IGluCXRoZSBidWZmZXIgcG9pbnRlZCBieSAqYnVm
KiB1cCB0byBzaXplDQo+ICsgKgkJKmJ1Zl9zaXplKiBieXRlcy4NCj4gKyAqDQo+ICsgKgkJQW55
IHVudXNlZCBwYXJ0cyBvZiAqYnVmKiB3aWxsIGJlIGZpbGxlZCB3aXRoIHplcm9zLg0KPiArICoJ
UmV0dXJuDQo+ICsgKgkJT24gc3VjY2VzcywgbnVtYmVyIG9mIGJ5dGVzIHdyaXR0ZW4gdG8gKmJ1
ZiouIE9uIGVycm9yLCBhDQo+ICsgKgkJbmVnYXRpdmUgdmFsdWUuDQo+ICAgICovDQo+ICAgI2Rl
ZmluZSBfX0JQRl9GVU5DX01BUFBFUihGTikJCVwNCj4gICAJRk4odW5zcGVjKSwJCQlcDQo+IEBA
IC0zMDEyLDcgKzMwMjQsOCBAQCB1bmlvbiBicGZfYXR0ciB7DQo+ICAgCUZOKHByb2JlX3JlYWRf
a2VybmVsX3N0ciksCVwNCj4gICAJRk4odGNwX3NlbmRfYWNrKSwJCVwNCj4gICAJRk4oc2VuZF9z
aWduYWxfdGhyZWFkKSwJCVwNCj4gLQlGTihqaWZmaWVzNjQpLA0KPiArCUZOKGppZmZpZXM2NCks
CQkJXA0KPiArCUZOKHBlcmZfcHJvZ19yZWFkX2JyYW5jaGVzKSwNCj4gICANCj4gICAvKiBpbnRl
Z2VyIHZhbHVlIGluICdpbW0nIGZpZWxkIG9mIEJQRl9DQUxMIGluc3RydWN0aW9uIHNlbGVjdHMg
d2hpY2ggaGVscGVyDQo+ICAgICogZnVuY3Rpb24gZUJQRiBwcm9ncmFtIGludGVuZHMgdG8gY2Fs
bA0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL3RyYWNlL2JwZl90cmFjZS5jIGIva2VybmVsL3RyYWNl
L2JwZl90cmFjZS5jDQo+IGluZGV4IDE5ZTc5M2FhNDQxYS4uMjRjNTEyNzJhMWY3IDEwMDY0NA0K
PiAtLS0gYS9rZXJuZWwvdHJhY2UvYnBmX3RyYWNlLmMNCj4gKysrIGIva2VybmVsL3RyYWNlL2Jw
Zl90cmFjZS5jDQo+IEBAIC0xMDI4LDYgKzEwMjgsMzUgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBi
cGZfZnVuY19wcm90byBicGZfcGVyZl9wcm9nX3JlYWRfdmFsdWVfcHJvdG8gPSB7DQo+ICAgICAg
ICAgICAgLmFyZzNfdHlwZSAgICAgID0gQVJHX0NPTlNUX1NJWkUsDQo+ICAgfTsNCj4gICANCj4g
K0JQRl9DQUxMXzMoYnBmX3BlcmZfcHJvZ19yZWFkX2JyYW5jaGVzLCBzdHJ1Y3QgYnBmX3BlcmZf
ZXZlbnRfZGF0YV9rZXJuICosIGN0eCwNCj4gKwkgICB2b2lkICosIGJ1ZiwgdTMyLCBzaXplKQ0K
PiArew0KPiArCXN0cnVjdCBwZXJmX2JyYW5jaF9zdGFjayAqYnJfc3RhY2sgPSBjdHgtPmRhdGEt
PmJyX3N0YWNrOw0KPiArCXUzMiB0b19jb3B5ID0gMCwgdG9fY2xlYXIgPSBzaXplOw0KPiArCWlu
dCBlcnIgPSAtRUlOVkFMOw0KPiArDQo+ICsJaWYgKHVubGlrZWx5KCFicl9zdGFjaykpDQo+ICsJ
CWdvdG8gY2xlYXI7DQo+ICsNCj4gKwl0b19jb3B5ID0gbWluX3QodTMyLCBicl9zdGFjay0+bnIg
KiBzaXplb2Yoc3RydWN0IHBlcmZfYnJhbmNoX2VudHJ5KSwgc2l6ZSk7DQo+ICsJdG9fY2xlYXIg
LT0gdG9fY29weTsNCj4gKw0KPiArCW1lbWNweShidWYsIGJyX3N0YWNrLT5lbnRyaWVzLCB0b19j
b3B5KTsNCj4gKwllcnIgPSB0b19jb3B5Ow0KPiArY2xlYXI6DQo+ICsJbWVtc2V0KGJ1ZiArIHRv
X2NvcHksIDAsIHRvX2NsZWFyKTsNCj4gKwlyZXR1cm4gZXJyOw0KDQpJZiBzaXplIDwgdTMyLCBi
cl9zdGFjay0+bnIgKiBzaXplb2Yoc3RydWN0IHBlcmZfYnJhbmNoX2VudHJ5KSwNCnVzZXIgaGFz
IG5vIHdheSB0byBrbm93IHdoZXRoZXIgc29tZSBlbnRyaWVzIGFyZSBub3QgY29waWVkIGV4Y2Vw
dA0KcmVwZWF0ZWQgdHJ5aW5nIGxhcmdlciBidWZmZXJzIHVudGlsIHRoZSByZXR1cm4gdmFsdWUg
aXMgc21hbGxlcg0KdGhhbiBpbnB1dCBidWZmZXIgc2l6ZS4NCg0KSSB0aGluayByZXR1cm5pbmcg
dGhlIGV4cGVjdGVkIGJ1ZmZlciBzaXplIHRvIHVzZXJzIHNob3VsZCBiZSBhIGdvb2QgDQp0aGlu
Zz8gV2UgbWF5IG5vdCBoYXZlIG1hbGxvYyB0b2RheSBpbiBicGYsIGJ1dCBmdXR1cmUgbWFsbG9j
IHRoaW5nIA0Kc2hvdWxkIGhlbHAgaW4gdGhpcyBjYXNlLg0KDQpJbiB1c2VyIHNwYWNlLCB1c2Vy
IG1heSBoYXZlIGEgZml4ZWQgYnVmZmVyLCByZXBlYXRlZCBgcmVhZGAgc2hvdWxkDQpyZWFkIGFs
bCB2YWx1ZXMuDQoNClVzaW5nIGJwZl9wcm9iZV9yZWFkKCksIHJlcGVhdGVkIHJlYWQgd2l0aCBh
ZGp1c3RlZCBzb3VyY2UgcG9pbnRlcg0KY2FuIGFsc28gcmVhZCBhbGwgYnVmZmVycy4NCg0KT25l
IHBvc3NpYmxlIGRlc2lnbiBpcyB0byBhZGQgYSBmbGFnIHRvIHRoZSBmdW5jdGlvbiwgZS5nLiwg
aWYNCmZsYWcgPT0gR0VUX0JSX1NUQUNLX05SLCByZXR1cm4gYnJfc3RhY2stPm5yIGluIGJ1Zi9z
aXplLg0KaWYgZmxhZyA9PSBHRVRfQlJfU1RBQ0ssIHJldHVybiBicl9zdGFjay0+ZW50cmllcyBp
biBidWYvc2l6ZS4NCg0KV2hhdCBkbyB5b3UgdGhpbms/DQoNCg0KPiArfQ0KPiArDQo+ICtzdGF0
aWMgY29uc3Qgc3RydWN0IGJwZl9mdW5jX3Byb3RvIGJwZl9wZXJmX3Byb2dfcmVhZF9icmFuY2hl
c19wcm90byA9IHsNCj4gKyAgICAgICAgIC5mdW5jICAgICAgICAgICA9IGJwZl9wZXJmX3Byb2df
cmVhZF9icmFuY2hlcywNCj4gKyAgICAgICAgIC5ncGxfb25seSAgICAgICA9IHRydWUsDQo+ICsg
ICAgICAgICAucmV0X3R5cGUgICAgICAgPSBSRVRfSU5URUdFUiwNCj4gKyAgICAgICAgIC5hcmcx
X3R5cGUgICAgICA9IEFSR19QVFJfVE9fQ1RYLA0KPiArICAgICAgICAgLmFyZzJfdHlwZSAgICAg
ID0gQVJHX1BUUl9UT19VTklOSVRfTUVNLA0KPiArICAgICAgICAgLmFyZzNfdHlwZSAgICAgID0g
QVJHX0NPTlNUX1NJWkUsDQo+ICt9Ow0KPiArDQo+ICAgc3RhdGljIGNvbnN0IHN0cnVjdCBicGZf
ZnVuY19wcm90byAqDQo+ICAgcGVfcHJvZ19mdW5jX3Byb3RvKGVudW0gYnBmX2Z1bmNfaWQgZnVu
Y19pZCwgY29uc3Qgc3RydWN0IGJwZl9wcm9nICpwcm9nKQ0KPiAgIHsNCj4gQEAgLTEwNDAsNiAr
MTA2OSw4IEBAIHBlX3Byb2dfZnVuY19wcm90byhlbnVtIGJwZl9mdW5jX2lkIGZ1bmNfaWQsIGNv
bnN0IHN0cnVjdCBicGZfcHJvZyAqcHJvZykNCj4gICAJCXJldHVybiAmYnBmX2dldF9zdGFja19w
cm90b190cDsNCj4gICAJY2FzZSBCUEZfRlVOQ19wZXJmX3Byb2dfcmVhZF92YWx1ZToNCj4gICAJ
CXJldHVybiAmYnBmX3BlcmZfcHJvZ19yZWFkX3ZhbHVlX3Byb3RvOw0KPiArCWNhc2UgQlBGX0ZV
TkNfcGVyZl9wcm9nX3JlYWRfYnJhbmNoZXM6DQo+ICsJCXJldHVybiAmYnBmX3BlcmZfcHJvZ19y
ZWFkX2JyYW5jaGVzX3Byb3RvOw0KPiAgIAlkZWZhdWx0Og0KPiAgIAkJcmV0dXJuIHRyYWNpbmdf
ZnVuY19wcm90byhmdW5jX2lkLCBwcm9nKTsNCj4gICAJfQ0KPiANCg==
