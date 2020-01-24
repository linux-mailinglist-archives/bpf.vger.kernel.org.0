Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24579148C5C
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2020 17:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389596AbgAXQkS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jan 2020 11:40:18 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:20032 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387517AbgAXQkR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 Jan 2020 11:40:17 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00OGUwC6027855;
        Fri, 24 Jan 2020 08:40:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=/SqpiTqbUjhTu2h8Baz4Ln3jX2bwMqLfCZPMXsZqr3A=;
 b=fqYRiV0zcA1rZuKVSQnA1Iqeh8xGft2s2j48s40AkqTNGAf9TuHhgcVio9r79wX5tvrs
 a+3SoQn3YbCEbZmd+dd53rOV+3m4T8onnUxYOxrz30u9Hm3q1Gf9gru6imO3qORE78ZI
 D4SWpKLe1tPCc6KyKA3nco/+Wh+m2neIm1c= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xqc88643g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 24 Jan 2020 08:40:02 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 24 Jan 2020 08:40:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTB/fI1v1F1+z3jSmHWp4oN4VjmbJE7HpjOkFuCOZTc2QUKoGoPqMwD5r94dWMlLPoKm0uIqr/F0gcaLoyKprUb4yuBnoEEcGY63yc6pEbLDjNveRVzSzBbn7A1CsyvFiQV8UNjgg7EIDuShe4o5RlBqnNVDr0GYDjyvn8nwu9m+1omu8lqA6kraKbKy3vBofTMOe5FPbwlEhLKyTsAhzleuItmP7QG8uycbEqJcG+XWqrSrzNYxzygW9hJNpeKOEbBBaG19qdQH8tLfQm5hW8pWEryrOq+saj5leBaB9kVOXxGtRx0jjrkxZ7GtrA3/vorefYrHJ2ihydI+DIs3TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SqpiTqbUjhTu2h8Baz4Ln3jX2bwMqLfCZPMXsZqr3A=;
 b=FARS5Nrn+1DU+YlkaipB7PVa29slHkwGzrjECd9Ff1hHqv7Rb5OV4UiAi7XKS5Hw0mxeuGfVocAJ6WnAFOZTQRfLVX/Y6+PbxzpJZ1jH9llDd53vsaolJ7LUxcOqW3/Nk/05enT9/02aeK2bhh7Gf7aPwLD7quZqCep7/fx0CwQn+Nsk2lO7xTou1Sjq5jAA9JvLgLHtjQejj1QPafOtixrXMttW3iz3+2yjbkMk2b666CeDdT9KkTJRaWfoPBjgHMMOoV22wagraZl1T6XpFKyrpkgfWynZC/YlkidMM0WORlZM2HE69oJmPpyUdyA+3PsWNqvSaKv21S2/QjpvPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SqpiTqbUjhTu2h8Baz4Ln3jX2bwMqLfCZPMXsZqr3A=;
 b=D8hJpPLmvYWO/3xlbU4ib+mgEkPXi4UImOuuAUD2ZBROqNVxUIG05DUsiw6i3IVRq3+kls56hTlbsOeJNC1x8ayoq3vAYEcszosjKKrneJqNTla4xH/cH9hGffFRwafWmZ2bJ3YaFfhk0oJxteHNXRPZ6Vpvp6y8K50G+xNRmMY=
