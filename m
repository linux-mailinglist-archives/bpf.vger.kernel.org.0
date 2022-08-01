Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3936587476
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 01:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbiHAXfH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 19:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbiHAXfG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 19:35:06 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736AB26125
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 16:35:05 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271NFTPO027958
        for <bpf@vger.kernel.org>; Mon, 1 Aug 2022 16:35:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=+lU/sDHJBosWC4gOOYD0ao12yOkCmtkkeReGF8XP4c8=;
 b=PfEFSa6iMv3Mp15KVewtqQ/A6H7H4zx5cX8V7s15yvQL/KsQaiLOLKZN/dS/1897YBIw
 ig2Ugl1G+krePpIENrbil5E22+Mm6svaf3o0ay3BxcwWIwGKnVkmxK13HrlFC5VV4Ze4
 lMityfV71L2TYaEfqbnkyzT7zAX3CqZq0qI= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hpq1p8gqh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 01 Aug 2022 16:35:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzEgtmmolZzvtsCl4ltj0XG9gB+oZWzF5s9CvaCcxgukdMGxKBgVEFAfgjUmZE+CBjgc79V4DnV/OUpYMbWqdRI/7tjMyTcr70qYd8aLE0SIOfqDu8QkshO5GcQZdvlfsPvLm9xUvg4358z26c2Mc8pTT95VvefRwQCkljltjDaT+Jd1hsUNqlcqCj2HaR8JmHqL/5HHs7x271VU+zPl3CJqP3hw1L3salcHsARpXvVvoE0MKoRiaS+UbMf/+JZSyGb4ToIs+xH8QIPlEEBMHgB7YqvdqdHe12xBjl8DsybPvn2AkNcqrxI7b7vEExASDy30zyvg7yde4ukWLvzw/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lU/sDHJBosWC4gOOYD0ao12yOkCmtkkeReGF8XP4c8=;
 b=YtRSpYDkH9nUS8qmRfmdeLFzv2+6KbNz24EB0iT8uVXdDnZQZNriP1fP+MiiqTNlNYFDdAVS4jrWmCS1FOLmIjPX7cLo6SVt6oGyU0B0fcFbARFdSxoGY11tCsd4OGRCMxXSiyvToepiGFevaXSUocLCCz/xM6rwSUXvk/VPkM5kaZ6J3/vuQCBCvasWpDAJe1x6ePkQY+ZKeTjmMr4wKSbBZ1UB7UU+w99wmMb6B0aAOqZbZN+PFbogQ1MWGKZsPDFXiP3VtxUVEXMQ0NxacXFK8i6hEUAdoLwqEZG7rC+jA/dhRtgXy/Dj9FF0L/tV0iU8v4FQamXPeahgqMhgpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by SN7PR15MB4173.namprd15.prod.outlook.com (2603:10b6:806:10f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Mon, 1 Aug
 2022 23:35:02 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f%6]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 23:35:02 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 0/3] Parameterize task iterators.
