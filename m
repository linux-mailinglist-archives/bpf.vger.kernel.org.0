Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEE05F46FF
	for <lists+bpf@lfdr.de>; Tue,  4 Oct 2022 17:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiJDPzo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 11:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJDPzn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 11:55:43 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11023019.outbound.protection.outlook.com [52.101.64.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87C627DC7
        for <bpf@vger.kernel.org>; Tue,  4 Oct 2022 08:55:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOcV8cb2o3MG1iiK+9+iiQNqdY2V4ZpUThMCg6rOTFPXI3Rzbg8irTfU5Mu3XsN0UporUv2suRi2lbwLJJ5VQHgDQfcUOrFCK7gb0lzN8vRU3AiXTTOSoSazn+CPbLUTGUCbbteZ63Vj59Jmp7A0vSI9lRwZ9jmoCBTtQD5ux3QoNkuBPVjSzrkyJhepZi49liLo/5DV2Yd+VbF1AjDcHSQvf0dSofNJUcSV2258bn2sZkCvd+JSGHselolvdmsDw2syqvZgpFjkTPm6uAbD2qmdn8R2ZTdjuWWKm2G5NxVSdq0/ZTKnoz7tgZg5jjUXNmBAVeztdC0dCxq3BqAH9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YITHKWziOgIZnmBXQ54anzu7qtx9RqMF74pE/90ViyA=;
 b=PTfMiz573XC4FulUb4VGYmMSn84O4jkQ4RTTSe4yMrM7JngCWNGtFBxnqhWBYBhInm/sjJE+7W/1sxNi/ufBUJJVKjW12/lD0asfGdHsLNHWslQuZiZhvLEnrdcPvrAJBlc/4Xl8tbLhwhz6XfEVI2movS4Ky527KonVj3M+g6CxTiUEj9hxzGEEofgDrLxGY4nL+yN0GRR3oMHLtMklA3ASW/FTRiFkam7YyB4aFyDYVAow2P4YLMVkV594TGuuZrPrnOpAMTDRP6YA12VDLWcEO+5d89Sia5kATyX915KaNaNaUkYs6T5KDVWULGeQ9+oIT9vVTnn9vvO4MrA5aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YITHKWziOgIZnmBXQ54anzu7qtx9RqMF74pE/90ViyA=;
 b=QmkNiEh7sykQjWfGtoYwwZG+PecFfxy2oT6xtQNrvs8U1gLneRCDt33mkPY3HorPiWj0L3PpmPXF5a+EW+aD41uyjLOY99Aa6YD5zi97Jc2IhLwwDZPRFzshZUXB6cKKVJVjPaDQKe7zRYL5fB1zyxut4wZYYKQuTMJhiizlHZk=
Received: from DM4PR21MB3440.namprd21.prod.outlook.com (2603:10b6:8:ad::14) by
 SJ0PR21MB2023.namprd21.prod.outlook.com (2603:10b6:a03:399::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.9; Tue, 4 Oct
 2022 15:55:31 +0000
Received: from DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::c76c:9386:3651:999d]) by DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::c76c:9386:3651:999d%3]) with mapi id 15.20.5723.008; Tue, 4 Oct 2022
 15:55:31 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH 11/15] ebpf-docs: Improve English readability
Thread-Topic: [PATCH 11/15] ebpf-docs: Improve English readability
Thread-Index: AQHY0qNqv++jE8+E60q227lL8nNlGa34j0YAgAXGAWCAABQHAIAABHbQ
Date:   Tue, 4 Oct 2022 15:55:30 +0000
Message-ID: <DM4PR21MB3440DF39304851D5F6108039A35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
 <20220927185958.14995-11-dthaler1968@googlemail.com>
 <20220930221624.mqjrzmdxc6etkadm@macbook-pro-4.dhcp.thefacebook.com>
 <DM4PR21MB3440664B3010ECDDCF9731D1A35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
 <CAADnVQJQvdN2Dm7pwMno59EhMB6XT35RLMY4+w_xhauJ0sdtAQ@mail.gmail.com>
