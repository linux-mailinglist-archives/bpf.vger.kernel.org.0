Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525C4622882
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 11:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiKIKab (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 05:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKIKaa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 05:30:30 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westcentralusazon11021017.outbound.protection.outlook.com [40.93.199.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025E0263F
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 02:30:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dY5auvZ/MJP3/7MdkzA9YEtLSopzmEzBbYTkX2l9M7ADCKV6kqIAmb5B/q4TWl/auF2xAFdmX+GKYddGGvyOmeWBz3jEFjA56q6z1zR0rn1mI8uYgqNx6TjYsu9H2CpKXdvptExOeOHKMy5lbLZHPepCES7vsrAHrLtrELNm2XhIMCgTy8WuhPRHGm3O2qzoP9HIDiZJf1F6xJqYiQFh/zbd3VPYy2rCB0bRqo4Jjd2Xgqed7JUnTM0PVd0VswGqVhRneKrclZphIdvdjDnPhz9m0k3OpmpwddbeADdi8YRRZ4iID93dX7mxxxX17xiwJDnVSCZeJGiNCxkJPEUQFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQSv3iAD0pn7x42TqsGeNC/arP6SvmH9UTzfRC4ZVmQ=;
 b=bCYDoI0zB7J1COKZpRBViEWl/N7wNRThWXJ6+fcW8lMGnxFbBfFML+rtiMvDu6K1sA8kDFTS9r8+0Wx7vKzzx8OMTkzMOxq9mrtzlDyHZweAjCAndcCLfi5ueq34nIBcagCZIs23W6ZDPUdYabboUyfsEdA/vssbFuB2Cbqk43RE9jzh0TnJ+sYMJoAxDogQkAPBCccqLr//WntYkdeYDkIhzvuFbDWC7sMjRBr/GDUyjJ6zKIkOwkfFrizP4yKLU2EFeuBN+2DUDxj6Wmfhh0D8Sf6rGYKQhY9V8UgTqyfWTme7NuQqcPuqekHzVi221HvhZw0UGU7hniEJ63BYPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQSv3iAD0pn7x42TqsGeNC/arP6SvmH9UTzfRC4ZVmQ=;
 b=icOAv8Or8aDAU3hHBPa3u8BOP0/6gXzsKXShGh9VDYaxE1ZzOh0Dy/SoqlIwgW+GSa/+hN+LIjWXP+mBkbaDVfZ5UAlyy0b1rZZdoAp3pUN3hFugOLMxfohe9p4qrcfOEupYhxBy97Fhf4Nib4SJZaeaxZKyTAHZgBONrk9XZi4=
Received: from DM4PR21MB3440.namprd21.prod.outlook.com (2603:10b6:8:ad::14) by
 MN2PR21MB1408.namprd21.prod.outlook.com (2603:10b6:208:202::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.2; Wed, 9 Nov
 2022 10:30:26 +0000
Received: from DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::a366:bc9c:a902:361d]) by DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::a366:bc9c:a902:361d%6]) with mapi id 15.20.5834.002; Wed, 9 Nov 2022
 10:30:25 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "dthaler1968@googlemail.com" <dthaler1968@googlemail.com>
CC:     bpf <bpf@vger.kernel.org>
Subject: RE: [PATCH 4/4] bpf, docs: Explain helper functions
Thread-Topic: [PATCH 4/4] bpf, docs: Explain helper functions
Thread-Index: AQHY6hHxcBmsz42TBkKLNYpW1ep2jq4151OAgACQxzA=
Date:   Wed, 9 Nov 2022 10:30:25 +0000
Message-ID: <DM4PR21MB3440AA8F71FAD46496CFB84FA33E9@DM4PR21MB3440.namprd21.prod.outlook.com>
References: <20221027143914.1928-1-dthaler1968@googlemail.com>
 <20221027143914.1928-4-dthaler1968@googlemail.com>
 <CAADnVQKmzQJRX9KL06sbtpuQUO4A2Wc4Em+8--Y2Uku9fFPKRg@mail.gmail.com>
