Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6499A8F7CE
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2019 02:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbfHPAGV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Aug 2019 20:06:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:19716 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725978AbfHPAGU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 15 Aug 2019 20:06:20 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7G053k5029711;
        Thu, 15 Aug 2019 17:06:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=uua3R31Eh3MUF+NI7B1IKVk9T3cqWVN6lwX79lCki5M=;
 b=p7RN/eMMahUsWDnOX1bTjKxCt7nP0MlSLKx4I/mnFOrAPhjCNySnPLcc3+7da/P79oUI
 86SFrXKfi5dnsdhGjT/dCW9On/8FVdHhLc4RKoWaxMPUyoQuPVaRiUfM7p9CbWChJkP2
 mwykZHWG0MDkPikCqfRpPEVk7bR9T4jDGqU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2udemsrsbj-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 15 Aug 2019 17:06:00 -0700
Received: from ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) by
 ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 15 Aug 2019 17:05:55 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 15 Aug 2019 17:05:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDDmMV57FlPgRgElxz/qxXSTZ0GMbWyAOcSTqS+PZB5SMmMDtRXed2A0eXBorMJqcWfuTbCW4BV6Gddx3qz8aNo1hgpLKKiojCB7tR4EKSpmDdUrePuFb+ZkevbLPKqODEAsqmLyrDTzJRgvltO/ZKvPCS1xiJC3XLXtZtoB84wBynOzDZLoVtzUz7hi9Q22lSg6vJab5VwMRQ00RwPXT222y+Tn3ajQ52ydoFVRqW7bk5uGDRMWmckxbLz/96UbqR1d81qQvLoKt2l7zMLEV/WRNsmho02370KDP10aDkwM6DoDRRrNIkQJkyusPAhLruR4zJuL7NxIJkPkvnQIjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uua3R31Eh3MUF+NI7B1IKVk9T3cqWVN6lwX79lCki5M=;
 b=VX/gmzaE2PjCLTwmmoXdL5qYANdSZitctRRD9u01l7+pFqZ0GEYtffw1earKXEA/f1qoOr3Xf6gTSC+GmBvgtXCkciL3CqT+TnFcL8R2kIfUVGjyMHh2bE6pImYCdAgOQIhE5Yja/y1RMoxjfZH/PkzLGvWGCiNl1mHl5l1pC5j8Ae/hOsUfVERVnuLVBUMfAxmILErA8lr+5oEH7j+lqN+pdJ6Z00/7W42yUnOXeLtam2hMddnbEjT/qJ5MrWeLErJzAZGAL7aPxhtpbkEVophK0sRjNwnRFSF9sdeTDg16qDBL+nywVCr9Kv5b7tAcko496o3+D1q/Eao5CI/iAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uua3R31Eh3MUF+NI7B1IKVk9T3cqWVN6lwX79lCki5M=;
 b=jCC3i8KN/2Rsf2MS675YZb8yT/SO4/shBGWx/bIK992sGEZMdzzKKenIV8XKMEwEiNNEu3agSMQ0CbqUN14dpCYu/4Mi0Bg1WktYjYu3ozbOKadYZ4xODxB7WrEmxZCUrI9huo2R+3dTLnzUuT7H61MJs8Sy5B62RqcG5gXfD/k=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2424.namprd15.prod.outlook.com (52.135.198.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.23; Fri, 16 Aug 2019 00:05:37 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d95b:271:fa7e:e978]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d95b:271:fa7e:e978%5]) with mapi id 15.20.2157.022; Fri, 16 Aug 2019
 00:05:37 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH bpf] selftests/bpf: fix endianness issues in test_sysctl
