Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932C85C0D11
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 19:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiIURxK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Sep 2022 13:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiIURxJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Sep 2022 13:53:09 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020019.outbound.protection.outlook.com [52.101.61.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A88E9E137
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 10:53:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQurV21RxRdgs77r6V/Sdf1XRfDL4SnroDD1jYazOctboWD4DeHbfJuYjl++KWjXI4AP/YUx72lI+/nk6VXX1UGP0uOPAPMyIYY56a0zbc4PeMBtmkvMiN5ECRRTs8bxp2DTNx2V9ZrygUOOe4QhkQWeytk8unYRKoeMNsY0rytMX+2oabGmcCkCGs37St+RSIYb5O0TjBYHvOAMhtgQvHvpFUu8hqpLIIlWCzZmhMv8b16f5i+VzTGo/D+6Loieq4ChMKnuec2jnc2Enthf0zdDYSBTCG7togrR7POG96bKog9Chz7RTzwcmkuPvGsaTuSrVNiTIReUk8WL2ZiFhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8CsbjL7YtlzVQre5irT1GWY29p0a/2KF+qT638JkLg=;
 b=nwE4bQ7qY4DFZ1hqnyTKqCjCxMWSzTqen/xcfe2gk1zbFnIt9kFIULzi+M7CJejXcJa+KVblyadrnaUxps7QNysFLHK+BJkGX80cfZ5Ydx5KnSzgSylee4/jgzgvAylV4Kq62f0wT3OIywRfC9JZ+Trsav356NWUHfsxvfAeFMtTx8N69s6zzWy3afI/AGWp5emH7g1uqi8QONb08S4xYISXlACkzmwlcfRx8/8Faz+kSepX0UNeDOI7rF38n99rrMXJOtOFFNjUt3SGFTDOlKMjb8P6vwyssgfg+Jhy1a1D6zJYS3jlJI4DYEpokPOCTpwfdiwsZmY07TtMhg5//Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8CsbjL7YtlzVQre5irT1GWY29p0a/2KF+qT638JkLg=;
 b=Nn+GzA1maq3ZVW1ZN/9rmdX9MUguFglv2TD8zxhY5Af7zhBsqT7T5vA4YOKfQ/Tz3pN3MAoQRHgnuKxp78x/JNr3mPYm4uHCOPu+otSjvfiKaLkFfF8EU+wbhlRXyVaU4SyXcoCx34W0UZnjqOqy1maG11Yb4LoA5HE3jXuIP+k=
Received: from DM4PR21MB3440.namprd21.prod.outlook.com (2603:10b6:8:ad::14) by
 DM4PR21MB3273.namprd21.prod.outlook.com (2603:10b6:8:69::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.4; Wed, 21 Sep 2022 17:53:07 +0000
Received: from DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::5872:7dd2:2a86:c111]) by DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::5872:7dd2:2a86:c111%9]) with mapi id 15.20.5676.007; Wed, 21 Sep 2022
 17:53:07 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf <bpf@vger.kernel.org>
Subject: RE: FW: ebpf-docs: draft of ISA doc updates in progress
Thread-Topic: FW: ebpf-docs: draft of ISA doc updates in progress
Thread-Index: AdjEi0anVH25Go4YTCyzpO9wKsLa4gCvUITgAC54c4ABEdxTAAA2fB1gAAme1QAAJh+7wA==
Date:   Wed, 21 Sep 2022 17:53:07 +0000
Message-ID: <DM4PR21MB34409F03EA1385E1883558E7A34F9@DM4PR21MB3440.namprd21.prod.outlook.com>
References: <CY5PR21MB377000AC95B475C47B702293A3439@CY5PR21MB3770.namprd21.prod.outlook.com>
 <DM4PR21MB34401314FC9285A9F5A338E0A3479@DM4PR21MB3440.namprd21.prod.outlook.com>
 <YyFzO205ZZPieCav@syu-laptop> <YyihFIOt6xGWrXdC@infradead.org>
 <DM4PR21MB344020798F08A9D967E70719A34C9@DM4PR21MB3440.namprd21.prod.outlook.com>
 <CAADnVQ+bRxDkSWnx27KRm4mC3QrmPO+UyiA5VrjHNMQqeVYcNA@mail.gmail.com>
