Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B36D911E99C
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2019 19:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfLMSAb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Dec 2019 13:00:31 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:28258 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726404AbfLMSAa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 13 Dec 2019 13:00:30 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBDHuVCR014834;
        Fri, 13 Dec 2019 09:58:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=/KsHz8BakcDaPbeWPuKK74hMPfLsocegDzvyVSHk+f0=;
 b=HU6MV/Ic7AxzWCHP/XcU059RvVDQMmq5VR1L7Uo7RVbPPR/72WC9djnYhMDVgYhGZvCi
 K2WjXvptnNBBnRwjo0TU7/0Y38sCZ/+9F4SK8smank77OrKbDu3U8sQp59zFhCtTEGqp
 s1rzJ16JwS/ek9Oyf4tErp6bzBUE0KqeucU= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2wv2mek2bx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 13 Dec 2019 09:58:15 -0800
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 13 Dec 2019 09:58:14 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 13 Dec 2019 09:58:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnaVluP96Uq4rxd3UmQM70MNUnM/xoZjf0UlPX8UWidqGbxQhTk6yDGA5wGjRe0VDoLdCstT8aP7NRf88bfAUuga/5OATrNITjbkaIB9YURbzDDwBCuVlyNyQxNL6+eqtGo/ErlrSkXkMrqf1lhEe0m+teuAtdu2CyJdigKEVwTTXBZR5Gm7ZUrHp74PGrK2euts8kIObvDMKsnCPMXmNp7Tp7boXGr8LvLhZkjuo5Z2e/L0mSuhCeceSoS9BY0cDI+SRKRIfUJYVi69rwE9/XvkaX0RWcGiU7W0lDSqU1/d9jxqcrOUr2OTAqSKDSufZ3CZzSv+MHlgwzUYf1C7+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KsHz8BakcDaPbeWPuKK74hMPfLsocegDzvyVSHk+f0=;
 b=e8GqDzQJqEvodhnJ03cSfkUiVrBBr/LT0QoXw8i+/PB314c/j4hrNzg9GsT5ht9Z1jn0ZdQxq0dpdB+IzTi+gHd47JFQhny53Xv+drn4/NRuJOcgr6EVnUaa6hrWrwmpFOHt5HYbo6SXZw2aLGI9mcumEvBDdM/x40Ckc1znjxb0jZwZKAjBmSvDuJ9zzMIDX2ae8Bd0NGUxp4dZjBwPGfEsZ+QY2b8jQ2dIsLEPEOXkIf+NI7IHE1x05GiC1d5Htmp1+oLfRNZrp/H0749b8gTjtY6k9QCbZu/exUGBJsoXJCfsNi1bkL9zwMnRtOOcZRZAXIuLpEfpa5KO0EIQXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KsHz8BakcDaPbeWPuKK74hMPfLsocegDzvyVSHk+f0=;
 b=FqbWTit8jVjWOOMgAibVMOYXtiQlxBaN0JxixTJH3TQVu7IWSJFhoCYFYnzA/o7DirrgZpJvXhlUS2DBNuwp6Xmz1TOm2uZThQUh0sHia4fe/etXVkU/xcI5swZs621FzUc/gwI/DRVuFmtAJgtPJni1SHVpvXkise/v+0GQ2CE=
Received: from MWHPR15MB1294.namprd15.prod.outlook.com (10.175.3.150) by
 MWHPR15MB1696.namprd15.prod.outlook.com (10.175.135.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Fri, 13 Dec 2019 17:58:12 +0000
Received: from MWHPR15MB1294.namprd15.prod.outlook.com
 ([fe80::5160:b3c0:bed1:e26c]) by MWHPR15MB1294.namprd15.prod.outlook.com
 ([fe80::5160:b3c0:bed1:e26c%10]) with mapi id 15.20.2538.017; Fri, 13 Dec
 2019 17:58:12 +0000
From:   Andrey Ignatov <rdna@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 5/6] libbpf: Introduce bpf_prog_attach_xattr
Thread-Topic: [PATCH v2 bpf-next 5/6] libbpf: Introduce bpf_prog_attach_xattr
Thread-Index: AQHVsYKzTaxwU1H4KUulrEX7Yrlb/qe4Wr0A
Date:   Fri, 13 Dec 2019 17:58:12 +0000
Message-ID: <20191213175810.GA85689@rdna-mbp>
References: <cover.1576193131.git.rdna@fb.com>
 <364944f93a1d77eab769eeba79bb74122a688338.1576193131.git.rdna@fb.com>
 <CAEf4BzavGP6Aug4Jeg_MsxtgKyVDMGH6omoyMK=BvaAeW1QP3Q@mail.gmail.com>
