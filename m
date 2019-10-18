Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1865ADD0BC
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2019 22:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731834AbfJRU5S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Oct 2019 16:57:18 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56084 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732529AbfJRU5S (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 18 Oct 2019 16:57:18 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9IKrGr2024946;
        Fri, 18 Oct 2019 13:57:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=WmIm663ywN5frbReHyc2Q7xjGz2AeZC6gDwSie+bvIY=;
 b=Q3uuz9oDuVPaiWyM+vtNgfFSQHsI7rNWBvxEiLu5whIX15fzpHvT32wSLEyNjWlSmzwH
 Ukop8EbAPY9wVxmHbpSLzNUPZs5qyeFYaTLDp/fmepV7u6+RxAFJbV3stWGbgmWv0PFh
 VRnamGMs/OC5mVvjHFRdMgm78un0CiS55G0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vqeunhwdv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Oct 2019 13:57:01 -0700
Received: from ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) by
 ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 18 Oct 2019 13:56:59 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 18 Oct 2019 13:56:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKE1uLbD/S3fwjZOoD21TTlZLKaE+3HUHA7XMUx1au3f2/cAQeue2Ij4Wt7+5dDH2Aglo9BourD/GgK+8Nlf26rZfrtj7PXQMxz/nfluDGLVcRPTbOuwaWBXdpWmHdSQ2F/dj/6VAg5BIkXEJAw5UX156JnkiqAzJsxgZuY7OIhzaFxgFl5B5V9OsA0rciXyuef0oKSDpXEbhhC8twp5Yyjll4J3ht+vGNQgQ4dPaNIAKGbZqaoj+d5B/VxtT8v5MrJsci7HBhyTympEOm5E8l4jHLLuL98I0Ya//qw8EVNcHAoYUC7ySeGmwCw3SqqyTbbX2s1Pfz4wPaM/7WFiow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmIm663ywN5frbReHyc2Q7xjGz2AeZC6gDwSie+bvIY=;
 b=DjS5vr0Xw4YeSWf3sSFGouxVRRHbKwI/IGufraWFn+OyubSRwOf3HXSXu+BJ7xo6OHvooaF9pNGVaqjtrdzk6eFLS+o83gEaonPuDDi6Qq9xy7ScLpv+2E9jiKNE9NcA3cYkOW8cEoJMl024KpS/m2eDj7IkRXX6kt6Emj9ojrDKQicg8NPNpXuZjGXcKC15KOnzYvWq/8GJuqPPojJnSzPR7KIrSV6H5ur0rr8l+CLmPPHHVenvZkRhDyaEMYMv9ZFyQBBliVLaxpahB7LcX30GFWgSVXJtggaIGsouUNNCoz8giQVOluNZw2z+lQI/PTSsK14h4h+NJLdcpnuzOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmIm663ywN5frbReHyc2Q7xjGz2AeZC6gDwSie+bvIY=;
 b=W5fcIST3h6OzYS+dL4qE8kXYx/KlUTv6rlF8c4P6hQ8SZhU5UkW07vx6RaCBcXPtXITukMr/kU2n3ZZ3dEZcSBl/r7sPo6NZc6WDG95xvs/fWCejY0fBxQSvH8dMVeVYXtMpXx8EFOLxfZS/XrlCb3jRw+2/6oUog7AchuYfsBU=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.60.27) by
 BYAPR15MB3192.namprd15.prod.outlook.com (20.179.59.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Fri, 18 Oct 2019 20:56:58 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::b92c:ebd2:58dc:6b8d]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::b92c:ebd2:58dc:6b8d%5]) with mapi id 15.20.2347.024; Fri, 18 Oct 2019
 20:56:58 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "joe@wand.net.nz" <joe@wand.net.nz>
Subject: Re: [PATCH bpf] bpf: improve htab_map_get_next_key behaviour during
 races
Thread-Topic: [PATCH bpf] bpf: improve htab_map_get_next_key behaviour during
 races
Thread-Index: AQHVhboaHZNgMWvj5k6IVWWlP3dRAqdgj9mAgABR2QA=
Date:   Fri, 18 Oct 2019 20:56:58 +0000
Message-ID: <28216dce-037e-036c-2716-16f898b91a27@fb.com>
References: <20191018134311.7284-1-lmb@cloudflare.com>
 <20191018160357.rq7twrwywpuc4xax@ast-mbp>
In-Reply-To: <20191018160357.rq7twrwywpuc4xax@ast-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR15CA0041.namprd15.prod.outlook.com
 (2603:10b6:300:ad::27) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:112::27)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:95af]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0845ebf6-8d66-4ca5-826e-08d7540db73f
