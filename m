Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5364FFD24
	for <lists+bpf@lfdr.de>; Wed, 13 Apr 2022 19:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237373AbiDMRzj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Apr 2022 13:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbiDMRzg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Apr 2022 13:55:36 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3C26D4F5
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 10:53:14 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23DHTdwQ001251
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 10:53:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=lDx3pLht4m+XjSLxGh63pVDAul6j7hmJHgaM5459sM8=;
 b=kG6T762pYCLNd6H787+IhazEo50ek7ullmv+Co7//u3L26Nan3c/bg7+4EI5bmQgmNZS
 9tuLIKhOBYUOnc/cEbTmzFd/2rRMfvRXe2nkkcmf29U0AvIP/0+ubYEpTAkCaCGwKiwh
 xzF3zIjl8gXM3K8NCrLL9k4QvhKMkso+OCE= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fd6p42jxf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 10:53:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/pBW/yQ1am33LdhK1bpSRGFYB0bLcohs5VkIYXkvndIDJ1yZqVNcaJeyWyzeTiVml1zP5q+Rk17gBXNFaFyP/TNq9UdQ+5uQ+MAGS2mNC9W+v13Qa619coGj8kgxq+I1L/td9xqQmSvNuAqYZSjwjDvlfTMZUg92dwJQlW79Rmn3EAHQghBdv0y6ipgDeh7kUx4yXUPNUM3JG6U5exbMM3GRYN9q4y9YD2ASUH55+7cPRh0mMplvgkBKIgfieYdeIBdvIlLxjBEHffbZQl8yqUgWzGJe6DKEcaVXNpEH8t3WMCU6ZN9VSCMesNwlMzxLoZhWdr9WMLIxG7wI39+8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDx3pLht4m+XjSLxGh63pVDAul6j7hmJHgaM5459sM8=;
 b=dFfCd/qlEaT5RFq9/kieR1kuO/ivzTQ301kxJXbl9Z+dg+oOcwttVUBbmhOW2W45eMU9jPwKSR4in+rmievyg9vyFV5Tjb/iDrkKuIr8nPrErzMYuFDczrLHJ7jnWRRSJYgM2WiwgJiJ5wcYyqG1pOrooZiE31O7izflZG8xcbYv9w6ZVTvH5g+uBmXG5mdcVKwgLhby8qBD7HWGfRwPbZrZWXGHtiFkFujK+bCqlh2weFmjFu/9r3nM7M1RAW2C8I/uZkjFBSFOhGKmSxaYtP5NgPSFYVVu59zH1Ao08mu1Sw/WtbAGwzb1ZW9xmd5Tlc8C8vZitOgTMN2nCNNGoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by SJ0PR15MB4712.namprd15.prod.outlook.com (2603:10b6:a03:37d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 13 Apr
 2022 17:53:10 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::20d5:ab50:fdf7:2a9a]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::20d5:ab50:fdf7:2a9a%6]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 17:53:10 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v5 1/5] bpf, x86: Generate trampolines from
 bpf_tramp_links
Thread-Topic: [PATCH bpf-next v5 1/5] bpf, x86: Generate trampolines from
 bpf_tramp_links
Thread-Index: AQHYTo5JA1muDxnP70+zxcYcPdGpOaztI1qAgAD+NgA=
Date:   Wed, 13 Apr 2022 17:53:10 +0000
Message-ID: <dfd67ec4f86552273a89a25f264dcb9e349f3898.camel@fb.com>
References: <20220412165555.4146407-1-kuifeng@fb.com>
         <20220412165555.4146407-2-kuifeng@fb.com>
         <CAEf4BzapYFLns4iDiiRx9PpXftNDOc9jVswwcU_e3ncOeJSvMg@mail.gmail.com>
