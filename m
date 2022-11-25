Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121036383B2
	for <lists+bpf@lfdr.de>; Fri, 25 Nov 2022 06:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiKYF7H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Nov 2022 00:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKYF7H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Nov 2022 00:59:07 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120050.outbound.protection.outlook.com [40.107.12.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EB6233B3;
        Thu, 24 Nov 2022 21:59:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PggmluYsOTHug4N4zu3JpbFwL1Qw5BhWyrwxYFfioo7B/Xb9sCq4MaJp9roMfSM4QOUOB2y86c1STYrQ98kxHIAOIZUrt5WBdzyBjd10OIbUBFuTyyUPQQ34/GnuWVC9MVlCUvRIH8QzPUp4nj10SyQQkbpOpca6aJjIKxeKDooT2dJrcSNV0BsOFvGohOgra59gX8KCXy+vPLXgSrEypL0shdaePT6kdIOh/0Zz5dZdzdU285PxzhJsZa1OQAjjbXPWJm43eDTzQb++Pv87EIxRf7CueA0gYwiOwZm9akCZXmwZ3hMPMwpp022nHggH1y4/wN2spHkCeYz2bGISOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2rXStqRo5Mjs+g9Xfo/35lCjR5LX8W82k/gmHWXfBM=;
 b=PswgdQ/YubXteTV62fHvw0JDsKYmgkN9yu0DO0hxpHScjPVIXYqIVFNJ6ESeHoBl4cZX/bkqDzVgOmB2pqLiRJ4gOry0M3NAbHYFEsElNsUvbx41C1vXcjHbhbxPdZXjSsBTOVjXavZ6evHuoTPesaAmfy4KLdsw1IC95P+epXYen01o/ghRO1YsXruR9VWUYJVcJVY+97eqG5haM82JKGrVEufTuOLtkLQuKzBFd+/Si600ldz67BlJGS2IcS0i6mS7s9iLvVYHs5k1WMClXSCrMTk5w9eswldyN2F0Qs7hEPXxMN+IijEoV9eiZV+DqvlTqSk/QVDuLO8Q6DPiMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2rXStqRo5Mjs+g9Xfo/35lCjR5LX8W82k/gmHWXfBM=;
 b=3Ojyy5FxhqLR9T95uK8eoMSceK/KPPZsiBfdKX79gjyLddILA4j7uurqr3PzhcOyHNEzeoQVzOBbVc98PzQn6Gd7NflmZxRIqBZivN5lzTqBDHfWwyN2LhhjvIl2dgm+zt7d80EJR8mgQwBBsSL6srA35r8TuPxAg73u1z9jow9xE7djHtsG5nRmqDTWgqWsg9RWRBvfagT7013QqY8hsy5sHUQ0brd5HEALwnenBiScns1YlKTc4xc6//oSdRtRUnDmI1uu5Xt2V7WoI1z6HDBOFkEC74Q4y+d9PWojWrKx+erGH0HI9G/lAtvIrov2TzubuH8U6/bzEEUoX8WF2g==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAZP264MB2397.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Fri, 25 Nov
 2022 05:59:02 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a85b:a9b6:cb36:fa6]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a85b:a9b6:cb36:fa6%9]) with mapi id 15.20.5857.020; Fri, 25 Nov 2022
 05:59:02 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
CC:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Stanislav Fomichev <sdf@google.com>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH] powerpc/bpf: Only update ldimm64 during extra pass when
 it is an address
Thread-Topic: [PATCH] powerpc/bpf: Only update ldimm64 during extra pass when
 it is an address
