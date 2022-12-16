Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1718864EF47
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 17:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbiLPQhS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 11:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbiLPQhR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 11:37:17 -0500
Received: from MW2PR02CU001-vft-obe.outbound.protection.outlook.com (mail-westus2azon11022019.outbound.protection.outlook.com [52.101.48.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548E4B871;
        Fri, 16 Dec 2022 08:37:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJpLfFqE5NUBgonBytHSgloCtzTve7jUYh/1xQRwspYEMlZT+SCLaB45jkAV0r1ZF472cz4JJuscipGW6UPH4frMJ61bk1SQ39+gv0ymJxfXTKJu59Fcs/NSC61HnyFHkQ04kRwqDrUooHo6kK7yNJa/+P2GGpBQdI6OenbTTqrJzYrmcuv9fHRqTioYtAXjsyC3IEE9ZGXwiPOSEwnD89Hl+ezp46PL0J88Bmyspx29VB7S94nklb14Yu/naHJiTD3ghgjHiMT1643DhuNte1xBlPyeKVySyJWBIv3zoMB5mGrlGjaxTuLVl++Y4HwWc0nq1vZGe8+AlPEgiYh3rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0Aglx9Tu8WD5oOEbfqi8w038JsqKgO7eE+9UxlZ6BU=;
 b=ejEpxV0Io37HWRC3DUzGk+IAjd+ZNjUt4OBCcrGLdcmebKWmEy35nMlNv6iPbcEXLTFZnhuus4Slstq6v2On/5anYmye1Ua1FaExV00fOFjxgF3+r6taTZwt0fspgiMoELzb8efZCDxSIk2IIX/H032kGQhYEGdbdSXl3aetChMU95zYR9y6p9Sf+6xVuN4Mmnx4yLHvii0/zeoiDYBCMXddN50dYMkBrxdriHdGff/ZReqlDpk3kLCLOnyRwqrn3DVPx3slMpEclznikLF+V06D1KQVm0AsV7oxCWdeGdhufX10ke4qUgLuMI6Zx9Kuha01YJ90twzI1bBpG9n0cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0Aglx9Tu8WD5oOEbfqi8w038JsqKgO7eE+9UxlZ6BU=;
 b=H7Bt0aXu0XNGygzlneMkx7GSWEWkzwwIPkPYb7sih1gcR+U7f2+z7vkIFQrYi368hYuc8Mg6ZsNHEDXUoW7Oedlunha1vlma2qsohycqJoIs22mfQUmXjrNh29iZy6hpzg9Pxbx3EsdxEbE2K1bII7FZNEzBwvY/Lp9EC/17Fl0=
Received: from BN6PR21MB0788.namprd21.prod.outlook.com (2603:10b6:404:11c::17)
 by DS7PR21MB3174.namprd21.prod.outlook.com (2603:10b6:8:7a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.2; Fri, 16 Dec
 2022 16:37:14 +0000
Received: from BN6PR21MB0788.namprd21.prod.outlook.com
 ([fe80::82e8:8caf:81d7:5d46]) by BN6PR21MB0788.namprd21.prod.outlook.com
 ([fe80::82e8:8caf:81d7:5d46%8]) with mapi id 15.20.5944.006; Fri, 16 Dec 2022
 16:37:14 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     Maryam Tahhan <mtahhan@redhat.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     "jbrouer@redhat.com" <jbrouer@redhat.com>,
        "thoiland@redhat.com" <thoiland@redhat.com>,
        "donhunte@redhat.com" <donhunte@redhat.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "void@manifault.com" <void@manifault.com>
Subject: RE: [PATCH bpf-next v5 1/1] docs: BPF_MAP_TYPE_SOCK[MAP|HASH]
Thread-Topic: [PATCH bpf-next v5 1/1] docs: BPF_MAP_TYPE_SOCK[MAP|HASH]
Thread-Index: AQHZETWa7pxi9i9VV0SS3Z6YJXXor65wmwBQgAAU9ACAAAXfsA==
Date:   Fri, 16 Dec 2022 16:37:13 +0000
Message-ID: <BN6PR21MB0788A33A8AEC16607B2889B8A3E69@BN6PR21MB0788.namprd21.prod.outlook.com>
References: <20221216100135.13125-1-mtahhan@redhat.com>
 <BN6PR21MB0788FD10541056AF887B2B80A3E69@BN6PR21MB0788.namprd21.prod.outlook.com>
 <6b9b32fe-9f83-69f4-61e5-aabe3618af97@redhat.com>
In-Reply-To: <6b9b32fe-9f83-69f4-61e5-aabe3618af97@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4c837f1d-7994-479e-ab50-5eaf99140989;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-12-16T16:33:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR21MB0788:EE_|DS7PR21MB3174:EE_
x-ms-office365-filtering-correlation-id: 3de8beea-5aef-479f-7b3d-08dadf83c947
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ra9FONJbemr46yaNjdvbXm6++SvsQ2pp2kM8nvBzf4fqsaYHhtVfykUY9Z0cD9YZgwgHBBpd5zPoecUMQry4Uqjp90LKLyQyxkpLYzig44v4UvgCadsuxT+eSaQ0c0Y8BWTSau2umctywU1D/2sD2y0XdunAgldXDM6IBi6SHt4DfpGeBj7UQsHXp7jx7vf1TN8AsiJdIynebWacSNn7olDrqmkxk2PlvDW7wZMS/5DthuOAnXUVkJcE0paXHYRtc+iWVfgevEuqn6YrAj088ve7Yw1TmBpRTOMCFRQ+LsKDhsMF2M7kdGN+q5Me0i4Djjtx+PVhabSFc94BBvTsY0KZndZfbWjSSR4XhpkqnxtpbNTPlmJSafcpNf3SHJGxT2xcbx3Gg75+A2DoaqzoM1+hsLGP4zi6YsiOKAEllZApnUgPjSqEzjBXPBlJFvNKlpdiFx3I2rM4f0+qc3wQQ/onlbarW2ZQiATx6iojYu4Gn++oxNFJLKo7KiH3ggt9OjzUpitg4UDzjeV5D/pobApP72xudQZBGIS0TQ24p2LMsj9HEZDF86ike/JcnEJR/wDY2W/sIuS2YK0+4uiD5noA49FMK+G461ZyD+csJbdjxkquD7eFhXJHkeL5Ye3iHXjTjJQ+8K0+j7nkCThsCN2SCtAHfMeeL48bOmyTFQWLSQSc5QtpqjUY5bbYJTKWMMkvamOEpk68LGNql3dn8o1RyabnBZqG7Yab+r5mOtdOOZHLQhb0InQbYsYi/OvhEOi740UOdC3zrztOAm8xAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR21MB0788.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199015)(76116006)(86362001)(66946007)(66446008)(64756008)(8936002)(38070700005)(66476007)(66556008)(316002)(5660300002)(82950400001)(55016003)(52536014)(122000001)(33656002)(82960400001)(38100700002)(71200400001)(186003)(10290500003)(54906003)(110136005)(478600001)(6506007)(8990500004)(8676002)(9686003)(41300700001)(26005)(4326008)(7696005)(2906002)(83133001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGxFNUJpVmR6TzRHNzZJYS9jSTNjcGpIMlhNUzFLMTFzRWFlV1VQWkFyVE1x?=
 =?utf-8?B?WHJoZ0tQYVJPWDNWZGdVZ0w2am4rM28vQVV2Z3k1eUR6RXREYWlSZFVXNGhN?=
 =?utf-8?B?RWxpSG9YTHRHazZmTWI3Vk5vY2tMNXpkN3FuWVNlcnR6dXpLTEpEWitqUUlF?=
 =?utf-8?B?MFB5L0RmejdFaWlUTCsrTlhFQUdURWlndGR5VGVMZVBZQmN2RVN0WFVSai9S?=
 =?utf-8?B?RmQzRHMxL2ZyRmt6NTVKRDFjSWVpczNHYWJUcEI2clVjaXpsYkorVzRqMDBC?=
 =?utf-8?B?US9RVzhFNGRRWTQzbFBzUTVsMU8zOGpmNkFuNFJCckttMVlTTWNocmdBaEVZ?=
 =?utf-8?B?NHREQU9FekFNd0Q3dWdDb3l6MDluaVZkN2MrYjdmQUVRbTkvUDdGbDViZzdw?=
 =?utf-8?B?YlU1Y3p1MkNZWGRIVTk4V0JvWS9QcFREVHIreXRwSWJ6NDA1akcyWVFEWUo1?=
 =?utf-8?B?V2dodFRaWThUcEpjV081a2JCS3VWYVVSbEpJQnUrc1JlcGNqSEc2M0lleXhU?=
 =?utf-8?B?c3VQYWhjbEdZbmEzWVhzUFVtcnUxQk4xdVR0eHQ3cXYyTzlDUHhvb2Q2Wnhq?=
 =?utf-8?B?dFM2Tmx0YldGcmRTZkpQVHFLcmNydnRxaGpPTS9LMHF5TjRBZHQ4Y2lMY242?=
 =?utf-8?B?OFhmZnVSSHNMUXNwYlk4dE81ZFVmdjVaZHhCbTl3cFp0eEovY3NsTE9BT2J6?=
 =?utf-8?B?RW1HT0UwVE1UOE0rZFV4TU1IWW1JVGhaU0FSOUZDS2MwQ084UmFZZW5qWTk1?=
 =?utf-8?B?N2ViS1RsbU5hNWk1Z2RKMWNJYXEvTkNpNkgvQ0xKOGN4d3BpY3BDSDNTVHlV?=
 =?utf-8?B?VVRPYUhlQ0xOU1JZMkNzWmJhNkpuM1EwSWh5cHJ4WHFsaUZPdzNYVktyaFJj?=
 =?utf-8?B?ekZ0UzVFVkFjd1lFbGYwNm5vbERyM3pLMnhTZHhwbW5xZm5WYlo4aUt6aDVY?=
 =?utf-8?B?WWNpbGlqelNBZ2U2OGd5K2N0aVFCNS9TUUFMN2w4UkhaZUhQdHZnZFFHQ1Y2?=
 =?utf-8?B?Q25LQkNGV3Uzd2huaXJDRFgxMW1wY3lldER4anA5L20yMXo3WkM0a2x4K3cv?=
 =?utf-8?B?NUZ2SFZSdno1Zkk4Qm80T0l3OCtwSWFhS0NqdVNwbTY4bjAreHJycFVQVDNj?=
 =?utf-8?B?NGR2N3NFUkFXdWtpZ1RjOWIwdUc0ZHkrZ1dPMnVLMGxybVVuWHpQODhOT252?=
 =?utf-8?B?YVVKQW1mTGIwVFlEQzlRYm1KOVIwNFVYSk5XemlGd2xlRDZvSTZwMnNvQ2ta?=
 =?utf-8?B?UHJERFBJTTRYL3VuMmRwb1ZZTHVGdFFhbmprb01NTWdDeFZReGp5VVpKU25D?=
 =?utf-8?B?L2t6T0tWY3V5SHF0WlB1cGk1dThlQmtFcEJvQ0RYQjZVV0pXbGNYN01uaHhP?=
 =?utf-8?B?TFkreUhaWjFKMnRZL1FIRjRVOUgvQ2lubjJSQjJVZlE4QzhiT1VtWmZBd3FE?=
 =?utf-8?B?MGxQMmZicHI3RlZEMVBaK1pkbHVKNFhVSFlrUDVxeWU5Z25TYURtQVNHaVcz?=
 =?utf-8?B?RmpyVzR0akFXSVRPOUYxVEVkTm9ZT0hMMUFCUW83NDU1WXJvS3l1NFB2RDZq?=
 =?utf-8?B?RENhNnJXRDJCMHc2clpsa0pxdE5lOE1vaXJGdkFlMzAwRURFVytuMWV0OGwz?=
 =?utf-8?B?ZFUxRHB5UlZnSk9lQ21EQ3lKYXBBdDFxRUpWZlBrckRVNDNQREpJVkNhNFJh?=
 =?utf-8?B?L09TOW1WMmZKTWQ5TVlJQ3JiVit2dSt0OEQyMWJMcDlaNGRHMXFUS1J0dC9s?=
 =?utf-8?B?MmpVQVhsSXJLR0l0N0tRTGQ1OHdOTE1IV2U1a3JTcXI4UzRlTTR3ZENtajN6?=
 =?utf-8?B?MXVBK0F6d0thaTY4QXBZRnlOeTV5VUdIM1Yvc0R5UmxlOURjUVJzUk9sM1cy?=
 =?utf-8?B?R3FscmtndWdpWnU3cmczb1FVQmVjVzAzV1p6dVZlaGxEMFVzNmVTREhsUWVr?=
 =?utf-8?B?Q3JLL1FSQlJ3OVlySUdOd0VYVmFCSC9jeGZpWXFMNjdsQjQyUHV6OGgrZHY0?=
 =?utf-8?B?QWx1bDV1ZFZwOTB3VGZOTlFIVERxcFNDL2lVNEE1Y1J3RGRGMmhvMzlqSTg5?=
 =?utf-8?B?Y05HUmg1ejU1R2NOQzV2blEwUW0ySmwzVlNEd0RuTU42Uy9QbWpkZHh0ZXF1?=
 =?utf-8?B?L0E0OEtHSjdLRlZ4N1hCRWdHV1I3Sk55TTFLZDNPRkxmMlJ3Y25yMXJjNFIv?=
 =?utf-8?B?YkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR21MB0788.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de8beea-5aef-479f-7b3d-08dadf83c947
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 16:37:13.6805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kZKY4j5utUlTZch8LGQA/0yWLI/b97I8s2PkNPC9HszCSKfVBlh2pa8gLm/06knvWq4WHx3IqltheY6Z2dpGeldDSSTK9MkOFbX2xtJKjSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3174
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

TWFyeWFtIFRhaGhhbiA8bXRhaGhhbkByZWRoYXQuY29tPiAgd3JpdGVzOg0KPj4gKy4uIG5vdGU6
Og0KPj4gKyAgICBGb3IgbW9yZSBkZXRhaWxzIG9mIHRoZSBzb2NrZXQgY2FsbGJhY2tzIHRoYXQg
Z2V0IHJlcGxhY2VkIHBsZWFzZSBzZWUNCj4+ICsgICAgYGBuZXQvaXB2NC90Y3BfYnBmLmNgYCBh
bmQgYGBuZXQvaXB2NC91ZHBfYnBmLmNgYCBmb3IgVENQIGFuZCBVRFANCj4+ICsgICAgZnVuY3Rp
b25zLCByZXNwZWN0aXZlbHkuDQo+Pg0KPj4gV2h5IHRoaXMgbm90ZT8gIFRoZSByZXN0IG9mIHRo
ZSB0ZXh0IGxvb2tzIHRvIGJlIHVzYWJsZSBjcm9zcy1wbGF0Zm9ybQ0KPj4gYnV0IHRoZSBub3Rl
IGFib3ZlIGltcGxpZXMgdGhhdCB0aGlzIGRvY3VtZW50YXRpb24gaXMgbGFja2luZyBhbmQgdGhl
IHJlYWRlcg0KPj4gaGFzIHRvIGNvbnN1bHQgdGhlIExpbnV4IHNvdXJjZSBjb2RlLiAgQ2FuIG1v
cmUgYmUgZG9jdW1lbnRlZA0KPj4gaW4gdGhlIGRvYyBpbnN0ZWFkIG9mIGp1c3QgaW4gdGhlIGNv
ZGU/DQo+IA0KPiBUaGUgbm90ZSBpcyBqdXN0IGEgcG9pbnRlciB0byB3aGVyZSBmb2xrcyBjYW4g
ZmluZCB0aGVzZSBmdW5jdGlvbnMgZWFzaWx5LiBJIHNlZQ0KPiBsb3RzIG9mIHBsYWNlcyBpbiBk
b2N1bWVudGF0aW9uIHdoZXJlIHdlIG1ha2Ugbm90ZXMgbGlrZSB0aGVzZS4gVGhvc2UgZmlsZXMg
YXJlIA0KPiBlc3NlbnRpYWxseSB0aGUgY2FsbGJhY2sgaW1wbGVtZW50YXRpb25zLCB1bmxlc3Mg
d2UgdGhpbmsgd2UgbmVlZCB0byBkb2N1bWVudA0KPiBlYWNoIA0KPiBjYWxsYmFjayBoZXJlICh3
aGljaCBmb3IgbWUgc2VlbXMgbGlrZSBvdmVya2lsbCBmb3IgdGhlIG1hcCBkb2N1bWVudGF0aW9u
KSwgSSBjYW4NCj4gZWl0aGVyIHJlbW92ZSB0aGUgbm90ZSBvciBtYWtlIGl0IHNlZW0gbW9yZSBs
aWtlIGEgcG9pbnRlcj8NCg0KSSBoYXZlIG5vIHByZWZlcmVuY2UsIGJ1dCBteSBpbnRlbnQgaXMg
dGhhdCBldmVudHVhbGx5IGNyb3NzLXBsYXRmb3JtIG1hcCB0eXBlcw0Kd2lsbCBiZSBhZGRlZCB0
byBzdGFuZGFyZCBkb2N1bWVudGF0aW9uIGFuZCB0aGF0IGRvY3VtZW50YXRpb24gd29uJ3QgaGF2
ZQ0Kc3VjaCBhIG5vdGUgYnV0IHdvdWxkIG5lZWQgdG8gaW5jb3Jwb3JhdGUgYW55dGhpbmcgdGhh
dCdzIHJlYWxseSBjcm9zcy1wbGF0Zm9ybSBpbnRvIHRoZSBkb2N1bWVudGF0aW9uIGl0c2VsZi4g
ICBTaW5jZSBtb3N0IHNvY2tldCBjYWxscyBhcmUgUE9TSVggc3RhbmRhcmQgQVBJcywNCmFueSBj
YWxsYmFja3MgdGhhdCBjYW4gYmUgZGVzY3JpYmVkIGJ5IHJlZmVyZW5jaW5nIHN1Y2ggc3RhbmRh
cmQgQVBJcyBjb3VsZCBiZQ0KbGlzdGVkIGluIGNyb3NzLXBsYXRmb3JtIGRvY3MuDQoNCkRhdmUg
DQoNCg==
