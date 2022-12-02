Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CF063FD7A
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 02:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiLBBGh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Dec 2022 20:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiLBBGg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Dec 2022 20:06:36 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567ADCE439
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 17:06:33 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B211iCj017397
        for <bpf@vger.kernel.org>; Thu, 1 Dec 2022 17:06:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=sifvvsZefSkjQ61PzSRDFUUbFjUsXJA9eI+iN1PWcCY=;
 b=XzrgsJojO2UGOzm0WQaduLcOFLSFlJWw5EDMo88ACoTAJfo09rF/6aCBbhirl/n1Iz4a
 MloAsWP9bQk086h79kmdHau4ZXPROlHJsAgysTw6qxEU2zwoCeQe1wBBSbVE4AhdJsY2
 jFUWMEPpNzLyG9DqZC/x+UgC3J5UAmvjFzWRmIqGY6+QlU4q1Ry1hVgKysuNoZgmZDgg
 ZxSrcUXNEsPYVLnNYwqHawu0qXC9Nbo70vVs1+wCOcSFyUQJVT+AXVFPQ82leM2/+Dx2
 NoetnXKsgSChHLzdlzn4xxnio2vUimmd71JVSMG383O1f4YiFJSwgBxwKoqyinCDq+Jl Og== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m65bd1su6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 01 Dec 2022 17:06:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6Bq/SlIxSUfnNG53Z7OO+zYYqaPZJ8VOtDvDlp/ewpIcd3CLaJIikjvJjxI1KDin9j+G8fhRgm2GhmE1TBYrk4sCwQpLxhiVtbfR3ili4fa4kNwEbY8gps9L4qeqATuioHm9jHQwAgII/xPKNVfLRRtGVDMIsXW9ZB84kXLBoFW1+v5vQWMRk5TC+bSHZnY0POhdatrMd5HS1wGJF/7QopLEQt1rQQVnj8YEqzDu9TLb4yRmv+hywEQOkLR2cfRpC6jOAmBX8XxTaaKNgOK6gAkj8Pyh0jc1V2pyAJnsVp1dozSOw5fcDFWwlQunabZbiHOZnlD54j5Zjd9KUQOPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sifvvsZefSkjQ61PzSRDFUUbFjUsXJA9eI+iN1PWcCY=;
 b=TiUVj8mkGmC6sRFmL8gqhhNEJR973aDz25a2AxTCB/xO/jpfWlJ1hgFiBjx85pRXxUkGV1Mbm/9GV1sQ28PaAIpGGdWtxPnof1h9o4Mmrq4xAxsiz2XXfMgkjjq2H5Tk4QMd54S3xCRNcsiGf+AgWqKBw/UNxByHHIDsbPynbYVkhDDSO1jS94/8bGpQ+FW5w4XDF9Z8b++WJKNwXCW2YAX8tAhqh0HhlQ+WMCzNTxGUsAY1DIN9TB6noyAgtBpiusPvnvAg5mWZcdmNFqINDCdB6cZBiGhfqAPlCwyR1ATRGB80O7CJZC/eymcW9BadEhHMjmkf4AAkKpiIkk2y3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by PH7PR15MB5224.namprd15.prod.outlook.com (2603:10b6:510:133::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 01:06:29 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::ffe0:f829:d4c9:9cdc]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::ffe0:f829:d4c9:9cdc%7]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 01:06:29 +0000
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <kernel-team@meta.com>,
        Yonghong Song <yhs@meta.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Change the name
 kprobe_multi_test/bench_attach to kprobe_multi_bench_attach in DENYLIST.
Thread-Topic: [PATCH bpf-next] selftests/bpf: Change the name
 kprobe_multi_test/bench_attach to kprobe_multi_bench_attach in DENYLIST.
