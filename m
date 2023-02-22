Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAAC69FE69
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 23:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjBVWX3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 17:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjBVWX2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 17:23:28 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2096.outbound.protection.outlook.com [40.107.95.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37E965B3
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 14:23:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SelZgZ76lFj+eEOU0Gv7PSE3aIEGy7k+Ioa24ppb8+UZiat62/aXEz/sLy8REl/CfxccQnUPv0FMKob+rnGSrRfNjADLDVZ2Iz4qJpZwZnTIndWiG0498mWYxFISNu7tUynsH50JIZZXSEasovEMStWAhuMpXe8urFymohGQU/6IescXx4q7V3sIYgBfbJSGX+uxqUp7Uub+j3lD6ZOz2FnSsQtJGCDJDa3euJh0bK9E29B3rkOdPQKESPmpK+tqeT+drmGeZ8ULvf5Z3k41YcySsIcC6h2a7Ih9hhNtrh9knSaQEB/eX8cERHoMsEaVKtnQku75wg4DXTS3aSteVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4H/4MV021vt5wGaA62trbt7n3YCUNXQdwyeBCH+z4os=;
 b=euPh+FRBlG3/AYJlhKm8YrHihylKBH2QcAsx1QzAvlT77HCh+Ck1biEANpk/ox08NgXeYJka+zZDug8CfIHdk5J/POnRr2ZxeDvosfCvHVI88U1ryhIdD48keK4NIH0CjJkLDm44dyK3Bew0PP0wcA2EfJmZ9jxXoaUJJkAr7UOq7qZ8eH2UcweQkh4uxzRjk7eAyQPHjBIt3ZdsSve1JidOzszTXpuT+Pe6xlllj22qWppEL3Qpgrbdy8PXfhctRm0mPLnPKuxes4H0l5r/qbaosGWNJvxhkGFiReSoY4kSjlEv/UefVj80sb0JRSRVW5Y2Ddjzh1Fn/nWbbFbkKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4H/4MV021vt5wGaA62trbt7n3YCUNXQdwyeBCH+z4os=;
 b=LS6gZF1s2FpQxCeiCysOeLvFPNGNENb0Bk+MgOOo2J6uOa0+5YKdf/kTHk+gxkk+RO6S2UHIxRRWPvH64U04fp+FviMNAv/cQkZvzDyF2Ph7RWxwtXulB5B8bA4E4cCWvctXnAQFBQTAVAxliKBYrb4vIkJmuLZ7DrqHFep1yv4=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by CH2PR21MB1461.namprd21.prod.outlook.com (2603:10b6:610:83::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.5; Wed, 22 Feb
 2023 22:23:25 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::4538:223f:7805:9e75]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::4538:223f:7805:9e75%6]) with mapi id 15.20.6156.005; Wed, 22 Feb 2023
 22:23:25 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
CC:     bpf <bpf@vger.kernel.org>, "bpf@ietf.org" <bpf@ietf.org>,
        David Vernet <void@manifault.com>
Subject: RE: [Bpf] [PATCH bpf-next v3] bpf, docs: Explain helper functions
Thread-Topic: [Bpf] [PATCH bpf-next v3] bpf, docs: Explain helper functions
Thread-Index: AQHZRX4FT8MQ/ty9L0Kdx5CqvHKBaK7bi7cAgAAA2GA=
Date:   Wed, 22 Feb 2023 22:23:25 +0000
Message-ID: <PH7PR21MB38786142836F214747C82A92A3AA9@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <20230220225228.2129-1-dthaler1968@googlemail.com>
 <CAADnVQJHvFCTq-fWiore4iL9MV7CicDt=Tn697ZU3QMu-wWxeA@mail.gmail.com>
