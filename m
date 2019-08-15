Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1743F8F75A
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2019 01:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbfHOXDJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Aug 2019 19:03:09 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:16914 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729807AbfHOXDI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 15 Aug 2019 19:03:08 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7FMxS9v024551;
        Thu, 15 Aug 2019 16:02:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=F4KQpBCksQIQbceFejMEGnq80RDipKrXTB7PSqL+ZWc=;
 b=L5awIer/vOUfKbQ2Ha1foDjsC96hrbv4ktOy5UX7immIcTRQNvgoAjhw2X55zKEpmvRF
 XM5DqyuUxYi3MN7RD5WB46KmRHS/zjsEwh70vZT4Ih5kGWFR76bEXMAPnAW7a8nVqpmL
 +mX8Q6qD9v/EajstfYzT0nN1wbrEs2vTI+8= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2udehmgnwc-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 15 Aug 2019 16:02:42 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 15 Aug 2019 16:01:58 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 15 Aug 2019 16:01:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDxYnUatZg8p+EqDV62BtwId7JKYVvI+FsqtuvHCmDo1aYoiMNe1oHwq1Jlw9PYXsTuzv51MS1AgFFrtlOR/ij2D97FLv3qWQlRMSBxumEdo8IrCyp17tLXc23a2S6a29EnyZsU+rHcB90I2AA1IUIdnWTwK3udqjjzw4NHub8ROrbP18gXb7DZESLPrSYzzC/5QAGYafjxGE+8c3ohrhtBGECQJRD8Jyq6M3orIX8fdbEvsdIaugf+QB9EDFzGm2a7F0z5Pk8hql2LDvciSGJToIvcO84CHKBwafTRMMYN7Ed+DKFyo+0k646Dr1PtV1AZHNAHOvsXOuj/0RpA+TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4KQpBCksQIQbceFejMEGnq80RDipKrXTB7PSqL+ZWc=;
 b=l8VBQv+X2lVxofZtbx41qjPAZEY1ko3BxbcXMx2e5KR+cKRdKqr8MH3dHyAP/Bc5q8amI3zeR2h+SL2M8SaMrg53Tjkv5jnKfiG/y6859fEvHXUP16JS2Wwm5y8KE9djdrUaEi2LZITx8ZeU8mWgdrHfai/h87alArypzIQevF1BsI2fdYjNH5GP0v4ZBZ1enHR7qc8uaRzsJp2WlLzoRtBzK2afdm3S8KPXebLoVZn/pmyIt1Ymji/Fpv9f9tpzW0NqvcY8QnXMmJ51BaE0RPLkf0PAoTCJra7RFaHRgeT3eePo5+SCJyEFZgR7sLOmGYha2HRRWdlAByLlIe6qGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4KQpBCksQIQbceFejMEGnq80RDipKrXTB7PSqL+ZWc=;
 b=eakNAU96X6Ht5Mhs19Kfku0KMD9uwTnxoTcXjjGpuRcB9KN7DoDWs/Pb1u8Q/D0udo0bRlanNC4AOEE+LA2rL1/evnT2a4zy6WykRhYE3YRhHpcCmxGsDCq7BPob8e8qm6dmZYgMKDO4Lusg+zGTSR5or0BbGJBodfssooxzkVY=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2439.namprd15.prod.outlook.com (52.135.198.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 15 Aug 2019 23:01:44 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d95b:271:fa7e:e978]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d95b:271:fa7e:e978%5]) with mapi id 15.20.2157.022; Thu, 15 Aug 2019
 23:01:44 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH bpf] bpf: fix accessing bpf_sysctl.file_pos on s390
Thread-Topic: [PATCH bpf] bpf: fix accessing bpf_sysctl.file_pos on s390
Thread-Index: AQHVU71n3te8c0S7PE+oXZhbnTVdFA==
Date:   Thu, 15 Aug 2019 23:01:44 +0000
Message-ID: <515ad8ab-9ded-5573-b2c5-37ee9c23dd6e@fb.com>
References: <20190815112044.38420-1-iii@linux.ibm.com>
In-Reply-To: <20190815112044.38420-1-iii@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0070.namprd07.prod.outlook.com
 (2603:10b6:a03:60::47) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:11f2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7aaae24c-1d77-4aaa-5a03-08d721d48aaa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR15MB2439;