x-ms-traffictypediagnostic: BYAPR15MB3192:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <BYAPR15MB31925DCDF78698A6D194E512D36C0@BYAPR15MB3192.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(346002)(136003)(376002)(199004)(189003)(110136005)(8676002)(6306002)(76176011)(31696002)(6116002)(229853002)(4326008)(6436002)(6512007)(86362001)(25786009)(11346002)(6506007)(46003)(386003)(5660300002)(446003)(305945005)(476003)(54906003)(99286004)(53546011)(6486002)(2616005)(7736002)(102836004)(186003)(52116002)(486006)(81156014)(66556008)(81166006)(14444005)(316002)(36756003)(66946007)(966005)(256004)(478600001)(71200400001)(71190400001)(66476007)(14454004)(31686004)(6246003)(64756008)(2906002)(66446008)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3192;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VhmA4KlnysCaPi/7xyLUtPbrBf7Oq2FMB122eyrF6uRCH9z1oH9pXRL5xFVLIfRn62BqqZenyveMlDdsCWkTUyQsoDhsd9Oan/7HP7E+j9j60inYnqFrftxYCl35hO1Wxr//ko9442rZGPWGCNtyzUKHqg8zJlE4/nRDYHUTYjx15oSzksjm0QkOEBmYLlXzi2uAEu+gO55/SitD7S31vMv8ZQLJOQOqrKpZbkWNG2P86USPsYM+ccytSXDQmJpaxQKA/7WDTJG9gTgQntm6jQCw4nA2sdzqxJrjD5xiErbkwVfmzOkvtAN0p6Sk8f5b387D9rilvNMCa0QoNSs+W1/gf+vdsvgAmrIm6q7bTdXkp2bAReG1HzssliZKtN60Pzw1k/qWbkeIyLnYCLYyEnkWQnTnkb0sepX8oOXjxkmvGFx0G1QokfukF0BcQKwT8aXvHGBXVMSEqFdX5gf5Pg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A5E704CD40B1B458AE9246CC3FE4ECF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0845ebf6-8d66-4ca5-826e-08d7540db73f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 20:56:58.4963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +fVZ3wAFuXdbEcNrF+waKtbakM3Xb4SR5SA5ix9yE3aqVgWpUzJ6WRWQ6sRs52Ey
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3192
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-18_05:2019-10-18,2019-10-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 priorityscore=1501 mlxlogscore=853 bulkscore=0 clxscore=1011
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910180184
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDEwLzE4LzE5IDk6MDMgQU0sIEFsZXhlaSBTdGFyb3ZvaXRvdiB3cm90ZToNCj4gT24g
RnJpLCBPY3QgMTgsIDIwMTkgYXQgMDI6NDM6MTFQTSArMDEwMCwgTG9yZW56IEJhdWVyIHdyb3Rl
Og0KPj4gVG8gaXRlcmF0ZSBhIEJQRiBtYXAsIHVzZXJzcGFjZSBtdXN0IHVzZSBNQVBfR0VUX05F
WFRfS0VZIGFuZCBwcm92aWRlDQo+PiB0aGUgbGFzdCByZXRyaWV2ZWQga2V5LiBUaGUgY29kZSB0
aGVuIHNjYW5zIHRoZSBoYXNoIHRhYmxlIGJ1Y2tldA0KPj4gZm9yIHRoZSBrZXkgYW5kIHJldHVy
bnMgdGhlIGtleSBvZiB0aGUgbmV4dCBpdGVtLg0KPj4NCj4+IFRoaXMgcHJlc2VudHMgYSBwcm9i
bGVtIGlmIHRoZSBsYXN0IHJldHJpZXZlZCBrZXkgaXNuJ3QgcHJlc2VudCBpbiB0aGUNCj4+IGhh
c2ggdGFibGUgYW55bW9yZSwgZS5nLiBkdWUgdG8gY29uY3VycmVudCBkZWxldGlvbi4gSXQncyBu
b3QgcG9zc2libGUNCj4+IHRvIGFzY2VydGFpbiB0aGUgbG9jYXRpb24gb2YgYSBrZXkgaW4gYSBn
aXZlbiBidWNrZXQsIHNvIHRoZXJlIGlzbid0DQo+PiByZWFsbHkgYSBjb3JyZWN0IGFuc3dlci4g
VGhlIGltcGxlbWVudGF0aW9uIGN1cnJlbnRseSByZXR1cm5zIHRoZQ0KPj4gZmlyc3Qga2V5IGlu
IHRoZSBmaXJzdCBidWNrZXQuIFRoaXMgZ3VhcmFudGVlcyB0aGF0IHdlIG5ldmVyIHNraXAgYW4N
Cj4+IGV4aXN0aW5nIGtleS4gSG93ZXZlciwgaXQgbWVhbnMgdGhhdCBhIHVzZXIgc3BhY2UgcHJv
Z3JhbSBpdGVyYXRpbmcNCj4+IGEgaGVhdmlseSBtb2RpZmllZCBtYXAgbWF5IG5ldmVyIHJlYWNo
IHRoZSBlbmQgb2YgdGhlIGhhc2ggdGFibGUsDQo+PiBmb3JldmVyIHJlc3RhcnRpbmcgYXQgdGhl
IGJlZ2lubmluZy4NCj4+DQo+PiBGaXhpbmcgdGhpcyBvdXRyaWdodCBpcyByYXRoZXIgaW52b2x2
ZWQuIEhvd2V2ZXIsIHdlIGNhbiBpbXByb3ZlIHNsaWdodGx5DQo+PiBieSBuZXZlciByZXZpc2l0
aW5nIGVhcmxpZXIgYnVja2V0cy4gSW5zdGVhZCBvZiB0aGUgZmlyc3Qga2V5IGluIHRoZQ0KPj4g
Zmlyc3QgYnVja2V0IHdlIHJldHVybiB0aGUgZmlyc3Qga2V5IGluIHRoZSAiY3VycmVudCIgYnVj
a2V0LiBUaGlzDQo+PiBkb2Vzbid0IGVsaW1pbmF0ZSB0aGUgcHJvYmxlbSwgYnV0IG1ha2VzIGl0
IGxlc3MgbGlrZWx5IHRvIG9jY3VyLg0KPj4NCj4+IFByaW9yIHRvIGNvbW1pdCA4ZmU0NTkyNDM4
N2IgKCJicGY6IG1hcF9nZXRfbmV4dF9rZXkgdG8gcmV0dXJuIGZpcnN0IGtleSBvbiBOVUxMIikN
Cj4+IHBhc3NpbmcgYSBub24tZXhpc3RlbnQga2V5IHRvIE1BUF9HRVRfTkVYVF9LRVkgd2FzIHRo
ZSBvbmx5IHdheSB0bw0KPj4gZmluZCB0aGUgZmlyc3Qga2V5LiBIZW5jZSB0aGVyZSBpcyBhIHNt
YWxsIGNoYW5jZSB0aGF0IHRoZXJlIGlzIGNvZGUgdGhhdA0KPj4gd2lsbCBiZSBicm9rZW4gYnkg
dGhpcyBjaGFuZ2UuDQo+IA0KPiBJdCBpcyAxMDAlIGNoYW5jZSB0aGF0IGl0IHdpbGwgYnJlYWsg
b2xkZXIgYmNjIHRvb2xzIHRoYXQgd2VyZSB3cml0dGVuDQo+IGJlZm9yZSBOVUxMIHdhcyBwb3Nz
aWJsZSBhcmd1bWVudCBmb3IgZ2V0X25leHRfa2V5Lg0KDQpUaGUgcmVmZXJlbmNlZCBiY2MgY29k
ZSBpcyBpbiBiZWxvdzoNCmh0dHBzOi8vZ2l0aHViLmNvbS9pb3Zpc29yL2JjYy9ibG9iL21hc3Rl
ci9zcmMvY2MvbGliYnBmLmMjTDMwMS1MMzMwDQoNCj4gUGxlYXNlIHNlZSBZb25naG9uZydzIHBh
dGNoZXMgZm9yIGJhdGNoZWQgbWFwIGxvb2t1cC4NCg0KVGhpcyBpcyBteSBSRkMgcGF0Y2guDQpo
dHRwczovL2xvcmUua2VybmVsLm9yZy9icGYvMjAxOTA5MDYyMjU0MzQuMzYzNTQyMS0xLXloc0Bm
Yi5jb20vVC8jdA0KDQpJIGhhdmUgbm90IGdvdCB0aW1lIHRvIGZpbmlzaCBpdCBhcyBhIHByb3Bl
ciBwYXRjaCBzZXQgeWV0Lg0KQnV0IGhvcGVmdWxseSBzb29uIGNhbiBmaW5kIHNvbWUgdGltZSB0
byB3b3JrIG9uIHRoaXMuDQoNCg0KPiBUaGF0J3MgdGhlIHByb3BlciB3YXkgdG8gc29sdmUgeW91
ciBwcm9ibGVtLg0KPiANCg==
