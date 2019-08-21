Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7BD986FE
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2019 00:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbfHUWMP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Aug 2019 18:12:15 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35742 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729043AbfHUWMP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 21 Aug 2019 18:12:15 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x7LM9B7E029677;
        Wed, 21 Aug 2019 15:11:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=qzXRn/UPyKd9L4WmUVKiAl0GuigOw+dvfdkqU6KJtKw=;
 b=Uz2kg/O33F/2WPd7wDl4su5zl0sstGo/FN/yvv1i4oqq2cIqmQUQ5fmd1O/1O7k8B2bt
 4fW8jLv2pwLgDquFia0sawLFuz48W4b67aLY3VRlu1ESlmFvrnZXj6Y5quqy7Mo/gOKI
 tNZ6AFQ0SKdtleFRolBM6bO+bSIKDFSnE8w= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2uhdq8g6w1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 21 Aug 2019 15:11:00 -0700
Received: from ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 21 Aug 2019 15:10:59 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 21 Aug 2019 15:10:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=McgAmSKRAMnI3t7vmTScaqL1eMTqAai22rmMqE7H/oaKkEmh8vCFObUPZUJGE6ktJbvpivWrQiQlrjgfx8HJkpgAGY9J6hbr/l/pRDab0QZQ0LjkPhZotRsgtks/tactetmR+lA6pHkXAyViNeZTE3ylNTFLGf1hQ1IDedUbRRetlq28FijBuF02aXWjAvhv+AqXMbvKTmu3Ljmv4LpV3zmm+enYXmk4U/88O2YWj7lOn6DMd3LYsfc61VPU2OAi5ZLj+mzmfTq3xfImh8fVZqDfPcJlurXaGF62YkdiKqRK6ThlRalRcnr5ydD7iejsWvshN65Z4CLqbQ+Y9kQFgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzXRn/UPyKd9L4WmUVKiAl0GuigOw+dvfdkqU6KJtKw=;
 b=mRETp2kKF8nxa2sLupLGfz2e4Vvmvt7+XN2N1FdL0eWY/wdEaP6Ve5HIQglbivdj6koPU/dPWg9dZp2ISCeVsAdiOpwjEVBgqbM2DNTDsLKr0j1XMrsQszwW0hdix5mECNCr09ZBqC+UB9eDxpkz5gCai5gMroi6Jc2Dw0dXAmg1crp4WsayqJWaO3MyUwE26pdHBw++QkbPWnPivz4KVUbS+hEdJleMNbYWotcN/TKYKmm4VTDVx01BFXUaNtBJOiza15mLzy5aC4sB6DHuiJR2sbF9K759Cl26AwsPWJ7EFlw1alXC5CJFFZ3wkeIQlcRaM4BD8IBHTxbaQClsNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzXRn/UPyKd9L4WmUVKiAl0GuigOw+dvfdkqU6KJtKw=;
 b=I7b1Yte9vsLKggqEzPF0KOtjzni3yFhFVNXROxdIWYo9+vGM3QjK7TjzBiUj0IXxNazBhuSkEZjuKo5B4NY2tUjRbsOz9QLsxOEWurs7QyP/xTA4tPM71C7XfUjlolv6/TK/5Oho+GO4AcW/vaRaZTTWHvUhHsxAZMTuSqr0Xtc=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2614.namprd15.prod.outlook.com (20.179.155.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.20; Wed, 21 Aug 2019 22:10:59 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d95b:271:fa7e:e978]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d95b:271:fa7e:e978%5]) with mapi id 15.20.2178.020; Wed, 21 Aug 2019
 22:10:59 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     Peter Zijlstra <peterz@infradead.org>, Daniel Xu <dxu@dxuuu.xyz>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
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
Thread-Index: AQHVWBDfYHIXKLzjJEaHryqNNkv52KcFXMkAgACrEYCAACKgAA==
Date:   Wed, 21 Aug 2019 22:10:58 +0000
Message-ID: <99167889-246b-e332-41b0-144260eb5c01@fb.com>
References: <20190820144503.GV2332@hirez.programming.kicks-ass.net>
 <BWENHQJIN885.216UOYEIWNGFU@dlxu-fedora-R90QNFJV>
 <20190821110856.GB2349@hirez.programming.kicks-ass.net>
 <62874df3-cae0-36a1-357f-b59484459e52@fb.com>
 <20190821200701.GI3929@kernel.org>
