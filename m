Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6A74FE64B
	for <lists+bpf@lfdr.de>; Tue, 12 Apr 2022 18:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357832AbiDLQxO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Apr 2022 12:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357948AbiDLQww (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Apr 2022 12:52:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1E35A175
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 09:50:34 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23CF0nMw030138
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 09:50:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=BbMmPBzlUGnKfsHEXH+8MPu00dhth68nnbYgAhGwR0o=;
 b=icsthissxpp39d50Fa/3lyb4eAmIj/XChQeNG1+xeVDIS0xvi7k/sRxB/2/35dNOkpVJ
 Nh/xkvjkwlYr4MxHNwA//jB75FzK12qj5h0mgtIhaLxELPo4leb+d/JpdhpRLXUUqwMv
 1smBcqvSk7yHH09i/klJCjpvKxwdSJ4L/0U= 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2177.outbound.protection.outlook.com [104.47.73.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fdbpj8u91-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 09:50:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHy0QxgL5kmDUZmoN4RuBAPCaOL0+gCgWfM0QKJPs6aqJTgj0t8TENzMQClYEP3oTPTHgo87URNjfoipMgQEyaqjjdgR+qwKh2xnAeJc233dI2sb7Ie1XIKR/7+PSRTPuJbbvgHU9aBLyNJgnBGpOTvCWtVcLUS6jjBjBhPsjwMIk5piOoD3XR/b2oXr6UKThCk2IuXMfAjCUsVC3J/qPYPyK5v+CsUSJDoood7pGkhP7Z09bNHXMgQV4K6s93uuy4bdQhmR+lTujg5Y5SLcJg92r7dk6LVKoT0a7d3kACelcE1PgVecmhvYOS+oNbngc2kdmZvD3N0uTCt+k8ezcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbMmPBzlUGnKfsHEXH+8MPu00dhth68nnbYgAhGwR0o=;
 b=gGBc6LEv5JYfC+QH3Q3VRPyBVuki6UygxOze6QVbzqKY5MdRr3PhhZLgeSmblFnWhxeLSA0L02oZv0K9CdLIvV+KCpFHJ3lTZ/hhJYgNz7rb7J/ddmf+HrqWcn8qOjz1y1F7tFqYRBbUd66spPZJ4Pz64oJeJx2kWOx6HtoSkypQ8EOJ9xkegIvZ3KKyEu6a9Y+28FMlXeiB/gpiR3eWNT0wnlobf6l8RxQzQahFPOPYz2bW6GVqraVkubI/MwtDBpPHWZvBykF5qpsDy7aVppuAaZoMe2PKTqAKoa3XULlmcpLMFioV0sYeYAmFTHIZAcN6SZYGXJh2ukRfgtC9BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by MW2PR1501MB2092.namprd15.prod.outlook.com (2603:10b6:302:5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 16:50:32 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::20d5:ab50:fdf7:2a9a]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::20d5:ab50:fdf7:2a9a%6]) with mapi id 15.20.5144.027; Tue, 12 Apr 2022
 16:50:32 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 3/4] bpf, x86: Support BPF cookie for
 fentry/fexit/fmod_ret.
Thread-Topic: [PATCH bpf-next v2 3/4] bpf, x86: Support BPF cookie for
 fentry/fexit/fmod_ret.
Thread-Index: AQHYOM8IO1xa8/UtYkS3jv5jd0HQ6KzFhuUAgAT9CYCAAAOwgIAiIZuA
Date:   Tue, 12 Apr 2022 16:50:32 +0000
Message-ID: <f3d41f4b31a08d0fac955947f8ed59d1b1bbcd4d.camel@fb.com>
References: <20220316004231.1103318-1-kuifeng@fb.com>
         <20220316004231.1103318-4-kuifeng@fb.com>
         <20220318191332.7qsztafrjyu7bjtc@ast-mbp>
         <CAEf4BzZF02Jn3PP8LJ7oF55ogPOePt0Wt8+Dtmj5fN0r7PfU0w@mail.gmail.com>
         <CAEf4Bzb4d-BT9kVPCAPHmh2nZztx9q+GT4O6ap=HKKNUA3kmKw@mail.gmail.com>
