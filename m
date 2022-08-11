Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8041C58F53B
	for <lists+bpf@lfdr.de>; Thu, 11 Aug 2022 02:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiHKA1Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 20:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiHKA1O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 20:27:14 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630FA8FD5E
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 17:27:14 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27AGuUN0024481
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 17:27:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=0TuEeS+T/2LImagP+AWdMuISKfaVWHkn1Hj0ZHbs5XU=;
 b=fQHaC5A/WSIQBH5Mu66OySJRlyGrUUK111PT5HJ7inDUyf6uXeTI08XpVln5usPzakO9
 ExKz38pDnxxx6OFh/n4Wg9vNeusJTX3LhV4LhbBPBmcOP9YZqUWLn+aiVne18N+BExE/
 oOVVViPXL1LL2X9eLCLKDtzwoL7udNr/Uro= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hvdb1d9ad-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 17:27:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bnq0mTA/rcA+K4P9VKMa0htH6GulO5x4DH/bYOTSYxa3JzsCdwV2SSrQZQpzAdgBwboKBEfnOZMt3o7BBjAx9GVVeJn4Fk7EjUIWEcovTje3KwtwiDWT3nBoUC5p5CmsdqCM1AHvZ3CKyBtiOl6SsEl2solpJoMBmjj4olAaGKAkWzCg9zbIiA7oA13UjIpHMgTdYmOYIS7yB9iDH+tJoxN5QXIhpNIJi0WSgkCYYNcQ7ZB2j9DOXXXoPyHbOpPgd5qxow9mIKrEowyQnow0j7NRKS/qtmmBt/24QvXSaJMYx1oMZbKJ0HHOn5oc7o6MA69CzNCUAeCUAjT1GJFacQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TuEeS+T/2LImagP+AWdMuISKfaVWHkn1Hj0ZHbs5XU=;
 b=JkbO+H33IJ3y9n97ar2fv60TM0MO/9L3vavHyV2L4MmOehItd4StEC897sYKLY0yfByS1rIz1YNuRF5jwPNNfMGTnvoqB7THwNw3lrbc8F48JbciDfKhwpAs1nqiRNbvnoIHMpp41R0qoNrpEam+cHSi5L76s4KaXONL3yVosNRsUzdT0Yxw4fpMilzRntGyQAmBIerkdwLjkzAHDz5zKhyIdsBNC7tQuj+9PdFDnfNFjaXseFZimx3U9PBpOHKRqZ83qJu+x2++rzEUZUl1UKp+frh/mURXTDiaZoKr23Ms39DPd4g513cwlypXkhWxkJKR8NO/L4ZGZqX31gnIuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from PH0PR15MB5262.namprd15.prod.outlook.com (2603:10b6:510:14d::6)
 by BN8PR15MB2948.namprd15.prod.outlook.com (2603:10b6:408:84::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Thu, 11 Aug
 2022 00:27:09 +0000
Received: from PH0PR15MB5262.namprd15.prod.outlook.com
 ([fe80::84f7:68ec:470e:288b]) by PH0PR15MB5262.namprd15.prod.outlook.com
 ([fe80::84f7:68ec:470e:288b%7]) with mapi id 15.20.5525.011; Thu, 11 Aug 2022
 00:27:09 +0000
From:   Mykola Lysenko <mykolal@fb.com>
To:     =?utf-8?B?RGFuaWVsIE3DvGxsZXI=?= <deso@posteo.net>
CC:     Mykola Lysenko <mykolal@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf] selftests/bpf: Add lru_bug to s390x deny list
Thread-Topic: [PATCH bpf] selftests/bpf: Add lru_bug to s390x deny list
Thread-Index: AQHYrPTLH7B5vXvhKkSte+ifayZGwK2o2EQA
Date:   Thu, 11 Aug 2022 00:27:09 +0000
Message-ID: <4BFA8A8F-DED2-4AC6-BAE7-F9E0693F0B53@fb.com>
References: <20220810200710.1300299-1-deso@posteo.net>
In-Reply-To: <20220810200710.1300299-1-deso@posteo.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54560575-2a11-4bac-94db-08da7b303a64
x-ms-traffictypediagnostic: BN8PR15MB2948:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w+o386xCJxuDINFMbMdkTJezaNhoaWY3U8JFW5/8wvPivalt/O+c4UoD+rV8mNLK5JSVeukgG//xnJaBqg7kA0IOIBppIKY0WCsrANF6ziDoVshPtO78H3dXnNGGQgrHAJdg1p4UHeZwbl+NSVdxHwVDyDpv2y5sMD2YgJs4xc2jaZBNqtjEP9Bw9MnU6Gl/GdC7hu1d+qNOzf6l3Y4wccBfHZz6Y28vYhp4fXN4223jK1eFx3l7/fV6hLJUgJncL5SLCLRuJ/ePWaWNvuec+RkGYi38jazmtq9Stbo1qJBWGIh60jn+ZG/SvvprljJZtJHgLzoSK+BXrGgIoC4eAYGJnESfRj1/RijataNNtJJ6COhiPoizLgKaW4uQaoYLpGnCZQHxU0qSEFOcLPxro65j5Jnt7s3CabPq6SSgtwWM0Tq14UVXL+OsGMA69460F+B85CwgYUPaQoQF9e/cqOtu48EY9xDdfj70zOtTJoZ94hZYcsrn6ebIqewhZ9hFP7i9mVhkuKlI4j7v4xGwpRd7UuED9JWvkdcFC7PCdDi3CBCAxv48xTfgJSk8/KbxGTZ6xSwF0X9qI9s7Nzkw0IK/9pZjH6ma8VS/bajfokSsi17nSZ1pitmStG//qbuNjUnpj/7jHqrWIIedPuVBUPOChuyvK1gznkOybgDHAkP5I0PQ97cvl0BwAKGncXAdKFK9JVuunAkVSNCnwIwTqDPf/XQekiPtv0LoGXQ46cuItn1kq6FnZNr31uX3mjmKTipRhNLWQudGtkjBMAgDPOgv8bFQqfY6a41DCewb02r5RBgkYxma+ZiY7vM1L7lmm7hLuAOQXA3R7q4hoC4+gSp/f3DxFQ62PEOIgsjrsYcR0Ye9pQPVF5fOBlU/TRkn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5262.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(71200400001)(83380400001)(54906003)(76116006)(316002)(6916009)(66446008)(36756003)(66556008)(66946007)(8676002)(64756008)(91956017)(4326008)(478600001)(86362001)(966005)(8936002)(5660300002)(66476007)(2616005)(6486002)(33656002)(2906002)(38100700002)(41300700001)(6506007)(53546011)(38070700005)(122000001)(6512007)(186003)(66574015)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFNmSG12U0F4b1gxY1hENE0wbzQyUkh2SHVIZkpYdmVkL0lkSDRObVJLZjcr?=
 =?utf-8?B?eXJzZFVqWUhZZmtxSXQxckJyUmNvcktST1o1TGxvdkRaVG9UcHlSVVhnNFJi?=
 =?utf-8?B?ZXdBK2hCbGVPMTlyUE1peDNUZDdOQ2d4eWc2a3QyVWpwMms5ZjlJSUpSUnEv?=
 =?utf-8?B?Z1BSbWVzWHArbHZyRis5VG1pUkdWOU5GeWlZODg0RlVsamxwbzhtTUc3TXNx?=
 =?utf-8?B?VFZ1RzJlYXp1VWY0OGt0VURDWjc5VjVtUlc4YUFpTFU2RDYvOXd1d1R3QnRS?=
 =?utf-8?B?YzViQ2hlZGRmU2hZbjk5MW8wZG1UcmM5TU44YUZvM2pYb1J1alUrY1VXVloz?=
 =?utf-8?B?VHVTZjJaN0Y0WEo1bmhFTVFNSFZjeDdUNXNNb2dJb2NWU1NPVWRJM1ZvTWcz?=
 =?utf-8?B?ekNNNDNwV2JZand4MWt3cmdvZEljSHlMajY5bGUvVUFnbHRDVDJ2Q2dodHB1?=
 =?utf-8?B?bmRUOTNWUk9Xdm9Xc3BLb0JJbFNXbjBNV0tFNzZWdUgzVE01WWZLd2N4S1R4?=
 =?utf-8?B?djdSVzlraGZucTFVbEw1UkEydGxQR0JUa3R1UmRNNjFaVG1tdnIrdUsxeWNZ?=
 =?utf-8?B?ZjNud1dDQ3FQZGdhV2FVZmMyK21uSFc3aXZlYklPVm5KUHlPM045Z1N0bFEw?=
 =?utf-8?B?RW05c1FVc0t5SjRiVDg4UHIxRU83N3NMbjhtaEl4ZHlBN0p0TGNnSU45QWhI?=
 =?utf-8?B?WFVaM2g5b0E5b3ZkamxuN3crRCsrMFk0cDl1OWtmVFB0TWVtWFh5azNDbnFq?=
 =?utf-8?B?dFkySmhVUEgyK1Fia2QzaFcwU2pQWkdKNHgxOWRmNW9IRnQxQXNNTTVWVVkw?=
 =?utf-8?B?bEZEVHZ6aFlmckpDNE9SQXg0RXRTK3J3NzY4ZERRbnhZUHpJejE4Z1drc1F4?=
 =?utf-8?B?SkU2bG5zZXJQT0pMZWwxYldOT0hIbVpDK0VJZkxqempPaldGb2Zvd3FMZXlu?=
 =?utf-8?B?T3R0bWNLazQwMXBnbyt3TGl1WmNJaW8wZElKdjhzdWpiMSs5clF0MlA1cERO?=
 =?utf-8?B?YTZGc1FCU1dGamFSeHo3dW5vZCtWQkFzS1poZ2NBSjE3SmdWTnQyMC85R241?=
 =?utf-8?B?U3VjM05FNGhXVWVkQlhmQUF4dDMvd2Fzby9GeFRrMTVDRUFMZGEzZnJUb0E2?=
 =?utf-8?B?NGtCckphbjBlSFlDMVdxQzlLZmFvOENDUkZUWjR5UzZpYkJoQkFsNVgwNG81?=
 =?utf-8?B?UmZxdDJsMEZvRTdpOXg0RFo0WmhxcHdGR2U5bWh4aWpxTHpueTJEdFFiZHF2?=
 =?utf-8?B?TEZQalFJd2NKci9RSkh3eEpLQW4zbUgzclVESDR2NGdkajVGOXJZQlYyWEJR?=
 =?utf-8?B?Q2VSMHlCZnB2ajlRc3ExdlRNR1hmZi8wajBlOWREanEzQzNWS2dQTGswbmd1?=
 =?utf-8?B?anJ0cGN2VThHSnIvSDhGT0ZUTkJFdmRySENrQ3RXU0JMV1FrSU4xR1JCaWxR?=
 =?utf-8?B?T090akI5U2pqTW5pZ1JCTG1IbnlLRmRXZzFYWFlqQi9rTjFnV2dsektlOUxu?=
 =?utf-8?B?cCtLTGpycVJjZU5EVGh6a3hUVlBFcnQrYS9kZzVxdnhjWDh6ZGhpdkJ4TnRo?=
 =?utf-8?B?cHhwdWg5ZVRSSEM1SDl0aE9uZHJyZkhIam9YRm9iZ0NjejExUkNVRlU0dy9K?=
 =?utf-8?B?RnVKKzBEYWdCMUtieUtidzRJSng3SEJEZTU3QndPQ0QzdjhiZEVYeHJpTHlE?=
 =?utf-8?B?akQrTm9sS290eVJnWTNBQndzM1E3MEJEUnpqd1lUZHpCZjVhb29WWUdHWHlO?=
 =?utf-8?B?cVMvby9lWXgrcjNKVHZKaEVEdHV6UUpvdUFDRXhzU1dxRUk4ZDNWMUUwY2w3?=
 =?utf-8?B?UDBoa3pwM3VRVDlaK1p1bTZMZDBJbE94Q0dmSUV4U1NJQ0xaYldXNjJzK1RO?=
 =?utf-8?B?Y2dMR2JQWlFrS2Z4NXpJdk5MVGRtSTFqNDNXc1V5S1cxUklVQmVXbzJ4bXBn?=
 =?utf-8?B?THZTSmNYa3k4cWRjSWluZEJhMW00azRxcjhNdGgwQWs5dk55bEo4QVQ5ekta?=
 =?utf-8?B?QjFqOVUxaFNDZ1pTbW43Qk82WlZJT1JvSks5RTFYMVprYVR1UG5PN3JCYk9O?=
 =?utf-8?B?aHdYd1c0K1doME1mWnZ1bVI5THNEMTgxV3pRcEJCTkZFZWxqaEUxL3VTR0JX?=
 =?utf-8?B?R2ZqZmlCcTNaNkt6ajY0U0dvbXZuOG9yd0hTdDRmTWNlQU9sQlpzd2kyL3RR?=
 =?utf-8?Q?W1ZZKNGOErA2dlHP/TXVB3g/HYrbTaIxxP25rf68jFTL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E6A9A1AC752FC49B2B54EC0E96C31CB@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB5262.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54560575-2a11-4bac-94db-08da7b303a64
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2022 00:27:09.4507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 83c9zpFfI+w37rOBTHBlN3mMUAV9/yZhy20qc/Ony3gMhCEOMtq0mEUAJDPGrZmt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2948
X-Proofpoint-GUID: pgNwmKZ1o-Q1XuH_keT0Hco2di5cDiKw
X-Proofpoint-ORIG-GUID: pgNwmKZ1o-Q1XuH_keT0Hco2di5cDiKw
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_16,2022-08-10_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

