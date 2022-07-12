Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484AC572362
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 20:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbiGLSrN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 14:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbiGLSqp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 14:46:45 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5638CDC8B6
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 11:42:57 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26C9us3X024322
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 11:42:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=B1EoeLlNjufD82BM0mnKwsQOsZsfpwp142SQriGabfo=;
 b=V5h8cf9ooRHa1Ypbg9bdZ5adQtVRjA35BSdvtacvzvvCbYBTb7P/8Yc+CcjLlK0LUtIe
 I/b4i4QY7z5/4IoAQBIRz4qsVW6m55gSCBQtyp/Ezs4rgBrY0yk9CJj2FFUfEBfcT3cJ
 tDMcjLNyR9FjAl7YEHEUjYZ0yGXzgpj0Zsc= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h96s23c56-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 11:42:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D21dCZmVEkbuxVdpduP2biq/mULjz3N7VK5ukArHtbbi61mVlAlAM6PMTsHv4tKRxzlNmbJvUDTRBXE2uiuoAtd3Srlhb+nhrlmjrgnKreJ7dBsOUopKcWilI6FsFU69lovLArABK9FdUhYkkhpoGPc2DBrYMv/dwa5cse5PYvC3pyRh//qMVx0MDtuw/qO1CXqivEJYxCq5+FNF1vbjKeA/uZDi8+vZquaCNutIX3B5DFjKauAHBSWSgEnYH/Xe8GpHojUrIASOfX3HEZDqRZcGcI3C+UVs9HOVENGQMhUhOPJ9jrEtotv4EingNQ65vVaEGJ8hYyYrvan1p3awYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1EoeLlNjufD82BM0mnKwsQOsZsfpwp142SQriGabfo=;
 b=dsCUpDSk3/IWn4wpMnu37BYUiYG+WaQjmi2NCJ9Bn0ndPlvyevDw/oIcOB/26FuDs+AEGvpUqXhTearLPftKPpnV/lGBlZJsM/rCJBIHEmlIQmODibg4+TKK/v2W28qBSYwZdfaoNEs0s0tmeAtfjHiuPiGRX+pDRwIKjsHEs8o+hJER8DCjstw+K68MNrW1sCochoCgAjqqbUpvf/ByaRtaePzpYVsPIIGGsmWI5CH0j9I5LdAUq2+X42uJQRa+wMzX7qbaM1Gox0Xe7MTw2X2Y3057sB9ddbOxafOJ7uWxO/hIo80Hx2FyRtmAd1+80FG7EAKLWtHRLrFG3PvbcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by CO1PR15MB4890.namprd15.prod.outlook.com (2603:10b6:303:e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 18:42:53 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::ac52:e8fa:831f:237e]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::ac52:e8fa:831f:237e%9]) with mapi id 15.20.5395.020; Tue, 12 Jul 2022
 18:42:52 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "sdf@google.com" <sdf@google.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH RFC bpf-next 0/3] Execution context callbacks
Thread-Topic: [PATCH RFC bpf-next 0/3] Execution context callbacks
Thread-Index: AQHYlW/snznW93TcsEKe6oR5OxPAGK17CZiAgAAIg4A=
Date:   Tue, 12 Jul 2022 18:42:52 +0000
Message-ID: <3a6294a44dfec84b3efbdebed6a0d8d9c5874815.camel@fb.com>
References: <cover.1657576063.git.delyank@fb.com>
         <Ys24W4RJS0BAfKzP@google.com>
