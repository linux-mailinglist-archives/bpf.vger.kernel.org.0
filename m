Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9973FDEEE
	for <lists+bpf@lfdr.de>; Wed,  1 Sep 2021 17:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244351AbhIAPqP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Sep 2021 11:46:15 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:50321 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343744AbhIAPqP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Sep 2021 11:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630511118; x=1662047118;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zmQXZRtS5bKn0+oftEudOWTbB649O4QFekqQHTBuoVc=;
  b=rcwS69bgn/WGwmgqofOkfaYvI+NsNjSoFL00GNtkTuQeOjsOKgmGKfSe
   u09zQc5SaRoWI97zaotbN4TyA8wTegM3CSuwJCsYQ5CW3dfWwDarM8xyO
   hXJWLcpJ9FElRYkjeUQcKK/E1V2TMAcpijC1R9n0VSUYrpuZH1yoKPKiP
   A6OE0je1r6LYAugPzUISiTev8Xn+8X4HjBo/SMUOTjVufayxegIxsf7Rx
   tI3xkBzVDQw1MP1uTNwcP8Db16WwQwnruPeSN1CRLBl+H059n3/5is6c9
   a4oPijt9d38jn8VFkldB5IzPUGd9+cFlnB8K4AsnESseL15BNMCXtMhNo
   w==;
X-IronPort-AV: E=Sophos;i="5.84,369,1620662400"; 
   d="scan'208";a="282751591"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2021 23:45:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrdc/Tu7uZKEpYiYAeqxWtOcdm7pMGq5hsv8WnBp4zkCAbQzTM8sdSq5uFh2nYR3aNTLpEWiEC71W8VMPzvLGD365tFjHl5rKcCX3VYT4tyckiK7KIkM5kaEJBNYstT4iXrzP6g/NPD03LCEdlfQCBhd3g3DrXzKyUCR8v4VPErfKlvn4oo53tvaAixnLx9Q/Ncxbeq4C6AI63R/yOLe0M9tKlFKDNcEssVmTiS9WTzGt4UFJjpaYNqI7RCW6AuFrbTvnCxNhrBf0958tkQyVQIMOOqOpBYtIuE5D8apSe/YvAQ835DfuJOemVdmZvxG4XcQ6cD+ByjBjJbzDBbVFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=zmQXZRtS5bKn0+oftEudOWTbB649O4QFekqQHTBuoVc=;
 b=ck7Z7O1ySmv+0JW7frD6W415AMz5/5FJcNlLtnZ7MyvixwdNyICgFBPa89hmjFEVIfBdtuA0C6iG4h0mUMXiTgMGZFiWO/3AWnaPBrZLnHpzpDs3AmRN2hviAL5vT1LFa197rvF8chIO8l9rX384kAci6udd2lOTxnO5nJ+6T7dx9Kt23IfixGZwzZyOMgtAsMXdIn4ALZiVxJv6CrvjMFOLR01y7E085Ar9mHbhSIN/5Gc8GhUuzFXFChv9iJKDu4DX+uJ3AriM8uUWX6H4g75tu3SSucvl0MXJA5++k+ZzNVs7xR8BLP/I19rxlnQdJfCpZx54YQ7HKj/EXz8bCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmQXZRtS5bKn0+oftEudOWTbB649O4QFekqQHTBuoVc=;
 b=PDoOkBfewTWUYjuY+fHEntPGajuY0Ja4eJ2nJxxZopCkh3QXIjJi4HnTKmGMqdd102paD/O8jdTCL5VsbhTdK+w6eDP4Gzmo9xbH3pmdNQByiXNhDSkyOZdfKJtBA0mf+rbcwwNrYov2LPW6Xvkg9+DgtL73YTYjUJ6L9m2tSH4=
