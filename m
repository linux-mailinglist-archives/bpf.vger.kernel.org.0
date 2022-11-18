Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B915362F295
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 11:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241504AbiKRKaz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 05:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241185AbiKRKay (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 05:30:54 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70050.outbound.protection.outlook.com [40.107.7.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F13922EE
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 02:30:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksa2411t/jYsKoVbyDBAj962vz7VEiU9yt0j6J/MZpod6REQZ0OaZ5NOeJ4DSyFd9TkBxmv3ZqhdTDCix6GBrjQtCT08x3IL264+oW4CG3wr5LLAWDGCKtDVitX+OdI1/Tdzoh7JyUby405R8PHSA/VbXTnf1V1jafGBwz8lxIWbSa0jA3Mu3uaONrYIlELJxxORP8Bb4YHUk7EMjIP3MpbeKouOYwfRSb6KqiJesFZSeVnwxppF+7D8JOXQkM3u0fXuzihHDdELAX2X6Djf5T7n5uEZ0h3bsD2cUc4U493l/vEiYcJvEdVzypyiLf4eCW7VraDAuEWRKiE/GFIKnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4YFZmTJqp3kMl7SQ52EX6cM/yYZvuU0KfG+BOUn/0c=;
 b=JY3VfY0erAAAHeF426zVVH8rjDeYS1FJ4yWMMczRgUdocRPPLB44EtWVKiesg36xs9NVBy2ollIqOyWYIR0qqGQ6VcDDT9+GYHL9dy4aK3EuU4v2EmhvZ36K1+6la4SYrMQBWS0ZDRW7gpdxwD9nqTZxdKiWp+roima0JbJ2i/lRspqoueZY007Ak4miZICNfc36CtdcFfywGJKakLMuOBhtZcmettmPHm1TLiYJOwWdP2a2oaXaYQVT7xsaY+tXHRnTB1DeYUWTbVWr4BCQhivHl2R1sqOecoQ/4bWpjhoQmCYZtaE0VJrH7/Ajgrkc5RGxMGgRblMq7dNR0ldnww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4YFZmTJqp3kMl7SQ52EX6cM/yYZvuU0KfG+BOUn/0c=;
 b=K/D3eMtNB1P2jp7YE2OYZy18QY23Hc9aI71V3nYRPo6Ob72LU31QJtEqftYL+lzs1L/nb0HSmNrjongsOnoUhdiBNFQDx2sULLx1ZdyxbijY9Vsn+L0uPaI8UpmZjz0vp5qz5rqKnoXOxG1pJQeLgtKpE7i4O7CLw9lg8TAe/ps=
Received: from HE1PR07MB3321.eurprd07.prod.outlook.com (2603:10a6:7:2e::16) by
 AM7PR07MB6293.eurprd07.prod.outlook.com (2603:10a6:20b:133::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.20; Fri, 18 Nov 2022 10:30:51 +0000
Received: from HE1PR07MB3321.eurprd07.prod.outlook.com
 ([fe80::22cd:6278:c974:5e27]) by HE1PR07MB3321.eurprd07.prod.outlook.com
 ([fe80::22cd:6278:c974:5e27%7]) with mapi id 15.20.5813.018; Fri, 18 Nov 2022
 10:30:50 +0000
From:   =?utf-8?B?UGVyIFN1bmRzdHLDtm0gWFA=?= 
        <per.xp.sundstrom@ericsson.com>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Bad padding with bpftool btf dump .. format c
Thread-Topic: Bad padding with bpftool btf dump .. format c
Thread-Index: AQHY+zjUZPX3IHWbF0SkGbqCbLQ5Nw==
Date:   Fri, 18 Nov 2022 10:30:50 +0000
Message-ID: <9cfc736f2b45422a50a21b90b94de04b19836682.camel@ericsson.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR07MB3321:EE_|AM7PR07MB6293:EE_
x-ms-office365-filtering-correlation-id: e82c99f6-a186-4eea-d672-08dac94ff6ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 42k7SFqfwDLv/dbiCDoiogcM7huB2TEJWaDhu+IXcevSUJKEoFxwTbSJtBrYQcwWRY6Th4StU6XUd6I5q8JG2qEpYYWyN2558rSP0W0XpZytY3Y5osETDftRvkiheNKSyDVpa5Vwxt3CpMEr1N+N5yz0T2IrJIZqBwBzkkxkC+OWB58jBw1epBqBMM1LoFIeAl/D0h6eFeTz6rKUIL0sAZGU16NgPI5cvGzRvfFg4lJD7FqM3uAuT/N4qm9MBwhm0gCX0TQok6jFQqTQJEPz1l8M63GzX/VPHWF2an1GED0Yez+WZXtqLEE8h6USpb9oKfSjcaj74GWN8mNFtkUSXVjoAWUzCEk0wQDi86ldT/jL4XyJOfKXDqua9IdLqivZu/WlOAvS2g6bFypKwn8paPMQZYU83O9PG/swNT5qk3L/wkb+gnVHQbI7a6PaXagWa3kUEZ/swiwMHVbNfpOlBswmAN3+hIVGr05U8DK9a4BEqPUk+7Am0IPIlE96gsiIBEndLPnh0V+jTFSRkcQdpaPCPfd0fWVCTdRrW31rYTXjGeOpDYtHYAp2XBn0nSgKDkO4TeLY/83zns/rRvryzmpYiDnzei9XEl32CgGLxIeq1nB9UW/n1NrG4sx3WyUbAa419iF/VOv5zNsG1+7lHNhXg1MKgldMPJztbfeDJukmRghLlInvObBXkoYHsG1MAMrH0f71j1MmeRUyJjb1yYjMAYFETnhKmwnQajsKJJs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR07MB3321.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199015)(2616005)(85182001)(36756003)(5660300002)(8936002)(186003)(41300700001)(2906002)(85202003)(38070700005)(86362001)(122000001)(38100700002)(82960400001)(6916009)(6506007)(71200400001)(316002)(478600001)(6512007)(26005)(6486002)(64756008)(76116006)(91956017)(66476007)(8676002)(66446008)(66556008)(66946007)(129723003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkUrTHZMRThwWm1nT08rVFdpamhUUndQK1hLNlNlQmMyVHFpU2JvUG9FaGlU?=
 =?utf-8?B?UHE3MFAwT1V3L1lmOWdjUXRjUWZ1WnZ0SkJkUW9JVS9OUDlhQ0t6VWtBVm9S?=
 =?utf-8?B?NEx0MmtqSjBteUpJeEhDeXhBVytrT2N3UHV0aWEvRzJQNlFTby9GOVdpYStO?=
 =?utf-8?B?SFZFdkEyKzhaQi8zWEJrMEFtdjQ3NWsrU0hidC85MDBOenRSaHI2T1JHNjYw?=
 =?utf-8?B?QVB4TzhGSkFaaVV0dkZBRnB4d3NCMno0SzI4WCt6S0UzY24rSFZ4VnhPZE1j?=
 =?utf-8?B?SFpYV3dwNkttSHpJZUpZZXV4VE15VEF1aS83K3IrOEVpZVlnaWZaRVpONEF3?=
 =?utf-8?B?NWgxMUZaeCtnWWVGR3RoTWFhVWRGSFNGOS93NXRoajFkQUZaaVcvZDA2VTNG?=
 =?utf-8?B?ODRXVXZuOWtkOUxYcDZYcjhhdWxIdzBJbXhjRTJrbXg4M3FQTEF4ZFMzWDhk?=
 =?utf-8?B?UDVWelZzVWNGYU02aU53WStpT1ExMTJFVllkVGg0UUU2QWNtZXBwdHJJQmdM?=
 =?utf-8?B?TmhJUWdJRFNpamZFc25DMG14ZGtXQzZTTENWRXRSV3EwZmRBYnpFVW1COFp1?=
 =?utf-8?B?dDNWRDRVdEIxc1FhRVY1TTAwTytuaTBNRWJQd1BqU3pBOXJXVlFPZmZlL3k3?=
 =?utf-8?B?RkFqckFFc0FISUg3RE5qLy9pU0xuQm9mYy9pRXlDaDVsclpXc0F4eVZaYzlu?=
 =?utf-8?B?U09VOHhMeUF0UWdpN1d4bis1dHFBVkpxZjNhWE4vdGl6Z3NuL1V2UXkrMUF2?=
 =?utf-8?B?RVVwN0VSSXlXQi9UOS9WY0E2ZnhiL0Zvb3E4aDJZUG5SN0dvcFVsMDIzU0tP?=
 =?utf-8?B?ZDZvbklJNGRXVzczQ3M5bmZmQjNweDE0YWJuK3IvdGxCSFREZ0RuOWE2VHlE?=
 =?utf-8?B?R2ZUVHd1bzNKT1R6a0s2Q2tHUXFrcENNTE1zWDBFZGF1bnRsbXVSOWxmOFRz?=
 =?utf-8?B?UkYwU2dVRG1qQ2V2VXJyMjFhWlRKVytGbkRGZ2Q4WGMyYUN0b1VxR0JZYzlr?=
 =?utf-8?B?TkU4MkwrZzRkK29EMGQ4N1h0Q242Z0MvZFkvV1JQUGFoUlFBOFFTaTc2MWxB?=
 =?utf-8?B?WE1McE5lTUJaRHM2TmpsZWM5YVNuU2hSeTJ3cjFTVkcyMDNkVTNGNG1aQkNu?=
 =?utf-8?B?UVFONVpJMWhJNkRWdVVza0dhQXk2RFpVUmNhT1labVRIcWpiUW9sV3JPQ2xP?=
 =?utf-8?B?UHgyVTZVelN6d0tJdXFZaW9sdFhrRTQzejBHS1dDN05HbHM5cFRYTlVmTGxn?=
 =?utf-8?B?TjdZcEt0SXVPY2NjbExTbkdmL0Zpd2dyQnBTY09pVzhCSklzM09LR0pRSU1j?=
 =?utf-8?B?aHViaUkxdURhNFRzdlFUNkFXU2ovdWVSaW02eTEySm12MkFVcVkrOTlmelBN?=
 =?utf-8?B?OUpubGdLcXNObEloMzh4bjRDcEFIak12M0tjUlZ3eHdBMk9tcHNwN2l1QUs1?=
 =?utf-8?B?SEJhQlJOd25USzNoRXh2aUI5VnY2UlNEVU0yTTV3THdMeEYrNll0Nm9wRTFP?=
 =?utf-8?B?Vk1UMnZ0VldwcFl3dk5tanVGR0hKZjVhSXFUNG1HQnVuZzJTLy9vV0VYNnpu?=
 =?utf-8?B?TXNwc0pjR2RwdzdhZjhuQnRmM2t3ejZFYVl2T0JlS3ZkQ3ZtdmFMVy8rN2dv?=
 =?utf-8?B?R3FCMDBhU2hnSGUrYjNHZkhGN3RrazJzQnpVYjVuaW1FdXh2T3g1YVJHVHk2?=
 =?utf-8?B?TDFDMytrMGdYSElPdXBUcVp6bng2SlllN3lsYS9LbEFYZGFzR01BWXRZQ1oz?=
 =?utf-8?B?Z0IwZWNaN2NKVjZyTVJka2crRzNlSkVzb1JiV3JBNGJ2WFUxQzBkd215aHVk?=
 =?utf-8?B?ekJSUXNBZUdCVUxGK24wblpYb1M4SVgvL3NyVlhLWjZoTk1MMktYYURxL2Mv?=
 =?utf-8?B?RTlVRnB3S01XWVIvcXBQT0RpaUJ3QnA4elNZRlNBczlPckx1akNXME9hcGdk?=
 =?utf-8?B?UlRBenNNNHhGbXZMaWduNUhZVVo5SzN6QlZ5dFZwK1FWZG9HNjltZXI3WVBp?=
 =?utf-8?B?UDE1RUM5c0NrN051ckhBTElPc2tGQkdEVXJPSTg0aHJ2KzVZbWtsT0FjaUtH?=
 =?utf-8?B?QVBTczRreEZ1Q2Qxa2lHeGk3OE9PQ2YrR1FRTXQ1SUhuYkZBUUU2VTZOTzNQ?=
 =?utf-8?B?U1BWcCtLcTB5bDhQUzRKakgxbUFNZGNSU2hxZTByOE5aSzlrUDd1S2dJZ0dy?=
 =?utf-8?Q?jBTyAWeEQdCjx/CzbuIS9VU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <271EE4FD07B5EC4E976037627CCC10D7@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR07MB3321.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e82c99f6-a186-4eea-d672-08dac94ff6ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 10:30:50.8546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d4Y3sy48tq9fJt2PJKyOdjGtkg30dbMRpIkpdOrD2VjMWo8OMvDiQNvWjzq74xVFw+A3V4Kjq/hBODNN4GTf8nUZr2/f4zOX8GNj7GJ9T6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6293
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SGksDQoNCkkgZG9uJ3Qga25vdyBpZiB0aGlzIGlzIHRoZSBjaGFubmVsIGZvciByZXBvcnRpbmcg
aXNzdWVzIHdpdGggdGhlDQoiYnBmdG9vbCBkdW1wIC4uIGZvcm1hdCBjIiBmdW5jdGlvbi4NCklm
IHRoaXMgaXMgbm90IHRoZSBvbmUsIHBsZWFzZSBoZWxwIG1lIGZpbmQgdGhlIGNvcnJlY3Qgb25l
Lg0KDQpUaGlzIGJhc2ggc2NyaXB0IGlsbHVzdHJhdGVzIGEgcHJvYmxlbSB3aGVyZSAnYnBmdG9v
bCBidGYgZHVtcCA8ZmlsZT4NCmZvcm1hdCBjJzogcHJvZHVjZXMgYW4gaW5jb3JyZWN0ICdoJyBm
aWxlLg0KSSBsb29rZWQgaW50byBpdCBhIGJpdCwgYW5kIHRoZSBwcm9ibGVtIHNlZW0gdG8gYmUg
aW4gdGhlDQoibGliYnBmL2J0ZmR1bXAuYyA6IGJ0Zl9kdW1wX2VtaXRfYml0X3BhZGRpbmcoKSIg
ZnVuY3Rpb24uDQoNCkkgY2FuIGRpZyBpbnRvIGl0IG1vcmUgaWYgeW91IGxpa2UsIGJ1dCBmaXJz
dCBJIHdhbnQgdG8gcmVwb3J0IGl0IGFzIGENCmJ1Zy4NCg0KUmVnYXJkcywNCiAgIC9QZXINCg0K
LS0tLSBiYWRfcGFkZGluZyBiYXNoIHNjcmlwdCAtLS0NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiMNCiMgUmVwcm9kdWN0aW9uIGJhc2ggc2Ny
aXB0IGZvciB3cm9uZyBvZmZzZXRzDQojDQpjYXQgPmZvby5oIDw8RU9GIA0KI3ByYWdtYSBjbGFu
ZyBhdHRyaWJ1dGUgcHVzaCAoX19hdHRyaWJ1dGVfXygocHJlc2VydmVfYWNjZXNzX2luZGV4KSks
DQphcHBseV90byA9IHJlY29yZCkgDQpzdHJ1Y3QgZm9vIHsgDQogICBzdHJ1Y3QgeyANCiAgICAg
ICBpbnQgIGFhOyANCiAgICAgICBjaGFyIGFiOyANCiAgIH0gYTsgDQogICBsb25nICAgOjY0OyAN
CiAgIGludCAgICA6NDsgDQogICBjaGFyICAgYjsgDQogICBzaG9ydCAgYzsgDQp9OyANCiNwcmFn
bWEgY2xhbmcgYXR0cmlidXRlIHBvcCANCkVPRiANCg0KY2F0ID5mb28uYyA8PEVPRiANCiNpbmNs
dWRlICJmb28uaCIgDQoNCiNkZWZpbmUgb2Zmc2V0b2YoVFlQRSwgTUVNQkVSKSAoKGxvbmcpICYo
KFRZUEUqKTApLT5NRU1CRVIpIA0KDQpsb25nIGZvbygpIA0KeyANCiBsb25nIHJldCA9IDA7IA0K
IC8vcmV0ICs9ICgoc3RydWN0IGZvbyopMCktPmEuYWI7IA0KIHJldCArPSAoKHN0cnVjdCBmb28q
KTApLT5iOyANCiByZXQgKz0gKChzdHJ1Y3QgZm9vKikwKS0+YzsgDQogcmV0dXJuIHJldDsgDQp9
IA0KRU9GIA0KDQpjYXQgPm1haW4uYyA8PEVPRiANCiNpbmNsdWRlIDxzdGRpby5oPiANCiNpbmNs
dWRlICJmb28uaCIgDQoNCiNkZWZpbmUgb2Zmc2V0b2YoVFlQRSwgTUVNQkVSKSAoKGxvbmcpICYo
KFRZUEUqKTApLT5NRU1CRVIpIA0KDQp2b2lkIG1haW4oKXsgDQogcHJpbnRmKCJvZmZzZXRvZihz
dHJ1Y3QgZm9vLCBjKT0lbGRcbiIsIG9mZnNldG9mKHN0cnVjdCBmb28sIGMpKTsgDQp9IA0KRU9G
IA0KDQojIFZhbmlsbGEgaGVhZGVyIGNhc2UgDQpwcmludGYgIj09PT09PT09PT09PSBWYW5pbGxh
ID09PT09PT09PT1cbiIgDQpjYXQgZm9vLmggfCBhd2sgJy9ec3RydWN0IGZvby8sL159LycgDQpn
Y2MgLU8wIC1nIC1JLiAtbyBtYWluIG1haW4uYzsgLi9tYWluIA0KDQojIFByb3VkY2UgYSBjdXN0
b20gW21pbmltaXplZF0gaGVhZGVyIA0KQ0ZMQUdTPSItSS4gLWdnZGIgLWdkd2FyZiAtTzIgLVdh
bGwgLWZwaWUgLXRhcmdldCBicGYNCi1EX19UQVJHRVRfQVJDSF94ODYiIA0KY2xhbmcgJENGTEFH
UyAtREJPT1RTVFJBUCAtYyBmb28uYyAtbyBmb28ubyANCnBhaG9sZSAtLWJ0Zl9lbmNvZGVfZGV0
YWNoZWQgZnVsbC5idGYgZm9vLm8gDQpicGZ0b29sIGdlbiBtaW5fY29yZV9idGYgZnVsbC5idGYg
Y3VzdG9tLmJ0ZiBmb28ubyANCmJwZnRvb2wgYnRmIGR1bXAgZmlsZSBjdXN0b20uYnRmIGZvcm1h
dCBjID4gZm9vLmggDQoNCnByaW50ZiAiXG49PT09PT09PT09PT0gQ3VzdG9tID09PT09PT09PT1c
biIgDQpjYXQgZm9vLmggfCBhd2sgJy9ec3RydWN0IGZvby8sL159LycgDQpnY2MgLU8wIC1nIC1J
LiAtbyBtYWluIG1haW4uYzsgLi9tYWluIA0KDQpwcmludGYgIlxuPT09IEJURiBvZmZzZXRzID09
PVxuIiANCnByaW50ZiAiZnVsbCAgIDogIiANCi91c3Ivc2Jpbi9icGZ0b29sIGJ0ZiBkdW1wIGZp
bGUgZnVsbC5idGYgfCBncmVwICInYyciIA0KcHJpbnRmICJjdXN0b20gOiAiIA0KL3Vzci9zYmlu
L2JwZnRvb2wgYnRmIGR1bXAgZmlsZSBjdXN0b20uYnRmIHwgZ3JlcCAiJ2MnIg0KDQojLS0tLS0t
LS0tLS0tLS0tLS0tLS0tZW5kIG9mIHNjcmlwdCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQoNCg0KT3V0cHV0IG9mIC4vYmFkX3BhZGRpbmcuc2g6DQotLS0NCj09PT09PT09PT09PSBW
YW5pbGxhID09PT09PT09PT0gDQpzdHJ1Y3QgZm9vIHsgDQogICBzdHJ1Y3QgeyANCiAgICAgICBp
bnQgIGFhOyANCiAgICAgICBjaGFyIGFiOyANCiAgIH0gYTsgDQogICBsb25nICAgOjY0OyANCiAg
IGludCAgICA6NDsgDQogICBjaGFyICAgYjsgDQogICBzaG9ydCAgYzsgDQp9OyANCm9mZnNldG9m
KHN0cnVjdCBmb28sIGMpPTE4IA0KDQo9PT09PT09PT09PT0gQ3VzdG9tID09PT09PT09PT0gDQpz
dHJ1Y3QgZm9vIHsgDQogICAgICAgbG9uZzogODsgDQogICAgICAgbG9uZzogNjQ7IA0KICAgICAg
IGxvbmc6IDY0OyANCiAgICAgICBjaGFyIGI7IA0KICAgICAgIHNob3J0IGM7IA0KfTsgDQpvZmZz
ZXRvZihzdHJ1Y3QgZm9vLCBjKT0yNiANCg0KPT09IEJURiBvZmZzZXRzID09PSANCmZ1bGwgICA6
ICAgICAgICAnYycgdHlwZV9pZD02IGJpdHNfb2Zmc2V0PTE0NCANCmN1c3RvbSA6ICAgICAgICAn
YycgdHlwZV9pZD0zIGJpdHNfb2Zmc2V0PTE0NA0KDQo=