x-ms-traffictypediagnostic: BYAPR15MB2439:
x-microsoft-antispam-prvs: <BYAPR15MB2439DC0779E728F14F1FAE62D3AC0@BYAPR15MB2439.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 01304918F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(376002)(39860400002)(366004)(189003)(199004)(5660300002)(81156014)(8936002)(8676002)(81166006)(229853002)(86362001)(14454004)(54906003)(99286004)(110136005)(186003)(53546011)(386003)(11346002)(31696002)(478600001)(6506007)(102836004)(52116002)(76176011)(46003)(446003)(486006)(476003)(2616005)(31686004)(316002)(4326008)(6116002)(256004)(5024004)(6512007)(2906002)(25786009)(6436002)(14444005)(66556008)(64756008)(6246003)(6486002)(66446008)(53936002)(66476007)(66946007)(36756003)(71190400001)(7736002)(305945005)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2439;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CLo1YbavxiX0Oe50rcJQMpM0CJi6+FQY99lZHoqBmNeQGjRMXxkACczyMSuVOGJI4rPjfqMUd6c5t5xnQZIacWAki74OH/gP2CPc8pUO9++xZWlbuNUO10Q+u7pdi1CMODBJC3uE+4g7aKDXem3AwMYwWq2NLo3tZlKxU8V/Vf5lkY8Qkbf0ZhdK//aEO06o6hfmbbyX/hNMaPDP6J+WPDZN8GMVa/FfqIzMq1SiwChW79wnNCcDlzAFyZBH5KsmttCLkdA4+z9bw8SqH6A2xdbtUv8G1bsnv26xrw6xUJitXkW3NqM6f3td+ArPvxYeAuyZbEYblGUe/4Oc21GnUyV22qpie1/9++3LTOU8S6MTmmlA8i0zYLZpeiJEL2QKXj9nDTFAnDbJ3dKWzt7Yf/2wmRkj/ck6fOchGWEoDGg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDDF7C7688776747A09F775B809986DE@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aaae24c-1d77-4aaa-5a03-08d721d48aaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2019 23:01:44.1256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NepxO9HoO+p2S1SvJjdoBCk0lRFXHp/H9+OO1uTN807dukT3uDPc0TErGgmCh7Bv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2439
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-15_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908150219
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDgvMTUvMTkgNDoyMCBBTSwgSWx5YSBMZW9zaGtldmljaCB3cm90ZToNCj4gImN0eDpm
aWxlX3BvcyBzeXNjdGw6cmVhZCB3cml0ZSBvayIgZmFpbHMgb24gczM5MCB3aXRoICJSZWFkIHZh
bHVlICAhPQ0KPiBudXgiLiBUaGlzIGlzIGJlY2F1c2UgdmVyaWZpZXIgcmV3cml0ZXMgYSBjb21w
bGV0ZSAzMi1iaXQNCj4gYnBmX3N5c2N0bC5maWxlX3BvcyB1cGRhdGUgdG8gYSBwYXJ0aWFsIHVw
ZGF0ZSBvZiB0aGUgZmlyc3QgMzIgYml0cyBvZg0KPiA2NC1iaXQgKmJwZl9zeXNjdGxfa2Vybi5w
cG9zLCB3aGljaCBpcyBub3QgY29ycmVjdCBvbiBiaWctZW5kaWFuDQo+IHN5c3RlbXMuDQo+IA0K
PiBGaXggYnkgdXNpbmcgYW4gb2Zmc2V0IG9uIGJpZy1lbmRpYW4gc3lzdGVtcy4NCj4gDQo+IERp
dHRvIGZvciBicGZfc3lzY3RsLmZpbGVfcG9zIHJlYWRzLiBDdXJyZW50bHkgdGhlIHRlc3QgZG9l
cyBub3QgZGV0ZWN0DQo+IGEgcHJvYmxlbSB0aGVyZSwgc2luY2UgaXQgZXhwZWN0cyB0byBzZWUg
MCwgd2hpY2ggaXQgZ2V0cyB3aXRoIGhpZ2gNCj4gcHJvYmFiaWxpdHkgaW4gZXJyb3IgY2FzZXMs
IHNvIGNoYW5nZSBpdCB0byBzZWVrIHRvIG9mZnNldCAzIGFuZCBleHBlY3QNCj4gMyBpbiBicGZf
c3lzY3RsLmZpbGVfcG9zLg0KPiANCj4gRml4ZXM6IGUxNTUwYmZlMGRlNCAoImJwZjogQWRkIGZp
bGVfcG9zIGZpZWxkIHRvIGJwZl9zeXNjdGwgY3R4IikNCj4gU2lnbmVkLW9mZi1ieTogSWx5YSBM
ZW9zaGtldmljaCA8aWlpQGxpbnV4LmlibS5jb20+DQo+IC0tLQ0KPiAgIGluY2x1ZGUvbGludXgv
ZmlsdGVyLmggICAgICAgICAgICAgICAgICAgIHwgMTAgKysrKysrKysrKw0KPiAgIGtlcm5lbC9i
cGYvY2dyb3VwLmMgICAgICAgICAgICAgICAgICAgICAgIHwgIDkgKysrKysrKy0tDQo+ICAgdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Rlc3Rfc3lzY3RsLmMgfCAgOSArKysrKysrKy0NCj4g
ICAzIGZpbGVzIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9maWx0ZXIuaCBiL2luY2x1ZGUvbGludXgvZmls
dGVyLmgNCj4gaW5kZXggOTJjNmUzMWZiMDA4Li45NGU4MWM1NmQ4MWMgMTAwNjQ0DQo+IC0tLSBh
L2luY2x1ZGUvbGludXgvZmlsdGVyLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9maWx0ZXIuaA0K
PiBAQCAtNzYwLDYgKzc2MCwxNiBAQCBicGZfY3R4X25hcnJvd19sb2FkX3NoaWZ0KHUzMiBvZmYs
IHUzMiBzaXplLCB1MzIgc2l6ZV9kZWZhdWx0KQ0KPiAgICNlbmRpZg0KPiAgIH0NCj4gICANCj4g
K3N0YXRpYyBpbmxpbmUgczE2DQo+ICticGZfY3R4X25hcnJvd19hY2Nlc3Nfb2Zmc2V0KHNpemVf
dCB2YXJpYWJsZV9zaXplLCBzaXplX3QgYWNjZXNzX3NpemUpDQo+ICt7DQo+ICsjaWZkZWYgX19M
SVRUTEVfRU5ESUFODQo+ICsJcmV0dXJuIDA7DQo+ICsjZWxzZQ0KPiArCXJldHVybiB2YXJpYWJs
ZV9zaXplIC0gYWNjZXNzX3NpemU7DQo+ICsjZW5kaWYNCj4gK30NCg0KVGhlIGNoYW5nZSBsb29r
cyBjb3JyZWN0IHRvIG1lLg0KQnV0IG5vdyBpbiBpbmNsdWRlL2xpbnV4L2ZpbHRlci5oIHdlIGhh
dmUgdG8gbWFjcm9zOg0KDQpzdGF0aWMgaW5saW5lIHU4DQpicGZfY3R4X25hcnJvd19sb2FkX3No
aWZ0KHUzMiBvZmYsIHUzMiBzaXplLCB1MzIgc2l6ZV9kZWZhdWx0KQ0Kew0KICAgICAgICAgdTgg
bG9hZF9vZmYgPSBvZmYgJiAoc2l6ZV9kZWZhdWx0IC0gMSk7DQoNCiNpZmRlZiBfX0xJVFRMRV9F
TkRJQU4NCiAgICAgICAgIHJldHVybiBsb2FkX29mZiAqIDg7DQojZWxzZQ0KICAgICAgICAgcmV0
dXJuIChzaXplX2RlZmF1bHQgLSAobG9hZF9vZmYgKyBzaXplKSkgKiA4Ow0KI2VuZGlmDQp9DQoN
CnN0YXRpYyBpbmxpbmUgczE2DQpicGZfY3R4X25hcnJvd19hY2Nlc3Nfb2Zmc2V0KHNpemVfdCB2
YXJpYWJsZV9zaXplLCBzaXplX3QgYWNjZXNzX3NpemUpDQp7DQojaWZkZWYgX19MSVRUTEVfRU5E
SUFODQogICAgICAgICByZXR1cm4gMDsNCiNlbHNlDQogICAgICAgICByZXR1cm4gdmFyaWFibGVf
c2l6ZSAtIGFjY2Vzc19zaXplOw0KI2VuZGlmDQp9DQoNCkl0IHdvdWxkIGJlIGdvb2QgaWYgd2Ug
Y2FuIGhhdmUgaWZkZWYgX19MSVRUTEVfRU5ESUFOIG9ubHkgaW4gb25lIHBsYWNlLg0KSG93IGFi
b3V0IHNvbWV0aGluZyBsaWtlIGJlbG93Og0KDQpzdGF0aWMgaW5saW5lIHU4DQpicGZfY3R4X25h
cnJvd19hY2Nlc3Nfb2Zmc2V0KHUzMiBvZmYsIHUzMiBzaXplLCB1MzIgc2l6ZV9kZWZhdWx0KQ0K
ew0KICAgICAgICAgdTggYWNjZXNzX29mZiA9IG9mZiAmIChzaXplX2RlZmF1bHQgLSAxKTsNCg0K
I2lmZGVmIF9fTElUVExFX0VORElBTg0KICAgICAgICAgcmV0dXJuIGFjY2Vzc19vZmY7DQojZWxz
ZQ0KICAgICAgICAgcmV0dXJuIHNpemVfZGVmYXVsdCAtIChhY2Nlc3Nfb2ZmICsgc2l6ZSk7DQoj
ZW5kaWYNCn0NCg0Kc3RhdGljIGlubGluZSB1OA0KYnBmX2N0eF9uYXJyb3dfbG9hZF9zaGlmdCh1
MzIgb2ZmLCB1MzIgc2l6ZSwgdTMyIHNpemVfZGVmYXVsdCkNCnsNCiAgICAgICAgIHJldHVybiBi
cGZfY3R4X25hcnJvd19hY2Nlc3Nfb2Zmc2V0KG9mZiwgc2l6ZSwgc2l6ZV9kZWZhdWx0KSAqIDg7
DQp9DQoNCj4gKw0KPiAgICNkZWZpbmUgYnBmX2N0eF93aWRlX2FjY2Vzc19vayhvZmYsIHNpemUs
IHR5cGUsIGZpZWxkKQkJCVwNCj4gICAJKHNpemUgPT0gc2l6ZW9mKF9fdTY0KSAmJgkJCQkJXA0K
PiAgIAlvZmYgPj0gb2Zmc2V0b2YodHlwZSwgZmllbGQpICYmCQkJCQlcDQo+IGRpZmYgLS1naXQg
YS9rZXJuZWwvYnBmL2Nncm91cC5jIGIva2VybmVsL2JwZi9jZ3JvdXAuYw0KPiBpbmRleCAwYTAw
ZWFjYTZmYWUuLmI4MzVmYmIxM2VhOCAxMDA2NDQNCj4gLS0tIGEva2VybmVsL2JwZi9jZ3JvdXAu
Yw0KPiArKysgYi9rZXJuZWwvYnBmL2Nncm91cC5jDQo+IEBAIC0xMzU2LDcgKzEzNTYsOSBAQCBz
dGF0aWMgdTMyIHN5c2N0bF9jb252ZXJ0X2N0eF9hY2Nlc3MoZW51bSBicGZfYWNjZXNzX3R5cGUg
dHlwZSwNCj4gICAJCQkJdHJlZywgc2ktPmRzdF9yZWcsDQo+ICAgCQkJCW9mZnNldG9mKHN0cnVj
dCBicGZfc3lzY3RsX2tlcm4sIHBwb3MpKTsNCj4gICAJCQkqaW5zbisrID0gQlBGX1NUWF9NRU0o
DQo+IC0JCQkJQlBGX1NJWkVPRih1MzIpLCB0cmVnLCBzaS0+c3JjX3JlZywgMCk7DQo+ICsJCQkJ
QlBGX1NJWkVPRih1MzIpLCB0cmVnLCBzaS0+c3JjX3JlZywNCj4gKwkJCQlicGZfY3R4X25hcnJv
d19hY2Nlc3Nfb2Zmc2V0KA0KPiArCQkJCQlzaXplb2YobG9mZl90KSwgc2l6ZW9mKHUzMikpKTsN
Cj4gICAJCQkqaW5zbisrID0gQlBGX0xEWF9NRU0oDQo+ICAgCQkJCUJQRl9EVywgdHJlZywgc2kt
PmRzdF9yZWcsDQo+ICAgCQkJCW9mZnNldG9mKHN0cnVjdCBicGZfc3lzY3RsX2tlcm4sIHRtcF9y
ZWcpKTsNCj4gQEAgLTEzNjYsNyArMTM2OCwxMCBAQCBzdGF0aWMgdTMyIHN5c2N0bF9jb252ZXJ0
X2N0eF9hY2Nlc3MoZW51bSBicGZfYWNjZXNzX3R5cGUgdHlwZSwNCj4gICAJCQkJc2ktPmRzdF9y
ZWcsIHNpLT5zcmNfcmVnLA0KPiAgIAkJCQlvZmZzZXRvZihzdHJ1Y3QgYnBmX3N5c2N0bF9rZXJu
LCBwcG9zKSk7DQo+ICAgCQkJKmluc24rKyA9IEJQRl9MRFhfTUVNKA0KPiAtCQkJCUJQRl9TSVpF
KHNpLT5jb2RlKSwgc2ktPmRzdF9yZWcsIHNpLT5kc3RfcmVnLCAwKTsNCj4gKwkJCQlCUEZfU0la
RShzaS0+Y29kZSksIHNpLT5kc3RfcmVnLCBzaS0+ZHN0X3JlZywNCj4gKwkJCQlicGZfY3R4X25h
cnJvd19hY2Nlc3Nfb2Zmc2V0KA0KPiArCQkJCQlzaXplb2YobG9mZl90KSwNCj4gKwkJCQkJYnBm
X3NpemVfdG9fYnl0ZXMoQlBGX1NJWkUoc2ktPmNvZGUpKSkpOw0KPiAgIAkJfQ0KPiAgIAkJKnRh
cmdldF9zaXplID0gc2l6ZW9mKHUzMik7DQo+ICAgCQlicmVhazsNCj4gZGlmZiAtLWdpdCBhL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi90ZXN0X3N5c2N0bC5jIGIvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvYnBmL3Rlc3Rfc3lzY3RsLmMNCj4gaW5kZXggYTNiZWJkN2M2OGRkLi5hYmMyNjI0
OGE3ZjEgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi90ZXN0X3N5
c2N0bC5jDQo+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi90ZXN0X3N5c2N0bC5j
DQo+IEBAIC0zMSw2ICszMSw3IEBAIHN0cnVjdCBzeXNjdGxfdGVzdCB7DQo+ICAgCWVudW0gYnBm
X2F0dGFjaF90eXBlIGF0dGFjaF90eXBlOw0KPiAgIAljb25zdCBjaGFyICpzeXNjdGw7DQo+ICAg
CWludCBvcGVuX2ZsYWdzOw0KPiArCWludCBzZWVrOw0KPiAgIAljb25zdCBjaGFyICpuZXd2YWw7
DQo+ICAgCWNvbnN0IGNoYXIgKm9sZHZhbDsNCj4gICAJZW51bSB7DQo+IEBAIC0xMzksNyArMTQw
LDcgQEAgc3RhdGljIHN0cnVjdCBzeXNjdGxfdGVzdCB0ZXN0c1tdID0gew0KPiAgIAkJCS8qIElm
IChmaWxlX3BvcyA9PSBYKSAqLw0KPiAgIAkJCUJQRl9MRFhfTUVNKEJQRl9XLCBCUEZfUkVHXzcs
IEJQRl9SRUdfMSwNCj4gICAJCQkJICAgIG9mZnNldG9mKHN0cnVjdCBicGZfc3lzY3RsLCBmaWxl
X3BvcykpLA0KPiAtCQkJQlBGX0pNUF9JTU0oQlBGX0pORSwgQlBGX1JFR183LCAwLCAyKSwNCj4g
KwkJCUJQRl9KTVBfSU1NKEJQRl9KTkUsIEJQRl9SRUdfNywgMywgMiksDQo+ICAgDQo+ICAgCQkJ
LyogcmV0dXJuIEFMTE9XOyAqLw0KPiAgIAkJCUJQRl9NT1Y2NF9JTU0oQlBGX1JFR18wLCAxKSwN
Cj4gQEAgLTE1Miw2ICsxNTMsNyBAQCBzdGF0aWMgc3RydWN0IHN5c2N0bF90ZXN0IHRlc3RzW10g
PSB7DQo+ICAgCQkuYXR0YWNoX3R5cGUgPSBCUEZfQ0dST1VQX1NZU0NUTCwNCj4gICAJCS5zeXNj
dGwgPSAia2VybmVsL29zdHlwZSIsDQo+ICAgCQkub3Blbl9mbGFncyA9IE9fUkRPTkxZLA0KPiAr
CQkuc2VlayA9IDMsDQo+ICAgCQkucmVzdWx0ID0gU1VDQ0VTUywNCj4gICAJfSwNCj4gICAJew0K
PiBAQCAtMTQ0Miw2ICsxNDQ0LDExIEBAIHN0YXRpYyBpbnQgYWNjZXNzX3N5c2N0bChjb25zdCBj
aGFyICpzeXNjdGxfcGF0aCwNCj4gICAJaWYgKGZkIDwgMCkNCj4gICAJCXJldHVybiBmZDsNCj4g
ICANCj4gKwlpZiAodGVzdC0+c2VlayAmJiBsc2VlayhmZCwgdGVzdC0+c2VlaywgU0VFS19TRVQp
ID09IC0xKSB7DQo+ICsJCWxvZ19lcnIoImxzZWVrKCVkKSBmYWlsZWQiLCB0ZXN0LT5zZWVrKTsN
Cj4gKwkJZ290byBlcnI7DQo+ICsJfQ0KPiArDQo+ICAgCWlmICh0ZXN0LT5vcGVuX2ZsYWdzID09
IE9fUkRPTkxZKSB7DQo+ICAgCQljaGFyIGJ1ZlsxMjhdOw0KPiAgIA0KPiANCg==