In-Reply-To: <CAADnVQ+bRxDkSWnx27KRm4mC3QrmPO+UyiA5VrjHNMQqeVYcNA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=37bda40d-da7d-4ac1-a4af-51a05c2c0418;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-09-21T17:51:28Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3440:EE_|DM4PR21MB3273:EE_
x-ms-office365-filtering-correlation-id: 02b3311d-eb3a-4bf7-fd07-08da9bfa23e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OGiNtqhequFS0fSVq0epyylyBb+x2o1QOps3wVpfVrN78GOMtvlnnNgRsKRnRNiu9MwIxbZY27iNBmTkppR1YbQsahYUfMwOzDxoDbA7HkYGwLU7/CgSzfz3T7L9mLsReok/dNkcazx+CEkwwhF/4zXj7albBih5BWqcjHs97Z8VnMv88ptJ0/Q2uTzsSafufoCjrWMaji+0EOKO3gjCfEmcbmQmsZE06nkXaQqr/STq2ZHKfg0lQPawFZfehcurqYBNnGNWvRx6BG9MTmfFLuOJ9DVpdRguO92KWyeyKIBzEnvfesLL3+sxL9MLWi1xhCzHY5Pf+UVsjJkQ28eoOISGyfIMtyqhsX7ZfkOnC1Cr6pdUpKyVRBmEW5U86biSLgcO32Gy825M+Amq1yCGxze/QqZBfMOMBbumxEuJLdXedCUq5Yk6RfkT9qazP93/ZyCwmTOxPDr7/K82L5Y1juNwj+ZD4EU0oKkXkFyh1/euvQGT6gg/AiQAa5yRGLExKymz8gLVHWyOBD63OSOym4sOlI0tI2bHZYYJjONQMCMrPAPskkPItST7NmSaQM7aaDZN4+57JjNbQA0/zqfkw/+4Sn3S5jzjqLNOqa032XDhiNlOTpibGsEhZXQSdNbHnqIh7et+ZsnqHxFrp45YAdVfTBl53uJo6dPxKXf8uvSReeU+5RcoDwbUu6/b1y1YyXDowZiHMxJDcoC66fLllRbY6n29N26wxg23VsgDRNr5f/VD//uYGvWKPsjwa0EGaPq1NBuj07GgbQZltuXongrGcR56heaFiu/LiaSMRXO1ENqn3P77mz/muxJHFVUq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3440.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199015)(26005)(316002)(6916009)(82960400001)(82950400001)(54906003)(33656002)(478600001)(7696005)(6506007)(15650500001)(2906002)(9686003)(71200400001)(10290500003)(8936002)(38070700005)(4744005)(8990500004)(52536014)(66946007)(186003)(5660300002)(83380400001)(55016003)(38100700002)(41300700001)(66476007)(66556008)(4326008)(8676002)(76116006)(66446008)(64756008)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Uit0U2hkMXNPU3drYzh3OGVKVDRSTDFWRytrOWE0bmtLeUg3Z2NOT3Fyc0Uy?=
 =?utf-8?B?d0FrQTlCN2JqYXNMTUFwS3d4aisrYWgrZEpvSi9wS0dlNm5HSmpnYnpsNGZp?=
 =?utf-8?B?K1lyZGxFM2NpSGpVNklHWlNVbXZaL3Q1QjRyU1c1c29tOW5SK2oxbFFDVDdE?=
 =?utf-8?B?Ky9abzBTSjgzVldJT3ZSeXQzeC9INXE0cm5HMG1HcDVPVG1zcFI4UkRPeWRx?=
 =?utf-8?B?K2VCTGJhU2dqUUg1eE14NEYzcFFYMndiZ2x4aFVtQi9zSzdMT1FxenNMR2Y4?=
 =?utf-8?B?VmthYVFDV0FhQzlYbTRLdnVEcWhhSVR5SVh2UkNyRmFWcVphUHMvS3Y0NC9y?=
 =?utf-8?B?RHVVN2Q1YktUSWRPM2RzWW5XaUc0c1FrRTBKVUpJN0w4WUFsNkppaTBYTHZw?=
 =?utf-8?B?RjRiMkZ5RFFxUDN4bWZrRUszaHFNanJVZk1ZczhhcDMrOGoyU0UxODFSTUhr?=
 =?utf-8?B?ZVdvUnBtckdmZWtLN2t5dm5FQXI0VmJIWFdjUTJXQytsTmNaL2gzbVZDMlBF?=
 =?utf-8?B?aDJKVFZIQzh0Y0tLeTdvUkU2MlZtTWtYVk85OVQ1YVBOcVpkaURiSlNMS0Zh?=
 =?utf-8?B?eEl1S09RZ09sVmRkQTJTb2xzQXQ2MFk1dk53ZENvcytOVTEwTkhoUnU4eVIy?=
 =?utf-8?B?cnJONFR6anVmWGhZc2M1WnJodWkwR0dwSTFCclM3eUNQV0F0NkVkRFJvaElw?=
 =?utf-8?B?MGJvZHd5MWtFSDlkTzRMUGhBUmdrcm5GSHJheHgxUlFSQW9FeXZmazcrdTRI?=
 =?utf-8?B?ZmRUakFDbnM0Sk8vRnFKcGFqRHJ1Q2tHS2pQSVBrME56YUlGSzNJWkJXQUJX?=
 =?utf-8?B?a3pFTmM4NEdnblJuNmVPcGU1ck9zeGdhWWZlMUVXV3Z0cnFwSlh1SFZYL09E?=
 =?utf-8?B?aS9GdFVqYmN5Tk50N2pJRlZBMEozWVdCVU1OUU5GTGg3bkVyZExGUVkzMDNC?=
 =?utf-8?B?Nzdjby8yOFpZRStqYnJlTWlKbHFQcVZsZEZna0dCR24vdEF0dmMrNmNkTkVa?=
 =?utf-8?B?dHZCNlY5NnptL1QwcktLbk5hYVhIbTdEQ3BXR0k5T1RycENmTE5uUXM2RTF0?=
 =?utf-8?B?M0o3YSthSGtmdEFhamRpenlkZUU1dFNyQVB3WGtHK0NrcDg3YnFpenhXb0t4?=
 =?utf-8?B?cDlzbG4rZHBHcDc3cjloSFZxNHU3d0EvOW9TOTJzdFFLeTVSc1lxUHVNYXlz?=
 =?utf-8?B?WXZVd2lhMUZiU0M5c1NVaWxXTXgrVW45MlpOUjJFK1phOGRnNDhpSEYwVVZz?=
 =?utf-8?B?M2ZQZTlHTkxKeGxTREtNWFZkWEQ3L2p5Q3FsUzVSdXN0K1h2QkllNzgxQlJ6?=
 =?utf-8?B?bk5Ic2h1Q2VHUXFJd1cwc2hFbG95ZHh5WWFMN1VNMmpxdTFNN0N2VFgxTjZL?=
 =?utf-8?B?dVZjUjlDMDdnVy9zdmM4aG5vN21VZ1RSbWo1WHJsNGpaV05HNTZoemtSRTcw?=
 =?utf-8?B?a1QyN0doZjZJUE5GOFNSc0tydUZqYlZnQmM2ektDeVVGRnN6d21HVjhCQ0ov?=
 =?utf-8?B?K3lhSGpBWWtDb2ZNYUhHaXFxZSt2NEcwb1B4MEpiTE1xeDhJdXJWZVpFSjY1?=
 =?utf-8?B?UHZhRHFRMDdtSDFpeXBvWTJra0kvWlpIWDRScWxYeTNwMkhnRU10U0UxUE9z?=
 =?utf-8?B?VDRaRWFTNXY4OE9iZlpxeWh0dFNGeElWaEdSYkJxZ3E2U0NQY3NIQk1Ma1Zn?=
 =?utf-8?B?SlIrQldQVlR4cElZdExuS0VjTU52V2ZQT01wWFl6VFJTOEhBQ2EvWGJLTXhD?=
 =?utf-8?B?UEFoYzlaRDlhY1lnNzR4ck43L3hDcjl3ek1mRnBRZDNJWWpiN0E4K05vUVox?=
 =?utf-8?B?T2hhYytkeGxTTnFDOURyMWdzNDVVSXZIVGJWaTJSektYQ1h5b1V2SjJmNlFz?=
 =?utf-8?B?elhZYkdIZThrVUhaZ3gwd09CY1hQallHdTBlbGpFQzUxRjJ1cFJwdUl5LzVY?=
 =?utf-8?B?TmllQnY0aEdJcnk3a2NHTEg2ME1BNEMxQ2lVaWxsZTVuUTdJbkxTdE9ranQ2?=
 =?utf-8?B?WGljRyt4eTcySmpSSHJkd1pORVNZb2ZTZkRXOWRzR1Z1K1haT0VhRWFORUtZ?=
 =?utf-8?B?NFBJOS9VcHM2SlQwK01BMkRhcHJudGJYWk15YzhYSVArcS9qYUxka1JaN3Zr?=
 =?utf-8?B?R0ZwVmVWSUQ3djRMK1RlOFZnV2Fpdnl1WXQrS3JyTHNKdGdjVysvQ1Z3UWdB?=
 =?utf-8?B?elE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3440.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b3311d-eb3a-4bf7-fd07-08da9bfa23e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 17:53:07.2388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dXcf3EBqxUrfzSQjiCuZ16pBOV5KPcPSLyACI4i+tvyccnL4ga8zLyFCnr7CnnZVBnIkLflZhsZsMeuQuCe1IFgcdxVwPwvapvzwv9rZahI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3273
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

