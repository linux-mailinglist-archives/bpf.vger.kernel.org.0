Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991444CC581
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 19:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbiCCS6e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 13:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbiCCS6d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 13:58:33 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54801010
        for <bpf@vger.kernel.org>; Thu,  3 Mar 2022 10:57:43 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 223Ilx9K009308
        for <bpf@vger.kernel.org>; Thu, 3 Mar 2022 10:57:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=s1xXX0g4aKUFwux0t5dedaj0YNgQwV9Ij5WvaX6xb60=;
 b=mSht+EuXAf/E3W6nxTDVW094DwWGE1uXEn/wZA581EvrYL3ZNQVkey7YbPJePNijIazS
 PPcxNwRlpklBCZVQrT7oe/ebf1CUxMZIuSYG62nW9Q+Q273gRXAVXMuMRyNwUKXWALlz
 JJh+XSt35dXNAd2jyisINc8CoAZzLl+qFWw= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ejk2hwxdm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 03 Mar 2022 10:57:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aaz342miGJ23ZD5hRIkVXU2n2SPXGA5hu5z/r5m1Qp/zKkKaySfRzQmZWJx3ZlYFV6qOMrgkAmjKNEGNPBXwGnOWlladL+oxCXRt2BNB/Iq/nHh1JOua4rZmTjxPfVMcGluHwM7KVz/6UQUN8Po6Qrx/4tuvUjSUWTpfRYR6lu5MPgyFDi6hypNwtga/VoQWF33ejRi4Iy5xwq6ZwmtawnQV7R/f0T0eBqL9etGNjhqjhYqQsCbRm7IhtHVRkXlRxC4PpqwFTdJT5GLjJuB4oLKOar2zU4/lkAvgQce/VvaR3MNtxdX51BtMd/sPBCAyUyiyKwpOeMQ12UKreuUzwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1xXX0g4aKUFwux0t5dedaj0YNgQwV9Ij5WvaX6xb60=;
 b=XbroaC78d17v0ZzAk3RUkJu9V30Moodv75QGdP4U8LiJqA4pwlPMJdx6Y/eejHkFferbD6cLo8N/wzLRkA0cORQuoTUIIm8raJuZQRkNG79K9x+l0XsoSxHKkB75+rN8XxjE0IuGsVkOoDzCjjEkS/YoVeYQVlEAfj1ndb2xc51Pki/NubAdlnCHu+7+fvLVqiMIDfYXqyi53RRGEkwHvWRP0ZiY2m5OCrajeWZjpxCrC1Z2TYxDT9FkjmVVo/Q6RleCuf1FbBnLNCervz946ERac34eZ4QMVjSEF6fM090tr4sth3UPEl8qDRzze3NJQgzqtKzE4f40YoKIYfFUnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Thu, 3 Mar
 2022 18:57:32 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3%5]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 18:57:32 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/4] bpftool: add support for subskeletons
Thread-Topic: [PATCH bpf-next 2/4] bpftool: add support for subskeletons
Thread-Index: AQHYLeAOF8q5RjwbxUKWJ0TpgoNb3ays5SuAgAEewYA=
Date:   Thu, 3 Mar 2022 18:57:32 +0000
Message-ID: <9028e60f908d30d5f156064cebfd5af8d66c5c9c.camel@fb.com>
References: <cover.1646188795.git.delyank@fb.com>
         <a679538775e08c6f7686c2aec201589b47eda483.1646188795.git.delyank@fb.com>
         <CAEf4BzZzAToLHESKrddn2y1FoLHHUVGzJe7=1ih0E3EA7BBdHg@mail.gmail.com>
