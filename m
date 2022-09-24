Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87FF5E86D1
	for <lists+bpf@lfdr.de>; Sat, 24 Sep 2022 02:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiIXAv6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 20:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiIXAv5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 20:51:57 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E05E5FB1
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 17:51:56 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28NM9283031690
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 17:51:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=wxo9nmUw6llv/+34feQOVz8gPsxhycg8m1mtttqUc3c=;
 b=PxwWhRk/j9F3kuodpJT6HSdDnGP6Xy/444Pw5sF/bLvn1Sul7lBSKrn51ll0q6jA8cPa
 BOW7Fef5H5hIk/xu1UvgugAxOeZRKrGo3tGYwjaY4em6qHmQ+j82zvCnBc+5YUW91Oi9
 T3TePKAQcbvHsrH6THSeVkVwwfzv50cn8/g= 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3js7mxegcv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 17:51:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAyjmgXL7Q9M6nvDrJ/KSP/GQbc91Vs5amhJpgFMm2n7Iz8t0HM13sIOti0ih6cp3WB+lZrr8XgY/Hx0tZ4JxhKsZy5vzpfJp7L7+gz4bG/2uhuoTSSBxdGK9e14VSVWPZU2FffA5b+7aEGzS4kvythujhXa+sIvqQ+X8FKd8finYjKFC6S0az/NmiPCZZD3Ni6nk29tpHIWh/KWrZ8inu09etXrPjeQymNx8U8sLNmw3FHgx6i31/51wSQegQiSZB/9eXpNllZSwj0sCwnGPq3LVPwgpLle7VndD0jn3kmfKh02OZGo0fO+H0TYE4r4B5azAn8Awrdi+p/WAAsPgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxo9nmUw6llv/+34feQOVz8gPsxhycg8m1mtttqUc3c=;
 b=G4Qp96hrhSy/OF4q6sMqsVOL32kap024zxFy8SRyObTi8FbxJLF1qsH6zTlwOOPeqi009vG02Am6eFL9nQpAs2k8FhHi1ZLapqwhhHwz4zVoM2dhKfPAktcoa1q98ecEhJkkts+EwoWCRYPmcGFX5vQmohtM6+Eu6/5AuH4WJ2sKp9QJzXpJNU/pRJ92pFukwK64zoak5Mf2t1P6sETPhrG4KkQAlXoO24xSRE4QKg2u6pWTc9kEC1CGW1FSxygbHV41r6x31WgFtlnUx0uYx/nOlmSdPORYYlNyTLKfV5Gdqk3feHgRc6OxcgatqwJP3UES9g59fSsnCYFEoK1GOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SN6PR1501MB1968.namprd15.prod.outlook.com (2603:10b6:805:4::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Sat, 24 Sep
 2022 00:51:52 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537%7]) with mapi id 15.20.5654.020; Sat, 24 Sep 2022
 00:51:52 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kernel Team <Kernel-team@fb.com>, Hao Luo <haoluo@google.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: use bpf_prog_pack for bpf_dispatcher
Thread-Topic: [PATCH bpf-next 1/2] bpf: use bpf_prog_pack for bpf_dispatcher
Thread-Index: AQHYz5IaSevvmeP4LEWNGRKKbbYINq3tkLWAgAAVygCAAAFwgIAAGJeA
Date:   Sat, 24 Sep 2022 00:51:52 +0000
Message-ID: <C324732A-58BE-4E2D-9C81-A3F8696FB150@fb.com>
References: <20220923211837.3044723-1-song@kernel.org>
 <20220923211837.3044723-2-song@kernel.org>
 <CAADnVQKgvtt+aLpNQ2OFf5HXqyTePS5=9efRY14fMViayBLNwQ@mail.gmail.com>
 <37C7A6C4-33C6-42EC-8BEC-E6D70AB0774A@fb.com>
 <CAADnVQKxgCgL+09MX3N74rJsdrPRBAM8U2ZPYgZhxzNs54=n+A@mail.gmail.com>
