Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41B0E139EDD
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2020 02:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgANBWt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jan 2020 20:22:49 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11146 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727556AbgANBWt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Jan 2020 20:22:49 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00E1Lhbc027750;
        Mon, 13 Jan 2020 17:22:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=pUmzPKZWTSwfZpKWLi90K8SjEC28OfAE6CpzAShIcmQ=;
 b=OwLc06NCMIeI56Sf4aadkCpFd9IsSCOEMMxtIsAnYRYK3ncb6Hm+j/0qSJheWxYFh/gV
 VqK8cs7fD6Mia2EB+3954YYGduGzym/M9i55aRREG+EEh5Zb4MH/IzQbKjgv78vOBaCn
 Hchgp7rbj6Q182qZSwtaUpebuw7hZpPmcH4= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2xfxy07npw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 13 Jan 2020 17:22:35 -0800
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 13 Jan 2020 17:22:34 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 13 Jan 2020 17:22:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAo1eMkeF8rLOhDtGnvK3JY5XlsHLGFKs8toNnT2RrtVIb+yR+ZScoS8QcdxKa4ZuJPzwSPgOJmCT4cupu8TmruF3wJ7d3PZAOBF8vijCVI8CMRywukdH91DU6fpZijau7tvis4DTmXixYpj4+Y2scfp+lUq03hJwYg3KthmAoO4fQawQA1DI64IpyfzOj6DOzIc5IDLVEfZgvQ/u0RRPjkMy2FGhl3GRQG7B9+QdBAB01PXk469tfO/pNOxJQTeG7Vi6SwpnpP5q3+R7LC6Xb8EAPYPqz6UUuDybeIAgDV7mz0ZczT7MGNS8MmBP2TmX2ygmwN03J5THyFKCn0z6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUmzPKZWTSwfZpKWLi90K8SjEC28OfAE6CpzAShIcmQ=;
 b=ZQ7yuKMlqFaJAqbCHshDKzPS3qfOEvgV2ZJljvI1kEnyUV0MIh66xBp+fR75nWqVslmPPEW82/57eZ4nwLIxylmKoovVLPjquQ2b94nu7DK0aq7Wwupf6aue0HVU/YKrDFMXkKbGbVs4Lhznr425pDf6YuZi0Afn9zytk/pLXOPDDK2om1b2R3QxpAybUsRRD2hxMpDVf4GPFH4ElSHeISk3RpLK0e67m4mQqsTCOjYlTnx5PgRRZDPrDF9VQZtbVNXFZ7fhE1NKoycAbtTNRXkLNq3uWs3jYmBkkmLSKvQrYOIfF+8ia+PQk4jkS9oIx6lPjj3h6i9ivvTxW0Y/vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUmzPKZWTSwfZpKWLi90K8SjEC28OfAE6CpzAShIcmQ=;
 b=OO+E3lHmWFMp/1I5d+GhQTT5Xz7Q+Vmz2TujRwnWjjOcKKN7cuM4Jl8qfTezUeZ9KF73Nq3r/O+pdrqD03IrQdZwgRYC87nMF7hTRk9tCSJVZ11MsBeBMLKB40XrJPfwoqGniSQEScg8LTPprdP1Kc4dAQF6qCxlXL3jOZxbGzI=
