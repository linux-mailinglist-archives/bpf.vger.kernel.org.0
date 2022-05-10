Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCDA522194
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 18:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343754AbiEJQsh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 12:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347616AbiEJQse (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 12:48:34 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A69B1F3EBC
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 09:44:36 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AFLtR4002058
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 09:44:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=/h3fRjv+zOj37wbDptn9SDhptcPDwSlj/Z/sxhpln8M=;
 b=doeWp5KH48y+VAY9D7TMPAZdBiE3k+hQpBFfVVjhGhPAy9TbTtwrvfssxFvLmixmnbcv
 9nymsLa/oWY42MtY+9QkT/LdHc+xZCoReFPNFnOHV0XPvbtTSdVGsOVHPYTpzB+P0JM4
 fW6eutuA2FTT5v8PYj/bE3cmZUlEZ2EAQMs= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fygdk46cp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 09:44:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXxUEmRDB3q7aw3HgZDNahgLPqLQFygs8hN57uXFKYZuBj0z6cGMS+Gz0uepAmprwdeZuK7MXRhrI5tTiomyhO4u3QYBu4tZ6Hbyd4pR17lpbn++zPTm5XBJ+PCMWNZ397P12ZP2BUROkxusmqpF1QJPPhKIyxwAagjVv6uEMhUEeMfQ+TrIou+RpoCzHJnaUUsBgxp0cw8pB19hjwtO1x7oy065Nwpy2s9O84uzlY4vXSsJVlxX13muaOxeHExwV1i3aWzXB1X35nyvo784WGRDl289W1+/WURomLcJxa7P2pzxmK/lJMFbCxkqtJJ9API+dalgPOQwxYLuoASbXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/h3fRjv+zOj37wbDptn9SDhptcPDwSlj/Z/sxhpln8M=;
 b=HihFkwwCSeMaUANL9pYvDR/b7NaWfjVZtTrUT5tau6ubSj9YCcBnit0D34cPVafyNingI2RpNo06MsZOcZC5x9EhCVmet13a9T+4dFfdkNQZjmpBcrA9rhF6ZiqwbmdpQLTDiHTJmzDEQdd7os4bUwaeXUz2QnwWLNkTD5RrmroFtgtyFK5d+GdVBpBVtjW9P6Pkn3uG3YugZNBeUJPjFmG9E0CEoGNHnVuGCHUpItndDLuF74oKDYSIMQqNIipHqfcTkmvBuJ1MP6wJ4bmWbpz+tDbdpJLH4KcapZ3NDPbQs7nsgM8vWPDU5F42b0xY+3qnT4B5Cjw0sRS+uFQXtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by CY4PR15MB1559.namprd15.prod.outlook.com (2603:10b6:903:fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Tue, 10 May
 2022 16:44:33 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::8062:184b:31e7:8777]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::8062:184b:31e7:8777%6]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 16:44:33 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v7 3/5] bpf, x86: Attach a cookie to
 fentry/fexit/fmod_ret/lsm.
Thread-Topic: [PATCH bpf-next v7 3/5] bpf, x86: Attach a cookie to
 fentry/fexit/fmod_ret/lsm.
Thread-Index: AQHYYorAFF9uQwimNE2WYveuoA3c+a0W6GGAgAFs+wA=
Date:   Tue, 10 May 2022 16:44:32 +0000
Message-ID: <e3be9e432ba6ce95543977b542ee1a2a91e978e7.camel@fb.com>
References: <20220508032117.2783209-1-kuifeng@fb.com>
         <20220508032117.2783209-4-kuifeng@fb.com>
         <CAEf4BzYitV038g5SW1DexVuxH1YNgdgfKs_yV+ExbRPuy++N3w@mail.gmail.com>