Thread-Topic: [PATCH bpf] selftests/bpf: fix endianness issues in test_sysctl
Thread-Index: AQHVU8ZSr+W6lQSZGka9gEkiaXERSA==
Date:   Fri, 16 Aug 2019 00:05:36 +0000
Message-ID: <076513cd-fbde-cf66-ce3b-a6143878f786@fb.com>
References: <20190815122525.41073-1-iii@linux.ibm.com>
In-Reply-To: <20190815122525.41073-1-iii@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0121.namprd04.prod.outlook.com
 (2603:10b6:104:7::23) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:11f2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0c96958-d49c-409e-0581-08d721dd7709
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB2424;
x-ms-traffictypediagnostic: BYAPR15MB2424:
x-microsoft-antispam-prvs: <BYAPR15MB24249E428E41A5B05FAFE11AD3AF0@BYAPR15MB2424.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:751;
x-forefront-prvs: 0131D22242
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(39860400002)(136003)(376002)(199004)(189003)(14454004)(6486002)(66556008)(7736002)(46003)(86362001)(31696002)(256004)(14444005)(6436002)(8676002)(66946007)(229853002)(36756003)(64756008)(66476007)(478600001)(305945005)(66446008)(5660300002)(6512007)(446003)(71190400001)(316002)(186003)(476003)(53546011)(6506007)(486006)(2616005)(76176011)(4326008)(52116002)(386003)(102836004)(31686004)(81166006)(2906002)(25786009)(81156014)(8936002)(54906003)(99286004)(110136005)(53936002)(6246003)(11346002)(6116002)(71200400001)(461764006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2424;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MWK0NNb7Ddem6djomvSTD19s9hita+qECTnK5lC3b1Tji+Dm+HrbqrsHJ/9QAThZFmT410Mt6badzPGF1DwkrTZ7yqSVK877hq/YJIg3ReIKZ9jrwEJu67HOjSerzVfLId9l5VKZEUIpF27Q5qwCtF4oLoYjxDntS+oGAbKJmJAicA4T0dhvFFU+TkWCTOl/kTWox0gfRoBPDykG+TaTn46ALi740I2TKpl3DI3EIhqgCzDOZ5XJUytjON8bRQyjSSlQiNw/zeb7JVU1Y2q4rwFkehYOglPamAUNCQmPzZ6tSe6JjXK/6ABsCE+MTjP3HI6gxsaT1GoHOkPPqn/1lz8iMC5ET5zc4x8ZnC8M3n+/s3CkJiN+jdcF4q0ezSIOzGC1OJ3n7l8Qvv8EIqOv1TRqCCGy7LhrH19mYF3/XXY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5099C6C1B9C27E42836E9A1629AEB458@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c96958-d49c-409e-0581-08d721dd7709
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2019 00:05:36.8731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZKuFSuK4GB78GU/vL5DlSDr0WDlntFPrt+xSjVeYdaJxoTvaNvG3duHe5cnOLyhl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2424
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-15_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908150232
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDgvMTUvMTkgNToyNSBBTSwgSWx5YSBMZW9zaGtldmljaCB3cm90ZToNCj4gQSBsb3Qg
b2YgdGVzdF9zeXNjdGwgc3ViLXRlc3RzIGZhaWwgZHVlIHRvIGhhbmRsaW5nIHN0cmluZ3MgYXMg
YSBidW5jaA0KPiBvZiBpbW1lZGlhdGUgdmFsdWVzIGluIGEgbGl0dGxlLWVuZGlhbi1zcGVjaWZp
YyBtYW5uZXIuDQo+IA0KPiBGaXggYnkgd3JhcHBpbmcgYWxsIGltbWVkaWF0ZXMgaW4gX19icGZf
Y29uc3RhbnRfbnRvaGwsDQo+IF9fYnBmX2NvbnN0YW50X2JlNjRfdG9fY3B1IGFuZCBfX2JwZl9s
ZTY0X3RvX2NwdS4NCj4gDQo+IEZpeGVzOiAxZjVmYTlhYjZlMmUgKCJzZWxmdGVzdHMvYnBmOiBU
ZXN0IEJQRl9DR1JPVVBfU1lTQ1RMIikNCj4gRml4ZXM6IDlhMTAyN2U1MjUzNSAoInNlbGZ0ZXN0
cy9icGY6IFRlc3QgZmlsZV9wb3MgZmllbGQgaW4gYnBmX3N5c2N0bCBjdHgiKQ0KPiBGaXhlczog
NjA0MWM2N2YyOGQ4ICgic2VsZnRlc3RzL2JwZjogVGVzdCBicGZfc3lzY3RsX2dldF9uYW1lIGhl
bHBlciIpDQo+IEZpeGVzOiAxMWZmMzRmNzRlMzIgKCJzZWxmdGVzdHMvYnBmOiBUZXN0IHN5c2N0
bF9nZXRfY3VycmVudF92YWx1ZSBoZWxwZXIiKQ0KPiBGaXhlczogNzg2MDQ3ZGQwOGRlICgic2Vs
ZnRlc3RzL2JwZjogVGVzdCBicGZfc3lzY3RsX3tnZXQsc2V0fV9uZXdfdmFsdWUgaGVscGVycyIp
DQo+IEZpeGVzOiA4NTQ5ZGRjODMyZDYgKCJzZWxmdGVzdHMvYnBmOiBUZXN0IGJwZl9zdHJ0b2wg
YW5kIGJwZl9zdHJ0b3VsIGhlbHBlcnMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBJbHlhIExlb3Noa2V2
aWNoIDxpaWlAbGludXguaWJtLmNvbT4NCj4gLS0tDQo+ICAgdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvYnBmL2JwZl9lbmRpYW4uaCAgfCAgIDQgKw0KPiAgIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2JwZi90ZXN0X3N5c2N0bC5jIHwgMTIyICsrKysrKysrKysrKysrKy0tLS0tLS0NCj4gICAyIGZp
bGVzIGNoYW5nZWQsIDg2IGluc2VydGlvbnMoKyksIDQwIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9icGZfZW5kaWFuLmggYi90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvYnBmX2VuZGlhbi5oDQo+IGluZGV4IDA1ZjAzNmRmOGE0
Yy4uOTQxNzVjOTkzODA2IDEwMDY0NA0KPiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9i
cGYvYnBmX2VuZGlhbi5oDQo+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9icGZf
ZW5kaWFuLmgNCj4gQEAgLTI5LDYgKzI5LDggQEANCj4gICAjIGRlZmluZSBfX2JwZl9odG9ubCh4
KQkJCV9fYnVpbHRpbl9ic3dhcDMyKHgpDQo+ICAgIyBkZWZpbmUgX19icGZfY29uc3RhbnRfbnRv
aGwoeCkJX19fY29uc3RhbnRfc3dhYjMyKHgpDQo+ICAgIyBkZWZpbmUgX19icGZfY29uc3RhbnRf
aHRvbmwoeCkJX19fY29uc3RhbnRfc3dhYjMyKHgpDQo+ICsjIGRlZmluZSBfX2JwZl9sZTY0X3Rv
X2NwdSh4KQkNCg0KTWF5YmUgd2UgY2FuIHJlbW92ZSB0aGlzPyBTZWUgY29tbWVudHMgYmVsb3cu
DQoNCgkoeCkNCj4gKyMgZGVmaW5lIF9fYnBmX2NvbnN0YW50X2JlNjRfdG9fY3B1KHgpCV9fX2Nv
bnN0YW50X3N3YWI2NCh4KQ0KDQpicGZfZW5kaWFuLmggaXMgdXNlZCBmb3IgYm90aCBicGYgcHJv
Z3JhbSBhbmQgbmF0aXZlIGFwcGxpY2F0aW9ucy4NCkNvdWxkIHlvdSBtYWtlIHN1cmUgaXQgd29y
a3MgZm9yIGJwZiBwcm9ncmFtcz8gSXQgc2hvdWxkIGJlLCBidXQgd2FudCB0byANCmRvdWJsZSBj
aGVjay4NCg0KVGhlIF9fY29uc3RhbnRfc3dhYjY0IGxvb2tzIGxpa2UgYSBsaXR0bGUgYml0IGV4
cGVuc2l2ZQ0KZm9yIGJwZiBwcm9ncmFtcyBjb21wYXJlZCB0byBfX2J1aWx0aW5fYnN3YXA2NC4g
QnV0DQpfX2J1aWx0aW5fYnN3YXA2NCBtYXkgbm90IGJlIGF2YWlsYWJsZSBmb3IgYWxsIGFyY2hp
dGVjdHVyZXMsIGVzcC4NCjMyYml0IHN5c3RlbS4gU28gbWFjcm8gX19icGZfXyBpcyByZXF1aXJl
ZCB0byB1c2UgaXQuDQoNCkluIGFueSBjYXNlLCBicGYgcHJvZ3JhbXMgY2FuIGRpcmVjdGx5IHVz
ZSBfX2J1aWx0aW5fYnN3YXA2NCwNCnNvIEkgYW0gZmluZSB3aXRoIF9fYnBmX2NvbnN0YW50X2Jl
NjRfdG9fY3B1KCkuDQoNCg0KPiAgICNlbGlmIF9fQllURV9PUkRFUl9fID09IF9fT1JERVJfQklH
X0VORElBTl9fDQo+ICAgIyBkZWZpbmUgX19icGZfbnRvaHMoeCkJCQkoeCkNCj4gICAjIGRlZmlu
ZSBfX2JwZl9odG9ucyh4KQkJCSh4KQ0KPiBAQCAtMzgsNiArNDAsOCBAQA0KPiAgICMgZGVmaW5l
IF9fYnBmX2h0b25sKHgpCQkJKHgpDQo+ICAgIyBkZWZpbmUgX19icGZfY29uc3RhbnRfbnRvaGwo
eCkJKHgpDQo+ICAgIyBkZWZpbmUgX19icGZfY29uc3RhbnRfaHRvbmwoeCkJKHgpDQo+ICsjIGRl
ZmluZSBfX2JwZl9sZTY0X3RvX2NwdSh4KQkJX19zd2FiNjQoeCkNCj4gKyMgZGVmaW5lIF9fYnBm
X2NvbnN0YW50X2JlNjRfdG9fY3B1KHgpICAoeCkNCj4gICAjZWxzZQ0KPiAgICMgZXJyb3IgIkZp
eCB5b3VyIGNvbXBpbGVyJ3MgX19CWVRFX09SREVSX18/ISINCj4gICAjZW5kaWYNCj4gZGlmZiAt
LWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi90ZXN0X3N5c2N0bC5jIGIvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvYnBmL3Rlc3Rfc3lzY3RsLmMNCj4gaW5kZXggYTNiZWJkN2M2OGRk
Li45ZTQ5ODZiMDNlOTUgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Jw
Zi90ZXN0X3N5c2N0bC5jDQo+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi90ZXN0
X3N5c2N0bC5jDQo+IEBAIC0xMyw2ICsxMyw3IEBADQo+ICAgI2luY2x1ZGUgPGJwZi9icGYuaD4N
Cj4gICAjaW5jbHVkZSA8YnBmL2xpYmJwZi5oPg0KPiAgIA0KPiArI2luY2x1ZGUgImJwZl9lbmRp
YW4uaCINCj4gICAjaW5jbHVkZSAiYnBmX3JsaW1pdC5oIg0KPiAgICNpbmNsdWRlICJicGZfdXRp
bC5oIg0KPiAgICNpbmNsdWRlICJjZ3JvdXBfaGVscGVycy5oIg0KPiBAQCAtMTAwLDcgKzEwMSw3
IEBAIHN0YXRpYyBzdHJ1Y3Qgc3lzY3RsX3Rlc3QgdGVzdHNbXSA9IHsNCj4gICAJCS5kZXNjciA9
ICJjdHg6d3JpdGUgc3lzY3RsOndyaXRlIHJlYWQgb2siLA0KPiAgIAkJLmluc25zID0gew0KPiAg
IAkJCS8qIElmICh3cml0ZSkgKi8NCj4gLQkJCUJQRl9MRFhfTUVNKEJQRl9CLCBCUEZfUkVHXzcs
IEJQRl9SRUdfMSwNCj4gKwkJCUJQRl9MRFhfTUVNKEJQRl9XLCBCUEZfUkVHXzcsIEJQRl9SRUdf
MSwNCj4gICAJCQkJICAgIG9mZnNldG9mKHN0cnVjdCBicGZfc3lzY3RsLCB3cml0ZSkpLA0KPiAg
IAkJCUJQRl9KTVBfSU1NKEJQRl9KTkUsIEJQRl9SRUdfNywgMSwgMiksDQo+ICAgDQo+IEBAIC0y
MTQsNyArMjE1LDggQEAgc3RhdGljIHN0cnVjdCBzeXNjdGxfdGVzdCB0ZXN0c1tdID0gew0KPiAg
IAkJCS8qIGlmIChyZXQgPT0gZXhwZWN0ZWQgJiYgKi8NCj4gICAJCQlCUEZfSk1QX0lNTShCUEZf
Sk5FLCBCUEZfUkVHXzAsIHNpemVvZigidGNwX21lbSIpIC0gMSwgNiksDQo+ICAgCQkJLyogICAg
IGJ1ZiA9PSAidGNwX21lbVwwIikgKi8NCj4gLQkJCUJQRl9MRF9JTU02NChCUEZfUkVHXzgsIDB4
MDA2ZDY1NmQ1ZjcwNjM3NFVMTCksDQo+ICsJCQlCUEZfTERfSU1NNjQoQlBGX1JFR184LCBfX2Jw
Zl9jb25zdGFudF9iZTY0X3RvX2NwdSgNCj4gKwkJCQkweDc0NjM3MDVmNmQ2NTZkMDBVTEwpKSwN
Cj4gICAJCQlCUEZfTERYX01FTShCUEZfRFcsIEJQRl9SRUdfOSwgQlBGX1JFR183LCAwKSwNCj4g
ICAJCQlCUEZfSk1QX1JFRyhCUEZfSk5FLCBCUEZfUkVHXzgsIEJQRl9SRUdfOSwgMiksDQo+ICAg
DQpbLi4uLl0NCj4gICANCj4gICAJCQlCUEZfTU9WNjRfUkVHKEJQRl9SRUdfMSwgQlBGX1JFR183
KSwNCj4gQEAgLTEzNDQsMjAgKzEzNzksMjYgQEAgc3RhdGljIHNpemVfdCBwcm9iZV9wcm9nX2xl
bmd0aChjb25zdCBzdHJ1Y3QgYnBmX2luc24gKmZwKQ0KPiAgIHN0YXRpYyBpbnQgZml4dXBfc3lz
Y3RsX3ZhbHVlKGNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IGJ1Zl9sZW4sDQo+ICAgCQkJICAgICAg
c3RydWN0IGJwZl9pbnNuICpwcm9nLCBzaXplX3QgaW5zbl9udW0pDQo+ICAgew0KPiAtCXVpbnQz
Ml90IHZhbHVlX251bSA9IDA7DQo+ICsJdWludDY0X3QgdmFsdWVfbnVtID0gMDsNCj4gICAJdWlu
dDhfdCBjLCBpOw0KPiAgIA0KPiAgIAlpZiAoYnVmX2xlbiA+IHNpemVvZih2YWx1ZV9udW0pKSB7
DQo+ICAgCQlsb2dfZXJyKCJWYWx1ZSBpcyB0b28gYmlnICglemQpIHRvIHVzZSBpbiBmaXh1cCIs
IGJ1Zl9sZW4pOw0KPiAgIAkJcmV0dXJuIC0xOw0KPiAgIAl9DQo+ICsJaWYgKHByb2dbaW5zbl9u
dW1dLmNvZGUgIT0gKEJQRl9MRCB8IEJQRl9EVyB8IEJQRl9JTU0pKSB7DQo+ICsJCWxvZ19lcnIo
IkNhbiBmaXh1cCBvbmx5IEJQRl9MRF9JTU02NCBpbnNucyIpOw0KPiArCQlyZXR1cm4gLTE7DQo+
ICsJfQ0KPiAgIA0KPiAgIAlmb3IgKGkgPSAwOyBpIDwgYnVmX2xlbjsgKytpKSB7DQo+ICAgCQlj
ID0gYnVmW2ldOw0KPiAgIAkJdmFsdWVfbnVtIHw9IChjIDw8IGkgKiA4KTsNCj4gICAJfQ0KPiAr
CXZhbHVlX251bSA9IF9fYnBmX2xlNjRfdG9fY3B1KHZhbHVlX251bSk7DQoNCkNhbiB3ZSBhdm9p
ZCB0byB1c2UgX19icGZfbGU2NF90b19jcHU/DQpMb29rIGxpa2Ugd2UgYWxyZWFkeSBoYXZpbmcg
dGhlIHZhbHVlIGluIGJ1ZiwgY2FuIHdlIGp1c3QgY2FzdCBpdA0KdG8gZ2V0IHZhbHVlX251bS4g
Tm90ZSB0aGF0IGJwZiBwcm9ncmFtIGFuZCBob3N0IGFsd2F5cyBoYXZlDQp0aGUgc2FtZSBlbmRp
YW5uZXNzLiBUaGlzIHdheSwgbm8gZW5kaWFubmVzcyBjb252ZXJzaW9uDQppcyBuZWVkZWQuDQoN
Cj4gICANCj4gLQlwcm9nW2luc25fbnVtXS5pbW0gPSB2YWx1ZV9udW07DQo+ICsJcHJvZ1tpbnNu
X251bV0uaW1tID0gKF9fdTMyKXZhbHVlX251bTsNCj4gKwlwcm9nW2luc25fbnVtICsgMV0uaW1t
ID0gKF9fdTMyKSh2YWx1ZV9udW0gPj4gMzIpOw0KPiAgIA0KPiAgIAlyZXR1cm4gMDsNCj4gICB9
DQo+IEBAIC0xNDk5LDYgKzE1NDAsNyBAQCBzdGF0aWMgaW50IHJ1bl90ZXN0X2Nhc2UoaW50IGNn
ZmQsIHN0cnVjdCBzeXNjdGxfdGVzdCAqdGVzdCkNCj4gICAJCQlnb3RvIGVycjsNCj4gICAJfQ0K
PiAgIA0KPiArCWVycm5vID0gMDsNCj4gICAJaWYgKGFjY2Vzc19zeXNjdGwoc3lzY3RsX3BhdGgs
IHRlc3QpID09IC0xKSB7DQo+ICAgCQlpZiAodGVzdC0+cmVzdWx0ID09IE9QX0VQRVJNICYmIGVy
cm5vID09IEVQRVJNKQ0KPiAgIAkJCWdvdG8gb3V0Ow0KPiBAQCAtMTUwNyw3ICsxNTQ5LDcgQEAg
c3RhdGljIGludCBydW5fdGVzdF9jYXNlKGludCBjZ2ZkLCBzdHJ1Y3Qgc3lzY3RsX3Rlc3QgKnRl
c3QpDQo+ICAgCX0NCj4gICANCj4gICAJaWYgKHRlc3QtPnJlc3VsdCAhPSBTVUNDRVNTKSB7DQo+
IC0JCWxvZ19lcnIoIlVuZXhwZWN0ZWQgZmFpbHVyZSIpOw0KPiArCQlsb2dfZXJyKCJVbmV4cGVj
dGVkIHN1Y2Nlc3MiKTsNCj4gICAJCWdvdG8gZXJyOw0KPiAgIAl9DQo+ICAgDQo+IA0K