In-Reply-To: <CAEf4BzZzAToLHESKrddn2y1FoLHHUVGzJe7=1ih0E3EA7BBdHg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6851132c-69e0-4052-6afc-08d9fd47ac4a
x-ms-traffictypediagnostic: SN6PR1501MB2064:EE_
x-microsoft-antispam-prvs: <SN6PR1501MB20642148028B6396545E7E66C1049@SN6PR1501MB2064.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gaan66b6W5nREigaVjNblcgoh4Yzyl5acU8NyrxaxjA3knWIUZds/awF7XQi9AGLtVX97W4irKbEJB5fohecW52P0aXbYtA8Qxg8eaXvD2TEYYfKEyMiaOk6Oj3Xk2x9VrdKTjerWqEH5rQMqUIwZi97lfLWp766hetcCO/4S+dy3tqMkgAukkm62tmNbyVs1mcZ16EBp8oTPjgS6v97r78AYyKku/SDZ2ks01aWJfxL7mJfT8HSMYwxB4SqhXR/dd/xF0OsbwjjpijlZSwVA7fcdZXS5TbjO6nadwsPkIIe7cr7CL1Xn+HqNG3Slt0At+FBTir4876Y0vTcsTRT5EYJ12N2now5CrWd3Bnrhuw8vmxm1giLFXI0Paz1qVKy1/btO+pgTNuf4PqdIHyjCknUpVCK+m2YEdkkXIJ9SAd4ntIvFYTPPVs9fCea7U49tlaHTQwBJss+JMgDCdpl9sop4H7WosHvrJ5KIpohGKxZTmNlcGONQflg7oeEJh5+1GEautKJLBh35qQG/18LOlYfdMRnoe4nyoSJ068OwMY4kgQ52lHONbn9MnVn5Tuuy3dr32Ngvm26BU9Pn0govCFP32px7syTlNijOiO2UdkdpBchRdMgjy9AX2s6eO7FF3YPenLcBpZJ6cD5cXRJWiMrwyb15v3S9PxhCUuB+CJoEZIImBg9rRkXDFjeOqYD0OIWoIW5ssUBCrrB1z0CNA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(66476007)(2616005)(6916009)(6486002)(83380400001)(316002)(508600001)(122000001)(66556008)(76116006)(66946007)(5660300002)(64756008)(8936002)(86362001)(8676002)(4326008)(66446008)(6512007)(6506007)(26005)(186003)(54906003)(38100700002)(38070700005)(71200400001)(36756003)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ak9SYkd4MVgxRDRYVHI1NmIzdGZkZEppVHBUQmFkTlVMT251TFNOci9iVGFV?=
 =?utf-8?B?QTdzbE9JWUIrWkJXN3Q2OXJaWDcwTmM3VUhqQ1B5N2hNZFZodmVCMFlSZGFC?=
 =?utf-8?B?dFNHOHFadWkyYnlodXJqMzNqdlJsc1duRTRRekF0Uy9maDlZelJEcWptKzZw?=
 =?utf-8?B?Y2p3V1RlL1pXS0tXNlU0OUNEOTJ6ZWtxaWJPYXpwTTFZNUpNR29NOVlpbCtx?=
 =?utf-8?B?TzhOZDYyNVlwWXdiSFNsTWZReU84eDZDUUovRHJDZ0ZIZTNZeW1NSUMrY2V5?=
 =?utf-8?B?eXFvQzE5V3RQa2VUcnV2aXd5ZkVHeVUvUmZZQjNsZXFmMzZSZUdkQk1UaXpL?=
 =?utf-8?B?YjlCRVc1dndUY2VxQTVqdGFGdFViNUpOTGUxS2ZGOUhMUnowNmRsTEJ2ek1U?=
 =?utf-8?B?L0tYN3NOanY3SksrM2Yxc1phaFMrdGlBcmVhYVNqK1BpYTJEbm1JS3p4V3dC?=
 =?utf-8?B?VkpVcHRPN0NHT3VPK1RidDNxYkhUSEVKWk9US2Y1d0J5OHhuYVZQY0lGeHVH?=
 =?utf-8?B?b1FKSDIxbWZCZ0w1b3BXd0Q0dUpNeUdEVFdNYlVMTVlOcGw5U3BrNFZmZ3hD?=
 =?utf-8?B?Z3ArQXlZN0xjaXVEbjRmYTV5RkQrdjRiUmJTVHV5OGE3WXN0UGhCcEJWQ1ZZ?=
 =?utf-8?B?NEhLNUZoZGxvdHp2SzJyWWlLTFNrQmhIT0VwNWtub0ZKUk5OMFNqMlp0eUV2?=
 =?utf-8?B?QjZzclhheGVwOCthc0FUclVaa0U5L1hMZzJYSjc4M0dKQ0xjVnVnRzYvMndn?=
 =?utf-8?B?S3FPUnhYSW01Y3FGdW92Q2dLekNKOTFnL2hmV1R6V1R0NHJJREtFLzZ0a1VW?=
 =?utf-8?B?WVU4dGk0NUdpYkRMMGRRM2VPUjVQbVRRYkYxUTF5eVd1YkpLejhPSDdrUWxX?=
 =?utf-8?B?YTRpN2pndzY0dlRaVFBFbllod1J6OERGdFZYNU9KNm9GS1hiWWY0ZVBwTXk0?=
 =?utf-8?B?aDFnS3BjU0lrcTJjS1VmM3pHZ01CajZja2VJWjlVK3hHMUxxRkpUV2FvNmRq?=
 =?utf-8?B?R09xRVl1TzFiaXhwQ1JyYmlUWS9qVHNub2kvcm5nbGdzM0dFZURId25EMkRu?=
 =?utf-8?B?S01QakRFa2FTMWtUSnZxVWxaaDdFaEpjTk5IeG9iQXFkdllCZ1haYzFCaDI1?=
 =?utf-8?B?TzU2MnhvR1gySVVWdDZoZ2hHeENiNjRUcFR5Yi85ZDk1ZXFDV3dYaUpDNlNW?=
 =?utf-8?B?RXlWcmJObjJJRitXeGNmNjBWY053YkdwODhqdVJ4ZmM2NVVyT0NKalpRdFlw?=
 =?utf-8?B?NmtZSUxEMEsydnphUGFha1NPY3FzeStjSGdXUmlsWjViRUR6K05vaitGVkxO?=
 =?utf-8?B?NFJLcVNZWEtTNnV1eGw0bTFCYSs0SHV5OUo5a202SGxWMTdwYk44L01CZVU4?=
 =?utf-8?B?aUg2dmdBYkVURWtmMEJJMThCVmtIdmtFMXQ5UGhsM0hvcWNpODZXWnFTRnhW?=
 =?utf-8?B?Z3Y1WnpVd1Y5aGR6Q0oxS3E4K3Z0RHZiLzRXVHBOcXFoMUZnSU9xcUZHak9Y?=
 =?utf-8?B?NmVHdGU5dkIyS21GbDdYbnV4L3NXVnMvM0pZZmFMdG8yVVZESjJQNTRRRTNs?=
 =?utf-8?B?N0xtWlByOGpGYVZvemlXY1BSdGE1VDdjR3BIRURROVR2a0kvZHgzSzlrR1J0?=
 =?utf-8?B?VWJmRnZpSUtTdXJZbGQrMlFnSHplbmthdlR5UGhjRUtYM1FEbzZub0YvNzBi?=
 =?utf-8?B?aDZrWEpndWlsVlhUQnlvWlp3dGpBakF5aTJyVWwvTnFhWHRua25NTG1YVDVp?=
 =?utf-8?B?ZStFc2ViN3ExY3ErQVh5ZTA4Z1U5Z1U5WnlSUnY0c1VhYlFzK2U3V3hEbVZ3?=
 =?utf-8?B?bW1rblhRODNDLzU5RWl1aHhNRElBaUFOL0YzZmtmSTNINmVrREhwWXFjcG9J?=
 =?utf-8?B?TzJyTSthV2FVZDYxOU1QMXNZZGFoRjBxYzc0c25OVElaOXpMbDVmUy9BVXdP?=
 =?utf-8?B?bEVkMU4yT0ZrNXU4TktWOFFqeU55eW5kNXhBL3RYY1NUZEx6M1BTRjViekE4?=
 =?utf-8?B?aUF4VnZ5a3dodXpBUGxkb2xOeTdwdk8wQzV3Q2xyeC9JS3U3NXhlUFNHTWJD?=
 =?utf-8?B?cUIyQ3RuS3FuaDBnZWJVRXZyaFRsZkVCZVNTV1V6Z0RBZVlzMlc4Mmovc3Vr?=
 =?utf-8?Q?O+4U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6C304DDA5678B41BAE6190082A4D275@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6851132c-69e0-4052-6afc-08d9fd47ac4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 18:57:32.3918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IQnWutSBYgAN3NJwFtO1wMVOMpZcze5d76LhVfpte2fWH99JbKb6KmfBzRpkysvL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2064