In-Reply-To: <CAADnVQJQvdN2Dm7pwMno59EhMB6XT35RLMY4+w_xhauJ0sdtAQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e6f77def-86ea-4754-830f-5f08c7388d6d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-10-04T15:54:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3440:EE_|SJ0PR21MB2023:EE_
x-ms-office365-filtering-correlation-id: a511e3ec-ce68-48bb-1dbb-08daa620dd66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 23CTRnHrmrPZGVeZGtgLI8Cd2NvjE2nbqS27+xLMWfBtBFbAXnhMFfJYfmLXYmsvBsCQ93GkjXJ98/n6LvWXHmcKL+s0Yw3IKC3zzmvTpTVrr97p8EIpgE/aERbLCe9mYAVWLKF1xplKwjPpoMb5fytaaogVnUlgMNjlyMLqepVfYZ8ZRgz6UBCZTzfpEr9j4KtVwzw+VNme04I/doWZvCBI7gZCE2Ykzk5r2VCHKekXmIs9amOMl24WTmKbD1U++h3vYeyJckfnDn+7uCjfb+aXVlwEV4vhUp9HAQIqrNy8D3Xcn2AmaXGjH8oBjC+o4AHVScRWcgINJyUkfAcWiwbPtgJoFXILEMaqxNCmZcxqnn7BObu6uUvu815iQleIAyuE6FBe07au3FTPedw/vI/xFEerlVyvBrZ63c1HWvo11kz4rxStBNuHuq18KuxiCOg2UeXfIqKcbX4JIL89TRO3VaDyeeYU6AdKaBkVKpU0wfWSHvr81bQLbzzK/y0netSIfyB56sCFTKo20aTh41pmwXZ8U8m71taluLNGGV2dbkOooyp2952D9xLd+Nhgrvqyt3Zy1SVtx5dkOkFjsbDNgO6x1a6VZ7IConlLipgepgp0s9FOjP1CJGO8UrRD2ccw8o0Q/j0FL5cb8ubRvHzZ+U/TfPx8/gf2LUEHlVMGOvicGXQwA8Zb7j4UXSfPlCpppgm+97jFA4zlqnEPSpGuLeAajdYVglo0HPpxU2Xdqh+VuanglYZyu0fevkyCTah5z8kUvsisn+43i7bLAyosT81D0WABCinDlZkvbkXIC5296v70lwbHcViFzpYn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3440.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199015)(66476007)(64756008)(66556008)(8990500004)(66446008)(82950400001)(66946007)(38070700005)(4326008)(55016003)(8676002)(82960400001)(76116006)(6916009)(38100700002)(316002)(122000001)(26005)(33656002)(9686003)(6506007)(186003)(7696005)(10290500003)(83380400001)(478600001)(86362001)(71200400001)(8936002)(4744005)(52536014)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWZqUUNFU3BOcXpRQnZweFVFNEFvODRkQ1ViQmQwekRSbDl3dnVzREVEU08x?=
 =?utf-8?B?U2VYMXFoMFZKTXRkZDNlNmxUQ0RoSEJrZ05LZGdGTlJpcGR5Z2pocStHT0l2?=
 =?utf-8?B?NkY0U24vTEtGQnMrQTA5WHl4bmhRYU9XeWgyalBVbHFvMXp5TElzRHpMRUpJ?=
 =?utf-8?B?eXBOYjU3bG1zcGRsNHRPMzh1R01RTUx4YWticmNaZittaDZnSTNJM2s0eWNs?=
 =?utf-8?B?eTVqd2dxRndLbXY3WldleXhqOElYam1yZWMrWVYzamo4MXd1dGlyMkJYaFZM?=
 =?utf-8?B?WWtVaEdoK1FXRU52MHNQalFaRWhWaVBwWFpVbFBXWWhhY0E3SUoyeVFPYk1R?=
 =?utf-8?B?TGNwNzJkMjkxSzVjdHd2d1orN3BxcEN5MmpSZkQ5WGVkRHdsbTlmcUJxUC9k?=
 =?utf-8?B?akNNR3gyRXJmY09FUTlGWlg0dUZVallMNWlrcFpsVGxJYlJVazZZSVN2UFF3?=
 =?utf-8?B?bXRkaWx3MkViZEZEVTFZZkpLY1RuQ1hTV2F3ZWsxOUQ2eUh4S2Y5ZlBZek94?=
 =?utf-8?B?bG8wM0tVSDFsbGRJaW92d09FbXZvNWlvc1VsdUtjRE5yRG05QnFYZFJMeFJV?=
 =?utf-8?B?VHN2cVlkbitoQzY0WHZoMi80dzIzbThCR3d0aFZhajNqRW9iTzV3a1VYN2Q2?=
 =?utf-8?B?a1dPYmhQZ05YNnQ1S3owelVqU3FLVW9uVjJmRG8rZEVFVk5uQmNQU2dOSTZH?=
 =?utf-8?B?WUo1Ulcybkd0M0t1TTFqK09PWW83bUNOeE5iMzE4M2ZSN3VpWXo5all1OVlS?=
 =?utf-8?B?SEgvb2xiSTk0SmMvZnQ0Q0R2VzR6WXBNbmx0eUdINm93Uy91dGcyVkJ4NkFB?=
 =?utf-8?B?WG1xWUdLeTdlaG94NnFnNjNZRkVXbjRGUXdOVEpaekZQc0R4QVZWVUNjT2Z6?=
 =?utf-8?B?SE16T3BzWS9LbnlmN1lGYkJmVm5Ec01RUXFHUmUySVhMM0RSaTlzVEhmSWdY?=
 =?utf-8?B?aFhKOEFCSmxmMDBFVXE1NzhBSDJVY0t4eEkzeWtkV3RvSXJaMGZ6cTRuOGdO?=
 =?utf-8?B?UjE4TTIreGZ3N1ptNDNMWk9RTDN4RFM3b3QrYUNoMzJpVE9pVFBHWmswbVJS?=
 =?utf-8?B?TmdSOHRYNnVNOEI5ajdHSE9zTUpZbmo3cm01Q2JLQlVNbU5ZU1d3a2ZRdWU5?=
 =?utf-8?B?SFhtTnJtWnE1Nzg5ZmRMcXh5Q2pGbi91RlZoM2NuaVZwVGw2MHJxQXcxa1pa?=
 =?utf-8?B?UVVrQmhZWGxISmUrR2N1M1Q1R0paK1JvOUhpdTFFOWlmU0I5T2xHcEZmZnc3?=
 =?utf-8?B?NlZxMURVNmV0UStYZVlUeVJ4TlVYRHB5eE5jQ3JnYU5YbEd2N1lXcDIvL0lt?=
 =?utf-8?B?Z3lneFdWcTFOZTdXaStXSC96cEpCZTAwT2x2R1FpWklTWENiR2hMcU1DOHZU?=
 =?utf-8?B?bmZIbk5xWWpCUnpFU2xwSjMzMGNFU2dkOG9TckR6RUQ3eWpsV25NMnVVU1h2?=
 =?utf-8?B?RWUxdm14ckNhblVWSDJPR3l1eStVTEdRT1FuMG94UERNWlkrUElGbUd3NEhC?=
 =?utf-8?B?WUV4QVFlSWg5cW1nOXJEenJXb1I4UjNoY3plY09WWVZBNEp1ZVpzdUs2eUhG?=
 =?utf-8?B?QlpmTlNlbTJqVWpJRUttcGEwSmdkWnlSRGtWQXdiSmlmdWlKbXVZUzI1UmVq?=
 =?utf-8?B?ZFBWQjlKK0tVK0xnVXlNT2RLTDJIRnBGUXRFenhuMDUwLzZXR0NSTFc5bTNx?=
 =?utf-8?B?Q1B1UE03czBrekgwcXQrT2tnSDl2WURiVkJyTjNIb2xmRENWMjhZUHhuenQz?=
 =?utf-8?B?NTl3NThLVDRVYTNHOFNmRmlhMEkxNnY1TzZxaWpNY0xaRkZacVpQRWdBRlEy?=
 =?utf-8?B?UGRyVDRpdWYxNWRYWEk1cjBtb2RFemdtYnd1TjlWOGJOM1kyY3dJSmNhM1l5?=
 =?utf-8?B?R292b0NNZW9vaFFCSjMvM3I0dmk2TDliNmpCUVhJeXo2V2JBZlovdnI0M1Q3?=
 =?utf-8?B?QkdKWkNqWjk0UGJ3eUlYYVp2bTZ6U3RocVN2VG1IcVpqbys4aVdndCtrOWRq?=
 =?utf-8?B?d1BYdW44ZDFXMGprTDVoNWRVTE03bzJ3aFBpa1hWWFNxZVJ5NFkrV3gyZkRC?=
 =?utf-8?B?bENhZmVLTnlQT0ZQd0txbkxFTkdOdUNNdVZFMWg1S28wMytqQ3Nkdno0R0Vk?=
 =?utf-8?B?djdkdzZKMGVpNnlrUi9Sb2VhOGZ3Y01rMjFnekVHMmFGbzRIQ3NQQXdLRHRK?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3440.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a511e3ec-ce68-48bb-1dbb-08daa620dd66
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 15:55:30.9498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XJYNUeKv6wfTQNrDZHfk/GGzHkr6/hq7gQYTiwz5e2j53Fkj/DST6uZpK430U5gtjUCZrGecaxsFaBPlAJl6tMqhnx26o8LdNi5Z7aTCFtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB2023
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

