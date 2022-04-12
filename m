Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E7A4FCE78
	for <lists+bpf@lfdr.de>; Tue, 12 Apr 2022 07:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiDLFJM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Apr 2022 01:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347533AbiDLFJH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Apr 2022 01:09:07 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A732A205FB
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 22:06:50 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23C3dUOB031334
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 22:06:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=jhqNaoV6buYqMI4OQIs0OG+zb7trxlCrMglP7LFHO04=;
 b=PvDKm469zbw8pCGsBgYs3GKY2yMsd1PLFyWdxxUtzadwUzU6UutuT71FWrJaPbAd1iEi
 S7r3E6qXGRO0Hr31G/kCYXCoTeBIRBEFiymOhMm2yg1N3f4M6ulrPTBE6dMq7J6RWEd8
 ZMAO6YGAyBd+n9feF42f/m8Cisd55Bt6siU= 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fd1pwg7ux-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 22:06:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/wud6PAByIfsM3pYHRwKctIZtmHiRkV42XbNSv7x4dN3N6upmEJ0eLC+FozNfkLIJy7nh2Axlpx7qW9Q1n2UBrFwbzewzljg9q/21cg9If4OWrCjTpmAXIhSeK19oCwodCPKhrjayFrsXYF4k/0QVgxTOTdYY6d8twwqZKy3EqutbICPSrQ0AOimD0PujFClMgZ57FX2w6Lc9y3hfnwahC+4eoHQmRHZ+2f0RiopfYzqlHUwFprz8Ka0aPiCK70zTSiO2brYUKOsZBRhOXelgIh7Zy12xAp9DrUKJEZvr19wF9HbcpPQONVKB1OF3GgbDP3XqJd02zLWDcpL74zkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhqNaoV6buYqMI4OQIs0OG+zb7trxlCrMglP7LFHO04=;
 b=Du7QvWqQQXPYD/Ieyv5AN6JYxlfzz78biEQqE5NobV0N7HYmZKgXli0nb55ooALcEY74RrzlYpcSmWrrDtJryBteaAqK44idO7DNJb3L7jy5/y1Tgc6PfzRR7SWH4pw9K5at50I9/UIUw/LsgLej3D39BKsHeBkXo2b3YWoGH7PFHBQElSnW2v0w2W0fDjx5xJnnFtozx/W0cCx+zESz+S9fn6IoQxrn0Xn+M23Btu2O5wolYp8WzMnN/klhQDK3v2aWsPpoimI5nP7PSCFY33krb0zvfGrL+Q+HJHdYRKzAtxKvuLgxTvoxdBPkYU3GIVKebeziKdZFY7IVd7ZKUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by PH0PR15MB4752.namprd15.prod.outlook.com (2603:10b6:510:8d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Tue, 12 Apr
 2022 05:06:48 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::20d5:ab50:fdf7:2a9a]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::20d5:ab50:fdf7:2a9a%6]) with mapi id 15.20.5144.027; Tue, 12 Apr 2022
 05:06:47 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 2/5] bpf, x86: Create bpf_tramp_run_ctx on the
 caller thread's stack
Thread-Topic: [PATCH bpf-next v4 2/5] bpf, x86: Create bpf_tramp_run_ctx on
 the caller thread's stack
Thread-Index: AQHYTcqSwoc7q0QAuUCFfiocTOiReKzrOeAAgACAwQA=
Date:   Tue, 12 Apr 2022 05:06:47 +0000
Message-ID: <25a32b7839255ae8678452aa84eb640351b4b910.camel@fb.com>
References: <20220411173429.4139609-1-kuifeng@fb.com>
         <20220411173429.4139609-3-kuifeng@fb.com>
         <CAADnVQJYpsdUh9+vt8Majj+M5XoFxHjjjDQ7=4H+uG3HAhL4OQ@mail.gmail.com>
