Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB0B9B2C36
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2019 18:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfINQ05 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 14 Sep 2019 12:26:57 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37068 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727407AbfINQ04 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 14 Sep 2019 12:26:56 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8EGP8MX005112;
        Sat, 14 Sep 2019 09:26:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=YrLozyZ/83r6CyMrhYTfK9FFakO/9jzTWrqm9GxKPtA=;
 b=CaTApnU5FB0FFqUa3CLzj1v6K1gtGKLg5Vqt2LS4+cHj3bjbJaLTxKpCNkeTFoWtHp9l
 mq8+armj6U4dtAUKe0mzNfLl/KDGqlixPDFQ0jlYLGqSI4bQE+p1BnpidhrGX/EAfJvJ
 KLDYcsXwufmF7z6iLYn03GEuz1VZMpbdlY4= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2v0uhcs5g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 14 Sep 2019 09:26:09 -0700
Received: from prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Sat, 14 Sep 2019 09:26:09 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Sat, 14 Sep 2019 09:26:08 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Sat, 14 Sep 2019 09:26:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SxPQ1wc72Xjq2Tefx4xYEA9F+bTb6ZElImnKU+0GeGcp43Y9IssDBRU06rAmfOQPAPS7aS+ZqnYrvYr+3LfZ/1fOE+e4qbztD8+jKw+cNlZVBEO/0nfJ2raKXhgZSkYL8bmnQX3lK6ZM1IcpJK45bMJvdqB0GAG7fWgpDkzG1a5sWFxHhm3jaL8KqafFgHxv4T83EZEZW6/Wb+b3EfOb2g5TMOmpx4/1PMhcGRqS94kDycpe+KbilKto6o3GI+lOLb2qrsCtiEbgUMr+H2rwyfjcWmLmj24CfOCIhUbr+TT/+ubUWP8hVFDNjYDE/TLw1STW0Re027spLE7IIllPRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrLozyZ/83r6CyMrhYTfK9FFakO/9jzTWrqm9GxKPtA=;
 b=jCEvLcvbHwtC5oV3oNRPfTCjUM337jmh+U0gGljcHVONzh3nSWz6HPO7NwFQcR1m5MZwFcsO7Fkj0v7lhHllIqR/+02EDk5ILBzTAqf2T2LKevHDxI2CykVIQZiFalOlkNPH3+vvztXr5NjE1p1hoH9zgCL5OiHBge+hyE5ncqrebzlzEH0Hdl62IdRYGhQGDYBvJBsnsNndpxSgcO3mCEWv2l67PjzVWHsb3ksb1ZN8uQrLLtBlo2cwhPrSEFPx2FsYPXGvLYnMe6Cy5jRUO+TZvL7L2k+c4wlculCF7mQsR+CAFpkn6JUN9zj5NdxnsPqC28KZdRVj6JkayHwzcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrLozyZ/83r6CyMrhYTfK9FFakO/9jzTWrqm9GxKPtA=;
 b=T/uv3GDSJ1YcL7dxI4WkzXLTiK6E2pc5t7JLvWW3D2Pgha9ltRE5XKcax06mC52qFBmTosWBcnIlUUoZ3Sa58jEZ4bMMkLz7Eoce/Dj5u10qKFQl4Lae4sSs7RaeuRsK68tBr/vuNz5iCTxpixH3+OYk1s1zMZjrS4Nhea/kkvE=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.60.27) by
 BYAPR15MB2328.namprd15.prod.outlook.com (52.135.197.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.23; Sat, 14 Sep 2019 16:26:07 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::95ab:61a0:29f4:e07e]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::95ab:61a0:29f4:e07e%6]) with mapi id 15.20.2263.021; Sat, 14 Sep 2019
 16:26:07 +0000
From:   Yonghong Song <yhs@fb.com>
To:     KP Singh <kpsingh@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        "Michael Halcrow" <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "Andrey Ignatov" <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: Re: [RFC v1 05/14] krsi: Initialize KRSI hooks and create files in
 securityfs
