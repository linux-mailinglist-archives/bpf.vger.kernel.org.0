Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D6C52CC16
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 08:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiESGmt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 May 2022 02:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiESGms (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 May 2022 02:42:48 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8514E39F;
        Wed, 18 May 2022 23:42:47 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IN6GkS023802;
        Wed, 18 May 2022 23:42:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=IoT9cGCEakg713xFKfK4AgJ3iCwJhS0lepOIMqRq4nY=;
 b=VEJU197Kzl9zv7Ous0VfHHY2UE821sGaU4xcKg611/xz5XfYhH1S7VLUlAAO3+rrmryL
 fwcvn6hReOLJUagBvo9uYI6yNBMgoasX9C3fpHqLjKXxPLp9geYXc2OH/TcrSLwElUuz
 YiwYf3lnAfJDbNPzL+98dVcAZCC5hoh02kM= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g59tbhvv4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 23:42:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZXY2Y1FfKPdiaVzLIPlGI2RMxk/NXIhmLqVJJS88AJf6M4J6zo07xRtgTKUjztSvY94VNokdQ2bN93PThxVDFKs3ukxXUxewqJEponspbARHolsGSuN1/1udFb7PZbFkew3sSmB11b6NgoiXl+aA/etBkP1Odamrv1FGhJ9dbCvdhTDZiSeB/pbLRfvJV2rCIl2xr6iDzoMfE4f6umQlLVDRMjvsPdwAuG55ouPgHYFGx/+rQqTcFKqed3TjfV6PoohxutX5iVZtOwJA0xm9S6a5FK63nzvDdPkoUIgZfN0r7KECAeAireGjBMR5zhd6cDderA1z39jBkjsoJwqIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoT9cGCEakg713xFKfK4AgJ3iCwJhS0lepOIMqRq4nY=;
 b=hbQTGIfqSGA6dN2kHJCFrl5yXIhQHzZN7J/IZzALsm5G5gUl7Hv8xdWE2HVIXoCccbOWCa8iC7mITNuZ+ZIDEQDdskIdyTQeAUmoio9IKqcZHktxACmYv6klg9ZiyxOeJHjp8jdh0zUusgwcSCJU6AZBWXof+Ui56Cwb37USv9ezLraYV9VPQ2dDAg31FptHT9Q6WYXBxEXIBtc3qGMK5FCYDNzJxxtq4J7e5KuvolTC/Es30K17Q+A6tlfBojP7s9NzH5evBMlK0SHOrWAgrJ0snpl7jZSGJrAIth7Qt87RgqhW189nq8ckj0cRPnnvxwnDLH1qheYjDY9yWyJoaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MW3PR15MB3801.namprd15.prod.outlook.com (2603:10b6:303:4b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Thu, 19 May
 2022 06:42:43 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::3061:40ff:2ad:33aa]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::3061:40ff:2ad:33aa%5]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 06:42:43 +0000
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
Thread-Index: AQHYaOeMGoBl3hFoL0eR1OYIkVdnbK0jcwCAgAAfoYCAAC+jgIACAzQA
Date:   Thu, 19 May 2022 06:42:43 +0000
Message-ID: <E0C04599-E7E0-4377-8826-74FA073FC631@fb.com>
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
x-ms-office365-filtering-correlation-id: 008b2d09-f58e-4815-62d0-08da3962c705
x-ms-traffictypediagnostic: MW3PR15MB3801:EE_
x-microsoft-antispam-prvs: <MW3PR15MB380185AE90BE1A2B4DDD73F6B3D09@MW3PR15MB3801.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8WejIDUkNkFXopuwyKKOz59oMnpF50DZxmA7jwrq0CxF8ErKWAJ7zCqQ5e+O7UwIYxtgAzprvhudzU5BD+1UnwKr5ni7iaISdnkygtOTBKcJrTz6ebvVv37ifgs0KTIiNn0t/S3hiWlvMiMubyPHfZY+HGZig+0o+boRW5uv4jV5twDsUN2iAZh9RpTBWk23nDBezlkVNmgLtmQCQukTGnHHkwMp4matyXWeJPfPFgBLHDs5ESF+RWBcZN4uVW7laETsla+kzeks72ELBD7ivhCpbioKbVnxJks+ARuOTPtmomzTdKiV0jpSPTX4psA4n0mqDWRNZrMYbpzC4aPOwipZ9Od6Yld2m0rdtDoaxjmU30objSasiI8YgHdShv7N9/XxdllFlL+y/IBYFAoj+NAzNQAOyw1Co/DNClssCvwL/Fl1A3LP9QXyLRDq5r+V/SzIi5yGLFaFIEQCuRd/hqmOyxXGdPUbiejpO8TLnuJWUobrDBjn5aw9M8BIM4/3XKqc00H+sSpmvKwb8x6tXeraFuQ2wr3izzEmRBGzCmXAOSHcTsEfryUUGfRHyLjsJ/uaaOjY3xBcBRzptFoJD3VlwjEbVRWEmwXhNRzlmRCLVvyvjyJtWTK5+qdptNmYKssqCrHojxD25pkT4iqTjxx5AbncGE9w2b2ivc04aY6pJxvwRMyjrXqO+2Xv7y/BBW5PA0dK+aKb8OXag2oXMgfQZ1A7rsCTPVmp6q49M0ccJwcCpeeqH4G225lSyaxR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(8676002)(66446008)(36756003)(54906003)(38070700005)(6916009)(66476007)(6486002)(508600001)(76116006)(91956017)(66556008)(64756008)(66946007)(4326008)(71200400001)(33656002)(83380400001)(122000001)(8936002)(38100700002)(2906002)(186003)(53546011)(5660300002)(86362001)(6506007)(6512007)(2616005)(14583001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L01URU44MmlrQkNnZ0RueHlVdlpBZTIwejhTNFY3TGdTcDdXbjU3L0x0aUxN?=
 =?utf-8?B?R1RIclZka09xWk1CRGo2Tk1CNkoyQzFLMloya1I3N01DTUpTcFVuakc4WjRo?=
 =?utf-8?B?elJWU0JGVXNoWktobFh5WklLWnVpTXJSZ0oveWtDQzg3Mm1Bb2NQYjhBMWJX?=
 =?utf-8?B?TTlZYXIxK3NKNzVSWEhxS29ZMkl5QUZML0xjelZ5aDB0ZWYrREFaQlpJQldP?=
 =?utf-8?B?enlhWnVEaSs0ZjBmdzV1Z21QWWRhTklLR3U5OTY2amFhTDl6Y01FMS9kek1O?=
 =?utf-8?B?a0Y2VmlNd0o1WkFQbTNoMnU3YVpJSEtGYml6RmwwRnFjN09hYUd2VzhxQm5L?=
 =?utf-8?B?YU9veG94WDBMN3cwOGxST3BKRVhSRUk3NzlVN1lTYWl6OE81TlMrS2d6dWts?=
 =?utf-8?B?Y050MENMMHoxK3lWQjl4c2k4ZkdkbHE3Qk02WWYzWlBHMkFuMFkwVXNkdUQ5?=
 =?utf-8?B?VldoM2NSRHBvZlI0NVQ0SGRvaXZvc3NkZmpzWnlmcS9YakVzYm9QWXgvUkpG?=
 =?utf-8?B?Y0V5NHpKaC9ybmZqbDdISXZNUFp3RkRsbFRNWmNmU3k1Y0ozR3N3bEtiMm5X?=
 =?utf-8?B?eTl6Yi82WGFkWXNQY2pkV3d6UUlhbnVWd3ZwTGVORnNEZjRrREZWZi96SVNH?=
 =?utf-8?B?d3B1VU9MM2lGUWdhZHJ4dHRNOGNQVy8wTW5xY0J4Y3N5WCtRbU1jYnBzS3BH?=
 =?utf-8?B?YXQxa2EwNUNLeUcrV0JBY0lLbi9HbHlrY2tBQWtxV29UYzNSNUh2WWF3VU1T?=
 =?utf-8?B?QVdzdjNyMDZ6OXdzUlRIRUpVMCtUWmVSUHZoalNzVFRUMyt1SmxZSldaTUhm?=
 =?utf-8?B?dkZKaFNNVnJFcXVZck9JVnZaTm51ejNmWSs5clNzMUxuQlpNS2Q3RUg1Nzc3?=
 =?utf-8?B?RGV6TWVQY3JoQ2dzY3dabXQzMHYweWZPMVJHUmI3RXhUbEk0N25Ndjcyclk5?=
 =?utf-8?B?OVNvdkVqQndWbnhwZE5OdGsrbkZVSzV3d0trYis0ZU5KSnEvSGRGbVZDNEZr?=
 =?utf-8?B?V0txM2o1RkFrY1ZmVkdOa29oSUI3R29wN29pWkMxRGJ0KzlERG5mVHdSMXRE?=
 =?utf-8?B?L2w1d3BlZTZObVdsdXR6KzVRSnNlUWNRQmJkeFl2UzlabjBRU0RFRUpsK3Y0?=
 =?utf-8?B?YWNlRURhUzNmcGZZK1ZKS3VoSm9BVTZLeFBLbmcya0s4dWFGTnEyajhhV2Q3?=
 =?utf-8?B?UnVnZlFNYTBqaHVvTFNCa1R6SUlsQWtxZnFWZ0V4RitXTnlOMGM3eCtBUTBo?=
 =?utf-8?B?dGNmWjY4WFF4TGI3R3hZYkxNbXBYVHhTT3lJMms4RE1JTHZtRG1TWUlmTFN3?=
 =?utf-8?B?Um9OWEdZZlJYNEdyTE5ScG1LS2ZRMHluTWZCNnlEZE5IblVRZzRyMXRzOUFU?=
 =?utf-8?B?TVFxazFZK3pDVVptaG5YZFFRdG9pNXBvbGxWS2xMZDNLbzRsNmJxSkI5T1ND?=
 =?utf-8?B?aFRycFRhWlVCNDJlL0hrYVlEaGtRR1pSUXVIdnZueTI1MWFtbkZhUUV5cDRE?=
 =?utf-8?B?YlRCNWIyeG9OdERZSExnbDVmdTFETVZGcnhsVVBtTnVKQ2R4eE8xSkVZTlA4?=
 =?utf-8?B?UCtpckY4N3A4TE52QTR1L202MVhSRmpzRFNWSTZ0OFRRV3RvSXoxenUrMEow?=
 =?utf-8?B?L1F5WGp5Z2dycmdqR2tZdzEvNU8zbmhlRzVOY3ZiTHVnajNhaFdtUnBJY1Rh?=
 =?utf-8?B?S1E1OHl2N2FGSkNTWUVqRjBTUDh0TnBuNm9Gd09ZZFBDbFpYbUIyelk3RllS?=
 =?utf-8?B?dllxM3dMOFFvN3ZuVCsyaDRMN1BGNDB6Y2NBNlVuYitPbjB5aDZBb1ZWOTB4?=
 =?utf-8?B?bGI1YUdZMnJvbTJMbFk3SkcwVHQ4L2hsWkdWYzEyOWRYeXpFRmk1V0x4Zmt0?=
 =?utf-8?B?VnpSamtCdXNUNlBaNjVRT2x3bVE5OCsrQ2dMd0tqZkh1SGRHQ1lXUDFBbmRu?=
 =?utf-8?B?WXo1WU4vWGJYaGp1bFpVU3ZLblFuWGt5NGhVZ0U1WEpJMEJqNExaK3Z4WTRR?=
 =?utf-8?B?Q1RBUzRoS1pxT3AyLzFORThkL21YLzlHd29pS2dGMGlCT3ZiM0ZIQk5OMEZN?=
 =?utf-8?B?YXZqZnE3YmVxcDdONXFmdUxISmFaRnh0TW05cXk5RHZnSnpOaFVKUmJDRlNh?=
 =?utf-8?B?QTFMUFRiZ1pWUkNISWd1TkFlY29QbWhKRDRCZ1RkeW9naC9uQ2NJSGNkWHFN?=
 =?utf-8?B?ZFJRa09KV0drL3QwcFRMcjZ0UHJhS0xWaXExZVlBL3lZY3hyQ1BjZzFyWEpG?=
 =?utf-8?B?bDlZQ0pwODNna0U2SmhZd2tRNGdDMFVBdXUzNDJ6ZkhXdTU3QmFmTXRkZVBp?=
 =?utf-8?B?eTg3YW5lOHRoVFd1Q3drVC8vaHo2S1A2NS9UYkZPbEhyam4vM3hBYXdOZnN3?=
 =?utf-8?Q?iCMVZGWBf1Vzex47y3qCvWgvBso58e9kQUDJN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45BC32FB50985B468A4EA5E92209E28C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 008b2d09-f58e-4815-62d0-08da3962c705
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 06:42:43.4631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BOLWNTB7rkLr9WnnF7WcGCYQ7i90UFDCHsb/OkBVTj+M+LLXWh9L0PW2yogi2nQGaJ12PxO6hb2dHcrUZy9dFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3801
X-Proofpoint-ORIG-GUID: bJinbbJv_kig7GbBIIb4TZv_FSiuGMgA
X-Proofpoint-GUID: bJinbbJv_kig7GbBIIb4TZv_FSiuGMgA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-19_01,2022-05-17_02,2022-02-23_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCj4gT24gTWF5IDE3LCAyMDIyLCBhdCA0OjU4IFBNLCBFZGdlY29tYmUsIFJpY2sgUCA8cmlj
ay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4+PiANCj4+Pj4gU2lnbmVkLW9m
Zi1ieTogU29uZyBMaXUgPHNvbmdAa2VybmVsLm9yZz4NCj4+Pj4gLS0tDQo+Pj4+IGtlcm5lbC9i
cGYvY29yZS5jIHwgMTIgKysrKysrKy0tLS0tDQo+Pj4+IDEgZmlsZSBjaGFuZ2VkLCA3IGluc2Vy
dGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+Pj4+IA0KPj4+PiBkaWZmIC0tZ2l0IGEva2VybmVs
L2JwZi9jb3JlLmMgYi9rZXJuZWwvYnBmL2NvcmUuYw0KPj4+PiBpbmRleCBjYWNkODY4NGMzYzQu
LmI2NGQ5MWZjYjBiYSAxMDA2NDQNCj4+Pj4gLS0tIGEva2VybmVsL2JwZi9jb3JlLmMNCj4+Pj4g
KysrIGIva2VybmVsL2JwZi9jb3JlLmMNCj4+Pj4gQEAgLTg1Nyw3ICs4NTcsNyBAQCBzdGF0aWMg
c2l6ZV90IHNlbGVjdF9icGZfcHJvZ19wYWNrX3NpemUodm9pZCkNCj4+Pj4gICAgICB2b2lkICpw
dHI7DQo+Pj4+IA0KPj4+PiAgICAgIHNpemUgPSBCUEZfSFBBR0VfU0laRSAqIG51bV9vbmxpbmVf
bm9kZXMoKTsNCj4+Pj4gLSAgICBwdHIgPSBtb2R1bGVfYWxsb2Moc2l6ZSk7DQo+Pj4+ICsgICAg
cHRyID0gbW9kdWxlX2FsbG9jX2h1Z2Uoc2l6ZSk7DQo+Pj4gDQo+Pj4gVGhpcyBzZWxlY3RfYnBm
X3Byb2dfcGFja19zaXplKCkgZnVuY3Rpb24gYWx3YXlzIHNlZW1lZCB3ZWlyZCAtDQo+Pj4gZG9p
bmcgYQ0KPj4+IGJpZyBhbGxvY2F0aW9uIGFuZCB0aGVuIGltbWVkaWF0ZWx5IGZyZWVpbmcuIENh
bid0IGl0IGNoZWNrIGENCj4+PiBjb25maWcNCj4+PiBmb3Igdm1hbGxvYyBodWdlIHBhZ2Ugc3Vw
cG9ydD8NCj4+IA0KPj4gWWVzLCBpdCBpcyB3ZWlyZC4gQ2hlY2tpbmcgYSBjb25maWcgaXMgbm90
IGVub3VnaCBoZXJlLiBXZSBhbHNvIG5lZWQNCj4+IHRvIA0KPj4gY2hlY2sgdm1hcF9hbGxvd19o
dWdlLCB3aGljaCBpcyBjb250cm9sbGVkIGJ5IGJvb3QgcGFyYW1ldGVyDQo+PiBub2h1Z2Vpb21h
cC4gDQo+PiBJIGhhdmVu4oCZdCBnb3QgYSBiZXR0ZXIgc29sdXRpb24gZm9yIHRoaXMuIA0KPiAN
Cj4gSXQncyB0b28gd2VpcmQuIFdlIHNob3VsZCBleHBvc2Ugd2hhdHMgbmVlZGVkIGluIHZtYWxs
b2MuDQo+IGh1Z2Vfdm1hbGxvY19zdXBwb3J0ZWQoKSBvciBzb21ldGhpbmcuDQoNClRoaW5raW5n
IG1vcmUgb24gdGhpcy4gRXZlbiBodWdlIHBhZ2UgaXMgbm90IHN1cHBvcnRlZCwgd2UgY2FuIGFs
bG9jYXRlDQoyTUIgd29ydGggb2YgNGtCIHBhZ2VzIGFuZCBrZWVwIHVzaW5nIGl0LiBUaGlzIHdv
dWxkIGhlbHAgZGlyZWN0IG1hcA0KZnJhZ21lbnRhdGlvbi4gQW5kIHRoZSBjb2RlIHdvdWxkIGFs
c28gYmUgc2ltcGxlci4gDQoNClJpY2ssIEkgZ3Vlc3MgdGhpcyBpcyBpbmxpbmUgd2l0aCBzb21l
IG9mIHlvdXIgaWRlYXM/DQoNClRoYW5rcywNClNvbmcNCg0KPiANCj4gSSdtIGFsc28gbm90IGNs
ZWFyIHdoeSB3ZSB3b3VsZG4ndCB3YW50IHRvIHVzZSB0aGUgcHJvZyBwYWNrIGFsbG9jYXRvcg0K
PiBldmVuIGlmIHZtYWxsb2MgaHVnZSBwYWdlcyB3YXMgZGlzYWJsZWQuIERvZXNuJ3QgaXQgaW1w
cm92ZSBwZXJmb3JtYW5jZQ0KPiBldmVuIHdpdGggc21hbGwgcGFnZSBzaXplcywgcGVyIHlvdXIg
YmVuY2htYXJrcz8gV2hhdCBpcyB0aGUgZG93bnNpZGUNCj4gdG8ganVzdCBhbHdheXMgdXNpbmcg
aXQ/DQoNCg==
