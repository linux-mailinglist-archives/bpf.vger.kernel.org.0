Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 801451473F5
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 23:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgAWWlo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 17:41:44 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46072 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726191AbgAWWlo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Jan 2020 17:41:44 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00NMfFGI006630;
        Thu, 23 Jan 2020 14:41:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=WgDCCD95g9oDou/8H+biSVaDnjhKRIUxjHy99aqnJpg=;
 b=oOxxgGZekykhlbi2aJDwTeVTiHc6IVIpcLQaV3A+4tDfXhKpMAmJPY7ap4ZAaRmHSwTT
 r2KrmkqCIpCPY47hrRYdoTCddJqdbSDyAtNDFwjSf9IC7I6nhbDqj3JmbACaqXlxENoO
 URgWHEe18ASfnx7xYqWSuj1nBbVvYO7JN64= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2xqgc5s7vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Jan 2020 14:41:18 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 23 Jan 2020 14:41:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kp8LEuqNSjgXa6NLKGF/WLwVG9lUEk4hVrRPJSuomlLLUjo+KYqYKq8tiaQFKdoQW0y4ZSK2klyDBL67r/cvJFG0XhzLgUFKu3VFEbKQa4h2AYcEtGyQ0wKi3ImtiEMCCxs5wUvnACSAxa13tfl31htDQ7KUXnP8nnWpaLDhcu1g9uSCjD9/A7PzNW0FkcGesGD7E/SFu2hC/dtJzqZtQLplDhXacCIBz9ikkhjOoSdPDgC+TAPBDAnoaDJDcC8me6DSWCXmBdtmuzuD9oNt0+fjuJG1U+7j/omfrtoeo+0o6GMN789Yx7eLsdcvAMEXRNDQCLBVdpyf9+gAcQM/6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgDCCD95g9oDou/8H+biSVaDnjhKRIUxjHy99aqnJpg=;
 b=RzsxEB1sUi2Aja+xGYjFSEp6UXLaTPA3M0x/FpLSqc+SzyNmkkECmIOPP+Vj5d0ts1/9PRMl9Q329Ah+UjxkBPw/BBcdd08kMBhxeTgbTjAFIfDudrGyZP61cq50shafpu6Jkomwmp8r8NwBIsVfXsXnWh9l48sx87I+BujMQ+rb2xMoaOcjmr2GgD352H+Bx2b7j6LZV4Yp50/v3qqISchfVpLPzfSkNCHFjLAY7UZD0p7JxXDzlMrKGMYeBtDxV/7u8Ksn7hNnAVS6HDT2JyRGslymNgFqkNIpmeVSmDob0DHWtZv2hc3ojTAz7M95/lqIBsp1k6LW2Th0CwynAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgDCCD95g9oDou/8H+biSVaDnjhKRIUxjHy99aqnJpg=;
 b=KEbKX24V3mRuqu2EnEcRrg2kcCIul0uSNsfdl5alXjyz7bjgSUZ4igHqkB/YMSIVu9r3vtIjcphe1tzWO6YeS9J+gFTaL5WtZF5/Gs4I4N0C4fRt0UhIRxVWA1qypfWFwE3o0DC3+d6qs0rWZjCOZ186bzbT15VxdFMF4aClDaI=
