Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FDF621D07
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 20:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiKHTcL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 14:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiKHTcL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 14:32:11 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90041.outbound.protection.outlook.com [40.107.9.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3044B66CBC
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 11:32:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jegwB0ClLIPrQB8yTpi1GytVg0tWqlNy/H0SgbkbouwUOWfbQNyQ/gc5brAQcfAoxGv0o2ziC7cp3hmeUEAkL2hTkj/u0yJ4tljuOWoJBAvr80arFHWNOj0TIKh/CV2Hcg6AzyUHSMLhd23wrVInDH0XOnUkd5F8Vb6VlCsjypnbVd2m1prD/2nvJNzFX2iHDFCMyi7nEyiIkT2+DA5h+v1UccuFpvEyldO1ZSncIKh2iQ6+JFRZ3c7Vj5xJm2Y6pUDpPBRogHABGKAlY8dnTxqNx5wgfoYcO3NxSLke6j2fDj2TLekiZ68JNASNn1Cs+l4zqg5aceYuGS7MOpqorg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcYqI25uNan9/DvgbI2bgvb93GjRRmZONESvQCO6PGM=;
 b=XAapBeuPMb9Jlyv2AjTDGh32dS5UTmU71sQGJtWfLipISle5/xxBMwFJ61GR6uiofaNyeyGFY6FG21ZPhnaHZSguN5MVvC1gH+sVWKuFz8cS6Y9Uzvs4a+5EfsZQLvlz1z2ELB2Ml2MmI4+tOORTQIP8XD5J7d/HtUZ0TuPQFc5jiBNOAMYnyHD1s4bLdD1AkmlesjSiV9xjeO/p9Z3K2zeKARvjfCiXnnvMc9/Hyd51ke99tf+hKVkzVmj302YWlb5sodoV8d9P7yddsKv5SZuc7yn2IsyiPB1mGk2JiAyl3PT5G43K1SLX9xq7VcWdyC0r9K8INujH0iAMKZIsMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcYqI25uNan9/DvgbI2bgvb93GjRRmZONESvQCO6PGM=;
 b=I5QCREPXTg1CjgI+tiz9SPYgN4l2DmruxSy5BI9P3bXsu9aohxZWYdSohsSuQLnZ0YSIjmZB+2ill8blySvXeEpWHoL/P56BMCWZqHOkjWD4OdrBSdJu+Eu2hpOollKXv7KNcTo2uV0kc/krccc+j5EUg4l8SdrDIBeGQEG0Y0C4B8mW43QWpO1swpKCiLmZKdIcQqRFXOSX1f17jEGaKFVmHQFBA7oCuiYYVgqOTo8PX835lcleSrZo5JnD3Mb7o+HU5XvZU8VOoCqXCHiCdNloHtCDHbjyVpdFahF+O6zkyV1YGGyIuIx5ZwNRYJmt/xaaN9VzMt3zYX62L49juw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB1621.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 19:32:06 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a85b:a9b6:cb36:fa6]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a85b:a9b6:cb36:fa6%9]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 19:32:06 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Song Liu <song@kernel.org>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hch@lst.de" <hch@lst.de>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "aaron.lu@intel.com" <aaron.lu@intel.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Thread-Topic: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Thread-Index: AQHY8voad8K6jE28j02RCI2Gw4PNuq406Q0AgAB1+wCAAAyUgA==
Date:   Tue, 8 Nov 2022 19:32:06 +0000
Message-ID: <37764b42-aefc-067e-c5fb-dbe43a770688@csgroup.eu>
References: <20221107223921.3451913-1-song@kernel.org>
 <83277694-6cb3-3fc7-b300-d39f82ac5b04@csgroup.eu>
 <CAPhsuW7a6dAHQC1Qt7ryxxZ0RA8kfL3SWh+jrAKFaGDKguCexg@mail.gmail.com>