Thread-Topic: [PATCH bpf-next v2 0/3] Parameterize task iterators.
Thread-Index: AQHYpf4+Y5cdnHgr4USlL2FpW3gK7a2asqaA
Date:   Mon, 1 Aug 2022 23:35:02 +0000
Message-ID: <f92e20e9961963e20766e290ee6668edd4bacf06.camel@fb.com>
References: <20220801232649.2306614-1-kuifeng@fb.com>
In-Reply-To: <20220801232649.2306614-1-kuifeng@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa8a64bc-1b5b-42b7-81a4-08da741674d8
x-ms-traffictypediagnostic: SN7PR15MB4173:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c80tciggAJ1SOgKImTdI4Kq9M+tDJk91Lic+h0b/i4RITcMKlKMwsjTHPQ20YV6pWsEqTWBzTjCbECwX104lnu/f/a65SHP07BMJPPRhM32Iuux1sOtaVbNiPZS7DAs3MhfvioaKfk3IYEgh21RfPxQJaTD6EMs4VclXRLE2ZYb3Y99hiHVeQQFycSlI2umMI6wTdTg35t/2kUC8YL8lk3y5LU+X/5Z7tILb+r5J1tkGYDZwZYUMpjQmI1Ou2vh69KjUWLjdtsDa+k1mXZT+KgFS33rFY+JpG7WMbmeUMlRGIzek9M4vSctqNF4EN8Io/lSXUPygbaThxx4KSGEKNGQI0bdWwuVHQNXsTaQEwCicLswi9+chAuWsEGDhhd4HcCDsJ2F03pOf5M0n00P/kU/3xHlH+SsPJoGNYoqWSL8OnagzlyaXTWnSveQ6YwEgvGBmhqhKd7p4goaHos16ryCnlrRelTqct4HNN8p5tG6c8p2v6jIJdbWea226fknbVNSDHbHQw3A7ySYaKzE4Cv7eHjWD1gOS30zbzqp/7UdiV21APzeNM+SNfthN1plCgtlsoGQGCpO2CaDdYox5srrG5PdNQMjZun6Z4eSl0omA4h+Yp+lw/bbNckZs+HwimdbzasuXWA2ABftjmudnvIBbuVIoHZoKKcBsBT4DvSi1I3ciVorP/a4zQFa/EkgNqLwk/8Zc7wjIwY4BDzLS1TcedZRVbtY2L00Gvz8o7duhWBnm/yfNSa3Y2vIY4M3EEuHPOIs11q5MWDq1VJwIyxi4v1oGPJAmh+e1UGNhqkalY9Fq0qcYz/d+0uUbhqm0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(66476007)(76116006)(66446008)(38070700005)(64756008)(66946007)(5660300002)(83380400001)(478600001)(8936002)(66556008)(6486002)(2616005)(186003)(71200400001)(8676002)(36756003)(6506007)(110136005)(38100700002)(2906002)(316002)(6512007)(86362001)(41300700001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjJ0MitLbzdLMEFxeTkycGRyd0ZLdEhqei83c2hqakFBNFV3bVZQdnpVWk5Y?=
 =?utf-8?B?MmVGRTRTbFR2VmhROENHSG85dFdFcWt0ZlkrUlNUY3RKeCtlcmZtallWTzNH?=
 =?utf-8?B?bTA5MlA4azV5YTEwQ0N6cHFpdU5WYkdvNnpFRGZQb0VKeUhvWFdNcU9Yb0w4?=
 =?utf-8?B?N3lTZ3A4Y0Y1NHVTOVFheXVmeUYrTTBDQUVYaHdYVEp3b2RIakMwNkpDVmJn?=
 =?utf-8?B?NVFiV3VYRU5CMndRSERDL3kwRHF0Y3pka0tGYTFnYlBMN3d1bytwaThvUFdD?=
 =?utf-8?B?R3V3VkJxYjFnT21ZVkJiN040dStzOG9iWmZMUER4dklPUmFjemFzNk1LSkFK?=
 =?utf-8?B?OUpQUEFUQUU3RjVuZ3JvY0xnWVUrT1RQQ3owQ3RoVWcyZ3BZSGliWno4NjVH?=
 =?utf-8?B?aWtWVG9oeHMvOXJ2WDNQcUYxZkN5MG1RVDI0aDlOQ1pSUkdBZ2ttM2pGT0JY?=
 =?utf-8?B?dFpTVUx6U3ZERktvUW9WYzFMNkFsOTcvanF6Uy9mUWIrTmorYm1PRE8rcUtX?=
 =?utf-8?B?TnJDd3ROZzNmemNGOVFLOUJNejlKM3Vwd0hSdEF3ejlKTWRLVjFWYjNZc2tZ?=
 =?utf-8?B?L2wzM2trL2VuajZwZDZ6a21tcnp6SFlPVWE1ME41d2tqSG5tMEg2WEJ5VUtV?=
 =?utf-8?B?MTVDWjF1Z1puNlQ5MnVta1lQUC90QTZRS1FEdCs3UW5yNmlsTUY0R3FjMzQ0?=
 =?utf-8?B?Y2l2VjdjL3JWUFBnRWx2c0lyUVgxbm1ac2g1dXJBbFRadHQ3M3hPYjJ1WGhu?=
 =?utf-8?B?MWxMOFpvY1NrYUFiZlhCcUgrWTdkalErMktZS3NwMWF2OVhqVDNrLys1VEYy?=
 =?utf-8?B?cEdKT2dwZTgrTW9hbGFuTWhFdU55YysvYnM2U0lCNEYxSzFnd0w3YTFrRmRX?=
 =?utf-8?B?OUtLd205RnVVV0M3YW5MT2dhNkNsSnpQSTZFeGVCdnlEcy9SZXptekFZS3dy?=
 =?utf-8?B?aTJQY3RHUmpERnhCTHBvREhJVDZPbWNpYXNKS28yZEFKYTZ6SmtiZksySnFM?=
 =?utf-8?B?OFNiTjJkbHgvdXJyVVNmMXVNcUVDOVV0UkVRS0hkN3F0elBTbWwzckgwNElZ?=
 =?utf-8?B?ZWtER2Rad3BERFF1aXFxRmxmSHpNcU1TRE9GZE1HWnBHdFdxRWwyQmM5d0Rk?=
 =?utf-8?B?TklmOFVodVp5L1ovZ0ZWZ1k2QjRuWnpsL1R0L0VPUzZXVE5lYkRWd29IYzNS?=
 =?utf-8?B?REFxYzA5d3VTUmUvME1rQTQ5VEhQVGRrdkd2cTUzR0pISjlhdXdyQlhEdHR4?=
 =?utf-8?B?RlZSRW5NUWx6NmJUUlNHTi9ITitEamhwSllOVUlCK1hEV3l0M1E4WnlmQ3V0?=
 =?utf-8?B?TWliWVNsalhCYWJEenZIRzNLV09LSGM3T1EyVGtNeE9sb3Rja0d6eHhhZFZD?=
 =?utf-8?B?WUtQOC9kcElFcGJJRjJRMWowUlZzYzRjTkFZdmdHWFd5eVIraTBUdHhKS29x?=
 =?utf-8?B?UEVXWENuWU9vTFJNamdVVW5DQlFxUkVyK0Z5NDJsUnBqUEx6MHkzZlFGSkFY?=
 =?utf-8?B?UVU0OVEvWFhVNGlkZ2d3YVpTNGlUbmtzMGNiZDhTMGxTclMwMTMvSE1qRk5a?=
 =?utf-8?B?RXRkb3htR2tyaFJjVGt0QVlBL240SlZmVUh3V3NiUkVOZzl3aHMvaG5mWFFt?=
 =?utf-8?B?cVc3ZkpxL1FXNjFUZEt5TnR5cm5iWUF6ZmdWMzduRXlKcURtOENvVDJFQzI0?=
 =?utf-8?B?TXhYTjBtbVRQeHRqRUUzS1hJeVZKZ3p1ME92OGJYMGRhdWZ2NGVVRTBPb2g1?=
 =?utf-8?B?eTBKUm1UV0lKcU9hMGwwWWNRYjF3SnRuZU05YnB3MjQ5Z3prRFliRUNOVnY4?=
 =?utf-8?B?cFpwMkNES2JmeW1DbC9lcUNleXJhUVMxdHFlWGlCT05zQWc1bDMyVit1M3hN?=
 =?utf-8?B?ejNjTk15Zk0vY2hpM1dTRjUrckZlVVVUZUYybW13Wi9wTGpjQWFLdXc2TldT?=
 =?utf-8?B?azVJYndDRmRyVEhVZ3oyQm1Lb2h3YlJxL3pDM3NQZmhkK0lTaElPQTEyYWd4?=
 =?utf-8?B?WjZiSWhxdTVpRUgwT0tyZkQ2ZUQrL0hTVUtxcXBJWng3SUlmRWJzeDFDbkRG?=
 =?utf-8?B?cFFEVWtSdkszVjdWV04zR2VqUWZjTk9NT0gya1JobGcxV2dvaUh5Ykx5QU5G?=
 =?utf-8?B?R21uWUpyMHRncHlZOCtJSUpOQlU4OGFpRVp5czNuVERtZkVPOS9ua1k1Wm5a?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5814287B7CA3A3448CAC6A75AF08F0EF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8a64bc-1b5b-42b7-81a4-08da741674d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 23:35:02.4326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zsR8JUPTxJwhdyRKKAHLa30WUZKjN1draiy7zFVDULHWoOY6crSg7xGGkAJgK5jl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4173
X-Proofpoint-GUID: pIFW5Ld7GA4v2qnqRGmoyEfursizwWou
X-Proofpoint-ORIG-GUID: pIFW5Ld7GA4v2qnqRGmoyEfursizwWou
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_12,2022-08-01_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uLCAyMDIyLTA4LTAxIGF0IDE2OjI2IC0wNzAwLCBLdWktRmVuZyBMZWUgd3JvdGU6DQo+
IEFsbG93IGNyZWF0aW5nIGFuIGl0ZXJhdG9yIHRoYXQgbG9vcHMgdGhyb3VnaCByZXNvdXJjZXMg
b2Ygb25lDQo+IHRhc2svdGhyZWFkLg0KPiANCj4gUGVvcGxlIGNvdWxkIG9ubHkgY3JlYXRlIGl0
ZXJhdG9ycyB0byBsb29wIHRocm91Z2ggYWxsIHJlc291cmNlcyBvZg0KPiBmaWxlcywgdm1hLCBh
bmQgdGFza3MgaW4gdGhlIHN5c3RlbSwgZXZlbiB0aG91Z2ggdGhleSB3ZXJlIGludGVyZXN0ZWQN
Cj4gaW4gb25seSB0aGUNCj4gcmVzb3VyY2VzIG9mIGEgc3BlY2lmaWMgdGFzayBvciBwcm9jZXNz
LsKgIFBhc3NpbmcgdGhlIGFkZGludGlvbmFsDQo+IHBhcmFtZXRlcnMsIHBlb3BsZSBjYW4gbm93
IGNyZWF0ZSBhbiBpdGVyYXRvciB0byBnbyB0aHJvdWdoIGFsbA0KPiByZXNvdXJjZXMgb3Igb25s
eSB0aGUgcmVzb3VyY2VzIG9mIGEgdGFzay4NCj4gDQo+IE1ham9yIENoYW5nZXM6DQo+IA0KPiDC
oC0gQWRkIG5ldyBwYXJhbWV0ZXJzIGluIGJwZl9pdGVyX2xpbmtfaW5mbyB0byBpbmRpY2F0ZSB0
byBnbyB0aHJvdWdoDQo+IMKgwqAgYWxsIHRhc2tzIG9yIHRvIGdvIHRocm91Z2ggYSBzcGVjaWZp
YyB0YXNrLg0KPiANCj4gwqAtIENoYW5nZSB0aGUgaW1wbGVtZW50YXRpb25zIG9mIEJQRiBpdGVy
YXRvcnMgb2Ygdm1hLCBmaWxlcywgYW5kDQo+IMKgwqAgdGFza3MgdG8gYWxsb3cgZ29pbmcgdGhy
b3VnaCBvbmx5IHRoZSByZXNvdXJjZXMgb2YgYSBzcGVjaWZpYw0KPiB0YXNrLg0KPiANCj4gwqAt
IFByb3ZpZGUgdGhlIGFyZ3VtZW50cyBvZiBwYXJhbWV0ZXJpemVkIHRhc2sgaXRlcmF0b3JzIGlu
DQo+IMKgwqAgYnBmX2xpbmtfaW5mby4NCg0KVGhlIG1ham9yIGNoYW5nZXMgc2luY2UgdjE6DQog
LSBGaXggdGhlIGlzc3VlIG9mIHRhc2tfc2VxX2dldF9uZXh0KCkgcmV0dXJuaW5nIE5VTEwgZm9y
IGJlaW5nIGNhbGxlZA0KdHdpY2Ugb3IgbW9yZS4NCiAtIFVzZSBwaWRmZCBpbnN0ZWFkIG9mIHBp
ZC90aWQgd2hpbGUga2VlcCB0aGUgJ3R5cGUnLg0KDQoNCj4gDQo+IEt1aS1GZW5nIExlZSAoMyk6
DQo+IMKgIGJwZjogUGFyYW1ldGVyaXplIHRhc2sgaXRlcmF0b3JzLg0KPiDCoCBicGY6IEhhbmRs
ZSBicGZfbGlua19pbmZvIGZvciB0aGUgcGFyYW1ldGVyaXplZCB0YXNrIEJQRiBpdGVyYXRvcnMu
DQo+IMKgIHNlbGZ0ZXN0cy9icGY6IFRlc3QgcGFyYW1ldGVyaXplZCB0YXNrIEJQRiBpdGVyYXRv
cnMuDQo+IA0KPiDCoGluY2x1ZGUvbGludXgvYnBmLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDQgKw0KPiDCoGluY2x1ZGUvdWFwaS9s
aW51eC9icGYuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAg
MjcgKysrKw0KPiDCoGtlcm5lbC9icGYvdGFza19pdGVyLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTAzICsrKysrKysrKystLS0NCj4gwqB0b29scy9p
bmNsdWRlL3VhcGkvbGludXgvYnBmLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKg
IDI3ICsrKysNCj4gwqAuLi4vc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL2JwZl9pdGVyLmPCoMKg
wqDCoMKgwqAgfCAxNDMgKysrKysrKysrKysrKysrLQ0KPiAtLQ0KPiDCoC4uLi9zZWxmdGVzdHMv
YnBmL3Byb2dfdGVzdHMvYnRmX2R1bXAuY8KgwqDCoMKgwqDCoCB8wqDCoCAyICstDQo+IMKgLi4u
L3NlbGZ0ZXN0cy9icGYvcHJvZ3MvYnBmX2l0ZXJfdGFzay5jwqDCoMKgwqDCoMKgIHzCoMKgIDkg
KysNCj4gwqAuLi4vc2VsZnRlc3RzL2JwZi9wcm9ncy9icGZfaXRlcl90YXNrX2ZpbGUuY8KgIHzC
oMKgIDcgKw0KPiDCoC4uLi9zZWxmdGVzdHMvYnBmL3Byb2dzL2JwZl9pdGVyX3Rhc2tfdm1hLmPC
oMKgIHzCoMKgIDYgKy0NCj4gwqA5IGZpbGVzIGNoYW5nZWQsIDI4MiBpbnNlcnRpb25zKCspLCA0
NiBkZWxldGlvbnMoLSkNCj4gDQoNCg==
