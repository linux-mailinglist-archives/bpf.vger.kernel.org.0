Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5354B77D4
	for <lists+bpf@lfdr.de>; Tue, 15 Feb 2022 21:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiBOR1o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Feb 2022 12:27:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiBOR1n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Feb 2022 12:27:43 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A12193DB
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 09:27:33 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21FHPEOe006153
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 09:27:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=VbRqC4MA1VQW5UGCxbEZIdf5+uVAIQICIELZuAUTcy4=;
 b=CzJKsM9DGkwrgSBKyiBmUFFTbtILlQ/G/BXkr45Xgbj7RSFvXFVf1gswQxbSpimRhnal
 rvu5Wun8FFubQCF+khsq6ofMF4h8aJHNRibdkrIggIJAe81vM1qBsZs/UlUxBw1ppELU
 kwb8Q/EpdEKzsUmJ9cCAaanBYPb2Duj1xhE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e89dqua9u-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 09:27:32 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Feb 2022 09:27:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJ2zAIHJGwt2owQH3O5aK8F4fMF8tI2IKBIEToYe2iA2p8jAUhX//Pwc1drlHvPK8IdecjTFOi4TAyTvrUWD5+4egfQ5WbJ2tg+xiKQg9aFA7r2x/2KS4l1nqpKXBAjFXZtw6zWJwGDLTYoX/Ge5gwgo8+Py4IaIs51JIHF4GcYpmLNp+LRfE2J5+pR1CfWHKCDCskqS4Q5ALQQlnstBGIEFQyeYHXGE7lwCC2DQ/rAJ0qjTlsF008UnUzr4kGo38B9jeTyk6kv2sFWeTbUVd6L/bHlewXH6Yo+IeuRrbhqNU5x8Iw4KNQ2ECmLHXYLEm+rsPmhnSGaCabifaF+/ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbRqC4MA1VQW5UGCxbEZIdf5+uVAIQICIELZuAUTcy4=;
 b=Y+av4HyvkELO6+7aaz9dh/f8EHdqlswTsP06xkVvWj10LZmrLQmjRJ4wZ8002CbO/O9sYOJYWvuUWNcKuhwzAYY9bHABB5euZ4Q1JelT3yHTp4cmwRkD4aFEnid3TloFdzkgAycarXYQj30/GP8ulsorJWE9Bxbd+IyXLfAb6ZhLKLewreiK7V4LmXifWzAi1YwuS4kZYuVJ2Z12ygFjO41ByMadWFKQ035rG9k5j5myNLnLaa+Bpv9nVmJOxXa6YDJq5fuHMH63rutz/IG6Op9/PoemZroXrkqMN0M3bFQ4NhI/JSo/PnXbtxdHWU+uUJ6l4MRc9vQg6QlgZ3qsGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by DM6PR15MB3862.namprd15.prod.outlook.com (2603:10b6:5:2bf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Tue, 15 Feb
 2022 17:27:28 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::7867:90d0:bcaa:2ea7]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::7867:90d0:bcaa:2ea7%5]) with mapi id 15.20.4975.012; Tue, 15 Feb 2022
 17:27:28 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 1/1] bpftool: bpf skeletons assert type sizes
Thread-Topic: [PATCH bpf-next v2 1/1] bpftool: bpf skeletons assert type sizes
Thread-Index: AQHYIgKzQKiPCqlUp0Kc0d/h5OrekKyUENWAgADMWQA=
Date:   Tue, 15 Feb 2022 17:27:27 +0000
Message-ID: <8c8820379a241322535ce0821bdb9f6c05c91290.camel@fb.com>
References: <cover.1644884357.git.delyank@fb.com>
         <6c673f48d35fd06bc3490b00d4e6527b7e180d59.1644884357.git.delyank@fb.com>
         <CAEf4BzYZ7r3hpUsEQvkF-fpJhHdt0OXAxJxPvPDN-f4088bM6A@mail.gmail.com>