In-Reply-To: <CAADnVQKmzQJRX9KL06sbtpuQUO4A2Wc4Em+8--Y2Uku9fFPKRg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d5bfa050-0346-445b-99a0-faeecbef66f7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-09T10:29:17Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3440:EE_|MN2PR21MB1408:EE_
x-ms-office365-filtering-correlation-id: 5905e4dc-bfab-48ca-3786-08dac23d6a5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v5igDEk8z4K6x04AHsA6ZxgIwQwUbzAxJg2Ro8o6uDi/WLhBcJcqhSpXMcq6V0PYJxGi5IHOe3ih7yM/muppz8nCvumeIwNDtOIOsSEHnjYLZcDvsNybC9SQQpY9Ak5vv8FOFm2J6bSvfDI0mEcKqtVlEElc7p9o+mMFfcT7QS4Vm794ytB3H/D3JVy1SEV+5YEYBDhM779uYCxP4aq5Sh+zNz/KIWqzxvtqvkIZpoxETktQy2bWwJhdpQKhnP2ihnZIBJRGpwN3yIdntWpd+mfDFDE5PCsQF+ut9eM5TIMLAHVxz4fhBOzW5Kdw10mkCFXte4r6uAAHZq789+dHZYeGeCXBgzUhaWckVTI5Jz70OnTM6DDzIT0EcAKLZUKZcPQ7/NyBMfz/Z5LbAdb67nWtB02l5xWX6MfJwXSu0kTmAlQ7GNusBMbVlfMlY/wBI6IBFJlZ9oNtuMWsMCN6OCK0eQA2rICa5PfAot72uNDaAyAJIZ73Ltxh9D+0g+VQo3FuklNQ3afpiSoSquwGqnqyelT5F5x6NfestxAUm2RdZBmDUTMsrXuabLPu0gvVEb1AV3I+oOyHlViCLvVtNxedzGK4yL9FPKJYVOhBRNMbJ01yme0JQg9Y/W4zd1oulOK8zauI3AVa3ougeVq6aiucGd+M7bIvcXh4N9sdS/Kq8DseKdf1Wok4hVEDmGIcZyYNhIydzi7naPXosuNHn83WXdhNM3v0EPoxpGh0JP6069Xtn49kIoraJquEPndl+vkWqNHU8tnsKhyCFJ5Sslqf/lN1BSwnDWXygmKiIRYkLjW41xR5iVT9DssTk03N
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3440.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199015)(53546011)(7696005)(186003)(9686003)(38100700002)(83380400001)(122000001)(8990500004)(2906002)(5660300002)(55016003)(6506007)(8936002)(66946007)(64756008)(110136005)(71200400001)(41300700001)(66446008)(478600001)(52536014)(66476007)(8676002)(66556008)(316002)(76116006)(4326008)(82950400001)(38070700005)(10290500003)(86362001)(82960400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZU01L2JOaHlxZmRBS2d6cVBycTUzTENaUHdDMlFFQlp6QWtOVjRsMHoyelM3?=
 =?utf-8?B?Z2owS3psOC9rUFZ3RmtQbml2QTl3NlRtL0hpTTdsbE1TRndGNWpzdVJTaGkx?=
 =?utf-8?B?TTVwSHZJMEdNUG5IcEp0cGlvaGRQTE9iTnZLRy9vZmlndnMxc3JiSjEra01H?=
 =?utf-8?B?a0FnMW5XM1RzV3BxREF0WUxwb2N5ZkJSai9XTkUrbXBTemVZY1BjZGNDdGJt?=
 =?utf-8?B?RWlMK29pQ0ZRSzFFREhoNGgwbiswWGJXclBlN1ZMRTVnbmhRK2lwZzRsbDZ3?=
 =?utf-8?B?N0lqRXRsS3VuNHl2OXBQU1pkT2JvZGZJcHdUTFdhOEFUZ3BBbGtqWEI5ei9Z?=
 =?utf-8?B?RXRyM2J2MzY0Rjk2VThWZHNJZWhCT2VRaVNFNUpSVWhQbncyMU5rR3dPSGYv?=
 =?utf-8?B?NStPWEdCQjFYa0xTcVRoU0E2M3hXNjRKNkdnZEpwWWFOamxDTVh2K3h0WmFP?=
 =?utf-8?B?MHZMdGR1a3hoaWFya1N4KzlvZ3lQdXpSSGRjY2pzVU5OY3JONVRUS1ZxYTVY?=
 =?utf-8?B?WlVJV1dONTNRRW53OFRpWHBSQWQ4U2FwazJia2RiZGZOUTdUKzhBUnkvY0sr?=
 =?utf-8?B?VWJoQlJBWmZZUno2RFR3U0RnSFNEaXRJR1lld05Vc2RiS290ZnZBUHBJMThU?=
 =?utf-8?B?Ykd4bHAzYWY0d0tIWVg4N0pJM2pjMlQ4bVh2amZ1QWk2TFhqR2lhOGpuay80?=
 =?utf-8?B?ODg2OHhFdnAvU3Q5NVdTSEh0YkpqTUJ4SUdmU2plU25sTzErenBaOE8zcHFa?=
 =?utf-8?B?N1JldFBzcXJpTEhlMUFxa0IwWlJ3M1JadEg3ZTRNb3lYSm1xWHlwY2FqN3RV?=
 =?utf-8?B?VW5XQ0hqc0FhYTNoNVJSbVV4VnB4UVo2cjhpZ1QzMGthcE1DQXAwNzNUNkdw?=
 =?utf-8?B?dG9zQUJTSVFtbDIxZWhpN2s5NEJFNGM1TUlXbnJtNjlwYy9SdmkxeVQ0VDJl?=
 =?utf-8?B?VnlRS2hjU2lsYWhTcVlwWkg2OHA0aDlJOU9lRWpKRjlJaDdpWENXTmlycGtI?=
 =?utf-8?B?ZU5nQXVDT1pkckRVc3BBTm9CbFB1amcxcW9JZS95RTlySm5iTk4zZmR5OXhD?=
 =?utf-8?B?YllIVWFleiswM3FBU3l5WVNaaDZmdmNORE5KTXF3aGgyQUUzNHhVSWRSRzdX?=
 =?utf-8?B?TWtXMWlDVkprVE9Xc0xjVU8wUnNWNXBqVldqSnR2Vy9xTTZkdTA5cThDYjlS?=
 =?utf-8?B?TzlJNTE1WUhDZTdwV0l5YlJ3dTVCd00rYXlxTmJUdnU1WUdmK05RM3dPcTBz?=
 =?utf-8?B?RlZFWUhvZ1ZjV252M2Y1YWNTc3Q4ZGFVYkhrcGJDTGNQSk9DMlRCZTYvU3VR?=
 =?utf-8?B?ZEJSUEM3N1NmMDJsVS9HOEVSWExEQ2dWUmVySFpuWEtOWDd6UCtnSW0yeXBC?=
 =?utf-8?B?d1VVRjE5S20vblVjdkdwNVUvd0Y5bWVZTUJpMVplSXdqMXptNUQvRDAzUlZj?=
 =?utf-8?B?akxxMDhzb2JRYVlRM1JzNmw3aERWRTNxOHhSa2wvQ21CNXdiakRXVmNpWmdk?=
 =?utf-8?B?bEswb3g3NjlNbHNERzVTbXJ6UFpnRUcwbkx4cEt5a2pSUDJFeUpIUHk0aW5C?=
 =?utf-8?B?YlRNcTFLd1QrYlYyenF0MnMrVzJ0ZURBOWpVK2ROR25uQ1FVVUovUStDczVY?=
 =?utf-8?B?UzEzYTdobnNUSDVpMnhDeHYremdIL2dvWm1VR2c0emNSNzFYLzl2ZDdlbGUw?=
 =?utf-8?B?ZzRyMzIxWlRKQTBJVGVlY056RTk3TDJBNTFIazBzWHBWVHcyV1I4b2RPQXBL?=
 =?utf-8?B?WllUd282c2Y4SUQ2Zis1eVdCWnBtZFZIQXZkR1h2ZmloZXRXUi9tQ3VrVXBz?=
 =?utf-8?B?RXBlbmVWMnl4T2taeVRrL3JQd3BlVFNVdUsva2p4YWVPTHRHSG03UkV4ODc1?=
 =?utf-8?B?SGZBRXFpeWsyVHlFVUVlQUd4bUMrcHhwdkF1MkxrQnhDUEFCMXJJZFJicEFM?=
 =?utf-8?B?eFJJY0lEWkRDTHRDa1Q1KzhEbkk4SHI4bkkxOWZGdzVlS2Z3cHl2VDJvNm1V?=
 =?utf-8?B?UkRxenNkVEtQVWFUOWJKL1ZlUUMzRVMremMrYUlGejVXR0pLVjNhdE44SU15?=
 =?utf-8?B?bkJzS3dvNVdhdEI1eFZYRTFrZzRBdys2WUVZTUdrbGhmTXNDb0ZHM2h0bEQ5?=
 =?utf-8?B?Nnh1R3FKeC9pK29hclkrejlpbW01Uy9Lb1dnYSt0NmhzVTVaY0JHNW9FK2FD?=
 =?utf-8?B?M1lSZE0zekZEdnpCdEFaY0lSblk3YUZlaE40QXJIKzhyVmVPRDBkNVNuZ0FZ?=
 =?utf-8?B?RnRNWUtzRlgvTE5sK0RzOUV4TFhRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3440.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5905e4dc-bfab-48ca-3786-08dac23d6a5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 10:30:25.9296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g5gDlTEv49TWxZGMuuPaTvD44C/qfJ7urcS8wom0fKMxvQ/xobiVXr3LnUPLC9u1A1C8Abo2Vur6RJDIJFxDrhuKPlrZshJRzlKPkPbi+7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1408
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4ZWkgU3Rhcm92b2l0b3Yg
PGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1i
ZXIgOSwgMjAyMiAxOjUxIEFNDQo+IFRvOiBkdGhhbGVyMTk2OEBnb29nbGVtYWlsLmNvbQ0KPiBD
YzogYnBmIDxicGZAdmdlci5rZXJuZWwub3JnPjsgRGF2ZSBUaGFsZXIgPGR0aGFsZXJAbWljcm9z
b2Z0LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCA0LzRdIGJwZiwgZG9jczogRXhwbGFpbiBo
ZWxwZXIgZnVuY3Rpb25zDQo+IA0KPiBPbiBUaHUsIE9jdCAyNywgMjAyMiBhdCA3OjQ2IEFNIDxk
dGhhbGVyMTk2OEBnb29nbGVtYWlsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBEYXZlIFRo
YWxlciA8ZHRoYWxlckBtaWNyb3NvZnQuY29tPg0KPiA+DQo+ID4gRXhwbGFpbiBoZWxwZXIgZnVu
Y3Rpb25zDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBEYXZlIFRoYWxlciA8ZHRoYWxlckBtaWNy
b3NvZnQuY29tPg0KPiA+IC0tLQ0KPiA+ICBEb2N1bWVudGF0aW9uL2JwZi9pbnN0cnVjdGlvbi1z
ZXQucnN0IHwgMTggKysrKysrKysrKysrKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNyBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9icGYvaW5zdHJ1Y3Rpb24tc2V0LnJzdA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9icGYv
aW5zdHJ1Y3Rpb24tc2V0LnJzdA0KPiA+IGluZGV4IGFhMWIzN2NiNS4uNDBjMzI5M2Q2IDEwMDY0
NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vYnBmL2luc3RydWN0aW9uLXNldC5yc3QNCj4gPiAr
KysgYi9Eb2N1bWVudGF0aW9uL2JwZi9pbnN0cnVjdGlvbi1zZXQucnN0DQo+ID4gQEAgLTI0Miw3
ICsyNDIsNyBAQCBCUEZfSlNFVCAgMHg0MCAgIFBDICs9IG9mZiBpZiBkc3QgJiBzcmMNCj4gPiAg
QlBGX0pORSAgIDB4NTAgICBQQyArPSBvZmYgaWYgZHN0ICE9IHNyYw0KPiA+ICBCUEZfSlNHVCAg
MHg2MCAgIFBDICs9IG9mZiBpZiBkc3QgPiBzcmMgICAgIHNpZ25lZA0KPiA+ICBCUEZfSlNHRSAg
MHg3MCAgIFBDICs9IG9mZiBpZiBkc3QgPj0gc3JjICAgIHNpZ25lZA0KPiA+IC1CUEZfQ0FMTCAg
MHg4MCAgIGZ1bmN0aW9uIGNhbGwNCj4gPiArQlBGX0NBTEwgIDB4ODAgICBmdW5jdGlvbiBjYWxs
ICAgICAgICAgICAgICBzZWUgYEhlbHBlciBmdW5jdGlvbnNgXw0KPiA+ICBCUEZfRVhJVCAgMHg5
MCAgIGZ1bmN0aW9uIC8gcHJvZ3JhbSByZXR1cm4gIEJQRl9KTVAgb25seQ0KPiA+ICBCUEZfSkxU
ICAgMHhhMCAgIFBDICs9IG9mZiBpZiBkc3QgPCBzcmMgICAgIHVuc2lnbmVkDQo+ID4gIEJQRl9K
TEUgICAweGIwICAgUEMgKz0gb2ZmIGlmIGRzdCA8PSBzcmMgICAgdW5zaWduZWQNCj4gPiBAQCAt
MjUzLDYgKzI1MywyMiBAQCBCUEZfSlNMRSAgMHhkMCAgIFBDICs9IG9mZiBpZiBkc3QgPD0gc3Jj
ICAgIHNpZ25lZA0KPiA+ICBUaGUgZUJQRiBwcm9ncmFtIG5lZWRzIHRvIHN0b3JlIHRoZSByZXR1
cm4gdmFsdWUgaW50byByZWdpc3RlciBSMA0KPiA+IGJlZm9yZSBkb2luZyBhICBCUEZfRVhJVC4N
Cj4gPg0KPiA+ICtIZWxwZXIgZnVuY3Rpb25zDQo+ID4gK35+fn5+fn5+fn5+fn5+fn4NCj4gPiAr
SGVscGVyIGZ1bmN0aW9ucyBhcmUgYSBjb25jZXB0IHdoZXJlYnkgQlBGIHByb2dyYW1zIGNhbiBj
YWxsIGludG8gYQ0KPiA+ICtzZXQgb2YgZnVuY3Rpb24gY2FsbHMgZXhwb3NlZCBieSB0aGUgZUJQ
RiBydW50aW1lLiAgRWFjaCBoZWxwZXINCj4gDQo+IGVCUEYgcmlnaHQgbmV4dCB0byBCUEYgbG9v
a3Mgb2RkLiBMZXQncyBzdGljayB0byBCUEYgZXZlcnl3aGVyZT8NCg0KU2luY2UgdGhlIGJyYW5k
IGlzIGVCUEYsIGNvdWxkIHdlIHN0aWNrIHRvIGVCUEYgZXZlcnl3aGVyZSBleGNlcHQgdGhlDQph
Y3R1YWwgZGVmaW5lcyAoQlBGX0NBTEwsIGV0Yy4gaGF2ZSB0byBiZSBsaXRlcmFsKT8NCg0KRGF2
ZQ0K
