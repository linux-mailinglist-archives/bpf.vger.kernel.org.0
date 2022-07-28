Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63175846CA
	for <lists+bpf@lfdr.de>; Thu, 28 Jul 2022 22:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiG1T6C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 15:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiG1T5z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 15:57:55 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511571EAF8
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 12:57:54 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SIApCH002925
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 12:57:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=0pxr8vCIiq3R2qMDR8al8Mmz9cqN/G8HUAd/3ta54/E=;
 b=ViWATbgnlic1ZCKPYksh81eDaCCYUtiY7Cqa87ci6aT49X5cy+h55F3DeFClAji5WvCm
 jY0YWi3rgomoPvipWK2z9iQ6EcrmSryd6eB6SY4V+uOqFg2s3VEykX2scjiUt30JNXwa
 LzrrrLpWgZHEMnsM1C1iu9N0rEUOjaAwWL4= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hjjnt2385-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 12:57:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3eakWf+FPQdN5tGOjw1eN1oqYf1x1om5CfSHTQDrpf5/mdc8hDaJ6lqsIbQ5c3ss/ZaNRDeXkO/fr2dmFZWEFQ9win6pDwvP6d9QClqBLYKJHdJgFjNVDwIaF+1lRtCMzZhyncqyi3FBrJ3bf/qNTXRE1IAKWJ6f6NSjeOY1vWUvvKprMkATX0ufXJAt7JZbZftYU6cbfPskIZVSQ6AIIvnNEo1J11sIp4KGOfZOuHO/BEiaSFb754fCMF86SMCrBMQeNduk+U1r3chnrM+OKQ+Cj/FTVfF6WkQ3ezv4IjW8JJOcQ5d6/tw3cD5sSP/+O7zslc76ZSzjGkoBd50bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pxr8vCIiq3R2qMDR8al8Mmz9cqN/G8HUAd/3ta54/E=;
 b=dO9t2YnDQv9EmTWzRIYZR+73wHBvp8Wxt291XyDRCT5dQyz7TsQjCCl/e2aeNp3u7SXKus+Y7ODANzqF18vT8HSMIDMnvwfxF8Qr6RppEjni9XPZj8r9mpJ7hDoV7OrlFAVpNLDjI4tSzDEUbmxCqTOAApx3Bup8N4D4GA5e3++6lU3oOWZ8mg13NzRrQ+W/GxMTIYNKMhf0zuAgxmd4iblBp9BjxLUzcWE3a1shmZWfknZyB7BgF+E3FaOacKrWY9VjvHN0RvKwLsjW79rX95/hOr3oe8by8NQR3Db/ESoY0zIwyxNvZWJOmwNm+ltvNy5SxACaNbitoVa4P2V7Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by BL0PR1501MB2180.namprd15.prod.outlook.com (2603:10b6:207:19::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Thu, 28 Jul
 2022 19:57:51 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f%6]) with mapi id 15.20.5482.011; Thu, 28 Jul 2022
 19:57:50 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     Yonghong Song <yhs@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>
Subject: Re: [RFC PATCH bpf-next 0/7] bpf: Support struct value argument for
 trampoline base progs
Thread-Topic: [RFC PATCH bpf-next 0/7] bpf: Support struct value argument for
 trampoline base progs
Thread-Index: AQHYoRLIz41WXjJWD0i8rSCksLxN2q2T8E8AgAAhcQCAACS6gA==
Date:   Thu, 28 Jul 2022 19:57:50 +0000
Message-ID: <17dbbb831db12049ebfb5161e380c9078fbddad5.camel@fb.com>
References: <20220726171129.708371-1-yhs@fb.com>
         <aa998af64d0662af4c138175259244640cecfcbf.camel@fb.com>
         <18273e85-4e45-c395-0aa9-a10125d59e50@fb.com>
