Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56ACB58806E
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 18:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237856AbiHBQmn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 12:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238150AbiHBQmm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 12:42:42 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A4D65D6
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 09:42:41 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 272FeR66011487
        for <bpf@vger.kernel.org>; Tue, 2 Aug 2022 09:42:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=1X0JP6UWHuhCekseya/pZqipIFgTPzdnPBXgj7ORS1I=;
 b=E7CpkoGQ5CnoEtZh38FVRqWdiyfBWCUjbvRHdmZQPk+hzXbm7u6r1RP6ld2p5HQA06SQ
 t8RUFCAyuw6sjCswtUkMpAsm1pp24OeIbQMcHsWoIUTkAThgnV/drR1eML/4SJS+rFf6
 XfQHaIX59Fmyk4Zolh5KiEJa1QX6eluCtE0= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hpq1pdc41-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 02 Aug 2022 09:42:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6NK7A+QmeD2VPzn+4gSYNQOoeHrk1N/5yboaFOM0d3B0XHsNkbhQ5QkiBr1KlAk/gItjKZcSSTkqBxxsq68WdQU9bvTXz9Lwxhg/HTZ7Qhi/iGHbRvRq+CTF9+Z9rFMqUGdsafbhxAbzIEM8KkOBJEtc6sja16O2lpNl6yBKMb10paGe1b2k5Puqws0aCO/Kfh4R//aEhaqaBgmvbwYWEIX2RZAD2DKX5V4M9yTxhwNJDlL25XUqyb+FogZJTgMhqw2xhKlgbxNz3eo9HAx1umdKU9Wf2CoQWfDUydW4ZzyYIOmHf6UugUNdWJ6jDBAAbCxW+7VxrahlFrY5k0Jkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1X0JP6UWHuhCekseya/pZqipIFgTPzdnPBXgj7ORS1I=;
 b=HEeTI2w6xKamgaLCsV3me/FdyMI3t2r7OsV6ESHNYkcxhG/oMXRzHpT5U3NbDq3/uDJKSXBiao6wKwb96uYOxluhqQpurbgKySAGAF+/wvBkHys1tTyCfIr4A5jXbXupDrJshZjZ8owi+gJujhOJeT5OE9wu1y9MYcsim4lm9LNNulL8xhwSXlUtQlEm4jThKtwkVkHX3NOI+pREknzJanI7wnIfEfC9x403K7V3gAanhhL2uuzaSwN47FIyu1eWnTPRdbyM0XsX46tcm2NPgHF+u4cGWEDyM2pYmGRwZ+xjeW9t3Hln/s36ssWaK7Zpy7Yq+ln2g4PeS7E3f5yw2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by BY5PR15MB3570.namprd15.prod.outlook.com (2603:10b6:a03:1f9::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Tue, 2 Aug
 2022 16:42:36 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f%6]) with mapi id 15.20.5504.014; Tue, 2 Aug 2022
 16:42:35 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Parameterize task iterators.
Thread-Topic: [PATCH bpf-next v2 1/3] bpf: Parameterize task iterators.
Thread-Index: AQHYpf4+00grtixoB0ai67RLDHc1uq2a9HsAgADdQwA=
Date:   Tue, 2 Aug 2022 16:42:35 +0000
Message-ID: <9ab00aa58259d9dd7b45fdf860423e86612b591d.camel@fb.com>
References: <20220801232649.2306614-1-kuifeng@fb.com>
         <20220801232649.2306614-2-kuifeng@fb.com>
         <CAEf4BzZqwoCecuUTe=LGBBrTWMp_bCttik1fkmRF1rBXxBYPAw@mail.gmail.com>
