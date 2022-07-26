Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9BB581C3F
	for <lists+bpf@lfdr.de>; Wed, 27 Jul 2022 01:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239934AbiGZXEo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 19:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239945AbiGZXEn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 19:04:43 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DA4EE2E
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 16:04:42 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QKZvmj020458
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 16:04:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=O1bVz6BQL0taxr7Ii8qyrzu2Vmmiyli7vnaJ3U3+ow0=;
 b=KebmmrqvFv9D1+885jRV5di8siLvnGJ7Yg1dhqTfQg65hhD15NKSmt/gFLebrtu5s0Xq
 2u59uHQ60UII4v2Cxk94xglqM9H8XPH32T6CRm4ycX6PiJa1/3kyZJMfeRvgNHuUebHm
 5oNnfJ8/5TD5nCexPiAcSIqyTmDLdjsXchA= 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hjdvtn1au-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 16:04:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGlJoMlvL8L4aO45tF7XUAbzgnNXFQWle/ibpYHvS9E2BWuKyMZ1Swk+DObcIgm8/eyurjOJW34s8IIL0Uekqwrf/RXGtZkFH3gMBoFruoNjyZvKdhGc8Vfkc0abDhEElTsR/XOhYwBMdPpcSr6KC3beOj3aUoqUp/EgWVNMIe8F0XXJQD2Sbjf6rtYCwHDrZ7TQvjJwpLl0HvEi6PuI/71xjATbIENYJZGwheelkxU9yhGDDd0sMfVHNRozk8Dg+LA1x/HkTasJw9b/5AsPlm4PqpaKfDsxgMoSOE0ofqwRBQmCx1D8ElFPZhtEbzlBjXr/wPnBwFsC09VjqsaGSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1bVz6BQL0taxr7Ii8qyrzu2Vmmiyli7vnaJ3U3+ow0=;
 b=GbQDvYduLuWZaIyv30DGxvJ6r07tOkZ/K4O9Nxj43yU4FodLoRBqqx11RhbRFZ6CttH5GLqzAQ5PaTrljXSgBxmMuhl/5hI/oRtCV0xUocjLCE0ALIyCFrde2+wmcuQ4ssNn7Fe8cqIiPyIMciiCMSxh9rBqlyM39W/VeZ9fDodXEuE0D7DcCP6w/sB4QmLNt4F3x0cF7kBn1YGVCtxJKOmJlAhBIURIxj9vN517ZXY55OCwEdF2fjyqE4/qAloCE2ojLjpC5I7EzAIcivMmDm7Bu4DrJgUrBmnbBb3sgdiZ0JoNLlkLuayiKav4bTwE1eaCDaT0DtPX0nNd6IOirQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from PH0PR15MB5262.namprd15.prod.outlook.com (2603:10b6:510:14d::6)
 by CY4PR15MB1893.namprd15.prod.outlook.com (2603:10b6:910:22::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Tue, 26 Jul
 2022 23:04:38 +0000
Received: from PH0PR15MB5262.namprd15.prod.outlook.com
 ([fe80::487c:66da:ff78:a6fe]) by PH0PR15MB5262.namprd15.prod.outlook.com
 ([fe80::487c:66da:ff78:a6fe%6]) with mapi id 15.20.5458.020; Tue, 26 Jul 2022
 23:04:38 +0000
From:   Mykola Lysenko <mykolal@fb.com>
To:     =?utf-8?B?RGFuaWVsIE3DvGxsZXI=?= <deso@posteo.net>
CC:     Mykola Lysenko <mykolal@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v2 0/3] Maintain selftest configuration in-tree
Thread-Topic: [PATCH bpf-next v2 0/3] Maintain selftest configuration in-tree
Thread-Index: AQHYoSvnKzjxzKp5x0WOtpQgJ5A/v62RRc+A
Date:   Tue, 26 Jul 2022 23:04:38 +0000
Message-ID: <42352041-E158-4440-AF7A-E07CA1E932BD@fb.com>
References: <20220726201126.2486635-1-deso@posteo.net>
In-Reply-To: <20220726201126.2486635-1-deso@posteo.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e91d878-df6d-4382-fef7-08da6f5b375b
x-ms-traffictypediagnostic: CY4PR15MB1893:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y/kReeJqPf6cZdfyaKivlz5lDX7ppPFtU3urjkdW/JQSwtiUx8ExCkhR3bViu9DNp+3dL0agwJGH9qij+rtk5Qfg+owvLCGpDH4YrXqCO49OIV8cZ+NQzIAVJHApWEpdLRQc7urR/yU1Nik2OFjNUt1Fvo90dEWRTQRyywTZtvDGGh4YDmMdyh8fv5r2MfBBfxMatIw+X3WZCw+C9ndRtHZmD1UPW2pqxW8A4xM5qot0pABToOw2dkso5B5BrWY8eHPh6c8rUXeeDQ4pj/tHlnsxxDFvyt2OxHneQtxWnxBNzJDO4oAI2VndxzyUP8Hvn3YvtE0uQ57GyuGvckHnX/AGC7InxCf4ybe/M9I46rLGvAd4Kga1SRUp7iMw6AjN4Kn4STyYdl6deW8xtduFkQirYFbBPjniwthUPcVCwML5hAr9Nfv1ZLyiYhvQoOnoW7bqkX96vYzsHLiD0ZXxBoOmYjoZ9gsTwtNr78KJCwC5I2wh61pM2yjp80O86BZX8Ar/CWRnZuhTN39l3CoLGm9SmjhQHTdYDXnuJjGTbe11hjOv/i/Hw5HWG86PSV73bJKvkXL5WyA15lQcq0y13SJnMlV7aqudVeBOoIbiWr08C2BAYBrzlbrvzPmUA08cGgobhpRekV5razQavN52moKFvwntrca07AK/I00TmMQQx06epWKO9yJvHI75IIbCoVIsSnGIY4gpJoYCiX4Z6Wy6fACYItOtNOn1KrA0rXOagmUSaIoHu4WbE7QwFftffU37a8iDv0+VxODvN8PP/QrecOs8jJuTblaBHPfCOyS3VQwyK+1uKlNAb8P+xBItxdh+iS2bRDt7bVtFmkvOotv1TB94cGd90hf3mgbWMZ0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5262.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(122000001)(38070700005)(6512007)(38100700002)(86362001)(6486002)(966005)(5660300002)(8936002)(478600001)(33656002)(316002)(64756008)(76116006)(8676002)(66574015)(66476007)(66946007)(91956017)(186003)(2616005)(6916009)(54906003)(66446008)(2906002)(83380400001)(53546011)(41300700001)(36756003)(66556008)(71200400001)(4326008)(6506007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2psbFpjZURTZ2g3anhVbTV1QXp2MHk0ZG8zMGtvZjVTQWVKZnQ1NkJWRGg4?=
 =?utf-8?B?eVphNXZLWUFUNTZmZ0VoVWlqVXRsRTkvc1lrYSsrMEFFUWVvUVptWktTdm1q?=
 =?utf-8?B?ak0vL2RhSUx0MkZVTUl0UXJGWnhTbzJ2djFzY0JVWkdjbUJleW8wMm5ER0ZB?=
 =?utf-8?B?MEo1ODYwZGlmMXZTNkk0ejlHeFlMeVBKSS8yUHF5bHErcDVxcko1bW56ZCt2?=
 =?utf-8?B?NUp1eXJwS2dneENGTm1CWC8vbDJlYWtud1J5eDdlV3kwWXBSOStTbkNpZGFa?=
 =?utf-8?B?bmJJV3J0eHlSVm1lWEdWMnM1WFpiZ1FDblpwdWFpU3pVSSswZ0JTSlQ5aURr?=
 =?utf-8?B?K2JGOWM1TG9lMndST3FyQ3EwR0dqVzBQUXZ2L2V4amVGSjRzSm5MVHF5bGxK?=
 =?utf-8?B?VWxQMDZPUVJYaUxxVVdTdGlGRis5dXR4TFJmU051Z2hSbjJkQUZKb0NZdkdP?=
 =?utf-8?B?elhuVkdKZWZ0NnhaTWVUb2dkMWt6WjVzdXVKTXV5TGFEcU5GaU02QXAwWVg3?=
 =?utf-8?B?ZUlxRHZvbnBlbmNaeGZiN3NIRnBuTUV4aC9EcFE2VDlWTG1qRWg0TGc5cXho?=
 =?utf-8?B?OFpRc0dPT0VpY2Nud0duRDB1UEpBOEhCNUZCd1FqVlcyM3EvQWlnU0JxdFo2?=
 =?utf-8?B?NWdHZDZuZEhaZm9tdit6Q0ZhUDJ2QlVzOVh4VzEyTGdaREtDVTZDWVJtL1I0?=
 =?utf-8?B?MDZzbUlRb3daV2dLbWVLYTUrY0JONDNNcFE3RVdXZU1FWUlTREZDTGF2b3pK?=
 =?utf-8?B?R3BOK3pDNDJlVzRRWnZZZ3Q2VVovaEk5NEhnWDNITW5CbXBJTnpMTlBJM29p?=
 =?utf-8?B?NDdBREc0VTMvYkVISGludUpWUGZVbjhSRjlla3h4SVJkL0dmb2xZM3pVR3lx?=
 =?utf-8?B?Ni96d3RuQmFVeUNDQnNzTXBZcmlDcGMrZVNLOW4veFJMbkhtdXZTZVNnSG40?=
 =?utf-8?B?L3FYaVQzakdpUVhKczQ1ZWRoeVBiQU1ZU0xLQXlxWU9XdjJLMFovYVFUd1lY?=
 =?utf-8?B?SjFDWS9tRDg0WUJoekY0WGc1SkZjSWRUMmZBeVN3ZHpwNk96ekhjY29tb0dT?=
 =?utf-8?B?MkJRaUxvcHJ2L0hWVCtYSDRodVdpUlpJcVI4aHVRVFZQdXFxVW1xZHRWcjBP?=
 =?utf-8?B?U2RYUXBpZnp1OUtwOTVFSWwyaXZPUWt1b281cmQ1cUppeWhaUnZ5Y2RUL1BE?=
 =?utf-8?B?ZTVsR2x1VmNSSHBrRkdBb0Z2cXJKbThSOXE1ZUNtQmVnUnh6Y2hpTTM0UVJy?=
 =?utf-8?B?cWRaMGQrZUt4MFQyZ2E2bm1VWWJ3aHV0ZGVYdWtwQ3dHMGJQbG5YeW56cTN3?=
 =?utf-8?B?Q1dDTVVhRVBCOXF3U2hnS1F1NHdaaFp0NTZYY0c2ZDEyL3REK2MvY016RXVW?=
 =?utf-8?B?dHdsNk1ycG1CU1VnNjk1YWJ3dndkV3VDcVloVDNpenlpcXdJUUMwNTJ5SG93?=
 =?utf-8?B?bjJSVnpjblprRUVXeWFUZGNWd0YrbWo3dGRibWh6eFdKUTIrNHhVdk1jMnRs?=
 =?utf-8?B?bWlTd29RK2I4VHdrdlJPd2R2SmFzOTYrVGdDSDNicVV6ODFMRmZaU0lkOXow?=
 =?utf-8?B?bE83STMvMnMwL0xqQ0tJWUJLSFBjakJ5Vkp4cGVrd0pSYjdXa1FaaGZ4MXNT?=
 =?utf-8?B?Z1djMnpSL29tTStyNU5WdXFqY2VYR2JibWo2RG03dGorQlR3TFI0WHJxY29Z?=
 =?utf-8?B?UkRtR2NMTHB5M3BaNXg2TDFRbVFCaWZxWnVTU0VjMnV5TE9TM3E5a2dYSlZZ?=
 =?utf-8?B?L0htMGErR3RHckVySGdLcUdUYUVNOUwzOHEyUEpVSk14Snc3VVYwSmwrWW5U?=
 =?utf-8?B?UHAxYThLWlBsUDVWVlFVb0FhcjdIRWlQSDZ0WjQzZzEyY0V2QjFnOVhicUlN?=
 =?utf-8?B?WGJ5cGEyVVhGdVBBZlBjdmpqY1BVRi9zR1dKNGsxUnh2WEt1LzZSSWlnb1Rx?=
 =?utf-8?B?aGxrRi9rTmpRQ3VwNmNqQVJlMGFmdEt4QkxSUlBhUXRsd2VGSzUvK0RkeTVz?=
 =?utf-8?B?enh6amxXWGQ2Ym5CaHZBdnJqREI3b2wvdG15QzJITEdWRWErSkVzMGlhZEVF?=
 =?utf-8?B?RTBLK3puZjVMZitkR1A3S3FURHhGUGlrOVpWclJ2V3hSSExQd1FjNEpGYjVq?=
 =?utf-8?B?R2lqZldHdVRjeTBmVUFwVy9FbkF1bWw1UE4yeGhwSDVHVlhsV3k0WExtRVp1?=
 =?utf-8?Q?YaP2NkdkHocZjffInsChEOSHqFLnhKAnuiUKE74STWTA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B67F87EABD4B00478BD3557232A5AFB8@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB5262.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e91d878-df6d-4382-fef7-08da6f5b375b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 23:04:38.7517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fgr/R+/LB3BVaLOB6O1PDZiqLo4ocY7cTnYG0AqkvVfbjXc30r8jo/ZHwz5nhqC0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1893
X-Proofpoint-GUID: 4UZP1HJfurf0BonzOynYT6fYJdOk7TWc
X-Proofpoint-ORIG-GUID: 4UZP1HJfurf0BonzOynYT6fYJdOk7TWc
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_07,2022-07-26_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCj4gT24gSnVsIDI2LCAyMDIyLCBhdCAxOjExIFBNLCBEYW5pZWwgTcO8bGxlciA8ZGVzb0Bw
b3N0ZW8ubmV0PiB3cm90ZToNCj4gDQo+IEJQRiBzZWxmdGVzdHMgbWFuZGF0ZSBjZXJ0YWluIGtl
cm5lbCBjb25maWd1cmF0aW9uIG9wdGlvbnMgdG8gYmUgcHJlc2VudCBpbg0KPiBvcmRlciB0byBw
YXNzLiBDdXJyZW50bHkgdGhlICJyZWZlcmVuY2UiIGNvbmZpZyBmaWxlcyBjb250YWluaW5nIHRo
ZXNlIG9wdGlvbnMNCj4gYXJlIGhvc3RlZCBpbiBhIHNlcGFyYXRlIHJlcG9zaXRvcnkgWzBdLiBG
cm9tIHRoZXJlIHRoZXkgYXJlIHBpY2tlZCB1cCBieSB0aGUNCj4gQlBGIGNvbnRpbnVvdXMgaW50
ZWdyYXRpb24gc3lzdGVtIGFzIHdlbGwgYXMgdGhlIGluLXRyZWUgdm10ZXN0LnNoIGhlbHBlcg0K
PiBzY3JpcHQsIHdoaWNoIGFsbG93cyBmb3IgcnVubmluZyB0ZXN0cyBpbiBhIFZNLWJhc2VkIHNl
dHVwIGxvY2FsbHkuDQo+IA0KPiBCdXQgaXQgZ2V0cyB3b3JzZSwgYXMgIkJQRiBDSSIgaXMgcmVh
bGx5IHR3byBDSSBzeXN0ZW1zOiBvbmUgZm9yIGxpYmJwZg0KPiAobWVudGlvbmVkIGFib3ZlKSBh
bmQgb25lIGZvciB0aGUgYnBmLW5leHQga2VybmVsIHJlcG9zaXRvcnkgKG9yIG1vcmUgcHJlY2lz
ZWx5Og0KPiBmYW1pbHkgb2YgcmVwb3NpdG9yaWVzLCBhcyBicGYtcmMgaXMgdXNpbmcgdGhlIHN5
c3RlbSkuIEFzIHN1Y2gsIHdlIGhhdmUgYW4NCj4gYWRkaXRpb25hbCAtLSBhbmQgc2xpZ2h0bHkg
ZGl2ZXJnZW50IC0tIGNvcHkgb2YgdGhlc2UgY29uZmlndXJhdGlvbnMuDQo+IA0KPiBUaGlzIHBh
dGNoIHNldCBwcm9wb3NlcyB0aGUgbWVyZ2luZyBvZiBzYWlkIGNvbmZpZ3VyYXRpb25zIGludG8g
dGhpcyByZXBvc2l0b3J5Lg0KPiBEb2luZyBzbyBwcm92aWRlcyBzZXZlcmFsIGJlbmVmaXRzOg0K
PiAxKSB0aGUgdm10ZXN0LnNoIHNjcmlwdCBpcyBub3cgc2VsZi1jb250YWluZWQsIG5vIGxvbmdl
ciByZXF1aXJpbmcgdG8gcHVsbA0KPiAgIGNvbmZpZ3VyYXRpb25zIG92ZXIgdGhlIG5ldHdvcmsN
Cj4gMikgd2UgY2FuIGhhdmUgYSBzaW5nbGUgY29weSBvZiB0aGVzZSBjb25maWd1cmF0aW9ucywg
ZWxpbWluYXRpbmcgdGhlDQo+ICAgbWFpbnRlbmFuY2UgYnVyZGVuIG9mIGtlZXBpbmcgdHdvIHZl
cnNpb25zIGluLXN5bmMNCj4gMykgdGhlIGtlcm5lbCB0cmVlIGlzIHRoZSBwbGFjZSB3aGVyZSBt
b3N0IGRldmVsb3BtZW50IGhhcHBlbnMsIHNvIGl0IGlzIHRoZQ0KPiAgIG1vc3QgbmF0dXJhbCB0
byBhZGp1c3QgY29uZmlndXJhdGlvbnMgYXMgY2hhbmdlcyBhcmUgcHJvcG9zZWQgdGhlcmUsIGFz
DQo+ICAgb3Bwb3NlZCB0byBvdXQtb2YtdHJlZSwgd2hlcmUgdGhleSB3b3VsZCBhbHdheXMgcmVt
YWluIGFuIGFmdGVydGhvdWdodA0KPiANCj4gVGhlIHBhdGNoIHNldCBpcyBzdHJ1Y3R1cmVkIGlu
IHN1Y2ggYSB3YXkgdGhhdCB3ZSBmaXJzdCBpbnRlZ3JhdGUgdGhlIGV4dGVybmFsDQo+IGNvbmZp
Z3VyYXRpb24gWzBdIGFuZCB0aGVuIGFkanVzdCB0aGUgdm10ZXN0LnNoIHNjcmlwdCB0byBwaWNr
IHVwIHRoZSBsb2NhbA0KPiBjb25maWd1cmF0aW9uIGluc3RlYWQgb2YgcmVhY2hpbmcgb3V0IHRv
IEdpdEh1Yi4NCj4gDQo+IFswXSBodHRwczovL2dpdGh1Yi5jb20vbGliYnBmL2xpYmJwZi90cmVl
LzIwZjAzMzAyMzUwYTQxNDM4MjVjZWRjYmQyMTBjNGQ3MTEyYzE4OTgvdHJhdmlzLWNpL3ZtdGVz
dC9jb25maWdzDQo+IA0KPiAtLS0NCj4gQ2hhbmdlbG9nOg0KPiB2MiAtPiB2MzoNCj4gLSByZW1v
dmVkIHNldmVuIG1vcmUgb3B0aW9ucyBmcm9tIHMzOTB4IGNvbmZpZ3VyYXRpb24gdGhhdCBvdmVy
bGFwcGVkIHdpdGgNCj4gIHByZS1leGlzdGluZyBjb25maWcNCj4gdjEgLT4gdjI6DQo+IC0gbWlu
aW1pemVkIGltcG9ydGVkIGtlcm5lbCBjb25maWdzIGFuZCBtYWRlIHRoZW0gYnVpbGQgb24gdG9w
IG9mIGV4aXN0aW5nDQo+ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvY29uZmlnDQo+ICAt
IG1vdmVkIHRoZW0gZGlyZWN0bHkgaW50byB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvDQo+
IC0gc29ydGVkIGFuZCBjbGVhbmVkIHVwIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9jb25m
aWcNCj4gLSByZW1vdmVkICJzZWxmdGVzdHMvYnBmOiBJbnRlZ3JhdGUgdm10ZXN0IGNvbmZpZ3Mi
IGZyb20gcGF0Y2ggc2V0DQo+IC0gcmVtb3ZlZCA0LjkgJiA1LjUgY29uZmlncw0KPiANCj4gRGFu
aWVsIE3DvGxsZXIgKDMpOg0KPiAgc2VsZnRlc3RzL2JwZjogU29ydCBjb25maWd1cmF0aW9uDQo+
ICBzZWxmdGVzdHMvYnBmOiBDb3B5IG92ZXIgbGliYnBmIGNvbmZpZ3MNCj4gIHNlbGZ0ZXN0cy9i
cGY6IEFkanVzdCB2bXRlc3Quc2ggdG8gdXNlIGxvY2FsIGtlcm5lbCBjb25maWd1cmF0aW9uDQo+
IA0KPiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvREVOWUxJU1QgICAgICAgfCAgIDYgKw0K
PiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvREVOWUxJU1QuczM5MHggfCAgNjcgKysrKysr
DQo+IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9jb25maWcgICAgICAgICB8IDEwMSArKysr
LS0tLS0NCj4gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL2NvbmZpZy5zMzkweCAgIHwgMTQ3
ICsrKysrKysrKysrKw0KPiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvY29uZmlnLng4Nl82
NCAgfCAyNTEgKysrKysrKysrKysrKysrKysrKysrDQo+IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2JwZi92bXRlc3Quc2ggICAgICB8ICA1MSArKystLQ0KPiA2IGZpbGVzIGNoYW5nZWQsIDU1NCBp
bnNlcnRpb25zKCspLCA2OSBkZWxldGlvbnMoLSkNCj4gY3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9ERU5ZTElTVA0KPiBjcmVhdGUgbW9kZSAxMDA2NDQgdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL0RFTllMSVNULnMzOTB4DQo+IGNyZWF0ZSBtb2RlIDEw
MDY0NCB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvY29uZmlnLnMzOTB4DQo+IGNyZWF0ZSBt
b2RlIDEwMDY0NCB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvY29uZmlnLng4Nl82NA0KPiAN
Cj4gLS0gDQo+IDIuMzAuMg0KPiANCg0KQWNrZWQtYnk6IE15a29sYSBMeXNlbmtvIDxteWtvbGFs
QGZiLmNvbT4=
