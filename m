Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FA458DF9A
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 21:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245444AbiHITCe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 15:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348255AbiHITBZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 15:01:25 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460082AE0D
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 11:34:10 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279DUOni014466
        for <bpf@vger.kernel.org>; Tue, 9 Aug 2022 11:34:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=4s7f+GiCQumdtBf0LUlqS//nLoksstu3pFAzzbdrEaY=;
 b=o5LAtvqQxfPBsWMic2bRJn0n7C5X6kOK/ZoDfNKMshMsLruBTI7jKWtaMy3F4WLOFlvD
 wzun9XHk/D0f48nfngPzwbexVSABIj8/4ZymL6/8KJBqjifHC9V3JdqiqWRRq4e4hH7b
 LBnPIRmFpv6TT1+8QltFscqZkOXcOqd4a94= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hu9utqbg8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 09 Aug 2022 11:34:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ce3hzeN+DqhNq98daid0zKokrasUhNCOZYdgnhFyKrmhS0owmpXsI4wR9zRWLoPUl9KINqNj4IWs/gRpwm5s1vxvictC5FK+KZok8oSeqADwxoU2+isvBcSbXGTr+9hLW525JjOHEMdGIbW+v9RFM0BqgQgEsuEXfA5zwm1Kt3wJe5r3zZr7nud7zLqRAIQIc4+DPIj4daDvs/NJpw6AkW8tVCz2bolN1b8OWlttZbdWqG7W1czAC7efMtII9cDYsqNZb8+vUtwAa4fXxBs6sGRN5UYtHeWnwykc4UUk93IjZAHIXN3Bl/+9I9kalFzXg3gM35PhJWuekCbSojK3jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4s7f+GiCQumdtBf0LUlqS//nLoksstu3pFAzzbdrEaY=;
 b=Zi0ghroYHegJIATs2XKlsNFU71lNJFfx2SA6QR6a2WWgglUaZbLm87mudxEwKVhMH2YtamU55JVdM9K5UgglgmdfeAqE2fb2OaAjbnYtN032sT0i5kKheUKo+LVuiubSs8lgUzbcdjK3zcCUaN6vigEzlECyPr/+//t5grFlsjU6WC55opMEU0NjUcPzC5jEMVM3eKTMqtrXXiVPRpPx4p8Jw78o+rDrB4qXYLfPixtIw2piNUzmfiggYTON4q4wxPtXL41NnCH2dxXkeoXp9Uo/sxiXKINnNRs/MaWRdYnIoKcs8RBJ3COJ6+WQzE8xcz26qHPgLYYoffnsthhjeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by DM6PR15MB2905.namprd15.prod.outlook.com (2603:10b6:5:139::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Tue, 9 Aug
 2022 18:34:05 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f%6]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 18:34:05 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "olsajiri@gmail.com" <olsajiri@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 0/3] Parameterize task iterators.