In-Reply-To: <CAEf4BzZqwoCecuUTe=LGBBrTWMp_bCttik1fkmRF1rBXxBYPAw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c94b1988-7245-4d25-11fb-08da74a600fa
x-ms-traffictypediagnostic: BY5PR15MB3570:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GfZblJgnFSaT2+gBnlXu0haQyTapV3Id8wkmItVMJBmIFgP1M7ea6quZxOOUXrCYyOGXW0xLEvKKuDZi0FIiFZusxS7p5cGtdSnlE2woMUq7cokYFBCGL4uQF7KJppA2hAJ8FPPJWyaxxuQsj009Cv+XlIF6stgSXtgYj4s5Ov22kYusDTLvlkkFYV+sGS+HCOA5TYfvj7Ej5oCMRrjemR5G4L4bWhsQXU6VMLHU7YbC3r5MOWveYUkzek65vwZzLlLvIuMnqhMOwFNPaAciRiAPLNG38o9LTHMC3nnVf08yLPz6aHTSV3fse+HhHuiwy8I5gDc5TcG4CbwKAIEbjMU4O72GOEx+IVBxLtQg7TSY7TEI29zCq+USANNN0BHd1HpKBRS91Eu6KCaiywFawftfifCm5FovPqI1KVWvOaU5xxY+Mur5RtYOxIlERTvTBGHgQ8R1mpF9jlnD3sEuhPTPa+zHrD8Y6zRgYcD/sgP0H/kJACDmQIPU2MsDLrDOmNgBDtViIf345pxW0LtfugoFD3b5tT+jocX0kvmErtXsxCLsOLLHm+qZiu1yhF7s6LbMmdd2gTGLG78bivxi+7yTn6e9aCWlXz7vNCSjyUQANl7Lyq1Hqv3LmvcUFHqnKancx8UcyJ8ECzUIrZO4Qdyh74rBEKnWH7CXVRXIhAPu4DQJ9mgjgSsEJO/tgL0oNtKHK3jI3QGaLOf4IepZHaXQ7CqRGEymCYaGazQwqEDLsaNzy4PVeAlpyEYDVa8VUSn9iBFOgcy9DZStUefXsiqOOSbph/WJ6RSwX8wpab8rOkexurOW2ASiAoyd5t2g
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(6486002)(71200400001)(6916009)(66946007)(316002)(38070700005)(76116006)(5660300002)(66476007)(8676002)(54906003)(66556008)(4326008)(478600001)(8936002)(36756003)(64756008)(66446008)(2616005)(83380400001)(86362001)(122000001)(41300700001)(2906002)(186003)(38100700002)(6512007)(53546011)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVZ5MFJqK2g5aHNWU0lpcHFPMkNyZC9SNitQcWgzOGJSTjM4b05Dc2huanpT?=
 =?utf-8?B?dklOejA0cHRxVTVJZE4rMHk3RHZZckphRXZ0M0lKZUhqMFBDcHJGTUR5Q1Fq?=
 =?utf-8?B?MndXMkppZi9tcXRnZUF0b0VvTEtTcElMRFMyU1pvY1Q5WjBENkNZSlhGcGM2?=
 =?utf-8?B?NkhIUlV5RkN3bUtzRDZUbUo3QnZ6Y3NTSEp4T3FFTlYyNTRnRkVCQlVKZlAr?=
 =?utf-8?B?UjA4OWFjL1FuZHE4S1Vkc3piVDcyTTNYNlBwN0tYUzE4aHh2WkJwQ2lWd05E?=
 =?utf-8?B?MVZIaFZxTWs2S2JuVVpsa3BlZjUyNE91WnROMkpyRFBjekNoYlE2VXRHMlJI?=
 =?utf-8?B?YmFNVlFCUEFRd1YxbDlKMHZXdnhXMUNnZ1VrRm9TVUFwUmdKUittaFNSM2ZK?=
 =?utf-8?B?aml1b2d5Y0xUWlM0eGQrZ3NwQy9TSFBScTJGNkVzSXQ1MVZTS2lya2tSY1JZ?=
 =?utf-8?B?bXNaT3EyaWducVpjRVRxZU9RdlNaQUVtVzkxMFFOR0R6Q1daNGh1OWVqOS94?=
 =?utf-8?B?bzJmaHFaQkpZbjRvKzJaMlRDM3ZYTWVPa2c5QkRrcGJjSjlPU0FJbG9IN3BK?=
 =?utf-8?B?Q3V5Z3RQVkJQMGRYVGk2azM0MWRWNGxWd1FYcWJSOEtYakZQQUtYcm5vUjg0?=
 =?utf-8?B?by8rUWtyS2pmSjNKcFVjd2IvcWRHNHBISDVKenF3bHgzZFZqS3E4MFJjYWwz?=
 =?utf-8?B?d2c2WlNYeG9JMWs1OCs0a0tZRzZHQy90bUE5TGFJRFNDMExHZ0ZtNldiV0xB?=
 =?utf-8?B?NTlOalVZMWlkSUU2am91cnlhUTkzUVF3WVdVYnFTODNvWmZUTTJWSGx3Wi9C?=
 =?utf-8?B?S2d3aWJFZ3c4Uk8vbGVZVEZXL2xpSGVsSDNLQUJBa29iNldpbDA0Y2NmVWdi?=
 =?utf-8?B?SHk4RlNkSU9lNHY5dmlQU3J2Vk1ndDVja0xNaitZb0YzRkVPV1lNV2oyZmdR?=
 =?utf-8?B?WTBkalR1RlNaVHNsZEYvdVp6RlZNdFVtckEzS2c1VjFkd20wRHlEaVBPdHgw?=
 =?utf-8?B?b3pieU9mOWdGUzhXcUlrNjd2dk16Wjd2LzBOd1lJSzN2ME9OOElnVlEvRUkz?=
 =?utf-8?B?Ui9WWkNidjAyNzFWZzNjekZDd01NamhybTFBWi84SG1WQWdJNDg0a2hiU2RB?=
 =?utf-8?B?SlRFWFRrZnpWR1MxQ2N3SGhITmZXeHdZdEQ0ZVV5dGNGdXVBUGtRR0xYVXRq?=
 =?utf-8?B?TWJCVURBdDMzQ0xSRnVEbm5xSHd5dWdIYmhNWkg2ejdYMnBGc0RFVzQwa2U3?=
 =?utf-8?B?N1ZETU5QM01zQWRvcW9McHRYRTlxY0JsMlFjd3RWZ2JZM0RCTTR6VGpWbzAv?=
 =?utf-8?B?MnFwRjJBVjFHYlNvNUYwOXVNdGdlaGg2Yk84eGNIcGJLRmNNS0lmQ2UzaWY3?=
 =?utf-8?B?NVBKUnZvUmtBdTNaVVRSaUVGSGN1OVhWRC8vOHVSblRCTEdZd3pKWWhYRlVE?=
 =?utf-8?B?ZU5mcTczRUxiSzg4aVFXZFpIbXZIdTFYUjgvM0taK1VyTGFkR1h3eXFNRGt0?=
 =?utf-8?B?Vjh3ZEZ4L2RYbDk4b2lDOEhuMXV3a3dINENUWW9TSlVLTGdzUDlGSkhxViti?=
 =?utf-8?B?RGpFM3B3VFBESmJKTU5oaHdxbmMrZGNJUGJsQ0NhejlrbzhJcU9YdVBJT2xX?=
 =?utf-8?B?Y1VkUzFpdm50ekVHSFhrdlVwUlpocEVVcUxOV1NLTkJUaTEvM05YYVR1NSs3?=
 =?utf-8?B?N3l1ZWx2QjZYRkd5a09mbkt4TUdZdjVqRWV0NG5HL0wybWtENWpxa29EL0RF?=
 =?utf-8?B?ei9ENVhGM2JocncwT3M0VE1SdWx6clZtVE90am1lSGx3S0FjTHFqNkpXbU92?=
 =?utf-8?B?QTR0M0lBTnp1VGhJeEdPYUZydG50SlVOYkZGaVFDT3ZjOVlId3RWV3NCSUk3?=
 =?utf-8?B?cGUrelpWZk5MVmI1STdBVmhJTm1mQUhZejlpdUx1TW9JUXVkamhoaFJuOU4v?=
 =?utf-8?B?VkhrbUJoeGZrSi9sTlJFdkx3ZDQxVnRGc0U3Q0czR2I5MTlvVzB3aTBlRlR1?=
 =?utf-8?B?WjY0ZXNSVzhmczJtQ3V6YUU5bGNaZ2tma3kybjRLMUZLamZoY0liV2cxVjdO?=
 =?utf-8?B?Zmo3SGtSNWZVSjdKem13cXFXTXRzc1ZMT21XZkxUSlhVR2hMTEhYUyt1N2VO?=
 =?utf-8?B?QjAraWF1ZUdPWUl4TGFibnJZa0s3RzRZRjNqSlZmdC96Qk03WkVNT0Q3a1FY?=
 =?utf-8?B?elE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFAA184A057B2D4E8815C381E7B89CAB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c94b1988-7245-4d25-11fb-08da74a600fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 16:42:35.5815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ysOyqdJAsfb3n+Noct3WNPFbUAv54ScCa6IOPb/r9rW9n+Pm3S9c3t11DicclStA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3570