Thread-Index: AQHY/+BWf7gs5QKIpkuwfOKyhRUrWq5N2yQAgAAkjgCAABeygIAAY6WAgAClm4CAAAWjgA==
Date:   Fri, 25 Nov 2022 05:59:02 +0000
Message-ID: <4dd462c8-7f0f-58c8-0f3f-757442134c90@csgroup.eu>
References: <3f6d302a2068d9e357efda2d92c8da99a0f2d0b2.1669278892.git.christophe.leroy@csgroup.eu>
 <1669284441.66eunvaboi.naveen@linux.ibm.com>
 <9f17237f-94da-f58f-4f4b-0068851b4123@csgroup.eu>
 <1669297066.kxu8xl391n.naveen@linux.ibm.com>
 <ba982820-0a22-1180-7b3c-b32acae6e9f7@csgroup.eu>
 <1669354227.c0iu04jq2o.naveen@linux.ibm.com>
In-Reply-To: <1669354227.c0iu04jq2o.naveen@linux.ibm.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PAZP264MB2397:EE_
x-ms-office365-filtering-correlation-id: 98e58c1c-5309-41b6-4595-08daceaa2736
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yJRYJcw03mKy8BOEPZqGzDpfAquQLGez4m5aX90x7ve7Qjt3dKBnusz9Y+EqrOQHwoRIu1LP+b6NNu0fKGf4WncTKXjmgmE/4BA3eQkl5rvQTLZhdr16QkwPu2033Gmn8h8m9VWejoBfUM3gi0+x9CsnMmz6ZoQN7j1G1AKTnuYN8ormd73e2xVzlMqN1HXVsSbOHt7UqzWfzGr7VY4mot5i5bLQX+sutFC6zNicSvGBryxcYJAFC2XjbZoy+CMxZ8ercCOvklPi6vI2TnMoN6XStMIMYFINIqCbdiG1WgPWXSLFatOv9C72l9CrQz4Pnp4Olw3CTGxS0cQytx737AUTWQLOdtxkLbvIhwddNXC7iuvOD96VCi++H+m5cRXfreIZyJJjbNVZwGBtQkjfwI6DQir04An+/lDuhB18QbpoZTSmLouuxdRGeyr90DzyKFbZbkEKxuNd/RlpdMrsg+aW7o42QpqP6ahruN2Yi4VWxAUNGHp89ypE8ICc1QoktNLwNJh5GBVvd/BN3b/BqM5L6s4YJOrANEXTGMr+M4eUBO70SdPEN/3U35FdPk/x/7BJbAn/WwkGHQ1p6SsKybGRUEy614WKFdxomQj1jDO4H1/LxUGvWQg6QF20/SlEnkG1fJjF5P4SIa/D3bN6tVs6CwrXYmbKilX5/TwofOUgIksgDtjGSY/Hz0ee56hgzo27r4MQLCJiIO29JbRqAktbW6p+0KPYAsi8pzptPz4YOkoINfVoNgvnbqyzBiFl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(451199015)(38100700002)(83380400001)(66574015)(31686004)(31696002)(86362001)(54906003)(110136005)(6506007)(71200400001)(6486002)(36756003)(38070700005)(26005)(122000001)(2616005)(186003)(6512007)(44832011)(5660300002)(7416002)(478600001)(15650500001)(91956017)(66556008)(8676002)(66476007)(64756008)(76116006)(66946007)(66446008)(41300700001)(4326008)(8936002)(316002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWh1SzJtZzBrQjRrektYOUE5RHdvb2Q3dXN4bUJITlQ5QlVSVHIvT0hMNCtV?=
 =?utf-8?B?aDNEWGFNSW1Eb2I0THRWdXdCN3BTL1dGVGFJKzBzeHpHWmhEdFdQU1laVzFt?=
 =?utf-8?B?blZ6dTVncFo2MW1TcmxML2dGR1o4WDgwc1RrSThzMHpWVUNBaDhxUG5DRy9w?=
 =?utf-8?B?U3F6Mm5GeitSb2JlZlN2MzdYU1A4YTFhVm1rU3NvK3g4RFlLWi9paExUeUxr?=
 =?utf-8?B?TTU2N0lraGNJaGw2SzE3NDRjM0pBKzZVTlZGRDcrYytYSlhwSnFxZk1oTkw4?=
 =?utf-8?B?SmRmSUNEM0tIc2R2MEtqbm1sOEtnUWN3Q29zQmtkZEpjL01SNXVQNEVyUFlp?=
 =?utf-8?B?cy9PV25ZdzJ0d0FXbVM5ZE9sekRXdFpmcFdHc1N1OERrV1N2a1phT0JDaHhK?=
 =?utf-8?B?U2FPMElsNDhaMkZkRkVmMVUvNHFHcWZFNXJlbi9GL0d0WTBvVEpkL3ZMNVNy?=
 =?utf-8?B?ZUhVTFI3WEhqMS9MOW9uTkM0TFUxcFEwVXBabzF1ci9qQUU3dURnaHJ3R1lv?=
 =?utf-8?B?NjNBQ1c4S0pZcjM3SVNKazVYbWZDbGhpaG0zNm1ubTB6T2plZis3U29KMlFJ?=
 =?utf-8?B?blNnakxZTEtYemFKWWxlSUZPVEx6MlhqN0c3Q0c3VjZxYXNtTU41MzdhR1Bt?=
 =?utf-8?B?Z1hXWFQ5UzJyeVFZZWhpRnl4d1BMS1ZhVWErVlpkRmhrTTFNbkFhUXN5bVI0?=
 =?utf-8?B?aTM0UVRlb1QxeThhaXMrc21PV05scEE1Z1RLaFhHTG1jR2s1VWVYTVIrL3dv?=
 =?utf-8?B?ZmNjRUdSdlBMRXRQTkVobHg2aTZmbjRZcm51cXhWVDZpTFp2bnhscXNmNlVw?=
 =?utf-8?B?WEE2ajlYSHJhdGFHRUp0R1V4b2E3MUlHeW5PKyt0R3FOM0dMR1FaaGN3UEUw?=
 =?utf-8?B?VXY0SHJ2M3Y4ZFFHTzhsbXY4SGw1N3hEK1l4d2xNb3BRaWM4Um1VOE1vdWU4?=
 =?utf-8?B?SzFQVFdxakIvTWgrWlVPc0VoMTFyNVpueFBORDBBdDBNcXlTWWZsQmIrUGZQ?=
 =?utf-8?B?UDR4STJueGpRQTRIcGt2UzA5eTRTUExaakR1dHM3YjBTSlNWUkxUeTRmbnkx?=
 =?utf-8?B?TjdDZ0loVnM0VUtFOXQyaG1yNXozaC9ocXdhbmNFTlo2NjZ3YlZ0RDRlUmln?=
 =?utf-8?B?eHZTdzB1cXZVWjNZaWtSNnFqSnE4M005U3IycXJWRmg2NThseFpzTVhScnhL?=
 =?utf-8?B?cGlGQmU3VUZZdE9icUw5TFVkZlF4N0Z1N3grL25RTm5uOGxuYTRaamxQSjNG?=
 =?utf-8?B?KzBNbGVUdWtPSTRTZUlnc2M1UjMwMGhJK29na0I4QzQxdXQvM29QdE1hUmJx?=
 =?utf-8?B?cFFLU2dnNGRBRzZndlh4ZlhZQ1BiQklPWXYxY3FLZzNNQ2N0VHpMTkExaUJ5?=
 =?utf-8?B?V3JWN1NJUnJBU3phTDF4ZEhaR2hBSDBMS2Q0akNMMXFKSVBZYWNZUEhsYjdB?=
 =?utf-8?B?cnQ4Qy81cWQxKzBvVjVhaW82RXJ6YkFTNHVDalIza1dSVHQzQTh5T1I3akFa?=
 =?utf-8?B?ZEc1WVlBOUN6a2xkTmNOb0pXUHBROVphTTZEblBIQlR0VWJIencrTDhaQWNl?=
 =?utf-8?B?ZFNRNllSdVZmS25wem53bVJtcmdtNkdLTk1ja0dHdjV3MjdOWlZhSzVvNk1G?=
 =?utf-8?B?RG9ndUFmUjBZWGkwa2Z3VFB1VEVFWmU3R0FJTDI3QllVdUhrYWdZSHBCTWdD?=
 =?utf-8?B?TUtHQ3dBbW9BYjFmVlpmdEVhck1sd1BlQ2IrZHNVQ0NUdSs5RElINmZXM1FB?=
 =?utf-8?B?b3JIV24yWlNGdXhxL21rL1A4dk9DdVowaUhmekFTRGZ3d1BNK24raFdBM2Fa?=
 =?utf-8?B?dFd3NGZjZWJBdjdKUm9yVmwrcWtnb0dPSjhkMDlNZythWWRxRUIrcWRtVEpR?=
 =?utf-8?B?ZFZ5anlZSm8xVWI0OS8xL0paQ0JtSkZhYS9QcTV4Y0Y0QlA2Rk5BU01hVGgz?=
 =?utf-8?B?SGpkY054Z013RkRYWUNoRTRnOE9Mc3k1RnZjVXBYcVRQZGM3QkdRU0RGQTZ6?=
 =?utf-8?B?WjY4ZnlmbmordlA2MGgyNmpPVGxwa1lDTng2amNLT054bXhPNXA4M1VIT0h3?=
 =?utf-8?B?cVZFK1VZZlZac3pqelRzNUFYdXVxL1p2Y3dsRnp3VlNXNkVTL0xjTTFpUk1K?=
 =?utf-8?Q?QNx20SgwnU0GOI/wk+CB7ZZTN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <708F16E5F1595940A5ED15F41080868E@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e58c1c-5309-41b6-4595-08daceaa2736
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2022 05:59:02.3664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JDR//BMwIn8gIHNKkkvfOMtNWGnAEDTgqvzlWRFeeieq8Ui1xQRQlHqZ8ROUsEo0KblC88pp4u8hH1jbLfaNPf/AbINU5yuxwo5wFklDy3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2397
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCkxlIDI1LzExLzIwMjIgw6AgMDY6MzgsIE5hdmVlbiBOLiBSYW8gYSDDqWNyaXTCoDoNCj4g
Q2hyaXN0b3BoZSBMZXJveSB3cm90ZToNCj4+DQo+Pg0KPj4gTGUgMjQvMTEvMjAyMiDDoCAxNDo0
OSwgTmF2ZWVuIE4uIFJhbyBhIMOpY3JpdMKgOg0KPj4+IENocmlzdG9waGUgTGVyb3kgd3JvdGU6
DQo+Pj4+DQo+Pj4+DQo+Pj4+IExlIDI0LzExLzIwMjIgw6AgMTE6MTMsIE5hdmVlbiBOLiBSYW8g
YSDDqWNyaXTCoDoNCj4+Pj4+IENocmlzdG9waGUgTGVyb3kgd3JvdGU6DQo+Pj4+DQo+Pj4+IElu
IHdoYXQgZGlyZWN0aW9uIGNvdWxkIHRoYXQgY2hhbmdlIGluIHRoZSBmdXR1cmUgPw0KPj4+Pg0K
Pj4+PiBGb3IgbWUgaWYgdGhleSBjaGFuZ2UgdGhhdCBpdCBiZWNvbWVzIGFuIEFQSSBjaGFuZ2Uu
DQo+Pj4NCj4+PiBNb3JlIG9mIGFuIGV4dGVuc2lvbiwgd2hpY2ggaXMgZXhhY3RseSB3aGF0IHdl
IGhhZCB3aGVuIA0KPj4+IEJQRl9QU0VVRE9fRlVOQyB3YXMgaW50cm9kdWNlZC4gVG9vayB1cyBu
ZWFybHkgYSB5ZWFyIGJlZm9yZSB3ZSBub3RpY2VkLg0KPj4+DQo+Pj4gQmVjYXVzZSB3ZSBkbyBu
b3QgZG8gYSBmdWxsIEpJVCBkdXJpbmcgdGhlIGV4dHJhIHBhc3MgdG9kYXkgbGlrZSANCj4+PiBv
dGhlciBhcmNoaXRlY3R1cmVzLCB3ZSBhcmUgdGhlIGV4Y2VwdGlvbiAtIHRoZXJlIGlzIGFsd2F5
cyB0aGUgcmlzayANCj4+PiBvZiBicGYgY29yZSBjaGFuZ2VzIGJyZWFraW5nIG91ciBKSVQuIFNv
LCBJIHN0aWxsIHRoaW5rIGl0IGlzIGJldHRlciANCj4+PiBpZiB3ZSBkbyBhIGZ1bGwgSklUIGR1
cmluZyBleHRyYSBwYXNzLg0KPj4+DQo+Pg0KPj4gSSBsaWtlIHRoZSBpZGVhIG9mIGEgZnVsbCBK
SVQgZHVyaW5nIGV4dHJhIHBhc3NlcyBhbmQgd2lsbCBzdGFydCANCj4+IGxvb2tpbmcgYXQgaXQu
DQo+Pg0KPj4gV2lsbCBpdCBhbHNvIGFsbG93IHVzIHRvIHJldmVydCB5b3VyIGNvbW1pdCBmYWIw
NzYxMWZiMmUgDQo+PiAoInBvd2VycGMzMi9icGY6IEZpeCBjb2RlZ2VuIGZvciBicGYtdG8tYnBm
IGNhbGxzIikgPw0KPiANCj4gTm90IGVudGlyZWx5LiBXZSBzdGlsbCBuZWVkIHRob3NlIGV4dHJh
IG5vcHMgZHVyaW5nIHRoZSBpbml0aWFsIEpJVCBzbyANCj4gdGhhdCB3ZSBjYW4gZXN0aW1hdGUg
dGhlIG1heGltdW0gcHJvZyBzaXplLiBEdXJpbmcgZXh0cmEgcGFzcywgd2UgY2FuIA0KPiBvbmx5
IGVtaXQgdGhlIG5lY2Vzc2FyeSBpbnN0cnVjdGlvbnMgYW5kIHNraXAgZXh0cmEgbm9wcy4gV2Ug
bWF5IG5lZWQgdG8gDQo+IGRvIHR3byBwYXNzZXMgZHVyaW5nIGV4dHJhX3Bhc3MgdG8gYWRqdXN0
IHRoZSBicmFuY2ggdGFyZ2V0cyB0aG91Z2guDQo+IA0KDQpCZWZvcmUgeW91ciBjaGFuZ2UsIHRo
ZSBjb2RlIHdhczoNCg0KCWlmIChpbWFnZSAmJiByZWwgPCAweDIwMDAwMDAgJiYgcmVsID49IC0w
eDIwMDAwMDApIHsNCgkJUFBDX0JMKGZ1bmMpOw0KCX0gZWxzZSB7DQoJCS8qIExvYWQgZnVuY3Rp
b24gYWRkcmVzcyBpbnRvIHIwICovDQoJCUVNSVQoUFBDX1JBV19MSVMoX1IwLCBJTU1fSChmdW5j
KSkpOw0KCQlFTUlUKFBQQ19SQVdfT1JJKF9SMCwgX1IwLCBJTU1fTChmdW5jKSkpOw0KCQlFTUlU
KFBQQ19SQVdfTVRDVFIoX1IwKSk7DQoJCUVNSVQoUFBDX1JBV19CQ1RSTCgpKTsNCgl9DQoNCkR1
cmluZyB0aGUgaW5pdGlhbCBwYXNzLCBpbWFnZSBpcyBOVUxMIHNvIHRoZSBlbHNlIGJyYW5jaCBp
cyB0YWtlbi4NCg0KQ2hyaXN0b3BoZQ0K
