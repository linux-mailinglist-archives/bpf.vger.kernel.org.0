Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09BF0139ED1
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2020 02:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgANBPh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jan 2020 20:15:37 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48704 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729088AbgANBPh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Jan 2020 20:15:37 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00E1DYfH008479;
        Mon, 13 Jan 2020 17:15:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=AkhiAy/zUtIP7+9kn+GpH1nr1zQE8P9kwEBFX0B/yAA=;
 b=lqKGRC2ln1qt+ge3UuuKzgy55C18wIy+JmtssDuziQMgAYKi4dIqqY2bctfGg0gSHFw0
 ZfawfRI2mtE533rV0mze+Zh5mCF4yLJqFJv/Oake8CHO9teeLMmOA04HjLHzYQB4L/Ll
 Gyr2iwPIXyLeHwLjgtwqtlSR9rpvpNU4ijc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xfxy07mxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 13 Jan 2020 17:15:23 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 13 Jan 2020 17:15:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGYqnUZfL6W1QlakdyZtqlvUpzweu6nUpOBxNVpi0GeD/kLsm2p5/UWCWFv/+IvdosIDf1O+Dvf6HVw2WNor5wO3wprv47kdmIKSkFGKk9mrVGCQc2b5KanIMTx1uBFbLb1WVzaUzTjMohcXIl8Tq4GC8I8rZkutGYABD9U87p/EBLx3WEeRgjKHvTAEsbD5pqHFrrcEOsh/eHJDTKGzSJxCo4peZzJWNLsGAMYSjibLhxNMchjZtNzLb+q1bDdKYwJChGKulPEoxsc6FBxhEEdJph9GgmmVkOJTLFspAcDot7oGCOXf7+h3tIMAoMl1D3jQ/jhdwpHUGRtdvDBKVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkhiAy/zUtIP7+9kn+GpH1nr1zQE8P9kwEBFX0B/yAA=;
 b=IBz6gb0lV3uAvp3hGyTxvfyXC37n3rLqxr5UldBFy8SWrdN7CUOPC1QVoP8PB2MOrJz0D8PImOTJRRo95ACFkjv143r5xs9uybYV43Ce9KdwiVqWcct9T8l8zyv36oxDhuXzmKhUeaWaygk85AZDQ5BdtdF3yxo5CdApH4e2MaOH2Aj3bwwBk+2kqJuUbdv1AYIL2/uGNeTQGr/89zNFBQiaq5SiZb39LxdgmbvARomJtBY2nZRruL0oqucAZnG7eh5utMHn+MqnKk96ck/93lB2wAI86R57CsOcgT9k/Ead0ylFqtR8k+8NsYCBGU1uKjnudxyvRgx0q3WH/iIBRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkhiAy/zUtIP7+9kn+GpH1nr1zQE8P9kwEBFX0B/yAA=;
 b=cV8orDyngzLmhjUuKSWbUfuBTz599wtTGZY57V/kPAUzowmx4bNp+T9wsiK6EuSC5KCjodeBhEfteAVu3a7ApSwVoFkQ/znNf/luJcd6ffyib6Labecy8d22Svy3YAhLVrHldiRnQymDrRe6pPAdQt8jF8okWN1m1ixWb5fkA5s=
