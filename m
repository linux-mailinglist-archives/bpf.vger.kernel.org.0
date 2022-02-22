Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C714C0337
	for <lists+bpf@lfdr.de>; Tue, 22 Feb 2022 21:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbiBVUgf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Feb 2022 15:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235532AbiBVUgQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Feb 2022 15:36:16 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2523D148931
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 12:35:28 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 21MHOwvp005654
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 12:35:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=My/DUGrjHs6hNsQmuRa2p7+wUFZPRZAlKfjnbGPFKFs=;
 b=n+6JNdDTzTuaAJyqH7yFflAXygnGCKNpFrgY4c7oJNC4wDt+5zVBIK48HPKK2VRFf7PX
 uBZt5Qesn1w1yGYbposDrGgIdUNxSB79tmgfl2SYUY4zkjRe12TQfyWVxV5KJYlKGSxP
 Yi9UKASGTlGvSyxIU5xjVEAwTo5xFkvBOqE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3ec7wet3fr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 12:35:28 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Feb 2022 12:35:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgG75U35W0rOIhzYMcBmRwS2eLIDoKUfxfBVs4ZVzXaH3PXFtmz9rgZEh6n6yI78zMUxR82Z8dO+7zozz3x4jLmt0HpMcAAT2zyLNtTQgnh4bIMZaiGzd+3JcZWJdkwIPwgxbKmM6BVhGjbyL3+8IYivzoFYrL3Z4jH23Zrz5dgHYtQygwhX32U8MjQAa8OlMb62lw90o2Y4qCv8+WHCQb82ZgnYh6ow5GdTT58UIXOfkCR7Yt4LnZ+tz75wepyUAPfczRTkKsVUhOssQQLGmi4j5FLRqI+1sMJo08EsSIPAwy6bbl9qR2P4MrXn4ZTQqvm8coUxupIV++iC/SJa2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=My/DUGrjHs6hNsQmuRa2p7+wUFZPRZAlKfjnbGPFKFs=;
 b=Rtu70pK8cGld7TyDClOHfAiRQzjZ0yworO2DGhEvpwMlEPhsUip8glbhIh6Y36acGN4ZBP32Fji/6yEO7G6ZljKTKoFUC4umT8JQCrw+jytmHIHqqWX+8+yHQB1mkO3CfQxjNL0421I1iFUf/kmLMldPTX5eSf2Zw7s8Wp2ZSeH6oGqSO67YhNSwVwRWTgYlYAqP/vTc23GLcDz8intan2RpqYw6Bg3VHNYWAWPdGTCO5AWqsGtFWifkEeF9pStYi25jwdZFTR5ly2t3FnQm9z5e+qmZcQLMiExe5TzZ5AHq2644elnq8EW650CCNegXGCuCh8FmY6oWpPijSE1wvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4732.namprd15.prod.outlook.com (2603:10b6:303:10d::15)
 by MN2PR15MB3408.namprd15.prod.outlook.com (2603:10b6:208:3c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Tue, 22 Feb
 2022 20:35:15 +0000
Received: from MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::79fb:4741:b90a:e871]) by MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::79fb:4741:b90a:e871%7]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 20:35:15 +0000
From:   Mykola Lysenko <mykolal@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Mykola Lysenko <mykolal@fb.com>, bpf <bpf@vger.kernel.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next] Improve BPF test stability (related to perf
 events and scheduling)
Thread-Topic: [PATCH bpf-next] Improve BPF test stability (related to perf
 events and scheduling)
Thread-Index: AQHYJSfioyDZvWe6RkC/s6CQJwCsIqyb3UMAgAQv0AA=
Date:   Tue, 22 Feb 2022 20:35:15 +0000
Message-ID: <22435EA9-9336-4978-819A-0F91EFDBEA9E@fb.com>
References: <20220219003004.1085072-1-mykolal@fb.com>
 <CAEf4BzahKEObA_quad2M5Rmn42yPCNFAvVUtPVthFi2jPYNpmg@mail.gmail.com>