In-Reply-To: <CAPhsuW7a6dAHQC1Qt7ryxxZ0RA8kfL3SWh+jrAKFaGDKguCexg@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB1621:EE_
x-ms-office365-filtering-correlation-id: cc020360-5cf9-4eec-bd47-08dac1bfebca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w7U2lVvrF7XCXEmHsBsmcufPQSkIiFfnkpoK24ObsDyLAcUIY+IcPCuEALUJSoBvFzvhQWWjtr1WJ8gYz1SnX6uMsSwQjj66ykfFG3/V5HDw3hynnXEjm/Md6ypMwXneqz4nLzT6zHfUJyR1Pm5s+z96Uk3Oym+T3ewKNqWy1Mcjuvor9SKqFr0TriWmGo2/eozRU2QeOpc0CA65KGwaqBbYPMG5ab0fxZBdHAFqLC/bECRoBQ7WFsFBwBOjZRSy62GKHRhT645uW3iXNwXMsvi24otRP/AjAsvM7GJxi/ML5AYaFNRP1J46W6lVWphqzjgBw13Mt4QllQeamS06ZYZpObIqiD7pBWevTfZlPiOsky2hlKHMcvEmenT+YcjDn8RCl+4dg28t3eOCxac9DALMONk3XmfkJjZB5cJgWRsLAw1Xxrv63zyl4SSxL2XhTtRryVmsktjtMivYIqDCda9ON2N3aB7Kkl02Sm6sV8CD/y3Asxb9p7g6aXL8isGRPR55f4ILrhQ097GK2W0gbensBIDSuzQd/0vL14Y+p/gRqAk+t6fIGTtZ+T2jlJUcZwaynWWHiODR6pTW2tTCceIGSgMbcOkfRGLvzr/Oja3GvNqg3H49t091MHqJEdsPffvftGEDxDtewLEG5zw+NgdHN0p7E8nWO60Zbng6AYgfR5Y/zUsbsU2McV5oT5b+m5T7g4tL7+w1JsSLDLMX87oe5a2PWOh6DpqZbkUeVTGYNpVfy8clKhq/wCHiDLbME/6KyKb9VFoNe7rS+HB2qtFclhXLUlBxtZVgRkFuLoY98hhO1z2Ap7y/q7K+zV4boQKKGcohiqR1llrdNVMnbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199015)(86362001)(5660300002)(83380400001)(66574015)(44832011)(6506007)(53546011)(478600001)(31686004)(316002)(54906003)(38070700005)(6486002)(6916009)(36756003)(2616005)(8676002)(26005)(6512007)(31696002)(8936002)(38100700002)(122000001)(66946007)(4326008)(7416002)(76116006)(66446008)(91956017)(64756008)(66476007)(66556008)(186003)(41300700001)(71200400001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aC9sbGEreXQ4d3N4YXc5eVZyZWNDNmlRRDRELzIrcXJZMFc2M0dFelFsNC8z?=
 =?utf-8?B?Z0NzeDBDMkY2RXhVK3FMQmxHcWE5OG9ERFFiTWtHSzJPVmFFRmY1Nmh2NWdQ?=
 =?utf-8?B?L0UwRmxBblhLSUt1RjNlZnlRR1FiOVVIZE1qMjYyeUN0NTMwclZtL2NwRUx1?=
 =?utf-8?B?U3FmcHJyTW01YlpiVEt6aDN2NWJEaFBvb1daMndMNk5CREd0NU0vSzVrSHln?=
 =?utf-8?B?elBrRXBDMGtBdHNmVnJyclF1dDdoenlNVVJjSVNCMzlGY3hLeVBtL3gzNVdO?=
 =?utf-8?B?a0ZxeGlRL2ptK24yQUZUb2w0cVFBY2JBMU8vWUZabThkTnlkWTIzekhUV3Z6?=
 =?utf-8?B?K1M2UnAyK1VIN0IrSjRBN2ZIQ1NWTDJHUFY1WjRpb05tWEdlYWVlMlQrTHlH?=
 =?utf-8?B?QjZaVzMvTUtheHZTU0tsTXRMeEtuZ29GK3dNOUlmMHFxVTh0c2VVZVllSEpU?=
 =?utf-8?B?aHUxcm9xdU11THllQU9jNk56WXpXZlluNzFvYVZUUUZoenB2a3NjdHZuOTZi?=
 =?utf-8?B?U3dkNWRBSmNReHlHa25VT1dldW1CYWNnTFhmdUZEMVQyU1RTODdKVVcwRkx3?=
 =?utf-8?B?blQxRWhHV3I0eWtRQUJKYkM2Y2p6L2Y2c0t4eFVOQjlyTlc0UjQrTmZ0Z2pa?=
 =?utf-8?B?dFIvbU5POHJZZkt6bUlMTGhETFB2Vi9tU09vUjY0dTJQZGdvYnlRUDh3RFBa?=
 =?utf-8?B?UUZQM0I5bGdJbE9BRUtaNTRYTmxkamVoeUwrNUt2QmFLalNXRWZWdWpyTHlF?=
 =?utf-8?B?NzErRTRNWHQ3NTVVT0NVSHVldmFZaHZhcldRbHhPc1IrcXROSUVla1FORFRG?=
 =?utf-8?B?UGpnUzZFMDA5TWpQUEVxL1h5TDBHSUlMUFFlOWszTkhOUHR4L1JEb3pGQU5m?=
 =?utf-8?B?UUdvWHVGak5xcFFSOWtxaENlWlU2aWppOExFQVZSMm9IejRqZ3ovOHJKY1Rn?=
 =?utf-8?B?WGhIZ0xvdUduVmg3UXVhWmJOcWNDdHA2K0pJYUQ3OTZuZ3pqQjJ2d3c3cVNo?=
 =?utf-8?B?SERXNTUrQXB6eDh5bElxcklXVFQ0YWdnMmVWbENqLzh1VndmNWNmeE03NTND?=
 =?utf-8?B?TU4wcS9MOFFFMkdxMW15Vk12TDU0c0VTUkZrb2RvNnExa3BwRklXRk10R3JV?=
 =?utf-8?B?aXBaU2x1SlpRRitEamhFeFFtWXNPdnpPS2pvazhWQXdzdjhOM05LS0VpVjh5?=
 =?utf-8?B?UWx5UDk3YjNMbC8reG91eENoOWtMSy9UbUx1THQzWHVLbUFHSjlBQkNlV0Ix?=
 =?utf-8?B?ZE9ndEQ5eGQrLzNEZE5lQ1NjdThKSlpvd08xaUo4TlMwNUJoTXh2dDU2RDRK?=
 =?utf-8?B?RERiOHFnMythWkRscWx6emU3ZUwrSUtsYXZZalNZMW5URkNOQk1yYXpjQ1d4?=
 =?utf-8?B?MHR5aUZrTHB5NzJGcW5xZ3YzdzREUmVzeUFhM1VrSEZHWlREZmJjcS9nRzBB?=
 =?utf-8?B?M09xR2M3SzdvaDl1QVpUdTI1NkJuTGJJTFlJT0Q4WFNkQ2RSRmhyZXVzb0Uz?=
 =?utf-8?B?d3pQaHlpcFlKRGdPUk4vQkVTcDIwbWZTSmFhMnZWVCttclc2R0t1YkpYYU9a?=
 =?utf-8?B?WS83NWYyOFB2dS85ZWtOOWdvaGVzZWRWRUc5RFdlVisyNWovRmkvNlIxdk9k?=
 =?utf-8?B?NmJwVnMyZURZSTBkSE5lUjlTekVTZHBPMTNlUnNjQzRFc05BVTZBOVE2Y3p0?=
 =?utf-8?B?QXF6NUwvY3gzM01qUnQxYU9QVjhEZzZ3a1MyQWtCcFBXWTNjdUhRdlJaNm5w?=
 =?utf-8?B?WFIzMEd0RFRwWkVsMGdmV1hBVkVnNWxsNUhuMDBhTVU0YzdWN0pkMEJkcmsw?=
 =?utf-8?B?aDdkS05NeU8rdU1IVzRvRkd6MFA4eVRsNkFWQXdVODFxSVpyR0NLUmxKbmFQ?=
 =?utf-8?B?L1F0RDlSSFhiSTVYNDhBam5uQVZBWmhjcktwNGc3dk1ScE5OakowemNpdTRN?=
 =?utf-8?B?TTdUb2VGTUg4SUpjWVR3NExyVEN4dkl3VWZrOElVSDlvem9LRkE0ZnYzS2Nw?=
 =?utf-8?B?V0YzbUZEbnB2Z1ZoTkVTYndFRmlBYU9WRGR6ajRMRVJYWUJKaUErUTVyb2cx?=
 =?utf-8?B?MkFydUUzMzVPL2xGS2paNUVRTkpreEVkQkR3cWlIcmt5Y1dpL1djY2VFN0w1?=
 =?utf-8?B?Mml5Q2dEdGY1aVVJdnFoRXMwL1FKZGxOSm53amhxSkJVNldYZjloMzdsTTh3?=
 =?utf-8?Q?MEPGkjpJOj/fw2RMr7UlMlc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BEAAD6410F40A4E85BFF5645FDBF89D@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cc020360-5cf9-4eec-bd47-08dac1bfebca
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 19:32:06.4568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ovgKzsv5kt0KQ39tTOHYJlvTUfNemGdArHbrnkbby9w7ZG9T6voLANX71D2UgGA+QUwiTq+EqKGglAAR3UZZJhWjqCqc1aCrW28vncHlV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB1621
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCkxlIDA4LzExLzIwMjIgw6AgMTk6NDcsIFNvbmcgTGl1IGEgw6ljcml0wqA6DQo+IE9uIFR1
ZSwgTm92IDgsIDIwMjIgYXQgMzo0NCBBTSBDaHJpc3RvcGhlIExlcm95DQo+IDxjaHJpc3RvcGhl
Lmxlcm95QGNzZ3JvdXAuZXU+IHdyb3RlOg0KPj4NCj4gWy4uLl0NCj4+Pg0KPj4+IGV4ZWNtZW1f
YWxsb2MoKSBtYW5hZ2VzIGEgc2V0IG9mIFBNRF9TSVpFIFJPK1ggbWVtb3J5LCBhbmQgYWxsb2Nh
dGVzIHRoZXNlDQo+Pj4gbWVtb3J5IHRvIGl0cyB1c2Vycy4gZXhlY21lbV9hbGxvYygpIGlzIHVz
ZWQgdG8gZnJlZSBtZW1vcnkgYWxsb2NhdGVkIGJ5DQo+Pj4gZXhlY21lbV9hbGxvYygpLiBleGVj
bWVtX2ZpbGwoKSBpcyB1c2VkIHRvIHVwZGF0ZSBtZW1vcnkgYWxsb2NhdGVkIGJ5DQo+Pj4gZXhl
Y21lbV9hbGxvYygpLg0KPj4+DQo+Pj4gTWVtb3J5IGFsbG9jYXRlZCBieSBleGVjbWVtX2FsbG9j
KCkgaXMgUk8rWCwgc28gdGhpcyBkb2Vzbm90IHZpb2xhdGUgV15YLg0KPj4+IFRoZSBjYWxsZXIg
aGFzIHRvIHVwZGF0ZSB0aGUgY29udGVudCB3aXRoIHRleHRfcG9rZSBsaWtlIG1lY2hhbmlzbS4N
Cj4+PiBTcGVjaWZpY2FsbHksIGV4ZWNtZW1fZmlsbCgpIGlzIHByb3ZpZGVkIHRvIHVwZGF0ZSBt
ZW1vcnkgYWxsb2NhdGVkIGJ5DQo+Pj4gZXhlY21lbV9hbGxvYygpLiBleGVjbWVtX2ZpbGwoKSBh
bHNvIG1ha2VzIHN1cmUgdGhlIHVwZGF0ZSBzdGF5cyBpbiB0aGUNCj4+PiBib3VuZGFyeSBvZiBv
bmUgY2h1bmsgYWxsb2NhdGVkIGJ5IGV4ZWNtZW1fYWxsb2MoKS4gUGxlYXNlIHJlZmVyIHRvIHBh
dGNoDQo+Pj4gMS81IGZvciBtb3JlIGRldGFpbHMgb2YNCj4+Pg0KPj4+IFBhdGNoIDMvNSB1c2Vz
IHRoZXNlIG5ldyBBUElzIGluIGJwZiBwcm9ncmFtIGFuZCBicGYgZGlzcGF0Y2hlci4NCj4+Pg0K
Pj4+IFBhdGNoIDQvNSBhbmQgNS81IGFsbG93cyBzdGF0aWMga2VybmVsIHRleHQgKF9zdGV4dCB0
byBfZXRleHQpIHRvIHNoYXJlDQo+Pj4gUE1EX1NJWkUgcGFnZXMgd2l0aCBkeW5hbWljIGtlcm5l
bCB0ZXh0IG9uIHg4Nl82NC4gVGhpcyBpcyBhY2hpZXZlZCBieQ0KPj4+IGFsbG9jYXRpbmcgUE1E
X1NJWkUgcGFnZXMgdG8gcm91bmR1cChfZXRleHQsIFBNRF9TSVpFKSwgYW5kIHRoZW4gdXNlDQo+
Pj4gX2V0ZXh0IHRvIHJvdW5kdXAoX2V0ZXh0LCBQTURfU0laRSkgZm9yIGR5bmFtaWMga2VybmVs
IHRleHQuDQo+Pg0KPj4gV291bGQgaXQgYmUgcG9zc2libGUgdG8gaGF2ZSBzb21ldGhpbmcgbW9y
ZSBnZW5lcmljIHRoYW4gYmVpbmcgc3R1Y2sgdG8NCj4+IFBNRF9TSVpFID8NCj4+DQo+PiBPbiBw
b3dlcnBjIDh4eCwgUE1EX1NJWkUgaXMgNE1CIGFuZCBodWdlcGFnZXMgYXJlIDUxMmtCIGFuZCA4
TUIuDQo+IA0KPiBDdXJyZW50bHksIF9fdm1hbGxvY19ub2RlX3JhbmdlKCkgdHJpZXMgdG8gYWxs
b2NhdGUgaHVnZSBwYWdlcyB3aGVuDQo+IHNpemVfcGVyX25vZGUgPj0gUE1EX1NJWkUNCg0KQWgg
cmlnaHQsIHRoYXQgcmVtaW5kcyBtZSB0aGF0IGZvciBwb3dlcnBjIDh4eCwgOE1CIHZtYWxsb2Mg
bWFwcGluZyBpcyANCm5vdCBpbXBsZW1lbnRlZCB5ZXQgYW5kIGFyY2hfdm1hcF9wbWRfc3VwcG9y
dGVkKCkgcmV0dXJucyBmYWxzZS4gDQpIb3dldmVyLCA1MTJrQiBtYXBwaW5nIGlzIGltcGxlbWVu
dGVkLCB0aHJvdWdoIA0KYXJjaF92bWFwX3B0ZV9zdXBwb3J0ZWRfc2hpZnQoKS4NCg0KSW4gX192
bWFsbG9jX25vZGVfcmFuZ2UoKSB0aGF0J3MgdGhlIHBhcnQgYmVsb3c6DQoNCglpZiAoYXJjaF92
bWFwX3BtZF9zdXBwb3J0ZWQocHJvdCkgJiYgc2l6ZV9wZXJfbm9kZSA+PSBQTURfU0laRSkNCgkJ
c2hpZnQgPSBQTURfU0hJRlQ7DQoJZWxzZQ0KCQlzaGlmdCA9IGFyY2hfdm1hcF9wdGVfc3VwcG9y
dGVkX3NoaWZ0KHNpemVfcGVyX25vZGUpOw0KDQoNCj4gDQo+IEhvdyBkbyB3ZSBoYW5kbGUgdGhp
cyBpbiBwb3dlcnBjIDh4eD8gSSBndWVzcyB3ZSBjYW4gdXNlIHRoZSBzYW1lIGxvZ2ljDQo+IGhl
cmU/DQoNCmFyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9ub2hhc2gvMzIvbW11LTh4eC5oIGhhcyA6
DQoNCnN0YXRpYyBpbmxpbmUgaW50IGFyY2hfdm1hcF9wdGVfc3VwcG9ydGVkX3NoaWZ0KHVuc2ln
bmVkIGxvbmcgc2l6ZSkNCnsNCglpZiAoc2l6ZSA+PSBTWl81MTJLKQ0KCQlyZXR1cm4gMTk7DQoJ
ZWxzZSBpZiAoc2l6ZSA+PSBTWl8xNkspDQoJCXJldHVybiAxNDsNCgllbHNlDQoJCXJldHVybiBQ
QUdFX1NISUZUOw0KfQ0KDQoNCkNocmlzdG9waGU=
