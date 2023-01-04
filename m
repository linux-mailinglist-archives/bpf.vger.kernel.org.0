Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78D965DF00
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 22:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbjADVYl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 16:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240244AbjADVVp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 16:21:45 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A992431A0
        for <bpf@vger.kernel.org>; Wed,  4 Jan 2023 13:17:03 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 304GJ3B9025805
        for <bpf@vger.kernel.org>; Wed, 4 Jan 2023 13:17:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=qQkLKv6XIgLuQeBBbA+FToIvqkq8JQUwLMU2P1IjR5A=;
 b=GbKGViYqtQ8KfldXr/1vPiwaK+jry3i0xdRO4on9HNO7Ct3LrZXl9GeMJYC9Vesr5yKg
 KtcbWYScZHj+kE/Tyy3driTl8BdRjd4WN9o1S163ZWjwsWVwSZAm/WFNuKTvss03D83p
 5Oe0hz2BjBSV2/tL3EBcTHehZJ2eSI0Cr2AIVuZnYl2c7UTpF5S4a0nCZs9f3Jw2Z+Jp
 5/MPmdePYLdeu7DFJQXWxUJ4wJRVpa+0bNqA4vCt9tMtFgytlnkehgDrcjZ6tPT2lD1V
 54KbCrStNoC7J2KcI1bhxVhwQLAJzzSRsnrDk0RGtIN72HUy/K7kIVC41KcZt/V8iG1F Sg== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by m0001303.ppops.net (PPS) with ESMTPS id 3mvvt8qwm4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 04 Jan 2023 13:17:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLbM06sv4JVmlWGQt9EVwdygPuVCOeAOLxcLbddbmtxzp+YtThgjG41trMOKe02QUNLbKHJVvpxz/E7qnlfsUGwAQVhS1XwMJmLJdYU+2rrpG63QDBKDQGi3BWaEksQQb7S5ZV50MdNoNIZ3na1KbIC3MXi7qinlo4mPFP78tA+Ahs19D4WJWl1q8b0qKG/xQAaMtmriVAYOtZmjUIHgMWzgo4FBHLe1PVK+Adb5o5i9dgNODi/wGUhxTFqfkUiouZ3/ePvpFHQ4faX8IJIv4xLEaFytqe5dz20CoUn+BIKQRrhbibVUGqCW3nCN8Dcj6V9IwHCDSSpZuxgmDSnLmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQkLKv6XIgLuQeBBbA+FToIvqkq8JQUwLMU2P1IjR5A=;
 b=ZUOl6AfC2/22mX6PATQifeRYTPcDR/r0HqlM4IgUSormXbQ5nPFVcV28vwerZNR1ov3a402cOMxAh80qPFS/SJv3N36/pBeci5msj3aoYcx6gjGDZnh0aauBVN4quau8DSn0htZ3DHH6BneiqRf55+70qWzLYxpal7EqUgpLlGHXRqNkSrb5Xo76+KIQ/MaLteodlkfbzO9TUITJTtkQbUad6bhGkproJkzYnyGRdevmefbu8DoUYiCpMehg9Yp87b9zkxX6YyfVsR6w7o/Y3bG3/JIxhoF689VIzgfT/WZfmHFSMh0ZJGsO+LVl4EoQEGjVdm2avKeuKhN/JFUt6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by PH7PR15MB5151.namprd15.prod.outlook.com (2603:10b6:510:13b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 21:16:59 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::307c:32e1:ea90:bbf3]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::307c:32e1:ea90:bbf3%7]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 21:16:59 +0000
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     Kernel Team <kernel-team@meta.com>, Yonghong Song <yhs@meta.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "song@kernel.org" <song@kernel.org>,
        Kui-Feng Lee <kuifeng@meta.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 0/2] bpf: fix the crash caused by task
 iterators over vma
Thread-Topic: [PATCH bpf-next v2 0/2] bpf: fix the crash caused by task
 iterators over vma
