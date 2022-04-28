Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF27513C03
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 21:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347415AbiD1TO0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Apr 2022 15:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351369AbiD1TOW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 15:14:22 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF1C8BE03
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 12:11:05 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23SIPLUO031811
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 12:11:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=wDCPD01zXIYvrJoTodyxORmCSSPGfmq41NgP7aum6U0=;
 b=c9LIYbcAIp+t16yXtSNJy0rsuhpVO/cJ0gjE3TwYcIFr3Abujmz39FSJrYjj+57jIWJU
 4O2A/rIxSN+AdHO3PN38nxSZdXumN7XwPR3kJg2CTuKrtp9xze2ialv5mbqf6/1SRIIM
 vuRrLlNxUGrhZoAbX3X5sV954NfuVm5ZSJ8= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fqkdjdasu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 12:11:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mf1nQPCKttJ90VrUXaOo+d162X+LC8rHf8iQh2Q/+S0nfFzbbzEaWaRUhmppNNEWABMV/sgAmbKnEEFxgLfG6h3KtUyIjV+TmTazqHbn/mGGV5W9b5dZVGxSX1Vve4UDO7zIypfbDcoCNSb6dA85cVVAJpfEvubSYHwgyYSDx2Cg0QIm8tXVbqBpl347h0vBiA9IHxOijDs0VVUph5k5TUJtlzTTU9fBImJa0yFcuQ8upP1tcVeNDX/ofNAB+p/rNDO9Ge2uEAu73X4xAZRifo48dzulvZWdxqePTN4on9KK8WmoHo6++Sj7wOuia5obYLbyqvaZDJvxJEXnEp9SyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDCPD01zXIYvrJoTodyxORmCSSPGfmq41NgP7aum6U0=;
 b=gR+FiS/XCRJDZ/eQYAi3CAS2qZjdPjhovI/Wo+hNiHygg9Dxo2R7XH8gPFdDASmC6dPuev/hCNEqvNTinWxh5SsHj2168Wbf4xVsj89siAHwr9R4pWk2ir2bh7oJaJ0fasU4/8jzFlDVruzYR4yfAtKunEz8IrqYp+W57j9nQENs/g6goPdIRtAzVbxWmmByb+yrTwbdOYPjdiuc+H1/wvO2UBVZyD2VGtCZIWi9ttDxp0OEAFGIqFM8OMICjLHH4yOFlUYwQ2FbY511lKblBOSHeBJgUFAMoxTd/KUYzODA7acuZ3ClWn9Q6KfMJLEjewfVW4BcjkPgClKqyeDWjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by MWHPR15MB1904.namprd15.prod.outlook.com (2603:10b6:301:55::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Thu, 28 Apr
 2022 19:11:02 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b%4]) with mapi id 15.20.5186.020; Thu, 28 Apr 2022
 19:11:02 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 4/5] libbpf: add support for sleepable kprobe and
 uprobe programs
Thread-Topic: [PATCH bpf-next 4/5] libbpf: add support for sleepable kprobe
 and uprobe programs
Thread-Index: AQHYWyCLhvbKbgflA0ySya3Uqc55hK0FpqqAgAAJFYA=
Date:   Thu, 28 Apr 2022 19:11:02 +0000
Message-ID: <0b2ef96f301829ca9cc49aeb705573bf8d203c1c.camel@fb.com>
References: <cover.1651103126.git.delyank@fb.com>
         <aac0c6adae881f57c247d7bf35e3047f7bf6cfe0.1651103126.git.delyank@fb.com>
         <CAEf4BzaSXuKj9VyaKtRpQfztq40L9H1OEDYtDC2zBfgPMU7HhA@mail.gmail.com>
