Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33F548443E
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2019 08:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfHGGGb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Aug 2019 02:06:31 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52194 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726511AbfHGGGb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Aug 2019 02:06:31 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7764DdS005100;
        Tue, 6 Aug 2019 23:06:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ElaqlpAr9zMOUu8J2SVrZxGwmiawRlKWXZ0xt9jwGxs=;
 b=LvprPJ6VIBk+SASflKH58uLzfzyBrTzpHb47y0kOjuelMnDOGv1Cr2K9H4oDoh2nSx89
 UKfDsX5trkgWHWK0LJC8LZpnosp0CoWCguo4cRQ3tvytWQvpVQR1/qoQhKqVgW0mTHm9
 vU2PXmg7n2/8YrKn8sYaKN/Kdt6sgV0yHZs= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2u7g3g9nf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 06 Aug 2019 23:06:25 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 6 Aug 2019 23:06:24 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 6 Aug 2019 23:06:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ND7W37h5FErk43PNuIa+p7lcKyXDrmUAWk8SJe6L9KA8V8rEXRUMUrUP+j294x4AixZ2PQKGNMuHb+7sPZGeIhUHoP3LQonF4KpGcOezmH15Pghll84J+Dc/0KWLjKBA4nDnoQxQTOCmDirz0J6wmKc9+gzhE3rA4suFLkpyC79Olz6YDovRxRgKoTYBxQd0q3OazaAp661U7EFDAWqB1lxX8btBYKgsqn0m7meS2XLiwDC56C/8fbhEf/7o7Pw3kSQYf60wrco7pQTmaq/8Sx+NmokbNbc4MZekaRDsoDkl1+enrEoYG+VoatKWc6s2iPh+0iEhS2oq7K/+eCf3Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElaqlpAr9zMOUu8J2SVrZxGwmiawRlKWXZ0xt9jwGxs=;
 b=inxntj8rj/9fjEbtF1nfVip/sFNMbd0wmM6agLXYifvGu630meari6Tneffd9UtYvtioJp/cC/kzUDcvT0ZgjTzClBNuDnYBXshpd61HrUf7xsqGITeasWV8gEdX2InnDj19rZrVNEZsymS/YuWfVWViiAJeiJJLBYhsbUytYgbIu09Hm/hwgFMI1qC2TRV2orDXhrsIlHwD/nCRWnlMRIBfyAyuFMAcZSA2R028Fb0BCs/pDlFDcEgMFqEGDr4HUnlm/WSiajvb3FO/XQOZIvq2JDes67gnlmsJ1P0r/ww3mKvjMIucFcK7qvs38p7XmFupvN/Nb2cySXZAr+dLfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElaqlpAr9zMOUu8J2SVrZxGwmiawRlKWXZ0xt9jwGxs=;
 b=P2lRvxJqqziMElfU2o0Ld0FoeOSaBge6hrgxLdhH5Bi+pr6Ckr+IJHYKjM6B4RyyubFtXP8YLJ4DnSFnPUKhGBo6aHm2xJLB2oCu+hHbGvzEMzlD9JBp+8TIlIQWYFGW56jbIScCaYhw4rlsyYrGDfXBWHegC/jzwH1mvz9KuFg=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2550.namprd15.prod.outlook.com (20.179.155.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.13; Wed, 7 Aug 2019 06:06:22 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::e499:ecba:ec04:abac]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::e499:ecba:ec04:abac%5]) with mapi id 15.20.2136.018; Wed, 7 Aug 2019
 06:06:22 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Daniel Xu <dxu@dxuuu.xyz>, Song Liu <songliubraving@fb.com>,
        "Andrii Nakryiko" <andriin@fb.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 1/3] tracing/kprobe: Add PERF_EVENT_IOC_QUERY_KPROBE ioctl
Thread-Topic: [PATCH 1/3] tracing/kprobe: Add PERF_EVENT_IOC_QUERY_KPROBE
 ioctl