X-Proofpoint-GUID: stBItYcpymv5DelUiwuX6UjaR2QtL_fg
X-Proofpoint-ORIG-GUID: stBItYcpymv5DelUiwuX6UjaR2QtL_fg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_11,2022-08-02_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uLCAyMDIyLTA4LTAxIGF0IDIwOjMwIC0wNzAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
DQo+IE9uIE1vbiwgQXVnIDEsIDIwMjIgYXQgNDoyNyBQTSBLdWktRmVuZyBMZWUgPGt1aWZlbmdA
ZmIuY29tPiB3cm90ZToNCj4gPiANCj4gPiBBbGxvdyBjcmVhdGluZyBhbiBpdGVyYXRvciB0aGF0
IGxvb3BzIHRocm91Z2ggcmVzb3VyY2VzIG9mIG9uZQ0KPiA+IHRhc2svdGhyZWFkLg0KPiA+IA0K
PiA+IFBlb3BsZSBjb3VsZCBvbmx5IGNyZWF0ZSBpdGVyYXRvcnMgdG8gbG9vcCB0aHJvdWdoIGFs
bCByZXNvdXJjZXMgb2YNCj4gPiBmaWxlcywgdm1hLCBhbmQgdGFza3MgaW4gdGhlIHN5c3RlbSwg
ZXZlbiB0aG91Z2ggdGhleSB3ZXJlDQo+ID4gaW50ZXJlc3RlZA0KPiA+IGluIG9ubHkgdGhlIHJl
c291cmNlcyBvZiBhIHNwZWNpZmljIHRhc2sgb3IgcHJvY2Vzcy7CoCBQYXNzaW5nIHRoZQ0KPiA+
IGFkZGl0aW9uYWwgcGFyYW1ldGVycywgcGVvcGxlIGNhbiBub3cgY3JlYXRlIGFuIGl0ZXJhdG9y
IHRvIGdvDQo+ID4gdGhyb3VnaCBhbGwgcmVzb3VyY2VzIG9yIG9ubHkgdGhlIHJlc291cmNlcyBv
ZiBhIHRhc2suDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogS3VpLUZlbmcgTGVlIDxrdWlmZW5n
QGZiLmNvbT4NCj4gPiAtLS0NCj4gPiDCoGluY2x1ZGUvbGludXgvYnBmLmjCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHzCoCA0ICsrDQo+ID4gwqBpbmNsdWRlL3VhcGkvbGludXgvYnBmLmjCoMKgwqDC
oMKgwqAgfCAyMyArKysrKysrKysNCj4gPiDCoGtlcm5lbC9icGYvdGFza19pdGVyLmPCoMKgwqDC
oMKgwqDCoMKgIHwgOTMgKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tDQo+ID4gLS0tLQ0K
PiA+IMKgdG9vbHMvaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5oIHwgMjMgKysrKysrKysrDQo+ID4g
wqA0IGZpbGVzIGNoYW5nZWQsIDEyMSBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlvbnMoLSkNCj4g
PiANCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9icGYuaCBiL2luY2x1ZGUvbGludXgv
YnBmLmgNCj4gPiBpbmRleCAxMTk1MDAyOTI4NGYuLjNjMjZkYmZjOWNlZiAxMDA2NDQNCj4gPiAt
LS0gYS9pbmNsdWRlL2xpbnV4L2JwZi5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9icGYuaA0K
PiA+IEBAIC0xNzE4LDYgKzE3MTgsMTAgQEAgaW50IGJwZl9vYmpfZ2V0X3VzZXIoY29uc3QgY2hh
ciBfX3VzZXINCj4gPiAqcGF0aG5hbWUsIGludCBmbGFncyk7DQo+ID4gDQo+ID4gwqBzdHJ1Y3Qg
YnBmX2l0ZXJfYXV4X2luZm8gew0KPiA+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBicGZfbWFwICpt
YXA7DQo+ID4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3Qgew0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHUzMsKgwqDCoMKgIHRpZDsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB1OMKgwqDCoMKgwqAgdHlwZTsNCj4gPiArwqDCoMKgwqDCoMKgIH0gdGFzazsNCj4gPiDC
oH07DQo+ID4gDQo+ID4gwqB0eXBlZGVmIGludCAoKmJwZl9pdGVyX2F0dGFjaF90YXJnZXRfdCko
c3RydWN0IGJwZl9wcm9nICpwcm9nLA0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGlu
dXgvYnBmLmggYi9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmgNCj4gPiBpbmRleCBmZmNiZjc5YTU1
NmIuLmVkNWJhNTAxNjA5ZiAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvYnBm
LmgNCj4gPiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmgNCj4gPiBAQCAtODcsMTAgKzg3
LDMzIEBAIHN0cnVjdCBicGZfY2dyb3VwX3N0b3JhZ2Vfa2V5IHsNCj4gPiDCoMKgwqDCoMKgwqDC
oCBfX3UzMsKgwqAgYXR0YWNoX3R5cGU7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBwcm9ncmFt
IGF0dGFjaCB0eXBlDQo+ID4gKGVudW0gYnBmX2F0dGFjaF90eXBlKSAqLw0KPiA+IMKgfTsNCj4g
PiANCj4gPiArZW51bSBicGZfdGFza19pdGVyX3R5cGUgew0KPiA+ICvCoMKgwqDCoMKgwqAgQlBG
X1RBU0tfSVRFUl9BTEwgPSAwLA0KPiA+ICvCoMKgwqDCoMKgwqAgQlBGX1RBU0tfSVRFUl9USUQs
DQo+ID4gK307DQo+ID4gKw0KPiA+IMKgdW5pb24gYnBmX2l0ZXJfbGlua19pbmZvIHsNCj4gPiDC
oMKgwqDCoMKgwqDCoCBzdHJ1Y3Qgew0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBfX3UzMsKgwqAgbWFwX2ZkOw0KPiA+IMKgwqDCoMKgwqDCoMKgIH0gbWFwOw0KPiA+ICvCoMKg
wqDCoMKgwqAgLyoNCj4gPiArwqDCoMKgwqDCoMKgwqAgKiBQYXJhbWV0ZXJzIG9mIHRhc2sgaXRl
cmF0b3JzLg0KPiA+ICvCoMKgwqDCoMKgwqDCoCAqLw0KPiA+ICvCoMKgwqDCoMKgwqAgc3RydWN0
IHsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX3UzMsKgwqAgcGlkX2ZkOw0K
PiANCj4gSSB3YXMgYSBiaXQgbGF0ZSB0byB0aGUgZGlzY3Vzc2lvbiBhYm91dCBwaWRmZCB2cyBw
bGFpbiBwaWQuIEkgdGhpbmsNCj4gd2Ugc2hvdWxkIHN1cHBvcnQgYm90aCBpbiB0aGlzIEFQSS4g
V2hpbGUgcGlkX2ZkIGhhcyBzb21lIG5pY2UNCj4gZ3VhcmFudGVlcyBsaWtlIGF2b2lkaW5nIHRo
ZSByaXNrIG9mIGFjY2lkZW50YWwgUElEIHJldXNlLCBpbiBhIGxvdA0KPiAoaWYgbm90IGFsbCkg
Y2FzZXMgd2hlcmUgdGFzay90YXNrX3ZtYS90YXNrX2ZpbGUgaXRlcmF0b3JzIGFyZSBnb2luZw0K
PiB0byBiZSB1c2VkIHRoaXMgaXMgbmV2ZXIgYSByaXNrLCBiZWNhdXNlIHBpZCB3aWxsIHVzdWFs
bHkgY29tZSBmcm9tDQo+IHNvbWUgdHJhY2luZyBCUEYgcHJvZ3JhbSAoa3Byb2JlL3RwL2ZlbnRy
eS9ldGMpLCBsaWtlIGluIGNhc2Ugb2YNCj4gcHJvZmlsaW5nLCBhbmQgdGhlbiB3aWxsIGJlIHVz
ZWQgYnkgdXNlci1zcGFjZSBhbG1vc3QgaW1tZWRpYXRlbHkgdG8NCj4gcXVlcnkgc29tZSBhZGRp
dGlvbmFsIGluZm9ybWF0aW9uIChmZXRjaGluZyByZWxldmFudCB2bWEgaW5mb3JtYXRpb24NCj4g
Zm9yIHByb2ZpbGluZyB1c2UgY2FzZSkuIFNvIG1haW4gYmVuZWZpdCBvZiBwaWRmZCBpcyBub3Qg
dGhhdA0KPiByZWxldmFudA0KPiBmb3IgQlBGIHRyYWNpbmcgdXNlIGNhc2VzLCBiZWNhdXNlIFBJ
RHMgYXJlIG5vdCBnb2luZyB0byBiZSByZXVzZWQgc28NCj4gZmFzdCB3aXRoaW4gc3VjaCBhIHNo
b3J0IHRpbWUgZnJhbWUuDQo+IA0KPiBCdXQgcGlkZmQgZG9lcyBoYXZlIGRvd25zaWRlcy4gSXQg
cmVxdWlyZXMgMiBzeXNjYWxscyAocGlkZmRfb3BlbiBhbmQNCj4gY2xvc2UpIGZvciBlYWNoIFBJ
RCwgaXQgY3JlYXRlcyBzdHJ1Y3QgZmlsZSBmb3IgZWFjaCBzdWNoIGFjdGl2ZQ0KPiBwaWRmZC4g
U28gaXQgd2lsbCBoYXZlIG5vbi10cml2aWFsIG92ZXJoZWFkIGZvciBoaWdoLWZyZXF1ZW5jeSBC
UEYNCj4gaXRlcmF0b3IgdXNlIGNhc2VzIChpbWFnaW5lIHF1ZXJ5aW5nIHNvbWUgc2ltcGxlIHN0
YXRzIGZvciBhIGJpZyBzZXQNCj4gb2YgdGFza3MsIGZyZXF1ZW50bHk6IHlvdSdsbCBzcGVuZCBt
b3JlIHRpbWUgaW4gcGlkZmQgc3lzY2FsbHMgYW5kDQo+IG1vcmUgcmVzb3VyY2VzIGp1c3Qga2Vl
cGluZyBjb3JyZXNwb25kaW5nIHN0cnVjdCBmaWxlIG9wZW4gdGhhbg0KPiBhY3R1YWxseSBkb2lu
ZyB1c2VmdWwgQlBGIHdvcmspLiBGb3Igc2ltcGxlIEJQRiBpdGVyIGNhc2VzIGl0IHdpbGwNCj4g
dW5uZWNlc3NhcmlseSBjb21wbGljYXRlIHByb2dyYW0gZmxvdyB3aGlsZSBnaXZpbmcgbm8gYmVu
ZWZpdA0KPiBpbnN0ZWFkLg0KDQpJdCBpcyBhIGdvb2QgcG9pbnQgdG8gaGF2ZSBtb3JlIHN5c2Nh
bGxzLg0KDQo+IA0KPiBTbyBJIHByb3Bvc2Ugd2Ugc3VwcG9ydCBib3RoIGluIFVBUEkuIEludGVy
bmFsbHkgZWl0aGVyIHdheSB3ZQ0KPiByZXNvbHZlDQo+IHRvIHBsYWluIHBpZC90aWQsIHNvIHRo
aXMgd29uJ3QgY2F1c2UgYWRkZWQgbWFpbnRlbmFuY2UgYnVyZGVuLiBCdXQNCj4gc2ltcGxlIGNh
c2VzIHdpbGwga2VlcCBzaW1wbGUsIHdoaWxlIG1vcmUgbG9uZy1saXZlZCBhbmQvb3INCj4gY29t
cGxpY2F0ZWQgb25lcyB3aWxsIHN0aWxsIGJlIHN1cHBvcnRlZC4gV2UgdGhlbiBjYW4gaGF2ZQ0K
PiBCUEZfVEFTS19JVEVSX1BJREZEIHZzIEJQRl9UQVNLX0lURVJfVElEIHRvIGRpZmZlcmVudGlh
dGUgd2hldGhlciB0aGUNCj4gYWJvdmUgX191MzIgcGlkX2ZkICh3aGljaCB3ZSBzaG91bGQgcHJv
YmFibHkgcmVuYW1lIHRvIHNvbWV0aGluZyBtb3JlDQo+IGdlbmVyaWMgbGlrZSAidGFyZ2V0Iikg
aXMgcGlkIEZEIG9yIFRJRC9QSUQuIFNlZSBhbHNvIGJlbG93IGFib3V0IFRJRA0KPiB2cyBQSUQu
DQo+IA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qDQo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIFRoZSB0eXBlIG9mIHRoZSBpdGVyYXRvci4NCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICoNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICogSXQgY2FuIGJlIG9uZSBvZiBlbnVtIGJwZl90YXNrX2l0ZXJfdHlwZS4N
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICoNCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICogQlBGX1RBU0tfSVRFUl9BTEwgKGRlZmF1bHQpDQo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqwqDCoMKgwqDCoCBUaGUgaXRlcmF0b3IgaXRl
cmF0ZXMgb3ZlciByZXNvdXJjZXMgb2YNCj4gPiBldmVyeXByb2Nlc3MuDQo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAqIEJQRl9UQVNLX0lURVJfVElEDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAqwqDCoMKgwqDCoCBZb3Ugc2hvdWxkIGFsc28gc2V0ICpwaWRfZmQqIHRvIGl0ZXJhdGUN
Cj4gPiBvdmVyIG9uZSB0YXNrLg0KPiANCj4gbmFtaW5nIG5pdDogd2Ugc2hvdWxkIGRlY2lkZSB3
aGV0aGVyIHdlIHVzZSBUSUQgKHRocmVhZCkgYW5kIFBJRA0KPiAocHJvY2VzcykgdGVybWlub2xv
Z3kgKG1vcmUgdXN1YWwgZm9yIHVzZXItc3BhY2UpIG9yIFBJRCAocHJvY2VzcyA9PQ0KPiB0YXNr
ID09IHVzZXItc3BhY2UgdGhyZWFkKSBhbmQgVEdJRCAodGhyZWFkIGdyb3VwLCBpLmUuIHVzZXIt
c3BhY2UNCj4gcHJvY2VzcykuIEkgaGF2ZW4ndCBpbnZlc3RpZ2F0ZWQgbXVjaCB3aGF0J3Mgd2Ug
dXNlIG1vc3QNCj4gY29uc2lzdGVudGx5LA0KPiBidXQgY3VyaW91cyB0byBoZWFyIHdoYXQgb3Ro
ZXJzIHRoaW5rLg0KPiANCj4gQWxzbyBJIGNhbiBzZWUgdXNlLWNhc2VzIHdoZXJlIHdlIHdhbnQg
dG8gaXRlcmF0ZSBqdXN0IHNwZWNpZmllZCB0YXNrDQo+IChpLmUuLCBqdXN0IHNwZWNpZmllZCB0
aHJlYWQpIHZzIGFsbCB0aGUgdGFza3MgdGhhdCBiZWxvbmcgdG8gdGhlDQo+IHNhbWUNCj4gcHJv
Y2VzcyBncm91cCAoaS5lLiwgdGhyZWFkIHdpdGhpbiBwcm9jZXNzKS4gTmFtaW5nIFRCRCwgYnV0
IHdlDQo+IHNob3VsZA0KPiBoYXZlIEJQRl9UQVNLX0lURVJfVElEIGFuZCBCUEZfVEFTS19JVEVS
X1RHSUQgKG9yIHNvbWUgb3RoZXIgbmFtaW5nKS4NCg0KDQpJIGRpc2N1c3NlZCB3aXRoIFlvbmdo
b25nIGFib3V0IGl0ZXJhdG9ycyBvdmVyIHJlc291cmNlcyBvZiBhbGwgdGFza3MNCm9mIGEgcHJv
Y2Vzcy4gIFVzZXIgY29kZSBzaG91bGQgY3JlYXRlIGl0ZXJhdG9ycyBmb3IgZWFjaCB0aHJlYWQg
b2YgdGhlDQpwcm9jZXNzIGlmIG5lY2Vzc2FyeS4gIFdlIG1heSBhZGQgdGhlIHN1cHBvcnQgb2Yg
dGdpZCBpZiBpdCBpcyBoaWdseQ0KZGVtYW5kZWQuDQoNCkluIGEgZGlzY3Vzc2lvbiBvZiB1c2lu
ZyBwaWRmZCwgcGVvcGxlIG1lbnRpb25lZCB0byBleHRlbmQgcGlkZmQgdG8NCnRocmVhZHMgaWYg
dGhlcmUgaXMgYSBnb29kIHVzZS1jYXNlLiAgSXQgYWxzbyBhcHBsaWVzIHRvIG91ciBjYXNlLiAN
Ck1vc3Qgb2YgdGhlIHRpbWUsIGlmIG5vdCBhbHdheXMsIHZtYSAmIGZpbGVzIGFyZSBzaGFyZWQg
YnkgYWxsIHRocmVhZHMNCm9mIGEgcHJvY2Vzcy4gIFNvLCBhbiBpdGVyYXRpb24gb3ZlciBhbGwg
cmVzb3VyY2VzIG9mIGV2ZXJ5IHRocmVhZHMgb2YNCmEgcHJvY2VzcyBkb2Vzbid0IGdldCBvYnZp
b3VzIGJlbmVmaXQuICBJdCBpcyBhbHNvIHRydWUgZm9yIGFuIGl0ZXJhdG9yDQpvdmVyIHRoZSBy
ZXNvdXJjZXMgb2YgYSBzcGVjaWZpYyB0aHJlYWQgaW5zdGVhZCBvZiBhIHByb2Nlc3MuDQoNCj4g
DQo+IE9uZSBtaWdodCBhc2sgd2h5IGRvIHdlIG5lZWQgc2luZ2xlLXRhc2sgbW9kZSBpZiB3ZSBj
YW4gYWx3YXlzIHN0b3ANCj4gaXRlcmF0aW9uIGZyb20gQlBGIHByb2dyYW0sIGJ1dCB0aGlzIGlz
IHRyaXZpYWwgb25seSBmb3IgaXRlci90YXNrLA0KPiB3aGlsZSBmb3IgaXRlci90YXNrX3ZtYSBh
bmQgaXRlci90YXNrX2ZpbGUgaXQgYmVjb21lcyBpbmNvbnZlbmllbnQgdG8NCj4gZGV0ZWN0IHN3
aXRjaCBmcm9tIG9uZSB0YXNrIHRvIGFub3RoZXIuIEl0IGNvc3RzIHVzIGVzc2VudGlhbGx5DQo+
IG5vdGhpbmcgdG8gc3VwcG9ydCB0aGlzIG1vZGUsIHNvIEkgYWR2b2NhdGUgdG8gZG8gdGhhdC4N
Cj4gDQo+IEkgaGF2ZSBzaW1pbGFyIHRob3VnaHRzIGFib3V0IGNncm91cCBpdGVyYXRpb24gbW9k
ZXMgYW5kIGFjdHVhbGx5DQo+IHN1cHBvcnRpbmcgY2dyb3VwX2ZkIGFzIHRhcmdldCBmb3IgdGFz
ayBpdGVyYXRvcnMgKHdoaWNoIHdpbGwgbWVhbg0KPiBpdGVyYXRpbmcgdGFza3MgYmVsb25naW5n
IHRvIHByb3ZpZGVkIGNncm91cChzKSksIGJ1dCBJJ2xsIHJlcGx5IG9uDQo+IGNncm91cCBpdGVy
YXRvciBwYXRjaCBmaXJzdCwgYW5kIHdlIGNhbiBqdXN0IHJldXNlIHRoZSBzYW1lIGNncm91cA0K
PiB0YXJnZXQgc3BlY2lmaWNhdGlvbiBiZXR3ZWVuIGl0ZXIvY2dyb3VwIGFuZCBpdGVyL3Rhc2sg
YWZ0ZXJ3YXJkcy4NCj4gDQo+IA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Ki8NCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX3U4wqDCoMKgIHR5cGU7wqDC
oCAvKiBCUEZfVEFTS19JVEVSXyogKi8NCj4gPiArwqDCoMKgwqDCoMKgIH0gdGFzazsNCj4gPiDC
oH07DQo+ID4gDQo+IA0KPiBbLi4uXQ0KDQo=