Thread-Index: AQHZBeGIytev7VFMGUaS8VR8UGLU3a5ZyNiA
Date:   Fri, 2 Dec 2022 01:06:28 +0000
Message-ID: <ddd813553b36ea2ad77f7ef49c4735f376ad4d01.camel@fb.com>
References: <20221202000249.3865528-1-kuifeng@fb.com>
In-Reply-To: <20221202000249.3865528-1-kuifeng@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3651:EE_|PH7PR15MB5224:EE_
x-ms-office365-filtering-correlation-id: a6c38fe8-b59e-48a7-52de-08dad4017179
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SWd1XajuLCxb48gGOi1bDMwD3tNaNNwyTmpmq+UfTIeJrXlmpcL1zBLGRqlL4qCy1/0wpqY9NrOSTrmayYa1s0BzHLwrbf1XNzb5uVVKJ9zNUwWXwDVfWdSBq22Mx7gBEFL4h+9sN4RwQn/nVPwt96JbMUZNqjipnMg/yrz95wIz50VvDUZiMDwmMhp+/2QUNwARY3lAXIB79hI2GnaYUZuKT+KjdmcLs2xBUVsZJV9IXKg2a7OtpwII+Z7vnlPHuU4R6t9azeTTYOgANi3AVpX3cEg1almSEELxKdV6mf272kVDYIAvE4/BzyomHbsOp8Dyvy7K1fN17Df6BrzfnRbeDWZeFa89GMFvfji3I9fxKaHMd4ozKsdiEvLTkmjCb7aEa4k0GY1lrnSyowS8CGyvCTPyp1RRQbcWLv/wNRdvOdygNsvgVGDKFY2AiKGk0DHvqJKKX2FhBHzFG/dSNLdgKSeIealV3QYET3i2CL//PDRDWEj0QLZABUPK2ACcknxWp+qFzVDvj74Tg9LR70VulG484Sh4NXU+8GhT+641aJs9RDKwmASO6FUZLTxbQQpaJC+p8Htd/L+fOzrXk2Wpicc5UAfBlZaWUIIHnuUCkRLLf3MSP+i9kPyA5GiU4h360HavUr1ONA1rX67WfQ+6ljY7p46i8LSKdNYJRUnCV4ujuevbGR9OdkKHJHR9eL9MM32ufJP91ySvafW5gI75BNQqkwaQv8+7ssin2mDYVLcw3h13CidzaH8kAzKb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199015)(64756008)(110136005)(71200400001)(8936002)(966005)(66446008)(8676002)(76116006)(41300700001)(5660300002)(83380400001)(66476007)(66556008)(66946007)(36756003)(478600001)(122000001)(38100700002)(38070700005)(6506007)(6486002)(86362001)(9686003)(6512007)(186003)(316002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGRkUTN2b081WDlIb1VSMTl6RHhpZXY4Z1J0TzdMNElEdldGdFhmenVjdGlu?=
 =?utf-8?B?ZWdvTU1EU0NNQUFnRE1FazB0Y2pkMEhvbGMrVXVlY1pGc2FVbFZML0VjbkJU?=
 =?utf-8?B?ckQ2SWRGSkg5SjlLMFViWTE1NGtLK3Uwa2V2ZTloMkRwOUs1R25NQTN6dzFF?=
 =?utf-8?B?OXFyRXM3Q2VhOUpWSWFrQXJyT21vS3lDbFVVSzl3WUQ3bGhKaEM0bHdrVS9M?=
 =?utf-8?B?VjhPVlBWK2pRd1pUaS9aQXkzTVhid2oxQXNiRWU4Y1liSFg4eWZEVXBDNU9G?=
 =?utf-8?B?endqSTFwampqNUVySmhvRDJqM3hGaDUvWUE0UjhrVkF4N0dlUjZPN09qVVdH?=
 =?utf-8?B?eE5lM1JJUFFqNDU2bnZLckhKWjhCanhoc1VvK2NPQjJDNkdkRk85UWN3blI1?=
 =?utf-8?B?SklzcHd6ZHk3ejd4eTdjeUwvOHpZV3pZTk5OT05xWGxsVXk2YnV1b0dTSk5u?=
 =?utf-8?B?NEVlYTBLREtXTUpzSUZBM0M2MExsb3NpN2VYTXVoNTQwZGlvaU9XQmZmVUNk?=
 =?utf-8?B?RldGcG0vd281cmY0MUxoaUNIRk10K0RWejI3UTgyVmpTRER5RXl3M09DZGx4?=
 =?utf-8?B?b2Z2QXpXL0JuU1ZsN1hTeWRvUWZIMFcvUGtnaGk4OUJNK2prbGhvczlwZU15?=
 =?utf-8?B?SWtlR0M5UDRzTkNIREcvaml3MFhwTk04ZDlqdWFjSHN3TDZGWHJ4ZHgvWG9l?=
 =?utf-8?B?aVAvYmVlV3grSDJhSDV6R3BnZVoxdThEeWlrMjkvZFYvTmZlZFBZMGJFTmRW?=
 =?utf-8?B?NnVZQUJHMm1RMU1Na3Fvek5QaHRzdUJQUTJYbS8zYnBuMWd2K0pyUDF2S1du?=
 =?utf-8?B?c1RnWDRNUm56SUNoMXFIem1Venk3aXgzbnVXTkpyOHdUVnM0VkVkSnJSTGgx?=
 =?utf-8?B?NUc2dVFOcDF0Mmp0TnUxRCtyU1VMT0dIR2l5Q3NUVkp0emtyZXJsU21xMkp6?=
 =?utf-8?B?WEZFV0oydm9zY2w0S282eTBMOGU1SkhqTkxNZ3hBOG1ndzBFY0lxbm1id3Qy?=
 =?utf-8?B?aWRZanZUN1BZNVU4eE1PTVoyOXAwbDYwRFhKUEloRkF0NlY4Qmphc1hQQkRs?=
 =?utf-8?B?UDFEUVVTOVdoa3RYWmg5WDVtNzhUOVBSZnlHdVhoWUVDR29SMFQ4MGxXdmtn?=
 =?utf-8?B?MHYxUHoya01Wb2o5S0dFMnkrYU5KWEJNLzJpbU9GVURNendMb0E3dVBONmtn?=
 =?utf-8?B?U1hETnFENlRISlE0M0VwaFpQNjJFSGdVYTV6eTl5ZE5tUFdueGtkSXd5WDh1?=
 =?utf-8?B?TE9oZk4zV3kyaGpYV3A2Z1dma1c1T2F3SFBCZlFMT01xQjNYVmlBUFlXR25i?=
 =?utf-8?B?TWFzOXdObmRKN3hzREh6SjRRcHhjMzQ4aU5qQmlxMVBrUmJWcnZsQzJWaHNt?=
 =?utf-8?B?THFIYU5RdHBWS0ZXODgycUoybnpsRkRFWHJLNlV4ZUhpVnBaREUyNHZQYmJG?=
 =?utf-8?B?bEhHTEJrTjZoU2Z5cFp1VTZwWkJRRzhSS1laWUxNcElBTGtnRmJzS2dKc1Fj?=
 =?utf-8?B?Ym9mdGQ4bXV4N3RZaWg5TlgzSWx1cVVkdXh0ZVNwYW5wK2RiUWx6R3FSSHVH?=
 =?utf-8?B?MmJqSXlYdVFDSEFTNGR1NmhYRWkvUWpWV1RGRXpnRS91dENJWVB4MkZhdjgz?=
 =?utf-8?B?ZXRJWDNqTi9ZWHhmUjA5QXJoY1A2MURWM3M3VnBXRHFSTlRyaUtpYUwzRUZm?=
 =?utf-8?B?a3JCWEhqOEVVMlBIcEpvQ0pYa1BvWi9NY0FGVm9LRXZwelN3RzBab3o0UFRN?=
 =?utf-8?B?ZU4xSkg2SmNxblgrczRyWGg1MDZkdkJhcHNWVC8zTEZmSWRkbHhBdTlYQU5m?=
 =?utf-8?B?dS9ZZWhncjRGQnV2RWJaUmdPdXBnWHB1cUV5NFgydEJSOHgva2xOSmxvZkpK?=
 =?utf-8?B?Qk1kalpZU3dxelAyNTdUU2E0RjNiSkRjVTVua2g2b2IzMzU5MEUzU3BKVTZx?=
 =?utf-8?B?SEQ2V0s1ZjNYWm91K3liWFJ1eFFEZTF3VXJ2NFEyY1Bwd0Y5TjFHSjFWU2w4?=
 =?utf-8?B?SGJXWHFBanVhWXcrYlZyYmdHU0pHemo3Vm84WG51YmFPWWVuRWtwTnc2VmJU?=
 =?utf-8?B?SjhkaEdhM05pQ1pET3pKU0plNnhWL2ErV2NQRHNYTW5aaE1rSTNPZS9HM0hm?=
 =?utf-8?B?TnVMS1cwNTdGTk1LdE4wbFgzcTk4cG1kUXVHNVNZcnF2WSs1QnV4QWg2UTJz?=
 =?utf-8?B?Mnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <686F98A85F347146B97A2C3A48CAD8FD@namprd15.prod.outlook.com>
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c38fe8-b59e-48a7-52de-08dad4017179
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 01:06:28.9553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VuGmhKeSDHRiELPamKViWJBIL8eB0xUd4uWk8xRF35MI4JaPCIRZfNzfWWdZx+3O67GTvNLXUElk11V3k46KAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5224
X-Proofpoint-GUID: t_NpALorPBEQ6SoiaD0ccBTkGjokUoer
X-Proofpoint-ORIG-GUID: t_NpALorPBEQ6SoiaD0ccBTkGjokUoer
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_14,2022-12-01_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