In-Reply-To: <CAEf4BzavGP6Aug4Jeg_MsxtgKyVDMGH6omoyMK=BvaAeW1QP3Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0072.namprd19.prod.outlook.com
 (2603:10b6:300:94::34) To MWHPR15MB1294.namprd15.prod.outlook.com
 (2603:10b6:320:25::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::7920]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a543a9c-8b44-4891-a2b3-08d77ff60536
x-ms-traffictypediagnostic: MWHPR15MB1696:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB16968C06869CAF73C6A2E9FEA8540@MWHPR15MB1696.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0250B840C1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39860400002)(396003)(136003)(366004)(376002)(346002)(189003)(199004)(6506007)(53546011)(66476007)(66556008)(64756008)(66446008)(52116002)(66946007)(71200400001)(33656002)(186003)(86362001)(316002)(478600001)(6512007)(9686003)(5660300002)(54906003)(4326008)(6486002)(1076003)(81166006)(2906002)(4001150100001)(33716001)(6916009)(8936002)(8676002)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1696;H:MWHPR15MB1294.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uHAFj0339aCVB2/agNyzqu1hiAPVVZPL3qgEdchFmbXTuJQPVvJU0Te9pUyD2L2aHHKjH3f29p2E2zgvznHQki9PdCjct1NMsjgqm+o6YBIROCl4abo6CUOfeNfHGs/XnqsJIpavIWZTj/YJE8UHtslXRnSJRvJ5J97M1MiixjG/pEUxLaGwmIiB2hLeMGTghSD2yPM3rDjNY2ElcERhJzEagsMYXClFqnf7fxuG+dM8JxnPQXkVCReDhYmpfb+H2nVaJ72YFMQR30ykK2+7VFwJUFSfLbplV06EWD2va/Y4+O576M+17Bc54uDQhx3/jlC8dTyDUnbdI2E2F+B3bm8HYR0frb37jhYYD5c0sJRqvptbAWLvP2hPfpgl+qhyqJr3aze5P8cL3YuTYFNsiHQsb/5mMfIEj7uluvW0eVy8tA3EXgIix9Qv6i1q9Xi6
Content-Type: text/plain; charset="utf-8"
Content-ID: <18BD0D12DADF8743BEF32E3DA2F4D7DB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a543a9c-8b44-4891-a2b3-08d77ff60536
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2019 17:58:12.6721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JTB5Hf3ftOw9F+8/+YYIa4j/RxiR4r6Ca7krYmmZhheqFHDO3S8CDqvhcTDatoK9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1696
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-13_05:2019-12-13,2019-12-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 clxscore=1015 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912130142
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