In-Reply-To: <CAADnVQJHvFCTq-fWiore4iL9MV7CicDt=Tn697ZU3QMu-wWxeA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fce72e3f-1d3d-4402-adc4-4eb52846f4ab;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-22T22:19:47Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|CH2PR21MB1461:EE_
x-ms-office365-filtering-correlation-id: 1b48d46f-6e93-4995-7c9e-08db15236a30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ot3EJdfihW6dRe2oh+YVZcRtGvrI6KkSpzEa4AqwwollMVFUqS/SgVe6TyDlqwAjxQlVXT6bp7H16kt3Jz8J5xW0hOS4iPnwSBBI0Xlq1NiJqp5n7KVluMIDPGEi3i54mlUiktkCH+AG3VGT+ZxemYk0g1SmHo0M+EMEQISiCwxK/RTWtPdUo7PcDM0KCuottSgTkQswfKpgxI547FLsw4KvpXBEU7RIxCfCQo4GimOBw4wLh/4w6RcBcDj0kX1d88hgvj7JGAwKb+AtLKaCwCvfZzqo2N4Dt3+fctkzocsqPaV5roA/0/q49aoy+yjcOYdLwKawQahwA1LLmZxbeaMnDKOE3WXbrmo3+lNUFEVu5Gl4EbcplAcytMZGQsDIdS2JeZOhh2/w6yrS0EYvYqdM/J5dGMRLSrnLhyiuhMgNsk+NdEKXDIpwL0EJNqhu3NVAsPK/mKbarPfbBcOtDnErIhBbbfIU7lYm8DTHIBeEqLYGGCV8QkL7IO+ZN2ND83eLW4MXvK4aq+UrBqFQL2r5qmw6ax7ykCHUrzi3tyN29Wcix/yKU0Duv/uK3rmIEn44KNCh19MDHkahuwHtMq/NIgMul62VS4Hnq+jeGC6zG+CAzI16b2bAOsShOyTxPrA6PUJOwK3bE7CpxnX+l1ZW8Wn01d/z+1otVy3dEGVvtTwKvn75KEuymCwFEwCAF1VzgoBthY6R6jHNa9GTt7/vt3lbAICCn5na1rUE8kZxAgmUbTqwJwMcllogA2BY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(451199018)(52536014)(8936002)(186003)(5660300002)(9686003)(26005)(41300700001)(8990500004)(66556008)(54906003)(66946007)(64756008)(8676002)(76116006)(4326008)(66476007)(66446008)(316002)(110136005)(33656002)(10290500003)(6506007)(122000001)(38100700002)(478600001)(7696005)(71200400001)(86362001)(2906002)(55016003)(82950400001)(82960400001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y05IQ2pGWmRwUjlUMFpVbSs4RFJPejE4T0hxMDRYY2R1VmcrVjJwYmM3Q21Q?=
 =?utf-8?B?Qlg2Y09RTmNNV05kK3FjRDAxRCtDRW5HQU1qcS9Ld0l1TXl3bllUNEJ3eTJI?=
 =?utf-8?B?N1J3YlVqbXlRcGc1ODNQeHZpY3htb2xOdWVKcUhzV1c4M01Tem1EUm1rNXE0?=
 =?utf-8?B?Z1NhZ3J6SzR4U2JRb0FUYy9HNmI1QXFFQW12dk1mK0pkbStKVlRydGlsME1o?=
 =?utf-8?B?NGdCZVFHd0l1VTk4Z0tYTWpHU21uSkd1SUNXOXlvRzdFUWplUEwzNHJnc1dz?=
 =?utf-8?B?d2RLczd3RlpITWhINnB0Q0pXQ2wyMiszRFNiWG4zc1ZKU1hNUXhJNXdUeW10?=
 =?utf-8?B?V2RkeUFRamZrcFlvNENuaGh3VnIvNkZhUWFtdExqakdnVW55alREZFZrc1Bk?=
 =?utf-8?B?TU16T1hldnlrdGdNUFVzQXZmK0NEU3NnekZqTGtYK0tubVIvWHR1S08yUENS?=
 =?utf-8?B?Y2pPUnMvVjArbEFHcUNRTWtoM3cwWlpSK3NMQ1d1YzF5VGRnRnh3NFVrUmdH?=
 =?utf-8?B?VFpzemNYQlBSZFhtMGRoK0ZYRWNJUXJ0bkpwbDB0aVhoQW5nOExWcEVNcnVv?=
 =?utf-8?B?eFgwUHk0Q25BQUFDWHovVDNCWkNtYy95WTl1RjlTMzlENUxMRndFekFPWVds?=
 =?utf-8?B?RE94dGw1dVZsQzExdXVXc2lQV2JHZHlVTEhQeS90N21Bc251SFVBWFRvRGh3?=
 =?utf-8?B?NlI1T3Z6djF5aFNOeDl2TDZ6KzFSRU5pVUdxRTg2UEZLU3E3ZlAyNHZBTW9O?=
 =?utf-8?B?cUNrWnVjNmFrOXUyWHVUS0duM2RNdlVJOGFzTjdiZUErdDBZV2FHT252Y003?=
 =?utf-8?B?dVlSUkZGWEJGQ2xIVlNrcnlESnhYUkVlUHY3UFFRMWVkUng4WWJ1L2FDK0hq?=
 =?utf-8?B?Z2w5cXBYQ1Y2RVhTd2NqVWhDL2ZjeTQwRlh3QUh0bUswRERoNWdCVTJtN21T?=
 =?utf-8?B?dHFmT3dvd0xsbnA4L3crUDlZci9VNnQyZ2diTHp4NDhXWm5VbHZWa0NYdFMx?=
 =?utf-8?B?TTUyaUZWZFMxLzYwOGtDZXRGeGppdVNWRW1vNG5lYXZ5SksxRWFFRTU0Y1FC?=
 =?utf-8?B?Wjh6Q1Vxd05vWXBhRFlReVZrSGtOM3NFWjd6TGpyUmF6UzduR3BIU0k2alZK?=
 =?utf-8?B?WTdXRDFOK1lxeS81ZEoxa0ljT1owdkErQ1dqMmJTUkdTWjhhQ3BhQTlPZzBz?=
 =?utf-8?B?VGJFZmNFb1RtdWovUTVYMEtpL0FrbUNOUjB1T1FoR2RzbUNsTHNOd2ovT0c2?=
 =?utf-8?B?a0JnQ0QyZGszcjRhbHl3ZVducnhjTkFIRVVta0RMSnZPQnNQYmdvQ1NDYXpS?=
 =?utf-8?B?T2R0ZnlrRkVFUmtOOWFXeGd2RTQybDVWMEFHdHpkWGJLdDM1ekxDUTFnV0FC?=
 =?utf-8?B?WFVwaVpvc29FVHhxc0FORHFVN0F1dVNJUmJ3RDJzbU44M09GRXZkek1TZG5U?=
 =?utf-8?B?U0ZpWmFBNXpYSVJWaUNWMktNVERlRVVoU3VMSWhoUzQvVTY0Kys0NGJaUEVD?=
 =?utf-8?B?MkJmcE41NzcweXFoWTQ1bUpUbjJMZmp1QVVWcFJ1SU9iL1N3OERzL1oxd1Bz?=
 =?utf-8?B?YmlxRE0rZjMxb3U3L2tNY2UweHdpUUtNYWFFemhwM1BDOTRiWlBLYnRlaGlh?=
 =?utf-8?B?M2Q1SExXb0tLTjVURDBtd28xZzhqK1BVb2JSQWQ0bGlCODUvY25lM0pQMDNU?=
 =?utf-8?B?YVM5cVhTYVpIZmpsU2JqeSsxWTB4bStNN3FPWldvUFZOTXZ4OGJQRXU1RTY4?=
 =?utf-8?B?djZnWVhFWHl0VzNYcjJOdExZelZIUzAzWmUrR0pWNGhiVVhXZjQ3WVgyenF3?=
 =?utf-8?B?TGJMSnVPSkpBTGRJa3hyc2daaU5ldTg3ckxnTmlYNlFIWHc1NStWWVRPTmky?=
 =?utf-8?B?MWpERkMvN0pVKy9CdythdDJCUzB1SEExUmtpR24rL244MnJqZ29UdXdOOTBp?=
 =?utf-8?B?WGxub1lMYTZMbGVnbWNEZ0VFU3lnTWVVWEM4TitBQUlFbVBGNkRMaUhxZ3Za?=
 =?utf-8?B?N3ZyT0xQQTFoQWpMNytrZGRyOVV3T3N4bUc3RUQ3TU5zclBRSWdyZkJqMzBR?=
 =?utf-8?B?aGh4WGRWQnVjTGRvQjZrbjYvUzgvKzdDdkZuYTZNMGJsNGF4QlZiQ2tQcDZa?=
 =?utf-8?B?NDR3Y2Qya1hhMDAydzY0emtnUWxmQWR0NzV4NHZ3ZFBrUnF2SjRLb1RBc01E?=
 =?utf-8?B?RGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b48d46f-6e93-4995-7c9e-08db15236a30
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 22:23:25.2502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4qMPREzbrL75emoisBQqFeFIiNRAiszS+yS6W8GCpWxOgu6uUKWV48byrm9AyD+yw2wc74amWvDQAr2Ykq/qvwf3wihG1ba7XF7BIeYxU30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR21MB1461
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

QWxleGVpIFN0YXJvdm9pdG92IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cml0ZXM6
DQpbLi4uXQ0KPiA+ICtIZWxwZXIgZnVuY3Rpb25zDQo+ID4gK35+fn5+fn5+fn5+fn5+fn4NCj4g
PiArDQo+ID4gK0hlbHBlciBmdW5jdGlvbnMgYXJlIGEgY29uY2VwdCB3aGVyZWJ5IEJQRiBwcm9n
cmFtcyBjYW4gY2FsbCBpbnRvIGENCj4gPiArc2V0IG9mIGZ1bmN0aW9uIGNhbGxzIGV4cG9zZWQg
YnkgdGhlIHJ1bnRpbWUuICBFYWNoIGhlbHBlciBmdW5jdGlvbg0KPiA+ICtpcyBpZGVudGlmaWVk
IGJ5IGFuIGludGVnZXIgdXNlZCBpbiBhIGBgQlBGX0NBTExgYCBpbnN0cnVjdGlvbi4NCj4gPiAr
VGhlIGF2YWlsYWJsZSBoZWxwZXIgZnVuY3Rpb25zIG1heSBkaWZmZXIgZm9yIGVhY2ggcHJvZ3Jh
bSB0eXBlLg0KPiA+ICsNCj4gPiArQ29uY2VwdHVhbGx5LCBlYWNoIGhlbHBlciBmdW5jdGlvbiBp
cyBpbXBsZW1lbnRlZCB3aXRoIGEgY29tbW9ubHkNCj4gPiArc2hhcmVkIGZ1bmN0aW9uIHNpZ25h
dHVyZSBkZWZpbmVkIGFzOg0KPiA+ICsNCj4gPiArICB1NjQgZnVuY3Rpb24odTY0IHIxLCB1NjQg
cjIsIHU2NCByMywgdTY0IHI0LCB1NjQgcjUpDQo+ID4gKw0KPiA+ICtJbiBhY3R1YWxpdHksIGVh
Y2ggaGVscGVyIGZ1bmN0aW9uIGlzIGRlZmluZWQgYXMgdGFraW5nIGJldHdlZW4gMCBhbmQNCj4g
PiArNSBhcmd1bWVudHMsIHdpdGggdGhlIHJlbWFpbmluZyByZWdpc3RlcnMgYmVpbmcgaWdub3Jl
ZC4gIFRoZQ0KPiA+ICtkZWZpbml0aW9uIG9mIGEgaGVscGVyIGZ1bmN0aW9uIGlzIHJlc3BvbnNp
YmxlIGZvciBzcGVjaWZ5aW5nIHRoZQ0KPiA+ICt0eXBlIChlLmcuLCBpbnRlZ2VyLCBwb2ludGVy
LCBldGMuKSBvZiB0aGUgdmFsdWUgcmV0dXJuZWQsIHRoZSBudW1iZXIgb2YNCj4gYXJndW1lbnRz
LCBhbmQgdGhlIHR5cGUgb2YgZWFjaCBhcmd1bWVudC4NCj4gDQo+IEFib3ZlIGlzIGNvcnJlY3Qs
IGJ1dCBpdCBhaW1zIHRvIGRlc2NyaWJlIHRoZSBjYWxsaW5nIGNvbnZlbnRpb24gd2hpY2ggc2hv
dWxkDQo+IGJlIGRvbmUgaW4gYSBzZXBhcmF0ZSBCUEYgcHNBQkkgZG9jIGFuZCBub3QgaW4gaW5z
dHJ1Y3Rpb24tc2V0LnJzdC4NCj4gQW5kIGlmIHdlIHN0YXJ0IGRlc2NyaWJpbmcgY2FsbGluZyBj
b252ZW50aW9uIHdlIHNob3VsZCB0YWxrIGFib3V0IHByb21vdGlvbg0KPiBydWxlcywgc2lnbiBl
eHRlbnNpb25zLCBleHBlY3RhdGlvbnMgZm9yIHJldHVybiB2YWx1ZXMsIGZvciBwYXNzaW5nIHN0
cnVjdHMgYnkNCj4gdmFsdWUsIGV0Yy4NCg0KVGhlIGluc3RydWN0aW9uIGl0c2VsZiByZXF1aXJl
cyBkZWZpbmluZyB0aGUgY29uY2VwdCBvZiBhIGhlbHBlciBmdW5jdGlvbiwgc28gaXMgdGhlDQp0
ZXh0IGluIHF1ZXN0aW9uIHRoZSBwYXJ0IHN0YXJ0aW5nIHdpdGggIkNvbmNlcHR1YWxseSwiIGRv
d24gdG8gdGhlIGVuZCBvZiB0aGUNCnF1b3RlZCB0ZXh0Pw0KDQpTaW5jZSB0aGVyZSBpcyBubyBz
ZXBhcmF0ZSBCUEYgcHNBQkkgZG9jdW1lbnQgKGFuZCBJJ20gbm90IHN1cmUgdGhlIHNjb3BlIG9m
DQp0aGF0IGRvY3VtZW50IG15c2VsZikgY2FuIHdlIHB1dCBpdCBoZXJlIGZvciBub3cgYW5kIG1v
dmUgaXQgd2hlbiB0aGF0IGRvYw0KaXMgY3JlYXRlZD8gICBJZiBub3QsIHdoYXQgcGFydCBvZiB0
aGUgdGV4dCBhYm92ZSB3b3VsZCBiZSBpbiBhIHNlcGFyYXRlIGRvY3VtZW50Pw0KDQpbLi4uXQ0K
DQpEYXZlDQoNCg0K