Thread-Index: AQHVTLCaA23KAPLzH0qY+4wWGfc8J6bvMxMA
Date:   Wed, 7 Aug 2019 06:06:21 +0000
Message-ID: <8e7749b8-f537-7164-dc85-9a67fe88bba2@fb.com>
References: <20190806234131.5655-1-dxu@dxuuu.xyz>
In-Reply-To: <20190806234131.5655-1-dxu@dxuuu.xyz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::21) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1dec]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e4267db-bc1c-44f4-a264-08d71afd5ee7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB2550;
x-ms-traffictypediagnostic: BYAPR15MB2550:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB255054F8C4F9857D3546DB94D3D40@BYAPR15MB2550.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(376002)(366004)(396003)(346002)(199004)(189003)(86362001)(486006)(52116002)(31696002)(81156014)(81166006)(7736002)(14454004)(476003)(25786009)(256004)(5024004)(11346002)(14444005)(2616005)(229853002)(99286004)(6486002)(53936002)(2906002)(305945005)(46003)(446003)(36756003)(6436002)(68736007)(102836004)(31686004)(6506007)(53546011)(386003)(5660300002)(6512007)(478600001)(186003)(8676002)(6246003)(6636002)(76176011)(66556008)(64756008)(66446008)(316002)(66946007)(71200400001)(71190400001)(110136005)(54906003)(4326008)(8936002)(66476007)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2550;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ek0W85K02EYVslPIiZMdOemkI8sF5GCLAyKvLFM+Ns3h1I+FHB9EQ+thizkRnZfakvOor/Vg/FVKBJBnRriKML7sw36VlNbjbFY9wWEJF6eXnarCP+oMXDl+nvuh0xBgfAbMaSkiA+NnI59iSkFQjK5U/mo3rRxKHLK9WqeAo/ZHLVfh+xXxmVHX4H7B37c/eIS+/Xrt2LSImvTk0kJGe8LB4lZ4lcfMdkr7uJ6kCh642v9M92cKPxzblTDK4CurteuDZSKUsz9D+FRP+9495JdwOpKKbOchLqLmI2t8qcFbEXsVUZd8RXc4Gxq300XH793lBClMhmI4wKYwT8bik5cMk4GRLfOdKfuduDLMRT6cighJjwKLjuImKmgo8VN7ZJH1E09PbIh/yuUNqNbmQdVZ3jfuc6Yi0xZwRCajafk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C619334950DED448BAD0AE361825A34@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e4267db-bc1c-44f4-a264-08d71afd5ee7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 06:06:21.9530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yhs@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2550
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-07_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908070066
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDgvNi8xOSA0OjQxIFBNLCBEYW5pZWwgWHUgd3JvdGU6DQo+IEl0J3MgdXNlZnVsIHRv
IGtub3cga3Byb2JlJ3Mgbm1pc3NlZCBhbmQgbmhpdCBzdGF0cy4gRm9yIGV4YW1wbGUgd2l0aA0K
PiB0cmFjaW5nIHRvb2xzLCBpdCdzIGltcG9ydGFudCB0byBrbm93IHdoZW4gZXZlbnRzIG1heSBo
YXZlIGJlZW4gbG9zdC4NCj4gVGhlcmUgaXMgY3VycmVudGx5IG5vIHdheSB0byBnZXQgdGhhdCBp
bmZvcm1hdGlvbiBmcm9tIHRoZSBwZXJmIEFQSS4NCj4gVGhpcyBwYXRjaCBhZGRzIGEgbmV3IGlv
Y3RsIHRoYXQgbGV0cyB1c2VycyBxdWVyeSB0aGlzIGluZm9ybWF0aW9uLg0KPiAtLS0NCj4gICBp
bmNsdWRlL2xpbnV4L3RyYWNlX2V2ZW50cy5oICAgIHwgIDYgKysrKysrDQo+ICAgaW5jbHVkZS91
YXBpL2xpbnV4L3BlcmZfZXZlbnQuaCB8IDIzICsrKysrKysrKysrKysrKysrKysrKysrDQo+ICAg
a2VybmVsL2V2ZW50cy9jb3JlLmMgICAgICAgICAgICB8IDExICsrKysrKysrKysrDQo+ICAga2Vy
bmVsL3RyYWNlL3RyYWNlX2twcm9iZS5jICAgICB8IDI1ICsrKysrKysrKysrKysrKysrKysrKysr
KysNCj4gICA0IGZpbGVzIGNoYW5nZWQsIDY1IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L3RyYWNlX2V2ZW50cy5oIGIvaW5jbHVkZS9saW51eC90cmFjZV9l
dmVudHMuaA0KPiBpbmRleCA1MTUwNDM2NzgzZTguLjI4ZmFmMTE1ZTBiOCAxMDA2NDQNCj4gLS0t
IGEvaW5jbHVkZS9saW51eC90cmFjZV9ldmVudHMuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L3Ry
YWNlX2V2ZW50cy5oDQo+IEBAIC01ODYsNiArNTg2LDEyIEBAIGV4dGVybiBpbnQgYnBmX2dldF9r
cHJvYmVfaW5mbyhjb25zdCBzdHJ1Y3QgcGVyZl9ldmVudCAqZXZlbnQsDQo+ICAgCQkJICAgICAg
IHUzMiAqZmRfdHlwZSwgY29uc3QgY2hhciAqKnN5bWJvbCwNCj4gICAJCQkgICAgICAgdTY0ICpw
cm9iZV9vZmZzZXQsIHU2NCAqcHJvYmVfYWRkciwNCj4gICAJCQkgICAgICAgYm9vbCBwZXJmX3R5
cGVfdHJhY2Vwb2ludCk7DQo+ICtleHRlcm4gaW50IHBlcmZfZXZlbnRfcXVlcnlfa3Byb2JlKHN0
cnVjdCBwZXJmX2V2ZW50ICpldmVudCwgdm9pZCBfX3VzZXIgKmluZm8pOw0KPiArI2Vsc2UNCj4g
K2ludCBwZXJmX2V2ZW50X3F1ZXJ5X2twcm9iZShzdHJ1Y3QgcGVyZl9ldmVudCAqZXZlbnQsIHZv
aWQgX191c2VyICppbmZvKQ0KPiArew0KPiArCXJldHVybiAtRU9QTk9UU1VQUDsNCj4gK30NCj4g
ICAjZW5kaWYNCj4gICAjaWZkZWYgQ09ORklHX1VQUk9CRV9FVkVOVFMNCj4gICBleHRlcm4gaW50
ICBwZXJmX3Vwcm9iZV9pbml0KHN0cnVjdCBwZXJmX2V2ZW50ICpldmVudCwNCj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvdWFwaS9saW51eC9wZXJmX2V2ZW50LmggYi9pbmNsdWRlL3VhcGkvbGludXgv
cGVyZl9ldmVudC5oDQo+IGluZGV4IDcxOThkZGQwYzZiMS4uNGE1ZTE4NjA2YmFmIDEwMDY0NA0K
PiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvcGVyZl9ldmVudC5oDQo+ICsrKyBiL2luY2x1ZGUv
dWFwaS9saW51eC9wZXJmX2V2ZW50LmgNCj4gQEAgLTQ0Nyw2ICs0NDcsMjggQEAgc3RydWN0IHBl
cmZfZXZlbnRfcXVlcnlfYnBmIHsNCj4gICAJX191MzIJaWRzWzBdOw0KPiAgIH07DQo+ICAgDQo+
ICsvKg0KPiArICogU3RydWN0dXJlIHVzZWQgYnkgYmVsb3cgUEVSRl9FVkVOVF9JT0NfUVVFUllf
S1BST0UgY29tbWFuZA0KPiArICogdG8gcXVlcnkgaW5mb3JtYXRpb24gYWJvdXQgdGhlIGtwcm9i
ZSBhdHRhY2hlZCB0byB0aGUgcGVyZg0KPiArICogZXZlbnQuDQo+ICsgKi8NCj4gK3N0cnVjdCBw
ZXJmX2V2ZW50X3F1ZXJ5X2twcm9iZSB7DQo+ICsgICAgICAgLyoNCj4gKyAgICAgICAgKiBTaXpl
IG9mIHN0cnVjdHVyZSBmb3IgZm9yd2FyZC9iYWNrd2FyZCBjb21wYXRpYmlsaXR5DQo+ICsgICAg
ICAgICovDQo+ICsgICAgICAgX191MzIgICBzaXplOw0KPiArICAgICAgIC8qDQo+ICsgICAgICAg
ICogU2V0IGJ5IHRoZSBrZXJuZWwgdG8gaW5kaWNhdGUgbnVtYmVyIG9mIHRpbWVzIHRoaXMga3By
b2JlDQo+ICsgICAgICAgICogd2FzIHRlbXBvcmFyaWx5IGRpc2FibGVkDQo+ICsgICAgICAgICov
DQo+ICsgICAgICAgX191NjQgICBubWlzc2VkOw0KPiArICAgICAgIC8qDQo+ICsgICAgICAgICog
U2V0IGJ5IHRoZSBrZXJuZWwgdG8gaW5kaWNhdGUgbnVtYmVyIG9mIHRpbWVzIHRoaXMga3Byb2Jl
DQo+ICsgICAgICAgICogd2FzIGhpdA0KPiArICAgICAgICAqLw0KPiArICAgICAgIF9fdTY0ICAg
bmhpdDsNCj4gK307DQo+ICsNCj4gICAvKg0KPiAgICAqIElvY3RscyB0aGF0IGNhbiBiZSBkb25l
IG9uIGEgcGVyZiBldmVudCBmZDoNCj4gICAgKi8NCj4gQEAgLTQ2Miw2ICs0ODQsNyBAQCBzdHJ1
Y3QgcGVyZl9ldmVudF9xdWVyeV9icGYgew0KPiAgICNkZWZpbmUgUEVSRl9FVkVOVF9JT0NfUEFV
U0VfT1VUUFVUCQlfSU9XKCckJywgOSwgX191MzIpDQo+ICAgI2RlZmluZSBQRVJGX0VWRU5UX0lP
Q19RVUVSWV9CUEYJCV9JT1dSKCckJywgMTAsIHN0cnVjdCBwZXJmX2V2ZW50X3F1ZXJ5X2JwZiAq
KQ0KPiAgICNkZWZpbmUgUEVSRl9FVkVOVF9JT0NfTU9ESUZZX0FUVFJJQlVURVMJX0lPVygnJCcs
IDExLCBzdHJ1Y3QgcGVyZl9ldmVudF9hdHRyICopDQo+ICsjZGVmaW5lIFBFUkZfRVZFTlRfSU9D
X1FVRVJZX0tQUk9CRQkJX0lPV1IoJyQnLCAxMiwgc3RydWN0IHBlcmZfZXZlbnRfcXVlcnlfa3By
b2JlICopDQo+ICAgDQo+ICAgZW51bSBwZXJmX2V2ZW50X2lvY19mbGFncyB7DQo+ICAgCVBFUkZf
SU9DX0ZMQUdfR1JPVVAJCT0gMVUgPDwgMCwNCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9ldmVudHMv
Y29yZS5jIGIva2VybmVsL2V2ZW50cy9jb3JlLmMNCj4gaW5kZXggMDI2YTE0NTQxYTM4Li5kNjFj
M2FjNWRhNGYgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9ldmVudHMvY29yZS5jDQo+ICsrKyBiL2tl
cm5lbC9ldmVudHMvY29yZS5jDQo+IEBAIC01MDYxLDYgKzUwNjEsMTAgQEAgc3RhdGljIGludCBw
ZXJmX2V2ZW50X3NldF9icGZfcHJvZyhzdHJ1Y3QgcGVyZl9ldmVudCAqZXZlbnQsIHUzMiBwcm9n
X2ZkKTsNCj4gICBzdGF0aWMgaW50IHBlcmZfY29weV9hdHRyKHN0cnVjdCBwZXJmX2V2ZW50X2F0
dHIgX191c2VyICp1YXR0ciwNCj4gICAJCQkgIHN0cnVjdCBwZXJmX2V2ZW50X2F0dHIgKmF0dHIp
Ow0KPiAgIA0KPiArI2lmZGVmIENPTkZJR19LUFJPQkVfRVZFTlRTDQo+ICtzdGF0aWMgc3RydWN0
IHBtdSBwZXJmX2twcm9iZTsNCj4gKyNlbmRpZiAvKiBDT05GSUdfS1BST0JFX0VWRU5UUyAqLw0K
PiArDQo+ICAgc3RhdGljIGxvbmcgX3BlcmZfaW9jdGwoc3RydWN0IHBlcmZfZXZlbnQgKmV2ZW50
LCB1bnNpZ25lZCBpbnQgY21kLCB1bnNpZ25lZCBsb25nIGFyZykNCj4gICB7DQo+ICAgCXZvaWQg
KCpmdW5jKShzdHJ1Y3QgcGVyZl9ldmVudCAqKTsNCj4gQEAgLTUxNDMsNiArNTE0NywxMyBAQCBz
dGF0aWMgbG9uZyBfcGVyZl9pb2N0bChzdHJ1Y3QgcGVyZl9ldmVudCAqZXZlbnQsIHVuc2lnbmVk
IGludCBjbWQsIHVuc2lnbmVkIGxvbg0KPiAgIA0KPiAgIAkJcmV0dXJuIHBlcmZfZXZlbnRfbW9k
aWZ5X2F0dHIoZXZlbnQsICAmbmV3X2F0dHIpOw0KPiAgIAl9DQo+ICsjaWZkZWYgQ09ORklHX0tQ
Uk9CRV9FVkVOVFMNCj4gKyAgICAgICAgY2FzZSBQRVJGX0VWRU5UX0lPQ19RVUVSWV9LUFJPQkU6
DQo+ICsJCWlmIChldmVudC0+YXR0ci50eXBlICE9IHBlcmZfa3Byb2JlLnR5cGUpDQo+ICsJCQly
ZXR1cm4gLUVJTlZBTDsNCj4gKw0KPiArICAgICAgICAgICAgICAgIHJldHVybiBwZXJmX2V2ZW50
X3F1ZXJ5X2twcm9iZShldmVudCwgKHZvaWQgX191c2VyICopYXJnKTsNCj4gKyNlbmRpZiAvKiBD
T05GSUdfS1BST0JFX0VWRU5UUyAqLw0KPiAgIAlkZWZhdWx0Og0KPiAgIAkJcmV0dXJuIC1FTk9U
VFk7DQo+ICAgCX0NCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC90cmFjZS90cmFjZV9rcHJvYmUuYyBi
L2tlcm5lbC90cmFjZS90cmFjZV9rcHJvYmUuYw0KPiBpbmRleCA5ZDQ4M2FkOWJiNmMuLjU0NDkx
ODJmMzA1NiAxMDA2NDQNCj4gLS0tIGEva2VybmVsL3RyYWNlL3RyYWNlX2twcm9iZS5jDQo+ICsr
KyBiL2tlcm5lbC90cmFjZS90cmFjZV9rcHJvYmUuYw0KPiBAQCAtMTk2LDYgKzE5NiwzMSBAQCBi
b29sIHRyYWNlX2twcm9iZV9lcnJvcl9pbmplY3RhYmxlKHN0cnVjdCB0cmFjZV9ldmVudF9jYWxs
ICpjYWxsKQ0KPiAgIAlyZXR1cm4gd2l0aGluX2Vycm9yX2luamVjdGlvbl9saXN0KHRyYWNlX2tw
cm9iZV9hZGRyZXNzKHRrKSk7DQo+ICAgfQ0KPiAgIA0KPiAraW50IHBlcmZfZXZlbnRfcXVlcnlf
a3Byb2JlKHN0cnVjdCBwZXJmX2V2ZW50ICpldmVudCwgdm9pZCBfX3VzZXIgKmluZm8pDQo+ICt7
DQo+ICsJc3RydWN0IHBlcmZfZXZlbnRfcXVlcnlfa3Byb2JlIF9fdXNlciAqdXF1ZXJ5ID0gaW5m
bzsNCj4gKwlzdHJ1Y3QgcGVyZl9ldmVudF9xdWVyeV9rcHJvYmUgcXVlcnkgPSB7fTsNCj4gKwlz
dHJ1Y3QgdHJhY2VfZXZlbnRfY2FsbCAqY2FsbCA9IGV2ZW50LT50cF9ldmVudDsNCj4gKwlzdHJ1
Y3QgdHJhY2Vfa3Byb2JlICp0ayA9IChzdHJ1Y3QgdHJhY2Vfa3Byb2JlICopY2FsbC0+ZGF0YTsN
Cj4gKwl1NjQgbm1pc3NlZCwgbmhpdDsNCj4gKw0KPiArCWlmICghY2FwYWJsZShDQVBfU1lTX0FE
TUlOKSkNCj4gKwkJcmV0dXJuIC1FUEVSTTsNCj4gKwlpZiAoY29weV9mcm9tX3VzZXIoJnF1ZXJ5
LCB1cXVlcnksIHNpemVvZihxdWVyeSkpKQ0KPiArCQlyZXR1cm4gLUVGQVVMVDsNCj4gKwlpZiAo
cXVlcnkuc2l6ZSAhPSBzaXplb2YocXVlcnkpKQ0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCg0KTm90
ZSB0aGF0IGhlcmUgd2UgZGlkIG5vdCBoYW5kbGUgYW55IGJhY2t3YXJkIG9yIGZvcndhcmQgY29t
cGF0aWJpbGl0eS4NCg0KPiArDQo+ICsJbmhpdCA9IHRyYWNlX2twcm9iZV9uaGl0KHRrKTsNCj4g
KwlubWlzc2VkID0gdGstPnJwLmtwLm5taXNzZWQ7DQo+ICsNCj4gKwlpZiAoY29weV90b191c2Vy
KCZ1cXVlcnktPm5taXNzZWQsICZubWlzc2VkLCBzaXplb2Yobm1pc3NlZCkpIHx8DQo+ICsJICAg
IGNvcHlfdG9fdXNlcigmdXF1ZXJ5LT5uaGl0LCAmbmhpdCwgc2l6ZW9mKG5oaXQpKSkNCj4gKwkJ
cmV0dXJuIC1FRkFVTFQ7DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiAgIHN0YXRp
YyBpbnQgcmVnaXN0ZXJfa3Byb2JlX2V2ZW50KHN0cnVjdCB0cmFjZV9rcHJvYmUgKnRrKTsNCj4g
ICBzdGF0aWMgaW50IHVucmVnaXN0ZXJfa3Byb2JlX2V2ZW50KHN0cnVjdCB0cmFjZV9rcHJvYmUg
KnRrKTsNCj4gICANCj4gDQo=