In-Reply-To: <CAEf4BzYZ7r3hpUsEQvkF-fpJhHdt0OXAxJxPvPDN-f4088bM6A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc593de5-fe1a-4f4a-708d-08d9f0a87069
x-ms-traffictypediagnostic: DM6PR15MB3862:EE_
x-microsoft-antispam-prvs: <DM6PR15MB3862FA8F3C3F3D366C511149C1349@DM6PR15MB3862.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 22yaZPJS4Tb0nMkQI1bXcKrgqmIgN/nCz24VrXN+EGMlZ3bI6H4bRfYB8ToN4cJOJ8Al1oDuGm14DliF4AJ9+wglMG5E2dmcSRA8dvwG0fs4hAhWtT09BizHYFi3iE8K+v5eRWGGVnVUIxARzi4WtaSPHrGtHwA2OMlbnPUTlm9iveh1jwyY4ahz12Vi7yw8j+qIqu5/1lGOSfx0HhWuYQi6zoKvr3vCJo3xGHZe/15wb05XENeI0g/xX0tRMH+l6ewOCkFXCg2ZDZHkyK/iF8rRdYhwHGnHhEYjlxIdfyiTZ/3dbLwyzIng8GN4Xnpf/QBvtS95ognM/8/a4vEAaruDK9VLHlvrAaGrIGrsphdtW59xMBA2x0yrXd3Iynb5cs5hXj4ZXToCfb2uZi8psxLyyApdvUgCi1S9o4HVcBBvIvJs69k1bQAZRnlBs5bzFhI4WYYErpPAwvrBReShhXbBcs7GCIro20H7ZPBrPf6FWQwf5XvQVjW37C76ySCbhTEWNhw1cCEPF4RLx2ZV8JbVOgYPcWa3kvY23jaNV8jZwoNeWMkNVRP4CBU2ZbYmtvpqsKXxI2Wsw6csox40KvXhQKDeET/M78EAthJTaVi1aAz+mmSV4Fgeu3Htm15sCJHQKcOKGq/tNubJAAjiZ8p95AE1NTQ0dD92C5wIvhKyq1Ae2WGFGFu2S4n9i2EmArX2JemAtN6CZI0IOy1H9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(2906002)(38070700005)(8936002)(5660300002)(36756003)(38100700002)(122000001)(76116006)(2616005)(66946007)(66446008)(66476007)(66556008)(91956017)(8676002)(6512007)(186003)(6916009)(83380400001)(54906003)(4326008)(316002)(71200400001)(64756008)(508600001)(6486002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGJZVG0zajVuTHRoTVpPUjNRK09ycWtjOUJYdFM3anBDeTMybHpza2JjcGU5?=
 =?utf-8?B?eVJIcThENWFUVkxxUEVqWkhYRjludGpURVFFc0hnckVqZ0pDTlhaWWZZbndx?=
 =?utf-8?B?alZGdEhhKzdqNzNnYnBPeGpOZmhPV1NyTmpJMUV0WDYrakhRMEpSSElkRTNs?=
 =?utf-8?B?d2hFWEM1OXYzMGQweDF2TEFuTUZRRXZZeXdjYkxrWXlFRzIzemdRa210SkRK?=
 =?utf-8?B?MmlCWUltWmNNZEVzeldISncwUCtGTzVzbzNGSmtoRzg0TXRkKzBwSnRBWDkv?=
 =?utf-8?B?QUdUdG5OTFJLdllnaUpBYXdZUm1GRDFXMDcrOEEwRGdML1ZTakZBYTUwaVdE?=
 =?utf-8?B?WUVUL2dIT09YUUc4c29zNEtEUWhjbXdPbDlrRUtRMnB0Z0pvRDNiQnNTTFgw?=
 =?utf-8?B?Rlp5a1ZPNXhDK0lycURITnR5a2IzcHduRFB3aDZoTEwvemxVL2FhallYQjFU?=
 =?utf-8?B?cWF2NWJ2Zm9qL0RUK0RFWVA5YlROYk9oK0Q0bXlGd211T0p2bWdzSUJJajg5?=
 =?utf-8?B?S0RmNDBQU0lhbGtpWTNXWS9FN1plMUVPYm9XeU9qQm5zZjlnTStPMklaaGha?=
 =?utf-8?B?OGhMWk9CV1ltWW5qQmhtOFFJc1pjanh5eTVLdXF1QTJkRkoyYzdGWTI0SHhR?=
 =?utf-8?B?Q21EWlREOGVwdGl2NlY2cm81NHQzdGxLR1hYN213YTQ5NlpqelRublZUcTNt?=
 =?utf-8?B?Yk8rbXJWRkNtZ1l6UzFWYXhGTGRXQzJvb3EwN2RtV2wxZE1COWszdCtVQVJS?=
 =?utf-8?B?bWZZOGdGdkJJaWhKRDc5U2hDcngrcW40emVMakFoU3Y0SEhsRWl2WDVtQnlL?=
 =?utf-8?B?UTlnN2U0YTZHMzNkaEs3NnZqRm9Fb1FrSnAvajZtT3FoZ3Y2Mi81MjhhWWFx?=
 =?utf-8?B?QVFxOVljQkZ4dnM3dkZqeW9MbVRNc2xWMSt0WG1pSHNjQndiTkxBdFBzMEIw?=
 =?utf-8?B?ZlRBN3d1OXVQU214K1h0a29ZcDlSY05CaVdpVnFjMk1UajBCWVUybmgxK3pW?=
 =?utf-8?B?dkpXYnZVUS9nOThGaTBqWmtXT1BlamFSVzYzMEpTdi80WUxSZDFRMU1YZ2hH?=
 =?utf-8?B?QmVKbk91OWtHSldGc282WnlPWGdLb2d2K2VtNitzSjZ0RENVZmhYa2lnQms4?=
 =?utf-8?B?eWxBMS9Rak5mVmJBZjJ3dVpScGUwMzhQYmNXeHBIOXE0bmRSS0dzRDNJYWRM?=
 =?utf-8?B?UnUwWHFoS1loYitMczhmZUhXNG5JcGkycnBrUHdZKzZENks1STNPNk8zdS85?=
 =?utf-8?B?bXhiSm9HTDhwT3gzTTR0MmFpTTBPRk5Jdy9qUEl3cDJJYk9KT1F5dXlZMnpx?=
 =?utf-8?B?ZWR5NCtyOXhGWFhvSHpXYUxGWGgxdlkvOWNibk9ycFk3NHlYeFV4ZDNqUFRR?=
 =?utf-8?B?eC9NdG5OaThMTWszNG9CVFFkTW1Wa0Nvb0xVMTkyQ1ltSHpRb001S3pIOW4x?=
 =?utf-8?B?b2s1NEZiU2ZPNHR1cnNtSFVGZHNxV1B6YWlwbWYrQ0dRR09qKzlwR3JZSWNC?=
 =?utf-8?B?dHZtNHRZR1lBRFErL2NJQUdEeWpTVnYvTTRoNEJjYXZzZC9Fa3dTZThkcTQ5?=
 =?utf-8?B?R0g0VytWRUs4NHJnaVpNTDN3dVQvSHRJSllNN3MyS1hjajlLdmFYQ2pmclcy?=
 =?utf-8?B?MjYxRFE4NWhXZ3ptK0xwOExSUndoRVgrbTRGandDeTA5TlRTZW9MZDRPM0Zk?=
 =?utf-8?B?ZndSMzc2NDFKYlNkOWh2NXB0S1JQeUlQa0E5VEd1eXNLMXA5djN3WU55UmE3?=
 =?utf-8?B?RnFDRVliSGJtR2NVUnVyUHFYTnRhbUdsNnhEZCttSjFtYlNQbnVEa3Rlc2d1?=
 =?utf-8?B?b1dYS0ZyUDRVblB0UWhRU2ZIWTJkZVZCa2tFU1ZGWlQvdjI4NTVDTHZpYTZH?=
 =?utf-8?B?M1VlWi9Oejd1b2Z1VzVCNDFPQW0yRVljUmtZTUkrSytpVHpKMVQ2aFQzWmpW?=
 =?utf-8?B?aE5XdytpbzdFTzdMeldsNGhGTWZ6YUdWTG4vSVlla1lrT01YT05nbENEVVNO?=
 =?utf-8?B?SEJVd0I3dUw2bk5zTWFuSTh4dFk2Z09wVXdwdmp2UU5PTWM0SlZ1YkxmOHRr?=
 =?utf-8?B?d0xkblBwNllWdm9KZEV5TEhLRE51QUltK3dxS1A0dTBhU3pFdzluMTk2WFpa?=
 =?utf-8?B?YTVPWTJJMjJaRjRTRnlTbGc1ZEEzemUxSEd5cHkxSWp2Q1gyci83UnRQSVpH?=
 =?utf-8?B?R0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47044EB950DFB14B832109D88A6AE22A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc593de5-fe1a-4f4a-708d-08d9f0a87069
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 17:27:28.0141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nml3pkO7Bc5Ihvd05xd+BO+vrJZrqe/LgahyC1Z4J2cxfM7UuX4HyME6xnJfACEx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3862
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: V3swjvTD9TpbdzS9g9Ymh9uqoqhHRbuF
X-Proofpoint-ORIG-GUID: V3swjvTD9TpbdzS9g9Ymh9uqoqhHRbuF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-15_04,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 phishscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=683 impostorscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150100
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uLCAyMDIyLTAyLTE0IGF0IDIxOjExIC0wODAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
DQo+IFNvIGRvaW5nIGl0IHJpZ2h0IGFmdGVyIGVhY2ggc2VjdGlvbiByZWFsbHkgcG9sbHV0ZXMg
dGhlIGxheW91dCBvZiB0aGUNCj4gc2tlbGV0b24ncyBzdHJ1Y3QgYW5kIGh1cnRzIHJlYWRhYmls
aXR5IGEgbG90Lg0KPiANCj4gSG93IGFib3V0IGFkZGluZyBhbGwgdGhvc2UgX1N0YXRpY19hc3Nl
cnRzIGluIDxza2VsZXRvbl9fZWxmX2J5dGVzKCkNCj4gZnVuY3Rpb24sIGFmdGVyIHRoZSBodWdl
IGJpbmFyeSBkdW1wLCB0byBnZXQgaXQgb3V0IG9mIHNpZ2h0P8KgDQoNCkkgY2FuIGp1c3QgYWRk
IGEgYHZvaWQgX19hdHRyaWJ1dGVfXygodW51c2VkKSkgc2tlbGV0b25fX2Fzc2VydF9zaXplcygp
YCBhdCB0aGUNCmVuZD8gT3IgYSBgc3RydWN0IHNrZWxldG9uX190eXBlX2Fzc2VydHNgPyBJdCBm
ZWVscyB3ZWlyZCB0byBqdXN0IHB1dCB0aGVtIGluDQplbGZfYnl0ZXMsIHRoZXkgZG9uJ3QgYmVs
b25nIHRoZXJlLg0KDQo+IEkgdGhpbmsNCj4gaWYgd2UgYXJlIGRvaW5nIGFzc2VydHMsIHdlIG1p
Z2h0IGFzIHdlbGwgdmFsaWRhdGUgdGhhdCBub3QganVzdA0KPiBzaXplcywgYnV0IGFsc28gZWFj
aCB2YXJpYWJsZSdzIG9mZnNldCB3aXRoaW4gdGhlIHNlY3Rpb24gaXMgcmlnaHQuDQoNClN1cmUs
IGNhbiBkby4NCg0KDQo+IF9TdGF0aWNfYXNzZXJ0KHNpemVvZihzLT5kYXRhLT5pbjEpID09IDQs
ICJpbnZhbGlkIHNpemUgb2YgaW4xIik7DQo+IF9TdGF0aWNfYXNzZXJ0KG9mZnNldG9mKHR5cGVv
Zigqc2tlbC0+ZGF0YSksIGluMSkgPT0gMCwgImludmFsaWQNCj4gb2Zmc2V0IG9mIGluMSIpOw0K
PiAuLi4NCj4gX1N0YXRpY19hc3NlcnQoc2l6ZW9mKHMtPmRhdGFfcmVhZF9tb3N0bHktPnJlYWRf
bW9zdGx5X3ZhcikgPT0gNCwNCj4gImludmFsaWQgc2l6ZSBvZiByZWFkX21vc3RseV92YXIiKTsN
Cj4gX1N0YXRpY19hc3NlcnQob2Zmc2V0b2YodHlwZW9mKCpza2VsLT5kYXRhX3JlYWRfbW9zdGx5
KSwNCj4gcmVhZF9tb3N0bHlfdmFyKSA9PSAwLCAiaW52YWxpZCBvZmZzZXQgb2YgcmVhZF9tb3N0
bHlfdmFyIik7DQo+IA0KPiAodm9pZClzOyAvKiBhdm9pZCB1bnVzZWQgdmFyaWFibGUgd2Fybmlu
ZyAqLw0KPiANCj4gV0RZVD8NCg0KVGhhdCdzIGZpbmUgYnkgbWUsIEkgaGF2ZSBubyBvYmplY3Rp
b25zLiBJJ2xsIHNlZSBpZiBhIGZ1bmN0aW9uIG9yIGEgc3RydWN0IGlzDQptb3JlIHJlYWRhYmxl
LsKgDQoNCkkgc3VzcGVjdCBgU0laRV9BU1NFUlQoZGF0YSwgaW4xLCA0KTsgT0ZGU0VUX0FTU0VS
VChkYXRhLCBpbjEsIDApO2AgaXMgcHJvYmFibHkNCm1vc3QgcmVhZGFibGUgYnV0IEkgaGF0ZSB0
aGF0IEknZCBoYXZlIHRvIGluY2x1ZGUgdGhlIG1hY3JvcyBpbmxpbmUgKHRvIGVtaXQgdGhlDQpz
a2VsZXRvbiB0eXBlIG5hbWUpLg0KDQo+ID4gICAgICAgICByZXR1cm4gMDsNCj4gPiAgfQ0KPiA+
IA0KPiA+IEBAIC03NTYsNiArNzc5LDEyIEBAIHN0YXRpYyBpbnQgZG9fc2tlbGV0b24oaW50IGFy
Z2MsIGNoYXIgKiphcmd2KQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcblwNCj4gPiAgICAgICAg
ICAgICAgICAgI2luY2x1ZGUgPGJwZi9za2VsX2ludGVybmFsLmg+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXG5cDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxuXA0KPiA+ICsgICAgICAg
ICAgICAgICAjaWZkZWYgX19jcGx1c3BsdXMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBcblwNCj4gPiArICAgICAgICAgICAgICAgI2RlZmluZSBCUEZfU1RBVElDX0FT
U0VSVCBzdGF0aWNfYXNzZXJ0ICAgICAgICAgICAgICAgICAgICAgXG5cDQo+ID4gKyAgICAgICAg
ICAgICAgICNlbHNlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFxuXA0KPiA+ICsgICAgICAgICAgICAgICAjZGVmaW5lIEJQRl9TVEFUSUNfQVNT
RVJUIF9TdGF0aWNfYXNzZXJ0ICAgICAgICAgICAgICAgICAgICBcblwNCj4gPiArICAgICAgICAg
ICAgICAgI2VuZGlmICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXG5cDQo+IA0KPiBNYXliZSBqdXN0Og0KPiANCj4gI2lmZGVmIF9fY3BsdXNwbHVz
DQo+ICNkZWZpbmUgX1N0YXRpY19hc3NlcnQgc3RhdGljX2Fzc2VydA0KPiAjZW5kaWYNCj4gDQo+
ID8gT3IgdGhhdCBkb2Vzbid0IHdvcms/DQoNCkl0IGRvZXMgd29yaywgaXQncyBqdXN0IGxlc3Mg
ZXhwbGljaXQuIEknZCBiZSBoYXBweSB0byByZW1vdmUgdGhlIG1hY3JvDQpleHBhbnNpb24gb24g
dGhlIEMgcGF0aCB0aG91Z2gsIGl0IHdvdWxkIG1ha2UgZGlhZ25vc3RpY3Mgc2hvcnRlci4NCg0K
DQo+IEFsc28gYW55IHN1Y2ggbWFjcm8gaGFzIHRvIGJlICN1bmRlZiBpbiB0aGlzIGZpbGUsIG90
aGVyd2lzZSBpdCB3aWxsDQo+ICJsZWFrIiBpbnRvIHRoZSB1c2VyJ3MgY29kZSAoYXMgdGhpcyBp
cyBqdXN0IGEgaGVhZGVyIGZpbGUgaW5jbHVkZWQgaW4NCj4gdXNlcidzIC5jIGZpbGVzKS4NCg0K
TXkgYmFkLCBqdXN0IHRob3VnaHQgb2YgdGhhdCB0b28uDQoNCi0tDQoNClRvIHN1bW1hcml6ZSwg
c3RydWN0dXJhbGx5IEknbGwgZG8gdGhpczoNCg0KMS4gUHV0IHRoZW0gYWxsIGluIG9uZSBwbGFj
ZS4gKHRiZCB3aGF0IHR5cGUpDQoyLiBQdXQgdGhlbSBhdCB0aGUgZW5kIG9mIHRoZSBmaWxlLg0K
My4gQWRkIG9mZnNldHMuDQo0LiBGaXggdXAgdGhlIG1hY3JvIHVzYWdlLg0KDQo=
