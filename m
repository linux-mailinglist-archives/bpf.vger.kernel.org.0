Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF5333D30F
	for <lists+bpf@lfdr.de>; Tue, 16 Mar 2021 12:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbhCPL36 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Mar 2021 07:29:58 -0400
Received: from mail-dm6nam11on2054.outbound.protection.outlook.com ([40.107.223.54]:6113
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234605AbhCPL3i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Mar 2021 07:29:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhJ0oiHMQl3y3b13JPEX7two1DlL1IkA9E8CBdtKbaZbbTqIKz1eNrat8yt0F9fjWKuNGDbuS4o68EX+vQrRFtDOkIEabd56ghdbyvWNiDhMp8P6pTJPW5p0jepKpiozTayRY4+DIStNYbnj1h2tLKZmGva8MiZ8QdVrFm6V/f4zlBrFo6ZvfZ/SXNcUdcSE4asKY4nPLl72sAXfHtKqfW5EYyOb6EX1/6+J+vtke+HyxSc4fELRRnsGPz73ObaqxweK6Ugr9d5R3VJzMEMPr1wJseJc3cPDiKw3kkmHig/uuwbKm3JkCd7do+Znqi96LgOm8JDynI8LTytqvk2lOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzlIiO70faCxmLwDITEOrOpFlW4JMqAjmPx2pkRtSBE=;
 b=BRB+SCJ0i+V3BgUEIofmKJad5s67kI4eKNEpRK0HN4V4/qmpATubH3J9Ft8Ahck/iuTeBfropoP5h1wVAP5W+hEhyvH0K0hY4Ds+0WPfNuK+G99/znJ8SRqBDffoZfACGTKowiAQYgiYoZWvLMQ1fWD3bd+fOcNkxry6NWEktFx+yu9K49YGp4X21oFaXIduuZTLNHhzk2BIuMOhsJLxn6fVZZR2jBiopALexL7onQsJo5g1rBl3RO/MDmbMUhTBPDRXqx/rnwz+tFjZPy61UfbKBlHGS64AWXfwUtDyTiPBS8ZICWFD1pPGM/IADMNpuRIqd3VHwTzXmcUn7eYQIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzlIiO70faCxmLwDITEOrOpFlW4JMqAjmPx2pkRtSBE=;
 b=XMvIgfKI6GyTEvKTN1TUFa8Ox8OMAsn3p4F955X5uTSIN3eAps5fjSkaiAd/9et2r3TCsEmxXvJuw48JOZGunabt9I7WczcwSG9j/sQcA9uUR0/x5153jRvbYc7avseL9ZV54KfZoT2g9PJKUoMg20tzgSLbwUttlCzIRhDBN9U=
Received: from DM6PR11MB4202.namprd11.prod.outlook.com (2603:10b6:5:1df::16)
 by DM5PR1101MB2268.namprd11.prod.outlook.com (2603:10b6:4:53::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 11:29:36 +0000
Received: from DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::f19f:b31:c427:730e]) by DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::f19f:b31:c427:730e%4]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 11:29:36 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
CC:     "dvyukov@google.com" <dvyukov@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzbot+44908bb56d2bfe56b28e@syzkaller.appspotmail.com" 
        <syzbot+44908bb56d2bfe56b28e@syzkaller.appspotmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIHYyXSBicGY6IEZpeCBtZW1vcnkgbGVhayBpbiBjb3B5?=
 =?gb2312?Q?=5Fprocess()?=