In-Reply-To: <CAEf4BzYitV038g5SW1DexVuxH1YNgdgfKs_yV+ExbRPuy++N3w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d79492e-b251-4fd4-d86e-08da32a45c54
x-ms-traffictypediagnostic: CY4PR15MB1559:EE_
x-microsoft-antispam-prvs: <CY4PR15MB1559F3CD3E7D3C34CBE11B3ECCC99@CY4PR15MB1559.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cUPT30csu/X5XUe9ZDy312cI7snLjva+3slDX1otuFRkQP8zIhVsYeR6AHYpGZVKwTzIYM4r9f0UmdoAmf+KuGhE0GL4tgDiHtKpXDGzYXIz+ICz0mkdarDxP49Hug1LIselawqqtW2c5N4fDKikIyAnw9JByxcEX2FJUXhG8haogInu0yEyuMR+bHE7/8vOMxjXe9iKHR+fZuGOdXB9blyU1759saBivoaGzLr+w34GXasNI89rnDR49rMKTRQCZnNaY6ooWwoWKI3o/6UBlhboWr/yF7zfYs+N/aOen8+Rc/ryLeof/Q/94QLD5jX7W7LJV1OVNNYDW1NEVxXatd+8LrvdpHd8D/Xt1NLJ5WB7ujHUP3ZWV9ovlL2hFmDZvSFXE0zO7R25Ek1dZRs75XfaPu4e3UFHPxS3i3JJnSzCgn2bXtGeLuhhWaBKME1ekI9rtzWX5g8Rnl+Ozdd3VQ3fKMrw/6FDNQZ35MdFAFKOOjp0yAKwwC0bIfE+IMiD4w3x6RuN6kzm0YLo4rDIb55+zyyvYc9TK9uG2isFRvWv6LkG1vxVOcQNPZOBeePEbRQEHl4h7aTg1kSLT8cS7vaEEi1g8V8cdxAZ3XYlqYgpSaUiJZhxduWIhUNP6R2dv9WM53tJPK3isbLDNha3uRUG9Z2Uq+7hmmOiCe1dOzDl+2Hj/MwFKwpL+fwTx8PTks/yDA0tIHaBLHkOewqJ9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(2906002)(6506007)(6512007)(66556008)(8936002)(6486002)(71200400001)(6916009)(508600001)(5660300002)(86362001)(54906003)(186003)(66946007)(64756008)(66446008)(66476007)(76116006)(2616005)(8676002)(83380400001)(4326008)(36756003)(38100700002)(38070700005)(53546011)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0hrZ2ZvalN4ejU3Um9Nc21iU2EzeU43TWZxSkFwL0ZNUTY2N3VNM05wSGdt?=
 =?utf-8?B?dCtpM3hKaDlqUWFvK2VhNWFlSGFXQUI4T2ZxQVd6bndBNm9zemloT0JuTkhR?=
 =?utf-8?B?ZmhsZWNQTEt4QWsxTGxJNWwyZ25XeTlwWlNSbXAzWU53RXNzM1JVK0VtTFZh?=
 =?utf-8?B?aHVQZDhHaVVLaUg3V05pV2xYdjB5M3k3bnVIRDl2bUd4enlyYmRuZjBwZmE1?=
 =?utf-8?B?K0FRT2w1MVk0VXNRT3ltZkMxcHJQckJDL0tMY0xTaXN1OFVQWEYzUFBmaU1J?=
 =?utf-8?B?akY3TlB6OXJKcEdsSjZudDNEcStHM3FMZ2oxbEJGSGk4ZnBxbTBsMGJXem1T?=
 =?utf-8?B?SEZoU2M5b0t5YWhLcHUwWWllSGNEUkNsUkR3U1JuSTRzcW94YngvV0Vpc2pD?=
 =?utf-8?B?MEgwT3BFaGZzOVEvcDh1Lys4YkhPWkJjN2t3QXJzbzZva21nOWUxWDFBOThD?=
 =?utf-8?B?Mlo5WTZSMTRoeFkwRG94d3RyeDlmampQbHBrNHVhZStYOHBSVDZOWTZ4T0M0?=
 =?utf-8?B?elgrbk5raWhQenVQQkR6SVA2ajZ3dDhnMTN3YksxQjhHQ3VHMXF0Z3Bja25t?=
 =?utf-8?B?SG8rQzNxMkFwaEFEK1pQQWNJb2RvWVJxWnBPemFuZWIzcUlmQkwyZXh2QmFs?=
 =?utf-8?B?dGJVeTJHTlI5am9jOFFFT2c2b2xUQW9GdURRdit4U280T1VhVzU1V1N3V2Vi?=
 =?utf-8?B?Vi9ZL0x5UGtiL0FUZmxmS0hPMTMrZGR4VGxCOHdIUXR5OUhYNCtZSXFVckVZ?=
 =?utf-8?B?dzNjYjhwajNSODFFbU1ZNlRaR2Y4L3Y3R1NuNE1PTmZBZmtNWUIzcCtMNmdB?=
 =?utf-8?B?UW9ta2w5Ujc4MzlVVFVaQUo5YzVEUXhhUlp6RFNYMG92MURQRkpIYks2WDJ3?=
 =?utf-8?B?ZVdSaEhoRnBwOVBFWEtYNUVGbU82dTR4aTJCV3VmME9jY0t5SG5zaFdnVkZP?=
 =?utf-8?B?S25KcE5wK20xNy9GY3RKaU8zWTJrNXBUZDFFMW8wcnJWSG9WbHg5U2d0VHZC?=
 =?utf-8?B?eGdTSmZ4UHNmeVFWTGwzeTJGSFZxOVo1STZ6V3BmUGV5N25TamFIenNNb3I3?=
 =?utf-8?B?TVhqVGw0YXNzTkNVYzcwTWhkb2JpVjdUV3NwQVJvZ3NORWxJTU1QWGhINU9T?=
 =?utf-8?B?RGlNUUVSaEdPM1RUSGtkS2lqeVRJS3ZKQnhqRytXT2dPNHZnVWJrdUorZzFR?=
 =?utf-8?B?T0cyMDI3YnMyVlRmVTBwVVRCS1pZdVNiQmZLUUxpS0FKMzFlUHdzbmFLUFps?=
 =?utf-8?B?WWN4WXhvUm80Qm5ULzFZRVVsdEIwYlhNellvQTJ6Y0RpYjRoRkdvVnp2YnBG?=
 =?utf-8?B?UTlOT3l0ZWJQWktLUWEwQ2V6WGVjaDFGcm9KL0VwckZHUU5LK1NtQ01BeVJB?=
 =?utf-8?B?YUpXTGwvUjVkQUJyai9NOGpLTzdJbld0bExqQXJFNExFdXBoRVg5STkwLzE5?=
 =?utf-8?B?WXFKWkhTRDRuRThNYVFLUnZJc0ZPT1UzK0ZIZVlJR3p2NE9QWjVyUDdMZncw?=
 =?utf-8?B?czNIQ3A0eUlMWmllbFFmaW53a2xNZ1NlYUxKUTVsdmppS0t2TGc2NHIvV3Zr?=
 =?utf-8?B?alR4ZnVwclBsT3lJVy9jMnNtMWJ1enVBWm9mdGZROEI1TjdSWGRJTXZFQkFF?=
 =?utf-8?B?MHpLa3VGTXlFV1Z3YXdXTnJlR3pxUEZ6ZkVHaldieFY0eUxKMUgrMzU5cUlT?=
 =?utf-8?B?V0xjVFNGTGt2V21TMndqNUpOQmpML1U5TERHdEdjSWJUUjhQVnk0N3lxZjVI?=
 =?utf-8?B?NGhxNXlKNis5NHZVVmJBdkJXTXk2VW9NWjk1TktSaEJpd2k2bklUR0tNWERt?=
 =?utf-8?B?Z08wOVdHOHlUQjE2by9ZZldvSFdCZVZMamNETThWNUhISDlRb09Yd2ljUjNO?=
 =?utf-8?B?amxTNHRDbFRWQ3JHQndzMytNeDNzVTdESGtsdVRYZEdpU2ZleDU0K0NBR3po?=
 =?utf-8?B?dFBrOGdQNmlLaDBCVThJdDRkK1dSZGkzZTV1M2xXUzBqUDhVdmZGakZsYlFB?=
 =?utf-8?B?Z25DT213YWlheWRRUUEwWE42Q3Ird25qOWJMWHlyOVR1cjVpWjI4emxGOWs5?=
 =?utf-8?B?SDFjeVRtUWZvK1Y3SXkyc050cVlnNEhJNzNsY1cyWlRRY2M2dU10WlZQMFJz?=
 =?utf-8?B?bFg0ZCtVTDY5SkNndGRzTGdzYkRiam42YmZNRWxaSklxaEI0azRNNm5DLzU1?=
 =?utf-8?B?RXZsV1NBbDVmNnVaditXd21oRkdoQ2NhVHpkcWY2NzA5V3FRTHJPbDRGRHR2?=
 =?utf-8?B?Mm4rbGxUV1ExOGNUSUxjSXNFYlNmU2NqSUtRU2RISnRCNk8wK1UwRjkyNmVu?=
 =?utf-8?B?b1pVWVY4czN5ck93UGVVQ2FUaHV0cmJjY0JsZ084NWlxSlU2bDRVUFJ1Skw5?=
 =?utf-8?Q?kvo9RehVr2KUhWaxRDmoMECae0xLgViF2bV67?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A4CF00EA7A68846AB4C3B53E69C80BA@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d79492e-b251-4fd4-d86e-08da32a45c54
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 16:44:33.0811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3waV8I0PA3pn3LbX4M1CXLHWpNUG6GzIVv995/8BUHNkGmk39caYQ0b0uU4lCLvV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1559
X-Proofpoint-ORIG-GUID: T55khkP4y2XDftr-LV_j8z6a7TLbUq6R
X-Proofpoint-GUID: T55khkP4y2XDftr-LV_j8z6a7TLbUq6R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_04,2022-05-10_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uLCAyMDIyLTA1LTA5IGF0IDExOjU4IC0wNzAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
DQo+IE9uIFNhdCwgTWF5IDcsIDIwMjIgYXQgODoyMSBQTSBLdWktRmVuZyBMZWUgPGt1aWZlbmdA
ZmIuY29tPiB3cm90ZToNCj4gPiANCj4gPiBQYXNzIGEgY29va2llIGFsb25nIHdpdGggQlBGX0xJ
TktfQ1JFQVRFIHJlcXVlc3RzLg0KPiA+IA0KPiA+IEFkZCBhIGJwZl9jb29raWUgZmllbGQgdG8g
c3RydWN0IGJwZl90cmFjaW5nX2xpbmsgdG8gYXR0YWNoIGENCj4gPiBjb29raWUuDQo+ID4gVGhl
IGNvb2tpZSBvZiBhIGJwZl90cmFjaW5nX2xpbmsgaXMgYXZhaWxhYmxlIGJ5IGNhbGxpbmcNCj4g
PiBicGZfZ2V0X2F0dGFjaF9jb29raWUgd2hlbiBydW5uaW5nIHRoZSBCUEYgcHJvZ3JhbSBvZiB0
aGUgYXR0YWNoZWQNCj4gPiBsaW5rLg0KPiA+IA0KPiA+IFRoZSB2YWx1ZSBvZiBhIGNvb2tpZSB3
aWxsIGJlIHNldCBhdCBicGZfdHJhbXBfcnVuX2N0eCBieSB0aGUNCj4gPiB0cmFtcG9saW5lIG9m
IHRoZSBsaW5rLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEt1aS1GZW5nIExlZSA8a3VpZmVu
Z0BmYi5jb20+DQo+ID4gLS0tDQo+ID4gwqBhcmNoL3g4Ni9uZXQvYnBmX2ppdF9jb21wLmPCoMKg
wqAgfCAxMiArKysrKysrKysrLS0NCj4gPiDCoGluY2x1ZGUvbGludXgvYnBmLmjCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHzCoCAxICsNCj4gPiDCoGluY2x1ZGUvdWFwaS9saW51eC9icGYuaMKgwqDC
oMKgwqDCoCB8wqAgOSArKysrKysrKysNCj4gPiDCoGtlcm5lbC9icGYvYnBmX2xzbS5jwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfCAxNyArKysrKysrKysrKysrKysrKw0KPiA+IMKga2VybmVsL2JwZi9z
eXNjYWxsLmPCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDEyICsrKysrKysrLS0tLQ0KPiA+IMKga2Vy
bmVsL2JwZi90cmFtcG9saW5lLmPCoMKgwqDCoMKgwqDCoCB8wqAgNyArKysrKy0tDQo+ID4gwqBr
ZXJuZWwvdHJhY2UvYnBmX3RyYWNlLmPCoMKgwqDCoMKgwqAgfCAxNyArKysrKysrKysrKysrKysr
Kw0KPiA+IMKgdG9vbHMvaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5oIHzCoCA5ICsrKysrKysrKw0K
PiA+IMKgOCBmaWxlcyBjaGFuZ2VkLCA3NiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0K
PiA+IA0KPiANCj4gTEdUTSB3aXRoIGEgc3VnZ2VzdGlvbiBmb3Igc29tZSBmb2xsb3cgdXAgY2xl
YW4gdXAuDQo+IA0KPiBBY2tlZC1ieTogQW5kcmlpIE5ha3J5aWtvIDxhbmRyaWlAa2VybmVsLm9y
Zz4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L25ldC9icGZfaml0X2NvbXAuYw0KPiA+
IGIvYXJjaC94ODYvbmV0L2JwZl9qaXRfY29tcC5jDQo+ID4gaW5kZXggYmY0NTc2YTY5MzhjLi41
MmE1ZWJhMmQ1ZTggMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYvbmV0L2JwZl9qaXRfY29tcC5j
DQo+ID4gKysrIGIvYXJjaC94ODYvbmV0L2JwZl9qaXRfY29tcC5jDQo+ID4gQEAgLTE3NjQsMTMg
KzE3NjQsMjEgQEAgc3RhdGljIGludCBpbnZva2VfYnBmX3Byb2coY29uc3Qgc3RydWN0DQo+ID4g
YnRmX2Z1bmNfbW9kZWwgKm0sIHU4ICoqcHByb2csDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYnBmX3RyYW1wX2xpbmsgKmws
IGludA0KPiA+IHN0YWNrX3NpemUsDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBib29sIHNhdmVfcmV0KQ0KPiA+IMKgew0KPiA+ICvCoMKg
wqDCoMKgwqAgdTY0IGNvb2tpZSA9IDA7DQo+ID4gwqDCoMKgwqDCoMKgwqAgdTggKnByb2cgPSAq
cHByb2c7DQo+ID4gwqDCoMKgwqDCoMKgwqAgdTggKmptcF9pbnNuOw0KPiA+IMKgwqDCoMKgwqDC
oMKgIGludCBjdHhfY29va2llX29mZiA9IG9mZnNldG9mKHN0cnVjdCBicGZfdHJhbXBfcnVuX2N0
eCwNCj4gPiBicGZfY29va2llKTsNCj4gPiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYnBmX3Byb2cg
KnAgPSBsLT5saW5rLnByb2c7DQo+ID4gDQo+ID4gLcKgwqDCoMKgwqDCoCAvKiBtb3YgcmRpLCAw
ICovDQo+ID4gLcKgwqDCoMKgwqDCoCBlbWl0X21vdl9pbW02NCgmcHJvZywgQlBGX1JFR18xLCAw
LCAwKTsNCj4gPiArwqDCoMKgwqDCoMKgIGlmIChsLT5saW5rLnR5cGUgPT0gQlBGX0xJTktfVFlQ
RV9UUkFDSU5HKSB7DQo+IA0KPiBJdCB3b3VsZCBwcm9iYWJseSBiZSBuaWNlciB0byBwdXQgY29v
a2llIGZpZWxkIGludG8gc3RydWN0DQo+IGJwZl90cmFtcF9saW5rIGluc3RlYWQgc28gdGhhdCB0
aGUgSklUIGNvbXBpbGVyIGRvZXNuJ3QgaGF2ZSB0byBkbw0KPiB0aGlzIHNwZWNpYWwgaGFuZGxp
bmcuIEl0IGFsc28gbWFrZXMgc2Vuc2UgdGhhdCBzdHJ1Y3QgYnBmX3RyYW1wb2xpbmUNCj4gKnRy
YW1wb2xpbmUgaXMgbW92ZWQgaW50byBzdHJ1Y3QgYnBmX3RyYW1wX2xpbmsgaXRzZWxmIChnaXZl
bg0KPiB0cmFtcG9saW5lIGlzIGFsd2F5cyB0aGVyZSBmb3IgYnBmX3RyYW1wX2xpbmspLg0KDQpJ
dCB3aWxsIGluY3JlYXNlIHRoZSBzaXplIG9mIGJwZl90cmFtcF9saW5rIGEgbGl0dGxlIGJpdCwg
YnV0IHRoZXkgYXJlDQpub3QgdXNlZCBieSBicGZfc3RydWN0X29wcy4NCg0KPiANCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYnBmX3RyYWNpbmdfbGluayAqdHJfbGlu
ayA9DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNv
bnRhaW5lcl9vZihsLCBzdHJ1Y3QgYnBmX3RyYWNpbmdfbGluaywNCj4gPiBsaW5rKTsNCj4gPiAr
DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29va2llID0gdHJfbGluay0+Y29v
a2llOw0KPiA+ICvCoMKgwqDCoMKgwqAgfQ0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoMKgIC8qIG1v
diByZGksIGNvb2tpZSAqLw0KPiA+ICvCoMKgwqDCoMKgwqAgZW1pdF9tb3ZfaW1tNjQoJnByb2cs
IEJQRl9SRUdfMSwgKGxvbmcpIGNvb2tpZSA+PiAzMiwgKHUzMikNCj4gPiAobG9uZykgY29va2ll
KTsNCj4gPiANCj4gPiDCoMKgwqDCoMKgwqDCoCAvKiBQcmVwYXJlIHN0cnVjdCBicGZfdHJhbXBf
cnVuX2N0eC4NCj4gPiDCoMKgwqDCoMKgwqDCoMKgICoNCj4gDQo+IFsuLi5dDQoNCg==