Thread-Index: AQHZEZxt/vuq5Z285EmId/qSoY9ryK6O4IQA
Date:   Wed, 4 Jan 2023 21:16:59 +0000
Message-ID: <691f88317785d0114a1c6b3626be7b7538b1978f.camel@fb.com>
References: <20221216221855.4122288-1-kuifeng@meta.com>
In-Reply-To: <20221216221855.4122288-1-kuifeng@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3651:EE_|PH7PR15MB5151:EE_
x-ms-office365-filtering-correlation-id: 342176d0-0469-4df7-a906-08daee99046b
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KNgwIbgOZcH5dcFPzaCgWqvmtjqYAw7C6iv9P6mTrlu7IfYlE0f2TKy/0u9uB8tyDwB9Ytnu8cPtHK76tuVON4YMK8V92kF3dHGW+WO6xOB1SOAmF0mVv4jpSeLcG0QHJJfhmFYpFRimwEK8jL0wpBMl14irgcQYW4+CaGYK/av+LZXCpZz1Mh+om4UHPyRjC3iq3RCDSsf2zdAttCBNkpdYK46itJBqcCPEDdzb/Gxj6HlDK0RnjeETGZo0Ha/BTstiqJvamrujVyeXJHysWIJiEMJsAqYMCxUqv+2RC1VW/BU+Qamu4laBkRB0tXdjRlDk6vxaTtV3v75pprMwSS0JUNusgPtM4EGjYWPSQhKqVJdxYYxvatBDypUwAyCfXSxThkMt4s03vae0hgYZUFZDBl3yddebgVEPTg0Uw/mnlUnTthuhDHLsFIv9YfH1OdWj6j54O4j1lkvE4VjHOxqRhakzotqsN1Wv/F8fk8F+biQ7atJg0BF7FRoGaV+2juJwiKbIAtaukchw0QUJWxmtzOEFFMVi4acBai6nVplKFu90cW6IEvDuXVp07zxptiVhKBBd5V/yPiCZZUbRXO3MhpEqGnf7YjcF48DWmT+yFyxr2EjcV3TAd5zEOuidKOMksvzqbWFjgRPQFkI0hVXWGyPAfNw4BPQPAczJDw6xp53NXitPnuTmTf2qhIVi4ppG7EGFhJRivZ97SHqeyyptFvKSq0Br6friOVQ4QzY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199015)(8936002)(4001150100001)(2906002)(41300700001)(38100700002)(76116006)(66946007)(122000001)(66476007)(5660300002)(8676002)(64756008)(66556008)(66446008)(83380400001)(6512007)(478600001)(966005)(38070700005)(71200400001)(6486002)(9686003)(186003)(316002)(110136005)(36756003)(6506007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDU5d3NCWDdzcTAwQVN6Ymk0L0dMbnZYS1BSNDd5MFFxK3dJWTJDNnJRcU1G?=
 =?utf-8?B?aUd4dWIwYi9IOUF5Rm9rdEl4WFdaaHdrM0VCRnBTZ1g0Q2FvbTI0UnJEQ3pl?=
 =?utf-8?B?dVUyZXlITkRoSkFGSmZ4NnlvSGF6UXR0OGNjbU9xd2lMNVF3ZWN3YXRieTV6?=
 =?utf-8?B?Zjg4dEZEd1Z0OEdpaXRjMUh3UEg4UjFPWXJ4OXZ3dnlHRkViVmZSY21wNWhD?=
 =?utf-8?B?M08rajBaZkg2c3pGTk1FazQzc0Q4SyttSC93WTlwYk1QVXBXT2dlQzBvdTR5?=
 =?utf-8?B?YXg4d0VhWVY0cnM4UWFDdlgwcXQ1VTBheEswUCtscFlKMjVQMHF4TDZ5SlZi?=
 =?utf-8?B?eitLQld2NGluN2hOZVRFdlBIclJSSFIrT0Z2Vkdoa2J3UEcveXhCdXF6S0Zn?=
 =?utf-8?B?WUszRksySjN2RDdNaStNSEFqTlRNRmZvL01peEN1V1paMjlodDlCVXZIN3hW?=
 =?utf-8?B?dFI1M3pTTlM1eFo2ZlVHZVd6M09IWGRiOWZ3ZGlDQyt1NG9UdW1Zbm5DVVhN?=
 =?utf-8?B?T05sTWp4Zkp3R1F3ZW1BcDJLdnFPcG9qdlY2S0dZY1BZcWVGZ1IrWVUybkRi?=
 =?utf-8?B?NUF1M2hBaDZZbE4zM3RZWDVNOGJhaUZUdUJ6azMxL1FmMGpzck9ubFBxSW9V?=
 =?utf-8?B?bkxxT1crRUFvWTJ5RERHUzRCZkJ3cVEzcDVrVjlKTDJxQXFabG0yRXBFV2VJ?=
 =?utf-8?B?THg0UzFBSGNsajQzbDdPYnhvbVdUSkd2L3BzRmFLTE0rdnZBaHVVdE9QbnJZ?=
 =?utf-8?B?a1VnZkltbkEzWFV2T3JDU25KQXFTTzcyeTJCdU1nZ1p5ZHhGdm5hRWxvaW5D?=
 =?utf-8?B?eXByV2VrTDhMblArOFUvRndxNWlPYmlodS9LVnVkN1luMEVUSytWdzBINnFN?=
 =?utf-8?B?QWlPeW1wVm9qR1Y1cExEYzh5RUFYTmlCREg0NzFSRGJ5RGNXVTZwSm4yRHFm?=
 =?utf-8?B?a1pUbWVQdHEvQytQdldodWg2WTJSclZnSGh0ak0yZTcwNWkzVEVrenhoZFZ3?=
 =?utf-8?B?bDNCQUpuaGVVc291aGRJWldjZlU1Z3FpQ3RRejZNRW1XU0xQbXYydjIySGta?=
 =?utf-8?B?QWtYbFhDa0pEYklpNzRVbU9XMnZma3pCL1JwSXE3Wkdud3RpdkE1b0NIa0Zx?=
 =?utf-8?B?b1VpdW1kN2FIanlIdFRTTExsTjh2UmhucmtBQkNsV2VYdHdkb2U2NVRTdU43?=
 =?utf-8?B?bURXbjhLemJ0a2hHa2kvM3RWZ2pBVDkvLzdlQTlOTnAwemJzLzRPM1JmWkZx?=
 =?utf-8?B?aEJFUEdnTmpYTk1OQ2c5OTFJRjg3N1JTTWtMVllNRGkybzZCYWY0L3JlcjZ6?=
 =?utf-8?B?TEdBNDhBTGUzaGNjUDVPT2toZEdnMXRWUVpDeUZMVVhndmhqb2s5bHFuTkhm?=
 =?utf-8?B?Z3pmMTBJVFM5RVdobTlZSG9KVituWkt1WFhCeEVNMzdaMGQrMFZYTGFtQzJM?=
 =?utf-8?B?VDgzSTMwY0ZHaGE0aS9MM1FPeDBoZ0NxVGxzYUFhK3JVVmc2WlBJQURQV040?=
 =?utf-8?B?UUV2bFNtbGY4cDRROThPZDhMVERadzFJY05Qc2E0RStFZnE0K0tUL2Z4ZVpB?=
 =?utf-8?B?MHhnL3FVWjFRaXBrei9uWmVrRmdpYlA5WndwbTdPTTVYOHh2cldnSXNqQ3RH?=
 =?utf-8?B?cS9jLy8ySENzd3N4UWQ1VG5kMGEvNVY5THFPWFhoYXFxckdWWkJlSTRjS2Va?=
 =?utf-8?B?cnZFVDBuOXNjOG1Oem1jZkZaT2Z2NENGbUQ4MFVrK0xnb2dlVE5jaG1XZTRG?=
 =?utf-8?B?bUZ2T1Y1d1M0Vy9qOVlWdktnZm1keTltZzR1VWJQLzVkYXV3WGpaNTJpaUcr?=
 =?utf-8?B?d2VheS9GSFpEZXVVZkUrelJSRVgrUmcrZ2tybHJaNWJrUGpyaUV3QW16cUZT?=
 =?utf-8?B?eXRwQUQrakMxWDhlcDdnM2wwdllrZWpYSnBHbHR3bU1VV01tSTNpT0JFWmwz?=
 =?utf-8?B?emdpUjBiZnVKNytWbWpmUXh6cjlDNDVONW9QcDRoUFRDcDdOQnpNU05rUHgr?=
 =?utf-8?B?RXpIaXlLN0M3cjFwVWZ2OXRZcjdpQzdFMmo2RGdjU0F4dFpHTzVvWFlRa3A3?=
 =?utf-8?B?WW1MWk5Eb3VqK2MrL21EZlZYeWhjL1NlMk15cS80akhyRFhiVENnZDFta3hp?=
 =?utf-8?B?WkdNSUY4UjlDMVFNcUZnRmhqV3lFTlBPUDNRSkpqZHVpN2lNV05YKzYwZVRK?=
 =?utf-8?Q?bI4PTjrPtqaL/QXWIqEe2IU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C7CD07F18828849B7008A9197F9E4D5@namprd15.prod.outlook.com>
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 342176d0-0469-4df7-a906-08daee99046b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2023 21:16:59.7449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AUSRk4QqorabFf23MpDRQb+FMvyrvT4WqndVybdBAOSpy8v/CGKKZAQg/af5X4qmZeapTzdb403YPcb7+2/eNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5151
X-Proofpoint-GUID: sv0h79cWVWU8g-qDgZzQNrqHjqWBAZz2
X-Proofpoint-ORIG-GUID: sv0h79cWVWU8g-qDgZzQNrqHjqWBAZz2
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SGkgZXZlcnlvbmUsDQoNClRoaXMgcGF0Y2hzZXQgc2VlbXMgdG8gYmUgZm9yZ290IGR1cmluZyB0
aGUgaG9saWRheSBzZWFzb24uDQpIb3BlIHRoaXMgbWVzc2FnZSBnZXRzIHNvbWUgbm90aWNlLg0K
DQpPbiBGcmksIDIwMjItMTItMTYgYXQgMTQ6MTggLTA4MDAsIEt1aS1GZW5nIExlZSB3cm90ZToN
Cj4gVGhpcyBpc3N1ZSBpcyByZWxhdGVkIHRvIHRhc2sgaXRlcmF0b3JzIG92ZXIgdm1hLiBBIHN5
c3RlbSBjcmFzaCBjYW4NCj4gb2NjdXIgd2hlbiBhIHRhc2sgaXRlcmF0b3IgdHJhdmVscyB0aHJv
dWdoIHZtYSBvZiB0YXNrcyBhcyB0aGUgZGVhdGgNCj4gb2YgYSB0YXNrIHdpbGwgY2xlYXIgdGhl
IHBvaW50ZXIgdG8gaXRzIG1tLCBldmVuIHRob3VnaCB0aGUNCj4gdGFza19zdHJ1Y3QgaXMgc3Rp
bGwgaGVsZC4gQXMgYSByZXN1bHQsIGFuIHVuZXhwZWN0ZWQgY3Jhc2ggaGFwcGVucw0KPiBkdWUg
dG8gYSBudWxsIHBvaW50ZXIuIFRvIGFkZHJlc3MgdGhpcyBwcm9ibGVtLCBhIHJlZmVyZW5jZSB0
byBtbSBpcw0KPiBrZXB0IG9uIHRoZSBpdGVyYXRvciB0byBtYWtlIHN1cmUgdGhhdCB0aGUgcG9p
bnRlciBpcyBhbHdheXMNCj4gdmFsaWQuIFRoaXMgcGF0Y2ggc2V0IHByb3ZpZGVzIGEgc29sdXRp
b24gZm9yIHRoaXMgY3Jhc2ggYnkgcHJvcGVybHkNCj4gcmVmZXJlbmNpbmcgbW0gb24gdGFzayBp
dGVyYXRvcnMgb3ZlciB2bWEuDQo+IA0KPiBUaGUgbWFqb3IgY2hhbmdlcyBmcm9tIHYxIGFyZToN
Cj4gDQo+IMKgLSBGaXggY29tbWl0IGxvZ3Mgb2YgdGhlIHRlc3QgY2FzZS4NCj4gDQo+IMKgLSBV
c2UgcmV2ZXJzZSBDaHJpc3RtYXMgdHJlZSBjb2Rpbmcgc3R5bGUuDQo+IA0KPiDCoC0gUmVtb3Zl
IHVubmVjZXNzYXJ5IGVycm9yIGhhbmRsaW5nIGZvciB0aW1lKCkuDQo+IA0KPiB2MToNCj4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYnBmLzIwMjIxMjE2MDE1OTEyLjk5MTYxNi0xLWt1aWZlbmdA
bWV0YS5jb20vDQo+IA0KPiBLdWktRmVuZyBMZWUgKDIpOg0KPiDCoCBicGY6IGtlZXAgYSByZWZl
cmVuY2UgdG8gdGhlIG1tLCBpbiBjYXNlIHRoZSB0YXNrIGlzIGRlYWQuDQo+IMKgIHNlbGZ0ZXN0
cy9icGY6IGFkZCBhIHRlc3QgZm9yIGl0ZXIvdGFza192bWEgZm9yIHNob3J0LWxpdmVkDQo+IHBy
b2Nlc3Nlcw0KPiANCj4gwqBrZXJuZWwvYnBmL3Rhc2tfaXRlci5jwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDM5ICsrKysrKystLS0NCj4gwqAuLi4vc2Vs
ZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL2JwZl9pdGVyLmPCoMKgwqDCoMKgwqAgfCA3Mw0KPiArKysr
KysrKysrKysrKysrKysrDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAxMDAgaW5zZXJ0aW9ucygrKSwg
MTIgZGVsZXRpb25zKC0pDQo+IA0KDQo=
