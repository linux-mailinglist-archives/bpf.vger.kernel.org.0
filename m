Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02053124F6D
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2019 18:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfLRRho (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Dec 2019 12:37:44 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:9064 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726960AbfLRRho (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 18 Dec 2019 12:37:44 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBIHYKQh025188;
        Wed, 18 Dec 2019 09:37:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=mQaC9IXXHPzR0zwCVX0z7bDrby56GCQzQoDkTa5l8p4=;
 b=pFpY+f8MZyXdQNjWgijO2TaH6yIPmmi1f25vMx5dq/as1FdxS08jjhZEUuAGOcPepXDO
 kZm7/AesQInbkCq0SspfuoH0Iio5nwZsenH7bmSraUinoXcKd+pWppYsfyMJH4bpT3q/
 9gXhZ91gcQFFhm2qwGREC645+xwAEjs3dLs= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2wy1qrp9yh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 18 Dec 2019 09:37:28 -0800
Received: from prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 18 Dec 2019 09:37:28 -0800
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 18 Dec 2019 09:37:27 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 18 Dec 2019 09:37:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnjON9mGPJw4ZaGxrCd+7oYV71T23reAwafhWdx06/jOix5n+JzHXoCumC0OSyMA1q9pibXEJ+F9kAFQmlwpfoDjL1uE1u9Do6j69zrTBL4gZpCzkqX8UCa8rFAMekfHw5de9UbOawMj+8+mhjqdykhkcRfXgIAdQX/VGzuVPejkQ34PNNvt3TgjNTS9xkMqJlgN3iiTvjtp1vKjCeDaAvcoj+iEOgSJxlk0P0HV+wlnE/pct/Ih7nPdLDXB34CTNqg4J8hjIBBhX4TsS+eyxYi9r2suQvpYBu2ZPWsp84YhuYwFXtJjG2dpvlhU9OTkZW8qCzpGC6YgLk4v//d7Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQaC9IXXHPzR0zwCVX0z7bDrby56GCQzQoDkTa5l8p4=;
 b=OWag1kQsB41QoUzO2UtjT0NStksYVcpGV4XPQqXwOdXeOkvCCjiQopeZGZAmkIZXA+D3K1P0ug8+TZ/72uRwEoOjAyYMXwBQ/Q+tJJTS8ufazznqDHs/mQA5melOf5gFuj9fdyNE93bsw6mI77NB2h3WCarT0+IrSm++Pd0F9r4uO665m7Yt8bzTq7mOW+JfCTf/ctE/hxF226NxUb9vsGC5o9Pnq5DcxwFxlcBGc5V7Wx3rTtTYA+wIwM2pXj5FxPMN13O3/cntAfp8USd/Vx+YVFoDd46vhW/IgNPATHYEEfZJecLrZ0IHoZFzknCw7mhZIQ3a9X5nxcwk+3dtAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQaC9IXXHPzR0zwCVX0z7bDrby56GCQzQoDkTa5l8p4=;
 b=hT3w22dWC5KNEhkTKrrrKGFYLcP3LkXAYZLjEGf4Y407QTcl2sb+GhGKJKiRzeDyrhlgXYxh0CrqxGgov2QOxxr5ZzSp6EOikwKxZN/vsrQESjVgY069iUohi8ROQ1MqNwc3kn+L9Ir4Q6c7IFL8UC/IQRTzJDLKg7R0H1846A8=
Received: from MWHPR15MB1294.namprd15.prod.outlook.com (10.175.3.150) by
 MWHPR15MB1278.namprd15.prod.outlook.com (10.175.3.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.13; Wed, 18 Dec 2019 17:37:26 +0000
Received: from MWHPR15MB1294.namprd15.prod.outlook.com
 ([fe80::5160:b3c0:bed1:e26c]) by MWHPR15MB1294.namprd15.prod.outlook.com
 ([fe80::5160:b3c0:bed1:e26c%10]) with mapi id 15.20.2559.012; Wed, 18 Dec
 2019 17:37:26 +0000
Received: from localhost (2620:10d:c090:180::7ec8) by MWHPR10CA0005.namprd10.prod.outlook.com (2603:10b6:301::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend Transport; Wed, 18 Dec 2019 17:37:25 +0000
From:   Andrey Ignatov <rdna@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 6/6] selftests/bpf: Cover BPF_F_REPLACE in
 test_cgroup_attach
Thread-Topic: [PATCH v2 bpf-next 6/6] selftests/bpf: Cover BPF_F_REPLACE in
 test_cgroup_attach
Thread-Index: AQHVsURuuxkAl3N4Lkm2i24iTPRS86e3o64AgAiCYgCAAAd+gIAAA4YA
Date:   Wed, 18 Dec 2019 17:37:26 +0000
Message-ID: <20191218173724.GA99035@rdna-mbp.dhcp.thefacebook.com>
References: <cover.1576193131.git.rdna@fb.com>
 <bc55a274ea572d237bd091819f38502fa837abb5.1576193131.git.rdna@fb.com>
 <CAEf4Bza7KU1r3iRuXiwL7AiOnEbNmxx_hsEUZL8up2OVtJX3XA@mail.gmail.com>
 <20191218165755.GA94162@rdna-mbp.dhcp.thefacebook.com>
 <CAEf4BzZJrXPgmHSuDr1QoW8uPu61HXRgxBGt=T-8kTiOCAUnBQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZJrXPgmHSuDr1QoW8uPu61HXRgxBGt=T-8kTiOCAUnBQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR10CA0005.namprd10.prod.outlook.com (2603:10b6:301::15)
 To MWHPR15MB1294.namprd15.prod.outlook.com (2603:10b6:320:25::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::7ec8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdc36a6e-923f-4d80-9bd2-08d783e0f27e
x-ms-traffictypediagnostic: MWHPR15MB1278:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB12783D7C62C09E5CC93503BFA8530@MWHPR15MB1278.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(376002)(136003)(346002)(189003)(199004)(16526019)(52116002)(186003)(53546011)(6496006)(6486002)(71200400001)(64756008)(66946007)(33656002)(6916009)(66476007)(4001150100001)(66446008)(66556008)(1076003)(5660300002)(86362001)(54906003)(8936002)(81166006)(81156014)(9686003)(8676002)(478600001)(2906002)(316002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1278;H:MWHPR15MB1294.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jHdTWsDq6+U6ZOn/TODAwnwhznsBkS5DzVijFf1MIlUCokCaCYVZyIyiMDKIZa6GC3UjHPFKl7rkq3eRlXXPyeebc+DYA2scJpTtk2UJE4NaTHn1yDeTcbovlaLF0/toi4movGGbyJPiXvacbbM53+oX6aElx5yX6cT5xL+hAlSBQwf3HVVUQBjPFwFegL7rQHC1msInm8k0nsWDnwQlYnPgIle+9jRobwx0YVhtepvbxAr78gdspKdsk1Jtu/kAwUCHLO++vaRUeqgzuRvqgdrLjvZSdt37jUXN+UphZs7fgYaydTe18pm4wRJ84DMA1dJk3Qu9DjOj7fK0nfaABu8cHfeqtEaEIh9lWqo2S93aNq9SOQkQcn18nOPeVDgPZMuuAsR1ziAW9qu5jQj2dlmhEwrJwopXRVygDN4DCi21Wi+0VfspWaM2G45NUO+U
Content-Type: text/plain; charset="utf-8"
Content-ID: <B79DED4E32B5404983A33AD9DCE75CF1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc36a6e-923f-4d80-9bd2-08d783e0f27e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 17:37:26.3259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0W/xosjJBYKp6Z5gSd9N0oawLK5i+xomUK/5DLIbYcftsPD7RGafRAAgw6c35Ylu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1278
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_05:2019-12-17,2019-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 mlxlogscore=999 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912180143
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

QW5kcmlpIE5ha3J5aWtvIDxhbmRyaWkubmFrcnlpa29AZ21haWwuY29tPiBbV2VkLCAyMDE5LTEy
LTE4IDA5OjI1IC0wODAwXToNCj4gT24gV2VkLCBEZWMgMTgsIDIwMTkgYXQgODo1OCBBTSBBbmRy
ZXkgSWduYXRvdiA8cmRuYUBmYi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gQW5kcmlpIE5ha3J5aWtv
IDxhbmRyaWkubmFrcnlpa29AZ21haWwuY29tPiBbVGh1LCAyMDE5LTEyLTEyIDIzOjAxIC0wODAw
XToNCj4gPiA+IE9uIFRodSwgRGVjIDEyLCAyMDE5IGF0IDM6MzQgUE0gQW5kcmV5IElnbmF0b3Yg
PHJkbmFAZmIuY29tPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gVGVzdCByZXBsYWNlbWVudCBv
ZiBhIGNncm91cC1icGYgcHJvZ3JhbSBhdHRhY2hlZCB3aXRoIEJQRl9GX0FMTE9XX01VTFRJDQo+
ID4gPiA+IGFuZCBwb3NzaWJsZSBmYWlsdXJlIG1vZGVzOiBpbnZhbGlkIGNvbWJpbmF0aW9uIG9m
IGZsYWdzLCBpbnZhbGlkDQo+ID4gPiA+IHJlcGxhY2VfYnBmX2ZkLCByZXBsYWNpbmcgYSBub24t
YXR0YWNoZCB0byBzcGVjaWZpZWQgY2dyb3VwIHByb2dyYW0uDQo+ID4gPiA+DQo+ID4gPiA+IEV4
YW1wbGUgb2YgcHJvZ3JhbSByZXBsYWNpbmc6DQo+ID4gPiA+DQo+ID4gPiA+ICAgIyBnZGIgLXEg
Li90ZXN0X2Nncm91cF9hdHRhY2gNCj4gPiA+ID4gICBSZWFkaW5nIHN5bWJvbHMgZnJvbSAvZGF0
YS91c2Vycy9yZG5hL2Jpbi90ZXN0X2Nncm91cF9hdHRhY2guLi5kb25lLg0KPiA+ID4gPiAgIC4u
Lg0KPiA+ID4gPiAgIEJyZWFrcG9pbnQgMSwgdGVzdF9tdWx0aXByb2cgKCkgYXQgdGVzdF9jZ3Jv
dXBfYXR0YWNoLmM6NDQzDQo+ID4gPiA+ICAgNDQzICAgICB0ZXN0X2Nncm91cF9hdHRhY2guYzog
Tm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeS4NCj4gPiA+ID4gICAoZ2RiKQ0KPiA+ID4gPiAgIFsy
XSsgIFN0b3BwZWQgICAgICAgICAgICAgICAgIGdkYiAtcSAuL3Rlc3RfY2dyb3VwX2F0dGFjaA0K
PiA+ID4gPiAgICMgYnBmdG9vbCBjIHMgL21udC9jZ3JvdXAyL2Nncm91cC10ZXN0LXdvcmstZGly
L2NnMQ0KPiA+ID4gPiAgIElEICAgICAgIEF0dGFjaFR5cGUgICAgICBBdHRhY2hGbGFncyAgICAg
TmFtZQ0KPiA+ID4gPiAgIDM1ICAgICAgIGVncmVzcyAgICAgICAgICBtdWx0aQ0KPiA+ID4gPiAg
IDM2ICAgICAgIGVncmVzcyAgICAgICAgICBtdWx0aQ0KPiA+ID4gPiAgICMgZmcgZ2RiIC1xIC4v
dGVzdF9jZ3JvdXBfYXR0YWNoDQo+ID4gPiA+ICAgYw0KPiA+ID4gPiAgIENvbnRpbnVpbmcuDQo+
ID4gPiA+ICAgRGV0YWNoaW5nIGFmdGVyIGZvcmsgZnJvbSBjaGlsZCBwcm9jZXNzIDM2MS4NCj4g
PiA+ID4NCj4gPiA+ID4gICBCcmVha3BvaW50IDIsIHRlc3RfbXVsdGlwcm9nICgpIGF0IHRlc3Rf
Y2dyb3VwX2F0dGFjaC5jOjQ1NA0KPiA+ID4gPiAgIDQ1NCAgICAgaW4gdGVzdF9jZ3JvdXBfYXR0
YWNoLmMNCj4gPiA+ID4gICAoZ2RiKQ0KPiA+ID4gPiAgIFsyXSsgIFN0b3BwZWQgICAgICAgICAg
ICAgICAgIGdkYiAtcSAuL3Rlc3RfY2dyb3VwX2F0dGFjaA0KPiA+ID4gPiAgICMgYnBmdG9vbCBj
IHMgL21udC9jZ3JvdXAyL2Nncm91cC10ZXN0LXdvcmstZGlyL2NnMQ0KPiA+ID4gPiAgIElEICAg
ICAgIEF0dGFjaFR5cGUgICAgICBBdHRhY2hGbGFncyAgICAgTmFtZQ0KPiA+ID4gPiAgIDQxICAg
ICAgIGVncmVzcyAgICAgICAgICBtdWx0aQ0KPiA+ID4gPiAgIDM2ICAgICAgIGVncmVzcyAgICAg
ICAgICBtdWx0aQ0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgSWduYXRv
diA8cmRuYUBmYi5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgLi4uL3NlbGZ0ZXN0cy9icGYv
dGVzdF9jZ3JvdXBfYXR0YWNoLmMgICAgICAgIHwgNjIgKysrKysrKysrKysrKysrKystLQ0KPiA+
ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDU3IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+
ID4gPiA+DQo+ID4gPg0KPiA+ID4gSSBzZWNvbmQgQWxleGVpJ3Mgc2VudGltZW50LiBIYXZpbmcg
dGhpcyBhcyBwYXJ0IG9mIHRlc3RfcHJvZ3Mgd291bGQNCj4gPiA+IGNlcnRhaW5seSBiZSBiZXR0
ZXIgaW4gdGVybXMgb2YgZW5zdXJpbmcgdGhpcyBkb2Vzbid0IGFjY2lkZW50YWxseQ0KPiA+ID4g
YnJlYWtzLg0KPiA+DQo+ID4gT0ssIEkgY29udmVydGVkIGJvdGggZXhpc3RpbmcgdGVzdF9jZ3Jv
dXBfYXR0YWNoIGFuZCBteSB0ZXN0IGZvcg0KPiA+IEJQRl9GX1JFUExBQ0UgdG8gdGVzdF9wcm9n
cyBhbmQgd2lsbCBzZW5kIHYzIHdpdGggdGhpcyBjaGFuZ2UuDQo+ID4NCj4gDQo+IEdyZWF0LCB0
aGFua3MhDQo+IA0KPiA+DQo+ID4gPiBbLi4uXQ0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gKyAg
ICAgICAvKiBpbnZhbGlkIGlucHV0ICovDQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICBERUNM
QVJFX0xJQkJQRl9PUFRTKGJwZl9wcm9nX2F0dGFjaF9vcHRzLCBhdHRhY2hfb3B0cywNCj4gPiA+
ID4gKyAgICAgICAgICAgICAgIC50YXJnZXRfZmQgICAgICAgICAgICAgID0gY2cxLA0KPiA+ID4g
PiArICAgICAgICAgICAgICAgLnByb2dfZmQgICAgICAgICAgICAgICAgPSBhbGxvd19wcm9nWzZd
LA0KPiA+ID4gPiArICAgICAgICAgICAgICAgLnJlcGxhY2VfcHJvZ19mZCAgICAgICAgPSBhbGxv
d19wcm9nWzBdLA0KPiA+ID4gPiArICAgICAgICAgICAgICAgLnR5cGUgICAgICAgICAgICAgICAg
ICAgPSBCUEZfQ0dST1VQX0lORVRfRUdSRVNTLA0KPiA+ID4gPiArICAgICAgICAgICAgICAgLmZs
YWdzICAgICAgICAgICAgICAgICAgPSBCUEZfRl9BTExPV19NVUxUSSB8IEJQRl9GX1JFUExBQ0Us
DQo+ID4gPiA+ICsgICAgICAgKTsNCj4gPiA+DQo+ID4gPiBUaGlzIG1pZ2h0IGNhdXNlIGNvbXBp
bGVyIHdhcm5pbmdzIChkZXBlbmRpbmcgb24gY29tcGlsZXIgc2V0dGluZ3MsIG9mDQo+ID4gPiBj
b3Vyc2UpLiBERUNMQVJFX0xJQkJQRl9PUFRTIGRvZXMgZGVjbGFyZSB2YXJpYWJsZSwgc28gdGhp
cyBpcyBhDQo+ID4gPiBzaXR1YXRpb24gb2YgbWl4aW5nIGNvZGUgYW5kIHZhcmlhYmxlIGRlY2xh
cmF0aW9ucywgd2hpY2ggdW5kZXIgQzg5DQo+ID4gPiAob3Igd2hhdGV2ZXIgaXQncyBuYW1lZCwg
dGhlIG9sZGVyIHN0YW5kYXJkIHRoYXQga2VybmVsIGlzIHRyeWluZyB0bw0KPiA+ID4gc3RpY2sg
dG8gZm9yIHRoZSBtb3N0IHBhcnQpIGlzIG5vdCBhbGxvd2VkLg0KPiA+DQo+ID4gWWVhaCwgSSBr
bm93IGFib3V0IHN1Y2ggYSB3YXJuaW5nIGFuZCBleHBlY3RlZCBpdCBidXQgZGlkbid0IGdldCBp
dCB3aXRoDQo+ID4gdGhlIGN1cnJlbnQgc2V0dXAgKHdoYXQgc3VycHJpc2VkIG1lIGJ0dykgYW5k
IGRlY2lkZWQgdG8ga2VlcCBpdC4NCj4gDQo+IHllYWgsIHNlbGZ0ZXN0cyBjb21waWxlciBmbGFn
cyBtdXN0IG5vdCBiZSBhcyBzdHJpY3QgYXMga2VybmVsJ3MsIEkgZ3Vlc3M/Li4uDQoNClRoYXQg
SSBkb24ndCBrbm93IDopIEkgdGhvdWdodCB0aGV5IHNob3VsZCBiZSBzaW1pbGFyIGJ1dCBhcHBh
cmVudGx5DQppdCdzIG5vdCB0aGUgY2FzZS4NCg0KPiA+IFRoZSBtYWluIHJlYXNvbiBJIGtlcHQg
aXQgaXMgaXQncyBub3QgYWN0dWFsbHkgY2xlYXIgaG93IHRvIHNlcGFyYXRlDQo+ID4gZGVjbGFy
YXRpb24gYW5kIGluaXRpYWxpemF0aW9uIG9mIG9wdHMgc3RydWN0dXJlIHdoZW4NCj4gPiBERUNM
QVJFX0xJQkJQRl9PUFRTIGlzIHVzZWQgc2luY2UgdGhlIG1hY3JvIGRvZXMgYm90aCB0aGluZ3Mg
YXQgb25jZS4gSW4NCj4gPiBzZWxmdGVzdHMgSSBjYW4ganVzdCBzd2l0Y2ggdG8gZGlyZWN0IGlu
aXRpYWxpemF0aW9uICh3L28gdGhlIG1hY3JvKQ0KPiA+IHNpbmNlIGxpYmJwZiBhbmQgc2VsZnRl
c3RzIGFyZSBpbiBzeW5jLCBidXQgZm9yIHJlYWwgdXNlLWNhc2VzIHRoZXJlDQo+ID4gc2hvdWxk
IGJlIHNtdGggZWxzZSAoZS5nLiBJTklUX0xJQkJQRl9PUFRTIG1hY3JvIHRoYXQgZG9lcyBvbmx5
DQo+ID4gaW5pdGlhbGl6YXRpb24gb2YgYWxyZWFkeSBkZWNsYXJlZCBzdHJ1Y3QpLg0KPiANCj4g
Rm9yIGNvbXBpbGVyLCBERUNMQVJFX0xJQkJQRl9PUFRTIGlzIHB1cmVseSBkZWNsYXJhdGlvbiwg
aW4gdGhlIHNhbWUNCj4gc2Vuc2UgYXMgc3RydWN0IGRlY2xhcmF0aW9uK2luaXRpYWxpemF0aW9u
IGlzIHN0aWxsIGp1c3QgZGVjbGFyYXRpb24uDQo+IElmIHlvdSBuZWVkIHRvIHBvc3Rwb25lIHNv
bWUgb2YgdGhlIGZpZWxkIGluaXRpYWxpemF0aW9uLCB0aGVuIHlvdSBjYW4NCj4gZG8gdGhhdCBi
eSBhc3NpbmdpbmcgdGhhdCBmaWVsZCBleHBsaWNpdGx5Og0KPiANCj4gREVDTEFSRV9MSUJCUEZf
T1BUUyhicGZfcHJvZ19hdHRhY2hfb3B0cywgYXR0YWNoX29wdHMsDQo+ICAgICAudGFyZ2V0X2Zk
ID0gY2dsLA0KPiApOw0KPiANCj4gDQo+IC4uLiBzb21lIGNvZGUgaGVyZSAuLi4NCj4gYXR0YWNo
X29wdHMucHJvZ19mZCA9IGFsbG93X3Byb2dbNl07DQo+IA0KPiBJdCBpcyBqdXN0IGEgc3RydWN0
LCBERUNMQVJFX0xJQkJQRl9PUFRTIGp1c3QgaGlkZXMgbWVtc2V0IHRvIDAgYW5kDQo+IHNldHRp
bmcgLnN6IGNvcnJlY3RseSwgbm90aGluZyBtb3JlLg0KDQpMb2wgdGhhdCBtYWtlcyBzZW5zZSBv
ZiBjb3Vyc2UuIEknbSBub3Qgc3VyZSB3aHkgSSBkZWNpZGVkIHRoYXQgYWxsDQpmaWVsZHMgc2hv
dWxkIGJlIHNwZWNpZmllZCBpbiBERUNMQVJFX0xJQkJQRl9PUFRTKCkgYXQgb25jZSAuLiBUaGFu
a3MhDQoNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIGF0dGFjaF9vcHRzLmZsYWdzID0gQlBG
X0ZfQUxMT1dfT1ZFUlJJREUgfCBCUEZfRl9SRVBMQUNFOw0KPiA+ID4gPiArICAgICAgIGlmICgh
YnBmX3Byb2dfYXR0YWNoX3hhdHRyKCZhdHRhY2hfb3B0cykpIHsNCj4gPiA+ID4gKyAgICAgICAg
ICAgICAgIGxvZ19lcnIoIlVuZXhwZWN0ZWQgc3VjY2VzcyB3aXRoIE9WRVJSSURFIHwgUkVQTEFD
RSIpOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgZ290byBlcnI7DQo+ID4gPiA+ICsgICAgICAg
fQ0KPiA+ID4gPiArICAgICAgIGFzc2VydChlcnJubyA9PSBFSU5WQUwpOw0KPiA+ID4gPiArDQo+
ID4NCj4gPiAtLQ0KPiA+IEFuZHJleSBJZ25hdG92DQoNCi0tIA0KQW5kcmV5IElnbmF0b3YNCg==