Received: from DM5PR15MB1675.namprd15.prod.outlook.com (10.175.107.145) by
 DM5PR15MB1627.namprd15.prod.outlook.com (10.175.107.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Tue, 14 Jan 2020 01:15:21 +0000
Received: from DM5PR15MB1675.namprd15.prod.outlook.com
 ([fe80::1cbf:c518:3a4d:291b]) by DM5PR15MB1675.namprd15.prod.outlook.com
 ([fe80::1cbf:c518:3a4d:291b%11]) with mapi id 15.20.2623.015; Tue, 14 Jan
 2020 01:15:21 +0000
Received: from macbook-pro-52.dhcp.thefacebook.com (2620:10d:c090:200::3:67b) by MWHPR21CA0046.namprd21.prod.outlook.com (2603:10b6:300:129::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.0 via Frontend Transport; Tue, 14 Jan 2020 01:15:20 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@fb.com>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_send_signal_thread() helper
Thread-Topic: [PATCH bpf-next 1/2] bpf: add bpf_send_signal_thread() helper
Thread-Index: AQHVynXcfOJjn0hOVUKlkGRXm7VwTafpWz4A
Date:   Tue, 14 Jan 2020 01:15:20 +0000
Message-ID: <3eefa7f2-438f-9eda-b573-a8b2d0699441@fb.com>
References: <20200110011557.1949757-1-yhs@fb.com>
 <20200110011558.1949832-1-yhs@fb.com>
 <CAEf4Bzab0S_cXb3sJNaOFZ7gSrp8u5Y2Q+dmA4BWrqiXmYx7Gw@mail.gmail.com>
In-Reply-To: <CAEf4Bzab0S_cXb3sJNaOFZ7gSrp8u5Y2Q+dmA4BWrqiXmYx7Gw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0046.namprd21.prod.outlook.com
 (2603:10b6:300:129::32) To DM5PR15MB1675.namprd15.prod.outlook.com
 (2603:10b6:3:11f::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:67b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b14024fb-e5b6-420e-b75b-08d7988f397b
x-ms-traffictypediagnostic: DM5PR15MB1627:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR15MB1627D6B1087A64A2034206BDD3340@DM5PR15MB1627.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(366004)(376002)(39860400002)(199004)(189003)(478600001)(66476007)(86362001)(6512007)(6506007)(53546011)(52116002)(6916009)(31696002)(66556008)(4326008)(186003)(66946007)(64756008)(66446008)(16526019)(36756003)(6486002)(5660300002)(8676002)(8936002)(71200400001)(316002)(2906002)(31686004)(2616005)(81156014)(81166006)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1627;H:DM5PR15MB1675.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UtPzQ+wq3kA0Kccr8uCf83vQhHFgbc37DgTFCL3H85tU1DBFr25kYv9zghOvZtopQWq/eE1ogAs+36QL/n73SEHDdYSoNrsHLKYXQ5Axr7w4ISOH+0MIr4Z1kjWklqAhI0jaD+wUkgwIo+VTuXs0QUiEmfxua81SwRE5hpqa0hFd7WtX7fgpngRUCrtOHIrgT5uL6IzPBGeQx+Fp+WcKChANpmTphrU4jTbG3NZe0DWhJduTExidIC2QiLL3B6WbyHVe4nArSpovH2IfxWFjnwJ1PsEiPKvMtMqHoLkkX7+QbiITWNcDyrj/XSvlZIKT5gWisYfZ4AEmQtQO+zW40WnaQjsnI2Sy35pRkvMQYSo6bA9qOAkSXr0rmk4UIvK8OiVyX+R7LQHpRfAy+IzlOwAkNLgKqsq6IjBPbvRlQ2Q0d4hNXum+pRPNkPNDlya7
Content-Type: text/plain; charset="utf-8"
Content-ID: <D75EC2706C23C54491F7BF13A88EBA53@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b14024fb-e5b6-420e-b75b-08d7988f397b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 01:15:20.9688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 46gZBmSQlqpCyhXsd1P1aZGTTWLH5rljyz/6NepBcGQKJKbVMfmHdndRGJkK4cxm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1627
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-13_08:2020-01-13,2020-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001140008
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDEvMTMvMjAgNDo1OCBQTSwgQW5kcmlpIE5ha3J5aWtvIHdyb3RlOg0KPiBPbiBUaHUs
IEphbiA5LCAyMDIwIGF0IDU6MTYgUE0gWW9uZ2hvbmcgU29uZyA8eWhzQGZiLmNvbT4gd3JvdGU6
DQo+Pg0KPj4gQ29tbWl0IDhiNDAxZjllZDI0NCAoImJwZjogaW1wbGVtZW50IGJwZl9zZW5kX3Np
Z25hbCgpIGhlbHBlciIpDQo+PiBhZGRlZCBoZWxwZXIgYnBmX3NlbmRfc2lnbmFsKCkgd2hpY2gg
cGVybWl0cyBicGYgcHJvZ3JhbSB0bw0KPj4gc2VuZCBhIHNpZ25hbCB0byB0aGUgY3VycmVudCBw
cm9jZXNzLg0KPj4NCj4+IFdlIGZvdW5kIGEgdXNlIGNhc2Ugd2hlcmUgc2VuZGluZyB0aGUgc2ln
bmFsIHRvIHRoZSBjdXJyZW50DQo+PiB0aHJlYWQgaXMgbW9yZSBwcmVmZXJhYmxlLg0KPj4gICAg
LSBBIGJwZiBwcm9ncmFtIHdpbGwgY29sbGVjdCB0aGUgc3RhY2sgdHJhY2UgYW5kIHRoZW4NCj4+
ICAgICAgc2VuZCBzaWduYWwgdG8gdGhlIHVzZXIgYXBwbGljYXRpb24uDQo+PiAgICAtIFRoZSB1
c2VyIGFwcGxpY2F0aW9uIHdpbGwgYWRkIHNvbWUgdGhyZWFkIHNwZWNpZmljDQo+PiAgICAgIGlu
Zm9ybWF0aW9uIHRvIHRoZSBqdXN0IGNvbGxlY3RlZCBzdGFjayB0cmFjZSBmb3INCj4+ICAgICAg
bGF0ZXIgYW5hbHlzaXMuDQo+Pg0KPj4gSWYgYnBmX3NlbmRfc2lnbmFsKCkgaXMgdXNlZCwgdXNl
ciBhcHBsaWNhdGlvbiB3aWxsIG5lZWQNCj4+IHRvIGNoZWNrIHdoZXRoZXIgdGhlIHRocmVhZCBy
ZWNlaXZpbmcgdGhlIHNpZ25hbCBtYXRjaGVzDQo+PiB0aGUgdGhyZWFkIGNvbGxlY3RpbmcgdGhl
IHN0YWNrIGJ5IGNoZWNraW5nIHRocmVhZCBpZC4NCj4+IElmIG5vdCwgaXQgd2lsbCBuZWVkIHRv
IHNlbmQgc2lnbmFsIHRvIGFub3RoZXIgdGhyZWFkDQo+PiB0aHJvdWdoIHB0aHJlYWRfa2lsbCgp
Lg0KPj4NCj4+IFRoaXMgcGF0Y2ggcHJvcG9zZWQgYSBuZXcgaGVscGVyIGJwZl9zZW5kX3NpZ25h
bF90aHJlYWQoKSwNCj4+IHdoaWNoIHNlbmRzIHRoZSBzaWduYWwgdG8gdGhlIGN1cnJlbnQgdGhy
ZWFkLiBUaGlzIHdheSwNCj4+IHVzZXIgc3BhY2UgaXMgZ3VhcmFudGVlZCB0aGF0IGJwZl9wcm9n
cmFtIGV4ZWN1dGlvbiBjb250ZXh0DQo+PiBhbmQgdXNlciBzcGFjZSBzaWduYWwgaGFuZGxpbmcg
Y29udGV4dCBhcmUgdGhlIHNhbWUgdGhyZWFkLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFlvbmdo
b25nIFNvbmcgPHloc0BmYi5jb20+DQo+PiAtLS0NCj4+ICAgaW5jbHVkZS91YXBpL2xpbnV4L2Jw
Zi5oIHwgMTggKysrKysrKysrKysrKysrKy0tDQo+PiAgIGtlcm5lbC90cmFjZS9icGZfdHJhY2Uu
YyB8IDI3ICsrKysrKysrKysrKysrKysrKysrKysrKy0tLQ0KPj4gICAyIGZpbGVzIGNoYW5nZWQs
IDQwIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvdWFwaS9saW51eC9icGYuaCBiL2luY2x1ZGUvdWFwaS9saW51eC9icGYuaA0KPj4gaW5k
ZXggNTI5NjZlNzU4ZmU1Li4zMzIwZjhiZGZlN2UgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL3Vh
cGkvbGludXgvYnBmLmgNCj4+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC9icGYuaA0KPj4gQEAg
LTI3MTQsNyArMjcxNCw3IEBAIHVuaW9uIGJwZl9hdHRyIHsNCj4+ICAgICoNCj4+ICAgICogaW50
IGJwZl9zZW5kX3NpZ25hbCh1MzIgc2lnKQ0KPj4gICAgKiAgICAgRGVzY3JpcHRpb24NCj4+IC0g
KiAgICAgICAgICAgICBTZW5kIHNpZ25hbCAqc2lnKiB0byB0aGUgY3VycmVudCB0YXNrLg0KPj4g
KyAqICAgICAgICAgICAgIFNlbmQgc2lnbmFsICpzaWcqIHRvIHRoZSBwcm9jZXNzIG9mIHRoZSBj
dXJyZW50IHRhc2suDQo+PiAgICAqICAgICBSZXR1cm4NCj4+ICAgICogICAgICAgICAgICAgMCBv
biBzdWNjZXNzIG9yIHN1Y2Nlc3NmdWxseSBxdWV1ZWQuDQo+PiAgICAqDQo+PiBAQCAtMjg1MCw2
ICsyODUwLDE5IEBAIHVuaW9uIGJwZl9hdHRyIHsNCj4+ICAgICogICAgIFJldHVybg0KPj4gICAg
KiAgICAgICAgICAgICAwIG9uIHN1Y2Nlc3MsIG9yIGEgbmVnYXRpdmUgZXJyb3IgaW4gY2FzZSBv
ZiBmYWlsdXJlLg0KPj4gICAgKg0KPj4gKyAqIGludCBicGZfc2VuZF9zaWduYWxfdGhyZWFkKHUz
MiBzaWcpDQo+PiArICogICAgIERlc2NyaXB0aW9uDQo+PiArICogICAgICAgICAgICAgU2VuZCBz
aWduYWwgKnNpZyogdG8gdGhlIGN1cnJlbnQgdGFzay4NCj4gDQo+IA0KPiBUaGlzIGFsbCBtYWtl
cyBzZW5zZSBhbmQgbG9va3MgZ29vZCwgYnV0IEkgdGhpbmsgaXQncyB2ZXJ5IHVuY2xlYXIgd2h5
DQo+IHRoZSBkaXN0aW5jdGlvbiBiZXR3ZWVuIHNlbmRpbmcgc2lnbmFsIHRvIHByb2Nlc3MgdnMg
dGhyZWFkLiBDb3VsZCB5b3UNCj4gZXh0ZW5kIGJwZl9zZW5kX3NpZ25hbCBhbmQgYnBmX3NlbmRf
c2lnbmFsX3RocmVhZCBkZXNjcmlwdGlvbnMNCj4gZXhwbGFpbmluZyB0aGUgZGlmZmVyZW5jZSAo
ZS5nLiwgdGhhdCwgYWNjb3JkaW5nIHRvIFBPU0lYLCB3aGVuDQo+IHNlbmRpbmcgc2lnbmFsIHRv
IGEgcHJvY2VzcywgYW55IHRocmVhZCB3aXRoaW4gdGhhdCBwcm9jZXNzIGNhbiBnZXQNCj4gc2ln
bmFsIGRlbGl2ZXJlZCwgd2hpbGUgc2VuZGluZyB0byBhIHNwZWNpZmljIHRocmVhZCB3aWxsIGVu
c3VyZSB0aGF0DQo+IHRoYXQgc3BlY2lmaWMgdGhyZWFkIHdpbGwgcmVjZWl2ZSBkZXNpcmVkIHNp
Z25hbCkuDQoNClNvdW5kcyBnb29kLiBXaWxsIHNlbmQgdjIgd2l0aCBiZXR0ZXIgZGVzY3JpcHRp
b25zIGxhdGVyLg0KDQo+IA0KPiBbLi4uXQ0KPiANCg==
