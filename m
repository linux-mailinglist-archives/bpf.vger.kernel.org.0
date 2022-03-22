Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272D44E4302
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 16:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbiCVPcH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Mar 2022 11:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235839AbiCVPcH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Mar 2022 11:32:07 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C9B82D1B
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 08:30:38 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22M7mYTR018109
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 08:30:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=I67LnFEtBzjxN76gqCkgAKZzlMuvtaNfI8r5O15Wrmk=;
 b=OB8Ho2gAYEmV/Cize+WS970tPjAI8DuTUq4T5Ecjev2MehZidaPjH2R3/2RVuqzMqec7
 Xyu0Pl31k4j3Ej831Imf+jRz3aqhnD2r/s2+R2u8Ib3NkJqprBkGYH2DF/gUKAplaBHE
 9iuRy9f96p1mSLDU3dbrHiCaCHJzo9+HpK8= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ey802kmu5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 08:30:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QozqAQyVZNSxsmC3/a70lwX2ceiLgCcN98fY6Aqk8sHKaLY2+ZzQgvh8zHPyAST2CCbwXMrGr6wCf8BbeJ7AXTbcSBtwi24ecwUSUO6krmH0g4U7q+hLqHtlNLhTKlOxByxj/85z1jjGllIjpY7Isi4V8hljsdHtLAXhR8EpGykhy2JHDpcSxPaAd9Ue7dDzdMmWQUTMT4hg+Kke5GdN8VWq54X4+TY83MySaodMrVEBhjGe+qgEvwDuqgqZlFdokErGDeZNcccbVsqP9iONleacxsP3r0YtZuj7IGJiFFarY8r8eebEwtL2c5rR9ZG5QZFp3GN1qQo6fN4hLV3KvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I67LnFEtBzjxN76gqCkgAKZzlMuvtaNfI8r5O15Wrmk=;
 b=TzsVeipc9687QRW7+V/3CjFonWEiJhPJjdaQY8CJ9IALp3bY55DI2e4X+d5pNMe2qJX7ZWinnyec/2Y++ZeSYqOjsQSqEMgBWnozNpF8aiXdrpY0aAmWfNMomrWOd7QOVDVYzY5MOZ5sYVe+vBrvf0Aq/2JrhUrf5WPZkW5OE4R4vDn+u/0VMsMfRUnk9b3BUlKvE9QepuLemnQMdOAbf/Vw0JxZtR17SCts3yXCan57CaHaPP3vP/qYQDhlnIOplOf4SoKu+dewn7IThLSKgHwu26rJyi8AknvIlX6HqCbeBg5iiKOqpDWy+dLF14j19gViS6tcXG8jpYzkJAAYmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by CH2PR15MB3544.namprd15.prod.outlook.com (2603:10b6:610:5::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.23; Tue, 22 Mar
 2022 15:30:35 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::20d5:ab50:fdf7:2a9a]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::20d5:ab50:fdf7:2a9a%6]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 15:30:35 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 2/4] bpf, x86: Create bpf_trace_run_ctx on the
 caller thread's stack
Thread-Topic: [PATCH bpf-next v2 2/4] bpf, x86: Create bpf_trace_run_ctx on
 the caller thread's stack
Thread-Index: AQHYOM8Kq87gJQeSQ0GNh2q/Qbcp76zKf56AgAESUIA=
Date:   Tue, 22 Mar 2022 15:30:35 +0000
Message-ID: <47c30c3f2f1a149e343252c6a84f219b552bba4f.camel@fb.com>
References: <20220316004231.1103318-1-kuifeng@fb.com>
         <20220316004231.1103318-3-kuifeng@fb.com>
         <CAEf4Bzbtcyj-ciXzJVL3QV6mbbyA_6Nec8m_8rgz190dcxH4Yg@mail.gmail.com>