Received: from DM5PR15MB1675.namprd15.prod.outlook.com (10.175.107.145) by
 DM5PR15MB1770.namprd15.prod.outlook.com (10.174.247.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Tue, 14 Jan 2020 01:22:33 +0000
Received: from DM5PR15MB1675.namprd15.prod.outlook.com
 ([fe80::1cbf:c518:3a4d:291b]) by DM5PR15MB1675.namprd15.prod.outlook.com
 ([fe80::1cbf:c518:3a4d:291b%11]) with mapi id 15.20.2623.015; Tue, 14 Jan
 2020 01:22:33 +0000
Received: from macbook-pro-52.dhcp.thefacebook.com (2620:10d:c090:200::3:67b) by CO2PR05CA0009.namprd05.prod.outlook.com (2603:10b6:102:2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.11 via Frontend Transport; Tue, 14 Jan 2020 01:22:32 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@fb.com>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 2/2] tools/bpf: add a selftest for
 bpf_send_signal_thread()
Thread-Topic: [PATCH bpf-next 2/2] tools/bpf: add a selftest for
 bpf_send_signal_thread()
Thread-Index: AQHVyni2F/BTNhKxzUqWhLaGq/LdG6fpXTwA
Date:   Tue, 14 Jan 2020 01:22:33 +0000
Message-ID: <0fdac3e7-6457-8145-a3c9-b9f3e7dcf0ea@fb.com>
References: <20200110011557.1949757-1-yhs@fb.com>
 <20200110011559.1949913-1-yhs@fb.com>
 <CAEf4Bzagfmx1H3DgQ9ZjxKwbGdRGHAy7=qHt5S0Pqf0vV7PB4w@mail.gmail.com>
In-Reply-To: <CAEf4Bzagfmx1H3DgQ9ZjxKwbGdRGHAy7=qHt5S0Pqf0vV7PB4w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:102:2::19) To DM5PR15MB1675.namprd15.prod.outlook.com
 (2603:10b6:3:11f::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:67b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56f7eda6-04ca-45e3-6a15-08d798903b20
x-ms-traffictypediagnostic: DM5PR15MB1770:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR15MB1770463291684C991D45D787D3340@DM5PR15MB1770.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(376002)(136003)(39860400002)(189003)(199004)(5660300002)(86362001)(6512007)(316002)(8676002)(2616005)(54906003)(71200400001)(36756003)(2906002)(31696002)(6916009)(4326008)(16526019)(66556008)(52116002)(186003)(31686004)(81156014)(53546011)(81166006)(8936002)(478600001)(66476007)(66446008)(6486002)(6506007)(66946007)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1770;H:DM5PR15MB1675.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3FiPqnkxf+NC8W3ys6y4CwhSl3hXPcTUmMTiYTGRxNYOv34NjuK9NcmEAQo/s4x2f1Aywt+ZyNFqU7JZeLGt5iKy2caRBmhnRCfm97DciApCVwpocfGZd32rGtlvpGtu0K8sM+jL1sPus8kOXRPZFe86l2miIEblkrlJ/RLCQxB7PT4M5SYZu9GcbeJh7Hl4PtDqU6q1zdQmpYbFeqGTYSsvjswGoM8dF4GUEbmBjb0Nbxp75F8vxZW6AGHrg/54sWZuUp4AEKX3Ra0SMYRyND4eLYzmH6qNHf3prW0ytcvR9PakH2VH4b4ereIbnfYYQsxg2qV3U198jPYKNcbGAEVUX5fJ7xMCv0+eJmWfWnXDpaW32CRU2s5oseQ98XLokHJtTjc8KHQU0pHWmr29fob+5E2aJ0SFEWeSk9jdxuGml45B6jprx0YR5OOWDP6S
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EDC60EEC24D1D4DAD940C4A63E34CE0@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f7eda6-04ca-45e3-6a15-08d798903b20
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 01:22:33.1996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YGc413tVBSSBeqjggY7vj7gGqfgmvbeWCIv2XGx5zPwA8Ril3wY91rQM2Zgv49pd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1770
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-13_08:2020-01-13,2020-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001140009
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDEvMTMvMjAgNToxOSBQTSwgQW5kcmlpIE5ha3J5aWtvIHdyb3RlOg0KPiBPbiBUaHUs
IEphbiA5LCAyMDIwIGF0IDU6MTYgUE0gWW9uZ2hvbmcgU29uZyA8eWhzQGZiLmNvbT4gd3JvdGU6
DQo+Pg0KPj4gVGhlIHRlc3RfcHJvZ3Mgc2VuZF9zaWduYWwoKSBpcyBhbWVuZGVkIHRvIHRlc3QN
Cj4+IGJwZl9zZW5kX3NpZ25hbF90aHJlYWQoKSBhcyB3ZWxsLg0KPj4NCj4+ICAgICQgLi90ZXN0
X3Byb2dzIC1uIDQwDQo+PiAgICAjNDAvMSBzZW5kX3NpZ25hbF90cmFjZXBvaW50Ok9LDQo+PiAg
ICAjNDAvMiBzZW5kX3NpZ25hbF9wZXJmOk9LDQo+PiAgICAjNDAvMyBzZW5kX3NpZ25hbF9ubWk6
T0sNCj4+ICAgICM0MC80IHNlbmRfc2lnbmFsX3RyYWNlcG9pbnRfdGhyZWFkOk9LDQo+PiAgICAj
NDAvNSBzZW5kX3NpZ25hbF9wZXJmX3RocmVhZDpPSw0KPj4gICAgIzQwLzYgc2VuZF9zaWduYWxf
bm1pX3RocmVhZDpPSw0KPj4gICAgIzQwIHNlbmRfc2lnbmFsOk9LDQo+PiAgICBTdW1tYXJ5OiAx
LzYgUEFTU0VELCAwIFNLSVBQRUQsIDAgRkFJTEVEDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWW9u
Z2hvbmcgU29uZyA8eWhzQGZiLmNvbT4NCj4+IC0tLQ0KPj4gICB0b29scy9pbmNsdWRlL3VhcGkv
bGludXgvYnBmLmggICAgICAgICAgICAgICAgfCAxOCArKysrKysrKystLQ0KPiANCj4gbWF5YmUg
ZG8gdG9vbHMvdWFwaSBoZWFkZXIgc3luYyBpbiBhIGZpcnN0IHBhdGNoLCBhbG9uZyB0aGUgb3Jp
Z2luYWwgY2hhbmdlPw0KDQpXaWxsIGRvLg0KDQo+IA0KPj4gICAuLi4vc2VsZnRlc3RzL2JwZi9w
cm9nX3Rlc3RzL3NlbmRfc2lnbmFsLmMgICAgfCAzMCArKysrKysrKysrKystLS0tLS0tDQo+PiAg
IC4uLi9icGYvcHJvZ3MvdGVzdF9zZW5kX3NpZ25hbF9rZXJuLmMgICAgICAgICB8ICA5ICsrKyst
LQ0KPj4gICAzIGZpbGVzIGNoYW5nZWQsIDQyIGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygt
KQ0KPj4NCj4gDQo+IFsuLi5dDQo+IA0KPj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2JwZi9wcm9ncy90ZXN0X3NlbmRfc2lnbmFsX2tlcm4uYyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2JwZi9wcm9ncy90ZXN0X3NlbmRfc2lnbmFsX2tlcm4uYw0KPj4gaW5kZXggMGU2
YmUwMTE1N2U2Li40YTcyMjAyNGMzMmIgMTAwNjQ0DQo+PiAtLS0gYS90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9icGYvcHJvZ3MvdGVzdF9zZW5kX3NpZ25hbF9rZXJuLmMNCj4+ICsrKyBiL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9ncy90ZXN0X3NlbmRfc2lnbmFsX2tlcm4uYw0KPj4g
QEAgLTIzLDYgKzIzLDcgQEAgaW50IGJwZl9zZW5kX3NpZ25hbF90ZXN0KHZvaWQgKmN0eCkNCj4+
ICAgew0KPj4gICAgICAgICAgX191NjQgKmluZm9fdmFsLCAqc3RhdHVzX3ZhbDsNCj4+ICAgICAg
ICAgIF9fdTMyIGtleSA9IDAsIHBpZCwgc2lnOw0KPj4gKyAgICAgICBpbnQgdXNlX3NpZ25hbF90
aHJlYWQ7DQo+PiAgICAgICAgICBpbnQgcmV0Ow0KPj4NCj4+ICAgICAgICAgIHN0YXR1c192YWwg
PSBicGZfbWFwX2xvb2t1cF9lbGVtKCZzdGF0dXNfbWFwLCAma2V5KTsNCj4+IEBAIC0zMywxMSAr
MzQsMTUgQEAgaW50IGJwZl9zZW5kX3NpZ25hbF90ZXN0KHZvaWQgKmN0eCkNCj4+ICAgICAgICAg
IGlmICghaW5mb192YWwgfHwgKmluZm9fdmFsID09IDApDQo+PiAgICAgICAgICAgICAgICAgIHJl
dHVybiAwOw0KPj4NCj4+IC0gICAgICAgc2lnID0gKmluZm9fdmFsID4+IDMyOw0KPj4gKyAgICAg
ICB1c2Vfc2lnbmFsX3RocmVhZCA9ICppbmZvX3ZhbCA+PiA0ODsNCj4+ICsgICAgICAgc2lnID0g
KmluZm9fdmFsID4+IDMyICYgMHhGRkZGOw0KPj4gICAgICAgICAgcGlkID0gKmluZm9fdmFsICYg
MHhmZmZmRkZGRjsNCj4gDQo+IFdvdWxkIHlvdSBtaW5kIHJld3JpdGluZyB0aGlzIHRlc3Qgdy8g
QlBGIHNrZWxldG9uIGFuZCBnbG9iYWwgZGF0YT8gSXQNCj4gd291bGQgbWFrZSBpdCBjbGVhbmVy
IHdpdGhvdXQgYWxsIHRoaXMgbWFza2luZyBzdHVmZj8NCg0KUHJldmlvdXNseSBJIG1hZGUgdGhl
IGNoYW5nZSB0byBtaW5pbWl6ZSB0aGUgbnVtYmVyIG9mIGNoYW5nZWQgbGluZXMuDQpCdXQgc2lu
Y2UgeW91IGFyZSBtZW50aW9uaW5nIHJld3JpdGluZyBoZXJlLCBJIHdpbGwgZG8gaXQgaW4gdjIu
DQoNCj4gDQo+Pg0KPj4gICAgICAgICAgaWYgKChicGZfZ2V0X2N1cnJlbnRfcGlkX3RnaWQoKSA+
PiAzMikgPT0gcGlkKSB7DQo+PiAtICAgICAgICAgICAgICAgcmV0ID0gYnBmX3NlbmRfc2lnbmFs
KHNpZyk7DQo+PiArICAgICAgICAgICAgICAgaWYgKHVzZV9zaWduYWxfdGhyZWFkKQ0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgcmV0ID0gYnBmX3NlbmRfc2lnbmFsX3RocmVhZChzaWcpOw0K
Pj4gKyAgICAgICAgICAgICAgIGVsc2UNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldCA9
IGJwZl9zZW5kX3NpZ25hbChzaWcpOw0KPj4gICAgICAgICAgICAgICAgICBpZiAocmV0ID09IDAp
DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgKnN0YXR1c192YWwgPSAxOw0KPj4gICAgICAg
ICAgfQ0KPj4gLS0NCj4+IDIuMTcuMQ0KPj4NCg==
