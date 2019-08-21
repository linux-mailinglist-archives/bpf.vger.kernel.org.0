Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE016980C4
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2019 18:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbfHUQ4L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Aug 2019 12:56:11 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38220 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728810AbfHUQ4K (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 21 Aug 2019 12:56:10 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x7LGkkXL014193;
        Wed, 21 Aug 2019 09:54:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=8t1EpPoUxfleunOlM6mhSpWHnlTn9YDr+q9AtRyzrnU=;
 b=e36ypw0wg0HGQqOYiNgj3KDO7p9XBUAB9uhr2MfUAWQOVW9GhYSHNLOiZ4VNy9t5qqNo
 WYhK9FlE8BIrpwsEE4qlB1TJEl8O6iEyQ44Hs/O6Fnr2Q3+V1qNWMhib5YTlHXYCKm70
 3qHh5lIUSkI/t3nXRmejdAoLvGrJq43K938= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2uh8qcrch4-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 21 Aug 2019 09:54:54 -0700
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 21 Aug 2019 09:54:51 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 21 Aug 2019 09:54:51 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 21 Aug 2019 09:54:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9F351kA+kMd6wF0rzDHp7J4oG3vK7zL+vt6PatjliF5LTeiW4kB00vtsTINC29lzA5FA+vfNncFhhT6kcE+wzdlvFUUQnhS++pncrqjv9VpYL+6xr0eWw+N+1Ooint8/V3vy8rmcvPG01i0uj7q1vZw2L/7jHBHsVBlOiEKp0xuGqEt+dAScK2rcEiXbbEUvOnwDBVwt1NFlhzC2n+1SG6DHGl8AV7Zokoz3B1TtvXrxut1XG4zHGWTMZm3NHWk5Mg7JcomIWlxrYF9U+XrTRgZUPKdGSL4az2Dj0LftmtFf/WhIZdtr0H5FEtHeSkEEXR5XpOZo6x6xH2BY2plYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8t1EpPoUxfleunOlM6mhSpWHnlTn9YDr+q9AtRyzrnU=;
 b=kFhTsH8g4b3wnMYemlqjvM7G8CLvSPGiERI0PPbjfEeD2D1cFOtgOuGgeUqAslpvCIRxhdoCmsfXec2gShrQVk3GnEhY6MKSaaX1YznNiUC2i+f9jnQRFRzYfJRNGuf/ZXot/8zZ+WJMJcRP1my5kw36jF0LNYg236tDRnhrUmeFevEfjAInjFaJHV0SLkchtISVQ0TRC5yAudrPmYdHbLH6rwVJVqjTeOJlTTpG+jjYSdjYF8yy3ThUcLDSlH7R9MLkv/22KJjF0eh0SOFrfyZP6j8Jpf+2bw2pp17fdkIo6Q4gPoWA+enJEhUx2zqHeunGM2i/8Bpm12Z0rgjQYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8t1EpPoUxfleunOlM6mhSpWHnlTn9YDr+q9AtRyzrnU=;
 b=LUAuq2xzXYWZm3pfC4RD5Br0BmaHqwJjED/myLrsflo3/cpZHKDp+CtCOKW8r/Yi4pFWVJztB3vxWtfWRyXqL8qRhJ0cef35JxMaFoK9DGcDW1OP4Iw/yZWC35RIW2l0YEMsP0kdo8y44CwekZiNRSzZiCGAS5nwBOVNCcG14GU=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2360.namprd15.prod.outlook.com (52.135.198.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.23; Wed, 21 Aug 2019 16:54:47 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d95b:271:fa7e:e978]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d95b:271:fa7e:e978%5]) with mapi id 15.20.2178.020; Wed, 21 Aug 2019
 16:54:47 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>, Daniel Xu <dxu@dxuuu.xyz>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>
Subject: Re: [PATCH v3 bpf-next 1/4] tracing/probe: Add
 PERF_EVENT_IOC_QUERY_PROBE ioctl
Thread-Topic: [PATCH v3 bpf-next 1/4] tracing/probe: Add
 PERF_EVENT_IOC_QUERY_PROBE ioctl
Thread-Index: AQHVWBDfYHIXKLzjJEaHryqNNkv52KcF0iEA
Date:   Wed, 21 Aug 2019 16:54:47 +0000
Message-ID: <62874df3-cae0-36a1-357f-b59484459e52@fb.com>
References: <20190820144503.GV2332@hirez.programming.kicks-ass.net>
 <BWENHQJIN885.216UOYEIWNGFU@dlxu-fedora-R90QNFJV>
 <20190821110856.GB2349@hirez.programming.kicks-ass.net>
