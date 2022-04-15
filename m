Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5C2502E8F
	for <lists+bpf@lfdr.de>; Fri, 15 Apr 2022 20:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345333AbiDOSI4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Apr 2022 14:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243676AbiDOSIy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Apr 2022 14:08:54 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6730860D8E;
        Fri, 15 Apr 2022 11:06:25 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23FHgAe4028286;
        Fri, 15 Apr 2022 11:06:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=UXFyYiQ6heAIbJ0nSwo750rEOLWZx6/ftlfcpcGwKcM=;
 b=RTnqUyJAMxsx4k0w+DlHYgePk7+QS90We56Pe/TFfwjCfzPP00MT7zxOUvd1Sot8+tQQ
 O9zdubBr+WHVqHaC1tvZNdAyh9T8Werqy2ACuho2MtfkqUgdpdEE4o7qnjY6MR5g8x7H
 unroabiQigMuNdqryfhJG13uWwSDTeuxjJc= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fewgqccwk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Apr 2022 11:06:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZchHFyQ8gJR0YD3WlWao8jtOOMv1zd/RgS2pBoNaQ5w4/df8KWB+64c+CByGQ8PWJ5gO8IzV3p+o/h72lxJx/KL0V5SOtj5UxOGZ9D4IBTp3KAGX7f20GI0aslhxCXl7vX9TlNIYQCRM4BqP7AV8EMnzQe63gKKnEcua5Z1atmZyPqdwLD1YAxBh8Q+r577kbyJkMeXsBaQmUuybGHp3p1eiutwe1/RgcEOV9vEeIw74Kv2T13U77HmpcxNJ/Auz2XjWkk44pQNpylDwAnXx+tVpXwztCcdBvInyL4IWqMvizqQ3uDNxL5rHv8LSfpjHEzfE2vElFREbgJQzJT0tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXFyYiQ6heAIbJ0nSwo750rEOLWZx6/ftlfcpcGwKcM=;
 b=mLR9dj+CsGGRBd9ZLAmZ/ITOMlz/aGV5lCVySQ9A60beJsA3HB0qN5bNyhWYA5LEDtpsQyMntrdfY7VNynFlSSCOZpDBVtJ+oOK0Qk5O8B06yZlQ2kOcc/VYHnuEPqbO+jR/MtnnRk1V0gMVdzfmo/MP/8KsxeUDwc4QAMAl/3SO+rvCjvgxXdwjDHo56SgXdrRoS9PWBWEMOicN5qnUBXE1XlyOCppbTNhcrD2FdWyL9tKd5+OYI11O8Wo5vRtRW2Las5ilkTpprilYj7Zx0JfXgjD88LtgcYOM7fHFb8A9Ne8jPMfjhLq7oL2g8X4/bK9fdfs8EJ5pFEm4zkvVxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from CO1PR15MB4969.namprd15.prod.outlook.com (2603:10b6:303:e4::23)
 by CO1PR15MB4873.namprd15.prod.outlook.com (2603:10b6:303:e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 15 Apr
 2022 18:06:22 +0000
Received: from CO1PR15MB4969.namprd15.prod.outlook.com
 ([fe80::8120:700f:26f8:b29e]) by CO1PR15MB4969.namprd15.prod.outlook.com
 ([fe80::8120:700f:26f8:b29e%7]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 18:06:22 +0000
From:   Rik van Riel <riel@fb.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "song@kernel.org" <song@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "hch@infradead.org" <hch@infradead.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v4 bpf 3/4] module: introduce module_alloc_huge
Thread-Topic: [PATCH v4 bpf 3/4] module: introduce module_alloc_huge
Thread-Index: AQHYUOik1j7ipQb/LEKYeQKEAivkg6zxRTSA
Date:   Fri, 15 Apr 2022 18:06:22 +0000
Message-ID: <34e1ae46cec25811cc821f0d9ee2b9e382d1c42e.camel@fb.com>
References: <20220415164413.2727220-1-song@kernel.org>
         <20220415164413.2727220-4-song@kernel.org>
In-Reply-To: <20220415164413.2727220-4-song@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 328a3b37-4641-4fb4-bc96-08da1f0aa66e
x-ms-traffictypediagnostic: CO1PR15MB4873:EE_
x-microsoft-antispam-prvs: <CO1PR15MB48739054B5355E76E0034171A3EE9@CO1PR15MB4873.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0SMC1NY7L3SAo3J6GoIRdn/o6Q6XNHz9QaOt416jhcuMDR9Br/adkybbkDS2/o37Hs9EYsjQEGgsmwjqstM8pTUFZ9ZoU4NG1wAw7ZBJgWVnCzoes/V/WXZOsHlUZ0sUpMrBw2gR7j+JmYZQAFsNLs1JtItTaxkGXQl/6SOEGy34uBRIwp/mI40qspT5oOz/f76pRfchEXBgGLMlUyEIezMuko7GTD3lp+aH2ixsDFmL+9ehvcgpjECLf0mWEKW8kHCErvwRVm+JQvBpDwadO5KBVSXROrKVdb4Tsl6lAEy6rXyitEaHnvNXkTb+P29YiC7BQv91rOoTl9I8Fy1G4xjpHA1LHRjIqPI3/qX+Ms3dZjUlOkBLusUbAFHUpXyNK8KtCmDDqo5le1keBaymLFPKC3/HI+C0c4T1gJ3cHqFwLVJ/OuoT6005YksJqFk9qGZQUS439T6V7naZ7jttQJyB+rIh8JDb1WBvrE7zksgofyb6SPkwPh5uBkmFgFv6LIk8pnC9Bk9GDvc7f/213MLb8u6pAJMlWLrXaoYZcTXw/M6aIQ6OeCOz5+84o9xt8uoyEFqT268fXXKS8NMY2dpBBK1eoA+CmPuMldhJCI/Ge+6mqMFMy/mTIvBB6tf89v4AphIFBI1eD0EcwFyPYnMDEcplGb3IuR5KZEAaTMixLsxF11KT5qDV9eKawpqpCCVJVvp8bKGWNV48nb05/oZx2H1/7FwC0Up0dpQfTLM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR15MB4969.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(110136005)(54906003)(66446008)(38100700002)(76116006)(38070700005)(2616005)(6506007)(6512007)(122000001)(186003)(6486002)(71200400001)(8936002)(7416002)(2906002)(5660300002)(316002)(4326008)(86362001)(91956017)(4744005)(66476007)(508600001)(66556008)(64756008)(66946007)(8676002)(36756003)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0JCNjREdHNla0pGVi9BZ3QvLzc3SEZ5bFJoMC9BM0JoK1M2eTE5eXhEdC9k?=
 =?utf-8?B?RElielBkYUorYzhnYlJxTXdvQXp4NmM3aFExTE96aTJraDJWUW5GVWdENzI2?=
 =?utf-8?B?djVBVjI4blpGRklHaXF4emtaTXpJRFQzVjFKOVpPL05oOGtqUEl1ZXNhTndh?=
 =?utf-8?B?RHJNN0RNa0MvZWFaWGJrWDJXanRRQUZrb294QVhWOWd5S2hWaEZPRUQreEFn?=
 =?utf-8?B?V1hFV2ovdHgxNGQyMlIwYnphT2d5TFJldkttSm9KM3lkczUwMUpkS3dmdy93?=
 =?utf-8?B?aGc0RXZRZCtHTnRjdTlmaTVjN2dSMG9FZ0pVcWpmc1BGRHlJbEVDS1FtSXR6?=
 =?utf-8?B?UGN0S1hHU0hjTTFucWcwRC9waDBGSk9BaUt2dU53TnpDUVA2VEU1UFZKc3p0?=
 =?utf-8?B?WlI3UjlEZmlOanNpM2d6cytDb3lBbEJ2YmZEM0VDWk1ncE8weHJ5V3pjaC8r?=
 =?utf-8?B?S3Ywc01MVVJIb0wvRXBxZms2NlZRSjZQZ0dVRUZqTFVCMGwvVkFCRzkvdG9D?=
 =?utf-8?B?Y3NEY3VNUFlGWFNkT2F3SDRPVkd2NzFKT3dBZG1JZUJVYUluT2RESEkvZ0VG?=
 =?utf-8?B?eFBGbmdMK21IemhBdXBoYitiQ3JpM2l0SWNRbVh5M1haME8vblhQb0VMY2lD?=
 =?utf-8?B?Zi9MUTdCdk9zbWVDSnJpUUluZlc3cnNsSTBxbjJaREVMejRiZDNIY0FBbjVF?=
 =?utf-8?B?T1BoOTNwWVhpZTdOeHE0cU1pMEhWSmMzMUlPeXROLzBvT2FkRU1LZ1g1b2hn?=
 =?utf-8?B?a2ttU3RUem9jVWhmdWp3aHRwaWVuVDJVS2ZqcUtMYzE3MVVTVExwazBLelho?=
 =?utf-8?B?QmFXcGR0QTdkVlV3TTRVZ25RV1ZmR2ZxeFVJNnJ5QWo4WVZ0MXVnU0taV2NN?=
 =?utf-8?B?QjFzMndvVkpWL0RWWFF5Sk1ua3NLU2FqK0RiaCtYSGhXdWJHeGR2S0w5Y2c1?=
 =?utf-8?B?TW9zc3pJUzVNb01Ec0ZJNXVIU2JjRURJZkV0UHU5dlpkZ0xEblFaL3ZTQTdT?=
 =?utf-8?B?ZGlneURKRlVsY09LNzFTM3U2ZXJrMEpxNG9KenJqNHRjQWc2cVl1Q3hYRDhv?=
 =?utf-8?B?dHNyVld3ZDNQRmYvUWt6ZTFSUk9xT0d0SnFWZ01kWXVCaHQ4UWFWU296L0NY?=
 =?utf-8?B?RkIyTms5bHJOaWNjdlRxbVpIYUxTVktBN0xSOE1xSlZiVlZOaGVJdTNYYjAw?=
 =?utf-8?B?bUhsQXNxZ09DUjkwU3F3a3crZ1JmbSs5eGhJMGV6Tk00TkRXREVTT1Z4czEv?=
 =?utf-8?B?NEE3em9JbkZxOXlZTzJ2bVF3MUxwNHA2bzZnR1U0UzFoWllvUzVGVEFCaU4y?=
 =?utf-8?B?YkczSFlCdWtCajBoN3FteEd0UXNnaCtvejJTZE5TU21wNmhWTkJjUkYvWFhB?=
 =?utf-8?B?VnB2ZHFpNTgxTUtVREZYdkRoK2RybE4vZWgwalRTSDhYREZyK3pDZENBUHpM?=
 =?utf-8?B?SzdiMFhERC9Wb0hiMzM3ejdsY2llTlVacVh6ZEVNVFY5QWlsTUpGYUtwcUc1?=
 =?utf-8?B?NFJvcEVnek14ZDJDbk8ydnJaV3Vxb2hxTG9vNW1aOGo4aitkQVF1ZWRod2hv?=
 =?utf-8?B?TkcwWHVWQVpOenlIcG92NStTTGxxQUNuazFySUdRRzRheC9zVUlwRk5YLzAw?=
 =?utf-8?B?K1c2R1RqZHFWcVdRdjMvRGx0TlMrNGJMLzdlQUx4M1YydzBQMmkwQytINWpF?=
 =?utf-8?B?NG1ySVR3UGpSaUlSRDhUNm9OWklENnFidSs4VDNrUEhmWmZoOUNpaGVESERU?=
 =?utf-8?B?SVh0ejA3aXBPWGtqOXNtZ0Q4ZUgxTmI3Z1VwUDBuVGk4Q2JQTlB5VThoQnRW?=
 =?utf-8?B?VmNvcXJ4ZGZ6RzNZc3Y1UFpzUXQ5V1NSTFZrTkhoVmVEeThuS1gzL1lIU2kr?=
 =?utf-8?B?bTZZVmxuV1J1TGs3ZTY1R1BJTnIyZmVpd1NCY2trNE5QTFpBMGtJWWRLaVVt?=
 =?utf-8?B?Qmp4dW5QVHVIS1N6NjdraGlObklxM01tS09teGRsL09lQmpNYm40UWJXbjFQ?=
 =?utf-8?B?ZVJ3Vks3MFZYQ29ibEs0dVV5aDdML2RTdTBsZ0syZExGWUQxOEx5WkVPSHht?=
 =?utf-8?B?K1UrSjlZNjM3M2xaWlVhNHp4eUFyc3VUNnpjTzNDWUJrRmQvbm5FUW1LRWxN?=
 =?utf-8?B?aStZdHFrb2JFNEdtRVZNY2tYZ2ZaTHhZTkp4UkNBclF6SndOeTZZemYrRjRq?=
 =?utf-8?B?aGtKVUp2dmdoMWpnK0t1ODRWZkVyVEZBRDIybHhhdFEweldJZldlZDdmWnBB?=
 =?utf-8?B?UFcxZ3RhSllRalJWalI4eVozMVFXQ0RXUzVwcmtjK3g5N1AvY2ppKzd6WVFI?=
 =?utf-8?B?dGJwckswM0R2VEcveUljUjlIeGFyNUJCa0dsaUhzbkxoaS8rRGFjUXBmclN3?=
 =?utf-8?Q?3kRiOKUi+TsXMF4k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDAFE81FFD15C845950DA2423D0FFD36@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR15MB4969.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 328a3b37-4641-4fb4-bc96-08da1f0aa66e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 18:06:22.7350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YYtmL1aO4xUVijXdmUO3vAucDr0/AjoGIB4Hyb8IEZpB6JZJq5CtdDb2SMQr9NQT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4873
X-Proofpoint-GUID: HRkJOnQ1lQwOVX9tDga1ehsasLBZYatE
X-Proofpoint-ORIG-GUID: HRkJOnQ1lQwOVX9tDga1ehsasLBZYatE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-15_06,2022-04-15_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gRnJpLCAyMDIyLTA0LTE1IGF0IDA5OjQ0IC0wNzAwLCBTb25nIExpdSB3cm90ZToNCj4gSW50
cm9kdWNlIG1vZHVsZV9hbGxvY19odWdlLCB3aGljaCBhbGxvY2F0ZXMgaHVnZSBwYWdlIGJhY2tl
ZCBtZW1vcnkNCj4gaW4NCj4gbW9kdWxlIG1lbW9yeSBzcGFjZS4gVGhlIHByaW1hcnkgdXNlciBv
ZiB0aGlzIG1lbW9yeSBpcyBicGZfcHJvZ19wYWNrDQo+IChtdWx0aXBsZSBCUEYgcHJvZ3JhbXMg
c2hhcmluZyBhIGh1Z2UgcGFnZSkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTb25nIExpdSA8c29u
Z0BrZXJuZWwub3JnPg0KDQpMb29rcyBsaWtlIHRoZSBCUEYgbWlnaHQgZW5kIHVwIGJlaW5nIHRo
ZSBvbmx5IHVzZXIuDQoNCk9uIG15IHN5c3RlbSBJIGRvbid0IHNlZSBvbmUgc2luZ2xlIGtlcm5l
bCBtb2R1bGUgdGhhdCBpcw0KbGFyZ2UgZW5vdWdoIHRvIHVzZSBhbiBlbnRpcmUgaHVnZXBhZ2Uu
DQoNCk9oIHdlbGwsIGl0J3MgYSBzaW1wbGUgZW5vdWdoIGludGVyZmFjZS4uLg0KDQpSZXZpZXdl
ZC1ieTogUmlrIHZhbiBSaWVsIDxyaWVsQHN1cnJpZWwuY29tPg0K
