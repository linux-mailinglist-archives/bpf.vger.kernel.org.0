Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EEC52B267
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 08:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiERGZm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 02:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbiERGZk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 02:25:40 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F097D6839;
        Tue, 17 May 2022 23:25:38 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24I6DOnx031672;
        Tue, 17 May 2022 23:25:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=EPjGgY0A9QH/f8Wdus9EPIEcLOfWdmEWqO/QnAk6nDg=;
 b=Ts57YZOyYkzOKArFcRY0qi+Mh3LkNLfOHRXFKLxGzGjsnO2XdKLeZznUboERo8PthPfK
 YHnU/dL0nxd4HYK6FO9rd3cIgjfLKZ7QIaugc1a8FbsdgS9Y47eJPKT0DyxFvdLtmUPy
 GQ20n9vXbL6HuA7TLpy1n4F0ao0LzRkFqu0= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g4frt494c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 23:25:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0tV5h0ZtdQoI+9P9/Q7k6HdIR4HYNaGNNZjAr66+HhspRMfFAQBzbu6WayXhd5/AWmqqupA/eHRlG5o5qeMKIPzOyUxwNumzCt054WOkOd6TqIl38GYRtMc2un2bd8chvU19alMh+7Ebbi93+mtbNiU0VdbR/+3XK5C0Fqu3gXKlngk4gkkRqt3EnLYXzviGjHIaZBR+HtvsVT7sF+Zl6uCg/Mi8M7/O+modpaReFqay37IXMzyhTEzPBhGSvmzjPSvgop6uavhVoTnI4H6ZI30ODMvZOLkImJc8NL4g69ycjr/lR6WiazmQmj7L7bhrlk1qcro1xlIDAGO1b4M8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPjGgY0A9QH/f8Wdus9EPIEcLOfWdmEWqO/QnAk6nDg=;
 b=l0NR20Bekj2cFxbsleqOZbxfBj6RAwvCoWqRInC+5n4MC9Yn66N6GTPKDH5IQPXALVVagHDplOzSOGETWHqkA80e/aLJ8m4jKkhvlKLorAEcfAVMBftA+p+7P83ZC1Ix2eNTYEnF/bn7Z4xazlboViKwnl4UzSHCal3DRcB6l9zH+jQTIbyZZWR+oPiolEYJWJHIuhSCbOOwr408R//5muyKGXHJ8yhmyCpInL9kmbjLsCUZTcoCEGbjlrc0/dupJ5IiBxnx4gmx1BU0jjdn2uZc9iI4CYchWD7h/BZO5hxc30WEgNU+Nk/zVCjyrLFTc5q3DG0QvgTa/GqwHKR8Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DM6PR15MB3292.namprd15.prod.outlook.com (2603:10b6:5:167::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 06:25:35 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::3061:40ff:2ad:33aa]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::3061:40ff:2ad:33aa%5]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 06:25:35 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        Kernel Team <Kernel-team@fb.com>,
        "song@kernel.org" <song@kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
Subject: Re: [PATCH bpf-next 5/5] bpf: use module_alloc_huge for bpf_prog_pack
Thread-Topic: [PATCH bpf-next 5/5] bpf: use module_alloc_huge for
 bpf_prog_pack
Thread-Index: AQHYaOeMGoBl3hFoL0eR1OYIkVdnbK0jcwCAgAAfoYCAAC+jgIAAbBSA
Date:   Wed, 18 May 2022 06:25:35 +0000
Message-ID: <67105911-7B7B-4BA8-8BF2-79ABA13D87AF@fb.com>
References: <20220516054051.114490-1-song@kernel.org>
 <20220516054051.114490-6-song@kernel.org>
 <83a69976cb93e69c5ad7a9511b5e57c402eee19d.camel@intel.com>
 <68615225-D09D-465A-8EEC-6F81EF074854@fb.com>
 <dc23afb892846ef41d73a41d58c07f6620cb6312.camel@intel.com>