In-Reply-To: <CAEf4BzapYFLns4iDiiRx9PpXftNDOc9jVswwcU_e3ncOeJSvMg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d62ce791-88bb-4869-30f2-08da1d767992
x-ms-traffictypediagnostic: SJ0PR15MB4712:EE_
x-microsoft-antispam-prvs: <SJ0PR15MB4712179FD150FB26A1F8E22ACCEC9@SJ0PR15MB4712.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g0SpmwaiXj/Zd+b9EzmEH5ZjSD1M38St/6FvOzyhOues/fKA/rjh4X86sXPukf2wA+KtRJqXK0e81IazYt4bl2AiQ2xCw54TfE4MCp2OctjTAdHx5BgHxNuq2iYCC+7jfxzCoWxHqRDX1x9HqP6+d+WvegEsp4sG7+MZN7yL7eDRT45GhKyWyVp/kHViCQmldufGDk6t+rzktK8ffSSzyknGXTksUcNzBJWMDkxc6nOScwCXM0ups6tx7KY38S68wJIR5p67OK/OA//h6oyj/q7W8L8ArXlkC7kZbrN1sMl9orKZWwZ9HGiLOFbmisMOqEXefme6oiYSJtR0Xc/pNgxkiUHwoHuUfLlov9ZaMa3x9wiSTvmGT8JiLb/HYclgoJ+qbb9YQ5rtbWpdiLDFQu+hn7wHToHBgk2T+wGaqk4jz33aj5Q1Ut3Bt8Sa0JIN4jchRIb1HH8nBgejbpXte+zoaSsPopuurwoIkhWvjjJia0TlVGQh9S5aQo20U882jklkxkor165SH9PDVpUbbW2kcOb2zljlkUXbD6do0YGutGXr62MWiM0z+IkkWtCKW4/ECn5YWlLQoIp56YatoCrkNi8LgAnRsYfS74TreuksQMpM1V9HPnTx5gvPbc0n7cgx8DB6QI7criLPXOiefG9bVkr1MEk0aeCvbQkY4oGhHnKnEvyULAyDlowfnxyQAVjVXrAaFazyYiVXD6BHV6cxpGBHX8RT+roHXKSCO9wdHML3vdtW7Q18QFh5+ex7WlctEKLHR2UrddklVh1Tmaue5yzs98thGW06z/XP7Ik=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(38100700002)(316002)(5660300002)(186003)(36756003)(2906002)(6916009)(4326008)(508600001)(38070700005)(966005)(71200400001)(122000001)(8936002)(86362001)(6506007)(2616005)(8676002)(64756008)(66556008)(66946007)(76116006)(66476007)(66446008)(54906003)(53546011)(6486002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djQrUXNFS0RsV3hQV25lQWtFSC9IUGJVWERPSzZwR0VsWjM0NGlTWlN2Q0k5?=
 =?utf-8?B?YVozTzU5c3Z0REdaUmUxUnU4OXVjYm9TM2E1QTR4cTgxWlRuRDNjOVRNeWNs?=
 =?utf-8?B?WkJsMFJZQTZKZllTbUhlUXRtYlMxTFl0eEtZOUtqY3JPRktIK0FFenlTdkdW?=
 =?utf-8?B?Z2gxMzlNdzRSZ0RwOGRSWHNlY3MvMXNqQWJwQVNWeVhSRlMxdzkyUVZiUEMy?=
 =?utf-8?B?NTNkdkFsemVZc1FFL2hWSUROZGx5ODFpQTZGVTRydURXQzZ6Z1hzVHVpdFVL?=
 =?utf-8?B?VmZhKzVydTJPRlJUSmRNUDVVUDFVTTlhdHhUenVOOVV6UUUrY29LTDludExq?=
 =?utf-8?B?STRRdUFYRHpVZENZTFlqRUUwVlRZdE9ibVo4MmYrbFoycGlsTy9mNVRGSW94?=
 =?utf-8?B?U0hCYW53WGEvWnVCTlhZTWFtVkVPblBiYnkxRDgrREdPS3cxdWJRa2dCdzh6?=
 =?utf-8?B?bmRNWlhuY2ZzZlNjK0h4OTRjbFVHbjdMR01VWk9jS0p3dko1RnFkMXdEdU9y?=
 =?utf-8?B?OGROSDQ3NlQxSmxYK3ZGM1lRRW9xNGpPdjE3d1hzblU4WkdHbTBmTkM5dDRr?=
 =?utf-8?B?MHFLdEdnSGw0TlozTFZZTUZ5OUJVTXp5NlRVa1p3U3p1NnEzSG4rbHMxYkVm?=
 =?utf-8?B?VlVwWXMxeU8rSDNBZU1sd1dNeUlHNGtzL2x3RE9tK3lEWVlSTW84blJ0TWFj?=
 =?utf-8?B?T25PcE1Zd3h1T3E1QUN3RWw2eG1Ta2ttdTNLTzRGb1FhNWIzSGZHQ1BKRE8w?=
 =?utf-8?B?MkhqaXFJbVdwSFRvdzgxNXpEQnkxc1FkRkt2c2dMbHNOaUIyQnVBS0Y0ZExt?=
 =?utf-8?B?WU9VUTNGSnR1RkhPSU80TW1yd0ovZUtrZ041NXZGTFZKNE5OOExUVU5rdzAw?=
 =?utf-8?B?SWNxbDFOMFF3UElWdmxtZ1VqR1QyOGdRaTlsNWZwU3B0ek9NQ08vbDlTbXRE?=
 =?utf-8?B?UmFIYXlZdERVTEw0WGc0Mld5d091MFh0UnNVSXgyMysvOC9Hd3RYcVJQTDFB?=
 =?utf-8?B?bWh4KzhGV2VIdGVvL3FDN0EwRG9hY1h2ak12a0hiYVZQbmQrVHVRcDk3UUJk?=
 =?utf-8?B?cWRHV2NyRjQ4Z2JFUzBOVWcxRS9sY2RneTFMdk5oSGplaisvVlQ4eXRoTzlv?=
 =?utf-8?B?c2IwaGp3WkNiSTJQZ0JheDNkdmRKSE1EckYzS0NRWmJ3djVIcXo3T2IwSEF5?=
 =?utf-8?B?d1dXVlFENGVRcEQxVFpaek5kU1BTNUEzazJCaGxnN0lYcXdSTnB1aFljQWJr?=
 =?utf-8?B?eEJkT1ZtVTNEQ3hvenlmRDZxQUlPWFJxMHR0bEdyRjdWc2dCVys2RWNXeHVn?=
 =?utf-8?B?MTJNU3ltTzdpQXhyVmM5MVc4QWdxQS9Xck1EQnM2S1RxSTllcjNocjhzSlla?=
 =?utf-8?B?Q3hFZlJ5QmF5dDVnbFlMM09qZ2F2MjFrN0xaZnpCNWMwM3BSZG9xRW5FYWtq?=
 =?utf-8?B?cDBMdit0UnNNT2ZCOTdnb1RHWWFTc1Zpdk51TVVLazcvdGhEQ2djc0pLa3BB?=
 =?utf-8?B?cDRzVDNWZGVYZFRpQ0FsblZqODkwckZ3eVNEZEpSVml4amxjUGE1K0MxTXRv?=
 =?utf-8?B?Ym50Q3YzTmF1OTlaQlEvWTRZZi9ZbEFaSlgvZHFIU1BZRGNERSsxY2xVTmRM?=
 =?utf-8?B?SzRWRzBPVnh2YVBJdk9HMm9xMThJMHUrbkJZamI2b0wyZWhXMTN3U0tqVnUr?=
 =?utf-8?B?VXo3eXVnRjRJR2M5dk9XY2VXZ3Q3ZGhoVmxPS2xGTFExd0NwN2Q4cWdxcUc0?=
 =?utf-8?B?bDBzaVgybkRxZmpNVk1CeE9EQ0dlNVBiK0lnZndDcDNhTUdjR2R6em8rNllS?=
 =?utf-8?B?UjlVYUROU1R3ZndaSEdvSkdtdEVIVWE2ZURDRlppb0FUQ01HZGxZQjB3amRj?=
 =?utf-8?B?VVlKMnBqYm03eHJSNHdsNWNUeVRKUFpZTjZBNFhhRU5KT3NHK0wxQUdRdXBZ?=
 =?utf-8?B?NGZpdy9PTUtRZkRRU3ZMY1dEV3NVR3dGNHRWRm5xZzlRQStiWEwwbm5DenRw?=
 =?utf-8?B?Z2hFNkk3Z0RMRzdWYjJDbmQ3VTVQd2Fob1M4K3RGWCsvc3FCWlBCdDlyNUJs?=
 =?utf-8?B?QW15bWNvWjJTbUUyM0JUQWxKQldXc0VFWFdKZmluZitENTlHL0ltcXQ3N3VS?=
 =?utf-8?B?NnlOdGhjQ2twZTJhZ0VGUU4ySFVBY3AxRi9oajJ2a01qRDFRaXZFNkRxcXhU?=
 =?utf-8?B?Qi9US3NSOUFaV0hsSit0QWZFT0dCU0R6bDdHMDRiekJiM0dRMCsxOGQwTHV0?=
 =?utf-8?B?ZHFFd2pxb2lyVTJ6KzR5RURSV05lQkV0NHoyZmVjaUdRWTlNRHFEd3FLaEJV?=
 =?utf-8?B?QzFOWHV2NzIvMExNcktOWTZiR0VaL3VFNk0ydW1HVDRsNTN6b3VhSWdRUVF6?=
 =?utf-8?Q?hHT2qHlW7eqRlqDo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79E31588B2D54F4AA2A05C5093076A4D@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d62ce791-88bb-4869-30f2-08da1d767992
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 17:53:10.7910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TXj7HsdcgnlcswySmUIY5iITIO2FSqLByjPTewYmV9YSdA/clyxMJlAw0uSeXXIH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4712
X-Proofpoint-ORIG-GUID: Z-WSr6m65M-p6hR62ZwPf8UAtHSlKbtw
X-Proofpoint-GUID: Z-WSr6m65M-p6hR62ZwPf8UAtHSlKbtw
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-13_03,2022-04-13_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVHVlLCAyMDIyLTA0LTEyIGF0IDE5OjQzIC0wNzAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
Cj4gT24gVHVlLCBBcHIgMTIsIDIwMjIgYXQgOTo1NiBBTSBLdWktRmVuZyBMZWUgPGt1aWZlbmdA
ZmIuY29tPiB3cm90ZToKPiA+IAo+ID4gUmVwbGFjZSBzdHJ1Y3QgYnBmX3RyYW1wX3Byb2dzIHdp
dGggc3RydWN0IGJwZl90cmFtcF9saW5rcyB0bwo+ID4gY29sbGVjdAo+ID4gc3RydWN0IGJwZl90
cmFtcF9saW5rKHMpIGZvciBhIHRyYW1wb2xpbmUuwqAgc3RydWN0IGJwZl90cmFtcF9saW5rCj4g
PiBleHRlbmRzIGJwZl9saW5rIHRvIGFjdCBhcyBhIGxpbmtlZCBsaXN0IG5vZGUuCj4gPiAKPiA+
IGFyY2hfcHJlcGFyZV9icGZfdHJhbXBvbGluZSgpIGFjY2VwdHMgYSBzdHJ1Y3QgYnBmX3RyYW1w
X2xpbmtzIHRvCj4gPiBjb2xsZWN0cyBhbGwgYnBmX3RyYW1wX2xpbmsocykgdGhhdCBhIHRyYW1w
b2xpbmUgc2hvdWxkIGNhbGwuCj4gPiAKPiA+IENoYW5nZSBCUEYgdHJhbXBvbGluZSBhbmQgYnBm
X3N0cnVjdF9vcHMgdG8gcGFzcyBicGZfdHJhbXBfbGlua3MKPiA+IGluc3RlYWQgb2YgYnBmX3Ry
YW1wX3Byb2dzLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBLdWktRmVuZyBMZWUgPGt1aWZlbmdA
ZmIuY29tPgo+ID4gLS0tCj4gCj4gTG9va3MgZ29vZCwgc2VlIHR3byBjb21tZW50cyBiZWxvdy4K
PiAKPiBBY2tlZC1ieTogQW5kcmlpIE5ha3J5aWtvIDxhbmRyaWlAa2VybmVsLm9yZz4KPiAKPiA+
IMKgYXJjaC94ODYvbmV0L2JwZl9qaXRfY29tcC5jwqDCoMKgIHwgMzYgKysrKysrKysrLS0tLS0t
LS0KPiA+IMKgaW5jbHVkZS9saW51eC9icGYuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAzOCAr
KysrKysrKysrKystLS0tLS0KPiA+IMKgaW5jbHVkZS9saW51eC9icGZfdHlwZXMuaMKgwqDCoMKg
wqAgfMKgIDEgKwo+ID4gwqBpbmNsdWRlL3VhcGkvbGludXgvYnBmLmjCoMKgwqDCoMKgwqAgfMKg
IDEgKwo+ID4gwqBrZXJuZWwvYnBmL2JwZl9zdHJ1Y3Rfb3BzLmPCoMKgwqAgfCA2OSArKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0KPiA+IC0tCj4gPiDCoGtlcm5lbC9icGYvc3lzY2FsbC5j
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAyMyArKysrLS0tLS0tLQo+ID4gwqBrZXJuZWwvYnBmL3Ry
YW1wb2xpbmUuY8KgwqDCoMKgwqDCoMKgIHwgNzMgKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tCj4gPiAtLS0tCj4gPiDCoG5ldC9icGYvYnBmX2R1bW15X3N0cnVjdF9vcHMuYyB8IDM1ICsr
KysrKysrKysrKystLS0KPiA+IMKgdG9vbHMvYnBmL2JwZnRvb2wvbGluay5jwqDCoMKgwqDCoMKg
IHzCoCAxICsKPiA+IMKgdG9vbHMvaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5oIHzCoCAxICsKPiA+
IMKgMTAgZmlsZXMgY2hhbmdlZCwgMTc1IGluc2VydGlvbnMoKyksIDEwMyBkZWxldGlvbnMoLSkK
PiA+IAo+IAo+IFsuLi5dCj4gCj4gPiDCoC8qIERpZmZlcmVudCB1c2UgY2FzZXMgZm9yIEJQRiB0
cmFtcG9saW5lOgo+ID4gQEAgLTcwNCw3ICs3MDQsNyBAQCBzdHJ1Y3QgYnBmX3RyYW1wX3Byb2dz
IHsKPiA+IMKgc3RydWN0IGJwZl90cmFtcF9pbWFnZTsKPiA+IMKgaW50IGFyY2hfcHJlcGFyZV9i
cGZfdHJhbXBvbGluZShzdHJ1Y3QgYnBmX3RyYW1wX2ltYWdlICp0ciwgdm9pZAo+ID4gKmltYWdl
LCB2b2lkICppbWFnZV9lbmQsCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCBzdHJ1Y3QgYnRmX2Z1bmNfbW9kZWwg
Km0sIHUzMgo+ID4gZmxhZ3MsCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBicGZfdHJhbXBfcHJvZ3MgKnRwcm9n
cywKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgc3RydWN0IGJwZl90cmFtcF9saW5rcyAqdGxpbmtzLAo+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdm9p
ZCAqb3JpZ19jYWxsKTsKPiA+IMKgLyogdGhlc2UgdHdvIGZ1bmN0aW9ucyBhcmUgY2FsbGVkIGZy
b20gZ2VuZXJhdGVkIHRyYW1wb2xpbmUgKi8KPiA+IMKgdTY0IG5vdHJhY2UgX19icGZfcHJvZ19l
bnRlcihzdHJ1Y3QgYnBmX3Byb2cgKnByb2cpOwo+ID4gQEAgLTgwMyw5ICs4MDMsMTIgQEAgc3Rh
dGljIF9fYWx3YXlzX2lubGluZSBfX25vY2ZpIHVuc2lnbmVkIGludAo+ID4gYnBmX2Rpc3BhdGNo
ZXJfbm9wX2Z1bmMoCj4gPiDCoHsKPiA+IMKgwqDCoMKgwqDCoMKgIHJldHVybiBicGZfZnVuYyhj
dHgsIGluc25zaSk7Cj4gPiDCoH0KPiA+ICsKPiA+ICtzdHJ1Y3QgYnBmX2xpbms7Cj4gPiArCj4g
Cj4gaXMgdGhpcyBmb3J3YXJkIGRlY2xhcmF0aW9uIHN0aWxsIG5lZWRlZD8gd2FzIGl0IHN1cHBv
c2VkIHRvIGJlIGEKPiBzdHJ1Y3QgYnBmX3RyYW1wX2xpbmsgaW5zdGVhZD8gYW5kIGFsc28gcHJv
YmFibHkgaGlnaGVyIGFib3ZlLCBiZWZvcmUKPiBicGZfdHJhbXBfbGlua3M/CgpZb3UgYXJlIHJp
Z2h0LCBJIHNob3VsZCByZW12b2UgaXQuCgo+IAo+ID4gwqAjaWZkZWYgQ09ORklHX0JQRl9KSVQK
PiA+IC1pbnQgYnBmX3RyYW1wb2xpbmVfbGlua19wcm9nKHN0cnVjdCBicGZfcHJvZyAqcHJvZywg
c3RydWN0Cj4gPiBicGZfdHJhbXBvbGluZSAqdHIpOwo+ID4gLWludCBicGZfdHJhbXBvbGluZV91
bmxpbmtfcHJvZyhzdHJ1Y3QgYnBmX3Byb2cgKnByb2csIHN0cnVjdAo+ID4gYnBmX3RyYW1wb2xp
bmUgKnRyKTsKPiA+ICtpbnQgYnBmX3RyYW1wb2xpbmVfbGlua19wcm9nKHN0cnVjdCBicGZfdHJh
bXBfbGluayAqbGluaywgc3RydWN0Cj4gPiBicGZfdHJhbXBvbGluZSAqdHIpOwo+ID4gK2ludCBi
cGZfdHJhbXBvbGluZV91bmxpbmtfcHJvZyhzdHJ1Y3QgYnBmX3RyYW1wX2xpbmsgKmxpbmssIHN0
cnVjdAo+ID4gYnBmX3RyYW1wb2xpbmUgKnRyKTsKPiA+IMKgc3RydWN0IGJwZl90cmFtcG9saW5l
ICpicGZfdHJhbXBvbGluZV9nZXQodTY0IGtleSwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgc3RydWN0Cj4gPiBicGZfYXR0YWNoX3RhcmdldF9pbmZvICp0Z3RfaW5mbyk7Cj4gPiDCoHZv
aWQgYnBmX3RyYW1wb2xpbmVfcHV0KHN0cnVjdCBicGZfdHJhbXBvbGluZSAqdHIpOwo+ID4gQEAg
LTg1NiwxMiArODU5LDEyIEBAIGludCBicGZfaml0X2NoYXJnZV9tb2RtZW0odTMyIHNpemUpOwo+
ID4gwqB2b2lkIGJwZl9qaXRfdW5jaGFyZ2VfbW9kbWVtKHUzMiBzaXplKTsKPiA+IMKgYm9vbCBi
cGZfcHJvZ19oYXNfdHJhbXBvbGluZShjb25zdCBzdHJ1Y3QgYnBmX3Byb2cgKnByb2cpOwo+ID4g
wqAjZWxzZQo+ID4gLXN0YXRpYyBpbmxpbmUgaW50IGJwZl90cmFtcG9saW5lX2xpbmtfcHJvZyhz
dHJ1Y3QgYnBmX3Byb2cgKnByb2csCj4gPiArc3RhdGljIGlubGluZSBpbnQgYnBmX3RyYW1wb2xp
bmVfbGlua19wcm9nKHN0cnVjdCBicGZfdHJhbXBfbGluawo+ID4gKmxpbmssCj4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGJwZl90cmFtcG9saW5lCj4gPiAqdHIpCj4gPiDC
oHsKPiA+IMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5PVFNVUFA7Cj4gPiDCoH0KPiA+IC1zdGF0
aWMgaW5saW5lIGludCBicGZfdHJhbXBvbGluZV91bmxpbmtfcHJvZyhzdHJ1Y3QgYnBmX3Byb2cK
PiA+ICpwcm9nLAo+ID4gK3N0YXRpYyBpbmxpbmUgaW50IGJwZl90cmFtcG9saW5lX3VubGlua19w
cm9nKHN0cnVjdCBicGZfdHJhbXBfbGluawo+ID4gKmxpbmssCj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBicGZfdHJhbXBvbGluZQo+ID4gKnRyKQo+ID4gwqB7Cj4g
PiDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT1RTVVBQOwo+ID4gQEAgLTk2MCw3ICs5NjMsNiBA
QCBzdHJ1Y3QgYnBmX3Byb2dfYXV4IHsKPiA+IMKgwqDCoMKgwqDCoMKgIGJvb2wgdGFpbF9jYWxs
X3JlYWNoYWJsZTsKPiA+IMKgwqDCoMKgwqDCoMKgIGJvb2wgeGRwX2hhc19mcmFnczsKPiA+IMKg
wqDCoMKgwqDCoMKgIGJvb2wgdXNlX2JwZl9wcm9nX3BhY2s7Cj4gPiAtwqDCoMKgwqDCoMKgIHN0
cnVjdCBobGlzdF9ub2RlIHRyYW1wX2hsaXN0Owo+ID4gwqDCoMKgwqDCoMKgwqAgLyogQlRGX0tJ
TkRfRlVOQ19QUk9UTyBmb3IgdmFsaWQgYXR0YWNoX2J0Zl9pZCAqLwo+ID4gwqDCoMKgwqDCoMKg
wqAgY29uc3Qgc3RydWN0IGJ0Zl90eXBlICphdHRhY2hfZnVuY19wcm90bzsKPiA+IMKgwqDCoMKg
wqDCoMKgIC8qIGZ1bmN0aW9uIG5hbWUgZm9yIHZhbGlkIGF0dGFjaF9idGZfaWQgKi8KPiA+IEBA
IC0xMDQ3LDYgKzEwNDksMTggQEAgc3RydWN0IGJwZl9saW5rX29wcyB7Cj4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBi
cGZfbGlua19pbmZvICppbmZvKTsKPiA+IMKgfTsKPiA+IAo+ID4gK3N0cnVjdCBicGZfdHJhbXBf
bGluayB7Cj4gPiArwqDCoMKgwqDCoMKgIHN0cnVjdCBicGZfbGluayBsaW5rOwo+ID4gK8KgwqDC
oMKgwqDCoCBzdHJ1Y3QgaGxpc3Rfbm9kZSB0cmFtcF9obGlzdDsKPiA+ICt9Owo+ID4gKwo+ID4g
aHR0cHM6Ly9kb2NzLmdvb2dsZS5jb20vZG9jdW1lbnQvZC8xRllZZGkxSHc0cGp1bGJrdkkxVm1H
LWtHcVRKUkNnN2JoMXZBRjRid2pNYy9lZGl0P3VzcD1zaGFyaW5nCj4gPiArc3RydWN0IGJwZl90
cmFjaW5nX2xpbmsgewo+ID4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3QgYnBmX3RyYW1wX2xpbmsgbGlu
azsKPiA+ICvCoMKgwqDCoMKgwqAgZW51bSBicGZfYXR0YWNoX3R5cGUgYXR0YWNoX3R5cGU7Cj4g
PiArwqDCoMKgwqDCoMKgIHN0cnVjdCBicGZfdHJhbXBvbGluZSAqdHJhbXBvbGluZTsKPiA+ICvC
oMKgwqDCoMKgwqAgc3RydWN0IGJwZl9wcm9nICp0Z3RfcHJvZzsKPiA+ICt9Owo+IAo+IHN0cnVj
dCBicGZfdHJhY2luZ19saW5rIGNhbiBzdGF5IGluIHN5c2NhbGwuYywgbm8/IGRvbid0IHNlZSBh
bnlvbmUKPiBuZWVkaW5nIGl0IG91dHNpZGUgb2Ygc3lzY2FsbC5jCgpJdCB3aWxsIGJlIHVzZWQg
YnkgaW52b2tlX2JwZl9wcm9nKCkgb2YgYnBmX2ppdF9jb21wLmMgaW4gdGhlIDNyZCBwYXRjaAp0
byBnZXQgdGhlIGNvb2tpZSB2YWx1ZS4KCj4gCj4gPiArCj4gPiDCoHN0cnVjdCBicGZfbGlua19w
cmltZXIgewo+ID4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IGJwZl9saW5rICpsaW5rOwo+ID4gwqDC
oMKgwqDCoMKgwqAgc3RydWN0IGZpbGUgKmZpbGU7Cj4gPiBAQCAtMTA4NCw4ICsxMDk4LDggQEAg
Ym9vbCBicGZfc3RydWN0X29wc19nZXQoY29uc3Qgdm9pZCAqa2RhdGEpOwo+ID4gwqB2b2lkIGJw
Zl9zdHJ1Y3Rfb3BzX3B1dChjb25zdCB2b2lkICprZGF0YSk7Cj4gPiDCoGludCBicGZfc3RydWN0
X29wc19tYXBfc3lzX2xvb2t1cF9lbGVtKHN0cnVjdCBicGZfbWFwICptYXAsIHZvaWQKPiA+ICpr
ZXksCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZvaWQgKnZhbHVlKTsKPiA+IC1pbnQgYnBmX3N0
cnVjdF9vcHNfcHJlcGFyZV90cmFtcG9saW5lKHN0cnVjdCBicGZfdHJhbXBfcHJvZ3MKPiA+ICp0
cHJvZ3MsCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBicGZfcHJvZyAqcHJvZywKPiA+ICtp
bnQgYnBmX3N0cnVjdF9vcHNfcHJlcGFyZV90cmFtcG9saW5lKHN0cnVjdCBicGZfdHJhbXBfbGlu
a3MKPiA+ICp0bGlua3MsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBicGZfdHJhbXBfbGlu
ayAqbGluaywKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0IHN0cnVjdCBidGZfZnVuY19tb2Rl
bAo+ID4gKm1vZGVsLAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdm9pZCAqaW1hZ2UsIHZvaWQgKmlt
YWdlX2VuZCk7Cj4gCj4gWy4uLl0KCg==
