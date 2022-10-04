Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49FA5F47F1
	for <lists+bpf@lfdr.de>; Tue,  4 Oct 2022 18:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiJDQyU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 12:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiJDQyS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 12:54:18 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11023019.outbound.protection.outlook.com [52.101.64.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BF765826
        for <bpf@vger.kernel.org>; Tue,  4 Oct 2022 09:54:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gz2s1/TtSjG86EE/AZX+tjpiLxRLLeuaVMfGz8LFT+6YbLpTKRzI47iCtNCe/1kqTTWCngwQTfMxn48XSkU3xgNQM2i/iNm4L0O63V8NeOWcBQM34FCC/FV98V922JZXjxi869EWNnkz5kppLNuzd9XOjXUUpbV9XLax4n1wlghrYLvxFTAO8SP2SBmiLKIxgzN5NAMU25qusf55K7Oak4Bea06EdNq4xTTd7yKvSxLJk3GJwVAIDdHeK+h7GowRb3wRfubevyy+0q+GiHivRbystVseiW/RvuMMb8VuMmTD+SnCrU1PouMSmEQKYmdBrGQgz0vJz1ZFTlW1ItoYjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LaD1On3plwDTu2RWGiMXUogx6Gu5rN6nBsSLHVOPrMw=;
 b=aeWPPZ/Wt/WzYO9nHsr8aorkmDA4qi0liEpxFFvTamZqsGQMnMcmWT5pem4DaABZD3Y1d/jkwWtlbyzcASaIbo6389FWd6YM6BI2bXu88+ZIiV272A6RVjDi6S6cqVcvzCLo3XimtLvUCR2DszOu/SehiPTtr5VvxIdKb1FiBbiJPTe8PELeo3PZR9iZjA/9Lqo5nDDsf6aXRPcFG3QXo1NHz4FZva7gWC0ZS4ThFMOc0tgBKnCm+CMrIjWZ1kge6bXDG/NRBdFV2xEv6JkqY8MCfEyGFrMvpPSIk0lC2Ihjz+xi/IP9G5zDxdNQA2cvoCLOaaf3jDDLlktUzfjwgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaD1On3plwDTu2RWGiMXUogx6Gu5rN6nBsSLHVOPrMw=;
 b=e50YCco0ks8wNKoEJrRmaYOEPs9LF/fF9ATXuqd8lwsO0/nQA+wLwD5EfCHIyeUeAcHni2T/IFlgO6SlqgfO8PCUB+aa41bf0UkScTVkBPs90+B9I9JR3ExLLDV7rSfL+LL/vhG3wuu4rBZW5Y71UCGCroOeA5ypadAqvGm0p/c=
Received: from DM4PR21MB3440.namprd21.prod.outlook.com (2603:10b6:8:ad::14) by
 CY5PR21MB3516.namprd21.prod.outlook.com (2603:10b6:930:f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.9; Tue, 4 Oct 2022 16:54:14 +0000
Received: from DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::c76c:9386:3651:999d]) by DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::c76c:9386:3651:999d%3]) with mapi id 15.20.5723.008; Tue, 4 Oct 2022
 16:54:14 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH 11/15] ebpf-docs: Improve English readability
Thread-Topic: [PATCH 11/15] ebpf-docs: Improve English readability
Thread-Index: AQHY0qNqv++jE8+E60q227lL8nNlGa34j0YAgAXGAWCAABQHAIAABHbQgAAAhPCAAAa7AIAABSaggAADc6A=
Date:   Tue, 4 Oct 2022 16:54:14 +0000
Message-ID: <DM4PR21MB344043ACEFD72B5F0A2A0758A35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
 <20220927185958.14995-11-dthaler1968@googlemail.com>
 <20220930221624.mqjrzmdxc6etkadm@macbook-pro-4.dhcp.thefacebook.com>
 <DM4PR21MB3440664B3010ECDDCF9731D1A35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
 <CAADnVQJQvdN2Dm7pwMno59EhMB6XT35RLMY4+w_xhauJ0sdtAQ@mail.gmail.com>
 <DM4PR21MB3440DF39304851D5F6108039A35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
 <DM4PR21MB3440986863D2893E382BDD02A35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
 <CAADnVQ+Vrm6g7FZ-PaqLkGfVzN+z8HBTq6Q3MmvR88J6H8cHPw@mail.gmail.com>
 <DM4PR21MB3440D8E8BB2A81C63756AAD6A35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
