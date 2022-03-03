Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690F34CC4F8
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 19:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiCCSTx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 13:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiCCSTw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 13:19:52 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263F1AA2EE
        for <bpf@vger.kernel.org>; Thu,  3 Mar 2022 10:19:07 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 223Dt2lI018191
        for <bpf@vger.kernel.org>; Thu, 3 Mar 2022 10:19:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=+RHp0qoppHWG+nPoax9EhHYYQrG62KLyCu97yVpcqK0=;
 b=AGZFmJFmI/CnVnuKkE71sik75m/dNfovr1EkfEq+EW8XKiuUIQnmg940o/OIbrCxBv0S
 Zam7BEHG4em8qKllfWVAnbe7bmDEqI/nKJrGNf4FzXibrqxbe08tWP/LOpPIES3b+OCC
 0fZufRNktmrfqd5efUC0DGKSeCJTB49sj+w= 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ejxyn1y0u-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 03 Mar 2022 10:19:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j59XI/+wJj4aveZVmJXYanRcGxy5uiPZMW7uba+vgMWrLTmBq8jbaIOJpHBlGJ5p8+WvxQtiZjwn/3RS4UKjs5yJ0YENf6Y8nOb3dth0xxl95EQ30BfGPgKZ9xpbRCnYccvws7jowHE2gzda9J8a3RWt2QgwDm9gIrY5Jq8oxXmIGTY5cCW4wSuxW7DQtsF7An3i+FW/x7VcLR4lqEAuMcO8xfRNJ3SzrsjGkXT43lae5OzUrktAlreTImwJjfWvXAM9epJlfsEBXHeCfRnxbsYFels0QKrbfOoULODWKCK3OAENHr2s1rNlTrm9/CMsrrVmfAqqFtHPUh6YvIi6wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RHp0qoppHWG+nPoax9EhHYYQrG62KLyCu97yVpcqK0=;
 b=IDE9mOm563X1Tsain8oQz4muj0GROe8x+r9Un14dfmQyoeLtR+H81U3zPe2rR4Z2rAivm4U7jQAxTuMVsnsHcecjPr5rC2f1WgkmTqnwAIKP4CcO13J48d07YQcs9siXw3oND5shG1UakpdwN1KHJbBRa7K2zsiC5knTtjR9MUcaXrjSUi/mxVdy3Aesb9l0FYu1u3SPqCr61EhO6KLK9wHI/fNV2W9ki6TYlNRKcR5YF6evc/GCYsgt68QR1TCYtf+hwbidwCkmhxmbqI5q5p9WNUtkKtxnbdAL269Vr9C7mRpTArcpR/yqxh+Eap/8nIARFGh9h30Ahx0BLIjtwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by DM5PR15MB1212.namprd15.prod.outlook.com (2603:10b6:3:b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Thu, 3 Mar
 2022 18:19:04 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3%5]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 18:19:04 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/4] libbpf: expose map elf section name
Thread-Topic: [PATCH bpf-next 1/4] libbpf: expose map elf section name
Thread-Index: AQHYLeANziTDQjpLnUSAtW0AvQ3uFays2+UAgAEdR4A=
Date:   Thu, 3 Mar 2022 18:19:04 +0000
Message-ID: <f66d1cf491c9c37179232c84a18a6d870cac4ec4.camel@fb.com>
References: <cover.1646188795.git.delyank@fb.com>
         <c298c45f77ba2fc12fb54da5ea73b5a4dfbfe763.1646188795.git.delyank@fb.com>
         <CAEf4BzYqYZW_tioR+hH6_hZb3N4kgEbDvuShUngrJ-9k=tKD0g@mail.gmail.com>