In-Reply-To: <dc23afb892846ef41d73a41d58c07f6620cb6312.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee8d7033-c9aa-4f0e-36a3-08da389737d1
x-ms-traffictypediagnostic: DM6PR15MB3292:EE_
x-microsoft-antispam-prvs: <DM6PR15MB32929117E12DEE7FBC3B312DB3D19@DM6PR15MB3292.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dfGDfvBkqiFXM32xJGXZ0LMSa69iLaH00qVaOVPeAK+lP7CVOFVD2G+WMitUZ3rwe4KoiN+CvOTTvUbyA4et3AdM0LL5yFAOl468WOHyO65xMYNF/FiV+CQd388/SfaC8Cbhsk+l5DAnkWaAU6oKezRKx9kDUGVTggCYzyfy/JTgTEMviZUD3Wzk3W+2bGte2psXPSe8UMBgaOZz2lXbhlLbefVCTrveXv0Z+FdDiAbgXRNhony0KOuDaDfu0bbxiqLRlXYl7YW+uQbg+ML7VPPgrz0S/fhp5aUmBAApUUR2DYv9fSjXNns001GS232ThM5S9oYOu+byZnHou2rVFx051SpwHY4lKpN1vjsqeO07SWfcc+m0h/YTBw/Sbxcb2zLkFku21SyN97aAJAxae7lwPVnZVeJJNS+DRU80UG5TkHZ9O6+nruYsL7uO2uzefxt6aUFK1aCPhFvzxmBiugdt5SVYz6E9SnaX62xyt9X8Ay3zf+mBodSRNAxVwO+hDF5c0FZGGTvWaLzksWZ6FEmzxe7vgKxGdAqBVQz+AO5p9bgxpZMrOpsAgOr9xaujFpcPbJmPjZoHIGyhPGXFk2Tp5+zu7XO7WTw4CQMN0EsYwYlXdybmti67Vu8QdekqZsnbTsekSqKDIIawWxSFWHhz5pm2ske+IbckdUT1IcDV9VtXgb1htvN0BZf0VBEpwBGEmFcR61s3zZMvj/Dcuf5FIUu93REN58qvFqNi+c6NmhcqHu5sqapnj+cpIg6sDhl0kfOFJg1/wPiqlR19cOdPchYyy0OPYTt8f2L45nvsZjj6T9sTz02YoLh1r7OD6v145xteXhyBns+QVbJ/uDcOwL2KS1rfxl5ZSeX39Vs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(76116006)(6506007)(64756008)(91956017)(8676002)(6916009)(54906003)(86362001)(71200400001)(36756003)(66556008)(6486002)(316002)(508600001)(83380400001)(38100700002)(966005)(2616005)(122000001)(38070700005)(186003)(8936002)(2906002)(66476007)(6512007)(66446008)(53546011)(33656002)(4326008)(5660300002)(14583001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGVuY1hUWittMFAzRkx1TGQ1S29WMTBhNzJUSEpORndDVlhGTzBUNjhZT0VJ?=
 =?utf-8?B?eVRPNEU4VmhxdGI5Wm9RN1JXRCsxOU04TFVYNjBBMVkraGZwSUhpRmNld2pq?=
 =?utf-8?B?Y3NpQ0NLUHdPa2pDZGlkODFROWgrM3hnZTRnYXBjYmpPMkdlTndqZ3FxU2Vh?=
 =?utf-8?B?aThSTTZ0Z0RJcFJldGs0SERFWmlRdUNMZ1hCSkFqQmRUQUtwWlpqQkw2MXhw?=
 =?utf-8?B?WDRHWEorcVhHbExsald5bGVJdnVTSTk1WHhrT2dQTnJjR1Y3ZGpqaTJCMk5I?=
 =?utf-8?B?clpvN2JVazBWUm4xV3U5Y1dTTU1pZ0JNWVdodG0wc3RvL0dxenNqalAzVCtC?=
 =?utf-8?B?MTBpWThkcGNnbjRKVnd0aCtHNS9IQUluWWFiOUtmRmM4eE5mTlNrV0FUcjNx?=
 =?utf-8?B?NGx4bjZ6Qnp2VnJhYi9ibytpa0JBeFpaeVMxZnNMZktpWGxwalErSlg5TTVZ?=
 =?utf-8?B?eTdsbm9oMzlIa3BXblFlSzRHbmtZNWZzQXd0SEcxZG0wY1pPNW4yRVoydHlu?=
 =?utf-8?B?a1llVFB1RXhISGJ4Nm1xNnlOdzdOdVQwc0hnOUEzOXpFNFpIQ1BqSzRaWGhS?=
 =?utf-8?B?NWdPanlFSW5ManNaMmdkL2hyWmhUU0NvRzNjTUwyQjFrSWl6YTJEdEdZSnVC?=
 =?utf-8?B?ZHRyd2MvRHpUaEh4d3pXaUtBY2pHZzM0SytJY1lzVXhvclJ6S3I5cGhLNjNY?=
 =?utf-8?B?bnE5b1ZxTTBKMi9WK1F0Rnd4UUp2bmNycjFUR2RDSnljL0dmSVVZekIzRjRD?=
 =?utf-8?B?UWlRTjkzU2hVemJ3dGFIUC94cjJMcUszU21LZlptWmUvZ0pSOVB5dEFXUDda?=
 =?utf-8?B?ZXVQSGs2NzlKUFZxNlFzVmtvMndqWjUvWHRCbUZNLzBXZ2htSVBaY0dUNk84?=
 =?utf-8?B?SWRZZ3NhdHlKNmY3dG84NEtLb0QxY3crQndXV3d0ZmMrcC9WODhROFA2M1Zm?=
 =?utf-8?B?L2ozTjEzUE5RZ1FWc3dGVUp0emZhcFNSUDViL2llVUFpc25IQVhIc0ZCczZp?=
 =?utf-8?B?dkVkZVdKNExCN245d2QrWFIwUHNxMHN0aWc5cXZkTjJDY05ML3BCT3lMVXZR?=
 =?utf-8?B?K2lJZnRqY25xKzFhUm11ZmswQzBRY1lMdmNNbEcyY2I2Rk9yM1l5Q3BSWUJa?=
 =?utf-8?B?bmwxSEFNU0djZEZXSW5uem1RWjNGc3dEdXhsYVlQQWg0UnRVYWR3UENUUTRV?=
 =?utf-8?B?UkR2RXJMOGZwcDNwNFFIdVJINmQ3cUxmZkNuYURvL1k2QWd5eS8yKy9Xbkt5?=
 =?utf-8?B?ZEJVeDczcXpPZXI4NGYvVi9rMjJZK3kvaGRQM05oazZwOHc2U3ptKzFRR3FI?=
 =?utf-8?B?M25pd2YramsvUi81Y1daRDhtdTNYK1lLR2JsOWVxanlpMXlyR1U0ZXhINGxX?=
 =?utf-8?B?MzZmbkNlZDRxaHp0RVppcjlKM29TREtsTEIzbXVNbzh0S0FHTWJHRG9ZUG84?=
 =?utf-8?B?WW55a2JxV0Z4WmFBUVllREh1VmY2eVZoeHlNb3hpSVVHd0IxWmk1ME9TMFg2?=
 =?utf-8?B?bG93MW1wZ1JGSFZEZHg1Vk1ISWdzbWVtamtuRjFEZHFuQ1JzRWdxOC9GQVZN?=
 =?utf-8?B?RC9HNXNaYkNacXdJSkRuUzVaSGswSjZGV0lQa0U4V0UrdE9BUGRpVEVwcEZZ?=
 =?utf-8?B?UzhrNk9CWWwrdkNPM3FlbnVEWFpzRzVXdzlGczV6SUFNVk03eEFwY0ptNkRT?=
 =?utf-8?B?SXFSTDA5T2tuekRYaVdtbXdoelBJSVZVZ3VkRzZCS2NFOWRtMjlpeHhrdjZT?=
 =?utf-8?B?bUpOY3FVRHMxd2FPb3BtK2FCczFCYjJFRWZFN0tlVW9YYnd3L3lRejZmV1hL?=
 =?utf-8?B?QnhtalNDNktEY1BsME9aNVc5WU1jQXlwUHc5N2FFS1NCOW1FVlhOelZzMCtP?=
 =?utf-8?B?V0FmN2F6NmsyT1ViY0J6SmVKcWp3Y0l5YXVKUDkvclpUaG5xYVg0SlZpa0tV?=
 =?utf-8?B?djNEZmNQVW1Wc2VWTGtPL1FiRDl1UjZhNFBycW00ODYzeTR3RHJqcmFDeUNR?=
 =?utf-8?B?Y3g2RHB2c1dsU00yakpWQW5VRmJvdnNiT2R1U1FKRHp1ZG5BYUtXL1V1Unlx?=
 =?utf-8?B?amFPaHFXdTJoeXFpMmNlMjlhazg4S0dyNHZURDhzRkU5amg3MjRTN1R2Wlpt?=
 =?utf-8?B?SlZja3I5cmIzYmkySDNUUENlSjRRSWpQM2ZmeklVaVZsQzJsbGJZY0ZVNlVJ?=
 =?utf-8?B?NUt3aTVYWmJhdTEwYVR1YkVGUDE2VW5GS1E4WUVGK2ZQR3V5Z1ZGMHJmWHZn?=
 =?utf-8?B?WGxtUUZwbWg0TkpMTTMzOE1FY1ROMUdHNHR2S2JSMnlEd3FaTVRxUjl2aCs3?=
 =?utf-8?B?QXlWRm5MdnlVUVJ1QzNlNFBrdG1GYkNZTVYvN0dyb0h5dExYakVYSmhwZ1RY?=
 =?utf-8?Q?7cNnIRDbRqb4DaUtWn1+Da0NbJ0TgwVdiioQB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B94D0614CAFFA42B9AD7E3B4BB6B603@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8d7033-c9aa-4f0e-36a3-08da389737d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 06:25:35.3709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KAxy66nnGUEpnyE1a4isQ7Fw6OLEpIDxlQiLCzmgAA1kiF8OSnDSSSvsJrlymRDxpNw1bGIyEw3DipHkROf+jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3292
X-Proofpoint-GUID: 57pdkSwrCTJYrOF3b7_s2ZdIerPQlQm3
X-Proofpoint-ORIG-GUID: 57pdkSwrCTJYrOF3b7_s2ZdIerPQlQm3
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_02,2022-05-17_02,2022-02-23_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCj4gT24gTWF5IDE3LCAyMDIyLCBhdCA0OjU4IFBNLCBFZGdlY29tYmUsIFJpY2sgUCA8cmlj
ay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gT24gVHVlLCAyMDIyLTA1LTE3
IGF0IDIxOjA4ICswMDAwLCBTb25nIExpdSB3cm90ZToNCj4+PiBPbiBNYXkgMTcsIDIwMjIsIGF0
IDEyOjE1IFBNLCBFZGdlY29tYmUsIFJpY2sgUCA8DQo+Pj4gcmljay5wLmVkZ2Vjb21iZUBpbnRl
bC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIFN1biwgMjAyMi0wNS0xNSBhdCAyMjo0MCAtMDcw
MCwgU29uZyBMaXUgd3JvdGU6DQo+Pj4+IFVzZSBtb2R1bGVfYWxsb2NfaHVnZSBmb3IgYnBmX3By
b2dfcGFjayBzbyB0aGF0IEJQRiBwcm9ncmFtcyBzaXQNCj4+Pj4gb24NCj4+Pj4gUE1EX1NJWkUg
cGFnZXMuIFRoaXMgYmVuZWZpdHMgc3lzdGVtIHBlcmZvcm1hbmNlIGJ5IHJlZHVjaW5nIGlUTEIN
Cj4+Pj4gbWlzcw0KPj4+PiByYXRlLiBCZW5jaG1hcmsgb2YgYSByZWFsIHdlYiBzZXJ2aWNlIHdv
cmtsb2FkIHNob3dzIHRoaXMgY2hhbmdlDQo+Pj4+IGdpdmVzDQo+Pj4+IGFub3RoZXIgfjAuMiUg
cGVyZm9ybWFuY2UgYm9vc3Qgb24gdG9wIG9mIFBBR0VfU0laRSBicGZfcHJvZ19wYWNrDQo+Pj4+
ICh3aGljaCBpbXByb3ZlIHN5c3RlbSB0aHJvdWdocHV0IGJ5IH4wLjUlKS4NCj4+PiANCj4+PiAw
LjclIHNvdW5kcyBnb29kIGFzIGEgd2hvbGUuIEhvdyBzdXJlIGFyZSB5b3Ugb2YgdGhhdCArMC4y
JT8gV2FzDQo+Pj4gdGhpcyBhDQo+Pj4gYmlnIGF2ZXJhZ2VkIHRlc3Q/DQo+PiANCj4+IFllcywg
dGhpcyB3YXMgYSB0ZXN0IGJldHdlZW4gdHdvIHRpZXJzIHdpdGggMTArIHNlcnZlcnMgb24gZWFj
aA0KPj4gdGllci4gIA0KPj4gV2UgdG9vayB0aGUgYXZlcmFnZSBwZXJmb3JtYW5jZSBvdmVyIGEg
ZmV3IGhvdXJzIG9mIHNoYWRvdyB3b3JrbG9hZC4gDQo+IA0KPiBBd2Vzb21lLiBTb3VuZHMgZ3Jl
YXQuDQo+IA0KPj4gDQo+Pj4gDQo+Pj4+IA0KPj4+PiBBbHNvLCByZW1vdmUgc2V0X3ZtX2ZsdXNo
X3Jlc2V0X3Blcm1zKCkgZnJvbSBhbGxvY19uZXdfcGFjaygpIGFuZA0KPj4+PiB1c2UNCj4+Pj4g
c2V0X21lbW9yeV9bbnh8cnddIGluIGJwZl9wcm9nX3BhY2tfZnJlZSgpLiBUaGlzIGlzIGJlY2F1
c2UNCj4+Pj4gVk1fRkxVU0hfUkVTRVRfUEVSTVMgZG9lcyBub3Qgd29yayB3aXRoIGh1Z2UgcGFn
ZXMgeWV0LiBbMV0NCj4+Pj4gDQo+Pj4+IFsxXSANCj4+Pj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2JwZi9hZWVlYWYwYjdlYzYzZmRiYTU1ZDQ4MzRkMmY1MjRkOGJmMDViNzFiLmNhbWVs
QGludGVsLmNvbS8NCj4+Pj4gU3VnZ2VzdGVkLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVk
Z2Vjb21iZUBpbnRlbC5jb20+DQo+Pj4gDQo+Pj4gQXMgSSBzYWlkIGJlZm9yZSwgSSB0aGluayB0
aGlzIHdpbGwgd29yayBmdW5jdGlvbmFsbHkuIEJ1dCBJIG1lYW50DQo+Pj4gaXQNCj4+PiBhcyBh
IHF1aWNrIGZpeCB3aGVuIHdlIHdlcmUgdGFsa2luZyBhYm91dCBwYXRjaGluZyB0aGlzIHVwIHRv
IGtlZXANCj4+PiBpdA0KPj4+IGVuYWJsZWQgdXBzdHJlYW0uDQo+Pj4gDQo+Pj4gU28gbm93LCBz
aG91bGQgd2UgbWFrZSBWTV9GTFVTSF9SRVNFVF9QRVJNUyB3b3JrIHByb3Blcmx5IHdpdGggaHVn
ZQ0KPj4+IHBhZ2VzPyBUaGUgbWFpbiBiZW5lZml0IHdvdWxkIGJlIHRvIGtlZXAgdGhlIHRlYXIg
ZG93biBvZiB0aGVzZQ0KPj4+IHR5cGVzDQo+Pj4gb2YgYWxsb2NhdGlvbnMgY29uc2lzdGVudCBm
b3IgY29ycmVjdG5lc3MgcmVhc29ucy4gVGhlIFRMQiBmbHVzaA0KPj4+IG1pbmltaXppbmcgZGlm
ZmVyZW5jZXMgYXJlIHByb2JhYmx5IGxlc3MgaW1wYWN0ZnVsIGdpdmVuIHRoZQ0KPj4+IGNhY2hp
bmcNCj4+PiBpbnRyb2R1Y2VkIGhlcmUuIEF0IHRoZSB2ZXJ5IGxlYXN0IHRob3VnaCwgd2Ugc2hv
dWxkIGhhdmUgKG9yIGhhdmUNCj4+PiBhbHJlYWR5IGhhZCkgc29tZSBXQVJOIGlmIHBlb3BsZSB0
cnkgdG8gdXNlIGl0IHdpdGggaHVnZSBwYWdlcy4NCj4+IA0KPj4gSSBhbSBub3QgcXVpdGUgc3Vy
ZSB0aGUgZXhhY3Qgd29yayBuZWVkZWQgaGVyZS4gUmljaywgd291bGQgeW91IGhhdmUNCj4+IHRp
bWUgdG8gZW5hYmxlIFZNX0ZMVVNIX1JFU0VUX1BFUk1TIGZvciBodWdlIHBhZ2VzPyBHaXZlbiB0
aGUgbWVyZ2UgDQo+PiB3aW5kb3cgaXMgY29taW5nIHNvb24sIEkgZ3Vlc3Mgd2UgbmVlZCBjdXJy
ZW50IHdvcmsgYXJvdW5kIGluIDUuMTkuIA0KPiANCj4gSSB3b3VsZCBoYXZlIGhhcmQgdGltZSBz
cXVlZXppbmcgdGhhdCBpbiBub3cuIFRoZSB2bWFsbG9jIHBhcnQgaXMgZWFzeSwNCj4gSSB0aGlu
ayBJIGFscmVhZHkgcG9zdGVkIGEgZGlmZi4gQnV0IGZpcnN0IGhpYmVybmF0ZSBuZWVkcyB0byBi
ZQ0KPiBjaGFuZ2VkIHRvIG5vdCBjYXJlIGFib3V0IGRpcmVjdCBtYXAgcGFnZSBzaXplcy4NCg0K
SSBndWVzcyBJIG1pc3NlZCB0aGUgZGlmZiwgY291bGQgeW91IHBsZWFzZSBzZW5kIGEgbGluayB0
byBpdD8NCg0KPiANCj4+IA0KPj4+IA0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBTb25nIExpdSA8c29u
Z0BrZXJuZWwub3JnPg0KPj4+PiAtLS0NCj4+Pj4ga2VybmVsL2JwZi9jb3JlLmMgfCAxMiArKysr
KysrLS0tLS0NCj4+Pj4gMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlv
bnMoLSkNCj4+Pj4gDQo+Pj4+IGRpZmYgLS1naXQgYS9rZXJuZWwvYnBmL2NvcmUuYyBiL2tlcm5l
bC9icGYvY29yZS5jDQo+Pj4+IGluZGV4IGNhY2Q4Njg0YzNjNC4uYjY0ZDkxZmNiMGJhIDEwMDY0
NA0KPj4+PiAtLS0gYS9rZXJuZWwvYnBmL2NvcmUuYw0KPj4+PiArKysgYi9rZXJuZWwvYnBmL2Nv
cmUuYw0KPj4+PiBAQCAtODU3LDcgKzg1Nyw3IEBAIHN0YXRpYyBzaXplX3Qgc2VsZWN0X2JwZl9w
cm9nX3BhY2tfc2l6ZSh2b2lkKQ0KPj4+PiAgICAgIHZvaWQgKnB0cjsNCj4+Pj4gDQo+Pj4+ICAg
ICAgc2l6ZSA9IEJQRl9IUEFHRV9TSVpFICogbnVtX29ubGluZV9ub2RlcygpOw0KPj4+PiAtICAg
IHB0ciA9IG1vZHVsZV9hbGxvYyhzaXplKTsNCj4+Pj4gKyAgICBwdHIgPSBtb2R1bGVfYWxsb2Nf
aHVnZShzaXplKTsNCj4+PiANCj4+PiBUaGlzIHNlbGVjdF9icGZfcHJvZ19wYWNrX3NpemUoKSBm
dW5jdGlvbiBhbHdheXMgc2VlbWVkIHdlaXJkIC0NCj4+PiBkb2luZyBhDQo+Pj4gYmlnIGFsbG9j
YXRpb24gYW5kIHRoZW4gaW1tZWRpYXRlbHkgZnJlZWluZy4gQ2FuJ3QgaXQgY2hlY2sgYQ0KPj4+
IGNvbmZpZw0KPj4+IGZvciB2bWFsbG9jIGh1Z2UgcGFnZSBzdXBwb3J0Pw0KPj4gDQo+PiBZZXMs
IGl0IGlzIHdlaXJkLiBDaGVja2luZyBhIGNvbmZpZyBpcyBub3QgZW5vdWdoIGhlcmUuIFdlIGFs
c28gbmVlZA0KPj4gdG8gDQo+PiBjaGVjayB2bWFwX2FsbG93X2h1Z2UsIHdoaWNoIGlzIGNvbnRy
b2xsZWQgYnkgYm9vdCBwYXJhbWV0ZXINCj4+IG5vaHVnZWlvbWFwLiANCj4+IEkgaGF2ZW7igJl0
IGdvdCBhIGJldHRlciBzb2x1dGlvbiBmb3IgdGhpcy4gDQo+IA0KPiBJdCdzIHRvbyB3ZWlyZC4g
V2Ugc2hvdWxkIGV4cG9zZSB3aGF0cyBuZWVkZWQgaW4gdm1hbGxvYy4NCj4gaHVnZV92bWFsbG9j
X3N1cHBvcnRlZCgpIG9yIHNvbWV0aGluZy4NCg0KWWVhaCwgdGhpcyBzaG91bGQgd29yay4gSSB3
aWxsIGdldCBzb21ldGhpbmcgbGlrZSB0aGlzIGluIHRoZSBuZXh0IA0KdmVyc2lvbi4NCg0KPiAN
Cj4gSSdtIGFsc28gbm90IGNsZWFyIHdoeSB3ZSB3b3VsZG4ndCB3YW50IHRvIHVzZSB0aGUgcHJv
ZyBwYWNrIGFsbG9jYXRvcg0KPiBldmVuIGlmIHZtYWxsb2MgaHVnZSBwYWdlcyB3YXMgZGlzYWJs
ZWQuIERvZXNuJ3QgaXQgaW1wcm92ZSBwZXJmb3JtYW5jZQ0KPiBldmVuIHdpdGggc21hbGwgcGFn
ZSBzaXplcywgcGVyIHlvdXIgYmVuY2htYXJrcz8gV2hhdCBpcyB0aGUgZG93bnNpZGUNCj4gdG8g
anVzdCBhbHdheXMgdXNpbmcgaXQ/DQoNCldpdGggY3VycmVudCB2ZXJzaW9uLCB3aGVuIGh1Z2Ug
cGFnZSBpcyBkaXNhYmxlZCwgdGhlIHByb2cgcGFjayBhbGxvY2F0b3INCndpbGwgdXNlIDRrQiBw
YWdlcyBmb3IgZWFjaCBwYWNrLiBXZSBzdGlsbCBnZXQgYWJvdXQgMC41JSBwZXJmb3JtYW5jZQ0K
aW1wcm92ZW1lbnQgd2l0aCA0a0IgcHJvZyBwYWNrcy4gDQoNClRoYW5rcywNClNvbmcNCg0KDQo=
