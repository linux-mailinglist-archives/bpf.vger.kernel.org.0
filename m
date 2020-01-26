Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2192D1498C6
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2020 05:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgAZEu7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Jan 2020 23:50:59 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50072 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729014AbgAZEu7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 25 Jan 2020 23:50:59 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00Q4jD3I021064;
        Sat, 25 Jan 2020 20:50:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Cjm9dlAFlPueRhTet0usxe7Zx6i3snPBTlZUKgY8ty0=;
 b=P8RwhOzPXT+84gC7yQvKNVrPpdJLsCE4dsYai54y4kNJ5AuUBN6CzoWNT2qatHqCrH8V
 AzjGR7wddgEjXLXJ5H0tyG1wjlYCCqWK476LjtOFyC5Qj5SGWMqVl+6cpiNxBUAlCwn/
 9zacGX5KtRZbDoIbeP79782DWRP0yIQ/uFM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xrjkgax9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 25 Jan 2020 20:50:30 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sat, 25 Jan 2020 20:50:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAFmS4dqxuGw0upAEh2uhO1UOZ7CkHuMhX4OerUsvMYrrQFIdzmLZfNdtMiQBGTmkm8x6NIehlEkL7++wZ7WORTznU6VtCFfPMmCim4keQTidhVTWT1UQBQNQwzhzFHG1KKxo7a9DIpMotvnb2op33PHwWQhIwkWEm2a3rpjFgmZTO65YNw3wp3o+kqxcdVORkMz8tmzJkOFGoEsoeVwM1Qj1SA/TS/mByKTaKQo2w17/FvO+xFwlCJrRi2aBkeTXRe8BYvDHvfUrhlrO1DXFbWkzzrMu4d6Q1tNw+f9izH4GzXc9txzdC+6K31Q4zYWZh0tUEct/rEwTPuH8aevTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cjm9dlAFlPueRhTet0usxe7Zx6i3snPBTlZUKgY8ty0=;
 b=JTeBefmwF436JwecZomsRpuxRVkJe+066FeNtLhAiY067wISZMTdaTtNr94UyNycdJWlHNYdT/qD0+5wnmBOhGYToxzeR+CvDSBMviF1xFqoK2PaaigaV0GfrwHlRQ7DFeuFWuR6bEPWgdLuBfVjIEHtm2wRU4w7cFt/r3VG2aI5o/nyn0p21TTzMS1FW0lMGPIs2pXqKOQm10mi8+r4qRUcL2AjYu1KaE1C4RfCrhIh7gSMvb1uH35HPgPK2pBdFekL5iGtf9ChCcQUlPkQZqF+ccoE2Z62zfy2u8138GeN1ff1nDn21VuiNpA5dIU+Y2smSKMP9EjXEdTsqCx4qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cjm9dlAFlPueRhTet0usxe7Zx6i3snPBTlZUKgY8ty0=;
 b=aJPxA5pBlXQmYLczGppVDKr1+o5YnF61lPerEmStOQ6x/ghBkt/p9773Z3cMWZ7cywcr4BvfaEGYsLxL84QZvzZCYv4SMntuma1cb0A38eGffyYpMm0TzFFkjC8G3IGq2rpvnL9A52v8fPOQ+7ul0o4VDP8KTH9jRm3bgyaLL5A=