In-Reply-To: <CAEf4BzaSXuKj9VyaKtRpQfztq40L9H1OEDYtDC2zBfgPMU7HhA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04db29b6-70cd-40ed-abcc-08da294ad670
x-ms-traffictypediagnostic: MWHPR15MB1904:EE_
x-microsoft-antispam-prvs: <MWHPR15MB1904038FDDD11A11D1457847C1FD9@MWHPR15MB1904.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q4LBLJHkuE2CjXgbK3oWd61CDmjdbvWnmaDgetDLcNPP4a73FCTkOFMTJPQQKdbcmOY6o3o3uiFrFL8FgtgyUDtxwJZDKBy7yeheUU3C9iBH1j879Xz9bWiSBr4ANT7Dk6AWivS1Dqz40lIiL379N+EnAQr89EMWaOyRwUSpPvmErDQOBf2IQc2842ityDNxEmWnZNd5QH6tW4Uf+FW0nOi0X0Ocx5ZEMt2Jqu6G885LMb9lpatd1LIEUDHzh+pAbtBEgtQZIqZnjMUsDFBAMOFPEGGTo2iLo1WNKrQ8c8sqwAewnHZowC4JwlNCmDb8dSNtVcH5UJ5Vdwuvb/XAg3sRdD0YFOGhx+HQTKW/aCimzISoozqEke9OAPM0MNmc+U5fOsWYS9voTNEIsrDp5UpGS6PlUFtpnc9ouWm5yVSCMhi78w5zkR50D/AE1WU7Yeu9cZuBwqptDVkF7e/w8OepbBg/HQl3xoksArbHHWcLM2xIO6hbmpeIYj+D7ax2uKWEKDHllTs6mstJt0rLFHJVfWgYe4/CK0KT72IUBml1hEAqDvUXclk6qEHoE5sA5hFA0cAJWACr6eBTVRLgPlSWFfT6cof7bL0zpkj5VuCtqeRjc6v/hf7FJ5kaC3zo1Du5R0+AblIqwtj1fO2arhila/OjtoSfkgKf6MeLjVjFF2ugon28Z/KSkvIGyYLcrIjoyPcMT1lSGG0ts5r9am4+3+BTb025zIMatl7dAnV8nv/23KLTG6PfJQk+TzH0TgwGPZR2WeUmcLXErd2DajzdXGkFMqhCBPKsd3NYVts=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(64756008)(66946007)(508600001)(8676002)(36756003)(316002)(5660300002)(8936002)(6916009)(76116006)(54906003)(186003)(86362001)(66556008)(6512007)(38100700002)(4326008)(66446008)(38070700005)(2616005)(71200400001)(66476007)(2906002)(966005)(122000001)(6486002)(83380400001)(6506007)(26005)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUR1MTN3OHZTWmFqOTdHTkRZUExWL2xpcTVTNExFcEJXVStVZ0I0Rk9ub25N?=
 =?utf-8?B?bVBBMzVhUHZZaGl1UDNYUm5IYlBRT2hqSFVFb1VWODJHY09tYWRTK1BTWmNh?=
 =?utf-8?B?Y3FDK1YyYjkxTU51RlJqNVpXTHhicnl4QjBNcXVJdG5KNGRhcFppQ2VMczVB?=
 =?utf-8?B?WCtubW1iWnN5OGF1MmZGa2ErRmYxcmx1RWZwY0VIcy84Y0RVbW5kVDRIZ1F5?=
 =?utf-8?B?UlBMREo5VERtZjR5dWUyWHZIOTM5RzJPSzhUdU1SZGVSN1owRVNFTlN1bTRq?=
 =?utf-8?B?bFpZUkZQZkNPNXhwOHJ6MEtobTBya2NQOURkTXNKeDc3WVVlOXluQmx3VHBi?=
 =?utf-8?B?MERvbmxIWVl0bmdTWitJemk5OTh2SjBXQ2M5Uy9nTW40QnRNdTl1b2JySTRh?=
 =?utf-8?B?SExJeTA2bmlGcXduZjFBYTd0WW5iSmJlc3BvL3o0RzVtNWtrM3FjOGdhY2ts?=
 =?utf-8?B?VWpDdE14Q3ZlNmJvRDhaZTNvbGhiTU1HTmovUmxJSjhBSklrOFBoQy85VFdJ?=
 =?utf-8?B?eVJTcG9JaFFybGJONVU0bEhTMnY0QlN2K3FWMWZhRzROWWhhVlllR0l5Z3ZX?=
 =?utf-8?B?RVpoYTFtZ2NDdkFxMVg3cGVjRlpybnFUajM5N3lRZSt6ZlB0eEZrNzhhbytK?=
 =?utf-8?B?cW9rQTNRVnVQK2lFK2J1Q3BMNzJNbWg1ODhNbEpNVkt6cU5SOVBiRXJRMDFZ?=
 =?utf-8?B?eGd1NmhRbWdUMG1xRmlocjdtUUJUMDZqcUU1cENQdStFTmdmN2o0dkJDZHI0?=
 =?utf-8?B?cDNJZGVxTGI2M1FoaWRyRGdDVEVjaUd5MnFTTWV4UEZpbDVGYldjZmx2MXVo?=
 =?utf-8?B?ZzQ0UlJvcVJhQlVyWGlDU0cxenFDeFdmRjR2SWhPaXBmbnpUaWJuYVplb1ND?=
 =?utf-8?B?R2RpaGxiV0pKeGo5N3E0L09rYWxNZDhFZVh0aS9STUd3UzNVbktUSjZwNk9w?=
 =?utf-8?B?OXMxZnFxbXVEa2FQdmdOY24rSlVoVTBtN0Y1WVJiY2N2UlM0Ymdhcmtrc21v?=
 =?utf-8?B?M1BkTklObjVsNERGSWFKcGdVSjEwaGJzaVA2Nmw5QWFJQU1yWjJXOHoydG14?=
 =?utf-8?B?YWlWYmpLOHc1YjNWYTJldjYzYytQZGF3TkhUclVxMzJ5RlR1ZE1kQXBwbEVn?=
 =?utf-8?B?TUs0MHhaU0ViamhIVlkzNE1rN2ZZQ1p6YkY2L0ZnSDhNTHloRkRKZWI4WEJF?=
 =?utf-8?B?d1VHNUFKbTBoQjYzODFFWDJKNDE0cU5Jd1hYTjRvd2d4bzlyNG8zM01UL3hC?=
 =?utf-8?B?REhnREZkVG9tZUpWekxZK1V0U2d6b1EyN2FhS3M2MCtBN0JIbG1iSVBwd0dG?=
 =?utf-8?B?UGhHNnFyTVA2eWt3ZmpHSFpoVmY2OHM4TFhuOUhtTjBnbHV1RGtIK1M0Zmpt?=
 =?utf-8?B?ckd0U2tRL2kzV0NMdjZwc0pxbFV2UlZYejk5a0hYWnBsM1hxaXhYWElaRmkw?=
 =?utf-8?B?N3VLaDd5dzNZN01nRUQ5b2NHRmxFZ2ZnK0szM1YvNmxDUzd1amNLNGhCQncx?=
 =?utf-8?B?bS8xMG9Bd1RNdW9oRFlmbXhQaXAwdWdwQlI1ZFFvU0c5MVFXakM0WGFtMUFh?=
 =?utf-8?B?dnRVamxWaXJsaWtmb0xqZk5nZUVYWGZJRUFTZzg4TkRYOE8yN3RHY1hZU2ds?=
 =?utf-8?B?TnhhQTVic2FqZFdtKytuQkVhbUcySjd6SmpWSmp0WnAwV09MeVFndEcrclFQ?=
 =?utf-8?B?dGlua04yZ3gydnRhbVcveWJ2WjZtVGpFN1pMZ2wra25pQzdoRDQvS1J0KzE4?=
 =?utf-8?B?QnlRZXVUZW41d2RMZWMwcG9uT0RPWHJLVDZQdTB5WDhOUnl3dmJWdHh3NjEr?=
 =?utf-8?B?cWd5ZFkxdStwSXEreWZOVSt0dndFeGFGbFBoOU0zTWliaXorNEExdFY1TThY?=
 =?utf-8?B?NkdzZWd5VGtqOEpwaVRIcVFqZHl6a0hmdnVYSzQwTW9rOFlSVTRFcVByTjVq?=
 =?utf-8?B?MGszNmpyQlVXeEtzZnJMaEVHWWRpTm40L0tmR20xQ2NldXRVckFaMy8xVFRq?=
 =?utf-8?B?QUd4MENtWE56SFNSekpjekwxOEVrbnhEZk84Z3ZSTlBPV1hEMVIzMHdZVUdm?=
 =?utf-8?B?QjkxclIyYmlDdThUWllEdDVocXZtVVkxajVVQmtZSTR1WVBYb3A0cXJnWEI0?=
 =?utf-8?B?NzdITlhra2o2M0RJZHdkYk8zVTBGUFdlblR0cDlwcEpFekE4ZzY1aWhJNnlw?=
 =?utf-8?B?Wi95UEVTL0tnTFU3aUY3T0VHS0g0TkRmOW1qb1J1aFp1aTBOK1JPcktKYm82?=
 =?utf-8?B?WDlOem01dU9sV2JoOCsvWjJJMkRZRVRac1RQTmdaK1lnU0RmdFA2YWRSY0Ny?=
 =?utf-8?B?dVZ5aWhuQmp3UlNFejZaUFl5RmFLRzJNb2JPaExjZklEZ3E5NnlRUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20F24EBEB07DFF488A19201DBCD16B0E@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04db29b6-70cd-40ed-abcc-08da294ad670
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2022 19:11:02.7904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zi138Nui8cw7P6lpIarfIZKz0rhwKWDI2vDGK6l5CenWH8fz8XJLUQIiyImp8Fa/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1904
X-Proofpoint-ORIG-GUID: vbNuiAH48xWekvvaSNBZtCpFkvCA2xxC
X-Proofpoint-GUID: vbNuiAH48xWekvvaSNBZtCpFkvCA2xxC
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-28_03,2022-04-28_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVGh1LCAyMDIyLTA0LTI4IGF0IDExOjMzIC0wNzAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
DQo+IE9uIFRodSwgQXByIDI4LCAyMDIyIGF0IDk6NTQgQU0gRGVseWFuIEtyYXR1bm92IDxkZWx5
YW5rQGZiLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gQWRkIHNlY3Rpb24gbWFwcGluZ3MgZm9yIHVw
cm9iZS5zIGFuZCBrcHJvYmUucyBwcm9ncmFtcy4gVGhlIGxhdHRlcg0KPiA+IGNhbm5vdCBjdXJy
ZW50bHkgYXR0YWNoIGJ1dCB0aGV5J3JlIHN0aWxsIHVzZWZ1bCB0byBvcGVuIGFuZCBsb2FkIGlu
DQo+ID4gb3JkZXIgdG8gdmFsaWRhdGUgdGhhdCBwcm9oaWJpdGlvbi4NCj4gPiANCj4gDQo+IFRo
aXMgcGF0Y2ggbWFkZSBtZSByZWFsaXplIHRoYXQgc29tZSBjaGFuZ2VzIEkgZGlkIGZldyB3ZWVr
cyBhZ28NCj4gaGFzbid0IGxhbmRlZCAoWzBdKS4gSSdtIGdvaW5nIHRvIHJlYmFzZSBhbmQgcmVz
dWJtaXQgYW5kIEknbGwgYXNrIHlvdQ0KPiB0byByZWJhc2Ugb24gdG9wIG9mIHRob3NlIGNoYW5n
ZXMuDQo+IA0KPiAgIFswXSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbmV0
ZGV2YnBmL2xpc3QvP3Nlcmllcz02MzA1NTAmc3RhdGU9Kg0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBEZWx5YW4gS3JhdHVub3YgPGRlbHlhbmtAZmIuY29tPg0KPiA+IC0tLQ0KPiA+ICB0b29scy9s
aWIvYnBmL2xpYmJwZi5jIHwgMTAgKysrKysrKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgOSBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL3Rvb2xz
L2xpYi9icGYvbGliYnBmLmMgYi90b29scy9saWIvYnBmL2xpYmJwZi5jDQo+ID4gaW5kZXggOWEy
MTNhYWFhYzhhLi45ZTg5YTQ3OGQ0MGUgMTAwNjQ0DQo+ID4gLS0tIGEvdG9vbHMvbGliL2JwZi9s
aWJicGYuYw0KPiA+ICsrKyBiL3Rvb2xzL2xpYi9icGYvbGliYnBmLmMNCj4gPiBAQCAtODY5Miw5
ICs4NjkyLDEyIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYnBmX3NlY19kZWYgc2VjdGlvbl9kZWZz
W10gPSB7DQo+ID4gICAgICAgICBTRUNfREVGKCJza19yZXVzZXBvcnQvbWlncmF0ZSIsIFNLX1JF
VVNFUE9SVCwgQlBGX1NLX1JFVVNFUE9SVF9TRUxFQ1RfT1JfTUlHUkFURSwgU0VDX0FUVEFDSEFC
TEUgfCBTRUNfU0xPUFBZX1BGWCksDQo+ID4gICAgICAgICBTRUNfREVGKCJza19yZXVzZXBvcnQi
LCAgICAgICAgIFNLX1JFVVNFUE9SVCwgQlBGX1NLX1JFVVNFUE9SVF9TRUxFQ1QsIFNFQ19BVFRB
Q0hBQkxFIHwgU0VDX1NMT1BQWV9QRlgpLA0KPiA+ICAgICAgICAgU0VDX0RFRigia3Byb2JlLyIs
ICAgICAgICAgICAgICBLUFJPQkUsIDAsIFNFQ19OT05FLCBhdHRhY2hfa3Byb2JlKSwNCj4gPiAr
ICAgICAgIFNFQ19ERUYoImtwcm9iZS5zLyIsICAgICAgICAgICAgS1BST0JFLCAwLCBTRUNfU0xF
RVBBQkxFLCBhdHRhY2hfa3Byb2JlKSwNCj4gDQo+IGJ1dCBkbyB3ZSByZWFsbHkgaGF2ZSBzbGVl
cGFibGUga3Byb2JlcyBzdXBwb3J0ZWQgaW4gdGhlIGtlcm5lbD8gSQ0KPiBkb24ndCB0aGluayB5
ZXQsIGxldCdzIG5vdCBhZHZlcnRpc2UgYXMgaWYgU0VDKCJrcHJvYmUucyIpIGlzIGEgdGhpbmcN
Cj4gdW50aWwgd2UgZG8NCg0KRmFpciBlbm91Z2gsIEkgd2FzIGJlaW5nIGxhenkuIEknbGwgaGF2
ZSB0aGUgdGVzdCBleHBsaWNpdGx5IHNldCBmbGFncy90eXBlLCBpdCdzIG5vdA0KdGhhdCBoYXJk
IGFueXdheS4NCg0KPiA+ICAgICAgICAgU0VDX0RFRigidXByb2JlKyIsICAgICAgICAgICAgICBL
UFJPQkUsIDAsIFNFQ19OT05FLCBhdHRhY2hfdXByb2JlKSwNCj4gPiArICAgICAgIFNFQ19ERUYo
InVwcm9iZS5zKyIsICAgICAgICAgICAgS1BST0JFLCAwLCBTRUNfU0xFRVBBQkxFLCBhdHRhY2hf
dXByb2JlKSwNCj4gPiAgICAgICAgIFNFQ19ERUYoImtyZXRwcm9iZS8iLCAgICAgICAgICAgS1BS
T0JFLCAwLCBTRUNfTk9ORSwgYXR0YWNoX2twcm9iZSksDQo+ID4gICAgICAgICBTRUNfREVGKCJ1
cmV0cHJvYmUrIiwgICAgICAgICAgIEtQUk9CRSwgMCwgU0VDX05PTkUsIGF0dGFjaF91cHJvYmUp
LA0KPiA+ICsgICAgICAgU0VDX0RFRigidXJldHByb2JlLnMrIiwgICAgICAgICBLUFJPQkUsIDAs
IFNFQ19TTEVFUEFCTEUsIGF0dGFjaF91cHJvYmUpLA0KPiA+ICAgICAgICAgU0VDX0RFRigia3By
b2JlLm11bHRpLyIsICAgICAgICBLUFJPQkUsIEJQRl9UUkFDRV9LUFJPQkVfTVVMVEksIFNFQ19O
T05FLCBhdHRhY2hfa3Byb2JlX211bHRpKSwNCj4gPiAgICAgICAgIFNFQ19ERUYoImtyZXRwcm9i
ZS5tdWx0aS8iLCAgICAgS1BST0JFLCBCUEZfVFJBQ0VfS1BST0JFX01VTFRJLCBTRUNfTk9ORSwg
YXR0YWNoX2twcm9iZV9tdWx0aSksDQo+ID4gICAgICAgICBTRUNfREVGKCJ1c2R0KyIsICAgICAg
ICAgICAgICAgIEtQUk9CRSwgMCwgU0VDX05PTkUsIGF0dGFjaF91c2R0KSwNCj4gPiBAQCAtMTA0
MzIsMTMgKzEwNDM1LDE4IEBAIHN0YXRpYyBpbnQgYXR0YWNoX2twcm9iZShjb25zdCBzdHJ1Y3Qg
YnBmX3Byb2dyYW0gKnByb2csIGxvbmcgY29va2llLCBzdHJ1Y3QgYnBmDQo+ID4gICAgICAgICBj
b25zdCBjaGFyICpmdW5jX25hbWU7DQo+ID4gICAgICAgICBjaGFyICpmdW5jOw0KPiA+ICAgICAg
ICAgaW50IG47DQo+ID4gKyAgICAgICBib29sIHNsZWVwYWJsZSA9IGZhbHNlOw0KPiA+IA0KPiA+
ICAgICAgICAgb3B0cy5yZXRwcm9iZSA9IHN0cl9oYXNfcGZ4KHByb2ctPnNlY19uYW1lLCAia3Jl
dHByb2JlLyIpOw0KPiA+ICsgICAgICAgc2xlZXBhYmxlID0gc3RyX2hhc19wZngocHJvZy0+c2Vj
X25hbWUsICJrcHJvYmUucy8iKTsNCj4gPiAgICAgICAgIGlmIChvcHRzLnJldHByb2JlKQ0KPiA+
ICAgICAgICAgICAgICAgICBmdW5jX25hbWUgPSBwcm9nLT5zZWNfbmFtZSArIHNpemVvZigia3Jl
dHByb2JlLyIpIC0gMTsNCj4gPiArICAgICAgIGVsc2UgaWYgKHNsZWVwYWJsZSkNCj4gPiArICAg
ICAgICAgICAgICAgZnVuY19uYW1lID0gcHJvZy0+c2VjX25hbWUgKyBzaXplb2YoImtwcm9iZS5z
LyIpIC0gMTsNCj4gPiAgICAgICAgIGVsc2UNCj4gPiAgICAgICAgICAgICAgICAgZnVuY19uYW1l
ID0gcHJvZy0+c2VjX25hbWUgKyBzaXplb2YoImtwcm9iZS8iKSAtIDE7DQo+ID4gDQo+ID4gKw0K
PiA+ICAgICAgICAgbiA9IHNzY2FuZihmdW5jX25hbWUsICIlbVthLXpBLVowLTlfLl0rJWxpIiwg
JmZ1bmMsICZvZmZzZXQpOw0KPiA+ICAgICAgICAgaWYgKG4gPCAxKSB7DQo+ID4gICAgICAgICAg
ICAgICAgIHByX3dhcm4oImtwcm9iZSBuYW1lIGlzIGludmFsaWQ6ICVzXG4iLCBmdW5jX25hbWUp
Ow0KPiA+IEBAIC0xMDk1Nyw3ICsxMDk2NSw3IEBAIHN0YXRpYyBpbnQgYXR0YWNoX3Vwcm9iZShj
b25zdCBzdHJ1Y3QgYnBmX3Byb2dyYW0gKnByb2csIGxvbmcgY29va2llLCBzdHJ1Y3QgYnBmDQo+
ID4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICAgICAgICAgY2FzZSAzOg0KPiA+ICAgICAg
ICAgY2FzZSA0Og0KPiA+IC0gICAgICAgICAgICAgICBvcHRzLnJldHByb2JlID0gc3RyY21wKHBy
b2JlX3R5cGUsICJ1cmV0cHJvYmUiKSA9PSAwOw0KPiA+ICsgICAgICAgICAgICAgICBvcHRzLnJl
dHByb2JlID0gc3RyX2hhc19wZngocHJvYmVfdHlwZSwgInVyZXRwcm9iZSIpOw0KPiANCj4gaXQn
cyBhIHRvdGFsIG5pdCBidXQgSSdkIGZlZWwgYSBiaXQgbW9yZSBjb21mb3J0YWJsZSB3aXRoIGV4
cGxpY2l0DQo+IGNoZWNrIGZvciAidXJldHByb2JlIiBhbmQgInVyZXRwcm9iZS5zIiBpbnN0ZWFk
IG9mIGEgcHJlZml4IG1hdGNoLCBpZg0KPiB5b3UgZG9uJ3QgbWluZC4NCg0KU3VyZS4NCg0KPiAN
Cj4gPiAgICAgICAgICAgICAgICAgaWYgKG9wdHMucmV0cHJvYmUgJiYgb2Zmc2V0ICE9IDApIHsN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBwcl93YXJuKCJwcm9nICclcyc6IHVyZXRwcm9i
ZXMgZG8gbm90IHN1cHBvcnQgb2Zmc2V0IHNwZWNpZmljYXRpb25cbiIsDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBwcm9nLT5uYW1lKTsNCj4gPiAtLQ0KPiA+IDIuMzUuMQ0K
DQo=
