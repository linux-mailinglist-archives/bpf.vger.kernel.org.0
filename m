Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85F791498D4
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2020 06:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgAZFAG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Jan 2020 00:00:06 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44652 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725446AbgAZFAG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 26 Jan 2020 00:00:06 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00Q4xgwc011849;
        Sat, 25 Jan 2020 20:59:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=h4Efp7i5EMVx2LDt4it5Z7g2prpCa72MQ1W/YUwhQSI=;
 b=D5QdXT96pNG3/vkb8tNp1hGBpCGxBBmaGzAFut82dIyOvyGcB0r2N6Yqmrz7+aGt2Qch
 1SzRq58usbVyrOBe1nTjhNUMj+czId77u29ybqLAextBzAJa22BGGavXbLCcffzAcWNm
 svjnboHcQei2S3fzipOoR7S7mCk7jvvb6Sw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xrknqjrvx-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 25 Jan 2020 20:59:43 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sat, 25 Jan 2020 20:59:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dY7fI+M/p/7QgP03JeGgaxGe9aRxO2z3dUfpJ8Ae4ljqpWhjdTuiKjHOw86jmp0Q/56UWn5GX5uGKiVyLfy6ItBjdX6ILbDhQtCsb+DcT+ir4aDt4eK/RnTMsc4EuEDC4JYH6wOEgMv1QoqlKtdi7ajOcJgKsQWS1KxON4yUBnQhfeYtNfm3s3RiKeYcndvEaf3Pfm7yfnz+PfJsSMveerPwB64gWJloWAv1pvmaabjS/9CYEU8Om/JiFUyvB8rVCnm4XamomlbCKwcLBRU1oQUL0LA22VoOUl6F7A9Jo6hbPMsCmW8OQi7hxqk0rY4I/KSV3g++6Jk/peO92Z/aCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4Efp7i5EMVx2LDt4it5Z7g2prpCa72MQ1W/YUwhQSI=;
 b=Gzkw97dRlNg0Z9fhBHauSvt8PGIMJg8D4xO7W1ibyTBs9s+XdLcEvWl8U1g1E6CRItIoJXr/JxRl7FkvxVlus83Hl81icwcszRk7v3WPPkbxD9sesiKXO//gvtnVNdHBvRGhX42CHmNVLFgguDUIcsBKhgmf5bpjlJXIX/p8HADqB6maH+IV81k/ZWOHdcxZo7pALuHB3NL/EOrS0zeabGsD8/mzSOYKWDJx9goVeJjIl7ocCOuUeQpZVfOws4Crua1PrWczoG08WffqxwsRaTX91B0zakoYGal2OYcIdO9GbQKapDu6hJqMH7IdHDPP+MXyHKb0PA8y3S76Wvc/cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4Efp7i5EMVx2LDt4it5Z7g2prpCa72MQ1W/YUwhQSI=;
 b=JIWBnnTnyaxZ+4xrvtEmq5hkpUWgFWUV/3bI9AKG10Olplkwm5NXxtL3PUkmU0l9OImOZBEpG6I+tKUdCXjNZkqk6B/4PFq/WDiwEpO5wSscKMusqgf5bTllwCgxUsVuTKBuBazezV6E7P3/M6xkp7VlSkraYo+uAlRvHVeqpbg=