In-Reply-To: <CAEf4Bzb4d-BT9kVPCAPHmh2nZztx9q+GT4O6ap=HKKNUA3kmKw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 494ded3a-b70b-4ebe-c649-08da1ca48ec9
x-ms-traffictypediagnostic: MW2PR1501MB2092:EE_
x-microsoft-antispam-prvs: <MW2PR1501MB209242C1F5E92056A8673F5ECCED9@MW2PR1501MB2092.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9EaK3q4ellJP6sKg2arrMuQM6bJVnhBPOmUZGP0aLCicUkFwDpush6bTqV/MCryZ9l2Tklc835xKlrBE6ihYGZ1zbSKz+s0KVQ8sj7k83SaHYYnDr6tD36L8eQJCnvp5bZRvb3+MCD2lO19tEAhbXyhoJUCfAW9KboMhgoHJaxEaT5/7NQLBWgm3Mib6pP0bauvZ0IoGxGBnmVdUj6u+HGGDRh0wiAAXXJ9nldZyQnmv7z8UvjEapBQEx9oGScvRdpvT/scdjVdlHqrgUtsNqYeY1SvTI4D/yYcXxKJn5xobp1ZfRmUIpBklredjzxokMYzurpghSUkPe7juqPfsqYyhEGyCh8wCU+iz0QVKuYAA6XgZKxk8ndzpkXJ9I58NkhUfs7Ug6wx55RFDt+xME3e3ssntOkWb/22R+pM+T7hVtZqt4HODFlSFJfUuZyn11g9YVCjgNoo+jAKkp7vKL/UxCfZ3zmTcGjTxfQIy2BS0l0JBaX1AavU5ymyTa9tWjcvQjIaVDiJcVesa7KVOJRBE0/FUzAr4zITknc8FGF+FX/JkuHpNKvyZC26D/fDZwhMoIf/hfAWEJzI3sflayoYaTrI4jtRyiMEGBz3cd5cZYv4XAPCClKve8NcWtTLRHg7m53j6gWljSzV/pppchMl8WncdYLsEhtMOLmC9tZUrQJzORm3zRVqptxmwNTa9UNW+Jjjbt/fEyHuBjfRO8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(83380400001)(86362001)(38070700005)(8676002)(71200400001)(2906002)(8936002)(36756003)(186003)(6512007)(6506007)(53546011)(508600001)(6486002)(5660300002)(66946007)(76116006)(4326008)(66446008)(91956017)(122000001)(316002)(38100700002)(66556008)(64756008)(54906003)(110136005)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eC9KODFweGZFdHdOc1pIOWpndm1iSGphOEFmNU5RUFgyaDE1NW94M29Pbmd2?=
 =?utf-8?B?UnVFcTJJQko4RmhWNFk1RGk5cURSNjJEdi9kOENxTFBZMy94dFNzejloS04w?=
 =?utf-8?B?L0VlbWYvQ1c4UldvZ3llSWUwOUM0bGlXOHYyRkhlbTNVY0plU1FnWGEvWlpW?=
 =?utf-8?B?NjZaUHVnTnZFVE1aYitsbThTdm4wTkl0OTJQOUY0czRLRnFwQ21MK0dTSUVw?=
 =?utf-8?B?bXNaZFdMd1pyN1pCYVR0cmRXblpGU2owTzd6WVh0S3hpWkVvcXg5Wk9JVWh1?=
 =?utf-8?B?WnU3ZSsvaUU3K0Z6eXN0TWp1cWthaElNMHBreUJkUTVqaURsYlQ4L0krbVNT?=
 =?utf-8?B?U1lCSk83NmpYQzYwdWlhK3pNcHdkQzRTNlNKaWZMOVJPalp3eCszM0s0SUlx?=
 =?utf-8?B?TTN4a0lXdHQ5anBhRGRqQ1NqeHlrTWVaTjZYZEx6Z0owRGlBYnFTNnI4V3JM?=
 =?utf-8?B?OXhXQVo4OENnNlI1eEJUL09jZnBGTFdHYXV6NkU3eU1EOHVqV2JpUmVkR2hZ?=
 =?utf-8?B?NCtsWThjNXREMkwvWU9MRzA5cklKSmE1b1llZ0JVVkVuTThQYVRyLzVLSkty?=
 =?utf-8?B?VWFhR1dkNUdYdWFxRUpHdndRWEorR1R4VWZSYS9uUWhNVmtseGwyWGg3TWVo?=
 =?utf-8?B?MnRyUi9zWit6K2cwRTc0Y2k5b3ZWQXdwOE12ZXBpWjV3VTY3ajZQYjZYYkxJ?=
 =?utf-8?B?RVVXV1o5aEJvY1B5Z0NOZVZPRFErK09NOFVGcWt0Z0xFNEpEUXpMRWpOOHpR?=
 =?utf-8?B?N2ZjVm5oOFFSL2xqQ2RDYmtidyt4YTdDYzEwRm50MkZPd09mQWFWSngwd0tI?=
 =?utf-8?B?SjdHclA1WWtuaVVVZGNpazZXMzFlWlNPVldqOFE5TkZlV3NlRFRWSkU0WWJY?=
 =?utf-8?B?TkxXQTdRMnBMZUZaelRVSlFlL3IrYmxRR2JSVUYyQzlERjFieEdSMko0Nk4v?=
 =?utf-8?B?elB4U1VZVTFiaEFoZXZzcHRaSm0vZHYwaWh4NDV2TTY4c3o4UjdHV3d4M3FP?=
 =?utf-8?B?WE1JbnJNamR6NE9ENTIxeHY0bFkycEpLK3FuR2hUNHVDNHh2OG02VUhuYVFZ?=
 =?utf-8?B?QU81SXl3cWZPeXN2WWhGZlhhMmVTV2VPeCt1S2hmK2lvYnFtenQzUy85RU5B?=
 =?utf-8?B?MmNjNlk0YkVGcHhZbi92UGRab1FaY3B3bzVWeE1FM3N6YW1CV1dxclhkelg1?=
 =?utf-8?B?UVJZaGdPMGprcTU3OXgrT21uTkVINGs3RTZGQ2lXSFdlak04aWlyZTFpdTBS?=
 =?utf-8?B?MERRTkk2dWF2YzJlTTgxSXc5WUhmWFBhNGU1ZnpUN0FQcjRFd3czYjhwK0Fv?=
 =?utf-8?B?R2VKZEZkdzllcGszVTk5OXlkaFZvNlIwK1kxTGxSZ2xOSmMzbytzODU3bDRN?=
 =?utf-8?B?aWxsaVFYRjBBaWV3d0lQNTEvZEpwZUJCdDNRTk1oa3pDK25vTUc5VDdsRkJt?=
 =?utf-8?B?dlQxUXV1NnZOaXlXOC92WFIwdUJDeFNJWFRSb3JiNnpzWTcyU0dmeVZsNzdw?=
 =?utf-8?B?cHNIemRPY1VlOUEwUFcraGE0aWZBakY0T0xJQ09WcHZmSWRFcSt3bzVBb0l3?=
 =?utf-8?B?ZlpmT2xhcnVNVFpsQ2c4TkpKdWpaeS9qblNScWtYU1VGMXpXK2hZdk5YQlNM?=
 =?utf-8?B?R3pDSllkVUVmSnozYVp1aWtiSUZYVzZsL1hhOTZvb3Y2OFZBTnltUkViOHN6?=
 =?utf-8?B?UmdKWmNSK1FWS2JoekwzcVpkejJMZ3hPajEremFPNCtaemNNYU9sVWZaN1Ns?=
 =?utf-8?B?dEZEM0YwZSt4dkgvV3RsUTJtajkwYkgwU2RwUWdNaWxQNDArR1dmOGE5L0FB?=
 =?utf-8?B?YVdURlJnWnFzc0swaXpXdDZORzd5Y1dDeDAvK1Q2TkJXY09jZXN4NVh2V2ZN?=
 =?utf-8?B?VHc1SzVvcnhhNVU1TGNCaGpXVEhGZk5UTHpweDd2YTdOaU5EY3hzSUcrRTN5?=
 =?utf-8?B?bkZYbk9JdW8yb0VHSnNwcTRyNWhGYVVHWWdkbS9UU3dQMzdSOGhIVHF4eW4r?=
 =?utf-8?B?VjRBcFVXanYwVlZkaWtFTVdUZ1N1QVhhVFllZmE0cG1QWUVRRFg0clV3NW9K?=
 =?utf-8?B?cEYzT29pUkZRSi9JMUFFRnp2SWkrc1VwUGQ5S3Nya1hhaFFqRnBIWTZnK0lG?=
 =?utf-8?B?OGo1QkxjWHlqcTFXazNHUVYvYnROQW1DSGI5L3d5ZVVtTnZxM3JiTXJySWVO?=
 =?utf-8?B?bC9zdlZWUHBGVU0xakhOUE83RENUU1NxdVV5UEpqL2lKTHNOK1A1cURrY3p0?=
 =?utf-8?B?c3hBNUw3LzZSTU4wMndYUVNtOWtFVVNOZ3ZybWxuZDZZZ2dsZndOMm1QaE02?=
 =?utf-8?B?cVBCVDRybG1zdlNBc0RubXNWWk5PYm1IRzY2SXkvUUZsQkFmM3VKQTdlQURN?=
 =?utf-8?Q?2duB/O4av9GU0cgM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79F57DC1DEF9B144BC42097235ED2514@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 494ded3a-b70b-4ebe-c649-08da1ca48ec9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 16:50:32.1211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lHSt2oMpWNcX43nWG21UuvyRS6t+d9FjF0mvixF9GymZ/+SHwDayOFi+2ixU1NMh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR1501MB2092