Received: from DM6PR15MB3001.namprd15.prod.outlook.com (20.178.231.16) by
 DM6PR15MB2540.namprd15.prod.outlook.com (20.179.160.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Fri, 24 Jan 2020 16:40:00 +0000
Received: from DM6PR15MB3001.namprd15.prod.outlook.com
 ([fe80::1d74:b392:183e:c8c2]) by DM6PR15MB3001.namprd15.prod.outlook.com
 ([fe80::1d74:b392:183e:c8c2%6]) with mapi id 15.20.2644.028; Fri, 24 Jan 2020
 16:39:59 +0000
Received: from MacBook-Pro-52.local (2620:10d:c090:200::bdf3) by MWHPR13CA0004.namprd13.prod.outlook.com (2603:10b6:300:16::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.14 via Frontend Transport; Fri, 24 Jan 2020 16:39:57 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     "ast@kernel.org" <ast@kernel.org>
Subject: Re: [bpf PATCH] bpf: verifier, do_refine_retval_range may clamp umin
 to 0 incorrectly
Thread-Topic: [bpf PATCH] bpf: verifier, do_refine_retval_range may clamp umin
 to 0 incorrectly
Thread-Index: AQHV0oV9Zk/2dsKgMUehFx1ZmmRN2Kf5fasAgACHGoA=
Date:   Fri, 24 Jan 2020 16:39:58 +0000
Message-ID: <80b751cc-dc3d-e0e2-1901-b49fc9e866a8@fb.com>
References: <157984984270.18622.13529102486040865869.stgit@john-XPS-13-9370>
 <6cdc9a24-39af-a06a-1db4-3cbf7eae598c@iogearbox.net>
In-Reply-To: <6cdc9a24-39af-a06a-1db4-3cbf7eae598c@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:300:16::14) To DM6PR15MB3001.namprd15.prod.outlook.com
 (2603:10b6:5:13c::16)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::bdf3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54cc57bb-1bae-4ac7-24cc-08d7a0ec0c9b
x-ms-traffictypediagnostic: DM6PR15MB2540:
x-microsoft-antispam-prvs: <DM6PR15MB25409C1C569D905F2C99130ED30E0@DM6PR15MB2540.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 02929ECF07
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(366004)(39860400002)(346002)(396003)(189003)(199004)(5660300002)(52116002)(31696002)(8676002)(81156014)(6512007)(66556008)(66946007)(66446008)(86362001)(81166006)(36756003)(8936002)(66476007)(64756008)(71200400001)(478600001)(316002)(4326008)(2906002)(110136005)(16526019)(53546011)(2616005)(31686004)(186003)(6486002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB2540;H:DM6PR15MB3001.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UqO7FSdnQk/zDXfrECj1KFEXt/ymsqpxkqA10y2sxig1tXiuKBmDYrLbQRxKvFuiUKSnDAf7uJ8jkFims3+vRmwI+uMTNpVFIeBf3lbV97V2Get1vn45zE+6vTkbOXJWmOj3kVDZEEJ1eV8YTN4D7fpIqIo/HeJuVNjVuQX7REFjfGzH+htsIC1wmA3d5Xbj5BVwdOO43Dw565gKqh8qf/XPQ1379qiGYID7PwAa0qpUNh6GzVfmCvhzED52AGiLGqF5r9kQiv72l83n5q/fNY63DqTRDeVbwyKXfwfmooaDPxtwIIByrbiuHOVGbFblAGCj1EG3ENJYhvzlu4DHzAzvS96GYYkosuNV3z6EEooh/eeI0PAt+rcC/Hw2d4JbUrOutx1fQ6TSPFRH/P1qqAeOGom0hm3HghtlnsFjIn8Vgq4fwBpxAdEl8buucfsx
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C023570A168011468BF06CB8891D30F4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 54cc57bb-1bae-4ac7-24cc-08d7a0ec0c9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2020 16:39:59.0949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SSrnsYvOOFkfjrov1yP7zA0gt9dOsIPq9iSkWpRDFdch5WfnMdAnWEDKlDhkSdY5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2540
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-24_05:2020-01-24,2020-01-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001240135
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDEvMjQvMjAgMTI6MzYgQU0sIERhbmllbCBCb3JrbWFubiB3cm90ZToNCj4gT24gMS8y
NC8yMCA4OjEwIEFNLCBKb2huIEZhc3RhYmVuZCB3cm90ZToNCj4+IGRvX3JlZmluZV9yZXR2YWxf
cmFuZ2UoKSBpcyBjYWxsZWQgdG8gcmVmaW5lIHJldHVybiB2YWx1ZXMgZnJvbSBzcGVjaWZpZWQN
Cj4+IGhlbHBlcnMsIHByb2JlX3JlYWRfc3RyIGFuZCBnZXRfc3RhY2sgYXQgdGhlIG1vbWVudCwg
dGhlIHJlYXNvbmluZyBpcw0KPj4gYmVjYXVzZSBib3RoIGhhdmUgYSBtYXggdmFsdWUgYXMgcGFy
dCBvZiB0aGVpciBpbnB1dCBhcmd1bWVudHMgYW5kDQo+PiBiZWNhdXNlIHRoZSBoZWxwZXIgZW5z
dXJlIHRoZSByZXR1cm4gdmFsdWUgd2lsbCBub3QgYmUgbGFyZ2VyIHRoYW4gdGhpcw0KPj4gd2Ug
Y2FuIHNldCB1bWF4IGFuZCBzbWF4IHZhbHVlcyBvZiB0aGUgcmV0dXJuIHJlZ2lzdGVyLCByMC4N
Cj4+DQo+PiBIb3dldmVyLCB0aGUgcmV0dXJuIHZhbHVlIGlzIGEgc2lnbmVkIGludGVnZXIgc28g
c2V0dGluZyB1bWF4IGlzIA0KPj4gaW5jb3JyZWN0DQo+PiBJdCBsZWFkcyB0byBmdXJ0aGVyIGNv
bmZ1c2lvbiB3aGVuIHRoZSBkb19yZWZpbmVfcmV0dmFsX3JhbmdlKCkgdGhlbiANCj4+IGNhbGxz
LA0KPj4gX19yZWdfZGVkdWNlX2JvdW5kcygpIHdoaWNoIHdpbGwgc2VlIGEgdW1heCB2YWx1ZSBh
cyBtZWFuaW5nIHRoZSB2YWx1ZSBpcw0KPj4gdW5zaWduZWQgYW5kIHRoZW4gYXNzdW1pbmcgaXQg
aXMgdW5zaWduZWQgc2V0IHRoZSBzbWluID0gdW1pbiB3aGljaCBpbiANCj4+IHRoaXMNCj4+IGNh
c2UgcmVzdWx0cyBpbiAnc21pbiA9IDAnIGFuZCBhbiAnc21heCA9IFgnIHdoZXJlIFggaXMgdGhl
IGlucHV0IA0KPj4gYXJndW1lbnQNCj4+IGZyb20gdGhlIGhlbHBlciBjYWxsLg0KPj4NCj4+IEhl
cmUgYXJlIHRoZSBjb21tZW50cyBmcm9tIF9yZWdfZGVkdWNlX2JvdW5kcygpIG9uIHdoeSB0aGlz
IHdvdWxkIGJlIHNhZmUNCj4+IHRvIGRvLg0KPj4NCj4+IMKgIC8qIExlYXJuIHNpZ24gZnJvbSB1
bnNpZ25lZCBib3VuZHMuwqAgU2lnbmVkIGJvdW5kcyBjcm9zcyB0aGUgc2lnbg0KPj4gwqDCoCAq
IGJvdW5kYXJ5LCBzbyB3ZSBtdXN0IGJlIGNhcmVmdWwuDQo+PiDCoMKgICovDQo+PiDCoCBpZiAo
KHM2NClyZWctPnVtYXhfdmFsdWUgPj0gMCkgew0KPj4gwqDCoMKgwqAvKiBQb3NpdGl2ZS7CoCBX
ZSBjYW4ndCBsZWFybiBhbnl0aGluZyBmcm9tIHRoZSBzbWluLCBidXQgc21heA0KPj4gwqDCoMKg
wqAgKiBpcyBwb3NpdGl2ZSwgaGVuY2Ugc2FmZS4NCj4+IMKgwqDCoMKgICovDQo+PiDCoMKgwqDC
oHJlZy0+c21pbl92YWx1ZSA9IHJlZy0+dW1pbl92YWx1ZTsNCj4+IMKgwqDCoMKgcmVnLT5zbWF4
X3ZhbHVlID0gcmVnLT51bWF4X3ZhbHVlID0gbWluX3QodTY0LCByZWctPnNtYXhfdmFsdWUsDQo+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWct
PnVtYXhfdmFsdWUpOw0KPj4NCj4+IEJ1dCBub3cgd2UgaW5jb3JyZWN0bHkgaGF2ZSBhIHJldHVy
biB2YWx1ZSB3aXRoIHR5cGUgaW50IHdpdGggdGhlDQo+PiBzaWduZWQgYm91bmRzICgwLFgpLiBT
dXBwb3NlIHRoZSByZXR1cm4gdmFsdWUgaXMgbmVnYXRpdmUsIHdoaWNoIGlzDQo+PiBwb3NzaWJs
ZSB0aGUgd2UgaGF2ZSB0aGUgdmVyaWZpZXIgYW5kIHJlYWxpdHkgb3V0IG9mIHN5bmMuIEFtb25n
IG90aGVyDQo+PiB0aGluZ3MgdGhpcyBtYXkgcmVzdWx0IGluIGFueSBlcnJvciBoYW5kbGluZyBj
b2RlIGJlaW5nIGZhbHNlbHkgZGV0ZWN0ZWQNCj4+IGFzIGRlYWQtY29kZSBhbmQgcmVtb3ZlZC4g
Rm9yIGluc3RhbmNlIHRoZSBleGFtcGxlIGJlbG93IHNob3dzIHVzaW5nDQo+PiBicGZfcHJvYmVf
cmVhZF9zdHIoKSBjYXVzZXMgdGhlIGVycm9yIHBhdGggdG8gYmUgaWRlbnRpZmllZCBhcyBkZWFk
DQo+PiBjb2RlIGFuZCByZW1vdmVkLg0KPj4NCj4+PiBGcm9tIHRoZSAnbGx2bS1vYmplY3QgLVMn
IGR1bXAsDQo+Pg0KPj4gwqAgcjIgPSAxMDANCj4+IMKgIGNhbGwgNDUNCj4+IMKgIGlmIHIwIHM8
IDAgZ290byArNA0KPj4gwqAgcjQgPSAqKHUzMiAqKShyNyArIDApDQo+Pg0KPj4gQnV0IGZyb20g
ZHVtcCB4bGF0ZQ0KPj4NCj4+IMKgwqAgKGI3KSByMiA9IDEwMA0KPj4gwqDCoCAoODUpIGNhbGwg
YnBmX3Byb2JlX3JlYWRfY29tcGF0X3N0ciMtOTY3NjgNCj4+IMKgwqAgKDYxKSByNCA9ICoodTMy
ICopKHI3ICswKcKgIDwtLSBkcm9wcGVkIGlmIGdvdG8NCj4+DQo+PiBEdWUgdG8gdmVyaWZpZXIg
c3RhdGUgYWZ0ZXIgY2FsbCBiZWluZw0KPj4NCj4+IMKgIFIwPWludihpZD0wLHVtYXhfdmFsdWU9
MTAwLHZhcl9vZmY9KDB4MDsgMHg3ZikpDQo+Pg0KPj4gVG8gZml4IG9taXQgc2V0dGluZyB0aGUg
dW1heCB2YWx1ZSBiZWNhdXNlIGl0cyBub3Qgc2FmZS4gVGhlIG9ubHkNCj4+IGFjdHVhbCBib3Vu
ZHMgd2Uga25vdyBpcyB0aGUgc21heC4gVGhpcyByZXN1bHRzIGluIHRoZSBjb3JyZWN0IGJvdW5k
cw0KPj4gKFNNSU4sIFgpIHdoZXJlIFggaXMgdGhlIG1heCBsZW5ndGggZnJvbSB0aGUgaGVscGVy
LiBBZnRlciB0aGlzIHRoZQ0KPj4gbmV3IHZlcmlmaWVyIHN0YXRlIGxvb2tzIGxpa2UgdGhlIGZv
bGxvd2luZyBhZnRlciBjYWxsIDQ1Lg0KPj4NCj4+IFIwPWludihpZD0wLHNtYXhfdmFsdWU9MTAw
KQ0KPj4NCj4+IFRoZW4geGxhdGVkIHZlcnNpb24gbm8gbG9uZ2VyIHJlbW92ZWQgZGVhZCBjb2Rl
IGdpdmluZyB0aGUgZXhwZWN0ZWQNCj4+IHJlc3VsdCwNCj4+DQo+PiDCoMKgIChiNykgcjIgPSAx
MDANCj4+IMKgwqAgKDg1KSBjYWxsIGJwZl9wcm9iZV9yZWFkX2NvbXBhdF9zdHIjLTk2NzY4DQo+
PiDCoMKgIChjNSkgaWYgcjAgczwgMHgwIGdvdG8gcGMrNA0KPj4gwqDCoCAoNjEpIHI0ID0gKih1
MzIgKikocjcgKzApDQo+Pg0KPj4gTm90ZSwgYnBmX3Byb2JlX3JlYWRfKiBjYWxscyBhcmUgcm9v
dCBvbmx5IHNvIHdlIHdvbnQgaGl0IHRoaXMgY2FzZQ0KPj4gd2l0aCBub24tcm9vdCBicGYgdXNl
cnMuDQo+Pg0KPj4gRml4ZXM6IDg0OWZhNTA2NjJmYmMgKCJicGY6IHZlcmlmaWVyLCByZWZpbmUg
Ym91bmRzIG1heSBjbGFtcCB1bWluIHRvIA0KPj4gMCBpbmNvcnJlY3RseSIpDQo+PiBTaWduZWQt
b2ZmLWJ5OiBKb2huIEZhc3RhYmVuZCA8am9obi5mYXN0YWJlbmRAZ21haWwuY29tPg0KPiANCj4g
QmVlbiByZXZpZXdpbmcgdGhpcyBmaXggaW50ZXJuYWxseSwgdGhlcmVmb3JlIGFsc286DQo+IA0K
PiBSZXZpZXdlZC1ieTogRGFuaWVsIEJvcmttYW5uIDxkYW5pZWxAaW9nZWFyYm94Lm5ldD4NCj4g
DQo+IFN0aWxsIHdhaXRpbmcgdG8gZ2l2ZSBZb25naG9uZyBhIGNoYW5jZSB0byB0YWtlIGEgbG9v
ayBhcyB3ZWxsIGJlZm9yZSANCj4gYXBwbHlpbmcNCj4gYW5kIGdldHRpbmcgYnBmIFBSIG91dCAo
c2hvdWxkIGJlIHJvdWdobHkgaW4gbW9ybmluZyBVUyB0aW1lKS4NCg0KVGhlIGNoYW5nZSBtYWtl
cyBzZW5zZSB0byBtZS4gVGhhbmtzIQ0KQWNrZWQtYnk6IFlvbmdob25nIFNvbmcgPHloc0BmYi5j
b20+DQoNCg==