PiA+IEkgZm91bmQgaXQgdmVyeSBoZWxwZnVsIGluIHZlcmlmeWluZyB0aGF0IHRoZSBBcHBlbmRp
eCB0YWJsZSB3YXMNCj4gPiBjb3JyZWN0LCBhbmQgcHJvdmlkaW5nIGEgY29ycmVsYXRpb24gdG8g
dGhlIHRleHQgaGVyZSB0aGF0IHNob3dzIHRoZQ0KPiA+IGNvbnN0cnVjdGlvbiBvZiB0aGUgdmFs
dWUuICBTbyBJJ2QgbGlrZSB0byBrZWVwIHRoZW0uDQo+IA0KPiBJIHRoaW5rIHRoYXQgbWVhbnMg
dGhhdCB0aGUgYXBwZW5kaXggdGFibGUgc2hvdWxkbid0IGJlIHRoZXJlIGVpdGhlci4NCj4gSSdk
IGxpa2UgdG8gYXZvaWQgYm90aC4NCg0KSSd2ZSBoZWFyZCBmcm9tIG11bHRpcGxlIHBlb3BsZSB3
aXRoIGRpZmZlcmVudCBhZmZpbGlhdGlvbnMgdGhhdCB0aGUgYXBwZW5kaXgNCmlzIHRoZSBtb3N0
IHVzZWZ1bCBwYXJ0IG9mIHRoZSBkb2N1bWVudCwgYW5kIHdoYXQgdGhleSB3YW50ZWQgdG8gc2Vl
DQphZGRlZC4gIFNvIEkgYWRkZWQgYnkgcG9wdWxhciByZXF1ZXN0Lg0KDQpEYXZlDQoNCg==