X-Proofpoint-ORIG-GUID: W8icbtPCeQtKwcHiFDk2IlY6ZiI8_p6p
X-Proofpoint-GUID: W8icbtPCeQtKwcHiFDk2IlY6ZiI8_p6p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-03_09,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1011
 bulkscore=0 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203030086
X-FB-Internal: deliver
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

VGhhbmtzIEFuZHJpaSBmb3IgdGFraW5nIGEgdGhvcm91Z2ggbG9vayENCg0KT24gV2VkLCAyMDIy
LTAzLTAyIGF0IDE3OjQ2IC0wODAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6DQo+IFRoZXJlIGlz
IGEgbmVlZCAoSSBuZWVkZWQgaXQgaW4gbGlidXNkdCwgZm9yIGV4YW1wbGUpLiBMZXQncyBhZGQg
aXQNCj4gZnJvbSB0aGUgdmVyeSBiZWdpbm5pbmcsIGVzcGVjaWFsbHkgdGhhdCBpdCBjYW4gYmUg
ZG9uZSBpbiAqZXhhY3RseSoNCj4gdGhlIHNhbWUgZm9ybSBhcyBmb3Igc2tlbGV0b25zLg0KDQpB
YnNvbHV0ZWx5LCBJJ2xsIGdldCB0aGF0IGludG8gdGhlIG5leHQgdmVyc2lvbiENCg0KPiBzZWVt
cyBsaWtlIHN1YnNrZWwncyBkYXRhc2VjIGNvZGVnZW4gaXMgY29uc2lkZXJhYmx5IGRpZmZlcmVu
dCAoYW5kDQo+IHNpbXBsZXIsIHJlYWxseSkgdGhhbiBza2VsZXRvbidzLCBJJ2QgYWRkIGEgc2Vw
YXJhdGUgZnVuY3Rpb24gZm9yIGl0DQo+IGluc3RlYWQgb2YgYWxsIHRoaXMgaWYgKHN1YnNrZWwp
IHNwZWNpYWwtY2FzaW5nLiBNYWluIGNvbmNlcm4gZm9yDQo+IHNrZWxldG9uIGlzIGdlbmVyYXRp
bmcgY29ycmVjdCBtZW1vcnkgbGF5b3V0LCB3aGlsZSBmb3Igc3Vic2tlbCB3ZQ0KPiBqdXN0IG5l
ZWQgdG8gZ2VuZXJhdGUgYSBsaXN0IG9mIHBvaW50ZXJzIHdpdGhvdXQgYW55IHJlZ2FyZCB0byBt
ZW1vcnkNCj4gbGF5b3V0Lg0KDQpJJ20gbm90IDEwMCUgY29udmluY2VkIGdpdmVuIGhvdyBtdWNo
IGNvZGUgd291bGQgZW5kIHVwIGJlaW5nIGR1cGxpY2F0ZWQgYnV0IEkNCmNhbiBnbyBpbiB0aGF0
IGRpcmVjdGlvbiwgaWYgeW91J2QgcHJlZmVyIGl0Lg0KDQo+IA0KDQo+IGl0J3MgdW5mb3J0dW5h
dGUgdG8gaGF2ZSB0byBtb2RpZnkgb3JpZ2luYWwgQlRGIGp1c3QgdG8gaGF2ZSB0aGlzICcqJw0K
PiBhZGRlZC4gIElmIEkgcmVtZW1iZXIgY29ycmVjdGx5LCBDIHN5bnRheCBmb3IgcG9pbnRlcnMg
aGFzIHNwZWNpYWwNCj4gY2FzZSBvbmx5IGZvciBhcnJheXMgYW5kIGZ1bmMgcHJvdG90eXBlcywg
c28gaXQgc2hvdWxkIHdvcmsgd2l0aCB0aGlzDQo+IGxvZ2ljIChub3QgdGVzdGVkLCBvYnZpb3Vz
bHkpDQo+IA0KPiAxLiBpZiB0b3AgdmFyaWFibGUgdHlwZSBpcyBhcnJheSBvciBmdW5jX3Byb3Rv
LCBzZXQgdmFyX2lkZW50IHRvICIoKjx2YXJpYWJsZT4pIg0KPiAyLiBvdGhlcndpc2Ugc2V0IHZh
cl9pZGVudCB0byAiKjx2YXJpYWJsZT4iDQo+IA0KPiB3ZSdkIG5lZWQgdG8gdGVzdCBpdCBmb3Ig
YXJyYXkgYW5kIGZ1bmNfcHJvdG8sIGJ1dCBpdCBkZWZpbml0ZWx5DQo+IHNob3VsZCB3b3JrIGZv
ciBhbGwgb3RoZXIgY2FzZXMNCg0KQSBjb3VwbGUgb2YgdGhvdWdodHMgaGVyZToNCg0KMS4gV2Ug
YXJlIG5vdCBtb2RpZmluZyB0aGUgb3JpZ2luYWwgQlRGLCB3ZSBhcmUgbGF5ZXJpbmcgaW4tbWVt
b3J5LW9ubHkgdHlwZXMgb24NCnRvcCBvZiBpdC4gVGhpcyBlbmRzIHVwIHdvcmtpbmcgdHJhbnNw
YXJlbnRseSB0aHJvdWdoIGJ0Zl9kdW1wIGNvZGUsIHdoaWNoIGlzDQp0aGUgc291cmNlIG9mIHRy
dXRoIG9mIHdoYXQgImNvcnJlY3QiIGlzLiBJIHRoaW5rIHRoaXMgaXMgc3RyaWN0bHkgYmV0dGVy
IHRoYW4NCnRoZSBhbHRlcm5hdGl2ZSB0ZXh0dWFsIG1vZGlmaWNhdGlvbnMgdG8gdmFyX2lkZW50
Lg0KDQoyLiBJIGd1ZXNzIHdlIHNlZSB0aGUgY2hhbmdlIGRpZmZlcmVudGx5IC0gdG8gbWUgaXQn
cyBub3QganVzdCBhYm91dCBhZGRpbmcgYW4NCmFzdGVyaXNrIGJ1dCBpbnN0ZWFkIHdvcmtpbmcg
d2l0aCBkZXJpdmF0aXZlIHR5cGVzLiBUaGlzIG1pZ2h0IGNvbWUgaW4gaGFuZHkgaW4NCm90aGVy
IGNvbnRleHRzIHRoYXQgd2UgaGF2ZW4ndCBlbnZpc2lvbmVkIHlldCBhbmQgSSBmZWVsIGlzIGEg
ZGlyZWN0aW9uIHdvcnRoDQpzdXBwb3J0aW5nIG92ZXJhbGwuDQoNCjMuIFdlIGhhdmUgYSBmdWxs
IHR5cGUgc3lzdGVtIHdpdGggbGF5ZXJpbmcgYW5kIG1peGVkIGZpbGUtIGFuZCBtZW1vcnktYmFz
ZWQNCnN0b3JhZ2UuIFdoeSBsaW1pdCBvdXJzZWx2ZXMgdG8gdGVtcGxhdGluZyBpbnN0ZWFkIG9m
IHVzaW5nIGl0IGluIHRoZSBjb2RlZ2VuPw0KSWYgSSB3ZXJlIHdyaXRpbmcgdGhpcyBmcm9tIHNj
cmF0Y2gsIG11Y2ggb2YgY29kZWdlbl9kYXRhc2VjcyB3b3VsZCBpbnN0ZWFkDQpjcmVhdGUgaW4t
bWVtb3J5IEJURiB0eXBlcyBhbmQgaGF2ZSBidGZfZHVtcCBlbWl0IHRoZW0gKGJ1dCB0aGF0J3Mg
bm90IHRoZQ0KYmlrZXNoZWQgSSB3YW50IHRvIHBhaW50IGhlcmUhKS4NCg0KPiA+ICsgICAgICAg
Y2hhciBoZWFkZXJfZ3VhcmRbTUFYX09CSl9OQU1FX0xFTiArIHNpemVvZigiX19TS0VMX0hfXyIp
XTsNCj4gDQo+IHVzZSBfX1NVQlNLRUxfSF9fIGhlcmU/DQoNClN1cmUsIEkgY2FuIGludHJvZHVj
ZSB0aGUgLnN1YnNrZWwuaCBzdWZmaXggZXZlcnl3aGVyZS4NCg0KPiANCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICBzdHJuY3B5KG9ial9uYW1lLCAqYXJndiwgTUFYX09CSl9OQU1FX0xFTiAt
IDEpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIG9ial9uYW1lW01BWF9PQkpfTkFNRV9M
RU4gLSAxXSA9ICdcMCc7DQo+IA0KPiB3ZSBzaG91bGQgcHJvYmFibHkgZm9yY2Ugb2JqX25hbWUg
dG8gYmUgYW4gZW1wdHkgc3RyaW5nLCBzbyB0aGF0IGFsbA0KPiBtYXAgbmFtZXMgbWF0Y2ggdGhl
aXIgcHJvcGVyIHNlY3Rpb24gbmFtZXMNCg0KQWgsIG1heWJlIHRoaXMgaXMgd2h5IGJwZl9tYXBf
X25hbWUgd2FzIG5vdCBkb2luZyB0aGUgcmlnaHQgdGhpbmcgYmVmb3JlLiBJDQpkb24ndCByZWFs
bHkgbGlrZSB0aGF0IHdlJ3JlIHJlbHlpbmcgb24gc2lkZSBlZmZlY3RzIG9mIHRoZSBlbXB0eSBv
YmpfbmFtZSBidXQNCkknbGwgdHJ5IGl0IGFuZCBzZWUgaWYgYW55dGhpbmcgYnJlYWtzICh0aGUg
dGVtcGxhdGluZyBmb3Igb25lIHdpbGwgbmVlZCBpdA0KYW55d2F5KS4NCg0KPiANCj4gPiArICAg
ICAgIGlmICh2ZXJpZmllcl9sb2dzKQ0KPiA+ICsgICAgICAgICAgICAgICAvKiBsb2dfbGV2ZWwx
ICsgbG9nX2xldmVsMiArIHN0YXRzLCBidXQgbm90IHN0YWJsZSBVQVBJICovDQo+ID4gKyAgICAg
ICAgICAgICAgIG9wdHMua2VybmVsX2xvZ19sZXZlbCA9IDEgKyAyICsgNDsNCj4gDQo+IGhtLi4g
d2Ugc2hvdWxkbid0IG5lZWQgdGhpcywgd2UgYXJlIG5vdCBsb2FkaW5nIGFueXRoaW5nIGludG8g
a2VybmVsDQo+IGFuZCBkb24ndCB1c2UgbGlnaHQgc2tlbGV0b24NCg0KWW91J3JlIHJpZ2h0LCB3
aWxsIHJlbW92ZS4NCg0KPiANCj4gPiArICAgICAgIG9iaiA9IGJwZl9vYmplY3RfX29wZW5fbWVt
KG9ial9kYXRhLCBmaWxlX3N6LCAmb3B0cyk7DQo+ID4gKyAgICAgICBlcnIgPSBsaWJicGZfZ2V0
X2Vycm9yKG9iaik7DQo+IA0KPiBubyBuZWVkIGZvciBsaWJicGZfZ2V0X2Vycm9yKCkgYW55bW9y
ZSwgYnBmdG9vbCBpcyBpbiBsaWJicGYgMS4wIG1vZGUsDQo+IHNvIGl0IHdpbGwgZ2V0IE5VTEwg
b24gZXJyb3IgYW5kIGVycm9yIGl0c2VsZiB3aWxsIGJlIGluIGVycm5vDQoNCkFoLCB5ZXMsIEkg
d29uJ3QgYWRkIG5ldyBjYWxsc2l0ZXMuDQoNCj4gDQo+ID4gDQo+ID4gKyAgICAgICAgICAgICAg
IG1hcF90eXBlX2lkID0gYnRmX19maW5kX2J5X25hbWVfa2luZChidGYsIGJwZl9tYXBfX3NlY3Rp
b25fbmFtZShtYXApLCBCVEZfS0lORF9EQVRBU0VDKTsNCj4gDQo+IGlmIHdlIHNldCBvYmpfbmFt
ZSB0byAiIiwgYnBmX21hcF9fbmFtZSgpIHNob3VsZCByZXR1cm4gRUxGIHNlY3Rpb24NCj4gbmFt
ZSBoZXJlLCBzbyBubyBuZWVkIHRvIGV4cG9zZSB0aGlzIGFzIGFuIEFQSQ0KPiANCj4gDQo+IG9o
LCBidXQgYWxzbyBicGZfbWFwX19idGZfdmFsdWVfdHlwZV9pZCgpIHNob3VsZCBnaXZlIHlvdSB0
aGlzIElEIGRpcmVjdGx5DQoNClRJTCwgdGhhdCdzIG5vdCBvYnZpb3VzIGF0IGFsbC4gVGhlcmUn
cyBhIGZldyBwbGFjZXMgaW4gZ2VuLmMgdGhhdCBjb3VsZCBiZQ0Kc2ltcGxpZmllZCB0aGVuIC0g
ZmluZF90eXBlX2Zvcl9tYXAgZ29lcyB0aHJvdWdoIHNsaWNpbmcgdGhlIGNvbXBsZXRlIG5hbWUg
YW5kDQp3YWxraW5nIG92ZXIgZXZlcnkgQlRGIHR5cGUgdG8gbWF0Y2ggb24gdGhlIHNsaWNlLiBJ
cyB0aGVyZSBzb21lIGNvbXBhdGliaWxpdHkNCnJlYXNvbiB0byBkbyB0aGF0IG9yIGlzIGJ0Zl92
YWx1ZV90eXBlX2lkIGFsd2F5cyB0aGVyZT8NCg0KPiANCj4gPiArICAgICAgICAgICAgICAgZm9y
IChpID0gMCwgdmFyID0gYnRmX3Zhcl9zZWNpbmZvcyhtYXBfdHlwZSksIGxlbiA9IGJ0Zl92bGVu
KG1hcF90eXBlKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICBpIDwgbGVuOw0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgIGkrKywgdmFyKyspIHsNCj4gDQo+IG5pdDogbW92ZSB0aG9zZSBsb25n
IG9uZS10aW1lIGFzc2lnbm1lbnRzIG91dCBvZiB0aGUgZm9yKCkgbG9vcCBhbmQNCj4ga2VlcCBp
dCBzaW5nbGUtbGluZT8NCg0KWWVhaCwgSSBoYXRlIHRoYXQgc3RydWN0dXJlIHRvbywgSSdsbCBj
bGVhbiBpdCB1cC4NCg0KPiANCj4gPiANCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAo
IXN1YnNrZWwpIHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXG5cDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlcnJubyA9IEVOT01FTTsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFxuXA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIE5VTEw7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcblwNCj4gDQo+
IGxlYWtpbmcgb2JqIGhlcmUNCg0KWWVhaCwgSSBub3RpY2VkIHRoYXQgSSBkaWRuJ3QgdXNlIF9f
ZGVzdHJveSBpbiB0aGUgc3Vic2tlbCwgd2lsbCBmaXggZm9yIHYyLg0KDQoNCj4gPiArICAgICAg
IC8qIHdhbGsgdGhyb3VnaCBlYWNoIHN5bWJvbCBhbmQgZW1pdCB0aGUgcnVudGltZSByZXByZXNl
bnRhdGlvbg0KPiA+ICsgICAgICAgICovDQo+IA0KPiBuaXQ6IGtlZXAgdGhpcyBjb21tZW50IHNp
bmdsZS1saW5lZD8NCg0KSSBkaWQgaW5pdGlhbGx5IGFuZCBjaGVja3BhdGNoIHNjb2xkZWQgbWUg
OikgDQoNCj4gDQo+ID4gKyAgICAgICBicGZfb2JqZWN0X19mb3JfZWFjaF9tYXAobWFwLCBvYmop
IHsNCj4gPiArICAgICAgICAgICAgICAgaWYgKCFicGZfbWFwX19pc19pbnRlcm5hbChtYXApKQ0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiA+ICsNCj4gPiArICAgICAg
ICAgICAgICAgaWYgKCEoYnBmX21hcF9fbWFwX2ZsYWdzKG1hcCkgJiBCUEZfRl9NTUFQQUJMRSkp
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+ID4gKw0KPiA+ICsgICAg
ICAgICAgICAgICBpZiAoIWdldF9tYXBfaWRlbnQobWFwLCBpZGVudCwgc2l6ZW9mKGlkZW50KSkp
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+IA0KPiB0aGlzIHNlcXVl
bmNlIG9mIGlmcyBzZWVtcyBzbyBmcmVxdWVudGx5IHJlcGVhdGVkIHRoYXQgaXQncyBwcm9iYWJs
eQ0KPiB0aW1lIHRvIGFkZCBhIGhlbHBlciBmdW5jdGlvbj8NCg0KSXQgaXMgYW5kIGl0J3MgYW5u
b3lpbmcgbWUgdG9vLiBJJ2xsIGxvb2sgYXQgdGhlIHdob2xlIGl0ZXJhdGlvbiBwYXR0ZXJuIG1v
cmUNCmNsb3NlbHkuDQoNCj4gDQo+IA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGNvZGVn
ZW4oIlwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBcblwNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHN5bXNbJTQkZF0ubmFtZSA9IFwiJTEkc1wiOyAgICAgICAgICAg
ICAgICAgXG5cDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzeW1zWyU0JGRd
LnNlY3Rpb24gPSBcIiUzJHNcIjsgICAgICAgICAgICAgIFxuXA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc3ltc1slNCRkXS5hZGRyID0gKHZvaWQqKikgJm9iai0+JTIkcy4l
MSRzOyBcblwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAiLCB2YXJfaWRlbnQsIGlkZW50
LCBicGZfbWFwX19zZWN0aW9uX25hbWUobWFwKSwgc3ltX2lkeCk7DQo+ID4gKyAgICAgICAgICAg
ICAgIH0NCj4gPiArICAgICAgIH0NCj4gDQo+IHdoeSBub3QgYXNzaWduIHN1YnNrZWwtPnN5bV9j
bnQgaGVyZSB1c2luZyBzeW1faWR4IGFuZCBhdm9pZCB0aGF0DQo+IGV4dHJhIGxvb3Agb3ZlciBh
bGwgdmFyaWFibGVzIGFib3ZlPw0KDQpHb29kIGNhbGwsIHdpbGwgZG8uDQo+IA0KPiBRdWVudGlu
IHdpbGwgcmVtaW5kIHlvdSB0aGF0IHlvdSBzaG91bGQgYWxzbyB1cGRhdGUgdGhlIG1hbiBwYWdl
IGFuZA0KPiBiYXNoIGNvbXBsZXRpb24gc2NyaXB0IDopDQoNCkFoLCB5ZXMsIGdsYWQgdG8gc2Vl
IGl0J3MgcnN0IGFuZCBJIGRvbid0IGhhdmUgdG8gc3VmZmVyIGdyb2ZmL21kb2MgZmxhc2hiYWNr
cyENCg0KVGhhbmtzLA0KRGVseWFuDQoNCg==
