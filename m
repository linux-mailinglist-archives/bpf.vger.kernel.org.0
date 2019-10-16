Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29EB8D99A8
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2019 21:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436672AbfJPTEF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Oct 2019 15:04:05 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:14664 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2436666AbfJPTEF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 16 Oct 2019 15:04:05 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x9GIqgnZ002460;
        Wed, 16 Oct 2019 12:04:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=DgZiXA9R77LpN8e7dgIiH94rgW7Z8Tt7Nd1Q9GGpV44=;
 b=We14e5vINxpBr/ZFQULyyCAHPriQPMi6mgE3NO8ajIJb4X5ST8uyITygDrtTuwV7xrf7
 lwKgsoTzKrPKy+R9As4iLsHgrKm6kBifZFY2KnYiWMDncaZe4vWQIoTi/dRnBiW/R2pD
 KjVocULivZ1ko4uECpZOf/LKbxef3YUFZfk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2vp8epg63r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 16 Oct 2019 12:04:02 -0700
Received: from ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) by
 ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 16 Oct 2019 12:04:01 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 16 Oct 2019 12:04:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWuAtCeoBOUK5fnhpjKycTuyY0kFhujjMP456dVcTEL6LLyLHxdhnOoIQWFTDhJwKD6vh4cv2heo/7Dj7QttaqEHlIkq1FJNvK/Mw2ebnodNqNFgPvLi7Zk2II2pbFRVyY/5MxWZ96njMFiOytb+X/A9XsjYvM/crlDC/uQtl6G7dTG0rGjUotj12f43ow1bWjXP4bN/vc3xy97ZwXGp8xNXVoyqF1nXSJVNn7eY+Esh3yBfV5io4X5SsO7+zmAMckQJNSb0xROZ9QbE7MbIgD9mHCPGIun2vqDKux58UtdY1ccq4Yi48gmwy0b+9wiolT382fHuW42bie7kZB2TwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgZiXA9R77LpN8e7dgIiH94rgW7Z8Tt7Nd1Q9GGpV44=;
 b=WpEgWTRC0O4sm6UdgYfNUgLn3m1eZK4m7grb+nKqdeT4iDuk+YKAnS2+vgwfJM2FN4mNAhL4oh1Zny/H4fo9X7iKiLp5y0j4i20P/Kucqgyd+QyPW3cdILRhH3S6pO7rRVjef4Srng73Fl9fuA+6Vddw9ej0x1KjDVylc+QhplqAoVmN4oBrCgm6I82xjm7920dtnE2ys1fOJbUOiHvMtuoLGzj3eurfUIE3H5LyoArJw4rPJQ3EBwhqiLMTLNo6l6ZWdGyyEuLwvP6lmK6KDchopnXEpALFC+g4Zxk2w5dGZaclIKYCF1TdC7JvJnBe77RKBy8zVNumGp5StX2QBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgZiXA9R77LpN8e7dgIiH94rgW7Z8Tt7Nd1Q9GGpV44=;
 b=NMJb5SsdSljYQ0+5tGSopQTcojzltpuSbd2hNTnBwsex0I4ULCu26Z6SJzjgPpwPaxMWNg4BusGd8bhX7/aR7zCMx8b7ex7Xz9DPu9I0/YtNtKP9ogmjV4/m7yLbNxf9KcToHC/U7z2OAJXViPFkr3PEvjKoCEqw5Q0FW6HjtSQ=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.60.27) by
 BYAPR15MB2919.namprd15.prod.outlook.com (20.178.239.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 16 Oct 2019 19:04:00 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::b92c:ebd2:58dc:6b8d]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::b92c:ebd2:58dc:6b8d%5]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 19:04:00 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Jiong Wang <jiong.wang@netronome.com>
CC:     "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "oss-drivers@netronome.com" <oss-drivers@netronome.com>
Subject: Re: [LLVM PATCH] bpf: fix wrong truncation elimination when there is
 back-edge/loop
Thread-Topic: [LLVM PATCH] bpf: fix wrong truncation elimination when there is
 back-edge/loop
Thread-Index: AQHVgM1h/vL3bQ0fZUKDV2iofaXBJadbAnsAgAB7joCAAe5pgIAAOt4A
Date:   Wed, 16 Oct 2019 19:03:59 +0000
Message-ID: <e12b61aa-9348-60a5-8948-517bf8781d6c@fb.com>
References: <1570864740-16857-1-git-send-email-jiong.wang@netronome.com>
 <4bcc6709-cbdf-fbdc-7e5f-103a1160d05a@fb.com>
 <1rvepbpe.fsf@cbtest28.netronome.com> <4l08k8n8.fsf@cbtest28.netronome.com>