Thread-Topic: [PATCH v2] bpf: Fix memory leak in copy_process()
Thread-Index: AQHXGXisamgV0cMrEEG9Ytn4tLDnhqqGekcZ
Date:   Tue, 16 Mar 2021 11:29:36 +0000
Message-ID: <DM6PR11MB4202D95C3B579C7A6F381A97FF6B9@DM6PR11MB4202.namprd11.prod.outlook.com>
References: <20210315085816.21413-1-qiang.zhang@windriver.com>
In-Reply-To: <20210315085816.21413-1-qiang.zhang@windriver.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [106.39.150.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44f65fcf-5e6d-4ce4-dee6-08d8e86ec7b9
x-ms-traffictypediagnostic: DM5PR1101MB2268:
x-microsoft-antispam-prvs: <DM5PR1101MB2268C95B2702DBC19EF5D853FF6B9@DM5PR1101MB2268.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8/ygk8zU18xUdgwZpdeiiYKHxZDwmEIYXF1FYIe81oEEdqF85vF1YHw0Zm0zhrc6cRU29LeIV4225T5yubAGHz6u8AX19nk3yAIh9n7Bt5d2gX3VVb53hZHCejT96gb1f/We/WbZTQ89f8r12pBH8A/O2RUEBmFlstjrl8XvoQqD4zbUg8VrE4N/k9M35gTryIdyoIZPLwyw3umZ+MJW5jLr5uIUDxja3DlKa3Xw8OLn3SUOmN+EqQov6Sjj4Jg1pR9wwQ2i08dT5+7q6/zjoxO4eRr9u6VzZFElZW++c6IghLv758CpxFqg6CjBdsTeUONZS1kzydnkA5e+VpKhURJhk1CIskSJsmZYhvIZMz6l5Jhj9T9Ckv8UqTlWmSx28lBhWyxYqHhBKivGCewHK3eD8KpkogFy6qQ0JStRtjYdeZ5REqsbzhjGaEyRrOWjFxFDRfaLFwNd0mpSQemvcj+jXft7R3yrDdpDD5oJd4mgAkXyYhLbuYmz10/drVclpMicVvHtJvX/k8HLSQfOjOaztQgQiJAtmOdJnKbAvFQ+Ac91ztbcIIq8/KFPa9RG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4202.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(136003)(346002)(366004)(396003)(376002)(66556008)(91956017)(110136005)(6506007)(4326008)(66476007)(64756008)(54906003)(76116006)(8936002)(33656002)(26005)(7416002)(5660300002)(52536014)(316002)(83380400001)(7696005)(66946007)(66446008)(9686003)(224303003)(86362001)(71200400001)(186003)(2906002)(55016002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?aEsyakJjb1hHNEhKVDAvbGl5azNLY3lMNGxzcHYzaEVHUkIwRy9RUHlBWVZR?=
 =?gb2312?B?WGdTb1c4ZkpRenRlMWQ0MW5Mc05QdUlGYi9IbUs5YWYvTUd1QVZ1aVBPU2Vv?=
 =?gb2312?B?T1ZzTHhIc3BTU1I3UVk1blNQbXF3cGxKd00wR3dHaitzTGZyakpiWUc5Snlo?=
 =?gb2312?B?QytsUWd3QVIyc2RuOGh3dUk5dmFYVGo2V0FTbXlicHZpeEJFZ2ViWlhEc2hL?=
 =?gb2312?B?dHdxMDBDd2VzaGNlYndhVmRpTEZMUUZyZXY2WEZEc0NFZk9ubVFmWnFyKytp?=
 =?gb2312?B?dXBBMWtFVVZ0aEF4ME8xU3c3UWJDdlVHQXozdGthbGh6Q1FLMk1ia0tsUEg5?=
 =?gb2312?B?dmwvTWF3OHc3Y3lmTzhHTkx6VHpkU2ZLNURIbnJWaGJvZURrV0M3bmdHREJI?=
 =?gb2312?B?Ky9HUXhWaHNXUlNjVnUrY3NQMUw1cmlwdzFLZDF6UVo3WVU0a3NHRjJGRHM3?=
 =?gb2312?B?WndvY1dOOTFHNUpiNGtZZmFmclRpTVpDYkt4MXpVa1cyRFVuYmw5dUNSY0xQ?=
 =?gb2312?B?TUhIK2tOS2tqQjkzdEIyb1orMC9Eb2MyUmdKVDNhSURXTjAvbFc1ZW5qc3dT?=
 =?gb2312?B?aWJ3dmpBNVB2OWRtRThCTEd1VTRPSU90b05Id0VjNm9Yc01xck1JcVpPRWt0?=
 =?gb2312?B?Ri9sNExXS0tod2RuazZyZGNST2dNR2UrOThaWmZ0bjMycjdWeDJSdDUvcE5o?=
 =?gb2312?B?dy91K0pTWDVSbklXV2RCMXJNVXZ6U09talc5WExXZ0dOSFZueXp1RVU2NXVm?=
 =?gb2312?B?alFndm5VQjF4R0R0QVMvWlg0T0p3eFM3c2JNb3BEcGtxcjNLajVseVdYZmZJ?=
 =?gb2312?B?MlVwSlBsaCtKMzZkR1MzaTBqWC9idHhGMlNneThTWW1JVE1oRE1HZkU1NVJs?=
 =?gb2312?B?djdHVWEwd0FiZ2VEdDViWHJqU1I4ZjNoTUx4WThsQno1M05ML0NuN08xOHEy?=
 =?gb2312?B?bjh4TjA5ZExOS04yMXljSDJLbnRkb0JtNnA4YzE2N1Era21FYlA5TElaZUtt?=
 =?gb2312?B?UGkyOGh5SElYd25vMU9DV1pUeHZxbGZ4ajhyVk14K3k2RXdleWpHaG1XaHRR?=
 =?gb2312?B?N2ZYNFYrdzdvUS9rRWloY3UzTDNqcnF5TEh3SEJjQkF0dC83cGg3T2xoNFVn?=
 =?gb2312?B?OW10akpwb2FDYTJnM0VXVFU4WStsNkF5OFdJS0dSV1JuWHpHbVEwd0pWV2VK?=
 =?gb2312?B?dlNKSTkrQWx6TWFsQk51ZDAramhIcmsrS1FieXJacG5zNmpta1Z6a0twR3Zv?=
 =?gb2312?B?L09jc2R3WEZiRC80ekJXVWFiUy9Ob2o0VWI2anMwMnhCN1hEakRuNDFNR0N0?=
 =?gb2312?B?Q1pkdUJlWmlkVVpHYk5YL2thQWZVVTVHWjhWN0JwUWY0ZURiWXp2QWc3Z0VT?=
 =?gb2312?B?RnRidTJ5a3kvV0gzL0hDM2gyR3FWMUwvWlhDZ0NyR0J4MVlEMDNPL1pJdmVE?=
 =?gb2312?B?eUp5N3RGMHdockRZc1pPQmU1eTlKc3pkRk02SHFuZEpDTmw1T0Jjais1MnZ6?=
 =?gb2312?B?eGZBc0w3Q0MweVRsaWNQcFN3SkJiQ3duR05DNUZGRmpJQWxDS3BjQkt6c2wz?=
 =?gb2312?B?elJhR3o1ak1BWitPaDY1SDNPSWFKQzJZNzVHK0hDNTY1bi9MZEtGL2xrZWxS?=
 =?gb2312?B?NnlobjJsTVJNYVdrRkpLWXhLb2V4enI1R2M1TFpCTFp1WGVqV0xVSXNaOUtJ?=
 =?gb2312?B?VWtncWJ2dW9TQzBpWFZlcHNRRTU4WHowcmJBMk90RGdINldDenNQa1o3eVpw?=
 =?gb2312?Q?HfFIrhOAVuDI2X6bak=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4202.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f65fcf-5e6d-4ce4-dee6-08d8e86ec7b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 11:29:36.7229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n1qNhN1TuDF4SVopwCr+ohVQsJwLPCtcYaydLvaVVPfhsHun/ZO2vdrIQ6m3ZS8x4vmoMGPeXiAXMSYhK5TYFRYMm8SAvRpjJcjtWVm8QPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2268
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SGVsbG8gQWxleGVpIFN0YXJvdm9pdG92IERhbmllbCBCb3JrbWFubgpQbGVhc2UgIHJldmlldyB0
aGlzIHBhdGNoLgoKVGhhbmtzClFpYW5nCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCreivP7IyzogWmhhbmcsIFFpYW5nIDxxaWFuZy56aGFuZ0B3aW5kcml2ZXIuY29t
Pgq3osvNyrG85DogMjAyMcTqM9TCMTXI1SAxNjo1MwrK1bz+yMs6IGFzdEBrZXJuZWwub3JnOyBk
YW5pZWxAaW9nZWFyYm94Lm5ldDsgYW5kcmlpQGtlcm5lbC5vcmcKs63LzTogZHZ5dWtvdkBnb29n
bGUuY29tOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBzeXpib3QrNDQ5MDhiYjU2ZDJi
ZmU1NmIyOGVAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbTsgYnBmQHZnZXIua2VybmVsLm9yZzsg
WmhhbmcsIFFpYW5nCtb3zOI6IFtQQVRDSCB2Ml0gYnBmOiBGaXggbWVtb3J5IGxlYWsgaW4gY29w
eV9wcm9jZXNzKCkKCkZyb206IFpxaWFuZyA8cWlhbmcuemhhbmdAd2luZHJpdmVyLmNvbT4KClRo
ZSBzeXpib3QgcmVwb3J0IGEgbWVtbGVhayBmb2xsb3c6CkJVRzogbWVtb3J5IGxlYWsKdW5yZWZl
cmVuY2VkIG9iamVjdCAweGZmZmY4ODgxMDFiNDFkMDAgKHNpemUgMTIwKToKICBjb21tICJrd29y
a2VyL3U0OjAiLCBwaWQgOCwgamlmZmllcyA0Mjk0OTQ0MjcwIChhZ2UgMTIuNzgwcykKICBiYWNr
dHJhY2U6CiAgICBbPGZmZmZmZmZmODEyNWRjNTY+XSBhbGxvY19waWQrMHg2Ni8weDU2MAogICAg
WzxmZmZmZmZmZjgxMjI2NDA1Pl0gY29weV9wcm9jZXNzKzB4MTQ2NS8weDI1ZTAKICAgIFs8ZmZm
ZmZmZmY4MTIyNzk0Mz5dIGtlcm5lbF9jbG9uZSsweGYzLzB4NjcwCiAgICBbPGZmZmZmZmZmODEy
MjgxYTE+XSBrZXJuZWxfdGhyZWFkKzB4NjEvMHg4MAogICAgWzxmZmZmZmZmZjgxMjUzNDY0Pl0g
Y2FsbF91c2VybW9kZWhlbHBlcl9leGVjX3dvcmsKICAgIFs8ZmZmZmZmZmY4MTI1MzQ2ND5dIGNh
bGxfdXNlcm1vZGVoZWxwZXJfZXhlY193b3JrKzB4YzQvMHgxMjAKICAgIFs8ZmZmZmZmZmY4MTI1
OTFjOT5dIHByb2Nlc3Nfb25lX3dvcmsrMHgyYzkvMHg2MDAKICAgIFs8ZmZmZmZmZmY4MTI1OWFi
OT5dIHdvcmtlcl90aHJlYWQrMHg1OS8weDVkMAogICAgWzxmZmZmZmZmZjgxMjYxMWM4Pl0ga3Ro
cmVhZCsweDE3OC8weDFiMAogICAgWzxmZmZmZmZmZjgxMDAyMjdmPl0gcmV0X2Zyb21fZm9yaysw
eDFmLzB4MzAKCnVucmVmZXJlbmNlZCBvYmplY3QgMHhmZmZmODg4MTEwZWY1YzAwIChzaXplIDIz
Mik6CiAgY29tbSAia3dvcmtlci91NDowIiwgcGlkIDg0MTQsIGppZmZpZXMgNDI5NDk0NDI3MCAo
YWdlIDEyLjc4MHMpCiAgYmFja3RyYWNlOgogICAgWzxmZmZmZmZmZjgxNTRhMGNmPl0ga21lbV9j
YWNoZV96YWxsb2MKICAgIFs8ZmZmZmZmZmY4MTU0YTBjZj5dIF9fYWxsb2NfZmlsZSsweDFmLzB4
ZjAKICAgIFs8ZmZmZmZmZmY4MTU0YTgwOT5dIGFsbG9jX2VtcHR5X2ZpbGUrMHg2OS8weDEyMAog
ICAgWzxmZmZmZmZmZjgxNTRhOGYzPl0gYWxsb2NfZmlsZSsweDMzLzB4MWIwCiAgICBbPGZmZmZm
ZmZmODE1NGFiMjI+XSBhbGxvY19maWxlX3BzZXVkbysweGIyLzB4MTQwCiAgICBbPGZmZmZmZmZm
ODE1NTkyMTg+XSBjcmVhdGVfcGlwZV9maWxlcysweDEzOC8weDJlMAogICAgWzxmZmZmZmZmZjgx
MjZjNzkzPl0gdW1kX3NldHVwKzB4MzMvMHgyMjAKICAgIFs8ZmZmZmZmZmY4MTI1MzU3ND5dIGNh
bGxfdXNlcm1vZGVoZWxwZXJfZXhlY19hc3luYysweGI0LzB4MWIwCiAgICBbPGZmZmZmZmZmODEw
MDIyN2Y+XSByZXRfZnJvbV9mb3JrKzB4MWYvMHgzMAoKYWZ0ZXIgdGhlIFVNRCBwcm9jZXNzIGV4
aXRzLCB0aGUgcGlwZV90b191bWgvcGlwZV9mcm9tX3VtaCBhbmQgdGdpZApuZWVkIHRvIGJlIHJl
bGVhc2UuCgpGaXhlczogZDcxZmE1Yzk3NjNjICgiYnBmOiBBZGQga2VybmVsIG1vZHVsZSB3aXRo
IHVzZXIgbW9kZSBkcml2ZXIgdGhhdCBwb3B1bGF0ZXMgYnBmZnMuIikKUmVwb3J0ZWQtYnk6IHN5
emJvdCs0NDkwOGJiNTZkMmJmZTU2YjI4ZUBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tClNpZ25l
ZC1vZmYtYnk6IFpxaWFuZyA8cWlhbmcuemhhbmdAd2luZHJpdmVyLmNvbT4KLS0tCiB2MS0+djI6
CiBKdWRnZSB3aGV0aGVyIHRoZSBwb2ludGVyIHZhcmlhYmxlIHRnaWQgaXMgdmFsaWQuCgoga2Vy
bmVsL2JwZi9wcmVsb2FkL2JwZl9wcmVsb2FkX2tlcm4uYyB8IDI0ICsrKysrKysrKysrKysrKysr
KysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEva2VybmVsL2JwZi9wcmVsb2FkL2JwZl9wcmVsb2FkX2tlcm4uYyBiL2tl
cm5lbC9icGYvcHJlbG9hZC9icGZfcHJlbG9hZF9rZXJuLmMKaW5kZXggNzljNTc3MjQ2NWYxLi41
MDA5ODc1ZjAxZDMgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9icGYvcHJlbG9hZC9icGZfcHJlbG9hZF9r
ZXJuLmMKKysrIGIva2VybmVsL2JwZi9wcmVsb2FkL2JwZl9wcmVsb2FkX2tlcm4uYwpAQCAtNCw2
ICs0LDcgQEAKICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KICNpbmNsdWRlIDxsaW51eC9waWQu
aD4KICNpbmNsdWRlIDxsaW51eC9mcy5oPgorI2luY2x1ZGUgPGxpbnV4L2ZpbGUuaD4KICNpbmNs
dWRlIDxsaW51eC9zY2hlZC9zaWduYWwuaD4KICNpbmNsdWRlICJicGZfcHJlbG9hZC5oIgoKQEAg
LTIwLDYgKzIxLDE0IEBAIHN0YXRpYyBzdHJ1Y3QgYnBmX3ByZWxvYWRfb3BzIHVtZF9vcHMgPSB7
CiAgICAgICAgLm93bmVyID0gVEhJU19NT0RVTEUsCiB9OwoKK3N0YXRpYyB2b2lkIGJwZl9wcmVs
b2FkX3VtaF9jbGVhbnVwKHN0cnVjdCB1bWRfaW5mbyAqaW5mbykKK3sKKyAgICAgICBmcHV0KGlu
Zm8tPnBpcGVfdG9fdW1oKTsKKyAgICAgICBmcHV0KGluZm8tPnBpcGVfZnJvbV91bWgpOworICAg
ICAgIHB1dF9waWQoaW5mby0+dGdpZCk7CisgICAgICAgaW5mby0+dGdpZCA9IE5VTEw7Cit9CisK
IHN0YXRpYyBpbnQgcHJlbG9hZChzdHJ1Y3QgYnBmX3ByZWxvYWRfaW5mbyAqb2JqKQogewogICAg
ICAgIGludCBtYWdpYyA9IEJQRl9QUkVMT0FEX1NUQVJUOwpAQCAtNjEsOCArNzAsMTAgQEAgc3Rh
dGljIGludCBmaW5pc2godm9pZCkKICAgICAgICBpZiAobiAhPSBzaXplb2YobWFnaWMpKQogICAg
ICAgICAgICAgICAgcmV0dXJuIC1FUElQRTsKICAgICAgICB0Z2lkID0gdW1kX29wcy5pbmZvLnRn
aWQ7Ci0gICAgICAgd2FpdF9ldmVudCh0Z2lkLT53YWl0X3BpZGZkLCB0aHJlYWRfZ3JvdXBfZXhp
dGVkKHRnaWQpKTsKLSAgICAgICB1bWRfb3BzLmluZm8udGdpZCA9IE5VTEw7CisgICAgICAgaWYg
KHRnaWQpIHsKKyAgICAgICAgICAgICAgIHdhaXRfZXZlbnQodGdpZC0+d2FpdF9waWRmZCwgdGhy
ZWFkX2dyb3VwX2V4aXRlZCh0Z2lkKSk7CisgICAgICAgICAgICAgICBicGZfcHJlbG9hZF91bWhf
Y2xlYW51cCgmdW1kX29wcy5pbmZvKTsKKyAgICAgICB9CiAgICAgICAgcmV0dXJuIDA7CiB9CgpA
QCAtODAsMTAgKzkxLDE1IEBAIHN0YXRpYyBpbnQgX19pbml0IGxvYWRfdW1kKHZvaWQpCgogc3Rh
dGljIHZvaWQgX19leGl0IGZpbmlfdW1kKHZvaWQpCiB7CisgICAgICAgc3RydWN0IHBpZCAqdGdp
ZDsKICAgICAgICBicGZfcHJlbG9hZF9vcHMgPSBOVUxMOwogICAgICAgIC8qIGtpbGwgVU1EIGlu
IGNhc2UgaXQncyBzdGlsbCB0aGVyZSBkdWUgdG8gZWFybGllciBlcnJvciAqLwotICAgICAgIGtp
bGxfcGlkKHVtZF9vcHMuaW5mby50Z2lkLCBTSUdLSUxMLCAxKTsKLSAgICAgICB1bWRfb3BzLmlu
Zm8udGdpZCA9IE5VTEw7CisgICAgICAgdGdpZCA9IHVtZF9vcHMuaW5mby50Z2lkOworICAgICAg
IGlmICh0Z2lkKSB7CisgICAgICAgICAgICAgICBraWxsX3BpZCh0Z2lkLCBTSUdLSUxMLCAxKTsK
KyAgICAgICAgICAgICAgIHdhaXRfZXZlbnQodGdpZC0+d2FpdF9waWRmZCwgdGhyZWFkX2dyb3Vw
X2V4aXRlZCh0Z2lkKSk7CisgICAgICAgICAgICAgICBicGZfcHJlbG9hZF91bWhfY2xlYW51cCgm
dW1kX29wcy5pbmZvKTsKKyAgICAgICB9CiAgICAgICAgdW1kX3VubG9hZF9ibG9iKCZ1bWRfb3Bz
LmluZm8pOwogfQogbGF0ZV9pbml0Y2FsbChsb2FkX3VtZCk7Ci0tCjIuMTcuMQoK