Received: from CY4PR15MB1304.namprd15.prod.outlook.com (10.172.181.135) by
 CY4PR15MB1718.namprd15.prod.outlook.com (10.174.53.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.19; Thu, 23 Jan 2020 22:41:16 +0000
Received: from CY4PR15MB1304.namprd15.prod.outlook.com
 ([fe80::d8e:7375:a261:6e38]) by CY4PR15MB1304.namprd15.prod.outlook.com
 ([fe80::d8e:7375:a261:6e38%5]) with mapi id 15.20.2644.028; Thu, 23 Jan 2020
 22:41:15 +0000
Received: from [IPv6:2620:10d:c083:1309:c13:c9a5:618e:9452] (2620:10d:c090:200::3:c5a1) by CO2PR05CA0099.namprd05.prod.outlook.com (2603:10b6:104:1::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.11 via Frontend Transport; Thu, 23 Jan 2020 22:41:14 +0000
From:   Andrii Nakryiko <andriin@fb.com>
To:     Daniel Xu <dxu@dxuuu.xyz>, Daniel Borkmann <daniel@iogearbox.net>,
        "John Fastabend" <john.fastabend@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>
Subject: Re: [PATCH v2 bpf-next 1/3] bpf: Add bpf_perf_prog_read_branches()
 helper
Thread-Topic: [PATCH v2 bpf-next 1/3] bpf: Add bpf_perf_prog_read_branches()
 helper
Thread-Index: AQHV0WHU5E2EEvFg5ECYtB9DS4fmraf3vCiAgADzN4CAACVegIAAAcsAgAADIoA=
Date:   Thu, 23 Jan 2020 22:41:15 +0000
Message-ID: <2b11467f-9d93-8109-4561-d25ac605ef10@fb.com>
References: <C03IYDPABSU1.1C6OL4DJ7ID1H@dlxu-fedora-R90QNFJV>
In-Reply-To: <C03IYDPABSU1.1C6OL4DJ7ID1H@dlxu-fedora-R90QNFJV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR05CA0099.namprd05.prod.outlook.com
 (2603:10b6:104:1::25) To CY4PR15MB1304.namprd15.prod.outlook.com
 (2603:10b6:903:113::7)
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:c5a1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e6eb7a4-3989-493c-6891-08d7a0555b00
x-ms-traffictypediagnostic: CY4PR15MB1718:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR15MB17189E06EB34255B54410E70C60F0@CY4PR15MB1718.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(376002)(136003)(39860400002)(189003)(199004)(52116002)(66556008)(36756003)(53546011)(66476007)(16526019)(6636002)(186003)(4326008)(2906002)(5660300002)(64756008)(66446008)(110136005)(54906003)(31686004)(66946007)(478600001)(31696002)(2616005)(86362001)(8676002)(8936002)(6486002)(71200400001)(316002)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1718;H:CY4PR15MB1304.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hz02ayoJFaDXydEsuVYL40rcaBSLPz5qXYLW4djCyHGKkOZqk2nAc2XdtR+WuuaJUnS9EKCfKmioN5m04G3ZpNhQTZRfazh5WCwJ4Fupj4OawyX6OPCKWPhbITI7zLGBk9Bg8g3wylseVweIDWSbBgxs5AuCMds1G7XelISpXnYjdMB2OBytKuCv3EPymVUBGm36u3HuoOie8ecbcDmXtRTsKkODl+qhwHLWUZh0uJljf7CqIH79coKBldcSy5vHYe+I/FZuioiUsjP0jNy7Kk/Z+PgAnglfh5JM4f4J5DgV/ZJn0K66fzevhleHhfO/RUClI7TreJoFMRg5uVeSQ1W0husVz2V9cHlXt46ZEW9r3XDgy6+FhrHgDNYnA+MvnumpAzH86XDtXvOCMtgY4mQ4RA7vC1LxhJv/IvTl7hhEFS9i+03P54eXXZnmJUxX
x-ms-exchange-antispam-messagedata: oE0k6GvMIGK5XVQKmT1JLMzWVsZ5x6UX57UhGck2b7T4JY/vgrbtSXlromg+4xQr3YV36hUq3uqTKaovvmJiUi6M5SKfp4cSLjym57/jXS3elWn2xW4vnC/8xUR/DO/zvCcXVwkDzx+wwqlUUUwHYE76A6fPjpimsnR9YwIPxgO+EeuSWlTC3tbo9/PXuLQD
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F796BD6F0B8FA40B1C352DFD63F61FD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6eb7a4-3989-493c-6891-08d7a0555b00
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 22:41:15.7731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NP0riwmQxJdxIDLLkJqGqRmySxB7tcQh9QMuqWzimVXvk1pUeDbQDcEEf13IV9EI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1718
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-23_13:2020-01-23,2020-01-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011
 adultscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001230169
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gMS8yMy8yMCAyOjMwIFBNLCBEYW5pZWwgWHUgd3JvdGU6DQo+IE9uIFRodSBKYW4gMjMsIDIw
MjAgYXQgMTE6MjMgUE0sIERhbmllbCBCb3JrbWFubiB3cm90ZToNCj4gWy4uLl0NCj4+DQo+PiBZ
ZXMsIHNvIHdlJ3ZlIGJlZW4gZm9sbG93aW5nIHRoaXMgcHJhY3RpY2UgZm9yIGFsbCB0aGUgQlBG
IGhlbHBlcnMgbm8NCj4+IG1hdHRlcg0KPj4gd2hpY2ggcHJvZ3JhbSB0eXBlLiBUaG91Z2ggZm9y
IHRyYWNpbmcgaXQgbWF5IGJlIHVwIHRvIGRlYmF0ZSB3aGV0aGVyIGl0DQo+PiBtYWtlcw0KPj4g
c3RpbGwgc2Vuc2UgZ2l2ZW4gdGhlcmUncyBub3RoaW5nIHRvIGJlIGxlYWtlZCBoZXJlIHNpbmNl
IHlvdSBjYW4gcmVhZA0KPj4gdGhpcyBkYXRhDQo+PiBhbnl3YXkgdmlhIHByb2JlIHJlYWQgaWYg
eW91J2Qgd2FudGVkIHRvLiBTbyB3ZSBtaWdodCBhcyB3ZWxsIGdldCByaWQgb2YNCj4+IHRoZQ0K
Pj4gY2xlYXJpbmcgZm9yIGFsbCB0cmFjaW5nIGhlbHBlcnMuDQo+IA0KPiBSaWdodCwgdGhhdCBt
YWtlcyBzZW5zZS4gRG8geW91IHdhbnQgbWUgdG8gbGVhdmUgaXQgaW4gZm9yIHRoaXMgcGF0Y2hz
ZXQNCj4gYW5kIHRoZW4gcmVtb3ZlIGFsbCBvZiB0aGVtIGluIGEgZm9sbG93dXAgcGF0Y2hzZXQ/
DQo+IA0KDQpJIGRvbid0IHRoaW5rIHdlIGNhbiByZW1vdmUgdGhhdCBmb3IgZXhpc3RpbmcgdHJh
Y2luZyBoZWxwZXJzIChlLmcuLCANCmJwZl9wcm9iZV9yZWFkKS4gVGhlcmUgYXJlIGFwcGxpY2F0
aW9ucyB0aGF0IGV4cGxpY2l0bHkgZXhwZWN0IA0KZGVzdGluYXRpb24gbWVtb3J5IHRvIGJlIHpl
cm9lZCBvdXQgb24gZmFpbHVyZS4gSXQncyBhIEJQRiB3b3JsZCdzIA0KbWVtc2V0KDApLg0KDQpJ
IGFsc28gd29uZGVyIGlmIEJQRiB2ZXJpZmllciBoYXMgYW55IGV4dHJhIGFzc3VtcHRpb25zIGZv
ciANCkFSR19QVFJfVE9fVU5JTklUX01FTSB3LnIudC4gaXQgYmVpbmcgaW5pdGlhbGl6ZWQgYWZ0
ZXIgaGVscGVyIGNhbGwgDQooZS5nLiwgZm9yIGxpdmVuZXNzIHRyYWNraW5nKS4NCg0KPj4NCj4+
IERpZmZlcmVudCBxdWVzdGlvbiByZWxhdGVkIHRvIHlvdXIgc2V0LiBJdCBsb29rcyBsaWtlIGJy
X3N0YWNrIGlzIG9ubHkNCj4+IGF2YWlsYWJsZQ0KPj4gb24geDg2LCBpcyB0aGF0IGNvcnJlY3Q/
IEZvciBvdGhlciBhcmNocyB0aGlzIHdpbGwgYWx3YXlzIGJhaWwgb3V0IG9uDQo+PiAhYnJfc3Rh
Y2sNCj4+IHRlc3QuIFBlcmhhcHMgd2Ugc2hvdWxkIGRvY3VtZW50IHRoaXMgZmFjdCBzbyB1c2Vy
cyBhcmUgbm90IHN1cnByaXNlZA0KPj4gd2h5IHRoZWlyDQo+PiBwcm9nIHVzaW5nIHRoaXMgaGVs
cGVyIGlzIG5vdCB3b3JraW5nIG9uICF4ODYuIFdkeXQ/DQo+IA0KPiBJIHRoaW5rIHBlcmZfZXZl
bnRfb3BlbigpIHNob3VsZCBmYWlsIG9uICF4ODYgaWYgYSB1c2VyIHRyaWVzIHRvIGNvbmZpZ3Vy
ZQ0KPiBpdCB3aXRoIGJyYW5jaCBzdGFjayBjb2xsZWN0aW9uLiBTbyB0aGVyZSB3b3VsZCBub3Qg
YmUgdGhlIG9wcG9ydHVuaXR5IGZvcg0KPiB0aGUgYnBmIHByb2cgdG8gYmUgYXR0YWNoZWQgYW5k
IHJ1bi4gSSBoYXZlbid0IHRlc3RlZCB0aGlzLCB0aG91Z2guIEknbGwNCj4gbG9vayB0aHJvdWdo
IHRoZSBjb2RlIC8gaW5zdGFsbCBhIFZNIGFuZCB0ZXN0IGl0Lg0KPiANCj4gWy4uLl0NCj4gDQo+
IFRoYW5rcywNCj4gRGFuaWVsDQo+IA0KDQo=