In-Reply-To: <4l08k8n8.fsf@cbtest28.netronome.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR10CA0071.namprd10.prod.outlook.com
 (2603:10b6:300:2c::33) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:112::27)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::b533]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1ed5682-d47a-44c9-c8ec-08d7526b9a1c
x-ms-traffictypediagnostic: BYAPR15MB2919:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR15MB2919D650DF78A162F60963E4D3920@BYAPR15MB2919.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(376002)(39860400002)(396003)(346002)(51914003)(199004)(189003)(6512007)(6246003)(6506007)(76176011)(6306002)(31686004)(966005)(99286004)(478600001)(102836004)(14454004)(52116002)(4326008)(6916009)(2906002)(316002)(54906003)(5660300002)(6116002)(25786009)(71190400001)(71200400001)(386003)(53546011)(36756003)(11346002)(8676002)(31696002)(8936002)(6486002)(2616005)(46003)(476003)(186003)(81166006)(486006)(81156014)(256004)(14444005)(66446008)(66946007)(305945005)(7736002)(64756008)(66556008)(86362001)(66476007)(229853002)(6436002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2919;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SS8z2rNtgA1jV00eNmM/O4vsDNtVBVwKtPhu58KrqZnAYOQ34k3x2mDDbvQpbPZFmlUyuGPFIZ1MY3VxotL20zLYWwgeaG3d4+xpbdGZo2hTVH7RQ6vjgQKfPDbGILMDafkeFD7RYFE53dzX/EUKKb5GjYsD8YSHBixwzlyA55NwTBWVHbnPKIWkAsEDp3qH3xCSFd/q8BH0He0KgnGi3XRuhzmtVNCajk5GzPTwq5EDOQOu5N5+fXSPSX0impw328ymfyrFFCkhRA27sOk56OOpfQWUeCuQZ1y76fVtZ5YecR5PMOPlA7DymQkpATKWghsGVXEZaMR0gehezVmPp2kQ2AuWEjl/IK9KDaNie2CZd4YoKH1CgV+x6SjxirLP9YU0e6NjHkclctdWtKl2ZrIecHcJBFj7JDLqJJqR53fkq9RDPlNtoS7d9n4YZvBQBNnuDKuN9jw0KdMK2qj/tQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <026FBC5A42914E45B55FD4794CAAEAF0@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ed5682-d47a-44c9-c8ec-08d7526b9a1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 19:04:00.0058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qWu5hj1AR2X5RqlEwQLiQ4y3FxYu2Q2wKQEdC6m2BWeKGgHPkPQzWfcfJx3EIZj4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2919
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-16_07:2019-10-16,2019-10-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=782 lowpriorityscore=0 impostorscore=0
 suspectscore=0 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910160154
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDEwLzE2LzE5IDg6MzMgQU0sIEppb25nIFdhbmcgd3JvdGU6DQo+IA0KPiBKaW9uZyBX
YW5nIHdyaXRlczoNCj4gDQo+PiBZb25naG9uZyBTb25nIHdyaXRlczoNCj4+DQo+Pj4gT24gMTAv
MTIvMTkgMTI6MTggQU0sIEppb25nIFdhbmcgd3JvdGU6DQo+Pj4+IEN1cnJlbnRseSwgQlBGIGJh
Y2tlbmQgaXMgZG9pbmcgdHJ1bmNhdGlvbiBlbGltaW5hdGlvbi4gSWYgb25lIHRydW5jYXRpb24N
Cj4+Pj4gaXMgcGVyZm9ybWVkIG9uIGEgdmFsdWUgZGVmaW5lZCBieSBuYXJyb3cgbG9hZHMsIHRo
ZW4gaXQgY291bGQgYmUgcmVkdW5kYW50DQo+Pj4+IGdpdmVuIEJQRiBsb2FkcyB6ZXJvIGV4dGVu
ZCB0aGUgZGVzdGluYXRpb24gcmVnaXN0ZXIgaW1wbGljaXRseS4NCj4+Pj4NCj4+Pj4gV2hlbiB0
aGUgZGVmaW5pdGlvbiBvZiB0aGUgdHJ1bmNhdGVkIHZhbHVlIGlzIGEgbWVyZ2luZyB2YWx1ZSAo
UEhJIG5vZGUpDQo+Pj4+IHRoYXQgY291bGQgY29tZSBmcm9tIGRpZmZlcmVudCBjb2RlIHBhdGhz
LCB0aGVuIGNoZWNrcyBuZWVkIHRvIGJlIGRvbmUgb24NCj4+Pj4gYWxsIHBvc3NpYmxlIGNvZGUg
cGF0aHMuDQo+Pj4+DQo+Pj4+IEFib3ZlIGRlc2NyaWJlZCBvcHRpbWl6YXRpb24gd2FzIGludHJv
ZHVjZWQgYXMgcjMwNjY4NSwgaG93ZXZlciBpdCBkb2Vzbid0DQo+Pj4+IHdvcmsgd2hlbiB0aGVy
ZSBpcyBiYWNrLWVkZ2UsIGZvciBleGFtcGxlIHdoZW4gbG9vcCBpcyB1c2VkIGluc2lkZSBCUEYN
Cj4+Pj4gY29kZS4NCj4+Pj4NCj4+Pj4gRm9yIGV4YW1wbGUgZm9yIHRoZSBmb2xsb3dpbmcgY29k
ZSwgYSB6ZXJvLWV4dGVuZGVkIHZhbHVlIHNob3VsZCBiZSBzdG9yZWQNCj4+Pj4gaW50byBiW2ld
LCBidXQgdGhlICJhbmQgcmVnLCAweGZmZmYiIGlzIHdyb25nbHkgZWxpbWluYXRlZCB3aGljaCB0
aGVuDQo+Pj4+IGdlbmVyYXRlcyBjb3JydXB0ZWQgZGF0YS4NCj4+Pj4NCj4+Pj4gdm9pZCBjYWwx
KHVuc2lnbmVkIHNob3J0ICphLCB1bnNpZ25lZCBsb25nICpiLCB1bnNpZ25lZCBpbnQgaykNCj4+
Pj4gew0KPj4+PiAgICAgdW5zaWduZWQgc2hvcnQgZTsNCj4+Pj4NCj4+Pj4gICAgIGUgPSAqYTsN
Cj4+Pj4gICAgIGZvciAodW5zaWduZWQgaW50IGkgPSAwOyBpIDwgazsgaSsrKSB7DQo+Pj4+ICAg
ICAgIGJbaV0gPSBlOw0KPj4+PiAgICAgICBlID0gfmU7DQo+Pj4+ICAgICB9DQo+Pj4+IH0NCj4+
Pj4NCj4+Pj4gVGhlIHJlYXNvbiBpcyByMzA2Njg1IHdhcyB0cnlpbmcgdG8gZG8gdGhlIFBISSBu
b2RlIGNoZWNrcyBpbnNpZGUgaXNlbA0KPj4+PiBEQUcyREFHIHBoYXNlLCBhbmQgdGhlIGNoZWNr
cyBhcmUgZG9uZSBvbiBNYWNoaW5lSW5zdHIuIFRoaXMgaXMgYWN0dWFsbHkNCj4+Pj4gd3Jvbmcs
IGJlY2F1c2UgTWFjaGluZUluc3RyIGlzIGJlaW5nIGJ1aWx0IGR1cmluZyBpc2VsIHBoYXNlIGFu
ZCB0aGUNCj4+Pj4gYXNzb2NpYXRlZCBpbmZvcm1hdGlvbiBpcyBub3QgY29tcGxldGVkIHlldC4g
QSBxdWljayBzZWFyY2ggc2hvd3Mgbm9uZQ0KPj4+PiB0YXJnZXQgb3RoZXIgdGhhbiBCUEYgaXMg
YWNjZXNzIE1hY2hpbmVJbnN0ciBpbmZvIGR1cmluZyBpc2VsIHBoYXNlLg0KPj4+Pg0KPj4+PiBG
b3IgYW4gUEhJIG5vZGUsIHdoZW4geW91IHJlYWNoZWQgaXQgZHVyaW5nIGlzZWwgcGhhc2UsIGl0
IG1heSBoYXZlIGFsbA0KPj4+PiBwcmVkZWNlc3NvcnMgbGlua2VkLCBidXQgbm90IHN1Y2Nlc3Nv
cnMuIEl0IHNlZW1zIHN1Y2Nlc3NvcnMgYXJlIGxpbmtlZCB0bw0KPj4+PiBQSEkgbm9kZSBvbmx5
IHdoZW4gZG9pbmcgU2VsZWN0aW9uREFHSVNlbDo6RmluaXNoQmFzaWNCbG9jayBhbmQgdGhpcw0K
Pj4+PiBoYXBwZW5zIGxhdGVyIHRoYW4gUHJlcHJvY2Vzc0lTZWxEQUcgaG9vay4NCj4+Pj4NCj4+
Pj4gUHJldmlvdXNseSwgQlBGIHByb2dyYW0gZG9lc24ndCBhbGxvdyBsb29wLCB0aGVyZSBpcyBw
cm9iYWJseSB0aGUgcmVhc29uDQo+Pj4+IHdoeSB0aGlzIGJ1ZyB3YXMgbm90IGV4cG9zZWQuDQo+
Pj4+DQo+Pj4+IFRoaXMgcGF0Y2ggdGhlcmVmb3JlIGZpeGVzIHRoZSBidWcgYnkgdGhlIGZvbGxv
d2luZyBhcHByb2FjaDoNCj4+Pj4gICAgLSBUaGUgZXhpc3RpbmcgdHJ1bmNhdGlvbiBlbGltaW5h
dGlvbiBjb2RlIGFuZCB0aGUgYXNzb2NpYXRlZA0KPj4+PiAgICAgICJsb2FkX3RvX3ZyZWdfIiBy
ZWNvcmRzIGFyZSByZW1vdmVkLg0KPj4+PiAgICAtIEluc3RlYWQsIGltcGxlbWVudCB0cnVuY2F0
aW9uIGVsaW1pbmF0aW9uIHVzaW5nIE1hY2hpbmVTU0EgcGFzcywgdGhpcw0KPj4+PiAgICAgIGlz
IHdoZXJlIGFsbCBpbmZvcm1hdGlvbiBhcmUgYnVpbHQsIGFuZCBrZWVwIHRoZSBwYXNzIHRvZ2V0
aGVyIHdpdGggb3RoZXINCj4+Pj4gICAgICBzaW1pbGFyIHBlZXBob2xlIG9wdGltaXphdGlvbnMg
aW5zaWRlIEJQRk1JUGVlcGhvbGUuY3BwLiBSZWR1bmRhbnQgbW92ZQ0KPj4+PiAgICAgIGVsaW1p
bmF0aW9uIGxvZ2ljIGlzIHVwZGF0ZWQgYWNjb3JkaW5nbHkuDQo+Pj4+ICAgIC0gVW5pdCB0ZXN0
Y2FzZSBpbmNsdWRlZCArIG5vIGNvbXBpbGF0aW9uIGVycm9ycyBmb3Iga2VybmVsIEJQRiBzZWxm
dGVzdC4NCj4+Pg0KPj4+IFRoYW5rcyBmb3IgdGhlIGZpeC4gVGhlIGNvZGUgbG9va3MgZ29vZC4g
SnVzdCB0d28gbWlub3IgY29tbWVudHMuDQo+Pg0KPj4gVGhhbmtzIFlvbmdob25nLiBZb3VyIGNv
bW1lbnRzIG1ha2Ugc2Vuc2UgdG8gbWUsIHdpbGwgZml4IHRoZW0uDQo+Pg0KPj4+IEFmdGVyIHRo
ZSBmaXgsIGNvdWxkIHlvdSBkaXJlY3RseSBwdXNoIHRvIHRoZSBsbHZtIHJlcG8/DQo+Pg0KPj4g
U3VyZSB3aWxsIGRvLg0KPj4NCj4+IChBbmQgSSB3aWxsIHVwZGF0ZSBteSBsbHZtIGFjY291bnQg
ZW1haWwgZmlyc3QsIHNob3VsZCBiZSBxdWljaywgaWYgaXQgdGFrZXMNCj4+IHRvbyBsb25nIHdp
bGwgY29tZSBiYWNrIHRvIHlvdSBmb3IgY29tbWl0dGluZyBoZWxwKQ0KPiANCj4gRml4IHB1c2hl
ZCBhZnRlciB0d28gbWlub3IgY29tbWVudHMgYWRkcmVzc2VkIGFuZCByZS11bml0LXRlc3RlZDoN
Cj4gDQo+ICAgIGh0dHBzOi8vZ2l0aHViLmNvbS9sbHZtL2xsdm0tcHJvamVjdC9jb21taXQvZWM1
MTg1MTAyNmE1NWUxY2ZjN2YwMDZmMGU3NWYwYTE5YWNiMzJkMw0KDQpUaGFua3MhDQo=