In-Reply-To: <Ys24W4RJS0BAfKzP@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22a81878-50a6-45b6-02ee-08da6436540f
x-ms-traffictypediagnostic: CO1PR15MB4890:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bxr9KV6wheYCx1Pm/0sQUsM9MslYiWtzmaLD6jFWrSvTwNDNFyameY8kcf/Kl9lTkdP3kzB1QU8q2SfvXf8x66P25/v2STXJRJQSGtftjt65fBjVvY9CxacMMKTYsnwbsfIINHwiMRxIt81kH3UMCzITTmwvLwMvM4boUFSC9nTqEMKOVNM7shBZBHb+fler161mMcRBawHPeeT2X1NBCCzK6FlFOGt/Ez9OyQHjvWrnJXP9JzQxwNKANWlnBswthLECSk7GpFwJkLt2gQtr3iVbmU3iSiyUP+PRzxesBN6mroI1CWX1YdZnLY1Nxfl1kwcsTrVIu5jwuqsHIsIbvigIo6yX1S0YjaM+o7hSZMDnAK1bLiD4dbOQr4ZifG3Zc0AIiqFpFxmZspbs7giA9J4hAkkXV/ll4bZz8+N2JibpxfyFl63pZKRQ4AVVV8yAKpFhk9zYDr4++CvZuXJtBFLS2GjpgZFpmXFWRl/XAXgSp90fR/UMmJM69UrxoXXBMFWHOXuHCKQ9wDAXRxndAGDg/baJCwxGeoahV81+9SdM7+3kWBL6GLzAfifjGgch3qQI64PgOod5A7rnjvtgeRlXeedrQJQ4PpwyakWO7B/jah5NODxjtOqV4ETsYWNVeJKUCoWbgZbQjyjYLhthxpnNXa2k9vg2IgzPqFtDlBz0i+eKiqyOwcCZKia/RMvbFUGmgpJZy6fp7wFI1lKYqHV01PboUid9vTEJJrHJlxXBCxmFt++lrrGy3dajyZIcYmA7TV3bsdQSDZHvdvdABQurhqELIAIGglES35YXqVZhfctBgqNbLiih3F2Pweh+M7+HQH5m8kcp4YCTJyr0DCxSGX2PW2d/apowDiG4DNk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(122000001)(2906002)(8936002)(83380400001)(6512007)(38100700002)(6506007)(8676002)(4326008)(54906003)(66476007)(5660300002)(966005)(6916009)(66446008)(316002)(76116006)(66946007)(91956017)(186003)(2616005)(66556008)(64756008)(6486002)(478600001)(71200400001)(86362001)(38070700005)(41300700001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFBjR0h6dnFhenRXM2RncGpiZWVOMC9adjM4Qmh3TmpVeTU5ZWJVR3g0Uy9B?=
 =?utf-8?B?VFFoS0lOVTNNLzJITUJ5U3Z6VFpDUFpUQ0FIN1NCcVlsYWFiaHRmTGVlRDBE?=
 =?utf-8?B?WVdKUzFVVXMzanJNbC9XaW5KWkJqTGlvc2tMQjROSHBBNFBLNHlRWHJnaHRu?=
 =?utf-8?B?bTZWcmNBR3dpRzRzZFhMOXFmcG9UV0dsd3hSQVVBNFRsSnhkWSt3Y0U2aWVk?=
 =?utf-8?B?dHZLMThMU004RzMxcFJmUkxBcGVNYUp0a0pFbGFqUVBEUFNkVWNOVVJXN1hj?=
 =?utf-8?B?SW9nSEhUR2p1ZUNWejlMdGw1RFRlMmg1M2xDRXYzd3lIQUx0eUw5UkZHL2ho?=
 =?utf-8?B?VnVTQW5FanF3OWNPakV2bm91SW45dmxXUjBaZUl2M2tyNmVNLytvaktRejZq?=
 =?utf-8?B?STdqSENDcG53ZjFLUTNNdkVVdm5qME5pYzZaYXY2YUQ3bWhlbHVXNnYzVkFX?=
 =?utf-8?B?SkQ3clVCU3BQMWNvR3JJQkluN0FtWkxQb2ZRa2xlaEIwd1FmMENPTGpHamds?=
 =?utf-8?B?RVhLNVZiMGtPTk1RUkdSdnVPMnFCOVBJc05McGcwTGw5amxQTnd4YzVhL1pC?=
 =?utf-8?B?RmU2Y3NsUUI1SDg1TGxTQWIzdzZpZ3JweVJlTnR1ME9xU25UN2F6cnZ2dGdu?=
 =?utf-8?B?WXlHSmdockdvSklNVi9aakZlMnZSRmp2TTZzNWtKaFdYRHkzMW1DcjgzZURX?=
 =?utf-8?B?MytIYmpZOEMycnhWRTZxS0ZCSXpybzhTRDVCZFZMLzVIeHNtR0doV2EyY0VX?=
 =?utf-8?B?eHRRY2FzRXY2bTNFMHNMZUduUEVYWjdOOXNDRTdHclUvQUZ0dHJab2JJOXZu?=
 =?utf-8?B?cnlmazQ4Ym9qOFcwS0dZR1E5SXhrUFVuejRxZVZyL3VwMDVYV25WNk1SaVA5?=
 =?utf-8?B?Um9SN2Q5MEpwQkZxb0tqTUM0cmlubDc2WTl4MGJRdWtxSjVWOUNHbGxhbW9n?=
 =?utf-8?B?NjBtTlJpMVZnV25rOFBrTjZScFVTNVkrcEVoZmtMV3c4RURIQlNlMDMvREZU?=
 =?utf-8?B?WlJGeEE1aHVpTXk2YXJyMjFaV3F1VFNKR09EdVFERDZIdGpiVElRRzFMcFdI?=
 =?utf-8?B?K1BhMzViV01TWTJIWHBjVjJSWmNaa3A0Y1lERmFqTXVRTzkrbjFaNVNPMVYy?=
 =?utf-8?B?bjNPU1ZQSGZRdGVqK2pNSWJicUkxTm4xU3V1WXVvdjE1c28xQkxPWWZUdDg2?=
 =?utf-8?B?OENMV1lSRHFsMHBoajlhTGRRaDhsZitiQm1HR0xiaXM1NklKRGNqc3RlVVli?=
 =?utf-8?B?V1QzbGJadGQ0VmtrOU5OTVpubGFtSHR1OVg1V1NUbzVBYjM1dDY5ZGkzQlBP?=
 =?utf-8?B?akJHRmd6cjg4TE1GSEkybnZNZnBHUHdHSUsyZlRHQzRUS1ZvRTBKQTdic3lR?=
 =?utf-8?B?ZkV3K1o4RzlpL3gvTzl1QmRCanJmcEIwbWl5M0dydDhRdEhlcldzdTNyKzI4?=
 =?utf-8?B?aS9FclAwSzlRWERaTnpwcjMrOEwzRUw2bkl1bHBBM1JKT3cwTzc3Y3hYZlpS?=
 =?utf-8?B?a0N1b0duSjhhdGlxTng5RDd0dlAxc2xrVGxwSitOVW1VRmhmKytVbHBSRVhG?=
 =?utf-8?B?eENHV3hyWGxnTHY3WGZuSTJXM0h0TDlWbU9zUmtsSVJLajB1ZGUva3AzS0pl?=
 =?utf-8?B?eXFrUFJ6bmhkaVBFMmFQa0RUQytpV2NCTU0wOEZxdWFBZjlkYm8rNmhHemIy?=
 =?utf-8?B?UnVHV0RKK3IwZzY4aHBvWjVJSWxFeS8rY05FZUxSa1VmOXlGQUlMRUgwMWVW?=
 =?utf-8?B?M2Y5VkdObWs1dG5Oa1BvdnBHb1VZTUk5QWFueDZRNW5sOGNjc3phY3M1S3Zt?=
 =?utf-8?B?UW14YWtBSFlldi9YNTY4UDF5bHd3bEVxS2xGY3FiZGR0dUpySnNhbDFmaXpv?=
 =?utf-8?B?cjAvSmN5ZnVQcE9nUFZ1L0VsRGYwZlZIdVd4R0FLWXNMaVowZWk2ZTdDdUl5?=
 =?utf-8?B?MnU0eEkwd3phK3I4dEpuNDUxTkVNZCs1MzFsaG56OWpwdkl1cG9WOGFIQ0sz?=
 =?utf-8?B?V0U0VHA2Q0VJaVJlM1BHZktidVlTbzM3TW9UVWExUnArRzBKTU4vT2FDSith?=
 =?utf-8?B?a251T0JmMTdUYTFpWDA3SEVHZk84MFkrSXNmMTE2RE1ZNDREeWNnZVc3NU8y?=
 =?utf-8?B?NlhlWG9RNmFPY0t1b1VqVzAzNGd6UjQ3ZTdYTjA4K0owK3R1cWN1NnFWd01x?=
 =?utf-8?B?Wnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <470CF26E6E00B94ABB34CAEA57423C05@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a81878-50a6-45b6-02ee-08da6436540f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 18:42:52.7003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GtKgabKKQ/FAQSV20+DR2Pw3UfPZhkBWMALozf/CwAKY34DR+nVvDyuswbTYKCIK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4890
X-Proofpoint-GUID: 1DjgMmO8Wjpb2EflPezsicL1KLsVf5P7
X-Proofpoint-ORIG-GUID: 1DjgMmO8Wjpb2EflPezsicL1KLsVf5P7
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_12,2022-07-12_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

VGhhbmtzIGZvciB0YWtpbmcgYSBsb29rLCBTdGFuaXNsYXYhDQoNCk9uIFR1ZSwgMjAyMi0wNy0x
MiBhdCAxMTowNyAtMDcwMCwgc2RmQGdvb2dsZS5jb20gd3JvdGU6DQo+ICpzbmlwKg0KPiA+IDIu
IFRoZSBjYWxsYmFjayBhcmd1bWVudHMgbmVlZCB0byBiZSBpbiBhIG1hcC4gV2UgY2FuIGN1cnJl
bnRseSBleHByZXNzICANCj4gPiBoZWxwZXIgYXJndW1lbnRzIHRha2luZyBhDQo+ID4gcG9pbnRl
ciB0byBhIG1hcCB2YWx1ZSBidXQgbm90IGEgcG9pbnRlciB0byBfd2l0aGluXyBhIG1hcCB2YWx1
ZS4gU2hvdWxkICANCj4gPiB3ZSBhZGQgYSBuZXcgYXJndW1lbnQNCj4gPiB0eXBlIG9yIHNob3Vs
ZCB3ZSBqdXN0IHBhc3MgdGhlIG1hcCB2YWx1ZSBwb2ludGVyIHRvIHRoZSBjYWxsYmFjaz8NCj4g
DQo+IFBhc3NpbmcgbWFwIHZhbHVlIHBvaW50ZXIgKGFzIHlvdSBkbyBpbiB0aGUgc2VsZnRlc3Qp
IHNlZW1zIGZpbmU7IGRvDQo+IHlvdSB0aGluayB3ZSBuZWVkIG1vcmUgZmxleGliaWxpdHkgaGVy
ZT8NCg0KSSB0aGluayBpdCBtYWtlcyBhIGNsZWFuZXIgYW5kIG1vcmUgZmFtaWxpYXIgQVBJIC0g
dGhlIHBvaW50ZXIgdG8gbXkgZGF0YSB0aGF0IEkgZ2l2ZQ0KdG8gdGhlIHN1Ym1pc3Npb24gZnVu
Y3Rpb24gaXMgdGhlIG9uZSBJIGdldCBpbiB0aGUgY2FsbGJhY2suIFJlcXVpcmluZyBpdCB0byBi
ZSBhIG1hcA0KdmFsdWUgaXMgYSBsaXR0bGUgYml0IHF1aXJreSAoaXQncyBub3QgcmVhbGx5IG15
IGRhdGEgaXQncyBwb2ludGluZyB0byEpLiBJIGRvbid0DQprbm93IGlmIGl0J3MgYSBsb3Qgb2Yg
d29yayBpbiB0aGUgdmVyaWZpZXIgdG8gaXJvbiBvdXQgdGhpcyBxdWlyayBidXQgaWYgaXQncw0K
cmVhc29uYWJsZSwgSSdkIGJlIGhhcHB5IHRvIG1ha2UgdGhlIGRldmVsb3BlciBleHBlcmllbmNl
IGEgbGl0dGxlIG1vcmUgcHJlZGljdGFibGUuDQoNCj4gPiAzLiBBIGxvdCBvZiB0aGUgbWFwIGhh
bmRsaW5nIGNvZGUgaXMgdmVyYmF0aW0gZnJvbSBicGZfdGltZXIuIFRoaXMgZmVlbHMgIA0KPiA+
IGlja3kgYnV0IEknbSBub3Qgc3VyZSBpZiBpdA0KPiA+IGp1c3RpZmllcyBhIHJlZmFjdG9yIHF1
aXRlIHlldC4gT3BpbmlvbnMgd2VsY29tZS4NCj4gDQo+ICsxLCBpdCBkb2VzIHNlZW0gdmVyeSBj
bG9zZSB0byBhIHRpbWVyIHdpdGggZXhwaXJ5IHRpbWUgPT0gMC4NCj4gDQo+IEkgZG9uJ3Qga25v
dyB3aGF0J3MgdGhlIGV4YWN0IHVzZWNhc2UgeW91J3JlIHRyeWluZyB0byBzb2x2ZSBleGFjdGx5
LA0KDQpUaGUgcHJpbWFyeSBtb3RpdmF0aW5nIGV4YW1wbGVzIGFyZSAxKSBHRlBfQVRPTUlDIHVz
YWdlIGlzIG5vdCBzYWZlIGluIE5NSSBhaXVpLCBzbw0Kc3dpdGNoaW5nIGFsbG9jYXRpb25zIHRv
IGhhcmRpcnEgaGVscHMgYW5kIDIpIGNvcHlfZnJvbV91c2VyIGluIHRyYWNpbmcgcHJvZ3JhbXMg
KG5taQ0Kb3Igc29mdGlycSB3aGVuIHVzaW5nIHNvZnR3YXJlIGNsb2NrcykuIFRoZSBsYXR0ZXIg
c2hvd3MgdXAgaW4gaW5zaWRpb3VzIHdheXMgbGlrZQ0KYnVpbGQgaWQgbm90IGJlaW5nIHJlbGlh
YmxlIHdoZW4gcmV0cmlldmluZyBzdGFjayB0cmFjZXMgKFsxXSBpcyBhIHRocmVhZCBmcm9tIGEN
CndoaWxlIGFnbyBhYm91dCBpdCkuDQoNCj4gYnV0IGhhdmUgeW91IHRob3VnaCBvZiBtYXliZSBp
bml0aWFsbHkgc3VwcG9ydGluZyBzb21ldGhpbmcgbGlrZToNCj4gDQo+IGJwZl90aW1lcl9pbml0
KCZ0aW1lciwgbWFwLCBTT01FX05FV19ERUZFUlJFRF9OTUlfT05MWV9GTEFHKTsNCj4gYnBmX3Rp
bWVyX3NldF9jYWxsYmFjaygmdGltZXIsIGNnKTsNCj4gYnBmX3RpbWVyX3N0YXJ0KCZ0aW1lciwg
MCwgMCk7DQo+IA0KPiBJZiB5b3UgaW5pdCBhIHRpbWVyIHdpdGggdGhhdCBzcGVjaWFsIGZsYWcs
IEknbSBhc3N1bWluZyB5b3UgY2FuIGhhdmUNCj4gc3BlY2lhbCBjYXNlcyBpbiB0aGUgZXhpc3Rp
bmcgaGVscGVycyB0byBzaW11bGF0ZSB0aGUgZGVsYXllZCB3b3JrPw0KDQpQb3RlbnRpYWxseSBi
dXQgSSBoYXZlIHNvbWUgcmVzZXJ2YXRpb25zIGFib3V0IGRyYXdpbmcgdGhpcyBlcXVpdmFsZW5j
ZS4NCg0KPiBUaGVuLCB0aGUgdmVyaWZpZXIgY2hhbmdlcyBzaG91bGQgYmUgbWluaW1hbCBpdCBz
ZWVtcy4NCj4gDQo+IE9UT0gsIGhhdmluZyBhIHNlcGFyYXRlIHNldCBvZiBoZWxwZXJzIHNlZW1z
IG1vcmUgY2xlYXIgQVBJLXdpc2UgOi0vDQoNClRoZSBwcmltYXJ5IHdheSB0aGlzIGRpZmZlcnMg
ZnJvbSB0aW1lcnMgaXMgdGhhdCB0aW1lcnMgYWxyZWFkeSBzcGVjaWZ5IGFuIGV4ZWN1dGlvbg0K
Y29udGV4dCAtIHRoZSBjYWxsYmFjayB3aWxsIGJlIGNhbGxlZCBmcm9tIGEgc29mdGlycS7CoA0K
DQpJdCBkb2Vzbid0IG1ha2Ugc2Vuc2UgdG8gbWUgdG8gaGF2ZSBzb21lICJ0aW1lcnMiIChidXQg
b25seSAwLWRlbGF5LCBzdXBlci1zcGVjaWFsDQp0aW1lcnMpIHJ1biBpbiBoYXJkaXJxIG9yLCBt
b3JlIGNvbmZ1c2luZ2x5LCB1c2VyIGNvbnRleHQuIEF0IHRoYXQgcG9pbnQsIHRoZXJlJ3MNCmxp
dHRsZSBpbiB0aGUgQVBJIHRvIGV4cHJlc3MgdGhlc2UgZGlmZmVyZW5jZXMsIChlLmcuLCBicGZf
Y29weV9mcm9tX3VzZXJfdGFzayBpcw0KYWNjZXNzaWJsZSBpbiAqdGhpcyogY2FsbGJhY2spIGFu
ZCB0aGUgdmVyaWZpZXIgd29yayB3aWxsIGJlIGZhciBtb3JlIGNoYWxsZW5naW5nIChpZg0KYXQg
YWxsIHBvc3NpYmxlIHNpbmNlIHRoZSBpbml0IGFuZCB0aGUgc2V0X2NhbGxiYWNrIHdvdWxkIGJl
IHNwbGl0KS4NCg0KSSB0aGluayBpdCdzIHdvcnRoIHRoaW5raW5nIGFib3V0IGhvdyB0byB1bmlm
eSB0aGUgaGFuZGxpbmcgb2YgdGltZXItbGlrZSBtYXAgdmFsdWUNCm1lbWJlcnMgYnV0IEkgZG9u
J3QgdGhpbmsgaXQncyB3b3J0aCBpdCB0cnlpbmcgdG8gc2hvZWhvcm4gdGhpcyBmdW5jdGlvbmFs
aXR5IGludG8NCmV4aXN0aW5nIGluZnJhLg0KDQo+ICpzbmlwKg0KDQogIFsxXTogaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvYnBmL0NBK2toVzdnaD12TzhtLV9TVm53V3dqN2t2K0VEZVVQY3VXRnFl
YmYyWm1pOVRfb0VBUUBtYWlsLmdtYWlsLmNvbS8NCg0K
