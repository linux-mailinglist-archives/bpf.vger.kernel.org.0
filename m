Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB94B62FB98
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 18:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242465AbiKRR0f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 12:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242329AbiKRR02 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 12:26:28 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80057.outbound.protection.outlook.com [40.107.8.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EB6DF8B
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 09:26:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adlnhuA7EgE1XPFiIrV/ASYZLTC9YCx6bcnVmFU3XRdXsIecxQmvirto6vcUeDJwy7AKo0xPpqCJgWIDuxDXQaU1vK4dNaQbhsEPlwfZEBYDYdUqkCvdXY71/6l25OOaw+sZu8nFNe8DdXg0UJRhtDtf4WDGY7Qbc/pZb+K9/e35LTBoRsY+PPUfsYiBe3kE/CENHigJWyec/hQP6esywV5tvKhAPcpe9J4ks+k7sQrIjVHWcNj10v41SG+/ucronIWntBCI9hvJA6VENCWuuiermYpg5/ZTxHrJ7pyMvD+uCjgOcUEk1XuwQIz9T/Yt73o6BdGm9NXkdMjnSRkLIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZsMrN6yhcqsOrzGb3wt2Y9Rib/JM/BCaHVo28H7Igc=;
 b=NvwD04d9JgJsoiCcd1eRuRH9Oq19GR0FbkMUsasDi8pr/wRhJ4DzeODlorc3gPBrDhStsmQLUtPULB6lA2PgWiBazUaEWsXRCc22y3v/hV527T5JxlIgoMNpXbr50Gpc4xSkSQ0VJ9OiT0LwaqVfpPDsRyUutXlKK/VjZR10VTb/BCOvqYS1GnEAXv6x3ssVCmzDE/+gLEiO3BJ4/m04icCLGoxDhQavTmWjn/oFLtdJ9DOYsmYFi0PsNhj+6QdnE80D69cuMxhFGRiaprJJhWzHhi7h13E1ioK+AvVzAv04Whvi5ROJhrouXqs9Dmp6AWa2LUTUMeXcTQZ5qa+Jgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZsMrN6yhcqsOrzGb3wt2Y9Rib/JM/BCaHVo28H7Igc=;
 b=JCI7FIstTEGG1t8wg9JKK9BIDvDo6Z1dGSTrR9F+FXWCkzsXFmr1uIIEeyuJrnoBTPwFG9KQYZDaXvdBGmHvR181wsK7Vd6nCnoGDuznLfjGE/4ytLoe9mMr/Zpteqke3I1oylYvWenE3rouyhttGW0cDYWbYiI4wsfu4p3kDLc=
Received: from HE1PR07MB3321.eurprd07.prod.outlook.com (2603:10a6:7:2e::16) by
 DU0PR07MB8468.eurprd07.prod.outlook.com (2603:10a6:10:357::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.9; Fri, 18 Nov 2022 17:26:24 +0000
Received: from HE1PR07MB3321.eurprd07.prod.outlook.com
 ([fe80::22cd:6278:c974:5e27]) by HE1PR07MB3321.eurprd07.prod.outlook.com
 ([fe80::22cd:6278:c974:5e27%7]) with mapi id 15.20.5813.018; Fri, 18 Nov 2022
 17:26:24 +0000
From:   =?utf-8?B?UGVyIFN1bmRzdHLDtm0gWFA=?= 
        <per.xp.sundstrom@ericsson.com>
To:     "olsajiri@gmail.com" <olsajiri@gmail.com>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: Sv: Bad padding with bpftool btf dump .. format c
Thread-Topic: Sv: Bad padding with bpftool btf dump .. format c
Thread-Index: AQHY+zjUZPX3IHWbF0SkGbqCbLQ5N65En92AgAAkm4aAACrWgA==
Date:   Fri, 18 Nov 2022 17:26:24 +0000
Message-ID: <b529c3fa5946537f96430d679b9e8a4280f03e4b.camel@ericsson.com>
References: <9cfc736f2b45422a50a21b90b94de04b19836682.camel@ericsson.com>
         <Y3d9mYrkWjrkJ9q2@krava>
         <HE1PR07MB3321F2F4C156BCA6EFD3A3DBBD099@HE1PR07MB3321.eurprd07.prod.outlook.com>
In-Reply-To: <HE1PR07MB3321F2F4C156BCA6EFD3A3DBBD099@HE1PR07MB3321.eurprd07.prod.outlook.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR07MB3321:EE_|DU0PR07MB8468:EE_
x-ms-office365-filtering-correlation-id: 55134d6b-6e00-440b-3c76-08dac98a04ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JpYJf4hdGPWxe8CGqK0foc8CJmfLENTedp5J8YVOLW00pDlEDJrSW2BvBwvXWuZUDP0IzjZRCdhWk813pAduryzL3eT2Cbx0cpG7zHwSlxOYmxBxXDD329U8W4tEovmrPmXdvNj6IgItkXRb0HWeoSqWgHXFg0WMBexgh5c70XKiL/JZU3RVLB2Nj9EWwp1dlA7qhce6JA6rJBtY3Cz6dcienRTC0oUnF9dS5Kot1MThD8RRUwfanVbbbcGLAZumeFPusNyMBGUxUm00AIfINsPKhFnChj6+STtYk5Yp49X/th0XCFx3rJFKGF+ef5GuFtM5h+TEmAQiuS68JxKtUCTRxZTee0ZBaJ860rbxbqG7sJv47H19zIfB5+wjwURDICHARVQ70LMLzJdD3yiDg1I0FFJZArw2XKQbI3aHbLzxtPAzlOj7DfbZ8121eMUoG4wef81aOUSOfWKbo6ajYww1fzJYEIttV53qOUn8XGsQLL1oG2Soj1KCPNPz6NeYAoc5U+O9KmsWfAg7uVndH202G60N6rWrxnj3vTbuvhgfayS6q59QikgYtqDBcFjOdkzELB6ZWPx7Lj1+s3pvd5Jh4wzw0QnGdbUyfzA2OSoY4vFNGrOV9JYxkdvlikezOMAXYtekJTjlRYGxMYmejDkMp3Q0bjV4vxA6TuIirPaEHsE4MaRH8IXLS7xLOSnxFSENp6D0ZpLX6wCqEWDRjWZ4NWkEsnZ6pBqCiRQonSU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR07MB3321.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199015)(6506007)(478600001)(316002)(91956017)(2906002)(71200400001)(6512007)(110136005)(26005)(64756008)(66476007)(76116006)(41300700001)(8676002)(4326008)(2616005)(6486002)(66556008)(5660300002)(8936002)(186003)(66446008)(66946007)(86362001)(36756003)(85182001)(38070700005)(85202003)(38100700002)(82960400001)(122000001)(129723003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFhGWFpvWFYzS05LVmpLMFUwaEJxa3pQVERDTWh3NGoxNHJtRGJyY1I2NnNq?=
 =?utf-8?B?dGxKNlJXSTlGSUlMQnNkMHY5aWtINUF5M3dzOXpnR05pQkFickc5Z3JJOHo5?=
 =?utf-8?B?Z1lDZlRyNnBrQUtGaUtaY25hS2dBWC9lUjkwYTVPTDdmOW1EUzd4dVk2dG03?=
 =?utf-8?B?RTZzN0JHcUUzalJQV0dzUEZENVdtMXFsVUVwWDh2SytwbEQ2Rlczc2UzZ1N3?=
 =?utf-8?B?RHVuWGoxYUd5TjQ0MWN4TkRtZkV6VE1XU2F3RnZKV0VGM2ZrNjY2WGhiOVA1?=
 =?utf-8?B?TkI2MG0xUGNFbTVDNUFGTXFFcDJSS3VvTWt2bkM0blJpbHVqeHd2OStUaTlL?=
 =?utf-8?B?VlpaaTZUK1EyUFBidHpsK0pieTRzNkx1ZlFRVW9ESWsxQWZEc0xkMWJsODFy?=
 =?utf-8?B?cUJlN1ZINEEwQjVBN0hDVWl1WWEzN2NlREtrdGhJNFhWa3JCa1UycVBRaHlD?=
 =?utf-8?B?c1JOTlU2dEVsNTlwSytqY1RZeU0rQWJJUTZSOEJGK2hKVVpFWVl2SzVEakVx?=
 =?utf-8?B?YjdMNXIyMDJBRkVqSTA1QWlnVzdvaWY1Z3JuNDhJeng4Yk5yZUNkS2JRbTFJ?=
 =?utf-8?B?d0FsY1dBdCs1WGNrYTUzZEMxOUlFMWpqOHN2ai9RdXRTUVBKVGZ3RWJlY0Z6?=
 =?utf-8?B?TnQzaWU5dGVRd0N2YnVIZ09MaG0vWk9LTDNHM1N0UnhxWWNXb2NjVnN1SDRk?=
 =?utf-8?B?bTNTUXdWUlRnU2dVam9wSkRCVGorOXh1SzZmSS8rbkMwSHJJU2NsVUdaUWtt?=
 =?utf-8?B?RGNFL3NBY2Zodk5GSDRlTjhXRmVCNFozTDlLU0pjV2o2WFZTL2J0OWs0RWVC?=
 =?utf-8?B?cG9GbjlCRk5EdGpyc0hLWUdyK3ZSVnl5N28rcVJNcmFIMENXS0RMbnArVkw2?=
 =?utf-8?B?UWdGUjg3OWF2cEY4MGtzY0ZWcTkxWU9LOXVNVW00M1lLLzdpV2JjYnFkQ0Vh?=
 =?utf-8?B?OVEwVDFIZjd1aEpOb0JlelNxRWpPWUVnQklBMElCVHA5dFZqU3dYemJpQUJn?=
 =?utf-8?B?eTkvRGhPQWNndDgydzRrVHREUGhXV0xZZm4vSEFsRlhVY21FKytqY0kzYUJ3?=
 =?utf-8?B?ZFdGbWhzdFczZ1dRNWxKMEN2ZU9XTzFXckkrMmN6TllnOTRYRG1ya1k3VnVr?=
 =?utf-8?B?WXl0RzgvWHRXMjdlWC9zRVprZ1FmTzJUSEYzS0hLTkQ3S1VBaFB5cThHTWpO?=
 =?utf-8?B?OHFYSGpXc004WDRZRll5YStPSFBoVFNucVVUNC9Jd0pNbDFZSkZMVUNWMjJv?=
 =?utf-8?B?dkVmRlA0L1JKTE15U2ZtT1ZuSXp4MlJvRVBYTWZtWEk2ZFZteU53N1RHNTFC?=
 =?utf-8?B?M1lYSVlDem1jcFdEeTgzTnU3dkVBcjc2N01tWHFqWTU4T2hBa1dJMlpqZkZ6?=
 =?utf-8?B?VnR4WmJ6T2I3RE1PNll3TkFicytmUkE5NzJGRStPSTl2Vk1LcGhiMG83Nkhi?=
 =?utf-8?B?K0pCZFo5UllvZXR2RHhudkhEd3ZscCtvNzI1ZzNZRFhjbTVvSndoSEFTSzVt?=
 =?utf-8?B?T0h4NGIySDhMZWpQTGErOXVaRlBTYWJmYWZuMzVoZzd5cEpQT0VYU3d0Sm91?=
 =?utf-8?B?eWRvV2hrYmhObFRrS0tKZ1Z4ZDNkSDBVMzIxWGhxbnp4QWtleER0MUV6Q0dH?=
 =?utf-8?B?a0EzTnZhV1RyL3NHUjBNc3orbFZCNVpDNlNlcHZONjZjdGRYUDZUSUtlcUJ0?=
 =?utf-8?B?R2JveE1lZlZxQXRjaXQxUmdwRmhzYVpKTmVOWG9RSVR3eFArN3IwS1l0Mm1R?=
 =?utf-8?B?dWlGcHNsTWN6ZjhZNlpaaHE4eTQ2UmxIclJ6bWtDbG9UZk1ER25RZmVrYTJ2?=
 =?utf-8?B?SmtxemoxT3luMyswNjcwWjFIay95V2VaQmp0N3R1ZmNjbWRDRSt0dXBMME9o?=
 =?utf-8?B?ZXBoVW85QU9ZWEo2c1BqcTMvYkhmTGErNnZlTEp1cUJNVXJtYytMME1CRUp6?=
 =?utf-8?B?TnpHVmlIKzZLS1g0YTl3Vks4UGc3dEVxeGk4UjNGaWJVaGxqWVg5ekpHSWh6?=
 =?utf-8?B?MTJVOUZrUnNVWjRSR1ArWVlUSTg3cmxXRkpDaHhKTHBzUGZWUEhRYU5YR2Fl?=
 =?utf-8?B?aHhQMk9EWUNZK2trcXd5aWQvWFFIY0x4SUFGdmlyZ3ZSL0lmMTBQV3B6WUcv?=
 =?utf-8?B?YklYRGFEamZCdkZ1aGJLNUNpN0p0aVFBWjM1SEtiWVZxcWtTeHhRR3l4WFla?=
 =?utf-8?B?Y1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BAFAB69BB18BB498B6848A9D8016BFF@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR07MB3321.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55134d6b-6e00-440b-3c76-08dac98a04ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 17:26:24.7009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9/yBIch8txJXK7EY/t+gZ5DlSBX5+5QVn/85om1B8dTZ9brXQvPmukxxEtAhScVqX4TY00bzUIEk9BE2F306cG9FJYO42TerkF3uh5S1uLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8468
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQo+ID4gPT09PT09PT09PT09IFZhbmlsbGEgPT09PT09PT09PSANCj4gPiBzdHJ1Y3QgZm9vIHsg
DQo+ID4gICAgIHN0cnVjdCB7IA0KPiA+ICAgICAgICAgaW50ICBhYTsgDQo+ID4gICAgICAgICBj
aGFyIGFiOyANCj4gPiAgICAgfSBhOyANCj4gPiAgICAgbG9uZyAgIDo2NDsgDQo+ID4gICAgIGlu
dCAgICA6NDsgDQo+ID4gICAgIGNoYXIgICBiOyANCj4gPiAgICAgc2hvcnQgIGM7IA0KPiA+IH07
IA0KPiA+IG9mZnNldG9mKHN0cnVjdCBmb28sIGMpPTE4IA0KPiA+IA0KPiA+ID09PT09PT09PT09
PSBDdXN0b20gPT09PT09PT09PSANCj4gPiBzdHJ1Y3QgZm9vIHsgDQo+ID4gICAgICAgICBsb25n
OiA4OyANCj4gPiAgICAgICAgIGxvbmc6IDY0OyANCj4gPiAgICAgICAgIGxvbmc6IDY0OyANCj4g
PiAgICAgICAgIGNoYXIgYjsgDQo+ID4gICAgICAgICBzaG9ydCBjOyANCj4gPiB9OyANCj4gDQo+
IHNvIEkgZ3Vlc3MgdGhlIGlzc3VlIGlzIHRoYXQgdGhlIGZpcnN0ICdsb25nOiA4JyBpcyBwYWRk
ZWQgdG8gZnVsbA0KPiBsb25nOiA2NCA/DQo+IA0KPiBsb29rcyBsaWtlIGJ0Zl9kdW1wX2VtaXRf
Yml0X3BhZGRpbmcgZGlkIG5vdCB0YWtlIGludG8gYWNjb3V0IHRoZSBnYXANCj4gb24gdGhlDQo+
IGJlZ2luaW5nIG9mIHRoZSBzdHJ1Y3QNCj4gDQo+IG9uIHRoZSBvdGhlciBoYW5kIHlvdSBnZW5l
cmF0ZWQgdGhhdCBoZWFkZXIgZmlsZSBmcm9tICdtaW5fY29yZV9idGYnDQo+IGJ0ZiBkYXRhLA0K
PiB3aGljaCB0YWtlcyBhd2F5IGFsbCB0aGUgdW51c2VkIGZpZWxkcy4uIGl0IG1pZ2h0IG5vdCBi
ZWVlbg0KPiBjb25zaWRlcmVkIGFzIGENCj4gdXNlIGNhc2UgYmVmb3JlDQo+IA0KPiBqaXJrYQ0K
PiANCg0KPiBUaGF0IGNvdWxkIGJlIHRoZSBjYXNlLCBidXQgSSB0aGluayB0aGUgJ2VtaXRfYml0
X3BhZGRpbmcoKScgd2lsbCBub3QNCj4gcmVhbGx5IGhhdmUgYQ0KPiBsb3QgdG8gZG8gZm9yIHRo
ZSBub24gc3BhcnNlIGhlYWRlcnMgLi4NCj4gICAvUGVyDQoNCg0KTG9va3MgbGlrZSBzb21ldGhp
bmcgbGlrZSB0aGlzIG1ha2VzIHRpbmdzIGEgbG90IGJldHRlcjoNCg0KZGlmZiAtLWdpdCBhL3Ny
Yy9idGZfZHVtcC5jIGIvc3JjL2J0Zl9kdW1wLmMNCmluZGV4IDEyZjcwMzkuLmE4YmQ1MmEgMTAw
NjQ0DQotLS0gYS9zcmMvYnRmX2R1bXAuYw0KKysrIGIvc3JjL2J0Zl9kdW1wLmMNCkBAIC04ODEs
MTMgKzg4MSwxMyBAQCBzdGF0aWMgdm9pZCBidGZfZHVtcF9lbWl0X2JpdF9wYWRkaW5nKGNvbnN0
DQpzdHJ1Y3QgYnRmX2R1bXAgKmQsDQogICAgICAgICAgICAgICAgY29uc3QgY2hhciAqcGFkX3R5
cGU7DQogICAgICAgICAgICAgICAgaW50IHBhZF9iaXRzOw0KIA0KLSAgICAgICAgICAgICAgIGlm
IChwdHJfYml0cyA+IDMyICYmIG9mZl9kaWZmID4gMzIpIHsNCisgICAgICAgICAgICAgICBpZiAo
YWxpZ24gPiA0ICYmIHB0cl9iaXRzID4gMzIgJiYgb2ZmX2RpZmYgPiAzMikgew0KICAgICAgICAg
ICAgICAgICAgICAgICAgcGFkX3R5cGUgPSAibG9uZyI7DQogICAgICAgICAgICAgICAgICAgICAg
ICBwYWRfYml0cyA9IGNoaXBfYXdheV9iaXRzKG9mZl9kaWZmLCBwdHJfYml0cyk7DQotICAgICAg
ICAgICAgICAgfSBlbHNlIGlmIChvZmZfZGlmZiA+IDE2KSB7DQorICAgICAgICAgICAgICAgfSBl
bHNlIGlmIChhbGlnbiA+IDIgJiYgb2ZmX2RpZmYgPiAxNikgew0KICAgICAgICAgICAgICAgICAg
ICAgICAgcGFkX3R5cGUgPSAiaW50IjsNCiAgICAgICAgICAgICAgICAgICAgICAgIHBhZF9iaXRz
ID0gY2hpcF9hd2F5X2JpdHMob2ZmX2RpZmYsIDMyKTsNCi0gICAgICAgICAgICAgICB9IGVsc2Ug
aWYgKG9mZl9kaWZmID4gOCkgew0KKyAgICAgICAgICAgICAgIH0gZWxzZSBpZiAoYWxpZ24gPiAx
ICYmIG9mZl9kaWZmID4gOCkgew0KICAgICAgICAgICAgICAgICAgICAgICAgcGFkX3R5cGUgPSAi
c2hvcnQiOw0KICAgICAgICAgICAgICAgICAgICAgICAgcGFkX2JpdHMgPSBjaGlwX2F3YXlfYml0
cyhvZmZfZGlmZiwgMTYpOw0KICAgICAgICAgICAgICAgIH0gZWxzZSB7DQogIC9QZXINCg==