In-Reply-To: <CAADnVQJYpsdUh9+vt8Majj+M5XoFxHjjjDQ7=4H+uG3HAhL4OQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c06564b2-0a92-4303-4454-08da1c423f21
x-ms-traffictypediagnostic: PH0PR15MB4752:EE_
x-microsoft-antispam-prvs: <PH0PR15MB4752BE5011A5F13F3851AE7ACCED9@PH0PR15MB4752.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZTIqURgw9B7D4lWco4K5+rMNXZYyO6i2DWSMNzTQvGeF1JklmU81Ri1K8BCor82QKvsxFA8Ga5cDRkY0RokpaXUgPKR3XNu6vacWh0UFZ3MnYQcLnzdEvUuwoj7H9gTz2ZUhSGqrxT6mG2mrckB/Fv+nUpMSpwtSWq30ALCHwzFwiLHJpdsloVdjpSGre77x/GAylMKev87P0/Pi1PKH03g5G7LBhWGY2TGzTSNTR7RBZjfgbm0wabOWy+YfCFfwXeSNPSSNWx6m3WzML8UEDldjZCzH3ImEERBWeVRKkAWYsieBSUmx3dXV4yQysyLGys+SWPLhurWw2vJf6/LSj1zmaqn0fSc7+YX7Y6m3XJIeig5ZFN4WPpVdNJU5GfPzSrJrx218ozTS0AOQKXbNa6g4POH53NMkBdSaRgUNalww1bDSJs5LGp68IQXvG1npjABlrfzlPbg+GlUjq8zFqG8WEtxJR7wpxOY+52NxbTNn1pOVA3s2zAJ7fTij2uhe7MOrHPp3A9H/qlf9WnDhKQfFWcWZYqVvQ9mKEcYjO/ohtUVlzBt9RUhbM5+BHuovczJPr0By8BSGwBhO5SciL1CHZAr5y2RffzgOpxICTjXTqxLL+yBqvqHpdKu21PT4qfkqmxYa4KYtErSBWDf15bx111DpVkOG3sz8jZy7Y4TPVDG7panKWZTF/zKJ+HMsaY9Mbn/ur/7dO80Kzu8TaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(66946007)(64756008)(36756003)(66476007)(5660300002)(8676002)(66556008)(86362001)(508600001)(8936002)(53546011)(4326008)(2906002)(6486002)(83380400001)(316002)(2616005)(6512007)(54906003)(6916009)(186003)(71200400001)(76116006)(4744005)(122000001)(38100700002)(38070700005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alpKcE80aUMxL0V1Q2ZiY3dDQkdSMU42Mm1RVDZSWnhleSt5WXBuTHp5U2NJ?=
 =?utf-8?B?RkRlNVdXUjdJcXlkejlVQTJCL0lPZDEwZ3lPK3BSRXdzRDRKMzFrazVLWFc4?=
 =?utf-8?B?dWlrWGFpTzlvcDdlbjVIb0NTUVFNWHZydkMrYThSdUxMWHBYMDlCWHB1cW5w?=
 =?utf-8?B?MzhONVJzeitaY1ByMUVRcEhQZjJ5YlFnRGFCT2gzMk5QeFNZdFJDaStnL1Qr?=
 =?utf-8?B?bUwvOVRuangyeDlwL1NoOEJxMVNSUXF5NmU3TVFMUkxRVmd0S3NWaG5ydW9x?=
 =?utf-8?B?VEhZZ0FsejM1SmZYRitkS2tPYkhJSDdWaHdqVDRsejQvUEo5dTVsYU5PL1Y3?=
 =?utf-8?B?SlQxL083SkhxOExORklzQVk1a2NQRUw5TG1PaC94aU5iTnhIME50LzcwNU9w?=
 =?utf-8?B?LzB6ZXFSWjRYVU80QUt5UUxDRUhGREJmNm53OVJBalNCU01jV1hIbkJrVW1q?=
 =?utf-8?B?VkZKVDllbUowMXRvWHFUeVNERG1aVjlQUzZlREwwVUd3TVdDZnVOZmIwZ1Vs?=
 =?utf-8?B?NXlGbWhTQWZ1elJPa01lbHVYZWlBK2hvc2tjSU1UVWNjWWRaZ0hBbGhoZThJ?=
 =?utf-8?B?TExxMW9hdFVMNVBLNWxBUkVaYlJWR3loMUFXRXNtQURVS0kzZWhiQlkwSUJo?=
 =?utf-8?B?MXh2T3I3RjNtVnRsakhwSzNRcXRaQVdvM2w4TGF3bjRaSnRLY3pUS0QwRW91?=
 =?utf-8?B?Y1FGQUVtNktQVGRCRjBuMElZZ3hXZGM4WUg3WWl2MEpmZlU5RjJtcFM3emp3?=
 =?utf-8?B?MmZrVlpmQVd2VHlFY2RlaWVucVRhTWN0TThGYmFjODJyVnVpYmlxSFg5RXhv?=
 =?utf-8?B?MXpFd0dpeCttK2tSUUhJeU5IR2kya0dBMExRQkNESm53RTF4Y0ZqNjYwV05L?=
 =?utf-8?B?cGpqWlQwZlVsRkNla3RQMS84ZjZYRmZnUjltUjl5YzFBMXJSbE5ONXdDaXN4?=
 =?utf-8?B?ZHVKRmJOem9QUlVMNFlVcWkxTGFmT2hMbnRoWThURmZjSEVwbm5XbkpWWHFZ?=
 =?utf-8?B?VVhta2FCVmxYc09wMlRvS093dDRoRFh3T0tGeHJvQ2JneWVEaTMwVWFEYWRq?=
 =?utf-8?B?UXJ0aktReUZUNit0a2d3UlowVlhrT2pUNDFKRVBEK0dCOUkrZkJLSEhSMmQ1?=
 =?utf-8?B?dVRRZWtPV2ppN3RwMmxaVkdvWXpjbHVLYWZpQ3VMU1hNM2thVXozM0RFakhr?=
 =?utf-8?B?WGQ3SS9hRGhkOGc4Y1ZnNDdOSWNRZlZWbG5TVkllVUNGK3ZpNnVNdko2Tkcv?=
 =?utf-8?B?WXJXWVdlQi9XM25RL1E5dDUvWGFYellaYjBVZXpEYVA2N1cxVU1ocTNHNGlx?=
 =?utf-8?B?eWx5NWVENlVLNmx2NVpGdHpUZ2g1WStRNUZrS2YyUmIvY0MwS3NsaFM2alU1?=
 =?utf-8?B?ZlpKRG8yajRML2dBQ205U1V5dmRzRkl0TWFTTXVyejlTVGN1c2p5TnJEblU0?=
 =?utf-8?B?LzI2Yk11ZEZSblRJTGtFZkFtbDF4dU5rT09vNTM1bjdzTGUwWVRHRXo0QnF3?=
 =?utf-8?B?OEtXTjByQ2JmeEVRZ1VpaDNGMHNGN1RlY0F3L3RaTlM1eUtZWXdMWUZia3lK?=
 =?utf-8?B?SXp6dlpsTzlDTDFwZWE5NGYza2xkd1BidzRjUytLUW5aRzZDWlhXeE5KUWZJ?=
 =?utf-8?B?alN4TDFWckY5WXVPMytISGo4STFhRllrN1dqclJvWVdYYVliOU9BR1lucXhU?=
 =?utf-8?B?Z0R1R3IyNlBNT3ZuSW0zQUlZcDEyVzdNWnN3YzNKNWZWRDB3NWNuMmVJWFpx?=
 =?utf-8?B?dFAwcTFHdGRRZ0xtc3J3Z0ViWTZWMFpnMm9DRlJqTFJ5Y2F0THJFbzlCZ0hX?=
 =?utf-8?B?THV4SzFFd1lhbm5talB1WkgyTDZHMXpvR294Mkc2Y2cra2FZODMydlFvVndy?=
 =?utf-8?B?MFdxMTR3N3dteXBLQkJaRnR2dFk2VjJhRDVmb3BzK2dEM2dLdDg4YngwUDdl?=
 =?utf-8?B?T2hGWTQ0M1V4dWNOT1dqdmVobWlUUVZIaC9JbEc0Ylhhd1N2b3ZUd2wzbkhq?=
 =?utf-8?B?UXFHOG5mUDBGSDJ0QWw4aEdraWY5M3grOFgwWmJHdFZibmJXclZIOW9HaGtT?=
 =?utf-8?B?L3NOMGRlcGJFQkZJMVp5QStzY0wzRjJ3bHFFUnlUem1nNXA2TklwYTFHbFpa?=
 =?utf-8?B?dGJlc3h5WS9MRlZTQWltb04yb0w3ZERsbjVGQUVBNHNYdUlmYTJNdTJ3UkpP?=
 =?utf-8?B?cUR5TjkvTk1Wd1BYZEtpOVB6S1YrWnFxWlVSRmxqOG5haFRHYXRmdXJ5K3dK?=
 =?utf-8?B?S29mRWUvbzdHK2hKblRVdUNhejhFOFFHczk5V2ZNbVZXT1FQMnNmQ28xL3h5?=
 =?utf-8?B?RGkyMTQvMlQwTGpOb3Fxb0lPRkhTRWh5eWJFWlpNTStIRTNmSDZYZDcyRTUw?=
 =?utf-8?Q?2APlTO1y7D6Uf86o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE2811DC62EA994582F912EB4E2B086B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c06564b2-0a92-4303-4454-08da1c423f21
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 05:06:47.7816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YRYH29ie6OEoRgV2g/R/au/Mt5M7jAvbpdn6qGkHu/Mse+/biuagQGbuABHQ8dDJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4752
X-Proofpoint-GUID: UjqRmfoAvtT-9OLTsvRQSrqyA09LktM3
X-Proofpoint-ORIG-GUID: UjqRmfoAvtT-9OLTsvRQSrqyA09LktM3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-12_01,2022-04-11_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uLCAyMDIyLTA0LTExIGF0IDIxOjI1ICswMDAwLCBBbGV4ZWkgU3Rhcm92b2l0b3Ygd3Jv
dGU6DQo+IE9uIE1vbiwgQXByIDExLCAyMDIyIGF0IDU6MzUgUE0gS3VpLUZlbmcgTGVlIDxrdWlm
ZW5nQGZiLmNvbT4gd3JvdGU6DQo+ID4gLXU2NCBub3RyYWNlIF9fYnBmX3Byb2dfZW50ZXIoc3Ry
dWN0IGJwZl9wcm9nICpwcm9nKQ0KPiA+ICt1NjQgbm90cmFjZSBfX2JwZl9wcm9nX2VudGVyKHN0
cnVjdCBicGZfcHJvZyAqcHJvZywgc3RydWN0DQo+ID4gYnBmX3RyYW1wX3J1bl9jdHggKnJ1bl9j
dHgpDQo+ID4gwqDCoMKgwqDCoMKgwqAgX19hY3F1aXJlcyhSQ1UpDQo+ID4gwqB7DQo+ID4gwqDC
oMKgwqDCoMKgwqAgcmN1X3JlYWRfbG9jaygpOw0KPiA+IMKgwqDCoMKgwqDCoMKgIG1pZ3JhdGVf
ZGlzYWJsZSgpOw0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoMKgIGlmIChydW5fY3R4KQ0KPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJ1bl9jdHgtPnNhdmVkX3J1bl9jdHggPSBicGZf
c2V0X3J1bl9jdHgoJnJ1bl9jdHgtDQo+ID4gPnJ1bl9jdHgpOw0KPiANCj4gM3JkIHRpbWUgdGhl
IHNhbWUgY29tbWVudC4NCj4gTG9va3MgbGlrZSB5b3UncmUgbWlzc2luZyBteSBlbWFpbHMuDQo+
IFBsZWFzZSBmaXggeW91ciBlbWFpbCBmaWx0ZXJzLg0KR290IGl0ISBTb3JyeSBmb3IgdGhhdCEN
Cg0K