VGhhbmtzIERhbmllbCBmb3IgZml4aW5nIHRoaXMgcXVpY2tseS4gSXQgc2hvdWxkIHJlY292ZXI6
IGh0dHBzOi8vZ2l0aHViLmNvbS9rZXJuZWwtcGF0Y2hlcy9icGYvcnVucy83NzcyMzA1MDExP2No
ZWNrX3N1aXRlX2ZvY3VzPXRydWUNCg0KQWNrZWQtYnk6IE15a29sYSBMeXNlbmtvIDxteWtvbGFs
QGZiLmNvbT4NCg0KPiBPbiBBdWcgMTAsIDIwMjIsIGF0IDE6MDcgUE0sIERhbmllbCBNw7xsbGVy
IDxkZXNvQHBvc3Rlby5uZXQ+IHdyb3RlOg0KPiANCj4gVGhlIGxydV9idWcgQlBGIHNlbGZ0ZXN0
IGlzIGZhaWxpbmcgZXhlY3V0aW9uIG9uIHMzOTB4IG1hY2hpbmVzLiBUaGUNCj4gZmFpbHVyZSBp
cyBkdWUgdG8gcHJvZ3JhbSBhdHRhY2htZW50IGZhaWxpbmcgaW4gdHVybiwgc2ltaWxhciB0byBh
IGJ1bmNoDQo+IG9mIG90aGVyIHRlc3RzLiBUaG9zZSBvdGhlciB0ZXN0cyBoYXZlIGFscmVhZHkg
YmVlbiBkZW55LWxpc3RlZCBhbmQgd2l0aA0KPiB0aGlzIGNoYW5nZSB3ZSBkbyB0aGUgc2FtZSBm
b3IgdGhlIGxydV9idWcgdGVzdCwgYWRkaW5nIGl0IHRvIHRoZQ0KPiBjb3JyZXNwb25kaW5nIGZp
bGUuDQo+IA0KPiBGaXhlczogZGU3Yjk5MjcxMDViICgic2VsZnRlc3RzL2JwZjogQWRkIHRlc3Qg
Zm9yIHByZWFsbG9jX2xydV9wb3AgYnVnIikNCj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIE3DvGxs
ZXIgPGRlc29AcG9zdGVvLm5ldD4NCj4gLS0tDQo+IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Jw
Zi9ERU5ZTElTVC5zMzkweCB8IDEgKw0KPiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvREVOWUxJU1Qu
czM5MHggYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvREVOWUxJU1QuczM5MHgNCj4gaW5k
ZXggZTMzY2FiLi5kYjk4MTAgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2JwZi9ERU5ZTElTVC5zMzkweA0KPiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYv
REVOWUxJU1QuczM5MHgNCj4gQEAgLTY1LDMgKzY1LDQgQEAgc2VuZF9zaWduYWwgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAjIGludGVybWl0dGVudGx5IGZhaWxzIHRvIHJlY2VpdmUgc2ln
bmENCj4gc2VsZWN0X3JldXNlcG9ydCAgICAgICAgICAgICAgICAgICAgICAgICAjIGludGVybWl0
dGVudGx5IGZhaWxzIG9uIG5ldyBzMzkweCBzZXR1cA0KPiB4ZHBfc3lucHJveHkgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICMgSklUIGRvZXMgbm90IHN1cHBvcnQgY2FsbGluZyBrZXJuZWwg
ZnVuY3Rpb24gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChrZnVuYykNCj4gdW5wcml2
X2JwZl9kaXNhYmxlZCAgICAgICAgICAgICAgICAgICAgICAjIGZlbnRyeQ0KPiArbHJ1X2J1ZyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjIHByb2cgJ3ByaW50ayc6IGZhaWxlZCB0
byBhdXRvLWF0dGFjaDogLTUyNA0KPiAtLSANCj4gMi4zMC4yDQo+IA0KDQo=