In-Reply-To: <20190821110856.GB2349@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR17CA0057.namprd17.prod.outlook.com
 (2603:10b6:300:93::19) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:f330]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d1f7ba8-f8d0-45bd-b892-08d72658460e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB2360;
x-ms-traffictypediagnostic: BYAPR15MB2360:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB23608A53F1A3217021797FAED3AA0@BYAPR15MB2360.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:207;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39860400002)(376002)(366004)(189003)(199004)(71190400001)(86362001)(14454004)(11346002)(5024004)(6306002)(966005)(99286004)(478600001)(66476007)(6506007)(46003)(2616005)(31686004)(6116002)(14444005)(36756003)(386003)(53546011)(102836004)(76176011)(6436002)(6486002)(229853002)(110136005)(54906003)(446003)(66946007)(53936002)(66556008)(476003)(256004)(7416002)(316002)(186003)(64756008)(25786009)(7736002)(6246003)(2906002)(81166006)(66446008)(5660300002)(71200400001)(8676002)(31696002)(81156014)(6512007)(4326008)(8936002)(52116002)(486006)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2360;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pYv1XFLjqtI496zsp0dfMFVJa0/2ZKomQlbxFRsO8Mi1goVTsTExbNwI/eLz6ffJM7bbT3hUbTes2E9zz06wxCEua9KoYuV/FeghXtZhnbyHixfActpB8AWiPO6klN8l/X9einKk6X2Vl39jqc9INsLJWfSLj4AFfTaKG7b/h3s6RqiQeSNhycoJhPixfnSVrNahU/F9kwB8iPZ7XRMjGwP+uhUIRuzasatbFwV0vIVtRKJehb27KidZMHFpZiil+lSjLxzUY4xMvTOV9sHww+39pXN+GgOwg+x4lLS4poKrSWlWG6trCpqNP7DZfEy/v03l/bBjLIcG2N96q5/HV9IEoVwwPMUk6kQwZmGs1wbmAgzzLv85pleBjwM2iT5nvTHbdBE8zgwqqBZUiyjpQ5fmqy3b85Sz7M5eAQc6n4I=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC4D09795D8943449FC0DD7BE84648A9@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1f7ba8-f8d0-45bd-b892-08d72658460e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 16:54:47.2660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lv3YgNbSJ1wAs52PgIESJbrt9eGBl1VKG03yTdPMkm4F/wqXYhn/GSKbQS/+xkPS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2360
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-21_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908210173
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDgvMjEvMTkgNDowOCBBTSwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+IE9uIFR1ZSwg
QXVnIDIwLCAyMDE5IGF0IDEwOjU4OjQ3QU0gLTA3MDAsIERhbmllbCBYdSB3cm90ZToNCj4+IEhp
IFBldGVyLA0KPj4NCj4+IE9uIFR1ZSBBdWcgMjAsIDIwMTkgYXQgNDo0NSBQTSBQZXRlciBaaWps
c3RyYSB3cm90ZToNCj4+PiBPbiBGcmksIEF1ZyAxNiwgMjAxOSBhdCAwMzozMTo0NlBNIC0wNzAw
LCBEYW5pZWwgWHUgd3JvdGU6DQo+Pj4+IEl0J3MgdXNlZnVsIHRvIGtub3cgW3VrXXByb2JlJ3Mg
bm1pc3NlZCBhbmQgbmhpdCBzdGF0cy4gRm9yIGV4YW1wbGUgd2l0aA0KPj4+PiB0cmFjaW5nIHRv
b2xzLCBpdCdzIGltcG9ydGFudCB0byBrbm93IHdoZW4gZXZlbnRzIG1heSBoYXZlIGJlZW4gbG9z
dC4NCj4+Pj4gZGVidWdmcyBjdXJyZW50bHkgZXhwb3NlcyBhIGNvbnRyb2wgZmlsZSB0byBnZXQg
dGhpcyBpbmZvcm1hdGlvbiwgYnV0DQo+Pj4+IGl0IGlzIG5vdCBjb21wYXRpYmxlIHdpdGggcHJv
YmVzIHJlZ2lzdGVyZWQgd2l0aCB0aGUgcGVyZiBBUEkuDQo+Pj4NCj4+PiBXaGF0IGlzIHRoaXMg
bm1pc3NlZCBhbmQgbmhpdCBzdHVmZj8NCj4+DQo+PiBubWlzc2VkIGlzIHRoZSBudW1iZXIgb2Yg
dGltZXMgdGhlIHByb2JlJ3MgaGFuZGxlciBzaG91bGQgaGF2ZSBiZWVuIHJ1bg0KPj4gYnV0IGRp
ZG4ndC4gbmhpdCBpcyB0aGUgbnVtYmVyIG9mIHRpbWVzIHRoZSBwcm9iZXMgaGFuZGxlciBoYXMg
cnVuLiBJJ3ZlDQo+PiBkb2N1bWVudGVkIHRoaXMgaW5mb3JtYXRpb24gaW4gdGhlIHVhcGkgaGVh
ZGVyLiBJZiB5b3UnZCBsaWtlLCBJIGNhbiBwdXQNCj4+IGl0IGluIHRoZSBjb21taXQgbWVzc2Fn
ZSB0b28uDQo+IA0KPiBUaGF0IGNvbW1lbnQganVzdCBzYXlzOiAnbnVtYmVyIG9mIHRpbWVzIHRo
aXMgcHJvYmUgd2FzIHRlbXBvcmFyaWx5DQo+IGRpc2FibGVkJywgd2hpY2ggc2F5cyBleGFjdGx5
IG5vdGhpbmcuDQo+IA0KPiBCdXQgcmVhZGluZyB0aGUga3Byb2JlIGNvZGUgc2VlbXMgdG8gc3Vn
Z2VzdCB0aGlzIGhhcHBlbnMgb24gcmVjdXJzaXZlDQo+IGtwcm9iZXMsIHdoaWNoIEknbSB0aGlu
a2luZyBpcyBhIGRvZGd5IHNpdHVhdGlvbiBpbiB0aGUgZmlyc3QgcGxhY2UuDQo+IA0KPiBmdHJh
Y2UgYW5kIHBlcmYgaW4gZ2VuZXJhbCBkb24ndCBrZWVwIGNvdW50cyBvZiBldmVudHMgbG9zdCBk
dWUgdG8NCj4gcmVjdXJzaW9uLCBzbyB3aHkgc2hvdWxkIHdlIGRvIHRoaXMgZm9yIGtwcm9iZXM/
IEFsc28sIHdoaWxlIHlvdSB3cml0ZQ0KPiB0byBzdXBwb3J0IHVwcm9iZXMsIGl0IGRvZXNuJ3Qg
YWN0dWFsbHkgc3VmZmVyIGZyb20gdGhpcyAoaXQgY2Fubm90LA0KPiB1cHJvYmVzIGNhbm5vdCBy
ZWN1cnNlKSwgc28gc3VwcG9ydGluZyBpdCBtYWtlcyBubyBzZW5zZS4NCj4gDQo+IEFuZCB3aXRo
IHRoYXQsIHRoZSBuYW1lIFFVRVJZX1BST0JFIGFsc28gbWFrZXMgbm8gc2Vuc2UsIGJlY2F1c2Ug
aXQgaXMNCj4gbm90IHNwZWNpZmljIHRvIFt1a11wcm9iZXMsIGFsbCBzb2Z0d2FyZSBldmVudHMg
c3VmZmVyIHRoaXMuDQo+IA0KPiBBbmQgSSdtIG5vdCBzdXJlIGFuIGFkZGl0aW9uYWwgaW9jdGwo
KSBpcyB0aGUgcmlnaHQgd2F5LCBzdXBwb3Npbmcgd2UNCj4gd2FudCB0byBleHBvc2UgdGhpcyBh
dCBhbGwuIFlvdSd2ZSBtZW50aW9uZWQgbm8gYWx0ZXJuYXRpdmUgYXBwcm9hY2hlZCwNCj4gSSdt
IHRoaW5raW5nIFBFUkZfRk9STUFUX0xPU1QgbWlnaHQgYmUgcG9zc2libGUsIG9yIG1heWJlIGEN
Cj4gUEVSRl9SRUNPUkRfTE9TVCBleHRlbnRpb24uDQoNClRoaW5ncyBnZXQgbW9yZSBjb21wbGlj
YXRlZCB3aGVuIGJwZiBwcm9ncmFtIGlzIGV4ZWN1dGluZyB0byByZXBsYWNlDQpyaW5nIGJ1ZmZl
ciBvdXRwdXQuDQoNCkN1cnJlbnRseSwgaW4ga2VybmVsL3RyYWNlL2JwZl90cmFjZS5jLCB3ZSBo
YXZlDQoNCnVuc2lnbmVkIGludCB0cmFjZV9jYWxsX2JwZihzdHJ1Y3QgdHJhY2VfZXZlbnRfY2Fs
bCAqY2FsbCwgdm9pZCAqY3R4KQ0Kew0KICAgICAgICAgdW5zaWduZWQgaW50IHJldDsNCg0KICAg
ICAgICAgaWYgKGluX25taSgpKSAvKiBub3Qgc3VwcG9ydGVkIHlldCAqLw0KICAgICAgICAgICAg
ICAgICByZXR1cm4gMTsNCg0KICAgICAgICAgcHJlZW1wdF9kaXNhYmxlKCk7DQoNCiAgICAgICAg
IGlmICh1bmxpa2VseShfX3RoaXNfY3B1X2luY19yZXR1cm4oYnBmX3Byb2dfYWN0aXZlKSAhPSAx
KSkgew0KICAgICAgICAgICAgICAgICAvKg0KICAgICAgICAgICAgICAgICAgKiBzaW5jZSBzb21l
IGJwZiBwcm9ncmFtIGlzIGFscmVhZHkgcnVubmluZyBvbiB0aGlzIGNwdSwNCiAgICAgICAgICAg
ICAgICAgICogZG9uJ3QgY2FsbCBpbnRvIGFub3RoZXIgYnBmIHByb2dyYW0gKHNhbWUgb3IgZGlm
ZmVyZW50KQ0KICAgICAgICAgICAgICAgICAgKiBhbmQgZG9uJ3Qgc2VuZCBrcHJvYmUgZXZlbnQg
aW50byByaW5nLWJ1ZmZlciwNCiAgICAgICAgICAgICAgICAgICogc28gcmV0dXJuIHplcm8gaGVy
ZQ0KICAgICAgICAgICAgICAgICAgKi8NCiAgICAgICAgICAgICAgICAgcmV0ID0gMDsNCiAgICAg
ICAgICAgICAgICAgZ290byBvdXQ7DQogICAgICAgICB9DQouLi4uLg0KDQpJbiB0aGUgYWJvdmUs
IHRoZSBldmVudHMgd2l0aCBicGYgcHJvZ3JhbSBhdHRhY2hlZCB3aWxsIGJlIG1pc3NlZA0KaWYg
dGhlIGNvbnRleHQgaXMgbm1pIGludGVycnVwdCwgb3IgaWYgc29tZSByZWN1cnNpb24gaGFwcGVu
cyBldmVuIHdpdGggDQp0aGUgc2FtZSBvciBkaWZmZXJlbnQgYnBmIHByb2dyYW1zLg0KSW4gY2Fz
ZSBvZiByZWN1cnNpb24sIHRoZSBldmVudHMgd2lsbCBub3QgYmUgc2VudCB0byByaW5nIGJ1ZmZl
ci4NCg0KQSBsb3Qgb2YgYnBmLWJhc2VkIHRyYWNpbmcgcHJvZ3JhbXMgdXNlcyBtYXBzIHRvIGNv
bW11bmljYXRlIGFuZA0KZG8gbm90IGFsbG9jYXRlIHJpbmcgYnVmZmVyIGF0IGFsbC4NCg0KTWF5
YmUgd2UgY2FuIHN0aWxsIHVzZSBpb2N0bCBiYXNlZCBhcHByb2FjaCB3aGljaCBpcyBsaWdodCB3
ZWlnaHRlZA0KY29tcGFyZWQgdG8gcmluZyBidWZmZXIgYXBwcm9hY2g/IElmIGEgZmQgaGFzIGJw
ZiBhdHRhY2hlZCwgbmhpdC9ubWlzc2VzDQptZWFucyB0aGUga3Byb2JlIGlzIHByb2Nlc3NlZCBi
eSBicGYgcHJvZ3JhbSBvciBub3QuDQoNCkN1cnJlbnRseSwgZm9yIGRlYnVnZnMsIHRoZSBuaGl0
L25taXNzZXMgaW5mbyBpcyBleHBvc2VkIGF0DQp7a3x1fXByb2JlX3Byb2ZpbGUuIEFsdGVybmF0
aXZlLCB3ZSBjb3VsZCBleHBvc2UgdGhlIG5oaXQvbm1pc3Nlcw0KaW4gL3Byb2Mvc2VsZi9mZGlu
Zm8vPGZkPi4gVXNlciBjYW4gcXVlcnkgdGhpcyBpbnRlcmZhY2UgdG8NCmdldCBudW1iZXJzLg0K
DQpBcm5hbGRvIGhhcyBhIHF1ZXN0aW9uIG9uIGJjYyBtYWlsaW5nIGxpc3QgYWJvdXQgdGhlIGhp
dC9taXNzDQpjb3VudGluZyBvZiBicGYgcHJvZ3JhbSBtaXNzZWQgdG8gcHJvY2VzcyBldmVudHMu
DQoNCmh0dHBzOi8vbGlzdHMuaW92aXNvci5vcmcvZy9pb3Zpc29yLWRldi9tZXNzYWdlLzE3ODMN
Cg0KQ29tbWVudHM/DQoNCg0KPiANCj4gT2YgY291cnNlLCB0aGVuIHlvdSBnZXQgdG8gaW1wbGVt
ZW50IGl0IGZvciB0cmFjZXBvaW50cyBhbmQgc29mdHdhcmUNCj4gZXZlbnRzIHRvby4NCj4gDQo=