Thread-Topic: [PATCH bpf-next v3 0/3] Parameterize task iterators.
Thread-Index: AQHYq7qD140jjFbwrE6WtxTwqMpM6a2ms4wAgAAyMgA=
Date:   Tue, 9 Aug 2022 18:34:05 +0000
Message-ID: <5bbe63b053c7579916cf19bfcaaafe993dfd083c.camel@fb.com>
References: <20220809063501.667610-1-kuifeng@fb.com>     <YvJ+gCJ0V5hg8wLR@krava>
In-Reply-To: <YvJ+gCJ0V5hg8wLR@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 298cd733-525e-41a1-4e00-08da7a35bd4c
x-ms-traffictypediagnostic: DM6PR15MB2905:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l5ePCF4AEB8PiiYlpy5OPGQ6vX0AyKdpJPdioCL/TlhjRisPPoAgYYPlDLGnccsMHmqJBg4PLTVijJg1Jc5Tvx4Wtu9vQYRAY4xPnRWuzq/PPrpWmw8RdZRTYBbqWpYAGj/RWgVOToRhCf0/HCjTeqrlud+AyIfi5WY7mPTGlykvyoEo0Q0YgM8jWk1pHKkNa3xwQUxIOfhfahG2WdT3Dq5aURdXDXgEQaieriOHRWmRVXtxxNr4rIGLSdmMlOIjCLJkKbaGYrd/2SgUU8R2UKImka0saOrfxgOmVV7ErWTYddN92E2kmsXNdTzsLZcbOSQ8+c1Ds20XVY4p1youzmAwcd1T7Rrd3WSUHMkh4oAAqNLlHHjZF88zTyAxS+QB3ABKdpsVPBzKwEAkjx9p8vqwStlXkwjMhhz+natkTvTmL0ysDUDWa9GgDRHVQHrxem/RCPucwUut36pXhmsgQjyt8Y2LpqzrqIUVcIUMRKitge7dKITW5ESlpTvYQb44+PU8YfKrEGR1FeijmFyFGb6E9QeLiuIdk4LXlBuQsZ/gxuotOEY5uyLHGJwzOQ05gV/E9Xt0/oxhd1SEnGrzFdifyMch8ovWuhjMOtGFjEJKPvoIbupZX9CDxibIlLvn0GFxErTG6gtQtSPivZVe9LO9GIF+Zj0hlU7L6Pp/vpIjapkbEAJcp3CZoXdl8h3TxdB4wvNZugtwtvX4L9IOwNW9J4XYf+kmYftlf2QV2nR9ggv40UkB6vjTMxiUswFt1l0rKnLxjsCJkKc5R7NXclIBaUiL31leqgYl0iV4SF9PMID9cgKfBXWRmz2VkXdZI486RuMnkFf5geyNPFfxM4dS0Tg+ef7gmIKDTPkcGitZvqg5edZjYUkB6vf0Jon/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(76116006)(66946007)(122000001)(66476007)(66556008)(8936002)(4326008)(64756008)(38070700005)(8676002)(38100700002)(66446008)(5660300002)(478600001)(41300700001)(186003)(6506007)(6512007)(71200400001)(316002)(2906002)(6916009)(54906003)(966005)(6486002)(36756003)(83380400001)(2616005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmsrMDk2Sjk4TXNJMzN0V2c1am5qRTB1YllzR0JBS0NlUXVaRVFsSjVSY3Va?=
 =?utf-8?B?d2syM0tFdWovb1hmcDR3bU9IM0FRSjRndnI4SG9FZlpWVW9nQkNIQS90VlpS?=
 =?utf-8?B?Wmo0M1AzZ0F1YjZxK0gxUjNsSnRnd1FkTkt0ZHZHSjU3NHhLZUViQU5OUmhH?=
 =?utf-8?B?aVhEZVpDQk13bHhJSkVINXFhcHdDWm1OU0hSdk16UHdOUVRWc1dnMlhWaW5v?=
 =?utf-8?B?VkE3MmxFdUZvOE9PcDRwYnd0SXM1cS90R25WZFNFZFpsMUZCekVGVXZNZ3NS?=
 =?utf-8?B?Q09tZGllMTFkbVpwVVhqM1N1a1N4aUd4NHJSVDhFdUlmQjEvcFpUTURzenhi?=
 =?utf-8?B?MnQrSVNnOHR5M2tKVHpqSmh4anY2OTg2VHZjOGNyeDBKKzNHelUyeGNXcEt1?=
 =?utf-8?B?WlVSQThMQmpZQVEycStZbER6TmlTeGtCOGR5VXI4bjlsU2VyaVZQeG5UV3Z5?=
 =?utf-8?B?S0htQ29JRWVOZm5IL2JCem9zRHEra3JqbFBUOUE3aS9SejlKa2IxQmpGbEJj?=
 =?utf-8?B?bTFGOWswS0FzVTlNRldUR1pvUTR6QkU0TURCekdmcy8ybHJkZlFPOHI2S1o5?=
 =?utf-8?B?THdndDM2Tkc3Rm5XWHdZTHZGMGQwcnIva2JVTmtIQXZWT3RMb1JsVHNRdWpu?=
 =?utf-8?B?QUVIVFk0eExaa09peGdZeDM5TFEra1J1TTROcHM4NGNweUdXNHNHWDlYVkkw?=
 =?utf-8?B?VGpGSm0xMkVRN1B6NXhFN2NrMnVEbXZvK2RyNkRKalpDK09YMWY2Mno5Nk1K?=
 =?utf-8?B?V3BXa21YYitURUpNUXRhT2xBQitJeHhPeCt2cXI1Y1RHWm1leldvVUpDaXdW?=
 =?utf-8?B?Vno1bjFDcDY0OENLNkRpSkV5cDFnUGtQN0oyRkFMR2Q0aGVDSTBqZDVNYmMv?=
 =?utf-8?B?QWxKQS96bXpaV20xczVnVmNKU0xZK0dsc1JUeXdCOHRBV0xoSlgxd2hFY1Ny?=
 =?utf-8?B?WUpvWkFzM0htZEpuYUx0a0NZN3hScWRkMnREOW1EKzM0TmtRMU83YWVZd0pH?=
 =?utf-8?B?Nkw1ZmZ2eGFiRzViOHBOZFZVbDJJTjFIYm12UzVLdDJYMFhaZjhRUmI3NmZL?=
 =?utf-8?B?Ri9EOEh5dHlRMjVDMU5EZ1V0aG0zNWI5Z1BEOEEyOWdPTHpoNVVIck51QU1v?=
 =?utf-8?B?QmhBWjNKR0FSc20zTVlxd2VIZVh0MnFkRzkzUmRiOWV5dEw0UGZWcHF6VzIr?=
 =?utf-8?B?OUlFK3ppSW5ySGRBenB3M3NMeDVIeTNmem9CZDFDN0R2alBTaGphSU9kaFNp?=
 =?utf-8?B?UWgrRldSUExzZURyaGQ3c1JkVFBsWWFmTVNzUllSRllnTzgzR095OFdETGRV?=
 =?utf-8?B?M0sxeTFyZmNHajQ3V2MvWHUzQWFPd3BacG42cGl0cm1sYkpSTHZncU9ITnB2?=
 =?utf-8?B?Tnd6dUs4b0QweEUzWFM4b1lVWUJ3TkVsaTF1blpLNDBSZFdvSEZUT0xEQVpF?=
 =?utf-8?B?V2c4YnpySnJpampmeWZpS2RXOTZBOVVmZXY4MTJLaWhXNmtvOUY1QmpGTWYr?=
 =?utf-8?B?UGREMklqSDRnYnREWDczQktsVnMwUGFVcXdoc0RrTG9DdVJNbTdFSE9wUWJv?=
 =?utf-8?B?VHRzUktRWHAxSzlkd3FmY3JRQVRERWwyYStlRFN0dFgxUUEzbk1IZEZyZllS?=
 =?utf-8?B?WHhEbzN0d29Na1pocnBjY3dtb1I2WHdnVDBNYTdjWDBDY0hyQzhpSFNaSWox?=
 =?utf-8?B?NFA5TXRyNlVXS3BRWDBWRFBteTVmZ1NiT2ZWNUY0b1VqL2YzdEwraW5XK2xz?=
 =?utf-8?B?WkdaSE5UUnNyTEUwVWZySlFiWjRFdDY3MlQ3cHN3RG1SSHZsd0Nlb1ZkenJy?=
 =?utf-8?B?d1Z0cTZmRzBTTmQxS0FtdldCd2xsVmFjYXExcmRNR1lUS296SERGeVA1SnhK?=
 =?utf-8?B?aER4NCtGZU14VFZNT0RQYWNRalRNd0N1djU1eS9OZUNPVm9DeTF6S0t1Y2M2?=
 =?utf-8?B?ZEZzZVAwVUI1TUZVeURJZGhabkRQcC9FbWhJaUhuQ1BERFhGSXEzdDBxY3RF?=
 =?utf-8?B?VnhMNnNySktXUkMrSyt1aXdxOU9wdTBQMHlQR2Fvbmt1bEF1VGJ2c0hrWk1R?=
 =?utf-8?B?MFVlMGJ0SldpbXVyZVo4aGdyajFrWW1DakhvTVVML2xIZjlxTE95cWorbHMx?=
 =?utf-8?B?UWF5d0M3YkI5QmM4eVE1NmFucDhJV3RrV05BNzVpUFhocEdjUTh3S21wYTVp?=
 =?utf-8?B?WHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D47875463343E41A2F18CB0DC06E8A4@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 298cd733-525e-41a1-4e00-08da7a35bd4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 18:34:05.3940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: reQBZne5LSbMVPGr0ZfZ+iNVPu4kdTu8zzQkGng9QhH6nvFZuyT9bCje7j/yo3P3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2905
X-Proofpoint-GUID: dfBqRtde_EM2S0HETEbtMPjFXs_4Yp1X
X-Proofpoint-ORIG-GUID: dfBqRtde_EM2S0HETEbtMPjFXs_4Yp1X
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVHVlLCAyMDIyLTA4LTA5IGF0IDE3OjM0ICswMjAwLCBKaXJpIE9sc2Egd3JvdGU6DQo+IE9u
IE1vbiwgQXVnIDA4LCAyMDIyIGF0IDExOjM0OjU4UE0gLTA3MDAsIEt1aS1GZW5nIExlZSB3cm90
ZToNCj4gPiBBbGxvdyBjcmVhdGluZyBhbiBpdGVyYXRvciB0aGF0IGxvb3BzIHRocm91Z2ggcmVz
b3VyY2VzIG9mIG9uZQ0KPiA+IHRhc2svdGhyZWFkLg0KPiA+IA0KPiA+IFBlb3BsZSBjb3VsZCBv
bmx5IGNyZWF0ZSBpdGVyYXRvcnMgdG8gbG9vcCB0aHJvdWdoIGFsbCByZXNvdXJjZXMgb2YNCj4g
PiBmaWxlcywgdm1hLCBhbmQgdGFza3MgaW4gdGhlIHN5c3RlbSwgZXZlbiB0aG91Z2ggdGhleSB3
ZXJlDQo+ID4gaW50ZXJlc3RlZCBpbiBvbmx5IHRoZQ0KPiA+IHJlc291cmNlcyBvZiBhIHNwZWNp
ZmljIHRhc2sgb3IgcHJvY2Vzcy7CoCBQYXNzaW5nIHRoZSBhZGRpbnRpb25hbA0KPiA+IHBhcmFt
ZXRlcnMsIHBlb3BsZSBjYW4gbm93IGNyZWF0ZSBhbiBpdGVyYXRvciB0byBnbyB0aHJvdWdoIGFs
bA0KPiA+IHJlc291cmNlcyBvciBvbmx5IHRoZSByZXNvdXJjZXMgb2YgYSB0YXNrLg0KPiA+IA0K
PiA+IE1ham9yIENoYW5nZXM6DQo+ID4gDQo+ID4gwqAtIEFkZCBuZXcgcGFyYW1ldGVycyBpbiBi
cGZfaXRlcl9saW5rX2luZm8gdG8gaW5kaWNhdGUgdG8gZ28NCj4gPiB0aHJvdWdoDQo+ID4gwqDC
oCBhbGwgdGFza3Mgb3IgdG8gZ28gdGhyb3VnaCBhIHNwZWNpZmljIHRhc2suDQo+ID4gDQo+ID4g
wqAtIENoYW5nZSB0aGUgaW1wbGVtZW50YXRpb25zIG9mIEJQRiBpdGVyYXRvcnMgb2Ygdm1hLCBm
aWxlcywgYW5kDQo+ID4gwqDCoCB0YXNrcyB0byBhbGxvdyBnb2luZyB0aHJvdWdoIG9ubHkgdGhl
IHJlc291cmNlcyBvZiBhIHNwZWNpZmljDQo+ID4gdGFzay4NCj4gPiANCj4gPiDCoC0gUHJvdmlk
ZSB0aGUgYXJndW1lbnRzIG9mIHBhcmFtZXRlcml6ZWQgdGFzayBpdGVyYXRvcnMgaW4NCj4gPiDC
oMKgIGJwZl9saW5rX2luZm8uDQo+ID4gDQo+ID4gRGlmZmVyZW5jZXMgZnJvbSB2MjoNCj4gPiAN
Cj4gPiDCoC0gU3VwcG9ydHMgdGlkLCB0Z2lkLCBhbmQgcGlkZmQuDQo+ID4gDQo+ID4gwqAtIENo
YW5nZSAndHlwZScgZnJvbSBfX3U4IHRvIGVudW0gYnBmX3Rhc2tfaXRlcl90eXBlLg0KPiANCj4g
aGksDQo+IEknbSBnZXR0aW5nIHRlc3QgZmFpbDoNCj4gDQo+IHRlc3RfdGFza186UEFTUzpicGZf
aXRlcl90YXNrX19vcGVuX2FuZF9sb2FkIDAgbnNlYw0KPiB0ZXN0X3Rhc2tfOlBBU1M6cHRocmVh
ZF9tdXRleF9pbml0IDAgbnNlYw0KPiB0ZXN0X3Rhc2tfOlBBU1M6cHRocmVhZF9tdXRleF9sb2Nr
IDAgbnNlYw0KPiB0ZXN0X3Rhc2tfOlBBU1M6cHRocmVhZF9jcmVhdGUgMCBuc2VjDQo+IGRvX2R1
bW15X3JlYWQ6UEFTUzphdHRhY2hfaXRlciAwIG5zZWMNCj4gZG9fZHVtbXlfcmVhZDpQQVNTOmNy
ZWF0ZV9pdGVyIDAgbnNlYw0KPiBkb19kdW1teV9yZWFkOlBBU1M6cmVhZCAwIG5zZWMNCj4gdGVz
dF90YXNrXzpQQVNTOnB0aHJlYWRfbXV0ZXhfdW5sb2NrIDAgbnNlYw0KPiB0ZXN0X3Rhc2tfOkZB
SUw6Y2hlY2tfbnVtX3Vua25vd25fdGlkIHVuZXhwZWN0ZWQNCj4gY2hlY2tfbnVtX3Vua25vd25f
dGlkOiBhY3R1YWwgMCAhPSBleHBlY3RlZCAxDQo+IHRlc3RfdGFza186UEFTUzpjaGVja19udW1f
a25vd25fdGlkIDAgbnNlYw0KPiB0ZXN0X3Rhc2tfOlBBU1M6cHRocmVhZF9qb2luIDAgbnNlYw0K
PiB0ZXN0X3Rhc2tfOlBBU1M6YnBmX2l0ZXJfdGFza19fb3Blbl9hbmRfbG9hZCAwIG5zZWMNCj4g
dGVzdF90YXNrXzpQQVNTOnB0aHJlYWRfbXV0ZXhfaW5pdCAwIG5zZWMNCj4gdGVzdF90YXNrXzpQ
QVNTOnB0aHJlYWRfbXV0ZXhfbG9jayAwIG5zZWMNCj4gdGVzdF90YXNrXzpQQVNTOnB0aHJlYWRf
Y3JlYXRlIDAgbnNlYw0KPiBkb19kdW1teV9yZWFkOlBBU1M6YXR0YWNoX2l0ZXIgMCBuc2VjDQo+
IGRvX2R1bW15X3JlYWQ6UEFTUzpjcmVhdGVfaXRlciAwIG5zZWMNCj4gZG9fZHVtbXlfcmVhZDpQ
QVNTOnJlYWQgMCBuc2VjDQo+IHRlc3RfdGFza186UEFTUzpwdGhyZWFkX211dGV4X3VubG9jayAw
IG5zZWMNCj4gdGVzdF90YXNrXzpGQUlMOmNoZWNrX251bV91bmtub3duX3RpZCB1bmV4cGVjdGVk
DQo+IGNoZWNrX251bV91bmtub3duX3RpZDogYWN0dWFsIDEzNCAhPSBleHBlY3RlZCAxDQo+IHRl
c3RfdGFza186UEFTUzpjaGVja19udW1fa25vd25fdGlkIDAgbnNlYw0KPiB0ZXN0X3Rhc2tfOlBB
U1M6cHRocmVhZF9qb2luIDAgbnNlYw0KPiAjMTAvNcKgwqDCoCBicGZfaXRlci90YXNrOkZBSUwN
Cg0KU29ycnkhICBJIHdpbGwgcmVzZW50IGEgY29ycmVjdCB2ZXJzaW9uIG9mIHNlbGZ0ZXN0cyBB
U0FQLg0KDQo+IA0KPiBqaXJrYQ0KPiANCj4gPiANCj4gPiB2MjoNCj4gPiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9icGYvMjAyMjA4MDEyMzI2NDkuMjMwNjYxNC0xLWt1aWZlbmdAZmIuY29tLw0K
PiA+IHYxOg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2JwZi8yMDIyMDcyNjA1MTcxMy44
NDA0MzEtMS1rdWlmZW5nQGZiLmNvbS8NCj4gPiANCj4gPiBLdWktRmVuZyBMZWUgKDMpOg0KPiA+
IMKgIGJwZjogUGFyYW1ldGVyaXplIHRhc2sgaXRlcmF0b3JzLg0KPiA+IMKgIGJwZjogSGFuZGxl
IGJwZl9saW5rX2luZm8gZm9yIHRoZSBwYXJhbWV0ZXJpemVkIHRhc2sgQlBGDQo+ID4gaXRlcmF0
b3JzLg0KPiA+IMKgIHNlbGZ0ZXN0cy9icGY6IFRlc3QgcGFyYW1ldGVyaXplZCB0YXNrIEJQRiBp
dGVyYXRvcnMuDQo+ID4gDQo+ID4gwqBpbmNsdWRlL2xpbnV4L2JwZi5owqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA4ICsNCj4gPiDCoGlu
Y2x1ZGUvdWFwaS9saW51eC9icGYuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8wqAgNDMgKysrDQo+ID4gwqBrZXJuZWwvYnBmL3Rhc2tfaXRlci5jwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE1MyArKysrKysrKystLQ0K
PiA+IMKgdG9vbHMvaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5owqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHzCoCA0MyArKysNCj4gPiDCoC4uLi9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMv
YnBmX2l0ZXIuY8KgwqDCoMKgwqDCoCB8IDI1MQ0KPiA+ICsrKysrKysrKysrKysrKystLQ0KPiA+
IMKgLi4uL3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy9idGZfZHVtcC5jwqDCoMKgwqDCoMKgIHzC
oMKgIDIgKy0NCj4gPiDCoC4uLi9zZWxmdGVzdHMvYnBmL3Byb2dzL2JwZl9pdGVyX3Rhc2suY8Kg
wqDCoMKgwqDCoCB8wqDCoCA5ICsNCj4gPiDCoC4uLi9zZWxmdGVzdHMvYnBmL3Byb2dzL2JwZl9p
dGVyX3Rhc2tfZmlsZS5jwqAgfMKgwqAgNyArDQo+ID4gwqAuLi4vc2VsZnRlc3RzL2JwZi9wcm9n
cy9icGZfaXRlcl90YXNrX3ZtYS5jwqDCoCB8wqDCoCA2ICstDQo+ID4gwqA5IGZpbGVzIGNoYW5n
ZWQsIDQ3NCBpbnNlcnRpb25zKCspLCA0OCBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiAtLSANCj4g
PiAyLjMwLjINCj4gPiANCg0K