QXBwYXJlbnRseSwgdGhpcyBpcyB0aGUgcmlnaHQgcGxhY2UgdG8gc2VuZCB0aGlzIHBhdGNoLg0K
U29ycnkgdG8gZGlzdHVyYiB5b3UuDQoNCk9uIFRodSwgMjAyMi0xMi0wMSBhdCAxNjowMiAtMDgw
MCwgS3VpLUZlbmcgTGVlIHdyb3RlOg0KPiBTaW5jZSB0aGUgdGVzdCBjYXNlIHdhcyByZW5hbWVk
LCB0aGUgREVOWUxJU1Qgc2hvdWxkIGJlIHVwZGF0ZWQgYXMNCj4gd2VsbC4NCj4gDQo+IFRoZSB0
ZXN0IGxvZyBvZiBzZWxmdGVzdHMgYmVmb3JlIHVkcGF0ZS4NCj4gDQo+IMKgLQ0KPiBodHRwczov
L2dpdGh1Yi5jb20va2VybmVsLXBhdGNoZXMvYnBmL2FjdGlvbnMvcnVucy8zNTc4NDM2MTkwL2pv
YnMvNjAxODg0ODYzNQ0KPiDCoChhYXJjaDY0LWdjYykNCj4gwqAtDQo+IGh0dHBzOi8vZ2l0aHVi
LmNvbS9rZXJuZWwtcGF0Y2hlcy9icGYvYWN0aW9ucy9ydW5zLzM1Nzg0MzYxOTAvam9icy82MDE4
ODQ5MjEwDQo+IMKgKGFhcmNoNjQtbGx2bS0xNikNCj4gDQo+IFRoZSB0ZXN0IGxvZyBvZiBzZWxm
dGVzdHMgYWZ0ZXIgdXBkYXRlLg0KPiANCj4gwqAtDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9rZXJu
ZWwtcGF0Y2hlcy9icGYvYWN0aW9ucy9ydW5zLzM1OTUwMjM1OTMvam9icy82MDU1MzI3NzU0DQo+
IMKgKGFhcmNoNjQtZ2NjKQ0KPiDCoC0NCj4gaHR0cHM6Ly9naXRodWIuY29tL2tlcm5lbC1wYXRj
aGVzL2JwZi9hY3Rpb25zL3J1bnMvMzU5NTAyMzU5My9qb2JzLzYwNTUzMjg0NjQNCj4gwqAoYWFy
Y2g2NC1sbHZtLTE2KQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogS3VpLUZlbmcgTGVlIDxrdWlmZW5n
QGZiLmNvbT4NCj4gLS0tDQo+IMKgY2kvdm10ZXN0L2NvbmZpZ3MvREVOWUxJU1QgfCAyICstDQo+
IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvY2kvdm10ZXN0L2NvbmZpZ3MvREVOWUxJU1QgYi9jaS92bXRlc3QvY29uZmln
cy9ERU5ZTElTVA0KPiBpbmRleCBkMTJjZjlmYWU1ZWUuLjFjZTljZWZkNDU3ZiAxMDA2NDQNCj4g
LS0tIGEvY2kvdm10ZXN0L2NvbmZpZ3MvREVOWUxJU1QNCj4gKysrIGIvY2kvdm10ZXN0L2NvbmZp
Z3MvREVOWUxJU1QNCj4gQEAgLTEsNiArMSw2IEBADQo+IMKgIyBURU1QT1JBUlkNCj4gwqBidGZf
ZHVtcC9idGZfZHVtcDogc3ludGF4DQo+IC1rcHJvYmVfbXVsdGlfdGVzdC9iZW5jaF9hdHRhY2gN
Cj4gK2twcm9iZV9tdWx0aV9iZW5jaF9hdHRhY2gNCj4gwqBjb3JlX3JlbG9jL2VudW02NHZhbA0K
PiDCoGNvcmVfcmVsb2Mvc2l6ZV9fX2RpZmZfc3oNCj4gwqBjb3JlX3JlbG9jL3R5cGVfYmFzZWRf
X19kaWZmX3N6DQoNCg==