QW5kcmlpIE5ha3J5aWtvIDxhbmRyaWkubmFrcnlpa29AZ21haWwuY29tPiBbVGh1LCAyMDE5LTEy
LTEyIDIyOjU4IC0wODAwXToNCj4gT24gVGh1LCBEZWMgMTIsIDIwMTkgYXQgMzozNCBQTSBBbmRy
ZXkgSWduYXRvdiA8cmRuYUBmYi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSW50cm9kdWNlIGEgbmV3
IGJwZl9wcm9nX2F0dGFjaF94YXR0ciBmdW5jdGlvbiB0aGF0IGFjY2VwdHMgYW4NCj4gPiBleHRl
bmRhYmxlIHN0cnVjdCBicGZfcHJvZ19hdHRhY2hfb3B0cyBhbmQgc3VwcG9ydHMgcGFzc2luZyBh
IG5ldw0KPiA+IGF0dHJpYnV0ZSB0byBCUEZfUFJPR19BVFRBQ0ggY29tbWFuZDogcmVwbGFjZV9w
cm9nX2ZkIHRoYXQgaXMgZmQgb2YNCj4gPiBwcmV2aW91c2x5IGF0dGFjaGVkIGNncm91cC1icGYg
cHJvZ3JhbSB0byByZXBsYWNlIGlmIHJlY2VudGx5IGludHJvZHVjZWQNCj4gPiBCUEZfRl9SRVBM
QUNFIGZsYWcgaXMgdXNlZC4NCj4gPg0KPiA+IFRoZSBuZXcgZnVuY3Rpb24gaXMgbmFtZWQgdG8g
YmUgY29uc2lzdGVudCB3aXRoIG90aGVyIHhhdHRyLWZ1bmN0aW9ucw0KPiA+IChicGZfcHJvZ190
ZXN0X3J1bl94YXR0ciwgYnBmX2NyZWF0ZV9tYXBfeGF0dHIsIGJwZl9sb2FkX3Byb2dyYW1feGF0
dHIpLg0KPiA+DQo+ID4gVGhlIHN0cnVjdCBicGZfcHJvZ19hdHRhY2hfb3B0cyBpcyBzdXBwb3Nl
ZCB0byBiZSB1c2VkIHdpdGgNCj4gPiBERUNMQVJFX0xJQkJQRl9PUFRTIGZyYW1ld29yay4NCj4g
Pg0KPiA+IFRoZSBvcHRzIGFyZ3VtZW50IGlzIHVzZWQgZGlyZWN0bHkgaW4gYnBmX3Byb2dfYXR0
YWNoX3hhdHRyDQo+ID4gaW1wbGVtZW50YXRpb24gc2luY2UgYXQgdGhlIHRpbWUgb2YgYWRkaW5n
IGFsbCBmaWVsZHMgYWxyZWFkeSBleGlzdCBpbg0KPiA+IHRoZSBrZXJuZWwuIE5ldyBmaWVsZHMs
IGlmIGFkZGVkLCB3aWxsIG5lZWQgdG8gYmUgdXNlZCB2aWEgT1BUU18qIG1hY3Jvcw0KPiA+IGZy
b20gbGliYnBmX2ludGVybmFsLmguDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgSWdu
YXRvdiA8cmRuYUBmYi5jb20+DQo+ID4gLS0tDQo+ID4gIHRvb2xzL2xpYi9icGYvYnBmLmMgICAg
ICB8IDIxICsrKysrKysrKysrKysrKysrLS0tLQ0KPiA+ICB0b29scy9saWIvYnBmL2JwZi5oICAg
ICAgfCAxMiArKysrKysrKysrKysNCj4gPiAgdG9vbHMvbGliL2JwZi9saWJicGYubWFwIHwgIDIg
KysNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL2xpYi9icGYvYnBmLmMgYi90b29scy9saWIv
YnBmL2JwZi5jDQo+ID4gaW5kZXggOTg1OTZlMTUzOTBmLi45ZjRlNDJhYmQxODUgMTAwNjQ0DQo+
ID4gLS0tIGEvdG9vbHMvbGliL2JwZi9icGYuYw0KPiA+ICsrKyBiL3Rvb2xzL2xpYi9icGYvYnBm
LmMNCj4gPiBAQCAtNDY2LDE0ICs0NjYsMjcgQEAgaW50IGJwZl9vYmpfZ2V0KGNvbnN0IGNoYXIg
KnBhdGhuYW1lKQ0KPiA+DQo+ID4gIGludCBicGZfcHJvZ19hdHRhY2goaW50IHByb2dfZmQsIGlu
dCB0YXJnZXRfZmQsIGVudW0gYnBmX2F0dGFjaF90eXBlIHR5cGUsDQo+ID4gICAgICAgICAgICAg
ICAgICAgICB1bnNpZ25lZCBpbnQgZmxhZ3MpDQo+ID4gK3sNCj4gPiArICAgICAgIERFQ0xBUkVf
TElCQlBGX09QVFMoYnBmX3Byb2dfYXR0YWNoX29wdHMsIG9wdHMsDQo+ID4gKyAgICAgICAgICAg
ICAgIC50YXJnZXRfZmQgPSB0YXJnZXRfZmQsDQo+ID4gKyAgICAgICAgICAgICAgIC5wcm9nX2Zk
ID0gcHJvZ19mZCwNCj4gPiArICAgICAgICAgICAgICAgLnR5cGUgPSB0eXBlLA0KPiA+ICsgICAg
ICAgICAgICAgICAuZmxhZ3MgPSBmbGFncywNCj4gPiArICAgICAgICk7DQo+ID4gKw0KPiA+ICsg
ICAgICAgcmV0dXJuIGJwZl9wcm9nX2F0dGFjaF94YXR0cigmb3B0cyk7DQo+ID4gK30NCj4gPiAr
DQo+ID4gK2ludCBicGZfcHJvZ19hdHRhY2hfeGF0dHIoY29uc3Qgc3RydWN0IGJwZl9wcm9nX2F0
dGFjaF9vcHRzICpvcHRzKQ0KPiANCj4gV2hlbiB3ZSBkaXNjdXNzZWQgdGhpcyB3aG9sZSBPUFRT
IGlkZWEsIHdlIGFncmVlZCB0aGF0IHNwZWNpZnlpbmcNCj4gbWFuZGF0b3J5IGFyZ3VtZW50cyBh
cyBpcyBtYWtlcyBmb3IgYmV0dGVyIHVzYWJpbGl0eS4gQWxsIHRoZSBvcHRpb25hbA0KPiBzdHVm
ZiB0aGVuIGlzIG1vdmVkIGludG8gb3B0cyAoYW5kIHRoZW4gZXh0ZW5kZWQgaW5kZWZpbml0ZWx5
LCBiZWNhdXNlDQo+IGFsbCB0aGUgbmV3bHkgYWRkZWQgc3R1ZmYgaGFzIHRvIGJlIG9wdGlvbmFs
LCBhdCBsZWFzdCBmb3Igc29tZSBzdWJzZXQNCj4gb2YgYXJndW1lbnRzKS4NCj4gDQo+IFNvIGlm
IHdlIHdlcmUgdG8gZm9sbG93IHRob3NlIHVub2ZmaWNpYWwgImd1aWRlbGluZXMiLA0KPiBicGZf
cHJvZ19hdHRhY2hfeGF0dHIgd291bGQgYmUgZGVmaW5lZCBhczoNCj4gDQo+IGludCBicGZfcHJv
Z19hdHRhY2hfeGF0dHIoaW50IHByb2dfZmQsIGludCB0YXJnZXRfZmQsIGVudW0gYnBmX2F0dGFj
aF90eXBlIHR5cGUsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0IGJw
Zl9wcm9nX2F0dGFjaF9vcHRzICpvcHRzKTsNCj4gDQo+ICwgd2hlcmUgb3B0cyBoYXMgZmxhZ3Mg
YW5kIHJlcGxhY2VfYnBmX2ZkIHJpZ2h0IG5vdy4NCg0KT2gsIEkgc2VlLCBJIHRoaW5rIEkgbWlz
c2VkIHRoZSAibWFuZGF0b3J5IHZzIG9wdGlvbmFsIiBwYXJ0IG9mIHlvdXINCmNvbW1lbnQgYW5k
IHRvb2sgb25seSB0aGUgInN3aXRjaGluZyB0byBvcHRpb25zIiBhcyB0aGUgbWFpbiBpZGVhLCBi
dXQNCm5vdyBJIHNlZSBpdC4gU29ycnkuDQoNClRob3VnaCB0aGlua2luZyBtb3JlIGFib3V0IGl0
LCBJJ20gbm90IHN1cmUgaXQnZCBidXkgdXMgbXVjaCBpbiB0aGlzDQpzcGVjaWZpYyBjYXNlLiAi
UmVxdWlyZWQiIGFyZ3VtZW50cyBhcmUgc2V0IGluIHN0b25lIGFuZCBjYW4ndCBiZQ0KY2hhbmdl
ZCwgYnV0IHRoZSBBUEkgYWxyZWFkeSBoYXMgYSB2ZXJzaW9uIG9mIGZ1bmN0aW9uIHdpdGggdGhp
cyBzYW1lDQpsaXN0IG9mIHJlcXVpcmVkIGFyZ3VtZW50czoNCg0KTElCQlBGX0FQSSBpbnQgYnBm
X3Byb2dfYXR0YWNoKGludCBwcm9nX2ZkLCBpbnQgYXR0YWNoYWJsZV9mZCwNCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBlbnVtIGJwZl9hdHRhY2hfdHlwZSB0eXBlLCB1bnNpZ25lZCBp
bnQgZmxhZ3MpOw0KDQpBcyBhIHVzZXIsIEknZCByYXRoZXIgdXNlIGJwZl9wcm9nX2F0dGFjaCgp
IGlmIEkgZG9uJ3QgbmVlZCBvcHRpb25hbA0KYXJndW1lbnRzICh3aGF0LCBhbHNvLCBoYXMgc2hv
cnRlZCBuYW1lKS4NCg0KQWRkaW5nIGFub3RoZXIgdmVyeSBzaW1pbGFyIG9uZSB3aXRoIHNhbWUg
bGlzdCBvZiBhcmd1bWVudHMgKyBvcHRpb25hbA0Kb25lcyB3b3VsZCBtYWtlIGl0IHNvIHRoYXQg
aXQnZCBuZXZlciBiZSB1c2VkIGluIHRoZSBjYXNlIHdoZW4gbm8NCm9wdGlvbmFsIGFyZ3VtZW50
cyBhcmUgbmVlZGVkLg0KDQpZZWFoLCBJIHNhdyB5b3UgY29tbWVudCBvbiB0aGUgZmxhZ3MsIGJ1
dCBmbGFncyBhcmUgbmVlZGVkIHF1aXRlIG9mdGVuDQoobm90IEJQRl9GX1JFUExBQ0UsIGJ1dCBC
UEZfRl9BTExPV19PVkVSUklERSBhbmQgQlBGX0ZfQUxMT1dfTVVMVEkpLA0Kc28gSSdtIG5vdCBz
dXJlIGFib3V0IG1vdmluZyBmbGFncyB0byBvcHRpb25hbC4NCg0KVGhlIGxhc3QgcG9pbnQgYnJp
bmdzIGFub3RoZXIgcG9pbnQgdGhhdCBzdWNoIGEgc2VwYXJhdGlvbiwgInJlcXVpcmVkIiAvDQoi
b3B0aW9uYWwiLCBtYXkgYmUgcXVpdGUgYmlhc2VkIGFjY29yZGluZyB0byB1c2UtY2FzZXMgdXNl
cnMgbW9zdGx5IGRlYWwNCndpdGggYW5kIG1heSBzdGFydCBtYWtpbmcgbGVzcyBzZW5zZSBvdmVy
IHRpbWUgd2hlbiBtb3JlIGFyZ3VtZW50cyBhcmUNCmFkZGVkIHRvIG9wdGlvbmFsIHRoYXQgYXJl
ICJoaWdobHkgcmVjb21tZW5kZWQgdG8gdXNlIi4NCg0KT24gdGhlIG90aGVyIGhhbmQgaWYgd2Ug
anVzdCBkbyBvbmUgc2luZ2xlIHN0cnVjdCBhcmd1bWVudCwgdGhlcmUgd29uJ3QNCmJlIHRoaXMg
cHJvYmxlbSBob3cgdG8gc2VwYXJhdGUgcmVxdWlyZWQgYW5kIG9wdGlvbmFsIHdodCBib3RoIHRo
ZQ0KY3VycmVudCBzZXQgb2YgYXJndW1lbnRzIGFuZCB3aGF0ZXZlciBpcyBhZGRlZCBpbiB0aGUg
ZnV0dXJlLg0KDQoNCj4gTmFtaW5nIHdpc2UsIGl0J3MgcXVpdGUgZGVwYXJ0dXJlIGZyb20geGF0
dHIgYXBwcm9hY2gsIHNvIEknZCBwcm9iYWJseQ0KPiB3b3VsZCBnbyB3aXRoIGJwZl9wcm9nX2F0
dGFjaF9vcHRzLCBidXQgSSB3b24ndCBpbnNpc3QuDQoNClllYWgsIGFncmVlIHRoYXQgaXQncyBu
b3QgcXVpdGUgInhhdHRyIi4gSSBkb24ndCBoYXZlIHN0cm9uZyBwcmVmZXJlbmNlcw0KaGVyZSwg
anVzdCB1c2VkIHRoZSBwcmVmaXggdGhhdCBpcyBhbHJlYWR5IHVzZWQgaW4gdGhlIEFQSS4gSSBj
YW4ndA0KcmVuYW1lIGl0IHRvIGJwZl9wcm9nX2F0dGFjaF9vcHRzIHRob3VnaCwgYmVjYXVzZSB0
aGVyZSBpcyBhIHN0cnVjdHVyZQ0Kd2l0aCB0aGUgc2FtZSBuYW1lIDopIGJ1dCBpZiB0aGVyZSBp
cyBhIGJldHRlciBuYW1lLCBoYXBweSB0byByZW5hbWUgaXQuDQpJIGhhZCBhbiBvcHRpb24gYnBm
X3Byb2dfYXR0YWNoMiAoc2ltaWxhciB0byBleGlzdGluZyBicGZfcHJvZ19kZXRhY2gyKQ0KYnV0
IElNTyBpdCdzIHdvcnNlLg0KDQoNCj4gV0RZVD8NCj4gDQo+ID4gIHsNCj4gPiAgICAgICAgIHVu
aW9uIGJwZl9hdHRyIGF0dHI7DQo+ID4NCj4gPiAgICAgICAgIG1lbXNldCgmYXR0ciwgMCwgc2l6
ZW9mKGF0dHIpKTsNCj4gPiAtICAgICAgIGF0dHIudGFyZ2V0X2ZkICAgICA9IHRhcmdldF9mZDsN
Cj4gPiAtICAgICAgIGF0dHIuYXR0YWNoX2JwZl9mZCA9IHByb2dfZmQ7DQo+ID4gLSAgICAgICBh
dHRyLmF0dGFjaF90eXBlICAgPSB0eXBlOw0KPiA+IC0gICAgICAgYXR0ci5hdHRhY2hfZmxhZ3Mg
ID0gZmxhZ3M7DQo+ID4gKyAgICAgICBhdHRyLnRhcmdldF9mZCAgICAgPSBvcHRzLT50YXJnZXRf
ZmQ7DQo+ID4gKyAgICAgICBhdHRyLmF0dGFjaF9icGZfZmQgPSBvcHRzLT5wcm9nX2ZkOw0KPiA+
ICsgICAgICAgYXR0ci5hdHRhY2hfdHlwZSAgID0gb3B0cy0+dHlwZTsNCj4gPiArICAgICAgIGF0
dHIuYXR0YWNoX2ZsYWdzICA9IG9wdHMtPmZsYWdzOw0KPiA+ICsgICAgICAgYXR0ci5yZXBsYWNl
X2JwZl9mZCA9IG9wdHMtPnJlcGxhY2VfcHJvZ19mZDsNCj4gPg0KPiA+ICAgICAgICAgcmV0dXJu
IHN5c19icGYoQlBGX1BST0dfQVRUQUNILCAmYXR0ciwgc2l6ZW9mKGF0dHIpKTsNCj4gPiAgfQ0K
PiA+IGRpZmYgLS1naXQgYS90b29scy9saWIvYnBmL2JwZi5oIGIvdG9vbHMvbGliL2JwZi9icGYu
aA0KPiA+IGluZGV4IDVjZmU2ZTBhMWFlZi4uNWI1ZjliMzc0MDc0IDEwMDY0NA0KPiA+IC0tLSBh
L3Rvb2xzL2xpYi9icGYvYnBmLmgNCj4gPiArKysgYi90b29scy9saWIvYnBmL2JwZi5oDQo+ID4g
QEAgLTE1MCw4ICsxNTAsMjAgQEAgTElCQlBGX0FQSSBpbnQgYnBmX21hcF9nZXRfbmV4dF9rZXko
aW50IGZkLCBjb25zdCB2b2lkICprZXksIHZvaWQgKm5leHRfa2V5KTsNCj4gPiAgTElCQlBGX0FQ
SSBpbnQgYnBmX21hcF9mcmVlemUoaW50IGZkKTsNCj4gPiAgTElCQlBGX0FQSSBpbnQgYnBmX29i
al9waW4oaW50IGZkLCBjb25zdCBjaGFyICpwYXRobmFtZSk7DQo+ID4gIExJQkJQRl9BUEkgaW50
IGJwZl9vYmpfZ2V0KGNvbnN0IGNoYXIgKnBhdGhuYW1lKTsNCj4gPiArDQo+ID4gK3N0cnVjdCBi
cGZfcHJvZ19hdHRhY2hfb3B0cyB7DQo+ID4gKyAgICAgICBzaXplX3Qgc3o7IC8qIHNpemUgb2Yg
dGhpcyBzdHJ1Y3QgZm9yIGZvcndhcmQvYmFja3dhcmQgY29tcGF0aWJpbGl0eSAqLw0KPiA+ICsg
ICAgICAgaW50IHRhcmdldF9mZDsNCj4gPiArICAgICAgIGludCBwcm9nX2ZkOw0KPiA+ICsgICAg
ICAgZW51bSBicGZfYXR0YWNoX3R5cGUgdHlwZTsNCj4gPiArICAgICAgIHVuc2lnbmVkIGludCBm
bGFnczsNCj4gPiArICAgICAgIGludCByZXBsYWNlX3Byb2dfZmQ7DQo+ID4gK307DQo+ID4gKyNk
ZWZpbmUgYnBmX3Byb2dfYXR0YWNoX29wdHNfX2xhc3RfZmllbGQgcmVwbGFjZV9wcm9nX2ZkDQo+
ID4gKw0KPiA+ICBMSUJCUEZfQVBJIGludCBicGZfcHJvZ19hdHRhY2goaW50IHByb2dfZmQsIGlu
dCBhdHRhY2hhYmxlX2ZkLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnVt
IGJwZl9hdHRhY2hfdHlwZSB0eXBlLCB1bnNpZ25lZCBpbnQgZmxhZ3MpOw0KPiA+ICtMSUJCUEZf
QVBJIGludCBicGZfcHJvZ19hdHRhY2hfeGF0dHIoY29uc3Qgc3RydWN0IGJwZl9wcm9nX2F0dGFj
aF9vcHRzICpvcHRzKTsNCj4gPiAgTElCQlBGX0FQSSBpbnQgYnBmX3Byb2dfZGV0YWNoKGludCBh
dHRhY2hhYmxlX2ZkLCBlbnVtIGJwZl9hdHRhY2hfdHlwZSB0eXBlKTsNCj4gPiAgTElCQlBGX0FQ
SSBpbnQgYnBmX3Byb2dfZGV0YWNoMihpbnQgcHJvZ19mZCwgaW50IGF0dGFjaGFibGVfZmQsDQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnVtIGJwZl9hdHRhY2hfdHlwZSB0
eXBlKTsNCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvbGliL2JwZi9saWJicGYubWFwIGIvdG9vbHMv
bGliL2JwZi9saWJicGYubWFwDQo+ID4gaW5kZXggNDk1ZGY1NzVmODdmLi40MmIwNjU0NTQwMzEg
MTAwNjQ0DQo+ID4gLS0tIGEvdG9vbHMvbGliL2JwZi9saWJicGYubWFwDQo+ID4gKysrIGIvdG9v
bHMvbGliL2JwZi9saWJicGYubWFwDQo+ID4gQEAgLTIxMCw0ICsyMTAsNiBAQCBMSUJCUEZfMC4w
LjYgew0KPiA+ICB9IExJQkJQRl8wLjAuNTsNCj4gPg0KPiA+ICBMSUJCUEZfMC4wLjcgew0KPiA+
ICsgICAgICAgZ2xvYmFsOg0KPiA+ICsgICAgICAgICAgICAgICBicGZfcHJvZ19hdHRhY2hfeGF0
dHI7DQo+ID4gIH0gTElCQlBGXzAuMC42Ow0KPiA+IC0tDQo+ID4gMi4xNy4xDQo+ID4NCg0KLS0g
DQpBbmRyZXkgSWduYXRvdg0K