QWxleGVpIHdyb3RlOg0KPiA+IEJhc2VkIG9uIHRoZSBkaXNjdXNzaW9uIGF0IExQQywgYW5kIHRo
ZSBmYWN0IHRoYXQgb2xkZXINCj4gPiBpbXBsZW1lbnRhdGlvbnMsIGFzIHdlbGwgYXMgdUJQRiBh
bmQgcmJwZiBzdGlsbCB0ZXJtaW5hdGUgdGhlIHByb2dyYW0sDQo+ID4gSSd2ZSBhZGRlZCB0aGlz
IHRleHQgdG8gcGVybWl0IGJvdGggYmVoYXZpb3JzOg0KPiANCj4gVGhhdCdzIG5vdCByaWdodC4g
dWJwZiBhbmQgcmJwZiBhcmUgYnJva2VuLg0KPiBXZSBzaG91bGRuJ3QgYmUgYWRkaW5nIGRlc2Ny
aXB0aW9ucyBvZiBicm9rZW4gaW1wbGVtZW50YXRpb25zIHRvIHRoZQ0KPiBzdGFuZGFyZC4NCj4g
VGhlcmUgaXMgbm8gd2F5IHRvICdncmFjZWZ1bGx5IGFib3J0JyBpbiBlQlBGLg0KDQpKdXN0IGhh
ZCBhIGRpc2N1c3Npb24gd2l0aCBvbmUgb2YgdGhlIHVicGYgbWFpbnRhaW5lcnMgKEFsYW4sIHdo
byB3YXMNCmluIHRoZSBvZmZpY2UtaG91cnMtc2xvdCBzdGFuZGFyZGl6YXRpb24gbWVldGluZykg
d2hvIGFncmVlZCB0aGF0IHVicGYNCnNob3VsZCBiZSBmaXhlZCwgc28gd2lsbCB1cGRhdGUgdG8g
cmVtb3ZlIHRoYXQuDQoNCkRhdmUNCg==