In-Reply-To: <CAEf4BzYqYZW_tioR+hH6_hZb3N4kgEbDvuShUngrJ-9k=tKD0g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c91c4ec6-062f-405f-72c1-08d9fd424ca0
x-ms-traffictypediagnostic: DM5PR15MB1212:EE_
x-microsoft-antispam-prvs: <DM5PR15MB12120510E30DA62CC719183BC1049@DM5PR15MB1212.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wlVCKXVuZW3Zukb6hWo1URsRPPySpmeexwuFkyFb2QhUvm2+H9BChS8oB2emXKNo0DJb6zqWMUno1RLWhA4WV6k8vFoXeld0YeY6SGehUFSPm2TFAH3GIm896PYJ2lGBj1Kzz9tPQhfkKvDc6ODtFavrEo30+dShiITBVIEC/VgqT2XQl/GPOOmvyRSdTnjEwLJuqBe6yOwaRdlGDY2NLV/QNv6gbkGkp9IUGykpOTxCR4kC3RNkcO7DdJ+WJjaXYSgBWW1tZG3Xdz4DgyjY68s5sc8HcpkpxCqR4lWZHXeU2siMTDdYVJbEb9nzkXa98IHQLaZC17STnkqxdIbxRrV/bnflGb4OV0mzLCkdqdBglskfopVzG8JvyGZHH8qGelTOs7FqhJP82tAdpyvx0dipzu4XtFc3mZppyQDDO3jbZcALfUtLouFYNk6035tZjeTdVddTL/VE2/2GUW/gQXNgNEWAZcaVkSxq5/qSOWE6o8xhgFJwvGiJUEal4qhX7YH4JtMAPryNFl2R9ZTfFAr6PlJwz6iuUGJaiTFrVkGbd15M6NieC0CZxW/9Zt6EUjPAdsa7NhVv9V4swTusgtnbDXWvRZIFEdx/11pCA5uNJVxPAVuPsjXJkW7a1WhKHtVp0UZxVFcIRUVRm9d2d0EhVQw1Ew01QWwwLeZMB5BXRDgGUtgpOV9mHwRteOG1xIvs5ikl1+qkToGFdJurFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(4744005)(8936002)(71200400001)(2906002)(38100700002)(4326008)(36756003)(8676002)(6512007)(6506007)(38070700005)(66556008)(54906003)(66446008)(64756008)(66946007)(186003)(316002)(6916009)(2616005)(26005)(76116006)(91956017)(66476007)(86362001)(508600001)(122000001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0oxMlQvRzVyREl2N3BBU3ErVktmNjNjTWNtcUFEc0ljeHozZllhcnVNY0dt?=
 =?utf-8?B?dURmUWpUL1ZOYmUybHdZSzV0cy9JdXpkVkYzUnd2SE5FRGsybnp0RkhoS2FK?=
 =?utf-8?B?UlM3di9pbFVpZ1FxTzMwL05oTGQ1bUV2K09yamN0UHFsYTVnYmJFeXRXTTJr?=
 =?utf-8?B?WnhzQk1KZCtRZGtPOEx2cGZqNGkxdGxtSk1aMWJQUEVZYk5CQ0xSVzBWdlVU?=
 =?utf-8?B?R2diU2ttSGpTZXNSdFVPUEEyOUVQWXNOVWxhdW1ZOElkU1d6eTZFOHFCT0dy?=
 =?utf-8?B?NmxjenBoZW1Xck8yVy9XSzhBL3NKTWdVTXVmb2xiRFhrQUdUQzc4SHlrWUJK?=
 =?utf-8?B?Qkgyc3dsOTNCSEsrYnpLWWtjcEsxWlh2UTlaZ0dRQ3dEWUdjdmZoUzB1UVBy?=
 =?utf-8?B?NHBBbWNHVFlOZS9EWG80eTZpN2U1Y3VlZHIzMEt1dHRrNjBVN29LS3M4RUhy?=
 =?utf-8?B?V0pKTlllaXhEQi81blVpWnhyRWtwZDMwdXdOSVJ4YlFQdm9RZndSRlF4UEhz?=
 =?utf-8?B?RE1CT05vNVBJcGU5bWRHSmxGODBSZ1lFMUlSOUY4b1NFY2U3VmRTczNXOFF0?=
 =?utf-8?B?Um5aRFJYaCsxY0JlRjg1K1p1VDk5TGtwU3g4eTlpWjlRdVJycUNlSUZld0xN?=
 =?utf-8?B?RU5CWVdpZEJQb0VvUmRTV28ybmppMitwWHhuQkxHMk95Y0hXb29TVUVsTUxa?=
 =?utf-8?B?Sm50MzdPa3I2UlZjU0NTWE1RWlo3dE5BS3JUdFNONnhVWjRRTTl1QmVxTzNW?=
 =?utf-8?B?d3JVakp3Z0RSV28xd0EzRHYrd1hGZWVIN1lLckMrdVU4VVdnbmJmS3RMaFdq?=
 =?utf-8?B?dERVNFNXdGV0aCtLWW02NEN6VURvT21QNlUwVGZjTUVpSFBMM1VRazROU0h1?=
 =?utf-8?B?MVZNZ21sTTJQcjN0MFVIYy9SbzdJbk1rL1NpUFVTWjkrQ0s3a1JjNDlLamUx?=
 =?utf-8?B?R3phRGlpTVFFUllSMGhZUDJoVzZRTVZmNjdlU3VLWG55TmJ5OUVPNGhpRUdO?=
 =?utf-8?B?ZE1pY3NuL3RWSU90N1lYZnhkWjNuY1dqaTdYSHNOR2hWZGtxeFAxdFYwTUZX?=
 =?utf-8?B?cmxRN3dTTllBSjA4VEp3MVJFMTFmRkZndHV4eXVIVjlPRnBCVmt0VHB4N1pZ?=
 =?utf-8?B?YkhVZ2FteU1rTC9RL2Y4d2tmRTFHZmNySFp3VElIMTNUUHhFUDA1VnYzMHJY?=
 =?utf-8?B?ZDNzNG5ka2VicWV6YjNlK2NHSnhNbklIenY4Q091emIzRk5tbURUYSsyaGhD?=
 =?utf-8?B?MzlnMkw3R2VzUG9qUGZkb1AydkhWdjVnNlI4Y0VtRnV5SmZEZ1BmUDdDcjFo?=
 =?utf-8?B?cGUzelV2a1RibEoyT0lQejZtVGVhazZUSDdmM210K3ZvQ3UxdU1SL1JJN2lK?=
 =?utf-8?B?YzNaOHJ3c2tlc1FBZnluNkpCQXdHYjZYblQrQXV4UkxFQy9idGhtd25VVVBY?=
 =?utf-8?B?VHVobHhCOTVtRkdxU3JFNDA0cjkwL2F6WTM5K29hRkxFVDJRcEVQdkJTY253?=
 =?utf-8?B?WmFXZ213OGFZSi9OT2ZEMHYrdlRscUhXekxlcDN2aWdQSHlXRXVqSkZtMmdq?=
 =?utf-8?B?cEk0Wi9GSFpieU5BMHlxMUwvQ1pnNnNjazdKNmFSTHNYVTNLMnZqWFl3TGl2?=
 =?utf-8?B?czMwUjhqbEc4dkdjS3padGh3YkhuZFhxY0E4a0lDSU5SSndNcDMxMnU4S0ox?=
 =?utf-8?B?NHZObHhjR0h1cGpnWjJzb2ZFVGtVb2FZYUpUZ0xZRHJNZzZQWGJFeTdyNWtV?=
 =?utf-8?B?R2pYYkpNT0FNRmUwS2R3bVR0U0ZhOEFMU1dPOW13RmNLVlpBQkFEaGRrWDF2?=
 =?utf-8?B?SWwrYTE5aWlveVozcDRvMXpicTZGNWE2dXNkVzVmd2ZwQzQwNTNIektKamJ6?=
 =?utf-8?B?SzRUQ1BKc2J3YjZzdStIVlNMNU95cjVuK1dUVDRwSitlU25vTDlqWW5rTnhx?=
 =?utf-8?B?cTBvRUtlb1ltam1qbjgybkpCRmdicXBMKzZtM2JkUThnaWFRS29raXRkbWND?=
 =?utf-8?B?TlZBUzRXY3Q1UEEvYUdvbXJHbUJXcXVIL1lmc1hsUXEwWWx3ODF0TGR0WlhB?=
 =?utf-8?B?M3FtMlZsUm91c1R1Ukw0OWE3NTdDQVordUFsVFBpQWxQVU9ESk1jZ0dJb3RH?=
 =?utf-8?Q?RxFc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0C07399FC931B4CA51FDC6F7B775B32@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c91c4ec6-062f-405f-72c1-08d9fd424ca0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 18:19:04.3794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BCV61NNEepDNSyg7jgV65EqbjPmm7zVOGIKZdp9/BmCDr1ydaf3DFHDzKi2zF8iL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1212
X-Proofpoint-ORIG-GUID: vkfS1F6yWpaw-srWGfeRmYgaIILS6FlP
X-Proofpoint-GUID: vkfS1F6yWpaw-srWGfeRmYgaIILS6FlP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-03_09,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 adultscore=0
 impostorscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 mlxlogscore=613
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2203030083
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

T24gV2VkLCAyMDIyLTAzLTAyIGF0IDE3OjEzIC0wODAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
DQo+IEZpcnN0LCAic2VjdGlvbl9uYW1lIiBoZXJlIGlzIGV4dHJlbWVseSBjb25mdXNpbmcgaW4g
dGhlIGZhY2Ugb2YNCj4gYnBmX3Byb2dyYW1fX3NlY3Rpb25fbmFtZSgpIHdoaWNoIHJldHVybnMg
YSB2ZXJ5IGRpZmZlcmVudCB0aGluZyBmb3INCj4gQlBGIHByb2dyYW0uIEJ1dCBJIHRoaW5rIHdl
IHNob3VsZG4ndCBuZWVkIHRvIGRvIGFueXRoaW5nIGV4dHJhIGhlcmUuDQo+IFVzaW5nIGJwZl9t
YXBfX25hbWUoKSBhbmQgdGhlbiBicGZfb2JqZWN0X19maW5kX21hcF9ieV9uYW1lKCkgc2hvdWxk
DQo+IGp1c3Qgd29yayAodGhlcmUgaXMgcmVhbF9uYW1lIHNwZWNpYWwtaGFuZGxpbmcgZm9yIG1h
cHMgdGhhdCBzdGFydA0KPiB3aXRoIGRvdCkuIElmIHRoYXQgcmVhbF9uYW1lIHNwZWNpYWwgaGFu
ZGxpbmcgZG9lc24ndCB3b3JrIGZvcg0KPiBzdWJza2VsZXRvbnMsIHdlIHNob3VsZCBmaXggdGhh
dCBzcGVjaWFsIGhhbmRsaW5nIGluc3RlYWQgb2YgYWRkaW5nIGENCj4gc3BlY2lhbCBnZXR0ZXIu
DQoNClRoYXQgc3BlY2lhbCBoYW5kbGluZyBkaWQgbm90IGRvIHRoZSByaWdodCB0aGluZyB3aGVu
IEkgZmlyc3QgdHJpZWQgaXQgYnV0IEknbGwNCnBva2UgYXQgaXQsIGlmIHRoYXQncyB0aGUgcHJl
ZmVycmVkIGFwcHJvYWNoIQ0KDQpUaGFua3MsDQpEZWx5YW4NCg0K