In-Reply-To: <DM4PR21MB3440D8E8BB2A81C63756AAD6A35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7e384ac4-ceb8-45af-b92a-b38ac280eec0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-10-04T16:38:23Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3440:EE_|CY5PR21MB3516:EE_
x-ms-office365-filtering-correlation-id: 8878fdbf-2a87-4e63-dde5-08daa6291166
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N07hG3SHOiF8IXlkJcaZ58av1Kxl3AGY8pgeWzSTpmhNLG9GK5DXx6wVfiIjTuDOZ3yjTaJRhfrLM6CRLl7Wi7MWPwcBad2sXIC01yinkl9dSiDcnh8MZKGbQk/dE3OcQYkobKtUaYuQgQV/EdIzCDa0MXJdXr0dlQiMfZTiO/ei8KfcgeCCV0uR5WvJbRkE03e7PoEocP+5uqR/gMwobPkoNU+qhkiCbAQEodOA/vycwrThsklk6oKiQOBcDDuBSK3cpeTYMbmr7DShXUW1CbHSoORVknH0xsYP26nCIDTA+ZYkB++S/mGekuxRkC/WvoEWispcL/jxPcjmI+2I8qz4sm39Q8NafKuW8xK/uYuDaux7eGp4DE+7ENJxhYlSbzA1/AkT6kbHZVw6YDqYXwnJwCiPFO7xt9p2ghtmwM8XGOHjJwUVlpYGda5C91rCUkSsTdXZxzFDyAN7pJsUdqG1aIS4rsH+LHAi3LlxVNBXa88wxumWs5aA/MIoH6qFaqKVC40v73DgKcD63gCiOQM/Dw/MZIMuIfYBL71IS7IEGxvcHsPJ3/Sqj/j+0GkjRdjW+g7BZmUhp0rMMFMqFpuSni+AvPGDY+N+zFN7DGvVkNXRTYUcmNhnJ+RNvITetxOUTctIjfAYsC4tp8BBAS/3nixYLhr2ngP7cOKvW6VJmOokNeVnpEmIAlDJ9HVPwwI4Cf6llSUA4nvMgvnfpZ7DakCBFapEsjidRC+OSA6svYQeAR0JTwiQzPyP81fk6CHl7hsNzFC1pcCEPFfFgxtPjlVrVCbAbDfT13Rex92woJQYL9ExOaCZnqdK07e0GMGXjjM2O1/FoTjiTZ7a4GQRCyOhN6ySmVPrz1IwtYQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3440.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199015)(186003)(8990500004)(2906002)(71200400001)(316002)(33656002)(122000001)(76116006)(6916009)(8676002)(478600001)(66946007)(41300700001)(966005)(10290500003)(4326008)(66476007)(66556008)(66446008)(64756008)(2940100002)(55016003)(9686003)(52536014)(38070700005)(5660300002)(86362001)(7696005)(6506007)(8936002)(26005)(82960400001)(82950400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXJCN1ZGbEtHcUpieDY1OVNoUitCcW5vck9uZEdaR3hXU1BDdGxSZ2hnZHdP?=
 =?utf-8?B?NUtXR00xU003Mjl0MWNzb01uRlFqZUxsVlJIN2JIMzVCVW1iSTJtekhhM3hi?=
 =?utf-8?B?aXFiUmFFQ0ZxcEM4ZVdGSTFrTzNReWlVSFhmbm1yaGoyaS8yLzVYUzk3RTJG?=
 =?utf-8?B?Z05McTQvbkd5L1oyaGF1Z2c3RCt1dVV5ZlZiV2Y4d3ZUUkY1Mk1lNjZYeThi?=
 =?utf-8?B?TlZqN1dSdmNlQndiZEw0ZkYvYnJ6N3RIUytYV2lUN1o2UlhEMnM1YWRpVWJM?=
 =?utf-8?B?SXVMUEpHVkZuMTl2L1VwRXpFWE5OM3RWRC9YT0tmMDYrMXdiVnNwQU5SaEUy?=
 =?utf-8?B?ZHNxUmRpZ3hsdGxlRGxDeVZNeXlmOHdaWTRIQlNuREFBWTgxUFRZeE52TkFV?=
 =?utf-8?B?VitTT3pCM05OQUkzT1AxK1VsWWFzdDA1NnR1Y0JFdUdpUHc1OHVRYlUyVG5u?=
 =?utf-8?B?WFZDT25RK2tCMk5QY204NnlIaTlQWGtoZFJrR0F1ZUp2bGJ0UTRCTU1xTCtB?=
 =?utf-8?B?bjhLTmtqc0hRVFBhemJQVUNqVE9FbE1EaU14M09PL04zSTlDNXpZMTFxa0lU?=
 =?utf-8?B?QUN5by9MaFJ3N2p0ZWU2c25lMlVGUFh0dnQrVWxRcDN3MThxalBMUVpiTThQ?=
 =?utf-8?B?OXFpSFdKeFVFNmdhNGx1TWxXR3kySG1lYVcxZWZlUFpFWFFSSnRua1RmNE42?=
 =?utf-8?B?b3JGcGhTQ2gxdDhIRmh4ekFDR1RDV2Fzb1JabWhXcHJsVlU1c081VDFocEUr?=
 =?utf-8?B?TytVYWt5NW1yU2svSDhkVzVzVSsyQWJKQWVWT21Hb0RNKzdYbjRjdnhxV0pi?=
 =?utf-8?B?UHhCUzJDNTZBdHYxbTZvYklwcEZaZHZqbDNIaUp2U3VFR3RpRFZ2TE54M0hq?=
 =?utf-8?B?Zzd1MExBOHA3R1ZZWU5YYVlPUU1HRXBMT2JGbXpvSHEvRndMVE5DU0xkOURN?=
 =?utf-8?B?NUJaUXorMEN4VElxUjV5ZUVPYnJLQ1RIaUljbUJ1RUcxcjYyMHZKNitMcTl1?=
 =?utf-8?B?eGZQVDArRERnNU1YOHhSZDRVTVZncnZUd1FOVXNqOXVHWFk0SXhWbjF2UGN4?=
 =?utf-8?B?U2pRcjc0TWU3cERpUGtpOTh5UXBqd0NpMk5kdGgrK1VQU0c2dzZZVGR6cXdL?=
 =?utf-8?B?M1lnL0FxVjdxbjBzMnZGbDBwZzl2RFYveWF6dHp1ZklOWFRBY1ROY002cFE1?=
 =?utf-8?B?cDVTc0lPVG1tTU9kcnJKVVBQcXlmNkRaamRWVkt6TTd2b2NiRW5ZRXpEcWdG?=
 =?utf-8?B?NTZpOVd5c3lIcFNmckZocldMcnNITm1rUkYrZ0FVU3hQVjdlcDRtVUsvcjFP?=
 =?utf-8?B?UytXTEhGQUxYWkl1TG53Mm5pdkFQTzhNWW9TWk5RcUkra3Y1Nkk5dFhvT3dO?=
 =?utf-8?B?WmVMd3l0RUlHMkVqUndUa2tWd08yTDRxRnpoclNGaFR5a0pnemEvNzNqS20x?=
 =?utf-8?B?Qldqa1NvUVhBcTlTR0J4Zjl1N2Iwa1hZWVJlOTFhRzVRbnVKVkRwNWN3R0cr?=
 =?utf-8?B?bzU5d0haK1NCemMwQUJxdmVkQk1Wa1JxUlBBUjBGdTFIZGxVVUJkdHExVUlr?=
 =?utf-8?B?RmpyZnhvOHlINFI5SlpZS25HbEZYR1VWVXVwSGtuVnorMmlHZ0wzc05mYTNT?=
 =?utf-8?B?STJOWU5pVGxBQkZqSk0yaFRad1c2THpGQnMybWNwVlNWRUNHc0JGUlg4ZmNT?=
 =?utf-8?B?bzduSnVCbWpvVllWME1pUnkwdVdYYjkyajg1ZGF0dmRWQ1RtN2pqSzFFSkNx?=
 =?utf-8?B?bFlEMmltRnRqZzhLNGhENHptZitmU2ZoUXYvcmNPSEVhT1VyZ1J2ajF2SURq?=
 =?utf-8?B?TVB2R29lSmhIOWJvbm0rSTdqVWhQMW5FekdVZ2xTU1FkNnkzcjNZY1dVZVVN?=
 =?utf-8?B?dE9vaEx4Unhpc3BSRGQraEhQeFRia1FlYjgvb0EzZHpvK0RsSXdIZWFRcVMx?=
 =?utf-8?B?RGh0Si9HZlBTaDRXUlExbTRtN1d1WEIyZUlWQURVM2RBYVJFNVBuNEI3a1lR?=
 =?utf-8?B?T296TlZ6VVB6KzNFcW9KRmYweWdPcFhkS0hjR1g5OGlXOXdZNGozOHBOTlNO?=
 =?utf-8?B?Wm1ITDZjWVdUUXNUZmJtKytQdUVjQnJKQTdOOHl0dEc5M1JEaXNKV3p2YTlZ?=
 =?utf-8?B?VEo2WUJOMmFkU0Fzaiszb1VaaUxUcTBZb0RPVVJKTmM1dS84em01eG5CN0dR?=
 =?utf-8?B?aFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3440.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8878fdbf-2a87-4e63-dde5-08daa6291166
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 16:54:14.1701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wPZuYG/slN5KpchENxwXG/V9+G07uPoLF812wyJTOKmHn4Qnnrwaq/3U8g3by5VvhSQL9XlGl0H56E6o85kEthY7epWPwb/c8uF2LyZ8eek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3516
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

UmVnYXJkaW5nIHRoZSB0YWJsZXM6DQo+IFN1Y2ggdGFibGVzIGFyZSBzZWVuIGFzIGludmFsdWFi
bGUgZm9yIGRldGVybWluaW5nIGNvcnJlY3RuZXNzIG9mIG90aGVyDQo+IGltcGxlbWVudGF0aW9u
cy4gICBTbyB0aGUgZmVlZGJhY2sgaXMgdGhhdCBpdCdzIGltcG9ydGFudCB0byBoYXZlIHN1Y2gg
aWYgd2UNCj4gd2FudCBldmVyeW9uZSBlbHNlIHRvIGRvIHRoZSByaWdodCB0aGluZy4NCj4gDQo+
ID4gVGhlc2UgcGVvcGxlIHNob3VsZCBzcGVhayB1cCB0aGVuLg0KPiANCj4gSSBhZ3JlZS4NCg0K
SGVyZSdzIHR3byBwdWJsaWMgZXhhbXBsZXMuLi4NCg0KQ2hyaXN0b3BoIEhlbGx3aWcsIHNhaWQg
b24gTWF5IDE3IGF0IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2JwZi8yMDIyMDUxNzA5MTAxMS5H
QTE4NzIzQGxzdC5kZS86DQo+IE9uZSB1c2VmdWwgdGhpbmcgZm9yIHRoaXMgd291bGQgYmUgYW4g
b3Bjb2RlIHRhYmxlIHdpdGggYWxsIHRoZSANCj4gb3B0aW9uYWwgZmllbGQgdXNhZ2UgaW4gbWFj
aGluZSByZWFkYWJsZSBmb3JtYXQuDQo+DQo+IEppbSB3aG8gaXMgb24gQ0MgaGFzIGFscmVhZHkg
YnVpbHQgYSBuaWNlIHRhYmxlIG9mZiBhbGwgb3Bjb2RlcyBiYXNlZCANCj4gb24gZXhpc3Rpbmcg
bWF0ZXJpYWwgdGhhdCBtaWdodCBiZSBhIGdvb2Qgc3RhcnRpbmcgcG9pbnQuDQoNCkppbSBIYXJy
aXMgcmVzcG9uZGVkIG9uIHRoYXQgdGhyZWFkIHdpdGggYSBzdHJhd21hbiB3aGljaCB3YXMNCnVz
ZWQgYXMgdGhlIGJhc2lzIGZvciB0aGUgdGFibGUgaW4gdGhlIGFwcGVuZGl4Lg0KDQpKaW0gdGhl
biBjb21tZW50ZWQgaW4gdGhlIGdpdGh1YiB2ZXJzaW9uIG9uIEF1Z3VzdCAzMDoNCj4gSW4gbXkg
b3BpbmlvbiwgdGhpcyB0YWJsZSBpcyB0aGUgYmlnZ2VzdCB0aGluZyB0aGF0IGhhcyBiZWVuIG1p
c3NpbmcsIA0KPiBhbmQgd2lsbCBiZSBtb3N0IGVzc2VudGlhbCBmb3IgYSBtb3JlICJmb3JtYWwi
IHNwZWNpZmljYXRpb24uDQoNCkkgd2lsbCBlbmNvdXJhZ2UgdGhlbSBhbmQgb3RoZXJzIHRvIGNv
bW1lbnQgb24gdGhpcyB0aHJlYWQuDQoNCkRhdmUNCg0K