Received: from DM6PR15MB3001.namprd15.prod.outlook.com (20.178.231.16) by
 DM6PR15MB3225.namprd15.prod.outlook.com (20.179.49.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Sun, 26 Jan 2020 04:50:15 +0000
Received: from DM6PR15MB3001.namprd15.prod.outlook.com
 ([fe80::294e:884:76fd:743c]) by DM6PR15MB3001.namprd15.prod.outlook.com
 ([fe80::294e:884:76fd:743c%4]) with mapi id 15.20.2665.017; Sun, 26 Jan 2020
 04:50:14 +0000
Received: from macbook-pro-52.local.dhcp.thefacebook.com (2620:10d:c090:180::3a87) by MWHPR2001CA0004.namprd20.prod.outlook.com (2603:10b6:301:15::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22 via Frontend Transport; Sun, 26 Jan 2020 04:50:11 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Daniel Xu <dxu@dxuuu.xyz>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        "Andrii Nakryiko" <andriin@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v5 bpf-next 2/2] selftests/bpf: add
 bpf_read_branch_records() selftest
Thread-Topic: [PATCH v5 bpf-next 2/2] selftests/bpf: add
 bpf_read_branch_records() selftest
Thread-Index: AQHV0/6hj37VXzJy60OxdaYnx1/cgKf8YCyA
Date:   Sun, 26 Jan 2020 04:50:14 +0000
Message-ID: <fcbc20dd-e5ca-e779-774f-49490dc87c3b@fb.com>
References: <C05FGIY6DS21.3FOPNFKMT6EWK@dlxu-fedora-R90QNFJV>
In-Reply-To: <C05FGIY6DS21.3FOPNFKMT6EWK@dlxu-fedora-R90QNFJV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2001CA0004.namprd20.prod.outlook.com
 (2603:10b6:301:15::14) To DM6PR15MB3001.namprd15.prod.outlook.com
 (2603:10b6:5:13c::16)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::3a87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2619412-48a4-47ea-976a-08d7a21b3bbd
x-ms-traffictypediagnostic: DM6PR15MB3225:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR15MB32253A9D88C93C47ECAF39D2D3080@DM6PR15MB3225.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02945962BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(376002)(346002)(366004)(189003)(199004)(66946007)(66446008)(64756008)(66556008)(66476007)(966005)(186003)(16526019)(31686004)(5660300002)(6506007)(53546011)(478600001)(2906002)(6486002)(52116002)(316002)(31696002)(86362001)(71200400001)(110136005)(54906003)(81166006)(81156014)(8936002)(36756003)(6512007)(2616005)(8676002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB3225;H:DM6PR15MB3001.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZR/gKL9MBnt0+lMozfe0VP4FS2kiUe/UFo4Jd80VVKyvGLa4kj6IyPrm4svx9IOUIys8lDOigwxNGeYO5El7XebBtl5XTg7CbORD+O8kLdVihe387QnPkOJuotVSoysnDu5ozb0RLgF1tJnTXwqBRglIAA/78ZXi6xBkVXwTY+PXqW1M7kgbkYCrw+FST1M2DQbUNONxAFWDvN0He8m+oqZsq/jJxRGxUJF6kvOQZLSpRnPZiAPuTMEnhpaPcfBU/v7k+t/nxZegmx1KpmJ4AI6cWA9gHdrdci4FSBg0nBSmekONBPz8WfMGfFt6H+bxznCQgm5SJ/305T1AZXXlb6HhfEqzEVA4z+RrcSi5hltWIBO0qcfs+Eiy0BP05mO3xLkG56F5yKQNkEpJTMB5FQh8DZ+Iur9fIBQv8BricrTAniQSZ7pprnxCGs30WXz/0UfZp5NCm1LprWX02FGMs8TAMl5S5jRaeTfpzQTYVkgCOkAX61nq7/8LgXOPyVGoJCREQgNkbN7rU4kgKpuv0w==
x-ms-exchange-antispam-messagedata: /vg1fT8lFOP7Hb0ZMJMSJvl97ngRxGg6uRmT6Sud35ZDfkAEQz8ga6z52HpVRu85hK1IbbTxo3tIgcKbHuSPcIrvnjJfJ7zSCWXqV5bSnBoGWuRwyM+VYSz/sHFcVPQkUdcuM1b1TQlmkaIZt9Q0UQw3g8UysAE3h94zVyx/A/U=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CE4C37A99A8004492AB79C396ECCD8D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e2619412-48a4-47ea-976a-08d7a21b3bbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2020 04:50:14.7581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bop8AQdnknPnbXrFsIEgaClIEDn+rtF1KjBzBbdHdkh/NJWhZWxZY8DyG90F6EbE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3225
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-25_09:2020-01-24,2020-01-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001260040
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDEvMjUvMjAgODoxMCBQTSwgRGFuaWVsIFh1IHdyb3RlOg0KPiBPbiBTYXQgSmFuIDI1
LCAyMDIwIGF0IDY6NTMgUE0sIEFsZXhlaSBTdGFyb3ZvaXRvdiB3cm90ZToNCj4+IE9uIFNhdCwg
SmFuIDI1LCAyMDIwIGF0IDI6MzIgUE0gRGFuaWVsIFh1IDxkeHVAZHh1dXUueHl6PiB3cm90ZToN
Cj4+PiArICAgICAgIGF0dHIudHlwZSA9IFBFUkZfVFlQRV9IQVJEV0FSRTsNCj4+PiArICAgICAg
IGF0dHIuY29uZmlnID0gUEVSRl9DT1VOVF9IV19DUFVfQ1lDTEVTOw0KPj4+ICsgICAgICAgYXR0
ci5mcmVxID0gMTsNCj4+PiArICAgICAgIGF0dHIuc2FtcGxlX2ZyZXEgPSA0MDAwOw0KPj4+ICsg
ICAgICAgYXR0ci5zYW1wbGVfdHlwZSA9IFBFUkZfU0FNUExFX0JSQU5DSF9TVEFDSzsNCj4+PiAr
ICAgICAgIGF0dHIuYnJhbmNoX3NhbXBsZV90eXBlID0gUEVSRl9TQU1QTEVfQlJBTkNIX1VTRVIg
fCBQRVJGX1NBTVBMRV9CUkFOQ0hfQU5ZOw0KPj4+ICsgICAgICAgcGZkID0gc3lzY2FsbChfX05S
X3BlcmZfZXZlbnRfb3BlbiwgJmF0dHIsIC0xLCAwLCAtMSwgUEVSRl9GTEFHX0ZEX0NMT0VYRUMp
Ow0KPj4+ICsgICAgICAgaWYgKENIRUNLKHBmZCA8IDAsICJwZXJmX2V2ZW50X29wZW4iLCAiZXJy
ICVkXG4iLCBwZmQpKQ0KPj4+ICsgICAgICAgICAgICAgICBnb3RvIG91dF9kZXN0cm95Ow0KPj4N
Cj4+DQo+PiBJdCdzIGZhaWxpbmcgZm9yIG1lIGluIGt2bS4gSXMgdGhlcmUgd2F5IHRvIG1ha2Ug
aXQgd29yaz8NCj4+IENJcyB3aWxsIGJlIHZtIGJhc2VkIHRvby4gSWYgdGhpcyB0ZXN0IHJlcXVp
cmVzIHBoeXNpY2FsIGhvc3QNCj4+IHN1Y2ggdGVzdCB3aWxsIGtlZXAgZmFpbGluZyBpbiBhbGwg
c3VjaCBlbnZpcm9ubWVudHMuDQo+PiBGb2xrcyB3aWxsIGJlIGFubm95ZWQgYW5kIGV2ZW50dWFs
bHkgd2lsbCBkaXNhYmxlIHRoZSB0ZXN0Lg0KPj4gQ2FuIHdlIGZpZ3VyZSBvdXQgaG93IHRvIHRl
c3QgaW4gdGhlIHZtIGZyb20gdGhlIHN0YXJ0Pw0KPiANCj4gSXQgc2VlbXMgdGhlcmUncyBhIHBh
dGNoc2V0IHRoYXQncyBhZGRpbmcgTEJSIHN1cHBvcnQgdG8gZ3Vlc3QgaG9zdHM6DQo+IGh0dHBz
Oi8vbGttbC5vcmcvbGttbC8yMDE5LzgvNi8yMTUgLiBIb3dldmVyIGl0IHNlZW1zIHRvIGJlIHN0
dWNrIGluDQo+IHJldmlldyBsaW1iby4gSXMgdGhlcmUgYW55dGhpbmcgd2UgY2FuIGRvIHRvIGhl
bHAgdGhhdCBzZXQgYWxvbmc/DQo+IA0KPiBBcyBmYXIgYXMgaGFja2luZyBpdCwgbm90aGluZyBy
ZWFsbHkgY29tZXMgdG8gbWluZC4gU2VlbXMgdGhhdCBwYXRjaHNldA0KPiBpcyBvdXIgYmVzdCBo
b3BlLg0KDQpwcm9nX3Rlc3RzL3NlbmRfc2lnbmFsLmMgdGVzdHMgc2VuZF9zaWduYWwgaGVscGVy
IHVuZGVyIG5taSB3aXRoIA0KaGFyZHdhcmUgY291bnRlcnMuIEl0IGFkZGVkIGEgY2hlY2sgdG8g
c2VlIHdoZXRoZXIgdGhlIHVuZGVybHlpbmcNCmhhcmR3YXJlIGNvdW50ZXIgaXMgc3VwcG9ydGVk
LCBpZiBpdCBpcyBub3QsIHRoZSB0ZXN0IGlzDQpza2lwcGVkLg0KDQpNYXliZSB3ZSBjYW4gdXNl
IHRoZSBzYW1lIGFwcHJhb2NoIGhlcmUuIElmIHBlcmZfZXZlbnRfb3BlbiB3aXRoDQpQRVJGX1RZ
UEVfSEFSRFdBUkUvUEVSRl9TQU1QTEVfQlJBTkNIX1NUQUNLIGZhaWxlZCwNCndlIGp1c3QgbWFy
ayB0aGUgdGVzdCBhcyBza2lwcGVkIGluc3RlYWQgb2YgZmFpbGluZy4NCg==