In-Reply-To: <20190821200701.GI3929@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR10CA0006.namprd10.prod.outlook.com (2603:10b6:301::16)
 To BYAPR15MB3384.namprd15.prod.outlook.com (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:f330]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8dbcf2b3-a57f-490b-48fe-08d726847217
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR15MB2614;
x-ms-traffictypediagnostic: BYAPR15MB2614:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB2614D26C6381D14CDAB29050D3AA0@BYAPR15MB2614.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(136003)(396003)(346002)(189003)(51914003)(199004)(53546011)(6506007)(7736002)(386003)(102836004)(99286004)(6916009)(76176011)(52116002)(66476007)(66946007)(64756008)(66446008)(66556008)(86362001)(31696002)(46003)(36756003)(2616005)(11346002)(186003)(446003)(476003)(486006)(54906003)(8936002)(53936002)(8676002)(6246003)(6116002)(6512007)(6486002)(6306002)(25786009)(6436002)(7416002)(229853002)(478600001)(31686004)(966005)(71190400001)(71200400001)(2906002)(4744005)(316002)(14454004)(256004)(81156014)(4326008)(81166006)(5660300002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2614;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VvE0PKKHZcM49qH2fBK0fAf5nCTVPC1v3zwgW48oHt6Pbd6xUjGcpq6jnfoLXOptE0KN+Bbqg+tfoGE3ujlr2tqEozirKGqZIwm6Sl6mwuFvsAypYs6q93JfnAXlzFqNyMWRekKnz7xJbqhVaeUYh8MEh0mfBl9RGZdWRkUMW6fym5yhknolofYehbo7MeHfSmQmegq/JkiPXrH3v58q5gkU0NF+wpzXoJhBoegnQ1Zvhes3EczBTd+halLM4IE69U2qLq6ZZnlTNb0+oJWg2FtrcohW24m7qSglAp5JDkcf0niWhOpF3ANK849WKM29Yd/BcnxQ90BI2ma8sskG+y8We0W4ggkKQzabR6l1DfsP+Q+OZcyr4b2Ab4vYgcupMt6y552O6bekuYiKrKkWwNVas5tC5luCMNWRbuEvRwI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8167CAFD584C0349BAADF0F50E673123@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dbcf2b3-a57f-490b-48fe-08d726847217
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 22:10:58.9780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Si81L+uj1ww8Tchezq+i3O5wL3U5pPZWh+haI6hzEp4OfldYSiDbzHv70CAIooEC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2614
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-21_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908210217
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDgvMjEvMTkgMTowNyBQTSwgQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxvIHdyb3RlOg0K
PiBFbSBXZWQsIEF1ZyAyMSwgMjAxOSBhdCAwNDo1NDo0N1BNICswMDAwLCBZb25naG9uZyBTb25n
IGVzY3JldmV1Og0KPj4gQXJuYWxkbyBoYXMgYSBxdWVzdGlvbiBvbiBiY2MgbWFpbGluZyBsaXN0
IGFib3V0IHRoZSBoaXQvbWlzcw0KPj4gY291bnRpbmcgb2YgYnBmIHByb2dyYW0gbWlzc2VkIHRv
IHByb2Nlc3MgZXZlbnRzLg0KPiAgIA0KPj4gaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQu
Y29tL3YyL3VybD91PWh0dHBzLTNBX19saXN0cy5pb3Zpc29yLm9yZ19nX2lvdmlzb3ItMkRkZXZf
bWVzc2FnZV8xNzgzJmQ9RHdJQkFnJmM9NVZEMFJUdE5sVGgzeWNkNDFiM01VdyZyPURBOGUxQjVy
MDczdklxUnJGejdNUkEmbT1ScnZxNkszbXgyd1lCQ1U2Y1NYTGpKajhYZmIwNm95bXhOWkg4eXNu
bExBJnM9SWJFYVg4djBPdWxtdktVLXBtY0FoV05tYUh3WGdhRGQ1YXVWRmZSb3lKZyZlPQ0KPiAN
Cj4gUEVSRl9GT1JNQVRfTE9TVCBzZWVtcyB0byBiZSBhIGdvb2QgYW5zd2VyIHRvIHRoYXQ/IFNl
ZSBteSBvdGhlciByZXBseQ0KPiB0byB0aGlzIHRocmVhZC4NCg0KSnVzdCBjaGVja2VkLiBpbmRl
ZWQgYWRkaW5nIFBFUkZfRk9STUFUX0xPU1QgdG8gcGVyZiByZWFkX2Zvcm1hdA0Kc2VlbXMgYSBy
ZWFzb25hYmxlIGFwcHJvYWNoLiBpb2N0bCB3aXRoIHBlcmZfZXZlbnRfb3BlbiBmZCBjYW4gZG8g
dGhlIA0Kc2FtZSB0aGluZywgYnV0IGlvY3RsIHNob3VsZCBiZSBhdm9pZGVkIGlmIHdlIGhhdmUg
YWx0ZXJuYXRpdmVzLg0KDQpUaGFua3MgZm9yIHRoZSBwb2ludGVyIQ0KDQo+IA0KPiAtIEFybmFs
ZG8NCj4gDQo=
