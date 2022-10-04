Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E785F47C9
	for <lists+bpf@lfdr.de>; Tue,  4 Oct 2022 18:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJDQlu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 12:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiJDQlt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 12:41:49 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11023027.outbound.protection.outlook.com [52.101.64.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D2C5EDE3
        for <bpf@vger.kernel.org>; Tue,  4 Oct 2022 09:41:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6aA9fg8nrlMMj2wdjwtW2FbpMh2iH5rmYIrwli/JAA9NApwXcSVR+sgYGxFrylvGLKnlvduGzc3P6ci6JbOk1HDmkNjDIn1DoGCLkHk/G4DYbMB3Housy9nOmmV9PBxh4U1ITGchTf6MP9niKIsWM589GTD4+FvFUG9a8m3C0lY5quKzZaopFhkSJ2mkIX+RuJ7EvIrRq4MfjODTwmYfCoiyszeLP8Gpf64UsVgHS9KBAPbO7g3QfJsO5/5NXhh4e5f9TmRKtWEZ3pDW/wFSnOjDLy7WGA6F7VePha+lYVmCjjXAoXqex0bBguctE7hMdDXf8bkXXr6xKDuZ7Z/sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iqr0m9JXoRpKpOpcBELiKjzXDWaJtYlr192QOqLw/Y8=;
 b=JlssOqpJbwlz5Fd1tB4Hr1W3EaZZLO12o9WDWeGyOs3mzXlHsQAEiGn6ZPtDDH+shJzyvb1f4fkXYU8tUs5KBHCh1zORbXOfkEH8T/Monexg1HeEjvIekqZAF1CvTCmmW1XUU7IMKSxcctoF276e1qtKtYN9MnsEJ1pYMr1zN9e76onw+ZZstz/Dr1reDEGda7iipXXuFyzOXKardo8PfY1zR07/fuKGUWAOdKXf9EDn8AzvTvcrwcC38M2oLcXmh23mQ/+JumQeEsfkkExlrFD4D2OaD0MyhtdltL+ZNxG3BLMwyrlrjDxlf8RBH/Yg4fD+c9kxK+3OhkzYshFuOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iqr0m9JXoRpKpOpcBELiKjzXDWaJtYlr192QOqLw/Y8=;
 b=Rli8picfSBkXmXHbuo6H44gs6SvHL5weUjRsNhrX+Wi3n1tFEJClmHD0728aqZVE5pTUM4cnsFMCAgzy6zcTWNDb2CRyyE1wQJ/tFU+b76nr1DSs48aYjCyPfVmi3P3SsPPEszKN1Wu+HWcV9vr9LDSh7LdeFt9qPHMxW0QKM5E=
Received: from DM4PR21MB3440.namprd21.prod.outlook.com (2603:10b6:8:ad::14) by
 MN2PR21MB1392.namprd21.prod.outlook.com (2603:10b6:208:20a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.7; Tue, 4 Oct
 2022 16:41:46 +0000
Received: from DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::c76c:9386:3651:999d]) by DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::c76c:9386:3651:999d%3]) with mapi id 15.20.5723.008; Tue, 4 Oct 2022
 16:41:46 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH 11/15] ebpf-docs: Improve English readability
Thread-Topic: [PATCH 11/15] ebpf-docs: Improve English readability
Thread-Index: AQHY0qNqv++jE8+E60q227lL8nNlGa34j0YAgAXGAWCAABQHAIAABHbQgAAAhPCAAAa7AIAABSag
Date:   Tue, 4 Oct 2022 16:41:46 +0000
Message-ID: <DM4PR21MB3440D8E8BB2A81C63756AAD6A35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
 <20220927185958.14995-11-dthaler1968@googlemail.com>
 <20220930221624.mqjrzmdxc6etkadm@macbook-pro-4.dhcp.thefacebook.com>
 <DM4PR21MB3440664B3010ECDDCF9731D1A35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
 <CAADnVQJQvdN2Dm7pwMno59EhMB6XT35RLMY4+w_xhauJ0sdtAQ@mail.gmail.com>
 <DM4PR21MB3440DF39304851D5F6108039A35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
 <DM4PR21MB3440986863D2893E382BDD02A35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
 <CAADnVQ+Vrm6g7FZ-PaqLkGfVzN+z8HBTq6Q3MmvR88J6H8cHPw@mail.gmail.com>