In-Reply-To: <CAEf4BzahKEObA_quad2M5Rmn42yPCNFAvVUtPVthFi2jPYNpmg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f9002e7-79a7-41e9-5f2d-08d9f642d507
x-ms-traffictypediagnostic: MN2PR15MB3408:EE_
x-microsoft-antispam-prvs: <MN2PR15MB34085DCDC0A8E9FE3A8A54A8C03B9@MN2PR15MB3408.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZHsEAKcrT5Tl60psaaiA7o7QZ2zI1qnH4VZVJDBfcSgUX1OBaRQROruGueDm0gsST27OgxUx8TFFXpT05jpHecOzZ5qovk4e2WwwagKC/rC/4m6oGUqzK3IEw0MygVP01NqvHP1T6RFTqHkQmXRgc1CQIvUculafuVXxF7I4+poBw1Z9KKwX2e3opfT4+NF49ouwZIrdT6+aC41fA+AHtrN6B0rqgqtszJmnj8xRTVm1mbcHoWZdhsLEifHlauMDzwsw+S3yGQGolmt52AY6CAmwy1knqI0q2Iix5kymJxgIDdQ7FOnQjWTmDSCOxm29KTJCOVE0SOisV0Ih5989ee2aXO0QEQPVaSSSB/snvyauuLDNJWZAFAhbrbRqVxwj4xrLmdhemD2LK424qRmd8AqsAMEXudYZ/VthN/cfITOeTo/yskaCnQahBBtgz6S8rjlfLGNVsaDpNfOOKt+7Pq5EJw/iApAb5LxDm7nvwvDiVn18OlrROR8mG1GKTciGrVgocTHANdnebsKAtWbQa6gzLLDdY8tzA8e006ExhoavOarKUfZkNm5EsD1Bu9YUK7ZtGlvfXI/4ZcA8aAtrB+bpu2SPvGyXFgPszGTTHNNeLWb4PLu94Gy+d8a/22X4LQdieDx6ZWw1mULVPLiASWN1d/0p7UkuxOiJUR2AovubMiPZ9eL/gtz8zVgGwve697FXb9jHHpfUb2VLjSY2shRNzMYGofSfjy5J5J6ULI8A9IdJq0a2T7XENazKJepE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4732.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(2616005)(186003)(5660300002)(122000001)(6512007)(38100700002)(8936002)(86362001)(2906002)(316002)(66556008)(71200400001)(83380400001)(36756003)(66476007)(66446008)(76116006)(64756008)(66946007)(6916009)(54906003)(53546011)(6506007)(6486002)(33656002)(8676002)(508600001)(4326008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmpnRGJEVGtHUzQ1WjlnWFZpUXRYODVpRDkwUEJiaWFNN2VGV0U1TlVMRFlW?=
 =?utf-8?B?VHNSM2l6dEZjYks0M3ZSNk5VbGpNL3VQNXBZdHcrVmFwczdJU2JXWFIxT2tN?=
 =?utf-8?B?NG1GNk5RZlV5eHUrUXg2WjJXbElkZDNsQjQzYWZGbThCQUx5L3kyWk44Ylky?=
 =?utf-8?B?N2tBNHBDM3Qwb0dtV1NsV3EyaTVJN295K1RiMm1keTNrMlhPVVdvbVphVWtS?=
 =?utf-8?B?VzY2MU9Zb3FVbzNZMmFwNTJQNjBMdmRSTGFZWFoycEM5bk1yekNHZmdzMzhv?=
 =?utf-8?B?UVVDZms0OGpHY1BLODF6by84ajQ1RzVWcE1XeWpNcVNmazNQUVNrUjJRcElN?=
 =?utf-8?B?Yk1idlNMVXZXQ2lDTTVIenBkblpHU1R1NE13TXkxMUxkaXN1NWZPYWN0N3FG?=
 =?utf-8?B?ejh6OE9zRnBwL1RnZ0poQjVxK1A5R2d5N1NCckFFVHdsU1UyNVVnek1GbXFC?=
 =?utf-8?B?OFVhSDk5VHFqanB2UC9NajgzOTRsZXludjdodm0raDc0c2xjdHNyV1V1MS8w?=
 =?utf-8?B?WWJ5cjNTYkxLQmtCUU9qZldBcWxyVXZmeDhLbWt2SDhqMGRBVExYNjBZUzNX?=
 =?utf-8?B?dENaM3k4ZkhpaFhUQnQ1TkhYclBCWTUzN256Sm5JTmlQOWQzOTBxOVFXRElv?=
 =?utf-8?B?MkZjRnJ4SEVNUklwVjlubEo5bkhhM0J5SFdyR3ZPdHp4R3RmZXUvZzljeE9R?=
 =?utf-8?B?c0UzTFduN0V0NXozeHA1ZituUUZXTnpQaGhlYzdQSkpUMHdub0V3RFhORTlZ?=
 =?utf-8?B?YTRqeGtiZ0I2V3grOFFRMXphTWlRVVdNLzQ5TVZiQUtYbFRoSnNJQU9IQzl6?=
 =?utf-8?B?bnJjUXMyYVVqOVMyNStBOFlKWngydkxvWUQ3bWxLbFgvWC91bmQyMGtPZWR3?=
 =?utf-8?B?NmZzVWZ3R2o3WXM0NEFCelpEODlJcFB3WmJjN3lGcFRFUm1GKzRXUnpoL1FS?=
 =?utf-8?B?OEI5RzFGZHJTMXUwL2M2ZlJ0eHdRY1JGZStjaWlNRytJa1FMNGQrVzJqZHYx?=
 =?utf-8?B?Q1RuTG1uY0ZGN25qT1MzeVF1WnBtWU85OHJ0ZENaK1V5TU9abW4xcnRVd2tp?=
 =?utf-8?B?dEFSV3dwZzZUTDhIckw5V2c4UzlmcmFlMVp4aEU2Wk1kbVp3bzltc0hUVWFk?=
 =?utf-8?B?bDdYQ0xwNzc4dzB6VWs1M2R2NGhQcThINm0reGVZNTE2Zy9zb0dQTDNSREtm?=
 =?utf-8?B?Y1ZseDlaWlBkSy9DT1RiOXhHQVRDM0dadXNlTmlvVEROTCtHNWFtNEhvSDlr?=
 =?utf-8?B?OXhZSVZHSTAvRjVCZ2VzdkFJKzFVd0EvSWRQTFdISVBkWUpjV3lzVTJSWGlE?=
 =?utf-8?B?NUZqazgreUxCdURRNlpBZ0VaZGExeTJRTmFBZHZyWWw3Q0R4eVlFZHZHYXo0?=
 =?utf-8?B?eFRORFg2Nk1xK3FBL0ljdW5qVWRIUEg1ZGx3azRSTFRLY1MvbDhENmI0Yjgx?=
 =?utf-8?B?ZzI0R09NWG9sdTlGWWdhY1B2TzNIaTVmR2h1cUhaUktTSDU3M2ErdXFDZFZx?=
 =?utf-8?B?R3g4SHV2TTlSVlg5emwwOUVKSm5EVU9tSitudjdEaDl5VVF6aXMxOS9Gd0FI?=
 =?utf-8?B?bHpqand3RUlaZzY5M2xHNW9OSjYwOVV3QzVsWm9ZNk9Sd3NzSHhMVnkyQmh4?=
 =?utf-8?B?cUg1dVkrRkNnVWFydFo5SG5qUlI5OGhjZXJ5T1o4SVdZYzBuS3dST1d4WWFJ?=
 =?utf-8?B?Q3owMkZNZGVNQ296ZGlOT29ROG9oZUovM0R4dlpkMUlXL0M0VEJhLzNjV1Q5?=
 =?utf-8?B?WE9VbVpVSFFZcHVXTzluMkp0WTc3REhPaElTdm1LemZLZWVEUTlZY094Zkl6?=
 =?utf-8?B?eGt5cFVVSUlsdWoxWGFDQmp6dWJra2hLVWsrK0EzNzhqVnduczlHM2Vqdnky?=
 =?utf-8?B?N3JoK0xOV3Nxb0VITFFkMmdpTWpabmsrZE9DRTVHR0FIK29HdHoyUWhUSFVh?=
 =?utf-8?B?N3BnN0Y0Z2NKa00rUWp0VW5QZTlyR2V0VGxQdnlmZTEwTXhqR2I0Y0RZbDBY?=
 =?utf-8?B?T1hMdGx3TkhPK0ZzQWRHazEzcis5M1c5bUNpTjZ0RUxBTjZTZG5iOFlqSko5?=
 =?utf-8?B?WUkrNzlqdU1VU0JmNHVKaEszNkdWZXZHMThEM3Y2dUpldjNVWWYra0t0ODNL?=
 =?utf-8?B?cGpacisvU0xFL3JpbCt3V1BKZzhGS2RvRk5IZWVNdGlrYUdkQ2crUlpZdUJz?=
 =?utf-8?B?eGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44A6A7B683D2234D8247F3C23864252C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4732.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9002e7-79a7-41e9-5f2d-08d9f642d507
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 20:35:15.1003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lOy50yWT/FMEGeeu4kSZoYr8NUGvNMMBZ8jlRoDyTRmcE9jErtk9pzMfIHvkdQLN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3408
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: JS1I5EQUcfT7vm4FJlj9Q5azTcM8jRAY
X-Proofpoint-ORIG-GUID: JS1I5EQUcfT7vm4FJlj9Q5azTcM8jRAY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-22_07,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202220126
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

VGhhbmtzIGZvciB0aGUgcmV2aWV3IEFuZHJpaSENCg0KPiBPbiBGZWIgMTksIDIwMjIsIGF0IDg6
MzkgUE0sIEFuZHJpaSBOYWtyeWlrbyA8YW5kcmlpLm5ha3J5aWtvQGdtYWlsLmNvbT4gd3JvdGU6
DQo+IA0KPiBPbiBGcmksIEZlYiAxOCwgMjAyMiBhdCA0OjMwIFBNIE15a29sYSBMeXNlbmtvIDxt
eWtvbGFsQGZiLmNvbT4gd3JvdGU6DQo+PiANCj4+IEluIHNlbmRfc2lnbmFsLCByZXBsYWNlIHNs
ZWVwIHdpdGggZHVtbXkgY3B1IGludGVuc2l2ZSBjb21wdXRhdGlvbg0KPj4gdG8gaW5jcmVhc2Ug
cHJvYmFiaWxpdHkgb2YgY2hpbGQgcHJvY2VzcyBiZWluZyBzY2hlZHVsZWQuIEFkZCBmZXcNCj4+
IG1vcmUgYXNzZXJ0cy4NCj4+IA0KPj4gSW4gZmluZF92bWEsIHJlZHVjZSBzYW1wbGVfZnJlcSBh
cyBoaWdoZXIgdmFsdWVzIG1heSBiZSByZWplY3RlZCBpbg0KPj4gc29tZSBxZW11IHNldHVwcywg
cmVtb3ZlIHVzbGVlcCBhbmQgaW5jcmVhc2UgbGVuZ3RoIG9mIGNwdSBpbnRlbnNpdmUNCj4+IGNv
bXB1dGF0aW9uLg0KPj4gDQo+PiBJbiBicGZfY29va2llLCBwZXJmX2xpbmsgYW5kIHBlcmZfYnJh
bmNoZXMsIHJlZHVjZSBzYW1wbGVfZnJlcSBhcw0KPj4gaGlnaGVyIHZhbHVlcyBtYXkgYmUgcmVq
ZWN0ZWQgaW4gc29tZSBxZW11IHNldHVwcw0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBNeWtvbGEg
THlzZW5rbyA8bXlrb2xhbEBmYi5jb20+DQo+PiAtLS0NCj4+IC4uLi90ZXN0aW5nL3NlbGZ0ZXN0
cy9icGYvcHJvZ190ZXN0cy9icGZfY29va2llLmMgIHwgIDIgKy0NCj4+IHRvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL2ZpbmRfdm1hLmMgIHwgIDUgKystLS0NCj4+IC4uLi9z
ZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvcGVyZl9icmFuY2hlcy5jICAgICAgIHwgIDQgKystLQ0K
Pj4gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvcGVyZl9saW5rLmMgfCAg
MiArLQ0KPj4gLi4uL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3NlbmRfc2lnbmFs
LmMgfCAxNCArKysrKysrKysrLS0tLQ0KPj4gNSBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25z
KCspLCAxMSBkZWxldGlvbnMoLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL2JwZl9jb29raWUuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL2JwZl9jb29raWUuYw0KPj4gaW5kZXggY2QxMGRmNmNkMGZj
Li4wNjEyZTc5YTkyODEgMTAwNjQ0DQo+PiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9i
cGYvcHJvZ190ZXN0cy9icGZfY29va2llLmMNCj4+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2JwZi9wcm9nX3Rlc3RzL2JwZl9jb29raWUuYw0KPj4gQEAgLTE5OSw3ICsxOTksNyBAQCBz
dGF0aWMgdm9pZCBwZV9zdWJ0ZXN0KHN0cnVjdCB0ZXN0X2JwZl9jb29raWUgKnNrZWwpDQo+PiAg
ICAgICAgYXR0ci50eXBlID0gUEVSRl9UWVBFX1NPRlRXQVJFOw0KPj4gICAgICAgIGF0dHIuY29u
ZmlnID0gUEVSRl9DT1VOVF9TV19DUFVfQ0xPQ0s7DQo+PiAgICAgICAgYXR0ci5mcmVxID0gMTsN
Cj4+IC0gICAgICAgYXR0ci5zYW1wbGVfZnJlcSA9IDQwMDA7DQo+PiArICAgICAgIGF0dHIuc2Ft
cGxlX2ZyZXEgPSAxMDAwOw0KPj4gICAgICAgIHBmZCA9IHN5c2NhbGwoX19OUl9wZXJmX2V2ZW50
X29wZW4sICZhdHRyLCAtMSwgMCwgLTEsIFBFUkZfRkxBR19GRF9DTE9FWEVDKTsNCj4+ICAgICAg
ICBpZiAoIUFTU0VSVF9HRShwZmQsIDAsICJwZXJmX2ZkIikpDQo+PiAgICAgICAgICAgICAgICBn
b3RvIGNsZWFudXA7DQo+PiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBm
L3Byb2dfdGVzdHMvZmluZF92bWEuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9n
X3Rlc3RzL2ZpbmRfdm1hLmMNCj4+IGluZGV4IGI3NGIzYzBjNTU1YS4uYWNjNDEyMjNhMTEyIDEw
MDY0NA0KPj4gLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvZmlu
ZF92bWEuYw0KPj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMv
ZmluZF92bWEuYw0KPj4gQEAgLTMwLDcgKzMwLDcgQEAgc3RhdGljIGludCBvcGVuX3BlKHZvaWQp
DQo+PiAgICAgICAgYXR0ci50eXBlID0gUEVSRl9UWVBFX0hBUkRXQVJFOw0KPj4gICAgICAgIGF0
dHIuY29uZmlnID0gUEVSRl9DT1VOVF9IV19DUFVfQ1lDTEVTOw0KPj4gICAgICAgIGF0dHIuZnJl
cSA9IDE7DQo+PiAtICAgICAgIGF0dHIuc2FtcGxlX2ZyZXEgPSA0MDAwOw0KPj4gKyAgICAgICBh
dHRyLnNhbXBsZV9mcmVxID0gMTAwMDsNCj4+ICAgICAgICBwZmQgPSBzeXNjYWxsKF9fTlJfcGVy
Zl9ldmVudF9vcGVuLCAmYXR0ciwgMCwgLTEsIC0xLCBQRVJGX0ZMQUdfRkRfQ0xPRVhFQyk7DQo+
PiANCj4+ICAgICAgICByZXR1cm4gcGZkID49IDAgPyBwZmQgOiAtZXJybm87DQo+PiBAQCAtNTcs
NyArNTcsNyBAQCBzdGF0aWMgdm9pZCB0ZXN0X2ZpbmRfdm1hX3BlKHN0cnVjdCBmaW5kX3ZtYSAq
c2tlbCkNCj4+ICAgICAgICBpZiAoIUFTU0VSVF9PS19QVFIobGluaywgImF0dGFjaF9wZXJmX2V2
ZW50IikpDQo+PiAgICAgICAgICAgICAgICBnb3RvIGNsZWFudXA7DQo+PiANCj4+IC0gICAgICAg
Zm9yIChpID0gMDsgaSA8IDEwMDAwMDA7ICsraSkNCj4+ICsgICAgICAgZm9yIChpID0gMDsgaSA8
IDEwMDAwMDAwMDA7ICsraSkNCj4gDQo+IDFibG4gc2VlbXMgZXhjZXNzaXZlLi4uIG1heWJlIDEw
bWxuIHdvdWxkIGJlIGVub3VnaD8NCg0KU2VlIGV4cGxhbmF0aW9uIGZvciBzZW5kX3NpZ25hbCB0
ZXN0IGNhc2UgYmVsb3cNCg0KPiANCj4+ICAgICAgICAgICAgICAgICsrajsNCj4+IA0KPj4gICAg
ICAgIHRlc3RfYW5kX3Jlc2V0X3NrZWwoc2tlbCwgLUVCVVNZIC8qIGluIG5taSwgaXJxX3dvcmsg
aXMgYnVzeSAqLyk7DQo+IA0KPiBbLi4uXQ0KPiANCj4+IGRpZmYgLS1naXQgYS90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy9zZW5kX3NpZ25hbC5jIGIvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvc2VuZF9zaWduYWwuYw0KPj4gaW5kZXggNzc2OTE2
YjYxYzQwLi44NDEyMTdiZDFkZjYgMTAwNjQ0DQo+PiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9icGYvcHJvZ190ZXN0cy9zZW5kX3NpZ25hbC5jDQo+PiArKysgYi90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy9zZW5kX3NpZ25hbC5jDQo+PiBAQCAtNCwxMSArNCwx
MiBAQA0KPj4gI2luY2x1ZGUgPHN5cy9yZXNvdXJjZS5oPg0KPj4gI2luY2x1ZGUgInRlc3Rfc2Vu
ZF9zaWduYWxfa2Vybi5za2VsLmgiDQo+PiANCj4+IC1pbnQgc2lndXNyMV9yZWNlaXZlZCA9IDA7
DQo+PiAraW50IHNpZ3VzcjFfcmVjZWl2ZWQ7DQo+PiArdm9sYXRpbGUgaW50IHZvbGF0aWxlX3Zh
cmlhYmxlOw0KPiANCj4gcGxlYXNlIG1ha2UgdGhlbSBzdGF0aWMNCg0Kc3VyZQ0KDQo+IA0KPj4g
DQo+PiBzdGF0aWMgdm9pZCBzaWd1c3IxX2hhbmRsZXIoaW50IHNpZ251bSkNCj4+IHsNCj4+IC0g
ICAgICAgc2lndXNyMV9yZWNlaXZlZCsrOw0KPj4gKyAgICAgICBzaWd1c3IxX3JlY2VpdmVkID0g
MTsNCj4+IH0NCj4+IA0KPj4gc3RhdGljIHZvaWQgdGVzdF9zZW5kX3NpZ25hbF9jb21tb24oc3Ry
dWN0IHBlcmZfZXZlbnRfYXR0ciAqYXR0ciwNCj4+IEBAIC00Miw3ICs0Myw5IEBAIHN0YXRpYyB2
b2lkIHRlc3Rfc2VuZF9zaWduYWxfY29tbW9uKHN0cnVjdCBwZXJmX2V2ZW50X2F0dHIgKmF0dHIs
DQo+PiAgICAgICAgICAgICAgICBpbnQgb2xkX3ByaW87DQo+PiANCj4+ICAgICAgICAgICAgICAg
IC8qIGluc3RhbGwgc2lnbmFsIGhhbmRsZXIgYW5kIG5vdGlmeSBwYXJlbnQgKi8NCj4+ICsgICAg
ICAgICAgICAgICBlcnJubyA9IDA7DQo+PiAgICAgICAgICAgICAgICBzaWduYWwoU0lHVVNSMSwg
c2lndXNyMV9oYW5kbGVyKTsNCj4+ICsgICAgICAgICAgICAgICBBU1NFUlRfT0soZXJybm8sICJz
aWduYWwiKTsNCj4gDQo+IGp1c3QgQVNTRVJUX09LKHNpZ25hbCguLi4pLCAic2lnbmFsIik7DQoN
CkkgYW0gZmluZSB0byBtZXJnZSBzaWduYWwgYW5kIEFTU0VSVCBsaW5lcywgYnV0IHdpbGwgc3Vi
c3RpdHV0ZSB3aXRoIGNvbmRpdGlvbiAic2lnbmFsKFNJR1VTUjEsIHNpZ3VzcjFfaGFuZGxlcikg
IT0gU0lHX0VSUuKAnSwgc291bmRzIGdvb2Q/DQoNCj4gDQo+PiANCj4+ICAgICAgICAgICAgICAg
IGNsb3NlKHBpcGVfYzJwWzBdKTsgLyogY2xvc2UgcmVhZCAqLw0KPj4gICAgICAgICAgICAgICAg
Y2xvc2UocGlwZV9wMmNbMV0pOyAvKiBjbG9zZSB3cml0ZSAqLw0KPj4gQEAgLTYzLDkgKzY2LDEy
IEBAIHN0YXRpYyB2b2lkIHRlc3Rfc2VuZF9zaWduYWxfY29tbW9uKHN0cnVjdCBwZXJmX2V2ZW50
X2F0dHIgKmF0dHIsDQo+PiAgICAgICAgICAgICAgICBBU1NFUlRfRVEocmVhZChwaXBlX3AyY1sw
XSwgYnVmLCAxKSwgMSwgInBpcGVfcmVhZCIpOw0KPj4gDQo+PiAgICAgICAgICAgICAgICAvKiB3
YWl0IGEgbGl0dGxlIGZvciBzaWduYWwgaGFuZGxlciAqLw0KPj4gLSAgICAgICAgICAgICAgIHNs
ZWVwKDEpOw0KPj4gKyAgICAgICAgICAgICAgIGZvciAoaW50IGkgPSAwOyBpIDwgMTAwMDAwMDAw
MDsgaSsrKQ0KPiANCj4gc2FtZSBhYm91dCAxYmxuDQoNCldpdGggMTBtbG4gYW5kIDEwMCB0ZXN0
IHJ1bnMgSSBnb3QgODYgZmFpbHVyZXMNCjEwMG1sbiAtIDYzIGZhaWx1cmVzDQoxYmxuIC0gMCBm
YWlsdXJlcyBvbiAxMDAgcnVucw0KDQpOb3csIHRoZXJlIGlzIHBlcmZvcm1hbmNlIGNvbmNlcm4g
Zm9yIHRoaXMgdGVzdC4gUnVubmluZw0KDQp0aW1lIHN1ZG8gIC4vdGVzdF9wcm9ncyAtdCBzZW5k
X3NpZ25hbC9zZW5kX3NpZ25hbF9ubWlfdGhyZWFkDQoNCldpdGggMWJsbiB0YWtlcyB+NHMNCjEw
MG1sbiAtIDFzLg0KVW5jaGFuZ2VkIHRlc3Qgd2l0aCBzbGVlcCgxKTsgdGFrZXMgfjJzLg0KDQpP
biB0aGUgb3RoZXIgaGFuZCAzMDBtbG4gcnVucyB+MnMsIGFuZCBvbmx5IGZhaWxzIDEgdGltZSBw
ZXIgMTAwIHJ1bnMuIEFzIDMwMG1sbiBkb2VzIG5vdCByZWdyZXNzIHBlcmZvcm1hbmNlIGNvbXBh
cmluZyB0byB0aGUgY3VycmVudCDigJxzbGVlcCgxKeKAnSBpbXBsZW1lbnRhdGlvbiwgSSBwcm9w
b3NlIHRvIGdvIHdpdGggaXQuIFdoYXQgZG8geW91IHRoaW5rPw0KDQo+IA0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgdm9sYXRpbGVfdmFyaWFibGUrKzsNCj4+IA0KPj4gICAgICAgICAgICAg
ICAgYnVmWzBdID0gc2lndXNyMV9yZWNlaXZlZCA/ICcyJyA6ICcwJzsNCj4+ICsgICAgICAgICAg
ICAgICBBU1NFUlRfRVEoc2lndXNyMV9yZWNlaXZlZCwgMSwgInNpZ3VzcjFfcmVjZWl2ZWQiKTsN
Cj4+ICsNCj4+ICAgICAgICAgICAgICAgIEFTU0VSVF9FUSh3cml0ZShwaXBlX2MycFsxXSwgYnVm
LCAxKSwgMSwgInBpcGVfd3JpdGUiKTsNCj4+IA0KPj4gICAgICAgICAgICAgICAgLyogd2FpdCBm
b3IgcGFyZW50IG5vdGlmaWNhdGlvbiBhbmQgZXhpdCAqLw0KPj4gQEAgLTExMCw5ICsxMTYsOSBA
QCBzdGF0aWMgdm9pZCB0ZXN0X3NlbmRfc2lnbmFsX2NvbW1vbihzdHJ1Y3QgcGVyZl9ldmVudF9h
dHRyICphdHRyLA0KPj4gICAgICAgIEFTU0VSVF9FUShyZWFkKHBpcGVfYzJwWzBdLCBidWYsIDEp
LCAxLCAicGlwZV9yZWFkIik7DQo+PiANCj4+ICAgICAgICAvKiB0cmlnZ2VyIHRoZSBicGYgc2Vu
ZF9zaWduYWwgKi8NCj4+ICsgICAgICAgc2tlbC0+YnNzLT5zaWduYWxfdGhyZWFkID0gc2lnbmFs
X3RocmVhZDsNCj4+ICAgICAgICBza2VsLT5ic3MtPnBpZCA9IHBpZDsNCj4+ICAgICAgICBza2Vs
LT5ic3MtPnNpZyA9IFNJR1VTUjE7DQo+PiAtICAgICAgIHNrZWwtPmJzcy0+c2lnbmFsX3RocmVh
ZCA9IHNpZ25hbF90aHJlYWQ7DQo+PiANCj4+ICAgICAgICAvKiBub3RpZnkgY2hpbGQgdGhhdCBi
cGYgcHJvZ3JhbSBjYW4gc2VuZF9zaWduYWwgbm93ICovDQo+PiAgICAgICAgQVNTRVJUX0VRKHdy
aXRlKHBpcGVfcDJjWzFdLCBidWYsIDEpLCAxLCAicGlwZV93cml0ZSIpOw0KPj4gLS0NCj4+IDIu
MzAuMg0KDQo=