Received: from DM6PR15MB3001.namprd15.prod.outlook.com (20.178.231.16) by
 DM6PR15MB3225.namprd15.prod.outlook.com (20.179.49.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Sun, 26 Jan 2020 04:59:38 +0000
Received: from DM6PR15MB3001.namprd15.prod.outlook.com
 ([fe80::294e:884:76fd:743c]) by DM6PR15MB3001.namprd15.prod.outlook.com
 ([fe80::294e:884:76fd:743c%4]) with mapi id 15.20.2665.017; Sun, 26 Jan 2020
 04:59:38 +0000
Received: from macbook-pro-52.local.dhcp.thefacebook.com (2620:10d:c090:180::3a87) by MWHPR17CA0060.namprd17.prod.outlook.com (2603:10b6:300:93::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.19 via Frontend Transport; Sun, 26 Jan 2020 04:59:34 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Daniel Xu <dxu@dxuuu.xyz>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>
Subject: Re: [PATCH v5 bpf-next 2/2] selftests/bpf: add
 bpf_read_branch_records() selftest
Thread-Topic: [PATCH v5 bpf-next 2/2] selftests/bpf: add
 bpf_read_branch_records() selftest
Thread-Index: AQHV0/6hj37VXzJy60OxdaYnx1/cgKf72g+AgACG0QCAAAHsgA==
Date:   Sun, 26 Jan 2020 04:59:37 +0000
Message-ID: <33c3e47d-f4fb-e298-0d81-45cc16e13fc1@fb.com>
References: <C05FGIY6DS21.3FOPNFKMT6EWK@dlxu-fedora-R90QNFJV>
 <fcbc20dd-e5ca-e779-774f-49490dc87c3b@fb.com>
 <20200126045236.d6ah2l7joxtthdw6@ast-mbp>
In-Reply-To: <20200126045236.d6ah2l7joxtthdw6@ast-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR17CA0060.namprd17.prod.outlook.com
 (2603:10b6:300:93::22) To DM6PR15MB3001.namprd15.prod.outlook.com
 (2603:10b6:5:13c::16)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::3a87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d22f160-1ae8-461f-4c5b-08d7a21c8b4e
x-ms-traffictypediagnostic: DM6PR15MB3225:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR15MB3225E6107B6DC9C730395544D3080@DM6PR15MB3225.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02945962BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(376002)(396003)(136003)(189003)(199004)(86362001)(31696002)(6916009)(54906003)(316002)(52116002)(6486002)(4326008)(8676002)(36756003)(81166006)(81156014)(8936002)(6512007)(2616005)(71200400001)(16526019)(5660300002)(31686004)(186003)(66946007)(66446008)(64756008)(66556008)(66476007)(966005)(2906002)(53546011)(6506007)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB3225;H:DM6PR15MB3001.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LwTy9/XeaZSiV3VM6CmPYVBb3LbdgqLsNNFEApXF7D0vZUH/t1WVvAh+bQhvNlepdQC1+xR41UcSF9//0D5prERrp0hJxcwrSK/8kcn5hWmlrc6RY/jhVdb5uVOIGt456ruImU/Tm4V9x9aPPFSFksuuvANEJrz46mPnG7Ze+DVvONzs7Clqk6e/7BY8x+Zm8pVO8FxI/ZlgQLbMb1SQlOTfMvrjV2h/gEafvuJNFkL6n/GCCXaFaMspP8YBYxXZerEd8vg9m0mOnph7wnr6q6rNqFc534llhAI92K6PpeG8BoCpudkQTisEQD42K75aHUNQsnpc5DnLijNPrQlsFyajdCcU2slhQOSaQN1eyIQC+xpX4ig7lFjQ95UvJhFLcQMAR9y+faKyJqoETSHw602d8hqbWfC5cUmdoe+JGM8wsZEiE8vWAFkWWl6ukpNuDoWjC9PpHFylV3iwe+1S2sKPfxgGankwWBDvrVtmC1XfxrNNqtGxSx/Q6R2svaf6azcU2EaJ6qzNWL/BmahJ4A==
x-ms-exchange-antispam-messagedata: a6NFdYV7vXBfqF/HrAyDTMzZcooIH3ZWvdBRIguA7f7NUnbyd8fU/7Sfqpfj6b+NLyke8JBgUQo0Yq2E/GXC0IIwtC8uqscjPziQWj0WsK/4j0wYVlMaqlYEmLMJTvYleWVVO22Ak/zOenEaQ/qKcuR+X3lzAvwsoX8YqqPfYbk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8EFFA1170FE22B4A8318AC9B6378248C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d22f160-1ae8-461f-4c5b-08d7a21c8b4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2020 04:59:37.7622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ws4PeL72zclEuIViha+DhSjLYzCvM0wW6VF5C2C56ZUQZZT9b8WTU67w3RZzIYjy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3225
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-25_09:2020-01-24,2020-01-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 bulkscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001260042
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDEvMjUvMjAgODo1MiBQTSwgQWxleGVpIFN0YXJvdm9pdG92IHdyb3RlOg0KPiBPbiBT
dW4sIEphbiAyNiwgMjAyMCBhdCAwNDo1MDoxNEFNICswMDAwLCBZb25naG9uZyBTb25nIHdyb3Rl
Og0KPj4NCj4+DQo+PiBPbiAxLzI1LzIwIDg6MTAgUE0sIERhbmllbCBYdSB3cm90ZToNCj4+PiBP
biBTYXQgSmFuIDI1LCAyMDIwIGF0IDY6NTMgUE0sIEFsZXhlaSBTdGFyb3ZvaXRvdiB3cm90ZToN
Cj4+Pj4gT24gU2F0LCBKYW4gMjUsIDIwMjAgYXQgMjozMiBQTSBEYW5pZWwgWHUgPGR4dUBkeHV1
dS54eXo+IHdyb3RlOg0KPj4+Pj4gKyAgICAgICBhdHRyLnR5cGUgPSBQRVJGX1RZUEVfSEFSRFdB
UkU7DQo+Pj4+PiArICAgICAgIGF0dHIuY29uZmlnID0gUEVSRl9DT1VOVF9IV19DUFVfQ1lDTEVT
Ow0KPj4+Pj4gKyAgICAgICBhdHRyLmZyZXEgPSAxOw0KPj4+Pj4gKyAgICAgICBhdHRyLnNhbXBs
ZV9mcmVxID0gNDAwMDsNCj4+Pj4+ICsgICAgICAgYXR0ci5zYW1wbGVfdHlwZSA9IFBFUkZfU0FN
UExFX0JSQU5DSF9TVEFDSzsNCj4+Pj4+ICsgICAgICAgYXR0ci5icmFuY2hfc2FtcGxlX3R5cGUg
PSBQRVJGX1NBTVBMRV9CUkFOQ0hfVVNFUiB8IFBFUkZfU0FNUExFX0JSQU5DSF9BTlk7DQo+Pj4+
PiArICAgICAgIHBmZCA9IHN5c2NhbGwoX19OUl9wZXJmX2V2ZW50X29wZW4sICZhdHRyLCAtMSwg
MCwgLTEsIFBFUkZfRkxBR19GRF9DTE9FWEVDKTsNCj4+Pj4+ICsgICAgICAgaWYgKENIRUNLKHBm
ZCA8IDAsICJwZXJmX2V2ZW50X29wZW4iLCAiZXJyICVkXG4iLCBwZmQpKQ0KPj4+Pj4gKyAgICAg
ICAgICAgICAgIGdvdG8gb3V0X2Rlc3Ryb3k7DQo+Pj4+DQo+Pj4+DQo+Pj4+IEl0J3MgZmFpbGlu
ZyBmb3IgbWUgaW4ga3ZtLiBJcyB0aGVyZSB3YXkgdG8gbWFrZSBpdCB3b3JrPw0KPj4+PiBDSXMg
d2lsbCBiZSB2bSBiYXNlZCB0b28uIElmIHRoaXMgdGVzdCByZXF1aXJlcyBwaHlzaWNhbCBob3N0
DQo+Pj4+IHN1Y2ggdGVzdCB3aWxsIGtlZXAgZmFpbGluZyBpbiBhbGwgc3VjaCBlbnZpcm9ubWVu
dHMuDQo+Pj4+IEZvbGtzIHdpbGwgYmUgYW5ub3llZCBhbmQgZXZlbnR1YWxseSB3aWxsIGRpc2Fi
bGUgdGhlIHRlc3QuDQo+Pj4+IENhbiB3ZSBmaWd1cmUgb3V0IGhvdyB0byB0ZXN0IGluIHRoZSB2
bSBmcm9tIHRoZSBzdGFydD8NCj4+Pg0KPj4+IEl0IHNlZW1zIHRoZXJlJ3MgYSBwYXRjaHNldCB0
aGF0J3MgYWRkaW5nIExCUiBzdXBwb3J0IHRvIGd1ZXN0IGhvc3RzOg0KPj4+IGh0dHBzOi8vbGtt
bC5vcmcvbGttbC8yMDE5LzgvNi8yMTUgLiBIb3dldmVyIGl0IHNlZW1zIHRvIGJlIHN0dWNrIGlu
DQo+Pj4gcmV2aWV3IGxpbWJvLiBJcyB0aGVyZSBhbnl0aGluZyB3ZSBjYW4gZG8gdG8gaGVscCB0
aGF0IHNldCBhbG9uZz8NCj4+Pg0KPj4+IEFzIGZhciBhcyBoYWNraW5nIGl0LCBub3RoaW5nIHJl
YWxseSBjb21lcyB0byBtaW5kLiBTZWVtcyB0aGF0IHBhdGNoc2V0DQo+Pj4gaXMgb3VyIGJlc3Qg
aG9wZS4NCj4+DQo+PiBwcm9nX3Rlc3RzL3NlbmRfc2lnbmFsLmMgdGVzdHMgc2VuZF9zaWduYWwg
aGVscGVyIHVuZGVyIG5taSB3aXRoDQo+PiBoYXJkd2FyZSBjb3VudGVycy4gSXQgYWRkZWQgYSBj
aGVjayB0byBzZWUgd2hldGhlciB0aGUgdW5kZXJseWluZw0KPj4gaGFyZHdhcmUgY291bnRlciBp
cyBzdXBwb3J0ZWQsIGlmIGl0IGlzIG5vdCwgdGhlIHRlc3QgaXMNCj4+IHNraXBwZWQuDQo+Pg0K
Pj4gTWF5YmUgd2UgY2FuIHVzZSB0aGUgc2FtZSBhcHByYW9jaCBoZXJlLiBJZiBwZXJmX2V2ZW50
X29wZW4gd2l0aA0KPj4gUEVSRl9UWVBFX0hBUkRXQVJFL1BFUkZfU0FNUExFX0JSQU5DSF9TVEFD
SyBmYWlsZWQsDQo+PiB3ZSBqdXN0IG1hcmsgdGhlIHRlc3QgYXMgc2tpcHBlZCBpbnN0ZWFkIG9m
IGZhaWxpbmcuDQo+IA0KPiBJbnN0ZWFkIG9mIGZhaWxpbmcgYW5kIHNraXBwaW5nIHRoZSB0ZXN0
IGhvdyBhYm91dCBtYWtpbmcgaXQgdGVzdCBlcnJvciBjYXNlPw0KPiBMaWtlIGluc3RlYWQgb2Yg
bGJyIHBlcmZfZXZlbnQgc29tZSBvdGhlciBldmVudCBjYW4gYmUgcGFzc2VkIGludG8gYnBmIHBy
b2cuDQo+IE5ldyBoZWxwZXIgY2FuIHN0aWxsIGJlIGNhbGxlZCBhbmQgaW4gc3VjaCBjYXNlIGl0
IHNob3VsZCByZXR1cm4gZWludmFsPw0KDQpXZSBjYW4gaGF2ZSBib3RoLCBJIHRoaW5rLiBTb21l
IHBlb3BsZSBtYXkgaGF2ZSBhIHRlc3QgZW52aXJvbm1lbnQNCndoZXJlIFBFUkZfU0FNUExFX0JS
QU5DSF9TVEFDSyBpcyBhdmFpbGFibGUsIGlmIHRoZXJlIGlzIGEgYnJlYWthZ2UsDQp0aGVuIGl0
IHdpbGwgYmUgcmVwb3J0ZWQuDQo=