In-Reply-To: <CAEf4Bzbtcyj-ciXzJVL3QV6mbbyA_6Nec8m_8rgz190dcxH4Yg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69bf60bb-2643-474c-dbe5-08da0c18e926
x-ms-traffictypediagnostic: CH2PR15MB3544:EE_
x-microsoft-antispam-prvs: <CH2PR15MB354403C888B1F7F4D2A57947CC179@CH2PR15MB3544.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Jrh1JrFi+9qX0moZvCtntqz9SWozvpKe9Cp9IwhcHyssU3J7EptIEScGlS3Rx/jOFr4Z4aUAnLdm6ww2XUOYwIjqaxPlQfgiClEi7VMrde8PENY8TuKurmcVB4Z+DapyUyFTKYbsGD/pxOrj7dkeplLmPN3NCNcuASGFGa+NkYA5BBGDulVasurozqgLb6pbU5qzVFLwQx6Gy/PJ8WAlTqodPPE2bX1Xe8bUXOVLhVXDRffXhAkcifuZFixbaBrY+3pDKbOqo3ScdRTf/zD3D/iENUnrYZwqeTKsWxVK41HCoF0dCqCGg4n9B2tsIbQlALg9bfgyaW9JLZTghZfQDvCQmbwfFYEAiJ2kRzDtevVxNMzfsBZ9OtRMcOfGshwcYR9ID1pdTgbYTLRJkQ7lleoLD/MmGSzCHzpewtje+hBoDf3X/HrJbQskJRnh754PUb2370phUxgVxsvhKjxvtyujAyKn0hscRRd4JtJf6XnIiGZ0PfZ8j/isDXdOXgXJ9YQGBJh1mLSaENyMuskrpCLxITxOh6k11/oqSj/CM7nj1w8QxiEMBOzXanl1RI3kdoZRHgZ6T7xLNit7bNoL0fKNTATQuikfaDUQ7gpXUWFSkYkJt4jGZllK0jPBNL3ZWlG/gx28kbciMa1O38JgDj1jEgjkZ3+j7mC4oDy4vexNJ5VNwga/SakE750rIcNtO3rBrywzdJ7QFjMqJ0GVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(2906002)(66946007)(38100700002)(5660300002)(4744005)(122000001)(66556008)(6916009)(2616005)(38070700005)(8936002)(6506007)(6512007)(53546011)(186003)(508600001)(64756008)(66446008)(66476007)(76116006)(4326008)(71200400001)(6486002)(91956017)(86362001)(54906003)(8676002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2lTSFRGVVpZaGllMG5hazZIVkpCaEU0WTkzZnZNN3RoSkNEVkNRNVhtdTVB?=
 =?utf-8?B?a0h3K0NWQnM4ZmZUZWFxengydVZNc0V5NUlubHdiK25TSDhodzl4MWdYNitS?=
 =?utf-8?B?U2hpYXZYbFFiMTVtdFN1NXMrQWVyM2ZFQS9xdWZ6RW40QTZ3UUEwTExMNFNk?=
 =?utf-8?B?SGVYVnBLdFJiWXlNc0Evd1ZqMzJJYWNvRHUrdGVXOG5HYVdobUNmTjc5elFE?=
 =?utf-8?B?cVMzTUp6ZUNBOFlDUkhrL0dGc2pLU20wdk5SSm1ROFc3cmJobUhOT0ZiQXhN?=
 =?utf-8?B?dkxRU2R6c2tad0RsaUJVL0ZXV1pjRlh4cmtsdjB4Z3k1Y2RGQkVVaWRsbGFS?=
 =?utf-8?B?S1VzRmZTSTdBSWNyWDUvMkFuOG4yekxad3AyRnZTdHdZWVRSL1JHT3FDaE1P?=
 =?utf-8?B?OE1jaHdtUFZzWkRGMy9YNW0yZ2RPY1RFMWNyU3NjWUREb3JNK2hWR2dPRUhF?=
 =?utf-8?B?ODJieXVQNlVBVlZVOWNiOFdDeEozUlgzVy9iZmw1UWxoWmxxSW9nWDdsNUNU?=
 =?utf-8?B?RVV5NHF1TUxhQ0s1WjIrWmNJRGJWaEFlcEVrVHJubWdJb2tEeHVLUkdpOTFO?=
 =?utf-8?B?TjNMdStNN2dOS1R1M0xTeGYzTHF3UVFHZ0wrMWwxVGRGYzlOcC9DYkFZb1hz?=
 =?utf-8?B?S0xVZGpPeVhvZ1RvM1pGYmRXVmY4MkRHVWwvWnNVVC9IMTlxclRLUWNMbkU0?=
 =?utf-8?B?aXozQlA4ZUFLU1loRzk0THBqbzJKTTlLZm1OQ1JyUFRLOTVEcEpZR0srYVEr?=
 =?utf-8?B?ZEFXUENsOXN3UDNGWmpraG1hS0lJUlFHYzBwbTIrYWxjT3ZYTzFLNHc2TFI4?=
 =?utf-8?B?cENyR2xmSWV4OHdkSHNsL3lkTVIyOWpwWnVkTVU5MjI5Wld3TjZQUTZCeWFa?=
 =?utf-8?B?NHJ3WElZWjM4cEVvQ2tMQ29LbnlkN0x4UXZkekc0R1REd1RpS2RMYWJ2eTE1?=
 =?utf-8?B?TWwvNVFXdzFWVk9RT0J5cHZSNnZ0cUdCWjhORGI1ai9JdlBZU3U1N2RVUytu?=
 =?utf-8?B?MWZ1Q0N6VmovYWZIN3FGcy80UDhBMHAweFpFQXRDY00rbzVtREdBMm9TQng3?=
 =?utf-8?B?SFFZUmdQbkIrR1RiTmtiRkhGVDdQZ3N6YWQ5VnZ2Q3FFUVdMUi8yak8zWDNW?=
 =?utf-8?B?ZzRKNUI4cHlJb09jZ3dWUlFrRHBXbmcxd2lzOWNFalREa0k2MkszWjluYkIy?=
 =?utf-8?B?QWQ5blFIQzdZZnRHL0lZd1JGbzRqSUxnMlBqSHlkU214T0ZieGJBNUpCamhp?=
 =?utf-8?B?Qks1WTNwYW1nZGs2Tmc2b2d2T0JOMkQ2YWpFQTVsZEwyWGpMaVdNa3FCQWNv?=
 =?utf-8?B?dnV2VnFSdkJmSEtXUWhKVzcwdWdqMTRPSnVaOXZXL2pQUzRFNktNS2NLd3pB?=
 =?utf-8?B?eWd6VWVhbThFRHhVWXZkWENKdVNFQ2EvTE5QamRJVVBSUWdrQWdFL1lIOG5V?=
 =?utf-8?B?ZWxJYUNmWklDdUZINEwzVkVzYVpWUG9KSndlRG1oNkpPOENYcUZuMDY2c0Rz?=
 =?utf-8?B?VXM0aUs2VkY4cTl1SFlEdU0rN2RCblNyNmtqQjVrQnN6N2xuN0g1MnAxQ3hD?=
 =?utf-8?B?N2E2dklDVFBpWjQ0YWNvU2hCNEsvWjJFcHYzOWVXMGQ5TWhjSmFKRFR5Vktz?=
 =?utf-8?B?WEx6R2Fwcllaeko5MmlDNEMxTEczR0pLRFdyNEhraXA3c2sxMmxHU3hlcTNE?=
 =?utf-8?B?L00rU0V0dVZiQ2dOUTBtL2haQ0pnanA0YWhNblZTL2Q2OTNMNlYxWXJON00r?=
 =?utf-8?B?S0ZaYW9SUTZTQncyY0phMFplelNSeitXK0dMZGdLOUpkRHdiQk4rc1lyWlcx?=
 =?utf-8?B?SkdWSm9Bdk9XdytPdUQ5aElqdkQ1aU1CQnBDS0dNdDljSDdTQUtCbDB4Yllu?=
 =?utf-8?B?ZmpWd2ZQSW9ESTJKNXRBdldZRm5haCt2T3pGc242ZFNlYnNldzBvZVd1QmpX?=
 =?utf-8?B?QVNMcGJvT0lUTmVlVUtNV0pISkw1aHFHdm1rS2lCa2swelNpU2xVWXdvb3Z4?=
 =?utf-8?Q?UMj210hBPlxkrFq331mcJgd1WAhBsI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E1F1AF2F58CA944B42EDFF4A64C8494@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69bf60bb-2643-474c-dbe5-08da0c18e926
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 15:30:35.5639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JIHEpciUPkWsqSnEDdQiIANNNUdVyH1R9szAI3CAap67QTnkH075WMlYKokyZO3s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB3544
X-Proofpoint-GUID: dd3zm976wPBY6M6AE8zEdcR_XGjgFN4p
X-Proofpoint-ORIG-GUID: dd3zm976wPBY6M6AE8zEdcR_XGjgFN4p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-22_07,2022-03-22_01,2022-02-23_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uLCAyMDIyLTAzLTIxIGF0IDE2OjA4IC0wNzAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
DQo+IE9uIFR1ZSwgTWFyIDE1LCAyMDIyIGF0IDU6NDQgUE0gS3VpLUZlbmcgTGVlIDxrdWlmZW5n
QGZiLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gQEAgLTEyOTEsNiArMTI5NCw3IEBAIHN0cnVjdCBi
cGZfY2dfcnVuX2N0eCB7DQo+ID4gwqBzdHJ1Y3QgYnBmX3RyYWNlX3J1bl9jdHggew0KPiA+IMKg
wqDCoMKgwqDCoMKgIHN0cnVjdCBicGZfcnVuX2N0eCBydW5fY3R4Ow0KPiA+IMKgwqDCoMKgwqDC
oMKgIHU2NCBicGZfY29va2llOw0KPiA+ICvCoMKgwqDCoMKgwqAgc3RydWN0IGJwZl9ydW5fY3R4
ICpzYXZlZF9ydW5fY3R4Ow0KPiA+IMKgfTsNCj4gDQo+IG9oLCBhbmQgYnBmX3RyYWNlX3J1bl9j
dHggaXMgdXNlZCBmb3Iga3Byb2JlL3Vwcm9iZS90cmFjZXBvaW50LCBsZXQncw0KPiBhZGQgYSBu
ZXcgc3RydWN0IGJwZl90cmFtcF9ydW5fY3R4IHdoaWNoIHdvdWxkIHJlZmxlY3QgdGhhdCBpdCBp
cw0KPiB1c2VkDQo+IGZvciBCUEYgdHJhbXBvbGluZS1iYXNlZCBCUEYgcHJvZ3JhbXMuIE90aGVy
d2lzZSBpdCdzIGNvbmZ1c2luZyB0bw0KPiBoYXZlIHNhdmVkX3J1bl9jdHggZm9yIGtwcm9iZSB3
aGVyZSB3ZSBkb24ndCB1c2UgdGhhdC4gU2ltaWxhcmx5LCBpZg0KPiB3ZSBtb3ZlICJzdGFydCIg
dGltZXN0YW1wLCBpdCB3aWxsIGJlIGEgYml0IG9mZi4gTm90IGVuZCBvZiB0aGUNCj4gd29ybGQs
DQo+IGJ1dCBJIHRoaW5rIGtlZXBpbmcgdGhlbSBzZXBhcmF0ZSB3b3VsZCBtYWtlIHNlbnNlIG92
ZXIgbG9uZyBydW4uDQoNCk9rIQ0KDQo=