In-Reply-To: <CAADnVQ+Vrm6g7FZ-PaqLkGfVzN+z8HBTq6Q3MmvR88J6H8cHPw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7e384ac4-ceb8-45af-b92a-b38ac280eec0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-10-04T16:38:23Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3440:EE_|MN2PR21MB1392:EE_
x-ms-office365-filtering-correlation-id: 556b0c87-87b3-4bda-f5bc-08daa62753b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u35J9LplLHFICb9z+GpiIWqo3t9EE/hmxh8TfGe1ozXC2Bapd33r7ohmZI4icoono6qpukfT5pLFOWTAuxMg9IzgN63s/W71mO0RUG1A6RyefyZhbI0AoZG10/TbLO4U4k3rbpr15bWlXUXS2ntzVmHuthk38S4veplT+CkIBvEO6uoxaIHZAbSYv1pTZRbRBF82Fk17n6R6atQDO/AX+cLLvMyKYB5yd+8ge7Mp0+2G5stUODnRPv0t6JwkfaddP4FY5QLmsS44pxWdXw5a4GQJQv5NMJVm8kOKidNHKQlc0bxfKur46WGapse5CyuT6JLc1X7L5WRC9+UWX4dQlv+sHxXiXmqfHGYAJjVO453Oqr1yjCcgC0+/83fZ4IZSacgR1jqB10tEzD6rJyfbPJV2q9VBtOAeGL0j2PfkgsKR2Nr4j7+XRFhBsg7FXlEeMXzCOHAdNTiauoBGDjprU/OIxnbBROOyHvHg1w3zV0cay4TtBtRhrkL/b7OOgsnHeU6RfTDY/ZBlkb/Hb0pC7QvJWH++hPcWDuq5wmNFyRt+angQjGmJRuFsoEtuZPTZf4iSC620kppeOZERDZxWb9G0VQtij9hoOU9UeUyEtDjMtR+wjB4iTdiLrBjWkzCsfuW+Xn7ElcnNy7lugPqUPhiKc3qNo+Ld1/NshoS0U0ieZlL6cboYPWoZJZRbI9l1TuFS69TUt2lkyJqMGLSTyPtuIfM00J2FOYBNOR+GpefuPAAvVbI9SbB6A93GQjJEYNeOlG5ooQmsATYp4kP547wZXsiw1zhyLTpaU29kgD9SKB/OO4s8iVQHineGuYeo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3440.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(451199015)(86362001)(478600001)(71200400001)(10290500003)(8990500004)(64756008)(4326008)(66556008)(26005)(8936002)(66446008)(8676002)(52536014)(316002)(6506007)(5660300002)(41300700001)(6916009)(66946007)(76116006)(53546011)(7696005)(186003)(122000001)(55016003)(2906002)(38100700002)(33656002)(83380400001)(9686003)(82950400001)(82960400001)(66476007)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTVQbHJCb1hpZHZUS21ESkRTRm9rUCtmaFJXaEcycG1nTUhuQnhuZVJMWWxw?=
 =?utf-8?B?ZWk2S3Y0Mlg2cGM0S21MUnhaTFhTL2VUUThoR251QzNoUmMvY3FCajFEMkNU?=
 =?utf-8?B?dUZST29Sank0MENPdk9obEdGUGRQWWc3emRtRkdNSWVqclIybW1XZEo3OUpM?=
 =?utf-8?B?YW9JL3g1SlB5dHdNeVBVSW9IUUJIbXhWNzVCUit0QU41YUEweUgzaTlYN0NL?=
 =?utf-8?B?UnFJS0d4elpaYy9USitJb2s1aCtZUklpU2FVSll4b3hOanBBN1VjYzU4Rjlj?=
 =?utf-8?B?YXVyR1F1R1RxeWJDRW5sUkdPTDhLNUp1bmxtMU14VzhZSlJ3bWdYSjk1clBV?=
 =?utf-8?B?SkhsdW4zc216SlQ5T3l6MHlKTXNiRUZsOHhqTkJGVzZBYWM0TXJIODVkTDdm?=
 =?utf-8?B?eWd0N0RFdklkbmJzU01qMEs2U2V3WStmRjVUREJKV2VFWjk2ODdGR1A3Q1R0?=
 =?utf-8?B?VEFvRmRwS1BNdjJvYllpeXViUXFZcjNaWERuTlpXUloyMWdSRlhqa1d5OFdI?=
 =?utf-8?B?WU5PYTcwbTBVSGp3aG8xOWp6NHZyeGxTd0NpaFNiNEpjL0lWMjRsQzBuRDMr?=
 =?utf-8?B?NGxPdzZDdW95blAyeDVpLzEyS1RwazRKRUpSRjNHN3hYbk1BWmZhUHpjVysr?=
 =?utf-8?B?S0VrY3crdlgvc0JtK29IRDR4cXlmdTBudjFhblMvWkNPb0RFeW5rakloenB0?=
 =?utf-8?B?VWkrRWdYTm1JOU5GODJwaEtnWGVhU2hzaWREdXpkdkdQTzJHVnVOWGdUbmZm?=
 =?utf-8?B?ZEpQWnF3TFA5OUxWRUgwdnJCS3VtZlFmazRsQW85NTFpbXBCbVptYlU3VVRn?=
 =?utf-8?B?RFkyVjh1NGZwTkloVWh6V0pBaEFrZEpVYzB1eWtFVmdNRUpMckZETXBaU0I1?=
 =?utf-8?B?dlhTTmR6alBMVXhTelBXSk80bktWMDkzUkZjRTFxMlRzcUFhMXg5RmZFTXNs?=
 =?utf-8?B?M3Q5Y2RsRlFJdVpvNSs2UG9OSGc3N2d0Wi8xdUR6NWV2UW9OYlV1S0R3RFRy?=
 =?utf-8?B?dDY1SUhrZG9Wem0wQXFuTDJGczhIWmpxRm9lSjR1ekpyNFFuUkt4ZGVSNitV?=
 =?utf-8?B?aXcya2hLSXVtYW1ZMGJHOGNXYnZnY2FpT1lDL2VIQ2Z2UDBMa1hYTWM5b1h5?=
 =?utf-8?B?ZFkrLzFUaHVnMWsvMWl4cjUzaGRyMjJHUktoaGFWM01hL1UzV21yUEkrMnVv?=
 =?utf-8?B?ZHhwSy9iUk5tM1RVRTZkSnV4Wld4SjdqTE1oNTJqQXVFbHVqaWFIbmY3V1Mw?=
 =?utf-8?B?dmRoTXc0S3JybndFRGllaWZJN3dYMDFzTy9BVW9HbXZUYnNBUUQzTFJlZzZa?=
 =?utf-8?B?NStCcGdsZVJncC95M2pRM0ZvSlFJOE82VjB5MkZCdWxIOWJuTGllOWtaa0dp?=
 =?utf-8?B?b2QyaFU1L3NqYU43YmFBbm40c1l3V2pWTWhFeHg0c1hZMHp1QjZEczJnRUVs?=
 =?utf-8?B?bm9qUEJRV1NGUUQ4ME14VFB6UTdNd3RscDJPVzA4eVkvcFNzRHhZT0d1SnM2?=
 =?utf-8?B?ckNDaDE5Wll2NXA3VlhaSmlUdGVBZHJEVFBEL2FnM0JZa3RCVnVLVlFhV01S?=
 =?utf-8?B?Z3lsWERpZ1hocitRMzRwNHptMmN4L0pkTjhtVkRiSEpHd0NaVVhsSnFDNy8x?=
 =?utf-8?B?dDVFcmYyelpSL05JVkdFYVYrK1dPYk9haURGOGQ1SXZUZUxDRDdiSGJYV1ZS?=
 =?utf-8?B?OXF3YXpwaUk0WVhxeWl2Y2djbno0STJQdk53SjJyYVJXOFArZ2w4cERuY3lj?=
 =?utf-8?B?Yk43SUZDbHgyOWFxa2RxWk04eUgyMkl1b1MvL2NmOUJsb05OODBuYk0zdUsz?=
 =?utf-8?B?Z1RES2YyeDAxekM2TXhERUUzWTQ1bjcvYWJlSlNTR0ZwSG1RL1NuMEZMd29Q?=
 =?utf-8?B?MzBlNzhUTnlXVWFzeUViNGh2c0dERmd2dWsvVTBkKzFHMEgzU3pPNDJZU1N5?=
 =?utf-8?B?UFVUL1ZGU2k0UW1SRFVuZTdodEJNUDhkb3A0VUFucTlUQW5FekdPVjdudlJj?=
 =?utf-8?B?clNZcDRISFdpVkxWZUVobmQvaEx6aTBCeDVFdGFvWUczMURZRXRIOERoUlZ3?=
 =?utf-8?B?NTBLU0t3UHZYQ01JRm9kUnFQam5EeUFPMitGNVpmcFRjSE81L3pRN0RyQWRo?=
 =?utf-8?B?RVZPTkE1SG1JdXZLYWhpMVhTdE10Qk5jUktSaGRxTlhtbEI1ZFBGYWJFM05O?=
 =?utf-8?B?d3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3440.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 556b0c87-87b3-4bda-f5bc-08daa62753b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 16:41:46.4156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sWPnCTcrV+hU5RBhrR9iYk1748Mo8Q9WzXjiVY9B0y9+mcBuETY+53g/7J1B6ZUJWcJF4AEzI67slX/mnixPb77GjPWP0py1XmCQWQC6gNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1392
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4ZWkgU3Rhcm92b2l0b3Yg
PGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIg
NCwgMjAyMiA5OjIwIEFNDQo+IFRvOiBEYXZlIFRoYWxlciA8ZHRoYWxlckBtaWNyb3NvZnQuY29t
Pg0KPiBDYzogYnBmQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDExLzE1
XSBlYnBmLWRvY3M6IEltcHJvdmUgRW5nbGlzaCByZWFkYWJpbGl0eQ0KPiANCj4gT24gVHVlLCBP
Y3QgNCwgMjAyMiBhdCA4OjU2IEFNIERhdmUgVGhhbGVyIDxkdGhhbGVyQG1pY3Jvc29mdC5jb20+
DQo+IHdyb3RlOg0KPiA+DQo+ID4gQWxzbyB3b3J0aCBub3RpbmcgdGhhdCBRdWVudGluIGhhcyBh
IHNjcmlwdCB0aGF0IEkgYmVsaWV2ZSBwYXJzZXMgdGhlDQo+ID4gYXBwZW5kaXggYW5kIHVzZXMg
aXQgdG8gZ2VuZXJhdGUgYSB2YWxpZGF0b3IgZm9yIGVicGYgcHJvZ3JhbXMuDQo+ID4gKFdoaWNo
IGFsc28gaGVscHMgdmFsaWRhdGUgdGhlIGFwcGVuZGl4KS4NCj4gDQo+IFRoZSBsYXN0IHRoaW5n
IEkgd2FudCB0byBzZWUgaXMgYSBkb2N1bWVudCBiZWNvbWluZyBhIGRlc2NyaXB0aW9uIG9mIHRo
ZQ0KPiBjb2RlLg0KPiBXZSd2ZSBhbHdheXMgYmVlbiBkb2luZyBpdCB0aGUgb3RoZXIgd2F5IGFy
b3VuZC4NCj4gVGhlIGRvY3VtZW50YXRpb24gY2FuIGxpdmUgbmV4dCB0byB0aGUgY29kZSBhbmQg
ZG9jcyBhdXRvbWF0aWNhbGx5DQo+IGdlbmVyYXRlZCBmcm9tIC5oIG9yIC5jIGZpbGVzLg0KPiBE
b2luZyB0aGUgb3RoZXIgd2F5IGFyb3VuZCBzb29uZXIgb3IgbGF0ZXIgd2lsbCBiZSBhIGRpc2Fz
dGVyLg0KPiBJbWFnaW5lIGEgdHlwbyBpbiBpbnN0cnVjdGlvbi1zZXQucnN0Lg0KPiBXaGF0IHNo
b3VsZCB3ZSBkbyBuZXh0PyBGaXggYSB0eXBvIGFuZCBzYXksIGxvb2ssIHRoZSBjb2RlIGJlaGF2
ZXMNCj4gZGlmZmVyZW50bHksIHNvIHdlJ3JlIGZpeGluZyB0aGUgZG9jLg0KPiBJZiBzbywgdGhl
cmUgaXMgY2xvc2UgdG8gemVybyByZWFzb24gdG8gYWRkIGhleCB0byB0aGUgZG9jLCBzaW5jZSBp
dCdzIG5vdCBhbg0KPiBhdXRob3JpdGF0aXZlIGFuc3dlci4NCj4gT24gdGhlIG90aGVyIGhhbmQg
aWYgaW5zdHJ1Y3Rpb24tc2V0LnJzdCBpcyB0aGUgc291cmNlIG9mIHRoZSB0cnV0aCB0aGVuIHRo
ZQ0KPiBjb2RlIHdvdWxkIGhhdmUgdG8gY2hhbmdlLCB3aGljaCB3ZSBvYnZpb3VzbHkgY2Fubm90
IGRvLiBTbyBsZXQncyBub3QgZ2V0IHVzDQo+IGludG8gdGhlIGNvcm5lciB3aXRoIHN1Y2ggdGFi
bGVzLg0KDQpUaGUgcG9pbnQgb2YgYSBzdGFuZGFyZCBpcyB0byBiZSBhIHNvdXJjZSBvZiB0cnV0
aC4gIElmIGFub3RoZXIgaW1wbGVtZW50YXRpb24NCih1YnBmLCBoYnBmLCBldGMuKSBkb2Vzbid0
IG1hdGNoIHRoZSBzcGVjLCB0aGVuIHRoZSBjb2RlIHdvdWxkIGhhdmUgdG8gY2hhbmdlLg0KU3Vj
aCB0YWJsZXMgYXJlIHNlZW4gYXMgaW52YWx1YWJsZSBmb3IgZGV0ZXJtaW5pbmcgY29ycmVjdG5l
c3Mgb2Ygb3RoZXINCmltcGxlbWVudGF0aW9ucy4gICBTbyB0aGUgZmVlZGJhY2sgaXMgdGhhdCBp
dCdzIGltcG9ydGFudCB0byBoYXZlIHN1Y2ggaWYgd2UNCndhbnQgZXZlcnlvbmUgZWxzZSB0byBk
byB0aGUgcmlnaHQgdGhpbmcuDQoNCj4gVGhlc2UgcGVvcGxlIHNob3VsZCBzcGVhayB1cCB0aGVu
Lg0KDQpJIGFncmVlLg0KDQpEYXZlDQo=