In-Reply-To: <CAADnVQKxgCgL+09MX3N74rJsdrPRBAM8U2ZPYgZhxzNs54=n+A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SN6PR1501MB1968:EE_
x-ms-office365-filtering-correlation-id: 212900ee-6c63-4f32-ed04-08da9dc6f889
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wZiB5Obt068mBQH5JDyqrWCICM6PTwmZzbRzHkqMN/wzBlPT7ZeGvAzOfULu2osoUHHwvVnS+LlbY6hnrNIoIukMtBvIyRM2VlwBKV8DodLc4QyaFwbfX7plwk72ZRPYFJ2oKmYd4R7J9zs0wnd4TLCe1FfWHSYAGmMabgM/KUH+Gv/5hXZozzLpLehEAaE15fMpB1b5sapOvfAzrz79Otm6LWYLjwk/qXvhPwwu+BukwUZMOzImGmZdvamRDxfmfIvwNznEZvSYfcVzbuqdxAJIyAJMXPCsM3wUmM0AqHWR4lWeK5D8y+O8whxLaiC+sPVckvXebPe8bFI544+S68C3YUvs2zcZFqa5kBx3JkdkaQ79CI2clNl/xbtc+bfxh1+qqQuKMzymI7Kx5FJ40kZQ81Kb/KPg4qvk3CH3R3jkJdxtgXqirsUoxNy/zzhxKsNdInO39IwMUca90gWfVZhiYiPsZTbrEMi5lT1bO9bypHKM58REN59SVS12JTdBvtFMaWmDw0i9shPagHcqfdTz2rUJeomWrvP/ZP9wxx3AJ/tLQ7Nth8NyfcWox1ubJg9inNtKdQbNRKnq+jnC0KegAAkv2gPrlxxMoLf8WyIPWA1TXQ6menjJpsOIkSg9WyRzCr744LnCCeGLHme+Xf3diZ1XYlhqmp5fAlriXs6lPyF30T3HL7XenqQ5vAsuRyuwk09+o/OgVYS0GbDScOqOOHFTOpPZ7bF70bkjxvQA9qSqlHTg0jWUdtekeKF0fXhJ7aAHpARNocP0zfP+pUd9k/q59dCVF2j9L8EFtmE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(53546011)(38070700005)(6506007)(2616005)(6512007)(36756003)(186003)(316002)(478600001)(71200400001)(6486002)(122000001)(6916009)(86362001)(66574015)(33656002)(38100700002)(83380400001)(54906003)(5660300002)(2906002)(91956017)(64756008)(66946007)(41300700001)(8676002)(66446008)(66476007)(4326008)(66556008)(76116006)(7416002)(8936002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WThSa1RWL2lPSGRmVC9lUnk2akZYUWdjeWJzbFNqL0J5eHJNblAzZ2ZtN3Vz?=
 =?utf-8?B?OU80U3VIUkxQZi9yUnRrOTRzWHBKMEVrS1RDaTVlTUhtd1BoS1NRY2JOMjFH?=
 =?utf-8?B?YXFKMUFNR1prbVR2QkNQUnJLVFlxMklvckk0TXBCUDZEM251d242anNmV3NI?=
 =?utf-8?B?L09QQnZBOEozdTdFekhtZk4xMnRSL3BYUGlYNUUzMEk0eDA1SXIvY2NpU296?=
 =?utf-8?B?WENIc1I2dElEWHhUSklFRDdQYWpDMGVIRFFobStmdEJaRys2NVNpdHBERXNm?=
 =?utf-8?B?bXJOeStGcHJUcUxJVU5ibFNGZDkySFdCNXRpL2haWXJhWGFnMU5WVDVDcWRm?=
 =?utf-8?B?VFhJdEREcFZGUVdBQ2hsN0tnaDhzWThTelMyRTJnenpYS3dpM29qY2NEK0xy?=
 =?utf-8?B?V08zeWxvTXhWaSsrR25pZEYyNnQweDVCVUhSUUlTT2h5UlovUmZmUzdWUWtO?=
 =?utf-8?B?R1dGVXBNWXZJTVBOaWVTZzgvK0NkRFhEVWJrSVhiUklrTTVVVVVyK1NrUHI1?=
 =?utf-8?B?aG40MlhueWdUYy81SEdob05IbTBRa01iRkh5SStYbmVEQk90TU1pejhnbVlk?=
 =?utf-8?B?QXRMZG02b0J4Wmw0cnJJYmpSZVRvaXhrc3p5ME5nanpJbDM2SVJ1OG5DZHUv?=
 =?utf-8?B?NHhoQVpOZEtDUUE0bHF5QWVpS1pGbzJ4Nk9MQ3Z6UzNYT2YxSFowUDNTMzJO?=
 =?utf-8?B?amk5MndQeUViTW1lMXBDS01sbzVabG1JWEJ2b3hXeS83WStmMzVQS0NIOEJv?=
 =?utf-8?B?c1NQT095S2ZlaVExSjZaN0VIN1B4THBySnlET1RDbHpVWWJ0anlIbDZldjhQ?=
 =?utf-8?B?UXdVbllKTFhMME5haXRxRjdsY2RYQzcwN1VmVXhseWl4N05wMVRPb3Fla2xi?=
 =?utf-8?B?RmlXY2FzMnJDSFVGM2tNUlFMVzFaODNZbXF5YnM4QlZkWkNsc2luRDJheVZO?=
 =?utf-8?B?RmVweGpkMXZxUlZ5OWNIODE1QUpnNHJTeE8xUXBUcFgrWGR3bXJ2ajVmY3JM?=
 =?utf-8?B?czNpaGhtMlJzVFp5YmliNy9DS210VnVSUDRpcDdZQWRHS1FvYkp3d2U4OTFK?=
 =?utf-8?B?dy96UFNLRDlCUC82VU1DTm5NWnVySVZ2VVZUTUQ4ZmhiK1d3eFRxUG4wWndj?=
 =?utf-8?B?cGc2VnRoZFE4blBYSWY1YWJycFN6OXJVZ1FhRVQycHVuSmFmTTlYVVo4dVJO?=
 =?utf-8?B?alcvY3ZNd0paNDI5eHVmUkw4UHdCYThSbXBYNUwvMFNqMlRpLzU5Z2RVVmtp?=
 =?utf-8?B?THNGRXExTms4eDFrVkJGTlRtZ3FmMGV5ekVnRE5pTERrQ1NsdldKV3IrTUQ1?=
 =?utf-8?B?Vm55SXFpM0x5bXBKQXA2d3p0MllmNE11WDJKSFdwaEplb3VLUjZQWUJqS2VB?=
 =?utf-8?B?N3FEL0p6dEFCeldyTWNHcVlId2I5VGpxTndLekIwOEl4VnZHYThXa1pjVGkx?=
 =?utf-8?B?VUQxeGVLRnFtVkdlMWFCUU5wVVFjMzRsVkJmWXVQTFd6UXVMV0ZlaWxKQ3Vx?=
 =?utf-8?B?ajFoSjZzMHhkelFGM0FJcXhZSXJoWFZ1dlFVOGFIUDE0aUl5MGl3eEwyRWhi?=
 =?utf-8?B?bjhHbkQ2SEIxTmMxY2ppM09FRFVheE5vOGlGeUh3dTZhdCtxb0RNYkRzTFpI?=
 =?utf-8?B?M3dLOWtQbHFuY2tXSkQvU3JqMHYweUNnZmY4eEMyMm9LSHppTjV3RzVoeDB4?=
 =?utf-8?B?elExNERINlpnNHRjZVFVZ0xSTUN0Z3FOeUpUMnFXT0NuSnBVMmNLQ2o1d1h4?=
 =?utf-8?B?bVIvL1ZDcmllRTF2bE4vL3NEaE9OUFZGVnkwOUhMM1E0VkZyTTVObzRscVJy?=
 =?utf-8?B?TDZULy9RR0lYVWVFTFo5d1hpNjQ1b29DSHoxdHhKbENMRkQ5bWNiUVI5SEg2?=
 =?utf-8?B?MDRuT1B1WmxXaGpSaHdwL3UwN2FLU3ZnUmpKMEhINjJ3ellYSEhDYlZxUHJs?=
 =?utf-8?B?YytiSENwY1lOcUhmaEN5THA1Rm1lNkhtajk4czNudXpUejJuNWg4ajdSR0VF?=
 =?utf-8?B?UEZzekJORGpKS0xNYkpYUGhlTWQ5OW5MQTRtdnJGUnNTS1lGVU1UQ3ZsMkt0?=
 =?utf-8?B?ZWxqbE9ZQnB0U3RRQVUydllhNm9yZ2RjZGNpUEhjVFFtK2RKK0NEbHRpMUUz?=
 =?utf-8?B?K1BBNng0aUlNSC9uZkdKckw0UXg0NzhhcFcwNWRxdy90QWVhN1pUUXNERWdK?=
 =?utf-8?Q?4wNuvlzexa+Ti466hGO7Th4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE26CDD463E01F4A98081A09F57FFD2B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 212900ee-6c63-4f32-ed04-08da9dc6f889
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2022 00:51:52.4595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: quQBEDmDvIL4nnTFsAZC2slN203EvMfu4asEnYQP2gifCFCtx3oFN60oUAQHHZ5QG356eLFsr6/kIdgNk4SmZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB1968
X-Proofpoint-ORIG-GUID: Lh-4sr-3r7pSjD7msguV1rQ_83FO-wfN
X-Proofpoint-GUID: Lh-4sr-3r7pSjD7msguV1rQ_83FO-wfN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_11,2022-09-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCj4gT24gU2VwIDIzLCAyMDIyLCBhdCA0OjIzIFBNLCBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFs
ZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gRnJpLCBTZXAgMjMs
IDIwMjIgYXQgNDoxOCBQTSBTb25nIExpdSA8c29uZ2xpdWJyYXZpbmdAZmIuY29tPiB3cm90ZToN
Cj4+IA0KPj4gKyBCasO2cm4gVMO2cGVsDQo+PiANCj4+PiBPbiBTZXAgMjMsIDIwMjIsIGF0IDM6
MDAgUE0sIEFsZXhlaSBTdGFyb3ZvaXRvdiA8YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4g
d3JvdGU6DQo+Pj4gDQo+Pj4gT24gRnJpLCBTZXAgMjMsIDIwMjIgYXQgMjoxOCBQTSBTb25nIExp
dSA8c29uZ0BrZXJuZWwub3JnPiB3cm90ZToNCj4+Pj4gDQo+Pj4+IEFsbG9jYXRlIGJwZl9kaXNw
YXRjaGVyIHdpdGggYnBmX3Byb2dfcGFja19hbGxvYyBzbyB0aGF0IGJwZl9kaXNwYXRjaGVyDQo+
Pj4+IGNhbiBzaGFyZSBwYWdlcyB3aXRoIGJwZiBwcm9ncmFtcy4NCj4+Pj4gDQo+Pj4+IFRoaXMg
YWxzbyBmaXhlcyBDUEEgV15YIHdhcm5uaW5nIGxpa2U6DQo+Pj4+IA0KPj4+PiBDUEEgcmVmdXNl
IFdeWCB2aW9sYXRpb246IDgwMDAwMDAwMDAwMDAxNjMgLT4gMDAwMDAwMDAwMDAwMDE2MyByYW5n
ZTogLi4uDQo+Pj4+IA0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBTb25nIExpdSA8c29uZ0BrZXJuZWwu
b3JnPg0KPj4+PiAtLS0NCj4+Pj4gaW5jbHVkZS9saW51eC9icGYuaCAgICAgfCAgMSArDQo+Pj4+
IGluY2x1ZGUvbGludXgvZmlsdGVyLmggIHwgIDUgKysrKysNCj4+Pj4ga2VybmVsL2JwZi9jb3Jl
LmMgICAgICAgfCAgOSArKysrKysrLS0NCj4+Pj4ga2VybmVsL2JwZi9kaXNwYXRjaGVyLmMgfCAy
MSArKysrKysrKysrKysrKysrKystLS0NCj4+Pj4gNCBmaWxlcyBjaGFuZ2VkLCAzMSBpbnNlcnRp
b25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPj4+PiANCj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGludXgvYnBmLmggYi9pbmNsdWRlL2xpbnV4L2JwZi5oDQo+Pj4+IGluZGV4IGVkZDQzZWRiMjdk
Ni4uYThkMGNmZTE0MzcyIDEwMDY0NA0KPj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2JwZi5oDQo+
Pj4+ICsrKyBiL2luY2x1ZGUvbGludXgvYnBmLmgNCj4+Pj4gQEAgLTk0Niw2ICs5NDYsNyBAQCBz
dHJ1Y3QgYnBmX2Rpc3BhdGNoZXIgew0KPj4+PiAgICAgICBzdHJ1Y3QgYnBmX2Rpc3BhdGNoZXJf
cHJvZyBwcm9nc1tCUEZfRElTUEFUQ0hFUl9NQVhdOw0KPj4+PiAgICAgICBpbnQgbnVtX3Byb2dz
Ow0KPj4+PiAgICAgICB2b2lkICppbWFnZTsNCj4+Pj4gKyAgICAgICB2b2lkICpyd19pbWFnZTsN
Cj4+Pj4gICAgICAgdTMyIGltYWdlX29mZjsNCj4+Pj4gICAgICAgc3RydWN0IGJwZl9rc3ltIGtz
eW07DQo+Pj4+IH07DQo+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2ZpbHRlci5oIGIv
aW5jbHVkZS9saW51eC9maWx0ZXIuaA0KPj4+PiBpbmRleCA5OGUyODEyNmMyNGIuLmVmYzQyYTZl
M2FlZCAxMDA2NDQNCj4+Pj4gLS0tIGEvaW5jbHVkZS9saW51eC9maWx0ZXIuaA0KPj4+PiArKysg
Yi9pbmNsdWRlL2xpbnV4L2ZpbHRlci5oDQo+Pj4+IEBAIC0xMDIzLDYgKzEwMjMsOCBAQCBleHRl
cm4gbG9uZyBicGZfaml0X2xpbWl0X21heDsNCj4+Pj4gDQo+Pj4+IHR5cGVkZWYgdm9pZCAoKmJw
Zl9qaXRfZmlsbF9ob2xlX3QpKHZvaWQgKmFyZWEsIHVuc2lnbmVkIGludCBzaXplKTsNCj4+Pj4g
DQo+Pj4+ICt2b2lkIGJwZl9qaXRfZmlsbF9ob2xlX3dpdGhfemVybyh2b2lkICphcmVhLCB1bnNp
Z25lZCBpbnQgc2l6ZSk7DQo+Pj4+ICsNCj4+Pj4gc3RydWN0IGJwZl9iaW5hcnlfaGVhZGVyICoN
Cj4+Pj4gYnBmX2ppdF9iaW5hcnlfYWxsb2ModW5zaWduZWQgaW50IHByb2dsZW4sIHU4ICoqaW1h
Z2VfcHRyLA0KPj4+PiAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IGFsaWdubWVudCwN
Cj4+Pj4gQEAgLTEwMzUsNiArMTAzNyw5IEBAIHZvaWQgYnBmX2ppdF9mcmVlKHN0cnVjdCBicGZf
cHJvZyAqZnApOw0KPj4+PiBzdHJ1Y3QgYnBmX2JpbmFyeV9oZWFkZXIgKg0KPj4+PiBicGZfaml0
X2JpbmFyeV9wYWNrX2hkcihjb25zdCBzdHJ1Y3QgYnBmX3Byb2cgKmZwKTsNCj4+Pj4gDQo+Pj4+
ICt2b2lkICpicGZfcHJvZ19wYWNrX2FsbG9jKHUzMiBzaXplLCBicGZfaml0X2ZpbGxfaG9sZV90
IGJwZl9maWxsX2lsbF9pbnNucyk7DQo+Pj4+ICt2b2lkIGJwZl9wcm9nX3BhY2tfZnJlZShzdHJ1
Y3QgYnBmX2JpbmFyeV9oZWFkZXIgKmhkcik7DQo+Pj4+ICsNCj4+Pj4gc3RhdGljIGlubGluZSBi
b29sIGJwZl9wcm9nX2thbGxzeW1zX3ZlcmlmeV9vZmYoY29uc3Qgc3RydWN0IGJwZl9wcm9nICpm
cCkNCj4+Pj4gew0KPj4+PiAgICAgICByZXR1cm4gbGlzdF9lbXB0eSgmZnAtPmF1eC0+a3N5bS5s
bm9kZSkgfHwNCj4+Pj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvY29yZS5jIGIva2VybmVsL2Jw
Zi9jb3JlLmMNCj4+Pj4gaW5kZXggZDFiZTc4YzI4NjE5Li43MTFmZDI5M2I2ZGUgMTAwNjQ0DQo+
Pj4+IC0tLSBhL2tlcm5lbC9icGYvY29yZS5jDQo+Pj4+ICsrKyBiL2tlcm5lbC9icGYvY29yZS5j
DQo+Pj4+IEBAIC04MjUsNiArODI1LDExIEBAIHN0cnVjdCBicGZfcHJvZ19wYWNrIHsNCj4+Pj4g
ICAgICAgdW5zaWduZWQgbG9uZyBiaXRtYXBbXTsNCj4+Pj4gfTsNCj4+Pj4gDQo+Pj4+ICt2b2lk
IGJwZl9qaXRfZmlsbF9ob2xlX3dpdGhfemVybyh2b2lkICphcmVhLCB1bnNpZ25lZCBpbnQgc2l6
ZSkNCj4+Pj4gK3sNCj4+Pj4gKyAgICAgICBtZW1zZXQoYXJlYSwgMCwgc2l6ZSk7DQo+Pj4+ICt9
DQo+Pj4+ICsNCj4+Pj4gI2RlZmluZSBCUEZfUFJPR19TSVpFX1RPX05CSVRTKHNpemUpICAgKHJv
dW5kX3VwKHNpemUsIEJQRl9QUk9HX0NIVU5LX1NJWkUpIC8gQlBGX1BST0dfQ0hVTktfU0laRSkN
Cj4+Pj4gDQo+Pj4+IHN0YXRpYyBERUZJTkVfTVVURVgocGFja19tdXRleCk7DQo+Pj4+IEBAIC04
NjQsNyArODY5LDcgQEAgc3RhdGljIHN0cnVjdCBicGZfcHJvZ19wYWNrICphbGxvY19uZXdfcGFj
ayhicGZfaml0X2ZpbGxfaG9sZV90IGJwZl9maWxsX2lsbF9pbnMNCj4+Pj4gICAgICAgcmV0dXJu
IHBhY2s7DQo+Pj4+IH0NCj4+Pj4gDQo+Pj4+IC1zdGF0aWMgdm9pZCAqYnBmX3Byb2dfcGFja19h
bGxvYyh1MzIgc2l6ZSwgYnBmX2ppdF9maWxsX2hvbGVfdCBicGZfZmlsbF9pbGxfaW5zbnMpDQo+
Pj4+ICt2b2lkICpicGZfcHJvZ19wYWNrX2FsbG9jKHUzMiBzaXplLCBicGZfaml0X2ZpbGxfaG9s
ZV90IGJwZl9maWxsX2lsbF9pbnNucykNCj4+Pj4gew0KPj4+PiAgICAgICB1bnNpZ25lZCBpbnQg
bmJpdHMgPSBCUEZfUFJPR19TSVpFX1RPX05CSVRTKHNpemUpOw0KPj4+PiAgICAgICBzdHJ1Y3Qg
YnBmX3Byb2dfcGFjayAqcGFjazsNCj4+Pj4gQEAgLTkwNSw3ICs5MTAsNyBAQCBzdGF0aWMgdm9p
ZCAqYnBmX3Byb2dfcGFja19hbGxvYyh1MzIgc2l6ZSwgYnBmX2ppdF9maWxsX2hvbGVfdCBicGZf
ZmlsbF9pbGxfaW5zbg0KPj4+PiAgICAgICByZXR1cm4gcHRyOw0KPj4+PiB9DQo+Pj4+IA0KPj4+
PiAtc3RhdGljIHZvaWQgYnBmX3Byb2dfcGFja19mcmVlKHN0cnVjdCBicGZfYmluYXJ5X2hlYWRl
ciAqaGRyKQ0KPj4+PiArdm9pZCBicGZfcHJvZ19wYWNrX2ZyZWUoc3RydWN0IGJwZl9iaW5hcnlf
aGVhZGVyICpoZHIpDQo+Pj4+IHsNCj4+Pj4gICAgICAgc3RydWN0IGJwZl9wcm9nX3BhY2sgKnBh
Y2sgPSBOVUxMLCAqdG1wOw0KPj4+PiAgICAgICB1bnNpZ25lZCBpbnQgbmJpdHM7DQo+Pj4+IGRp
ZmYgLS1naXQgYS9rZXJuZWwvYnBmL2Rpc3BhdGNoZXIuYyBiL2tlcm5lbC9icGYvZGlzcGF0Y2hl
ci5jDQo+Pj4+IGluZGV4IDI0NDRiZDE1Y2MyZC4uOGExMDMwMDg1NGI2IDEwMDY0NA0KPj4+PiAt
LS0gYS9rZXJuZWwvYnBmL2Rpc3BhdGNoZXIuYw0KPj4+PiArKysgYi9rZXJuZWwvYnBmL2Rpc3Bh
dGNoZXIuYw0KPj4+PiBAQCAtMTA0LDcgKzEwNCw3IEBAIHN0YXRpYyBpbnQgYnBmX2Rpc3BhdGNo
ZXJfcHJlcGFyZShzdHJ1Y3QgYnBmX2Rpc3BhdGNoZXIgKmQsIHZvaWQgKmltYWdlKQ0KPj4+PiAN
Cj4+Pj4gc3RhdGljIHZvaWQgYnBmX2Rpc3BhdGNoZXJfdXBkYXRlKHN0cnVjdCBicGZfZGlzcGF0
Y2hlciAqZCwgaW50IHByZXZfbnVtX3Byb2dzKQ0KPj4+PiB7DQo+Pj4+IC0gICAgICAgdm9pZCAq
b2xkLCAqbmV3Ow0KPj4+PiArICAgICAgIHZvaWQgKm9sZCwgKm5ldywgKnRtcDsNCj4+Pj4gICAg
ICAgdTMyIG5vZmY7DQo+Pj4+ICAgICAgIGludCBlcnI7DQo+Pj4+IA0KPj4+PiBAQCAtMTE3LDgg
KzExNywxNCBAQCBzdGF0aWMgdm9pZCBicGZfZGlzcGF0Y2hlcl91cGRhdGUoc3RydWN0IGJwZl9k
aXNwYXRjaGVyICpkLCBpbnQgcHJldl9udW1fcHJvZ3MpDQo+Pj4+ICAgICAgIH0NCj4+Pj4gDQo+
Pj4+ICAgICAgIG5ldyA9IGQtPm51bV9wcm9ncyA/IGQtPmltYWdlICsgbm9mZiA6IE5VTEw7DQo+
Pj4+ICsgICAgICAgdG1wID0gZC0+bnVtX3Byb2dzID8gZC0+cndfaW1hZ2UgKyBub2ZmIDogTlVM
TDsNCj4+Pj4gICAgICAgaWYgKG5ldykgew0KPj4+PiAtICAgICAgICAgICAgICAgaWYgKGJwZl9k
aXNwYXRjaGVyX3ByZXBhcmUoZCwgbmV3KSkNCj4+Pj4gKyAgICAgICAgICAgICAgIC8qIFByZXBh
cmUgdGhlIGRpc3BhdGNoZXIgaW4gZC0+cndfaW1hZ2UuIFRoZW4gdXNlDQo+Pj4+ICsgICAgICAg
ICAgICAgICAgKiBicGZfYXJjaF90ZXh0X2NvcHkgdG8gdXBkYXRlIGQtPmltYWdlLCB3aGljaCBp
cyBSTytYLg0KPj4+PiArICAgICAgICAgICAgICAgICovDQo+Pj4+ICsgICAgICAgICAgICAgICBp
ZiAoYnBmX2Rpc3BhdGNoZXJfcHJlcGFyZShkLCB0bXApKQ0KPj4+PiArICAgICAgICAgICAgICAg
ICAgICAgICByZXR1cm47DQo+Pj4+ICsgICAgICAgICAgICAgICBpZiAoSVNfRVJSKGJwZl9hcmNo
X3RleHRfY29weShuZXcsIHRtcCwgUEFHRV9TSVpFIC8gMikpKQ0KPj4+IA0KPj4+IEkgZG9uJ3Qg
dGhpbmsgd2UgY2FuIGNyZWF0ZSBhIGRpc3BhdGNoZXIgd2l0aCBvbmUgaXANCj4+PiBhbmQgdGhl
biBjb3B5IG92ZXIgaW50byBhIGRpZmZlcmVudCBsb2NhdGlvbi4NCj4+PiBTZWUgZW1pdF9icGZf
ZGlzcGF0Y2hlcigpIC0+IGVtaXRfY29uZF9uZWFyX2p1bXAoKQ0KPj4+IEl0J3MgYSByZWxhdGl2
ZSBvZmZzZXQganVtcC4NCj4+IA0KPj4gSG1tLi4uIFllYWgsIHRoaXMgbWFrZXMgc2Vuc2UuIEJ1
dCBzb21laG93IHZtdGVzdCBkb2Vzbid0DQo+PiBzaG93IGFueSBpc3N1ZSB3aXRoIHRoaXMuIElz
IHRoZXJlIGEgYmV0dGVyIHdheSB0byB0ZXN0IHRoaXM/DQo+IA0KPiB0ZXN0X3hkcCouc2ggc2hv
dWxkIHN1cmVseSB0cmlnZ2VyIGl0LA0KDQp0ZXh0X3hkcCouc2ggc2VlbSB0byBnaXZlIHNhbWUg
cmVzdWx0IHcvIGFuZCB3L28gdGhlIHNldCAob24gdG9wDQpvZiBicGYtbmV4dCkuIEZvciBleGFt
cGxlLCAuL3Rlc3RfeGRwX3JlZGlyZWN0LnNoIHdvcmtzIGp1c3QgZmluZS4gDQooQW5kIEkgdGhp
bmsgaXQgc2hvdWxkbid0LikNCg0KDQo+IGJ1dCBJJ20gc3VycHJpc2VkIHRoZSByZWd1bGFyIHRl
c3RfcnVuIGRvZXNuJ3QgdHJpZ2dlciBpdC4NCj4gV2UgY2FsbCBicGZfcHJvZ19ydW5feGRwKCkg
dGhlcmUuDQo+IFdlJ3ZlIGFkZGVkDQo+ICAgICAgICBpZiAocmVwZWF0ID4gMSkNCj4gICAgICAg
ICAgICAgICAgYnBmX3Byb2dfY2hhbmdlX3hkcChOVUxMLCBwcm9nKTsNCg0KSSByZW1vdmVkIHRo
aXMgZnJvbSB0ZXN0X3J1bi5jLCBidXQgdGhhdCBkaWRuJ3QgY2hhbmdlIHZtdGVzdC4gDQoNClNv
bmcNCg0KDQo+IA0KPiB0aGVyZSB0byByZWR1Y2UgdGVzdF9wcm9ncyB0aW1lLiBNYXliZSBpdCBy
ZWR1Y2VkIHRlc3QgY292ZXJhZ2UgdG9vIG11Y2guDQoNCg0KDQo=