In-Reply-To: <18273e85-4e45-c395-0aa9-a10125d59e50@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2753b00b-f266-45a8-5e4f-08da70d373af
x-ms-traffictypediagnostic: BL0PR1501MB2180:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kdWU0NqCORKJGHiO4EETfHGxGneVSNAQkWRXE6IO4jHuSyvas6OB0I2ZbT100u5V2t9dx4vzcFK6AK9NKTTTw5RM6zRyRfIcKl9VhsFeOzxQi606BT6vJaPKdR+PkEeEAfxHqhTOutZ9DEu7gZdOCzGvWohsaGFeNGJrpLs8T3PLRm06spH79i6wuY0/++3KBVMKdDNSLhpYUaK9WLOnrHeh81TVPFX5/+y48lK2ODcSVL2mq5wQ/boanyPhF28UhumNuM2xNXsrSSajEp7sqLF+xOciVeUCstWf4uIc3KVzPgcQHTev12fNl3Z3xaVYmuyPJTeNOxxxznG3b71UQIsaMCx/Vee+OZzmWWrLDxtTEEj9waWmq6q5+P735aO8tKMeZW0ExlxruQZUhn0uKYHnQD9NNJi13MJf/SusUn2nffI4CuR/wbKefTbYgQ1JjU1uYkd7edgpMvbvMRz67oe9BgV5x6iOOmvUsNrdodFDx/oJ/Z1p1Mxve+2LNq7A/Jkya19aLEetAQ0OuUMexJ/DOIb7W0MV2Kpwb0enkYPv6T44mAUOzEJmep6iyUr7sSupD/4CTs25W6qm5h9Eue/vFtB6034AB95uJzCDqKsXNzWOArh4gXWmq7+MAyVmRg1zXSDvV0j+XNRKRcHBzgLr0aSJpM+JhwE8JNNJm142MLoNdgdNSD/hYhnALmYWcYucx3dBcEg1tUEAgVJtpftU1SP4fOpVK1MwJpZvvvTrSCFL872giDgIHcSn71/jBotS6Ej/SeM0SJHul/SSBepcBGFJzyQ/LmeqpXEVfm9zOzh2PeXjJ5TAxbRCr4or
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(38070700005)(122000001)(38100700002)(86362001)(54906003)(36756003)(83380400001)(316002)(2616005)(53546011)(6512007)(6506007)(8676002)(110136005)(41300700001)(64756008)(4326008)(66946007)(91956017)(66556008)(478600001)(76116006)(66476007)(2906002)(186003)(6486002)(71200400001)(8936002)(66446008)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDdwSllIMnB4clpDSU9oc3RkQ3ZUbFMydnRpU3Vlbk1kb1d2cTZLWXRVVGtu?=
 =?utf-8?B?R01HYUNDanNNLzY3L3o4MmZVM0lGUnJrVVpObm1lM3ZFRngwY1FZeFVUUksr?=
 =?utf-8?B?QUpvYXNscEU5M0RXbWt6STkzandvT0s3a1hnR3h4bU9hbk0yNjZmVExONkp1?=
 =?utf-8?B?a1VnSmtkTDlwVmpLWEdhNzJuWVRyOFd5Z1ZDZjV0ZnNBd3k0aTEvTjl2SWZH?=
 =?utf-8?B?WldNT3BLRUZZcFk0Wm5JREFRK3YzSmhwTXBsUXF4ME5NUHlwejhtSkRVcGox?=
 =?utf-8?B?Ykd3Yk52T3huQ01kbGh5UXdZa1dhNE9ueUEyaWxTMStRbjdpV3FsMUxMZGdo?=
 =?utf-8?B?bitkbTJWSnRUdkZTWTBnZFBObkdhLytZVW9GWUlnUnVjWG9NQlBTNVQrTTV1?=
 =?utf-8?B?T1F4TmFiaktaSithUTNFM3k2OEtjbE5NREh1Q2dlTktNTE1ZRDdCc1RuSDV2?=
 =?utf-8?B?Y3kwQVZYdVRCWGJHYjVWdkxYcXY3dldLODd3bGdTYTBKOG5ma0habXZCdDNT?=
 =?utf-8?B?aFVYVTkxQ0hZVlluV2pEdXRlTVhmblJ5K0FkVGljOTRTOUpFeHlVWVg3SUwr?=
 =?utf-8?B?bmpIRFRQR1FZbUFNWk1POGVhakkyQ1dqV1dCc0dkNjQ2eCtFN00xbnRrR2pP?=
 =?utf-8?B?ZkV6SzlKVDB4dzYyb0RXWUtnZzU4L0tEWjBXMVpUaWd3SlBac2ZXT202M1Y1?=
 =?utf-8?B?YWh3VE43OEo3T3FSM3ExYktVd1FUcnBua3NPNWt6QTZreDBRMXc4amFtd3RJ?=
 =?utf-8?B?ei9CL1o1cHZVOVVkOGhLNkVWWWVVMHkybjExbW9Nb1hmYWFtbzhvTWU5MnFB?=
 =?utf-8?B?YXdNeEkrRSt1TUhQM3pINjlBQ0wvZjRJb3cxYlZRbXVJWTNJTWJKRU9NYkNZ?=
 =?utf-8?B?dTlJZzNvVGlWL0lWb2xnYTZDNU9BZHl2VTVOUVAyMnRFZDk5aFh4c3p4UlZC?=
 =?utf-8?B?MEI4bHYyZHZ3elNRNERzVXJFZDg4aG9CbGcxT0pEdlJIcXROSXgzWEV6MW5J?=
 =?utf-8?B?ditpN1JaZHlYbWdZcDFSekZsUkkzVWxSQzJ5VDZKOWpZMFh3cTFwdDNDOVg4?=
 =?utf-8?B?WDFxUmk2ZzVjUHFYT0RLdE13L2p4SjQwblY4SlNNNVJ4Q2poczdLTHkwZFF3?=
 =?utf-8?B?RzhHcFZvYXAvd1BxSEVoZ0Y3dm9pM3BsZ2NyVjBHRC9JcFhWeGJxbUhGUWM5?=
 =?utf-8?B?VjZ5MWtkc3BhYnVrVkNDMWxGbEg3aGZZNEdvWkNKNllaSWxSYno2OG5xRS9Q?=
 =?utf-8?B?dHFBamRySC8razNIZDRvckJLT0JGOVVwdlVhU2tqeU1RdDVOcmpxa2VOcWho?=
 =?utf-8?B?cWNwd0NMYzFOZitjU3d3UStrTHRtZ2dGUFI3UWVwVllIcVZVU2NGQWNMdEls?=
 =?utf-8?B?dXdMZWh3QVpKeDlROHpkOEg5b1lnVUFRTlhaWmxmZ1YvTzA1YzNyRyttd2FP?=
 =?utf-8?B?MFFZUFNqS3A5cnRWOVV3Tk92TmZUSnFlaDQzR3Q3cHZjcTJYTDBiYU4zK0dm?=
 =?utf-8?B?aWFZOWw0RE1uOVdVWXZCOEc4dmVEYzIzb0xjNTNQaFIwaUg1UUVYZXoraG9z?=
 =?utf-8?B?eVFQVG83bUZkKzFNQWd2aVhsYjNPZmFlMVZtZW0xa0FFZnkrQzNkVjg3NWhz?=
 =?utf-8?B?bThZcUVHZklyZkNwYUVTSVF6NWdGaGdXdFVtVm9YeVVqdVFvZ3ZPaURjTk14?=
 =?utf-8?B?UUYyK3J1V0VxU2ZoS3ZESEdaL3VISTh4ZXpLMTg4bTRKVXpYMEkwUGp5SU1n?=
 =?utf-8?B?bHg2SG9DKzZnZW01Q3FRMjJUbnkxQ3FrSXlydTVOMnVDdnZWbGU4WG0weHo1?=
 =?utf-8?B?WXRVSmZFeHpCMlB4dW9Db2o3eU9KNDJ6MEliK2s2ZkNXaWVmMm5FZndWTTNK?=
 =?utf-8?B?VkJ5K0JySnQ3SGg0eVVZM01IRnhneVMvNlJwMUF4ckd6djZ4dUR3b3hCY2NG?=
 =?utf-8?B?YzIzcmJUYW1TckJWbXdPWkhDWE0xNGRVdGt1Zm9XdGkyTVN5b2xaS2c1Nlpz?=
 =?utf-8?B?alFsNmI2SGlCTTJjY3dDaVRXMFBER0Z6NytUN3g0dHA5VDF5TWY2ZUl3MGNm?=
 =?utf-8?B?MDVqVndBQVNQZ0xVSjdpdERra0xUamJpLzJsZFJpYkkxVWQ1MGdzWWhKYk4v?=
 =?utf-8?B?eG5nVWhwbXZKeGE3TmtSam91NmNNYjlFcms3RWpmVmg3aXk5THZlU3kyUjRL?=
 =?utf-8?B?K3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFF372131C62B0428C654F5CC2D67C5A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2753b00b-f266-45a8-5e4f-08da70d373af
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 19:57:50.7160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RaSewxef5t0ufI7akovNTsJr0lgTJPRJt3pIPVZC48J3dX3t/MKM9t71+JSmtA7I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1501MB2180
X-Proofpoint-ORIG-GUID: 4oqRG0j1NXeP738FGtrFyKZuvDHtd9iT
X-Proofpoint-GUID: 4oqRG0j1NXeP738FGtrFyKZuvDHtd9iT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVGh1LCAyMDIyLTA3LTI4IGF0IDEwOjQ2IC0wNzAwLCBZb25naG9uZyBTb25nIHdyb3RlOg0K
PiANCj4gDQo+IE9uIDcvMjgvMjIgODo0NiBBTSwgS3VpLUZlbmcgTGVlIHdyb3RlOg0KPiA+IE9u
IFR1ZSwgMjAyMi0wNy0yNiBhdCAxMDoxMSAtMDcwMCwgWW9uZ2hvbmcgU29uZyB3cm90ZToNCj4g
PiA+IEN1cnJlbnRseSBzdHJ1Y3QgYXJndW1lbnRzIGFyZSBub3Qgc3VwcG9ydGVkIGZvciB0cmFt
cG9saW5lIGJhc2VkDQo+ID4gPiBwcm9ncy4NCj4gPiA+IE9uZSBvZiBtYWpvciByZWFzb24gaXMg
dGhhdCBzdHJ1Y3QgYXJndW1lbnQgbWF5IHBhc3MgYnkgdmFsdWUNCj4gPiA+IHdoaWNoDQo+ID4g
PiBtYXkNCj4gPiA+IHVzZSBtb3JlIHRoYW4gb25lIHJlZ2lzdGVycy4gVGhpcyBicmVha3MgdHJh
bXBvbGluZSBwcm9ncyB3aGVyZQ0KPiA+ID4gZWFjaCBhcmd1bWVudCBpcyBhc3N1bWVkIHRvIHRh
a2Ugb25lIHJlZ2lzdGVyLiBiY2MgY29tbXVuaXR5DQo+ID4gPiByZXBvcnRlZA0KPiA+ID4gdGhl
DQo+ID4gPiBpc3N1ZSAoWzFdKSB3aGVyZSBzdHJ1Y3QgYXJndW1lbnQgaXMgbm90IHN1cHBvcnRl
ZCBmb3IgZmVudHJ5DQo+ID4gPiBwcm9ncmFtLg0KPiA+ID4gwqDCoCB0eXBlZGVmIHN0cnVjdCB7
DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgIHVpZF90IHZhbDsNCj4gPiA+IMKgwqAgfSBrdWlkX3Q7
DQo+ID4gPiDCoMKgIHR5cGVkZWYgc3RydWN0IHsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqAgZ2lk
X3QgdmFsOw0KPiA+ID4gwqDCoCB9IGtnaWRfdDsNCj4gPiA+IMKgwqAgaW50IHNlY3VyaXR5X3Bh
dGhfY2hvd24oc3RydWN0IHBhdGggKnBhdGgsIGt1aWRfdCB1aWQsIGtnaWRfdA0KPiA+ID4gZ2lk
KTsNCj4gPiA+IEluc2lkZSBNZXRhLCB3ZSBhbHNvIGhhdmUgYSB1c2UgY2FzZSB0byBhdHRhY2gg
dG8NCj4gPiA+IHRjcF9zZXRzb2Nrb3B0KCkNCj4gPiA+IMKgwqAgdHlwZWRlZiBzdHJ1Y3Qgew0K
PiA+ID4gwqDCoMKgwqDCoMKgwqDCoCB1bmlvbiB7DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB2b2lkwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqa2VybmVsOw0KPiA+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdm9pZCBfX3VzZXLCoMKgwqDCoCAqdXNl
cjsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqAgfTsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqAgYm9v
bMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaXNfa2VybmVsIDogMTsNCj4gPiA+IMKgwqAgfSBzb2Nr
cHRyX3Q7DQo+ID4gPiDCoMKgIGludCB0Y3Bfc2V0c29ja29wdChzdHJ1Y3Qgc29jayAqc2ssIGlu
dCBsZXZlbCwgaW50IG9wdG5hbWUsDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgc29ja3B0cl90IG9wdHZhbCwgdW5zaWduZWQgaW50IG9wdGxlbik7DQo+
ID4gPiANCj4gPiA+IFRoaXMgcGF0Y2ggYWRkZWQgc3RydWN0IHZhbHVlIHN1cHBvcnQgZm9yIGJw
ZiB0cmFjaW5nIHByb2dyYW1zDQo+ID4gPiB3aGljaA0KPiA+ID4gdXNlcyB0cmFtcG9saW5lLiBz
dHJ1Y3QgYXJndW1lbnQgc2l6ZSBuZWVkcyB0byBiZSAxNiBvciBsZXNzIHNvDQo+ID4gPiBpdCBj
YW4gZml0IGluIG9uZSBvciB0d28gcmVnaXN0ZXJzLiBCYXNlZCBvbiBhbmFseXNpcyBvbiBsbHZt
IGFuZA0KPiA+ID4gZXhwZXJpbWVudHMsIGF0cnVjdCBhcmd1bWVudCBzaXplIGdyZWF0ZXIgdGhh
biAxNiB3aWxsIGJlIHBhc3NlZA0KPiA+ID4gYXMgcG9pbnRlciB0byB0aGUgc3RydWN0Lg0KPiA+
IA0KPiA+IElzIGl0IHBvc3NpYmxlIHRvIGZvcmNlIGxsdm0gdG8gYWx3YXlzIHBhc3MgYSBwb2lu
dGVyIHRvIGEgc3RydWN0DQo+ID4gb3Zlcg0KPiA+IDggYnl0ZXMgKHRoZSBzaXplIG9mIHNpbmds
ZSByZWdpc3RlcikgZm9yIHRoZSBCUEYgdHJhZ2V0Pw0KPiANCj4gVGhpcyBpcyBhbHJlYWR5IHRo
ZSBjYXNlIGZvciBicGYgdGFyZ2V0LiBBbnkgc3RydWN0IHBhcmFtZXRlciAoMQ0KPiBieXRlLCAy
IA0KPiBieXRlcywgLi4uLCA4IHR5cGVzLCAuLi4sIDE2IGJ5dGVzLCAuLi4pIHdpbGwgYmUgcGFz
c2VkIGFzIGENCj4gcmVmZXJlbmNlLg0KPiANCj4gQnV0IHRoaXMgaXMgbm90IHRoZSBjYXNlIGZv
ciBtb3N0IG90aGVyIGFyY2hpdGVjdHVyZXMuIEZvciBleGFtcGxlLA0KPiBmb3INCj4geDg2XzY0
LCBpbiBtb3N0IGNhc2VzLCBzdHJ1Y3Qgc2l6ZSA8PSAxNiB3aWxsIGJlIHBhc3NlZCB3aXRoIHR3
bw0KPiByZWdpc3RlcnMgaW5zdGVhZCBvZiBhcyBhIHJlZmVyZW5jZS4NCg0KSSBhc2sgdGhpcyBx
dWVzdGlvbiBiZWNhdXNlIHlvdSBtb2RpZnkgdGhlIHNpZ25hdHVyZSBvZiBhIGJwZiBwcm9ncmFt
DQp0byBhIHBvaW50ZXIgdG8gYSBzdHJ1Y3QgaW4gcGF0Y2ggIzQuICBJcyB0aGF0IG5lY2Vzc2Fy
eSBpZiB0aGUNCmNvbXBpbGVyIHBhc3NlcyBhIHN0cnVjdCBwYXJhbXRlciBhcyBhIHJlZmVyZW5j
ZT8NCg0KDQo=