X-Proofpoint-ORIG-GUID: X_YHvdune4g-bVOytEv2O24Xpsf3nUL-
X-Proofpoint-GUID: X_YHvdune4g-bVOytEv2O24Xpsf3nUL-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-12_06,2022-04-12_02,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uLCAyMDIyLTAzLTIxIGF0IDE2OjM3IC0wNzAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
DQo+IE9uIE1vbiwgTWFyIDIxLCAyMDIyIGF0IDQ6MjQgUE0gQW5kcmlpIE5ha3J5aWtvDQo+IDxh
bmRyaWkubmFrcnlpa29AZ21haWwuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBGcmksIE1hciAx
OCwgMjAyMiBhdCAxMjoxMyBQTSBBbGV4ZWkgU3Rhcm92b2l0b3YNCj4gPiA8YWxleGVpLnN0YXJv
dm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gPiANCj4gPiA+IE9uIFR1ZSwgTWFyIDE1LCAy
MDIyIGF0IDA1OjQyOjMwUE0gLTA3MDAsIEt1aS1GZW5nIExlZSB3cm90ZToNCj4gPiA+ID4gQWRk
IGEgYnBmX2Nvb2tpZSBmaWVsZCB0byBhdHRhY2ggYSBjb29raWUgdG8gYW4gaW5zdGFuY2Ugb2YN
Cj4gPiA+ID4gc3RydWN0DQo+ID4gPiA+IGJwZl9saW5rLsKgIFRoZSBjb29raWUgb2YgYSBicGZf
bGluayB3aWxsIGJlIGluc3RhbGxlZCB3aGVuDQo+ID4gPiA+IGNhbGxpbmcgdGhlDQo+ID4gPiA+
IGFzc29jaWF0ZWQgcHJvZ3JhbSB0byBtYWtlIGl0IGF2YWlsYWJsZSB0byB0aGUgcHJvZ3JhbS4N
Cj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEt1aS1GZW5nIExlZSA8a3VpZmVuZ0Bm
Yi5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiDCoGFyY2gveDg2L25ldC9icGZfaml0X2NvbXAu
Y8KgwqDCoCB8wqAgNCArKy0tDQo+ID4gPiA+IMKgaW5jbHVkZS9saW51eC9icGYuaMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgIDEgKw0KPiA+ID4gPiDCoGluY2x1ZGUvdWFwaS9saW51eC9icGYu
aMKgwqDCoMKgwqDCoCB8wqAgMSArDQo+ID4gPiA+IMKga2VybmVsL2JwZi9zeXNjYWxsLmPCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8IDExICsrKysrKystLS0tDQo+ID4gPiA+IMKga2VybmVsL3RyYWNl
L2JwZl90cmFjZS5jwqDCoMKgwqDCoMKgIHwgMTcgKysrKysrKysrKysrKysrKysNCj4gPiA+ID4g
wqB0b29scy9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmggfMKgIDEgKw0KPiA+ID4gPiDCoHRvb2xz
L2xpYi9icGYvYnBmLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTQgKysrKysrKysrKysrKysN
Cj4gPiA+ID4gwqB0b29scy9saWIvYnBmL2JwZi5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAg
MSArDQo+ID4gPiA+IMKgdG9vbHMvbGliL2JwZi9saWJicGYubWFwwqDCoMKgwqDCoMKgIHzCoCAx
ICsNCj4gPiA+ID4gwqA5IGZpbGVzIGNoYW5nZWQsIDQ1IGluc2VydGlvbnMoKyksIDYgZGVsZXRp
b25zKC0pDQo+ID4gPiANCj4gPiA+IHBsZWFzZSBzcGxpdCBrZXJuZWwgYW5kIGxpYmJwZiBjaGFu
Z2VzIGludG8gdHdvIGRpZmZlcmVudA0KPiA+ID4gcGF0Y2hlcy4NCj4gPiA+IA0KPiA+IA0KPiA+
ICsxDQo+ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS90b29scy9saWIvYnBmL2JwZi5jIGIvdG9v
bHMvbGliL2JwZi9icGYuYw0KPiA+ID4gPiBpbmRleCBmNjljZTNhMDEzODUuLmRiYmYwOWM4NGMy
MSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvdG9vbHMvbGliL2JwZi9icGYuYw0KPiA+ID4gPiArKysg
Yi90b29scy9saWIvYnBmL2JwZi5jDQo+ID4gPiA+IEBAIC0xMTMzLDYgKzExMzMsMjAgQEAgaW50
IGJwZl9yYXdfdHJhY2Vwb2ludF9vcGVuKGNvbnN0IGNoYXINCj4gPiA+ID4gKm5hbWUsIGludCBw
cm9nX2ZkKQ0KPiA+ID4gPiDCoMKgwqDCoMKgIHJldHVybiBsaWJicGZfZXJyX2Vycm5vKGZkKTsN
Cj4gPiA+ID4gwqB9DQo+ID4gPiA+IA0KPiA+ID4gPiAraW50IGJwZl9yYXdfdHJhY2Vwb2ludF9j
b29raWVfb3Blbihjb25zdCBjaGFyICpuYW1lLCBpbnQNCj4gPiA+ID4gcHJvZ19mZCwgX191NjQg
YnBmX2Nvb2tpZSkNCj4gPiA+IA0KPiA+ID4gbGV0cyBpbnRyb2R1Y2Ugb3B0cyBzdHlsZSB0byBy
YXdfdHBfb3BlbiBpbnN0ZWFkLg0KPiA+IA0KPiA+IEkgcmVtZW1iZXIgSSBicm91Z2h0IHRoaXMg
dXAgZWFybGllciwgYnV0IEkgZm9yZ290IHRoZSBvdXRjb21lLg0KPiA+IFdoYXQNCj4gPiBpZiBk
b24ndCB0b3VjaCBCUEZfUkFXX1RSQUNFUE9JTlRfT1BFTiBhbmQgaW5zdGVhZCBhbGxvdyB0byBj
cmVhdGUNCj4gPiBhbGwNCj4gPiB0aGUgc2FtZSBsaW5rcyB0aHJvdWdoIG1vcmUgdW5pdmVyc2Fs
IEJQRl9MSU5LX0NSRUFURSBjb21tYW5kLiBBbmQNCj4gPiBvbmx5IHRoZXJlIHdlIGFkZCBicGZf
Y29va2llPyBUaGVyZSBhcmUgZmV3IGFkdmFudGFnZXM6DQo+ID4gDQo+ID4gMS4gV2UgY2FuIHNl
cGFyYXRlIHJhd190cmFjZXBvaW50IGFuZCB0cmFtcG9saW5lLWJhc2VkIHByb2dyYW1zDQo+ID4g
bW9yZQ0KPiA+IGNsZWFubHkgaW4gVUFQSSAoaXQgd2lsbCBiZSB0d28gc2VwYXJhdGUgc3RydWN0
czoNCj4gPiBsaW5rX2NyZWF0ZS5yYXdfdHANCj4gPiB3aXRoIHJhdyB0cmFjZXBvaW50IG5hbWUg
dnMgbGlua19jcmVhdGUudHJhbXBvbGluZSwgb3Igd2hhdGV2ZXIgdGhlDQo+ID4gbmFtZSwgd2l0
aCBjb29raWUgYW5kIHN0dWZmKS4gUmVtZW1iZXIgdGhhdCByYXdfdHAgd29uJ3Qgc3VwcG9ydA0K
PiA+IGJwZl9jb29raWUgZm9yIG5vdywgc28gaXQgd291bGQgYmUgYW5vdGhlciBhZHZhbnRhZ2Ug
bm90IHRvIHByb21pc2UNCj4gPiBjb29raWUgaW4gVUFQSS4NCj4gPiANCj4gPiAyLiBsaWJicGYg
Y2FuIGJlIHNtYXJ0IGVub3VnaCB0byBwaWNrIGVpdGhlciBSQVdfVFJBQ0VQT0lOVF9PUEVODQo+
ID4gKGFuZA0KPiA+IHJlamVjdCBpdCBpZiBicGZfY29va2llIGlzIG5vbi16ZXJvKSBvciBCUEZf
TElOS19DUkVBVEUsIGRlcGVuZGluZw0KPiA+IG9uDQo+ID4ga2VybmVsIHN1cHBvcnQuIFNvIHVz
ZXJzIHdvdWxkIG5lZWQgdG8gb25seSB1c2UgYnBmX2xpbmtfY3JlYXRlKCkNCj4gPiBtb3Zpbmcg
Zm9yd2FyZCB3aXRoIGFsbCB0aGUgYmFja3dhcmRzIGNvbXBhdGliaWxpdHkgcHJlc2VydmVkLg0K
PiA+IA0KPiA+IA0KPiANCj4gT2gsIGFuZCB3ZSBuZWVkIGJwZl9wcm9ncmFtX19hdHRhY2hfdHJh
Y2Vfb3B0cygpIGFzIHdlbGwgKHJlZ2FyZGxlc3MNCj4gb2Ygd2hldGhlciBpdCBpcyBCUEZfUkFX
X1RSQUNFUE9JTlRfT1BFTiBvciBCUEZfTElOS19DUkVBVEUpLg0KPiANCj4gPiANCkkgcmVtb3Zl
ZCByYXdfdHBfb3Blbl9vcHRzKCkgc2luY2UgcmF3X3RwIHdvbid0IHN1cHBvcnQgYnBmX2Nvb2tp
ZS4NCkltcGxlbWVudGVkIG9ubHkgYnBmX3Byb2dyYW1fX2F0dGFjaF90cmFjZV9vcHRzKCkuDQoN
Cg==