Received: from BY5PR04MB6724.namprd04.prod.outlook.com (2603:10b6:a03:219::15)
 by BYAPR04MB5512.namprd04.prod.outlook.com (2603:10b6:a03:e2::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Wed, 1 Sep
 2021 15:45:12 +0000
Received: from BY5PR04MB6724.namprd04.prod.outlook.com
 ([fe80::f0c6:540c:9ce8:ed9b]) by BY5PR04MB6724.namprd04.prod.outlook.com
 ([fe80::f0c6:540c:9ce8:ed9b%8]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 15:45:12 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "nikita.shubin@maquefel.me" <nikita.shubin@maquefel.me>
CC:     "mick@ics.forth.gr" <mick@ics.forth.gr>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "vincent.chen@sifive.com" <vincent.chen@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "alankao@andestech.com" <alankao@andestech.com>,
        "nickhu@andestech.com" <nickhu@andestech.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "guoren@linux.alibaba.com" <guoren@linux.alibaba.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: Not compiling with CONFIG_BPF_SYSCALL enabled
Thread-Topic: Not compiling with CONFIG_BPF_SYSCALL enabled
Thread-Index: AQHXnx1G+ZnXmZIbiUmuKtSvy2mA8KuPUngA
Date:   Wed, 1 Sep 2021 15:45:12 +0000
Message-ID: <a2d921c6e8158327a0a018a075fd94694fd7ab7b.camel@wdc.com>
References: <20210528184405.1793783-2-atish.patra@wdc.com>
         <20210901103634.26558-1-nikita.shubin@maquefel.me>
In-Reply-To: <20210901103634.26558-1-nikita.shubin@maquefel.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.1 (3.40.1-1.module_f34+11997+0ba8848e) 
authentication-results: maquefel.me; dkim=none (message not signed)
 header.d=none;maquefel.me; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b3a7952-2df1-4490-b23e-08d96d5f7c81
x-ms-traffictypediagnostic: BYAPR04MB5512:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5512BC61B2A784AFFD36E2B1FACD9@BYAPR04MB5512.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nPAolQ5rjoWUV2s2a5o68M8EH5N6vGIqjQtTK2F/ZOugyGAZtVbqB+GpBQhmvq7rGGxfpkaKkeQE40J3MY+IJLstRliIFzagwsPWf5XjevSLQ0RVEtP1pMPmQik7kqr59oImt1zwiXjJsl1DiYNw2Zk3u1mvWS2f3sYxk+0jTo70PnnwtdO3RqLBMfFS5pXN5YuVINJ5vdalt2GREY63m0auByHCSErQaDV+k6v3viTGrTCsT44ppKUnnaZz2x130bLbDpc8ez3kVLGYCq/i9E1xL0UgoIwMlmR113BDoC/Lyat/5eXbfgJxsqeJiknG3s623aZETR1agcrcITdGVjAwiLQsCoA20qELiT+BAiHzz5gydLBWGBWTPpWWvadg4+qlq8RQw/yCn04aU1SORWvhsrmVUVW872+taeejyiGLdTJdjWw76OW4Vj/+RlipXVxEmVRuwJjtRHMb1QccN9w0+uJYB2ubc02lGT5oUZdbcdMNrRs/tessfa5SfXc7hRW1/8jV+zdbqAUVBXH1VyHeLWNwYeKAnNbnmo01fcOyFQik9NMzifPkWFBTYs2ucbFveVAhe3CmSs0YaA15JOxNgihtxk/Wj10+t9AF6JN51jayGej8/yi/ItygGKhsZgZ+Ugsv812uwfwXDjrfesNF1ea7nAqlIl+7wCRC3xwrk4X9s68UgbjWvK/kYH6n2fTPmIriJkkxFmbbfJItaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6724.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(36756003)(2906002)(8936002)(8676002)(186003)(66946007)(66476007)(66556008)(64756008)(66446008)(38100700002)(6486002)(71200400001)(6916009)(38070700005)(4326008)(7416002)(4744005)(316002)(2616005)(54906003)(6512007)(5660300002)(6506007)(478600001)(26005)(122000001)(86362001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkJQdHNwbW5odGV4WG9WUzR1c1lwaU9qQVpOQjBTUjZQMnZGdnc1aGJPMTJU?=
 =?utf-8?B?bitjVnR2T0NpamFLeXRKc3pPbDdMOGZlNVJtbmtJejc4NVJLNWVNekhGTFcw?=
 =?utf-8?B?Qk1TZkh5N2tjdmp4Q2RHMk1lblk0NFhiMlV1dUJSaHZFYWJYMFhqUUNVRGxp?=
 =?utf-8?B?VUV6Z0RaV0g5VXJIVjhORXE2Y0xOZE5hZmk2U1RXOVJxdmtuY05WRStXZi9o?=
 =?utf-8?B?VGFYazR0dzdhNnVlZXFqditIKzBMRURhNHo0aHl1MHd3RmlSc2RBb1hFVVYr?=
 =?utf-8?B?VE5XVG5wYTNFbDdsOVovNFRKR1BMcWZnNVVyRGtlQ0JZMCtGdVVPUGJiNlUv?=
 =?utf-8?B?YkFHYU5ZYjhUc0lkTXBTd1c2NnBIQnpVS3lNb2ZEdDF3SUhrUUJHZXdRT05y?=
 =?utf-8?B?S2JwTi85NnMwemFuSERINmR5RHNDN3B3aDl4UmQ1bE1GWGdyaGZiTGNpelVZ?=
 =?utf-8?B?enM2U1JrUlQ4eElyK2RJcEZ2NmFCYlU1cHE2ZVprSVBMTHJ4WmdLdXUvdXEr?=
 =?utf-8?B?ZGtsbngzU3NRWmpFMzF3QXZKWTN6UC9TcXlucjkxUHJWRWZnd085S0tZT3Iz?=
 =?utf-8?B?dU9oSDZsSm5NcDRTWDVHQUZxSGQ4cWZyQTRmcEg1NG5HOHVjbzFEQ3dzVll1?=
 =?utf-8?B?QVdLMnE5OFFRUUVFcnU2czJZdjNTZklkZUVHeWRGZUNHTUs5SktKT0hmOFpr?=
 =?utf-8?B?Yis5RVc1RWY0MHRTc2pEMEh2YThkM1NQQWEraG1KaWJJK1JnajJneERHM2l4?=
 =?utf-8?B?UHNVRGpWTEZuQUtTSVZidDlia2JTM2xXelllM0NzUmgydTltMEFwQWhnK2pU?=
 =?utf-8?B?N0ZDS1c5ZHpRck51U0FJMUIydGZVSTgxSnhSVlhkOC9VRFlEelEzRTRVdTEr?=
 =?utf-8?B?cUlGTDBEOEl1eWQvYUpZem93VWNGd2tiZ2ZidWdIS2RYbWYyNGJtNnNJc3Ur?=
 =?utf-8?B?cjZwb200RGlDV0o0c0luTmNUdlRGa242Qy9BL2J6UnByK0VhVjJVL1VaVXRT?=
 =?utf-8?B?dXdsaURQbkFRdEl1M3hwYVc1ZDdscnRCMVl3SFNQcTYvRXM4S1AvSzNEU3Vr?=
 =?utf-8?B?SFdESEdSMDB6TUFEaUFBYjBtR2VJMURudDJYV2NMblVHKytYWC9rVVJMRVJW?=
 =?utf-8?B?U0xCWnBmRGxqbVlYOTIrMGZUK0I4WXgwUVJiRDBBWVlLbnRmQzRCNm50Q3lP?=
 =?utf-8?B?cjQzSmlyU1pUaSt5UWprckMwZ2xKcWpURUlwakpzT05JcnVocmw2VEthRy9o?=
 =?utf-8?B?N1ZRdEQyeDUycG9mRjFrQmZJbHdnTUpWTGc0MEMyYS92SWlFT21hR1lYYlhl?=
 =?utf-8?B?S1NzRlJRRHBQanNtdjRmMW5VRHQxL3NLZlE2elNEWkVlanp5UHhpMndabWpL?=
 =?utf-8?B?MlY2cStxa2YvNWZTSVh3Sm1nRlBjZmpCWkpJTGd6aWM4VGd1WXBrTkF4ajVC?=
 =?utf-8?B?MmZQeG4wMEJHTXh2L0x4cWlzOXdWOE5jakZJTnNIWmIrWnZjV0lJNlBsQnZE?=
 =?utf-8?B?Ykc3bStGWTBSbDZaRWVoQTA2NFk4T3U2RCtodjZ0T1FhbmU1U2NkZ2lQNVhO?=
 =?utf-8?B?Smg2aE5VM0xRSUt1d0JhczNpSmYyUzd3VE9VKzdOK3dJaTlnVnJiMXF1UzNp?=
 =?utf-8?B?QVZiL2xPblVCbHFMZXhwYmtIaStQelZOV1Zzb0F3Q1ZueXB5T2lWZmN1dmFp?=
 =?utf-8?B?M0RvTzVxcGwrWnUrcUFzK2pNbEhYYWQvRkIzZkIrN2gweDBMOVdzZzFYNkF0?=
 =?utf-8?B?R2xFL2t6bk1jb0N2NWhBbk9hSzkrSHFiRG9id2VoYkM3Z1YxZTdVeUpLOWdR?=
 =?utf-8?B?K1hmMVBkdlhSbDAzNFlSZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C46E25CF883F94F9A6D081D3B60BF91@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6724.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3a7952-2df1-4490-b23e-08d96d5f7c81
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2021 15:45:12.6178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GICurV+T+AeQXcVcxa3/ueJAOYhggKeESAzcIIuMFWJOOb1lFq5fvbQU0c8sSewgJMhwSR90qSnlm7WzXeLSHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5512
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gV2VkLCAyMDIxLTA5LTAxIGF0IDEzOjM2ICswMzAwLCBOaWtpdGEgU2h1YmluIHdyb3RlOg0K
PiBIZWxsbywgQXRpc2guDQo+IA0KPiBUaGUgYWJvdmUgc2VyaWVzIHdvbid0IGNvbXBpbGUgd2l0
aCBDT05GSUdfQlBGX1NZU0NBTEwgc2V0Og0KPiANCj4gbGludXgva2VybmVsL2V2ZW50cy9jb3Jl
LmM6OTkxMjoxODogZXJyb3I6IGFzc2lnbm1lbnQgdG8gDQo+ICdicGZfdXNlcl9wdF9yZWdzX3Qg
Kicge2FrYSAnc3RydWN0IHVzZXJfcmVnc19zdHJ1Y3QgKid9IA0KPiBmcm9tIGluY29tcGF0aWJs
ZSBwb2ludGVyIHR5cGUgJ3N0cnVjdCBwdF9yZWdzIConIA0KPiBbLVdlcnJvcj1pbmNvbXBhdGli
bGUtcG9pbnRlci10eXBlc10NCj4gwqA5OTEyIHzCoMKgwqDCoMKgwqDCoMKgIGN0eC5yZWdzID0g
cGVyZl9hcmNoX2JwZl91c2VyX3B0X3JlZ3MocmVncyk7DQo+IA0KPiBKdXN0IGluZm9ybWluZyB5
b3UgLSBob3BlIHRoaXMgaXMgaGVscGZ1bC4NCg0KVGhhbmtzIGZvciByZXBvcnRpbmcgdGhpcy4g
SSBhbSBzcGlubmluZyB0aGUgdjMgb2YgdGhpcyBzZXJpZXMuIEkgd2lsbA0KdGFrZSBsb29rLg0K
DQo+IA0KPiBZb3VycywNCj4gTmlraXRhIFNodWJpbg0KPiANCg0KLS0gDQpSZWdhcmRzLA0KQXRp
c2gNCg==