Thread-Topic: [RFC v1 05/14] krsi: Initialize KRSI hooks and create files in
 securityfs
Thread-Index: AQHVZ87VulD+roYrOEGjatJtlFoEF6crYpIA
Date:   Sat, 14 Sep 2019 16:26:07 +0000
Message-ID: <1638d88d-e4ab-d08e-e15f-f7086e72c796@fb.com>
References: <20190910115527.5235-1-kpsingh@chromium.org>
 <20190910115527.5235-6-kpsingh@chromium.org>
In-Reply-To: <20190910115527.5235-6-kpsingh@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR14CA0066.namprd14.prod.outlook.com
 (2603:10b6:300:81::28) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:112::27)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::9917]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 129f2ef4-2472-4585-ba2a-08d739303e92
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB2328;
x-ms-traffictypediagnostic: BYAPR15MB2328:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB23288BE7DE4D4564D4E6119ED3B20@BYAPR15MB2328.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01604FB62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(346002)(366004)(39860400002)(199004)(189003)(478600001)(14454004)(71190400001)(31696002)(71200400001)(36756003)(4326008)(25786009)(5660300002)(52116002)(76176011)(7416002)(2201001)(7736002)(305945005)(99286004)(102836004)(186003)(46003)(86362001)(6506007)(53546011)(446003)(11346002)(2616005)(476003)(386003)(6486002)(66946007)(66446008)(64756008)(66556008)(66476007)(486006)(229853002)(15650500001)(6116002)(6436002)(2906002)(2501003)(5024004)(316002)(110136005)(54906003)(53936002)(6246003)(31686004)(8676002)(8936002)(81156014)(6512007)(256004)(14444005)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2328;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: icMepugiUre86qc+LLMrQum7uje5gBU6zs7TaynKZ7cENhgK+CJ+zcuFvdjvbmHx8IQMwM9HcXY+b+NfrKu8qRJgqLOHFNB09InnTVhj1QoNpVwTAK55Evojv9kyZfFOukAC8HbCkeC+hZ4W0BKQhVM6zrw7cfCqw++lZb/our7YEL0diBZIHkVK+RVvgsjybok98kJjRT48SnAkZNQJGuqJYwCTZJZLGwNJhPGrI30XDGCzacB8MJbdzMfosC6W5h/KpyC3am1X4MB4CnBxZF275xiArvIU5AgJ7QtnguL/P9QsWm9mAEPnwzToDz2wZz4zb2WW7u0bW3yPbgQIdSo/stOXLURBeeO2CpvEie6rlWR4mlisDo8t8o8+F0pN7pObfirAuoie7/kdN1ZMnVW94slSpRNY+PDfiF2Ilws=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D70A72A2EF1F264D844A9DEFE6FDDC46@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 129f2ef4-2472-4585-ba2a-08d739303e92
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2019 16:26:07.0699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dl/YF+zQV2xnZw5ypi8L52KoiJ4iheJ/VohKKczox6wBWejlo5IQya30jDgWmaL5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2328
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-14_05:2019-09-11,2019-09-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909140174
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDkvMTAvMTkgMTI6NTUgUE0sIEtQIFNpbmdoIHdyb3RlOg0KPiBGcm9tOiBLUCBTaW5n
aCA8a3BzaW5naEBnb29nbGUuY29tPg0KPiANCj4gVGhlIExTTSBjcmVhdGVzIGZpbGVzIGluIHNl
Y3VyaXR5ZnMgZm9yIGVhY2ggaG9vayByZWdpc3RlcmVkIHdpdGggdGhlDQo+IExTTS4NCj4gDQo+
ICAgICAgL3N5cy9rZXJuZWwvc2VjdXJpdHkvYnBmLzxoX25hbWU+DQo+IA0KPiBUaGUgaW5pdGlh
bGl6YXRpb24gb2YgdGhlIGhvb2tzIGlzIGRvbmUgY29sbGVjdGl2ZWx5IGluIGFuIGludGVybmFs
DQo+IGhlYWRlciAiaG9va3MuaCIgd2hpY2ggcmVzdWx0cyBpbjoNCj4gDQo+ICogQ3JlYXRpb24g
b2YgYSBmaWxlIGZvciB0aGUgaG9vayBpbiB0aGUgc2VjdXJpdHlmcy4NCj4gKiBBbGxvY2F0aW9u
IG9mIGEga3JzaV9ob29rIGRhdGEgc3RydWN0dXJlIHdoaWNoIHN0b3JlcyBhIHBvaW50ZXIgdG8g
dGhlDQo+ICAgIGRlbnRyeSBvZiB0aGUgbmV3bHkgY3JlYXRlZCBmaWxlIGluIHNlY3VyaXR5ZnMu
DQo+ICogQSBwb2ludGVyIHRvIHRoZSBrcnNpX2hvb2sgZGF0YSBzdHJ1Y3R1cmUgaXMgc3RvcmVk
IGluIHRoZSBwcml2YXRlDQo+ICAgIGRfZnNkYXRhIG9mIGRlbnRyeSBvZiB0aGUgZmlsZSBjcmVh
dGVkIGluIHNlY3VyaXR5RlMuDQo+IA0KPiBUaGVzZSBmaWxlcyB3aWxsIGxhdGVyIGJlIHVzZWQg
dG8gc3BlY2lmeSBhbiBhdHRhY2htZW50IHRhcmdldCBkdXJpbmcNCj4gQlBGX1BST0dfTE9BRC4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtQIFNpbmdoIDxrcHNpbmdoQGdvb2dsZS5jb20+DQo+IC0t
LQ0KPiAgIHNlY3VyaXR5L2tyc2kvTWFrZWZpbGUgICAgICAgICAgICB8ICA0ICstDQo+ICAgc2Vj
dXJpdHkva3JzaS9pbmNsdWRlL2hvb2tzLmggICAgIHwgMjEgKysrKysrKysNCj4gICBzZWN1cml0
eS9rcnNpL2luY2x1ZGUva3JzaV9mcy5oICAgfCAxOSArKysrKysrDQo+ICAgc2VjdXJpdHkva3Jz
aS9pbmNsdWRlL2tyc2lfaW5pdC5oIHwgNDUgKysrKysrKysrKysrKysrKw0KPiAgIHNlY3VyaXR5
L2tyc2kva3JzaS5jICAgICAgICAgICAgICB8IDE2ICsrKysrLQ0KPiAgIHNlY3VyaXR5L2tyc2kv
a3JzaV9mcy5jICAgICAgICAgICB8IDg4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gICA2IGZpbGVzIGNoYW5nZWQsIDE5MSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0K
PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBzZWN1cml0eS9rcnNpL2luY2x1ZGUvaG9va3MuaA0KPiAg
IGNyZWF0ZSBtb2RlIDEwMDY0NCBzZWN1cml0eS9rcnNpL2luY2x1ZGUva3JzaV9mcy5oDQo+ICAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IHNlY3VyaXR5L2tyc2kvaW5jbHVkZS9rcnNpX2luaXQuaA0KPiAg
IGNyZWF0ZSBtb2RlIDEwMDY0NCBzZWN1cml0eS9rcnNpL2tyc2lfZnMuYw0KPiANCj4gZGlmZiAt
LWdpdCBhL3NlY3VyaXR5L2tyc2kvTWFrZWZpbGUgYi9zZWN1cml0eS9rcnNpL01ha2VmaWxlDQo+
IGluZGV4IDY2MGNjMWY0MjJmZC4uNDU4NjI0MWYxNmUxIDEwMDY0NA0KPiAtLS0gYS9zZWN1cml0
eS9rcnNpL01ha2VmaWxlDQo+ICsrKyBiL3NlY3VyaXR5L2tyc2kvTWFrZWZpbGUNCj4gQEAgLTEg
KzEsMyBAQA0KPiAtb2JqLSQoQ09ORklHX1NFQ1VSSVRZX0tSU0kpIDo9IGtyc2kubyBvcHMubw0K
PiArb2JqLSQoQ09ORklHX1NFQ1VSSVRZX0tSU0kpIDo9IGtyc2kubyBrcnNpX2ZzLm8gb3BzLm8N
Cj4gKw0KPiArY2NmbGFncy15IDo9IC1JJChzcmN0cmVlKS9zZWN1cml0eS9rcnNpIC1JJChzcmN0
cmVlKS9zZWN1cml0eS9rcnNpL2luY2x1ZGUNCj4gZGlmZiAtLWdpdCBhL3NlY3VyaXR5L2tyc2kv
aW5jbHVkZS9ob29rcy5oIGIvc2VjdXJpdHkva3JzaS9pbmNsdWRlL2hvb2tzLmgNCj4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAwLi5lMDcwYzQ1MmI1ZGUNCj4gLS0t
IC9kZXYvbnVsbA0KPiArKysgYi9zZWN1cml0eS9rcnNpL2luY2x1ZGUvaG9va3MuaA0KPiBAQCAt
MCwwICsxLDIxIEBADQo+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCAqLw0K
PiArDQo+ICsvKg0KPiArICogVGhlIGhvb2tzIGZvciB0aGUgS1JTSSBMU00gYXJlIGRlY2xhcmVk
IGluIHRoaXMgZmlsZS4NCj4gKyAqDQo+ICsgKiBUaGlzIGhlYWRlciBNVVNUIE5PVCBiZSBpbmNs
dWRlZCBkaXJlY3RseSBhbmQgc2hvdWxkDQo+ICsgKiBiZSBvbmx5IHVzZWQgdG8gaW5pdGlhbGl6
ZSB0aGUgaG9va3MgbGlzdHMuDQo+ICsgKg0KPiArICogRm9ybWF0Og0KPiArICoNCj4gKyAqICAg
S1JTSV9IT09LX0lOSVQoVFlQRSwgTkFNRSwgTFNNX0hPT0ssIEtSU0lfSE9PS19GTikNCj4gKyAq
DQo+ICsgKiBLUlNJIGFkZHMgb25lIGxheWVyIG9mIGluZGlyZWN0aW9uIGJldHdlZW4gdGhlIG5h
bWUgb2YgdGhlIGhvb2sgYW5kIHRoZSBuYW1lDQo+ICsgKiBpdCBleHBvc2VzIHRvIHRoZSB1c2Vy
c3BhY2UgaW4gU2VjdXJpdHkgRlMgdG8gcHJldmVudCB0aGUgdXNlcnNwYWNlIGZyb20NCj4gKyAq
IGJyZWFraW5nIGluIGNhc2UgdGhlIG5hbWUgb2YgdGhlIGhvb2sgY2hhbmdlcyBpbiB0aGUga2Vy
bmVsIG9yIGlmIHRoZXJlJ3MNCj4gKyAqIGFub3RoZXIgTFNNIGhvb2sgdGhhdCBtYXBzIGJldHRl
ciB0byB0aGUgcmVwcmVzZW50ZWQgc2VjdXJpdHkgYmVoYXZpb3VyLg0KPiArICovDQo+ICtLUlNJ
X0hPT0tfSU5JVChQUk9DRVNTX0VYRUNVVElPTiwNCj4gKwkgICAgICAgcHJvY2Vzc19leGVjdXRp
b24sDQo+ICsJICAgICAgIGJwcm1fY2hlY2tfc2VjdXJpdHksDQo+ICsJICAgICAgIGtyc2lfcHJv
Y2Vzc19leGVjdXRpb24pDQo+IGRpZmYgLS1naXQgYS9zZWN1cml0eS9rcnNpL2luY2x1ZGUva3Jz
aV9mcy5oIGIvc2VjdXJpdHkva3JzaS9pbmNsdWRlL2tyc2lfZnMuaA0KPiBuZXcgZmlsZSBtb2Rl
IDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLjM4MTM0NjYxZDhkNg0KPiAtLS0gL2Rldi9u
dWxsDQo+ICsrKyBiL3NlY3VyaXR5L2tyc2kvaW5jbHVkZS9rcnNpX2ZzLmgNCj4gQEAgLTAsMCAr
MSwxOSBAQA0KPiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgKi8NCj4gKw0K
PiArI2lmbmRlZiBfS1JTSV9GU19IDQo+ICsjZGVmaW5lIF9LUlNJX0ZTX0gNCj4gKw0KPiArI2lu
Y2x1ZGUgPGxpbnV4L2JwZi5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L2ZzLmg+DQo+ICsjaW5jbHVk
ZSA8bGludXgvdHlwZXMuaD4NCj4gKw0KPiArYm9vbCBpc19rcnNpX2hvb2tfZmlsZShzdHJ1Y3Qg
ZmlsZSAqZik7DQo+ICsNCj4gKy8qDQo+ICsgKiBUaGUgbmFtZSBvZiB0aGUgZGlyZWN0b3J5IGNy
ZWF0ZWQgaW4gc2VjdXJpdHlmcw0KPiArICoNCj4gKyAqCS9zeXMva2VybmVsL3NlY3VyaXR5Lzxk
aXJfbmFtZT4NCj4gKyAqLw0KPiArI2RlZmluZSBLUlNJX1NGU19OQU1FICJrcnNpIg0KPiArDQo+
ICsjZW5kaWYgLyogX0tSU0lfRlNfSCAqLw0KPiBkaWZmIC0tZ2l0IGEvc2VjdXJpdHkva3JzaS9p
bmNsdWRlL2tyc2lfaW5pdC5oIGIvc2VjdXJpdHkva3JzaS9pbmNsdWRlL2tyc2lfaW5pdC5oDQo+
IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uNjg3NTUxODJhMDMx
DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvc2VjdXJpdHkva3JzaS9pbmNsdWRlL2tyc2lfaW5p
dC5oDQo+IEBAIC0wLDAgKzEsNDUgQEANCj4gKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wICovDQo+ICsNCj4gKyNpZm5kZWYgX0tSU0lfSU5JVF9IDQo+ICsjZGVmaW5lIF9LUlNJ
X0lOSVRfSA0KPiArDQo+ICsjaW5jbHVkZSAia3JzaV9mcy5oIg0KPiArDQo+ICtlbnVtIGtyc2lf
aG9va190eXBlIHsNCj4gKwlQUk9DRVNTX0VYRUNVVElPTiwNCj4gKwlfX01BWF9LUlNJX0hPT0tf
VFlQRSwgLyogZGVsaW1pdGVyICovDQo+ICt9Ow0KPiArDQo+ICtleHRlcm4gaW50IGtyc2lfZnNf
aW5pdGlhbGl6ZWQ7DQo+ICsvKg0KPiArICogVGhlIExTTSBjcmVhdGVzIG9uZSBmaWxlIHBlciBo
b29rLg0KPiArICoNCj4gKyAqIEEgcG9pbnRlciB0byBrcnNpX2hvb2sgZGF0YSBzdHJ1Y3R1cmUg
aXMgc3RvcmVkIGluIHRoZQ0KPiArICogcHJpdmF0ZSBmc2RhdGEgb2YgdGhlIGRlbnRyeSBvZiB0
aGUgcGVyLWhvb2sgZmlsZSBjcmVhdGVkDQo+ICsgKiBpbiBzZWN1cml0eWZzLg0KPiArICovDQo+
ICtzdHJ1Y3Qga3JzaV9ob29rIHsNCj4gKwkvKg0KPiArCSAqIFRoZSBuYW1lIG9mIHRoZSBzZWN1
cml0eSBob29rLCBhIGZpbGUgd2l0aCB0aGlzIG5hbWUgd2lsbCBiZSBjcmVhdGVkDQo+ICsJICog
aW4gdGhlIHNlY3VyaXR5ZnMuDQo+ICsJICovDQo+ICsJY29uc3QgY2hhciAqbmFtZTsNCj4gKwkv
Kg0KPiArCSAqIFRoZSB0eXBlIG9mIHRoZSBMU00gaG9vaywgdGhlIExTTSB1c2VzIHRoaXMgdG8g
aW5kZXggdGhlIGxpc3Qgb2YgdGhlDQo+ICsJICogaG9va3MgdG8gcnVuIHRoZSBlQlBGIHByb2dy
YW1zIHRoYXQgbWF5IGhhdmUgYmVlbiBhdHRhY2hlZC4NCj4gKwkgKi8NCj4gKwllbnVtIGtyc2lf
aG9va190eXBlIGhfdHlwZTsNCj4gKwkvKg0KPiArCSAqIFRoZSBkZW50cnkgb2YgdGhlIGZpbGUg
Y3JlYXRlZCBpbiBzZWN1cml0eWZzLg0KPiArCSAqLw0KPiArCXN0cnVjdCBkZW50cnkgKmhfZGVu
dHJ5Ow0KPiArfTsNCj4gKw0KPiArZXh0ZXJuIHN0cnVjdCBrcnNpX2hvb2sga3JzaV9ob29rc19s
aXN0W107DQo+ICsNCj4gKyNkZWZpbmUga3JzaV9mb3JfZWFjaF9ob29rKGhvb2spIFwNCj4gKwlm
b3IgKChob29rKSA9ICZrcnNpX2hvb2tzX2xpc3RbMF07IFwNCj4gKwkgICAgIChob29rKSA8ICZr
cnNpX2hvb2tzX2xpc3RbX19NQVhfS1JTSV9IT09LX1RZUEVdOyBcDQo+ICsJICAgICAoaG9vaykr
KykNCj4gKw0KPiArI2VuZGlmIC8qIF9LUlNJX0lOSVRfSCAqLw0KPiBkaWZmIC0tZ2l0IGEvc2Vj
dXJpdHkva3JzaS9rcnNpLmMgYi9zZWN1cml0eS9rcnNpL2tyc2kuYw0KPiBpbmRleCA5Y2U0ZjU2
ZmI3OGQuLjc3ZDdlMmY5MTE3MiAxMDA2NDQNCj4gLS0tIGEvc2VjdXJpdHkva3JzaS9rcnNpLmMN
Cj4gKysrIGIvc2VjdXJpdHkva3JzaS9rcnNpLmMNCj4gQEAgLTIsMTMgKzIsMjcgQEANCj4gICAN
Cj4gICAjaW5jbHVkZSA8bGludXgvbHNtX2hvb2tzLmg+DQo+ICAgDQo+ICsjaW5jbHVkZSAia3Jz
aV9pbml0LmgiDQo+ICsNCj4gK3N0cnVjdCBrcnNpX2hvb2sga3JzaV9ob29rc19saXN0W10gPSB7
DQo+ICsJI2RlZmluZSBLUlNJX0hPT0tfSU5JVChUWVBFLCBOQU1FLCBILCBJKSBcDQo+ICsJCVtU
WVBFXSA9IHsgXA0KPiArCQkJLmhfdHlwZSA9IFRZUEUsIFwNCj4gKwkJCS5uYW1lID0gI05BTUUs
IFwNCj4gKwkJfSwNCj4gKwkjaW5jbHVkZSAiaG9va3MuaCINCj4gKwkjdW5kZWYgS1JTSV9IT09L
X0lOSVQNCj4gK307DQo+ICsNCj4gICBzdGF0aWMgaW50IGtyc2lfcHJvY2Vzc19leGVjdXRpb24o
c3RydWN0IGxpbnV4X2JpbnBybSAqYnBybSkNCj4gICB7DQo+ICAgCXJldHVybiAwOw0KPiAgIH0N
Cj4gICANCj4gICBzdGF0aWMgc3RydWN0IHNlY3VyaXR5X2hvb2tfbGlzdCBrcnNpX2hvb2tzW10g
X19sc21fcm9fYWZ0ZXJfaW5pdCA9IHsNCj4gLQlMU01fSE9PS19JTklUKGJwcm1fY2hlY2tfc2Vj
dXJpdHksIGtyc2lfcHJvY2Vzc19leGVjdXRpb24pLA0KPiArCSNkZWZpbmUgS1JTSV9IT09LX0lO
SVQoVCwgTiwgSE9PSywgSU1QTCkgTFNNX0hPT0tfSU5JVChIT09LLCBJTVBMKSwNCj4gKwkjaW5j
bHVkZSAiaG9va3MuaCINCj4gKwkjdW5kZWYgS1JTSV9IT09LX0lOSVQNCj4gICB9Ow0KPiAgIA0K
PiAgIHN0YXRpYyBpbnQgX19pbml0IGtyc2lfaW5pdCh2b2lkKQ0KPiBkaWZmIC0tZ2l0IGEvc2Vj
dXJpdHkva3JzaS9rcnNpX2ZzLmMgYi9zZWN1cml0eS9rcnNpL2tyc2lfZnMuYw0KPiBuZXcgZmls
ZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLjYwNGY4MjZjZWU1Yw0KPiAtLS0g
L2Rldi9udWxsDQo+ICsrKyBiL3NlY3VyaXR5L2tyc2kva3JzaV9mcy5jDQo+IEBAIC0wLDAgKzEs
ODggQEANCj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ICsNCj4gKyNp
bmNsdWRlIDxsaW51eC9lcnIuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9pbml0Lmg+DQo+ICsjaW5j
bHVkZSA8bGludXgvZmlsZS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L2ZzLmg+DQo+ICsjaW5jbHVk
ZSA8bGludXgvdHlwZXMuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9zZWN1cml0eS5oPg0KPiArDQo+
ICsjaW5jbHVkZSAia3JzaV9mcy5oIg0KPiArI2luY2x1ZGUgImtyc2lfaW5pdC5oIg0KPiArDQo+
ICtleHRlcm4gc3RydWN0IGtyc2lfaG9vayBrcnNpX2hvb2tzX2xpc3RbXTsNCj4gKw0KPiArc3Rh
dGljIHN0cnVjdCBkZW50cnkgKmtyc2lfZGlyOw0KPiArDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0
IGZpbGVfb3BlcmF0aW9ucyBrcnNpX2hvb2tfb3BzID0gew0KPiArCS5sbHNlZWsgPSBnZW5lcmlj
X2ZpbGVfbGxzZWVrLA0KPiArfTsNCj4gKw0KPiAraW50IGtyc2lfZnNfaW5pdGlhbGl6ZWQ7DQo+
ICsNCj4gK2Jvb2wgaXNfa3JzaV9ob29rX2ZpbGUoc3RydWN0IGZpbGUgKmYpDQo+ICt7DQo+ICsJ
cmV0dXJuIGYtPmZfb3AgPT0gJmtyc2lfaG9va19vcHM7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2
b2lkIF9faW5pdCBrcnNpX2ZyZWVfaG9vayhzdHJ1Y3Qga3JzaV9ob29rICpoKQ0KPiArew0KPiAr
CXNlY3VyaXR5ZnNfcmVtb3ZlKGgtPmhfZGVudHJ5KTsNCj4gKwloLT5oX2RlbnRyeSA9IE5VTEw7
DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgX19pbml0IGtyc2lfaW5pdF9ob29rKHN0cnVjdCBr
cnNpX2hvb2sgKmgsIHN0cnVjdCBkZW50cnkgKnBhcmVudCkNCj4gK3sNCj4gKwlzdHJ1Y3QgZGVu
dHJ5ICpoX2RlbnRyeTsNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICsJaF9kZW50cnkgPSBzZWN1cml0
eWZzX2NyZWF0ZV9maWxlKGgtPm5hbWUsIDA2MDAsIHBhcmVudCwNCj4gKwkJCU5VTEwsICZrcnNp
X2hvb2tfb3BzKTsNCj4gKw0KPiArCWlmIChJU19FUlIoaF9kZW50cnkpKQ0KPiArCQlyZXR1cm4g
UFRSX0VSUihoX2RlbnRyeSk7DQo+ICsJaF9kZW50cnktPmRfZnNkYXRhID0gaDsNCj4gKwloLT5o
X2RlbnRyeSA9IGhfZGVudHJ5Ow0KPiArCXJldHVybiAwOw0KPiArDQo+ICtlcnJvcjoNCg0KVGhl
ICdlcnJvcicgbGFiZWwgaXMgbm90IHVzZWQgaGVyZS4NCg0KPiArCXNlY3VyaXR5ZnNfcmVtb3Zl
KGhfZGVudHJ5KTsNCj4gKwlyZXR1cm4gcmV0Ow0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IF9f
aW5pdCBrcnNpX2ZzX2luaXQodm9pZCkNCj4gK3sNCj4gKw0KPiArCXN0cnVjdCBrcnNpX2hvb2sg
Kmhvb2s7DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCWtyc2lfZGlyID0gc2VjdXJpdHlmc19jcmVh
dGVfZGlyKEtSU0lfU0ZTX05BTUUsIE5VTEwpOw0KPiArCWlmIChJU19FUlIoa3JzaV9kaXIpKSB7
DQo+ICsJCXJldCA9IFBUUl9FUlIoa3JzaV9kaXIpOw0KPiArCQlwcl9lcnIoIlVuYWJsZSB0byBj
cmVhdGUga3JzaSBzeXNmcyBkaXI6ICVkXG4iLCByZXQpOw0KPiArCQlrcnNpX2RpciA9IE5VTEw7
DQo+ICsJCXJldHVybiByZXQ7DQo+ICsJfQ0KPiArDQo+ICsJLyoNCj4gKwkgKiBJZiB0aGVyZSBp
cyBhbiBlcnJvciBpbiBpbml0aWFsaXppbmcgYSBob29rLCB0aGUgaW5pdGlhbGl6YXRpb24NCj4g
KwkgKiBsb2dpYyBtYWtlcyBzdXJlIHRoYXQgaXQgaGFzIGJlZW4gZnJlZWQsIGJ1dCB0aGlzIG1l
YW5zIHRoYXQNCj4gKwkgKiBjbGVhbnVwIHNob3VsZCBiZSBjYWxsZWQgZm9yIGFsbCB0aGUgb3Ro
ZXIgaG9va3MuIFRoZSBjbGVhbnVwDQo+ICsJICogbG9naWMgaGFuZGxlcyB1bmluaXRpYWxpemVk
IGRhdGEuDQo+ICsJICovDQo+ICsJa3JzaV9mb3JfZWFjaF9ob29rKGhvb2spIHsNCj4gKwkJcmV0
ID0ga3JzaV9pbml0X2hvb2soaG9vaywga3JzaV9kaXIpOw0KPiArCQlpZiAocmV0IDwgMCkNCj4g
KwkJCWdvdG8gZXJyb3I7DQo+ICsJfQ0KPiArDQo+ICsJa3JzaV9mc19pbml0aWFsaXplZCA9IDE7
DQo+ICsJcmV0dXJuIDA7DQo+ICtlcnJvcjoNCj4gKwlrcnNpX2Zvcl9lYWNoX2hvb2soaG9vaykN
Cj4gKwkJa3JzaV9mcmVlX2hvb2soaG9vayk7DQo+ICsJc2VjdXJpdHlmc19yZW1vdmUoa3JzaV9k
aXIpOw0KPiArCXJldHVybiByZXQ7DQo+ICt9DQo+ICsNCj4gK2xhdGVfaW5pdGNhbGwoa3JzaV9m
c19pbml0KTsNCj4gDQo=
